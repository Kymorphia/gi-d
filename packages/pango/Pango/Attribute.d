module Pango.Attribute;

import GLib.Boxed;
import Gid.gid;
import Pango.AttrColor;
import Pango.AttrFloat;
import Pango.AttrFontDesc;
import Pango.AttrFontFeatures;
import Pango.AttrInt;
import Pango.AttrLanguage;
import Pango.AttrShape;
import Pango.AttrSize;
import Pango.AttrString;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttribute` structure represents the common portions of all
 * attributes.
 * Particular types of attributes include this structure as their initial
 * portion. The common portion of the attribute holds the range to which
 * the value in the type-specific part of the attribute applies and should
 * be initialized using [Pango.Attribute.init_]. By default, an attribute
 * will have an all-inclusive range of [0,%G_MAXUINT].
 */
class Attribute : Boxed
{

  this()
  {
    super(safeMalloc(PangoAttribute.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return pango_attribute_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property AttrClass klass()
  {
    return *(cast(PangoAttribute*)cPtr).klass;
  }

  @property void klass(AttrClass propval)
  {
    (cast(PangoAttribute*)cPtr).klass = &propval;
  }

  @property uint startIndex()
  {
    return (cast(PangoAttribute*)cPtr).startIndex;
  }

  @property void startIndex(uint propval)
  {
    (cast(PangoAttribute*)cPtr).startIndex = propval;
  }

  @property uint endIndex()
  {
    return (cast(PangoAttribute*)cPtr).endIndex;
  }

  @property void endIndex(uint propval)
  {
    (cast(PangoAttribute*)cPtr).endIndex = propval;
  }

  /**
   * Returns the attribute cast to `PangoAttrColor`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrColor`,
   *   or %NULL if it's not a color attribute
   */
  AttrColor asColor()
  {
    PangoAttrColor* _cretval;
    _cretval = pango_attribute_as_color(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrColor(cast(PangoAttrColor*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrFloat`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrFloat`,
   *   or %NULL if it's not a floating point attribute
   */
  AttrFloat asFloat()
  {
    PangoAttrFloat* _cretval;
    _cretval = pango_attribute_as_float(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrFloat(cast(PangoAttrFloat*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrFontDesc`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrFontDesc`,
   *   or %NULL if it's not a font description attribute
   */
  AttrFontDesc asFontDesc()
  {
    PangoAttrFontDesc* _cretval;
    _cretval = pango_attribute_as_font_desc(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrFontDesc(cast(PangoAttrFontDesc*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrFontFeatures`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrFontFeatures`,
   *   or %NULL if it's not a font features attribute
   */
  AttrFontFeatures asFontFeatures()
  {
    PangoAttrFontFeatures* _cretval;
    _cretval = pango_attribute_as_font_features(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrFontFeatures(cast(PangoAttrFontFeatures*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrInt`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrInt`,
   *   or %NULL if it's not an integer attribute
   */
  AttrInt asInt()
  {
    PangoAttrInt* _cretval;
    _cretval = pango_attribute_as_int(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrInt(cast(PangoAttrInt*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrLanguage`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrLanguage`,
   *   or %NULL if it's not a language attribute
   */
  AttrLanguage asLanguage()
  {
    PangoAttrLanguage* _cretval;
    _cretval = pango_attribute_as_language(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrLanguage(cast(PangoAttrLanguage*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrShape`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrShape`,
   *   or %NULL if it's not a shape attribute
   */
  AttrShape asShape()
  {
    PangoAttrShape* _cretval;
    _cretval = pango_attribute_as_shape(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrShape(cast(PangoAttrShape*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrSize`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrSize`,
   *   or NULL if it's not a size attribute
   */
  AttrSize asSize()
  {
    PangoAttrSize* _cretval;
    _cretval = pango_attribute_as_size(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrSize(cast(PangoAttrSize*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns the attribute cast to `PangoAttrString`.
   * This is mainly useful for language bindings.
   * Returns: The attribute as `PangoAttrString`,
   *   or %NULL if it's not a string attribute
   */
  AttrString asString()
  {
    PangoAttrString* _cretval;
    _cretval = pango_attribute_as_string(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new AttrString(cast(PangoAttrString*)_cretval) : null;
    return _retval;
  }

  /**
   * Make a copy of an attribute.
   * Returns: the newly allocated
   *   `PangoAttribute`, which should be freed with
   *   [Pango.Attribute.destroy].
   */
  Attribute copy()
  {
    PangoAttribute* _cretval;
    _cretval = pango_attribute_copy(cast(PangoAttribute*)cPtr);
    auto _retval = _cretval ? new Attribute(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Destroy a `PangoAttribute` and free all associated memory.
   */
  void destroy()
  {
    pango_attribute_destroy(cast(PangoAttribute*)cPtr);
  }

  /**
   * Compare two attributes for equality.
   * This compares only the actual value of the two
   * attributes and not the ranges that the attributes
   * apply to.
   * Params:
   *   attr2 = another `PangoAttribute`
   * Returns: %TRUE if the two attributes have the same value
   */
  bool equal(Attribute attr2)
  {
    bool _retval;
    _retval = pango_attribute_equal(cast(PangoAttribute*)cPtr, attr2 ? cast(PangoAttribute*)attr2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes attr's klass to klass, it's start_index to
   * %PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING and end_index to
   * %PANGO_ATTR_INDEX_TO_TEXT_END such that the attribute applies
   * to the entire text by default.
   * Params:
   *   klass = a `PangoAttrClass`
   */
  void init_(AttrClass klass)
  {
    pango_attribute_init(cast(PangoAttribute*)cPtr, &klass);
  }
}
