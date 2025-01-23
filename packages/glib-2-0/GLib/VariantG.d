module GLib.VariantG;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.VariantType;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;


import GLib.VariantBuilder;
import GLib.VariantType;

import std.conv : to;
import std.traits : isSomeString;
import std.typecons : isTuple, Tuple;
import std.variant : Variant;

/**
 * `GVariant` is a variant datatype; it can contain one or more values
 * along with information about the type of the values.
 * A `GVariant` may contain simple types, like an integer, or a boolean value;
 * or complex types, like an array of two strings, or a dictionary of key
 * value pairs. A `GVariant` is also immutable: once it’s been created neither
 * its type nor its content can be modified further.
 * `GVariant` is useful whenever data needs to be serialized, for example when
 * sending method parameters in D-Bus, or when saving settings using
 * [`GSettings`](../gio/class.Settings.html).
 * When creating a new `GVariant`, you pass the data you want to store in it
 * along with a string representing the type of data you wish to pass to it.
 * For instance, if you want to create a `GVariant` holding an integer value you
 * can use:
 * ```c
 * GVariant *v \= g_variant_new $(LPAREN)"u", 40$(RPAREN);
 * ```
 * The string `u` in the first argument tells `GVariant` that the data passed to
 * the constructor $(LPAREN)`40`$(RPAREN) is going to be an unsigned integer.
 * More advanced examples of `GVariant` in use can be found in documentation for
 * [`GVariant` format strings](gvariant-format-strings.html#pointers).
 * The range of possible values is determined by the type.
 * The type system used by `GVariant` is [GLib.VariantType].
 * `GVariant` instances always have a type and a value $(LPAREN)which are given
 * at construction time$(RPAREN).  The type and value of a `GVariant` instance
 * can never change other than by the `GVariant` itself being
 * destroyed.  A `GVariant` cannot contain a pointer.
 * `GVariant` is reference counted using [GLib.VariantG.ref_] and
 * [GLib.VariantG.unref].  `GVariant` also has floating reference counts —
 * see [GLib.VariantG.refSink].
 * `GVariant` is completely threadsafe.  A `GVariant` instance can be
 * concurrently accessed in any way from any number of threads without
 * problems.
 * `GVariant` is heavily optimised for dealing with data in serialized
 * form.  It works particularly well with data located in memory-mapped
 * files.  It can perform nearly all deserialization operations in a
 * small constant time, usually touching only a single memory page.
 * Serialized `GVariant` data can also be sent over the network.
 * `GVariant` is largely compatible with D-Bus.  Almost all types of
 * `GVariant` instances can be sent over D-Bus.  See [GLib.VariantType] for
 * exceptions.  $(LPAREN)However, `GVariant`’s serialization format is not the same
 * as the serialization format of a D-Bus message body: use
 * [GDBusMessage](../gio/class.DBusMessage.html), in the GIO library, for those.$(RPAREN)
 * For space-efficiency, the `GVariant` serialization format does not
 * automatically include the variant’s length, type or endianness,
 * which must either be implied from context $(LPAREN)such as knowledge that a
 * particular file format always contains a little-endian
 * `G_VARIANT_TYPE_VARIANT` which occupies the whole length of the file$(RPAREN)
 * or supplied out-of-band $(LPAREN)for instance, a length, type and/or endianness
 * indicator could be placed at the beginning of a file, network message
 * or network stream$(RPAREN).
 * A `GVariant`’s size is limited mainly by any lower level operating
 * system constraints, such as the number of bits in `gsize`.  For
 * example, it is reasonable to have a 2GB file mapped into memory
 * with [GLib.MappedFile], and call [GLib.VariantG.newFromData] on
 * it.
 * For convenience to C programmers, `GVariant` features powerful
 * varargs-based value construction and destruction.  This feature is
 * designed to be embedded in other libraries.
 * There is a Python-inspired text language for describing `GVariant`
 * values.  `GVariant` includes a printer for this language and a parser
 * with type inferencing.
 * ## Memory Use
 * `GVariant` tries to be quite efficient with respect to memory use.
 * This section gives a rough idea of how much memory is used by the
 * current implementation.  The information here is subject to change
 * in the future.
 * The memory allocated by `GVariant` can be grouped into 4 broad
 * purposes: memory for serialized data, memory for the type
 * information cache, buffer management memory and memory for the
 * `GVariant` structure itself.
 * ## Serialized Data Memory
 * This is the memory that is used for storing `GVariant` data in
 * serialized form.  This is what would be sent over the network or
 * what would end up on disk, not counting any indicator of the
 * endianness, or of the length or type of the top-level variant.
 * The amount of memory required to store a boolean is 1 byte. 16,
 * 32 and 64 bit integers and double precision floating point numbers
 * use their ‘natural’ size.  Strings $(LPAREN)including object path and
 * signature strings$(RPAREN) are stored with a nul terminator, and as such
 * use the length of the string plus 1 byte.
 * ‘Maybe’ types use no space at all to represent the null value and
 * use the same amount of space $(LPAREN)sometimes plus one byte$(RPAREN) as the
 * equivalent non-maybe-typed value to represent the non-null case.
 * Arrays use the amount of space required to store each of their
 * members, concatenated.  Additionally, if the items stored in an
 * array are not of a fixed-size $(LPAREN)ie: strings, other arrays, etc$(RPAREN)
 * then an additional framing offset is stored for each item.  The
 * size of this offset is either 1, 2 or 4 bytes depending on the
 * overall size of the container.  Additionally, extra padding bytes
 * are added as required for alignment of child values.
 * Tuples $(LPAREN)including dictionary entries$(RPAREN) use the amount of space
 * required to store each of their members, concatenated, plus one
 * framing offset $(LPAREN)as per arrays$(RPAREN) for each non-fixed-sized item in
 * the tuple, except for the last one.  Additionally, extra padding
 * bytes are added as required for alignment of child values.
 * Variants use the same amount of space as the item inside of the
 * variant, plus 1 byte, plus the length of the type string for the
 * item inside the variant.
 * As an example, consider a dictionary mapping strings to variants.
 * In the case that the dictionary is empty, 0 bytes are required for
 * the serialization.
 * If we add an item ‘width’ that maps to the int32 value of 500 then
 * we will use 4 bytes to store the int32 $(LPAREN)so 6 for the variant
 * containing it$(RPAREN) and 6 bytes for the string.  The variant must be
 * aligned to 8 after the 6 bytes of the string, so that’s 2 extra
 * bytes.  6 $(LPAREN)string$(RPAREN) + 2 $(LPAREN)padding$(RPAREN) + 6 $(LPAREN)variant$(RPAREN) is 14 bytes used
 * for the dictionary entry.  An additional 1 byte is added to the
 * array as a framing offset making a total of 15 bytes.
 * If we add another entry, ‘title’ that maps to a nullable string
 * that happens to have a value of null, then we use 0 bytes for the
 * null value $(LPAREN)and 3 bytes for the variant to contain it along with
 * its type string$(RPAREN) plus 6 bytes for the string.  Again, we need 2
 * padding bytes.  That makes a total of 6 + 2 + 3 \= 11 bytes.
 * We now require extra padding between the two items in the array.
 * After the 14 bytes of the first item, that’s 2 bytes required.
 * We now require 2 framing offsets for an extra two
 * bytes. 14 + 2 + 11 + 2 \= 29 bytes to encode the entire two-item
 * dictionary.
 * ## Type Information Cache
 * For each `GVariant` type that currently exists in the program a type
 * information structure is kept in the type information cache.  The
 * type information structure is required for rapid deserialization.
 * Continuing with the above example, if a `GVariant` exists with the
 * type `a{sv}` then a type information struct will exist for
 * `a{sv}`, `{sv}`, `s`, and `v`.  Multiple uses of the same type
 * will share the same type information.  Additionally, all
 * single-digit types are stored in read-only static memory and do
 * not contribute to the writable memory footprint of a program using
 * `GVariant`.
 * Aside from the type information structures stored in read-only
 * memory, there are two forms of type information.  One is used for
 * container types where there is a single element type: arrays and
 * maybe types.  The other is used for container types where there
 * are multiple element types: tuples and dictionary entries.
 * Array type info structures are `6 * sizeof $(LPAREN)void *$(RPAREN)`, plus the
 * memory required to store the type string itself.  This means that
 * on 32-bit systems, the cache entry for `a{sv}` would require 30
 * bytes of memory $(LPAREN)plus allocation overhead$(RPAREN).
 * Tuple type info structures are `6 * sizeof $(LPAREN)void *$(RPAREN)`, plus `4 *
 * sizeof $(LPAREN)void *$(RPAREN)` for each item in the tuple, plus the memory
 * required to store the type string itself.  A 2-item tuple, for
 * example, would have a type information structure that consumed
 * writable memory in the size of `14 * sizeof $(LPAREN)void *$(RPAREN)` $(LPAREN)plus type
 * string$(RPAREN)  This means that on 32-bit systems, the cache entry for
 * `{sv}` would require 61 bytes of memory $(LPAREN)plus allocation overhead$(RPAREN).
 * This means that in total, for our `a{sv}` example, 91 bytes of
 * type information would be allocated.
 * The type information cache, additionally, uses a [GLib.HashTable] to
 * store and look up the cached items and stores a pointer to this
 * hash table in static storage.  The hash table is freed when there
 * are zero items in the type cache.
 * Although these sizes may seem large it is important to remember
 * that a program will probably only have a very small number of
 * different types of values in it and that only one type information
 * structure is required for many different values of the same type.
 * ## Buffer Management Memory
 * `GVariant` uses an internal buffer management structure to deal
 * with the various different possible sources of serialized data
 * that it uses.  The buffer is responsible for ensuring that the
 * correct call is made when the data is no longer in use by
 * `GVariant`.  This may involve a func@GLib.free or
 * even [GLib.MappedFile.unref].
 * One buffer management structure is used for each chunk of
 * serialized data.  The size of the buffer management structure
 * is `4 * $(LPAREN)void *$(RPAREN)`.  On 32-bit systems, that’s 16 bytes.
 * ## GVariant structure
 * The size of a `GVariant` structure is `6 * $(LPAREN)void *$(RPAREN)`.  On 32-bit
 * systems, that’s 24 bytes.
 * `GVariant` structures only exist if they are explicitly created
 * with API calls.  For example, if a `GVariant` is constructed out of
 * serialized data for the example given above $(LPAREN)with the dictionary$(RPAREN)
 * then although there are 9 individual values that comprise the
 * entire dictionary $(LPAREN)two keys, two values, two variants containing
 * the values, two dictionary entries, plus the dictionary itself$(RPAREN),
 * only 1 `GVariant` instance exists — the one referring to the
 * dictionary.
 * If calls are made to start accessing the other values then
 * `GVariant` instances will exist for those values only for as long
 * as they are in use $(LPAREN)ie: until you call [GLib.VariantG.unref]$(RPAREN).  The
 * type information is shared.  The serialized data and the buffer
 * management structure for that serialized data is shared by the
 * child.
 * ## Summary
 * To put the entire example together, for our dictionary mapping
 * strings to variants $(LPAREN)with two entries, as given above$(RPAREN), we are
 * using 91 bytes of memory for type information, 29 bytes of memory
 * for the serialized data, 16 bytes for buffer management and 24
 * bytes for the `GVariant` instance, or a total of 160 bytes, plus
 * allocation overhead.  If we were to use [GLib.VariantG.getChildValue]
 * to access the two dictionary entries, we would use an additional 48
 * bytes.  If we were to have other dictionaries of the same type, we
 * would use more memory for the serialized data and buffer
 * management for those dictionaries, but the type information would
 * be shared.
 */
