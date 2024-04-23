module GLib.SequenceIter;

import GLib.Sequence;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GSequenceIter struct is an opaque data type representing an
 * iterator pointing into a #GSequence.
 */
class SequenceIter
{
  GSequenceIter* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.SequenceIter");

    cInstancePtr = cast(GSequenceIter*)ptr;

    this.owned = owned;
  }

  T* cPtr(T)()
  if (is(T == GSequenceIter))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * a negative number if @a comes before @b, 0 if they are
   * equal, and a positive number if @a comes after @b
   */
  int compare(SequenceIter b)
  {
    int _retval;
    _retval = g_sequence_iter_compare(cPtr!GSequenceIter, b ? b.cPtr!GSequenceIter : null);
    return _retval;
  }

  /**
   * the position of @iter
   */
  int getPosition()
  {
    int _retval;
    _retval = g_sequence_iter_get_position(cPtr!GSequenceIter);
    return _retval;
  }

  /**
   * the #GSequence that @iter points into
   */
  Sequence getSequence()
  {
    GSequence* _cretval;
    _cretval = g_sequence_iter_get_sequence(cPtr!GSequenceIter);
    Sequence _retval = new Sequence(cast(GSequence*)_cretval, false);
    return _retval;
  }

  /**
   * whether @iter is the begin iterator
   */
  bool isBegin()
  {
    bool _retval;
    _retval = g_sequence_iter_is_begin(cPtr!GSequenceIter);
    return _retval;
  }

  /**
   * Whether @iter is the end iterator
   */
  bool isEnd()
  {
    bool _retval;
    _retval = g_sequence_iter_is_end(cPtr!GSequenceIter);
    return _retval;
  }

  /**
   * a #GSequenceIter which is @delta positions away from @iter
   */
  SequenceIter move(int delta)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_move(cPtr!GSequenceIter, delta);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * a #GSequenceIter pointing to the next position after @iter
   */
  SequenceIter next()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_next(cPtr!GSequenceIter);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }

  /**
   * a #GSequenceIter pointing to the previous position
   * before @iter
   */
  SequenceIter prev()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_prev(cPtr!GSequenceIter);
    SequenceIter _retval = new SequenceIter(cast(GSequenceIter*)_cretval, false);
    return _retval;
  }
}
