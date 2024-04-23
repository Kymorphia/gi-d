module Gio.ApplicationClass;

import GLib.Types;
import GLib.Variant;
import GLib.VariantBuilder;
import GLib.VariantDict;
import GLib.c.functions;
import Gid.Gid;
import Gio.Application;
import Gio.ApplicationCommandLine;
import Gio.DBusConnection;
import Gio.File;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GApplicationClass))
  {
    return cast(T*)&cInstance;
  }

  alias StartupFuncType = extern(C) void function(GApplication* application);

  @property StartupFuncType startup()
  {
    return cPtr!GApplicationClass.startup;
  }

  alias ActivateFuncType = extern(C) void function(GApplication* application);

  @property ActivateFuncType activate()
  {
    return cPtr!GApplicationClass.activate;
  }

  alias OpenFuncType = extern(C) void function(GApplication* application, GFile** files, int nFiles, const(char)* hint);

  @property OpenFuncType open()
  {
    return cPtr!GApplicationClass.open;
  }

  alias CommandLineFuncType = extern(C) int function(GApplication* application, GApplicationCommandLine* commandLine);

  @property CommandLineFuncType commandLine()
  {
    return cPtr!GApplicationClass.commandLine;
  }

  alias LocalCommandLineFuncType = extern(C) bool function(GApplication* application, char*** arguments, int* exitStatus);

  @property LocalCommandLineFuncType localCommandLine()
  {
    return cPtr!GApplicationClass.localCommandLine;
  }

  alias BeforeEmitFuncType = extern(C) void function(GApplication* application, GVariant* platformData);

  @property BeforeEmitFuncType beforeEmit()
  {
    return cPtr!GApplicationClass.beforeEmit;
  }

  alias AfterEmitFuncType = extern(C) void function(GApplication* application, GVariant* platformData);

  @property AfterEmitFuncType afterEmit()
  {
    return cPtr!GApplicationClass.afterEmit;
  }

  alias AddPlatformDataFuncType = extern(C) void function(GApplication* application, GVariantBuilder* builder);

  @property AddPlatformDataFuncType addPlatformData()
  {
    return cPtr!GApplicationClass.addPlatformData;
  }

  alias QuitMainloopFuncType = extern(C) void function(GApplication* application);

  @property QuitMainloopFuncType quitMainloop()
  {
    return cPtr!GApplicationClass.quitMainloop;
  }

  alias RunMainloopFuncType = extern(C) void function(GApplication* application);

  @property RunMainloopFuncType runMainloop()
  {
    return cPtr!GApplicationClass.runMainloop;
  }

  alias ShutdownFuncType = extern(C) void function(GApplication* application);

  @property ShutdownFuncType shutdown()
  {
    return cPtr!GApplicationClass.shutdown;
  }

  alias DbusRegisterFuncType = extern(C) bool function(GApplication* application, GDBusConnection* connection, const(char)* objectPath, GError** _err);

  @property DbusRegisterFuncType dbusRegister()
  {
    return cPtr!GApplicationClass.dbusRegister;
  }

  alias DbusUnregisterFuncType = extern(C) void function(GApplication* application, GDBusConnection* connection, const(char)* objectPath);

  @property DbusUnregisterFuncType dbusUnregister()
  {
    return cPtr!GApplicationClass.dbusUnregister;
  }

  alias HandleLocalOptionsFuncType = extern(C) int function(GApplication* application, GVariantDict* options);

  @property HandleLocalOptionsFuncType handleLocalOptions()
  {
    return cPtr!GApplicationClass.handleLocalOptions;
  }

  alias NameLostFuncType = extern(C) bool function(GApplication* application);

  @property NameLostFuncType nameLost()
  {
    return cPtr!GApplicationClass.nameLost;
  }
}
