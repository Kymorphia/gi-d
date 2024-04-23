module GObject.c.types;

public import GLib.c.types;

/**
 * This is the signature of marshaller functions, required to marshall
 * arrays of parameter values to signal emissions into C language callback
 * invocations.
 *
 * It is merely an alias to #GClosureMarshal since the #GClosure mechanism
 * takes over responsibility of actual function invocation for the signal
 * system.
 */
alias GSignalCMarshaller = GClosureMarshal;

/**
 * This is the signature of va_list marshaller functions, an optional
 * marshaller that can be used in some situations to avoid
 * marshalling the signal argument into GValues.
 */
alias GSignalCVaMarshaller = GVaClosureMarshal;

/**
 * A numerical value which represents the unique identifier of a registered
 * type.
 */
alias GType = size_t;

/**
 * Flags to be passed to g_object_bind_property() or
 * g_object_bind_property_full().
 *
 * This enumeration can be extended at later date.
 */
enum GBindingFlags : uint
{
  /**
   * The default binding; if the source property
   * changes, the target property is updated with its value.
   */
  Default = 0,

  /**
   * Bidirectional binding; if either the
   * property of the source or the property of the target changes,
   * the other is updated.
   */
  Bidirectional = 1,

  /**
   * Synchronize the values of the source and
   * target properties when creating the binding; the direction of
   * the synchronization is always from the source to the target.
   */
  SyncCreate = 2,

  /**
   * If the two properties being bound are
   * booleans, setting one to %TRUE will result in the other being
   * set to %FALSE and vice versa. This flag will only work for
   * boolean properties, and cannot be used when passing custom
   * transformation functions to g_object_bind_property_full().
   */
  InvertBoolean = 4,
}

/**
 * The connection flags are used to specify the behaviour of a signal's
 * connection.
 */
enum GConnectFlags : uint
{
  /**
   * Default behaviour (no special flags). Since: 2.74
   */
  Default = 0,

  /**
   * If set, the handler should be called after the
   * default handler of the signal. Normally, the handler is called before
   * the default handler.
   */
  After = 1,

  /**
   * If set, the instance and data should be swapped when
   * calling the handler; see g_signal_connect_swapped() for an example.
   */
  Swapped = 2,
}

/**
 * Through the #GParamFlags flag values, certain aspects of parameters
 * can be configured.
 *
 * See also: %G_PARAM_STATIC_STRINGS
 */
enum GParamFlags : uint
{
  /**
   * the parameter is readable
   */
  Readable = 1,

  /**
   * the parameter is writable
   */
  Writable = 2,

  /**
   * alias for %G_PARAM_READABLE | %G_PARAM_WRITABLE
   */
  Readwrite = 3,

  /**
   * the parameter will be set upon object construction
   */
  Construct = 4,

  /**
   * the parameter can only be set upon object construction
   */
  ConstructOnly = 8,

  /**
   * upon parameter conversion (see g_param_value_convert())
   * strict validation is not required
   */
  LaxValidation = 16,

  /**
   * the string used as name when constructing the
   * parameter is guaranteed to remain valid and
   * unmodified for the lifetime of the parameter.
   * Since 2.8
   */
  StaticName = 32,

  /**
   * internal
   */
  Private = 32,

  /**
   * the string used as nick when constructing the
   * parameter is guaranteed to remain valid and
   * unmmodified for the lifetime of the parameter.
   * Since 2.8
   */
  StaticNick = 64,

  /**
   * the string used as blurb when constructing the
   * parameter is guaranteed to remain valid and
   * unmodified for the lifetime of the parameter.
   * Since 2.8
   */
  StaticBlurb = 128,

  /**
   * calls to g_object_set_property() for this
   * property will not automatically result in a "notify" signal being
   * emitted: the implementation must call g_object_notify() themselves
   * in case the property actually changes.  Since: 2.42.
   */
  ExplicitNotify = 1073741824,

  /**
   * the parameter is deprecated and will be removed
   * in a future version. A warning will be generated if it is used
   * while running with G_ENABLE_DIAGNOSTIC=1.
   * Since 2.26
   */
  Deprecated = 2147483648,
}

/**
 * The signal flags are used to specify a signal's behaviour.
 */
enum GSignalFlags : uint
{
  /**
   * Invoke the object method handler in the first emission stage.
   */
  RunFirst = 1,

  /**
   * Invoke the object method handler in the third emission stage.
   */
  RunLast = 2,

  /**
   * Invoke the object method handler in the last emission stage.
   */
  RunCleanup = 4,

  /**
   * Signals being emitted for an object while currently being in
   * emission for this very object will not be emitted recursively,
   * but instead cause the first emission to be restarted.
   */
  NoRecurse = 8,

  /**
   * This signal supports "::detail" appendices to the signal name
   * upon handler connections and emissions.
   */
  Detailed = 16,

  /**
   * Action signals are signals that may freely be emitted on alive
   * objects from user code via g_signal_emit() and friends, without
   * the need of being embedded into extra code that performs pre or
   * post emission adjustments on the object. They can also be thought
   * of as object methods which can be called generically by
   * third-party code.
   */
  Action = 32,

  /**
   * No emissions hooks are supported for this signal.
   */
  NoHooks = 64,

  /**
   * Varargs signal emission will always collect the
   * arguments, even if there are no signal handlers connected.  Since 2.30.
   */
  MustCollect = 128,

  /**
   * The signal is deprecated and will be removed
   * in a future version. A warning will be generated if it is connected while
   * running with G_ENABLE_DIAGNOSTIC=1.  Since 2.32.
   */
  Deprecated = 256,

  /**
   * Only used in #GSignalAccumulator accumulator
   * functions for the #GSignalInvocationHint::run_type field to mark the first
   * call to the accumulator function for a signal emission.  Since 2.68.
   */
  AccumulatorFirstRun = 131072,
}

/**
 * The match types specify what g_signal_handlers_block_matched(),
 * g_signal_handlers_unblock_matched() and g_signal_handlers_disconnect_matched()
 * match signals by.
 */
enum GSignalMatchType : uint
{
  /**
   * The signal id must be equal.
   */
  Id = 1,

  /**
   * The signal detail must be equal.
   */
  Detail = 2,

  /**
   * The closure must be the same.
   */
  Closure = 4,

  /**
   * The C closure callback must be the same.
   */
  Func = 8,

  /**
   * The closure data must be the same.
   */
  Data = 16,

  /**
   * Only unblocked signals may be matched.
   */
  Unblocked = 32,
}

/**
 * These flags used to be passed to g_type_init_with_debug_flags() which
 * is now deprecated.
 *
 * If you need to enable debugging features, use the `GOBJECT_DEBUG`
 * environment variable.
 */
