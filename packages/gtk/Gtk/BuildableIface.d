module Gtk.BuildableIface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkBuildableIface` interface contains methods that are
 * necessary to allow `GtkBuilder` to construct an object from
 * a `GtkBuilder` UI definition.
 */
class BuildableIface
{
  GtkBuildableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.BuildableIface");

    cInstance = *cast(GtkBuildableIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkBuildableIface*)cPtr).gIface);
  }

  alias SetIdFuncType = extern(C) void function(GtkBuildable* buildable, const(char)* id);

  @property SetIdFuncType setId()
  {
    return (cast(GtkBuildableIface*)cPtr).setId;
  }

  alias GetIdFuncType = extern(C) const(char)* function(GtkBuildable* buildable);

  @property GetIdFuncType getId()
  {
    return (cast(GtkBuildableIface*)cPtr).getId;
  }

  alias AddChildFuncType = extern(C) void function(GtkBuildable* buildable, GtkBuilder* builder, ObjectC* child, const(char)* type);

  @property AddChildFuncType addChild()
  {
    return (cast(GtkBuildableIface*)cPtr).addChild;
  }

  alias SetBuildablePropertyFuncType = extern(C) void function(GtkBuildable* buildable, GtkBuilder* builder, const(char)* name, const(GValue)* value);

  @property SetBuildablePropertyFuncType setBuildableProperty()
  {
    return (cast(GtkBuildableIface*)cPtr).setBuildableProperty;
  }

  alias CustomTagStartFuncType = extern(C) bool function(GtkBuildable* buildable, GtkBuilder* builder, ObjectC* child, const(char)* tagname, GtkBuildableParser* parser, void** data);

  @property CustomTagStartFuncType customTagStart()
  {
    return (cast(GtkBuildableIface*)cPtr).customTagStart;
  }

  alias CustomTagEndFuncType = extern(C) void function(GtkBuildable* buildable, GtkBuilder* builder, ObjectC* child, const(char)* tagname, void* data);

  @property CustomTagEndFuncType customTagEnd()
  {
    return (cast(GtkBuildableIface*)cPtr).customTagEnd;
  }

  alias CustomFinishedFuncType = extern(C) void function(GtkBuildable* buildable, GtkBuilder* builder, ObjectC* child, const(char)* tagname, void* data);

  @property CustomFinishedFuncType customFinished()
  {
    return (cast(GtkBuildableIface*)cPtr).customFinished;
  }

  alias ParserFinishedFuncType = extern(C) void function(GtkBuildable* buildable, GtkBuilder* builder);

  @property ParserFinishedFuncType parserFinished()
  {
    return (cast(GtkBuildableIface*)cPtr).parserFinished;
  }

  alias GetInternalChildFuncType = extern(C) ObjectC* function(GtkBuildable* buildable, GtkBuilder* builder, const(char)* childname);

  @property GetInternalChildFuncType getInternalChild()
  {
    return (cast(GtkBuildableIface*)cPtr).getInternalChild;
  }
}
