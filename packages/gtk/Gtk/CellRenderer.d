module Gtk.CellRenderer;

import GObject.DClosure;
import GObject.InitiallyUnowned;
import GObject.ObjectG;
import Gdk.Event;
import Gdk.Rectangle;
import Gid.gid;
import Gtk.CellEditable;
import Gtk.CellEditableT;
import Gtk.Requisition;
import Gtk.Snapshot;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An object for rendering a single cell
 * The `GtkCellRenderer` is a base class of a set of objects used for
 * rendering a cell to a `cairo_t`.  These objects are used primarily by
 * the `GtkTreeView` widget, though they aren’t tied to them in any
 * specific way.  It is worth noting that `GtkCellRenderer` is not a
 * `GtkWidget` and cannot be treated as such.
 * The primary use of a `GtkCellRenderer` is for drawing a certain graphical
 * elements on a `cairo_t`. Typically, one cell renderer is used to
 * draw many cells on the screen.  To this extent, it isn’t expected that a
 * CellRenderer keep any permanent state around.  Instead, any state is set
 * just prior to use using `GObject`s property system.  Then, the
 * cell is measured using [Gtk.CellRenderer.getPreferredSize]. Finally, the cell
 * is rendered in the correct location using [Gtk.CellRenderer.snapshot].
 * There are a number of rules that must be followed when writing a new
 * `GtkCellRenderer`.  First and foremost, it’s important that a certain set
 * of properties will always yield a cell renderer of the same size,
 * barring a style change. The `GtkCellRenderer` also has a number of
 * generic properties that are expected to be honored by all children.
 * Beyond merely rendering a cell, cell renderers can optionally
 * provide active user interface elements. A cell renderer can be
 * “activatable” like `GtkCellRenderer`Toggle,
 * which toggles when it gets activated by a mouse click, or it can be
 * “editable” like `GtkCellRenderer`Text, which
 * allows the user to edit the text using a widget implementing the
 * `GtkCellEditable` interface, e.g. `GtkEntry`.
 * To make a cell renderer activatable or editable, you have to
 * implement the `GtkCellRenderer`Class.activate or
 * `GtkCellRenderer`Class.start_editing virtual functions, respectively.
 * Many properties of `GtkCellRenderer` and its subclasses have a
 * corresponding “set” property, e.g. “cell-background-set” corresponds
 * to “cell-background”. These “set” properties reflect whether a property
 * has been set or not. You should not set them independently.

 * Deprecated: List views use widgets for displaying their
 *   contents
 */
