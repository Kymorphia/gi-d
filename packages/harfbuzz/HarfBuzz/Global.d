module HarfBuzz.Global;

import GLib.Bytes;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Blob;
import HarfBuzz.Buffer;
import HarfBuzz.ColorLine;
import HarfBuzz.ColorStop;
import HarfBuzz.DrawFuncs;
import HarfBuzz.DrawState;
import HarfBuzz.Feature;
import HarfBuzz.Font;
import HarfBuzz.FontFuncs;
import HarfBuzz.GlyphInfo;
import HarfBuzz.GlyphPosition;
import HarfBuzz.HBFace;
import HarfBuzz.Language;
import HarfBuzz.Map;
import HarfBuzz.OtMathGlyphPart;
import HarfBuzz.OtMathGlyphVariant;
import HarfBuzz.OtNameEntry;
import HarfBuzz.OtVarAxisInfo;
import HarfBuzz.PaintFuncs;
import HarfBuzz.SegmentProperties;
import HarfBuzz.Set;
import HarfBuzz.ShapePlan;
import HarfBuzz.Types;
import HarfBuzz.UnicodeFuncs;
import HarfBuzz.Variation;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;
import freetype2.Types;


/**
 * Name identifier of the requested feature type
 */
OtNameId aatLayoutFeatureTypeGetNameId(HBFace face, AatLayoutFeatureType featureType)
{
  OtNameId _retval;
  _retval = hb_aat_layout_feature_type_get_name_id(face ? face.cPtr!hb_face_t : null, featureType);
  return _retval;
}

/**
 * Number of all available feature selectors
 */
uint aatLayoutFeatureTypeGetSelectorInfos(HBFace face, AatLayoutFeatureType featureType, uint startOffset, ref AatLayoutFeatureSelectorInfo[] selectors, out uint defaultIndex)
{
  uint _retval;
  auto _selectorCount = selectors ? cast(uint)selectors.length : 0;
  _retval = hb_aat_layout_feature_type_get_selector_infos(face ? face.cPtr!hb_face_t : null, featureType, startOffset, &_selectorCount, selectors.ptr, cast(uint*)&defaultIndex);
  return _retval;
}

/**
 * Number of all available feature types.
 */
