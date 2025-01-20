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
import GObject.TypePluginT;
import GObject.TypeQuery;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;


/**
 * Set the callback for a source as a #GClosure.
 * If the source is not one of the standard GLib types, the closure_callback
 * and closure_marshal fields of the #GSourceFuncs structure must have been
 * filled in with pointers to appropriate functions.
 * Params:
 *   source = the source
 *   closure = a #GClosure
 */
void setClosure(Source source, Closure closure)
{
  g_source_set_closure(source ? cast(GSource*)source.cPtr(false) : null, closure ? cast(GClosure*)closure.cPtr(false) : null);
}

/**
 * Sets a dummy callback for source. The callback will do nothing, and
 * if the source expects a #gboolean return value, it will return %TRUE.
 * $(LPAREN)If the source expects any other type of return value, it will return
 * a 0/%NULL value; whatever [GObject.Value.init_] initializes a #GValue to for
 * that type.$(RPAREN)
 * If the source is not one of the standard GLib types, the
 * closure_callback and closure_marshal fields of the #GSourceFuncs
 * structure must have been filled in with pointers to appropriate
 * functions.
 * Params:
 *   source = the source
 */
void setDummyCallback(Source source)
{
  g_source_set_dummy_callback(source ? cast(GSource*)source.cPtr(false) : null);
}

/**
 * Provide a copy of a boxed structure src_boxed which is of type boxed_type.
 * Params:
 *   boxedType = The type of src_boxed.
 *   srcBoxed = The boxed structure to be copied.
 * Returns: The newly created copy of the boxed
 *   structure.
 */
void* boxedCopy(GType boxedType, const(void)* srcBoxed)
{
  void* _retval;
  _retval = g_boxed_copy(boxedType, srcBoxed);
  return _retval;
}

/**
 * Free the boxed structure boxed which is of type boxed_type.
 * Params:
 *   boxedType = The type of boxed.
 *   boxed = The boxed structure to be freed.
 */
void boxedFree(GType boxedType, void* boxed)
{
  g_boxed_free(boxedType, boxed);
}

/**
 * Disconnects a handler from instance so it will not be called during
 * any future or currently ongoing emissions of the signal it has been
 * connected to. The handler_id_ptr is then set to zero, which is never a valid handler ID value $(LPAREN)see g_signal_connect$(LPAREN)$(RPAREN)$(RPAREN).
 * If the handler ID is 0 then this function does nothing.
 * There is also a macro version of this function so that the code
 * will be inlined.
 * Params:
 *   handlerIdPtr = A pointer to a handler ID $(LPAREN)of type #gulong$(RPAREN) of the handler to be disconnected.
 *   instance = The instance to remove the signal handler from.
 *     This pointer may be %NULL or invalid, if the handler ID is zero.
 */
void clearSignalHandler(ref ulong handlerIdPtr, ObjectG instance)
{
  g_clear_signal_handler(cast(ulong*)&handlerIdPtr, instance ? cast(ObjectC*)instance.cPtr(false) : null);
}

/**
 * This function is meant to be called from the `complete_type_info`
 * function of a #GTypePlugin implementation, as in the following
 * example:
 * |[<!-- language\="C" -->
 * static void
 * my_enum_complete_type_info $(LPAREN)GTypePlugin     *plugin,
 * GType            g_type,
 * GTypeInfo       *info,
 * GTypeValueTable *value_table$(RPAREN)
 * {
 * static const GEnumValue values[] \= {
 * { MY_ENUM_FOO, "MY_ENUM_FOO", "foo" },
 * { MY_ENUM_BAR, "MY_ENUM_BAR", "bar" },
 * { 0, NULL, NULL }
 * };
 * g_enum_complete_type_info $(LPAREN)type, info, values$(RPAREN);
 * }
 * ]|
 * Params:
 *   gEnumType = the type identifier of the type being completed
 *   info = the #GTypeInfo struct to be filled in
 *   constValues = An array of #GEnumValue structs for the possible
 *     enumeration values. The array is terminated by a struct with all
 *     members being 0.
 */
void enumCompleteTypeInfo(GType gEnumType, out TypeInfoG info, EnumValue constValues)
{
  GTypeInfo _info;
  g_enum_complete_type_info(gEnumType, &_info, constValues ? cast(GEnumValue*)constValues.cPtr : null);
  info = new TypeInfoG(cast(void*)&_info);
}

/**
 * Returns the #GEnumValue for a value.
 * Params:
 *   enumClass = a #GEnumClass
 *   value = the value to look up
 * Returns: the #GEnumValue for value, or %NULL
 *   if value is not a member of the enumeration
 */
EnumValue enumGetValue(EnumClass enumClass, int value)
{
  GEnumValue* _cretval;
  _cretval = g_enum_get_value(enumClass ? cast(GEnumClass*)enumClass.cPtr : null, value);
  auto _retval = _cretval ? new EnumValue(cast(GEnumValue*)_cretval) : null;
  return _retval;
}

/**
 * Looks up a #GEnumValue by name.
 * Params:
 *   enumClass = a #GEnumClass
 *   name = the name to look up
 * Returns: the #GEnumValue with name name,
 *   or %NULL if the enumeration doesn't have a member
 *   with that name
 */
EnumValue enumGetValueByName(EnumClass enumClass, string name)
{
  GEnumValue* _cretval;
  const(char)* _name = name.toCString(false);
  _cretval = g_enum_get_value_by_name(enumClass ? cast(GEnumClass*)enumClass.cPtr : null, _name);
  auto _retval = _cretval ? new EnumValue(cast(GEnumValue*)_cretval) : null;
  return _retval;
}

/**
 * Looks up a #GEnumValue by nickname.
 * Params:
 *   enumClass = a #GEnumClass
 *   nick = the nickname to look up
 * Returns: the #GEnumValue with nickname nick,
 *   or %NULL if the enumeration doesn't have a member
 *   with that nickname
 */
EnumValue enumGetValueByNick(EnumClass enumClass, string nick)
{
  GEnumValue* _cretval;
  const(char)* _nick = nick.toCString(false);
  _cretval = g_enum_get_value_by_nick(enumClass ? cast(GEnumClass*)enumClass.cPtr : null, _nick);
  auto _retval = _cretval ? new EnumValue(cast(GEnumValue*)_cretval) : null;
  return _retval;
}

/**
 * Registers a new static enumeration type with the name name.
 * It is normally more convenient to let [glib-mkenums][glib-mkenums],
 * generate a my_enum_get_type$(LPAREN)$(RPAREN) function from a usual C enumeration
 * definition  than to write one yourself using [GObject.Global.enumRegisterStatic].
 * Params:
 *   name = A nul-terminated string used as the name of the new type.
 *   constStaticValues = An array of #GEnumValue structs for the possible
 *     enumeration values. The array is terminated by a struct with all
 *     members being 0. GObject keeps a reference to the data, so it cannot
 *     be stack-allocated.
 * Returns: The new type identifier.
 */
GType enumRegisterStatic(string name, EnumValue constStaticValues)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_enum_register_static(_name, constStaticValues ? cast(GEnumValue*)constStaticValues.cPtr : null);
  return _retval;
}

/**
 * Pretty-prints value in the form of the enum’s name.
 * This is intended to be used for debugging purposes. The format of the output
 * may change in the future.
 * Params:
 *   gEnumType = the type identifier of a #GEnumClass type
 *   value = the value
 * Returns: a newly-allocated text string
 */
