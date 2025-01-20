module Gdk.KeyEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a key-based device.
 */
class KeyEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.KeyEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts the consumed modifiers from a key event.
   * Returns: the consumed modifiers or event
   */
  ModifierType getConsumedModifiers()
  {
    GdkModifierType _cretval;
    _cretval = gdk_key_event_get_consumed_modifiers(cast(GdkEvent*)cPtr);
    ModifierType _retval = cast(ModifierType)_cretval;
    return _retval;
  }

  /**
   * Extracts the keycode from a key event.
   * Returns: the keycode of event
   */
  uint getKeycode()
  {
    uint _retval;
    _retval = gdk_key_event_get_keycode(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Extracts the keyval from a key event.
   * Returns: the keyval of event
   */
  uint getKeyval()
  {
    uint _retval;
    _retval = gdk_key_event_get_keyval(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Extracts the layout from a key event.
   * Returns: the layout of event
   */
  uint getLayout()
  {
    uint _retval;
    _retval = gdk_key_event_get_layout(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Extracts the shift level from a key event.
   * Returns: the shift level of event
   */
  uint getLevel()
  {
    uint _retval;
    _retval = gdk_key_event_get_level(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Gets a keyval and modifier combination that will match
   * the event.
   * See [Gdk.KeyEvent.matches].
   * Params:
   *   keyval = return location for a keyval
   *   modifiers = return location for modifiers
   * Returns: %TRUE on success
   */
  bool getMatch(out uint keyval, out ModifierType modifiers)
  {
    bool _retval;
    _retval = gdk_key_event_get_match(cast(GdkEvent*)cPtr, cast(uint*)&keyval, &modifiers);
    return _retval;
  }

  /**
   * Extracts whether the key event is for a modifier key.
   * Returns: %TRUE if the event is for a modifier key
   */
  bool isModifier()
  {
    bool _retval;
    _retval = gdk_key_event_is_modifier(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Matches a key event against a keyval and modifiers.
   * This is typically used to trigger keyboard shortcuts such as Ctrl-C.
   * Partial matches are possible where the combination matches
   * if the currently active group is ignored.
   * Note that we ignore Caps Lock for matching.
   * Params:
   *   keyval = the keyval to match
   *   modifiers = the modifiers to match
   * Returns: a `GdkKeyMatch` value describing whether event matches
   */
  KeyMatch matches(uint keyval, ModifierType modifiers)
  {
    GdkKeyMatch _cretval;
    _cretval = gdk_key_event_matches(cast(GdkEvent*)cPtr, keyval, modifiers);
    KeyMatch _retval = cast(KeyMatch)_cretval;
    return _retval;
  }
}
