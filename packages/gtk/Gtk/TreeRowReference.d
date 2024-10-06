module Gtk.TreeRowReference;

import GLib.Boxed;
import GObject.ObjectG;
import Gid.gid;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A GtkTreeRowReference tracks model changes so that it always refers to the
 * same row $(LPAREN)a `GtkTreePath` refers to a position, not a fixed row$(RPAREN). Create a
 * new GtkTreeRowReference with [Gtk.TreeRowReference.new_].

 * Deprecated: Use [Gio.ListModel] instead
 */
class TreeRowReference : Boxed
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
    return gtk_tree_row_reference_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a row reference based on path.
   * This reference will keep pointing to the node pointed to
   * by path, so long as it exists. Any changes that occur on model are
   * propagated, and the path is updated appropriately. If
   * path isn’t a valid path in model, then %NULL is returned.
   * Params:
   *   model = a `GtkTreeModel`
   *   path = a valid `GtkTreePath` to monitor
   * Returns: a newly allocated `GtkTreeRowReference`
   */
  this(TreeModel model, TreePath path)
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_new(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * You do not need to use this function.
   * Creates a row reference based on path.
   * This reference will keep pointing to the node pointed to
   * by path, so long as it exists. If path isn’t a valid
   * path in model, then %NULL is returned. However, unlike
   * references created with [Gtk.TreeRowReference.new_], it
   * does not listen to the model for changes. The creator of
   * the row reference must do this explicitly using
   * [Gtk.TreeRowReference.inserted], [Gtk.TreeRowReference.deleted],
   * [Gtk.TreeRowReference.reordered].
   * These functions must be called exactly once per proxy when the
   * corresponding signal on the model is emitted. This single call
   * updates all row references for that proxy. Since built-in GTK
   * objects like `GtkTreeView` already use this mechanism internally,
   * using them as the proxy object will produce unpredictable results.
   * Further more, passing the same object as model and proxy
   * doesn’t work for reasons of internal implementation.
   * This type of row reference is primarily meant by structures that
   * need to carefully monitor exactly when a row reference updates
   * itself, and is not generally needed by most applications.
   * Params:
   *   proxy = a proxy `GObject`
   *   model = a `GtkTreeModel`
   *   path = a valid `GtkTreePath` to monitor
   * Returns: a newly allocated `GtkTreeRowReference`
   */
  static TreeRowReference newProxy(ObjectG proxy, TreeModel model, TreePath path)
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_new_proxy(proxy ? cast(ObjectC*)proxy.cPtr(false) : null, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    auto _retval = _cretval ? new TreeRowReference(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Copies a `GtkTreeRowReference`.
   * Returns: a copy of reference
   */
  TreeRowReference copy()
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_copy(cast(GtkTreeRowReference*)cPtr);
    auto _retval = _cretval ? new TreeRowReference(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the model that the row reference is monitoring.
   * Returns: the model
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_row_reference_get_model(cast(GtkTreeRowReference*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns a path that the row reference currently points to,
   * or %NULL if the path pointed to is no longer valid.
   * Returns: a current path
   */
  TreePath getPath()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_row_reference_get_path(cast(GtkTreeRowReference*)cPtr);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the reference is non-%NULL and refers to
   * a current valid path.
   * Returns: %TRUE if reference points to a valid path
   */
  bool valid()
  {
    bool _retval;
    _retval = gtk_tree_row_reference_valid(cast(GtkTreeRowReference*)cPtr);
    return _retval;
  }

  /**
   * Lets a set of row reference created by
   * [Gtk.TreeRowReference.newProxy] know that the
   * model emitted the ::row-deleted signal.
   * Params:
   *   proxy = a `GObject`
   *   path = the path position that was deleted
   */
  static void deleted(ObjectG proxy, TreePath path)
  {
    gtk_tree_row_reference_deleted(proxy ? cast(ObjectC*)proxy.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Lets a set of row reference created by
   * [Gtk.TreeRowReference.newProxy] know that the
   * model emitted the ::row-inserted signal.
   * Params:
   *   proxy = a `GObject`
   *   path = the row position that was inserted
   */
  static void inserted(ObjectG proxy, TreePath path)
  {
    gtk_tree_row_reference_inserted(proxy ? cast(ObjectC*)proxy.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }
}
