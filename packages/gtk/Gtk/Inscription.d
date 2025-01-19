module Gtk.Inscription;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.AccessibleText;
import Gtk.AccessibleTextT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.AttrList;
import Pango.Types : WrapMode = WrapMode;

/**
 * `GtkInscription` is a widget to show text in a predefined area.
 * You likely want to use `GtkLabel` instead as this widget is intended only
 * for a small subset of use cases. The main scenario envisaged is inside lists
 * such as `GtkColumnView`.
 * While a `GtkLabel` sizes itself depending on the text that is displayed,
 * `GtkInscription` is given a size and inscribes the given text into that
 * space as well as it can.
 * Users of this widget should take care to plan behaviour for the common case
 * where the text doesn't fit exactly in the allocated space.
 */
class Inscription : Widget, AccessibleText
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
    return gtk_inscription_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleTextT!();

  /**
   * Creates a new `GtkInscription` with the given text.
   * Params:
   *   text = The text to display.
   * Returns: a new `GtkInscription`
   */
  this(string text)
  {
    GtkWidget* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = gtk_inscription_new(_text);
    this(_cretval, false);
  }

  /**
   * Gets the inscription's attribute list.
   * Returns: the attribute list
   */
  AttrList getAttributes()
  {
    PangoAttrList* _cretval;
    _cretval = gtk_inscription_get_attributes(cast(GtkInscription*)cPtr);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `min-chars` of the inscription.
   * See the propertyGtk.Inscription:min-chars property.
   * Returns: the min-chars property
   */
  uint getMinChars()
  {
    uint _retval;
    _retval = gtk_inscription_get_min_chars(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Gets the `min-lines` of the inscription.
   * See the propertyGtk.Inscription:min-lines property.
   * Returns: the min-lines property
   */
  uint getMinLines()
  {
    uint _retval;
    _retval = gtk_inscription_get_min_lines(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Gets the `nat-chars` of the inscription.
   * See the propertyGtk.Inscription:nat-chars property.
   * Returns: the nat-chars property
   */
  uint getNatChars()
  {
    uint _retval;
    _retval = gtk_inscription_get_nat_chars(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Gets the `nat-lines` of the inscription.
   * See the propertyGtk.Inscription:nat-lines property.
   * Returns: the nat-lines property
   */
  uint getNatLines()
  {
    uint _retval;
    _retval = gtk_inscription_get_nat_lines(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Gets the text that is displayed.
   * Returns: The displayed text
   */
  string getText()
  {
    const(char)* _cretval;
    _cretval = gtk_inscription_get_text(cast(GtkInscription*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the inscription's overflow method.
   * Returns: the overflow method
   */
  InscriptionOverflow getTextOverflow()
  {
    GtkInscriptionOverflow _cretval;
    _cretval = gtk_inscription_get_text_overflow(cast(GtkInscription*)cPtr);
    InscriptionOverflow _retval = cast(InscriptionOverflow)_cretval;
    return _retval;
  }

  /**
   * Returns line wrap mode used by the inscription.
   * See [Gtk.Inscription.setWrapMode].
   * Returns: the line wrap mode
   */
  WrapMode getWrapMode()
  {
    PangoWrapMode _cretval;
    _cretval = gtk_inscription_get_wrap_mode(cast(GtkInscription*)cPtr);
    WrapMode _retval = cast(WrapMode)_cretval;
    return _retval;
  }

  /**
   * Gets the `xalign` of the inscription.
   * See the [Gtk.Inscription.xalign] property.
   * Returns: the xalign property
   */
  float getXalign()
  {
    float _retval;
    _retval = gtk_inscription_get_xalign(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Gets the `yalign` of the inscription.
   * See the [Gtk.Inscription.yalign] property.
   * Returns: the yalign property
   */
  float getYalign()
  {
    float _retval;
    _retval = gtk_inscription_get_yalign(cast(GtkInscription*)cPtr);
    return _retval;
  }

  /**
   * Apply attributes to the inscription text.
   * These attributes will not be evaluated for sizing the inscription.
   * Params:
   *   attrs = a [Pango.AttrList]
   */
  void setAttributes(AttrList attrs)
  {
    gtk_inscription_set_attributes(cast(GtkInscription*)cPtr, attrs ? cast(PangoAttrList*)attrs.cPtr(false) : null);
  }

  /**
   * Utility function to set the text and attributes to be displayed.
   * See the [Gtk.Inscription.markup] property.
   * Params:
   *   markup = The markup to display
   */
  void setMarkup(string markup)
  {
    const(char)* _markup = markup.toCString(false);
    gtk_inscription_set_markup(cast(GtkInscription*)cPtr, _markup);
  }

  /**
   * Sets the `min-chars` of the inscription.
   * See the propertyGtk.Inscription:min-chars property.
   * Params:
   *   minChars = the minimum number of characters that should fit, approximately
   */
  void setMinChars(uint minChars)
  {
    gtk_inscription_set_min_chars(cast(GtkInscription*)cPtr, minChars);
  }

  /**
   * Sets the `min-lines` of the inscription.
   * See the propertyGtk.Inscription:min-lines property.
   * Params:
   *   minLines = the minimum number of lines that should fit, approximately
   */
  void setMinLines(uint minLines)
  {
    gtk_inscription_set_min_lines(cast(GtkInscription*)cPtr, minLines);
  }

  /**
   * Sets the `nat-chars` of the inscription.
   * See the propertyGtk.Inscription:nat-chars property.
   * Params:
   *   natChars = the number of characters that should ideally fit, approximately
   */
  void setNatChars(uint natChars)
  {
    gtk_inscription_set_nat_chars(cast(GtkInscription*)cPtr, natChars);
  }

  /**
   * Sets the `nat-lines` of the inscription.
   * See the propertyGtk.Inscription:nat-lines property.
   * Params:
   *   natLines = the number of lines that should ideally fit
   */
  void setNatLines(uint natLines)
  {
    gtk_inscription_set_nat_lines(cast(GtkInscription*)cPtr, natLines);
  }

  /**
   * Sets the text to be displayed.
   * Params:
   *   text = The text to display
   */
  void setText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_inscription_set_text(cast(GtkInscription*)cPtr, _text);
  }

  /**
   * Sets what to do when the text doesn't fit.
   * Params:
   *   overflow = the overflow method to use
   */
  void setTextOverflow(InscriptionOverflow overflow)
  {
    gtk_inscription_set_text_overflow(cast(GtkInscription*)cPtr, overflow);
  }

  /**
   * Controls how line wrapping is done.
   * Params:
   *   wrapMode = the line wrapping mode
   */
  void setWrapMode(WrapMode wrapMode)
  {
    gtk_inscription_set_wrap_mode(cast(GtkInscription*)cPtr, wrapMode);
  }

  /**
   * Sets the `xalign` of the inscription.
   * See the [Gtk.Inscription.xalign] property.
   * Params:
   *   xalign = the new xalign value, between 0 and 1
   */
  void setXalign(float xalign)
  {
    gtk_inscription_set_xalign(cast(GtkInscription*)cPtr, xalign);
  }

  /**
   * Sets the `yalign` of the inscription.
   * See the [Gtk.Inscription.yalign] property.
   * Params:
   *   yalign = the new yalign value, between 0 and 1
   */
  void setYalign(float yalign)
  {
    gtk_inscription_set_yalign(cast(GtkInscription*)cPtr, yalign);
  }
}
