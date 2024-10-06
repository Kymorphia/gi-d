module Pango.AttrFontFeatures;

import Gid.gid;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrFontFeatures` structure is used to represent OpenType
 * font features as an attribute.
 */
class AttrFontFeatures
{
  PangoAttrFontFeatures cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrFontFeatures");

    cInstance = *cast(PangoAttrFontFeatures*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrFontFeatures*)cPtr).attr);
  }

  @property string features()
  {
    return (cast(PangoAttrFontFeatures*)cPtr).features.fromCString(false);
  }

  @property void features(string propval)
  {
    safeFree(cast(void*)(cast(PangoAttrFontFeatures*)cPtr).features);
    (cast(PangoAttrFontFeatures*)cPtr).features = propval.toCString(true);
  }

  /**
   * Create a new font features tag attribute.
   * You can use this attribute to select OpenType font features like small-caps,
   * alternative glyphs, ligatures, etc. for fonts that support them.
   * Params:
   *   features = a string with OpenType font features, with the syntax of the [CSS
   *     font-feature-settings property]$(LPAREN)https://www.w3.org/TR/css-fonts-4/#font-rend-desc$(RPAREN)
   * Returns: the newly allocated
   *   `PangoAttribute`, which should be freed with
   *   [Pango.Attribute.destroy]
   */
  static Attribute new_(string features)
  {
    PangoAttribute* _cretval;
    const(char)* _features = features.toCString(false);
    _cretval = pango_attr_font_features_new(_features);
    auto _retval = _cretval ? new Attribute(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
