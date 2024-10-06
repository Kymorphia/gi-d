module Gtk.Label;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.MenuModel;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.AccessibleText;
import Gtk.AccessibleTextT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.AttrList;
import Pango.Layout;
import Pango.TabArray;
import Pango.Types;
import Pango.Types : WrapMode = WrapMode;

/**
 * The `GtkLabel` widget displays a small amount of text.
 * As the name implies, most labels are used to label another widget
 * such as a class@Button.
 * ![An example GtkLabel](label.png)
 * ## CSS nodes
 * ```
 * label
 * ├── [selection]
 * ├── [link]
 * ┊
 * ╰── [link]
 * ```
 * `GtkLabel` has a single CSS node with the name label. A wide variety
 * of style classes may be applied to labels, such as .title, .subtitle,
 * .dim-label, etc. In the `GtkShortcutsWindow`, labels are used with the
 * .keycap style class.
 * If the label has a selection, it gets a subnode with name selection.
 * If the label has links, there is one subnode per link. These subnodes
 * carry the link or visited state depending on whether they have been
 * visited. In this case, label node also gets a .link style class.
 * ## GtkLabel as GtkBuildable
 * The GtkLabel implementation of the GtkBuildable interface supports a
 * custom `<attributes>` element, which supports any number of `<attribute>`
 * elements. The `<attribute>` element has attributes named “name“, “value“,
 * “start“ and “end“ and allows you to specify [Pango.Attribute]
 * values for this label.
 * An example of a UI definition fragment specifying Pango attributes:
 * ```xml
 * <object class\="GtkLabel">
 * <attributes>
 * <attribute name\="weight" value\="PANGO_WEIGHT_BOLD"/>
 * <attribute name\="background" value\="red" start\="5" end\="10"/>
 * </attributes>
 * </object>
 * ```
 * The start and end attributes specify the range of characters to which the
 * Pango attribute applies. If start and end are not specified, the attribute is
 * applied to the whole text. Note that specifying ranges does not make much
 * sense with translatable attributes. Use markup embedded in the translatable
 * content instead.
 * ## Accessibility
 * `GtkLabel` uses the %GTK_ACCESSIBLE_ROLE_LABEL role.
 * ## Mnemonics
 * Labels may contain “mnemonics”. Mnemonics are underlined characters in the
 * label, used for keyboard navigation. Mnemonics are created by providing a
 * string with an underscore before the mnemonic character, such as `"_File"`,
 * to the functions [Gtk.Label.newWithMnemonic] or
 * [Gtk.Label.setTextWithMnemonic].
 * Mnemonics automatically activate any activatable widget the label is
 * inside, such as a [Gtk.Button]; if the label is not inside the
 * mnemonic’s target widget, you have to tell the label about the target
 * using [Gtk.Label.setMnemonicWidget].
 * Here’s a simple example where the label is inside a button:
 * ```c
 * // Pressing Alt+H will activate this button
 * GtkWidget *button \= gtk_button_new $(LPAREN)$(RPAREN);
 * GtkWidget *label \= gtk_label_new_with_mnemonic $(LPAREN)"_Hello"$(RPAREN);
 * gtk_button_set_child $(LPAREN)GTK_BUTTON $(LPAREN)button$(RPAREN), label$(RPAREN);
 * ```
 * There’s a convenience function to create buttons with a mnemonic label
 * already inside:
 * ```c
 * // Pressing Alt+H will activate this button
 * GtkWidget *button \= gtk_button_new_with_mnemonic $(LPAREN)"_Hello"$(RPAREN);
 * ```
 * To create a mnemonic for a widget alongside the label, such as a
 * [Gtk.Entry], you have to point the label at the entry with
 * [Gtk.Label.setMnemonicWidget]:
 * ```c
 * // Pressing Alt+H will focus the entry
 * GtkWidget *entry \= gtk_entry_new $(LPAREN)$(RPAREN);
 * GtkWidget *label \= gtk_label_new_with_mnemonic $(LPAREN)"_Hello"$(RPAREN);
 * gtk_label_set_mnemonic_widget $(LPAREN)GTK_LABEL $(LPAREN)label$(RPAREN), entry$(RPAREN);
 * ```
 * ## Markup $(LPAREN)styled text$(RPAREN)
 * To make it easy to format text in a label $(LPAREN)changing colors,
 * fonts, etc.$(RPAREN), label text can be provided in a simple
 * markup format:
 * Here’s how to create a label with a small font:
 * ```c
 * GtkWidget *label \= gtk_label_new $(LPAREN)NULL$(RPAREN);
 * gtk_label_set_markup $(LPAREN)GTK_LABEL $(LPAREN)label$(RPAREN), "<small>Small text</small>"$(RPAREN);
 * ```
 * $(LPAREN)See the Pango manual for complete documentation] of available
 * tags, func@Pango.parse_markup$(RPAREN)
 * The markup passed to [Gtk.Label.setMarkup] must be valid; for example,
 * literal `<`, `>` and `&` characters must be escaped as `&lt;`, `&gt;`, and `&amp;`.
 * If you pass text obtained from the user, file, or a network to
 * [Gtk.Label.setMarkup], you’ll want to escape it with
 * func@GLib.markup_escape_text or func@GLib.markup_printf_escaped.
 * Markup strings are just a convenient way to set the [Pango.AttrList]
 * on a label; [Gtk.Label.setAttributes] may be a simpler way to set
 * attributes in some cases. Be careful though; [Pango.AttrList] tends
 * to cause internationalization problems, unless you’re applying attributes
 * to the entire string $(LPAREN)i.e. unless you set the range of each attribute
 * to [0, %G_MAXINT$(RPAREN)$(RPAREN). The reason is that specifying the start_index and
 * end_index for a [Pango.Attribute] requires knowledge of the exact
 * string being displayed, so translations will cause problems.
 * ## Selectable labels
 * Labels can be made selectable with [Gtk.Label.setSelectable].
 * Selectable labels allow the user to copy the label contents to
 * the clipboard. Only labels that contain useful-to-copy information—such
 * as error messages—should be made selectable.
 * ## Text layout
 * A label can contain any number of paragraphs, but will have
 * performance problems if it contains more than a small number.
 * Paragraphs are separated by newlines or other paragraph separators
 * understood by Pango.
 * Labels can automatically wrap text if you call [Gtk.Label.setWrap].
 * [Gtk.Label.setJustify] sets how the lines in a label align
 * with one another. If you want to set how the label as a whole aligns
 * in its available space, see the [Gtk.Widget.halign] and
 * [Gtk.Widget.valign] properties.
 * The property@Gtk.Label:width-chars and property@Gtk.Label:max-width-chars
 * properties can be used to control the size allocation of ellipsized or
 * wrapped labels. For ellipsizing labels, if either is specified $(LPAREN)and less
 * than the actual text size$(RPAREN), it is used as the minimum width, and the actual
 * text size is used as the natural width of the label. For wrapping labels,
 * width-chars is used as the minimum width, if specified, and max-width-chars
 * is used as the natural width. Even if max-width-chars specified, wrapping
 * labels will be rewrapped to use all of the available width.
 * ## Links
 * GTK supports markup for clickable hyperlinks in addition to regular Pango
 * markup. The markup for links is borrowed from HTML, using the `<a>` with
 * “href“, “title“ and “class“ attributes. GTK renders links similar to the
 * way they appear in web browsers, with colored, underlined text. The “title“
 * attribute is displayed as a tooltip on the link. The “class“ attribute is
 * used as style class on the CSS node for the link.
 * An example of inline links looks like this:
 * ```c
 * const char *text \=
 * "Go to the "
 * "<a href\=\"https://www.gtk.org\" title\=\"&lt;i&gt;Our&lt;/i&gt; website\">"
 * "GTK website</a> for more...";
 * GtkWidget *label \= gtk_label_new $(LPAREN)NULL$(RPAREN);
 * gtk_label_set_markup $(LPAREN)GTK_LABEL $(LPAREN)label$(RPAREN), text$(RPAREN);
 * ```
 * It is possible to implement custom handling for links and their tooltips
 * with the signal@Gtk.Label::activate-link signal and the
 * [Gtk.Label.getCurrentUri] function.
 */
