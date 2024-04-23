module Gio.Resource;

import GLib.Boxed;
import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import Gid.Gid;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Applications and libraries often contain binary or textual data that is
 * really part of the application, rather than user data. For instance
 * #GtkBuilder .ui files, splashscreen images, GMenu markup XML, CSS files,
 * icons, etc. These are often shipped as files in `$datadir/appname`, or
 * manually included as literal strings in the code.
 *
 * The #GResource API and the [glib-compile-resources][glib-compile-resources] program
 * provide a convenient and efficient alternative to this which has some nice properties. You
 * maintain the files as normal files, so its easy to edit them, but during the build the files
 * are combined into a binary bundle that is linked into the executable. This means that loading
 * the resource files are efficient (as they are already in memory, shared with other instances) and
 * simple (no need to check for things like I/O errors or locate the files in the filesystem). It
 * also makes it easier to create relocatable applications.
 *
 * Resource files can also be marked as compressed. Such files will be included in the resource bundle
 * in a compressed form, but will be automatically uncompressed when the resource is used. This
 * is very useful e.g. for larger text files that are parsed once (or rarely) and then thrown away.
 *
 * Resource files can also be marked to be preprocessed, by setting the value of the
 * `preprocess` attribute to a comma-separated list of preprocessing options.
 * The only options currently supported are:
 *
 * `xml-stripblanks` which will use the xmllint command
 * to strip ignorable whitespace from the XML file. For this to work,
 * the `XMLLINT` environment variable must be set to the full path to
 * the xmllint executable, or xmllint must be in the `PATH`; otherwise
 * the preprocessing step is skipped.
 *
 * `to-pixdata` (deprecated since gdk-pixbuf 2.32) which will use the
 * `gdk-pixbuf-pixdata` command to convert images to the #GdkPixdata format,
 * which allows you to create pixbufs directly using the data inside the
 * resource file, rather than an (uncompressed) copy of it. For this, the
 * `gdk-pixbuf-pixdata` program must be in the `PATH`, or the
 * `GDK_PIXBUF_PIXDATA` environment variable must be set to the full path to the
 * `gdk-pixbuf-pixdata` executable; otherwise the resource compiler will abort.
 * `to-pixdata` has been deprecated since gdk-pixbuf 2.32, as #GResource
 * supports embedding modern image formats just as well. Instead of using it,
 * embed a PNG or SVG file in your #GResource.
 *
 * `json-stripblanks` which will use the `json-glib-format` command to strip
 * ignorable whitespace from the JSON file. For this to work, the
 * `JSON_GLIB_FORMAT` environment variable must be set to the full path to the
 * `json-glib-format` executable, or it must be in the `PATH`;
 * otherwise the preprocessing step is skipped. In addition, at least version
 * 1.6 of `json-glib-format` is required.
 *
 * Resource files will be exported in the GResource namespace using the
 * combination of the given `prefix` and the filename from the `file` element.
 * The `alias` attribute can be used to alter the filename to expose them at a
 * different location in the resource namespace. Typically, this is used to
 * include files from a different source directory without exposing the source
 * directory in the resource namespace, as in the example below.
 *
 * Resource bundles are created by the [glib-compile-resources][glib-compile-resources] program
 * which takes an XML file that describes the bundle, and a set of files that the XML references. These
 * are combined into a binary resource bundle.
 *
 * An example resource description:
 * |[
 * <?xml version="1.0" encoding="UTF-8"?>
 * <gresources>
 * <gresource prefix="/org/gtk/Example">
 * <file>data/splashscreen.png</file>
 * <file compressed="true">dialog.ui</file>
 * <file preprocess="xml-stripblanks">menumarkup.xml</file>
 * <file alias="example.css">data/example.css</file>
 * </gresource>
 * </gresources>
 * ]|
 *
 * This will create a resource bundle with the following files:
 * |[
 * /org/gtk/Example/data/splashscreen.png
 * /org/gtk/Example/dialog.ui
 * /org/gtk/Example/menumarkup.xml
 * /org/gtk/Example/example.css
 * ]|
 *
 * Note that all resources in the process share the same namespace, so use Java-style
 * path prefixes (like in the above example) to avoid conflicts.
 *
 * You can then use [glib-compile-resources][glib-compile-resources] to compile the XML to a
 * binary bundle that you can load with g_resource_load(). However, its more common to use the --generate-source and
 * --generate-header arguments to create a source file and header to link directly into your application.
 * This will generate `get_resource()`, `register_resource()` and
 * `unregister_resource()` functions, prefixed by the `--c-name` argument passed
 * to [glib-compile-resources][glib-compile-resources]. `get_resource()` returns
 * the generated #GResource object. The register and unregister functions
 * register the resource so its files can be accessed using
 * g_resources_lookup_data().
 *
 * Once a #GResource has been created and registered all the data in it can be accessed globally in the process by
 * using API calls like g_resources_open_stream() to stream the data or g_resources_lookup_data() to get a direct pointer
 * to the data. You can also use URIs like "resource:///org/gtk/Example/data/splashscreen.png" with #GFile to access
 * the resource data.
 *
 * Some higher-level APIs, such as #GtkApplication, will automatically load
 * resources from certain well-known paths in the resource namespace as a
 * convenience. See the documentation for those APIs for details.
 *
 * There are two forms of the generated source, the default version uses the compiler support for constructor
 * and destructor functions (where available) to automatically create and register the #GResource on startup
 * or library load time. If you pass `--manual-register`, two functions to register/unregister the resource are created
 * instead. This requires an explicit initialization call in your application/library, but it works on all platforms,
 * even on the minor ones where constructors are not supported. (Constructor support is available for at least Win32, Mac OS and Linux.)
 *
 * Note that resource data can point directly into the data segment of e.g. a library, so if you are unloading libraries
 * during runtime you need to be very careful with keeping around pointers to data from a resource, as this goes away
 * when the library is unloaded. However, in practice this is not generally a problem, since most resource accesses
 * are for your own resources, and resource data is often used once, during parsing, and then released.
 *
 * When debugging a program or testing a change to an installed version, it is often useful to be able to
 * replace resources in the program or library, without recompiling, for debugging or quick hacking and testing
 * purposes. Since GLib 2.50, it is possible to use the `G_RESOURCE_OVERLAYS` environment variable to selectively overlay
 * resources with replacements from the filesystem.  It is a %G_SEARCHPATH_SEPARATOR-separated list of substitutions to perform
 * during resource lookups. It is ignored when running in a setuid process.
 *
 * A substitution has the form
 *
 * |[
 * /org/gtk/libgtk=/home/desrt/gtk-overlay
 * ]|
 *
 * The part before the `=` is the resource subpath for which the overlay applies.  The part after is a
 * filesystem path which contains files and subdirectories as you would like to be loaded as resources with the
 * equivalent names.
 *
 * In the example above, if an application tried to load a resource with the resource path
 * `/org/gtk/libgtk/ui/gtkdialog.ui` then GResource would check the filesystem path
 * `/home/desrt/gtk-overlay/ui/gtkdialog.ui`.  If a file was found there, it would be used instead.  This is an
 * overlay, not an outright replacement, which means that if a file is not found at that path, the built-in
 * version will be used instead.  Whiteouts are not currently supported.
 *
 * Substitutions must start with a slash, and must not contain a trailing slash before the '='.  The path after
 * the slash should ideally be absolute, but this is not strictly required.  It is possible to overlay the
 * location of a single resource with an individual file.
 */
