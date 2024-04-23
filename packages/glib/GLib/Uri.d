module GLib.Uri;

import GLib.Boxed;
import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GUri type and related functions can be used to parse URIs into
 * their components, and build valid URIs from individual components.
 *
 * Note that #GUri scope is to help manipulate URIs in various applications,
 * following [RFC 3986](https://tools.ietf.org/html/rfc3986). In particular,
 * it doesn't intend to cover web browser needs, and doesn't implement the
 * [WHATWG URL](https://url.spec.whatwg.org/) standard. No APIs are provided to
 * help prevent
 * [homograph attacks](https://en.wikipedia.org/wiki/IDN_homograph_attack), so
 * #GUri is not suitable for formatting URIs for display to the user for making
 * security-sensitive decisions.
 *
 * ## Relative and absolute URIs # {#relative-absolute-uris}
 *
 * As defined in [RFC 3986](https://tools.ietf.org/html/rfc3986#section-4), the
 * hierarchical nature of URIs means that they can either be ‘relative
 * references’ (sometimes referred to as ‘relative URIs’) or ‘URIs’ (for
 * clarity, ‘URIs’ are referred to in this documentation as
 * ‘absolute URIs’ — although
 * [in constrast to RFC 3986](https://tools.ietf.org/html/rfc3986#section-4.3),
 * fragment identifiers are always allowed).
 *
 * Relative references have one or more components of the URI missing. In
 * particular, they have no scheme. Any other component, such as hostname,
 * query, etc. may be missing, apart from a path, which has to be specified (but
 * may be empty). The path may be relative, starting with `./` rather than `/`.
 *
 * For example, a valid relative reference is `./path?query`,
 * `/?query#fragment` or `//example.com`.
 *
 * Absolute URIs have a scheme specified. Any other components of the URI which
 * are missing are specified as explicitly unset in the URI, rather than being
 * resolved relative to a base URI using g_uri_parse_relative().
 *
 * For example, a valid absolute URI is `file:///home/bob` or
 * `https://search.com?query=string`.
 *
 * A #GUri instance is always an absolute URI. A string may be an absolute URI
 * or a relative reference; see the documentation for individual functions as to
 * what forms they accept.
 *
 * ## Parsing URIs
 *
 * The most minimalist APIs for parsing URIs are g_uri_split() and
 * g_uri_split_with_user(). These split a URI into its component
 * parts, and return the parts; the difference between the two is that
 * g_uri_split() treats the ‘userinfo’ component of the URI as a
 * single element, while g_uri_split_with_user() can (depending on the
 * #GUriFlags you pass) treat it as containing a username, password,
 * and authentication parameters. Alternatively, g_uri_split_network()
 * can be used when you are only interested in the components that are
 * needed to initiate a network connection to the service (scheme,
 * host, and port).
 *
 * g_uri_parse() is similar to g_uri_split(), but instead of returning
 * individual strings, it returns a #GUri structure (and it requires
 * that the URI be an absolute URI).
 *
 * g_uri_resolve_relative() and g_uri_parse_relative() allow you to
 * resolve a relative URI relative to a base URI.
 * g_uri_resolve_relative() takes two strings and returns a string,
 * and g_uri_parse_relative() takes a #GUri and a string and returns a
 * #GUri.
 *
 * All of the parsing functions take a #GUriFlags argument describing
 * exactly how to parse the URI; see the documentation for that type
 * for more details on the specific flags that you can pass. If you
 * need to choose different flags based on the type of URI, you can
 * use g_uri_peek_scheme() on the URI string to check the scheme
 * first, and use that to decide what flags to parse it with.
 *
 * For example, you might want to use %G_URI_PARAMS_WWW_FORM when parsing the
 * params for a web URI, so compare the result of g_uri_peek_scheme() against
 * `http` and `https`.
 *
 * ## Building URIs
 *
 * g_uri_join() and g_uri_join_with_user() can be used to construct
 * valid URI strings from a set of component strings. They are the
 * inverse of g_uri_split() and g_uri_split_with_user().
 *
 * Similarly, g_uri_build() and g_uri_build_with_user() can be used to
 * construct a #GUri from a set of component strings.
 *
 * As with the parsing functions, the building functions take a
 * #GUriFlags argument. In particular, it is important to keep in mind
 * whether the URI components you are using are already `%`-encoded. If so,
 * you must pass the %G_URI_FLAGS_ENCODED flag.
 *
 * ## `file://` URIs
 *
 * Note that Windows and Unix both define special rules for parsing
 * `file://` URIs (involving non-UTF-8 character sets on Unix, and the
 * interpretation of path separators on Windows). #GUri does not
 * implement these rules. Use g_filename_from_uri() and
 * g_filename_to_uri() if you want to properly convert between
 * `file://` URIs and local filenames.
 *
 * ## URI Equality
 *
 * Note that there is no `g_uri_equal ()` function, because comparing
 * URIs usefully requires scheme-specific knowledge that #GUri does
 * not have. #GUri can help with normalization if you use the various
 * encoded #GUriFlags as well as %G_URI_FLAGS_SCHEME_NORMALIZE however
 * it is not comprehensive.
 * For example, `data:,foo` and `data:;base64,Zm9v` resolve to the same
 * thing according to the `data:` URI specification which GLib does not
 * handle.
 */
class Uri : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GUri))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_uri_get_type();
  }

  /**
   * @uri's authentication parameters.
   */
  string getAuthParams()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_auth_params(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's flags.
   */
  UriFlags getFlags()
  {
    GUriFlags _cretval;
    _cretval = g_uri_get_flags(cPtr!GUri);
    UriFlags _retval = cast(UriFlags)_cretval;
    return _retval;
  }

  /**
   * @uri's fragment.
   */
  string getFragment()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_fragment(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's host.
   */
  string getHost()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_host(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's password.
   */
  string getPassword()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_password(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's path.
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_path(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's port, or `-1` if no port was specified.
   */
  int getPort()
  {
    int _retval;
    _retval = g_uri_get_port(cPtr!GUri);
    return _retval;
  }

  /**
   * @uri's query.
   */
  string getQuery()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_query(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's scheme.
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_scheme(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's user.
   */
  string getUser()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_user(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @uri's userinfo.
   */
  string getUserinfo()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_userinfo(cPtr!GUri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a new #GUri, or NULL on error.
   */
  Uri parseRelative(string uriRef, UriFlags flags)
  {
    GUri* _cretval;
    const(char)* _uriRef = uriRef.toCString(false);
    GError *_err;
    _cretval = g_uri_parse_relative(cPtr!GUri, _uriRef, flags, &_err);
    if (_err)
      throw new UriException(_err);
    Uri _retval = new Uri(cast(GUri*)_cretval, true);
    return _retval;
  }

  /**
   * a string representing @uri,
   * which the caller must free.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_uri_to_string(cPtr!GUri);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string representing
   * @uri, which the caller must free.
   */
  string toStringPartial(UriHideFlags flags)
  {
    char* _cretval;
    _cretval = g_uri_to_string_partial(cPtr!GUri, flags);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a new #GUri
   */
  static Uri build(UriFlags flags, string scheme, string userinfo, string host, int port, string path, string query, string fragment)
  {
    GUri* _cretval;
    const(char)* _scheme = scheme.toCString(false);
    const(char)* _userinfo = userinfo.toCString(false);
    const(char)* _host = host.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _query = query.toCString(false);
    const(char)* _fragment = fragment.toCString(false);
    _cretval = g_uri_build(flags, _scheme, _userinfo, _host, port, _path, _query, _fragment);
    Uri _retval = new Uri(cast(GUri*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GUri
   */
  static Uri buildWithUser(UriFlags flags, string scheme, string user, string password, string authParams, string host, int port, string path, string query, string fragment)
  {
    GUri* _cretval;
    const(char)* _scheme = scheme.toCString(false);
    const(char)* _user = user.toCString(false);
    const(char)* _password = password.toCString(false);
    const(char)* _authParams = authParams.toCString(false);
    const(char)* _host = host.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _query = query.toCString(false);
    const(char)* _fragment = fragment.toCString(false);
    _cretval = g_uri_build_with_user(flags, _scheme, _user, _password, _authParams, _host, port, _path, _query, _fragment);
    Uri _retval = new Uri(cast(GUri*)_cretval, true);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_uri_error_quark();
    return _retval;
  }

  /**
   * an escaped version of @unescaped.
   * The returned string should be freed when no longer needed.
   */
  static string escapeBytes(ubyte[] unescaped, string reservedCharsAllowed)
  {
    char* _cretval;
    auto _unescaped = cast(const(ubyte)*)unescaped.ptr;
    const(char)* _reservedCharsAllowed = reservedCharsAllowed.toCString(false);
    _cretval = g_uri_escape_bytes(_unescaped, unescaped ? cast(size_t)unescaped.length : 0, _reservedCharsAllowed);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * an escaped version of @unescaped. The
   * returned string should be freed when no longer needed.
   */
  static string escapeString(string unescaped, string reservedCharsAllowed, bool allowUtf8)
  {
    char* _cretval;
    const(char)* _unescaped = unescaped.toCString(false);
    const(char)* _reservedCharsAllowed = reservedCharsAllowed.toCString(false);
    _cretval = g_uri_escape_string(_unescaped, _reservedCharsAllowed, allowUtf8);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @uri_string is a valid absolute URI, %FALSE on error.
   */
  static bool isValid(string uriString, UriFlags flags)
  {
    bool _retval;
    const(char)* _uriString = uriString.toCString(false);
    GError *_err;
    _retval = g_uri_is_valid(_uriString, flags, &_err);
    if (_err)
      throw new UriException(_err);
    return _retval;
  }

  /**
   * an absolute URI string
   */
  static string join(UriFlags flags, string scheme, string userinfo, string host, int port, string path, string query, string fragment)
  {
    char* _cretval;
    const(char)* _scheme = scheme.toCString(false);
    const(char)* _userinfo = userinfo.toCString(false);
    const(char)* _host = host.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _query = query.toCString(false);
    const(char)* _fragment = fragment.toCString(false);
    _cretval = g_uri_join(flags, _scheme, _userinfo, _host, port, _path, _query, _fragment);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * an absolute URI string
   */
  static string joinWithUser(UriFlags flags, string scheme, string user, string password, string authParams, string host, int port, string path, string query, string fragment)
  {
    char* _cretval;
    const(char)* _scheme = scheme.toCString(false);
    const(char)* _user = user.toCString(false);
    const(char)* _password = password.toCString(false);
    const(char)* _authParams = authParams.toCString(false);
    const(char)* _host = host.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _query = query.toCString(false);
    const(char)* _fragment = fragment.toCString(false);
    _cretval = g_uri_join_with_user(flags, _scheme, _user, _password, _authParams, _host, port, _path, _query, _fragment);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated %NULL-terminated list
   * of strings holding the individual URIs. The array should be freed
   * with g_strfreev().
   */
  static string[] listExtractUris(string uriList)
  {
    char** _cretval;
    const(char)* _uriList = uriList.toCString(false);
    _cretval = g_uri_list_extract_uris(_uriList);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * a new #GUri, or NULL on error.
   */
  static Uri parse(string uriString, UriFlags flags)
  {
    GUri* _cretval;
    const(char)* _uriString = uriString.toCString(false);
    GError *_err;
    _cretval = g_uri_parse(_uriString, flags, &_err);
    if (_err)
      throw new UriException(_err);
    Uri _retval = new Uri(cast(GUri*)_cretval, true);
    return _retval;
  }

  /**
   * A hash table of attribute/value pairs, with both names and values
   * fully-decoded; or %NULL on error.
   */
  static string[string] parseParams(string params, ptrdiff_t length, string separators, UriParamsFlags flags)
  {
    GHashTable* _cretval;
    const(char)* _params = params.toCString(false);
    const(char)* _separators = separators.toCString(false);
    GError *_err;
    _cretval = g_uri_parse_params(_params, length, _separators, flags, &_err);
    if (_err)
      throw new UriException(_err);
    string[string] _retval = _cretval ? hashTableToMap!(string, string, true)(_cretval) : null;
    return _retval;
  }

  /**
   * The ‘scheme’ component of the URI, or
   * %NULL on error. The returned string should be freed when no longer needed.
   */
  static string parseScheme(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = g_uri_parse_scheme(_uri);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The ‘scheme’ component of the URI, or
   * %NULL on error. The returned string is normalized to all-lowercase, and
   * interned via g_intern_string(), so it does not need to be freed.
   */
  static string peekScheme(string uri)
  {
    const(char)* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = g_uri_peek_scheme(_uri);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the resolved URI string,
   * or NULL on error.
   */
  static string resolveRelative(string baseUriString, string uriRef, UriFlags flags)
  {
    char* _cretval;
    const(char)* _baseUriString = baseUriString.toCString(false);
    const(char)* _uriRef = uriRef.toCString(false);
    GError *_err;
    _cretval = g_uri_resolve_relative(_baseUriString, _uriRef, flags, &_err);
    if (_err)
      throw new UriException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @uri_ref parsed successfully, %FALSE
   * on error.
   */
  static bool split(string uriRef, UriFlags flags, out string scheme, out string userinfo, out string host, out int port, out string path, out string query, out string fragment)
  {
    bool _retval;
    const(char)* _uriRef = uriRef.toCString(false);
    char* _scheme;
    char* _userinfo;
    char* _host;
    char* _path;
    char* _query;
    char* _fragment;
    GError *_err;
    _retval = g_uri_split(_uriRef, flags, &_scheme, &_userinfo, &_host, cast(int*)&port, &_path, &_query, &_fragment, &_err);
    if (_err)
      throw new UriException(_err);
    scheme = _scheme.fromCString(true);
    userinfo = _userinfo.fromCString(true);
    host = _host.fromCString(true);
    path = _path.fromCString(true);
    query = _query.fromCString(true);
    fragment = _fragment.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @uri_string parsed successfully,
   * %FALSE on error.
   */
  static bool splitNetwork(string uriString, UriFlags flags, out string scheme, out string host, out int port)
  {
    bool _retval;
    const(char)* _uriString = uriString.toCString(false);
    char* _scheme;
    char* _host;
    GError *_err;
    _retval = g_uri_split_network(_uriString, flags, &_scheme, &_host, cast(int*)&port, &_err);
    if (_err)
      throw new UriException(_err);
    scheme = _scheme.fromCString(true);
    host = _host.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @uri_ref parsed successfully, %FALSE
   * on error.
   */
  static bool splitWithUser(string uriRef, UriFlags flags, out string scheme, out string user, out string password, out string authParams, out string host, out int port, out string path, out string query, out string fragment)
  {
    bool _retval;
    const(char)* _uriRef = uriRef.toCString(false);
    char* _scheme;
    char* _user;
    char* _password;
    char* _authParams;
    char* _host;
    char* _path;
    char* _query;
    char* _fragment;
    GError *_err;
    _retval = g_uri_split_with_user(_uriRef, flags, &_scheme, &_user, &_password, &_authParams, &_host, cast(int*)&port, &_path, &_query, &_fragment, &_err);
    if (_err)
      throw new UriException(_err);
    scheme = _scheme.fromCString(true);
    user = _user.fromCString(true);
    password = _password.fromCString(true);
    authParams = _authParams.fromCString(true);
    host = _host.fromCString(true);
    path = _path.fromCString(true);
    query = _query.fromCString(true);
    fragment = _fragment.fromCString(true);
    return _retval;
  }

  /**
   * an unescaped version of @escaped_string
   * or %NULL on error (if decoding failed, using %G_URI_ERROR_FAILED error
   * code). The returned #GBytes should be unreffed when no longer needed.
   */
  static Bytes unescapeBytes(string escapedString, ptrdiff_t length, string illegalCharacters)
  {
    GBytes* _cretval;
    const(char)* _escapedString = escapedString.toCString(false);
    const(char)* _illegalCharacters = illegalCharacters.toCString(false);
    GError *_err;
    _cretval = g_uri_unescape_bytes(_escapedString, length, _illegalCharacters, &_err);
    if (_err)
      throw new UriException(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * an unescaped version of @escaped_string,
   * or %NULL on error. The returned string should be freed when no longer
   * needed.  As a special case if %NULL is given for @escaped_string, this
   * function will return %NULL.
   */
  static string unescapeSegment(string escapedString, string escapedStringEnd, string illegalCharacters)
  {
    char* _cretval;
    const(char)* _escapedString = escapedString.toCString(false);
    const(char)* _escapedStringEnd = escapedStringEnd.toCString(false);
    const(char)* _illegalCharacters = illegalCharacters.toCString(false);
    _cretval = g_uri_unescape_segment(_escapedString, _escapedStringEnd, _illegalCharacters);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * an unescaped version of @escaped_string.
   * The returned string should be freed when no longer needed.
   */
  static string unescapeString(string escapedString, string illegalCharacters)
  {
    char* _cretval;
    const(char)* _escapedString = escapedString.toCString(false);
    const(char)* _illegalCharacters = illegalCharacters.toCString(false);
    _cretval = g_uri_unescape_string(_escapedString, _illegalCharacters);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

class UriException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(Uri.errorQuark, cast(int)code, msg);
  }

  alias Code = GUriError;
}
