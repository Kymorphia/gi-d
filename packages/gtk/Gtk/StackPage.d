module Gtk.StackPage;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkStackPage` is an auxiliary class used by `GtkStack`.
 */
class StackPage : ObjectG, Accessible
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
    return gtk_stack_page_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleT!();

  /**
   * Returns the stack child to which self belongs.
   * Returns: the child to which self belongs
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_stack_page_get_child(cast(GtkStackPage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the icon name of the page.
   * Returns: The value of the propertyGtk.StackPage:icon-name property
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_stack_page_get_icon_name(cast(GtkStackPage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the name of the page.
   * Returns: The value of the [Gtk.StackPage.name] property
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_stack_page_get_name(cast(GtkStackPage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the page is marked as “needs attention”.
   * Returns: The value of the propertyGtk.StackPage:needs-attention
   *   property.
   */
  bool getNeedsAttention()
  {
    bool _retval;
    _retval = gtk_stack_page_get_needs_attention(cast(GtkStackPage*)cPtr);
    return _retval;
  }

  /**
   * Gets the page title.
   * Returns: The value of the [Gtk.StackPage.title] property
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_stack_page_get_title(cast(GtkStackPage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether underlines in the page title indicate mnemonics.
   * Returns: The value of the propertyGtk.StackPage:use-underline property
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_stack_page_get_use_underline(cast(GtkStackPage*)cPtr);
    return _retval;
  }

  /**
   * Returns whether page is visible in its `GtkStack`.
   * This is independent from the [Gtk.Widget.visible]
   * property of its widget.
   * Returns: %TRUE if page is visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_stack_page_get_visible(cast(GtkStackPage*)cPtr);
    return _retval;
  }

  /**
   * Sets the icon name of the page.
   * Params:
   *   setting = the new value to set
   */
  void setIconName(string setting)
  {
    const(char)* _setting = setting.toCString(false);
    gtk_stack_page_set_icon_name(cast(GtkStackPage*)cPtr, _setting);
  }

  /**
   * Sets the name of the page.
   * Params:
   *   setting = the new value to set
   */
  void setName(string setting)
  {
    const(char)* _setting = setting.toCString(false);
    gtk_stack_page_set_name(cast(GtkStackPage*)cPtr, _setting);
  }

  /**
   * Sets whether the page is marked as “needs attention”.
   * Params:
   *   setting = the new value to set
   */
  void setNeedsAttention(bool setting)
  {
    gtk_stack_page_set_needs_attention(cast(GtkStackPage*)cPtr, setting);
  }

  /**
   * Sets the page title.
   * Params:
   *   setting = the new value to set
   */
  void setTitle(string setting)
  {
    const(char)* _setting = setting.toCString(false);
    gtk_stack_page_set_title(cast(GtkStackPage*)cPtr, _setting);
  }

  /**
   * Sets whether underlines in the page title indicate mnemonics.
   * Params:
   *   setting = the new value to set
   */
  void setUseUnderline(bool setting)
  {
    gtk_stack_page_set_use_underline(cast(GtkStackPage*)cPtr, setting);
  }

  /**
   * Sets whether page is visible in its `GtkStack`.
   * Params:
   *   visible = The new property value
   */
  void setVisible(bool visible)
  {
    gtk_stack_page_set_visible(cast(GtkStackPage*)cPtr, visible);
  }
}
