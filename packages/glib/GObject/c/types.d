module GObject.c.types;

public import GLib.c.types;

/**
 * This is the signature of marshaller functions, required to marshall
 * arrays of parameter values to signal emissions into C language callback
 * invocations.
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
 * Flags to be passed to [GObject.ObjectG.bindProperty] or
 * [GObject.ObjectG.bindPropertyFull].
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
   * transformation functions to [GObject.ObjectG.bindPropertyFull].
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
   * Default behaviour $(LPAREN)no special flags$(RPAREN). Since: 2.74
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
   * calling the handler; see g_signal_connect_swapped$(LPAREN)$(RPAREN) for an example.
   */
  Swapped = 2,
}

/**
 * Through the #GParamFlags flag values, certain aspects of parameters
 * can be configured.
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
   * upon parameter conversion $(LPAREN)see [GObject.Global.paramValueConvert]$(RPAREN)
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
   * calls to [GObject.ObjectG.setProperty] for this
   * property will not automatically result in a "notify" signal being
   * emitted: the implementation must call [GObject.ObjectG.notify] themselves
   * in case the property actually changes.  Since: 2.42.
   */
  ExplicitNotify = 1073741824,

  /**
   * the parameter is deprecated and will be removed
   * in a future version. A warning will be generated if it is used
   * while running with G_ENABLE_DIAGNOSTIC\=1.
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
   * objects from user code via [GObject.Global.signalEmit] and friends, without
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
   * running with G_ENABLE_DIAGNOSTIC\=1.  Since 2.32.
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
 * The match types specify what [GObject.Global.signalHandlersBlockMatched],
 * [GObject.Global.signalHandlersUnblockMatched] and [GObject.Global.signalHandlersDisconnectMatched]
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
 * These flags used to be passed to [GObject.Global.typeInitWithDebugFlags] which
 * is now deprecated.
 * If you need to enable debugging features, use the `GOBJECT_DEBUG`
 * environment variable.

 * Deprecated: [GObject.Global.typeInit] is now done automatically
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
   * [GObject.Value.init_]
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
   * running with `G_ENABLE_DIAGNOSTIC\=1`. Since 2.76
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
   * Indicates an instantiatable type $(LPAREN)implies classed$(RPAREN)
   */
  Instantiatable = 2,

  /**
   * Indicates a flat derivable type
   */
  Derivable = 4,

  /**
   * Indicates a deep derivable type $(LPAREN)implies derivable$(RPAREN)
   */
  DeepDerivable = 8,
}

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
struct GBinding;

