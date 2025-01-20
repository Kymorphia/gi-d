module Gio.Emblem;

import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GEmblem` is an implementation of [Gio.Icon] that supports
 * having an emblem, which is an icon with additional properties.
 * It can than be added to a [Gio.EmblemedIcon].
 * Currently, only metainformation about the emblem's origin is
 * supported. More may be added in the future.
 */
class Emblem : ObjectG, Icon
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
    return g_emblem_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();

  /**
   * Creates a new emblem for icon.
   * Params:
   *   icon = a GIcon containing the icon.
   * Returns: a new #GEmblem.
   */
  this(Icon icon)
  {
    GEmblem* _cretval;
    _cretval = g_emblem_new(icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a new emblem for icon.
   * Params:
   *   icon = a GIcon containing the icon.
   *   origin = a GEmblemOrigin enum defining the emblem's origin
   * Returns: a new #GEmblem.
   */
  static Emblem newWithOrigin(Icon icon, EmblemOrigin origin)
  {
    GEmblem* _cretval;
    _cretval = g_emblem_new_with_origin(icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null, origin);
    auto _retval = _cretval ? ObjectG.getDObject!Emblem(cast(GEmblem*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gives back the icon from emblem.
   * Returns: a #GIcon. The returned object belongs to
   *   the emblem and should not be modified or freed.
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_emblem_get_icon(cast(GEmblem*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the origin of the emblem.
   * Returns: the origin of the emblem
   */
  EmblemOrigin getOrigin()
  {
    GEmblemOrigin _cretval;
    _cretval = g_emblem_get_origin(cast(GEmblem*)cPtr);
    EmblemOrigin _retval = cast(EmblemOrigin)_cretval;
    return _retval;
  }
}
