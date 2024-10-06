module Gtk.AppChooserWidget;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gio.AppInfo;
import Gio.AppInfoT;
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
 * `GtkAppChooserWidget` is a widget for selecting applications.
 * It is the main building block for [Gtk.AppChooserDialog].
 * Most applications only need to use the latter; but you can use
 * this widget as part of a larger widget if you have special needs.
 * `GtkAppChooserWidget` offers detailed control over what applications
 * are shown, using the
 * property@Gtk.AppChooserWidget:show-default,
 * property@Gtk.AppChooserWidget:show-recommended,
 * property@Gtk.AppChooserWidget:show-fallback,
 * property@Gtk.AppChooserWidget:show-other and
 * property@Gtk.AppChooserWidget:show-all properties. See the
 * [Gtk.AppChooser] documentation for more information about these
 * groups of applications.
 * To keep track of the selected application, use the
 * signal@Gtk.AppChooserWidget::application-selected and
 * signal@Gtk.AppChooserWidget::application-activated signals.
 * ## CSS nodes
 * `GtkAppChooserWidget` has a single CSS node with name appchooser.

 * Deprecated: The application selection widgets should be
 *   implemented according to the design of each platform and/or
 *   application requiring them.
 */
class AppChooserWidget : Widget, AppChooser
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
    return gtk_app_chooser_widget_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AppChooserT!GtkAppChooserWidget;

  /**
   * Creates a new `GtkAppChooserWidget` for applications
   * that can handle content of the given type.
   * Params:
   *   contentType = the content type to show applications for
   * Returns: a newly created `GtkAppChooserWidget`

   * Deprecated: This widget will be removed in GTK 5
   */
  this(string contentType)
  {
    GtkWidget* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = gtk_app_chooser_widget_new(_contentType);
    this(_cretval, false);
  }

  /**
   * Returns the text that is shown if there are not applications
   * that can handle the content type.
   * Returns: the value of propertyGtk.AppChooserWidget:default-text

   * Deprecated: This widget will be removed in GTK 5
   */
  string getDefaultText()
  {
    const(char)* _cretval;
    _cretval = gtk_app_chooser_widget_get_default_text(cast(GtkAppChooserWidget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether the app chooser should show all applications
   * in a flat list.
   * Returns: the value of propertyGtk.AppChooserWidget:show-all

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowAll()
  {
    bool _retval;
    _retval = gtk_app_chooser_widget_get_show_all(cast(GtkAppChooserWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the app chooser should show the default handler
   * for the content type in a separate section.
   * Returns: the value of propertyGtk.AppChooserWidget:show-default

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowDefault()
  {
    bool _retval;
    _retval = gtk_app_chooser_widget_get_show_default(cast(GtkAppChooserWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the app chooser should show related applications
   * for the content type in a separate section.
   * Returns: the value of propertyGtk.AppChooserWidget:show-fallback

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowFallback()
  {
    bool _retval;
    _retval = gtk_app_chooser_widget_get_show_fallback(cast(GtkAppChooserWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the app chooser should show applications
   * which are unrelated to the content type.
   * Returns: the value of propertyGtk.AppChooserWidget:show-other

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowOther()
  {
    bool _retval;
    _retval = gtk_app_chooser_widget_get_show_other(cast(GtkAppChooserWidget*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the app chooser should show recommended applications
   * for the content type in a separate section.
   * Returns: the value of propertyGtk.AppChooserWidget:show-recommended

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getShowRecommended()
  {
    bool _retval;
    _retval = gtk_app_chooser_widget_get_show_recommended(cast(GtkAppChooserWidget*)cPtr);
    return _retval;
  }

  /**
   * Sets the text that is shown if there are not applications
   * that can handle the content type.
   * Params:
   *   text = the new value for propertyGtk.AppChooserWidget:default-text

   * Deprecated: This widget will be removed in GTK 5
   */
  void setDefaultText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_app_chooser_widget_set_default_text(cast(GtkAppChooserWidget*)cPtr, _text);
  }

  /**
   * Sets whether the app chooser should show all applications
   * in a flat list.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserWidget:show-all

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowAll(bool setting)
  {
    gtk_app_chooser_widget_set_show_all(cast(GtkAppChooserWidget*)cPtr, setting);
  }

  /**
   * Sets whether the app chooser should show the default handler
   * for the content type in a separate section.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserWidget:show-default

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowDefault(bool setting)
  {
    gtk_app_chooser_widget_set_show_default(cast(GtkAppChooserWidget*)cPtr, setting);
  }

  /**
   * Sets whether the app chooser should show related applications
   * for the content type in a separate section.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserWidget:show-fallback

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowFallback(bool setting)
  {
    gtk_app_chooser_widget_set_show_fallback(cast(GtkAppChooserWidget*)cPtr, setting);
  }

  /**
   * Sets whether the app chooser should show applications
   * which are unrelated to the content type.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserWidget:show-other

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowOther(bool setting)
  {
    gtk_app_chooser_widget_set_show_other(cast(GtkAppChooserWidget*)cPtr, setting);
  }

  /**
   * Sets whether the app chooser should show recommended applications
   * for the content type in a separate section.
   * Params:
   *   setting = the new value for propertyGtk.AppChooserWidget:show-recommended

   * Deprecated: This widget will be removed in GTK 5
   */
  void setShowRecommended(bool setting)
  {
    gtk_app_chooser_widget_set_show_recommended(cast(GtkAppChooserWidget*)cPtr, setting);
  }

  /**
   * Emitted when an application item is activated from the widget's list.
   * This usually happens when the user double clicks an item, or an item
   * is selected and the user presses one of the keys Space, Shift+Space,
   * Return or Enter.
   * Params
   *   application = the activated `GAppInfo`
   *   appChooserWidget = the instance the signal is connected to
   */
  alias ApplicationActivatedCallback = void delegate(AppInfo application, AppChooserWidget appChooserWidget);

  /**
   * Connect to ApplicationActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectApplicationActivated(ApplicationActivatedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appChooserWidget = getVal!AppChooserWidget(_paramVals);
      auto application = getVal!AppInfo(&_paramVals[1]);
      _dgClosure.dlg(application, appChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("application-activated", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when an application item is selected from the widget's list.
   * Params
   *   application = the selected `GAppInfo`
   *   appChooserWidget = the instance the signal is connected to
   */
  alias ApplicationSelectedCallback = void delegate(AppInfo application, AppChooserWidget appChooserWidget);

  /**
   * Connect to ApplicationSelected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectApplicationSelected(ApplicationSelectedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appChooserWidget = getVal!AppChooserWidget(_paramVals);
      auto application = getVal!AppInfo(&_paramVals[1]);
      _dgClosure.dlg(application, appChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("application-selected", closure, (flags & ConnectFlags.After) != 0);
  }
}
