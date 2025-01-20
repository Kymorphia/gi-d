module Gio.OutputMessage;

import GObject.ObjectG;
import Gid.gid;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Structure used for scatter/gather data output when sending multiple
 * messages or packets in one go. You generally pass in an array of
 * #GOutputVectors and the operation will use all the buffers as if they
 * were one buffer.
 * If @address is %NULL then the message is sent to the default receiver
 * $(LPAREN)as previously set by [Gio.Socket.connect]$(RPAREN).
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SocketAddress address()
  {
    return ObjectG.getDObject!SocketAddress((cast(GOutputMessage*)cPtr).address, false);
  }

  @property OutputVector vectors()
  {
    return *(cast(GOutputMessage*)cPtr).vectors;
  }

  @property void vectors(OutputVector propval)
  {
    (cast(GOutputMessage*)cPtr).vectors = &propval;
  }

  @property uint numVectors()
  {
    return (cast(GOutputMessage*)cPtr).numVectors;
  }

  @property void numVectors(uint propval)
  {
    (cast(GOutputMessage*)cPtr).numVectors = propval;
  }

  @property uint bytesSent()
  {
    return (cast(GOutputMessage*)cPtr).bytesSent;
  }

  @property void bytesSent(uint propval)
  {
    (cast(GOutputMessage*)cPtr).bytesSent = propval;
  }

  @property uint numControlMessages()
  {
    return (cast(GOutputMessage*)cPtr).numControlMessages;
  }

  @property void numControlMessages(uint propval)
  {
    (cast(GOutputMessage*)cPtr).numControlMessages = propval;
  }
}
