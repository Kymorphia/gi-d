module gir.repo;

import std.conv : to;
import std.stdio : stderr;

import gir.alias_;
import gir.base;
import gir.constant;
import gir.enumeration;
import gir.field;
import gir.func;
import gir.member;
import gir.param;
import gir.property;
import gir.structure;
import xml_tree;

/// Gir repository
final class Repo
{
  this()
  {
  }

  this(XmlTree tree)
  {
    fromXml(tree);
  }

  /// Convert an XML object tree to a Gir object tree
  void fromXml(XmlTree tree)
  {
    void recurseXml(XmlNode node)
    {
      switch (node.name)
      {
        case "alias": // Alias info
          aliases ~= new Alias(node);
          break;
        case "array": // Array type info
          break; // Do nothing, TypeNode handles this
        case "attribute": // FIXME - Freeform attributes, but for which nodes?
          break;
        case "bitfield", "enumeration":
          enums ~= new Enumeration(node);
          break;
        case "c:include":
          cIncludes ~= node["name"];
          break;
        case "callback", "constructor", "function", "function-macro",
        "glib:signal", "method", "virtual-method":
          functions ~= new Func(node);
          break;
        case "class", "interface", "record":
          structures ~= new Structure(node);
          break;
        case "constant":
          constants ~= new Constant(node);
          break;
        case "doc": // Documentation file position
          if (auto base = baseParentFromXmlNodeWarn!Base(node))
          {
            base.doc = node.content;
            base.docFilename = node.get("filename");
            base.docLine = node.get("line").to!uint;
          }
          break; // Do nothing, handled by individual objects
        case "doc-deprecated": // Deprecated note
          if (auto base = node.baseParentFromXmlNodeWarn!Base)
            base.docDeprecated = node.content;
          break;
        case "docsection": // Documentation section
          docSections ~= new DocSection(node);
          break;
        case "field": // Field 
          if (auto st = node.baseParentFromXmlNodeWarn!Structure)
            st.fields ~= new Field(node);
          break;
        case "glib:boxed":
          break; // Silently ignore this seldom used node (only TreeRowData seen so far)
        case "implements":
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            if (auto name = node.get("name"))
              cl.implements ~= name;
          break;
        case "include":
          includes ~= Include(node["name"], node["version"]);
          break;
        case "member": // Enumeration or bitfield member
          if (auto en = node.baseParentFromXmlNodeWarn!Enumeration)
            en.members ~= new Member(node);
          break;
        case "namespace":
          namespace = node["name"];
          sharedLibrary = node.get("shared-library");
          nsVersion = node.get("version");
          identifierPrefixes = node.get("c:identifier-prefixes");
          symbolPrefixes = node.get("c:symbol-prefixes");
          break;
        case "package":
          packageName = node.get("name");
          break;
        case "parameter", "instance-parameter":
          if (node.parent)
          {
            if (auto fn = node.parent.baseParentFromXmlNodeWarn!Func)
              fn.params ~= new Param(node);
          }
          else
            node.warn("Expected node to have a parent");
          break;
        case "parameters": // Node which contains parameters
          break; // Do nothing, parameters are individually processed
        case "prerequisite": // Interface object prerequisite
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            if (auto name = node.get("name"))
              cl.prerequisites ~= name;
          break;
        case "property": // Class or interface property
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            cl.properties ~= new Property(node);
          break;
        case "repository":
          repoVersion = node.get("version");
          xmlns = node.get("xmlns");
          xmlnsC = node.get("xmlns:c");
          xmlnsGlib = node.get("xmlns:glib");
          break;
        case "return-value": // Function return value info
          break; // Do nothing, handled by function object
        case "source-position":
          if (auto base = node.baseParentFromXmlNodeWarn!Base)
          {
            base.sourceFilename = node.get("filename");
            base.sourceLine = node.get("line").to!uint;
          }
          break;
        case "type": // Type information
          break; // Do nothing, TypeNode handles this
        case "varargs":
          if (auto par = node.baseParentFromXmlNodeWarn!Param)
            par.varargs = true;
          break;
        default:
          static bool[dstring] unknownElements;

          if (node.name !in unknownElements)
          {
            unknownElements[node.name] = true;
            stderr.writeln(cast(string)("Unknown XML element '" ~ node.name ~ "'"));
          }
          break;
      }

      foreach (child; node.children)
        recurseXml(child);
    }

    recurseXml(tree.root);
  }

  dstring fileName; /// Gir filename
  dstring packageName; /// Package name
  dstring repoVersion; /// Version of the repo

  dstring namespace; /// Name space of symbols in gir file
  dstring nsVersion; /// Version of the namespace
  dstring sharedLibrary; /// Namespace shared library
  dstring identifierPrefixes; /// Prefix to identifiers
  dstring symbolPrefixes; /// C symbol prefix

  Alias[] aliases; /// Aliases
  Constant[] constants; /// Constants
  Enumeration[] enums; /// Enumerations and bitfields
  Func[] functions; /// Global package functions
  Structure[] structures; /// Structures
  Include[] includes; /// Package includes
  dstring[] cIncludes; /// C header includes
  DocSection[] docSections; /// Documentation sections

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;
}

/// Package include
struct Include
{
  dstring name;
  dstring version_;
}

/// Documentation section
final class DocSection : Base
{
  this(XmlNode node)
  {
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);
    name = node.get("name");
  }

  dstring name; /// Name of doc section
}
