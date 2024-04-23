module GObject.ObjectClass;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.TypeClass;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The class structure for the GObject type.
 *
 * |[<!-- language="C" -->
 * // Example of implementing a singleton using a constructor.
 * static MySingleton *the_singleton = NULL;
 *
 * static GObject*
 * my_singleton_constructor (GType                  type,
 * guint                  n_construct_params,
 * GObjectConstructParam *construct_params)
 * {
 * GObject *object;
 *
 * if (!the_singleton)
 * {
 * object = G_OBJECT_CLASS (parent_class)->constructor (type,
 * n_construct_params,
 * construct_params);
 * the_singleton = MY_SINGLETON (object);
 * }
 * else
 * object = g_object_ref (G_OBJECT (the_singleton));
 *
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GObjectClass))
  {
    return cast(T*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&cPtr!GObjectClass.gTypeClass);
  }

  alias SetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec);

  @property SetPropertyFuncType setProperty()
  {
    return cPtr!GObjectClass.setProperty;
  }

  alias GetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec);

  @property GetPropertyFuncType getProperty()
  {
    return cPtr!GObjectClass.getProperty;
  }

  alias DisposeFuncType = extern(C) void function(ObjectC* object);

  @property DisposeFuncType dispose()
  {
    return cPtr!GObjectClass.dispose;
  }

  alias FinalizeFuncType = extern(C) void function(ObjectC* object);

  @property FinalizeFuncType finalize()
  {
    return cPtr!GObjectClass.finalize;
  }

  alias DispatchPropertiesChangedFuncType = extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs);

  @property DispatchPropertiesChangedFuncType dispatchPropertiesChanged()
  {
    return cPtr!GObjectClass.dispatchPropertiesChanged;
  }

  alias NotifyFuncType = extern(C) void function(ObjectC* object, GParamSpec* pspec);

  @property NotifyFuncType notify()
  {
    return cPtr!GObjectClass.notify;
  }

  alias ConstructedFuncType = extern(C) void function(ObjectC* object);

  @property ConstructedFuncType constructed()
  {
    return cPtr!GObjectClass.constructed;
  }

  /**
   * the #GParamSpec for the property, or
   * %NULL if the class doesn't have a property of that name
   */
  ParamSpec findProperty(string propertyName)
  {
    GParamSpec* _cretval;
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_object_class_find_property(cPtr!GObjectClass, _propertyName);
    ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, false);
    return _retval;
  }

  /**
   * Installs new properties from an array of #GParamSpecs.
   *
   * All properties should be installed during the class initializer.  It
   * is possible to install properties after that, but doing so is not
   * recommend, and specifically, is not guaranteed to be thread-safe vs.
   * use of properties on the same type on other threads.
   *
   * The property id of each property is the index of each #GParamSpec in
   * the @pspecs array.
   *
   * The property id of 0 is treated specially by #GObject and it should not
   * be used to store a #GParamSpec.
   *
   * This function should be used if you plan to use a static array of
   * #GParamSpecs and g_object_notify_by_pspec(). For instance, this
   * class initialization:
   *
   * |[<!-- language="C" -->
   * typedef enum {
   * PROP_FOO = 1,
   * PROP_BAR,
   * N_PROPERTIES
   * } MyObjectProperty;
   *
   * static GParamSpec *obj_properties[N_PROPERTIES] = { NULL, };
   *
   * static void
   * my_object_class_init (MyObjectClass *klass)
   * {
   * GObjectClass *gobject_class = G_OBJECT_CLASS (klass);
   *
   * obj_properties[PROP_FOO] =
   * g_param_spec_int ("foo", "Foo", "Foo",
   * -1, G_MAXINT,
   * 0,
   * G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS);
   *
   * obj_properties[PROP_BAR] =
   * g_param_spec_string ("bar", "Bar", "Bar",
   * NULL,
   * G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS);
   *
   * gobject_class->set_property = my_object_set_property;
   * gobject_class->get_property = my_object_get_property;
   * g_object_class_install_properties (gobject_class,
   * G_N_ELEMENTS (obj_properties),
   * obj_properties);
   * }
   * ]|
   *
   * allows calling g_object_notify_by_pspec() to notify of property changes:
   *
   * |[<!-- language="C" -->
   * void
   * my_object_set_foo (MyObject *self, gint foo)
   * {
   * if (self->foo != foo)
   * {
   * self->foo = foo;
   * g_object_notify_by_pspec (G_OBJECT (self), obj_properties[PROP_FOO]);
   * }
   * }
   * ]|
   */
  void installProperties(ParamSpec[] pspecs)
  {
    GParamSpec*[] _tmppspecs;
    foreach (obj; pspecs)
      _tmppspecs ~= obj ? obj.cPtr!GParamSpec : null;
    GParamSpec** _pspecs = cast(GParamSpec**)_tmppspecs.ptr;
    g_object_class_install_properties(cPtr!GObjectClass, pspecs ? cast(uint)pspecs.length : 0, _pspecs);
  }

  /**
   * Installs a new property.
   *
   * All properties should be installed during the class initializer.  It
   * is possible to install properties after that, but doing so is not
   * recommend, and specifically, is not guaranteed to be thread-safe vs.
   * use of properties on the same type on other threads.
   *
   * Note that it is possible to redefine a property in a derived class,
   * by installing a property with the same name. This can be useful at times,
   * e.g. to change the range of allowed values or the default value.
   */
  void installProperty(uint propertyId, ParamSpec pspec)
  {
    g_object_class_install_property(cPtr!GObjectClass, propertyId, pspec ? pspec.cPtr!GParamSpec : null);
  }

  /**
   * an array of
   * #GParamSpec* which should be freed after use
   */
  ParamSpec[] listProperties()
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = g_object_class_list_properties(cPtr!GObjectClass, &_cretlength);
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
   * Registers @property_id as referring to a property with the name
   * @name in a parent class or in an interface implemented by @oclass.
   * This allows this class to "override" a property implementation in
   * a parent class or to provide the implementation of a property from
   * an interface.
   *
   * Internally, overriding is implemented by creating a property of type
   * #GParamSpecOverride; generally operations that query the properties of
   * the object class, such as g_object_class_find_property() or
   * g_object_class_list_properties() will return the overridden
   * property. However, in one case, the @construct_properties argument of
   * the @constructor virtual function, the #GParamSpecOverride is passed
   * instead, so that the @param_id field of the #GParamSpec will be
   * correct.  For virtually all uses, this makes no difference. If you
   * need to get the overridden property, you can call
   * g_param_spec_get_redirect_target().
   */
  void overrideProperty(uint propertyId, string name)
  {
    const(char)* _name = name.toCString(false);
    g_object_class_override_property(cPtr!GObjectClass, propertyId, _name);
  }
}
