module Gio.FileAttributeMatcher;

import GLib.Boxed;
import Gid.gid;
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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_file_attribute_matcher_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new file attribute matcher, which matches attributes
   * against a given string. #GFileAttributeMatchers are reference
   * counted structures, and are created with a reference count of 1. If
   * the number of references falls to 0, the #GFileAttributeMatcher is
   * automatically destroyed.
   * The attributes string should be formatted with specific keys separated
   * from namespaces with a double colon. Several "namespace::key" strings may be
   * concatenated with a single comma $(LPAREN)e.g. "standard::type,standard::is-hidden"$(RPAREN).
   * The wildcard "*" may be used to match all keys and namespaces, or
   * "namespace::*" will match all keys in a given namespace.
   * ## Examples of file attribute matcher strings and results
   * - `"*"`: matches all attributes.
   * - `"standard::is-hidden"`: matches only the key is-hidden in the
   * standard namespace.
   * - `"standard::type,unix::*"`: matches the type key in the standard
   * namespace and all keys in the unix namespace.
   * Params:
   *   attributes = an attribute string to match.
   * Returns: a #GFileAttributeMatcher
   */
  this(string attributes)
  {
    GFileAttributeMatcher* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    _cretval = g_file_attribute_matcher_new(_attributes);
    this(_cretval, true);
  }

  /**
   * Checks if the matcher will match all of the keys in a given namespace.
   * This will always return %TRUE if a wildcard character is in use $(LPAREN)e.g. if
   * matcher was created with "standard::*" and ns is "standard", or if matcher was created
   * using "*" and namespace is anything.$(RPAREN)
   * TODO: this is awkwardly worded.
   * Params:
   *   ns = a string containing a file attribute namespace.
   * Returns: %TRUE if the matcher matches all of the entries
   *   in the given ns, %FALSE otherwise.
   */
  bool enumerateNamespace(string ns)
  {
    bool _retval;
    const(char)* _ns = ns.toCString(false);
    _retval = g_file_attribute_matcher_enumerate_namespace(cast(GFileAttributeMatcher*)cPtr, _ns);
    return _retval;
  }

  /**
   * Gets the next matched attribute from a #GFileAttributeMatcher.
   * Returns: a string containing the next attribute or, %NULL if
   *   no more attribute exist.
   */
  string enumerateNext()
  {
    const(char)* _cretval;
    _cretval = g_file_attribute_matcher_enumerate_next(cast(GFileAttributeMatcher*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks if an attribute will be matched by an attribute matcher. If
   * the matcher was created with the "*" matching string, this function
   * will always return %TRUE.
   * Params:
   *   attribute = a file attribute key.
   * Returns: %TRUE if attribute matches matcher. %FALSE otherwise.
   */
  bool matches(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_attribute_matcher_matches(cast(GFileAttributeMatcher*)cPtr, _attribute);
    return _retval;
  }

  /**
   * Checks if an attribute matcher only matches a given attribute. Always
   * returns %FALSE if "*" was used when creating the matcher.
   * Params:
   *   attribute = a file attribute key.
   * Returns: %TRUE if the matcher only matches attribute. %FALSE otherwise.
   */
  bool matchesOnly(string attribute)
  {
    bool _retval;
    const(char)* _attribute = attribute.toCString(false);
    _retval = g_file_attribute_matcher_matches_only(cast(GFileAttributeMatcher*)cPtr, _attribute);
    return _retval;
  }

  /**
   * Subtracts all attributes of subtract from matcher and returns
   * a matcher that supports those attributes.
   * Note that currently it is not possible to remove a single
   * attribute when the matcher matches the whole namespace - or remove
   * a namespace or attribute when the matcher matches everything. This
   * is a limitation of the current implementation, but may be fixed
   * in the future.
   * Params:
   *   subtract = The matcher to subtract
   * Returns: A file attribute matcher matching all attributes of
   *   matcher that are not matched by subtract
   */
  FileAttributeMatcher subtract(FileAttributeMatcher subtract)
  {
    GFileAttributeMatcher* _cretval;
    _cretval = g_file_attribute_matcher_subtract(cast(GFileAttributeMatcher*)cPtr, subtract ? cast(GFileAttributeMatcher*)subtract.cPtr(false) : null);
    auto _retval = _cretval ? new FileAttributeMatcher(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Prints what the matcher is matching against. The format will be
   * equal to the format passed to [Gio.FileAttributeMatcher.new_].
   * The output however, might not be identical, as the matcher may
   * decide to use a different order or omit needless parts.
   * Returns: a string describing the attributes the matcher matches
   *   against or %NULL if matcher was %NULL.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_file_attribute_matcher_to_string(cast(GFileAttributeMatcher*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
