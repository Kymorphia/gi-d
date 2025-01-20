module Pango.Matrix;

import GLib.Boxed;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoMatrix` specifies a transformation between user-space
 * and device coordinates.
 * The transformation is given by
 * ```
 * x_device \= x_user * matrix->xx + y_user * matrix->xy + matrix->x0;
 * y_device \= x_user * matrix->yx + y_user * matrix->yy + matrix->y0;
 * ```
 */
class Matrix : Boxed
{

  this()
  {
    super(safeMalloc(PangoMatrix.sizeof), true);
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
    return pango_matrix_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property double xx()
  {
    return (cast(PangoMatrix*)cPtr).xx;
  }

  @property void xx(double propval)
  {
    (cast(PangoMatrix*)cPtr).xx = propval;
  }

  @property double xy()
  {
    return (cast(PangoMatrix*)cPtr).xy;
  }

  @property void xy(double propval)
  {
    (cast(PangoMatrix*)cPtr).xy = propval;
  }

  @property double yx()
  {
    return (cast(PangoMatrix*)cPtr).yx;
  }

  @property void yx(double propval)
  {
    (cast(PangoMatrix*)cPtr).yx = propval;
  }

  @property double yy()
  {
    return (cast(PangoMatrix*)cPtr).yy;
  }

  @property void yy(double propval)
  {
    (cast(PangoMatrix*)cPtr).yy = propval;
  }

  @property double x0()
  {
    return (cast(PangoMatrix*)cPtr).x0;
  }

  @property void x0(double propval)
  {
    (cast(PangoMatrix*)cPtr).x0 = propval;
  }

  @property double y0()
  {
    return (cast(PangoMatrix*)cPtr).y0;
  }

  @property void y0(double propval)
  {
    (cast(PangoMatrix*)cPtr).y0 = propval;
  }

  /**
   * Changes the transformation represented by matrix to be the
   * transformation given by first applying transformation
   * given by new_matrix then applying the original transformation.
   * Params:
   *   newMatrix = a `PangoMatrix`
   */
  void concat(Matrix newMatrix)
  {
    pango_matrix_concat(cast(PangoMatrix*)cPtr, newMatrix ? cast(PangoMatrix*)newMatrix.cPtr(false) : null);
  }

  /**
   * Copies a `PangoMatrix`.
   * Returns: the newly allocated `PangoMatrix`
   */
  Matrix copy()
  {
    PangoMatrix* _cretval;
    _cretval = pango_matrix_copy(cast(PangoMatrix*)cPtr);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the scale factor of a matrix on the height of the font.
   * That is, the scale factor in the direction perpendicular to the
   * vector that the X coordinate is mapped to.  If the scale in the X
   * coordinate is needed as well, use [Pango.Matrix.getFontScaleFactors].
   * Returns: the scale factor of matrix on the height of the font,
   *   or 1.0 if matrix is %NULL.
   */
  double getFontScaleFactor()
  {
    double _retval;
    _retval = pango_matrix_get_font_scale_factor(cast(PangoMatrix*)cPtr);
    return _retval;
  }

  /**
   * Calculates the scale factor of a matrix on the width and height of the font.
   * That is, xscale is the scale factor in the direction of the X coordinate,
   * and yscale is the scale factor in the direction perpendicular to the
   * vector that the X coordinate is mapped to.
   * Note that output numbers will always be non-negative.
   * Params:
   *   xscale = output scale factor in the x direction
   *   yscale = output scale factor perpendicular to the x direction
   */
  void getFontScaleFactors(out double xscale, out double yscale)
  {
    pango_matrix_get_font_scale_factors(cast(PangoMatrix*)cPtr, cast(double*)&xscale, cast(double*)&yscale);
  }

  /**
   * Gets the slant ratio of a matrix.
   * For a simple shear matrix in the form:
   * 1 λ
   * 0 1
   * this is simply λ.
   * Returns: the slant ratio of matrix
   */
  double getSlantRatio()
  {
    double _retval;
    _retval = pango_matrix_get_slant_ratio(cast(PangoMatrix*)cPtr);
    return _retval;
  }

  /**
   * Changes the transformation represented by matrix to be the
   * transformation given by first rotating by degrees degrees
   * counter-clockwise then applying the original transformation.
   * Params:
   *   degrees = degrees to rotate counter-clockwise
   */
  void rotate(double degrees)
  {
    pango_matrix_rotate(cast(PangoMatrix*)cPtr, degrees);
  }

  /**
   * Changes the transformation represented by matrix to be the
   * transformation given by first scaling by sx in the X direction
   * and sy in the Y direction then applying the original
   * transformation.
   * Params:
   *   scaleX = amount to scale by in X direction
   *   scaleY = amount to scale by in Y direction
   */
  void scale(double scaleX, double scaleY)
  {
    pango_matrix_scale(cast(PangoMatrix*)cPtr, scaleX, scaleY);
  }

  /**
   * Transforms the distance vector $(LPAREN)dx,dy$(RPAREN) by matrix.
   * This is similar to [Pango.Matrix.transformPoint],
   * except that the translation components of the transformation
   * are ignored. The calculation of the returned vector is as follows:
   * ```
   * dx2 \= dx1 * xx + dy1 * xy;
   * dy2 \= dx1 * yx + dy1 * yy;
   * ```
   * Affine transformations are position invariant, so the same vector
   * always transforms to the same vector. If $(LPAREN)x1,y1$(RPAREN) transforms
   * to $(LPAREN)x2,y2$(RPAREN) then $(LPAREN)x1+dx1,y1+dy1$(RPAREN) will transform to
   * $(LPAREN)x1+dx2,y1+dy2$(RPAREN) for all values of x1 and x2.
   * Params:
   *   dx = in/out X component of a distance vector
   *   dy = in/out Y component of a distance vector
   */
  void transformDistance(ref double dx, ref double dy)
  {
    pango_matrix_transform_distance(cast(PangoMatrix*)cPtr, cast(double*)&dx, cast(double*)&dy);
  }

  /**
   * First transforms the rect using matrix, then calculates the bounding box
   * of the transformed rectangle.
   * This function is useful for example when you want to draw a rotated
   * PangoLayout to an image buffer, and want to know how large the image
   * should be and how much you should shift the layout when rendering.
   * For better accuracy, you should use [Pango.Matrix.transformRectangle]
   * on original rectangle in Pango units and convert to pixels afterward
   * using funcextents_to_pixels's first argument.
   * Params:
   *   rect = in/out bounding box in device units
   */
  void transformPixelRectangle(ref Rectangle rect)
  {
    pango_matrix_transform_pixel_rectangle(cast(PangoMatrix*)cPtr, &rect);
  }

  /**
   * Transforms the point $(LPAREN)x, y$(RPAREN) by matrix.
   * Params:
   *   x = in/out X position
   *   y = in/out Y position
   */
  void transformPoint(ref double x, ref double y)
  {
    pango_matrix_transform_point(cast(PangoMatrix*)cPtr, cast(double*)&x, cast(double*)&y);
  }

  /**
   * First transforms rect using matrix, then calculates the bounding box
   * of the transformed rectangle.
   * This function is useful for example when you want to draw a rotated
   * PangoLayout to an image buffer, and want to know how large the image
   * should be and how much you should shift the layout when rendering.
   * If you have a rectangle in device units $(LPAREN)pixels$(RPAREN), use
   * [Pango.Matrix.transformPixelRectangle].
   * If you have the rectangle in Pango units and want to convert to
   * transformed pixel bounding box, it is more accurate to transform it first
   * $(LPAREN)using this function$(RPAREN) and pass the result to [Pango.Global.extentsToPixels],
   * first argument, for an inclusive rounded rectangle.
   * However, there are valid reasons that you may want to convert
   * to pixels first and then transform, for example when the transformed
   * coordinates may overflow in Pango units $(LPAREN)large matrix translation for
   * example$(RPAREN).
   * Params:
   *   rect = in/out bounding box in Pango units
   */
  void transformRectangle(ref Rectangle rect)
  {
    pango_matrix_transform_rectangle(cast(PangoMatrix*)cPtr, &rect);
  }

  /**
   * Changes the transformation represented by matrix to be the
   * transformation given by first translating by $(LPAREN)tx, ty$(RPAREN)
   * then applying the original transformation.
   * Params:
   *   tx = amount to translate in the X direction
   *   ty = amount to translate in the Y direction
   */
  void translate(double tx, double ty)
  {
    pango_matrix_translate(cast(PangoMatrix*)cPtr, tx, ty);
  }
}
