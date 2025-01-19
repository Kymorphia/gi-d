module Gio.DatagramBased;

public import Gio.DatagramBasedIfaceProxy;
import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import Gid.gid;
import Gio.Cancellable;
import Gio.InputMessage;
import Gio.OutputMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface for socket-like objects with datagram semantics.
 * A `GDatagramBased` is a networking interface for representing datagram-based
 * communications. It is a more or less direct mapping of the core parts of the
 * BSD socket API in a portable GObject interface. It is implemented by
 * [Gio.Socket], which wraps the UNIX socket API on UNIX and winsock2 on Windows.
 * `GDatagramBased` is entirely platform independent, and is intended to be used
 * alongside higher-level networking APIs such as [Gio.IOStream].
 * It uses vectored scatter/gather I/O by default, allowing for many messages
 * to be sent or received in a single call. Where possible, implementations of
 * the interface should take advantage of vectored I/O to minimise processing
 * or system calls. For example, `GSocket` uses `recvmmsg$(LPAREN)$(RPAREN)` and `sendmmsg$(LPAREN)$(RPAREN)`
 * where possible. Callers should take advantage of scatter/gather I/O $(LPAREN)the use of
 * multiple buffers per message$(RPAREN) to avoid unnecessary copying of data to
 * assemble or disassemble a message.
 * Each `GDatagramBased` operation has a timeout parameter which may be negative
 * for blocking behaviour, zero for non-blocking behaviour, or positive for
 * timeout behaviour. A blocking operation blocks until finished or there is an
 * error. A non-blocking operation will return immediately with a
 * `G_IO_ERROR_WOULD_BLOCK` error if it cannot make progress. A timeout operation
 * will block until the operation is complete or the timeout expires; if the
 * timeout expires it will return what progress it made, or
 * `G_IO_ERROR_TIMED_OUT` if no progress was made. To know when a call would
 * successfully run you can call [Gio.DatagramBased.conditionCheck] or
 * [Gio.DatagramBased.conditionWait]. You can also use
 * [Gio.DatagramBased.createSource] and attach it to a [GLib.MainContext]
 * to get callbacks when I/O is possible.
 * When running a non-blocking operation applications should always be able to
 * handle getting a `G_IO_ERROR_WOULD_BLOCK` error even when some other function
 * said that I/O was possible. This can easily happen in case of a race
 * condition in the application, but it can also happen for other reasons. For
 * instance, on Windows a socket is always seen as writable until a write
 * returns `G_IO_ERROR_WOULD_BLOCK`.
 * As with `GSocket`, `GDatagramBased`s can be either connection oriented $(LPAREN)for
 * example, SCTP$(RPAREN) or connectionless $(LPAREN)for example, UDP$(RPAREN). `GDatagramBased`s must be
 * datagram-based, not stream-based. The interface does not cover connection
 * establishment — use methods on the underlying type to establish a connection
 * before sending and receiving data through the `GDatagramBased` API. For
 * connectionless socket types the target/source address is specified or
 * received in each I/O operation.
 * Like most other APIs in GLib, `GDatagramBased` is not inherently thread safe.
 * To use a `GDatagramBased` concurrently from multiple threads, you must
 * implement your own locking.
 */
interface DatagramBased
{

  static GType getType()
  {
    return g_datagram_based_get_type();
  }

