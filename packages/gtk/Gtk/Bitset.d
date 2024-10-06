module Gtk.Bitset;

import GLib.Boxed;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkBitset` represents a set of unsigned integers.
 * Another name for this data structure is "bitmap".
 * The current implementation is based on [roaring bitmaps](https://roaringbitmap.org/).
 * A bitset allows adding a set of integers and provides support for set operations
 * like unions, intersections and checks for equality or if a value is contained
 * in the set. `GtkBitset` also contains various functions to query metadata about
 * the bitset, such as the minimum or maximum values or its size.
 * The fastest way to iterate values in a bitset is [Gtk.BitsetIter].
 * The main use case for `GtkBitset` is implementing complex selections for
 * [Gtk.SelectionModel].
 */
class Bitset : Boxed
{

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
    return gtk_bitset_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty bitset.
   * Returns: A new empty bitset
   */
  static Bitset newEmpty()
  {
    GtkBitset* _cretval;
    _cretval = gtk_bitset_new_empty();
    auto _retval = _cretval ? new Bitset(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a bitset with the given range set.
   * Params:
   *   start = first value to add
   *   nItems = number of consecutive values to add
   * Returns: A new bitset
   */
  static Bitset newRange(uint start, uint nItems)
  {
    GtkBitset* _cretval;
    _cretval = gtk_bitset_new_range(start, nItems);
    auto _retval = _cretval ? new Bitset(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds value to self if it wasn't part of it before.
   * Params:
   *   value = value to add
   * Returns: %TRUE if value was not part of self and self
   *   was changed
   */
  bool add(uint value)
  {
    bool _retval;
    _retval = gtk_bitset_add(cast(GtkBitset*)cPtr, value);
    return _retval;
  }

  /**
   * Adds all values from start $(LPAREN)inclusive$(RPAREN) to start + n_items
   * $(LPAREN)exclusive$(RPAREN) in self.
   * Params:
   *   start = first value to add
   *   nItems = number of consecutive values to add
   */
  void addRange(uint start, uint nItems)
  {
    gtk_bitset_add_range(cast(GtkBitset*)cPtr, start, nItems);
  }

  /**
   * Adds the closed range [first, last], so first, last and all
   * values in between. first must be smaller than last.
   * Params:
   *   first = first value to add
   *   last = last value to add
   */
  void addRangeClosed(uint first, uint last)
  {
    gtk_bitset_add_range_closed(cast(GtkBitset*)cPtr, first, last);
  }

  /**
   * Interprets the values as a 2-dimensional boolean grid with the given stride
   * and inside that grid, adds a rectangle with the given width and height.
   * Params:
   *   start = first value to add
   *   width = width of the rectangle
   *   height = height of the rectangle
   *   stride = row stride of the grid
   */
  void addRectangle(uint start, uint width, uint height, uint stride)
  {
    gtk_bitset_add_rectangle(cast(GtkBitset*)cPtr, start, width, height, stride);
  }

  /**
   * Checks if the given value has been added to self
   * Params:
   *   value = the value to check
   * Returns: %TRUE if self contains value
   */
  bool contains(uint value)
  {
    bool _retval;
    _retval = gtk_bitset_contains(cast(GtkBitset*)cPtr, value);
    return _retval;
  }

  /**
   * Creates a copy of self.
   * Returns: A new bitset that contains the same
   *   values as self
   */
  Bitset copy()
  {
    GtkBitset* _cretval;
    _cretval = gtk_bitset_copy(cast(GtkBitset*)cPtr);
    auto _retval = _cretval ? new Bitset(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets self to be the symmetric difference of self and other.
   * The symmetric difference is set self to contain all values that
   * were either contained in self or in other, but not in both.
   * This operation is also called an XOR.
   * It is allowed for self and other to be the same bitset. The bitset
   * will be emptied in that case.
   * Params:
   *   other = the `GtkBitset` to compute the difference from
   */
  void difference(Bitset other)
  {
    gtk_bitset_difference(cast(GtkBitset*)cPtr, other ? cast(GtkBitset*)other.cPtr(false) : null);
  }

  /**
   * Returns %TRUE if self and other contain the same values.
   * Params:
   *   other = another `GtkBitset`
   * Returns: %TRUE if self and other contain the same values
   */
  bool equals(Bitset other)
  {
    bool _retval;
    _retval = gtk_bitset_equals(cast(GtkBitset*)cPtr, other ? cast(GtkBitset*)other.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the largest value in self.
   * If self is empty, 0 is returned.
   * Returns: The largest value in self
   */
  uint getMaximum()
  {
    uint _retval;
    _retval = gtk_bitset_get_maximum(cast(GtkBitset*)cPtr);
    return _retval;
  }

  /**
   * Returns the smallest value in self.
   * If self is empty, `G_MAXUINT` is returned.
   * Returns: The smallest value in self
   */
  uint getMinimum()
  {
    uint _retval;
    _retval = gtk_bitset_get_minimum(cast(GtkBitset*)cPtr);
    return _retval;
  }

  /**
   * Returns the value of the nth item in self.
   * If nth is >\= the size of self, 0 is returned.
   * Params:
   *   nth = index of the item to get
   * Returns: the value of the nth item in self
   */
  uint getNth(uint nth)
  {
    uint _retval;
    _retval = gtk_bitset_get_nth(cast(GtkBitset*)cPtr, nth);
    return _retval;
  }

  /**
   * Gets the number of values that were added to the set.
   * For example, if the set is empty, 0 is returned.
   * Note that this function returns a `guint64`, because when all
   * values are set, the return value is `G_MAXUINT + 1`. Unless you
   * are sure this cannot happen $(LPAREN)it can't with `GListModel`$(RPAREN), be sure
   * to use a 64bit type.
   * Returns: The number of values in the set.
   */
  ulong getSize()
  {
    ulong _retval;
    _retval = gtk_bitset_get_size(cast(GtkBitset*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of values that are part of the set from first to last
   * $(LPAREN)inclusive$(RPAREN).
   * Note that this function returns a `guint64`, because when all values are
   * set, the return value is `G_MAXUINT + 1`. Unless you are sure this cannot
   * happen $(LPAREN)it can't with `GListModel`$(RPAREN), be sure to use a 64bit type.
   * Params:
   *   first = the first element to include
   *   last = the last element to include
   * Returns: The number of values in the set from first to last.
   */
  ulong getSizeInRange(uint first, uint last)
  {
    ulong _retval;
    _retval = gtk_bitset_get_size_in_range(cast(GtkBitset*)cPtr, first, last);
    return _retval;
  }

  /**
   * Sets self to be the intersection of self and other.
   * In other words, remove all values from self that are not part of other.
   * It is allowed for self and other to be the same bitset. Nothing will
   * happen in that case.
   * Params:
   *   other = the `GtkBitset` to intersect with
   */
  void intersect(Bitset other)
  {
    gtk_bitset_intersect(cast(GtkBitset*)cPtr, other ? cast(GtkBitset*)other.cPtr(false) : null);
  }

  /**
   * Check if no value is contained in bitset.
   * Returns: %TRUE if self is empty
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = gtk_bitset_is_empty(cast(GtkBitset*)cPtr);
    return _retval;
  }

  /**
   * Removes value from self if it was part of it before.
   * Params:
   *   value = value to remove
   * Returns: %TRUE if value was part of self and self
   *   was changed
   */
  bool remove(uint value)
  {
    bool _retval;
    _retval = gtk_bitset_remove(cast(GtkBitset*)cPtr, value);
    return _retval;
  }

  /**
   * Removes all values from the bitset so that it is empty again.
   */
  void removeAll()
  {
    gtk_bitset_remove_all(cast(GtkBitset*)cPtr);
  }

  /**
   * Removes all values from start $(LPAREN)inclusive$(RPAREN) to start + n_items $(LPAREN)exclusive$(RPAREN)
   * in self.
   * Params:
   *   start = first value to remove
   *   nItems = number of consecutive values to remove
   */
  void removeRange(uint start, uint nItems)
  {
    gtk_bitset_remove_range(cast(GtkBitset*)cPtr, start, nItems);
  }

  /**
   * Removes the closed range [first, last], so first, last and all
   * values in between. first must be smaller than last.
   * Params:
   *   first = first value to remove
   *   last = last value to remove
   */
  void removeRangeClosed(uint first, uint last)
  {
    gtk_bitset_remove_range_closed(cast(GtkBitset*)cPtr, first, last);
  }

  /**
   * Interprets the values as a 2-dimensional boolean grid with the given stride
   * and inside that grid, removes a rectangle with the given width and height.
   * Params:
   *   start = first value to remove
   *   width = width of the rectangle
   *   height = height of the rectangle
   *   stride = row stride of the grid
   */
  void removeRectangle(uint start, uint width, uint height, uint stride)
  {
    gtk_bitset_remove_rectangle(cast(GtkBitset*)cPtr, start, width, height, stride);
  }

  /**
   * Shifts all values in self to the left by amount.
   * Values smaller than amount are discarded.
   * Params:
   *   amount = amount to shift all values to the left
   */
  void shiftLeft(uint amount)
  {
    gtk_bitset_shift_left(cast(GtkBitset*)cPtr, amount);
  }

  /**
   * Shifts all values in self to the right by amount.
   * Values that end up too large to be held in a #guint are discarded.
   * Params:
   *   amount = amount to shift all values to the right
   */
  void shiftRight(uint amount)
  {
    gtk_bitset_shift_right(cast(GtkBitset*)cPtr, amount);
  }

  /**
   * This is a support function for `GListModel` handling, by mirroring
   * the `GlistModel::items-changed` signal.
   * First, it "cuts" the values from position to removed from
   * the bitset. That is, it removes all those values and shifts
   * all larger values to the left by removed places.
   * Then, it "pastes" new room into the bitset by shifting all values
   * larger than position by added spaces to the right. This frees
   * up space that can then be filled.
   * Params:
   *   position = position at which to slice
   *   removed = number of values to remove
   *   added = number of values to add
   */
  void splice(uint position, uint removed, uint added)
  {
    gtk_bitset_splice(cast(GtkBitset*)cPtr, position, removed, added);
  }

  /**
   * Sets self to be the subtraction of other from self.
   * In other words, remove all values from self that are part of other.
   * It is allowed for self and other to be the same bitset. The bitset
   * will be emptied in that case.
   * Params:
   *   other = the `GtkBitset` to subtract
   */
  void subtract(Bitset other)
  {
    gtk_bitset_subtract(cast(GtkBitset*)cPtr, other ? cast(GtkBitset*)other.cPtr(false) : null);
  }

  /**
   * Sets self to be the union of self and other.
   * That is, add all values from other into self that weren't part of it.
   * It is allowed for self and other to be the same bitset. Nothing will
   * happen in that case.
   * Params:
   *   other = the `GtkBitset` to union with
   */
  void union_(Bitset other)
  {
    gtk_bitset_union(cast(GtkBitset*)cPtr, other ? cast(GtkBitset*)other.cPtr(false) : null);
  }
}
