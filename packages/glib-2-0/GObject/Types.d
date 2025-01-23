module GObject.Types;

import GObject.Binding;
import GObject.Closure;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.TypeClass;
import GObject.TypeInfoG;
import GObject.TypeInstance;
import GObject.TypeInterface;
import GObject.TypePlugin;
import GObject.TypePluginT;
import GObject.TypeValueTable;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;


// Aliases
alias SignalCMarshaller = ClosureMarshal;
alias GType = GObject.c.types.GType;

// Enums
alias BindingFlags = GBindingFlags;
alias ConnectFlags = GConnectFlags;
alias ParamFlags = GParamFlags;
alias SignalFlags = GSignalFlags;
alias SignalMatchType = GSignalMatchType;
alias TypeDebugFlags = GTypeDebugFlags;
alias TypeFlags = GTypeFlags;
alias TypeFundamentalFlags = GTypeFundamentalFlags;

// Structs
alias ClosureNotifyData = GClosureNotifyData;
alias InterfaceInfo = GInterfaceInfo;
alias ParamSpecTypeInfo = GParamSpecTypeInfo;
alias SignalInvocationHint = GSignalInvocationHint;
alias TypeCValue = GTypeCValue;
alias TypeFundamentalInfo = GTypeFundamentalInfo;

// Callbacks
alias BaseFinalizeFunc = void delegate(TypeClass gClass);
alias BaseInitFunc = void delegate(TypeClass gClass);
alias BindingTransformFunc = bool delegate(Binding binding, Value fromValue, Value toValue);
alias BoxedCopyFunc = void* delegate(void* boxed);
alias BoxedFreeFunc = void delegate(void* boxed);
alias Callback = void delegate();
alias ClassFinalizeFunc = void delegate(TypeClass gClass);
alias ClassInitFunc = void delegate(TypeClass gClass);
alias ClosureMarshal = void delegate(Closure closure, Value returnValue, Value[] paramValues, void* invocationHint);
alias ClosureNotify = void delegate(Closure closure);
alias InstanceInitFunc = void delegate(TypeInstance instance, TypeClass gClass);
alias InterfaceFinalizeFunc = void delegate(TypeInterface gIface);
alias InterfaceInitFunc = void delegate(TypeInterface gIface);
alias ObjectFinalizeFunc = void delegate(ObjectG object);
alias ObjectGetPropertyFunc = void delegate(ObjectG object, uint propertyId, Value value, ParamSpec pspec);
alias ObjectSetPropertyFunc = void delegate(ObjectG object, uint propertyId, Value value, ParamSpec pspec);
alias SignalAccumulator = bool delegate(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn);
alias SignalEmissionHook = bool delegate(SignalInvocationHint ihint, Value[] paramValues);
alias ToggleNotify = void delegate(ObjectG object, bool isLastRef);
alias TypeClassCacheFunc = bool delegate(TypeClass gClass);
alias TypeInterfaceCheckFunc = void delegate(TypeInterface gIface);
alias TypePluginCompleteInterfaceInfo = void delegate(TypePlugin plugin, GType instanceType, GType interfaceType, InterfaceInfo info);
alias TypePluginCompleteTypeInfo = void delegate(TypePlugin plugin, GType gType, TypeInfoG info, TypeValueTable valueTable);
alias TypePluginUnuse = void delegate(TypePlugin plugin);
alias TypePluginUse = void delegate(TypePlugin plugin);
alias TypeValueCollectFunc = string delegate(Value value, TypeCValue[] collectValues, uint collectFlags);
alias TypeValueCopyFunc = void delegate(Value srcValue, out Value destValue);
alias TypeValueFreeFunc = void delegate(Value value);
alias TypeValueInitFunc = void delegate(Value value);
alias TypeValueLCopyFunc = string delegate(Value value, TypeCValue[] collectValues, uint collectFlags);
alias TypeValuePeekPointerFunc = void* delegate(Value value);
alias ValueTransform = void delegate(Value srcValue, Value destValue);
alias WeakNotify = void delegate(ObjectG whereTheObjectWas);

/**
 * Mask containing the bits of #GParamSpec.flags which are reserved for GLib.
 */
enum PARAM_MASK = 255;


