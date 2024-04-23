module Gio.OutputMessage;

import GLib.c.functions;
import GObject.ObjectG;
import Gid.Gid;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Structure used for scatter/gather data output when sending multiple
 * messages or packets in one go. You generally pass in an array of
 * #GOutputVectors and the operation will use all the buffers as if they
 * were one buffer.
 *
 * If @address is %NULL then the message is sent to the default receiver
 * (as previously set by g_socket_connect()).
 */
class OutputMessage
{
  GOutputMessage cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.OutputMessage");

    cInstance = *cast(GOutputMessage*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GOutputMessage))
  {
    return cast(T*)&cInstance;
  }

  @property SocketAddress address()
  {
    return ObjectG.getDObject!SocketAddress(cPtr!GOutputMessage.address, false);
  }

  @property OutputVector* vectors()
  {
    return cPtr!GOutputMessage.vectors;
  }

  @property void vectors(OutputVector* propval)
  {
    cPtr!GOutputMessage.vectors = propval;
  }

  @property uint numVectors()
  {
    return cPtr!GOutputMessage.numVectors;
  }

  @property void numVectors(uint propval)
  {
    cPtr!GOutputMessage.numVectors = propval;
  }

  @property uint bytesSent()
  {
    return cPtr!GOutputMessage.bytesSent;
  }

  @property void bytesSent(uint propval)
  {
    cPtr!GOutputMessage.bytesSent = propval;
  }

  @property uint numControlMessages()
  {
    return cPtr!GOutputMessage.numControlMessages;
  }

  @property void numControlMessages(uint propval)
  {
    cPtr!GOutputMessage.numControlMessages = propval;
  }
}
