module HarfBuzz.Types;

import Gid.gid;
import HarfBuzz.Blob;
import HarfBuzz.Buffer;
import HarfBuzz.ColorLine;
import HarfBuzz.ColorStop;
import HarfBuzz.DrawFuncs;
import HarfBuzz.DrawState;
import HarfBuzz.Font;
import HarfBuzz.HBFace;
import HarfBuzz.PaintFuncs;
import HarfBuzz.Types : DHarfBuzzFontGetFontExtentsFunc = FontGetFontExtentsFunc;
import HarfBuzz.Types : DHarfBuzzFontGetGlyphAdvanceFunc = FontGetGlyphAdvanceFunc;
import HarfBuzz.Types : DHarfBuzzFontGetGlyphKerningFunc = FontGetGlyphKerningFunc;
import HarfBuzz.Types : DHarfBuzzFontGetGlyphOriginFunc = FontGetGlyphOriginFunc;
import HarfBuzz.UnicodeFuncs;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;


// Aliases
alias Bool = hb_bool_t;
alias Codepoint = hb_codepoint_t;
alias Color = hb_color_t;
alias FontGetFontHExtentsFunc = FontGetFontExtentsFunc;
alias FontGetFontVExtentsFunc = DHarfBuzzFontGetFontExtentsFunc;
alias FontGetGlyphHAdvanceFunc = FontGetGlyphAdvanceFunc;
alias FontGetGlyphHKerningFunc = FontGetGlyphKerningFunc;
alias FontGetGlyphHOriginFunc = FontGetGlyphOriginFunc;
alias FontGetGlyphVAdvanceFunc = DHarfBuzzFontGetGlyphAdvanceFunc;
alias FontGetGlyphVKerningFunc = DHarfBuzzFontGetGlyphKerningFunc;
alias FontGetGlyphVOriginFunc = DHarfBuzzFontGetGlyphOriginFunc;
alias Mask = hb_mask_t;
alias OtNameId = hb_ot_name_id_t;
alias Position = hb_position_t;
alias Tag = hb_tag_t;

// Enums
alias AatLayoutFeatureSelector = hb_aat_layout_feature_selector_t;
alias AatLayoutFeatureType = hb_aat_layout_feature_type_t;
alias BufferClusterLevel = hb_buffer_cluster_level_t;
alias BufferContentType = hb_buffer_content_type_t;
alias BufferDiffFlags = hb_buffer_diff_flags_t;
alias BufferFlags = hb_buffer_flags_t;
alias BufferSerializeFlags = hb_buffer_serialize_flags_t;
alias BufferSerializeFormat = hb_buffer_serialize_format_t;
alias Direction = hb_direction_t;
alias GlyphFlags = hb_glyph_flags_t;
alias MemoryMode = hb_memory_mode_t;
alias OtColorPaletteFlags = hb_ot_color_palette_flags_t;
alias OtLayoutBaselineTag = hb_ot_layout_baseline_tag_t;
alias OtLayoutGlyphClass = hb_ot_layout_glyph_class_t;
alias OtMathConstant = hb_ot_math_constant_t;
alias OtMathGlyphPartFlags = hb_ot_math_glyph_part_flags_t;
alias OtMathKern = hb_ot_math_kern_t;
alias OtMetaTag = hb_ot_meta_tag_t;
alias OtMetricsTag = hb_ot_metrics_tag_t;
alias OtNameIdPredefined = hb_ot_name_id_predefined_t;
alias OtVarAxisFlags = hb_ot_var_axis_flags_t;
alias PaintCompositeMode = hb_paint_composite_mode_t;
alias PaintExtend = hb_paint_extend_t;
alias Script = hb_script_t;
alias StyleTag = hb_style_tag_t;
alias UnicodeCombiningClass = hb_unicode_combining_class_t;
alias UnicodeGeneralCategory = hb_unicode_general_category_t;

// Structs
alias AatLayoutFeatureSelectorInfo = hb_aat_layout_feature_selector_info_t;
alias FontExtents = hb_font_extents_t;
alias GlyphExtents = hb_glyph_extents_t;
alias Language = hb_language_t;
alias OtColorLayer = hb_ot_color_layer_t;
alias OtMathKernEntry = hb_ot_math_kern_entry_t;
alias OtVarAxis = hb_ot_var_axis_t;
alias VarInt = hb_var_int_t;
alias VarNum = hb_var_num_t;

