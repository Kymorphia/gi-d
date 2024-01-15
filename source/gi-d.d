module gid;

import std.algorithm : sort;
import std.file : readText;
import std.getopt;
import std.stdio : writeln;

import gir.repo;
import xml_tree;

void main(string[] args)
{
  auto tree = new XmlTree();
  string data = readText(args[1]);
  tree.parse(data, args[1]);

  auto repo = new Repo(tree);

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
