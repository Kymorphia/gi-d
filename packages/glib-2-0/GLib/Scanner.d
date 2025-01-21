module GLib.Scanner;

import GLib.ScannerConfig;
import GLib.TokenValue;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GScanner` provides a general-purpose lexical scanner.
 * You should set @input_name after creating the scanner, since
 * it is used by the default message handler when displaying
 * warnings and errors. If you are scanning a file, the filename
 * would be a good choice.
 * The @user_data and @max_parse_errors fields are not used.
 * If you need to associate extra data with the scanner you
 * can place them here.
 * If you want to use your own message handler you can set the
 * @msg_handler field. The type of the message handler function
 * is declared by #GScannerMsgFunc.
 */
class Scanner
{
  GScanner cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Scanner");

    cInstance = *cast(GScanner*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  ~this()
  {
    g_scanner_destroy(&cInstance);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property uint maxParseErrors()
  {
    return (cast(GScanner*)cPtr).maxParseErrors;
  }

  @property void maxParseErrors(uint propval)
  {
    (cast(GScanner*)cPtr).maxParseErrors = propval;
  }

  @property uint parseErrors()
  {
    return (cast(GScanner*)cPtr).parseErrors;
  }

  @property void parseErrors(uint propval)
  {
    (cast(GScanner*)cPtr).parseErrors = propval;
  }

  @property string inputName()
  {
    return (cast(GScanner*)cPtr).inputName.fromCString(false);
  }

  @property void inputName(string propval)
  {
    safeFree(cast(void*)(cast(GScanner*)cPtr).inputName);
    (cast(GScanner*)cPtr).inputName = propval.toCString(true);
  }

  @property Data qdata()
  {
    return (cast(GScanner*)cPtr).qdata;
  }

  @property void qdata(Data propval)
  {
    (cast(GScanner*)cPtr).qdata = propval;
  }

  @property ScannerConfig config()
  {
    return new ScannerConfig(cast(GScannerConfig*)(cast(GScanner*)cPtr).config);
  }

  @property TokenType token()
  {
    return cast(TokenType)(cast(GScanner*)cPtr).token;
  }

  @property void token(TokenType propval)
  {
    (cast(GScanner*)cPtr).token = cast(GTokenType)propval;
  }

  @property TokenValue value()
  {
    return new TokenValue(cast(GTokenValue*)&(cast(GScanner*)cPtr).value);
  }

  @property uint line()
  {
    return (cast(GScanner*)cPtr).line;
  }

  @property void line(uint propval)
  {
    (cast(GScanner*)cPtr).line = propval;
  }

  @property uint position()
  {
    return (cast(GScanner*)cPtr).position;
  }

  @property void position(uint propval)
  {
    (cast(GScanner*)cPtr).position = propval;
  }

  @property TokenType nextToken()
  {
    return cast(TokenType)(cast(GScanner*)cPtr).nextToken;
  }

  @property void nextToken(TokenType propval)
  {
    (cast(GScanner*)cPtr).nextToken = cast(GTokenType)propval;
  }

  @property TokenValue nextValue()
  {
    return new TokenValue(cast(GTokenValue*)&(cast(GScanner*)cPtr).nextValue);
  }

  @property uint nextLine()
  {
    return (cast(GScanner*)cPtr).nextLine;
  }

  @property void nextLine(uint propval)
  {
    (cast(GScanner*)cPtr).nextLine = propval;
  }

  @property uint nextPosition()
  {
    return (cast(GScanner*)cPtr).nextPosition;
  }

  @property void nextPosition(uint propval)
  {
    (cast(GScanner*)cPtr).nextPosition = propval;
  }

  @property GScannerMsgFunc msgHandler()
  {
    return (cast(GScanner*)cPtr).msgHandler;
  }

  @property void msgHandler(GScannerMsgFunc propval)
  {
    (cast(GScanner*)cPtr).msgHandler = propval;
  }

  /**
   * Returns the current line in the input stream $(LPAREN)counting
   * from 1$(RPAREN). This is the line of the last token parsed via
   * [GLib.Scanner.getNextToken].
   * Returns: the current line
   */
  uint curLine()
  {
    uint _retval;
    _retval = g_scanner_cur_line(cast(GScanner*)cPtr);
    return _retval;
  }

  /**
   * Returns the current position in the current line $(LPAREN)counting
   * from 0$(RPAREN). This is the position of the last token parsed via
   * [GLib.Scanner.getNextToken].
   * Returns: the current position on the line
   */
  uint curPosition()
  {
    uint _retval;
    _retval = g_scanner_cur_position(cast(GScanner*)cPtr);
    return _retval;
  }

  /**
   * Gets the current token type. This is simply the token
   * field in the #GScanner structure.
   * Returns: the current token type
   */
  TokenType curToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_cur_token(cast(GScanner*)cPtr);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Frees all memory used by the #GScanner.
   */
  void destroy()
  {
    g_scanner_destroy(cast(GScanner*)cPtr);
  }

  /**
   * Returns %TRUE if the scanner has reached the end of
   * the file or text buffer.
   * Returns: %TRUE if the scanner has reached the end of
   *   the file or text buffer
   */
  bool eof()
  {
    bool _retval;
    _retval = g_scanner_eof(cast(GScanner*)cPtr);
    return _retval;
  }

  /**
   * Parses the next token just like [GLib.Scanner.peekNextToken]
   * and also removes it from the input stream. The token data is
   * placed in the token, value, line, and position fields of
   * the #GScanner structure.
   * Returns: the type of the token
   */
  TokenType getNextToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_get_next_token(cast(GScanner*)cPtr);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Prepares to scan a file.
   * Params:
   *   inputFd = a file descriptor
   */
  void inputFile(int inputFd)
  {
    g_scanner_input_file(cast(GScanner*)cPtr, inputFd);
  }

  /**
   * Prepares to scan a text buffer.
   * Params:
   *   text = the text buffer to scan
   *   textLen = the length of the text buffer
   */
  void inputText(string text, uint textLen)
  {
    const(char)* _text = text.toCString(false);
    g_scanner_input_text(cast(GScanner*)cPtr, _text, textLen);
  }

  /**
   * Looks up a symbol in the current scope and return its value.
   * If the symbol is not bound in the current scope, %NULL is
   * returned.
   * Params:
   *   symbol = the symbol to look up
   * Returns: the value of symbol in the current scope, or %NULL
   *   if symbol is not bound in the current scope
   */
  void* lookupSymbol(string symbol)
  {
    void* _retval;
    const(char)* _symbol = symbol.toCString(false);
    _retval = g_scanner_lookup_symbol(cast(GScanner*)cPtr, _symbol);
    return _retval;
  }

  /**
   * Parses the next token, without removing it from the input stream.
   * The token data is placed in the next_token, next_value, next_line,
   * and next_position fields of the #GScanner structure.
   * Note that, while the token is not removed from the input stream
   * $(LPAREN)i.e. the next call to [GLib.Scanner.getNextToken] will return the
   * same token$(RPAREN), it will not be reevaluated. This can lead to surprising
   * results when changing scope or the scanner configuration after peeking
   * the next token. Getting the next token after switching the scope or
   * configuration will return whatever was peeked before, regardless of
   * any symbols that may have been added or removed in the new scope.
   * Returns: the type of the token
   */
  TokenType peekNextToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_peek_next_token(cast(GScanner*)cPtr);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Adds a symbol to the given scope.
   * Params:
   *   scopeId = the scope id
   *   symbol = the symbol to add
   *   value = the value of the symbol
   */
  void scopeAddSymbol(uint scopeId, string symbol, void* value)
  {
    const(char)* _symbol = symbol.toCString(false);
    g_scanner_scope_add_symbol(cast(GScanner*)cPtr, scopeId, _symbol, value);
  }

  /**
   * Calls the given function for each of the symbol/value pairs
   * in the given scope of the #GScanner. The function is passed
   * the symbol and value of each pair, and the given user_data
   * parameter.
   * Params:
   *   scopeId = the scope id
   *   func = the function to call for each symbol/value pair
   */
  void scopeForeachSymbol(uint scopeId, HFunc func)
  {
    extern(C) void _funcCallback(void* key, void* value, void* userData)
    {
      auto _dlg = cast(HFunc*)userData;

      (*_dlg)(key, value);
    }

    auto _func = cast(void*)&func;
    g_scanner_scope_foreach_symbol(cast(GScanner*)cPtr, scopeId, &_funcCallback, _func);
  }

  /**
   * Looks up a symbol in a scope and return its value. If the
   * symbol is not bound in the scope, %NULL is returned.
   * Params:
   *   scopeId = the scope id
   *   symbol = the symbol to look up
   * Returns: the value of symbol in the given scope, or %NULL
   *   if symbol is not bound in the given scope.
   */
  void* scopeLookupSymbol(uint scopeId, string symbol)
  {
    void* _retval;
    const(char)* _symbol = symbol.toCString(false);
    _retval = g_scanner_scope_lookup_symbol(cast(GScanner*)cPtr, scopeId, _symbol);
    return _retval;
  }

  /**
   * Removes a symbol from a scope.
   * Params:
   *   scopeId = the scope id
   *   symbol = the symbol to remove
   */
  void scopeRemoveSymbol(uint scopeId, string symbol)
  {
    const(char)* _symbol = symbol.toCString(false);
    g_scanner_scope_remove_symbol(cast(GScanner*)cPtr, scopeId, _symbol);
  }

  /**
   * Sets the current scope.
   * Params:
   *   scopeId = the new scope id
   * Returns: the old scope id
   */
  uint setScope(uint scopeId)
  {
    uint _retval;
    _retval = g_scanner_set_scope(cast(GScanner*)cPtr, scopeId);
    return _retval;
  }

  /**
   * Rewinds the filedescriptor to the current buffer position
   * and blows the file read ahead buffer. This is useful for
   * third party uses of the scanners filedescriptor, which hooks
   * onto the current scanning position.
   */
  void syncFileOffset()
  {
    g_scanner_sync_file_offset(cast(GScanner*)cPtr);
  }

  /**
   * Outputs a message through the scanner's msg_handler,
   * resulting from an unexpected token in the input stream.
   * Note that you should not call [GLib.Scanner.peekNextToken]
   * followed by [GLib.Scanner.unexpToken] without an intermediate
   * call to [GLib.Scanner.getNextToken], as [GLib.Scanner.unexpToken]
   * evaluates the scanner's current token $(LPAREN)not the peeked token$(RPAREN)
   * to construct part of the message.
   * Params:
   *   expectedToken = the expected token
   *   identifierSpec = a string describing how the scanner's user
   *     refers to identifiers $(LPAREN)%NULL defaults to "identifier"$(RPAREN).
   *     This is used if expected_token is %G_TOKEN_IDENTIFIER or
   *     %G_TOKEN_IDENTIFIER_NULL.
   *   symbolSpec = a string describing how the scanner's user refers
   *     to symbols $(LPAREN)%NULL defaults to "symbol"$(RPAREN). This is used if
   *     expected_token is %G_TOKEN_SYMBOL or any token value greater
   *     than %G_TOKEN_LAST.
   *   symbolName = the name of the symbol, if the scanner's current
   *     token is a symbol.
   *   message = a message string to output at the end of the
   *     warning/error, or %NULL.
   *   isError = if %TRUE it is output as an error. If %FALSE it is
   *     output as a warning.
   */
  void unexpToken(TokenType expectedToken, string identifierSpec, string symbolSpec, string symbolName, string message, int isError)
  {
    const(char)* _identifierSpec = identifierSpec.toCString(false);
    const(char)* _symbolSpec = symbolSpec.toCString(false);
    const(char)* _symbolName = symbolName.toCString(false);
    const(char)* _message = message.toCString(false);
    g_scanner_unexp_token(cast(GScanner*)cPtr, expectedToken, _identifierSpec, _symbolSpec, _symbolName, _message, isError);
  }
}
