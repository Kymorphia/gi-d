module cairo.TextCluster;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * The #cairo_text_cluster_t structure holds information about a single
 * <firstterm>text cluster</firstterm>.  A text cluster is a minimal
 * mapping of some glyphs corresponding to some UTF-8 text.
 * For a cluster to be valid, both @num_bytes and @num_glyphs should
 * be non-negative, and at least one should be non-zero.
 * Note that clusters with zero glyphs are not as well supported as
 * normal clusters.  For example, PDF rendering applications typically
 * ignore those clusters when PDF text is being selected.
 * See [cairo.Context.showTextGlyphs] for how clusters are used in advanced
 * text operations.
 */
class TextCluster : Boxed
{

  this()
  {
    super(safeMalloc(cairo_text_cluster_t.sizeof), true);
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
    return cairo_gobject_text_cluster_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int numBytes()
  {
    return (cast(cairo_text_cluster_t*)cPtr).numBytes;
  }

  @property void numBytes(int propval)
  {
    (cast(cairo_text_cluster_t*)cPtr).numBytes = propval;
  }

  @property int numGlyphs()
  {
    return (cast(cairo_text_cluster_t*)cPtr).numGlyphs;
  }

  @property void numGlyphs(int propval)
  {
    (cast(cairo_text_cluster_t*)cPtr).numGlyphs = propval;
  }
}