  /**
   * Checks on the readiness of datagram_based to perform operations. The
   * operations specified in condition are checked for and masked against the
   * currently-satisfied conditions on datagram_based. The result is returned.
   * %G_IO_IN will be set in the return value if data is available to read with
   * [Gio.DatagramBased.receiveMessages], or if the connection is closed remotely
   * $(LPAREN)EOS$(RPAREN); and if the datagram_based has not been closed locally using some
   * implementation-specific method $(LPAREN)such as [Gio.Socket.close] or
   * [Gio.Socket.shutdown] with shutdown_read set, if it’s a #GSocket$(RPAREN).
   * If the connection is shut down or closed $(LPAREN)by calling [Gio.Socket.close] or
   * [Gio.Socket.shutdown] with shutdown_read set, if it’s a #GSocket, for
   * example$(RPAREN), all calls to this function will return %G_IO_ERROR_CLOSED.
   * %G_IO_OUT will be set if it is expected that at least one byte can be sent
   * using [Gio.DatagramBased.sendMessages] without blocking. It will not be set
   * if the datagram_based has been closed locally.
   * %G_IO_HUP will be set if the connection has been closed locally.
   * %G_IO_ERR will be set if there was an asynchronous error in transmitting data
   * previously enqueued using [Gio.DatagramBased.sendMessages].
   * Note that on Windows, it is possible for an operation to return
   * %G_IO_ERROR_WOULD_BLOCK even immediately after
   * [Gio.DatagramBased.conditionCheck] has claimed that the #GDatagramBased is
   * ready for writing. Rather than calling [Gio.DatagramBased.conditionCheck] and
   * then writing to the #GDatagramBased if it succeeds, it is generally better to
   * simply try writing right away, and try again later if the initial attempt
   * returns %G_IO_ERROR_WOULD_BLOCK.
   * It is meaningless to specify %G_IO_ERR or %G_IO_HUP in condition; these
   * conditions will always be set in the output if they are true. Apart from
   * these flags, the output is guaranteed to be masked by condition.
   * This call never blocks.
   * Params:
   *   condition = a #GIOCondition mask to check
   * Returns: the #GIOCondition mask of the current state
   */
  IOCondition conditionCheck(IOCondition condition);

  /**
   * Waits for up to timeout microseconds for condition to become true on
   * datagram_based. If the condition is met, %TRUE is returned.
   * If cancellable is cancelled before the condition is met, or if timeout is
   * reached before the condition is met, then %FALSE is returned and error is
   * set appropriately $(LPAREN)%G_IO_ERROR_CANCELLED or %G_IO_ERROR_TIMED_OUT$(RPAREN).
   * Params:
   *   condition = a #GIOCondition mask to wait for
   *   timeout = the maximum time $(LPAREN)in microseconds$(RPAREN) to wait, 0 to not block, or -1
   *     to block indefinitely
   *   cancellable = a #GCancellable
   * Returns: %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionWait(IOCondition condition, long timeout, Cancellable cancellable);

  /**
   * Creates a #GSource that can be attached to a #GMainContext to monitor for
   * the availability of the specified condition on the #GDatagramBased. The
   * #GSource keeps a reference to the datagram_based.
   * The callback on the source is of the #GDatagramBasedSourceFunc type.
   * It is meaningless to specify %G_IO_ERR or %G_IO_HUP in condition; these
   * conditions will always be reported in the callback if they are true.
   * If non-%NULL, cancellable can be used to cancel the source, which will
   * cause the source to trigger, reporting the current condition $(LPAREN)which is
   * likely 0 unless cancellation happened at the same time as a condition
   * change$(RPAREN). You can check for this in the callback using
   * [Gio.Cancellable.isCancelled].
   * Params:
   *   condition = a #GIOCondition mask to monitor
   *   cancellable = a #GCancellable
   * Returns: a newly allocated #GSource
   */
  Source createSource(IOCondition condition, Cancellable cancellable);

