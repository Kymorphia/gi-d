module Gtk.PrintSettings;

import GLib.ErrorG;
import GLib.KeyFile;
import GLib.Variant;
import GObject.ObjectG;
import Gid.gid;
import Gtk.PaperSize;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkPrintSettings` object represents the settings of a print dialog in
 * a system-independent way.
 * The main use for this object is that once you’ve printed you can get a
 * settings object that represents the settings the user chose, and the next
 * time you print you can pass that object in so that the user doesn’t have
 * to re-set all his settings.
 * Its also possible to enumerate the settings so that you can easily save
 * the settings for the next time your app runs, or even store them in a
 * document. The predefined keys try to use shared values as much as possible
 * so that moving such a document between systems still works.
 */
class PrintSettings : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_print_settings_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPrintSettings` object.
   * Returns: a new `GtkPrintSettings` object
   */
  this()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_settings_new();
    this(_cretval, true);
  }

  /**
   * Reads the print settings from file_name.
   * Returns a new `GtkPrintSettings` object with the restored settings,
   * or %NULL if an error occurred. If the file could not be loaded then
   * error is set to either a `GFileError` or `GKeyFileError`.
   * See [Gtk.PrintSettings.toFile].
   * Params:
   *   fileName = the filename to read the settings from
   * Returns: the restored `GtkPrintSettings`
   */
  static PrintSettings newFromFile(string fileName)
  {
    GtkPrintSettings* _cretval;
    const(char)* _fileName = fileName.toCString(false);
    GError *_err;
    _cretval = gtk_print_settings_new_from_file(_fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Deserialize print settings from an a{sv} variant.
   * The variant must be in the format produced by
   * [Gtk.PrintSettings.toGvariant].
   * Params:
   *   variant = an a{sv} `GVariant`
   * Returns: a new `GtkPrintSettings` object
   */
  static PrintSettings newFromGvariant(Variant variant)
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_settings_new_from_gvariant(variant ? cast(GVariant*)variant.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Reads the print settings from the group group_name in key_file.
   * Returns a new `GtkPrintSettings` object with the restored settings,
   * or %NULL if an error occurred. If the file could not be loaded then
   * error is set to either `GFileError` or `GKeyFileError`.
   * Params:
   *   keyFile = the `GKeyFile` to retrieve the settings from
   *   groupName = the name of the group to use, or %NULL to use
   *     the default “Print Settings”
   * Returns: the restored `GtkPrintSettings`
   */
  static PrintSettings newFromKeyFile(KeyFile keyFile, string groupName)
  {
    GtkPrintSettings* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _cretval = gtk_print_settings_new_from_key_file(keyFile ? cast(GKeyFile*)keyFile.cPtr(false) : null, _groupName, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Copies a `GtkPrintSettings` object.
   * Returns: a newly allocated copy of other
   */
  PrintSettings copy()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_settings_copy(cast(GtkPrintSettings*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Calls func for each key-value pair of settings.
   * Params:
   *   func = the function to call
   */
  void foreach_(PrintSettingsFunc func)
  {
    static PrintSettingsFunc _static_func;

    extern(C) void _funcCallback(const(char)* key, const(char)* value, void* userData)
    {
      string _key = key.fromCString(false);
      string _value = value.fromCString(false);

      _static_func(_key, _value);
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    gtk_print_settings_foreach(cast(GtkPrintSettings*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Looks up the string value associated with key.
   * Params:
   *   key = a key
   * Returns: the string value for key
   */
  string get(string key)
  {
    const(char)* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = gtk_print_settings_get(cast(GtkPrintSettings*)cPtr, _key);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the boolean represented by the value
   * that is associated with key.
   * The string “true” represents %TRUE, any other
   * string %FALSE.
   * Params:
   *   key = a key
   * Returns: %TRUE, if key maps to a true value.
   */
  bool getBool(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_bool(cast(GtkPrintSettings*)cPtr, _key);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_COLLATE.
   * Returns: whether to collate the printed pages
   */
  bool getCollate()
  {
    bool _retval;
    _retval = gtk_print_settings_get_collate(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_DEFAULT_SOURCE.
   * Returns: the default source
   */
  string getDefaultSource()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_default_source(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_DITHER.
   * Returns: the dithering that is used
   */
  string getDither()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_dither(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the double value associated with key, or 0.
   * Params:
   *   key = a key
   * Returns: the double value of key
   */
  double getDouble(string key)
  {
    double _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_double(cast(GtkPrintSettings*)cPtr, _key);
    return _retval;
  }

  /**
   * Returns the floating point number represented by
   * the value that is associated with key, or default_val
   * if the value does not represent a floating point number.
   * Floating point numbers are parsed with [GLib.Global.asciiStrtod].
   * Params:
   *   key = a key
   *   def = the default value
   * Returns: the floating point number associated with key
   */
  double getDoubleWithDefault(string key, double def)
  {
    double _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_double_with_default(cast(GtkPrintSettings*)cPtr, _key, def);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_DUPLEX.
   * Returns: whether to print the output in duplex.
   */
  PrintDuplex getDuplex()
  {
    GtkPrintDuplex _cretval;
    _cretval = gtk_print_settings_get_duplex(cast(GtkPrintSettings*)cPtr);
    PrintDuplex _retval = cast(PrintDuplex)_cretval;
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_FINISHINGS.
   * Returns: the finishings
   */
  string getFinishings()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_finishings(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the integer value of key, or 0.
   * Params:
   *   key = a key
   * Returns: the integer value of key
   */
  int getInt(string key)
  {
    int _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_int(cast(GtkPrintSettings*)cPtr, _key);
    return _retval;
  }

  /**
   * Returns the value of key, interpreted as
   * an integer, or the default value.
   * Params:
   *   key = a key
   *   def = the default value
   * Returns: the integer value of key
   */
  int getIntWithDefault(string key, int def)
  {
    int _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_int_with_default(cast(GtkPrintSettings*)cPtr, _key, def);
    return _retval;
  }

  /**
   * Returns the value associated with key, interpreted
   * as a length.
   * The returned value is converted to units.
   * Params:
   *   key = a key
   *   unit = the unit of the return value
   * Returns: the length value of key, converted to unit
   */
  double getLength(string key, Unit unit)
  {
    double _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_get_length(cast(GtkPrintSettings*)cPtr, _key, unit);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_MEDIA_TYPE.
   * The set of media types is defined in PWG 5101.1-2002 PWG.
   * Returns: the media type
   */
  string getMediaType()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_media_type(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_N_COPIES.
   * Returns: the number of copies to print
   */
  int getNCopies()
  {
    int _retval;
    _retval = gtk_print_settings_get_n_copies(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_NUMBER_UP.
   * Returns: the number of pages per sheet
   */
  int getNumberUp()
  {
    int _retval;
    _retval = gtk_print_settings_get_number_up(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT.
   * Returns: layout of page in number-up mode
   */
  NumberUpLayout getNumberUpLayout()
  {
    GtkNumberUpLayout _cretval;
    _cretval = gtk_print_settings_get_number_up_layout(cast(GtkPrintSettings*)cPtr);
    NumberUpLayout _retval = cast(NumberUpLayout)_cretval;
    return _retval;
  }

  /**
   * Get the value of %GTK_PRINT_SETTINGS_ORIENTATION,
   * converted to a `GtkPageOrientation`.
   * Returns: the orientation
   */
  PageOrientation getOrientation()
  {
    GtkPageOrientation _cretval;
    _cretval = gtk_print_settings_get_orientation(cast(GtkPrintSettings*)cPtr);
    PageOrientation _retval = cast(PageOrientation)_cretval;
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_OUTPUT_BIN.
   * Returns: the output bin
   */
  string getOutputBin()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_output_bin(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PAGE_RANGES.
   * Returns: an array
   *   of `GtkPageRange`s. Use [GLib.Global.gfree] to free the array when
   *   it is no longer needed.
   */
  PageRange[] getPageRanges()
  {
    GtkPageRange* _cretval;
    int _cretlength;
    _cretval = gtk_print_settings_get_page_ranges(cast(GtkPrintSettings*)cPtr, &_cretlength);
    PageRange[] _retval;

    if (_cretval)
    {
      _retval = new PageRange[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i];
    }
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PAGE_SET.
   * Returns: the set of pages to print
   */
  PageSet getPageSet()
  {
    GtkPageSet _cretval;
    _cretval = gtk_print_settings_get_page_set(cast(GtkPrintSettings*)cPtr);
    PageSet _retval = cast(PageSet)_cretval;
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PAPER_HEIGHT,
   * converted to unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the paper height, in units of unit
   */
  double getPaperHeight(Unit unit)
  {
    double _retval;
    _retval = gtk_print_settings_get_paper_height(cast(GtkPrintSettings*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PAPER_FORMAT,
   * converted to a `GtkPaperSize`.
   * Returns: the paper size
   */
  PaperSize getPaperSize()
  {
    GtkPaperSize* _cretval;
    _cretval = gtk_print_settings_get_paper_size(cast(GtkPrintSettings*)cPtr);
    auto _retval = _cretval ? new PaperSize(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PAPER_WIDTH,
   * converted to unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the paper width, in units of unit
   */
  double getPaperWidth(Unit unit)
  {
    double _retval;
    _retval = gtk_print_settings_get_paper_width(cast(GtkPrintSettings*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PRINT_PAGES.
   * Returns: which pages to print
   */
  PrintPages getPrintPages()
  {
    GtkPrintPages _cretval;
    _cretval = gtk_print_settings_get_print_pages(cast(GtkPrintSettings*)cPtr);
    PrintPages _retval = cast(PrintPages)_cretval;
    return _retval;
  }

  /**
   * Convenience function to obtain the value of
   * %GTK_PRINT_SETTINGS_PRINTER.
   * Returns: the printer name
   */
  string getPrinter()
  {
    const(char)* _cretval;
    _cretval = gtk_print_settings_get_printer(cast(GtkPrintSettings*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_PRINTER_LPI.
   * Returns: the resolution in lpi $(LPAREN)lines per inch$(RPAREN)
   */
  double getPrinterLpi()
  {
    double _retval;
    _retval = gtk_print_settings_get_printer_lpi(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_QUALITY.
   * Returns: the print quality
   */
  PrintQuality getQuality()
  {
    GtkPrintQuality _cretval;
    _cretval = gtk_print_settings_get_quality(cast(GtkPrintSettings*)cPtr);
    PrintQuality _retval = cast(PrintQuality)_cretval;
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_RESOLUTION.
   * Returns: the resolution in dpi
   */
  int getResolution()
  {
    int _retval;
    _retval = gtk_print_settings_get_resolution(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_RESOLUTION_X.
   * Returns: the horizontal resolution in dpi
   */
  int getResolutionX()
  {
    int _retval;
    _retval = gtk_print_settings_get_resolution_x(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_RESOLUTION_Y.
   * Returns: the vertical resolution in dpi
   */
  int getResolutionY()
  {
    int _retval;
    _retval = gtk_print_settings_get_resolution_y(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_REVERSE.
   * Returns: whether to reverse the order of the printed pages
   */
  bool getReverse()
  {
    bool _retval;
    _retval = gtk_print_settings_get_reverse(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_SCALE.
   * Returns: the scale in percent
   */
  double getScale()
  {
    double _retval;
    _retval = gtk_print_settings_get_scale(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of %GTK_PRINT_SETTINGS_USE_COLOR.
   * Returns: whether to use color
   */
  bool getUseColor()
  {
    bool _retval;
    _retval = gtk_print_settings_get_use_color(cast(GtkPrintSettings*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE, if a value is associated with key.
   * Params:
   *   key = a key
   * Returns: %TRUE, if key has a value
   */
  bool hasKey(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = gtk_print_settings_has_key(cast(GtkPrintSettings*)cPtr, _key);
    return _retval;
  }

  /**
   * Reads the print settings from file_name.
   * If the file could not be loaded then error is set to either
   * a `GFileError` or `GKeyFileError`.
   * See [Gtk.PrintSettings.toFile].
   * Params:
   *   fileName = the filename to read the settings from
   * Returns: %TRUE on success
   */
  bool loadFile(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(false);
    GError *_err;
    _retval = gtk_print_settings_load_file(cast(GtkPrintSettings*)cPtr, _fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads the print settings from the group group_name in key_file.
   * If the file could not be loaded then error is set to either a
   * `GFileError` or `GKeyFileError`.
   * Params:
   *   keyFile = the `GKeyFile` to retrieve the settings from
   *   groupName = the name of the group to use, or %NULL
   *     to use the default “Print Settings”
   * Returns: %TRUE on success
   */
  bool loadKeyFile(KeyFile keyFile, string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _retval = gtk_print_settings_load_key_file(cast(GtkPrintSettings*)cPtr, keyFile ? cast(GKeyFile*)keyFile.cPtr(false) : null, _groupName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Associates value with key.
   * Params:
   *   key = a key
   *   value = a string value
   */
  void set(string key, string value)
  {
    const(char)* _key = key.toCString(false);
    const(char)* _value = value.toCString(false);
    gtk_print_settings_set(cast(GtkPrintSettings*)cPtr, _key, _value);
  }

  /**
   * Sets key to a boolean value.
   * Params:
   *   key = a key
   *   value = a boolean
   */
  void setBool(string key, bool value)
  {
    const(char)* _key = key.toCString(false);
    gtk_print_settings_set_bool(cast(GtkPrintSettings*)cPtr, _key, value);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_COLLATE.
   * Params:
   *   collate = whether to collate the output
   */
  void setCollate(bool collate)
  {
    gtk_print_settings_set_collate(cast(GtkPrintSettings*)cPtr, collate);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_DEFAULT_SOURCE.
   * Params:
   *   defaultSource = the default source
   */
  void setDefaultSource(string defaultSource)
  {
    const(char)* _defaultSource = defaultSource.toCString(false);
    gtk_print_settings_set_default_source(cast(GtkPrintSettings*)cPtr, _defaultSource);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_DITHER.
   * Params:
   *   dither = the dithering that is used
   */
  void setDither(string dither)
  {
    const(char)* _dither = dither.toCString(false);
    gtk_print_settings_set_dither(cast(GtkPrintSettings*)cPtr, _dither);
  }

  /**
   * Sets key to a double value.
   * Params:
   *   key = a key
   *   value = a double value
   */
  void setDouble(string key, double value)
  {
    const(char)* _key = key.toCString(false);
    gtk_print_settings_set_double(cast(GtkPrintSettings*)cPtr, _key, value);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_DUPLEX.
   * Params:
   *   duplex = a `GtkPrintDuplex` value
   */
  void setDuplex(PrintDuplex duplex)
  {
    gtk_print_settings_set_duplex(cast(GtkPrintSettings*)cPtr, duplex);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_FINISHINGS.
   * Params:
   *   finishings = the finishings
   */
  void setFinishings(string finishings)
  {
    const(char)* _finishings = finishings.toCString(false);
    gtk_print_settings_set_finishings(cast(GtkPrintSettings*)cPtr, _finishings);
  }

  /**
   * Sets key to an integer value.
   * Params:
   *   key = a key
   *   value = an integer
   */
  void setInt(string key, int value)
  {
    const(char)* _key = key.toCString(false);
    gtk_print_settings_set_int(cast(GtkPrintSettings*)cPtr, _key, value);
  }

  /**
   * Associates a length in units of unit with key.
   * Params:
   *   key = a key
   *   value = a length
   *   unit = the unit of length
   */
  void setLength(string key, double value, Unit unit)
  {
    const(char)* _key = key.toCString(false);
    gtk_print_settings_set_length(cast(GtkPrintSettings*)cPtr, _key, value, unit);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_MEDIA_TYPE.
   * The set of media types is defined in PWG 5101.1-2002 PWG.
   * Params:
   *   mediaType = the media type
   */
  void setMediaType(string mediaType)
  {
    const(char)* _mediaType = mediaType.toCString(false);
    gtk_print_settings_set_media_type(cast(GtkPrintSettings*)cPtr, _mediaType);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_N_COPIES.
   * Params:
   *   numCopies = the number of copies
   */
  void setNCopies(int numCopies)
  {
    gtk_print_settings_set_n_copies(cast(GtkPrintSettings*)cPtr, numCopies);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_NUMBER_UP.
   * Params:
   *   numberUp = the number of pages per sheet
   */
  void setNumberUp(int numberUp)
  {
    gtk_print_settings_set_number_up(cast(GtkPrintSettings*)cPtr, numberUp);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT.
   * Params:
   *   numberUpLayout = a `GtkNumberUpLayout` value
   */
  void setNumberUpLayout(NumberUpLayout numberUpLayout)
  {
    gtk_print_settings_set_number_up_layout(cast(GtkPrintSettings*)cPtr, numberUpLayout);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_ORIENTATION.
   * Params:
   *   orientation = a page orientation
   */
  void setOrientation(PageOrientation orientation)
  {
    gtk_print_settings_set_orientation(cast(GtkPrintSettings*)cPtr, orientation);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_OUTPUT_BIN.
   * Params:
   *   outputBin = the output bin
   */
  void setOutputBin(string outputBin)
  {
    const(char)* _outputBin = outputBin.toCString(false);
    gtk_print_settings_set_output_bin(cast(GtkPrintSettings*)cPtr, _outputBin);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PAGE_RANGES.
   * Params:
   *   pageRanges = an array of `GtkPageRange`s
   */
  void setPageRanges(PageRange[] pageRanges)
  {
    int _numRanges;
    if (pageRanges)
      _numRanges = cast(int)pageRanges.length;

    auto _pageRanges = cast(GtkPageRange*)pageRanges.ptr;
    gtk_print_settings_set_page_ranges(cast(GtkPrintSettings*)cPtr, _pageRanges, _numRanges);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PAGE_SET.
   * Params:
   *   pageSet = a `GtkPageSet` value
   */
  void setPageSet(PageSet pageSet)
  {
    gtk_print_settings_set_page_set(cast(GtkPrintSettings*)cPtr, pageSet);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PAPER_HEIGHT.
   * Params:
   *   height = the paper height
   *   unit = the units of height
   */
  void setPaperHeight(double height, Unit unit)
  {
    gtk_print_settings_set_paper_height(cast(GtkPrintSettings*)cPtr, height, unit);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PAPER_FORMAT,
   * %GTK_PRINT_SETTINGS_PAPER_WIDTH and
   * %GTK_PRINT_SETTINGS_PAPER_HEIGHT.
   * Params:
   *   paperSize = a paper size
   */
  void setPaperSize(PaperSize paperSize)
  {
    gtk_print_settings_set_paper_size(cast(GtkPrintSettings*)cPtr, paperSize ? cast(GtkPaperSize*)paperSize.cPtr(false) : null);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PAPER_WIDTH.
   * Params:
   *   width = the paper width
   *   unit = the units of width
   */
  void setPaperWidth(double width, Unit unit)
  {
    gtk_print_settings_set_paper_width(cast(GtkPrintSettings*)cPtr, width, unit);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PRINT_PAGES.
   * Params:
   *   pages = a `GtkPrintPages` value
   */
  void setPrintPages(PrintPages pages)
  {
    gtk_print_settings_set_print_pages(cast(GtkPrintSettings*)cPtr, pages);
  }

  /**
   * Convenience function to set %GTK_PRINT_SETTINGS_PRINTER
   * to printer.
   * Params:
   *   printer = the printer name
   */
  void setPrinter(string printer)
  {
    const(char)* _printer = printer.toCString(false);
    gtk_print_settings_set_printer(cast(GtkPrintSettings*)cPtr, _printer);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_PRINTER_LPI.
   * Params:
   *   lpi = the resolution in lpi $(LPAREN)lines per inch$(RPAREN)
   */
  void setPrinterLpi(double lpi)
  {
    gtk_print_settings_set_printer_lpi(cast(GtkPrintSettings*)cPtr, lpi);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_QUALITY.
   * Params:
   *   quality = a `GtkPrintQuality` value
   */
  void setQuality(PrintQuality quality)
  {
    gtk_print_settings_set_quality(cast(GtkPrintSettings*)cPtr, quality);
  }

  /**
   * Sets the values of %GTK_PRINT_SETTINGS_RESOLUTION,
   * %GTK_PRINT_SETTINGS_RESOLUTION_X and
   * %GTK_PRINT_SETTINGS_RESOLUTION_Y.
   * Params:
   *   resolution = the resolution in dpi
   */
  void setResolution(int resolution)
  {
    gtk_print_settings_set_resolution(cast(GtkPrintSettings*)cPtr, resolution);
  }

  /**
   * Sets the values of %GTK_PRINT_SETTINGS_RESOLUTION,
   * %GTK_PRINT_SETTINGS_RESOLUTION_X and
   * %GTK_PRINT_SETTINGS_RESOLUTION_Y.
   * Params:
   *   resolutionX = the horizontal resolution in dpi
   *   resolutionY = the vertical resolution in dpi
   */
  void setResolutionXy(int resolutionX, int resolutionY)
  {
    gtk_print_settings_set_resolution_xy(cast(GtkPrintSettings*)cPtr, resolutionX, resolutionY);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_REVERSE.
   * Params:
   *   reverse = whether to reverse the output
   */
  void setReverse(bool reverse)
  {
    gtk_print_settings_set_reverse(cast(GtkPrintSettings*)cPtr, reverse);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_SCALE.
   * Params:
   *   scale = the scale in percent
   */
  void setScale(double scale)
  {
    gtk_print_settings_set_scale(cast(GtkPrintSettings*)cPtr, scale);
  }

  /**
   * Sets the value of %GTK_PRINT_SETTINGS_USE_COLOR.
   * Params:
   *   useColor = whether to use color
   */
  void setUseColor(bool useColor)
  {
    gtk_print_settings_set_use_color(cast(GtkPrintSettings*)cPtr, useColor);
  }

  /**
   * This function saves the print settings from settings to file_name.
   * If the file could not be written then error is set to either a
   * `GFileError` or `GKeyFileError`.
   * Params:
   *   fileName = the file to save to
   * Returns: %TRUE on success
   */
  bool toFile(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(false);
    GError *_err;
    _retval = gtk_print_settings_to_file(cast(GtkPrintSettings*)cPtr, _fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Serialize print settings to an a{sv} variant.
   * Returns: a new, floating, `GVariant`
   */
  Variant toGvariant()
  {
    GVariant* _cretval;
    _cretval = gtk_print_settings_to_gvariant(cast(GtkPrintSettings*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, false) : null;
    return _retval;
  }

  /**
   * This function adds the print settings from settings to key_file.
   * Params:
   *   keyFile = the `GKeyFile` to save the print settings to
   *   groupName = the group to add the settings to in key_file, or
   *     %NULL to use the default “Print Settings”
   */
  void toKeyFile(KeyFile keyFile, string groupName)
  {
    const(char)* _groupName = groupName.toCString(false);
    gtk_print_settings_to_key_file(cast(GtkPrintSettings*)cPtr, keyFile ? cast(GKeyFile*)keyFile.cPtr(false) : null, _groupName);
  }

  /**
   * Removes any value associated with key.
   * This has the same effect as setting the value to %NULL.
   * Params:
   *   key = a key
   */
  void unset(string key)
  {
    const(char)* _key = key.toCString(false);
    gtk_print_settings_unset(cast(GtkPrintSettings*)cPtr, _key);
  }
}
