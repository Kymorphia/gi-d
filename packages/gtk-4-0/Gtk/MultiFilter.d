module Gtk.MultiFilter;

import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Filter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkMultiFilter` is the base class for filters that combine multiple filters.
 */
class MultiFilter : Filter, ListModel, Buildable
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
    return gtk_multi_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin BuildableT!();

  /**
   * Adds a filter to self to use for matching.
   * Params:
   *   filter = A new filter to use
   */
  void append(Filter filter)
  {
    gtk_multi_filter_append(cast(GtkMultiFilter*)cPtr, filter ? cast(GtkFilter*)filter.cPtr(true) : null);
  }

  /**
   * Removes the filter at the given position from the list of filters used
   * by self.
   * If position is larger than the number of filters, nothing happens and
   * the function returns.
   * Params:
   *   position = position of filter to remove
   */
  void remove(uint position)
  {
    gtk_multi_filter_remove(cast(GtkMultiFilter*)cPtr, position);
  }
}