enum GTypeDebugFlags : uint
{
  /**
   * Print no messages
   */
  None = 0,

  /**
   * Print messages about object bookkeeping
   */
  Objects = 1,

  /**
   * Print messages about signal emissions
   */
  Signals = 2,

  /**
   * Keep a count of instances of each type
   */
  InstanceCount = 4,

  /**
   * Mask covering all debug flags
   */
  Mask = 7,
}

/**
 * Bit masks used to check or determine characteristics of a type.
 */
enum GTypeFlags : uint
{
  /**
   * No special flags. Since: 2.74
   */
  None = 0,

  /**
   * Indicates an abstract type. No instances can be
   * created for an abstract type
   */
  Abstract = 16,

  /**
   * Indicates an abstract value type, i.e. a type
   * that introduces a value table, but can't be used for
   * g_value_init()
   */
  ValueAbstract = 32,

  /**
   * Indicates a final type. A final type is a non-derivable
   * leaf node in a deep derivable type hierarchy tree. Since: 2.70
   */
  Final = 64,

  /**
   * The type is deprecated and may be removed in a
   * future version. A warning will be emitted if it is instantiated while
   * running with `G_ENABLE_DIAGNOSTIC=1`. Since 2.76
   */
  Deprecated = 128,
}

/**
 * Bit masks used to check or determine specific characteristics of a
 * fundamental type.
 */
enum GTypeFundamentalFlags : uint
{
  /**
   * Indicates a classed type
   */
  Classed = 1,

  /**
   * Indicates an instantiatable type (implies classed)
   */
  Instantiatable = 2,

  /**
   * Indicates a flat derivable type
   */
  Derivable = 4,

  /**
   * Indicates a deep derivable type (implies derivable)
   */
  DeepDerivable = 8,
}

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
struct GBinding;

/**
 * The #GBindingGroup can be used to bind multiple properties
 * from an object collectively.
 *
 * Use the various methods to bind properties from a single source
 * object to multiple destination objects. Properties can be bound
 * bidirectionally and are connected when the source object is set
 * with g_binding_group_set_source().
 */
struct GBindingGroup;

/**
 * A #GCClosure is a specialization of #GClosure for C function callbacks.
 */
struct GCClosure
{
  /**
   * the #GClosure
   */
  GClosure closure;

  /**
   * the callback function
   */
  void* callback;
}

/**
 * A #GClosure represents a callback supplied by the programmer.
 *
 * It will generally comprise a function of some kind and a marshaller
 * used to call it. It is the responsibility of the marshaller to
 * convert the arguments for the invocation from #GValues into
 * a suitable form, perform the callback on the converted arguments,
 * and transform the return value back into a #GValue.
 *
 * In the case of C programs, a closure usually just holds a pointer
 * to a function and maybe a data argument, and the marshaller
 * converts between #GValue and native C types. The GObject
 * library provides the #GCClosure type for this purpose. Bindings for
 * other languages need marshallers which convert between #GValues
 * and suitable representations in the runtime of the language in
 * order to use functions written in that language as callbacks. Use
 * g_closure_set_marshal() to set the marshaller on such a custom
 * closure implementation.
 *
 * Within GObject, closures play an important role in the
 * implementation of signals. When a signal is registered, the
 * @c_marshaller argument to g_signal_new() specifies the default C
 * marshaller for any closure which is connected to this
 * signal. GObject provides a number of C marshallers for this
 * purpose, see the g_cclosure_marshal_*() functions. Additional C
 * marshallers can be generated with the [glib-genmarshal][glib-genmarshal]
 * utility.  Closures can be explicitly connected to signals with
 * g_signal_connect_closure(), but it usually more convenient to let
 * GObject create a closure automatically by using one of the
 * g_signal_connect_*() functions which take a callback function/user
 * data pair.
 *
 * Using closures has a number of important advantages over a simple
 * callback function/data pointer combination:
 *
 * - Closures allow the callee to get the types of the callback parameters,
 * which means that language bindings don't have to write individual glue
 * for each callback type.
 *
 * - The reference counting of #GClosure makes it easy to handle reentrancy
 * right; if a callback is removed while it is being invoked, the closure
 * and its parameters won't be freed until the invocation finishes.
 *
 * - g_closure_invalidate() and invalidation notifiers allow callbacks to be
 * automatically removed when the objects they point to go away.
 */
struct GClosure
{
  uint refCount;

  uint metaMarshalNouse;

  uint nGuards;

  uint nFnotifiers;

  uint nInotifiers;

  uint inInotify;

  uint floating;

  uint derivativeFlag;

  /**
   * Indicates whether the closure is currently being invoked with
   * g_closure_invoke()
   */
  uint inMarshal;

  /**
   * Indicates whether the closure has been invalidated by
   * g_closure_invalidate()
   */
  uint isInvalid;

  extern(C) void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) marshal;

  void* data;

  GClosureNotifyData* notifiers;
}

struct GClosureNotifyData
{
  void* data;

  GClosureNotify notify;
}

/**
 * The class of an enumeration type holds information about its
 * possible values.
 */
struct GEnumClass
{
  /**
   * the parent class
   */
  GTypeClass gTypeClass;

  /**
   * the smallest possible value.
   */
  int minimum;

  /**
   * the largest possible value.
   */
  int maximum;

  /**
   * the number of possible values.
   */
  uint nValues;

  /**
   * an array of #GEnumValue structs describing the
   * individual values.
   */
  GEnumValue* values;
}

/**
 * A structure which contains a single enum value, its name, and its
 * nickname.
 */
struct GEnumValue
{
  /**
   * the enum value
   */
  int value;

  /**
   * the name of the value
   */
  const(char)* valueName;

  /**
   * the nickname of the value
   */
  const(char)* valueNick;
}

/**
 * The class of a flags type holds information about its
 * possible values.
 */
struct GFlagsClass
{
  /**
   * the parent class
   */
  GTypeClass gTypeClass;

  /**
   * a mask covering all possible values.
   */
  uint mask;

  /**
   * the number of possible values.
   */
  uint nValues;

  /**
   * an array of #GFlagsValue structs describing the
   * individual values.
   */
  GFlagsValue* values;
}

/**
 * A structure which contains a single flags value, its name, and its
 * nickname.
 */
struct GFlagsValue
{
  /**
   * the flags value
   */
  uint value;

  /**
   * the name of the value
   */
  const(char)* valueName;

  /**
   * the nickname of the value
   */
  const(char)* valueNick;
}

/**
 * A type for objects that have an initially floating reference.
 *
 * All the fields in the `GInitiallyUnowned` structure are private to the
 * implementation and should never be accessed directly.
 */
struct GInitiallyUnowned
{
  GTypeInstance gTypeInstance;

