module Gtk.CClosureExpression;

import Gid.gid;
import Gtk.Expression;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A variant of `GtkClosureExpression` using a C closure.
 */
class CClosureExpression : Expression
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CClosureExpression");

    super(cast(GtkExpression*)ptr, ownedRef);
  }
}
