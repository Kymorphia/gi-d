//!generate funcs
import core.memory;
import GLib.global;
import GLib.c.functions;

private immutable Quark gidObjectQuark;

shared static this()
{
  gidObjectQuark = g_quark_from_string("_gidObject");
}

/// Base class wrapper for GObject types
class ObjectG
{
  protected ObjectC* cInstancePtr; // Pointer to wrapped C GObject

  /**
    * Constructor to wrap a C GObject with a D proxy object.
    * Params:
    *   cptr = Pointer to the GObject
    *   owned = true if the D object should take ownership of the passed reference, false to add a new reference
    */
  this(void* cObj, bool owned)
  {
    if (!cObj)
      throw new GidConstructException("Null instance pointer for " ~ typeid(this).name);

    cInstancePtr = cast(ObjectC*)cObj;

    // Add a data pointer to the D object from the C GObject
    g_object_set_qdata(cInstancePtr, gidObjectQuark, cast(void*)this);

    // Add a toggle reference to bind the GObject to this proxy D Object to prevent the GObject from being destroyed, while also preventing ref loops.
    g_object_add_toggle_ref(cInstancePtr, &_cObjToggleNotify, cast(void*)this);

    // Add D object as a root to garbage collector so that it doesn't get collected as long as the GObject has a strong reference on it (toggle ref + 1 or more other refs).
    // There will always be at least 2 references at this point, one from the caller and one for the toggle ref.
    GC.addRoot(cast(void*)this);

    // If object has a floating reference (GInitiallyOwned), take ownership of it
    if (g_object_is_floating(cInstancePtr))
      g_object_ref_sink(cInstancePtr);

    // If taking ownership of the object, remove the extra reference. May trigger toggle notify if it is the last remaining ref,
    // which will call GC.removeRoot() allowing the D object to be garbage collected if it is no longer being accessed, resulting in the destruction of the GObject in dtor.
    if (owned)
      g_object_unref(cInstancePtr);
  }

  ~this()
  { // D object is being garbage collected. Only happens when there is only the toggle reference on GObject and there are no more pointers to the D proxy object.
    if (cInstancePtr) // Might be null if an exception occurred during construction
      g_object_remove_toggle_ref(cInstancePtr, &_cObjToggleNotify, cast(void*)this); // Remove the toggle reference, which will likely lead to the destruction of the GObject
  }

  extern(C)
  { // Toggle ref callback
    static void _cObjToggleNotify(void *dObj, ObjectC* gObj, bool isLastRef)
    {
      if (isLastRef) // Is the toggle reference the only reference?
        GC.removeRoot(dObj);
      else // Toggle reference was the last reference, but now there is an additional one
        GC.addRoot(dObj);
    }
  }

  /**
   * Get a pointer to the underlying C object.
   * Params:
   *   T = The type of C object to get (must be a valid C type for the D object or one of it's ancestors)
   * Returns: The C object (no reference is added)
   */
  T* cPtr(T)()
    if (is(T : ObjectC))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Get the GType of an object.
   * Returns: The GType
   */
  GType getType()
  {
    return g_object_get_type();
  }

  /**
    * Template to get the D object from a C GObject and cast it to the given D object type.
    * Params:
    *   T = The D object type
    *   cptr = The C GObject
    *   owned = If true then the D object will take ownership of the GObject reference (false by default).
    * Returns: The D object (which may be a new object if the GObject wasn't already wrapped)
    */
  static T getDObject(T)(void* cptr, bool owned = false)
  {
    if (auto dObj = g_object_get_qdata(cast(ObjectC*)cptr, gidObjectQuark))
      return cast(T)dObj;

    static if (!is(T == interface))
      return new T(cptr, owned);
    else
      return null; // FIXME - Need to handle returning an object instance for an interface
  }
}

T containerGetItem(T, CT)(void* data)
  if (is(T : ObjectG) || is(T == interface))
{
  return new T(cast(CT)data, ownership == GidOwnership.Full);
}

void* containerCopyItem(T, CT)(void* data)
  if (is(T : ObjectG) || is(T == interface))
{
  return data ? g_object_ref(data) : null;
}

void containerFreeItem(T, CT)(void* data)
  if (is(T : ObjectG) || is(T == interface))
{
  T.free(cast(CT)data);
}