/**
 * #GParamFlags value alias for %G_PARAM_STATIC_NAME | %G_PARAM_STATIC_NICK | %G_PARAM_STATIC_BLURB.
 * It is recommended to use this for all properties by default, as it allows for
 * internal performance improvements in GObject.
 * It is very rare that a property would have a dynamically constructed name,
 * nickname or blurb.
 * Since 2.13.0
 */
enum PARAM_STATIC_STRINGS = 224;


/**
 * Minimum shift count to be used for user defined flags, to be stored in
 * #GParamSpec.flags. The maximum allowed is 10.
 */
enum PARAM_USER_SHIFT = 8;


/**
 * A mask for all #GSignalFlags bits.
 */
enum SIGNAL_FLAGS_MASK = 511;


/**
 * A mask for all #GSignalMatchType bits.
 */
enum SIGNAL_MATCH_MASK = 63;


/**
 * A bit in the type number that's supposed to be left untouched.
 */
enum TYPE_FLAG_RESERVED_ID_BIT = 1;


/**
 * An integer constant that represents the number of identifiers reserved
 * for types that are assigned at compile-time.
 */
enum TYPE_FUNDAMENTAL_MAX = 1020;


/**
 * Shift value used in converting numbers to type IDs.
 */
enum TYPE_FUNDAMENTAL_SHIFT = 2;


/**
 * First fundamental type number to create a new fundamental type id with
 * G_TYPE_MAKE_FUNDAMENTAL$(LPAREN)$(RPAREN) reserved for BSE.
 */
enum TYPE_RESERVED_BSE_FIRST = 32;


/**
 * Last fundamental type number reserved for BSE.
 */
enum TYPE_RESERVED_BSE_LAST = 48;


/**
 * First fundamental type number to create a new fundamental type id with
 * G_TYPE_MAKE_FUNDAMENTAL$(LPAREN)$(RPAREN) reserved for GLib.
 */
enum TYPE_RESERVED_GLIB_FIRST = 22;


/**
 * Last fundamental type number reserved for GLib.
 */
enum TYPE_RESERVED_GLIB_LAST = 31;


/**
 * First available fundamental type number to create new fundamental
 * type id with G_TYPE_MAKE_FUNDAMENTAL$(LPAREN)$(RPAREN).
 */
enum TYPE_RESERVED_USER_FIRST = 49;


/**
 * The maximal number of #GTypeCValues which can be collected for a
 * single #GValue.
 */
enum VALUE_COLLECT_FORMAT_MAX_LENGTH = 8;


/**
 * For string values, indicates that the string contained is canonical and will
 * exist for the duration of the process. See [GObject.Value.setInternedString].
 */
enum VALUE_INTERNED_STRING = 268435456;


/**
 * If passed to G_VALUE_COLLECT$(LPAREN)$(RPAREN), allocated data won't be copied
 * but used verbatim. This does not affect ref-counted types like
 * objects. This does not affect usage of [GObject.Value.copy], the data will
 * be copied if it is not ref-counted.
 */
enum VALUE_NOCOPY_CONTENTS = 134217728;


enum GTypeFundamentalShift = 2; /// Fundamental GType shift value (G_TYPE_FUNDAMENTAL_SHIFT)

/// Fundamental GType values as an enum
enum GTypeEnum
{
  Invalid = 0 << GTypeFundamentalShift,
  None = 1 << GTypeFundamentalShift,
  Interface = 2 << GTypeFundamentalShift,
  Char = 3 << GTypeFundamentalShift,
  Uchar = 4 << GTypeFundamentalShift,
  Boolean = 5 << GTypeFundamentalShift,
  Int = 6 << GTypeFundamentalShift,
  Uint = 7 << GTypeFundamentalShift,
  Long = 8 << GTypeFundamentalShift,
  Ulong = 9 << GTypeFundamentalShift,
  Int64 = 10 << GTypeFundamentalShift,
  Uint64 = 11 << GTypeFundamentalShift,
  Enum = 12 << GTypeFundamentalShift,
  Flags = 13 << GTypeFundamentalShift,
  Float = 14 << GTypeFundamentalShift,
  Double = 15 << GTypeFundamentalShift,
  String = 16 << GTypeFundamentalShift,
  Pointer = 17 << GTypeFundamentalShift,
  Boxed = 18 << GTypeFundamentalShift,
  Param = 19 << GTypeFundamentalShift,
  Object = 20 << GTypeFundamentalShift,
  Variant = 21 << GTypeFundamentalShift,
}
