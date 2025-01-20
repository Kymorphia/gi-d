module GLib.Types;

import GLib.ErrorG;
import GLib.Hook;
import GLib.HookList;
import GLib.IOChannel;
import GLib.LogField;
import GLib.MatchInfo;
import GLib.Node;
import GLib.OptionContext;
import GLib.OptionGroup;
import GLib.Scanner;
import GLib.SequenceIter;
import GLib.Source;
import GLib.String;
import GLib.TreeNode;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;


// Aliases
alias DateDay = GDateDay;
alias DateYear = GDateYear;
alias MainContextPusher = GMainContextPusher;
alias MutexLocker = GMutexLocker;
alias Pid = GPid;
alias Quark = GQuark;
alias RWLockReaderLocker = GRWLockReaderLocker;
alias RWLockWriterLocker = GRWLockWriterLocker;
alias RecMutexLocker = GRecMutexLocker;
alias RefString = GRefString;
alias Strv = GStrv;
alias Time = GTime;
alias TimeSpan = GTimeSpan;
alias IConv = GIConv;

// Enums
alias AsciiType = GAsciiType;
alias BookmarkFileError = GBookmarkFileError;
alias ChecksumType = GChecksumType;
alias ConvertError = GConvertError;
alias DateDMY = GDateDMY;
alias DateMonth = GDateMonth;
alias DateWeekday = GDateWeekday;
alias ErrorType = GErrorType;
alias FileError = GFileError;
alias FileSetContentsFlags = GFileSetContentsFlags;
alias FileTest = GFileTest;
alias FormatSizeFlags = GFormatSizeFlags;
alias HookFlagMask = GHookFlagMask;
alias IOChannelError = GIOChannelError;
alias IOCondition = GIOCondition;
alias IOError = GIOError;
alias IOFlags = GIOFlags;
alias IOStatus = GIOStatus;
alias KeyFileError = GKeyFileError;
alias KeyFileFlags = GKeyFileFlags;
alias LogLevelFlags = GLogLevelFlags;
alias LogWriterOutput = GLogWriterOutput;
alias MainContextFlags = GMainContextFlags;
alias MarkupCollectType = GMarkupCollectType;
alias MarkupError = GMarkupError;
alias MarkupParseFlags = GMarkupParseFlags;
alias NormalizeMode = GNormalizeMode;
alias NumberParserError = GNumberParserError;
alias OnceStatus = GOnceStatus;
alias OptionArg = GOptionArg;
alias OptionError = GOptionError;
alias OptionFlags = GOptionFlags;
alias RegexCompileFlags = GRegexCompileFlags;
alias RegexError = GRegexError;
alias RegexMatchFlags = GRegexMatchFlags;
alias SeekType = GSeekType;
alias ShellError = GShellError;
alias SliceConfig = GSliceConfig;
alias SpawnError = GSpawnError;
alias SpawnFlags = GSpawnFlags;
alias TestFileType = GTestFileType;
alias TestLogType = GTestLogType;
alias TestResult = GTestResult;
alias TestSubprocessFlags = GTestSubprocessFlags;
alias TestTrapFlags = GTestTrapFlags;
alias ThreadError = GThreadError;
alias ThreadPriority = GThreadPriority;
alias TimeType = GTimeType;
alias TokenType = GTokenType;
alias TraverseFlags = GTraverseFlags;
alias TraverseType = GTraverseType;
alias UnicodeBreakType = GUnicodeBreakType;
alias UnicodeScript = GUnicodeScript;
alias UnicodeType = GUnicodeType;
alias UnixPipeEnd = GUnixPipeEnd;
alias UriError = GUriError;
alias UriFlags = GUriFlags;
alias UriHideFlags = GUriHideFlags;
alias UriParamsFlags = GUriParamsFlags;
alias UserDirectory = GUserDirectory;
alias VariantClass = GVariantClass;
alias VariantParseError = GVariantParseError;

