module GObject.c.functions;

import GObject.c.types;
public import GLib.c.types;

version(Windows)
  private immutable LIBS = ["libgobject-2.0-0.dll;gobject-2.0-0.dll;gobject-2.dll"];
version(OSX)
  private immutable LIBS = ["libgobject-2.0.0.dylib"];
else
  private immutable LIBS = ["libgobject-2.0.so.0"];

__gshared extern(C)
{
  // Binding
  GType function() c_g_binding_get_type;
  ObjectC* function(GBinding* binding) c_g_binding_dup_source;
  ObjectC* function(GBinding* binding) c_g_binding_dup_target;
  GBindingFlags function(GBinding* binding) c_g_binding_get_flags;
  ObjectC* function(GBinding* binding) c_g_binding_get_source;
  const(char)* function(GBinding* binding) c_g_binding_get_source_property;
  ObjectC* function(GBinding* binding) c_g_binding_get_target;
  const(char)* function(GBinding* binding) c_g_binding_get_target_property;
  void function(GBinding* binding) c_g_binding_unbind;

  // BindingGroup
  GType function() c_g_binding_group_get_type;
  GBindingGroup* function() c_g_binding_group_new;
  void function(GBindingGroup* self, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags) c_g_binding_group_bind;
  void function(GBindingGroup* self, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags, GBindingTransformFunc transformTo, GBindingTransformFunc transformFrom, void* userData, GDestroyNotify userDataDestroy) c_g_binding_group_bind_full;
  void function(GBindingGroup* self, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags, GClosure* transformTo, GClosure* transformFrom) c_g_binding_group_bind_with_closures;
  ObjectC* function(GBindingGroup* self) c_g_binding_group_dup_source;
  void function(GBindingGroup* self, ObjectC* source) c_g_binding_group_set_source;

  // CClosure
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_BOOLEAN__BOXED_BOXED;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_BOOLEAN__FLAGS;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_BOOLEAN__FLAGSv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_STRING__OBJECT_POINTER;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_STRING__OBJECT_POINTERv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__BOOLEAN;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__BOOLEANv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__BOXED;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__BOXEDv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__CHAR;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__CHARv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__DOUBLE;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__DOUBLEv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__ENUM;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__ENUMv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__FLAGS;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__FLAGSv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__FLOAT;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__FLOATv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__INT;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__INTv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__LONG;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__LONGv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__OBJECT;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__OBJECTv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__PARAM;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__PARAMv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__POINTER;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__POINTERv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__STRING;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__STRINGv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__UCHAR;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__UCHARv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__UINT;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__UINT_POINTER;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__UINT_POINTERv;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__UINTv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__ULONG;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__ULONGv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__VARIANT;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__VARIANTv;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_VOID__VOID;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* args, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_VOID__VOIDv;
  void function(GClosure* closure, GValue* returnGvalue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) c_g_cclosure_marshal_generic;
  void function(GClosure* closure, GValue* returnValue, GTypeInstance* instance, void* argsList, void* marshalData, int nParams, GType* paramTypes) c_g_cclosure_marshal_generic_va;
  GClosure* function(GCallback callbackFunc, void* userData, GClosureNotify destroyData) c_g_cclosure_new;
  GClosure* function(GCallback callbackFunc, ObjectC* object) c_g_cclosure_new_object;
  GClosure* function(GCallback callbackFunc, ObjectC* object) c_g_cclosure_new_object_swap;
  GClosure* function(GCallback callbackFunc, void* userData, GClosureNotify destroyData) c_g_cclosure_new_swap;

  // Closure
  GType function() c_g_closure_get_type;
  GClosure* function(uint sizeofClosure, ObjectC* object) c_g_closure_new_object;
  GClosure* function(uint sizeofClosure, void* data) c_g_closure_new_simple;
  void function(GClosure* closure, void* notifyData, GClosureNotify notifyFunc) c_g_closure_add_finalize_notifier;
  void function(GClosure* closure, void* notifyData, GClosureNotify notifyFunc) c_g_closure_add_invalidate_notifier;
  void function(GClosure* closure, void* preMarshalData, GClosureNotify preMarshalNotify, void* postMarshalData, GClosureNotify postMarshalNotify) c_g_closure_add_marshal_guards;
  void function(GClosure* closure) c_g_closure_invalidate;
  void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint) c_g_closure_invoke;
  GClosure* function(GClosure* closure) c_g_closure_ref;
  void function(GClosure* closure, void* notifyData, GClosureNotify notifyFunc) c_g_closure_remove_finalize_notifier;
  void function(GClosure* closure, void* notifyData, GClosureNotify notifyFunc) c_g_closure_remove_invalidate_notifier;
  void function(GClosure* closure, GClosureMarshal marshal) c_g_closure_set_marshal;
  void function(GClosure* closure, void* marshalData, GClosureMarshal metaMarshal) c_g_closure_set_meta_marshal;
  void function(GClosure* closure) c_g_closure_sink;
  void function(GClosure* closure) c_g_closure_unref;

  // Global
  void function(GSource* source, GClosure* closure) c_g_source_set_closure;
  void function(GSource* source) c_g_source_set_dummy_callback;
  void* function(GType boxedType, const(void)* srcBoxed) c_g_boxed_copy;
  void function(GType boxedType, void* boxed) c_g_boxed_free;
  GType function(const(char)* name, GBoxedCopyFunc boxedCopy, GBoxedFreeFunc boxedFree) c_g_boxed_type_register_static;
  void function(ObjectC** objectPtr) c_g_clear_object;
  void function(ulong* handlerIdPtr, ObjectC* instance) c_g_clear_signal_handler;
  void function(GType gEnumType, GTypeInfo* info, const(GEnumValue)* constValues) c_g_enum_complete_type_info;
  GEnumValue* function(GEnumClass* enumClass, int value) c_g_enum_get_value;
  GEnumValue* function(GEnumClass* enumClass, const(char)* name) c_g_enum_get_value_by_name;
  GEnumValue* function(GEnumClass* enumClass, const(char)* nick) c_g_enum_get_value_by_nick;
  GType function(const(char)* name, const(GEnumValue)* constStaticValues) c_g_enum_register_static;
  char* function(GType gEnumType, int value) c_g_enum_to_string;
  void function(GType gFlagsType, GTypeInfo* info, const(GFlagsValue)* constValues) c_g_flags_complete_type_info;
  GFlagsValue* function(GFlagsClass* flagsClass, uint value) c_g_flags_get_first_value;
  GFlagsValue* function(GFlagsClass* flagsClass, const(char)* name) c_g_flags_get_value_by_name;
  GFlagsValue* function(GFlagsClass* flagsClass, const(char)* nick) c_g_flags_get_value_by_nick;
  GType function(const(char)* name, const(GFlagsValue)* constStaticValues) c_g_flags_register_static;
  char* function(GType flagsType, uint value) c_g_flags_to_string;
  GType function() c_g_gtype_get_type;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, bool defaultValue, GParamFlags flags) c_g_param_spec_boolean;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType boxedType, GParamFlags flags) c_g_param_spec_boxed;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, byte minimum, byte maximum, byte defaultValue, GParamFlags flags) c_g_param_spec_char;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, double minimum, double maximum, double defaultValue, GParamFlags flags) c_g_param_spec_double;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType enumType, int defaultValue, GParamFlags flags) c_g_param_spec_enum;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType flagsType, uint defaultValue, GParamFlags flags) c_g_param_spec_flags;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, float minimum, float maximum, float defaultValue, GParamFlags flags) c_g_param_spec_float;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType isAType, GParamFlags flags) c_g_param_spec_gtype;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, int minimum, int maximum, int defaultValue, GParamFlags flags) c_g_param_spec_int;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, long minimum, long maximum, long defaultValue, GParamFlags flags) c_g_param_spec_int64;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, long minimum, long maximum, long defaultValue, GParamFlags flags) c_g_param_spec_long;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType objectType, GParamFlags flags) c_g_param_spec_object;
  GParamSpec* function(const(char)* name, GParamSpec* overridden) c_g_param_spec_override;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GType paramType, GParamFlags flags) c_g_param_spec_param;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GParamFlags flags) c_g_param_spec_pointer;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, const(char)* defaultValue, GParamFlags flags) c_g_param_spec_string;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, ubyte minimum, ubyte maximum, ubyte defaultValue, GParamFlags flags) c_g_param_spec_uchar;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, uint minimum, uint maximum, uint defaultValue, GParamFlags flags) c_g_param_spec_uint;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, ulong minimum, ulong maximum, ulong defaultValue, GParamFlags flags) c_g_param_spec_uint64;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, ulong minimum, ulong maximum, ulong defaultValue, GParamFlags flags) c_g_param_spec_ulong;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, dchar defaultValue, GParamFlags flags) c_g_param_spec_unichar;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GParamSpec* elementSpec, GParamFlags flags) c_g_param_spec_value_array;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, const(GVariantType)* type, VariantC* defaultValue, GParamFlags flags) c_g_param_spec_variant;
  GType function(const(char)* name, const(GParamSpecTypeInfo)* pspecInfo) c_g_param_type_register_static;
  bool function(GParamSpec* pspec, const(GValue)* srcValue, GValue* destValue, bool strictValidation) c_g_param_value_convert;
  bool function(GParamSpec* pspec, const(GValue)* value) c_g_param_value_defaults;
  bool function(GParamSpec* pspec, const(GValue)* value) c_g_param_value_is_valid;
  void function(GParamSpec* pspec, GValue* value) c_g_param_value_set_default;
  bool function(GParamSpec* pspec, GValue* value) c_g_param_value_validate;
  int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2) c_g_param_values_cmp;
  GType function(const(char)* name) c_g_pointer_type_register_static;
  bool function(GSignalInvocationHint* ihint, GValue* returnAccu, const(GValue)* handlerReturn, void* dummy) c_g_signal_accumulator_first_wins;
  bool function(GSignalInvocationHint* ihint, GValue* returnAccu, const(GValue)* handlerReturn, void* dummy) c_g_signal_accumulator_true_handled;
  ulong function(uint signalId, GQuark detail, GSignalEmissionHook hookFunc, void* hookData, GDestroyNotify dataDestroy) c_g_signal_add_emission_hook;
  void function(const(GValue)* instanceAndParams, GValue* returnValue) c_g_signal_chain_from_overridden;
  void function(GTypeInstance* instance,  ...) c_g_signal_chain_from_overridden_handler;
  ulong function(ObjectC* instance, const(char)* detailedSignal, GClosure* closure, bool after) c_g_signal_connect_closure;
  ulong function(ObjectC* instance, uint signalId, GQuark detail, GClosure* closure, bool after) c_g_signal_connect_closure_by_id;
  ulong function(ObjectC* instance, const(char)* detailedSignal, GCallback cHandler, void* data, GClosureNotify destroyData, GConnectFlags connectFlags) c_g_signal_connect_data;
  ulong function(GTypeInstance* instance, const(char)* detailedSignal, GCallback cHandler, ObjectC* gobject, GConnectFlags connectFlags) c_g_signal_connect_object;
  void function(ObjectC* instance, uint signalId, GQuark detail,  ...) c_g_signal_emit;
  void function(ObjectC* instance, const(char)* detailedSignal,  ...) c_g_signal_emit_by_name;
  void function(GTypeInstance* instance, uint signalId, GQuark detail, void* varArgs) c_g_signal_emit_valist;
  void function(const(GValue)* instanceAndParams, uint signalId, GQuark detail, GValue* returnValue) c_g_signal_emitv;
  GSignalInvocationHint* function(ObjectC* instance) c_g_signal_get_invocation_hint;
  void function(ObjectC* instance, ulong handlerId) c_g_signal_handler_block;
  void function(ObjectC* instance, ulong handlerId) c_g_signal_handler_disconnect;
  ulong function(ObjectC* instance, GSignalMatchType mask, uint signalId, GQuark detail, GClosure* closure, void* func, void* data) c_g_signal_handler_find;
  bool function(ObjectC* instance, ulong handlerId) c_g_signal_handler_is_connected;
  void function(ObjectC* instance, ulong handlerId) c_g_signal_handler_unblock;
  uint function(ObjectC* instance, GSignalMatchType mask, uint signalId, GQuark detail, GClosure* closure, void* func, void* data) c_g_signal_handlers_block_matched;
  void function(ObjectC* instance) c_g_signal_handlers_destroy;
  uint function(ObjectC* instance, GSignalMatchType mask, uint signalId, GQuark detail, GClosure* closure, void* func, void* data) c_g_signal_handlers_disconnect_matched;
  uint function(ObjectC* instance, GSignalMatchType mask, uint signalId, GQuark detail, GClosure* closure, void* func, void* data) c_g_signal_handlers_unblock_matched;
  bool function(ObjectC* instance, uint signalId, GQuark detail, bool mayBeBlocked) c_g_signal_has_handler_pending;
  bool function(const(char)* name) c_g_signal_is_valid_name;
  uint* function(GType itype, uint* nIds) c_g_signal_list_ids;
  uint function(const(char)* name, GType itype) c_g_signal_lookup;
  const(char)* function(uint signalId) c_g_signal_name;
  uint function(const(char)* signalName, GType itype, GSignalFlags signalFlags, uint classOffset, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams,  ...) c_g_signal_new;
  uint function(const(char)* signalName, GType itype, GSignalFlags signalFlags, GCallback classHandler, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams,  ...) c_g_signal_new_class_handler;
  uint function(const(char)* signalName, GType itype, GSignalFlags signalFlags, GClosure* classClosure, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, void* args) c_g_signal_new_valist;
  uint function(const(char)* signalName, GType itype, GSignalFlags signalFlags, GClosure* classClosure, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, GType* paramTypes) c_g_signal_newv;
  void function(uint signalId, GType instanceType, GClosure* classClosure) c_g_signal_override_class_closure;
  void function(const(char)* signalName, GType instanceType, GCallback classHandler) c_g_signal_override_class_handler;
  bool function(const(char)* detailedSignal, GType itype, uint* signalIdP, GQuark* detailP, bool forceDetailQuark) c_g_signal_parse_name;
  void function(uint signalId, GSignalQuery* query) c_g_signal_query;
  void function(uint signalId, ulong hookId) c_g_signal_remove_emission_hook;
  void function(uint signalId, GType instanceType, GSignalCVaMarshaller vaMarshaller) c_g_signal_set_va_marshaller;
  void function(ObjectC* instance, uint signalId, GQuark detail) c_g_signal_stop_emission;
  void function(ObjectC* instance, const(char)* detailedSignal) c_g_signal_stop_emission_by_name;
  GClosure* function(GType itype, uint structOffset) c_g_signal_type_cclosure_new;
  char* function(const(GValue)* value) c_g_strdup_value_contents;
  void function(void* cacheData, GTypeClassCacheFunc cacheFunc) c_g_type_add_class_cache_func;
  void function(GType classType, size_t privateSize) c_g_type_add_class_private;
  int function(GType classType, size_t privateSize) c_g_type_add_instance_private;
  void function(void* checkData, GTypeInterfaceCheckFunc checkFunc) c_g_type_add_interface_check;
  void function(GType instanceType, GType interfaceType, GTypePlugin* plugin) c_g_type_add_interface_dynamic;
  void function(GType instanceType, GType interfaceType, const(GInterfaceInfo)* info) c_g_type_add_interface_static;
  GTypeClass* function(GTypeClass* gClass, GType isAType) c_g_type_check_class_cast;
  bool function(GTypeClass* gClass, GType isAType) c_g_type_check_class_is_a;
  bool function(GTypeInstance* instance) c_g_type_check_instance;
  GTypeInstance* function(GTypeInstance* instance, GType ifaceType) c_g_type_check_instance_cast;
  bool function(GTypeInstance* instance, GType ifaceType) c_g_type_check_instance_is_a;
  bool function(GTypeInstance* instance, GType fundamentalType) c_g_type_check_instance_is_fundamentally_a;
  bool function(GType type) c_g_type_check_is_value_type;
  bool function(const(GValue)* value) c_g_type_check_value;
  bool function(const(GValue)* value, GType type) c_g_type_check_value_holds;
  GType* function(GType type, uint* nChildren) c_g_type_children;
  GTypeInstance* function(GType type) c_g_type_create_instance;
  GTypeInterface* function(GType gType) c_g_type_default_interface_peek;
  GTypeInterface* function(GType gType) c_g_type_default_interface_ref;
  void function(GTypeInterface* gIface) c_g_type_default_interface_unref;
  uint function(GType type) c_g_type_depth;
  void function(GType type) c_g_type_ensure;
  void function(GTypeInstance* instance) c_g_type_free_instance;
  GType function(const(char)* name) c_g_type_from_name;
  GType function(GType typeId) c_g_type_fundamental;
  GType function() c_g_type_fundamental_next;
  int function(GType type) c_g_type_get_instance_count;
  GTypePlugin* function(GType type) c_g_type_get_plugin;
  void* function(GType type, GQuark quark) c_g_type_get_qdata;
  uint function() c_g_type_get_type_registration_serial;
  void function() c_g_type_init;
  void function(GTypeDebugFlags debugFlags) c_g_type_init_with_debug_flags;
  GType* function(GType type, uint* nInterfaces) c_g_type_interfaces;
  bool function(GType type, GType isAType) c_g_type_is_a;
  const(char)* function(GType type) c_g_type_name;
  const(char)* function(GTypeClass* gClass) c_g_type_name_from_class;
  const(char)* function(GTypeInstance* instance) c_g_type_name_from_instance;
  GType function(GType leafType, GType rootType) c_g_type_next_base;
  GType function(GType type) c_g_type_parent;
  GQuark function(GType type) c_g_type_qname;
  void function(GType type, GTypeQuery* query) c_g_type_query;
  GType function(GType parentType, const(char)* typeName, GTypePlugin* plugin, GTypeFlags flags) c_g_type_register_dynamic;
  GType function(GType typeId, const(char)* typeName, const(GTypeInfo)* info, const(GTypeFundamentalInfo)* finfo, GTypeFlags flags) c_g_type_register_fundamental;
  GType function(GType parentType, const(char)* typeName, const(GTypeInfo)* info, GTypeFlags flags) c_g_type_register_static;
  GType function(GType parentType, const(char)* typeName, uint classSize, GClassInitFunc classInit, uint instanceSize, GInstanceInitFunc instanceInit, GTypeFlags flags) c_g_type_register_static_simple;
  void function(void* cacheData, GTypeClassCacheFunc cacheFunc) c_g_type_remove_class_cache_func;
  void function(void* checkData, GTypeInterfaceCheckFunc checkFunc) c_g_type_remove_interface_check;
  void function(GType type, GQuark quark, void* data) c_g_type_set_qdata;
  bool function(GType type, uint flags) c_g_type_test_flags;
  GType function() c_g_variant_get_gtype;

  // InitiallyUnowned
  GType function() c_g_initially_unowned_get_type;

  // ObjectClass
  GParamSpec* function(GObjectClass* oclass, const(char)* propertyName) c_g_object_class_find_property;
  void function(GObjectClass* oclass, uint nPspecs, GParamSpec** pspecs) c_g_object_class_install_properties;
  void function(GObjectClass* oclass, uint propertyId, GParamSpec* pspec) c_g_object_class_install_property;
  GParamSpec** function(GObjectClass* oclass, uint* nProperties) c_g_object_class_list_properties;
  void function(GObjectClass* oclass, uint propertyId, const(char)* name) c_g_object_class_override_property;

  // ObjectG
  GType function() c_g_object_get_type;
  ObjectC* function(GType objectType, const(char)* firstPropertyName,  ...) c_g_object_new;
  ObjectC* function(GType objectType, const(char)* firstPropertyName, void* varArgs) c_g_object_new_valist;
  ObjectC* function(GType objectType, uint nProperties, const(char*)* names, const(GValue)* values) c_g_object_new_with_properties;
  ObjectC* function(GType objectType, uint nParameters, GParameter* parameters) c_g_object_newv;
  size_t function(size_t what, void* data) c_g_object_compat_control;
  GParamSpec* function(GTypeInterface* gIface, const(char)* propertyName) c_g_object_interface_find_property;
  void function(GTypeInterface* gIface, GParamSpec* pspec) c_g_object_interface_install_property;
  GParamSpec** function(GTypeInterface* gIface, uint* nPropertiesP) c_g_object_interface_list_properties;
  void function(ObjectC* object, GToggleNotify notify, void* data) c_g_object_add_toggle_ref;
  void function(ObjectC* object, void** weakPointerLocation) c_g_object_add_weak_pointer;
  GBinding* function(ObjectC* source, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags) c_g_object_bind_property;
  GBinding* function(ObjectC* source, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags, GBindingTransformFunc transformTo, GBindingTransformFunc transformFrom, void* userData, GDestroyNotify notify) c_g_object_bind_property_full;
  GBinding* function(ObjectC* source, const(char)* sourceProperty, ObjectC* target, const(char)* targetProperty, GBindingFlags flags, GClosure* transformTo, GClosure* transformFrom) c_g_object_bind_property_with_closures;
  ObjectC* function(ObjectC* object, const(char)* signalSpec,  ...) c_g_object_connect;
  void function(ObjectC* object, const(char)* signalSpec,  ...) c_g_object_disconnect;
  void* function(ObjectC* object, const(char)* key, GDuplicateFunc dupFunc, void* userData) c_g_object_dup_data;
  void* function(ObjectC* object, GQuark quark, GDuplicateFunc dupFunc, void* userData) c_g_object_dup_qdata;
  void function(ObjectC* object) c_g_object_force_floating;
  void function(ObjectC* object) c_g_object_freeze_notify;
  void function(ObjectC* object, const(char)* firstPropertyName,  ...) c_g_object_get;
  void* function(ObjectC* object, const(char)* key) c_g_object_get_data;
  void function(ObjectC* object, const(char)* propertyName, GValue* value) c_g_object_get_property;
  void* function(ObjectC* object, GQuark quark) c_g_object_get_qdata;
  void function(ObjectC* object, const(char)* firstPropertyName, void* varArgs) c_g_object_get_valist;
  void function(ObjectC* object, uint nProperties, const(char*)* names, GValue* values) c_g_object_getv;
  bool function(ObjectC* object) c_g_object_is_floating;
  void function(ObjectC* object, const(char)* propertyName) c_g_object_notify;
  void function(ObjectC* object, GParamSpec* pspec) c_g_object_notify_by_pspec;
  ObjectC* function(ObjectC* object) c_g_object_ref;
  ObjectC* function(ObjectC* object) c_g_object_ref_sink;
  void function(ObjectC* object, GToggleNotify notify, void* data) c_g_object_remove_toggle_ref;
  void function(ObjectC* object, void** weakPointerLocation) c_g_object_remove_weak_pointer;
  bool function(ObjectC* object, const(char)* key, void* oldval, void* newval, GDestroyNotify destroy, GDestroyNotify* oldDestroy) c_g_object_replace_data;
  bool function(ObjectC* object, GQuark quark, void* oldval, void* newval, GDestroyNotify destroy, GDestroyNotify* oldDestroy) c_g_object_replace_qdata;
  void function(ObjectC* object) c_g_object_run_dispose;
  void function(ObjectC* object, const(char)* firstPropertyName,  ...) c_g_object_set;
  void function(ObjectC* object, const(char)* key, void* data) c_g_object_set_data;
  void function(ObjectC* object, const(char)* key, void* data, GDestroyNotify destroy) c_g_object_set_data_full;
  void function(ObjectC* object, const(char)* propertyName, const(GValue)* value) c_g_object_set_property;
  void function(ObjectC* object, GQuark quark, void* data) c_g_object_set_qdata;
  void function(ObjectC* object, GQuark quark, void* data, GDestroyNotify destroy) c_g_object_set_qdata_full;
  void function(ObjectC* object, const(char)* firstPropertyName, void* varArgs) c_g_object_set_valist;
  void function(ObjectC* object, uint nProperties, const(char*)* names, const(GValue)* values) c_g_object_setv;
  void* function(ObjectC* object, const(char)* key) c_g_object_steal_data;
  void* function(ObjectC* object, GQuark quark) c_g_object_steal_qdata;
  ObjectC* function(ObjectC* object) c_g_object_take_ref;
  void function(ObjectC* object) c_g_object_thaw_notify;
  void function(ObjectC* object) c_g_object_unref;
  void function(ObjectC* object, GClosure* closure) c_g_object_watch_closure;
  void function(ObjectC* object, GWeakNotify notify, void* data) c_g_object_weak_ref;
  void function(ObjectC* object, GWeakNotify notify, void* data) c_g_object_weak_unref;

  // ParamSpec
  GParamSpec* function(GType paramType, const(char)* name, const(char)* nick, const(char)* blurb, GParamFlags flags) c_g_param_spec_internal;
  bool function(const(char)* name) c_g_param_spec_is_valid_name;
  const(char)* function(GParamSpec* pspec) c_g_param_spec_get_blurb;
  const(GValue)* function(GParamSpec* pspec) c_g_param_spec_get_default_value;
  const(char)* function(GParamSpec* pspec) c_g_param_spec_get_name;
  GQuark function(GParamSpec* pspec) c_g_param_spec_get_name_quark;
  const(char)* function(GParamSpec* pspec) c_g_param_spec_get_nick;
  void* function(GParamSpec* pspec, GQuark quark) c_g_param_spec_get_qdata;
  GParamSpec* function(GParamSpec* pspec) c_g_param_spec_get_redirect_target;
  GParamSpec* function(GParamSpec* pspec) c_g_param_spec_ref;
  GParamSpec* function(GParamSpec* pspec) c_g_param_spec_ref_sink;
  void function(GParamSpec* pspec, GQuark quark, void* data) c_g_param_spec_set_qdata;
  void function(GParamSpec* pspec, GQuark quark, void* data, GDestroyNotify destroy) c_g_param_spec_set_qdata_full;
  void function(GParamSpec* pspec) c_g_param_spec_sink;
  void* function(GParamSpec* pspec, GQuark quark) c_g_param_spec_steal_qdata;
  void function(GParamSpec* pspec) c_g_param_spec_unref;

  // ParamSpecPool
  void function(GParamSpecPool* pool) c_g_param_spec_pool_free;
  void function(GParamSpecPool* pool, GParamSpec* pspec, GType ownerType) c_g_param_spec_pool_insert;
  GParamSpec** function(GParamSpecPool* pool, GType ownerType, uint* nPspecsP) c_g_param_spec_pool_list;
  GList* function(GParamSpecPool* pool, GType ownerType) c_g_param_spec_pool_list_owned;
  GParamSpec* function(GParamSpecPool* pool, const(char)* paramName, GType ownerType, bool walkAncestors) c_g_param_spec_pool_lookup;
  void function(GParamSpecPool* pool, GParamSpec* pspec) c_g_param_spec_pool_remove;
  GParamSpecPool* function(bool typePrefixing) c_g_param_spec_pool_new;

  // SignalGroup
  GType function() c_g_signal_group_get_type;
  GSignalGroup* function(GType targetType) c_g_signal_group_new;
  void function(GSignalGroup* self) c_g_signal_group_block;
  void function(GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data) c_g_signal_group_connect;
  void function(GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data) c_g_signal_group_connect_after;
  void function(GSignalGroup* self, const(char)* detailedSignal, GClosure* closure, bool after) c_g_signal_group_connect_closure;
  void function(GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data, GClosureNotify notify, GConnectFlags flags) c_g_signal_group_connect_data;
  void function(GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* object, GConnectFlags flags) c_g_signal_group_connect_object;
  void function(GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data) c_g_signal_group_connect_swapped;
  ObjectC* function(GSignalGroup* self) c_g_signal_group_dup_target;
  void function(GSignalGroup* self, ObjectC* target) c_g_signal_group_set_target;
  void function(GSignalGroup* self) c_g_signal_group_unblock;

  // TypeClass
  void function(GTypeClass* gClass, size_t privateSize) c_g_type_class_add_private;
  int function(GTypeClass* gClass) c_g_type_class_get_instance_private_offset;
  void* function(GTypeClass* klass, GType privateType) c_g_type_class_get_private;
  GTypeClass* function(GTypeClass* gClass) c_g_type_class_peek_parent;
  void function(GTypeClass* gClass) c_g_type_class_unref;
  void function(GTypeClass* gClass) c_g_type_class_unref_uncached;
  void function(void* gClass, int* privateSizeOrOffset) c_g_type_class_adjust_private_offset;
  GTypeClass* function(GType type) c_g_type_class_peek;
  GTypeClass* function(GType type) c_g_type_class_peek_static;
  GTypeClass* function(GType type) c_g_type_class_ref;

  // TypeInstance
  void* function(GTypeInstance* instance, GType privateType) c_g_type_instance_get_private;

  // TypeInterface
  GTypeInterface* function(GTypeInterface* gIface) c_g_type_interface_peek_parent;
  void function(GType interfaceType, GType prerequisiteType) c_g_type_interface_add_prerequisite;
  GTypePlugin* function(GType instanceType, GType interfaceType) c_g_type_interface_get_plugin;
  GType function(GType interfaceType) c_g_type_interface_instantiatable_prerequisite;
  GTypeInterface* function(GTypeClass* instanceClass, GType ifaceType) c_g_type_interface_peek;
  GType* function(GType interfaceType, uint* nPrerequisites) c_g_type_interface_prerequisites;

  // TypeModule
  GType function() c_g_type_module_get_type;
  void function(GTypeModule* module_, GType instanceType, GType interfaceType, const(GInterfaceInfo)* interfaceInfo) c_g_type_module_add_interface;
  GType function(GTypeModule* module_, const(char)* name, const(GEnumValue)* constStaticValues) c_g_type_module_register_enum;
  GType function(GTypeModule* module_, const(char)* name, const(GFlagsValue)* constStaticValues) c_g_type_module_register_flags;
  GType function(GTypeModule* module_, GType parentType, const(char)* typeName, const(GTypeInfo)* typeInfo, GTypeFlags flags) c_g_type_module_register_type;
  void function(GTypeModule* module_, const(char)* name) c_g_type_module_set_name;
  void function(GTypeModule* module_) c_g_type_module_unuse;
  bool function(GTypeModule* module_) c_g_type_module_use;

  // TypePlugin
  GType function() c_g_type_plugin_get_type;
  void function(GTypePlugin* plugin, GType instanceType, GType interfaceType, GInterfaceInfo* info) c_g_type_plugin_complete_interface_info;
  void function(GTypePlugin* plugin, GType gType, GTypeInfo* info, GTypeValueTable* valueTable) c_g_type_plugin_complete_type_info;
  void function(GTypePlugin* plugin) c_g_type_plugin_unuse;
  void function(GTypePlugin* plugin) c_g_type_plugin_use;

  // TypeValueTable
  GTypeValueTable* function(GType type) c_g_type_value_table_peek;

  // Value
  GType function() c_g_value_get_type;
  void function(const(GValue)* srcValue, GValue* destValue) c_g_value_copy;
  void* function(const(GValue)* value) c_g_value_dup_boxed;
  ObjectC* function(const(GValue)* value) c_g_value_dup_object;
  GParamSpec* function(const(GValue)* value) c_g_value_dup_param;
  char* function(const(GValue)* value) c_g_value_dup_string;
  VariantC* function(const(GValue)* value) c_g_value_dup_variant;
  bool function(const(GValue)* value) c_g_value_fits_pointer;
  bool function(const(GValue)* value) c_g_value_get_boolean;
  void* function(const(GValue)* value) c_g_value_get_boxed;
  char function(const(GValue)* value) c_g_value_get_char;
  double function(const(GValue)* value) c_g_value_get_double;
  int function(const(GValue)* value) c_g_value_get_enum;
  uint function(const(GValue)* value) c_g_value_get_flags;
  float function(const(GValue)* value) c_g_value_get_float;
  GType function(const(GValue)* value) c_g_value_get_gtype;
  int function(const(GValue)* value) c_g_value_get_int;
  long function(const(GValue)* value) c_g_value_get_int64;
  long function(const(GValue)* value) c_g_value_get_long;
  ObjectC* function(const(GValue)* value) c_g_value_get_object;
  GParamSpec* function(const(GValue)* value) c_g_value_get_param;
  void* function(const(GValue)* value) c_g_value_get_pointer;
  byte function(const(GValue)* value) c_g_value_get_schar;
  const(char)* function(const(GValue)* value) c_g_value_get_string;
  ubyte function(const(GValue)* value) c_g_value_get_uchar;
  uint function(const(GValue)* value) c_g_value_get_uint;
  ulong function(const(GValue)* value) c_g_value_get_uint64;
  ulong function(const(GValue)* value) c_g_value_get_ulong;
  VariantC* function(const(GValue)* value) c_g_value_get_variant;
  GValue* function(GValue* value, GType gType) c_g_value_init;
  void function(GValue* value, GTypeInstance* instance) c_g_value_init_from_instance;
  void* function(const(GValue)* value) c_g_value_peek_pointer;
  GValue* function(GValue* value) c_g_value_reset;
  void function(GValue* value, bool vBoolean) c_g_value_set_boolean;
  void function(GValue* value, const(void)* vBoxed) c_g_value_set_boxed;
  void function(GValue* value, const(void)* vBoxed) c_g_value_set_boxed_take_ownership;
  void function(GValue* value, char vChar) c_g_value_set_char;
  void function(GValue* value, double vDouble) c_g_value_set_double;
  void function(GValue* value, int vEnum) c_g_value_set_enum;
  void function(GValue* value, uint vFlags) c_g_value_set_flags;
  void function(GValue* value, float vFloat) c_g_value_set_float;
  void function(GValue* value, GType vGtype) c_g_value_set_gtype;
  void function(GValue* value, void* instance) c_g_value_set_instance;
  void function(GValue* value, int vInt) c_g_value_set_int;
  void function(GValue* value, long vInt64) c_g_value_set_int64;
  void function(GValue* value, const(char)* vString) c_g_value_set_interned_string;
  void function(GValue* value, long vLong) c_g_value_set_long;
  void function(GValue* value, ObjectC* vObject) c_g_value_set_object;
  void function(GValue* value, void* vObject) c_g_value_set_object_take_ownership;
  void function(GValue* value, GParamSpec* param) c_g_value_set_param;
  void function(GValue* value, GParamSpec* param) c_g_value_set_param_take_ownership;
  void function(GValue* value, void* vPointer) c_g_value_set_pointer;
  void function(GValue* value, byte vChar) c_g_value_set_schar;
  void function(GValue* value, const(void)* vBoxed) c_g_value_set_static_boxed;
  void function(GValue* value, const(char)* vString) c_g_value_set_static_string;
  void function(GValue* value, const(char)* vString) c_g_value_set_string;
  void function(GValue* value, char* vString) c_g_value_set_string_take_ownership;
  void function(GValue* value, ubyte vUchar) c_g_value_set_uchar;
  void function(GValue* value, uint vUint) c_g_value_set_uint;
  void function(GValue* value, ulong vUint64) c_g_value_set_uint64;
  void function(GValue* value, ulong vUlong) c_g_value_set_ulong;
  void function(GValue* value, VariantC* variant) c_g_value_set_variant;
  char* function(GValue* value) c_g_value_steal_string;
  void function(GValue* value, const(void)* vBoxed) c_g_value_take_boxed;
  void function(GValue* value, void* vObject) c_g_value_take_object;
  void function(GValue* value, GParamSpec* param) c_g_value_take_param;
  void function(GValue* value, char* vString) c_g_value_take_string;
  void function(GValue* value, VariantC* variant) c_g_value_take_variant;
  bool function(const(GValue)* srcValue, GValue* destValue) c_g_value_transform;
  void function(GValue* value) c_g_value_unset;
  void function(GType srcType, GType destType, GValueTransform transformFunc) c_g_value_register_transform_func;
  bool function(GType srcType, GType destType) c_g_value_type_compatible;
  bool function(GType srcType, GType destType) c_g_value_type_transformable;

  // ValueArray
  GType function() c_g_value_array_get_type;
  GValueArray* function(uint nPrealloced) c_g_value_array_new;
  GValueArray* function(GValueArray* valueArray, const(GValue)* value) c_g_value_array_append;
  GValueArray* function(const(GValueArray)* valueArray) c_g_value_array_copy;
  void function(GValueArray* valueArray) c_g_value_array_free;
  GValue* function(GValueArray* valueArray, uint index) c_g_value_array_get_nth;
  GValueArray* function(GValueArray* valueArray, uint index, const(GValue)* value) c_g_value_array_insert;
  GValueArray* function(GValueArray* valueArray, const(GValue)* value) c_g_value_array_prepend;
  GValueArray* function(GValueArray* valueArray, uint index) c_g_value_array_remove;
  GValueArray* function(GValueArray* valueArray, GCompareFunc compareFunc) c_g_value_array_sort;
  GValueArray* function(GValueArray* valueArray, GCompareDataFunc compareFunc, void* userData) c_g_value_array_sort_with_data;

  // WeakRef
  void function(GWeakRef* weakRef) c_g_weak_ref_clear;
  ObjectC* function(GWeakRef* weakRef) c_g_weak_ref_get;
  void function(GWeakRef* weakRef, ObjectC* object) c_g_weak_ref_init;
  void function(GWeakRef* weakRef, ObjectC* object) c_g_weak_ref_set;
}

