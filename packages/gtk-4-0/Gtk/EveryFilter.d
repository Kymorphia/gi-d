module Gtk.EveryFilter;

import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.MultiFilter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEveryFilter` matches an item when each of its filters matches.
 * To add filters to a `GtkEveryFilter`, use [Gtk.MultiFilter.append].
 */
class EveryFilter : MultiFilter
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_every_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty "every" filter.
   * Use [Gtk.MultiFilter.append] to add filters to it.
   * This filter matches an item if each of the filters added to it
   * matches the item. In particular, this means that if no filter
   * has been added to it, the filter matches every item.
   * Returns: a new `GtkEveryFilter`
   */
  this()
  {
    GtkEveryFilter* _cretval;
    _cretval = gtk_every_filter_new();
    this(_cretval, true);
  }
}
