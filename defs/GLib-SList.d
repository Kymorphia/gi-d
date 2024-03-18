import GLib.Boxed;
import GLib.global;

/**
 * SList ForwardRange template. Creates an object which wraps a GSList of C type (CT) items into a D type (T) items.
 */
class SList(T, CT)
{
  GSList* cPtr; // Front of list
  GidOwnership ownership; // Ownership of the list elements and data

  this(GList* list, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = list;
    self.ownership = ownership;
  }

  ~this()
  {
    if (ownership == GidOwnership.None)
      return;

    if (ownership == GidOwnership.Container)
      g_slist_free(cPtr);

    while (cPtr)
      popFront;
  }

  bool empty() const
  {
    return cPtr is null;
  }

  T front()
  {
    return containerGetItem!T(cPtr);
  }

  void popFront()
  {
    if (cPtr)
    {
      auto p = cPtr;
      cPtr = cPtr.next;

      containerFreeItem!T(p.data);
      g_slist_free_1(p);
    }
  }

  List!(T, CT) save()
  {
    GSList* newList;

    for (auto p = cPtr; p; p = p.next)
      newList = g_slist_prepend(newList, containerCopyItem!T(p.data));

    return new SList!(T, CT)(g_slist_reverse(newList), GidOwnership.Full);
  }
}
