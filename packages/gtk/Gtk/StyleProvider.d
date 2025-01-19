module Gtk.StyleProvider;

public import Gtk.StyleProviderIfaceProxy;
import GObject.DClosure;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkStyleProvider` is an interface for style information used by
 * `GtkStyleContext`.
 * See [Gtk.StyleContext.addProvider] and
 * [Gtk.StyleContext.addProviderForDisplay] for
 * adding `GtkStyleProviders`.
 * GTK uses the `GtkStyleProvider` implementation for CSS in
 * [Gtk.CssProvider].
 */
interface StyleProvider
{

  static GType getType()
  {
    return gtk_style_provider_get_type();
  }

  alias GtkPrivateChangedCallback = void delegate(StyleProvider styleProvider);

  /**
   * Connect to GtkPrivateChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectGtkPrivateChanged(GtkPrivateChangedCallback dlg, Flag!"After" after = No.After);
}
