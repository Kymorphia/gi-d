module Gtk.ConstraintGuide;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkConstraintGuide` is an invisible layout element in a
 * `GtkConstraintLayout`.
 * The `GtkConstraintLayout` treats guides like widgets. They
 * can be used as the source or target of a `GtkConstraint`.
 * Guides have a minimum, maximum and natural size. Depending
 * on the constraints that are applied, they can act like a
 * guideline that widgets can be aligned to, or like *flexible
 * space*.
 * Unlike a `GtkWidget`, a `GtkConstraintGuide` will not be drawn.
 */
class ConstraintGuide : ObjectG, ConstraintTarget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_constraint_guide_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ConstraintTargetT!();

  /**
   * Creates a new `GtkConstraintGuide` object.
   * Returns: a new `GtkConstraintGuide` object.
   */
  this()
  {
    GtkConstraintGuide* _cretval;
    _cretval = gtk_constraint_guide_new();
    this(_cretval, true);
  }

  /**
   * Gets the maximum size of guide.
   * Params:
   *   width = return location for the maximum width
   *   height = return location for the maximum height
   */
  void getMaxSize(out int width, out int height)
  {
    gtk_constraint_guide_get_max_size(cast(GtkConstraintGuide*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Gets the minimum size of guide.
   * Params:
   *   width = return location for the minimum width
   *   height = return location for the minimum height
   */
  void getMinSize(out int width, out int height)
  {
    gtk_constraint_guide_get_min_size(cast(GtkConstraintGuide*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Retrieves the name set using [Gtk.ConstraintGuide.setName].
   * Returns: the name of the guide
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_constraint_guide_get_name(cast(GtkConstraintGuide*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the natural size of guide.
   * Params:
   *   width = return location for the natural width
   *   height = return location for the natural height
   */
  void getNatSize(out int width, out int height)
  {
    gtk_constraint_guide_get_nat_size(cast(GtkConstraintGuide*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Retrieves the strength set using [Gtk.ConstraintGuide.setStrength].
   * Returns: the strength of the constraint on the natural size
   */
  ConstraintStrength getStrength()
  {
    GtkConstraintStrength _cretval;
    _cretval = gtk_constraint_guide_get_strength(cast(GtkConstraintGuide*)cPtr);
    ConstraintStrength _retval = cast(ConstraintStrength)_cretval;
    return _retval;
  }

  /**
   * Sets the maximum size of guide.
   * If guide is attached to a `GtkConstraintLayout`,
   * the constraints will be updated to reflect the new size.
   * Params:
   *   width = the new maximum width, or -1 to not change it
   *   height = the new maximum height, or -1 to not change it
   */
  void setMaxSize(int width, int height)
  {
    gtk_constraint_guide_set_max_size(cast(GtkConstraintGuide*)cPtr, width, height);
  }

  /**
   * Sets the minimum size of guide.
   * If guide is attached to a `GtkConstraintLayout`,
   * the constraints will be updated to reflect the new size.
   * Params:
   *   width = the new minimum width, or -1 to not change it
   *   height = the new minimum height, or -1 to not change it
   */
  void setMinSize(int width, int height)
  {
    gtk_constraint_guide_set_min_size(cast(GtkConstraintGuide*)cPtr, width, height);
  }

  /**
   * Sets a name for the given `GtkConstraintGuide`.
   * The name is useful for debugging purposes.
   * Params:
   *   name = a name for the guide
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_constraint_guide_set_name(cast(GtkConstraintGuide*)cPtr, _name);
  }

  /**
   * Sets the natural size of guide.
   * If guide is attached to a `GtkConstraintLayout`,
   * the constraints will be updated to reflect the new size.
   * Params:
   *   width = the new natural width, or -1 to not change it
   *   height = the new natural height, or -1 to not change it
   */
  void setNatSize(int width, int height)
  {
    gtk_constraint_guide_set_nat_size(cast(GtkConstraintGuide*)cPtr, width, height);
  }

  /**
   * Sets the strength of the constraint on the natural size of the
   * given `GtkConstraintGuide`.
   * Params:
   *   strength = the strength of the constraint
   */
  void setStrength(ConstraintStrength strength)
  {
    gtk_constraint_guide_set_strength(cast(GtkConstraintGuide*)cPtr, strength);
  }
}
