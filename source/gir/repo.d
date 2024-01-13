module gir.repo;

import gir.func;

/// Gir repository
class Repo
{
  dstring fileName; /// Gir filename
  dstring packageName; /// Package name
  dstring repoVersion; /// Version of the repo

  dstring namespace; /// Name space of symbols in gir file
  dstring nsVersion; /// Version of the namespace
  dstring sharedLibrary; /// Namespace shared library
  dstring identifierPrefixes; /// Prefix to identifiers
  dstring cSymbolPrefixes; /// C symbol prefix

  Func[] functions; /// Global package functions
  Include[] includes; /// Package includes
  dstring[] cIncludes; /// C header includes
  DocSection[] docSections; /// Documentation sections
}

/// Package include
class Include
{
  dstring name;
  dstring version_;
}

/// Documentation section
class DocSection
{
  dstring name; /// Name of doc section
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line
}
