module Gdk.ContentFormats;

import GLib.Boxed;
import GLib.String;
import GObject.Types;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkContentFormats` structure is used to advertise and negotiate the
 * format of content.
 * You will encounter `GdkContentFormats` when interacting with objects
 * controlling operations that pass data between different widgets, window
 * or application, like [Gdk.Drag], [Gdk.Drop],
 * [Gdk.Clipboard] or [Gdk.ContentProvider].
 * GDK supports content in 2 forms: `GType` and mime type.
 * Using `GTypes` is meant only for in-process content transfers. Mime types
 * are meant to be used for data passing both in-process and out-of-process.
 * The details of how data is passed is described in the documentation of
 * the actual implementations. To transform between the two forms,
 * [Gdk.ContentSerializer] and [Gdk.ContentDeserializer] are used.
 * A `GdkContentFormats` describes a set of possible formats content can be
 * exchanged in. It is assumed that this set is ordered. `GTypes` are more
 * important than mime types. Order between different `GTypes` or mime types
 * is the order they were added in, most important first. Functions that
 * care about order, such as [Gdk.ContentFormats.union_], will describe
 * in their documentation how they interpret that order, though in general the
 * order of the first argument is considered the primary order of the result,
 * followed by the order of further arguments.
 * For debugging purposes, the function [Gdk.ContentFormats.toString_]
 * exists. It will print a comma-separated list of formats from most important
 * to least important.
 * `GdkContentFormats` is an immutable struct. After creation, you cannot change
 * the types it represents. Instead, new `GdkContentFormats` have to be created.
 * The [Gdk.ContentFormatsBuilder] structure is meant to help in this
 * endeavor.
 */
class ContentFormats : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_content_formats_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GdkContentFormats` from an array of mime types.
   * The mime types must be valid and different from each other or the
   * behavior of the return value is undefined. If you cannot guarantee
   * this, use [Gdk.ContentFormatsBuilder] instead.
   * Params:
   *   mimeTypes = Pointer to an
   *     array of mime types
   * Returns: the new `GdkContentFormats`.
   */
  this(string[] mimeTypes)
  {
    GdkContentFormats* _cretval;
    uint _nMimeTypes;
    if (mimeTypes)
      _nMimeTypes = cast(uint)mimeTypes.length;

    char*[] _tmpmimeTypes;
    foreach (s; mimeTypes)
      _tmpmimeTypes ~= s.toCString(false);
    const(char*)* _mimeTypes = _tmpmimeTypes.ptr;
    _cretval = gdk_content_formats_new(_mimeTypes, _nMimeTypes);
    this(_cretval, true);
  }

  /**
   * Creates a new `GdkContentFormats` for a given `GType`.
   * Params:
   *   type = a `GType`
   * Returns: a new `GdkContentFormats`
   */
  static ContentFormats newForGtype(GType type)
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_new_for_gtype(type);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if a given `GType` is part of the given formats.
   * Params:
   *   type = the `GType` to search for
   * Returns: %TRUE if the `GType` was found
   */
  bool containGtype(GType type)
  {
    bool _retval;
    _retval = gdk_content_formats_contain_gtype(cast(GdkContentFormats*)cPtr, type);
    return _retval;
  }

  /**
   * Checks if a given mime type is part of the given formats.
   * Params:
   *   mimeType = the mime type to search for
   * Returns: %TRUE if the mime_type was found
   */
  bool containMimeType(string mimeType)
  {
    bool _retval;
    const(char)* _mimeType = mimeType.toCString(false);
    _retval = gdk_content_formats_contain_mime_type(cast(GdkContentFormats*)cPtr, _mimeType);
    return _retval;
  }

  /**
   * Gets the `GType`s included in formats.
   * Note that formats may not contain any `GType`s, in particular when
   * they are empty. In that case %NULL will be returned.
   * Returns: %G_TYPE_INVALID-terminated array of types included in formats
   */
  GType[] getGtypes()
  {
    const(GType)* _cretval;
    size_t _cretlength;
    _cretval = gdk_content_formats_get_gtypes(cast(GdkContentFormats*)cPtr, &_cretlength);
    GType[] _retval;

    if (_cretval)
    {
      _retval = cast(GType[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Gets the mime types included in formats.
   * Note that formats may not contain any mime types, in particular
   * when they are empty. In that case %NULL will be returned.
   * Returns: %NULL-terminated array of interned strings of mime types included
   *   in formats
   */
  string[] getMimeTypes()
  {
    const(char*)* _cretval;
    size_t _cretlength;
    _cretval = gdk_content_formats_get_mime_types(cast(GdkContentFormats*)cPtr, &_cretlength);
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
   * Checks if first and second have any matching formats.
   * Params:
   *   second = the `GdkContentFormats` to intersect with
   * Returns: %TRUE if a matching format was found.
   */
  bool match(ContentFormats second)
  {
    bool _retval;
    _retval = gdk_content_formats_match(cast(GdkContentFormats*)cPtr, second ? cast(GdkContentFormats*)second.cPtr(false) : null);
    return _retval;
  }

  /**
   * Finds the first `GType` from first that is also contained
   * in second.
   * If no matching `GType` is found, %G_TYPE_INVALID is returned.
   * Params:
   *   second = the `GdkContentFormats` to intersect with
   * Returns: The first common `GType` or %G_TYPE_INVALID if none.
   */
  GType matchGtype(ContentFormats second)
  {
    GType _retval;
    _retval = gdk_content_formats_match_gtype(cast(GdkContentFormats*)cPtr, second ? cast(GdkContentFormats*)second.cPtr(false) : null);
    return _retval;
  }

  /**
   * Finds the first mime type from first that is also contained
   * in second.
   * If no matching mime type is found, %NULL is returned.
   * Params:
   *   second = the `GdkContentFormats` to intersect with
   * Returns: The first common mime type or %NULL if none
   */
  string matchMimeType(ContentFormats second)
  {
    const(char)* _cretval;
    _cretval = gdk_content_formats_match_mime_type(cast(GdkContentFormats*)cPtr, second ? cast(GdkContentFormats*)second.cPtr(false) : null);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Prints the given formats into a string for human consumption.
   * The result of this function can later be parsed with
   * [Gdk.ContentFormats.parse].
   * Params:
   *   string_ = a `GString` to print into
   */
  void print(String string_)
  {
    gdk_content_formats_print(cast(GdkContentFormats*)cPtr, string_ ? cast(GString*)string_.cPtr(false) : null);
  }

  /**
   * Prints the given formats into a human-readable string.
   * The resulting string can be parsed with [Gdk.ContentFormats.parse].
   * This is a small wrapper around [Gdk.ContentFormats.print]
   * to help when debugging.
   * Returns: a new string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gdk_content_formats_to_string(cast(GdkContentFormats*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Append all missing types from second to first, in the order
   * they had in second.
   * Params:
   *   second = the `GdkContentFormats` to merge from
   * Returns: a new `GdkContentFormats`
   */
  ContentFormats union_(ContentFormats second)
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_union(cast(GdkContentFormats*)cPtr, second ? cast(GdkContentFormats*)second.cPtr(false) : null);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Add GTypes for mime types in formats for which deserializers are
   * registered.
   * Returns: a new `GdkContentFormats`
   */
  ContentFormats unionDeserializeGtypes()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_union_deserialize_gtypes(cast(GdkContentFormats*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Add mime types for GTypes in formats for which deserializers are
   * registered.
   * Returns: a new `GdkContentFormats`
   */
  ContentFormats unionDeserializeMimeTypes()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_union_deserialize_mime_types(cast(GdkContentFormats*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Add GTypes for the mime types in formats for which serializers are
   * registered.
   * Returns: a new `GdkContentFormats`
   */
  ContentFormats unionSerializeGtypes()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_union_serialize_gtypes(cast(GdkContentFormats*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Add mime types for GTypes in formats for which serializers are
   * registered.
   * Returns: a new `GdkContentFormats`
   */
  ContentFormats unionSerializeMimeTypes()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_union_serialize_mime_types(cast(GdkContentFormats*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses the given string into `GdkContentFormats` and
   * returns the formats.
   * Strings printed via [Gdk.ContentFormats.toString_]
   * can be read in again successfully using this function.
   * If string does not describe valid content formats, %NULL
   * is returned.
   * Params:
   *   string_ = the string to parse
   * Returns: the content formats if string is valid
   */
  static ContentFormats parse(string string_)
  {
    GdkContentFormats* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gdk_content_formats_parse(_string_);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
