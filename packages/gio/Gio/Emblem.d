module Gio.Emblem;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GEmblem is an implementation of #GIcon that supports
 * having an emblem, which is an icon with additional properties.
 * It can than be added to a #GEmblemedIcon.
 *
 * Currently, only metainformation about the emblem's origin is
 * supported. More may be added in the future.
 */
class Emblem : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_emblem_get_type();
  }

  /**
   * a new #GEmblem.
   */
  this(Icon icon)
  {
    GEmblem* _cretval;
    _cretval = g_emblem_new(icon ? (cast(ObjectG)icon).cPtr!GIcon : null);
    this(_cretval, true);
  }

  /**
   * a new #GEmblem.
   */
  static Emblem newWithOrigin(Icon icon, EmblemOrigin origin)
  {
    GEmblem* _cretval;
    _cretval = g_emblem_new_with_origin(icon ? (cast(ObjectG)icon).cPtr!GIcon : null, origin);
    Emblem _retval = ObjectG.getDObject!Emblem(cast(GEmblem*)_cretval, true);
    return _retval;
  }

  /**
   * a #GIcon. The returned object belongs to
   * the emblem and should not be modified or freed.
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_emblem_get_icon(cPtr!GEmblem);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false);
    return _retval;
  }

  /**
   * the origin of the emblem
   */
  EmblemOrigin getOrigin()
  {
    GEmblemOrigin _cretval;
    _cretval = g_emblem_get_origin(cPtr!GEmblem);
    EmblemOrigin _retval = cast(EmblemOrigin)_cretval;
    return _retval;
  }
}
