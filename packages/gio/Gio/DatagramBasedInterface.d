module Gio.DatagramBasedInterface;

import GLib.Source;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.DatagramBased;
import Gio.InputMessage;
import Gio.OutputMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for socket-like objects which have datagram semantics,
 * following the Berkeley sockets API. The interface methods are thin wrappers
 * around the corresponding virtual methods, and no pre-processing of inputs is
 * implemented — so implementations of this API must handle all functionality
 * documented in the interface methods.
 */
class DatagramBasedInterface
{
  GDatagramBasedInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DatagramBasedInterface");

    cInstance = *cast(GDatagramBasedInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDatagramBasedInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDatagramBasedInterface.gIface);
  }

  alias ReceiveMessagesFuncType = extern(C) int function(GDatagramBased* datagramBased, GInputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err);

  @property ReceiveMessagesFuncType receiveMessages()
  {
    return cPtr!GDatagramBasedInterface.receiveMessages;
  }

  alias SendMessagesFuncType = extern(C) int function(GDatagramBased* datagramBased, GOutputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err);

  @property SendMessagesFuncType sendMessages()
  {
    return cPtr!GDatagramBasedInterface.sendMessages;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GDatagramBased* datagramBased, GIOCondition condition, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return cPtr!GDatagramBasedInterface.createSource;
  }

  alias ConditionCheckFuncType = extern(C) GIOCondition function(GDatagramBased* datagramBased, GIOCondition condition);

  @property ConditionCheckFuncType conditionCheck()
  {
    return cPtr!GDatagramBasedInterface.conditionCheck;
  }

  alias ConditionWaitFuncType = extern(C) bool function(GDatagramBased* datagramBased, GIOCondition condition, long timeout, GCancellable* cancellable, GError** _err);

  @property ConditionWaitFuncType conditionWait()
  {
    return cPtr!GDatagramBasedInterface.conditionWait;
  }
}