string enumToString(GType gEnumType, int value)
{
  char* _cretval;
  _cretval = g_enum_to_string(gEnumType, value);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * This function is meant to be called from the complete_type_info$(LPAREN)$(RPAREN)
 * function of a #GTypePlugin implementation, see the example for
 * [GObject.Global.enumCompleteTypeInfo] above.
 * Params:
 *   gFlagsType = the type identifier of the type being completed
 *   info = the #GTypeInfo struct to be filled in
 *   constValues = An array of #GFlagsValue structs for the possible
 *     enumeration values. The array is terminated by a struct with all
 *     members being 0.
 */
void flagsCompleteTypeInfo(GType gFlagsType, out TypeInfoG info, FlagsValue constValues)
{
  GTypeInfo _info;
  g_flags_complete_type_info(gFlagsType, &_info, constValues ? cast(GFlagsValue*)constValues.cPtr : null);
  info = new TypeInfoG(cast(void*)&_info);
}

/**
 * Returns the first #GFlagsValue which is set in value.
 * Params:
 *   flagsClass = a #GFlagsClass
 *   value = the value
 * Returns: the first #GFlagsValue which is set in
 *   value, or %NULL if none is set
 */
FlagsValue flagsGetFirstValue(FlagsClass flagsClass, uint value)
{
  GFlagsValue* _cretval;
  _cretval = g_flags_get_first_value(flagsClass ? cast(GFlagsClass*)flagsClass.cPtr : null, value);
  auto _retval = _cretval ? new FlagsValue(cast(GFlagsValue*)_cretval) : null;
  return _retval;
}

/**
 * Looks up a #GFlagsValue by name.
 * Params:
 *   flagsClass = a #GFlagsClass
 *   name = the name to look up
 * Returns: the #GFlagsValue with name name,
 *   or %NULL if there is no flag with that name
 */
FlagsValue flagsGetValueByName(FlagsClass flagsClass, string name)
{
  GFlagsValue* _cretval;
  const(char)* _name = name.toCString(false);
  _cretval = g_flags_get_value_by_name(flagsClass ? cast(GFlagsClass*)flagsClass.cPtr : null, _name);
  auto _retval = _cretval ? new FlagsValue(cast(GFlagsValue*)_cretval) : null;
  return _retval;
}

/**
 * Looks up a #GFlagsValue by nickname.
 * Params:
 *   flagsClass = a #GFlagsClass
 *   nick = the nickname to look up
 * Returns: the #GFlagsValue with nickname nick,
 *   or %NULL if there is no flag with that nickname
 */
FlagsValue flagsGetValueByNick(FlagsClass flagsClass, string nick)
{
  GFlagsValue* _cretval;
  const(char)* _nick = nick.toCString(false);
  _cretval = g_flags_get_value_by_nick(flagsClass ? cast(GFlagsClass*)flagsClass.cPtr : null, _nick);
  auto _retval = _cretval ? new FlagsValue(cast(GFlagsValue*)_cretval) : null;
  return _retval;
}

/**
 * Registers a new static flags type with the name name.
 * It is normally more convenient to let [glib-mkenums][glib-mkenums]
 * generate a my_flags_get_type$(LPAREN)$(RPAREN) function from a usual C enumeration
 * definition than to write one yourself using [GObject.Global.flagsRegisterStatic].
 * Params:
 *   name = A nul-terminated string used as the name of the new type.
 *   constStaticValues = An array of #GFlagsValue structs for the possible
 *     flags values. The array is terminated by a struct with all members being 0.
 *     GObject keeps a reference to the data, so it cannot be stack-allocated.
 * Returns: The new type identifier.
 */
GType flagsRegisterStatic(string name, FlagsValue constStaticValues)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_flags_register_static(_name, constStaticValues ? cast(GFlagsValue*)constStaticValues.cPtr : null);
  return _retval;
}

/**
 * Pretty-prints value in the form of the flag names separated by ` | ` and
 * sorted. Any extra bits will be shown at the end as a hexadecimal number.
 * This is intended to be used for debugging purposes. The format of the output
 * may change in the future.
 * Params:
 *   flagsType = the type identifier of a #GFlagsClass type
 *   value = the value
 * Returns: a newly-allocated text string
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
 * Creates a new #GParamSpecBoolean instance specifying a %G_TYPE_BOOLEAN
 * property. In many cases, it may be more appropriate to use an enum with
 * [GObject.Global.paramSpecEnum], both to improve code clarity by using explicitly named
 * values, and to allow for more values to be added in future without breaking
 * API.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecBoolean(string name, string nick, string blurb, bool defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_boolean(_name, _nick, _blurb, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecBoxed instance specifying a %G_TYPE_BOXED
 * derived property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   boxedType = %G_TYPE_BOXED derived type of this property
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecBoxed(string name, string nick, string blurb, GType boxedType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_boxed(_name, _nick, _blurb, boxedType, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecChar instance specifying a %G_TYPE_CHAR property.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecChar(string name, string nick, string blurb, byte minimum, byte maximum, byte defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_char(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecDouble instance specifying a %G_TYPE_DOUBLE
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecDouble(string name, string nick, string blurb, double minimum, double maximum, double defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_double(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecEnum instance specifying a %G_TYPE_ENUM
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   enumType = a #GType derived from %G_TYPE_ENUM
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecEnum(string name, string nick, string blurb, GType enumType, int defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_enum(_name, _nick, _blurb, enumType, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecFlags instance specifying a %G_TYPE_FLAGS
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   flagsType = a #GType derived from %G_TYPE_FLAGS
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecFlags(string name, string nick, string blurb, GType flagsType, uint defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_flags(_name, _nick, _blurb, flagsType, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecFloat instance specifying a %G_TYPE_FLOAT property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecFloat(string name, string nick, string blurb, float minimum, float maximum, float defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_float(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecGType instance specifying a
 * %G_TYPE_GTYPE property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   isAType = a #GType whose subtypes are allowed as values
 *     of the property $(LPAREN)use %G_TYPE_NONE for any type$(RPAREN)
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecGtype(string name, string nick, string blurb, GType isAType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_gtype(_name, _nick, _blurb, isAType, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecInt instance specifying a %G_TYPE_INT property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecInt(string name, string nick, string blurb, int minimum, int maximum, int defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_int(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecInt64 instance specifying a %G_TYPE_INT64 property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecInt64(string name, string nick, string blurb, long minimum, long maximum, long defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_int64(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecLong instance specifying a %G_TYPE_LONG property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecLong(string name, string nick, string blurb, long minimum, long maximum, long defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_long(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecBoxed instance specifying a %G_TYPE_OBJECT
 * derived property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   objectType = %G_TYPE_OBJECT derived type of this property
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecObject(string name, string nick, string blurb, GType objectType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_object(_name, _nick, _blurb, objectType, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecParam instance specifying a %G_TYPE_PARAM
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   paramType = a #GType derived from %G_TYPE_PARAM
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecParam(string name, string nick, string blurb, GType paramType, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_param(_name, _nick, _blurb, paramType, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecPointer instance specifying a pointer property.
 * Where possible, it is better to use [GObject.Global.paramSpecObject] or
 * [GObject.Global.paramSpecBoxed] to expose memory management information.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecPointer(string name, string nick, string blurb, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_pointer(_name, _nick, _blurb, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecString instance.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecString(string name, string nick, string blurb, string defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  const(char)* _defaultValue = defaultValue.toCString(false);
  _cretval = g_param_spec_string(_name, _nick, _blurb, _defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecUChar instance specifying a %G_TYPE_UCHAR property.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecUchar(string name, string nick, string blurb, ubyte minimum, ubyte maximum, ubyte defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uchar(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecUInt instance specifying a %G_TYPE_UINT property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecUint(string name, string nick, string blurb, uint minimum, uint maximum, uint defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uint(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecUInt64 instance specifying a %G_TYPE_UINT64
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecUint64(string name, string nick, string blurb, ulong minimum, ulong maximum, ulong defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_uint64(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecULong instance specifying a %G_TYPE_ULONG
 * property.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   minimum = minimum value for the property specified
 *   maximum = maximum value for the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecUlong(string name, string nick, string blurb, ulong minimum, ulong maximum, ulong defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_ulong(_name, _nick, _blurb, minimum, maximum, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecUnichar instance specifying a %G_TYPE_UINT
 * property. #GValue structures for this property can be accessed with
 * [GObject.Value.setUint] and [GObject.Value.getUint].
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   defaultValue = default value for the property specified
 *   flags = flags for the property specified
 * Returns: a newly created parameter specification
 */
