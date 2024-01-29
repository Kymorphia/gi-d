import core.memory;
import glib.c.functions;
import glib.GLib;
import glib.GObject;

private immutable Quark gidObjectQuark;

shared static this()
{
  dObjQuark = GLib.quark_from_string("_gidObject");
}

/// Base class wrapper for GObject types
abstract class ObjectG
{
  private void* cptr; // Pointer to wrapped C GObject

  /**
    * Constructor to wrap a C GObject with a D proxy object.
    * Params:
    *   cptr = Pointer to the GObject
    *   owned = true if the D object should take ownership of the passed reference, false to add a new reference
    */
  this(void* cptr, bool owned)
  {
    this.cptr = cptr;

    // Add a data pointer to the D object from the C GObject
    g_object_set_qdata (cptr, gidObjectQuark, cast(void*)this);

    // Add a toggle reference to bind the GObject to this proxy D Object to prevent the GObject from being destroyed, while also preventing ref loops.
    g_add_toggle_ref(cptr, _cObjToggleNotify, cast(void*)this);

    // Add D object as a root to garbage collector so that it doesn't get collected as long as the GObject has a strong reference on it (toggle ref + 1 or more other refs).
    // There will always be at least 2 references at this point, one from the caller and one for the toggle ref.
    GC.addRoot(this);

    // If object has a floating reference (GInitiallyOwned), take ownership of it
    if (g_object_is_floating(cptr))
      g_object_ref_sink(cptr);

    // If taking ownership of the object, remove the extra reference. May trigger toggle notify if it is the last remaining ref,
    // which will call GC.removeRoot() allowing the D object to be garbage collected if it is no longer being accessed, resulting in the destruction of the GObject in dtor.
    if (owned)
      g_object_unref(cptr);
  }

  ~this()
  { // D object is being garbage collected. Only happens when there is only the toggle reference on GObject and there are no more pointers to the D proxy object.
    g_remove_toggle_ref(cptr); // Remove the toggle reference, which will likely lead to the destruction of the GObject
    cptr = null;
  }

  extern(C)
  { // Toggle ref callback
    void _cObjToggleNotify(void *dObj, GObject* gObj, gboolean isLastRef)
    {
      if (isLastRef) // Is the toggle reference the only reference?
        GC.removeRoot(dObj);
      else // Toggle reference was the last reference, but now there is an additional one
        GC.addRoot(dObj);
    }
  }

  GType getType();

  /**
    * Get the GObject wrapped by the D object.
    * Returns: GObject (no reference is added for caller)
    */
  GObject* getGObject()
  {
    return cast(GObject*)cptr;
  }

  /**
    * Template to get the D object from a C GObject and cast it to the given D object type.
    * Params:
    *   T = The D object type
    *   cptr = The C GObject
    *   owned = If true then the D object will take ownership of the GObject reference.
    * Returns: The D object (which may be a new object if the GObject wasn't already wrapped)
    */
  static T getDObject(T)(void* cptr, bool owned)
  {
    if (auto dObj = g_object_get_qdata(cptr, gidObjectQuark))
      return cast(T)dObj;
    else
      return new T(cptr, owned);
  }
}
