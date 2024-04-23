module GLib.MarkupParseContext;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A parse context is used to parse a stream of bytes that
 * you expect to contain marked-up text.
 *
 * See g_markup_parse_context_new(), #GMarkupParser, and so
 * on for more details.
 */
class MarkupParseContext : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GMarkupParseContext))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_markup_parse_context_get_type();
  }

  this(ref MarkupParser parser, MarkupParseFlags flags)
  {
    GMarkupParseContext* _cretval;
    GMarkupParseFlags _flags = cast(GMarkupParseFlags)cast(uint)flags;
    _cretval = g_markup_parse_context_new(&parser, _flags, null, null);
    this(&_cretval, true);
  }


  /**
   * %TRUE on success, %FALSE if an error was set
   */
  bool endParse()
  {
    bool _retval;
    GError *_err;
    _retval = g_markup_parse_context_end_parse(cPtr!GMarkupParseContext, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the name of the currently open element, or %NULL
   */
  string getElement()
  {
    const(char)* _cretval;
    _cretval = g_markup_parse_context_get_element(cPtr!GMarkupParseContext);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the current line number and the number of the character on
   * that line. Intended for use in error messages; there are no strict
   * semantics for what constitutes the "current" line number other than
   * "the best number we could come up with for error messages."
   */
  void getPosition(out int lineNumber, out int charNumber)
  {
    g_markup_parse_context_get_position(cPtr!GMarkupParseContext, cast(int*)&lineNumber, cast(int*)&charNumber);
  }

  /**
   * the provided user_data. The returned data belongs to
   * the markup context and will be freed when
   * g_markup_parse_context_free() is called.
   */
  void* getUserData()
  {
    void* _retval;
    _retval = g_markup_parse_context_get_user_data(cPtr!GMarkupParseContext);
    return _retval;
  }

  /**
   * %FALSE if an error occurred, %TRUE on success
   */
  bool parse(string text, ptrdiff_t textLen)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    GError *_err;
    _retval = g_markup_parse_context_parse(cPtr!GMarkupParseContext, _text, textLen, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the user data passed to g_markup_parse_context_push()
   */
  void* pop()
  {
    void* _retval;
    _retval = g_markup_parse_context_pop(cPtr!GMarkupParseContext);
    return _retval;
  }

  /**
   * Temporarily redirects markup data to a sub-parser.
   *
   * This function may only be called from the start_element handler of
   * a #GMarkupParser. It must be matched with a corresponding call to
   * g_markup_parse_context_pop() in the matching end_element handler
   * (except in the case that the parser aborts due to an error).
   *
   * All tags, text and other data between the matching tags is
   * redirected to the subparser given by @parser. @user_data is used
   * as the user_data for that parser. @user_data is also passed to the
   * error callback in the event that an error occurs. This includes
   * errors that occur in subparsers of the subparser.
   *
   * The end tag matching the start tag for which this call was made is
   * handled by the previous parser (which is given its own user_data)
   * which is why g_markup_parse_context_pop() is provided to allow "one
   * last access" to the @user_data provided to this function. In the
   * case of error, the @user_data provided here is passed directly to
   * the error callback of the subparser and g_markup_parse_context_pop()
   * should not be called. In either case, if @user_data was allocated
   * then it ought to be freed from both of these locations.
   *
   * This function is not intended to be directly called by users
   * interested in invoking subparsers. Instead, it is intended to be
   * used by the subparsers themselves to implement a higher-level
   * interface.
   *
   * As an example, see the following implementation of a simple
   * parser that counts the number of tags encountered.
   *
   * |[<!-- language="C" -->
   * typedef struct
   * {
   * gint tag_count;
   * } CounterData;
   *
   * static void
   * counter_start_element (GMarkupParseContext  *context,
   * const gchar          *element_name,
   * const gchar         **attribute_names,
   * const gchar         **attribute_values,
   * gpointer              user_data,
   * GError              **error)
   * {
   * CounterData *data = user_data;
   *
   * data->tag_count++;
   * }
   *
   * static void
   * counter_error (GMarkupParseContext *context,
   * GError              *error,
   * gpointer             user_data)
   * {
   * CounterData *data = user_data;
   *
   * g_slice_free (CounterData, data);
   * }
   *
   * static GMarkupParser counter_subparser =
   * {
   * counter_start_element,
   * NULL,
   * NULL,
   * NULL,
   * counter_error
   * };
   * ]|
   *
   * In order to allow this parser to be easily used as a subparser, the
   * following interface is provided:
   *
   * |[<!-- language="C" -->
   * void
   * start_counting (GMarkupParseContext *context)
   * {
   * CounterData *data = g_slice_new (CounterData);
   *
   * data->tag_count = 0;
   * g_markup_parse_context_push (context, &counter_subparser, data);
   * }
   *
   * gint
   * end_counting (GMarkupParseContext *context)
   * {
   * CounterData *data = g_markup_parse_context_pop (context);
   * int result;
   *
   * result = data->tag_count;
   * g_slice_free (CounterData, data);
   *
   * return result;
   * }
   * ]|
   *
   * The subparser would then be used as follows:
   *
   * |[<!-- language="C" -->
   * static void start_element (context, element_name, ...)
   * {
   * if (strcmp (element_name, "count-these") == 0)
   * start_counting (context);
   *
   * // else, handle other tags...
   * }
   *
   * static void end_element (context, element_name, ...)
   * {
   * if (strcmp (element_name, "count-these") == 0)
   * g_print ("Counted %d tags\n", end_counting (context));
   *
   * // else, handle other tags...
   * }
   * ]|
   */
  void push(MarkupParser parser, void* userData)
  {
    g_markup_parse_context_push(cPtr!GMarkupParseContext, &parser, userData);
  }
}
