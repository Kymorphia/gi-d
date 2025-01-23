module Gio.Application;

import GLib.ErrorG;
import GLib.OptionGroup;
import GLib.Types;
import GLib.VariantDict;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ActionMap;
import Gio.ActionMapT;
import Gio.ApplicationCommandLine;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.File;
import Gio.FileT;
import Gio.Notification;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GApplication` is the core class for application support.
 * A `GApplication` is the foundation of an application. It wraps some
 * low-level platform-specific services and is intended to act as the
 * foundation for higher-level application classes such as
 * `GtkApplication` or `MxApplication`. In general, you should not use
 * this class outside of a higher level framework.
 * `GApplication` provides convenient life-cycle management by maintaining
 * a "use count" for the primary application instance. The use count can
 * be changed using [Gio.Application.hold] and
 * [Gio.Application.release]. If it drops to zero, the application
 * exits. Higher-level classes such as `GtkApplication` employ the use count
 * to ensure that the application stays alive as long as it has any opened
 * windows.
 * Another feature that `GApplication` $(LPAREN)optionally$(RPAREN) provides is process
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
 * The use of `GApplication` differs from some other commonly-used
 * uniqueness libraries $(LPAREN)such as libunique$(RPAREN) in important ways. The
 * application is not expected to manually register itself and check
 * if it is the primary instance. Instead, the main$(LPAREN)$(RPAREN) function of a
 * `GApplication` should do very little more than instantiating the
 * application instance, possibly connecting signal handlers, then
 * calling [Gio.Application.run]. All checks for uniqueness are done
 * internally. If the application is the primary instance then the
 * startup signal is emitted and the mainloop runs. If the application
 * is not the primary instance then a signal is sent to the primary
 * instance and [Gio.Application.run] promptly returns. See the code
 * examples below.
 * If used, the expected form of an application identifier is the
 * same as that of a
 * [D-Bus well-known bus name](https://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-names-bus).
 * Examples include: `com.example.MyApp`, `org.example.internal_apps.Calculator`,
 * `org._7_zip.Archiver`.
 * For details on valid application identifiers, see [Gio.Application.idIsValid].
 * On Linux, the application identifier is claimed as a well-known bus name
 * on the user's session bus. This means that the uniqueness of your
 * application is scoped to the current session. It also means that your
 * application may provide additional services $(LPAREN)through registration of other
 * object paths$(RPAREN) at that bus name. The registration of these object paths
 * should be done with the shared GDBus session bus. Note that due to the
 * internal architecture of GDBus, method calls can be dispatched at any time
 * $(LPAREN)even if a main loop is not running$(RPAREN). For this reason, you must ensure that
 * any object paths that you wish to register are registered before #GApplication
 * attempts to acquire the bus name of your application $(LPAREN)which happens in
 * [Gio.Application.register]$(RPAREN). Unfortunately, this means that you cannot
 * use property@Gio.Application:is-remote to decide if you want to register
 * object paths.
 * `GApplication` also implements the [Gio.ActionGroup] and [Gio.ActionMap]
 * interfaces and lets you easily export actions by adding them with
 * [Gio.ActionMap.addAction]. When invoking an action by calling
 * [Gio.ActionGroup.activateAction] on the application, it is always
 * invoked in the primary instance. The actions are also exported on
 * the session bus, and GIO provides the [Gio.DBusActionGroup] wrapper to
 * conveniently access them remotely. GIO provides a [Gio.DBusMenuModel] wrapper
 * for remote access to exported [Gio.MenuModel]s.
 * Note: Due to the fact that actions are exported on the session bus,
 * using `maybe` parameters is not supported, since D-Bus does not support
 * `maybe` types.
 * There is a number of different entry points into a `GApplication`:
 * - via 'Activate' $(LPAREN)i.e. just starting the application$(RPAREN)
 * - via 'Open' $(LPAREN)i.e. opening some files$(RPAREN)
 * - by handling a command-line
 * - via activating an action
 * The [Gio.Application.startup] signal lets you handle the application
 * initialization for all of these in a single place.
 * Regardless of which of these entry points is used to start the
 * application, `GApplication` passes some ‘platform data’ from the
 * launching instance to the primary instance, in the form of a
 * [GLib.VariantG] dictionary mapping strings to variants. To use platform
 * data, override the vfunc@Gio.Application.before_emit or
 * vfunc@Gio.Application.after_emit virtual functions
 * in your `GApplication` subclass. When dealing with
 * [Gio.ApplicationCommandLine] objects, the platform data is
 * directly available via [Gio.ApplicationCommandLine.getCwd],
 * [Gio.ApplicationCommandLine.getEnviron] and
 * [Gio.ApplicationCommandLine.getPlatformData].
 * As the name indicates, the platform data may vary depending on the
 * operating system, but it always includes the current directory $(LPAREN)key
 * `cwd`$(RPAREN), and optionally the environment $(LPAREN)ie the set of environment
 * variables and their values$(RPAREN) of the calling process $(LPAREN)key `environ`$(RPAREN).
 * The environment is only added to the platform data if the
 * `G_APPLICATION_SEND_ENVIRONMENT` flag is set. `GApplication` subclasses
 * can add their own platform data by overriding the
 * vfunc@Gio.Application.add_platform_data virtual function. For instance,
 * `GtkApplication` adds startup notification data in this way.
 * To parse commandline arguments you may handle the
 * signal@Gio.Application::command-line signal or override the
 * vfunc@Gio.Application.local_command_line virtual funcion, to parse them in
 * either the primary instance or the local instance, respectively.
 * For an example of opening files with a `GApplication`, see
 * [gapplication-example-open.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-open.c).
 * For an example of using actions with `GApplication`, see
 * [gapplication-example-actions.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-actions.c).
 * For an example of using extra D-Bus hooks with `GApplication`, see
 * [gapplication-example-dbushooks.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-dbushooks.c).
 */
class Application : ObjectG, ActionGroup, ActionMap
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
    return g_application_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionGroupT!();
  mixin ActionMapT!();

  /**
   * Creates a new #GApplication instance.
   * If non-%NULL, the application id must be valid.  See
   * [Gio.Application.idIsValid].
   * If no application ID is given then some features of #GApplication
   * $(LPAREN)most notably application uniqueness$(RPAREN) will be disabled.
   * Params:
   *   applicationId = the application id
   *   flags = the application flags
   * Returns: a new #GApplication instance
   */
  this(string applicationId, ApplicationFlags flags)
  {
    GApplication* _cretval;
    const(char)* _applicationId = applicationId.toCString(false);
    _cretval = g_application_new(_applicationId, flags);
    this(_cretval, true);
  }

  /**
   * Returns the default #GApplication instance for this process.
   * Normally there is only one #GApplication per process and it becomes
   * the default when it is created.  You can exercise more control over
   * this by using [Gio.Application.setDefault].
   * If there is no default application then %NULL is returned.
   * Returns: the default application for this process, or %NULL
   */
  static Application getDefault()
  {
    GApplication* _cretval;
    _cretval = g_application_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!Application(cast(GApplication*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if application_id is a valid application identifier.
   * A valid ID is required for calls to [Gio.Application.new_] and
   * [Gio.Application.setApplicationId].
   * Application identifiers follow the same format as
   * [D-Bus well-known bus names](https://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-names-bus).
   * For convenience, the restrictions on application identifiers are
   * reproduced here:
   * - Application identifiers are composed of 1 or more elements separated by a
   * period $(LPAREN)`.`$(RPAREN) character. All elements must contain at least one character.
   * - Each element must only contain the ASCII characters `[A-Z][a-z][0-9]_-`,
   * with `-` discouraged in new application identifiers. Each element must not
   * begin with a digit.
   * - Application identifiers must contain at least one `.` $(LPAREN)period$(RPAREN) character
   * $(LPAREN)and thus at least two elements$(RPAREN).
   * - Application identifiers must not begin with a `.` $(LPAREN)period$(RPAREN) character.
   * - Application identifiers must not exceed 255 characters.
   * Note that the hyphen $(LPAREN)`-`$(RPAREN) character is allowed in application identifiers,
   * but is problematic or not allowed in various specifications and APIs that
   * refer to D-Bus, such as
   * [Flatpak application IDs](http://docs.flatpak.org/en/latest/introduction.html#identifiers),
   * the
   * [`DBusActivatable` interface in the Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#dbus),
   * and the convention that an application's "main" interface and object path
   * resemble its application identifier and bus name. To avoid situations that
   * require special-case handling, it is recommended that new application
   * identifiers consistently replace hyphens with underscores.
   * Like D-Bus interface names, application identifiers should start with the
   * reversed DNS domain name of the author of the interface $(LPAREN)in lower-case$(RPAREN), and
   * it is conventional for the rest of the application identifier to consist of
   * words run together, with initial capital letters.
   * As with D-Bus interface names, if the author's DNS domain name contains
   * hyphen/minus characters they should be replaced by underscores, and if it
   * contains leading digits they should be escaped by prepending an underscore.
   * For example, if the owner of 7-zip.org used an application identifier for an
   * archiving application, it might be named `org._7_zip.Archiver`.
   * Params:
   *   applicationId = a potential application identifier
   * Returns: %TRUE if application_id is valid
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
   * In essence, this results in the #GApplication::activate signal being
   * emitted in the primary instance.
   * The application must be registered before calling this function.
   */
  void activate()
  {
    g_application_activate(cast(GApplication*)cPtr);
  }

  /**
   * Add an option to be handled by application.
   * Calling this function is the equivalent of calling
   * [Gio.Application.addMainOptionEntries] with a single #GOptionEntry
   * that has its arg_data member set to %NULL.
   * The parsed arguments will be packed into a #GVariantDict which
   * is passed to #GApplication::handle-local-options. If
   * %G_APPLICATION_HANDLES_COMMAND_LINE is set, then it will also
   * be sent to the primary instance. See
   * [Gio.Application.addMainOptionEntries] for more details.
   * See #GOptionEntry for more documentation of the arguments.
   * Params:
   *   longName = the long name of an option used to specify it in a commandline
   *   shortName = the short name of an option
   *   flags = flags from #GOptionFlags
   *   arg = the type of the option, as a #GOptionArg
   *   description = the description for the option in `--help` output
   *   argDescription = the placeholder to use for the extra argument
   *     parsed by the option in `--help` output
   */
  void addMainOption(string longName, char shortName, OptionFlags flags, OptionArg arg, string description, string argDescription)
  {
    const(char)* _longName = longName.toCString(false);
    const(char)* _description = description.toCString(false);
    const(char)* _argDescription = argDescription.toCString(false);
    g_application_add_main_option(cast(GApplication*)cPtr, _longName, shortName, flags, arg, _description, _argDescription);
  }

  /**
   * Adds main option entries to be handled by application.
   * This function is comparable to [GLib.OptionContext.addMainEntries].
   * After the commandline arguments are parsed, the
   * #GApplication::handle-local-options signal will be emitted.  At this
   * point, the application can inspect the values pointed to by arg_data
   * in the given #GOptionEntrys.
   * Unlike #GOptionContext, #GApplication supports giving a %NULL
   * arg_data for a non-callback #GOptionEntry.  This results in the
   * argument in question being packed into a #GVariantDict which is also
   * passed to #GApplication::handle-local-options, where it can be
   * inspected and modified.  If %G_APPLICATION_HANDLES_COMMAND_LINE is
   * set, then the resulting dictionary is sent to the primary instance,
   * where [Gio.ApplicationCommandLine.getOptionsDict] will return it.
   * As it has been passed outside the process at this point, the types of all
   * values in the options dict must be checked before being used.
   * This "packing" is done according to the type of the argument --
   * booleans for normal flags, strings for strings, bytestrings for
   * filenames, etc.  The packing only occurs if the flag is given $(LPAREN)ie: we
   * do not pack a "false" #GVariant in the case that a flag is missing$(RPAREN).
   * In general, it is recommended that all commandline arguments are
   * parsed locally.  The options dictionary should then be used to
   * transmit the result of the parsing to the primary instance, where
   * [GLib.VariantDict.lookup] can be used.  For local options, it is
   * possible to either use arg_data in the usual way, or to consult $(LPAREN)and
   * potentially remove$(RPAREN) the option from the options dictionary.
   * This function is new in GLib 2.40.  Before then, the only real choice
   * was to send all of the commandline arguments $(LPAREN)options and all$(RPAREN) to the
   * primary instance for handling.  #GApplication ignored them completely
   * on the local side.  Calling this function "opts in" to the new
   * behaviour, and in particular, means that unrecognised options will be
   * treated as errors.  Unrecognised options have never been ignored when
   * %G_APPLICATION_HANDLES_COMMAND_LINE is unset.
   * If #GApplication::handle-local-options needs to see the list of
   * filenames, then the use of %G_OPTION_REMAINING is recommended.  If
   * arg_data is %NULL then %G_OPTION_REMAINING can be used as a key into
   * the options dictionary.  If you do use %G_OPTION_REMAINING then you
   * need to handle these arguments for yourself because once they are
   * consumed, they will no longer be visible to the default handling
   * $(LPAREN)which treats them as filenames to be opened$(RPAREN).
   * It is important to use the proper GVariant format when retrieving
   * the options with [GLib.VariantDict.lookup]:
   * - for %G_OPTION_ARG_NONE, use `b`
   * - for %G_OPTION_ARG_STRING, use `&s`
   * - for %G_OPTION_ARG_INT, use `i`
   * - for %G_OPTION_ARG_INT64, use `x`
   * - for %G_OPTION_ARG_DOUBLE, use `d`
   * - for %G_OPTION_ARG_FILENAME, use `^&ay`
   * - for %G_OPTION_ARG_STRING_ARRAY, use `^a&s`
   * - for %G_OPTION_ARG_FILENAME_ARRAY, use `^a&ay`
   * Params:
   *   entries = the
   *     main options for the application
   */
  void addMainOptionEntries(OptionEntry[] entries)
  {
    auto _entries = cast(const(GOptionEntry)*)(entries ~ GOptionEntry.init).ptr;
    g_application_add_main_option_entries(cast(GApplication*)cPtr, _entries);
  }

  /**
   * Adds a #GOptionGroup to the commandline handling of application.
   * This function is comparable to [GLib.OptionContext.addGroup].
   * Unlike [Gio.Application.addMainOptionEntries], this function does
   * not deal with %NULL arg_data and never transmits options to the
   * primary instance.
   * The reason for that is because, by the time the options arrive at the
   * primary instance, it is typically too late to do anything with them.
   * Taking the GTK option group as an example: GTK will already have been
   * initialised by the time the #GApplication::command-line handler runs.
   * In the case that this is not the first-running instance of the
   * application, the existing instance may already have been running for
   * a very long time.
   * This means that the options from #GOptionGroup are only really usable
   * in the case that the instance of the application being run is the
   * first instance.  Passing options like `--display\=` or `--gdk-debug\=`
   * on future runs will have no effect on the existing primary instance.
   * Calling this function will cause the options in the supplied option
   * group to be parsed, but it does not cause you to be "opted in" to the
   * new functionality whereby unrecognised options are rejected even if
   * %G_APPLICATION_HANDLES_COMMAND_LINE was given.
   * Params:
   *   group = a #GOptionGroup
   */
  void addOptionGroup(OptionGroup group)
  {
    g_application_add_option_group(cast(GApplication*)cPtr, group ? cast(GOptionGroup*)group.cPtr(true) : null);
  }

  /**
   * Marks application as busy $(LPAREN)see [Gio.Application.markBusy]$(RPAREN) while
   * property on object is %TRUE.
   * The binding holds a reference to application while it is active, but
   * not to object. Instead, the binding is destroyed when object is
   * finalized.
   * Params:
   *   object = a #GObject
   *   property = the name of a boolean property of object
   */
  void bindBusyProperty(ObjectG object, string property)
  {
    const(char)* _property = property.toCString(false);
    g_application_bind_busy_property(cast(GApplication*)cPtr, object ? cast(ObjectC*)object.cPtr(false) : null, _property);
  }

  /**
   * Gets the unique identifier for application.
   * Returns: the identifier for application, owned by application
   */
  string getApplicationId()
  {
    const(char)* _cretval;
    _cretval = g_application_get_application_id(cast(GApplication*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the #GDBusConnection being used by the application, or %NULL.
   * If #GApplication is using its D-Bus backend then this function will
   * return the #GDBusConnection being used for uniqueness and
   * communication with the desktop environment and other instances of the
   * application.
   * If #GApplication is not using D-Bus then this function will return
   * %NULL.  This includes the situation where the D-Bus backend would
   * normally be in use but we were unable to connect to the bus.
   * This function must not be called before the application has been
   * registered.  See [Gio.Application.getIsRegistered].
   * Returns: a #GDBusConnection, or %NULL
   */
  DBusConnection getDbusConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_application_get_dbus_connection(cast(GApplication*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the D-Bus object path being used by the application, or %NULL.
   * If #GApplication is using its D-Bus backend then this function will
   * return the D-Bus object path that #GApplication is using.  If the
   * application is the primary instance then there is an object published
   * at this path.  If the application is not the primary instance then
   * the result of this function is undefined.
   * If #GApplication is not using D-Bus then this function will return
   * %NULL.  This includes the situation where the D-Bus backend would
   * normally be in use but we were unable to connect to the bus.
   * This function must not be called before the application has been
   * registered.  See [Gio.Application.getIsRegistered].
   * Returns: the object path, or %NULL
   */
  string getDbusObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_application_get_dbus_object_path(cast(GApplication*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the flags for application.
   * See #GApplicationFlags.
   * Returns: the flags for application
   */
  ApplicationFlags getFlags()
  {
    GApplicationFlags _cretval;
    _cretval = g_application_get_flags(cast(GApplication*)cPtr);
    ApplicationFlags _retval = cast(ApplicationFlags)_cretval;
    return _retval;
  }

  /**
   * Gets the current inactivity timeout for the application.
   * This is the amount of time $(LPAREN)in milliseconds$(RPAREN) after the last call to
   * [Gio.Application.release] before the application stops running.
   * Returns: the timeout, in milliseconds
   */
  uint getInactivityTimeout()
  {
    uint _retval;
    _retval = g_application_get_inactivity_timeout(cast(GApplication*)cPtr);
    return _retval;
  }

  /**
   * Gets the application's current busy state, as set through
   * [Gio.Application.markBusy] or [Gio.Application.bindBusyProperty].
   * Returns: %TRUE if application is currently marked as busy
   */
  bool getIsBusy()
  {
    bool _retval;
    _retval = g_application_get_is_busy(cast(GApplication*)cPtr);
    return _retval;
  }

  /**
   * Checks if application is registered.
   * An application is registered if [Gio.Application.register] has been
   * successfully called.
   * Returns: %TRUE if application is registered
   */
  bool getIsRegistered()
  {
    bool _retval;
    _retval = g_application_get_is_registered(cast(GApplication*)cPtr);
    return _retval;
  }

  /**
   * Checks if application is remote.
   * If application is remote then it means that another instance of
   * application already exists $(LPAREN)the 'primary' instance$(RPAREN).  Calls to
   * perform actions on application will result in the actions being
   * performed by the primary instance.
   * The value of this property cannot be accessed before
   * [Gio.Application.register] has been called.  See
   * [Gio.Application.getIsRegistered].
   * Returns: %TRUE if application is remote
   */
  bool getIsRemote()
  {
    bool _retval;
    _retval = g_application_get_is_remote(cast(GApplication*)cPtr);
    return _retval;
  }

  /**
   * Gets the resource base path of application.
   * See [Gio.Application.setResourceBasePath] for more information.
   * Returns: the base resource path, if one is set
   */
  string getResourceBasePath()
  {
    const(char)* _cretval;
    _cretval = g_application_get_resource_base_path(cast(GApplication*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the version of application.
   * Returns: the version of application
   */
  string getVersion()
  {
    const(char)* _cretval;
    _cretval = g_application_get_version(cast(GApplication*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Increases the use count of application.
   * Use this function to indicate that the application has a reason to
   * continue to run.  For example, [Gio.Application.hold] is called by GTK
   * when a toplevel window is on the screen.
   * To cancel the hold, call [Gio.Application.release].
   */
  void hold()
  {
    g_application_hold(cast(GApplication*)cPtr);
  }

  /**
   * Increases the busy count of application.
   * Use this function to indicate that the application is busy, for instance
   * while a long running operation is pending.
   * The busy state will be exposed to other processes, so a session shell will
   * use that information to indicate the state to the user $(LPAREN)e.g. with a
   * spinner$(RPAREN).
   * To cancel the busy indication, use [Gio.Application.unmarkBusy].
   * The application must be registered before calling this function.
   */
  void markBusy()
  {
    g_application_mark_busy(cast(GApplication*)cPtr);
  }

  /**
   * Opens the given files.
   * In essence, this results in the #GApplication::open signal being emitted
   * in the primary instance.
   * n_files must be greater than zero.
   * hint is simply passed through to the ::open signal.  It is
   * intended to be used by applications that have multiple modes for
   * opening files $(LPAREN)eg: "view" vs "edit", etc$(RPAREN).  Unless you have a need
   * for this functionality, you should use "".
   * The application must be registered before calling this function
   * and it must have the %G_APPLICATION_HANDLES_OPEN flag set.
   * Params:
   *   files = an array of #GFiles to open
   *   hint = a hint $(LPAREN)or ""$(RPAREN), but never %NULL
   */
  void open(File[] files, string hint)
  {
    int _nFiles;
    if (files)
      _nFiles = cast(int)files.length;

    GFile*[] _tmpfiles;
    foreach (obj; files)
      _tmpfiles ~= obj ? cast(GFile*)(cast(ObjectG)obj).cPtr : null;
    GFile** _files = _tmpfiles.ptr;

    const(char)* _hint = hint.toCString(false);
    g_application_open(cast(GApplication*)cPtr, _files, _nFiles, _hint);
  }

  /**
   * Immediately quits the application.
   * Upon return to the mainloop, [Gio.Application.run] will return,
   * calling only the 'shutdown' function before doing so.
   * The hold count is ignored.
   * Take care if your code has called [Gio.Application.hold] on the application and
   * is therefore still expecting it to exist.
   * $(LPAREN)Note that you may have called [Gio.Application.hold] indirectly, for example
   * through [Gtk.DGtkApplication.addWindow].$(RPAREN)
   * The result of calling [Gio.Application.run] again after it returns is
   * unspecified.
   */
  void quit()
  {
    g_application_quit(cast(GApplication*)cPtr);
  }

  /**
   * Attempts registration of the application.
   * This is the point at which the application discovers if it is the
   * primary instance or merely acting as a remote for an already-existing
   * primary instance.  This is implemented by attempting to acquire the
   * application identifier as a unique bus name on the session bus using
   * GDBus.
   * If there is no application ID or if %G_APPLICATION_NON_UNIQUE was
   * given, then this process will always become the primary instance.
   * Due to the internal architecture of GDBus, method calls can be
   * dispatched at any time $(LPAREN)even if a main loop is not running$(RPAREN).  For
   * this reason, you must ensure that any object paths that you wish to
   * register are registered before calling this function.
   * If the application has already been registered then %TRUE is
   * returned with no work performed.
   * The #GApplication::startup signal is emitted if registration succeeds
   * and application is the primary instance $(LPAREN)including the non-unique
   * case$(RPAREN).
   * In the event of an error $(LPAREN)such as cancellable being cancelled, or a
   * failure to connect to the session bus$(RPAREN), %FALSE is returned and error
   * is set appropriately.
   * Note: the return value of this function is not an indicator that this
   * instance is or is not the primary instance of the application.  See
   * [Gio.Application.getIsRemote] for that.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE if registration succeeded
   */
  bool register(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_application_register(cast(GApplication*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Decrease the use count of application.
   * When the use count reaches zero, the application will stop running.
   * Never call this function except to cancel the effect of a previous
   * call to [Gio.Application.hold].
   */
  void release()
  {
    g_application_release(cast(GApplication*)cPtr);
  }

  /**
   * Runs the application.
   * This function is intended to be run from main$(LPAREN)$(RPAREN) and its return value
   * is intended to be returned by main$(LPAREN)$(RPAREN). Although you are expected to pass
   * the argc, argv parameters from main$(LPAREN)$(RPAREN) to this function, it is possible
   * to pass %NULL if argv is not available or commandline handling is not
   * required.  Note that on Windows, argc and argv are ignored, and
   * g_win32_get_command_line$(LPAREN)$(RPAREN) is called internally $(LPAREN)for proper support
   * of Unicode commandline arguments$(RPAREN).
   * #GApplication will attempt to parse the commandline arguments.  You
   * can add commandline flags to the list of recognised options by way of
   * [Gio.Application.addMainOptionEntries].  After this, the
   * #GApplication::handle-local-options signal is emitted, from which the
   * application can inspect the values of its #GOptionEntrys.
   * #GApplication::handle-local-options is a good place to handle options
   * such as `--version`, where an immediate reply from the local process is
   * desired $(LPAREN)instead of communicating with an already-running instance$(RPAREN).
   * A #GApplication::handle-local-options handler can stop further processing
   * by returning a non-negative value, which then becomes the exit status of
   * the process.
   * What happens next depends on the flags: if
   * %G_APPLICATION_HANDLES_COMMAND_LINE was specified then the remaining
   * commandline arguments are sent to the primary instance, where a
   * #GApplication::command-line signal is emitted.  Otherwise, the
   * remaining commandline arguments are assumed to be a list of files.
   * If there are no files listed, the application is activated via the
   * #GApplication::activate signal.  If there are one or more files, and
   * %G_APPLICATION_HANDLES_OPEN was specified then the files are opened
   * via the #GApplication::open signal.
   * If you are interested in doing more complicated local handling of the
   * commandline then you should implement your own #GApplication subclass
   * and override local_command_line$(LPAREN)$(RPAREN). In this case, you most likely want
   * to return %TRUE from your local_command_line$(LPAREN)$(RPAREN) implementation to
   * suppress the default handling. See
   * [gapplication-example-cmdline2.c][https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline2.c]
   * for an example.
   * If, after the above is done, the use count of the application is zero
   * then the exit status is returned immediately.  If the use count is
   * non-zero then the default main context is iterated until the use count
   * falls to zero, at which point 0 is returned.
   * If the %G_APPLICATION_IS_SERVICE flag is set, then the service will
   * run for as much as 10 seconds with a use count of zero while waiting
   * for the message that caused the activation to arrive.  After that,
   * if the use count falls to zero the application will exit immediately,
   * except in the case that [Gio.Application.setInactivityTimeout] is in
   * use.
   * This function sets the prgname $(LPAREN)[GLib.Global.setPrgname]$(RPAREN), if not already set,
   * to the basename of argv[0].
   * Much like [GLib.MainLoop.run], this function will acquire the main context
   * for the duration that the application is running.
   * Since 2.40, applications that are not explicitly flagged as services
   * or launchers $(LPAREN)ie: neither %G_APPLICATION_IS_SERVICE or
   * %G_APPLICATION_IS_LAUNCHER are given as flags$(RPAREN) will check $(LPAREN)from the
   * default handler for local_command_line$(RPAREN) if "--gapplication-service"
   * was given in the command line.  If this flag is present then normal
   * commandline processing is interrupted and the
   * %G_APPLICATION_IS_SERVICE flag is set.  This provides a "compromise"
   * solution whereby running an application directly from the commandline
   * will invoke it in the normal way $(LPAREN)which can be useful for debugging$(RPAREN)
   * while still allowing applications to be D-Bus activated in service
   * mode.  The D-Bus service file should invoke the executable with
   * "--gapplication-service" as the sole commandline argument.  This
   * approach is suitable for use by most graphical applications but
   * should not be used from applications like editors that need precise
   * control over when processes invoked via the commandline will exit and
   * what their exit status will be.
   * Params:
   *   argv = the argv from main$(LPAREN)$(RPAREN), or %NULL
   * Returns: the exit status
   */
  int run(string[] argv)
  {
    int _retval;
    int _argc;
    if (argv)
      _argc = cast(int)argv.length;

    char*[] _tmpargv;
    foreach (s; argv)
      _tmpargv ~= s.toCString(false);
    char** _argv = _tmpargv.ptr;
    _retval = g_application_run(cast(GApplication*)cPtr, _argc, _argv);
    return _retval;
  }

  /**
   * Sends a notification on behalf of application to the desktop shell.
   * There is no guarantee that the notification is displayed immediately,
   * or even at all.
   * Notifications may persist after the application exits. It will be
   * D-Bus-activated when the notification or one of its actions is
   * activated.
   * Modifying notification after this call has no effect. However, the
   * object can be reused for a later call to this function.
   * id may be any string that uniquely identifies the event for the
   * application. It does not need to be in any special format. For
   * example, "new-message" might be appropriate for a notification about
   * new messages.
   * If a previous notification was sent with the same id, it will be
   * replaced with notification and shown again as if it was a new
   * notification. This works even for notifications sent from a previous
   * execution of the application, as long as id is the same string.
   * id may be %NULL, but it is impossible to replace or withdraw
   * notifications without an id.
   * If notification is no longer relevant, it can be withdrawn with
   * [Gio.Application.withdrawNotification].
   * It is an error to call this function if application has no
   * application ID.
   * Params:
   *   id = id of the notification, or %NULL
   *   notification = the #GNotification to send
   */
  void sendNotification(string id, Notification notification)
  {
    const(char)* _id = id.toCString(false);
    g_application_send_notification(cast(GApplication*)cPtr, _id, notification ? cast(GNotification*)notification.cPtr(false) : null);
  }

  /**
   * This used to be how actions were associated with a #GApplication.
   * Now there is #GActionMap for that.
   * Params:
   *   actionGroup = a #GActionGroup, or %NULL

   * Deprecated: Use the #GActionMap interface instead.  Never ever
   *   mix use of this API with use of #GActionMap on the same application
   *   or things will go very badly wrong.  This function is known to
   *   introduce buggy behaviour $(LPAREN)ie: signals not emitted on changes to the
   *   action group$(RPAREN), so you should really use #GActionMap instead.
   */
  void setActionGroup(ActionGroup actionGroup)
  {
    g_application_set_action_group(cast(GApplication*)cPtr, actionGroup ? cast(GActionGroup*)(cast(ObjectG)actionGroup).cPtr(false) : null);
  }

  /**
   * Sets the unique identifier for application.
   * The application id can only be modified if application has not yet
   * been registered.
   * If non-%NULL, the application id must be valid.  See
   * [Gio.Application.idIsValid].
   * Params:
   *   applicationId = the identifier for application
   */
  void setApplicationId(string applicationId)
  {
    const(char)* _applicationId = applicationId.toCString(false);
    g_application_set_application_id(cast(GApplication*)cPtr, _applicationId);
  }

  /**
   * Sets or unsets the default application for the process, as returned
   * by [Gio.Application.getDefault].
   * This function does not take its own reference on application.  If
   * application is destroyed then the default application will revert
   * back to %NULL.
   */
  void setDefault()
  {
    g_application_set_default(cast(GApplication*)cPtr);
  }

  /**
   * Sets the flags for application.
   * The flags can only be modified if application has not yet been
   * registered.
   * See #GApplicationFlags.
   * Params:
   *   flags = the flags for application
   */
  void setFlags(ApplicationFlags flags)
  {
    g_application_set_flags(cast(GApplication*)cPtr, flags);
  }

  /**
   * Sets the current inactivity timeout for the application.
   * This is the amount of time $(LPAREN)in milliseconds$(RPAREN) after the last call to
   * [Gio.Application.release] before the application stops running.
   * This call has no side effects of its own.  The value set here is only
   * used for next time [Gio.Application.release] drops the use count to
   * zero.  Any timeouts currently in progress are not impacted.
   * Params:
   *   inactivityTimeout = the timeout, in milliseconds
   */
  void setInactivityTimeout(uint inactivityTimeout)
  {
    g_application_set_inactivity_timeout(cast(GApplication*)cPtr, inactivityTimeout);
  }

  /**
   * Adds a description to the application option context.
   * See [GLib.OptionContext.setDescription] for more information.
   * Params:
   *   description = a string to be shown in `--help` output
   *     after the list of options, or %NULL
   */
  void setOptionContextDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_application_set_option_context_description(cast(GApplication*)cPtr, _description);
  }

  /**
   * Sets the parameter string to be used by the commandline handling of application.
   * This function registers the argument to be passed to [GLib.OptionContext.new_]
   * when the internal #GOptionContext of application is created.
   * See [GLib.OptionContext.new_] for more information about parameter_string.
   * Params:
   *   parameterString = a string which is displayed
   *     in the first line of `--help` output, after the usage summary `programname [OPTION...]`.
   */
  void setOptionContextParameterString(string parameterString)
  {
    const(char)* _parameterString = parameterString.toCString(false);
    g_application_set_option_context_parameter_string(cast(GApplication*)cPtr, _parameterString);
  }

  /**
   * Adds a summary to the application option context.
   * See [GLib.OptionContext.setSummary] for more information.
   * Params:
   *   summary = a string to be shown in `--help` output
   *     before the list of options, or %NULL
   */
  void setOptionContextSummary(string summary)
  {
    const(char)* _summary = summary.toCString(false);
    g_application_set_option_context_summary(cast(GApplication*)cPtr, _summary);
  }

  /**
   * Sets $(LPAREN)or unsets$(RPAREN) the base resource path of application.
   * The path is used to automatically load various [application
   * resources][gresource] such as menu layouts and action descriptions.
   * The various types of resources will be found at fixed names relative
   * to the given base path.
   * By default, the resource base path is determined from the application
   * ID by prefixing '/' and replacing each '.' with '/'.  This is done at
   * the time that the #GApplication object is constructed.  Changes to
   * the application ID after that point will not have an impact on the
   * resource base path.
   * As an example, if the application has an ID of "org.example.app" then
   * the default resource base path will be "/org/example/app".  If this
   * is a #GtkApplication $(LPAREN)and you have not manually changed the path$(RPAREN)
   * then Gtk will then search for the menus of the application at
   * "/org/example/app/gtk/menus.ui".
   * See #GResource for more information about adding resources to your
   * application.
   * You can disable automatic resource loading functionality by setting
   * the path to %NULL.
   * Changing the resource base path once the application is running is
   * not recommended.  The point at which the resource path is consulted
   * for forming paths for various purposes is unspecified.  When writing
   * a sub-class of #GApplication you should either set the
   * #GApplication:resource-base-path property at construction time, or call
   * this function during the instance initialization. Alternatively, you
   * can call this function in the #GApplicationClass.startup virtual function,
   * before chaining up to the parent implementation.
   * Params:
   *   resourcePath = the resource path to use
   */
  void setResourceBasePath(string resourcePath)
  {
    const(char)* _resourcePath = resourcePath.toCString(false);
    g_application_set_resource_base_path(cast(GApplication*)cPtr, _resourcePath);
  }

  /**
   * Sets the version number of application. This will be used to implement
   * a `--version` command line argument
   * The application version can only be modified if application has not yet
   * been registered.
   * Params:
   *   version_ = the version of application
   */
  void setVersion(string version_)
  {
    const(char)* _version_ = version_.toCString(false);
    g_application_set_version(cast(GApplication*)cPtr, _version_);
  }

  /**
   * Destroys a binding between property and the busy state of
   * application that was previously created with
   * [Gio.Application.bindBusyProperty].
   * Params:
   *   object = a #GObject
   *   property = the name of a boolean property of object
   */
  void unbindBusyProperty(ObjectG object, string property)
  {
    const(char)* _property = property.toCString(false);
    g_application_unbind_busy_property(cast(GApplication*)cPtr, object ? cast(ObjectC*)object.cPtr(false) : null, _property);
  }

  /**
   * Decreases the busy count of application.
   * When the busy count reaches zero, the new state will be propagated
   * to other processes.
   * This function must only be called to cancel the effect of a previous
   * call to [Gio.Application.markBusy].
   */
  void unmarkBusy()
  {
    g_application_unmark_busy(cast(GApplication*)cPtr);
  }

  /**
   * Withdraws a notification that was sent with
   * [Gio.Application.sendNotification].
   * This call does nothing if a notification with id doesn't exist or
   * the notification was never sent.
   * This function works even for notifications sent in previous
   * executions of this application, as long id is the same as it was for
   * the sent notification.
   * Note that notifications are dismissed when the user clicks on one
   * of the buttons in a notification or triggers its default action, so
   * there is no need to explicitly withdraw the notification in that case.
   * Params:
   *   id = id of a previously sent notification
   */
  void withdrawNotification(string id)
  {
    const(char)* _id = id.toCString(false);
    g_application_withdraw_notification(cast(GApplication*)cPtr, _id);
  }

  /**
   * The ::activate signal is emitted on the primary instance when an
   * activation occurs. See [Gio.Application.activate].
   *   application = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Application application);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }

  /**
   * The ::command-line signal is emitted on the primary instance when
   * a commandline is not handled locally. See [Gio.Application.run] and
   * the #GApplicationCommandLine documentation for more information.
   * Params
   *   commandLine = a #GApplicationCommandLine representing the
   *     passed commandline
   *   application = the instance the signal is connected to
   * Returns: An integer that is set as the exit status for the calling
   *   process. See [Gio.ApplicationCommandLine.setExitStatus].
   */
  alias CommandLineCallback = int delegate(ApplicationCommandLine commandLine, Application application);

  /**
   * Connect to CommandLine signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCommandLine(CommandLineCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("command-line", closure, after);
  }

  /**
   * The ::handle-local-options signal is emitted on the local instance
   * after the parsing of the commandline options has occurred.
   * You can add options to be recognised during commandline option
   * parsing using [Gio.Application.addMainOptionEntries] and
   * [Gio.Application.addOptionGroup].
   * Signal handlers can inspect options $(LPAREN)along with values pointed to
   * from the arg_data of an installed #GOptionEntrys$(RPAREN) in order to
   * decide to perform certain actions, including direct local handling
   * $(LPAREN)which may be useful for options like --version$(RPAREN).
   * In the event that the application is marked
   * %G_APPLICATION_HANDLES_COMMAND_LINE the "normal processing" will
   * send the options dictionary to the primary instance where it can be
   * read with [Gio.ApplicationCommandLine.getOptionsDict].  The signal
   * handler can modify the dictionary before returning, and the
   * modified dictionary will be sent.
   * In the event that %G_APPLICATION_HANDLES_COMMAND_LINE is not set,
   * "normal processing" will treat the remaining uncollected command
   * line arguments as filenames or URIs.  If there are no arguments,
   * the application is activated by [Gio.Application.activate].  One or
   * more arguments results in a call to [Gio.Application.open].
   * If you want to handle the local commandline arguments for yourself
   * by converting them to calls to [Gio.Application.open] or
   * [Gio.ActionGroup.activateAction] then you must be sure to register
   * the application first.  You should probably not call
   * [Gio.Application.activate] for yourself, however: just return -1 and
   * allow the default handler to do it for you.  This will ensure that
   * the `--gapplication-service` switch works properly $(LPAREN)i.e. no activation
   * in that case$(RPAREN).
   * Note that this signal is emitted from the default implementation of
   * local_command_line$(LPAREN)$(RPAREN).  If you override that function and don't
   * chain up then this signal will never be emitted.
   * You can override local_command_line$(LPAREN)$(RPAREN) if you need more powerful
   * capabilities than what is provided here, but this should not
   * normally be required.
   * Params
   *   options = the options dictionary
   *   application = the instance the signal is connected to
   * Returns: an exit code. If you have handled your options and want
   *   to exit the process, return a non-negative option, 0 for success,
   *   and a positive value for failure. To continue, return -1 to let
   *   the default option processing continue.
   */
  alias HandleLocalOptionsCallback = int delegate(VariantDict options, Application application);

  /**
   * Connect to HandleLocalOptions signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectHandleLocalOptions(HandleLocalOptionsCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("handle-local-options", closure, after);
  }

  /**
   * The ::name-lost signal is emitted only on the registered primary instance
   * when a new instance has taken over. This can only happen if the application
   * is using the %G_APPLICATION_ALLOW_REPLACEMENT flag.
   * The default handler for this signal calls [Gio.Application.quit].
   *   application = the instance the signal is connected to
   * Returns: %TRUE if the signal has been handled
   */
  alias NameLostCallback = bool delegate(Application application);

  /**
   * Connect to NameLost signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNameLost(NameLostCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("name-lost", closure, after);
  }

  /**
   * The ::open signal is emitted on the primary instance when there are
   * files to open. See [Gio.Application.open] for more information.
   * Params
   *   files = an array of #GFiles
   *   hint = a hint provided by the calling instance
   *   application = the instance the signal is connected to
   */
  alias OpenCallback = void delegate(File[] files, string hint, Application application);

  /**
   * Connect to Open signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectOpen(OpenCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      auto files = getVal!(GFile**)(&_paramVals[1]);
      File[] _files;
      auto nFiles = getVal!int(&_paramVals[2]);
      auto hint = getVal!string(&_paramVals[3]);
      foreach (i; 0 .. nFiles)
        _files ~= ObjectG.getDObject!File(files[i], false);
      _dgClosure.dlg(_files, hint, application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("open", closure, after);
  }

  /**
   * The ::shutdown signal is emitted only on the registered primary instance
   * immediately after the main loop terminates.
   *   application = the instance the signal is connected to
   */
  alias ShutdownCallback = void delegate(Application application);

  /**
   * Connect to Shutdown signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectShutdown(ShutdownCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("shutdown", closure, after);
  }

  /**
   * The ::startup signal is emitted on the primary instance immediately
   * after registration. See [Gio.Application.register].
   *   application = the instance the signal is connected to
   */
  alias StartupCallback = void delegate(Application application);

  /**
   * Connect to Startup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStartup(StartupCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("startup", closure, after);
  }
}
