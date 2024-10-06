module cairo.Matrix;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A #cairo_matrix_t holds an affine transformation, such as a scale,
 * rotation, shear, or a combination of those. The transformation of
 * a point $(LPAREN)x, y$(RPAREN) is given by:
 * <programlisting>
 * x_new \= xx * x + xy * y + x0;
 * y_new \= yx * x + yy * y + y0;
 * </programlisting>
 */
class Matrix : Boxed
{

  this()
  {
    super(safeMalloc(cairo_matrix_t.sizeof), true);
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
    return cairo_gobject_matrix_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property double xx()
  {
    return (cast(cairo_matrix_t*)cPtr).xx;
  }

  @property void xx(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).xx = propval;
  }

  @property double yx()
  {
    return (cast(cairo_matrix_t*)cPtr).yx;
  }

  @property void yx(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).yx = propval;
  }

  @property double xy()
  {
    return (cast(cairo_matrix_t*)cPtr).xy;
  }

  @property void xy(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).xy = propval;
  }

  @property double yy()
  {
    return (cast(cairo_matrix_t*)cPtr).yy;
  }

  @property void yy(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).yy = propval;
  }

  @property double x0()
  {
    return (cast(cairo_matrix_t*)cPtr).x0;
  }

  @property void x0(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).x0 = propval;
  }

  @property double y0()
  {
    return (cast(cairo_matrix_t*)cPtr).y0;
  }

  @property void y0(double propval)
  {
    (cast(cairo_matrix_t*)cPtr).y0 = propval;
  }

  /**
   * Sets matrix to be the affine transformation given by
   * xx, yx, xy, yy, x0, y0. The transformation is given
   * by:
   * <programlisting>
   * x_new \= xx * x + xy * y + x0;
   * y_new \= yx * x + yy * y + y0;
   * </programlisting>
   * Params:
   *   xx = xx component of the affine transformation
   *   yx = yx component of the affine transformation
   *   xy = xy component of the affine transformation
   *   yy = yy component of the affine transformation
   *   x0 = X translation component of the affine transformation
   *   y0 = Y translation component of the affine transformation
   */
  void init_(double xx, double yx, double xy, double yy, double x0, double y0)
  {
    cairo_matrix_init(cast(cairo_matrix_t*)cPtr, xx, yx, xy, yy, x0, y0);
  }

  /**
   * Modifies matrix to be an identity transformation.
   */
  void initIdentity()
  {
    cairo_matrix_init_identity(cast(cairo_matrix_t*)cPtr);
  }

  /**
   * Initialized matrix to a transformation that rotates by radians.
   * Params:
   *   radians = angle of rotation, in radians. The direction of rotation
   *     is defined such that positive angles rotate in the direction from
   *     the positive X axis toward the positive Y axis. With the default
   *     axis orientation of cairo, positive angles rotate in a clockwise
   *     direction.
   */
  void initRotate(double radians)
  {
    cairo_matrix_init_rotate(cast(cairo_matrix_t*)cPtr, radians);
  }

  /**
   * Initializes matrix to a transformation that scales by sx and sy
   * in the X and Y dimensions, respectively.
   * Params:
   *   sx = scale factor in the X direction
   *   sy = scale factor in the Y direction
   */
  void initScale(double sx, double sy)
  {
    cairo_matrix_init_scale(cast(cairo_matrix_t*)cPtr, sx, sy);
  }

  /**
   * Initializes matrix to a transformation that translates by tx and
   * ty in the X and Y dimensions, respectively.
   * Params:
   *   tx = amount to translate in the X direction
   *   ty = amount to translate in the Y direction
   */
  void initTranslate(double tx, double ty)
  {
    cairo_matrix_init_translate(cast(cairo_matrix_t*)cPtr, tx, ty);
  }

  /**
   * Changes matrix to be the inverse of its original value. Not
   * all transformation matrices have inverses; if the matrix
   * collapses points together $(LPAREN)it is <firstterm>degenerate</firstterm>$(RPAREN),
   * then it has no inverse and this function will fail.
   * Returns: If matrix has an inverse, modifies matrix to
   *   be the inverse matrix and returns %CAIRO_STATUS_SUCCESS. Otherwise,
   *   returns %CAIRO_STATUS_INVALID_MATRIX.
   */
  Status invert()
  {
    cairo_status_t _cretval;
    _cretval = cairo_matrix_invert(cast(cairo_matrix_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Multiplies the affine transformations in a and b together
   * and stores the result in result. The effect of the resulting
   * transformation is to first apply the transformation in a to the
   * coordinates and then apply the transformation in b to the
   * coordinates.
   * It is allowable for result to be identical to either a or b.
   * Params:
   *   a = a #cairo_matrix_t
   *   b = a #cairo_matrix_t
   */
  void multiply(Matrix a, Matrix b)
  {
    cairo_matrix_multiply(cast(cairo_matrix_t*)cPtr, a ? cast(cairo_matrix_t*)a.cPtr(false) : null, b ? cast(cairo_matrix_t*)b.cPtr(false) : null);
  }

  /**
   * Applies rotation by radians to the transformation in
   * matrix. The effect of the new transformation is to first rotate the
   * coordinates by radians, then apply the original transformation
   * to the coordinates.
   * Params:
   *   radians = angle of rotation, in radians. The direction of rotation
   *     is defined such that positive angles rotate in the direction from
   *     the positive X axis toward the positive Y axis. With the default
   *     axis orientation of cairo, positive angles rotate in a clockwise
   *     direction.
   */
  void rotate(double radians)
  {
    cairo_matrix_rotate(cast(cairo_matrix_t*)cPtr, radians);
  }

  /**
   * Applies scaling by sx, sy to the transformation in matrix. The
   * effect of the new transformation is to first scale the coordinates
   * by sx and sy, then apply the original transformation to the coordinates.
   * Params:
   *   sx = scale factor in the X direction
   *   sy = scale factor in the Y direction
   */
  void scale(double sx, double sy)
  {
    cairo_matrix_scale(cast(cairo_matrix_t*)cPtr, sx, sy);
  }

  /**
   * Transforms the distance vector $(LPAREN)dx,dy$(RPAREN) by matrix. This is
   * similar to [cairo.Matrix.transformPoint] except that the translation
   * components of the transformation are ignored. The calculation of
   * the returned vector is as follows:
   * <programlisting>
   * dx_new \= xx * dx + xy * dy;
   * dy_new \= yx * dx + yy * dy;
   * </programlisting>
   * Params:
   *   dx = X component of a distance vector. An in/out parameter
   *   dy = Y component of a distance vector. An in/out parameter
   */
  void transformDistance(out double dx, out double dy)
  {
    cairo_matrix_transform_distance(cast(cairo_matrix_t*)cPtr, cast(double*)&dx, cast(double*)&dy);
  }

  /**
   * Transforms the point $(LPAREN)x, y$(RPAREN) by matrix.
   * Params:
   *   x = X position. An in/out parameter
   *   y = Y position. An in/out parameter
   */
  void transformPoint(out double x, out double y)
  {
    cairo_matrix_transform_point(cast(cairo_matrix_t*)cPtr, cast(double*)&x, cast(double*)&y);
  }

  /**
   * Applies a translation by tx, ty to the transformation in
   * matrix. The effect of the new transformation is to first translate
   * the coordinates by tx and ty, then apply the original transformation
   * to the coordinates.
   * Params:
   *   tx = amount to translate in the X direction
   *   ty = amount to translate in the Y direction
   */
  void translate(double tx, double ty)
  {
    cairo_matrix_translate(cast(cairo_matrix_t*)cPtr, tx, ty);
  }
}
