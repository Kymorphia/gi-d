module gid;

import std.file : readText;
import std.getopt;
import std.stdio : writeln;

import xmltree;

void main(string[] args)
{
  auto tree = new XmlTree();
	string data = readText(args[1]);

  try
	{
		tree.parse(data);
	}
	catch (XmlParseError e)
	{
		writeln(e);
		throw e;
	}

	void recurseXmlTree(XmlNode node, dstring indent="")
	{
		dstring s = indent ~ node.name ~ ":";

		foreach (atName; node.attrs.keys)
			s ~= " " ~ atName ~ "=" ~ node.attrs[atName];

		writeln(s);

		foreach (child; node.children)
			recurseXmlTree(child, indent ~ "  ");

		writeln(indent ~ "/" ~ node.name);
	}

	recurseXmlTree(tree.root);
}
