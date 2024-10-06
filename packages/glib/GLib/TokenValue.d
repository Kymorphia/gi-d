module GLib.TokenValue;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string vIdentifier()
  {
    return (cast(GTokenValue*)cPtr).vIdentifier.fromCString(false);
  }

  @property void vIdentifier(string propval)
  {
    safeFree(cast(void*)(cast(GTokenValue*)cPtr).vIdentifier);
    (cast(GTokenValue*)cPtr).vIdentifier = propval.toCString(true);
  }

  @property ulong vBinary()
  {
    return (cast(GTokenValue*)cPtr).vBinary;
  }

  @property void vBinary(ulong propval)
  {
    (cast(GTokenValue*)cPtr).vBinary = propval;
  }

  @property ulong vOctal()
  {
    return (cast(GTokenValue*)cPtr).vOctal;
  }

  @property void vOctal(ulong propval)
  {
    (cast(GTokenValue*)cPtr).vOctal = propval;
  }

  @property ulong vInt()
  {
    return (cast(GTokenValue*)cPtr).vInt;
  }

  @property void vInt(ulong propval)
  {
    (cast(GTokenValue*)cPtr).vInt = propval;
  }

  @property ulong vInt64()
  {
    return (cast(GTokenValue*)cPtr).vInt64;
  }

  @property void vInt64(ulong propval)
  {
    (cast(GTokenValue*)cPtr).vInt64 = propval;
  }

  @property double vFloat()
  {
    return (cast(GTokenValue*)cPtr).vFloat;
  }

  @property void vFloat(double propval)
  {
    (cast(GTokenValue*)cPtr).vFloat = propval;
  }

  @property ulong vHex()
  {
    return (cast(GTokenValue*)cPtr).vHex;
  }

  @property void vHex(ulong propval)
  {
    (cast(GTokenValue*)cPtr).vHex = propval;
  }

  @property string vString()
  {
    return (cast(GTokenValue*)cPtr).vString.fromCString(false);
  }

  @property void vString(string propval)
  {
    safeFree(cast(void*)(cast(GTokenValue*)cPtr).vString);
    (cast(GTokenValue*)cPtr).vString = propval.toCString(true);
  }

  @property string vComment()
  {
    return (cast(GTokenValue*)cPtr).vComment.fromCString(false);
  }

  @property void vComment(string propval)
  {
    safeFree(cast(void*)(cast(GTokenValue*)cPtr).vComment);
    (cast(GTokenValue*)cPtr).vComment = propval.toCString(true);
  }

  @property ubyte vChar()
  {
    return (cast(GTokenValue*)cPtr).vChar;
  }

  @property void vChar(ubyte propval)
  {
    (cast(GTokenValue*)cPtr).vChar = propval;
  }

  @property uint vError()
  {
    return (cast(GTokenValue*)cPtr).vError;
  }

  @property void vError(uint propval)
  {
    (cast(GTokenValue*)cPtr).vError = propval;
  }
}
