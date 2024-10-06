module Gtk.ShortcutController;

import GObject.ObjectG;
import Gdk.Types;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.EventController;
import Gtk.Shortcut;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkShortcutController` is an event controller that manages shortcuts.
 * Most common shortcuts are using this controller implicitly, e.g. by
 * adding a mnemonic underline to a [Gtk.Label], or by installing a key
 * binding using [Gtk.WidgetClass.addBinding], or by adding accelerators
 * to global actions using [Gtk.Application.setAccelsForAction].
 * But it is possible to create your own shortcut controller, and add
 * shortcuts to it.
 * `GtkShortcutController` implements [Gio.ListModel] for querying the
 * shortcuts that have been added to it.
 * # GtkShortcutController as GtkBuildable
 * `GtkShortcutController`s can be created in [Gtk.Builder] ui files, to set up
 * shortcuts in the same place as the widgets.
 * An example of a UI definition fragment with `GtkShortcutController`:
 * ```xml
 * <object class\='GtkButton'>
 * <child>
 * <object class\='GtkShortcutController'>
 * <property name\='scope'>managed</property>
 * <child>
 * <object class\='GtkShortcut'>
 * <property name\='trigger'>&lt;Control&gt;k</property>
 * <property name\='action'>activate</property>
 * </object>
 * </child>
 * </object>
 * </child>
 * </object>
 * ```
 * This example creates a [Gtk.ActivateAction] for triggering the
 * `activate` signal of the [Gtk.Button]. See [Gtk.ShortcutAction.parseString]
 * for the syntax for other kinds of [Gtk.ShortcutAction]. See
 * [Gtk.ShortcutTrigger.parseString] to learn more about the syntax
 * for triggers.
 */
class ShortcutController : EventController, ListModel, Buildable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_shortcut_controller_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!GtkShortcutController;
  mixin BuildableT!GtkShortcutController;

  /**
   * Creates a new shortcut controller.
   * Returns: a newly created shortcut controller
   */
  this()
  {
    GtkEventController* _cretval;
    _cretval = gtk_shortcut_controller_new();
    this(_cretval, true);
  }

  /**
   * Creates a new shortcut controller that takes its shortcuts from
   * the given list model.
   * A controller created by this function does not let you add or
   * remove individual shortcuts using the shortcut controller api,
   * but you can change the contents of the model.
   * Params:
   *   model = a `GListModel` containing shortcuts
   * Returns: a newly created shortcut controller
   */
  static ShortcutController newForModel(ListModel model)
  {
    GtkEventController* _cretval;
    _cretval = gtk_shortcut_controller_new_for_model(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutController(cast(GtkEventController*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds shortcut to the list of shortcuts handled by self.
   * If this controller uses an external shortcut list, this
   * function does nothing.
   * Params:
   *   shortcut = a `GtkShortcut`
   */
  void addShortcut(Shortcut shortcut)
  {
    gtk_shortcut_controller_add_shortcut(cast(GtkShortcutController*)cPtr, shortcut ? cast(GtkShortcut*)shortcut.cPtr(true) : null);
  }

  /**
   * Gets the mnemonics modifiers for when this controller activates its shortcuts.
   * Returns: the controller's mnemonics modifiers
   */
  ModifierType getMnemonicsModifiers()
  {
    GdkModifierType _cretval;
    _cretval = gtk_shortcut_controller_get_mnemonics_modifiers(cast(GtkShortcutController*)cPtr);
    ModifierType _retval = cast(ModifierType)_cretval;
    return _retval;
  }

  /**
   * Gets the scope for when this controller activates its shortcuts.
   * See [Gtk.ShortcutController.setScope] for details.
   * Returns: the controller's scope
   */
  ShortcutScope getScope()
  {
    GtkShortcutScope _cretval;
    _cretval = gtk_shortcut_controller_get_scope(cast(GtkShortcutController*)cPtr);
    ShortcutScope _retval = cast(ShortcutScope)_cretval;
    return _retval;
  }

  /**
   * Removes shortcut from the list of shortcuts handled by self.
   * If shortcut had not been added to controller or this controller
   * uses an external shortcut list, this function does nothing.
   * Params:
   *   shortcut = a `GtkShortcut`
   */
  void removeShortcut(Shortcut shortcut)
  {
    gtk_shortcut_controller_remove_shortcut(cast(GtkShortcutController*)cPtr, shortcut ? cast(GtkShortcut*)shortcut.cPtr(false) : null);
  }

  /**
   * Sets the controller to use the given modifier for mnemonics.
   * The mnemonics modifiers determines which modifiers need to be pressed to allow
   * activation of shortcuts with mnemonics triggers.
   * GTK normally uses the Alt modifier for mnemonics, except in `GtkPopoverMenu`s,
   * where mnemonics can be triggered without any modifiers. It should be very
   * rarely necessary to change this, and doing so is likely to interfere with
   * other shortcuts.
   * This value is only relevant for local shortcut controllers. Global and managed
   * shortcut controllers will have their shortcuts activated from other places which
   * have their own modifiers for activating mnemonics.
   * Params:
   *   modifiers = the new mnemonics_modifiers to use
   */
  void setMnemonicsModifiers(ModifierType modifiers)
  {
    gtk_shortcut_controller_set_mnemonics_modifiers(cast(GtkShortcutController*)cPtr, modifiers);
  }

  /**
   * Sets the controller to have the given scope.
   * The scope allows shortcuts to be activated outside of the normal
   * event propagation. In particular, it allows installing global
   * keyboard shortcuts that can be activated even when a widget does
   * not have focus.
   * With %GTK_SHORTCUT_SCOPE_LOCAL, shortcuts will only be activated
   * when the widget has focus.
   * Params:
   *   scope_ = the new scope to use
   */
  void setScope(ShortcutScope scope_)
  {
    gtk_shortcut_controller_set_scope(cast(GtkShortcutController*)cPtr, scope_);
  }
}
