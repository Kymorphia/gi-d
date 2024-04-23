module Gio.TlsInteraction;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.TlsConnection;
import Gio.TlsPassword;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GTlsInteraction provides a mechanism for the TLS connection and database
 * code to interact with the user. It can be used to ask the user for passwords.
 *
 * To use a #GTlsInteraction with a TLS connection use
 * g_tls_connection_set_interaction().
 *
 * Callers should instantiate a derived class that implements the various
 * interaction methods to show the required dialogs.
 *
 * Callers should use the 'invoke' functions like
 * g_tls_interaction_invoke_ask_password() to run interaction methods. These
 * functions make sure that the interaction is invoked in the main loop
 * and not in the current thread, if the current thread is not running the
 * main loop.
 *
 * Derived classes can choose to implement whichever interactions methods they'd
 * like to support by overriding those virtual methods in their class
 * initialization function. Any interactions not implemented will return
 * %G_TLS_INTERACTION_UNHANDLED. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 */
class TlsInteraction : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_interaction_get_type();
  }

  /**
   * The status of the ask password interaction.
   */
  TlsInteractionResult askPassword(TlsPassword password, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_ask_password(cPtr!GTlsInteraction, password ? password.cPtr!GTlsPassword : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Run asynchronous interaction to ask the user for a password. In general,
   * g_tls_interaction_invoke_ask_password() should be used instead of this
   * function.
   *
   * Derived subclasses usually implement a password prompt, although they may
   * also choose to provide a password from elsewhere. The @password value will
   * be filled in and then @callback will be called. Alternatively the user may
   * abort this password request, which will usually abort the TLS connection.
   *
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   *
   * Certain implementations may not support immediate cancellation.
   */
  void askPasswordAsync(TlsPassword password, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_tls_interaction_ask_password_async(cPtr!GTlsInteraction, password ? password.cPtr!GTlsPassword : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * The status of the ask password interaction.
   */
  TlsInteractionResult askPasswordFinish(AsyncResult result)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_ask_password_finish(cPtr!GTlsInteraction, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * The status of the ask password interaction.
   */
  TlsInteractionResult invokeAskPassword(TlsPassword password, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_invoke_ask_password(cPtr!GTlsInteraction, password ? password.cPtr!GTlsPassword : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * The status of the certificate request interaction.
   */
  TlsInteractionResult invokeRequestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_invoke_request_certificate(cPtr!GTlsInteraction, connection ? connection.cPtr!GTlsConnection : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * The status of the request certificate interaction.
   */
  TlsInteractionResult requestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_request_certificate(cPtr!GTlsInteraction, connection ? connection.cPtr!GTlsConnection : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Run asynchronous interaction to ask the user for a certificate to use with
   * the connection. In general, g_tls_interaction_invoke_request_certificate() should
   * be used instead of this function.
   *
   * Derived subclasses usually implement a certificate selector, although they may
   * also choose to provide a certificate from elsewhere. @callback will be called
   * when the operation completes. Alternatively the user may abort this certificate
   * request, which will usually abort the TLS connection.
   */
  void requestCertificateAsync(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_tls_interaction_request_certificate_async(cPtr!GTlsInteraction, connection ? connection.cPtr!GTlsConnection : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * The status of the request certificate interaction.
   */
  TlsInteractionResult requestCertificateFinish(AsyncResult result)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_request_certificate_finish(cPtr!GTlsInteraction, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }
}