// Callbacks
alias BufferMessageFunc = Bool delegate(Buffer buffer, Font font, string message);
alias ColorLineGetColorStopsFunc = uint delegate(ColorLine colorLine, void* colorLineData, uint start, ref ColorStop[] colorStops);
alias ColorLineGetExtendFunc = PaintExtend delegate(ColorLine colorLine, void* colorLineData);
alias DestroyFunc = void delegate();
alias DrawClosePathFunc = void delegate(DrawFuncs dfuncs, void* drawData, DrawState st);
alias DrawCubicToFunc = void delegate(DrawFuncs dfuncs, void* drawData, DrawState st, float control1X, float control1Y, float control2X, float control2Y, float toX, float toY);
alias DrawLineToFunc = void delegate(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY);
alias DrawMoveToFunc = void delegate(DrawFuncs dfuncs, void* drawData, DrawState st, float toX, float toY);
alias DrawQuadraticToFunc = void delegate(DrawFuncs dfuncs, void* drawData, DrawState st, float controlX, float controlY, float toX, float toY);
alias FontDrawGlyphFunc = void delegate(Font font, void* fontData, Codepoint glyph, DrawFuncs drawFuncs, void* drawData);
alias FontGetFontExtentsFunc = Bool delegate(Font font, void* fontData, out FontExtents extents);
alias FontGetGlyphAdvanceFunc = Position delegate(Font font, void* fontData, Codepoint glyph);
alias FontGetGlyphContourPointFunc = Bool delegate(Font font, void* fontData, Codepoint glyph, uint pointIndex, out Position x, out Position y);
alias FontGetGlyphExtentsFunc = Bool delegate(Font font, void* fontData, Codepoint glyph, out GlyphExtents extents);
alias FontGetGlyphFromNameFunc = Bool delegate(Font font, void* fontData, char[] name, out Codepoint glyph);
alias FontGetGlyphFunc = Bool delegate(Font font, void* fontData, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph);
alias FontGetGlyphKerningFunc = Position delegate(Font font, void* fontData, Codepoint firstGlyph, Codepoint secondGlyph);
alias FontGetGlyphNameFunc = Bool delegate(Font font, void* fontData, Codepoint glyph, ref char[] name);
alias FontGetGlyphOriginFunc = Bool delegate(Font font, void* fontData, Codepoint glyph, out Position x, out Position y);
alias FontGetGlyphShapeFunc = void delegate(Font font, void* fontData, Codepoint glyph, DrawFuncs drawFuncs, void* drawData);
alias FontGetNominalGlyphFunc = Bool delegate(Font font, void* fontData, Codepoint unicode, out Codepoint glyph);
alias FontGetVariationGlyphFunc = Bool delegate(Font font, void* fontData, Codepoint unicode, Codepoint variationSelector, out Codepoint glyph);
alias FontPaintGlyphFunc = void delegate(Font font, void* fontData, Codepoint glyph, PaintFuncs paintFuncs, void* paintData, uint paletteIndex, Color foreground);
alias PaintColorFunc = void delegate(PaintFuncs funcs, void* paintData, Bool isForeground, Color color);
alias PaintColorGlyphFunc = Bool delegate(PaintFuncs funcs, void* paintData, Codepoint glyph, Font font);
alias PaintCustomPaletteColorFunc = Bool delegate(PaintFuncs funcs, void* paintData, uint colorIndex, out Color color);
alias PaintImageFunc = Bool delegate(PaintFuncs funcs, void* paintData, Blob image, uint width, uint height, Tag format, float slant, GlyphExtents extents);
alias PaintLinearGradientFunc = void delegate(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float x1, float y1, float x2, float y2);
alias PaintPopClipFunc = void delegate(PaintFuncs funcs, void* paintData);
alias PaintPopGroupFunc = void delegate(PaintFuncs funcs, void* paintData, PaintCompositeMode mode);
alias PaintPopTransformFunc = void delegate(PaintFuncs funcs, void* paintData);
alias PaintPushClipGlyphFunc = void delegate(PaintFuncs funcs, void* paintData, Codepoint glyph, Font font);
alias PaintPushClipRectangleFunc = void delegate(PaintFuncs funcs, void* paintData, float xmin, float ymin, float xmax, float ymax);
alias PaintPushGroupFunc = void delegate(PaintFuncs funcs, void* paintData);
alias PaintPushTransformFunc = void delegate(PaintFuncs funcs, void* paintData, float xx, float yx, float xy, float yy, float dx, float dy);
alias PaintRadialGradientFunc = void delegate(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float r0, float x1, float y1, float r1);
alias PaintSweepGradientFunc = void delegate(PaintFuncs funcs, void* paintData, ColorLine colorLine, float x0, float y0, float startAngle, float endAngle);
alias ReferenceTableFunc = Blob delegate(HBFace face, Tag tag);
alias UnicodeCombiningClassFunc = UnicodeCombiningClass delegate(UnicodeFuncs ufuncs, Codepoint unicode);
alias UnicodeComposeFunc = Bool delegate(UnicodeFuncs ufuncs, Codepoint a, Codepoint b, out Codepoint ab);
alias UnicodeDecomposeFunc = Bool delegate(UnicodeFuncs ufuncs, Codepoint ab, out Codepoint a, out Codepoint b);
alias UnicodeEastasianWidthFunc = uint delegate(UnicodeFuncs ufuncs, Codepoint unicode);
alias UnicodeGeneralCategoryFunc = UnicodeGeneralCategory delegate(UnicodeFuncs ufuncs, Codepoint unicode);
alias UnicodeMirroringFunc = Codepoint delegate(UnicodeFuncs ufuncs, Codepoint unicode);
alias UnicodeScriptFunc = Script delegate(UnicodeFuncs ufuncs, Codepoint unicode);

