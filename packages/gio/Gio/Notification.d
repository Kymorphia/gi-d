module Gio.Notification;

import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GNotification is a mechanism for creating a notification to be shown
 * to the user -- typically as a pop-up notification presented by the
 * desktop environment shell.
 *
 * The key difference between #GNotification and other similar APIs is
 * that, if supported by the desktop environment, notifications sent
 * with #GNotification will persist after the application has exited,
 * and even across system reboots.
 *
 * Since the user may click on a notification while the application is
 * not running, applications using #GNotification should be able to be
 * started as a D-Bus service, using #GApplication.
 *
 * In order for #GNotification to work, the application must have installed
 * a `.desktop` file. For example:
 * |[
 * [Desktop Entry]
 * Name=Test Application
 * Comment=Description of what Test Application does
 * Exec=gnome-test-application
 * Icon=org.gnome.TestApplication
 * Terminal=false
 * Type=Application
 * Categories=GNOME;GTK;TestApplication Category;
 * StartupNotify=true
 * DBusActivatable=true
 * X-GNOME-UsesNotifications=true
 * ]|
 *
 * The `X-GNOME-UsesNotifications` key indicates to GNOME Control Center
 * that this application uses notifications, so it can be listed in the
 * Control Center’s ‘Notifications’ panel.
 *
 * The `.desktop` file must be named as `org.gnome.TestApplication.desktop`,
 * where `org.gnome.TestApplication` is the ID passed to g_application_new().
 *
 * User interaction with a notification (either the default action, or
 * buttons) must be associated with actions on the application (ie:
 * "app." actions).  It is not possible to route user interaction
 * through the notification itself, because the object will not exist if
 * the application is autostarted as a result of a notification being
 * clicked.
 *
 * A notification can be sent with g_application_send_notification().
 */
class Notification : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_notification_get_type();
  }

  /**
   * a new #GNotification instance
   */
  this(string title)
  {
    GNotification* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = g_notification_new(_title);
    this(_cretval, true);
  }

  /**
   * Adds a button to @notification that activates the action in
   * @detailed_action when clicked. That action must be an
   * application-wide action (starting with "app."). If @detailed_action
   * contains a target, the action will be activated with that target as
   * its parameter.
   *
   * See g_action_parse_detailed_name() for a description of the format
   * for @detailed_action.
   */
  void addButton(string label, string detailedAction)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_notification_add_button(cPtr!GNotification, _label, _detailedAction);
  }

  /**
   * Adds a button to @notification that activates @action when clicked.
   * @action must be an application-wide action (it must start with "app.").
   *
   * If @target is non-%NULL, @action will be activated with @target as
   * its parameter.
   */
  void addButtonWithTarget(string label, string action, Variant target)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _action = action.toCString(false);
    g_notification_add_button_with_target_value(cPtr!GNotification, _label, _action, target ? target.cPtr!GVariant : null);
  }

  /**
   * Sets the body of @notification to @body.
   */
  void setBody(string body_)
  {
    const(char)* _body_ = body_.toCString(false);
    g_notification_set_body(cPtr!GNotification, _body_);
  }

  /**
   * Sets the type of @notification to @category. Categories have a main
   * type like `email`, `im` or `device` and can have a detail separated
   * by a `.`, e.g. `im.received` or `email.arrived`. Setting the category
   * helps the notification server to select proper feedback to the user.
   *
   * Standard categories are [listed in the specification](https://specifications.freedesktop.org/notification-spec/latest/ar01s06.html).
   */
  void setCategory(string category)
  {
    const(char)* _category = category.toCString(false);
    g_notification_set_category(cPtr!GNotification, _category);
  }

  /**
   * Sets the default action of @notification to @detailed_action. This
   * action is activated when the notification is clicked on.
   *
   * The action in @detailed_action must be an application-wide action (it
   * must start with "app."). If @detailed_action contains a target, the
   * given action will be activated with that target as its parameter.
   * See g_action_parse_detailed_name() for a description of the format
   * for @detailed_action.
   *
   * When no default action is set, the application that the notification
   * was sent on is activated.
   */
  void setDefaultAction(string detailedAction)
  {
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_notification_set_default_action(cPtr!GNotification, _detailedAction);
  }

  /**
   * Sets the default action of @notification to @action. This action is
   * activated when the notification is clicked on. It must be an
   * application-wide action (start with "app.").
   *
   * If @target is non-%NULL, @action will be activated with @target as
   * its parameter. If @target is floating, it will be consumed.
   *
   * When no default action is set, the application that the notification
   * was sent on is activated.
   */
  void setDefaultActionAndTarget(string action, Variant target)
  {
    const(char)* _action = action.toCString(false);
    g_notification_set_default_action_and_target_value(cPtr!GNotification, _action, target ? target.cPtr!GVariant : null);
  }

  /**
   * Sets the icon of @notification to @icon.
   */
  void setIcon(Icon icon)
  {
    g_notification_set_icon(cPtr!GNotification, icon ? (cast(ObjectG)icon).cPtr!GIcon : null);
  }

  /**
   * Sets the priority of @notification to @priority. See
   * #GNotificationPriority for possible values.
   */
  void setPriority(NotificationPriority priority)
  {
    g_notification_set_priority(cPtr!GNotification, priority);
  }

  /**
   * Sets the title of @notification to @title.
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    g_notification_set_title(cPtr!GNotification, _title);
  }

  /**
   * Deprecated in favor of g_notification_set_priority().
   */
  void setUrgent(bool urgent)
  {
    g_notification_set_urgent(cPtr!GNotification, urgent);
  }
}
