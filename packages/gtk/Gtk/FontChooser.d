module Gtk.FontChooser;

public import Gtk.FontChooserIfaceProxy;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.FontDescription;
import Pango.FontFace;
import Pango.FontFamily;
import Pango.FontMap;

/**
 * `GtkFontChooser` is an interface that can be implemented by widgets
 * for choosing fonts.
 * In GTK, the main objects that implement this interface are
 * [Gtk.FontChooserWidget], [Gtk.FontChooserDialog] and
 * [Gtk.FontButton].

 * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
 *   instead
 */
interface FontChooser
{

  static GType getType()
  {
    return gtk_font_chooser_get_type();
  }

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
  string getFont();

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
  FontDescription getFontDesc();

  /**
   * Gets the `PangoFontFace` representing the selected font group
   * details $(LPAREN)i.e. family, slant, weight, width, etc$(RPAREN).
   * If the selected font is not installed, returns %NULL.
   * Returns: A `PangoFontFace` representing the
   *   selected font group details

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  FontFace getFontFace();

  /**
   * Gets the `PangoFontFamily` representing the selected font family.
   * Font families are a collection of font faces.
   * If the selected font is not installed, returns %NULL.
   * Returns: A `PangoFontFamily` representing the
   *   selected font family

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  FontFamily getFontFamily();

  /**
   * Gets the currently-selected font features.
   * The format of the returned string is compatible with the
   * [CSS font-feature-settings property](https://www.w3.org/TR/css-fonts-4/#font-rend-desc).
   * It can be passed to [Pango.AttrFontFeatures.new_].
   * Returns: the currently selected font features

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  string getFontFeatures();

  /**
   * Gets the custom font map of this font chooser widget,
   * or %NULL if it does not have one.
   * Returns: a `PangoFontMap`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  FontMap getFontMap();

  /**
   * The selected font size.
   * Returns: A n integer representing the selected font size,
   *   or -1 if no font size is selected.

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  int getFontSize();

  /**
   * Gets the language that is used for font features.
   * Returns: the currently selected language

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  string getLanguage();

  /**
   * Returns the current level of granularity for selecting fonts.
   * Returns: the current granularity level

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  FontChooserLevel getLevel();

  /**
   * Gets the text displayed in the preview area.
   * Returns: the text displayed in the preview area

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  string getPreviewText();

  /**
   * Returns whether the preview entry is shown or not.
   * Returns: %TRUE if the preview entry is shown or %FALSE if it is hidden.

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  bool getShowPreviewEntry();

  /**
   * Adds a filter function that decides which fonts to display
   * in the font chooser.
   * Params:
   *   filter = a `GtkFontFilterFunc`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setFilterFunc(FontFilterFunc filter);

  /**
   * Sets the currently-selected font.
   * Params:
   *   fontname = a font name like “Helvetica 12” or “Times Bold 18”

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setFont(string fontname);

  /**
   * Sets the currently-selected font from font_desc.
   * Params:
   *   fontDesc = a `PangoFontDescription`

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setFontDesc(FontDescription fontDesc);

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
  void setFontMap(FontMap fontmap);

  /**
   * Sets the language to use for font features.
   * Params:
   *   language = a language

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setLanguage(string language);

  /**
   * Sets the desired level of granularity for selecting fonts.
   * Params:
   *   level = the desired level of granularity

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setLevel(FontChooserLevel level);

  /**
   * Sets the text displayed in the preview area.
   * The text is used to show how the selected font looks.
   * Params:
   *   text = the text to display in the preview area

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setPreviewText(string text);

  /**
   * Shows or hides the editable preview entry.
   * Params:
   *   showPreviewEntry = whether to show the editable preview entry or not

   * Deprecated: Use [Gtk.FontDialog] and [Gtk.FontDialogButton]
   *   instead
   */
  void setShowPreviewEntry(bool showPreviewEntry);

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
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectFontActivated(FontActivatedCallback dlg, Flag!"After" after = No.After);
}
