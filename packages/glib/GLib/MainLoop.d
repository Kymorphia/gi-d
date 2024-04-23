module GLib.MainLoop;

import GLib.Boxed;
import GLib.MainContext;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GMainLoop))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_main_loop_get_type();
  }

  /**
   * a new #GMainLoop.
   */
  this(MainContext context, bool isRunning)
  {
    GMainLoop* _cretval;
    _cretval = g_main_loop_new(context ? context.cPtr!GMainContext : null, isRunning);
    this(_cretval, true);
  }

  /**
   * the #GMainContext of @loop
   */
  MainContext getContext()
  {
    GMainContext* _cretval;
    _cretval = g_main_loop_get_context(cPtr!GMainLoop);
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the mainloop is currently being run.
   */
  bool isRunning()
  {
    bool _retval;
    _retval = g_main_loop_is_running(cPtr!GMainLoop);
    return _retval;
  }

  /**
   * Stops a #GMainLoop from running. Any calls to g_main_loop_run()
   * for the loop will return.
   *
   * Note that sources that have already been dispatched when
   * g_main_loop_quit() is called will still be executed.
   */
  void quit()
  {
    g_main_loop_quit(cPtr!GMainLoop);
  }

  /**
   * Runs a main loop until g_main_loop_quit() is called on the loop.
   * If this is called for the thread of the loop's #GMainContext,
   * it will process events from the loop, otherwise it will
   * simply wait.
   */
  void run()
  {
    g_main_loop_run(cPtr!GMainLoop);
  }
}
