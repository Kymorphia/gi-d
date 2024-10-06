module GObject.TypeClass;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  ~this()
  {
    g_type_class_unref(&cInstance);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Registers a private structure for an instantiatable type.
   * When an object is allocated, the private structures for
   * the type and all of its parent types are allocated
   * sequentially in the same memory block as the public
   * structures, and are zero-filled.
   * Note that the accumulated size of the private structures of
   * a type and all its parent types cannot exceed 64 KiB.
   * This function should be called in the type's class_init$(LPAREN)$(RPAREN) function.
   * The private structure can be retrieved using the
   * G_TYPE_INSTANCE_GET_PRIVATE$(LPAREN)$(RPAREN) macro.
   * The following example shows attaching a private structure
   * MyObjectPrivate to an object MyObject defined in the standard
   * GObject fashion in the type's class_init$(LPAREN)$(RPAREN) function.
   * Note the use of a structure member "priv" to avoid the overhead
   * of repeatedly calling MY_OBJECT_GET_PRIVATE$(LPAREN)$(RPAREN).
   * |[<!-- language\="C" -->
   * typedef struct _MyObject        MyObject;
   * typedef struct _MyObjectPrivate MyObjectPrivate;
   * struct _MyObject {
   * GObject parent;
   * MyObjectPrivate *priv;
   * };
   * struct _MyObjectPrivate {
   * int some_field;
   * };
   * static void
   * my_object_class_init $(LPAREN)MyObjectClass *klass$(RPAREN)
   * {
   * g_type_class_add_private $(LPAREN)klass, sizeof $(LPAREN)MyObjectPrivate$(RPAREN)$(RPAREN);
   * }
   * static void
   * my_object_init $(LPAREN)MyObject *my_object$(RPAREN)
   * {
   * my_object->priv \= G_TYPE_INSTANCE_GET_PRIVATE $(LPAREN)my_object,
   * MY_TYPE_OBJECT,
   * MyObjectPrivate$(RPAREN);
   * // my_object->priv->some_field will be automatically initialised to 0
   * }
   * static int
   * my_object_get_some_field $(LPAREN)MyObject *my_object$(RPAREN)
   * {
   * MyObjectPrivate *priv;
   * g_return_val_if_fail $(LPAREN)MY_IS_OBJECT $(LPAREN)my_object$(RPAREN), 0$(RPAREN);
   * priv \= my_object->priv;
   * return priv->some_field;
   * }
   * ]|
   * Params:
   *   privateSize = size of private structure

   * Deprecated: Use the G_ADD_PRIVATE$(LPAREN)$(RPAREN) macro with the `G_DEFINE_*`
   *   family of macros to add instance private data to a type
   */
  void addPrivate(size_t privateSize)
  {
    g_type_class_add_private(cast(GTypeClass*)cPtr, privateSize);
  }

  void* getPrivate(GType privateType)
  {
    void* _retval;
    _retval = g_type_class_get_private(cast(GTypeClass*)cPtr, privateType);
    return _retval;
  }

  /**
   * This is a convenience function often needed in class initializers.
   * It returns the class structure of the immediate parent type of the
   * class passed in.  Since derived classes hold a reference count on
   * their parent classes as long as they are instantiated, the returned
   * class will always exist.
   * This function is essentially equivalent to:
   * g_type_class_peek $(LPAREN)g_type_parent $(LPAREN)G_TYPE_FROM_CLASS $(LPAREN)g_class$(RPAREN)$(RPAREN)$(RPAREN)
   * Returns: the parent class
   *   of g_class
   */
  TypeClass peekParent()
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek_parent(cast(GTypeClass*)cPtr);
    auto _retval = _cretval ? new TypeClass(cast(GTypeClass*)_cretval) : null;
    return _retval;
  }

  static void adjustPrivateOffset(void* gClass, ref int privateSizeOrOffset)
  {
    g_type_class_adjust_private_offset(gClass, cast(int*)&privateSizeOrOffset);
  }

  /**
   * This function is essentially the same as [GObject.TypeClass.ref_],
   * except that the classes reference count isn't incremented.
   * As a consequence, this function may return %NULL if the class
   * of the type passed in does not currently exist $(LPAREN)hasn't been
   * referenced before$(RPAREN).
   * Params:
   *   type = type ID of a classed type
   * Returns: the #GTypeClass
   *   structure for the given type ID or %NULL if the class does not
   *   currently exist
   */
  static TypeClass peek(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek(type);
    auto _retval = _cretval ? new TypeClass(cast(GTypeClass*)_cretval) : null;
    return _retval;
  }

  /**
   * A more efficient version of [GObject.TypeClass.peek] which works only for
   * static types.
   * Params:
   *   type = type ID of a classed type
   * Returns: the #GTypeClass
   *   structure for the given type ID or %NULL if the class does not
   *   currently exist or is dynamically loaded
   */
  static TypeClass peekStatic(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_peek_static(type);
    auto _retval = _cretval ? new TypeClass(cast(GTypeClass*)_cretval) : null;
    return _retval;
  }

  /**
   * Increments the reference count of the class structure belonging to
   * type. This function will demand-create the class if it doesn't
   * exist already.
   * Params:
   *   type = type ID of a classed type
   * Returns: the #GTypeClass
   *   structure for the given type ID
   */
  static TypeClass ref_(GType type)
  {
    GTypeClass* _cretval;
    _cretval = g_type_class_ref(type);
    auto _retval = _cretval ? new TypeClass(cast(GTypeClass*)_cretval) : null;
    return _retval;
  }
}
