module GObject.TypeInterface;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.TypeClass;
import GObject.TypePlugin;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * An opaque structure used as the base of all interface types.
 */
class TypeInterface
{
  GTypeInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeInterface");

    cInstance = *cast(GTypeInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeInterface))
  {
    return cast(T*)&cInstance;
  }

  /**
   * the
   * corresponding #GTypeInterface structure of the parent type of the
   * instance type to which @g_iface belongs, or %NULL if the parent
   * type doesn't conform to the interface
   */
  TypeInterface peekParent()
  {
    GTypeInterface* _cretval;
    _cretval = g_type_interface_peek_parent(cPtr!GTypeInterface);
    TypeInterface _retval = new TypeInterface(cast(GTypeInterface*)_cretval);
    return _retval;
  }

  /**
   * Adds @prerequisite_type to the list of prerequisites of @interface_type.
   * This means that any type implementing @interface_type must also implement
   * @prerequisite_type. Prerequisites can be thought of as an alternative to
   * interface derivation (which GType doesn't support). An interface can have
   * at most one instantiatable prerequisite type.
   */
  static void addPrerequisite(GType interfaceType, GType prerequisiteType)
  {
    g_type_interface_add_prerequisite(interfaceType, prerequisiteType);
  }

  /**
   * the #GTypePlugin for the dynamic
   * interface @interface_type of @instance_type
   */
  static TypePlugin getPlugin(GType instanceType, GType interfaceType)
  {
    GTypePlugin* _cretval;
    _cretval = g_type_interface_get_plugin(instanceType, interfaceType);
    TypePlugin _retval = ObjectG.getDObject!TypePlugin(cast(GTypePlugin*)_cretval, false);
    return _retval;
  }

  /**
   * the instantiatable prerequisite type or %G_TYPE_INVALID if none
   */
  static GType instantiatablePrerequisite(GType interfaceType)
  {
    GType _retval;
    _retval = g_type_interface_instantiatable_prerequisite(interfaceType);
    return _retval;
  }

  /**
   * the #GTypeInterface
   * structure of @iface_type if implemented by @instance_class, %NULL
   * otherwise
   */
  static TypeInterface peek(TypeClass instanceClass, GType ifaceType)
  {
    GTypeInterface* _cretval;
    _cretval = g_type_interface_peek(instanceClass ? instanceClass.cPtr!GTypeClass : null, ifaceType);
    TypeInterface _retval = new TypeInterface(cast(GTypeInterface*)_cretval);
    return _retval;
  }

  /**
   * a
   * newly-allocated zero-terminated array of #GType containing
   * the prerequisites of @interface_type
   */
  static GType[] prerequisites(GType interfaceType)
  {
    GType* _cretval;
    uint _cretlength;
    _cretval = g_type_interface_prerequisites(interfaceType, &_cretlength);
    GType[] _retval;

    if (_cretval)
    {
      _retval = cast(GType[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}
