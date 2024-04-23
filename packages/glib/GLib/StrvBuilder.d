module GLib.StrvBuilder;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * #GStrvBuilder is a method of easily building dynamically sized
 * NULL-terminated string arrays.
 *
 * The following example shows how to build a two element array:
 *
 * |[<!-- language="C" -->
 * g_autoptr(GStrvBuilder) builder = g_strv_builder_new ();
 * g_strv_builder_add (builder, "hello");
 * g_strv_builder_add (builder, "world");
 * g_auto(GStrv) array = g_strv_builder_end (builder);
 * ]|
 */
class StrvBuilder
{
  GStrvBuilder* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StrvBuilder");

    cInstancePtr = cast(GStrvBuilder*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_strv_builder_unref(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GStrvBuilder))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Add a string to the end of the array.
   *
   * Since 2.68
   */
  void add(string value)
  {
    const(char)* _value = value.toCString(false);
    g_strv_builder_add(cPtr!GStrvBuilder, _value);
  }

  /**
   * Appends all the strings in the given vector to the builder.
   *
   * Since 2.70
   */
  void addv(string[] value)
  {
    char*[] _tmpvalue;
    foreach (s; value)
      _tmpvalue ~= s.toCString(false);
    _tmpvalue ~= null;
    const(char*)* _value = _tmpvalue.ptr;
    g_strv_builder_addv(cPtr!GStrvBuilder, _value);
  }

  /**
   * the constructed string array.
   *
   * Since 2.68
   */
  string[] end()
  {
    char** _cretval;
    _cretval = g_strv_builder_end(cPtr!GStrvBuilder);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }
}
