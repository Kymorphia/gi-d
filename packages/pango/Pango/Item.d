module Pango.Item;

import GLib.Boxed;
import Gid.gid;
import Pango.Analysis;
import Pango.AttrIterator;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoItem` structure stores information about a segment of text.
 * You typically obtain `PangoItems` by itemizing a piece of text
 * with func@itemize.
 */
class Item : Boxed
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
    return pango_item_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int offset()
  {
    return (cast(PangoItem*)cPtr).offset;
  }

  @property void offset(int propval)
  {
    (cast(PangoItem*)cPtr).offset = propval;
  }

  @property int length()
  {
    return (cast(PangoItem*)cPtr).length;
  }

  @property void length(int propval)
  {
    (cast(PangoItem*)cPtr).length = propval;
  }

  @property int numChars()
  {
    return (cast(PangoItem*)cPtr).numChars;
  }

  @property void numChars(int propval)
  {
    (cast(PangoItem*)cPtr).numChars = propval;
  }

  @property Analysis analysis()
  {
    return new Analysis(cast(PangoAnalysis*)&(cast(PangoItem*)cPtr).analysis);
  }

  /**
   * Creates a new `PangoItem` structure initialized to default values.
   * Returns: the newly allocated `PangoItem`, which should
   *   be freed with [Pango.Item.free].
   */
  this()
  {
    PangoItem* _cretval;
    _cretval = pango_item_new();
    this(_cretval, true);
  }

  /**
   * Add attributes to a `PangoItem`.
   * The idea is that you have attributes that don't affect itemization,
   * such as font features, so you filter them out using
   * [Pango.AttrList.filter], itemize your text, then reapply the
   * attributes to the resulting items using this function.
   * The iter should be positioned before the range of the item,
   * and will be advanced past it. This function is meant to be called
   * in a loop over the items resulting from itemization, while passing
   * the iter to each call.
   * Params:
   *   iter = a `PangoAttrIterator`
   */
  void applyAttrs(AttrIterator iter)
  {
    pango_item_apply_attrs(cast(PangoItem*)cPtr, iter ? cast(PangoAttrIterator*)iter.cPtr(false) : null);
  }

  /**
   * Copy an existing `PangoItem` structure.
   * Returns: the newly allocated `PangoItem`
   */
  Item copy()
  {
    PangoItem* _cretval;
    _cretval = pango_item_copy(cast(PangoItem*)cPtr);
    auto _retval = _cretval ? new Item(cast(void*)_cretval, true) : null;
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
   * split_offset is the length of the first item in chars, and must be
   * provided because the text used to generate the item isn't available,
   * so `[Pango.Item.split]` can't count the char length of the split items
   * itself.
   * Params:
   *   splitIndex = byte index of position to split item, relative to the
   *     start of the item
   *   splitOffset = number of chars between start of orig and split_index
   * Returns: new item representing text before split_index, which
   *   should be freed with [Pango.Item.free].
   */
  Item split(int splitIndex, int splitOffset)
  {
    PangoItem* _cretval;
    _cretval = pango_item_split(cast(PangoItem*)cPtr, splitIndex, splitOffset);
    auto _retval = _cretval ? new Item(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