// Binding
alias g_binding_get_type = c_g_binding_get_type;
alias g_binding_dup_source = c_g_binding_dup_source;
alias g_binding_dup_target = c_g_binding_dup_target;
alias g_binding_get_flags = c_g_binding_get_flags;
alias g_binding_get_source = c_g_binding_get_source;
alias g_binding_get_source_property = c_g_binding_get_source_property;
alias g_binding_get_target = c_g_binding_get_target;
alias g_binding_get_target_property = c_g_binding_get_target_property;
alias g_binding_unbind = c_g_binding_unbind;

// BindingGroup
alias g_binding_group_get_type = c_g_binding_group_get_type;
alias g_binding_group_new = c_g_binding_group_new;
alias g_binding_group_bind = c_g_binding_group_bind;
alias g_binding_group_bind_full = c_g_binding_group_bind_full;
alias g_binding_group_bind_with_closures = c_g_binding_group_bind_with_closures;
alias g_binding_group_dup_source = c_g_binding_group_dup_source;
alias g_binding_group_set_source = c_g_binding_group_set_source;

// CClosure
alias g_cclosure_marshal_BOOLEAN__BOXED_BOXED = c_g_cclosure_marshal_BOOLEAN__BOXED_BOXED;
alias g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv = c_g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv;
alias g_cclosure_marshal_BOOLEAN__FLAGS = c_g_cclosure_marshal_BOOLEAN__FLAGS;
alias g_cclosure_marshal_BOOLEAN__FLAGSv = c_g_cclosure_marshal_BOOLEAN__FLAGSv;
alias g_cclosure_marshal_STRING__OBJECT_POINTER = c_g_cclosure_marshal_STRING__OBJECT_POINTER;
alias g_cclosure_marshal_STRING__OBJECT_POINTERv = c_g_cclosure_marshal_STRING__OBJECT_POINTERv;
alias g_cclosure_marshal_VOID__BOOLEAN = c_g_cclosure_marshal_VOID__BOOLEAN;
alias g_cclosure_marshal_VOID__BOOLEANv = c_g_cclosure_marshal_VOID__BOOLEANv;
alias g_cclosure_marshal_VOID__BOXED = c_g_cclosure_marshal_VOID__BOXED;
alias g_cclosure_marshal_VOID__BOXEDv = c_g_cclosure_marshal_VOID__BOXEDv;
alias g_cclosure_marshal_VOID__CHAR = c_g_cclosure_marshal_VOID__CHAR;
alias g_cclosure_marshal_VOID__CHARv = c_g_cclosure_marshal_VOID__CHARv;
alias g_cclosure_marshal_VOID__DOUBLE = c_g_cclosure_marshal_VOID__DOUBLE;
alias g_cclosure_marshal_VOID__DOUBLEv = c_g_cclosure_marshal_VOID__DOUBLEv;
alias g_cclosure_marshal_VOID__ENUM = c_g_cclosure_marshal_VOID__ENUM;
alias g_cclosure_marshal_VOID__ENUMv = c_g_cclosure_marshal_VOID__ENUMv;
alias g_cclosure_marshal_VOID__FLAGS = c_g_cclosure_marshal_VOID__FLAGS;
alias g_cclosure_marshal_VOID__FLAGSv = c_g_cclosure_marshal_VOID__FLAGSv;
alias g_cclosure_marshal_VOID__FLOAT = c_g_cclosure_marshal_VOID__FLOAT;
alias g_cclosure_marshal_VOID__FLOATv = c_g_cclosure_marshal_VOID__FLOATv;
alias g_cclosure_marshal_VOID__INT = c_g_cclosure_marshal_VOID__INT;
alias g_cclosure_marshal_VOID__INTv = c_g_cclosure_marshal_VOID__INTv;
alias g_cclosure_marshal_VOID__LONG = c_g_cclosure_marshal_VOID__LONG;
alias g_cclosure_marshal_VOID__LONGv = c_g_cclosure_marshal_VOID__LONGv;
alias g_cclosure_marshal_VOID__OBJECT = c_g_cclosure_marshal_VOID__OBJECT;
alias g_cclosure_marshal_VOID__OBJECTv = c_g_cclosure_marshal_VOID__OBJECTv;
alias g_cclosure_marshal_VOID__PARAM = c_g_cclosure_marshal_VOID__PARAM;
alias g_cclosure_marshal_VOID__PARAMv = c_g_cclosure_marshal_VOID__PARAMv;
alias g_cclosure_marshal_VOID__POINTER = c_g_cclosure_marshal_VOID__POINTER;
alias g_cclosure_marshal_VOID__POINTERv = c_g_cclosure_marshal_VOID__POINTERv;
alias g_cclosure_marshal_VOID__STRING = c_g_cclosure_marshal_VOID__STRING;
alias g_cclosure_marshal_VOID__STRINGv = c_g_cclosure_marshal_VOID__STRINGv;
alias g_cclosure_marshal_VOID__UCHAR = c_g_cclosure_marshal_VOID__UCHAR;
alias g_cclosure_marshal_VOID__UCHARv = c_g_cclosure_marshal_VOID__UCHARv;
alias g_cclosure_marshal_VOID__UINT = c_g_cclosure_marshal_VOID__UINT;
alias g_cclosure_marshal_VOID__UINT_POINTER = c_g_cclosure_marshal_VOID__UINT_POINTER;
alias g_cclosure_marshal_VOID__UINT_POINTERv = c_g_cclosure_marshal_VOID__UINT_POINTERv;
alias g_cclosure_marshal_VOID__UINTv = c_g_cclosure_marshal_VOID__UINTv;
alias g_cclosure_marshal_VOID__ULONG = c_g_cclosure_marshal_VOID__ULONG;
alias g_cclosure_marshal_VOID__ULONGv = c_g_cclosure_marshal_VOID__ULONGv;
alias g_cclosure_marshal_VOID__VARIANT = c_g_cclosure_marshal_VOID__VARIANT;
alias g_cclosure_marshal_VOID__VARIANTv = c_g_cclosure_marshal_VOID__VARIANTv;
alias g_cclosure_marshal_VOID__VOID = c_g_cclosure_marshal_VOID__VOID;
alias g_cclosure_marshal_VOID__VOIDv = c_g_cclosure_marshal_VOID__VOIDv;
alias g_cclosure_marshal_generic = c_g_cclosure_marshal_generic;
alias g_cclosure_marshal_generic_va = c_g_cclosure_marshal_generic_va;
alias g_cclosure_new = c_g_cclosure_new;
alias g_cclosure_new_object = c_g_cclosure_new_object;
alias g_cclosure_new_object_swap = c_g_cclosure_new_object_swap;
alias g_cclosure_new_swap = c_g_cclosure_new_swap;

