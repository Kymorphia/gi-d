module GObject.SignalQuery;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A structure holding in-depth information for a specific signal.
 *
 * See also: g_signal_query()
 */
class SignalQuery
{
  GSignalQuery cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.SignalQuery");

    cInstance = *cast(GSignalQuery*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSignalQuery))
  {
    return cast(T*)&cInstance;
  }

  @property uint signalId()
  {
    return cPtr!GSignalQuery.signalId;
  }

  @property void signalId(uint propval)
  {
    cPtr!GSignalQuery.signalId = propval;
  }

  @property string signalName()
  {
    return cPtr!GSignalQuery.signalName.fromCString(false);
  }

  @property void signalName(string propval)
  {
    g_free(cast(void*)cPtr!GSignalQuery.signalName);
    cPtr!GSignalQuery.signalName = propval.toCString(true);
  }

  @property GType itype()
  {
    return cPtr!GSignalQuery.itype;
  }

  @property void itype(GType propval)
  {
    cPtr!GSignalQuery.itype = propval;
  }

  @property SignalFlags signalFlags()
  {
    return cast(SignalFlags)cPtr!GSignalQuery.signalFlags;
  }

  @property void signalFlags(SignalFlags propval)
  {
    cPtr!GSignalQuery.signalFlags = cast(GSignalFlags)propval;
  }

  @property GType returnType()
  {
    return cPtr!GSignalQuery.returnType;
  }

  @property void returnType(GType propval)
  {
    cPtr!GSignalQuery.returnType = propval;
  }

  @property uint nParams()
  {
    return cPtr!GSignalQuery.nParams;
  }

  @property void nParams(uint propval)
  {
    cPtr!GSignalQuery.nParams = propval;
  }
}
