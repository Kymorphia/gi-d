module Gio.FileInfo;

import GLib.DateTime;
import GLib.TimeVal;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.FileAttributeMatcher;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Functionality for manipulating basic metadata for files. #GFileInfo
 * implements methods for getting information that all files should
 * contain, and allows for manipulation of extended attributes.
 *
 * See [GFileAttribute][gio-GFileAttribute] for more information on how
 * GIO handles file attributes.
 *
 * To obtain a #GFileInfo for a #GFile, use g_file_query_info() (or its
 * async variant). To obtain a #GFileInfo for a file input or output
 * stream, use g_file_input_stream_query_info() or
 * g_file_output_stream_query_info() (or their async variants).
 *
 * To change the actual attributes of a file, you should then set the
 * attribute in the #GFileInfo and call g_file_set_attributes_from_info()
 * or g_file_set_attributes_async() on a GFile.
 *
 * However, not all attributes can be changed in the file. For instance,
 * the actual size of a file cannot be changed via g_file_info_set_size().
 * You may call g_file_query_settable_attributes() and
 * g_file_query_writable_namespaces() to discover the settable attributes
 * of a particular file at runtime.
 *
 * The direct accessors, such as g_file_info_get_name(), are slightly more
 * optimized than the generic attribute accessors, such as
 * g_file_info_get_attribute_byte_string().This optimization will matter
 * only if calling the API in a tight loop.
 *
 * It is an error to call these accessors without specifying their required file
 * attributes when creating the #GFileInfo. Use g_file_info_has_attribute() or
 * g_file_info_list_attributes() to check what attributes are specified for a
 * #GFileInfo.
 *
 * #GFileAttributeMatcher allows for searching through a #GFileInfo for
 * attributes.
 */
