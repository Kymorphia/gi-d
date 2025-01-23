module Gtk.Widget;

import GLib.List;
import GLib.VariantG;
import GObject.DClosure;
import GObject.InitiallyUnowned;
import GObject.ObjectG;
import GObject.Types;
import Gdk.Clipboard;
import Gdk.Cursor;
import Gdk.Display;
import Gdk.FrameClock;
import Gdk.RGBA;
import Gid.gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ListModel;
import Gio.ListModelT;
import Graphene.Matrix;
import Graphene.Point;
import Graphene.Rect;
import Gsk.Transform;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.EventController;
import Gtk.LayoutManager;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Requisition;
import Gtk.Root;
import Gtk.RootT;
import Gtk.Settings;
import Gtk.Snapshot;
import Gtk.StyleContext;
import Gtk.Tooltip;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.Context;
import Pango.FontMap;
import Pango.Layout;
import cairo.FontOptions;

/**
 * The base class for all widgets.
 * `GtkWidget` is the base class all widgets in GTK derive from. It manages the
 * widget lifecycle, layout, states and style.
 * ### Height-for-width Geometry Management
 * GTK uses a height-for-width $(LPAREN)and width-for-height$(RPAREN) geometry management
 * system. Height-for-width means that a widget can change how much
 * vertical space it needs, depending on the amount of horizontal space
 * that it is given $(LPAREN)and similar for width-for-height$(RPAREN). The most common
 * example is a label that reflows to fill up the available width, wraps
 * to fewer lines, and therefore needs less height.
 * Height-for-width geometry management is implemented in GTK by way
 * of two virtual methods:
 * - vfunc@Gtk.Widget.get_request_mode
 * - vfunc@Gtk.Widget.measure
 * There are some important things to keep in mind when implementing
 * height-for-width and when using it in widget implementations.
 * If you implement a direct `GtkWidget` subclass that supports
 * height-for-width or width-for-height geometry management for itself
 * or its child widgets, the vfunc@Gtk.Widget.get_request_mode virtual
 * function must be implemented as well and return the widget's preferred
 * request mode. The default implementation of this virtual function
 * returns %GTK_SIZE_REQUEST_CONSTANT_SIZE, which means that the widget will
 * only ever get -1 passed as the for_size value to its
 * vfunc@Gtk.Widget.measure implementation.
 * The geometry management system will query a widget hierarchy in
 * only one orientation at a time. When widgets are initially queried
 * for their minimum sizes it is generally done in two initial passes
 * in the [Gtk] chosen by the toplevel.
 * For example, when queried in the normal %GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH mode:
 * First, the default minimum and natural width for each widget
 * in the interface will be computed using [Gtk.Widget.measure] with an
 * orientation of %GTK_ORIENTATION_HORIZONTAL and a for_size of -1.
 * Because the preferred widths for each widget depend on the preferred
 * widths of their children, this information propagates up the hierarchy,
 * and finally a minimum and natural width is determined for the entire
 * toplevel. Next, the toplevel will use the minimum width to query for the
 * minimum height contextual to that width using [Gtk.Widget.measure] with an
 * orientation of %GTK_ORIENTATION_VERTICAL and a for_size of the just computed
 * width. This will also be a highly recursive operation. The minimum height
 * for the minimum width is normally used to set the minimum size constraint
 * on the toplevel.
 * After the toplevel window has initially requested its size in both
 * dimensions it can go on to allocate itself a reasonable size $(LPAREN)or a size
 * previously specified with [Gtk.Window.setDefaultSize]$(RPAREN). During the
 * recursive allocation process it’s important to note that request cycles
 * will be recursively executed while widgets allocate their children.
 * Each widget, once allocated a size, will go on to first share the
 * space in one orientation among its children and then request each child's
 * height for its target allocated width or its width for allocated height,
 * depending. In this way a `GtkWidget` will typically be requested its size
 * a number of times before actually being allocated a size. The size a
 * widget is finally allocated can of course differ from the size it has
 * requested. For this reason, `GtkWidget` caches a  small number of results
 * to avoid re-querying for the same sizes in one allocation cycle.
 * If a widget does move content around to intelligently use up the
 * allocated size then it must support the request in both
 * `GtkSizeRequestMode`s even if the widget in question only
 * trades sizes in a single orientation.
 * For instance, a [Gtk.Label] that does height-for-width word wrapping
 * will not expect to have vfunc@Gtk.Widget.measure with an orientation of
 * %GTK_ORIENTATION_VERTICAL called because that call is specific to a
 * width-for-height request. In this case the label must return the height
 * required for its own minimum possible width. By following this rule any
 * widget that handles height-for-width or width-for-height requests will
 * always be allocated at least enough space to fit its own content.
 * Here are some examples of how a %GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH widget
 * generally deals with width-for-height requests:
 * ```c
 * static void
 * foo_widget_measure $(LPAREN)GtkWidget      *widget,
 * GtkOrientation  orientation,
 * int             for_size,
 * int            *minimum_size,
 * int            *natural_size,
 * int            *minimum_baseline,
 * int            *natural_baseline$(RPAREN)
 * {
 * if $(LPAREN)orientation \=\= GTK_ORIENTATION_HORIZONTAL$(RPAREN)
 * {
 * // Calculate minimum and natural width
 * }
 * else // VERTICAL
 * {
 * if $(LPAREN)i_am_in_height_for_width_mode$(RPAREN)
 * {
 * int min_width, dummy;
 * // First, get the minimum width of our widget
 * GTK_WIDGET_GET_CLASS $(LPAREN)widget$(RPAREN)->measure $(LPAREN)widget, GTK_ORIENTATION_HORIZONTAL, -1,
 * &min_width, &dummy, &dummy, &dummy$(RPAREN);
 * // Now use the minimum width to retrieve the minimum and natural height to display
 * // that width.
 * GTK_WIDGET_GET_CLASS $(LPAREN)widget$(RPAREN)->measure $(LPAREN)widget, GTK_ORIENTATION_VERTICAL, min_width,
 * minimum_size, natural_size, &dummy, &dummy$(RPAREN);
 * }
 * else
 * {
 * // ... some widgets do both.
 * }
 * }
 * }
 * ```
 * Often a widget needs to get its own request during size request or
 * allocation. For example, when computing height it may need to also
 * compute width. Or when deciding how to use an allocation, the widget
 * may need to know its natural size. In these cases, the widget should
 * be careful to call its virtual methods directly, like in the code
 * example above.
 * It will not work to use the wrapper function [Gtk.Widget.measure]
 * inside your own vfunc@Gtk.Widget.size_allocate implementation.
 * These return a request adjusted by [Gtk.SizeGroup], the widget's
 * align and expand flags, as well as its CSS style.
 * If a widget used the wrappers inside its virtual method implementations,
 * then the adjustments $(LPAREN)such as widget margins$(RPAREN) would be applied
 * twice. GTK therefore does not allow this and will warn if you try
 * to do it.
 * Of course if you are getting the size request for another widget, such
 * as a child widget, you must use [Gtk.Widget.measure]; otherwise, you
 * would not properly consider widget margins, [Gtk.SizeGroup], and
 * so forth.
 * GTK also supports baseline vertical alignment of widgets. This
 * means that widgets are positioned such that the typographical baseline of
 * widgets in the same row are aligned. This happens if a widget supports
 * baselines, has a vertical alignment using baselines, and is inside
 * a widget that supports baselines and has a natural “row” that it aligns to
 * the baseline, or a baseline assigned to it by the grandparent.
 * Baseline alignment support for a widget is also done by the
 * vfunc@Gtk.Widget.measure virtual function. It allows you to report
 * both a minimum and natural size.
 * If a widget ends up baseline aligned it will be allocated all the space in
 * the parent as if it was %GTK_ALIGN_FILL, but the selected baseline can be
 * found via [Gtk.Widget.getBaseline]. If the baseline has a
 * value other than -1 you need to align the widget such that the baseline
 * appears at the position.
 * ### GtkWidget as GtkBuildable
 * The `GtkWidget` implementation of the `GtkBuildable` interface
 * supports various custom elements to specify additional aspects of widgets
 * that are not directly expressed as properties.
 * If the widget uses a [Gtk.LayoutManager], `GtkWidget` supports
 * a custom `<layout>` element, used to define layout properties:
 * ```xml
 * <object class\="GtkGrid" id\="my_grid">
 * <child>
 * <object class\="GtkLabel" id\="label1">
 * <property name\="label">Description</property>
 * <layout>
 * <property name\="column">0</property>
 * <property name\="row">0</property>
 * <property name\="row-span">1</property>
 * <property name\="column-span">1</property>
 * </layout>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkEntry" id\="description_entry">
 * <layout>
 * <property name\="column">1</property>
 * <property name\="row">0</property>
 * <property name\="row-span">1</property>
 * <property name\="column-span">1</property>
 * </layout>
 * </object>
 * </child>
 * </object>
 * ```
 * `GtkWidget` allows style information such as style classes to
 * be associated with widgets, using the custom `<style>` element:
 * ```xml
 * <object class\="GtkButton" id\="button1">
 * <style>
 * <class name\="my-special-button-class"/>
 * <class name\="dark-button"/>
 * </style>
 * </object>
 * ```
 * `GtkWidget` allows defining accessibility information, such as properties,
 * relations, and states, using the custom `<accessibility>` element:
 * ```xml
 * <object class\="GtkButton" id\="button1">
 * <accessibility>
 * <property name\="label">Download</property>
 * <relation name\="labelled-by">label1</relation>
 * </accessibility>
 * </object>
 * ```
 * ### Building composite widgets from template XML
 * `GtkWidget `exposes some facilities to automate the procedure
 * of creating composite widgets using "templates".
 * To create composite widgets with `GtkBuilder` XML, one must associate
 * the interface description with the widget class at class initialization
 * time using [Gtk.WidgetClass.setTemplate].
 * The interface description semantics expected in composite template descriptions
 * is slightly different from regular [Gtk.Builder] XML.
 * Unlike regular interface descriptions, [Gtk.WidgetClass.setTemplate]
 * will expect a `<template>` tag as a direct child of the toplevel
 * `<interface>` tag. The `<template>` tag must specify the “class” attribute
 * which must be the type name of the widget. Optionally, the “parent”
 * attribute may be specified to specify the direct parent type of the widget
 * type; this is ignored by `GtkBuilder` but can be used by UI design tools to
 * introspect what kind of properties and internal children exist for a given
 * type when the actual type does not exist.
 * The XML which is contained inside the `<template>` tag behaves as if it were
 * added to the `<object>` tag defining the widget itself. You may set properties
 * on a widget by inserting `<property>` tags into the `<template>` tag, and also
 * add `<child>` tags to add children and extend a widget in the normal way you
 * would with `<object>` tags.
 * Additionally, `<object>` tags can also be added before and after the initial
 * `<template>` tag in the normal way, allowing one to define auxiliary objects
 * which might be referenced by other widgets declared as children of the
 * `<template>` tag.
 * Since, unlike the `<object>` tag, the `<template>` tag does not contain an
 * “id” attribute, if you need to refer to the instance of the object itself that
 * the template will create, simply refer to the template class name in an
 * applicable element content.
 * Here is an example of a template definition, which includes an example of
 * this in the `<signal>` tag:
 * ```xml
 * <interface>
 * <template class\="FooWidget" parent\="GtkBox">
 * <property name\="orientation">horizontal</property>
 * <property name\="spacing">4</property>
 * <child>
 * <object class\="GtkButton" id\="hello_button">
 * <property name\="label">Hello World</property>
 * <signal name\="clicked" handler\="hello_button_clicked" object\="FooWidget" swapped\="yes"/>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkButton" id\="goodbye_button">
 * <property name\="label">Goodbye World</property>
 * </object>
 * </child>
 * </template>
 * </interface>
 * ```
 * Typically, you'll place the template fragment into a file that is
 * bundled with your project, using `GResource`. In order to load the
 * template, you need to call [Gtk.WidgetClass.setTemplateFromResource]
 * from the class initialization of your `GtkWidget` type:
 * ```c
 * static void
 * foo_widget_class_init $(LPAREN)FooWidgetClass *klass$(RPAREN)
 * {
 * // ...
 * gtk_widget_class_set_template_from_resource $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN),
 * "/com/example/ui/foowidget.ui"$(RPAREN);
 * }
 * ```
 * You will also need to call [Gtk.Widget.initTemplate] from the
 * instance initialization function:
 * ```c
 * static void
 * foo_widget_init $(LPAREN)FooWidget *self$(RPAREN)
 * {
 * gtk_widget_init_template $(LPAREN)GTK_WIDGET $(LPAREN)self$(RPAREN)$(RPAREN);
 * // Initialize the rest of the widget...
 * }
 * ```
 * as well as calling [Gtk.Widget.disposeTemplate] from the dispose
 * function:
 * ```c
 * static void
 * foo_widget_dispose $(LPAREN)GObject *gobject$(RPAREN)
 * {
 * FooWidget *self \= FOO_WIDGET $(LPAREN)gobject$(RPAREN);
 * // Dispose objects for which you have a reference...
 * // Clear the template children for this widget type
 * gtk_widget_dispose_template $(LPAREN)GTK_WIDGET $(LPAREN)self$(RPAREN), FOO_TYPE_WIDGET$(RPAREN);
 * G_OBJECT_CLASS $(LPAREN)foo_widget_parent_class$(RPAREN)->dispose $(LPAREN)gobject$(RPAREN);
 * }
 * ```
 * You can access widgets defined in the template using the
 * [Gtk.Widget.getTemplateChild] function, but you will typically declare
 * a pointer in the instance private data structure of your type using the same
 * name as the widget in the template definition, and call
 * [Gtk.WidgetClass.bindTemplateChildFull] $(LPAREN)or one of its wrapper macros
 * func@Gtk.widget_class_bind_template_child and func@Gtk.widget_class_bind_template_child_private$(RPAREN)
 * with that name, e.g.
 * ```c
 * typedef struct {
 * GtkWidget *hello_button;
 * GtkWidget *goodbye_button;
 * } FooWidgetPrivate;
 * G_DEFINE_TYPE_WITH_PRIVATE $(LPAREN)FooWidget, foo_widget, GTK_TYPE_BOX$(RPAREN)
 * static void
 * foo_widget_dispose $(LPAREN)GObject *gobject$(RPAREN)
 * {
 * gtk_widget_dispose_template $(LPAREN)GTK_WIDGET $(LPAREN)gobject$(RPAREN), FOO_TYPE_WIDGET$(RPAREN);
 * G_OBJECT_CLASS $(LPAREN)foo_widget_parent_class$(RPAREN)->dispose $(LPAREN)gobject$(RPAREN);
 * }
 * static void
 * foo_widget_class_init $(LPAREN)FooWidgetClass *klass$(RPAREN)
 * {
 * // ...
 * G_OBJECT_CLASS $(LPAREN)klass$(RPAREN)->dispose \= foo_widget_dispose;
 * gtk_widget_class_set_template_from_resource $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN),
 * "/com/example/ui/foowidget.ui"$(RPAREN);
 * gtk_widget_class_bind_template_child_private $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN),
 * FooWidget, hello_button$(RPAREN);
 * gtk_widget_class_bind_template_child_private $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN),
 * FooWidget, goodbye_button$(RPAREN);
 * }
 * static void
 * foo_widget_init $(LPAREN)FooWidget *widget$(RPAREN)
 * {
 * gtk_widget_init_template $(LPAREN)GTK_WIDGET $(LPAREN)widget$(RPAREN)$(RPAREN);
 * }
 * ```
 * You can also use [Gtk.WidgetClass.bindTemplateCallbackFull] $(LPAREN)or
 * is wrapper macro func@Gtk.widget_class_bind_template_callback$(RPAREN) to connect
 * a signal callback defined in the template with a function visible in the
 * scope of the class, e.g.
 * ```c
 * // the signal handler has the instance and user data swapped
 * // because of the swapped\="yes" attribute in the template XML
 * static void
 * hello_button_clicked $(LPAREN)FooWidget *self,
 * GtkButton *button$(RPAREN)
 * {
 * g_print $(LPAREN)"Hello, world!\n"$(RPAREN);
 * }
 * static void
 * foo_widget_class_init $(LPAREN)FooWidgetClass *klass$(RPAREN)
 * {
 * // ...
 * gtk_widget_class_set_template_from_resource $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN),
 * "/com/example/ui/foowidget.ui"$(RPAREN);
 * gtk_widget_class_bind_template_callback $(LPAREN)GTK_WIDGET_CLASS $(LPAREN)klass$(RPAREN), hello_button_clicked$(RPAREN);
 * }
 * ```
 */
