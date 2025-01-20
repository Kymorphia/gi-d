module Gtk.BuilderScope;

public import Gtk.BuilderScopeIfaceProxy;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkBuilderScope` is an interface to provide language binding support
 * to `GtkBuilder`.
 * The goal of `GtkBuilderScope` is to look up programming-language-specific
 * values for strings that are given in a `GtkBuilder` UI file.
 * The primary intended audience is bindings that want to provide deeper
 * integration of `GtkBuilder` into the language.
 * A `GtkBuilderScope` instance may be used with multiple `GtkBuilder` objects,
 * even at once.
 * By default, GTK will use its own implementation of `GtkBuilderScope`
 * for the C language which can be created via [Gtk.BuilderCScope.new_].
 * If you implement `GtkBuilderScope` for a language binding, you
 * may want to $(LPAREN)partially$(RPAREN) derive from or fall back to a [Gtk.BuilderCScope],
 * as that class implements support for automatic lookups from C symbols.
 */
interface BuilderScope
{

  static GType getType()
  {
    return gtk_builder_scope_get_type();
  }
}
