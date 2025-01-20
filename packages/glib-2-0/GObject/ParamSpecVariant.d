module GObject.ParamSpecVariant;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for #GVariant properties.
 * When comparing values with [GObject.Global.paramValuesCmp], scalar values with the same
 * type will be compared with [GLib.Variant.compare]. Other non-%NULL variants will
 * be checked for equality with [GLib.Variant.equal], and their sort order is
 * otherwise undefined. %NULL is ordered before non-%NULL variants. Two %NULL
 * values compare equal.
 */
class ParamSpecVariant : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecVariant");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
