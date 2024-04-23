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
import GLib.c.types;
import Gid.Gid;


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
alias Type = GType;
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
alias TimeType = GTimeType;
alias TokenType = GTokenType;
alias TraverseFlags = GTraverseFlags;
alias TraverseType = GTraverseType;
alias UnicodeBreakType = GUnicodeBreakType;
alias UnicodeScript = GUnicodeScript;
alias UnicodeType = GUnicodeType;
alias UriError = GUriError;
alias UriFlags = GUriFlags;
alias UriHideFlags = GUriHideFlags;
alias UriParamsFlags = GUriParamsFlags;
alias UserDirectory = GUserDirectory;
alias VariantClass = GVariantClass;
alias VariantParseError = GVariantParseError;

// Structs
alias Data = GData;
alias IOFuncs = GIOFuncs;
alias MarkupParser = GMarkupParser;
alias MemVTable = GMemVTable;
alias PollFD = GPollFD;
alias SourceCallbackFuncs = GSourceCallbackFuncs;
alias SourceFuncs = GSourceFuncs;
alias SourcePrivate = GSourcePrivate;
alias StatBuf = GStatBuf;
alias TestConfig = GTestConfig;

// Callbacks
alias ChildWatchFunc = void delegate(Pid pid, int waitStatus);
alias ClearHandleFunc = void delegate(uint handleId);
alias CompareDataFunc = int delegate(const(void)* a, const(void)* b);
alias CompareFunc = int delegate(const(void)* a, const(void)* b);
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

enum ANALYZER_ANALYZING = 1;


/**
 * A good size for a buffer to be passed into g_ascii_dtostr().
 * It is guaranteed to be enough for all output of that function
 * on systems with 64bit IEEE-compatible doubles.
 *
 * The typical usage would be something like:
 * |[<!-- language="C" -->
 * char buf[G_ASCII_DTOSTR_BUF_SIZE];
 *
 * fprintf (out, "value=%s\n", g_ascii_dtostr (buf, sizeof (buf), value));
 * ]|
 */
enum ASCII_DTOSTR_BUF_SIZE = 39;


/**
 * Evaluates to the initial reference count for `gatomicrefcount`.
 *
 * This macro is useful for initializing `gatomicrefcount` fields inside
 * structures, for instance:
 *
 * |[<!-- language="C" -->
 * typedef struct {
 * gatomicrefcount ref_count;
 * char *name;
 * char *address;
 * } Person;
 *
 * static const Person default_person = {
 * .ref_count = G_ATOMIC_REF_COUNT_INIT,
 * .name = "Default name",
 * .address = "Default address",
 * };
 * ]|
 */
enum ATOMIC_REF_COUNT_INIT = 1;


/**
 * Specifies one of the possible types of byte order.
 * See %G_BYTE_ORDER.
 */
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


/**
 * The C standard version the code is compiling against, it's normally
 * defined with the same value of `__STDC_VERSION__` for C standard
 * compatible compilers, while it uses the lowest standard version
 * in pure MSVC, given that in such compiler the definition depends on
 * a compilation flag.
 *
 * This is granted to be undefined when compiling with a C++ compiler.
 *
 * See also: %G_C_STD_CHECK_VERSION and %G_CXX_STD_VERSION
 */
enum C_STD_VERSION = 199000;


/**
 * A bitmask that restricts the possible flags passed to
 * g_datalist_set_flags(). Passing a flags value where
 * flags & ~G_DATALIST_FLAGS_MASK != 0 is an error.
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


/**
 * The directory separator character.
 * This is '/' on UNIX machines and '\' under Windows.
 */
enum DIR_SEPARATOR = 47;


/**
 * The directory separator as a string.
 * This is "/" on UNIX machines and "\" under Windows.
 */
enum DIR_SEPARATOR_S = "/";


/**
 * The base of natural logarithms.
 */
enum E = 2.718282;


