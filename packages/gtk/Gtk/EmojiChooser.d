module Gtk.EmojiChooser;

import GObject.DClosure;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Popover;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkEmojiChooser` is used by text widgets such as `GtkEntry` or
 * `GtkTextView` to let users insert Emoji characters.
 * ![An example GtkEmojiChooser](emojichooser.png)
 * `GtkEmojiChooser` emits the signal@Gtk.EmojiChooser::emoji-picked
 * signal when an Emoji is selected.
 * # CSS nodes
 * ```
 * popover
 * ├── box.emoji-searchbar
 * │   ╰── entry.search
 * ╰── box.emoji-toolbar
 * ├── button.image-button.emoji-section
 * ├── ...
 * ╰── button.image-button.emoji-section
 * ```
 * Every `GtkEmojiChooser` consists of a main node called popover.
 * The contents of the popover are largely implementation defined
 * and supposed to inherit general styles.
 * The top searchbar used to search emoji and gets the .emoji-searchbar
 * style class itself.
 * The bottom toolbar used to switch between different emoji categories
 * consists of buttons with the .emoji-section style class and gets the
 * .emoji-toolbar style class itself.
 */
class EmojiChooser : Popover
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_emoji_chooser_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkEmojiChooser`.
   * Returns: a new `GtkEmojiChooser`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_emoji_chooser_new();
    this(_cretval, false);
  }

  /**
   * Emitted when the user selects an Emoji.
   * Params
   *   text = the Unicode sequence for the picked Emoji, in UTF-8
   *   emojiChooser = the instance the signal is connected to
   */
  alias EmojiPickedCallback = void delegate(string text, EmojiChooser emojiChooser);

  /**
   * Connect to EmojiPicked signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEmojiPicked(EmojiPickedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto emojiChooser = getVal!EmojiChooser(_paramVals);
      auto text = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(text, emojiChooser);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("emoji-picked", closure, after);
  }
}
