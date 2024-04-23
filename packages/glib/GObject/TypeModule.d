module GObject.TypeModule;

import GObject.EnumValue;
import GObject.FlagsValue;
import GObject.ObjectG;
import GObject.TypeInfoG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * #GTypeModule provides a simple implementation of the #GTypePlugin
 * interface.
 *
 * The model of #GTypeModule is a dynamically loaded module which
 * implements some number of types and interface implementations.
 *
 * When the module is loaded, it registers its types and interfaces
 * using g_type_module_register_type() and g_type_module_add_interface().
 * As long as any instances of these types and interface implementations
 * are in use, the module is kept loaded. When the types and interfaces
 * are gone, the module may be unloaded. If the types and interfaces
 * become used again, the module will be reloaded. Note that the last
 * reference cannot be released from within the module code, since that
 * would lead to the caller's code being unloaded before g_object_unref()
 * returns to it.
 *
 * Keeping track of whether the module should be loaded or not is done by
 * using a use count - it starts at zero, and whenever it is greater than
 * zero, the module is loaded. The use count is maintained internally by
 * the type system, but also can be explicitly controlled by
 * g_type_module_use() and g_type_module_unuse(). Typically, when loading
 * a module for the first type, g_type_module_use() will be used to load
 * it so that it can initialize its types. At some later point, when the
 * module no longer needs to be loaded except for the type
 * implementations it contains, g_type_module_unuse() is called.
 *
 * #GTypeModule does not actually provide any implementation of module
 * loading and unloading. To create a particular module type you must
 * derive from #GTypeModule and implement the load and unload functions
 * in #GTypeModuleClass.
 */
class TypeModule : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_type_module_get_type();
  }

  /**
   * Registers an additional interface for a type, whose interface lives
   * in the given type plugin. If the interface was already registered
   * for the type in this plugin, nothing will be done.
   *
   * As long as any instances of the type exist, the type plugin will
   * not be unloaded.
   *
   * Since 2.56 if @module is %NULL this will call g_type_add_interface_static()
   * instead. This can be used when making a static build of the module.
   */
  void addInterface(GType instanceType, GType interfaceType, InterfaceInfo interfaceInfo)
  {
    g_type_module_add_interface(cPtr!GTypeModule, instanceType, interfaceType, &interfaceInfo);
  }

  /**
   * the new or existing type ID
   */
  GType registerEnum(string name, EnumValue constStaticValues)
  {
    GType _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_type_module_register_enum(cPtr!GTypeModule, _name, constStaticValues ? constStaticValues.cPtr!GEnumValue : null);
    return _retval;
  }

  /**
   * the new or existing type ID
   */
  GType registerFlags(string name, FlagsValue constStaticValues)
  {
    GType _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_type_module_register_flags(cPtr!GTypeModule, _name, constStaticValues ? constStaticValues.cPtr!GFlagsValue : null);
    return _retval;
  }

  /**
   * the new or existing type ID
   */
  GType registerType(GType parentType, string typeName, TypeInfoG typeInfo, TypeFlags flags)
  {
    GType _retval;
    const(char)* _typeName = typeName.toCString(false);
    _retval = g_type_module_register_type(cPtr!GTypeModule, parentType, _typeName, typeInfo ? typeInfo.cPtr!GTypeInfo : null, flags);
    return _retval;
  }

  /**
   * Sets the name for a #GTypeModule
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_type_module_set_name(cPtr!GTypeModule, _name);
  }

  /**
   * Decreases the use count of a #GTypeModule by one. If the
   * result is zero, the module will be unloaded. (However, the
   * #GTypeModule will not be freed, and types associated with the
   * #GTypeModule are not unregistered. Once a #GTypeModule is
   * initialized, it must exist forever.)
   */
  void unuse()
  {
    g_type_module_unuse(cPtr!GTypeModule);
  }

  /**
   * %FALSE if the plugin needed to be loaded and
   * loading the plugin failed.
   */
  bool use()
  {
    bool _retval;
    _retval = g_type_module_use(cPtr!GTypeModule);
    return _retval;
  }
}
