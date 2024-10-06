module Gtk.CellRendererText;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.CellRenderer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders text in a cell
 * A `GtkCellRendererText` renders a given text in its cell, using the font, color and
 * style information provided by its properties. The text will be ellipsized if it is
 * too long and the `GtkCellRendererText:ellipsize` property allows it.
 * If the `GtkCellRenderer:mode` is %GTK_CELL_RENDERER_MODE_EDITABLE,
 * the `GtkCellRendererText` allows to edit its text using an entry.

 * Deprecated: List views use widgets to display their contents.
 *   You should use [Gtk.Inscription] or [Gtk.Label] instead
 */
class CellRendererText : CellRenderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_text_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererText`. Adjust how text is drawn using
   * object properties. Object properties can be
   * set globally $(LPAREN)with [GObject.ObjectG.set]$(RPAREN). Also, with `GtkTreeViewColumn`,
   * you can bind a property to a value in a `GtkTreeModel`. For example,
   * you can bind the “text” property on the cell renderer to a string
   * value in the model, thus rendering a different string in each row
   * of the `GtkTreeView`.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_text_new();
    this(_cretval, false);
  }

  /**
   * Sets the height of a renderer to explicitly be determined by the “font” and
   * “y_pad” property set on it.  Further changes in these properties do not
   * affect the height, so they must be accompanied by a subsequent call to this
   * function.  Using this function is inflexible, and should really only be used
   * if calculating the size of a cell is too slow $(LPAREN)ie, a massive number of cells
   * displayed$(RPAREN).  If number_of_rows is -1, then the fixed height is unset, and
   * the height is determined by the properties again.
   * Params:
   *   numberOfRows = Number of rows of text each cell renderer is allocated, or -1
   */
  void setFixedHeightFromFont(int numberOfRows)
  {
    gtk_cell_renderer_text_set_fixed_height_from_font(cast(GtkCellRendererText*)cPtr, numberOfRows);
  }

  /**
   * This signal is emitted after renderer has been edited.
   * It is the responsibility of the application to update the model
   * and store new_text at the position indicated by path.
   * Params
   *   path = the path identifying the edited cell
   *   newText = the new text
   *   cellRendererText = the instance the signal is connected to
   */
  alias EditedCallback = void delegate(string path, string newText, CellRendererText cellRendererText);

  /**
   * Connect to Edited signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectEdited(EditedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRendererText = getVal!CellRendererText(_paramVals);
      auto path = getVal!string(&_paramVals[1]);
      auto newText = getVal!string(&_paramVals[2]);
      _dgClosure.dlg(path, newText, cellRendererText);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("edited", closure, (flags & ConnectFlags.After) != 0);
  }
}
