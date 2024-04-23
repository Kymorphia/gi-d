module Gio.MountOperation;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMountOperation provides a mechanism for interacting with the user.
 * It can be used for authenticating mountable operations, such as loop
 * mounting files, hard drive partitions or server locations. It can
 * also be used to ask the user questions or show a list of applications
 * preventing unmount or eject operations from completing.
 *
 * Note that #GMountOperation is used for more than just #GMount
 * objects – for example it is also used in g_drive_start() and
 * g_drive_stop().
 *
 * Users should instantiate a subclass of this that implements all the
 * various callbacks to show the required dialogs, such as
 * #GtkMountOperation. If no user interaction is desired (for example
 * when automounting filesystems at login time), usually %NULL can be
 * passed, see each method taking a #GMountOperation for details.
 *
 * The term ‘TCRYPT’ is used to mean ‘compatible with TrueCrypt and VeraCrypt’.
 * [TrueCrypt](https://en.wikipedia.org/wiki/TrueCrypt) is a discontinued system for
 * encrypting file containers, partitions or whole disks, typically used with Windows.
 * [VeraCrypt](https://www.veracrypt.fr/) is a maintained fork of TrueCrypt with various
 * improvements and auditing fixes.
 */
class MountOperation : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_mount_operation_get_type();
  }

  /**
   * a #GMountOperation.
   */
  this()
  {
    GMountOperation* _cretval;
    _cretval = g_mount_operation_new();
    this(_cretval, true);
  }

  /**
   * %TRUE if mount operation is anonymous.
   */
  bool getAnonymous()
  {
    bool _retval;
    _retval = g_mount_operation_get_anonymous(cPtr!GMountOperation);
    return _retval;
  }

  /**
   * an integer containing an index of the user's choice from
   * the choice's list, or `0`.
   */
  int getChoice()
  {
    int _retval;
    _retval = g_mount_operation_get_choice(cPtr!GMountOperation);
    return _retval;
  }

  /**
   * a string set to the domain.
   */
  string getDomain()
  {
    const(char)* _cretval;
    _cretval = g_mount_operation_get_domain(cPtr!GMountOperation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if mount operation is for hidden volume.
   */
  bool getIsTcryptHiddenVolume()
  {
    bool _retval;
    _retval = g_mount_operation_get_is_tcrypt_hidden_volume(cPtr!GMountOperation);
    return _retval;
  }

  /**
   * %TRUE if mount operation is for system volume.
   */
  bool getIsTcryptSystemVolume()
  {
    bool _retval;
    _retval = g_mount_operation_get_is_tcrypt_system_volume(cPtr!GMountOperation);
    return _retval;
  }

  /**
   * a string containing the password within @op.
   */
  string getPassword()
  {
    const(char)* _cretval;
    _cretval = g_mount_operation_get_password(cPtr!GMountOperation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GPasswordSave flag.
   */
  PasswordSave getPasswordSave()
  {
    GPasswordSave _cretval;
    _cretval = g_mount_operation_get_password_save(cPtr!GMountOperation);
    PasswordSave _retval = cast(PasswordSave)_cretval;
    return _retval;
  }

  /**
   * The VeraCrypt PIM within @op.
   */
  uint getPim()
  {
    uint _retval;
    _retval = g_mount_operation_get_pim(cPtr!GMountOperation);
    return _retval;
  }

  /**
   * a string containing the user name.
   */
  string getUsername()
  {
    const(char)* _cretval;
    _cretval = g_mount_operation_get_username(cPtr!GMountOperation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Emits the #GMountOperation::reply signal.
   */
  void reply(MountOperationResult result)
  {
    g_mount_operation_reply(cPtr!GMountOperation, result);
  }

  /**
   * Sets the mount operation to use an anonymous user if @anonymous is %TRUE.
   */
  void setAnonymous(bool anonymous)
  {
    g_mount_operation_set_anonymous(cPtr!GMountOperation, anonymous);
  }

  /**
   * Sets a default choice for the mount operation.
   */
  void setChoice(int choice)
  {
    g_mount_operation_set_choice(cPtr!GMountOperation, choice);
  }

  /**
   * Sets the mount operation's domain.
   */
  void setDomain(string domain)
  {
    const(char)* _domain = domain.toCString(false);
    g_mount_operation_set_domain(cPtr!GMountOperation, _domain);
  }

  /**
   * Sets the mount operation to use a hidden volume if @hidden_volume is %TRUE.
   */
  void setIsTcryptHiddenVolume(bool hiddenVolume)
  {
    g_mount_operation_set_is_tcrypt_hidden_volume(cPtr!GMountOperation, hiddenVolume);
  }

  /**
   * Sets the mount operation to use a system volume if @system_volume is %TRUE.
   */
  void setIsTcryptSystemVolume(bool systemVolume)
  {
    g_mount_operation_set_is_tcrypt_system_volume(cPtr!GMountOperation, systemVolume);
  }

  /**
   * Sets the mount operation's password to @password.
   */
  void setPassword(string password)
  {
    const(char)* _password = password.toCString(false);
    g_mount_operation_set_password(cPtr!GMountOperation, _password);
  }

  /**
   * Sets the state of saving passwords for the mount operation.
   */
  void setPasswordSave(PasswordSave save)
  {
    g_mount_operation_set_password_save(cPtr!GMountOperation, save);
  }

  /**
   * Sets the mount operation's PIM to @pim.
   */
  void setPim(uint pim)
  {
    g_mount_operation_set_pim(cPtr!GMountOperation, pim);
  }

  /**
   * Sets the user name within @op to @username.
   */
  void setUsername(string username)
  {
    const(char)* _username = username.toCString(false);
    g_mount_operation_set_username(cPtr!GMountOperation, _username);
  }

  /**
   * Emitted by the backend when e.g. a device becomes unavailable
   * while a mount operation is in progress.
   *
   * Implementations of GMountOperation should handle this signal
   * by dismissing open password dialogs.
   */
  ulong connectAborted(void delegate(MountOperation mountOperation) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mountOperation = getVal!MountOperation(_paramVals);
      _dgClosure.dlg(mountOperation);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("aborted", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mount operation asks the user for a password.
   *
   * If the message contains a line break, the first line should be
   * presented as a heading. For example, it may be used as the
   * primary text in a #GtkMessageDialog.
   */
  ulong connectAskPassword(void delegate(string message, string defaultUser, string defaultDomain, AskPasswordFlags flags, MountOperation mountOperation) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mountOperation = getVal!MountOperation(_paramVals);
      auto message = getVal!string(&_paramVals[1]);
      char* _message = message.toCString(false);
      auto defaultUser = getVal!string(&_paramVals[2]);
      char* _defaultUser = defaultUser.toCString(false);
      auto defaultDomain = getVal!string(&_paramVals[3]);
      char* _defaultDomain = defaultDomain.toCString(false);
      auto flags = getVal!AskPasswordFlags(&_paramVals[4]);
      _dgClosure.dlg(message, defaultUser, defaultDomain, flags, mountOperation);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("ask-password", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user has replied to the mount operation.
   */
  ulong connectReply(void delegate(MountOperationResult result, MountOperation mountOperation) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mountOperation = getVal!MountOperation(_paramVals);
      auto result = getVal!MountOperationResult(&_paramVals[1]);
      _dgClosure.dlg(result, mountOperation);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("reply", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when an unmount operation has been busy for more than some time
   * (typically 1.5 seconds).
   *
   * When unmounting or ejecting a volume, the kernel might need to flush
   * pending data in its buffers to the volume stable storage, and this operation
   * can take a considerable amount of time. This signal may be emitted several
   * times as long as the unmount operation is outstanding, and then one
   * last time when the operation is completed, with @bytes_left set to zero.
   *
   * Implementations of GMountOperation should handle this signal by
   * showing an UI notification, and then dismiss it, or show another notification
   * of completion, when @bytes_left reaches zero.
   *
   * If the message contains a line break, the first line should be
   * presented as a heading. For example, it may be used as the
   * primary text in a #GtkMessageDialog.
   */
  ulong connectShowUnmountProgress(void delegate(string message, long timeLeft, long bytesLeft, MountOperation mountOperation) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mountOperation = getVal!MountOperation(_paramVals);
      auto message = getVal!string(&_paramVals[1]);
      char* _message = message.toCString(false);
      auto timeLeft = getVal!long(&_paramVals[2]);
      auto bytesLeft = getVal!long(&_paramVals[3]);
      _dgClosure.dlg(message, timeLeft, bytesLeft, mountOperation);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("show-unmount-progress", closure, (flags & ConnectFlags.After) != 0);
  }
}
