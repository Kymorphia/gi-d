module std_includes;

public import core.exception : RangeError;
public import std.algorithm : among, canFind, count, countUntil, each, endsWith, equal, find, filter, map, remove,
  sort, splitter, startsWith, uniq;
public import std.array : array, assocArray, replace, replicate, split;
public import std.conv : to;
public import std.exception : assertThrown;
public import std.file : exists, dirEntries, isFile, mkdirRecurse, readText, SpanMode, write;
public import std.format : format;
public import std.path : baseName, buildPath, dirName, stripExtension;
public import std.range : chain, drop, dropOne, empty, enumerate, join, repeat, retro, tee;
public import std.stdio : stderr, writeln;
public import std.string : capitalize, splitLines, toLower, toUpper, strip, stripLeft, stripRight;
public import std.traits : EnumMembers;
public import std.typecons : BitFlags, tuple, Yes;
public import std.uni : isWhite;