  uint refCount;

  GData* qdata;
}

/**
 * The class structure for the GInitiallyUnowned type.
 */
struct GInitiallyUnownedClass
{
  /**
   * the parent class
   */
  GTypeClass gTypeClass;

  GSList* constructProperties;

  extern(C) ObjectC* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties) constructor;

  extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) setProperty;

  extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) getProperty;

  extern(C) void function(ObjectC* object) dispose;

  extern(C) void function(ObjectC* object) finalize;

  extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs) dispatchPropertiesChanged;

  extern(C) void function(ObjectC* object, GParamSpec* pspec) notify;

  extern(C) void function(ObjectC* object) constructed;

  size_t flags;

  size_t nConstructProperties;

  void* pspecs;

  size_t nPspecs;

  void*[3] pdummy;
}

/**
 * A structure that provides information to the type system which is
 * used specifically for managing interface types.
 */
struct GInterfaceInfo
{
  /**
   * location of the interface initialization function
   */
  GInterfaceInitFunc interfaceInit;

  /**
   * location of the interface finalization function
   */
  GInterfaceFinalizeFunc interfaceFinalize;

  /**
   * user-supplied data passed to the interface init/finalize functions
   */
  void* interfaceData;
}

/**
 * The class structure for the GObject type.
 *
 * |[<!-- language="C" -->
 * // Example of implementing a singleton using a constructor.
 * static MySingleton *the_singleton = NULL;
 *
 * static GObject*
 * my_singleton_constructor (GType                  type,
 * guint                  n_construct_params,
 * GObjectConstructParam *construct_params)
 * {
 * GObject *object;
 *
 * if (!the_singleton)
 * {
 * object = G_OBJECT_CLASS (parent_class)->constructor (type,
 * n_construct_params,
 * construct_params);
 * the_singleton = MY_SINGLETON (object);
 * }
 * else
 * object = g_object_ref (G_OBJECT (the_singleton));
 *
 * return object;
 * }
 * ]|
 */
struct GObjectClass
{
  /**
   * the parent class
   */
  GTypeClass gTypeClass;

  GSList* constructProperties;

  extern(C) ObjectC* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties) constructor;

  extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) setProperty;

  extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) getProperty;

  extern(C) void function(ObjectC* object) dispose;

  extern(C) void function(ObjectC* object) finalize;

  extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs) dispatchPropertiesChanged;

  extern(C) void function(ObjectC* object, GParamSpec* pspec) notify;

  extern(C) void function(ObjectC* object) constructed;

  size_t flags;

  size_t nConstructProperties;

  void* pspecs;

  size_t nPspecs;

  void*[3] pdummy;
}

/**
 * The GObjectConstructParam struct is an auxiliary structure used to hand
 * #GParamSpec/#GValue pairs to the @constructor of a #GObjectClass.
 */
struct GObjectConstructParam
{
  /**
   * the #GParamSpec of the construct parameter
   */
  GParamSpec* pspec;

  /**
   * the value to set the parameter to
   */
  GValue* value;
}

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
struct ObjectC
{
  GTypeInstance gTypeInstance;

  uint refCount;

  GData* qdata;
}

/**
 * #GParamSpec is an object structure that encapsulates the metadata
 * required to specify parameters, such as e.g. #GObject properties.
 *
 * ## Parameter names # {#canonical-parameter-names}
 *
 * A property name consists of one or more segments consisting of ASCII letters
 * and digits, separated by either the `-` or `_` character. The first
 * character of a property name must be a letter. These are the same rules as
 * for signal naming (see g_signal_new()).
 *
 * When creating and looking up a #GParamSpec, either separator can be
 * used, but they cannot be mixed. Using `-` is considerably more
 * efficient, and is the ‘canonical form’. Using `_` is discouraged.
 */
struct GParamSpec
{
  /**
   * private #GTypeInstance portion
   */
  GTypeInstance gTypeInstance;

  /**
   * name of this parameter: always an interned string
   */
  const(char)* name;

  /**
   * #GParamFlags flags for this parameter
   */
  GParamFlags flags;

  /**
   * the #GValue type for this parameter
   */
  GType valueType;

  /**
   * #GType type that uses (introduces) this parameter
   */
  GType ownerType;

  char* Nick;

  char* Blurb;

  GData* qdata;

  uint refCount;

  uint paramId;
}

/**
 * A #GParamSpec derived structure that contains the meta data for boolean properties.
 */
struct GParamSpecBoolean
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * default value for the property specified
   */
  bool defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for boxed properties.
 */
struct GParamSpecBoxed
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;
}

/**
 * A #GParamSpec derived structure that contains the meta data for character properties.
 */
struct GParamSpecChar
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  byte minimum;

  /**
   * maximum value for the property specified
   */
  byte maximum;

  /**
   * default value for the property specified
   */
  byte defaultValue;
}

/**
 * The class structure for the GParamSpec type.
 * Normally, GParamSpec classes are filled by
 * g_param_type_register_static().
 */
struct GParamSpecClass
{
  /**
   * the parent class
   */
  GTypeClass gTypeClass;

  /**
   * the #GValue type for this parameter
   */
  GType valueType;

  extern(C) void function(GParamSpec* pspec) finalize;

  extern(C) void function(GParamSpec* pspec, GValue* value) valueSetDefault;

  extern(C) bool function(GParamSpec* pspec, GValue* value) valueValidate;

  extern(C) int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2) valuesCmp;

  extern(C) bool function(GParamSpec* pspec, const(GValue)* value) valueIsValid;

  void*[3] dummy;
}

/**
 * A #GParamSpec derived structure that contains the meta data for double properties.
 */
struct GParamSpecDouble
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  double minimum;

  /**
   * maximum value for the property specified
   */
  double maximum;

  /**
   * default value for the property specified
   */
  double defaultValue;

  /**
   * values closer than @epsilon will be considered identical
   * by g_param_values_cmp(); the default value is 1e-90.
   */
  double epsilon;
}

/**
 * A #GParamSpec derived structure that contains the meta data for enum
 * properties.
 */
struct GParamSpecEnum
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * the #GEnumClass for the enum
   */
  GEnumClass* enumClass;

  /**
   * default value for the property specified
   */
  int defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for flags
 * properties.
 */
struct GParamSpecFlags
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * the #GFlagsClass for the flags
   */
  GFlagsClass* flagsClass;

  /**
   * default value for the property specified
   */
  uint defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for float properties.
 */
struct GParamSpecFloat
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  float minimum;

  /**
   * maximum value for the property specified
   */
  float maximum;

  /**
   * default value for the property specified
   */
  float defaultValue;

  /**
   * values closer than @epsilon will be considered identical
   * by g_param_values_cmp(); the default value is 1e-30.
   */
  float epsilon;
}

