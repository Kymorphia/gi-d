module GObject.ParamSpec;

import GLib.Types;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * `GParamSpec` encapsulates the metadata required to specify parameters, such as `GObject` properties.
 * ## Parameter names
 * A property name consists of one or more segments consisting of ASCII letters
 * and digits, separated by either the `-` or `_` character. The first
 * character of a property name must be a letter. These are the same rules as
 * for signal naming $(LPAREN)see func@GObject.signal_new$(RPAREN).
 * When creating and looking up a `GParamSpec`, either separator can be
 * used, but they cannot be mixed. Using `-` is considerably more
 * efficient, and is the ‘canonical form’. Using `_` is discouraged.
 */
class ParamSpec
{
  GParamSpec* cInstancePtr;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpec");

    cInstancePtr = cast(GParamSpec*)ptr;

    if (!ownedRef)
      g_param_spec_ref(cInstancePtr);
  }

  ~this()
  {
    g_param_spec_unref(cInstancePtr);
  }


  void* cPtr(bool addRef = false)
  {
    if (addRef)
      g_param_spec_ref(cInstancePtr);

    return cInstancePtr;
  }

  /**
   * Validate a property name for a #GParamSpec. This can be useful for
   * dynamically-generated properties which need to be validated at run-time
   * before actually trying to create them.
   * See [canonical parameter names][canonical-parameter-names] for details of
   * the rules for valid names.
   * Params:
   *   name = the canonical name of the property
   * Returns: %TRUE if name is a valid property name, %FALSE otherwise.
   */
  static bool isValidName(string name)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_param_spec_is_valid_name(_name);
    return _retval;
  }

  /**
   * Get the short description of a #GParamSpec.
   * Returns: the short description of pspec.
   */
  string getBlurb()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_blurb(cast(GParamSpec*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the default value of pspec as a pointer to a #GValue.
   * The #GValue will remain valid for the life of pspec.
   * Returns: a pointer to a #GValue which must not be modified
   */
  Value getDefaultValue()
  {
    const(GValue)* _cretval;
    _cretval = g_param_spec_get_default_value(cast(GParamSpec*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Get the name of a #GParamSpec.
   * The name is always an "interned" string $(LPAREN)as per [GLib.Global.internString]$(RPAREN).
   * This allows for pointer-value comparisons.
   * Returns: the name of pspec.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_name(cast(GParamSpec*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the GQuark for the name.
   * Returns: the GQuark for pspec->name.
   */
  Quark getNameQuark()
  {
    Quark _retval;
    _retval = g_param_spec_get_name_quark(cast(GParamSpec*)cPtr);
    return _retval;
  }

  /**
   * Get the nickname of a #GParamSpec.
   * Returns: the nickname of pspec.
   */
  string getNick()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_nick(cast(GParamSpec*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets back user data pointers stored via [GObject.ParamSpec.setQdata].
   * Params:
   *   quark = a #GQuark, naming the user data pointer
   * Returns: the user data pointer set, or %NULL
   */
  void* getQdata(Quark quark)
  {
    void* _retval;
    _retval = g_param_spec_get_qdata(cast(GParamSpec*)cPtr, quark);
    return _retval;
  }

  /**
   * If the paramspec redirects operations to another paramspec,
   * returns that paramspec. Redirect is used typically for
   * providing a new implementation of a property in a derived
   * type while preserving all the properties from the parent
   * type. Redirection is established by creating a property
   * of type #GParamSpecOverride. See [GObject.ObjectClass.overrideProperty]
   * for an example of the use of this capability.
   * Returns: paramspec to which requests on this
   *   paramspec should be redirected, or %NULL if none.
   */
  ParamSpec getRedirectTarget()
  {
    GParamSpec* _cretval;
    _cretval = g_param_spec_get_redirect_target(cast(GParamSpec*)cPtr);
    auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets an opaque, named pointer on a #GParamSpec. The name is
   * specified through a #GQuark $(LPAREN)retrieved e.g. via
   * [GLib.Global.quarkFromStaticString]$(RPAREN), and the pointer can be gotten back
   * from the pspec with [GObject.ParamSpec.getQdata].  Setting a
   * previously set user data pointer, overrides $(LPAREN)frees$(RPAREN) the old pointer
   * set, using %NULL as pointer essentially removes the data stored.
   * Params:
   *   quark = a #GQuark, naming the user data pointer
   *   data = an opaque user data pointer
   */
  void setQdata(Quark quark, void* data)
  {
    g_param_spec_set_qdata(cast(GParamSpec*)cPtr, quark, data);
  }

  /**
   * The initial reference count of a newly created #GParamSpec is 1,
   * even though no one has explicitly called [GObject.ParamSpec.ref_] on it
   * yet. So the initial reference count is flagged as "floating", until
   * someone calls `g_param_spec_ref $(LPAREN)pspec$(RPAREN); g_param_spec_sink
   * $(LPAREN)pspec$(RPAREN);` in sequence on it, taking over the initial
   * reference count $(LPAREN)thus ending up with a pspec that has a reference
   * count of 1 still, but is not flagged "floating" anymore$(RPAREN).
   */
  void sink()
  {
    g_param_spec_sink(cast(GParamSpec*)cPtr);
  }

  /**
   * Gets back user data pointers stored via [GObject.ParamSpec.setQdata]
   * and removes the data from pspec without invoking its destroy$(LPAREN)$(RPAREN)
   * function $(LPAREN)if any was set$(RPAREN).  Usually, calling this function is only
   * required to update user data pointers with a destroy notifier.
   * Params:
   *   quark = a #GQuark, naming the user data pointer
   * Returns: the user data pointer set, or %NULL
   */
  void* stealQdata(Quark quark)
  {
    void* _retval;
    _retval = g_param_spec_steal_qdata(cast(GParamSpec*)cPtr, quark);
    return _retval;
  }
}
