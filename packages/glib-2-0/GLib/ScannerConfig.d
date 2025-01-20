module GLib.ScannerConfig;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * Specifies the #GScanner parser configuration. Most settings can
 * be changed during the parsing phase and will affect the lexical
 * parsing of the next unpeeked token.
 */
class ScannerConfig
{
  GScannerConfig cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.ScannerConfig");

    cInstance = *cast(GScannerConfig*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string csetSkipCharacters()
  {
    return (cast(GScannerConfig*)cPtr).csetSkipCharacters.fromCString(false);
  }

  @property void csetSkipCharacters(string propval)
  {
    safeFree(cast(void*)(cast(GScannerConfig*)cPtr).csetSkipCharacters);
    (cast(GScannerConfig*)cPtr).csetSkipCharacters = propval.toCString(true);
  }

  @property string csetIdentifierFirst()
  {
    return (cast(GScannerConfig*)cPtr).csetIdentifierFirst.fromCString(false);
  }

  @property void csetIdentifierFirst(string propval)
  {
    safeFree(cast(void*)(cast(GScannerConfig*)cPtr).csetIdentifierFirst);
    (cast(GScannerConfig*)cPtr).csetIdentifierFirst = propval.toCString(true);
  }

  @property string csetIdentifierNth()
  {
    return (cast(GScannerConfig*)cPtr).csetIdentifierNth.fromCString(false);
  }

  @property void csetIdentifierNth(string propval)
  {
    safeFree(cast(void*)(cast(GScannerConfig*)cPtr).csetIdentifierNth);
    (cast(GScannerConfig*)cPtr).csetIdentifierNth = propval.toCString(true);
  }

  @property string cpairCommentSingle()
  {
    return (cast(GScannerConfig*)cPtr).cpairCommentSingle.fromCString(false);
  }

  @property void cpairCommentSingle(string propval)
  {
    safeFree(cast(void*)(cast(GScannerConfig*)cPtr).cpairCommentSingle);
    (cast(GScannerConfig*)cPtr).cpairCommentSingle = propval.toCString(true);
  }

  @property uint caseSensitive()
  {
    return (cast(GScannerConfig*)cPtr).caseSensitive;
  }

  @property void caseSensitive(uint propval)
  {
    (cast(GScannerConfig*)cPtr).caseSensitive = propval;
  }

  @property uint skipCommentMulti()
  {
    return (cast(GScannerConfig*)cPtr).skipCommentMulti;
  }

  @property void skipCommentMulti(uint propval)
  {
    (cast(GScannerConfig*)cPtr).skipCommentMulti = propval;
  }

  @property uint skipCommentSingle()
  {
    return (cast(GScannerConfig*)cPtr).skipCommentSingle;
  }

  @property void skipCommentSingle(uint propval)
  {
    (cast(GScannerConfig*)cPtr).skipCommentSingle = propval;
  }

  @property uint scanCommentMulti()
  {
    return (cast(GScannerConfig*)cPtr).scanCommentMulti;
  }

  @property void scanCommentMulti(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanCommentMulti = propval;
  }

  @property uint scanIdentifier()
  {
    return (cast(GScannerConfig*)cPtr).scanIdentifier;
  }

  @property void scanIdentifier(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanIdentifier = propval;
  }

  @property uint scanIdentifier1char()
  {
    return (cast(GScannerConfig*)cPtr).scanIdentifier1char;
  }

  @property void scanIdentifier1char(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanIdentifier1char = propval;
  }

  @property uint scanIdentifierNULL()
  {
    return (cast(GScannerConfig*)cPtr).scanIdentifierNULL;
  }

  @property void scanIdentifierNULL(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanIdentifierNULL = propval;
  }

  @property uint scanSymbols()
  {
    return (cast(GScannerConfig*)cPtr).scanSymbols;
  }

  @property void scanSymbols(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanSymbols = propval;
  }

  @property uint scanBinary()
  {
    return (cast(GScannerConfig*)cPtr).scanBinary;
  }

  @property void scanBinary(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanBinary = propval;
  }

  @property uint scanOctal()
  {
    return (cast(GScannerConfig*)cPtr).scanOctal;
  }

  @property void scanOctal(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanOctal = propval;
  }

  @property uint scanFloat()
  {
    return (cast(GScannerConfig*)cPtr).scanFloat;
  }

  @property void scanFloat(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanFloat = propval;
  }

  @property uint scanHex()
  {
    return (cast(GScannerConfig*)cPtr).scanHex;
  }

  @property void scanHex(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanHex = propval;
  }

  @property uint scanHexDollar()
  {
    return (cast(GScannerConfig*)cPtr).scanHexDollar;
  }

  @property void scanHexDollar(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanHexDollar = propval;
  }

  @property uint scanStringSq()
  {
    return (cast(GScannerConfig*)cPtr).scanStringSq;
  }

  @property void scanStringSq(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanStringSq = propval;
  }

  @property uint scanStringDq()
  {
    return (cast(GScannerConfig*)cPtr).scanStringDq;
  }

  @property void scanStringDq(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scanStringDq = propval;
  }

  @property uint numbers2Int()
  {
    return (cast(GScannerConfig*)cPtr).numbers2Int;
  }

  @property void numbers2Int(uint propval)
  {
    (cast(GScannerConfig*)cPtr).numbers2Int = propval;
  }

  @property uint int2Float()
  {
    return (cast(GScannerConfig*)cPtr).int2Float;
  }

  @property void int2Float(uint propval)
  {
    (cast(GScannerConfig*)cPtr).int2Float = propval;
  }

  @property uint identifier2String()
  {
    return (cast(GScannerConfig*)cPtr).identifier2String;
  }

  @property void identifier2String(uint propval)
  {
    (cast(GScannerConfig*)cPtr).identifier2String = propval;
  }

  @property uint char2Token()
  {
    return (cast(GScannerConfig*)cPtr).char2Token;
  }

  @property void char2Token(uint propval)
  {
    (cast(GScannerConfig*)cPtr).char2Token = propval;
  }

  @property uint symbol2Token()
  {
    return (cast(GScannerConfig*)cPtr).symbol2Token;
  }

  @property void symbol2Token(uint propval)
  {
    (cast(GScannerConfig*)cPtr).symbol2Token = propval;
  }

  @property uint scope0Fallback()
  {
    return (cast(GScannerConfig*)cPtr).scope0Fallback;
  }

  @property void scope0Fallback(uint propval)
  {
    (cast(GScannerConfig*)cPtr).scope0Fallback = propval;
  }

  @property uint storeInt64()
  {
    return (cast(GScannerConfig*)cPtr).storeInt64;
  }

  @property void storeInt64(uint propval)
  {
    (cast(GScannerConfig*)cPtr).storeInt64 = propval;
  }
}
