module Gio.FileEnumerator;

import GLib.ErrorG;
import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.File;
import Gio.FileInfo;
import Gio.FileT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GFileEnumerator` allows you to operate on a set of [Gio.File] objects,
 * returning a [Gio.FileInfo] structure for each file enumerated $(LPAREN)e.g.
 * [Gio.File.enumerateChildren] will return a `GFileEnumerator` for each
 * of the children within a directory$(RPAREN).
 * To get the next file's information from a `GFileEnumerator`, use
 * [Gio.FileEnumerator.nextFile] or its asynchronous version,
 * [Gio.FileEnumerator.nextFilesAsync]. Note that the asynchronous
 * version will return a list of [Gio.FileInfo] objects, whereas the
 * synchronous will only return the next file in the enumerator.
 * The ordering of returned files is unspecified for non-Unix
 * platforms; for more information, see [GLib.Dir.readName].  On Unix,
 * when operating on local files, returned files will be sorted by
 * inode number.  Effectively you can assume that the ordering of
 * returned files will be stable between successive calls $(LPAREN)and
 * applications$(RPAREN) assuming the directory is unchanged.
 * If your application needs a specific ordering, such as by name or
 * modification time, you will have to implement that in your
 * application code.
 * To close a `GFileEnumerator`, use [Gio.FileEnumerator.close], or
 * its asynchronous version, [Gio.FileEnumerator.closeAsync]. Once
 * a `GFileEnumerator` is closed, no further actions may be performed
 * on it, and it should be freed with [GObject.ObjectG.unref].
 */
class FileEnumerator : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_enumerator_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Releases all resources used by this enumerator, making the
   * enumerator return %G_IO_ERROR_CLOSED on all calls.
   * This will be automatically called when the last reference
   * is dropped, but you might want to call this function to make
   * sure resources are released as early as possible.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: #TRUE on success or #FALSE on error.
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_enumerator_close(cast(GFileEnumerator*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously closes the file enumerator.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned in
   * [Gio.FileEnumerator.closeFinish].
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_file_enumerator_close_async(cast(GFileEnumerator*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes closing a file enumerator, started from [Gio.FileEnumerator.closeAsync].
   * If the file enumerator was already closed when [Gio.FileEnumerator.closeAsync]
   * was called, then this function will report %G_IO_ERROR_CLOSED in error, and
   * return %FALSE. If the file enumerator had pending operation when the close
   * operation was started, then this function will report %G_IO_ERROR_PENDING, and
   * return %FALSE.  If cancellable was not %NULL, then the operation may have been
   * cancelled by triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be set, and %FALSE will be
   * returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the close operation has finished successfully.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_enumerator_close_finish(cast(GFileEnumerator*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Return a new #GFile which refers to the file named by info in the source
   * directory of enumerator.  This function is primarily intended to be used
   * inside loops with [Gio.FileEnumerator.nextFile].
   * To use this, %G_FILE_ATTRIBUTE_STANDARD_NAME must have been listed in the
   * attributes list used when creating the #GFileEnumerator.
   * This is a convenience method that's equivalent to:
   * |[<!-- language\="C" -->
   * gchar *name \= g_file_info_get_name $(LPAREN)info$(RPAREN);
   * GFile *child \= g_file_get_child $(LPAREN)g_file_enumerator_get_container $(LPAREN)enumr$(RPAREN),
   * name$(RPAREN);
   * ]|
   * Params:
   *   info = a #GFileInfo gotten from [Gio.FileEnumerator.nextFile]
   *     or the async equivalents.
   * Returns: a #GFile for the #GFileInfo passed it.
   */
  File getChild(FileInfo info)
  {
    GFile* _cretval;
    _cretval = g_file_enumerator_get_child(cast(GFileEnumerator*)cPtr, info ? cast(GFileInfo*)info.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get the #GFile container which is being enumerated.
   * Returns: the #GFile which is being enumerated.
   */
  File getContainer()
  {
    GFile* _cretval;
    _cretval = g_file_enumerator_get_container(cast(GFileEnumerator*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if the file enumerator has pending operations.
   * Returns: %TRUE if the enumerator has pending operations.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_file_enumerator_has_pending(cast(GFileEnumerator*)cPtr);
    return _retval;
  }

  /**
   * Checks if the file enumerator has been closed.
   * Returns: %TRUE if the enumerator is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_file_enumerator_is_closed(cast(GFileEnumerator*)cPtr);
    return _retval;
  }

  /**
   * This is a version of [Gio.FileEnumerator.nextFile] that's easier to
   * use correctly from C programs.  With [Gio.FileEnumerator.nextFile],
   * the gboolean return value signifies "end of iteration or error", which
   * requires allocation of a temporary #GError.
   * In contrast, with this function, a %FALSE return from
   * [Gio.FileEnumerator.iterate] *always* means
   * "error".  End of iteration is signaled by out_info or out_child being %NULL.
   * Another crucial difference is that the references for out_info and
   * out_child are owned by direnum $(LPAREN)they are cached as hidden
   * properties$(RPAREN).  You must not unref them in your own code.  This makes
   * memory management significantly easier for C code in combination
   * with loops.
   * Finally, this function optionally allows retrieving a #GFile as
   * well.
   * You must specify at least one of out_info or out_child.
   * The code pattern for correctly using [Gio.FileEnumerator.iterate] from C
   * is:
   * |[
   * direnum \= g_file_enumerate_children $(LPAREN)file, ...$(RPAREN);
   * while $(LPAREN)TRUE$(RPAREN)
   * {
   * GFileInfo *info;
   * if $(LPAREN)!g_file_enumerator_iterate $(LPAREN)direnum, &info, NULL, cancellable, error$(RPAREN)$(RPAREN)
   * goto out;
   * if $(LPAREN)!info$(RPAREN)
   * break;
   * ... do stuff with "info"; do not unref it! ...
   * }
   * out:
   * g_object_unref $(LPAREN)direnum$(RPAREN); // Note: frees the last info
   * ]|
   * Params:
   *   outInfo = Output location for the next #GFileInfo, or %NULL
   *   outChild = Output location for the next #GFile, or %NULL
   *   cancellable = a #GCancellable
   * Returns:
   */
  bool iterate(out FileInfo outInfo, out File outChild, Cancellable cancellable)
  {
    bool _retval;
    GFileInfo* _outInfo;
    GFile* _outChild;
    GError *_err;
    _retval = g_file_enumerator_iterate(cast(GFileEnumerator*)cPtr, &_outInfo, &_outChild, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    outInfo = new FileInfo(cast(void*)_outInfo, false);
    outChild = _outChild ? ObjectG.getDObject!File(_outChild, false) : null;
    return _retval;
  }

  /**
   * Returns information for the next file in the enumerated object.
   * Will block until the information is available. The #GFileInfo
   * returned from this function will contain attributes that match the
   * attribute string that was passed when the #GFileEnumerator was created.
   * See the documentation of #GFileEnumerator for information about the
   * order of returned files.
   * On error, returns %NULL and sets error to the error. If the
   * enumerator is at the end, %NULL will be returned and error will
   * be unset.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: A #GFileInfo or %NULL on error
   *   or end of enumerator.  Free the returned object with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  FileInfo nextFile(Cancellable cancellable)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_enumerator_next_file(cast(GFileEnumerator*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Request information for a number of files from the enumerator asynchronously.
   * When all I/O for the operation is finished the callback will be called with
   * the requested information.
   * See the documentation of #GFileEnumerator for information about the
   * order of returned files.
   * Once the end of the enumerator is reached, or if an error occurs, the
   * callback will be called with an empty list. In this case, the previous call
   * to [Gio.FileEnumerator.nextFilesAsync] will typically have returned fewer
   * than num_files items.
   * If a request is cancelled the callback will be called with
   * %G_IO_ERROR_CANCELLED.
   * This leads to the following pseudo-code usage:
   * |[
   * g_autoptr$(LPAREN)GFile$(RPAREN) dir \= get_directory $(LPAREN)$(RPAREN);
   * g_autoptr$(LPAREN)GFileEnumerator$(RPAREN) enumerator \= NULL;
   * g_autolist$(LPAREN)GFileInfo$(RPAREN) files \= NULL;
   * g_autoptr$(LPAREN)GError$(RPAREN) local_error \= NULL;
   * enumerator \= yield g_file_enumerate_children_async $(LPAREN)dir,
   * G_FILE_ATTRIBUTE_STANDARD_NAME ","
   * G_FILE_ATTRIBUTE_STANDARD_TYPE,
   * G_FILE_QUERY_INFO_NONE,
   * G_PRIORITY_DEFAULT,
   * cancellable,
   * …,
   * &local_error$(RPAREN);
   * if $(LPAREN)enumerator \=\= NULL$(RPAREN)
   * g_error $(LPAREN)"Error enumerating: %s", local_error->message$(RPAREN);
   * // Loop until no files are returned, either because the end of the enumerator
   * // has been reached, or an error was returned.
   * do
   * {
   * files \= yield g_file_enumerator_next_files_async $(LPAREN)enumerator,
   * 5,  // number of files to request
   * G_PRIORITY_DEFAULT,
   * cancellable,
   * …,
   * &local_error$(RPAREN);
   * // Process the returned files, but don’t assume that exactly 5 were returned.
   * for $(LPAREN)GList *l \= files; l !\= NULL; l \= l->next$(RPAREN)
   * {
   * GFileInfo *info \= l->data;
   * handle_file_info $(LPAREN)info$(RPAREN);
   * }
   * }
   * while $(LPAREN)files !\= NULL$(RPAREN);
   * if $(LPAREN)local_error !\= NULL &&
   * !g_error_matches $(LPAREN)local_error, G_IO_ERROR, G_IO_ERROR_CANCELLED$(RPAREN)$(RPAREN)
   * g_error $(LPAREN)"Error while enumerating: %s", local_error->message$(RPAREN);
   * ]|
   * During an async request no other sync and async calls are allowed, and will
   * result in %G_IO_ERROR_PENDING errors.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical value$(RPAREN) will
   * be executed before an outstanding request with lower priority. Default
   * priority is %G_PRIORITY_DEFAULT.
   * Params:
   *   numFiles = the number of file info objects to request
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void nextFilesAsync(int numFiles, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_file_enumerator_next_files_async(cast(GFileEnumerator*)cPtr, numFiles, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the asynchronous operation started with [Gio.FileEnumerator.nextFilesAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GList of #GFileInfos. You must free the list with
   *   [GLib.List.free] and unref the infos with [GObject.ObjectG.unref] when you're
   *   done with them.
   */
  List!(FileInfo) nextFilesFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_file_enumerator_next_files_finish(cast(GFileEnumerator*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(FileInfo) _retval = new List!(FileInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Sets the file enumerator as having pending operations.
   * Params:
   *   pending = a boolean value.
   */
  void setPending(bool pending)
  {
    g_file_enumerator_set_pending(cast(GFileEnumerator*)cPtr, pending);
  }
}
