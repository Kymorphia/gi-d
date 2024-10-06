module Pango.FontDescription;

import GLib.Boxed;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoFontDescription` describes a font in an implementation-independent
 * manner.
 * `PangoFontDescription` structures are used both to list what fonts are
 * available on the system and also for specifying the characteristics of
 * a font to load.
 */
class FontDescription : Boxed
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
    return pango_font_description_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new font description structure with all fields unset.
   * Returns: the newly allocated `PangoFontDescription`,
   *   which should be freed using [Pango.FontDescription.free].
   */
  this()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_font_description_new();
    this(_cretval, true);
  }

  /**
   * Determines if the style attributes of new_match are a closer match
   * for desc than those of old_match are, or if old_match is %NULL,
   * determines if new_match is a match at all.
   * Approximate matching is done for weight and style; other style attributes
   * must match exactly. Style attributes are all attributes other than family
   * and size-related attributes. Approximate matching for style considers
   * %PANGO_STYLE_OBLIQUE and %PANGO_STYLE_ITALIC as matches, but not as good
   * a match as when the styles are equal.
   * Note that old_match must match desc.
   * Params:
   *   oldMatch = a `PangoFontDescription`, or %NULL
   *   newMatch = a `PangoFontDescription`
   * Returns: %TRUE if new_match is a better match
   */
  bool betterMatch(FontDescription oldMatch, FontDescription newMatch)
  {
    bool _retval;
    _retval = pango_font_description_better_match(cast(PangoFontDescription*)cPtr, oldMatch ? cast(PangoFontDescription*)oldMatch.cPtr(false) : null, newMatch ? cast(PangoFontDescription*)newMatch.cPtr(false) : null);
    return _retval;
  }

  /**
   * Make a copy of a `PangoFontDescription`.
   * Returns: the newly allocated `PangoFontDescription`,
   *   which should be freed with [Pango.FontDescription.free],
   *   or %NULL if desc was %NULL.
   */
  FontDescription copy()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_font_description_copy(cast(PangoFontDescription*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Make a copy of a `PangoFontDescription`, but don't duplicate
   * allocated fields.
   * This is like [Pango.FontDescription.copy], but only a shallow
   * copy is made of the family name and other allocated fields. The result
   * can only be used until desc is modified or freed. This is meant
   * to be used when the copy is only needed temporarily.
   * Returns: the newly allocated `PangoFontDescription`,
   *   which should be freed with [Pango.FontDescription.free],
   *   or %NULL if desc was %NULL.
   */
  FontDescription copyStatic()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_font_description_copy_static(cast(PangoFontDescription*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compares two font descriptions for equality.
   * Two font descriptions are considered equal if the fonts they describe
   * are provably identical. This means that their masks do not have to match,
   * as long as other fields are all the same. $(LPAREN)Two font descriptions may
   * result in identical fonts being loaded, but still compare %FALSE.$(RPAREN)
   * Params:
   *   desc2 = another `PangoFontDescription`
   * Returns: %TRUE if the two font descriptions are identical,
   *   %FALSE otherwise.
   */
  bool equal(FontDescription desc2)
  {
    bool _retval;
    _retval = pango_font_description_equal(cast(PangoFontDescription*)cPtr, desc2 ? cast(PangoFontDescription*)desc2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the family name field of a font description.
   * See [Pango.FontDescription.setFamily].
   * Returns: the family name field for the
   *   font description, or %NULL if not previously set. This has the same
   *   life-time as the font description itself and should not be freed.
   */
  string getFamily()
  {
    const(char)* _cretval;
    _cretval = pango_font_description_get_family(cast(PangoFontDescription*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the gravity field of a font description.
   * See [Pango.FontDescription.setGravity].
   * Returns: the gravity field for the font description.
   *   Use [Pango.FontDescription.getSetFields] to find out
   *   if the field was explicitly set or not.
   */
  Gravity getGravity()
  {
    PangoGravity _cretval;
    _cretval = pango_font_description_get_gravity(cast(PangoFontDescription*)cPtr);
    Gravity _retval = cast(Gravity)_cretval;
    return _retval;
  }

  /**
   * Determines which fields in a font description have been set.
   * Returns: a bitmask with bits set corresponding to the
   *   fields in desc that have been set.
   */
  FontMask getSetFields()
  {
    PangoFontMask _cretval;
    _cretval = pango_font_description_get_set_fields(cast(PangoFontDescription*)cPtr);
    FontMask _retval = cast(FontMask)_cretval;
    return _retval;
  }

  /**
   * Gets the size field of a font description.
   * See [Pango.FontDescription.setSize].
   * Returns: the size field for the font description in points
   *   or device units. You must call
   *   [Pango.FontDescription.getSizeIsAbsolute] to find out
   *   which is the case. Returns 0 if the size field has not previously
   *   been set or it has been set to 0 explicitly.
   *   Use [Pango.FontDescription.getSetFields] to find out
   *   if the field was explicitly set or not.
   */
  int getSize()
  {
    int _retval;
    _retval = pango_font_description_get_size(cast(PangoFontDescription*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the size of the font is in points $(LPAREN)not absolute$(RPAREN)
   * or device units $(LPAREN)absolute$(RPAREN).
   * See [Pango.FontDescription.setSize]
   * and [Pango.FontDescription.setAbsoluteSize].
   * Returns: whether the size for the font description is in
   *   points or device units. Use [Pango.FontDescription.getSetFields]
   *   to find out if the size field of the font description was explicitly
   *   set or not.
   */
  bool getSizeIsAbsolute()
  {
    bool _retval;
    _retval = pango_font_description_get_size_is_absolute(cast(PangoFontDescription*)cPtr);
    return _retval;
  }

  /**
   * Gets the stretch field of a font description.
   * See [Pango.FontDescription.setStretch].
   * Returns: the stretch field for the font description.
   *   Use [Pango.FontDescription.getSetFields] to find
   *   out if the field was explicitly set or not.
   */
  Stretch getStretch()
  {
    PangoStretch _cretval;
    _cretval = pango_font_description_get_stretch(cast(PangoFontDescription*)cPtr);
    Stretch _retval = cast(Stretch)_cretval;
    return _retval;
  }

  /**
   * Gets the style field of a `PangoFontDescription`.
   * See [Pango.FontDescription.setStyle].
   * Returns: the style field for the font description.
   *   Use [Pango.FontDescription.getSetFields] to
   *   find out if the field was explicitly set or not.
   */
  Style getStyle()
  {
    PangoStyle _cretval;
    _cretval = pango_font_description_get_style(cast(PangoFontDescription*)cPtr);
    Style _retval = cast(Style)_cretval;
    return _retval;
  }

  /**
   * Gets the variant field of a `PangoFontDescription`.
   * See [Pango.FontDescription.setVariant].
   * Returns: the variant field for the font description.
   *   Use [Pango.FontDescription.getSetFields] to find
   *   out if the field was explicitly set or not.
   */
  Variant getVariant()
  {
    PangoVariant _cretval;
    _cretval = pango_font_description_get_variant(cast(PangoFontDescription*)cPtr);
    Variant _retval = cast(Variant)_cretval;
    return _retval;
  }

  /**
   * Gets the variations field of a font description.
   * See [Pango.FontDescription.setVariations].
   * Returns: the variations field for the font
   *   description, or %NULL if not previously set. This has the same
   *   life-time as the font description itself and should not be freed.
   */
  string getVariations()
  {
    const(char)* _cretval;
    _cretval = pango_font_description_get_variations(cast(PangoFontDescription*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the weight field of a font description.
   * See [Pango.FontDescription.setWeight].
   * Returns: the weight field for the font description.
   *   Use [Pango.FontDescription.getSetFields] to find
   *   out if the field was explicitly set or not.
   */
  Weight getWeight()
  {
    PangoWeight _cretval;
    _cretval = pango_font_description_get_weight(cast(PangoFontDescription*)cPtr);
    Weight _retval = cast(Weight)_cretval;
    return _retval;
  }

  /**
   * Computes a hash of a `PangoFontDescription` structure.
   * This is suitable to be used, for example, as an argument
   * to [GLib.HashTable.new_]. The hash value is independent of desc->mask.
   * Returns: the hash value.
   */
  uint hash()
  {
    uint _retval;
    _retval = pango_font_description_hash(cast(PangoFontDescription*)cPtr);
    return _retval;
  }

  /**
   * Merges the fields that are set in desc_to_merge into the fields in
   * desc.
   * If replace_existing is %FALSE, only fields in desc that
   * are not already set are affected. If %TRUE, then fields that are
   * already set will be replaced as well.
   * If desc_to_merge is %NULL, this function performs nothing.
   * Params:
   *   descToMerge = the `PangoFontDescription` to merge from,
   *     or %NULL
   *   replaceExisting = if %TRUE, replace fields in desc with the
   *     corresponding values from desc_to_merge, even if they
   *     are already exist.
   */
  void merge(FontDescription descToMerge, bool replaceExisting)
  {
    pango_font_description_merge(cast(PangoFontDescription*)cPtr, descToMerge ? cast(PangoFontDescription*)descToMerge.cPtr(false) : null, replaceExisting);
  }

  /**
   * Merges the fields that are set in desc_to_merge into the fields in
   * desc, without copying allocated fields.
   * This is like [Pango.FontDescription.merge], but only a shallow copy
   * is made of the family name and other allocated fields. desc can only
   * be used until desc_to_merge is modified or freed. This is meant to
   * be used when the merged font description is only needed temporarily.
   * Params:
   *   descToMerge = the `PangoFontDescription` to merge from
   *   replaceExisting = if %TRUE, replace fields in desc with the
   *     corresponding values from desc_to_merge, even if they
   *     are already exist.
   */
  void mergeStatic(FontDescription descToMerge, bool replaceExisting)
  {
    pango_font_description_merge_static(cast(PangoFontDescription*)cPtr, descToMerge ? cast(PangoFontDescription*)descToMerge.cPtr(false) : null, replaceExisting);
  }

  /**
   * Sets the size field of a font description, in device units.
   * This is mutually exclusive with [Pango.FontDescription.setSize]
   * which sets the font size in points.
   * Params:
   *   size = the new size, in Pango units. There are %PANGO_SCALE Pango units
   *     in one device unit. For an output backend where a device unit is a pixel,
   *     a size value of 10 * PANGO_SCALE gives a 10 pixel font.
   */
  void setAbsoluteSize(double size)
  {
    pango_font_description_set_absolute_size(cast(PangoFontDescription*)cPtr, size);
  }

  /**
   * Sets the family name field of a font description.
   * The family
   * name represents a family of related font styles, and will
   * resolve to a particular `PangoFontFamily`. In some uses of
   * `PangoFontDescription`, it is also possible to use a comma
   * separated list of family names for this field.
   * Params:
   *   family = a string representing the family name.
   */
  void setFamily(string family)
  {
    const(char)* _family = family.toCString(false);
    pango_font_description_set_family(cast(PangoFontDescription*)cPtr, _family);
  }

  /**
   * Sets the family name field of a font description, without copying the string.
   * This is like [Pango.FontDescription.setFamily], except that no
   * copy of family is made. The caller must make sure that the
   * string passed in stays around until desc has been freed or the
   * name is set again. This function can be used if family is a static
   * string such as a C string literal, or if desc is only needed temporarily.
   * Params:
   *   family = a string representing the family name
   */
  void setFamilyStatic(string family)
  {
    const(char)* _family = family.toCString(false);
    pango_font_description_set_family_static(cast(PangoFontDescription*)cPtr, _family);
  }

  /**
   * Sets the gravity field of a font description.
   * The gravity field
   * specifies how the glyphs should be rotated. If gravity is
   * %PANGO_GRAVITY_AUTO, this actually unsets the gravity mask on
   * the font description.
   * This function is seldom useful to the user. Gravity should normally
   * be set on a `PangoContext`.
   * Params:
   *   gravity = the gravity for the font description.
   */
  void setGravity(Gravity gravity)
  {
    pango_font_description_set_gravity(cast(PangoFontDescription*)cPtr, gravity);
  }

  /**
   * Sets the size field of a font description in fractional points.
   * This is mutually exclusive with
   * [Pango.FontDescription.setAbsoluteSize].
   * Params:
   *   size = the size of the font in points, scaled by %PANGO_SCALE.
   *     $(LPAREN)That is, a size value of 10 * PANGO_SCALE is a 10 point font.
   *     The conversion factor between points and device units depends on
   *     system configuration and the output device. For screen display, a
   *     logical DPI of 96 is common, in which case a 10 point font corresponds
   *     to a 10 * $(LPAREN)96 / 72$(RPAREN) \= 13.3 pixel font.
   *     Use [Pango.FontDescription.setAbsoluteSize] if you need
   *     a particular size in device units.
   */
  void setSize(int size)
  {
    pango_font_description_set_size(cast(PangoFontDescription*)cPtr, size);
  }

  /**
   * Sets the stretch field of a font description.
   * The [Pango] field specifies how narrow or
   * wide the font should be.
   * Params:
   *   stretch = the stretch for the font description
   */
  void setStretch(Stretch stretch)
  {
    pango_font_description_set_stretch(cast(PangoFontDescription*)cPtr, stretch);
  }

  /**
   * Sets the style field of a `PangoFontDescription`.
   * The [Pango] enumeration describes whether the font is
   * slanted and the manner in which it is slanted; it can be either
   * %PANGO_STYLE_NORMAL, %PANGO_STYLE_ITALIC, or %PANGO_STYLE_OBLIQUE.
   * Most fonts will either have a italic style or an oblique style,
   * but not both, and font matching in Pango will match italic
   * specifications with oblique fonts and vice-versa if an exact
   * match is not found.
   * Params:
   *   style = the style for the font description
   */
  void setStyle(Style style)
  {
    pango_font_description_set_style(cast(PangoFontDescription*)cPtr, style);
  }

  /**
   * Sets the variant field of a font description.
   * The [Pango] can either be %PANGO_VARIANT_NORMAL
   * or %PANGO_VARIANT_SMALL_CAPS.
   * Params:
   *   variant = the variant type for the font description.
   */
  void setVariant(Variant variant)
  {
    pango_font_description_set_variant(cast(PangoFontDescription*)cPtr, variant);
  }

  /**
   * Sets the variations field of a font description.
   * OpenType font variations allow to select a font instance by
   * specifying values for a number of axes, such as width or weight.
   * The format of the variations string is
   * AXIS1\=VALUE,AXIS2\=VALUE...
   * with each AXIS a 4 character tag that identifies a font axis,
   * and each VALUE a floating point number. Unknown axes are ignored,
   * and values are clamped to their allowed range.
   * Pango does not currently have a way to find supported axes of
   * a font. Both harfbuzz and freetype have API for this. See
   * for example [hb_ot_var_get_axis_infos](https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-get-axis-infos).
   * Params:
   *   variations = a string representing the variations
   */
  void setVariations(string variations)
  {
    const(char)* _variations = variations.toCString(false);
    pango_font_description_set_variations(cast(PangoFontDescription*)cPtr, _variations);
  }

  /**
   * Sets the variations field of a font description.
   * This is like [Pango.FontDescription.setVariations], except
   * that no copy of variations is made. The caller must make sure that
   * the string passed in stays around until desc has been freed
   * or the name is set again. This function can be used if
   * variations is a static string such as a C string literal,
   * or if desc is only needed temporarily.
   * Params:
   *   variations = a string representing the variations
   */
  void setVariationsStatic(string variations)
  {
    const(char)* _variations = variations.toCString(false);
    pango_font_description_set_variations_static(cast(PangoFontDescription*)cPtr, _variations);
  }

  /**
   * Sets the weight field of a font description.
   * The weight field
   * specifies how bold or light the font should be. In addition
   * to the values of the [Pango] enumeration, other
   * intermediate numeric values are possible.
   * Params:
   *   weight = the weight for the font description.
   */
  void setWeight(Weight weight)
  {
    pango_font_description_set_weight(cast(PangoFontDescription*)cPtr, weight);
  }

  /**
   * Creates a filename representation of a font description.
   * The filename is identical to the result from calling
   * [Pango.FontDescription.toString_], but with underscores
   * instead of characters that are untypical in filenames, and in
   * lower case only.
   * Returns: a new string that must be freed with [GLib.Global.gfree].
   */
  string toFilename()
  {
    char* _cretval;
    _cretval = pango_font_description_to_filename(cast(PangoFontDescription*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Creates a string representation of a font description.
   * See [Pango.FontDescription.fromString] for a description
   * of the format of the string representation. The family list in
   * the string description will only have a terminating comma if
   * the last word of the list is a valid style option.
   * Returns: a new string that must be freed with [GLib.Global.gfree].
   */
  string toString_()
  {
    char* _cretval;
    _cretval = pango_font_description_to_string(cast(PangoFontDescription*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Unsets some of the fields in a `PangoFontDescription`.
   * The unset fields will get back to their default values.
   * Params:
   *   toUnset = bitmask of fields in the desc to unset.
   */
  void unsetFields(FontMask toUnset)
  {
    pango_font_description_unset_fields(cast(PangoFontDescription*)cPtr, toUnset);
  }

  /**
   * Creates a new font description from a string representation.
   * The string must have the form
   * "\[FAMILY-LIST] \[STYLE-OPTIONS] \[SIZE] \[VARIATIONS]",
   * where FAMILY-LIST is a comma-separated list of families optionally
   * terminated by a comma, STYLE_OPTIONS is a whitespace-separated list
   * of words where each word describes one of style, variant, weight,
   * stretch, or gravity, and SIZE is a decimal number $(LPAREN)size in points$(RPAREN)
   * or optionally followed by the unit modifier "px" for absolute size.
   * VARIATIONS is a comma-separated list of font variation
   * specifications of the form "\axis\=value" $(LPAREN)the \= sign is optional$(RPAREN).
   * The following words are understood as styles:
   * "Normal", "Roman", "Oblique", "Italic".
   * The following words are understood as variants:
   * "Small-Caps", "All-Small-Caps", "Petite-Caps", "All-Petite-Caps",
   * "Unicase", "Title-Caps".
   * The following words are understood as weights:
   * "Thin", "Ultra-Light", "Extra-Light", "Light", "Semi-Light",
   * "Demi-Light", "Book", "Regular", "Medium", "Semi-Bold", "Demi-Bold",
   * "Bold", "Ultra-Bold", "Extra-Bold", "Heavy", "Black", "Ultra-Black",
   * "Extra-Black".
   * The following words are understood as stretch values:
   * "Ultra-Condensed", "Extra-Condensed", "Condensed", "Semi-Condensed",
   * "Semi-Expanded", "Expanded", "Extra-Expanded", "Ultra-Expanded".
   * The following words are understood as gravity values:
   * "Not-Rotated", "South", "Upside-Down", "North", "Rotated-Left",
   * "East", "Rotated-Right", "West".
   * Any one of the options may be absent. If FAMILY-LIST is absent, then
   * the family_name field of the resulting font description will be
   * initialized to %NULL. If STYLE-OPTIONS is missing, then all style
   * options will be set to the default values. If SIZE is missing, the
   * size in the resulting font description will be set to 0.
   * A typical example:
   * "Cantarell Italic Light 15 \wght\=200"
   * Params:
   *   str = string representation of a font description.
   * Returns: a new `PangoFontDescription`.
   */
  static FontDescription fromString(string str)
  {
    PangoFontDescription* _cretval;
    const(char)* _str = str.toCString(false);
    _cretval = pango_font_description_from_string(_str);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