/**
 * A #GParamSpec derived structure that contains the meta data for #GType properties.
 */
struct GParamSpecGType
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * a #GType whose subtypes can occur as values
   */
  GType isAType;
}

/**
 * A #GParamSpec derived structure that contains the meta data for integer properties.
 */
struct GParamSpecInt
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  int minimum;

  /**
   * maximum value for the property specified
   */
  int maximum;

  /**
   * default value for the property specified
   */
  int defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for 64bit integer properties.
 */
struct GParamSpecInt64
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  long minimum;

  /**
   * maximum value for the property specified
   */
  long maximum;

  /**
   * default value for the property specified
   */
  long defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for long integer properties.
 */
struct GParamSpecLong
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  long minimum;

  /**
   * maximum value for the property specified
   */
  long maximum;

  /**
   * default value for the property specified
   */
  long defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for object properties.
 */
struct GParamSpecObject
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;
}

/**
 * A #GParamSpec derived structure that redirects operations to
 * other types of #GParamSpec.
 *
 * All operations other than getting or setting the value are redirected,
 * including accessing the nick and blurb, validating a value, and so
 * forth.
 *
 * See g_param_spec_get_redirect_target() for retrieving the overridden
 * property. #GParamSpecOverride is used in implementing
 * g_object_class_override_property(), and will not be directly useful
 * unless you are implementing a new base type similar to GObject.
 */
struct GParamSpecOverride
{
  GParamSpec parentInstance;

  GParamSpec* overridden;
}

/**
 * A #GParamSpec derived structure that contains the meta data for %G_TYPE_PARAM
 * properties.
 */
struct GParamSpecParam
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;
}

/**
 * A #GParamSpec derived structure that contains the meta data for pointer properties.
 */
struct GParamSpecPointer
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;
}

/**
 * A #GParamSpecPool maintains a collection of #GParamSpecs which can be
 * quickly accessed by owner and name.
 *
 * The implementation of the #GObject property system uses such a pool to
 * store the #GParamSpecs of the properties all object types.
 */
struct GParamSpecPool;

/**
 * A #GParamSpec derived structure that contains the meta data for string
 * properties.
 */
struct GParamSpecString
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * default value for the property specified
   */
  char* defaultValue;

  /**
   * a string containing the allowed values for the first byte
   */
  char* csetFirst;

  /**
   * a string containing the allowed values for the subsequent bytes
   */
  char* csetNth;

  /**
   * the replacement byte for bytes which don't match @cset_first or @cset_nth.
   */
  char substitutor;

  /**
   * replace empty string by %NULL
   */
  uint nullFoldIfEmpty;

  /**
   * replace %NULL strings by an empty string
   */
  uint ensureNonNull;
}

/**
 * This structure is used to provide the type system with the information
 * required to initialize and destruct (finalize) a parameter's class and
 * instances thereof.
 *
 * The initialized structure is passed to the g_param_type_register_static()
 * The type system will perform a deep copy of this structure, so its memory
 * does not need to be persistent across invocation of
 * g_param_type_register_static().
 */
struct GParamSpecTypeInfo
{
  /**
   * Size of the instance (object) structure.
   */
  ushort instanceSize;

  /**
   * Prior to GLib 2.10, it specified the number of pre-allocated (cached) instances to reserve memory for (0 indicates no caching). Since GLib 2.10, it is ignored, since instances are allocated with the [slice allocator][glib-Memory-Slices] now.
   */
  ushort nPreallocs;

  extern(C) void function(GParamSpec* pspec) instanceInit;

  /**
   * The #GType of values conforming to this #GParamSpec
   */
  GType valueType;

  extern(C) void function(GParamSpec* pspec) finalize;

  extern(C) void function(GParamSpec* pspec, GValue* value) valueSetDefault;

  extern(C) bool function(GParamSpec* pspec, GValue* value) valueValidate;

  extern(C) int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2) valuesCmp;
}

/**
 * A #GParamSpec derived structure that contains the meta data for unsigned character properties.
 */
struct GParamSpecUChar
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  ubyte minimum;

  /**
   * maximum value for the property specified
   */
  ubyte maximum;

  /**
   * default value for the property specified
   */
  ubyte defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for unsigned integer properties.
 */
struct GParamSpecUInt
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  uint minimum;

  /**
   * maximum value for the property specified
   */
  uint maximum;

  /**
   * default value for the property specified
   */
  uint defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for unsigned 64bit integer properties.
 */
struct GParamSpecUInt64
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  ulong minimum;

  /**
   * maximum value for the property specified
   */
  ulong maximum;

  /**
   * default value for the property specified
   */
  ulong defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for unsigned long integer properties.
 */
struct GParamSpecULong
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * minimum value for the property specified
   */
  ulong minimum;

  /**
   * maximum value for the property specified
   */
  ulong maximum;

  /**
   * default value for the property specified
   */
  ulong defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for unichar (unsigned integer) properties.
 */
struct GParamSpecUnichar
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * default value for the property specified
   */
  dchar defaultValue;
}

/**
 * A #GParamSpec derived structure that contains the meta data for #GValueArray properties.
 */
struct GParamSpecValueArray
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * a #GParamSpec describing the elements contained in arrays of this property, may be %NULL
   */
  GParamSpec* elementSpec;

  /**
   * if greater than 0, arrays of this property will always have this many elements
   */
  uint fixedNElements;
}

/**
 * A #GParamSpec derived structure that contains the meta data for #GVariant properties.
 *
 * When comparing values with g_param_values_cmp(), scalar values with the same
 * type will be compared with g_variant_compare(). Other non-%NULL variants will
 * be checked for equality with g_variant_equal(), and their sort order is
 * otherwise undefined. %NULL is ordered before non-%NULL variants. Two %NULL
 * values compare equal.
 */
struct GParamSpecVariant
{
  /**
   * private #GParamSpec portion
   */
  GParamSpec parentInstance;

  /**
   * a #GVariantType, or %NULL
   */
  GVariantType* type;

  /**
   * a #GVariant, or %NULL
   */
  GVariant* defaultValue;

  void*[4] padding;
}

/**
 * The GParameter struct is an auxiliary structure used
 * to hand parameter name/value pairs to g_object_newv().
 */
struct GParameter
{
  /**
   * the parameter name
   */
  const(char)* name;

  /**
   * the parameter value
   */
  GValue value;
}

