module Gtk.DrawingArea;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
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
import cairo.Context;

/**
 * `GtkDrawingArea` is a widget that allows drawing with cairo.
 * ![An example GtkDrawingArea](drawingarea.png)
 * It’s essentially a blank widget; you can draw on it. After
 * creating a drawing area, the application may want to connect to:
 * - The [Gtk.Widget.realize] signal to take any necessary actions
 * when the widget is instantiated on a particular display.
 * $(LPAREN)Create GDK resources in response to this signal.$(RPAREN)
 * - The [Gtk.DrawingArea.resize] signal to take any necessary
 * actions when the widget changes size.
 * - Call [Gtk.DrawingArea.setDrawFunc] to handle redrawing the
 * contents of the widget.
 * The following code portion demonstrates using a drawing
 * area to display a circle in the normal widget foreground
 * color.
 * ## Simple GtkDrawingArea usage
 * ```c
 * static void
 * draw_function $(LPAREN)GtkDrawingArea *area,
 * cairo_t        *cr,
 * int             width,
 * int             height,
 * gpointer        data$(RPAREN)
 * {
 * GdkRGBA color;
 * cairo_arc $(LPAREN)cr,
 * width / 2.0, height / 2.0,
 * MIN $(LPAREN)width, height$(RPAREN) / 2.0,
 * 0, 2 * G_PI$(RPAREN);
 * gtk_widget_get_color $(LPAREN)GTK_WIDGET $(LPAREN)area$(RPAREN),
 * &color$(RPAREN);
 * gdk_cairo_set_source_rgba $(LPAREN)cr, &color$(RPAREN);
 * cairo_fill $(LPAREN)cr$(RPAREN);
 * }
 * int
 * main $(LPAREN)int argc, char **argv$(RPAREN)
 * {
 * gtk_init $(LPAREN)$(RPAREN);
 * GtkWidget *area \= gtk_drawing_area_new $(LPAREN)$(RPAREN);
 * gtk_drawing_area_set_content_width $(LPAREN)GTK_DRAWING_AREA $(LPAREN)area$(RPAREN), 100$(RPAREN);
 * gtk_drawing_area_set_content_height $(LPAREN)GTK_DRAWING_AREA $(LPAREN)area$(RPAREN), 100$(RPAREN);
 * gtk_drawing_area_set_draw_func $(LPAREN)GTK_DRAWING_AREA $(LPAREN)area$(RPAREN),
 * draw_function,
 * NULL, NULL$(RPAREN);
 * return 0;
 * }
 * ```
 * The draw function is normally called when a drawing area first comes
 * onscreen, or when it’s covered by another window and then uncovered.
 * You can also force a redraw by adding to the “damage region” of the
 * drawing area’s window using [Gtk.Widget.queueDraw].
 * This will cause the drawing area to call the draw function again.
 * The available routines for drawing are documented in the
 * [Cairo documentation](https://www.cairographics.org/manual/); GDK
 * offers additional API to integrate with Cairo, like func@Gdk.cairo_set_source_rgba
 * or func@Gdk.cairo_set_source_pixbuf.
 * To receive mouse events on a drawing area, you will need to use
 * event controllers. To receive keyboard events, you will need to set
 * the “can-focus” property on the drawing area, and you should probably
 * draw some user-visible indication that the drawing area is focused.
 * If you need more complex control over your widget, you should consider
 * creating your own `GtkWidget` subclass.
 */
class DrawingArea : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_drawing_area_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new drawing area.
   * Returns: a new `GtkDrawingArea`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_drawing_area_new();
    this(_cretval, false);
  }

  /**
   * Retrieves the content height of the `GtkDrawingArea`.
   * Returns: The height requested for content of the drawing area
   */
  int getContentHeight()
  {
    int _retval;
    _retval = gtk_drawing_area_get_content_height(cast(GtkDrawingArea*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the content width of the `GtkDrawingArea`.
   * Returns: The width requested for content of the drawing area
   */
  int getContentWidth()
  {
    int _retval;
    _retval = gtk_drawing_area_get_content_width(cast(GtkDrawingArea*)cPtr);
    return _retval;
  }

  /**
   * Sets the desired height of the contents of the drawing area.
   * Note that because widgets may be allocated larger sizes than they
   * requested, it is possible that the actual height passed to your draw
   * function is larger than the height set here. You can use
   * [Gtk.Widget.setValign] to avoid that.
   * If the height is set to 0 $(LPAREN)the default$(RPAREN), the drawing area may disappear.
   * Params:
   *   height = the height of contents
   */
  void setContentHeight(int height)
  {
    gtk_drawing_area_set_content_height(cast(GtkDrawingArea*)cPtr, height);
  }

  /**
   * Sets the desired width of the contents of the drawing area.
   * Note that because widgets may be allocated larger sizes than they
   * requested, it is possible that the actual width passed to your draw
   * function is larger than the width set here. You can use
   * [Gtk.Widget.setHalign] to avoid that.
   * If the width is set to 0 $(LPAREN)the default$(RPAREN), the drawing area may disappear.
   * Params:
   *   width = the width of contents
   */
  void setContentWidth(int width)
  {
    gtk_drawing_area_set_content_width(cast(GtkDrawingArea*)cPtr, width);
  }

  /**
   * Setting a draw function is the main thing you want to do when using
   * a drawing area.
   * The draw function is called whenever GTK needs to draw the contents
   * of the drawing area to the screen.
   * The draw function will be called during the drawing stage of GTK.
   * In the drawing stage it is not allowed to change properties of any
   * GTK widgets or call any functions that would cause any properties
   * to be changed. You should restrict yourself exclusively to drawing
   * your contents in the draw function.
   * If what you are drawing does change, call [Gtk.Widget.queueDraw]
   * on the drawing area. This will cause a redraw and will call draw_func again.
   * Params:
   *   drawFunc = callback that lets you draw
   *     the drawing area's contents
   */
  void setDrawFunc(DrawingAreaDrawFunc drawFunc)
  {
    extern(C) void _drawFuncCallback(GtkDrawingArea* drawingArea, cairo_t* cr, int width, int height, void* userData)
    {
      auto _dlg = cast(DrawingAreaDrawFunc*)userData;

      (*_dlg)(drawingArea ? ObjectG.getDObject!DrawingArea(cast(void*)drawingArea, false) : null, cr ? new Context(cast(void*)cr, false) : null, width, height);
    }

    auto _drawFunc = freezeDelegate(cast(void*)&drawFunc);
    gtk_drawing_area_set_draw_func(cast(GtkDrawingArea*)cPtr, &_drawFuncCallback, _drawFunc, &thawDelegate);
  }

  /**
   * Emitted once when the widget is realized, and then each time the widget
   * is changed while realized.
   * This is useful in order to keep state up to date with the widget size,
   * like for instance a backing surface.
   * Params
   *   width = the width of the viewport
   *   height = the height of the viewport
   *   drawingArea = the instance the signal is connected to
   */
  alias ResizeCallback = void delegate(int width, int height, DrawingArea drawingArea);

  /**
   * Connect to Resize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectResize(ResizeCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drawingArea = getVal!DrawingArea(_paramVals);
      auto width = getVal!int(&_paramVals[1]);
      auto height = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(width, height, drawingArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("resize", closure, (flags & ConnectFlags.After) != 0);
  }
}