/**
 * `GBindingGroup` can be used to bind multiple properties
 * from an object collectively.
 * Use the various methods to bind properties from a single source
 * object to multiple destination objects. Properties can be bound
 * bidirectionally and are connected when the source object is set
 * with [GObject.BindingGroup.setSource].
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
 * A `GClosure` represents a callback supplied by the programmer.
 * It will generally comprise a function of some kind and a marshaller
 * used to call it. It is the responsibility of the marshaller to
 * convert the arguments for the invocation from #GValues into
 * a suitable form, perform the callback on the converted arguments,
 * and transform the return value back into a #GValue.
 * In the case of C programs, a closure usually just holds a pointer
 * to a function and maybe a data argument, and the marshaller
 * converts between #GValue and native C types. The GObject
 * library provides the #GCClosure type for this purpose. Bindings for
 * other languages need marshallers which convert between #GValues
 * and suitable representations in the runtime of the language in
 * order to use functions written in that language as callbacks. Use
 * [GObject.Closure.setMarshal] to set the marshaller on such a custom
 * closure implementation.
 * Within GObject, closures play an important role in the
 * implementation of signals. When a signal is registered, the
 * @c_marshaller argument to [GObject.Global.signalNew] specifies the default C
 * marshaller for any closure which is connected to this
 * signal. GObject provides a number of C marshallers for this
 * purpose, see the g_cclosure_marshal_*$(LPAREN)$(RPAREN) functions. Additional C
 * marshallers can be generated with the [glib-genmarshal][glib-genmarshal]
 * utility.  Closures can be explicitly connected to signals with
 * [GObject.Global.signalConnectClosure], but it usually more convenient to let
 * GObject create a closure automatically by using one of the
 * g_signal_connect_*$(LPAREN)$(RPAREN) functions which take a callback function/user
 * data pair.
 * Using closures has a number of important advantages over a simple
 * callback function/data pointer combination:
 * - Closures allow the callee to get the types of the callback parameters,
 * which means that language bindings don't have to write individual glue
 * for each callback type.
 * - The reference counting of #GClosure makes it easy to handle reentrancy
 * right; if a callback is removed while it is being invoked, the closure
 * and its parameters won't be freed until the invocation finishes.
 * - [GObject.Closure.invalidate] and invalidation notifiers allow callbacks to be
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
   * [GObject.Closure.invoke]
   */
  uint inMarshal;

  /**
   * Indicates whether the closure has been invalidated by
   * [GObject.Closure.invalidate]
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

  /**
   * the @constructor function is called by g_object_new $(LPAREN)$(RPAREN) to
   * complete the object initialization after all the construction properties are
   * set. The first thing a @constructor implementation must do is chain up to the
   * @constructor of the parent class. Overriding @constructor should be rarely
   * needed, e.g. to handle construct properties, or to implement singletons.
   */
  extern(C) ObjectC* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties) constructor;

  /**
   * the generic setter for all properties of this type. Should be
   * overridden for every type with properties. If implementations of
   * @set_property don't emit property change notification explicitly, this will
   * be done implicitly by the type system. However, if the notify signal is
   * emitted explicitly, the type system will not emit it a second time.
   */
  extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) setProperty;

  /**
   * the generic getter for all properties of this type. Should be
   * overridden for every type with properties.
   */
  extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) getProperty;

  /**
   * the @dispose function is supposed to drop all references to other
   * objects, but keep the instance otherwise intact, so that client method
   * invocations still work. It may be run multiple times $(LPAREN)due to reference
   * loops$(RPAREN). Before returning, @dispose should chain up to the @dispose method
   * of the parent class.
   */
  extern(C) void function(ObjectC* object) dispose;

  /**
   * instance finalization function, should finish the finalization of
   * the instance begun in @dispose and chain up to the @finalize method of the
   * parent class.
   */
  extern(C) void function(ObjectC* object) finalize;

  /**
   * emits property change notification for a bunch
   * of properties. Overriding @dispatch_properties_changed should be rarely
   * needed.
   */
  extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs) dispatchPropertiesChanged;

  /**
   * the class closure for the notify signal
   */
  extern(C) void function(ObjectC* object, GParamSpec* pspec) notify;

  /**
   * the @constructed function is called by [GObject.ObjectG.new_] as the
   * final step of the object creation process.  At the point of the call, all
   * construction properties have been set on the object.  The purpose of this
   * call is to allow for object initialisation steps that can only be performed
   * after construction properties have been set.  @constructed implementors
   * should chain up to the @constructed call of their parent class to allow it
   * to complete its initialisation.
   */
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
 * |[<!-- language\="C" -->
 * // Example of implementing a singleton using a constructor.
 * static MySingleton *the_singleton \= NULL;
 * static GObject*
 * my_singleton_constructor $(LPAREN)GType                  type,
 * guint                  n_construct_params,
 * GObjectConstructParam *construct_params$(RPAREN)
 * {
 * GObject *object;
 * if $(LPAREN)!the_singleton$(RPAREN)
 * {
 * object \= G_OBJECT_CLASS $(LPAREN)parent_class$(RPAREN)->constructor $(LPAREN)type,
 * n_construct_params,
 * construct_params$(RPAREN);
 * the_singleton \= MY_SINGLETON $(LPAREN)object$(RPAREN);
 * }
 * else
 * object \= g_object_ref $(LPAREN)G_OBJECT $(LPAREN)the_singleton$(RPAREN)$(RPAREN);
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

  /**
   * the @constructor function is called by g_object_new $(LPAREN)$(RPAREN) to
   * complete the object initialization after all the construction properties are
   * set. The first thing a @constructor implementation must do is chain up to the
   * @constructor of the parent class. Overriding @constructor should be rarely
   * needed, e.g. to handle construct properties, or to implement singletons.
   */
  extern(C) ObjectC* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties) constructor;

  /**
   * the generic setter for all properties of this type. Should be
   * overridden for every type with properties. If implementations of
   * @set_property don't emit property change notification explicitly, this will
   * be done implicitly by the type system. However, if the notify signal is
   * emitted explicitly, the type system will not emit it a second time.
   */
  extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) setProperty;

  /**
   * the generic getter for all properties of this type. Should be
   * overridden for every type with properties.
   */
  extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) getProperty;

  /**
   * the @dispose function is supposed to drop all references to other
   * objects, but keep the instance otherwise intact, so that client method
   * invocations still work. It may be run multiple times $(LPAREN)due to reference
   * loops$(RPAREN). Before returning, @dispose should chain up to the @dispose method
   * of the parent class.
   */
  extern(C) void function(ObjectC* object) dispose;

  /**
   * instance finalization function, should finish the finalization of
   * the instance begun in @dispose and chain up to the @finalize method of the
   * parent class.
   */
  extern(C) void function(ObjectC* object) finalize;

  /**
   * emits property change notification for a bunch
   * of properties. Overriding @dispatch_properties_changed should be rarely
   * needed.
   */
  extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs) dispatchPropertiesChanged;

  /**
   * the class closure for the notify signal
   */
  extern(C) void function(ObjectC* object, GParamSpec* pspec) notify;

  /**
   * the @constructed function is called by [GObject.ObjectG.new_] as the
   * final step of the object creation process.  At the point of the call, all
   * construction properties have been set on the object.  The purpose of this
   * call is to allow for object initialisation steps that can only be performed
   * after construction properties have been set.  @constructed implementors
   * should chain up to the @constructed call of their parent class to allow it
   * to complete its initialisation.
   */
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
 * `GObject` is the fundamental type providing the common attributes and
 * methods for all object types in GTK, Pango and other libraries
 * based on GObject. The `GObject` class provides methods for object
 * construction and destruction, property access methods, and signal
 * support. Signals are described in detail [here][gobject-Signals].
 * For a tutorial on implementing a new `GObject` class, see [How to define and
 * implement a new GObject]$(LPAREN)tutorial.html#how-to-define-and-implement-a-new-gobject$(RPAREN).
 * For a list of naming conventions for GObjects and their methods, see the
 * [GType conventions](concepts.html#conventions). For the high-level concepts
 * behind GObject, read
 * [Instantiatable classed types: Objects](concepts.html#instantiatable-classed-types-objects).
 * Since GLib 2.72, all `GObject`s are guaranteed to be aligned to at least the
 * alignment of the largest basic GLib type $(LPAREN)typically this is `guint64` or
 * `gdouble`$(RPAREN). If you need larger alignment for an element in a `GObject`, you
 * should allocate it on the heap $(LPAREN)aligned$(RPAREN), or arrange for your `GObject` to be
 * appropriately padded. This guarantee applies to the `GObject` $(LPAREN)or derived$(RPAREN)
 * struct, the `GObjectClass` $(LPAREN)or derived$(RPAREN) struct, and any private data allocated
 * by `G_ADD_PRIVATE$(LPAREN)$(RPAREN)`.
 */
struct ObjectC
{
  GTypeInstance gTypeInstance;

  uint refCount;

  GData* qdata;
}

/**
 * `GParamSpec` encapsulates the metadata required to specify parameters, such as `GObject` properties.
 * ## Parameter names
 * A property name consists of one or more segments consisting of ASCII letters
 * and digits, separated by either the `-` or `_` character. The first
 * character of a property name must be a letter. These are the same rules as
 * for signal naming $(LPAREN)see func@GObject.signal_new$(RPAREN).
 * When creating and looking up a `GParamSpec`, either separator can be
 * used, but they cannot be mixed. Using `-` is considerably more
 * efficient, and is the ‘canonical form’. Using `_` is discouraged.
 */
struct GParamSpec
{
  /**
   * private `GTypeInstance` portion
   */
  GTypeInstance gTypeInstance;

  /**
   * name of this parameter: always an interned string
   */
  const(char)* name;

  /**
   * `GParamFlags` flags for this parameter
   */
  GParamFlags flags;

  /**
   * the `GValue` type for this parameter
   */
  GType valueType;

  /**
   * `GType` type that uses $(LPAREN)introduces$(RPAREN) this parameter
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
 * [GObject.Global.paramTypeRegisterStatic].
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

  /**
   * The instance finalization function $(LPAREN)optional$(RPAREN), should chain
   * up to the finalize method of the parent class.
   */
  extern(C) void function(GParamSpec* pspec) finalize;

  /**
   * Resets a @value to the default value for this type
   * $(LPAREN)recommended, the default is [GObject.Value.reset]$(RPAREN), see
   * [GObject.Global.paramValueSetDefault].
   */
  extern(C) void function(GParamSpec* pspec, GValue* value) valueSetDefault;

  /**
   * Ensures that the contents of @value comply with the
   * specifications set out by this type $(LPAREN)optional$(RPAREN), see
   * [GObject.Global.paramValueValidate].
   */
  extern(C) bool function(GParamSpec* pspec, GValue* value) valueValidate;

  /**
   * Compares @value1 with @value2 according to this type
   * $(LPAREN)recommended, the default is memcmp$(LPAREN)$(RPAREN)$(RPAREN), see [GObject.Global.paramValuesCmp].
   */
  extern(C) int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2) valuesCmp;

  /**
   * Checks if contents of @value comply with the specifications
   * set out by this type, without modifying the value. This vfunc is optional.
   * If it isn't set, GObject will use @value_validate. Since 2.74
   */
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
   * by [GObject.Global.paramValuesCmp]; the default value is 1e-90.
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
   * by [GObject.Global.paramValuesCmp]; the default value is 1e-30.
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
 * All operations other than getting or setting the value are redirected,
 * including accessing the nick and blurb, validating a value, and so
 * forth.
 * See [GObject.ParamSpec.getRedirectTarget] for retrieving the overridden
 * property. #GParamSpecOverride is used in implementing
 * [GObject.ObjectClass.overrideProperty], and will not be directly useful
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
 * required to initialize and destruct $(LPAREN)finalize$(RPAREN) a parameter's class and
 * instances thereof.
 * The initialized structure is passed to the [GObject.Global.paramTypeRegisterStatic]
 * The type system will perform a deep copy of this structure, so its memory
 * does not need to be persistent across invocation of
 * [GObject.Global.paramTypeRegisterStatic].
 */
struct GParamSpecTypeInfo
{
  /**
   * Size of the instance $(LPAREN)object$(RPAREN) structure.
   */
  ushort instanceSize;

  /**
   * Prior to GLib 2.10, it specified the number of pre-allocated $(LPAREN)cached$(RPAREN) instances to reserve memory for $(LPAREN)0 indicates no caching$(RPAREN). Since GLib 2.10, it is ignored, since instances are allocated with the [slice allocator][glib-Memory-Slices] now.
   */
  ushort nPreallocs;

  /**
   * Location of the instance initialization function $(LPAREN)optional$(RPAREN).
   */
  extern(C) void function(GParamSpec* pspec) instanceInit;

  /**
   * The #GType of values conforming to this #GParamSpec
   */
  GType valueType;

  /**
   * The instance finalization function $(LPAREN)optional$(RPAREN).
   */
  extern(C) void function(GParamSpec* pspec) finalize;

  /**
   * Resets a @value to the default value for @pspec
   * $(LPAREN)recommended, the default is [GObject.Value.reset]$(RPAREN), see
   * [GObject.Global.paramValueSetDefault].
   */
  extern(C) void function(GParamSpec* pspec, GValue* value) valueSetDefault;

  /**
   * Ensures that the contents of @value comply with the
   * specifications set out by @pspec $(LPAREN)optional$(RPAREN), see
   * [GObject.Global.paramValueValidate].
   */
  extern(C) bool function(GParamSpec* pspec, GValue* value) valueValidate;

  /**
   * Compares @value1 with @value2 according to @pspec
   * $(LPAREN)recommended, the default is memcmp$(LPAREN)$(RPAREN)$(RPAREN), see [GObject.Global.paramValuesCmp].
   */
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
 * A #GParamSpec derived structure that contains the meta data for unichar $(LPAREN)unsigned integer$(RPAREN) properties.
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
 * When comparing values with [GObject.Global.paramValuesCmp], scalar values with the same
 * type will be compared with [GLib.Variant.compare]. Other non-%NULL variants will
 * be checked for equality with [GLib.Variant.equal], and their sort order is
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
 * to hand parameter name/value pairs to [GObject.ObjectG.newv].

 * Deprecated: This type is not introspectable.
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
 * `GSignalGroup` manages a collection of signals on a `GObject`.
 * `GSignalGroup` simplifies the process of connecting  many signals to a `GObject`
 * as a group. As such there is no API to disconnect a signal from the group.
 * In particular, this allows you to:
 * - Change the target instance, which automatically causes disconnection
 * of the signals from the old instance and connecting to the new instance.
 * - Block and unblock signals as a group
 * - Ensuring that blocked state transfers across target instances.
 * One place you might want to use such a structure is with `GtkTextView` and
 * `GtkTextBuffer`. Often times, you'll need to connect to many signals on
 * `GtkTextBuffer` from a `GtkTextView` subclass. This allows you to create a
 * signal group during instance construction, simply bind the
 * `GtkTextView:buffer` property to `GSignalGroup:target` and connect
 * all the signals you need. When the `GtkTextView:buffer` property changes
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
 * See also: [GObject.Global.signalQuery]
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
   * The signal flags as passed in to [GObject.Global.signalNew].
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
   * |[<!-- language\="C" -->
   * @return_type callback $(LPAREN)#gpointer     data1,
   * [param_types param_names,]
   * gpointer     data2$(RPAREN);
   * ]|
   */
  const(GType)* paramTypes;
}

/**
 * A union holding one collected value.
 */
union GTypeCValue
{
  /**
   * the field for holding integer values
   */
  int vInt;

  /**
   * the field for holding long integer values
   */
  long vLong;

  /**
   * the field for holding 64 bit integer values
   */
  long vInt64;

  /**
   * the field for holding floating point values
   */
  double vDouble;

  /**
   * the field for holding pointers
   */
  void* vPointer;
}

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
 * required to initialize and destruct $(LPAREN)finalize$(RPAREN) a type's class and
 * its instances.
 * The initialized structure is passed to the [GObject.Global.typeRegisterStatic] function
 * $(LPAREN)or is copied into the provided #GTypeInfo structure in the
 * [GObject.TypePlugin.completeTypeInfo]$(RPAREN). The type system will perform a deep
 * copy of this structure, so its memory does not need to be persistent
 * across invocation of [GObject.Global.typeRegisterStatic].
 */
struct GTypeInfo
{
  /**
   * Size of the class structure $(LPAREN)required for interface, classed and instantiatable types$(RPAREN)
   */
  ushort classSize;

  /**
   * Location of the base initialization function $(LPAREN)optional$(RPAREN)
   */
  GBaseInitFunc baseInit;

  /**
   * Location of the base finalization function $(LPAREN)optional$(RPAREN)
   */
  GBaseFinalizeFunc baseFinalize;

  /**
   * Location of the class initialization function for
   * classed and instantiatable types. Location of the default vtable
   * inititalization function for interface types. $(LPAREN)optional$(RPAREN) This function
   * is used both to fill in virtual functions in the class or default vtable,
   * and to do type-specific setup such as registering signals and object
   * properties.
   */
  GClassInitFunc classInit;

  /**
   * Location of the class finalization function for
   * classed and instantiatable types. Location of the default vtable
   * finalization function for interface types. $(LPAREN)optional$(RPAREN)
   */
  GClassFinalizeFunc classFinalize;

  /**
   * User-supplied data passed to the class init/finalize functions
   */
  const(void)* classData;

  /**
   * Size of the instance $(LPAREN)object$(RPAREN) structure $(LPAREN)required for instantiatable types only$(RPAREN)
   */
  ushort instanceSize;

  /**
   * Prior to GLib 2.10, it specified the number of pre-allocated $(LPAREN)cached$(RPAREN) instances to reserve memory for $(LPAREN)0 indicates no caching$(RPAREN). Since GLib 2.10 this field is ignored.
   */
  ushort nPreallocs;

  /**
   * Location of the instance initialization function $(LPAREN)optional, for instantiatable types only$(RPAREN)
   */
  GInstanceInitFunc instanceInit;

  /**
   * A #GTypeValueTable function table for generic handling of GValues
   * of this type $(LPAREN)usually only useful for fundamental types$(RPAREN)
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

  /**
   * loads the module and registers one or more types using
   * [GObject.TypeModule.registerType].
   */
  extern(C) bool function(GTypeModule* module_) load;

  /**
   * unloads the module
   */
  extern(C) void function(GTypeModule* module_) unload;

  extern(C) void function() reserved1;

  extern(C) void function() reserved2;

  extern(C) void function() reserved3;

  extern(C) void function() reserved4;
}

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
   * with `memset$(LPAREN)s, 0, sizeof $(LPAREN)s$(RPAREN)$(RPAREN)` before calling this function.
   */
  GTypePluginCompleteTypeInfo completeTypeInfo;

  /**
   * Fills in missing parts of the #GInterfaceInfo
   * for the interface. The structs is initialized with
   * `memset$(LPAREN)s, 0, sizeof $(LPAREN)s$(RPAREN)$(RPAREN)` before calling this function.
   */
  GTypePluginCompleteInterfaceInfo completeInterfaceInfo;
}

/**
 * A structure holding information for a specific type.
 * See also: [GObject.Global.typeQuery]
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
   * only of `'p'`s to provide lcopy_value$(LPAREN)$(RPAREN) with pointers to storage locations.
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
 * The data within the structure has protected scope: it is accessible only
 * to functions within a #GTypeValueTable structure, or implementations of
 * the g_value_*$(LPAREN)$(RPAREN) API. That is, code portions which implement new fundamental
 * types.
 * #GValue users cannot make any assumptions about how data is stored
 * within the 2 element @data union, and the @g_type member should
 * only be accessed through the G_VALUE_TYPE$(LPAREN)$(RPAREN) macro.
 */
struct GValue
{
  GType gType;

  _Value__data__union[2] data;
}

/**
 * A `GValueArray` is a container structure to hold an array of generic values.
 * The prime purpose of a `GValueArray` is for it to be used as an
 * object property that holds an array of values. A `GValueArray` wraps
 * an array of `GValue` elements in order for it to be used as a boxed
 * type through `G_TYPE_VALUE_ARRAY`.
 * `GValueArray` is deprecated in favour of `GArray` since GLib 2.32.
 * It is possible to create a `GArray` that behaves like a `GValueArray`
 * by using the size of `GValue` as the element size, and by setting
 * [GObject.Value.unset] as the clear function using
 * [GLib.ArrayG.setClearFunc], for instance, the following code:
 * ```c
 * GValueArray *array \= g_value_array_new $(LPAREN)10$(RPAREN);
 * ```
 * can be replaced by:
 * ```c
 * GArray *array \= g_array_sized_new $(LPAREN)FALSE, TRUE, sizeof $(LPAREN)GValue$(RPAREN), 10$(RPAREN);
 * g_array_set_clear_func $(LPAREN)array, $(LPAREN)GDestroyNotify$(RPAREN) g_value_unset$(RPAREN);
 * ```

 * Deprecated: Use `GArray` instead, if possible for the given use case,
 *   as described above.
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
 * A `GWeakRef` can either be empty $(LPAREN)i.e. point to %NULL$(RPAREN), or point to an
 * object for as long as at least one "strong" reference to that object
 * exists. Before the object's #GObjectClass.dispose method is called,
 * every #GWeakRef associated with becomes empty $(LPAREN)i.e. points to %NULL$(RPAREN).
 * Like #GValue, #GWeakRef can be statically allocated, stack- or
 * heap-allocated, or embedded in larger structures.
 * Unlike [GObject.ObjectG.weakRef] and [GObject.ObjectG.addWeakPointer], this weak
 * reference is thread-safe: converting a weak pointer to a reference is
 * atomic with respect to invalidation of weak pointers to destroyed
 * objects.
 * If the object's #GObjectClass.dispose method results in additional
 * references to the object being held $(LPAREN)‘re-referencing’$(RPAREN), any #GWeakRefs taken
 * before it was disposed will continue to point to %NULL.  Any #GWeakRefs taken
 * during disposal and after re-referencing, or after disposal has returned due
 * to the re-referencing, will continue to point to the object until its refcount
 * goes back to zero, at which point they too will be invalidated.
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

alias extern(C) void function(GTypeClass* gClass) GBaseFinalizeFunc;

alias extern(C) void function(GTypeClass* gClass) GBaseInitFunc;

alias extern(C) bool function(GBinding* binding, const(GValue)* fromValue, GValue* toValue, void* userData) GBindingTransformFunc;

alias extern(C) void* function(void* boxed) GBoxedCopyFunc;

alias extern(C) void function(void* boxed) GBoxedFreeFunc;

alias extern(C) void function() GCallback;

alias extern(C) void function(GTypeClass* gClass, void* classData) GClassFinalizeFunc;

alias extern(C) void function(GTypeClass* gClass, void* classData) GClassInitFunc;

alias extern(C) void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) GClosureMarshal;

alias extern(C) void function(void* data, GClosure* closure) GClosureNotify;

alias extern(C) void function(GTypeInstance* instance, GTypeClass* gClass) GInstanceInitFunc;

alias extern(C) void function(GTypeInterface* gIface, void* ifaceData) GInterfaceFinalizeFunc;

alias extern(C) void function(GTypeInterface* gIface, void* ifaceData) GInterfaceInitFunc;

alias extern(C) void function(ObjectC* object) GObjectFinalizeFunc;

alias extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec) GObjectGetPropertyFunc;

alias extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec) GObjectSetPropertyFunc;

alias extern(C) bool function(GSignalInvocationHint* ihint, GValue* returnAccu, const(GValue)* handlerReturn, void* data) GSignalAccumulator;

alias extern(C) bool function(GSignalInvocationHint* ihint, uint nParamValues, const(GValue)* paramValues, void* data) GSignalEmissionHook;

alias extern(C) void function(void* data, ObjectC* object, bool isLastRef) GToggleNotify;

alias extern(C) bool function(void* cacheData, GTypeClass* gClass) GTypeClassCacheFunc;

alias extern(C) void function(void* checkData, GTypeInterface* gIface) GTypeInterfaceCheckFunc;

alias extern(C) void function(GTypePlugin* plugin, GType instanceType, GType interfaceType, GInterfaceInfo* info) GTypePluginCompleteInterfaceInfo;

alias extern(C) void function(GTypePlugin* plugin, GType gType, GTypeInfo* info, GTypeValueTable* valueTable) GTypePluginCompleteTypeInfo;

alias extern(C) void function(GTypePlugin* plugin) GTypePluginUnuse;

alias extern(C) void function(GTypePlugin* plugin) GTypePluginUse;

alias extern(C) char* function(GValue* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags) GTypeValueCollectFunc;

alias extern(C) void function(const(GValue)* srcValue, GValue* destValue) GTypeValueCopyFunc;

alias extern(C) void function(GValue* value) GTypeValueFreeFunc;

alias extern(C) void function(GValue* value) GTypeValueInitFunc;

alias extern(C) char* function(const(GValue)* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags) GTypeValueLCopyFunc;

alias extern(C) void* function(const(GValue)* value) GTypeValuePeekPointerFunc;

alias extern(C) void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) GVaClosureMarshal;

alias extern(C) void function(const(GValue)* srcValue, GValue* destValue) GValueTransform;

alias extern(C) void function(void* data, ObjectC* whereTheObjectWas) GWeakNotify;

