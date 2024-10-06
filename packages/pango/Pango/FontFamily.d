module Pango.FontFamily;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Pango.FontFace;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoFontFamily` is used to represent a family of related
 * font faces.
 * The font faces in a family share a common design, but differ in
 * slant, weight, width or other aspects.
 */
class FontFamily : ObjectG, ListModel
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
    return pango_font_family_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!PangoFontFamily;

  /**
   * Gets the `PangoFontFace` of family with the given name.
   * Params:
   *   name = the name of a face. If the name is %NULL,
   *     the family's default face $(LPAREN)fontconfig calls it "Regular"$(RPAREN)
   *     will be returned.
   * Returns: the `PangoFontFace`,
   *   or %NULL if no face with the given name exists.
   */
  FontFace getFace(string name)
  {
    PangoFontFace* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = pango_font_family_get_face(cast(PangoFontFamily*)cPtr, _name);
    auto _retval = _cretval ? ObjectG.getDObject!FontFace(cast(PangoFontFace*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the name of the family.
   * The name is unique among all fonts for the font backend and can
   * be used in a `PangoFontDescription` to specify that a face from
   * this family is desired.
   * Returns: the name of the family. This string is owned
   *   by the family object and must not be modified or freed.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = pango_font_family_get_name(cast(PangoFontFamily*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A monospace font is a font designed for text display where the the
   * characters form a regular grid.
   * For Western languages this would
   * mean that the advance width of all characters are the same, but
   * this categorization also includes Asian fonts which include
   * double-width characters: characters that occupy two grid cells.
   * [GLib.Global.unicharIswide] returns a result that indicates whether a
   * character is typically double-width in a monospace font.
   * The best way to find out the grid-cell size is to call
   * [Pango.FontMetrics.getApproximateDigitWidth], since the
   * results of [Pango.FontMetrics.getApproximateCharWidth] may
   * be affected by double-width characters.
   * Returns: %TRUE if the family is monospace.
   */
  bool isMonospace()
  {
    bool _retval;
    _retval = pango_font_family_is_monospace(cast(PangoFontFamily*)cPtr);
    return _retval;
  }

  /**
   * A variable font is a font which has axes that can be modified to
   * produce different faces.
   * Such axes are also known as _variations_; see
   * [Pango.FontDescription.setVariations] for more information.
   * Returns: %TRUE if the family is variable
   */
  bool isVariable()
  {
    bool _retval;
    _retval = pango_font_family_is_variable(cast(PangoFontFamily*)cPtr);
    return _retval;
  }

  /**
   * Lists the different font faces that make up family.
   * The faces in a family share a common design, but differ in slant, weight,
   * width and other aspects.
   * Note that the returned faces are not in any particular order, and
   * multiple faces may have the same name or characteristics.
   * `PangoFontFamily` also implemented the [Gio.ListModel] interface
   * for enumerating faces.
   * Params:
   *   faces = location to store an array of pointers to `PangoFontFace` objects,
   *     or %NULL. This array should be freed with [GLib.Global.gfree] when it is no
   *     longer needed.
   */
  void listFaces(out FontFace[] faces)
  {
    int _nFaces;
    PangoFontFace** _faces;
    pango_font_family_list_faces(cast(PangoFontFamily*)cPtr, &_faces, &_nFaces);
    faces.length = _nFaces;
    foreach (i; 0 .. _nFaces)
      faces[i] = ObjectG.getDObject!FontFace(_faces[i], false);
    safeFree(cast(void*)_faces);
  }
}
