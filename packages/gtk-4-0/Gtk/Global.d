module Gtk.Global;

import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.Types;
import GObject.Value;
import Gdk.ContentProvider;
import Gdk.Display;
import Gdk.Texture;
import Gdk.Types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Expression;
import Gtk.PageSetup;
import Gtk.PrintSettings;
import Gtk.Printer;
import Gtk.StyleContext;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.Widget;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.Layout;
import Pango.PgLanguage;
import cairo.Context;


/**
 * Gets the modifier mask.
 * The modifier mask determines which modifiers are considered significant
 * for keyboard accelerators. This includes all keyboard modifiers except
 * for %GDK_LOCK_MASK.
 * Returns: the modifier mask for accelerators
 */
ModifierType acceleratorGetDefaultModMask()
{
  GdkModifierType _cretval;
  _cretval = gtk_accelerator_get_default_mod_mask();
  ModifierType _retval = cast(ModifierType)_cretval;
  return _retval;
}

/**
 * Converts an accelerator keyval and modifier mask into a string
 * which can be used to represent the accelerator to the user.
 * Params:
 *   acceleratorKey = accelerator keyval
 *   acceleratorMods = accelerator modifier mask
 * Returns: a newly-allocated string representing the accelerator
 */
string acceleratorGetLabel(uint acceleratorKey, ModifierType acceleratorMods)
{
  char* _cretval;
  _cretval = gtk_accelerator_get_label(acceleratorKey, acceleratorMods);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Converts an accelerator keyval and modifier mask
 * into a string that can be displayed to the user.
 * The string may be translated.
 * This function is similar to funcGtk.accelerator_get_label,
 * but handling keycodes. This is only useful for system-level
 * components, applications should use funcGtk.accelerator_get_label
 * instead.
 * Params:
 *   display = a `GdkDisplay` or %NULL to use the default display
 *   acceleratorKey = accelerator keyval
 *   keycode = accelerator keycode
 *   acceleratorMods = accelerator modifier mask
 * Returns: a newly-allocated string representing the accelerator
 */
string acceleratorGetLabelWithKeycode(Display display, uint acceleratorKey, uint keycode, ModifierType acceleratorMods)
{
  char* _cretval;
  _cretval = gtk_accelerator_get_label_with_keycode(display ? cast(GdkDisplay*)display.cPtr(false) : null, acceleratorKey, keycode, acceleratorMods);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Converts an accelerator keyval and modifier mask into a string
 * parseable by [Gtk.Global.acceleratorParse].
 * For example, if you pass in %GDK_KEY_q and %GDK_CONTROL_MASK,
 * this function returns `<Control>q`.
 * If you need to display accelerators in the user interface,
 * see funcGtk.accelerator_get_label.
 * Params:
 *   acceleratorKey = accelerator keyval
 *   acceleratorMods = accelerator modifier mask
 * Returns: a newly-allocated accelerator name
 */
string acceleratorName(uint acceleratorKey, ModifierType acceleratorMods)
{
  char* _cretval;
  _cretval = gtk_accelerator_name(acceleratorKey, acceleratorMods);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Converts an accelerator keyval and modifier mask
 * into a string parseable by [Gtk.Global.acceleratorParseWithKeycode].
 * This is similar to funcGtk.accelerator_name but handling keycodes.
 * This is only useful for system-level components, applications
 * should use funcGtk.accelerator_name instead.
 * Params:
 *   display = a `GdkDisplay` or %NULL to use the default display
 *   acceleratorKey = accelerator keyval
 *   keycode = accelerator keycode
 *   acceleratorMods = accelerator modifier mask
 * Returns: a newly allocated accelerator name.
 */
string acceleratorNameWithKeycode(Display display, uint acceleratorKey, uint keycode, ModifierType acceleratorMods)
{
  char* _cretval;
  _cretval = gtk_accelerator_name_with_keycode(display ? cast(GdkDisplay*)display.cPtr(false) : null, acceleratorKey, keycode, acceleratorMods);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Parses a string representing an accelerator.
 * The format looks like “`<Control>a`” or “`<Shift><Alt>F1`”.
 * The parser is fairly liberal and allows lower or upper case, and also
 * abbreviations such as “`<Ctl>`” and “`<Ctrl>`”.
 * Key names are parsed using funcGdk.keyval_from_name. For character keys
 * the name is not the symbol, but the lowercase name, e.g. one would use
 * “`<Ctrl>minus`” instead of “`<Ctrl>-`”.
 * Modifiers are enclosed in angular brackets `<>`, and match the
 * [Gdk] mask:
 * - `<Shift>` for `GDK_SHIFT_MASK`
 * - `<Ctrl>` for `GDK_CONTROL_MASK`
 * - `<Alt>` for `GDK_ALT_MASK`
 * - `<Meta>` for `GDK_META_MASK`
 * - `<Super>` for `GDK_SUPER_MASK`
 * - `<Hyper>` for `GDK_HYPER_MASK`
 * If the parse operation fails, accelerator_key and accelerator_mods will
 * be set to 0 $(LPAREN)zero$(RPAREN).
 * Params:
 *   accelerator = string representing an accelerator
 *   acceleratorKey = return location for accelerator keyval
 *   acceleratorMods = return location for accelerator
 *     modifier mask
 * Returns:
 */
bool acceleratorParse(string accelerator, out uint acceleratorKey, out ModifierType acceleratorMods)
{
  bool _retval;
  const(char)* _accelerator = accelerator.toCString(false);
  _retval = gtk_accelerator_parse(_accelerator, cast(uint*)&acceleratorKey, &acceleratorMods);
  return _retval;
}

/**
 * Determines whether a given keyval and modifier mask constitute
 * a valid keyboard accelerator.
 * For example, the %GDK_KEY_a keyval plus %GDK_CONTROL_MASK mark is valid,
 * and matches the “Ctrl+a” accelerator. But, you can't, for instance, use
 * the %GDK_KEY_Control_L keyval as an accelerator.
 * Params:
 *   keyval = a GDK keyval
 *   modifiers = modifier mask
 * Returns: %TRUE if the accelerator is valid
 */
bool acceleratorValid(uint keyval, ModifierType modifiers)
{
  bool _retval;
  _retval = gtk_accelerator_valid(keyval, modifiers);
  return _retval;
}

/**
 * Checks that the GTK library in use is compatible with the
 * given version.
 * Generally you would pass in the constants %GTK_MAJOR_VERSION,
 * %GTK_MINOR_VERSION, %GTK_MICRO_VERSION as the three arguments
 * to this function; that produces a check that the library in
 * use is compatible with the version of GTK the application or
 * module was compiled against.
 * Compatibility is defined by two things: first the version
 * of the running library is newer than the version
 * required_major.required_minor.required_micro. Second
 * the running library must be binary compatible with the
 * version required_major.required_minor.required_micro
 * $(LPAREN)same major version.$(RPAREN)
 * This function is primarily for GTK modules; the module
 * can call this function to check that it wasn’t loaded
 * into an incompatible version of GTK. However, such a
 * check isn’t completely reliable, since the module may be
 * linked against an old version of GTK and calling the
 * old version of [Gtk.Global.checkVersion], but still get loaded
 * into an application using a newer version of GTK.
 * Params:
 *   requiredMajor = the required major version
 *   requiredMinor = the required minor version
 *   requiredMicro = the required micro version
 * Returns: %NULL if the GTK library is compatible with the
 *   given version, or a string describing the version mismatch.
 *   The returned string is owned by GTK and should not be modified
 *   or freed.
 */
string checkVersion(uint requiredMajor, uint requiredMinor, uint requiredMicro)
{
  const(char)* _cretval;
  _cretval = gtk_check_version(requiredMajor, requiredMinor, requiredMicro);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

Quark cssParserErrorQuark()
{
  Quark _retval;
  _retval = gtk_css_parser_error_quark();
  return _retval;
}

Quark cssParserWarningQuark()
{
  Quark _retval;
  _retval = gtk_css_parser_warning_quark();
  return _retval;
}

/**
 * Prevents funcGtk.init and funcGtk.init_check from automatically calling
 * `setlocale $(LPAREN)LC_ALL, ""$(RPAREN)`.
 * You would want to use this function if you wanted to set the locale for
 * your program to something other than the user’s locale, or if
 * you wanted to set different values for different locale categories.
 * Most programs should not need to call this function.
 */
void disableSetlocale()
{
  gtk_disable_setlocale();
}

/**
 * Distributes extra_space to child sizes by bringing smaller
 * children up to natural size first.
 * The remaining space will be added to the minimum_size member of the
 * `GtkRequestedSize` struct. If all sizes reach their natural size then
 * the remaining space is returned.
 * Params:
 *   extraSpace = Extra space to redistribute among children after subtracting
 *     minimum sizes and any child padding from the overall allocation
 *   sizes = An array of structs with a client pointer and a minimum/natural size
 *     in the orientation of the allocation.
 * Returns: The remainder of extra_space after redistributing space
 *   to sizes.
 */
int distributeNaturalAllocation(int extraSpace, RequestedSize[] sizes)
{
  int _retval;
  uint _nRequestedSizes;
  if (sizes)
    _nRequestedSizes = cast(uint)sizes.length;

  auto _sizes = cast(GtkRequestedSize*)sizes.ptr;
  _retval = gtk_distribute_natural_allocation(extraSpace, _nRequestedSizes, _sizes);
  return _retval;
}

/**
 * Calls a function for all `GtkPrinter`s.
 * If func returns %TRUE, the enumeration is stopped.
 * Params:
 *   func = a function to call for each printer
 *   wait = if %TRUE, wait in a recursive mainloop until
 *     all printers are enumerated; otherwise return early
 */
void enumeratePrinters(PrinterFunc func, bool wait)
{
  extern(C) bool _funcCallback(GtkPrinter* printer, void* data)
  {
    auto _dlg = cast(PrinterFunc*)data;

    bool _retval = (*_dlg)(printer ? ObjectG.getDObject!Printer(cast(void*)printer, false) : null);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  gtk_enumerate_printers(&_funcCallback, _func, &thawDelegate, wait);
}

/**
 * Returns the binary age as passed to `libtool`.
 * If `libtool` means nothing to you, don't worry about it.
 * Returns: the binary age of the GTK library
 */
uint getBinaryAge()
{
  uint _retval;
  _retval = gtk_get_binary_age();
  return _retval;
}

/**
 * Returns the GTK debug flags that are currently active.
 * This function is intended for GTK modules that want
 * to adjust their debug output based on GTK debug flags.
 * Returns: the GTK debug flags.
 */
DebugFlags getDebugFlags()
{
  GtkDebugFlags _cretval;
  _cretval = gtk_get_debug_flags();
  DebugFlags _retval = cast(DebugFlags)_cretval;
  return _retval;
}

/**
 * Returns the `PangoLanguage` for the default language
 * currently in effect.
 * Note that this can change over the life of an
 * application.
 * The default language is derived from the current
 * locale. It determines, for example, whether GTK uses
 * the right-to-left or left-to-right text direction.
 * This function is equivalent to [Pango.PgLanguage.getDefault].
 * See that function for details.
 * Returns: the default language
 */
PgLanguage getDefaultLanguage()
{
  PangoLanguage* _cretval;
  _cretval = gtk_get_default_language();
  auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Returns the interface age as passed to `libtool`.
 * If `libtool` means nothing to you, don't worry about it.
 * Returns: the interface age of the GTK library
 */
uint getInterfaceAge()
{
  uint _retval;
  _retval = gtk_get_interface_age();
  return _retval;
}

/**
 * Get the direction of the current locale. This is the expected
 * reading direction for text and UI.
 * This function depends on the current locale being set with
 * setlocale$(LPAREN)$(RPAREN) and will default to setting the %GTK_TEXT_DIR_LTR
 * direction otherwise. %GTK_TEXT_DIR_NONE will never be returned.
 * GTK sets the default text direction according to the locale
 * during [Gtk.Global.init_], and you should normally use
 * [Gtk.Widget.getDirection] or [Gtk.Widget.getDefaultDirection]
 * to obtain the current direction.
 * This function is only needed rare cases when the locale is
 * changed after GTK has already been initialized. In this case,
 * you can use it to update the default text direction as follows:
 * |[<!-- language\="C" -->
 * #include <locale.h>
 * static void
 * update_locale $(LPAREN)const char *new_locale$(RPAREN)
 * {
 * setlocale $(LPAREN)LC_ALL, new_locale$(RPAREN);
 * gtk_widget_set_default_direction $(LPAREN)gtk_get_locale_direction $(LPAREN)$(RPAREN)$(RPAREN);
 * }
 * ]|
 * Returns: the direction of the current locale
 */
TextDirection getLocaleDirection()
{
  GtkTextDirection _cretval;
  _cretval = gtk_get_locale_direction();
  TextDirection _retval = cast(TextDirection)_cretval;
  return _retval;
}

/**
 * Returns the major version number of the GTK library.
 * For example, in GTK version 3.1.5 this is 3.
 * This function is in the library, so it represents the GTK library
 * your code is running against. Contrast with the %GTK_MAJOR_VERSION
 * macro, which represents the major version of the GTK headers you
 * have included when compiling your code.
 * Returns: the major version number of the GTK library
 */
uint getMajorVersion()
{
  uint _retval;
  _retval = gtk_get_major_version();
  return _retval;
}

/**
 * Returns the micro version number of the GTK library.
 * For example, in GTK version 3.1.5 this is 5.
 * This function is in the library, so it represents the GTK library
 * your code is are running against. Contrast with the
 * %GTK_MICRO_VERSION macro, which represents the micro version of the
 * GTK headers you have included when compiling your code.
 * Returns: the micro version number of the GTK library
 */
uint getMicroVersion()
{
  uint _retval;
  _retval = gtk_get_micro_version();
  return _retval;
}

/**
 * Returns the minor version number of the GTK library.
 * For example, in GTK version 3.1.5 this is 1.
 * This function is in the library, so it represents the GTK library
 * your code is are running against. Contrast with the
 * %GTK_MINOR_VERSION macro, which represents the minor version of the
 * GTK headers you have included when compiling your code.
 * Returns: the minor version number of the GTK library
 */
uint getMinorVersion()
{
  uint _retval;
  _retval = gtk_get_minor_version();
  return _retval;
}

/**
 * Converts a color from HSV space to RGB.
 * Input values must be in the [0.0, 1.0] range;
 * output values will be in the same range.
 * Params:
 *   h = Hue
 *   s = Saturation
 *   v = Value
 *   r = Return value for the red component
 *   g = Return value for the green component
 *   b = Return value for the blue component
 */
void hsvToRgb(float h, float s, float v, out float r, out float g, out float b)
{
  gtk_hsv_to_rgb(h, s, v, cast(float*)&r, cast(float*)&g, cast(float*)&b);
}

/**
 * Call this function before using any other GTK functions in your GUI
 * applications. It will initialize everything needed to operate the
 * toolkit.
 * If you are using `GtkApplication`, you usually don't have to call this
 * function; the `GApplication::startup` handler does it for you. Though,
 * if you are using GApplication methods that will be invoked before `startup`,
 * such as `local_command_line`, you may need to initialize stuff explicitly.
 * This function will terminate your program if it was unable to
 * initialize the windowing system for some reason. If you want
 * your program to fall back to a textual interface, call
 * funcGtk.init_check instead.
 * GTK calls `signal $(LPAREN)SIGPIPE, SIG_IGN$(RPAREN)` during initialization, to ignore
 * SIGPIPE signals, since these are almost never wanted in graphical
 * applications. If you do need to handle SIGPIPE for some reason, reset
 * the handler after [Gtk.Global.init_], but notice that other libraries $(LPAREN)e.g.
 * libdbus or gvfs$(RPAREN) might do similar things.
 */
void init_()
{
  gtk_init();
}

/**
 * This function does the same work as [Gtk.Global.init_] with only a single
 * change: It does not terminate the program if the windowing system
 * can’t be initialized. Instead it returns %FALSE on failure.
 * This way the application can fall back to some other means of
 * communication with the user - for example a curses or command line
 * interface.
 * Returns: %TRUE if the windowing system has been successfully
 *   initialized, %FALSE otherwise
 */
bool initCheck()
{
  bool _retval;
  _retval = gtk_init_check();
  return _retval;
}

/**
 * Use this function to check if GTK has been initialized.
 * See funcGtk.init.
 * Returns: the initialization status
 */
bool isInitialized()
{
  bool _retval;
  _retval = gtk_is_initialized();
  return _retval;
}

/**
 * Creates a new `GParamSpec` instance for a property holding a `GtkExpression`.
 * See `[GObject.ParamSpec.internal]` for details on the property strings.
 * Params:
 *   name = canonical name of the property
 *   nick = a user-readable name for the property
 *   blurb = a user-readable description of the property
 *   flags = flags for the property
 * Returns: a newly created property specification
 */
ParamSpec paramSpecExpression(string name, string nick, string blurb, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = gtk_param_spec_expression(_name, _nick, _blurb, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Runs a page setup dialog, letting the user modify the values from
 * page_setup. If the user cancels the dialog, the returned `GtkPageSetup`
 * is identical to the passed in page_setup, otherwise it contains the
 * modifications done in the dialog.
 * Note that this function may use a recursive mainloop to show the page
 * setup dialog. See [Gtk.Global.printRunPageSetupDialogAsync] if this is
 * a problem.
 * Params:
 *   parent = transient parent
 *   pageSetup = an existing `GtkPageSetup`
 *   settings = a `GtkPrintSettings`
 * Returns: a new `GtkPageSetup`
 */
PageSetup printRunPageSetupDialog(Window parent, PageSetup pageSetup, PrintSettings settings)
{
  GtkPageSetup* _cretval;
  _cretval = gtk_print_run_page_setup_dialog(parent ? cast(GtkWindow*)parent.cPtr(false) : null, pageSetup ? cast(GtkPageSetup*)pageSetup.cPtr(false) : null, settings ? cast(GtkPrintSettings*)settings.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, true) : null;
  return _retval;
}

/**
 * Runs a page setup dialog, letting the user modify the values from page_setup.
 * In contrast to [Gtk.Global.printRunPageSetupDialog], this function  returns after
 * showing the page setup dialog on platforms that support this, and calls done_cb
 * from a signal handler for the ::response signal of the dialog.
 * Params:
 *   parent = transient parent
 *   pageSetup = an existing `GtkPageSetup`
 *   settings = a `GtkPrintSettings`
 *   doneCb = a function to call when the user saves
 *     the modified page setup
 */
void printRunPageSetupDialogAsync(Window parent, PageSetup pageSetup, PrintSettings settings, PageSetupDoneFunc doneCb)
{
  extern(C) void _doneCbCallback(GtkPageSetup* pageSetup, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(PageSetupDoneFunc*)data;

    (*_dlg)(pageSetup ? ObjectG.getDObject!PageSetup(cast(void*)pageSetup, false) : null);
  }

  auto _doneCb = freezeDelegate(cast(void*)&doneCb);
  gtk_print_run_page_setup_dialog_async(parent ? cast(GtkWindow*)parent.cPtr(false) : null, pageSetup ? cast(GtkPageSetup*)pageSetup.cPtr(false) : null, settings ? cast(GtkPrintSettings*)settings.cPtr(false) : null, &_doneCbCallback, _doneCb);
}

/**
 * Renders an activity indicator $(LPAREN)such as in `GtkSpinner`$(RPAREN).
 * The state %GTK_STATE_FLAG_CHECKED determines whether there is
 * activity going on.
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderActivity(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_activity(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders an arrow pointing to angle.
 * Typical arrow rendering at 0, 1⁄2 π;, π; and 3⁄2 π:
 * ![](arrows.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   angle = arrow angle from 0 to 2 * %G_PI, being 0 the arrow pointing to the north
 *   x = X origin of the render area
 *   y = Y origin of the render area
 *   size = square side for render area
 */
void renderArrow(StyleContext context, Context cr, double angle, double x, double y, double size)
{
  gtk_render_arrow(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, angle, x, y, size);
}

/**
 * Renders the background of an element.
 * Typical background rendering, showing the effect of
 * `background-image`, `border-width` and `border-radius`:
 * ![](background.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderBackground(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_background(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders a checkmark $(LPAREN)as in a `GtkCheckButton`$(RPAREN).
 * The %GTK_STATE_FLAG_CHECKED state determines whether the check is
 * on or off, and %GTK_STATE_FLAG_INCONSISTENT determines whether it
 * should be marked as undefined.
 * Typical checkmark rendering:
 * ![](checks.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderCheck(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_check(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders an expander $(LPAREN)as used in `GtkTreeView` and `GtkExpander`$(RPAREN) in the area
 * defined by x, y, width, height. The state %GTK_STATE_FLAG_CHECKED
 * determines whether the expander is collapsed or expanded.
 * Typical expander rendering:
 * ![](expanders.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderExpander(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_expander(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders a focus indicator on the rectangle determined by x, y, width, height.
 * Typical focus rendering:
 * ![](focus.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderFocus(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_focus(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders a frame around the rectangle defined by x, y, width, height.
 * Examples of frame rendering, showing the effect of `border-image`,
 * `border-color`, `border-width`, `border-radius` and junctions:
 * ![](frames.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderFrame(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_frame(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders a handle $(LPAREN)as in `GtkPaned` and `GtkWindow`’s resize grip$(RPAREN),
 * in the rectangle determined by x, y, width, height.
 * Handles rendered for the paned and grip classes:
 * ![](handles.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderHandle(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_handle(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Renders the icon in texture at the specified x and y coordinates.
 * This function will render the icon in texture at exactly its size,
 * regardless of scaling factors, which may not be appropriate when
 * drawing on displays with high pixel densities.
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   texture = a `GdkTexture` containing the icon to draw
 *   x = X position for the texture
 *   y = Y position for the texture
 */
void renderIcon(StyleContext context, Context cr, Texture texture, double x, double y)
{
  gtk_render_icon(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, texture ? cast(GdkTexture*)texture.cPtr(false) : null, x, y);
}

/**
 * Renders layout on the coordinates x, y
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin
 *   y = Y origin
 *   layout = the `PangoLayout` to render
 */
void renderLayout(StyleContext context, Context cr, double x, double y, Layout layout)
{
  gtk_render_layout(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
}

/**
 * Renders a line from $(LPAREN)x0, y0$(RPAREN) to $(LPAREN)x1, y1$(RPAREN).
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x0 = X coordinate for the origin of the line
 *   y0 = Y coordinate for the origin of the line
 *   x1 = X coordinate for the end of the line
 *   y1 = Y coordinate for the end of the line
 */
void renderLine(StyleContext context, Context cr, double x0, double y0, double x1, double y1)
{
  gtk_render_line(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x0, y0, x1, y1);
}

/**
 * Renders an option mark $(LPAREN)as in a radio button$(RPAREN), the %GTK_STATE_FLAG_CHECKED
 * state will determine whether the option is on or off, and
 * %GTK_STATE_FLAG_INCONSISTENT whether it should be marked as undefined.
 * Typical option mark rendering:
 * ![](options.png)
 * Params:
 *   context = a `GtkStyleContext`
 *   cr = a `cairo_t`
 *   x = X origin of the rectangle
 *   y = Y origin of the rectangle
 *   width = rectangle width
 *   height = rectangle height
 */
void renderOption(StyleContext context, Context cr, double x, double y, double width, double height)
{
  gtk_render_option(context ? cast(GtkStyleContext*)context.cPtr(false) : null, cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Converts a color from RGB space to HSV.
 * Input values must be in the [0.0, 1.0] range;
 * output values will be in the same range.
 * Params:
 *   r = Red
 *   g = Green
 *   b = Blue
 *   h = Return value for the hue component
 *   s = Return value for the saturation component
 *   v = Return value for the value component
 */
void rgbToHsv(float r, float g, float b, out float h, out float s, out float v)
{
  gtk_rgb_to_hsv(r, g, b, cast(float*)&h, cast(float*)&s, cast(float*)&v);
}

/**
 * Sets the GTK debug flags.
 * Params:
 *   flags = the debug flags to set
 */
void setDebugFlags(DebugFlags flags)
{
  gtk_set_debug_flags(flags);
}

/**
 * This function launches the default application for showing
 * a given uri, or shows an error dialog if that fails.
 * Params:
 *   parent = parent window
 *   uri = the uri to show
 *   timestamp = timestamp from the event that triggered this call, or %GDK_CURRENT_TIME

 * Deprecated: Use [Gtk.FileLauncher.launch] or
 *   [Gtk.UriLauncher.launch] instead
 */
void showUri(Window parent, string uri, uint timestamp)
{
  const(char)* _uri = uri.toCString(false);
  gtk_show_uri(parent ? cast(GtkWindow*)parent.cPtr(false) : null, _uri, timestamp);
}

/**
 * This function launches the default application for showing
 * a given uri.
 * The callback will be called when the launch is completed.
 * It should call [Gtk.Global.showUriFullFinish] to obtain the result.
 * This is the recommended call to be used as it passes information
 * necessary for sandbox helpers to parent their dialogs properly.
 * Params:
 *   parent = parent window
 *   uri = the uri to show
 *   timestamp = timestamp from the event that triggered this call, or %GDK_CURRENT_TIME
 *   cancellable = a `GCancellable` to cancel the launch
 *   callback = a callback to call when the action is complete

 * Deprecated: Use [Gtk.FileLauncher.launch] or
 *   [Gtk.UriLauncher.launch] instead
 */
void showUriFull(Window parent, string uri, uint timestamp, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  const(char)* _uri = uri.toCString(false);
  auto _callback = freezeDelegate(cast(void*)&callback);
  gtk_show_uri_full(parent ? cast(GtkWindow*)parent.cPtr(false) : null, _uri, timestamp, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
}

/**
 * Finishes the [Gtk.Global.showUri] call and returns the result
 * of the operation.
 * Params:
 *   parent = the `GtkWindow` passed to [Gtk.Global.showUri]
 *   result = `GAsyncResult` that was passed to callback
 * Returns: %TRUE if the URI was shown successfully.
 *   Otherwise, %FALSE is returned and error is set

 * Deprecated: Use [Gtk.FileLauncher.launchFinish] or
 *   [Gtk.UriLauncher.launchFinish] instead
 */
bool showUriFullFinish(Window parent, AsyncResult result)
{
  bool _retval;
  GError *_err;
  _retval = gtk_show_uri_full_finish(parent ? cast(GtkWindow*)parent.cPtr(false) : null, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

void testAccessibleAssertionMessageRole(string domain, string file, int line, string func, string expr, Accessible accessible, AccessibleRole expectedRole, AccessibleRole actualRole)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _expr = expr.toCString(false);
  gtk_test_accessible_assertion_message_role(_domain, _file, line, _func, _expr, accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(false) : null, expectedRole, actualRole);
}

/**
 * Checks whether the `GtkAccessible` has property set.
 * Params:
 *   accessible = a `GtkAccessible`
 *   property = a `GtkAccessibleProperty`
 * Returns: %TRUE if the property is set in the accessible
 */
bool testAccessibleHasProperty(Accessible accessible, AccessibleProperty property)
{
  bool _retval;
  _retval = gtk_test_accessible_has_property(accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(false) : null, property);
  return _retval;
}

/**
 * Checks whether the `GtkAccessible` has relation set.
 * Params:
 *   accessible = a `GtkAccessible`
 *   relation = a `GtkAccessibleRelation`
 * Returns: %TRUE if the relation is set in the accessible
 */
bool testAccessibleHasRelation(Accessible accessible, AccessibleRelation relation)
{
  bool _retval;
  _retval = gtk_test_accessible_has_relation(accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(false) : null, relation);
  return _retval;
}

/**
 * Checks whether the `GtkAccessible:accessible-role` of the accessible
 * is role.
 * Params:
 *   accessible = a `GtkAccessible`
 *   role = a `GtkAccessibleRole`
 * Returns: %TRUE if the role matches
 */
bool testAccessibleHasRole(Accessible accessible, AccessibleRole role)
{
  bool _retval;
  _retval = gtk_test_accessible_has_role(accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(false) : null, role);
  return _retval;
}

/**
 * Checks whether the `GtkAccessible` has state set.
 * Params:
 *   accessible = a `GtkAccessible`
 *   state = a `GtkAccessibleState`
 * Returns: %TRUE if the state is set in the accessible
 */
bool testAccessibleHasState(Accessible accessible, AccessibleState state)
{
  bool _retval;
  _retval = gtk_test_accessible_has_state(accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(false) : null, state);
  return _retval;
}

/**
 * Return the type ids that have been registered after
 * calling [Gtk.Global.testRegisterAllTypes].
 * Returns: 0-terminated array of type ids
 */
GType[] testListAllTypes()
{
  const(GType)* _cretval;
  uint _cretlength;
  _cretval = gtk_test_list_all_types(&_cretlength);
  GType[] _retval;

  if (_cretval)
  {
    _retval = cast(GType[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Force registration of all core GTK object types.
 * This allows to refer to any of those object types via
 * [GObject.Global.typeFromName] after calling this function.
 */
void testRegisterAllTypes()
{
  gtk_test_register_all_types();
}

/**
 * Enters the main loop and waits for widget to be “drawn”.
 * In this context that means it waits for the frame clock of
 * widget to have run a full styling, layout and drawing cycle.
 * This function is intended to be used for syncing with actions that
 * depend on widget relayouting or on interaction with the display
 * server.
 * Params:
 *   widget = the widget to wait for
 */
void testWidgetWaitForDraw(Widget widget)
{
  gtk_test_widget_wait_for_draw(widget ? cast(GtkWidget*)widget.cPtr(false) : null);
}

/**
 * Creates a content provider for dragging path from tree_model.
 * Params:
 *   treeModel = a `GtkTreeModel`
 *   path = a row in tree_model
 * Returns: a new `GdkContentProvider`

 * Deprecated: Use list models instead
 */
ContentProvider treeCreateRowDragContent(TreeModel treeModel, TreePath path)
{
  GdkContentProvider* _cretval;
  _cretval = gtk_tree_create_row_drag_content(treeModel ? cast(GtkTreeModel*)(cast(ObjectG)treeModel).cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, true) : null;
  return _retval;
}

/**
 * Obtains a tree_model and path from value of target type
 * %GTK_TYPE_TREE_ROW_DATA.
 * The returned path must be freed with [Gtk.TreePath.free].
 * Params:
 *   value = a `GValue`
 *   treeModel = a `GtkTreeModel`
 *   path = row in tree_model
 * Returns: %TRUE if selection_data had target type %GTK_TYPE_TREE_ROW_DATA
 *   is otherwise valid

 * Deprecated: Use list models instead
 */
bool treeGetRowDragData(Value value, out TreeModel treeModel, out TreePath path)
{
  bool _retval;
  GtkTreeModel* _treeModel;
  GtkTreePath* _path;
  _retval = gtk_tree_get_row_drag_data(value ? cast(GValue*)value.cPtr(false) : null, &_treeModel, &_path);
  treeModel = _treeModel ? ObjectG.getDObject!TreeModel(_treeModel, false) : null;
  path = new TreePath(cast(void*)_path, true);
  return _retval;
}

/**
 * Retrieves the `GtkExpression` stored inside the given `value`, and acquires
 * a reference to it.
 * Params:
 *   value = a `GValue` initialized with type `GTK_TYPE_EXPRESSION`
 * Returns: a `GtkExpression`
 */
Expression valueDupExpression(Value value)
{
  GtkExpression* _cretval;
  _cretval = gtk_value_dup_expression(value ? cast(GValue*)value.cPtr(false) : null);
  auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, true) : null;
  return _retval;
}

/**
 * Retrieves the `GtkExpression` stored inside the given `value`.
 * Params:
 *   value = a `GValue` initialized with type `GTK_TYPE_EXPRESSION`
 * Returns: a `GtkExpression`
 */
Expression valueGetExpression(Value value)
{
  GtkExpression* _cretval;
  _cretval = gtk_value_get_expression(value ? cast(GValue*)value.cPtr(false) : null);
  auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, false) : null;
  return _retval;
}

/**
 * Stores the given `GtkExpression` inside `value`.
 * The `GValue` will acquire a reference to the `expression`.
 * Params:
 *   value = a `GValue` initialized with type `GTK_TYPE_EXPRESSION`
 *   expression = a `GtkExpression`
 */
void valueSetExpression(Value value, Expression expression)
{
  gtk_value_set_expression(value ? cast(GValue*)value.cPtr(false) : null, expression ? cast(GtkExpression*)expression.cPtr(false) : null);
}

/**
 * Stores the given `GtkExpression` inside `value`.
 * This function transfers the ownership of the `expression` to the `GValue`.
 * Params:
 *   value = a `GValue` initialized with type `GTK_TYPE_EXPRESSION`
 *   expression = a `GtkExpression`
 */
void valueTakeExpression(Value value, Expression expression)
{
  gtk_value_take_expression(value ? cast(GValue*)value.cPtr(false) : null, expression ? cast(GtkExpression*)expression.cPtr(true) : null);
}
