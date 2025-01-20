module GLib.TestSuite;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * An opaque structure representing a test suite.
 */
class TestSuite
{
  GTestSuite* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestSuite");

    cInstancePtr = cast(GTestSuite*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_test_suite_free(cInstancePtr);
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Adds test_case to suite.
   * Params:
   *   testCase = a #GTestCase
   */
  void add(TestCase testCase)
  {
    g_test_suite_add(cast(GTestSuite*)cPtr, testCase);
  }

  /**
   * Adds nestedsuite to suite.
   * Params:
   *   nestedsuite = another #GTestSuite
   */
  void addSuite(TestSuite nestedsuite)
  {
    g_test_suite_add_suite(cast(GTestSuite*)cPtr, nestedsuite ? cast(GTestSuite*)nestedsuite.cPtr : null);
  }
}
