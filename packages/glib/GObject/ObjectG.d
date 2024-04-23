module GObject.ObjectG;

import GLib.Types;
import GLib.c.functions;
import GObject.Binding;
import GObject.Closure;
import GObject.DClosure;
import GObject.ParamSpec;
import GObject.Parameter;
import GObject.TypeInterface;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;


private immutable Quark gidObjectQuark;

shared static this()
{
  gidObjectQuark = g_quark_from_string("_gidObject");
}

/// Base class wrapper for GObject types
/**
 * The base object type.
 *
 * All the fields in the `GObject` structure are private to the implementation
 * and should never be accessed directly.
 *
 * Since GLib 2.72, all #GObjects are guaranteed to be aligned to at least the
 * alignment of the largest basic GLib type (typically this is #guint64 or
 * #gdouble). If you need larger alignment for an element in a #GObject, you
 * should allocate it on the heap (aligned), or arrange for your #GObject to be
 * appropriately padded. This guarantee applies to the #GObject (or derived)
 * struct, the #GObjectClass (or derived) struct, and any private data allocated
 * by G_ADD_PRIVATE().
 */
class ObjectG
{
  protected ObjectC* cInstancePtr; // Pointer to wrapped C GObject

  /**
   * Constructor to wrap a C GObject with a D proxy object.
   * Params:
   *   cptr = Pointer to the GObject
   *   owned = true if the D object should take ownership of the passed reference, false to add a new reference
   */
  this(void* cObj, bool owned)
  {
    if (!cObj)
      throw new GidConstructException("Null instance pointer for " ~ typeid(this).name);

    cInstancePtr = cast(ObjectC*)cObj;

    // Add a data pointer to the D object from the C GObject
    g_object_set_qdata(cInstancePtr, gidObjectQuark, cast(void*)this);

    // Add a toggle reference to bind the GObject to this proxy D Object to prevent the GObject from being destroyed, while also preventing ref loops.
    g_object_add_toggle_ref(cInstancePtr, &_cObjToggleNotify, cast(void*)this);

    // Add D object as a root to garbage collector so that it doesn't get collected as long as the GObject has a strong reference on it (toggle ref + 1 or more other refs).
    // There will always be at least 2 references at this point, one from the caller and one for the toggle ref.
    ptrFreezeGC(cast(void*)this);

    // If object has a floating reference (GInitiallyOwned), take ownership of it
    if (g_object_is_floating(cInstancePtr))
      g_object_ref_sink(cInstancePtr);

    // If taking ownership of the object, remove the extra reference. May trigger toggle notify if it is the last remaining ref,
    // which will call GC.removeRoot() allowing the D object to be garbage collected if it is no longer being accessed, resulting in the destruction of the GObject in dtor.
    if (owned)
      g_object_unref(cInstancePtr);
  }

  ~this()
  { // D object is being garbage collected. Only happens when there is only the toggle reference on GObject and there are no more pointers to the D proxy object.
    if (cInstancePtr) // Might be null if an exception occurred during construction
      g_object_remove_toggle_ref(cInstancePtr, &_cObjToggleNotify, cast(void*)this); // Remove the toggle reference, which will likely lead to the destruction of the GObject
  }


  // Toggle ref callback
  extern(C) static void _cObjToggleNotify(void *dObj, ObjectC* gObj, bool isLastRef)
  {
    if (isLastRef) // Is the toggle reference the only reference?
      ptrThawGC(dObj);
    else // Toggle reference was the last reference, but now there is an additional one
      ptrFreezeGC(dObj);
  }

  /**
   * Get a pointer to the underlying C object.
   * Params:
   *   T = The type of C object to get (must be a valid C type for the D object or one of it's ancestors)
   *   addRef = true to add a reference with g_object_ref(), false otherwise (default)
   * Returns: The C object (no reference is added)
   */
  T* cPtr(T)(bool addRef = false)
  {
    return cast(T*)(addRef ? g_object_ref(cInstancePtr) : cInstancePtr);
  }

  /**
   * Calls g_object_ref() on a GObject.
   * Params:
   *   gObj = The GObject to reference
   * Returns: The GObject
   */
  static void* ref_(void* gObj)
  {
    return g_object_ref(cast(ObjectC*)gObj);
  }

  /**
   * Calls g_object_unref() on a GObject.
   * Params:
   *   gObj = The GObject to reference
   */
  static unref(void* gObj)
  {
    g_object_unref(cast(ObjectC*)gObj);
  }

  /**
   * Get the GType of an object.
   * Returns: The GType
   */
  GType getType()
  {
    return g_object_get_type();
  }