class Label : Widget, AccessibleText
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_label_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleTextT!GtkLabel;

  /**
   * Creates a new label with the given text inside it.
   * You can pass %NULL to get an empty label widget.
   * Params:
   *   str = The text of the label
   * Returns: the new `GtkLabel`
   */
  this(string str)
  {
    GtkWidget* _cretval;
    const(char)* _str = str.toCString(false);
    _cretval = gtk_label_new(_str);
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkLabel`, containing the text in str.
   * If characters in str are preceded by an underscore, they are
   * underlined. If you need a literal underscore character in a label, use
   * '__' $(LPAREN)two underscores$(RPAREN). The first underlined character represents a
   * keyboard accelerator called a mnemonic. The mnemonic key can be used
   * to activate another widget, chosen automatically, or explicitly using
   * [Gtk.Label.setMnemonicWidget].
   * If [Gtk.Label.setMnemonicWidget] is not called, then the first
   * activatable ancestor of the `GtkLabel` will be chosen as the mnemonic
   * widget. For instance, if the label is inside a button or menu item,
   * the button or menu item will automatically become the mnemonic widget
   * and be activated by the mnemonic.
   * Params:
   *   str = The text of the label, with an underscore in front of the
   *     mnemonic character
   * Returns: the new `GtkLabel`
   */
  static Label newWithMnemonic(string str)
  {
    GtkWidget* _cretval;
    const(char)* _str = str.toCString(false);
    _cretval = gtk_label_new_with_mnemonic(_str);
    auto _retval = _cretval ? ObjectG.getDObject!Label(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the label's attribute list.
   * This is the [Pango.AttrList] that was set on the label using
   * [Gtk.Label.setAttributes], if any. This function does not
   * reflect attributes that come from the label's markup $(LPAREN)see
   * [Gtk.Label.setMarkup]$(RPAREN). If you want to get the effective
   * attributes for the label, use
   * `pango_layout_get_attributes $(LPAREN)gtk_label_get_layout $(LPAREN)self$(RPAREN)$(RPAREN)`.
   * Returns: the attribute list
   */
  AttrList getAttributes()
  {
    PangoAttrList* _cretval;
    _cretval = gtk_label_get_attributes(cast(GtkLabel*)cPtr);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the URI for the currently active link in the label.
   * The active link is the one under the mouse pointer or, in a
   * selectable label, the link in which the text cursor is currently
   * positioned.
   * This function is intended for use in a signalGtk.Label::activate-link
   * handler or for use in a signalGtk.Widget::query-tooltip handler.
   * Returns: the currently active URI
   */
  string getCurrentUri()
  {
    const(char)* _cretval;
    _cretval = gtk_label_get_current_uri(cast(GtkLabel*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the ellipsizing position of the label.
   * See [Gtk.Label.setEllipsize].
   * Returns: `PangoEllipsizeMode`
   */
  EllipsizeMode getEllipsize()
  {
    PangoEllipsizeMode _cretval;
    _cretval = gtk_label_get_ellipsize(cast(GtkLabel*)cPtr);
    EllipsizeMode _retval = cast(EllipsizeMode)_cretval;
    return _retval;
  }

  /**
   * Gets the extra menu model of label.
   * See [Gtk.Label.setExtraMenu].
   * Returns: the menu model
   */
  MenuModel getExtraMenu()
  {
    GMenuModel* _cretval;
    _cretval = gtk_label_get_extra_menu(cast(GtkLabel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the justification of the label.
   * See [Gtk.Label.setJustify].
   * Returns: `GtkJustification`
   */
  Justification getJustify()
  {
    GtkJustification _cretval;
    _cretval = gtk_label_get_justify(cast(GtkLabel*)cPtr);
    Justification _retval = cast(Justification)_cretval;
    return _retval;
  }

  /**
   * Fetches the text from a label.
   * The returned text includes any embedded underlines indicating
   * mnemonics and Pango markup. $(LPAREN)See [Gtk.Label.getText]$(RPAREN).
   * Returns: the text of the label widget. This string is
   *   owned by the widget and must not be modified or freed.
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_label_get_label(cast(GtkLabel*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the `PangoLayout` used to display the label.
   * The layout is useful to e.g. convert text positions to pixel
   * positions, in combination with [Gtk.Label.getLayoutOffsets].
   * The returned layout is owned by the label so need not be
   * freed by the caller. The label is free to recreate its layout
   * at any time, so it should be considered read-only.
   * Returns: the [Pango.Layout] for this label
   */
  Layout getLayout()
  {
    PangoLayout* _cretval;
    _cretval = gtk_label_get_layout(cast(GtkLabel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the coordinates where the label will draw its `PangoLayout`.
   * The coordinates are useful to convert mouse events into coordinates
   * inside the [Pango.Layout], e.g. to take some action if some part
   * of the label is clicked. Remember when using the [Pango.Layout]
   * functions you need to convert to and from pixels using PANGO_PIXELS$(LPAREN)$(RPAREN)
   * or [Pango.SCALE].
   * Params:
   *   x = location to store X offset of layout
   *   y = location to store Y offset of layout
   */
  void getLayoutOffsets(out int x, out int y)
  {
    gtk_label_get_layout_offsets(cast(GtkLabel*)cPtr, cast(int*)&x, cast(int*)&y);
  }

  /**
   * Gets the number of lines to which an ellipsized, wrapping
   * label should be limited.
   * See [Gtk.Label.setLines].
   * Returns: The number of lines
   */
  int getLines()
  {
    int _retval;
    _retval = gtk_label_get_lines(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the desired maximum width of label, in characters.
   * See [Gtk.Label.setWidthChars].
   * Returns: the maximum width of the label in characters.
   */
  int getMaxWidthChars()
  {
    int _retval;
    _retval = gtk_label_get_max_width_chars(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Return the mnemonic accelerator.
   * If the label has been set so that it has a mnemonic key this function
   * returns the keyval used for the mnemonic accelerator. If there is no
   * mnemonic set up it returns `GDK_KEY_VoidSymbol`.
   * Returns: GDK keyval usable for accelerators, or `GDK_KEY_VoidSymbol`
   */
  uint getMnemonicKeyval()
  {
    uint _retval;
    _retval = gtk_label_get_mnemonic_keyval(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the target of the mnemonic $(LPAREN)keyboard shortcut$(RPAREN) of this
   * label.
   * See [Gtk.Label.setMnemonicWidget].
   * Returns: the target of the label’s mnemonic,
   *   or %NULL if none has been set and the default algorithm will be used.
   */
  Widget getMnemonicWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_label_get_mnemonic_widget(cast(GtkLabel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns line wrap mode used by the label.
   * See [Gtk.Label.setNaturalWrapMode].
   * Returns: the natural line wrap mode
   */
  NaturalWrapMode getNaturalWrapMode()
  {
    GtkNaturalWrapMode _cretval;
    _cretval = gtk_label_get_natural_wrap_mode(cast(GtkLabel*)cPtr);
    NaturalWrapMode _retval = cast(NaturalWrapMode)_cretval;
    return _retval;
  }

  /**
   * Returns whether the label is selectable.
   * Returns: %TRUE if the user can copy text from the label
   */
  bool getSelectable()
  {
    bool _retval;
    _retval = gtk_label_get_selectable(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Gets the selected range of characters in the label.
   * Params:
   *   start = return location for start of selection, as a character offset
   *   end = return location for end of selection, as a character offset
   * Returns: %TRUE if selection is non-empty
   */
  bool getSelectionBounds(out int start, out int end)
  {
    bool _retval;
    _retval = gtk_label_get_selection_bounds(cast(GtkLabel*)cPtr, cast(int*)&start, cast(int*)&end);
    return _retval;
  }

  /**
   * Returns whether the label is in single line mode.
   * Returns: %TRUE when the label is in single line mode.
   */
  bool getSingleLineMode()
  {
    bool _retval;
    _retval = gtk_label_get_single_line_mode(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Gets the tabs for self.
   * The returned array will be %NULL if “standard” $(LPAREN)8-space$(RPAREN) tabs are used.
   * Free the return value with [Pango.TabArray.free].
   * Returns: copy of default tab array,
   *   or %NULL if standard tabs are used; must be freed with
   *   [Pango.TabArray.free].
   */
  TabArray getTabs()
  {
    PangoTabArray* _cretval;
    _cretval = gtk_label_get_tabs(cast(GtkLabel*)cPtr);
    auto _retval = _cretval ? new TabArray(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Fetches the text from a label.
   * The returned text is as it appears on screen. This does not include
   * any embedded underlines indicating mnemonics or Pango markup. $(LPAREN)See
   * [Gtk.Label.getLabel]$(RPAREN)
   * Returns: the text in the label widget. This is the internal
   *   string used by the label, and must not be modified.
   */
  string getText()
  {
    const(char)* _cretval;
    _cretval = gtk_label_get_text(cast(GtkLabel*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the label’s text is interpreted as Pango markup.
   * See [Gtk.Label.setUseMarkup].
   * Returns: %TRUE if the label’s text will be parsed for markup.
   */
  bool getUseMarkup()
  {
    bool _retval;
    _retval = gtk_label_get_use_markup(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Returns whether an embedded underlines in the label indicate mnemonics.
   * See [Gtk.Label.setUseUnderline].
   * Returns: %TRUE whether an embedded underline in the label indicates
   *   the mnemonic accelerator keys.
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_label_get_use_underline(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the desired width of label, in characters.
   * See [Gtk.Label.setWidthChars].
   * Returns: the width of the label in characters.
   */
  int getWidthChars()
  {
    int _retval;
    _retval = gtk_label_get_width_chars(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Returns whether lines in the label are automatically wrapped.
   * See [Gtk.Label.setWrap].
   * Returns: %TRUE if the lines of the label are automatically wrapped.
   */
  bool getWrap()
  {
    bool _retval;
    _retval = gtk_label_get_wrap(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Returns line wrap mode used by the label.
   * See [Gtk.Label.setWrapMode].
   * Returns: the line wrap mode
   */
  WrapMode getWrapMode()
  {
    PangoWrapMode _cretval;
    _cretval = gtk_label_get_wrap_mode(cast(GtkLabel*)cPtr);
    WrapMode _retval = cast(WrapMode)_cretval;
    return _retval;
  }

  /**
   * Gets the `xalign` of the label.
   * See the [Gtk.Label.xalign] property.
   * Returns: the xalign property
   */
  float getXalign()
  {
    float _retval;
    _retval = gtk_label_get_xalign(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Gets the `yalign` of the label.
   * See the [Gtk.Label.yalign] property.
   * Returns: the yalign property
   */
  float getYalign()
  {
    float _retval;
    _retval = gtk_label_get_yalign(cast(GtkLabel*)cPtr);
    return _retval;
  }

  /**
   * Selects a range of characters in the label, if the label is selectable.
   * See [Gtk.Label.setSelectable]. If the label is not selectable,
   * this function has no effect. If start_offset or
   * end_offset are -1, then the end of the label will be substituted.
   * Params:
   *   startOffset = start offset $(LPAREN)in characters not bytes$(RPAREN)
   *   endOffset = end offset $(LPAREN)in characters not bytes$(RPAREN)
   */
  void selectRegion(int startOffset, int endOffset)
  {
    gtk_label_select_region(cast(GtkLabel*)cPtr, startOffset, endOffset);
  }

  /**
   * Apply attributes to the label text.
   * The attributes set with this function will be applied and merged with
   * any other attributes previously effected by way of the
   * propertyGtk.Label:use-underline or propertyGtk.Label:use-markup
   * properties. While it is not recommended to mix markup strings with
   * manually set attributes, if you must; know that the attributes will
   * be applied to the label after the markup string is parsed.
   * Params:
   *   attrs = a [Pango.AttrList]
   */
  void setAttributes(AttrList attrs)
  {
    gtk_label_set_attributes(cast(GtkLabel*)cPtr, attrs ? cast(PangoAttrList*)attrs.cPtr(false) : null);
  }

  /**
   * Sets the mode used to ellipsize the text.
   * The text will be ellipsized if there is not enough space
   * to render the entire string.
   * Params:
   *   mode = a `PangoEllipsizeMode`
   */
  void setEllipsize(EllipsizeMode mode)
  {
    gtk_label_set_ellipsize(cast(GtkLabel*)cPtr, mode);
  }

  /**
   * Sets a menu model to add when constructing
   * the context menu for label.
   * Params:
   *   model = a `GMenuModel`
   */
  void setExtraMenu(MenuModel model)
  {
    gtk_label_set_extra_menu(cast(GtkLabel*)cPtr, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }

  /**
   * Sets the alignment of the lines in the text of the label relative to
   * each other.
   * %GTK_JUSTIFY_LEFT is the default value when the widget is first created
   * with [Gtk.Label.new_]. If you instead want to set the alignment of
   * the label as a whole, use [Gtk.Widget.setHalign] instead.
   * [Gtk.Label.setJustify] has no effect on labels containing
   * only a single line.
   * Params:
   *   jtype = a `GtkJustification`
   */
  void setJustify(Justification jtype)
  {
    gtk_label_set_justify(cast(GtkLabel*)cPtr, jtype);
  }

  /**
   * Sets the text of the label.
   * The label is interpreted as including embedded underlines and/or Pango
   * markup depending on the values of the propertyGtk.Label:use-underline
   * and propertyGtk.Label:use-markup properties.
   * Params:
   *   str = the new text to set for the label
   */
  void setLabel(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_label_set_label(cast(GtkLabel*)cPtr, _str);
  }

  /**
   * Sets the number of lines to which an ellipsized, wrapping label
   * should be limited.
   * This has no effect if the label is not wrapping or ellipsized.
   * Set this to -1 if you don’t want to limit the number of lines.
   * Params:
   *   lines = the desired number of lines, or -1
   */
  void setLines(int lines)
  {
    gtk_label_set_lines(cast(GtkLabel*)cPtr, lines);
  }

  /**
   * Sets the labels text and attributes from markup.
   * The string must be marked up with Pango markup
   * $(LPAREN)see funcPango.parse_markup$(RPAREN).
   * If the str is external data, you may need to escape it
   * with [GLib.Global.markupEscapeText] or [GLib.Global.markupPrintfEscaped]:
   * ```c
   * GtkWidget *self \= gtk_label_new $(LPAREN)NULL$(RPAREN);
   * const char *str \= "...";
   * const char *format \= "<span style\=\"italic\">\%s</span>";
   * char *markup;
   * markup \= g_markup_printf_escaped $(LPAREN)format, str$(RPAREN);
   * gtk_label_set_markup $(LPAREN)GTK_LABEL $(LPAREN)self$(RPAREN), markup$(RPAREN);
   * g_free $(LPAREN)markup$(RPAREN);
   * ```
   * This function will set the propertyGtk.Label:use-markup property
   * to %TRUE as a side effect.
   * If you set the label contents using the [Gtk.Label.label]
   * property you should also ensure that you set the
   * propertyGtk.Label:use-markup property accordingly.
   * See also: [Gtk.Label.setText]
   * Params:
   *   str = a markup string
   */
  void setMarkup(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_label_set_markup(cast(GtkLabel*)cPtr, _str);
  }

  /**
   * Sets the labels text, attributes and mnemonic from markup.
   * Parses str which is marked up with Pango markup $(LPAREN)see funcPango.parse_markup$(RPAREN),
   * setting the label’s text and attribute list based on the parse results.
   * If characters in str are preceded by an underscore, they are underlined
   * indicating that they represent a keyboard accelerator called a mnemonic.
   * The mnemonic key can be used to activate another widget, chosen
   * automatically, or explicitly using [Gtk.Label.setMnemonicWidget].
   * Params:
   *   str = a markup string
   */
  void setMarkupWithMnemonic(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_label_set_markup_with_mnemonic(cast(GtkLabel*)cPtr, _str);
  }

  /**
   * Sets the desired maximum width in characters of label to n_chars.
   * Params:
   *   nChars = the new desired maximum width, in characters.
   */
  void setMaxWidthChars(int nChars)
  {
    gtk_label_set_max_width_chars(cast(GtkLabel*)cPtr, nChars);
  }

  /**
   * Associate the label with its mnemonic target.
   * If the label has been set so that it has a mnemonic key $(LPAREN)using
   * i.e. [Gtk.Label.setMarkupWithMnemonic],
   * [Gtk.Label.setTextWithMnemonic],
   * [Gtk.Label.newWithMnemonic]
   * or the propertyGtk.Label:use_underline property$(RPAREN) the label can be
   * associated with a widget that is the target of the mnemonic. When the
   * label is inside a widget $(LPAREN)like a [Gtk.Button] or a
   * [Gtk.Notebook] tab$(RPAREN) it is automatically associated with the correct
   * widget, but sometimes $(LPAREN)i.e. when the target is a [Gtk.Entry] next to
   * the label$(RPAREN) you need to set it explicitly using this function.
   * The target widget will be accelerated by emitting the
   * signalGtk.Widget::mnemonic-activate signal on it. The default handler for
   * this signal will activate the widget if there are no mnemonic collisions
   * and toggle focus between the colliding widgets otherwise.
   * Params:
   *   widget = the target `GtkWidget`, or %NULL to unset
   */
  void setMnemonicWidget(Widget widget)
  {
    gtk_label_set_mnemonic_widget(cast(GtkLabel*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Select the line wrapping for the natural size request.
   * This only affects the natural size requested, for the actual wrapping used,
   * see the [Gtk.Label.wrap] property.
   * Params:
   *   wrapMode = the line wrapping mode
   */
  void setNaturalWrapMode(NaturalWrapMode wrapMode)
  {
    gtk_label_set_natural_wrap_mode(cast(GtkLabel*)cPtr, wrapMode);
  }

  /**
   * Makes text in the label selectable.
   * Selectable labels allow the user to select text from the label,
   * for copy-and-paste.
   * Params:
   *   setting = %TRUE to allow selecting text in the label
   */
  void setSelectable(bool setting)
  {
    gtk_label_set_selectable(cast(GtkLabel*)cPtr, setting);
  }

  /**
   * Sets whether the label is in single line mode.
   * Params:
   *   singleLineMode = %TRUE if the label should be in single line mode
   */
  void setSingleLineMode(bool singleLineMode)
  {
    gtk_label_set_single_line_mode(cast(GtkLabel*)cPtr, singleLineMode);
  }

  /**
   * Sets the default tab stops for paragraphs in self.
   * Params:
   *   tabs = tabs as a `PangoTabArray`
   */
  void setTabs(TabArray tabs)
  {
    gtk_label_set_tabs(cast(GtkLabel*)cPtr, tabs ? cast(PangoTabArray*)tabs.cPtr(false) : null);
  }

  /**
   * Sets the text within the `GtkLabel` widget.
   * It overwrites any text that was there before.
   * This function will clear any previously set mnemonic accelerators,
   * and set the propertyGtk.Label:use-underline property to %FALSE as
   * a side effect.
   * This function will set the propertyGtk.Label:use-markup property
   * to %FALSE as a side effect.
   * See also: [Gtk.Label.setMarkup]
   * Params:
   *   str = The text you want to set
   */
  void setText(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_label_set_text(cast(GtkLabel*)cPtr, _str);
  }

  /**
   * Sets the label’s text from the string str.
   * If characters in str are preceded by an underscore, they are underlined
   * indicating that they represent a keyboard accelerator called a mnemonic.
   * The mnemonic key can be used to activate another widget, chosen
   * automatically, or explicitly using [Gtk.Label.setMnemonicWidget].
   * Params:
   *   str = a string
   */
  void setTextWithMnemonic(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_label_set_text_with_mnemonic(cast(GtkLabel*)cPtr, _str);
  }

  /**
   * Sets whether the text of the label contains markup.
   * See [Gtk.Label.setMarkup].
   * Params:
   *   setting = %TRUE if the label’s text should be parsed for markup.
   */
  void setUseMarkup(bool setting)
  {
    gtk_label_set_use_markup(cast(GtkLabel*)cPtr, setting);
  }

  /**
   * Sets whether underlines in the text indicate mnemonics.
   * Params:
   *   setting = %TRUE if underlines in the text indicate mnemonics
   */
  void setUseUnderline(bool setting)
  {
    gtk_label_set_use_underline(cast(GtkLabel*)cPtr, setting);
  }

  /**
   * Sets the desired width in characters of label to n_chars.
   * Params:
   *   nChars = the new desired width, in characters.
   */
  void setWidthChars(int nChars)
  {
    gtk_label_set_width_chars(cast(GtkLabel*)cPtr, nChars);
  }

  /**
   * Toggles line wrapping within the `GtkLabel` widget.
   * %TRUE makes it break lines if text exceeds the widget’s size.
   * %FALSE lets the text get cut off by the edge of the widget if
   * it exceeds the widget size.
   * Note that setting line wrapping to %TRUE does not make the label
   * wrap at its parent container’s width, because GTK widgets
   * conceptually can’t make their requisition depend on the parent
   * container’s size. For a label that wraps at a specific position,
   * set the label’s width using [Gtk.Widget.setSizeRequest].
   * Params:
   *   wrap = the setting
   */
  void setWrap(bool wrap)
  {
    gtk_label_set_wrap(cast(GtkLabel*)cPtr, wrap);
  }

  /**
   * Controls how line wrapping is done.
   * This only affects the label if line wrapping is on. $(LPAREN)See
   * [Gtk.Label.setWrap]$(RPAREN) The default is %PANGO_WRAP_WORD
   * which means wrap on word boundaries.
   * For sizing behavior, also consider the propertyGtk.Label:natural-wrap-mode
   * property.
   * Params:
   *   wrapMode = the line wrapping mode
   */
  void setWrapMode(WrapMode wrapMode)
  {
    gtk_label_set_wrap_mode(cast(GtkLabel*)cPtr, wrapMode);
  }

  /**
   * Sets the `xalign` of the label.
   * See the [Gtk.Label.xalign] property.
   * Params:
   *   xalign = the new xalign value, between 0 and 1
   */
  void setXalign(float xalign)
  {
    gtk_label_set_xalign(cast(GtkLabel*)cPtr, xalign);
  }

  /**
   * Sets the `yalign` of the label.
   * See the [Gtk.Label.yalign] property.
   * Params:
   *   yalign = the new yalign value, between 0 and 1
   */
  void setYalign(float yalign)
  {
    gtk_label_set_yalign(cast(GtkLabel*)cPtr, yalign);
  }

  /**
   * Gets emitted when the user activates a link in the label.
   * The ::activate-current-link is a [keybinding signal](class.SignalAction.html).
   * Applications may also emit the signal with [GObject.DGObjectGlobal.signalEmitByName]
   * if they need to control activation of URIs programmatically.
   * The default bindings for this signal are all forms of the <kbd>Enter</kbd> key.
   *   label = the instance the signal is connected to
   */
  alias ActivateCurrentLinkCallback = void delegate(Label label);

  /**
   * Connect to ActivateCurrentLink signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivateCurrentLink(ActivateCurrentLinkCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto label = getVal!Label(_paramVals);
      _dgClosure.dlg(label);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-current-link", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Gets emitted to activate a URI.
   * Applications may connect to it to override the default behaviour,
   * which is to call [Gtk.FileLauncher.launch].
   * Params
   *   uri = the URI that is activated
   *   label = the instance the signal is connected to
   * Returns: %TRUE if the link has been activated
   */
  alias ActivateLinkCallback = bool delegate(string uri, Label label);

  /**
   * Connect to ActivateLink signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivateLink(ActivateLinkCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto label = getVal!Label(_paramVals);
      auto uri = getVal!string(&_paramVals[1]);
      _retval = _dgClosure.dlg(uri, label);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-link", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Gets emitted to copy the selection to the clipboard.
   * The ::copy-clipboard signal is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Ctrl</kbd>+<kbd>c</kbd>.
   *   label = the instance the signal is connected to
   */
  alias CopyClipboardCallback = void delegate(Label label);

  /**
   * Connect to CopyClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCopyClipboard(CopyClipboardCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto label = getVal!Label(_paramVals);
      _dgClosure.dlg(label);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("copy-clipboard", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Gets emitted when the user initiates a cursor movement.
   * The ::move-cursor signal is a [keybinding signal](class.SignalAction.html).
   * If the cursor is not visible in entry, this signal causes the viewport to
   * be moved instead.
   * Applications should not connect to it, but may emit it with
   * [GObject.DGObjectGlobal.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal come in two variants,
   * the variant with the Shift modifier extends the selection,
   * the variant without the Shift modifier does not.
   * There are too many key combinations to list them all here.
   * - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
   * move by individual characters/lines
   * - <kbd>Ctrl</kbd>+<kbd>←</kbd>, etc. move by words/paragraphs
   * - <kbd>Home</kbd> and <kbd>End</kbd> move to the ends of the buffer
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`
   *   count = the number of step units to move
   *   extendSelection = %TRUE if the move should extend the selection
   *   label = the instance the signal is connected to
   */
  alias MoveCursorCallback = void delegate(MovementStep step, int count, bool extendSelection, Label label);

  /**
   * Connect to MoveCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMoveCursor(MoveCursorCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto label = getVal!Label(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      auto extendSelection = getVal!bool(&_paramVals[3]);
      _dgClosure.dlg(step, count, extendSelection, label);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, (flags & ConnectFlags.After) != 0);
  }
}
