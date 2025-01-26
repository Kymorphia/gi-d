module HarfBuzz.Global;

import GLib.Types;
import Gid.gid;
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
 * Fetches the name identifier of the specified feature type in the face's `name` table.
 * Params:
 *   face = #hb_face_t to work upon
 *   featureType = The #hb_aat_layout_feature_type_t of the requested feature type
 * Returns: Name identifier of the requested feature type
 */
OtNameId aatLayoutFeatureTypeGetNameId(HBFace face, AatLayoutFeatureType featureType)
{
  OtNameId _retval;
  _retval = hb_aat_layout_feature_type_get_name_id(face ? cast(hb_face_t*)face.cPtr(false) : null, featureType);
  return _retval;
}

/**
 * Fetches a list of the selectors available for the specified feature in the given face.
 * If upon return, default_index is set to #HB_AAT_LAYOUT_NO_SELECTOR_INDEX, then
 * the feature type is non-exclusive.  Otherwise, default_index is the index of
 * the selector that is selected by default.
 * Params:
 *   face = #hb_face_t to work upon
 *   featureType = The #hb_aat_layout_feature_type_t of the requested feature type
 *   startOffset = offset of the first feature type to retrieve
 *   selectors = A buffer pointer. The selectors available for the feature type queries.
 *   defaultIndex = The index of the feature's default selector, if any
 * Returns: Number of all available feature selectors
 */
uint aatLayoutFeatureTypeGetSelectorInfos(HBFace face, AatLayoutFeatureType featureType, uint startOffset, ref AatLayoutFeatureSelectorInfo[] selectors, out uint defaultIndex)
{
  uint _retval;
  uint _selectorCount;
  _retval = hb_aat_layout_feature_type_get_selector_infos(face ? cast(hb_face_t*)face.cPtr(false) : null, featureType, startOffset, &_selectorCount, selectors.ptr, cast(uint*)&defaultIndex);
  return _retval;
}

/**
 * Fetches a list of the AAT feature types included in the specified face.
 * Params:
 *   face = #hb_face_t to work upon
 *   startOffset = offset of the first feature type to retrieve
 *   features = Array of feature types found
 * Returns: Number of all available feature types.
 */
uint aatLayoutGetFeatureTypes(HBFace face, uint startOffset, ref AatLayoutFeatureType[] features)
{
  uint _retval;
  uint _featureCount;
  _retval = hb_aat_layout_get_feature_types(face ? cast(hb_face_t*)face.cPtr(false) : null, startOffset, &_featureCount, features.ptr);
  return _retval;
}

/**
 * Tests whether the specified face includes any positioning information
 * in the `kerx` table.
 * <note>Note: does not examine the `GPOS` table.</note>
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool aatLayoutHasPositioning(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_positioning(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the specified face includes any substitutions in the
 * `morx` or `mort` tables.
 * <note>Note: does not examine the `GSUB` table.</note>
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool aatLayoutHasSubstitution(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_substitution(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the specified face includes any tracking information
 * in the `trak` table.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool aatLayoutHasTracking(HBFace face)
{
  Bool _retval;
  _retval = hb_aat_layout_has_tracking(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Makes a writable copy of blob.
 * Params:
 *   blob = A blob.
 * Returns: The new blob, or nullptr if allocation failed
 */
