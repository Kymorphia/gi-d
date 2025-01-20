module Gtk.NativeDialog;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Native dialogs are platform dialogs that don't use `GtkDialog`.
 * They are used in order to integrate better with a platform, by
 * looking the same as other native applications and supporting
 * platform specific features.
 * The [Gtk.Dialog] functions cannot be used on such objects,
 * but we need a similar API in order to drive them. The `GtkNativeDialog`
 * object is an API that allows you to do this. It allows you to set
 * various common properties on the dialog, as well as show and hide
 * it and get a [Gtk.NativeDialog.response] signal when the user
 * finished with the dialog.
 * Note that unlike `GtkDialog`, `GtkNativeDialog` objects are not
 * toplevel widgets, and GTK does not keep them alive. It is your
 * responsibility to keep a reference until you are done with the
 * object.
 */
class NativeDialog : ObjectG
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
    return gtk_native_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Destroys a dialog.
   * When a dialog is destroyed, it will break any references it holds
   * to other objects.
   * If it is visible it will be hidden and any underlying window system
   * resources will be destroyed.
   * Note that this does not release any reference to the object $(LPAREN)as opposed
   * to destroying a `GtkWindow`$(RPAREN) because there is no reference from the
   * windowing system to the `GtkNativeDialog`.
   */
  void destroy()
  {
    gtk_native_dialog_destroy(cast(GtkNativeDialog*)cPtr);
  }

  /**
   * Returns whether the dialog is modal.
   * Returns: %TRUE if the dialog is set to be modal
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_native_dialog_get_modal(cast(GtkNativeDialog*)cPtr);
    return _retval;
  }

  /**
   * Gets the title of the `GtkNativeDialog`.
   * Returns: the title of the dialog, or %NULL if none has
   *   been set explicitly. The returned string is owned by the widget
   *   and must not be modified or freed.
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_native_dialog_get_title(cast(GtkNativeDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Fetches the transient parent for this window.
   * Returns: the transient parent for this window,
   *   or %NULL if no transient parent has been set.
   */
  Window getTransientFor()
  {
    GtkWindow* _cretval;
    _cretval = gtk_native_dialog_get_transient_for(cast(GtkNativeDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Window(cast(GtkWindow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determines whether the dialog is visible.
   * Returns: %TRUE if the dialog is visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_native_dialog_get_visible(cast(GtkNativeDialog*)cPtr);
    return _retval;
  }

  /**
   * Hides the dialog if it is visible, aborting any interaction.
   * Once this is called the [Gtk.NativeDialog.response] signal
   * will *not* be emitted until after the next call to
   * [Gtk.NativeDialog.show].
   * If the dialog is not visible this does nothing.
   */
  void hide()
  {
    gtk_native_dialog_hide(cast(GtkNativeDialog*)cPtr);
  }

  /**
   * Sets a dialog modal or non-modal.
   * Modal dialogs prevent interaction with other windows in the same
   * application. To keep modal dialogs on top of main application
   * windows, use [Gtk.NativeDialog.setTransientFor] to make
   * the dialog transient for the parent; most window managers will
   * then disallow lowering the dialog below the parent.
   * Params:
   *   modal = whether the window is modal
   */
  void setModal(bool modal)
  {
    gtk_native_dialog_set_modal(cast(GtkNativeDialog*)cPtr, modal);
  }

  /**
   * Sets the title of the `GtkNativeDialog.`
   * Params:
   *   title = title of the dialog
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_native_dialog_set_title(cast(GtkNativeDialog*)cPtr, _title);
  }

  /**
   * Dialog windows should be set transient for the main application
   * window they were spawned from.
   * This allows window managers to e.g. keep the dialog on top of the
   * main window, or center the dialog over the main window.
   * Passing %NULL for parent unsets the current transient window.
   * Params:
   *   parent = parent window
   */
  void setTransientFor(Window parent)
  {
    gtk_native_dialog_set_transient_for(cast(GtkNativeDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null);
  }

  /**
   * Shows the dialog on the display.
   * When the user accepts the state of the dialog the dialog will
   * be automatically hidden and the [Gtk.NativeDialog.response]
   * signal will be emitted.
   * Multiple calls while the dialog is visible will be ignored.
   */
  void show()
  {
    gtk_native_dialog_show(cast(GtkNativeDialog*)cPtr);
  }

  /**
   * Emitted when the user responds to the dialog.
   * When this is called the dialog has been hidden.
   * If you call [Gtk.NativeDialog.hide] before the user
   * responds to the dialog this signal will not be emitted.
   * Params
   *   responseId = the response ID
   *   nativeDialog = the instance the signal is connected to
   */
  alias ResponseCallback = void delegate(int responseId, NativeDialog nativeDialog);

  /**
   * Connect to Response signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectResponse(ResponseCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto nativeDialog = getVal!NativeDialog(_paramVals);
      auto responseId = getVal!int(&_paramVals[1]);
      _dgClosure.dlg(responseId, nativeDialog);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("response", closure, after);
  }
}
