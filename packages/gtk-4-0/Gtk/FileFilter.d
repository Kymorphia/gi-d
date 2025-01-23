module Gtk.FileFilter;

import GLib.VariantG;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Filter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFileFilter` filters files by name or mime type.
 * `GtkFileFilter` can be used to restrict the files being shown in a
 * `GtkFileChooser`. Files can be filtered based on their name $(LPAREN)with
 * [Gtk.FileFilter.addPattern] or [Gtk.FileFilter.addSuffix]$(RPAREN)
 * or on their mime type $(LPAREN)with [Gtk.FileFilter.addMimeType]$(RPAREN).
 * Filtering by mime types handles aliasing and subclassing of mime
 * types; e.g. a filter for text/plain also matches a file with mime
 * type application/rtf, since application/rtf is a subclass of
 * text/plain. Note that `GtkFileFilter` allows wildcards for the
 * subtype of a mime type, so you can e.g. filter for image/\*.
 * Normally, file filters are used by adding them to a `GtkFileChooser`
 * $(LPAREN)see [Gtk.FileChooser.addFilter]$(RPAREN), but it is also possible to
 * manually use a file filter on any [Gtk.FilterListModel] containing
 * `GFileInfo` objects.
 * # GtkFileFilter as GtkBuildable
 * The `GtkFileFilter` implementation of the `GtkBuildable` interface
 * supports adding rules using the `<mime-types>` and `<patterns>` and
 * `<suffixes>` elements and listing the rules within. Specifying a
 * `<mime-type>` or `<pattern>` or `<suffix>` has the same effect as
 * as calling
 * [Gtk.FileFilter.addMimeType] or
 * [Gtk.FileFilter.addPattern] or
 * [Gtk.FileFilter.addSuffix].
 * An example of a UI definition fragment specifying `GtkFileFilter`
 * rules:
 * ```xml
 * <object class\="GtkFileFilter">
 * <property name\="name" translatable\="yes">Text and Images</property>
 * <mime-types>
 * <mime-type>text/plain</mime-type>
 * <mime-type>image/ *</mime-type>
 * </mime-types>
 * <patterns>
 * <pattern>*.txt</pattern>
 * </patterns>
 * <suffixes>
 * <suffix>png</suffix>
 * </suffixes>
 * </object>
 * ```
 */
class FileFilter : Filter, Buildable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_file_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!();

  /**
   * Creates a new `GtkFileFilter` with no rules added to it.
   * Such a filter doesn’t accept any files, so is not
   * particularly useful until you add rules with
   * [Gtk.FileFilter.addMimeType],
   * [Gtk.FileFilter.addPattern],
   * [Gtk.FileFilter.addSuffix] or
   * [Gtk.FileFilter.addPixbufFormats].
   * To create a filter that accepts any file, use:
   * ```c
   * GtkFileFilter *filter \= gtk_file_filter_new $(LPAREN)$(RPAREN);
   * gtk_file_filter_add_pattern $(LPAREN)filter, "*"$(RPAREN);
   * ```
   * Returns: a new `GtkFileFilter`
   */
  this()
  {
    GtkFileFilter* _cretval;
    _cretval = gtk_file_filter_new();
    this(_cretval, true);
  }

  /**
   * Deserialize a file filter from a `GVariant`.
   * The variant must be in the format produced by
   * [Gtk.FileFilter.toGvariant].
   * Params:
   *   variant = an `a{sv}` `GVariant`
   * Returns: a new `GtkFileFilter` object
   */
  static FileFilter newFromGvariant(VariantG variant)
  {
    GtkFileFilter* _cretval;
    _cretval = gtk_file_filter_new_from_gvariant(variant ? cast(VariantC*)variant.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!FileFilter(cast(GtkFileFilter*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds a rule allowing a given mime type to filter.
   * Params:
   *   mimeType = name of a MIME type
   */
  void addMimeType(string mimeType)
  {
    const(char)* _mimeType = mimeType.toCString(false);
    gtk_file_filter_add_mime_type(cast(GtkFileFilter*)cPtr, _mimeType);
  }

  /**
   * Adds a rule allowing a shell style glob to a filter.
   * Note that it depends on the platform whether pattern
   * matching ignores case or not. On Windows, it does, on
   * other platforms, it doesn't.
   * Params:
   *   pattern = a shell style glob
   */
  void addPattern(string pattern)
  {
    const(char)* _pattern = pattern.toCString(false);
    gtk_file_filter_add_pattern(cast(GtkFileFilter*)cPtr, _pattern);
  }

  /**
   * Adds a rule allowing image files in the formats supported
   * by GdkPixbuf.
   * This is equivalent to calling [Gtk.FileFilter.addMimeType]
   * for all the supported mime types.
   */
  void addPixbufFormats()
  {
    gtk_file_filter_add_pixbuf_formats(cast(GtkFileFilter*)cPtr);
  }

  /**
   * Adds a suffix match rule to a filter.
   * This is similar to adding a match for the pattern
   * "*.suffix".
   * In contrast to pattern matches, suffix matches
   * are *always* case-insensitive.
   * Params:
   *   suffix = filename suffix to match
   */
  void addSuffix(string suffix)
  {
    const(char)* _suffix = suffix.toCString(false);
    gtk_file_filter_add_suffix(cast(GtkFileFilter*)cPtr, _suffix);
  }

  /**
   * Gets the attributes that need to be filled in for the `GFileInfo`
   * passed to this filter.
   * This function will not typically be used by applications;
   * it is intended principally for use in the implementation
   * of `GtkFileChooser`.
   * Returns: the attributes
   */
  string[] getAttributes()
  {
    const(char*)* _cretval;
    _cretval = gtk_file_filter_get_attributes(cast(GtkFileFilter*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Gets the human-readable name for the filter.
   * See [Gtk.FileFilter.setName].
   * Returns: The human-readable name of the filter
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_file_filter_get_name(cast(GtkFileFilter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets a human-readable name of the filter.
   * This is the string that will be displayed in the file chooser
   * if there is a selectable list of filters.
   * Params:
   *   name = the human-readable-name for the filter, or %NULL
   *     to remove any existing name.
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_file_filter_set_name(cast(GtkFileFilter*)cPtr, _name);
  }

  /**
   * Serialize a file filter to an `a{sv}` variant.
   * Returns: a new, floating, `GVariant`
   */
  VariantG toGvariant()
  {
    VariantC* _cretval;
    _cretval = gtk_file_filter_to_gvariant(cast(GtkFileFilter*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }
}