// Closure
alias g_closure_get_type = c_g_closure_get_type;
alias g_closure_new_object = c_g_closure_new_object;
alias g_closure_new_simple = c_g_closure_new_simple;
alias g_closure_add_finalize_notifier = c_g_closure_add_finalize_notifier;
alias g_closure_add_invalidate_notifier = c_g_closure_add_invalidate_notifier;
alias g_closure_add_marshal_guards = c_g_closure_add_marshal_guards;
alias g_closure_invalidate = c_g_closure_invalidate;
alias g_closure_invoke = c_g_closure_invoke;
alias g_closure_ref = c_g_closure_ref;
alias g_closure_remove_finalize_notifier = c_g_closure_remove_finalize_notifier;
alias g_closure_remove_invalidate_notifier = c_g_closure_remove_invalidate_notifier;
alias g_closure_set_marshal = c_g_closure_set_marshal;
alias g_closure_set_meta_marshal = c_g_closure_set_meta_marshal;
alias g_closure_sink = c_g_closure_sink;
alias g_closure_unref = c_g_closure_unref;

// Global
alias g_source_set_closure = c_g_source_set_closure;
alias g_source_set_dummy_callback = c_g_source_set_dummy_callback;
alias g_boxed_copy = c_g_boxed_copy;
alias g_boxed_free = c_g_boxed_free;
alias g_boxed_type_register_static = c_g_boxed_type_register_static;
alias g_clear_object = c_g_clear_object;
alias g_clear_signal_handler = c_g_clear_signal_handler;
alias g_enum_complete_type_info = c_g_enum_complete_type_info;
alias g_enum_get_value = c_g_enum_get_value;
alias g_enum_get_value_by_name = c_g_enum_get_value_by_name;
alias g_enum_get_value_by_nick = c_g_enum_get_value_by_nick;
alias g_enum_register_static = c_g_enum_register_static;
alias g_enum_to_string = c_g_enum_to_string;
alias g_flags_complete_type_info = c_g_flags_complete_type_info;
alias g_flags_get_first_value = c_g_flags_get_first_value;
alias g_flags_get_value_by_name = c_g_flags_get_value_by_name;
alias g_flags_get_value_by_nick = c_g_flags_get_value_by_nick;
alias g_flags_register_static = c_g_flags_register_static;
alias g_flags_to_string = c_g_flags_to_string;
alias g_gtype_get_type = c_g_gtype_get_type;
alias g_param_spec_boolean = c_g_param_spec_boolean;
alias g_param_spec_boxed = c_g_param_spec_boxed;
alias g_param_spec_char = c_g_param_spec_char;
alias g_param_spec_double = c_g_param_spec_double;
alias g_param_spec_enum = c_g_param_spec_enum;
alias g_param_spec_flags = c_g_param_spec_flags;
alias g_param_spec_float = c_g_param_spec_float;
alias g_param_spec_gtype = c_g_param_spec_gtype;
alias g_param_spec_int = c_g_param_spec_int;
alias g_param_spec_int64 = c_g_param_spec_int64;
alias g_param_spec_long = c_g_param_spec_long;
alias g_param_spec_object = c_g_param_spec_object;
alias g_param_spec_override = c_g_param_spec_override;
alias g_param_spec_param = c_g_param_spec_param;
alias g_param_spec_pointer = c_g_param_spec_pointer;
alias g_param_spec_string = c_g_param_spec_string;
alias g_param_spec_uchar = c_g_param_spec_uchar;
alias g_param_spec_uint = c_g_param_spec_uint;
alias g_param_spec_uint64 = c_g_param_spec_uint64;
alias g_param_spec_ulong = c_g_param_spec_ulong;
alias g_param_spec_unichar = c_g_param_spec_unichar;
alias g_param_spec_value_array = c_g_param_spec_value_array;
alias g_param_spec_variant = c_g_param_spec_variant;
alias g_param_type_register_static = c_g_param_type_register_static;
alias g_param_value_convert = c_g_param_value_convert;
alias g_param_value_defaults = c_g_param_value_defaults;
alias g_param_value_is_valid = c_g_param_value_is_valid;
alias g_param_value_set_default = c_g_param_value_set_default;
alias g_param_value_validate = c_g_param_value_validate;
alias g_param_values_cmp = c_g_param_values_cmp;
alias g_pointer_type_register_static = c_g_pointer_type_register_static;
alias g_signal_accumulator_first_wins = c_g_signal_accumulator_first_wins;
alias g_signal_accumulator_true_handled = c_g_signal_accumulator_true_handled;
alias g_signal_add_emission_hook = c_g_signal_add_emission_hook;
alias g_signal_chain_from_overridden = c_g_signal_chain_from_overridden;
alias g_signal_chain_from_overridden_handler = c_g_signal_chain_from_overridden_handler;
alias g_signal_connect_closure = c_g_signal_connect_closure;
alias g_signal_connect_closure_by_id = c_g_signal_connect_closure_by_id;
alias g_signal_connect_data = c_g_signal_connect_data;
alias g_signal_connect_object = c_g_signal_connect_object;
alias g_signal_emit = c_g_signal_emit;
alias g_signal_emit_by_name = c_g_signal_emit_by_name;
alias g_signal_emit_valist = c_g_signal_emit_valist;
alias g_signal_emitv = c_g_signal_emitv;
alias g_signal_get_invocation_hint = c_g_signal_get_invocation_hint;
alias g_signal_handler_block = c_g_signal_handler_block;
alias g_signal_handler_disconnect = c_g_signal_handler_disconnect;
alias g_signal_handler_find = c_g_signal_handler_find;
alias g_signal_handler_is_connected = c_g_signal_handler_is_connected;
alias g_signal_handler_unblock = c_g_signal_handler_unblock;
alias g_signal_handlers_block_matched = c_g_signal_handlers_block_matched;
alias g_signal_handlers_destroy = c_g_signal_handlers_destroy;
alias g_signal_handlers_disconnect_matched = c_g_signal_handlers_disconnect_matched;
alias g_signal_handlers_unblock_matched = c_g_signal_handlers_unblock_matched;
alias g_signal_has_handler_pending = c_g_signal_has_handler_pending;
alias g_signal_is_valid_name = c_g_signal_is_valid_name;
alias g_signal_list_ids = c_g_signal_list_ids;
alias g_signal_lookup = c_g_signal_lookup;
alias g_signal_name = c_g_signal_name;
alias g_signal_new = c_g_signal_new;
alias g_signal_new_class_handler = c_g_signal_new_class_handler;
alias g_signal_new_valist = c_g_signal_new_valist;
alias g_signal_newv = c_g_signal_newv;
alias g_signal_override_class_closure = c_g_signal_override_class_closure;
alias g_signal_override_class_handler = c_g_signal_override_class_handler;
alias g_signal_parse_name = c_g_signal_parse_name;
alias g_signal_query = c_g_signal_query;
alias g_signal_remove_emission_hook = c_g_signal_remove_emission_hook;
alias g_signal_set_va_marshaller = c_g_signal_set_va_marshaller;
alias g_signal_stop_emission = c_g_signal_stop_emission;
alias g_signal_stop_emission_by_name = c_g_signal_stop_emission_by_name;
alias g_signal_type_cclosure_new = c_g_signal_type_cclosure_new;
alias g_strdup_value_contents = c_g_strdup_value_contents;
alias g_type_add_class_cache_func = c_g_type_add_class_cache_func;
alias g_type_add_class_private = c_g_type_add_class_private;
alias g_type_add_instance_private = c_g_type_add_instance_private;
alias g_type_add_interface_check = c_g_type_add_interface_check;
alias g_type_add_interface_dynamic = c_g_type_add_interface_dynamic;
alias g_type_add_interface_static = c_g_type_add_interface_static;
alias g_type_check_class_cast = c_g_type_check_class_cast;
alias g_type_check_class_is_a = c_g_type_check_class_is_a;
alias g_type_check_instance = c_g_type_check_instance;
alias g_type_check_instance_cast = c_g_type_check_instance_cast;
alias g_type_check_instance_is_a = c_g_type_check_instance_is_a;
alias g_type_check_instance_is_fundamentally_a = c_g_type_check_instance_is_fundamentally_a;
alias g_type_check_is_value_type = c_g_type_check_is_value_type;
alias g_type_check_value = c_g_type_check_value;
alias g_type_check_value_holds = c_g_type_check_value_holds;
alias g_type_children = c_g_type_children;
alias g_type_create_instance = c_g_type_create_instance;
alias g_type_default_interface_peek = c_g_type_default_interface_peek;
alias g_type_default_interface_ref = c_g_type_default_interface_ref;
alias g_type_default_interface_unref = c_g_type_default_interface_unref;
alias g_type_depth = c_g_type_depth;
alias g_type_ensure = c_g_type_ensure;
alias g_type_free_instance = c_g_type_free_instance;
alias g_type_from_name = c_g_type_from_name;
alias g_type_fundamental = c_g_type_fundamental;
alias g_type_fundamental_next = c_g_type_fundamental_next;
alias g_type_get_instance_count = c_g_type_get_instance_count;
alias g_type_get_plugin = c_g_type_get_plugin;
alias g_type_get_qdata = c_g_type_get_qdata;
alias g_type_get_type_registration_serial = c_g_type_get_type_registration_serial;
alias g_type_init = c_g_type_init;
alias g_type_init_with_debug_flags = c_g_type_init_with_debug_flags;
alias g_type_interfaces = c_g_type_interfaces;
alias g_type_is_a = c_g_type_is_a;
alias g_type_name = c_g_type_name;
alias g_type_name_from_class = c_g_type_name_from_class;
alias g_type_name_from_instance = c_g_type_name_from_instance;
alias g_type_next_base = c_g_type_next_base;
alias g_type_parent = c_g_type_parent;
alias g_type_qname = c_g_type_qname;
alias g_type_query = c_g_type_query;
alias g_type_register_dynamic = c_g_type_register_dynamic;
alias g_type_register_fundamental = c_g_type_register_fundamental;
alias g_type_register_static = c_g_type_register_static;
alias g_type_register_static_simple = c_g_type_register_static_simple;
alias g_type_remove_class_cache_func = c_g_type_remove_class_cache_func;
alias g_type_remove_interface_check = c_g_type_remove_interface_check;
alias g_type_set_qdata = c_g_type_set_qdata;
alias g_type_test_flags = c_g_type_test_flags;
alias g_variant_get_gtype = c_g_variant_get_gtype;

