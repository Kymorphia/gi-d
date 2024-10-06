module Gtk.FontChooserT;

public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;
public import Pango.FontDescription;
public import Pango.FontFace;
public import Pango.FontFamily;
public import Pango.FontMap;

/**
 * `GtkFontChooser` is an interface that can be implemented by widgets
 * for choosing fonts.
 * In GTK, the main objects that implement this interface are
 * [Gtk.FontChooserWidget], [Gtk.FontChooserDialog] and
 * [Gtk.FontButton].

 * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
 *   instead
 */
template FontChooserT(TStruct)
{

  /**
   * Gets the currently-selected font name.
   * Note that this can be a different string than what you set with
   * [Gtk.FontChooser.setFont], as the font chooser widget may
   * normalize font names and thus return a string with a different
   * structure. For example, “Helvetica Italic Bold 12” could be
   * normalized to “Helvetica Bold Italic 12”.
   * Use [Pango.FontDescription.equal] if you want to compare two
   * font descriptions.
   * Returns: A string with the name
   *   of the current font

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override string getFont()
  {
    char* _cretval;
    _cretval = gtk_font_chooser_get_font(cast(GtkFontChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the currently-selected font.
   * Note that this can be a different string than what you set with
   * [Gtk.FontChooser.setFont], as the font chooser widget may
   * normalize font names and thus return a string with a different
   * structure. For example, “Helvetica Italic Bold 12” could be
   * normalized to “Helvetica Bold Italic 12”.
   * Use [Pango.FontDescription.equal] if you want to compare two
   * font descriptions.
   * Returns: A `PangoFontDescription` for the
   *   current font

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override FontDescription getFontDesc()
  {
    PangoFontDescription* _cretval;
    _cretval = gtk_font_chooser_get_font_desc(cast(GtkFontChooser*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the `PangoFontFace` representing the selected font group
   * details $(LPAREN)i.e. family, slant, weight, width, etc$(RPAREN).
   * If the selected font is not installed, returns %NULL.
   * Returns: A `PangoFontFace` representing the
   *   selected font group details

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override FontFace getFontFace()
  {
    PangoFontFace* _cretval;
    _cretval = gtk_font_chooser_get_font_face(cast(GtkFontChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontFace(cast(PangoFontFace*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `PangoFontFamily` representing the selected font family.
   * Font families are a collection of font faces.
   * If the selected font is not installed, returns %NULL.
   * Returns: A `PangoFontFamily` representing the
   *   selected font family

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override FontFamily getFontFamily()
  {
    PangoFontFamily* _cretval;
    _cretval = gtk_font_chooser_get_font_family(cast(GtkFontChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontFamily(cast(PangoFontFamily*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the currently-selected font features.
   * The format of the returned string is compatible with the
   * [CSS font-feature-settings property](https://www.w3.org/TR/css-fonts-4/#font-rend-desc).
   * It can be passed to [Pango.AttrFontFeatures.new_].
   * Returns: the currently selected font features

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override string getFontFeatures()
  {
    char* _cretval;
    _cretval = gtk_font_chooser_get_font_features(cast(GtkFontChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the custom font map of this font chooser widget,
   * or %NULL if it does not have one.
   * Returns: a `PangoFontMap`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override FontMap getFontMap()
  {
    PangoFontMap* _cretval;
    _cretval = gtk_font_chooser_get_font_map(cast(GtkFontChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, true) : null;
    return _retval;
  }

  /**
   * The selected font size.
   * Returns: A n integer representing the selected font size,
   *   or -1 if no font size is selected.

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override int getFontSize()
  {
    int _retval;
    _retval = gtk_font_chooser_get_font_size(cast(GtkFontChooser*)cPtr);
    return _retval;
  }

  /**
   * Gets the language that is used for font features.
   * Returns: the currently selected language

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override string getLanguage()
  {
    char* _cretval;
    _cretval = gtk_font_chooser_get_language(cast(GtkFontChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the current level of granularity for selecting fonts.
   * Returns: the current granularity level

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override FontChooserLevel getLevel()
  {
    GtkFontChooserLevel _cretval;
    _cretval = gtk_font_chooser_get_level(cast(GtkFontChooser*)cPtr);
    FontChooserLevel _retval = cast(FontChooserLevel)_cretval;
    return _retval;
  }

  /**
   * Gets the text displayed in the preview area.
   * Returns: the text displayed in the preview area

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override string getPreviewText()
  {
    char* _cretval;
    _cretval = gtk_font_chooser_get_preview_text(cast(GtkFontChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns whether the preview entry is shown or not.
   * Returns: %TRUE if the preview entry is shown or %FALSE if it is hidden.

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override bool getShowPreviewEntry()
  {
    bool _retval;
    _retval = gtk_font_chooser_get_show_preview_entry(cast(GtkFontChooser*)cPtr);
    return _retval;
  }

  /**
   * Adds a filter function that decides which fonts to display
   * in the font chooser.
   * Params:
   *   filter = a `GtkFontFilterFunc`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setFilterFunc(FontFilterFunc filter)
  {
    extern(C) bool _filterCallback(const(PangoFontFamily)* family, const(PangoFontFace)* face, void* data)
    {
      auto _dlg = cast(FontFilterFunc*)data;

      bool _retval = (*_dlg)(family ? ObjectG.getDObject!FontFamily(cast(void*)family, false) : null, face ? ObjectG.getDObject!FontFace(cast(void*)face, false) : null);
      return _retval;
    }

    auto _filter = freezeDelegate(cast(void*)&filter);
    gtk_font_chooser_set_filter_func(cast(GtkFontChooser*)cPtr, &_filterCallback, _filter, &thawDelegate);
  }

  /**
   * Sets the currently-selected font.
   * Params:
   *   fontname = a font name like “Helvetica 12” or “Times Bold 18”

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setFont(string fontname)
  {
    const(char)* _fontname = fontname.toCString(false);
    gtk_font_chooser_set_font(cast(GtkFontChooser*)cPtr, _fontname);
  }

  /**
   * Sets the currently-selected font from font_desc.
   * Params:
   *   fontDesc = a `PangoFontDescription`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setFontDesc(FontDescription fontDesc)
  {
    gtk_font_chooser_set_font_desc(cast(GtkFontChooser*)cPtr, fontDesc ? cast(PangoFontDescription*)fontDesc.cPtr(false) : null);
  }

  /**
   * Sets a custom font map to use for this font chooser widget.
   * A custom font map can be used to present application-specific
   * fonts instead of or in addition to the normal system fonts.
   * ```c
   * FcConfig *config;
   * PangoFontMap *fontmap;
   * config \= FcInitLoadConfigAndFonts $(LPAREN)$(RPAREN);
   * FcConfigAppFontAddFile $(LPAREN)config, my_app_font_file$(RPAREN);
   * fontmap \= pango_cairo_font_map_new_for_font_type $(LPAREN)CAIRO_FONT_TYPE_FT$(RPAREN);
   * pango_fc_font_map_set_config $(LPAREN)PANGO_FC_FONT_MAP $(LPAREN)fontmap$(RPAREN), config$(RPAREN);
   * gtk_font_chooser_set_font_map $(LPAREN)font_chooser, fontmap$(RPAREN);
   * ```
   * Note that other GTK widgets will only be able to use the
   * application-specific font if it is present in the font map they use:
   * ```c
   * context \= gtk_widget_get_pango_context $(LPAREN)label$(RPAREN);
   * pango_context_set_font_map $(LPAREN)context, fontmap$(RPAREN);
   * ```
   * Params:
   *   fontmap = a `PangoFontMap`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setFontMap(FontMap fontmap)
  {
    gtk_font_chooser_set_font_map(cast(GtkFontChooser*)cPtr, fontmap ? cast(PangoFontMap*)fontmap.cPtr(false) : null);
  }

  /**
   * Sets the language to use for font features.
   * Params:
   *   language = a language

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setLanguage(string language)
  {
    const(char)* _language = language.toCString(false);
    gtk_font_chooser_set_language(cast(GtkFontChooser*)cPtr, _language);
  }

  /**
   * Sets the desired level of granularity for selecting fonts.
   * Params:
   *   level = the desired level of granularity

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setLevel(FontChooserLevel level)
  {
    gtk_font_chooser_set_level(cast(GtkFontChooser*)cPtr, level);
  }

  /**
   * Sets the text displayed in the preview area.
   * The text is used to show how the selected font looks.
   * Params:
   *   text = the text to display in the preview area

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setPreviewText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_font_chooser_set_preview_text(cast(GtkFontChooser*)cPtr, _text);
  }

  /**
   * Shows or hides the editable preview entry.
   * Params:
   *   showPreviewEntry = whether to show the editable preview entry or not

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  override void setShowPreviewEntry(bool showPreviewEntry)
  {
    gtk_font_chooser_set_show_preview_entry(cast(GtkFontChooser*)cPtr, showPreviewEntry);
  }

  /**
   * Emitted when a font is activated.
   * This usually happens when the user double clicks an item,
   * or an item is selected and the user presses one of the keys
   * Space, Shift+Space, Return or Enter.
   * Params
   *   fontname = the font name
   *   fontChooser = the instance the signal is connected to

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton] instead
   */
  alias FontActivatedCallback = void delegate(string fontname, FontChooser fontChooser);

  /**
   * Connect to FontActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectFontActivated(FontActivatedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fontChooser = getVal!FontChooser(_paramVals);
      auto fontname = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(fontname, fontChooser);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("font-activated", closure, (flags & ConnectFlags.After) != 0);
  }
}
