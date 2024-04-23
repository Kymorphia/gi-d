module GLib.TokenValue;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A union holding the value of the token.
 */
class TokenValue
{
  GTokenValue cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TokenValue");

    cInstance = *cast(GTokenValue*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTokenValue))
  {
    return cast(T*)&cInstance;
  }

  @property string vIdentifier()
  {
    return cPtr!GTokenValue.vIdentifier.fromCString(false);
  }

  @property void vIdentifier(string propval)
  {
    g_free(cast(void*)cPtr!GTokenValue.vIdentifier);
    cPtr!GTokenValue.vIdentifier = propval.toCString(true);
  }

  @property ulong vBinary()
  {
    return cPtr!GTokenValue.vBinary;
  }

  @property void vBinary(ulong propval)
  {
    cPtr!GTokenValue.vBinary = propval;
  }

  @property ulong vOctal()
  {
    return cPtr!GTokenValue.vOctal;
  }

  @property void vOctal(ulong propval)
  {
    cPtr!GTokenValue.vOctal = propval;
  }

  @property ulong vInt()
  {
    return cPtr!GTokenValue.vInt;
  }

  @property void vInt(ulong propval)
  {
    cPtr!GTokenValue.vInt = propval;
  }

  @property ulong vInt64()
  {
    return cPtr!GTokenValue.vInt64;
  }

  @property void vInt64(ulong propval)
  {
    cPtr!GTokenValue.vInt64 = propval;
  }

  @property double vFloat()
  {
    return cPtr!GTokenValue.vFloat;
  }

  @property void vFloat(double propval)
  {
    cPtr!GTokenValue.vFloat = propval;
  }

  @property ulong vHex()
  {
    return cPtr!GTokenValue.vHex;
  }

  @property void vHex(ulong propval)
  {
    cPtr!GTokenValue.vHex = propval;
  }

  @property string vString()
  {
    return cPtr!GTokenValue.vString.fromCString(false);
  }

  @property void vString(string propval)
  {
    g_free(cast(void*)cPtr!GTokenValue.vString);
    cPtr!GTokenValue.vString = propval.toCString(true);
  }

  @property string vComment()
  {
    return cPtr!GTokenValue.vComment.fromCString(false);
  }

  @property void vComment(string propval)
  {
    g_free(cast(void*)cPtr!GTokenValue.vComment);
    cPtr!GTokenValue.vComment = propval.toCString(true);
  }

  @property ubyte vChar()
  {
    return cPtr!GTokenValue.vChar;
  }

  @property void vChar(ubyte propval)
  {
    cPtr!GTokenValue.vChar = propval;
  }

  @property uint vError()
  {
    return cPtr!GTokenValue.vError;
  }

  @property void vError(uint propval)
  {
    cPtr!GTokenValue.vError = propval;
  }
}
