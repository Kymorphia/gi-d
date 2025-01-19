module Gtk.TextView;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Event;
import Gdk.Rectangle;
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
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.TextBuffer;
import Gtk.TextChildAnchor;
import Gtk.TextIter;
import Gtk.TextMark;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.Context;
import Pango.TabArray;

/**
 * A widget that displays the contents of a [Gtk.TextBuffer].
 * ![An example GtkTextview](multiline-text.png)
 * You may wish to begin by reading the [conceptual overview](section-text-widget.html),
 * which gives an overview of all the objects and data types related to the
 * text widget and how they work together.
 * ## CSS nodes
 * ```
 * textview.view
 * ├── border.top
 * ├── border.left
 * ├── text
 * │   ╰── [selection]
 * ├── border.right
 * ├── border.bottom
 * ╰── [window.popup]
 * ```
 * `GtkTextView` has a main css node with name textview and style class .view,
 * and subnodes for each of the border windows, and the main text area,
 * with names border and text, respectively. The border nodes each get
 * one of the style classes .left, .right, .top or .bottom.
 * A node representing the selection will appear below the text node.
 * If a context menu is opened, the window node will appear as a subnode
 * of the main node.
 * ## Accessibility
 * `GtkTextView` uses the %GTK_ACCESSIBLE_ROLE_TEXT_BOX role.
 */