/**
 * This is the platform dependent conversion specifier for scanning and
 * printing values of type #gint16. It is a string literal, but doesn't
 * include the percent-sign, such that you can add precision and length
 * modifiers between percent-sign and conversion specifier.
 *
 * |[<!-- language="C" -->
 * gint16 in;
 * gint32 out;
 * sscanf ("42", "%" G_GINT16_FORMAT, &in)
 * out = in * 1000;
 * g_print ("%" G_GINT32_FORMAT, out);
 *
 * This is not necessarily the correct format for printing and scanning
 * `int16_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId16` and `SCNd16` should be used for `int16_t`.
 * ]|
 */
enum GINT16_FORMAT = "hi";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gint16 or #guint16. It
 * is a string literal, but doesn't include the percent-sign, such
 * that you can add precision and length modifiers between percent-sign
 * and conversion specifier and append a conversion specifier.
 *
 * The following example prints "0x7b";
 * |[<!-- language="C" -->
 * gint16 value = 123;
 * g_print ("%#" G_GINT16_MODIFIER "x", value);
 * ]|
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `int16_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId16` and `SCNd16` should be used for `int16_t`.
 */
enum GINT16_MODIFIER = "h";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #gint32. See also %G_GINT16_FORMAT.
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `int32_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId32` and `SCNd32` should be used for `int32_t`.
 */
enum GINT32_FORMAT = "i";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gint32 or #guint32. It
 * is a string literal. See also %G_GINT16_MODIFIER.
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `int32_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId32` and `SCNd32` should be used for `int32_t`.
 */
enum GINT32_MODIFIER = "";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #gint64. See also %G_GINT16_FORMAT.
 *
 * Some platforms do not support scanning and printing 64-bit integers,
 * even though the types are supported. On such platforms %G_GINT64_FORMAT
 * is not defined. Note that scanf() may not support 64-bit integers, even
 * if %G_GINT64_FORMAT is defined. Due to its weak error handling, scanf()
 * is not recommended for parsing anyway; consider using g_ascii_strtoull()
 * instead.
 *
 * This is not necessarily the correct format for printing and scanning
 * `int64_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId64` and `SCNd64` should be used for `int64_t`.
 */
enum GINT64_FORMAT = "li";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gint64 or #guint64.
 * It is a string literal.
 *
 * Some platforms do not support printing 64-bit integers, even
 * though the types are supported. On such platforms %G_GINT64_MODIFIER
 * is not defined.
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `int64_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRId64` and `SCNd64` should be used for `int64_t`.
 */
enum GINT64_MODIFIER = "l";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #gintptr.
 *
 * Note that this is not necessarily the correct format to scan or
 * print an `intptr_t`, even though the in-memory representation is the
 * same.
 * Standard C macros like `PRIdPTR` and `SCNdPTR` should be used for
 * `intptr_t`.
 */
enum GINTPTR_FORMAT = "li";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gintptr or #guintptr.
 * It is a string literal.
 *
 * Note that this is not necessarily the correct modifier to scan or
 * print an `intptr_t`, even though the in-memory representation is the
 * same.
 * Standard C macros like `PRIdPTR` and `SCNdPTR` should be used for
 * `intptr_t`.
 */
enum GINTPTR_MODIFIER = "l";


/**
 * Expands to "" on all modern compilers, and to  __FUNCTION__ on gcc
 * version 2.x. Don't use it.
 */
enum GNUC_FUNCTION = "";


/**
 * Expands to "" on all modern compilers, and to __PRETTY_FUNCTION__
 * on gcc version 2.x. Don't use it.
 */
enum GNUC_PRETTY_FUNCTION = "";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #gsize. See also %G_GINT16_FORMAT.
 *
 * Note that this is not necessarily the correct format to scan or
 * print a `size_t`, even though the in-memory representation is the
 * same. The standard C `"zu"` format should be used for `size_t`,
 * assuming a C99-compliant `printf` implementation is available.
 */
enum GSIZE_FORMAT = "lu";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gsize. It
 * is a string literal.
 *
 * Note that this is not necessarily the correct modifier to scan or
 * print a `size_t`, even though the in-memory representation is the
 * same. The Standard C `"z"` modifier should be used for `size_t`,
 * assuming a C99-compliant `printf` implementation is available.
 */
