module Gio.Notification;

import GLib.Variant;
import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GNotification` is a mechanism for creating a notification to be shown
 * to the user — typically as a pop-up notification presented by the
 * desktop environment shell.
 * The key difference between `GNotification` and other similar APIs is
 * that, if supported by the desktop environment, notifications sent
 * with `GNotification` will persist after the application has exited,
 * and even across system reboots.
 * Since the user may click on a notification while the application is
 * not running, applications using `GNotification` should be able to be
 * started as a D-Bus service, using [Gio.Application].
 * In order for `GNotification` to work, the application must have installed
 * a `.desktop` file. For example:
 * ```
 * [Desktop Entry]
 * Name\=Test Application
 * Comment\=Description of what Test Application does
 * Exec\=gnome-test-application
 * Icon\=org.gnome.TestApplication
 * Terminal\=false
 * Type\=Application
 * Categories\=GNOME;GTK;TestApplication Category;
 * StartupNotify\=true
 * DBusActivatable\=true
 * X-GNOME-UsesNotifications\=true
 * ```
 * The `X-GNOME-UsesNotifications` key indicates to GNOME Control Center
 * that this application uses notifications, so it can be listed in the
 * Control Center’s ‘Notifications’ panel.
 * The `.desktop` file must be named as `org.gnome.TestApplication.desktop`,
 * where `org.gnome.TestApplication` is the ID passed to
 * [Gio.Application.new_].
 * User interaction with a notification $(LPAREN)either the default action, or
 * buttons$(RPAREN) must be associated with actions on the application $(LPAREN)ie:
 * `app.` actions$(RPAREN).  It is not possible to route user interaction
 * through the notification itself, because the object will not exist if
 * the application is autostarted as a result of a notification being
 * clicked.
 * A notification can be sent with [Gio.Application.sendNotification].
 */
class Notification : ObjectG
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
    return g_notification_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GNotification with title as its title.
   * After populating notification with more details, it can be sent to
   * the desktop shell with [Gio.Application.sendNotification]. Changing
   * any properties after this call will not have any effect until
   * resending notification.
   * Params:
   *   title = the title of the notification
   * Returns: a new #GNotification instance
   */
  this(string title)
  {
    GNotification* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = g_notification_new(_title);
    this(_cretval, true);
  }

  /**
   * Adds a button to notification that activates the action in
   * detailed_action when clicked. That action must be an
   * application-wide action $(LPAREN)starting with "app."$(RPAREN). If detailed_action
   * contains a target, the action will be activated with that target as
   * its parameter.
   * See [Gio.Action.parseDetailedName] for a description of the format
   * for detailed_action.
   * Params:
   *   label = label of the button
   *   detailedAction = a detailed action name
   */
  void addButton(string label, string detailedAction)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_notification_add_button(cast(GNotification*)cPtr, _label, _detailedAction);
  }

  /**
   * Adds a button to notification that activates action when clicked.
   * action must be an application-wide action $(LPAREN)it must start with "app."$(RPAREN).
   * If target is non-%NULL, action will be activated with target as
   * its parameter.
   * Params:
   *   label = label of the button
   *   action = an action name
   *   target = a #GVariant to use as action's parameter, or %NULL
   */
  void addButtonWithTarget(string label, string action, Variant target)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _action = action.toCString(false);
    g_notification_add_button_with_target_value(cast(GNotification*)cPtr, _label, _action, target ? cast(GVariant*)target.cPtr(false) : null);
  }

  /**
   * Sets the body of notification to body.
   * Params:
   *   body_ = the new body for notification, or %NULL
   */
  void setBody(string body_)
  {
    const(char)* _body_ = body_.toCString(false);
    g_notification_set_body(cast(GNotification*)cPtr, _body_);
  }

  /**
   * Sets the type of notification to category. Categories have a main
   * type like `email`, `im` or `device` and can have a detail separated
   * by a `.`, e.g. `im.received` or `email.arrived`. Setting the category
   * helps the notification server to select proper feedback to the user.
   * Standard categories are [listed in the specification](https://specifications.freedesktop.org/notification-spec/latest/ar01s06.html).
   * Params:
   *   category = the category for notification, or %NULL for no category
   */
  void setCategory(string category)
  {
    const(char)* _category = category.toCString(false);
    g_notification_set_category(cast(GNotification*)cPtr, _category);
  }

  /**
   * Sets the default action of notification to detailed_action. This
   * action is activated when the notification is clicked on.
   * The action in detailed_action must be an application-wide action $(LPAREN)it
   * must start with "app."$(RPAREN). If detailed_action contains a target, the
   * given action will be activated with that target as its parameter.
   * See [Gio.Action.parseDetailedName] for a description of the format
   * for detailed_action.
   * When no default action is set, the application that the notification
   * was sent on is activated.
   * Params:
   *   detailedAction = a detailed action name
   */
  void setDefaultAction(string detailedAction)
  {
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_notification_set_default_action(cast(GNotification*)cPtr, _detailedAction);
  }

  /**
   * Sets the default action of notification to action. This action is
   * activated when the notification is clicked on. It must be an
   * application-wide action $(LPAREN)start with "app."$(RPAREN).
   * If target is non-%NULL, action will be activated with target as
   * its parameter. If target is floating, it will be consumed.
   * When no default action is set, the application that the notification
   * was sent on is activated.
   * Params:
   *   action = an action name
   *   target = a #GVariant to use as action's parameter, or %NULL
   */
  void setDefaultActionAndTarget(string action, Variant target)
  {
    const(char)* _action = action.toCString(false);
    g_notification_set_default_action_and_target_value(cast(GNotification*)cPtr, _action, target ? cast(GVariant*)target.cPtr(false) : null);
  }

  /**
   * Sets the icon of notification to icon.
   * Params:
   *   icon = the icon to be shown in notification, as a #GIcon
   */
  void setIcon(Icon icon)
  {
    g_notification_set_icon(cast(GNotification*)cPtr, icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null);
  }

  /**
   * Sets the priority of notification to priority. See
   * #GNotificationPriority for possible values.
   * Params:
   *   priority = a #GNotificationPriority
   */
  void setPriority(NotificationPriority priority)
  {
    g_notification_set_priority(cast(GNotification*)cPtr, priority);
  }

  /**
   * Sets the title of notification to title.
   * Params:
   *   title = the new title for notification
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    g_notification_set_title(cast(GNotification*)cPtr, _title);
  }

  /**
   * Deprecated in favor of [Gio.Notification.setPriority].
   * Params:
   *   urgent = %TRUE if notification is urgent

   * Deprecated: Since 2.42, this has been deprecated in favour of
   *   [Gio.Notification.setPriority].
   */
  void setUrgent(bool urgent)
  {
    g_notification_set_urgent(cast(GNotification*)cPtr, urgent);
  }
}
