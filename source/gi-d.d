module gid;

import std.experimental.logger;
import std.getopt;
import std.stdio : writeln;

import code_traps;
import code_writer;
import defs;
import gir.repo;
import std_includes;
import xml_patch;

int main(string[] args)
{
  LogLevel logLevel = LogLevel.warning;
  string[] traps;
  arraySep = ","; // Allow comma separated values for array parameters (traps)

  try
  {
    auto helpInformation = getopt(
        args,
        "dump-ctypes", "Dump all raw C types", &Repo.dumpCTypes,
        "dump-dtypes", "Dump all raw D types", &Repo.dumpDTypes,
        "dump-patches", "Dump XML patch matches", &XmlPatch.dumpSelectorMatches,
        "dump-traps", "Dump code trap actions", &codeTrapsDump,
        "log-level", "Log level (" ~ [EnumMembers!LogLevel].map!(x => x.to!string)
        .join(", ") ~ ")", &logLevel,
        "suggest", "Output definition file command suggestions", &Repo.suggestDefCmds,
        "trap", "Add gdb breakpoint 'action:regex', action: domain (help to list), regex: pattern to match", &traps,
    );

    if (helpInformation.helpWanted)
    {
      defaultGetoptPrinter("GObject Introspection Dlang binding generator", helpInformation.options);
      return 0;
    }
  }
  catch (Exception e)
  {
    error(e.msg);
    return 1;
  }

  globalLogLevel(logLevel);

  foreach (tr; traps)
  {
    auto s = tr.split(":");

    try
      addCodeTrap(s[0], s[1]);
    catch (RangeError)
    {
      error("Invalid action:regex code trap");
      return 1;
    }
    catch (Exception e)
    {
      error("Invalid regex match: ", e.msg);
      return 1;
    }
  }

  auto defs = new Defs();
  defs.loadDefFiles();
  defs.loadRepos();
  defs.writePackages();

  defs.repos.sort!((a, b) => a.namespace < b.namespace);

  if (Repo.dumpCTypes)
  {
    bool[dstring] cTypes;

    foreach (repo; defs.repos)
      foreach (typeName; repo.cTypeHash.keys)
        cTypes[typeName] = true;

    writeln(cTypes.keys.array.sort.join("\n"));
  }

  if (Repo.dumpDTypes)
  {
    bool[dstring] dTypes;

    foreach (repo; defs.repos)
    {
      foreach (typeName; repo.dTypeHash.keys)
      {
        auto kind = defs.typeKind(typeName, repo);

        if (kind != TypeKind.Basic)
          typeName = repo.namespace ~ "." ~ typeName;

        dTypes[typeName ~ "," ~ kind.to!dstring] = true;
      }
    }

    writeln(dTypes.keys.array.sort.join("\n"));
  }

  return 0;
}
