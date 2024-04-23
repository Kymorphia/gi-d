module GLib.ScannerConfig;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GScannerConfig))
  {
    return cast(T*)&cInstance;
  }

  @property string csetSkipCharacters()
  {
    return cPtr!GScannerConfig.csetSkipCharacters.fromCString(false);
  }

  @property void csetSkipCharacters(string propval)
  {
    g_free(cast(void*)cPtr!GScannerConfig.csetSkipCharacters);
    cPtr!GScannerConfig.csetSkipCharacters = propval.toCString(true);
  }

  @property string csetIdentifierFirst()
  {
    return cPtr!GScannerConfig.csetIdentifierFirst.fromCString(false);
  }

  @property void csetIdentifierFirst(string propval)
  {
    g_free(cast(void*)cPtr!GScannerConfig.csetIdentifierFirst);
    cPtr!GScannerConfig.csetIdentifierFirst = propval.toCString(true);
  }

  @property string csetIdentifierNth()
  {
    return cPtr!GScannerConfig.csetIdentifierNth.fromCString(false);
  }

  @property void csetIdentifierNth(string propval)
  {
    g_free(cast(void*)cPtr!GScannerConfig.csetIdentifierNth);
    cPtr!GScannerConfig.csetIdentifierNth = propval.toCString(true);
  }

  @property string cpairCommentSingle()
  {
    return cPtr!GScannerConfig.cpairCommentSingle.fromCString(false);
  }

  @property void cpairCommentSingle(string propval)
  {
    g_free(cast(void*)cPtr!GScannerConfig.cpairCommentSingle);
    cPtr!GScannerConfig.cpairCommentSingle = propval.toCString(true);
  }

  @property uint caseSensitive()
  {
    return cPtr!GScannerConfig.caseSensitive;
  }

  @property void caseSensitive(uint propval)
  {
    cPtr!GScannerConfig.caseSensitive = propval;
  }

  @property uint skipCommentMulti()
  {
    return cPtr!GScannerConfig.skipCommentMulti;
  }

  @property void skipCommentMulti(uint propval)
  {
    cPtr!GScannerConfig.skipCommentMulti = propval;
  }

  @property uint skipCommentSingle()
  {
    return cPtr!GScannerConfig.skipCommentSingle;
  }

  @property void skipCommentSingle(uint propval)
  {
    cPtr!GScannerConfig.skipCommentSingle = propval;
  }

  @property uint scanCommentMulti()
  {
    return cPtr!GScannerConfig.scanCommentMulti;
  }

  @property void scanCommentMulti(uint propval)
  {
    cPtr!GScannerConfig.scanCommentMulti = propval;
  }

  @property uint scanIdentifier()
  {
    return cPtr!GScannerConfig.scanIdentifier;
  }

  @property void scanIdentifier(uint propval)
  {
    cPtr!GScannerConfig.scanIdentifier = propval;
  }

  @property uint scanIdentifier1char()
  {
    return cPtr!GScannerConfig.scanIdentifier1char;
  }

  @property void scanIdentifier1char(uint propval)
  {
    cPtr!GScannerConfig.scanIdentifier1char = propval;
  }

  @property uint scanIdentifierNULL()
  {
    return cPtr!GScannerConfig.scanIdentifierNULL;
  }

  @property void scanIdentifierNULL(uint propval)
  {
    cPtr!GScannerConfig.scanIdentifierNULL = propval;
  }

  @property uint scanSymbols()
  {
    return cPtr!GScannerConfig.scanSymbols;
  }

  @property void scanSymbols(uint propval)
  {
    cPtr!GScannerConfig.scanSymbols = propval;
  }

  @property uint scanBinary()
  {
    return cPtr!GScannerConfig.scanBinary;
  }

  @property void scanBinary(uint propval)
  {
    cPtr!GScannerConfig.scanBinary = propval;
  }

  @property uint scanOctal()
  {
    return cPtr!GScannerConfig.scanOctal;
  }

  @property void scanOctal(uint propval)
  {
    cPtr!GScannerConfig.scanOctal = propval;
  }

  @property uint scanFloat()
  {
    return cPtr!GScannerConfig.scanFloat;
  }

  @property void scanFloat(uint propval)
  {
    cPtr!GScannerConfig.scanFloat = propval;
  }

  @property uint scanHex()
  {
    return cPtr!GScannerConfig.scanHex;
  }

  @property void scanHex(uint propval)
  {
    cPtr!GScannerConfig.scanHex = propval;
  }

  @property uint scanHexDollar()
  {
    return cPtr!GScannerConfig.scanHexDollar;
  }

  @property void scanHexDollar(uint propval)
  {
    cPtr!GScannerConfig.scanHexDollar = propval;
  }

  @property uint scanStringSq()
  {
    return cPtr!GScannerConfig.scanStringSq;
  }

  @property void scanStringSq(uint propval)
  {
    cPtr!GScannerConfig.scanStringSq = propval;
  }

  @property uint scanStringDq()
  {
    return cPtr!GScannerConfig.scanStringDq;
  }

  @property void scanStringDq(uint propval)
  {
    cPtr!GScannerConfig.scanStringDq = propval;
  }

  @property uint numbers2Int()
  {
    return cPtr!GScannerConfig.numbers2Int;
  }

  @property void numbers2Int(uint propval)
  {
    cPtr!GScannerConfig.numbers2Int = propval;
  }

  @property uint int2Float()
  {
    return cPtr!GScannerConfig.int2Float;
  }

  @property void int2Float(uint propval)
  {
    cPtr!GScannerConfig.int2Float = propval;
  }

  @property uint identifier2String()
  {
    return cPtr!GScannerConfig.identifier2String;
  }

  @property void identifier2String(uint propval)
  {
    cPtr!GScannerConfig.identifier2String = propval;
  }

  @property uint char2Token()
  {
    return cPtr!GScannerConfig.char2Token;
  }

  @property void char2Token(uint propval)
  {
    cPtr!GScannerConfig.char2Token = propval;
  }

  @property uint symbol2Token()
  {
    return cPtr!GScannerConfig.symbol2Token;
  }

  @property void symbol2Token(uint propval)
  {
    cPtr!GScannerConfig.symbol2Token = propval;
  }

  @property uint scope0Fallback()
  {
    return cPtr!GScannerConfig.scope0Fallback;
  }

  @property void scope0Fallback(uint propval)
  {
    cPtr!GScannerConfig.scope0Fallback = propval;
  }

  @property uint storeInt64()
  {
    return cPtr!GScannerConfig.storeInt64;
  }

  @property void storeInt64(uint propval)
  {
    cPtr!GScannerConfig.storeInt64 = propval;
  }
}
