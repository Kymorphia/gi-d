module GLib.Variant;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.VariantType;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * #GVariant is a variant datatype; it can contain one or more values
 * along with information about the type of the values.
 *
 * A #GVariant may contain simple types, like an integer, or a boolean value;
 * or complex types, like an array of two strings, or a dictionary of key
 * value pairs. A #GVariant is also immutable: once it's been created neither
 * its type nor its content can be modified further.
 *
 * GVariant is useful whenever data needs to be serialized, for example when
 * sending method parameters in D-Bus, or when saving settings using GSettings.
 *
 * When creating a new #GVariant, you pass the data you want to store in it
 * along with a string representing the type of data you wish to pass to it.
 *
 * For instance, if you want to create a #GVariant holding an integer value you
 * can use:
 *
 * |[<!-- language="C" -->
 * GVariant *v = g_variant_new ("u", 40);
 * ]|
 *
 * The string "u" in the first argument tells #GVariant that the data passed to
 * the constructor (40) is going to be an unsigned integer.
 *
 * More advanced examples of #GVariant in use can be found in documentation for
 * [GVariant format strings][gvariant-format-strings-pointers].
 *
 * The range of possible values is determined by the type.
 *
 * The type system used by #GVariant is #GVariantType.
 *
 * #GVariant instances always have a type and a value (which are given
 * at construction time).  The type and value of a #GVariant instance
 * can never change other than by the #GVariant itself being
 * destroyed.  A #GVariant cannot contain a pointer.
 *
 * #GVariant is reference counted using g_variant_ref() and
 * g_variant_unref().  #GVariant also has floating reference counts --
 * see g_variant_ref_sink().
 *
 * #GVariant is completely threadsafe.  A #GVariant instance can be
 * concurrently accessed in any way from any number of threads without
 * problems.
 *
 * #GVariant is heavily optimised for dealing with data in serialized
 * form.  It works particularly well with data located in memory-mapped
 * files.  It can perform nearly all deserialization operations in a
 * small constant time, usually touching only a single memory page.
 * Serialized #GVariant data can also be sent over the network.
 *
 * #GVariant is largely compatible with D-Bus.  Almost all types of
 * #GVariant instances can be sent over D-Bus.  See #GVariantType for
 * exceptions.  (However, #GVariant's serialization format is not the same
 * as the serialization format of a D-Bus message body: use #GDBusMessage,
 * in the gio library, for those.)
 *
 * For space-efficiency, the #GVariant serialization format does not
 * automatically include the variant's length, type or endianness,
 * which must either be implied from context (such as knowledge that a
 * particular file format always contains a little-endian
 * %G_VARIANT_TYPE_VARIANT which occupies the whole length of the file)
 * or supplied out-of-band (for instance, a length, type and/or endianness
 * indicator could be placed at the beginning of a file, network message
 * or network stream).
 *
 * A #GVariant's size is limited mainly by any lower level operating
 * system constraints, such as the number of bits in #gsize.  For
 * example, it is reasonable to have a 2GB file mapped into memory
 * with #GMappedFile, and call g_variant_new_from_data() on it.
 *
 * For convenience to C programmers, #GVariant features powerful
 * varargs-based value construction and destruction.  This feature is
 * designed to be embedded in other libraries.
 *
 * There is a Python-inspired text language for describing #GVariant
 * values.  #GVariant includes a printer for this language and a parser
 * with type inferencing.
 *
 * ## Memory Use
 *
 * #GVariant tries to be quite efficient with respect to memory use.
 * This section gives a rough idea of how much memory is used by the
 * current implementation.  The information here is subject to change
 * in the future.
 *
 * The memory allocated by #GVariant can be grouped into 4 broad
 * purposes: memory for serialized data, memory for the type
 * information cache, buffer management memory and memory for the
 * #GVariant structure itself.
 *
 * ## Serialized Data Memory
 *
 * This is the memory that is used for storing GVariant data in
 * serialized form.  This is what would be sent over the network or
 * what would end up on disk, not counting any indicator of the
 * endianness, or of the length or type of the top-level variant.
 *
 * The amount of memory required to store a boolean is 1 byte. 16,
 * 32 and 64 bit integers and double precision floating point numbers
 * use their "natural" size.  Strings (including object path and
 * signature strings) are stored with a nul terminator, and as such
 * use the length of the string plus 1 byte.
 *
 * Maybe types use no space at all to represent the null value and
 * use the same amount of space (sometimes plus one byte) as the
 * equivalent non-maybe-typed value to represent the non-null case.
 *
 * Arrays use the amount of space required to store each of their
 * members, concatenated.  Additionally, if the items stored in an
 * array are not of a fixed-size (ie: strings, other arrays, etc)
 * then an additional framing offset is stored for each item.  The
 * size of this offset is either 1, 2 or 4 bytes depending on the
 * overall size of the container.  Additionally, extra padding bytes
 * are added as required for alignment of child values.
 *
 * Tuples (including dictionary entries) use the amount of space
 * required to store each of their members, concatenated, plus one
 * framing offset (as per arrays) for each non-fixed-sized item in
 * the tuple, except for the last one.  Additionally, extra padding
 * bytes are added as required for alignment of child values.
 *
 * Variants use the same amount of space as the item inside of the
 * variant, plus 1 byte, plus the length of the type string for the
 * item inside the variant.
 *
 * As an example, consider a dictionary mapping strings to variants.
 * In the case that the dictionary is empty, 0 bytes are required for
 * the serialization.
 *
 * If we add an item "width" that maps to the int32 value of 500 then
 * we will use 4 byte to store the int32 (so 6 for the variant
 * containing it) and 6 bytes for the string.  The variant must be
 * aligned to 8 after the 6 bytes of the string, so that's 2 extra
 * bytes.  6 (string) + 2 (padding) + 6 (variant) is 14 bytes used
 * for the dictionary entry.  An additional 1 byte is added to the
 * array as a framing offset making a total of 15 bytes.
 *
 * If we add another entry, "title" that maps to a nullable string
 * that happens to have a value of null, then we use 0 bytes for the
 * null value (and 3 bytes for the variant to contain it along with
 * its type string) plus 6 bytes for the string.  Again, we need 2
 * padding bytes.  That makes a total of 6 + 2 + 3 = 11 bytes.
 *
 * We now require extra padding between the two items in the array.
 * After the 14 bytes of the first item, that's 2 bytes required.
 * We now require 2 framing offsets for an extra two
 * bytes. 14 + 2 + 11 + 2 = 29 bytes to encode the entire two-item
 * dictionary.
 *
 * ## Type Information Cache
 *
 * For each GVariant type that currently exists in the program a type
 * information structure is kept in the type information cache.  The
 * type information structure is required for rapid deserialization.
 *
 * Continuing with the above example, if a #GVariant exists with the
 * type "a{sv}" then a type information struct will exist for
 * "a{sv}", "{sv}", "s", and "v".  Multiple uses of the same type
 * will share the same type information.  Additionally, all
 * single-digit types are stored in read-only static memory and do
 * not contribute to the writable memory footprint of a program using
 * #GVariant.
 *
 * Aside from the type information structures stored in read-only
 * memory, there are two forms of type information.  One is used for
 * container types where there is a single element type: arrays and
 * maybe types.  The other is used for container types where there
 * are multiple element types: tuples and dictionary entries.
 *
 * Array type info structures are 6 * sizeof (void *), plus the
 * memory required to store the type string itself.  This means that
 * on 32-bit systems, the cache entry for "a{sv}" would require 30
 * bytes of memory (plus malloc overhead).
 *
 * Tuple type info structures are 6 * sizeof (void *), plus 4 *
 * sizeof (void *) for each item in the tuple, plus the memory
 * required to store the type string itself.  A 2-item tuple, for
 * example, would have a type information structure that consumed
 * writable memory in the size of 14 * sizeof (void *) (plus type
 * string)  This means that on 32-bit systems, the cache entry for
 * "{sv}" would require 61 bytes of memory (plus malloc overhead).
 *
 * This means that in total, for our "a{sv}" example, 91 bytes of
 * type information would be allocated.
 *
 * The type information cache, additionally, uses a #GHashTable to
 * store and look up the cached items and stores a pointer to this
 * hash table in static storage.  The hash table is freed when there
 * are zero items in the type cache.
 *
 * Although these sizes may seem large it is important to remember
 * that a program will probably only have a very small number of
 * different types of values in it and that only one type information
 * structure is required for many different values of the same type.
 *
 * ## Buffer Management Memory
 *
 * #GVariant uses an internal buffer management structure to deal
 * with the various different possible sources of serialized data
 * that it uses.  The buffer is responsible for ensuring that the
 * correct call is made when the data is no longer in use by
 * #GVariant.  This may involve a g_free() or a g_slice_free() or
 * even g_mapped_file_unref().
 *
 * One buffer management structure is used for each chunk of
 * serialized data.  The size of the buffer management structure
 * is 4 * (void *).  On 32-bit systems, that's 16 bytes.
 *
 * ## GVariant structure
 *
 * The size of a #GVariant structure is 6 * (void *).  On 32-bit
 * systems, that's 24 bytes.
 *
 * #GVariant structures only exist if they are explicitly created
 * with API calls.  For example, if a #GVariant is constructed out of
 * serialized data for the example given above (with the dictionary)
 * then although there are 9 individual values that comprise the
 * entire dictionary (two keys, two values, two variants containing
 * the values, two dictionary entries, plus the dictionary itself),
 * only 1 #GVariant instance exists -- the one referring to the
 * dictionary.
 *
 * If calls are made to start accessing the other values then
 * #GVariant instances will exist for those values only for as long
 * as they are in use (ie: until you call g_variant_unref()).  The
 * type information is shared.  The serialized data and the buffer
 * management structure for that serialized data is shared by the
 * child.
 *
 * ## Summary
 *
 * To put the entire example together, for our dictionary mapping
 * strings to variants (with two entries, as given above), we are
 * using 91 bytes of memory for type information, 29 bytes of memory
 * for the serialized data, 16 bytes for buffer management and 24
 * bytes for the #GVariant instance, or a total of 160 bytes, plus
 * malloc overhead.  If we were to use g_variant_get_child_value() to
 * access the two dictionary entries, we would use an additional 48
 * bytes.  If we were to have other dictionaries of the same type, we
 * would use more memory for the serialized data and buffer
 * management for those dictionaries, but the type information would
 * be shared.
 */
