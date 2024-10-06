module Gtk.AnyFilter;

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
 * `GtkAnyFilter` matches an item when at least one of its filters matches.
 * To add filters to a `GtkAnyFilter`, use [Gtk.MultiFilter.append].
 */
class AnyFilter : MultiFilter
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_any_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty "any" filter.
   * Use [Gtk.MultiFilter.append] to add filters to it.
   * This filter matches an item if any of the filters added to it
   * matches the item. In particular, this means that if no filter
   * has been added to it, the filter matches no item.
   * Returns: a new `GtkAnyFilter`
   */
  this()
  {
    GtkAnyFilter* _cretval;
    _cretval = gtk_any_filter_new();
    this(_cretval, true);
  }
}
