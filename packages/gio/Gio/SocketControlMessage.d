module Gio.SocketControlMessage;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GSocketControlMessage is a special-purpose utility message that
 * can be sent to or received from a #GSocket. These types of
 * messages are often called "ancillary data".
 *
 * The message can represent some sort of special instruction to or
 * information from the socket or can represent a special kind of
 * transfer to the peer (for example, sending a file descriptor over
 * a UNIX socket).
 *
 * These messages are sent with g_socket_send_message() and received
 * with g_socket_receive_message().
 *
 * To extend the set of control message that can be sent, subclass this
 * class and override the get_size, get_level, get_type and serialize
 * methods.
 *
 * To extend the set of control messages that can be received, subclass
 * this class and implement the deserialize method. Also, make sure your
 * class is registered with the GType typesystem before calling
 * g_socket_receive_message() to read such a message.
 */
class SocketControlMessage : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_control_message_get_type();
  }

  /**
   * the deserialized message or %NULL
   */
  static SocketControlMessage deserialize(int level, int type, ubyte[] data)
  {
    GSocketControlMessage* _cretval;
    auto _data = cast(void*)data.ptr;
    _cretval = g_socket_control_message_deserialize(level, type, data ? cast(size_t)data.length : 0, _data);
    SocketControlMessage _retval = ObjectG.getDObject!SocketControlMessage(cast(GSocketControlMessage*)_cretval, true);
    return _retval;
  }

  /**
   * an integer describing the level
   */
  int getLevel()
  {
    int _retval;
    _retval = g_socket_control_message_get_level(cPtr!GSocketControlMessage);
    return _retval;
  }

  /**
   * an integer describing the type of control message
   */
  int getMsgType()
  {
    int _retval;
    _retval = g_socket_control_message_get_msg_type(cPtr!GSocketControlMessage);
    return _retval;
  }

  /**
   * The number of bytes required.
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_socket_control_message_get_size(cPtr!GSocketControlMessage);
    return _retval;
  }

  /**
   * Converts the data in the message to bytes placed in the
   * message.
   *
   * @data is guaranteed to have enough space to fit the size
   * returned by g_socket_control_message_get_size() on this
   * object.
   */
  void serialize(void* data)
  {
    g_socket_control_message_serialize(cPtr!GSocketControlMessage, data);
  }
}
