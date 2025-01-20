module GLib.MemChunk;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

class MemChunk
{
  GMemChunk* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.MemChunk");

    cInstancePtr = cast(GMemChunk*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  void* alloc()
  {
    void* _retval;
    _retval = g_mem_chunk_alloc(cast(GMemChunk*)cPtr);
    return _retval;
  }

  void* alloc0()
  {
    void* _retval;
    _retval = g_mem_chunk_alloc0(cast(GMemChunk*)cPtr);
    return _retval;
  }

  void clean()
  {
    g_mem_chunk_clean(cast(GMemChunk*)cPtr);
  }

  void destroy()
  {
    g_mem_chunk_destroy(cast(GMemChunk*)cPtr);
  }

  void print()
  {
    g_mem_chunk_print(cast(GMemChunk*)cPtr);
  }

  void reset()
  {
    g_mem_chunk_reset(cast(GMemChunk*)cPtr);
  }

  static void info()
  {
    g_mem_chunk_info();
  }
}
