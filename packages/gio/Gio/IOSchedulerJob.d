module Gio.IOSchedulerJob;

import GLib.Types;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Opaque class for defining and scheduling IO jobs.

 * Deprecated: Use [GLib.ThreadPool] or
 *   [Gio.Task.runInThread]
 */
class IOSchedulerJob
{
  GIOSchedulerJob* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOSchedulerJob");

    cInstancePtr = cast(GIOSchedulerJob*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Used from an I/O job to send a callback to be run in the thread
   * that the job was started from, waiting for the result $(LPAREN)and thus
   * blocking the I/O job$(RPAREN).
   * Params:
   *   func = a #GSourceFunc callback that will be called in the original thread
   * Returns: The return value of func

   * Deprecated: Use [GLib.MainContext.invoke].
   */
  bool sendToMainloop(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      auto _dlg = cast(SourceFunc*)userData;

      bool _retval = (*_dlg)();
      return _retval;
    }

    bool _retval;
    auto _func = freezeDelegate(cast(void*)&func);
    _retval = g_io_scheduler_job_send_to_mainloop(cast(GIOSchedulerJob*)cPtr, &_funcCallback, _func, &thawDelegate);
    return _retval;
  }

  /**
   * Used from an I/O job to send a callback to be run asynchronously in
   * the thread that the job was started from. The callback will be run
   * when the main loop is available, but at that time the I/O job might
   * have finished. The return value from the callback is ignored.
   * Note that if you are passing the user_data from [Gio.Global.ioSchedulerPushJob]
   * on to this function you have to ensure that it is not freed before
   * func is called, either by passing %NULL as notify to
   * [Gio.Global.ioSchedulerPushJob] or by using refcounting for user_data.
   * Params:
   *   func = a #GSourceFunc callback that will be called in the original thread

   * Deprecated: Use [GLib.MainContext.invoke].
   */
  void sendToMainloopAsync(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      auto _dlg = cast(SourceFunc*)userData;

      bool _retval = (*_dlg)();
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    g_io_scheduler_job_send_to_mainloop_async(cast(GIOSchedulerJob*)cPtr, &_funcCallback, _func, &thawDelegate);
  }
}