/**
 * Used when getting or setting AAT feature selectors. Indicates that
 * there is no selector index corresponding to the selector of interest.
 */
enum AAT_LAYOUT_NO_SELECTOR_INDEX = 65535;


/**
 * The default code point for replacing invalid characters in a given encoding.
 * Set to U+FFFD REPLACEMENT CHARACTER.
 */
enum BUFFER_REPLACEMENT_CODEPOINT_DEFAULT = 65533;


/**
 * Unused #hb_codepoint_t value.
 */
enum CODEPOINT_INVALID = 4294967295;


/**
 * Special setting for #hb_feature_t.start to apply the feature from the start
 * of the buffer.
 */
enum FEATURE_GLOBAL_START = 0;


/**
 * Constant signifying that a font does not have any
 * named-instance index set.  This is the default of
 * a font.
 */
enum FONT_NO_VAR_NAMED_INSTANCE = 4294967295;


/**
 * An unset #hb_language_t.
 */
enum LANGUAGE_INVALID = 0;


/**
 * Special value for language index indicating default or unsupported language.
 */
enum OT_LAYOUT_DEFAULT_LANGUAGE_INDEX = 65535;


/**
 * Special value for feature index indicating unsupported feature.
 */
enum OT_LAYOUT_NO_FEATURE_INDEX = 65535;


/**
 * Special value for script index indicating unsupported script.
 */
enum OT_LAYOUT_NO_SCRIPT_INDEX = 65535;


/**
 * Special value for variations index indicating unsupported variation.
 */
enum OT_LAYOUT_NO_VARIATIONS_INDEX = 4294967295;


/**
 * Maximum number of OpenType tags that can correspond to a give #hb_language_t.
 */
enum OT_MAX_TAGS_PER_LANGUAGE = 3;


/**
 * Maximum number of OpenType tags that can correspond to a give #hb_script_t.
 */
enum OT_MAX_TAGS_PER_SCRIPT = 3;


/**
 * Do not use.
 */
enum OT_VAR_NO_AXIS_INDEX = 4294967295;


/**
 * [Tibetan]
 */
enum UNICODE_COMBINING_CLASS_CCC133 = 133;


/**
 * Maximum valid Unicode code point.
 */
enum UNICODE_MAX = 1114111;


/**
 * See Unicode 6.1 for details on the maximum decomposition length.
 */
enum UNICODE_MAX_DECOMPOSITION_LEN = 19;


enum VERSION_MAJOR = 8;


enum VERSION_MICRO = 0;


enum VERSION_MINOR = 3;


enum VERSION_STRING = "8.3.0";

