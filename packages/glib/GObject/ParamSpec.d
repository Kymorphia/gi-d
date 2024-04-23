module GObject.ParamSpec;

import GLib.Types;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * #GParamSpec is an object structure that encapsulates the metadata
 * required to specify parameters, such as e.g. #GObject properties.
 *
 * ## Parameter names # {#canonical-parameter-names}
 *
 * A property name consists of one or more segments consisting of ASCII letters
 * and digits, separated by either the `-` or `_` character. The first
 * character of a property name must be a letter. These are the same rules as
 * for signal naming (see g_signal_new()).
 *
 * When creating and looking up a #GParamSpec, either separator can be
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


  T* cPtr(T)(bool addRef = false)
  if (is(T == GParamSpec))
  {
    if (addRef)
      g_param_spec_ref(cInstancePtr);

    return cast(T*)cInstancePtr;
  }

  /**
   * %TRUE if @name is a valid property name, %FALSE otherwise.
   */
  static bool isValidName(string name)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_param_spec_is_valid_name(_name);
    return _retval;
  }

  /**
   * the short description of @pspec.
   */
  string getBlurb()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_blurb(cPtr!GParamSpec);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a pointer to a #GValue which must not be modified
   */
  Value getDefaultValue()
  {
    const(GValue)* _cretval;
    _cretval = g_param_spec_get_default_value(cPtr!GParamSpec);
    Value _retval = new Value(cast(GValue*)_cretval, false);
    return _retval;
  }

  /**
   * the name of @pspec.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_name(cPtr!GParamSpec);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the GQuark for @pspec->name.
   */
  Quark getNameQuark()
  {
    Quark _retval;
    _retval = g_param_spec_get_name_quark(cPtr!GParamSpec);
    return _retval;
  }

  /**
   * the nickname of @pspec.
   */
  string getNick()
  {
    const(char)* _cretval;
    _cretval = g_param_spec_get_nick(cPtr!GParamSpec);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the user data pointer set, or %NULL
   */
  void* getQdata(Quark quark)
  {
    void* _retval;
    _retval = g_param_spec_get_qdata(cPtr!GParamSpec, quark);
    return _retval;
  }

  /**
   * paramspec to which requests on this
   * paramspec should be redirected, or %NULL if none.
   */
  ParamSpec getRedirectTarget()
  {
    GParamSpec* _cretval;
    _cretval = g_param_spec_get_redirect_target(cPtr!GParamSpec);
    ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, false);
    return _retval;
  }

  /**
   * Sets an opaque, named pointer on a #GParamSpec. The name is
   * specified through a #GQuark (retrieved e.g. via
   * g_quark_from_static_string()), and the pointer can be gotten back
   * from the @pspec with g_param_spec_get_qdata().  Setting a
   * previously set user data pointer, overrides (frees) the old pointer
   * set, using %NULL as pointer essentially removes the data stored.
   */
  void setQdata(Quark quark, void* data)
  {
    g_param_spec_set_qdata(cPtr!GParamSpec, quark, data);
  }

  /**
   * The initial reference count of a newly created #GParamSpec is 1,
   * even though no one has explicitly called g_param_spec_ref() on it
   * yet. So the initial reference count is flagged as "floating", until
   * someone calls `g_param_spec_ref (pspec); g_param_spec_sink
   * (pspec);` in sequence on it, taking over the initial
   * reference count (thus ending up with a @pspec that has a reference
   * count of 1 still, but is not flagged "floating" anymore).
   */
  void sink()
  {
    g_param_spec_sink(cPtr!GParamSpec);
  }

  /**
   * the user data pointer set, or %NULL
   */
  void* stealQdata(Quark quark)
  {
    void* _retval;
    _retval = g_param_spec_steal_qdata(cPtr!GParamSpec, quark);
    return _retval;
  }
}