/**
 * #GSignalGroup manages to simplify the process of connecting
 * many signals to a #GObject as a group. As such there is no API
 * to disconnect a signal from the group.
 *
 * In particular, this allows you to:
 *
 * - Change the target instance, which automatically causes disconnection
 * of the signals from the old instance and connecting to the new instance.
 * - Block and unblock signals as a group
 * - Ensuring that blocked state transfers across target instances.
 *
 * One place you might want to use such a structure is with #GtkTextView and
 * #GtkTextBuffer. Often times, you'll need to connect to many signals on
 * #GtkTextBuffer from a #GtkTextView subclass. This allows you to create a
 * signal group during instance construction, simply bind the
 * #GtkTextView:buffer property to #GSignalGroup:target and connect
 * all the signals you need. When the #GtkTextView:buffer property changes
 * all of the signals will be transitioned correctly.
 */
struct GSignalGroup;

/**
 * The #GSignalInvocationHint structure is used to pass on additional information
 * to callbacks during a signal emission.
 */
struct GSignalInvocationHint
{
  /**
   * The signal id of the signal invoking the callback
   */
  uint signalId;

  /**
   * The detail passed on for this emission
   */
  GQuark detail;

  /**
   * The stage the signal emission is currently in, this
   * field will contain one of %G_SIGNAL_RUN_FIRST,
   * %G_SIGNAL_RUN_LAST or %G_SIGNAL_RUN_CLEANUP and %G_SIGNAL_ACCUMULATOR_FIRST_RUN.
   * %G_SIGNAL_ACCUMULATOR_FIRST_RUN is only set for the first run of the accumulator
   * function for a signal emission.
   */
  GSignalFlags runType;
}

/**
 * A structure holding in-depth information for a specific signal.
 *
 * See also: g_signal_query()
 */
struct GSignalQuery
{
  /**
   * The signal id of the signal being queried, or 0 if the
   * signal to be queried was unknown.
   */
  uint signalId;

  /**
   * The signal name.
   */
  const(char)* signalName;

  /**
   * The interface/instance type that this signal can be emitted for.
   */
  GType itype;

  /**
   * The signal flags as passed in to g_signal_new().
   */
  GSignalFlags signalFlags;

  /**
   * The return type for user callbacks.
   */
  GType returnType;

  /**
   * The number of parameters that user callbacks take.
   */
  uint nParams;

  /**
   * The individual parameter types for
   * user callbacks, note that the effective callback signature is:
   * |[<!-- language="C" -->
   * @return_type callback (#gpointer     data1,
   * [param_types param_names,]
   * gpointer     data2);
   * ]|
   */
  const(GType)* paramTypes;
}

struct GTypeCValue;

/**
 * An opaque structure used as the base of all classes.
 */
struct GTypeClass
{
  GType gType;
}

/**
 * A structure that provides information to the type system which is
 * used specifically for managing fundamental types.
 */
struct GTypeFundamentalInfo
{
  /**
   * #GTypeFundamentalFlags describing the characteristics of the fundamental type
   */
  GTypeFundamentalFlags typeFlags;
}

/**
 * This structure is used to provide the type system with the information
 * required to initialize and destruct (finalize) a type's class and
 * its instances.
 *
 * The initialized structure is passed to the g_type_register_static() function
 * (or is copied into the provided #GTypeInfo structure in the
 * g_type_plugin_complete_type_info()). The type system will perform a deep
 * copy of this structure, so its memory does not need to be persistent
 * across invocation of g_type_register_static().
 */
struct GTypeInfo
{
  /**
   * Size of the class structure (required for interface, classed and instantiatable types)
   */
  ushort classSize;

  /**
   * Location of the base initialization function (optional)
   */
  GBaseInitFunc baseInit;

  /**
   * Location of the base finalization function (optional)
   */
  GBaseFinalizeFunc baseFinalize;

  /**
   * Location of the class initialization function for
   * classed and instantiatable types. Location of the default vtable
   * inititalization function for interface types. (optional) This function
   * is used both to fill in virtual functions in the class or default vtable,
   * and to do type-specific setup such as registering signals and object
   * properties.
   */
  GClassInitFunc classInit;

  /**
   * Location of the class finalization function for
   * classed and instantiatable types. Location of the default vtable
   * finalization function for interface types. (optional)
   */
  GClassFinalizeFunc classFinalize;

  /**
   * User-supplied data passed to the class init/finalize functions
   */
  const(void)* classData;

  /**
   * Size of the instance (object) structure (required for instantiatable types only)
   */
  ushort instanceSize;

  /**
   * Prior to GLib 2.10, it specified the number of pre-allocated (cached) instances to reserve memory for (0 indicates no caching). Since GLib 2.10 this field is ignored.
   */
  ushort nPreallocs;

  /**
   * Location of the instance initialization function (optional, for instantiatable types only)
   */
  GInstanceInitFunc instanceInit;

  /**
   * A #GTypeValueTable function table for generic handling of GValues
   * of this type (usually only useful for fundamental types)
   */
  const(GTypeValueTable)* valueTable;
}

/**
 * An opaque structure used as the base of all type instances.
 */
struct GTypeInstance
{
  GTypeClass* gClass;
}

/**
 * An opaque structure used as the base of all interface types.
 */
struct GTypeInterface
{
  GType gType;

  GType gInstanceType;
}

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
struct GTypeModule
{
  ObjectC parentInstance;

  uint useCount;

  GSList* typeInfos;

  GSList* interfaceInfos;

  /**
   * the name of the module
   */
  char* name;
}

/**
 * In order to implement dynamic loading of types based on #GTypeModule,
 * the @load and @unload functions in #GTypeModuleClass must be implemented.
 */
struct GTypeModuleClass
{
  /**
   * the parent class
   */
  GObjectClass parentClass;

  extern(C) bool function(GTypeModule* module_) load;

  extern(C) void function(GTypeModule* module_) unload;

  extern(C) void function() reserved1;

  extern(C) void function() reserved2;

  extern(C) void function() reserved3;

  extern(C) void function() reserved4;
}

