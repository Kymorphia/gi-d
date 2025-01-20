module Gtk.LockButton;

import GObject.ObjectG;
import Gid.gid;
import Gio.Permission;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Actionable;
import Gtk.ActionableT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Button;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLockButton` is a widget to obtain and revoke authorizations
 * needed to operate the controls.
 * ![An example GtkLockButton](lock-button.png)
 * It is typically used in preference dialogs or control panels.
 * The required authorization is represented by a `GPermission` object.
 * Concrete implementations of `GPermission` may use PolicyKit or some
 * other authorization framework. To obtain a PolicyKit-based
 * `GPermission`, use `polkit_permission_new$(LPAREN)$(RPAREN)`.
 * If the user is not currently allowed to perform the action, but can
 * obtain the permission, the widget looks like this:
 * ![](lockbutton-locked.png)
 * and the user can click the button to request the permission. Depending
 * on the platform, this may pop up an authentication dialog or ask the user
 * to authenticate in some other way. Once the user has obtained the permission,
 * the widget changes to this:
 * ![](lockbutton-unlocked.png)
 * and the permission can be dropped again by clicking the button. If the user
 * is not able to obtain the permission at all, the widget looks like this:
 * ![](lockbutton-sorry.png)
 * If the user has the permission and cannot drop it, the button is hidden.
 * The text $(LPAREN)and tooltips$(RPAREN) that are shown in the various cases can be adjusted
 * with the property@Gtk.LockButton:text-lock,
 * property@Gtk.LockButton:text-unlock,
 * property@Gtk.LockButton:tooltip-lock,
 * property@Gtk.LockButton:tooltip-unlock and
 * property@Gtk.LockButton:tooltip-not-authorized properties.

 * Deprecated: This widget will be removed in GTK 5
 */
class LockButton : Button
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
    return gtk_lock_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new lock button which reflects the permission.
   * Params:
   *   permission = a `GPermission`
   * Returns: a new `GtkLockButton`

   * Deprecated: This widget will be removed in GTK 5
   */
  this(Permission permission)
  {
    GtkWidget* _cretval;
    _cretval = gtk_lock_button_new(permission ? cast(GPermission*)permission.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Obtains the `GPermission` object that controls button.
   * Returns: the `GPermission` of button

   * Deprecated: This widget will be removed in GTK 5
   */
  Permission getPermission()
  {
    GPermission* _cretval;
    _cretval = gtk_lock_button_get_permission(cast(GtkLockButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Permission(cast(GPermission*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the `GPermission` object that controls button.
   * Params:
   *   permission = a `GPermission` object

   * Deprecated: This widget will be removed in GTK 5
   */
  void setPermission(Permission permission)
  {
    gtk_lock_button_set_permission(cast(GtkLockButton*)cPtr, permission ? cast(GPermission*)permission.cPtr(false) : null);
  }
}
