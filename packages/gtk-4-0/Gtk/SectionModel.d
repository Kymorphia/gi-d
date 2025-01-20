module Gtk.SectionModel;

public import Gtk.SectionModelIfaceProxy;
import GObject.DClosure;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSectionModel` is an interface that adds support for sections to list models.
 * A `GtkSectionModel` groups successive items into so-called sections. List widgets
 * like `GtkListView` and `GtkGridView` then allow displaying section headers for
 * these sections by installing a header factory.
 * Many GTK list models support sections inherently, or they pass through the sections
 * of a model they are wrapping.
 * When the section groupings of a model change, the model will emit the
 * signal@Gtk.SectionModel::sections-changed signal by calling the
 * [Gtk.SectionModel.sectionsChanged] function. All sections in the given range
 * then need to be queried again.
 * The signal@Gio.ListModel::items-changed signal has the same effect, all sections in
 * that range are invalidated, too.
 */
interface SectionModel
{

  static GType getType()
  {
    return gtk_section_model_get_type();
  }

  /**
   * Query the section that covers the given position. The number of
   * items in the section can be computed by `out_end - out_start`.
   * If the position is larger than the number of items, a single
   * range from n_items to G_MAXUINT will be returned.
   * Params:
   *   position = the position of the item to query
   *   outStart = the position of the first item in the section
   *   outEnd = the position of the first item not part of the section
   *     anymore.
   */
  void getSection(uint position, out uint outStart, out uint outEnd);

  void sectionsChanged(uint position, uint nItems);

  /**
   * Emitted when the start-of-section state of some of the items in model changes.
   * Note that this signal does not specify the new section state of the
   * items, they need to be queried manually. It is also not necessary for
   * a model to change the section state of any of the items in the section
   * model, though it would be rather useless to emit such a signal.
   * The signalGio.ListModel::items-changed implies the effect of the
   * signalGtk.SectionModel::sections-changed signal for all the items
   * it covers.
   * Params
   *   position = The first item that may have changed
   *   nItems = number of items with changes
   *   sectionModel = the instance the signal is connected to
   */
  alias SectionsChangedCallback = void delegate(uint position, uint nItems, SectionModel sectionModel);

  /**
   * Connect to SectionsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSectionsChanged(SectionsChangedCallback dlg, Flag!"After" after = No.After);
}
