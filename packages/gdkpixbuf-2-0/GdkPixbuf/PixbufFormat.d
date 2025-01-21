module GdkPixbuf.PixbufFormat;

import GLib.Boxed;
import GdkPixbuf.PixbufModulePattern;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * A `GdkPixbufFormat` contains information about the image format accepted
 * by a module.
 * Only modules should access the fields directly, applications should
 * use the `gdk_pixbuf_format_*` family of functions.
 */
class PixbufFormat : Boxed
{

  this()
  {
    super(safeMalloc(GdkPixbufFormat.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_pixbuf_format_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property string name()
  {
    return (cast(GdkPixbufFormat*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufFormat*)cPtr).name);
    (cast(GdkPixbufFormat*)cPtr).name = propval.toCString(true);
  }

  @property PixbufModulePattern signature()
  {
    return new PixbufModulePattern(cast(GdkPixbufModulePattern*)(cast(GdkPixbufFormat*)cPtr).signature);
  }

  @property string domain()
  {
    return (cast(GdkPixbufFormat*)cPtr).domain.fromCString(false);
  }

  @property void domain(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufFormat*)cPtr).domain);
    (cast(GdkPixbufFormat*)cPtr).domain = propval.toCString(true);
  }

  @property string description()
  {
    return (cast(GdkPixbufFormat*)cPtr).description.fromCString(false);
  }

  @property void description(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufFormat*)cPtr).description);
    (cast(GdkPixbufFormat*)cPtr).description = propval.toCString(true);
  }

  @property uint flags()
  {
    return (cast(GdkPixbufFormat*)cPtr).flags;
  }

  @property void flags(uint propval)
  {
    (cast(GdkPixbufFormat*)cPtr).flags = propval;
  }

  @property bool disabled()
  {
    return (cast(GdkPixbufFormat*)cPtr).disabled;
  }

  @property void disabled(bool propval)
  {
    (cast(GdkPixbufFormat*)cPtr).disabled = propval;
  }

  @property string license()
  {
    return (cast(GdkPixbufFormat*)cPtr).license.fromCString(false);
  }

  @property void license(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufFormat*)cPtr).license);
    (cast(GdkPixbufFormat*)cPtr).license = propval.toCString(true);
  }

  /**
   * Creates a copy of `format`.
   * Returns: the newly allocated copy of a `GdkPixbufFormat`. Use
   *   [GdkPixbuf.PixbufFormat.free] to free the resources when done
   */
  PixbufFormat copy()
  {
    GdkPixbufFormat* _cretval;
    _cretval = gdk_pixbuf_format_copy(cast(GdkPixbufFormat*)cPtr);
    auto _retval = _cretval ? new PixbufFormat(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a description of the format.
   * Returns: a description of the format.
   */
  string getDescription()
  {
    char* _cretval;
    _cretval = gdk_pixbuf_format_get_description(cast(GdkPixbufFormat*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the filename extensions typically used for files in the
   * given format.
   * Returns: an array of
   *   filename extensions
   */
  string[] getExtensions()
  {
    char** _cretval;
    _cretval = gdk_pixbuf_format_get_extensions(cast(GdkPixbufFormat*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns information about the license of the image loader for the format.
   * The returned string should be a shorthand for a well known license, e.g.
   * "LGPL", "GPL", "QPL", "GPL/QPL", or "other" to indicate some other license.
   * Returns: a string describing the license of the pixbuf format
   */
  string getLicense()
  {
    char* _cretval;
    _cretval = gdk_pixbuf_format_get_license(cast(GdkPixbufFormat*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the mime types supported by the format.
   * Returns: an array of mime types
   */
  string[] getMimeTypes()
  {
    char** _cretval;
    _cretval = gdk_pixbuf_format_get_mime_types(cast(GdkPixbufFormat*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns the name of the format.
   * Returns: the name of the format.
   */
  string getName()
  {
    char* _cretval;
    _cretval = gdk_pixbuf_format_get_name(cast(GdkPixbufFormat*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns whether this image format is disabled.
   * See [GdkPixbuf.PixbufFormat.setDisabled].
   * Returns: whether this image format is disabled.
   */
  bool isDisabled()
  {
    bool _retval;
    _retval = gdk_pixbuf_format_is_disabled(cast(GdkPixbufFormat*)cPtr);
    return _retval;
  }

  /**
   * Returns `TRUE` if the save option specified by option_key is supported when
   * saving a pixbuf using the module implementing format.
   * See [GdkPixbuf.Pixbuf.save] for more information about option keys.
   * Params:
   *   optionKey = the name of an option
   * Returns: `TRUE` if the specified option is supported
   */
  bool isSaveOptionSupported(string optionKey)
  {
    bool _retval;
    const(char)* _optionKey = optionKey.toCString(false);
    _retval = gdk_pixbuf_format_is_save_option_supported(cast(GdkPixbufFormat*)cPtr, _optionKey);
    return _retval;
  }

  /**
   * Returns whether this image format is scalable.
   * If a file is in a scalable format, it is preferable to load it at
   * the desired size, rather than loading it at the default size and
   * scaling the resulting pixbuf to the desired size.
   * Returns: whether this image format is scalable.
   */
  bool isScalable()
  {
    bool _retval;
    _retval = gdk_pixbuf_format_is_scalable(cast(GdkPixbufFormat*)cPtr);
    return _retval;
  }

  /**
   * Returns whether pixbufs can be saved in the given format.
   * Returns: whether pixbufs can be saved in the given format.
   */
  bool isWritable()
  {
    bool _retval;
    _retval = gdk_pixbuf_format_is_writable(cast(GdkPixbufFormat*)cPtr);
    return _retval;
  }

  /**
   * Disables or enables an image format.
   * If a format is disabled, GdkPixbuf won't use the image loader for
   * this format to load images.
   * Applications can use this to avoid using image loaders with an
   * inappropriate license, see [GdkPixbuf.PixbufFormat.getLicense].
   * Params:
   *   disabled = `TRUE` to disable the format format
   */
  void setDisabled(bool disabled)
  {
    gdk_pixbuf_format_set_disabled(cast(GdkPixbufFormat*)cPtr, disabled);
  }
}
