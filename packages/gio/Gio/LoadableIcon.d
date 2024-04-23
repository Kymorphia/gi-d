module Gio.LoadableIcon;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Extends the #GIcon interface and adds the ability to
 * load icons from streams.
 */
interface LoadableIcon
{

  static GType getType()
  {
    return g_loadable_icon_get_type();
  }

  /**
   * a #GInputStream to read the icon from.
   */
  InputStream load(int size, out string type, Cancellable cancellable);

  /**
   * Loads an icon asynchronously. To finish this function, see
   * g_loadable_icon_load_finish(). For the synchronous, blocking
   * version of this function, see g_loadable_icon_load().
   */
  void loadAsync(int size, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GInputStream to read the icon from.
   */
  InputStream loadFinish(AsyncResult res, out string type);
}
