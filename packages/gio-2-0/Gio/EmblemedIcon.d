module Gio.EmblemedIcon;

import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gio.Emblem;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GEmblemedIcon` is an implementation of [Gio.Icon] that supports
 * adding an emblem to an icon. Adding multiple emblems to an
 * icon is ensured via [Gio.EmblemedIcon.addEmblem].
 * Note that `GEmblemedIcon` allows no control over the position
 * of the emblems. See also [Gio.Emblem] for more information.
 */
class EmblemedIcon : ObjectG, Icon
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
    return g_emblemed_icon_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();

  /**
   * Creates a new emblemed icon for icon with the emblem emblem.
   * Params:
   *   icon = a #GIcon
   *   emblem = a #GEmblem, or %NULL
   * Returns: a new #GIcon
   */
  this(Icon icon, Emblem emblem)
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_new(icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null, emblem ? cast(GEmblem*)emblem.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Adds emblem to the #GList of #GEmblems.
   * Params:
   *   emblem = a #GEmblem
   */
  void addEmblem(Emblem emblem)
  {
    g_emblemed_icon_add_emblem(cast(GEmblemedIcon*)cPtr, emblem ? cast(GEmblem*)emblem.cPtr(false) : null);
  }

  /**
   * Removes all the emblems from icon.
   */
  void clearEmblems()
  {
    g_emblemed_icon_clear_emblems(cast(GEmblemedIcon*)cPtr);
  }

  /**
   * Gets the list of emblems for the icon.
   * Returns: a #GList of
   *   #GEmblems that is owned by emblemed
   */
  List!(Emblem, GEmblem) getEmblems()
  {
    GList* _cretval;
    _cretval = g_emblemed_icon_get_emblems(cast(GEmblemedIcon*)cPtr);
    List!(Emblem, GEmblem) _retval = new List!(Emblem, GEmblem)(cast(GList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Gets the main icon for emblemed.
   * Returns: a #GIcon that is owned by emblemed
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_get_icon(cast(GEmblemedIcon*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false) : null;
    return _retval;
  }
}
