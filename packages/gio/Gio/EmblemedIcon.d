module Gio.EmblemedIcon;

import GLib.List;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Emblem;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GEmblemedIcon is an implementation of #GIcon that supports
 * adding an emblem to an icon. Adding multiple emblems to an
 * icon is ensured via g_emblemed_icon_add_emblem().
 *
 * Note that #GEmblemedIcon allows no control over the position
 * of the emblems. See also #GEmblem for more information.
 */
class EmblemedIcon : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_emblemed_icon_get_type();
  }

  /**
   * a new #GIcon
   */
  this(Icon icon, Emblem emblem)
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_new(icon ? (cast(ObjectG)icon).cPtr!GIcon : null, emblem ? emblem.cPtr!GEmblem : null);
    this(_cretval, true);
  }

  /**
   * Adds @emblem to the #GList of #GEmblems.
   */
  void addEmblem(Emblem emblem)
  {
    g_emblemed_icon_add_emblem(cPtr!GEmblemedIcon, emblem ? emblem.cPtr!GEmblem : null);
  }

  /**
   * Removes all the emblems from @icon.
   */
  void clearEmblems()
  {
    g_emblemed_icon_clear_emblems(cPtr!GEmblemedIcon);
  }

  /**
   * a #GList of
   * #GEmblems that is owned by @emblemed
   */
  List!(Emblem, GEmblem*) getEmblems()
  {
    GList* _cretval;
    _cretval = g_emblemed_icon_get_emblems(cPtr!GEmblemedIcon);
    List!(Emblem, GEmblem*) _retval = _cretval ? new List!(Emblem, GEmblem*)(_cretval, GidOwnership.None) : null;
    return _retval;
  }

  /**
   * a #GIcon that is owned by @emblemed
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_get_icon(cPtr!GEmblemedIcon);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false);
    return _retval;
  }
}