// InitiallyUnowned
alias g_initially_unowned_get_type = c_g_initially_unowned_get_type;

// ObjectClass
alias g_object_class_find_property = c_g_object_class_find_property;
alias g_object_class_install_properties = c_g_object_class_install_properties;
alias g_object_class_install_property = c_g_object_class_install_property;
alias g_object_class_list_properties = c_g_object_class_list_properties;
alias g_object_class_override_property = c_g_object_class_override_property;

// ObjectG
alias g_object_get_type = c_g_object_get_type;
alias g_object_new = c_g_object_new;
alias g_object_new_valist = c_g_object_new_valist;
alias g_object_new_with_properties = c_g_object_new_with_properties;
alias g_object_newv = c_g_object_newv;
alias g_object_compat_control = c_g_object_compat_control;
alias g_object_interface_find_property = c_g_object_interface_find_property;
alias g_object_interface_install_property = c_g_object_interface_install_property;
alias g_object_interface_list_properties = c_g_object_interface_list_properties;
alias g_object_add_toggle_ref = c_g_object_add_toggle_ref;
alias g_object_add_weak_pointer = c_g_object_add_weak_pointer;
alias g_object_bind_property = c_g_object_bind_property;
alias g_object_bind_property_full = c_g_object_bind_property_full;
alias g_object_bind_property_with_closures = c_g_object_bind_property_with_closures;
alias g_object_connect = c_g_object_connect;
alias g_object_disconnect = c_g_object_disconnect;
alias g_object_dup_data = c_g_object_dup_data;
alias g_object_dup_qdata = c_g_object_dup_qdata;
alias g_object_force_floating = c_g_object_force_floating;
alias g_object_freeze_notify = c_g_object_freeze_notify;
alias g_object_get = c_g_object_get;
alias g_object_get_data = c_g_object_get_data;
alias g_object_get_property = c_g_object_get_property;
alias g_object_get_qdata = c_g_object_get_qdata;
alias g_object_get_valist = c_g_object_get_valist;
alias g_object_getv = c_g_object_getv;
alias g_object_is_floating = c_g_object_is_floating;
alias g_object_notify = c_g_object_notify;
alias g_object_notify_by_pspec = c_g_object_notify_by_pspec;
alias g_object_ref = c_g_object_ref;
alias g_object_ref_sink = c_g_object_ref_sink;
alias g_object_remove_toggle_ref = c_g_object_remove_toggle_ref;
alias g_object_remove_weak_pointer = c_g_object_remove_weak_pointer;
alias g_object_replace_data = c_g_object_replace_data;
alias g_object_replace_qdata = c_g_object_replace_qdata;
alias g_object_run_dispose = c_g_object_run_dispose;
alias g_object_set = c_g_object_set;
alias g_object_set_data = c_g_object_set_data;
alias g_object_set_data_full = c_g_object_set_data_full;
alias g_object_set_property = c_g_object_set_property;
alias g_object_set_qdata = c_g_object_set_qdata;
alias g_object_set_qdata_full = c_g_object_set_qdata_full;
alias g_object_set_valist = c_g_object_set_valist;
alias g_object_setv = c_g_object_setv;
alias g_object_steal_data = c_g_object_steal_data;
alias g_object_steal_qdata = c_g_object_steal_qdata;
alias g_object_take_ref = c_g_object_take_ref;
alias g_object_thaw_notify = c_g_object_thaw_notify;
alias g_object_unref = c_g_object_unref;
alias g_object_watch_closure = c_g_object_watch_closure;
alias g_object_weak_ref = c_g_object_weak_ref;
alias g_object_weak_unref = c_g_object_weak_unref;

