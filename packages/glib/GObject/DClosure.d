module GObject.DClosure;

import GObject.Closure;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;


import GObject.Closure;
public import GObject.Value;

/**
 * Closure used for D delegates.
 */
class DClosure : Closure
{
  this(T)(T dlg, GClosureMarshal cMarshal)
  {
    auto closure = g_closure_new_simple(DGClosure!T.sizeof, null);
    g_closure_ref(closure);
    g_closure_sink(closure);

    auto dgClosure = cast(DGClosure!T*)closure;
    dgClosure.dlg = dlg;
    g_closure_set_marshal(closure, cMarshal);
    super(closure, true);
  }

  T* cPtr(T)()
  if (is(T == DGClosure!T))
  {
    return cast(T*)cInstancePtr;
  }

  T getDelegate(T)()
  {
    return cPtr!DGClosure.dlg!T;
  }
}

/// New GClosure type with a delegate pointer
struct DGClosure(T)
{
  GClosure closure;
  T dlg;
}