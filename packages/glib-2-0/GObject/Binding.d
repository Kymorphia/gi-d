module GObject.Binding;

import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * `GObject` instance $(LPAREN)or source$(RPAREN) and another property on another `GObject`
 * instance $(LPAREN)or target$(RPAREN).
 * Whenever the source property changes, the same value is applied to the
 * target property; for instance, the following binding:
 * ```c
 * g_object_bind_property $(LPAREN)object1, "property-a",
 * object2, "property-b",
 * G_BINDING_DEFAULT$(RPAREN);
 * ```
 * will cause the property named "property-b" of @object2 to be updated
 * every time method@GObject.set or the specific accessor changes the value of
 * the property "property-a" of @object1.
 * It is possible to create a bidirectional binding between two properties
 * of two `GObject` instances, so that if either property changes, the
 * other is updated as well, for instance:
 * ```c
 * g_object_bind_property $(LPAREN)object1, "property-a",
 * object2, "property-b",
 * G_BINDING_BIDIRECTIONAL$(RPAREN);
 * ```
 * will keep the two properties in sync.
 * It is also possible to set a custom transformation function $(LPAREN)in both
 * directions, in case of a bidirectional binding$(RPAREN) to apply a custom
 * transformation from the source value to the target value before
 * applying it; for instance, the following binding:
 * ```c
 * g_object_bind_property_full $(LPAREN)adjustment1, "value",
 * adjustment2, "value",
 * G_BINDING_BIDIRECTIONAL,
 * celsius_to_fahrenheit,
 * fahrenheit_to_celsius,
 * NULL, NULL$(RPAREN);
 * ```
 * will keep the "value" property of the two adjustments in sync; the
 * @celsius_to_fahrenheit function will be called whenever the "value"
 * property of @adjustment1 changes and will transform the current value
 * of the property before applying it to the "value" property of @adjustment2.
 * Vice versa, the @fahrenheit_to_celsius function will be called whenever
 * the "value" property of @adjustment2 changes, and will transform the
 * current value of the property before applying it to the "value" property
 * of @adjustment1.
 * Note that #GBinding does not resolve cycles by itself; a cycle like
 * ```
 * object1:propertyA -> object2:propertyB
 * object2:propertyB -> object3:propertyC
 * object3:propertyC -> object1:propertyA
 * ```
 * might lead to an infinite loop. The loop, in this particular case,
 * can be avoided if the objects emit the `GObject::notify` signal only
 * if the value has effectively been changed. A binding is implemented
 * using the `GObject::notify` signal, so it is susceptible to all the
 * various ways of blocking a signal emission, like func@GObject.signal_stop_emission
 * or func@GObject.signal_handler_block.
 * A binding will be severed, and the resources it allocates freed, whenever
 * either one of the `GObject` instances it refers to are finalized, or when
 * the #GBinding instance loses its last reference.
 * Bindings for languages with garbage collection can use
 * [GObject.Binding.unbind] to explicitly release a binding between the source
 * and target properties, instead of relying on the last reference on the
 * binding, source, and target instances to drop.
 */
class Binding : ObjectG
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
    return g_binding_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves the #GObject instance used as the source of the binding.
   * A #GBinding can outlive the source #GObject as the binding does not hold a
   * strong reference to the source. If the source is destroyed before the
   * binding then this function will return %NULL.
   * Returns: the source #GObject, or %NULL if the
   *   source does not exist any more.
   */
  ObjectG dupSource()
  {
    ObjectC* _cretval;
    _cretval = g_binding_dup_source(cast(GBinding*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the #GObject instance used as the target of the binding.
   * A #GBinding can outlive the target #GObject as the binding does not hold a
   * strong reference to the target. If the target is destroyed before the
   * binding then this function will return %NULL.
   * Returns: the target #GObject, or %NULL if the
   *   target does not exist any more.
   */
  ObjectG dupTarget()
  {
    ObjectC* _cretval;
    _cretval = g_binding_dup_target(cast(GBinding*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the flags passed when constructing the #GBinding.
   * Returns: the #GBindingFlags used by the #GBinding
   */
  BindingFlags getFlags()
  {
    GBindingFlags _cretval;
    _cretval = g_binding_get_flags(cast(GBinding*)cPtr);
    BindingFlags _retval = cast(BindingFlags)_cretval;
    return _retval;
  }

  /**
   * Retrieves the #GObject instance used as the source of the binding.
   * A #GBinding can outlive the source #GObject as the binding does not hold a
   * strong reference to the source. If the source is destroyed before the
   * binding then this function will return %NULL.
   * Use [GObject.Binding.dupSource] if the source or binding are used from different
   * threads as otherwise the pointer returned from this function might become
   * invalid if the source is finalized from another thread in the meantime.
   * Returns: the source #GObject, or %NULL if the
   *   source does not exist any more.

   * Deprecated: Use [GObject.Binding.dupSource] for a safer version of this
   *   function.
   */
  ObjectG getSource()
  {
    ObjectC* _cretval;
    _cretval = g_binding_get_source(cast(GBinding*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the name of the property of #GBinding:source used as the source
   * of the binding.
   * Returns: the name of the source property
   */
  string getSourceProperty()
  {
    const(char)* _cretval;
    _cretval = g_binding_get_source_property(cast(GBinding*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the #GObject instance used as the target of the binding.
   * A #GBinding can outlive the target #GObject as the binding does not hold a
   * strong reference to the target. If the target is destroyed before the
   * binding then this function will return %NULL.
   * Use [GObject.Binding.dupTarget] if the target or binding are used from different
   * threads as otherwise the pointer returned from this function might become
   * invalid if the target is finalized from another thread in the meantime.
   * Returns: the target #GObject, or %NULL if the
   *   target does not exist any more.

   * Deprecated: Use [GObject.Binding.dupTarget] for a safer version of this
   *   function.
   */
  ObjectG getTarget()
  {
    ObjectC* _cretval;
    _cretval = g_binding_get_target(cast(GBinding*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the name of the property of #GBinding:target used as the target
   * of the binding.
   * Returns: the name of the target property
   */
  string getTargetProperty()
  {
    const(char)* _cretval;
    _cretval = g_binding_get_target_property(cast(GBinding*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Explicitly releases the binding between the source and the target
   * property expressed by binding.
   * This function will release the reference that is being held on
   * the binding instance if the binding is still bound; if you want to hold on
   * to the #GBinding instance after calling [GObject.Binding.unbind], you will need
   * to hold a reference to it.
   * Note however that this function does not take ownership of binding, it
   * only unrefs the reference that was initially created by
   * [GObject.ObjectG.bindProperty] and is owned by the binding.
   */
  void unbind()
  {
    g_binding_unbind(cast(GBinding*)cPtr);
  }
}