class CellRenderer : InitiallyUnowned
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
    return gtk_cell_renderer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Passes an activate event to the cell renderer for possible processing.
   * Some cell renderers may use events; for example, `GtkCellRendererToggle`
   * toggles when it gets a mouse click.
   * Params:
   *   event = a `GdkEvent`
   *   widget = widget that received the event
   *   path = widget-dependent string representation of the event location;
   *     e.g. for `GtkTreeView`, a string representation of `GtkTreePath`
   *   backgroundArea = background area as passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN)
   *   cellArea = cell area as passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN)
   *   flags = render flags
   * Returns: %TRUE if the event was consumed/handled
   */
  bool activate(Event event, Widget widget, string path, Rectangle backgroundArea, Rectangle cellArea, CellRendererState flags)
  {
    bool _retval;
    const(char)* _path = path.toCString(false);
    _retval = gtk_cell_renderer_activate(cast(GtkCellRenderer*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, _path, backgroundArea ? cast(GdkRectangle*)backgroundArea.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags);
    return _retval;
  }

  /**
   * Gets the aligned area used by cell inside cell_area. Used for finding
   * the appropriate edit and focus rectangle.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   flags = render flags
   *   cellArea = cell area which would be passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN)
   *   alignedArea = the return location for the space inside cell_area
   *     that would actually be used to render.
   */
  void getAlignedArea(Widget widget, CellRendererState flags, Rectangle cellArea, out Rectangle alignedArea)
  {
    GdkRectangle _alignedArea;
    gtk_cell_renderer_get_aligned_area(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, flags, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, &_alignedArea);
    alignedArea = new Rectangle(cast(void*)&_alignedArea, false);
  }

  /**
   * Fills in xalign and yalign with the appropriate values of cell.
   * Params:
   *   xalign = location to fill in with the x alignment of the cell
   *   yalign = location to fill in with the y alignment of the cell
   */
  void getAlignment(out float xalign, out float yalign)
  {
    gtk_cell_renderer_get_alignment(cast(GtkCellRenderer*)cPtr, cast(float*)&xalign, cast(float*)&yalign);
  }

  /**
   * Fills in width and height with the appropriate size of cell.
   * Params:
   *   width = location to fill in with the fixed width of the cell
   *   height = location to fill in with the fixed height of the cell
   */
  void getFixedSize(out int width, out int height)
  {
    gtk_cell_renderer_get_fixed_size(cast(GtkCellRenderer*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Checks whether the given `GtkCellRenderer` is expanded.
   * Returns: %TRUE if the cell renderer is expanded
   */
  bool getIsExpanded()
  {
    bool _retval;
    _retval = gtk_cell_renderer_get_is_expanded(cast(GtkCellRenderer*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the given `GtkCellRenderer` is an expander.
   * Returns: %TRUE if cell is an expander, and %FALSE otherwise
   */
  bool getIsExpander()
  {
    bool _retval;
    _retval = gtk_cell_renderer_get_is_expander(cast(GtkCellRenderer*)cPtr);
    return _retval;
  }

  /**
   * Fills in xpad and ypad with the appropriate values of cell.
   * Params:
   *   xpad = location to fill in with the x padding of the cell
   *   ypad = location to fill in with the y padding of the cell
   */
  void getPadding(out int xpad, out int ypad)
  {
    gtk_cell_renderer_get_padding(cast(GtkCellRenderer*)cPtr, cast(int*)&xpad, cast(int*)&ypad);
  }

  /**
   * Retrieves a renderer’s natural size when rendered to widget.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   minimumSize = location to store the minimum size
   *   naturalSize = location to store the natural size
   */
  void getPreferredHeight(Widget widget, out int minimumSize, out int naturalSize)
  {
    gtk_cell_renderer_get_preferred_height(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cast(int*)&minimumSize, cast(int*)&naturalSize);
  }

  /**
   * Retrieves a cell renderers’s minimum and natural height if it were rendered to
   * widget with the specified width.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   width = the size which is available for allocation
   *   minimumHeight = location for storing the minimum size
   *   naturalHeight = location for storing the preferred size
   */
  void getPreferredHeightForWidth(Widget widget, int width, out int minimumHeight, out int naturalHeight)
  {
    gtk_cell_renderer_get_preferred_height_for_width(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, width, cast(int*)&minimumHeight, cast(int*)&naturalHeight);
  }

  /**
   * Retrieves the minimum and natural size of a cell taking
   * into account the widget’s preference for height-for-width management.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   minimumSize = location for storing the minimum size
   *   naturalSize = location for storing the natural size
   */
  void getPreferredSize(Widget widget, out Requisition minimumSize, out Requisition naturalSize)
  {
    GtkRequisition _minimumSize;
    GtkRequisition _naturalSize;
    gtk_cell_renderer_get_preferred_size(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, &_minimumSize, &_naturalSize);
    minimumSize = new Requisition(cast(void*)&_minimumSize, false);
    naturalSize = new Requisition(cast(void*)&_naturalSize, false);
  }

  /**
   * Retrieves a renderer’s natural size when rendered to widget.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   minimumSize = location to store the minimum size
   *   naturalSize = location to store the natural size
   */
  void getPreferredWidth(Widget widget, out int minimumSize, out int naturalSize)
  {
    gtk_cell_renderer_get_preferred_width(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cast(int*)&minimumSize, cast(int*)&naturalSize);
  }

  /**
   * Retrieves a cell renderers’s minimum and natural width if it were rendered to
   * widget with the specified height.
   * Params:
   *   widget = the `GtkWidget` this cell will be rendering to
   *   height = the size which is available for allocation
   *   minimumWidth = location for storing the minimum size
   *   naturalWidth = location for storing the preferred size
   */
  void getPreferredWidthForHeight(Widget widget, int height, out int minimumWidth, out int naturalWidth)
  {
    gtk_cell_renderer_get_preferred_width_for_height(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, height, cast(int*)&minimumWidth, cast(int*)&naturalWidth);
  }

  /**
   * Gets whether the cell renderer prefers a height-for-width layout
   * or a width-for-height layout.
   * Returns: The `GtkSizeRequestMode` preferred by this renderer.
   */
  SizeRequestMode getRequestMode()
  {
    GtkSizeRequestMode _cretval;
    _cretval = gtk_cell_renderer_get_request_mode(cast(GtkCellRenderer*)cPtr);
    SizeRequestMode _retval = cast(SizeRequestMode)_cretval;
    return _retval;
  }

  /**
   * Returns the cell renderer’s sensitivity.
   * Returns: %TRUE if the cell renderer is sensitive
   */
  bool getSensitive()
  {
    bool _retval;
    _retval = gtk_cell_renderer_get_sensitive(cast(GtkCellRenderer*)cPtr);
    return _retval;
  }

  /**
   * Translates the cell renderer state to `GtkStateFlags`,
   * based on the cell renderer and widget sensitivity, and
   * the given `GtkCellRenderer`State.
   * Params:
   *   widget = a `GtkWidget`
   *   cellState = cell renderer state
   * Returns: the widget state flags applying to cell
   */
  StateFlags getState(Widget widget, CellRendererState cellState)
  {
    GtkStateFlags _cretval;
    _cretval = gtk_cell_renderer_get_state(cast(GtkCellRenderer*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cellState);
    StateFlags _retval = cast(StateFlags)_cretval;
    return _retval;
  }

  /**
   * Returns the cell renderer’s visibility.
   * Returns: %TRUE if the cell renderer is visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_cell_renderer_get_visible(cast(GtkCellRenderer*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the cell renderer can do something when activated.
   * Returns: %TRUE if the cell renderer can do anything when activated
   */
  bool isActivatable()
  {
    bool _retval;
    _retval = gtk_cell_renderer_is_activatable(cast(GtkCellRenderer*)cPtr);
    return _retval;
  }

  /**
   * Sets the renderer’s alignment within its available space.
   * Params:
   *   xalign = the x alignment of the cell renderer
   *   yalign = the y alignment of the cell renderer
   */
  void setAlignment(float xalign, float yalign)
  {
    gtk_cell_renderer_set_alignment(cast(GtkCellRenderer*)cPtr, xalign, yalign);
  }

  /**
   * Sets the renderer size to be explicit, independent of the properties set.
   * Params:
   *   width = the width of the cell renderer, or -1
   *   height = the height of the cell renderer, or -1
   */
  void setFixedSize(int width, int height)
  {
    gtk_cell_renderer_set_fixed_size(cast(GtkCellRenderer*)cPtr, width, height);
  }

  /**
   * Sets whether the given `GtkCellRenderer` is expanded.
   * Params:
   *   isExpanded = whether cell should be expanded
   */
  void setIsExpanded(bool isExpanded)
  {
    gtk_cell_renderer_set_is_expanded(cast(GtkCellRenderer*)cPtr, isExpanded);
  }

  /**
   * Sets whether the given `GtkCellRenderer` is an expander.
   * Params:
   *   isExpander = whether cell is an expander
   */
  void setIsExpander(bool isExpander)
  {
    gtk_cell_renderer_set_is_expander(cast(GtkCellRenderer*)cPtr, isExpander);
  }

  /**
   * Sets the renderer’s padding.
   * Params:
   *   xpad = the x padding of the cell renderer
   *   ypad = the y padding of the cell renderer
   */
  void setPadding(int xpad, int ypad)
  {
    gtk_cell_renderer_set_padding(cast(GtkCellRenderer*)cPtr, xpad, ypad);
  }

  /**
   * Sets the cell renderer’s sensitivity.
   * Params:
   *   sensitive = the sensitivity of the cell
   */
  void setSensitive(bool sensitive)
  {
    gtk_cell_renderer_set_sensitive(cast(GtkCellRenderer*)cPtr, sensitive);
  }

  /**
   * Sets the cell renderer’s visibility.
   * Params:
   *   visible = the visibility of the cell
   */
  void setVisible(bool visible)
  {
    gtk_cell_renderer_set_visible(cast(GtkCellRenderer*)cPtr, visible);
  }

  /**
   * Invokes the virtual render function of the `GtkCellRenderer`. The three
   * passed-in rectangles are areas in cr. Most renderers will draw within
   * cell_area; the xalign, yalign, xpad, and ypad fields of the `GtkCellRenderer`
   * should be honored with respect to cell_area. background_area includes the
   * blank space around the cell, and also the area containing the tree expander;
   * so the background_area rectangles for all cells tile to cover the entire
   * window.
   * Params:
   *   snapshot = a `GtkSnapshot` to draw to
   *   widget = the widget owning window
   *   backgroundArea = entire cell area $(LPAREN)including tree expanders and maybe
   *     padding on the sides$(RPAREN)
   *   cellArea = area normally rendered by a cell renderer
   *   flags = flags that affect rendering
   */
  void snapshot(Snapshot snapshot, Widget widget, Rectangle backgroundArea, Rectangle cellArea, CellRendererState flags)
  {
    gtk_cell_renderer_snapshot(cast(GtkCellRenderer*)cPtr, snapshot ? cast(GtkSnapshot*)snapshot.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, backgroundArea ? cast(GdkRectangle*)backgroundArea.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags);
  }

  /**
   * Starts editing the contents of this cell, through a new `GtkCellEditable`
   * widget created by the `GtkCellRenderer`Class.start_editing virtual function.
   * Params:
   *   event = a `GdkEvent`
   *   widget = widget that received the event
   *   path = widget-dependent string representation of the event location;
   *     e.g. for `GtkTreeView`, a string representation of `GtkTreePath`
   *   backgroundArea = background area as passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN)
   *   cellArea = cell area as passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN)
   *   flags = render flags
   * Returns: A new `GtkCellEditable` for editing this
   *   cell, or %NULL if editing is not possible
   */
  CellEditable startEditing(Event event, Widget widget, string path, Rectangle backgroundArea, Rectangle cellArea, CellRendererState flags)
  {
    GtkCellEditable* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = gtk_cell_renderer_start_editing(cast(GtkCellRenderer*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, _path, backgroundArea ? cast(GdkRectangle*)backgroundArea.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags);
    auto _retval = _cretval ? ObjectG.getDObject!CellEditable(cast(GtkCellEditable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Informs the cell renderer that the editing is stopped.
   * If canceled is %TRUE, the cell renderer will emit the
   * `GtkCellRenderer`::editing-canceled signal.
   * This function should be called by cell renderer implementations
   * in response to the `GtkCellEditable::editing-done` signal of
   * `GtkCellEditable`.
   * Params:
   *   canceled = %TRUE if the editing has been canceled
   */
  void stopEditing(bool canceled)
  {
    gtk_cell_renderer_stop_editing(cast(GtkCellRenderer*)cPtr, canceled);
  }

  /**
   * This signal gets emitted when the user cancels the process of editing a
   * cell.  For example, an editable cell renderer could be written to cancel
   * editing when the user presses Escape.
   * See also: [Gtk.CellRenderer.stopEditing].
   *   cellRenderer = the instance the signal is connected to
   */
  alias EditingCanceledCallback = void delegate(CellRenderer cellRenderer);

  /**
   * Connect to EditingCanceled signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEditingCanceled(EditingCanceledCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRenderer = getVal!CellRenderer(_paramVals);
      _dgClosure.dlg(cellRenderer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("editing-canceled", closure, after);
  }

  /**
   * This signal gets emitted when a cell starts to be edited.
   * The intended use of this signal is to do special setup
   * on editable, e.g. adding a `GtkEntryCompletion` or setting
   * up additional columns in a `GtkComboBox`.
   * See [Gtk.CellEditable.startEditing] for information on the lifecycle of
   * the editable and a way to do setup that doesn’t depend on the renderer.
   * Note that GTK doesn't guarantee that cell renderers will
   * continue to use the same kind of widget for editing in future
   * releases, therefore you should check the type of editable
   * before doing any specific setup, as in the following example:
   * |[<!-- language\="C" -->
   * static void
   * text_editing_started $(LPAREN)GtkCellRenderer *cell,
   * GtkCellEditable *editable,
   * const char      *path,
   * gpointer         data$(RPAREN)
   * {
   * if $(LPAREN)GTK_IS_ENTRY $(LPAREN)editable$(RPAREN)$(RPAREN)
   * {
   * GtkEntry *entry \= GTK_ENTRY $(LPAREN)editable$(RPAREN);
   * // ... create a GtkEntryCompletion
   * gtk_entry_set_completion $(LPAREN)entry, completion$(RPAREN);
   * }
   * }
   * ]|
   * Params
   *   editable = the `GtkCellEditable`
   *   path = the path identifying the edited cell
   *   cellRenderer = the instance the signal is connected to
   */
  alias EditingStartedCallback = void delegate(CellEditable editable, string path, CellRenderer cellRenderer);

  /**
   * Connect to EditingStarted signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEditingStarted(EditingStartedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRenderer = getVal!CellRenderer(_paramVals);
      auto editable = getVal!CellEditable(&_paramVals[1]);
      auto path = getVal!string(&_paramVals[2]);
      _dgClosure.dlg(editable, path, cellRenderer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("editing-started", closure, after);
  }
}
