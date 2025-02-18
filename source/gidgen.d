module gidgen;

import std.experimental.logger;
import std.getopt;
import std.path : absolutePath, asNormalizedPath;
import std.stdio : writeln;

import code_traps;
import code_writer;
import defs;
import gir.enumeration;
import gir.func;
import gir.report;
import gir.type_node;
import std_includes;
import xml_patch;

int main(string[] args)
{
  LogLevel logLevel = LogLevel.warning;
  string[] traps;
  arraySep = ","; // Allow comma separated values for array parameters (traps)
  string[] defPaths;
  string[] girPaths;
  string pkgPath;
  string subPkgPath;
  bool defHelp;
  bool dumpKinds;
  bool enableReport;
  string reportFile;
  string reportOptions = "AllUnsupported";

  try
  {
    auto helpInformation = getopt(
        args,
        "d|defs", "Add a path to a directory of binding definition files or a single file (one or more required)", &defPaths,
        "g|gir-path", "Add a path to search for GIR files (one or more required)", &girPaths,
        "p|pkg-path", "Top-level package binding output path (required)", &pkgPath,
        "s|subpkg-path", "Subpackage path to write individual library packages to (required)", &subPkgPath,
        "def-help", "Display binding definition file command help", &defHelp,
        "log-level", "Log level (" ~ [EnumMembers!LogLevel].map!(x => x.to!string).join(", ") ~ ")", &logLevel,
        "log-gir-locs", "Log GIR file locations in warnings", &Repo.logGirLoc,
        "log-code-locs", "Log code locations in warnings", &Repo.logCodeLoc,
        "report", "Output binding coverage statistics (defaults to --report-options AllUnsupported)", &enableReport,
        "report-file", "File to output report to (defaults to stdout if not specified)", &reportFile,
        "report-options", "Customize report output (logically OR'd flags with '|' character, 'help' for flag list)", &reportOptions,
        "suggest", "Output definition file command suggestions", &Repo.suggestDefCmds,
        "dump-selectors", "Dump XML selectors for warnings", &TypeNode.dumpSelectorWarnings,
        "dump-ctypes", "Dump all raw C types", &Repo.dumpCTypes,
        "dump-dtypes", "Dump all raw D types", &Repo.dumpDTypes,
        "dump-kinds", "Dump the list of type kinds", &dumpKinds,
        "dump-matches", "Dump XML patch selector matches", &XmlPatch.dumpSelectorMatches,
        "dump-traps", "Dump code trap actions", &codeTrapsDump,
        "trap", "Add gdb breakpoint 'action:regex', action: domain (help to list), regex: pattern to match", &traps,
    );

    if (helpInformation.helpWanted)
    {
      defaultGetoptPrinter("GObject Introspection Dlang binding generator", helpInformation.options);
      return 0;
    }

    if (defHelp)
    {
      displayDefHelp;
      return 0;
    }

    if (dumpKinds)
    {
      writeln("Type kinds: " ~ [EnumMembers!TypeKind].map!(x => x.to!string).join(", "));
      return 0;
    }

    if (reportOptions == "help")
    {
      displayReportOptionsHelp;
      return 0;
    }
  }
  catch (Exception e)
  {
    error(e.msg);
    return 1;
  }

  if (girPaths.empty)
  {
    error("At least one --gir-path (-g) option is required");
    return 1;
  }

  if (!pkgPath)
  {
    error("A package output path must be specified with --pkg-path (-p)");
    return 1;
  }

  if (!subPkgPath)
  {
    error("A sub-package output path must be specified with --subpkg-path (-s)");
    return 1;
  }

  pkgPath = absolutePath(pkgPath).asNormalizedPath.array;
  subPkgPath = absolutePath(subPkgPath).asNormalizedPath.array;

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

  ReportFlags reportFlags;

  if (enableReport)
  {
    try
      reportFlags = processReportOptions(reportOptions);
    catch (ConvException e)
    {
      error("Invalid --report-options value '" ~ reportOptions ~ "': ", e.message);
      return 1;
    }
  }

  auto defs = new Defs();
  defs.loadDefFiles(defPaths);
  defs.loadRepos(girPaths);
  defs.writePackages(pkgPath, subPkgPath);

  defs.repos.sort!((a, b) => a.namespace < b.namespace);

  dstring cTypeAndKind(Base baseObj)
  {
    if (auto fn = cast(Func)baseObj)
      return fn.repo.namespace ~ "." ~ fn.cName ~ " " ~ fn.kind.to!dstring;
    else if (auto typeNode = cast(TypeNode)baseObj)
      return typeNode.repo.namespace ~ "." ~ (typeNode.cType.empty ? typeNode.name : typeNode.cType) ~ " "
        ~ typeNode.kind.to!dstring;
    else
      return baseObj.fullName ~ " Unknown";
  }

  if (Repo.dumpCTypes)
    writeln(defs.repos.map!(repo => repo.typeObjectHash.values)
      .join.map!(baseObj => cTypeAndKind(baseObj))
      .array.sort.uniq.join("\n"));

  if (Repo.dumpDTypes)
    writeln(defs.repos.map!(repo => repo.typeObjectHash.values)
      .join.map!(typeNode => typeNode.fullName ~ " " ~ typeNode.kind.to!dstring)
      .array.sort.uniq.join("\n"));

  if (Repo.suggestDefCmds) // Display suggestions if enabled
  {
    writeln("\nDefinition suggestions:");

    foreach (repo; defs.repos)
    {
      if (!repo.suggestions.empty)
        writeln("\nFile: " ~ repo.defsFilename);

      foreach (suggTopic, suggList; repo.suggestions)
      {
        writeln("\n//# " ~ suggTopic ~ "");

        foreach (sugg; suggList)
          writeln("//!" ~ sugg ~ "");
      }
    }
  }

  if (enableReport)
  {
    auto report = new Report(defs);
    auto reportStr = report.generate(reportFlags);

    if (reportFile)
    {
      import std.file : write;
      write(reportFile, reportStr);
    }
    else
      writeln(reportStr);
  }

  return 0;
}
