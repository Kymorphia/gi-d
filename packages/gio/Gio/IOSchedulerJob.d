module Gio.IOSchedulerJob;

import GLib.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Opaque class for defining and scheduling IO jobs.
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

  T* cPtr(T)()
  if (is(T == GIOSchedulerJob))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * The return value of @func
   */
  bool sendToMainloop(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      bool _retval = (*(cast(SourceFunc*)userData))();
      return _retval;
    }

    bool _retval;
    ptrFreezeGC(cast(void*)&func);
    _retval = g_io_scheduler_job_send_to_mainloop(cPtr!GIOSchedulerJob, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
    return _retval;
  }

  /**
   * Used from an I/O job to send a callback to be run asynchronously in
   * the thread that the job was started from. The callback will be run
   * when the main loop is available, but at that time the I/O job might
   * have finished. The return value from the callback is ignored.
   *
   * Note that if you are passing the @user_data from g_io_scheduler_push_job()
   * on to this function you have to ensure that it is not freed before
   * @func is called, either by passing %NULL as @notify to
   * g_io_scheduler_push_job() or by using refcounting for @user_data.
   */
  void sendToMainloopAsync(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      bool _retval = (*(cast(SourceFunc*)userData))();
      return _retval;
    }

    ptrFreezeGC(cast(void*)&func);
    g_io_scheduler_job_send_to_mainloop_async(cPtr!GIOSchedulerJob, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
  }
}
