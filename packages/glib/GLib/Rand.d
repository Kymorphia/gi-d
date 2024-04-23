module GLib.Rand;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The GRand struct is an opaque data structure. It should only be
 * accessed through the g_rand_* functions.
 */
class Rand
{
  GRand* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Rand");

    cInstancePtr = cast(GRand*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_rand_free(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GRand))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * a random number
   */
  double double_()
  {
    double _retval;
    _retval = g_rand_double(cPtr!GRand);
    return _retval;
  }

  /**
   * a random number
   */
  double doubleRange(double begin, double end)
  {
    double _retval;
    _retval = g_rand_double_range(cPtr!GRand, begin, end);
    return _retval;
  }

  /**
   * a random number
   */
  uint int_()
  {
    uint _retval;
    _retval = g_rand_int(cPtr!GRand);
    return _retval;
  }

  /**
   * a random number
   */
  int intRange(int begin, int end)
  {
    int _retval;
    _retval = g_rand_int_range(cPtr!GRand, begin, end);
    return _retval;
  }

  /**
   * Sets the seed for the random number generator #GRand to @seed.
   */
  void setSeed(uint seed)
  {
    g_rand_set_seed(cPtr!GRand, seed);
  }

  /**
   * Initializes the random number generator by an array of longs.
   * Array can be of arbitrary size, though only the first 624 values
   * are taken.  This function is useful if you have many low entropy
   * seeds, or if you require more then 32 bits of actual entropy for
   * your application.
   */
  void setSeedArray(uint[] seed)
  {
    auto _seed = cast(const(uint)*)seed.ptr;
    g_rand_set_seed_array(cPtr!GRand, _seed, seed ? cast(uint)seed.length : 0);
  }
}
