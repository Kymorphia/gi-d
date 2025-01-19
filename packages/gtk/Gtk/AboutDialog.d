module Gtk.AboutDialog;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkAboutDialog` offers a simple way to display information about
 * a program.
 * The shown information includes the programs' logo, name, copyright,
 * website and license. It is also possible to give credits to the authors,
 * documenters, translators and artists who have worked on the program.
 * An about dialog is typically opened when the user selects the `About`
 * option from the `Help` menu. All parts of the dialog are optional.
 * ![An example GtkAboutDialog](aboutdialog.png)
 * About dialogs often contain links and email addresses. `GtkAboutDialog`
 * displays these as clickable links. By default, it calls [Gtk.FileLauncher.launch]
 * when a user clicks one. The behaviour can be overridden with the
 * signal@Gtk.AboutDialog::activate-link signal.
 * To specify a person with an email address, use a string like
 * `Edgar Allan Poe <edgar@poe.com>`. To specify a website with a title,
 * use a string like `GTK team https://www.gtk.org`.
 * To make constructing a `GtkAboutDialog` as convenient as possible, you can
 * use the function func@Gtk.show_about_dialog which constructs and shows
 * a dialog and keeps it around so that it can be shown again.
 * Note that GTK sets a default title of `_$(LPAREN)"About %s"$(RPAREN)` on the dialog
 * window $(LPAREN)where `%s` is replaced by the name of the application, but in
 * order to ensure proper translation of the title, applications should
 * set the title property explicitly when constructing a `GtkAboutDialog`,
 * as shown in the following example:
 * ```c
 * GFile *logo_file \= g_file_new_for_path $(LPAREN)"./logo.png"$(RPAREN);
 * GdkTexture *example_logo \= gdk_texture_new_from_file $(LPAREN)logo_file, NULL$(RPAREN);
 * g_object_unref $(LPAREN)logo_file$(RPAREN);
 * gtk_show_about_dialog $(LPAREN)NULL,
 * "program-name", "ExampleCode",
 * "logo", example_logo,
 * "title", _$(LPAREN)"About ExampleCode"$(RPAREN),
 * NULL$(RPAREN);
 * ```
 * ## CSS nodes
 * `GtkAboutDialog` has a single CSS node with the name `window` and style
 * class `.aboutdialog`.
 */
