//# Dlang reserved words
//!reserved abstract
//!reserved alias
//!reserved align
//!reserved asm
//!reserved assert
//!reserved auto
//!reserved body
//!reserved bool
//!reserved break
//!reserved byte
//!reserved case
//!reserved cast
//!reserved catch
//!reserved cdouble
//!reserved cent
//!reserved cfloat
//!reserved char
//!reserved class
//!reserved const
//!reserved continue
//!reserved creal
//!reserved dchar
//!reserved debug
//!reserved default
//!reserved delegate
//!reserved delete
//!reserved deprecated
//!reserved do
//!reserved double
//!reserved else
//!reserved enum
//!reserved export
//!reserved extern
//!reserved false
//!reserved final
//!reserved finally
//!reserved float
//!reserved for
//!reserved foreach
//!reserved foreach_reverse
//!reserved function
//!reserved goto
//!reserved idouble
//!reserved if
//!reserved ifloat
//!reserved immutable
//!reserved import
//!reserved in
//!reserved inout
//!reserved int
//!reserved interface
//!reserved invariant
//!reserved ireal
//!reserved is
//!reserved lazy
//!reserved long
//!reserved macro
//!reserved mixin
//!reserved module
//!reserved new
//!reserved nothrow
//!reserved null
//!reserved out
//!reserved override
//!reserved package
//!reserved pragma
//!reserved private
//!reserved protected
//!reserved public
//!reserved pure
//!reserved real
//!reserved ref
//!reserved return
//!reserved scope
//!reserved shared
//!reserved short
//!reserved static
//!reserved struct
//!reserved super
//!reserved switch
//!reserved synchronized
//!reserved template
//!reserved this
//!reserved throw
//!reserved true
//!reserved try
//!reserved typedef
//!reserved typeid
//!reserved typeof
//!reserved ubyte
//!reserved ucent
//!reserved uint
//!reserved ulong
//!reserved union
//!reserved unittest
//!reserved ushort
//!reserved version
//!reserved void
//!reserved volatile
//!reserved wchar
//!reserved while
//!reserved with

//# Global type substitutions
//!subtype gboolean bool
//!subtype filename string
//!subtype gchar char
//!subtype gconstpointer const(void)*
//!subtype gdouble double
//!subtype gfloat float
//!subtype gint int
//!subtype gint16 short
//!subtype gint32 int
//!subtype gint64 long
//!subtype gint8 byte
//!subtype goffset long
//!subtype gpointer void*
//!subtype grefcount int
//!subtype gshort short
//!subtype gsize size_t
//!subtype gssize ptrdiff_t
//!subtype guchar ubyte
//!subtype guint uint
//!subtype guint16 ushort
//!subtype guint32 uint
//!subtype guint64 ulong
//!subtype guint8 ubyte
//!subtype guintptr size_t
//!subtype gunichar dchar
//!subtype gunichar2 ushort
//!subtype gushort ushort
//!subtype none void
//!subtype "unsigned int" uint
//!subtype utf8 string
//!subtype va_list void*

//# FIXME - Need to use int/uint on Windows
//!subtype glong long
//!subtype gulong ulong

//# Global XML patches

//# Generally free(), ref(), and unref() functions/methods aren't desirable
//!set *.method[free][introspectable] 0
//!set *.method[ref][introspectable] 0
//!set *.method[unref][introspectable] 0