// Structs
alias Allocator = GAllocator*;
alias Data = GData*;
alias IOFuncs = GIOFuncs;
alias MarkupParser = GMarkupParser;
alias MemVTable = GMemVTable;
alias OptionEntry = GOptionEntry;
alias PollFD = GPollFD;
alias SourceCallbackFuncs = GSourceCallbackFuncs;
alias SourceFuncs = GSourceFuncs;
alias SourcePrivate = GSourcePrivate*;
alias StatBuf = GStatBuf*;
alias TestCase = GTestCase*;
alias TestConfig = GTestConfig;
alias ThreadFunctions = GThreadFunctions;
alias UnixPipe = GUnixPipe;

// Callbacks
alias CacheDestroyFunc = void delegate(void* value);
alias CacheDupFunc = void* delegate(void* value);
alias CacheNewFunc = void* delegate(void* key);
alias ChildWatchFunc = void delegate(Pid pid, int waitStatus);
alias ClearHandleFunc = void delegate(uint handleId);
alias CompareDataFunc = int delegate(const(void)* a, const(void)* b);
alias CompareFunc = int delegate(const(void)* a, const(void)* b);
alias CompletionFunc = string delegate(void* item);
alias CompletionStrncmpFunc = int delegate(string s1, string s2, size_t n);
alias CopyFunc = void* delegate(const(void)* src);
alias DataForeachFunc = void delegate(Quark keyId, void* data);
alias DestroyNotify = void delegate();
alias DuplicateFunc = void* delegate(void* data);
alias EqualFunc = bool delegate(const(void)* a, const(void)* b);
alias EqualFuncFull = bool delegate(const(void)* a, const(void)* b);
alias ErrorClearFunc = void delegate(ErrorG error);
alias ErrorCopyFunc = void delegate(ErrorG srcError, ErrorG destError);
alias ErrorInitFunc = void delegate(ErrorG error);
alias FreeFunc = void delegate();
alias Func = void delegate(void* data);
alias HFunc = void delegate(void* key, void* value);
alias HRFunc = bool delegate(void* key, void* value);
alias HashFunc = uint delegate(const(void)* key);
alias HookCheckFunc = bool delegate();
alias HookCheckMarshaller = bool delegate(Hook hook);
alias HookCompareFunc = int delegate(Hook newHook, Hook sibling);
alias HookFinalizeFunc = void delegate(HookList hookList, Hook hook);
alias HookFindFunc = bool delegate(Hook hook);
alias HookFunc = void delegate();
alias HookMarshaller = void delegate(Hook hook);
alias IOFunc = bool delegate(IOChannel source, IOCondition condition);
alias LogFunc = void delegate(string logDomain, LogLevelFlags logLevel, string message);
alias LogWriterFunc = LogWriterOutput delegate(LogLevelFlags logLevel, LogField[] fields);
alias NodeForeachFunc = void delegate(Node node);
alias NodeTraverseFunc = bool delegate(Node node);
alias OptionArgFunc = bool delegate(string optionName, string value);
alias OptionErrorFunc = void delegate(OptionContext context, OptionGroup group);
alias OptionParseFunc = bool delegate(OptionContext context, OptionGroup group);
alias PollFunc = int delegate(PollFD ufds, uint nfsd, int timeout);
alias PrintFunc = void delegate(string string_);
alias RegexEvalCallback = bool delegate(MatchInfo matchInfo, String result);
alias ScannerMsgFunc = void delegate(Scanner scanner, string message, bool error);
alias SequenceIterCompareFunc = int delegate(SequenceIter a, SequenceIter b);
alias SourceDisposeFunc = void delegate(Source source);
alias SourceDummyMarshal = void delegate();
alias SourceFunc = bool delegate();
alias SourceOnceFunc = void delegate();
alias SpawnChildSetupFunc = void delegate();
alias TestDataFunc = void delegate();
alias TestFixtureFunc = void delegate(void* fixture);
alias TestFunc = void delegate();
alias TestLogFatalFunc = bool delegate(string logDomain, LogLevelFlags logLevel, string message);
alias ThreadFunc = void* delegate();
alias TranslateFunc = string delegate(string str);
alias TraverseFunc = bool delegate(void* key, void* value);
alias TraverseNodeFunc = bool delegate(TreeNode node);
alias UnixFDSourceFunc = bool delegate(int fd, IOCondition condition);
alias VoidFunc = void delegate();

