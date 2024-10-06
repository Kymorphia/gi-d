module GLib.Relation;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GRelation` is a table of data which can be indexed on any number
 * of fields, rather like simple database tables. A `GRelation` contains
 * a number of records, called tuples. Each record contains a number of
 * fields. Records are not ordered, so it is not possible to find the
 * record at a particular index.
 * Note that `GRelation` tables are currently limited to 2 fields.
 * To create a `GRelation`, use [GLib.Relation.new_].
 * To specify which fields should be indexed, use [GLib.Relation.index].
 * Note that this must be called before any tuples are added to the
 * `GRelation`.
 * To add records to a `GRelation` use [GLib.Relation.insert].
 * To determine if a given record appears in a `GRelation`, use
 * [GLib.Relation.exists]. Note that fields are compared directly, so
 * pointers must point to the exact same position $(LPAREN)i.e. different
 * copies of the same string will not match.$(RPAREN)
 * To count the number of records which have a particular value in a
 * given field, use [GLib.Relation.count].
 * To get all the records which have a particular value in a given
 * field, use [GLib.Relation.select]. To access fields of the resulting
 * records, use [GLib.Tuples.index]. To free the resulting records use
 * [GLib.Tuples.destroy].
 * To delete all records which have a particular value in a given
 * field, use [GLib.Relation.delete_].
 * To destroy the `GRelation`, use [GLib.Relation.destroy].
 * To help debug `GRelation` objects, use [GLib.Relation.print].
 * `GRelation` has been marked as deprecated, since this API has never
 * been fully implemented, is not very actively maintained and rarely
 * used.

 * Deprecated: Rarely used API
 */
class Relation
{
  GRelation* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Relation");

    cInstancePtr = cast(GRelation*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Returns the number of tuples in a #GRelation that have the given
   * value in the given field.
   * Params:
   *   key = the value to compare with.
   *   field = the field of each record to match.
   * Returns: the number of matches.

   * Deprecated: Rarely used API
   */
  int count(const(void)* key, int field)
  {
    int _retval;
    _retval = g_relation_count(cast(GRelation*)cPtr, key, field);
    return _retval;
  }

  /**
   * Deletes any records from a #GRelation that have the given key value
   * in the given field.
   * Params:
   *   key = the value to compare with.
   *   field = the field of each record to match.
   * Returns: the number of records deleted.

   * Deprecated: Rarely used API
   */
  int delete_(const(void)* key, int field)
  {
    int _retval;
    _retval = g_relation_delete(cast(GRelation*)cPtr, key, field);
    return _retval;
  }

  /**
   * Destroys the #GRelation, freeing all memory allocated. However, it
   * does not free memory allocated for the tuple data, so you should
   * free that first if appropriate.

   * Deprecated: Rarely used API
   */
  void destroy()
  {
    g_relation_destroy(cast(GRelation*)cPtr);
  }

  /**
   * Outputs information about all records in a #GRelation, as well as
   * the indexes. It is for debugging.

   * Deprecated: Rarely used API
   */
  void print()
  {
    g_relation_print(cast(GRelation*)cPtr);
  }
}
