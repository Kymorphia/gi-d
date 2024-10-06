module Gtk.BuildableParseContext;

import GLib.PtrArray;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An opaque context struct for `GtkBuildableParser`.
 */
class BuildableParseContext
{
  GtkBuildableParseContext* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.BuildableParseContext");

    cInstancePtr = cast(GtkBuildableParseContext*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Retrieves the name of the currently open element.
   * If called from the start_element or end_element handlers this will
   * give the element_name as passed to those functions. For the parent
   * elements, see [Gtk.BuildableParseContext.getElementStack].
   * Returns: the name of the currently open element
   */
  string getElement()
  {
    const(char)* _cretval;
    _cretval = gtk_buildable_parse_context_get_element(cast(GtkBuildableParseContext*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the element stack from the internal state of the parser.
   * The returned `GPtrArray` is an array of strings where the last item is
   * the currently open tag $(LPAREN)as would be returned by
   * [Gtk.BuildableParseContext.getElement]$(RPAREN) and the previous item is its
   * immediate parent.
   * This function is intended to be used in the start_element and
   * end_element handlers where [Gtk.BuildableParseContext.getElement]
   * would merely return the name of the element that is being
   * processed.
   * Returns: the element stack, which must not be modified
   */
  PtrArray!(string, char*) getElementStack()
  {
    GPtrArray* _cretval;
    _cretval = gtk_buildable_parse_context_get_element_stack(cast(GtkBuildableParseContext*)cPtr);
    PtrArray!(string, char*) _retval = new PtrArray!(string, char*)(cast(GPtrArray*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Retrieves the current line number and the number of the character on
   * that line. Intended for use in error messages; there are no strict
   * semantics for what constitutes the "current" line number other than
   * "the best number we could come up with for error messages."
   * Params:
   *   lineNumber = return location for a line number
   *   charNumber = return location for a char-on-line number
   */
  void getPosition(out int lineNumber, out int charNumber)
  {
    gtk_buildable_parse_context_get_position(cast(GtkBuildableParseContext*)cPtr, cast(int*)&lineNumber, cast(int*)&charNumber);
  }

  /**
   * Completes the process of a temporary sub-parser redirection.
   * This function exists to collect the user_data allocated by a
   * matching call to [Gtk.BuildableParseContext.push]. It must be called
   * in the end_element handler corresponding to the start_element
   * handler during which [Gtk.BuildableParseContext.push] was called.
   * You must not call this function from the error callback -- the
   * user_data is provided directly to the callback in that case.
   * This function is not intended to be directly called by users
   * interested in invoking subparsers. Instead, it is intended to
   * be used by the subparsers themselves to implement a higher-level
   * interface.
   * Returns: the user data passed to [Gtk.BuildableParseContext.push]
   */
  void* pop()
  {
    void* _retval;
    _retval = gtk_buildable_parse_context_pop(cast(GtkBuildableParseContext*)cPtr);
    return _retval;
  }

  /**
   * Temporarily redirects markup data to a sub-parser.
   * This function may only be called from the start_element handler of
   * a `GtkBuildableParser`. It must be matched with a corresponding call to
   * [Gtk.BuildableParseContext.pop] in the matching end_element handler
   * $(LPAREN)except in the case that the parser aborts due to an error$(RPAREN).
   * All tags, text and other data between the matching tags is
   * redirected to the subparser given by parser. user_data is used
   * as the user_data for that parser. user_data is also passed to the
   * error callback in the event that an error occurs. This includes
   * errors that occur in subparsers of the subparser.
   * The end tag matching the start tag for which this call was made is
   * handled by the previous parser $(LPAREN)which is given its own user_data$(RPAREN)
   * which is why [Gtk.BuildableParseContext.pop] is provided to allow "one
   * last access" to the user_data provided to this function. In the
   * case of error, the user_data provided here is passed directly to
   * the error callback of the subparser and [Gtk.BuildableParseContext.pop]
   * should not be called. In either case, if user_data was allocated
   * then it ought to be freed from both of these locations.
   * This function is not intended to be directly called by users
   * interested in invoking subparsers. Instead, it is intended to be
   * used by the subparsers themselves to implement a higher-level
   * interface.
   * For an example of how to use this, see [GLib.MarkupParseContext.push] which
   * has the same kind of API.
   * Params:
   *   parser = a `GtkBuildableParser`
   *   userData = user data to pass to `GtkBuildableParser` functions
   */
  void push(BuildableParser parser, void* userData)
  {
    gtk_buildable_parse_context_push(cast(GtkBuildableParseContext*)cPtr, &parser, userData);
  }
}