/**
 * An interface that handles the lifecycle of dynamically loaded types.
 *
 * The GObject type system supports dynamic loading of types.
 * It goes as follows:
 *
 * 1. The type is initially introduced (usually upon loading the module
 * the first time, or by your main application that knows what modules
 * introduces what types), like this:
 * |[<!-- language="C" -->
 * new_type_id = g_type_register_dynamic (parent_type_id,
 * "TypeName",
 * new_type_plugin,
 * type_flags);
 * ]|
 * where @new_type_plugin is an implementation of the
 * #GTypePlugin interface.
 *
 * 2. The type's implementation is referenced, e.g. through
 * g_type_class_ref() or through g_type_create_instance() (this is
 * being called by g_object_new()) or through one of the above done on
 * a type derived from @new_type_id.
 *
 * 3. This causes the type system to load the type's implementation by
 * calling g_type_plugin_use() and g_type_plugin_complete_type_info()
 * on @new_type_plugin.
 *
 * 4. At some point the type's implementation isn't required anymore,
 * e.g. after g_type_class_unref() or g_type_free_instance() (called
 * when the reference count of an instance drops to zero).
 *
 * 5. This causes the type system to throw away the information retrieved
 * from g_type_plugin_complete_type_info() and then it calls
 * g_type_plugin_unuse() on @new_type_plugin.
 *
 * 6. Things may repeat from the second step.
 *
 * So basically, you need to implement a #GTypePlugin type that
 * carries a use_count, once use_count goes from zero to one, you need
 * to load the implementation to successfully handle the upcoming
 * g_type_plugin_complete_type_info() call. Later, maybe after
 * succeeding use/unuse calls, once use_count drops to zero, you can
 * unload the implementation again. The type system makes sure to call
 * g_type_plugin_use() and g_type_plugin_complete_type_info() again
 * when the type is needed again.
 *
 * #GTypeModule is an implementation of #GTypePlugin that already
 * implements most of this except for the actual module loading and
 * unloading. It even handles multiple registered types per module.
 */
struct GTypePlugin;

/**
 * The #GTypePlugin interface is used by the type system in order to handle
 * the lifecycle of dynamically loaded types.
 */
struct GTypePluginClass
{
  GTypeInterface baseIface;

  /**
   * Increases the use count of the plugin.
   */
  GTypePluginUse usePlugin;

  /**
   * Decreases the use count of the plugin.
   */
  GTypePluginUnuse unusePlugin;

  /**
   * Fills in the #GTypeInfo and
   * #GTypeValueTable structs for the type. The structs are initialized
   * with `memset(s, 0, sizeof (s))` before calling this function.
   */
  GTypePluginCompleteTypeInfo completeTypeInfo;

  /**
   * Fills in missing parts of the #GInterfaceInfo
   * for the interface. The structs is initialized with
   * `memset(s, 0, sizeof (s))` before calling this function.
   */
  GTypePluginCompleteInterfaceInfo completeInterfaceInfo;
}

/**
 * A structure holding information for a specific type.
 *
 * See also: g_type_query()
 */
struct GTypeQuery
{
  /**
   * the #GType value of the type
   */
  GType type;

  /**
   * the name of the type
   */
  const(char)* typeName;

  /**
   * the size of the class structure
   */
  uint classSize;

  /**
   * the size of the instance structure
   */
  uint instanceSize;
}

/**
 * The #GTypeValueTable provides the functions required by the #GValue
 * implementation, to serve as a container for values of a type.
 */
struct GTypeValueTable
{
  /**
   * Function to initialize a GValue
   */
  GTypeValueInitFunc valueInit;

  /**
   * Function to free a GValue
   */
  GTypeValueFreeFunc valueFree;

  /**
   * Function to copy a GValue
   */
  GTypeValueCopyFunc valueCopy;

  /**
   * Function to peek the contents of a GValue if they fit
   * into a pointer
   */
  GTypeValuePeekPointerFunc valuePeekPointer;

  /**
   * A string format describing how to collect the contents of
   * this value bit-by-bit. Each character in the format represents
   * an argument to be collected, and the characters themselves indicate
   * the type of the argument. Currently supported arguments are:
   * - `'i'`: Integers, passed as `collect_values[].v_int`
   * - `'l'`: Longs, passed as `collect_values[].v_long`
   * - `'d'`: Doubles, passed as `collect_values[].v_double`
   * - `'p'`: Pointers, passed as `collect_values[].v_pointer`
   * It should be noted that for variable argument list construction,
   * ANSI C promotes every type smaller than an integer to an int, and
   * floats to doubles. So for collection of short int or char, `'i'`
   * needs to be used, and for collection of floats `'d'`.
   */
  const(char)* collectFormat;

  /**
   * Function to initialize a GValue from the values
   * collected from variadic arguments
   */
  GTypeValueCollectFunc collectValue;

  /**
   * Format description of the arguments to collect for @lcopy_value,
   * analogous to @collect_format. Usually, @lcopy_format string consists
   * only of `'p'`s to provide lcopy_value() with pointers to storage locations.
   */
  const(char)* lcopyFormat;

  /**
   * Function to store the contents of a value into the
   * locations collected from variadic arguments
   */
  GTypeValueLCopyFunc lcopyValue;
}

/**
 * An opaque structure used to hold different types of values.
 *
 * The data within the structure has protected scope: it is accessible only
 * to functions within a #GTypeValueTable structure, or implementations of
 * the g_value_*() API. That is, code portions which implement new fundamental
 * types.
 *
 * #GValue users cannot make any assumptions about how data is stored
 * within the 2 element @data union, and the @g_type member should
 * only be accessed through the G_VALUE_TYPE() macro.
 */
struct GValue
{
  GType gType;

  _Value__data__union[2] data;
}

/**
 * A #GValueArray contains an array of #GValue elements.
 */
struct GValueArray
{
  /**
   * number of values contained in the array
   */
  uint nValues;

  /**
   * array of values
   */
  GValue* values;

  uint nPrealloced;
}

union _Value__data__union
{
  int vInt;

  uint vUint;

  long vLong;

  ulong vUlong;

  long vInt64;

  ulong vUint64;

  float vFloat;

  double vDouble;

  void* vPointer;
}

/**
 * A structure containing a weak reference to a #GObject.
 *
 * A `GWeakRef` can either be empty (i.e. point to %NULL), or point to an
 * object for as long as at least one "strong" reference to that object
 * exists. Before the object's #GObjectClass.dispose method is called,
 * every #GWeakRef associated with becomes empty (i.e. points to %NULL).
 *
 * Like #GValue, #GWeakRef can be statically allocated, stack- or
 * heap-allocated, or embedded in larger structures.
 *
 * Unlike g_object_weak_ref() and g_object_add_weak_pointer(), this weak
 * reference is thread-safe: converting a weak pointer to a reference is
 * atomic with respect to invalidation of weak pointers to destroyed
 * objects.
 *
 * If the object's #GObjectClass.dispose method results in additional
 * references to the object being held (‘re-referencing’), any #GWeakRefs taken
 * before it was disposed will continue to point to %NULL.  Any #GWeakRefs taken
 * during disposal and after re-referencing, or after disposal has returned due
 * to the re-referencing, will continue to point to the object until its refcount
 * goes back to zero, at which point they too will be invalidated.
 *
 * It is invalid to take a #GWeakRef on an object during #GObjectClass.dispose
 * without first having or creating a strong reference to the object.
 */
struct GWeakRef
{
  union PrivType
  {
    void* p;
  }

  PrivType priv;
}

