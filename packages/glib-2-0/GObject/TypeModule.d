module GObject.TypeModule;

import GObject.EnumValue;
import GObject.FlagsValue;
import GObject.ObjectG;
import GObject.TypeInfoG;
import GObject.TypePlugin;
import GObject.TypePluginT;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * `GTypeModule` provides a simple implementation of the `GTypePlugin`
 * interface.
 * The model of `GTypeModule` is a dynamically loaded module which
 * implements some number of types and interface implementations.
 * When the module is loaded, it registers its types and interfaces
 * using [GObject.TypeModule.registerType] and
 * [GObject.TypeModule.addInterface].
 * As long as any instances of these types and interface implementations
 * are in use, the module is kept loaded. When the types and interfaces
 * are gone, the module may be unloaded. If the types and interfaces
 * become used again, the module will be reloaded. Note that the last
 * reference cannot be released from within the module code, since that
 * would lead to the caller's code being unloaded before `[GObject.ObjectG.unref]`
 * returns to it.
 * Keeping track of whether the module should be loaded or not is done by
 * using a use count - it starts at zero, and whenever it is greater than
 * zero, the module is loaded. The use count is maintained internally by
 * the type system, but also can be explicitly controlled by
 * [GObject.TypeModule.use] and [GObject.TypeModule.unuse].
 * Typically, when loading a module for the first type, `[GObject.TypeModule.use]`
 * will be used to load it so that it can initialize its types. At some later
 * point, when the module no longer needs to be loaded except for the type
 * implementations it contains, `[GObject.TypeModule.unuse]` is called.
 * `GTypeModule` does not actually provide any implementation of module
 * loading and unloading. To create a particular module type you must
 * derive from `GTypeModule` and implement the load and unload functions
 * in `GTypeModuleClass`.
 */
class TypeModule : ObjectG, TypePlugin
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
    return g_type_module_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin TypePluginT!();

  /**
   * Registers an additional interface for a type, whose interface lives
   * in the given type plugin. If the interface was already registered
   * for the type in this plugin, nothing will be done.
   * As long as any instances of the type exist, the type plugin will
   * not be unloaded.
   * Since 2.56 if module is %NULL this will call [GObject.Global.typeAddInterfaceStatic]
   * instead. This can be used when making a static build of the module.
   * Params:
   *   instanceType = type to which to add the interface.
   *   interfaceType = interface type to add
   *   interfaceInfo = type information structure
   */
  void addInterface(GType instanceType, GType interfaceType, InterfaceInfo interfaceInfo)
  {
    g_type_module_add_interface(cast(GTypeModule*)cPtr, instanceType, interfaceType, &interfaceInfo);
  }

  /**
   * Looks up or registers an enumeration that is implemented with a particular
   * type plugin. If a type with name type_name was previously registered,
   * the #GType identifier for the type is returned, otherwise the type
   * is newly registered, and the resulting #GType identifier returned.
   * As long as any instances of the type exist, the type plugin will
   * not be unloaded.
   * Since 2.56 if module is %NULL this will call [GObject.Global.typeRegisterStatic]
   * instead. This can be used when making a static build of the module.
   * Params:
   *   name = name for the type
   *   constStaticValues = an array of #GEnumValue structs for the
   *     possible enumeration values. The array is
   *     terminated by a struct with all members being
   *     0.
   * Returns: the new or existing type ID
   */
  GType registerEnum(string name, EnumValue constStaticValues)
  {
    GType _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_type_module_register_enum(cast(GTypeModule*)cPtr, _name, constStaticValues ? cast(GEnumValue*)constStaticValues.cPtr : null);
    return _retval;
  }

  /**
   * Looks up or registers a flags type that is implemented with a particular
   * type plugin. If a type with name type_name was previously registered,
   * the #GType identifier for the type is returned, otherwise the type
   * is newly registered, and the resulting #GType identifier returned.
   * As long as any instances of the type exist, the type plugin will
   * not be unloaded.
   * Since 2.56 if module is %NULL this will call [GObject.Global.typeRegisterStatic]
   * instead. This can be used when making a static build of the module.
   * Params:
   *   name = name for the type
   *   constStaticValues = an array of #GFlagsValue structs for the
   *     possible flags values. The array is
   *     terminated by a struct with all members being
   *     0.
   * Returns: the new or existing type ID
   */
  GType registerFlags(string name, FlagsValue constStaticValues)
  {
    GType _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_type_module_register_flags(cast(GTypeModule*)cPtr, _name, constStaticValues ? cast(GFlagsValue*)constStaticValues.cPtr : null);
    return _retval;
  }

  /**
   * Looks up or registers a type that is implemented with a particular
   * type plugin. If a type with name type_name was previously registered,
   * the #GType identifier for the type is returned, otherwise the type
   * is newly registered, and the resulting #GType identifier returned.
   * When reregistering a type $(LPAREN)typically because a module is unloaded
   * then reloaded, and reinitialized$(RPAREN), module and parent_type must
   * be the same as they were previously.
   * As long as any instances of the type exist, the type plugin will
   * not be unloaded.
   * Since 2.56 if module is %NULL this will call [GObject.Global.typeRegisterStatic]
   * instead. This can be used when making a static build of the module.
   * Params:
   *   parentType = the type for the parent class
   *   typeName = name for the type
   *   typeInfo = type information structure
   *   flags = flags field providing details about the type
   * Returns: the new or existing type ID
   */
  GType registerType(GType parentType, string typeName, TypeInfoG typeInfo, TypeFlags flags)
  {
    GType _retval;
    const(char)* _typeName = typeName.toCString(false);
    _retval = g_type_module_register_type(cast(GTypeModule*)cPtr, parentType, _typeName, typeInfo ? cast(GTypeInfo*)typeInfo.cPtr : null, flags);
    return _retval;
  }

  /**
   * Sets the name for a #GTypeModule
   * Params:
   *   name = a human-readable name to use in error messages.
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_type_module_set_name(cast(GTypeModule*)cPtr, _name);
  }

  /**
   * Decreases the use count of a #GTypeModule by one. If the
   * result is zero, the module will be unloaded. $(LPAREN)However, the
   * #GTypeModule will not be freed, and types associated with the
   * #GTypeModule are not unregistered. Once a #GTypeModule is
   * initialized, it must exist forever.$(RPAREN)
   */
  void unuse()
  {
    g_type_module_unuse(cast(GTypeModule*)cPtr);
  }

  /**
   * Increases the use count of a #GTypeModule by one. If the
   * use count was zero before, the plugin will be loaded.
   * If loading the plugin fails, the use count is reset to
   * its prior value.
   * Returns: %FALSE if the plugin needed to be loaded and
   *   loading the plugin failed.
   */
  bool use()
  {
    bool _retval;
    _retval = g_type_module_use(cast(GTypeModule*)cPtr);
    return _retval;
  }
}
