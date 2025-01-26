module GLib.Uri;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The `GUri` type and related functions can be used to parse URIs into
 * their components, and build valid URIs from individual components.
 * Since `GUri` only represents absolute URIs, all `GUri`s will have a
 * URI scheme, so [GLib.Uri.getScheme] will always return a non-`NULL`
 * answer. Likewise, by definition, all URIs have a path component, so
 * [GLib.Uri.getPath] will always return a non-`NULL` string $(LPAREN)which may
 * be empty$(RPAREN).
 * If the URI string has an
 * [‘authority’ component](https://tools.ietf.org/html/rfc3986#section-3) $(LPAREN)that
 * is, if the scheme is followed by `://` rather than just `:`$(RPAREN), then the
 * `GUri` will contain a hostname, and possibly a port and ‘userinfo’.
 * Additionally, depending on how the `GUri` was constructed/parsed $(LPAREN)for example,
 * using the `G_URI_FLAGS_HAS_PASSWORD` and `G_URI_FLAGS_HAS_AUTH_PARAMS` flags$(RPAREN),
 * the userinfo may be split out into a username, password, and
 * additional authorization-related parameters.
 * Normally, the components of a `GUri` will have all `%`-encoded
 * characters decoded. However, if you construct/parse a `GUri` with
 * `G_URI_FLAGS_ENCODED`, then the `%`-encoding will be preserved instead in
 * the userinfo, path, and query fields $(LPAREN)and in the host field if also
 * created with `G_URI_FLAGS_NON_DNS`$(RPAREN). In particular, this is necessary if
 * the URI may contain binary data or non-UTF-8 text, or if decoding
 * the components might change the interpretation of the URI.
 * For example, with the encoded flag:
 * ```c
 * g_autoptr$(LPAREN)GUri$(RPAREN) uri \= g_uri_parse $(LPAREN)"http://host/path?query\=http%3A%2F%2Fhost%2Fpath%3Fparam%3Dvalue", G_URI_FLAGS_ENCODED, &err$(RPAREN);
 * g_assert_cmpstr $(LPAREN)g_uri_get_query $(LPAREN)uri$(RPAREN), \=\=, "query\=http%3A%2F%2Fhost%2Fpath%3Fparam%3Dvalue"$(RPAREN);
 * ```
 * While the default `%`-decoding behaviour would give:
 * ```c
 * g_autoptr$(LPAREN)GUri$(RPAREN) uri \= g_uri_parse $(LPAREN)"http://host/path?query\=http%3A%2F%2Fhost%2Fpath%3Fparam%3Dvalue", G_URI_FLAGS_NONE, &err$(RPAREN);
 * g_assert_cmpstr $(LPAREN)g_uri_get_query $(LPAREN)uri$(RPAREN), \=\=, "query\=http://host/path?param\=value"$(RPAREN);
 * ```
 * During decoding, if an invalid UTF-8 string is encountered, parsing will fail
 * with an error indicating the bad string location:
 * ```c
 * g_autoptr$(LPAREN)GUri$(RPAREN) uri \= g_uri_parse $(LPAREN)"http://host/path?query\=http%3A%2F%2Fhost%2Fpath%3Fbad%3D%00alue", G_URI_FLAGS_NONE, &err$(RPAREN);
 * g_assert_error $(LPAREN)err, G_URI_ERROR, G_URI_ERROR_BAD_QUERY$(RPAREN);
 * ```
 * You should pass `G_URI_FLAGS_ENCODED` or `G_URI_FLAGS_ENCODED_QUERY` if you
 * need to handle that case manually. In particular, if the query string
 * contains `\=` characters that are `%`-encoded, you should let
 * [GLib.Uri.parseParams] do the decoding once of the query.
 * `GUri` is immutable once constructed, and can safely be accessed from
 * multiple threads. Its reference counting is atomic.
 * Note that the scope of `GUri` is to help manipulate URIs in various applications,
 * following [RFC 3986](https://tools.ietf.org/html/rfc3986). In particular,
 * it doesn't intend to cover web browser needs, and doesn’t implement the
 * [WHATWG URL](https://url.spec.whatwg.org/) standard. No APIs are provided to
 * help prevent
 * [homograph attacks](https://en.wikipedia.org/wiki/IDN_homograph_attack), so
 * `GUri` is not suitable for formatting URIs for display to the user for making
 * security-sensitive decisions.
 * ## Relative and absolute URIs
 * As defined in [RFC 3986](https://tools.ietf.org/html/rfc3986#section-4), the
 * hierarchical nature of URIs means that they can either be ‘relative
 * references’ $(LPAREN)sometimes referred to as ‘relative URIs’$(RPAREN) or ‘URIs’ $(LPAREN)for
 * clarity, ‘URIs’ are referred to in this documentation as
 * ‘absolute URIs’ — although
 * [in constrast to RFC 3986](https://tools.ietf.org/html/rfc3986#section-4.3),
 * fragment identifiers are always allowed$(RPAREN).
 * Relative references have one or more components of the URI missing. In
 * particular, they have no scheme. Any other component, such as hostname,
 * query, etc. may be missing, apart from a path, which has to be specified $(LPAREN)but
 * may be empty$(RPAREN). The path may be relative, starting with `./` rather than `/`.
 * For example, a valid relative reference is `./path?query`,
 * `/?query#fragment` or `//example.com`.
 * Absolute URIs have a scheme specified. Any other components of the URI which
 * are missing are specified as explicitly unset in the URI, rather than being
 * resolved relative to a base URI using [GLib.Uri.parseRelative].
 * For example, a valid absolute URI is `file:///home/bob` or
 * `https://search.com?query\=string`.
 * A `GUri` instance is always an absolute URI. A string may be an absolute URI
 * or a relative reference; see the documentation for individual functions as to
 * what forms they accept.
 * ## Parsing URIs
 * The most minimalist APIs for parsing URIs are [GLib.Uri.split] and
 * [GLib.Uri.splitWithUser]. These split a URI into its component
 * parts, and return the parts; the difference between the two is that
 * [GLib.Uri.split] treats the ‘userinfo’ component of the URI as a
 * single element, while [GLib.Uri.splitWithUser] can $(LPAREN)depending on the
 * [GLib] you pass$(RPAREN) treat it as containing a username, password,
 * and authentication parameters. Alternatively, [GLib.Uri.splitNetwork]
 * can be used when you are only interested in the components that are
 * needed to initiate a network connection to the service $(LPAREN)scheme,
 * host, and port$(RPAREN).
 * [GLib.Uri.parse] is similar to [GLib.Uri.split], but instead of
 * returning individual strings, it returns a `GUri` structure $(LPAREN)and it requires
 * that the URI be an absolute URI$(RPAREN).
 * [GLib.Uri.resolveRelative] and [GLib.Uri.parseRelative] allow
 * you to resolve a relative URI relative to a base URI.
 * [GLib.Uri.resolveRelative] takes two strings and returns a string,
 * and [GLib.Uri.parseRelative] takes a `GUri` and a string and returns a
 * `GUri`.
 * All of the parsing functions take a [GLib] argument describing
 * exactly how to parse the URI; see the documentation for that type
 * for more details on the specific flags that you can pass. If you
 * need to choose different flags based on the type of URI, you can
 * use [GLib.Uri.peekScheme] on the URI string to check the scheme
 * first, and use that to decide what flags to parse it with.
 * For example, you might want to use `G_URI_PARAMS_WWW_FORM` when parsing the
 * params for a web URI, so compare the result of [GLib.Uri.peekScheme]
 * against `http` and `https`.
 * ## Building URIs
 * [GLib.Uri.join] and [GLib.Uri.joinWithUser] can be used to construct
 * valid URI strings from a set of component strings. They are the
 * inverse of [GLib.Uri.split] and [GLib.Uri.splitWithUser].
 * Similarly, [GLib.Uri.build] and [GLib.Uri.buildWithUser] can be
 * used to construct a `GUri` from a set of component strings.
 * As with the parsing functions, the building functions take a
 * [GLib] argument. In particular, it is important to keep in mind
 * whether the URI components you are using are already `%`-encoded. If so,
 * you must pass the `G_URI_FLAGS_ENCODED` flag.
 * ## `file://` URIs
 * Note that Windows and Unix both define special rules for parsing
 * `file://` URIs $(LPAREN)involving non-UTF-8 character sets on Unix, and the
 * interpretation of path separators on Windows$(RPAREN). `GUri` does not
 * implement these rules. Use func@GLib.filename_from_uri and
 * func@GLib.filename_to_uri if you want to properly convert between
 * `file://` URIs and local filenames.
 * ## URI Equality
 * Note that there is no `g_uri_equal $(LPAREN)$(RPAREN)` function, because comparing
 * URIs usefully requires scheme-specific knowledge that `GUri` does
 * not have. `GUri` can help with normalization if you use the various
 * encoded [GLib] as well as `G_URI_FLAGS_SCHEME_NORMALIZE`
 * however it is not comprehensive.
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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_uri_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets uri's authentication parameters, which may contain
   * `%`-encoding, depending on the flags with which uri was created.
   * $(LPAREN)If uri was not created with %G_URI_FLAGS_HAS_AUTH_PARAMS then this will
   * be %NULL.$(RPAREN)
   * Depending on the URI scheme, [GLib.Uri.parseParams] may be useful for
   * further parsing this information.
   * Returns: uri's authentication parameters.
   */
  string getAuthParams()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_auth_params(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's flags set upon construction.
   * Returns: uri's flags.
   */
  UriFlags getFlags()
  {
    GUriFlags _cretval;
    _cretval = g_uri_get_flags(cast(GUri*)cPtr);
    UriFlags _retval = cast(UriFlags)_cretval;
    return _retval;
  }

  /**
   * Gets uri's fragment, which may contain `%`-encoding, depending on
   * the flags with which uri was created.
   * Returns: uri's fragment.
   */
  string getFragment()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_fragment(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's host. This will never have `%`-encoded characters,
   * unless it is non-UTF-8 $(LPAREN)which can only be the case if uri was
   * created with %G_URI_FLAGS_NON_DNS$(RPAREN).
   * If uri contained an IPv6 address literal, this value will be just
   * that address, without the brackets around it that are necessary in
   * the string form of the URI. Note that in this case there may also
   * be a scope ID attached to the address. Eg, `fe80::1234%``em1` $(LPAREN)or
   * `fe80::1234%``25em1` if the string is still encoded$(RPAREN).
   * Returns: uri's host.
   */
  string getHost()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_host(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's password, which may contain `%`-encoding, depending on
   * the flags with which uri was created. $(LPAREN)If uri was not created
   * with %G_URI_FLAGS_HAS_PASSWORD then this will be %NULL.$(RPAREN)
   * Returns: uri's password.
   */
  string getPassword()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_password(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's path, which may contain `%`-encoding, depending on the
   * flags with which uri was created.
   * Returns: uri's path.
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_path(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's port.
   * Returns: uri's port, or `-1` if no port was specified.
   */
  int getPort()
  {
    int _retval;
    _retval = g_uri_get_port(cast(GUri*)cPtr);
    return _retval;
  }

  /**
   * Gets uri's query, which may contain `%`-encoding, depending on the
   * flags with which uri was created.
   * For queries consisting of a series of `name\=value` parameters,
   * #GUriParamsIter or [GLib.Uri.parseParams] may be useful.
   * Returns: uri's query.
   */
  string getQuery()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_query(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's scheme. Note that this will always be all-lowercase,
   * regardless of the string or strings that uri was created from.
   * Returns: uri's scheme.
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_scheme(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the ‘username’ component of uri's userinfo, which may contain
   * `%`-encoding, depending on the flags with which uri was created.
   * If uri was not created with %G_URI_FLAGS_HAS_PASSWORD or
   * %G_URI_FLAGS_HAS_AUTH_PARAMS, this is the same as [GLib.Uri.getUserinfo].
   * Returns: uri's user.
   */
  string getUser()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_user(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets uri's userinfo, which may contain `%`-encoding, depending on
   * the flags with which uri was created.
   * Returns: uri's userinfo.
   */
  string getUserinfo()
  {
    const(char)* _cretval;
    _cretval = g_uri_get_userinfo(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Parses uri_ref according to flags and, if it is a
   * [relative URI](#relative-and-absolute-uris), resolves it relative to base_uri.
   * If the result is not a valid absolute URI, it will be discarded, and an error
   * returned.
   * Params:
   *   uriRef = a string representing a relative or absolute URI
   *   flags = flags describing how to parse uri_ref
   * Returns: a new #GUri, or NULL on error.
   */
  Uri parseRelative(string uriRef, UriFlags flags)
  {
    GUri* _cretval;
    const(char)* _uriRef = uriRef.toCString(false);
    GError *_err;
    _cretval = g_uri_parse_relative(cast(GUri*)cPtr, _uriRef, flags, &_err);
    if (_err)
      throw new UriException(_err);
    auto _retval = _cretval ? new Uri(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a string representing uri.
   * This is not guaranteed to return a string which is identical to the
   * string that uri was parsed from. However, if the source URI was
   * syntactically correct $(LPAREN)according to RFC 3986$(RPAREN), and it was parsed
   * with %G_URI_FLAGS_ENCODED, then [GLib.Uri.toString_] is guaranteed to return
   * a string which is at least semantically equivalent to the source
   * URI $(LPAREN)according to RFC 3986$(RPAREN).
   * If uri might contain sensitive details, such as authentication parameters,
   * or private data in its query string, and the returned string is going to be
   * logged, then consider using [GLib.Uri.toStringPartial] to redact parts.
   * Returns: a string representing uri,
   *   which the caller must free.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_uri_to_string(cast(GUri*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns a string representing uri, subject to the options in
   * flags. See [GLib.Uri.toString_] and #GUriHideFlags for more details.
   * Params:
   *   flags = flags describing what parts of uri to hide
   * Returns: a string representing
   *   uri, which the caller must free.
   */
  string toStringPartial(UriHideFlags flags)
  {
    char* _cretval;
    _cretval = g_uri_to_string_partial(cast(GUri*)cPtr, flags);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Creates a new #GUri from the given components according to flags.
   * See also [GLib.Uri.buildWithUser], which allows specifying the
   * components of the "userinfo" separately.
   * Params:
   *   flags = flags describing how to build the #GUri
   *   scheme = the URI scheme
   *   userinfo = the userinfo component, or %NULL
   *   host = the host component, or %NULL
   *   port = the port, or `-1`
   *   path = the path component
   *   query = the query component, or %NULL
   *   fragment = the fragment, or %NULL
   * Returns: a new #GUri
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
    auto _retval = _cretval ? new Uri(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GUri from the given components according to flags
   * $(LPAREN)%G_URI_FLAGS_HAS_PASSWORD is added unconditionally$(RPAREN). The flags must be
   * coherent with the passed values, in particular use `%`-encoded values with
   * %G_URI_FLAGS_ENCODED.
   * In contrast to [GLib.Uri.build], this allows specifying the components
   * of the ‘userinfo’ field separately. Note that user must be non-%NULL
   * if either password or auth_params is non-%NULL.
   * Params:
   *   flags = flags describing how to build the #GUri
   *   scheme = the URI scheme
   *   user = the user component of the userinfo, or %NULL
   *   password = the password component of the userinfo, or %NULL
   *   authParams = the auth params of the userinfo, or %NULL
   *   host = the host component, or %NULL
   *   port = the port, or `-1`
   *   path = the path component
   *   query = the query component, or %NULL
   *   fragment = the fragment, or %NULL
   * Returns: a new #GUri
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
    auto _retval = _cretval ? new Uri(cast(void*)_cretval, true) : null;
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_uri_error_quark();
    return _retval;
  }

  /**
   * Escapes arbitrary data for use in a URI.
   * Normally all characters that are not ‘unreserved’ $(LPAREN)i.e. ASCII
   * alphanumerical characters plus dash, dot, underscore and tilde$(RPAREN) are
   * escaped. But if you specify characters in reserved_chars_allowed
   * they are not escaped. This is useful for the ‘reserved’ characters
   * in the URI specification, since those are allowed unescaped in some
   * portions of a URI.
   * Though technically incorrect, this will also allow escaping nul
   * bytes as `%``00`.
   * Params:
   *   unescaped = the unescaped input data.
   *   reservedCharsAllowed = a string of reserved
   *     characters that are allowed to be used, or %NULL.
   * Returns: an escaped version of unescaped.
   *   The returned string should be freed when no longer needed.
   */
  static string escapeBytes(ubyte[] unescaped, string reservedCharsAllowed)
  {
    char* _cretval;
    size_t _length;
    if (unescaped)
      _length = cast(size_t)unescaped.length;

    auto _unescaped = cast(const(ubyte)*)unescaped.ptr;
    const(char)* _reservedCharsAllowed = reservedCharsAllowed.toCString(false);
    _cretval = g_uri_escape_bytes(_unescaped, _length, _reservedCharsAllowed);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Escapes a string for use in a URI.
   * Normally all characters that are not "unreserved" $(LPAREN)i.e. ASCII
   * alphanumerical characters plus dash, dot, underscore and tilde$(RPAREN) are
   * escaped. But if you specify characters in reserved_chars_allowed
   * they are not escaped. This is useful for the "reserved" characters
   * in the URI specification, since those are allowed unescaped in some
   * portions of a URI.
   * Params:
   *   unescaped = the unescaped input string.
   *   reservedCharsAllowed = a string of reserved
   *     characters that are allowed to be used, or %NULL.
   *   allowUtf8 = %TRUE if the result can include UTF-8 characters.
   * Returns: an escaped version of unescaped. The
   *   returned string should be freed when no longer needed.
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
   * Parses uri_string according to flags, to determine whether it is a valid
   * [absolute URI](#relative-and-absolute-uris), i.e. it does not need to be resolved
   * relative to another URI using [GLib.Uri.parseRelative].
   * If it’s not a valid URI, an error is returned explaining how it’s invalid.
   * See [GLib.Uri.split], and the definition of #GUriFlags, for more
   * information on the effect of flags.
   * Params:
   *   uriString = a string containing an absolute URI
   *   flags = flags for parsing uri_string
   * Returns: %TRUE if uri_string is a valid absolute URI, %FALSE on error.
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
   * Joins the given components together according to flags to create
   * an absolute URI string. path may not be %NULL $(LPAREN)though it may be the empty
   * string$(RPAREN).
   * When host is present, path must either be empty or begin with a slash $(LPAREN)`/`$(RPAREN)
   * character. When host is not present, path cannot begin with two slash
   * characters $(LPAREN)`//`$(RPAREN). See
   * [RFC 3986, section 3](https://tools.ietf.org/html/rfc3986#section-3).
   * See also [GLib.Uri.joinWithUser], which allows specifying the
   * components of the ‘userinfo’ separately.
   * %G_URI_FLAGS_HAS_PASSWORD and %G_URI_FLAGS_HAS_AUTH_PARAMS are ignored if set
   * in flags.
   * Params:
   *   flags = flags describing how to build the URI string
   *   scheme = the URI scheme, or %NULL
   *   userinfo = the userinfo component, or %NULL
   *   host = the host component, or %NULL
   *   port = the port, or `-1`
   *   path = the path component
   *   query = the query component, or %NULL
   *   fragment = the fragment, or %NULL
   * Returns: an absolute URI string
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
   * Joins the given components together according to flags to create
   * an absolute URI string. path may not be %NULL $(LPAREN)though it may be the empty
   * string$(RPAREN).
   * In contrast to [GLib.Uri.join], this allows specifying the components
   * of the ‘userinfo’ separately. It otherwise behaves the same.
   * %G_URI_FLAGS_HAS_PASSWORD and %G_URI_FLAGS_HAS_AUTH_PARAMS are ignored if set
   * in flags.
   * Params:
   *   flags = flags describing how to build the URI string
   *   scheme = the URI scheme, or %NULL
   *   user = the user component of the userinfo, or %NULL
   *   password = the password component of the userinfo, or
   *     %NULL
   *   authParams = the auth params of the userinfo, or
   *     %NULL
   *   host = the host component, or %NULL
   *   port = the port, or `-1`
   *   path = the path component
   *   query = the query component, or %NULL
   *   fragment = the fragment, or %NULL
   * Returns: an absolute URI string
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
   * Splits an URI list conforming to the text/uri-list
   * mime type defined in RFC 2483 into individual URIs,
   * discarding any comments. The URIs are not validated.
   * Params:
   *   uriList = an URI list
   * Returns: a newly allocated %NULL-terminated list
   *   of strings holding the individual URIs. The array should be freed
   *   with [GLib.Global.strfreev].
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
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Parses uri_string according to flags. If the result is not a
   * valid [absolute URI](#relative-and-absolute-uris), it will be discarded, and an
   * error returned.
   * Params:
   *   uriString = a string representing an absolute URI
   *   flags = flags describing how to parse uri_string
   * Returns: a new #GUri, or NULL on error.
   */
  static Uri parse(string uriString, UriFlags flags)
  {
    GUri* _cretval;
    const(char)* _uriString = uriString.toCString(false);
    GError *_err;
    _cretval = g_uri_parse(_uriString, flags, &_err);
    if (_err)
      throw new UriException(_err);
    auto _retval = _cretval ? new Uri(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Many URI schemes include one or more attribute/value pairs as part of the URI
   * value. This method can be used to parse them into a hash table. When an
   * attribute has multiple occurrences, the last value is the final returned
   * value. If you need to handle repeated attributes differently, use
   * #GUriParamsIter.
   * The params string is assumed to still be `%`-encoded, but the returned
   * values will be fully decoded. $(LPAREN)Thus it is possible that the returned values
   * may contain `\=` or separators, if the value was encoded in the input.$(RPAREN)
   * Invalid `%`-encoding is treated as with the %G_URI_FLAGS_PARSE_RELAXED
   * rules for [GLib.Uri.parse]. $(LPAREN)However, if params is the path or query string
   * from a #GUri that was parsed without %G_URI_FLAGS_PARSE_RELAXED and
   * %G_URI_FLAGS_ENCODED, then you already know that it does not contain any
   * invalid encoding.$(RPAREN)
   * %G_URI_PARAMS_WWW_FORM is handled as documented for [GLib.UriParamsIter.init_].
   * If %G_URI_PARAMS_CASE_INSENSITIVE is passed to flags, attributes will be
   * compared case-insensitively, so a params string `attr\=123&Attr\=456` will only
   * return a single attribute–value pair, `Attr\=456`. Case will be preserved in
   * the returned attributes.
   * If params cannot be parsed $(LPAREN)for example, it contains two separators
   * characters in a row$(RPAREN), then error is set and %NULL is returned.
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
   * Returns: A hash table of attribute/value pairs, with both names and values
   *   fully-decoded; or %NULL on error.
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
    auto _retval = gHashTableToD!(string, string, GidOwnership.Full)(cast(GHashTable*)_cretval);
    return _retval;
  }

  /**
   * Gets the scheme portion of a URI string.
   * [RFC 3986](https://tools.ietf.org/html/rfc3986#section-3) decodes the scheme
   * as:
   * |[
   * URI \= scheme ":" hier-part [ "?" query ] [ "#" fragment ]
   * ]|
   * Common schemes include `file`, `https`, `svn+ssh`, etc.
   * Params:
   *   uri = a valid URI.
   * Returns: The ‘scheme’ component of the URI, or
   *   %NULL on error. The returned string should be freed when no longer needed.
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
   * Gets the scheme portion of a URI string.
   * [RFC 3986](https://tools.ietf.org/html/rfc3986#section-3) decodes the scheme
   * as:
   * |[
   * URI \= scheme ":" hier-part [ "?" query ] [ "#" fragment ]
   * ]|
   * Common schemes include `file`, `https`, `svn+ssh`, etc.
   * Unlike [GLib.Uri.parseScheme], the returned scheme is normalized to
   * all-lowercase and does not need to be freed.
   * Params:
   *   uri = a valid URI.
   * Returns: The ‘scheme’ component of the URI, or
   *   %NULL on error. The returned string is normalized to all-lowercase, and
   *   interned via [GLib.Global.internString], so it does not need to be freed.
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
   * Parses uri_ref according to flags and, if it is a
   * [relative URI](#relative-and-absolute-uris), resolves it relative to
   * base_uri_string. If the result is not a valid absolute URI, it will be
   * discarded, and an error returned.
   * $(LPAREN)If base_uri_string is %NULL, this just returns uri_ref, or
   * %NULL if uri_ref is invalid or not absolute.$(RPAREN)
   * Params:
   *   baseUriString = a string representing a base URI
   *   uriRef = a string representing a relative or absolute URI
   *   flags = flags describing how to parse uri_ref
   * Returns: the resolved URI string,
   *   or NULL on error.
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
   * Parses uri_ref $(LPAREN)which can be an
   * [absolute or relative URI](#relative-and-absolute-uris)$(RPAREN) according to flags, and
   * returns the pieces. Any component that doesn't appear in uri_ref will be
   * returned as %NULL $(LPAREN)but note that all URIs always have a path component,
   * though it may be the empty string$(RPAREN).
   * If flags contains %G_URI_FLAGS_ENCODED, then `%`-encoded characters in
   * uri_ref will remain encoded in the output strings. $(LPAREN)If not,
   * then all such characters will be decoded.$(RPAREN) Note that decoding will
   * only work if the URI components are ASCII or UTF-8, so you will
   * need to use %G_URI_FLAGS_ENCODED if they are not.
   * Note that the %G_URI_FLAGS_HAS_PASSWORD and
   * %G_URI_FLAGS_HAS_AUTH_PARAMS flags are ignored by [GLib.Uri.split],
   * since it always returns only the full userinfo; use
   * [GLib.Uri.splitWithUser] if you want it split up.
   * Params:
   *   uriRef = a string containing a relative or absolute URI
   *   flags = flags for parsing uri_ref
   *   scheme = on return, contains
   *     the scheme $(LPAREN)converted to lowercase$(RPAREN), or %NULL
   *   userinfo = on return, contains
   *     the userinfo, or %NULL
   *   host = on return, contains the
   *     host, or %NULL
   *   port = on return, contains the
   *     port, or `-1`
   *   path = on return, contains the
   *     path
   *   query = on return, contains the
   *     query, or %NULL
   *   fragment = on return, contains
   *     the fragment, or %NULL
   * Returns: %TRUE if uri_ref parsed successfully, %FALSE
   *   on error.
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
   * Parses uri_string $(LPAREN)which must be an [absolute URI](#relative-and-absolute-uris)$(RPAREN)
   * according to flags, and returns the pieces relevant to connecting to a host.
   * See the documentation for [GLib.Uri.split] for more details; this is
   * mostly a wrapper around that function with simpler arguments.
   * However, it will return an error if uri_string is a relative URI,
   * or does not contain a hostname component.
   * Params:
   *   uriString = a string containing an absolute URI
   *   flags = flags for parsing uri_string
   *   scheme = on return, contains
   *     the scheme $(LPAREN)converted to lowercase$(RPAREN), or %NULL
   *   host = on return, contains the
   *     host, or %NULL
   *   port = on return, contains the
   *     port, or `-1`
   * Returns: %TRUE if uri_string parsed successfully,
   *   %FALSE on error.
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
   * Parses uri_ref $(LPAREN)which can be an
   * [absolute or relative URI](#relative-and-absolute-uris)$(RPAREN) according to flags, and
   * returns the pieces. Any component that doesn't appear in uri_ref will be
   * returned as %NULL $(LPAREN)but note that all URIs always have a path component,
   * though it may be the empty string$(RPAREN).
   * See [GLib.Uri.split], and the definition of #GUriFlags, for more
   * information on the effect of flags. Note that password will only
   * be parsed out if flags contains %G_URI_FLAGS_HAS_PASSWORD, and
   * auth_params will only be parsed out if flags contains
   * %G_URI_FLAGS_HAS_AUTH_PARAMS.
   * Params:
   *   uriRef = a string containing a relative or absolute URI
   *   flags = flags for parsing uri_ref
   *   scheme = on return, contains
   *     the scheme $(LPAREN)converted to lowercase$(RPAREN), or %NULL
   *   user = on return, contains
   *     the user, or %NULL
   *   password = on return, contains
   *     the password, or %NULL
   *   authParams = on return, contains
   *     the auth_params, or %NULL
   *   host = on return, contains the
   *     host, or %NULL
   *   port = on return, contains the
   *     port, or `-1`
   *   path = on return, contains the
   *     path
   *   query = on return, contains the
   *     query, or %NULL
   *   fragment = on return, contains
   *     the fragment, or %NULL
   * Returns: %TRUE if uri_ref parsed successfully, %FALSE
   *   on error.
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
   * Unescapes a segment of an escaped string.
   * If any of the characters in illegal_characters or the NUL
   * character appears as an escaped character in escaped_string, then
   * that is an error and %NULL will be returned. This is useful if you
   * want to avoid for instance having a slash being expanded in an
   * escaped path element, which might confuse pathname handling.
   * Note: `NUL` byte is not accepted in the output, in contrast to
   * [GLib.Uri.unescapeBytes].
   * Params:
   *   escapedString = A string, may be %NULL
   *   escapedStringEnd = Pointer to end of escaped_string,
   *     may be %NULL
   *   illegalCharacters = An optional string of illegal
   *     characters not to be allowed, may be %NULL
   * Returns: an unescaped version of escaped_string,
   *   or %NULL on error. The returned string should be freed when no longer
   *   needed.  As a special case if %NULL is given for escaped_string, this
   *   function will return %NULL.
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
   * Unescapes a whole escaped string.
   * If any of the characters in illegal_characters or the NUL
   * character appears as an escaped character in escaped_string, then
   * that is an error and %NULL will be returned. This is useful if you
   * want to avoid for instance having a slash being expanded in an
   * escaped path element, which might confuse pathname handling.
   * Params:
   *   escapedString = an escaped string to be unescaped.
   *   illegalCharacters = a string of illegal characters
   *     not to be allowed, or %NULL.
   * Returns: an unescaped version of escaped_string.
   *   The returned string should be freed when no longer needed.
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