class FileInfo : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_info_get_type();
  }

  /**
   * a #GFileInfo.
   */
  this()
  {
    GFileInfo* _cretval;
    _cretval = g_file_info_new();
    this(_cretval, true);
  }

  /**
   * Clears the status information from @info.
   */
  void clearStatus()
  {
    g_file_info_clear_status(cPtr!GFileInfo);
  }

  /**
   * First clears all of the [GFileAttribute][gio-GFileAttribute] of @dest_info,
   * and then copies all of the file attributes from @src_info to @dest_info.
   */
  void copyInto(FileInfo destInfo)
  {
    g_file_info_copy_into(cPtr!GFileInfo, destInfo ? destInfo.cPtr!GFileInfo : null);
  }

  /**
   * a duplicate #GFileInfo of @other.
   */
  FileInfo dup()
  {
    GFileInfo* _cretval;
    _cretval = g_file_info_dup(cPtr!GFileInfo);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * access time, or %NULL if unknown
   */
  DateTime getAccessDateTime()
  {
    GDateTime* _cretval;
    _cretval = g_file_info_get_access_date_time(cPtr!GFileInfo);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a UTF-8 string associated with the given @attribute, or
   * %NULL if the attribute wasn’t set.
   * When you're done with the string it must be freed with g_free().
   */
  string getAttributeAsString(string attribute)
  {
    char* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_as_string(cPtr!GFileInfo, _attribute);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the boolean value contained within the attribute.
   */
  bool getAttributeBoolean(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_boolean(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * the contents of the @attribute value as a byte string, or
   * %NULL otherwise.
   */
  string getAttributeByteString(string attribute)
  {
    const(char)* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_byte_string(cPtr!GFileInfo, _attribute);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if @info has an attribute named @attribute,
   * %FALSE otherwise.
   */
  bool getAttributeData(string attribute, out FileAttributeType type, out void* valuePp, out FileAttributeStatus status)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_data(cPtr!GFileInfo, _attribute, &type, cast(void**)&valuePp, &status);
    return _retval;
  }

  /**
   * the contents of the @attribute value as
   * a file path, or %NULL otherwise.
   */
  string getAttributeFilePath(string attribute)
  {
    const(char)* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_file_path(cPtr!GFileInfo, _attribute);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a signed 32-bit integer from the attribute.
   */
  int getAttributeInt32(string attribute)
  {
    int _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_int32(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * a signed 64-bit integer from the attribute.
   */
  long getAttributeInt64(string attribute)
  {
    long _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_int64(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * a #GObject associated with the given @attribute,
   * or %NULL otherwise.
   */
  ObjectG getAttributeObject(string attribute)
  {
    ObjectC* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_object(cPtr!GFileInfo, _attribute);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * a #GFileAttributeStatus for the given @attribute, or
   * %G_FILE_ATTRIBUTE_STATUS_UNSET if the key is invalid.
   */
  FileAttributeStatus getAttributeStatus(string attribute)
  {
    GFileAttributeStatus _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_status(cPtr!GFileInfo, _attribute);
    FileAttributeStatus _retval = cast(FileAttributeStatus)_cretval;
    return _retval;
  }

  /**
   * the contents of the @attribute value as a UTF-8 string,
   * or %NULL otherwise.
   */
  string getAttributeString(string attribute)
  {
    const(char)* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_string(cPtr!GFileInfo, _attribute);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the contents of the @attribute value as a stringv,
   * or %NULL otherwise. Do not free. These returned strings are UTF-8.
   */
  string[] getAttributeStringv(string attribute)
  {
    char** _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_stringv(cPtr!GFileInfo, _attribute);
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
   * a #GFileAttributeType for the given @attribute, or
   * %G_FILE_ATTRIBUTE_TYPE_INVALID if the key is not set.
   */
  FileAttributeType getAttributeType(string attribute)
  {
    GFileAttributeType _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_file_info_get_attribute_type(cPtr!GFileInfo, _attribute);
    FileAttributeType _retval = cast(FileAttributeType)_cretval;
    return _retval;
  }

  /**
   * an unsigned 32-bit integer from the attribute.
   */
  uint getAttributeUint32(string attribute)
  {
    uint _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_uint32(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * a unsigned 64-bit integer from the attribute.
   */
  ulong getAttributeUint64(string attribute)
  {
    ulong _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_get_attribute_uint64(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * a string containing the file's content type,
   * or %NULL if unknown.
   */
  string getContentType()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_content_type(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * creation time, or %NULL if unknown
   */
  DateTime getCreationDateTime()
  {
    GDateTime* _cretval;
    _cretval = g_file_info_get_creation_date_time(cPtr!GFileInfo);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDateTime, or %NULL.
   */
  DateTime getDeletionDate()
  {
    GDateTime* _cretval;
    _cretval = g_file_info_get_deletion_date(cPtr!GFileInfo);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a string containing the display name.
   */
  string getDisplayName()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_display_name(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the edit name.
   */
  string getEditName()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_edit_name(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the value of the "etag:value" attribute.
   */
  string getEtag()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_etag(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GFileType for the given file.
   */
  FileType getFileType()
  {
    GFileType _cretval;
    _cretval = g_file_info_get_file_type(cPtr!GFileInfo);
    FileType _retval = cast(FileType)_cretval;
    return _retval;
  }

  /**
   * #GIcon for the given @info.
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_file_info_get_icon(cPtr!GFileInfo);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if file is a backup file, %FALSE otherwise.
   */
  bool getIsBackup()
  {
    bool _retval;
    _retval = g_file_info_get_is_backup(cPtr!GFileInfo);
    return _retval;
  }

  /**
   * %TRUE if the file is a hidden file, %FALSE otherwise.
   */
  bool getIsHidden()
  {
    bool _retval;
    _retval = g_file_info_get_is_hidden(cPtr!GFileInfo);
    return _retval;
  }

  /**
   * %TRUE if the given @info is a symlink.
   */
  bool getIsSymlink()
  {
    bool _retval;
    _retval = g_file_info_get_is_symlink(cPtr!GFileInfo);
    return _retval;
  }

  /**
   * modification time, or %NULL if unknown
   */
  DateTime getModificationDateTime()
  {
    GDateTime* _cretval;
    _cretval = g_file_info_get_modification_date_time(cPtr!GFileInfo);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * Gets the modification time of the current @info and sets it
   * in @result.
   *
   * It is an error to call this if the #GFileInfo does not contain
   * %G_FILE_ATTRIBUTE_TIME_MODIFIED. If %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC is
   * provided it will be used too.
   */
  void getModificationTime(out TimeVal result)
  {
    GTimeVal _result;
    g_file_info_get_modification_time(cPtr!GFileInfo, &_result);
    result = new TimeVal(cast(void*)&_result);
  }

  /**
   * a string containing the file name.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_name(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #goffset containing the file's size (in bytes).
   */
  long getSize()
  {
    long _retval;
    _retval = g_file_info_get_size(cPtr!GFileInfo);
    return _retval;
  }

  /**
   * a #gint32 containing the value of the "standard::sort_order" attribute.
   */
  int getSortOrder()
  {
    int _retval;
    _retval = g_file_info_get_sort_order(cPtr!GFileInfo);
    return _retval;
  }

  /**
   * #GIcon for the given @info.
   */
  Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_file_info_get_symbolic_icon(cPtr!GFileInfo);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false);
    return _retval;
  }

  /**
   * a string containing the symlink target.
   */
  string getSymlinkTarget()
  {
    const(char)* _cretval;
    _cretval = g_file_info_get_symlink_target(cPtr!GFileInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if @info has an attribute named @attribute,
   * %FALSE otherwise.
   */
  bool hasAttribute(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_has_attribute(cPtr!GFileInfo, _attribute);
    return _retval;
  }

  /**
   * %TRUE if @info has an attribute in @name_space,
   * %FALSE otherwise.
   */
  bool hasNamespace(string nameSpace)
  {
    bool _retval;
    const(char)* _nameSpace = nameSpace.toCString(false);
    _retval = g_file_info_has_namespace(cPtr!GFileInfo, _nameSpace);
    return _retval;
  }

  /**
   * a
   * null-terminated array of strings of all of the possible attribute
   * types for the given @name_space, or %NULL on error.
   */
  string[] listAttributes(string nameSpace)
  {
    char** _cretval;
    const(char)* _nameSpace = nameSpace.toCString(false);
    _cretval = g_file_info_list_attributes(cPtr!GFileInfo, _nameSpace);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Removes all cases of @attribute from @info if it exists.
   */
  void removeAttribute(string attribute)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_remove_attribute(cPtr!GFileInfo, _attribute);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_TIME_ACCESS and
   * %G_FILE_ATTRIBUTE_TIME_ACCESS_USEC attributes in the file info to the
   * given date/time value.
   *
   * %G_FILE_ATTRIBUTE_TIME_ACCESS_NSEC will be cleared.
   */
  void setAccessDateTime(DateTime atime)
  {
    g_file_info_set_access_date_time(cPtr!GFileInfo, atime ? atime.cPtr!GDateTime : null);
  }

  /**
   * Sets the @attribute to contain the given value, if possible. To unset the
   * attribute, use %G_FILE_ATTRIBUTE_TYPE_INVALID for @type.
   */
  void setAttribute(string attribute, FileAttributeType type, void* valueP)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute(cPtr!GFileInfo, _attribute, type, valueP);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeBoolean(string attribute, bool attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_boolean(cPtr!GFileInfo, _attribute, attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeByteString(string attribute, string attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    const(char)* _attrValue = attrValue.toCString(false);
    g_file_info_set_attribute_byte_string(cPtr!GFileInfo, _attribute, _attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   *
   * This function is meant to be used by language bindings that have specific
   * handling for Unix paths.
   */
  void setAttributeFilePath(string attribute, string attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    const(char)* _attrValue = attrValue.toCString(false);
    g_file_info_set_attribute_file_path(cPtr!GFileInfo, _attribute, _attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeInt32(string attribute, int attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_int32(cPtr!GFileInfo, _attribute, attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeInt64(string attribute, long attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_int64(cPtr!GFileInfo, _attribute, attrValue);
  }

  /**
   * Sets @mask on @info to match specific attribute types.
   */
  void setAttributeMask(FileAttributeMatcher mask)
  {
    g_file_info_set_attribute_mask(cPtr!GFileInfo, mask ? mask.cPtr!GFileAttributeMatcher : null);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeObject(string attribute, ObjectG attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_object(cPtr!GFileInfo, _attribute, attrValue ? attrValue.cPtr!ObjectC : null);
  }

  /**
   * %TRUE if the status was changed, %FALSE if the key was not set.
   */
  bool setAttributeStatus(string attribute, FileAttributeStatus status)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_info_set_attribute_status(cPtr!GFileInfo, _attribute, status);
    return _retval;
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeString(string attribute, string attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    const(char)* _attrValue = attrValue.toCString(false);
    g_file_info_set_attribute_string(cPtr!GFileInfo, _attribute, _attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   *
   * Sinze: 2.22
   */
  void setAttributeStringv(string attribute, string[] attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    char*[] _tmpattrValue;
    foreach (s; attrValue)
      _tmpattrValue ~= s.toCString(false);
    _tmpattrValue ~= null;
    char** _attrValue = _tmpattrValue.ptr;
    g_file_info_set_attribute_stringv(cPtr!GFileInfo, _attribute, _attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeUint32(string attribute, uint attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_uint32(cPtr!GFileInfo, _attribute, attrValue);
  }

  /**
   * Sets the @attribute to contain the given @attr_value,
   * if possible.
   */
  void setAttributeUint64(string attribute, ulong attrValue)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_file_info_set_attribute_uint64(cPtr!GFileInfo, _attribute, attrValue);
  }

  /**
   * Sets the content type attribute for a given #GFileInfo.
   * See %G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE.
   */
  void setContentType(string contentType)
  {
    const(char)* _contentType = contentType.toCString(false);
    g_file_info_set_content_type(cPtr!GFileInfo, _contentType);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_TIME_CREATED and
   * %G_FILE_ATTRIBUTE_TIME_CREATED_USEC attributes in the file info to the
   * given date/time value.
   *
   * %G_FILE_ATTRIBUTE_TIME_CREATED_NSEC will be cleared.
   */
  void setCreationDateTime(DateTime creationTime)
  {
    g_file_info_set_creation_date_time(cPtr!GFileInfo, creationTime ? creationTime.cPtr!GDateTime : null);
  }

  /**
   * Sets the display name for the current #GFileInfo.
   * See %G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME.
   */
  void setDisplayName(string displayName)
  {
    const(char)* _displayName = displayName.toCString(false);
    g_file_info_set_display_name(cPtr!GFileInfo, _displayName);
  }

  /**
   * Sets the edit name for the current file.
   * See %G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME.
   */
  void setEditName(string editName)
  {
    const(char)* _editName = editName.toCString(false);
    g_file_info_set_edit_name(cPtr!GFileInfo, _editName);
  }

  /**
   * Sets the file type in a #GFileInfo to @type.
   * See %G_FILE_ATTRIBUTE_STANDARD_TYPE.
   */
  void setFileType(FileType type)
  {
    g_file_info_set_file_type(cPtr!GFileInfo, type);
  }

  /**
   * Sets the icon for a given #GFileInfo.
   * See %G_FILE_ATTRIBUTE_STANDARD_ICON.
   */
  void setIcon(Icon icon)
  {
    g_file_info_set_icon(cPtr!GFileInfo, icon ? (cast(ObjectG)icon).cPtr!GIcon : null);
  }

  /**
   * Sets the "is_hidden" attribute in a #GFileInfo according to @is_hidden.
   * See %G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN.
   */
  void setIsHidden(bool isHidden)
  {
    g_file_info_set_is_hidden(cPtr!GFileInfo, isHidden);
  }

  /**
   * Sets the "is_symlink" attribute in a #GFileInfo according to @is_symlink.
   * See %G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK.
   */
  void setIsSymlink(bool isSymlink)
  {
    g_file_info_set_is_symlink(cPtr!GFileInfo, isSymlink);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_TIME_MODIFIED and
   * %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC attributes in the file info to the
   * given date/time value.
   *
   * %G_FILE_ATTRIBUTE_TIME_MODIFIED_NSEC will be cleared.
   */
  void setModificationDateTime(DateTime mtime)
  {
    g_file_info_set_modification_date_time(cPtr!GFileInfo, mtime ? mtime.cPtr!GDateTime : null);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_TIME_MODIFIED and
   * %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC attributes in the file info to the
   * given time value.
   *
   * %G_FILE_ATTRIBUTE_TIME_MODIFIED_NSEC will be cleared.
   */
  void setModificationTime(TimeVal mtime)
  {
    g_file_info_set_modification_time(cPtr!GFileInfo, mtime ? mtime.cPtr!GTimeVal : null);
  }

  /**
   * Sets the name attribute for the current #GFileInfo.
   * See %G_FILE_ATTRIBUTE_STANDARD_NAME.
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_file_info_set_name(cPtr!GFileInfo, _name);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_STANDARD_SIZE attribute in the file info
   * to the given size.
   */
  void setSize(long size)
  {
    g_file_info_set_size(cPtr!GFileInfo, size);
  }

  /**
   * Sets the sort order attribute in the file info structure. See
   * %G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER.
   */
  void setSortOrder(int sortOrder)
  {
    g_file_info_set_sort_order(cPtr!GFileInfo, sortOrder);
  }

  /**
   * Sets the symbolic icon for a given #GFileInfo.
   * See %G_FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON.
   */
  void setSymbolicIcon(Icon icon)
  {
    g_file_info_set_symbolic_icon(cPtr!GFileInfo, icon ? (cast(ObjectG)icon).cPtr!GIcon : null);
  }

  /**
   * Sets the %G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET attribute in the file info
   * to the given symlink target.
   */
  void setSymlinkTarget(string symlinkTarget)
  {
    const(char)* _symlinkTarget = symlinkTarget.toCString(false);
    g_file_info_set_symlink_target(cPtr!GFileInfo, _symlinkTarget);
  }

  /**
   * Unsets a mask set by g_file_info_set_attribute_mask(), if one
   * is set.
   */
  void unsetAttributeMask()
  {
    g_file_info_unset_attribute_mask(cPtr!GFileInfo);
  }
}
