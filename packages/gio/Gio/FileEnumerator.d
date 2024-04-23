module Gio.FileEnumerator;

import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.File;
import Gio.FileInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GFileEnumerator allows you to operate on a set of #GFiles,
 * returning a #GFileInfo structure for each file enumerated (e.g.
 * g_file_enumerate_children() will return a #GFileEnumerator for each
 * of the children within a directory).
 *
 * To get the next file's information from a #GFileEnumerator, use
 * g_file_enumerator_next_file() or its asynchronous version,
 * g_file_enumerator_next_files_async(). Note that the asynchronous
 * version will return a list of #GFileInfos, whereas the
 * synchronous will only return the next file in the enumerator.
 *
 * The ordering of returned files is unspecified for non-Unix
 * platforms; for more information, see g_dir_read_name().  On Unix,
 * when operating on local files, returned files will be sorted by
 * inode number.  Effectively you can assume that the ordering of
 * returned files will be stable between successive calls (and
 * applications) assuming the directory is unchanged.
 *
 * If your application needs a specific ordering, such as by name or
 * modification time, you will have to implement that in your
 * application code.
 *
 * To close a #GFileEnumerator, use g_file_enumerator_close(), or
 * its asynchronous version, g_file_enumerator_close_async(). Once
 * a #GFileEnumerator is closed, no further actions may be performed
 * on it, and it should be freed with g_object_unref().
 */
