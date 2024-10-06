module GLib.MainLoop;

import GLib.Boxed;
import GLib.MainContext;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The `GMainLoop` struct is an opaque data type
 * representing the main event loop of a GLib or GTK application.
 */
class MainLoop : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_main_loop_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GMainLoop structure.
   * Params:
   *   context = a #GMainContext  $(LPAREN)if %NULL, the global-default
   *     main context will be used$(RPAREN).
   *   isRunning = set to %TRUE to indicate that the loop is running. This
   *     is not very important since calling [GLib.MainLoop.run] will set this to
   *     %TRUE anyway.
   * Returns: a new #GMainLoop.
   */
  this(MainContext context, bool isRunning)
  {
    GMainLoop* _cretval;
    _cretval = g_main_loop_new(context ? cast(GMainContext*)context.cPtr(false) : null, isRunning);
    this(_cretval, true);
  }

  /**
   * Returns the #GMainContext of loop.
   * Returns: the #GMainContext of loop
   */
  MainContext getContext()
  {
    GMainContext* _cretval;
    _cretval = g_main_loop_get_context(cast(GMainLoop*)cPtr);
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks to see if the main loop is currently being run via [GLib.MainLoop.run].
   * Returns: %TRUE if the mainloop is currently being run.
   */
  bool isRunning()
  {
    bool _retval;
    _retval = g_main_loop_is_running(cast(GMainLoop*)cPtr);
    return _retval;
  }

  /**
   * Stops a #GMainLoop from running. Any calls to [GLib.MainLoop.run]
   * for the loop will return.
   * Note that sources that have already been dispatched when
   * [GLib.MainLoop.quit] is called will still be executed.
   */
  void quit()
  {
    g_main_loop_quit(cast(GMainLoop*)cPtr);
  }

  /**
   * Runs a main loop until [GLib.MainLoop.quit] is called on the loop.
   * If this is called for the thread of the loop's #GMainContext,
   * it will process events from the loop, otherwise it will
   * simply wait.
   */
  void run()
  {
    g_main_loop_run(cast(GMainLoop*)cPtr);
  }
}
