module Gtk.Frame;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFrame` is a widget that surrounds its child with a decorative
 * frame and an optional label.
 * ![An example GtkFrame](frame.png)
 * If present, the label is drawn inside the top edge of the frame.
 * The horizontal position of the label can be controlled with
 * [Gtk.Frame.setLabelAlign].
 * `GtkFrame` clips its child. You can use this to add rounded corners
 * to widgets, but be aware that it also cuts off shadows.
 * # GtkFrame as GtkBuildable
 * The `GtkFrame` implementation of the `GtkBuildable` interface supports
 * placing a child in the label position by specifying “label” as the
 * “type” attribute of a `<child>` element. A normal content child can
 * be specified without specifying a `<child>` type attribute.
 * An example of a UI definition fragment with GtkFrame:
 * ```xml
 * <object class\="GtkFrame">
 * <child type\="label">
 * <object class\="GtkLabel" id\="frame_label"/>
 * </child>
 * <child>
 * <object class\="GtkEntry" id\="frame_content"/>
 * </child>
 * </object>
 * ```
 * # CSS nodes
 * ```
 * frame
 * ├── <label widget>
 * ╰── <child>
 * ```
 * `GtkFrame` has a main CSS node with name “frame”, which is used to draw the
 * visible border. You can set the appearance of the border using CSS properties
 * like “border-style” on this node.
 * # Accessibility
 * `GtkFrame` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 */
class Frame : Widget
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
    return gtk_frame_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFrame`, with optional label label.
   * If label is %NULL, the label is omitted.
   * Params:
   *   label = the text to use as the label of the frame
   * Returns: a new `GtkFrame` widget
   */
  this(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_frame_new(_label);
    this(_cretval, false);
  }

  /**
   * Gets the child widget of frame.
   * Returns: the child widget of frame
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_frame_get_child(cast(GtkFrame*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the frame labels text.
   * If the frame's label widget is not a `GtkLabel`, %NULL
   * is returned.
   * Returns: the text in the label, or %NULL if there
   *   was no label widget or the label widget was not a `GtkLabel`.
   *   This string is owned by GTK and must not be modified or freed.
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_frame_get_label(cast(GtkFrame*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the X alignment of the frame’s label.
   * Returns: the frames X alignment
   */
  float getLabelAlign()
  {
    float _retval;
    _retval = gtk_frame_get_label_align(cast(GtkFrame*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the label widget for the frame.
   * Returns: the label widget
   */
  Widget getLabelWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_frame_get_label_widget(cast(GtkFrame*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the child widget of frame.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_frame_set_child(cast(GtkFrame*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Creates a new `GtkLabel` with the label and sets it as the frame's
   * label widget.
   * Params:
   *   label = the text to use as the label of the frame
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_frame_set_label(cast(GtkFrame*)cPtr, _label);
  }

  /**
   * Sets the X alignment of the frame widget’s label.
   * The default value for a newly created frame is 0.0.
   * Params:
   *   xalign = The position of the label along the top edge
   *     of the widget. A value of 0.0 represents left alignment;
   *     1.0 represents right alignment.
   */
  void setLabelAlign(float xalign)
  {
    gtk_frame_set_label_align(cast(GtkFrame*)cPtr, xalign);
  }

  /**
   * Sets the label widget for the frame.
   * This is the widget that will appear embedded in the top edge
   * of the frame as a title.
   * Params:
   *   labelWidget = the new label widget
   */
  void setLabelWidget(Widget labelWidget)
  {
    gtk_frame_set_label_widget(cast(GtkFrame*)cPtr, labelWidget ? cast(GtkWidget*)labelWidget.cPtr(false) : null);
  }
}
