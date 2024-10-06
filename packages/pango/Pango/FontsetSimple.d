module Pango.FontsetSimple;

import Gid.gid;
import Pango.Font;
import Pango.Fontset;
import Pango.PgLanguage;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * `PangoFontsetSimple` is a implementation of the abstract
 * `PangoFontset` base class as an array of fonts.
 * When creating a `PangoFontsetSimple`, you have to provide
 * the array of fonts that make up the fontset.
 */
class FontsetSimple : Fontset
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return pango_fontset_simple_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `PangoFontsetSimple` for the given language.
   * Params:
   *   language = a `PangoLanguage` tag
   * Returns: the newly allocated `PangoFontsetSimple`
   */
  this(PgLanguage language)
  {
    PangoFontsetSimple* _cretval;
    _cretval = pango_fontset_simple_new(language ? cast(PangoLanguage*)language.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Adds a font to the fontset.
   * The fontset takes ownership of font.
   * Params:
   *   font = a `PangoFont`.
   */
  void append(Font font)
  {
    pango_fontset_simple_append(cast(PangoFontsetSimple*)cPtr, font ? cast(PangoFont*)font.cPtr(true) : null);
  }

  /**
   * Returns the number of fonts in the fontset.
   * Returns: the size of fontset
   */
  int size()
  {
    int _retval;
    _retval = pango_fontset_simple_size(cast(PangoFontsetSimple*)cPtr);
    return _retval;
  }
}