// ParamSpec
alias g_param_spec_internal = c_g_param_spec_internal;
alias g_param_spec_is_valid_name = c_g_param_spec_is_valid_name;
alias g_param_spec_get_blurb = c_g_param_spec_get_blurb;
alias g_param_spec_get_default_value = c_g_param_spec_get_default_value;
alias g_param_spec_get_name = c_g_param_spec_get_name;
alias g_param_spec_get_name_quark = c_g_param_spec_get_name_quark;
alias g_param_spec_get_nick = c_g_param_spec_get_nick;
alias g_param_spec_get_qdata = c_g_param_spec_get_qdata;
alias g_param_spec_get_redirect_target = c_g_param_spec_get_redirect_target;
alias g_param_spec_ref = c_g_param_spec_ref;
alias g_param_spec_ref_sink = c_g_param_spec_ref_sink;
alias g_param_spec_set_qdata = c_g_param_spec_set_qdata;
alias g_param_spec_set_qdata_full = c_g_param_spec_set_qdata_full;
alias g_param_spec_sink = c_g_param_spec_sink;
alias g_param_spec_steal_qdata = c_g_param_spec_steal_qdata;
alias g_param_spec_unref = c_g_param_spec_unref;

// ParamSpecPool
alias g_param_spec_pool_free = c_g_param_spec_pool_free;
alias g_param_spec_pool_insert = c_g_param_spec_pool_insert;
alias g_param_spec_pool_list = c_g_param_spec_pool_list;
alias g_param_spec_pool_list_owned = c_g_param_spec_pool_list_owned;
alias g_param_spec_pool_lookup = c_g_param_spec_pool_lookup;
alias g_param_spec_pool_remove = c_g_param_spec_pool_remove;
alias g_param_spec_pool_new = c_g_param_spec_pool_new;

// SignalGroup
alias g_signal_group_get_type = c_g_signal_group_get_type;
alias g_signal_group_new = c_g_signal_group_new;
alias g_signal_group_block = c_g_signal_group_block;
alias g_signal_group_connect = c_g_signal_group_connect;
alias g_signal_group_connect_after = c_g_signal_group_connect_after;
alias g_signal_group_connect_closure = c_g_signal_group_connect_closure;
alias g_signal_group_connect_data = c_g_signal_group_connect_data;
alias g_signal_group_connect_object = c_g_signal_group_connect_object;
alias g_signal_group_connect_swapped = c_g_signal_group_connect_swapped;
alias g_signal_group_dup_target = c_g_signal_group_dup_target;
alias g_signal_group_set_target = c_g_signal_group_set_target;
alias g_signal_group_unblock = c_g_signal_group_unblock;

// TypeClass
alias g_type_class_add_private = c_g_type_class_add_private;
alias g_type_class_get_instance_private_offset = c_g_type_class_get_instance_private_offset;
alias g_type_class_get_private = c_g_type_class_get_private;
alias g_type_class_peek_parent = c_g_type_class_peek_parent;
alias g_type_class_unref = c_g_type_class_unref;
alias g_type_class_unref_uncached = c_g_type_class_unref_uncached;
alias g_type_class_adjust_private_offset = c_g_type_class_adjust_private_offset;
alias g_type_class_peek = c_g_type_class_peek;
alias g_type_class_peek_static = c_g_type_class_peek_static;
alias g_type_class_ref = c_g_type_class_ref;

// TypeInstance
alias g_type_instance_get_private = c_g_type_instance_get_private;

// TypeInterface
alias g_type_interface_peek_parent = c_g_type_interface_peek_parent;
alias g_type_interface_add_prerequisite = c_g_type_interface_add_prerequisite;
alias g_type_interface_get_plugin = c_g_type_interface_get_plugin;
alias g_type_interface_instantiatable_prerequisite = c_g_type_interface_instantiatable_prerequisite;
alias g_type_interface_peek = c_g_type_interface_peek;
alias g_type_interface_prerequisites = c_g_type_interface_prerequisites;

