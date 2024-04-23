module Gio.PropertyAction;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
import Gio.ActionT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GPropertyAction is a way to get a #GAction with a state value
 * reflecting and controlling the value of a #GObject property.
 *
 * The state of the action will correspond to the value of the property.
 * Changing it will change the property (assuming the requested value
 * matches the requirements as specified in the #GParamSpec).
 *
 * Only the most common types are presently supported.  Booleans are
 * mapped to booleans, strings to strings, signed/unsigned integers to
 * int32/uint32 and floats and doubles to doubles.
 *
 * If the property is an enum then the state will be string-typed and
 * conversion will automatically be performed between the enum value and
 * "nick" string as per the #GEnumValue table.
 *
 * Flags types are not currently supported.
 *
 * Properties of object types, boxed types and pointer types are not
 * supported and probably never will be.
 *
 * Properties of #GVariant types are not currently supported.
 *
 * If the property is boolean-valued then the action will have a NULL
 * parameter type, and activating the action (with no parameter) will
 * toggle the value of the property.
 *
 * In all other cases, the parameter type will correspond to the type of
 * the property.
 *
 * The general idea here is to reduce the number of locations where a
 * particular piece of state is kept (and therefore has to be synchronised
 * between). #GPropertyAction does not have a separate state that is kept
 * in sync with the property value -- its state is the property value.
 *
 * For example, it might be useful to create a #GAction corresponding to
 * the "visible-child-name" property of a #GtkStack so that the current
 * page can be switched from a menu.  The active radio indication in the
 * menu is then directly determined from the active page of the
 * #GtkStack.
 *
 * An anti-example would be binding the "active-id" property on a
 * #GtkComboBox.  This is because the state of the combobox itself is
 * probably uninteresting and is actually being used to control
 * something else.
 *
 * Another anti-example would be to bind to the "visible-child-name"
 * property of a #GtkStack if this value is actually stored in
 * #GSettings.  In that case, the real source of the value is
 * #GSettings.  If you want a #GAction to control a setting stored in
 * #GSettings, see g_settings_create_action() instead, and possibly
 * combine its use with g_settings_bind().
 */
class PropertyAction : ObjectG, Action
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_property_action_get_type();
  }

  mixin ActionT!GPropertyAction;

  /**
   * a new #GPropertyAction
   */
  this(string name, ObjectG object, string propertyName)
  {
    GPropertyAction* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_property_action_new(_name, object ? object.cPtr!ObjectC : null, _propertyName);
    this(_cretval, true);
  }
}
