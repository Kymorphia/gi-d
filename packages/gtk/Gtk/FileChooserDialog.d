module Gtk.FileChooserDialog;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Dialog;
import Gtk.FileChooser;
import Gtk.FileChooserT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFileChooserDialog` is a dialog suitable for use with
 * “File Open” or “File Save” commands.
 * ![An example GtkFileChooserDialog](filechooser.png)
 * This widget works by putting a [Gtk.FileChooserWidget]
 * inside a [Gtk.Dialog]. It exposes the [Gtk.FileChooser]
 * interface, so you can use all of the [Gtk.FileChooser] functions
 * on the file chooser dialog as well as those for [Gtk.Dialog].
 * Note that `GtkFileChooserDialog` does not have any methods of its
 * own. Instead, you should use the functions that work on a
 * [Gtk.FileChooser].
 * If you want to integrate well with the platform you should use the
 * [Gtk.FileChooserNative] API, which will use a platform-specific
 * dialog if available and fall back to `GtkFileChooserDialog`
 * otherwise.
 * ## Typical usage
 * In the simplest of cases, you can the following code to use
 * `GtkFileChooserDialog` to select a file for opening:
 * ```c
 * static void
 * on_open_response $(LPAREN)GtkDialog *dialog,
 * int        response$(RPAREN)
 * {
 * if $(LPAREN)response \=\= GTK_RESPONSE_ACCEPT$(RPAREN)
 * {
 * GtkFileChooser *chooser \= GTK_FILE_CHOOSER $(LPAREN)dialog$(RPAREN);
 * g_autoptr$(LPAREN)GFile$(RPAREN) file \= gtk_file_chooser_get_file $(LPAREN)chooser$(RPAREN);
 * open_file $(LPAREN)file$(RPAREN);
 * }
 * gtk_window_destroy $(LPAREN)GTK_WINDOW $(LPAREN)dialog$(RPAREN)$(RPAREN);
 * }
 * // ...
 * GtkWidget *dialog;
 * GtkFileChooserAction action \= GTK_FILE_CHOOSER_ACTION_OPEN;
 * dialog \= gtk_file_chooser_dialog_new $(LPAREN)"Open File",
 * parent_window,
 * action,
 * _$(LPAREN)"_Cancel"$(RPAREN),
 * GTK_RESPONSE_CANCEL,
 * _$(LPAREN)"_Open"$(RPAREN),
 * GTK_RESPONSE_ACCEPT,
 * NULL$(RPAREN);
 * gtk_window_present $(LPAREN)GTK_WINDOW $(LPAREN)dialog$(RPAREN)$(RPAREN);
 * g_signal_connect $(LPAREN)dialog, "response",
 * G_CALLBACK $(LPAREN)on_open_response$(RPAREN),
 * NULL$(RPAREN);
 * ```
 * To use a dialog for saving, you can use this:
 * ```c
 * static void
 * on_save_response $(LPAREN)GtkDialog *dialog,
 * int        response$(RPAREN)
 * {
 * if $(LPAREN)response \=\= GTK_RESPONSE_ACCEPT$(RPAREN)
 * {
 * GtkFileChooser *chooser \= GTK_FILE_CHOOSER $(LPAREN)dialog$(RPAREN);
 * g_autoptr$(LPAREN)GFile$(RPAREN) file \= gtk_file_chooser_get_file $(LPAREN)chooser$(RPAREN);
 * save_to_file $(LPAREN)file$(RPAREN);
 * }
 * gtk_window_destroy $(LPAREN)GTK_WINDOW $(LPAREN)dialog$(RPAREN)$(RPAREN);
 * }
 * // ...
 * GtkWidget *dialog;
 * GtkFileChooser *chooser;
 * GtkFileChooserAction action \= GTK_FILE_CHOOSER_ACTION_SAVE;
 * dialog \= gtk_file_chooser_dialog_new $(LPAREN)"Save File",
 * parent_window,
 * action,
 * _$(LPAREN)"_Cancel"$(RPAREN),
 * GTK_RESPONSE_CANCEL,
 * _$(LPAREN)"_Save"$(RPAREN),
 * GTK_RESPONSE_ACCEPT,
 * NULL$(RPAREN);
 * chooser \= GTK_FILE_CHOOSER $(LPAREN)dialog$(RPAREN);
 * if $(LPAREN)user_edited_a_new_document$(RPAREN)
 * gtk_file_chooser_set_current_name $(LPAREN)chooser, _$(LPAREN)"Untitled document"$(RPAREN)$(RPAREN);
 * else
 * gtk_file_chooser_set_file $(LPAREN)chooser, existing_filename$(RPAREN);
 * gtk_window_present $(LPAREN)GTK_WINDOW $(LPAREN)dialog$(RPAREN)$(RPAREN);
 * g_signal_connect $(LPAREN)dialog, "response",
 * G_CALLBACK $(LPAREN)on_save_response$(RPAREN),
 * NULL$(RPAREN);
 * ```
 * ## Setting up a file chooser dialog
 * There are various cases in which you may need to use a `GtkFileChooserDialog`:
 * - To select a file for opening, use %GTK_FILE_CHOOSER_ACTION_OPEN.
 * - To save a file for the first time, use %GTK_FILE_CHOOSER_ACTION_SAVE,
 * and suggest a name such as “Untitled” with
 * [Gtk.FileChooser.setCurrentName].
 * - To save a file under a different name, use %GTK_FILE_CHOOSER_ACTION_SAVE,
 * and set the existing file with [Gtk.FileChooser.setFile].
 * - To choose a folder instead of a filem use %GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER.
 * In general, you should only cause the file chooser to show a specific
 * folder when it is appropriate to use [Gtk.FileChooser.setFile],
 * i.e. when you are doing a “Save As” command and you already have a file
 * saved somewhere.
 * ## Response Codes
 * `GtkFileChooserDialog` inherits from [Gtk.Dialog], so buttons that
 * go in its action area have response codes such as %GTK_RESPONSE_ACCEPT and
 * %GTK_RESPONSE_CANCEL. For example, you could call
 * [Gtk.FileChooserDialog.new_] as follows:
 * ```c
 * GtkWidget *dialog;
 * GtkFileChooserAction action \= GTK_FILE_CHOOSER_ACTION_OPEN;
 * dialog \= gtk_file_chooser_dialog_new $(LPAREN)"Open File",
 * parent_window,
 * action,
 * _$(LPAREN)"_Cancel"$(RPAREN),
 * GTK_RESPONSE_CANCEL,
 * _$(LPAREN)"_Open"$(RPAREN),
 * GTK_RESPONSE_ACCEPT,
 * NULL$(RPAREN);
 * ```
 * This will create buttons for “Cancel” and “Open” that use predefined
 * response identifiers from [Gtk].  For most dialog
 * boxes you can use your own custom response codes rather than the
 * ones in [Gtk], but `GtkFileChooserDialog` assumes that
 * its “accept”-type action, e.g. an “Open” or “Save” button,
 * will have one of the following response codes:
 * - %GTK_RESPONSE_ACCEPT
 * - %GTK_RESPONSE_OK
 * - %GTK_RESPONSE_YES
 * - %GTK_RESPONSE_APPLY
 * This is because `GtkFileChooserDialog` must intercept responses and switch
 * to folders if appropriate, rather than letting the dialog terminate — the
 * implementation uses these known response codes to know which responses can
 * be blocked if appropriate.
 * To summarize, make sure you use a predefined response code
 * when you use `GtkFileChooserDialog` to ensure proper operation.
 * ## CSS nodes
 * `GtkFileChooserDialog` has a single CSS node with the name `window` and style
 * class `.filechooser`.

 * Deprecated: Use [Gtk.FileDialog] instead
 */
class FileChooserDialog : Dialog, FileChooser
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
    return gtk_file_chooser_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin FileChooserT!GtkFileChooserDialog;
}
