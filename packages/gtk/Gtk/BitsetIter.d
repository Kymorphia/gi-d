module Gtk.BitsetIter;

import GLib.Boxed;
import Gid.gid;
import Gtk.Bitset;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An opaque, stack-allocated struct for iterating
 * over the elements of a `GtkBitset`.
 * Before a `GtkBitsetIter` can be used, it needs to be initialized with
 * [Gtk.BitsetIter.initFirst], [Gtk.BitsetIter.initLast]
 * or [Gtk.BitsetIter.initAt].
 */
class BitsetIter : Boxed
{

  this()
  {
    super(safeMalloc(GtkBitsetIter.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gtk_bitset_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the current value that iter points to.
   * If iter is not valid and [Gtk.BitsetIter.isValid]
   * returns %FALSE, this function returns 0.
   * Returns: The current value pointer to by iter
   */
  uint getValue()
  {
    uint _retval;
    _retval = gtk_bitset_iter_get_value(cast(GtkBitsetIter*)cPtr);
    return _retval;
  }

  /**
   * Checks if iter points to a valid value.
   * Returns: %TRUE if iter points to a valid value
   */
  bool isValid()
  {
    bool _retval;
    _retval = gtk_bitset_iter_is_valid(cast(GtkBitsetIter*)cPtr);
    return _retval;
  }

  /**
   * Moves iter to the next value in the set.
   * If it was already pointing to the last value in the set,
   * %FALSE is returned and iter is invalidated.
   * Params:
   *   value = Set to the next value
   * Returns: %TRUE if a next value existed
   */
  bool next(out uint value)
  {
    bool _retval;
    _retval = gtk_bitset_iter_next(cast(GtkBitsetIter*)cPtr, cast(uint*)&value);
    return _retval;
  }

  /**
   * Moves iter to the previous value in the set.
   * If it was already pointing to the first value in the set,
   * %FALSE is returned and iter is invalidated.
   * Params:
   *   value = Set to the previous value
   * Returns: %TRUE if a previous value existed
   */
  bool previous(out uint value)
  {
    bool _retval;
    _retval = gtk_bitset_iter_previous(cast(GtkBitsetIter*)cPtr, cast(uint*)&value);
    return _retval;
  }

  /**
   * Initializes iter to point to target.
   * If target is not found, finds the next value after it.
   * If no value >\= target exists in set, this function returns %FALSE.
   * Params:
   *   iter = a pointer to an uninitialized `GtkBitsetIter`
   *   set = a `GtkBitset`
   *   target = target value to start iterating at
   *   value = Set to the found value in set
   * Returns: %TRUE if a value was found.
   */
  static bool initAt(out BitsetIter iter, Bitset set, uint target, out uint value)
  {
    bool _retval;
    GtkBitsetIter _iter;
    _retval = gtk_bitset_iter_init_at(&_iter, set ? cast(GtkBitset*)set.cPtr(false) : null, target, cast(uint*)&value);
    iter = new BitsetIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Initializes an iterator for set and points it to the first
   * value in set.
   * If set is empty, %FALSE is returned and value is set to %G_MAXUINT.
   * Params:
   *   iter = a pointer to an uninitialized `GtkBitsetIter`
   *   set = a `GtkBitset`
   *   value = Set to the first value in set
   * Returns: %TRUE if set isn't empty.
   */
  static bool initFirst(out BitsetIter iter, Bitset set, out uint value)
  {
    bool _retval;
    GtkBitsetIter _iter;
    _retval = gtk_bitset_iter_init_first(&_iter, set ? cast(GtkBitset*)set.cPtr(false) : null, cast(uint*)&value);
    iter = new BitsetIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Initializes an iterator for set and points it to the last
   * value in set.
   * If set is empty, %FALSE is returned.
   * Params:
   *   iter = a pointer to an uninitialized `GtkBitsetIter`
   *   set = a `GtkBitset`
   *   value = Set to the last value in set
   * Returns: %TRUE if set isn't empty.
   */
  static bool initLast(out BitsetIter iter, Bitset set, out uint value)
  {
    bool _retval;
    GtkBitsetIter _iter;
    _retval = gtk_bitset_iter_init_last(&_iter, set ? cast(GtkBitset*)set.cPtr(false) : null, cast(uint*)&value);
    iter = new BitsetIter(cast(void*)&_iter, false);
    return _retval;
  }
}
