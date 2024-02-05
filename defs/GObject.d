//!repo GObject-2.0

//!del union[_Value__data__union]

//!set record[InitiallyUnownedClass][opaque] 1
//!set record[ObjectClass][opaque] 1
//!set record[Value][opaque] 1
//!set record[WeakRef][opaque] 1

// Object conflicts with the base D Object type, rename to ObjectG
//!set class[Object][name] ObjectG

// Set ref/unref of ParamSpec
//!set class[ParamSpec][glib:ref-func] g_param_spec_ref
//!set class[ParamSpec][glib:unref-func] g_param_spec_unref
//!del class[ParamSpec][glib:get-type]