uint aatLayoutGetFeatureTypes(HBFace face, uint startOffset, ref AatLayoutFeatureType[] features)
{
  uint _retval;
  auto _featureCount = features ? cast(uint)features.length : 0;
  _retval = hb_aat_layout_get_feature_types(face ? face.cPtr!hb_face_t : null, startOffset, &_featureCount, features.ptr);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool aatLayoutHasPositioning(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_positioning(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool aatLayoutHasSubstitution(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_substitution(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool aatLayoutHasTracking(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_tracking(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * The new blob, or nullptr if allocation failed
 */
Blob blobCopyWritableOrFail(Blob blob)
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_copy_writable_or_fail(blob ? blob.cPtr!hb_blob_t : null);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * An #hb_blob_t pointer with the content of the file,
 * or hb_blob_get_empty() if failed.
 */
Blob blobCreateFromFile(string fileName)
{
  hb_blob_t* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = hb_blob_create_from_file(_fileName);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * An #hb_blob_t pointer with the content of the file,
 * or `NULL` if failed.
 */
Blob blobCreateFromFileOrFail(string fileName)
{
  hb_blob_t* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = hb_blob_create_from_file_or_fail(_fileName);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * New blob, or the empty blob if something failed or if
 * @length is zero or @offset is beyond the end of @parent's data.  Destroy
 * with hb_blob_destroy().
 */
Blob blobCreateSubBlob(Blob parent, uint offset, uint length)
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_create_sub_blob(parent ? parent.cPtr!hb_blob_t : null, offset, length);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * the byte data of @blob.
 */
string blobGetData(Blob blob)
{
  const(char)* _cretval;
  uint _cretlength;
  _cretval = hb_blob_get_data(blob ? blob.cPtr!hb_blob_t : null, &_cretlength);
  string _retval;

  if (_cretval)
  {
    _retval = cast(string )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Writable blob data,
 * or `NULL` if failed.
 */
string blobGetDataWritable(Blob blob)
{
  char* _cretval;
  uint _cretlength;
  _cretval = hb_blob_get_data_writable(blob ? blob.cPtr!hb_blob_t : null, &_cretlength);
  string _retval;

  if (_cretval)
  {
    _retval = cast(string )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * The empty blob.
 */
Blob blobGetEmpty()
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_get_empty();
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * the length of @blob data in bytes.
 */
uint blobGetLength(Blob blob)
{
  uint _retval;
  _retval = hb_blob_get_length(blob ? blob.cPtr!hb_blob_t : null);
  return _retval;
}

/**
 * `true` if @blob is immutable, `false` otherwise
 */
Bool blobIsImmutable(Blob blob)
{
  Bool _retval;
  _retval = hb_blob_is_immutable(blob ? blob.cPtr!hb_blob_t : null);
  return _retval;
}

/**
 * Makes a blob immutable.
 */
void blobMakeImmutable(Blob blob)
{
  hb_blob_make_immutable(blob ? blob.cPtr!hb_blob_t : null);
}

/**
 * Appends a character with the Unicode value of @codepoint to @buffer, and
 * gives it the initial cluster value of @cluster. Clusters can be any thing
 * the client wants, they are usually used to refer to the index of the
 * character in the input text stream and are output in
 * #hb_glyph_info_t.cluster field.
 *
 * This function does not check the validity of @codepoint, it is up to the
 * caller to ensure it is a valid Unicode code point.
 */
void bufferAdd(Buffer buffer, Codepoint codepoint, uint cluster)
{
  hb_buffer_add(buffer ? buffer.cPtr!hb_buffer_t : null, codepoint, cluster);
}

/**
 * Appends characters from @text array to @buffer. The @item_offset is the
 * position of the first character from @text that will be appended, and
 * @item_length is the number of character. When shaping part of a larger text
 * (e.g. a run of text from a paragraph), instead of passing just the substring
 * corresponding to the run, it is preferable to pass the whole
 * paragraph and specify the run start and length as @item_offset and
 * @item_length, respectively, to give HarfBuzz the full context to be able,
 * for example, to do cross-run Arabic shaping or properly handle combining
 * marks at stat of run.
 *
 * This function does not check the validity of @text, it is up to the caller
 * to ensure it contains a valid Unicode scalar values.  In contrast,
 * hb_buffer_add_utf32() can be used that takes similar input but performs
 * sanity-check on the input.
 */
void bufferAddCodepoints(Buffer buffer, Codepoint[] text, uint itemOffset, int itemLength)
{
  auto _text = cast(const(hb_codepoint_t)*)text.ptr;
  hb_buffer_add_codepoints(buffer ? buffer.cPtr!hb_buffer_t : null, _text, text ? cast(int)text.length : 0, itemOffset, itemLength);
}

/**
 * Similar to hb_buffer_add_codepoints(), but allows only access to first 256
 * Unicode code points that can fit in 8-bit strings.
 *
 * <note>Has nothing to do with non-Unicode Latin-1 encoding.</note>
 */
void bufferAddLatin1(Buffer buffer, ubyte[] text, uint itemOffset, int itemLength)
{
  auto _text = cast(const(ubyte)*)text.ptr;
  hb_buffer_add_latin1(buffer ? buffer.cPtr!hb_buffer_t : null, _text, text ? cast(int)text.length : 0, itemOffset, itemLength);
}

/**
 * See hb_buffer_add_codepoints().
 *
 * Replaces invalid UTF-16 characters with the @buffer replacement code point,
 * see hb_buffer_set_replacement_codepoint().
 */
void bufferAddUtf16(Buffer buffer, ushort[] text, uint itemOffset, int itemLength)
{
  auto _text = cast(const(ushort)*)text.ptr;
  hb_buffer_add_utf16(buffer ? buffer.cPtr!hb_buffer_t : null, _text, text ? cast(int)text.length : 0, itemOffset, itemLength);
}

/**
 * See hb_buffer_add_codepoints().
 *
 * Replaces invalid UTF-32 characters with the @buffer replacement code point,
 * see hb_buffer_set_replacement_codepoint().
 */
void bufferAddUtf32(Buffer buffer, uint[] text, uint itemOffset, int itemLength)
{
  auto _text = cast(const(uint)*)text.ptr;
  hb_buffer_add_utf32(buffer ? buffer.cPtr!hb_buffer_t : null, _text, text ? cast(int)text.length : 0, itemOffset, itemLength);
}

/**
 * See hb_buffer_add_codepoints().
 *
 * Replaces invalid UTF-8 characters with the @buffer replacement code point,
 * see hb_buffer_set_replacement_codepoint().
 */
void bufferAddUtf8(Buffer buffer, ubyte[] text, uint itemOffset, int itemLength)
{
  auto _text = cast(const(ubyte)*)text.ptr;
  hb_buffer_add_utf8(buffer ? buffer.cPtr!hb_buffer_t : null, _text, text ? cast(int)text.length : 0, itemOffset, itemLength);
}

/**
 * `true` if @buffer memory allocation succeeded, `false` otherwise.
 */
Bool bufferAllocationSuccessful(Buffer buffer)
{
  Bool _retval;
  _retval = hb_buffer_allocation_successful(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * Append (part of) contents of another buffer to this buffer.
 */
void bufferAppend(Buffer buffer, Buffer source, uint start, uint end)
{
  hb_buffer_append(buffer ? buffer.cPtr!hb_buffer_t : null, source ? source.cPtr!hb_buffer_t : null, start, end);
}

/**
 * Similar to hb_buffer_reset(), but does not clear the Unicode functions and
 * the replacement code point.
 */
void bufferClearContents(Buffer buffer)
{
  hb_buffer_clear_contents(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * A newly allocated #hb_buffer_t with a reference count of 1. The initial
 * reference count should be released with hb_buffer_destroy() when you are done
 * using the #hb_buffer_t. This function never returns `NULL`. If memory cannot
 * be allocated, a special #hb_buffer_t object will be returned on which
 * hb_buffer_allocation_successful() returns `false`.
 */
Buffer bufferCreate()
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_create();
  Buffer _retval = new Buffer(cast(hb_buffer_t*)_cretval, true);
  return _retval;
}

/**
 * A newly allocated #hb_buffer_t, similar to hb_buffer_create().
 */
Buffer bufferCreateSimilar(Buffer src)
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_create_similar(src ? src.cPtr!hb_buffer_t : null);
  Buffer _retval = new Buffer(cast(hb_buffer_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if parse was successful, `false` if an error
 * occurred.
 */
Bool bufferDeserializeGlyphs(Buffer buffer, string buf, out string endPtr, Font font, BufferSerializeFormat format)
{
  Bool _retval;
  auto _buf = cast(const(char)*)buf.ptr;
  char* _endPtr;
  _retval = hb_buffer_deserialize_glyphs(buffer ? buffer.cPtr!hb_buffer_t : null, _buf, buf ? cast(int)buf.length : 0, &_endPtr, font ? font.cPtr!hb_font_t : null, format);
  endPtr = _endPtr.fromCString(true);
  return _retval;
}

/**
 * `true` if parse was successful, `false` if an error
 * occurred.
 */
Bool bufferDeserializeUnicode(Buffer buffer, string buf, out string endPtr, BufferSerializeFormat format)
{
  Bool _retval;
  auto _buf = cast(const(char)*)buf.ptr;
  char* _endPtr;
  _retval = hb_buffer_deserialize_unicode(buffer ? buffer.cPtr!hb_buffer_t : null, _buf, buf ? cast(int)buf.length : 0, &_endPtr, format);
  endPtr = _endPtr.fromCString(true);
  return _retval;
}

/**
 * If dottedcircle_glyph is (hb_codepoint_t) -1 then #HB_BUFFER_DIFF_FLAG_DOTTED_CIRCLE_PRESENT
 * and #HB_BUFFER_DIFF_FLAG_NOTDEF_PRESENT are never returned.  This should be used by most
 * callers if just comparing two buffers is needed.
 */
BufferDiffFlags bufferDiff(Buffer buffer, Buffer reference, Codepoint dottedcircleGlyph, uint positionFuzz)
{
  hb_buffer_diff_flags_t _cretval;
  _cretval = hb_buffer_diff(buffer ? buffer.cPtr!hb_buffer_t : null, reference ? reference.cPtr!hb_buffer_t : null, dottedcircleGlyph, positionFuzz);
  BufferDiffFlags _retval = cast(BufferDiffFlags)_cretval;
  return _retval;
}

/**
 * The cluster level of @buffer
 */
BufferClusterLevel bufferGetClusterLevel(Buffer buffer)
{
  hb_buffer_cluster_level_t _cretval;
  _cretval = hb_buffer_get_cluster_level(buffer ? buffer.cPtr!hb_buffer_t : null);
  BufferClusterLevel _retval = cast(BufferClusterLevel)_cretval;
  return _retval;
}

/**
 * The type of @buffer contents
 */
BufferContentType bufferGetContentType(Buffer buffer)
{
  hb_buffer_content_type_t _cretval;
  _cretval = hb_buffer_get_content_type(buffer ? buffer.cPtr!hb_buffer_t : null);
  BufferContentType _retval = cast(BufferContentType)_cretval;
  return _retval;
}

/**
 * The direction of the @buffer.
 */
Direction bufferGetDirection(Buffer buffer)
{
  hb_direction_t _cretval;
  _cretval = hb_buffer_get_direction(buffer ? buffer.cPtr!hb_buffer_t : null);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * The empty buffer
 */
Buffer bufferGetEmpty()
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_get_empty();
  Buffer _retval = new Buffer(cast(hb_buffer_t*)_cretval, true);
  return _retval;
}

/**
 * The @buffer flags
 */
BufferFlags bufferGetFlags(Buffer buffer)
{
  hb_buffer_flags_t _cretval;
  _cretval = hb_buffer_get_flags(buffer ? buffer.cPtr!hb_buffer_t : null);
  BufferFlags _retval = cast(BufferFlags)_cretval;
  return _retval;
}

/**
 * The @buffer glyph information array.
 * The value valid as long as buffer has not been modified.
 */
GlyphInfo[] bufferGetGlyphInfos(Buffer buffer)
{
  hb_glyph_info_t* _cretval;
  uint _cretlength;
  _cretval = hb_buffer_get_glyph_infos(buffer ? buffer.cPtr!hb_buffer_t : null, &_cretlength);
  GlyphInfo[] _retval;

  if (_cretval)
  {
    _retval = new GlyphInfo[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = new GlyphInfo(cast(void*)&_cretval[i], false);
  }
  return _retval;
}

/**
 * The @buffer glyph position array.
 * The value valid as long as buffer has not been modified.
 */
GlyphPosition[] bufferGetGlyphPositions(Buffer buffer)
{
  hb_glyph_position_t* _cretval;
  uint _cretlength;
  _cretval = hb_buffer_get_glyph_positions(buffer ? buffer.cPtr!hb_buffer_t : null, &_cretlength);
  GlyphPosition[] _retval;

  if (_cretval)
  {
    _retval = new GlyphPosition[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = new GlyphPosition(cast(void*)&_cretval[i], false);
  }
  return _retval;
}

/**
 * The @buffer invisible #hb_codepoint_t
 */
Codepoint bufferGetInvisibleGlyph(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_invisible_glyph(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * The #hb_language_t of the buffer. Must not be freed by the caller.
 */
Language bufferGetLanguage(Buffer buffer)
{
  hb_language_t _cretval;
  _cretval = hb_buffer_get_language(buffer ? buffer.cPtr!hb_buffer_t : null);
  Language _retval = new Language(cast(hb_language_t)_cretval, false);
  return _retval;
}

/**
 * The @buffer length.
 * The value valid as long as buffer has not been modified.
 */
uint bufferGetLength(Buffer buffer)
{
  uint _retval;
  _retval = hb_buffer_get_length(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * The @buffer not-found #hb_codepoint_t
 */
Codepoint bufferGetNotFoundGlyph(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_not_found_glyph(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * The @buffer replacement #hb_codepoint_t
 */
Codepoint bufferGetReplacementCodepoint(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_replacement_codepoint(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * The #hb_script_t of the @buffer
 */
Script bufferGetScript(Buffer buffer)
{
  hb_script_t _cretval;
  _cretval = hb_buffer_get_script(buffer ? buffer.cPtr!hb_buffer_t : null);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * The Unicode-functions structure
 */
UnicodeFuncs bufferGetUnicodeFuncs(Buffer buffer)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_buffer_get_unicode_funcs(buffer ? buffer.cPtr!hb_buffer_t : null);
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * Sets unset buffer segment properties based on buffer Unicode
 * contents.  If buffer is not empty, it must have content type
 * #HB_BUFFER_CONTENT_TYPE_UNICODE.
 *
 * If buffer script is not set (ie. is #HB_SCRIPT_INVALID), it
 * will be set to the Unicode script of the first character in
 * the buffer that has a script other than #HB_SCRIPT_COMMON,
 * #HB_SCRIPT_INHERITED, and #HB_SCRIPT_UNKNOWN.
 *
 * Next, if buffer direction is not set (ie. is #HB_DIRECTION_INVALID),
 * it will be set to the natural horizontal direction of the
 * buffer script as returned by hb_script_get_horizontal_direction().
 * If hb_script_get_horizontal_direction() returns #HB_DIRECTION_INVALID,
 * then #HB_DIRECTION_LTR is used.
 *
 * Finally, if buffer language is not set (ie. is #HB_LANGUAGE_INVALID),
 * it will be set to the process's default language as returned by
 * hb_language_get_default().  This may change in the future by
 * taking buffer script into consideration when choosing a language.
 * Note that hb_language_get_default() is NOT threadsafe the first time
 * it is called.  See documentation for that function for details.
 */
void bufferGuessSegmentProperties(Buffer buffer)
{
  hb_buffer_guess_segment_properties(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * `true` if the @buffer has position array, `false` otherwise.
 */
Bool bufferHasPositions(Buffer buffer)
{
  Bool _retval;
  _retval = hb_buffer_has_positions(buffer ? buffer.cPtr!hb_buffer_t : null);
  return _retval;
}

/**
 * Reorders a glyph buffer to have canonical in-cluster glyph order / position.
 * The resulting clusters should behave identical to pre-reordering clusters.
 *
 * <note>This has nothing to do with Unicode normalization.</note>
 */
void bufferNormalizeGlyphs(Buffer buffer)
{
  hb_buffer_normalize_glyphs(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * `true` if @buffer memory allocation succeeded, `false` otherwise
 */
Bool bufferPreAllocate(Buffer buffer, uint size)
{
  Bool _retval;
  _retval = hb_buffer_pre_allocate(buffer ? buffer.cPtr!hb_buffer_t : null, size);
  return _retval;
}

/**
 * Resets the buffer to its initial status, as if it was just newly created
 * with hb_buffer_create().
 */
void bufferReset(Buffer buffer)
{
  hb_buffer_reset(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * Reverses buffer contents.
 */
void bufferReverse(Buffer buffer)
{
  hb_buffer_reverse(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * Reverses buffer clusters.  That is, the buffer contents are
 * reversed, then each cluster (consecutive items having the
 * same cluster number) are reversed again.
 */
void bufferReverseClusters(Buffer buffer)
{
  hb_buffer_reverse_clusters(buffer ? buffer.cPtr!hb_buffer_t : null);
}

/**
 * Reverses buffer contents between @start and @end.
 */
void bufferReverseRange(Buffer buffer, uint start, uint end)
{
  hb_buffer_reverse_range(buffer ? buffer.cPtr!hb_buffer_t : null, start, end);
}

/**
 * The parsed #hb_buffer_serialize_format_t.
 */
BufferSerializeFormat bufferSerializeFormatFromString(ubyte[] str)
{
  hb_buffer_serialize_format_t _cretval;
  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_buffer_serialize_format_from_string(_str, str ? cast(int)str.length : 0);
  BufferSerializeFormat _retval = cast(BufferSerializeFormat)_cretval;
  return _retval;
}

/**
 * A `NULL` terminated string corresponding to @format. Should not be freed.
 */
string bufferSerializeFormatToString(BufferSerializeFormat format)
{
  const(char)* _cretval;
  _cretval = hb_buffer_serialize_format_to_string(format);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * A string array of buffer serialization formats. Should not be freed.
 */
string[] bufferSerializeListFormats()
{
  const(char*)* _cretval;
  _cretval = hb_buffer_serialize_list_formats();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * Sets the cluster level of a buffer. The #hb_buffer_cluster_level_t
 * dictates one aspect of how HarfBuzz will treat non-base characters
 * during shaping.
 */
void bufferSetClusterLevel(Buffer buffer, BufferClusterLevel clusterLevel)
{
  hb_buffer_set_cluster_level(buffer ? buffer.cPtr!hb_buffer_t : null, clusterLevel);
}

/**
 * Sets the type of @buffer contents. Buffers are either empty, contain
 * characters (before shaping), or contain glyphs (the result of shaping).
 *
 * You rarely need to call this function, since a number of other
 * functions transition the content type for you. Namely:
 *
 * - A newly created buffer starts with content type
 * %HB_BUFFER_CONTENT_TYPE_INVALID. Calling hb_buffer_reset(),
 * hb_buffer_clear_contents(), as well as calling hb_buffer_set_length()
 * with an argument of zero all set the buffer content type to invalid
 * as well.
 *
 * - Calling hb_buffer_add_utf8(), hb_buffer_add_utf16(),
 * hb_buffer_add_utf32(), hb_buffer_add_codepoints() and
 * hb_buffer_add_latin1() expect that buffer is either empty and
 * have a content type of invalid, or that buffer content type is
 * %HB_BUFFER_CONTENT_TYPE_UNICODE, and they also set the content
 * type to Unicode if they added anything to an empty buffer.
 *
 * - Finally hb_shape() and hb_shape_full() expect that the buffer
 * is either empty and have content type of invalid, or that buffer
 * content type is %HB_BUFFER_CONTENT_TYPE_UNICODE, and upon
 * success they set the buffer content type to
 * %HB_BUFFER_CONTENT_TYPE_GLYPHS.
 *
 * The above transitions are designed such that one can use a buffer
 * in a loop of "reset : add-text : shape" without needing to ever
 * modify the content type manually.
 */
void bufferSetContentType(Buffer buffer, BufferContentType contentType)
{
  hb_buffer_set_content_type(buffer ? buffer.cPtr!hb_buffer_t : null, contentType);
}

/**
 * Set the text flow direction of the buffer. No shaping can happen without
 * setting @buffer direction, and it controls the visual direction for the
 * output glyphs; for RTL direction the glyphs will be reversed. Many layout
 * features depend on the proper setting of the direction, for example,
 * reversing RTL text before shaping, then shaping with LTR direction is not
 * the same as keeping the text in logical order and shaping with RTL
 * direction.
 */
void bufferSetDirection(Buffer buffer, Direction direction)
{
  hb_buffer_set_direction(buffer ? buffer.cPtr!hb_buffer_t : null, direction);
}

/**
 * Sets @buffer flags to @flags. See #hb_buffer_flags_t.
 */
void bufferSetFlags(Buffer buffer, BufferFlags flags)
{
  hb_buffer_set_flags(buffer ? buffer.cPtr!hb_buffer_t : null, flags);
}

/**
 * Sets the #hb_codepoint_t that replaces invisible characters in
 * the shaping result.  If set to zero (default), the glyph for the
 * U+0020 SPACE character is used.  Otherwise, this value is used
 * verbatim.
 */
void bufferSetInvisibleGlyph(Buffer buffer, Codepoint invisible)
{
  hb_buffer_set_invisible_glyph(buffer ? buffer.cPtr!hb_buffer_t : null, invisible);
}

/**
 * Sets the language of @buffer to @language.
 *
 * Languages are crucial for selecting which OpenType feature to apply to the
 * buffer which can result in applying language-specific behaviour. Languages
 * are orthogonal to the scripts, and though they are related, they are
 * different concepts and should not be confused with each other.
 *
 * Use hb_language_from_string() to convert from BCP 47 language tags to
 * #hb_language_t.
 */
void bufferSetLanguage(Buffer buffer, Language language)
{
  hb_buffer_set_language(buffer ? buffer.cPtr!hb_buffer_t : null, language ? language.cPtr!hb_language_t : null);
}

/**
 * `true` if @buffer memory allocation succeeded, `false` otherwise.
 */
Bool bufferSetLength(Buffer buffer, uint length)
{
  Bool _retval;
  _retval = hb_buffer_set_length(buffer ? buffer.cPtr!hb_buffer_t : null, length);
  return _retval;
}

/**
 * Sets the implementation function for #hb_buffer_message_func_t.
 */
void bufferSetMessageFunc(Buffer buffer, BufferMessageFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_buffer_t* buffer, hb_font_t* font, const(char)* message, void* userData)
  {
    string _message = message.fromCString(false);

    hb_bool_t _retval = (*(cast(BufferMessageFunc*)userData))(buffer ? new Buffer(buffer, false) : null, font ? new Font(font, false) : null, _message);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_buffer_set_message_func(buffer ? buffer.cPtr!hb_buffer_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the #hb_codepoint_t that replaces characters not found in
 * the font during shaping.
 *
 * The not-found glyph defaults to zero, sometimes knows as the
 * ".notdef" glyph.  This API allows for differentiating the two.
 */
void bufferSetNotFoundGlyph(Buffer buffer, Codepoint notFound)
{
  hb_buffer_set_not_found_glyph(buffer ? buffer.cPtr!hb_buffer_t : null, notFound);
}

/**
 * Sets the #hb_codepoint_t that replaces invalid entries for a given encoding
 * when adding text to @buffer.
 *
 * Default is #HB_BUFFER_REPLACEMENT_CODEPOINT_DEFAULT.
 */
void bufferSetReplacementCodepoint(Buffer buffer, Codepoint replacement)
{
  hb_buffer_set_replacement_codepoint(buffer ? buffer.cPtr!hb_buffer_t : null, replacement);
}

/**
 * Sets the script of @buffer to @script.
 *
 * Script is crucial for choosing the proper shaping behaviour for scripts that
 * require it (e.g. Arabic) and the which OpenType features defined in the font
 * to be applied.
 *
 * You can pass one of the predefined #hb_script_t values, or use
 * hb_script_from_string() or hb_script_from_iso15924_tag() to get the
 * corresponding script from an ISO 15924 script tag.
 */
void bufferSetScript(Buffer buffer, Script script)
{
  hb_buffer_set_script(buffer ? buffer.cPtr!hb_buffer_t : null, script);
}

/**
 * Sets the segment properties of the buffer, a shortcut for calling
 * hb_buffer_set_direction(), hb_buffer_set_script() and
 * hb_buffer_set_language() individually.
 */
void bufferSetSegmentProperties(Buffer buffer, SegmentProperties props)
{
  hb_buffer_set_segment_properties(buffer ? buffer.cPtr!hb_buffer_t : null, props ? props.cPtr!hb_segment_properties_t : null);
}

/**
 * Sets the Unicode-functions structure of a buffer to
 * @unicode_funcs.
 */
void bufferSetUnicodeFuncs(Buffer buffer, UnicodeFuncs unicodeFuncs)
{
  hb_buffer_set_unicode_funcs(buffer ? buffer.cPtr!hb_buffer_t : null, unicodeFuncs ? unicodeFuncs.cPtr!hb_unicode_funcs_t : null);
}

/**
 * Alpha channel value
 */
ubyte colorGetAlpha(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_alpha(color);
  return _retval;
}

/**
 * Blue channel value
 */
ubyte colorGetBlue(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_blue(color);
  return _retval;
}

/**
 * Green channel value
 */
ubyte colorGetGreen(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_green(color);
  return _retval;
}

/**
 * Red channel value
 */
ubyte colorGetRed(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_red(color);
  return _retval;
}

/**
 * the total number of color stops in @color_line
 */
uint colorLineGetColorStops(ColorLine colorLine, uint start, ref ColorStop[] colorStops)
{
  uint _retval;
  auto _count = colorStops ? cast(uint)colorStops.length : 0;
  hb_color_stop_t[] _colorStops;
  _colorStops.length = _count;
  _retval = hb_color_line_get_color_stops(colorLine ? colorLine.cPtr!hb_color_line_t : null, start, &_count, _colorStops.ptr);
  colorStops.length = _count;
  foreach (i; 0 .. _count)
    colorStops[i] = new ColorStop(cast(void*)&_colorStops[i], false);
  return _retval;
}

/**
 * the extend mode of @color_line
 */
PaintExtend colorLineGetExtend(ColorLine colorLine)
{
  hb_paint_extend_t _cretval;
  _cretval = hb_color_line_get_extend(colorLine ? colorLine.cPtr!hb_color_line_t : null);
  PaintExtend _retval = cast(PaintExtend)_cretval;
  return _retval;
}

/**
 * The #hb_direction_t matching @str
 */
Direction directionFromString(ubyte[] str)
{
  hb_direction_t _cretval;
  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_direction_from_string(_str, str ? cast(int)str.length : 0);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * The string corresponding to @direction
 */
string directionToString(Direction direction)
{
  const(char)* _cretval;
  _cretval = hb_direction_to_string(direction);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Perform a "close-path" draw operation.
 */
void drawClosePath(DrawFuncs dfuncs, void* drawData, DrawState st)
{
  hb_draw_close_path(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData, st ? st.cPtr!hb_draw_state_t : null);
}

/**
 * Perform a "cubic-to" draw operation.
 */
void drawCubicTo(DrawFuncs dfuncs, void* drawData, DrawState st, float control1X, float control1Y, float control2X, float control2Y, float toX, float toY)
{
  hb_draw_cubic_to(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData, st ? st.cPtr!hb_draw_state_t : null, control1X, control1Y, control2X, control2Y, toX, toY);
}

/**
 * A newly allocated #hb_draw_funcs_t with a reference count of 1. The initial
 * reference count should be released with hb_draw_funcs_destroy when you are
 * done using the #hb_draw_funcs_t. This function never returns `NULL`. If
 * memory cannot be allocated, a special singleton #hb_draw_funcs_t object will
 * be returned.
 */
DrawFuncs drawFuncsCreate()
{
  hb_draw_funcs_t* _cretval;
  _cretval = hb_draw_funcs_create();
  DrawFuncs _retval = new DrawFuncs(cast(hb_draw_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * The empty draw-functions structure
 */
DrawFuncs drawFuncsGetEmpty()
{
  hb_draw_funcs_t* _cretval;
  _cretval = hb_draw_funcs_get_empty();
  DrawFuncs _retval = new DrawFuncs(cast(hb_draw_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if @dfuncs is immutable, `false` otherwise
 */
Bool drawFuncsIsImmutable(DrawFuncs dfuncs)
{
  Bool _retval;
  _retval = hb_draw_funcs_is_immutable(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null);
  return _retval;
}

/**
 * Makes @dfuncs object immutable.
 */
void drawFuncsMakeImmutable(DrawFuncs dfuncs)
{
  hb_draw_funcs_make_immutable(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null);
}

/**
 * Sets close-path callback to the draw functions object.
 */
void drawFuncsSetClosePathFunc(DrawFuncs dfuncs, DrawClosePathFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, void* userData)
  {
    (*(cast(DrawClosePathFunc*)userData))(dfuncs ? new DrawFuncs(dfuncs, false) : null, drawData, st ? new DrawState(st, false) : null);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_draw_funcs_set_close_path_func(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets cubic-to callback to the draw functions object.
 */
void drawFuncsSetCubicToFunc(DrawFuncs dfuncs, DrawCubicToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float control1X, float control1Y, float control2X, float control2Y, float toX, float toY, void* userData)
  {
    (*(cast(DrawCubicToFunc*)userData))(dfuncs ? new DrawFuncs(dfuncs, false) : null, drawData, st ? new DrawState(st, false) : null, control1X, control1Y, control2X, control2Y, toX, toY);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_draw_funcs_set_cubic_to_func(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets line-to callback to the draw functions object.
 */
void drawFuncsSetLineToFunc(DrawFuncs dfuncs, DrawLineToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float toX, float toY, void* userData)
  {
    (*(cast(DrawLineToFunc*)userData))(dfuncs ? new DrawFuncs(dfuncs, false) : null, drawData, st ? new DrawState(st, false) : null, toX, toY);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_draw_funcs_set_line_to_func(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets move-to callback to the draw functions object.
 */
void drawFuncsSetMoveToFunc(DrawFuncs dfuncs, DrawMoveToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float toX, float toY, void* userData)
  {
    (*(cast(DrawMoveToFunc*)userData))(dfuncs ? new DrawFuncs(dfuncs, false) : null, drawData, st ? new DrawState(st, false) : null, toX, toY);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_draw_funcs_set_move_to_func(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets quadratic-to callback to the draw functions object.
 */
void drawFuncsSetQuadraticToFunc(DrawFuncs dfuncs, DrawQuadraticToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float controlX, float controlY, float toX, float toY, void* userData)
  {
    (*(cast(DrawQuadraticToFunc*)userData))(dfuncs ? new DrawFuncs(dfuncs, false) : null, drawData, st ? new DrawState(st, false) : null, controlX, controlY, toX, toY);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_draw_funcs_set_quadratic_to_func(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Perform a "line-to" draw operation.
 */
void drawLineTo(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY)
{
  hb_draw_line_to(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData, st ? st.cPtr!hb_draw_state_t : null, toX, toY);
}

/**
 * Perform a "move-to" draw operation.
 */
void drawMoveTo(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY)
{
  hb_draw_move_to(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData, st ? st.cPtr!hb_draw_state_t : null, toX, toY);
}

/**
 * Perform a "quadratic-to" draw operation.
 */
void drawQuadraticTo(DrawFuncs dfuncs, void* drawData, DrawState st, float controlX, float controlY, float toX, float toY)
{
  hb_draw_quadratic_to(dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData, st ? st.cPtr!hb_draw_state_t : null, controlX, controlY, toX, toY);
}

/**
 * Add table for @tag with data provided by @blob to the face.  @face must
 * be created using hb_face_builder_create().
 */
Bool faceBuilderAddTable(HBFace face, Tag tag, Blob blob)
{
  Bool _retval;
  _retval = hb_face_builder_add_table(face ? face.cPtr!hb_face_t : null, tag, blob ? blob.cPtr!hb_blob_t : null);
  return _retval;
}

/**
 * New face.
 */
HBFace faceBuilderCreate()
{
  hb_face_t* _cretval;
  _cretval = hb_face_builder_create();
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * Set the ordering of tables for serialization. Any tables not
 * specified in the tags list will be ordered after the tables in
 * tags, ordered by the default sort ordering.
 */
void faceBuilderSortTables(HBFace face, Tag[] tags)
{
  auto _tags = cast(const(hb_tag_t)*)(tags ~ 0).ptr;
  hb_face_builder_sort_tables(face ? face.cPtr!hb_face_t : null, _tags);
}

/**
 * Number of faces in @blob
 */
uint faceCount(Blob blob)
{
  uint _retval;
  _retval = hb_face_count(blob ? blob.cPtr!hb_blob_t : null);
  return _retval;
}

/**
 * The new face object
 */
HBFace faceCreate(Blob blob, uint index)
{
  hb_face_t* _cretval;
  _cretval = hb_face_create(blob ? blob.cPtr!hb_blob_t : null, index);
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * The new face object
 */
HBFace faceCreateForTables(ReferenceTableFunc referenceTableFunc)
{
  extern(C) hb_blob_t* _referenceTableFuncCallback(hb_face_t* face, hb_tag_t tag, void* userData)
  {
    Blob _dretval;

    _dretval = (*(cast(ReferenceTableFunc*)userData))(face ? new HBFace(face, false) : null, tag);
    hb_blob_t* _retval = _dretval.cPtr!hb_blob_t(true);

    return _retval;
  }

  hb_face_t* _cretval;
  ptrFreezeGC(cast(void*)&referenceTableFunc);
  _cretval = hb_face_create_for_tables(&_referenceTableFuncCallback, cast(void*)&referenceTableFunc, &ptrThawDestroyNotify);
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * The empty face object
 */
HBFace faceGetEmpty()
{
  hb_face_t* _cretval;
  _cretval = hb_face_get_empty();
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * The glyph-count value of @face
 */
uint faceGetGlyphCount(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_glyph_count(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * The index of @face.
 */
uint faceGetIndex(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_index(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * Total number of tables, or zero if it is not possible to list
 */
uint faceGetTableTags(HBFace face, uint startOffset, ref Tag[] tableTags)
{
  uint _retval;
  auto _tableCount = tableTags ? cast(uint)tableTags.length : 0;
  _retval = hb_face_get_table_tags(face ? face.cPtr!hb_face_t : null, startOffset, &_tableCount, tableTags.ptr);
  return _retval;
}

/**
 * The upem value of @face
 */
uint faceGetUpem(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_upem(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` is @face is immutable, `false` otherwise
 */
Bool faceIsImmutable(HBFace face)
{
  Bool _retval;
  _retval = hb_face_is_immutable(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * Makes the given face object immutable.
 */
void faceMakeImmutable(HBFace face)
{
  hb_face_make_immutable(face ? face.cPtr!hb_face_t : null);
}

/**
 * A pointer to the blob for @face
 */
Blob faceReferenceBlob(HBFace face)
{
  hb_blob_t* _cretval;
  _cretval = hb_face_reference_blob(face ? face.cPtr!hb_face_t : null);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * A pointer to the @tag table within @face
 */
Blob faceReferenceTable(HBFace face, Tag tag)
{
  hb_blob_t* _cretval;
  _cretval = hb_face_reference_table(face ? face.cPtr!hb_face_t : null, tag);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * Sets the glyph count for a face object to the specified value.
 *
 * This API is used in rare circumstances.
 */
void faceSetGlyphCount(HBFace face, uint glyphCount)
{
  hb_face_set_glyph_count(face ? face.cPtr!hb_face_t : null, glyphCount);
}

/**
 * Assigns the specified face-index to @face. Fails if the
 * face is immutable.
 *
 * <note>Note: changing the index has no effect on the face itself
 * This only changes the value returned by hb_face_get_index().</note>
 */
void faceSetIndex(HBFace face, uint index)
{
  hb_face_set_index(face ? face.cPtr!hb_face_t : null, index);
}

/**
 * Sets the units-per-em (upem) for a face object to the specified value.
 *
 * This API is used in rare circumstances.
 */
void faceSetUpem(HBFace face, uint upem)
{
  hb_face_set_upem(face ? face.cPtr!hb_face_t : null, upem);
}

/**
 * Adds the origin coordinates to an (X,Y) point coordinate, in
 * the specified glyph ID in the specified font.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontAddGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, inout Position x, inout Position y)
{
  hb_font_add_glyph_origin_for_direction(font ? font.cPtr!hb_font_t : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Notifies the @font that underlying font data has changed.
 * This has the effect of increasing the serial as returned
 * by hb_font_get_serial(), which invalidates internal caches.
 */
void fontChanged(Font font)
{
  hb_font_changed(font ? font.cPtr!hb_font_t : null);
}

/**
 * The new font object
 */
Font fontCreate(HBFace face)
{
  hb_font_t* _cretval;
  _cretval = hb_font_create(face ? face.cPtr!hb_face_t : null);
  Font _retval = new Font(cast(hb_font_t*)_cretval, true);
  return _retval;
}

/**
 * The new sub-font font object
 */
Font fontCreateSubFont(Font parent)
{
  hb_font_t* _cretval;
  _cretval = hb_font_create_sub_font(parent ? parent.cPtr!hb_font_t : null);
  Font _retval = new Font(cast(hb_font_t*)_cretval, true);
  return _retval;
}

/**
 * Draws the outline that corresponds to a glyph in the specified @font.
 *
 * The outline is returned by way of calls to the callbacks of the @dfuncs
 * objects, with @draw_data passed to them.
 */
void fontDrawGlyph(Font font, Codepoint glyph, DrawFuncs dfuncs, void* drawData)
{
  hb_font_draw_glyph(font ? font.cPtr!hb_font_t : null, glyph, dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData);
}

/**
 * The font-functions structure
 */
FontFuncs fontFuncsCreate()
{
  hb_font_funcs_t* _cretval;
  _cretval = hb_font_funcs_create();
  FontFuncs _retval = new FontFuncs(cast(hb_font_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * The font-functions structure
 */
FontFuncs fontFuncsGetEmpty()
{
  hb_font_funcs_t* _cretval;
  _cretval = hb_font_funcs_get_empty();
  FontFuncs _retval = new FontFuncs(cast(hb_font_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if @ffuncs is immutable, `false` otherwise
 */
Bool fontFuncsIsImmutable(FontFuncs ffuncs)
{
  Bool _retval;
  _retval = hb_font_funcs_is_immutable(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null);
  return _retval;
}

/**
 * Makes a font-functions structure immutable.
 */
void fontFuncsMakeImmutable(FontFuncs ffuncs)
{
  hb_font_funcs_make_immutable(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null);
}

/**
 * Sets the implementation function for #hb_font_draw_glyph_func_t.
 */
void fontFuncsSetDrawGlyphFunc(FontFuncs ffuncs, FontDrawGlyphFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_draw_funcs_t* drawFuncs, void* drawData, void* userData)
  {
    (*(cast(FontDrawGlyphFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, drawFuncs ? new DrawFuncs(drawFuncs, false) : null, drawData);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_draw_glyph_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_font_h_extents_func_t.
 */
void fontFuncsSetFontHExtentsFunc(FontFuncs ffuncs, FontGetFontHExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_font_extents_t* extents, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetFontHExtentsFunc*)userData))(font ? new Font(font, false) : null, fontData, *extents);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_font_h_extents_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_font_v_extents_func_t.
 */
void fontFuncsSetFontVExtentsFunc(FontFuncs ffuncs, FontGetFontVExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_font_extents_t* extents, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetFontVExtentsFunc*)userData))(font ? new Font(font, false) : null, fontData, *extents);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_font_v_extents_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_contour_point_func_t.
 */
void fontFuncsSetGlyphContourPointFunc(FontFuncs ffuncs, FontGetGlyphContourPointFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, uint pointIndex, hb_position_t* x, hb_position_t* y, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetGlyphContourPointFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, pointIndex, *x, *y);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_contour_point_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_extents_func_t.
 */
void fontFuncsSetGlyphExtentsFunc(FontFuncs ffuncs, FontGetGlyphExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_glyph_extents_t* extents, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetGlyphExtentsFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, *extents);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_extents_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_from_name_func_t.
 */
void fontFuncsSetGlyphFromNameFunc(FontFuncs ffuncs, FontGetGlyphFromNameFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, const(char)* name, int len, hb_codepoint_t* glyph, void* userData)
  {
    char[] _name;
    _name = cast(char[])name[0 .. len];

    hb_bool_t _retval = (*(cast(FontGetGlyphFromNameFunc*)userData))(font ? new Font(font, false) : null, fontData, _name, *glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_from_name_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Deprecated.  Use hb_font_funcs_set_nominal_glyph_func() and
 * hb_font_funcs_set_variation_glyph_func() instead.
 */
void fontFuncsSetGlyphFunc(FontFuncs ffuncs, FontGetGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t variationSelector, hb_codepoint_t* glyph, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetGlyphFunc*)userData))(font ? new Font(font, false) : null, fontData, unicode, variationSelector, *glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_advance_func_t.
 */
void fontFuncsSetGlyphHAdvanceFunc(FontFuncs ffuncs, FontGetGlyphHAdvanceFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, void* userData)
  {
    hb_position_t _retval = (*(cast(FontGetGlyphHAdvanceFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_h_advance_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_kerning_func_t.
 */
void fontFuncsSetGlyphHKerningFunc(FontFuncs ffuncs, FontGetGlyphHKerningFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t firstGlyph, hb_codepoint_t secondGlyph, void* userData)
  {
    hb_position_t _retval = (*(cast(FontGetGlyphHKerningFunc*)userData))(font ? new Font(font, false) : null, fontData, firstGlyph, secondGlyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_h_kerning_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_origin_func_t.
 */
void fontFuncsSetGlyphHOriginFunc(FontFuncs ffuncs, FontGetGlyphHOriginFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_position_t* x, hb_position_t* y, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetGlyphHOriginFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, *x, *y);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_h_origin_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_name_func_t.
 */
void fontFuncsSetGlyphNameFunc(FontFuncs ffuncs, FontGetGlyphNameFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, char* name, uint size, void* userData)
  {
    char[] _name;

    hb_bool_t _retval = (*(cast(FontGetGlyphNameFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, _name);
    size = cast(uint)_name.length;
    name = arrayDtoC!(char, Yes.UseMalloc, No.ZeroTerm)(_name);

    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_name_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_shape_func_t,
 * which is the same as #hb_font_draw_glyph_func_t.
 */
void fontFuncsSetGlyphShapeFunc(FontFuncs ffuncs, FontGetGlyphShapeFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_draw_funcs_t* drawFuncs, void* drawData, void* userData)
  {
    (*(cast(FontGetGlyphShapeFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, drawFuncs ? new DrawFuncs(drawFuncs, false) : null, drawData);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_shape_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_advance_func_t.
 */
void fontFuncsSetGlyphVAdvanceFunc(FontFuncs ffuncs, FontGetGlyphVAdvanceFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, void* userData)
  {
    hb_position_t _retval = (*(cast(FontGetGlyphVAdvanceFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_v_advance_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_kerning_func_t.
 */
void fontFuncsSetGlyphVKerningFunc(FontFuncs ffuncs, FontGetGlyphVKerningFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t firstGlyph, hb_codepoint_t secondGlyph, void* userData)
  {
    hb_position_t _retval = (*(cast(FontGetGlyphVKerningFunc*)userData))(font ? new Font(font, false) : null, fontData, firstGlyph, secondGlyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_v_kerning_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_origin_func_t.
 */
void fontFuncsSetGlyphVOriginFunc(FontFuncs ffuncs, FontGetGlyphVOriginFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_position_t* x, hb_position_t* y, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetGlyphVOriginFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, *x, *y);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_glyph_v_origin_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_nominal_glyph_func_t.
 */
void fontFuncsSetNominalGlyphFunc(FontFuncs ffuncs, FontGetNominalGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t* glyph, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetNominalGlyphFunc*)userData))(font ? new Font(font, false) : null, fontData, unicode, *glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_nominal_glyph_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_paint_glyph_func_t.
 */
void fontFuncsSetPaintGlyphFunc(FontFuncs ffuncs, FontPaintGlyphFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_paint_funcs_t* paintFuncs, void* paintData, uint paletteIndex, hb_color_t foreground, void* userData)
  {
    (*(cast(FontPaintGlyphFunc*)userData))(font ? new Font(font, false) : null, fontData, glyph, paintFuncs ? new PaintFuncs(paintFuncs, false) : null, paintData, paletteIndex, foreground);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_paint_glyph_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_font_get_variation_glyph_func_t.
 */
void fontFuncsSetVariationGlyphFunc(FontFuncs ffuncs, FontGetVariationGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t variationSelector, hb_codepoint_t* glyph, void* userData)
  {
    hb_bool_t _retval = (*(cast(FontGetVariationGlyphFunc*)userData))(font ? new Font(font, false) : null, fontData, unicode, variationSelector, *glyph);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_font_funcs_set_variation_glyph_func(ffuncs ? ffuncs.cPtr!hb_font_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * The empty font object
 */
Font fontGetEmpty()
{
  hb_font_t* _cretval;
  _cretval = hb_font_get_empty();
  Font _retval = new Font(cast(hb_font_t*)_cretval, true);
  return _retval;
}

/**
 * Fetches the extents for a font in a text segment of the
 * specified direction.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontGetExtentsForDirection(Font font, Direction direction, out FontExtents extents)
{
  hb_font_get_extents_for_direction(font ? font.cPtr!hb_font_t : null, direction, &extents);
}

/**
 * The #hb_face_t value
 */
HBFace fontGetFace(Font font)
{
  hb_face_t* _cretval;
  _cretval = hb_font_get_face(font ? font.cPtr!hb_font_t : null);
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, false);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyph(Font font, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_glyph(font ? font.cPtr!hb_font_t : null, unicode, variationSelector, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Fetches the advance for a glyph ID from the specified font,
 * in a text segment of the specified direction.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontGetGlyphAdvanceForDirection(Font font, Codepoint glyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_advance_for_direction(font ? font.cPtr!hb_font_t : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphContourPoint(Font font, Codepoint glyph, uint pointIndex, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_contour_point(font ? font.cPtr!hb_font_t : null, glyph, pointIndex, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphContourPointForOrigin(Font font, Codepoint glyph, uint pointIndex, Direction direction, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_contour_point_for_origin(font ? font.cPtr!hb_font_t : null, glyph, pointIndex, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphExtents(Font font, Codepoint glyph, out GlyphExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_glyph_extents(font ? font.cPtr!hb_font_t : null, glyph, &extents);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphExtentsForOrigin(Font font, Codepoint glyph, Direction direction, out GlyphExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_glyph_extents_for_origin(font ? font.cPtr!hb_font_t : null, glyph, direction, &extents);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphFromName(Font font, string name, out Codepoint glyph)
{
  Bool _retval;
  auto _name = cast(const(char)*)name.ptr;
  _retval = hb_font_get_glyph_from_name(font ? font.cPtr!hb_font_t : null, _name, name ? cast(int)name.length : 0, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * The advance of @glyph within @font
 */
Position fontGetGlyphHAdvance(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_h_advance(font ? font.cPtr!hb_font_t : null, glyph);
  return _retval;
}

/**
 * The kerning adjustment value
 */
Position fontGetGlyphHKerning(Font font, Codepoint leftGlyph, Codepoint rightGlyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_h_kerning(font ? font.cPtr!hb_font_t : null, leftGlyph, rightGlyph);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphHOrigin(Font font, Codepoint glyph, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_h_origin(font ? font.cPtr!hb_font_t : null, glyph, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * Fetches the kerning-adjustment value for a glyph-pair in the specified font.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontGetGlyphKerningForDirection(Font font, Codepoint firstGlyph, Codepoint secondGlyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_kerning_for_direction(font ? font.cPtr!hb_font_t : null, firstGlyph, secondGlyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Fetches the (X,Y) coordinates of the origin for a glyph in
 * the specified font.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontGetGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_origin_for_direction(font ? font.cPtr!hb_font_t : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Fetches the glyph shape that corresponds to a glyph in the specified @font.
 * The shape is returned by way of calls to the callbacks of the @dfuncs
 * objects, with @draw_data passed to them.
 */
void fontGetGlyphShape(Font font, Codepoint glyph, DrawFuncs dfuncs, void* drawData)
{
  hb_font_get_glyph_shape(font ? font.cPtr!hb_font_t : null, glyph, dfuncs ? dfuncs.cPtr!hb_draw_funcs_t : null, drawData);
}

/**
 * The advance of @glyph within @font
 */
Position fontGetGlyphVAdvance(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_v_advance(font ? font.cPtr!hb_font_t : null, glyph);
  return _retval;
}

/**
 * The kerning adjustment value
 */
Position fontGetGlyphVKerning(Font font, Codepoint topGlyph, Codepoint bottomGlyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_v_kerning(font ? font.cPtr!hb_font_t : null, topGlyph, bottomGlyph);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetGlyphVOrigin(Font font, Codepoint glyph, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_v_origin(font ? font.cPtr!hb_font_t : null, glyph, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetHExtents(Font font, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_h_extents(font ? font.cPtr!hb_font_t : null, &extents);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetNominalGlyph(Font font, Codepoint unicode, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_nominal_glyph(font ? font.cPtr!hb_font_t : null, unicode, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * The parent font object
 */
Font fontGetParent(Font font)
{
  hb_font_t* _cretval;
  _cretval = hb_font_get_parent(font ? font.cPtr!hb_font_t : null);
  Font _retval = new Font(cast(hb_font_t*)_cretval, false);
  return _retval;
}

/**
 * Fetches the horizontal and vertical points-per-em (ppem) of a font.
 */
void fontGetPpem(Font font, out uint xPpem, out uint yPpem)
{
  hb_font_get_ppem(font ? font.cPtr!hb_font_t : null, cast(uint*)&xPpem, cast(uint*)&yPpem);
}

/**
 * Point size.  A value of zero means "not set."
 */
float fontGetPtem(Font font)
{
  float _retval;
  _retval = hb_font_get_ptem(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * Fetches the horizontal and vertical scale of a font.
 */
void fontGetScale(Font font, out int xScale, out int yScale)
{
  hb_font_get_scale(font ? font.cPtr!hb_font_t : null, cast(int*)&xScale, cast(int*)&yScale);
}

/**
 * serial number
 */
uint fontGetSerial(Font font)
{
  uint _retval;
  _retval = hb_font_get_serial(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * Fetches the "synthetic boldness" parameters of a font.
 */
void fontGetSyntheticBold(Font font, out float xEmbolden, out float yEmbolden, out Bool inPlace)
{
  hb_font_get_synthetic_bold(font ? font.cPtr!hb_font_t : null, cast(float*)&xEmbolden, cast(float*)&yEmbolden, cast(hb_bool_t*)&inPlace);
}

/**
 * Synthetic slant.  By default is zero.
 */
float fontGetSyntheticSlant(Font font)
{
  float _retval;
  _retval = hb_font_get_synthetic_slant(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetVExtents(Font font, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_v_extents(font ? font.cPtr!hb_font_t : null, &extents);
  return _retval;
}

/**
 * Named-instance index or %HB_FONT_NO_VAR_NAMED_INSTANCE.
 */
uint fontGetVarNamedInstance(Font font)
{
  uint _retval;
  _retval = hb_font_get_var_named_instance(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGetVariationGlyph(Font font, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_variation_glyph(font ? font.cPtr!hb_font_t : null, unicode, variationSelector, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool fontGlyphFromString(Font font, ubyte[] s, out Codepoint glyph)
{
  Bool _retval;
  auto _s = cast(const(ubyte)*)s.ptr;
  _retval = hb_font_glyph_from_string(font ? font.cPtr!hb_font_t : null, _s, s ? cast(int)s.length : 0, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * `true` if @font is immutable, `false` otherwise
 */
Bool fontIsImmutable(Font font)
{
  Bool _retval;
  _retval = hb_font_is_immutable(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * Makes @font immutable.
 */
void fontMakeImmutable(Font font)
{
  hb_font_make_immutable(font ? font.cPtr!hb_font_t : null);
}

/**
 * Paints the glyph.
 *
 * The painting instructions are returned by way of calls to
 * the callbacks of the @funcs object, with @paint_data passed
 * to them.
 *
 * If the font has color palettes (see hb_ot_color_has_palettes()),
 * then @palette_index selects the palette to use. If the font only
 * has one palette, this will be 0.
 */
void fontPaintGlyph(Font font, Codepoint glyph, PaintFuncs pfuncs, void* paintData, uint paletteIndex, Color foreground)
{
  hb_font_paint_glyph(font ? font.cPtr!hb_font_t : null, glyph, pfuncs ? pfuncs.cPtr!hb_paint_funcs_t : null, paintData, paletteIndex, foreground);
}

/**
 * Sets @face as the font-face value of @font.
 */
void fontSetFace(Font font, HBFace face)
{
  hb_font_set_face(font ? font.cPtr!hb_font_t : null, face ? face.cPtr!hb_face_t : null);
}

/**
 * Sets the parent font of @font.
 */
void fontSetParent(Font font, Font parent)
{
  hb_font_set_parent(font ? font.cPtr!hb_font_t : null, parent ? parent.cPtr!hb_font_t : null);
}

/**
 * Sets the horizontal and vertical pixels-per-em (PPEM) of a font.
 *
 * These values are used for pixel-size-specific adjustment to
 * shaping and draw results, though for the most part they are
 * unused and can be left unset.
 */
void fontSetPpem(Font font, uint xPpem, uint yPpem)
{
  hb_font_set_ppem(font ? font.cPtr!hb_font_t : null, xPpem, yPpem);
}

/**
 * Sets the "point size" of a font. Set to zero to unset.
 * Used in CoreText to implement optical sizing.
 *
 * <note>Note: There are 72 points in an inch.</note>
 */
void fontSetPtem(Font font, float ptem)
{
  hb_font_set_ptem(font ? font.cPtr!hb_font_t : null, ptem);
}

/**
 * Sets the horizontal and vertical scale of a font.
 *
 * The font scale is a number related to, but not the same as,
 * font size. Typically the client establishes a scale factor
 * to be used between the two. For example, 64, or 256, which
 * would be the fractional-precision part of the font scale.
 * This is necessary because #hb_position_t values are integer
 * types and you need to leave room for fractional values
 * in there.
 *
 * For example, to set the font size to 20, with 64
 * levels of fractional precision you would call
 * `hb_font_set_scale(font, 20 * 64, 20 * 64)`.
 *
 * In the example above, even what font size 20 means is up to
 * you. It might be 20 pixels, or 20 points, or 20 millimeters.
 * HarfBuzz does not care about that.  You can set the point
 * size of the font using hb_font_set_ptem(), and the pixel
 * size using hb_font_set_ppem().
 *
 * The choice of scale is yours but needs to be consistent between
 * what you set here, and what you expect out of #hb_position_t
 * as well has draw / paint API output values.
 *
 * Fonts default to a scale equal to the UPEM value of their face.
 * A font with this setting is sometimes called an "unscaled" font.
 */
void fontSetScale(Font font, int xScale, int yScale)
{
  hb_font_set_scale(font ? font.cPtr!hb_font_t : null, xScale, yScale);
}

/**
 * Sets the "synthetic boldness" of a font.
 *
 * Positive values for @x_embolden / @y_embolden make a font
 * bolder, negative values thinner. Typical values are in the
 * 0.01 to 0.05 range. The default value is zero.
 *
 * Synthetic boldness is applied by offsetting the contour
 * points of the glyph shape.
 *
 * Synthetic boldness is applied when rendering a glyph via
 * hb_font_draw_glyph().
 *
 * If @in_place is `false`, then glyph advance-widths are also
 * adjusted, otherwise they are not.  The in-place mode is
 * useful for simulating [font grading](https://fonts.google.com/knowledge/glossary/grade).
 */
void fontSetSyntheticBold(Font font, float xEmbolden, float yEmbolden, Bool inPlace)
{
  hb_font_set_synthetic_bold(font ? font.cPtr!hb_font_t : null, xEmbolden, yEmbolden, inPlace);
}

/**
 * Sets the "synthetic slant" of a font.  By default is zero.
 * Synthetic slant is the graphical skew applied to the font
 * at rendering time.
 *
 * HarfBuzz needs to know this value to adjust shaping results,
 * metrics, and style values to match the slanted rendering.
 *
 * <note>Note: The glyph shape fetched via the hb_font_draw_glyph()
 * function is slanted to reflect this value as well.</note>
 *
 * <note>Note: The slant value is a ratio.  For example, a
 * 20% slant would be represented as a 0.2 value.</note>
 */
void fontSetSyntheticSlant(Font font, float slant)
{
  hb_font_set_synthetic_slant(font ? font.cPtr!hb_font_t : null, slant);
}

/**
 * Applies a list of variation coordinates (in design-space units)
 * to a font.
 *
 * Note that this overrides all existing variations set on @font.
 * Axes not included in @coords will be effectively set to their
 * default values.
 */
void fontSetVarCoordsDesign(Font font, float[] coords)
{
  auto _coords = cast(const(float)*)coords.ptr;
  hb_font_set_var_coords_design(font ? font.cPtr!hb_font_t : null, _coords, coords ? cast(uint)coords.length : 0);
}

/**
 * Applies a list of variation coordinates (in normalized units)
 * to a font.
 *
 * Note that this overrides all existing variations set on @font.
 * Axes not included in @coords will be effectively set to their
 * default values.
 *
 * <note>Note: Coordinates should be normalized to 2.14.</note>
 */
void fontSetVarCoordsNormalized(Font font, int[] coords)
{
  auto _coords = cast(const(int)*)coords.ptr;
  hb_font_set_var_coords_normalized(font ? font.cPtr!hb_font_t : null, _coords, coords ? cast(uint)coords.length : 0);
}

/**
 * Sets design coords of a font from a named-instance index.
 */
void fontSetVarNamedInstance(Font font, uint instanceIndex)
{
  hb_font_set_var_named_instance(font ? font.cPtr!hb_font_t : null, instanceIndex);
}

/**
 * Change the value of one variation axis on the font.
 *
 * Note: This function is expensive to be called repeatedly.
 * If you want to set multiple variation axes at the same time,
 * use hb_font_set_variations() instead.
 */
void fontSetVariation(Font font, Tag tag, float value)
{
  hb_font_set_variation(font ? font.cPtr!hb_font_t : null, tag, value);
}

/**
 * Applies a list of font-variation settings to a font.
 *
 * Note that this overrides all existing variations set on @font.
 * Axes not included in @variations will be effectively set to their
 * default values.
 */
void fontSetVariations(Font font, Variation[] variations)
{
  hb_variation_t[] _tmpvariations;
  foreach (obj; variations)
    _tmpvariations ~= obj.cInstance;
  const(hb_variation_t)* _variations = _tmpvariations.ptr;
  hb_font_set_variations(font ? font.cPtr!hb_font_t : null, _variations, variations ? cast(uint)variations.length : 0);
}

/**
 * Subtracts the origin coordinates from an (X,Y) point coordinate,
 * in the specified glyph ID in the specified font.
 *
 * Calls the appropriate direction-specific variant (horizontal
 * or vertical) depending on the value of @direction.
 */
void fontSubtractGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, inout Position x, inout Position y)
{
  hb_font_subtract_glyph_origin_for_direction(font ? font.cPtr!hb_font_t : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * the new #hb_face_t face object
 */
HBFace ftFaceCreateCached(Face ftFace)
{
  hb_face_t* _cretval;
  _cretval = hb_ft_face_create_cached(ftFace);
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * the new #hb_face_t face object
 */
HBFace ftFaceCreateReferenced(Face ftFace)
{
  hb_face_t* _cretval;
  _cretval = hb_ft_face_create_referenced(ftFace);
  HBFace _retval = new HBFace(cast(hb_face_t*)_cretval, true);
  return _retval;
}

/**
 * Refreshes the state of @font when the underlying FT_Face has changed.
 * This function should be called after changing the size or
 * variation-axis settings on the FT_Face.
 */
void ftFontChanged(Font font)
{
  hb_ft_font_changed(font ? font.cPtr!hb_font_t : null);
}

/**
 * the new #hb_font_t font object
 */
Font ftFontCreateReferenced(Face ftFace)
{
  hb_font_t* _cretval;
  _cretval = hb_ft_font_create_referenced(ftFace);
  Font _retval = new Font(cast(hb_font_t*)_cretval, true);
  return _retval;
}

/**
 * FT_Load_Glyph flags found, or 0
 */
int ftFontGetLoadFlags(Font font)
{
  int _retval;
  _retval = hb_ft_font_get_load_flags(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * Configures the font-functions structure of the specified
 * #hb_font_t font object to use FreeType font functions.
 *
 * In particular, you can use this function to configure an
 * existing #hb_face_t face object for use with FreeType font
 * functions even if that #hb_face_t face object was initially
 * created with hb_face_create(), and therefore was not
 * initially configured to use FreeType font functions.
 *
 * An #hb_font_t object created with hb_ft_font_create()
 * is preconfigured for FreeType font functions and does not
 * require this function to be used.
 *
 * Note that if you modify the underlying #hb_font_t after
 * calling this function, you need to call hb_ft_hb_font_changed()
 * to update the underlying FT_Face.
 *
 * <note>Note: Internally, this function creates an FT_Face.
 * </note>
 */
void ftFontSetFuncs(Font font)
{
  hb_ft_font_set_funcs(font ? font.cPtr!hb_font_t : null);
}

/**
 * Sets the FT_Load_Glyph load flags for the specified #hb_font_t.
 *
 * For more information, see
 * https://www.freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_load_xxx
 *
 * This function works with #hb_font_t objects created by
 * hb_ft_font_create() or hb_ft_font_create_referenced().
 */
void ftFontSetLoadFlags(Font font, int loadFlags)
{
  hb_ft_font_set_load_flags(font ? font.cPtr!hb_font_t : null, loadFlags);
}

/**
 * true if changed, false otherwise
 */
Bool ftHbFontChanged(Font font)
{
  Bool _retval;
  _retval = hb_ft_hb_font_changed(font ? font.cPtr!hb_font_t : null);
  return _retval;
}

/**
 * the new #hb_blob_t blob object
 */
Blob glibBlobCreate(Bytes gbytes)
{
  hb_blob_t* _cretval;
  _cretval = hb_glib_blob_create(gbytes ? gbytes.cPtr!GBytes : null);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * a pointer to the #hb_unicode_funcs_t Unicode-functions structure
 */
UnicodeFuncs glibGetUnicodeFuncs()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_glib_get_unicode_funcs();
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, false);
  return _retval;
}

/**
 * the GUnicodeScript identifier found
 */
UnicodeScript glibScriptFromScript(Script script)
{
  GUnicodeScript _cretval;
  _cretval = hb_glib_script_from_script(script);
  UnicodeScript _retval = cast(UnicodeScript)_cretval;
  return _retval;
}

/**
 * the #hb_script_t script found
 */
Script glibScriptToScript(UnicodeScript script)
{
  hb_script_t _cretval;
  _cretval = hb_glib_script_to_script(script);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * The #hb_glyph_flags_t encoded within @info
 */
GlyphFlags glyphInfoGetGlyphFlags(GlyphInfo info)
{
  hb_glyph_flags_t _cretval;
  _cretval = hb_glyph_info_get_glyph_flags(info ? info.cPtr!hb_glyph_info_t : null);
  GlyphFlags _retval = cast(GlyphFlags)_cretval;
  return _retval;
}

/**
 * The #hb_language_t corresponding to the BCP 47 language tag.
 */
Language languageFromString(ubyte[] str)
{
  hb_language_t _cretval;
  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_language_from_string(_str, str ? cast(int)str.length : 0);
  Language _retval = new Language(cast(hb_language_t)_cretval, false);
  return _retval;
}

/**
 * The default language of the locale as
 * an #hb_language_t
 */
Language languageGetDefault()
{
  hb_language_t _cretval;
  _cretval = hb_language_get_default();
  Language _retval = new Language(cast(hb_language_t)_cretval, false);
  return _retval;
}

/**
 * `true` if languages match, `false` otherwise.
 */
Bool languageMatches(Language language, Language specific)
{
  Bool _retval;
  _retval = hb_language_matches(language ? language.cPtr!hb_language_t : null, specific ? specific.cPtr!hb_language_t : null);
  return _retval;
}

/**
 * A `NULL`-terminated string representing the @language. Must not be freed by
 * the caller.
 */
string languageToString(Language language)
{
  const(char)* _cretval;
  _cretval = hb_language_to_string(language ? language.cPtr!hb_language_t : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * `true` if allocation succeeded, `false` otherwise
 */
Bool mapAllocationSuccessful(Map map)
{
  Bool _retval;
  _retval = hb_map_allocation_successful(map ? map.cPtr!hb_map_t : null);
  return _retval;
}

/**
 * Clears out the contents of @map.
 */
void mapClear(Map map)
{
  hb_map_clear(map ? map.cPtr!hb_map_t : null);
}

/**
 * Newly-allocated map.
 */
Map mapCopy(Map map)
{
  hb_map_t* _cretval;
  _cretval = hb_map_copy(map ? map.cPtr!hb_map_t : null);
  Map _retval = new Map(cast(hb_map_t*)_cretval, true);
  return _retval;
}

/**
 * The new #hb_map_t
 */
Map mapCreate()
{
  hb_map_t* _cretval;
  _cretval = hb_map_create();
  Map _retval = new Map(cast(hb_map_t*)_cretval, true);
  return _retval;
}

/**
 * Removes @key and its stored value from @map.
 */
void mapDel(Map map, Codepoint key)
{
  hb_map_del(map ? map.cPtr!hb_map_t : null, key);
}

/**
 * Fetches the value stored for @key in @map.
 */
Codepoint mapGet(Map map, Codepoint key)
{
  Codepoint _retval;
  _retval = hb_map_get(map ? map.cPtr!hb_map_t : null, key);
  return _retval;
}

/**
 * The empty #hb_map_t
 */
Map mapGetEmpty()
{
  hb_map_t* _cretval;
  _cretval = hb_map_get_empty();
  Map _retval = new Map(cast(hb_map_t*)_cretval, true);
  return _retval;
}

/**
 * The population of @map
 */
uint mapGetPopulation(Map map)
{
  uint _retval;
  _retval = hb_map_get_population(map ? map.cPtr!hb_map_t : null);
  return _retval;
}

/**
 * `true` if @key is found in @map, `false` otherwise
 */
Bool mapHas(Map map, Codepoint key)
{
  Bool _retval;
  _retval = hb_map_has(map ? map.cPtr!hb_map_t : null, key);
  return _retval;
}

/**
 * A hash of @map.
 */
uint mapHash(Map map)
{
  uint _retval;
  _retval = hb_map_hash(map ? map.cPtr!hb_map_t : null);
  return _retval;
}

/**
 * `true` if @map is empty
 */
Bool mapIsEmpty(Map map)
{
  Bool _retval;
  _retval = hb_map_is_empty(map ? map.cPtr!hb_map_t : null);
  return _retval;
}

/**
 * `true` if the two maps are equal, `false` otherwise.
 */
Bool mapIsEqual(Map map, Map other)
{
  Bool _retval;
  _retval = hb_map_is_equal(map ? map.cPtr!hb_map_t : null, other ? other.cPtr!hb_map_t : null);
  return _retval;
}

/**
 * Add the keys of @map to @keys.
 */
void mapKeys(Map map, Set keys)
{
  hb_map_keys(map ? map.cPtr!hb_map_t : null, keys ? keys.cPtr!hb_set_t : null);
}

/**
 * `true` if there was a next value, `false` otherwise
 */
Bool mapNext(Map map, inout int idx, out Codepoint key, out Codepoint value)
{
  Bool _retval;
  _retval = hb_map_next(map ? map.cPtr!hb_map_t : null, cast(int*)&idx, cast(hb_codepoint_t*)&key, cast(hb_codepoint_t*)&value);
  return _retval;
}

/**
 * Stores @key:@value in the map.
 */
void mapSet(Map map, Codepoint key, Codepoint value)
{
  hb_map_set(map ? map.cPtr!hb_map_t : null, key, value);
}

/**
 * Add the contents of @other to @map.
 */
void mapUpdate(Map map, Map other)
{
  hb_map_update(map ? map.cPtr!hb_map_t : null, other ? other.cPtr!hb_map_t : null);
}

/**
 * Add the values of @map to @values.
 */
void mapValues(Map map, Set values)
{
  hb_map_values(map ? map.cPtr!hb_map_t : null, values ? values.cPtr!hb_set_t : null);
}

/**
 * Total number of layers available for the glyph index queried
 */
uint otColorGlyphGetLayers(HBFace face, Codepoint glyph, uint startOffset, ref OtColorLayer[] layers)
{
  uint _retval;
  auto _layerCount = layers ? cast(uint)layers.length : 0;
  _retval = hb_ot_color_glyph_get_layers(face ? face.cPtr!hb_face_t : null, glyph, startOffset, &_layerCount, layers.ptr);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otColorGlyphHasPaint(HBFace face, Codepoint glyph)
{
  Bool _retval;
  _retval = hb_ot_color_glyph_has_paint(face ? face.cPtr!hb_face_t : null, glyph);
  return _retval;
}

/**
 * An #hb_blob_t containing the PNG image for the glyph, if available
 */
Blob otColorGlyphReferencePng(Font font, Codepoint glyph)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_color_glyph_reference_png(font ? font.cPtr!hb_font_t : null, glyph);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * An #hb_blob_t containing the SVG document of the glyph, if available
 */
Blob otColorGlyphReferenceSvg(HBFace face, Codepoint glyph)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_color_glyph_reference_svg(face ? face.cPtr!hb_face_t : null, glyph);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otColorHasLayers(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_layers(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otColorHasPaint(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_paint(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otColorHasPalettes(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_palettes(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otColorHasPng(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_png(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise.
 */
Bool otColorHasSvg(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_svg(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * the Name ID found for the color.
 */
OtNameId otColorPaletteColorGetNameId(HBFace face, uint colorIndex)
{
  OtNameId _retval;
  _retval = hb_ot_color_palette_color_get_name_id(face ? face.cPtr!hb_face_t : null, colorIndex);
  return _retval;
}

/**
 * the total number of colors in the palette
 */
uint otColorPaletteGetColors(HBFace face, uint paletteIndex, uint startOffset, ref Color[] colors)
{
  uint _retval;
  auto _colorCount = colors ? cast(uint)colors.length : 0;
  _retval = hb_ot_color_palette_get_colors(face ? face.cPtr!hb_face_t : null, paletteIndex, startOffset, &_colorCount, colors.ptr);
  return _retval;
}

/**
 * the number of palettes found
 */
uint otColorPaletteGetCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_color_palette_get_count(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * the #hb_ot_color_palette_flags_t of the requested color palette
 */
OtColorPaletteFlags otColorPaletteGetFlags(HBFace face, uint paletteIndex)
{
  hb_ot_color_palette_flags_t _cretval;
  _cretval = hb_ot_color_palette_get_flags(face ? face.cPtr!hb_face_t : null, paletteIndex);
  OtColorPaletteFlags _retval = cast(OtColorPaletteFlags)_cretval;
  return _retval;
}

/**
 * the Named ID found for the palette.
 * If the requested palette has no name the result is #HB_OT_NAME_ID_INVALID.
 */
OtNameId otColorPaletteGetNameId(HBFace face, uint paletteIndex)
{
  OtNameId _retval;
  _retval = hb_ot_color_palette_get_name_id(face ? face.cPtr!hb_face_t : null, paletteIndex);
  return _retval;
}

/**
 * Sets the font functions to use when working with @font.
 */
void otFontSetFuncs(Font font)
{
  hb_ot_font_set_funcs(font ? font.cPtr!hb_font_t : null);
}

/**
 * Number of total sample characters in the cvXX feature.
 */
uint otLayoutFeatureGetCharacters(HBFace face, Tag tableTag, uint featureIndex, uint startOffset, ref Codepoint[] characters)
{
  uint _retval;
  auto _charCount = characters ? cast(uint)characters.length : 0;
  _retval = hb_ot_layout_feature_get_characters(face ? face.cPtr!hb_face_t : null, tableTag, featureIndex, startOffset, &_charCount, characters.ptr);
  return _retval;
}

/**
 * Total number of lookups.
 */
uint otLayoutFeatureGetLookups(HBFace face, Tag tableTag, uint featureIndex, uint startOffset, ref uint[] lookupIndexes)
{
  uint _retval;
  auto _lookupCount = lookupIndexes ? cast(uint)lookupIndexes.length : 0;
  _retval = hb_ot_layout_feature_get_lookups(face ? face.cPtr!hb_face_t : null, tableTag, featureIndex, startOffset, &_lookupCount, lookupIndexes.ptr);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otLayoutFeatureGetNameIds(HBFace face, Tag tableTag, uint featureIndex, out OtNameId labelId, out OtNameId tooltipId, out OtNameId sampleId, out uint numNamedParameters, out OtNameId firstParamId)
{
  Bool _retval;
  _retval = hb_ot_layout_feature_get_name_ids(face ? face.cPtr!hb_face_t : null, tableTag, featureIndex, cast(hb_ot_name_id_t*)&labelId, cast(hb_ot_name_id_t*)&tooltipId, cast(hb_ot_name_id_t*)&sampleId, cast(uint*)&numNamedParameters, cast(hb_ot_name_id_t*)&firstParamId);
  return _retval;
}

/**
 * Total number of lookups.
 */
uint otLayoutFeatureWithVariationsGetLookups(HBFace face, Tag tableTag, uint featureIndex, uint variationsIndex, uint startOffset, ref uint[] lookupIndexes)
{
  uint _retval;
  auto _lookupCount = lookupIndexes ? cast(uint)lookupIndexes.length : 0;
  _retval = hb_ot_layout_feature_with_variations_get_lookups(face ? face.cPtr!hb_face_t : null, tableTag, featureIndex, variationsIndex, startOffset, &_lookupCount, lookupIndexes.ptr);
  return _retval;
}

/**
 * Total number of attachment points for @glyph.
 */
uint otLayoutGetAttachPoints(HBFace face, Codepoint glyph, uint startOffset, ref uint[] pointArray)
{
  uint _retval;
  auto _pointCount = pointArray ? cast(uint)pointArray.length : 0;
  _retval = hb_ot_layout_get_attach_points(face ? face.cPtr!hb_face_t : null, glyph, startOffset, &_pointCount, pointArray.ptr);
  return _retval;
}

/**
 * `true` if found baseline value in the font.
 */
Bool otLayoutGetBaseline(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Tag scriptTag, Tag languageTag, out Position coord)
{
  Bool _retval;
  _retval = hb_ot_layout_get_baseline(font ? font.cPtr!hb_font_t : null, baselineTag, direction, scriptTag, languageTag, cast(hb_position_t*)&coord);
  return _retval;
}

/**
 * `true` if found baseline value in the font.
 */
Bool otLayoutGetBaseline2(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Script script, Language language, out Position coord)
{
  Bool _retval;
  _retval = hb_ot_layout_get_baseline2(font ? font.cPtr!hb_font_t : null, baselineTag, direction, script, language ? language.cPtr!hb_language_t : null, cast(hb_position_t*)&coord);
  return _retval;
}

/**
 * Fetches a baseline value from the face, and synthesizes
 * it if the font does not have it.
 */
void otLayoutGetBaselineWithFallback(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Tag scriptTag, Tag languageTag, out Position coord)
{
  hb_ot_layout_get_baseline_with_fallback(font ? font.cPtr!hb_font_t : null, baselineTag, direction, scriptTag, languageTag, cast(hb_position_t*)&coord);
}

/**
 * Fetches a baseline value from the face, and synthesizes
 * it if the font does not have it.
 *
 * This function is like hb_ot_layout_get_baseline_with_fallback() but takes
 * #hb_script_t and #hb_language_t instead of OpenType #hb_tag_t.
 */
void otLayoutGetBaselineWithFallback2(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Script script, Language language, out Position coord)
{
  hb_ot_layout_get_baseline_with_fallback2(font ? font.cPtr!hb_font_t : null, baselineTag, direction, script, language ? language.cPtr!hb_language_t : null, cast(hb_position_t*)&coord);
}

/**
 * `true` if found script/language-specific font extents.
 */
Bool otLayoutGetFontExtents(Font font, Direction direction, Tag scriptTag, Tag languageTag, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_ot_layout_get_font_extents(font ? font.cPtr!hb_font_t : null, direction, scriptTag, languageTag, &extents);
  return _retval;
}

/**
 * `true` if found script/language-specific font extents.
 */
Bool otLayoutGetFontExtents2(Font font, Direction direction, Script script, Language language, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_ot_layout_get_font_extents2(font ? font.cPtr!hb_font_t : null, direction, script, language ? language.cPtr!hb_language_t : null, &extents);
  return _retval;
}

/**
 * The #hb_ot_layout_glyph_class_t glyph class of the given code
 * point in the GDEF table of the face.
 */
OtLayoutGlyphClass otLayoutGetGlyphClass(HBFace face, Codepoint glyph)
{
  hb_ot_layout_glyph_class_t _cretval;
  _cretval = hb_ot_layout_get_glyph_class(face ? face.cPtr!hb_face_t : null, glyph);
  OtLayoutGlyphClass _retval = cast(OtLayoutGlyphClass)_cretval;
  return _retval;
}

/**
 * dominant baseline tag for the @script.
 */
OtLayoutBaselineTag otLayoutGetHorizontalBaselineTagForScript(Script script)
{
  hb_ot_layout_baseline_tag_t _cretval;
  _cretval = hb_ot_layout_get_horizontal_baseline_tag_for_script(script);
  OtLayoutBaselineTag _retval = cast(OtLayoutBaselineTag)_cretval;
  return _retval;
}

/**
 * Total number of ligature caret positions for @glyph.
 */
uint otLayoutGetLigatureCarets(Font font, Direction direction, Codepoint glyph, uint startOffset, ref Position[] caretArray)
{
  uint _retval;
  auto _caretCount = caretArray ? cast(uint)caretArray.length : 0;
  _retval = hb_ot_layout_get_ligature_carets(font ? font.cPtr!hb_font_t : null, direction, glyph, startOffset, &_caretCount, caretArray.ptr);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otLayoutGetSizeParams(HBFace face, out uint designSize, out uint subfamilyId, out OtNameId subfamilyNameId, out uint rangeStart, out uint rangeEnd)
{
  Bool _retval;
  _retval = hb_ot_layout_get_size_params(face ? face.cPtr!hb_face_t : null, cast(uint*)&designSize, cast(uint*)&subfamilyId, cast(hb_ot_name_id_t*)&subfamilyNameId, cast(uint*)&rangeStart, cast(uint*)&rangeEnd);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otLayoutHasGlyphClasses(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_glyph_classes(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if the face has GPOS data, `false` otherwise
 */
Bool otLayoutHasPositioning(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_positioning(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otLayoutHasSubstitution(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_substitution(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageFindFeature(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, Tag featureTag, out uint featureIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_language_find_feature(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, languageIndex, featureTag, cast(uint*)&featureIndex);
  return _retval;
}

/**
 * Total number of features.
 */
uint otLayoutLanguageGetFeatureIndexes(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, uint startOffset, ref uint[] featureIndexes)
{
  uint _retval;
  auto _featureCount = featureIndexes ? cast(uint)featureIndexes.length : 0;
  _retval = hb_ot_layout_language_get_feature_indexes(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, languageIndex, startOffset, &_featureCount, featureIndexes.ptr);
  return _retval;
}

/**
 * Total number of feature tags.
 */
uint otLayoutLanguageGetFeatureTags(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, uint startOffset, ref Tag[] featureTags)
{
  uint _retval;
  auto _featureCount = featureTags ? cast(uint)featureTags.length : 0;
  _retval = hb_ot_layout_language_get_feature_tags(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, languageIndex, startOffset, &_featureCount, featureTags.ptr);
  return _retval;
}

/**
 * `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageGetRequiredFeature(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, out uint featureIndex, out Tag featureTag)
{
  Bool _retval;
  _retval = hb_ot_layout_language_get_required_feature(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, languageIndex, cast(uint*)&featureIndex, cast(hb_tag_t*)&featureTag);
  return _retval;
}

/**
 * `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageGetRequiredFeatureIndex(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, out uint featureIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_language_get_required_feature_index(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, languageIndex, cast(uint*)&featureIndex);
  return _retval;
}

/**
 * Total number of alternates found in the specific lookup index for the given glyph id.
 */
uint otLayoutLookupGetGlyphAlternates(HBFace face, uint lookupIndex, Codepoint glyph, uint startOffset, ref Codepoint[] alternateGlyphs)
{
  uint _retval;
  auto _alternateCount = alternateGlyphs ? cast(uint)alternateGlyphs.length : 0;
  _retval = hb_ot_layout_lookup_get_glyph_alternates(face ? face.cPtr!hb_face_t : null, lookupIndex, glyph, startOffset, &_alternateCount, alternateGlyphs.ptr);
  return _retval;
}

/**
 * Adjustment value. Negative values mean the glyph will stick out of the margin.
 */
Position otLayoutLookupGetOpticalBound(Font font, uint lookupIndex, Direction direction, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_layout_lookup_get_optical_bound(font ? font.cPtr!hb_font_t : null, lookupIndex, direction, glyph);
  return _retval;
}

/**
 * Total number of language tags.
 */
uint otLayoutScriptGetLanguageTags(HBFace face, Tag tableTag, uint scriptIndex, uint startOffset, ref Tag[] languageTags)
{
  uint _retval;
  auto _languageCount = languageTags ? cast(uint)languageTags.length : 0;
  _retval = hb_ot_layout_script_get_language_tags(face ? face.cPtr!hb_face_t : null, tableTag, scriptIndex, startOffset, &_languageCount, languageTags.ptr);
  return _retval;
}

/**
 * `true` if the script is found, `false` otherwise
 */
Bool otLayoutTableFindScript(HBFace face, Tag tableTag, Tag scriptTag, out uint scriptIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_table_find_script(face ? face.cPtr!hb_face_t : null, tableTag, scriptTag, cast(uint*)&scriptIndex);
  return _retval;
}

/**
 * Total number of feature tags.
 */
uint otLayoutTableGetFeatureTags(HBFace face, Tag tableTag, uint startOffset, ref Tag[] featureTags)
{
  uint _retval;
  auto _featureCount = featureTags ? cast(uint)featureTags.length : 0;
  _retval = hb_ot_layout_table_get_feature_tags(face ? face.cPtr!hb_face_t : null, tableTag, startOffset, &_featureCount, featureTags.ptr);
  return _retval;
}

/**
 * Total number of lookups.
 */
uint otLayoutTableGetLookupCount(HBFace face, Tag tableTag)
{
  uint _retval;
  _retval = hb_ot_layout_table_get_lookup_count(face ? face.cPtr!hb_face_t : null, tableTag);
  return _retval;
}

/**
 * Total number of script tags.
 */
uint otLayoutTableGetScriptTags(HBFace face, Tag tableTag, uint startOffset, ref Tag[] scriptTags)
{
  uint _retval;
  auto _scriptCount = scriptTags ? cast(uint)scriptTags.length : 0;
  _retval = hb_ot_layout_table_get_script_tags(face ? face.cPtr!hb_face_t : null, tableTag, startOffset, &_scriptCount, scriptTags.ptr);
  return _retval;
}

/**
 * the requested constant or zero
 */
Position otMathGetConstant(Font font, OtMathConstant constant)
{
  Position _retval;
  _retval = hb_ot_math_get_constant(font ? font.cPtr!hb_font_t : null, constant);
  return _retval;
}

/**
 * the total number of parts in the glyph assembly
 */
uint otMathGetGlyphAssembly(Font font, Codepoint glyph, Direction direction, uint startOffset, ref OtMathGlyphPart[] parts, out Position italicsCorrection)
{
  uint _retval;
  auto _partsCount = parts ? cast(uint)parts.length : 0;
  hb_ot_math_glyph_part_t[] _parts;
  _parts.length = _partsCount;
  _retval = hb_ot_math_get_glyph_assembly(font ? font.cPtr!hb_font_t : null, glyph, direction, startOffset, &_partsCount, _parts.ptr, cast(hb_position_t*)&italicsCorrection);
  parts.length = _partsCount;
  foreach (i; 0 .. _partsCount)
    parts[i] = new OtMathGlyphPart(cast(void*)&_parts[i], false);
  return _retval;
}

/**
 * the italics correction of the glyph or zero
 */
Position otMathGetGlyphItalicsCorrection(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_italics_correction(font ? font.cPtr!hb_font_t : null, glyph);
  return _retval;
}

/**
 * requested kerning value or zero
 */
Position otMathGetGlyphKerning(Font font, Codepoint glyph, OtMathKern kern, Position correctionHeight)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_kerning(font ? font.cPtr!hb_font_t : null, glyph, kern, correctionHeight);
  return _retval;
}

/**
 * the total number of kern values available or zero
 */
uint otMathGetGlyphKernings(Font font, Codepoint glyph, OtMathKern kern, uint startOffset, ref OtMathKernEntry[] kernEntries)
{
  uint _retval;
  auto _entriesCount = kernEntries ? cast(uint)kernEntries.length : 0;
  _retval = hb_ot_math_get_glyph_kernings(font ? font.cPtr!hb_font_t : null, glyph, kern, startOffset, &_entriesCount, kernEntries.ptr);
  return _retval;
}

/**
 * the top accent attachment of the glyph or 0.5 * the advance
 * width of @glyph
 */
Position otMathGetGlyphTopAccentAttachment(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_top_accent_attachment(font ? font.cPtr!hb_font_t : null, glyph);
  return _retval;
}

/**
 * the total number of size variants available or zero
 */
uint otMathGetGlyphVariants(Font font, Codepoint glyph, Direction direction, uint startOffset, ref OtMathGlyphVariant[] variants)
{
  uint _retval;
  auto _variantsCount = variants ? cast(uint)variants.length : 0;
  hb_ot_math_glyph_variant_t[] _variants;
  _variants.length = _variantsCount;
  _retval = hb_ot_math_get_glyph_variants(font ? font.cPtr!hb_font_t : null, glyph, direction, startOffset, &_variantsCount, _variants.ptr);
  variants.length = _variantsCount;
  foreach (i; 0 .. _variantsCount)
    variants[i] = new OtMathGlyphVariant(cast(void*)&_variants[i], false);
  return _retval;
}

/**
 * requested minimum connector overlap or zero
 */
Position otMathGetMinConnectorOverlap(Font font, Direction direction)
{
  Position _retval;
  _retval = hb_ot_math_get_min_connector_overlap(font ? font.cPtr!hb_font_t : null, direction);
  return _retval;
}

/**
 * `true` if the table is found, `false` otherwise
 */
Bool otMathHasData(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_math_has_data(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if the glyph is an extended shape, `false` otherwise
 */
Bool otMathIsGlyphExtendedShape(HBFace face, Codepoint glyph)
{
  Bool _retval;
  _retval = hb_ot_math_is_glyph_extended_shape(face ? face.cPtr!hb_face_t : null, glyph);
  return _retval;
}

/**
 * A blob containing the blob.
 */
Blob otMetaReferenceEntry(HBFace face, OtMetaTag metaTag)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_meta_reference_entry(face ? face.cPtr!hb_face_t : null, metaTag);
  Blob _retval = new Blob(cast(hb_blob_t*)_cretval, true);
  return _retval;
}

/**
 * Whether found the requested metrics in the font.
 */
Bool otMetricsGetPosition(Font font, OtMetricsTag metricsTag, out Position position)
{
  Bool _retval;
  _retval = hb_ot_metrics_get_position(font ? font.cPtr!hb_font_t : null, metricsTag, cast(hb_position_t*)&position);
  return _retval;
}

/**
 * Fetches metrics value corresponding to @metrics_tag from @font,
 * and synthesizes a value if it the value is missing in the font.
 */
void otMetricsGetPositionWithFallback(Font font, OtMetricsTag metricsTag, out Position position)
{
  hb_ot_metrics_get_position_with_fallback(font ? font.cPtr!hb_font_t : null, metricsTag, cast(hb_position_t*)&position);
}

/**
 * The requested metric value.
 */
float otMetricsGetVariation(Font font, OtMetricsTag metricsTag)
{
  float _retval;
  _retval = hb_ot_metrics_get_variation(font ? font.cPtr!hb_font_t : null, metricsTag);
  return _retval;
}

/**
 * The requested metric value.
 */
Position otMetricsGetXVariation(Font font, OtMetricsTag metricsTag)
{
  Position _retval;
  _retval = hb_ot_metrics_get_x_variation(font ? font.cPtr!hb_font_t : null, metricsTag);
  return _retval;
}

/**
 * The requested metric value.
 */
Position otMetricsGetYVariation(Font font, OtMetricsTag metricsTag)
{
  Position _retval;
  _retval = hb_ot_metrics_get_y_variation(font ? font.cPtr!hb_font_t : null, metricsTag);
  return _retval;
}

/**
 * Array of available name entries.
 */
OtNameEntry[] otNameListNames(HBFace face)
{
  const(hb_ot_name_entry_t)* _cretval;
  uint _cretlength;
  _cretval = hb_ot_name_list_names(face ? face.cPtr!hb_face_t : null, &_cretlength);
  OtNameEntry[] _retval;

  if (_cretval)
  {
    _retval = new OtNameEntry[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = new OtNameEntry(cast(void*)&_cretval[i], false);
  }
  return _retval;
}

/**
 * Converts an #hb_language_t to an #hb_tag_t.
 */
Tag otTagFromLanguage(Language language)
{
  Tag _retval;
  _retval = hb_ot_tag_from_language(language ? language.cPtr!hb_language_t : null);
  return _retval;
}

/**
 * The #hb_language_t corresponding to @tag.
 */
Language otTagToLanguage(Tag tag)
{
  hb_language_t _cretval;
  _cretval = hb_ot_tag_to_language(tag);
  Language _retval = new Language(cast(hb_language_t)_cretval, false);
  return _retval;
}

/**
 * The #hb_script_t corresponding to @tag.
 */
Script otTagToScript(Tag tag)
{
  hb_script_t _cretval;
  _cretval = hb_ot_tag_to_script(tag);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Converts an #hb_script_t to script tags.
 */
void otTagsFromScript(Script script, out Tag scriptTag1, out Tag scriptTag2)
{
  hb_ot_tags_from_script(script, cast(hb_tag_t*)&scriptTag1, cast(hb_tag_t*)&scriptTag2);
}

/**
 * Converts an #hb_script_t and an #hb_language_t to script and language tags.
 */
void otTagsFromScriptAndLanguage(Script script, Language language, inout uint scriptCount, out Tag scriptTags, inout uint languageCount, out Tag languageTags)
{
  hb_ot_tags_from_script_and_language(script, language ? language.cPtr!hb_language_t : null, cast(uint*)&scriptCount, cast(hb_tag_t*)&scriptTags, cast(uint*)&languageCount, cast(hb_tag_t*)&languageTags);
}

/**
 * Converts a script tag and a language tag to an #hb_script_t and an
 * #hb_language_t.
 */
void otTagsToScriptAndLanguage(Tag scriptTag, Tag languageTag, out Script script, out Language language)
{
  hb_language_t _language;
  hb_ot_tags_to_script_and_language(scriptTag, languageTag, &script, &_language);
  language = new Language(cast(void*)&_language, false);
}

/**
 * Fetches a list of all variation axes in the specified face. The list returned will begin
 * at the offset provided.
 */
uint otVarGetAxes(HBFace face, uint startOffset, ref OtVarAxis[] axesArray)
{
  uint _retval;
  auto _axesCount = axesArray ? cast(uint)axesArray.length : 0;
  _retval = hb_ot_var_get_axes(face ? face.cPtr!hb_face_t : null, startOffset, &_axesCount, axesArray.ptr);
  return _retval;
}

/**
 * the number of variation axes defined
 */
uint otVarGetAxisCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_var_get_axis_count(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * the number of variation axes in the face
 */
uint otVarGetAxisInfos(HBFace face, uint startOffset, ref OtVarAxisInfo[] axesArray)
{
  uint _retval;
  auto _axesCount = axesArray ? cast(uint)axesArray.length : 0;
  hb_ot_var_axis_info_t[] _axesArray;
  _axesArray.length = _axesCount;
  _retval = hb_ot_var_get_axis_infos(face ? face.cPtr!hb_face_t : null, startOffset, &_axesCount, _axesArray.ptr);
  axesArray.length = _axesCount;
  foreach (i; 0 .. _axesCount)
    axesArray[i] = new OtVarAxisInfo(cast(void*)&_axesArray[i], false);
  return _retval;
}

/**
 * the number of named instances defined
 */
uint otVarGetNamedInstanceCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_var_get_named_instance_count(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * `true` if data found, `false` otherwise
 */
Bool otVarHasData(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_var_has_data(face ? face.cPtr!hb_face_t : null);
  return _retval;
}

/**
 * the number of variation axes in the face
 */
uint otVarNamedInstanceGetDesignCoords(HBFace face, uint instanceIndex, ref float[] coords)
{
  uint _retval;
  auto _coordsLength = coords ? cast(uint)coords.length : 0;
  _retval = hb_ot_var_named_instance_get_design_coords(face ? face.cPtr!hb_face_t : null, instanceIndex, &_coordsLength, coords.ptr);
  return _retval;
}

/**
 * the Name ID found for the PostScript name
 */
OtNameId otVarNamedInstanceGetPostscriptNameId(HBFace face, uint instanceIndex)
{
  OtNameId _retval;
  _retval = hb_ot_var_named_instance_get_postscript_name_id(face ? face.cPtr!hb_face_t : null, instanceIndex);
  return _retval;
}

/**
 * the Name ID found for the Subfamily name
 */
OtNameId otVarNamedInstanceGetSubfamilyNameId(HBFace face, uint instanceIndex)
{
  OtNameId _retval;
  _retval = hb_ot_var_named_instance_get_subfamily_name_id(face ? face.cPtr!hb_face_t : null, instanceIndex);
  return _retval;
}

/**
 * Perform a "color" paint operation.
 */
void paintColor(PaintFuncs funcs, void* paintData, Bool isForeground, Color color)
{
  hb_paint_color(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, isForeground, color);
}

/**
 * `true` if found, `false` otherwise
 */
Bool paintCustomPaletteColor(PaintFuncs funcs, void* paintData, uint colorIndex, out Color color)
{
  Bool _retval;
  _retval = hb_paint_custom_palette_color(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, colorIndex, cast(hb_color_t*)&color);
  return _retval;
}

/**
 * the paint-functions structure
 */
PaintFuncs paintFuncsCreate()
{
  hb_paint_funcs_t* _cretval;
  _cretval = hb_paint_funcs_create();
  PaintFuncs _retval = new PaintFuncs(cast(hb_paint_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * The empty paint-functions structure
 */
PaintFuncs paintFuncsGetEmpty()
{
  hb_paint_funcs_t* _cretval;
  _cretval = hb_paint_funcs_get_empty();
  PaintFuncs _retval = new PaintFuncs(cast(hb_paint_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if @funcs is immutable, `false` otherwise
 */
Bool paintFuncsIsImmutable(PaintFuncs funcs)
{
  Bool _retval;
  _retval = hb_paint_funcs_is_immutable(funcs ? funcs.cPtr!hb_paint_funcs_t : null);
  return _retval;
}

/**
 * Makes a paint-functions structure immutable.
 *
 * After this call, all attempts to set one of the callbacks
 * on @funcs will fail.
 */
void paintFuncsMakeImmutable(PaintFuncs funcs)
{
  hb_paint_funcs_make_immutable(funcs ? funcs.cPtr!hb_paint_funcs_t : null);
}

/**
 * Sets the paint-color callback on the paint functions struct.
 */
void paintFuncsSetColorFunc(PaintFuncs funcs, PaintColorFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_bool_t isForeground, hb_color_t color, void* userData)
  {
    (*(cast(PaintColorFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, isForeground, color);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_color_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the custom-palette-color callback on the paint functions struct.
 */
void paintFuncsSetCustomPaletteColorFunc(PaintFuncs funcs, PaintCustomPaletteColorFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_paint_funcs_t* funcs, void* paintData, uint colorIndex, hb_color_t* color, void* userData)
  {
    hb_bool_t _retval = (*(cast(PaintCustomPaletteColorFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, colorIndex, *color);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_custom_palette_color_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the paint-image callback on the paint functions struct.
 */
void paintFuncsSetImageFunc(PaintFuncs funcs, PaintImageFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_blob_t* image, uint width, uint height, hb_tag_t format, float slant, hb_glyph_extents_t* extents, void* userData)
  {
    hb_bool_t _retval = (*(cast(PaintImageFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, image ? new Blob(image, false) : null, width, height, format, slant, *extents);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_image_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the linear-gradient callback on the paint functions struct.
 */
void paintFuncsSetLinearGradientFunc(PaintFuncs funcs, PaintLinearGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float x1, float y1, float x2, float y2, void* userData)
  {
    (*(cast(PaintLinearGradientFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, colorLine ? new ColorLine(colorLine, false) : null, x0, y0, x1, y1, x2, y2);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_linear_gradient_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the pop-clip callback on the paint functions struct.
 */
void paintFuncsSetPopClipFunc(PaintFuncs funcs, PaintPopClipFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    (*(cast(PaintPopClipFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_pop_clip_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the pop-group callback on the paint functions struct.
 */
void paintFuncsSetPopGroupFunc(PaintFuncs funcs, PaintPopGroupFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_paint_composite_mode_t mode, void* userData)
  {
    (*(cast(PaintPopGroupFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, mode);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_pop_group_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the pop-transform callback on the paint functions struct.
 */
void paintFuncsSetPopTransformFunc(PaintFuncs funcs, PaintPopTransformFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    (*(cast(PaintPopTransformFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_pop_transform_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the push-clip-glyph callback on the paint functions struct.
 */
void paintFuncsSetPushClipGlyphFunc(PaintFuncs funcs, PaintPushClipGlyphFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_codepoint_t glyph, hb_font_t* font, void* userData)
  {
    (*(cast(PaintPushClipGlyphFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, glyph, font ? new Font(font, false) : null);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_push_clip_glyph_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the push-clip-rect callback on the paint functions struct.
 */
void paintFuncsSetPushClipRectangleFunc(PaintFuncs funcs, PaintPushClipRectangleFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, float xmin, float ymin, float xmax, float ymax, void* userData)
  {
    (*(cast(PaintPushClipRectangleFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, xmin, ymin, xmax, ymax);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_push_clip_rectangle_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the push-group callback on the paint functions struct.
 */
void paintFuncsSetPushGroupFunc(PaintFuncs funcs, PaintPushGroupFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    (*(cast(PaintPushGroupFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_push_group_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the push-transform callback on the paint functions struct.
 */
void paintFuncsSetPushTransformFunc(PaintFuncs funcs, PaintPushTransformFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, float xx, float yx, float xy, float yy, float dx, float dy, void* userData)
  {
    (*(cast(PaintPushTransformFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, xx, yx, xy, yy, dx, dy);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_push_transform_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the radial-gradient callback on the paint functions struct.
 */
void paintFuncsSetRadialGradientFunc(PaintFuncs funcs, PaintRadialGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float r0, float x1, float y1, float r1, void* userData)
  {
    (*(cast(PaintRadialGradientFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, colorLine ? new ColorLine(colorLine, false) : null, x0, y0, r0, x1, y1, r1);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_radial_gradient_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the sweep-gradient callback on the paint functions struct.
 */
void paintFuncsSetSweepGradientFunc(PaintFuncs funcs, PaintSweepGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float startAngle, float endAngle, void* userData)
  {
    (*(cast(PaintSweepGradientFunc*)userData))(funcs ? new PaintFuncs(funcs, false) : null, paintData, colorLine ? new ColorLine(colorLine, false) : null, x0, y0, startAngle, endAngle);
  }

  ptrFreezeGC(cast(void*)&func);
  hb_paint_funcs_set_sweep_gradient_func(funcs ? funcs.cPtr!hb_paint_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Perform a "image" paint operation.
 */
void paintImage(PaintFuncs funcs, void* paintData, Blob image, uint width, uint height, Tag format, float slant, GlyphExtents extents)
{
  hb_paint_image(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, image ? image.cPtr!hb_blob_t : null, width, height, format, slant, &extents);
}

/**
 * Perform a "linear-gradient" paint operation.
 */
void paintLinearGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float x1, float y1, float x2, float y2)
{
  hb_paint_linear_gradient(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, colorLine ? colorLine.cPtr!hb_color_line_t : null, x0, y0, x1, y1, x2, y2);
}

/**
 * Perform a "pop-clip" paint operation.
 */
void paintPopClip(PaintFuncs funcs, void* paintData)
{
  hb_paint_pop_clip(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData);
}

/**
 * Perform a "pop-group" paint operation.
 */
void paintPopGroup(PaintFuncs funcs, void* paintData, PaintCompositeMode mode)
{
  hb_paint_pop_group(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, mode);
}

/**
 * Perform a "pop-transform" paint operation.
 */
void paintPopTransform(PaintFuncs funcs, void* paintData)
{
  hb_paint_pop_transform(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData);
}

/**
 * Perform a "push-clip-glyph" paint operation.
 */
void paintPushClipGlyph(PaintFuncs funcs, void* paintData, Codepoint glyph, Font font)
{
  hb_paint_push_clip_glyph(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, glyph, font ? font.cPtr!hb_font_t : null);
}

/**
 * Perform a "push-clip-rect" paint operation.
 */
void paintPushClipRectangle(PaintFuncs funcs, void* paintData, float xmin, float ymin, float xmax, float ymax)
{
  hb_paint_push_clip_rectangle(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, xmin, ymin, xmax, ymax);
}

/**
 * Perform a "push-group" paint operation.
 */
void paintPushGroup(PaintFuncs funcs, void* paintData)
{
  hb_paint_push_group(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData);
}

/**
 * Perform a "push-transform" paint operation.
 */
void paintPushTransform(PaintFuncs funcs, void* paintData, float xx, float yx, float xy, float yy, float dx, float dy)
{
  hb_paint_push_transform(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, xx, yx, xy, yy, dx, dy);
}

/**
 * Perform a "radial-gradient" paint operation.
 */
void paintRadialGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float r0, float x1, float y1, float r1)
{
  hb_paint_radial_gradient(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, colorLine ? colorLine.cPtr!hb_color_line_t : null, x0, y0, r0, x1, y1, r1);
}

/**
 * Perform a "sweep-gradient" paint operation.
 */
void paintSweepGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float startAngle, float endAngle)
{
  hb_paint_sweep_gradient(funcs ? funcs.cPtr!hb_paint_funcs_t : null, paintData, colorLine ? colorLine.cPtr!hb_color_line_t : null, x0, y0, startAngle, endAngle);
}

/**
 * An #hb_script_t corresponding to the ISO 15924 tag.
 */
Script scriptFromIso15924Tag(Tag tag)
{
  hb_script_t _cretval;
  _cretval = hb_script_from_iso15924_tag(tag);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * An #hb_script_t corresponding to the ISO 15924 tag.
 */
Script scriptFromString(ubyte[] str)
{
  hb_script_t _cretval;
  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_script_from_string(_str, str ? cast(int)str.length : 0);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * The horizontal #hb_direction_t of @script
 */
Direction scriptGetHorizontalDirection(Script script)
{
  hb_direction_t _cretval;
  _cretval = hb_script_get_horizontal_direction(script);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * An #hb_tag_t representing an ISO 15924 script tag.
 */
Tag scriptToIso15924Tag(Script script)
{
  Tag _retval;
  _retval = hb_script_to_iso15924_tag(script);
  return _retval;
}

/**
 * `true` if all properties of @a equal those of @b, `false` otherwise.
 */
Bool segmentPropertiesEqual(SegmentProperties a, SegmentProperties b)
{
  Bool _retval;
  _retval = hb_segment_properties_equal(a ? a.cPtr!hb_segment_properties_t : null, b ? b.cPtr!hb_segment_properties_t : null);
  return _retval;
}

/**
 * A hash of @p.
 */
uint segmentPropertiesHash(SegmentProperties p)
{
  uint _retval;
  _retval = hb_segment_properties_hash(p ? p.cPtr!hb_segment_properties_t : null);
  return _retval;
}

/**
 * Fills in missing fields of @p from @src in a considered manner.
 *
 * First, if @p does not have direction set, direction is copied from @src.
 *
 * Next, if @p and @src have the same direction (which can be unset), if @p
 * does not have script set, script is copied from @src.
 *
 * Finally, if @p and @src have the same direction and script (which either
 * can be unset), if @p does not have language set, language is copied from
 * @src.
 */
void segmentPropertiesOverlay(SegmentProperties p, SegmentProperties src)
{
  hb_segment_properties_overlay(p ? p.cPtr!hb_segment_properties_t : null, src ? src.cPtr!hb_segment_properties_t : null);
}

/**
 * Adds @codepoint to @set.
 */
void setAdd(Set set, Codepoint codepoint)
{
  hb_set_add(set ? set.cPtr!hb_set_t : null, codepoint);
}

/**
 * Adds all of the elements from @first to @last
 * (inclusive) to @set.
 */
void setAddRange(Set set, Codepoint first, Codepoint last)
{
  hb_set_add_range(set ? set.cPtr!hb_set_t : null, first, last);
}

/**
 * Adds @num_codepoints codepoints to a set at once.
 * The codepoints array must be in increasing order,
 * with size at least @num_codepoints.
 */
void setAddSortedArray(Set set, Codepoint[] sortedCodepoints)
{
  auto _sortedCodepoints = cast(const(hb_codepoint_t)*)sortedCodepoints.ptr;
  hb_set_add_sorted_array(set ? set.cPtr!hb_set_t : null, _sortedCodepoints, sortedCodepoints ? cast(uint)sortedCodepoints.length : 0);
}

/**
 * `true` if allocation succeeded, `false` otherwise
 */
Bool setAllocationSuccessful(Set set)
{
  Bool _retval;
  _retval = hb_set_allocation_successful(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * Clears out the contents of a set.
 */
void setClear(Set set)
{
  hb_set_clear(set ? set.cPtr!hb_set_t : null);
}

/**
 * Newly-allocated set.
 */
Set setCopy(Set set)
{
  hb_set_t* _cretval;
  _cretval = hb_set_copy(set ? set.cPtr!hb_set_t : null);
  Set _retval = new Set(cast(hb_set_t*)_cretval, true);
  return _retval;
}

/**
 * The new #hb_set_t
 */
Set setCreate()
{
  hb_set_t* _cretval;
  _cretval = hb_set_create();
  Set _retval = new Set(cast(hb_set_t*)_cretval, true);
  return _retval;
}

/**
 * Removes @codepoint from @set.
 */
void setDel(Set set, Codepoint codepoint)
{
  hb_set_del(set ? set.cPtr!hb_set_t : null, codepoint);
}

/**
 * Removes all of the elements from @first to @last
 * (inclusive) from @set.
 *
 * If @last is #HB_SET_VALUE_INVALID, then all values
 * greater than or equal to @first are removed.
 */
void setDelRange(Set set, Codepoint first, Codepoint last)
{
  hb_set_del_range(set ? set.cPtr!hb_set_t : null, first, last);
}

/**
 * The empty #hb_set_t
 */
Set setGetEmpty()
{
  hb_set_t* _cretval;
  _cretval = hb_set_get_empty();
  Set _retval = new Set(cast(hb_set_t*)_cretval, true);
  return _retval;
}

/**
 * maximum of @set, or #HB_SET_VALUE_INVALID if @set is empty.
 */
Codepoint setGetMax(Set set)
{
  Codepoint _retval;
  _retval = hb_set_get_max(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * minimum of @set, or #HB_SET_VALUE_INVALID if @set is empty.
 */
Codepoint setGetMin(Set set)
{
  Codepoint _retval;
  _retval = hb_set_get_min(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * The population of @set
 */
uint setGetPopulation(Set set)
{
  uint _retval;
  _retval = hb_set_get_population(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * `true` if @codepoint is in @set, `false` otherwise
 */
Bool setHas(Set set, Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_has(set ? set.cPtr!hb_set_t : null, codepoint);
  return _retval;
}

/**
 * A hash of @set.
 */
uint setHash(Set set)
{
  uint _retval;
  _retval = hb_set_hash(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * Makes @set the intersection of @set and @other.
 */
void setIntersect(Set set, Set other)
{
  hb_set_intersect(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
}

/**
 * Inverts the contents of @set.
 */
void setInvert(Set set)
{
  hb_set_invert(set ? set.cPtr!hb_set_t : null);
}

/**
 * `true` if @set is empty
 */
Bool setIsEmpty(Set set)
{
  Bool _retval;
  _retval = hb_set_is_empty(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * `true` if the two sets are equal, `false` otherwise.
 */
Bool setIsEqual(Set set, Set other)
{
  Bool _retval;
  _retval = hb_set_is_equal(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * `true` if the set is inverted, `false` otherwise
 */
Bool setIsInverted(Set set)
{
  Bool _retval;
  _retval = hb_set_is_inverted(set ? set.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * `true` if the @set is a subset of (or equal to) @larger_set, `false` otherwise.
 */
Bool setIsSubset(Set set, Set largerSet)
{
  Bool _retval;
  _retval = hb_set_is_subset(set ? set.cPtr!hb_set_t : null, largerSet ? largerSet.cPtr!hb_set_t : null);
  return _retval;
}

/**
 * `true` if there was a next value, `false` otherwise
 */
Bool setNext(Set set, inout Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_next(set ? set.cPtr!hb_set_t : null, cast(hb_codepoint_t*)&codepoint);
  return _retval;
}

/**
 * the number of values written.
 */
uint setNextMany(Set set, Codepoint codepoint, Codepoint[] out_)
{
  uint _retval;
  auto _out_ = cast(hb_codepoint_t*)out_.ptr;
  _retval = hb_set_next_many(set ? set.cPtr!hb_set_t : null, codepoint, _out_, out_ ? cast(uint)out_.length : 0);
  return _retval;
}

/**
 * `true` if there was a next range, `false` otherwise
 */
Bool setNextRange(Set set, out Codepoint first, inout Codepoint last)
{
  Bool _retval;
  _retval = hb_set_next_range(set ? set.cPtr!hb_set_t : null, cast(hb_codepoint_t*)&first, cast(hb_codepoint_t*)&last);
  return _retval;
}

/**
 * `true` if there was a previous value, `false` otherwise
 */
Bool setPrevious(Set set, inout Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_previous(set ? set.cPtr!hb_set_t : null, cast(hb_codepoint_t*)&codepoint);
  return _retval;
}

/**
 * `true` if there was a previous range, `false` otherwise
 */
Bool setPreviousRange(Set set, inout Codepoint first, out Codepoint last)
{
  Bool _retval;
  _retval = hb_set_previous_range(set ? set.cPtr!hb_set_t : null, cast(hb_codepoint_t*)&first, cast(hb_codepoint_t*)&last);
  return _retval;
}

/**
 * Makes the contents of @set equal to the contents of @other.
 */
void setSet(Set set, Set other)
{
  hb_set_set(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
}

/**
 * Subtracts the contents of @other from @set.
 */
void setSubtract(Set set, Set other)
{
  hb_set_subtract(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
}

/**
 * Makes @set the symmetric difference of @set
 * and @other.
 */
void setSymmetricDifference(Set set, Set other)
{
  hb_set_symmetric_difference(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
}

/**
 * Makes @set the union of @set and @other.
 */
void setUnion(Set set, Set other)
{
  hb_set_union(set ? set.cPtr!hb_set_t : null, other ? other.cPtr!hb_set_t : null);
}

/**
 * Shapes @buffer using @font turning its Unicode characters content to
 * positioned glyphs. If @features is not `NULL`, it will be used to control the
 * features applied during shaping. If two @features have the same tag but
 * overlapping ranges the value of the feature with the higher index takes
 * precedence.
 */
void shape(Font font, Buffer buffer, Feature[] features)
{
  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;
  hb_shape(font ? font.cPtr!hb_font_t : null, buffer ? buffer.cPtr!hb_buffer_t : null, _features, features ? cast(uint)features.length : 0);
}

/**
 * false if all shapers failed, true otherwise
 */
Bool shapeFull(Font font, Buffer buffer, Feature[] features, string[] shaperList)
{
  Bool _retval;
  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _retval = hb_shape_full(font ? font.cPtr!hb_font_t : null, buffer ? buffer.cPtr!hb_buffer_t : null, _features, features ? cast(uint)features.length : 0, _shaperList);
  return _retval;
}

/**
 * false if all shapers failed, true otherwise
 *
 * XSince: EXPERIMENTAL
 */
Bool shapeJustify(Font font, Buffer buffer, Feature[] features, string[] shaperList, float minTargetAdvance, float maxTargetAdvance, inout float advance, out Tag varTag, out float varValue)
{
  Bool _retval;
  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _retval = hb_shape_justify(font ? font.cPtr!hb_font_t : null, buffer ? buffer.cPtr!hb_buffer_t : null, _features, features ? cast(uint)features.length : 0, _shaperList, minTargetAdvance, maxTargetAdvance, cast(float*)&advance, cast(hb_tag_t*)&varTag, cast(float*)&varValue);
  return _retval;
}

/**
 * an array of
 * constant strings
 */
string[] shapeListShapers()
{
  const(char*)* _cretval;
  _cretval = hb_shape_list_shapers();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * The shaping plan
 */
ShapePlan shapePlanCreate(HBFace face, SegmentProperties props, Feature[] userFeatures, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create(face ? face.cPtr!hb_face_t : null, props ? props.cPtr!hb_segment_properties_t : null, _userFeatures, userFeatures ? cast(uint)userFeatures.length : 0, _shaperList);
  ShapePlan _retval = new ShapePlan(cast(hb_shape_plan_t*)_cretval, true);
  return _retval;
}

/**
 * The shaping plan
 */
ShapePlan shapePlanCreate2(HBFace face, SegmentProperties props, Feature[] userFeatures, int[] coords, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  auto _coords = cast(const(int)*)coords.ptr;
  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create2(face ? face.cPtr!hb_face_t : null, props ? props.cPtr!hb_segment_properties_t : null, _userFeatures, userFeatures ? cast(uint)userFeatures.length : 0, _coords, coords ? cast(uint)coords.length : 0, _shaperList);
  ShapePlan _retval = new ShapePlan(cast(hb_shape_plan_t*)_cretval, true);
  return _retval;
}

/**
 * The shaping plan
 */
ShapePlan shapePlanCreateCached(HBFace face, SegmentProperties props, Feature[] userFeatures, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create_cached(face ? face.cPtr!hb_face_t : null, props ? props.cPtr!hb_segment_properties_t : null, _userFeatures, userFeatures ? cast(uint)userFeatures.length : 0, _shaperList);
  ShapePlan _retval = new ShapePlan(cast(hb_shape_plan_t*)_cretval, true);
  return _retval;
}

/**
 * The shaping plan
 */
ShapePlan shapePlanCreateCached2(HBFace face, SegmentProperties props, Feature[] userFeatures, int[] coords, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  auto _coords = cast(const(int)*)coords.ptr;
  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create_cached2(face ? face.cPtr!hb_face_t : null, props ? props.cPtr!hb_segment_properties_t : null, _userFeatures, userFeatures ? cast(uint)userFeatures.length : 0, _coords, coords ? cast(uint)coords.length : 0, _shaperList);
  ShapePlan _retval = new ShapePlan(cast(hb_shape_plan_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if success, `false` otherwise.
 */
Bool shapePlanExecute(ShapePlan shapePlan, Font font, Buffer buffer, Feature[] features)
{
  Bool _retval;
  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *obj.cPtr!hb_feature_t;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;
  _retval = hb_shape_plan_execute(shapePlan ? shapePlan.cPtr!hb_shape_plan_t : null, font ? font.cPtr!hb_font_t : null, buffer ? buffer.cPtr!hb_buffer_t : null, _features, features ? cast(uint)features.length : 0);
  return _retval;
}

/**
 * The empty shaping plan
 */
ShapePlan shapePlanGetEmpty()
{
  hb_shape_plan_t* _cretval;
  _cretval = hb_shape_plan_get_empty();
  ShapePlan _retval = new ShapePlan(cast(hb_shape_plan_t*)_cretval, true);
  return _retval;
}

/**
 * The shaper
 */
string shapePlanGetShaper(ShapePlan shapePlan)
{
  const(char)* _cretval;
  _cretval = hb_shape_plan_get_shaper(shapePlan ? shapePlan.cPtr!hb_shape_plan_t : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Corresponding axis or default value to a style tag.
 */
float styleGetValue(Font font, StyleTag styleTag)
{
  float _retval;
  _retval = hb_style_get_value(font ? font.cPtr!hb_font_t : null, styleTag);
  return _retval;
}

/**
 * The #hb_tag_t corresponding to @str
 */
Tag tagFromString(ubyte[] str)
{
  Tag _retval;
  auto _str = cast(const(ubyte)*)str.ptr;
  _retval = hb_tag_from_string(_str, str ? cast(int)str.length : 0);
  return _retval;
}

/**
 * The #hb_unicode_combining_class_t of @unicode
 */
UnicodeCombiningClass unicodeCombiningClass(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_unicode_combining_class_t _cretval;
  _cretval = hb_unicode_combining_class(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, unicode);
  UnicodeCombiningClass _retval = cast(UnicodeCombiningClass)_cretval;
  return _retval;
}

/**
 * `true` if @a and @b composed, `false` otherwise
 */
Bool unicodeCompose(UnicodeFuncs ufuncs, Codepoint a, Codepoint b, out Codepoint ab)
{
  Bool _retval;
  _retval = hb_unicode_compose(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, a, b, cast(hb_codepoint_t*)&ab);
  return _retval;
}

/**
 * `true` if @ab was decomposed, `false` otherwise
 */
Bool unicodeDecompose(UnicodeFuncs ufuncs, Codepoint ab, out Codepoint a, out Codepoint b)
{
  Bool _retval;
  _retval = hb_unicode_decompose(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, ab, cast(hb_codepoint_t*)&a, cast(hb_codepoint_t*)&b);
  return _retval;
}

/**
 * length of @decomposed.
 */
uint unicodeDecomposeCompatibility(UnicodeFuncs ufuncs, Codepoint u, out Codepoint decomposed)
{
  uint _retval;
  _retval = hb_unicode_decompose_compatibility(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, u, cast(hb_codepoint_t*)&decomposed);
  return _retval;
}

/**
 * Don't use. Not used by HarfBuzz.
 */
uint unicodeEastasianWidth(UnicodeFuncs ufuncs, Codepoint unicode)
{
  uint _retval;
  _retval = hb_unicode_eastasian_width(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, unicode);
  return _retval;
}

/**
 * The Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsCreate(UnicodeFuncs parent)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_create(parent ? parent.cPtr!hb_unicode_funcs_t : null);
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * a pointer to the #hb_unicode_funcs_t Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetDefault()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_default();
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, false);
  return _retval;
}

/**
 * The empty Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetEmpty()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_empty();
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * The parent Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetParent(UnicodeFuncs ufuncs)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_parent(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null);
  UnicodeFuncs _retval = new UnicodeFuncs(cast(hb_unicode_funcs_t*)_cretval, true);
  return _retval;
}

/**
 * `true` if @ufuncs is immutable, `false` otherwise
 */
Bool unicodeFuncsIsImmutable(UnicodeFuncs ufuncs)
{
  Bool _retval;
  _retval = hb_unicode_funcs_is_immutable(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null);
  return _retval;
}

/**
 * Makes the specified Unicode-functions structure
 * immutable.
 */
void unicodeFuncsMakeImmutable(UnicodeFuncs ufuncs)
{
  hb_unicode_funcs_make_immutable(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null);
}

/**
 * Sets the implementation function for #hb_unicode_combining_class_func_t.
 */
void unicodeFuncsSetCombiningClassFunc(UnicodeFuncs ufuncs, UnicodeCombiningClassFunc func)
{
  extern(C) hb_unicode_combining_class_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    UnicodeCombiningClass _dretval;

    _dretval = (*(cast(UnicodeCombiningClassFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, unicode);
    hb_unicode_combining_class_t _retval = cast(hb_unicode_combining_class_t)_dretval;

    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_combining_class_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_compose_func_t.
 */
void unicodeFuncsSetComposeFunc(UnicodeFuncs ufuncs, UnicodeComposeFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t a, hb_codepoint_t b, hb_codepoint_t* ab, void* userData)
  {
    hb_bool_t _retval = (*(cast(UnicodeComposeFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, a, b, *ab);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_compose_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_decompose_func_t.
 */
void unicodeFuncsSetDecomposeFunc(UnicodeFuncs ufuncs, UnicodeDecomposeFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t ab, hb_codepoint_t* a, hb_codepoint_t* b, void* userData)
  {
    hb_bool_t _retval = (*(cast(UnicodeDecomposeFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, ab, *a, *b);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_decompose_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_eastasian_width_func_t.
 */
void unicodeFuncsSetEastasianWidthFunc(UnicodeFuncs ufuncs, UnicodeEastasianWidthFunc func)
{
  extern(C) uint _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    uint _retval = (*(cast(UnicodeEastasianWidthFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, unicode);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_eastasian_width_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_general_category_func_t.
 */
void unicodeFuncsSetGeneralCategoryFunc(UnicodeFuncs ufuncs, UnicodeGeneralCategoryFunc func)
{
  extern(C) hb_unicode_general_category_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    UnicodeGeneralCategory _dretval;

    _dretval = (*(cast(UnicodeGeneralCategoryFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, unicode);
    hb_unicode_general_category_t _retval = cast(hb_unicode_general_category_t)_dretval;

    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_general_category_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_mirroring_func_t.
 */
void unicodeFuncsSetMirroringFunc(UnicodeFuncs ufuncs, UnicodeMirroringFunc func)
{
  extern(C) hb_codepoint_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    hb_codepoint_t _retval = (*(cast(UnicodeMirroringFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, unicode);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_mirroring_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Sets the implementation function for #hb_unicode_script_func_t.
 */
void unicodeFuncsSetScriptFunc(UnicodeFuncs ufuncs, UnicodeScriptFunc func)
{
  extern(C) hb_script_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    Script _dretval;

    _dretval = (*(cast(UnicodeScriptFunc*)userData))(ufuncs ? new UnicodeFuncs(ufuncs, false) : null, unicode);
    hb_script_t _retval = cast(hb_script_t)_dretval;

    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  hb_unicode_funcs_set_script_func(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * The #hb_unicode_general_category_t of @unicode
 */
UnicodeGeneralCategory unicodeGeneralCategory(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_unicode_general_category_t _cretval;
  _cretval = hb_unicode_general_category(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, unicode);
  UnicodeGeneralCategory _retval = cast(UnicodeGeneralCategory)_cretval;
  return _retval;
}

/**
 * The #hb_codepoint_t of the Mirroring Glyph for @unicode
 */
Codepoint unicodeMirroring(UnicodeFuncs ufuncs, Codepoint unicode)
{
  Codepoint _retval;
  _retval = hb_unicode_mirroring(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, unicode);
  return _retval;
}

/**
 * The #hb_script_t of @unicode
 */
Script unicodeScript(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_script_t _cretval;
  _cretval = hb_unicode_script(ufuncs ? ufuncs.cPtr!hb_unicode_funcs_t : null, unicode);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * `true` if @str is successfully parsed, `false` otherwise
 */
Bool variationFromString(ubyte[] str, out Variation variation)
{
  Bool _retval;
  auto _str = cast(const(ubyte)*)str.ptr;
  hb_variation_t _variation;
  _retval = hb_variation_from_string(_str, str ? cast(int)str.length : 0, &_variation);
  variation = new Variation(cast(void*)&_variation);
  return _retval;
}