enum GSIZE_MODIFIER = "l";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #gssize. See also %G_GINT16_FORMAT.
 *
 * Note that this is not necessarily the correct format to scan or print
 * a POSIX `ssize_t` or a Windows `SSIZE_T`, even though the in-memory
 * representation is the same.
 * On POSIX platforms, the `"zd"` format should be used for `ssize_t`.
 */
enum GSSIZE_FORMAT = "li";


/**
 * The platform dependent length modifier for conversion specifiers
 * for scanning and printing values of type #gssize. It
 * is a string literal.
 *
 * Note that this is not necessarily the correct modifier to scan or print
 * a POSIX `ssize_t` or a Windows `SSIZE_T`, even though the in-memory
 * representation is the same.
 * On POSIX platforms, the `"z"` modifier should be used for `ssize_t`.
 */
enum GSSIZE_MODIFIER = "l";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #guint16. See also %G_GINT16_FORMAT
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `uint16_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRIu16` and `SCNu16` should be used for `uint16_t`.
 */
enum GUINT16_FORMAT = "hu";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #guint32. See also %G_GINT16_FORMAT.
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `uint32_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRIu32` and `SCNu32` should be used for `uint32_t`.
 */
enum GUINT32_FORMAT = "u";


/**
 * This is the platform dependent conversion specifier for scanning
 * and printing values of type #guint64. See also %G_GINT16_FORMAT.
 *
 * Some platforms do not support scanning and printing 64-bit integers,
 * even though the types are supported. On such platforms %G_GUINT64_FORMAT
 * is not defined.  Note that scanf() may not support 64-bit integers, even
 * if %G_GINT64_FORMAT is defined. Due to its weak error handling, scanf()
 * is not recommended for parsing anyway; consider using g_ascii_strtoull()
 * instead.
 *
 * This is not necessarily the correct modifier for printing and scanning
 * `uint64_t` values, even though the in-memory representation is the same.
 * Standard C macros like `PRIu64` and `SCNu64` should be used for `uint64_t`.
 */
enum GUINT64_FORMAT = "lu";


/**
 * This is the platform dependent conversion specifier
 * for scanning and printing values of type #guintptr.
 *
 * Note that this is not necessarily the correct format to scan or
 * print a `uintptr_t`, even though the in-memory representation is the
 * same.
 * Standard C macros like `PRIuPTR` and `SCNuPTR` should be used for
 * `uintptr_t`.
 */
enum GUINTPTR_FORMAT = "lu";


enum HAVE_GINT64 = 1;


enum HAVE_GNUC_VARARGS = 1;


/**
 * Defined to 1 if gcc-style visibility handling is supported.
 */
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


/**
 * The bias by which exponents in double-precision floats are offset.
 */
enum IEEE754_DOUBLE_BIAS = 1023;


/**
 * The bias by which exponents in single-precision floats are offset.
 */
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
 *
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
 *
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


/**
 * Specifies one of the possible types of byte order.
 * See %G_BYTE_ORDER.
 */
enum LITTLE_ENDIAN = 1234;


/**
 * The natural logarithm of 10.
 */
enum LN10 = 2.302585;


/**
 * The natural logarithm of 2.
 */
enum LN2 = 0.693147;


/**
 * Multiplying the base 2 exponent by this number yields the base 10 exponent.
 */
enum LOG_2_BASE_10 = 0.301030;


/**
 * Defines the log domain. See [Log Domains](#log-domains).
 *
 * Libraries should define this so that any messages
 * which they log can be differentiated from messages from other
 * libraries and application code. But be careful not to define
 * it in any public header files.
 *
 * Log domains must be unique, and it is recommended that they are the
 * application or library name, optionally followed by a hyphen and a sub-domain
 * name. For example, `bloatpad` or `bloatpad-io`.
 *
 * If undefined, it defaults to the default %NULL (or `""`) log domain; this is
 * not advisable, as it cannot be filtered against using the `G_MESSAGES_DEBUG`
 * environment variable.
 *
 * For example, GTK uses this in its `Makefile.am`:
 * |[
 * AM_CPPFLAGS = -DG_LOG_DOMAIN=\"Gtk\"
 * ]|
 *
 * Applications can choose to leave it as the default %NULL (or `""`)
 * domain. However, defining the domain offers the same advantages as
 * above.
 */
