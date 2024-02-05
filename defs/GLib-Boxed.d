/// Class wrapper for boxed types
abstract class Boxed
{
  void* boxPtr; /// Pointer to the C boxed value

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

    this.boxPtr = owned ? boxPtr : g_boxed_copy(getType, boxPtr);
  }

  /**
    * Constructor for duplicating a wrapped boxed type value.
    */
  this(Boxed boxed)
  {
    this(boxed.boxPtr, false);
  }

  ~this()
  {
    g_boxed_free(getType, boxPtr);
  }

  /**
    * Get the GType of this boxed type.
    * Returns: The GObject GType
    */
  GType getType();
