module GLib.TestSuite;

import GLib.TestCase;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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

  T* cPtr(T)()
  if (is(T == GTestSuite))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Adds @test_case to @suite.
   */
  void add(TestCase testCase)
  {
    g_test_suite_add(cPtr!GTestSuite, testCase ? testCase.cPtr!GTestCase : null);
  }

  /**
   * Adds @nestedsuite to @suite.
   */
  void addSuite(TestSuite nestedsuite)
  {
    g_test_suite_add_suite(cPtr!GTestSuite, nestedsuite ? nestedsuite.cPtr!GTestSuite : null);
  }
}
