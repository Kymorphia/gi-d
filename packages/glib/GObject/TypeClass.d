module GObject.TypeClass;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * An opaque structure used as the base of all classes.
 */
class TypeClass
{
  GTypeClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeClass");

    cInstance = *cast(GTypeClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  ~this()
  {
    g_type_class_unref(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GTypeClass))
  {
    return cast(T*)&cInstance;
  }

  /**
   * Registers a private structure for an instantiatable type.
   *
   * When an object is allocated, the private structures for
   * the type and all of its parent types are allocated
   * sequentially in the same memory block as the public
   * structures, and are zero-filled.
   *
   * Note that the accumulated size of the private structures of
   * a type and all its parent types cannot exceed 64 KiB.
   *
   * This function should be called in the type's class_init() function.
   * The private structure can be retrieved using the
   * G_TYPE_INSTANCE_GET_PRIVATE() macro.
   *
   * The following example shows attaching a private structure
   * MyObjectPrivate to an object MyObject defined in the standard
   * GObject fashion in the type's class_init() function.
   *
   * Note the use of a structure member "priv" to avoid the overhead
   * of repeatedly calling MY_OBJECT_GET_PRIVATE().
   *
   * |[<!-- language="C" -->
   * typedef struct _MyObject        MyObject;
   * typedef struct _MyObjectPrivate MyObjectPrivate;
   *
   * struct _MyObject {
   * GObject parent;
   *
   * MyObjectPrivate *priv;
   * };
   *
   * struct _MyObjectPrivate {
   * int some_field;
   * };
   *
   * static void
   * my_object_class_init (MyObjectClass *klass)
   * {
   * g_type_class_add_private (klass, sizeof (MyObjectPrivate));
   * }
   *
   * static void
   * my_object_init (MyObject *my_object)
   * {
   * my_object->priv = G_TYPE_INSTANCE_GET_PRIVATE (my_object,
   * MY_TYPE_OBJECT,
   * MyObjectPrivate);
   * // my_object->priv->some_field will be automatically initialised to 0
   * }
   *
   * static int
   * my_object_get_some_field (MyObject *my_object)
   * {
   * MyObjectPrivate *priv;
   *
   * g_return_val_if_fail (MY_IS_OBJECT (my_object), 0);
   *
   * priv = my_object->priv;
   *
   * return priv->some_field;
   * }
   * ]|
   */
  void addPrivate(size_t privateSize)
  {
    g_type_class_add_private(cPtr!GTypeClass, privateSize);
  }

  void* getPrivate(GType privateType)
  {
    void* _retval;
    _retval = g_type_class_get_private(cPtr!GTypeClass, privateType);
    return _retval;
  }

  /**
   * the parent class
   * of @g_class
   */
  TypeClass peekParent()
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek_parent(cPtr!GTypeClass);
    TypeClass _retval = new TypeClass(cast(GTypeClass*)_cretval);
    return _retval;
  }

  static void adjustPrivateOffset(void* gClass, inout int privateSizeOrOffset)
  {
    g_type_class_adjust_private_offset(gClass, cast(int*)&privateSizeOrOffset);
  }

  /**
   * the #GTypeClass
   * structure for the given type ID or %NULL if the class does not
   * currently exist
   */
  static TypeClass peek(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek(type);
    TypeClass _retval = new TypeClass(cast(GTypeClass*)_cretval);
    return _retval;
  }

  /**
   * the #GTypeClass
   * structure for the given type ID or %NULL if the class does not
   * currently exist or is dynamically loaded
   */
  static TypeClass peekStatic(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek_static(type);
    TypeClass _retval = new TypeClass(cast(GTypeClass*)_cretval);
    return _retval;
  }

  /**
   * the #GTypeClass
   * structure for the given type ID
   */
  static TypeClass ref_(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_ref(type);
    TypeClass _retval = new TypeClass(cast(GTypeClass*)_cretval);
    return _retval;
  }
}