class Resource : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GResource))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_resource_get_type();
  }

  /**
   * a new #GResource, or %NULL on error
   */
  static Resource newFromData(Bytes data)
  {
    GResource* _cretval;
    GError *_err;
    _cretval = g_resource_new_from_data(data ? data.cPtr!GBytes : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Resource _retval = new Resource(cast(GResource*)_cretval, true);
    return _retval;
  }

  /**
   * an array of constant strings
   */
  string[] enumerateChildren(string path, ResourceLookupFlags lookupFlags)
  {
    char** _cretval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _cretval = g_resource_enumerate_children(cPtr!GResource, _path, lookupFlags, &_err);
    if (_err)
      throw new ErrorG(_err);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * %TRUE if the file was found. %FALSE if there were errors
   */
  bool getInfo(string path, ResourceLookupFlags lookupFlags, out size_t size, out uint flags)
  {
    bool _retval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _retval = g_resource_get_info(cPtr!GResource, _path, lookupFlags, cast(size_t*)&size, cast(uint*)&flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * #GBytes or %NULL on error.
   * Free the returned object with g_bytes_unref()
   */
  Bytes lookupData(string path, ResourceLookupFlags lookupFlags)
  {
    GBytes* _cretval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _cretval = g_resource_lookup_data(cPtr!GResource, _path, lookupFlags, &_err);
    if (_err)
      throw new ErrorG(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * #GInputStream or %NULL on error.
   * Free the returned object with g_object_unref()
   */
  InputStream openStream(string path, ResourceLookupFlags lookupFlags)
  {
    GInputStream* _cretval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _cretval = g_resource_open_stream(cPtr!GResource, _path, lookupFlags, &_err);
    if (_err)
      throw new ErrorG(_err);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GResource, or %NULL on error
   */
  static Resource load(string filename)
  {
    GResource* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = g_resource_load(_filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    Resource _retval = new Resource(cast(GResource*)_cretval, true);
    return _retval;
  }
}