class FileEnumerator : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_enumerator_get_type();
  }

  /**
   * #TRUE on success or #FALSE on error.
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_enumerator_close(cPtr!GFileEnumerator, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously closes the file enumerator.
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned in
   * g_file_enumerator_close_finish().
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_enumerator_close_async(cPtr!GFileEnumerator, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the close operation has finished successfully.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_file_enumerator_close_finish(cPtr!GFileEnumerator, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GFile for the #GFileInfo passed it.
   */
  File getChild(FileInfo info)
  {
    GFile* _cretval;
    _cretval = g_file_enumerator_get_child(cPtr!GFileEnumerator, info ? info.cPtr!GFileInfo : null);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * the #GFile which is being enumerated.
   */
  File getContainer()
  {
    GFile* _cretval;
    _cretval = g_file_enumerator_get_container(cPtr!GFileEnumerator);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the @enumerator has pending operations.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_file_enumerator_has_pending(cPtr!GFileEnumerator);
    return _retval;
  }

  /**
   * %TRUE if the @enumerator is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_file_enumerator_is_closed(cPtr!GFileEnumerator);
    return _retval;
  }

  /**
   * This is a version of g_file_enumerator_next_file() that's easier to
   * use correctly from C programs.  With g_file_enumerator_next_file(),
   * the gboolean return value signifies "end of iteration or error", which
   * requires allocation of a temporary #GError.
   *
   * In contrast, with this function, a %FALSE return from
   * g_file_enumerator_iterate() *always* means
   * "error".  End of iteration is signaled by @out_info or @out_child being %NULL.
   *
   * Another crucial difference is that the references for @out_info and
   * @out_child are owned by @direnum (they are cached as hidden
   * properties).  You must not unref them in your own code.  This makes
   * memory management significantly easier for C code in combination
   * with loops.
   *
   * Finally, this function optionally allows retrieving a #GFile as
   * well.
   *
   * You must specify at least one of @out_info or @out_child.
   *
   * The code pattern for correctly using g_file_enumerator_iterate() from C
   * is:
   *
   * |[
   * direnum = g_file_enumerate_children (file, ...);
   * while (TRUE)
   * {
   * GFileInfo *info;
   * if (!g_file_enumerator_iterate (direnum, &info, NULL, cancellable, error))
   * goto out;
   * if (!info)
   * break;
   * ... do stuff with "info"; do not unref it! ...
   * }
   *
   * out:
   * g_object_unref (direnum); // Note: frees the last @info
   * ]|
   */
  bool iterate(out FileInfo outInfo, out File outChild, Cancellable cancellable)
  {
    bool _retval;
    GFileInfo* _outInfo;
    GFile* _outChild;
    GError *_err;
    _retval = g_file_enumerator_iterate(cPtr!GFileEnumerator, &_outInfo, &_outChild, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    outInfo = new FileInfo(cast(void*)_outInfo, false);
    outChild = _outChild ? ObjectG.getDObject!File(_outChild, false) : null;
    return _retval;
  }

  /**
   * A #GFileInfo or %NULL on error
   * or end of enumerator.  Free the returned object with
   * g_object_unref() when no longer needed.
   */
  FileInfo nextFile(Cancellable cancellable)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_enumerator_next_file(cPtr!GFileEnumerator, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Request information for a number of files from the enumerator asynchronously.
   * When all I/O for the operation is finished the @callback will be called with
   * the requested information.
   *
   * See the documentation of #GFileEnumerator for information about the
   * order of returned files.
   *
   * Once the end of the enumerator is reached, or if an error occurs, the
   * @callback will be called with an empty list. In this case, the previous call
   * to g_file_enumerator_next_files_async() will typically have returned fewer
   * than @num_files items.
   *
   * If a request is cancelled the callback will be called with
   * %G_IO_ERROR_CANCELLED.
   *
   * This leads to the following pseudo-code usage:
   * |[
   * g_autoptr(GFile) dir = get_directory ();
   * g_autoptr(GFileEnumerator) enumerator = NULL;
   * g_autolist(GFileInfo) files = NULL;
   * g_autoptr(GError) local_error = NULL;
   *
   * enumerator = yield g_file_enumerate_children_async (dir,
   * G_FILE_ATTRIBUTE_STANDARD_NAME ","
   * G_FILE_ATTRIBUTE_STANDARD_TYPE,
   * G_FILE_QUERY_INFO_NONE,
   * G_PRIORITY_DEFAULT,
   * cancellable,
   * …,
   * &local_error);
   * if (enumerator == NULL)
   * g_error ("Error enumerating: %s", local_error->message);
   *
   * // Loop until no files are returned, either because the end of the enumerator
   * // has been reached, or an error was returned.
   * do
   * {
   * files = yield g_file_enumerator_next_files_async (enumerator,
   * 5,  // number of files to request
   * G_PRIORITY_DEFAULT,
   * cancellable,
   * …,
   * &local_error);
   *
   * // Process the returned files, but don’t assume that exactly 5 were returned.
   * for (GList *l = files; l != NULL; l = l->next)
   * {
   * GFileInfo *info = l->data;
   * handle_file_info (info);
   * }
   * }
   * while (files != NULL);
   *
   * if (local_error != NULL &&
   * !g_error_matches (local_error, G_IO_ERROR, G_IO_ERROR_CANCELLED))
   * g_error ("Error while enumerating: %s", local_error->message);
   * ]|
   *
   * During an async request no other sync and async calls are allowed, and will
   * result in %G_IO_ERROR_PENDING errors.
   *
   * Any outstanding I/O request with higher priority (lower numerical value) will
   * be executed before an outstanding request with lower priority. Default
   * priority is %G_PRIORITY_DEFAULT.
   */
  void nextFilesAsync(int numFiles, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_file_enumerator_next_files_async(cPtr!GFileEnumerator, numFiles, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GList of #GFileInfos. You must free the list with
   * g_list_free() and unref the infos with g_object_unref() when you're
   * done with them.
   */
  List!(FileInfo, GFileInfo*) nextFilesFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_file_enumerator_next_files_finish(cPtr!GFileEnumerator, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(FileInfo, GFileInfo*) _retval = _cretval ? new List!(FileInfo, GFileInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Sets the file enumerator as having pending operations.
   */
  void setPending(bool pending)
  {
    g_file_enumerator_set_pending(cPtr!GFileEnumerator, pending);
  }
}