/**
 * A callback function used by the type system to finalize those portions
 * of a derived types class structure that were setup from the corresponding
 * GBaseInitFunc() function.
 *
 * Class finalization basically works the inverse way in which class
 * initialization is performed.
 *
 * See GClassInitFunc() for a discussion of the class initialization process.
 */
alias extern(C) void function(GTypeClass* gClass) GBaseFinalizeFunc;

/**
 * A callback function used by the type system to do base initialization
 * of the class structures of derived types.
 *
 * This function is called as part of the initialization process of all derived
 * classes and should reallocate or reset all dynamic class members copied over
 * from the parent class.
 *
 * For example, class members (such as strings) that are not sufficiently
 * handled by a plain memory copy of the parent class into the derived class
 * have to be altered. See GClassInitFunc() for a discussion of the class
 * initialization process.
 */
alias extern(C) void function(GTypeClass* gClass) GBaseInitFunc;

/**
 * %TRUE if the transformation was successful, and %FALSE
 * otherwise
 */
alias extern(C) bool function(GBinding* binding, const(GValue)* fromValue, GValue* toValue, void* userData) GBindingTransformFunc;

/**
 * The newly created copy of the boxed structure.
 */
alias extern(C) void* function(void* boxed) GBoxedCopyFunc;

/**
 * This function is provided by the user and should free the boxed
 * structure passed.
 */
alias extern(C) void function(void* boxed) GBoxedFreeFunc;

/**
 * The type used for callback functions in structure definitions and function
 * signatures.
 *
 * This doesn't mean that all callback functions must take no  parameters and
 * return void. The required signature of a callback function is determined by
 * the context in which is used (e.g. the signal to which it is connected).
 *
 * Use G_CALLBACK() to cast the callback function to a #GCallback.
 */
alias extern(C) void function() GCallback;

/**
 * A callback function used by the type system to finalize a class.
 *
 * This function is rarely needed, as dynamically allocated class resources
 * should be handled by GBaseInitFunc() and GBaseFinalizeFunc().
 *
 * Also, specification of a GClassFinalizeFunc() in the #GTypeInfo
 * structure of a static type is invalid, because classes of static types
 * will never be finalized (they are artificially kept alive when their
 * reference count drops to zero).
 */
alias extern(C) void function(GTypeClass* gClass, void* classData) GClassFinalizeFunc;

/**
 * A callback function used by the type system to initialize the class
 * of a specific type.
 *
 * This function should initialize all static class members.
 *
 * The initialization process of a class involves:
 *
 * - Copying common members from the parent class over to the
 * derived class structure.
 * - Zero initialization of the remaining members not copied
 * over from the parent class.
 * - Invocation of the GBaseInitFunc() initializers of all parent
 * types and the class' type.
 * - Invocation of the class' GClassInitFunc() initializer.
 *
 * Since derived classes are partially initialized through a memory copy
 * of the parent class, the general rule is that GBaseInitFunc() and
 * GBaseFinalizeFunc() should take care of necessary reinitialization
 * and release of those class members that were introduced by the type
 * that specified these GBaseInitFunc()/GBaseFinalizeFunc().
 * GClassInitFunc() should only care about initializing static
 * class members, while dynamic class members (such as allocated strings
 * or reference counted resources) are better handled by a GBaseInitFunc()
 * for this type, so proper initialization of the dynamic class members
 * is performed for class initialization of derived types as well.
 *
 * An example may help to correspond the intend of the different class
 * initializers:
 *
 * |[<!-- language="C" -->
 * typedef struct {
 * GObjectClass parent_class;
 * gint         static_integer;
 * gchar       *dynamic_string;
 * } TypeAClass;
 * static void
 * type_a_base_class_init (TypeAClass *class)
 * {
 * class->dynamic_string = g_strdup ("some string");
 * }
 * static void
 * type_a_base_class_finalize (TypeAClass *class)
 * {
 * g_free (class->dynamic_string);
 * }
 * static void
 * type_a_class_init (TypeAClass *class)
 * {
 * class->static_integer = 42;
 * }
 *
 * typedef struct {
 * TypeAClass   parent_class;
 * gfloat       static_float;
 * GString     *dynamic_gstring;
 * } TypeBClass;
 * static void
 * type_b_base_class_init (TypeBClass *class)
 * {
 * class->dynamic_gstring = g_string_new ("some other string");
 * }
 * static void
 * type_b_base_class_finalize (TypeBClass *class)
 * {
 * g_string_free (class->dynamic_gstring);
 * }
 * static void
 * type_b_class_init (TypeBClass *class)
 * {
 * class->static_float = 3.14159265358979323846;
 * }
 * ]|
 *
 * Initialization of TypeBClass will first cause initialization of
 * TypeAClass (derived classes reference their parent classes, see
 * g_type_class_ref() on this).
 *
 * Initialization of TypeAClass roughly involves zero-initializing its fields,
 * then calling its GBaseInitFunc() type_a_base_class_init() to allocate
 * its dynamic members (dynamic_string), and finally calling its GClassInitFunc()
 * type_a_class_init() to initialize its static members (static_integer).
 * The first step in the initialization process of TypeBClass is then
 * a plain memory copy of the contents of TypeAClass into TypeBClass and
 * zero-initialization of the remaining fields in TypeBClass.
 * The dynamic members of TypeAClass within TypeBClass now need
 * reinitialization which is performed by calling type_a_base_class_init()
 * with an argument of TypeBClass.
 *
 * After that, the GBaseInitFunc() of TypeBClass, type_b_base_class_init()
 * is called to allocate the dynamic members of TypeBClass (dynamic_gstring),
 * and finally the GClassInitFunc() of TypeBClass, type_b_class_init(),
 * is called to complete the initialization process with the static members
 * (static_float).
 *
 * Corresponding finalization counter parts to the GBaseInitFunc() functions
 * have to be provided to release allocated resources at class finalization
 * time.
 */
alias extern(C) void function(GTypeClass* gClass, void* classData) GClassInitFunc;

/**
 * The type used for marshaller functions.
 */
alias extern(C) void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) GClosureMarshal;

/**
 * The type used for the various notification callbacks which can be registered
 * on closures.
 */
alias extern(C) void function(void* data, GClosure* closure) GClosureNotify;

/**
 * A callback function used by the type system to initialize a new
 * instance of a type.
 *
 * This function initializes all instance members and allocates any resources
 * required by it.
 *
 * Initialization of a derived instance involves calling all its parent
 * types instance initializers, so the class member of the instance
 * is altered during its initialization to always point to the class that
 * belongs to the type the current initializer was introduced for.
 *
 * The extended members of @instance are guaranteed to have been filled with
 * zeros before this function is called.
 */
alias extern(C) void function(GTypeInstance* instance, GTypeClass* gClass) GInstanceInitFunc;

