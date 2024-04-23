module Gio.FileAttributeMatcher;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Determines if a string matches a file attribute.
 */
class FileAttributeMatcher : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GFileAttributeMatcher))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_file_attribute_matcher_get_type();
  }

  /**
   * a #GFileAttributeMatcher
   */
  this(string attributes)
  {
    GFileAttributeMatcher* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    _cretval = g_file_attribute_matcher_new(_attributes);
    this(_cretval, true);
  }

  /**
   * %TRUE if the matcher matches all of the entries
   * in the given @ns, %FALSE otherwise.
   */
  bool enumerateNamespace(string ns)
  {
    bool _retval;
    const(char)* _ns = ns.toCString(false);
    _retval = g_file_attribute_matcher_enumerate_namespace(cPtr!GFileAttributeMatcher, _ns);
    return _retval;
  }

  /**
   * a string containing the next attribute or, %NULL if
   * no more attribute exist.
   */
  string enumerateNext()
  {
    const(char)* _cretval;
    _cretval = g_file_attribute_matcher_enumerate_next(cPtr!GFileAttributeMatcher);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if @attribute matches @matcher. %FALSE otherwise.
   */
  bool matches(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_attribute_matcher_matches(cPtr!GFileAttributeMatcher, _attribute);
    return _retval;
  }

  /**
   * %TRUE if the matcher only matches @attribute. %FALSE otherwise.
   */
  bool matchesOnly(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_attribute_matcher_matches_only(cPtr!GFileAttributeMatcher, _attribute);
    return _retval;
  }

  /**
   * A file attribute matcher matching all attributes of
   * @matcher that are not matched by @subtract
   */
  FileAttributeMatcher subtract(FileAttributeMatcher subtract)
  {
    GFileAttributeMatcher* _cretval;
    _cretval = g_file_attribute_matcher_subtract(cPtr!GFileAttributeMatcher, subtract ? subtract.cPtr!GFileAttributeMatcher : null);
    FileAttributeMatcher _retval = new FileAttributeMatcher(cast(GFileAttributeMatcher*)_cretval, true);
    return _retval;
  }

  /**
   * a string describing the attributes the matcher matches
   * against or %NULL if @matcher was %NULL.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_file_attribute_matcher_to_string(cPtr!GFileAttributeMatcher);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
