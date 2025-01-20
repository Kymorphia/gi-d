module Gtk.PasswordEntryBuffer;

import Gid.gid;
import Gtk.EntryBuffer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkEntryBuffer` that locks the underlying memory to prevent it
 * from being swapped to disk.
 * `GtkPasswordEntry` uses a `GtkPasswordEntryBuffer`.
 */
class PasswordEntryBuffer : EntryBuffer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_password_entry_buffer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkEntryBuffer` using secure memory allocations.
   * Returns: the newly created instance
   */
  this()
  {
    GtkEntryBuffer* _cretval;
    _cretval = gtk_password_entry_buffer_new();
    this(_cretval, true);
  }
}