class Variant
{
  GVariant* cInstancePtr;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Variant");

    cInstancePtr = cast(GVariant*)ptr;

    if (!ownedRef)
      g_variant_ref(cInstancePtr);
  }

  ~this()
  {
    g_variant_unref(cInstancePtr);
  }


  T* cPtr(T)(bool addRef = false)
  if (is(T == GVariant))
  {
    if (addRef)
      g_variant_ref(cInstancePtr);

    return cast(T*)cInstancePtr;
  }

  /**
   * a floating reference to a new #GVariant array
   */
  static Variant newArray(VariantType childType, Variant[] children)
  {
    GVariant* _cretval;
    GVariant*[] _tmpchildren;
    foreach (obj; children)
      _tmpchildren ~= obj ? obj.cPtr!GVariant : null;
    GVariant** _children = cast(GVariant**)_tmpchildren.ptr;
    _cretval = g_variant_new_array(childType ? childType.cPtr!GVariantType : null, _children, children ? cast(size_t)children.length : 0);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new boolean #GVariant instance
   */
  static Variant newBoolean(bool value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_boolean(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new byte #GVariant instance
   */
  static Variant newByte(ubyte value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_byte(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new bytestring #GVariant instance
   */
  static Variant newBytestring(string string_)
  {
    GVariant* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_variant_new_bytestring(_string_);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a new floating #GVariant instance
   */
  static Variant newBytestringArray(string[] strv)
  {
    GVariant* _cretval;
    char*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_bytestring_array(_strv, strv ? cast(ptrdiff_t)strv.length : 0);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new dictionary entry #GVariant
   */
  static Variant newDictEntry(Variant key, Variant value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_dict_entry(key ? key.cPtr!GVariant : null, value ? value.cPtr!GVariant : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new double #GVariant instance
   */
  static Variant newDouble(double value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_double(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new array #GVariant instance
   */
  static Variant newFixedArray(VariantType elementType, const(void)* elements, size_t nElements, size_t elementSize)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_fixed_array(elementType ? elementType.cPtr!GVariantType : null, elements, nElements, elementSize);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a new #GVariant with a floating reference
   */
  static Variant newFromBytes(VariantType type, Bytes bytes, bool trusted)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_from_bytes(type ? type.cPtr!GVariantType : null, bytes ? bytes.cPtr!GBytes : null, trusted);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new handle #GVariant instance
   */
  static Variant newHandle(int value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_handle(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new int16 #GVariant instance
   */
  static Variant newInt16(short value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_int16(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new int32 #GVariant instance
   */
  static Variant newInt32(int value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_int32(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new int64 #GVariant instance
   */
  static Variant newInt64(long value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_int64(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new #GVariant maybe instance
   */
  static Variant newMaybe(VariantType childType, Variant child)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_maybe(childType ? childType.cPtr!GVariantType : null, child ? child.cPtr!GVariant : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new object path #GVariant instance
   */
  static Variant newObjectPath(string objectPath)
  {
    GVariant* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_variant_new_object_path(_objectPath);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a new floating #GVariant instance
   */
  static Variant newObjv(string[] strv)
  {
    GVariant* _cretval;
    char*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_objv(_strv, strv ? cast(ptrdiff_t)strv.length : 0);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new signature #GVariant instance
   */
  static Variant newSignature(string signature)
  {
    GVariant* _cretval;
    const(char)* _signature = signature.toCString(false);
    _cretval = g_variant_new_signature(_signature);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new string #GVariant instance
   */
  static Variant newString(string string_)
  {
    GVariant* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_variant_new_string(_string_);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a new floating #GVariant instance
   */
  static Variant newStrv(string[] strv)
  {
    GVariant* _cretval;
    char*[] _tmpstrv;
    foreach (s; strv)
      _tmpstrv ~= s.toCString(false);
    const(char*)* _strv = _tmpstrv.ptr;
    _cretval = g_variant_new_strv(_strv, strv ? cast(ptrdiff_t)strv.length : 0);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new #GVariant tuple
   */
  static Variant newTuple(Variant[] children)
  {
    GVariant* _cretval;
    GVariant*[] _tmpchildren;
    foreach (obj; children)
      _tmpchildren ~= obj ? obj.cPtr!GVariant : null;
    GVariant** _children = cast(GVariant**)_tmpchildren.ptr;
    _cretval = g_variant_new_tuple(_children, children ? cast(size_t)children.length : 0);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new uint16 #GVariant instance
   */
  static Variant newUint16(ushort value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_uint16(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new uint32 #GVariant instance
   */
  static Variant newUint32(uint value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_uint32(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new uint64 #GVariant instance
   */
  static Variant newUint64(ulong value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_uint64(value);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a floating reference to a new variant #GVariant instance
   */
  static Variant newVariant(Variant value)
  {
    GVariant* _cretval;
    _cretval = g_variant_new_variant(value ? value.cPtr!GVariant : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * the byteswapped form of @value
   */
  Variant byteswap()
  {
    GVariant* _cretval;
    _cretval = g_variant_byteswap(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @format_string is safe to use
   */
  bool checkFormatString(string formatString, bool copyOnly)
  {
    bool _retval;
    const(char)* _formatString = formatString.toCString(false);
    _retval = g_variant_check_format_string(cPtr!GVariant, _formatString, copyOnly);
    return _retval;
  }

  /**
   * the #GVariantClass of @value
   */
  VariantClass classify()
  {
    GVariantClass _cretval;
    _cretval = g_variant_classify(cPtr!GVariant);
    VariantClass _retval = cast(VariantClass)_cretval;
    return _retval;
  }

  /**
   * negative value if a < b;
   * zero if a = b;
   * positive value if a > b.
   */
  int compare(Variant two)
  {
    int _retval;
    _retval = g_variant_compare(cPtr!GVariant, two ? two.cPtr!GVariant : null);
    return _retval;
  }

  /**
   * a newly allocated string
   */
  ubyte[] dupBytestring()
  {
    ubyte* _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_bytestring(cPtr!GVariant, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * an array of strings
   */
  string[] dupBytestringArray()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_bytestring_array(cPtr!GVariant, &_cretlength);
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
   * an array of strings
   */
  string[] dupObjv()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_objv(cPtr!GVariant, &_cretlength);
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
   * a newly allocated string, UTF-8 encoded
   */
  string dupString(out size_t length)
  {
    char* _cretval;
    _cretval = g_variant_dup_string(cPtr!GVariant, cast(size_t*)&length);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * an array of strings
   */
  string[] dupStrv()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_variant_dup_strv(cPtr!GVariant, &_cretlength);
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
   * %TRUE if @one and @two are equal
   */
  bool equal(Variant two)
  {
    bool _retval;
    _retval = g_variant_equal(cPtr!GVariant, two ? two.cPtr!GVariant : null);
    return _retval;
  }

  /**
   * %TRUE or %FALSE
   */
  bool getBoolean()
  {
    bool _retval;
    _retval = g_variant_get_boolean(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #guint8
   */
  ubyte getByte()
  {
    ubyte _retval;
    _retval = g_variant_get_byte(cPtr!GVariant);
    return _retval;
  }

  /**
   * the constant string
   */
  string getBytestring()
  {
    const(char)* _cretval;
    _cretval = g_variant_get_bytestring(cPtr!GVariant);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * an array of constant strings
   */
  string[] getBytestringArray()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_bytestring_array(cPtr!GVariant, &_cretlength);
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
   * the child at the specified index
   */
  Variant getChildValue(size_t index)
  {
    GVariant* _cretval;
    _cretval = g_variant_get_child_value(cPtr!GVariant, index);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the serialized form of @value, or %NULL
   */
  const(void)* getData()
  {
    const(void)* _retval;
    _retval = g_variant_get_data(cPtr!GVariant);
    return _retval;
  }

  /**
   * A new #GBytes representing the variant data
   */
  Bytes getDataAsBytes()
  {
    GBytes* _cretval;
    _cretval = g_variant_get_data_as_bytes(cPtr!GVariant);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * a #gdouble
   */
  double getDouble()
  {
    double _retval;
    _retval = g_variant_get_double(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #gint32
   */
  int getHandle()
  {
    int _retval;
    _retval = g_variant_get_handle(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #gint16
   */
  short getInt16()
  {
    short _retval;
    _retval = g_variant_get_int16(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #gint32
   */
  int getInt32()
  {
    int _retval;
    _retval = g_variant_get_int32(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #gint64
   */
  long getInt64()
  {
    long _retval;
    _retval = g_variant_get_int64(cPtr!GVariant);
    return _retval;
  }

  /**
   * the contents of @value, or %NULL
   */
  Variant getMaybe()
  {
    GVariant* _cretval;
    _cretval = g_variant_get_maybe(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a trusted #GVariant
   */
  Variant getNormalForm()
  {
    GVariant* _cretval;
    _cretval = g_variant_get_normal_form(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * an array of constant strings
   */
  string[] getObjv()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_objv(cPtr!GVariant, &_cretlength);
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
   * the serialized size of @value
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_variant_get_size(cPtr!GVariant);
    return _retval;
  }

  /**
   * the constant string, UTF-8 encoded
   */
  string getString(out size_t length)
  {
    const(char)* _cretval;
    _cretval = g_variant_get_string(cPtr!GVariant, cast(size_t*)&length);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * an array of constant strings
   */
  string[] getStrv()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = g_variant_get_strv(cPtr!GVariant, &_cretlength);
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
   * a #GVariantType
   */
  VariantType getType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_variant_get_type(cPtr!GVariant);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }

  /**
   * the type string for the type of @value
   */
  string getTypeString()
  {
    const(char)* _cretval;
    _cretval = g_variant_get_type_string(cPtr!GVariant);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #guint16
   */
  ushort getUint16()
  {
    ushort _retval;
    _retval = g_variant_get_uint16(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #guint32
   */
  uint getUint32()
  {
    uint _retval;
    _retval = g_variant_get_uint32(cPtr!GVariant);
    return _retval;
  }

  /**
   * a #guint64
   */
  ulong getUint64()
  {
    ulong _retval;
    _retval = g_variant_get_uint64(cPtr!GVariant);
    return _retval;
  }

  /**
   * the item contained in the variant
   */
  Variant getVariant()
  {
    GVariant* _cretval;
    _cretval = g_variant_get_variant(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a hash value corresponding to @value
   */
  uint hash()
  {
    uint _retval;
    _retval = g_variant_hash(cPtr!GVariant);
    return _retval;
  }

  /**
   * %TRUE if @value is a container
   */
  bool isContainer()
  {
    bool _retval;
    _retval = g_variant_is_container(cPtr!GVariant);
    return _retval;
  }

  /**
   * whether @value is floating
   */
  bool isFloating()
  {
    bool _retval;
    _retval = g_variant_is_floating(cPtr!GVariant);
    return _retval;
  }

  /**
   * %TRUE if @value is in normal form
   */
  bool isNormalForm()
  {
    bool _retval;
    _retval = g_variant_is_normal_form(cPtr!GVariant);
    return _retval;
  }

  /**
   * %TRUE if the type of @value matches @type
   */
  bool isOfType(VariantType type)
  {
    bool _retval;
    _retval = g_variant_is_of_type(cPtr!GVariant, type ? type.cPtr!GVariantType : null);
    return _retval;
  }

  /**
   * the value of the dictionary key, or %NULL
   */
  Variant lookupValue(string key, VariantType expectedType)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_variant_lookup_value(cPtr!GVariant, _key, expectedType ? expectedType.cPtr!GVariantType : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the number of children in the container
   */
  size_t nChildren()
  {
    size_t _retval;
    _retval = g_variant_n_children(cPtr!GVariant);
    return _retval;
  }

  /**
   * a newly-allocated string holding the result.
   */
  string print(bool typeAnnotate)
  {
    char* _cretval;
    _cretval = g_variant_print(cPtr!GVariant, typeAnnotate);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the same @value
   */
  Variant refSink()
  {
    GVariant* _cretval;
    _cretval = g_variant_ref_sink(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * Stores the serialized form of @value at @data.  @data should be
   * large enough.  See g_variant_get_size().
   *
   * The stored data is in machine native byte order but may not be in
   * fully-normalised form if read from an untrusted source.  See
   * g_variant_get_normal_form() for a solution.
   *
   * As with g_variant_get_data(), to be able to deserialize the
   * serialized variant successfully, its type and (if the destination
   * machine might be different) its endianness must also be available.
   *
   * This function is approximately O(n) in the size of @data.
   */
  void store(void* data)
  {
    g_variant_store(cPtr!GVariant, data);
  }

  /**
   * the same @value
   */
  Variant takeRef()
  {
    GVariant* _cretval;
    _cretval = g_variant_take_ref(cPtr!GVariant);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @string is a D-Bus object path
   */
  static bool isObjectPath(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_variant_is_object_path(_string_);
    return _retval;
  }

  /**
   * %TRUE if @string is a D-Bus type signature
   */
  static bool isSignature(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_variant_is_signature(_string_);
    return _retval;
  }

  /**
   * the printed message
   */
  static string parseErrorPrintContext(ErrorG error, string sourceStr)
  {
    char* _cretval;
    const(char)* _sourceStr = sourceStr.toCString(false);
    _cretval = g_variant_parse_error_print_context(error ? error.cPtr!GError : null, _sourceStr);
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
    super(Variant.parseErrorQuark, cast(int)code, msg);
  }

  alias Code = GVariantParseError;
}
