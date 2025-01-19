module Gtk.ShortcutsSection;

import GObject.DClosure;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Box;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.ShortcutsGroup;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutsSection` collects all the keyboard shortcuts and gestures
 * for a major application mode.
 * If your application needs multiple sections, you should give each
 * section a unique property@Gtk.ShortcutsSection:section-name and
 * a [Gtk.ShortcutsSection.title] that can be shown in the
 * section selector of the [Gtk.ShortcutsWindow].
 * The property@Gtk.ShortcutsSection:max-height property can be used
 * to influence how the groups in the section are distributed over pages
 * and columns.
 * This widget is only meant to be used with [Gtk.ShortcutsWindow].
 * The recommended way to construct a `GtkShortcutsSection` is with
 * [Gtk.Builder], by using the `<child>` tag to populate a
 * `GtkShortcutsSection` with one or more [Gtk.ShortcutsGroup]
 * instances, which in turn contain one or more [Gtk.ShortcutsShortcut]
 * objects.
 * If you need to add a group programmatically, use
 * [Gtk.ShortcutsSection.addGroup].
 */
class ShortcutsSection : Box
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
    return gtk_shortcuts_section_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds a group to the shortcuts section.
   * This is the programmatic equivalent to using [Gtk.Builder] and a
   * `<child>` tag to add the child.
   * Adding children with the `GtkBox` API is not appropriate, as
   * `GtkShortcutsSection` manages its children internally.
   * Params:
   *   group = the `GtkShortcutsGroup` to add
   */
  void addGroup(ShortcutsGroup group)
  {
    gtk_shortcuts_section_add_group(cast(GtkShortcutsSection*)cPtr, group ? cast(GtkShortcutsGroup*)group.cPtr(false) : null);
  }

  alias ChangeCurrentPageCallback = bool delegate(int object, ShortcutsSection shortcutsSection);

  /**
   * Connect to ChangeCurrentPage signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChangeCurrentPage(ChangeCurrentPageCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto shortcutsSection = getVal!ShortcutsSection(_paramVals);
      auto object = getVal!int(&_paramVals[1]);
      _retval = _dgClosure.dlg(object, shortcutsSection);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("change-current-page", closure, after);
  }
}
