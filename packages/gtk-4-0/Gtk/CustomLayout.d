module Gtk.CustomLayout;

import GObject.ObjectG;
import Gid.gid;
import Gtk.LayoutManager;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkCustomLayout` uses closures for size negotiation.
 * A `GtkCustomLayout `uses closures matching to the old `GtkWidget`
 * virtual functions for size negotiation, as a convenience API to
 * ease the porting towards the corresponding `GtkLayoutManager
 * virtual functions.
 */
class CustomLayout : LayoutManager
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
    return gtk_custom_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new legacy layout manager.
   * Legacy layout managers map to the old `GtkWidget` size negotiation
   * virtual functions, and are meant to be used during the transition
   * from layout containers to layout manager delegates.
   * Params:
   *   requestMode = a function to retrieve
   *     the `GtkSizeRequestMode` of the widget using the layout; the
   *     default request mode is %GTK_SIZE_REQUEST_CONSTANT_SIZE
   *   measure = a function to measure the widget using the layout manager
   *   allocate = a function to allocate the children of the widget using
   *     the layout manager
   * Returns: the newly created `GtkCustomLayout`
   */
  this(CustomRequestModeFunc requestMode, CustomMeasureFunc measure, CustomAllocateFunc allocate)
  {
    static CustomRequestModeFunc _static_requestMode;

    extern(C) GtkSizeRequestMode _requestModeCallback(GtkWidget* widget)
    {
      SizeRequestMode _dretval;

      _dretval = _static_requestMode(widget ? ObjectG.getDObject!Widget(cast(void*)widget, false) : null);
      auto _retval = cast(GtkSizeRequestMode)_dretval;

      return _retval;
    }

    _static_requestMode = requestMode;
    static CustomMeasureFunc _static_measure;

    extern(C) void _measureCallback(GtkWidget* widget, GtkOrientation orientation, int forSize, int* minimum, int* natural, int* minimumBaseline, int* naturalBaseline)
    {
      _static_measure(widget ? ObjectG.getDObject!Widget(cast(void*)widget, false) : null, orientation, forSize, *minimum, *natural, *minimumBaseline, *naturalBaseline);
    }

    _static_measure = measure;
    static CustomAllocateFunc _static_allocate;

    extern(C) void _allocateCallback(GtkWidget* widget, int width, int height, int baseline)
    {
      _static_allocate(widget ? ObjectG.getDObject!Widget(cast(void*)widget, false) : null, width, height, baseline);
    }

    _static_allocate = allocate;
    GtkLayoutManager* _cretval;
    _cretval = gtk_custom_layout_new(&_requestModeCallback, &_measureCallback, &_allocateCallback);
    _static_requestMode = null;
    _static_measure = null;
    _static_allocate = null;
    this(_cretval, true);
  }
}
