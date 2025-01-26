module Gtk.WidgetClass;

import GLib.VariantType;
import GObject.InitiallyUnownedClass;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.BuilderScope;
import Gtk.BuilderScopeT;
import Gtk.Shortcut;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class WidgetClass
{
  GtkWidgetClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.WidgetClass");

    cInstance = *cast(GtkWidgetClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property InitiallyUnownedClass parentClass()
  {
    return new InitiallyUnownedClass(cast(GInitiallyUnownedClass*)&(cast(GtkWidgetClass*)cPtr).parentClass);
  }

  alias ShowFuncType = extern(C) void function(GtkWidget* widget);

  @property ShowFuncType show()
  {
    return (cast(GtkWidgetClass*)cPtr).show;
  }

  alias HideFuncType = extern(C) void function(GtkWidget* widget);

  @property HideFuncType hide()
  {
    return (cast(GtkWidgetClass*)cPtr).hide;
  }

  alias MapFuncType = extern(C) void function(GtkWidget* widget);

  @property MapFuncType map()
  {
    return (cast(GtkWidgetClass*)cPtr).map;
  }

  alias UnmapFuncType = extern(C) void function(GtkWidget* widget);

  @property UnmapFuncType unmap()
  {
    return (cast(GtkWidgetClass*)cPtr).unmap;
  }

  alias RealizeFuncType = extern(C) void function(GtkWidget* widget);

  @property RealizeFuncType realize()
  {
    return (cast(GtkWidgetClass*)cPtr).realize;
  }

  alias UnrealizeFuncType = extern(C) void function(GtkWidget* widget);

  @property UnrealizeFuncType unrealize()
  {
    return (cast(GtkWidgetClass*)cPtr).unrealize;
  }

  alias RootFuncType = extern(C) void function(GtkWidget* widget);

  @property RootFuncType root()
  {
    return (cast(GtkWidgetClass*)cPtr).root;
  }

  alias UnrootFuncType = extern(C) void function(GtkWidget* widget);

  @property UnrootFuncType unroot()
  {
    return (cast(GtkWidgetClass*)cPtr).unroot;
  }

  alias SizeAllocateFuncType = extern(C) void function(GtkWidget* widget, int width, int height, int baseline);

  @property SizeAllocateFuncType sizeAllocate()
  {
    return (cast(GtkWidgetClass*)cPtr).sizeAllocate;
  }

  alias StateFlagsChangedFuncType = extern(C) void function(GtkWidget* widget, GtkStateFlags previousStateFlags);

  @property StateFlagsChangedFuncType stateFlagsChanged()
  {
    return (cast(GtkWidgetClass*)cPtr).stateFlagsChanged;
  }

  alias DirectionChangedFuncType = extern(C) void function(GtkWidget* widget, GtkTextDirection previousDirection);

  @property DirectionChangedFuncType directionChanged()
  {
    return (cast(GtkWidgetClass*)cPtr).directionChanged;
  }

  alias GetRequestModeFuncType = extern(C) GtkSizeRequestMode function(GtkWidget* widget);

  @property GetRequestModeFuncType getRequestMode()
  {
    return (cast(GtkWidgetClass*)cPtr).getRequestMode;
  }

  alias MeasureFuncType = extern(C) void function(GtkWidget* widget, GtkOrientation orientation, int forSize, int* minimum, int* natural, int* minimumBaseline, int* naturalBaseline);

  @property MeasureFuncType measure()
  {
    return (cast(GtkWidgetClass*)cPtr).measure;
  }

  alias MnemonicActivateFuncType = extern(C) bool function(GtkWidget* widget, bool groupCycling);

  @property MnemonicActivateFuncType mnemonicActivate()
  {
    return (cast(GtkWidgetClass*)cPtr).mnemonicActivate;
  }

  alias GrabFocusFuncType = extern(C) bool function(GtkWidget* widget);

  @property GrabFocusFuncType grabFocus()
  {
    return (cast(GtkWidgetClass*)cPtr).grabFocus;
  }

  alias FocusFuncType = extern(C) bool function(GtkWidget* widget, GtkDirectionType direction);

  @property FocusFuncType focus()
  {
    return (cast(GtkWidgetClass*)cPtr).focus;
  }

  alias SetFocusChildFuncType = extern(C) void function(GtkWidget* widget, GtkWidget* child);

  @property SetFocusChildFuncType setFocusChild()
  {
    return (cast(GtkWidgetClass*)cPtr).setFocusChild;
  }

  alias MoveFocusFuncType = extern(C) void function(GtkWidget* widget, GtkDirectionType direction);

  @property MoveFocusFuncType moveFocus()
  {
    return (cast(GtkWidgetClass*)cPtr).moveFocus;
  }

  alias KeynavFailedFuncType = extern(C) bool function(GtkWidget* widget, GtkDirectionType direction);

  @property KeynavFailedFuncType keynavFailed()
  {
    return (cast(GtkWidgetClass*)cPtr).keynavFailed;
  }

  alias QueryTooltipFuncType = extern(C) bool function(GtkWidget* widget, int x, int y, bool keyboardTooltip, GtkTooltip* tooltip);

  @property QueryTooltipFuncType queryTooltip()
  {
    return (cast(GtkWidgetClass*)cPtr).queryTooltip;
  }

  alias ComputeExpandFuncType = extern(C) void function(GtkWidget* widget, bool* hexpandP, bool* vexpandP);

  @property ComputeExpandFuncType computeExpand()
  {
    return (cast(GtkWidgetClass*)cPtr).computeExpand;
  }

  alias CssChangedFuncType = extern(C) void function(GtkWidget* widget, GtkCssStyleChange* change);

  @property CssChangedFuncType cssChanged()
  {
    return (cast(GtkWidgetClass*)cPtr).cssChanged;
  }

  alias SystemSettingChangedFuncType = extern(C) void function(GtkWidget* widget, GtkSystemSetting settings);

  @property SystemSettingChangedFuncType systemSettingChanged()
  {
    return (cast(GtkWidgetClass*)cPtr).systemSettingChanged;
  }

  alias SnapshotFuncType = extern(C) void function(GtkWidget* widget, GtkSnapshot* snapshot);

  @property SnapshotFuncType snapshot()
  {
    return (cast(GtkWidgetClass*)cPtr).snapshot;
  }

  alias ContainsFuncType = extern(C) bool function(GtkWidget* widget, double x, double y);

  @property ContainsFuncType contains()
  {
    return (cast(GtkWidgetClass*)cPtr).contains;
  }

  /**
   * Installs a shortcut in widget_class.
   * Every instance created for widget_class or its subclasses will
   * inherit this shortcut and trigger it.
   * Shortcuts added this way will be triggered in the %GTK_PHASE_BUBBLE
   * phase, which means they may also trigger if child widgets have focus.
   * This function must only be used in class initialization functions
   * otherwise it is not guaranteed that the shortcut will be installed.
   * Params:
   *   shortcut = the `GtkShortcut` to add
   */
  void addShortcut(Shortcut shortcut)
  {
    gtk_widget_class_add_shortcut(cast(GtkWidgetClass*)cPtr, shortcut ? cast(GtkShortcut*)shortcut.cPtr(false) : null);
  }

  /**
   * Automatically assign an object declared in the class template XML to
   * be set to a location on a freshly built instance’s private data, or
   * alternatively accessible via [Gtk.Widget.getTemplateChild].
   * The struct can point either into the public instance, then you should
   * use `G_STRUCT_OFFSET$(LPAREN)WidgetType, member$(RPAREN)` for struct_offset, or in the
   * private struct, then you should use `G_PRIVATE_OFFSET$(LPAREN)WidgetType, member$(RPAREN)`.
   * An explicit strong reference will be held automatically for the duration
   * of your instance’s life cycle, it will be released automatically when
   * `GObjectClass.dispose$(LPAREN)$(RPAREN)` runs on your instance and if a struct_offset
   * that is `!\= 0` is specified, then the automatic location in your instance
   * public or private data will be set to %NULL. You can however access an
   * automated child pointer the first time your classes `GObjectClass.dispose$(LPAREN)$(RPAREN)`
   * runs, or alternatively in [Gtk.Widget.destroy].
   * If internal_child is specified, vfuncGtk.Buildable.get_internal_child
   * will be automatically implemented by the `GtkWidget` class so there is no
   * need to implement it manually.
   * The wrapper macros funcGtk.widget_class_bind_template_child,
   * funcGtk.widget_class_bind_template_child_internal,
   * funcGtk.widget_class_bind_template_child_private and
   * funcGtk.widget_class_bind_template_child_internal_private
   * might be more convenient to use.
   * Note that this must be called from a composite widget classes class
   * initializer after calling [Gtk.WidgetClass.setTemplate].
   * Params:
   *   name = The “id” of the child defined in the template XML
   *   internalChild = Whether the child should be accessible as an “internal-child”
   *     when this class is used in GtkBuilder XML
   *   structOffset = The structure offset into the composite widget’s instance
   *     public or private structure where the automated child pointer should be set,
   *     or 0 to not assign the pointer.
   */
  void bindTemplateChildFull(string name, bool internalChild, ptrdiff_t structOffset)
  {
    const(char)* _name = name.toCString(false);
    gtk_widget_class_bind_template_child_full(cast(GtkWidgetClass*)cPtr, _name, internalChild, structOffset);
  }

  /**
   * Retrieves the accessible role used by the given `GtkWidget` class.
   * Different accessible roles have different states, and are rendered
   * differently by assistive technologies.
   * See also: [Gtk.Accessible.getAccessibleRole].
   * Returns: the accessible role for the widget class
   */
  AccessibleRole getAccessibleRole()
  {
    GtkAccessibleRole _cretval;
    _cretval = gtk_widget_class_get_accessible_role(cast(GtkWidgetClass*)cPtr);
    AccessibleRole _retval = cast(AccessibleRole)_cretval;
    return _retval;
  }

  /**
   * Retrieves the signal id for the activation signal.
   * the activation signal is set using
   * [Gtk.WidgetClass.setActivateSignal].
   * Returns: a signal id, or 0 if the widget class does not
   *   specify an activation signal
   */
  uint getActivateSignal()
  {
    uint _retval;
    _retval = gtk_widget_class_get_activate_signal(cast(GtkWidgetClass*)cPtr);
    return _retval;
  }

  /**
   * Gets the name used by this class for matching in CSS code.
   * See [Gtk.WidgetClass.setCssName] for details.
   * Returns: the CSS name of the given class
   */
  string getCssName()
  {
    const(char)* _cretval;
    _cretval = gtk_widget_class_get_css_name(cast(GtkWidgetClass*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the type of the [Gtk.LayoutManager]
   * used by widgets of class widget_class.
   * See also: [Gtk.WidgetClass.setLayoutManagerType].
   * Returns: type of a `GtkLayoutManager` subclass, or %G_TYPE_INVALID
   */
  GType getLayoutManagerType()
  {
    GType _retval;
    _retval = gtk_widget_class_get_layout_manager_type(cast(GtkWidgetClass*)cPtr);
    return _retval;
  }

  /**
   * Installs an action called action_name on widget_class and
   * binds its state to the value of the property_name property.
   * This function will perform a few sanity checks on the property selected
   * via property_name. Namely, the property must exist, must be readable,
   * writable and must not be construct-only. There are also restrictions
   * on the type of the given property, it must be boolean, int, unsigned int,
   * double or string. If any of these conditions are not met, a critical
   * warning will be printed and no action will be added.
   * The state type of the action matches the property type.
   * If the property is boolean, the action will have no parameter and
   * toggle the property value. Otherwise, the action will have a parameter
   * of the same type as the property.
   * Params:
   *   actionName = name of the action
   *   propertyName = name of the property in instances of widget_class
   *     or any parent class.
   */
  void installPropertyAction(string actionName, string propertyName)
  {
    const(char)* _actionName = actionName.toCString(false);
    const(char)* _propertyName = propertyName.toCString(false);
    gtk_widget_class_install_property_action(cast(GtkWidgetClass*)cPtr, _actionName, _propertyName);
  }

  /**
   * Returns details about the index_-th action that has been
   * installed for widget_class during class initialization.
   * See [Gtk.WidgetClass.installAction] for details on
   * how to install actions.
   * Note that this function will also return actions defined
   * by parent classes. You can identify those by looking
   * at owner.
   * Params:
   *   index = position of the action to query
   *   owner = return location for the type where the action was defined
   *   actionName = return location for the action name
   *   parameterType = return location for the parameter type
   *   propertyName = return location for the property name
   * Returns: %TRUE if the action was found, %FALSE if index_
   *   is out of range
   */
  bool queryAction(uint index, out GType owner, out string actionName, out VariantType parameterType, out string propertyName)
  {
    bool _retval;
    char* _actionName;
    const(GVariantType)* _parameterType;
    char* _propertyName;
    _retval = gtk_widget_class_query_action(cast(GtkWidgetClass*)cPtr, index, cast(GType*)&owner, &_actionName, &_parameterType, &_propertyName);
    actionName = _actionName.fromCString(false);
    parameterType = new VariantType(cast(void*)_parameterType, false);
    propertyName = _propertyName.fromCString(false);
    return _retval;
  }

  /**
   * Sets the accessible role used by the given `GtkWidget` class.
   * Different accessible roles have different states, and are
   * rendered differently by assistive technologies.
   * Params:
   *   accessibleRole = the `GtkAccessibleRole` used by the widget_class
   */
  void setAccessibleRole(AccessibleRole accessibleRole)
  {
    gtk_widget_class_set_accessible_role(cast(GtkWidgetClass*)cPtr, accessibleRole);
  }

  /**
   * Sets the `GtkWidgetClass.activate_signal` field with the
   * given signal_id.
   * The signal will be emitted when calling [Gtk.Widget.activate].
   * The signal_id must have been registered with `[GObject.Global.signalNew]`
   * or [GObject.Global.signalNewv] before calling this function.
   * Params:
   *   signalId = the id for the activate signal
   */
  void setActivateSignal(uint signalId)
  {
    gtk_widget_class_set_activate_signal(cast(GtkWidgetClass*)cPtr, signalId);
  }

  /**
   * Sets the `GtkWidgetClass.activate_signal` field with the signal id for
   * the given signal_name.
   * The signal will be emitted when calling [Gtk.Widget.activate].
   * The signal_name of widget_type must have been registered with
   * [GObject.Global.signalNew] or [GObject.Global.signalNewv] before calling this function.
   * Params:
   *   signalName = the name of the activate signal of widget_type
   */
  void setActivateSignalFromName(string signalName)
  {
    const(char)* _signalName = signalName.toCString(false);
    gtk_widget_class_set_activate_signal_from_name(cast(GtkWidgetClass*)cPtr, _signalName);
  }

  /**
   * Sets the name to be used for CSS matching of widgets.
   * If this function is not called for a given class, the name
   * set on the parent class is used. By default, `GtkWidget`
   * uses the name "widget".
   * Params:
   *   name = name to use
   */
  void setCssName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_widget_class_set_css_name(cast(GtkWidgetClass*)cPtr, _name);
  }

  /**
   * Sets the type to be used for creating layout managers for
   * widgets of widget_class.
   * The given type must be a subtype of [Gtk.LayoutManager].
   * This function should only be called from class init functions
   * of widgets.
   * Params:
   *   type = The object type that implements the `GtkLayoutManager`
   *     for widget_class
   */
  void setLayoutManagerType(GType type)
  {
    gtk_widget_class_set_layout_manager_type(cast(GtkWidgetClass*)cPtr, type);
  }

  /**
   * A convenience function that calls [Gtk.WidgetClass.setTemplate]
   * with the contents of a `GResource`.
   * Note that any class that installs templates must call
   * [Gtk.Widget.initTemplate] in the widget’s instance
   * initializer.
   * Params:
   *   resourceName = The name of the resource to load the template from
   */
  void setTemplateFromResource(string resourceName)
  {
    const(char)* _resourceName = resourceName.toCString(false);
    gtk_widget_class_set_template_from_resource(cast(GtkWidgetClass*)cPtr, _resourceName);
  }

  /**
   * For use in language bindings, this will override the default
   * `GtkBuilderScope` to be used when parsing GtkBuilder XML from
   * this class’s template data.
   * Note that this must be called from a composite widget classes class
   * initializer after calling [Gtk.WidgetClass.setTemplate].
   * Params:
   *   scope_ = The `GtkBuilderScope` to use when loading
   *     the class template
   */
  void setTemplateScope(BuilderScope scope_)
  {
    gtk_widget_class_set_template_scope(cast(GtkWidgetClass*)cPtr, scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(false) : null);
  }
}
