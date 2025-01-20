module Gtk.ConstantExpression;

import GObject.Value;
import Gid.gid;
import Gtk.Expression;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A constant value in a `GtkExpression`.
 */
class ConstantExpression : Expression
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ConstantExpression");

    super(cast(GtkExpression*)ptr, ownedRef);
  }

  /**
   * Creates an expression that always evaluates to the given `value`.
   * Params:
   *   value = a `GValue`
   * Returns: a new `GtkExpression`
   */
  static ConstantExpression newForValue(Value value)
  {
    GtkExpression* _cretval;
    _cretval = gtk_constant_expression_new_for_value(value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? new ConstantExpression(cast(GtkExpression*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the value that a constant expression evaluates to.
   * Returns: the value
   */
  Value getValue()
  {
    const(GValue)* _cretval;
    _cretval = gtk_constant_expression_get_value(cast(GtkExpression*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
