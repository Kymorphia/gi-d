module std_includes;

public import std.algorithm : among, canFind, countUntil, endsWith, equal, find, filter, map, sort, splitter, startsWith;
public import std.array : array, assocArray, split;
public import std.conv : to;
public import std.exception : assertThrown;
public import std.file : exists, dirEntries, isFile, mkdirRecurse, readText, SpanMode, write;
public import std.format : format;
public import std.path : baseName, buildPath, dirName, stripExtension;
public import std.range : drop, dropOne, empty, join, repeat, tee;
public import std.stdio : stderr, writeln;
public import std.string : splitLines, toLower, toUpper, strip, stripLeft, stripRight;
public import std.typecons : BitFlags, tuple, Yes;
public import std.uni : isWhite;