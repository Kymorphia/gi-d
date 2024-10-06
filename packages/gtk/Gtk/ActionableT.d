module Gtk.ActionableT;

public import GLib.Variant;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * The `GtkActionable` interface provides a convenient way of associating
 * widgets with actions.
 * It primarily consists of two properties: property@Gtk.Actionable:action-name
 * and property@Gtk.Actionable:action-target. There are also some convenience
 * APIs for setting these properties.
 * The action will be looked up in action groups that are found among
 * the widgets ancestors. Most commonly, these will be the actions with
 * the “win.” or “app.” prefix that are associated with the
 * `GtkApplicationWindow` or `GtkApplication`, but other action groups that
 * are added with [Gtk.Widget.insertActionGroup] will be consulted
 * as well.
 */
template ActionableT(TStruct)
{

  /**
   * Gets the action name for actionable.
   * Returns: the action name
   */
  override string getActionName()
  {
    const(char)* _cretval;
    _cretval = gtk_actionable_get_action_name(cast(GtkActionable*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the current target value of actionable.
   * Returns: the current target value
   */
  override Variant getActionTargetValue()
  {
    GVariant* _cretval;
    _cretval = gtk_actionable_get_action_target_value(cast(GtkActionable*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Specifies the name of the action with which this widget should be
   * associated.
   * If action_name is %NULL then the widget will be unassociated from
   * any previous action.
   * Usually this function is used when the widget is located $(LPAREN)or will be
   * located$(RPAREN) within the hierarchy of a `GtkApplicationWindow`.
   * Names are of the form “win.save” or “app.quit” for actions on the
   * containing classApplicationWindow or its associated classApplication,
   * respectively. This is the same form used for actions in the [Gio.Menu]
   * associated with the window.
   * Params:
   *   actionName = an action name
   */
  override void setActionName(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    gtk_actionable_set_action_name(cast(GtkActionable*)cPtr, _actionName);
  }

  /**
   * Sets the target value of an actionable widget.
   * If target_value is %NULL then the target value is unset.
   * The target value has two purposes. First, it is used as the parameter
   * to activation of the action associated with the `GtkActionable` widget.
   * Second, it is used to determine if the widget should be rendered as
   * “active” — the widget is active if the state is equal to the given target.
   * Consider the example of associating a set of buttons with a [Gio.Action]
   * with string state in a typical “radio button” situation. Each button
   * will be associated with the same action, but with a different target
   * value for that action. Clicking on a particular button will activate
   * the action with the target of that button, which will typically cause
   * the action’s state to change to that value. Since the action’s state
   * is now equal to the target value of the button, the button will now
   * be rendered as active $(LPAREN)and the other buttons, with different targets,
   * rendered inactive$(RPAREN).
   * Params:
   *   targetValue = a [GLib.Variant] to set as the target value
   */
  override void setActionTargetValue(Variant targetValue)
  {
    gtk_actionable_set_action_target_value(cast(GtkActionable*)cPtr, targetValue ? cast(GVariant*)targetValue.cPtr(false) : null);
  }

  /**
   * Sets the action-name and associated string target value of an
   * actionable widget.
   * detailed_action_name is a string in the format accepted by
   * [Gio.Action.parseDetailedName].
   * Params:
   *   detailedActionName = the detailed action name
   */
  override void setDetailedActionName(string detailedActionName)
  {
    const(char)* _detailedActionName = detailedActionName.toCString(false);
    gtk_actionable_set_detailed_action_name(cast(GtkActionable*)cPtr, _detailedActionName);
  }
}
