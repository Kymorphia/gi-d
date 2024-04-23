module GObject.BindingGroup;

import GObject.Closure;
import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The #GBindingGroup can be used to bind multiple properties
 * from an object collectively.
 *
 * Use the various methods to bind properties from a single source
 * object to multiple destination objects. Properties can be bound
 * bidirectionally and are connected when the source object is set
 * with g_binding_group_set_source().
 */
class BindingGroup : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_binding_group_get_type();
  }

  /**
   * a new #GBindingGroup
   */
  this()
  {
    GBindingGroup* _cretval;
    _cretval = g_binding_group_new();
    this(_cretval, true);
  }

  /**
   * Creates a binding between @source_property on the source object
   * and @target_property on @target. Whenever the @source_property
   * is changed the @target_property is updated using the same value.
   * The binding flag %G_BINDING_SYNC_CREATE is automatically specified.
   *
   * See g_object_bind_property() for more information.
   */
  void bind(string sourceProperty, ObjectG target, string targetProperty, BindingFlags flags)
  {
    const(char)* _sourceProperty = sourceProperty.toCString(false);
    const(char)* _targetProperty = targetProperty.toCString(false);
    g_binding_group_bind(cPtr!GBindingGroup, _sourceProperty, target ? target.cPtr!ObjectC : null, _targetProperty, flags);
  }

  /**
   * Creates a binding between @source_property on the source object and
   * @target_property on @target, allowing you to set the transformation
   * functions to be used by the binding. The binding flag
   * %G_BINDING_SYNC_CREATE is automatically specified.
   *
   * This function is the language bindings friendly version of
   * g_binding_group_bind_property_full(), using #GClosures
   * instead of function pointers.
   *
   * See g_object_bind_property_with_closures() for more information.
   */
  void bindFull(string sourceProperty, ObjectG target, string targetProperty, BindingFlags flags, Closure transformTo, Closure transformFrom)
  {
    const(char)* _sourceProperty = sourceProperty.toCString(false);
    const(char)* _targetProperty = targetProperty.toCString(false);
    g_binding_group_bind_with_closures(cPtr!GBindingGroup, _sourceProperty, target ? target.cPtr!ObjectC : null, _targetProperty, flags, transformTo ? transformTo.cPtr!GClosure : null, transformFrom ? transformFrom.cPtr!GClosure : null);
  }

  /**
   * a #GObject or %NULL.
   */
  ObjectG dupSource()
  {
    ObjectC* _cretval;
    _cretval = g_binding_group_dup_source(cPtr!GBindingGroup);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * Sets @source as the source object used for creating property
   * bindings. If there is already a source object all bindings from it
   * will be removed.
   *
   * Note that all properties that have been bound must exist on @source.
   */
  void setSource(ObjectG source)
  {
    g_binding_group_set_source(cPtr!GBindingGroup, source ? source.cPtr!ObjectC : null);
  }
}