ParamSpec paramSpecUnichar(string name, string nick, string blurb, dchar defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_unichar(_name, _nick, _blurb, defaultValue, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #GParamSpecVariant instance specifying a #GVariant
 * property.
 * If default_value is floating, it is consumed.
 * See [GObject.ParamSpec.internal] for details on property names.
 * Params:
 *   name = canonical name of the property specified
 *   nick = nick name for the property specified
 *   blurb = description of the property specified
 *   type = a #GVariantType
 *   defaultValue = a #GVariant of type type to
 *     use as the default value, or %NULL
 *   flags = flags for the property specified
 * Returns: the newly created #GParamSpec
 */
ParamSpec paramSpecVariant(string name, string nick, string blurb, VariantType type, Variant defaultValue, ParamFlags flags)
{
  GParamSpec* _cretval;
  const(char)* _name = name.toCString(false);
  const(char)* _nick = nick.toCString(false);
  const(char)* _blurb = blurb.toCString(false);
  _cretval = g_param_spec_variant(_name, _nick, _blurb, type ? cast(GVariantType*)type.cPtr(false) : null, defaultValue ? cast(GVariant*)defaultValue.cPtr(true) : null, flags);
  auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, true) : null;
  return _retval;
}

/**
 * Registers name as the name of a new static type derived
 * from %G_TYPE_PARAM.
 * The type system uses the information contained in the #GParamSpecTypeInfo
 * structure pointed to by info to manage the #GParamSpec type and its
 * instances.
 * Params:
 *   name = 0-terminated string used as the name of the new #GParamSpec type.
 *   pspecInfo = The #GParamSpecTypeInfo for this #GParamSpec type.
 * Returns: The new type identifier.
 */
GType paramTypeRegisterStatic(string name, ParamSpecTypeInfo pspecInfo)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_param_type_register_static(_name, &pspecInfo);
  return _retval;
}

/**
 * Transforms src_value into dest_value if possible, and then
 * validates dest_value, in order for it to conform to pspec.  If
 * strict_validation is %TRUE this function will only succeed if the
 * transformed dest_value complied to pspec without modifications.
 * See also [GObject.Value.typeTransformable], [GObject.Value.transform] and
 * [GObject.Global.paramValueValidate].
 * Params:
 *   pspec = a valid #GParamSpec
 *   srcValue = source #GValue
 *   destValue = destination #GValue of correct type for pspec
 *   strictValidation = %TRUE requires dest_value to conform to pspec
 *     without modifications
 * Returns: %TRUE if transformation and validation were successful,
 *   %FALSE otherwise and dest_value is left untouched.
 */
bool paramValueConvert(ParamSpec pspec, Value srcValue, Value destValue, bool strictValidation)
{
  bool _retval;
  _retval = g_param_value_convert(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, srcValue ? cast(GValue*)srcValue.cPtr(false) : null, destValue ? cast(GValue*)destValue.cPtr(false) : null, strictValidation);
  return _retval;
}

/**
 * Checks whether value contains the default value as specified in pspec.
 * Params:
 *   pspec = a valid #GParamSpec
 *   value = a #GValue of correct type for pspec
 * Returns: whether value contains the canonical default for this pspec
 */
bool paramValueDefaults(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_defaults(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, value ? cast(GValue*)value.cPtr(false) : null);
  return _retval;
}

/**
 * Return whether the contents of value comply with the specifications
 * set out by pspec.
 * Params:
 *   pspec = a valid #GParamSpec
 *   value = a #GValue of correct type for pspec
 * Returns: whether the contents of value comply with the specifications
 *   set out by pspec.
 */
bool paramValueIsValid(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_is_valid(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, value ? cast(GValue*)value.cPtr(false) : null);
  return _retval;
}

/**
 * Sets value to its default value as specified in pspec.
 * Params:
 *   pspec = a valid #GParamSpec
 *   value = a #GValue of correct type for pspec; since 2.64, you
 *     can also pass an empty #GValue, initialized with %G_VALUE_INIT
 */
void paramValueSetDefault(ParamSpec pspec, Value value)
{
  g_param_value_set_default(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, value ? cast(GValue*)value.cPtr(false) : null);
}

/**
 * Ensures that the contents of value comply with the specifications
 * set out by pspec. For example, a #GParamSpecInt might require
 * that integers stored in value may not be smaller than -42 and not be
 * greater than +42. If value contains an integer outside of this range,
 * it is modified accordingly, so the resulting value will fit into the
 * range -42 .. +42.
 * Params:
 *   pspec = a valid #GParamSpec
 *   value = a #GValue of correct type for pspec
 * Returns: whether modifying value was necessary to ensure validity
 */
bool paramValueValidate(ParamSpec pspec, Value value)
{
  bool _retval;
  _retval = g_param_value_validate(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, value ? cast(GValue*)value.cPtr(false) : null);
  return _retval;
}

/**
 * Compares value1 with value2 according to pspec, and return -1, 0 or +1,
 * if value1 is found to be less than, equal to or greater than value2,
 * respectively.
 * Params:
 *   pspec = a valid #GParamSpec
 *   value1 = a #GValue of correct type for pspec
 *   value2 = a #GValue of correct type for pspec
 * Returns: -1, 0 or +1, for a less than, equal to or greater than result
 */
int paramValuesCmp(ParamSpec pspec, Value value1, Value value2)
{
  int _retval;
  _retval = g_param_values_cmp(pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, value1 ? cast(GValue*)value1.cPtr(false) : null, value2 ? cast(GValue*)value2.cPtr(false) : null);
  return _retval;
}

/**
 * Creates a new %G_TYPE_POINTER derived type id for a new
 * pointer type with name name.
 * Params:
 *   name = the name of the new pointer type.
 * Returns: a new %G_TYPE_POINTER derived type id for name.
 */
GType pointerTypeRegisterStatic(string name)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_pointer_type_register_static(_name);
  return _retval;
}

/**
 * A predefined #GSignalAccumulator for signals intended to be used as a
 * hook for application code to provide a particular value.  Usually
 * only one such value is desired and multiple handlers for the same
 * signal don't make much sense $(LPAREN)except for the case of the default
 * handler defined in the class structure, in which case you will
 * usually want the signal connection to override the class handler$(RPAREN).
 * This accumulator will use the return value from the first signal
 * handler that is run as the return value for the signal and not run
 * any further handlers $(LPAREN)ie: the first handler "wins"$(RPAREN).
 * Params:
 *   ihint = standard #GSignalAccumulator parameter
 *   returnAccu = standard #GSignalAccumulator parameter
 *   handlerReturn = standard #GSignalAccumulator parameter
 *   dummy = standard #GSignalAccumulator parameter
 * Returns: standard #GSignalAccumulator result
 */
bool signalAccumulatorFirstWins(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, void* dummy)
{
  bool _retval;
  _retval = g_signal_accumulator_first_wins(&ihint, returnAccu ? cast(GValue*)returnAccu.cPtr(false) : null, handlerReturn ? cast(GValue*)handlerReturn.cPtr(false) : null, dummy);
  return _retval;
}

/**
 * A predefined #GSignalAccumulator for signals that return a
 * boolean values. The behavior that this accumulator gives is
 * that a return of %TRUE stops the signal emission: no further
 * callbacks will be invoked, while a return of %FALSE allows
 * the emission to continue. The idea here is that a %TRUE return
 * indicates that the callback handled the signal, and no further
 * handling is needed.
 * Params:
 *   ihint = standard #GSignalAccumulator parameter
 *   returnAccu = standard #GSignalAccumulator parameter
 *   handlerReturn = standard #GSignalAccumulator parameter
 *   dummy = standard #GSignalAccumulator parameter
 * Returns: standard #GSignalAccumulator result
 */
bool signalAccumulatorTrueHandled(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, void* dummy)
{
  bool _retval;
  _retval = g_signal_accumulator_true_handled(&ihint, returnAccu ? cast(GValue*)returnAccu.cPtr(false) : null, handlerReturn ? cast(GValue*)handlerReturn.cPtr(false) : null, dummy);
  return _retval;
}

