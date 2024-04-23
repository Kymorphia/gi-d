module Gio.ThemedIcon;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GThemedIcon is an implementation of #GIcon that supports icon themes.
 * #GThemedIcon contains a list of all of the icons present in an icon
 * theme, so that icons can be looked up quickly. #GThemedIcon does
 * not provide actual pixmaps for icons, just the icon names.
 * Ideally something like gtk_icon_theme_choose_icon() should be used to
 * resolve the list of names so that fallback icons work nicely with
 * themes that inherit other themes.
 */
class ThemedIcon : ObjectG, Icon
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_themed_icon_get_type();
  }

  mixin IconT!GThemedIcon;

  /**
   * a new #GThemedIcon.
   */
  this(string iconname)
  {
    GIcon* _cretval;
    const(char)* _iconname = iconname.toCString(false);
    _cretval = g_themed_icon_new(_iconname);
    this(_cretval, true);
  }

  /**
   * a new #GThemedIcon
   */
  static ThemedIcon newFromNames(string[] iconnames)
  {
    GIcon* _cretval;
    char*[] _tmpiconnames;
    foreach (s; iconnames)
      _tmpiconnames ~= s.toCString(false);
    char** _iconnames = _tmpiconnames.ptr;
    _cretval = g_themed_icon_new_from_names(_iconnames, iconnames ? cast(int)iconnames.length : 0);
    ThemedIcon _retval = ObjectG.getDObject!ThemedIcon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GThemedIcon.
   */
  static ThemedIcon newWithDefaultFallbacks(string iconname)
  {
    GIcon* _cretval;
    const(char)* _iconname = iconname.toCString(false);
    _cretval = g_themed_icon_new_with_default_fallbacks(_iconname);
    ThemedIcon _retval = ObjectG.getDObject!ThemedIcon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * Append a name to the list of icons from within @icon.
   *
   * Note that doing so invalidates the hash computed by prior calls
   * to g_icon_hash().
   */
  void appendName(string iconname)
  {
    const(char)* _iconname = iconname.toCString(false);
    g_themed_icon_append_name(cPtr!GThemedIcon, _iconname);
  }

  /**
   * a list of icon names.
   */
  string[] getNames()
  {
    const(char*)* _cretval;
    _cretval = g_themed_icon_get_names(cPtr!GThemedIcon);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Prepend a name to the list of icons from within @icon.
   *
   * Note that doing so invalidates the hash computed by prior calls
   * to g_icon_hash().
   */
  void prependName(string iconname)
  {
    const(char)* _iconname = iconname.toCString(false);
    g_themed_icon_prepend_name(cPtr!GThemedIcon, _iconname);
  }
}