enum LOG_DOMAIN = 0;


/**
 * GLib log levels that are considered fatal by default.
 *
 * This is not used if structured logging is enabled; see
 * [Using Structured Logging][using-structured-logging].
 */
enum LOG_FATAL_MASK = 5;


/**
 * Log levels below 1<<G_LOG_LEVEL_USER_SHIFT are used by GLib.
 * Higher bits can be used for user-defined log levels.
 */
enum LOG_LEVEL_USER_SHIFT = 8;


/**
 * The major version number of the GLib library.
 *
 * Like #glib_major_version, but from the headers used at
 * application compile time, rather than from the library
 * linked against at application run time.
 */
enum MAJOR_VERSION = 2;


/**
 * The maximum value which can be held in a #gint16.
 *
 * This is the same as standard C `INT16_MAX`, which should be
 * preferred in new code.
 */
enum MAXINT16 = 32767;


/**
 * The maximum value which can be held in a #gint32.
 *
 * This is the same as standard C `INT32_MAX`, which should be
 * preferred in new code.
 */
enum MAXINT32 = 2147483647;


/**
 * The maximum value which can be held in a #gint64.
 */
enum MAXINT64 = 9223372036854775807;


/**
 * The maximum value which can be held in a #gint8.
 *
 * This is the same as standard C `INT8_MAX`, which should be
 * preferred in new code.
 */
enum MAXINT8 = 127;


/**
 * The maximum value which can be held in a #guint16.
 *
 * This is the same as standard C `UINT16_MAX`, which should be
 * preferred in new code.
 */
enum MAXUINT16 = 65535;


/**
 * The maximum value which can be held in a #guint32.
 *
 * This is the same as standard C `UINT32_MAX`, which should be
 * preferred in new code.
 */
enum MAXUINT32 = 4294967295;


/**
 * The maximum value which can be held in a #guint64.
 *
 * This is the same as standard C `UINT64_MAX`, which should be
 * preferred in new code.
 */
enum MAXUINT64 = 18446744073709551615;


/**
 * The maximum value which can be held in a #guint8.
 *
 * This is the same as standard C `UINT8_MAX`, which should be
 * preferred in new code.
 */
enum MAXUINT8 = 255;


/**
 * The micro version number of the GLib library.
 *
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
 *
 * Like #gtk_minor_version, but from the headers used at
 * application compile time, rather than from the library
 * linked against at application run time.
 */
enum MINOR_VERSION = 78;


enum MODULE_SUFFIX = "so";


/**
 * If a long option in the main group has this name, it is not treated as a
 * regular option. Instead it collects all non-option arguments which would
 * otherwise be left in `argv`. The option must be of type
 * %G_OPTION_ARG_CALLBACK, %G_OPTION_ARG_STRING_ARRAY
 * or %G_OPTION_ARG_FILENAME_ARRAY.
 *
 *
 * Using %G_OPTION_REMAINING instead of simply scanning `argv`
 * for leftover arguments has the advantage that GOption takes care of
 * necessary encoding conversions for strings or filenames.
 */
enum OPTION_REMAINING = "";


/**
 * Specifies one of the possible types of byte order
 * (currently unused). See %G_BYTE_ORDER.
 */
enum PDP_ENDIAN = 3412;


/**
 * The value of pi (ratio of circle's circumference to its diameter).
 */
enum PI = 3.141593;


/**
 * A format specifier that can be used in printf()-style format strings
 * when printing a #GPid.
 */
enum PID_FORMAT = "i";


/**
 * Pi divided by 2.
 */
enum PI_2 = 1.570796;


/**
 * Pi divided by 4.
 */
enum PI_4 = 0.785398;


/**
 * A format specifier that can be used in printf()-style format strings
 * when printing the @fd member of a #GPollFD.
 */
enum POLLFD_FORMAT = "%d";


/**
 * Use this for default priority event sources.
 *
 * In GLib this priority is used when adding timeout functions
 * with g_timeout_add(). In GDK this priority is used for events
 * from the X server.
 */
