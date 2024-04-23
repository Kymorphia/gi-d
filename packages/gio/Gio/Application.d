module Gio.Application;

import GLib.ErrorG;
import GLib.OptionEntry;
import GLib.OptionGroup;
import GLib.Types;
import GLib.VariantDict;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ActionMap;
import Gio.ActionMapT;
import Gio.ApplicationCommandLine;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.File;
import Gio.Notification;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GApplication is the foundation of an application.  It wraps some
 * low-level platform-specific services and is intended to act as the
 * foundation for higher-level application classes such as
 * #GtkApplication or #MxApplication.  In general, you should not use
 * this class outside of a higher level framework.
 *
 * GApplication provides convenient life cycle management by maintaining
 * a "use count" for the primary application instance. The use count can
 * be changed using g_application_hold() and g_application_release(). If
 * it drops to zero, the application exits. Higher-level classes such as
 * #GtkApplication employ the use count to ensure that the application
 * stays alive as long as it has any opened windows.
 *
 * Another feature that GApplication (optionally) provides is process
 * uniqueness. Applications can make use of this functionality by
 * providing a unique application ID. If given, only one application
 * with this ID can be running at a time per session. The session
 * concept is platform-dependent, but corresponds roughly to a graphical
 * desktop login. When your application is launched again, its
 * arguments are passed through platform communication to the already
 * running program. The already running instance of the program is
 * called the "primary instance"; for non-unique applications this is
 * always the current instance. On Linux, the D-Bus session bus
 * is used for communication.
 *
 * The use of #GApplication differs from some other commonly-used
 * uniqueness libraries (such as libunique) in important ways. The
 * application is not expected to manually register itself and check
 * if it is the primary instance. Instead, the main() function of a
 * #GApplication should do very little more than instantiating the
 * application instance, possibly connecting signal handlers, then
 * calling g_application_run(). All checks for uniqueness are done
 * internally. If the application is the primary instance then the
 * startup signal is emitted and the mainloop runs. If the application
 * is not the primary instance then a signal is sent to the primary
 * instance and g_application_run() promptly returns. See the code
 * examples below.
 *
 * If used, the expected form of an application identifier is the
 * same as that of a
 * [D-Bus well-known bus name](https://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-names-bus).
 * Examples include: `com.example.MyApp`, `org.example.internal_apps.Calculator`,
 * `org._7_zip.Archiver`.
 * For details on valid application identifiers, see g_application_id_is_valid().
 *
 * On Linux, the application identifier is claimed as a well-known bus name
 * on the user's session bus.  This means that the uniqueness of your
 * application is scoped to the current session.  It also means that your
 * application may provide additional services (through registration of other
 * object paths) at that bus name.  The registration of these object paths
 * should be done with the shared GDBus session bus.  Note that due to the
 * internal architecture of GDBus, method calls can be dispatched at any time
 * (even if a main loop is not running).  For this reason, you must ensure that
 * any object paths that you wish to register are registered before #GApplication
 * attempts to acquire the bus name of your application (which happens in
 * g_application_register()).  Unfortunately, this means that you cannot use
 * g_application_get_is_remote() to decide if you want to register object paths.
 *
 * GApplication also implements the #GActionGroup and #GActionMap
 * interfaces and lets you easily export actions by adding them with
 * g_action_map_add_action(). When invoking an action by calling
 * g_action_group_activate_action() on the application, it is always
 * invoked in the primary instance. The actions are also exported on
 * the session bus, and GIO provides the #GDBusActionGroup wrapper to
 * conveniently access them remotely. GIO provides a #GDBusMenuModel wrapper
 * for remote access to exported #GMenuModels.
 *
 * Note: Due to the fact that actions are exported on the session bus,
 * using `maybe` parameters is not supported, since D-Bus does not support
 * `maybe` types.
 *
 * There is a number of different entry points into a GApplication:
 *
 * - via 'Activate' (i.e. just starting the application)
 *
 * - via 'Open' (i.e. opening some files)
 *
 * - by handling a command-line
 *
 * - via activating an action
 *
 * The #GApplication::startup signal lets you handle the application
 * initialization for all of these in a single place.
 *
 * Regardless of which of these entry points is used to start the
 * application, GApplication passes some ‘platform data’ from the
 * launching instance to the primary instance, in the form of a
 * #GVariant dictionary mapping strings to variants. To use platform
 * data, override the @before_emit or @after_emit virtual functions
 * in your #GApplication subclass. When dealing with
 * #GApplicationCommandLine objects, the platform data is
 * directly available via g_application_command_line_get_cwd(),
 * g_application_command_line_get_environ() and
 * g_application_command_line_get_platform_data().
 *
 * As the name indicates, the platform data may vary depending on the
 * operating system, but it always includes the current directory (key
 * "cwd"), and optionally the environment (ie the set of environment
 * variables and their values) of the calling process (key "environ").
 * The environment is only added to the platform data if the
 * %G_APPLICATION_SEND_ENVIRONMENT flag is set. #GApplication subclasses
 * can add their own platform data by overriding the @add_platform_data
 * virtual function. For instance, #GtkApplication adds startup notification
 * data in this way.
 *
 * To parse commandline arguments you may handle the
 * #GApplication::command-line signal or override the local_command_line()
 * vfunc, to parse them in either the primary instance or the local instance,
 * respectively.
 *
 * For an example of opening files with a GApplication, see
 * [gapplication-example-open.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-open.c).
 *
 * For an example of using actions with GApplication, see
 * [gapplication-example-actions.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-actions.c).
 *
 * For an example of using extra D-Bus hooks with GApplication, see
 * [gapplication-example-dbushooks.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-dbushooks.c).
 */
class Application : ObjectG, ActionGroup, ActionMap
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_application_get_type();
  }

  mixin ActionGroupT!GApplication;
  mixin ActionMapT!GApplication;

  /**
   * a new #GApplication instance
   */
  this(string applicationId, ApplicationFlags flags)
  {
    GApplication* _cretval;
    const(char)* _applicationId = applicationId.toCString(false);
    _cretval = g_application_new(_applicationId, flags);
    this(_cretval, true);
  }

  /**
   * the default application for this process, or %NULL
   */
  static Application getDefault()
  {
    GApplication* _cretval;
    _cretval = g_application_get_default();
    Application _retval = ObjectG.getDObject!Application(cast(GApplication*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if @application_id is valid
   */
  static bool idIsValid(string applicationId)
  {
    bool _retval;
    const(char)* _applicationId = applicationId.toCString(false);
    _retval = g_application_id_is_valid(_applicationId);
    return _retval;
  }

  /**
   * Activates the application.
   *
   * In essence, this results in the #GApplication::activate signal being
   * emitted in the primary instance.
   *
   * The application must be registered before calling this function.
   */
  void activate()
  {
    g_application_activate(cPtr!GApplication);
  }

  /**
   * Add an option to be handled by @application.
   *
   * Calling this function is the equivalent of calling
   * g_application_add_main_option_entries() with a single #GOptionEntry
   * that has its arg_data member set to %NULL.
   *
   * The parsed arguments will be packed into a #GVariantDict which
   * is passed to #GApplication::handle-local-options. If
   * %G_APPLICATION_HANDLES_COMMAND_LINE is set, then it will also
   * be sent to the primary instance. See
   * g_application_add_main_option_entries() for more details.
   *
   * See #GOptionEntry for more documentation of the arguments.
   */
  void addMainOption(string longName, char shortName, OptionFlags flags, OptionArg arg, string description, string argDescription)
  {
    const(char)* _longName = longName.toCString(false);
    const(char)* _description = description.toCString(false);
    const(char)* _argDescription = argDescription.toCString(false);
    g_application_add_main_option(cPtr!GApplication, _longName, shortName, flags, arg, _description, _argDescription);
  }

  /**
   * Adds main option entries to be handled by @application.
   *
   * This function is comparable to g_option_context_add_main_entries().
   *
   * After the commandline arguments are parsed, the
   * #GApplication::handle-local-options signal will be emitted.  At this
   * point, the application can inspect the values pointed to by @arg_data
   * in the given #GOptionEntrys.
   *
   * Unlike #GOptionContext, #GApplication supports giving a %NULL
   * @arg_data for a non-callback #GOptionEntry.  This results in the
   * argument in question being packed into a #GVariantDict which is also
   * passed to #GApplication::handle-local-options, where it can be
   * inspected and modified.  If %G_APPLICATION_HANDLES_COMMAND_LINE is
   * set, then the resulting dictionary is sent to the primary instance,
   * where g_application_command_line_get_options_dict() will return it.
   * As it has been passed outside the process at this point, the types of all
   * values in the options dict must be checked before being used.
   * This "packing" is done according to the type of the argument --
   * booleans for normal flags, strings for strings, bytestrings for
   * filenames, etc.  The packing only occurs if the flag is given (ie: we
   * do not pack a "false" #GVariant in the case that a flag is missing).
   *
   * In general, it is recommended that all commandline arguments are
   * parsed locally.  The options dictionary should then be used to
   * transmit the result of the parsing to the primary instance, where
   * g_variant_dict_lookup() can be used.  For local options, it is
   * possible to either use @arg_data in the usual way, or to consult (and
   * potentially remove) the option from the options dictionary.
   *
   * This function is new in GLib 2.40.  Before then, the only real choice
   * was to send all of the commandline arguments (options and all) to the
   * primary instance for handling.  #GApplication ignored them completely
   * on the local side.  Calling this function "opts in" to the new
   * behaviour, and in particular, means that unrecognised options will be
   * treated as errors.  Unrecognised options have never been ignored when
   * %G_APPLICATION_HANDLES_COMMAND_LINE is unset.
   *
   * If #GApplication::handle-local-options needs to see the list of
   * filenames, then the use of %G_OPTION_REMAINING is recommended.  If
   * @arg_data is %NULL then %G_OPTION_REMAINING can be used as a key into
   * the options dictionary.  If you do use %G_OPTION_REMAINING then you
   * need to handle these arguments for yourself because once they are
   * consumed, they will no longer be visible to the default handling
   * (which treats them as filenames to be opened).
   *
   * It is important to use the proper GVariant format when retrieving
   * the options with g_variant_dict_lookup():
   * - for %G_OPTION_ARG_NONE, use `b`
   * - for %G_OPTION_ARG_STRING, use `&s`
   * - for %G_OPTION_ARG_INT, use `i`
   * - for %G_OPTION_ARG_INT64, use `x`
   * - for %G_OPTION_ARG_DOUBLE, use `d`
   * - for %G_OPTION_ARG_FILENAME, use `^&ay`
   * - for %G_OPTION_ARG_STRING_ARRAY, use `^a&s`
   * - for %G_OPTION_ARG_FILENAME_ARRAY, use `^a&ay`
   */
  void addMainOptionEntries(OptionEntry[] entries)
  {
    GOptionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    _tmpentries ~= GOptionEntry();
    const(GOptionEntry)* _entries = _tmpentries.ptr;
    g_application_add_main_option_entries(cPtr!GApplication, _entries);
  }

  /**
   * Adds a #GOptionGroup to the commandline handling of @application.
   *
   * This function is comparable to g_option_context_add_group().
   *
   * Unlike g_application_add_main_option_entries(), this function does
   * not deal with %NULL @arg_data and never transmits options to the
   * primary instance.
   *
   * The reason for that is because, by the time the options arrive at the
   * primary instance, it is typically too late to do anything with them.
   * Taking the GTK option group as an example: GTK will already have been
   * initialised by the time the #GApplication::command-line handler runs.
   * In the case that this is not the first-running instance of the
   * application, the existing instance may already have been running for
   * a very long time.
   *
   * This means that the options from #GOptionGroup are only really usable
   * in the case that the instance of the application being run is the
   * first instance.  Passing options like `--display=` or `--gdk-debug=`
   * on future runs will have no effect on the existing primary instance.
   *
   * Calling this function will cause the options in the supplied option
   * group to be parsed, but it does not cause you to be "opted in" to the
   * new functionality whereby unrecognised options are rejected even if
   * %G_APPLICATION_HANDLES_COMMAND_LINE was given.
   */
  void addOptionGroup(OptionGroup group)
  {
    g_application_add_option_group(cPtr!GApplication, group ? group.cPtr!GOptionGroup : null);
  }

  /**
   * Marks @application as busy (see g_application_mark_busy()) while
   * @property on @object is %TRUE.
   *
   * The binding holds a reference to @application while it is active, but
   * not to @object. Instead, the binding is destroyed when @object is
   * finalized.
   */
  void bindBusyProperty(ObjectG object, string property)
  {
    const(char)* _property = property.toCString(false);
    g_application_bind_busy_property(cPtr!GApplication, object ? object.cPtr!ObjectC : null, _property);
  }

  /**
   * the identifier for @application, owned by @application
   */
  string getApplicationId()
  {
    const(char)* _cretval;
    _cretval = g_application_get_application_id(cPtr!GApplication);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GDBusConnection, or %NULL
   */
  DBusConnection getDbusConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_application_get_dbus_connection(cPtr!GApplication);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }

  /**
   * the object path, or %NULL
   */
  string getDbusObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_application_get_dbus_object_path(cPtr!GApplication);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the flags for @application
   */
  ApplicationFlags getFlags()
  {
    GApplicationFlags _cretval;
    _cretval = g_application_get_flags(cPtr!GApplication);
    ApplicationFlags _retval = cast(ApplicationFlags)_cretval;
    return _retval;
  }

  /**
   * the timeout, in milliseconds
   */
  uint getInactivityTimeout()
  {
    uint _retval;
    _retval = g_application_get_inactivity_timeout(cPtr!GApplication);
    return _retval;
  }

  /**
   * %TRUE if @application is currently marked as busy
   */
  bool getIsBusy()
  {
    bool _retval;
    _retval = g_application_get_is_busy(cPtr!GApplication);
    return _retval;
  }

  /**
   * %TRUE if @application is registered
   */
  bool getIsRegistered()
  {
    bool _retval;
    _retval = g_application_get_is_registered(cPtr!GApplication);
    return _retval;
  }

  /**
   * %TRUE if @application is remote
   */
  bool getIsRemote()
  {
    bool _retval;
    _retval = g_application_get_is_remote(cPtr!GApplication);
    return _retval;
  }

  /**
   * the base resource path, if one is set
   */
  string getResourceBasePath()
  {
    const(char)* _cretval;
    _cretval = g_application_get_resource_base_path(cPtr!GApplication);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Increases the use count of @application.
   *
   * Use this function to indicate that the application has a reason to
   * continue to run.  For example, g_application_hold() is called by GTK
   * when a toplevel window is on the screen.
   *
   * To cancel the hold, call g_application_release().
   */
  void hold()
  {
    g_application_hold(cPtr!GApplication);
  }

  /**
   * Increases the busy count of @application.
   *
   * Use this function to indicate that the application is busy, for instance
   * while a long running operation is pending.
   *
   * The busy state will be exposed to other processes, so a session shell will
   * use that information to indicate the state to the user (e.g. with a
   * spinner).
   *
   * To cancel the busy indication, use g_application_unmark_busy().
   *
   * The application must be registered before calling this function.
   */
  void markBusy()
  {
    g_application_mark_busy(cPtr!GApplication);
  }

  /**
   * Opens the given files.
   *
   * In essence, this results in the #GApplication::open signal being emitted
   * in the primary instance.
   *
   * @n_files must be greater than zero.
   *
   * @hint is simply passed through to the ::open signal.  It is
   * intended to be used by applications that have multiple modes for
   * opening files (eg: "view" vs "edit", etc).  Unless you have a need
   * for this functionality, you should use "".
   *
   * The application must be registered before calling this function
   * and it must have the %G_APPLICATION_HANDLES_OPEN flag set.
   */
  void open(File[] files, string hint)
  {
    GFile*[] _tmpfiles;
    foreach (obj; files)
      _tmpfiles ~= obj ? (cast(ObjectG)obj).cPtr!GFile : null;
    GFile** _files = _tmpfiles.ptr;

    const(char)* _hint = hint.toCString(false);
    g_application_open(cPtr!GApplication, _files, files ? cast(int)files.length : 0, _hint);
  }

  /**
   * Immediately quits the application.
   *
   * Upon return to the mainloop, g_application_run() will return,
   * calling only the 'shutdown' function before doing so.
   *
   * The hold count is ignored.
   * Take care if your code has called g_application_hold() on the application and
   * is therefore still expecting it to exist.
   * (Note that you may have called g_application_hold() indirectly, for example
   * through gtk_application_add_window().)
   *
   * The result of calling g_application_run() again after it returns is
   * unspecified.
   */
  void quit()
  {
    g_application_quit(cPtr!GApplication);
  }

  /**
   * %TRUE if registration succeeded
   */
  bool register(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_application_register(cPtr!GApplication, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Decrease the use count of @application.
   *
   * When the use count reaches zero, the application will stop running.
   *
   * Never call this function except to cancel the effect of a previous
   * call to g_application_hold().
   */
  void release()
  {
    g_application_release(cPtr!GApplication);
  }

  /**
   * the exit status
   */
  int run(string[] argv)
  {
    int _retval;
    char*[] _tmpargv;
    foreach (s; argv)
      _tmpargv ~= s.toCString(false);
    char** _argv = _tmpargv.ptr;
    _retval = g_application_run(cPtr!GApplication, argv ? cast(int)argv.length : 0, _argv);
    return _retval;
  }

  /**
   * Sends a notification on behalf of @application to the desktop shell.
   * There is no guarantee that the notification is displayed immediately,
   * or even at all.
   *
   * Notifications may persist after the application exits. It will be
   * D-Bus-activated when the notification or one of its actions is
   * activated.
   *
   * Modifying @notification after this call has no effect. However, the
   * object can be reused for a later call to this function.
   *
   * @id may be any string that uniquely identifies the event for the
   * application. It does not need to be in any special format. For
   * example, "new-message" might be appropriate for a notification about
   * new messages.
   *
   * If a previous notification was sent with the same @id, it will be
   * replaced with @notification and shown again as if it was a new
   * notification. This works even for notifications sent from a previous
   * execution of the application, as long as @id is the same string.
   *
   * @id may be %NULL, but it is impossible to replace or withdraw
   * notifications without an id.
   *
   * If @notification is no longer relevant, it can be withdrawn with
   * g_application_withdraw_notification().
   */
  void sendNotification(string id, Notification notification)
  {
    const(char)* _id = id.toCString(false);
    g_application_send_notification(cPtr!GApplication, _id, notification ? notification.cPtr!GNotification : null);
  }

  /**
   * This used to be how actions were associated with a #GApplication.
   * Now there is #GActionMap for that.
   */
  void setActionGroup(ActionGroup actionGroup)
  {
    g_application_set_action_group(cPtr!GApplication, actionGroup ? (cast(ObjectG)actionGroup).cPtr!GActionGroup : null);
  }

  /**
   * Sets the unique identifier for @application.
   *
   * The application id can only be modified if @application has not yet
   * been registered.
   *
   * If non-%NULL, the application id must be valid.  See
   * g_application_id_is_valid().
   */
  void setApplicationId(string applicationId)
  {
    const(char)* _applicationId = applicationId.toCString(false);
    g_application_set_application_id(cPtr!GApplication, _applicationId);
  }

  /**
   * Sets or unsets the default application for the process, as returned
   * by g_application_get_default().
   *
   * This function does not take its own reference on @application.  If
   * @application is destroyed then the default application will revert
   * back to %NULL.
   */
  void setDefault()
  {
    g_application_set_default(cPtr!GApplication);
  }

  /**
   * Sets the flags for @application.
   *
   * The flags can only be modified if @application has not yet been
   * registered.
   *
   * See #GApplicationFlags.
   */
  void setFlags(ApplicationFlags flags)
  {
    g_application_set_flags(cPtr!GApplication, flags);
  }

  /**
   * Sets the current inactivity timeout for the application.
   *
   * This is the amount of time (in milliseconds) after the last call to
   * g_application_release() before the application stops running.
   *
   * This call has no side effects of its own.  The value set here is only
   * used for next time g_application_release() drops the use count to
   * zero.  Any timeouts currently in progress are not impacted.
   */
  void setInactivityTimeout(uint inactivityTimeout)
  {
    g_application_set_inactivity_timeout(cPtr!GApplication, inactivityTimeout);
  }

  /**
   * Adds a description to the @application option context.
   *
   * See g_option_context_set_description() for more information.
   */
  void setOptionContextDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_application_set_option_context_description(cPtr!GApplication, _description);
  }

  /**
   * Sets the parameter string to be used by the commandline handling of @application.
   *
   * This function registers the argument to be passed to g_option_context_new()
   * when the internal #GOptionContext of @application is created.
   *
   * See g_option_context_new() for more information about @parameter_string.
   */
  void setOptionContextParameterString(string parameterString)
  {
    const(char)* _parameterString = parameterString.toCString(false);
    g_application_set_option_context_parameter_string(cPtr!GApplication, _parameterString);
  }

  /**
   * Adds a summary to the @application option context.
   *
   * See g_option_context_set_summary() for more information.
   */
  void setOptionContextSummary(string summary)
  {
    const(char)* _summary = summary.toCString(false);
    g_application_set_option_context_summary(cPtr!GApplication, _summary);
  }

  /**
   * Sets (or unsets) the base resource path of @application.
   *
   * The path is used to automatically load various [application
   * resources][gresource] such as menu layouts and action descriptions.
   * The various types of resources will be found at fixed names relative
   * to the given base path.
   *
   * By default, the resource base path is determined from the application
   * ID by prefixing '/' and replacing each '.' with '/'.  This is done at
   * the time that the #GApplication object is constructed.  Changes to
   * the application ID after that point will not have an impact on the
   * resource base path.
   *
   * As an example, if the application has an ID of "org.example.app" then
   * the default resource base path will be "/org/example/app".  If this
   * is a #GtkApplication (and you have not manually changed the path)
   * then Gtk will then search for the menus of the application at
   * "/org/example/app/gtk/menus.ui".
   *
   * See #GResource for more information about adding resources to your
   * application.
   *
   * You can disable automatic resource loading functionality by setting
   * the path to %NULL.
   *
   * Changing the resource base path once the application is running is
   * not recommended.  The point at which the resource path is consulted
   * for forming paths for various purposes is unspecified.  When writing
   * a sub-class of #GApplication you should either set the
   * #GApplication:resource-base-path property at construction time, or call
   * this function during the instance initialization. Alternatively, you
   * can call this function in the #GApplicationClass.startup virtual function,
   * before chaining up to the parent implementation.
   */
  void setResourceBasePath(string resourcePath)
  {
    const(char)* _resourcePath = resourcePath.toCString(false);
    g_application_set_resource_base_path(cPtr!GApplication, _resourcePath);
  }

  /**
   * Destroys a binding between @property and the busy state of
   * @application that was previously created with
   * g_application_bind_busy_property().
   */
  void unbindBusyProperty(ObjectG object, string property)
  {
    const(char)* _property = property.toCString(false);
    g_application_unbind_busy_property(cPtr!GApplication, object ? object.cPtr!ObjectC : null, _property);
  }

  /**
   * Decreases the busy count of @application.
   *
   * When the busy count reaches zero, the new state will be propagated
   * to other processes.
   *
   * This function must only be called to cancel the effect of a previous
   * call to g_application_mark_busy().
   */
  void unmarkBusy()
  {
    g_application_unmark_busy(cPtr!GApplication);
  }

  /**
   * Withdraws a notification that was sent with
   * g_application_send_notification().
   *
   * This call does nothing if a notification with @id doesn't exist or
   * the notification was never sent.
   *
   * This function works even for notifications sent in previous
   * executions of this application, as long @id is the same as it was for
   * the sent notification.
   *
   * Note that notifications are dismissed when the user clicks on one
   * of the buttons in a notification or triggers its default action, so
   * there is no need to explicitly withdraw the notification in that case.
   */
  void withdrawNotification(string id)
  {
    const(char)* _id = id.toCString(false);
    g_application_withdraw_notification(cPtr!GApplication, _id);
  }

  /**
   * The ::activate signal is emitted on the primary instance when an
   * activation occurs. See g_application_activate().
   */
  ulong connectActivate(void delegate(Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * An integer that is set as the exit status for the calling
   * process. See g_application_command_line_set_exit_status().
   */
  ulong connectCommandLine(int delegate(ApplicationCommandLine commandLine, Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      int _retval;
      auto application = getVal!Application(_paramVals);
      auto commandLine = getVal!ApplicationCommandLine(&_paramVals[1]);
      _retval = _dgClosure.dlg(commandLine, application);
      setVal!int(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("command-line", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * an exit code. If you have handled your options and want
   * to exit the process, return a non-negative option, 0 for success,
   * and a positive value for failure. To continue, return -1 to let
   * the default option processing continue.
   */
  ulong connectHandleLocalOptions(int delegate(VariantDict options, Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      int _retval;
      auto application = getVal!Application(_paramVals);
      auto options = getVal!VariantDict(&_paramVals[1]);
      _retval = _dgClosure.dlg(options, application);
      setVal!int(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("handle-local-options", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * %TRUE if the signal has been handled
   */
  ulong connectNameLost(bool delegate(Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto application = getVal!Application(_paramVals);
      _retval = _dgClosure.dlg(application);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("name-lost", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::shutdown signal is emitted only on the registered primary instance
   * immediately after the main loop terminates.
   */
  ulong connectShutdown(void delegate(Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("shutdown", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::startup signal is emitted on the primary instance immediately
   * after registration. See g_application_register().
   */
  ulong connectStartup(void delegate(Application application) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("startup", closure, (flags & ConnectFlags.After) != 0);
  }
}
