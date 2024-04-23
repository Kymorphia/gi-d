module GObject.ParamSpecPool;

import GLib.List;
import GLib.Types;
import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A #GParamSpecPool maintains a collection of #GParamSpecs which can be
 * quickly accessed by owner and name.
 *
 * The implementation of the #GObject property system uses such a pool to
 * store the #GParamSpecs of the properties all object types.
 */
class ParamSpecPool
{
  GParamSpecPool* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecPool");

    cInstancePtr = cast(GParamSpecPool*)ptr;

    this.owned = owned;
  }

  T* cPtr(T)()
  if (is(T == GParamSpecPool))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Inserts a #GParamSpec in the pool.
   */
  void insert(ParamSpec pspec, GType ownerType)
  {
    g_param_spec_pool_insert(cPtr!GParamSpecPool, pspec ? pspec.cPtr!GParamSpec : null, ownerType);
  }

  /**
   * a newly
   * allocated array containing pointers to all #GParamSpecs
   * owned by @owner_type in the pool
   */
  ParamSpec[] list(GType ownerType)
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = g_param_spec_pool_list(cPtr!GParamSpecPool, ownerType, &_cretlength);
    ParamSpec[] _retval;

    if (_cretval)
    {
      _retval = new ParamSpec[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new ParamSpec(cast(void*)_cretval[i], false);
    }
    return _retval;
  }

  /**
   * a
   * #GList of all #GParamSpecs owned by @owner_type in
   * the pool#GParamSpecs.
   */
  List!(ParamSpec, GParamSpec*) listOwned(GType ownerType)
  {
    GList* _cretval;
    _cretval = g_param_spec_pool_list_owned(cPtr!GParamSpecPool, ownerType);
    List!(ParamSpec, GParamSpec*) _retval = _cretval ? new List!(ParamSpec, GParamSpec*)(_cretval, GidOwnership.Container) : null;
    return _retval;
  }

  /**
   * The found #GParamSpec, or %NULL if no
   * matching #GParamSpec was found.
   */
  ParamSpec lookup(string paramName, GType ownerType, bool walkAncestors)
  {
    GParamSpec* _cretval;
    const(char)* _paramName = paramName.toCString(false);
    _cretval = g_param_spec_pool_lookup(cPtr!GParamSpecPool, _paramName, ownerType, walkAncestors);
    ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, false);
    return _retval;
  }

  /**
   * Removes a #GParamSpec from the pool.
   */
  void remove(ParamSpec pspec)
  {
    g_param_spec_pool_remove(cPtr!GParamSpecPool, pspec ? pspec.cPtr!GParamSpec : null);
  }

  /**
   * a newly allocated #GParamSpecPool.
   */
  this(bool typePrefixing)
  {
    GParamSpecPool* _cretval;
    _cretval = g_param_spec_pool_new(typePrefixing);
    this(_cretval, true);
  }
}