// TypeModule
alias g_type_module_get_type = c_g_type_module_get_type;
alias g_type_module_add_interface = c_g_type_module_add_interface;
alias g_type_module_register_enum = c_g_type_module_register_enum;
alias g_type_module_register_flags = c_g_type_module_register_flags;
alias g_type_module_register_type = c_g_type_module_register_type;
alias g_type_module_set_name = c_g_type_module_set_name;
alias g_type_module_unuse = c_g_type_module_unuse;
alias g_type_module_use = c_g_type_module_use;

// TypePlugin
alias g_type_plugin_get_type = c_g_type_plugin_get_type;
alias g_type_plugin_complete_interface_info = c_g_type_plugin_complete_interface_info;
alias g_type_plugin_complete_type_info = c_g_type_plugin_complete_type_info;
alias g_type_plugin_unuse = c_g_type_plugin_unuse;
alias g_type_plugin_use = c_g_type_plugin_use;

// TypeValueTable
alias g_type_value_table_peek = c_g_type_value_table_peek;

// Value
alias g_value_get_type = c_g_value_get_type;
alias g_value_copy = c_g_value_copy;
alias g_value_dup_boxed = c_g_value_dup_boxed;
alias g_value_dup_object = c_g_value_dup_object;
alias g_value_dup_param = c_g_value_dup_param;
alias g_value_dup_string = c_g_value_dup_string;
alias g_value_dup_variant = c_g_value_dup_variant;
alias g_value_fits_pointer = c_g_value_fits_pointer;
alias g_value_get_boolean = c_g_value_get_boolean;
alias g_value_get_boxed = c_g_value_get_boxed;
alias g_value_get_char = c_g_value_get_char;
alias g_value_get_double = c_g_value_get_double;
alias g_value_get_enum = c_g_value_get_enum;
alias g_value_get_flags = c_g_value_get_flags;
alias g_value_get_float = c_g_value_get_float;
alias g_value_get_gtype = c_g_value_get_gtype;
alias g_value_get_int = c_g_value_get_int;
alias g_value_get_int64 = c_g_value_get_int64;
alias g_value_get_long = c_g_value_get_long;
alias g_value_get_object = c_g_value_get_object;
alias g_value_get_param = c_g_value_get_param;
alias g_value_get_pointer = c_g_value_get_pointer;
alias g_value_get_schar = c_g_value_get_schar;
alias g_value_get_string = c_g_value_get_string;
alias g_value_get_uchar = c_g_value_get_uchar;
alias g_value_get_uint = c_g_value_get_uint;
alias g_value_get_uint64 = c_g_value_get_uint64;
alias g_value_get_ulong = c_g_value_get_ulong;
alias g_value_get_variant = c_g_value_get_variant;
alias g_value_init = c_g_value_init;
alias g_value_init_from_instance = c_g_value_init_from_instance;
alias g_value_peek_pointer = c_g_value_peek_pointer;
alias g_value_reset = c_g_value_reset;
alias g_value_set_boolean = c_g_value_set_boolean;
alias g_value_set_boxed = c_g_value_set_boxed;
alias g_value_set_boxed_take_ownership = c_g_value_set_boxed_take_ownership;
alias g_value_set_char = c_g_value_set_char;
alias g_value_set_double = c_g_value_set_double;
alias g_value_set_enum = c_g_value_set_enum;
alias g_value_set_flags = c_g_value_set_flags;
alias g_value_set_float = c_g_value_set_float;
alias g_value_set_gtype = c_g_value_set_gtype;
alias g_value_set_instance = c_g_value_set_instance;
alias g_value_set_int = c_g_value_set_int;
alias g_value_set_int64 = c_g_value_set_int64;
alias g_value_set_interned_string = c_g_value_set_interned_string;
alias g_value_set_long = c_g_value_set_long;
alias g_value_set_object = c_g_value_set_object;
alias g_value_set_object_take_ownership = c_g_value_set_object_take_ownership;
alias g_value_set_param = c_g_value_set_param;
alias g_value_set_param_take_ownership = c_g_value_set_param_take_ownership;
alias g_value_set_pointer = c_g_value_set_pointer;
alias g_value_set_schar = c_g_value_set_schar;
alias g_value_set_static_boxed = c_g_value_set_static_boxed;
alias g_value_set_static_string = c_g_value_set_static_string;
alias g_value_set_string = c_g_value_set_string;
alias g_value_set_string_take_ownership = c_g_value_set_string_take_ownership;
alias g_value_set_uchar = c_g_value_set_uchar;
alias g_value_set_uint = c_g_value_set_uint;
alias g_value_set_uint64 = c_g_value_set_uint64;
alias g_value_set_ulong = c_g_value_set_ulong;
alias g_value_set_variant = c_g_value_set_variant;
alias g_value_steal_string = c_g_value_steal_string;
alias g_value_take_boxed = c_g_value_take_boxed;
alias g_value_take_object = c_g_value_take_object;
alias g_value_take_param = c_g_value_take_param;
alias g_value_take_string = c_g_value_take_string;
alias g_value_take_variant = c_g_value_take_variant;
alias g_value_transform = c_g_value_transform;
alias g_value_unset = c_g_value_unset;
alias g_value_register_transform_func = c_g_value_register_transform_func;
alias g_value_type_compatible = c_g_value_type_compatible;
alias g_value_type_transformable = c_g_value_type_transformable;

// ValueArray
alias g_value_array_get_type = c_g_value_array_get_type;
alias g_value_array_new = c_g_value_array_new;
alias g_value_array_append = c_g_value_array_append;
alias g_value_array_copy = c_g_value_array_copy;
alias g_value_array_free = c_g_value_array_free;
alias g_value_array_get_nth = c_g_value_array_get_nth;
alias g_value_array_insert = c_g_value_array_insert;
alias g_value_array_prepend = c_g_value_array_prepend;
alias g_value_array_remove = c_g_value_array_remove;
alias g_value_array_sort = c_g_value_array_sort;
alias g_value_array_sort_with_data = c_g_value_array_sort_with_data;

// WeakRef
alias g_weak_ref_clear = c_g_weak_ref_clear;
alias g_weak_ref_get = c_g_weak_ref_get;
alias g_weak_ref_init = c_g_weak_ref_init;
alias g_weak_ref_set = c_g_weak_ref_set;

