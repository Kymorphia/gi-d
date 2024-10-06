module Gio.TlsPassword;

import GLib.Types;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * An abstract interface representing a password used in TLS. Often used in
 * user interaction such as unlocking a key storage token.
 */
class TlsPassword : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_password_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new #GTlsPassword object.
   * Params:
   *   flags = the password flags
   *   description = description of what the password is for
   * Returns: The newly allocated password object
   */
  this(TlsPasswordFlags flags, string description)
  {
    GTlsPassword* _cretval;
    const(char)* _description = description.toCString(false);
    _cretval = g_tls_password_new(flags, _description);
    this(_cretval, true);
  }

  /**
   * Get a description string about what the password will be used for.
   * Returns: The description of the password.
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_tls_password_get_description(cast(GTlsPassword*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Get flags about the password.
   * Returns: The flags about the password.
   */
  TlsPasswordFlags getFlags()
  {
    GTlsPasswordFlags _cretval;
    _cretval = g_tls_password_get_flags(cast(GTlsPassword*)cPtr);
    TlsPasswordFlags _retval = cast(TlsPasswordFlags)_cretval;
    return _retval;
  }

  /**
   * Get the password value. If length is not %NULL then it will be
   * filled in with the length of the password value. $(LPAREN)Note that the
   * password value is not nul-terminated, so you can only pass %NULL
   * for length in contexts where you know the password will have a
   * certain fixed length.$(RPAREN)
   * Returns: The password value $(LPAREN)owned by the password object$(RPAREN).
   */
  ubyte[] getValue()
  {
    const(ubyte)* _cretval;
    size_t _cretlength;
    _cretval = g_tls_password_get_value(cast(GTlsPassword*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Get a user readable translated warning. Usually this warning is a
   * representation of the password flags returned from
   * [Gio.TlsPassword.getFlags].
   * Returns: The warning.
   */
  string getWarning()
  {
    const(char)* _cretval;
    _cretval = g_tls_password_get_warning(cast(GTlsPassword*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Set a description string about what the password will be used for.
   * Params:
   *   description = The description of the password
   */
  void setDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_tls_password_set_description(cast(GTlsPassword*)cPtr, _description);
  }

  /**
   * Set flags about the password.
   * Params:
   *   flags = The flags about the password
   */
  void setFlags(TlsPasswordFlags flags)
  {
    g_tls_password_set_flags(cast(GTlsPassword*)cPtr, flags);
  }

  /**
   * Set the value for this password. The value will be copied by the password
   * object.
   * Specify the length, for a non-nul-terminated password. Pass -1 as
   * length if using a nul-terminated password, and length will be
   * calculated automatically. $(LPAREN)Note that the terminating nul is not
   * considered part of the password in this case.$(RPAREN)
   * Params:
   *   value = the new password value
   */
  void setValue(ubyte[] value)
  {
    ptrdiff_t _length;
    if (value)
      _length = cast(ptrdiff_t)value.length;

    auto _value = cast(const(ubyte)*)value.ptr;
    g_tls_password_set_value(cast(GTlsPassword*)cPtr, _value, _length);
  }

  /**
   * Provide the value for this password.
   * The value will be owned by the password object, and later freed using
   * the destroy function callback.
   * Specify the length, for a non-nul-terminated password. Pass -1 as
   * length if using a nul-terminated password, and length will be
   * calculated automatically. $(LPAREN)Note that the terminating nul is not
   * considered part of the password in this case.$(RPAREN)
   * Params:
   *   value = the value for the password
   *   destroy = a function to use to free the password.
   */
  void setValueFull(ubyte[] value, DestroyNotify destroy)
  {
    extern(C) void _destroyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }

    ptrdiff_t _length;
    if (value)
      _length = cast(ptrdiff_t)value.length;

    auto _value = cast(ubyte*)value.ptr;
    g_tls_password_set_value_full(cast(GTlsPassword*)cPtr, _value, _length, &_destroyCallback);
  }

  /**
   * Set a user readable translated warning. Usually this warning is a
   * representation of the password flags returned from
   * [Gio.TlsPassword.getFlags].
   * Params:
   *   warning = The user readable warning
   */
  void setWarning(string warning)
  {
    const(char)* _warning = warning.toCString(false);
    g_tls_password_set_warning(cast(GTlsPassword*)cPtr, _warning);
  }
}
