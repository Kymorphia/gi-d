module Gio.DatagramBased;

import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.InputMessage;
import Gio.OutputMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GDatagramBased is a networking interface for representing datagram-based
 * communications. It is a more or less direct mapping of the core parts of the
 * BSD socket API in a portable GObject interface. It is implemented by
 * #GSocket, which wraps the UNIX socket API on UNIX and winsock2 on Windows.
 *
 * #GDatagramBased is entirely platform independent, and is intended to be used
 * alongside higher-level networking APIs such as #GIOStream.
 *
 * It uses vectored scatter/gather I/O by default, allowing for many messages
 * to be sent or received in a single call. Where possible, implementations of
 * the interface should take advantage of vectored I/O to minimise processing
 * or system calls. For example, #GSocket uses recvmmsg() and sendmmsg() where
 * possible. Callers should take advantage of scatter/gather I/O (the use of
 * multiple buffers per message) to avoid unnecessary copying of data to
 * assemble or disassemble a message.
 *
 * Each #GDatagramBased operation has a timeout parameter which may be negative
 * for blocking behaviour, zero for non-blocking behaviour, or positive for
 * timeout behaviour. A blocking operation blocks until finished or there is an
 * error. A non-blocking operation will return immediately with a
 * %G_IO_ERROR_WOULD_BLOCK error if it cannot make progress. A timeout operation
 * will block until the operation is complete or the timeout expires; if the
 * timeout expires it will return what progress it made, or
 * %G_IO_ERROR_TIMED_OUT if no progress was made. To know when a call would
 * successfully run you can call g_datagram_based_condition_check() or
 * g_datagram_based_condition_wait(). You can also use
 * g_datagram_based_create_source() and attach it to a #GMainContext to get
 * callbacks when I/O is possible.
 *
 * When running a non-blocking operation applications should always be able to
 * handle getting a %G_IO_ERROR_WOULD_BLOCK error even when some other function
 * said that I/O was possible. This can easily happen in case of a race
 * condition in the application, but it can also happen for other reasons. For
 * instance, on Windows a socket is always seen as writable until a write
 * returns %G_IO_ERROR_WOULD_BLOCK.
 *
 * As with #GSocket, #GDatagramBaseds can be either connection oriented (for
 * example, SCTP) or connectionless (for example, UDP). #GDatagramBaseds must be
 * datagram-based, not stream-based. The interface does not cover connection
 * establishment — use methods on the underlying type to establish a connection
 * before sending and receiving data through the #GDatagramBased API. For
 * connectionless socket types the target/source address is specified or
 * received in each I/O operation.
 *
 * Like most other APIs in GLib, #GDatagramBased is not inherently thread safe.
 * To use a #GDatagramBased concurrently from multiple threads, you must
 * implement your own locking.
 */
interface DatagramBased
{

  static GType getType()
  {
    return g_datagram_based_get_type();
  }

  /**
   * the #GIOCondition mask of the current state
   */
  IOCondition conditionCheck(IOCondition condition);

  /**
   * %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionWait(IOCondition condition, long timeout, Cancellable cancellable);

  /**
   * a newly allocated #GSource
   */
  Source createSource(IOCondition condition, Cancellable cancellable);

  /**
   * number of messages received, or -1 on error. Note that the number
   * of messages received may be smaller than @num_messages if @timeout is
   * zero or positive, if the peer closed the connection, or if @num_messages
   * was larger than `UIO_MAXIOV` (1024), in which case the caller may re-try
   * to receive the remaining messages.
   */
  int receiveMessages(InputMessage[] messages, int flags, long timeout, Cancellable cancellable);

  /**
   * number of messages sent, or -1 on error. Note that the number of
   * messages sent may be smaller than @num_messages if @timeout is zero
   * or positive, or if @num_messages was larger than `UIO_MAXIOV` (1024), in
   * which case the caller may re-try to send the remaining messages.
   */
  int sendMessages(OutputMessage[] messages, int flags, long timeout, Cancellable cancellable);
}
