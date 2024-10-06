//!repo Gtk-4.0

//# Add missing c:type for GtkSnapshot
//!set class[Snapshot][c:type] GtkSnapshot

//# CellArea::add-editable signal has parameter name which conflicts with cellArea instance name, rename it
//!set class[CellArea].glib:signal[add-editable].parameters.parameter[cell_area][name] area

//!set class[Application].method[set_accels_for_action].parameters.parameter[accels].array[][zero-terminated] 1

//!class ApplicationWindow
  // Add base class alias for activateAction since it is used in GtkWidget and Gio.ActionGroup interface
  alias activateAction = Widget.activateAction;

//!class MenuButton
  // Add base class alias for getDirection since it is used in GtkWidget and defined in MenuButton class
  alias getDirection = Widget.getDirection;

//!class PrintUnixDialog
  // Add base class alias for getSettings since it is used in GtkWidget and defined in PrintUnixDialog class
  alias getSettings = Widget.getSettings;

//!class CustomSorter
//!set class[CustomSorter].constructor[new][disable] 1
//!set class[CustomSorter].method[set_sort_func][disable] 1
  import GObject.ObjectG;

  // Define a sort delegate that takes ObjectG objects, instead of the CompareDataFunc which is passed raw ObjectC pointers
  alias CustomSortDelegate = int delegate(ObjectG aObj, ObjectG bObj);

  /**
   * Creates a new `GtkSorter` that works by calling
   * sortFunc to compare items.
   * If sortFunc is null, all items are considered equal.
   * Params:
   *   sortFunc = the callback delegate to use for sorting
   * Returns: a new `CustomSorter`
   */
  this(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    GtkCustomSorter* _cretval;
    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    _cretval = gtk_custom_sorter_new(&_sortFuncCallback, _sortFunc, &thawDelegate);
    this(_cretval, true);
  }

  /**
   * Sets $(LPAREN)or unsets$(RPAREN) the function used for sorting items.
   * If sort_func is %NULL, all items are considered equal.
   * If the sort func changes its sorting behavior,
   * [Gtk.Sorter.changed] needs to be called.
   * If a previous function was set, its user_destroy will be
   * called now.
   * Params:
   *   sortFunc = function to sort items
   */
  void setSortFunc(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_custom_sorter_set_sort_func(cast(GtkCustomSorter*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }
