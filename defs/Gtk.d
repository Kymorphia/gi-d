//!repo Gtk-4.0

//# Add missing c:type for GtkSnapshot
//!set class[Snapshot][c:type] GtkSnapshot

//# CellArea::add-editable signal has parameter name which conflicts with cellArea instance name, rename it
//!set class[CellArea].glib:signal[add-editable].parameters.parameter[cell_area][name] area

//!class ApplicationWindow
  // Add base class alias for activateAction since it is used in GtkWidget and Gio.ActionGroup interface
  alias activateAction = Widget.activateAction;

//!class MenuButton
  // Add base class alias for getDirection since it is used in GtkWidget and defined in MenuButton class
  alias getDirection = Widget.getDirection;

//!class PrintUnixDialog
  // Add base class alias for getSettings since it is used in GtkWidget and defined in PrintUnixDialog class
  alias getSettings = Widget.getSettings;