/**
 * Adds an emission hook for a signal, which will get called for any emission
 * of that signal, independent of the instance. This is possible only
 * for signals which don't have %G_SIGNAL_NO_HOOKS flag set.
 * Params:
 *   signalId = the signal identifier, as returned by [GObject.Global.signalLookup].
 *   detail = the detail on which to call the hook.
 *   hookFunc = a #GSignalEmissionHook function.
 * Returns: the hook id, for later use with [GObject.Global.signalRemoveEmissionHook].
 */
ulong signalAddEmissionHook(uint signalId, Quark detail, SignalEmissionHook hookFunc)
{
  extern(C) bool _hookFuncCallback(GSignalInvocationHint* ihint, uint nParamValues, const(GValue)* paramValues, void* data)
  {
    auto _dlg = cast(SignalEmissionHook*)data;
    Value[] _paramValues;
    foreach (i; 0 .. nParamValues)
      _paramValues ~= new Value(cast(GValue*)&paramValues[i], false);

    bool _retval = (*_dlg)(*ihint, _paramValues);
    return _retval;
  }

  ulong _retval;
  auto _hookFunc = freezeDelegate(cast(void*)&hookFunc);
  _retval = g_signal_add_emission_hook(signalId, detail, &_hookFuncCallback, _hookFunc, &thawDelegate);
  return _retval;
}

/**
 * Connects a closure to a signal for a particular object.
 * If closure is a floating reference $(LPAREN)see [GObject.Closure.sink]$(RPAREN), this function
 * takes ownership of closure.
 * This function cannot fail. If the given signal doesn’t exist, a critical
 * warning is emitted.
 * Params:
 *   instance = the instance to connect to.
 *   detailedSignal = a string of the form "signal-name::detail".
 *   closure = the closure to connect.
 *   after = whether the handler should be called before or after the
 *     default handler of the signal.
 * Returns: the handler ID $(LPAREN)always greater than 0$(RPAREN)
 */
ulong signalConnectClosure(ObjectG instance, string detailedSignal, Closure closure, bool after)
{
  ulong _retval;
  const(char)* _detailedSignal = detailedSignal.toCString(false);
  _retval = g_signal_connect_closure(instance ? cast(ObjectC*)instance.cPtr(false) : null, _detailedSignal, closure ? cast(GClosure*)closure.cPtr(false) : null, after);
  return _retval;
}

/**
 * Connects a closure to a signal for a particular object.
 * If closure is a floating reference $(LPAREN)see [GObject.Closure.sink]$(RPAREN), this function
 * takes ownership of closure.
 * This function cannot fail. If the given signal doesn’t exist, a critical
 * warning is emitted.
 * Params:
 *   instance = the instance to connect to.
 *   signalId = the id of the signal.
 *   detail = the detail.
 *   closure = the closure to connect.
 *   after = whether the handler should be called before or after the
 *     default handler of the signal.
 * Returns: the handler ID $(LPAREN)always greater than 0$(RPAREN)
 */
ulong signalConnectClosureById(ObjectG instance, uint signalId, Quark detail, Closure closure, bool after)
{
  ulong _retval;
  _retval = g_signal_connect_closure_by_id(instance ? cast(ObjectC*)instance.cPtr(false) : null, signalId, detail, closure ? cast(GClosure*)closure.cPtr(false) : null, after);
  return _retval;
}

/**
 * Returns the invocation hint of the innermost signal emission of instance.
 * Params:
 *   instance = the instance to query
 * Returns: the invocation hint of the innermost
 *   signal emission, or %NULL if not found.
 */
SignalInvocationHint signalGetInvocationHint(ObjectG instance)
{
  GSignalInvocationHint* _cretval;
  _cretval = g_signal_get_invocation_hint(instance ? cast(ObjectC*)instance.cPtr(false) : null);
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
 * The handler_id has to be a valid signal handler id, connected to a
 * signal of instance.
 * Params:
 *   instance = The instance to block the signal handler of.
 *   handlerId = Handler id of the handler to be blocked.
 */
void signalHandlerBlock(ObjectG instance, ulong handlerId)
{
  g_signal_handler_block(instance ? cast(ObjectC*)instance.cPtr(false) : null, handlerId);
}

/**
 * Disconnects a handler from an instance so it will not be called during
 * any future or currently ongoing emissions of the signal it has been
 * connected to. The handler_id becomes invalid and may be reused.
 * The handler_id has to be a valid signal handler id, connected to a
 * signal of instance.
 * Params:
 *   instance = The instance to remove the signal handler from.
 *   handlerId = Handler id of the handler to be disconnected.
 */
void signalHandlerDisconnect(ObjectG instance, ulong handlerId)
{
  g_signal_handler_disconnect(instance ? cast(ObjectC*)instance.cPtr(false) : null, handlerId);
}

/**
 * Finds the first signal handler that matches certain selection criteria.
 * The criteria mask is passed as an OR-ed combination of #GSignalMatchType
 * flags, and the criteria values are passed as arguments.
 * The match mask has to be non-0 for successful matches.
 * If no handler was found, 0 is returned.
 * Params:
 *   instance = The instance owning the signal handler to be found.
 *   mask = Mask indicating which of signal_id, detail, closure, func
 *     and/or data the handler has to match.
 *   signalId = Signal the handler has to be connected to.
 *   detail = Signal detail the handler has to be connected to.
 *   closure = The closure the handler will invoke.
 *   func = The C closure callback of the handler $(LPAREN)useless for non-C closures$(RPAREN).
 * Returns: A valid non-0 signal handler id for a successful match.
 */
ulong signalHandlerFind(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  ulong _retval;
  _retval = g_signal_handler_find(instance ? cast(ObjectC*)instance.cPtr(false) : null, mask, signalId, detail, closure ? cast(GClosure*)closure.cPtr(false) : null, func, null);
  return _retval;
}

/**
 * Returns whether handler_id is the ID of a handler connected to instance.
 * Params:
 *   instance = The instance where a signal handler is sought.
 *   handlerId = the handler ID.
 * Returns: whether handler_id identifies a handler connected to instance.
 */
bool signalHandlerIsConnected(ObjectG instance, ulong handlerId)
{
  bool _retval;
  _retval = g_signal_handler_is_connected(instance ? cast(ObjectC*)instance.cPtr(false) : null, handlerId);
  return _retval;
}

/**
 * Undoes the effect of a previous [GObject.Global.signalHandlerBlock] call.  A
 * blocked handler is skipped during signal emissions and will not be
 * invoked, unblocking it $(LPAREN)for exactly the amount of times it has been
 * blocked before$(RPAREN) reverts its "blocked" state, so the handler will be
 * recognized by the signal system and is called upon future or
 * currently ongoing signal emissions $(LPAREN)since the order in which
 * handlers are called during signal emissions is deterministic,
 * whether the unblocked handler in question is called as part of a
 * currently ongoing emission depends on how far that emission has
 * proceeded yet$(RPAREN).
 * The handler_id has to be a valid id of a signal handler that is
 * connected to a signal of instance and is currently blocked.
 * Params:
 *   instance = The instance to unblock the signal handler of.
 *   handlerId = Handler id of the handler to be unblocked.
 */
void signalHandlerUnblock(ObjectG instance, ulong handlerId)
{
  g_signal_handler_unblock(instance ? cast(ObjectC*)instance.cPtr(false) : null, handlerId);
}

/**
 * Blocks all handlers on an instance that match a certain selection criteria.
 * The criteria mask is passed as a combination of #GSignalMatchType flags, and
 * the criteria values are passed as arguments. A handler must match on all
 * flags set in mask to be blocked $(LPAREN)i.e. the match is conjunctive$(RPAREN).
 * Passing at least one of the %G_SIGNAL_MATCH_ID, %G_SIGNAL_MATCH_CLOSURE,
 * %G_SIGNAL_MATCH_FUNC
 * or %G_SIGNAL_MATCH_DATA match flags is required for successful matches.
 * If no handlers were found, 0 is returned, the number of blocked handlers
 * otherwise.
 * Support for %G_SIGNAL_MATCH_ID was added in GLib 2.78.
 * Params:
 *   instance = The instance to block handlers from.
 *   mask = Mask indicating which of signal_id, detail, closure, func
 *     and/or data the handlers have to match.
 *   signalId = Signal the handlers have to be connected to.
 *   detail = Signal detail the handlers have to be connected to.
 *   closure = The closure the handlers will invoke.
 *   func = The C closure callback of the handlers $(LPAREN)useless for non-C closures$(RPAREN).
 * Returns: The number of handlers that matched.
 */
uint signalHandlersBlockMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_block_matched(instance ? cast(ObjectC*)instance.cPtr(false) : null, mask, signalId, detail, closure ? cast(GClosure*)closure.cPtr(false) : null, func, null);
  return _retval;
}

