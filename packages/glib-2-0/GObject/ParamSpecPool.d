module GObject.ParamSpecPool;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpecPool maintains a collection of #GParamSpecs which can be
 * quickly accessed by owner and name.
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

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Inserts a #GParamSpec in the pool.
   * Params:
   *   pspec = the #GParamSpec to insert
   *   ownerType = a #GType identifying the owner of pspec
   */
  void insert(ParamSpec pspec, GType ownerType)
  {
    g_param_spec_pool_insert(cast(GParamSpecPool*)cPtr, pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, ownerType);
  }

  /**
   * Gets an array of all #GParamSpecs owned by owner_type in
   * the pool.
   * Params:
   *   ownerType = the owner to look for
   * Returns: a newly
   *   allocated array containing pointers to all #GParamSpecs
   *   owned by owner_type in the pool
   */
  ParamSpec[] list(GType ownerType)
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = g_param_spec_pool_list(cast(GParamSpecPool*)cPtr, ownerType, &_cretlength);
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
   * Gets an #GList of all #GParamSpecs owned by owner_type in
   * the pool.
   * Params:
   *   ownerType = the owner to look for
   * Returns: a
   *   #GList of all #GParamSpecs owned by owner_type in
   *   the pool#GParamSpecs.
   */
  ParamSpec[] listOwned(GType ownerType)
  {
    GList* _cretval;
    _cretval = g_param_spec_pool_list_owned(cast(GParamSpecPool*)cPtr, ownerType);
    auto _retval = gListToD!(ParamSpec, GidOwnership.Container)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Looks up a #GParamSpec in the pool.
   * Params:
   *   paramName = the name to look for
   *   ownerType = the owner to look for
   *   walkAncestors = If %TRUE, also try to find a #GParamSpec with param_name
   *     owned by an ancestor of owner_type.
   * Returns: The found #GParamSpec, or %NULL if no
   *   matching #GParamSpec was found.
   */
  ParamSpec lookup(string paramName, GType ownerType, bool walkAncestors)
  {
    GParamSpec* _cretval;
    const(char)* _paramName = paramName.toCString(false);
    _cretval = g_param_spec_pool_lookup(cast(GParamSpecPool*)cPtr, _paramName, ownerType, walkAncestors);
    auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes a #GParamSpec from the pool.
   * Params:
   *   pspec = the #GParamSpec to remove
   */
  void remove(ParamSpec pspec)
  {
    g_param_spec_pool_remove(cast(GParamSpecPool*)cPtr, pspec ? cast(GParamSpec*)pspec.cPtr(false) : null);
  }

  /**
   * Creates a new #GParamSpecPool.
   * If type_prefixing is %TRUE, lookups in the newly created pool will
   * allow to specify the owner as a colon-separated prefix of the
   * property name, like "GtkContainer:border-width". This feature is
   * deprecated, so you should always set type_prefixing to %FALSE.
   * Params:
   *   typePrefixing = Whether the pool will support type-prefixed property names.
   * Returns: a newly allocated #GParamSpecPool.
   */
  this(bool typePrefixing)
  {
    GParamSpecPool* _cretval;
    _cretval = g_param_spec_pool_new(typePrefixing);
    this(_cretval, true);
  }
}
