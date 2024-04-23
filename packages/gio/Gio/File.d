module Gio.File;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileAttributeInfoList;
import Gio.FileEnumerator;
import Gio.FileIOStream;
import Gio.FileInfo;
import Gio.FileInputStream;
import Gio.FileMonitor;
import Gio.FileOutputStream;
import Gio.Mount;
import Gio.MountOperation;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface File
{

  static GType getType()
  {
    return g_file_get_type();
  }

  /**
   * a new #GFile
   */
  static File newBuildFilenamev(string[] args);

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newForCommandlineArg(string arg);

  /**
   * a new #GFile
   */
  static File newForCommandlineArgAndCwd(string arg, string cwd);

  /**
   * a new #GFile for the given @path.
   * Free the returned object with g_object_unref().
   */
  static File newForPath(string path);

  /**
   * a new #GFile for the given @uri.
   * Free the returned object with g_object_unref().
   */
  static File newForUri(string uri);

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmp(string tmpl, out FileIOStream iostream);

  /**
   * Asynchronously opens a file in the preferred directory for temporary files
   * (as returned by g_get_tmp_dir()) as g_file_new_tmp().
   *
   * @tmpl should be a string in the GLib file name encoding
   * containing a sequence of six 'X' characters, and containing no
   * directory components. If it is %NULL, a default template is used.
   */
  static void newTmpAsync(string tmpl, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Asynchronously creates a directory in the preferred directory for
   * temporary files (as returned by g_get_tmp_dir()) as g_dir_make_tmp().
   *
   * @tmpl should be a string in the GLib file name encoding
   * containing a sequence of six 'X' characters, and containing no
   * directory components. If it is %NULL, a default template is used.
   */
  static void newTmpDirAsync(string tmpl, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmpDirFinish(AsyncResult result);

  /**
   * a new #GFile.
   * Free the returned object with g_object_unref().
   */
  static File newTmpFinish(AsyncResult result, out FileIOStream iostream);

  /**
   * a new #GFile.
   */
  static File parseName(string parseName);

  /**
   * a #GFileOutputStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream appendTo(FileCreateFlags flags, Cancellable cancellable);

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
  void appendToAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a valid #GFileOutputStream
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream appendToFinish(AsyncResult res);

  /**
   * an attribute query string for g_file_query_info(),
   * or %NULL if an error occurs.
   */
  string buildAttributeListForCopy(FileCopyFlags flags, Cancellable cancellable);

  /**
   * %TRUE on success, %FALSE otherwise.
   */
  bool copy(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback);

  /**
   * %TRUE if the attributes were copied successfully,
   * %FALSE otherwise.
   */
  bool copyAttributes(File destination, FileCopyFlags flags, Cancellable cancellable);

  /**
   * a %TRUE on success, %FALSE on error.
   */
  bool copyFinish(AsyncResult res);

  /**
   * a #GFileOutputStream for the newly created
   * file, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream create(FileCreateFlags flags, Cancellable cancellable);

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
  void createAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileOutputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream createFinish(AsyncResult res);

  /**
   * a #GFileIOStream for the newly created
   * file, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream createReadwrite(FileCreateFlags flags, Cancellable cancellable);

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
  void createReadwriteAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream createReadwriteFinish(AsyncResult res);

  /**
   * %TRUE if the file was deleted. %FALSE otherwise.
   */
  bool delete_(Cancellable cancellable);

  /**
   * Asynchronously delete a file. If the @file is a directory, it will
   * only be deleted if it is empty.  This has the same semantics as
   * g_unlink().
   */
  void deleteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the file was deleted. %FALSE otherwise.
   */
  bool deleteFinish(AsyncResult result);

  /**
   * a new #GFile that is a duplicate
   * of the given #GFile.
   */
  File dup();

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
  void ejectMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the @file was ejected successfully.
   * %FALSE otherwise.
   */
  bool ejectMountableFinish(AsyncResult result);

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
  void ejectMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the @file was ejected successfully.
   * %FALSE otherwise.
   */
  bool ejectMountableWithOperationFinish(AsyncResult result);

  /**
   * A #GFileEnumerator if successful,
   * %NULL on error. Free the returned object with g_object_unref().
   */
  FileEnumerator enumerateChildren(string attributes, FileQueryInfoFlags flags, Cancellable cancellable);

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
  void enumerateChildrenAsync(string attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileEnumerator or %NULL
   * if an error occurred.
   * Free the returned object with g_object_unref().
   */
  FileEnumerator enumerateChildrenFinish(AsyncResult res);

  /**
   * %TRUE if @file1 and @file2 are equal.
   */
  bool equal(File file2);

  /**
   * a #GMount where the @file is located
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  Mount findEnclosingMount(Cancellable cancellable);

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
  void findEnclosingMountAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * #GMount for given @file or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  Mount findEnclosingMountFinish(AsyncResult res);

  /**
   * string containing the #GFile's
   * base name, or %NULL if given #GFile is invalid. The returned string
   * should be freed with g_free() when no longer needed.
   */
  string getBasename();

  /**
   * a #GFile to a child specified by @name.
   * Free the returned object with g_object_unref().
   */
  File getChild(string name);

  /**
   * a #GFile to the specified child, or
   * %NULL if the display name couldn't be converted.
   * Free the returned object with g_object_unref().
   */
  File getChildForDisplayName(string displayName);

  /**
   * a #GFile structure to the
   * parent of the given #GFile or %NULL if there is no parent. Free
   * the returned object with g_object_unref().
   */
  File getParent();

  /**
   * a string containing the #GFile's parse name.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  string getParseName();

  /**
   * string containing the #GFile's path,
   * or %NULL if no such path exists. The returned string should be freed
   * with g_free() when no longer needed.
   */
  string getPath();

  /**
   * string with the relative path from
   * @descendant to @parent, or %NULL if @descendant doesn't have @parent as
   * prefix. The returned string should be freed with g_free() when
   * no longer needed.
   */
  string getRelativePath(File descendant);

  /**
   * a string containing the #GFile's URI. If the #GFile was constructed
   * with an invalid URI, an invalid URI is returned.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  string getUri();

  /**
   * a string containing the URI scheme for the given
   * #GFile or %NULL if the #GFile was constructed with an invalid URI. The
   * returned string should be freed with g_free() when no longer needed.
   */
  string getUriScheme();

  /**
   * %TRUE if @file is an immediate child of @parent (or any parent in
   * the case that @parent is %NULL).
   */
  bool hasParent(File parent);

  /**
   * %TRUE if the @file's parent, grandparent, etc is @prefix,
   * %FALSE otherwise.
   */
  bool hasPrefix(File prefix);

  /**
   * %TRUE if #GFile's backend supports the
   * given URI scheme, %FALSE if URI scheme is %NULL,
   * not supported, or #GFile is invalid.
   */
  bool hasUriScheme(string uriScheme);

  /**
   * 0 if @file is not a valid #GFile, otherwise an
   * integer that can be used as hash value for the #GFile.
   * This function is intended for easily hashing a #GFile to
   * add to a #GHashTable or similar data structure.
   */
  uint hash();

  /**
   * %TRUE if @file is native
   */
  bool isNative();

  /**
   * a #GBytes or %NULL and @error is set
   */
  Bytes loadBytes(Cancellable cancellable, out string etagOut);

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
  void loadBytesAsync(Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GBytes or %NULL and @error is set
   */
  Bytes loadBytesFinish(AsyncResult result, out string etagOut);

  /**
   * %TRUE if the @file's contents were successfully loaded.
   * %FALSE if there were errors.
   */
  bool loadContents(Cancellable cancellable, out ubyte[] contents, out string etagOut);

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
  void loadContentsAsync(Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the load was successful. If %FALSE and @error is
   * present, it will be set appropriately.
   */
  bool loadContentsFinish(AsyncResult res, out ubyte[] contents, out string etagOut);

  /**
   * %TRUE if the load was successful. If %FALSE and @error is
   * present, it will be set appropriately.
   */
  bool loadPartialContentsFinish(AsyncResult res, out ubyte[] contents, out string etagOut);

  /**
   * %TRUE on successful creation, %FALSE otherwise.
   */
  bool makeDirectory(Cancellable cancellable);

  /**
   * Asynchronously creates a directory.
   */
  void makeDirectoryAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on successful directory creation, %FALSE otherwise.
   */
  bool makeDirectoryFinish(AsyncResult result);

  /**
   * %TRUE if all directories have been successfully created, %FALSE
   * otherwise.
   */
  bool makeDirectoryWithParents(Cancellable cancellable);

  /**
   * %TRUE on the creation of a new symlink, %FALSE otherwise.
   */
  bool makeSymbolicLink(string symlinkValue, Cancellable cancellable);

  /**
   * Asynchronously creates a symbolic link named @file which contains the
   * string @symlink_value.
   */
  void makeSymbolicLinkAsync(string symlinkValue, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on successful directory creation, %FALSE otherwise.
   */
  bool makeSymbolicLinkFinish(AsyncResult result);

  /**
   * %TRUE if successful, with the out parameters set.
   * %FALSE otherwise, with @error set.
   */
  bool measureDiskUsageFinish(AsyncResult result, out ulong diskUsage, out ulong numDirs, out ulong numFiles);

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileMonitor monitor(FileMonitorFlags flags, Cancellable cancellable);

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileMonitor monitorDirectory(FileMonitorFlags flags, Cancellable cancellable);

  /**
   * a #GFileMonitor for the given @file,
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileMonitor monitorFile(FileMonitorFlags flags, Cancellable cancellable);

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
  void mountEnclosingVolume(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if successful. If an error has occurred,
   * this function will return %FALSE and set @error
   * appropriately if present.
   */
  bool mountEnclosingVolumeFinish(AsyncResult result);

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
  void mountMountable(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFile or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  File mountMountableFinish(AsyncResult result);

  /**
   * %TRUE on successful move, %FALSE otherwise.
   */
  bool move(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback);

  /**
   * %TRUE on successful file move, %FALSE otherwise.
   */
  bool moveFinish(AsyncResult result);

  /**
   * #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream openReadwrite(Cancellable cancellable);

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
  void openReadwriteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream openReadwriteFinish(AsyncResult res);

  /**
   * string containing the #GFile's path,
   * or %NULL if no such path exists. The returned string is owned by @file.
   */
  string peekPath();

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
  void pollMountable(Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the operation finished successfully. %FALSE
   * otherwise.
   */
  bool pollMountableFinish(AsyncResult result);

  /**
   * a #GAppInfo if the handle was found,
   * %NULL if there were errors.
   * When you are done with it, release it with g_object_unref()
   */
  AppInfo queryDefaultHandler(Cancellable cancellable);

  /**
   * Async version of g_file_query_default_handler().
   */
  void queryDefaultHandlerAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GAppInfo if the handle was found,
   * %NULL if there were errors.
   * When you are done with it, release it with g_object_unref()
   */
  AppInfo queryDefaultHandlerFinish(AsyncResult result);

  /**
   * %TRUE if the file exists (and can be detected without error),
   * %FALSE otherwise (or if cancelled).
   */
  bool queryExists(Cancellable cancellable);

  /**
   * The #GFileType of the file and %G_FILE_TYPE_UNKNOWN
   * if the file does not exist
   */
  FileType queryFileType(FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * a #GFileInfo or %NULL if there was an error.
   * Free the returned object with g_object_unref().
   */
  FileInfo queryFilesystemInfo(string attributes, Cancellable cancellable);

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
  void queryFilesystemInfoAsync(string attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * #GFileInfo for given @file
   * or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileInfo queryFilesystemInfoFinish(AsyncResult res);

  /**
   * a #GFileInfo for the given @file, or %NULL
   * on error. Free the returned object with g_object_unref().
   */
  FileInfo queryInfo(string attributes, FileQueryInfoFlags flags, Cancellable cancellable);

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
  void queryInfoAsync(string attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * #GFileInfo for given @file
   * or %NULL on error. Free the returned object with
   * g_object_unref().
   */
  FileInfo queryInfoFinish(AsyncResult res);

  /**
   * a #GFileAttributeInfoList describing the settable attributes.
   * When you are done with it, release it with
   * g_file_attribute_info_list_unref()
   */
  FileAttributeInfoList querySettableAttributes(Cancellable cancellable);

  /**
   * a #GFileAttributeInfoList describing the writable namespaces.
   * When you are done with it, release it with
   * g_file_attribute_info_list_unref()
   */
  FileAttributeInfoList queryWritableNamespaces(Cancellable cancellable);

  /**
   * #GFileInputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileInputStream read(Cancellable cancellable);

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
  void readAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileInputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileInputStream readFinish(AsyncResult res);

  /**
   * a #GFileOutputStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream replace(string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable);

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
  void replaceAsync(string etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if successful. If an error has occurred, this function
   * will return %FALSE and set @error appropriately if present.
   */
  bool replaceContents(ubyte[] contents, string etag, bool makeBackup, FileCreateFlags flags, out string newEtag, Cancellable cancellable);

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
  void replaceContentsAsync(ubyte[] contents, string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

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
  void replaceContentsBytesAsync(Bytes contents, string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on success, %FALSE on failure.
   */
  bool replaceContentsFinish(AsyncResult res, out string newEtag);

  /**
   * a #GFileOutputStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileOutputStream replaceFinish(AsyncResult res);

  /**
   * a #GFileIOStream or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream replaceReadwrite(string etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable);

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
  void replaceReadwriteAsync(string etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFileIOStream, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  FileIOStream replaceReadwriteFinish(AsyncResult res);

  /**
   * a #GFile for the resolved path.
   */
  File resolveRelativePath(string relativePath);

  /**
   * %TRUE if the attribute was set, %FALSE otherwise.
   */
  bool setAttribute(string attribute, FileAttributeType type, void* valueP, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  bool setAttributeByteString(string attribute, string value, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  bool setAttributeInt32(string attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set, %FALSE otherwise.
   */
  bool setAttributeInt64(string attribute, long value, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set, %FALSE otherwise.
   */
  bool setAttributeString(string attribute, string value, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  bool setAttributeUint32(string attribute, uint value, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * %TRUE if the @attribute was successfully set to @value
   * in the @file, %FALSE otherwise.
   */
  bool setAttributeUint64(string attribute, ulong value, FileQueryInfoFlags flags, Cancellable cancellable);

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
  void setAttributesAsync(FileInfo info, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the attributes were set correctly, %FALSE otherwise.
   */
  bool setAttributesFinish(AsyncResult result, out FileInfo info);

  /**
   * %FALSE if there was any error, %TRUE otherwise.
   */
  bool setAttributesFromInfo(FileInfo info, FileQueryInfoFlags flags, Cancellable cancellable);

  /**
   * a #GFile specifying what @file was renamed to,
   * or %NULL if there was an error.
   * Free the returned object with g_object_unref().
   */
  File setDisplayName(string displayName, Cancellable cancellable);

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
  void setDisplayNameAsync(string displayName, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GFile or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  File setDisplayNameFinish(AsyncResult res);

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
  void startMountable(DriveStartFlags flags, MountOperation startOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the operation finished successfully. %FALSE
   * otherwise.
   */
  bool startMountableFinish(AsyncResult result);

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
  void stopMountable(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  bool stopMountableFinish(AsyncResult result);

  /**
   * Whether or not @file supports thread-default contexts.
   */
  bool supportsThreadContexts();

  /**
   * %TRUE on successful trash, %FALSE otherwise.
   */
  bool trash(Cancellable cancellable);

  /**
   * Asynchronously sends @file to the Trash location, if possible.
   */
  void trashAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on successful trash, %FALSE otherwise.
   */
  bool trashFinish(AsyncResult result);

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
  void unmountMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  bool unmountMountableFinish(AsyncResult result);

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
  void unmountMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the operation finished successfully.
   * %FALSE otherwise.
   */
  bool unmountMountableWithOperationFinish(AsyncResult result);
}