class VariantG
{
  VariantC* cInstancePtr;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.VariantG");

    cInstancePtr = cast(VariantC*)ptr;

    if (!ownedRef)
      g_variant_ref(cInstancePtr);
  }

  ~this()
  {
    g_variant_unref(cInstancePtr);
  }


  void* cPtr(bool addRef = false)
  {
    if (addRef)
      g_variant_ref(cInstancePtr);

    return cInstancePtr;
  }

  override bool opEquals(Object other)
  {
    if (auto otherVariant = cast(VariantG)other)
      return equal(otherVariant);
    else
      return super.opEquals(other);
  }

  override int opCmp(Object other)
  {
    if (auto otherVariant = cast(VariantG)other)
      return compare(otherVariant);
    else
      return super.opCmp(other);
  }

  override string toString()
  {
    return print(true);
  }

  /**
   * Template to create a new VariantG from a single D value.
   * Params:
   *   T = The D type to create the variant from
   *   val = The value to assign
   */
  static VariantG create(T)(T val)
  {
    static if (is(T == bool))
      return newBoolean(val);
    else static if (is(T == byte) || is(T == ubyte))
      return newByte(val);
    else static if (is(T == short))
      return newInt16(val);
    else static if (is(T == ushort))
      return newUint16(val);
    else static if (is(T == int))
      return newInt32(val);
    else static if (is(T == uint))
      return newUint32(val);
    else static if (is(T == long))
      return newInt64(val);
    else static if (is(T == ulong))
      return newUint64(val);
    else static if (is(T == float) || is(T == double))
      return newDouble(val);
    else static if (isSomeString!T)
      return newString(val.to!string);
    else static if (is(T : E[], E))
    {
      VariantBuilder builder = new VariantBuilder(VariantType.create!T);

      foreach (item; val)
        builder.addValue(create(item));

      return builder.end;
    }
    else static if (is(T : V[K], V, K)) // Dictionary
    {
      VariantBuilder builder = new VariantBuilder(VariantType.create!T);

      foreach (k, v; val)
        builder.addValue(newDictEntry(create(k), create(v)));

      return builder.end;
    }
    else static if (is(T == VariantG)) // A variant (copy it)
      return VariantG.newVariant(val);
    else static if (is(T == Variant)) // std.variant.Variant (only basic types supported currently)
    {
      if (val.type is typeid(bool))
        return create(val.get!bool);
      else if (val.type is typeid(byte) || val.type is typeid(ubyte))
        return create(val.coerce!byte);
      else if (val.type is typeid(short))
        return create(val.get!short);
      else if (val.type is typeid(ushort))
        return create(val.get!ushort);
      else if (val.type is typeid(int))
        return create(val.get!int);
      else if (val.type is typeid(uint))
        return create(val.get!uint);
      else if (val.type is typeid(long))
        return create(val.get!long);
      else if (val.type is typeid(ulong))
        return create(val.get!ulong);
      else if (val.type is typeid(float) || val.type is typeid(double))
        return create(val.coerce!double);
      else if (val.type is typeid(string) || val.type is typeid(wstring) || val.type is typeid(dstring))
        return create(val.coerce!string);
      else
        assert(false, "VariantG.create does not support D Variant type " ~ val.type.to!string);
    }
    else static if (isTuple!T)
      return create(val.expand);
    else
      static assert(false, "Unsupported type for VariantG.create: " ~ T.stringof);
  }

  /**
   * Template to create a new VariantG from multiple D values. The variant is constructed as a Variant tuple container.
   * Params:
   *   T = The D types to create the variant from
   *   vals = The value to assign
   */
  static VariantG create(T...)(T vals)
  if (vals.length > 1)
  {
    VariantBuilder builder = new VariantBuilder(new VariantType("r")); // Build a tuple container variant

    foreach (v; vals)
      builder.addValue(create(v));

    return builder.end;
  }

  /**
   * Template to get a single value from a VariantG
   */
  T get(T)()
  {
    static if (is(T == bool))
      return getBoolean;
    else static if (is(T == byte) || is(T == ubyte))
      return cast(T)getByte;
    else static if (is(T == short))
      return getInt16;
    else static if (is(T == ushort))
      return getUint16;
    else static if (is(T == int))
      return getInt32;
    else static if (is(T == uint))
      return getUint32;
    else static if (is(T == long))
      return getInt64;
    else static if (is(T == ulong))
      return getUint64;
    else static if (is(T == float) || is(T == double))
      return cast(T)getDouble;
    else static if (isSomeString!T)
      return getString.to!T;
    else static if (is(T : E[], E))
    {
      T valArray;
      valArray.length = nChildren;

      foreach (i; 0 .. valArray.length)
        valArray[i] = getChildValue(i).get!E;

      return valArray;
    }
    else static if (is(T : V[K], V, K)) // Dictionary
    {
      T dict;

      foreach (i; 0 .. nChildren)
        dict[getChildValue(i).getChildValue(0).get!K] = getChildValue(i).getChildValue(1).get!V; // VariantG dict entries hold 2 values (key, value)

      return dict;
    }
    else static if (is(T == VariantG)) // A variant (unwrap it)
      return getVariant;
    else static if (is(T == Variant)) // std.variant.Variant (only basic types supported currently)
    {
      if (getType.isBasic)
      {
        switch (getTypeStr[0])
        {
          case 'b':
          return Variant(get!bool);
          case 'y':
          return Variant(get!byte);
          case 'n':
          return Variant(get!short);
          case 'q':
          return Variant(get!ushort);
          case 'i':
          return Variant(get!int);
          case 'u':
          return Variant(get!uint);
          case 'x':
          return Variant(get!long);
          case 't':
          return Variant(get!ulong);
          case 'd':
          return Variant(get!double);
          case 's':
          return Variant(coerce!string);
          default:
          assert(false, "VariantG.create does not support D Variant type " ~ val.type.to!string);
        }
      }
    }
    else static if (isTuple!T)
      return create(val.expand);
    else
      static assert(false, "Unsupported type for VariantG.get: " ~ T.stringof);
  }

  /**
   * Template to get multiple values from a VariantG
   */
  auto get(T...)()
  if (T.length > 1)
  {
    Tuple!T vals;

    foreach (i, E; T)
      vals[i] = getChildValue(i).get!E;

    return vals;
  }

  /**
   * Creates a new #GVariant array from children.
   * child_type must be non-%NULL if n_children is zero.  Otherwise, the
   * child type is determined by inspecting the first element of the
   * children array.  If child_type is non-%NULL then it must be a
   * definite type.
   * The items of the array are taken from the children array.  No entry
   * in the children array may be %NULL.
   * All items in the array must have the same type, which must be the
   * same as child_type, if given.
   * If the children are floating references $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN), the
   * new instance takes ownership of them as if via [GLib.VariantG.refSink].
   * Params:
   *   childType = the element type of the new array
   *   children = an array of
   *     #GVariant pointers, the children
   * Returns: a floating reference to a new #GVariant array
   */
  static VariantG newArray(VariantType childType, VariantG[] children)
  {
    VariantC* _cretval;
    size_t _nChildren;
    if (children)
      _nChildren = cast(size_t)children.length;

    VariantC*[] _tmpchildren;
    foreach (obj; children)
      _tmpchildren ~= obj ? cast(VariantC*)obj.cPtr : null;
    const(VariantC*)* _children = cast(const(VariantC*)*)_tmpchildren.ptr;
    _cretval = g_variant_new_array(childType ? cast(GVariantType*)childType.cPtr(false) : null, _children, _nChildren);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new boolean #GVariant instance -- either %TRUE or %FALSE.
   * Params:
   *   value = a #gboolean value
   * Returns: a floating reference to a new boolean #GVariant instance
   */
  static VariantG newBoolean(bool value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_boolean(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new byte #GVariant instance.
   * Params:
   *   value = a #guint8 value
   * Returns: a floating reference to a new byte #GVariant instance
   */
  static VariantG newByte(ubyte value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_byte(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates an array-of-bytes #GVariant with the contents of string.
   * This function is just like [GLib.VariantG.newString] except that the
   * string need not be valid UTF-8.
   * The nul terminator character at the end of the string is stored in
   * the array.
   * Params:
   *   string_ = a normal
   *     nul-terminated string in no particular encoding
   * Returns: a floating reference to a new bytestring #GVariant instance
   */
  static VariantG newBytestring(string string_)
  {
    VariantC* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_variant_new_bytestring(_string_);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Constructs an array of bytestring #GVariant from the given array of
   * strings.
   * If length is -1 then strv is %NULL-terminated.
   * Params:
   *   strv = an array of strings
   * Returns: a new floating #GVariant instance
   */
  static VariantG newBytestringArray(string[] strv)
  {
    VariantC* _cretval;
    ptrdiff_t _length;
    if (strv)
      _length = cast(ptrdiff_t)strv.length;

    char*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_bytestring_array(_strv, _length);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new dictionary entry #GVariant. key and value must be
   * non-%NULL. key must be a value of a basic type $(LPAREN)ie: not a container$(RPAREN).
   * If the key or value are floating references $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN),
   * the new instance takes ownership of them as if via [GLib.VariantG.refSink].
   * Params:
   *   key = a basic #GVariant, the key
   *   value = a #GVariant, the value
   * Returns: a floating reference to a new dictionary entry #GVariant
   */
  static VariantG newDictEntry(VariantG key, VariantG value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_dict_entry(key ? cast(VariantC*)key.cPtr(false) : null, value ? cast(VariantC*)value.cPtr(false) : null);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new double #GVariant instance.
   * Params:
   *   value = a #gdouble floating point value
   * Returns: a floating reference to a new double #GVariant instance
   */
  static VariantG newDouble(double value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_double(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Constructs a new array #GVariant instance, where the elements are
   * of element_type type.
   * elements must be an array with fixed-sized elements.  Numeric types are
   * fixed-size as are tuples containing only other fixed-sized types.
   * element_size must be the size of a single element in the array.
   * For example, if calling this function for an array of 32-bit integers,
   * you might say sizeof$(LPAREN)gint32$(RPAREN). This value isn't used except for the purpose
   * of a double-check that the form of the serialized data matches the caller's
   * expectation.
   * n_elements must be the length of the elements array.
   * Params:
   *   elementType = the #GVariantType of each element
   *   elements = a pointer to the fixed array of contiguous elements
   *   nElements = the number of elements
   *   elementSize = the size of each element
   * Returns: a floating reference to a new array #GVariant instance
   */
  static VariantG newFixedArray(VariantType elementType, const(void)* elements, size_t nElements, size_t elementSize)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_fixed_array(elementType ? cast(GVariantType*)elementType.cPtr(false) : null, elements, nElements, elementSize);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Constructs a new serialized-mode #GVariant instance.  This is the
   * inner interface for creation of new serialized values that gets
   * called from various functions in gvariant.c.
   * A reference is taken on bytes.
   * The data in bytes must be aligned appropriately for the type being loaded.
   * Otherwise this function will internally create a copy of the memory $(LPAREN)since
   * GLib 2.60$(RPAREN) or $(LPAREN)in older versions$(RPAREN) fail and exit the process.
   * Params:
   *   type = a #GVariantType
   *   bytes = a #GBytes
   *   trusted = if the contents of bytes are trusted
   * Returns: a new #GVariant with a floating reference
   */
  static VariantG newFromBytes(VariantType type, Bytes bytes, bool trusted)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_from_bytes(type ? cast(GVariantType*)type.cPtr(false) : null, bytes ? cast(GBytes*)bytes.cPtr(false) : null, trusted);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new handle #GVariant instance.
   * By convention, handles are indexes into an array of file descriptors
   * that are sent alongside a D-Bus message.  If you're not interacting
   * with D-Bus, you probably don't need them.
   * Params:
   *   value = a #gint32 value
   * Returns: a floating reference to a new handle #GVariant instance
   */
  static VariantG newHandle(int value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_handle(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new int16 #GVariant instance.
   * Params:
   *   value = a #gint16 value
   * Returns: a floating reference to a new int16 #GVariant instance
   */
  static VariantG newInt16(short value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_int16(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new int32 #GVariant instance.
   * Params:
   *   value = a #gint32 value
   * Returns: a floating reference to a new int32 #GVariant instance
   */
  static VariantG newInt32(int value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_int32(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new int64 #GVariant instance.
   * Params:
   *   value = a #gint64 value
   * Returns: a floating reference to a new int64 #GVariant instance
   */
  static VariantG newInt64(long value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_int64(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Depending on if child is %NULL, either wraps child inside of a
   * maybe container or creates a Nothing instance for the given type.
   * At least one of child_type and child must be non-%NULL.
   * If child_type is non-%NULL then it must be a definite type.
   * If they are both non-%NULL then child_type must be the type
   * of child.
   * If child is a floating reference $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN), the new
   * instance takes ownership of child.
   * Params:
   *   childType = the #GVariantType of the child, or %NULL
   *   child = the child value, or %NULL
   * Returns: a floating reference to a new #GVariant maybe instance
   */
  static VariantG newMaybe(VariantType childType, VariantG child)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_maybe(childType ? cast(GVariantType*)childType.cPtr(false) : null, child ? cast(VariantC*)child.cPtr(false) : null);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a D-Bus object path #GVariant with the contents of object_path.
   * object_path must be a valid D-Bus object path.  Use
   * [GLib.VariantG.isObjectPath] if you're not sure.
   * Params:
   *   objectPath = a normal C nul-terminated string
   * Returns: a floating reference to a new object path #GVariant instance
   */
  static VariantG newObjectPath(string objectPath)
  {
    VariantC* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_variant_new_object_path(_objectPath);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Constructs an array of object paths #GVariant from the given array of
   * strings.
   * Each string must be a valid #GVariant object path; see
   * [GLib.VariantG.isObjectPath].
   * If length is -1 then strv is %NULL-terminated.
   * Params:
   *   strv = an array of strings
   * Returns: a new floating #GVariant instance
   */
  static VariantG newObjv(string[] strv)
  {
    VariantC* _cretval;
    ptrdiff_t _length;
    if (strv)
      _length = cast(ptrdiff_t)strv.length;

    const(char)*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_objv(_strv, _length);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a D-Bus type signature #GVariant with the contents of
   * string.  string must be a valid D-Bus type signature.  Use
   * [GLib.VariantG.isSignature] if you're not sure.
   * Params:
   *   signature = a normal C nul-terminated string
   * Returns: a floating reference to a new signature #GVariant instance
   */
  static VariantG newSignature(string signature)
  {
    VariantC* _cretval;
    const(char)* _signature = signature.toCString(false);
    _cretval = g_variant_new_signature(_signature);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a string #GVariant with the contents of string.
   * string must be valid UTF-8, and must not be %NULL. To encode
   * potentially-%NULL strings, use [GLib.VariantG.new_] with `ms` as the
   * [format string][gvariant-format-strings-maybe-types].
   * Params:
   *   string_ = a normal UTF-8 nul-terminated string
   * Returns: a floating reference to a new string #GVariant instance
   */
  static VariantG newString(string string_)
  {
    VariantC* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_variant_new_string(_string_);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Constructs an array of strings #GVariant from the given array of
   * strings.
   * If length is -1 then strv is %NULL-terminated.
   * Params:
   *   strv = an array of strings
   * Returns: a new floating #GVariant instance
   */
  static VariantG newStrv(string[] strv)
  {
    VariantC* _cretval;
    ptrdiff_t _length;
    if (strv)
      _length = cast(ptrdiff_t)strv.length;

    const(char)*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_strv(_strv, _length);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new tuple #GVariant out of the items in children.  The
   * type is determined from the types of children.  No entry in the
   * children array may be %NULL.
   * If n_children is 0 then the unit tuple is constructed.
   * If the children are floating references $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN), the
   * new instance takes ownership of them as if via [GLib.VariantG.refSink].
   * Params:
   *   children = the items to make the tuple out of
   * Returns: a floating reference to a new #GVariant tuple
   */
  static VariantG newTuple(VariantG[] children)
  {
    VariantC* _cretval;
    size_t _nChildren;
    if (children)
      _nChildren = cast(size_t)children.length;

    VariantC*[] _tmpchildren;
    foreach (obj; children)
      _tmpchildren ~= obj ? cast(VariantC*)obj.cPtr : null;
    const(VariantC*)* _children = cast(const(VariantC*)*)_tmpchildren.ptr;
    _cretval = g_variant_new_tuple(_children, _nChildren);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new uint16 #GVariant instance.
   * Params:
   *   value = a #guint16 value
   * Returns: a floating reference to a new uint16 #GVariant instance
   */
  static VariantG newUint16(ushort value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_uint16(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new uint32 #GVariant instance.
   * Params:
   *   value = a #guint32 value
   * Returns: a floating reference to a new uint32 #GVariant instance
   */
  static VariantG newUint32(uint value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_uint32(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new uint64 #GVariant instance.
   * Params:
   *   value = a #guint64 value
   * Returns: a floating reference to a new uint64 #GVariant instance
   */
  static VariantG newUint64(ulong value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_uint64(value);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Boxes value.  The result is a #GVariant instance representing a
   * variant containing the original value.
   * If child is a floating reference $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN), the new
   * instance takes ownership of child.
   * Params:
   *   value = a #GVariant instance
   * Returns: a floating reference to a new variant #GVariant instance
   */
  static VariantG newVariant(VariantG value)
  {
    VariantC* _cretval;
    _cretval = g_variant_new_variant(value ? cast(VariantC*)value.cPtr(false) : null);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Performs a byteswapping operation on the contents of value.  The
   * result is that all multi-byte numeric data contained in value is
   * byteswapped.  That includes 16, 32, and 64bit signed and unsigned
   * integers as well as file handles and double precision floating point
   * values.
   * This function is an identity mapping on any value that does not
   * contain multi-byte numeric data.  That include strings, booleans,
   * bytes and containers containing only these things $(LPAREN)recursively$(RPAREN).
   * While this function can safely handle untrusted, non-normal data, it is
   * recommended to check whether the input is in normal form beforehand, using
   * [GLib.VariantG.isNormalForm], and to reject non-normal inputs if your
   * application can be strict about what inputs it rejects.
   * The returned value is always in normal form and is marked as trusted.
   * A full, not floating, reference is returned.
   * Returns: the byteswapped form of value
   */
  VariantG byteswap()
  {
    VariantC* _cretval;
    _cretval = g_variant_byteswap(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if calling [GLib.VariantG.get] with format_string on value would
   * be valid from a type-compatibility standpoint.  format_string is
   * assumed to be a valid format string $(LPAREN)from a syntactic standpoint$(RPAREN).
   * If copy_only is %TRUE then this function additionally checks that it
   * would be safe to call [GLib.VariantG.unref] on value immediately after
   * the call to [GLib.VariantG.get] without invalidating the result.  This is
   * only possible if deep copies are made $(LPAREN)ie: there are no pointers to
   * the data inside of the soon-to-be-freed #GVariant instance$(RPAREN).  If this
   * check fails then a g_critical$(LPAREN)$(RPAREN) is printed and %FALSE is returned.
   * This function is meant to be used by functions that wish to provide
   * varargs accessors to #GVariant values of uncertain values $(LPAREN)eg:
   * [GLib.VariantG.lookup] or [Gio.MenuModel.getItemAttribute]$(RPAREN).
   * Params:
   *   formatString = a valid #GVariant format string
   *   copyOnly = %TRUE to ensure the format string makes deep copies
   * Returns: %TRUE if format_string is safe to use
   */
  bool checkFormatString(string formatString, bool copyOnly)
  {
    bool _retval;
    const(char)* _formatString = formatString.toCString(false);
    _retval = g_variant_check_format_string(cast(VariantC*)cPtr, _formatString, copyOnly);
    return _retval;
  }

  /**
   * Classifies value according to its top-level type.
   * Returns: the #GVariantClass of value
   */
  VariantClass classify()
  {
    GVariantClass _cretval;
    _cretval = g_variant_classify(cast(VariantC*)cPtr);
    VariantClass _retval = cast(VariantClass)_cretval;
    return _retval;
  }

  /**
   * Compares one and two.
   * The types of one and two are #gconstpointer only to allow use of
   * this function with #GTree, #GPtrArray, etc.  They must each be a
   * #GVariant.
   * Comparison is only defined for basic types $(LPAREN)ie: booleans, numbers,
   * strings$(RPAREN).  For booleans, %FALSE is less than %TRUE.  Numbers are
   * ordered in the usual way.  Strings are in ASCII lexographical order.
   * It is a programmer error to attempt to compare container values or
   * two values that have types that are not exactly equal.  For example,
   * you cannot compare a 32-bit signed integer with a 32-bit unsigned
   * integer.  Also note that this function is not particularly
   * well-behaved when it comes to comparison of doubles; in particular,
   * the handling of incomparable values $(LPAREN)ie: NaN$(RPAREN) is undefined.
   * If you only require an equality comparison, [GLib.VariantG.equal] is more
   * general.
   * Params:
   *   two = a #GVariant instance of the same type
   * Returns: negative value if a < b;
   *   zero if a \= b;
   *   positive value if a > b.
   */
  int compare(VariantG two)
  {
    int _retval;
    _retval = g_variant_compare(cast(VariantC*)cPtr, two ? cast(VariantC*)two.cPtr(false) : null);
    return _retval;
  }

  /**
   * Similar to [GLib.VariantG.getBytestring] except that instead of
   * returning a constant string, the string is duplicated.
   * The return value must be freed using [GLib.Global.gfree].
   * Returns: a newly allocated string
   */
  ubyte[] dupBytestring()
  {
    ubyte* _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_bytestring(cast(VariantC*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Gets the contents of an array of array of bytes #GVariant.  This call
   * makes a deep copy; the return result should be released with
   * [GLib.Global.strfreev].
   * If length is non-%NULL then the number of elements in the result is
   * stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of strings
   */
  string[] dupBytestringArray()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_bytestring_array(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Gets the contents of an array of object paths #GVariant.  This call
   * makes a deep copy; the return result should be released with
   * [GLib.Global.strfreev].
   * If length is non-%NULL then the number of elements in the result
   * is stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of strings
   */
  string[] dupObjv()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_objv(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Similar to [GLib.VariantG.getString] except that instead of returning
   * a constant string, the string is duplicated.
   * The string will always be UTF-8 encoded.
   * The return value must be freed using [GLib.Global.gfree].
   * Params:
   *   length = a pointer to a #gsize, to store the length
   * Returns: a newly allocated string, UTF-8 encoded
   */
  string dupString(out size_t length)
  {
    char* _cretval;
    _cretval = g_variant_dup_string(cast(VariantC*)cPtr, cast(size_t*)&length);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the contents of an array of strings #GVariant.  This call
   * makes a deep copy; the return result should be released with
   * [GLib.Global.strfreev].
   * If length is non-%NULL then the number of elements in the result
   * is stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of strings
   */
  string[] dupStrv()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_strv(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Checks if one and two have the same type and value.
   * The types of one and two are #gconstpointer only to allow use of
   * this function with #GHashTable.  They must each be a #GVariant.
   * Params:
   *   two = a #GVariant instance
   * Returns: %TRUE if one and two are equal
   */
  bool equal(VariantG two)
  {
    bool _retval;
    _retval = g_variant_equal(cast(VariantC*)cPtr, two ? cast(VariantC*)two.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the boolean value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_BOOLEAN.
   * Returns: %TRUE or %FALSE
   */
  bool getBoolean()
  {
    bool _retval;
    _retval = g_variant_get_boolean(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the byte value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_BYTE.
   * Returns: a #guint8
   */
  ubyte getByte()
  {
    ubyte _retval;
    _retval = g_variant_get_byte(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the string value of a #GVariant instance with an
   * array-of-bytes type.  The string has no particular encoding.
   * If the array does not end with a nul terminator character, the empty
   * string is returned.  For this reason, you can always trust that a
   * non-%NULL nul-terminated string will be returned by this function.
   * If the array contains a nul terminator character somewhere other than
   * the last byte then the returned string is the string, up to the first
   * such nul character.
   * [GLib.VariantG.getFixedArray] should be used instead if the array contains
   * arbitrary data that could not be nul-terminated or could contain nul bytes.
   * It is an error to call this function with a value that is not an
   * array of bytes.
   * The return value remains valid as long as value exists.
   * Returns: the constant string
   */
  string getBytestring()
  {
    const(char)* _cretval;
    _cretval = g_variant_get_bytestring(cast(VariantC*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the contents of an array of array of bytes #GVariant.  This call
   * makes a shallow copy; the return result should be released with
   * [GLib.Global.gfree], but the individual strings must not be modified.
   * If length is non-%NULL then the number of elements in the result is
   * stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of constant strings
   */
  string[] getBytestringArray()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_bytestring_array(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Reads a child item out of a container #GVariant instance.  This
   * includes variants, maybes, arrays, tuples and dictionary
   * entries.  It is an error to call this function on any other type of
   * #GVariant.
   * It is an error if index_ is greater than the number of child items
   * in the container.  See [GLib.VariantG.nChildren].
   * The returned value is never floating.  You should free it with
   * [GLib.VariantG.unref] when you're done with it.
   * Note that values borrowed from the returned child are not guaranteed to
   * still be valid after the child is freed even if you still hold a reference
   * to value, if value has not been serialized at the time this function is
   * called. To avoid this, you can serialize value by calling
   * [GLib.VariantG.getData] and optionally ignoring the return value.
   * There may be implementation specific restrictions on deeply nested values,
   * which would result in the unit tuple being returned as the child value,
   * instead of further nested children. #GVariant is guaranteed to handle
   * nesting up to at least 64 levels.
   * This function is O$(LPAREN)1$(RPAREN).
   * Params:
   *   index = the index of the child to fetch
   * Returns: the child at the specified index
   */
  VariantG getChildValue(size_t index)
  {
    VariantC* _cretval;
    _cretval = g_variant_get_child_value(cast(VariantC*)cPtr, index);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a pointer to the serialized form of a #GVariant instance.
   * The returned data may not be in fully-normalised form if read from an
   * untrusted source.  The returned data must not be freed; it remains
   * valid for as long as value exists.
   * If value is a fixed-sized value that was deserialized from a
   * corrupted serialized container then %NULL may be returned.  In this
   * case, the proper thing to do is typically to use the appropriate
   * number of nul bytes in place of value.  If value is not fixed-sized
   * then %NULL is never returned.
   * In the case that value is already in serialized form, this function
   * is O$(LPAREN)1$(RPAREN).  If the value is not already in serialized form,
   * serialization occurs implicitly and is approximately O$(LPAREN)n$(RPAREN) in the size
   * of the result.
   * To deserialize the data returned by this function, in addition to the
   * serialized data, you must know the type of the #GVariant, and $(LPAREN)if the
   * machine might be different$(RPAREN) the endianness of the machine that stored
   * it. As a result, file formats or network messages that incorporate
   * serialized #GVariants must include this information either
   * implicitly $(LPAREN)for instance "the file always contains a
   * %G_VARIANT_TYPE_VARIANT and it is always in little-endian order"$(RPAREN) or
   * explicitly $(LPAREN)by storing the type and/or endianness in addition to the
   * serialized data$(RPAREN).
   * Returns: the serialized form of value, or %NULL
   */
  const(void)* getData()
  {
    const(void)* _retval;
    _retval = g_variant_get_data(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns a pointer to the serialized form of a #GVariant instance.
   * The semantics of this function are exactly the same as
   * [GLib.VariantG.getData], except that the returned #GBytes holds
   * a reference to the variant data.
   * Returns: A new #GBytes representing the variant data
   */
  Bytes getDataAsBytes()
  {
    GBytes* _cretval;
    _cretval = g_variant_get_data_as_bytes(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the double precision floating point value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_DOUBLE.
   * Returns: a #gdouble
   */
  double getDouble()
  {
    double _retval;
    _retval = g_variant_get_double(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 32-bit signed integer value of value.
   * It is an error to call this function with a value of any type other
   * than %G_VARIANT_TYPE_HANDLE.
   * By convention, handles are indexes into an array of file descriptors
   * that are sent alongside a D-Bus message.  If you're not interacting
   * with D-Bus, you probably don't need them.
   * Returns: a #gint32
   */
  int getHandle()
  {
    int _retval;
    _retval = g_variant_get_handle(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 16-bit signed integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_INT16.
   * Returns: a #gint16
   */
  short getInt16()
  {
    short _retval;
    _retval = g_variant_get_int16(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 32-bit signed integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_INT32.
   * Returns: a #gint32
   */
  int getInt32()
  {
    int _retval;
    _retval = g_variant_get_int32(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 64-bit signed integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_INT64.
   * Returns: a #gint64
   */
  long getInt64()
  {
    long _retval;
    _retval = g_variant_get_int64(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Given a maybe-typed #GVariant instance, extract its value.  If the
   * value is Nothing, then this function returns %NULL.
   * Returns: the contents of value, or %NULL
   */
  VariantG getMaybe()
  {
    VariantC* _cretval;
    _cretval = g_variant_get_maybe(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a #GVariant instance that has the same value as value and is
   * trusted to be in normal form.
   * If value is already trusted to be in normal form then a new
   * reference to value is returned.
   * If value is not already trusted, then it is scanned to check if it
   * is in normal form.  If it is found to be in normal form then it is
   * marked as trusted and a new reference to it is returned.
   * If value is found not to be in normal form then a new trusted
   * #GVariant is created with the same value as value. The non-normal parts of
   * value will be replaced with default values which are guaranteed to be in
   * normal form.
   * It makes sense to call this function if you've received #GVariant
   * data from untrusted sources and you want to ensure your serialized
   * output is definitely in normal form.
   * If value is already in normal form, a new reference will be returned
   * $(LPAREN)which will be floating if value is floating$(RPAREN). If it is not in normal form,
   * the newly created #GVariant will be returned with a single non-floating
   * reference. Typically, [GLib.VariantG.takeRef] should be called on the return
   * value from this function to guarantee ownership of a single non-floating
   * reference to it.
   * Returns: a trusted #GVariant
   */
  VariantG getNormalForm()
  {
    VariantC* _cretval;
    _cretval = g_variant_get_normal_form(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the contents of an array of object paths #GVariant.  This call
   * makes a shallow copy; the return result should be released with
   * [GLib.Global.gfree], but the individual strings must not be modified.
   * If length is non-%NULL then the number of elements in the result
   * is stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of constant strings
   */
  string[] getObjv()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_objv(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Determines the number of bytes that would be required to store value
   * with [GLib.VariantG.store].
   * If value has a fixed-sized type then this function always returned
   * that fixed size.
   * In the case that value is already in serialized form or the size has
   * already been calculated $(LPAREN)ie: this function has been called before$(RPAREN)
   * then this function is O$(LPAREN)1$(RPAREN).  Otherwise, the size is calculated, an
   * operation which is approximately O$(LPAREN)n$(RPAREN) in the number of values
   * involved.
   * Returns: the serialized size of value
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_variant_get_size(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the string value of a #GVariant instance with a string
   * type.  This includes the types %G_VARIANT_TYPE_STRING,
   * %G_VARIANT_TYPE_OBJECT_PATH and %G_VARIANT_TYPE_SIGNATURE.
   * The string will always be UTF-8 encoded, will never be %NULL, and will never
   * contain nul bytes.
   * If length is non-%NULL then the length of the string $(LPAREN)in bytes$(RPAREN) is
   * returned there.  For trusted values, this information is already
   * known.  Untrusted values will be validated and, if valid, a strlen$(LPAREN)$(RPAREN) will be
   * performed. If invalid, a default value will be returned — for
   * %G_VARIANT_TYPE_OBJECT_PATH, this is `"/"`, and for other types it is the
   * empty string.
   * It is an error to call this function with a value of any type
   * other than those three.
   * The return value remains valid as long as value exists.
   * Returns: the constant string, UTF-8 encoded
   */
  string getString()
  {
    char* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_string(cast(VariantC*)cPtr, &_cretlength);
    string _retval;

    if (_cretval)
    {
      _retval = cast(string )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Gets the contents of an array of strings #GVariant.  This call
   * makes a shallow copy; the return result should be released with
   * [GLib.Global.gfree], but the individual strings must not be modified.
   * If length is non-%NULL then the number of elements in the result
   * is stored there.  In any case, the resulting array will be
   * %NULL-terminated.
   * For an empty array, length will be set to 0 and a pointer to a
   * %NULL pointer will be returned.
   * Returns: an array of constant strings
   */
  string[] getStrv()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_strv(cast(VariantC*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Determines the type of value.
   * The return value is valid for the lifetime of value and must not
   * be freed.
   * Returns: a #GVariantType
   */
  VariantType getType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_variant_get_type(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the type string of value.  Unlike the result of calling
   * [GLib.VariantType.peekString], this string is nul-terminated.  This
   * string belongs to #GVariant and must not be freed.
   * Returns: the type string for the type of value
   */
  string getTypeString()
  {
    const(char)* _cretval;
    _cretval = g_variant_get_type_string(cast(VariantC*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the 16-bit unsigned integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_UINT16.
   * Returns: a #guint16
   */
  ushort getUint16()
  {
    ushort _retval;
    _retval = g_variant_get_uint16(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 32-bit unsigned integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_UINT32.
   * Returns: a #guint32
   */
  uint getUint32()
  {
    uint _retval;
    _retval = g_variant_get_uint32(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Returns the 64-bit unsigned integer value of value.
   * It is an error to call this function with a value of any type
   * other than %G_VARIANT_TYPE_UINT64.
   * Returns: a #guint64
   */
  ulong getUint64()
  {
    ulong _retval;
    _retval = g_variant_get_uint64(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Unboxes value.  The result is the #GVariant instance that was
   * contained in value.
   * Returns: the item contained in the variant
   */
  VariantG getVariant()
  {
    VariantC* _cretval;
    _cretval = g_variant_get_variant(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Generates a hash value for a #GVariant instance.
   * The output of this function is guaranteed to be the same for a given
   * value only per-process.  It may change between different processor
   * architectures or even different versions of GLib.  Do not use this
   * function as a basis for building protocols or file formats.
   * The type of value is #gconstpointer only to allow use of this
   * function with #GHashTable.  value must be a #GVariant.
   * Returns: a hash value corresponding to value
   */
  uint hash()
  {
    uint _retval;
    _retval = g_variant_hash(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Checks if value is a container.
   * Returns: %TRUE if value is a container
   */
  bool isContainer()
  {
    bool _retval;
    _retval = g_variant_is_container(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Checks whether value has a floating reference count.
   * This function should only ever be used to assert that a given variant
   * is or is not floating, or for debug purposes. To acquire a reference
   * to a variant that might be floating, always use [GLib.VariantG.refSink]
   * or [GLib.VariantG.takeRef].
   * See [GLib.VariantG.refSink] for more information about floating reference
   * counts.
   * Returns: whether value is floating
   */
  bool isFloating()
  {
    bool _retval;
    _retval = g_variant_is_floating(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Checks if value is in normal form.
   * The main reason to do this is to detect if a given chunk of
   * serialized data is in normal form: load the data into a #GVariant
   * using [GLib.VariantG.newFromData] and then use this function to
   * check.
   * If value is found to be in normal form then it will be marked as
   * being trusted.  If the value was already marked as being trusted then
   * this function will immediately return %TRUE.
   * There may be implementation specific restrictions on deeply nested values.
   * GVariant is guaranteed to handle nesting up to at least 64 levels.
   * Returns: %TRUE if value is in normal form
   */
  bool isNormalForm()
  {
    bool _retval;
    _retval = g_variant_is_normal_form(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Checks if a value has a type matching the provided type.
   * Params:
   *   type = a #GVariantType
   * Returns: %TRUE if the type of value matches type
   */
  bool isOfType(VariantType type)
  {
    bool _retval;
    _retval = g_variant_is_of_type(cast(VariantC*)cPtr, type ? cast(GVariantType*)type.cPtr(false) : null);
    return _retval;
  }

  /**
   * Looks up a value in a dictionary #GVariant.
   * This function works with dictionaries of the type a{s*} $(LPAREN)and equally
   * well with type a{o*}, but we only further discuss the string case
   * for sake of clarity$(RPAREN).
   * In the event that dictionary has the type a{sv}, the expected_type
   * string specifies what type of value is expected to be inside of the
   * variant. If the value inside the variant has a different type then
   * %NULL is returned. In the event that dictionary has a value type other
   * than v then expected_type must directly match the value type and it is
   * used to unpack the value directly or an error occurs.
   * In either case, if key is not found in dictionary, %NULL is returned.
   * If the key is found and the value has the correct type, it is
   * returned.  If expected_type was specified then any non-%NULL return
   * value will have this type.
   * This function is currently implemented with a linear scan.  If you
   * plan to do many lookups then #GVariantDict may be more efficient.
   * Params:
   *   key = the key to look up in the dictionary
   *   expectedType = a #GVariantType, or %NULL
   * Returns: the value of the dictionary key, or %NULL
   */
  VariantG lookupValue(string key, VariantType expectedType)
  {
    VariantC* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_variant_lookup_value(cast(VariantC*)cPtr, _key, expectedType ? cast(GVariantType*)expectedType.cPtr(false) : null);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Determines the number of children in a container #GVariant instance.
   * This includes variants, maybes, arrays, tuples and dictionary
   * entries.  It is an error to call this function on any other type of
   * #GVariant.
   * For variants, the return value is always 1.  For values with maybe
   * types, it is always zero or one.  For arrays, it is the length of the
   * array.  For tuples it is the number of tuple items $(LPAREN)which depends
   * only on the type$(RPAREN).  For dictionary entries, it is always 2
   * This function is O$(LPAREN)1$(RPAREN).
   * Returns: the number of children in the container
   */
  size_t nChildren()
  {
    size_t _retval;
    _retval = g_variant_n_children(cast(VariantC*)cPtr);
    return _retval;
  }

  /**
   * Pretty-prints value in the format understood by [GLib.VariantG.parse].
   * The format is described [here][gvariant-text].
   * If type_annotate is %TRUE, then type information is included in
   * the output.
   * Params:
   *   typeAnnotate = %TRUE if type information should be included in
   *     the output
   * Returns: a newly-allocated string holding the result.
   */
  string print(bool typeAnnotate)
  {
    char* _cretval;
    _cretval = g_variant_print(cast(VariantC*)cPtr, typeAnnotate);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * #GVariant uses a floating reference count system.  All functions with
   * names starting with `g_variant_new_` return floating
   * references.
   * Calling [GLib.VariantG.refSink] on a #GVariant with a floating reference
   * will convert the floating reference into a full reference.  Calling
   * [GLib.VariantG.refSink] on a non-floating #GVariant results in an
   * additional normal reference being added.
   * In other words, if the value is floating, then this call "assumes
   * ownership" of the floating reference, converting it to a normal
   * reference.  If the value is not floating, then this call adds a
   * new normal reference increasing the reference count by one.
   * All calls that result in a #GVariant instance being inserted into a
   * container will call [GLib.VariantG.refSink] on the instance.  This means
   * that if the value was just created $(LPAREN)and has only its floating
   * reference$(RPAREN) then the container will assume sole ownership of the value
   * at that point and the caller will not need to unreference it.  This
   * makes certain common styles of programming much easier while still
   * maintaining normal refcounting semantics in situations where values
   * are not floating.
   * Returns: the same value
   */
  VariantG refSink()
  {
    VariantC* _cretval;
    _cretval = g_variant_ref_sink(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Stores the serialized form of value at data.  data should be
   * large enough.  See [GLib.VariantG.getSize].
   * The stored data is in machine native byte order but may not be in
   * fully-normalised form if read from an untrusted source.  See
   * [GLib.VariantG.getNormalForm] for a solution.
   * As with [GLib.VariantG.getData], to be able to deserialize the
   * serialized variant successfully, its type and $(LPAREN)if the destination
   * machine might be different$(RPAREN) its endianness must also be available.
   * This function is approximately O$(LPAREN)n$(RPAREN) in the size of data.
   * Params:
   *   data = the location to store the serialized data at
   */
  void store(void* data)
  {
    g_variant_store(cast(VariantC*)cPtr, data);
  }

  /**
   * If value is floating, sink it.  Otherwise, do nothing.
   * Typically you want to use [GLib.VariantG.refSink] in order to
   * automatically do the correct thing with respect to floating or
   * non-floating references, but there is one specific scenario where
   * this function is helpful.
   * The situation where this function is helpful is when creating an API
   * that allows the user to provide a callback function that returns a
   * #GVariant.  We certainly want to allow the user the flexibility to
   * return a non-floating reference from this callback $(LPAREN)for the case
   * where the value that is being returned already exists$(RPAREN).
   * At the same time, the style of the #GVariant API makes it likely that
   * for newly-created #GVariant instances, the user can be saved some
   * typing if they are allowed to return a #GVariant with a floating
   * reference.
   * Using this function on the return value of the user's callback allows
   * the user to do whichever is more convenient for them.  The caller
   * will always receives exactly one full reference to the value: either
   * the one that was returned in the first place, or a floating reference
   * that has been converted to a full reference.
   * This function has an odd interaction when combined with
   * [GLib.VariantG.refSink] running at the same time in another thread on
   * the same #GVariant instance.  If [GLib.VariantG.refSink] runs first then
   * the result will be that the floating reference is converted to a hard
   * reference.  If [GLib.VariantG.takeRef] runs first then the result will
   * be that the floating reference is converted to a hard reference and
   * an additional reference on top of that one is added.  It is best to
   * avoid this situation.
   * Returns: the same value
   */
  VariantG takeRef()
  {
    VariantC* _cretval;
    _cretval = g_variant_take_ref(cast(VariantC*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Determines if a given string is a valid D-Bus object path.  You
   * should ensure that a string is a valid D-Bus object path before
   * passing it to [GLib.VariantG.newObjectPath].
   * A valid object path starts with `/` followed by zero or more
   * sequences of characters separated by `/` characters.  Each sequence
   * must contain only the characters `[A-Z][a-z][0-9]_`.  No sequence
   * $(LPAREN)including the one following the final `/` character$(RPAREN) may be empty.
   * Params:
   *   string_ = a normal C nul-terminated string
   * Returns: %TRUE if string is a D-Bus object path
   */
  static bool isObjectPath(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_variant_is_object_path(_string_);
    return _retval;
  }

  /**
   * Determines if a given string is a valid D-Bus type signature.  You
   * should ensure that a string is a valid D-Bus type signature before
   * passing it to [GLib.VariantG.newSignature].
   * D-Bus type signatures consist of zero or more definite #GVariantType
   * strings in sequence.
   * Params:
   *   string_ = a normal C nul-terminated string
   * Returns: %TRUE if string is a D-Bus type signature
   */
  static bool isSignature(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_variant_is_signature(_string_);
    return _retval;
  }

  /**
   * Pretty-prints a message showing the context of a #GVariant parse
   * error within the string for which parsing was attempted.
   * The resulting string is suitable for output to the console or other
   * monospace media where newlines are treated in the usual way.
   * The message will typically look something like one of the following:
   * |[
   * unterminated string constant:
   * $(LPAREN)1, 2, 3, 'abc
   * ^^^^
   * ]|
   * or
   * |[
   * unable to find a common type:
   * [1, 2, 3, 'str']
   * ^        ^^^^^
   * ]|
   * The format of the message may change in a future version.
   * error must have come from a failed attempt to [GLib.VariantG.parse] and
   * source_str must be exactly the same string that caused the error.
   * If source_str was not nul-terminated when you passed it to
   * [GLib.VariantG.parse] then you must add nul termination before using this
   * function.
   * Params:
   *   error = a #GError from the #GVariantParseError domain
   *   sourceStr = the string that was given to the parser
   * Returns: the printed message
   */
  static string parseErrorPrintContext(ErrorG error, string sourceStr)
  {
    char* _cretval;
    const(char)* _sourceStr = sourceStr.toCString(false);
    _cretval = g_variant_parse_error_print_context(error ? cast(GError*)error.cPtr : null, _sourceStr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  static Quark parseErrorQuark()
  {
    Quark _retval;
    _retval = g_variant_parse_error_quark();
    return _retval;
  }
}

class VariantParseException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(VariantG.parseErrorQuark, cast(int)code, msg);
  }

  alias Code = GVariantParseError;
}
