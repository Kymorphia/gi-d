module Gio.DebugControllerDBus;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.DBusMethodInvocation;
import Gio.DebugController;
import Gio.DebugControllerT;
import Gio.Initable;
import Gio.InitableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDebugControllerDBus` is an implementation of [Gio.DebugController]
 * which exposes debug settings as a D-Bus object.
 * It is a [Gio.Initable] object, and will register an object at
 * `/org/gtk/Debugging` on the bus given as
 * [Gio.DebugControllerDBus.connection] once it’s initialized. The
 * object will be unregistered when the last reference to the
 * `GDebugControllerDBus` is dropped.
 * This D-Bus object can be used by remote processes to enable or disable debug
 * output in this process. Remote processes calling
 * `org.gtk.Debugging.SetDebugEnabled$(LPAREN)$(RPAREN)` will affect the value of
 * property@Gio.DebugController:debug-enabled and, by default,
 * func@GLib.log_get_debug_enabled.
 * By default, no processes are allowed to call `SetDebugEnabled$(LPAREN)$(RPAREN)` unless a
 * [Gio.DebugControllerDBus.authorize] signal handler is installed. This
 * is because the process may be privileged, or might expose sensitive
 * information in its debug output. You may want to restrict the ability to
 * enable debug output to privileged users or processes.
 * One option is to install a D-Bus security policy which restricts access to
 * `SetDebugEnabled$(LPAREN)$(RPAREN)`, installing something like the following in
 * `\$datadir/dbus-1/system.d/`:
 * ```xml
 * <?xml version\="1.0"?> <!--*-nxml-*-->
 * <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 * "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
 * <busconfig>
 * <policy user\="root">
 * <allow send_destination\="com.example.MyService" send_interface\="org.gtk.Debugging"/>
 * </policy>
 * <policy context\="default">
 * <deny send_destination\="com.example.MyService" send_interface\="org.gtk.Debugging"/>
 * </policy>
 * </busconfig>
 * ```
 * This will prevent the `SetDebugEnabled$(LPAREN)$(RPAREN)` method from being called by all
 * except root. It will not prevent the `DebugEnabled` property from being read,
 * as it’s accessed through the `org.freedesktop.DBus.Properties` interface.
 * Another option is to use polkit to allow or deny requests on a case-by-case
 * basis, allowing for the possibility of dynamic authorisation. To do this,
 * connect to the [Gio.DebugControllerDBus.authorize] signal and query
 * polkit in it:
 * ```c
 * g_autoptr$(LPAREN)GError$(RPAREN) child_error \= NULL;
 * g_autoptr$(LPAREN)GDBusConnection$(RPAREN) connection \= g_bus_get_sync $(LPAREN)G_BUS_TYPE_SYSTEM, NULL, NULL$(RPAREN);
 * gulong debug_controller_authorize_id \= 0;
 * // Set up the debug controller.
 * debug_controller \= G_DEBUG_CONTROLLER $(LPAREN)g_debug_controller_dbus_new $(LPAREN)priv->connection, NULL, &child_error$(RPAREN)$(RPAREN);
 * if $(LPAREN)debug_controller \=\= NULL$(RPAREN)
 * {
 * g_error $(LPAREN)"Could not register debug controller on bus: %s"$(RPAREN),
 * child_error->message$(RPAREN);
 * }
 * debug_controller_authorize_id \= g_signal_connect $(LPAREN)debug_controller,
 * "authorize",
 * G_CALLBACK $(LPAREN)debug_controller_authorize_cb$(RPAREN),
 * self$(RPAREN);
 * static gboolean
 * debug_controller_authorize_cb $(LPAREN)GDebugControllerDBus  *debug_controller,
 * GDBusMethodInvocation *invocation,
 * gpointer               user_data$(RPAREN)
 * {
 * g_autoptr$(LPAREN)PolkitAuthority$(RPAREN) authority \= NULL;
 * g_autoptr$(LPAREN)PolkitSubject$(RPAREN) subject \= NULL;
 * g_autoptr$(LPAREN)PolkitAuthorizationResult$(RPAREN) auth_result \= NULL;
 * g_autoptr$(LPAREN)GError$(RPAREN) local_error \= NULL;
 * GDBusMessage *message;
 * GDBusMessageFlags message_flags;
 * PolkitCheckAuthorizationFlags flags \= POLKIT_CHECK_AUTHORIZATION_FLAGS_NONE;
 * message \= g_dbus_method_invocation_get_message $(LPAREN)invocation$(RPAREN);
 * message_flags \= g_dbus_message_get_flags $(LPAREN)message$(RPAREN);
 * authority \= polkit_authority_get_sync $(LPAREN)NULL, &local_error$(RPAREN);
 * if $(LPAREN)authority \=\= NULL$(RPAREN)
 * {
 * g_warning $(LPAREN)"Failed to get polkit authority: %s", local_error->message$(RPAREN);
 * return FALSE;
 * }
 * if $(LPAREN)message_flags & G_DBUS_MESSAGE_FLAGS_ALLOW_INTERACTIVE_AUTHORIZATION$(RPAREN)
 * flags |\= POLKIT_CHECK_AUTHORIZATION_FLAGS_ALLOW_USER_INTERACTION;
 * subject \= polkit_system_bus_name_new $(LPAREN)g_dbus_method_invocation_get_sender $(LPAREN)invocation$(RPAREN)$(RPAREN);
 * auth_result \= polkit_authority_check_authorization_sync $(LPAREN)authority,
 * subject,
 * "com.example.MyService.set-debug-enabled",
 * NULL,
 * flags,
 * NULL,
 * &local_error$(RPAREN);
 * if $(LPAREN)auth_result \=\= NULL$(RPAREN)
 * {
 * g_warning $(LPAREN)"Failed to get check polkit authorization: %s", local_error->message$(RPAREN);
 * return FALSE;
 * }
 * return polkit_authorization_result_get_is_authorized $(LPAREN)auth_result$(RPAREN);
 * }
 * ```
 */
class DebugControllerDBus : ObjectG, DebugController, Initable
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
    return g_debug_controller_dbus_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin DebugControllerT!();
  mixin InitableT!();

  /**
   * Create a new #GDebugControllerDBus and synchronously initialize it.
   * Initializing the object will export the debug object on connection. The
   * object will remain registered until the last reference to the
   * #GDebugControllerDBus is dropped.
   * Initialization may fail if registering the object on connection fails.
   * Params:
   *   connection = a #GDBusConnection to register the debug object on
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a new #GDebugControllerDBus, or %NULL
   *   on failure
   */
  this(DBusConnection connection, Cancellable cancellable)
  {
    GDebugControllerDBus* _cretval;
    GError *_err;
    _cretval = g_debug_controller_dbus_new(connection ? cast(GDBusConnection*)connection.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * Stop the debug controller, unregistering its object from the bus.
   * Any pending method calls to the object will complete successfully, but new
   * ones will return an error. This method will block until all pending
   * #GDebugControllerDBus::authorize signals have been handled. This is expected
   * to not take long, as it will just be waiting for threads to join. If any
   * #GDebugControllerDBus::authorize signal handlers are still executing in other
   * threads, this will block until after they have returned.
   * This method will be called automatically when the final reference to the
   * #GDebugControllerDBus is dropped. You may want to call it explicitly to know
   * when the controller has been fully removed from the bus, or to break
   * reference count cycles.
   * Calling this method from within a #GDebugControllerDBus::authorize signal
   * handler will cause a deadlock and must not be done.
   */
  void stop()
  {
    g_debug_controller_dbus_stop(cast(GDebugControllerDBus*)cPtr);
  }

  /**
   * Emitted when a D-Bus peer is trying to change the debug settings and used
   * to determine if that is authorized.
   * This signal is emitted in a dedicated worker thread, so handlers are
   * allowed to perform blocking I/O. This means that, for example, it is
   * appropriate to call `polkit_authority_check_authorization_sync$(LPAREN)$(RPAREN)` to check
   * authorization using polkit.
   * If %FALSE is returned then no further handlers are run and the request to
   * change the debug settings is rejected.
   * Otherwise, if %TRUE is returned, signal emission continues. If no handlers
   * return %FALSE, then the debug settings are allowed to be changed.
   * Signal handlers must not modify invocation, or cause it to return a value.
   * The default class handler just returns %TRUE.
   * Params
   *   invocation = A #GDBusMethodInvocation.
   *   debugControllerDBus = the instance the signal is connected to
   * Returns: %TRUE if the call is authorized, %FALSE otherwise.
   */
  alias AuthorizeCallback = bool delegate(DBusMethodInvocation invocation, DebugControllerDBus debugControllerDBus);

  /**
   * Connect to Authorize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAuthorize(AuthorizeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto debugControllerDBus = getVal!DebugControllerDBus(_paramVals);
      auto invocation = getVal!DBusMethodInvocation(&_paramVals[1]);
      _retval = _dgClosure.dlg(invocation, debugControllerDBus);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("authorize", closure, after);
  }
}
