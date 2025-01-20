module GLib.SequenceIter;

import GLib.Sequence;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Returns a negative number if a comes before b, 0 if they are equal,
   * and a positive number if a comes after b.
   * The a and b iterators must point into the same sequence.
   * Params:
   *   b = a #GSequenceIter
   * Returns: a negative number if a comes before b, 0 if they are
   *   equal, and a positive number if a comes after b
   */
  int compare(SequenceIter b)
  {
    int _retval;
    _retval = g_sequence_iter_compare(cast(GSequenceIter*)cPtr, b ? cast(GSequenceIter*)b.cPtr : null);
    return _retval;
  }

  /**
   * Returns the position of iter
   * Returns: the position of iter
   */
  int getPosition()
  {
    int _retval;
    _retval = g_sequence_iter_get_position(cast(GSequenceIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the #GSequence that iter points into.
   * Returns: the #GSequence that iter points into
   */
  Sequence getSequence()
  {
    GSequence* _cretval;
    _cretval = g_sequence_iter_get_sequence(cast(GSequenceIter*)cPtr);
    auto _retval = _cretval ? new Sequence(cast(GSequence*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether iter is the begin iterator
   * Returns: whether iter is the begin iterator
   */
  bool isBegin()
  {
    bool _retval;
    _retval = g_sequence_iter_is_begin(cast(GSequenceIter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether iter is the end iterator
   * Returns: Whether iter is the end iterator
   */
  bool isEnd()
  {
    bool _retval;
    _retval = g_sequence_iter_is_end(cast(GSequenceIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the #GSequenceIter which is delta positions away from iter.
   * If iter is closer than -delta positions to the beginning of the sequence,
   * the begin iterator is returned. If iter is closer than delta positions
   * to the end of the sequence, the end iterator is returned.
   * Params:
   *   delta = A positive or negative number indicating how many positions away
   *     from iter the returned #GSequenceIter will be
   * Returns: a #GSequenceIter which is delta positions away from iter
   */
  SequenceIter move(int delta)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_move(cast(GSequenceIter*)cPtr, delta);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns an iterator pointing to the next position after iter.
   * If iter is the end iterator, the end iterator is returned.
   * Returns: a #GSequenceIter pointing to the next position after iter
   */
  SequenceIter next()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_next(cast(GSequenceIter*)cPtr);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns an iterator pointing to the previous position before iter.
   * If iter is the begin iterator, the begin iterator is returned.
   * Returns: a #GSequenceIter pointing to the previous position
   *   before iter
   */
  SequenceIter prev()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_iter_prev(cast(GSequenceIter*)cPtr);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }
}