/**
 * Destroy all signal handlers of a type instance. This function is
 * an implementation detail of the #GObject dispose implementation,
 * and should not be used outside of the type system.
 * Params:
 *   instance = The instance whose signal handlers are destroyed
 */
void signalHandlersDestroy(ObjectG instance)
{
  g_signal_handlers_destroy(instance ? cast(ObjectC*)instance.cPtr(false) : null);
}

/**
 * Disconnects all handlers on an instance that match a certain
 * selection criteria.
 * The criteria mask is passed as a combination of #GSignalMatchType flags, and
 * the criteria values are passed as arguments. A handler must match on all
 * flags set in mask to be disconnected $(LPAREN)i.e. the match is conjunctive$(RPAREN).
 * Passing at least one of the %G_SIGNAL_MATCH_ID, %G_SIGNAL_MATCH_CLOSURE,
 * %G_SIGNAL_MATCH_FUNC or
 * %G_SIGNAL_MATCH_DATA match flags is required for successful
 * matches.  If no handlers were found, 0 is returned, the number of
 * disconnected handlers otherwise.
 * Support for %G_SIGNAL_MATCH_ID was added in GLib 2.78.
 * Params:
 *   instance = The instance to remove handlers from.
 *   mask = Mask indicating which of signal_id, detail, closure, func
 *     and/or data the handlers have to match.
 *   signalId = Signal the handlers have to be connected to.
 *   detail = Signal detail the handlers have to be connected to.
 *   closure = The closure the handlers will invoke.
 *   func = The C closure callback of the handlers $(LPAREN)useless for non-C closures$(RPAREN).
 * Returns: The number of handlers that matched.
 */
uint signalHandlersDisconnectMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_disconnect_matched(instance ? cast(ObjectC*)instance.cPtr(false) : null, mask, signalId, detail, closure ? cast(GClosure*)closure.cPtr(false) : null, func, null);
  return _retval;
}

/**
 * Unblocks all handlers on an instance that match a certain selection
 * criteria.
 * The criteria mask is passed as a combination of #GSignalMatchType flags, and
 * the criteria values are passed as arguments. A handler must match on all
 * flags set in mask to be unblocked $(LPAREN)i.e. the match is conjunctive$(RPAREN).
 * Passing at least one of the %G_SIGNAL_MATCH_ID, %G_SIGNAL_MATCH_CLOSURE,
 * %G_SIGNAL_MATCH_FUNC
 * or %G_SIGNAL_MATCH_DATA match flags is required for successful matches.
 * If no handlers were found, 0 is returned, the number of unblocked handlers
 * otherwise. The match criteria should not apply to any handlers that are
 * not currently blocked.
 * Support for %G_SIGNAL_MATCH_ID was added in GLib 2.78.
 * Params:
 *   instance = The instance to unblock handlers from.
 *   mask = Mask indicating which of signal_id, detail, closure, func
 *     and/or data the handlers have to match.
 *   signalId = Signal the handlers have to be connected to.
 *   detail = Signal detail the handlers have to be connected to.
 *   closure = The closure the handlers will invoke.
 *   func = The C closure callback of the handlers $(LPAREN)useless for non-C closures$(RPAREN).
 * Returns: The number of handlers that matched.
 */
uint signalHandlersUnblockMatched(ObjectG instance, SignalMatchType mask, uint signalId, Quark detail, Closure closure, void* func)
{
  uint _retval;
  _retval = g_signal_handlers_unblock_matched(instance ? cast(ObjectC*)instance.cPtr(false) : null, mask, signalId, detail, closure ? cast(GClosure*)closure.cPtr(false) : null, func, null);
  return _retval;
}

/**
 * Returns whether there are any handlers connected to instance for the
 * given signal id and detail.
 * If detail is 0 then it will only match handlers that were connected
 * without detail.  If detail is non-zero then it will match handlers
 * connected both without detail and with the given detail.  This is
 * consistent with how a signal emitted with detail would be delivered
 * to those handlers.
 * Since 2.46 this also checks for a non-default class closure being
 * installed, as this is basically always what you want.
 * One example of when you might use this is when the arguments to the
 * signal are difficult to compute. A class implementor may opt to not
 * emit the signal if no one is attached anyway, thus saving the cost
 * of building the arguments.
 * Params:
 *   instance = the object whose signal handlers are sought.
 *   signalId = the signal id.
 *   detail = the detail.
 *   mayBeBlocked = whether blocked handlers should count as match.
 * Returns: %TRUE if a handler is connected to the signal, %FALSE
 *   otherwise.
 */
bool signalHasHandlerPending(ObjectG instance, uint signalId, Quark detail, bool mayBeBlocked)
{
  bool _retval;
  _retval = g_signal_has_handler_pending(instance ? cast(ObjectC*)instance.cPtr(false) : null, signalId, detail, mayBeBlocked);
  return _retval;
}

/**
 * Validate a signal name. This can be useful for dynamically-generated signals
 * which need to be validated at run-time before actually trying to create them.
 * See [canonical parameter names][canonical-parameter-names] for details of
 * the rules for valid names. The rules for signal names are the same as those
 * for property names.
 * Params:
 *   name = the canonical name of the signal
 * Returns: %TRUE if name is a valid signal name, %FALSE otherwise.
 */
bool signalIsValidName(string name)
{
  bool _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_signal_is_valid_name(_name);
  return _retval;
}

/**
 * Lists the signals by id that a certain instance or interface type
 * created. Further information about the signals can be acquired through
 * [GObject.Global.signalQuery].
 * Params:
 *   itype = Instance or interface type.
 * Returns: Newly allocated array of signal IDs.
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
 * Given the name of the signal and the type of object it connects to, gets
 * the signal's identifying integer. Emitting the signal by number is
 * somewhat faster than using the name each time.
 * Also tries the ancestors of the given type.
 * The type class passed as itype must already have been instantiated $(LPAREN)for
 * example, using [GObject.TypeClass.ref_]$(RPAREN) for this function to work, as signals are
 * always installed during class initialization.
 * See [GObject.Global.signalNew] for details on allowed signal names.
 * Params:
 *   name = the signal's name.
 *   itype = the type that the signal operates on.
 * Returns: the signal's identifying number, or 0 if no signal was found.
 */
uint signalLookup(string name, GType itype)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_signal_lookup(_name, itype);
  return _retval;
}

/**
 * Given the signal's identifier, finds its name.
 * Two different signals may have the same name, if they have differing types.
 * Params:
 *   signalId = the signal's identifying number.
 * Returns: the signal name, or %NULL if the signal number was invalid.
 */
