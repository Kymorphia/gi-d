//!repo GObject-2.0

//!del union[_Value__data__union]

//!set record[InitiallyUnownedClass][opaque] 1
//!set record[ObjectClass][opaque] 1
//!set record[Value][opaque] 1
//!set record[WeakRef][opaque] 1

// Object conflicts with the base D Object type, rename to ObjectG
//!set class[Object][name] ObjectG
