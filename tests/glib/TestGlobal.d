module glib.TestGlobal;

import std.stdio;

import GLib.c.functions;
import GLib.c.types;
import GLib.Global;
import GLib.LogField;
import GLib.Types;

unittest
{
  string testMsg = "Hello C this is D!";
  string capturedLogData;

  void logFunc(string logDomain, LogLevelFlags logLevel, string message)
  {
    capturedLogData = message.dup;
  }

  logSetHandler(null, LogLevelFlags.LevelWarning, &logFunc);
  g_log(cast(const(char)*)null, GLogLevelFlags.LevelWarning, testMsg.ptr);

  assert(capturedLogData == testMsg);
}
