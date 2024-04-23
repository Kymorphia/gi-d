module Gio.TlsPassword;

import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Holds a password used in TLS.
 */
class TlsPassword : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_password_get_type();
  }

  /**
   * The newly allocated password object
   */
  this(TlsPasswordFlags flags, string description)
  {
    GTlsPassword* _cretval;
    const(char)* _description = description.toCString(false);
    _cretval = g_tls_password_new(flags, _description);
    this(_cretval, true);
  }

  /**
   * The description of the password.
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_tls_password_get_description(cPtr!GTlsPassword);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The flags about the password.
   */
  TlsPasswordFlags getFlags()
  {
    GTlsPasswordFlags _cretval;
    _cretval = g_tls_password_get_flags(cPtr!GTlsPassword);
    TlsPasswordFlags _retval = cast(TlsPasswordFlags)_cretval;
    return _retval;
  }

  /**
   * The password value (owned by the password object).
   */
  ubyte[] getValue()
  {
    const(ubyte)* _cretval;
    size_t _cretlength;
    _cretval = g_tls_password_get_value(cPtr!GTlsPassword, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * The warning.
   */
  string getWarning()
  {
    const(char)* _cretval;
    _cretval = g_tls_password_get_warning(cPtr!GTlsPassword);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Set a description string about what the password will be used for.
   */
  void setDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_tls_password_set_description(cPtr!GTlsPassword, _description);
  }

  /**
   * Set flags about the password.
   */
  void setFlags(TlsPasswordFlags flags)
  {
    g_tls_password_set_flags(cPtr!GTlsPassword, flags);
  }

  /**
   * Set the value for this password. The @value will be copied by the password
   * object.
   *
   * Specify the @length, for a non-nul-terminated password. Pass -1 as
   * @length if using a nul-terminated password, and @length will be
   * calculated automatically. (Note that the terminating nul is not
   * considered part of the password in this case.)
   */
  void setValue(ubyte[] value)
  {
    auto _value = cast(const(ubyte)*)value.ptr;
    g_tls_password_set_value(cPtr!GTlsPassword, _value, value ? cast(ptrdiff_t)value.length : 0);
  }

  /**
   * Provide the value for this password.
   *
   * The @value will be owned by the password object, and later freed using
   * the @destroy function callback.
   *
   * Specify the @length, for a non-nul-terminated password. Pass -1 as
   * @length if using a nul-terminated password, and @length will be
   * calculated automatically. (Note that the terminating nul is not
   * considered part of the password in this case.)
   */
  void setValueFull(ubyte[] value, DestroyNotify destroy)
  {
    extern(C) void _destroyCallback(void* data)
    {
      ptrThawGC(data);

      (*(cast(DestroyNotify*)data))();
    }

    auto _value = cast(ubyte*)value.ptr;
    g_tls_password_set_value_full(cPtr!GTlsPassword, _value, value ? cast(ptrdiff_t)value.length : 0, &_destroyCallback);
  }

  /**
   * Set a user readable translated warning. Usually this warning is a
   * representation of the password flags returned from
   * g_tls_password_get_flags().
   */
  void setWarning(string warning)
  {
    const(char)* _warning = warning.toCString(false);
    g_tls_password_set_warning(cPtr!GTlsPassword, _warning);
  }
}
