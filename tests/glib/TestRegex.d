module glib.TestRegex;

import std.typecons;

import GLib.MatchInfo;
import GLib.Regex;
import GLib.Global;
import GLib.Types;
import GLib.c.types;

unittest
{
  import std.exception;
  import std.algorithm;

  void testRegexException()
  {
    try
      new Regex("BrokenRegex[", RegexCompileFlags(GRegexCompileFlags.Default), RegexMatchFlags(GRegexMatchFlags.Default));
    catch (RegexException e)
    {
      assert(e.domain == Regex.errorQuark);
      assert(e.code == RegexError.UnterminatedCharacterClass);
      assert(e.message.canFind("Error while compiling regular expression"));
      throw e;
    }
  }
  assertThrown!RegexException(testRegexException);

  auto pattern = `status: \(([^)]+)\)`;

  auto regex = new Regex(pattern, RegexCompileFlags(GRegexCompileFlags.Caseless), RegexMatchFlags(GRegexMatchFlags.Default));
  assert(regex.getCaptureCount == 1);
  assert(regex.getCompileFlags == RegexCompileFlags(GRegexCompileFlags.Caseless));
  assert(regex.getMatchFlags == RegexMatchFlags(GRegexMatchFlags.Default));
  assert(regex.getPattern == pattern);

  MatchInfo matchInfo;
  auto retval = regex.match("Test output status: (Okay)", RegexMatchFlags(GRegexMatchFlags.Default), matchInfo);
  assert(retval == true);
  assert(matchInfo.matches);
  assert(matchInfo.getMatchCount == 2);
  assert(matchInfo.fetch(1) == "Okay");
}
