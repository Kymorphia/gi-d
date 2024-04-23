module GLib.TestCase;

import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque structure representing a test case.
 */
class TestCase
{
  GTestCase* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestCase");

    cInstancePtr = cast(GTestCase*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_test_case_free(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GTestCase))
  {
    return cast(T*)cInstancePtr;
  }
}
