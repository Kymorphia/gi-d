module Gtk.TextTag;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A tag that can be applied to text contained in a `GtkTextBuffer`.
 * You may wish to begin by reading the
 * [text widget conceptual overview](section-text-widget.html),
 * which gives an overview of all the objects and data types
 * related to the text widget and how they work together.
 * Tags should be in the [Gtk.TextTagTable] for a given
 * `GtkTextBuffer` before using them with that buffer.
 * [Gtk.TextBuffer.createTag] is the best way to create tags.
 * See “gtk4-demo” for numerous examples.
 * For each property of `GtkTextTag`, there is a “set” property, e.g.
 * “font-set” corresponds to “font”. These “set” properties reflect
 * whether a property has been set or not.
 * They are maintained by GTK and you should not set them independently.
 */
class TextTag : ObjectG
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
    return gtk_text_tag_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkTextTag`.
   * Params:
   *   name = tag name
   * Returns: a new `GtkTextTag`
   */
  this(string name)
  {
    GtkTextTag* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_text_tag_new(_name);
    this(_cretval, true);
  }

  /**
   * Emits the signalGtk.TextTagTable::tag-changed signal on the
   * `GtkTextTagTable` where the tag is included.
   * The signal is already emitted when setting a `GtkTextTag` property.
   * This function is useful for a `GtkTextTag` subclass.
   * Params:
   *   sizeChanged = whether the change affects the `GtkTextView` layout
   */
  void changed(bool sizeChanged)
  {
    gtk_text_tag_changed(cast(GtkTextTag*)cPtr, sizeChanged);
  }

  /**
   * Get the tag priority.
   * Returns: The tag’s priority.
   */
  int getPriority()
  {
    int _retval;
    _retval = gtk_text_tag_get_priority(cast(GtkTextTag*)cPtr);
    return _retval;
  }

  /**
   * Sets the priority of a `GtkTextTag`.
   * Valid priorities start at 0 and go to one less than
   * [Gtk.TextTagTable.getSize]. Each tag in a table
   * has a unique priority; setting the priority of one tag shifts
   * the priorities of all the other tags in the table to maintain
   * a unique priority for each tag.
   * Higher priority tags “win” if two tags both set the same text
   * attribute. When adding a tag to a tag table, it will be assigned
   * the highest priority in the table by default; so normally the
   * precedence of a set of tags is the order in which they were added
   * to the table, or created with [Gtk.TextBuffer.createTag],
   * which adds the tag to the buffer’s table automatically.
   * Params:
   *   priority = the new priority
   */
  void setPriority(int priority)
  {
    gtk_text_tag_set_priority(cast(GtkTextTag*)cPtr, priority);
  }
}