enum ALLOCATOR_LIST = 1;


enum ALLOCATOR_NODE = 3;


enum ALLOCATOR_SLIST = 2;


enum ALLOC_AND_FREE = 2;


enum ALLOC_ONLY = 1;


enum ANALYZER_ANALYZING = 1;


/**
 * A good size for a buffer to be passed into func@GLib.ascii_dtostr.
 * It is guaranteed to be enough for all output of that function
 * on systems with 64bit IEEE-compatible doubles.
 * The typical usage would be something like:
 * ```C
 * char buf[G_ASCII_DTOSTR_BUF_SIZE];
 * fprintf $(LPAREN)out, "value\=%s\n", g_ascii_dtostr $(LPAREN)buf, sizeof $(LPAREN)buf$(RPAREN), value$(RPAREN)$(RPAREN);
 * ```
 */
enum ASCII_DTOSTR_BUF_SIZE = 39;


/**
 * Evaluates to the initial reference count for `gatomicrefcount`.
 * This macro is useful for initializing `gatomicrefcount` fields inside
 * structures, for instance:
 * |[<!-- language\="C" -->
 * typedef struct {
 * gatomicrefcount ref_count;
 * char *name;
 * char *address;
 * } Person;
 * static const Person default_person \= {
 * .ref_count \= G_ATOMIC_REF_COUNT_INIT,
 * .name \= "Default name",
 * .address \= "Default address",
 * };
 * ]|
 */
enum ATOMIC_REF_COUNT_INIT = 1;


enum BIG_ENDIAN = 4321;


/**
 * The set of uppercase ASCII alphabet characters.
 * Used for specifying valid identifier characters
 * in #GScannerConfig.
 */
enum CSET_A_2_Z = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";


/**
 * The set of ASCII digits.
 * Used for specifying valid identifier characters
 * in #GScannerConfig.
 */
enum CSET_DIGITS = "0123456789";


/**
 * The set of lowercase ASCII alphabet characters.
 * Used for specifying valid identifier characters
 * in #GScannerConfig.
 */
enum CSET_a_2_z = "abcdefghijklmnopqrstuvwxyz";


enum C_STD_VERSION = 199000;


/**
 * A bitmask that restricts the possible flags passed to
 * [GLib.Global.datalistSetFlags]. Passing a flags value where
 * flags & ~G_DATALIST_FLAGS_MASK !\= 0 is an error.
 */
enum DATALIST_FLAGS_MASK = 3;


/**
 * Represents an invalid #GDateDay.
 */
enum DATE_BAD_DAY = 0;


/**
 * Represents an invalid Julian day number.
 */
enum DATE_BAD_JULIAN = 0;


/**
 * Represents an invalid year.
 */
enum DATE_BAD_YEAR = 0;


enum DIR_SEPARATOR = 47;


enum DIR_SEPARATOR_S = "/";


enum E = 2.718282;


enum GINT16_FORMAT = "hi";


enum GINT16_MODIFIER = "h";


enum GINT32_FORMAT = "i";


enum GINT32_MODIFIER = "";


enum GINT64_FORMAT = "li";


enum GINT64_MODIFIER = "l";


enum GINTPTR_FORMAT = "li";


enum GINTPTR_MODIFIER = "l";


/**
 * Expands to "" on all modern compilers, and to  __FUNCTION__ on gcc
 * version 2.x. Don't use it.

 * Deprecated: Use G_STRFUNC$(LPAREN)$(RPAREN) instead
 */
enum GNUC_FUNCTION = "";


/**
 * Expands to "" on all modern compilers, and to __PRETTY_FUNCTION__
 * on gcc version 2.x. Don't use it.

 * Deprecated: Use G_STRFUNC$(LPAREN)$(RPAREN) instead
 */
enum GNUC_PRETTY_FUNCTION = "";


enum GSIZE_FORMAT = "lu";


