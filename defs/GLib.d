//!repo GLib-2.0

// Don't treat ByteArray as an actual array, treat it as an opaque type, as it should be.
//!set *.array[GLib.ByteArray] '<type name="ByteArray" c:type="GByteArray*"/>'

// Set ByteArray functions to be methods
//!rename record[ByteArray].*function method

// Change array parameter to be an instance-parameter
//!rename record[ByteArray].*method.parameters.parameter[array] instance-parameter

// Change new methods to constructors
//!rename record[ByteArray].method[*new*] constructor

// Several ByteArray methods are erroneously marked introspectable="0"
//!set record[ByteArray].method[append][introspectable] 1
//!set record[ByteArray].method[prepend][introspectable] 1
//!set record[ByteArray].method[remove_index][introspectable] 1
//!set record[ByteArray].method[remove_index_fast][introspectable] 1
//!set record[ByteArray].method[remove_range][introspectable] 1
//!set record[ByteArray].method[set_size][introspectable] 1
//!set record[ByteArray].method[sort][introspectable] 1

// Disable Data list type (not useful in bindings)
//!set record[Data][disable] 1

// Disable datalist functions
//!set *function[datalist_*][disable] 1

// Remove problematic type
//!del union[DoubleIEEE754]

// Error conflicts with the base D Error type, rename to ErrorG
//!subtype Error ErrorG

// Remove problematic type
//!del union[FloatIEEE754]

// Change IConv from a record to a void* alias
//!del record[IConv]
//!add repository.namespace '<alias name="IConv" c:type="GIConv"><type name="void*" c:type="void*"/></alias>'

// IOChannel should be opaque
//!set record[IOChannel][opaque] 1

//# FIXME - This contains a union which isn't currently supported
//!set record[VariantDict][opaque] 1

// These string arrays should have zero-terminated set
//!set function[environ_setenv].return-value.array[][zero-terminated] 1
//!set function[environ_setenv].parameters.parameter[envp].array[][zero-terminated] 1
//!set record[Regex].method[split].return-value.array[][zero-terminated] 1
//!set record[Regex].method[split_full].return-value.array[][zero-terminated] 1
//!set record[Regex].function[split_simple].return-value.array[][zero-terminated] 1

// Set Scanner free function
//!set record[Scanner][free-function] g_scanner_destroy

// Change Variant to a class, set to glib:fundamental, and add ref and unref functions
//!rename record[Variant] class
//!set class[Variant][glib:fundamental] 1
//!set class[Variant][glib:ref-func] g_variant_ref
//!set class[Variant][glib:unref-func] g_variant_unref

// VariantBuilder should be opaque
//!set record[VariantBuilder][opaque] 1