string signalName(uint signalId)
{
  const(char)* _cretval;
  _cretval = g_signal_name(signalId);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Creates a new signal. $(LPAREN)This is usually done in the class initializer.$(RPAREN)
 * See [GObject.Global.signalNew] for details on allowed signal names.
 * If c_marshaller is %NULL, [GObject.CClosure.marshalGeneric] will be used as
 * the marshaller for this signal.
 * Params:
 *   signalName = the name for the signal
 *   itype = the type this signal pertains to. It will also pertain to
 *     types which are derived from this type
 *   signalFlags = a combination of #GSignalFlags specifying detail of when
 *     the default handler is to be invoked. You should at least specify
 *     %G_SIGNAL_RUN_FIRST or %G_SIGNAL_RUN_LAST
 *   classClosure = The closure to invoke on signal emission;
 *     may be %NULL
 *   accumulator = the accumulator for this signal; may be %NULL
 *   cMarshaller = the function to translate arrays of
 *     parameter values to signal emissions into C language callback
 *     invocations or %NULL
 *   returnType = the type of return value, or %G_TYPE_NONE for a signal
 *     without a return value
 *   paramTypes = an array of types, one for
 *     each parameter $(LPAREN)may be %NULL if n_params is zero$(RPAREN)
 * Returns: the signal id
 */
uint signalNewv(string signalName, GType itype, SignalFlags signalFlags, Closure classClosure, SignalAccumulator accumulator, SignalCMarshaller cMarshaller, GType returnType, GType[] paramTypes)
{
  extern(C) bool _accumulatorCallback(GSignalInvocationHint* ihint, GValue* returnAccu, const(GValue)* handlerReturn, void* data)
  {
    auto _dlg = cast(SignalAccumulator*)data;

    bool _retval = (*_dlg)(*ihint, returnAccu ? new Value(cast(void*)returnAccu, false) : null, handlerReturn ? new Value(cast(void*)handlerReturn, false) : null);
    return _retval;
  }

  extern(C) void _cMarshallerCallback(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData)
  {
    auto _dlg = cast(SignalCMarshaller*)marshalData;
    Value[] _paramValues;
    foreach (i; 0 .. nParamValues)
      _paramValues ~= new Value(cast(GValue*)&paramValues[i], false);

    (*_dlg)(closure ? new Closure(cast(void*)closure, false) : null, returnValue ? new Value(cast(void*)returnValue, false) : null, _paramValues, invocationHint);
  }

  uint _retval;
  const(char)* _signalName = signalName.toCString(false);
  auto _accumulator = freezeDelegate(cast(void*)&accumulator);
  uint _nParams;
  if (paramTypes)
    _nParams = cast(uint)paramTypes.length;

  auto _paramTypes = cast(GType*)paramTypes.ptr;
  _retval = g_signal_newv(_signalName, itype, signalFlags, classClosure ? cast(GClosure*)classClosure.cPtr(false) : null, &_accumulatorCallback, _accumulator, &_cMarshallerCallback, returnType, _nParams, _paramTypes);
  return _retval;
}

/**
 * Overrides the class closure $(LPAREN)i.e. the default handler$(RPAREN) for the given signal
 * for emissions on instances of instance_type. instance_type must be derived
 * from the type to which the signal belongs.
 * See [GObject.Global.signalChainFromOverridden] and
 * [GObject.Global.signalChainFromOverriddenHandler] for how to chain up to the
 * parent class closure from inside the overridden one.
 * Params:
 *   signalId = the signal id
 *   instanceType = the instance type on which to override the class closure
 *     for the signal.
 *   classClosure = the closure.
 */
void signalOverrideClassClosure(uint signalId, GType instanceType, Closure classClosure)
{
  g_signal_override_class_closure(signalId, instanceType, classClosure ? cast(GClosure*)classClosure.cPtr(false) : null);
}

/**
 * Internal function to parse a signal name into its signal_id
 * and detail quark.
 * Params:
 *   detailedSignal = a string of the form "signal-name::detail".
 *   itype = The interface/instance type that introduced "signal-name".
 *   signalIdP = Location to store the signal id.
 *   detailP = Location to store the detail quark.
 *   forceDetailQuark = %TRUE forces creation of a #GQuark for the detail.
 * Returns: Whether the signal name could successfully be parsed and signal_id_p and detail_p contain valid return values.
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
 * signal id is passed in, the signal_id member of the #GSignalQuery
 * is 0. All members filled into the #GSignalQuery structure should
 * be considered constant and have to be left untouched.
 * Params:
 *   signalId = The signal id of the signal to query information for.
 *   query = A user provided structure that is
 *     filled in with constant values upon success.
 */
void signalQuery(uint signalId, out SignalQuery query)
{
  GSignalQuery _query;
  g_signal_query(signalId, &_query);
  query = new SignalQuery(cast(void*)&_query);
}

/**
 * Deletes an emission hook.
 * Params:
 *   signalId = the id of the signal
 *   hookId = the id of the emission hook, as returned by
 *     [GObject.Global.signalAddEmissionHook]
 */
void signalRemoveEmissionHook(uint signalId, ulong hookId)
{
  g_signal_remove_emission_hook(signalId, hookId);
}

/**
 * Stops a signal's current emission.
 * This will prevent the default method from running, if the signal was
 * %G_SIGNAL_RUN_LAST and you connected normally $(LPAREN)i.e. without the "after"
 * flag$(RPAREN).
 * Prints a warning if used on a signal which isn't being emitted.
 * Params:
 *   instance = the object whose signal handlers you wish to stop.
 *   signalId = the signal identifier, as returned by [GObject.Global.signalLookup].
 *   detail = the detail which the signal was emitted with.
 */
void signalStopEmission(ObjectG instance, uint signalId, Quark detail)
{
  g_signal_stop_emission(instance ? cast(ObjectC*)instance.cPtr(false) : null, signalId, detail);
}

/**
 * Stops a signal's current emission.
 * This is just like [GObject.Global.signalStopEmission] except it will look up the
 * signal id for you.
 * Params:
 *   instance = the object whose signal handlers you wish to stop.
 *   detailedSignal = a string of the form "signal-name::detail".
 */
void signalStopEmissionByName(ObjectG instance, string detailedSignal)
{
  const(char)* _detailedSignal = detailedSignal.toCString(false);
  g_signal_stop_emission_by_name(instance ? cast(ObjectC*)instance.cPtr(false) : null, _detailedSignal);
}

/**
 * Creates a new closure which invokes the function found at the offset
 * struct_offset in the class structure of the interface or classed type
 * identified by itype.
 * Params:
 *   itype = the #GType identifier of an interface or classed type
 *   structOffset = the offset of the member function of itype's class
 *     structure which is to be invoked by the new closure
 * Returns: a floating reference to a new #GCClosure
 */
Closure signalTypeCclosureNew(GType itype, uint structOffset)
{
  GClosure* _cretval;
  _cretval = g_signal_type_cclosure_new(itype, structOffset);
  auto _retval = _cretval ? new Closure(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Return a newly allocated string, which describes the contents of a
 * #GValue.  The main purpose of this function is to describe #GValue
 * contents for debugging output, the way in which the contents are
 * described may change between different GLib versions.
 * Params:
 *   value = #GValue which contents are to be described.
 * Returns: Newly allocated string.
 */
string strdupValueContents(Value value)
{
  char* _cretval;
  _cretval = g_strdup_value_contents(value ? cast(GValue*)value.cPtr(false) : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Registers a private class structure for a classed type;
 * when the class is allocated, the private structures for
 * the class and all of its parent types are allocated
 * sequentially in the same memory block as the public
 * structures, and are zero-filled.
 * This function should be called in the
 * type's get_type$(LPAREN)$(RPAREN) function after the type is registered.
 * The private structure can be retrieved using the
 * G_TYPE_CLASS_GET_PRIVATE$(LPAREN)$(RPAREN) macro.
 * Params:
 *   classType = GType of a classed type
 *   privateSize = size of private structure
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
 * Adds interface_type to the dynamic instance_type. The information
 * contained in the #GTypePlugin structure pointed to by plugin
 * is used to manage the relationship.
 * Params:
 *   instanceType = #GType value of an instantiatable type
 *   interfaceType = #GType value of an interface type
 *   plugin = #GTypePlugin structure to retrieve the #GInterfaceInfo from
 */
void typeAddInterfaceDynamic(GType instanceType, GType interfaceType, TypePlugin plugin)
{
  g_type_add_interface_dynamic(instanceType, interfaceType, plugin ? cast(GTypePlugin*)(cast(ObjectG)plugin).cPtr(false) : null);
}

/**
 * Adds interface_type to the static instance_type.
 * The information contained in the #GInterfaceInfo structure
 * pointed to by info is used to manage the relationship.
 * Params:
 *   instanceType = #GType value of an instantiatable type
 *   interfaceType = #GType value of an interface type
 *   info = #GInterfaceInfo structure for this
 *     $(LPAREN)instance_type, interface_type$(RPAREN) combination
 */
void typeAddInterfaceStatic(GType instanceType, GType interfaceType, InterfaceInfo info)
{
  g_type_add_interface_static(instanceType, interfaceType, &info);
}

bool typeCheckClassIsA(TypeClass gClass, GType isAType)
{
  bool _retval;
  _retval = g_type_check_class_is_a(gClass ? cast(GTypeClass*)gClass.cPtr : null, isAType);
  return _retval;
}

/**
 * Private helper function to aid implementation of the
 * G_TYPE_CHECK_INSTANCE$(LPAREN)$(RPAREN) macro.
 * Params:
 *   instance = a valid #GTypeInstance structure
 * Returns: %TRUE if instance is valid, %FALSE otherwise
 */
bool typeCheckInstance(TypeInstance instance)
{
  bool _retval;
  _retval = g_type_check_instance(instance ? cast(GTypeInstance*)instance.cPtr : null);
  return _retval;
}

bool typeCheckInstanceIsA(TypeInstance instance, GType ifaceType)
{
  bool _retval;
  _retval = g_type_check_instance_is_a(instance ? cast(GTypeInstance*)instance.cPtr : null, ifaceType);
  return _retval;
}

bool typeCheckInstanceIsFundamentallyA(TypeInstance instance, GType fundamentalType)
{
  bool _retval;
  _retval = g_type_check_instance_is_fundamentally_a(instance ? cast(GTypeInstance*)instance.cPtr : null, fundamentalType);
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
  _retval = g_type_check_value(value ? cast(GValue*)value.cPtr(false) : null);
  return _retval;
}

bool typeCheckValueHolds(Value value, GType type)
{
  bool _retval;
  _retval = g_type_check_value_holds(value ? cast(GValue*)value.cPtr(false) : null, type);
  return _retval;
}

/**
 * Return a newly allocated and 0-terminated array of type IDs, listing
 * the child types of type.
 * Params:
 *   type = the parent type
 * Returns: Newly allocated
 *   and 0-terminated array of child types, free with [GLib.Global.gfree]
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
 * If the interface type g_type is currently in use, returns its
 * default interface vtable.
 * Params:
 *   gType = an interface type
 * Returns: the default
 *   vtable for the interface, or %NULL if the type is not currently
 *   in use
 */
TypeInterface typeDefaultInterfacePeek(GType gType)
{
  GTypeInterface* _cretval;
  _cretval = g_type_default_interface_peek(gType);
  auto _retval = _cretval ? new TypeInterface(cast(GTypeInterface*)_cretval) : null;
  return _retval;
}

/**
 * Increments the reference count for the interface type g_type,
 * and returns the default interface vtable for the type.
 * If the type is not currently in use, then the default vtable
 * for the type will be created and initialized by calling
 * the base interface init and default vtable init functions for
 * the type $(LPAREN)the base_init and class_init members of #GTypeInfo$(RPAREN).
 * Calling [GObject.Global.typeDefaultInterfaceRef] is useful when you
 * want to make sure that signals and properties for an interface
 * have been installed.
 * Params:
 *   gType = an interface type
 * Returns: the default
 *   vtable for the interface; call [GObject.Global.typeDefaultInterfaceUnref]
 *   when you are done using the interface.
 */
TypeInterface typeDefaultInterfaceRef(GType gType)
{
  GTypeInterface* _cretval;
  _cretval = g_type_default_interface_ref(gType);
  auto _retval = _cretval ? new TypeInterface(cast(GTypeInterface*)_cretval) : null;
  return _retval;
}

/**
 * Decrements the reference count for the type corresponding to the
 * interface default vtable g_iface. If the type is dynamic, then
 * when no one is using the interface and all references have
 * been released, the finalize function for the interface's default
 * vtable $(LPAREN)the class_finalize member of #GTypeInfo$(RPAREN) will be called.
 * Params:
 *   gIface = the default vtable
 *     structure for an interface, as returned by [GObject.Global.typeDefaultInterfaceRef]
 */
void typeDefaultInterfaceUnref(TypeInterface gIface)
{
  g_type_default_interface_unref(gIface ? cast(GTypeInterface*)gIface.cPtr : null);
}

/**
 * Returns the length of the ancestry of the passed in type. This
 * includes the type itself, so that e.g. a fundamental type has depth 1.
 * Params:
 *   type = a #GType
 * Returns: the depth of type
 */
uint typeDepth(GType type)
{
  uint _retval;
  _retval = g_type_depth(type);
  return _retval;
}

/**
 * Ensures that the indicated type has been registered with the
 * type system, and its _class_init$(LPAREN)$(RPAREN) method has been run.
 * In theory, simply calling the type's _get_type$(LPAREN)$(RPAREN) method $(LPAREN)or using
 * the corresponding macro$(RPAREN) is supposed take care of this. However,
 * _get_type$(LPAREN)$(RPAREN) methods are often marked %G_GNUC_CONST for performance
 * reasons, even though this is technically incorrect $(LPAREN)since
 * %G_GNUC_CONST requires that the function not have side effects,
 * which _get_type$(LPAREN)$(RPAREN) methods do on the first call$(RPAREN). As a result, if
 * you write a bare call to a _get_type$(LPAREN)$(RPAREN) macro, it may get optimized
 * out by the compiler. Using [GObject.Global.typeEnsure] guarantees that the
 * type's _get_type$(LPAREN)$(RPAREN) method is called.
 * Params:
 *   type = a #GType
 */
void typeEnsure(GType type)
{
  g_type_ensure(type);
}

/**
 * Frees an instance of a type, returning it to the instance pool for
 * the type, if there is one.
 * Like [GObject.Global.typeCreateInstance], this function is reserved for
 * implementors of fundamental types.
 * Params:
 *   instance = an instance of a type
 */
void typeFreeInstance(TypeInstance instance)
{
  g_type_free_instance(instance ? cast(GTypeInstance*)instance.cPtr : null);
}

/**
 * Look up the type ID from a given type name, returning 0 if no type
 * has been registered under this name $(LPAREN)this is the preferred method
 * to find out by name whether a specific type has been registered
 * yet$(RPAREN).
 * Params:
 *   name = type name to look up
 * Returns: corresponding type ID or 0
 */
GType typeFromName(string name)
{
  GType _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_type_from_name(_name);
  return _retval;
}

/**
 * Internal function, used to extract the fundamental type ID portion.
 * Use G_TYPE_FUNDAMENTAL$(LPAREN)$(RPAREN) instead.
 * Params:
 *   typeId = valid type ID
 * Returns: fundamental type ID
 */
GType typeFundamental(GType typeId)
{
  GType _retval;
  _retval = g_type_fundamental(typeId);
  return _retval;
}

/**
 * Returns the next free fundamental type id which can be used to
 * register a new fundamental type with [GObject.Global.typeRegisterFundamental].
 * The returned type ID represents the highest currently registered
 * fundamental type identifier.
 * Returns: the next available fundamental type ID to be registered,
 *   or 0 if the type system ran out of fundamental type IDs
 */
GType typeFundamentalNext()
{
  GType _retval;
  _retval = g_type_fundamental_next();
  return _retval;
}

/**
 * Returns the number of instances allocated of the particular type;
 * this is only available if GLib is built with debugging support and
 * the `instance-count` debug flag is set $(LPAREN)by setting the `GOBJECT_DEBUG`
 * variable to include `instance-count`$(RPAREN).
 * Params:
 *   type = a #GType
 * Returns: the number of instances allocated of the given type;
 *   if instance counts are not available, returns 0.
 */
int typeGetInstanceCount(GType type)
{
  int _retval;
  _retval = g_type_get_instance_count(type);
  return _retval;
}

/**
 * Returns the #GTypePlugin structure for type.
 * Params:
 *   type = #GType to retrieve the plugin for
 * Returns: the corresponding plugin
 *   if type is a dynamic type, %NULL otherwise
 */
TypePlugin typeGetPlugin(GType type)
{
  GTypePlugin* _cretval;
  _cretval = g_type_get_plugin(type);
  auto _retval = _cretval ? ObjectG.getDObject!TypePlugin(cast(GTypePlugin*)_cretval, false) : null;
  return _retval;
}

/**
 * Obtains data which has previously been attached to type
 * with [GObject.Global.typeSetQdata].
 * Note that this does not take subtyping into account; data
 * attached to one type with [GObject.Global.typeSetQdata] cannot
 * be retrieved from a subtype using [GObject.Global.typeGetQdata].
 * Params:
 *   type = a #GType
 *   quark = a #GQuark id to identify the data
 * Returns: the data, or %NULL if no data was found
 */
void* typeGetQdata(GType type, Quark quark)
{
  void* _retval;
  _retval = g_type_get_qdata(type, quark);
  return _retval;
}

/**
 * Returns an opaque serial number that represents the state of the set
 * of registered types. Any time a type is registered this serial changes,
 * which means you can cache information based on type lookups $(LPAREN)such as
 * [GObject.Global.typeFromName]$(RPAREN) and know if the cache is still valid at a later
 * time by comparing the current serial with the one at the type lookup.
 * Returns: An unsigned int, representing the state of type registrations
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

 * Deprecated: the type system is now initialised automatically
 */
void typeInit()
{
  g_type_init();
}

/**
 * This function used to initialise the type system with debugging
 * flags.  Since GLib 2.36, the type system is initialised automatically
 * and this function does nothing.
 * If you need to enable debugging features, use the `GOBJECT_DEBUG`
 * environment variable.
 * Params:
 *   debugFlags = bitwise combination of #GTypeDebugFlags values for
 *     debugging purposes

 * Deprecated: the type system is now initialised automatically
 */
void typeInitWithDebugFlags(TypeDebugFlags debugFlags)
{
  g_type_init_with_debug_flags(debugFlags);
}

/**
 * Return a newly allocated and 0-terminated array of type IDs, listing
 * the interface types that type conforms to.
 * Params:
 *   type = the type to list interface types for
 * Returns: Newly allocated
 *   and 0-terminated array of interface types, free with [GLib.Global.gfree]
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
 * If is_a_type is a derivable type, check whether type is a
 * descendant of is_a_type. If is_a_type is an interface, check
 * whether type conforms to it.
 * Params:
 *   type = type to check ancestry for
 *   isAType = possible ancestor of type or interface that type
 *     could conform to
 * Returns: %TRUE if type is a is_a_type
 */
bool typeIsA(GType type, GType isAType)
{
  bool _retval;
  _retval = g_type_is_a(type, isAType);
  return _retval;
}

/**
 * Get the unique name that is assigned to a type ID.  Note that this
 * function $(LPAREN)like all other GType API$(RPAREN) cannot cope with invalid type
 * IDs. %G_TYPE_INVALID may be passed to this function, as may be any
 * other validly registered type ID, but randomized type IDs should
 * not be passed in and will most likely lead to a crash.
 * Params:
 *   type = type to return name for
 * Returns: static type name or %NULL
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
  _cretval = g_type_name_from_class(gClass ? cast(GTypeClass*)gClass.cPtr : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

string typeNameFromInstance(TypeInstance instance)
{
  const(char)* _cretval;
  _cretval = g_type_name_from_instance(instance ? cast(GTypeInstance*)instance.cPtr : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Given a leaf_type and a root_type which is contained in its
 * ancestry, return the type that root_type is the immediate parent
 * of. In other words, this function determines the type that is
 * derived directly from root_type which is also a base class of
 * leaf_type.  Given a root type and a leaf type, this function can
 * be used to determine the types and order in which the leaf type is
 * descended from the root type.
 * Params:
 *   leafType = descendant of root_type and the type to be returned
 *   rootType = immediate parent of the returned type
 * Returns: immediate child of root_type and ancestor of leaf_type
 */
GType typeNextBase(GType leafType, GType rootType)
{
  GType _retval;
  _retval = g_type_next_base(leafType, rootType);
  return _retval;
}

/**
 * Return the direct parent type of the passed in type. If the passed
 * in type has no parent, i.e. is a fundamental type, 0 is returned.
 * Params:
 *   type = the derived type
 * Returns: the parent type
 */
GType typeParent(GType type)
{
  GType _retval;
  _retval = g_type_parent(type);
  return _retval;
}

/**
 * Get the corresponding quark of the type IDs name.
 * Params:
 *   type = type to return quark of type name for
 * Returns: the type names quark or 0
 */
Quark typeQname(GType type)
{
  Quark _retval;
  _retval = g_type_qname(type);
  return _retval;
}

/**
 * Queries the type system for information about a specific type.
 * This function will fill in a user-provided structure to hold
 * type-specific information. If an invalid #GType is passed in, the
 * type member of the #GTypeQuery is 0. All members filled into the
 * #GTypeQuery structure should be considered constant and have to be
 * left untouched.
 * Since GLib 2.78, this function allows queries on dynamic types. Previously
 * it only supported static types.
 * Params:
 *   type = #GType of a static, classed type
 *   query = a user provided structure that is
 *     filled in with constant values upon success
 */
void typeQuery(GType type, out TypeQuery query)
{
  GTypeQuery _query;
  g_type_query(type, &_query);
  query = new TypeQuery(cast(void*)&_query);
}

/**
 * Registers type_name as the name of a new dynamic type derived from
 * parent_type.  The type system uses the information contained in the
 * #GTypePlugin structure pointed to by plugin to manage the type and its
 * instances $(LPAREN)if not abstract$(RPAREN).  The value of flags determines the nature
 * $(LPAREN)e.g. abstract or not$(RPAREN) of the type.
 * Params:
 *   parentType = type from which this type will be derived
 *   typeName = 0-terminated string used as the name of the new type
 *   plugin = #GTypePlugin structure to retrieve the #GTypeInfo from
 *   flags = bitwise combination of #GTypeFlags values
 * Returns: the new type identifier or %G_TYPE_INVALID if registration failed
 */
GType typeRegisterDynamic(GType parentType, string typeName, TypePlugin plugin, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_dynamic(parentType, _typeName, plugin ? cast(GTypePlugin*)(cast(ObjectG)plugin).cPtr(false) : null, flags);
  return _retval;
}

/**
 * Registers type_id as the predefined identifier and type_name as the
 * name of a fundamental type. If type_id is already registered, or a
 * type named type_name is already registered, the behaviour is undefined.
 * The type system uses the information contained in the #GTypeInfo structure
 * pointed to by info and the #GTypeFundamentalInfo structure pointed to by
 * finfo to manage the type and its instances. The value of flags determines
 * additional characteristics of the fundamental type.
 * Params:
 *   typeId = a predefined type identifier
 *   typeName = 0-terminated string used as the name of the new type
 *   info = #GTypeInfo structure for this type
 *   finfo = #GTypeFundamentalInfo structure for this type
 *   flags = bitwise combination of #GTypeFlags values
 * Returns: the predefined type identifier
 */
GType typeRegisterFundamental(GType typeId, string typeName, TypeInfoG info, TypeFundamentalInfo finfo, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_fundamental(typeId, _typeName, info ? cast(GTypeInfo*)info.cPtr : null, &finfo, flags);
  return _retval;
}

/**
 * Registers type_name as the name of a new static type derived from
 * parent_type. The type system uses the information contained in the
 * #GTypeInfo structure pointed to by info to manage the type and its
 * instances $(LPAREN)if not abstract$(RPAREN). The value of flags determines the nature
 * $(LPAREN)e.g. abstract or not$(RPAREN) of the type.
 * Params:
 *   parentType = type from which this type will be derived
 *   typeName = 0-terminated string used as the name of the new type
 *   info = #GTypeInfo structure for this type
 *   flags = bitwise combination of #GTypeFlags values
 * Returns: the new type identifier
 */
GType typeRegisterStatic(GType parentType, string typeName, TypeInfoG info, TypeFlags flags)
{
  GType _retval;
  const(char)* _typeName = typeName.toCString(false);
  _retval = g_type_register_static(parentType, _typeName, info ? cast(GTypeInfo*)info.cPtr : null, flags);
  return _retval;
}

/**
 * Attaches arbitrary data to a type.
 * Params:
 *   type = a #GType
 *   quark = a #GQuark id to identify the data
 *   data = the data
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

GType variantGetGtype()
{
  GType _retval;
  _retval = g_variant_get_gtype();
  return _retval;
}
