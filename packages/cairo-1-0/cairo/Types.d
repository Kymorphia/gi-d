module cairo.Types;

import Gid.gid;
import cairo.Context;
import cairo.Pattern;
import cairo.RectangleInt;
import cairo.ScaledFont;
import cairo.Surface;
import cairo.c.functions;
import cairo.c.types;


// Aliases
alias Bool = cairo_bool_t;

// Enums
alias Antialias = cairo_antialias_t;
alias ColorMode = cairo_color_mode_t;
alias Content = cairo_content_t;
alias DeviceType = cairo_device_type_t;
alias Dither = cairo_dither_t;
alias Extend = cairo_extend_t;
alias FillRule = cairo_fill_rule_t;
alias Filter = cairo_filter_t;
alias FontSlant = cairo_font_slant_t;
alias FontType = cairo_font_type_t;
alias FontWeight = cairo_font_weight_t;
alias Format = cairo_format_t;
alias HintMetrics = cairo_hint_metrics_t;
alias HintStyle = cairo_hint_style_t;
alias LineCap = cairo_line_cap_t;
alias LineJoin = cairo_line_join_t;
alias Operator = cairo_operator_t;
alias PathDataType = cairo_path_data_type_t;
alias PatternType = cairo_pattern_type_t;
alias PdfMetadata = cairo_pdf_metadata_t;
alias PdfOutlineFlags = cairo_pdf_outline_flags_t;
alias PdfVersion = cairo_pdf_version_t;
alias PsLevel = cairo_ps_level_t;
alias RegionOverlap = cairo_region_overlap_t;
alias ScriptMode = cairo_script_mode_t;
alias Status = cairo_status_t;
alias SubpixelOrder = cairo_subpixel_order_t;
alias SurfaceObserverMode = cairo_surface_observer_mode_t;
alias SurfaceType = cairo_surface_type_t;
alias SvgUnit = cairo_svg_unit_t;
alias SvgVersion = cairo_svg_version_t;
alias TextClusterFlags = cairo_text_cluster_flags_t;

// Structs
alias FontExtents = cairo_font_extents_t;
alias TextExtents = cairo_text_extents_t;
alias UserDataKey = cairo_user_data_key_t;

// Callbacks
alias DestroyFunc = void delegate();
alias RasterSourceAcquireFunc = Surface delegate(Pattern pattern, Surface target, RectangleInt extents);
alias RasterSourceCopyFunc = Status delegate(Pattern pattern, Pattern other);
alias RasterSourceFinishFunc = void delegate(Pattern pattern);
alias RasterSourceReleaseFunc = void delegate(Pattern pattern, Surface surface);
alias RasterSourceSnapshotFunc = Status delegate(Pattern pattern);
alias ReadFunc = Status delegate(ubyte[] data);
alias SurfaceObserverCallback = void delegate(Surface observer, Surface target);
alias UserScaledFontInitFunc = Status delegate(ScaledFont scaledFont, Context cr, FontExtents extents);
alias UserScaledFontRenderGlyphFunc = Status delegate(ScaledFont scaledFont, ulong glyph, Context cr, TextExtents extents);
alias UserScaledFontUnicodeToGlyphFunc = Status delegate(ScaledFont scaledFont, ulong unicode, out ulong glyphIndex);
alias WriteFunc = Status delegate(ubyte[] data);

/**
 * The default color palette index.
 */
enum COLOR_PALETTE_DEFAULT = 0;


/**
 * Group 3 or Group 4 CCITT facsimile encoding $(LPAREN)International
 * Telecommunication Union, Recommendations T.4 and T.6.$(RPAREN)
 */
enum MIME_TYPE_CCITT_FAX = "image/g3fax";


/**
 * Decode parameters for Group 3 or Group 4 CCITT facsimile encoding.
 * See [CCITT Fax Images][ccitt].
 */
enum MIME_TYPE_CCITT_FAX_PARAMS = "application/x-cairo.ccitt.params";


/**
 * Encapsulated PostScript file.
 * [Encapsulated PostScript File Format Specification](http://wwwimages.adobe.com/content/dam/Adobe/endevnet/postscript/pdfs/5002.EPSF_Spec.pdf)
 */
enum MIME_TYPE_EPS = "application/postscript";


/**
 * Embedding parameters Encapsulated PostScript data.
 * See [Embedding EPS files][eps].
 */
enum MIME_TYPE_EPS_PARAMS = "application/x-cairo.eps.params";


/**
 * Joint Bi-level Image Experts Group image coding standard $(LPAREN)ISO/IEC 11544$(RPAREN).
 */
enum MIME_TYPE_JBIG2 = "application/x-cairo.jbig2";


/**
 * Joint Bi-level Image Experts Group image coding standard $(LPAREN)ISO/IEC 11544$(RPAREN) global segment.
 */
enum MIME_TYPE_JBIG2_GLOBAL = "application/x-cairo.jbig2-global";


/**
 * An unique identifier shared by a JBIG2 global segment and all JBIG2 images
 * that depend on the global segment.
 */
enum MIME_TYPE_JBIG2_GLOBAL_ID = "application/x-cairo.jbig2-global-id";


/**
 * The Joint Photographic Experts Group $(LPAREN)JPEG$(RPAREN) 2000 image coding standard $(LPAREN)ISO/IEC 15444-1$(RPAREN).
 */
enum MIME_TYPE_JP2 = "image/jp2";


/**
 * The Joint Photographic Experts Group $(LPAREN)JPEG$(RPAREN) image coding standard $(LPAREN)ISO/IEC 10918-1$(RPAREN).
 */
enum MIME_TYPE_JPEG = "image/jpeg";


/**
 * The Portable Network Graphics image file format $(LPAREN)ISO/IEC 15948$(RPAREN).
 */
enum MIME_TYPE_PNG = "image/png";


/**
 * Unique identifier for a surface $(LPAREN)cairo specific MIME type$(RPAREN). All surfaces with
 * the same unique identifier will only be embedded once.
 */
enum MIME_TYPE_UNIQUE_ID = "application/x-cairo.uuid";


/**
 * URI for an image file $(LPAREN)unofficial MIME type$(RPAREN).
 */
enum MIME_TYPE_URI = "text/x-uri";


/**
 * The root outline item in [cairo.Global.pdfSurfaceAddOutline].
 */
enum PDF_OUTLINE_ROOT = 0;


/**
 * Create a content tag.
 */
enum TAG_CONTENT = "cairo.content";


/**
 * Create a content reference tag.
 */
enum TAG_CONTENT_REF = "cairo.content_ref";


/**
 * Create a destination for a hyperlink. Destination tag attributes
 * are detailed at [Destinations][dest].
 */
enum TAG_DEST = "cairo.dest";


/**
 * Create hyperlink. Link tag attributes are detailed at
 * [Links][link].
 */
enum TAG_LINK = "Link";

