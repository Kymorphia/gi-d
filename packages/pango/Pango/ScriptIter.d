module Pango.ScriptIter;

import GLib.Boxed;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoScriptIter` is used to iterate through a string
 * and identify ranges in different scripts.
 */
class ScriptIter : Boxed
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
    return pango_script_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `PangoScriptIter`, used to break a string of
   * Unicode text into runs by Unicode script.
   * No copy is made of text, so the caller needs to make
   * sure it remains valid until the iterator is freed with
   * [Pango.ScriptIter.free].
   * Params:
   *   text = a UTF-8 string
   *   length = length of text, or -1 if text is nul-terminated
   * Returns: the new script iterator, initialized
   *   to point at the first range in the text, which should be
   *   freed with [Pango.ScriptIter.free]. If the string is
   *   empty, it will point at an empty range.
   */
  this(string text, int length)
  {
    PangoScriptIter* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = pango_script_iter_new(_text, length);
    this(_cretval, true);
  }

  /**
   * Gets information about the range to which iter currently points.
   * The range is the set of locations p where *start <\= p < *end.
   * $(LPAREN)That is, it doesn't include the character stored at *end$(RPAREN)
   * Note that while the type of the script argument is declared
   * as `PangoScript`, as of Pango 1.18, this function simply returns
   * `GUnicodeScript` values. Callers must be prepared to handle unknown
   * values.
   * Params:
   *   start = location to store start position of the range
   *   end = location to store end position of the range
   *   script = location to store script for range
   */
  void getRange(out string start, out string end, out Script script)
  {
    char* _start;
    char* _end;
    pango_script_iter_get_range(cast(PangoScriptIter*)cPtr, &_start, &_end, &script);
    start = _start.fromCString(true);
    end = _end.fromCString(true);
  }

  /**
   * Advances a `PangoScriptIter` to the next range.
   * If iter is already at the end, it is left unchanged
   * and %FALSE is returned.
   * Returns: %TRUE if iter was successfully advanced
   */
  bool next()
  {
    bool _retval;
    _retval = pango_script_iter_next(cast(PangoScriptIter*)cPtr);
    return _retval;
  }
}
