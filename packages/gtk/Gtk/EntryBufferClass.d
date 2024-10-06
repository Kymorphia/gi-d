module Gtk.EntryBufferClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class EntryBufferClass
{
  GtkEntryBufferClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.EntryBufferClass");

    cInstance = *cast(GtkEntryBufferClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkEntryBufferClass*)cPtr).parentClass);
  }

  alias InsertedTextFuncType = extern(C) void function(GtkEntryBuffer* buffer, uint position, const(char)* chars, uint nChars);

  @property InsertedTextFuncType insertedText()
  {
    return (cast(GtkEntryBufferClass*)cPtr).insertedText;
  }

  alias DeletedTextFuncType = extern(C) void function(GtkEntryBuffer* buffer, uint position, uint nChars);

  @property DeletedTextFuncType deletedText()
  {
    return (cast(GtkEntryBufferClass*)cPtr).deletedText;
  }

  alias GetTextFuncType = extern(C) const(char)* function(GtkEntryBuffer* buffer, size_t* nBytes);

  @property GetTextFuncType getText()
  {
    return (cast(GtkEntryBufferClass*)cPtr).getText;
  }

  alias GetLengthFuncType = extern(C) uint function(GtkEntryBuffer* buffer);

  @property GetLengthFuncType getLength()
  {
    return (cast(GtkEntryBufferClass*)cPtr).getLength;
  }

  alias InsertTextFuncType = extern(C) uint function(GtkEntryBuffer* buffer, uint position, const(char)* chars, uint nChars);

  @property InsertTextFuncType insertText()
  {
    return (cast(GtkEntryBufferClass*)cPtr).insertText;
  }

  alias DeleteTextFuncType = extern(C) uint function(GtkEntryBuffer* buffer, uint position, uint nChars);

  @property DeleteTextFuncType deleteText()
  {
    return (cast(GtkEntryBufferClass*)cPtr).deleteText;
  }
}
