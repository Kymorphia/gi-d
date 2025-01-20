module Gio.SocketControlMessage;

import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GSocketControlMessage` is a special-purpose utility message that
 * can be sent to or received from a [Gio.Socket]. These types of
 * messages are often called ‘ancillary data’.
 * The message can represent some sort of special instruction to or
 * information from the socket or can represent a special kind of
 * transfer to the peer $(LPAREN)for example, sending a file descriptor over
 * a UNIX socket$(RPAREN).
 * These messages are sent with [Gio.Socket.sendMessage] and received
 * with [Gio.Socket.receiveMessage].
 * To extend the set of control message that can be sent, subclass this
 * class and override the `get_size`, `get_level`, `get_type` and `serialize`
 * methods.
 * To extend the set of control messages that can be received, subclass
 * this class and implement the `deserialize` method. Also, make sure your
 * class is registered with the [GObject.GType] type system before calling
 * [Gio.Socket.receiveMessage] to read such a message.
 */
class SocketControlMessage : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_control_message_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Tries to deserialize a socket control message of a given
   * level and type. This will ask all known $(LPAREN)to GType$(RPAREN) subclasses
   * of #GSocketControlMessage if they can understand this kind
   * of message and if so deserialize it into a #GSocketControlMessage.
   * If there is no implementation for this kind of control message, %NULL
   * will be returned.
   * Params:
   *   level = a socket level
   *   type = a socket control message type for the given level
   *   data = pointer to the message data
   * Returns: the deserialized message or %NULL
   */
  static SocketControlMessage deserialize(int level, int type, ubyte[] data)
  {
    GSocketControlMessage* _cretval;
    size_t _size;
    if (data)
      _size = cast(size_t)data.length;

    auto _data = cast(void*)data.ptr;
    _cretval = g_socket_control_message_deserialize(level, type, _size, _data);
    auto _retval = _cretval ? ObjectG.getDObject!SocketControlMessage(cast(GSocketControlMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the "level" $(LPAREN)i.e. the originating protocol$(RPAREN) of the control message.
   * This is often SOL_SOCKET.
   * Returns: an integer describing the level
   */
  int getLevel()
  {
    int _retval;
    _retval = g_socket_control_message_get_level(cast(GSocketControlMessage*)cPtr);
    return _retval;
  }

  /**
   * Returns the protocol specific type of the control message.
   * For instance, for UNIX fd passing this would be SCM_RIGHTS.
   * Returns: an integer describing the type of control message
   */
  int getMsgType()
  {
    int _retval;
    _retval = g_socket_control_message_get_msg_type(cast(GSocketControlMessage*)cPtr);
    return _retval;
  }

  /**
   * Returns the space required for the control message, not including
   * headers or alignment.
   * Returns: The number of bytes required.
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_socket_control_message_get_size(cast(GSocketControlMessage*)cPtr);
    return _retval;
  }

  /**
   * Converts the data in the message to bytes placed in the
   * message.
   * data is guaranteed to have enough space to fit the size
   * returned by [Gio.SocketControlMessage.getSize] on this
   * object.
   * Params:
   *   data = A buffer to write data to
   */
  void serialize(void* data)
  {
    g_socket_control_message_serialize(cast(GSocketControlMessage*)cPtr, data);
  }
}
