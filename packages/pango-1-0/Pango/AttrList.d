module Pango.AttrList;

import GLib.Boxed;
import GLib.SList;
import Gid.gid;
import Pango.AttrIterator;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoAttrList` represents a list of attributes that apply to a section
 * of text.
 * The attributes in a `PangoAttrList` are, in general, allowed to overlap in
 * an arbitrary fashion. However, if the attributes are manipulated only through
 * [Pango.AttrList.change], the overlap between properties will meet
 * stricter criteria.
 * Since the `PangoAttrList` structure is stored as a linear list, it is not
 * suitable for storing attributes for large amounts of text. In general, you
 * should not use a single `PangoAttrList` for more than one paragraph of text.
 */
class AttrList : Boxed
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
    return pango_attr_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new empty attribute list with a reference
   * count of one.
   * Returns: the newly allocated
   *   `PangoAttrList`, which should be freed with
   *   [Pango.AttrList.unref]
   */
  this()
  {
    PangoAttrList* _cretval;
    _cretval = pango_attr_list_new();
    this(_cretval, true);
  }

  /**
   * Insert the given attribute into the `PangoAttrList`.
   * It will replace any attributes of the same type
   * on that segment and be merged with any adjoining
   * attributes that are identical.
   * This function is slower than [Pango.AttrList.insert]
   * for creating an attribute list in order $(LPAREN)potentially
   * much slower for large lists$(RPAREN). However,
   * [Pango.AttrList.insert] is not suitable for
   * continually changing a set of attributes since it
   * never removes or combines existing attributes.
   * Params:
   *   attr = the attribute to insert
   */
  void change(Attribute attr)
  {
    pango_attr_list_change(cast(PangoAttrList*)cPtr, attr ? cast(PangoAttribute*)attr.cPtr(true) : null);
  }

  /**
   * Copy list and return an identical new list.
   * Returns: the newly allocated
   *   `PangoAttrList`, with a reference count of one,
   *   which should be freed with [Pango.AttrList.unref].
   *   Returns %NULL if list was %NULL.
   */
  AttrList copy()
  {
    PangoAttrList* _cretval;
    _cretval = pango_attr_list_copy(cast(PangoAttrList*)cPtr);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether list and other_list contain the same
   * attributes and whether those attributes apply to the
   * same ranges.
   * Beware that this will return wrong values if any list
   * contains duplicates.
   * Params:
   *   otherList = the other `PangoAttrList`
   * Returns: %TRUE if the lists are equal, %FALSE if
   *   they aren't
   */
  bool equal(AttrList otherList)
  {
    bool _retval;
    _retval = pango_attr_list_equal(cast(PangoAttrList*)cPtr, otherList ? cast(PangoAttrList*)otherList.cPtr(false) : null);
    return _retval;
  }

  /**
   * Given a `PangoAttrList` and callback function, removes
   * any elements of list for which func returns %TRUE and
   * inserts them into a new list.
   * Params:
   *   func = callback function;
   *     returns %TRUE if an attribute should be filtered out
   * Returns: the new
   *   `PangoAttrList` or %NULL if no attributes of the
   *   given types were found
   */
  AttrList filter(AttrFilterFunc func)
  {
    static AttrFilterFunc _static_func;

    extern(C) bool _funcCallback(PangoAttribute* attribute, void* userData)
    {
      bool _retval = _static_func(attribute ? new Attribute(cast(void*)attribute, false) : null);
      return _retval;
    }

    _static_func = func;
    PangoAttrList* _cretval;
    auto _func = freezeDelegate(cast(void*)&func);
    _cretval = pango_attr_list_filter(cast(PangoAttrList*)cPtr, &_funcCallback, _func);
    _static_func = null;
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of all attributes in list.
   * Returns: a list of all attributes in list. To free this value,
   *   call [Pango.Attribute.destroy] on each value and
   *   [GLib.SList.free] on the list.
   */
  SList!(Attribute) getAttributes()
  {
    GSList* _cretval;
    _cretval = pango_attr_list_get_attributes(cast(PangoAttrList*)cPtr);
    SList!(Attribute) _retval = new SList!(Attribute)(cast(GSList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Create a iterator initialized to the beginning of the list.
   * list must not be modified until this iterator is freed.
   * Returns: the newly allocated
   *   `PangoAttrIterator`, which should be freed with
   *   [Pango.AttrIterator.destroy]
   */
  AttrIterator getIterator()
  {
    PangoAttrIterator* _cretval;
    _cretval = pango_attr_list_get_iterator(cast(PangoAttrList*)cPtr);
    auto _retval = _cretval ? new AttrIterator(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Insert the given attribute into the `PangoAttrList`.
   * It will be inserted after all other attributes with a
   * matching start_index.
   * Params:
   *   attr = the attribute to insert
   */
  void insert(Attribute attr)
  {
    pango_attr_list_insert(cast(PangoAttrList*)cPtr, attr ? cast(PangoAttribute*)attr.cPtr(true) : null);
  }

  /**
   * Insert the given attribute into the `PangoAttrList`.
   * It will be inserted before all other attributes with a
   * matching start_index.
   * Params:
   *   attr = the attribute to insert
   */
  void insertBefore(Attribute attr)
  {
    pango_attr_list_insert_before(cast(PangoAttrList*)cPtr, attr ? cast(PangoAttribute*)attr.cPtr(true) : null);
  }

  /**
   * This function opens up a hole in list, fills it
   * in with attributes from the left, and then merges
   * other on top of the hole.
   * This operation is equivalent to stretching every attribute
   * that applies at position pos in list by an amount len,
   * and then calling [Pango.AttrList.change] with a copy
   * of each attribute in other in sequence $(LPAREN)offset in position
   * by pos, and limited in length to len$(RPAREN).
   * This operation proves useful for, for instance, inserting
   * a pre-edit string in the middle of an edit buffer.
   * For backwards compatibility, the function behaves differently
   * when len is 0. In this case, the attributes from other are
   * not imited to len, and are just overlayed on top of list.
   * This mode is useful for merging two lists of attributes together.
   * Params:
   *   other = another `PangoAttrList`
   *   pos = the position in list at which to insert other
   *   len = the length of the spliced segment. $(LPAREN)Note that this
   *     must be specified since the attributes in other may only
   *     be present at some subsection of this range$(RPAREN)
   */
  void splice(AttrList other, int pos, int len)
  {
    pango_attr_list_splice(cast(PangoAttrList*)cPtr, other ? cast(PangoAttrList*)other.cPtr(false) : null, pos, len);
  }

  /**
   * Serializes a `PangoAttrList` to a string.
   * In the resulting string, serialized attributes are separated by newlines or commas.
   * Individual attributes are serialized to a string of the form
   * START END TYPE VALUE
   * Where START and END are the indices $(LPAREN)with -1 being accepted in place
   * of MAXUINT$(RPAREN), TYPE is the nickname of the attribute value type, e.g.
   * _weight_ or _stretch_, and the value is serialized according to its type:
   * - enum values as nick or numeric value
   * - boolean values as _true_ or _false_
   * - integers and floats as numbers
   * - strings as string, optionally quoted
   * - font features as quoted string
   * - PangoLanguage as string
   * - PangoFontDescription as serialized by [Pango.FontDescription.toString_], quoted
   * - PangoColor as serialized by [Pango.Color.toString_]
   * Examples:
   * ```
   * 0 10 foreground red, 5 15 weight bold, 0 200 font-desc "Sans 10"
   * ```
   * ```
   * 0 -1 weight 700
   * 0 100 family Times
   * ```
   * To parse the returned value, use [Pango.AttrList.fromString].
   * Note that shape attributes can not be serialized.
   * Returns: a newly allocated string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = pango_attr_list_to_string(cast(PangoAttrList*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Update indices of attributes in list for a change in the
   * text they refer to.
   * The change that this function applies is removing remove
   * bytes at position pos and inserting add bytes instead.
   * Attributes that fall entirely in the $(LPAREN)pos, pos + remove$(RPAREN)
   * range are removed.
   * Attributes that start or end inside the $(LPAREN)pos, pos + remove$(RPAREN)
   * range are shortened to reflect the removal.
   * Attributes start and end positions are updated if they are
   * behind pos + remove.
   * Params:
   *   pos = the position of the change
   *   remove = the number of removed bytes
   *   add = the number of added bytes
   */
  void update(int pos, int remove, int add)
  {
    pango_attr_list_update(cast(PangoAttrList*)cPtr, pos, remove, add);
  }

  /**
   * Deserializes a `PangoAttrList` from a string.
   * This is the counterpart to [Pango.AttrList.toString_].
   * See that functions for details about the format.
   * Params:
   *   text = a string
   * Returns: a new `PangoAttrList`
   */
  static AttrList fromString(string text)
  {
    PangoAttrList* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = pango_attr_list_from_string(_text);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