  /**
   * Template to get the D object from a C GObject and cast it to the given D object type.
   * Params:
   *   T = The D object type
   *   cptr = The C GObject
   *   owned = If true then the D object will take ownership of the GObject reference (false by default).
   * Returns: The D object (which may be a new object if the GObject wasn't already wrapped)
   */
  static T getDObject(T)(void* cptr, bool owned = false)
  {
    if (auto dObj = g_object_get_qdata(cast(ObjectC*)cptr, gidObjectQuark))
      return cast(T)dObj;

    static if (!is(T == interface))
      return new T(cptr, owned);
    else
      return null; // FIXME - Need to handle returning an object instance for an interface
  }

  /**
   * Connect a D closure to an object signal.
   * Params:
   *   signalDetail = Signal name and optional detail separated by '::'
   *   closure = Closure to connect signal to
   *   after = true invoke the signal after the default handler, false to execute before (default)
   * Returns: The signal connection ID
   */
  ulong connectSignalClosure(string signalDetail, DClosure closure, bool after = false)
  {
    return g_signal_connect_closure(cInstancePtr, signalDetail.toCString(false), (cast(Closure)closure).cPtr!GClosure, after);
  }

  /**
   * a new instance of
   * @object_type
   */
  static ObjectG newv(GType objectType, Parameter[] parameters)
  {
    ObjectC* _cretval;
    GParameter[] _tmpparameters;
    foreach (obj; parameters)
      _tmpparameters ~= obj.cInstance;
    GParameter* _parameters = _tmpparameters.ptr;
    _cretval = g_object_newv(objectType, parameters ? cast(uint)parameters.length : 0, _parameters);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  static size_t compatControl(size_t what, void* data)
  {
    size_t _retval;
    _retval = g_object_compat_control(what, data);
    return _retval;
  }

  /**
   * the #GParamSpec for the property of the
   * interface with the name @property_name, or %NULL if no
   * such property exists.
   */
  static ParamSpec interfaceFindProperty(TypeInterface gIface, string propertyName)
  {
    GParamSpec* _cretval;
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_object_interface_find_property(gIface ? gIface.cPtr!GTypeInterface : null, _propertyName);
    ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, false);
    return _retval;
  }

  /**
   * Add a property to an interface; this is only useful for interfaces
   * that are added to GObject-derived types. Adding a property to an
   * interface forces all objects classes with that interface to have a
   * compatible property. The compatible property could be a newly
   * created #GParamSpec, but normally
   * g_object_class_override_property() will be used so that the object
   * class only needs to provide an implementation and inherits the
   * property description, default value, bounds, and so forth from the
   * interface property.
   *
   * This function is meant to be called from the interface's default
   * vtable initialization function (the @class_init member of
   * #GTypeInfo.) It must not be called after after @class_init has
   * been called for any object types implementing this interface.
   *
   * If @pspec is a floating reference, it will be consumed.
   */
  static void interfaceInstallProperty(TypeInterface gIface, ParamSpec pspec)
  {
    g_object_interface_install_property(gIface ? gIface.cPtr!GTypeInterface : null, pspec ? pspec.cPtr!GParamSpec : null);
  }

  /**
   * a
   * pointer to an array of pointers to #GParamSpec
   * structures. The paramspecs are owned by GLib, but the
   * array should be freed with g_free() when you are done with
   * it.
   */
  static ParamSpec[] interfaceListProperties(TypeInterface gIface)
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = g_object_interface_list_properties(gIface ? gIface.cPtr!GTypeInterface : null, &_cretlength);
    ParamSpec[] _retval;

    if (_cretval)
    {
      _retval = new ParamSpec[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new ParamSpec(cast(void*)_cretval[i], false);
    }
    return _retval;
  }

  /**
   * the #GBinding instance representing the
   * binding between the two #GObject instances. The binding is released
   * whenever the #GBinding reference count reaches zero.
   */
  Binding bindProperty(string sourceProperty, ObjectG target, string targetProperty, BindingFlags flags)
  {
    GBinding* _cretval;
    const(char)* _sourceProperty = sourceProperty.toCString(false);
    const(char)* _targetProperty = targetProperty.toCString(false);
    _cretval = g_object_bind_property(cPtr!ObjectC, _sourceProperty, target ? target.cPtr!ObjectC : null, _targetProperty, flags);
    Binding _retval = ObjectG.getDObject!Binding(cast(GBinding*)_cretval, false);
    return _retval;
  }

  /**
   * the #GBinding instance representing the
   * binding between the two #GObject instances. The binding is released
   * whenever the #GBinding reference count reaches zero.
   */
  Binding bindPropertyFull(string sourceProperty, ObjectG target, string targetProperty, BindingFlags flags, Closure transformTo, Closure transformFrom)
  {
    GBinding* _cretval;
    const(char)* _sourceProperty = sourceProperty.toCString(false);
    const(char)* _targetProperty = targetProperty.toCString(false);
    _cretval = g_object_bind_property_with_closures(cPtr!ObjectC, _sourceProperty, target ? target.cPtr!ObjectC : null, _targetProperty, flags, transformTo ? transformTo.cPtr!GClosure : null, transformFrom ? transformFrom.cPtr!GClosure : null);
    Binding _retval = ObjectG.getDObject!Binding(cast(GBinding*)_cretval, false);
    return _retval;
  }

