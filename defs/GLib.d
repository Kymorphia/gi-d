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

// Remove some problematic types which aren't needed
//!del union[DoubleIEEE754]
//!del union[FloatIEEE754]
//!del record[TestLogMsg]

// Set some structures to opaque as they should be
//!set record[IOChannel][opaque] 1
//!set record[SourceCallbackFuncs][opaque] 1
//!set record[SourceFuncs][opaque] 1
//!set record[VariantBuilder][opaque] 1
//!set record[VariantDict][opaque] 1

// These string arrays should have zero-terminated set
//!set function[environ_setenv].return-value.array[][zero-terminated] 1
//!set function[environ_setenv].parameters.parameter[envp].array[][zero-terminated] 1

// Has "long double" type which seems problematic
//!del function[assertion_message_cmpnum]
