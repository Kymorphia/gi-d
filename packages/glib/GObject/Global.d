module GObject.Global;

import GLib.Source;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.Closure;
import GObject.EnumClass;
import GObject.EnumValue;
import GObject.FlagsClass;
import GObject.FlagsValue;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.SignalQuery;
import GObject.TypeClass;
import GObject.TypeInfoG;
import GObject.TypeInstance;
import GObject.TypeInterface;
import GObject.TypePlugin;
import GObject.TypeQuery;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;


/**
 * The newly created copy of the boxed
 * structure.
 */
void* boxedCopy(GType boxedType, const(void)* srcBoxed)
{
  void* _retval;
  _retval = g_boxed_copy(boxedType, srcBoxed);
  return _retval;
}

/**
 * Free the boxed structure @boxed which is of type @boxed_type.
 */
void boxedFree(GType boxedType, void* boxed)
{
  g_boxed_free(boxedType, boxed);
}

/**
 * Disconnects a handler from @instance so it will not be called during
 * any future or currently ongoing emissions of the signal it has been
 * connected to. The @handler_id_ptr is then set to zero, which is never a valid handler ID value (see g_signal_connect()).
 *
 * If the handler ID is 0 then this function does nothing.
 *
 * There is also a macro version of this function so that the code
 * will be inlined.
 */
void clearSignalHandler(inout ulong handlerIdPtr, ObjectG instance)
{
  g_clear_signal_handler(cast(ulong*)&handlerIdPtr, instance ? instance.cPtr!ObjectC : null);
}

/**
 * This function is meant to be called from the `complete_type_info`
 * function of a #GTypePlugin implementation, as in the following
 * example:
 *
 * |[<!-- language="C" -->
 * static void
 * my_enum_complete_type_info (GTypePlugin     *plugin,
 * GType            g_type,
 * GTypeInfo       *info,
 * GTypeValueTable *value_table)
 * {
 * static const GEnumValue values[] = {
 * { MY_ENUM_FOO, "MY_ENUM_FOO", "foo" },
 * { MY_ENUM_BAR, "MY_ENUM_BAR", "bar" },
 * { 0, NULL, NULL }
 * };
 *
 * g_enum_complete_type_info (type, info, values);
 * }
 * ]|
 */
void enumCompleteTypeInfo(GType gEnumType, out TypeInfoG info, EnumValue constValues)
{
  GTypeInfo _info;
  g_enum_complete_type_info(gEnumType, &_info, constValues ? constValues.cPtr!GEnumValue : null);
  info = new TypeInfoG(cast(void*)&_info);
}

/**
 * the #GEnumValue for @value, or %NULL
 * if @value is not a member of the enumeration
 */
EnumValue enumGetValue(EnumClass enumClass, int value)
{
  GEnumValue* _cretval;
  _cretval = g_enum_get_value(enumClass ? enumClass.cPtr!GEnumClass : null, value);
  EnumValue _retval = new EnumValue(cast(GEnumValue*)_cretval);
  return _retval;
}

/**
 * the #GEnumValue with name @name,
 * or %NULL if the enumeration doesn't have a member
 * with that name
 */
EnumValue enumGetValueByName(EnumClass enumClass, string name)
{
  GEnumValue* _cretval;
  const(char)* _name = name.toCString(false);
  _cretval = g_enum_get_value_by_name(enumClass ? enumClass.cPtr!GEnumClass : null, _name);
  EnumValue _retval = new EnumValue(cast(GEnumValue*)_cretval);
  return _retval;
}

/**
 * the #GEnumValue with nickname @nick,
 * or %NULL if the enumeration doesn't have a member
 * with that nickname
 */
EnumValue enumGetValueByNick(EnumClass enumClass, string nick)
{
  GEnumValue* _cretval;
  const(char)* _nick = nick.toCString(false);
  _cretval = g_enum_get_value_by_nick(enumClass ? enumClass.cPtr!GEnumClass : null, _nick);
  EnumValue _retval = new EnumValue(cast(GEnumValue*)_cretval);
  return _retval;
}

/**
 * The new type identifier.
 */
GType enumRegisterStatic(string name, EnumValue constStaticValues)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_enum_register_static(_name, constStaticValues ? constStaticValues.cPtr!GEnumValue : null);
  return _retval;
}

/**
 * a newly-allocated text string
 */
