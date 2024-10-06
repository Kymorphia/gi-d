module Gtk.BuilderScopeInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The virtual function table to implement for `GtkBuilderScope` implementations.
 * Default implementations for each function do exist, but they usually just fail,
 * so it is suggested that implementations implement all of them.
 */
class BuilderScopeInterface
{
  GtkBuilderScopeInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.BuilderScopeInterface");

    cInstance = *cast(GtkBuilderScopeInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetTypeFromNameFuncType = extern(C) GType function(GtkBuilderScope* self, GtkBuilder* builder, const(char)* typeName);

  @property GetTypeFromNameFuncType getTypeFromName()
  {
    return (cast(GtkBuilderScopeInterface*)cPtr).getTypeFromName;
  }

  alias GetTypeFromFunctionFuncType = extern(C) GType function(GtkBuilderScope* self, GtkBuilder* builder, const(char)* functionName);

  @property GetTypeFromFunctionFuncType getTypeFromFunction()
  {
    return (cast(GtkBuilderScopeInterface*)cPtr).getTypeFromFunction;
  }

  alias CreateClosureFuncType = extern(C) GClosure* function(GtkBuilderScope* self, GtkBuilder* builder, const(char)* functionName, GtkBuilderClosureFlags flags, ObjectC* object, GError** _err);

  @property CreateClosureFuncType createClosure()
  {
    return (cast(GtkBuilderScopeInterface*)cPtr).createClosure;
  }
}
