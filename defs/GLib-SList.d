import gid;
import GLib.c.functions;
import GLib.c.types;

/**
 * List range template. Creates an object which wraps a GSList of C type (CT) items into a D type (T) items.
 */
class List(T, CT)
{
  this(GSList* list, GidOwnership ownership = None)
  {
    _list = _curItem = list;
    _ownership = ownership;
  }

  ~this()
  {
    if (_ownership == GidOwnership.None)
      return;

    if (_ownership == GidOwnership.Container)
    {
      g_list_free(_list);
      return;
    }

    while (_list)
    {
      auto p = _list;
      _list = g_list_remove_link(_list, _list);
      g_list_free_1(p);

      static if (is(T : ObjectG) || is(T == interface) || is(T : Boxed))
        T.free(cast(CT)_list.data);
      else static if (is(T : string))
        g_free(_list.data);
      else
        assert(0, "Unhandled List type " ~ T.stringof);
    }
  }

  @property bool empty() const
  {
    return _curItem is null;
  }

  @property T front()
  {
    static if (is(T : ObjectG) || is(T == interface) || is(T : Boxed))
      return new T(cast(CT)_list.data, ownership == GidOwnership.Full);
    else static if (is(T : string))
      g_free(_list.data);
  }

  void popFront()
  {
    if (_curItem)
      _curItem = _curItem.next;
  }

private:
  GSList* _list; // Root of list
  GSList* _curItem; // Current range item
  GidOwnership _ownership; // Ownership of the list and item data
}