string enumToString(GType gEnumType, int value)
{
  char* _cretval;
  _cretval = g_enum_to_string(gEnumType, value);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * This function is meant to be called from the complete_type_info()
 * function of a #GTypePlugin implementation, see the example for
 * g_enum_complete_type_info() above.
 */
void flagsCompleteTypeInfo(GType gFlagsType, out TypeInfoG info, FlagsValue constValues)
{
  GTypeInfo _info;
  g_flags_complete_type_info(gFlagsType, &_info, constValues ? constValues.cPtr!GFlagsValue : null);
  info = new TypeInfoG(cast(void*)&_info);
}

/**
 * the first #GFlagsValue which is set in
 * @value, or %NULL if none is set
 */
FlagsValue flagsGetFirstValue(FlagsClass flagsClass, uint value)
{
  GFlagsValue* _cretval;
  _cretval = g_flags_get_first_value(flagsClass ? flagsClass.cPtr!GFlagsClass : null, value);
  FlagsValue _retval = new FlagsValue(cast(GFlagsValue*)_cretval);
  return _retval;
}

/**
 * the #GFlagsValue with name @name,
 * or %NULL if there is no flag with that name
 */
FlagsValue flagsGetValueByName(FlagsClass flagsClass, string name)
{
  GFlagsValue* _cretval;
  const(char)* _name = name.toCString(false);
  _cretval = g_flags_get_value_by_name(flagsClass ? flagsClass.cPtr!GFlagsClass : null, _name);
  FlagsValue _retval = new FlagsValue(cast(GFlagsValue*)_cretval);
  return _retval;
}

/**
 * the #GFlagsValue with nickname @nick,
 * or %NULL if there is no flag with that nickname
 */
FlagsValue flagsGetValueByNick(FlagsClass flagsClass, string nick)
{
  GFlagsValue* _cretval;
  const(char)* _nick = nick.toCString(false);
  _cretval = g_flags_get_value_by_nick(flagsClass ? flagsClass.cPtr!GFlagsClass : null, _nick);
  FlagsValue _retval = new FlagsValue(cast(GFlagsValue*)_cretval);
  return _retval;
}

/**
 * The new type identifier.
 */
GType flagsRegisterStatic(string name, FlagsValue constStaticValues)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_flags_register_static(_name, constStaticValues ? constStaticValues.cPtr!GFlagsValue : null);
  return _retval;
}

/**
 * a newly-allocated text string
 */
