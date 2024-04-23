module GLib.Sequence;

import GLib.SequenceIter;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GSequence struct is an opaque data type representing a
 * [sequence][glib-Sequences] data type.
 */
class Sequence
{
  GSequence* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Sequence");

    cInstancePtr = cast(GSequence*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_sequence_free(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GSequence))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * an iterator pointing to the new item
   */
  SequenceIter append(void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_append(cPtr!GSequence, data);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * the begin iterator for @seq.
   */
  SequenceIter getBeginIter()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_begin_iter(cPtr!GSequence);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * the end iterator for @seq
   */
  SequenceIter getEndIter()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_end_iter(cPtr!GSequence);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * The #GSequenceIter at position @pos
   */
  SequenceIter getIterAtPos(int pos)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_iter_at_pos(cPtr!GSequence, pos);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * the length of @seq
   */
  int getLength()
  {
    int _retval;
    _retval = g_sequence_get_length(cPtr!GSequence);
    return _retval;
  }

  /**
   * %TRUE if the sequence is empty, otherwise %FALSE.
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = g_sequence_is_empty(cPtr!GSequence);
    return _retval;
  }

  /**
   * an iterator pointing to the new item
   */
  SequenceIter prepend(void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_prepend(cPtr!GSequence, data);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * the data that @iter points to
   */
  static void* get(SequenceIter iter)
  {
    void* _retval;
    _retval = g_sequence_get(iter ? iter.cPtr!GSequenceIter : null);
    return _retval;
  }

  /**
   * an iterator pointing to the new item
   */
  static SequenceIter insertBefore(SequenceIter iter, void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_insert_before(iter ? iter.cPtr!GSequenceIter : null, data);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * Moves the item pointed to by @src to the position indicated by @dest.
   * After calling this function @dest will point to the position immediately
   * after @src. It is allowed for @src and @dest to point into different
   * sequences.
   */
  static void move(SequenceIter src, SequenceIter dest)
  {
    g_sequence_move(src ? src.cPtr!GSequenceIter : null, dest ? dest.cPtr!GSequenceIter : null);
  }

  /**
   * Inserts the (@begin, @end) range at the destination pointed to by @dest.
   * The @begin and @end iters must point into the same sequence. It is
   * allowed for @dest to point to a different sequence than the one pointed
   * into by @begin and @end.
   *
   * If @dest is %NULL, the range indicated by @begin and @end is
   * removed from the sequence. If @dest points to a place within
   * the (@begin, @end) range, the range does not move.
   */
  static void moveRange(SequenceIter dest, SequenceIter begin, SequenceIter end)
  {
    g_sequence_move_range(dest ? dest.cPtr!GSequenceIter : null, begin ? begin.cPtr!GSequenceIter : null, end ? end.cPtr!GSequenceIter : null);
  }

  /**
   * a #GSequenceIter pointing somewhere in the
   * (@begin, @end) range
   */
  static SequenceIter rangeGetMidpoint(SequenceIter begin, SequenceIter end)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_range_get_midpoint(begin ? begin.cPtr!GSequenceIter : null, end ? end.cPtr!GSequenceIter : null);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * Removes the item pointed to by @iter. It is an error to pass the
   * end iterator to this function.
   *
   * If the sequence has a data destroy function associated with it, this
   * function is called on the data for the removed item.
   */
  static void remove(SequenceIter iter)
  {
    g_sequence_remove(iter ? iter.cPtr!GSequenceIter : null);
  }

  /**
   * Removes all items in the (@begin, @end) range.
   *
   * If the sequence has a data destroy function associated with it, this
   * function is called on the data for the removed items.
   */
  static void removeRange(SequenceIter begin, SequenceIter end)
  {
    g_sequence_remove_range(begin ? begin.cPtr!GSequenceIter : null, end ? end.cPtr!GSequenceIter : null);
  }

  /**
   * Changes the data for the item pointed to by @iter to be @data. If
   * the sequence has a data destroy function associated with it, that
   * function is called on the existing data that @iter pointed to.
   */
  static void set(SequenceIter iter, void* data)
  {
    g_sequence_set(iter ? iter.cPtr!GSequenceIter : null, data);
  }

  /**
   * Swaps the items pointed to by @a and @b. It is allowed for @a and @b
   * to point into difference sequences.
   */
  static void swap(SequenceIter a, SequenceIter b)
  {
    g_sequence_swap(a ? a.cPtr!GSequenceIter : null, b ? b.cPtr!GSequenceIter : null);
  }
}
