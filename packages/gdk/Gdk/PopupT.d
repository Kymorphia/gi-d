module Gdk.PopupT;

public import GObject.ObjectG;
public import Gdk.PopupLayout;
public import Gdk.Surface;
public import Gdk.Types;
public import Gdk.c.functions;
public import Gdk.c.types;
public import Gid.gid;

/**
 * A `GdkPopup` is a surface that is attached to another surface.
 * The `GdkPopup` is positioned relative to its parent surface.
 * `GdkPopup`s are typically used to implement menus and similar popups.
 * They can be modal, which is indicated by the [Gdk.Popup.autohide]
 * property.
 */
template PopupT(TStruct)
{

  /**
   * Returns whether this popup is set to hide on outside clicks.
   * Returns: %TRUE if popup will autohide
   */
  override bool getAutohide()
  {
    bool _retval;
    _retval = gdk_popup_get_autohide(cast(GdkPopup*)cPtr);
    return _retval;
  }

  /**
   * Returns the parent surface of a popup.
   * Returns: the parent surface
   */
  override Surface getParent()
  {
    GdkSurface* _cretval;
    _cretval = gdk_popup_get_parent(cast(GdkPopup*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the position of the popup relative to its parent.
   * Returns: the X coordinate of popup position
   */
  override int getPositionX()
  {
    int _retval;
    _retval = gdk_popup_get_position_x(cast(GdkPopup*)cPtr);
    return _retval;
  }

  /**
   * Obtains the position of the popup relative to its parent.
   * Returns: the Y coordinate of popup position
   */
  override int getPositionY()
  {
    int _retval;
    _retval = gdk_popup_get_position_y(cast(GdkPopup*)cPtr);
    return _retval;
  }

  /**
   * Gets the current popup rectangle anchor.
   * The value returned may change after calling [Gdk.Popup.present],
   * or after the [Gdk.Surface.layout] signal is emitted.
   * Returns: the current rectangle anchor value of popup
   */
  override Gravity getRectAnchor()
  {
    GdkGravity _cretval;
    _cretval = gdk_popup_get_rect_anchor(cast(GdkPopup*)cPtr);
    Gravity _retval = cast(Gravity)_cretval;
    return _retval;
  }

  /**
   * Gets the current popup surface anchor.
   * The value returned may change after calling [Gdk.Popup.present],
   * or after the [Gdk.Surface.layout] signal is emitted.
   * Returns: the current surface anchor value of popup
   */
  override Gravity getSurfaceAnchor()
  {
    GdkGravity _cretval;
    _cretval = gdk_popup_get_surface_anchor(cast(GdkPopup*)cPtr);
    Gravity _retval = cast(Gravity)_cretval;
    return _retval;
  }

  /**
   * Present popup after having processed the `GdkPopupLayout` rules.
   * If the popup was previously now showing, it will be showed,
   * otherwise it will change position according to layout.
   * After calling this function, the result should be handled in response
   * to the [Gdk.Surface.layout] signal being emitted. The resulting
   * popup position can be queried using [Gdk.Popup.getPositionX],
   * [Gdk.Popup.getPositionY], and the resulting size will be sent as
   * parameters in the layout signal. Use [Gdk.Popup.getRectAnchor]
   * and [Gdk.Popup.getSurfaceAnchor] to get the resulting anchors.
   * Presenting may fail, for example if the popup is set to autohide
   * and is immediately hidden upon being presented. If presenting failed,
   * the [Gdk.Surface.layout] signal will not me emitted.
   * Params:
   *   width = the unconstrained popup width to layout
   *   height = the unconstrained popup height to layout
   *   layout = the `GdkPopupLayout` object used to layout
   * Returns: %FALSE if it failed to be presented, otherwise %TRUE.
   */
  override bool present(int width, int height, PopupLayout layout)
  {
    bool _retval;
    _retval = gdk_popup_present(cast(GdkPopup*)cPtr, width, height, layout ? cast(GdkPopupLayout*)layout.cPtr(false) : null);
    return _retval;
  }
}