  /**
   * This function is intended for #GObject implementations to re-enforce
   * a [floating][floating-ref] object reference. Doing this is seldom
   * required: all #GInitiallyUnowneds are created with a floating reference
   * which usually just needs to be sunken by calling g_object_ref_sink().
   */
  void forceFloating()
  {
    g_object_force_floating(cPtr!ObjectC);
  }

  /**
   * Increases the freeze count on @object. If the freeze count is
   * non-zero, the emission of "notify" signals on @object is
   * stopped. The signals are queued until the freeze count is decreased
   * to zero. Duplicate notifications are squashed so that at most one
   * #GObject::notify signal is emitted for each property modified while the
   * object is frozen.
   *
   * This is necessary for accessors that modify multiple properties to prevent
   * premature notification while the object is still being modified.
   */
  void freezeNotify()
  {
    g_object_freeze_notify(cPtr!ObjectC);
  }

  /**
   * the data if found,
   * or %NULL if no such data exists.
   */
  void* getData(string key)
  {
    void* _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_object_get_data(cPtr!ObjectC, _key);
    return _retval;
  }

  /**
   * Gets a property of an object.
   *
   * The @value can be:
   *
   * - an empty #GValue initialized by %G_VALUE_INIT, which will be
   * automatically initialized with the expected type of the property
   * (since GLib 2.60)
   * - a #GValue initialized with the expected type of the property
   * - a #GValue initialized with a type to which the expected type
   * of the property can be transformed
   *
   * In general, a copy is made of the property contents and the caller is
   * responsible for freeing the memory by calling g_value_unset().
   *
   * Note that g_object_get_property() is really intended for language
   * bindings, g_object_get() is much more convenient for C programming.
   */
  void getProperty(string propertyName, Value value)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    g_object_get_property(cPtr!ObjectC, _propertyName, value ? value.cPtr!GValue : null);
  }

  /**
   * The user data pointer set, or %NULL
   */
  void* getQdata(Quark quark)
  {
    void* _retval;
    _retval = g_object_get_qdata(cPtr!ObjectC, quark);
    return _retval;
  }

  /**
   * Gets @n_properties properties for an @object.
   * Obtained properties will be set to @values. All properties must be valid.
   * Warnings will be emitted and undefined behaviour may result if invalid
   * properties are passed in.
   */
  void getv(string[] names, Value[] values)
  {
    char*[] _tmpnames;
    foreach (s; names)
      _tmpnames ~= s.toCString(false);
    const(char*)* _names = _tmpnames.ptr;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *obj.cPtr!GValue;
    GValue* _values = _tmpvalues.ptr;
    g_object_getv(cPtr!ObjectC, values ? cast(uint)values.length : 0, _names, _values);
  }

  /**
   * %TRUE if @object has a floating reference
   */
  bool isFloating()
  {
    bool _retval;
    _retval = g_object_is_floating(cPtr!ObjectC);
    return _retval;
  }

  /**
   * Emits a "notify" signal for the property @property_name on @object.
   *
   * When possible, eg. when signaling a property change from within the class
   * that registered the property, you should use g_object_notify_by_pspec()
   * instead.
   *
   * Note that emission of the notify signal may be blocked with
   * g_object_freeze_notify(). In this case, the signal emissions are queued
   * and will be emitted (in reverse order) when g_object_thaw_notify() is
   * called.
   */
  void notify(string propertyName)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    g_object_notify(cPtr!ObjectC, _propertyName);
  }

  /**
   * Emits a "notify" signal for the property specified by @pspec on @object.
   *
   * This function omits the property name lookup, hence it is faster than
   * g_object_notify().
   *
   * One way to avoid using g_object_notify() from within the
   * class that registered the properties, and using g_object_notify_by_pspec()
   * instead, is to store the GParamSpec used with
   * g_object_class_install_property() inside a static array, e.g.:
   *
   * |[<!-- language="C" -->
   * typedef enum
   * {
   * PROP_FOO = 1,
   * PROP_LAST
   * } MyObjectProperty;
   *
   * static GParamSpec *properties[PROP_LAST];
   *
   * static void
   * my_object_class_init (MyObjectClass *klass)
   * {
   * properties[PROP_FOO] = g_param_spec_int ("foo", "Foo", "The foo",
   * 0, 100,
   * 50,
   * G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS);
   * g_object_class_install_property (gobject_class,
   * PROP_FOO,
   * properties[PROP_FOO]);
   * }
   * ]|
   *
   * and then notify a change on the "foo" property with:
   *
   * |[<!-- language="C" -->
   * g_object_notify_by_pspec (self, properties[PROP_FOO]);
   * ]|
   */
  void notifyByPspec(ParamSpec pspec)
  {
    g_object_notify_by_pspec(cPtr!ObjectC, pspec ? pspec.cPtr!GParamSpec : null);
  }

  /**
   * @object
   */
  ObjectG refSink()
  {
    ObjectC* _cretval;
    _cretval = g_object_ref_sink(cPtr!ObjectC);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * Releases all references to other objects. This can be used to break
   * reference cycles.
   *
   * This function should only be called from object system implementations.
   */
  void runDispose()
  {
    g_object_run_dispose(cPtr!ObjectC);
  }

  /**
   * Each object carries around a table of associations from
   * strings to pointers.  This function lets you set an association.
   *
   * If the object already had an association with that name,
   * the old association will be destroyed.
   *
   * Internally, the @key is converted to a #GQuark using g_quark_from_string().
   * This means a copy of @key is kept permanently (even after @object has been
   * finalized) — so it is recommended to only use a small, bounded set of values
   * for @key in your program, to avoid the #GQuark storage growing unbounded.
   */
  void setData(string key, void* data)
  {
    const(char)* _key = key.toCString(false);
    g_object_set_data(cPtr!ObjectC, _key, data);
  }

  /**
   * Sets a property on an object.
   */
  void setProperty(string propertyName, Value value)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    g_object_set_property(cPtr!ObjectC, _propertyName, value ? value.cPtr!GValue : null);
  }

  /**
   * the data if found, or %NULL
   * if no such data exists.
   */
  void* stealData(string key)
  {
    void* _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_object_steal_data(cPtr!ObjectC, _key);
    return _retval;
  }

  /**
   * The user data pointer set, or %NULL
   */
  void* stealQdata(Quark quark)
  {
    void* _retval;
    _retval = g_object_steal_qdata(cPtr!ObjectC, quark);
    return _retval;
  }

  /**
   * Reverts the effect of a previous call to
   * g_object_freeze_notify(). The freeze count is decreased on @object
   * and when it reaches zero, queued "notify" signals are emitted.
   *
   * Duplicate notifications for each property are squashed so that at most one
   * #GObject::notify signal is emitted for each property, in the reverse order
   * in which they have been queued.
   *
   * It is an error to call this function when the freeze count is zero.
   */
  void thawNotify()
  {
    g_object_thaw_notify(cPtr!ObjectC);
  }

  /**
   * This function essentially limits the life time of the @closure to
   * the life time of the object. That is, when the object is finalized,
   * the @closure is invalidated by calling g_closure_invalidate() on
   * it, in order to prevent invocations of the closure with a finalized
   * (nonexisting) object. Also, g_object_ref() and g_object_unref() are
   * added as marshal guards to the @closure, to ensure that an extra
   * reference count is held on @object during invocation of the
   * @closure.  Usually, this function will be called on closures that
   * use this @object as closure data.
   */
  void watchClosure(Closure closure)
  {
    g_object_watch_closure(cPtr!ObjectC, closure ? closure.cPtr!GClosure : null);
  }

  /**
   * The notify signal is emitted on an object when one of its properties has
   * its value set through g_object_set_property(), g_object_set(), et al.
   *
   * Note that getting this signal doesn’t itself guarantee that the value of
   * the property has actually changed. When it is emitted is determined by the
   * derived GObject class. If the implementor did not create the property with
   * %G_PARAM_EXPLICIT_NOTIFY, then any call to g_object_set_property() results
   * in ::notify being emitted, even if the new value is the same as the old.
   * If they did pass %G_PARAM_EXPLICIT_NOTIFY, then this signal is emitted only
   * when they explicitly call g_object_notify() or g_object_notify_by_pspec(),
   * and common practice is to do that only when the value has actually changed.
   *
   * This signal is typically used to obtain change notification for a
   * single property, by specifying the property name as a detail in the
   * g_signal_connect() call, like this:
   *
   * |[<!-- language="C" -->
   * g_signal_connect (text_view->buffer, "notify::paste-target-list",
   * G_CALLBACK (gtk_text_view_target_list_notify),
   * text_view)
   * ]|
   *
   * It is important to note that you must use
   * [canonical parameter names][canonical-parameter-names] as
   * detail strings for the notify signal.
   */
  ulong connectNotify(void delegate(ParamSpec pspec, ObjectG objectG) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto objectG = getVal!ObjectG(_paramVals);
      auto pspec = getVal!ParamSpec(&_paramVals[1]);
      _dgClosure.dlg(pspec, objectG);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("notify", closure, (flags & ConnectFlags.After) != 0);
  }
}
