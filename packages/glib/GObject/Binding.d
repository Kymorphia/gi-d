module GObject.Binding;

import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * #GBinding is the representation of a binding between a property on a
 * #GObject instance (or source) and another property on another #GObject
 * instance (or target).
 *
 * Whenever the source property changes, the same value is applied to the
 * target property; for instance, the following binding:
 *
 * |[<!-- language="C" -->
 * g_object_bind_property (object1, "property-a",
 * object2, "property-b",
 * G_BINDING_DEFAULT);
 * ]|
 *
 * will cause the property named "property-b" of @object2 to be updated
 * every time g_object_set() or the specific accessor changes the value of
 * the property "property-a" of @object1.
 *
 * It is possible to create a bidirectional binding between two properties
 * of two #GObject instances, so that if either property changes, the
 * other is updated as well, for instance:
 *
 * |[<!-- language="C" -->
 * g_object_bind_property (object1, "property-a",
 * object2, "property-b",
 * G_BINDING_BIDIRECTIONAL);
 * ]|
 *
 * will keep the two properties in sync.
 *
 * It is also possible to set a custom transformation function (in both
 * directions, in case of a bidirectional binding) to apply a custom
 * transformation from the source value to the target value before
 * applying it; for instance, the following binding:
 *
 * |[<!-- language="C" -->
 * g_object_bind_property_full (adjustment1, "value",
 * adjustment2, "value",
 * G_BINDING_BIDIRECTIONAL,
 * celsius_to_fahrenheit,
 * fahrenheit_to_celsius,
 * NULL, NULL);
 * ]|
 *
 * will keep the "value" property of the two adjustments in sync; the
 * @celsius_to_fahrenheit function will be called whenever the "value"
 * property of @adjustment1 changes and will transform the current value
 * of the property before applying it to the "value" property of @adjustment2.
 *
 * Vice versa, the @fahrenheit_to_celsius function will be called whenever
 * the "value" property of @adjustment2 changes, and will transform the
 * current value of the property before applying it to the "value" property
 * of @adjustment1.
 *
 * Note that #GBinding does not resolve cycles by itself; a cycle like
 *
 * |[
 * object1:propertyA -> object2:propertyB
 * object2:propertyB -> object3:propertyC
 * object3:propertyC -> object1:propertyA
 * ]|
 *
 * might lead to an infinite loop. The loop, in this particular case,
 * can be avoided if the objects emit the #GObject::notify signal only
 * if the value has effectively been changed. A binding is implemented
 * using the #GObject::notify signal, so it is susceptible to all the
 * various ways of blocking a signal emission, like g_signal_stop_emission()
 * or g_signal_handler_block().
 *
 * A binding will be severed, and the resources it allocates freed, whenever
 * either one of the #GObject instances it refers to are finalized, or when
 * the #GBinding instance loses its last reference.
 *
 * Bindings for languages with garbage collection can use
 * g_binding_unbind() to explicitly release a binding between the source
 * and target properties, instead of relying on the last reference on the
 * binding, source, and target instances to drop.
 *
 * #GBinding is available since GObject 2.26
 */
class Binding : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_binding_get_type();
  }

  /**
   * the source #GObject, or %NULL if the
   * source does not exist any more.
   */
  ObjectG dupSource()
  {
    ObjectC* _cretval;
    _cretval = g_binding_dup_source(cPtr!GBinding);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  /**
   * the target #GObject, or %NULL if the
   * target does not exist any more.
   */
  ObjectG dupTarget()
  {
    ObjectC* _cretval;
    _cretval = g_binding_dup_target(cPtr!GBinding);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  /**
   * the #GBindingFlags used by the #GBinding
   */
  BindingFlags getFlags()
  {
    GBindingFlags _cretval;
    _cretval = g_binding_get_flags(cPtr!GBinding);
    BindingFlags _retval = cast(BindingFlags)_cretval;
    return _retval;
  }

  /**
   * the source #GObject, or %NULL if the
   * source does not exist any more.
   */
  ObjectG getSource()
  {
    ObjectC* _cretval;
    _cretval = g_binding_get_source(cPtr!GBinding);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * the name of the source property
   */
  string getSourceProperty()
  {
    const(char)* _cretval;
    _cretval = g_binding_get_source_property(cPtr!GBinding);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the target #GObject, or %NULL if the
   * target does not exist any more.
   */
  ObjectG getTarget()
  {
    ObjectC* _cretval;
    _cretval = g_binding_get_target(cPtr!GBinding);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * the name of the target property
   */
  string getTargetProperty()
  {
    const(char)* _cretval;
    _cretval = g_binding_get_target_property(cPtr!GBinding);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Explicitly releases the binding between the source and the target
   * property expressed by @binding.
   *
   * This function will release the reference that is being held on
   * the @binding instance if the binding is still bound; if you want to hold on
   * to the #GBinding instance after calling g_binding_unbind(), you will need
   * to hold a reference to it.
   *
   * Note however that this function does not take ownership of @binding, it
   * only unrefs the reference that was initially created by
   * g_object_bind_property() and is owned by the binding.
   */
  void unbind()
  {
    g_binding_unbind(cPtr!GBinding);
  }
}
