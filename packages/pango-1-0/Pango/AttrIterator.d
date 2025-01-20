module Pango.AttrIterator;

import GLib.Boxed;
import GLib.SList;
import Gid.gid;
import Pango.Attribute;
import Pango.FontDescription;
import Pango.PgLanguage;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoAttrIterator` is used to iterate through a `PangoAttrList`.
 * A new iterator is created with [Pango.AttrList.getIterator].
 * Once the iterator is created, it can be advanced through the style
 * changes in the text using [Pango.AttrIterator.next]. At each
 * style change, the range of the current style segment and the attributes
 * currently in effect can be queried.
 */
class AttrIterator : Boxed
{

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
    return pango_attr_iterator_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Copy a `PangoAttrIterator`.
   * Returns: the newly allocated
   *   `PangoAttrIterator`, which should be freed with
   *   [Pango.AttrIterator.destroy]
   */
  AttrIterator copy()
  {
    PangoAttrIterator* _cretval;
    _cretval = pango_attr_iterator_copy(cast(PangoAttrIterator*)cPtr);
    auto _retval = _cretval ? new AttrIterator(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Destroy a `PangoAttrIterator` and free all associated memory.
   */
  void destroy()
  {
    pango_attr_iterator_destroy(cast(PangoAttrIterator*)cPtr);
  }

  /**
   * Find the current attribute of a particular type
   * at the iterator location.
   * When multiple attributes of the same type overlap,
   * the attribute whose range starts closest to the
   * current location is used.
   * Params:
   *   type = the type of attribute to find
   * Returns: the current
   *   attribute of the given type, or %NULL if no attribute
   *   of that type applies to the current location.
   */
  Attribute get(AttrType type)
  {
    PangoAttribute* _cretval;
    _cretval = pango_attr_iterator_get(cast(PangoAttrIterator*)cPtr, type);
    auto _retval = _cretval ? new Attribute(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a list of all attributes at the current position of the
   * iterator.
   * Returns: a list of all attributes for the current range. To free
   *   this value, call [Pango.Attribute.destroy] on each
   *   value and [GLib.SList.free] on the list.
   */
  SList!(Attribute) getAttrs()
  {
    GSList* _cretval;
    _cretval = pango_attr_iterator_get_attrs(cast(PangoAttrIterator*)cPtr);
    SList!(Attribute) _retval = new SList!(Attribute)(cast(GSList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Get the font and other attributes at the current
   * iterator position.
   * Params:
   *   desc = a `PangoFontDescription` to fill in with the current
   *     values. The family name in this structure will be set using
   *     [Pango.FontDescription.setFamilyStatic] using
   *     values from an attribute in the `PangoAttrList` associated
   *     with the iterator, so if you plan to keep it around, you
   *     must call:
   *     `pango_font_description_set_family $(LPAREN)desc, pango_font_description_get_family $(LPAREN)desc$(RPAREN)$(RPAREN)`.
   *   language = location to store language tag
   *     for item, or %NULL if none is found.
   *   extraAttrs = location in which to store a list of non-font attributes
   *     at the the current position; only the highest priority
   *     value of each attribute will be added to this list. In
   *     order to free this value, you must call
   *     [Pango.Attribute.destroy] on each member.
   */
  void getFont(FontDescription desc, out PgLanguage language, out SList!(Attribute) extraAttrs)
  {
    PangoLanguage* _language;
    GSList* _extraAttrs;
    pango_attr_iterator_get_font(cast(PangoAttrIterator*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null, &_language, &_extraAttrs);
    language = new PgLanguage(cast(void*)_language, true);
    extraAttrs = new SList!(Attribute)(_extraAttrs, GidOwnership.Full);
  }

  /**
   * Advance the iterator until the next change of style.
   * Returns: %FALSE if the iterator is at the end
   *   of the list, otherwise %TRUE
   */
  bool next()
  {
    bool _retval;
    _retval = pango_attr_iterator_next(cast(PangoAttrIterator*)cPtr);
    return _retval;
  }

  /**
   * Get the range of the current segment.
   * Note that the stored return values are signed, not unsigned
   * like the values in `PangoAttribute`. To deal with this API
   * oversight, stored return values that wouldn't fit into
   * a signed integer are clamped to %G_MAXINT.
   * Params:
   *   start = location to store the start of the range
   *   end = location to store the end of the range
   */
  void range(out int start, out int end)
  {
    pango_attr_iterator_range(cast(PangoAttrIterator*)cPtr, cast(int*)&start, cast(int*)&end);
  }
}
