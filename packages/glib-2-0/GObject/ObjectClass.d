module GObject.ObjectClass;

import GObject.ParamSpec;
import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * The class structure for the GObject type.
 * |[<!-- language\="C" -->
 * // Example of implementing a singleton using a constructor.
 * static MySingleton *the_singleton \= NULL;
 * static GObject*
 * my_singleton_constructor $(LPAREN)GType                  type,
 * guint                  n_construct_params,
 * GObjectConstructParam *construct_params$(RPAREN)
 * {
 * GObject *object;
 * if $(LPAREN)!the_singleton$(RPAREN)
 * {
 * object \= G_OBJECT_CLASS $(LPAREN)parent_class$(RPAREN)->constructor $(LPAREN)type,
 * n_construct_params,
 * construct_params$(RPAREN);
 * the_singleton \= MY_SINGLETON $(LPAREN)object$(RPAREN);
 * }
 * else
 * object \= g_object_ref $(LPAREN)G_OBJECT $(LPAREN)the_singleton$(RPAREN)$(RPAREN);
 * return object;
 * }
 * ]|
 */
class ObjectClass
{
  GObjectClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ObjectClass");

    cInstance = *cast(GObjectClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&(cast(GObjectClass*)cPtr).gTypeClass);
  }

  alias SetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec);

  @property SetPropertyFuncType setProperty()
  {
    return (cast(GObjectClass*)cPtr).setProperty;
  }

  alias GetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec);

  @property GetPropertyFuncType getProperty()
  {
    return (cast(GObjectClass*)cPtr).getProperty;
  }

  alias DisposeFuncType = extern(C) void function(ObjectC* object);

  @property DisposeFuncType dispose()
  {
    return (cast(GObjectClass*)cPtr).dispose;
  }

  alias FinalizeFuncType = extern(C) void function(ObjectC* object);

  @property FinalizeFuncType finalize()
  {
    return (cast(GObjectClass*)cPtr).finalize;
  }

  alias DispatchPropertiesChangedFuncType = extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs);

  @property DispatchPropertiesChangedFuncType dispatchPropertiesChanged()
  {
    return (cast(GObjectClass*)cPtr).dispatchPropertiesChanged;
  }

  alias NotifyFuncType = extern(C) void function(ObjectC* object, GParamSpec* pspec);

  @property NotifyFuncType notify()
  {
    return (cast(GObjectClass*)cPtr).notify;
  }

  alias ConstructedFuncType = extern(C) void function(ObjectC* object);

  @property ConstructedFuncType constructed()
  {
    return (cast(GObjectClass*)cPtr).constructed;
  }

  /**
   * Looks up the #GParamSpec for a property of a class.
   * Params:
   *   propertyName = the name of the property to look up
   * Returns: the #GParamSpec for the property, or
   *   %NULL if the class doesn't have a property of that name
   */
  ParamSpec findProperty(string propertyName)
  {
    GParamSpec* _cretval;
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_object_class_find_property(cast(GObjectClass*)cPtr, _propertyName);
    auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Installs new properties from an array of #GParamSpecs.
   * All properties should be installed during the class initializer.  It
   * is possible to install properties after that, but doing so is not
   * recommend, and specifically, is not guaranteed to be thread-safe vs.
   * use of properties on the same type on other threads.
   * The property id of each property is the index of each #GParamSpec in
   * the pspecs array.
   * The property id of 0 is treated specially by #GObject and it should not
   * be used to store a #GParamSpec.
   * This function should be used if you plan to use a static array of
   * #GParamSpecs and [GObject.ObjectG.notifyByPspec]. For instance, this
   * class initialization:
   * |[<!-- language\="C" -->
   * typedef enum {
   * PROP_FOO \= 1,
   * PROP_BAR,
   * N_PROPERTIES
   * } MyObjectProperty;
   * static GParamSpec *obj_properties[N_PROPERTIES] \= { NULL, };
   * static void
   * my_object_class_init $(LPAREN)MyObjectClass *klass$(RPAREN)
   * {
   * GObjectClass *gobject_class \= G_OBJECT_CLASS $(LPAREN)klass$(RPAREN);
   * obj_properties[PROP_FOO] \=
   * g_param_spec_int $(LPAREN)"foo", NULL, NULL,
   * -1, G_MAXINT,
   * 0,
   * G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS$(RPAREN);
   * obj_properties[PROP_BAR] \=
   * g_param_spec_string $(LPAREN)"bar", NULL, NULL,
   * NULL,
   * G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS$(RPAREN);
   * gobject_class->set_property \= my_object_set_property;
   * gobject_class->get_property \= my_object_get_property;
   * g_object_class_install_properties $(LPAREN)gobject_class,
   * G_N_ELEMENTS $(LPAREN)obj_properties$(RPAREN),
   * obj_properties$(RPAREN);
   * }
   * ]|
   * allows calling [GObject.ObjectG.notifyByPspec] to notify of property changes:
   * |[<!-- language\="C" -->
   * void
   * my_object_set_foo $(LPAREN)MyObject *self, gint foo$(RPAREN)
   * {
   * if $(LPAREN)self->foo !\= foo$(RPAREN)
   * {
   * self->foo \= foo;
   * g_object_notify_by_pspec $(LPAREN)G_OBJECT $(LPAREN)self$(RPAREN), obj_properties[PROP_FOO]$(RPAREN);
   * }
   * }
   * ]|
   * Params:
   *   pspecs = the #GParamSpecs array
   *     defining the new properties
   */
  void installProperties(ParamSpec[] pspecs)
  {
    uint _nPspecs;
    if (pspecs)
      _nPspecs = cast(uint)pspecs.length;

    GParamSpec*[] _tmppspecs;
    foreach (obj; pspecs)
      _tmppspecs ~= obj ? cast(GParamSpec*)obj.cPtr : null;
    GParamSpec** _pspecs = cast(GParamSpec**)_tmppspecs.ptr;
    g_object_class_install_properties(cast(GObjectClass*)cPtr, _nPspecs, _pspecs);
  }

  /**
   * Installs a new property.
   * All properties should be installed during the class initializer.  It
   * is possible to install properties after that, but doing so is not
   * recommend, and specifically, is not guaranteed to be thread-safe vs.
   * use of properties on the same type on other threads.
   * Note that it is possible to redefine a property in a derived class,
   * by installing a property with the same name. This can be useful at times,
   * e.g. to change the range of allowed values or the default value.
   * Params:
   *   propertyId = the id for the new property
   *   pspec = the #GParamSpec for the new property
   */
  void installProperty(uint propertyId, ParamSpec pspec)
  {
    g_object_class_install_property(cast(GObjectClass*)cPtr, propertyId, pspec ? cast(GParamSpec*)pspec.cPtr(false) : null);
  }

  /**
   * Get an array of #GParamSpec* for all properties of a class.
   * Returns: an array of
   *   #GParamSpec* which should be freed after use
   */
  ParamSpec[] listProperties()
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = g_object_class_list_properties(cast(GObjectClass*)cPtr, &_cretlength);
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
   * Registers property_id as referring to a property with the name
   * name in a parent class or in an interface implemented by oclass.
   * This allows this class to "override" a property implementation in
   * a parent class or to provide the implementation of a property from
   * an interface.
   * Internally, overriding is implemented by creating a property of type
   * #GParamSpecOverride; generally operations that query the properties of
   * the object class, such as [GObject.ObjectClass.findProperty] or
   * [GObject.ObjectClass.listProperties] will return the overridden
   * property. However, in one case, the construct_properties argument of
   * the constructor virtual function, the #GParamSpecOverride is passed
   * instead, so that the param_id field of the #GParamSpec will be
   * correct.  For virtually all uses, this makes no difference. If you
   * need to get the overridden property, you can call
   * [GObject.ParamSpec.getRedirectTarget].
   * Params:
   *   propertyId = the new property ID
   *   name = the name of a property registered in a parent class or
   *     in an interface of this class.
   */
  void overrideProperty(uint propertyId, string name)
  {
    const(char)* _name = name.toCString(false);
    g_object_class_override_property(cast(GObjectClass*)cPtr, propertyId, _name);
  }
}
