module Gtk.Settings;

import GObject.ObjectG;
import Gdk.Display;
import Gid.gid;
import Gtk.StyleProvider;
import Gtk.StyleProviderT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSettings` provides a mechanism to share global settings between
 * applications.
 * On the X window system, this sharing is realized by an
 * [XSettings](http://www.freedesktop.org/wiki/Specifications/xsettings-spec)
 * manager that is usually part of the desktop environment, along with
 * utilities that let the user change these settings.
 * On Wayland, the settings are obtained either via a settings portal,
 * or by reading desktop settings from DConf.
 * On macOS, the settings are obtained from `NSUserDefaults`.
 * In the absence of these sharing mechanisms, GTK reads default values for
 * settings from `settings.ini` files in `/etc/gtk-4.0`, `\$XDG_CONFIG_DIRS/gtk-4.0`
 * and `\$XDG_CONFIG_HOME/gtk-4.0`. These files must be valid key files $(LPAREN)see
 * `GKeyFile`$(RPAREN), and have a section called Settings. Themes can also provide
 * default values for settings by installing a `settings.ini` file
 * next to their `gtk.css` file.
 * Applications can override system-wide settings by setting the property
 * of the `GtkSettings` object with [GObject.ObjectG.set]. This should be restricted
 * to special cases though; `GtkSettings` are not meant as an application
 * configuration facility.
 * There is one `GtkSettings` instance per display. It can be obtained with
 * [Gtk.Settings.getForDisplay], but in many cases, it is more
 * convenient to use [Gtk.Widget.getSettings].
 */
class Settings : ObjectG, StyleProvider
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
    return gtk_settings_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin StyleProviderT!();

  /**
   * Gets the `GtkSettings` object for the default display, creating
   * it if necessary.
   * See [Gtk.Settings.getForDisplay].
   * Returns: a `GtkSettings` object. If there is
   *   no default display, then returns %NULL.
   */
  static Settings getDefault()
  {
    GtkSettings* _cretval;
    _cretval = gtk_settings_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!Settings(cast(GtkSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GtkSettings` object for display, creating it if necessary.
   * Params:
   *   display = a `GdkDisplay`
   * Returns: a `GtkSettings` object
   */
  static Settings getForDisplay(Display display)
  {
    GtkSettings* _cretval;
    _cretval = gtk_settings_get_for_display(display ? cast(GdkDisplay*)display.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Settings(cast(GtkSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Undoes the effect of calling [GObject.ObjectG.set] to install an
   * application-specific value for a setting.
   * After this call, the setting will again follow the session-wide
   * value for this setting.
   * Params:
   *   name = the name of the setting to reset
   */
  void resetProperty(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_settings_reset_property(cast(GtkSettings*)cPtr, _name);
  }
}