class AboutDialog : Window
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_about_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkAboutDialog`.
   * Returns: a newly created `GtkAboutDialog`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_about_dialog_new();
    this(_cretval, false);
  }

  /**
   * Returns the comments string.
   * Returns: The comments
   */
  string getComments()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_comments(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the copyright string.
   * Returns: The copyright string
   */
  string getCopyright()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_copyright(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the license information.
   * Returns: The license information
   */
  string getLicense()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_license(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the license type.
   * Returns: a [Gtk] value
   */
  License getLicenseType()
  {
    GtkLicense _cretval;
    _cretval = gtk_about_dialog_get_license_type(cast(GtkAboutDialog*)cPtr);
    License _retval = cast(License)_cretval;
    return _retval;
  }

  /**
   * Returns the paintable displayed as logo in the about dialog.
   * Returns: the paintable displayed as
   *   logo or `NULL` if the logo is unset or has been set via
   *   [Gtk.AboutDialog.setLogoIconName]
   */
  Paintable getLogo()
  {
    GdkPaintable* _cretval;
    _cretval = gtk_about_dialog_get_logo(cast(GtkAboutDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the icon name displayed as logo in the about dialog.
   * Returns: the icon name displayed as logo,
   *   or `NULL` if the logo has been set via [Gtk.AboutDialog.setLogo]
   */
  string getLogoIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_logo_icon_name(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the program name displayed in the about dialog.
   * Returns: The program name
   */
  string getProgramName()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_program_name(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the system information that is shown in the about dialog.
   * Returns: the system information
   */
  string getSystemInformation()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_system_information(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the translator credits string which is displayed
   * in the credits page.
   * Returns: The translator credits string
   */
  string getTranslatorCredits()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_translator_credits(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the version string.
   * Returns: The version string
   */
  string getVersion()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_version(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the website URL.
   * Returns: The website URL
   */
  string getWebsite()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_website(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the label used for the website link.
   * Returns: The label used for the website link
   */
  string getWebsiteLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_about_dialog_get_website_label(cast(GtkAboutDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the license text in the about dialog is
   * automatically wrapped.
   * Returns: `TRUE` if the license text is wrapped
   */
  bool getWrapLicense()
  {
    bool _retval;
    _retval = gtk_about_dialog_get_wrap_license(cast(GtkAboutDialog*)cPtr);
    return _retval;
  }

  /**
   * Sets the comments string to display in the about dialog.
   * This should be a short string of one or two lines.
   * Params:
   *   comments = a comments string
   */
  void setComments(string comments)
  {
    const(char)* _comments = comments.toCString(false);
    gtk_about_dialog_set_comments(cast(GtkAboutDialog*)cPtr, _comments);
  }

  /**
   * Sets the copyright string to display in the about dialog.
   * This should be a short string of one or two lines.
   * Params:
   *   copyright = the copyright string
   */
  void setCopyright(string copyright)
  {
    const(char)* _copyright = copyright.toCString(false);
    gtk_about_dialog_set_copyright(cast(GtkAboutDialog*)cPtr, _copyright);
  }

  /**
   * Sets the license information to be displayed in the
   * about dialog.
   * If `license` is `NULL`, the license page is hidden.
   * Params:
   *   license = the license information
   */
  void setLicense(string license)
  {
    const(char)* _license = license.toCString(false);
    gtk_about_dialog_set_license(cast(GtkAboutDialog*)cPtr, _license);
  }

  /**
   * Sets the license of the application showing the about dialog from a
   * list of known licenses.
   * This function overrides the license set using
   * [Gtk.AboutDialog.setLicense].
   * Params:
   *   licenseType = the type of license
   */
  void setLicenseType(License licenseType)
  {
    gtk_about_dialog_set_license_type(cast(GtkAboutDialog*)cPtr, licenseType);
  }

  /**
   * Sets the logo in the about dialog.
   * Params:
   *   logo = a `GdkPaintable`
   */
  void setLogo(Paintable logo)
  {
    gtk_about_dialog_set_logo(cast(GtkAboutDialog*)cPtr, logo ? cast(GdkPaintable*)(cast(ObjectG)logo).cPtr(false) : null);
  }

  /**
   * Sets the icon name to be displayed as logo in the about dialog.
   * Params:
   *   iconName = an icon name
   */
  void setLogoIconName(string iconName)
  {
    const(char)* _iconName = iconName.toCString(false);
    gtk_about_dialog_set_logo_icon_name(cast(GtkAboutDialog*)cPtr, _iconName);
  }

  /**
   * Sets the name to display in the about dialog.
   * If `name` is not set, the string returned
   * by `[GLib.Global.getApplicationName]` is used.
   * Params:
   *   name = the program name
   */
  void setProgramName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_about_dialog_set_program_name(cast(GtkAboutDialog*)cPtr, _name);
  }

  /**
   * Sets the system information to be displayed in the about
   * dialog.
   * If `system_information` is `NULL`, the system information
   * page is hidden.
   * See propertyGtk.AboutDialog:system-information.
   * Params:
   *   systemInformation = system information
   */
  void setSystemInformation(string systemInformation)
  {
    const(char)* _systemInformation = systemInformation.toCString(false);
    gtk_about_dialog_set_system_information(cast(GtkAboutDialog*)cPtr, _systemInformation);
  }

  /**
   * Sets the translator credits string which is displayed in
   * the credits page.
   * The intended use for this string is to display the translator
   * of the language which is currently used in the user interface.
   * Using `gettext$(LPAREN)$(RPAREN)`, a simple way to achieve that is to mark the
   * string for translation:
   * ```c
   * GtkWidget *about \= gtk_about_dialog_new $(LPAREN)$(RPAREN);
   * gtk_about_dialog_set_translator_credits $(LPAREN)GTK_ABOUT_DIALOG $(LPAREN)about$(RPAREN),
   * _$(LPAREN)"translator-credits"$(RPAREN)$(RPAREN);
   * ```
   * It is a good idea to use the customary `msgid` “translator-credits”
   * for this purpose, since translators will already know the purpose of
   * that `msgid`, and since `GtkAboutDialog` will detect if “translator-credits”
   * is untranslated and omit translator credits.
   * Params:
   *   translatorCredits = the translator credits
   */
  void setTranslatorCredits(string translatorCredits)
  {
    const(char)* _translatorCredits = translatorCredits.toCString(false);
    gtk_about_dialog_set_translator_credits(cast(GtkAboutDialog*)cPtr, _translatorCredits);
  }

  /**
   * Sets the version string to display in the about dialog.
   * Params:
   *   version_ = the version string
   */
  void setVersion(string version_)
  {
    const(char)* _version_ = version_.toCString(false);
    gtk_about_dialog_set_version(cast(GtkAboutDialog*)cPtr, _version_);
  }

  /**
   * Sets the URL to use for the website link.
   * Params:
   *   website = a URL string starting with `http://`
   */
  void setWebsite(string website)
  {
    const(char)* _website = website.toCString(false);
    gtk_about_dialog_set_website(cast(GtkAboutDialog*)cPtr, _website);
  }

  /**
   * Sets the label to be used for the website link.
   * Params:
   *   websiteLabel = the label used for the website link
   */
  void setWebsiteLabel(string websiteLabel)
  {
    const(char)* _websiteLabel = websiteLabel.toCString(false);
    gtk_about_dialog_set_website_label(cast(GtkAboutDialog*)cPtr, _websiteLabel);
  }

  /**
   * Sets whether the license text in the about dialog should be
   * automatically wrapped.
   * Params:
   *   wrapLicense = whether to wrap the license
   */
  void setWrapLicense(bool wrapLicense)
  {
    gtk_about_dialog_set_wrap_license(cast(GtkAboutDialog*)cPtr, wrapLicense);
  }

  /**
   * Emitted every time a URL is activated.
   * Applications may connect to it to override the default behaviour,
   * which is to call [Gtk.FileLauncher.launch].
   * Params
   *   uri = the URI that is activated
   *   aboutDialog = the instance the signal is connected to
   * Returns: `TRUE` if the link has been activated
   */
  alias ActivateLinkCallback = bool delegate(string uri, AboutDialog aboutDialog);

  /**
   * Connect to ActivateLink signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateLink(ActivateLinkCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto aboutDialog = getVal!AboutDialog(_paramVals);
      auto uri = getVal!string(&_paramVals[1]);
      _retval = _dgClosure.dlg(uri, aboutDialog);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-link", closure, after);
  }
}
