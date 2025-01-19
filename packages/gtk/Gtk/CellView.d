module Gtk.CellView;

import GObject.ObjectG;
import Gdk.Texture;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellArea;
import Gtk.CellAreaContext;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A widget displaying a single row of a GtkTreeModel
 * A `GtkCellView` displays a single row of a `GtkTreeModel` using a `GtkCellArea`
 * and `GtkCellAreaContext`. A `GtkCellAreaContext` can be provided to the
 * `GtkCellView` at construction time in order to keep the cellview in context
 * of a group of cell views, this ensures that the renderers displayed will
 * be properly aligned with each other $(LPAREN)like the aligned cells in the menus
 * of `GtkComboBox`$(RPAREN).
 * `GtkCellView` is `GtkOrientable` in order to decide in which orientation
 * the underlying `GtkCellAreaContext` should be allocated. Taking the `GtkComboBox`
 * menu as an example, cellviews should be oriented horizontally if the menus are
 * listed top-to-bottom and thus all share the same width but may have separate
 * individual heights $(LPAREN)left-to-right menus should be allocated vertically since
 * they all share the same height but may have variable widths$(RPAREN).
 * ## CSS nodes
 * GtkCellView has a single CSS node with name cellview.

 * Deprecated: List views use widgets to display their contents.
 *   You can use [Gtk.Box] instead
 */
class CellView : Widget, CellLayout, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_view_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin CellLayoutT!();
  mixin OrientableT!();

  /**
   * Creates a new `GtkCellView` widget.
   * Returns: A newly created `GtkCellView` widget.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_cell_view_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkCellView` widget with a specific `GtkCellArea`
   * to layout cells and a specific `GtkCellAreaContext`.
   * Specifying the same context for a handful of cells lets
   * the underlying area synchronize the geometry for those cells,
   * in this way alignments with cellviews for other rows are
   * possible.
   * Params:
   *   area = the `GtkCellArea` to layout cells
   *   context = the `GtkCellAreaContext` in which to calculate cell geometry
   * Returns: A newly created `GtkCellView` widget.
   */
  static CellView newWithContext(CellArea area, CellAreaContext context)
  {
    GtkWidget* _cretval;
    _cretval = gtk_cell_view_new_with_context(area ? cast(GtkCellArea*)area.cPtr(false) : null, context ? cast(GtkCellAreaContext*)context.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!CellView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkCellView` widget, adds a `GtkCellRendererText`
   * to it, and makes it show markup. The text can be marked up with
   * the [Pango text markup language](https://docs.gtk.org/Pango/pango_markup.html).
   * Params:
   *   markup = the text to display in the cell view
   * Returns: A newly created `GtkCellView` widget.
   */
  static CellView newWithMarkup(string markup)
  {
    GtkWidget* _cretval;
    const(char)* _markup = markup.toCString(false);
    _cretval = gtk_cell_view_new_with_markup(_markup);
    auto _retval = _cretval ? ObjectG.getDObject!CellView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkCellView` widget, adds a `GtkCellRendererText`
   * to it, and makes it show text.
   * Params:
   *   text = the text to display in the cell view
   * Returns: A newly created `GtkCellView` widget.
   */
  static CellView newWithText(string text)
  {
    GtkWidget* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = gtk_cell_view_new_with_text(_text);
    auto _retval = _cretval ? ObjectG.getDObject!CellView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkCellView` widget, adds a `GtkCellRendererPixbuf`
   * to it, and makes it show texture.
   * Params:
   *   texture = the image to display in the cell view
   * Returns: A newly created `GtkCellView` widget.
   */
  static CellView newWithTexture(Texture texture)
  {
    GtkWidget* _cretval;
    _cretval = gtk_cell_view_new_with_texture(texture ? cast(GdkTexture*)texture.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!CellView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns a `GtkTreePath` referring to the currently
   * displayed row. If no row is currently displayed,
   * %NULL is returned.
   * Returns: the currently displayed row
   */
  TreePath getDisplayedRow()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_cell_view_get_displayed_row(cast(GtkCellView*)cPtr);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets whether cell_view is configured to draw all of its
   * cells in a sensitive state.
   * Returns: whether cell_view draws all of its
   *   cells in a sensitive state
   */
  bool getDrawSensitive()
  {
    bool _retval;
    _retval = gtk_cell_view_get_draw_sensitive(cast(GtkCellView*)cPtr);
    return _retval;
  }

  /**
   * Gets whether cell_view is configured to request space
   * to fit the entire `GtkTreeModel`.
   * Returns: whether cell_view requests space to fit
   *   the entire `GtkTreeModel`.
   */
  bool getFitModel()
  {
    bool _retval;
    _retval = gtk_cell_view_get_fit_model(cast(GtkCellView*)cPtr);
    return _retval;
  }

  /**
   * Returns the model for cell_view. If no model is used %NULL is
   * returned.
   * Returns: a `GtkTreeModel` used
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_cell_view_get_model(cast(GtkCellView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the row of the model that is currently displayed
   * by the `GtkCellView`. If the path is unset, then the
   * contents of the cellview “stick” at their last value;
   * this is not normally a desired result, but may be
   * a needed intermediate state if say, the model for
   * the `GtkCellView` becomes temporarily empty.
   * Params:
   *   path = a `GtkTreePath` or %NULL to unset.
   */
  void setDisplayedRow(TreePath path)
  {
    gtk_cell_view_set_displayed_row(cast(GtkCellView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Sets whether cell_view should draw all of its
   * cells in a sensitive state, this is used by `GtkComboBox` menus
   * to ensure that rows with insensitive cells that contain
   * children appear sensitive in the parent menu item.
   * Params:
   *   drawSensitive = whether to draw all cells in a sensitive state.
   */
  void setDrawSensitive(bool drawSensitive)
  {
    gtk_cell_view_set_draw_sensitive(cast(GtkCellView*)cPtr, drawSensitive);
  }

  /**
   * Sets whether cell_view should request space to fit the entire `GtkTreeModel`.
   * This is used by `GtkComboBox` to ensure that the cell view displayed on
   * the combo box’s button always gets enough space and does not resize
   * when selection changes.
   * Params:
   *   fitModel = whether cell_view should request space for the whole model.
   */
  void setFitModel(bool fitModel)
  {
    gtk_cell_view_set_fit_model(cast(GtkCellView*)cPtr, fitModel);
  }

  /**
   * Sets the model for cell_view.  If cell_view already has a model
   * set, it will remove it before setting the new model.  If model is
   * %NULL, then it will unset the old model.
   * Params:
   *   model = a `GtkTreeModel`
   */
  void setModel(TreeModel model)
  {
    gtk_cell_view_set_model(cast(GtkCellView*)cPtr, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
  }
}