enum PRIORITY_DEFAULT = 0;


/**
 * Use this for default priority idle functions.
 *
 * In GLib this priority is used when adding idle functions with
 * g_idle_add().
 */
enum PRIORITY_DEFAULT_IDLE = 200;


/**
 * Use this for high priority event sources.
 *
 * It is not used within GLib or GTK.
 */
enum PRIORITY_HIGH = -100;


/**
 * Use this for high priority idle functions.
 *
 * GTK uses %G_PRIORITY_HIGH_IDLE + 10 for resizing operations,
 * and %G_PRIORITY_HIGH_IDLE + 20 for redrawing operations. (This is
 * done to ensure that any pending resizes are processed before any
 * pending redraws, so that widgets are not redrawn twice unnecessarily.)
 */
enum PRIORITY_HIGH_IDLE = 100;


/**
 * Use this for very low priority background tasks.
 *
 * It is not used within GLib or GTK.
 */
enum PRIORITY_LOW = 300;


/**
 * Evaluates to the initial reference count for `grefcount`.
 *
 * This macro is useful for initializing `grefcount` fields inside
 * structures, for instance:
 *
 * |[<!-- language="C" -->
 * typedef struct {
 * grefcount ref_count;
 * char *name;
 * char *address;
 * } Person;
 *
 * static const Person default_person = {
 * .ref_count = G_REF_COUNT_INIT,
 * .name = "Default name",
 * .address = "Default address",
 * };
 * ]|
 */
enum REF_COUNT_INIT = -1;


/**
 * The search path separator character.
 * This is ':' on UNIX machines and ';' under Windows.
 */
enum SEARCHPATH_SEPARATOR = 58;


/**
 * The search path separator as a string.
 * This is ":" on UNIX machines and ";" under Windows.
 */
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


/**
 * The square root of two.
 */
enum SQRT2 = 1.414214;


/**
 * The standard delimiters, used in g_strdelimit().
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
 * g_set_user_dirs() to set XDG directories to point into subdirectories of it
 * for the duration of the unit test. The directory tree is cleaned up after the
 * test finishes successfully. Note that this doesn’t take effect until
 * g_test_run() is called, so calls to (for example) g_get_user_home_dir() will
 * return the system-wide value when made in a test program’s main() function.
 *
 * The following functions will return subdirectories of the temporary directory
 * when this option is used. The specific subdirectory paths in use are not
 * guaranteed to be stable API — always use a getter function to retrieve them.
 *
 * - g_get_home_dir()
 * - g_get_user_cache_dir()
 * - g_get_system_config_dirs()
 * - g_get_user_config_dir()
 * - g_get_system_data_dirs()
 * - g_get_user_data_dir()
 * - g_get_user_state_dir()
 * - g_get_user_runtime_dir()
 *
 * The subdirectories may not be created by the test harness; as with normal
 * calls to functions like g_get_user_cache_dir(), the caller must be prepared
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
 * The maximum length (in codepoints) of a compatibility or canonical
 * decomposition of a single Unicode character.
 *
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
 * [RFC 3986](https://tools.ietf.org/html/rfc3986). Includes `!$&'()*+,;=`.
 */
enum URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS = "!$&'()*+,;=";


/**
 * Number of microseconds in one second (1 million).
 * This macro is provided for code readability.
 */
enum USEC_PER_SEC = 1000000;


enum VA_COPY_AS_ARRAY = 1;


/**
 * A macro that should be defined by the user prior to including
 * the glib.h header.
 * The definition should be one of the predefined GLib version
 * macros: %GLIB_VERSION_2_26, %GLIB_VERSION_2_28,...
 *
 * This macro defines the earliest version of GLib that the package is
 * required to be able to compile against.
 *
 * If the compiler is configured to warn about the use of deprecated
 * functions, then using functions that were deprecated in version
 * %GLIB_VERSION_MIN_REQUIRED or earlier will cause warnings (but
 * using functions deprecated in later releases will not).
 */
enum VERSION_MIN_REQUIRED = 2;


enum WIN32_MSG_HANDLE = 19981206;


enum macro__has_attribute___noreturn__ = 0;

