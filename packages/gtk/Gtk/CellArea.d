module Gtk.CellArea;

import GLib.List;
import GObject.DClosure;
import GObject.InitiallyUnowned;
import GObject.ObjectG;
import GObject.Value;
import Gdk.Event;
import Gdk.Rectangle;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellAreaContext;
import Gtk.CellEditable;
import Gtk.CellEditableT;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.CellRenderer;
import Gtk.Snapshot;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An abstract class for laying out `GtkCellRenderer`s
 * The `GtkCellArea` is an abstract class for [Gtk.CellLayout]
 * widgets $(LPAREN)also referred to as "layouting widgets"$(RPAREN) to interface with
 * an arbitrary number of [Gtk.CellRenderer]s and interact with the user
 * for a given [Gtk.TreeModel] row.
 * The cell area handles events, focus navigation, drawing and
 * size requests and allocations for a given row of data.
 * Usually users dont have to interact with the `GtkCellArea` directly
 * unless they are implementing a cell-layouting widget themselves.
 * ## Requesting area sizes
 * As outlined in
 * [GtkWidget’s geometry management section](class.Widget.html#height-for-width-geometry-management),
 * GTK uses a height-for-width
 * geometry management system to compute the sizes of widgets and user
 * interfaces. `GtkCellArea` uses the same semantics to calculate the
 * size of an area for an arbitrary number of `GtkTreeModel` rows.
 * When requesting the size of a cell area one needs to calculate
 * the size for a handful of rows, and this will be done differently by
 * different layouting widgets. For instance a [Gtk.TreeViewColumn]
 * always lines up the areas from top to bottom while a [Gtk.IconView]
 * on the other hand might enforce that all areas received the same
 * width and wrap the areas around, requesting height for more cell
 * areas when allocated less width.
 * It’s also important for areas to maintain some cell
 * alignments with areas rendered for adjacent rows $(LPAREN)cells can
 * appear “columnized” inside an area even when the size of
 * cells are different in each row$(RPAREN). For this reason the `GtkCellArea`
 * uses a [Gtk.CellAreaContext] object to store the alignments
 * and sizes along the way $(LPAREN)as well as the overall largest minimum
 * and natural size for all the rows which have been calculated
 * with the said context$(RPAREN).
 * The [Gtk.CellAreaContext] is an opaque object specific to the
 * `GtkCellArea` which created it $(LPAREN)see [Gtk.CellArea.createContext]$(RPAREN).
 * The owning cell-layouting widget can create as many contexts as
 * it wishes to calculate sizes of rows which should receive the
 * same size in at least one orientation $(LPAREN)horizontally or vertically$(RPAREN),
 * However, it’s important that the same [Gtk.CellAreaContext] which
 * was used to request the sizes for a given `GtkTreeModel` row be
 * used when rendering or processing events for that row.
 * In order to request the width of all the rows at the root level
 * of a `GtkTreeModel` one would do the following:
 * ```c
 * GtkTreeIter iter;
 * int minimum_width;
 * int natural_width;
 * valid \= gtk_tree_model_get_iter_first $(LPAREN)model, &iter$(RPAREN);
 * while $(LPAREN)valid$(RPAREN)
 * {
 * gtk_cell_area_apply_attributes $(LPAREN)area, model, &iter, FALSE, FALSE$(RPAREN);
 * gtk_cell_area_get_preferred_width $(LPAREN)area, context, widget, NULL, NULL$(RPAREN);
 * valid \= gtk_tree_model_iter_next $(LPAREN)model, &iter$(RPAREN);
 * }
 * gtk_cell_area_context_get_preferred_width $(LPAREN)context, &minimum_width, &natural_width$(RPAREN);
 * ```
 * Note that in this example it’s not important to observe the
 * returned minimum and natural width of the area for each row
 * unless the cell-layouting object is actually interested in the
 * widths of individual rows. The overall width is however stored
 * in the accompanying `GtkCellAreaContext` object and can be consulted
 * at any time.
 * This can be useful since `GtkCellLayout` widgets usually have to
 * support requesting and rendering rows in treemodels with an
 * exceedingly large amount of rows. The `GtkCellLayout` widget in
 * that case would calculate the required width of the rows in an
 * idle or timeout source $(LPAREN)see func@GLib.timeout_add$(RPAREN) and when the widget
 * is requested its actual width in vfunc@Gtk.Widget.measure
 * it can simply consult the width accumulated so far in the
 * `GtkCellAreaContext` object.
 * A simple example where rows are rendered from top to bottom and
 * take up the full width of the layouting widget would look like:
 * ```c
 * static void
 * foo_get_preferred_width $(LPAREN)GtkWidget *widget,
 * int       *minimum_size,
 * int       *natural_size$(RPAREN)
 * {
 * Foo *self \= FOO $(LPAREN)widget$(RPAREN);
 * FooPrivate *priv \= foo_get_instance_private $(LPAREN)self$(RPAREN);
 * foo_ensure_at_least_one_handfull_of_rows_have_been_requested $(LPAREN)self$(RPAREN);
 * gtk_cell_area_context_get_preferred_width $(LPAREN)priv->context, minimum_size, natural_size$(RPAREN);
 * }
 * ```
 * In the above example the `Foo` widget has to make sure that some
 * row sizes have been calculated $(LPAREN)the amount of rows that `Foo` judged
 * was appropriate to request space for in a single timeout iteration$(RPAREN)
 * before simply returning the amount of space required by the area via
 * the `GtkCellAreaContext`.
 * Requesting the height for width $(LPAREN)or width for height$(RPAREN) of an area is
 * a similar task except in this case the `GtkCellAreaContext` does not
 * store the data $(LPAREN)actually, it does not know how much space the layouting
 * widget plans to allocate it for every row. It’s up to the layouting
 * widget to render each row of data with the appropriate height and
 * width which was requested by the `GtkCellArea`$(RPAREN).
 * In order to request the height for width of all the rows at the
 * root level of a `GtkTreeModel` one would do the following:
 * ```c
 * GtkTreeIter iter;
 * int minimum_height;
 * int natural_height;
 * int full_minimum_height \= 0;
 * int full_natural_height \= 0;
 * valid \= gtk_tree_model_get_iter_first $(LPAREN)model, &iter$(RPAREN);
 * while $(LPAREN)valid$(RPAREN)
 * {
 * gtk_cell_area_apply_attributes $(LPAREN)area, model, &iter, FALSE, FALSE$(RPAREN);
 * gtk_cell_area_get_preferred_height_for_width $(LPAREN)area, context, widget,
 * width, &minimum_height, &natural_height$(RPAREN);
 * if $(LPAREN)width_is_for_allocation$(RPAREN)
 * cache_row_height $(LPAREN)&iter, minimum_height, natural_height$(RPAREN);
 * full_minimum_height +\= minimum_height;
 * full_natural_height +\= natural_height;
 * valid \= gtk_tree_model_iter_next $(LPAREN)model, &iter$(RPAREN);
 * }
 * ```
 * Note that in the above example we would need to cache the heights
 * returned for each row so that we would know what sizes to render the
 * areas for each row. However we would only want to really cache the
 * heights if the request is intended for the layouting widgets real
 * allocation.
 * In some cases the layouting widget is requested the height for an
 * arbitrary for_width, this is a special case for layouting widgets
 * who need to request size for tens of thousands  of rows. For this
 * case it’s only important that the layouting widget calculate
 * one reasonably sized chunk of rows and return that height
 * synchronously. The reasoning here is that any layouting widget is
 * at least capable of synchronously calculating enough height to fill
 * the screen height $(LPAREN)or scrolled window height$(RPAREN) in response to a single
 * call to vfunc@Gtk.Widget.measure. Returning
 * a perfect height for width that is larger than the screen area is
 * inconsequential since after the layouting receives an allocation
 * from a scrolled window it simply continues to drive the scrollbar
 * values while more and more height is required for the row heights
 * that are calculated in the background.
 * ## Rendering Areas
 * Once area sizes have been acquired at least for the rows in the
 * visible area of the layouting widget they can be rendered at
 * vfunc@Gtk.Widget.snapshot time.
 * A crude example of how to render all the rows at the root level
 * runs as follows:
 * ```c
 * GtkAllocation allocation;
 * GdkRectangle cell_area \= { 0, };
 * GtkTreeIter iter;
 * int minimum_width;
 * int natural_width;
 * gtk_widget_get_allocation $(LPAREN)widget, &allocation$(RPAREN);
 * cell_area.width \= allocation.width;
 * valid \= gtk_tree_model_get_iter_first $(LPAREN)model, &iter$(RPAREN);
 * while $(LPAREN)valid$(RPAREN)
 * {
 * cell_area.height \= get_cached_height_for_row $(LPAREN)&iter$(RPAREN);
 * gtk_cell_area_apply_attributes $(LPAREN)area, model, &iter, FALSE, FALSE$(RPAREN);
 * gtk_cell_area_render $(LPAREN)area, context, widget, cr,
 * &cell_area, &cell_area, state_flags, FALSE$(RPAREN);
 * cell_area.y +\= cell_area.height;
 * valid \= gtk_tree_model_iter_next $(LPAREN)model, &iter$(RPAREN);
 * }
 * ```
 * Note that the cached height in this example really depends on how
 * the layouting widget works. The layouting widget might decide to
 * give every row its minimum or natural height or, if the model content
 * is expected to fit inside the layouting widget without scrolling, it
 * would make sense to calculate the allocation for each row at
 * the time the widget is allocated using func@Gtk.distribute_natural_allocation.
 * ## Handling Events and Driving Keyboard Focus
 * Passing events to the area is as simple as handling events on any
 * normal widget and then passing them to the [Gtk.CellArea.event]
 * API as they come in. Usually `GtkCellArea` is only interested in
 * button events, however some customized derived areas can be implemented
 * who are interested in handling other events. Handling an event can
 * trigger the signal@Gtk.CellArea::focus-changed signal to fire; as well
 * as signal@Gtk.CellArea::add-editable in the case that an editable cell
 * was clicked and needs to start editing. You can call
 * [Gtk.CellArea.stopEditing] at any time to cancel any cell editing
 * that is currently in progress.
 * The `GtkCellArea` drives keyboard focus from cell to cell in a way
 * similar to `GtkWidget`. For layouting widgets that support giving
 * focus to cells it’s important to remember to pass `GTK_CELL_RENDERER_FOCUSED`
 * to the area functions for the row that has focus and to tell the
 * area to paint the focus at render time.
 * Layouting widgets that accept focus on cells should implement the
 * vfunc@Gtk.Widget.focus virtual method. The layouting widget is always
 * responsible for knowing where `GtkTreeModel` rows are rendered inside
 * the widget, so at vfunc@Gtk.Widget.focus time the layouting widget
 * should use the `GtkCellArea` methods to navigate focus inside the area
 * and then observe the [Gtk] to pass the focus to adjacent
 * rows and areas.
 * A basic example of how the vfunc@Gtk.Widget.focus virtual method
 * should be implemented:
 * ```
 * static gboolean
 * foo_focus $(LPAREN)GtkWidget       *widget,
 * GtkDirectionType direction$(RPAREN)
 * {
 * Foo *self \= FOO $(LPAREN)widget$(RPAREN);
 * FooPrivate *priv \= foo_get_instance_private $(LPAREN)self$(RPAREN);
 * int focus_row \= priv->focus_row;
 * gboolean have_focus \= FALSE;
 * if $(LPAREN)!gtk_widget_has_focus $(LPAREN)widget$(RPAREN)$(RPAREN)
 * gtk_widget_grab_focus $(LPAREN)widget$(RPAREN);
 * valid \= gtk_tree_model_iter_nth_child $(LPAREN)priv->model, &iter, NULL, priv->focus_row$(RPAREN);
 * while $(LPAREN)valid$(RPAREN)
 * {
 * gtk_cell_area_apply_attributes $(LPAREN)priv->area, priv->model, &iter, FALSE, FALSE$(RPAREN);
 * if $(LPAREN)gtk_cell_area_focus $(LPAREN)priv->area, direction$(RPAREN)$(RPAREN)
 * {
 * priv->focus_row \= focus_row;
 * have_focus \= TRUE;
 * break;
 * }
 * else
 * {
 * if $(LPAREN)direction \=\= GTK_DIR_RIGHT ||
 * direction \=\= GTK_DIR_LEFT$(RPAREN)
 * break;
 * else if $(LPAREN)direction \=\= GTK_DIR_UP ||
 * direction \=\= GTK_DIR_TAB_BACKWARD$(RPAREN)
 * {
 * if $(LPAREN)focus_row \=\= 0$(RPAREN)
 * break;
 * else
 * {
 * focus_row--;
 * valid \= gtk_tree_model_iter_nth_child $(LPAREN)priv->model, &iter, NULL, focus_row$(RPAREN);
 * }
 * }
 * else
 * {
 * if $(LPAREN)focus_row \=\= last_row$(RPAREN)
 * break;
 * else
 * {
 * focus_row++;
 * valid \= gtk_tree_model_iter_next $(LPAREN)priv->model, &iter$(RPAREN);
 * }
 * }
 * }
 * }
 * return have_focus;
 * }
 * ```
 * Note that the layouting widget is responsible for matching the
 * `GtkDirectionType` values to the way it lays out its cells.
 * ## Cell Properties
 * The `GtkCellArea` introduces cell properties for `GtkCellRenderer`s.
 * This provides some general interfaces for defining the relationship
 * cell areas have with their cells. For instance in a [Gtk.CellAreaBox]
 * a cell might “expand” and receive extra space when the area is allocated
 * more than its full natural request, or a cell might be configured to “align”
 * with adjacent rows which were requested and rendered with the same
 * `GtkCellAreaContext`.
 * Use [Gtk.CellAreaClass.installCellProperty] to install cell
 * properties for a cell area class and [Gtk.CellAreaClass.findCellProperty]
 * or [Gtk.CellAreaClass.listCellProperties] to get information about
 * existing cell properties.
 * To set the value of a cell property, use [Gtk.CellArea.cellSetProperty],
 * [Gtk.CellArea.cellSet] or [Gtk.CellArea.cellSetValist]. To obtain
 * the value of a cell property, use [Gtk.CellArea.cellGetProperty]
 * [Gtk.CellArea.cellGet] or [Gtk.CellArea.cellGetValist].

 * Deprecated: List views use widgets for displaying their
 *   contents
 */
class CellArea : InitiallyUnowned, Buildable, CellLayout
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
    return gtk_cell_area_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!();
  mixin CellLayoutT!();

  /**
   * Activates area, usually by activating the currently focused
   * cell, however some subclasses which embed widgets in the area
   * can also activate a widget if it currently has the focus.
   * Params:
   *   context = the `GtkCellArea`Context in context with the current row data
   *   widget = the `GtkWidget` that area is rendering on
   *   cellArea = the size and location of area relative to widget’s allocation
   *   flags = the `GtkCellRenderer`State flags for area for this row of data.
   *   editOnly = if %TRUE then only cell renderers that are %GTK_CELL_RENDERER_MODE_EDITABLE
   *     will be activated.
   * Returns: Whether area was successfully activated.
   */
  bool activate(CellAreaContext context, Widget widget, Rectangle cellArea, CellRendererState flags, bool editOnly)
  {
    bool _retval;
    _retval = gtk_cell_area_activate(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags, editOnly);
    return _retval;
  }

  /**
   * This is used by `GtkCellArea` subclasses when handling events
   * to activate cells, the base `GtkCellArea` class activates cells
   * for keyboard events for free in its own GtkCellArea->activate$(LPAREN)$(RPAREN)
   * implementation.
   * Params:
   *   widget = the `GtkWidget` that area is rendering onto
   *   renderer = the `GtkCellRenderer` in area to activate
   *   event = the `GdkEvent` for which cell activation should occur
   *   cellArea = the `GdkRectangle` in widget relative coordinates
   *     of renderer for the current row.
   *   flags = the `GtkCellRenderer`State for renderer
   * Returns: whether cell activation was successful
   */
  bool activateCell(Widget widget, CellRenderer renderer, Event event, Rectangle cellArea, CellRendererState flags)
  {
    bool _retval;
    _retval = gtk_cell_area_activate_cell(cast(GtkCellArea*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, event ? cast(GdkEvent*)event.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags);
    return _retval;
  }

  /**
   * Adds renderer to area with the default child cell properties.
   * Params:
   *   renderer = the `GtkCellRenderer` to add to area
   */
  void add(CellRenderer renderer)
  {
    gtk_cell_area_add(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
  }

  /**
   * Adds sibling to renderer’s focusable area, focus will be drawn
   * around renderer and all of its siblings if renderer can
   * focus for a given row.
   * Events handled by focus siblings can also activate the given
   * focusable renderer.
   * Params:
   *   renderer = the `GtkCellRenderer` expected to have focus
   *   sibling = the `GtkCellRenderer` to add to renderer’s focus area
   */
  void addFocusSibling(CellRenderer renderer, CellRenderer sibling)
  {
    gtk_cell_area_add_focus_sibling(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, sibling ? cast(GtkCellRenderer*)sibling.cPtr(false) : null);
  }

  /**
   * Applies any connected attributes to the renderers in
   * area by pulling the values from tree_model.
   * Params:
   *   treeModel = the `GtkTreeModel` to pull values from
   *   iter = the `GtkTreeIter` in tree_model to apply values for
   *   isExpander = whether iter has children
   *   isExpanded = whether iter is expanded in the view and
   *     children are visible
   */
  void applyAttributes(TreeModel treeModel, TreeIter iter, bool isExpander, bool isExpanded)
  {
    gtk_cell_area_apply_attributes(cast(GtkCellArea*)cPtr, treeModel ? cast(GtkTreeModel*)(cast(ObjectG)treeModel).cPtr(false) : null, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, isExpander, isExpanded);
  }

  /**
   * Connects an attribute to apply values from column for the
   * `GtkTreeModel` in use.
   * Params:
   *   renderer = the `GtkCellRenderer` to connect an attribute for
   *   attribute = the attribute name
   *   column = the `GtkTreeModel` column to fetch attribute values from
   */
  void attributeConnect(CellRenderer renderer, string attribute, int column)
  {
    const(char)* _attribute = attribute.toCString(false);
    gtk_cell_area_attribute_connect(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, _attribute, column);
  }

  /**
   * Disconnects attribute for the renderer in area so that
   * attribute will no longer be updated with values from the
   * model.
   * Params:
   *   renderer = the `GtkCellRenderer` to disconnect an attribute for
   *   attribute = the attribute name
   */
  void attributeDisconnect(CellRenderer renderer, string attribute)
  {
    const(char)* _attribute = attribute.toCString(false);
    gtk_cell_area_attribute_disconnect(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, _attribute);
  }

  /**
   * Returns the model column that an attribute has been mapped to,
   * or -1 if the attribute is not mapped.
   * Params:
   *   renderer = a `GtkCellRenderer`
   *   attribute = an attribute on the renderer
   * Returns: the model column, or -1
   */
  int attributeGetColumn(CellRenderer renderer, string attribute)
  {
    int _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = gtk_cell_area_attribute_get_column(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, _attribute);
    return _retval;
  }

  /**
   * Gets the value of a cell property for renderer in area.
   * Params:
   *   renderer = a `GtkCellRenderer` inside area
   *   propertyName = the name of the property to get
   *   value = a location to return the value
   */
  void cellGetProperty(CellRenderer renderer, string propertyName, Value value)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    gtk_cell_area_cell_get_property(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, _propertyName, value ? cast(GValue*)value.cPtr(false) : null);
  }

  /**
   * Sets a cell property for renderer in area.
   * Params:
   *   renderer = a `GtkCellRenderer` inside area
   *   propertyName = the name of the cell property to set
   *   value = the value to set the cell property to
   */
  void cellSetProperty(CellRenderer renderer, string propertyName, Value value)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    gtk_cell_area_cell_set_property(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, _propertyName, value ? cast(GValue*)value.cPtr(false) : null);
  }

  /**
   * This is sometimes needed for cases where rows need to share
   * alignments in one orientation but may be separately grouped
   * in the opposing orientation.
   * For instance, `GtkIconView` creates all icons $(LPAREN)rows$(RPAREN) to have
   * the same width and the cells theirin to have the same
   * horizontal alignments. However each row of icons may have
   * a separate collective height. `GtkIconView` uses this to
   * request the heights of each row based on a context which
   * was already used to request all the row widths that are
   * to be displayed.
   * Params:
   *   context = the `GtkCellArea`Context to copy
   * Returns: a newly created `GtkCellArea`Context copy of context.
   */
  CellAreaContext copyContext(CellAreaContext context)
  {
    GtkCellAreaContext* _cretval;
    _cretval = gtk_cell_area_copy_context(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!CellAreaContext(cast(GtkCellAreaContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a `GtkCellArea`Context to be used with area for
   * all purposes. `GtkCellArea`Context stores geometry information
   * for rows for which it was operated on, it is important to use
   * the same context for the same row of data at all times $(LPAREN)i.e.
   * one should render and handle events with the same `GtkCellArea`Context
   * which was used to request the size of those rows of data$(RPAREN).
   * Returns: a newly created `GtkCellArea`Context which can be used with area.
   */
  CellAreaContext createContext()
  {
    GtkCellAreaContext* _cretval;
    _cretval = gtk_cell_area_create_context(cast(GtkCellArea*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CellAreaContext(cast(GtkCellAreaContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Delegates event handling to a `GtkCellArea`.
   * Params:
   *   context = the `GtkCellArea`Context for this row of data.
   *   widget = the `GtkWidget` that area is rendering to
   *   event = the `GdkEvent` to handle
   *   cellArea = the widget relative coordinates for area
   *   flags = the `GtkCellRenderer`State for area in this row.
   * Returns: %TRUE if the event was handled by area.
   */
  int event(CellAreaContext context, Widget widget, Event event, Rectangle cellArea, CellRendererState flags)
  {
    int _retval;
    _retval = gtk_cell_area_event(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, event ? cast(GdkEvent*)event.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags);
    return _retval;
  }

  /**
   * This should be called by the area’s owning layout widget
   * when focus is to be passed to area, or moved within area
   * for a given direction and row data.
   * Implementing `GtkCellArea` classes should implement this
   * method to receive and navigate focus in its own way particular
   * to how it lays out cells.
   * Params:
   *   direction = the `GtkDirectionType`
   * Returns: %TRUE if focus remains inside area as a result of this call.
   */
  bool focus(DirectionType direction)
  {
    bool _retval;
    _retval = gtk_cell_area_focus(cast(GtkCellArea*)cPtr, direction);
    return _retval;
  }

  /**
   * Calls callback for every `GtkCellRenderer` in area.
   * Params:
   *   callback = the `GtkCellCallback` to call
   */
  void foreach_(CellCallback callback)
  {
    static CellCallback _static_callback;

    extern(C) bool _callbackCallback(GtkCellRenderer* renderer, void* data)
    {
      bool _retval = _static_callback(renderer ? ObjectG.getDObject!CellRenderer(cast(void*)renderer, false) : null);
      return _retval;
    }

    _static_callback = callback;
    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_cell_area_foreach(cast(GtkCellArea*)cPtr, &_callbackCallback, _callback);
    _static_callback = null;
  }

  /**
   * Calls callback for every `GtkCellRenderer` in area with the
   * allocated rectangle inside cell_area.
   * Params:
   *   context = the `GtkCellArea`Context for this row of data.
   *   widget = the `GtkWidget` that area is rendering to
   *   cellArea = the widget relative coordinates and size for area
   *   backgroundArea = the widget relative coordinates of the background area
   *   callback = the `GtkCellAllocCallback` to call
   */
  void foreachAlloc(CellAreaContext context, Widget widget, Rectangle cellArea, Rectangle backgroundArea, CellAllocCallback callback)
  {
    static CellAllocCallback _static_callback;

    extern(C) bool _callbackCallback(GtkCellRenderer* renderer, const(GdkRectangle)* cellArea, const(GdkRectangle)* cellBackground, void* data)
    {
      bool _retval = _static_callback(renderer ? ObjectG.getDObject!CellRenderer(cast(void*)renderer, false) : null, cellArea ? new Rectangle(cast(void*)cellArea, false) : null, cellBackground ? new Rectangle(cast(void*)cellBackground, false) : null);
      return _retval;
    }

    _static_callback = callback;
    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_cell_area_foreach_alloc(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, backgroundArea ? cast(GdkRectangle*)backgroundArea.cPtr(false) : null, &_callbackCallback, _callback);
    _static_callback = null;
  }

  /**
   * Derives the allocation of renderer inside area if area
   * were to be rendered in cell_area.
   * Params:
   *   context = the `GtkCellArea`Context used to hold sizes for area.
   *   widget = the `GtkWidget` that area is rendering on
   *   renderer = the `GtkCellRenderer` to get the allocation for
   *   cellArea = the whole allocated area for area in widget
   *     for this row
   *   allocation = where to store the allocation for renderer
   */
  void getCellAllocation(CellAreaContext context, Widget widget, CellRenderer renderer, Rectangle cellArea, out Rectangle allocation)
  {
    GdkRectangle _allocation;
    gtk_cell_area_get_cell_allocation(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, &_allocation);
    allocation = new Rectangle(cast(void*)&_allocation, false);
  }

  /**
   * Gets the `GtkCellRenderer` at x and y coordinates inside area and optionally
   * returns the full cell allocation for it inside cell_area.
   * Params:
   *   context = the `GtkCellArea`Context used to hold sizes for area.
   *   widget = the `GtkWidget` that area is rendering on
   *   cellArea = the whole allocated area for area in widget
   *     for this row
   *   x = the x position
   *   y = the y position
   *   allocArea = where to store the inner allocated area of the
   *     returned cell renderer
   * Returns: the `GtkCellRenderer` at x and y.
   */
  CellRenderer getCellAtPosition(CellAreaContext context, Widget widget, Rectangle cellArea, int x, int y, out Rectangle allocArea)
  {
    GtkCellRenderer* _cretval;
    GdkRectangle _allocArea;
    _cretval = gtk_cell_area_get_cell_at_position(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, x, y, &_allocArea);
    auto _retval = _cretval ? ObjectG.getDObject!CellRenderer(cast(GtkCellRenderer*)_cretval, false) : null;
    allocArea = new Rectangle(cast(void*)&_allocArea, false);
    return _retval;
  }

  /**
   * Gets the current `GtkTreePath` string for the currently
   * applied `GtkTreeIter`, this is implicitly updated when
   * [Gtk.CellArea.applyAttributes] is called and can be
   * used to interact with renderers from `GtkCellArea`
   * subclasses.
   * Returns: The current `GtkTreePath` string for the current
   *   attributes applied to area. This string belongs to the area and
   *   should not be freed.
   */
  string getCurrentPathString()
  {
    const(char)* _cretval;
    _cretval = gtk_cell_area_get_current_path_string(cast(GtkCellArea*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the `GtkCellEditable` widget currently used
   * to edit the currently edited cell.
   * Returns: The currently active `GtkCellEditable` widget
   */
  CellEditable getEditWidget()
  {
    GtkCellEditable* _cretval;
    _cretval = gtk_cell_area_get_edit_widget(cast(GtkCellArea*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CellEditable(cast(GtkCellEditable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GtkCellRenderer` in area that is currently
   * being edited.
   * Returns: The currently edited `GtkCellRenderer`
   */
  CellRenderer getEditedCell()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_area_get_edited_cell(cast(GtkCellArea*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CellRenderer(cast(GtkCellRenderer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the currently focused cell for area
   * Returns: the currently focused cell in area.
   */
  CellRenderer getFocusCell()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_area_get_focus_cell(cast(GtkCellArea*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CellRenderer(cast(GtkCellRenderer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GtkCellRenderer` which is expected to be focusable
   * for which renderer is, or may be a sibling.
   * This is handy for `GtkCellArea` subclasses when handling events,
   * after determining the renderer at the event location it can
   * then chose to activate the focus cell for which the event
   * cell may have been a sibling.
   * Params:
   *   renderer = the `GtkCellRenderer`
   * Returns: the `GtkCellRenderer`
   *   for which renderer is a sibling
   */
  CellRenderer getFocusFromSibling(CellRenderer renderer)
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_area_get_focus_from_sibling(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!CellRenderer(cast(GtkCellRenderer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the focus sibling cell renderers for renderer.
   * Params:
   *   renderer = the `GtkCellRenderer` expected to have focus
   * Returns: A `GList` of `GtkCellRenderer`s.
   *   The returned list is internal and should not be freed.
   */
  List!(CellRenderer, GtkCellRenderer) getFocusSiblings(CellRenderer renderer)
  {
    const(GList)* _cretval;
    _cretval = gtk_cell_area_get_focus_siblings(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
    List!(CellRenderer, GtkCellRenderer) _retval = new List!(CellRenderer, GtkCellRenderer)(cast(GList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Retrieves a cell area’s initial minimum and natural height.
   * area will store some geometrical information in context along the way;
   * when requesting sizes over an arbitrary number of rows, it’s not important
   * to check the minimum_height and natural_height of this call but rather to
   * consult [Gtk.CellAreaContext.getPreferredHeight] after a series of
   * requests.
   * Params:
   *   context = the `GtkCellArea`Context to perform this request with
   *   widget = the `GtkWidget` where area will be rendering
   *   minimumHeight = location to store the minimum height
   *   naturalHeight = location to store the natural height
   */
  void getPreferredHeight(CellAreaContext context, Widget widget, out int minimumHeight, out int naturalHeight)
  {
    gtk_cell_area_get_preferred_height(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cast(int*)&minimumHeight, cast(int*)&naturalHeight);
  }

  /**
   * Retrieves a cell area’s minimum and natural height if it would be given
   * the specified width.
   * area stores some geometrical information in context along the way
   * while calling [Gtk.CellArea.getPreferredWidth]. It’s important to
   * perform a series of [Gtk.CellArea.getPreferredWidth] requests with
   * context first and then call [Gtk.CellArea.getPreferredHeightForWidth]
   * on each cell area individually to get the height for width of each
   * fully requested row.
   * If at some point, the width of a single row changes, it should be
   * requested with [Gtk.CellArea.getPreferredWidth] again and then
   * the full width of the requested rows checked again with
   * [Gtk.CellAreaContext.getPreferredWidth].
   * Params:
   *   context = the `GtkCellArea`Context which has already been requested for widths.
   *   widget = the `GtkWidget` where area will be rendering
   *   width = the width for which to check the height of this area
   *   minimumHeight = location to store the minimum height
   *   naturalHeight = location to store the natural height
   */
  void getPreferredHeightForWidth(CellAreaContext context, Widget widget, int width, out int minimumHeight, out int naturalHeight)
  {
    gtk_cell_area_get_preferred_height_for_width(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, width, cast(int*)&minimumHeight, cast(int*)&naturalHeight);
  }

  /**
   * Retrieves a cell area’s initial minimum and natural width.
   * area will store some geometrical information in context along the way;
   * when requesting sizes over an arbitrary number of rows, it’s not important
   * to check the minimum_width and natural_width of this call but rather to
   * consult [Gtk.CellAreaContext.getPreferredWidth] after a series of
   * requests.
   * Params:
   *   context = the `GtkCellArea`Context to perform this request with
   *   widget = the `GtkWidget` where area will be rendering
   *   minimumWidth = location to store the minimum width
   *   naturalWidth = location to store the natural width
   */
  void getPreferredWidth(CellAreaContext context, Widget widget, out int minimumWidth, out int naturalWidth)
  {
    gtk_cell_area_get_preferred_width(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cast(int*)&minimumWidth, cast(int*)&naturalWidth);
  }

  /**
   * Retrieves a cell area’s minimum and natural width if it would be given
   * the specified height.
   * area stores some geometrical information in context along the way
   * while calling [Gtk.CellArea.getPreferredHeight]. It’s important to
   * perform a series of [Gtk.CellArea.getPreferredHeight] requests with
   * context first and then call [Gtk.CellArea.getPreferredWidthForHeight]
   * on each cell area individually to get the height for width of each
   * fully requested row.
   * If at some point, the height of a single row changes, it should be
   * requested with [Gtk.CellArea.getPreferredHeight] again and then
   * the full height of the requested rows checked again with
   * [Gtk.CellAreaContext.getPreferredHeight].
   * Params:
   *   context = the `GtkCellArea`Context which has already been requested for widths.
   *   widget = the `GtkWidget` where area will be rendering
   *   height = the height for which to check the width of this area
   *   minimumWidth = location to store the minimum width
   *   naturalWidth = location to store the natural width
   */
  void getPreferredWidthForHeight(CellAreaContext context, Widget widget, int height, out int minimumWidth, out int naturalWidth)
  {
    gtk_cell_area_get_preferred_width_for_height(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, height, cast(int*)&minimumWidth, cast(int*)&naturalWidth);
  }

  /**
   * Gets whether the area prefers a height-for-width layout
   * or a width-for-height layout.
   * Returns: The `GtkSizeRequestMode` preferred by area.
   */
  SizeRequestMode getRequestMode()
  {
    GtkSizeRequestMode _cretval;
    _cretval = gtk_cell_area_get_request_mode(cast(GtkCellArea*)cPtr);
    SizeRequestMode _retval = cast(SizeRequestMode)_cretval;
    return _retval;
  }

  /**
   * Checks if area contains renderer.
   * Params:
   *   renderer = the `GtkCellRenderer` to check
   * Returns: %TRUE if renderer is in the area.
   */
  bool hasRenderer(CellRenderer renderer)
  {
    bool _retval;
    _retval = gtk_cell_area_has_renderer(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
    return _retval;
  }

  /**
   * This is a convenience function for `GtkCellArea` implementations
   * to get the inner area where a given `GtkCellRenderer` will be
   * rendered. It removes any padding previously added by [Gtk.CellArea.requestRenderer].
   * Params:
   *   widget = the `GtkWidget` that area is rendering onto
   *   cellArea = the widget relative coordinates where one of area’s cells
   *     is to be placed
   *   innerArea = the return location for the inner cell area
   */
  void innerCellArea(Widget widget, Rectangle cellArea, out Rectangle innerArea)
  {
    GdkRectangle _innerArea;
    gtk_cell_area_inner_cell_area(cast(GtkCellArea*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, &_innerArea);
    innerArea = new Rectangle(cast(void*)&_innerArea, false);
  }

  /**
   * Returns whether the area can do anything when activated,
   * after applying new attributes to area.
   * Returns: whether area can do anything when activated.
   */
  bool isActivatable()
  {
    bool _retval;
    _retval = gtk_cell_area_is_activatable(cast(GtkCellArea*)cPtr);
    return _retval;
  }

  /**
   * Returns whether sibling is one of renderer’s focus siblings
   * $(LPAREN)see [Gtk.CellArea.addFocusSibling]$(RPAREN).
   * Params:
   *   renderer = the `GtkCellRenderer` expected to have focus
   *   sibling = the `GtkCellRenderer` to check against renderer’s sibling list
   * Returns: %TRUE if sibling is a focus sibling of renderer
   */
  bool isFocusSibling(CellRenderer renderer, CellRenderer sibling)
  {
    bool _retval;
    _retval = gtk_cell_area_is_focus_sibling(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, sibling ? cast(GtkCellRenderer*)sibling.cPtr(false) : null);
    return _retval;
  }

  /**
   * Removes renderer from area.
   * Params:
   *   renderer = the `GtkCellRenderer` to remove from area
   */
  void remove(CellRenderer renderer)
  {
    gtk_cell_area_remove(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
  }

  /**
   * Removes sibling from renderer’s focus sibling list
   * $(LPAREN)see [Gtk.CellArea.addFocusSibling]$(RPAREN).
   * Params:
   *   renderer = the `GtkCellRenderer` expected to have focus
   *   sibling = the `GtkCellRenderer` to remove from renderer’s focus area
   */
  void removeFocusSibling(CellRenderer renderer, CellRenderer sibling)
  {
    gtk_cell_area_remove_focus_sibling(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, sibling ? cast(GtkCellRenderer*)sibling.cPtr(false) : null);
  }

  /**
   * This is a convenience function for `GtkCellArea` implementations
   * to request size for cell renderers. It’s important to use this
   * function to request size and then use [Gtk.CellArea.innerCellArea]
   * at render and event time since this function will add padding
   * around the cell for focus painting.
   * Params:
   *   renderer = the `GtkCellRenderer` to request size for
   *   orientation = the `GtkOrientation` in which to request size
   *   widget = the `GtkWidget` that area is rendering onto
   *   forSize = the allocation contextual size to request for, or -1 if
   *     the base request for the orientation is to be returned.
   *   minimumSize = location to store the minimum size
   *   naturalSize = location to store the natural size
   */
  void requestRenderer(CellRenderer renderer, Orientation orientation, Widget widget, int forSize, out int minimumSize, out int naturalSize)
  {
    gtk_cell_area_request_renderer(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null, orientation, widget ? cast(GtkWidget*)widget.cPtr(false) : null, forSize, cast(int*)&minimumSize, cast(int*)&naturalSize);
  }

  /**
   * Explicitly sets the currently focused cell to renderer.
   * This is generally called by implementations of
   * `GtkCellAreaClass.focus$(LPAREN)$(RPAREN)` or `GtkCellAreaClass.event$(LPAREN)$(RPAREN)`,
   * however it can also be used to implement functions such
   * as [Gtk.TreeView.setCursorOnCell].
   * Params:
   *   renderer = the `GtkCellRenderer` to give focus to
   */
  void setFocusCell(CellRenderer renderer)
  {
    gtk_cell_area_set_focus_cell(cast(GtkCellArea*)cPtr, renderer ? cast(GtkCellRenderer*)renderer.cPtr(false) : null);
  }

  /**
   * Snapshots area’s cells according to area’s layout onto at
   * the given coordinates.
   * Params:
   *   context = the `GtkCellArea`Context for this row of data.
   *   widget = the `GtkWidget` that area is rendering to
   *   snapshot = the `GtkSnapshot` to draw to
   *   backgroundArea = the widget relative coordinates for area’s background
   *   cellArea = the widget relative coordinates for area
   *   flags = the `GtkCellRenderer`State for area in this row.
   *   paintFocus = whether area should paint focus on focused cells for focused rows or not.
   */
  void snapshot(CellAreaContext context, Widget widget, Snapshot snapshot, Rectangle backgroundArea, Rectangle cellArea, CellRendererState flags, bool paintFocus)
  {
    gtk_cell_area_snapshot(cast(GtkCellArea*)cPtr, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null, widget ? cast(GtkWidget*)widget.cPtr(false) : null, snapshot ? cast(GtkSnapshot*)snapshot.cPtr(false) : null, backgroundArea ? cast(GdkRectangle*)backgroundArea.cPtr(false) : null, cellArea ? cast(GdkRectangle*)cellArea.cPtr(false) : null, flags, paintFocus);
  }

  /**
   * Explicitly stops the editing of the currently edited cell.
   * If canceled is %TRUE, the currently edited cell renderer
   * will emit the ::editing-canceled signal, otherwise the
   * the ::editing-done signal will be emitted on the current
   * edit widget.
   * See [Gtk.CellArea.getEditedCell] and [Gtk.CellArea.getEditWidget].
   * Params:
   *   canceled = whether editing was canceled.
   */
  void stopEditing(bool canceled)
  {
    gtk_cell_area_stop_editing(cast(GtkCellArea*)cPtr, canceled);
  }

  /**
   * Indicates that editing has started on renderer and that editable
   * should be added to the owning cell-layouting widget at cell_area.
   * Params
   *   renderer = the `GtkCellRenderer` that started the edited
   *   editable = the `GtkCellEditable` widget to add
   *   area = the `GtkWidget` relative `GdkRectangle` coordinates
   *     where editable should be added
   *   path = the `GtkTreePath` string this edit was initiated for
   *   cellArea = the instance the signal is connected to
   */
  alias AddEditableCallback = void delegate(CellRenderer renderer, CellEditable editable, Rectangle area, string path, CellArea cellArea);

  /**
   * Connect to AddEditable signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAddEditable(AddEditableCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellArea = getVal!CellArea(_paramVals);
      auto renderer = getVal!CellRenderer(&_paramVals[1]);
      auto editable = getVal!CellEditable(&_paramVals[2]);
      auto area = getVal!Rectangle(&_paramVals[3]);
      auto path = getVal!string(&_paramVals[4]);
      _dgClosure.dlg(renderer, editable, area, path, cellArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("add-editable", closure, after);
  }

  /**
   * This signal is emitted whenever applying attributes to area from model
   * Params
   *   model = the `GtkTreeModel` to apply the attributes from
   *   iter = the `GtkTreeIter` indicating which row to apply the attributes of
   *   isExpander = whether the view shows children for this row
   *   isExpanded = whether the view is currently showing the children of this row
   *   cellArea = the instance the signal is connected to
   */
  alias ApplyAttributesCallback = void delegate(TreeModel model, TreeIter iter, bool isExpander, bool isExpanded, CellArea cellArea);

  /**
   * Connect to ApplyAttributes signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectApplyAttributes(ApplyAttributesCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellArea = getVal!CellArea(_paramVals);
      auto model = getVal!TreeModel(&_paramVals[1]);
      auto iter = getVal!TreeIter(&_paramVals[2]);
      auto isExpander = getVal!bool(&_paramVals[3]);
      auto isExpanded = getVal!bool(&_paramVals[4]);
      _dgClosure.dlg(model, iter, isExpander, isExpanded, cellArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("apply-attributes", closure, after);
  }

  /**
   * Indicates that focus changed on this area. This signal
   * is emitted either as a result of focus handling or event
   * handling.
   * It's possible that the signal is emitted even if the
   * currently focused renderer did not change, this is
   * because focus may change to the same renderer in the
   * same cell area for a different row of data.
   * Params
   *   renderer = the `GtkCellRenderer` that has focus
   *   path = the current `GtkTreePath` string set for area
   *   cellArea = the instance the signal is connected to
   */
  alias FocusChangedCallback = void delegate(CellRenderer renderer, string path, CellArea cellArea);

  /**
   * Connect to FocusChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectFocusChanged(FocusChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellArea = getVal!CellArea(_paramVals);
      auto renderer = getVal!CellRenderer(&_paramVals[1]);
      auto path = getVal!string(&_paramVals[2]);
      _dgClosure.dlg(renderer, path, cellArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("focus-changed", closure, after);
  }

  /**
   * Indicates that editing finished on renderer and that editable
   * should be removed from the owning cell-layouting widget.
   * Params
   *   renderer = the `GtkCellRenderer` that finished editeding
   *   editable = the `GtkCellEditable` widget to remove
   *   cellArea = the instance the signal is connected to
   */
  alias RemoveEditableCallback = void delegate(CellRenderer renderer, CellEditable editable, CellArea cellArea);

  /**
   * Connect to RemoveEditable signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRemoveEditable(RemoveEditableCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellArea = getVal!CellArea(_paramVals);
      auto renderer = getVal!CellRenderer(&_paramVals[1]);
      auto editable = getVal!CellEditable(&_paramVals[2]);
      _dgClosure.dlg(renderer, editable, cellArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("remove-editable", closure, after);
  }
}
