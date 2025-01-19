module Gtk.AppChooserButton;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.AppChooser;
import Gtk.AppChooserT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkAppChooserButton` lets the user select an application.
 * ![An example GtkAppChooserButton](appchooserbutton.png)
 * Initially, a `GtkAppChooserButton` selects the first application
 * in its list, which will either be the most-recently used application
 * or, if property@Gtk.AppChooserButton:show-default-item is %TRUE, the
 * default application.
 * The list of applications shown in a `GtkAppChooserButton` includes
 * the recommended applications for the given content type. When
 * property@Gtk.AppChooserButton:show-default-item is set, the default
 * application is also included. To let the user chooser other applications,
 * you can set the property@Gtk.AppChooserButton:show-dialog-item property,
 * which allows to open a full [Gtk.AppChooserDialog].
 * It is possible to add custom items to the list, using
 * [Gtk.AppChooserButton.appendCustomItem]. These items cause
 * the signal@Gtk.AppChooserButton::custom-item-activated signal to be
 * emitted when they are selected.
 * To track changes in the selected application, use the
 * [Gtk.AppChooserButton.changed] signal.
 * ## CSS nodes
 * `GtkAppChooserButton` has a single CSS node with the name “appchooserbutton”.

 * Deprecated: The application selection widgets should be
 *   implemented according to the design of each platform and/or
 *   application requiring them.
 */
class AppChooserButton : Widget, AppChooser
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
    return gtk_app_chooser_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AppChooserT!();

  /**
   * Creates a new `GtkAppChooserButton` for applications
   * that can handle content of the given type.
   * Params:
   *   contentType = the content type to show applications for
   * Returns: a newly created `GtkAppChooserButton`

   * Deprecated: This widget will be removed in GTK 5
   */
  this(string contentType)
  {
    GtkWidget* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = gtk_app_chooser_button_new(_contentType);
    this(_cretval, false);
  }

  /**
   * Appends a custom item to the list of applications that is shown
   * in the popup.
   * The item name must be unique per-widget. Clients can use the
   * provided name as a detail for the
   * signalGtk.AppChooserButton::custom-item-activated signal, to add a
   * callback for the activation of a particular custom item in the list.
   * See also [Gtk.AppChooserButton.appendSeparator].
   * Params:
   *   name = the name of the custom item
   *   label = the label for the custom item
   *   icon = the icon for the custom item

   * Deprecated: This widget will be removed in GTK 5
   */
  void appendCustomItem(string name, string label, Icon icon)
  {
    const(char)* _name = name.toCString(false);
    const(char)* _label = label.toCString(false);
    gtk_app_chooser_button_append_custom_item(cast(GtkAppChooserButton*)cPtr, _name, _label, icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null);
  }

  /**
   * Appends a separator to the list of applications that is shown
   * in the popup.

   * Deprecated: This widget will be removed in GTK 5
   */
  void appendSeparator()
  {
    gtk_app_chooser_button_append_separator(cast(GtkAppChooserButton*)cPtr);
  }

  /**
   * Returns the text to display at the top of the dialog.
   * Returns: the text to display at the top of the dialog,
   *   or %NULL, in which case a default text is displayed

   * Deprecated: This widget will be removed in GTK 5
   */
  string getHeading()
  {
    const(char)* _cretval;
    _cretval = gtk_app_chooser_button_get_heading(cast(GtkAppChooserButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether the dialog is modal.
   * Returns: %TRUE if the dialog is modal

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_app_chooser_button_get_modal(cast(GtkAppChooserButton*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the dropdown menu should show the default
   * application at the top.
   * Returns: the value of propertyGtk.AppChooserButton:show-default-item

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowDefaultItem()
  {
    bool _retval;
    _retval = gtk_app_chooser_button_get_show_default_item(cast(GtkAppChooserButton*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the dropdown menu shows an item
   * for a `GtkAppChooserDialog`.
   * Returns: the value of propertyGtk.AppChooserButton:show-dialog-item

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowDialogItem()
  {
    bool _retval;
    _retval = gtk_app_chooser_button_get_show_dialog_item(cast(GtkAppChooserButton*)cPtr);
    return _retval;
  }

  /**
   * Selects a custom item.
   * See [Gtk.AppChooserButton.appendCustomItem].
   * Use [Gtk.AppChooser.refresh] to bring the selection
   * to its initial state.
   * Params:
   *   name = the name of the custom item

   * Deprecated: This widget will be removed in GTK 5
   */
  void setActiveCustomItem(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_app_chooser_button_set_active_custom_item(cast(GtkAppChooserButton*)cPtr, _name);
  }

  /**
   * Sets the text to display at the top of the dialog.
   * If the heading is not set, the dialog displays a default text.
   * Params:
   *   heading = a string containing Pango markup

   * Deprecated: This widget will be removed in GTK 5
   */
  void setHeading(string heading)
  {
    const(char)* _heading = heading.toCString(false);
    gtk_app_chooser_button_set_heading(cast(GtkAppChooserButton*)cPtr, _heading);
  }

  /**
   * Sets whether the dialog should be modal.
   * Params:
   *   modal = %TRUE to make the dialog modal

   * Deprecated: This widget will be removed in GTK 5
   */
  void setModal(bool modal)
  {
    gtk_app_chooser_button_set_modal(cast(GtkAppChooserButton*)cPtr, modal);
  }

  /**
   * Sets whether the dropdown menu of this button should show the
   * default application for the given content type at top.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserButton:show-default-item

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowDefaultItem(bool setting)
  {
    gtk_app_chooser_button_set_show_default_item(cast(GtkAppChooserButton*)cPtr, setting);
  }

  /**
   * Sets whether the dropdown menu of this button should show an
   * entry to trigger a `GtkAppChooserDialog`.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserButton:show-dialog-item

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowDialogItem(bool setting)
  {
    gtk_app_chooser_button_set_show_dialog_item(cast(GtkAppChooserButton*)cPtr, setting);
  }

  /**
   * Emitted to when the button is activated.
   * The `::activate` signal on `GtkAppChooserButton` is an action signal and
   * emitting it causes the button to pop up its dialog.
   *   appChooserButton = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(AppChooserButton appChooserButton);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appChooserButton = getVal!AppChooserButton(_paramVals);
      _dgClosure.dlg(appChooserButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }

  /**
   * Emitted when the active application changes.
   *   appChooserButton = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(AppChooserButton appChooserButton);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appChooserButton = getVal!AppChooserButton(_paramVals);
      _dgClosure.dlg(appChooserButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * Emitted when a custom item is activated.
   * Use [Gtk.AppChooserButton.appendCustomItem],
   * to add custom items.
   * Params
   *   itemName = the name of the activated item
   *   appChooserButton = the instance the signal is connected to
   */
  alias CustomItemActivatedCallback = void delegate(string itemName, AppChooserButton appChooserButton);

  /**
   * Connect to CustomItemActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   detail = Signal detail or null (default)
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCustomItemActivated(CustomItemActivatedCallback dlg, string detail = null, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appChooserButton = getVal!AppChooserButton(_paramVals);
      auto itemName = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(itemName, appChooserButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("custom-item-activated"~ (detail.length ? "::" ~ detail : ""), closure, after);
  }
}
