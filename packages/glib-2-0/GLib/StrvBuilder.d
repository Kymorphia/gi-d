module GLib.StrvBuilder;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GStrvBuilder` is a helper object to build a %NULL-terminated string arrays.
 * The following example shows how to build a two element array:
 * ```c
 * g_autoptr$(LPAREN)GStrvBuilder$(RPAREN) builder \= g_strv_builder_new $(LPAREN)$(RPAREN);
 * g_strv_builder_add $(LPAREN)builder, "hello"$(RPAREN);
 * g_strv_builder_add $(LPAREN)builder, "world"$(RPAREN);
 * g_auto$(LPAREN)GStrv$(RPAREN) array \= g_strv_builder_end $(LPAREN)builder$(RPAREN);
 * ```
 */
class StrvBuilder : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_strv_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GStrvBuilder with a reference count of 1.
   * Use [GLib.StrvBuilder.unref] on the returned value when no longer needed.
   * Returns: the new #GStrvBuilder
   */
  this()
  {
    GStrvBuilder* _cretval;
    _cretval = g_strv_builder_new();
    this(_cretval, true);
  }

  /**
   * Add a string to the end of the array.
   * Since 2.68
   * Params:
   *   value = a string.
   */
  void add(string value)
  {
    const(char)* _value = value.toCString(false);
    g_strv_builder_add(cast(GStrvBuilder*)cPtr, _value);
  }

  /**
   * Appends all the strings in the given vector to the builder.
   * Since 2.70
   * Params:
   *   value = the vector of strings to add
   */
  void addv(string[] value)
  {
    char*[] _tmpvalue;
    foreach (s; value)
      _tmpvalue ~= s.toCString(false);
    _tmpvalue ~= null;
    const(char*)* _value = _tmpvalue.ptr;
    g_strv_builder_addv(cast(GStrvBuilder*)cPtr, _value);
  }

  /**
   * Ends the builder process and returns the constructed NULL-terminated string
   * array. The returned value should be freed with [GLib.Global.strfreev] when no longer
   * needed.
   * Returns: the constructed string array.
   *   Since 2.68
   */
  string[] end()
  {
    char** _cretval;
    _cretval = g_strv_builder_end(cast(GStrvBuilder*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Add a string to the end of the array. After value belongs to the
   * #GStrvBuilder and may no longer be modified by the caller.
   * Since 2.80
   * Params:
   *   value = a string.
   *     Ownership of the string is transferred to the #GStrvBuilder
   */
  void take(string value)
  {
    char* _value = value.toCString(true);
    g_strv_builder_take(cast(GStrvBuilder*)cPtr, _value);
  }
}