string flagsToString(GType flagsType, uint value)
{
  char* _cretval;
  _cretval = g_flags_to_string(flagsType, value);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

GType gtypeGetType()
{
  GType _retval;
  _retval = g_gtype_get_type();
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecBoolean(string name, string nick, string blurb, bool defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_boolean(_name, _nick, _blurb, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecBoxed(string name, string nick, string blurb, GType boxedType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_boxed(_name, _nick, _blurb, boxedType, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecChar(string name, string nick, string blurb, byte minimum, byte maximum, byte defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_char(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecDouble(string name, string nick, string blurb, double minimum, double maximum, double defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_double(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecEnum(string name, string nick, string blurb, GType enumType, int defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_enum(_name, _nick, _blurb, enumType, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecFlags(string name, string nick, string blurb, GType flagsType, uint defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_flags(_name, _nick, _blurb, flagsType, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecFloat(string name, string nick, string blurb, float minimum, float maximum, float defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_float(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecGtype(string name, string nick, string blurb, GType isAType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_gtype(_name, _nick, _blurb, isAType, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecInt(string name, string nick, string blurb, int minimum, int maximum, int defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_int(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecInt64(string name, string nick, string blurb, long minimum, long maximum, long defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_int64(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecLong(string name, string nick, string blurb, long minimum, long maximum, long defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_long(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecObject(string name, string nick, string blurb, GType objectType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_object(_name, _nick, _blurb, objectType, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecParam(string name, string nick, string blurb, GType paramType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_param(_name, _nick, _blurb, paramType, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecPointer(string name, string nick, string blurb, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_pointer(_name, _nick, _blurb, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecString(string name, string nick, string blurb, string defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  const(char)* _defaultValue = defaultValue.toCString(false);
  _cretval = g_param_spec_string(_name, _nick, _blurb, _defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecUchar(string name, string nick, string blurb, ubyte minimum, ubyte maximum, ubyte defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uchar(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecUint(string name, string nick, string blurb, uint minimum, uint maximum, uint defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uint(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecUint64(string name, string nick, string blurb, ulong minimum, ulong maximum, ulong defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uint64(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecUlong(string name, string nick, string blurb, ulong minimum, ulong maximum, ulong defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_ulong(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * a newly created parameter specification
 */
ParamSpec paramSpecUnichar(string name, string nick, string blurb, dchar defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_unichar(_name, _nick, _blurb, defaultValue, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * the newly created #GParamSpec
 */
ParamSpec paramSpecVariant(string name, string nick, string blurb, VariantType type, Variant defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_variant(_name, _nick, _blurb, type ? type.cPtr!GVariantType : null, defaultValue ? defaultValue.cPtr!GVariant : null, flags);
  ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, true);
  return _retval;
}

/**
 * The new type identifier.
 */
GType paramTypeRegisterStatic(string name, ParamSpecTypeInfo pspecInfo)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_param_type_register_static(_name, &pspecInfo);
  return _retval;
}

/**
 * %TRUE if transformation and validation were successful,
 * %FALSE otherwise and @dest_value is left untouched.
 */
bool paramValueConvert(ParamSpec pspec, Value srcValue, Value destValue, bool strictValidation)
{
  bool _retval;
  _retval = g_param_value_convert(pspec ? pspec.cPtr!GParamSpec : null, srcValue ? srcValue.cPtr!GValue : null, destValue ? destValue.cPtr!GValue : null, strictValidation);
  return _retval;
}

/**
 * whether @value contains the canonical default for this @pspec
 */
bool paramValueDefaults(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_defaults(pspec ? pspec.cPtr!GParamSpec : null, value ? value.cPtr!GValue : null);
  return _retval;
}

/**
 * whether the contents of @value comply with the specifications
 * set out by @pspec.
 */
bool paramValueIsValid(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_is_valid(pspec ? pspec.cPtr!GParamSpec : null, value ? value.cPtr!GValue : null);
  return _retval;
}

/**
 * Sets @value to its default value as specified in @pspec.
 */
void paramValueSetDefault(ParamSpec pspec, Value value)
{
  g_param_value_set_default(pspec ? pspec.cPtr!GParamSpec : null, value ? value.cPtr!GValue : null);
}

/**
 * whether modifying @value was necessary to ensure validity
 */
bool paramValueValidate(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_validate(pspec ? pspec.cPtr!GParamSpec : null, value ? value.cPtr!GValue : null);
  return _retval;
}

/**
 * -1, 0 or +1, for a less than, equal to or greater than result
 */
int paramValuesCmp(ParamSpec pspec, Value value1, Value value2)
{
  int _retval;
  _retval = g_param_values_cmp(pspec ? pspec.cPtr!GParamSpec : null, value1 ? value1.cPtr!GValue : null, value2 ? value2.cPtr!GValue : null);
  return _retval;
}

/**
 * a new %G_TYPE_POINTER derived type id for @name.
 */
GType pointerTypeRegisterStatic(string name)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_pointer_type_register_static(_name);
  return _retval;
}

/**
 * standard #GSignalAccumulator result
 */
bool signalAccumulatorFirstWins(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, void* dummy)
{
  bool _retval;
  _retval = g_signal_accumulator_first_wins(&ihint, returnAccu ? returnAccu.cPtr!GValue : null, handlerReturn ? handlerReturn.cPtr!GValue : null, dummy);
  return _retval;
}

/**
 * standard #GSignalAccumulator result
 */
bool signalAccumulatorTrueHandled(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, void* dummy)
{
  bool _retval;
  _retval = g_signal_accumulator_true_handled(&ihint, returnAccu ? returnAccu.cPtr!GValue : null, handlerReturn ? handlerReturn.cPtr!GValue : null, dummy);
  return _retval;
}

/**
 * the hook id, for later use with g_signal_remove_emission_hook().
 */
ulong signalAddEmissionHook(uint signalId, Quark detail, SignalEmissionHook hookFunc)
{
  extern(C) bool _hookFuncCallback(GSignalInvocationHint* ihint, uint nParamValues, const(GValue)* paramValues, void* data)
  {
    Value[] _paramValues;
    foreach (i; 0 .. nParamValues)
      _paramValues ~= new Value(cast(GValue*)&paramValues[i], false);

    bool _retval = (*(cast(SignalEmissionHook*)data))(*ihint, _paramValues);
    return _retval;
  }

  ulong _retval;
  ptrFreezeGC(cast(void*)&hookFunc);
  _retval = g_signal_add_emission_hook(signalId, detail, &_hookFuncCallback, cast(void*)&hookFunc, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * the handler ID (always greater than 0 for successful connections)
 */
ulong signalConnectClosure(ObjectG instance, string detailedSignal, Closure closure, bool after)
{
  ulong _retval;
  const(char)* _detailedSignal = detailedSignal.toCString(false);
  _retval = g_signal_connect_closure(instance ? instance.cPtr!ObjectC : null, _detailedSignal, closure ? closure.cPtr!GClosure : null, after);
  return _retval;
}

/**
 * the handler ID (always greater than 0 for successful connections)
 */
ulong signalConnectClosureById(ObjectG instance, uint signalId, Quark detail, Closure closure, bool after)
{
  ulong _retval;
  _retval = g_signal_connect_closure_by_id(instance ? instance.cPtr!ObjectC : null, signalId, detail, closure ? closure.cPtr!GClosure : null, after);
  return _retval;
}

/**
 * the invocation hint of the innermost
 * signal emission, or %NULL if not found.
 */
SignalInvocationHint signalGetInvocationHint(ObjectG instance)
{
  GSignalInvocationHint* _cretval;
  _cretval = g_signal_get_invocation_hint(instance ? instance.cPtr!ObjectC : null);
  SignalInvocationHint _retval;
  if (_cretval)
    _retval = *_cretval;
  return _retval;
}

/**
 * Blocks a handler of an instance so it will not be called during any
 * signal emissions unless it is unblocked again. Thus "blocking" a
 * signal handler means to temporarily deactivate it, a signal handler
 * has to be unblocked exactly the same amount of times it has been
 * blocked before to become active again.
 *
 * The @handler_id has to be a valid signal handler id, connected to a
 * signal of @instance.
 */
void signalHandlerBlock(ObjectG instance, ulong handlerId)
{
  g_signal_handler_block(instance ? instance.cPtr!ObjectC : null, handlerId);
}

/**
 * Disconnects a handler from an instance so it will not be called during
 * any future or currently ongoing emissions of the signal it has been
 * connected to. The @handler_id becomes invalid and may be reused.
 *
 * The @handler_id has to be a valid signal handler id, connected to a
 * signal of @instance.
 */
void signalHandlerDisconnect(ObjectG instance, ulong handlerId)
{
  g_signal_handler_disconnect(instance ? instance.cPtr!ObjectC : null, handlerId);
}

/**
 * A valid non-0 signal handler id for a successful match.
 */
ulong signalHandlerFind(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  ulong _retval;
  _retval = g_signal_handler_find(instance ? instance.cPtr!ObjectC : null, mask, signalId, detail, closure ? closure.cPtr!GClosure : null, func, null);
  return _retval;
}

/**
 * whether @handler_id identifies a handler connected to @instance.
 */
bool signalHandlerIsConnected(ObjectG instance, ulong handlerId)
{
  bool _retval;
  _retval = g_signal_handler_is_connected(instance ? instance.cPtr!ObjectC : null, handlerId);
  return _retval;
}

/**
 * Undoes the effect of a previous g_signal_handler_block() call.  A
 * blocked handler is skipped during signal emissions and will not be
 * invoked, unblocking it (for exactly the amount of times it has been
 * blocked before) reverts its "blocked" state, so the handler will be
 * recognized by the signal system and is called upon future or
 * currently ongoing signal emissions (since the order in which
 * handlers are called during signal emissions is deterministic,
 * whether the unblocked handler in question is called as part of a
 * currently ongoing emission depends on how far that emission has
 * proceeded yet).
 *
 * The @handler_id has to be a valid id of a signal handler that is
 * connected to a signal of @instance and is currently blocked.
 */
void signalHandlerUnblock(ObjectG instance, ulong handlerId)
{
  g_signal_handler_unblock(instance ? instance.cPtr!ObjectC : null, handlerId);
}

/**
 * The number of handlers that matched.
 */
uint signalHandlersBlockMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_block_matched(instance ? instance.cPtr!ObjectC : null, mask, signalId, detail, closure ? closure.cPtr!GClosure : null, func, null);
  return _retval;
}

/**
 * Destroy all signal handlers of a type instance. This function is
 * an implementation detail of the #GObject dispose implementation,
 * and should not be used outside of the type system.
 */
void signalHandlersDestroy(ObjectG instance)
{
  g_signal_handlers_destroy(instance ? instance.cPtr!ObjectC : null);
}

/**
 * The number of handlers that matched.
 */
uint signalHandlersDisconnectMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_disconnect_matched(instance ? instance.cPtr!ObjectC : null, mask, signalId, detail, closure ? closure.cPtr!GClosure : null, func, null);
  return _retval;
}

/**
 * The number of handlers that matched.
 */
uint signalHandlersUnblockMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_unblock_matched(instance ? instance.cPtr!ObjectC : null, mask, signalId, detail, closure ? closure.cPtr!GClosure : null, func, null);
  return _retval;
}

/**
 * %TRUE if a handler is connected to the signal, %FALSE
 * otherwise.
 */
bool signalHasHandlerPending(ObjectG instance, uint signalId, Quark detail, bool mayBeBlocked)
{
  bool _retval;
  _retval = g_signal_has_handler_pending(instance ? instance.cPtr!ObjectC : null, signalId, detail, mayBeBlocked);
  return _retval;
}

/**
 * %TRUE if @name is a valid signal name, %FALSE otherwise.
 */
bool signalIsValidName(string name)
{
  bool _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_signal_is_valid_name(_name);
  return _retval;
}

/**
 * Newly allocated array of signal IDs.
 */
uint[] signalListIds(GType itype)
{
  uint* _cretval;
  uint _cretlength;
  _cretval = g_signal_list_ids(itype, &_cretlength);
  uint[] _retval;

  if (_cretval)
  {
    _retval = cast(uint[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * the signal's identifying number, or 0 if no signal was found.
 */
uint signalLookup(string name, GType itype)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_signal_lookup(_name, itype);
  return _retval;
}

/**
 * the signal name, or %NULL if the signal number was invalid.
 */
string signalName(uint signalId)
{
  const(char)* _cretval;
  _cretval = g_signal_name(signalId);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Overrides the class closure (i.e. the default handler) for the given signal
 * for emissions on instances of @instance_type. @instance_type must be derived
 * from the type to which the signal belongs.
 *
 * See g_signal_chain_from_overridden() and
 * g_signal_chain_from_overridden_handler() for how to chain up to the
 * parent class closure from inside the overridden one.
 */
void signalOverrideClassClosure(uint signalId, GType instanceType, Closure classClosure)
{
  g_signal_override_class_closure(signalId, instanceType, classClosure ? classClosure.cPtr!GClosure : null);
}

/**
 * Whether the signal name could successfully be parsed and @signal_id_p and @detail_p contain valid return values.
 */
bool signalParseName(string detailedSignal, GType itype, out uint signalIdP, out Quark detailP, bool forceDetailQuark)
{
  bool _retval;
  const(char)* _detailedSignal = detailedSignal.toCString(false);
  _retval = g_signal_parse_name(_detailedSignal, itype, cast(uint*)&signalIdP, cast(GQuark*)&detailP, forceDetailQuark);
  return _retval;
}

/**
 * Queries the signal system for in-depth information about a
 * specific signal. This function will fill in a user-provided
 * structure to hold signal-specific information. If an invalid
 * signal id is passed in, the @signal_id member of the #GSignalQuery
 * is 0. All members filled into the #GSignalQuery structure should
 * be considered constant and have to be left untouched.
 */
void signalQuery(uint signalId, out SignalQuery query)
{
  GSignalQuery _query;
  g_signal_query(signalId, &_query);
  query = new SignalQuery(cast(void*)&_query);
}

/**
 * Deletes an emission hook.
 */
void signalRemoveEmissionHook(uint signalId, ulong hookId)
{
  g_signal_remove_emission_hook(signalId, hookId);
}

/**
 * Stops a signal's current emission.
 *
 * This will prevent the default method from running, if the signal was
 * %G_SIGNAL_RUN_LAST and you connected normally (i.e. without the "after"
 * flag).
 *
 * Prints a warning if used on a signal which isn't being emitted.
 */
void signalStopEmission(ObjectG instance, uint signalId, Quark detail)
{
  g_signal_stop_emission(instance ? instance.cPtr!ObjectC : null, signalId, detail);
}

/**
 * Stops a signal's current emission.
 *
 * This is just like g_signal_stop_emission() except it will look up the
 * signal id for you.
 */
void signalStopEmissionByName(ObjectG instance, string detailedSignal)
{
  const(char)* _detailedSignal = detailedSignal.toCString(false);
  g_signal_stop_emission_by_name(instance ? instance.cPtr!ObjectC : null, _detailedSignal);
}

/**
 * a floating reference to a new #GCClosure
 */
Closure signalTypeCclosureNew(GType itype, uint structOffset)
{
  GClosure* _cretval;
  _cretval = g_signal_type_cclosure_new(itype, structOffset);
  Closure _retval = new Closure(cast(GClosure*)_cretval, true);
  return _retval;
}

/**
 * Set the callback for a source as a #GClosure.
 *
 * If the source is not one of the standard GLib types, the @closure_callback
 * and @closure_marshal fields of the #GSourceFuncs structure must have been
 * filled in with pointers to appropriate functions.
 */
void sourceSetClosure(Source source, Closure closure)
{
  g_source_set_closure(source ? source.cPtr!GSource : null, closure ? closure.cPtr!GClosure : null);
}

/**
 * Sets a dummy callback for @source. The callback will do nothing, and
 * if the source expects a #gboolean return value, it will return %TRUE.
 * (If the source expects any other type of return value, it will return
 * a 0/%NULL value; whatever g_value_init() initializes a #GValue to for
 * that type.)
 *
 * If the source is not one of the standard GLib types, the
 * @closure_callback and @closure_marshal fields of the #GSourceFuncs
 * structure must have been filled in with pointers to appropriate
 * functions.
 */
void sourceSetDummyCallback(Source source)
{
  g_source_set_dummy_callback(source ? source.cPtr!GSource : null);
}

/**
 * Newly allocated string.
 */
string strdupValueContents(Value value)
{
  char* _cretval;
  _cretval = g_strdup_value_contents(value ? value.cPtr!GValue : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Registers a private class structure for a classed type;
 * when the class is allocated, the private structures for
 * the class and all of its parent types are allocated
 * sequentially in the same memory block as the public
 * structures, and are zero-filled.
 *
 * This function should be called in the
 * type's get_type() function after the type is registered.
 * The private structure can be retrieved using the
 * G_TYPE_CLASS_GET_PRIVATE() macro.
 */
void typeAddClassPrivate(GType classType, size_t privateSize)
{
  g_type_add_class_private(classType, privateSize);
}

int typeAddInstancePrivate(GType classType, size_t privateSize)
{
  int _retval;
  _retval = g_type_add_instance_private(classType, privateSize);
  return _retval;
}

/**
 * Adds @interface_type to the dynamic @instance_type. The information
 * contained in the #GTypePlugin structure pointed to by @plugin
 * is used to manage the relationship.
 */
void typeAddInterfaceDynamic(GType instanceType, GType interfaceType, TypePlugin plugin)
{
  g_type_add_interface_dynamic(instanceType, interfaceType, plugin ? (cast(ObjectG)plugin).cPtr!GTypePlugin : null);
}

/**
 * Adds @interface_type to the static @instance_type.
 * The information contained in the #GInterfaceInfo structure
 * pointed to by @info is used to manage the relationship.
 */
void typeAddInterfaceStatic(GType instanceType, GType interfaceType, InterfaceInfo info)
{
  g_type_add_interface_static(instanceType, interfaceType, &info);
}

bool typeCheckClassIsA(TypeClass gClass, GType isAType)
{
  bool _retval;
  _retval = g_type_check_class_is_a(gClass ? gClass.cPtr!GTypeClass : null, isAType);
  return _retval;
}

/**
 * %TRUE if @instance is valid, %FALSE otherwise
 */
bool typeCheckInstance(TypeInstance instance)
{
  bool _retval;
  _retval = g_type_check_instance(instance ? instance.cPtr!GTypeInstance : null);
  return _retval;
}

bool typeCheckInstanceIsA(TypeInstance instance, GType ifaceType)
{
  bool _retval;
  _retval = g_type_check_instance_is_a(instance ? instance.cPtr!GTypeInstance : null, ifaceType);
  return _retval;
}

bool typeCheckInstanceIsFundamentallyA(TypeInstance instance, GType fundamentalType)
{
  bool _retval;
  _retval = g_type_check_instance_is_fundamentally_a(instance ? instance.cPtr!GTypeInstance : null, fundamentalType);
  return _retval;
}

bool typeCheckIsValueType(GType type)
{
  bool _retval;
  _retval = g_type_check_is_value_type(type);
  return _retval;
}

bool typeCheckValue(Value value)
{
  bool _retval;
  _retval = g_type_check_value(value ? value.cPtr!GValue : null);
  return _retval;
}

bool typeCheckValueHolds(Value value, GType type)
{
  bool _retval;
  _retval = g_type_check_value_holds(value ? value.cPtr!GValue : null, type);
  return _retval;
}

/**
 * Newly allocated
 * and 0-terminated array of child types, free with g_free()
 */
GType[] typeChildren(GType type)
{
  GType* _cretval;
  uint _cretlength;
  _cretval = g_type_children(type, &_cretlength);
  GType[] _retval;

  if (_cretval)
  {
    _retval = cast(GType[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * the default
 * vtable for the interface, or %NULL if the type is not currently
 * in use
 */
TypeInterface typeDefaultInterfacePeek(GType gType)
{
  GTypeInterface* _cretval;
  _cretval = g_type_default_interface_peek(gType);
  TypeInterface _retval = new TypeInterface(cast(GTypeInterface*)_cretval);
  return _retval;
}

/**
 * the default
 * vtable for the interface; call g_type_default_interface_unref()
 * when you are done using the interface.
 */
TypeInterface typeDefaultInterfaceRef(GType gType)
{
  GTypeInterface* _cretval;
  _cretval = g_type_default_interface_ref(gType);
  TypeInterface _retval = new TypeInterface(cast(GTypeInterface*)_cretval);
  return _retval;
}

/**
 * Decrements the reference count for the type corresponding to the
 * interface default vtable @g_iface. If the type is dynamic, then
 * when no one is using the interface and all references have
 * been released, the finalize function for the interface's default
 * vtable (the @class_finalize member of #GTypeInfo) will be called.
 */
void typeDefaultInterfaceUnref(TypeInterface gIface)
{
  g_type_default_interface_unref(gIface ? gIface.cPtr!GTypeInterface : null);
}

/**
 * the depth of @type
 */
uint typeDepth(GType type)
{
  uint _retval;
  _retval = g_type_depth(type);
  return _retval;
}

/**
 * Ensures that the indicated @type has been registered with the
 * type system, and its _class_init() method has been run.
 *
 * In theory, simply calling the type's _get_type() method (or using
 * the corresponding macro) is supposed take care of this. However,
 * _get_type() methods are often marked %G_GNUC_CONST for performance
 * reasons, even though this is technically incorrect (since
 * %G_GNUC_CONST requires that the function not have side effects,
 * which _get_type() methods do on the first call). As a result, if
 * you write a bare call to a _get_type() macro, it may get optimized
 * out by the compiler. Using g_type_ensure() guarantees that the
 * type's _get_type() method is called.
 */
void typeEnsure(GType type)
{
  g_type_ensure(type);
}

/**
 * Frees an instance of a type, returning it to the instance pool for
 * the type, if there is one.
 *
 * Like g_type_create_instance(), this function is reserved for
 * implementors of fundamental types.
 */
void typeFreeInstance(TypeInstance instance)
{
  g_type_free_instance(instance ? instance.cPtr!GTypeInstance : null);
}

/**
 * corresponding type ID or 0
 */
GType typeFromName(string name)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_type_from_name(_name);
  return _retval;
}

/**
 * fundamental type ID
 */
GType typeFundamental(GType typeId)
{
  GType _retval;
  _retval = g_type_fundamental(typeId);
  return _retval;
}

/**
 * the next available fundamental type ID to be registered,
 * or 0 if the type system ran out of fundamental type IDs
 */
GType typeFundamentalNext()
{
  GType _retval;
  _retval = g_type_fundamental_next();
  return _retval;
}

/**
 * the number of instances allocated of the given type;
 * if instance counts are not available, returns 0.
 */
int typeGetInstanceCount(GType type)
{
  int _retval;
  _retval = g_type_get_instance_count(type);
  return _retval;
}

/**
 * the corresponding plugin
 * if @type is a dynamic type, %NULL otherwise
 */
TypePlugin typeGetPlugin(GType type)
{
  GTypePlugin* _cretval;
  _cretval = g_type_get_plugin(type);
  TypePlugin _retval = ObjectG.getDObject!TypePlugin(cast(GTypePlugin*)_cretval, false);
  return _retval;
}

/**
 * the data, or %NULL if no data was found
 */
void* typeGetQdata(GType type, Quark quark)
{
  void* _retval;
  _retval = g_type_get_qdata(type, quark);
  return _retval;
}

/**
 * An unsigned int, representing the state of type registrations
 */
uint typeGetTypeRegistrationSerial()
{
  uint _retval;
  _retval = g_type_get_type_registration_serial();
  return _retval;
}

/**
 * This function used to initialise the type system.  Since GLib 2.36,
 * the type system is initialised automatically and this function does
 * nothing.
 */
void typeInit()
{
  g_type_init();
}

/**
 * This function used to initialise the type system with debugging
 * flags.  Since GLib 2.36, the type system is initialised automatically
 * and this function does nothing.
 *
 * If you need to enable debugging features, use the `GOBJECT_DEBUG`
 * environment variable.
 */
void typeInitWithDebugFlags(TypeDebugFlags debugFlags)
{
  g_type_init_with_debug_flags(debugFlags);
}

/**
 * Newly allocated
 * and 0-terminated array of interface types, free with g_free()
 */
GType[] typeInterfaces(GType type)
{
  GType* _cretval;
  uint _cretlength;
  _cretval = g_type_interfaces(type, &_cretlength);
  GType[] _retval;

  if (_cretval)
  {
    _retval = cast(GType[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * %TRUE if @type is a @is_a_type
 */
bool typeIsA(GType type, GType isAType)
{
  bool _retval;
  _retval = g_type_is_a(type, isAType);
  return _retval;
}

/**
 * static type name or %NULL
 */
string typeName(GType type)
{
  const(char)* _cretval;
  _cretval = g_type_name(type);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

string typeNameFromClass(TypeClass gClass)
{
  const(char)* _cretval;
  _cretval = g_type_name_from_class(gClass ? gClass.cPtr!GTypeClass : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

string typeNameFromInstance(TypeInstance instance)
{
  const(char)* _cretval;
  _cretval = g_type_name_from_instance(instance ? instance.cPtr!GTypeInstance : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * immediate child of @root_type and ancestor of @leaf_type
 */
GType typeNextBase(GType leafType, GType rootType)
{
  GType _retval;
  _retval = g_type_next_base(leafType, rootType);
  return _retval;
}

/**
 * the parent type
 */
GType typeParent(GType type)
{
  GType _retval;
  _retval = g_type_parent(type);
  return _retval;
}

/**
 * the type names quark or 0
 */
Quark typeQname(GType type)
{
  Quark _retval;
  _retval = g_type_qname(type);
  return _retval;
}

/**
 * Queries the type system for information about a specific type.
 *
 * This function will fill in a user-provided structure to hold
 * type-specific information. If an invalid #GType is passed in, the
 * @type member of the #GTypeQuery is 0. All members filled into the
 * #GTypeQuery structure should be considered constant and have to be
 * left untouched.
 *
 * Since GLib 2.78, this function allows queries on dynamic types. Previously
 * it only supported static types.
 */
void typeQuery(GType type, out TypeQuery query)
{
  GTypeQuery _query;
  g_type_query(type, &_query);
  query = new TypeQuery(cast(void*)&_query);
}

/**
 * the new type identifier or %G_TYPE_INVALID if registration failed
 */
GType typeRegisterDynamic(GType parentType, string typeName, TypePlugin plugin, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_dynamic(parentType, _typeName, plugin ? (cast(ObjectG)plugin).cPtr!GTypePlugin : null, flags);
  return _retval;
}

/**
 * the predefined type identifier
 */
GType typeRegisterFundamental(GType typeId, string typeName, TypeInfoG info, TypeFundamentalInfo finfo, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_fundamental(typeId, _typeName, info ? info.cPtr!GTypeInfo : null, &finfo, flags);
  return _retval;
}

/**
 * the new type identifier
 */
GType typeRegisterStatic(GType parentType, string typeName, TypeInfoG info, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_static(parentType, _typeName, info ? info.cPtr!GTypeInfo : null, flags);
  return _retval;
}

/**
 * Attaches arbitrary data to a type.
 */
void typeSetQdata(GType type, Quark quark, void* data)
{
  g_type_set_qdata(type, quark, data);
}

bool typeTestFlags(GType type, uint flags)
{
  bool _retval;
  _retval = g_type_test_flags(type, flags);
  return _retval;
}
