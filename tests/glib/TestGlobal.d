module glib.TestGlobal;

import std.stdio;

import GLib.c.functions;
import GLib.c.types;
import GLib.global;
import GLib.LogField;
import gid;

unittest
{
  string testMsg = "Hello C this is D!";
  string capturedLogData;

  void logFunc(string logDomain, LogLevelFlags logLevel, string message)
  {
    capturedLogData = message.dup;
  }

  logSetHandler(null, LogLevelFlags(GLogLevelFlags.LevelWarning), &logFunc);
  g_log(cast(const(char)*)null, GLogLevelFlags.LevelWarning, testMsg.ptr);

  assert(capturedLogData == testMsg);
}
