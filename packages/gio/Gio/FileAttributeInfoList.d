module Gio.FileAttributeInfoList;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
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

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GFileAttributeInfoList))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_file_attribute_info_list_get_type();
  }

  @property FileAttributeInfo infos()
  {
    return new FileAttributeInfo(cast(GFileAttributeInfo*)cPtr!GFileAttributeInfoList.infos);
  }

  @property int nInfos()
  {
    return cPtr!GFileAttributeInfoList.nInfos;
  }

  @property void nInfos(int propval)
  {
    cPtr!GFileAttributeInfoList.nInfos = propval;
  }

  /**
   * a #GFileAttributeInfoList.
   */
  this()
  {
    GFileAttributeInfoList* _cretval;
    _cretval = g_file_attribute_info_list_new();
    this(_cretval, true);
  }

  /**
   * Adds a new attribute with @name to the @list, setting
   * its @type and @flags.
   */
  void add(string name, FileAttributeType type, FileAttributeInfoFlags flags)
  {
    const(char)* _name = name.toCString(false);
    g_file_attribute_info_list_add(cPtr!GFileAttributeInfoList, _name, type, flags);
  }

  /**
   * a copy of the given @list.
   */
  FileAttributeInfoList dup()
  {
    GFileAttributeInfoList* _cretval;
    _cretval = g_file_attribute_info_list_dup(cPtr!GFileAttributeInfoList);
    FileAttributeInfoList _retval = new FileAttributeInfoList(cast(GFileAttributeInfoList*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileAttributeInfo for the @name, or %NULL if an
   * attribute isn't found.
   */
  FileAttributeInfo lookup(string name)
  {
    const(GFileAttributeInfo)* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_file_attribute_info_list_lookup(cPtr!GFileAttributeInfoList, _name);
    FileAttributeInfo _retval = new FileAttributeInfo(cast(GFileAttributeInfo*)_cretval);
    return _retval;
  }
}