enum GSIZE_MODIFIER = "l";


enum GSSIZE_FORMAT = "li";


enum GSSIZE_MODIFIER = "l";


enum GUINT16_FORMAT = "hu";


enum GUINT32_FORMAT = "u";


enum GUINT64_FORMAT = "lu";


enum GUINTPTR_FORMAT = "lu";


enum HAVE_GINT64 = 1;


enum HAVE_GNUC_VARARGS = 1;


enum HAVE_GNUC_VISIBILITY = 1;


enum HAVE_GROWING_STACK = 0;


enum HAVE_ISO_VARARGS = 1;


/**
 * The position of the first bit which is not reserved for internal
 * use be the #GHook implementation, i.e.
 * `1 << G_HOOK_FLAG_USER_SHIFT` is the first
 * bit which can be used for application-defined flags.
 */
enum HOOK_FLAG_USER_SHIFT = 4;


enum IEEE754_DOUBLE_BIAS = 1023;


enum IEEE754_FLOAT_BIAS = 127;


/**
 * The name of the main group of a desktop entry file, as defined in the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec).
 * Consult the specification for more
 * details about the meanings of the keys below.
 */
enum KEY_FILE_DESKTOP_GROUP = "Desktop Entry";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string list
 * giving the available application actions.
 */
enum KEY_FILE_DESKTOP_KEY_ACTIONS = "Actions";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a list
 * of strings giving the categories in which the desktop entry
 * should be shown in a menu.
 */
enum KEY_FILE_DESKTOP_KEY_CATEGORIES = "Categories";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a localized
 * string giving the tooltip for the desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_COMMENT = "Comment";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a boolean
 * set to true if the application is D-Bus activatable.
 */
enum KEY_FILE_DESKTOP_KEY_DBUS_ACTIVATABLE = "DBusActivatable";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * giving the command line to execute. It is only valid for desktop
 * entries with the `Application` type.
 */
enum KEY_FILE_DESKTOP_KEY_EXEC = "Exec";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a localized
 * string giving the generic name of the desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_GENERIC_NAME = "GenericName";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a boolean
 * stating whether the desktop entry has been deleted by the user.
 */
enum KEY_FILE_DESKTOP_KEY_HIDDEN = "Hidden";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a localized
 * string giving the name of the icon to be displayed for the desktop
 * entry.
 */
enum KEY_FILE_DESKTOP_KEY_ICON = "Icon";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a list
 * of strings giving the MIME types supported by this desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_MIME_TYPE = "MimeType";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a localized
 * string giving the specific name of the desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_NAME = "Name";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a list of
 * strings identifying the environments that should not display the
 * desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN = "NotShowIn";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a boolean
 * stating whether the desktop entry should be shown in menus.
 */
enum KEY_FILE_DESKTOP_KEY_NO_DISPLAY = "NoDisplay";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a list of
 * strings identifying the environments that should display the
 * desktop entry.
 */
enum KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN = "OnlyShowIn";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * containing the working directory to run the program in. It is only
 * valid for desktop entries with the `Application` type.
 */
