module gid;

import std.algorithm : sort;
import std.file : readText;
import std.getopt;
import std.stdio : writeln;

import definitions;
import gir.repo;
import xml_tree;

void main(string[] args)
{
  auto defs = new Definitions();
  defs.loadDefFiles();

  auto tree = new XmlTree();
  tree.parse(readText(args[1]), args[1]);

  auto repo = new Repo(defs, tree);

  repo.writePackage();

  /*
	bool[dstring] nodeNames;

	void recurseTree(XmlNode node)
	{
		nodeNames[node.name] = true;

		foreach (child; node.children)
		  recurseTree(child);
	}

	recurseTree(tree.root);

	foreach (name; nodeNames.keys.sort)
		writeln("case \"", name, "\":");
*/
}
