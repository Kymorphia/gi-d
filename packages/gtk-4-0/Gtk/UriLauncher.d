module Gtk.UriLauncher;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkUriLauncher` object collects the arguments that are needed to open a uri
 * with an application.
 * Depending on system configuration, user preferences and available APIs, this
 * may or may not show an app chooser dialog or launch the default application
 * right away.
 * The operation is started with the [Gtk.UriLauncher.launch] function.
 * This API follows the GIO async pattern, and the result can be obtained by
 * calling [Gtk.UriLauncher.launchFinish].
 * To launch a file, use [Gtk.FileLauncher].
 */
class UriLauncher : ObjectG
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
    return gtk_uri_launcher_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkUriLauncher` object.
   * Params:
   *   uri = the uri to open
   * Returns: the new `GtkUriLauncher`
   */
  this(string uri)
  {
    GtkUriLauncher* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = gtk_uri_launcher_new(_uri);
    this(_cretval, true);
  }

  /**
   * Gets the uri that will be opened.
   * Returns: the uri
   */
  string getUri()
  {
    const(char)* _cretval;
    _cretval = gtk_uri_launcher_get_uri(cast(GtkUriLauncher*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Launch an application to open the uri.
   * This may present an app chooser dialog to the user.
   * The callback will be called when the operation is completed.
   * It should call [Gtk.UriLauncher.launchFinish] to obtain
   * the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void launch(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_uri_launcher_launch(cast(GtkUriLauncher*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.UriLauncher.launch] call and
   * returns the result.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: `TRUE` if an application was launched,
   *   or `FALSE` and error is set
   */
  bool launchFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_uri_launcher_launch_finish(cast(GtkUriLauncher*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the uri that will be opened.
   * Params:
   *   uri = the uri
   */
  void setUri(string uri)
  {
    const(char)* _uri = uri.toCString(false);
    gtk_uri_launcher_set_uri(cast(GtkUriLauncher*)cPtr, _uri);
  }
}