class Widget : InitiallyUnowned, Accessible, Buildable, ConstraintTarget
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
    return gtk_widget_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleT!();
  mixin BuildableT!();
  mixin ConstraintTargetT!();

  /**
   * Obtains the current default reading direction.
   * See [Gtk.Widget.setDefaultDirection].
   * Returns: the current default direction.
   */
  static TextDirection getDefaultDirection()
  {
    GtkTextDirection _cretval;
    _cretval = gtk_widget_get_default_direction();
    TextDirection _retval = cast(TextDirection)_cretval;
    return _retval;
  }

  /**
   * Sets the default reading direction for widgets.
   * See [Gtk.Widget.setDirection].
   * Params:
   *   dir = the new default direction. This cannot be %GTK_TEXT_DIR_NONE.
   */
  static void setDefaultDirection(TextDirection dir)
  {
    gtk_widget_set_default_direction(dir);
  }

  /**
   * Enable or disable an action installed with
   * [Gtk.WidgetClass.installAction].
   * Params:
   *   actionName = action name, such as "clipboard.paste"
   *   enabled = whether the action is now enabled
   */
  void actionSetEnabled(string actionName, bool enabled)
  {
    const(char)* _actionName = actionName.toCString(false);
    gtk_widget_action_set_enabled(cast(GtkWidget*)cPtr, _actionName, enabled);
  }

  /**
   * For widgets that can be “activated” $(LPAREN)buttons, menu items, etc.$(RPAREN),
   * this function activates them.
   * The activation will emit the signal set using
   * [Gtk.WidgetClass.setActivateSignal] during class initialization.
   * Activation is what happens when you press <kbd>Enter</kbd>
   * on a widget during key navigation.
   * If you wish to handle the activation keybinding yourself, it is
   * recommended to use [Gtk.WidgetClass.addShortcut] with an action
   * created with [Gtk.SignalAction.new_].
   * If widget isn't activatable, the function returns %FALSE.
   * Returns: %TRUE if the widget was activatable
   */
  bool activate()
  {
    bool _retval;
    _retval = gtk_widget_activate(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Looks up the action in the action groups associated with
   * widget and its ancestors, and activates it.
   * If the action is in an action group added with
   * [Gtk.Widget.insertActionGroup], the name is expected
   * to be prefixed with the prefix that was used when the group was
   * inserted.
   * The arguments must match the actions expected parameter type,
   * as returned by `[Gio.Action.getParameterType]`.
   * Params:
   *   name = the name of the action to activate
   *   args = parameters to use
   * Returns: %TRUE if the action was activated, %FALSE if the
   *   action does not exist.
   */
  bool activateAction(string name, VariantG args)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = gtk_widget_activate_action_variant(cast(GtkWidget*)cPtr, _name, args ? cast(VariantC*)args.cPtr(false) : null);
    return _retval;
  }

  /**
   * Activates the `default.activate` action from widget.
   */
  void activateDefault()
  {
    gtk_widget_activate_default(cast(GtkWidget*)cPtr);
  }

  /**
   * Adds controller to widget so that it will receive events.
   * You will usually want to call this function right after
   * creating any kind of [Gtk.EventController].
   * Params:
   *   controller = a `GtkEventController` that hasn't been
   *     added to a widget yet
   */
  void addController(EventController controller)
  {
    gtk_widget_add_controller(cast(GtkWidget*)cPtr, controller ? cast(GtkEventController*)controller.cPtr(true) : null);
  }

  /**
   * Adds a style class to widget.
   * After calling this function, the widget’s style will match
   * for css_class, according to CSS matching rules.
   * Use [Gtk.Widget.removeCssClass] to remove the
   * style again.
   * Params:
   *   cssClass = The style class to add to widget, without
   *     the leading '.' used for notation of style classes
   */
  void addCssClass(string cssClass)
  {
    const(char)* _cssClass = cssClass.toCString(false);
    gtk_widget_add_css_class(cast(GtkWidget*)cPtr, _cssClass);
  }

  /**
   * Adds a widget to the list of mnemonic labels for this widget.
   * See [Gtk.Widget.listMnemonicLabels]. Note the
   * list of mnemonic labels for the widget is cleared when the
   * widget is destroyed, so the caller must make sure to update
   * its internal state at this point as well.
   * Params:
   *   label = a `GtkWidget` that acts as a mnemonic label for widget
   */
  void addMnemonicLabel(Widget label)
  {
    gtk_widget_add_mnemonic_label(cast(GtkWidget*)cPtr, label ? cast(GtkWidget*)label.cPtr(false) : null);
  }

  /**
   * Queues an animation frame update and adds a callback to be called
   * before each frame.
   * Until the tick callback is removed, it will be called frequently
   * $(LPAREN)usually at the frame rate of the output device or as quickly as
   * the application can be repainted, whichever is slower$(RPAREN). For this
   * reason, is most suitable for handling graphics that change every
   * frame or every few frames. The tick callback does not automatically
   * imply a relayout or repaint. If you want a repaint or relayout, and
   * aren’t changing widget properties that would trigger that $(LPAREN)for example,
   * changing the text of a `GtkLabel`$(RPAREN), then you will have to call
   * [Gtk.Widget.queueResize] or [Gtk.Widget.queueDraw]
   * yourself.
   * [Gdk.FrameClock.getFrameTime] should generally be used
   * for timing continuous animations and
   * [Gdk.FrameTimings.getPredictedPresentationTime] if you are
   * trying to display isolated frames at particular times.
   * This is a more convenient alternative to connecting directly to the
   * [Gdk.FrameClock.update] signal of `GdkFrameClock`, since you
   * don't have to worry about when a `GdkFrameClock` is assigned to a widget.
   * Params:
   *   callback = function to call for updating animations
   * Returns: an id for the connection of this callback. Remove the callback
   *   by passing the id returned from this function to
   *   [Gtk.Widget.removeTickCallback]
   */
  uint addTickCallback(TickCallback callback)
  {
    extern(C) bool _callbackCallback(GtkWidget* widget, GdkFrameClock* frameClock, void* userData)
    {
      auto _dlg = cast(TickCallback*)userData;

      bool _retval = (*_dlg)(widget ? ObjectG.getDObject!Widget(cast(void*)widget, false) : null, frameClock ? ObjectG.getDObject!FrameClock(cast(void*)frameClock, false) : null);
      return _retval;
    }

    uint _retval;
    auto _callback = freezeDelegate(cast(void*)&callback);
    _retval = gtk_widget_add_tick_callback(cast(GtkWidget*)cPtr, &_callbackCallback, _callback, &thawDelegate);
    return _retval;
  }

  /**
   * This function is only used by `GtkWidget` subclasses, to
   * assign a size, position and $(LPAREN)optionally$(RPAREN) baseline to their
   * child widgets.
   * In this function, the allocation and baseline may be adjusted.
   * The given allocation will be forced to be bigger than the
   * widget's minimum size, as well as at least 0×0 in size.
   * For a version that does not take a transform, see
   * [Gtk.Widget.sizeAllocate].
   * Params:
   *   width = New width of widget
   *   height = New height of widget
   *   baseline = New baseline of widget, or -1
   *   transform = Transformation to be applied to widget
   */
  void allocate(int width, int height, int baseline, Transform transform)
  {
    gtk_widget_allocate(cast(GtkWidget*)cPtr, width, height, baseline, transform ? cast(GskTransform*)transform.cPtr(true) : null);
  }

  /**
   * Called by widgets as the user moves around the window using
   * keyboard shortcuts.
   * The direction argument indicates what kind of motion is taking place $(LPAREN)up,
   * down, left, right, tab forward, tab backward$(RPAREN).
   * This function calls the vfuncGtk.Widget.focus virtual function; widgets
   * can override the virtual function in order to implement appropriate focus
   * behavior.
   * The default `focus$(LPAREN)$(RPAREN)` virtual function for a widget should return `TRUE` if
   * moving in direction left the focus on a focusable location inside that
   * widget, and `FALSE` if moving in direction moved the focus outside the
   * widget. When returning `TRUE`, widgets normally call [Gtk.Widget.grabFocus]
   * to place the focus accordingly; when returning `FALSE`, they don’t modify
   * the current focus location.
   * This function is used by custom widget implementations; if you're
   * writing an app, you’d use [Gtk.Widget.grabFocus] to move
   * the focus to a particular widget.
   * Params:
   *   direction = direction of focus movement
   * Returns: %TRUE if focus ended up inside widget
   */
  bool childFocus(DirectionType direction)
  {
    bool _retval;
    _retval = gtk_widget_child_focus(cast(GtkWidget*)cPtr, direction);
    return _retval;
  }

  /**
   * Computes the bounds for widget in the coordinate space of target.
   * The bounds of widget are $(LPAREN)the bounding box of$(RPAREN) the region that it is
   * expected to draw in. See the [coordinate system](coordinates.html)
   * overview to learn more.
   * If the operation is successful, %TRUE is returned. If widget has no
   * bounds or the bounds cannot be expressed in target's coordinate space
   * $(LPAREN)for example if both widgets are in different windows$(RPAREN), %FALSE is
   * returned and bounds is set to the zero rectangle.
   * It is valid for widget and target to be the same widget.
   * Params:
   *   target = the `GtkWidget`
   *   outBounds = the rectangle taking the bounds
   * Returns: %TRUE if the bounds could be computed
   */
  bool computeBounds(Widget target, out Rect outBounds)
  {
    bool _retval;
    graphene_rect_t _outBounds;
    _retval = gtk_widget_compute_bounds(cast(GtkWidget*)cPtr, target ? cast(GtkWidget*)target.cPtr(false) : null, &_outBounds);
    outBounds = new Rect(cast(void*)&_outBounds, false);
    return _retval;
  }

  /**
   * Computes whether a container should give this widget
   * extra space when possible.
   * Containers should check this, rather than looking at
   * [Gtk.Widget.getHexpand] or [Gtk.Widget.getVexpand].
   * This function already checks whether the widget is visible, so
   * visibility does not need to be checked separately. Non-visible
   * widgets are not expanded.
   * The computed expand value uses either the expand setting explicitly
   * set on the widget itself, or, if none has been explicitly set,
   * the widget may expand if some of its children do.
   * Params:
   *   orientation = expand direction
   * Returns: whether widget tree rooted here should be expanded
   */
  bool computeExpand(Orientation orientation)
  {
    bool _retval;
    _retval = gtk_widget_compute_expand(cast(GtkWidget*)cPtr, orientation);
    return _retval;
  }

  /**
   * Translates the given point in widget's coordinates to coordinates
   * relative to target’s coordinate system.
   * In order to perform this operation, both widgets must share a
   * common ancestor.
   * Params:
   *   target = the `GtkWidget` to transform into
   *   point = a point in widget's coordinate system
   *   outPoint = Set to the corresponding coordinates in
   *     target's coordinate system
   * Returns: %TRUE if the point could be determined, %FALSE on failure.
   *   In this case, 0 is stored in out_point.
   */
  bool computePoint(Widget target, Point point, out Point outPoint)
  {
    bool _retval;
    graphene_point_t _outPoint;
    _retval = gtk_widget_compute_point(cast(GtkWidget*)cPtr, target ? cast(GtkWidget*)target.cPtr(false) : null, point ? cast(graphene_point_t*)point.cPtr(false) : null, &_outPoint);
    outPoint = new Point(cast(void*)&_outPoint, false);
    return _retval;
  }

  /**
   * Computes a matrix suitable to describe a transformation from
   * widget's coordinate system into target's coordinate system.
   * The transform can not be computed in certain cases, for example
   * when widget and target do not share a common ancestor. In that
   * case out_transform gets set to the identity matrix.
   * To learn more about widget coordinate systems, see the coordinate
   * system [overview](coordinates.html).
   * Params:
   *   target = the target widget that the matrix will transform to
   *   outTransform = location to
   *     store the final transformation
   * Returns: %TRUE if the transform could be computed, %FALSE otherwise
   */
  bool computeTransform(Widget target, out Matrix outTransform)
  {
    bool _retval;
    graphene_matrix_t _outTransform;
    _retval = gtk_widget_compute_transform(cast(GtkWidget*)cPtr, target ? cast(GtkWidget*)target.cPtr(false) : null, &_outTransform);
    outTransform = new Matrix(cast(void*)&_outTransform, false);
    return _retval;
  }

  /**
   * Tests if the point at $(LPAREN)x, y$(RPAREN) is contained in widget.
   * The coordinates for $(LPAREN)x, y$(RPAREN) must be in widget coordinates, so
   * $(LPAREN)0, 0$(RPAREN) is assumed to be the top left of widget's content area.
   * Params:
   *   x = X coordinate to test, relative to widget's origin
   *   y = Y coordinate to test, relative to widget's origin
   * Returns: %TRUE if widget contains $(LPAREN)x, y$(RPAREN).
   */
  bool contains(double x, double y)
  {
    bool _retval;
    _retval = gtk_widget_contains(cast(GtkWidget*)cPtr, x, y);
    return _retval;
  }

  /**
   * Creates a new `PangoContext` with the appropriate font map,
   * font options, font description, and base direction for drawing
   * text for this widget.
   * See also [Gtk.Widget.getPangoContext].
   * Returns: the new `PangoContext`
   */
  Context createPangoContext()
  {
    PangoContext* _cretval;
    _cretval = gtk_widget_create_pango_context(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `PangoLayout` with the appropriate font map,
   * font description, and base direction for drawing text for
   * this widget.
   * If you keep a `PangoLayout` created in this way around,
   * you need to re-create it when the widget `PangoContext`
   * is replaced. This can be tracked by listening to changes
   * of the [Gtk.Widget.root] property on the widget.
   * Params:
   *   text = text to set on the layout
   * Returns: the new `PangoLayout`
   */
  Layout createPangoLayout(string text)
  {
    PangoLayout* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = gtk_widget_create_pango_layout(cast(GtkWidget*)cPtr, _text);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Clears the template children for the given widget.
   * This function is the opposite of [Gtk.Widget.initTemplate], and
   * it is used to clear all the template children from a widget instance.
   * If you bound a template child to a field in the instance structure, or
   * in the instance private data structure, the field will be set to `NULL`
   * after this function returns.
   * You should call this function inside the `GObjectClass.dispose$(LPAREN)$(RPAREN)`
   * implementation of any widget that called `[Gtk.Widget.initTemplate]`.
   * Typically, you will want to call this function last, right before
   * chaining up to the parent type's dispose implementation, e.g.
   * ```c
   * static void
   * some_widget_dispose $(LPAREN)GObject *gobject$(RPAREN)
   * {
   * SomeWidget *self \= SOME_WIDGET $(LPAREN)gobject$(RPAREN);
   * // Clear the template data for SomeWidget
   * gtk_widget_dispose_template $(LPAREN)GTK_WIDGET $(LPAREN)self$(RPAREN), SOME_TYPE_WIDGET$(RPAREN);
   * G_OBJECT_CLASS $(LPAREN)some_widget_parent_class$(RPAREN)->dispose $(LPAREN)gobject$(RPAREN);
   * }
   * ```
   * Params:
   *   widgetType = the type of the widget to finalize the template for
   */
  void disposeTemplate(GType widgetType)
  {
    gtk_widget_dispose_template(cast(GtkWidget*)cPtr, widgetType);
  }

  /**
   * Checks to see if a drag movement has passed the GTK drag threshold.
   * Params:
   *   startX = X coordinate of start of drag
   *   startY = Y coordinate of start of drag
   *   currentX = current X coordinate
   *   currentY = current Y coordinate
   * Returns: %TRUE if the drag threshold has been passed.
   */
  bool dragCheckThreshold(int startX, int startY, int currentX, int currentY)
  {
    bool _retval;
    _retval = gtk_drag_check_threshold(cast(GtkWidget*)cPtr, startX, startY, currentX, currentY);
    return _retval;
  }

  /**
   * Notifies the user about an input-related error on this widget.
   * If the propertyGtk.Settings:gtk-error-bell setting is %TRUE,
   * it calls [Gdk.Surface.beep], otherwise it does nothing.
   * Note that the effect of [Gdk.Surface.beep] can be configured
   * in many ways, depending on the windowing backend and the desktop
   * environment or window manager that is used.
   */
  void errorBell()
  {
    gtk_widget_error_bell(cast(GtkWidget*)cPtr);
  }

  /**
   * Returns the baseline that has currently been allocated to widget.
   * This function is intended to be used when implementing handlers
   * for the `GtkWidget`Class.snapshot$(LPAREN)$(RPAREN) function, and when allocating
   * child widgets in `GtkWidget`Class.size_allocate$(LPAREN)$(RPAREN).
   * Returns: the baseline of the widget, or -1 if none

   * Deprecated: Use [Gtk.Widget.getBaseline] instead
   */
  int getAllocatedBaseline()
  {
    int _retval;
    _retval = gtk_widget_get_allocated_baseline(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the height that has currently been allocated to widget.
   * To learn more about widget sizes, see the coordinate
   * system [overview](coordinates.html).
   * Returns: the height of the widget

   * Deprecated: Use [Gtk.Widget.getHeight] instead
   */
  int getAllocatedHeight()
  {
    int _retval;
    _retval = gtk_widget_get_allocated_height(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the width that has currently been allocated to widget.
   * To learn more about widget sizes, see the coordinate
   * system [overview](coordinates.html).
   * Returns: the width of the widget

   * Deprecated: Use [Gtk.Widget.getWidth] instead
   */
  int getAllocatedWidth()
  {
    int _retval;
    _retval = gtk_widget_get_allocated_width(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the first ancestor of widget with type widget_type.
   * For example, `gtk_widget_get_ancestor $(LPAREN)widget, GTK_TYPE_BOX$(RPAREN)`
   * gets the first `GtkBox` that’s an ancestor of widget. No
   * reference will be added to the returned widget; it should
   * not be unreferenced.
   * Note that unlike [Gtk.Widget.isAncestor], this function
   * considers widget to be an ancestor of itself.
   * Params:
   *   widgetType = ancestor type
   * Returns: the ancestor widget
   */
  Widget getAncestor(GType widgetType)
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_ancestor(cast(GtkWidget*)cPtr, widgetType);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the baseline that has currently been allocated to widget.
   * This function is intended to be used when implementing handlers
   * for the `GtkWidget`Class.snapshot$(LPAREN)$(RPAREN) function, and when allocating
   * child widgets in `GtkWidget`Class.size_allocate$(LPAREN)$(RPAREN).
   * Returns: the baseline of the widget, or -1 if none
   */
  int getBaseline()
  {
    int _retval;
    _retval = gtk_widget_get_baseline(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the input focus can enter widget or any
   * of its children.
   * See [Gtk.Widget.setFocusable].
   * Returns: %TRUE if the input focus can enter widget, %FALSE otherwise
   */
  bool getCanFocus()
  {
    bool _retval;
    _retval = gtk_widget_get_can_focus(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Queries whether widget can be the target of pointer events.
   * Returns: %TRUE if widget can receive pointer events
   */
  bool getCanTarget()
  {
    bool _retval;
    _retval = gtk_widget_get_can_target(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the value set with [Gtk.Widget.setChildVisible].
   * If you feel a need to use this function, your code probably
   * needs reorganization.
   * This function is only useful for container implementations
   * and should never be called by an application.
   * Returns: %TRUE if the widget is mapped with the parent.
   */
  bool getChildVisible()
  {
    bool _retval;
    _retval = gtk_widget_get_child_visible(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the clipboard object for widget.
   * This is a utility function to get the clipboard object for the
   * `GdkDisplay` that widget is using.
   * Note that this function always works, even when widget is not
   * realized yet.
   * Returns: the appropriate clipboard object
   */
  Clipboard getClipboard()
  {
    GdkClipboard* _cretval;
    _cretval = gtk_widget_get_clipboard(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Clipboard(cast(GdkClipboard*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current foreground color for the widget’s
   * CSS style.
   * This function should only be used in snapshot
   * implementations that need to do custom
   * drawing with the foreground color.
   * Params:
   *   color = return location for the color
   */
  void getColor(out RGBA color)
  {
    GdkRGBA _color;
    gtk_widget_get_color(cast(GtkWidget*)cPtr, &_color);
    color = new RGBA(cast(void*)&_color, false);
  }

  /**
   * Returns the list of style classes applied to widget.
   * Returns: a %NULL-terminated list of
   *   css classes currently applied to widget. The returned
   *   list must freed using [GLib.Global.strfreev].
   */
  string[] getCssClasses()
  {
    char** _cretval;
    _cretval = gtk_widget_get_css_classes(cast(GtkWidget*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns the CSS name that is used for self.
   * Returns: the CSS name
   */
  string getCssName()
  {
    const(char)* _cretval;
    _cretval = gtk_widget_get_css_name(cast(GtkWidget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Queries the cursor set on widget.
   * See [Gtk.Widget.setCursor] for details.
   * Returns: the cursor
   *   currently in use or %NULL if the cursor is inherited
   */
  Cursor getCursor()
  {
    GdkCursor* _cretval;
    _cretval = gtk_widget_get_cursor(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the reading direction for a particular widget.
   * See [Gtk.Widget.setDirection].
   * Returns: the reading direction for the widget.
   */
  TextDirection getDirection()
  {
    GtkTextDirection _cretval;
    _cretval = gtk_widget_get_direction(cast(GtkWidget*)cPtr);
    TextDirection _retval = cast(TextDirection)_cretval;
    return _retval;
  }

  /**
   * Get the `GdkDisplay` for the toplevel window associated with
   * this widget.
   * This function can only be called after the widget has been
   * added to a widget hierarchy with a `GtkWindow` at the top.
   * In general, you should only create display specific
   * resources when a widget has been realized, and you should
   * free those resources when the widget is unrealized.
   * Returns: the `GdkDisplay` for the toplevel
   *   for this widget.
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gtk_widget_get_display(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the widget’s first child.
   * This API is primarily meant for widget implementations.
   * Returns: The widget's first child
   */
  Widget getFirstChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_first_child(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the current focus child of widget.
   * Returns: The current focus
   *   child of widget
   */
  Widget getFocusChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_focus_child(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the widget should grab focus when it is clicked
   * with the mouse.
   * See [Gtk.Widget.setFocusOnClick].
   * Returns: %TRUE if the widget should grab focus when it is
   *   clicked with the mouse
   */
  bool getFocusOnClick()
  {
    bool _retval;
    _retval = gtk_widget_get_focus_on_click(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines whether widget can own the input focus.
   * See [Gtk.Widget.setFocusable].
   * Returns: %TRUE if widget can own the input focus, %FALSE otherwise
   */
  bool getFocusable()
  {
    bool _retval;
    _retval = gtk_widget_get_focusable(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the font map of widget.
   * See [Gtk.Widget.setFontMap].
   * Returns: A `PangoFontMap`
   */
  FontMap getFontMap()
  {
    PangoFontMap* _cretval;
    _cretval = gtk_widget_get_font_map(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `cairo_font_options_t` of widget.
   * Seee [Gtk.Widget.setFontOptions].
   * Returns: the `cairo_font_options_t`
   *   of widget
   */
  FontOptions getFontOptions()
  {
    const(cairo_font_options_t)* _cretval;
    _cretval = gtk_widget_get_font_options(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? new FontOptions(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the frame clock for a widget.
   * The frame clock is a global “ticker” that can be used to drive
   * animations and repaints. The most common reason to get the frame
   * clock is to call [Gdk.FrameClock.getFrameTime], in order
   * to get a time to use for animating. For example you might record
   * the start of the animation with an initial value from
   * [Gdk.FrameClock.getFrameTime], and then update the animation
   * by calling [Gdk.FrameClock.getFrameTime] again during each repaint.
   * [Gdk.FrameClock.requestPhase] will result in a new frame on the
   * clock, but won’t necessarily repaint any widgets. To repaint a
   * widget, you have to use [Gtk.Widget.queueDraw] which invalidates
   * the widget $(LPAREN)thus scheduling it to receive a draw on the next
   * frame$(RPAREN). [Gtk.Widget.queueDraw] will also end up requesting a frame
   * on the appropriate frame clock.
   * A widget’s frame clock will not change while the widget is
   * mapped. Reparenting a widget $(LPAREN)which implies a temporary unmap$(RPAREN) can
   * change the widget’s frame clock.
   * Unrealized widgets do not have a frame clock.
   * Returns: a `GdkFrameClock`
   */
  FrameClock getFrameClock()
  {
    GdkFrameClock* _cretval;
    _cretval = gtk_widget_get_frame_clock(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FrameClock(cast(GdkFrameClock*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the horizontal alignment of widget.
   * For backwards compatibility reasons this method will never return
   * one of the baseline alignments, but instead it will convert it to
   * `GTK_ALIGN_FILL` or `GTK_ALIGN_CENTER`.
   * Baselines are not supported for horizontal alignment.
   * Returns: the horizontal alignment of widget
   */
  Align getHalign()
  {
    GtkAlign _cretval;
    _cretval = gtk_widget_get_halign(cast(GtkWidget*)cPtr);
    Align _retval = cast(Align)_cretval;
    return _retval;
  }

  /**
   * Returns the current value of the `has-tooltip` property.
   * Returns: current value of `has-tooltip` on widget.
   */
  bool getHasTooltip()
  {
    bool _retval;
    _retval = gtk_widget_get_has_tooltip(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the content height of the widget.
   * This function returns the height passed to its
   * size-allocate implementation, which is the height you
   * should be using in vfuncGtk.Widget.snapshot.
   * For pointer events, see [Gtk.Widget.contains].
   * To learn more about widget sizes, see the coordinate
   * system [overview](coordinates.html).
   * Returns: The height of widget
   */
  int getHeight()
  {
    int _retval;
    _retval = gtk_widget_get_height(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the widget would like any available extra horizontal
   * space.
   * When a user resizes a `GtkWindow`, widgets with expand\=TRUE
   * generally receive the extra space. For example, a list or
   * scrollable area or document in your window would often be set to
   * expand.
   * Containers should use [Gtk.Widget.computeExpand] rather
   * than this function, to see whether a widget, or any of its children,
   * has the expand flag set. If any child of a widget wants to
   * expand, the parent may ask to expand also.
   * This function only looks at the widget’s own hexpand flag, rather
   * than computing whether the entire widget tree rooted at this widget
   * wants to expand.
   * Returns: whether hexpand flag is set
   */
  bool getHexpand()
  {
    bool _retval;
    _retval = gtk_widget_get_hexpand(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether [Gtk.Widget.setHexpand] has been used
   * to explicitly set the expand flag on this widget.
   * If [Gtk.Widget.hexpand] property is set, then it
   * overrides any computed expand value based on child widgets.
   * If `hexpand` is not set, then the expand value depends on
   * whether any children of the widget would like to expand.
   * There are few reasons to use this function, but it’s here
   * for completeness and consistency.
   * Returns: whether hexpand has been explicitly set
   */
  bool getHexpandSet()
  {
    bool _retval;
    _retval = gtk_widget_get_hexpand_set(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the widget’s last child.
   * This API is primarily meant for widget implementations.
   * Returns: The widget's last child
   */
  Widget getLastChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_last_child(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the layout manager used by widget.
   * See [Gtk.Widget.setLayoutManager].
   * Returns: a `GtkLayoutManager`
   */
  LayoutManager getLayoutManager()
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_widget_get_layout_manager(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!LayoutManager(cast(GtkLayoutManager*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Whether the widget is mapped.
   * Returns: %TRUE if the widget is mapped, %FALSE otherwise.
   */
  bool getMapped()
  {
    bool _retval;
    _retval = gtk_widget_get_mapped(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the bottom margin of widget.
   * Returns: The bottom margin of widget
   */
  int getMarginBottom()
  {
    int _retval;
    _retval = gtk_widget_get_margin_bottom(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the end margin of widget.
   * Returns: The end margin of widget
   */
  int getMarginEnd()
  {
    int _retval;
    _retval = gtk_widget_get_margin_end(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the start margin of widget.
   * Returns: The start margin of widget
   */
  int getMarginStart()
  {
    int _retval;
    _retval = gtk_widget_get_margin_start(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the top margin of widget.
   * Returns: The top margin of widget
   */
  int getMarginTop()
  {
    int _retval;
    _retval = gtk_widget_get_margin_top(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the name of a widget.
   * See [Gtk.Widget.setName] for the significance of widget names.
   * Returns: name of the widget. This string is owned by GTK and
   *   should not be modified or freed
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_widget_get_name(cast(GtkWidget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the nearest `GtkNative` ancestor of widget.
   * This function will return %NULL if the widget is not
   * contained inside a widget tree with a native ancestor.
   * `GtkNative` widgets will return themselves here.
   * Returns: the `GtkNative` ancestor of widget
   */
  Native getNative()
  {
    GtkNative* _cretval;
    _cretval = gtk_widget_get_native(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Native(cast(GtkNative*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the widget’s next sibling.
   * This API is primarily meant for widget implementations.
   * Returns: The widget's next sibling
   */
  Widget getNextSibling()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_next_sibling(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * #Fetches the requested opacity for this widget.
   * See [Gtk.Widget.setOpacity].
   * Returns: the requested opacity for this widget.
   */
  double getOpacity()
  {
    double _retval;
    _retval = gtk_widget_get_opacity(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the widget’s overflow value.
   * Returns: The widget's overflow.
   */
  Overflow getOverflow()
  {
    GtkOverflow _cretval;
    _cretval = gtk_widget_get_overflow(cast(GtkWidget*)cPtr);
    Overflow _retval = cast(Overflow)_cretval;
    return _retval;
  }

  /**
   * Gets a `PangoContext` with the appropriate font map, font description,
   * and base direction for this widget.
   * Unlike the context returned by [Gtk.Widget.createPangoContext],
   * this context is owned by the widget $(LPAREN)it can be used until the screen
   * for the widget changes or the widget is removed from its toplevel$(RPAREN),
   * and will be updated to match any changes to the widget’s attributes.
   * This can be tracked by listening to changes of the
   * [Gtk.Widget.root] property on the widget.
   * Returns: the `PangoContext` for the widget.
   */
  Context getPangoContext()
  {
    PangoContext* _cretval;
    _cretval = gtk_widget_get_pango_context(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the parent widget of widget.
   * Returns: the parent widget of widget
   */
  Widget getParent()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_parent(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the minimum and natural size of a widget, taking
   * into account the widget’s preference for height-for-width management.
   * This is used to retrieve a suitable size by container widgets which do
   * not impose any restrictions on the child placement. It can be used
   * to deduce toplevel window and menu sizes as well as child widgets in
   * free-form containers such as `GtkFixed`.
   * Handle with care. Note that the natural height of a height-for-width
   * widget will generally be a smaller size than the minimum height, since
   * the required height for the natural width is generally smaller than the
   * required height for the minimum width.
   * Use [Gtk.Widget.measure] if you want to support baseline alignment.
   * Params:
   *   minimumSize = location for storing the minimum size
   *   naturalSize = location for storing the natural size
   */
  void getPreferredSize(out Requisition minimumSize, out Requisition naturalSize)
  {
    GtkRequisition _minimumSize;
    GtkRequisition _naturalSize;
    gtk_widget_get_preferred_size(cast(GtkWidget*)cPtr, &_minimumSize, &_naturalSize);
    minimumSize = new Requisition(cast(void*)&_minimumSize, false);
    naturalSize = new Requisition(cast(void*)&_naturalSize, false);
  }

  /**
   * Returns the widget’s previous sibling.
   * This API is primarily meant for widget implementations.
   * Returns: The widget's previous sibling
   */
  Widget getPrevSibling()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_get_prev_sibling(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the primary clipboard of widget.
   * This is a utility function to get the primary clipboard object
   * for the `GdkDisplay` that widget is using.
   * Note that this function always works, even when widget is not
   * realized yet.
   * Returns: the appropriate clipboard object
   */
  Clipboard getPrimaryClipboard()
  {
    GdkClipboard* _cretval;
    _cretval = gtk_widget_get_primary_clipboard(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Clipboard(cast(GdkClipboard*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determines whether widget is realized.
   * Returns: %TRUE if widget is realized, %FALSE otherwise
   */
  bool getRealized()
  {
    bool _retval;
    _retval = gtk_widget_get_realized(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines whether widget is always treated as the default widget
   * within its toplevel when it has the focus, even if another widget
   * is the default.
   * See [Gtk.Widget.setReceivesDefault].
   * Returns: %TRUE if widget acts as the default widget when focused,
   *   %FALSE otherwise
   */
  bool getReceivesDefault()
  {
    bool _retval;
    _retval = gtk_widget_get_receives_default(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the widget prefers a height-for-width layout
   * or a width-for-height layout.
   * Single-child widgets generally propagate the preference of
   * their child, more complex widgets need to request something
   * either in context of their children or in context of their
   * allocation capabilities.
   * Returns: The `GtkSizeRequestMode` preferred by widget.
   */
  SizeRequestMode getRequestMode()
  {
    GtkSizeRequestMode _cretval;
    _cretval = gtk_widget_get_request_mode(cast(GtkWidget*)cPtr);
    SizeRequestMode _retval = cast(SizeRequestMode)_cretval;
    return _retval;
  }

  /**
   * Returns the `GtkRoot` widget of widget.
   * This function will return %NULL if the widget is not contained
   * inside a widget tree with a root widget.
   * `GtkRoot` widgets will return themselves here.
   * Returns: the root widget of widget
   */
  Root getRoot()
  {
    GtkRoot* _cretval;
    _cretval = gtk_widget_get_root(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Root(cast(GtkRoot*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the internal scale factor that maps from window
   * coordinates to the actual device pixels.
   * On traditional systems this is 1, on high density outputs,
   * it can be a higher value $(LPAREN)typically 2$(RPAREN).
   * See [Gdk.Surface.getScaleFactor].
   * Returns: the scale factor for widget
   */
  int getScaleFactor()
  {
    int _retval;
    _retval = gtk_widget_get_scale_factor(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the widget’s sensitivity.
   * This function returns the value that has been set using
   * [Gtk.Widget.setSensitive]$(RPAREN).
   * The effective sensitivity of a widget is however determined
   * by both its own and its parent widget’s sensitivity.
   * See [Gtk.Widget.isSensitive].
   * Returns: %TRUE if the widget is sensitive
   */
  bool getSensitive()
  {
    bool _retval;
    _retval = gtk_widget_get_sensitive(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets the settings object holding the settings used for this widget.
   * Note that this function can only be called when the `GtkWidget`
   * is attached to a toplevel, since the settings object is specific
   * to a particular `GdkDisplay`. If you want to monitor the widget for
   * changes in its settings, connect to the `notify::display` signal.
   * Returns: the relevant `GtkSettings` object
   */
  Settings getSettings()
  {
    GtkSettings* _cretval;
    _cretval = gtk_widget_get_settings(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Settings(cast(GtkSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the content width or height of the widget.
   * Which dimension is returned depends on orientation.
   * This is equivalent to calling [Gtk.Widget.getWidth]
   * for %GTK_ORIENTATION_HORIZONTAL or [Gtk.Widget.getHeight]
   * for %GTK_ORIENTATION_VERTICAL, but can be used when
   * writing orientation-independent code, such as when
   * implementing [Gtk.Orientable] widgets.
   * To learn more about widget sizes, see the coordinate
   * system [overview](coordinates.html).
   * Params:
   *   orientation = the orientation to query
   * Returns: The size of widget in orientation.
   */
  int getSize(Orientation orientation)
  {
    int _retval;
    _retval = gtk_widget_get_size(cast(GtkWidget*)cPtr, orientation);
    return _retval;
  }

  /**
   * Gets the size request that was explicitly set for the widget using
   * [Gtk.Widget.setSizeRequest].
   * A value of -1 stored in width or height indicates that that
   * dimension has not been set explicitly and the natural requisition
   * of the widget will be used instead. See
   * [Gtk.Widget.setSizeRequest]. To get the size a widget will
   * actually request, call [Gtk.Widget.measure] instead of
   * this function.
   * Params:
   *   width = return location for width
   *   height = return location for height
   */
  void getSizeRequest(out int width, out int height)
  {
    gtk_widget_get_size_request(cast(GtkWidget*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Returns the widget state as a flag set.
   * It is worth mentioning that the effective %GTK_STATE_FLAG_INSENSITIVE
   * state will be returned, that is, also based on parent insensitivity,
   * even if widget itself is sensitive.
   * Also note that if you are looking for a way to obtain the
   * [Gtk] to pass to a [Gtk.StyleContext]
   * method, you should look at [Gtk.StyleContext.getState].
   * Returns: The state flags for widget
   */
  StateFlags getStateFlags()
  {
    GtkStateFlags _cretval;
    _cretval = gtk_widget_get_state_flags(cast(GtkWidget*)cPtr);
    StateFlags _retval = cast(StateFlags)_cretval;
    return _retval;
  }

  /**
   * Returns the style context associated to widget.
   * The returned object is guaranteed to be the same
   * for the lifetime of widget.
   * Returns: the widget’s `GtkStyleContext`

   * Deprecated: Style contexts will be removed in GTK 5
   */
  StyleContext getStyleContext()
  {
    GtkStyleContext* _cretval;
    _cretval = gtk_widget_get_style_context(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!StyleContext(cast(GtkStyleContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Fetch an object build from the template XML for widget_type in
   * this widget instance.
   * This will only report children which were previously declared
   * with [Gtk.WidgetClass.bindTemplateChildFull] or one of its
   * variants.
   * This function is only meant to be called for code which is private
   * to the widget_type which declared the child and is meant for language
   * bindings which cannot easily make use of the GObject structure offsets.
   * Params:
   *   widgetType = The `GType` to get a template child for
   *   name = The “id” of the child defined in the template XML
   * Returns: The object built in the template XML with
   *   the id name
   */
  ObjectG getTemplateChild(GType widgetType, string name)
  {
    ObjectC* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_widget_get_template_child(cast(GtkWidget*)cPtr, widgetType, _name);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the contents of the tooltip for widget.
   * If the tooltip has not been set using
   * [Gtk.Widget.setTooltipMarkup], this
   * function returns %NULL.
   * Returns: the tooltip text
   */
  string getTooltipMarkup()
  {
    const(char)* _cretval;
    _cretval = gtk_widget_get_tooltip_markup(cast(GtkWidget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the contents of the tooltip for widget.
   * If the widget's tooltip was set using
   * [Gtk.Widget.setTooltipMarkup],
   * this function will return the escaped text.
   * Returns: the tooltip text
   */
  string getTooltipText()
  {
    const(char)* _cretval;
    _cretval = gtk_widget_get_tooltip_text(cast(GtkWidget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the vertical alignment of widget.
   * Returns: the vertical alignment of widget
   */
  Align getValign()
  {
    GtkAlign _cretval;
    _cretval = gtk_widget_get_valign(cast(GtkWidget*)cPtr);
    Align _retval = cast(Align)_cretval;
    return _retval;
  }

  /**
   * Gets whether the widget would like any available extra vertical
   * space.
   * See [Gtk.Widget.getHexpand] for more detail.
   * Returns: whether vexpand flag is set
   */
  bool getVexpand()
  {
    bool _retval;
    _retval = gtk_widget_get_vexpand(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether [Gtk.Widget.setVexpand] has been used to
   * explicitly set the expand flag on this widget.
   * See [Gtk.Widget.getHexpandSet] for more detail.
   * Returns: whether vexpand has been explicitly set
   */
  bool getVexpandSet()
  {
    bool _retval;
    _retval = gtk_widget_get_vexpand_set(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the widget is visible.
   * If you want to take into account whether the widget’s
   * parent is also marked as visible, use
   * [Gtk.Widget.isVisible] instead.
   * This function does not check if the widget is
   * obscured in any way.
   * See [Gtk.Widget.setVisible].
   * Returns: %TRUE if the widget is visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_widget_get_visible(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the content width of the widget.
   * This function returns the width passed to its
   * size-allocate implementation, which is the width you
   * should be using in vfuncGtk.Widget.snapshot.
   * For pointer events, see [Gtk.Widget.contains].
   * To learn more about widget sizes, see the coordinate
   * system [overview](coordinates.html).
   * Returns: The width of widget
   */
  int getWidth()
  {
    int _retval;
    _retval = gtk_widget_get_width(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Causes widget to have the keyboard focus for the `GtkWindow` it's inside.
   * If widget is not focusable, or its vfuncGtk.Widget.grab_focus
   * implementation cannot transfer the focus to a descendant of widget
   * that is focusable, it will not take focus and %FALSE will be returned.
   * Calling [Gtk.Widget.grabFocus] on an already focused widget
   * is allowed, should not have an effect, and return %TRUE.
   * Returns: %TRUE if focus is now inside widget.
   */
  bool grabFocus()
  {
    bool _retval;
    _retval = gtk_widget_grab_focus(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns whether css_class is currently applied to widget.
   * Params:
   *   cssClass = A style class, without the leading '.'
   *     used for notation of style classes
   * Returns: %TRUE if css_class is currently applied to widget,
   *   %FALSE otherwise.
   */
  bool hasCssClass(string cssClass)
  {
    bool _retval;
    const(char)* _cssClass = cssClass.toCString(false);
    _retval = gtk_widget_has_css_class(cast(GtkWidget*)cPtr, _cssClass);
    return _retval;
  }

  /**
   * Determines whether widget is the current default widget
   * within its toplevel.
   * Returns: %TRUE if widget is the current default widget
   *   within its toplevel, %FALSE otherwise
   */
  bool hasDefault()
  {
    bool _retval;
    _retval = gtk_widget_has_default(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines if the widget has the global input focus.
   * See [Gtk.Widget.isFocus] for the difference between
   * having the global input focus, and only having the focus
   * within a toplevel.
   * Returns: %TRUE if the widget has the global input focus.
   */
  bool hasFocus()
  {
    bool _retval;
    _retval = gtk_widget_has_focus(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines if the widget should show a visible indication that
   * it has the global input focus.
   * This is a convenience function that takes into account whether
   * focus indication should currently be shown in the toplevel window
   * of widget. See [Gtk.Window.getFocusVisible] for more
   * information about focus indication.
   * To find out if the widget has the global input focus, use
   * [Gtk.Widget.hasFocus].
   * Returns: %TRUE if the widget should display a “focus rectangle”
   */
  bool hasVisibleFocus()
  {
    bool _retval;
    _retval = gtk_widget_has_visible_focus(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Reverses the effects of [Gtk.Widget.show].
   * This is causing the widget to be hidden $(LPAREN)invisible to the user$(RPAREN).

   * Deprecated: Use [Gtk.Widget.setVisible] instead
   */
  void hide()
  {
    gtk_widget_hide(cast(GtkWidget*)cPtr);
  }

  /**
   * Returns whether the widget is currently being destroyed.
   * This information can sometimes be used to avoid doing
   * unnecessary work.
   * Returns: %TRUE if widget is being destroyed
   */
  bool inDestruction()
  {
    bool _retval;
    _retval = gtk_widget_in_destruction(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Creates and initializes child widgets defined in templates.
   * This function must be called in the instance initializer
   * for any class which assigned itself a template using
   * [Gtk.WidgetClass.setTemplate].
   * It is important to call this function in the instance initializer
   * of a `GtkWidget` subclass and not in `GObject.constructed$(LPAREN)$(RPAREN)` or
   * `GObject.constructor$(LPAREN)$(RPAREN)` for two reasons:
   * - derived widgets will assume that the composite widgets
   * defined by its parent classes have been created in their
   * relative instance initializers
   * - when calling `[GObject.ObjectG.new_]` on a widget with composite templates,
   * it’s important to build the composite widgets before the construct
   * properties are set. Properties passed to `[GObject.ObjectG.new_]` should
   * take precedence over properties set in the private template XML
   * A good rule of thumb is to call this function as the first thing in
   * an instance initialization function.
   */
  void initTemplate()
  {
    gtk_widget_init_template(cast(GtkWidget*)cPtr);
  }

  /**
   * Inserts group into widget.
   * Children of widget that implement [Gtk.Actionable] can
   * then be associated with actions in group by setting their
   * “action-name” to prefix.`action-name`.
   * Note that inheritance is defined for individual actions. I.e.
   * even if you insert a group with prefix prefix, actions with
   * the same prefix will still be inherited from the parent, unless
   * the group contains an action with the same name.
   * If group is %NULL, a previously inserted group for name is
   * removed from widget.
   * Params:
   *   name = the prefix for actions in group
   *   group = a `GActionGroup`, or %NULL to remove
   *     the previously inserted group for name
   */
  void insertActionGroup(string name, ActionGroup group)
  {
    const(char)* _name = name.toCString(false);
    gtk_widget_insert_action_group(cast(GtkWidget*)cPtr, _name, group ? cast(GActionGroup*)(cast(ObjectG)group).cPtr(false) : null);
  }

  /**
   * Inserts widget into the child widget list of parent.
   * It will be placed after previous_sibling, or at the beginning if
   * previous_sibling is %NULL.
   * After calling this function, `gtk_widget_get_prev_sibling$(LPAREN)widget$(RPAREN)`
   * will return previous_sibling.
   * If parent is already set as the parent widget of widget, this
   * function can also be used to reorder widget in the child widget
   * list of parent.
   * This API is primarily meant for widget implementations; if you are
   * just using a widget, you *must* use its own API for adding children.
   * Params:
   *   parent = the parent `GtkWidget` to insert widget into
   *   previousSibling = the new previous sibling of widget
   */
  void insertAfter(Widget parent, Widget previousSibling)
  {
    gtk_widget_insert_after(cast(GtkWidget*)cPtr, parent ? cast(GtkWidget*)parent.cPtr(false) : null, previousSibling ? cast(GtkWidget*)previousSibling.cPtr(false) : null);
  }

  /**
   * Inserts widget into the child widget list of parent.
   * It will be placed before next_sibling, or at the end if
   * next_sibling is %NULL.
   * After calling this function, `gtk_widget_get_next_sibling$(LPAREN)widget$(RPAREN)`
   * will return next_sibling.
   * If parent is already set as the parent widget of widget, this function
   * can also be used to reorder widget in the child widget list of parent.
   * This API is primarily meant for widget implementations; if you are
   * just using a widget, you *must* use its own API for adding children.
   * Params:
   *   parent = the parent `GtkWidget` to insert widget into
   *   nextSibling = the new next sibling of widget
   */
  void insertBefore(Widget parent, Widget nextSibling)
  {
    gtk_widget_insert_before(cast(GtkWidget*)cPtr, parent ? cast(GtkWidget*)parent.cPtr(false) : null, nextSibling ? cast(GtkWidget*)nextSibling.cPtr(false) : null);
  }

  /**
   * Determines whether widget is somewhere inside ancestor,
   * possibly with intermediate containers.
   * Params:
   *   ancestor = another `GtkWidget`
   * Returns: %TRUE if ancestor contains widget as a child,
   *   grandchild, great grandchild, etc.
   */
  bool isAncestor(Widget ancestor)
  {
    bool _retval;
    _retval = gtk_widget_is_ancestor(cast(GtkWidget*)cPtr, ancestor ? cast(GtkWidget*)ancestor.cPtr(false) : null);
    return _retval;
  }

  /**
   * Determines whether widget can be drawn to.
   * A widget can be drawn if it is mapped and visible.
   * Returns: %TRUE if widget is drawable, %FALSE otherwise
   */
  bool isDrawable()
  {
    bool _retval;
    _retval = gtk_widget_is_drawable(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines if the widget is the focus widget within its
   * toplevel.
   * This does not mean that the propertyGtk.Widget:has-focus
   * property is necessarily set; propertyGtk.Widget:has-focus
   * will only be set if the toplevel widget additionally has the
   * global input focus.
   * Returns: %TRUE if the widget is the focus widget.
   */
  bool isFocus()
  {
    bool _retval;
    _retval = gtk_widget_is_focus(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Returns the widget’s effective sensitivity.
   * This means it is sensitive itself and also its
   * parent widget is sensitive.
   * Returns: %TRUE if the widget is effectively sensitive
   */
  bool isSensitive()
  {
    bool _retval;
    _retval = gtk_widget_is_sensitive(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the widget and all its parents are marked as
   * visible.
   * This function does not check if the widget is obscured in any way.
   * See also [Gtk.Widget.getVisible] and
   * [Gtk.Widget.setVisible].
   * Returns: %TRUE if the widget and all its parents are visible
   */
  bool isVisible()
  {
    bool _retval;
    _retval = gtk_widget_is_visible(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Emits the `::keynav-failed` signal on the widget.
   * This function should be called whenever keyboard navigation
   * within a single widget hits a boundary.
   * The return value of this function should be interpreted
   * in a way similar to the return value of
   * [Gtk.Widget.childFocus]. When %TRUE is returned,
   * stay in the widget, the failed keyboard  navigation is OK
   * and/or there is nowhere we can/should move the focus to.
   * When %FALSE is returned, the caller should continue with
   * keyboard navigation outside the widget, e.g. by calling
   * [Gtk.Widget.childFocus] on the widget’s toplevel.
   * The default signalGtk.Widget::keynav-failed handler returns
   * %FALSE for %GTK_DIR_TAB_FORWARD and %GTK_DIR_TAB_BACKWARD.
   * For the other values of `GtkDirectionType` it returns %TRUE.
   * Whenever the default handler returns %TRUE, it also calls
   * [Gtk.Widget.errorBell] to notify the user of the
   * failed keyboard navigation.
   * A use case for providing an own implementation of ::keynav-failed
   * $(LPAREN)either by connecting to it or by overriding it$(RPAREN) would be a row of
   * [Gtk.Entry] widgets where the user should be able to navigate
   * the entire row with the cursor keys, as e.g. known from user
   * interfaces that require entering license keys.
   * Params:
   *   direction = direction of focus movement
   * Returns: %TRUE if stopping keyboard navigation is fine, %FALSE
   *   if the emitting widget should try to handle the keyboard
   *   navigation attempt in its parent container$(LPAREN)s$(RPAREN).
   */
  bool keynavFailed(DirectionType direction)
  {
    bool _retval;
    _retval = gtk_widget_keynav_failed(cast(GtkWidget*)cPtr, direction);
    return _retval;
  }

  /**
   * Returns the widgets for which this widget is the target of a
   * mnemonic.
   * Typically, these widgets will be labels. See, for example,
   * [Gtk.Label.setMnemonicWidget].
   * The widgets in the list are not individually referenced.
   * If you want to iterate through the list and perform actions
   * involving callbacks that might destroy the widgets, you
   * must call `g_list_foreach $(LPAREN)result, $(LPAREN)GFunc$(RPAREN)g_object_ref, NULL$(RPAREN)`
   * first, and then unref all the widgets afterwards.
   * Returns: the list
   *   of mnemonic labels; free this list with [GLib.List.free] when you
   *   are done with it.
   */
  List!(Widget) listMnemonicLabels()
  {
    GList* _cretval;
    _cretval = gtk_widget_list_mnemonic_labels(cast(GtkWidget*)cPtr);
    List!(Widget) _retval = new List!(Widget)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Causes a widget to be mapped if it isn’t already.
   * This function is only for use in widget implementations.
   */
  void map()
  {
    gtk_widget_map(cast(GtkWidget*)cPtr);
  }

  /**
   * Measures widget in the orientation orientation and for the given for_size.
   * As an example, if orientation is %GTK_ORIENTATION_HORIZONTAL and for_size
   * is 300, this functions will compute the minimum and natural width of widget
   * if it is allocated at a height of 300 pixels.
   * See [GtkWidget’s geometry management section](class.Widget.html#height-for-width-geometry-management) for
   * a more details on implementing `GtkWidgetClass.measure$(LPAREN)$(RPAREN)`.
   * Params:
   *   orientation = the orientation to measure
   *   forSize = Size for the opposite of orientation, i.e.
   *     if orientation is %GTK_ORIENTATION_HORIZONTAL, this is
   *     the height the widget should be measured with. The %GTK_ORIENTATION_VERTICAL
   *     case is analogous. This way, both height-for-width and width-for-height
   *     requests can be implemented. If no size is known, -1 can be passed.
   *   minimum = location to store the minimum size
   *   natural = location to store the natural size
   *   minimumBaseline = location to store the baseline
   *     position for the minimum size, or -1 to report no baseline
   *   naturalBaseline = location to store the baseline
   *     position for the natural size, or -1 to report no baseline
   */
  void measure(Orientation orientation, int forSize, out int minimum, out int natural, out int minimumBaseline, out int naturalBaseline)
  {
    gtk_widget_measure(cast(GtkWidget*)cPtr, orientation, forSize, cast(int*)&minimum, cast(int*)&natural, cast(int*)&minimumBaseline, cast(int*)&naturalBaseline);
  }

  /**
   * Emits the ::mnemonic-activate signal.
   * See signalGtk.Widget::mnemonic-activate.
   * Params:
   *   groupCycling = %TRUE if there are other widgets with the same mnemonic
   * Returns: %TRUE if the signal has been handled
   */
  bool mnemonicActivate(bool groupCycling)
  {
    bool _retval;
    _retval = gtk_widget_mnemonic_activate(cast(GtkWidget*)cPtr, groupCycling);
    return _retval;
  }

  /**
   * Returns a `GListModel` to track the children of widget.
   * Calling this function will enable extra internal bookkeeping
   * to track children and emit signals on the returned listmodel.
   * It may slow down operations a lot.
   * Applications should try hard to avoid calling this function
   * because of the slowdowns.
   * Returns: a `GListModel` tracking widget's children
   */
  ListModel observeChildren()
  {
    GListModel* _cretval;
    _cretval = gtk_widget_observe_children(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a `GListModel` to track the [Gtk.EventController]s
   * of widget.
   * Calling this function will enable extra internal bookkeeping
   * to track controllers and emit signals on the returned listmodel.
   * It may slow down operations a lot.
   * Applications should try hard to avoid calling this function
   * because of the slowdowns.
   * Returns: a `GListModel` tracking widget's controllers
   */
  ListModel observeControllers()
  {
    GListModel* _cretval;
    _cretval = gtk_widget_observe_controllers(cast(GtkWidget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Finds the descendant of widget closest to the point $(LPAREN)x, y$(RPAREN).
   * The point must be given in widget coordinates, so $(LPAREN)0, 0$(RPAREN) is assumed
   * to be the top left of widget's content area.
   * Usually widgets will return %NULL if the given coordinate is not
   * contained in widget checked via [Gtk.Widget.contains].
   * Otherwise they will recursively try to find a child that does
   * not return %NULL. Widgets are however free to customize their
   * picking algorithm.
   * This function is used on the toplevel to determine the widget
   * below the mouse cursor for purposes of hover highlighting and
   * delivering events.
   * Params:
   *   x = X coordinate to test, relative to widget's origin
   *   y = Y coordinate to test, relative to widget's origin
   *   flags = Flags to influence what is picked
   * Returns: The widget descendant at
   *   the given point
   */
  Widget pick(double x, double y, PickFlags flags)
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_pick(cast(GtkWidget*)cPtr, x, y, flags);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Flags the widget for a rerun of the vfuncGtk.Widget.size_allocate
   * function.
   * Use this function instead of [Gtk.Widget.queueResize]
   * when the widget's size request didn't change but it wants to
   * reposition its contents.
   * An example user of this function is [Gtk.Widget.setHalign].
   * This function is only for use in widget implementations.
   */
  void queueAllocate()
  {
    gtk_widget_queue_allocate(cast(GtkWidget*)cPtr);
  }

  /**
   * Schedules this widget to be redrawn in the paint phase
   * of the current or the next frame.
   * This means widget's vfuncGtk.Widget.snapshot
   * implementation will be called.
   */
  void queueDraw()
  {
    gtk_widget_queue_draw(cast(GtkWidget*)cPtr);
  }

  /**
   * Flags a widget to have its size renegotiated.
   * This should be called when a widget for some reason has a new
   * size request. For example, when you change the text in a
   * [Gtk.Label], the label queues a resize to ensure there’s
   * enough space for the new text.
   * Note that you cannot call [Gtk.Widget.queueResize] on a widget
   * from inside its implementation of the vfuncGtk.Widget.size_allocate
   * virtual method. Calls to [Gtk.Widget.queueResize] from inside
   * vfuncGtk.Widget.size_allocate will be silently ignored.
   * This function is only for use in widget implementations.
   */
  void queueResize()
  {
    gtk_widget_queue_resize(cast(GtkWidget*)cPtr);
  }

  /**
   * Creates the GDK resources associated with a widget.
   * Normally realization happens implicitly; if you show a widget
   * and all its parent containers, then the widget will be realized
   * and mapped automatically.
   * Realizing a widget requires all the widget’s parent widgets to be
   * realized; calling this function realizes the widget’s parents
   * in addition to widget itself. If a widget is not yet inside a
   * toplevel window when you realize it, bad things will happen.
   * This function is primarily used in widget implementations, and
   * isn’t very useful otherwise. Many times when you think you might
   * need it, a better approach is to connect to a signal that will be
   * called after the widget is realized automatically, such as
   * [Gtk.Widget.realize].
   */
  void realize()
  {
    gtk_widget_realize(cast(GtkWidget*)cPtr);
  }

  /**
   * Removes controller from widget, so that it doesn't process
   * events anymore.
   * It should not be used again.
   * Widgets will remove all event controllers automatically when they
   * are destroyed, there is normally no need to call this function.
   * Params:
   *   controller = a `GtkEventController`
   */
  void removeController(EventController controller)
  {
    gtk_widget_remove_controller(cast(GtkWidget*)cPtr, controller ? cast(GtkEventController*)controller.cPtr(false) : null);
  }

  /**
   * Removes a style from widget.
   * After this, the style of widget will stop matching for css_class.
   * Params:
   *   cssClass = The style class to remove from widget, without
   *     the leading '.' used for notation of style classes
   */
  void removeCssClass(string cssClass)
  {
    const(char)* _cssClass = cssClass.toCString(false);
    gtk_widget_remove_css_class(cast(GtkWidget*)cPtr, _cssClass);
  }

  /**
   * Removes a widget from the list of mnemonic labels for this widget.
   * See [Gtk.Widget.listMnemonicLabels]. The widget must
   * have previously been added to the list with
   * [Gtk.Widget.addMnemonicLabel].
   * Params:
   *   label = a `GtkWidget` that was previously set as a mnemonic
   *     label for widget with [Gtk.Widget.addMnemonicLabel]
   */
  void removeMnemonicLabel(Widget label)
  {
    gtk_widget_remove_mnemonic_label(cast(GtkWidget*)cPtr, label ? cast(GtkWidget*)label.cPtr(false) : null);
  }

  /**
   * Removes a tick callback previously registered with
   * [Gtk.Widget.addTickCallback].
   * Params:
   *   id = an id returned by [Gtk.Widget.addTickCallback]
   */
  void removeTickCallback(uint id)
  {
    gtk_widget_remove_tick_callback(cast(GtkWidget*)cPtr, id);
  }

  /**
   * Specifies whether the input focus can enter the widget
   * or any of its children.
   * Applications should set can_focus to %FALSE to mark a
   * widget as for pointer/touch use only.
   * Note that having can_focus be %TRUE is only one of the
   * necessary conditions for being focusable. A widget must
   * also be sensitive and focusable and not have an ancestor
   * that is marked as not can-focus in order to receive input
   * focus.
   * See [Gtk.Widget.grabFocus] for actually setting
   * the input focus on a widget.
   * Params:
   *   canFocus = whether or not the input focus can enter
   *     the widget or any of its children
   */
  void setCanFocus(bool canFocus)
  {
    gtk_widget_set_can_focus(cast(GtkWidget*)cPtr, canFocus);
  }

  /**
   * Sets whether widget can be the target of pointer events.
   * Params:
   *   canTarget = whether this widget should be able to
   *     receive pointer events
   */
  void setCanTarget(bool canTarget)
  {
    gtk_widget_set_can_target(cast(GtkWidget*)cPtr, canTarget);
  }

  /**
   * Sets whether widget should be mapped along with its parent.
   * The child visibility can be set for widget before it is added
   * to a container with [Gtk.Widget.setParent], to avoid
   * mapping children unnecessary before immediately unmapping them.
   * However it will be reset to its default state of %TRUE when the
   * widget is removed from a container.
   * Note that changing the child visibility of a widget does not
   * queue a resize on the widget. Most of the time, the size of
   * a widget is computed from all visible children, whether or
   * not they are mapped. If this is not the case, the container
   * can queue a resize itself.
   * This function is only useful for container implementations
   * and should never be called by an application.
   * Params:
   *   childVisible = if %TRUE, widget should be mapped along
   *     with its parent.
   */
  void setChildVisible(bool childVisible)
  {
    gtk_widget_set_child_visible(cast(GtkWidget*)cPtr, childVisible);
  }

  /**
   * Clear all style classes applied to widget
   * and replace them with classes.
   * Params:
   *   classes = %NULL-terminated list of style classes to apply to widget.
   */
  void setCssClasses(string[] classes)
  {
    char*[] _tmpclasses;
    foreach (s; classes)
      _tmpclasses ~= s.toCString(false);
    _tmpclasses ~= null;
    const(char*)* _classes = _tmpclasses.ptr;
    gtk_widget_set_css_classes(cast(GtkWidget*)cPtr, _classes);
  }

  /**
   * Sets the cursor to be shown when pointer devices point
   * towards widget.
   * If the cursor is NULL, widget will use the cursor
   * inherited from the parent widget.
   * Params:
   *   cursor = the new cursor
   */
  void setCursor(Cursor cursor)
  {
    gtk_widget_set_cursor(cast(GtkWidget*)cPtr, cursor ? cast(GdkCursor*)cursor.cPtr(false) : null);
  }

  /**
   * Sets a named cursor to be shown when pointer devices point
   * towards widget.
   * This is a utility function that creates a cursor via
   * [Gdk.Cursor.newFromName] and then sets it on widget
   * with [Gtk.Widget.setCursor]. See those functions for
   * details.
   * On top of that, this function allows name to be %NULL, which
   * will do the same as calling [Gtk.Widget.setCursor]
   * with a %NULL cursor.
   * Params:
   *   name = The name of the cursor
   */
  void setCursorFromName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_widget_set_cursor_from_name(cast(GtkWidget*)cPtr, _name);
  }

  /**
   * Sets the reading direction on a particular widget.
   * This direction controls the primary direction for widgets
   * containing text, and also the direction in which the children
   * of a container are packed. The ability to set the direction is
   * present in order so that correct localization into languages with
   * right-to-left reading directions can be done. Generally, applications
   * will let the default reading direction present, except for containers
   * where the containers are arranged in an order that is explicitly
   * visual rather than logical $(LPAREN)such as buttons for text justification$(RPAREN).
   * If the direction is set to %GTK_TEXT_DIR_NONE, then the value
   * set by [Gtk.Widget.setDefaultDirection] will be used.
   * Params:
   *   dir = the new direction
   */
  void setDirection(TextDirection dir)
  {
    gtk_widget_set_direction(cast(GtkWidget*)cPtr, dir);
  }

  /**
   * Set child as the current focus child of widget.
   * This function is only suitable for widget implementations.
   * If you want a certain widget to get the input focus, call
   * [Gtk.Widget.grabFocus] on it.
   * Params:
   *   child = a direct child widget of widget or %NULL
   *     to unset the focus child of widget
   */
  void setFocusChild(Widget child)
  {
    gtk_widget_set_focus_child(cast(GtkWidget*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the widget should grab focus when it is clicked
   * with the mouse.
   * Making mouse clicks not grab focus is useful in places like
   * toolbars where you don’t want the keyboard focus removed from
   * the main area of the application.
   * Params:
   *   focusOnClick = whether the widget should grab focus when clicked
   *     with the mouse
   */
  void setFocusOnClick(bool focusOnClick)
  {
    gtk_widget_set_focus_on_click(cast(GtkWidget*)cPtr, focusOnClick);
  }

  /**
   * Specifies whether widget can own the input focus.
   * Widget implementations should set focusable to %TRUE in
   * their init$(LPAREN)$(RPAREN) function if they want to receive keyboard input.
   * Note that having focusable be %TRUE is only one of the
   * necessary conditions for being focusable. A widget must
   * also be sensitive and can-focus and not have an ancestor
   * that is marked as not can-focus in order to receive input
   * focus.
   * See [Gtk.Widget.grabFocus] for actually setting
   * the input focus on a widget.
   * Params:
   *   focusable = whether or not widget can own the input focus
   */
  void setFocusable(bool focusable)
  {
    gtk_widget_set_focusable(cast(GtkWidget*)cPtr, focusable);
  }

  /**
   * Sets the font map to use for Pango rendering.
   * The font map is the object that is used to look up fonts.
   * Setting a custom font map can be useful in special situations,
   * e.g. when you need to add application-specific fonts to the set
   * of available fonts.
   * When not set, the widget will inherit the font map from its parent.
   * Params:
   *   fontMap = a `PangoFontMap`, or %NULL to unset any
   *     previously set font map
   */
  void setFontMap(FontMap fontMap)
  {
    gtk_widget_set_font_map(cast(GtkWidget*)cPtr, fontMap ? cast(PangoFontMap*)fontMap.cPtr(false) : null);
  }

  /**
   * Sets the `cairo_font_options_t` used for Pango rendering
   * in this widget.
   * When not set, the default font options for the `GdkDisplay`
   * will be used.
   * Params:
   *   options = a `cairo_font_options_t`
   *     to unset any previously set default font options
   */
  void setFontOptions(FontOptions options)
  {
    gtk_widget_set_font_options(cast(GtkWidget*)cPtr, options ? cast(cairo_font_options_t*)options.cPtr(false) : null);
  }

  /**
   * Sets the horizontal alignment of widget.
   * Params:
   *   align_ = the horizontal alignment
   */
  void setHalign(Align align_)
  {
    gtk_widget_set_halign(cast(GtkWidget*)cPtr, align_);
  }

  /**
   * Sets the `has-tooltip` property on widget to has_tooltip.
   * Params:
   *   hasTooltip = whether or not widget has a tooltip.
   */
  void setHasTooltip(bool hasTooltip)
  {
    gtk_widget_set_has_tooltip(cast(GtkWidget*)cPtr, hasTooltip);
  }

  /**
   * Sets whether the widget would like any available extra horizontal
   * space.
   * When a user resizes a `GtkWindow`, widgets with expand\=TRUE
   * generally receive the extra space. For example, a list or
   * scrollable area or document in your window would often be set to
   * expand.
   * Call this function to set the expand flag if you would like your
   * widget to become larger horizontally when the window has extra
   * room.
   * By default, widgets automatically expand if any of their children
   * want to expand. $(LPAREN)To see if a widget will automatically expand given
   * its current children and state, call [Gtk.Widget.computeExpand].
   * A container can decide how the expandability of children affects the
   * expansion of the container by overriding the compute_expand virtual
   * method on `GtkWidget`.$(RPAREN).
   * Setting hexpand explicitly with this function will override the
   * automatic expand behavior.
   * This function forces the widget to expand or not to expand,
   * regardless of children.  The override occurs because
   * [Gtk.Widget.setHexpand] sets the hexpand-set property $(LPAREN)see
   * [Gtk.Widget.setHexpandSet]$(RPAREN) which causes the widget’s hexpand
   * value to be used, rather than looking at children and widget state.
   * Params:
   *   expand = whether to expand
   */
  void setHexpand(bool expand)
  {
    gtk_widget_set_hexpand(cast(GtkWidget*)cPtr, expand);
  }

  /**
   * Sets whether the hexpand flag will be used.
   * The [Gtk.Widget.hexpand] property will be set
   * automatically when you call [Gtk.Widget.setHexpand]
   * to set hexpand, so the most likely reason to use this function
   * would be to unset an explicit expand flag.
   * If hexpand is set, then it overrides any computed
   * expand value based on child widgets. If hexpand is not
   * set, then the expand value depends on whether any
   * children of the widget would like to expand.
   * There are few reasons to use this function, but it’s here
   * for completeness and consistency.
   * Params:
   *   set = value for hexpand-set property
   */
  void setHexpandSet(bool set)
  {
    gtk_widget_set_hexpand_set(cast(GtkWidget*)cPtr, set);
  }

  /**
   * Sets the layout manager delegate instance that provides an
   * implementation for measuring and allocating the children of widget.
   * Params:
   *   layoutManager = a `GtkLayoutManager`
   */
  void setLayoutManager(LayoutManager layoutManager)
  {
    gtk_widget_set_layout_manager(cast(GtkWidget*)cPtr, layoutManager ? cast(GtkLayoutManager*)layoutManager.cPtr(true) : null);
  }

  /**
   * Sets the bottom margin of widget.
   * Params:
   *   margin = the bottom margin
   */
  void setMarginBottom(int margin)
  {
    gtk_widget_set_margin_bottom(cast(GtkWidget*)cPtr, margin);
  }

  /**
   * Sets the end margin of widget.
   * Params:
   *   margin = the end margin
   */
  void setMarginEnd(int margin)
  {
    gtk_widget_set_margin_end(cast(GtkWidget*)cPtr, margin);
  }

  /**
   * Sets the start margin of widget.
   * Params:
   *   margin = the start margin
   */
  void setMarginStart(int margin)
  {
    gtk_widget_set_margin_start(cast(GtkWidget*)cPtr, margin);
  }

  /**
   * Sets the top margin of widget.
   * Params:
   *   margin = the top margin
   */
  void setMarginTop(int margin)
  {
    gtk_widget_set_margin_top(cast(GtkWidget*)cPtr, margin);
  }

  /**
   * Sets a widgets name.
   * Setting a name allows you to refer to the widget from a
   * CSS file. You can apply a style to widgets with a particular name
   * in the CSS file. See the documentation for the CSS syntax $(LPAREN)on the
   * same page as the docs for [Gtk.StyleContext].
   * Note that the CSS syntax has certain special characters to delimit
   * and represent elements in a selector $(LPAREN)period, #, >, *...$(RPAREN), so using
   * these will make your widget impossible to match by name. Any combination
   * of alphanumeric symbols, dashes and underscores will suffice.
   * Params:
   *   name = name for the widget
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_widget_set_name(cast(GtkWidget*)cPtr, _name);
  }

  /**
   * Request the widget to be rendered partially transparent.
   * An opacity of 0 is fully transparent and an opacity of 1
   * is fully opaque.
   * Opacity works on both toplevel widgets and child widgets, although
   * there are some limitations: For toplevel widgets, applying opacity
   * depends on the capabilities of the windowing system. On X11, this
   * has any effect only on X displays with a compositing manager,
   * see [Gdk.Display.isComposited]. On Windows and Wayland it should
   * always work, although setting a window’s opacity after the window
   * has been shown may cause some flicker.
   * Note that the opacity is inherited through inclusion — if you set
   * a toplevel to be partially translucent, all of its content will
   * appear translucent, since it is ultimatively rendered on that
   * toplevel. The opacity value itself is not inherited by child
   * widgets $(LPAREN)since that would make widgets deeper in the hierarchy
   * progressively more translucent$(RPAREN). As a consequence, [Gtk.Popover]s
   * and other [Gtk.Native] widgets with their own surface will use their
   * own opacity value, and thus by default appear non-translucent,
   * even if they are attached to a toplevel that is translucent.
   * Params:
   *   opacity = desired opacity, between 0 and 1
   */
  void setOpacity(double opacity)
  {
    gtk_widget_set_opacity(cast(GtkWidget*)cPtr, opacity);
  }

  /**
   * Sets how widget treats content that is drawn outside the
   * widget's content area.
   * See the definition of [Gtk] for details.
   * This setting is provided for widget implementations and
   * should not be used by application code.
   * The default value is %GTK_OVERFLOW_VISIBLE.
   * Params:
   *   overflow = desired overflow
   */
  void setOverflow(Overflow overflow)
  {
    gtk_widget_set_overflow(cast(GtkWidget*)cPtr, overflow);
  }

  /**
   * Sets parent as the parent widget of widget.
   * This takes care of details such as updating the state and style
   * of the child to reflect its new location and resizing the parent.
   * The opposite function is [Gtk.Widget.unparent].
   * This function is useful only when implementing subclasses of
   * `GtkWidget`.
   * Params:
   *   parent = parent widget
   */
  void setParent(Widget parent)
  {
    gtk_widget_set_parent(cast(GtkWidget*)cPtr, parent ? cast(GtkWidget*)parent.cPtr(false) : null);
  }

  /**
   * Specifies whether widget will be treated as the default
   * widget within its toplevel when it has the focus, even if
   * another widget is the default.
   * Params:
   *   receivesDefault = whether or not widget can be a default widget.
   */
  void setReceivesDefault(bool receivesDefault)
  {
    gtk_widget_set_receives_default(cast(GtkWidget*)cPtr, receivesDefault);
  }

  /**
   * Sets the sensitivity of a widget.
   * A widget is sensitive if the user can interact with it.
   * Insensitive widgets are “grayed out” and the user can’t
   * interact with them. Insensitive widgets are known as
   * “inactive”, “disabled”, or “ghosted” in some other toolkits.
   * Params:
   *   sensitive = %TRUE to make the widget sensitive
   */
  void setSensitive(bool sensitive)
  {
    gtk_widget_set_sensitive(cast(GtkWidget*)cPtr, sensitive);
  }

  /**
   * Sets the minimum size of a widget.
   * That is, the widget’s size request will be at least width
   * by height. You can use this function to force a widget to
   * be larger than it normally would be.
   * In most cases, [Gtk.Window.setDefaultSize] is a better
   * choice for toplevel windows than this function; setting the default
   * size will still allow users to shrink the window. Setting the size
   * request will force them to leave the window at least as large as
   * the size request.
   * Note the inherent danger of setting any fixed size - themes,
   * translations into other languages, different fonts, and user action
   * can all change the appropriate size for a given widget. So, it's
   * basically impossible to hardcode a size that will always be
   * correct.
   * The size request of a widget is the smallest size a widget can
   * accept while still functioning well and drawing itself correctly.
   * However in some strange cases a widget may be allocated less than
   * its requested size, and in many cases a widget may be allocated more
   * space than it requested.
   * If the size request in a given direction is -1 $(LPAREN)unset$(RPAREN), then
   * the “natural” size request of the widget will be used instead.
   * The size request set here does not include any margin from the
   * properties
   * propertyGtk.Widget:margin-start,
   * propertyGtk.Widget:margin-end,
   * propertyGtk.Widget:margin-top, and
   * propertyGtk.Widget:margin-bottom, but it does include pretty
   * much all other padding or border properties set by any subclass
   * of `GtkWidget`.
   * Params:
   *   width = width widget should request, or -1 to unset
   *   height = height widget should request, or -1 to unset
   */
  void setSizeRequest(int width, int height)
  {
    gtk_widget_set_size_request(cast(GtkWidget*)cPtr, width, height);
  }

  /**
   * Turns on flag values in the current widget state.
   * Typical widget states are insensitive, prelighted, etc.
   * This function accepts the values %GTK_STATE_FLAG_DIR_LTR and
   * %GTK_STATE_FLAG_DIR_RTL but ignores them. If you want to set
   * the widget's direction, use [Gtk.Widget.setDirection].
   * This function is for use in widget implementations.
   * Params:
   *   flags = State flags to turn on
   *   clear = Whether to clear state before turning on flags
   */
  void setStateFlags(StateFlags flags, bool clear)
  {
    gtk_widget_set_state_flags(cast(GtkWidget*)cPtr, flags, clear);
  }

  /**
   * Sets markup as the contents of the tooltip, which is marked
   * up with Pango markup.
   * This function will take care of setting the
   * propertyGtk.Widget:has-tooltip as a side effect, and of the
   * default handler for the signalGtk.Widget::query-tooltip signal.
   * See also [Gtk.Tooltip.setMarkup].
   * Params:
   *   markup = the contents of the tooltip for widget
   */
  void setTooltipMarkup(string markup)
  {
    const(char)* _markup = markup.toCString(false);
    gtk_widget_set_tooltip_markup(cast(GtkWidget*)cPtr, _markup);
  }

  /**
   * Sets text as the contents of the tooltip.
   * If text contains any markup, it will be escaped.
   * This function will take care of setting
   * propertyGtk.Widget:has-tooltip as a side effect,
   * and of the default handler for the
   * signalGtk.Widget::query-tooltip signal.
   * See also [Gtk.Tooltip.setText].
   * Params:
   *   text = the contents of the tooltip for widget
   */
  void setTooltipText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_widget_set_tooltip_text(cast(GtkWidget*)cPtr, _text);
  }

  /**
   * Sets the vertical alignment of widget.
   * Params:
   *   align_ = the vertical alignment
   */
  void setValign(Align align_)
  {
    gtk_widget_set_valign(cast(GtkWidget*)cPtr, align_);
  }

  /**
   * Sets whether the widget would like any available extra vertical
   * space.
   * See [Gtk.Widget.setHexpand] for more detail.
   * Params:
   *   expand = whether to expand
   */
  void setVexpand(bool expand)
  {
    gtk_widget_set_vexpand(cast(GtkWidget*)cPtr, expand);
  }

  /**
   * Sets whether the vexpand flag will be used.
   * See [Gtk.Widget.setHexpandSet] for more detail.
   * Params:
   *   set = value for vexpand-set property
   */
  void setVexpandSet(bool set)
  {
    gtk_widget_set_vexpand_set(cast(GtkWidget*)cPtr, set);
  }

  /**
   * Sets the visibility state of widget.
   * Note that setting this to %TRUE doesn’t mean the widget is
   * actually viewable, see [Gtk.Widget.getVisible].
   * Params:
   *   visible = whether the widget should be shown or not
   */
  void setVisible(bool visible)
  {
    gtk_widget_set_visible(cast(GtkWidget*)cPtr, visible);
  }

  /**
   * Returns whether widget should contribute to
   * the measuring and allocation of its parent.
   * This is %FALSE for invisible children, but also
   * for children that have their own surface.
   * Returns: %TRUE if child should be included in
   *   measuring and allocating
   */
  bool shouldLayout()
  {
    bool _retval;
    _retval = gtk_widget_should_layout(cast(GtkWidget*)cPtr);
    return _retval;
  }

  /**
   * Flags a widget to be displayed.
   * Any widget that isn’t shown will not appear on the screen.
   * Remember that you have to show the containers containing a widget,
   * in addition to the widget itself, before it will appear onscreen.
   * When a toplevel container is shown, it is immediately realized and
   * mapped; other shown widgets are realized and mapped when their
   * toplevel container is realized and mapped.

   * Deprecated: Use [Gtk.Widget.setVisible] instead
   */
  void show()
  {
    gtk_widget_show(cast(GtkWidget*)cPtr);
  }

  /**
   * Snapshot the a child of widget.
   * When a widget receives a call to the snapshot function,
   * it must send synthetic vfuncGtk.Widget.snapshot calls
   * to all children. This function provides a convenient way
   * of doing this. A widget, when it receives a call to its
   * vfuncGtk.Widget.snapshot function, calls
   * [Gtk.Widget.snapshotChild] once for each child, passing in
   * the snapshot the widget received.
   * [Gtk.Widget.snapshotChild] takes care of translating the origin of
   * snapshot, and deciding whether the child needs to be snapshot.
   * This function does nothing for children that implement `GtkNative`.
   * Params:
   *   child = a child of widget
   *   snapshot = `GtkSnapshot` as passed to the widget. In particular, no
   *     calls to [Gtk.Snapshot.translate] or other transform calls should
   *     have been made.
   */
  void snapshotChild(Widget child, Snapshot snapshot)
  {
    gtk_widget_snapshot_child(cast(GtkWidget*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, snapshot ? cast(GtkSnapshot*)snapshot.cPtr(false) : null);
  }

  /**
   * Translate coordinates relative to src_widget’s allocation
   * to coordinates relative to dest_widget’s allocations.
   * In order to perform this operation, both widget must share
   * a common ancestor.
   * Params:
   *   destWidget = a `GtkWidget`
   *   srcX = X position relative to src_widget
   *   srcY = Y position relative to src_widget
   *   destX = location to store X position relative to dest_widget
   *   destY = location to store Y position relative to dest_widget
   * Returns: %FALSE if src_widget and dest_widget have no common
   *   ancestor. In this case, 0 is stored in *dest_x and *dest_y.
   *   Otherwise %TRUE.

   * Deprecated: Use [Gtk.Widget.computePoint] instead
   */
  bool translateCoordinates(Widget destWidget, double srcX, double srcY, out double destX, out double destY)
  {
    bool _retval;
    _retval = gtk_widget_translate_coordinates(cast(GtkWidget*)cPtr, destWidget ? cast(GtkWidget*)destWidget.cPtr(false) : null, srcX, srcY, cast(double*)&destX, cast(double*)&destY);
    return _retval;
  }

  /**
   * Triggers a tooltip query on the display where the toplevel
   * of widget is located.
   */
  void triggerTooltipQuery()
  {
    gtk_widget_trigger_tooltip_query(cast(GtkWidget*)cPtr);
  }

  /**
   * Causes a widget to be unmapped if it’s currently mapped.
   * This function is only for use in widget implementations.
   */
  void unmap()
  {
    gtk_widget_unmap(cast(GtkWidget*)cPtr);
  }

  /**
   * Dissociate widget from its parent.
   * This function is only for use in widget implementations,
   * typically in dispose.
   */
  void unparent()
  {
    gtk_widget_unparent(cast(GtkWidget*)cPtr);
  }

  /**
   * Causes a widget to be unrealized $(LPAREN)frees all GDK resources
   * associated with the widget$(RPAREN).
   * This function is only useful in widget implementations.
   */
  void unrealize()
  {
    gtk_widget_unrealize(cast(GtkWidget*)cPtr);
  }

  /**
   * Turns off flag values for the current widget state.
   * See [Gtk.Widget.setStateFlags].
   * This function is for use in widget implementations.
   * Params:
   *   flags = State flags to turn off
   */
  void unsetStateFlags(StateFlags flags)
  {
    gtk_widget_unset_state_flags(cast(GtkWidget*)cPtr, flags);
  }

  /**
   * Signals that all holders of a reference to the widget should release
   * the reference that they hold.
   * May result in finalization of the widget if all references are released.
   * This signal is not suitable for saving widget state.
   *   widget = the instance the signal is connected to
   */
  alias DestroyCallback = void delegate(Widget widget);

  /**
   * Connect to Destroy signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDestroy(DestroyCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("destroy", closure, after);
  }

  /**
   * Emitted when the text direction of a widget changes.
   * Params
   *   previousDirection = the previous text direction of widget
   *   widget = the instance the signal is connected to
   */
  alias DirectionChangedCallback = void delegate(TextDirection previousDirection, Widget widget);

  /**
   * Connect to DirectionChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDirectionChanged(DirectionChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      auto previousDirection = getVal!TextDirection(&_paramVals[1]);
      _dgClosure.dlg(previousDirection, widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("direction-changed", closure, after);
  }

  /**
   * Emitted when widget is hidden.
   *   widget = the instance the signal is connected to
   */
  alias HideCallback = void delegate(Widget widget);

  /**
   * Connect to Hide signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectHide(HideCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("hide", closure, after);
  }

  /**
   * Emitted if keyboard navigation fails.
   * See [Gtk.Widget.keynavFailed] for details.
   * Params
   *   direction = the direction of movement
   *   widget = the instance the signal is connected to
   * Returns: %TRUE if stopping keyboard navigation is fine, %FALSE
   *   if the emitting widget should try to handle the keyboard
   *   navigation attempt in its parent widget$(LPAREN)s$(RPAREN).
   */
  alias KeynavFailedCallback = bool delegate(DirectionType direction, Widget widget);

  /**
   * Connect to KeynavFailed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectKeynavFailed(KeynavFailedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto widget = getVal!Widget(_paramVals);
      auto direction = getVal!DirectionType(&_paramVals[1]);
      _retval = _dgClosure.dlg(direction, widget);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("keynav-failed", closure, after);
  }

  /**
   * Emitted when widget is going to be mapped.
   * A widget is mapped when the widget is visible $(LPAREN)which is controlled with
   * [Gtk.Widget.visible]$(RPAREN) and all its parents up to the toplevel widget
   * are also visible.
   * The ::map signal can be used to determine whether a widget will be drawn,
   * for instance it can resume an animation that was stopped during the
   * emission of [Gtk.Widget.unmap].
   *   widget = the instance the signal is connected to
   */
  alias MapCallback = void delegate(Widget widget);

  /**
   * Connect to Map signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMap(MapCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("map", closure, after);
  }

  /**
   * Emitted when a widget is activated via a mnemonic.
   * The default handler for this signal activates widget if group_cycling
   * is %FALSE, or just makes widget grab focus if group_cycling is %TRUE.
   * Params
   *   groupCycling = %TRUE if there are other widgets with the same mnemonic
   *   widget = the instance the signal is connected to
   * Returns: %TRUE to stop other handlers from being invoked for the event.
   *   %FALSE to propagate the event further.
   */
  alias MnemonicActivateCallback = bool delegate(bool groupCycling, Widget widget);

  /**
   * Connect to MnemonicActivate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMnemonicActivate(MnemonicActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto widget = getVal!Widget(_paramVals);
      auto groupCycling = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(groupCycling, widget);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mnemonic-activate", closure, after);
  }

  /**
   * Emitted when the focus is moved.
   * The ::move-focus signal is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are <kbd>Tab</kbd> to move forward,
   * and <kbd>Shift</kbd>+<kbd>Tab</kbd> to move backward.
   * Params
   *   direction = the direction of the focus move
   *   widget = the instance the signal is connected to
   */
  alias MoveFocusCallback = void delegate(DirectionType direction, Widget widget);

  /**
   * Connect to MoveFocus signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveFocus(MoveFocusCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      auto direction = getVal!DirectionType(&_paramVals[1]);
      _dgClosure.dlg(direction, widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-focus", closure, after);
  }

  /**
   * Emitted when the widget’s tooltip is about to be shown.
   * This happens when the propertyGtk.Widget:has-tooltip property
   * is %TRUE and the hover timeout has expired with the cursor hovering
   * "above" widget; or emitted when widget got focus in keyboard mode.
   * Using the given coordinates, the signal handler should determine
   * whether a tooltip should be shown for widget. If this is the case
   * %TRUE should be returned, %FALSE otherwise.  Note that if
   * keyboard_mode is %TRUE, the values of x and y are undefined and
   * should not be used.
   * The signal handler is free to manipulate tooltip with the therefore
   * destined function calls.
   * Params
   *   x = the x coordinate of the cursor position where the request has
   *     been emitted, relative to widget's left side
   *   y = the y coordinate of the cursor position where the request has
   *     been emitted, relative to widget's top
   *   keyboardMode = %TRUE if the tooltip was triggered using the keyboard
   *   tooltip = a `GtkTooltip`
   *   widget = the instance the signal is connected to
   * Returns: %TRUE if tooltip should be shown right now, %FALSE otherwise.
   */
  alias QueryTooltipCallback = bool delegate(int x, int y, bool keyboardMode, Tooltip tooltip, Widget widget);

  /**
   * Connect to QueryTooltip signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectQueryTooltip(QueryTooltipCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto widget = getVal!Widget(_paramVals);
      auto x = getVal!int(&_paramVals[1]);
      auto y = getVal!int(&_paramVals[2]);
      auto keyboardMode = getVal!bool(&_paramVals[3]);
      auto tooltip = getVal!Tooltip(&_paramVals[4]);
      _retval = _dgClosure.dlg(x, y, keyboardMode, tooltip, widget);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("query-tooltip", closure, after);
  }

  /**
   * Emitted when widget is associated with a `GdkSurface`.
   * This means that [Gtk.Widget.realize] has been called
   * or the widget has been mapped $(LPAREN)that is, it is going to be drawn$(RPAREN).
   *   widget = the instance the signal is connected to
   */
  alias RealizeCallback = void delegate(Widget widget);

  /**
   * Connect to Realize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRealize(RealizeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("realize", closure, after);
  }

  /**
   * Emitted when widget is shown.
   *   widget = the instance the signal is connected to
   */
  alias ShowCallback = void delegate(Widget widget);

  /**
   * Connect to Show signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectShow(ShowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("show", closure, after);
  }

  /**
   * Emitted when the widget state changes.
   * See [Gtk.Widget.getStateFlags].
   * Params
   *   flags = The previous state flags.
   *   widget = the instance the signal is connected to
   */
  alias StateFlagsChangedCallback = void delegate(StateFlags flags, Widget widget);

  /**
   * Connect to StateFlagsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStateFlagsChanged(StateFlagsChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      auto flags = getVal!StateFlags(&_paramVals[1]);
      _dgClosure.dlg(flags, widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("state-flags-changed", closure, after);
  }

  /**
   * Emitted when widget is going to be unmapped.
   * A widget is unmapped when either it or any of its parents up to the
   * toplevel widget have been set as hidden.
   * As ::unmap indicates that a widget will not be shown any longer,
   * it can be used to, for example, stop an animation on the widget.
   *   widget = the instance the signal is connected to
   */
  alias UnmapCallback = void delegate(Widget widget);

  /**
   * Connect to Unmap signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnmap(UnmapCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unmap", closure, after);
  }

  /**
   * Emitted when the `GdkSurface` associated with widget is destroyed.
   * This means that [Gtk.Widget.unrealize] has been called
   * or the widget has been unmapped $(LPAREN)that is, it is going to be hidden$(RPAREN).
   *   widget = the instance the signal is connected to
   */
  alias UnrealizeCallback = void delegate(Widget widget);

  /**
   * Connect to Unrealize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnrealize(UnrealizeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto widget = getVal!Widget(_paramVals);
      _dgClosure.dlg(widget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unrealize", closure, after);
  }
}
