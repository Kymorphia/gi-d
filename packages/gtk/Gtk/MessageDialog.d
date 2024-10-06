module Gtk.MessageDialog;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Dialog;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkMessageDialog` presents a dialog with some message text.
 * ![An example GtkMessageDialog](messagedialog.png)
 * It’s simply a convenience widget; you could construct the equivalent of
 * `GtkMessageDialog` from `GtkDialog` without too much effort, but
 * `GtkMessageDialog` saves typing.
 * The easiest way to do a modal message dialog is to use the %GTK_DIALOG_MODAL
 * flag, which will call [Gtk.Window.setModal] internally. The dialog will
 * prevent interaction with the parent window until it's hidden or destroyed.
 * You can use the [Gtk.Dialog.response] signal to know when the user
 * dismissed the dialog.
 * An example for using a modal dialog:
 * ```c
 * GtkDialogFlags flags \= GTK_DIALOG_DESTROY_WITH_PARENT | GTK_DIALOG_MODAL;
 * dialog \= gtk_message_dialog_new $(LPAREN)parent_window,
 * flags,
 * GTK_MESSAGE_ERROR,
 * GTK_BUTTONS_CLOSE,
 * "Error reading “%s”: %s",
 * filename,
 * g_strerror $(LPAREN)errno$(RPAREN)$(RPAREN);
 * // Destroy the dialog when the user responds to it
 * // $(LPAREN)e.g. clicks a button$(RPAREN)
 * g_signal_connect $(LPAREN)dialog, "response",
 * G_CALLBACK $(LPAREN)gtk_window_destroy$(RPAREN),
 * NULL$(RPAREN);
 * ```
 * You might do a non-modal `GtkMessageDialog` simply by omitting the
 * %GTK_DIALOG_MODAL flag:
 * ```c
 * GtkDialogFlags flags \= GTK_DIALOG_DESTROY_WITH_PARENT;
 * dialog \= gtk_message_dialog_new $(LPAREN)parent_window,
 * flags,
 * GTK_MESSAGE_ERROR,
 * GTK_BUTTONS_CLOSE,
 * "Error reading “%s”: %s",
 * filename,
 * g_strerror $(LPAREN)errno$(RPAREN)$(RPAREN);
 * // Destroy the dialog when the user responds to it
 * // $(LPAREN)e.g. clicks a button$(RPAREN)
 * g_signal_connect $(LPAREN)dialog, "response",
 * G_CALLBACK $(LPAREN)gtk_window_destroy$(RPAREN),
 * NULL$(RPAREN);
 * ```
 * # GtkMessageDialog as GtkBuildable
 * The `GtkMessageDialog` implementation of the `GtkBuildable` interface exposes
 * the message area as an internal child with the name “message_area”.

 * Deprecated: Use [Gtk.AlertDialog] instead
 */
class MessageDialog : Dialog
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
    return gtk_message_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the message area of the dialog.
   * This is the box where the dialog’s primary and secondary labels
   * are packed. You can add your own extra content to that box and it
   * will appear below those labels. See [Gtk.Dialog.getContentArea]
   * for the corresponding function in the parent [Gtk.Dialog].
   * Returns: A `GtkBox` corresponding to the
   *   “message area” in the message_dialog

   * Deprecated: Use [Gtk.AlertDialog] instead
   */
  Widget getMessageArea()
  {
    GtkWidget* _cretval;
    _cretval = gtk_message_dialog_get_message_area(cast(GtkMessageDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the text of the message dialog.
   * Params:
   *   str = string with Pango markup

   * Deprecated: Use [Gtk.AlertDialog] instead
   */
  void setMarkup(string str)
  {
    const(char)* _str = str.toCString(false);
    gtk_message_dialog_set_markup(cast(GtkMessageDialog*)cPtr, _str);
  }
}
