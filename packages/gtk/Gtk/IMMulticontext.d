module Gtk.IMMulticontext;

import Gid.gid;
import Gtk.IMContext;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkIMMulticontext` is an input method context supporting multiple,
 * switchable input methods.
 * Text widgets such as `GtkText` or `GtkTextView` use a `GtkIMMultiContext`
 * to implement their `im-module` property for switching between different
 * input methods.
 */
class IMMulticontext : IMContext
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_im_multicontext_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkIMMulticontext`.
   * Returns: a new `GtkIMMulticontext`.
   */
  this()
  {
    GtkIMContext* _cretval;
    _cretval = gtk_im_multicontext_new();
    this(_cretval, true);
  }

  /**
   * Gets the id of the currently active delegate of the context.
   * Returns: the id of the currently active delegate
   */
  string getContextId()
  {
    const(char)* _cretval;
    _cretval = gtk_im_multicontext_get_context_id(cast(GtkIMMulticontext*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets the context id for context.
   * This causes the currently active delegate of context to be
   * replaced by the delegate corresponding to the new context id.
   * Setting this to a non-%NULL value overrides the system-wide
   * IM module setting. See the propertyGtk.Settings:gtk-im-module
   * property.
   * Params:
   *   contextId = the id to use
   */
  void setContextId(string contextId)
  {
    const(char)* _contextId = contextId.toCString(false);
    gtk_im_multicontext_set_context_id(cast(GtkIMMulticontext*)cPtr, _contextId);
  }
}
