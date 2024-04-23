module GLib.Scanner;

import GLib.ScannerConfig;
import GLib.TokenValue;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The data structure representing a lexical scanner.
 *
 * You should set @input_name after creating the scanner, since
 * it is used by the default message handler when displaying
 * warnings and errors. If you are scanning a file, the filename
 * would be a good choice.
 *
 * The @user_data and @max_parse_errors fields are not used.
 * If you need to associate extra data with the scanner you
 * can place them here.
 *
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
      g_free(ptr);
  }

  ~this()
  {
    g_scanner_destroy(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GScanner))
  {
    return cast(T*)&cInstance;
  }

  @property uint maxParseErrors()
  {
    return cPtr!GScanner.maxParseErrors;
  }

  @property void maxParseErrors(uint propval)
  {
    cPtr!GScanner.maxParseErrors = propval;
  }

  @property uint parseErrors()
  {
    return cPtr!GScanner.parseErrors;
  }

  @property void parseErrors(uint propval)
  {
    cPtr!GScanner.parseErrors = propval;
  }

  @property string inputName()
  {
    return cPtr!GScanner.inputName.fromCString(false);
  }

  @property void inputName(string propval)
  {
    g_free(cast(void*)cPtr!GScanner.inputName);
    cPtr!GScanner.inputName = propval.toCString(true);
  }

  @property Data* qdata()
  {
    return cPtr!GScanner.qdata;
  }

  @property void qdata(Data* propval)
  {
    cPtr!GScanner.qdata = propval;
  }

  @property ScannerConfig config()
  {
    return new ScannerConfig(cast(GScannerConfig*)cPtr!GScanner.config);
  }

  @property TokenType token()
  {
    return cast(TokenType)cPtr!GScanner.token;
  }

  @property void token(TokenType propval)
  {
    cPtr!GScanner.token = cast(GTokenType)propval;
  }

  @property TokenValue value()
  {
    return new TokenValue(cast(GTokenValue*)&cPtr!GScanner.value);
  }

  @property uint line()
  {
    return cPtr!GScanner.line;
  }

  @property void line(uint propval)
  {
    cPtr!GScanner.line = propval;
  }

  @property uint position()
  {
    return cPtr!GScanner.position;
  }

  @property void position(uint propval)
  {
    cPtr!GScanner.position = propval;
  }

  @property TokenType nextToken()
  {
    return cast(TokenType)cPtr!GScanner.nextToken;
  }

  @property void nextToken(TokenType propval)
  {
    cPtr!GScanner.nextToken = cast(GTokenType)propval;
  }

  @property TokenValue nextValue()
  {
    return new TokenValue(cast(GTokenValue*)&cPtr!GScanner.nextValue);
  }

  @property uint nextLine()
  {
    return cPtr!GScanner.nextLine;
  }

  @property void nextLine(uint propval)
  {
    cPtr!GScanner.nextLine = propval;
  }

  @property uint nextPosition()
  {
    return cPtr!GScanner.nextPosition;
  }

  @property void nextPosition(uint propval)
  {
    cPtr!GScanner.nextPosition = propval;
  }

  @property GScannerMsgFunc msgHandler()
  {
    return cPtr!GScanner.msgHandler;
  }

  @property void msgHandler(GScannerMsgFunc propval)
  {
    cPtr!GScanner.msgHandler = propval;
  }

  /**
   * the current line
   */
  uint curLine()
  {
    uint _retval;
    _retval = g_scanner_cur_line(cPtr!GScanner);
    return _retval;
  }

  /**
   * the current position on the line
   */
  uint curPosition()
  {
    uint _retval;
    _retval = g_scanner_cur_position(cPtr!GScanner);
    return _retval;
  }

  /**
   * the current token type
   */
  TokenType curToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_cur_token(cPtr!GScanner);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Frees all memory used by the #GScanner.
   */
  void destroy()
  {
    g_scanner_destroy(cPtr!GScanner);
  }

  /**
   * %TRUE if the scanner has reached the end of
   * the file or text buffer
   */
  bool eof()
  {
    bool _retval;
    _retval = g_scanner_eof(cPtr!GScanner);
    return _retval;
  }

  /**
   * the type of the token
   */
  TokenType getNextToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_get_next_token(cPtr!GScanner);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Prepares to scan a file.
   */
  void inputFile(int inputFd)
  {
    g_scanner_input_file(cPtr!GScanner, inputFd);
  }

  /**
   * Prepares to scan a text buffer.
   */
  void inputText(string text, uint textLen)
  {
    const(char)* _text = text.toCString(false);
    g_scanner_input_text(cPtr!GScanner, _text, textLen);
  }

  /**
   * the value of @symbol in the current scope, or %NULL
   * if @symbol is not bound in the current scope
   */
  void* lookupSymbol(string symbol)
  {
    void* _retval;
    const(char)* _symbol = symbol.toCString(false);
    _retval = g_scanner_lookup_symbol(cPtr!GScanner, _symbol);
    return _retval;
  }

  /**
   * the type of the token
   */
  TokenType peekNextToken()
  {
    GTokenType _cretval;
    _cretval = g_scanner_peek_next_token(cPtr!GScanner);
    TokenType _retval = cast(TokenType)_cretval;
    return _retval;
  }

  /**
   * Adds a symbol to the given scope.
   */
  void scopeAddSymbol(uint scopeId, string symbol, void* value)
  {
    const(char)* _symbol = symbol.toCString(false);
    g_scanner_scope_add_symbol(cPtr!GScanner, scopeId, _symbol, value);
  }

  /**
   * the value of @symbol in the given scope, or %NULL
   * if @symbol is not bound in the given scope.
   */
  void* scopeLookupSymbol(uint scopeId, string symbol)
  {
    void* _retval;
    const(char)* _symbol = symbol.toCString(false);
    _retval = g_scanner_scope_lookup_symbol(cPtr!GScanner, scopeId, _symbol);
    return _retval;
  }

  /**
   * Removes a symbol from a scope.
   */
  void scopeRemoveSymbol(uint scopeId, string symbol)
  {
    const(char)* _symbol = symbol.toCString(false);
    g_scanner_scope_remove_symbol(cPtr!GScanner, scopeId, _symbol);
  }

  /**
   * the old scope id
   */
  uint setScope(uint scopeId)
  {
    uint _retval;
    _retval = g_scanner_set_scope(cPtr!GScanner, scopeId);
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
    g_scanner_sync_file_offset(cPtr!GScanner);
  }

  /**
   * Outputs a message through the scanner's msg_handler,
   * resulting from an unexpected token in the input stream.
   * Note that you should not call g_scanner_peek_next_token()
   * followed by g_scanner_unexp_token() without an intermediate
   * call to g_scanner_get_next_token(), as g_scanner_unexp_token()
   * evaluates the scanner's current token (not the peeked token)
   * to construct part of the message.
   */
  void unexpToken(TokenType expectedToken, string identifierSpec, string symbolSpec, string symbolName, string message, int isError)
  {
    const(char)* _identifierSpec = identifierSpec.toCString(false);
    const(char)* _symbolSpec = symbolSpec.toCString(false);
    const(char)* _symbolName = symbolName.toCString(false);
    const(char)* _message = message.toCString(false);
    g_scanner_unexp_token(cPtr!GScanner, expectedToken, _identifierSpec, _symbolSpec, _symbolName, _message, isError);
  }
}
