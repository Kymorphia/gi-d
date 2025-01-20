module GLib.UriParamsIter;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * Many URI schemes include one or more attribute/value pairs as part of the URI
 * value. For example `scheme://server/path?query\=string&is\=there` has two
 * attributes – `query\=string` and `is\=there` – in its query part.
 * A #GUriParamsIter structure represents an iterator that can be used to
 * iterate over the attribute/value pairs of a URI query string. #GUriParamsIter
 * structures are typically allocated on the stack and then initialized with
 * [GLib.UriParamsIter.init_]. See the documentation for [GLib.UriParamsIter.init_]
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Initializes an attribute/value pair iterator.
   * The iterator keeps pointers to the params and separators arguments, those
   * variables must thus outlive the iterator and not be modified during the
   * iteration.
   * If %G_URI_PARAMS_WWW_FORM is passed in flags, `+` characters in the param
   * string will be replaced with spaces in the output. For example, `foo\=bar+baz`
   * will give attribute `foo` with value `bar baz`. This is commonly used on the
   * web $(LPAREN)the `https` and `http` schemes only$(RPAREN), but is deprecated in favour of
   * the equivalent of encoding spaces as `%20`.
   * Unlike with [GLib.Uri.parseParams], %G_URI_PARAMS_CASE_INSENSITIVE has no
   * effect if passed to flags for [GLib.UriParamsIter.init_]. The caller is
   * responsible for doing their own case-insensitive comparisons.
   * |[<!-- language\="C" -->
   * GUriParamsIter iter;
   * GError *error \= NULL;
   * gchar *unowned_attr, *unowned_value;
   * g_uri_params_iter_init $(LPAREN)&iter, "foo\=bar&baz\=bar&Foo\=frob&baz\=bar2", -1, "&", G_URI_PARAMS_NONE$(RPAREN);
   * while $(LPAREN)g_uri_params_iter_next $(LPAREN)&iter, &unowned_attr, &unowned_value, &error$(RPAREN)$(RPAREN)
   * {
   * g_autofree gchar *attr \= g_steal_pointer $(LPAREN)&unowned_attr$(RPAREN);
   * g_autofree gchar *value \= g_steal_pointer $(LPAREN)&unowned_value$(RPAREN);
   * // do something with attr and value; this code will be called 4 times
   * // for the params string in this example: once with attr\=foo and value\=bar,
   * // then with baz/bar, then Foo/frob, then baz/bar2.
   * }
   * if $(LPAREN)error$(RPAREN)
   * // handle parsing error
   * ]|
   * Params:
   *   params = a `%`-encoded string containing `attribute\=value`
   *     parameters
   *   length = the length of params, or `-1` if it is nul-terminated
   *   separators = the separator byte character set between parameters. $(LPAREN)usually
   *     `&`, but sometimes `;` or both `&;`$(RPAREN). Note that this function works on
   *     bytes not characters, so it can't be used to delimit UTF-8 strings for
   *     anything but ASCII characters. You may pass an empty set, in which case
   *     no splitting will occur.
   *   flags = flags to modify the way the parameters are handled.
   */
  void init_(string params, ptrdiff_t length, string separators, UriParamsFlags flags)
  {
    const(char)* _params = params.toCString(false);
    const(char)* _separators = separators.toCString(false);
    g_uri_params_iter_init(cast(GUriParamsIter*)cPtr, _params, length, _separators, flags);
  }

  /**
   * Advances iter and retrieves the next attribute/value. %FALSE is returned if
   * an error has occurred $(LPAREN)in which case error is set$(RPAREN), or if the end of the
   * iteration is reached $(LPAREN)in which case attribute and value are set to %NULL
   * and the iterator becomes invalid$(RPAREN). If %TRUE is returned,
   * [GLib.UriParamsIter.next] may be called again to receive another
   * attribute/value pair.
   * Note that the same attribute may be returned multiple times, since URIs
   * allow repeated attributes.
   * Params:
   *   attribute = on return, contains
   *     the attribute, or %NULL.
   *   value = on return, contains
   *     the value, or %NULL.
   * Returns: %FALSE if the end of the parameters has been reached or an error was
   *   encountered. %TRUE otherwise.
   */
  bool next(out string attribute, out string value)
  {
    bool _retval;
    char* _attribute;
    char* _value;
    GError *_err;
    _retval = g_uri_params_iter_next(cast(GUriParamsIter*)cPtr, &_attribute, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    attribute = _attribute.fromCString(true);
    value = _value.fromCString(true);
    return _retval;
  }
}
