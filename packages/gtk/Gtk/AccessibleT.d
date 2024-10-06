module Gtk.AccessibleT;

public import GObject.ObjectG;
public import GObject.Value;
public import Gid.gid;
public import Gtk.ATContext;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkAccessible` is an interface for describing UI elements for
 * Assistive Technologies.
 * Every accessible implementation has:
 * - a “role”, represented by a value of the [Gtk] enumeration
 * - an “attribute”, represented by a set of [Gtk],
 * [Gtk] and [Gtk] values
 * The role cannot be changed after instantiating a `GtkAccessible`
 * implementation.
 * The attributes are updated every time a UI element's state changes in
 * a way that should be reflected by assistive technologies. For instance,
 * if a `GtkWidget` visibility changes, the %GTK_ACCESSIBLE_STATE_HIDDEN
 * state will also change to reflect the [Gtk.Widget.visible] property.
 * Every accessible implementation is part of a tree of accessible objects.
 * Normally, this tree corresponds to the widget tree, but can be customized
 * by reimplementing the vfunc@Gtk.Accessible.get_accessible_parent,
 * vfunc@Gtk.Accessible.get_first_accessible_child and
 * vfunc@Gtk.Accessible.get_next_accessible_sibling virtual functions.
 * Note that you can not create a top-level accessible object as of now,
 * which means that you must always have a parent accessible object.
 * Also note that when an accessible object does not correspond to a widget,
 * and it has children, whose implementation you don't control,
 * it is necessary to ensure the correct shape of the a11y tree
 * by calling [Gtk.Accessible.setAccessibleParent] and
 * updating the sibling by [Gtk.Accessible.updateNextAccessibleSibling].
 */
template AccessibleT(TStruct)
{

  /**
   * Requests the user's screen reader to announce the given message.
   * This kind of notification is useful for messages that
   * either have only a visual representation or that are not
   * exposed visually at all, e.g. a notification about a
   * successful operation.
   * Also, by using this API, you can ensure that the message
   * does not interrupts the user's current screen reader output.
   * Params:
   *   message = the string to announce
   *   priority = the priority of the announcement
   */
  override void announce(string message, AccessibleAnnouncementPriority priority)
  {
    const(char)* _message = message.toCString(false);
    gtk_accessible_announce(cast(GtkAccessible*)cPtr, _message, priority);
  }

  /**
   * Retrieves the accessible parent for an accessible object.
   * This function returns `NULL` for top level widgets.
   * Returns: the accessible parent
   */
  override Accessible getAccessibleParent()
  {
    GtkAccessible* _cretval;
    _cretval = gtk_accessible_get_accessible_parent(cast(GtkAccessible*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Accessible(cast(GtkAccessible*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the accessible role of an accessible object.
   * Returns: the accessible role
   */
  override AccessibleRole getAccessibleRole()
  {
    GtkAccessibleRole _cretval;
    _cretval = gtk_accessible_get_accessible_role(cast(GtkAccessible*)cPtr);
    AccessibleRole _retval = cast(AccessibleRole)_cretval;
    return _retval;
  }

  /**
   * Retrieves the accessible implementation for the given `GtkAccessible`.
   * Returns: the accessible implementation object
   */
  override ATContext getAtContext()
  {
    GtkATContext* _cretval;
    _cretval = gtk_accessible_get_at_context(cast(GtkAccessible*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ATContext(cast(GtkATContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the coordinates and dimensions of this accessible
   * This functionality can be overridden by `GtkAccessible`
   * implementations, e.g. to get the bounds from an ignored
   * child widget.
   * Params:
   *   x = the x coordinate of the top left corner of the accessible
   *   y = the y coordinate of the top left corner of the widget
   *   width = the width of the accessible object
   *   height = the height of the accessible object
   * Returns: true if the bounds are valid, and false otherwise
   */
  override bool getBounds(out int x, out int y, out int width, out int height)
  {
    bool _retval;
    _retval = gtk_accessible_get_bounds(cast(GtkAccessible*)cPtr, cast(int*)&x, cast(int*)&y, cast(int*)&width, cast(int*)&height);
    return _retval;
  }

  /**
   * Retrieves the first accessible child of an accessible object.
   * Returns: the first accessible child
   */
  override Accessible getFirstAccessibleChild()
  {
    GtkAccessible* _cretval;
    _cretval = gtk_accessible_get_first_accessible_child(cast(GtkAccessible*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Accessible(cast(GtkAccessible*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the next accessible sibling of an accessible object
   * Returns: the next accessible sibling
   */
  override Accessible getNextAccessibleSibling()
  {
    GtkAccessible* _cretval;
    _cretval = gtk_accessible_get_next_accessible_sibling(cast(GtkAccessible*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Accessible(cast(GtkAccessible*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Query a platform state, such as focus.
   * See gtk_accessible_platform_changed$(LPAREN)$(RPAREN).
   * This functionality can be overridden by `GtkAccessible`
   * implementations, e.g. to get platform state from an ignored
   * child widget, as is the case for `GtkText` wrappers.
   * Params:
   *   state = platform state to query
   * Returns: the value of state for the accessible
   */
  override bool getPlatformState(AccessiblePlatformState state)
  {
    bool _retval;
    _retval = gtk_accessible_get_platform_state(cast(GtkAccessible*)cPtr, state);
    return _retval;
  }

  /**
   * Resets the accessible property to its default value.
   * Params:
   *   property = a `GtkAccessibleProperty`
   */
  override void resetProperty(AccessibleProperty property)
  {
    gtk_accessible_reset_property(cast(GtkAccessible*)cPtr, property);
  }

  /**
   * Resets the accessible relation to its default value.
   * Params:
   *   relation = a `GtkAccessibleRelation`
   */
  override void resetRelation(AccessibleRelation relation)
  {
    gtk_accessible_reset_relation(cast(GtkAccessible*)cPtr, relation);
  }

  /**
   * Resets the accessible state to its default value.
   * Params:
   *   state = a `GtkAccessibleState`
   */
  override void resetState(AccessibleState state)
  {
    gtk_accessible_reset_state(cast(GtkAccessible*)cPtr, state);
  }

  /**
   * Sets the parent and sibling of an accessible object.
   * This function is meant to be used by accessible implementations that are
   * not part of the widget hierarchy, and but act as a logical bridge between
   * widgets. For instance, if a widget creates an object that holds metadata
   * for each child, and you want that object to implement the `GtkAccessible`
   * interface, you will use this function to ensure that the parent of each
   * child widget is the metadata object, and the parent of each metadata
   * object is the container widget.
   * Params:
   *   parent = the parent accessible object
   *   nextSibling = the sibling accessible object
   */
  override void setAccessibleParent(Accessible parent, Accessible nextSibling)
  {
    gtk_accessible_set_accessible_parent(cast(GtkAccessible*)cPtr, parent ? cast(GtkAccessible*)(cast(ObjectG)parent).cPtr(false) : null, nextSibling ? cast(GtkAccessible*)(cast(ObjectG)nextSibling).cPtr(false) : null);
  }

  /**
   * Updates the next accessible sibling of self.
   * That might be useful when a new child of a custom `GtkAccessible`
   * is created, and it needs to be linked to a previous child.
   * Params:
   *   newSibling = the new next accessible sibling to set
   */
  override void updateNextAccessibleSibling(Accessible newSibling)
  {
    gtk_accessible_update_next_accessible_sibling(cast(GtkAccessible*)cPtr, newSibling ? cast(GtkAccessible*)(cast(ObjectG)newSibling).cPtr(false) : null);
  }

  /**
   * Updates an array of accessible properties.
   * This function should be called by `GtkWidget` types whenever an accessible
   * property change must be communicated to assistive technologies.
   * This function is meant to be used by language bindings.
   * Params:
   *   properties = an array of `GtkAccessibleProperty`
   *   values = an array of `GValues`, one for each property
   */
  override void updateProperty(AccessibleProperty[] properties, Value[] values)
  {
    int _nProperties;
    if (properties)
      _nProperties = cast(int)properties.length;

    auto _properties = cast(GtkAccessibleProperty*)properties.ptr;
    if (values)
      _nProperties = cast(int)values.length;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *cast(GValue*)obj.cPtr;
    const(GValue)* _values = _tmpvalues.ptr;
    gtk_accessible_update_property_value(cast(GtkAccessible*)cPtr, _nProperties, _properties, _values);
  }

  /**
   * Updates an array of accessible relations.
   * This function should be called by `GtkWidget` types whenever an accessible
   * relation change must be communicated to assistive technologies.
   * This function is meant to be used by language bindings.
   * Params:
   *   relations = an array of `GtkAccessibleRelation`
   *   values = an array of `GValues`, one for each relation
   */
  override void updateRelation(AccessibleRelation[] relations, Value[] values)
  {
    int _nRelations;
    if (relations)
      _nRelations = cast(int)relations.length;

    auto _relations = cast(GtkAccessibleRelation*)relations.ptr;
    if (values)
      _nRelations = cast(int)values.length;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *cast(GValue*)obj.cPtr;
    const(GValue)* _values = _tmpvalues.ptr;
    gtk_accessible_update_relation_value(cast(GtkAccessible*)cPtr, _nRelations, _relations, _values);
  }

  /**
   * Updates an array of accessible states.
   * This function should be called by `GtkWidget` types whenever an accessible
   * state change must be communicated to assistive technologies.
   * This function is meant to be used by language bindings.
   * Params:
   *   states = an array of `GtkAccessibleState`
   *   values = an array of `GValues`, one for each state
   */
  override void updateState(AccessibleState[] states, Value[] values)
  {
    int _nStates;
    if (states)
      _nStates = cast(int)states.length;

    auto _states = cast(GtkAccessibleState*)states.ptr;
    if (values)
      _nStates = cast(int)values.length;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *cast(GValue*)obj.cPtr;
    const(GValue)* _values = _tmpvalues.ptr;
    gtk_accessible_update_state_value(cast(GtkAccessible*)cPtr, _nStates, _states, _values);
  }
}
