module Pango.Layout;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.SList;
import GObject.ObjectG;
import Gid.gid;
import Pango.AttrList;
import Pango.Context;
import Pango.FontDescription;
import Pango.LayoutIter;
import Pango.LayoutLine;
import Pango.TabArray;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoLayout` structure represents an entire paragraph of text.
 * While complete access to the layout capabilities of Pango is provided
 * using the detailed interfaces for itemization and shaping, using
 * that functionality directly involves writing a fairly large amount
 * of code. `PangoLayout` provides a high-level driver for formatting
 * entire paragraphs of text at once. This includes paragraph-level
 * functionality such as line breaking, justification, alignment and
 * ellipsization.
 * A `PangoLayout` is initialized with a `PangoContext`, UTF-8 string
 * and set of attributes for that string. Once that is done, the set of
 * formatted lines can be extracted from the object, the layout can be
 * rendered, and conversion between logical character positions within
 * the layout's text, and the physical position of the resulting glyphs
 * can be made.
 * There are a number of parameters to adjust the formatting of a
 * `PangoLayout`. The following image shows adjustable parameters
 * $(LPAREN)on the left$(RPAREN) and font metrics $(LPAREN)on the right$(RPAREN):
 * <picture>
 * <source srcset\="layout-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
 * <img alt\="Pango Layout Parameters" src\="layout-light.png">
 * </picture>
 * The following images demonstrate the effect of alignment and
 * justification on the layout of text:
 * | | |
 * | --- | --- |
 * | ![align\=left](align-left.png) | ![align\=left, justify](align-left-justify.png) |
 * | ![align\=center](align-center.png) | ![align\=center, justify](align-center-justify.png) |
 * | ![align\=right](align-right.png) | ![align\=right, justify](align-right-justify.png) |
 * It is possible, as well, to ignore the 2-D setup,
 * and simply treat the results of a `PangoLayout` as a list of lines.
 */
class Layout : ObjectG
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
    return pango_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `PangoLayout` object with attributes initialized to
   * default values for a particular `PangoContext`.
   * Params:
   *   context = a `PangoContext`
   * Returns: the newly allocated `PangoLayout`
   */
  this(Context context)
  {
    PangoLayout* _cretval;
    _cretval = pango_layout_new(context ? cast(PangoContext*)context.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Loads data previously created via [Pango.Layout.serialize].
   * For a discussion of the supported format, see that function.
   * Note: to verify that the returned layout is identical to
   * the one that was serialized, you can compare bytes to the
   * result of serializing the layout again.
   * Params:
   *   context = a `PangoContext`
   *   bytes = the bytes containing the data
   *   flags = `PangoLayoutDeserializeFlags`
   * Returns: a new `PangoLayout`
   */
  static Layout deserialize(Context context, Bytes bytes, LayoutDeserializeFlags flags)
  {
    PangoLayout* _cretval;
    GError *_err;
    _cretval = pango_layout_deserialize(context ? cast(PangoContext*)context.cPtr(false) : null, bytes ? cast(GBytes*)bytes.cPtr(false) : null, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Forces recomputation of any state in the `PangoLayout` that
   * might depend on the layout's context.
   * This function should be called if you make changes to the context
   * subsequent to creating the layout.
   */
  void contextChanged()
  {
    pango_layout_context_changed(cast(PangoLayout*)cPtr);
  }

  /**
   * Creates a deep copy-by-value of the layout.
   * The attribute list, tab array, and text from the original layout
   * are all copied by value.
   * Returns: the newly allocated `PangoLayout`
   */
  Layout copy()
  {
    PangoLayout* _cretval;
    _cretval = pango_layout_copy(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the alignment for the layout: how partial lines are
   * positioned within the horizontal space available.
   * Returns: the alignment
   */
  Alignment getAlignment()
  {
    PangoAlignment _cretval;
    _cretval = pango_layout_get_alignment(cast(PangoLayout*)cPtr);
    Alignment _retval = cast(Alignment)_cretval;
    return _retval;
  }

  /**
   * Gets the attribute list for the layout, if any.
   * Returns: a `PangoAttrList`
   */
  AttrList getAttributes()
  {
    PangoAttrList* _cretval;
    _cretval = pango_layout_get_attributes(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether to calculate the base direction for the layout
   * according to its contents.
   * See [Pango.Layout.setAutoDir].
   * Returns: %TRUE if the bidirectional base direction
   *   is computed from the layout's contents, %FALSE otherwise
   */
  bool getAutoDir()
  {
    bool _retval;
    _retval = pango_layout_get_auto_dir(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the Y position of baseline of the first line in layout.
   * Returns: baseline of first line, from top of layout
   */
  int getBaseline()
  {
    int _retval;
    _retval = pango_layout_get_baseline(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Given an index within a layout, determines the positions that of the
   * strong and weak cursors if the insertion point is at that index.
   * This is a variant of [Pango.Layout.getCursorPos] that applies
   * font metric information about caret slope and offset to the positions
   * it returns.
   * <picture>
   * <source srcset\="caret-metrics-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Caret metrics" src\="caret-metrics-light.png">
   * </picture>
   * Params:
   *   index = the byte index of the cursor
   *   strongPos = location to store the strong cursor position
   *   weakPos = location to store the weak cursor position
   */
  void getCaretPos(int index, out Rectangle strongPos, out Rectangle weakPos)
  {
    pango_layout_get_caret_pos(cast(PangoLayout*)cPtr, index, &strongPos, &weakPos);
  }

  /**
   * Returns the number of Unicode characters in the
   * the text of layout.
   * Returns: the number of Unicode characters
   *   in the text of layout
   */
  int getCharacterCount()
  {
    int _retval;
    _retval = pango_layout_get_character_count(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the `PangoContext` used for this layout.
   * Returns: the `PangoContext` for the layout
   */
  Context getContext()
  {
    PangoContext* _cretval;
    _cretval = pango_layout_get_context(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Given an index within a layout, determines the positions that of the
   * strong and weak cursors if the insertion point is at that index.
   * The position of each cursor is stored as a zero-width rectangle
   * with the height of the run extents.
   * <picture>
   * <source srcset\="cursor-positions-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Cursor positions" src\="cursor-positions-light.png">
   * </picture>
   * The strong cursor location is the location where characters of the
   * directionality equal to the base direction of the layout are inserted.
   * The weak cursor location is the location where characters of the
   * directionality opposite to the base direction of the layout are inserted.
   * The following example shows text with both a strong and a weak cursor.
   * <picture>
   * <source srcset\="split-cursor-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Strong and weak cursors" src\="split-cursor-light.png">
   * </picture>
   * The strong cursor has a little arrow pointing to the right, the weak
   * cursor to the left. Typing a 'c' in this situation will insert the
   * character after the 'b', and typing another Hebrew character, like 'ג',
   * will insert it at the end.
   * Params:
   *   index = the byte index of the cursor
   *   strongPos = location to store the strong cursor position
   *   weakPos = location to store the weak cursor position
   */
  void getCursorPos(int index, out Rectangle strongPos, out Rectangle weakPos)
  {
    pango_layout_get_cursor_pos(cast(PangoLayout*)cPtr, index, &strongPos, &weakPos);
  }

  /**
   * Gets the text direction at the given character position in layout.
   * Params:
   *   index = the byte index of the char
   * Returns: the text direction at index
   */
  Direction getDirection(int index)
  {
    PangoDirection _cretval;
    _cretval = pango_layout_get_direction(cast(PangoLayout*)cPtr, index);
    Direction _retval = cast(Direction)_cretval;
    return _retval;
  }

  /**
   * Gets the type of ellipsization being performed for layout.
   * See [Pango.Layout.setEllipsize].
   * Use [Pango.Layout.isEllipsized] to query whether any
   * paragraphs were actually ellipsized.
   * Returns: the current ellipsization mode for layout
   */
  EllipsizeMode getEllipsize()
  {
    PangoEllipsizeMode _cretval;
    _cretval = pango_layout_get_ellipsize(cast(PangoLayout*)cPtr);
    EllipsizeMode _retval = cast(EllipsizeMode)_cretval;
    return _retval;
  }

  /**
   * Computes the logical and ink extents of layout.
   * Logical extents are usually what you want for positioning things. Note
   * that both extents may have non-zero x and y. You may want to use those
   * to offset where you render the layout. Not doing that is a very typical
   * bug that shows up as right-to-left layouts not being correctly positioned
   * in a layout with a set width.
   * The extents are given in layout coordinates and in Pango units; layout
   * coordinates begin at the top left corner of the layout.
   * Params:
   *   inkRect = rectangle used to store the extents of the
   *     layout as drawn
   *   logicalRect = rectangle used to store the logical
   *     extents of the layout
   */
  void getExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_get_extents(cast(PangoLayout*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Gets the font description for the layout, if any.
   * Returns: a pointer to the
   *   layout's font description, or %NULL if the font description
   *   from the layout's context is inherited.
   */
  FontDescription getFontDescription()
  {
    const(PangoFontDescription)* _cretval;
    _cretval = pango_layout_get_font_description(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the height of layout used for ellipsization.
   * See [Pango.Layout.setHeight] for details.
   * Returns: the height, in Pango units if positive,
   *   or number of lines if negative.
   */
  int getHeight()
  {
    int _retval;
    _retval = pango_layout_get_height(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the paragraph indent width in Pango units.
   * A negative value indicates a hanging indentation.
   * Returns: the indent in Pango units
   */
  int getIndent()
  {
    int _retval;
    _retval = pango_layout_get_indent(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Returns an iterator to iterate over the visual extents of the layout.
   * Returns: the new `PangoLayoutIter`
   */
  LayoutIter getIter()
  {
    PangoLayoutIter* _cretval;
    _cretval = pango_layout_get_iter(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? new LayoutIter(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets whether each complete line should be stretched to fill the entire
   * width of the layout.
   * Returns: the justify value
   */
  bool getJustify()
  {
    bool _retval;
    _retval = pango_layout_get_justify(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the last line should be stretched
   * to fill the entire width of the layout.
   * Returns: the justify value
   */
  bool getJustifyLastLine()
  {
    bool _retval;
    _retval = pango_layout_get_justify_last_line(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Retrieves a particular line from a `PangoLayout`.
   * Use the faster [Pango.Layout.getLineReadonly] if you do not
   * plan to modify the contents of the line $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Params:
   *   line = the index of a line, which must be between 0 and
   *     `pango_layout_get_line_count$(LPAREN)layout$(RPAREN) - 1`, inclusive.
   * Returns: the requested `PangoLayoutLine`,
   *   or %NULL if the index is out of range. This layout line can be ref'ed
   *   and retained, but will become invalid if changes are made to the
   *   `PangoLayout`.
   */
  LayoutLine getLine(int line)
  {
    PangoLayoutLine* _cretval;
    _cretval = pango_layout_get_line(cast(PangoLayout*)cPtr, line);
    auto _retval = _cretval ? new LayoutLine(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the count of lines for the layout.
   * Returns: the line count
   */
  int getLineCount()
  {
    int _retval;
    _retval = pango_layout_get_line_count(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Retrieves a particular line from a `PangoLayout`.
   * This is a faster alternative to [Pango.Layout.getLine],
   * but the user is not expected to modify the contents of the line
   * $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Params:
   *   line = the index of a line, which must be between 0 and
   *     `pango_layout_get_line_count$(LPAREN)layout$(RPAREN) - 1`, inclusive.
   * Returns: the requested `PangoLayoutLine`,
   *   or %NULL if the index is out of range. This layout line can be ref'ed
   *   and retained, but will become invalid if changes are made to the
   *   `PangoLayout`. No changes should be made to the line.
   */
  LayoutLine getLineReadonly(int line)
  {
    PangoLayoutLine* _cretval;
    _cretval = pango_layout_get_line_readonly(cast(PangoLayout*)cPtr, line);
    auto _retval = _cretval ? new LayoutLine(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the line spacing factor of layout.
   * See [Pango.Layout.setLineSpacing].
   * Returns:
   */
  float getLineSpacing()
  {
    float _retval;
    _retval = pango_layout_get_line_spacing(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Returns the lines of the layout as a list.
   * Use the faster [Pango.Layout.getLinesReadonly] if you do not
   * plan to modify the contents of the lines $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Returns: a `GSList`
   *   containing the lines in the layout. This points to internal data of the
   *   `PangoLayout` and must be used with care. It will become invalid on any
   *   change to the layout's text or properties.
   */
  SList!(LayoutLine) getLines()
  {
    GSList* _cretval;
    _cretval = pango_layout_get_lines(cast(PangoLayout*)cPtr);
    SList!(LayoutLine) _retval = new SList!(LayoutLine)(cast(GSList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Returns the lines of the layout as a list.
   * This is a faster alternative to [Pango.Layout.getLines],
   * but the user is not expected to modify the contents of the lines
   * $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Returns: a `GSList`
   *   containing the lines in the layout. This points to internal data of the
   *   `PangoLayout` and must be used with care. It will become invalid on any
   *   change to the layout's text or properties. No changes should be made to
   *   the lines.
   */
  SList!(LayoutLine) getLinesReadonly()
  {
    GSList* _cretval;
    _cretval = pango_layout_get_lines_readonly(cast(PangoLayout*)cPtr);
    SList!(LayoutLine) _retval = new SList!(LayoutLine)(cast(GSList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Retrieves an array of logical attributes for each character in
   * the layout.
   * Params:
   *   attrs = location to store a pointer to an array of logical attributes.
   *     This value must be freed with [GLib.Global.gfree].
   */
  void getLogAttrs(out LogAttr[] attrs)
  {
    int _nAttrs;
    PangoLogAttr* _attrs;
    pango_layout_get_log_attrs(cast(PangoLayout*)cPtr, &_attrs, &_nAttrs);
    attrs = _attrs[0 .. _nAttrs];
    safeFree(cast(void*)_attrs);
  }

  /**
   * Retrieves an array of logical attributes for each character in
   * the layout.
   * This is a faster alternative to [Pango.Layout.getLogAttrs].
   * The returned array is part of layout and must not be modified.
   * Modifying the layout will invalidate the returned array.
   * The number of attributes returned in n_attrs will be one more
   * than the total number of characters in the layout, since there
   * need to be attributes corresponding to both the position before
   * the first character and the position after the last character.
   * Returns: an array of logical attributes
   */
  LogAttr[] getLogAttrsReadonly()
  {
    const(PangoLogAttr)* _cretval;
    int _cretlength;
    _cretval = pango_layout_get_log_attrs_readonly(cast(PangoLayout*)cPtr, &_cretlength);
    LogAttr[] _retval;

    if (_cretval)
    {
      _retval = new LogAttr[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i];
    }
    return _retval;
  }

  /**
   * Computes the logical and ink extents of layout in device units.
   * This function just calls [Pango.Layout.getExtents] followed by
   * two funcextents_to_pixels calls, rounding ink_rect and logical_rect
   * such that the rounded rectangles fully contain the unrounded one $(LPAREN)that is,
   * passes them as first argument to funcPango.extents_to_pixels$(RPAREN).
   * Params:
   *   inkRect = rectangle used to store the extents of the
   *     layout as drawn
   *   logicalRect = rectangle used to store the logical
   *     extents of the layout
   */
  void getPixelExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_get_pixel_extents(cast(PangoLayout*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Determines the logical width and height of a `PangoLayout` in device
   * units.
   * [Pango.Layout.getSize] returns the width and height
   * scaled by %PANGO_SCALE. This is simply a convenience function
   * around [Pango.Layout.getPixelExtents].
   * Params:
   *   width = location to store the logical width
   *   height = location to store the logical height
   */
  void getPixelSize(out int width, out int height)
  {
    pango_layout_get_pixel_size(cast(PangoLayout*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Returns the current serial number of layout.
   * The serial number is initialized to an small number larger than zero
   * when a new layout is created and is increased whenever the layout is
   * changed using any of the setter functions, or the `PangoContext` it
   * uses has changed. The serial may wrap, but will never have the value 0.
   * Since it can wrap, never compare it with "less than", always use "not equals".
   * This can be used to automatically detect changes to a `PangoLayout`,
   * and is useful for example to decide whether a layout needs redrawing.
   * To force the serial to be increased, use
   * [Pango.Layout.contextChanged].
   * Returns: The current serial number of layout.
   */
  uint getSerial()
  {
    uint _retval;
    _retval = pango_layout_get_serial(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Obtains whether layout is in single paragraph mode.
   * See [Pango.Layout.setSingleParagraphMode].
   * Returns: %TRUE if the layout does not break paragraphs
   *   at paragraph separator characters, %FALSE otherwise
   */
  bool getSingleParagraphMode()
  {
    bool _retval;
    _retval = pango_layout_get_single_paragraph_mode(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Determines the logical width and height of a `PangoLayout` in Pango
   * units.
   * This is simply a convenience function around [Pango.Layout.getExtents].
   * Params:
   *   width = location to store the logical width
   *   height = location to store the logical height
   */
  void getSize(out int width, out int height)
  {
    pango_layout_get_size(cast(PangoLayout*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Gets the amount of spacing between the lines of the layout.
   * Returns: the spacing in Pango units
   */
  int getSpacing()
  {
    int _retval;
    _retval = pango_layout_get_spacing(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the current `PangoTabArray` used by this layout.
   * If no `PangoTabArray` has been set, then the default tabs are
   * in use and %NULL is returned. Default tabs are every 8 spaces.
   * The return value should be freed with [Pango.TabArray.free].
   * Returns: a copy of the tabs for this layout
   */
  TabArray getTabs()
  {
    PangoTabArray* _cretval;
    _cretval = pango_layout_get_tabs(cast(PangoLayout*)cPtr);
    auto _retval = _cretval ? new TabArray(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the text in the layout.
   * The returned text should not be freed or modified.
   * Returns: the text in the layout
   */
  string getText()
  {
    const(char)* _cretval;
    _cretval = pango_layout_get_text(cast(PangoLayout*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Counts the number of unknown glyphs in layout.
   * This function can be used to determine if there are any fonts
   * available to render all characters in a certain string, or when
   * used in combination with %PANGO_ATTR_FALLBACK, to check if a
   * certain font supports all the characters in the string.
   * Returns: The number of unknown glyphs in layout
   */
  int getUnknownGlyphsCount()
  {
    int _retval;
    _retval = pango_layout_get_unknown_glyphs_count(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the width to which the lines of the `PangoLayout` should wrap.
   * Returns: the width in Pango units, or -1 if no width set.
   */
  int getWidth()
  {
    int _retval;
    _retval = pango_layout_get_width(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the wrap mode for the layout.
   * Use [Pango.Layout.isWrapped] to query whether
   * any paragraphs were actually wrapped.
   * Returns: active wrap mode.
   */
  WrapMode getWrap()
  {
    PangoWrapMode _cretval;
    _cretval = pango_layout_get_wrap(cast(PangoLayout*)cPtr);
    WrapMode _retval = cast(WrapMode)_cretval;
    return _retval;
  }

  /**
   * Converts from byte index_ within the layout to line and X position.
   * The X position is measured from the left edge of the line.
   * Params:
   *   index = the byte index of a grapheme within the layout
   *   trailing = an integer indicating the edge of the grapheme to retrieve the
   *     position of. If > 0, the trailing edge of the grapheme, if 0,
   *     the leading of the grapheme
   *   line = location to store resulting line index. $(LPAREN)which will
   *     between 0 and pango_layout_get_line_count$(LPAREN)layout$(RPAREN) - 1$(RPAREN)
   *   xPos = location to store resulting position within line
   *     $(LPAREN)%PANGO_SCALE units per device unit$(RPAREN)
   */
  void indexToLineX(int index, bool trailing, out int line, out int xPos)
  {
    pango_layout_index_to_line_x(cast(PangoLayout*)cPtr, index, trailing, cast(int*)&line, cast(int*)&xPos);
  }

  /**
   * Converts from an index within a `PangoLayout` to the onscreen position
   * corresponding to the grapheme at that index.
   * The returns is represented as rectangle. Note that `pos->x` is
   * always the leading edge of the grapheme and `pos->x + pos->width` the
   * trailing edge of the grapheme. If the directionality of the grapheme
   * is right-to-left, then `pos->width` will be negative.
   * Params:
   *   index = byte index within layout
   *   pos = rectangle in which to store the position of the grapheme
   */
  void indexToPos(int index, out Rectangle pos)
  {
    pango_layout_index_to_pos(cast(PangoLayout*)cPtr, index, &pos);
  }

  /**
   * Queries whether the layout had to ellipsize any paragraphs.
   * This returns %TRUE if the ellipsization mode for layout
   * is not %PANGO_ELLIPSIZE_NONE, a positive width is set on layout,
   * and there are paragraphs exceeding that width that have to be
   * ellipsized.
   * Returns: %TRUE if any paragraphs had to be ellipsized,
   *   %FALSE otherwise
   */
  bool isEllipsized()
  {
    bool _retval;
    _retval = pango_layout_is_ellipsized(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Queries whether the layout had to wrap any paragraphs.
   * This returns %TRUE if a positive width is set on layout,
   * ellipsization mode of layout is set to %PANGO_ELLIPSIZE_NONE,
   * and there are paragraphs exceeding the layout width that have
   * to be wrapped.
   * Returns: %TRUE if any paragraphs had to be wrapped, %FALSE
   *   otherwise
   */
  bool isWrapped()
  {
    bool _retval;
    _retval = pango_layout_is_wrapped(cast(PangoLayout*)cPtr);
    return _retval;
  }

  /**
   * Computes a new cursor position from an old position and a direction.
   * If direction is positive, then the new position will cause the strong
   * or weak cursor to be displayed one position to right of where it was
   * with the old cursor position. If direction is negative, it will be
   * moved to the left.
   * In the presence of bidirectional text, the correspondence between
   * logical and visual order will depend on the direction of the current
   * run, and there may be jumps when the cursor is moved off of the end
   * of a run.
   * Motion here is in cursor positions, not in characters, so a single
   * call to this function may move the cursor over multiple characters
   * when multiple characters combine to form a single grapheme.
   * Params:
   *   strong = whether the moving cursor is the strong cursor or the
   *     weak cursor. The strong cursor is the cursor corresponding
   *     to text insertion in the base direction for the layout.
   *   oldIndex = the byte index of the current cursor position
   *   oldTrailing = if 0, the cursor was at the leading edge of the
   *     grapheme indicated by old_index, if > 0, the cursor
   *     was at the trailing edge.
   *   direction = direction to move cursor. A negative
   *     value indicates motion to the left
   *   newIndex = location to store the new cursor byte index.
   *     A value of -1 indicates that the cursor has been moved off the
   *     beginning of the layout. A value of %G_MAXINT indicates that
   *     the cursor has been moved off the end of the layout.
   *   newTrailing = number of characters to move forward from
   *     the location returned for new_index to get the position where
   *     the cursor should be displayed. This allows distinguishing the
   *     position at the beginning of one line from the position at the
   *     end of the preceding line. new_index is always on the line where
   *     the cursor should be displayed.
   */
  void moveCursorVisually(bool strong, int oldIndex, int oldTrailing, int direction, out int newIndex, out int newTrailing)
  {
    pango_layout_move_cursor_visually(cast(PangoLayout*)cPtr, strong, oldIndex, oldTrailing, direction, cast(int*)&newIndex, cast(int*)&newTrailing);
  }

  /**
   * Serializes the layout for later deserialization via [Pango.Layout.deserialize].
   * There are no guarantees about the format of the output across different
   * versions of Pango and [Pango.Layout.deserialize] will reject data
   * that it cannot parse.
   * The intended use of this function is testing, benchmarking and debugging.
   * The format is not meant as a permanent storage format.
   * Params:
   *   flags = `PangoLayoutSerializeFlags`
   * Returns: a `GBytes` containing the serialized form of layout
   */
  Bytes serialize(LayoutSerializeFlags flags)
  {
    GBytes* _cretval;
    _cretval = pango_layout_serialize(cast(PangoLayout*)cPtr, flags);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the alignment for the layout: how partial lines are
   * positioned within the horizontal space available.
   * The default alignment is %PANGO_ALIGN_LEFT.
   * Params:
   *   alignment = the alignment
   */
  void setAlignment(Alignment alignment)
  {
    pango_layout_set_alignment(cast(PangoLayout*)cPtr, alignment);
  }

  /**
   * Sets the text attributes for a layout object.
   * References attrs, so the caller can unref its reference.
   * Params:
   *   attrs = a `PangoAttrList`
   */
  void setAttributes(AttrList attrs)
  {
    pango_layout_set_attributes(cast(PangoLayout*)cPtr, attrs ? cast(PangoAttrList*)attrs.cPtr(false) : null);
  }

  /**
   * Sets whether to calculate the base direction
   * for the layout according to its contents.
   * When this flag is on $(LPAREN)the default$(RPAREN), then paragraphs in layout that
   * begin with strong right-to-left characters $(LPAREN)Arabic and Hebrew principally$(RPAREN),
   * will have right-to-left layout, paragraphs with letters from other scripts
   * will have left-to-right layout. Paragraphs with only neutral characters
   * get their direction from the surrounding paragraphs.
   * When %FALSE, the choice between left-to-right and right-to-left
   * layout is done according to the base direction of the layout's
   * `PangoContext`. $(LPAREN)See [Pango.Context.setBaseDir]$(RPAREN).
   * When the auto-computed direction of a paragraph differs from the
   * base direction of the context, the interpretation of
   * %PANGO_ALIGN_LEFT and %PANGO_ALIGN_RIGHT are swapped.
   * Params:
   *   autoDir = if %TRUE, compute the bidirectional base direction
   *     from the layout's contents
   */
  void setAutoDir(bool autoDir)
  {
    pango_layout_set_auto_dir(cast(PangoLayout*)cPtr, autoDir);
  }

  /**
   * Sets the type of ellipsization being performed for layout.
   * Depending on the ellipsization mode ellipsize text is
   * removed from the start, middle, or end of text so they
   * fit within the width and height of layout set with
   * [Pango.Layout.setWidth] and [Pango.Layout.setHeight].
   * If the layout contains characters such as newlines that
   * force it to be layed out in multiple paragraphs, then whether
   * each paragraph is ellipsized separately or the entire layout
   * is ellipsized as a whole depends on the set height of the layout.
   * The default value is %PANGO_ELLIPSIZE_NONE.
   * See [Pango.Layout.setHeight] for details.
   * Params:
   *   ellipsize = the new ellipsization mode for layout
   */
  void setEllipsize(EllipsizeMode ellipsize)
  {
    pango_layout_set_ellipsize(cast(PangoLayout*)cPtr, ellipsize);
  }

  /**
   * Sets the default font description for the layout.
   * If no font description is set on the layout, the
   * font description from the layout's context is used.
   * Params:
   *   desc = the new `PangoFontDescription`
   *     to unset the current font description
   */
  void setFontDescription(FontDescription desc)
  {
    pango_layout_set_font_description(cast(PangoLayout*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null);
  }

  /**
   * Sets the height to which the `PangoLayout` should be ellipsized at.
   * There are two different behaviors, based on whether height is positive
   * or negative.
   * If height is positive, it will be the maximum height of the layout. Only
   * lines would be shown that would fit, and if there is any text omitted,
   * an ellipsis added. At least one line is included in each paragraph regardless
   * of how small the height value is. A value of zero will render exactly one
   * line for the entire layout.
   * If height is negative, it will be the $(LPAREN)negative of$(RPAREN) maximum number of lines
   * per paragraph. That is, the total number of lines shown may well be more than
   * this value if the layout contains multiple paragraphs of text.
   * The default value of -1 means that the first line of each paragraph is ellipsized.
   * This behavior may be changed in the future to act per layout instead of per
   * paragraph. File a bug against pango at
   * [https://gitlab.gnome.org/gnome/pango](https://gitlab.gnome.org/gnome/pango)
   * if your code relies on this behavior.
   * Height setting only has effect if a positive width is set on
   * layout and ellipsization mode of layout is not %PANGO_ELLIPSIZE_NONE.
   * The behavior is undefined if a height other than -1 is set and
   * ellipsization mode is set to %PANGO_ELLIPSIZE_NONE, and may change in the
   * future.
   * Params:
   *   height = the desired height of the layout in Pango units if positive,
   *     or desired number of lines if negative.
   */
  void setHeight(int height)
  {
    pango_layout_set_height(cast(PangoLayout*)cPtr, height);
  }

  /**
   * Sets the width in Pango units to indent each paragraph.
   * A negative value of indent will produce a hanging indentation.
   * That is, the first line will have the full width, and subsequent
   * lines will be indented by the absolute value of indent.
   * The indent setting is ignored if layout alignment is set to
   * %PANGO_ALIGN_CENTER.
   * The default value is 0.
   * Params:
   *   indent = the amount by which to indent
   */
  void setIndent(int indent)
  {
    pango_layout_set_indent(cast(PangoLayout*)cPtr, indent);
  }

  /**
   * Sets whether each complete line should be stretched to fill the
   * entire width of the layout.
   * Stretching is typically done by adding whitespace, but for some scripts
   * $(LPAREN)such as Arabic$(RPAREN), the justification may be done in more complex ways,
   * like extending the characters.
   * Note that this setting is not implemented and so is ignored in
   * Pango older than 1.18.
   * Note that tabs and justification conflict with each other:
   * Justification will move content away from its tab-aligned
   * positions.
   * The default value is %FALSE.
   * Also see [Pango.Layout.setJustifyLastLine].
   * Params:
   *   justify = whether the lines in the layout should be justified
   */
  void setJustify(bool justify)
  {
    pango_layout_set_justify(cast(PangoLayout*)cPtr, justify);
  }

  /**
   * Sets whether the last line should be stretched to fill the
   * entire width of the layout.
   * This only has an effect if [Pango.Layout.setJustify] has
   * been called as well.
   * The default value is %FALSE.
   * Params:
   *   justify = whether the last line in the layout should be justified
   */
  void setJustifyLastLine(bool justify)
  {
    pango_layout_set_justify_last_line(cast(PangoLayout*)cPtr, justify);
  }

  /**
   * Sets a factor for line spacing.
   * Typical values are: 0, 1, 1.5, 2. The default values is 0.
   * If factor is non-zero, lines are placed so that
   * baseline2 \= baseline1 + factor * height2
   * where height2 is the line height of the second line
   * $(LPAREN)as determined by the font$(LPAREN)s$(RPAREN)$(RPAREN). In this case, the spacing
   * set with [Pango.Layout.setSpacing] is ignored.
   * If factor is zero $(LPAREN)the default$(RPAREN), spacing is applied as before.
   * Note: for semantics that are closer to the CSS line-height
   * property, see funcPango.attr_line_height_new.
   * Params:
   *   factor = the new line spacing factor
   */
  void setLineSpacing(float factor)
  {
    pango_layout_set_line_spacing(cast(PangoLayout*)cPtr, factor);
  }

  /**
   * Sets the layout text and attribute list from marked-up text.
   * See [Pango Markup](pango_markup.html)$(RPAREN).
   * Replaces the current text and attribute list.
   * This is the same as [Pango.Layout.setMarkupWithAccel],
   * but the markup text isn't scanned for accelerators.
   * Params:
   *   markup = marked-up text
   *   length = length of marked-up text in bytes, or -1 if markup is
   *     `NUL`-terminated
   */
  void setMarkup(string markup, int length)
  {
    const(char)* _markup = markup.toCString(false);
    pango_layout_set_markup(cast(PangoLayout*)cPtr, _markup, length);
  }

  /**
   * Sets the layout text and attribute list from marked-up text.
   * See [Pango Markup](pango_markup.html)$(RPAREN).
   * Replaces the current text and attribute list.
   * If accel_marker is nonzero, the given character will mark the
   * character following it as an accelerator. For example, accel_marker
   * might be an ampersand or underscore. All characters marked
   * as an accelerator will receive a %PANGO_UNDERLINE_LOW attribute,
   * and the first character so marked will be returned in accel_char.
   * Two accel_marker characters following each other produce a single
   * literal accel_marker character.
   * Params:
   *   markup = marked-up text $(LPAREN)see [Pango Markup](pango_markup.html)$(RPAREN)
   *   length = length of marked-up text in bytes, or -1 if markup is
   *     `NUL`-terminated
   *   accelMarker = marker for accelerators in the text
   *   accelChar = return location
   *     for first located accelerator
   */
  void setMarkupWithAccel(string markup, int length, dchar accelMarker, out dchar accelChar)
  {
    const(char)* _markup = markup.toCString(false);
    pango_layout_set_markup_with_accel(cast(PangoLayout*)cPtr, _markup, length, accelMarker, cast(dchar*)&accelChar);
  }

  /**
   * Sets the single paragraph mode of layout.
   * If setting is %TRUE, do not treat newlines and similar characters
   * as paragraph separators; instead, keep all text in a single paragraph,
   * and display a glyph for paragraph separator characters. Used when
   * you want to allow editing of newlines on a single text line.
   * The default value is %FALSE.
   * Params:
   *   setting = new setting
   */
  void setSingleParagraphMode(bool setting)
  {
    pango_layout_set_single_paragraph_mode(cast(PangoLayout*)cPtr, setting);
  }

  /**
   * Sets the amount of spacing in Pango units between
   * the lines of the layout.
   * When placing lines with spacing, Pango arranges things so that
   * line2.top \= line1.bottom + spacing
   * The default value is 0.
   * Note: Since 1.44, Pango is using the line height $(LPAREN)as determined
   * by the font$(RPAREN) for placing lines when the line spacing factor is set
   * to a non-zero value with [Pango.Layout.setLineSpacing].
   * In that case, the spacing set with this function is ignored.
   * Note: for semantics that are closer to the CSS line-height
   * property, see funcPango.attr_line_height_new.
   * Params:
   *   spacing = the amount of spacing
   */
  void setSpacing(int spacing)
  {
    pango_layout_set_spacing(cast(PangoLayout*)cPtr, spacing);
  }

  /**
   * Sets the tabs to use for layout, overriding the default tabs.
   * `PangoLayout` will place content at the next tab position
   * whenever it meets a Tab character $(LPAREN)U+0009$(RPAREN).
   * By default, tabs are every 8 spaces. If tabs is %NULL, the
   * default tabs are reinstated. tabs is copied into the layout;
   * you must free your copy of tabs yourself.
   * Note that tabs and justification conflict with each other:
   * Justification will move content away from its tab-aligned
   * positions. The same is true for alignments other than
   * %PANGO_ALIGN_LEFT.
   * Params:
   *   tabs = a `PangoTabArray`
   */
  void setTabs(TabArray tabs)
  {
    pango_layout_set_tabs(cast(PangoLayout*)cPtr, tabs ? cast(PangoTabArray*)tabs.cPtr(false) : null);
  }

  /**
   * Sets the text of the layout.
   * This function validates text and renders invalid UTF-8
   * with a placeholder glyph.
   * Note that if you have used [Pango.Layout.setMarkup] or
   * [Pango.Layout.setMarkupWithAccel] on layout before, you
   * may want to call [Pango.Layout.setAttributes] to clear the
   * attributes set on the layout from the markup as this function does
   * not clear attributes.
   * Params:
   *   text = the text
   */
  void setText(string text)
  {
    int _length;
    if (text)
      _length = cast(int)text.length;

    auto _text = cast(char*)text.ptr;
    pango_layout_set_text(cast(PangoLayout*)cPtr, _text, _length);
  }

  /**
   * Sets the width to which the lines of the `PangoLayout` should wrap or
   * ellipsized.
   * The default value is -1: no width set.
   * Params:
   *   width = the desired width in Pango units, or -1 to indicate that no
   *     wrapping or ellipsization should be performed.
   */
  void setWidth(int width)
  {
    pango_layout_set_width(cast(PangoLayout*)cPtr, width);
  }

  /**
   * Sets the wrap mode.
   * The wrap mode only has effect if a width is set on the layout
   * with [Pango.Layout.setWidth]. To turn off wrapping,
   * set the width to -1.
   * The default value is %PANGO_WRAP_WORD.
   * Params:
   *   wrap = the wrap mode
   */
  void setWrap(WrapMode wrap)
  {
    pango_layout_set_wrap(cast(PangoLayout*)cPtr, wrap);
  }

  /**
   * A convenience method to serialize a layout to a file.
   * It is equivalent to calling [Pango.Layout.serialize]
   * followed by funcGLib.file_set_contents.
   * See those two functions for details on the arguments.
   * It is mostly intended for use inside a debugger to quickly dump
   * a layout to a file for later inspection.
   * Params:
   *   flags = `PangoLayoutSerializeFlags`
   *   filename = the file to save it to
   * Returns: %TRUE if saving was successful
   */
  bool writeToFile(LayoutSerializeFlags flags, string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = pango_layout_write_to_file(cast(PangoLayout*)cPtr, flags, _filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Converts from X and Y position within a layout to the byte index to the
   * character at that logical position.
   * If the Y position is not inside the layout, the closest position is
   * chosen $(LPAREN)the position will be clamped inside the layout$(RPAREN). If the X position
   * is not within the layout, then the start or the end of the line is
   * chosen as described for [Pango.LayoutLine.xToIndex]. If either
   * the X or Y positions were not inside the layout, then the function returns
   * %FALSE; on an exact hit, it returns %TRUE.
   * Params:
   *   x = the X offset $(LPAREN)in Pango units$(RPAREN) from the left edge of the layout
   *   y = the Y offset $(LPAREN)in Pango units$(RPAREN) from the top edge of the layout
   *   index = location to store calculated byte index
   *   trailing = location to store a integer indicating where
   *     in the grapheme the user clicked. It will either be zero, or the
   *     number of characters in the grapheme. 0 represents the leading edge
   *     of the grapheme.
   * Returns: %TRUE if the coordinates were inside text, %FALSE otherwise
   */
  bool xyToIndex(int x, int y, out int index, out int trailing)
  {
    bool _retval;
    _retval = pango_layout_xy_to_index(cast(PangoLayout*)cPtr, x, y, cast(int*)&index, cast(int*)&trailing);
    return _retval;
  }
}
