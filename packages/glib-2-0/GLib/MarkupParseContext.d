module GLib.MarkupParseContext;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.SList;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A parse context is used to parse a stream of bytes that
 * you expect to contain marked-up text.
 * See [GLib.MarkupParseContext.new_], #GMarkupParser, and so
 * on for more details.
 */
class MarkupParseContext : Boxed
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
    return g_markup_parse_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(ref MarkupParser parser, MarkupParseFlags flags)
  {
    GMarkupParseContext* _cretval;
    GMarkupParseFlags _flags = cast(GMarkupParseFlags)cast(uint)flags;
    _cretval = g_markup_parse_context_new(&parser, _flags, null, null);
    this(&_cretval, true);
  }


  /**
   * Signals to the #GMarkupParseContext that all data has been
   * fed into the parse context with [GLib.MarkupParseContext.parse].
   * This function reports an error if the document isn't complete,
   * for example if elements are still open.
   * Returns: %TRUE on success, %FALSE if an error was set
   */
  bool endParse()
  {
    bool _retval;
    GError *_err;
    _retval = g_markup_parse_context_end_parse(cast(GMarkupParseContext*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Retrieves the name of the currently open element.
   * If called from the start_element or end_element handlers this will
   * give the element_name as passed to those functions. For the parent
   * elements, see [GLib.MarkupParseContext.getElementStack].
   * Returns: the name of the currently open element, or %NULL
   */
  string getElement()
  {
    const(char)* _cretval;
    _cretval = g_markup_parse_context_get_element(cast(GMarkupParseContext*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the element stack from the internal state of the parser.
   * The returned #GSList is a list of strings where the first item is
   * the currently open tag $(LPAREN)as would be returned by
   * [GLib.MarkupParseContext.getElement]$(RPAREN) and the next item is its
   * immediate parent.
   * This function is intended to be used in the start_element and
   * end_element handlers where [GLib.MarkupParseContext.getElement]
   * would merely return the name of the element that is being
   * processed.
   * Returns: the element stack, which must not be modified
   */
  SList!(string) getElementStack()
  {
    const(GSList)* _cretval;
    _cretval = g_markup_parse_context_get_element_stack(cast(GMarkupParseContext*)cPtr);
    SList!(string) _retval = new SList!(string)(cast(GSList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Retrieves the current line number and the number of the character on
   * that line. Intended for use in error messages; there are no strict
   * semantics for what constitutes the "current" line number other than
   * "the best number we could come up with for error messages."
   * Params:
   *   lineNumber = return location for a line number, or %NULL
   *   charNumber = return location for a char-on-line number, or %NULL
   */
  void getPosition(out int lineNumber, out int charNumber)
  {
    g_markup_parse_context_get_position(cast(GMarkupParseContext*)cPtr, cast(int*)&lineNumber, cast(int*)&charNumber);
  }

  /**
   * Returns the user_data associated with context.
   * This will either be the user_data that was provided to
   * [GLib.MarkupParseContext.new_] or to the most recent call
   * of [GLib.MarkupParseContext.push].
   * Returns: the provided user_data. The returned data belongs to
   *   the markup context and will be freed when
   *   [GLib.MarkupParseContext.free] is called.
   */
  void* getUserData()
  {
    void* _retval;
    _retval = g_markup_parse_context_get_user_data(cast(GMarkupParseContext*)cPtr);
    return _retval;
  }

  /**
   * Feed some data to the #GMarkupParseContext.
   * The data need not be valid UTF-8; an error will be signaled if
   * it's invalid. The data need not be an entire document; you can
   * feed a document into the parser incrementally, via multiple calls
   * to this function. Typically, as you receive data from a network
   * connection or file, you feed each received chunk of data into this
   * function, aborting the process if an error occurs. Once an error
   * is reported, no further data may be fed to the #GMarkupParseContext;
   * all errors are fatal.
   * Params:
   *   text = chunk of text to parse
   *   textLen = length of text in bytes
   * Returns: %FALSE if an error occurred, %TRUE on success
   */
  bool parse(string text, ptrdiff_t textLen)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    GError *_err;
    _retval = g_markup_parse_context_parse(cast(GMarkupParseContext*)cPtr, _text, textLen, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Completes the process of a temporary sub-parser redirection.
   * This function exists to collect the user_data allocated by a
   * matching call to [GLib.MarkupParseContext.push]. It must be called
   * in the end_element handler corresponding to the start_element
   * handler during which [GLib.MarkupParseContext.push] was called.
   * You must not call this function from the error callback -- the
   * user_data is provided directly to the callback in that case.
   * This function is not intended to be directly called by users
   * interested in invoking subparsers. Instead, it is intended to
   * be used by the subparsers themselves to implement a higher-level
   * interface.
   * Returns: the user data passed to [GLib.MarkupParseContext.push]
   */
  void* pop()
  {
    void* _retval;
    _retval = g_markup_parse_context_pop(cast(GMarkupParseContext*)cPtr);
    return _retval;
  }

  /**
   * Temporarily redirects markup data to a sub-parser.
   * This function may only be called from the start_element handler of
   * a #GMarkupParser. It must be matched with a corresponding call to
   * [GLib.MarkupParseContext.pop] in the matching end_element handler
   * $(LPAREN)except in the case that the parser aborts due to an error$(RPAREN).
   * All tags, text and other data between the matching tags is
   * redirected to the subparser given by parser. user_data is used
   * as the user_data for that parser. user_data is also passed to the
   * error callback in the event that an error occurs. This includes
   * errors that occur in subparsers of the subparser.
   * The end tag matching the start tag for which this call was made is
   * handled by the previous parser $(LPAREN)which is given its own user_data$(RPAREN)
   * which is why [GLib.MarkupParseContext.pop] is provided to allow "one
   * last access" to the user_data provided to this function. In the
   * case of error, the user_data provided here is passed directly to
   * the error callback of the subparser and [GLib.MarkupParseContext.pop]
   * should not be called. In either case, if user_data was allocated
   * then it ought to be freed from both of these locations.
   * This function is not intended to be directly called by users
   * interested in invoking subparsers. Instead, it is intended to be
   * used by the subparsers themselves to implement a higher-level
   * interface.
   * As an example, see the following implementation of a simple
   * parser that counts the number of tags encountered.
   * |[<!-- language\="C" -->
   * typedef struct
   * {
   * gint tag_count;
   * } CounterData;
   * static void
   * counter_start_element $(LPAREN)GMarkupParseContext  *context,
   * const gchar          *element_name,
   * const gchar         **attribute_names,
   * const gchar         **attribute_values,
   * gpointer              user_data,
   * GError              **error$(RPAREN)
   * {
   * CounterData *data \= user_data;
   * data->tag_count++;
   * }
   * static void
   * counter_error $(LPAREN)GMarkupParseContext *context,
   * GError              *error,
   * gpointer             user_data$(RPAREN)
   * {
   * CounterData *data \= user_data;
   * g_slice_free $(LPAREN)CounterData, data$(RPAREN);
   * }
   * static GMarkupParser counter_subparser \=
   * {
   * counter_start_element,
   * NULL,
   * NULL,
   * NULL,
   * counter_error
   * };
   * ]|
   * In order to allow this parser to be easily used as a subparser, the
   * following interface is provided:
   * |[<!-- language\="C" -->
   * void
   * start_counting $(LPAREN)GMarkupParseContext *context$(RPAREN)
   * {
   * CounterData *data \= g_slice_new $(LPAREN)CounterData$(RPAREN);
   * data->tag_count \= 0;
   * g_markup_parse_context_push $(LPAREN)context, &counter_subparser, data$(RPAREN);
   * }
   * gint
   * end_counting $(LPAREN)GMarkupParseContext *context$(RPAREN)
   * {
   * CounterData *data \= g_markup_parse_context_pop $(LPAREN)context$(RPAREN);
   * int result;
   * result \= data->tag_count;
   * g_slice_free $(LPAREN)CounterData, data$(RPAREN);
   * return result;
   * }
   * ]|
   * The subparser would then be used as follows:
   * |[<!-- language\="C" -->
   * static void start_element $(LPAREN)context, element_name, ...$(RPAREN)
   * {
   * if $(LPAREN)strcmp $(LPAREN)element_name, "count-these"$(RPAREN) \=\= 0$(RPAREN)
   * start_counting $(LPAREN)context$(RPAREN);
   * // else, handle other tags...
   * }
   * static void end_element $(LPAREN)context, element_name, ...$(RPAREN)
   * {
   * if $(LPAREN)strcmp $(LPAREN)element_name, "count-these"$(RPAREN) \=\= 0$(RPAREN)
   * g_print $(LPAREN)"Counted %d tags\n", end_counting $(LPAREN)context$(RPAREN)$(RPAREN);
   * // else, handle other tags...
   * }
   * ]|
   * Params:
   *   parser = a #GMarkupParser
   *   userData = user data to pass to #GMarkupParser functions
   */
  void push(MarkupParser parser, void* userData)
  {
    g_markup_parse_context_push(cast(GMarkupParseContext*)cPtr, &parser, userData);
  }
}
