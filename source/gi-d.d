module gid;

import std.getopt;
import std.stdio : writeln;

import defs;

void main(string[] args)
{
  auto defs = new Defs();
  defs.loadDefFiles();
	defs.loadRepos();
	defs.writePackages();
}
