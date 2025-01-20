module Gtk.SelectionModelInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The list of virtual functions for the `GtkSelectionModel` interface.
 * No function must be implemented, but unless `GtkSelectionModel::is_selected$(LPAREN)$(RPAREN)`
 * is implemented, it will not be possible to select items in the set.
 * The model does not need to implement any functions to support either
 * selecting or unselecting items. Of course, if the model does not do that,
 * it means that users cannot select or unselect items in a list widget
 * using the model.
 * All selection functions fall back to `GtkSelectionModel::set_selection$(LPAREN)$(RPAREN)`
 * so it is sufficient to implement just that function for full selection
 * support.
 */
class SelectionModelInterface
{
  GtkSelectionModelInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.SelectionModelInterface");

    cInstance = *cast(GtkSelectionModelInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias IsSelectedFuncType = extern(C) bool function(GtkSelectionModel* model, uint position);

  @property IsSelectedFuncType isSelected()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).isSelected;
  }

  alias GetSelectionInRangeFuncType = extern(C) GtkBitset* function(GtkSelectionModel* model, uint position, uint nItems);

  @property GetSelectionInRangeFuncType getSelectionInRange()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).getSelectionInRange;
  }

  alias SelectItemFuncType = extern(C) bool function(GtkSelectionModel* model, uint position, bool unselectRest);

  @property SelectItemFuncType selectItem()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).selectItem;
  }

  alias UnselectItemFuncType = extern(C) bool function(GtkSelectionModel* model, uint position);

  @property UnselectItemFuncType unselectItem()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).unselectItem;
  }

  alias SelectRangeFuncType = extern(C) bool function(GtkSelectionModel* model, uint position, uint nItems, bool unselectRest);

  @property SelectRangeFuncType selectRange()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).selectRange;
  }

  alias UnselectRangeFuncType = extern(C) bool function(GtkSelectionModel* model, uint position, uint nItems);

  @property UnselectRangeFuncType unselectRange()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).unselectRange;
  }

  alias SelectAllFuncType = extern(C) bool function(GtkSelectionModel* model);

  @property SelectAllFuncType selectAll()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).selectAll;
  }

  alias UnselectAllFuncType = extern(C) bool function(GtkSelectionModel* model);

  @property UnselectAllFuncType unselectAll()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).unselectAll;
  }

  alias SetSelectionFuncType = extern(C) bool function(GtkSelectionModel* model, GtkBitset* selected, GtkBitset* mask);

  @property SetSelectionFuncType setSelection()
  {
    return (cast(GtkSelectionModelInterface*)cPtr).setSelection;
  }
}
