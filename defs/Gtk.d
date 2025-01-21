//!repo Gtk-4.0

//# Add missing c:type for GtkSnapshot
//!set class[Snapshot][c:type] GtkSnapshot

//# CellArea::add-editable signal has parameter name which conflicts with cellArea instance name, rename it
//!set class[CellArea].glib:signal[add-editable].parameters.parameter[cell_area][name] area

//# Set arrays to be zero-terminated=1
//!set class[Application].method[set_accels_for_action].parameters.parameter[accels].array[][zero-terminated] 1
//!set class[AboutDialog].method[add_credit_section].parameters.parameter[people].array[][zero-terminated] 1
//!set class[AboutDialog].method[get_artists].return-value.array[][zero-terminated] 1
//!set class[AboutDialog].method[get_authors].return-value.array[][zero-terminated] 1
//!set class[AboutDialog].method[get_documenters].return-value.array[][zero-terminated] 1
//!set class[AboutDialog].method[set_artists].parameters.parameter[artists].array[][zero-terminated] 1
//!set class[AboutDialog].method[set_authors].parameters.parameter[authors].array[][zero-terminated] 1
//!set class[AboutDialog].method[set_documenters].parameters.parameter[documenters].array[][zero-terminated] 1
//!set class[AlertDialog].method[get_buttons].return-value.array[][zero-terminated] 1
//!set class[AlertDialog].method[set_buttons].parameters.parameter[labels].array[][zero-terminated] 1
//!set class[Application].method[get_accels_for_action].return-value.array[][zero-terminated] 1
//!set class[Application].method[get_actions_for_accel].return-value.array[][zero-terminated] 1
//!set class[Application].method[list_action_descriptions].return-value.array[][zero-terminated] 1
//!set class[Builder].method[add_objects_from_file].parameters.parameter[object_ids].array[][zero-terminated] 1
//!set class[Builder].method[add_objects_from_resource].parameters.parameter[object_ids].array[][zero-terminated] 1
//!set class[Builder].method[add_objects_from_string].parameters.parameter[object_ids].array[][zero-terminated] 1
//!set class[DropDown].constructor[new_from_strings].parameters.parameter[strings].array[][zero-terminated] 1
//!set interface[FileChooser].method[add_choice].parameters.parameter[options].array[][zero-terminated] 1
//!set interface[FileChooser].method[add_choice].parameters.parameter[option_labels].array[][zero-terminated] 1
//!set class[FileFilter].method[get_attributes].return-value.array[][zero-terminated] 1
//!set function[accelerator_parse_with_keycode].parameters.parameter[accelerator_codes].array[][zero-terminated] 1
//!set class[IconTheme].method[get_icon_names].return-value.array[][zero-terminated] 1
//!set class[IconTheme].method[get_icon_sizes].return-value.array[][zero-terminated] 1
//!set class[IconTheme].method[get_resource_path].return-value.array[][zero-terminated] 1
//!set class[IconTheme].method[get_search_path].return-value.array[][zero-terminated] 1
//!set class[IconTheme].method[lookup_icon].parameters.parameter[fallbacks].array[][zero-terminated] 1
//!set class[IconTheme].method[set_resource_path].parameters.parameter[path].array[][zero-terminated] 1
//!set class[IconTheme].method[set_search_path].parameters.parameter[path].array[][zero-terminated] 1
//!set class[ListStore].method[reorder].parameters.parameter[new_order].array[][zero-terminated] 1
//!set record[RecentData].field[groups].array[][zero-terminated] 1
//!set class[ScaleButton].constructor[new].parameters.parameter[icons].array[][zero-terminated] 1
//!set class[ScaleButton].method[set_icons].parameters.parameter[icons].array[][zero-terminated] 1
//!set class[StringList].constructor[new].parameters.parameter[strings].array[][zero-terminated] 1
//!set class[StringList].method[splice].parameters.parameter[additions].array[][zero-terminated] 1
//!set class[Widget].method[get_css_classes].return-value.array[][zero-terminated] 1
//!set class[Widget].method[set_css_classes].parameters.parameter[classes].array[][zero-terminated] 1

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