class TextView : Widget, AccessibleText, Scrollable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_text_view_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleTextT!();
  mixin ScrollableT!();

  /**
   * Creates a new `GtkTextView`.
   * If you don’t call [Gtk.TextView.setBuffer] before using the
   * text view, an empty default buffer will be created for you. Get the
   * buffer with [Gtk.TextView.getBuffer]. If you want to specify
   * your own buffer, consider [Gtk.TextView.newWithBuffer].
   * Returns: a new `GtkTextView`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_text_view_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkTextView` widget displaying the buffer buffer.
   * One buffer can be shared among many widgets. buffer may be %NULL
   * to create a default buffer, in which case this function is equivalent
   * to [Gtk.TextView.new_]. The text view adds its own reference count
   * to the buffer; it does not take over an existing reference.
   * Params:
   *   buffer = a `GtkTextBuffer`
   * Returns: a new `GtkTextView`.
   */
  static TextView newWithBuffer(TextBuffer buffer)
  {
    GtkWidget* _cretval;
    _cretval = gtk_text_view_new_with_buffer(buffer ? cast(GtkTextBuffer*)buffer.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!TextView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a child widget in the text buffer, at the given anchor.
   * Params:
   *   child = a `GtkWidget`
   *   anchor = a `GtkTextChildAnchor` in the `GtkTextBuffer` for text_view
   */
  void addChildAtAnchor(Widget child, TextChildAnchor anchor)
  {
    gtk_text_view_add_child_at_anchor(cast(GtkTextView*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, anchor ? cast(GtkTextChildAnchor*)anchor.cPtr(false) : null);
  }

  /**
   * Adds child at a fixed coordinate in the `GtkTextView`'s text window.
   * The xpos and ypos must be in buffer coordinates $(LPAREN)see
   * [Gtk.TextView.getIterLocation] to convert to
   * buffer coordinates$(RPAREN).
   * child will scroll with the text view.
   * If instead you want a widget that will not move with the
   * `GtkTextView` contents see `GtkOverlay`.
   * Params:
   *   child = a `GtkWidget`
   *   xpos = X position of child in window coordinates
   *   ypos = Y position of child in window coordinates
   */
  void addOverlay(Widget child, int xpos, int ypos)
  {
    gtk_text_view_add_overlay(cast(GtkTextView*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, xpos, ypos);
  }

  /**
   * Moves the given iter backward by one display $(LPAREN)wrapped$(RPAREN) line.
   * A display line is different from a paragraph. Paragraphs are
   * separated by newlines or other paragraph separator characters.
   * Display lines are created by line-wrapping a paragraph. If
   * wrapping is turned off, display lines and paragraphs will be the
   * same. Display lines are divided differently for each view, since
   * they depend on the view’s width; paragraphs are the same in all
   * views, since they depend on the contents of the `GtkTextBuffer`.
   * Params:
   *   iter = a `GtkTextIter`
   * Returns: %TRUE if iter was moved and is not on the end iterator
   */
  bool backwardDisplayLine(TextIter iter)
  {
    bool _retval;
    _retval = gtk_text_view_backward_display_line(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves the given iter backward to the next display line start.
   * A display line is different from a paragraph. Paragraphs are
   * separated by newlines or other paragraph separator characters.
   * Display lines are created by line-wrapping a paragraph. If
   * wrapping is turned off, display lines and paragraphs will be the
   * same. Display lines are divided differently for each view, since
   * they depend on the view’s width; paragraphs are the same in all
   * views, since they depend on the contents of the `GtkTextBuffer`.
   * Params:
   *   iter = a `GtkTextIter`
   * Returns: %TRUE if iter was moved and is not on the end iterator
   */
  bool backwardDisplayLineStart(TextIter iter)
  {
    bool _retval;
    _retval = gtk_text_view_backward_display_line_start(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Converts buffer coordinates to window coordinates.
   * Params:
   *   win = a `GtkTextWindowType`
   *   bufferX = buffer x coordinate
   *   bufferY = buffer y coordinate
   *   windowX = window x coordinate return location
   *   windowY = window y coordinate return location
   */
  void bufferToWindowCoords(TextWindowType win, int bufferX, int bufferY, out int windowX, out int windowY)
  {
    gtk_text_view_buffer_to_window_coords(cast(GtkTextView*)cPtr, win, bufferX, bufferY, cast(int*)&windowX, cast(int*)&windowY);
  }

  /**
   * Moves the given iter forward by one display $(LPAREN)wrapped$(RPAREN) line.
   * A display line is different from a paragraph. Paragraphs are
   * separated by newlines or other paragraph separator characters.
   * Display lines are created by line-wrapping a paragraph. If
   * wrapping is turned off, display lines and paragraphs will be the
   * same. Display lines are divided differently for each view, since
   * they depend on the view’s width; paragraphs are the same in all
   * views, since they depend on the contents of the `GtkTextBuffer`.
   * Params:
   *   iter = a `GtkTextIter`
   * Returns: %TRUE if iter was moved and is not on the end iterator
   */
  bool forwardDisplayLine(TextIter iter)
  {
    bool _retval;
    _retval = gtk_text_view_forward_display_line(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves the given iter forward to the next display line end.
   * A display line is different from a paragraph. Paragraphs are
   * separated by newlines or other paragraph separator characters.
   * Display lines are created by line-wrapping a paragraph. If
   * wrapping is turned off, display lines and paragraphs will be the
   * same. Display lines are divided differently for each view, since
   * they depend on the view’s width; paragraphs are the same in all
   * views, since they depend on the contents of the `GtkTextBuffer`.
   * Params:
   *   iter = a `GtkTextIter`
   * Returns: %TRUE if iter was moved and is not on the end iterator
   */
  bool forwardDisplayLineEnd(TextIter iter)
  {
    bool _retval;
    _retval = gtk_text_view_forward_display_line_end(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns whether pressing the <kbd>Tab</kbd> key inserts a tab characters.
   * See [Gtk.TextView.setAcceptsTab].
   * Returns: %TRUE if pressing the Tab key inserts a tab character,
   *   %FALSE if pressing the Tab key moves the keyboard focus.
   */
  bool getAcceptsTab()
  {
    bool _retval;
    _retval = gtk_text_view_get_accepts_tab(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the bottom margin for text in the text_view.
   * Returns: bottom margin in pixels
   */
  int getBottomMargin()
  {
    int _retval;
    _retval = gtk_text_view_get_bottom_margin(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Returns the `GtkTextBuffer` being displayed by this text view.
   * The reference count on the buffer is not incremented; the caller
   * of this function won’t own a new reference.
   * Returns: a `GtkTextBuffer`
   */
  TextBuffer getBuffer()
  {
    GtkTextBuffer* _cretval;
    _cretval = gtk_text_view_get_buffer(cast(GtkTextView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextBuffer(cast(GtkTextBuffer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determine the positions of the strong and weak cursors if the
   * insertion point is at iter.
   * The position of each cursor is stored as a zero-width rectangle.
   * The strong cursor location is the location where characters of
   * the directionality equal to the base direction of the paragraph
   * are inserted. The weak cursor location is the location where
   * characters of the directionality opposite to the base direction
   * of the paragraph are inserted.
   * If iter is %NULL, the actual cursor position is used.
   * Note that if iter happens to be the actual cursor position, and
   * there is currently an IM preedit sequence being entered, the
   * returned locations will be adjusted to account for the preedit
   * cursor’s offset within the preedit sequence.
   * The rectangle position is in buffer coordinates; use
   * [Gtk.TextView.bufferToWindowCoords] to convert these
   * coordinates to coordinates for one of the windows in the text view.
   * Params:
   *   iter = a `GtkTextIter`
   *   strong = location to store the strong cursor position
   *   weak = location to store the weak cursor position
   */
  void getCursorLocations(TextIter iter, out Rectangle strong, out Rectangle weak)
  {
    GdkRectangle _strong;
    GdkRectangle _weak;
    gtk_text_view_get_cursor_locations(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, &_strong, &_weak);
    strong = new Rectangle(cast(void*)&_strong, false);
    weak = new Rectangle(cast(void*)&_weak, false);
  }

  /**
   * Find out whether the cursor should be displayed.
   * Returns: whether the insertion mark is visible
   */
  bool getCursorVisible()
  {
    bool _retval;
    _retval = gtk_text_view_get_cursor_visible(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Returns the default editability of the `GtkTextView`.
   * Tags in the buffer may override this setting for some ranges of text.
   * Returns: whether text is editable by default
   */
  bool getEditable()
  {
    bool _retval;
    _retval = gtk_text_view_get_editable(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the menu model that gets added to the context menu
   * or %NULL if none has been set.
   * Returns: the menu model
   */
  MenuModel getExtraMenu()
  {
    GMenuModel* _cretval;
    _cretval = gtk_text_view_get_extra_menu(cast(GtkTextView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a `GtkWidget` that has previously been set as gutter.
   * See [Gtk.TextView.setGutter].
   * win must be one of %GTK_TEXT_WINDOW_LEFT, %GTK_TEXT_WINDOW_RIGHT,
   * %GTK_TEXT_WINDOW_TOP, or %GTK_TEXT_WINDOW_BOTTOM.
   * Params:
   *   win = a `GtkTextWindowType`
   * Returns: a `GtkWidget`
   */
  Widget getGutter(TextWindowType win)
  {
    GtkWidget* _cretval;
    _cretval = gtk_text_view_get_gutter(cast(GtkTextView*)cPtr, win);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the default indentation of paragraphs in text_view.
   * Tags in the view’s buffer may override the default.
   * The indentation may be negative.
   * Returns: number of pixels of indentation
   */
  int getIndent()
  {
    int _retval;
    _retval = gtk_text_view_get_indent(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the `input-hints` of the `GtkTextView`.
   * Returns:
   */
  InputHints getInputHints()
  {
    GtkInputHints _cretval;
    _cretval = gtk_text_view_get_input_hints(cast(GtkTextView*)cPtr);
    InputHints _retval = cast(InputHints)_cretval;
    return _retval;
  }

  /**
   * Gets the `input-purpose` of the `GtkTextView`.
   * Returns:
   */
  InputPurpose getInputPurpose()
  {
    GtkInputPurpose _cretval;
    _cretval = gtk_text_view_get_input_purpose(cast(GtkTextView*)cPtr);
    InputPurpose _retval = cast(InputPurpose)_cretval;
    return _retval;
  }

  /**
   * Retrieves the iterator at buffer coordinates x and y.
   * Buffer coordinates are coordinates for the entire buffer, not just
   * the currently-displayed portion. If you have coordinates from an
   * event, you have to convert those to buffer coordinates with
   * [Gtk.TextView.windowToBufferCoords].
   * Params:
   *   iter = a `GtkTextIter`
   *   x = x position, in buffer coordinates
   *   y = y position, in buffer coordinates
   * Returns: %TRUE if the position is over text
   */
  bool getIterAtLocation(out TextIter iter, int x, int y)
  {
    bool _retval;
    GtkTextIter _iter;
    _retval = gtk_text_view_get_iter_at_location(cast(GtkTextView*)cPtr, &_iter, x, y);
    iter = new TextIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Retrieves the iterator pointing to the character at buffer
   * coordinates x and y.
   * Buffer coordinates are coordinates for the entire buffer, not just
   * the currently-displayed portion. If you have coordinates from an event,
   * you have to convert those to buffer coordinates with
   * [Gtk.TextView.windowToBufferCoords].
   * Note that this is different from [Gtk.TextView.getIterAtLocation],
   * which returns cursor locations, i.e. positions between characters.
   * Params:
   *   iter = a `GtkTextIter`
   *   trailing = if non-%NULL, location to store
   *     an integer indicating where in the grapheme the user clicked.
   *     It will either be zero, or the number of characters in the grapheme.
   *     0 represents the trailing edge of the grapheme.
   *   x = x position, in buffer coordinates
   *   y = y position, in buffer coordinates
   * Returns: %TRUE if the position is over text
   */
  bool getIterAtPosition(out TextIter iter, out int trailing, int x, int y)
  {
    bool _retval;
    GtkTextIter _iter;
    _retval = gtk_text_view_get_iter_at_position(cast(GtkTextView*)cPtr, &_iter, cast(int*)&trailing, x, y);
    iter = new TextIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Gets a rectangle which roughly contains the character at iter.
   * The rectangle position is in buffer coordinates; use
   * [Gtk.TextView.bufferToWindowCoords] to convert these
   * coordinates to coordinates for one of the windows in the text view.
   * Params:
   *   iter = a `GtkTextIter`
   *   location = bounds of the character at iter
   */
  void getIterLocation(TextIter iter, out Rectangle location)
  {
    GdkRectangle _location;
    gtk_text_view_get_iter_location(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, &_location);
    location = new Rectangle(cast(void*)&_location, false);
  }

  /**
   * Gets the default justification of paragraphs in text_view.
   * Tags in the buffer may override the default.
   * Returns: default justification
   */
  Justification getJustification()
  {
    GtkJustification _cretval;
    _cretval = gtk_text_view_get_justification(cast(GtkTextView*)cPtr);
    Justification _retval = cast(Justification)_cretval;
    return _retval;
  }

  /**
   * Gets the default left margin size of paragraphs in the text_view.
   * Tags in the buffer may override the default.
   * Returns: left margin in pixels
   */
  int getLeftMargin()
  {
    int _retval;
    _retval = gtk_text_view_get_left_margin(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GtkTextIter` at the start of the line containing
   * the coordinate y.
   * y is in buffer coordinates, convert from window coordinates with
   * [Gtk.TextView.windowToBufferCoords]. If non-%NULL,
   * line_top will be filled with the coordinate of the top edge
   * of the line.
   * Params:
   *   targetIter = a `GtkTextIter`
   *   y = a y coordinate
   *   lineTop = return location for top coordinate of the line
   */
  void getLineAtY(out TextIter targetIter, int y, out int lineTop)
  {
    GtkTextIter _targetIter;
    gtk_text_view_get_line_at_y(cast(GtkTextView*)cPtr, &_targetIter, y, cast(int*)&lineTop);
    targetIter = new TextIter(cast(void*)&_targetIter, false);
  }

  /**
   * Gets the y coordinate of the top of the line containing iter,
   * and the height of the line.
   * The coordinate is a buffer coordinate; convert to window
   * coordinates with [Gtk.TextView.bufferToWindowCoords].
   * Params:
   *   iter = a `GtkTextIter`
   *   y = return location for a y coordinate
   *   height = return location for a height
   */
  void getLineYrange(TextIter iter, out int y, out int height)
  {
    gtk_text_view_get_line_yrange(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, cast(int*)&y, cast(int*)&height);
  }

  /**
   * Gets the `PangoContext` that is used for rendering LTR directed
   * text layouts.
   * The context may be replaced when CSS changes occur.
   * Returns: a `PangoContext`
   */
  Context getLtrContext()
  {
    PangoContext* _cretval;
    _cretval = gtk_text_view_get_ltr_context(cast(GtkTextView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the `GtkTextView` uses monospace styling.
   * Returns: %TRUE if monospace fonts are desired
   */
  bool getMonospace()
  {
    bool _retval;
    _retval = gtk_text_view_get_monospace(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the `GtkTextView` is in overwrite mode or not.
   * Returns: whether text_view is in overwrite mode or not.
   */
  bool getOverwrite()
  {
    bool _retval;
    _retval = gtk_text_view_get_overwrite(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the default number of pixels to put above paragraphs.
   * Adding this function with [Gtk.TextView.getPixelsBelowLines]
   * is equal to the line space between each paragraph.
   * Returns: default number of pixels above paragraphs
   */
  int getPixelsAboveLines()
  {
    int _retval;
    _retval = gtk_text_view_get_pixels_above_lines(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the default number of pixels to put below paragraphs.
   * The line space is the sum of the value returned by this function and
   * the value returned by [Gtk.TextView.getPixelsAboveLines].
   * Returns: default number of blank pixels below paragraphs
   */
  int getPixelsBelowLines()
  {
    int _retval;
    _retval = gtk_text_view_get_pixels_below_lines(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the default number of pixels to put between wrapped lines
   * inside a paragraph.
   * Returns: default number of pixels of blank space between wrapped lines
   */
  int getPixelsInsideWrap()
  {
    int _retval;
    _retval = gtk_text_view_get_pixels_inside_wrap(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the default right margin for text in text_view.
   * Tags in the buffer may override the default.
   * Returns: right margin in pixels
   */
  int getRightMargin()
  {
    int _retval;
    _retval = gtk_text_view_get_right_margin(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Gets the `PangoContext` that is used for rendering RTL directed
   * text layouts.
   * The context may be replaced when CSS changes occur.
   * Returns: a `PangoContext`
   */
  Context getRtlContext()
  {
    PangoContext* _cretval;
    _cretval = gtk_text_view_get_rtl_context(cast(GtkTextView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the default tabs for text_view.
   * Tags in the buffer may override the defaults. The returned array
   * will be %NULL if “standard” $(LPAREN)8-space$(RPAREN) tabs are used. Free the
   * return value with [Pango.TabArray.free].
   * Returns: copy of default tab array,
   *   or %NULL if standard tabs are used; must be freed with
   *   [Pango.TabArray.free].
   */
  TabArray getTabs()
  {
    PangoTabArray* _cretval;
    _cretval = gtk_text_view_get_tabs(cast(GtkTextView*)cPtr);
    auto _retval = _cretval ? new TabArray(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the top margin for text in the text_view.
   * Returns: top margin in pixels
   */
  int getTopMargin()
  {
    int _retval;
    _retval = gtk_text_view_get_top_margin(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Fills visible_rect with the currently-visible
   * region of the buffer, in buffer coordinates.
   * Convert to window coordinates with
   * [Gtk.TextView.bufferToWindowCoords].
   * Params:
   *   visibleRect = rectangle to fill
   */
  void getVisibleRect(out Rectangle visibleRect)
  {
    GdkRectangle _visibleRect;
    gtk_text_view_get_visible_rect(cast(GtkTextView*)cPtr, &_visibleRect);
    visibleRect = new Rectangle(cast(void*)&_visibleRect, false);
  }

  /**
   * Gets the line wrapping for the view.
   * Returns: the line wrap setting
   */
  WrapMode getWrapMode()
  {
    GtkWrapMode _cretval;
    _cretval = gtk_text_view_get_wrap_mode(cast(GtkTextView*)cPtr);
    WrapMode _retval = cast(WrapMode)_cretval;
    return _retval;
  }

  /**
   * Allow the `GtkTextView` input method to internally handle key press
   * and release events.
   * If this function returns %TRUE, then no further processing should be
   * done for this key event. See [Gtk.IMContext.filterKeypress].
   * Note that you are expected to call this function from your handler
   * when overriding key event handling. This is needed in the case when
   * you need to insert your own key handling between the input method
   * and the default key event handling of the `GtkTextView`.
   * ```c
   * static gboolean
   * gtk_foo_bar_key_press_event $(LPAREN)GtkWidget *widget,
   * GdkEvent  *event$(RPAREN)
   * {
   * guint keyval;
   * gdk_event_get_keyval $(LPAREN)$(LPAREN)GdkEvent*$(RPAREN)event, &keyval$(RPAREN);
   * if $(LPAREN)keyval \=\= GDK_KEY_Return || keyval \=\= GDK_KEY_KP_Enter$(RPAREN)
   * {
   * if $(LPAREN)gtk_text_view_im_context_filter_keypress $(LPAREN)GTK_TEXT_VIEW $(LPAREN)widget$(RPAREN), event$(RPAREN)$(RPAREN)
   * return TRUE;
   * }
   * // Do some stuff
   * return GTK_WIDGET_CLASS $(LPAREN)gtk_foo_bar_parent_class$(RPAREN)->key_press_event $(LPAREN)widget, event$(RPAREN);
   * }
   * ```
   * Params:
   *   event = the key event
   * Returns: %TRUE if the input method handled the key event.
   */
  bool imContextFilterKeypress(Event event)
  {
    bool _retval;
    _retval = gtk_text_view_im_context_filter_keypress(cast(GtkTextView*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves a mark within the buffer so that it's
   * located within the currently-visible text area.
   * Params:
   *   mark = a `GtkTextMark`
   * Returns: %TRUE if the mark moved $(LPAREN)wasn’t already onscreen$(RPAREN)
   */
  bool moveMarkOnscreen(TextMark mark)
  {
    bool _retval;
    _retval = gtk_text_view_move_mark_onscreen(cast(GtkTextView*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null);
    return _retval;
  }

  /**
   * Updates the position of a child.
   * See [Gtk.TextView.addOverlay].
   * Params:
   *   child = a widget already added with [Gtk.TextView.addOverlay]
   *   xpos = new X position in buffer coordinates
   *   ypos = new Y position in buffer coordinates
   */
  void moveOverlay(Widget child, int xpos, int ypos)
  {
    gtk_text_view_move_overlay(cast(GtkTextView*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, xpos, ypos);
  }

  /**
   * Move the iterator a given number of characters visually, treating
   * it as the strong cursor position.
   * If count is positive, then the new strong cursor position will
   * be count positions to the right of the old cursor position.
   * If count is negative then the new strong cursor position will
   * be count positions to the left of the old cursor position.
   * In the presence of bi-directional text, the correspondence
   * between logical and visual order will depend on the direction
   * of the current run, and there may be jumps when the cursor
   * is moved off of the end of a run.
   * Params:
   *   iter = a `GtkTextIter`
   *   count = number of characters to move $(LPAREN)negative moves left,
   *     positive moves right$(RPAREN)
   * Returns: %TRUE if iter moved and is not on the end iterator
   */
  bool moveVisually(TextIter iter, int count)
  {
    bool _retval;
    _retval = gtk_text_view_move_visually(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, count);
    return _retval;
  }

  /**
   * Moves the cursor to the currently visible region of the
   * buffer.
   * Returns: %TRUE if the cursor had to be moved.
   */
  bool placeCursorOnscreen()
  {
    bool _retval;
    _retval = gtk_text_view_place_cursor_onscreen(cast(GtkTextView*)cPtr);
    return _retval;
  }

  /**
   * Removes a child widget from text_view.
   * Params:
   *   child = the child to remove
   */
  void remove(Widget child)
  {
    gtk_text_view_remove(cast(GtkTextView*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Ensures that the cursor is shown.
   * This also resets the time that it will stay blinking $(LPAREN)or
   * visible, in case blinking is disabled$(RPAREN).
   * This function should be called in response to user input
   * $(LPAREN)e.g. from derived classes that override the textview's
   * event handlers$(RPAREN).
   */
  void resetCursorBlink()
  {
    gtk_text_view_reset_cursor_blink(cast(GtkTextView*)cPtr);
  }

  /**
   * Reset the input method context of the text view if needed.
   * This can be necessary in the case where modifying the buffer
   * would confuse on-going input method behavior.
   */
  void resetImContext()
  {
    gtk_text_view_reset_im_context(cast(GtkTextView*)cPtr);
  }

  /**
   * Scrolls text_view the minimum distance such that mark is contained
   * within the visible area of the widget.
   * Params:
   *   mark = a mark in the buffer for text_view
   */
  void scrollMarkOnscreen(TextMark mark)
  {
    gtk_text_view_scroll_mark_onscreen(cast(GtkTextView*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null);
  }

  /**
   * Scrolls text_view so that iter is on the screen in the position
   * indicated by xalign and yalign.
   * An alignment of 0.0 indicates left or top, 1.0 indicates right or
   * bottom, 0.5 means center. If use_align is %FALSE, the text scrolls
   * the minimal distance to get the mark onscreen, possibly not scrolling
   * at all. The effective screen for purposes of this function is reduced
   * by a margin of size within_margin.
   * Note that this function uses the currently-computed height of the
   * lines in the text buffer. Line heights are computed in an idle
   * handler; so this function may not have the desired effect if it’s
   * called before the height computations. To avoid oddness, consider
   * using [Gtk.TextView.scrollToMark] which saves a point to be
   * scrolled to after line validation.
   * Params:
   *   iter = a `GtkTextIter`
   *   withinMargin = margin as a [0.0,0.5$(RPAREN) fraction of screen size
   *   useAlign = whether to use alignment arguments $(LPAREN)if %FALSE,
   *     just get the mark onscreen$(RPAREN)
   *   xalign = horizontal alignment of mark within visible area
   *   yalign = vertical alignment of mark within visible area
   * Returns: %TRUE if scrolling occurred
   */
  bool scrollToIter(TextIter iter, double withinMargin, bool useAlign, double xalign, double yalign)
  {
    bool _retval;
    _retval = gtk_text_view_scroll_to_iter(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, withinMargin, useAlign, xalign, yalign);
    return _retval;
  }

  /**
   * Scrolls text_view so that mark is on the screen in the position
   * indicated by xalign and yalign.
   * An alignment of 0.0 indicates left or top, 1.0 indicates right or
   * bottom, 0.5 means center. If use_align is %FALSE, the text scrolls
   * the minimal distance to get the mark onscreen, possibly not scrolling
   * at all. The effective screen for purposes of this function is reduced
   * by a margin of size within_margin.
   * Params:
   *   mark = a `GtkTextMark`
   *   withinMargin = margin as a [0.0,0.5$(RPAREN) fraction of screen size
   *   useAlign = whether to use alignment arguments $(LPAREN)if %FALSE, just
   *     get the mark onscreen$(RPAREN)
   *   xalign = horizontal alignment of mark within visible area
   *   yalign = vertical alignment of mark within visible area
   */
  void scrollToMark(TextMark mark, double withinMargin, bool useAlign, double xalign, double yalign)
  {
    gtk_text_view_scroll_to_mark(cast(GtkTextView*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null, withinMargin, useAlign, xalign, yalign);
  }

  /**
   * Sets the behavior of the text widget when the <kbd>Tab</kbd> key is pressed.
   * If accepts_tab is %TRUE, a tab character is inserted. If accepts_tab
   * is %FALSE the keyboard focus is moved to the next widget in the focus
   * chain.
   * Focus can always be moved using <kbd>Ctrl</kbd>+<kbd>Tab</kbd>.
   * Params:
   *   acceptsTab = %TRUE if pressing the Tab key should insert a tab
   *     character, %FALSE, if pressing the Tab key should move the
   *     keyboard focus.
   */
  void setAcceptsTab(bool acceptsTab)
  {
    gtk_text_view_set_accepts_tab(cast(GtkTextView*)cPtr, acceptsTab);
  }

  /**
   * Sets the bottom margin for text in text_view.
   * Note that this function is confusingly named.
   * In CSS terms, the value set here is padding.
   * Params:
   *   bottomMargin = bottom margin in pixels
   */
  void setBottomMargin(int bottomMargin)
  {
    gtk_text_view_set_bottom_margin(cast(GtkTextView*)cPtr, bottomMargin);
  }

  /**
   * Sets buffer as the buffer being displayed by text_view.
   * The previous buffer displayed by the text view is unreferenced, and
   * a reference is added to buffer. If you owned a reference to buffer
   * before passing it to this function, you must remove that reference
   * yourself; `GtkTextView` will not “adopt” it.
   * Params:
   *   buffer = a `GtkTextBuffer`
   */
  void setBuffer(TextBuffer buffer)
  {
    gtk_text_view_set_buffer(cast(GtkTextView*)cPtr, buffer ? cast(GtkTextBuffer*)buffer.cPtr(false) : null);
  }

  /**
   * Toggles whether the insertion point should be displayed.
   * A buffer with no editable text probably shouldn’t have a visible
   * cursor, so you may want to turn the cursor off.
   * Note that this property may be overridden by the
   * propertyGtk.Settings:gtk-keynav-use-caret setting.
   * Params:
   *   setting = whether to show the insertion cursor
   */
  void setCursorVisible(bool setting)
  {
    gtk_text_view_set_cursor_visible(cast(GtkTextView*)cPtr, setting);
  }

  /**
   * Sets the default editability of the `GtkTextView`.
   * You can override this default setting with tags in the buffer,
   * using the “editable” attribute of tags.
   * Params:
   *   setting = whether it’s editable
   */
  void setEditable(bool setting)
  {
    gtk_text_view_set_editable(cast(GtkTextView*)cPtr, setting);
  }

  /**
   * Sets a menu model to add when constructing the context
   * menu for text_view.
   * You can pass %NULL to remove a previously set extra menu.
   * Params:
   *   model = a `GMenuModel`
   */
  void setExtraMenu(MenuModel model)
  {
    gtk_text_view_set_extra_menu(cast(GtkTextView*)cPtr, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }

  /**
   * Places widget into the gutter specified by win.
   * win must be one of %GTK_TEXT_WINDOW_LEFT, %GTK_TEXT_WINDOW_RIGHT,
   * %GTK_TEXT_WINDOW_TOP, or %GTK_TEXT_WINDOW_BOTTOM.
   * Params:
   *   win = a `GtkTextWindowType`
   *   widget = a `GtkWidget`
   */
  void setGutter(TextWindowType win, Widget widget)
  {
    gtk_text_view_set_gutter(cast(GtkTextView*)cPtr, win, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Sets the default indentation for paragraphs in text_view.
   * Tags in the buffer may override the default.
   * Params:
   *   indent = indentation in pixels
   */
  void setIndent(int indent)
  {
    gtk_text_view_set_indent(cast(GtkTextView*)cPtr, indent);
  }

  /**
   * Sets the `input-hints` of the `GtkTextView`.
   * The `input-hints` allow input methods to fine-tune
   * their behaviour.
   * Params:
   *   hints = the hints
   */
  void setInputHints(InputHints hints)
  {
    gtk_text_view_set_input_hints(cast(GtkTextView*)cPtr, hints);
  }

  /**
   * Sets the `input-purpose` of the `GtkTextView`.
   * The `input-purpose` can be used by on-screen keyboards
   * and other input methods to adjust their behaviour.
   * Params:
   *   purpose = the purpose
   */
  void setInputPurpose(InputPurpose purpose)
  {
    gtk_text_view_set_input_purpose(cast(GtkTextView*)cPtr, purpose);
  }

  /**
   * Sets the default justification of text in text_view.
   * Tags in the view’s buffer may override the default.
   * Params:
   *   justification = justification
   */
  void setJustification(Justification justification)
  {
    gtk_text_view_set_justification(cast(GtkTextView*)cPtr, justification);
  }

  /**
   * Sets the default left margin for text in text_view.
   * Tags in the buffer may override the default.
   * Note that this function is confusingly named.
   * In CSS terms, the value set here is padding.
   * Params:
   *   leftMargin = left margin in pixels
   */
  void setLeftMargin(int leftMargin)
  {
    gtk_text_view_set_left_margin(cast(GtkTextView*)cPtr, leftMargin);
  }

  /**
   * Sets whether the `GtkTextView` should display text in
   * monospace styling.
   * Params:
   *   monospace = %TRUE to request monospace styling
   */
  void setMonospace(bool monospace)
  {
    gtk_text_view_set_monospace(cast(GtkTextView*)cPtr, monospace);
  }

  /**
   * Changes the `GtkTextView` overwrite mode.
   * Params:
   *   overwrite = %TRUE to turn on overwrite mode, %FALSE to turn it off
   */
  void setOverwrite(bool overwrite)
  {
    gtk_text_view_set_overwrite(cast(GtkTextView*)cPtr, overwrite);
  }

  /**
   * Sets the default number of blank pixels above paragraphs in text_view.
   * Tags in the buffer for text_view may override the defaults.
   * Params:
   *   pixelsAboveLines = pixels above paragraphs
   */
  void setPixelsAboveLines(int pixelsAboveLines)
  {
    gtk_text_view_set_pixels_above_lines(cast(GtkTextView*)cPtr, pixelsAboveLines);
  }

  /**
   * Sets the default number of pixels of blank space
   * to put below paragraphs in text_view.
   * May be overridden by tags applied to text_view’s buffer.
   * Params:
   *   pixelsBelowLines = pixels below paragraphs
   */
  void setPixelsBelowLines(int pixelsBelowLines)
  {
    gtk_text_view_set_pixels_below_lines(cast(GtkTextView*)cPtr, pixelsBelowLines);
  }

  /**
   * Sets the default number of pixels of blank space to leave between
   * display/wrapped lines within a paragraph.
   * May be overridden by tags in text_view’s buffer.
   * Params:
   *   pixelsInsideWrap = default number of pixels between wrapped lines
   */
  void setPixelsInsideWrap(int pixelsInsideWrap)
  {
    gtk_text_view_set_pixels_inside_wrap(cast(GtkTextView*)cPtr, pixelsInsideWrap);
  }

  /**
   * Sets the default right margin for text in the text view.
   * Tags in the buffer may override the default.
   * Note that this function is confusingly named.
   * In CSS terms, the value set here is padding.
   * Params:
   *   rightMargin = right margin in pixels
   */
  void setRightMargin(int rightMargin)
  {
    gtk_text_view_set_right_margin(cast(GtkTextView*)cPtr, rightMargin);
  }

  /**
   * Sets the default tab stops for paragraphs in text_view.
   * Tags in the buffer may override the default.
   * Params:
   *   tabs = tabs as a `PangoTabArray`
   */
  void setTabs(TabArray tabs)
  {
    gtk_text_view_set_tabs(cast(GtkTextView*)cPtr, tabs ? cast(PangoTabArray*)tabs.cPtr(false) : null);
  }

  /**
   * Sets the top margin for text in text_view.
   * Note that this function is confusingly named.
   * In CSS terms, the value set here is padding.
   * Params:
   *   topMargin = top margin in pixels
   */
  void setTopMargin(int topMargin)
  {
    gtk_text_view_set_top_margin(cast(GtkTextView*)cPtr, topMargin);
  }

  /**
   * Sets the line wrapping for the view.
   * Params:
   *   wrapMode = a `GtkWrapMode`
   */
  void setWrapMode(WrapMode wrapMode)
  {
    gtk_text_view_set_wrap_mode(cast(GtkTextView*)cPtr, wrapMode);
  }

  /**
   * Determines whether iter is at the start of a display line.
   * See [Gtk.TextView.forwardDisplayLine] for an
   * explanation of display lines vs. paragraphs.
   * Params:
   *   iter = a `GtkTextIter`
   * Returns: %TRUE if iter begins a wrapped line
   */
  bool startsDisplayLine(TextIter iter)
  {
    bool _retval;
    _retval = gtk_text_view_starts_display_line(cast(GtkTextView*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Converts coordinates on the window identified by win to buffer
   * coordinates.
   * Params:
   *   win = a `GtkTextWindowType`
   *   windowX = window x coordinate
   *   windowY = window y coordinate
   *   bufferX = buffer x coordinate return location
   *   bufferY = buffer y coordinate return location
   */
  void windowToBufferCoords(TextWindowType win, int windowX, int windowY, out int bufferX, out int bufferY)
  {
    gtk_text_view_window_to_buffer_coords(cast(GtkTextView*)cPtr, win, windowX, windowY, cast(int*)&bufferX, cast(int*)&bufferY);
  }

  /**
   * Gets emitted when the user asks for it.
   * The ::backspace signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Backspace</kbd> and <kbd>Shift</kbd>+<kbd>Backspace</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias BackspaceCallback = void delegate(TextView textView);

  /**
   * Connect to Backspace signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBackspace(BackspaceCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("backspace", closure, after);
  }

  /**
   * Gets emitted to copy the selection to the clipboard.
   * The ::copy-clipboard signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>c</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>Insert</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias CopyClipboardCallback = void delegate(TextView textView);

  /**
   * Connect to CopyClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCopyClipboard(CopyClipboardCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("copy-clipboard", closure, after);
  }

  /**
   * Gets emitted to cut the selection to the clipboard.
   * The ::cut-clipboard signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>x</kbd> and
   * <kbd>Shift</kbd>+<kbd>Delete</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias CutClipboardCallback = void delegate(TextView textView);

  /**
   * Connect to CutClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCutClipboard(CutClipboardCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cut-clipboard", closure, after);
  }

  /**
   * Gets emitted when the user initiates a text deletion.
   * The ::delete-from-cursor signal is a [keybinding signal](class.SignalAction.html).
   * If the type is %GTK_DELETE_CHARS, GTK deletes the selection
   * if there is one, otherwise it deletes the requested number
   * of characters.
   * The default bindings for this signal are <kbd>Delete</kbd> for
   * deleting a character, <kbd>Ctrl</kbd>+<kbd>Delete</kbd> for
   * deleting a word and <kbd>Ctrl</kbd>+<kbd>Backspace</kbd> for
   * deleting a word backwards.
   * Params
   *   type = the granularity of the deletion, as a `GtkDeleteType`
   *   count = the number of type units to delete
   *   textView = the instance the signal is connected to
   */
  alias DeleteFromCursorCallback = void delegate(DeleteType type, int count, TextView textView);

  /**
   * Connect to DeleteFromCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDeleteFromCursor(DeleteFromCursorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto type = getVal!DeleteType(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(type, count, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("delete-from-cursor", closure, after);
  }

  /**
   * Emitted when the selection needs to be extended at location.
   * Params
   *   granularity = the granularity type
   *   location = the location where to extend the selection
   *   start = where the selection should start
   *   end = where the selection should end
   *   textView = the instance the signal is connected to
   * Returns: %GDK_EVENT_STOP to stop other handlers from being invoked for the
   *   event. %GDK_EVENT_PROPAGATE to propagate the event further.
   */
  alias ExtendSelectionCallback = bool delegate(TextExtendSelection granularity, TextIter location, TextIter start, TextIter end, TextView textView);

  /**
   * Connect to ExtendSelection signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectExtendSelection(ExtendSelectionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto textView = getVal!TextView(_paramVals);
      auto granularity = getVal!TextExtendSelection(&_paramVals[1]);
      auto location = getVal!TextIter(&_paramVals[2]);
      auto start = getVal!TextIter(&_paramVals[3]);
      auto end = getVal!TextIter(&_paramVals[4]);
      _retval = _dgClosure.dlg(granularity, location, start, end, textView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("extend-selection", closure, after);
  }

  /**
   * Gets emitted when the user initiates the insertion of a
   * fixed string at the cursor.
   * The ::insert-at-cursor signal is a [keybinding signal](class.SignalAction.html).
   * This signal has no default bindings.
   * Params
   *   string_ = the string to insert
   *   textView = the instance the signal is connected to
   */
  alias InsertAtCursorCallback = void delegate(string string_, TextView textView);

  /**
   * Connect to InsertAtCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertAtCursor(InsertAtCursorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto string_ = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(string_, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-at-cursor", closure, after);
  }

  /**
   * Gets emitted to present the Emoji chooser for the text_view.
   * The ::insert-emoji signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>.</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>;</kbd>
   *   textView = the instance the signal is connected to
   */
  alias InsertEmojiCallback = void delegate(TextView textView);

  /**
   * Connect to InsertEmoji signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertEmoji(InsertEmojiCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-emoji", closure, after);
  }

  /**
   * Gets emitted when the user initiates a cursor movement.
   * The ::move-cursor signal is a [keybinding signal](class.SignalAction.html).
   * If the cursor is not visible in text_view, this signal causes
   * the viewport to be moved instead.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal come in two variants,
   * the variant with the <kbd>Shift</kbd> modifier extends the
   * selection, the variant without it does not.
   * There are too many key combinations to list them all here.
   * - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
   * move by individual characters/lines
   * - <kbd>Ctrl</kbd>+<kbd>←</kbd>, etc. move by words/paragraphs
   * - <kbd>Home</kbd> and <kbd>End</kbd> move to the ends of the buffer
   * - <kbd>PgUp</kbd> and <kbd>PgDn</kbd> move vertically by pages
   * - <kbd>Ctrl</kbd>+<kbd>PgUp</kbd> and <kbd>Ctrl</kbd>+<kbd>PgDn</kbd>
   * move horizontally by pages
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`
   *   count = the number of step units to move
   *   extendSelection = %TRUE if the move should extend the selection
   *   textView = the instance the signal is connected to
   */
  alias MoveCursorCallback = void delegate(MovementStep step, int count, bool extendSelection, TextView textView);

  /**
   * Connect to MoveCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveCursor(MoveCursorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      auto extendSelection = getVal!bool(&_paramVals[3]);
      _dgClosure.dlg(step, count, extendSelection, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, after);
  }

  /**
   * Gets emitted to move the viewport.
   * The ::move-viewport signal is a [keybinding signal](class.SignalAction.html),
   * which can be bound to key combinations to allow the user to move the viewport,
   * i.e. change what part of the text view is visible in a containing scrolled
   * window.
   * There are no default bindings for this signal.
   * Params
   *   step = the granularity of the movement, as a `GtkScrollStep`
   *   count = the number of step units to move
   *   textView = the instance the signal is connected to
   */
  alias MoveViewportCallback = void delegate(ScrollStep step, int count, TextView textView);

  /**
   * Connect to MoveViewport signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveViewport(MoveViewportCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto step = getVal!ScrollStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(step, count, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-viewport", closure, after);
  }

  /**
   * Gets emitted to paste the contents of the clipboard
   * into the text view.
   * The ::paste-clipboard signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>v</kbd> and
   * <kbd>Shift</kbd>+<kbd>Insert</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias PasteClipboardCallback = void delegate(TextView textView);

  /**
   * Connect to PasteClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPasteClipboard(PasteClipboardCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("paste-clipboard", closure, after);
  }

  /**
   * Emitted when preedit text of the active IM changes.
   * If an input method is used, the typed text will not immediately
   * be committed to the buffer. So if you are interested in the text,
   * connect to this signal.
   * This signal is only emitted if the text at the given position
   * is actually editable.
   * Params
   *   preedit = the current preedit string
   *   textView = the instance the signal is connected to
   */
  alias PreeditChangedCallback = void delegate(string preedit, TextView textView);

  /**
   * Connect to PreeditChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPreeditChanged(PreeditChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto preedit = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(preedit, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("preedit-changed", closure, after);
  }

  /**
   * Gets emitted to select or unselect the complete contents of the text view.
   * The ::select-all signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>a</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>/</kbd> for selecting and
   * <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>a</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>\</kbd> for unselecting.
   * Params
   *   select = %TRUE to select, %FALSE to unselect
   *   textView = the instance the signal is connected to
   */
  alias SelectAllCallback = void delegate(bool select, TextView textView);

  /**
   * Connect to SelectAll signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectAll(SelectAllCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      auto select = getVal!bool(&_paramVals[1]);
      _dgClosure.dlg(select, textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-all", closure, after);
  }

  /**
   * Gets emitted when the user initiates settings the "anchor" mark.
   * The ::set-anchor signal is a [keybinding signal](class.SignalAction.html)
   * which gets emitted when the user initiates setting the "anchor"
   * mark. The "anchor" mark gets placed at the same position as the
   * "insert" mark.
   * This signal has no default bindings.
   *   textView = the instance the signal is connected to
   */
  alias SetAnchorCallback = void delegate(TextView textView);

  /**
   * Connect to SetAnchor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSetAnchor(SetAnchorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("set-anchor", closure, after);
  }

  /**
   * Gets emitted to toggle the `cursor-visible` property.
   * The ::toggle-cursor-visible signal is a
   * [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>F7</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias ToggleCursorVisibleCallback = void delegate(TextView textView);

  /**
   * Connect to ToggleCursorVisible signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleCursorVisible(ToggleCursorVisibleCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-cursor-visible", closure, after);
  }

  /**
   * Gets emitted to toggle the overwrite mode of the text view.
   * The ::toggle-overwrite signal is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Insert</kbd>.
   *   textView = the instance the signal is connected to
   */
  alias ToggleOverwriteCallback = void delegate(TextView textView);

  /**
   * Connect to ToggleOverwrite signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleOverwrite(ToggleOverwriteCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textView = getVal!TextView(_paramVals);
      _dgClosure.dlg(textView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-overwrite", closure, after);
  }
}
