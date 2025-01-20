import GLib.Boxed;
import GLib.Types;

/**
 * List BidirectionalRange template. Creates an object which wraps a GList of D type (T) items.
 */
class List(T)
{
  GList* cPtr; // Front of list
  private GList* _backItem; // Back of list, will be null if not initialized or empty (cPtr also null)
  GidOwnership ownership; // Ownership of the list elements and data

  this(GList* list, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = list;
    this.ownership = ownership;
  }

  ~this()
  {
    if (ownership == GidOwnership.None)
      return;

    if (ownership == GidOwnership.Container)
      g_list_free(cPtr);

    while (cPtr)
      popFront;
  }

  bool empty() const
  {
    return cPtr is null;
  }

  T front()
  {
    return containerGetItem!T(cPtr.data);
  }

  T back()
  {
    if (!_backItem && cPtr)
      _backItem = g_list_last(cPtr);

    return containerGetItem!T(_backItem.data);
  }

  void popFront()
  {
    if (cPtr)
    {
      auto p = cPtr;
      cPtr = cPtr.next;

      if (cPtr)
        cPtr.prev = null;

      containerFreeItem!T(p.data);
      g_list_free_1(p);
    }
  }

  void popBack()
  {
    if (!_backItem && cPtr)
      _backItem = g_list_last(cPtr);

    if (_backItem)
    {
      auto p = _backItem;
      _backItem = _backItem.prev;

      if (_backItem)
        _backItem.next = null;

      containerFreeItem!T(p.data);
      g_list_free_1(p);
    }
  }

  List!(T) save()
  {
    GList* newList;

    for (auto p = cPtr; p; p = p.next)
      newList = g_list_prepend(newList, containerCopyItem!T(p.data));

    return new List!(T)(g_list_reverse(newList), GidOwnership.Full);
  }
}
