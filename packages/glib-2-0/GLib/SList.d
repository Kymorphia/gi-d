module GLib.SList;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

import GLib.Boxed;
import GLib.Types;

/**
 * SList ForwardRange template. Creates an object which wraps a GSList of D type (T) items.
 */
/**
 * The #GSList struct is used for each element in the singly-linked
 * list.
 */
class SList(T)
{
  GSList* cPtr; // Front of list
  GidOwnership ownership; // Ownership of the list elements and data

  this(GSList* list, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = list;
    this.ownership = ownership;
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

  SList!(T) save()
  {
    GSList* newList;

    for (auto p = cPtr; p; p = p.next)
      newList = g_slist_prepend(newList, containerCopyItem!T(p.data));

    return new SList!(T)(g_slist_reverse(newList), GidOwnership.Full);
  }
}
