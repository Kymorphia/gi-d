module Gtk.StyleContext;

import GObject.ObjectG;
import Gdk.Display;
import Gdk.RGBA;
import Gid.gid;
import Gtk.Border;
import Gtk.StyleProvider;
import Gtk.StyleProviderT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkStyleContext` stores styling information affecting a widget.
 * In order to construct the final style information, `GtkStyleContext`
 * queries information from all attached `GtkStyleProviders`. Style
 * providers can be either attached explicitly to the context through
 * [Gtk.StyleContext.addProvider], or to the display through
 * [Gtk.StyleContext.addProviderForDisplay]. The resulting
 * style is a combination of all providers’ information in priority order.
 * For GTK widgets, any `GtkStyleContext` returned by
 * [Gtk.Widget.getStyleContext] will already have a `GdkDisplay`
 * and RTL/LTR information set. The style context will also be updated
 * automatically if any of these settings change on the widget.
 * ## Style Classes
 * Widgets can add style classes to their context, which can be used to associate
 * different styles by class. The documentation for individual widgets lists
 * which style classes it uses itself, and which style classes may be added by
 * applications to affect their appearance.
 * # Custom styling in UI libraries and applications
 * If you are developing a library with custom widgets that render differently
 * than standard components, you may need to add a `GtkStyleProvider` yourself
 * with the %GTK_STYLE_PROVIDER_PRIORITY_FALLBACK priority, either a
 * `GtkCssProvider` or a custom object implementing the `GtkStyleProvider`
 * interface. This way themes may still attempt to style your UI elements in
 * a different way if needed so.
 * If you are using custom styling on an applications, you probably want then
 * to make your style information prevail to the theme’s, so you must use
 * a `GtkStyleProvider` with the %GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
 * priority, keep in mind that the user settings in
 * `XDG_CONFIG_HOME/gtk-4.0/gtk.css` will
 * still take precedence over your changes, as it uses the
 * %GTK_STYLE_PROVIDER_PRIORITY_USER priority.

 * Deprecated: The relevant API has been moved to [Gtk.Widget]
 *   where applicable; otherwise, there is no replacement for querying the
 *   style machinery. Stylable UI elements should use widgets.
 */
class StyleContext : ObjectG
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
    return gtk_style_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds a global style provider to display, which will be used
   * in style construction for all `GtkStyleContexts` under display.
   * GTK uses this to make styling information from `GtkSettings`
   * available.
   * Note: If both priorities are the same, A `GtkStyleProvider`
   * added through [Gtk.StyleContext.addProvider] takes
   * precedence over another added through this function.
   * Params:
   *   display = a `GdkDisplay`
   *   provider = a `GtkStyleProvider`
   *   priority = the priority of the style provider. The lower
   *     it is, the earlier it will be used in the style construction.
   *     Typically this will be in the range between
   *     %GTK_STYLE_PROVIDER_PRIORITY_FALLBACK and
   *     %GTK_STYLE_PROVIDER_PRIORITY_USER
   */
  static void addProviderForDisplay(Display display, StyleProvider provider, uint priority)
  {
    gtk_style_context_add_provider_for_display(display ? cast(GdkDisplay*)display.cPtr(false) : null, provider ? cast(GtkStyleProvider*)(cast(ObjectG)provider).cPtr(false) : null, priority);
  }

  /**
   * Removes provider from the global style providers list in display.
   * Params:
   *   display = a `GdkDisplay`
   *   provider = a `GtkStyleProvider`
   */
  static void removeProviderForDisplay(Display display, StyleProvider provider)
  {
    gtk_style_context_remove_provider_for_display(display ? cast(GdkDisplay*)display.cPtr(false) : null, provider ? cast(GtkStyleProvider*)(cast(ObjectG)provider).cPtr(false) : null);
  }

  /**
   * Adds a style class to context, so later uses of the
   * style context will make use of this new class for styling.
   * In the CSS file format, a `GtkEntry` defining a “search”
   * class, would be matched by:
   * ```css
   * entry.search { ... }
   * ```
   * While any widget defining a “search” class would be
   * matched by:
   * ```css
   * .search { ... }
   * ```
   * Params:
   *   className = class name to use in styling

   * Deprecated: Use [Gtk.Widget.addCssClass] instead
   */
  void addClass(string className)
  {
    const(char)* _className = className.toCString(false);
    gtk_style_context_add_class(cast(GtkStyleContext*)cPtr, _className);
  }

  /**
   * Adds a style provider to context, to be used in style construction.
   * Note that a style provider added by this function only affects
   * the style of the widget to which context belongs. If you want
   * to affect the style of all widgets, use
   * [Gtk.StyleContext.addProviderForDisplay].
   * Note: If both priorities are the same, a `GtkStyleProvider`
   * added through this function takes precedence over another added
   * through [Gtk.StyleContext.addProviderForDisplay].
   * Params:
   *   provider = a `GtkStyleProvider`
   *   priority = the priority of the style provider. The lower
   *     it is, the earlier it will be used in the style construction.
   *     Typically this will be in the range between
   *     %GTK_STYLE_PROVIDER_PRIORITY_FALLBACK and
   *     %GTK_STYLE_PROVIDER_PRIORITY_USER

   * Deprecated: Use style classes instead
   */
  void addProvider(StyleProvider provider, uint priority)
  {
    gtk_style_context_add_provider(cast(GtkStyleContext*)cPtr, provider ? cast(GtkStyleProvider*)(cast(ObjectG)provider).cPtr(false) : null, priority);
  }

  /**
   * Gets the border for a given state as a `GtkBorder`.
   * Params:
   *   border = return value for the border settings

   * Deprecated: This api will be removed in GTK 5
   */
  void getBorder(out Border border)
  {
    GtkBorder _border;
    gtk_style_context_get_border(cast(GtkStyleContext*)cPtr, &_border);
    border = new Border(cast(void*)&_border, false);
  }

  /**
   * Gets the foreground color for a given state.
   * Params:
   *   color = return value for the foreground color

   * Deprecated: Use [Gtk.Widget.getColor] instead
   */
  void getColor(out RGBA color)
  {
    GdkRGBA _color;
    gtk_style_context_get_color(cast(GtkStyleContext*)cPtr, &_color);
    color = new RGBA(cast(void*)&_color, false);
  }

  /**
   * Returns the `GdkDisplay` to which context is attached.
   * Returns: a `GdkDisplay`.

   * Deprecated: Use [Gtk.Widget.getDisplay] instead
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gtk_style_context_get_display(cast(GtkStyleContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the margin for a given state as a `GtkBorder`.
   * Params:
   *   margin = return value for the margin settings

   * Deprecated: This api will be removed in GTK 5
   */
  void getMargin(out Border margin)
  {
    GtkBorder _margin;
    gtk_style_context_get_margin(cast(GtkStyleContext*)cPtr, &_margin);
    margin = new Border(cast(void*)&_margin, false);
  }

  /**
   * Gets the padding for a given state as a `GtkBorder`.
   * Params:
   *   padding = return value for the padding settings

   * Deprecated: This api will be removed in GTK 5
   */
  void getPadding(out Border padding)
  {
    GtkBorder _padding;
    gtk_style_context_get_padding(cast(GtkStyleContext*)cPtr, &_padding);
    padding = new Border(cast(void*)&_padding, false);
  }

  /**
   * Returns the scale used for assets.
   * Returns: the scale

   * Deprecated: Use [Gtk.Widget.getScaleFactor] instead
   */
  int getScale()
  {
    int _retval;
    _retval = gtk_style_context_get_scale(cast(GtkStyleContext*)cPtr);
    return _retval;
  }

  /**
   * Returns the state used for style matching.
   * This method should only be used to retrieve the `GtkStateFlags`
   * to pass to `GtkStyleContext` methods, like
   * [Gtk.StyleContext.getPadding].
   * If you need to retrieve the current state of a `GtkWidget`, use
   * [Gtk.Widget.getStateFlags].
   * Returns: the state flags

   * Deprecated: Use [Gtk.Widget.getStateFlags] instead
   */
  StateFlags getState()
  {
    GtkStateFlags _cretval;
    _cretval = gtk_style_context_get_state(cast(GtkStyleContext*)cPtr);
    StateFlags _retval = cast(StateFlags)_cretval;
    return _retval;
  }

  /**
   * Returns %TRUE if context currently has defined the
   * given class name.
   * Params:
   *   className = a class name
   * Returns: %TRUE if context has class_name defined

   * Deprecated: Use [Gtk.Widget.hasCssClass] instead
   */
  bool hasClass(string className)
  {
    bool _retval;
    const(char)* _className = className.toCString(false);
    _retval = gtk_style_context_has_class(cast(GtkStyleContext*)cPtr, _className);
    return _retval;
  }

  /**
   * Looks up and resolves a color name in the context color map.
   * Params:
   *   colorName = color name to lookup
   *   color = Return location for the looked up color
   * Returns: %TRUE if color_name was found and resolved, %FALSE otherwise

   * Deprecated: This api will be removed in GTK 5
   */
  bool lookupColor(string colorName, out RGBA color)
  {
    bool _retval;
    const(char)* _colorName = colorName.toCString(false);
    GdkRGBA _color;
    _retval = gtk_style_context_lookup_color(cast(GtkStyleContext*)cPtr, _colorName, &_color);
    color = new RGBA(cast(void*)&_color, false);
    return _retval;
  }

  /**
   * Removes class_name from context.
   * Params:
   *   className = class name to remove

   * Deprecated: Use [Gtk.Widget.removeCssClass] instead
   */
  void removeClass(string className)
  {
    const(char)* _className = className.toCString(false);
    gtk_style_context_remove_class(cast(GtkStyleContext*)cPtr, _className);
  }

  /**
   * Removes provider from the style providers list in context.
   * Params:
   *   provider = a `GtkStyleProvider`
   */
  void removeProvider(StyleProvider provider)
  {
    gtk_style_context_remove_provider(cast(GtkStyleContext*)cPtr, provider ? cast(GtkStyleProvider*)(cast(ObjectG)provider).cPtr(false) : null);
  }

  /**
   * Restores context state to a previous stage.
   * See [Gtk.StyleContext.save].

   * Deprecated: This API will be removed in GTK 5
   */
  void restore()
  {
    gtk_style_context_restore(cast(GtkStyleContext*)cPtr);
  }

  /**
   * Saves the context state.
   * This allows temporary modifications done through
   * [Gtk.StyleContext.addClass],
   * [Gtk.StyleContext.removeClass],
   * [Gtk.StyleContext.setState] to be quickly
   * reverted in one go through [Gtk.StyleContext.restore].
   * The matching call to [Gtk.StyleContext.restore]
   * must be done before GTK returns to the main loop.

   * Deprecated: This API will be removed in GTK 5
   */
  void save()
  {
    gtk_style_context_save(cast(GtkStyleContext*)cPtr);
  }

  /**
   * Attaches context to the given display.
   * The display is used to add style information from “global”
   * style providers, such as the display's `GtkSettings` instance.
   * If you are using a `GtkStyleContext` returned from
   * [Gtk.Widget.getStyleContext], you do not need to
   * call this yourself.
   * Params:
   *   display = a `GdkDisplay`

   * Deprecated: You should not use this api
   */
  void setDisplay(Display display)
  {
    gtk_style_context_set_display(cast(GtkStyleContext*)cPtr, display ? cast(GdkDisplay*)display.cPtr(false) : null);
  }

  /**
   * Sets the scale to use when getting image assets for the style.
   * Params:
   *   scale = scale

   * Deprecated: You should not use this api
   */
  void setScale(int scale)
  {
    gtk_style_context_set_scale(cast(GtkStyleContext*)cPtr, scale);
  }

  /**
   * Sets the state to be used for style matching.
   * Params:
   *   flags = state to represent

   * Deprecated: You should not use this api
   */
  void setState(StateFlags flags)
  {
    gtk_style_context_set_state(cast(GtkStyleContext*)cPtr, flags);
  }

  /**
   * Converts the style context into a string representation.
   * The string representation always includes information about
   * the name, state, id, visibility and style classes of the CSS
   * node that is backing context. Depending on the flags, more
   * information may be included.
   * This function is intended for testing and debugging of the
   * CSS implementation in GTK. There are no guarantees about
   * the format of the returned string, it may change.
   * Params:
   *   flags = Flags that determine what to print
   * Returns: a newly allocated string representing context

   * Deprecated: This api will be removed in GTK 5
   */
  string toString_(StyleContextPrintFlags flags)
  {
    char* _cretval;
    _cretval = gtk_style_context_to_string(cast(GtkStyleContext*)cPtr, flags);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
