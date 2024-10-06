module Graphene.Size;

import GLib.Boxed;
import Gid.gid;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A size.
 */
class Size : Boxed
{

  this()
  {
    super(safeMalloc(graphene_size_t.sizeof), true);
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
    return graphene_size_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property float width()
  {
    return (cast(graphene_size_t*)cPtr).width;
  }

  @property void width(float propval)
  {
    (cast(graphene_size_t*)cPtr).width = propval;
  }

  @property float height()
  {
    return (cast(graphene_size_t*)cPtr).height;
  }

  @property void height(float propval)
  {
    (cast(graphene_size_t*)cPtr).height = propval;
  }

  /**
   * Allocates a new #graphene_size_t.
   * The contents of the returned value are undefined.
   * Returns: the newly allocated #graphene_size_t
   */
  static Size alloc()
  {
    graphene_size_t* _cretval;
    _cretval = graphene_size_alloc();
    auto _retval = _cretval ? new Size(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the two give #graphene_size_t are equal.
   * Params:
   *   b = a #graphene_size_t
   * Returns: `true` if the sizes are equal
   */
  bool equal(Size b)
  {
    bool _retval;
    _retval = graphene_size_equal(cast(graphene_size_t*)cPtr, b ? cast(graphene_size_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes a #graphene_size_t using the given width and height.
   * Params:
   *   width = the width
   *   height = the height
   * Returns: the initialized #graphene_size_t
   */
  Size init_(float width, float height)
  {
    graphene_size_t* _cretval;
    _cretval = graphene_size_init(cast(graphene_size_t*)cPtr, width, height);
    auto _retval = _cretval ? new Size(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_size_t using the width and height of
   * the given src.
   * Params:
   *   src = a #graphene_size_t
   * Returns: the initialized #graphene_size_t
   */
  Size initFromSize(Size src)
  {
    graphene_size_t* _cretval;
    _cretval = graphene_size_init_from_size(cast(graphene_size_t*)cPtr, src ? cast(graphene_size_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Size(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates the two given #graphene_size_t using the given
   * interpolation factor.
   * Params:
   *   b = a #graphene_size_t
   *   factor = the linear interpolation factor
   *   res = return location for the interpolated size
   */
  void interpolate(Size b, double factor, out Size res)
  {
    graphene_size_t _res;
    graphene_size_interpolate(cast(graphene_size_t*)cPtr, b ? cast(graphene_size_t*)b.cPtr(false) : null, factor, &_res);
    res = new Size(cast(void*)&_res, false);
  }

  /**
   * Scales the components of a #graphene_size_t using the given factor.
   * Params:
   *   factor = the scaling factor
   *   res = return location for the scaled size
   */
  void scale(float factor, out Size res)
  {
    graphene_size_t _res;
    graphene_size_scale(cast(graphene_size_t*)cPtr, factor, &_res);
    res = new Size(cast(void*)&_res, false);
  }

  /**
   * A constant pointer to a zero #graphene_size_t, useful for
   * equality checks and interpolations.
   * Returns: a constant size
   */
  static Size zero()
  {
    const(graphene_size_t)* _cretval;
    _cretval = graphene_size_zero();
    auto _retval = _cretval ? new Size(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
