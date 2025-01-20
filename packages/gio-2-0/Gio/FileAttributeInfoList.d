module Gio.FileAttributeInfoList;

import GLib.Boxed;
import Gid.gid;
import Gio.FileAttributeInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Acts as a lightweight registry for possible valid file attributes.
 * The registry stores Key-Value pair formats as #GFileAttributeInfos.
 */
class FileAttributeInfoList : Boxed
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
    return g_file_attribute_info_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property FileAttributeInfo infos()
  {
    return new FileAttributeInfo(cast(GFileAttributeInfo*)(cast(GFileAttributeInfoList*)cPtr).infos);
  }

  @property int nInfos()
  {
    return (cast(GFileAttributeInfoList*)cPtr).nInfos;
  }

  @property void nInfos(int propval)
  {
    (cast(GFileAttributeInfoList*)cPtr).nInfos = propval;
  }

  /**
   * Creates a new file attribute info list.
   * Returns: a #GFileAttributeInfoList.
   */
  this()
  {
    GFileAttributeInfoList* _cretval;
    _cretval = g_file_attribute_info_list_new();
    this(_cretval, true);
  }

  /**
   * Adds a new attribute with name to the list, setting
   * its type and flags.
   * Params:
   *   name = the name of the attribute to add.
   *   type = the #GFileAttributeType for the attribute.
   *   flags = #GFileAttributeInfoFlags for the attribute.
   */
  void add(string name, FileAttributeType type, FileAttributeInfoFlags flags)
  {
    const(char)* _name = name.toCString(false);
    g_file_attribute_info_list_add(cast(GFileAttributeInfoList*)cPtr, _name, type, flags);
  }

  /**
   * Makes a duplicate of a file attribute info list.
   * Returns: a copy of the given list.
   */
  FileAttributeInfoList dup()
  {
    GFileAttributeInfoList* _cretval;
    _cretval = g_file_attribute_info_list_dup(cast(GFileAttributeInfoList*)cPtr);
    auto _retval = _cretval ? new FileAttributeInfoList(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the file attribute with the name name from list.
   * Params:
   *   name = the name of the attribute to look up.
   * Returns: a #GFileAttributeInfo for the name, or %NULL if an
   *   attribute isn't found.
   */
  FileAttributeInfo lookup(string name)
  {
    const(GFileAttributeInfo)* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_file_attribute_info_list_lookup(cast(GFileAttributeInfoList*)cPtr, _name);
    auto _retval = _cretval ? new FileAttributeInfo(cast(GFileAttributeInfo*)_cretval) : null;
    return _retval;
  }
}
