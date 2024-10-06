module Gtk.IMContextSimple;

import Gid.gid;
import Gtk.IMContext;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkIMContextSimple` is an input method supporting table-based input methods.
 * ## Compose sequences
 * `GtkIMContextSimple` reads compose sequences from the first of the
 * following files that is found: ~/.config/gtk-4.0/Compose, ~/.XCompose,
 * /usr/share/X11/locale/\$locale/Compose $(LPAREN)for locales that have a nontrivial
 * Compose file$(RPAREN). A subset of the file syntax described in the Compose$(LPAREN)5$(RPAREN)
 * manual page is supported. Additionally, `include "%L"` loads GTK’s built-in
 * table of compose sequences rather than the locale-specific one from X11.
 * If none of these files is found, `GtkIMContextSimple` uses a built-in table
 * of compose sequences that is derived from the X11 Compose files.
 * Note that compose sequences typically start with the Compose_key, which is
 * often not available as a dedicated key on keyboards. Keyboard layouts may
 * map this keysym to other keys, such as the right Control key.
 * ## Unicode characters
 * `GtkIMContextSimple` also supports numeric entry of Unicode characters
 * by typing <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>u</kbd>, followed by a
 * hexadecimal Unicode codepoint.
 * For example,
 * Ctrl-Shift-u 1 2 3 Enter
 * yields U+0123 LATIN SMALL LETTER G WITH CEDILLA, i.e. ģ.
 * ## Dead keys
 * `GtkIMContextSimple` supports dead keys. For example, typing
 * dead_acute a
 * yields U+00E! LATIN SMALL LETTER_A WITH ACUTE, i.e. á. Note that this
 * depends on the keyboard layout including dead keys.
 */
class IMContextSimple : IMContext
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_im_context_simple_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkIMContextSimple`.
   * Returns: a new `GtkIMContextSimple`
   */
  this()
  {
    GtkIMContext* _cretval;
    _cretval = gtk_im_context_simple_new();
    this(_cretval, true);
  }

  /**
   * Adds an additional table from the X11 compose file.
   * Params:
   *   composeFile = The path of compose file
   */
  void addComposeFile(string composeFile)
  {
    const(char)* _composeFile = composeFile.toCString(false);
    gtk_im_context_simple_add_compose_file(cast(GtkIMContextSimple*)cPtr, _composeFile);
  }
}
