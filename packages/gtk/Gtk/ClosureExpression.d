module Gtk.ClosureExpression;

import Gid.gid;
import Gtk.Expression;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An expression using a custom `GClosure` to compute the value from
 * its parameters.
 */
class ClosureExpression : Expression
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ClosureExpression");

    super(cast(GtkExpression*)ptr, ownedRef);
  }
}
