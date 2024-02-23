//!repo GObject-2.0

// FIXME - Temporarily disable functions requiring GValue definition
//!set record[Closure].method[invoke][disable] 1
//!set class[Object].method[getv][disable] 1

//# Disable binding of unuseful and problematic structures
//!set record[TypePluginClass][disable] 1

//# Rename Object and TypeInfo which conflict with the base D Object type
//!subtype GObject ObjectC
//!subtype Object ObjectG
//!subtype TypeInfo TypeInfoG

//!set class[InitiallyUnowned][opaque] 1

//!del union[_Value__data__union]

//!set record[InitiallyUnownedClass][opaque] 1
//!set record[ObjectClass][opaque] 1
//!set record[Value][opaque] 1
//!set record[WeakRef][opaque] 1

//# Delete fields from some structures which can just be treated opaque
//!del *class[ParamSpec*].*field
//!del record[Parameter].*field
//!del record[TypeModuleClass].*field

//# Set ref/unref of ParamSpec
//!set class[ParamSpec][glib:ref-func] g_param_spec_ref
//!set class[ParamSpec][glib:unref-func] g_param_spec_unref
//!del class[ParamSpec][glib:get-type]

//# Replace gpointer C types to actual type
//!set record[TypeClass].method[peek_parent].return-value.type[][c:type] GTypeClass*
//!set record[TypeClass].function[peek].return-value.type[][c:type] GTypeClass*
//!set record[TypeClass].function[peek_static].return-value.type[][c:type] GTypeClass*
//!set record[TypeClass].function[ref].return-value.type[][c:type] GTypeClass*
//!set record[TypeInterface].method[peek_parent].return-value.type[][c:type] GTypeInterface*
//!set record[TypeInterface].function[peek].return-value.type[][c:type] GTypeInterface*
//!set function[type_default_interface_peek].return-value.type[][c:type] GTypeInterface*
//!set function[type_default_interface_ref].return-value.type[][c:type] GTypeInterface*

//# Not introspectable, but could be implemented manually
//!set function[signal_chain_from_overridden][introspectable] 0
//!set function[signal_emitv][introspectable] 0

//!set function[clear_signal_handler].parameters.parameter[handler_id_ptr][direction] inout
//!set record[TypeClass].function[adjust_private_offset].parameters.parameter[private_size_or_offset][direction] inout

//# Add missing free functions
//!set record[TypeClass][free-function] g_type_class_unref
