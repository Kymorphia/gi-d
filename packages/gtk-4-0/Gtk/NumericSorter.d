module Gtk.NumericSorter;

import Gid.gid;
import Gtk.Expression;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkNumericSorter` is a `GtkSorter` that compares numbers.
 * To obtain the numbers to compare, this sorter evaluates a
 * [Gtk.Expression].
 */
class NumericSorter : Sorter
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
    return gtk_numeric_sorter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new numeric sorter using the given expression.
   * Smaller numbers will be sorted first. You can call
   * [Gtk.NumericSorter.setSortOrder] to change this.
   * Params:
   *   expression = The expression to evaluate
   * Returns: a new `GtkNumericSorter`
   */
  this(Expression expression)
  {
    GtkNumericSorter* _cretval;
    _cretval = gtk_numeric_sorter_new(expression ? cast(GtkExpression*)expression.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the expression that is evaluated to obtain numbers from items.
   * Returns: a `GtkExpression`
   */
  Expression getExpression()
  {
    GtkExpression* _cretval;
    _cretval = gtk_numeric_sorter_get_expression(cast(GtkNumericSorter*)cPtr);
    auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether this sorter will sort smaller numbers first.
   * Returns: the order of the numbers
   */
  SortType getSortOrder()
  {
    GtkSortType _cretval;
    _cretval = gtk_numeric_sorter_get_sort_order(cast(GtkNumericSorter*)cPtr);
    SortType _retval = cast(SortType)_cretval;
    return _retval;
  }

  /**
   * Sets the expression that is evaluated to obtain numbers from items.
   * Unless an expression is set on self, the sorter will always
   * compare items as invalid.
   * The expression must have a return type that can be compared
   * numerically, such as %G_TYPE_INT or %G_TYPE_DOUBLE.
   * Params:
   *   expression = a `GtkExpression`
   */
  void setExpression(Expression expression)
  {
    gtk_numeric_sorter_set_expression(cast(GtkNumericSorter*)cPtr, expression ? cast(GtkExpression*)expression.cPtr(false) : null);
  }

  /**
   * Sets whether to sort smaller numbers before larger ones.
   * Params:
   *   sortOrder = whether to sort smaller numbers first
   */
  void setSortOrder(SortType sortOrder)
  {
    gtk_numeric_sorter_set_sort_order(cast(GtkNumericSorter*)cPtr, sortOrder);
  }
}
