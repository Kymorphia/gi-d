module Pango.GlyphItemIter;

import GLib.Boxed;
import Gid.gid;
import Pango.GlyphItem;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoGlyphItemIter` is an iterator over the clusters in a
 * `PangoGlyphItem`.
 * The *forward direction* of the iterator is the logical direction of text.
 * That is, with increasing @start_index and @start_char values. If @glyph_item
 * is right-to-left $(LPAREN)that is, if `glyph_item->item->analysis.level` is odd$(RPAREN),
 * then @start_glyph decreases as the iterator moves forward.  Moreover,
 * in right-to-left cases, @start_glyph is greater than @end_glyph.
 * An iterator should be initialized using either
 * [Pango.GlyphItemIter.initStart] or
 * [Pango.GlyphItemIter.initEnd], for forward and backward iteration
 * respectively, and walked over using any desired mixture of
 * [Pango.GlyphItemIter.nextCluster] and
 * [Pango.GlyphItemIter.prevCluster].
 * A common idiom for doing a forward iteration over the clusters is:
 * ```
 * PangoGlyphItemIter cluster_iter;
 * gboolean have_cluster;
 * for $(LPAREN)have_cluster \= pango_glyph_item_iter_init_start $(LPAREN)&cluster_iter,
 * glyph_item, text$(RPAREN);
 * have_cluster;
 * have_cluster \= pango_glyph_item_iter_next_cluster $(LPAREN)&cluster_iter$(RPAREN)$(RPAREN)
 * {
 * ...
 * }
 * ```
 * Note that @text is the start of the text for layout, which is then
 * indexed by `glyph_item->item->offset` to get to the text of @glyph_item.
 * The @start_index and @end_index values can directly index into @text. The
 * @start_glyph, @end_glyph, @start_char, and @end_char values however are
 * zero-based for the @glyph_item.  For each cluster, the item pointed at by
 * the start variables is included in the cluster while the one pointed at by
 * end variables is not.
 * None of the members of a `PangoGlyphItemIter` should be modified manually.
 */
class GlyphItemIter : Boxed
{

  this()
  {
    super(safeMalloc(PangoGlyphItemIter.sizeof), true);
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
    return pango_glyph_item_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property GlyphItem glyphItem()
  {
    return new GlyphItem(cast(PangoGlyphItem*)(cast(PangoGlyphItemIter*)cPtr).glyphItem);
  }

  @property string text()
  {
    return (cast(PangoGlyphItemIter*)cPtr).text.fromCString(false);
  }

  @property void text(string propval)
  {
    safeFree(cast(void*)(cast(PangoGlyphItemIter*)cPtr).text);
    (cast(PangoGlyphItemIter*)cPtr).text = propval.toCString(true);
  }

  @property int startGlyph()
  {
    return (cast(PangoGlyphItemIter*)cPtr).startGlyph;
  }

  @property void startGlyph(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).startGlyph = propval;
  }

  @property int startIndex()
  {
    return (cast(PangoGlyphItemIter*)cPtr).startIndex;
  }

  @property void startIndex(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).startIndex = propval;
  }

  @property int startChar()
  {
    return (cast(PangoGlyphItemIter*)cPtr).startChar;
  }

  @property void startChar(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).startChar = propval;
  }

  @property int endGlyph()
  {
    return (cast(PangoGlyphItemIter*)cPtr).endGlyph;
  }

  @property void endGlyph(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).endGlyph = propval;
  }

  @property int endIndex()
  {
    return (cast(PangoGlyphItemIter*)cPtr).endIndex;
  }

  @property void endIndex(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).endIndex = propval;
  }

  @property int endChar()
  {
    return (cast(PangoGlyphItemIter*)cPtr).endChar;
  }

  @property void endChar(int propval)
  {
    (cast(PangoGlyphItemIter*)cPtr).endChar = propval;
  }

  /**
   * Make a shallow copy of an existing `PangoGlyphItemIter` structure.
   * Returns: the newly allocated `PangoGlyphItemIter`
   */
  GlyphItemIter copy()
  {
    PangoGlyphItemIter* _cretval;
    _cretval = pango_glyph_item_iter_copy(cast(PangoGlyphItemIter*)cPtr);
    auto _retval = _cretval ? new GlyphItemIter(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Initializes a `PangoGlyphItemIter` structure to point to the
   * last cluster in a glyph item.
   * See `PangoGlyphItemIter` for details of cluster orders.
   * Params:
   *   glyphItem = the glyph item to iterate over
   *   text = text corresponding to the glyph item
   * Returns: %FALSE if there are no clusters in the glyph item
   */
  bool initEnd(GlyphItem glyphItem, string text)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    _retval = pango_glyph_item_iter_init_end(cast(PangoGlyphItemIter*)cPtr, glyphItem ? cast(PangoGlyphItem*)glyphItem.cPtr(false) : null, _text);
    return _retval;
  }

  /**
   * Initializes a `PangoGlyphItemIter` structure to point to the
   * first cluster in a glyph item.
   * See `PangoGlyphItemIter` for details of cluster orders.
   * Params:
   *   glyphItem = the glyph item to iterate over
   *   text = text corresponding to the glyph item
   * Returns: %FALSE if there are no clusters in the glyph item
   */
  bool initStart(GlyphItem glyphItem, string text)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    _retval = pango_glyph_item_iter_init_start(cast(PangoGlyphItemIter*)cPtr, glyphItem ? cast(PangoGlyphItem*)glyphItem.cPtr(false) : null, _text);
    return _retval;
  }

  /**
   * Advances the iterator to the next cluster in the glyph item.
   * See `PangoGlyphItemIter` for details of cluster orders.
   * Returns: %TRUE if the iterator was advanced,
   *   %FALSE if we were already on the  last cluster.
   */
  bool nextCluster()
  {
    bool _retval;
    _retval = pango_glyph_item_iter_next_cluster(cast(PangoGlyphItemIter*)cPtr);
    return _retval;
  }

  /**
   * Moves the iterator to the preceding cluster in the glyph item.
   * See `PangoGlyphItemIter` for details of cluster orders.
   * Returns: %TRUE if the iterator was moved,
   *   %FALSE if we were already on the first cluster.
   */
  bool prevCluster()
  {
    bool _retval;
    _retval = pango_glyph_item_iter_prev_cluster(cast(PangoGlyphItemIter*)cPtr);
    return _retval;
  }
}
