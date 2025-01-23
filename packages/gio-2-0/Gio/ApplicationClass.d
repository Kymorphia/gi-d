module Gio.ApplicationClass;

import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Virtual function table for #GApplication.
 */
class ApplicationClass
{
  GApplicationClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ApplicationClass");

    cInstance = *cast(GApplicationClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias StartupFuncType = extern(C) void function(GApplication* application);

  @property StartupFuncType startup()
  {
    return (cast(GApplicationClass*)cPtr).startup;
  }

  alias ActivateFuncType = extern(C) void function(GApplication* application);

  @property ActivateFuncType activate()
  {
    return (cast(GApplicationClass*)cPtr).activate;
  }

  alias OpenFuncType = extern(C) void function(GApplication* application, GFile** files, int nFiles, const(char)* hint);

  @property OpenFuncType open()
  {
    return (cast(GApplicationClass*)cPtr).open;
  }

  alias CommandLineFuncType = extern(C) int function(GApplication* application, GApplicationCommandLine* commandLine);

  @property CommandLineFuncType commandLine()
  {
    return (cast(GApplicationClass*)cPtr).commandLine;
  }

  alias LocalCommandLineFuncType = extern(C) bool function(GApplication* application, char*** arguments, int* exitStatus);

  @property LocalCommandLineFuncType localCommandLine()
  {
    return (cast(GApplicationClass*)cPtr).localCommandLine;
  }

  alias BeforeEmitFuncType = extern(C) void function(GApplication* application, VariantC* platformData);

  @property BeforeEmitFuncType beforeEmit()
  {
    return (cast(GApplicationClass*)cPtr).beforeEmit;
  }

  alias AfterEmitFuncType = extern(C) void function(GApplication* application, VariantC* platformData);

  @property AfterEmitFuncType afterEmit()
  {
    return (cast(GApplicationClass*)cPtr).afterEmit;
  }

  alias AddPlatformDataFuncType = extern(C) void function(GApplication* application, GVariantBuilder* builder);

  @property AddPlatformDataFuncType addPlatformData()
  {
    return (cast(GApplicationClass*)cPtr).addPlatformData;
  }

  alias QuitMainloopFuncType = extern(C) void function(GApplication* application);

  @property QuitMainloopFuncType quitMainloop()
  {
    return (cast(GApplicationClass*)cPtr).quitMainloop;
  }

  alias RunMainloopFuncType = extern(C) void function(GApplication* application);

  @property RunMainloopFuncType runMainloop()
  {
    return (cast(GApplicationClass*)cPtr).runMainloop;
  }

  alias ShutdownFuncType = extern(C) void function(GApplication* application);

  @property ShutdownFuncType shutdown()
  {
    return (cast(GApplicationClass*)cPtr).shutdown;
  }

  alias DbusRegisterFuncType = extern(C) bool function(GApplication* application, GDBusConnection* connection, const(char)* objectPath, GError** _err);

  @property DbusRegisterFuncType dbusRegister()
  {
    return (cast(GApplicationClass*)cPtr).dbusRegister;
  }

  alias DbusUnregisterFuncType = extern(C) void function(GApplication* application, GDBusConnection* connection, const(char)* objectPath);

  @property DbusUnregisterFuncType dbusUnregister()
  {
    return (cast(GApplicationClass*)cPtr).dbusUnregister;
  }

  alias HandleLocalOptionsFuncType = extern(C) int function(GApplication* application, GVariantDict* options);

  @property HandleLocalOptionsFuncType handleLocalOptions()
  {
    return (cast(GApplicationClass*)cPtr).handleLocalOptions;
  }

  alias NameLostFuncType = extern(C) bool function(GApplication* application);

  @property NameLostFuncType nameLost()
  {
    return (cast(GApplicationClass*)cPtr).nameLost;
  }
}