/**
 * A callback function used by the type system to finalize an interface.
 *
 * This function should destroy any internal data and release any resources
 * allocated by the corresponding GInterfaceInitFunc() function.
 */
alias extern(C) void function(GTypeInterface* gIface, void* ifaceData) GInterfaceFinalizeFunc;

/**
 * A callback function used by the type system to initialize a new
 * interface.
 *
 * This function should initialize all internal data and* allocate any
 * resources required by the interface.
 *
 * The members of @iface_data are guaranteed to have been filled with
 * zeros before this function is called.
 */
alias extern(C) void function(GTypeInterface* gIface, void* ifaceData) GInterfaceInitFunc;

/**
 * The type of the @finalize function of #GObjectClass.
 */
alias extern(C) void function(ObjectC* object) GObjectFinalizeFunc;

/**
 * The type of the @get_property function of #GObjectClass.
 */
alias extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) GObjectGetPropertyFunc;

/**
 * The type of the @set_property function of #GObjectClass.
 */
alias extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) GObjectSetPropertyFunc;

/**
 * The accumulator function returns whether the signal emission
 * should be aborted. Returning %TRUE will continue with
 * the signal emission. Returning %FALSE will abort the current emission.
 * Since 2.62, returning %FALSE will skip to the CLEANUP stage. In this case,
 * emission will occur as normal in the CLEANUP stage and the handler's
 * return value will be accumulated.
 */
alias extern(C) bool function(GSignalInvocationHint* ihint, GValue* returnAccu, const(GValue)* handlerReturn, void* data) GSignalAccumulator;

/**
 * whether it wants to stay connected. If it returns %FALSE, the signal
 * hook is disconnected (and destroyed).
 */
alias extern(C) bool function(GSignalInvocationHint* ihint, uint nParamValues, const(GValue)* paramValues, void* data) GSignalEmissionHook;

/**
 * A callback function used for notification when the state
 * of a toggle reference changes.
 *
 * See also: g_object_add_toggle_ref()
 */
alias extern(C) void function(void* data, ObjectC* object, bool isLastRef) GToggleNotify;

/**
 * %TRUE to stop further #GTypeClassCacheFuncs from being
 * called, %FALSE to continue
 */
alias extern(C) bool function(void* cacheData, GTypeClass* gClass) GTypeClassCacheFunc;

/**
 * A callback called after an interface vtable is initialized.
 *
 * See g_type_add_interface_check().
 */
alias extern(C) void function(void* checkData, GTypeInterface* gIface) GTypeInterfaceCheckFunc;

/**
 * The type of the @complete_interface_info function of #GTypePluginClass.
 */
alias extern(C) void function(GTypePlugin* plugin, GType instanceType, GType interfaceType, GInterfaceInfo* info) GTypePluginCompleteInterfaceInfo;

/**
 * The type of the @complete_type_info function of #GTypePluginClass.
 */
alias extern(C) void function(GTypePlugin* plugin, GType gType, GTypeInfo* info, GTypeValueTable* valueTable) GTypePluginCompleteTypeInfo;

/**
 * The type of the @unuse_plugin function of #GTypePluginClass.
 */
alias extern(C) void function(GTypePlugin* plugin) GTypePluginUnuse;

/**
 * The type of the @use_plugin function of #GTypePluginClass, which gets called
 * to increase the use count of @plugin.
 */
alias extern(C) void function(GTypePlugin* plugin) GTypePluginUse;

/**
 * `NULL` on success, otherwise a
 * newly allocated error string on failure
 */
alias extern(C) char* function(GValue* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags) GTypeValueCollectFunc;

/**
 * Copies the content of a #GValue into another.
 *
 * The @dest_value is a #GValue with zero-filled data section and @src_value
 * is a properly initialized #GValue of same type, or derived type.
 *
 * The purpose of this function is to copy the contents of @src_value
 * into @dest_value in a way, that even after @src_value has been freed, the
 * contents of @dest_value remain valid. String type example:
 *
 * |[<!-- language="C" -->
 * dest_value->data[0].v_pointer = g_strdup (src_value->data[0].v_pointer);
 * ]|
 */
alias extern(C) void function(const(GValue)* srcValue, GValue* destValue) GTypeValueCopyFunc;

/**
 * Frees any old contents that might be left in the `value->data` array of
 * the given value.
 *
 * No resources may remain allocated through the #GValue contents after this
 * function returns. E.g. for our above string type:
 *
 * |[<!-- language="C" -->
 * // only free strings without a specific flag for static storage
 * if (!(value->data[1].v_uint & G_VALUE_NOCOPY_CONTENTS))
 * g_free (value->data[0].v_pointer);
 * ]|
 */
alias extern(C) void function(GValue* value) GTypeValueFreeFunc;

/**
 * Initializes the value contents by setting the fields of the `value->data`
 * array.
 *
 * The data array of the #GValue passed into this function was zero-filled
 * with `memset()`, so no care has to be taken to free any old contents.
 * For example, in the case of a string value that may never be %NULL, the
 * implementation might look like:
 *
 * |[<!-- language="C" -->
 * value->data[0].v_pointer = g_strdup ("");
 * ]|
 */
alias extern(C) void function(GValue* value) GTypeValueInitFunc;

/**
 * `NULL` on success, otherwise
 * a newly allocated error string on failure
 */
alias extern(C) char* function(const(GValue)* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags) GTypeValueLCopyFunc;

/**
 * a pointer to the value contents
 */
alias extern(C) void* function(const(GValue)* value) GTypeValuePeekPointerFunc;

/**
 * This is the signature of va_list marshaller functions, an optional
 * marshaller that can be used in some situations to avoid
 * marshalling the signal argument into GValues.
 */
alias extern(C) void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) GVaClosureMarshal;

/**
 * The type of value transformation functions which can be registered with
 * g_value_register_transform_func().
 *
 * @dest_value will be initialized to the correct destination type.
 */
alias extern(C) void function(const(GValue)* srcValue, GValue* destValue) GValueTransform;

/**
 * A #GWeakNotify function can be added to an object as a callback that gets
 * triggered when the object is finalized.
 *
 * Since the object is already being disposed when the #GWeakNotify is called,
 * there's not much you could do with the object, apart from e.g. using its
 * address as hash-index or the like.
 *
 * In particular, this means it’s invalid to call g_object_ref(),
 * g_weak_ref_init(), g_weak_ref_set(), g_object_add_toggle_ref(),
 * g_object_weak_ref(), g_object_add_weak_pointer() or any function which calls
 * them on the object from this callback.
 */
alias extern(C) void function(void* data, ObjectC* whereTheObjectWas) GWeakNotify;

