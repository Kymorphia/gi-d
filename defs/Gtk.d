//!repo Gtk-4.0

//# Add missing c:type for GtkSnapshot
//!set class[Snapshot][c:type] GtkSnapshot

//# CellArea::add-editable signal has parameter name which conflicts with cellArea instance name, rename it
//!set class[CellArea].glib:signal[add-editable].parameters.parameter[cell_area][name] area

//# Rename PrintUnixDialog.getSettings so it does not conflict with Widget.getSettings
//!set class[PrintUnixDialog].method[get_settings][name] get_print_settings

//# Rename Widget.activateAction so that it doesn't conflict with ActionGroup.ActivateAction
//!set class[Widget].method[activate_action][name] activate_action_group

//# Rename MenuButton.getDirection so that it doesn't conflict with Widget.getDirection
//!set class[MenuButton].method[get_direction][name] get_popup_direction