enum KEY_FILE_DESKTOP_KEY_PATH = "Path";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a boolean
 * stating whether the application supports the
 * [Startup Notification Protocol Specification](http://www.freedesktop.org/Standards/startup-notification-spec).
 */
enum KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY = "StartupNotify";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is string
 * identifying the WM class or name hint of a window that the application
 * will create, which can be used to emulate Startup Notification with
 * older applications.
 */
enum KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS = "StartupWMClass";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a boolean
 * stating whether the program should be run in a terminal window.
 * It is only valid for desktop entries with the `Application` type.
 */
enum KEY_FILE_DESKTOP_KEY_TERMINAL = "Terminal";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * giving the file name of a binary on disk used to determine if the
 * program is actually installed. It is only valid for desktop entries
 * with the `Application` type.
 */
enum KEY_FILE_DESKTOP_KEY_TRY_EXEC = "TryExec";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * giving the type of the desktop entry.
 * Usually %G_KEY_FILE_DESKTOP_TYPE_APPLICATION,
 * %G_KEY_FILE_DESKTOP_TYPE_LINK, or
 * %G_KEY_FILE_DESKTOP_TYPE_DIRECTORY.
 */
enum KEY_FILE_DESKTOP_KEY_TYPE = "Type";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * giving the URL to access. It is only valid for desktop entries
 * with the `Link` type.
 */
enum KEY_FILE_DESKTOP_KEY_URL = "URL";


/**
 * A key under %G_KEY_FILE_DESKTOP_GROUP, whose value is a string
 * giving the version of the Desktop Entry Specification used for
 * the desktop entry file.
 */
enum KEY_FILE_DESKTOP_KEY_VERSION = "Version";


/**
 * The value of the %G_KEY_FILE_DESKTOP_KEY_TYPE, key for desktop
 * entries representing applications.
 */
enum KEY_FILE_DESKTOP_TYPE_APPLICATION = "Application";


/**
 * The value of the %G_KEY_FILE_DESKTOP_KEY_TYPE, key for desktop
 * entries representing directories.
 */
enum KEY_FILE_DESKTOP_TYPE_DIRECTORY = "Directory";


/**
 * The value of the %G_KEY_FILE_DESKTOP_KEY_TYPE, key for desktop
 * entries representing links to documents.
 */
enum KEY_FILE_DESKTOP_TYPE_LINK = "Link";


enum LITTLE_ENDIAN = 1234;


enum LN10 = 2.302585;


enum LN2 = 0.693147;


enum LOG_2_BASE_10 = 0.301030;


/**
 * Defines the log domain. See [Log Domains](#log-domains).
 * Libraries should define this so that any messages
 * which they log can be differentiated from messages from other
 * libraries and application code. But be careful not to define
 * it in any public header files.
 * Log domains must be unique, and it is recommended that they are the
 * application or library name, optionally followed by a hyphen and a sub-domain
 * name. For example, `bloatpad` or `bloatpad-io`.
 * If undefined, it defaults to the default %NULL $(LPAREN)or `""`$(RPAREN) log domain; this is
 * not advisable, as it cannot be filtered against using the `G_MESSAGES_DEBUG`
 * environment variable.
 * For example, GTK uses this in its `Makefile.am`:
 * |[
 * AM_CPPFLAGS \= -DG_LOG_DOMAIN\=\"Gtk\"
 * ]|
 * Applications can choose to leave it as the default %NULL $(LPAREN)or `""`$(RPAREN)
 * domain. However, defining the domain offers the same advantages as
 * above.
 */
enum LOG_DOMAIN = 0;


/**
 * GLib log levels that are considered fatal by default.
 * This is not used if structured logging is enabled; see
 * [Using Structured Logging](logging.html#using-structured-logging).
 */
enum LOG_FATAL_MASK = 5;


/**
 * Log levels below `1<<G_LOG_LEVEL_USER_SHIFT` are used by GLib.
 * Higher bits can be used for user-defined log levels.
 */
enum LOG_LEVEL_USER_SHIFT = 8;


/**
 * The major version number of the GLib library.
 * Like #glib_major_version, but from the headers used at
 * application compile time, rather than from the library
 * linked against at application run time.
 */
enum MAJOR_VERSION = 2;


enum MAXINT16 = 32767;


enum MAXINT32 = 2147483647;


enum MAXINT64 = 9223372036854775807;


enum MAXINT8 = 127;


enum MAXUINT16 = 65535;


enum MAXUINT32 = 4294967295;


enum MAXUINT64 = 18446744073709551615;


enum MAXUINT8 = 255;


/**
 * The micro version number of the GLib library.
 * Like #gtk_micro_version, but from the headers used at
 * application compile time, rather than from the library
 * linked against at application run time.
 */
enum MICRO_VERSION = 0;


/**
 * The minimum value which can be held in a #gint16.
 */
enum MININT16 = -32768;


/**
 * The minimum value which can be held in a #gint32.
 */
enum MININT32 = -2147483648;


/**
 * The minimum value which can be held in a #gint64.
 */
enum MININT64 = -9223372036854775808;


/**
 * The minimum value which can be held in a #gint8.
 */
enum MININT8 = -128;


/**
 * The minor version number of the GLib library.
 * Like #gtk_minor_version, but from the headers used at
 * application compile time, rather than from the library
 * linked against at application run time.
 */
enum MINOR_VERSION = 80;


enum MODULE_SUFFIX = "so";


/**
 * If a long option in the main group has this name, it is not treated as a
 * regular option. Instead it collects all non-option arguments which would
 * otherwise be left in `argv`. The option must be of type
 * %G_OPTION_ARG_CALLBACK, %G_OPTION_ARG_STRING_ARRAY
 * or %G_OPTION_ARG_FILENAME_ARRAY.
 * Using %G_OPTION_REMAINING instead of simply scanning `argv`
 * for leftover arguments has the advantage that GOption takes care of
 * necessary encoding conversions for strings or filenames.
 */
enum OPTION_REMAINING = "";


enum PDP_ENDIAN = 3412;


enum PI = 3.141593;


/**
 * A format specifier that can be used in printf$(LPAREN)$(RPAREN)-style format strings
 * when printing a #GPid.
 */
enum PID_FORMAT = "i";


enum PI_2 = 1.570796;


enum PI_4 = 0.785398;


/**
 * A format specifier that can be used in printf$(LPAREN)$(RPAREN)-style format strings
 * when printing the @fd member of a #GPollFD.
 */
enum POLLFD_FORMAT = "%d";


/**
 * Use this for default priority event sources.
 * In GLib this priority is used when adding timeout functions
 * with [GLib.Global.timeoutAdd]. In GDK this priority is used for events
 * from the X server.
 */
enum PRIORITY_DEFAULT = 0;


/**
 * Use this for default priority idle functions.
 * In GLib this priority is used when adding idle functions with
 * [GLib.Global.idleAdd].
 */
enum PRIORITY_DEFAULT_IDLE = 200;


/**
 * Use this for high priority event sources.
 * It is not used within GLib or GTK.
 */
enum PRIORITY_HIGH = -100;


/**
 * Use this for high priority idle functions.
 * GTK uses %G_PRIORITY_HIGH_IDLE + 10 for resizing operations,
 * and %G_PRIORITY_HIGH_IDLE + 20 for redrawing operations. $(LPAREN)This is
 * done to ensure that any pending resizes are processed before any
 * pending redraws, so that widgets are not redrawn twice unnecessarily.$(RPAREN)
 */
enum PRIORITY_HIGH_IDLE = 100;


/**
 * Use this for very low priority background tasks.
 * It is not used within GLib or GTK.
 */
enum PRIORITY_LOW = 300;


/**
 * Evaluates to the initial reference count for `grefcount`.
 * This macro is useful for initializing `grefcount` fields inside
 * structures, for instance:
 * |[<!-- language\="C" -->
 * typedef struct {
 * grefcount ref_count;
 * char *name;
 * char *address;
 * } Person;
 * static const Person default_person \= {
 * .ref_count \= G_REF_COUNT_INIT,
 * .name \= "Default name",
 * .address \= "Default address",
 * };
 * ]|
 */
enum REF_COUNT_INIT = -1;


enum SEARCHPATH_SEPARATOR = 58;


enum SEARCHPATH_SEPARATOR_S = ":";


enum SIZEOF_LONG = 8;


enum SIZEOF_SIZE_T = 8;


enum SIZEOF_SSIZE_T = 8;


enum SIZEOF_VOID_P = 8;


/**
 * Use this macro as the return value of a #GSourceFunc to leave
 * the #GSource in the main loop.
 */
enum SOURCE_CONTINUE = true;


/**
 * Use this macro as the return value of a #GSourceFunc to remove
 * the #GSource from the main loop.
 */
enum SOURCE_REMOVE = false;


enum SQRT2 = 1.414214;


/**
 * The standard delimiters, used in func@GLib.strdelimit.
 */
enum STR_DELIMITERS = "_-|> <.";


enum SYSDEF_AF_INET = 2;


enum SYSDEF_AF_INET6 = 10;


enum SYSDEF_AF_UNIX = 1;


enum SYSDEF_MSG_DONTROUTE = 4;


enum SYSDEF_MSG_OOB = 1;


enum SYSDEF_MSG_PEEK = 2;


/**
 * Creates a unique temporary directory for each unit test and uses
 * g_set_user_dirs$(LPAREN)$(RPAREN) to set XDG directories to point into subdirectories of it
 * for the duration of the unit test. The directory tree is cleaned up after the
 * test finishes successfully. Note that this doesn’t take effect until
 * [GLib.Global.testRun] is called, so calls to (for example) g_get_user_home_dir$(LPAREN)$(RPAREN) will
 * return the system-wide value when made in a test program’s main$(LPAREN)$(RPAREN) function.
 * The following functions will return subdirectories of the temporary directory
 * when this option is used. The specific subdirectory paths in use are not
 * guaranteed to be stable API — always use a getter function to retrieve them.
 * - [GLib.Global.getHomeDir]
 * - [GLib.Global.getUserCacheDir]
 * - [GLib.Global.getSystemConfigDirs]
 * - [GLib.Global.getUserConfigDir]
 * - [GLib.Global.getSystemDataDirs]
 * - [GLib.Global.getUserDataDir]
 * - [GLib.Global.getUserStateDir]
 * - [GLib.Global.getUserRuntimeDir]
 * The subdirectories may not be created by the test harness; as with normal
 * calls to functions like [GLib.Global.getUserCacheDir], the caller must be prepared
 * to create the directory if it doesn’t exist.
 */
enum TEST_OPTION_ISOLATE_DIRS = "isolate_dirs";


/**
 * Evaluates to a time span of one day.
 */
enum TIME_SPAN_DAY = 86400000000;


/**
 * Evaluates to a time span of one hour.
 */
enum TIME_SPAN_HOUR = 3600000000;


/**
 * Evaluates to a time span of one millisecond.
 */
enum TIME_SPAN_MILLISECOND = 1000;


/**
 * Evaluates to a time span of one minute.
 */
enum TIME_SPAN_MINUTE = 60000000;


/**
 * Evaluates to a time span of one second.
 */
enum TIME_SPAN_SECOND = 1000000;


/**
 * The maximum length $(LPAREN)in codepoints$(RPAREN) of a compatibility or canonical
 * decomposition of a single Unicode character.
 * This is as defined by Unicode 6.1.
 */
enum UNICHAR_MAX_DECOMPOSITION_LENGTH = 18;


/**
 * Generic delimiters characters as defined in
 * [RFC 3986](https://tools.ietf.org/html/rfc3986). Includes `:/?#[]@`.
 */
enum URI_RESERVED_CHARS_GENERIC_DELIMITERS = ":/?#[]@";


/**
 * Subcomponent delimiter characters as defined in
 * [RFC 3986](https://tools.ietf.org/html/rfc3986). Includes `!\$&'$(LPAREN)$(RPAREN)*+,;\=`.
 */
enum URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS = "!$&'()*+,;=";


/**
 * Number of microseconds in one second $(LPAREN)1 million$(RPAREN).
 * This macro is provided for code readability.
 */
enum USEC_PER_SEC = 1000000;


enum VA_COPY_AS_ARRAY = 1;


/**
 * A macro that should be defined by the user prior to including
 * the glib.h header.
 * The definition should be one of the predefined GLib version
 * macros: %GLIB_VERSION_2_26, %GLIB_VERSION_2_28,...
 * This macro defines the earliest version of GLib that the package is
 * required to be able to compile against.
 * If the compiler is configured to warn about the use of deprecated
 * functions, then using functions that were deprecated in version
 * %GLIB_VERSION_MIN_REQUIRED or earlier will cause warnings $(LPAREN)but
 * using functions deprecated in later releases will not$(RPAREN).
 */
enum VERSION_MIN_REQUIRED = 2;


enum WIN32_MSG_HANDLE = 19981206;


enum macro__has_attribute___noreturn__ = 0;

