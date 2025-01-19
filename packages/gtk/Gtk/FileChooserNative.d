module Gtk.FileChooserNative;

import Gid.gid;
import Gtk.FileChooser;
import Gtk.FileChooserT;
import Gtk.NativeDialog;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFileChooserNative` is an abstraction of a dialog suitable
 * for use with “File Open” or “File Save as” commands.
 * By default, this just uses a `GtkFileChooserDialog` to implement
 * the actual dialog. However, on some platforms, such as Windows and
 * macOS, the native platform file chooser is used instead. When the
 * application is running in a sandboxed environment without direct
 * filesystem access $(LPAREN)such as Flatpak$(RPAREN), `GtkFileChooserNative` may call
 * the proper APIs $(LPAREN)portals$(RPAREN) to let the user choose a file and make it
 * available to the application.
 * While the API of `GtkFileChooserNative` closely mirrors `GtkFileChooserDialog`,
 * the main difference is that there is no access to any `GtkWindow` or `GtkWidget`
 * for the dialog. This is required, as there may not be one in the case of a
 * platform native dialog.
 * Showing, hiding and running the dialog is handled by the
 * [Gtk.NativeDialog] functions.
 * Note that unlike `GtkFileChooserDialog`, `GtkFileChooserNative` objects
 * are not toplevel widgets, and GTK does not keep them alive. It is your
 * responsibility to keep a reference until you are done with the
 * object.
 * ## Typical usage
 * In the simplest of cases, you can the following code to use
 * `GtkFileChooserNative` to select a file for opening:
 * ```c
 * static void
 * on_response $(LPAREN)GtkNativeDialog *native,
 * int              response$(RPAREN)
 * {
 * if $(LPAREN)response \=\= GTK_RESPONSE_ACCEPT$(RPAREN)
 * {
 * GtkFileChooser *chooser \= GTK_FILE_CHOOSER $(LPAREN)native$(RPAREN);
 * GFile *file \= gtk_file_chooser_get_file $(LPAREN)chooser$(RPAREN);
 * open_file $(LPAREN)file$(RPAREN);
 * g_object_unref $(LPAREN)file$(RPAREN);
 * }
 * g_object_unref $(LPAREN)native$(RPAREN);
 * }
 * // ...
 * GtkFileChooserNative *native;
 * GtkFileChooserAction action \= GTK_FILE_CHOOSER_ACTION_OPEN;
 * native \= gtk_file_chooser_native_new $(LPAREN)"Open File",
 * parent_window,
 * action,
 * "_Open",
 * "_Cancel"$(RPAREN);
 * g_signal_connect $(LPAREN)native, "response", G_CALLBACK $(LPAREN)on_response$(RPAREN), NULL$(RPAREN);
 * gtk_native_dialog_show $(LPAREN)GTK_NATIVE_DIALOG $(LPAREN)native$(RPAREN)$(RPAREN);
 * ```
 * To use a `GtkFileChooserNative` for saving, you can use this:
 * ```c
 * static void
 * on_response $(LPAREN)GtkNativeDialog *native,
 * int              response$(RPAREN)
 * {
 * if $(LPAREN)response \=\= GTK_RESPONSE_ACCEPT$(RPAREN)
 * {
 * GtkFileChooser *chooser \= GTK_FILE_CHOOSER $(LPAREN)native$(RPAREN);
 * GFile *file \= gtk_file_chooser_get_file $(LPAREN)chooser$(RPAREN);
 * save_to_file $(LPAREN)file$(RPAREN);
 * g_object_unref $(LPAREN)file$(RPAREN);
 * }
 * g_object_unref $(LPAREN)native$(RPAREN);
 * }
 * // ...
 * GtkFileChooserNative *native;
 * GtkFileChooser *chooser;
 * GtkFileChooserAction action \= GTK_FILE_CHOOSER_ACTION_SAVE;
 * native \= gtk_file_chooser_native_new $(LPAREN)"Save File",
 * parent_window,
 * action,
 * "_Save",
 * "_Cancel"$(RPAREN);
 * chooser \= GTK_FILE_CHOOSER $(LPAREN)native$(RPAREN);
 * if $(LPAREN)user_edited_a_new_document$(RPAREN)
 * gtk_file_chooser_set_current_name $(LPAREN)chooser, _$(LPAREN)"Untitled document"$(RPAREN)$(RPAREN);
 * else
 * gtk_file_chooser_set_file $(LPAREN)chooser, existing_file, NULL$(RPAREN);
 * g_signal_connect $(LPAREN)native, "response", G_CALLBACK $(LPAREN)on_response$(RPAREN), NULL$(RPAREN);
 * gtk_native_dialog_show $(LPAREN)GTK_NATIVE_DIALOG $(LPAREN)native$(RPAREN)$(RPAREN);
 * ```
 * For more information on how to best set up a file dialog,
 * see the [Gtk.FileChooserDialog] documentation.
 * ## Response Codes
 * `GtkFileChooserNative` inherits from [Gtk.NativeDialog],
 * which means it will return %GTK_RESPONSE_ACCEPT if the user accepted,
 * and %GTK_RESPONSE_CANCEL if he pressed cancel. It can also return
 * %GTK_RESPONSE_DELETE_EVENT if the window was unexpectedly closed.
 * ## Differences from `GtkFileChooserDialog`
 * There are a few things in the [Gtk.FileChooser] interface that
 * are not possible to use with `GtkFileChooserNative`, as such use would
 * prohibit the use of a native dialog.
 * No operations that change the dialog work while the dialog is visible.
 * Set all the properties that are required before showing the dialog.
 * ## Win32 details
 * On windows the `IFileDialog` implementation $(LPAREN)added in Windows Vista$(RPAREN) is
 * used. It supports many of the features that `GtkFileChooser` has, but
 * there are some things it does not handle:
 * * Any [Gtk.FileFilter] added using a mimetype
 * If any of these features are used the regular `GtkFileChooserDialog`
 * will be used in place of the native one.
 * ## Portal details
 * When the `org.freedesktop.portal.FileChooser` portal is available on
 * the session bus, it is used to bring up an out-of-process file chooser.
 * Depending on the kind of session the application is running in, this may
 * or may not be a GTK file chooser.
 * ## macOS details
 * On macOS the `NSSavePanel` and `NSOpenPanel` classes are used to provide
 * native file chooser dialogs. Some features provided by `GtkFileChooser`
 * are not supported:
 * * Shortcut folders.

 * Deprecated: Use [Gtk.FileDialog] instead
 */
class FileChooserNative : NativeDialog, FileChooser
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
    return gtk_file_chooser_native_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin FileChooserT!();

  /**
   * Creates a new `GtkFileChooserNative`.
   * Params:
   *   title = Title of the native
   *   parent = Transient parent of the native
   *   action = Open or save mode for the dialog
   *   acceptLabel = text to go in the accept button, or %NULL for the default
   *   cancelLabel = text to go in the cancel button, or %NULL for the default
   * Returns: a new `GtkFileChooserNative`

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  this(string title, Window parent, FileChooserAction action, string acceptLabel, string cancelLabel)
  {
    GtkFileChooserNative* _cretval;
    const(char)* _title = title.toCString(false);
    const(char)* _acceptLabel = acceptLabel.toCString(false);
    const(char)* _cancelLabel = cancelLabel.toCString(false);
    _cretval = gtk_file_chooser_native_new(_title, parent ? cast(GtkWindow*)parent.cPtr(false) : null, action, _acceptLabel, _cancelLabel);
    this(_cretval, true);
  }

  /**
   * Retrieves the custom label text for the accept button.
   * Returns: The custom label

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  string getAcceptLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_file_chooser_native_get_accept_label(cast(GtkFileChooserNative*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the custom label text for the cancel button.
   * Returns: The custom label

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  string getCancelLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_file_chooser_native_get_cancel_label(cast(GtkFileChooserNative*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets the custom label text for the accept button.
   * If characters in label are preceded by an underscore, they are
   * underlined. If you need a literal underscore character in a label,
   * use “__” $(LPAREN)two underscores$(RPAREN). The first underlined character represents
   * a keyboard accelerator called a mnemonic.
   * Pressing Alt and that key should activate the button.
   * Params:
   *   acceptLabel = custom label

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  void setAcceptLabel(string acceptLabel)
  {
    const(char)* _acceptLabel = acceptLabel.toCString(false);
    gtk_file_chooser_native_set_accept_label(cast(GtkFileChooserNative*)cPtr, _acceptLabel);
  }

  /**
   * Sets the custom label text for the cancel button.
   * If characters in label are preceded by an underscore, they are
   * underlined. If you need a literal underscore character in a label,
   * use “__” $(LPAREN)two underscores$(RPAREN). The first underlined character represents
   * a keyboard accelerator called a mnemonic.
   * Pressing Alt and that key should activate the button.
   * Params:
   *   cancelLabel = custom label

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  void setCancelLabel(string cancelLabel)
  {
    const(char)* _cancelLabel = cancelLabel.toCString(false);
    gtk_file_chooser_native_set_cancel_label(cast(GtkFileChooserNative*)cPtr, _cancelLabel);
  }
}
