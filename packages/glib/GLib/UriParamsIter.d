module GLib.UriParamsIter;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Many URI schemes include one or more attribute/value pairs as part of the URI
 * value. For example `scheme://server/path?query=string&is=there` has two
 * attributes – `query=string` and `is=there` – in its query part.
 *
 * A #GUriParamsIter structure represents an iterator that can be used to
 * iterate over the attribute/value pairs of a URI query string. #GUriParamsIter
 * structures are typically allocated on the stack and then initialized with
 * g_uri_params_iter_init(). See the documentation for g_uri_params_iter_init()
 * for a usage example.
 */
class UriParamsIter
{
  GUriParamsIter cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.UriParamsIter");

    cInstance = *cast(GUriParamsIter*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUriParamsIter))
  {
    return cast(T*)&cInstance;
  }

  /**
   * Initializes an attribute/value pair iterator.
   *
   * The iterator keeps pointers to the @params and @separators arguments, those
   * variables must thus outlive the iterator and not be modified during the
   * iteration.
   *
   * If %G_URI_PARAMS_WWW_FORM is passed in @flags, `+` characters in the param
   * string will be replaced with spaces in the output. For example, `foo=bar+baz`
   * will give attribute `foo` with value `bar baz`. This is commonly used on the
   * web (the `https` and `http` schemes only), but is deprecated in favour of
   * the equivalent of encoding spaces as `%20`.
   *
   * Unlike with g_uri_parse_params(), %G_URI_PARAMS_CASE_INSENSITIVE has no
   * effect if passed to @flags for g_uri_params_iter_init(). The caller is
   * responsible for doing their own case-insensitive comparisons.
   *
   * |[<!-- language="C" -->
   * GUriParamsIter iter;
   * GError *error = NULL;
   * gchar *unowned_attr, *unowned_value;
   *
   * g_uri_params_iter_init (&iter, "foo=bar&baz=bar&Foo=frob&baz=bar2", -1, "&", G_URI_PARAMS_NONE);
   * while (g_uri_params_iter_next (&iter, &unowned_attr, &unowned_value, &error))
   * {
   * g_autofree gchar *attr = g_steal_pointer (&unowned_attr);
   * g_autofree gchar *value = g_steal_pointer (&unowned_value);
   * // do something with attr and value; this code will be called 4 times
   * // for the params string in this example: once with attr=foo and value=bar,
   * // then with baz/bar, then Foo/frob, then baz/bar2.
   * }
   * if (error)
   * // handle parsing error
   * ]|
   */
  void init_(string params, ptrdiff_t length, string separators, UriParamsFlags flags)
  {
    const(char)* _params = params.toCString(false);
    const(char)* _separators = separators.toCString(false);
    g_uri_params_iter_init(cPtr!GUriParamsIter, _params, length, _separators, flags);
  }

  /**
   * %FALSE if the end of the parameters has been reached or an error was
   * encountered. %TRUE otherwise.
   */
  bool next(out string attribute, out string value)
  {
    bool _retval;
    char* _attribute;
    char* _value;
    GError *_err;
    _retval = g_uri_params_iter_next(cPtr!GUriParamsIter, &_attribute, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    attribute = _attribute.fromCString(true);
    value = _value.fromCString(true);
    return _retval;
  }
}
