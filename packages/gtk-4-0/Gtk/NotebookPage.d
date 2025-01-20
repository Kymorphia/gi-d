module Gtk.NotebookPage;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkNotebookPage` is an auxiliary object used by `GtkNotebook`.
 */
class NotebookPage : ObjectG
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
    return gtk_notebook_page_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the notebook child to which page belongs.
   * Returns: the child to which page belongs
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_page_get_child(cast(GtkNotebookPage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }
}
