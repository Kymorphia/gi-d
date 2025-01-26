module Pango.GlyphItem;

import GLib.Boxed;
import Gid.gid;
import Pango.AttrList;
import Pango.GlyphString;
import Pango.Item;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoGlyphItem` is a pair of a `PangoItem` and the glyphs
 * resulting from shaping the items text.
 * As an example of the usage of `PangoGlyphItem`, the results
 * of shaping text with `PangoLayout` is a list of `PangoLayoutLine`,
 * each of which contains a list of `PangoGlyphItem`.
 */
class GlyphItem : Boxed
{

  this()
  {
    super(safeMalloc(PangoGlyphItem.sizeof), true);
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
    return pango_glyph_item_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Item item()
  {
    return new Item(cast(PangoItem*)(cast(PangoGlyphItem*)cPtr).item);
  }

  @property GlyphString glyphs()
  {
    return new GlyphString(cast(PangoGlyphString*)(cast(PangoGlyphItem*)cPtr).glyphs);
  }

  @property int yOffset()
  {
    return (cast(PangoGlyphItem*)cPtr).yOffset;
  }

  @property void yOffset(int propval)
  {
    (cast(PangoGlyphItem*)cPtr).yOffset = propval;
  }

  @property int startXOffset()
  {
    return (cast(PangoGlyphItem*)cPtr).startXOffset;
  }

  @property void startXOffset(int propval)
  {
    (cast(PangoGlyphItem*)cPtr).startXOffset = propval;
  }

  @property int endXOffset()
  {
    return (cast(PangoGlyphItem*)cPtr).endXOffset;
  }

  @property void endXOffset(int propval)
  {
    (cast(PangoGlyphItem*)cPtr).endXOffset = propval;
  }

  /**
   * Splits a shaped item $(LPAREN)`PangoGlyphItem`$(RPAREN) into multiple items based
   * on an attribute list.
   * The idea is that if you have attributes that don't affect shaping,
   * such as color or underline, to avoid affecting shaping, you filter
   * them out $(LPAREN)[Pango.AttrList.filter]$(RPAREN), apply the shaping process
   * and then reapply them to the result using this function.
   * All attributes that start or end inside a cluster are applied
   * to that cluster; for instance, if half of a cluster is underlined
   * and the other-half strikethrough, then the cluster will end
   * up with both underline and strikethrough attributes. In these
   * cases, it may happen that item->extra_attrs for some of the
   * result items can have multiple attributes of the same type.
   * This function takes ownership of glyph_item; it will be reused
   * as one of the elements in the list.
   * Params:
   *   text = text that list applies to
   *   list = a `PangoAttrList`
   * Returns: a
   *   list of glyph items resulting from splitting glyph_item. Free
   *   the elements using [Pango.GlyphItem.free], the list using
   *   [GLib.SList.free].
   */
  GlyphItem[] applyAttrs(string text, AttrList list)
  {
    GSList* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = pango_glyph_item_apply_attrs(cast(PangoGlyphItem*)cPtr, _text, list ? cast(PangoAttrList*)list.cPtr(false) : null);
    auto _retval = gSListToD!(GlyphItem, GidOwnership.Full)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Make a deep copy of an existing `PangoGlyphItem` structure.
   * Returns: the newly allocated `PangoGlyphItem`
   */
  GlyphItem copy()
  {
    PangoGlyphItem* _cretval;
    _cretval = pango_glyph_item_copy(cast(PangoGlyphItem*)cPtr);
    auto _retval = _cretval ? new GlyphItem(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Modifies orig to cover only the text after split_index, and
   * returns a new item that covers the text before split_index that
   * used to be in orig.
   * You can think of split_index as the length of the returned item.
   * split_index may not be 0, and it may not be greater than or equal
   * to the length of orig $(LPAREN)that is, there must be at least one byte
   * assigned to each item, you can't create a zero-length item$(RPAREN).
   * This function is similar in function to [Pango.Item.split] $(LPAREN)and uses
   * it internally.$(RPAREN)
   * Params:
   *   text = text to which positions in orig apply
   *   splitIndex = byte index of position to split item, relative to the
   *     start of the item
   * Returns: the newly allocated item
   *   representing text before split_index, which should be freed
   *   with [Pango.GlyphItem.free].
   */
  GlyphItem split(string text, int splitIndex)
  {
    PangoGlyphItem* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = pango_glyph_item_split(cast(PangoGlyphItem*)cPtr, _text, splitIndex);
    auto _retval = _cretval ? new GlyphItem(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