Blob blobCopyWritableOrFail(Blob blob)
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_copy_writable_or_fail(blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new blob containing the data from the
 * specified binary font file.
 * Params:
 *   fileName = A font filename
 * Returns: An #hb_blob_t pointer with the content of the file,
 *   or [HarfBuzz.Global.blobGetEmpty] if failed.
 */
Blob blobCreateFromFile(string fileName)
{
  hb_blob_t* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = hb_blob_create_from_file(_fileName);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new blob containing the data from the
 * specified binary font file.
 * Params:
 *   fileName = A font filename
 * Returns: An #hb_blob_t pointer with the content of the file,
 *   or `NULL` if failed.
 */
Blob blobCreateFromFileOrFail(string fileName)
{
  hb_blob_t* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = hb_blob_create_from_file_or_fail(_fileName);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Returns a blob that represents a range of bytes in parent.  The new
 * blob is always created with #HB_MEMORY_MODE_READONLY, meaning that it
 * will never modify data in the parent blob.  The parent data is not
 * expected to be modified, and will result in undefined behavior if it
 * is.
 * Makes parent immutable.
 * Params:
 *   parent = Parent blob.
 *   offset = Start offset of sub-blob within parent, in bytes.
 *   length = Length of sub-blob.
 * Returns: New blob, or the empty blob if something failed or if
 *   length is zero or offset is beyond the end of parent's data.  Destroy
 *   with [HarfBuzz.Global.blobDestroy].
 */
Blob blobCreateSubBlob(Blob parent, uint offset, uint length)
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_create_sub_blob(parent ? cast(hb_blob_t*)parent.cPtr(false) : null, offset, length);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the data from a blob.
 * Params:
 *   blob = a blob.
 * Returns: the byte data of blob.
 */
string blobGetData(Blob blob)
{
  const(char)* _cretval;
  uint _cretlength;
  _cretval = hb_blob_get_data(blob ? cast(hb_blob_t*)blob.cPtr(false) : null, &_cretlength);
  string _retval;

  if (_cretval)
  {
    _retval = cast(string )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Tries to make blob data writable $(LPAREN)possibly copying it$(RPAREN) and
 * return pointer to data.
 * Fails if blob has been made immutable, or if memory allocation
 * fails.
 * Params:
 *   blob = a blob.
 * Returns: Writable blob data,
 *   or `NULL` if failed.
 */
string blobGetDataWritable(Blob blob)
{
  char* _cretval;
  uint _cretlength;
  _cretval = hb_blob_get_data_writable(blob ? cast(hb_blob_t*)blob.cPtr(false) : null, &_cretlength);
  string _retval;

  if (_cretval)
  {
    _retval = cast(string )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Returns the singleton empty blob.
 * See TODO:link object types for more information.
 * Returns: The empty blob.
 */
Blob blobGetEmpty()
{
  hb_blob_t* _cretval;
  _cretval = hb_blob_get_empty();
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the length of a blob's data.
 * Params:
 *   blob = a blob.
 * Returns: the length of blob data in bytes.
 */
uint blobGetLength(Blob blob)
{
  uint _retval;
  _retval = hb_blob_get_length(blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether a blob is immutable.
 * Params:
 *   blob = a blob.
 * Returns: `true` if blob is immutable, `false` otherwise
 */
Bool blobIsImmutable(Blob blob)
{
  Bool _retval;
  _retval = hb_blob_is_immutable(blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
  return _retval;
}

/**
 * Makes a blob immutable.
 * Params:
 *   blob = a blob
 */
void blobMakeImmutable(Blob blob)
{
  hb_blob_make_immutable(blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
}

/**
 * Appends a character with the Unicode value of codepoint to buffer, and
 * gives it the initial cluster value of cluster. Clusters can be any thing
 * the client wants, they are usually used to refer to the index of the
 * character in the input text stream and are output in
 * #hb_glyph_info_t.cluster field.
 * This function does not check the validity of codepoint, it is up to the
 * caller to ensure it is a valid Unicode code point.
 * Params:
 *   buffer = An #hb_buffer_t
 *   codepoint = A Unicode code point.
 *   cluster = The cluster value of codepoint.
 */
void bufferAdd(Buffer buffer, Codepoint codepoint, uint cluster)
{
  hb_buffer_add(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, codepoint, cluster);
}

/**
 * Appends characters from text array to buffer. The item_offset is the
 * position of the first character from text that will be appended, and
 * item_length is the number of character. When shaping part of a larger text
 * $(LPAREN)e.g. a run of text from a paragraph$(RPAREN), instead of passing just the substring
 * corresponding to the run, it is preferable to pass the whole
 * paragraph and specify the run start and length as item_offset and
 * item_length, respectively, to give HarfBuzz the full context to be able,
 * for example, to do cross-run Arabic shaping or properly handle combining
 * marks at stat of run.
 * This function does not check the validity of text, it is up to the caller
 * to ensure it contains a valid Unicode scalar values.  In contrast,
 * [HarfBuzz.Global.bufferAddUtf32] can be used that takes similar input but performs
 * sanity-check on the input.
 * Params:
 *   buffer = a #hb_buffer_t to append characters to.
 *   text = an array of Unicode code points to append.
 *   itemOffset = the offset of the first code point to add to the buffer.
 *   itemLength = the number of code points to add to the buffer, or -1 for the
 *     end of text $(LPAREN)assuming it is `NULL` terminated$(RPAREN).
 */
void bufferAddCodepoints(Buffer buffer, Codepoint[] text, uint itemOffset, int itemLength)
{
  int _textLength;
  if (text)
    _textLength = cast(int)text.length;

  auto _text = cast(const(hb_codepoint_t)*)text.ptr;
  hb_buffer_add_codepoints(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _text, _textLength, itemOffset, itemLength);
}

/**
 * Similar to [HarfBuzz.Global.bufferAddCodepoints], but allows only access to first 256
 * Unicode code points that can fit in 8-bit strings.
 * <note>Has nothing to do with non-Unicode Latin-1 encoding.</note>
 * Params:
 *   buffer = An #hb_buffer_t
 *   text = an array of UTF-8
 *     characters to append
 *   itemOffset = the offset of the first character to add to the buffer
 *   itemLength = the number of characters to add to the buffer, or -1 for the
 *     end of text $(LPAREN)assuming it is `NULL` terminated$(RPAREN)
 */
void bufferAddLatin1(Buffer buffer, ubyte[] text, uint itemOffset, int itemLength)
{
  int _textLength;
  if (text)
    _textLength = cast(int)text.length;

  auto _text = cast(const(ubyte)*)text.ptr;
  hb_buffer_add_latin1(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _text, _textLength, itemOffset, itemLength);
}

/**
 * See [HarfBuzz.Global.bufferAddCodepoints].
 * Replaces invalid UTF-16 characters with the buffer replacement code point,
 * see [HarfBuzz.Global.bufferSetReplacementCodepoint].
 * Params:
 *   buffer = An #hb_buffer_t
 *   text = An array of UTF-16 characters to append
 *   itemOffset = The offset of the first character to add to the buffer
 *   itemLength = The number of characters to add to the buffer, or -1 for the
 *     end of text $(LPAREN)assuming it is `NULL` terminated$(RPAREN)
 */
void bufferAddUtf16(Buffer buffer, ushort[] text, uint itemOffset, int itemLength)
{
  int _textLength;
  if (text)
    _textLength = cast(int)text.length;

  auto _text = cast(const(ushort)*)text.ptr;
  hb_buffer_add_utf16(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _text, _textLength, itemOffset, itemLength);
}

/**
 * See [HarfBuzz.Global.bufferAddCodepoints].
 * Replaces invalid UTF-32 characters with the buffer replacement code point,
 * see [HarfBuzz.Global.bufferSetReplacementCodepoint].
 * Params:
 *   buffer = An #hb_buffer_t
 *   text = An array of UTF-32 characters to append
 *   itemOffset = The offset of the first character to add to the buffer
 *   itemLength = The number of characters to add to the buffer, or -1 for the
 *     end of text $(LPAREN)assuming it is `NULL` terminated$(RPAREN)
 */
void bufferAddUtf32(Buffer buffer, uint[] text, uint itemOffset, int itemLength)
{
  int _textLength;
  if (text)
    _textLength = cast(int)text.length;

  auto _text = cast(const(uint)*)text.ptr;
  hb_buffer_add_utf32(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _text, _textLength, itemOffset, itemLength);
}

/**
 * See [HarfBuzz.Global.bufferAddCodepoints].
 * Replaces invalid UTF-8 characters with the buffer replacement code point,
 * see [HarfBuzz.Global.bufferSetReplacementCodepoint].
 * Params:
 *   buffer = An #hb_buffer_t
 *   text = An array of UTF-8
 *     characters to append.
 *   itemOffset = The offset of the first character to add to the buffer.
 *   itemLength = The number of characters to add to the buffer, or -1 for the
 *     end of text $(LPAREN)assuming it is `NULL` terminated$(RPAREN).
 */
void bufferAddUtf8(Buffer buffer, ubyte[] text, uint itemOffset, int itemLength)
{
  int _textLength;
  if (text)
    _textLength = cast(int)text.length;

  auto _text = cast(const(ubyte)*)text.ptr;
  hb_buffer_add_utf8(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _text, _textLength, itemOffset, itemLength);
}

/**
 * Check if allocating memory for the buffer succeeded.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: `true` if buffer memory allocation succeeded, `false` otherwise.
 */
Bool bufferAllocationSuccessful(Buffer buffer)
{
  Bool _retval;
  _retval = hb_buffer_allocation_successful(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * Append $(LPAREN)part of$(RPAREN) contents of another buffer to this buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 *   source = source #hb_buffer_t
 *   start = start index into source buffer to copy.  Use 0 to copy from start of buffer.
 *   end = end index into source buffer to copy.  Use HB_FEATURE_GLOBAL_END to copy to end of buffer.
 */
void bufferAppend(Buffer buffer, Buffer source, uint start, uint end)
{
  hb_buffer_append(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, source ? cast(hb_buffer_t*)source.cPtr(false) : null, start, end);
}

/**
 * Similar to [HarfBuzz.Global.bufferReset], but does not clear the Unicode functions and
 * the replacement code point.
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferClearContents(Buffer buffer)
{
  hb_buffer_clear_contents(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Creates a new #hb_buffer_t with all properties to defaults.
 * Returns: A newly allocated #hb_buffer_t with a reference count of 1. The initial
 *   reference count should be released with [HarfBuzz.Global.bufferDestroy] when you are done
 *   using the #hb_buffer_t. This function never returns `NULL`. If memory cannot
 *   be allocated, a special #hb_buffer_t object will be returned on which
 *   [HarfBuzz.Global.bufferAllocationSuccessful] returns `false`.
 */
Buffer bufferCreate()
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_create();
  auto _retval = _cretval ? new Buffer(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #hb_buffer_t, similar to [HarfBuzz.Global.bufferCreate]. The only
 * difference is that the buffer is configured similarly to src.
 * Params:
 *   src = An #hb_buffer_t
 * Returns: A newly allocated #hb_buffer_t, similar to [HarfBuzz.Global.bufferCreate].
 */
Buffer bufferCreateSimilar(Buffer src)
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_create_similar(src ? cast(hb_buffer_t*)src.cPtr(false) : null);
  auto _retval = _cretval ? new Buffer(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Deserializes glyphs buffer from textual representation in the format
 * produced by [HarfBuzz.Global.bufferSerializeGlyphs].
 * Params:
 *   buffer = an #hb_buffer_t buffer.
 *   buf = string to deserialize
 *   endPtr = output pointer to the character after last
 *     consumed one.
 *   font = font for getting glyph IDs
 *   format = the #hb_buffer_serialize_format_t of the input buf
 * Returns: `true` if parse was successful, `false` if an error
 *   occurred.
 */
Bool bufferDeserializeGlyphs(Buffer buffer, string buf, out string endPtr, Font font, BufferSerializeFormat format)
{
  Bool _retval;
  int _bufLen;
  if (buf)
    _bufLen = cast(int)buf.length;

  auto _buf = cast(const(char)*)buf.ptr;
  char* _endPtr;
  _retval = hb_buffer_deserialize_glyphs(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _buf, _bufLen, &_endPtr, font ? cast(hb_font_t*)font.cPtr(false) : null, format);
  endPtr = _endPtr.fromCString(true);
  return _retval;
}

/**
 * Deserializes Unicode buffer from textual representation in the format
 * produced by [HarfBuzz.Global.bufferSerializeUnicode].
 * Params:
 *   buffer = an #hb_buffer_t buffer.
 *   buf = string to deserialize
 *   endPtr = output pointer to the character after last
 *     consumed one.
 *   format = the #hb_buffer_serialize_format_t of the input buf
 * Returns: `true` if parse was successful, `false` if an error
 *   occurred.
 */
Bool bufferDeserializeUnicode(Buffer buffer, string buf, out string endPtr, BufferSerializeFormat format)
{
  Bool _retval;
  int _bufLen;
  if (buf)
    _bufLen = cast(int)buf.length;

  auto _buf = cast(const(char)*)buf.ptr;
  char* _endPtr;
  _retval = hb_buffer_deserialize_unicode(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _buf, _bufLen, &_endPtr, format);
  endPtr = _endPtr.fromCString(true);
  return _retval;
}

/**
 * If dottedcircle_glyph is $(LPAREN)hb_codepoint_t$(RPAREN) -1 then #HB_BUFFER_DIFF_FLAG_DOTTED_CIRCLE_PRESENT
 * and #HB_BUFFER_DIFF_FLAG_NOTDEF_PRESENT are never returned.  This should be used by most
 * callers if just comparing two buffers is needed.
 * Params:
 *   buffer = a buffer.
 *   reference = other buffer to compare to.
 *   dottedcircleGlyph = glyph id of U+25CC DOTTED CIRCLE, or $(LPAREN)hb_codepoint_t$(RPAREN) -1.
 *   positionFuzz = allowed absolute difference in position values.
 * Returns:
 */
BufferDiffFlags bufferDiff(Buffer buffer, Buffer reference, Codepoint dottedcircleGlyph, uint positionFuzz)
{
  hb_buffer_diff_flags_t _cretval;
  _cretval = hb_buffer_diff(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, reference ? cast(hb_buffer_t*)reference.cPtr(false) : null, dottedcircleGlyph, positionFuzz);
  BufferDiffFlags _retval = cast(BufferDiffFlags)_cretval;
  return _retval;
}

/**
 * Fetches the cluster level of a buffer. The #hb_buffer_cluster_level_t
 * dictates one aspect of how HarfBuzz will treat non-base characters
 * during shaping.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The cluster level of buffer
 */
BufferClusterLevel bufferGetClusterLevel(Buffer buffer)
{
  hb_buffer_cluster_level_t _cretval;
  _cretval = hb_buffer_get_cluster_level(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  BufferClusterLevel _retval = cast(BufferClusterLevel)_cretval;
  return _retval;
}

/**
 * Fetches the type of buffer contents. Buffers are either empty, contain
 * characters $(LPAREN)before shaping$(RPAREN), or contain glyphs $(LPAREN)the result of shaping$(RPAREN).
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The type of buffer contents
 */
BufferContentType bufferGetContentType(Buffer buffer)
{
  hb_buffer_content_type_t _cretval;
  _cretval = hb_buffer_get_content_type(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  BufferContentType _retval = cast(BufferContentType)_cretval;
  return _retval;
}

/**
 * See [HarfBuzz.Global.bufferSetDirection]
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The direction of the buffer.
 */
Direction bufferGetDirection(Buffer buffer)
{
  hb_direction_t _cretval;
  _cretval = hb_buffer_get_direction(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * Fetches an empty #hb_buffer_t.
 * Returns: The empty buffer
 */
Buffer bufferGetEmpty()
{
  hb_buffer_t* _cretval;
  _cretval = hb_buffer_get_empty();
  auto _retval = _cretval ? new Buffer(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the #hb_buffer_flags_t of buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer flags
 */
BufferFlags bufferGetFlags(Buffer buffer)
{
  hb_buffer_flags_t _cretval;
  _cretval = hb_buffer_get_flags(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  BufferFlags _retval = cast(BufferFlags)_cretval;
  return _retval;
}

/**
 * Returns buffer glyph information array.  Returned pointer
 * is valid as long as buffer contents are not modified.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer glyph information array.
 *   The value valid as long as buffer has not been modified.
 */
GlyphInfo[] bufferGetGlyphInfos(Buffer buffer)
{
  hb_glyph_info_t* _cretval;
  uint _cretlength;
  _cretval = hb_buffer_get_glyph_infos(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, &_cretlength);
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
 * Returns buffer glyph position array.  Returned pointer
 * is valid as long as buffer contents are not modified.
 * If buffer did not have positions before, the positions will be
 * initialized to zeros, unless this function is called from
 * within a buffer message callback $(LPAREN)see [HarfBuzz.Global.bufferSetMessageFunc]$(RPAREN),
 * in which case `NULL` is returned.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer glyph position array.
 *   The value valid as long as buffer has not been modified.
 */
GlyphPosition[] bufferGetGlyphPositions(Buffer buffer)
{
  hb_glyph_position_t* _cretval;
  uint _cretlength;
  _cretval = hb_buffer_get_glyph_positions(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, &_cretlength);
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
 * See [HarfBuzz.Global.bufferSetInvisibleGlyph].
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer invisible #hb_codepoint_t
 */
Codepoint bufferGetInvisibleGlyph(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_invisible_glyph(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * See [HarfBuzz.Global.bufferSetLanguage].
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The #hb_language_t of the buffer. Must not be freed by the caller.
 */
Language bufferGetLanguage(Buffer buffer)
{
  auto _retval = hb_buffer_get_language(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * Returns the number of items in the buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer length.
 *   The value valid as long as buffer has not been modified.
 */
uint bufferGetLength(Buffer buffer)
{
  uint _retval;
  _retval = hb_buffer_get_length(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * See [HarfBuzz.Global.bufferSetNotFoundGlyph].
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer not-found #hb_codepoint_t
 */
Codepoint bufferGetNotFoundGlyph(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_not_found_glyph(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the #hb_codepoint_t that replaces invalid entries for a given encoding
 * when adding text to buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The buffer replacement #hb_codepoint_t
 */
Codepoint bufferGetReplacementCodepoint(Buffer buffer)
{
  Codepoint _retval;
  _retval = hb_buffer_get_replacement_codepoint(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the script of buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The #hb_script_t of the buffer
 */
Script bufferGetScript(Buffer buffer)
{
  hb_script_t _cretval;
  _cretval = hb_buffer_get_script(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Sets props to the #hb_segment_properties_t of buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 *   props = The output #hb_segment_properties_t
 */
void bufferGetSegmentProperties(Buffer buffer, out SegmentProperties props)
{
  hb_segment_properties_t _props;
  hb_buffer_get_segment_properties(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, &_props);
  props = new SegmentProperties(cast(void*)&_props, false);
}

/**
 * Fetches the Unicode-functions structure of a buffer.
 * Params:
 *   buffer = An #hb_buffer_t
 * Returns: The Unicode-functions structure
 */
UnicodeFuncs bufferGetUnicodeFuncs(Buffer buffer)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_buffer_get_unicode_funcs(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Sets unset buffer segment properties based on buffer Unicode
 * contents.  If buffer is not empty, it must have content type
 * #HB_BUFFER_CONTENT_TYPE_UNICODE.
 * If buffer script is not set $(LPAREN)ie. is #HB_SCRIPT_INVALID$(RPAREN), it
 * will be set to the Unicode script of the first character in
 * the buffer that has a script other than #HB_SCRIPT_COMMON,
 * #HB_SCRIPT_INHERITED, and #HB_SCRIPT_UNKNOWN.
 * Next, if buffer direction is not set $(LPAREN)ie. is #HB_DIRECTION_INVALID$(RPAREN),
 * it will be set to the natural horizontal direction of the
 * buffer script as returned by [HarfBuzz.Global.scriptGetHorizontalDirection].
 * If [HarfBuzz.Global.scriptGetHorizontalDirection] returns #HB_DIRECTION_INVALID,
 * then #HB_DIRECTION_LTR is used.
 * Finally, if buffer language is not set $(LPAREN)ie. is #HB_LANGUAGE_INVALID$(RPAREN),
 * it will be set to the process's default language as returned by
 * [HarfBuzz.Global.languageGetDefault].  This may change in the future by
 * taking buffer script into consideration when choosing a language.
 * Note that [HarfBuzz.Global.languageGetDefault] is NOT threadsafe the first time
 * it is called.  See documentation for that function for details.
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferGuessSegmentProperties(Buffer buffer)
{
  hb_buffer_guess_segment_properties(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Returns whether buffer has glyph position data.
 * A buffer gains position data when [HarfBuzz.Global.bufferGetGlyphPositions] is called on it,
 * and cleared of position data when [HarfBuzz.Global.bufferClearContents] is called.
 * Params:
 *   buffer = an #hb_buffer_t.
 * Returns: `true` if the buffer has position array, `false` otherwise.
 */
Bool bufferHasPositions(Buffer buffer)
{
  Bool _retval;
  _retval = hb_buffer_has_positions(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
  return _retval;
}

/**
 * Reorders a glyph buffer to have canonical in-cluster glyph order / position.
 * The resulting clusters should behave identical to pre-reordering clusters.
 * <note>This has nothing to do with Unicode normalization.</note>
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferNormalizeGlyphs(Buffer buffer)
{
  hb_buffer_normalize_glyphs(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Pre allocates memory for buffer to fit at least size number of items.
 * Params:
 *   buffer = An #hb_buffer_t
 *   size = Number of items to pre allocate.
 * Returns: `true` if buffer memory allocation succeeded, `false` otherwise
 */
Bool bufferPreAllocate(Buffer buffer, uint size)
{
  Bool _retval;
  _retval = hb_buffer_pre_allocate(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, size);
  return _retval;
}

/**
 * Resets the buffer to its initial status, as if it was just newly created
 * with [HarfBuzz.Global.bufferCreate].
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferReset(Buffer buffer)
{
  hb_buffer_reset(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Reverses buffer contents.
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferReverse(Buffer buffer)
{
  hb_buffer_reverse(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Reverses buffer clusters.  That is, the buffer contents are
 * reversed, then each cluster $(LPAREN)consecutive items having the
 * same cluster number$(RPAREN) are reversed again.
 * Params:
 *   buffer = An #hb_buffer_t
 */
void bufferReverseClusters(Buffer buffer)
{
  hb_buffer_reverse_clusters(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null);
}

/**
 * Reverses buffer contents between start and end.
 * Params:
 *   buffer = An #hb_buffer_t
 *   start = start index
 *   end = end index
 */
void bufferReverseRange(Buffer buffer, uint start, uint end)
{
  hb_buffer_reverse_range(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, start, end);
}

/**
 * Parses a string into an #hb_buffer_serialize_format_t. Does not check if
 * str is a valid buffer serialization format, use
 * [HarfBuzz.Global.bufferSerializeListFormats] to get the list of supported formats.
 * Params:
 *   str = a string to parse
 * Returns: The parsed #hb_buffer_serialize_format_t.
 */
BufferSerializeFormat bufferSerializeFormatFromString(ubyte[] str)
{
  hb_buffer_serialize_format_t _cretval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_buffer_serialize_format_from_string(_str, _len);
  BufferSerializeFormat _retval = cast(BufferSerializeFormat)_cretval;
  return _retval;
}

/**
 * Converts format to the string corresponding it, or `NULL` if it is not a valid
 * #hb_buffer_serialize_format_t.
 * Params:
 *   format = an #hb_buffer_serialize_format_t to convert.
 * Returns: A `NULL` terminated string corresponding to format. Should not be freed.
 */
string bufferSerializeFormatToString(BufferSerializeFormat format)
{
  const(char)* _cretval;
  _cretval = hb_buffer_serialize_format_to_string(format);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Returns a list of supported buffer serialization formats.
 * Returns: A string array of buffer serialization formats. Should not be freed.
 */
string[] bufferSerializeListFormats()
{
  const(char*)* _cretval;
  _cretval = hb_buffer_serialize_list_formats();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] !is null; _cretlength++)
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
 * Params:
 *   buffer = An #hb_buffer_t
 *   clusterLevel = The cluster level to set on the buffer
 */
void bufferSetClusterLevel(Buffer buffer, BufferClusterLevel clusterLevel)
{
  hb_buffer_set_cluster_level(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, clusterLevel);
}

/**
 * Sets the type of buffer contents. Buffers are either empty, contain
 * characters $(LPAREN)before shaping$(RPAREN), or contain glyphs $(LPAREN)the result of shaping$(RPAREN).
 * You rarely need to call this function, since a number of other
 * functions transition the content type for you. Namely:
 * - A newly created buffer starts with content type
 * %HB_BUFFER_CONTENT_TYPE_INVALID. Calling [HarfBuzz.Global.bufferReset],
 * [HarfBuzz.Global.bufferClearContents], as well as calling [HarfBuzz.Global.bufferSetLength]
 * with an argument of zero all set the buffer content type to invalid
 * as well.
 * - Calling [HarfBuzz.Global.bufferAddUtf8], [HarfBuzz.Global.bufferAddUtf16],
 * [HarfBuzz.Global.bufferAddUtf32], [HarfBuzz.Global.bufferAddCodepoints] and
 * [HarfBuzz.Global.bufferAddLatin1] expect that buffer is either empty and
 * have a content type of invalid, or that buffer content type is
 * %HB_BUFFER_CONTENT_TYPE_UNICODE, and they also set the content
 * type to Unicode if they added anything to an empty buffer.
 * - Finally [HarfBuzz.Global.shape] and [HarfBuzz.Global.shapeFull] expect that the buffer
 * is either empty and have content type of invalid, or that buffer
 * content type is %HB_BUFFER_CONTENT_TYPE_UNICODE, and upon
 * success they set the buffer content type to
 * %HB_BUFFER_CONTENT_TYPE_GLYPHS.
 * The above transitions are designed such that one can use a buffer
 * in a loop of "reset : add-text : shape" without needing to ever
 * modify the content type manually.
 * Params:
 *   buffer = An #hb_buffer_t
 *   contentType = The type of buffer contents to set
 */
void bufferSetContentType(Buffer buffer, BufferContentType contentType)
{
  hb_buffer_set_content_type(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, contentType);
}

/**
 * Set the text flow direction of the buffer. No shaping can happen without
 * setting buffer direction, and it controls the visual direction for the
 * output glyphs; for RTL direction the glyphs will be reversed. Many layout
 * features depend on the proper setting of the direction, for example,
 * reversing RTL text before shaping, then shaping with LTR direction is not
 * the same as keeping the text in logical order and shaping with RTL
 * direction.
 * Params:
 *   buffer = An #hb_buffer_t
 *   direction = the #hb_direction_t of the buffer
 */
void bufferSetDirection(Buffer buffer, Direction direction)
{
  hb_buffer_set_direction(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, direction);
}

/**
 * Sets buffer flags to flags. See #hb_buffer_flags_t.
 * Params:
 *   buffer = An #hb_buffer_t
 *   flags = The buffer flags to set
 */
void bufferSetFlags(Buffer buffer, BufferFlags flags)
{
  hb_buffer_set_flags(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, flags);
}

/**
 * Sets the #hb_codepoint_t that replaces invisible characters in
 * the shaping result.  If set to zero $(LPAREN)default$(RPAREN), the glyph for the
 * U+0020 SPACE character is used.  Otherwise, this value is used
 * verbatim.
 * Params:
 *   buffer = An #hb_buffer_t
 *   invisible = the invisible #hb_codepoint_t
 */
void bufferSetInvisibleGlyph(Buffer buffer, Codepoint invisible)
{
  hb_buffer_set_invisible_glyph(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, invisible);
}

/**
 * Sets the language of buffer to language.
 * Languages are crucial for selecting which OpenType feature to apply to the
 * buffer which can result in applying language-specific behaviour. Languages
 * are orthogonal to the scripts, and though they are related, they are
 * different concepts and should not be confused with each other.
 * Use [HarfBuzz.Global.languageFromString] to convert from BCP 47 language tags to
 * #hb_language_t.
 * Params:
 *   buffer = An #hb_buffer_t
 *   language = An hb_language_t to set
 */
void bufferSetLanguage(Buffer buffer, Language language)
{
  hb_buffer_set_language(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, language);
}

/**
 * Similar to [HarfBuzz.Global.bufferPreAllocate], but clears any new items added at the
 * end.
 * Params:
 *   buffer = An #hb_buffer_t
 *   length = The new length of buffer
 * Returns: `true` if buffer memory allocation succeeded, `false` otherwise.
 */
Bool bufferSetLength(Buffer buffer, uint length)
{
  Bool _retval;
  _retval = hb_buffer_set_length(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, length);
  return _retval;
}

/**
 * Sets the implementation function for #hb_buffer_message_func_t.
 * Params:
 *   buffer = An #hb_buffer_t
 *   func = Callback function
 */
void bufferSetMessageFunc(Buffer buffer, BufferMessageFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_buffer_t* buffer, hb_font_t* font, const(char)* message, void* userData)
  {
    auto _dlg = cast(BufferMessageFunc*)userData;
    string _message = message.fromCString(false);

    hb_bool_t _retval = (*_dlg)(buffer ? new Buffer(cast(void*)buffer, false) : null, font ? new Font(cast(void*)font, false) : null, _message);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_buffer_set_message_func(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the #hb_codepoint_t that replaces characters not found in
 * the font during shaping.
 * The not-found glyph defaults to zero, sometimes known as the
 * ".notdef" glyph.  This API allows for differentiating the two.
 * Params:
 *   buffer = An #hb_buffer_t
 *   notFound = the not-found #hb_codepoint_t
 */
void bufferSetNotFoundGlyph(Buffer buffer, Codepoint notFound)
{
  hb_buffer_set_not_found_glyph(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, notFound);
}

/**
 * Sets the #hb_codepoint_t that replaces invalid entries for a given encoding
 * when adding text to buffer.
 * Default is #HB_BUFFER_REPLACEMENT_CODEPOINT_DEFAULT.
 * Params:
 *   buffer = An #hb_buffer_t
 *   replacement = the replacement #hb_codepoint_t
 */
void bufferSetReplacementCodepoint(Buffer buffer, Codepoint replacement)
{
  hb_buffer_set_replacement_codepoint(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, replacement);
}

/**
 * Sets the script of buffer to script.
 * Script is crucial for choosing the proper shaping behaviour for scripts that
 * require it $(LPAREN)e.g. Arabic$(RPAREN) and the which OpenType features defined in the font
 * to be applied.
 * You can pass one of the predefined #hb_script_t values, or use
 * [HarfBuzz.Global.scriptFromString] or [HarfBuzz.Global.scriptFromIso15924Tag] to get the
 * corresponding script from an ISO 15924 script tag.
 * Params:
 *   buffer = An #hb_buffer_t
 *   script = An #hb_script_t to set.
 */
void bufferSetScript(Buffer buffer, Script script)
{
  hb_buffer_set_script(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, script);
}

/**
 * Sets the segment properties of the buffer, a shortcut for calling
 * [HarfBuzz.Global.bufferSetDirection], [HarfBuzz.Global.bufferSetScript] and
 * [HarfBuzz.Global.bufferSetLanguage] individually.
 * Params:
 *   buffer = An #hb_buffer_t
 *   props = An #hb_segment_properties_t to use
 */
void bufferSetSegmentProperties(Buffer buffer, SegmentProperties props)
{
  hb_buffer_set_segment_properties(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, props ? cast(hb_segment_properties_t*)props.cPtr(false) : null);
}

/**
 * Sets the Unicode-functions structure of a buffer to
 * unicode_funcs.
 * Params:
 *   buffer = An #hb_buffer_t
 *   unicodeFuncs = The Unicode-functions structure
 */
void bufferSetUnicodeFuncs(Buffer buffer, UnicodeFuncs unicodeFuncs)
{
  hb_buffer_set_unicode_funcs(buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, unicodeFuncs ? cast(hb_unicode_funcs_t*)unicodeFuncs.cPtr(false) : null);
}

/**
 * Fetches the alpha channel of the given color.
 * Params:
 *   color = an #hb_color_t we are interested in its channels.
 * Returns: Alpha channel value
 */
ubyte colorGetAlpha(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_alpha(color);
  return _retval;
}

/**
 * Fetches the blue channel of the given color.
 * Params:
 *   color = an #hb_color_t we are interested in its channels.
 * Returns: Blue channel value
 */
ubyte colorGetBlue(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_blue(color);
  return _retval;
}

/**
 * Fetches the green channel of the given color.
 * Params:
 *   color = an #hb_color_t we are interested in its channels.
 * Returns: Green channel value
 */
ubyte colorGetGreen(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_green(color);
  return _retval;
}

/**
 * Fetches the red channel of the given color.
 * Params:
 *   color = an #hb_color_t we are interested in its channels.
 * Returns: Red channel value
 */
ubyte colorGetRed(Color color)
{
  ubyte _retval;
  _retval = hb_color_get_red(color);
  return _retval;
}

/**
 * Fetches a list of color stops from the given color line object.
 * Note that due to variations being applied, the returned color stops
 * may be out of order. It is the callers responsibility to ensure that
 * color stops are sorted by their offset before they are used.
 * Params:
 *   colorLine = a #hb_color_line_t object
 *   start = the index of the first color stop to return
 *   colorStops = Array of #hb_color_stop_t to populate
 * Returns: the total number of color stops in color_line
 */
uint colorLineGetColorStops(ColorLine colorLine, uint start, ref ColorStop[] colorStops)
{
  uint _retval;
  uint _count;
  hb_color_stop_t[] _colorStops;
  _colorStops.length = _count;
  _retval = hb_color_line_get_color_stops(colorLine ? cast(hb_color_line_t*)colorLine.cPtr(false) : null, start, &_count, _colorStops.ptr);
  colorStops.length = _count;
  foreach (i; 0 .. _count)
    colorStops[i] = new ColorStop(cast(void*)&_colorStops[i], false);
  return _retval;
}

/**
 * Fetches the extend mode of the color line object.
 * Params:
 *   colorLine = a #hb_color_line_t object
 * Returns: the extend mode of color_line
 */
PaintExtend colorLineGetExtend(ColorLine colorLine)
{
  hb_paint_extend_t _cretval;
  _cretval = hb_color_line_get_extend(colorLine ? cast(hb_color_line_t*)colorLine.cPtr(false) : null);
  PaintExtend _retval = cast(PaintExtend)_cretval;
  return _retval;
}

/**
 * Converts a string to an #hb_direction_t.
 * Matching is loose and applies only to the first letter. For
 * examples, "LTR" and "left-to-right" will both return #HB_DIRECTION_LTR.
 * Unmatched strings will return #HB_DIRECTION_INVALID.
 * Params:
 *   str = String to convert
 * Returns: The #hb_direction_t matching str
 */
Direction directionFromString(ubyte[] str)
{
  hb_direction_t _cretval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_direction_from_string(_str, _len);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * Converts an #hb_direction_t to a string.
 * Params:
 *   direction = The #hb_direction_t to convert
 * Returns: The string corresponding to direction
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
 * Params:
 *   dfuncs = draw functions
 *   drawData = associated draw data passed by the caller
 *   st = current draw state
 */
void drawClosePath(DrawFuncs dfuncs, void* drawData, DrawState st)
{
  hb_draw_close_path(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData, st ? cast(hb_draw_state_t*)st.cPtr(false) : null);
}

/**
 * Perform a "cubic-to" draw operation.
 * Params:
 *   dfuncs = draw functions
 *   drawData = associated draw data passed by the caller
 *   st = current draw state
 *   control1X = X component of first control point
 *   control1Y = Y component of first control point
 *   control2X = X component of second control point
 *   control2Y = Y component of second control point
 *   toX = X component of target point
 *   toY = Y component of target point
 */
void drawCubicTo(DrawFuncs dfuncs, void* drawData, DrawState st, float control1X, float control1Y, float control2X, float control2Y, float toX, float toY)
{
  hb_draw_cubic_to(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData, st ? cast(hb_draw_state_t*)st.cPtr(false) : null, control1X, control1Y, control2X, control2Y, toX, toY);
}

/**
 * Creates a new draw callbacks object.
 * Returns: A newly allocated #hb_draw_funcs_t with a reference count of 1. The initial
 *   reference count should be released with hb_draw_funcs_destroy when you are
 *   done using the #hb_draw_funcs_t. This function never returns `NULL`. If
 *   memory cannot be allocated, a special singleton #hb_draw_funcs_t object will
 *   be returned.
 */
DrawFuncs drawFuncsCreate()
{
  hb_draw_funcs_t* _cretval;
  _cretval = hb_draw_funcs_create();
  auto _retval = _cretval ? new DrawFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the singleton empty draw-functions structure.
 * Returns: The empty draw-functions structure
 */
DrawFuncs drawFuncsGetEmpty()
{
  hb_draw_funcs_t* _cretval;
  _cretval = hb_draw_funcs_get_empty();
  auto _retval = _cretval ? new DrawFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Checks whether dfuncs is immutable.
 * Params:
 *   dfuncs = draw functions
 * Returns: `true` if dfuncs is immutable, `false` otherwise
 */
Bool drawFuncsIsImmutable(DrawFuncs dfuncs)
{
  Bool _retval;
  _retval = hb_draw_funcs_is_immutable(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null);
  return _retval;
}

/**
 * Makes dfuncs object immutable.
 * Params:
 *   dfuncs = draw functions
 */
void drawFuncsMakeImmutable(DrawFuncs dfuncs)
{
  hb_draw_funcs_make_immutable(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null);
}

/**
 * Sets close-path callback to the draw functions object.
 * Params:
 *   dfuncs = draw functions object
 *   func = close-path callback
 */
void drawFuncsSetClosePathFunc(DrawFuncs dfuncs, DrawClosePathFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, void* userData)
  {
    auto _dlg = cast(DrawClosePathFunc*)userData;

    (*_dlg)(dfuncs ? new DrawFuncs(cast(void*)dfuncs, false) : null, drawData, st ? new DrawState(cast(void*)st, false) : null);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_draw_funcs_set_close_path_func(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets cubic-to callback to the draw functions object.
 * Params:
 *   dfuncs = draw functions
 *   func = cubic-to callback
 */
void drawFuncsSetCubicToFunc(DrawFuncs dfuncs, DrawCubicToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float control1X, float control1Y, float control2X, float control2Y, float toX, float toY, void* userData)
  {
    auto _dlg = cast(DrawCubicToFunc*)userData;

    (*_dlg)(dfuncs ? new DrawFuncs(cast(void*)dfuncs, false) : null, drawData, st ? new DrawState(cast(void*)st, false) : null, control1X, control1Y, control2X, control2Y, toX, toY);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_draw_funcs_set_cubic_to_func(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets line-to callback to the draw functions object.
 * Params:
 *   dfuncs = draw functions object
 *   func = line-to callback
 */
void drawFuncsSetLineToFunc(DrawFuncs dfuncs, DrawLineToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float toX, float toY, void* userData)
  {
    auto _dlg = cast(DrawLineToFunc*)userData;

    (*_dlg)(dfuncs ? new DrawFuncs(cast(void*)dfuncs, false) : null, drawData, st ? new DrawState(cast(void*)st, false) : null, toX, toY);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_draw_funcs_set_line_to_func(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets move-to callback to the draw functions object.
 * Params:
 *   dfuncs = draw functions object
 *   func = move-to callback
 */
void drawFuncsSetMoveToFunc(DrawFuncs dfuncs, DrawMoveToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float toX, float toY, void* userData)
  {
    auto _dlg = cast(DrawMoveToFunc*)userData;

    (*_dlg)(dfuncs ? new DrawFuncs(cast(void*)dfuncs, false) : null, drawData, st ? new DrawState(cast(void*)st, false) : null, toX, toY);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_draw_funcs_set_move_to_func(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets quadratic-to callback to the draw functions object.
 * Params:
 *   dfuncs = draw functions object
 *   func = quadratic-to callback
 */
void drawFuncsSetQuadraticToFunc(DrawFuncs dfuncs, DrawQuadraticToFunc func)
{
  extern(C) void _funcCallback(hb_draw_funcs_t* dfuncs, void* drawData, hb_draw_state_t* st, float controlX, float controlY, float toX, float toY, void* userData)
  {
    auto _dlg = cast(DrawQuadraticToFunc*)userData;

    (*_dlg)(dfuncs ? new DrawFuncs(cast(void*)dfuncs, false) : null, drawData, st ? new DrawState(cast(void*)st, false) : null, controlX, controlY, toX, toY);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_draw_funcs_set_quadratic_to_func(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Perform a "line-to" draw operation.
 * Params:
 *   dfuncs = draw functions
 *   drawData = associated draw data passed by the caller
 *   st = current draw state
 *   toX = X component of target point
 *   toY = Y component of target point
 */
void drawLineTo(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY)
{
  hb_draw_line_to(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData, st ? cast(hb_draw_state_t*)st.cPtr(false) : null, toX, toY);
}

/**
 * Perform a "move-to" draw operation.
 * Params:
 *   dfuncs = draw functions
 *   drawData = associated draw data passed by the caller
 *   st = current draw state
 *   toX = X component of target point
 *   toY = Y component of target point
 */
void drawMoveTo(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY)
{
  hb_draw_move_to(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData, st ? cast(hb_draw_state_t*)st.cPtr(false) : null, toX, toY);
}

/**
 * Perform a "quadratic-to" draw operation.
 * Params:
 *   dfuncs = draw functions
 *   drawData = associated draw data passed by the caller
 *   st = current draw state
 *   controlX = X component of control point
 *   controlY = Y component of control point
 *   toX = X component of target point
 *   toY = Y component of target point
 */
void drawQuadraticTo(DrawFuncs dfuncs, void* drawData, DrawState st, float controlX, float controlY, float toX, float toY)
{
  hb_draw_quadratic_to(dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData, st ? cast(hb_draw_state_t*)st.cPtr(false) : null, controlX, controlY, toX, toY);
}

/**
 * Add table for tag with data provided by blob to the face.  face must
 * be created using [HarfBuzz.Global.faceBuilderCreate].
 * Params:
 *   face = A face object created with [HarfBuzz.Global.faceBuilderCreate]
 *   tag = The #hb_tag_t of the table to add
 *   blob = The blob containing the table data to add
 * Returns:
 */
Bool faceBuilderAddTable(HBFace face, Tag tag, Blob blob)
{
  Bool _retval;
  _retval = hb_face_builder_add_table(face ? cast(hb_face_t*)face.cPtr(false) : null, tag, blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
  return _retval;
}

/**
 * Creates a #hb_face_t that can be used with [HarfBuzz.Global.faceBuilderAddTable].
 * After tables are added to the face, it can be compiled to a binary
 * font file by calling [HarfBuzz.Global.faceReferenceBlob].
 * Returns: New face.
 */
HBFace faceBuilderCreate()
{
  hb_face_t* _cretval;
  _cretval = hb_face_builder_create();
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Set the ordering of tables for serialization. Any tables not
 * specified in the tags list will be ordered after the tables in
 * tags, ordered by the default sort ordering.
 * Params:
 *   face = A face object created with [HarfBuzz.Global.faceBuilderCreate]
 *   tags = ordered list of table tags terminated by
 *     %HB_TAG_NONE
 */
void faceBuilderSortTables(HBFace face, Tag[] tags)
{
  auto _tags = cast(const(hb_tag_t)*)(tags ~ hb_tag_t.init).ptr;
  hb_face_builder_sort_tables(face ? cast(hb_face_t*)face.cPtr(false) : null, _tags);
}

/**
 * Fetches the number of faces in a blob.
 * Params:
 *   blob = a blob.
 * Returns: Number of faces in blob
 */
uint faceCount(Blob blob)
{
  uint _retval;
  _retval = hb_face_count(blob ? cast(hb_blob_t*)blob.cPtr(false) : null);
  return _retval;
}

/**
 * Constructs a new face object from the specified blob and
 * a face index into that blob.
 * The face index is used for blobs of file formats such as TTC and
 * DFont that can contain more than one face.  Face indices within
 * such collections are zero-based.
 * <note>Note: If the blob font format is not a collection, index
 * is ignored.  Otherwise, only the lower 16-bits of index are used.
 * The unmodified index can be accessed via [HarfBuzz.Global.faceGetIndex].</note>
 * <note>Note: The high 16-bits of index, if non-zero, are used by
 * [HarfBuzz.Global.fontCreate] to load named-instances in variable fonts.  See
 * [HarfBuzz.Global.fontCreate] for details.</note>
 * Params:
 *   blob = #hb_blob_t to work upon
 *   index = The index of the face within blob
 * Returns: The new face object
 */
HBFace faceCreate(Blob blob, uint index)
{
  hb_face_t* _cretval;
  _cretval = hb_face_create(blob ? cast(hb_blob_t*)blob.cPtr(false) : null, index);
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Variant of [HarfBuzz.Global.faceCreate], built for those cases where it is more
 * convenient to provide data for individual tables instead of the whole font
 * data. With the caveat that [HarfBuzz.Global.faceGetTableTags] does not currently work
 * with faces created this way.
 * Creates a new face object from the specified user_data and reference_table_func,
 * with the destroy callback.
 * Params:
 *   referenceTableFunc = Table-referencing function
 * Returns: The new face object
 */
HBFace faceCreateForTables(ReferenceTableFunc referenceTableFunc)
{
  extern(C) hb_blob_t* _referenceTableFuncCallback(hb_face_t* face, hb_tag_t tag, void* userData)
  {
    Blob _dretval;
    auto _dlg = cast(ReferenceTableFunc*)userData;

    _dretval = (*_dlg)(face ? new HBFace(cast(void*)face, false) : null, tag);
    hb_blob_t* _retval = cast(hb_blob_t*)_dretval.cPtr(true);

    return _retval;
  }

  hb_face_t* _cretval;
  auto _referenceTableFunc = freezeDelegate(cast(void*)&referenceTableFunc);
  _cretval = hb_face_create_for_tables(&_referenceTableFuncCallback, _referenceTableFunc, &thawDelegate);
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the singleton empty face object.
 * Returns: The empty face object
 */
HBFace faceGetEmpty()
{
  hb_face_t* _cretval;
  _cretval = hb_face_get_empty();
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the glyph-count value of the specified face object.
 * Params:
 *   face = A face object
 * Returns: The glyph-count value of face
 */
uint faceGetGlyphCount(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_glyph_count(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the face-index corresponding to the given face.
 * <note>Note: face indices within a collection are zero-based.</note>
 * Params:
 *   face = A face object
 * Returns: The index of face.
 */
uint faceGetIndex(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_index(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches a list of all table tags for a face, if possible. The list returned will
 * begin at the offset provided
 * Params:
 *   face = A face object
 *   startOffset = The index of first table tag to retrieve
 *   tableTags = The array of table tags found
 * Returns: Total number of tables, or zero if it is not possible to list
 */
uint faceGetTableTags(HBFace face, uint startOffset, ref Tag[] tableTags)
{
  uint _retval;
  uint _tableCount;
  _retval = hb_face_get_table_tags(face ? cast(hb_face_t*)face.cPtr(false) : null, startOffset, &_tableCount, tableTags.ptr);
  return _retval;
}

/**
 * Fetches the units-per-em $(LPAREN)UPEM$(RPAREN) value of the specified face object.
 * Typical UPEM values for fonts are 1000, or 2048, but any value
 * in between 16 and 16,384 is allowed for OpenType fonts.
 * Params:
 *   face = A face object
 * Returns: The upem value of face
 */
uint faceGetUpem(HBFace face)
{
  uint _retval;
  _retval = hb_face_get_upem(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the given face object is immutable.
 * Params:
 *   face = A face object
 * Returns: `true` is face is immutable, `false` otherwise
 */
Bool faceIsImmutable(HBFace face)
{
  Bool _retval;
  _retval = hb_face_is_immutable(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Makes the given face object immutable.
 * Params:
 *   face = A face object
 */
void faceMakeImmutable(HBFace face)
{
  hb_face_make_immutable(face ? cast(hb_face_t*)face.cPtr(false) : null);
}

/**
 * Fetches a pointer to the binary blob that contains the
 * specified face. Returns an empty blob if referencing face data is not
 * possible.
 * Params:
 *   face = A face object
 * Returns: A pointer to the blob for face
 */
Blob faceReferenceBlob(HBFace face)
{
  hb_blob_t* _cretval;
  _cretval = hb_face_reference_blob(face ? cast(hb_face_t*)face.cPtr(false) : null);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches a reference to the specified table within
 * the specified face.
 * Params:
 *   face = A face object
 *   tag = The #hb_tag_t of the table to query
 * Returns: A pointer to the tag table within face
 */
Blob faceReferenceTable(HBFace face, Tag tag)
{
  hb_blob_t* _cretval;
  _cretval = hb_face_reference_table(face ? cast(hb_face_t*)face.cPtr(false) : null, tag);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Sets the glyph count for a face object to the specified value.
 * This API is used in rare circumstances.
 * Params:
 *   face = A face object
 *   glyphCount = The glyph-count value to assign
 */
void faceSetGlyphCount(HBFace face, uint glyphCount)
{
  hb_face_set_glyph_count(face ? cast(hb_face_t*)face.cPtr(false) : null, glyphCount);
}

/**
 * Assigns the specified face-index to face. Fails if the
 * face is immutable.
 * <note>Note: changing the index has no effect on the face itself
 * This only changes the value returned by [HarfBuzz.Global.faceGetIndex].</note>
 * Params:
 *   face = A face object
 *   index = The index to assign
 */
void faceSetIndex(HBFace face, uint index)
{
  hb_face_set_index(face ? cast(hb_face_t*)face.cPtr(false) : null, index);
}

/**
 * Sets the units-per-em $(LPAREN)upem$(RPAREN) for a face object to the specified value.
 * This API is used in rare circumstances.
 * Params:
 *   face = A face object
 *   upem = The units-per-em value to assign
 */
void faceSetUpem(HBFace face, uint upem)
{
  hb_face_set_upem(face ? cast(hb_face_t*)face.cPtr(false) : null, upem);
}

/**
 * Parses a string into a #hb_feature_t.
 * The format for specifying feature strings follows. All valid CSS
 * font-feature-settings values other than 'normal' and the global values are
 * also accepted, though not documented below. CSS string escapes are not
 * supported.
 * The range indices refer to the positions between Unicode characters. The
 * position before the first character is always 0.
 * The format is Python-esque.  Here is how it all works:
 * <informaltable pgwide\='1' align\='left' frame\='none'>
 * <tgroup cols\='5'>
 * <thead>
 * <row><entry>Syntax</entry>    <entry>Value</entry> <entry>Start</entry> <entry>End</entry></row>
 * </thead>
 * <tbody>
 * <row><entry>Setting value:</entry></row>
 * <row><entry>kern</entry>      <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
 * <row><entry>+kern</entry>     <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
 * <row><entry>-kern</entry>     <entry>0</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature off</entry></row>
 * <row><entry>kern\=0</entry>    <entry>0</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature off</entry></row>
 * <row><entry>kern\=1</entry>    <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
 * <row><entry>aalt\=2</entry>    <entry>2</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Choose 2nd alternate</entry></row>
 * <row><entry>Setting index:</entry></row>
 * <row><entry>kern[]</entry>    <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
 * <row><entry>kern[:]</entry>   <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
 * <row><entry>kern[5:]</entry>  <entry>1</entry>     <entry>5</entry>      <entry>∞</entry>   <entry>Turn feature on, partial</entry></row>
 * <row><entry>kern[:5]</entry>  <entry>1</entry>     <entry>0</entry>      <entry>5</entry>   <entry>Turn feature on, partial</entry></row>
 * <row><entry>kern[3:5]</entry> <entry>1</entry>     <entry>3</entry>      <entry>5</entry>   <entry>Turn feature on, range</entry></row>
 * <row><entry>kern[3]</entry>   <entry>1</entry>     <entry>3</entry>      <entry>3+1</entry> <entry>Turn feature on, single char</entry></row>
 * <row><entry>Mixing it all:</entry></row>
 * <row><entry>aalt[3:5]\=2</entry> <entry>2</entry>   <entry>3</entry>      <entry>5</entry>   <entry>Turn 2nd alternate on for range</entry></row>
 * </tbody>
 * </tgroup>
 * </informaltable>
 * Params:
 *   str = a string to parse
 *   feature = the #hb_feature_t to initialize with the parsed values
 * Returns: `true` if str is successfully parsed, `false` otherwise
 */
Bool featureFromString(ubyte[] str, out Feature feature)
{
  Bool _retval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  hb_feature_t _feature;
  _retval = hb_feature_from_string(_str, _len, &_feature);
  feature = new Feature(cast(void*)&_feature, false);
  return _retval;
}

/**
 * Adds the origin coordinates to an $(LPAREN)X,Y$(RPAREN) point coordinate, in
 * the specified glyph ID in the specified font.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   direction = The direction of the text segment
 *   x = Input \= The original X coordinate
 *     Output \= The X coordinate plus the X-coordinate of the origin
 *   y = Input \= The original Y coordinate
 *     Output \= The Y coordinate plus the Y-coordinate of the origin
 */
void fontAddGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, ref Position x, ref Position y)
{
  hb_font_add_glyph_origin_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Notifies the font that underlying font data has changed.
 * This has the effect of increasing the serial as returned
 * by [HarfBuzz.Global.fontGetSerial], which invalidates internal caches.
 * Params:
 *   font = #hb_font_t to work upon
 */
void fontChanged(Font font)
{
  hb_font_changed(font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Constructs a new font object from the specified face.
 * <note>Note: If face's index value $(LPAREN)as passed to [HarfBuzz.Global.faceCreate]
 * has non-zero top 16-bits, those bits minus one are passed to
 * [HarfBuzz.Global.fontSetVarNamedInstance], effectively loading a named-instance
 * of a variable font, instead of the default-instance.  This allows
 * specifying which named-instance to load by default when creating the
 * face.</note>
 * Params:
 *   face = a face.
 * Returns: The new font object
 */
Font fontCreate(HBFace face)
{
  hb_font_t* _cretval;
  _cretval = hb_font_create(face ? cast(hb_face_t*)face.cPtr(false) : null);
  auto _retval = _cretval ? new Font(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Constructs a sub-font font object from the specified parent font,
 * replicating the parent's properties.
 * Params:
 *   parent = The parent font object
 * Returns: The new sub-font font object
 */
Font fontCreateSubFont(Font parent)
{
  hb_font_t* _cretval;
  _cretval = hb_font_create_sub_font(parent ? cast(hb_font_t*)parent.cPtr(false) : null);
  auto _retval = _cretval ? new Font(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Draws the outline that corresponds to a glyph in the specified font.
 * The outline is returned by way of calls to the callbacks of the dfuncs
 * objects, with draw_data passed to them.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID
 *   dfuncs = #hb_draw_funcs_t to draw to
 *   drawData = User data to pass to draw callbacks
 */
void fontDrawGlyph(Font font, Codepoint glyph, DrawFuncs dfuncs, void* drawData)
{
  hb_font_draw_glyph(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData);
}

/**
 * Creates a new #hb_font_funcs_t structure of font functions.
 * Returns: The font-functions structure
 */
FontFuncs fontFuncsCreate()
{
  hb_font_funcs_t* _cretval;
  _cretval = hb_font_funcs_create();
  auto _retval = _cretval ? new FontFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches an empty font-functions structure.
 * Returns: The font-functions structure
 */
FontFuncs fontFuncsGetEmpty()
{
  hb_font_funcs_t* _cretval;
  _cretval = hb_font_funcs_get_empty();
  auto _retval = _cretval ? new FontFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Tests whether a font-functions structure is immutable.
 * Params:
 *   ffuncs = The font-functions structure
 * Returns: `true` if ffuncs is immutable, `false` otherwise
 */
Bool fontFuncsIsImmutable(FontFuncs ffuncs)
{
  Bool _retval;
  _retval = hb_font_funcs_is_immutable(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null);
  return _retval;
}

/**
 * Makes a font-functions structure immutable.
 * Params:
 *   ffuncs = The font-functions structure
 */
void fontFuncsMakeImmutable(FontFuncs ffuncs)
{
  hb_font_funcs_make_immutable(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null);
}

/**
 * Sets the implementation function for #hb_font_draw_glyph_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetDrawGlyphFunc(FontFuncs ffuncs, FontDrawGlyphFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_draw_funcs_t* drawFuncs, void* drawData, void* userData)
  {
    auto _dlg = cast(FontDrawGlyphFunc*)userData;

    (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, drawFuncs ? new DrawFuncs(cast(void*)drawFuncs, false) : null, drawData);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_draw_glyph_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_font_h_extents_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetFontHExtentsFunc(FontFuncs ffuncs, FontGetFontHExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_font_extents_t* extents, void* userData)
  {
    auto _dlg = cast(FontGetFontHExtentsFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, *extents);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_font_h_extents_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_font_v_extents_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetFontVExtentsFunc(FontFuncs ffuncs, FontGetFontVExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_font_extents_t* extents, void* userData)
  {
    auto _dlg = cast(FontGetFontVExtentsFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, *extents);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_font_v_extents_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_contour_point_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphContourPointFunc(FontFuncs ffuncs, FontGetGlyphContourPointFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, uint pointIndex, hb_position_t* x, hb_position_t* y, void* userData)
  {
    auto _dlg = cast(FontGetGlyphContourPointFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, pointIndex, *x, *y);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_contour_point_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_extents_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphExtentsFunc(FontFuncs ffuncs, FontGetGlyphExtentsFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_glyph_extents_t* extents, void* userData)
  {
    auto _dlg = cast(FontGetGlyphExtentsFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, *extents);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_extents_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_from_name_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphFromNameFunc(FontFuncs ffuncs, FontGetGlyphFromNameFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, const(char)* name, int len, hb_codepoint_t* glyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphFromNameFunc*)userData;
    char[] _name;
    _name.length = len;
    _name[0 .. len] = name[0 .. len];

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, _name, *glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_from_name_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Deprecated.  Use [HarfBuzz.Global.fontFuncsSetNominalGlyphFunc] and
 * [HarfBuzz.Global.fontFuncsSetVariationGlyphFunc] instead.
 * Params:
 *   ffuncs = The font-functions structure
 *   func = callback function
 */
void fontFuncsSetGlyphFunc(FontFuncs ffuncs, FontGetGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t variationSelector, hb_codepoint_t* glyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, unicode, variationSelector, *glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_advance_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphHAdvanceFunc(FontFuncs ffuncs, FontGetGlyphHAdvanceFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphHAdvanceFunc*)userData;

    hb_position_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_h_advance_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_kerning_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphHKerningFunc(FontFuncs ffuncs, FontGetGlyphHKerningFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t firstGlyph, hb_codepoint_t secondGlyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphHKerningFunc*)userData;

    hb_position_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, firstGlyph, secondGlyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_h_kerning_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_h_origin_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphHOriginFunc(FontFuncs ffuncs, FontGetGlyphHOriginFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_position_t* x, hb_position_t* y, void* userData)
  {
    auto _dlg = cast(FontGetGlyphHOriginFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, *x, *y);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_h_origin_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_name_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphNameFunc(FontFuncs ffuncs, FontGetGlyphNameFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, char* name, uint size, void* userData)
  {
    auto _dlg = cast(FontGetGlyphNameFunc*)userData;
    char[] _name;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, _name);
    size = cast(uint)_name.length;
    name = arrayDtoC!(char, Yes.UseMalloc, No.ZeroTerm)(_name);

    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_name_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_shape_func_t,
 * which is the same as #hb_font_draw_glyph_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign

 * Deprecated: Use [HarfBuzz.Global.fontFuncsSetDrawGlyphFunc] instead
 */
void fontFuncsSetGlyphShapeFunc(FontFuncs ffuncs, FontGetGlyphShapeFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_draw_funcs_t* drawFuncs, void* drawData, void* userData)
  {
    auto _dlg = cast(FontGetGlyphShapeFunc*)userData;

    (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, drawFuncs ? new DrawFuncs(cast(void*)drawFuncs, false) : null, drawData);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_shape_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_advance_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphVAdvanceFunc(FontFuncs ffuncs, FontGetGlyphVAdvanceFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphVAdvanceFunc*)userData;

    hb_position_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_v_advance_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_kerning_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphVKerningFunc(FontFuncs ffuncs, FontGetGlyphVKerningFunc func)
{
  extern(C) hb_position_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t firstGlyph, hb_codepoint_t secondGlyph, void* userData)
  {
    auto _dlg = cast(FontGetGlyphVKerningFunc*)userData;

    hb_position_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, firstGlyph, secondGlyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_v_kerning_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_glyph_v_origin_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetGlyphVOriginFunc(FontFuncs ffuncs, FontGetGlyphVOriginFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_position_t* x, hb_position_t* y, void* userData)
  {
    auto _dlg = cast(FontGetGlyphVOriginFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, *x, *y);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_glyph_v_origin_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_nominal_glyph_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetNominalGlyphFunc(FontFuncs ffuncs, FontGetNominalGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t* glyph, void* userData)
  {
    auto _dlg = cast(FontGetNominalGlyphFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, unicode, *glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_nominal_glyph_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_paint_glyph_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetPaintGlyphFunc(FontFuncs ffuncs, FontPaintGlyphFunc func)
{
  extern(C) void _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t glyph, hb_paint_funcs_t* paintFuncs, void* paintData, uint paletteIndex, hb_color_t foreground, void* userData)
  {
    auto _dlg = cast(FontPaintGlyphFunc*)userData;

    (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, glyph, paintFuncs ? new PaintFuncs(cast(void*)paintFuncs, false) : null, paintData, paletteIndex, foreground);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_paint_glyph_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_font_get_variation_glyph_func_t.
 * Params:
 *   ffuncs = A font-function structure
 *   func = The callback function to assign
 */
void fontFuncsSetVariationGlyphFunc(FontFuncs ffuncs, FontGetVariationGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_font_t* font, void* fontData, hb_codepoint_t unicode, hb_codepoint_t variationSelector, hb_codepoint_t* glyph, void* userData)
  {
    auto _dlg = cast(FontGetVariationGlyphFunc*)userData;

    hb_bool_t _retval = (*_dlg)(font ? new Font(cast(void*)font, false) : null, fontData, unicode, variationSelector, *glyph);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_font_funcs_set_variation_glyph_func(ffuncs ? cast(hb_font_funcs_t*)ffuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Fetches the empty font object.
 * Returns: The empty font object
 */
Font fontGetEmpty()
{
  hb_font_t* _cretval;
  _cretval = hb_font_get_empty();
  auto _retval = _cretval ? new Font(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the extents for a font in a text segment of the
 * specified direction.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   direction = The direction of the text segment
 *   extents = The #hb_font_extents_t retrieved
 */
void fontGetExtentsForDirection(Font font, Direction direction, out FontExtents extents)
{
  hb_font_get_extents_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, direction, &extents);
}

/**
 * Fetches the face associated with the specified font object.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: The #hb_face_t value
 */
HBFace fontGetFace(Font font)
{
  hb_face_t* _cretval;
  _cretval = hb_font_get_face(font ? cast(hb_font_t*)font.cPtr(false) : null);
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Fetches the glyph ID for a Unicode code point in the specified
 * font, with an optional variation selector.
 * If variation_selector is 0, calls [HarfBuzz.Global.fontGetNominalGlyph];
 * otherwise calls [HarfBuzz.Global.fontGetVariationGlyph].
 * Params:
 *   font = #hb_font_t to work upon
 *   unicode = The Unicode code point to query
 *   variationSelector = A variation-selector code point
 *   glyph = The glyph ID retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyph(Font font, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_glyph(font ? cast(hb_font_t*)font.cPtr(false) : null, unicode, variationSelector, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Fetches the advance for a glyph ID from the specified font,
 * in a text segment of the specified direction.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   direction = The direction of the text segment
 *   x = The horizontal advance retrieved
 *   y = The vertical advance retrieved
 */
void fontGetGlyphAdvanceForDirection(Font font, Codepoint glyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_advance_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Fetches the $(LPAREN)x,y$(RPAREN) coordinates of a specified contour-point index
 * in the specified glyph, within the specified font.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   pointIndex = The contour-point index to query
 *   x = The X value retrieved for the contour point
 *   y = The Y value retrieved for the contour point
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphContourPoint(Font font, Codepoint glyph, uint pointIndex, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_contour_point(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, pointIndex, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * Fetches the $(LPAREN)X,Y$(RPAREN) coordinates of a specified contour-point index
 * in the specified glyph ID in the specified font, with respect
 * to the origin in a text segment in the specified direction.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   pointIndex = The contour-point index to query
 *   direction = The direction of the text segment
 *   x = The X value retrieved for the contour point
 *   y = The Y value retrieved for the contour point
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphContourPointForOrigin(Font font, Codepoint glyph, uint pointIndex, Direction direction, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_contour_point_for_origin(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, pointIndex, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * Fetches the #hb_glyph_extents_t data for a glyph ID
 * in the specified font.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   extents = The #hb_glyph_extents_t retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphExtents(Font font, Codepoint glyph, out GlyphExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_glyph_extents(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, &extents);
  return _retval;
}

/**
 * Fetches the #hb_glyph_extents_t data for a glyph ID
 * in the specified font, with respect to the origin in
 * a text segment in the specified direction.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   direction = The direction of the text segment
 *   extents = The #hb_glyph_extents_t retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphExtentsForOrigin(Font font, Codepoint glyph, Direction direction, out GlyphExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_glyph_extents_for_origin(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, &extents);
  return _retval;
}

/**
 * Fetches the glyph ID that corresponds to a name string in the specified font.
 * <note>Note: len \=\= -1 means the name string is null-terminated.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   name = The name string to query
 *   glyph = The glyph ID retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphFromName(Font font, string name, out Codepoint glyph)
{
  Bool _retval;
  int _len;
  if (name)
    _len = cast(int)name.length;

  auto _name = cast(const(char)*)name.ptr;
  _retval = hb_font_get_glyph_from_name(font ? cast(hb_font_t*)font.cPtr(false) : null, _name, _len, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Fetches the advance for a glyph ID in the specified font,
 * for horizontal text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 * Returns: The advance of glyph within font
 */
Position fontGetGlyphHAdvance(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_h_advance(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * Fetches the kerning-adjustment value for a glyph-pair in
 * the specified font, for horizontal text segments.
 * <note>It handles legacy kerning only $(LPAREN)as returned by the corresponding
 * #hb_font_funcs_t function$(RPAREN).</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   leftGlyph = The glyph ID of the left glyph in the glyph pair
 *   rightGlyph = The glyph ID of the right glyph in the glyph pair
 * Returns: The kerning adjustment value
 */
Position fontGetGlyphHKerning(Font font, Codepoint leftGlyph, Codepoint rightGlyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_h_kerning(font ? cast(hb_font_t*)font.cPtr(false) : null, leftGlyph, rightGlyph);
  return _retval;
}

/**
 * Fetches the $(LPAREN)X,Y$(RPAREN) coordinates of the origin for a glyph ID
 * in the specified font, for horizontal text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   x = The X coordinate of the origin
 *   y = The Y coordinate of the origin
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphHOrigin(Font font, Codepoint glyph, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_h_origin(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * Fetches the kerning-adjustment value for a glyph-pair in the specified font.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   firstGlyph = The glyph ID of the first glyph in the glyph pair to query
 *   secondGlyph = The glyph ID of the second glyph in the glyph pair to query
 *   direction = The direction of the text segment
 *   x = The horizontal kerning-adjustment value retrieved
 *   y = The vertical kerning-adjustment value retrieved
 */
void fontGetGlyphKerningForDirection(Font font, Codepoint firstGlyph, Codepoint secondGlyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_kerning_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, firstGlyph, secondGlyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Fetches the $(LPAREN)X,Y$(RPAREN) coordinates of the origin for a glyph in
 * the specified font.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   direction = The direction of the text segment
 *   x = The X coordinate retrieved for the origin
 *   y = The Y coordinate retrieved for the origin
 */
void fontGetGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, out Position x, out Position y)
{
  hb_font_get_glyph_origin_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Fetches the glyph shape that corresponds to a glyph in the specified font.
 * The shape is returned by way of calls to the callbacks of the dfuncs
 * objects, with draw_data passed to them.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID
 *   dfuncs = #hb_draw_funcs_t to draw to
 *   drawData = User data to pass to draw callbacks

 * Deprecated: Use [HarfBuzz.Global.fontDrawGlyph] instead
 */
void fontGetGlyphShape(Font font, Codepoint glyph, DrawFuncs dfuncs, void* drawData)
{
  hb_font_get_glyph_shape(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, dfuncs ? cast(hb_draw_funcs_t*)dfuncs.cPtr(false) : null, drawData);
}

/**
 * Fetches the advance for a glyph ID in the specified font,
 * for vertical text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 * Returns: The advance of glyph within font
 */
Position fontGetGlyphVAdvance(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_v_advance(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * Fetches the kerning-adjustment value for a glyph-pair in
 * the specified font, for vertical text segments.
 * <note>It handles legacy kerning only $(LPAREN)as returned by the corresponding
 * #hb_font_funcs_t function$(RPAREN).</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   topGlyph = The glyph ID of the top glyph in the glyph pair
 *   bottomGlyph = The glyph ID of the bottom glyph in the glyph pair
 * Returns: The kerning adjustment value
 */
Position fontGetGlyphVKerning(Font font, Codepoint topGlyph, Codepoint bottomGlyph)
{
  Position _retval;
  _retval = hb_font_get_glyph_v_kerning(font ? cast(hb_font_t*)font.cPtr(false) : null, topGlyph, bottomGlyph);
  return _retval;
}

/**
 * Fetches the $(LPAREN)X,Y$(RPAREN) coordinates of the origin for a glyph ID
 * in the specified font, for vertical text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   x = The X coordinate of the origin
 *   y = The Y coordinate of the origin
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetGlyphVOrigin(Font font, Codepoint glyph, out Position x, out Position y)
{
  Bool _retval;
  _retval = hb_font_get_glyph_v_origin(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
  return _retval;
}

/**
 * Fetches the extents for a specified font, for horizontal
 * text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   extents = The font extents retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetHExtents(Font font, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_h_extents(font ? cast(hb_font_t*)font.cPtr(false) : null, &extents);
  return _retval;
}

/**
 * Fetches the nominal glyph ID for a Unicode code point in the
 * specified font.
 * This version of the function should not be used to fetch glyph IDs
 * for code points modified by variation selectors. For variation-selector
 * support, user [HarfBuzz.Global.fontGetVariationGlyph] or use [HarfBuzz.Global.fontGetGlyph].
 * Params:
 *   font = #hb_font_t to work upon
 *   unicode = The Unicode code point to query
 *   glyph = The glyph ID retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetNominalGlyph(Font font, Codepoint unicode, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_nominal_glyph(font ? cast(hb_font_t*)font.cPtr(false) : null, unicode, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Fetches the parent font of font.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: The parent font object
 */
Font fontGetParent(Font font)
{
  hb_font_t* _cretval;
  _cretval = hb_font_get_parent(font ? cast(hb_font_t*)font.cPtr(false) : null);
  auto _retval = _cretval ? new Font(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Fetches the horizontal and vertical points-per-em $(LPAREN)ppem$(RPAREN) of a font.
 * Params:
 *   font = #hb_font_t to work upon
 *   xPpem = Horizontal ppem value
 *   yPpem = Vertical ppem value
 */
void fontGetPpem(Font font, out uint xPpem, out uint yPpem)
{
  hb_font_get_ppem(font ? cast(hb_font_t*)font.cPtr(false) : null, cast(uint*)&xPpem, cast(uint*)&yPpem);
}

/**
 * Fetches the "point size" of a font. Used in CoreText to
 * implement optical sizing.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: Point size.  A value of zero means "not set."
 */
float fontGetPtem(Font font)
{
  float _retval;
  _retval = hb_font_get_ptem(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the horizontal and vertical scale of a font.
 * Params:
 *   font = #hb_font_t to work upon
 *   xScale = Horizontal scale value
 *   yScale = Vertical scale value
 */
void fontGetScale(Font font, out int xScale, out int yScale)
{
  hb_font_get_scale(font ? cast(hb_font_t*)font.cPtr(false) : null, cast(int*)&xScale, cast(int*)&yScale);
}

/**
 * Returns the internal serial number of the font. The serial
 * number is increased every time a setting on the font is
 * changed, using a setter function.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: serial number
 */
uint fontGetSerial(Font font)
{
  uint _retval;
  _retval = hb_font_get_serial(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the "synthetic boldness" parameters of a font.
 * Params:
 *   font = #hb_font_t to work upon
 *   xEmbolden = return location for horizontal value
 *   yEmbolden = return location for vertical value
 *   inPlace = return location for in-place value
 */
void fontGetSyntheticBold(Font font, out float xEmbolden, out float yEmbolden, out Bool inPlace)
{
  hb_font_get_synthetic_bold(font ? cast(hb_font_t*)font.cPtr(false) : null, cast(float*)&xEmbolden, cast(float*)&yEmbolden, cast(hb_bool_t*)&inPlace);
}

/**
 * Fetches the "synthetic slant" of a font.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: Synthetic slant.  By default is zero.
 */
float fontGetSyntheticSlant(Font font)
{
  float _retval;
  _retval = hb_font_get_synthetic_slant(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the extents for a specified font, for vertical
 * text segments.
 * Params:
 *   font = #hb_font_t to work upon
 *   extents = The font extents retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetVExtents(Font font, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_font_get_v_extents(font ? cast(hb_font_t*)font.cPtr(false) : null, &extents);
  return _retval;
}

/**
 * Returns the currently-set named-instance index of the font.
 * Params:
 *   font = a font.
 * Returns: Named-instance index or %HB_FONT_NO_VAR_NAMED_INSTANCE.
 */
uint fontGetVarNamedInstance(Font font)
{
  uint _retval;
  _retval = hb_font_get_var_named_instance(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the glyph ID for a Unicode code point when followed by
 * by the specified variation-selector code point, in the specified
 * font.
 * Params:
 *   font = #hb_font_t to work upon
 *   unicode = The Unicode code point to query
 *   variationSelector = The  variation-selector code point to query
 *   glyph = The glyph ID retrieved
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGetVariationGlyph(Font font, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph)
{
  Bool _retval;
  _retval = hb_font_get_variation_glyph(font ? cast(hb_font_t*)font.cPtr(false) : null, unicode, variationSelector, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Fetches the glyph ID from font that matches the specified string.
 * Strings of the format `gidDDD` or `uniUUUU` are parsed automatically.
 * <note>Note: len \=\= -1 means the string is null-terminated.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   s = string to query
 *   glyph = The glyph ID corresponding to the string requested
 * Returns: `true` if data found, `false` otherwise
 */
Bool fontGlyphFromString(Font font, ubyte[] s, out Codepoint glyph)
{
  Bool _retval;
  int _len;
  if (s)
    _len = cast(int)s.length;

  auto _s = cast(const(ubyte)*)s.ptr;
  _retval = hb_font_glyph_from_string(font ? cast(hb_font_t*)font.cPtr(false) : null, _s, _len, cast(hb_codepoint_t*)&glyph);
  return _retval;
}

/**
 * Tests whether a font object is immutable.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: `true` if font is immutable, `false` otherwise
 */
Bool fontIsImmutable(Font font)
{
  Bool _retval;
  _retval = hb_font_is_immutable(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Makes font immutable.
 * Params:
 *   font = #hb_font_t to work upon
 */
void fontMakeImmutable(Font font)
{
  hb_font_make_immutable(font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Paints the glyph.
 * The painting instructions are returned by way of calls to
 * the callbacks of the funcs object, with paint_data passed
 * to them.
 * If the font has color palettes $(LPAREN)see [HarfBuzz.Global.otColorHasPalettes]$(RPAREN),
 * then palette_index selects the palette to use. If the font only
 * has one palette, this will be 0.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID
 *   pfuncs = #hb_paint_funcs_t to paint with
 *   paintData = User data to pass to paint callbacks
 *   paletteIndex = The index of the font's color palette to use
 *   foreground = The foreground color, unpremultipled
 */
void fontPaintGlyph(Font font, Codepoint glyph, PaintFuncs pfuncs, void* paintData, uint paletteIndex, Color foreground)
{
  hb_font_paint_glyph(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, pfuncs ? cast(hb_paint_funcs_t*)pfuncs.cPtr(false) : null, paintData, paletteIndex, foreground);
}

/**
 * Sets face as the font-face value of font.
 * Params:
 *   font = #hb_font_t to work upon
 *   face = The #hb_face_t to assign
 */
void fontSetFace(Font font, HBFace face)
{
  hb_font_set_face(font ? cast(hb_font_t*)font.cPtr(false) : null, face ? cast(hb_face_t*)face.cPtr(false) : null);
}

/**
 * Sets the parent font of font.
 * Params:
 *   font = #hb_font_t to work upon
 *   parent = The parent font object to assign
 */
void fontSetParent(Font font, Font parent)
{
  hb_font_set_parent(font ? cast(hb_font_t*)font.cPtr(false) : null, parent ? cast(hb_font_t*)parent.cPtr(false) : null);
}

/**
 * Sets the horizontal and vertical pixels-per-em $(LPAREN)PPEM$(RPAREN) of a font.
 * These values are used for pixel-size-specific adjustment to
 * shaping and draw results, though for the most part they are
 * unused and can be left unset.
 * Params:
 *   font = #hb_font_t to work upon
 *   xPpem = Horizontal ppem value to assign
 *   yPpem = Vertical ppem value to assign
 */
void fontSetPpem(Font font, uint xPpem, uint yPpem)
{
  hb_font_set_ppem(font ? cast(hb_font_t*)font.cPtr(false) : null, xPpem, yPpem);
}

/**
 * Sets the "point size" of a font. Set to zero to unset.
 * Used in CoreText to implement optical sizing.
 * <note>Note: There are 72 points in an inch.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   ptem = font size in points.
 */
void fontSetPtem(Font font, float ptem)
{
  hb_font_set_ptem(font ? cast(hb_font_t*)font.cPtr(false) : null, ptem);
}

/**
 * Sets the horizontal and vertical scale of a font.
 * The font scale is a number related to, but not the same as,
 * font size. Typically the client establishes a scale factor
 * to be used between the two. For example, 64, or 256, which
 * would be the fractional-precision part of the font scale.
 * This is necessary because #hb_position_t values are integer
 * types and you need to leave room for fractional values
 * in there.
 * For example, to set the font size to 20, with 64
 * levels of fractional precision you would call
 * `hb_font_set_scale$(LPAREN)font, 20 * 64, 20 * 64$(RPAREN)`.
 * In the example above, even what font size 20 means is up to
 * you. It might be 20 pixels, or 20 points, or 20 millimeters.
 * HarfBuzz does not care about that.  You can set the point
 * size of the font using [HarfBuzz.Global.fontSetPtem], and the pixel
 * size using [HarfBuzz.Global.fontSetPpem].
 * The choice of scale is yours but needs to be consistent between
 * what you set here, and what you expect out of #hb_position_t
 * as well has draw / paint API output values.
 * Fonts default to a scale equal to the UPEM value of their face.
 * A font with this setting is sometimes called an "unscaled" font.
 * Params:
 *   font = #hb_font_t to work upon
 *   xScale = Horizontal scale value to assign
 *   yScale = Vertical scale value to assign
 */
void fontSetScale(Font font, int xScale, int yScale)
{
  hb_font_set_scale(font ? cast(hb_font_t*)font.cPtr(false) : null, xScale, yScale);
}

/**
 * Sets the "synthetic boldness" of a font.
 * Positive values for x_embolden / y_embolden make a font
 * bolder, negative values thinner. Typical values are in the
 * 0.01 to 0.05 range. The default value is zero.
 * Synthetic boldness is applied by offsetting the contour
 * points of the glyph shape.
 * Synthetic boldness is applied when rendering a glyph via
 * [HarfBuzz.Global.fontDrawGlyph].
 * If in_place is `false`, then glyph advance-widths are also
 * adjusted, otherwise they are not.  The in-place mode is
 * useful for simulating [font grading](https://fonts.google.com/knowledge/glossary/grade).
 * Params:
 *   font = #hb_font_t to work upon
 *   xEmbolden = the amount to embolden horizontally
 *   yEmbolden = the amount to embolden vertically
 *   inPlace = whether to embolden glyphs in-place
 */
void fontSetSyntheticBold(Font font, float xEmbolden, float yEmbolden, Bool inPlace)
{
  hb_font_set_synthetic_bold(font ? cast(hb_font_t*)font.cPtr(false) : null, xEmbolden, yEmbolden, inPlace);
}

/**
 * Sets the "synthetic slant" of a font.  By default is zero.
 * Synthetic slant is the graphical skew applied to the font
 * at rendering time.
 * HarfBuzz needs to know this value to adjust shaping results,
 * metrics, and style values to match the slanted rendering.
 * <note>Note: The glyph shape fetched via the [HarfBuzz.Global.fontDrawGlyph]
 * function is slanted to reflect this value as well.</note>
 * <note>Note: The slant value is a ratio.  For example, a
 * 20% slant would be represented as a 0.2 value.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   slant = synthetic slant value.
 */
void fontSetSyntheticSlant(Font font, float slant)
{
  hb_font_set_synthetic_slant(font ? cast(hb_font_t*)font.cPtr(false) : null, slant);
}

/**
 * Applies a list of variation coordinates $(LPAREN)in design-space units$(RPAREN)
 * to a font.
 * Note that this overrides all existing variations set on font.
 * Axes not included in coords will be effectively set to their
 * default values.
 * Params:
 *   font = #hb_font_t to work upon
 *   coords = Array of variation coordinates to apply
 */
void fontSetVarCoordsDesign(Font font, float[] coords)
{
  uint _coordsLength;
  if (coords)
    _coordsLength = cast(uint)coords.length;

  auto _coords = cast(const(float)*)coords.ptr;
  hb_font_set_var_coords_design(font ? cast(hb_font_t*)font.cPtr(false) : null, _coords, _coordsLength);
}

/**
 * Applies a list of variation coordinates $(LPAREN)in normalized units$(RPAREN)
 * to a font.
 * Note that this overrides all existing variations set on font.
 * Axes not included in coords will be effectively set to their
 * default values.
 * <note>Note: Coordinates should be normalized to 2.14.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   coords = Array of variation coordinates to apply
 */
void fontSetVarCoordsNormalized(Font font, int[] coords)
{
  uint _coordsLength;
  if (coords)
    _coordsLength = cast(uint)coords.length;

  auto _coords = cast(const(int)*)coords.ptr;
  hb_font_set_var_coords_normalized(font ? cast(hb_font_t*)font.cPtr(false) : null, _coords, _coordsLength);
}

/**
 * Sets design coords of a font from a named-instance index.
 * Params:
 *   font = a font.
 *   instanceIndex = named instance index.
 */
void fontSetVarNamedInstance(Font font, uint instanceIndex)
{
  hb_font_set_var_named_instance(font ? cast(hb_font_t*)font.cPtr(false) : null, instanceIndex);
}

/**
 * Change the value of one variation axis on the font.
 * Note: This function is expensive to be called repeatedly.
 * If you want to set multiple variation axes at the same time,
 * use [HarfBuzz.Global.fontSetVariations] instead.
 * Params:
 *   font = #hb_font_t to work upon
 *   tag = The #hb_tag_t tag of the variation-axis name
 *   value = The value of the variation axis
 */
void fontSetVariation(Font font, Tag tag, float value)
{
  hb_font_set_variation(font ? cast(hb_font_t*)font.cPtr(false) : null, tag, value);
}

/**
 * Applies a list of font-variation settings to a font.
 * Note that this overrides all existing variations set on font.
 * Axes not included in variations will be effectively set to their
 * default values.
 * Params:
 *   font = #hb_font_t to work upon
 *   variations = Array of variation settings to apply
 */
void fontSetVariations(Font font, Variation[] variations)
{
  uint _variationsLength;
  if (variations)
    _variationsLength = cast(uint)variations.length;

  hb_variation_t[] _tmpvariations;
  foreach (obj; variations)
    _tmpvariations ~= obj.cInstance;
  const(hb_variation_t)* _variations = _tmpvariations.ptr;
  hb_font_set_variations(font ? cast(hb_font_t*)font.cPtr(false) : null, _variations, _variationsLength);
}

/**
 * Subtracts the origin coordinates from an $(LPAREN)X,Y$(RPAREN) point coordinate,
 * in the specified glyph ID in the specified font.
 * Calls the appropriate direction-specific variant $(LPAREN)horizontal
 * or vertical$(RPAREN) depending on the value of direction.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph ID to query
 *   direction = The direction of the text segment
 *   x = Input \= The original X coordinate
 *     Output \= The X coordinate minus the X-coordinate of the origin
 *   y = Input \= The original Y coordinate
 *     Output \= The Y coordinate minus the Y-coordinate of the origin
 */
void fontSubtractGlyphOriginForDirection(Font font, Codepoint glyph, Direction direction, ref Position x, ref Position y)
{
  hb_font_subtract_glyph_origin_for_direction(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, cast(hb_position_t*)&x, cast(hb_position_t*)&y);
}

/**
 * Creates an #hb_face_t face object from the specified FT_Face.
 * Note that this is using the FT_Face object just to get at the underlying
 * font data, and fonts created from the returned #hb_face_t will use the native
 * HarfBuzz font implementation, unless you call [HarfBuzz.Global.ftFontSetFuncs] on them.
 * This variant of the function caches the newly created #hb_face_t
 * face object, using the generic pointer of ft_face. Subsequent function
 * calls that are passed the same ft_face parameter will have the same
 * #hb_face_t returned to them, and that #hb_face_t will be correctly
 * reference counted.
 * However, client programs are still responsible for destroying
 * ft_face after the last #hb_face_t face object has been destroyed.
 * Params:
 *   ftFace = FT_Face to work upon
 * Returns: the new #hb_face_t face object
 */
HBFace ftFaceCreateCached(Face ftFace)
{
  hb_face_t* _cretval;
  _cretval = hb_ft_face_create_cached(ftFace);
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates an #hb_face_t face object from the specified FT_Face.
 * Note that this is using the FT_Face object just to get at the underlying
 * font data, and fonts created from the returned #hb_face_t will use the native
 * HarfBuzz font implementation, unless you call [HarfBuzz.Global.ftFontSetFuncs] on them.
 * This is the preferred variant of the hb_ft_face_create*
 * function family, because it calls FT_Reference_Face$(LPAREN)$(RPAREN) on ft_face,
 * ensuring that ft_face remains alive as long as the resulting
 * #hb_face_t face object remains alive. Also calls FT_Done_Face$(LPAREN)$(RPAREN)
 * when the #hb_face_t face object is destroyed.
 * Use this version unless you know you have good reasons not to.
 * Params:
 *   ftFace = FT_Face to work upon
 * Returns: the new #hb_face_t face object
 */
HBFace ftFaceCreateReferenced(Face ftFace)
{
  hb_face_t* _cretval;
  _cretval = hb_ft_face_create_referenced(ftFace);
  auto _retval = _cretval ? new HBFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Refreshes the state of font when the underlying FT_Face has changed.
 * This function should be called after changing the size or
 * variation-axis settings on the FT_Face.
 * Params:
 *   font = #hb_font_t to work upon
 */
void ftFontChanged(Font font)
{
  hb_ft_font_changed(font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Creates an #hb_font_t font object from the specified FT_Face.
 * <note>Note: You must set the face size on ft_face before calling
 * [HarfBuzz.Global.ftFontCreateReferenced] on it. HarfBuzz assumes size is always set
 * and will access `size` member of FT_Face unconditionally.</note>
 * This is the preferred variant of the hb_ft_font_create*
 * function family, because it calls FT_Reference_Face$(LPAREN)$(RPAREN) on ft_face,
 * ensuring that ft_face remains alive as long as the resulting
 * #hb_font_t font object remains alive.
 * Use this version unless you know you have good reasons not to.
 * Params:
 *   ftFace = FT_Face to work upon
 * Returns: the new #hb_font_t font object
 */
Font ftFontCreateReferenced(Face ftFace)
{
  hb_font_t* _cretval;
  _cretval = hb_ft_font_create_referenced(ftFace);
  auto _retval = _cretval ? new Font(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the FT_Load_Glyph load flags of the specified #hb_font_t.
 * For more information, see
 * <https://freetype.org/freetype2/docs/reference/ft2-glyph_retrieval.html#ft_load_xxx>
 * This function works with #hb_font_t objects created by
 * [HarfBuzz.Global.ftFontCreate] or [HarfBuzz.Global.ftFontCreateReferenced].
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: FT_Load_Glyph flags found, or 0
 */
int ftFontGetLoadFlags(Font font)
{
  int _retval;
  _retval = hb_ft_font_get_load_flags(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Configures the font-functions structure of the specified
 * #hb_font_t font object to use FreeType font functions.
 * In particular, you can use this function to configure an
 * existing #hb_face_t face object for use with FreeType font
 * functions even if that #hb_face_t face object was initially
 * created with [HarfBuzz.Global.faceCreate], and therefore was not
 * initially configured to use FreeType font functions.
 * An #hb_font_t object created with [HarfBuzz.Global.ftFontCreate]
 * is preconfigured for FreeType font functions and does not
 * require this function to be used.
 * Note that if you modify the underlying #hb_font_t after
 * calling this function, you need to call [HarfBuzz.Global.ftHbFontChanged]
 * to update the underlying FT_Face.
 * <note>Note: Internally, this function creates an FT_Face.
 * </note>
 * Params:
 *   font = #hb_font_t to work upon
 */
void ftFontSetFuncs(Font font)
{
  hb_ft_font_set_funcs(font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Sets the FT_Load_Glyph load flags for the specified #hb_font_t.
 * For more information, see
 * <https://freetype.org/freetype2/docs/reference/ft2-glyph_retrieval.html#ft_load_xxx>
 * This function works with #hb_font_t objects created by
 * [HarfBuzz.Global.ftFontCreate] or [HarfBuzz.Global.ftFontCreateReferenced].
 * Params:
 *   font = #hb_font_t to work upon
 *   loadFlags = The FreeType load flags to set
 */
void ftFontSetLoadFlags(Font font, int loadFlags)
{
  hb_ft_font_set_load_flags(font ? cast(hb_font_t*)font.cPtr(false) : null, loadFlags);
}

/**
 * Refreshes the state of the underlying FT_Face of font when the hb_font_t
 * font has changed.
 * This function should be called after changing the size or
 * variation-axis settings on the font.
 * This call is fast if nothing has changed on font.
 * Params:
 *   font = #hb_font_t to work upon
 * Returns: true if changed, false otherwise
 */
Bool ftHbFontChanged(Font font)
{
  Bool _retval;
  _retval = hb_ft_hb_font_changed(font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches a Unicode-functions structure that is populated
 * with the appropriate GLib function for each method.
 * Returns: a pointer to the #hb_unicode_funcs_t Unicode-functions structure
 */
UnicodeFuncs glibGetUnicodeFuncs()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_glib_get_unicode_funcs();
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Fetches the GUnicodeScript identifier that corresponds to the
 * specified #hb_script_t script.
 * Params:
 *   script = The #hb_script_t to query
 * Returns: the GUnicodeScript identifier found
 */
UnicodeScript glibScriptFromScript(Script script)
{
  GUnicodeScript _cretval;
  _cretval = hb_glib_script_from_script(script);
  UnicodeScript _retval = cast(UnicodeScript)_cretval;
  return _retval;
}

/**
 * Fetches the #hb_script_t script that corresponds to the
 * specified GUnicodeScript identifier.
 * Params:
 *   script = The GUnicodeScript identifier to query
 * Returns: the #hb_script_t script found
 */
Script glibScriptToScript(UnicodeScript script)
{
  hb_script_t _cretval;
  _cretval = hb_glib_script_to_script(script);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Returns glyph flags encoded within a #hb_glyph_info_t.
 * Params:
 *   info = a #hb_glyph_info_t
 * Returns: The #hb_glyph_flags_t encoded within info
 */
GlyphFlags glyphInfoGetGlyphFlags(GlyphInfo info)
{
  hb_glyph_flags_t _cretval;
  _cretval = hb_glyph_info_get_glyph_flags(info ? cast(hb_glyph_info_t*)info.cPtr(false) : null);
  GlyphFlags _retval = cast(GlyphFlags)_cretval;
  return _retval;
}

/**
 * Converts str representing a BCP 47 language tag to the corresponding
 * #hb_language_t.
 * Params:
 *   str = a string representing
 *     a BCP 47 language tag
 * Returns: The #hb_language_t corresponding to the BCP 47 language tag.
 */
Language languageFromString(ubyte[] str)
{
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  auto _retval = hb_language_from_string(_str, _len);
  return _retval;
}

/**
 * Fetch the default language from current locale.
 * <note>Note that the first time this function is called, it calls
 * "setlocale $(LPAREN)LC_CTYPE, nullptr$(RPAREN)" to fetch current locale.  The underlying
 * setlocale function is, in many implementations, NOT threadsafe.  To avoid
 * problems, call this function once before multiple threads can call it.
 * This function is only used from [HarfBuzz.Global.bufferGuessSegmentProperties] by
 * HarfBuzz itself.</note>
 * Returns: The default language of the locale as
 *   an #hb_language_t
 */
Language languageGetDefault()
{
  auto _retval = hb_language_get_default();
  return _retval;
}

/**
 * Check whether a second language tag is the same or a more
 * specific version of the provided language tag.  For example,
 * "fa_IR.utf8" is a more specific tag for "fa" or for "fa_IR".
 * Params:
 *   language = The #hb_language_t to work on
 *   specific = Another #hb_language_t
 * Returns: `true` if languages match, `false` otherwise.
 */
Bool languageMatches(Language language, Language specific)
{
  Bool _retval;
  _retval = hb_language_matches(language, specific);
  return _retval;
}

/**
 * Converts an #hb_language_t to a string.
 * Params:
 *   language = The #hb_language_t to convert
 * Returns: A `NULL`-terminated string representing the language. Must not be freed by
 *   the caller.
 */
string languageToString(Language language)
{
  const(char)* _cretval;
  _cretval = hb_language_to_string(language);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Tests whether memory allocation for a set was successful.
 * Params:
 *   map = A map
 * Returns: `true` if allocation succeeded, `false` otherwise
 */
Bool mapAllocationSuccessful(Map map)
{
  Bool _retval;
  _retval = hb_map_allocation_successful(map ? cast(hb_map_t*)map.cPtr(false) : null);
  return _retval;
}

/**
 * Clears out the contents of map.
 * Params:
 *   map = A map
 */
void mapClear(Map map)
{
  hb_map_clear(map ? cast(hb_map_t*)map.cPtr(false) : null);
}

/**
 * Allocate a copy of map.
 * Params:
 *   map = A map
 * Returns: Newly-allocated map.
 */
Map mapCopy(Map map)
{
  hb_map_t* _cretval;
  _cretval = hb_map_copy(map ? cast(hb_map_t*)map.cPtr(false) : null);
  auto _retval = _cretval ? new Map(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new, initially empty map.
 * Returns: The new #hb_map_t
 */
Map mapCreate()
{
  hb_map_t* _cretval;
  _cretval = hb_map_create();
  auto _retval = _cretval ? new Map(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Removes key and its stored value from map.
 * Params:
 *   map = A map
 *   key = The key to delete
 */
void mapDel(Map map, Codepoint key)
{
  hb_map_del(map ? cast(hb_map_t*)map.cPtr(false) : null, key);
}

/**
 * Fetches the value stored for key in map.
 * Params:
 *   map = A map
 *   key = The key to query
 * Returns:
 */
Codepoint mapGet(Map map, Codepoint key)
{
  Codepoint _retval;
  _retval = hb_map_get(map ? cast(hb_map_t*)map.cPtr(false) : null, key);
  return _retval;
}

/**
 * Fetches the singleton empty #hb_map_t.
 * Returns: The empty #hb_map_t
 */
Map mapGetEmpty()
{
  hb_map_t* _cretval;
  _cretval = hb_map_get_empty();
  auto _retval = _cretval ? new Map(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Returns the number of key-value pairs in the map.
 * Params:
 *   map = A map
 * Returns: The population of map
 */
uint mapGetPopulation(Map map)
{
  uint _retval;
  _retval = hb_map_get_population(map ? cast(hb_map_t*)map.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether key is an element of map.
 * Params:
 *   map = A map
 *   key = The key to query
 * Returns: `true` if key is found in map, `false` otherwise
 */
Bool mapHas(Map map, Codepoint key)
{
  Bool _retval;
  _retval = hb_map_has(map ? cast(hb_map_t*)map.cPtr(false) : null, key);
  return _retval;
}

/**
 * Creates a hash representing map.
 * Params:
 *   map = A map
 * Returns: A hash of map.
 */
uint mapHash(Map map)
{
  uint _retval;
  _retval = hb_map_hash(map ? cast(hb_map_t*)map.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether map is empty $(LPAREN)contains no elements$(RPAREN).
 * Params:
 *   map = A map
 * Returns: `true` if map is empty
 */
Bool mapIsEmpty(Map map)
{
  Bool _retval;
  _retval = hb_map_is_empty(map ? cast(hb_map_t*)map.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether map and other are equal $(LPAREN)contain the same
 * elements$(RPAREN).
 * Params:
 *   map = A map
 *   other = Another map
 * Returns: `true` if the two maps are equal, `false` otherwise.
 */
Bool mapIsEqual(Map map, Map other)
{
  Bool _retval;
  _retval = hb_map_is_equal(map ? cast(hb_map_t*)map.cPtr(false) : null, other ? cast(hb_map_t*)other.cPtr(false) : null);
  return _retval;
}

/**
 * Add the keys of map to keys.
 * Params:
 *   map = A map
 *   keys = A set
 */
void mapKeys(Map map, Set keys)
{
  hb_map_keys(map ? cast(hb_map_t*)map.cPtr(false) : null, keys ? cast(hb_set_t*)keys.cPtr(false) : null);
}

/**
 * Fetches the next key/value pair in map.
 * Set idx to -1 to get started.
 * If the map is modified during iteration, the behavior is undefined.
 * The order in which the key/values are returned is undefined.
 * Params:
 *   map = A map
 *   idx = Iterator internal state
 *   key = Key retrieved
 *   value = Value retrieved
 * Returns: `true` if there was a next value, `false` otherwise
 */
Bool mapNext(Map map, ref int idx, out Codepoint key, out Codepoint value)
{
  Bool _retval;
  _retval = hb_map_next(map ? cast(hb_map_t*)map.cPtr(false) : null, cast(int*)&idx, cast(hb_codepoint_t*)&key, cast(hb_codepoint_t*)&value);
  return _retval;
}

/**
 * Stores key:value in the map.
 * Params:
 *   map = A map
 *   key = The key to store in the map
 *   value = The value to store for key
 */
void mapSet(Map map, Codepoint key, Codepoint value)
{
  hb_map_set(map ? cast(hb_map_t*)map.cPtr(false) : null, key, value);
}

/**
 * Add the contents of other to map.
 * Params:
 *   map = A map
 *   other = Another map
 */
void mapUpdate(Map map, Map other)
{
  hb_map_update(map ? cast(hb_map_t*)map.cPtr(false) : null, other ? cast(hb_map_t*)other.cPtr(false) : null);
}

/**
 * Add the values of map to values.
 * Params:
 *   map = A map
 *   values = A set
 */
void mapValues(Map map, Set values)
{
  hb_map_values(map ? cast(hb_map_t*)map.cPtr(false) : null, values ? cast(hb_set_t*)values.cPtr(false) : null);
}

/**
 * Fetches a list of all color layers for the specified glyph index in the specified
 * face. The list returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   glyph = The glyph index to query
 *   startOffset = offset of the first layer to retrieve
 *   layers = The array of layers found
 * Returns: Total number of layers available for the glyph index queried
 */
uint otColorGlyphGetLayers(HBFace face, Codepoint glyph, uint startOffset, ref OtColorLayer[] layers)
{
  uint _retval;
  uint _layerCount;
  _retval = hb_ot_color_glyph_get_layers(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph, startOffset, &_layerCount, layers.ptr);
  return _retval;
}

/**
 * Tests where a face includes COLRv1 paint
 * data for glyph.
 * Params:
 *   face = #hb_face_t to work upon
 *   glyph = The glyph index to query
 * Returns: `true` if data found, `false` otherwise
 */
Bool otColorGlyphHasPaint(HBFace face, Codepoint glyph)
{
  Bool _retval;
  _retval = hb_ot_color_glyph_has_paint(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * Fetches the PNG image for a glyph. This function takes a font object, not a face object,
 * as input. To get an optimally sized PNG blob, the PPEM values must be set on the font
 * object. If PPEM is unset, the blob returned will be the largest PNG available.
 * If the glyph has no PNG image, the singleton empty blob is returned.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = a glyph index
 * Returns: An #hb_blob_t containing the PNG image for the glyph, if available
 */
Blob otColorGlyphReferencePng(Font font, Codepoint glyph)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_color_glyph_reference_png(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the SVG document for a glyph. The blob may be either plain text or gzip-encoded.
 * If the glyph has no SVG document, the singleton empty blob is returned.
 * Params:
 *   face = #hb_face_t to work upon
 *   glyph = a svg glyph index
 * Returns: An #hb_blob_t containing the SVG document of the glyph, if available
 */
Blob otColorGlyphReferenceSvg(HBFace face, Codepoint glyph)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_color_glyph_reference_svg(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Tests whether a face includes a `COLR` table
 * with data according to COLRv0.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otColorHasLayers(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_layers(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests where a face includes a `COLR` table
 * with data according to COLRv1.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otColorHasPaint(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_paint(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether a face includes a `CPAL` color-palette table.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otColorHasPalettes(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_palettes(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether a face has PNG glyph images $(LPAREN)either in `CBDT` or `sbix` tables$(RPAREN).
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otColorHasPng(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_png(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether a face includes any `SVG` glyph images.
 * Params:
 *   face = #hb_face_t to work upon.
 * Returns: `true` if data found, `false` otherwise.
 */
Bool otColorHasSvg(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_color_has_svg(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the `name` table Name ID that provides display names for
 * the specified color in a face's `CPAL` color palette.
 * Display names can be generic $(LPAREN)e.g., "Background"$(RPAREN) or specific
 * $(LPAREN)e.g., "Eye color"$(RPAREN).
 * Params:
 *   face = #hb_face_t to work upon
 *   colorIndex = The index of the color
 * Returns: the Name ID found for the color.
 */
OtNameId otColorPaletteColorGetNameId(HBFace face, uint colorIndex)
{
  OtNameId _retval;
  _retval = hb_ot_color_palette_color_get_name_id(face ? cast(hb_face_t*)face.cPtr(false) : null, colorIndex);
  return _retval;
}

/**
 * Fetches a list of the colors in a color palette.
 * After calling this function, colors will be filled with the palette
 * colors. If colors is NULL, the function will just return the number
 * of total colors without storing any actual colors; this can be used
 * for allocating a buffer of suitable size before calling
 * [HarfBuzz.Global.otColorPaletteGetColors] a second time.
 * The RGBA values in the palette are unpremultiplied. See the
 * OpenType spec [CPAL](https://learn.microsoft.com/en-us/typography/opentype/spec/cpal)
 * section for details.
 * Params:
 *   face = #hb_face_t to work upon
 *   paletteIndex = the index of the color palette to query
 *   startOffset = offset of the first color to retrieve
 *   colors = The array of #hb_color_t records found
 * Returns: the total number of colors in the palette
 */
uint otColorPaletteGetColors(HBFace face, uint paletteIndex, uint startOffset, ref Color[] colors)
{
  uint _retval;
  uint _colorCount;
  _retval = hb_ot_color_palette_get_colors(face ? cast(hb_face_t*)face.cPtr(false) : null, paletteIndex, startOffset, &_colorCount, colors.ptr);
  return _retval;
}

/**
 * Fetches the number of color palettes in a face.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: the number of palettes found
 */
uint otColorPaletteGetCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_color_palette_get_count(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the flags defined for a color palette.
 * Params:
 *   face = #hb_face_t to work upon
 *   paletteIndex = The index of the color palette
 * Returns: the #hb_ot_color_palette_flags_t of the requested color palette
 */
OtColorPaletteFlags otColorPaletteGetFlags(HBFace face, uint paletteIndex)
{
  hb_ot_color_palette_flags_t _cretval;
  _cretval = hb_ot_color_palette_get_flags(face ? cast(hb_face_t*)face.cPtr(false) : null, paletteIndex);
  OtColorPaletteFlags _retval = cast(OtColorPaletteFlags)_cretval;
  return _retval;
}

/**
 * Fetches the `name` table Name ID that provides display names for
 * a `CPAL` color palette.
 * Palette display names can be generic $(LPAREN)e.g., "Default"$(RPAREN) or provide
 * specific, themed names $(LPAREN)e.g., "Spring", "Summer", "Fall", and "Winter"$(RPAREN).
 * Params:
 *   face = #hb_face_t to work upon
 *   paletteIndex = The index of the color palette
 * Returns: the Named ID found for the palette.
 *   If the requested palette has no name the result is #HB_OT_NAME_ID_INVALID.
 */
OtNameId otColorPaletteGetNameId(HBFace face, uint paletteIndex)
{
  OtNameId _retval;
  _retval = hb_ot_color_palette_get_name_id(face ? cast(hb_face_t*)face.cPtr(false) : null, paletteIndex);
  return _retval;
}

/**
 * Sets the font functions to use when working with font.
 * Params:
 *   font = #hb_font_t to work upon
 */
void otFontSetFuncs(Font font)
{
  hb_ot_font_set_funcs(font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Fetches a list of the characters defined as having a variant under the specified
 * "Character Variant" $(LPAREN)"cvXX"$(RPAREN) feature tag.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = table tag to query, "GSUB" or "GPOS".
 *   featureIndex = index of feature to query.
 *   startOffset = offset of the first character to retrieve
 *   characters = A buffer pointer.
 *     The Unicode codepoints of the characters for which this feature provides
 *     glyph variants.
 * Returns: Number of total sample characters in the cvXX feature.
 */
uint otLayoutFeatureGetCharacters(HBFace face, Tag tableTag, uint featureIndex, uint startOffset, ref Codepoint[] characters)
{
  uint _retval;
  uint _charCount;
  _retval = hb_ot_layout_feature_get_characters(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, featureIndex, startOffset, &_charCount, characters.ptr);
  return _retval;
}

/**
 * Fetches a list of all lookups enumerated for the specified feature, in
 * the specified face's GSUB table or GPOS table. The list returned will
 * begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   featureIndex = The index of the requested feature
 *   startOffset = offset of the first lookup to retrieve
 *   lookupIndexes = The array of lookup indexes found for the query
 * Returns: Total number of lookups.
 */
uint otLayoutFeatureGetLookups(HBFace face, Tag tableTag, uint featureIndex, uint startOffset, ref uint[] lookupIndexes)
{
  uint _retval;
  uint _lookupCount;
  _retval = hb_ot_layout_feature_get_lookups(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, featureIndex, startOffset, &_lookupCount, lookupIndexes.ptr);
  return _retval;
}

/**
 * Fetches name indices from feature parameters for "Stylistic Set" $(LPAREN)'ssXX'$(RPAREN) or
 * "Character Variant" $(LPAREN)'cvXX'$(RPAREN) features.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = table tag to query, "GSUB" or "GPOS".
 *   featureIndex = index of feature to query.
 *   labelId = The ‘name’ table name ID that specifies a string
 *     for a user-interface label for this feature. $(LPAREN)May be NULL.$(RPAREN)
 *   tooltipId = The ‘name’ table name ID that specifies a string
 *     that an application can use for tooltip text for this
 *     feature. $(LPAREN)May be NULL.$(RPAREN)
 *   sampleId = The ‘name’ table name ID that specifies sample text
 *     that illustrates the effect of this feature. $(LPAREN)May be NULL.$(RPAREN)
 *   numNamedParameters = Number of named parameters. $(LPAREN)May be zero.$(RPAREN)
 *   firstParamId = The first ‘name’ table name ID used to specify
 *     strings for user-interface labels for the feature
 *     parameters. $(LPAREN)Must be zero if numParameters is zero.$(RPAREN)
 * Returns: `true` if data found, `false` otherwise
 */
Bool otLayoutFeatureGetNameIds(HBFace face, Tag tableTag, uint featureIndex, out OtNameId labelId, out OtNameId tooltipId, out OtNameId sampleId, out uint numNamedParameters, out OtNameId firstParamId)
{
  Bool _retval;
  _retval = hb_ot_layout_feature_get_name_ids(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, featureIndex, cast(hb_ot_name_id_t*)&labelId, cast(hb_ot_name_id_t*)&tooltipId, cast(hb_ot_name_id_t*)&sampleId, cast(uint*)&numNamedParameters, cast(hb_ot_name_id_t*)&firstParamId);
  return _retval;
}

/**
 * Fetches a list of all lookups enumerated for the specified feature, in
 * the specified face's GSUB table or GPOS table, enabled at the specified
 * variations index. The list returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   featureIndex = The index of the feature to query
 *   variationsIndex = The index of the feature variation to query
 *   startOffset = offset of the first lookup to retrieve
 *   lookupIndexes = The array of lookups found for the query
 * Returns: Total number of lookups.
 */
uint otLayoutFeatureWithVariationsGetLookups(HBFace face, Tag tableTag, uint featureIndex, uint variationsIndex, uint startOffset, ref uint[] lookupIndexes)
{
  uint _retval;
  uint _lookupCount;
  _retval = hb_ot_layout_feature_with_variations_get_lookups(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, featureIndex, variationsIndex, startOffset, &_lookupCount, lookupIndexes.ptr);
  return _retval;
}

/**
 * Fetches a list of all attachment points for the specified glyph in the GDEF
 * table of the face. The list returned will begin at the offset provided.
 * Useful if the client program wishes to cache the list.
 * Params:
 *   face = The #hb_face_t to work on
 *   glyph = The #hb_codepoint_t code point to query
 *   startOffset = offset of the first attachment point to retrieve
 *   pointArray = The array of attachment points found for the query
 * Returns: Total number of attachment points for glyph.
 */
uint otLayoutGetAttachPoints(HBFace face, Codepoint glyph, uint startOffset, ref uint[] pointArray)
{
  uint _retval;
  uint _pointCount;
  _retval = hb_ot_layout_get_attach_points(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph, startOffset, &_pointCount, pointArray.ptr);
  return _retval;
}

/**
 * Fetches a baseline value from the face.
 * Params:
 *   font = a font
 *   baselineTag = a baseline tag
 *   direction = text direction.
 *   scriptTag = script tag.
 *   languageTag = language tag, currently unused.
 *   coord = baseline value if found.
 * Returns: `true` if found baseline value in the font.
 */
Bool otLayoutGetBaseline(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Tag scriptTag, Tag languageTag, out Position coord)
{
  Bool _retval;
  _retval = hb_ot_layout_get_baseline(font ? cast(hb_font_t*)font.cPtr(false) : null, baselineTag, direction, scriptTag, languageTag, cast(hb_position_t*)&coord);
  return _retval;
}

/**
 * Fetches a baseline value from the face.
 * This function is like [HarfBuzz.Global.otLayoutGetBaseline] but takes
 * #hb_script_t and #hb_language_t instead of OpenType #hb_tag_t.
 * Params:
 *   font = a font
 *   baselineTag = a baseline tag
 *   direction = text direction.
 *   script = script.
 *   language = language, currently unused.
 *   coord = baseline value if found.
 * Returns: `true` if found baseline value in the font.
 */
Bool otLayoutGetBaseline2(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Script script, Language language, out Position coord)
{
  Bool _retval;
  _retval = hb_ot_layout_get_baseline2(font ? cast(hb_font_t*)font.cPtr(false) : null, baselineTag, direction, script, language, cast(hb_position_t*)&coord);
  return _retval;
}

/**
 * Fetches a baseline value from the face, and synthesizes
 * it if the font does not have it.
 * Params:
 *   font = a font
 *   baselineTag = a baseline tag
 *   direction = text direction.
 *   scriptTag = script tag.
 *   languageTag = language tag, currently unused.
 *   coord = baseline value if found.
 */
void otLayoutGetBaselineWithFallback(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Tag scriptTag, Tag languageTag, out Position coord)
{
  hb_ot_layout_get_baseline_with_fallback(font ? cast(hb_font_t*)font.cPtr(false) : null, baselineTag, direction, scriptTag, languageTag, cast(hb_position_t*)&coord);
}

/**
 * Fetches a baseline value from the face, and synthesizes
 * it if the font does not have it.
 * This function is like [HarfBuzz.Global.otLayoutGetBaselineWithFallback] but takes
 * #hb_script_t and #hb_language_t instead of OpenType #hb_tag_t.
 * Params:
 *   font = a font
 *   baselineTag = a baseline tag
 *   direction = text direction.
 *   script = script.
 *   language = language, currently unused.
 *   coord = baseline value if found.
 */
void otLayoutGetBaselineWithFallback2(Font font, OtLayoutBaselineTag baselineTag, Direction direction, Script script, Language language, out Position coord)
{
  hb_ot_layout_get_baseline_with_fallback2(font ? cast(hb_font_t*)font.cPtr(false) : null, baselineTag, direction, script, language, cast(hb_position_t*)&coord);
}

/**
 * Fetches script/language-specific font extents.  These values are
 * looked up in the `BASE` table's `MinMax` records.
 * If no such extents are found, the default extents for the font are
 * fetched. As such, the return value of this function can for the
 * most part be ignored.  Note that the per-script/language extents
 * do not have a line-gap value, and the line-gap is set to zero in
 * that case.
 * Params:
 *   font = a font
 *   direction = text direction.
 *   scriptTag = script tag.
 *   languageTag = language tag.
 *   extents = font extents if found.
 * Returns: `true` if found script/language-specific font extents.
 */
Bool otLayoutGetFontExtents(Font font, Direction direction, Tag scriptTag, Tag languageTag, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_ot_layout_get_font_extents(font ? cast(hb_font_t*)font.cPtr(false) : null, direction, scriptTag, languageTag, &extents);
  return _retval;
}

/**
 * Fetches script/language-specific font extents.  These values are
 * looked up in the `BASE` table's `MinMax` records.
 * If no such extents are found, the default extents for the font are
 * fetched. As such, the return value of this function can for the
 * most part be ignored.  Note that the per-script/language extents
 * do not have a line-gap value, and the line-gap is set to zero in
 * that case.
 * This function is like [HarfBuzz.Global.otLayoutGetFontExtents] but takes
 * #hb_script_t and #hb_language_t instead of OpenType #hb_tag_t.
 * Params:
 *   font = a font
 *   direction = text direction.
 *   script = script.
 *   language = language.
 *   extents = font extents if found.
 * Returns: `true` if found script/language-specific font extents.
 */
Bool otLayoutGetFontExtents2(Font font, Direction direction, Script script, Language language, out FontExtents extents)
{
  Bool _retval;
  _retval = hb_ot_layout_get_font_extents2(font ? cast(hb_font_t*)font.cPtr(false) : null, direction, script, language, &extents);
  return _retval;
}

/**
 * Fetches the GDEF class of the requested glyph in the specified face.
 * Params:
 *   face = The #hb_face_t to work on
 *   glyph = The #hb_codepoint_t code point to query
 * Returns: The #hb_ot_layout_glyph_class_t glyph class of the given code
 *   point in the GDEF table of the face.
 */
OtLayoutGlyphClass otLayoutGetGlyphClass(HBFace face, Codepoint glyph)
{
  hb_ot_layout_glyph_class_t _cretval;
  _cretval = hb_ot_layout_get_glyph_class(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph);
  OtLayoutGlyphClass _retval = cast(OtLayoutGlyphClass)_cretval;
  return _retval;
}

/**
 * Fetches the dominant horizontal baseline tag used by script.
 * Params:
 *   script = a script tag.
 * Returns: dominant baseline tag for the script.
 */
OtLayoutBaselineTag otLayoutGetHorizontalBaselineTagForScript(Script script)
{
  hb_ot_layout_baseline_tag_t _cretval;
  _cretval = hb_ot_layout_get_horizontal_baseline_tag_for_script(script);
  OtLayoutBaselineTag _retval = cast(OtLayoutBaselineTag)_cretval;
  return _retval;
}

/**
 * Fetches a list of the caret positions defined for a ligature glyph in the GDEF
 * table of the font. The list returned will begin at the offset provided.
 * Note that a ligature that is formed from n characters will have n-1
 * caret positions. The first character is not represented in the array,
 * since its caret position is the glyph position.
 * The positions returned by this function are 'unshaped', and will have to
 * be fixed up for kerning that may be applied to the ligature glyph.
 * Params:
 *   font = The #hb_font_t to work on
 *   direction = The #hb_direction_t text direction to use
 *   glyph = The #hb_codepoint_t code point to query
 *   startOffset = offset of the first caret position to retrieve
 *   caretArray = The array of caret positions found for the query
 * Returns: Total number of ligature caret positions for glyph.
 */
uint otLayoutGetLigatureCarets(Font font, Direction direction, Codepoint glyph, uint startOffset, ref Position[] caretArray)
{
  uint _retval;
  uint _caretCount;
  _retval = hb_ot_layout_get_ligature_carets(font ? cast(hb_font_t*)font.cPtr(false) : null, direction, glyph, startOffset, &_caretCount, caretArray.ptr);
  return _retval;
}

/**
 * Fetches optical-size feature data $(LPAREN)i.e., the `size` feature from GPOS$(RPAREN). Note that
 * the subfamily_id and the subfamily name string $(LPAREN)accessible via the subfamily_name_id$(RPAREN)
 * as used here are defined as pertaining only to fonts within a font family that differ
 * specifically in their respective size ranges; other ways to differentiate fonts within
 * a subfamily are not covered by the `size` feature.
 * For more information on this distinction, see the [`size` feature documentation]$(LPAREN)
 * https://docs.microsoft.com/en-us/typography/opentype/spec/features_pt#tag-size$(RPAREN).
 * Params:
 *   face = #hb_face_t to work upon
 *   designSize = The design size of the face
 *   subfamilyId = The identifier of the face within the font subfamily
 *   subfamilyNameId = The ‘name’ table name ID of the face within the font subfamily
 *   rangeStart = The minimum size of the recommended size range for the face
 *   rangeEnd = The maximum size of the recommended size range for the face
 * Returns: `true` if data found, `false` otherwise
 */
Bool otLayoutGetSizeParams(HBFace face, out uint designSize, out uint subfamilyId, out OtNameId subfamilyNameId, out uint rangeStart, out uint rangeEnd)
{
  Bool _retval;
  _retval = hb_ot_layout_get_size_params(face ? cast(hb_face_t*)face.cPtr(false) : null, cast(uint*)&designSize, cast(uint*)&subfamilyId, cast(hb_ot_name_id_t*)&subfamilyNameId, cast(uint*)&rangeStart, cast(uint*)&rangeEnd);
  return _retval;
}

/**
 * Tests whether a face has any glyph classes defined in its GDEF table.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otLayoutHasGlyphClasses(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_glyph_classes(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the specified face includes any GPOS positioning.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if the face has GPOS data, `false` otherwise
 */
Bool otLayoutHasPositioning(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_positioning(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the specified face includes any GSUB substitutions.
 * Params:
 *   face = #hb_face_t to work upon
 * Returns: `true` if data found, `false` otherwise
 */
Bool otLayoutHasSubstitution(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_layout_has_substitution(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the index of a given feature tag in the specified face's GSUB table
 * or GPOS table, underneath the specified script and language.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageIndex = The index of the requested language tag
 *   featureTag = #hb_tag_t of the feature tag requested
 *   featureIndex = The index of the requested feature
 * Returns: `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageFindFeature(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, Tag featureTag, out uint featureIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_language_find_feature(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageIndex, featureTag, cast(uint*)&featureIndex);
  return _retval;
}

/**
 * Fetches a list of all features in the specified face's GSUB table
 * or GPOS table, underneath the specified script and language. The list
 * returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageIndex = The index of the requested language tag
 *   startOffset = offset of the first feature tag to retrieve
 *   featureIndexes = The array of feature indexes found for the query
 * Returns: Total number of features.
 */
uint otLayoutLanguageGetFeatureIndexes(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, uint startOffset, ref uint[] featureIndexes)
{
  uint _retval;
  uint _featureCount;
  _retval = hb_ot_layout_language_get_feature_indexes(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageIndex, startOffset, &_featureCount, featureIndexes.ptr);
  return _retval;
}

/**
 * Fetches a list of all features in the specified face's GSUB table
 * or GPOS table, underneath the specified script and language. The list
 * returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageIndex = The index of the requested language tag
 *   startOffset = offset of the first feature tag to retrieve
 *   featureTags = The array of #hb_tag_t feature tags found for the query
 * Returns: Total number of feature tags.
 */
uint otLayoutLanguageGetFeatureTags(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, uint startOffset, ref Tag[] featureTags)
{
  uint _retval;
  uint _featureCount;
  _retval = hb_ot_layout_language_get_feature_tags(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageIndex, startOffset, &_featureCount, featureTags.ptr);
  return _retval;
}

/**
 * Fetches the tag of a requested feature index in the given face's GSUB or GPOS table,
 * underneath the specified script and language.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageIndex = The index of the requested language tag
 *   featureIndex = The index of the requested feature
 *   featureTag = The #hb_tag_t of the requested feature
 * Returns: `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageGetRequiredFeature(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, out uint featureIndex, out Tag featureTag)
{
  Bool _retval;
  _retval = hb_ot_layout_language_get_required_feature(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageIndex, cast(uint*)&featureIndex, cast(hb_tag_t*)&featureTag);
  return _retval;
}

/**
 * Fetches the index of a requested feature in the given face's GSUB or GPOS table,
 * underneath the specified script and language.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageIndex = The index of the requested language tag
 *   featureIndex = The index of the requested feature
 * Returns: `true` if the feature is found, `false` otherwise
 */
Bool otLayoutLanguageGetRequiredFeatureIndex(HBFace face, Tag tableTag, uint scriptIndex, uint languageIndex, out uint featureIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_language_get_required_feature_index(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageIndex, cast(uint*)&featureIndex);
  return _retval;
}

/**
 * Fetches alternates of a glyph from a given GSUB lookup index.
 * Params:
 *   face = a face.
 *   lookupIndex = index of the feature lookup to query.
 *   glyph = a glyph id.
 *   startOffset = starting offset.
 *   alternateGlyphs = A glyphs buffer.
 *     Alternate glyphs associated with the glyph id.
 * Returns: Total number of alternates found in the specific lookup index for the given glyph id.
 */
uint otLayoutLookupGetGlyphAlternates(HBFace face, uint lookupIndex, Codepoint glyph, uint startOffset, ref Codepoint[] alternateGlyphs)
{
  uint _retval;
  uint _alternateCount;
  _retval = hb_ot_layout_lookup_get_glyph_alternates(face ? cast(hb_face_t*)face.cPtr(false) : null, lookupIndex, glyph, startOffset, &_alternateCount, alternateGlyphs.ptr);
  return _retval;
}

/**
 * Fetches the optical bound of a glyph positioned at the margin of text.
 * The direction identifies which edge of the glyph to query.
 * Params:
 *   font = a font.
 *   lookupIndex = index of the feature lookup to query.
 *   direction = edge of the glyph to query.
 *   glyph = a glyph id.
 * Returns: Adjustment value. Negative values mean the glyph will stick out of the margin.
 */
Position otLayoutLookupGetOpticalBound(Font font, uint lookupIndex, Direction direction, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_layout_lookup_get_optical_bound(font ? cast(hb_font_t*)font.cPtr(false) : null, lookupIndex, direction, glyph);
  return _retval;
}

/**
 * Tests whether a specified lookup in the specified face would
 * trigger a substitution on the given glyph sequence.
 * Params:
 *   face = #hb_face_t to work upon
 *   lookupIndex = The index of the lookup to query
 *   glyphs = The sequence of glyphs to query for substitution
 *   zeroContext = #hb_bool_t indicating whether pre-/post-context are disallowed
 *     in substitutions
 * Returns: `true` if a substitution would be triggered, `false` otherwise
 */
Bool otLayoutLookupWouldSubstitute(HBFace face, uint lookupIndex, Codepoint[] glyphs, Bool zeroContext)
{
  Bool _retval;
  uint _glyphsLength;
  if (glyphs)
    _glyphsLength = cast(uint)glyphs.length;

  auto _glyphs = cast(const(hb_codepoint_t)*)glyphs.ptr;
  _retval = hb_ot_layout_lookup_would_substitute(face ? cast(hb_face_t*)face.cPtr(false) : null, lookupIndex, _glyphs, _glyphsLength, zeroContext);
  return _retval;
}

/**
 * Fetches the index of a given language tag in the specified face's GSUB table
 * or GPOS table, underneath the specified script tag.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageTag = The #hb_tag_t of the requested language
 *   languageIndex = The index of the requested language
 * Returns: `true` if the language tag is found, `false` otherwise
 */
Bool otLayoutScriptFindLanguage(HBFace face, Tag tableTag, uint scriptIndex, Tag languageTag, out uint languageIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_script_find_language(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, languageTag, cast(uint*)&languageIndex);
  return _retval;
}

/**
 * Fetches a list of language tags in the given face's GSUB or GPOS table, underneath
 * the specified script index. The list returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   startOffset = offset of the first language tag to retrieve
 *   languageTags = Array of language tags found in the table
 * Returns: Total number of language tags.
 */
uint otLayoutScriptGetLanguageTags(HBFace face, Tag tableTag, uint scriptIndex, uint startOffset, ref Tag[] languageTags)
{
  uint _retval;
  uint _languageCount;
  _retval = hb_ot_layout_script_get_language_tags(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, startOffset, &_languageCount, languageTags.ptr);
  return _retval;
}

/**
 * Fetches the index of the first language tag fom language_tags that is present
 * in the specified face's GSUB or GPOS table, underneath the specified script
 * index.
 * If none of the given language tags is found, `false` is returned and
 * language_index is set to the default language index.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageTags = The array of language tags
 *   languageIndex = The index of the requested language
 * Returns: `true` if one of the given language tags is found, `false` otherwise
 */
Bool otLayoutScriptSelectLanguage(HBFace face, Tag tableTag, uint scriptIndex, Tag[] languageTags, out uint languageIndex)
{
  Bool _retval;
  uint _languageCount;
  if (languageTags)
    _languageCount = cast(uint)languageTags.length;

  auto _languageTags = cast(const(hb_tag_t)*)languageTags.ptr;
  _retval = hb_ot_layout_script_select_language(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, _languageCount, _languageTags, cast(uint*)&languageIndex);
  return _retval;
}

/**
 * Fetches the index of the first language tag fom language_tags that is present
 * in the specified face's GSUB or GPOS table, underneath the specified script
 * index.
 * If none of the given language tags is found, `false` is returned and
 * language_index is set to #HB_OT_LAYOUT_DEFAULT_LANGUAGE_INDEX and
 * chosen_language is set to #HB_TAG_NONE.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptIndex = The index of the requested script tag
 *   languageTags = The array of language tags
 *   languageIndex = The index of the chosen language
 *   chosenLanguage = #hb_tag_t of the chosen language
 * Returns: `true` if one of the given language tags is found, `false` otherwise
 */
Bool otLayoutScriptSelectLanguage2(HBFace face, Tag tableTag, uint scriptIndex, Tag[] languageTags, out uint languageIndex, out Tag chosenLanguage)
{
  Bool _retval;
  uint _languageCount;
  if (languageTags)
    _languageCount = cast(uint)languageTags.length;

  auto _languageTags = cast(const(hb_tag_t)*)languageTags.ptr;
  _retval = hb_ot_layout_script_select_language2(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptIndex, _languageCount, _languageTags, cast(uint*)&languageIndex, cast(hb_tag_t*)&chosenLanguage);
  return _retval;
}

/**
 * Fetches a list of feature variations in the specified face's GSUB table
 * or GPOS table, at the specified variation coordinates.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   coords = The variation coordinates to query
 *   variationsIndex = The array of feature variations found for the query
 * Returns: `true` if feature variations were found, `false` otherwise.
 */
Bool otLayoutTableFindFeatureVariations(HBFace face, Tag tableTag, int[] coords, out uint variationsIndex)
{
  Bool _retval;
  uint _numCoords;
  if (coords)
    _numCoords = cast(uint)coords.length;

  auto _coords = cast(const(int)*)coords.ptr;
  _retval = hb_ot_layout_table_find_feature_variations(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, _coords, _numCoords, cast(uint*)&variationsIndex);
  return _retval;
}

/**
 * Fetches the index if a given script tag in the specified face's GSUB table
 * or GPOS table.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptTag = #hb_tag_t of the script tag requested
 *   scriptIndex = The index of the requested script tag
 * Returns: `true` if the script is found, `false` otherwise
 */
Bool otLayoutTableFindScript(HBFace face, Tag tableTag, Tag scriptTag, out uint scriptIndex)
{
  Bool _retval;
  _retval = hb_ot_layout_table_find_script(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, scriptTag, cast(uint*)&scriptIndex);
  return _retval;
}

/**
 * Fetches a list of all feature tags in the given face's GSUB or GPOS table.
 * Note that there might be duplicate feature tags, belonging to different
 * script/language-system pairs of the table.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   startOffset = offset of the first feature tag to retrieve
 *   featureTags = Array of feature tags found in the table
 * Returns: Total number of feature tags.
 */
uint otLayoutTableGetFeatureTags(HBFace face, Tag tableTag, uint startOffset, ref Tag[] featureTags)
{
  uint _retval;
  uint _featureCount;
  _retval = hb_ot_layout_table_get_feature_tags(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, startOffset, &_featureCount, featureTags.ptr);
  return _retval;
}

/**
 * Fetches the total number of lookups enumerated in the specified
 * face's GSUB table or GPOS table.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 * Returns: Total number of lookups.
 */
uint otLayoutTableGetLookupCount(HBFace face, Tag tableTag)
{
  uint _retval;
  _retval = hb_ot_layout_table_get_lookup_count(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag);
  return _retval;
}

/**
 * Fetches a list of all scripts enumerated in the specified face's GSUB table
 * or GPOS table. The list returned will begin at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   startOffset = offset of the first script tag to retrieve
 *   scriptTags = The array of #hb_tag_t script tags found for the query
 * Returns: Total number of script tags.
 */
uint otLayoutTableGetScriptTags(HBFace face, Tag tableTag, uint startOffset, ref Tag[] scriptTags)
{
  uint _retval;
  uint _scriptCount;
  _retval = hb_ot_layout_table_get_script_tags(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, startOffset, &_scriptCount, scriptTags.ptr);
  return _retval;
}

/**
 * Selects an OpenType script for table_tag from the script_tags array.
 * If the table does not have any of the requested scripts, then `DFLT`,
 * `dflt`, and `latn` tags are tried in that order. If the table still does not
 * have any of these scripts, script_index is set to
 * #HB_OT_LAYOUT_NO_SCRIPT_INDEX and chosen_script is set to #HB_TAG_NONE.
 * Params:
 *   face = #hb_face_t to work upon
 *   tableTag = #HB_OT_TAG_GSUB or #HB_OT_TAG_GPOS
 *   scriptTags = Array of #hb_tag_t script tags
 *   scriptIndex = The index of the requested script
 *   chosenScript = #hb_tag_t of the requested script
 * Returns: `true` if one of the requested scripts is selected, `false` if a fallback
 *   script is selected or if no scripts are selected.
 */
Bool otLayoutTableSelectScript(HBFace face, Tag tableTag, Tag[] scriptTags, out uint scriptIndex, out Tag chosenScript)
{
  Bool _retval;
  uint _scriptCount;
  if (scriptTags)
    _scriptCount = cast(uint)scriptTags.length;

  auto _scriptTags = cast(const(hb_tag_t)*)scriptTags.ptr;
  _retval = hb_ot_layout_table_select_script(face ? cast(hb_face_t*)face.cPtr(false) : null, tableTag, _scriptCount, _scriptTags, cast(uint*)&scriptIndex, cast(hb_tag_t*)&chosenScript);
  return _retval;
}

/**
 * Fetches the specified math constant. For most constants, the value returned
 * is an #hb_position_t.
 * However, if the requested constant is #HB_OT_MATH_CONSTANT_SCRIPT_PERCENT_SCALE_DOWN,
 * #HB_OT_MATH_CONSTANT_SCRIPT_SCRIPT_PERCENT_SCALE_DOWN or
 * #HB_OT_MATH_CONSTANT_RADICAL_DEGREE_BOTTOM_RAISE_PERCENT, then the return value is
 * an integer between 0 and 100 representing that percentage.
 * Params:
 *   font = #hb_font_t to work upon
 *   constant = #hb_ot_math_constant_t the constant to retrieve
 * Returns: the requested constant or zero
 */
Position otMathGetConstant(Font font, OtMathConstant constant)
{
  Position _retval;
  _retval = hb_ot_math_get_constant(font ? cast(hb_font_t*)font.cPtr(false) : null, constant);
  return _retval;
}

/**
 * Fetches the GlyphAssembly for the specified font, glyph index, and direction.
 * Returned are a list of #hb_ot_math_glyph_part_t glyph parts that can be
 * used to draw the glyph and an italics-correction value $(LPAREN)if one is defined
 * in the font$(RPAREN).
 * <note>The direction parameter is only used to select between horizontal
 * or vertical directions for the construction. Even though all #hb_direction_t
 * values are accepted, only the result of #HB_DIRECTION_IS_HORIZONTAL is
 * considered.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The index of the glyph to stretch
 *   direction = direction of the stretching $(LPAREN)horizontal or vertical$(RPAREN)
 *   startOffset = offset of the first glyph part to retrieve
 *   parts = the glyph parts returned
 *   italicsCorrection = italics correction of the glyph assembly
 * Returns: the total number of parts in the glyph assembly
 */
uint otMathGetGlyphAssembly(Font font, Codepoint glyph, Direction direction, uint startOffset, ref OtMathGlyphPart[] parts, out Position italicsCorrection)
{
  uint _retval;
  uint _partsCount;
  hb_ot_math_glyph_part_t[] _parts;
  _parts.length = _partsCount;
  _retval = hb_ot_math_get_glyph_assembly(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, startOffset, &_partsCount, _parts.ptr, cast(hb_position_t*)&italicsCorrection);
  parts.length = _partsCount;
  foreach (i; 0 .. _partsCount)
    parts[i] = new OtMathGlyphPart(cast(void*)&_parts[i], false);
  return _retval;
}

/**
 * Fetches an italics-correction value $(LPAREN)if one exists$(RPAREN) for the specified
 * glyph index.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph index from which to retrieve the value
 * Returns: the italics correction of the glyph or zero
 */
Position otMathGetGlyphItalicsCorrection(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_italics_correction(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * Fetches the math kerning $(LPAREN)cut-ins$(RPAREN) value for the specified font, glyph index, and
 * kern.
 * If the MathKern table is found, the function examines it to find a height
 * value that is greater or equal to correction_height. If such a height
 * value is found, corresponding kerning value from the table is returned. If
 * no such height value is found, the last kerning value is returned.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph index from which to retrieve the value
 *   kern = The #hb_ot_math_kern_t from which to retrieve the value
 *   correctionHeight = the correction height to use to determine the kerning.
 * Returns: requested kerning value or zero
 */
Position otMathGetGlyphKerning(Font font, Codepoint glyph, OtMathKern kern, Position correctionHeight)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_kerning(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, kern, correctionHeight);
  return _retval;
}

/**
 * Fetches the raw MathKern $(LPAREN)cut-in$(RPAREN) data for the specified font, glyph index,
 * and kern. The corresponding list of kern values and correction heights is
 * returned as a list of #hb_ot_math_kern_entry_t structs.
 * See also #hb_ot_math_get_glyph_kerning, which handles selecting the
 * appropriate kern value for a given correction height.
 * <note>For a glyph with n defined kern values $(LPAREN)where n > 0$(RPAREN), there are only
 * n−1 defined correction heights, as each correction height defines a boundary
 * past which the next kern value should be selected. Therefore, only the
 * #hb_ot_math_kern_entry_t.kern_value of the uppermost #hb_ot_math_kern_entry_t
 * actually comes from the font; its corresponding
 * #hb_ot_math_kern_entry_t.max_correction_height is always set to
 * <code>INT32_MAX</code>.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph index from which to retrieve the kernings
 *   kern = The #hb_ot_math_kern_t from which to retrieve the kernings
 *   startOffset = offset of the first kern entry to retrieve
 *   kernEntries = array of kern entries returned
 * Returns: the total number of kern values available or zero
 */
uint otMathGetGlyphKernings(Font font, Codepoint glyph, OtMathKern kern, uint startOffset, ref OtMathKernEntry[] kernEntries)
{
  uint _retval;
  uint _entriesCount;
  _retval = hb_ot_math_get_glyph_kernings(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, kern, startOffset, &_entriesCount, kernEntries.ptr);
  return _retval;
}

/**
 * Fetches a top-accent-attachment value $(LPAREN)if one exists$(RPAREN) for the specified
 * glyph index.
 * For any glyph that does not have a top-accent-attachment value - that is,
 * a glyph not covered by the `MathTopAccentAttachment` table $(LPAREN)or, when
 * font has no `MathTopAccentAttachment` table or no `MATH` table, any
 * glyph$(RPAREN) - the function synthesizes a value, returning the position at
 * one-half the glyph's advance width.
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The glyph index from which to retrieve the value
 * Returns: the top accent attachment of the glyph or 0.5 * the advance
 *   width of glyph
 */
Position otMathGetGlyphTopAccentAttachment(Font font, Codepoint glyph)
{
  Position _retval;
  _retval = hb_ot_math_get_glyph_top_accent_attachment(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * Fetches the MathGlyphConstruction for the specified font, glyph index, and
 * direction. The corresponding list of size variants is returned as a list of
 * #hb_ot_math_glyph_variant_t structs.
 * <note>The direction parameter is only used to select between horizontal
 * or vertical directions for the construction. Even though all #hb_direction_t
 * values are accepted, only the result of #HB_DIRECTION_IS_HORIZONTAL is
 * considered.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   glyph = The index of the glyph to stretch
 *   direction = The direction of the stretching $(LPAREN)horizontal or vertical$(RPAREN)
 *   startOffset = offset of the first variant to retrieve
 *   variants = array of variants returned
 * Returns: the total number of size variants available or zero
 */
uint otMathGetGlyphVariants(Font font, Codepoint glyph, Direction direction, uint startOffset, ref OtMathGlyphVariant[] variants)
{
  uint _retval;
  uint _variantsCount;
  hb_ot_math_glyph_variant_t[] _variants;
  _variants.length = _variantsCount;
  _retval = hb_ot_math_get_glyph_variants(font ? cast(hb_font_t*)font.cPtr(false) : null, glyph, direction, startOffset, &_variantsCount, _variants.ptr);
  variants.length = _variantsCount;
  foreach (i; 0 .. _variantsCount)
    variants[i] = new OtMathGlyphVariant(cast(void*)&_variants[i], false);
  return _retval;
}

/**
 * Fetches the MathVariants table for the specified font and returns the
 * minimum overlap of connecting glyphs that are required to draw a glyph
 * assembly in the specified direction.
 * <note>The direction parameter is only used to select between horizontal
 * or vertical directions for the construction. Even though all #hb_direction_t
 * values are accepted, only the result of #HB_DIRECTION_IS_HORIZONTAL is
 * considered.</note>
 * Params:
 *   font = #hb_font_t to work upon
 *   direction = direction of the stretching $(LPAREN)horizontal or vertical$(RPAREN)
 * Returns: requested minimum connector overlap or zero
 */
Position otMathGetMinConnectorOverlap(Font font, Direction direction)
{
  Position _retval;
  _retval = hb_ot_math_get_min_connector_overlap(font ? cast(hb_font_t*)font.cPtr(false) : null, direction);
  return _retval;
}

/**
 * Tests whether a face has a `MATH` table.
 * Params:
 *   face = #hb_face_t to test
 * Returns: `true` if the table is found, `false` otherwise
 */
Bool otMathHasData(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_math_has_data(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether the given glyph index is an extended shape in the face.
 * Params:
 *   face = #hb_face_t to work upon
 *   glyph = The glyph index to test
 * Returns: `true` if the glyph is an extended shape, `false` otherwise
 */
Bool otMathIsGlyphExtendedShape(HBFace face, Codepoint glyph)
{
  Bool _retval;
  _retval = hb_ot_math_is_glyph_extended_shape(face ? cast(hb_face_t*)face.cPtr(false) : null, glyph);
  return _retval;
}

/**
 * It fetches metadata entry of a given tag from a font.
 * Params:
 *   face = a #hb_face_t object.
 *   metaTag = tag of metadata you like to have.
 * Returns: A blob containing the blob.
 */
Blob otMetaReferenceEntry(HBFace face, OtMetaTag metaTag)
{
  hb_blob_t* _cretval;
  _cretval = hb_ot_meta_reference_entry(face ? cast(hb_face_t*)face.cPtr(false) : null, metaTag);
  auto _retval = _cretval ? new Blob(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches metrics value corresponding to metrics_tag from font.
 * Params:
 *   font = an #hb_font_t object.
 *   metricsTag = tag of metrics value you like to fetch.
 *   position = result of metrics value from the font.
 * Returns: Whether found the requested metrics in the font.
 */
Bool otMetricsGetPosition(Font font, OtMetricsTag metricsTag, out Position position)
{
  Bool _retval;
  _retval = hb_ot_metrics_get_position(font ? cast(hb_font_t*)font.cPtr(false) : null, metricsTag, cast(hb_position_t*)&position);
  return _retval;
}

/**
 * Fetches metrics value corresponding to metrics_tag from font,
 * and synthesizes a value if it the value is missing in the font.
 * Params:
 *   font = an #hb_font_t object.
 *   metricsTag = tag of metrics value you like to fetch.
 *   position = result of metrics value from the font.
 */
void otMetricsGetPositionWithFallback(Font font, OtMetricsTag metricsTag, out Position position)
{
  hb_ot_metrics_get_position_with_fallback(font ? cast(hb_font_t*)font.cPtr(false) : null, metricsTag, cast(hb_position_t*)&position);
}

/**
 * Fetches metrics value corresponding to metrics_tag from font with the
 * current font variation settings applied.
 * Params:
 *   font = an #hb_font_t object.
 *   metricsTag = tag of metrics value you like to fetch.
 * Returns: The requested metric value.
 */
float otMetricsGetVariation(Font font, OtMetricsTag metricsTag)
{
  float _retval;
  _retval = hb_ot_metrics_get_variation(font ? cast(hb_font_t*)font.cPtr(false) : null, metricsTag);
  return _retval;
}

/**
 * Fetches horizontal metrics value corresponding to metrics_tag from font
 * with the current font variation settings applied.
 * Params:
 *   font = an #hb_font_t object.
 *   metricsTag = tag of metrics value you like to fetch.
 * Returns: The requested metric value.
 */
Position otMetricsGetXVariation(Font font, OtMetricsTag metricsTag)
{
  Position _retval;
  _retval = hb_ot_metrics_get_x_variation(font ? cast(hb_font_t*)font.cPtr(false) : null, metricsTag);
  return _retval;
}

/**
 * Fetches vertical metrics value corresponding to metrics_tag from font with
 * the current font variation settings applied.
 * Params:
 *   font = an #hb_font_t object.
 *   metricsTag = tag of metrics value you like to fetch.
 * Returns: The requested metric value.
 */
Position otMetricsGetYVariation(Font font, OtMetricsTag metricsTag)
{
  Position _retval;
  _retval = hb_ot_metrics_get_y_variation(font ? cast(hb_font_t*)font.cPtr(false) : null, metricsTag);
  return _retval;
}

/**
 * Enumerates all available name IDs and language combinations. Returned
 * array is owned by the face and should not be modified.  It can be
 * used as long as face is alive.
 * Params:
 *   face = font face.
 * Returns: Array of available name entries.
 */
OtNameEntry[] otNameListNames(HBFace face)
{
  const(hb_ot_name_entry_t)* _cretval;
  uint _cretlength;
  _cretval = hb_ot_name_list_names(face ? cast(hb_face_t*)face.cPtr(false) : null, &_cretlength);
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
 * Params:
 *   language = an #hb_language_t to convert.
 * Returns:

 * Deprecated: use [HarfBuzz.Global.otTagsFromScriptAndLanguage] instead
 */
Tag otTagFromLanguage(Language language)
{
  Tag _retval;
  _retval = hb_ot_tag_from_language(language);
  return _retval;
}

/**
 * Converts a language tag to an #hb_language_t.
 * Params:
 *   tag = an language tag
 * Returns: The #hb_language_t corresponding to tag.
 */
Language otTagToLanguage(Tag tag)
{
  auto _retval = hb_ot_tag_to_language(tag);
  return _retval;
}

/**
 * Converts a script tag to an #hb_script_t.
 * Params:
 *   tag = a script tag
 * Returns: The #hb_script_t corresponding to tag.
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
 * Params:
 *   script = an #hb_script_t to convert.
 *   scriptTag1 = output #hb_tag_t.
 *   scriptTag2 = output #hb_tag_t.

 * Deprecated: use [HarfBuzz.Global.otTagsFromScriptAndLanguage] instead
 */
void otTagsFromScript(Script script, out Tag scriptTag1, out Tag scriptTag2)
{
  hb_ot_tags_from_script(script, cast(hb_tag_t*)&scriptTag1, cast(hb_tag_t*)&scriptTag2);
}

/**
 * Converts an #hb_script_t and an #hb_language_t to script and language tags.
 * Params:
 *   script = an #hb_script_t to convert.
 *   language = an #hb_language_t to convert.
 *   scriptCount = maximum number of script tags to retrieve $(LPAREN)IN$(RPAREN)
 *     and actual number of script tags retrieved $(LPAREN)OUT$(RPAREN)
 *   scriptTags = array of size at least script_count to store the
 *     script tag results
 *   languageCount = maximum number of language tags to retrieve
 *     $(LPAREN)IN$(RPAREN) and actual number of language tags retrieved $(LPAREN)OUT$(RPAREN)
 *   languageTags = array of size at least language_count to store
 *     the language tag results
 */
void otTagsFromScriptAndLanguage(Script script, Language language, ref uint scriptCount, out Tag scriptTags, ref uint languageCount, out Tag languageTags)
{
  hb_ot_tags_from_script_and_language(script, language, cast(uint*)&scriptCount, cast(hb_tag_t*)&scriptTags, cast(uint*)&languageCount, cast(hb_tag_t*)&languageTags);
}

/**
 * Converts a script tag and a language tag to an #hb_script_t and an
 * #hb_language_t.
 * Params:
 *   scriptTag = a script tag
 *   languageTag = a language tag
 *   script = the #hb_script_t corresponding to script_tag.
 *   language = the #hb_language_t corresponding to script_tag and
 *     language_tag.
 */
void otTagsToScriptAndLanguage(Tag scriptTag, Tag languageTag, out Script script, out Language language)
{
  hb_ot_tags_to_script_and_language(scriptTag, languageTag, &script, &language);
}

/**
 * Fetches the variation-axis information corresponding to the specified axis tag
 * in the specified face.
 * Params:
 *   face = #hb_face_t to work upon
 *   axisTag = The #hb_tag_t of the variation axis to query
 *   axisInfo = The #hb_ot_var_axis_info_t of the axis tag queried
 * Returns: `true` if data found, `false` otherwise
 */
Bool otVarFindAxisInfo(HBFace face, Tag axisTag, out OtVarAxisInfo axisInfo)
{
  Bool _retval;
  hb_ot_var_axis_info_t _axisInfo;
  _retval = hb_ot_var_find_axis_info(face ? cast(hb_face_t*)face.cPtr(false) : null, axisTag, &_axisInfo);
  axisInfo = new OtVarAxisInfo(cast(void*)&_axisInfo, false);
  return _retval;
}

/**
 * Fetches a list of all variation axes in the specified face. The list returned will begin
 * at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   startOffset = offset of the first lookup to retrieve
 *   axesArray = The array of variation axes found
 * Returns:

 * Deprecated: use [HarfBuzz.Global.otVarGetAxisInfos] instead
 */
uint otVarGetAxes(HBFace face, uint startOffset, ref OtVarAxis[] axesArray)
{
  uint _retval;
  uint _axesCount;
  _retval = hb_ot_var_get_axes(face ? cast(hb_face_t*)face.cPtr(false) : null, startOffset, &_axesCount, axesArray.ptr);
  return _retval;
}

/**
 * Fetches the number of OpenType variation axes included in the face.
 * Params:
 *   face = The #hb_face_t to work on
 * Returns: the number of variation axes defined
 */
uint otVarGetAxisCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_var_get_axis_count(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches a list of all variation axes in the specified face. The list returned will begin
 * at the offset provided.
 * Params:
 *   face = #hb_face_t to work upon
 *   startOffset = offset of the first lookup to retrieve
 *   axesArray = The array of variation axes found
 * Returns: the number of variation axes in the face
 */
uint otVarGetAxisInfos(HBFace face, uint startOffset, ref OtVarAxisInfo[] axesArray)
{
  uint _retval;
  uint _axesCount;
  hb_ot_var_axis_info_t[] _axesArray;
  _axesArray.length = _axesCount;
  _retval = hb_ot_var_get_axis_infos(face ? cast(hb_face_t*)face.cPtr(false) : null, startOffset, &_axesCount, _axesArray.ptr);
  axesArray.length = _axesCount;
  foreach (i; 0 .. _axesCount)
    axesArray[i] = new OtVarAxisInfo(cast(void*)&_axesArray[i], false);
  return _retval;
}

/**
 * Fetches the number of named instances included in the face.
 * Params:
 *   face = The #hb_face_t to work on
 * Returns: the number of named instances defined
 */
uint otVarGetNamedInstanceCount(HBFace face)
{
  uint _retval;
  _retval = hb_ot_var_get_named_instance_count(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether a face includes any OpenType variation data in the `fvar` table.
 * Params:
 *   face = The #hb_face_t to work on
 * Returns: `true` if data found, `false` otherwise
 */
Bool otVarHasData(HBFace face)
{
  Bool _retval;
  _retval = hb_ot_var_has_data(face ? cast(hb_face_t*)face.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the design-space coordinates corresponding to the given
 * named instance in the face.
 * Params:
 *   face = The #hb_face_t to work on
 *   instanceIndex = The index of the named instance to query
 *   coords = The array of coordinates found for the query
 * Returns: the number of variation axes in the face
 */
uint otVarNamedInstanceGetDesignCoords(HBFace face, uint instanceIndex, ref float[] coords)
{
  uint _retval;
  uint _coordsLength;
  _retval = hb_ot_var_named_instance_get_design_coords(face ? cast(hb_face_t*)face.cPtr(false) : null, instanceIndex, &_coordsLength, coords.ptr);
  return _retval;
}

/**
 * Fetches the `name` table Name ID that provides display names for
 * the "PostScript name" defined for the given named instance in the face.
 * Params:
 *   face = The #hb_face_t to work on
 *   instanceIndex = The index of the named instance to query
 * Returns: the Name ID found for the PostScript name
 */
OtNameId otVarNamedInstanceGetPostscriptNameId(HBFace face, uint instanceIndex)
{
  OtNameId _retval;
  _retval = hb_ot_var_named_instance_get_postscript_name_id(face ? cast(hb_face_t*)face.cPtr(false) : null, instanceIndex);
  return _retval;
}

/**
 * Fetches the `name` table Name ID that provides display names for
 * the "Subfamily name" defined for the given named instance in the face.
 * Params:
 *   face = The #hb_face_t to work on
 *   instanceIndex = The index of the named instance to query
 * Returns: the Name ID found for the Subfamily name
 */
OtNameId otVarNamedInstanceGetSubfamilyNameId(HBFace face, uint instanceIndex)
{
  OtNameId _retval;
  _retval = hb_ot_var_named_instance_get_subfamily_name_id(face ? cast(hb_face_t*)face.cPtr(false) : null, instanceIndex);
  return _retval;
}

/**
 * Normalizes the given design-space coordinates. The minimum and maximum
 * values for the axis are mapped to the interval [-1,1], with the default
 * axis value mapped to 0.
 * The normalized values have 14 bits of fixed-point sub-integer precision as per
 * OpenType specification.
 * Any additional scaling defined in the face's `avar` table is also
 * applied, as described at https://docs.microsoft.com/en-us/typography/opentype/spec/avar
 * Params:
 *   face = The #hb_face_t to work on
 *   designCoords = The design-space coordinates to normalize
 *   normalizedCoords = The normalized coordinates
 */
void otVarNormalizeCoords(HBFace face, float[] designCoords, out int normalizedCoords)
{
  uint _coordsLength;
  if (designCoords)
    _coordsLength = cast(uint)designCoords.length;

  auto _designCoords = cast(const(float)*)designCoords.ptr;
  hb_ot_var_normalize_coords(face ? cast(hb_face_t*)face.cPtr(false) : null, _coordsLength, _designCoords, cast(int*)&normalizedCoords);
}

/**
 * Perform a "color" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   isForeground = whether the color is the foreground
 *   color = The color to use
 */
void paintColor(PaintFuncs funcs, void* paintData, Bool isForeground, Color color)
{
  hb_paint_color(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, isForeground, color);
}

/**
 * Perform a "color-glyph" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   glyph = the glyph ID
 *   font = the font
 * Returns:
 */
Bool paintColorGlyph(PaintFuncs funcs, void* paintData, Codepoint glyph, Font font)
{
  Bool _retval;
  _retval = hb_paint_color_glyph(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, glyph, font ? cast(hb_font_t*)font.cPtr(false) : null);
  return _retval;
}

/**
 * Gets the custom palette color for color_index.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   colorIndex = color index
 *   color = fetched color
 * Returns: `true` if found, `false` otherwise
 */
Bool paintCustomPaletteColor(PaintFuncs funcs, void* paintData, uint colorIndex, out Color color)
{
  Bool _retval;
  _retval = hb_paint_custom_palette_color(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, colorIndex, cast(hb_color_t*)&color);
  return _retval;
}

/**
 * Creates a new #hb_paint_funcs_t structure of paint functions.
 * The initial reference count of 1 should be released with [HarfBuzz.Global.paintFuncsDestroy]
 * when you are done using the #hb_paint_funcs_t. This function never returns
 * `NULL`. If memory cannot be allocated, a special singleton #hb_paint_funcs_t
 * object will be returned.
 * Returns: the paint-functions structure
 */
PaintFuncs paintFuncsCreate()
{
  hb_paint_funcs_t* _cretval;
  _cretval = hb_paint_funcs_create();
  auto _retval = _cretval ? new PaintFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the singleton empty paint-functions structure.
 * Returns: The empty paint-functions structure
 */
PaintFuncs paintFuncsGetEmpty()
{
  hb_paint_funcs_t* _cretval;
  _cretval = hb_paint_funcs_get_empty();
  auto _retval = _cretval ? new PaintFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Tests whether a paint-functions structure is immutable.
 * Params:
 *   funcs = The paint-functions structure
 * Returns: `true` if funcs is immutable, `false` otherwise
 */
Bool paintFuncsIsImmutable(PaintFuncs funcs)
{
  Bool _retval;
  _retval = hb_paint_funcs_is_immutable(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null);
  return _retval;
}

/**
 * Makes a paint-functions structure immutable.
 * After this call, all attempts to set one of the callbacks
 * on funcs will fail.
 * Params:
 *   funcs = The paint-functions structure
 */
void paintFuncsMakeImmutable(PaintFuncs funcs)
{
  hb_paint_funcs_make_immutable(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null);
}

/**
 * Sets the paint-color callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The paint-color callback
 */
void paintFuncsSetColorFunc(PaintFuncs funcs, PaintColorFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_bool_t isForeground, hb_color_t color, void* userData)
  {
    auto _dlg = cast(PaintColorFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, isForeground, color);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_color_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the color-glyph callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The color-glyph callback
 */
void paintFuncsSetColorGlyphFunc(PaintFuncs funcs, PaintColorGlyphFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_codepoint_t glyph, hb_font_t* font, void* userData)
  {
    auto _dlg = cast(PaintColorGlyphFunc*)userData;

    hb_bool_t _retval = (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, glyph, font ? new Font(cast(void*)font, false) : null);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_color_glyph_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the custom-palette-color callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The custom-palette-color callback
 */
void paintFuncsSetCustomPaletteColorFunc(PaintFuncs funcs, PaintCustomPaletteColorFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_paint_funcs_t* funcs, void* paintData, uint colorIndex, hb_color_t* color, void* userData)
  {
    auto _dlg = cast(PaintCustomPaletteColorFunc*)userData;

    hb_bool_t _retval = (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, colorIndex, *color);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_custom_palette_color_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the paint-image callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The paint-image callback
 */
void paintFuncsSetImageFunc(PaintFuncs funcs, PaintImageFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_blob_t* image, uint width, uint height, hb_tag_t format, float slant, hb_glyph_extents_t* extents, void* userData)
  {
    auto _dlg = cast(PaintImageFunc*)userData;

    hb_bool_t _retval = (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, image ? new Blob(cast(void*)image, false) : null, width, height, format, slant, *extents);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_image_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the linear-gradient callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The linear-gradient callback
 */
void paintFuncsSetLinearGradientFunc(PaintFuncs funcs, PaintLinearGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float x1, float y1, float x2, float y2, void* userData)
  {
    auto _dlg = cast(PaintLinearGradientFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, colorLine ? new ColorLine(cast(void*)colorLine, false) : null, x0, y0, x1, y1, x2, y2);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_linear_gradient_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the pop-clip callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The pop-clip callback
 */
void paintFuncsSetPopClipFunc(PaintFuncs funcs, PaintPopClipFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    auto _dlg = cast(PaintPopClipFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_pop_clip_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the pop-group callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The pop-group callback
 */
void paintFuncsSetPopGroupFunc(PaintFuncs funcs, PaintPopGroupFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_paint_composite_mode_t mode, void* userData)
  {
    auto _dlg = cast(PaintPopGroupFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, mode);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_pop_group_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the pop-transform callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The pop-transform callback
 */
void paintFuncsSetPopTransformFunc(PaintFuncs funcs, PaintPopTransformFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    auto _dlg = cast(PaintPopTransformFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_pop_transform_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the push-clip-glyph callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The push-clip-glyph callback
 */
void paintFuncsSetPushClipGlyphFunc(PaintFuncs funcs, PaintPushClipGlyphFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_codepoint_t glyph, hb_font_t* font, void* userData)
  {
    auto _dlg = cast(PaintPushClipGlyphFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, glyph, font ? new Font(cast(void*)font, false) : null);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_push_clip_glyph_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the push-clip-rect callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The push-clip-rectangle callback
 */
void paintFuncsSetPushClipRectangleFunc(PaintFuncs funcs, PaintPushClipRectangleFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, float xmin, float ymin, float xmax, float ymax, void* userData)
  {
    auto _dlg = cast(PaintPushClipRectangleFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, xmin, ymin, xmax, ymax);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_push_clip_rectangle_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the push-group callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The push-group callback
 */
void paintFuncsSetPushGroupFunc(PaintFuncs funcs, PaintPushGroupFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, void* userData)
  {
    auto _dlg = cast(PaintPushGroupFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_push_group_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the push-transform callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The push-transform callback
 */
void paintFuncsSetPushTransformFunc(PaintFuncs funcs, PaintPushTransformFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, float xx, float yx, float xy, float yy, float dx, float dy, void* userData)
  {
    auto _dlg = cast(PaintPushTransformFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, xx, yx, xy, yy, dx, dy);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_push_transform_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the radial-gradient callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The radial-gradient callback
 */
void paintFuncsSetRadialGradientFunc(PaintFuncs funcs, PaintRadialGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float r0, float x1, float y1, float r1, void* userData)
  {
    auto _dlg = cast(PaintRadialGradientFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, colorLine ? new ColorLine(cast(void*)colorLine, false) : null, x0, y0, r0, x1, y1, r1);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_radial_gradient_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the sweep-gradient callback on the paint functions struct.
 * Params:
 *   funcs = A paint functions struct
 *   func = The sweep-gradient callback
 */
void paintFuncsSetSweepGradientFunc(PaintFuncs funcs, PaintSweepGradientFunc func)
{
  extern(C) void _funcCallback(hb_paint_funcs_t* funcs, void* paintData, hb_color_line_t* colorLine, float x0, float y0, float startAngle, float endAngle, void* userData)
  {
    auto _dlg = cast(PaintSweepGradientFunc*)userData;

    (*_dlg)(funcs ? new PaintFuncs(cast(void*)funcs, false) : null, paintData, colorLine ? new ColorLine(cast(void*)colorLine, false) : null, x0, y0, startAngle, endAngle);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_paint_funcs_set_sweep_gradient_func(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Perform a "image" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   image = image data
 *   width = width of the raster image in pixels, or 0
 *   height = height of the raster image in pixels, or 0
 *   format = the image format as a tag
 *   slant = the synthetic slant ratio to be applied to the image during rendering
 *   extents = the extents of the glyph
 */
void paintImage(PaintFuncs funcs, void* paintData, Blob image, uint width, uint height, Tag format, float slant, GlyphExtents extents)
{
  hb_paint_image(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, image ? cast(hb_blob_t*)image.cPtr(false) : null, width, height, format, slant, &extents);
}

/**
 * Perform a "linear-gradient" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   colorLine = Color information for the gradient
 *   x0 = X coordinate of the first point
 *   y0 = Y coordinate of the first point
 *   x1 = X coordinate of the second point
 *   y1 = Y coordinate of the second point
 *   x2 = X coordinate of the third point
 *   y2 = Y coordinate of the third point
 */
void paintLinearGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float x1, float y1, float x2, float y2)
{
  hb_paint_linear_gradient(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, colorLine ? cast(hb_color_line_t*)colorLine.cPtr(false) : null, x0, y0, x1, y1, x2, y2);
}

/**
 * Perform a "pop-clip" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 */
void paintPopClip(PaintFuncs funcs, void* paintData)
{
  hb_paint_pop_clip(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData);
}

/**
 * Perform a "pop-group" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   mode = the compositing mode to use
 */
void paintPopGroup(PaintFuncs funcs, void* paintData, PaintCompositeMode mode)
{
  hb_paint_pop_group(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, mode);
}

/**
 * Perform a "pop-transform" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 */
void paintPopTransform(PaintFuncs funcs, void* paintData)
{
  hb_paint_pop_transform(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData);
}

/**
 * Perform a "push-clip-glyph" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   glyph = the glyph ID
 *   font = the font
 */
void paintPushClipGlyph(PaintFuncs funcs, void* paintData, Codepoint glyph, Font font)
{
  hb_paint_push_clip_glyph(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, glyph, font ? cast(hb_font_t*)font.cPtr(false) : null);
}

/**
 * Perform a "push-clip-rect" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   xmin = min X for the rectangle
 *   ymin = min Y for the rectangle
 *   xmax = max X for the rectangle
 *   ymax = max Y for the rectangle
 */
void paintPushClipRectangle(PaintFuncs funcs, void* paintData, float xmin, float ymin, float xmax, float ymax)
{
  hb_paint_push_clip_rectangle(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, xmin, ymin, xmax, ymax);
}

/**
 * Perform a "push-group" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 */
void paintPushGroup(PaintFuncs funcs, void* paintData)
{
  hb_paint_push_group(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData);
}

/**
 * Perform a "push-transform" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   xx = xx component of the transform matrix
 *   yx = yx component of the transform matrix
 *   xy = xy component of the transform matrix
 *   yy = yy component of the transform matrix
 *   dx = dx component of the transform matrix
 *   dy = dy component of the transform matrix
 */
void paintPushTransform(PaintFuncs funcs, void* paintData, float xx, float yx, float xy, float yy, float dx, float dy)
{
  hb_paint_push_transform(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, xx, yx, xy, yy, dx, dy);
}

/**
 * Perform a "radial-gradient" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   colorLine = Color information for the gradient
 *   x0 = X coordinate of the first circle's center
 *   y0 = Y coordinate of the first circle's center
 *   r0 = radius of the first circle
 *   x1 = X coordinate of the second circle's center
 *   y1 = Y coordinate of the second circle's center
 *   r1 = radius of the second circle
 */
void paintRadialGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float r0, float x1, float y1, float r1)
{
  hb_paint_radial_gradient(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, colorLine ? cast(hb_color_line_t*)colorLine.cPtr(false) : null, x0, y0, r0, x1, y1, r1);
}

/**
 * Perform a "sweep-gradient" paint operation.
 * Params:
 *   funcs = paint functions
 *   paintData = associated data passed by the caller
 *   colorLine = Color information for the gradient
 *   x0 = X coordinate of the circle's center
 *   y0 = Y coordinate of the circle's center
 *   startAngle = the start angle
 *   endAngle = the end angle
 */
void paintSweepGradient(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float startAngle, float endAngle)
{
  hb_paint_sweep_gradient(funcs ? cast(hb_paint_funcs_t*)funcs.cPtr(false) : null, paintData, colorLine ? cast(hb_color_line_t*)colorLine.cPtr(false) : null, x0, y0, startAngle, endAngle);
}

/**
 * Converts an ISO 15924 script tag to a corresponding #hb_script_t.
 * Params:
 *   tag = an #hb_tag_t representing an ISO 15924 tag.
 * Returns: An #hb_script_t corresponding to the ISO 15924 tag.
 */
Script scriptFromIso15924Tag(Tag tag)
{
  hb_script_t _cretval;
  _cretval = hb_script_from_iso15924_tag(tag);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Converts a string str representing an ISO 15924 script tag to a
 * corresponding #hb_script_t. Shorthand for [HarfBuzz.Global.tagFromString] then
 * [HarfBuzz.Global.scriptFromIso15924Tag].
 * Params:
 *   str = a string representing an
 *     ISO 15924 tag.
 * Returns: An #hb_script_t corresponding to the ISO 15924 tag.
 */
Script scriptFromString(ubyte[] str)
{
  hb_script_t _cretval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  _cretval = hb_script_from_string(_str, _len);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Fetches the #hb_direction_t of a script when it is
 * set horizontally. All right-to-left scripts will return
 * #HB_DIRECTION_RTL. All left-to-right scripts will return
 * #HB_DIRECTION_LTR.  Scripts that can be written either
 * horizontally or vertically will return #HB_DIRECTION_INVALID.
 * Unknown scripts will return #HB_DIRECTION_LTR.
 * Params:
 *   script = The #hb_script_t to query
 * Returns: The horizontal #hb_direction_t of script
 */
Direction scriptGetHorizontalDirection(Script script)
{
  hb_direction_t _cretval;
  _cretval = hb_script_get_horizontal_direction(script);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * Converts an #hb_script_t to a corresponding ISO 15924 script tag.
 * Params:
 *   script = an #hb_script_t to convert.
 * Returns: An #hb_tag_t representing an ISO 15924 script tag.
 */
Tag scriptToIso15924Tag(Script script)
{
  Tag _retval;
  _retval = hb_script_to_iso15924_tag(script);
  return _retval;
}

/**
 * Checks the equality of two #hb_segment_properties_t's.
 * Params:
 *   a = first #hb_segment_properties_t to compare.
 *   b = second #hb_segment_properties_t to compare.
 * Returns: `true` if all properties of a equal those of b, `false` otherwise.
 */
Bool segmentPropertiesEqual(SegmentProperties a, SegmentProperties b)
{
  Bool _retval;
  _retval = hb_segment_properties_equal(a ? cast(hb_segment_properties_t*)a.cPtr(false) : null, b ? cast(hb_segment_properties_t*)b.cPtr(false) : null);
  return _retval;
}

/**
 * Creates a hash representing p.
 * Params:
 *   p = #hb_segment_properties_t to hash.
 * Returns: A hash of p.
 */
uint segmentPropertiesHash(SegmentProperties p)
{
  uint _retval;
  _retval = hb_segment_properties_hash(p ? cast(hb_segment_properties_t*)p.cPtr(false) : null);
  return _retval;
}

/**
 * Fills in missing fields of p from src in a considered manner.
 * First, if p does not have direction set, direction is copied from src.
 * Next, if p and src have the same direction $(LPAREN)which can be unset$(RPAREN), if p
 * does not have script set, script is copied from src.
 * Finally, if p and src have the same direction and script $(LPAREN)which either
 * can be unset$(RPAREN), if p does not have language set, language is copied from
 * src.
 * Params:
 *   p = #hb_segment_properties_t to fill in.
 *   src = #hb_segment_properties_t to fill in from.
 */
void segmentPropertiesOverlay(SegmentProperties p, SegmentProperties src)
{
  hb_segment_properties_overlay(p ? cast(hb_segment_properties_t*)p.cPtr(false) : null, src ? cast(hb_segment_properties_t*)src.cPtr(false) : null);
}

/**
 * Adds codepoint to set.
 * Params:
 *   set = A set
 *   codepoint = The element to add to set
 */
void setAdd(Set set, Codepoint codepoint)
{
  hb_set_add(set ? cast(hb_set_t*)set.cPtr(false) : null, codepoint);
}

/**
 * Adds all of the elements from first to last
 * $(LPAREN)inclusive$(RPAREN) to set.
 * Params:
 *   set = A set
 *   first = The first element to add to set
 *   last = The final element to add to set
 */
void setAddRange(Set set, Codepoint first, Codepoint last)
{
  hb_set_add_range(set ? cast(hb_set_t*)set.cPtr(false) : null, first, last);
}

/**
 * Adds num_codepoints codepoints to a set at once.
 * The codepoints array must be in increasing order,
 * with size at least num_codepoints.
 * Params:
 *   set = A set
 *   sortedCodepoints = Array of codepoints to add
 */
void setAddSortedArray(Set set, Codepoint[] sortedCodepoints)
{
  uint _numCodepoints;
  if (sortedCodepoints)
    _numCodepoints = cast(uint)sortedCodepoints.length;

  auto _sortedCodepoints = cast(const(hb_codepoint_t)*)sortedCodepoints.ptr;
  hb_set_add_sorted_array(set ? cast(hb_set_t*)set.cPtr(false) : null, _sortedCodepoints, _numCodepoints);
}

/**
 * Tests whether memory allocation for a set was successful.
 * Params:
 *   set = A set
 * Returns: `true` if allocation succeeded, `false` otherwise
 */
Bool setAllocationSuccessful(Set set)
{
  Bool _retval;
  _retval = hb_set_allocation_successful(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Clears out the contents of a set.
 * Params:
 *   set = A set
 */
void setClear(Set set)
{
  hb_set_clear(set ? cast(hb_set_t*)set.cPtr(false) : null);
}

/**
 * Allocate a copy of set.
 * Params:
 *   set = A set
 * Returns: Newly-allocated set.
 */
Set setCopy(Set set)
{
  hb_set_t* _cretval;
  _cretval = hb_set_copy(set ? cast(hb_set_t*)set.cPtr(false) : null);
  auto _retval = _cretval ? new Set(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new, initially empty set.
 * Returns: The new #hb_set_t
 */
Set setCreate()
{
  hb_set_t* _cretval;
  _cretval = hb_set_create();
  auto _retval = _cretval ? new Set(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Removes codepoint from set.
 * Params:
 *   set = A set
 *   codepoint = Removes codepoint from set
 */
void setDel(Set set, Codepoint codepoint)
{
  hb_set_del(set ? cast(hb_set_t*)set.cPtr(false) : null, codepoint);
}

/**
 * Removes all of the elements from first to last
 * $(LPAREN)inclusive$(RPAREN) from set.
 * If last is #HB_SET_VALUE_INVALID, then all values
 * greater than or equal to first are removed.
 * Params:
 *   set = A set
 *   first = The first element to remove from set
 *   last = The final element to remove from set
 */
void setDelRange(Set set, Codepoint first, Codepoint last)
{
  hb_set_del_range(set ? cast(hb_set_t*)set.cPtr(false) : null, first, last);
}

/**
 * Fetches the singleton empty #hb_set_t.
 * Returns: The empty #hb_set_t
 */
Set setGetEmpty()
{
  hb_set_t* _cretval;
  _cretval = hb_set_get_empty();
  auto _retval = _cretval ? new Set(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Finds the largest element in the set.
 * Params:
 *   set = A set
 * Returns: maximum of set, or #HB_SET_VALUE_INVALID if set is empty.
 */
Codepoint setGetMax(Set set)
{
  Codepoint _retval;
  _retval = hb_set_get_max(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Finds the smallest element in the set.
 * Params:
 *   set = A set
 * Returns: minimum of set, or #HB_SET_VALUE_INVALID if set is empty.
 */
Codepoint setGetMin(Set set)
{
  Codepoint _retval;
  _retval = hb_set_get_min(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Returns the number of elements in the set.
 * Params:
 *   set = A set
 * Returns: The population of set
 */
uint setGetPopulation(Set set)
{
  uint _retval;
  _retval = hb_set_get_population(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether codepoint belongs to set.
 * Params:
 *   set = A set
 *   codepoint = The element to query
 * Returns: `true` if codepoint is in set, `false` otherwise
 */
Bool setHas(Set set, Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_has(set ? cast(hb_set_t*)set.cPtr(false) : null, codepoint);
  return _retval;
}

/**
 * Creates a hash representing set.
 * Params:
 *   set = A set
 * Returns: A hash of set.
 */
uint setHash(Set set)
{
  uint _retval;
  _retval = hb_set_hash(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Makes set the intersection of set and other.
 * Params:
 *   set = A set
 *   other = Another set
 */
void setIntersect(Set set, Set other)
{
  hb_set_intersect(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
}

/**
 * Inverts the contents of set.
 * Params:
 *   set = A set
 */
void setInvert(Set set)
{
  hb_set_invert(set ? cast(hb_set_t*)set.cPtr(false) : null);
}

/**
 * Tests whether a set is empty $(LPAREN)contains no elements$(RPAREN).
 * Params:
 *   set = a set.
 * Returns: `true` if set is empty
 */
Bool setIsEmpty(Set set)
{
  Bool _retval;
  _retval = hb_set_is_empty(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether set and other are equal $(LPAREN)contain the same
 * elements$(RPAREN).
 * Params:
 *   set = A set
 *   other = Another set
 * Returns: `true` if the two sets are equal, `false` otherwise.
 */
Bool setIsEqual(Set set, Set other)
{
  Bool _retval;
  _retval = hb_set_is_equal(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
  return _retval;
}

/**
 * Returns whether the set is inverted.
 * Params:
 *   set = A set
 * Returns: `true` if the set is inverted, `false` otherwise
 */
Bool setIsInverted(Set set)
{
  Bool _retval;
  _retval = hb_set_is_inverted(set ? cast(hb_set_t*)set.cPtr(false) : null);
  return _retval;
}

/**
 * Tests whether set is a subset of larger_set.
 * Params:
 *   set = A set
 *   largerSet = Another set
 * Returns: `true` if the set is a subset of $(LPAREN)or equal to$(RPAREN) larger_set, `false` otherwise.
 */
Bool setIsSubset(Set set, Set largerSet)
{
  Bool _retval;
  _retval = hb_set_is_subset(set ? cast(hb_set_t*)set.cPtr(false) : null, largerSet ? cast(hb_set_t*)largerSet.cPtr(false) : null);
  return _retval;
}

/**
 * Fetches the next element in set that is greater than current value of codepoint.
 * Set codepoint to #HB_SET_VALUE_INVALID to get started.
 * Params:
 *   set = A set
 *   codepoint = Input \= Code point to query
 *     Output \= Code point retrieved
 * Returns: `true` if there was a next value, `false` otherwise
 */
Bool setNext(Set set, ref Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_next(set ? cast(hb_set_t*)set.cPtr(false) : null, cast(hb_codepoint_t*)&codepoint);
  return _retval;
}

/**
 * Finds the next element in set that is greater than codepoint. Writes out
 * codepoints to out, until either the set runs out of elements, or size
 * codepoints are written, whichever comes first.
 * Params:
 *   set = A set
 *   codepoint = Outputting codepoints starting after this one.
 *     Use #HB_SET_VALUE_INVALID to get started.
 *   out_ = An array of codepoints to write to.
 * Returns: the number of values written.
 */
uint setNextMany(Set set, Codepoint codepoint, Codepoint[] out_)
{
  uint _retval;
  uint _size;
  if (out_)
    _size = cast(uint)out_.length;

  auto _out_ = cast(hb_codepoint_t*)out_.ptr;
  _retval = hb_set_next_many(set ? cast(hb_set_t*)set.cPtr(false) : null, codepoint, _out_, _size);
  return _retval;
}

/**
 * Fetches the next consecutive range of elements in set that
 * are greater than current value of last.
 * Set last to #HB_SET_VALUE_INVALID to get started.
 * Params:
 *   set = A set
 *   first = The first code point in the range
 *   last = Input \= The current last code point in the range
 *     Output \= The last code point in the range
 * Returns: `true` if there was a next range, `false` otherwise
 */
Bool setNextRange(Set set, out Codepoint first, ref Codepoint last)
{
  Bool _retval;
  _retval = hb_set_next_range(set ? cast(hb_set_t*)set.cPtr(false) : null, cast(hb_codepoint_t*)&first, cast(hb_codepoint_t*)&last);
  return _retval;
}

/**
 * Fetches the previous element in set that is lower than current value of codepoint.
 * Set codepoint to #HB_SET_VALUE_INVALID to get started.
 * Params:
 *   set = A set
 *   codepoint = Input \= Code point to query
 *     Output \= Code point retrieved
 * Returns: `true` if there was a previous value, `false` otherwise
 */
Bool setPrevious(Set set, ref Codepoint codepoint)
{
  Bool _retval;
  _retval = hb_set_previous(set ? cast(hb_set_t*)set.cPtr(false) : null, cast(hb_codepoint_t*)&codepoint);
  return _retval;
}

/**
 * Fetches the previous consecutive range of elements in set that
 * are greater than current value of last.
 * Set first to #HB_SET_VALUE_INVALID to get started.
 * Params:
 *   set = A set
 *   first = Input \= The current first code point in the range
 *     Output \= The first code point in the range
 *   last = The last code point in the range
 * Returns: `true` if there was a previous range, `false` otherwise
 */
Bool setPreviousRange(Set set, ref Codepoint first, out Codepoint last)
{
  Bool _retval;
  _retval = hb_set_previous_range(set ? cast(hb_set_t*)set.cPtr(false) : null, cast(hb_codepoint_t*)&first, cast(hb_codepoint_t*)&last);
  return _retval;
}

/**
 * Makes the contents of set equal to the contents of other.
 * Params:
 *   set = A set
 *   other = Another set
 */
void setSet(Set set, Set other)
{
  hb_set_set(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
}

/**
 * Subtracts the contents of other from set.
 * Params:
 *   set = A set
 *   other = Another set
 */
void setSubtract(Set set, Set other)
{
  hb_set_subtract(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
}

/**
 * Makes set the symmetric difference of set
 * and other.
 * Params:
 *   set = A set
 *   other = Another set
 */
void setSymmetricDifference(Set set, Set other)
{
  hb_set_symmetric_difference(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
}

/**
 * Makes set the union of set and other.
 * Params:
 *   set = A set
 *   other = Another set
 */
void setUnion(Set set, Set other)
{
  hb_set_union(set ? cast(hb_set_t*)set.cPtr(false) : null, other ? cast(hb_set_t*)other.cPtr(false) : null);
}

/**
 * Shapes buffer using font turning its Unicode characters content to
 * positioned glyphs. If features is not `NULL`, it will be used to control the
 * features applied during shaping. If two features have the same tag but
 * overlapping ranges the value of the feature with the higher index takes
 * precedence.
 * Params:
 *   font = an #hb_font_t to use for shaping
 *   buffer = an #hb_buffer_t to shape
 *   features = an array of user
 *     specified #hb_feature_t or `NULL`
 */
void shape(Font font, Buffer buffer, Feature[] features)
{
  uint _numFeatures;
  if (features)
    _numFeatures = cast(uint)features.length;

  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;
  hb_shape(font ? cast(hb_font_t*)font.cPtr(false) : null, buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _features, _numFeatures);
}

/**
 * See [HarfBuzz.Global.shape] for details. If shaper_list is not `NULL`, the specified
 * shapers will be used in the given order, otherwise the default shapers list
 * will be used.
 * Params:
 *   font = an #hb_font_t to use for shaping
 *   buffer = an #hb_buffer_t to shape
 *   features = an array of user
 *     specified #hb_feature_t or `NULL`
 *   shaperList = a `NULL`-terminated
 *     array of shapers to use or `NULL`
 * Returns: false if all shapers failed, true otherwise
 */
Bool shapeFull(Font font, Buffer buffer, Feature[] features, string[] shaperList)
{
  Bool _retval;
  uint _numFeatures;
  if (features)
    _numFeatures = cast(uint)features.length;

  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _retval = hb_shape_full(font ? cast(hb_font_t*)font.cPtr(false) : null, buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _features, _numFeatures, _shaperList);
  return _retval;
}

/**
 * See [HarfBuzz.Global.shapeFull] for basic details. If shaper_list is not `NULL`, the specified
 * shapers will be used in the given order, otherwise the default shapers list
 * will be used.
 * In addition, justify the shaping results such that the shaping results reach
 * the target advance width/height, depending on the buffer direction.
 * If the advance of the buffer shaped with [HarfBuzz.Global.shapeFull] is already known,
 * put that in *advance. Otherwise set *advance to zero.
 * This API is currently experimental and will probably change in the future.
 * Params:
 *   font = a mutable #hb_font_t to use for shaping
 *   buffer = an #hb_buffer_t to shape
 *   features = an array of user
 *     specified #hb_feature_t or `NULL`
 *   shaperList = a `NULL`-terminated
 *     array of shapers to use or `NULL`
 *   minTargetAdvance = Minimum advance width/height to aim for.
 *   maxTargetAdvance = Maximum advance width/height to aim for.
 *   advance = Input/output advance width/height of the buffer.
 *   varTag = Variation-axis tag used for justification.
 *   varValue = Variation-axis value used to reach target justification.
 * Returns: false if all shapers failed, true otherwise
 *   XSince: EXPERIMENTAL
 */
Bool shapeJustify(Font font, Buffer buffer, Feature[] features, string[] shaperList, float minTargetAdvance, float maxTargetAdvance, ref float advance, out Tag varTag, out float varValue)
{
  Bool _retval;
  uint _numFeatures;
  if (features)
    _numFeatures = cast(uint)features.length;

  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _retval = hb_shape_justify(font ? cast(hb_font_t*)font.cPtr(false) : null, buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _features, _numFeatures, _shaperList, minTargetAdvance, maxTargetAdvance, cast(float*)&advance, cast(hb_tag_t*)&varTag, cast(float*)&varValue);
  return _retval;
}

/**
 * Retrieves the list of shapers supported by HarfBuzz.
 * Returns: an array of
 *   constant strings
 */
string[] shapeListShapers()
{
  const(char*)* _cretval;
  _cretval = hb_shape_list_shapers();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] !is null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * Constructs a shaping plan for a combination of face, user_features, props,
 * and shaper_list.
 * Params:
 *   face = #hb_face_t to use
 *   props = The #hb_segment_properties_t of the segment
 *   userFeatures = The list of user-selected features
 *   shaperList = List of shapers to try
 * Returns: The shaping plan
 */
ShapePlan shapePlanCreate(HBFace face, SegmentProperties props, Feature[] userFeatures, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  uint _numUserFeatures;
  if (userFeatures)
    _numUserFeatures = cast(uint)userFeatures.length;

  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create(face ? cast(hb_face_t*)face.cPtr(false) : null, props ? cast(hb_segment_properties_t*)props.cPtr(false) : null, _userFeatures, _numUserFeatures, _shaperList);
  auto _retval = _cretval ? new ShapePlan(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * The variable-font version of #hb_shape_plan_create.
 * Constructs a shaping plan for a combination of face, user_features, props,
 * and shaper_list, plus the variation-space coordinates coords.
 * Params:
 *   face = #hb_face_t to use
 *   props = The #hb_segment_properties_t of the segment
 *   userFeatures = The list of user-selected features
 *   coords = The list of variation-space coordinates
 *   shaperList = List of shapers to try
 * Returns: The shaping plan
 */
ShapePlan shapePlanCreate2(HBFace face, SegmentProperties props, Feature[] userFeatures, int[] coords, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  uint _numUserFeatures;
  if (userFeatures)
    _numUserFeatures = cast(uint)userFeatures.length;

  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  uint _numCoords;
  if (coords)
    _numCoords = cast(uint)coords.length;

  auto _coords = cast(const(int)*)coords.ptr;
  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create2(face ? cast(hb_face_t*)face.cPtr(false) : null, props ? cast(hb_segment_properties_t*)props.cPtr(false) : null, _userFeatures, _numUserFeatures, _coords, _numCoords, _shaperList);
  auto _retval = _cretval ? new ShapePlan(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a cached shaping plan suitable for reuse, for a combination
 * of face, user_features, props, and shaper_list.
 * Params:
 *   face = #hb_face_t to use
 *   props = The #hb_segment_properties_t of the segment
 *   userFeatures = The list of user-selected features
 *   shaperList = List of shapers to try
 * Returns: The shaping plan
 */
ShapePlan shapePlanCreateCached(HBFace face, SegmentProperties props, Feature[] userFeatures, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  uint _numUserFeatures;
  if (userFeatures)
    _numUserFeatures = cast(uint)userFeatures.length;

  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create_cached(face ? cast(hb_face_t*)face.cPtr(false) : null, props ? cast(hb_segment_properties_t*)props.cPtr(false) : null, _userFeatures, _numUserFeatures, _shaperList);
  auto _retval = _cretval ? new ShapePlan(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * The variable-font version of #hb_shape_plan_create_cached.
 * Creates a cached shaping plan suitable for reuse, for a combination
 * of face, user_features, props, and shaper_list, plus the
 * variation-space coordinates coords.
 * Params:
 *   face = #hb_face_t to use
 *   props = The #hb_segment_properties_t of the segment
 *   userFeatures = The list of user-selected features
 *   coords = The list of variation-space coordinates
 *   shaperList = List of shapers to try
 * Returns: The shaping plan
 */
ShapePlan shapePlanCreateCached2(HBFace face, SegmentProperties props, Feature[] userFeatures, int[] coords, string[] shaperList)
{
  hb_shape_plan_t* _cretval;
  uint _numUserFeatures;
  if (userFeatures)
    _numUserFeatures = cast(uint)userFeatures.length;

  hb_feature_t[] _tmpuserFeatures;
  foreach (obj; userFeatures)
    _tmpuserFeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _userFeatures = _tmpuserFeatures.ptr;

  uint _numCoords;
  if (coords)
    _numCoords = cast(uint)coords.length;

  auto _coords = cast(const(int)*)coords.ptr;
  char*[] _tmpshaperList;
  foreach (s; shaperList)
    _tmpshaperList ~= s.toCString(false);
  _tmpshaperList ~= null;
  const(char*)* _shaperList = _tmpshaperList.ptr;
  _cretval = hb_shape_plan_create_cached2(face ? cast(hb_face_t*)face.cPtr(false) : null, props ? cast(hb_segment_properties_t*)props.cPtr(false) : null, _userFeatures, _numUserFeatures, _coords, _numCoords, _shaperList);
  auto _retval = _cretval ? new ShapePlan(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Executes the given shaping plan on the specified buffer, using
 * the given font and features.
 * Params:
 *   shapePlan = A shaping plan
 *   font = The #hb_font_t to use
 *   buffer = The #hb_buffer_t to work upon
 *   features = Features to enable
 * Returns: `true` if success, `false` otherwise.
 */
Bool shapePlanExecute(ShapePlan shapePlan, Font font, Buffer buffer, Feature[] features)
{
  Bool _retval;
  uint _numFeatures;
  if (features)
    _numFeatures = cast(uint)features.length;

  hb_feature_t[] _tmpfeatures;
  foreach (obj; features)
    _tmpfeatures ~= *cast(hb_feature_t*)obj.cPtr;
  const(hb_feature_t)* _features = _tmpfeatures.ptr;
  _retval = hb_shape_plan_execute(shapePlan ? cast(hb_shape_plan_t*)shapePlan.cPtr(false) : null, font ? cast(hb_font_t*)font.cPtr(false) : null, buffer ? cast(hb_buffer_t*)buffer.cPtr(false) : null, _features, _numFeatures);
  return _retval;
}

/**
 * Fetches the singleton empty shaping plan.
 * Returns: The empty shaping plan
 */
ShapePlan shapePlanGetEmpty()
{
  hb_shape_plan_t* _cretval;
  _cretval = hb_shape_plan_get_empty();
  auto _retval = _cretval ? new ShapePlan(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the shaper from a given shaping plan.
 * Params:
 *   shapePlan = A shaping plan
 * Returns: The shaper
 */
string shapePlanGetShaper(ShapePlan shapePlan)
{
  const(char)* _cretval;
  _cretval = hb_shape_plan_get_shaper(shapePlan ? cast(hb_shape_plan_t*)shapePlan.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Searches variation axes of a #hb_font_t object for a specific axis first,
 * if not set, then tries to get default style values from different
 * tables of the font.
 * Params:
 *   font = a #hb_font_t object.
 *   styleTag = a style tag.
 * Returns: Corresponding axis or default value to a style tag.
 */
float styleGetValue(Font font, StyleTag styleTag)
{
  float _retval;
  _retval = hb_style_get_value(font ? cast(hb_font_t*)font.cPtr(false) : null, styleTag);
  return _retval;
}

/**
 * Converts a string into an #hb_tag_t. Valid tags
 * are four characters. Shorter input strings will be
 * padded with spaces. Longer input strings will be
 * truncated.
 * Params:
 *   str = String to convert
 * Returns: The #hb_tag_t corresponding to str
 */
Tag tagFromString(ubyte[] str)
{
  Tag _retval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  _retval = hb_tag_from_string(_str, _len);
  return _retval;
}

/**
 * Retrieves the Canonical Combining Class $(LPAREN)ccc$(RPAREN) property
 * of code point unicode.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   unicode = The code point to query
 * Returns: The #hb_unicode_combining_class_t of unicode
 */
UnicodeCombiningClass unicodeCombiningClass(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_unicode_combining_class_t _cretval;
  _cretval = hb_unicode_combining_class(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, unicode);
  UnicodeCombiningClass _retval = cast(UnicodeCombiningClass)_cretval;
  return _retval;
}

/**
 * Fetches the composition of a sequence of two Unicode
 * code points.
 * Calls the composition function of the specified
 * Unicode-functions structure ufuncs.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   a = The first Unicode code point to compose
 *   b = The second Unicode code point to compose
 *   ab = The composition of a, b
 * Returns: `true` if a and b composed, `false` otherwise
 */
Bool unicodeCompose(UnicodeFuncs ufuncs, Codepoint a, Codepoint b, out Codepoint ab)
{
  Bool _retval;
  _retval = hb_unicode_compose(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, a, b, cast(hb_codepoint_t*)&ab);
  return _retval;
}

/**
 * Fetches the decomposition of a Unicode code point.
 * Calls the decomposition function of the specified
 * Unicode-functions structure ufuncs.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   ab = Unicode code point to decompose
 *   a = The first code point of the decomposition of ab
 *   b = The second code point of the decomposition of ab
 * Returns: `true` if ab was decomposed, `false` otherwise
 */
Bool unicodeDecompose(UnicodeFuncs ufuncs, Codepoint ab, out Codepoint a, out Codepoint b)
{
  Bool _retval;
  _retval = hb_unicode_decompose(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, ab, cast(hb_codepoint_t*)&a, cast(hb_codepoint_t*)&b);
  return _retval;
}

/**
 * Fetches the compatibility decomposition of a Unicode
 * code point. Deprecated.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   u = Code point to decompose
 *   decomposed = Compatibility decomposition of u
 * Returns: length of decomposed.
 */
uint unicodeDecomposeCompatibility(UnicodeFuncs ufuncs, Codepoint u, out Codepoint decomposed)
{
  uint _retval;
  _retval = hb_unicode_decompose_compatibility(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, u, cast(hb_codepoint_t*)&decomposed);
  return _retval;
}

/**
 * Don't use. Not used by HarfBuzz.
 * Params:
 *   ufuncs = a Unicode-function structure
 *   unicode = The code point to query
 * Returns:
 */
uint unicodeEastasianWidth(UnicodeFuncs ufuncs, Codepoint unicode)
{
  uint _retval;
  _retval = hb_unicode_eastasian_width(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, unicode);
  return _retval;
}

/**
 * Creates a new #hb_unicode_funcs_t structure of Unicode functions.
 * Params:
 *   parent = Parent Unicode-functions structure
 * Returns: The Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsCreate(UnicodeFuncs parent)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_create(parent ? cast(hb_unicode_funcs_t*)parent.cPtr(false) : null);
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches a pointer to the default Unicode-functions structure that is used
 * when no functions are explicitly set on #hb_buffer_t.
 * Returns: a pointer to the #hb_unicode_funcs_t Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetDefault()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_default();
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Fetches the singleton empty Unicode-functions structure.
 * Returns: The empty Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetEmpty()
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_empty();
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Fetches the parent of the Unicode-functions structure
 * ufuncs.
 * Params:
 *   ufuncs = The Unicode-functions structure
 * Returns: The parent Unicode-functions structure
 */
UnicodeFuncs unicodeFuncsGetParent(UnicodeFuncs ufuncs)
{
  hb_unicode_funcs_t* _cretval;
  _cretval = hb_unicode_funcs_get_parent(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null);
  auto _retval = _cretval ? new UnicodeFuncs(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Tests whether the specified Unicode-functions structure
 * is immutable.
 * Params:
 *   ufuncs = The Unicode-functions structure
 * Returns: `true` if ufuncs is immutable, `false` otherwise
 */
Bool unicodeFuncsIsImmutable(UnicodeFuncs ufuncs)
{
  Bool _retval;
  _retval = hb_unicode_funcs_is_immutable(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null);
  return _retval;
}

/**
 * Makes the specified Unicode-functions structure
 * immutable.
 * Params:
 *   ufuncs = The Unicode-functions structure
 */
void unicodeFuncsMakeImmutable(UnicodeFuncs ufuncs)
{
  hb_unicode_funcs_make_immutable(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null);
}

/**
 * Sets the implementation function for #hb_unicode_combining_class_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetCombiningClassFunc(UnicodeFuncs ufuncs, UnicodeCombiningClassFunc func)
{
  extern(C) hb_unicode_combining_class_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    UnicodeCombiningClass _dretval;
    auto _dlg = cast(UnicodeCombiningClassFunc*)userData;

    _dretval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, unicode);
    auto _retval = cast(hb_unicode_combining_class_t)_dretval;

    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_combining_class_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_compose_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetComposeFunc(UnicodeFuncs ufuncs, UnicodeComposeFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t a, hb_codepoint_t b, hb_codepoint_t* ab, void* userData)
  {
    auto _dlg = cast(UnicodeComposeFunc*)userData;

    hb_bool_t _retval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, a, b, *ab);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_compose_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_decompose_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetDecomposeFunc(UnicodeFuncs ufuncs, UnicodeDecomposeFunc func)
{
  extern(C) hb_bool_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t ab, hb_codepoint_t* a, hb_codepoint_t* b, void* userData)
  {
    auto _dlg = cast(UnicodeDecomposeFunc*)userData;

    hb_bool_t _retval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, ab, *a, *b);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_decompose_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_eastasian_width_func_t.
 * Params:
 *   ufuncs = a Unicode-function structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetEastasianWidthFunc(UnicodeFuncs ufuncs, UnicodeEastasianWidthFunc func)
{
  extern(C) uint _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    auto _dlg = cast(UnicodeEastasianWidthFunc*)userData;

    uint _retval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, unicode);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_eastasian_width_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_general_category_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetGeneralCategoryFunc(UnicodeFuncs ufuncs, UnicodeGeneralCategoryFunc func)
{
  extern(C) hb_unicode_general_category_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    UnicodeGeneralCategory _dretval;
    auto _dlg = cast(UnicodeGeneralCategoryFunc*)userData;

    _dretval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, unicode);
    auto _retval = cast(hb_unicode_general_category_t)_dretval;

    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_general_category_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_mirroring_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetMirroringFunc(UnicodeFuncs ufuncs, UnicodeMirroringFunc func)
{
  extern(C) hb_codepoint_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    auto _dlg = cast(UnicodeMirroringFunc*)userData;

    hb_codepoint_t _retval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, unicode);
    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_mirroring_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Sets the implementation function for #hb_unicode_script_func_t.
 * Params:
 *   ufuncs = A Unicode-functions structure
 *   func = The callback function to assign
 */
void unicodeFuncsSetScriptFunc(UnicodeFuncs ufuncs, UnicodeScriptFunc func)
{
  extern(C) hb_script_t _funcCallback(hb_unicode_funcs_t* ufuncs, hb_codepoint_t unicode, void* userData)
  {
    Script _dretval;
    auto _dlg = cast(UnicodeScriptFunc*)userData;

    _dretval = (*_dlg)(ufuncs ? new UnicodeFuncs(cast(void*)ufuncs, false) : null, unicode);
    auto _retval = cast(hb_script_t)_dretval;

    return _retval;
  }

  auto _func = freezeDelegate(cast(void*)&func);
  hb_unicode_funcs_set_script_func(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Retrieves the General Category $(LPAREN)gc$(RPAREN) property
 * of code point unicode.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   unicode = The code point to query
 * Returns: The #hb_unicode_general_category_t of unicode
 */
UnicodeGeneralCategory unicodeGeneralCategory(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_unicode_general_category_t _cretval;
  _cretval = hb_unicode_general_category(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, unicode);
  UnicodeGeneralCategory _retval = cast(UnicodeGeneralCategory)_cretval;
  return _retval;
}

/**
 * Retrieves the Bi-directional Mirroring Glyph code
 * point defined for code point unicode.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   unicode = The code point to query
 * Returns: The #hb_codepoint_t of the Mirroring Glyph for unicode
 */
Codepoint unicodeMirroring(UnicodeFuncs ufuncs, Codepoint unicode)
{
  Codepoint _retval;
  _retval = hb_unicode_mirroring(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, unicode);
  return _retval;
}

/**
 * Retrieves the #hb_script_t script to which code
 * point unicode belongs.
 * Params:
 *   ufuncs = The Unicode-functions structure
 *   unicode = The code point to query
 * Returns: The #hb_script_t of unicode
 */
Script unicodeScript(UnicodeFuncs ufuncs, Codepoint unicode)
{
  hb_script_t _cretval;
  _cretval = hb_unicode_script(ufuncs ? cast(hb_unicode_funcs_t*)ufuncs.cPtr(false) : null, unicode);
  Script _retval = cast(Script)_cretval;
  return _retval;
}

/**
 * Parses a string into a #hb_variation_t.
 * The format for specifying variation settings follows. All valid CSS
 * font-variation-settings values other than 'normal' and 'inherited' are also
 * accepted, though, not documented below.
 * The format is a tag, optionally followed by an equals sign, followed by a
 * number. For example `wght\=500`, or `slnt\=-7.5`.
 * Params:
 *   str = a string to parse
 *   variation = the #hb_variation_t to initialize with the parsed values
 * Returns: `true` if str is successfully parsed, `false` otherwise
 */
Bool variationFromString(ubyte[] str, out Variation variation)
{
  Bool _retval;
  int _len;
  if (str)
    _len = cast(int)str.length;

  auto _str = cast(const(ubyte)*)str.ptr;
  hb_variation_t _variation;
  _retval = hb_variation_from_string(_str, _len, &_variation);
  variation = new Variation(cast(void*)&_variation);
  return _retval;
}
