module Gtk.BoolFilter;

import Gid.gid;
import Gtk.Expression;
import Gtk.Filter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkBoolFilter` evaluates a boolean `GtkExpression`
 * to determine whether to include items.
 */
class BoolFilter : Filter
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
    return gtk_bool_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new bool filter.
   * Params:
   *   expression = The expression to evaluate
   * Returns: a new `GtkBoolFilter`
   */
  this(Expression expression)
  {
    GtkBoolFilter* _cretval;
    _cretval = gtk_bool_filter_new(expression ? cast(GtkExpression*)expression.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the expression that the filter uses to evaluate if
   * an item should be filtered.
   * Returns: a `GtkExpression`
   */
  Expression getExpression()
  {
    GtkExpression* _cretval;
    _cretval = gtk_bool_filter_get_expression(cast(GtkBoolFilter*)cPtr);
    auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the filter inverts the expression.
   * Returns: %TRUE if the filter inverts
   */
  bool getInvert()
  {
    bool _retval;
    _retval = gtk_bool_filter_get_invert(cast(GtkBoolFilter*)cPtr);
    return _retval;
  }

  /**
   * Sets the expression that the filter uses to check if items
   * should be filtered.
   * The expression must have a value type of %G_TYPE_BOOLEAN.
   * Params:
   *   expression = a `GtkExpression`
   */
  void setExpression(Expression expression)
  {
    gtk_bool_filter_set_expression(cast(GtkBoolFilter*)cPtr, expression ? cast(GtkExpression*)expression.cPtr(false) : null);
  }

  /**
   * Sets whether the filter should invert the expression.
   * Params:
   *   invert = %TRUE to invert
   */
  void setInvert(bool invert)
  {
    gtk_bool_filter_set_invert(cast(GtkBoolFilter*)cPtr, invert);
  }
}
