module Gio.FileT;

public import GLib.Bytes;
public import GLib.ErrorG;
public import GLib.Types;
public import GLib.c.functions;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AppInfo;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.FileAttributeInfoList;
public import Gio.FileEnumerator;
public import Gio.FileIOStream;
public import Gio.FileInfo;
public import Gio.FileInputStream;
public import Gio.FileMonitor;
public import Gio.FileOutputStream;
public import Gio.Mount;
public import Gio.MountOperation;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GFile is a high level abstraction for manipulating files on a
 * virtual file system. #GFiles are lightweight, immutable objects
 * that do no I/O upon creation. It is necessary to understand that
 * #GFile objects do not represent files, merely an identifier for a
 * file. All file content I/O is implemented as streaming operations
 * (see #GInputStream and #GOutputStream).
 *
 * To construct a #GFile, you can use:
 * - g_file_new_for_path() if you have a path.
 * - g_file_new_for_uri() if you have a URI.
 * - g_file_new_for_commandline_arg() for a command line argument.
 * - g_file_new_tmp() to create a temporary file from a template.
 * - g_file_new_tmp_async() to asynchronously create a temporary file.
 * - g_file_new_tmp_dir_async() to asynchronously create a temporary directory.
 * - g_file_parse_name() from a UTF-8 string gotten from g_file_get_parse_name().
 * - g_file_new_build_filename() or g_file_new_build_filenamev() to create a file from path elements.
 *
 * One way to think of a #GFile is as an abstraction of a pathname. For
 * normal files the system pathname is what is stored internally, but as
 * #GFiles are extensible it could also be something else that corresponds
 * to a pathname in a userspace implementation of a filesystem.
 *
 * #GFiles make up hierarchies of directories and files that correspond to
 * the files on a filesystem. You can move through the file system with
 * #GFile using g_file_get_parent() to get an identifier for the parent
 * directory, g_file_get_child() to get a child within a directory,
 * g_file_resolve_relative_path() to resolve a relative path between two
 * #GFiles. There can be multiple hierarchies, so you may not end up at
 * the same root if you repeatedly call g_file_get_parent() on two different
 * files.
 *
 * All #GFiles have a basename (get with g_file_get_basename()). These names
 * are byte strings that are used to identify the file on the filesystem
 * (relative to its parent directory) and there is no guarantees that they
 * have any particular charset encoding or even make any sense at all. If
 * you want to use filenames in a user interface you should use the display
 * name that you can get by requesting the
 * %G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME attribute with g_file_query_info().
 * This is guaranteed to be in UTF-8 and can be used in a user interface.
 * But always store the real basename or the #GFile to use to actually
 * access the file, because there is no way to go from a display name to
 * the actual name.
 *
 * Using #GFile as an identifier has the same weaknesses as using a path
 * in that there may be multiple aliases for the same file. For instance,
 * hard or soft links may cause two different #GFiles to refer to the same
 * file. Other possible causes for aliases are: case insensitive filesystems,
 * short and long names on FAT/NTFS, or bind mounts in Linux. If you want to
 * check if two #GFiles point to the same file you can query for the
 * %G_FILE_ATTRIBUTE_ID_FILE attribute. Note that #GFile does some trivial
 * canonicalization of pathnames passed in, so that trivial differences in
 * the path string used at creation (duplicated slashes, slash at end of
 * path, "." or ".." path segments, etc) does not create different #GFiles.
 *
 * Many #GFile operations have both synchronous and asynchronous versions
 * to suit your application. Asynchronous versions of synchronous functions
 * simply have _async() appended to their function names. The asynchronous
 * I/O functions call a #GAsyncReadyCallback which is then used to finalize
 * the operation, producing a GAsyncResult which is then passed to the
 * function's matching _finish() operation.
 *
 * It is highly recommended to use asynchronous calls when running within a
 * shared main loop, such as in the main thread of an application. This avoids
 * I/O operations blocking other sources on the main loop from being dispatched.
 * Synchronous I/O operations should be performed from worker threads. See the
 * [introduction to asynchronous programming section][async-programming] for
 * more.
 *
 * Some #GFile operations almost always take a noticeable amount of time, and
 * so do not have synchronous analogs. Notable cases include:
 * - g_file_mount_mountable() to mount a mountable file.
 * - g_file_unmount_mountable_with_operation() to unmount a mountable file.
 * - g_file_eject_mountable_with_operation() to eject a mountable file.
 *
 * ## Entity Tags # {#gfile-etag}
 *
 * One notable feature of #GFiles are entity tags, or "etags" for
 * short. Entity tags are somewhat like a more abstract version of the
 * traditional mtime, and can be used to quickly determine if the file
 * has been modified from the version on the file system. See the
 * HTTP 1.1
 * [specification](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html)
 * for HTTP Etag headers, which are a very similar concept.
 */
template FileT(TStruct)
{

  /**
   * a new #GFile
   */
  static File newBuildFilenamev(string[] args)
  {
    GFile* _cretval;
    char*[] _tmpargs;
    foreach (s; args)
      _tmpargs ~= s.toCString(false);
    _tmpargs ~= null;
    const(char*)* _args = _tmpargs.ptr;
    _cretval = g_file_new_build_filenamev(_args);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newForCommandlineArg(string arg)
  {
    GFile* _cretval;
    const(char)* _arg = arg.toCString(false);
    _cretval = g_file_new_for_commandline_arg(_arg);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile
   */
  static File newForCommandlineArgAndCwd(string arg, string cwd)
  {
    GFile* _cretval;
    const(char)* _arg = arg.toCString(false);
    const(char)* _cwd = cwd.toCString(false);
    _cretval = g_file_new_for_commandline_arg_and_cwd(_arg, _cwd);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile for the given @path.
   * Free the returned object with g_object_unref().
   */
  static File newForPath(string path)
  {
    GFile* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_file_new_for_path(_path);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile for the given @uri.
   * Free the returned object with g_object_unref().
   */
  static File newForUri(string uri)
  {
    GFile* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = g_file_new_for_uri(_uri);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmp(string tmpl, out FileIOStream iostream)
  {
    GFile* _cretval;
    const(char)* _tmpl = tmpl.toCString(false);
    GFileIOStream* _iostream;
    GError *_err;
    _cretval = g_file_new_tmp(_tmpl, &_iostream, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    iostream = new FileIOStream(cast(void*)_iostream, true);
    return _retval;
  }

  /**
   * Asynchronously opens a file in the preferred directory for temporary files
   * (as returned by g_get_tmp_dir()) as g_file_new_tmp().
   *
   * @tmpl should be a string in the GLib file name encoding
   * containing a sequence of six 'X' characters, and containing no
   * directory components. If it is %NULL, a default template is used.
   */
  static void newTmpAsync(string tmpl, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _tmpl = tmpl.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_new_tmp_async(_tmpl, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Asynchronously creates a directory in the preferred directory for
   * temporary files (as returned by g_get_tmp_dir()) as g_dir_make_tmp().
   *
   * @tmpl should be a string in the GLib file name encoding
   * containing a sequence of six 'X' characters, and containing no
   * directory components. If it is %NULL, a default template is used.
   */
  static void newTmpDirAsync(string tmpl, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _tmpl = tmpl.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_new_tmp_dir_async(_tmpl, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmpDirFinish(AsyncResult result)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = g_file_new_tmp_dir_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmpFinish(AsyncResult result, out FileIOStream iostream)
  {
    GFile* _cretval;
    GFileIOStream* _iostream;
    GError *_err;
    _cretval = g_file_new_tmp_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_iostream, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    iostream = new FileIOStream(cast(void*)_iostream, true);
    return _retval;
  }

  /**
   * a new #GFile.
   */
  static File parseName(string parseName)
  {
    GFile* _cretval;
    const(char)* _parseName = parseName.toCString(false);
    _cretval = g_file_parse_name(_parseName);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileOutputStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream appendTo(FileCreateFlags flags, Cancellable cancellable)
  {
    GFileOutputStream* _cretval;
    GError *_err;
    _cretval = g_file_append_to(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously opens @file for appending.
   *
   * For more details, see g_file_append_to() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_append_to_finish() to get the result
   * of the operation.
   */
  override void appendToAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_append_to_async(cPtr!GFile, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a valid #GFileOutputStream
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream appendToFinish(AsyncResult res)
  {
    GFileOutputStream* _cretval;
    GError *_err;
    _cretval = g_file_append_to_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * an attribute query string for g_file_query_info(),
   * or %NULL if an error occurs.
   */
  override string buildAttributeListForCopy(FileCopyFlags flags, Cancellable cancellable)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_file_build_attribute_list_for_copy(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE otherwise.
   */
  override bool copy(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback)
  {
    static FileProgressCallback _static_progressCallback;

    extern(C) void _progressCallbackCallback(long currentNumBytes, long totalNumBytes, void* data)
    {
      _static_progressCallback(currentNumBytes, totalNumBytes);
    }

    _static_progressCallback = progressCallback;
    bool _retval;
    ptrFreezeGC(cast(void*)&progressCallback);
    GError *_err;
    _retval = g_file_copy(cPtr!GFile, destination ? (cast(ObjectG)destination).cPtr!GFile : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_progressCallbackCallback, cast(void*)&progressCallback, &_err);
    if (_err)
      throw new ErrorG(_err);
    _static_progressCallback = null;
    return _retval;
  }

  /**
   * %TRUE if the attributes were copied successfully,
   * %FALSE otherwise.
   */
  override bool copyAttributes(File destination, FileCopyFlags flags, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_copy_attributes(cPtr!GFile, destination ? (cast(ObjectG)destination).cPtr!GFile : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a %TRUE on success, %FALSE on error.
   */
  override bool copyFinish(AsyncResult res)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_copy_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GFileOutputStream for the newly created
   * file, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream create(FileCreateFlags flags, Cancellable cancellable)
  {
    GFileOutputStream* _cretval;
    GError *_err;
    _cretval = g_file_create(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously creates a new file and returns an output stream
   * for writing to it. The file must not already exist.
   *
   * For more details, see g_file_create() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_create_finish() to get the result
   * of the operation.
   */
  override void createAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_create_async(cPtr!GFile, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileOutputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream createFinish(AsyncResult res)
  {
    GFileOutputStream* _cretval;
    GError *_err;
    _cretval = g_file_create_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileIOStream for the newly created
   * file, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream createReadwrite(FileCreateFlags flags, Cancellable cancellable)
  {
    GFileIOStream* _cretval;
    GError *_err;
    _cretval = g_file_create_readwrite(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously creates a new file and returns a stream
   * for reading and writing to it. The file must not already exist.
   *
   * For more details, see g_file_create_readwrite() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_create_readwrite_finish() to get
   * the result of the operation.
   */
  override void createReadwriteAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_create_readwrite_async(cPtr!GFile, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream createReadwriteFinish(AsyncResult res)
  {
    GFileIOStream* _cretval;
    GError *_err;
    _cretval = g_file_create_readwrite_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the file was deleted. %FALSE otherwise.
   */
  override bool delete_(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_delete(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously delete a file. If the @file is a directory, it will
   * only be deleted if it is empty.  This has the same semantics as
   * g_unlink().
   */
  override void deleteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_delete_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the file was deleted. %FALSE otherwise.
   */
  override bool deleteFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_delete_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a new #GFile that is a duplicate
   * of the given #GFile.
   */
  override File dup()
  {
    GFile* _cretval;
    _cretval = g_file_dup(cPtr!GFile);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * Starts an asynchronous eject on a mountable.
   * When this operation has completed, @callback will be called with
   * @user_user data, and the operation can be finalized with
   * g_file_eject_mountable_finish().
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   */
  override void ejectMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_eject_mountable(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the @file was ejected successfully.
   * %FALSE otherwise.
   */
  override bool ejectMountableFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_eject_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Starts an asynchronous eject on a mountable.
   * When this operation has completed, @callback will be called with
   * @user_user data, and the operation can be finalized with
   * g_file_eject_mountable_with_operation_finish().
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   */
  override void ejectMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_eject_mountable_with_operation(cPtr!GFile, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the @file was ejected successfully.
   * %FALSE otherwise.
   */
  override bool ejectMountableWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_eject_mountable_with_operation_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * A #GFileEnumerator if successful,
   * %NULL on error. Free the returned object with g_object_unref().
   */
  override FileEnumerator enumerateChildren(string attributes, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    GFileEnumerator* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_enumerate_children(cPtr!GFile, _attributes, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileEnumerator _retval = ObjectG.getDObject!FileEnumerator(cast(GFileEnumerator*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the requested information about the files
   * in a directory. The result is a #GFileEnumerator object that will
   * give out #GFileInfo objects for all the files in the directory.
   *
   * For more details, see g_file_enumerate_children() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called. You can
   * then call g_file_enumerate_children_finish() to get the result of
   * the operation.
   */
  override void enumerateChildrenAsync(string attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _attributes = attributes.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_enumerate_children_async(cPtr!GFile, _attributes, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileEnumerator or %NULL
   * if an error occurred.
   * Free the returned object with g_object_unref().
   */
  override FileEnumerator enumerateChildrenFinish(AsyncResult res)
  {
    GFileEnumerator* _cretval;
    GError *_err;
    _cretval = g_file_enumerate_children_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileEnumerator _retval = ObjectG.getDObject!FileEnumerator(cast(GFileEnumerator*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @file1 and @file2 are equal.
   */
  override bool equal(File file2)
  {
    bool _retval;
    _retval = g_file_equal(cPtr!GFile, file2 ? (cast(ObjectG)file2).cPtr!GFile : null);
    return _retval;
  }

  /**
   * a #GMount where the @file is located
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override Mount findEnclosingMount(Cancellable cancellable)
  {
    GMount* _cretval;
    GError *_err;
    _cretval = g_file_find_enclosing_mount(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Mount _retval = ObjectG.getDObject!Mount(cast(GMount*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the mount for the file.
   *
   * For more details, see g_file_find_enclosing_mount() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_find_enclosing_mount_finish() to
   * get the result of the operation.
   */
  override void findEnclosingMountAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_find_enclosing_mount_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GMount for given @file or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override Mount findEnclosingMountFinish(AsyncResult res)
  {
    GMount* _cretval;
    GError *_err;
    _cretval = g_file_find_enclosing_mount_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Mount _retval = ObjectG.getDObject!Mount(cast(GMount*)_cretval, true);
    return _retval;
  }

  /**
   * string containing the #GFile's
   * base name, or %NULL if given #GFile is invalid. The returned string
   * should be freed with g_free() when no longer needed.
   */
  override string getBasename()
  {
    char* _cretval;
    _cretval = g_file_get_basename(cPtr!GFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GFile to a child specified by @name.
   * Free the returned object with g_object_unref().
   */
  override File getChild(string name)
  {
    GFile* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_file_get_child(cPtr!GFile, _name);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFile to the specified child, or
   * %NULL if the display name couldn't be converted.
   * Free the returned object with g_object_unref().
   */
  override File getChildForDisplayName(string displayName)
  {
    GFile* _cretval;
    const(char)* _displayName = displayName.toCString(false);
    GError *_err;
    _cretval = g_file_get_child_for_display_name(cPtr!GFile, _displayName, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFile structure to the
   * parent of the given #GFile or %NULL if there is no parent. Free
   * the returned object with g_object_unref().
   */
  override File getParent()
  {
    GFile* _cretval;
    _cretval = g_file_get_parent(cPtr!GFile);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a string containing the #GFile's parse name.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  override string getParseName()
  {
    char* _cretval;
    _cretval = g_file_get_parse_name(cPtr!GFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * string containing the #GFile's path,
   * or %NULL if no such path exists. The returned string should be freed
   * with g_free() when no longer needed.
   */
  override string getPath()
  {
    char* _cretval;
    _cretval = g_file_get_path(cPtr!GFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * string with the relative path from
   * @descendant to @parent, or %NULL if @descendant doesn't have @parent as
   * prefix. The returned string should be freed with g_free() when
   * no longer needed.
   */
  override string getRelativePath(File descendant)
  {
    char* _cretval;
    _cretval = g_file_get_relative_path(cPtr!GFile, descendant ? (cast(ObjectG)descendant).cPtr!GFile : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string containing the #GFile's URI. If the #GFile was constructed
   * with an invalid URI, an invalid URI is returned.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  override string getUri()
  {
    char* _cretval;
    _cretval = g_file_get_uri(cPtr!GFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string containing the URI scheme for the given
   * #GFile or %NULL if the #GFile was constructed with an invalid URI. The
   * returned string should be freed with g_free() when no longer needed.
   */
  override string getUriScheme()
  {
    char* _cretval;
    _cretval = g_file_get_uri_scheme(cPtr!GFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @file is an immediate child of @parent (or any parent in
   * the case that @parent is %NULL).
   */
  override bool hasParent(File parent)
  {
    bool _retval;
    _retval = g_file_has_parent(cPtr!GFile, parent ? (cast(ObjectG)parent).cPtr!GFile : null);
    return _retval;
  }

  /**
   * %TRUE if the @file's parent, grandparent, etc is @prefix,
   * %FALSE otherwise.
   */
  override bool hasPrefix(File prefix)
  {
    bool _retval;
    _retval = g_file_has_prefix(cPtr!GFile, prefix ? (cast(ObjectG)prefix).cPtr!GFile : null);
    return _retval;
  }

  /**
   * %TRUE if #GFile's backend supports the
   * given URI scheme, %FALSE if URI scheme is %NULL,
   * not supported, or #GFile is invalid.
   */
  override bool hasUriScheme(string uriScheme)
  {
    bool _retval;
    const(char)* _uriScheme = uriScheme.toCString(false);
    _retval = g_file_has_uri_scheme(cPtr!GFile, _uriScheme);
    return _retval;
  }

  /**
   * 0 if @file is not a valid #GFile, otherwise an
   * integer that can be used as hash value for the #GFile.
   * This function is intended for easily hashing a #GFile to
   * add to a #GHashTable or similar data structure.
   */
  override uint hash()
  {
    uint _retval;
    _retval = g_file_hash(cPtr!GFile);
    return _retval;
  }

  /**
   * %TRUE if @file is native
   */
  override bool isNative()
  {
    bool _retval;
    _retval = g_file_is_native(cPtr!GFile);
    return _retval;
  }

  /**
   * a #GBytes or %NULL and @error is set
   */
  override Bytes loadBytes(Cancellable cancellable, out string etagOut)
  {
    GBytes* _cretval;
    char* _etagOut;
    GError *_err;
    _cretval = g_file_load_bytes(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_etagOut, &_err);
    if (_err)
      throw new ErrorG(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    etagOut = _etagOut.fromCString(true);
    return _retval;
  }

  /**
   * Asynchronously loads the contents of @file as #GBytes.
   *
   * If @file is a resource:// based URI, the resulting bytes will reference the
   * embedded resource instead of a copy. Otherwise, this is equivalent to calling
   * g_file_load_contents_async() and g_bytes_new_take().
   *
   * @callback should call g_file_load_bytes_finish() to get the result of this
   * asynchronous operation.
   *
   * See g_file_load_bytes() for more information.
   */
  override void loadBytesAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_load_bytes_async(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GBytes or %NULL and @error is set
   */
  override Bytes loadBytesFinish(AsyncResult result, out string etagOut)
  {
    GBytes* _cretval;
    char* _etagOut;
    GError *_err;
    _cretval = g_file_load_bytes_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_etagOut, &_err);
    if (_err)
      throw new ErrorG(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    etagOut = _etagOut.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the @file's contents were successfully loaded.
   * %FALSE if there were errors.
   */
  override bool loadContents(Cancellable cancellable, out ubyte[] contents, out string etagOut)
  {
    bool _retval;
    ubyte* _contents;
    size_t _length;
    char* _etagOut;
    GError *_err;
    _retval = g_file_load_contents(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_contents, &_length, &_etagOut, &_err);
    if (_err)
      throw new ErrorG(_err);
    contents = _contents[0 .. _length];
    g_free(cast(void*)_contents);
    etagOut = _etagOut.fromCString(true);
    return _retval;
  }

  /**
   * Starts an asynchronous load of the @file's contents.
   *
   * For more details, see g_file_load_contents() which is
   * the synchronous version of this call.
   *
   * When the load operation has completed, @callback will be called
   * with @user data. To finish the operation, call
   * g_file_load_contents_finish() with the #GAsyncResult returned by
   * the @callback.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   */
  override void loadContentsAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_load_contents_async(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the load was successful. If %FALSE and @error is
   * present, it will be set appropriately.
   */
  override bool loadContentsFinish(AsyncResult res, out ubyte[] contents, out string etagOut)
  {
    bool _retval;
    ubyte* _contents;
    size_t _length;
    char* _etagOut;
    GError *_err;
    _retval = g_file_load_contents_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_contents, &_length, &_etagOut, &_err);
    if (_err)
      throw new ErrorG(_err);
    contents = _contents[0 .. _length];
    g_free(cast(void*)_contents);
    etagOut = _etagOut.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the load was successful. If %FALSE and @error is
   * present, it will be set appropriately.
   */
  override bool loadPartialContentsFinish(AsyncResult res, out ubyte[] contents, out string etagOut)
  {
    bool _retval;
    ubyte* _contents;
    size_t _length;
    char* _etagOut;
    GError *_err;
    _retval = g_file_load_partial_contents_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_contents, &_length, &_etagOut, &_err);
    if (_err)
      throw new ErrorG(_err);
    contents = _contents[0 .. _length];
    g_free(cast(void*)_contents);
    etagOut = _etagOut.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE on successful creation, %FALSE otherwise.
   */
  override bool makeDirectory(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_make_directory(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously creates a directory.
   */
  override void makeDirectoryAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_make_directory_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on successful directory creation, %FALSE otherwise.
   */
  override bool makeDirectoryFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_make_directory_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if all directories have been successfully created, %FALSE
   * otherwise.
   */
  override bool makeDirectoryWithParents(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_make_directory_with_parents(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on the creation of a new symlink, %FALSE otherwise.
   */
  override bool makeSymbolicLink(string symlinkValue, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _symlinkValue = symlinkValue.toCString(false);
    GError *_err;
    _retval = g_file_make_symbolic_link(cPtr!GFile, _symlinkValue, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously creates a symbolic link named @file which contains the
   * string @symlink_value.
   */
  override void makeSymbolicLinkAsync(string symlinkValue, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _symlinkValue = symlinkValue.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_make_symbolic_link_async(cPtr!GFile, _symlinkValue, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on successful directory creation, %FALSE otherwise.
   */
  override bool makeSymbolicLinkFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_make_symbolic_link_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if successful, with the out parameters set.
   * %FALSE otherwise, with @error set.
   */
  override bool measureDiskUsageFinish(AsyncResult result, out ulong diskUsage, out ulong numDirs, out ulong numFiles)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_measure_disk_usage_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(ulong*)&diskUsage, cast(ulong*)&numDirs, cast(ulong*)&numFiles, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileMonitor monitor(FileMonitorFlags flags, Cancellable cancellable)
  {
    GFileMonitor* _cretval;
    GError *_err;
    _cretval = g_file_monitor(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileMonitor _retval = ObjectG.getDObject!FileMonitor(cast(GFileMonitor*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileMonitor monitorDirectory(FileMonitorFlags flags, Cancellable cancellable)
  {
    GFileMonitor* _cretval;
    GError *_err;
    _cretval = g_file_monitor_directory(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileMonitor _retval = ObjectG.getDObject!FileMonitor(cast(GFileMonitor*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileMonitor monitorFile(FileMonitorFlags flags, Cancellable cancellable)
  {
    GFileMonitor* _cretval;
    GError *_err;
    _cretval = g_file_monitor_file(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileMonitor _retval = ObjectG.getDObject!FileMonitor(cast(GFileMonitor*)_cretval, true);
    return _retval;
  }

  /**
   * Starts a @mount_operation, mounting the volume that contains
   * the file @location.
   *
   * When this operation has completed, @callback will be called with
   * @user_user data, and the operation can be finalized with
   * g_file_mount_enclosing_volume_finish().
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   */
  override void mountEnclosingVolume(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_mount_enclosing_volume(cPtr!GFile, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if successful. If an error has occurred,
   * this function will return %FALSE and set @error
   * appropriately if present.
   */
  override bool mountEnclosingVolumeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_mount_enclosing_volume_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Mounts a file of type G_FILE_TYPE_MOUNTABLE.
   * Using @mount_operation, you can request callbacks when, for instance,
   * passwords are needed during authentication.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_mount_mountable_finish() to get
   * the result of the operation.
   */
  override void mountMountable(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_mount_mountable(cPtr!GFile, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFile or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override File mountMountableFinish(AsyncResult result)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = g_file_mount_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE on successful move, %FALSE otherwise.
   */
  override bool move(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback)
  {
    static FileProgressCallback _static_progressCallback;

    extern(C) void _progressCallbackCallback(long currentNumBytes, long totalNumBytes, void* data)
    {
      _static_progressCallback(currentNumBytes, totalNumBytes);
    }

    _static_progressCallback = progressCallback;
    bool _retval;
    ptrFreezeGC(cast(void*)&progressCallback);
    GError *_err;
    _retval = g_file_move(cPtr!GFile, destination ? (cast(ObjectG)destination).cPtr!GFile : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_progressCallbackCallback, cast(void*)&progressCallback, &_err);
    if (_err)
      throw new ErrorG(_err);
    _static_progressCallback = null;
    return _retval;
  }

  /**
   * %TRUE on successful file move, %FALSE otherwise.
   */
  override bool moveFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_move_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream openReadwrite(Cancellable cancellable)
  {
    GFileIOStream* _cretval;
    GError *_err;
    _cretval = g_file_open_readwrite(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously opens @file for reading and writing.
   *
   * For more details, see g_file_open_readwrite() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_open_readwrite_finish() to get
   * the result of the operation.
   */
  override void openReadwriteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_open_readwrite_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream openReadwriteFinish(AsyncResult res)
  {
    GFileIOStream* _cretval;
    GError *_err;
    _cretval = g_file_open_readwrite_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * string containing the #GFile's path,
   * or %NULL if no such path exists. The returned string is owned by @file.
   */
  override string peekPath()
  {
    const(char)* _cretval;
    _cretval = g_file_peek_path(cPtr!GFile);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Polls a file of type %G_FILE_TYPE_MOUNTABLE.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_mount_mountable_finish() to get
   * the result of the operation.
   */
  override void pollMountable(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_poll_mountable(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation finished successfully. %FALSE
   * otherwise.
   */
  override bool pollMountableFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_poll_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GAppInfo if the handle was found,
   * %NULL if there were errors.
   * When you are done with it, release it with g_object_unref()
   */
  override AppInfo queryDefaultHandler(Cancellable cancellable)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_file_query_default_handler(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Async version of g_file_query_default_handler().
   */
  override void queryDefaultHandlerAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_query_default_handler_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GAppInfo if the handle was found,
   * %NULL if there were errors.
   * When you are done with it, release it with g_object_unref()
   */
  override AppInfo queryDefaultHandlerFinish(AsyncResult result)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_file_query_default_handler_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the file exists (and can be detected without error),
   * %FALSE otherwise (or if cancelled).
   */
  override bool queryExists(Cancellable cancellable)
  {
    bool _retval;
    _retval = g_file_query_exists(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null);
    return _retval;
  }

  /**
   * The #GFileType of the file and %G_FILE_TYPE_UNKNOWN
   * if the file does not exist
   */
  override FileType queryFileType(FileQueryInfoFlags flags, Cancellable cancellable)
  {
    GFileType _cretval;
    _cretval = g_file_query_file_type(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null);
    FileType _retval = cast(FileType)_cretval;
    return _retval;
  }

  /**
   * a #GFileInfo or %NULL if there was an error.
   * Free the returned object with g_object_unref().
   */
  override FileInfo queryFilesystemInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_query_filesystem_info(cPtr!GFile, _attributes, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the requested information about the filesystem
   * that the specified @file is on. The result is a #GFileInfo object
   * that contains key-value attributes (such as type or size for the
   * file).
   *
   * For more details, see g_file_query_filesystem_info() which is the
   * synchronous version of this call.
   *
   * When the operation is finished, @callback will be called. You can
   * then call g_file_query_info_finish() to get the result of the
   * operation.
   */
  override void queryFilesystemInfoAsync(string attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _attributes = attributes.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_query_filesystem_info_async(cPtr!GFile, _attributes, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GFileInfo for given @file
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileInfo queryFilesystemInfoFinish(AsyncResult res)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_query_filesystem_info_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileInfo for the given @file, or %NULL
   * on error. Free the returned object with g_object_unref().
   */
  override FileInfo queryInfo(string attributes, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_query_info(cPtr!GFile, _attributes, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the requested information about specified @file.
   * The result is a #GFileInfo object that contains key-value attributes
   * (such as type or size for the file).
   *
   * For more details, see g_file_query_info() which is the synchronous
   * version of this call.
   *
   * When the operation is finished, @callback will be called. You can
   * then call g_file_query_info_finish() to get the result of the operation.
   */
  override void queryInfoAsync(string attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _attributes = attributes.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_query_info_async(cPtr!GFile, _attributes, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GFileInfo for given @file
   * or %NULL on error. Free the returned object with
   * g_object_unref().
   */
  override FileInfo queryInfoFinish(AsyncResult res)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_query_info_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileAttributeInfoList describing the settable attributes.
   * When you are done with it, release it with
   * g_file_attribute_info_list_unref()
   */
  override FileAttributeInfoList querySettableAttributes(Cancellable cancellable)
  {
    GFileAttributeInfoList* _cretval;
    GError *_err;
    _cretval = g_file_query_settable_attributes(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileAttributeInfoList _retval = new FileAttributeInfoList(cast(GFileAttributeInfoList*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileAttributeInfoList describing the writable namespaces.
   * When you are done with it, release it with
   * g_file_attribute_info_list_unref()
   */
  override FileAttributeInfoList queryWritableNamespaces(Cancellable cancellable)
  {
    GFileAttributeInfoList* _cretval;
    GError *_err;
    _cretval = g_file_query_writable_namespaces(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileAttributeInfoList _retval = new FileAttributeInfoList(cast(GFileAttributeInfoList*)_cretval, true);
    return _retval;
  }

  /**
   * #GFileInputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileInputStream read(Cancellable cancellable)
  {
    GFileInputStream* _cretval;
    GError *_err;
    _cretval = g_file_read(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInputStream _retval = ObjectG.getDObject!FileInputStream(cast(GFileInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously opens @file for reading.
   *
   * For more details, see g_file_read() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_read_finish() to get the result
   * of the operation.
   */
  override void readAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_read_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileInputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileInputStream readFinish(AsyncResult res)
  {
    GFileInputStream* _cretval;
    GError *_err;
    _cretval = g_file_read_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInputStream _retval = ObjectG.getDObject!FileInputStream(cast(GFileInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileOutputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream replace(string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable)
  {
    GFileOutputStream* _cretval;
    const(char)* _etag = etag.toCString(false);
    GError *_err;
    _cretval = g_file_replace(cPtr!GFile, _etag, makeBackup, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously overwrites the file, replacing the contents,
   * possibly creating a backup copy of the file first.
   *
   * For more details, see g_file_replace() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_replace_finish() to get the result
   * of the operation.
   */
  override void replaceAsync(string etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _etag = etag.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_replace_async(cPtr!GFile, _etag, makeBackup, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if successful. If an error has occurred, this function
   * will return %FALSE and set @error appropriately if present.
   */
  override bool replaceContents(ubyte[] contents, string etag, bool makeBackup, FileCreateFlags flags, out string newEtag, Cancellable cancellable)
  {
    bool _retval;
    auto _contents = cast(const(ubyte)*)contents.ptr;
    const(char)* _etag = etag.toCString(false);
    char* _newEtag;
    GError *_err;
    _retval = g_file_replace_contents(cPtr!GFile, _contents, contents ? cast(size_t)contents.length : 0, _etag, makeBackup, flags, &_newEtag, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    newEtag = _newEtag.fromCString(true);
    return _retval;
  }

  /**
   * Starts an asynchronous replacement of @file with the given
   * @contents of @length bytes. @etag will replace the document's
   * current entity tag.
   *
   * When this operation has completed, @callback will be called with
   * @user_user data, and the operation can be finalized with
   * g_file_replace_contents_finish().
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * If @make_backup is %TRUE, this function will attempt to
   * make a backup of @file.
   *
   * Note that no copy of @contents will be made, so it must stay valid
   * until @callback is called. See g_file_replace_contents_bytes_async()
   * for a #GBytes version that will automatically hold a reference to the
   * contents (without copying) for the duration of the call.
   */
  override void replaceContentsAsync(ubyte[] contents, string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    auto _contents = cast(const(ubyte)*)contents.ptr;
    const(char)* _etag = etag.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_replace_contents_async(cPtr!GFile, _contents, contents ? cast(size_t)contents.length : 0, _etag, makeBackup, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Same as g_file_replace_contents_async() but takes a #GBytes input instead.
   * This function will keep a ref on @contents until the operation is done.
   * Unlike g_file_replace_contents_async() this allows forgetting about the
   * content without waiting for the callback.
   *
   * When this operation has completed, @callback will be called with
   * @user_user data, and the operation can be finalized with
   * g_file_replace_contents_finish().
   */
  override void replaceContentsBytesAsync(Bytes contents, string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _etag = etag.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_replace_contents_bytes_async(cPtr!GFile, contents ? contents.cPtr!GBytes : null, _etag, makeBackup, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE on failure.
   */
  override bool replaceContentsFinish(AsyncResult res, out string newEtag)
  {
    bool _retval;
    char* _newEtag;
    GError *_err;
    _retval = g_file_replace_contents_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_newEtag, &_err);
    if (_err)
      throw new ErrorG(_err);
    newEtag = _newEtag.fromCString(true);
    return _retval;
  }

  /**
   * a #GFileOutputStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileOutputStream replaceFinish(AsyncResult res)
  {
    GFileOutputStream* _cretval;
    GError *_err;
    _cretval = g_file_replace_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileOutputStream _retval = ObjectG.getDObject!FileOutputStream(cast(GFileOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream replaceReadwrite(string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable)
  {
    GFileIOStream* _cretval;
    const(char)* _etag = etag.toCString(false);
    GError *_err;
    _cretval = g_file_replace_readwrite(cPtr!GFile, _etag, makeBackup, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously overwrites the file in read-write mode,
   * replacing the contents, possibly creating a backup copy
   * of the file first.
   *
   * For more details, see g_file_replace_readwrite() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_replace_readwrite_finish() to get
   * the result of the operation.
   */
  override void replaceReadwriteAsync(string etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _etag = etag.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_replace_readwrite_async(cPtr!GFile, _etag, makeBackup, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFileIOStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override FileIOStream replaceReadwriteFinish(AsyncResult res)
  {
    GFileIOStream* _cretval;
    GError *_err;
    _cretval = g_file_replace_readwrite_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileIOStream _retval = ObjectG.getDObject!FileIOStream(cast(GFileIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFile for the resolved path.
   */
  override File resolveRelativePath(string relativePath)
  {
    GFile* _cretval;
    const(char)* _relativePath = relativePath.toCString(false);
    _cretval = g_file_resolve_relative_path(cPtr!GFile, _relativePath);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the attribute was set, %FALSE otherwise.
   */
  override bool setAttribute(string attribute, FileAttributeType type, void* valueP, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute(cPtr!GFile, _attribute, type, valueP, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  override bool setAttributeByteString(string attribute, string value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    const(char)* _value = value.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_byte_string(cPtr!GFile, _attribute, _value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  override bool setAttributeInt32(string attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_int32(cPtr!GFile, _attribute, value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set, %FALSE otherwise.
   */
  override bool setAttributeInt64(string attribute, long value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_int64(cPtr!GFile, _attribute, value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set, %FALSE otherwise.
   */
  override bool setAttributeString(string attribute, string value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    const(char)* _value = value.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_string(cPtr!GFile, _attribute, _value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  override bool setAttributeUint32(string attribute, uint value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_uint32(cPtr!GFile, _attribute, value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  override bool setAttributeUint64(string attribute, ulong value, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    GError *_err;
    _retval = g_file_set_attribute_uint64(cPtr!GFile, _attribute, value, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously sets the attributes of @file with @info.
   *
   * For more details, see g_file_set_attributes_from_info(),
   * which is the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_set_attributes_finish() to get
   * the result of the operation.
   */
  override void setAttributesAsync(FileInfo info, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_set_attributes_async(cPtr!GFile, info ? info.cPtr!GFileInfo : null, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the attributes were set correctly, %FALSE otherwise.
   */
  override bool setAttributesFinish(AsyncResult result, out FileInfo info)
  {
    bool _retval;
    GFileInfo* _info;
    GError *_err;
    _retval = g_file_set_attributes_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_info, &_err);
    if (_err)
      throw new ErrorG(_err);
    info = new FileInfo(cast(void*)_info, true);
    return _retval;
  }

  /**
   * %FALSE if there was any error, %TRUE otherwise.
   */
  override bool setAttributesFromInfo(FileInfo info, FileQueryInfoFlags flags, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_set_attributes_from_info(cPtr!GFile, info ? info.cPtr!GFileInfo : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GFile specifying what @file was renamed to,
   * or %NULL if there was an error.
   * Free the returned object with g_object_unref().
   */
  override File setDisplayName(string displayName, Cancellable cancellable)
  {
    GFile* _cretval;
    const(char)* _displayName = displayName.toCString(false);
    GError *_err;
    _cretval = g_file_set_display_name(cPtr!GFile, _displayName, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously sets the display name for a given #GFile.
   *
   * For more details, see g_file_set_display_name() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_set_display_name_finish() to get
   * the result of the operation.
   */
  override void setDisplayNameAsync(string displayName, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _displayName = displayName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_set_display_name_async(cPtr!GFile, _displayName, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GFile or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  override File setDisplayNameFinish(AsyncResult res)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = g_file_set_display_name_finish(cPtr!GFile, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * Starts a file of type %G_FILE_TYPE_MOUNTABLE.
   * Using @start_operation, you can request callbacks when, for instance,
   * passwords are needed during authentication.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_mount_mountable_finish() to get
   * the result of the operation.
   */
  override void startMountable(DriveStartFlags flags, MountOperation startOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_start_mountable(cPtr!GFile, flags, startOperation ? startOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation finished successfully. %FALSE
   * otherwise.
   */
  override bool startMountableFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_start_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Stops a file of type %G_FILE_TYPE_MOUNTABLE.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_stop_mountable_finish() to get
   * the result of the operation.
   */
  override void stopMountable(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_stop_mountable(cPtr!GFile, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  override bool stopMountableFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_stop_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Whether or not @file supports thread-default contexts.
   */
  override bool supportsThreadContexts()
  {
    bool _retval;
    _retval = g_file_supports_thread_contexts(cPtr!GFile);
    return _retval;
  }

  /**
   * %TRUE on successful trash, %FALSE otherwise.
   */
  override bool trash(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_trash(cPtr!GFile, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously sends @file to the Trash location, if possible.
   */
  override void trashAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_trash_async(cPtr!GFile, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on successful trash, %FALSE otherwise.
   */
  override bool trashFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_trash_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Unmounts a file of type G_FILE_TYPE_MOUNTABLE.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_unmount_mountable_finish() to get
   * the result of the operation.
   */
  override void unmountMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_unmount_mountable(cPtr!GFile, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  override bool unmountMountableFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_unmount_mountable_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Unmounts a file of type %G_FILE_TYPE_MOUNTABLE.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_file_unmount_mountable_finish() to get
   * the result of the operation.
   */
  override void unmountMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_unmount_mountable_with_operation(cPtr!GFile, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  override bool unmountMountableWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_unmount_mountable_with_operation_finish(cPtr!GFile, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
