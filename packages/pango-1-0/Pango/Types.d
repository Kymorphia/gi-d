module Pango.Types;

import Gid.gid;
import Pango.Attribute;
import Pango.Font;
import Pango.Fontset;
import Pango.GlyphItem;
import Pango.c.functions;
import Pango.c.types;


// Aliases
alias Glyph = PangoGlyph;
alias GlyphUnit = PangoGlyphUnit;
alias LayoutRun = GlyphItem;

// Enums
alias Alignment = PangoAlignment;
alias AttrType = PangoAttrType;
alias BaselineShift = PangoBaselineShift;
alias BidiType = PangoBidiType;
alias CoverageLevel = PangoCoverageLevel;
alias Direction = PangoDirection;
alias EllipsizeMode = PangoEllipsizeMode;
alias FontMask = PangoFontMask;
alias FontScale = PangoFontScale;
alias Gravity = PangoGravity;
alias GravityHint = PangoGravityHint;
alias LayoutDeserializeError = PangoLayoutDeserializeError;
alias LayoutDeserializeFlags = PangoLayoutDeserializeFlags;
alias LayoutSerializeFlags = PangoLayoutSerializeFlags;
alias Overline = PangoOverline;
alias RenderPart = PangoRenderPart;
alias Script = PangoScript;
alias ShapeFlags = PangoShapeFlags;
alias ShowFlags = PangoShowFlags;
alias Stretch = PangoStretch;
alias Style = PangoStyle;
alias TabAlign = PangoTabAlign;
alias TextTransform = PangoTextTransform;
alias Underline = PangoUnderline;
alias Variant = PangoVariant;
alias Weight = PangoWeight;
alias WrapMode = PangoWrapMode;

// Structs
alias AttrClass = PangoAttrClass;
alias ContextClass = PangoContextClass*;
alias FontsetSimpleClass = PangoFontsetSimpleClass*;
alias GlyphGeometry = PangoGlyphGeometry;
alias GlyphVisAttr = PangoGlyphVisAttr;
alias LayoutClass = PangoLayoutClass*;
alias LogAttr = PangoLogAttr;
alias Rectangle = PangoRectangle;
alias RendererPrivate = PangoRendererPrivate*;

// Callbacks
alias AttrDataCopyFunc = void* delegate();
alias AttrFilterFunc = bool delegate(Attribute attribute);
alias FontsetForeachFunc = bool delegate(Fontset fontset, Font font);

/**
 * Whether the segment should be shifted to center around the baseline.
 * This is mainly used in vertical writing directions.
 */
enum ANALYSIS_FLAG_CENTERED_BASELINE = 1;


/**
 * Whether this run holds ellipsized text.
 */
enum ANALYSIS_FLAG_IS_ELLIPSIS = 2;


/**
 * Whether to add a hyphen at the end of the run during shaping.
 */
enum ANALYSIS_FLAG_NEED_HYPHEN = 4;


/**
 * Value for @start_index in `PangoAttribute` that indicates
 * the beginning of the text.
 */
enum ATTR_INDEX_FROM_TEXT_BEGINNING = 0;


/**
 * Value for @end_index in `PangoAttribute` that indicates
 * the end of the text.
 */
enum ATTR_INDEX_TO_TEXT_END = 4294967295;


/**
 * A `PangoGlyph` value that indicates a zero-width empty glpyh.
 * This is useful for example in shaper modules, to use as the glyph for
 * various zero-width Unicode characters $(LPAREN)those passing func@is_zero_width$(RPAREN).
 */
enum GLYPH_EMPTY = 268435455;


/**
 * A `PangoGlyph` value for invalid input.
 * `PangoLayout` produces one such glyph per invalid input UTF-8 byte and such
 * a glyph is rendered as a crossed box.
 * Note that this value is defined such that it has the %PANGO_GLYPH_UNKNOWN_FLAG
 * set.
 */
enum GLYPH_INVALID_INPUT = 4294967295;


/**
 * Flag used in `PangoGlyph` to turn a `gunichar` value of a valid Unicode
 * character into an unknown-character glyph for that `gunichar`.
 * Such unknown-character glyphs may be rendered as a 'hex box'.
 */
enum GLYPH_UNKNOWN_FLAG = 268435456;


/**
 * The scale between dimensions used for Pango distances and device units.
 * The definition of device units is dependent on the output device; it will
 * typically be pixels for a screen, and points for a printer. %PANGO_SCALE is
 * currently 1024, but this may be changed in the future.
 * When setting font sizes, device units are always considered to be
 * points $(LPAREN)as in "12 point font"$(RPAREN), rather than pixels.
 */
enum SCALE = 1024;


/**
 * The major component of the version of Pango available at compile-time.
 */
enum VERSION_MAJOR = 1;


/**
 * The micro component of the version of Pango available at compile-time.
 */
enum VERSION_MICRO = 1;


/**
 * The minor component of the version of Pango available at compile-time.
 */
enum VERSION_MINOR = 52;


/**
 * A string literal containing the version of Pango available at compile-time.
 */
enum VERSION_STRING = "1.52.1";

