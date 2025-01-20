module Gio.PropertyAction;

import GObject.ObjectG;
import Gid.gid;
import Gio.Action;
import Gio.ActionT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GPropertyAction` is a way to get a [Gio.Action] with a state value
 * reflecting and controlling the value of a [GObject.ObjectG] property.
 * The state of the action will correspond to the value of the property.
 * Changing it will change the property $(LPAREN)assuming the requested value
 * matches the requirements as specified in the [GObject.ParamSpec]$(RPAREN).
 * Only the most common types are presently supported.  Booleans are
 * mapped to booleans, strings to strings, signed/unsigned integers to
 * int32/uint32 and floats and doubles to doubles.
 * If the property is an enum then the state will be string-typed and
 * conversion will automatically be performed between the enum value and
 * ‘nick’ string as per the [GObject.EnumValue] table.
 * Flags types are not currently supported.
 * Properties of object types, boxed types and pointer types are not
 * supported and probably never will be.
 * Properties of [GLib.Variant] types are not currently supported.
 * If the property is boolean-valued then the action will have a `NULL`
 * parameter type, and activating the action $(LPAREN)with no parameter$(RPAREN) will
 * toggle the value of the property.
 * In all other cases, the parameter type will correspond to the type of
 * the property.
 * The general idea here is to reduce the number of locations where a
 * particular piece of state is kept $(LPAREN)and therefore has to be synchronised
 * between$(RPAREN). `GPropertyAction` does not have a separate state that is kept
 * in sync with the property value — its state is the property value.
 * For example, it might be useful to create a [Gio.Action] corresponding
 * to the `visible-child-name` property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html)
 * so that the current page can be switched from a menu.  The active radio
 * indication in the menu is then directly determined from the active page of
 * the `GtkStack`.
 * An anti-example would be binding the `active-id` property on a
 * [`GtkComboBox`](https://docs.gtk.org/gtk4/class.ComboBox.html). This is
 * because the state of the combo box itself is probably uninteresting and is
 * actually being used to control something else.
 * Another anti-example would be to bind to the `visible-child-name`
 * property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html) if
 * this value is actually stored in [Gio.Settings].  In that case, the
 * real source of the value is* [Gio.Settings].  If you want
 * a [Gio.Action] to control a setting stored in [Gio.Settings],
 * see [Gio.Settings.createAction] instead, and possibly combine its
 * use with [Gio.Settings.bind].
 */
class PropertyAction : ObjectG, Action
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_property_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionT!();

  /**
   * Creates a #GAction corresponding to the value of property
   * property_name on object.
   * The property must be existent and readable and writable $(LPAREN)and not
   * construct-only$(RPAREN).
   * This function takes a reference on object and doesn't release it
   * until the action is destroyed.
   * Params:
   *   name = the name of the action to create
   *   object = the object that has the property
   *     to wrap
   *   propertyName = the name of the property
   * Returns: a new #GPropertyAction
   */
  this(string name, ObjectG object, string propertyName)
  {
    GPropertyAction* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_property_action_new(_name, object ? cast(ObjectC*)object.cPtr(false) : null, _propertyName);
    this(_cretval, true);
  }
}