  /**
   * Receive one or more data messages from datagram_based in one go.
   * messages must point to an array of #GInputMessage structs and
   * num_messages must be the length of this array. Each #GInputMessage
   * contains a pointer to an array of #GInputVector structs describing the
   * buffers that the data received in each message will be written to.
   * flags modify how all messages are received. The commonly available
   * arguments for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too. These
   * flags affect the overall receive operation. Flags affecting individual
   * messages are returned in #GInputMessage.flags.
   * The other members of #GInputMessage are treated as described in its
   * documentation.
   * If timeout is negative the call will block until num_messages have been
   * received, the connection is closed remotely $(LPAREN)EOS$(RPAREN), cancellable is cancelled,
   * or an error occurs.
   * If timeout is 0 the call will return up to num_messages without blocking,
   * or %G_IO_ERROR_WOULD_BLOCK if no messages are queued in the operating system
   * to be received.
   * If timeout is positive the call will block on the same conditions as if
   * timeout were negative. If the timeout is reached
   * before any messages are received, %G_IO_ERROR_TIMED_OUT is returned,
   * otherwise it will return the number of messages received before timing out.
   * $(LPAREN)Note: This is effectively the behaviour of `MSG_WAITFORONE` with
   * recvmmsg$(LPAREN)$(RPAREN).$(RPAREN)
   * To be notified when messages are available, wait for the %G_IO_IN condition.
   * Note though that you may still receive %G_IO_ERROR_WOULD_BLOCK from
   * [Gio.DatagramBased.receiveMessages] even if you were previously notified of a
   * %G_IO_IN condition.
   * If the remote peer closes the connection, any messages queued in the
   * underlying receive buffer will be returned, and subsequent calls to
   * [Gio.DatagramBased.receiveMessages] will return 0 (with no error set).
   * If the connection is shut down or closed $(LPAREN)by calling [Gio.Socket.close] or
   * [Gio.Socket.shutdown] with shutdown_read set, if it’s a #GSocket, for
   * example$(RPAREN), all calls to this function will return %G_IO_ERROR_CLOSED.
   * On error -1 is returned and error is set accordingly. An error will only
   * be returned if zero messages could be received; otherwise the number of
   * messages successfully received before the error will be returned. If
   * cancellable is cancelled, %G_IO_ERROR_CANCELLED is returned as with any
   * other error.
   * Params:
   *   messages = an array of #GInputMessage structs
   *   flags = an int containing #GSocketMsgFlags flags for the overall operation
   *   timeout = the maximum time $(LPAREN)in microseconds$(RPAREN) to wait, 0 to not block, or -1
   *     to block indefinitely
   *   cancellable = a %GCancellable
   * Returns: number of messages received, or -1 on error. Note that the number
   *   of messages received may be smaller than num_messages if timeout is
   *   zero or positive, if the peer closed the connection, or if num_messages
   *   was larger than `UIO_MAXIOV` $(LPAREN)1024$(RPAREN), in which case the caller may re-try
   *   to receive the remaining messages.
   */
  int receiveMessages(InputMessage[] messages, int flags, long timeout, Cancellable cancellable);

  /**
   * Send one or more data messages from datagram_based in one go.
   * messages must point to an array of #GOutputMessage structs and
   * num_messages must be the length of this array. Each #GOutputMessage
   * contains an address to send the data to, and a pointer to an array of
   * #GOutputVector structs to describe the buffers that the data to be sent
   * for each message will be gathered from.
   * flags modify how the message is sent. The commonly available arguments
   * for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too.
   * The other members of #GOutputMessage are treated as described in its
   * documentation.
   * If timeout is negative the call will block until num_messages have been
   * sent, cancellable is cancelled, or an error occurs.
   * If timeout is 0 the call will send up to num_messages without blocking,
   * or will return %G_IO_ERROR_WOULD_BLOCK if there is no space to send messages.
   * If timeout is positive the call will block on the same conditions as if
   * timeout were negative. If the timeout is reached before any messages are
   * sent, %G_IO_ERROR_TIMED_OUT is returned, otherwise it will return the number
   * of messages sent before timing out.
   * To be notified when messages can be sent, wait for the %G_IO_OUT condition.
   * Note though that you may still receive %G_IO_ERROR_WOULD_BLOCK from
   * [Gio.DatagramBased.sendMessages] even if you were previously notified of a
   * %G_IO_OUT condition. $(LPAREN)On Windows in particular, this is very common due to
   * the way the underlying APIs work.$(RPAREN)
   * If the connection is shut down or closed $(LPAREN)by calling [Gio.Socket.close] or
   * [Gio.Socket.shutdown] with shutdown_write set, if it’s a #GSocket, for
   * example$(RPAREN), all calls to this function will return %G_IO_ERROR_CLOSED.
   * On error -1 is returned and error is set accordingly. An error will only
   * be returned if zero messages could be sent; otherwise the number of messages
   * successfully sent before the error will be returned. If cancellable is
   * cancelled, %G_IO_ERROR_CANCELLED is returned as with any other error.
   * Params:
   *   messages = an array of #GOutputMessage structs
   *   flags = an int containing #GSocketMsgFlags flags
   *   timeout = the maximum time $(LPAREN)in microseconds$(RPAREN) to wait, 0 to not block, or -1
   *     to block indefinitely
   *   cancellable = a %GCancellable
   * Returns: number of messages sent, or -1 on error. Note that the number of
   *   messages sent may be smaller than num_messages if timeout is zero
   *   or positive, or if num_messages was larger than `UIO_MAXIOV` $(LPAREN)1024$(RPAREN), in
   *   which case the caller may re-try to send the remaining messages.
   */
  int sendMessages(OutputMessage[] messages, int flags, long timeout, Cancellable cancellable);
}
