module Gio.ListModel;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GListModel is an interface that represents a mutable list of
 * #GObjects. Its main intention is as a model for various widgets in
 * user interfaces, such as list views, but it can also be used as a
 * convenient method of returning lists of data, with support for
 * updates.
 *
 * Each object in the list may also report changes in itself via some
 * mechanism (normally the #GObject::notify signal).  Taken together
 * with the #GListModel::items-changed signal, this provides for a list
 * that can change its membership, and in which the members can change
 * their individual properties.
 *
 * A good example would be the list of visible wireless network access
 * points, where each access point can report dynamic properties such as
 * signal strength.
 *
 * It is important to note that the #GListModel itself does not report
 * changes to the individual items.  It only reports changes to the list
 * membership.  If you want to observe changes to the objects themselves
 * then you need to connect signals to the objects that you are
 * interested in.
 *
 * All items in a #GListModel are of (or derived from) the same type.
 * g_list_model_get_item_type() returns that type.  The type may be an
 * interface, in which case all objects in the list must implement it.
 *
 * The semantics are close to that of an array:
 * g_list_model_get_n_items() returns the number of items in the list and
 * g_list_model_get_item() returns an item at a (0-based) position. In
 * order to allow implementations to calculate the list length lazily,
 * you can also iterate over items: starting from 0, repeatedly call
 * g_list_model_get_item() until it returns %NULL.
 *
 * An implementation may create objects lazily, but must take care to
 * return the same object for a given position until all references to
 * it are gone.
 *
 * On the other side, a consumer is expected only to hold references on
 * objects that are currently "user visible", in order to facilitate the
 * maximum level of laziness in the implementation of the list and to
 * reduce the required number of signal connections at a given time.
 *
 * This interface is intended only to be used from a single thread.  The
 * thread in which it is appropriate to use it depends on the particular
 * implementation, but typically it will be from the thread that owns
 * the [thread-default main context][g-main-context-push-thread-default]
 * in effect at the time that the model was created.
 *
 * Over time, it has established itself as good practice for listmodel
 * implementations to provide properties `item-type` and `n-items` to
 * ease working with them. While it is not required, it is recommended
 * that implementations provide these two properties. They should return
 * the values of g_list_model_get_item_type() and g_list_model_get_n_items()
 * respectively and be defined as such:
 * |[<!-- language="C" -->
 * properties[PROP_ITEM_TYPE] =
 * g_param_spec_gtype ("item-type", "", "", G_TYPE_OBJECT,
 * G_PARAM_CONSTRUCT_ONLY | G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS);
 * properties[PROP_N_ITEMS] =
 * g_param_spec_uint ("n-items", "", "", 0, G_MAXUINT, 0,
 * G_PARAM_READABLE | G_PARAM_STATIC_STRINGS);
 * ]|
 */
interface ListModel
{

  static GType getType()
  {
    return g_list_model_get_type();
  }

  /**
   * the #GType of the items contained in @list.
   */
  GType getItemType();

  /**
   * the number of items in @list.
   */
  uint getNItems();

  /**
   * the object at @position.
   */
  ObjectG getItem(uint position);

  /**
   * Emits the #GListModel::items-changed signal on @list.
   *
   * This function should only be called by classes implementing
   * #GListModel. It has to be called after the internal representation
   * of @list has been updated, because handlers connected to this signal
   * might query the new state of the list.
   *
   * Implementations must only make changes to the model (as visible to
   * its consumer) in places that will not cause problems for that
   * consumer.  For models that are driven directly by a write API (such
   * as #GListStore), changes can be reported in response to uses of that
   * API.  For models that represent remote data, changes should only be
   * made from a fresh mainloop dispatch.  It is particularly not
   * permitted to make changes in response to a call to the #GListModel
   * consumer API.
   *
   * Stated another way: in general, it is assumed that code making a
   * series of accesses to the model via the API, without returning to the
   * mainloop, and without calling other code, will continue to view the
   * same contents of the model.
   */
  void itemsChanged(uint position, uint removed, uint added);

  /**
   * This signal is emitted whenever items were added to or removed
   * from @list. At @position, @removed items were removed and @added
   * items were added in their place.
   *
   * Note: If `removed != added`, the positions of all later items
   * in the model change.
   */
  ulong connectItemsChanged(void delegate(uint position, uint removed, uint added, ListModel listModel) dlg, ConnectFlags flags = ConnectFlags.Default);
}