shared static this()
{
  // Binding
  link(g_binding_get_type, "g_binding_get_type");
  link(g_binding_dup_source, "g_binding_dup_source");
  link(g_binding_dup_target, "g_binding_dup_target");
  link(g_binding_get_flags, "g_binding_get_flags");
  link(g_binding_get_source, "g_binding_get_source");
  link(g_binding_get_source_property, "g_binding_get_source_property");
  link(g_binding_get_target, "g_binding_get_target");
  link(g_binding_get_target_property, "g_binding_get_target_property");
  link(g_binding_unbind, "g_binding_unbind");

  // BindingGroup
  link(g_binding_group_get_type, "g_binding_group_get_type");
  link(g_binding_group_new, "g_binding_group_new");
  link(g_binding_group_bind, "g_binding_group_bind");
  link(g_binding_group_bind_full, "g_binding_group_bind_full");
  link(g_binding_group_bind_with_closures, "g_binding_group_bind_with_closures");
  link(g_binding_group_dup_source, "g_binding_group_dup_source");
  link(g_binding_group_set_source, "g_binding_group_set_source");

  // CClosure
  link(g_cclosure_marshal_BOOLEAN__BOXED_BOXED, "g_cclosure_marshal_BOOLEAN__BOXED_BOXED");
  link(g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv, "g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv");
  link(g_cclosure_marshal_BOOLEAN__FLAGS, "g_cclosure_marshal_BOOLEAN__FLAGS");
  link(g_cclosure_marshal_BOOLEAN__FLAGSv, "g_cclosure_marshal_BOOLEAN__FLAGSv");
  link(g_cclosure_marshal_STRING__OBJECT_POINTER, "g_cclosure_marshal_STRING__OBJECT_POINTER");
  link(g_cclosure_marshal_STRING__OBJECT_POINTERv, "g_cclosure_marshal_STRING__OBJECT_POINTERv");
  link(g_cclosure_marshal_VOID__BOOLEAN, "g_cclosure_marshal_VOID__BOOLEAN");
  link(g_cclosure_marshal_VOID__BOOLEANv, "g_cclosure_marshal_VOID__BOOLEANv");
  link(g_cclosure_marshal_VOID__BOXED, "g_cclosure_marshal_VOID__BOXED");
  link(g_cclosure_marshal_VOID__BOXEDv, "g_cclosure_marshal_VOID__BOXEDv");
  link(g_cclosure_marshal_VOID__CHAR, "g_cclosure_marshal_VOID__CHAR");
  link(g_cclosure_marshal_VOID__CHARv, "g_cclosure_marshal_VOID__CHARv");
  link(g_cclosure_marshal_VOID__DOUBLE, "g_cclosure_marshal_VOID__DOUBLE");
  link(g_cclosure_marshal_VOID__DOUBLEv, "g_cclosure_marshal_VOID__DOUBLEv");
  link(g_cclosure_marshal_VOID__ENUM, "g_cclosure_marshal_VOID__ENUM");
  link(g_cclosure_marshal_VOID__ENUMv, "g_cclosure_marshal_VOID__ENUMv");
  link(g_cclosure_marshal_VOID__FLAGS, "g_cclosure_marshal_VOID__FLAGS");
  link(g_cclosure_marshal_VOID__FLAGSv, "g_cclosure_marshal_VOID__FLAGSv");
  link(g_cclosure_marshal_VOID__FLOAT, "g_cclosure_marshal_VOID__FLOAT");
  link(g_cclosure_marshal_VOID__FLOATv, "g_cclosure_marshal_VOID__FLOATv");
  link(g_cclosure_marshal_VOID__INT, "g_cclosure_marshal_VOID__INT");
  link(g_cclosure_marshal_VOID__INTv, "g_cclosure_marshal_VOID__INTv");
  link(g_cclosure_marshal_VOID__LONG, "g_cclosure_marshal_VOID__LONG");
  link(g_cclosure_marshal_VOID__LONGv, "g_cclosure_marshal_VOID__LONGv");
  link(g_cclosure_marshal_VOID__OBJECT, "g_cclosure_marshal_VOID__OBJECT");
  link(g_cclosure_marshal_VOID__OBJECTv, "g_cclosure_marshal_VOID__OBJECTv");
  link(g_cclosure_marshal_VOID__PARAM, "g_cclosure_marshal_VOID__PARAM");
  link(g_cclosure_marshal_VOID__PARAMv, "g_cclosure_marshal_VOID__PARAMv");
  link(g_cclosure_marshal_VOID__POINTER, "g_cclosure_marshal_VOID__POINTER");
  link(g_cclosure_marshal_VOID__POINTERv, "g_cclosure_marshal_VOID__POINTERv");
  link(g_cclosure_marshal_VOID__STRING, "g_cclosure_marshal_VOID__STRING");
  link(g_cclosure_marshal_VOID__STRINGv, "g_cclosure_marshal_VOID__STRINGv");
  link(g_cclosure_marshal_VOID__UCHAR, "g_cclosure_marshal_VOID__UCHAR");
  link(g_cclosure_marshal_VOID__UCHARv, "g_cclosure_marshal_VOID__UCHARv");
  link(g_cclosure_marshal_VOID__UINT, "g_cclosure_marshal_VOID__UINT");
  link(g_cclosure_marshal_VOID__UINT_POINTER, "g_cclosure_marshal_VOID__UINT_POINTER");
  link(g_cclosure_marshal_VOID__UINT_POINTERv, "g_cclosure_marshal_VOID__UINT_POINTERv");
  link(g_cclosure_marshal_VOID__UINTv, "g_cclosure_marshal_VOID__UINTv");
  link(g_cclosure_marshal_VOID__ULONG, "g_cclosure_marshal_VOID__ULONG");
  link(g_cclosure_marshal_VOID__ULONGv, "g_cclosure_marshal_VOID__ULONGv");
  link(g_cclosure_marshal_VOID__VARIANT, "g_cclosure_marshal_VOID__VARIANT");
  link(g_cclosure_marshal_VOID__VARIANTv, "g_cclosure_marshal_VOID__VARIANTv");
  link(g_cclosure_marshal_VOID__VOID, "g_cclosure_marshal_VOID__VOID");
  link(g_cclosure_marshal_VOID__VOIDv, "g_cclosure_marshal_VOID__VOIDv");
  link(g_cclosure_marshal_generic, "g_cclosure_marshal_generic");
  link(g_cclosure_marshal_generic_va, "g_cclosure_marshal_generic_va");
  link(g_cclosure_new, "g_cclosure_new");
  link(g_cclosure_new_object, "g_cclosure_new_object");
  link(g_cclosure_new_object_swap, "g_cclosure_new_object_swap");
  link(g_cclosure_new_swap, "g_cclosure_new_swap");

  // Closure
  link(g_closure_get_type, "g_closure_get_type");
  link(g_closure_new_object, "g_closure_new_object");
  link(g_closure_new_simple, "g_closure_new_simple");
  link(g_closure_add_finalize_notifier, "g_closure_add_finalize_notifier");
  link(g_closure_add_invalidate_notifier, "g_closure_add_invalidate_notifier");
  link(g_closure_add_marshal_guards, "g_closure_add_marshal_guards");
  link(g_closure_invalidate, "g_closure_invalidate");
  link(g_closure_invoke, "g_closure_invoke");
  link(g_closure_ref, "g_closure_ref");
  link(g_closure_remove_finalize_notifier, "g_closure_remove_finalize_notifier");
  link(g_closure_remove_invalidate_notifier, "g_closure_remove_invalidate_notifier");
  link(g_closure_set_marshal, "g_closure_set_marshal");
  link(g_closure_set_meta_marshal, "g_closure_set_meta_marshal");
  link(g_closure_sink, "g_closure_sink");
  link(g_closure_unref, "g_closure_unref");

  // Global
  link(g_source_set_closure, "g_source_set_closure");
  link(g_source_set_dummy_callback, "g_source_set_dummy_callback");
  link(g_boxed_copy, "g_boxed_copy");
  link(g_boxed_free, "g_boxed_free");
  link(g_boxed_type_register_static, "g_boxed_type_register_static");
  link(g_clear_object, "g_clear_object");
  link(g_clear_signal_handler, "g_clear_signal_handler");
  link(g_enum_complete_type_info, "g_enum_complete_type_info");
  link(g_enum_get_value, "g_enum_get_value");
  link(g_enum_get_value_by_name, "g_enum_get_value_by_name");
  link(g_enum_get_value_by_nick, "g_enum_get_value_by_nick");
  link(g_enum_register_static, "g_enum_register_static");
  link(g_enum_to_string, "g_enum_to_string");
  link(g_flags_complete_type_info, "g_flags_complete_type_info");
  link(g_flags_get_first_value, "g_flags_get_first_value");
  link(g_flags_get_value_by_name, "g_flags_get_value_by_name");
  link(g_flags_get_value_by_nick, "g_flags_get_value_by_nick");
  link(g_flags_register_static, "g_flags_register_static");
  link(g_flags_to_string, "g_flags_to_string");
  link(g_gtype_get_type, "g_gtype_get_type");
  link(g_param_spec_boolean, "g_param_spec_boolean");
  link(g_param_spec_boxed, "g_param_spec_boxed");
  link(g_param_spec_char, "g_param_spec_char");
  link(g_param_spec_double, "g_param_spec_double");
  link(g_param_spec_enum, "g_param_spec_enum");
  link(g_param_spec_flags, "g_param_spec_flags");
  link(g_param_spec_float, "g_param_spec_float");
  link(g_param_spec_gtype, "g_param_spec_gtype");
  link(g_param_spec_int, "g_param_spec_int");
  link(g_param_spec_int64, "g_param_spec_int64");
  link(g_param_spec_long, "g_param_spec_long");
  link(g_param_spec_object, "g_param_spec_object");
  link(g_param_spec_override, "g_param_spec_override");
  link(g_param_spec_param, "g_param_spec_param");
  link(g_param_spec_pointer, "g_param_spec_pointer");
  link(g_param_spec_string, "g_param_spec_string");
  link(g_param_spec_uchar, "g_param_spec_uchar");
  link(g_param_spec_uint, "g_param_spec_uint");
  link(g_param_spec_uint64, "g_param_spec_uint64");
  link(g_param_spec_ulong, "g_param_spec_ulong");
  link(g_param_spec_unichar, "g_param_spec_unichar");
  link(g_param_spec_value_array, "g_param_spec_value_array");
  link(g_param_spec_variant, "g_param_spec_variant");
  link(g_param_type_register_static, "g_param_type_register_static");
  link(g_param_value_convert, "g_param_value_convert");
  link(g_param_value_defaults, "g_param_value_defaults");
  link(g_param_value_is_valid, "g_param_value_is_valid");
  link(g_param_value_set_default, "g_param_value_set_default");
  link(g_param_value_validate, "g_param_value_validate");
  link(g_param_values_cmp, "g_param_values_cmp");
  link(g_pointer_type_register_static, "g_pointer_type_register_static");
  link(g_signal_accumulator_first_wins, "g_signal_accumulator_first_wins");
  link(g_signal_accumulator_true_handled, "g_signal_accumulator_true_handled");
  link(g_signal_add_emission_hook, "g_signal_add_emission_hook");
  link(g_signal_chain_from_overridden, "g_signal_chain_from_overridden");
  link(g_signal_chain_from_overridden_handler, "g_signal_chain_from_overridden_handler");
  link(g_signal_connect_closure, "g_signal_connect_closure");
  link(g_signal_connect_closure_by_id, "g_signal_connect_closure_by_id");
  link(g_signal_connect_data, "g_signal_connect_data");
  link(g_signal_connect_object, "g_signal_connect_object");
  link(g_signal_emit, "g_signal_emit");
  link(g_signal_emit_by_name, "g_signal_emit_by_name");
  link(g_signal_emit_valist, "g_signal_emit_valist");
  link(g_signal_emitv, "g_signal_emitv");
  link(g_signal_get_invocation_hint, "g_signal_get_invocation_hint");
  link(g_signal_handler_block, "g_signal_handler_block");
  link(g_signal_handler_disconnect, "g_signal_handler_disconnect");
  link(g_signal_handler_find, "g_signal_handler_find");
  link(g_signal_handler_is_connected, "g_signal_handler_is_connected");
  link(g_signal_handler_unblock, "g_signal_handler_unblock");
  link(g_signal_handlers_block_matched, "g_signal_handlers_block_matched");
  link(g_signal_handlers_destroy, "g_signal_handlers_destroy");
  link(g_signal_handlers_disconnect_matched, "g_signal_handlers_disconnect_matched");
  link(g_signal_handlers_unblock_matched, "g_signal_handlers_unblock_matched");
  link(g_signal_has_handler_pending, "g_signal_has_handler_pending");
  link(g_signal_is_valid_name, "g_signal_is_valid_name");
  link(g_signal_list_ids, "g_signal_list_ids");
  link(g_signal_lookup, "g_signal_lookup");
  link(g_signal_name, "g_signal_name");
  link(g_signal_new, "g_signal_new");
  link(g_signal_new_class_handler, "g_signal_new_class_handler");
  link(g_signal_new_valist, "g_signal_new_valist");
  link(g_signal_newv, "g_signal_newv");
  link(g_signal_override_class_closure, "g_signal_override_class_closure");
  link(g_signal_override_class_handler, "g_signal_override_class_handler");
  link(g_signal_parse_name, "g_signal_parse_name");
  link(g_signal_query, "g_signal_query");
  link(g_signal_remove_emission_hook, "g_signal_remove_emission_hook");
  link(g_signal_set_va_marshaller, "g_signal_set_va_marshaller");
  link(g_signal_stop_emission, "g_signal_stop_emission");
  link(g_signal_stop_emission_by_name, "g_signal_stop_emission_by_name");
  link(g_signal_type_cclosure_new, "g_signal_type_cclosure_new");
  link(g_strdup_value_contents, "g_strdup_value_contents");
  link(g_type_add_class_cache_func, "g_type_add_class_cache_func");
  link(g_type_add_class_private, "g_type_add_class_private");
  link(g_type_add_instance_private, "g_type_add_instance_private");
  link(g_type_add_interface_check, "g_type_add_interface_check");
  link(g_type_add_interface_dynamic, "g_type_add_interface_dynamic");
  link(g_type_add_interface_static, "g_type_add_interface_static");
  link(g_type_check_class_cast, "g_type_check_class_cast");
  link(g_type_check_class_is_a, "g_type_check_class_is_a");
  link(g_type_check_instance, "g_type_check_instance");
  link(g_type_check_instance_cast, "g_type_check_instance_cast");
  link(g_type_check_instance_is_a, "g_type_check_instance_is_a");
  link(g_type_check_instance_is_fundamentally_a, "g_type_check_instance_is_fundamentally_a");
  link(g_type_check_is_value_type, "g_type_check_is_value_type");
  link(g_type_check_value, "g_type_check_value");
  link(g_type_check_value_holds, "g_type_check_value_holds");
  link(g_type_children, "g_type_children");
  link(g_type_create_instance, "g_type_create_instance");
  link(g_type_default_interface_peek, "g_type_default_interface_peek");
  link(g_type_default_interface_ref, "g_type_default_interface_ref");
  link(g_type_default_interface_unref, "g_type_default_interface_unref");
  link(g_type_depth, "g_type_depth");
  link(g_type_ensure, "g_type_ensure");
  link(g_type_free_instance, "g_type_free_instance");
  link(g_type_from_name, "g_type_from_name");
  link(g_type_fundamental, "g_type_fundamental");
  link(g_type_fundamental_next, "g_type_fundamental_next");
  link(g_type_get_instance_count, "g_type_get_instance_count");
  link(g_type_get_plugin, "g_type_get_plugin");
  link(g_type_get_qdata, "g_type_get_qdata");
  link(g_type_get_type_registration_serial, "g_type_get_type_registration_serial");
  link(g_type_init, "g_type_init");
  link(g_type_init_with_debug_flags, "g_type_init_with_debug_flags");
  link(g_type_interfaces, "g_type_interfaces");
  link(g_type_is_a, "g_type_is_a");
  link(g_type_name, "g_type_name");
  link(g_type_name_from_class, "g_type_name_from_class");
  link(g_type_name_from_instance, "g_type_name_from_instance");
  link(g_type_next_base, "g_type_next_base");
  link(g_type_parent, "g_type_parent");
  link(g_type_qname, "g_type_qname");
  link(g_type_query, "g_type_query");
  link(g_type_register_dynamic, "g_type_register_dynamic");
  link(g_type_register_fundamental, "g_type_register_fundamental");
  link(g_type_register_static, "g_type_register_static");
  link(g_type_register_static_simple, "g_type_register_static_simple");
  link(g_type_remove_class_cache_func, "g_type_remove_class_cache_func");
  link(g_type_remove_interface_check, "g_type_remove_interface_check");
  link(g_type_set_qdata, "g_type_set_qdata");
  link(g_type_test_flags, "g_type_test_flags");
  link(g_variant_get_gtype, "g_variant_get_gtype");

  // InitiallyUnowned
  link(g_initially_unowned_get_type, "g_initially_unowned_get_type");

  // ObjectClass
  link(g_object_class_find_property, "g_object_class_find_property");
  link(g_object_class_install_properties, "g_object_class_install_properties");
  link(g_object_class_install_property, "g_object_class_install_property");
  link(g_object_class_list_properties, "g_object_class_list_properties");
  link(g_object_class_override_property, "g_object_class_override_property");

  // ObjectG
  link(g_object_get_type, "g_object_get_type");
  link(g_object_new, "g_object_new");
  link(g_object_new_valist, "g_object_new_valist");
  link(g_object_new_with_properties, "g_object_new_with_properties");
  link(g_object_newv, "g_object_newv");
  link(g_object_compat_control, "g_object_compat_control");
  link(g_object_interface_find_property, "g_object_interface_find_property");
  link(g_object_interface_install_property, "g_object_interface_install_property");
  link(g_object_interface_list_properties, "g_object_interface_list_properties");
  link(g_object_add_toggle_ref, "g_object_add_toggle_ref");
  link(g_object_add_weak_pointer, "g_object_add_weak_pointer");
  link(g_object_bind_property, "g_object_bind_property");
  link(g_object_bind_property_full, "g_object_bind_property_full");
  link(g_object_bind_property_with_closures, "g_object_bind_property_with_closures");
  link(g_object_connect, "g_object_connect");
  link(g_object_disconnect, "g_object_disconnect");
  link(g_object_dup_data, "g_object_dup_data");
  link(g_object_dup_qdata, "g_object_dup_qdata");
  link(g_object_force_floating, "g_object_force_floating");
  link(g_object_freeze_notify, "g_object_freeze_notify");
  link(g_object_get, "g_object_get");
  link(g_object_get_data, "g_object_get_data");
  link(g_object_get_property, "g_object_get_property");
  link(g_object_get_qdata, "g_object_get_qdata");
  link(g_object_get_valist, "g_object_get_valist");
  link(g_object_getv, "g_object_getv");
  link(g_object_is_floating, "g_object_is_floating");
  link(g_object_notify, "g_object_notify");
  link(g_object_notify_by_pspec, "g_object_notify_by_pspec");
  link(g_object_ref, "g_object_ref");
  link(g_object_ref_sink, "g_object_ref_sink");
  link(g_object_remove_toggle_ref, "g_object_remove_toggle_ref");
  link(g_object_remove_weak_pointer, "g_object_remove_weak_pointer");
  link(g_object_replace_data, "g_object_replace_data");
  link(g_object_replace_qdata, "g_object_replace_qdata");
  link(g_object_run_dispose, "g_object_run_dispose");
  link(g_object_set, "g_object_set");
  link(g_object_set_data, "g_object_set_data");
  link(g_object_set_data_full, "g_object_set_data_full");
  link(g_object_set_property, "g_object_set_property");
  link(g_object_set_qdata, "g_object_set_qdata");
  link(g_object_set_qdata_full, "g_object_set_qdata_full");
  link(g_object_set_valist, "g_object_set_valist");
  link(g_object_setv, "g_object_setv");
  link(g_object_steal_data, "g_object_steal_data");
  link(g_object_steal_qdata, "g_object_steal_qdata");
  link(g_object_take_ref, "g_object_take_ref");
  link(g_object_thaw_notify, "g_object_thaw_notify");
  link(g_object_unref, "g_object_unref");
  link(g_object_watch_closure, "g_object_watch_closure");
  link(g_object_weak_ref, "g_object_weak_ref");
  link(g_object_weak_unref, "g_object_weak_unref");

  // ParamSpec
  link(g_param_spec_internal, "g_param_spec_internal");
  link(g_param_spec_is_valid_name, "g_param_spec_is_valid_name");
  link(g_param_spec_get_blurb, "g_param_spec_get_blurb");
  link(g_param_spec_get_default_value, "g_param_spec_get_default_value");
  link(g_param_spec_get_name, "g_param_spec_get_name");
  link(g_param_spec_get_name_quark, "g_param_spec_get_name_quark");
  link(g_param_spec_get_nick, "g_param_spec_get_nick");
  link(g_param_spec_get_qdata, "g_param_spec_get_qdata");
  link(g_param_spec_get_redirect_target, "g_param_spec_get_redirect_target");
  link(g_param_spec_ref, "g_param_spec_ref");
  link(g_param_spec_ref_sink, "g_param_spec_ref_sink");
  link(g_param_spec_set_qdata, "g_param_spec_set_qdata");
  link(g_param_spec_set_qdata_full, "g_param_spec_set_qdata_full");
  link(g_param_spec_sink, "g_param_spec_sink");
  link(g_param_spec_steal_qdata, "g_param_spec_steal_qdata");
  link(g_param_spec_unref, "g_param_spec_unref");

  // ParamSpecPool
  link(g_param_spec_pool_free, "g_param_spec_pool_free");
  link(g_param_spec_pool_insert, "g_param_spec_pool_insert");
  link(g_param_spec_pool_list, "g_param_spec_pool_list");
  link(g_param_spec_pool_list_owned, "g_param_spec_pool_list_owned");
  link(g_param_spec_pool_lookup, "g_param_spec_pool_lookup");
  link(g_param_spec_pool_remove, "g_param_spec_pool_remove");
  link(g_param_spec_pool_new, "g_param_spec_pool_new");

  // SignalGroup
  link(g_signal_group_get_type, "g_signal_group_get_type");
  link(g_signal_group_new, "g_signal_group_new");
  link(g_signal_group_block, "g_signal_group_block");
  link(g_signal_group_connect, "g_signal_group_connect");
  link(g_signal_group_connect_after, "g_signal_group_connect_after");
  link(g_signal_group_connect_closure, "g_signal_group_connect_closure");
  link(g_signal_group_connect_data, "g_signal_group_connect_data");
  link(g_signal_group_connect_object, "g_signal_group_connect_object");
  link(g_signal_group_connect_swapped, "g_signal_group_connect_swapped");
  link(g_signal_group_dup_target, "g_signal_group_dup_target");
  link(g_signal_group_set_target, "g_signal_group_set_target");
  link(g_signal_group_unblock, "g_signal_group_unblock");

  // TypeClass
  link(g_type_class_add_private, "g_type_class_add_private");
  link(g_type_class_get_instance_private_offset, "g_type_class_get_instance_private_offset");
  link(g_type_class_get_private, "g_type_class_get_private");
  link(g_type_class_peek_parent, "g_type_class_peek_parent");
  link(g_type_class_unref, "g_type_class_unref");
  link(g_type_class_unref_uncached, "g_type_class_unref_uncached");
  link(g_type_class_adjust_private_offset, "g_type_class_adjust_private_offset");
  link(g_type_class_peek, "g_type_class_peek");
  link(g_type_class_peek_static, "g_type_class_peek_static");
  link(g_type_class_ref, "g_type_class_ref");

  // TypeInstance
  link(g_type_instance_get_private, "g_type_instance_get_private");

  // TypeInterface
  link(g_type_interface_peek_parent, "g_type_interface_peek_parent");
  link(g_type_interface_add_prerequisite, "g_type_interface_add_prerequisite");
  link(g_type_interface_get_plugin, "g_type_interface_get_plugin");
  link(g_type_interface_instantiatable_prerequisite, "g_type_interface_instantiatable_prerequisite");
  link(g_type_interface_peek, "g_type_interface_peek");
  link(g_type_interface_prerequisites, "g_type_interface_prerequisites");

  // TypeModule
  link(g_type_module_get_type, "g_type_module_get_type");
  link(g_type_module_add_interface, "g_type_module_add_interface");
  link(g_type_module_register_enum, "g_type_module_register_enum");
  link(g_type_module_register_flags, "g_type_module_register_flags");
  link(g_type_module_register_type, "g_type_module_register_type");
  link(g_type_module_set_name, "g_type_module_set_name");
  link(g_type_module_unuse, "g_type_module_unuse");
  link(g_type_module_use, "g_type_module_use");

  // TypePlugin
  link(g_type_plugin_get_type, "g_type_plugin_get_type");
  link(g_type_plugin_complete_interface_info, "g_type_plugin_complete_interface_info");
  link(g_type_plugin_complete_type_info, "g_type_plugin_complete_type_info");
  link(g_type_plugin_unuse, "g_type_plugin_unuse");
  link(g_type_plugin_use, "g_type_plugin_use");

  // TypeValueTable
  link(g_type_value_table_peek, "g_type_value_table_peek");

  // Value
  link(g_value_get_type, "g_value_get_type");
  link(g_value_copy, "g_value_copy");
  link(g_value_dup_boxed, "g_value_dup_boxed");
  link(g_value_dup_object, "g_value_dup_object");
  link(g_value_dup_param, "g_value_dup_param");
  link(g_value_dup_string, "g_value_dup_string");
  link(g_value_dup_variant, "g_value_dup_variant");
  link(g_value_fits_pointer, "g_value_fits_pointer");
  link(g_value_get_boolean, "g_value_get_boolean");
  link(g_value_get_boxed, "g_value_get_boxed");
  link(g_value_get_char, "g_value_get_char");
  link(g_value_get_double, "g_value_get_double");
  link(g_value_get_enum, "g_value_get_enum");
  link(g_value_get_flags, "g_value_get_flags");
  link(g_value_get_float, "g_value_get_float");
  link(g_value_get_gtype, "g_value_get_gtype");
  link(g_value_get_int, "g_value_get_int");
  link(g_value_get_int64, "g_value_get_int64");
  link(g_value_get_long, "g_value_get_long");
  link(g_value_get_object, "g_value_get_object");
  link(g_value_get_param, "g_value_get_param");
  link(g_value_get_pointer, "g_value_get_pointer");
  link(g_value_get_schar, "g_value_get_schar");
  link(g_value_get_string, "g_value_get_string");
  link(g_value_get_uchar, "g_value_get_uchar");
  link(g_value_get_uint, "g_value_get_uint");
  link(g_value_get_uint64, "g_value_get_uint64");
  link(g_value_get_ulong, "g_value_get_ulong");
  link(g_value_get_variant, "g_value_get_variant");
  link(g_value_init, "g_value_init");
  link(g_value_init_from_instance, "g_value_init_from_instance");
  link(g_value_peek_pointer, "g_value_peek_pointer");
  link(g_value_reset, "g_value_reset");
  link(g_value_set_boolean, "g_value_set_boolean");
  link(g_value_set_boxed, "g_value_set_boxed");
  link(g_value_set_boxed_take_ownership, "g_value_set_boxed_take_ownership");
  link(g_value_set_char, "g_value_set_char");
  link(g_value_set_double, "g_value_set_double");
  link(g_value_set_enum, "g_value_set_enum");
  link(g_value_set_flags, "g_value_set_flags");
  link(g_value_set_float, "g_value_set_float");
  link(g_value_set_gtype, "g_value_set_gtype");
  link(g_value_set_instance, "g_value_set_instance");
  link(g_value_set_int, "g_value_set_int");
  link(g_value_set_int64, "g_value_set_int64");
  link(g_value_set_interned_string, "g_value_set_interned_string");
  link(g_value_set_long, "g_value_set_long");
  link(g_value_set_object, "g_value_set_object");
  link(g_value_set_object_take_ownership, "g_value_set_object_take_ownership");
  link(g_value_set_param, "g_value_set_param");
  link(g_value_set_param_take_ownership, "g_value_set_param_take_ownership");
  link(g_value_set_pointer, "g_value_set_pointer");
  link(g_value_set_schar, "g_value_set_schar");
  link(g_value_set_static_boxed, "g_value_set_static_boxed");
  link(g_value_set_static_string, "g_value_set_static_string");
  link(g_value_set_string, "g_value_set_string");
  link(g_value_set_string_take_ownership, "g_value_set_string_take_ownership");
  link(g_value_set_uchar, "g_value_set_uchar");
  link(g_value_set_uint, "g_value_set_uint");
  link(g_value_set_uint64, "g_value_set_uint64");
  link(g_value_set_ulong, "g_value_set_ulong");
  link(g_value_set_variant, "g_value_set_variant");
  link(g_value_steal_string, "g_value_steal_string");
  link(g_value_take_boxed, "g_value_take_boxed");
  link(g_value_take_object, "g_value_take_object");
  link(g_value_take_param, "g_value_take_param");
  link(g_value_take_string, "g_value_take_string");
  link(g_value_take_variant, "g_value_take_variant");
  link(g_value_transform, "g_value_transform");
  link(g_value_unset, "g_value_unset");
  link(g_value_register_transform_func, "g_value_register_transform_func");
  link(g_value_type_compatible, "g_value_type_compatible");
  link(g_value_type_transformable, "g_value_type_transformable");

  // ValueArray
  link(g_value_array_get_type, "g_value_array_get_type");
  link(g_value_array_new, "g_value_array_new");
  link(g_value_array_append, "g_value_array_append");
  link(g_value_array_copy, "g_value_array_copy");
  link(g_value_array_free, "g_value_array_free");
  link(g_value_array_get_nth, "g_value_array_get_nth");
  link(g_value_array_insert, "g_value_array_insert");
  link(g_value_array_prepend, "g_value_array_prepend");
  link(g_value_array_remove, "g_value_array_remove");
  link(g_value_array_sort, "g_value_array_sort");
  link(g_value_array_sort_with_data, "g_value_array_sort_with_data");

  // WeakRef
  link(g_weak_ref_clear, "g_weak_ref_clear");
  link(g_weak_ref_get, "g_weak_ref_get");
  link(g_weak_ref_init, "g_weak_ref_init");
  link(g_weak_ref_set, "g_weak_ref_set");
}

import core.sys.posix.dlfcn : dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
import std.string : fromStringz, toStringz;

private void link(T)(ref T funcPtr, string symbol)
{
  foreach (lib; LIBS)
  {
  if (auto handle = dlopen(cast(char*)toStringz(lib), RTLD_GLOBAL | RTLD_NOW))
  {
  if (auto symPtr = dlsym(handle, cast(char*)toStringz(symbol)))
  {
  funcPtr = cast(T)symPtr;
  return;
  }
  }
  else
  throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  funcPtr = cast(T)&symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
