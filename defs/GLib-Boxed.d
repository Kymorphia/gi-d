import GLib.Boxed;

/// Class wrapper for boxed types
abstract class Boxed
{
  void* cInstancePtr; /// Pointer to the C boxed value

  /**
    * Constructor for wrapping a GObject boxed value
    * Params:
    *   boxPtr = The pointer to the boxed type instance
    *   owned = true if ownership of pointer should be taken by the D object, false to do a box copy of it
    */
  this(void* boxPtr, bool owned)
  {
    if (!boxPtr)
      throw new GidConstructException("Null instance pointer for " ~ typeid(this).name);

    this.cInstancePtr = owned ? boxPtr : glib_g_boxed_copy(getType, boxPtr);
  }

  /**
    * Constructor for duplicating a wrapped boxed type value.
    */
  this(Boxed boxed)
  {
    this(boxed.cInstancePtr, false);
  }

  ~this()
  {
    if (cInstancePtr) // Might be null if an exception occurred during construction
      glib_g_boxed_free(getType, cInstancePtr);
  }

  /**
    * Get the GType of this boxed type.
    * Returns: The GObject GType
    */
  GType getType()
  {
    return cast(GType)0; // Gets overridden by derived boxed types
  }
}

T containerGetItem(T, CT)(void* data)
  if (is(T : Boxed))
{
  return new T(cast(CT)data, ownership == GidOwnership.Full);
}

void* containerCopyItem(T, CT)(void* data)
  if (is(T : Boxed))
{
  return glib_g_boxed_copy(T.getType, data);
}

void containerFreeItem(T, CT)(void* data)
  if (is(T : Boxed))
{
  glib_g_boxed_free(T.getType, data);
}

// GLib binding also depends on libgobject for boxed functions
// Resolve the symbols here to avoid circular dependency between GLib and GObject bindings

void* function(GType boxedType, const(void)* srcBoxed) glib_g_boxed_copy;
void function(GType boxedType, void* boxed) glib_g_boxed_free;

static this()
{
  link(glib_g_boxed_copy, "g_boxed_copy");
  link(glib_g_boxed_free, "g_boxed_free");
}

version(Windows)
  private immutable LIBS = ["libgobject-2.0-0.dll;gobject-2.0-0.dll;gobject-2.dll"];
version(OSX)
  private immutable LIBS = ["libgobject-2.0.0.dylib"];
else
  private immutable LIBS = ["libgobject-2.0.so.0"];

private void link(T)(ref T funcPtr, string symbol)
{
  import core.sys.posix.dlfcn : dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
  import std.string : fromStringz, toStringz;

  foreach (lib; LIBS)
  {
    if (auto handle = dlopen(cast(char*)toStringz(lib), RTLD_GLOBAL | RTLD_NOW))
    {
      if (auto symPtr = dlsym(handle, cast(char*)toStringz(symbol)))
      {
        funcPtr = cast(T)symPtr;
        return;
    }
    }
    else
      throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  funcPtr = cast(T)&symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
