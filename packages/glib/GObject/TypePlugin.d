module GObject.TypePlugin;

import GObject.TypeInfoG;
import GObject.TypeValueTable;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * An interface that handles the lifecycle of dynamically loaded types.
 * The GObject type system supports dynamic loading of types.
 * It goes as follows:
 * 1. The type is initially introduced $(LPAREN)usually upon loading the module
 * the first time, or by your main application that knows what modules
 * introduces what types$(RPAREN), like this:
 * ```c
 * new_type_id \= g_type_register_dynamic $(LPAREN)parent_type_id,
 * "TypeName",
 * new_type_plugin,
 * type_flags$(RPAREN);
 * ```
 * where `new_type_plugin` is an implementation of the
 * `GTypePlugin` interface.
 * 2. The type's implementation is referenced, e.g. through
 * [GObject.TypeClass.ref_] or through func@GObject.type_create_instance
 * $(LPAREN)this is being called by [GObject.ObjectG.new_]$(RPAREN) or through one of the above
 * done on a type derived from `new_type_id`.
 * 3. This causes the type system to load the type's implementation by calling
 * [GObject.TypePlugin.use] and [GObject.TypePlugin.completeTypeInfo]
 * on `new_type_plugin`.
 * 4. At some point the type's implementation isn't required anymore, e.g. after
 * [GObject.TypeClass.unref] or func@GObject.type_free_instance
 * $(LPAREN)called when the reference count of an instance drops to zero$(RPAREN).
 * 5. This causes the type system to throw away the information retrieved
 * from [GObject.TypePlugin.completeTypeInfo] and then it calls
 * [GObject.TypePlugin.unuse] on `new_type_plugin`.
 * 6. Things may repeat from the second step.
 * So basically, you need to implement a `GTypePlugin` type that
 * carries a use_count, once use_count goes from zero to one, you need
 * to load the implementation to successfully handle the upcoming
 * [GObject.TypePlugin.completeTypeInfo] call. Later, maybe after
 * succeeding use/unuse calls, once use_count drops to zero, you can
 * unload the implementation again. The type system makes sure to call
 * [GObject.TypePlugin.use] and [GObject.TypePlugin.completeTypeInfo]
 * again when the type is needed again.
 * [GObject.TypeModule] is an implementation of `GTypePlugin` that
 * already implements most of this except for the actual module loading and
 * unloading. It even handles multiple registered types per module.
 */
interface TypePlugin
{

  static GType getType()
  {
    return g_type_plugin_get_type();
  }

  /**
   * Calls the complete_interface_info function from the
   * #GTypePluginClass of plugin. There should be no need to use this
   * function outside of the GObject type system itself.
   * Params:
   *   instanceType = the #GType of an instantiatable type to which the interface
   *     is added
   *   interfaceType = the #GType of the interface whose info is completed
   *   info = the #GInterfaceInfo to fill in
   */
  void completeInterfaceInfo(GType instanceType, GType interfaceType, InterfaceInfo info);

  /**
   * Calls the complete_type_info function from the #GTypePluginClass of plugin.
   * There should be no need to use this function outside of the GObject
   * type system itself.
   * Params:
   *   gType = the #GType whose info is completed
   *   info = the #GTypeInfo struct to fill in
   *   valueTable = the #GTypeValueTable to fill in
   */
  void completeTypeInfo(GType gType, TypeInfoG info, TypeValueTable valueTable);
}
