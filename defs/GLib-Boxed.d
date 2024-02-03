/// Class wrapper for boxed types
abstract class Boxed
{
  private void* cptr; /// Pointer to the C boxed value

  /**
    * Constructor for wrapping a GObject boxed value
    * Params:
    *   cptr = The pointer to the boxed type instance
    *   owned = true if ownership of pointer should be taken by the D object, false to do a box copy of it
    */
  this(void* cptr, bool owned)
  {
    if (!cptr)
      throw new GidConstructException("Null instance pointer for " ~ typeid(this).name);

    this.cptr = owned ? cptr : g_boxed_copy(getType, boxed.cptr);
  }

  /**
    * Constructor for duplicating a wrapped boxed type value.
    */
  this(Boxed boxed)
  {
    this(boxed.cptr, false);
  }

  ~this()
  {
    g_boxed_free(getType, cptr);
  }

  /**
    * Get the GType of this boxed type.
    * Returns: The GObject GType
    */
  GType getType();
