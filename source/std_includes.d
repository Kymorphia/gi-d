module std_includes;

public import std.algorithm : among, canFind, countUntil, endsWith, equal, filter, map, splitter, startsWith;
public import std.array : array, split;
public import std.conv : to;
public import std.exception : assertThrown;
public import std.file : exists, dirEntries, isFile, mkdirRecurse, readText, SpanMode;
public import std.format : format;
public import std.path : buildPath, dirName;
public import std.range : drop, dropOne, empty, join, repeat;
public import std.stdio : stderr;
public import std.string : splitLines, toLower, toUpper, strip;
public import std.uni : isWhite;