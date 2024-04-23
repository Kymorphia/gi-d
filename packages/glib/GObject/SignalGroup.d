module GObject.SignalGroup;

import GObject.Closure;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * #GSignalGroup manages to simplify the process of connecting
 * many signals to a #GObject as a group. As such there is no API
 * to disconnect a signal from the group.
 *
 * In particular, this allows you to:
 *
 * - Change the target instance, which automatically causes disconnection
 * of the signals from the old instance and connecting to the new instance.
 * - Block and unblock signals as a group
 * - Ensuring that blocked state transfers across target instances.
 *
 * One place you might want to use such a structure is with #GtkTextView and
 * #GtkTextBuffer. Often times, you'll need to connect to many signals on
 * #GtkTextBuffer from a #GtkTextView subclass. This allows you to create a
 * signal group during instance construction, simply bind the
 * #GtkTextView:buffer property to #GSignalGroup:target and connect
 * all the signals you need. When the #GtkTextView:buffer property changes
 * all of the signals will be transitioned correctly.
 */
class SignalGroup : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_signal_group_get_type();
  }

  /**
   * a new #GSignalGroup
   */
  this(GType targetType)
  {
    GSignalGroup* _cretval;
    _cretval = g_signal_group_new(targetType);
    this(_cretval, true);
  }

  /**
   * Blocks all signal handlers managed by @self so they will not
   * be called during any signal emissions. Must be unblocked exactly
   * the same number of times it has been blocked to become active again.
   *
   * This blocked state will be kept across changes of the target instance.
   */
  void block()
  {
    g_signal_group_block(cPtr!GSignalGroup);
  }

  /**
   * Connects @closure to the signal @detailed_signal on #GSignalGroup:target.
   *
   * You cannot connect a signal handler after #GSignalGroup:target has been set.
   */
  void connectClosure(string detailedSignal, Closure closure, bool after)
  {
    const(char)* _detailedSignal = detailedSignal.toCString(false);
    g_signal_group_connect_closure(cPtr!GSignalGroup, _detailedSignal, closure ? closure.cPtr!GClosure : null, after);
  }

  /**
   * The target instance
   */
  ObjectG dupTarget()
  {
    ObjectC* _cretval;
    _cretval = g_signal_group_dup_target(cPtr!GSignalGroup);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  /**
   * Sets the target instance used when connecting signals. Any signal
   * that has been registered with g_signal_group_connect_object() or
   * similar functions will be connected to this object.
   *
   * If the target instance was previously set, signals will be
   * disconnected from that object prior to connecting to @target.
   */
  void setTarget(ObjectG target)
  {
    g_signal_group_set_target(cPtr!GSignalGroup, target ? target.cPtr!ObjectC : null);
  }

  /**
   * Unblocks all signal handlers managed by @self so they will be
   * called again during any signal emissions unless it is blocked
   * again. Must be unblocked exactly the same number of times it
   * has been blocked to become active again.
   */
  void unblock()
  {
    g_signal_group_unblock(cPtr!GSignalGroup);
  }

  /**
   * This signal is emitted when #GSignalGroup:target is set to a new value
   * other than %NULL. It is similar to #GObject::notify on `target` except it
   * will not emit when #GSignalGroup:target is %NULL and also allows for
   * receiving the #GObject without a data-race.
   */
  ulong connectBind(void delegate(ObjectG instance, SignalGroup signalGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalGroup = getVal!SignalGroup(_paramVals);
      auto instance = getVal!ObjectG(&_paramVals[1]);
      _dgClosure.dlg(instance, signalGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("bind", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal is emitted when the target instance of @self is set to a
   * new #GObject.
   *
   * This signal will only be emitted if the previous target of @self is
   * non-%NULL.
   */
  ulong connectUnbind(void delegate(SignalGroup signalGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalGroup = getVal!SignalGroup(_paramVals);
      _dgClosure.dlg(signalGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unbind", closure, (flags & ConnectFlags.After) != 0);
  }
}
