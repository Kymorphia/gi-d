module Gtk.AppChooserT;

public import Gtk.AppChooserIfaceProxy;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AppInfo;
public import Gio.AppInfoT;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkAppChooser` is an interface for widgets which allow the user to
 * choose an application.
 * The main objects that implement this interface are
 * [Gtk.AppChooserWidget],
 * [Gtk.AppChooserDialog] and [Gtk.AppChooserButton].
 * Applications are represented by GIO `GAppInfo` objects here.
 * GIO has a concept of recommended and fallback applications for a
 * given content type. Recommended applications are those that claim
 * to handle the content type itself, while fallback also includes
 * applications that handle a more generic content type. GIO also
 * knows the default and last-used application for a given content
 * type. The `GtkAppChooserWidget` provides detailed control over
 * whether the shown list of applications should include default,
 * recommended or fallback applications.
 * To obtain the application that has been selected in a `GtkAppChooser`,
 * use [Gtk.AppChooser.getAppInfo].

 * Deprecated: The application selection widgets should be
 *   implemented according to the design of each platform and/or
 *   application requiring them.
 */
template AppChooserT()
{

  /**
   * Returns the currently selected application.
   * Returns: a `GAppInfo` for the
   *   currently selected application

   * Deprecated: This widget will be removed in GTK 5
   */
  override AppInfo getAppInfo()
  {
    GAppInfo* _cretval;
    _cretval = gtk_app_chooser_get_app_info(cast(GtkAppChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the content type for which the `GtkAppChooser`
   * shows applications.
   * Returns: the content type of self. Free with [GLib.Global.gfree]

   * Deprecated: This widget will be removed in GTK 5
   */
  override string getContentType()
  {
    char* _cretval;
    _cretval = gtk_app_chooser_get_content_type(cast(GtkAppChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Reloads the list of applications.

   * Deprecated: This widget will be removed in GTK 5
   */
  override void refresh()
  {
    gtk_app_chooser_refresh(cast(GtkAppChooser*)cPtr);
  }
}
