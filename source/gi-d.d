module gid;

import std.getopt;
import std.stdio : writeln;

import code_writer;
import defs;
import gir.repo;
import std_includes;
import xml_patch;

void main(string[] args)
{
  string[] traps;
  arraySep = ","; // Allow comma separated values for array parameters (traps)

  auto helpInformation = getopt(
    args,
    "dump-ctypes", "Dump all raw C types", &Repo.dumpCTypes,
    "dump-dtypes", "Dump all raw D types", &Repo.dumpDTypes,
    "dump-patches", "Dump XML patch matches", &XmlPatch.dumpSelectorMatches,
    "suggest", "Output definition file command suggestions", &Repo.suggestDefCmds,
    "trap", "Add gdb breakpoint in an output file in the form 'filename:line' (file paths match from the end)", &traps,
  );

  if (helpInformation.helpWanted)
  {
    defaultGetoptPrinter("GObject Introspection Dlang binding generator", helpInformation.options);
    return;
  }

  foreach (tr; traps)
  {
    auto s = tr.split(":");
    CodeWriter.setDebugTrap(s[0], s.length > 1 ? s[1].to!uint : 0);
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
}
