module Gtk.Constraint;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkConstraint` describes a constraint between attributes of two widgets,
 * expressed as a linear equation.
 * The typical equation for a constraint is:
 * ```
 * target.target_attr \= source.source_attr × multiplier + constant
 * ```
 * Each `GtkConstraint` is part of a system that will be solved by a
 * [Gtk.ConstraintLayout] in order to allocate and position each
 * child widget or guide.
 * The source and target, as well as their attributes, of a `GtkConstraint`
 * instance are immutable after creation.
 */
class Constraint : ObjectG
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
    return gtk_constraint_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new constraint representing a relation between a layout
   * attribute on a source and a layout attribute on a target.
   * Params:
   *   target = the target of the constraint
   *   targetAttribute = the attribute of `target` to be set
   *   relation = the relation equivalence between `target_attribute` and `source_attribute`
   *   source = the source of the constraint
   *   sourceAttribute = the attribute of `source` to be read
   *   multiplier = a multiplication factor to be applied to `source_attribute`
   *   constant = a constant factor to be added to `source_attribute`
   *   strength = the strength of the constraint
   * Returns: the newly created constraint
   */
  this(ConstraintTarget target, ConstraintAttribute targetAttribute, ConstraintRelation relation, ConstraintTarget source, ConstraintAttribute sourceAttribute, double multiplier, double constant, int strength)
  {
    GtkConstraint* _cretval;
    _cretval = gtk_constraint_new(target ? cast(GtkConstraintTarget*)(cast(ObjectG)target).cPtr(false) : null, targetAttribute, relation, source ? cast(GtkConstraintTarget*)(cast(ObjectG)source).cPtr(false) : null, sourceAttribute, multiplier, constant, strength);
    this(_cretval, true);
  }

  /**
   * Creates a new constraint representing a relation between a layout
   * attribute on a target and a constant value.
   * Params:
   *   target = a the target of the constraint
   *   targetAttribute = the attribute of `target` to be set
   *   relation = the relation equivalence between `target_attribute` and `constant`
   *   constant = a constant factor to be set on `target_attribute`
   *   strength = the strength of the constraint
   * Returns: the newly created constraint
   */
  static Constraint newConstant(ConstraintTarget target, ConstraintAttribute targetAttribute, ConstraintRelation relation, double constant, int strength)
  {
    GtkConstraint* _cretval;
    _cretval = gtk_constraint_new_constant(target ? cast(GtkConstraintTarget*)(cast(ObjectG)target).cPtr(false) : null, targetAttribute, relation, constant, strength);
    auto _retval = _cretval ? ObjectG.getDObject!Constraint(cast(GtkConstraint*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the constant factor added to the source attributes' value.
   * Returns: a constant factor
   */
  double getConstant()
  {
    double _retval;
    _retval = gtk_constraint_get_constant(cast(GtkConstraint*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the multiplication factor applied to the source
   * attribute's value.
   * Returns: a multiplication factor
   */
  double getMultiplier()
  {
    double _retval;
    _retval = gtk_constraint_get_multiplier(cast(GtkConstraint*)cPtr);
    return _retval;
  }

  /**
   * The order relation between the terms of the constraint.
   * Returns: a relation type
   */
  ConstraintRelation getRelation()
  {
    GtkConstraintRelation _cretval;
    _cretval = gtk_constraint_get_relation(cast(GtkConstraint*)cPtr);
    ConstraintRelation _retval = cast(ConstraintRelation)_cretval;
    return _retval;
  }

  /**
   * Retrieves the [Gtk.ConstraintTarget] used as the source for the
   * constraint.
   * If the source is set to `NULL` at creation, the constraint will use
   * the widget using the [Gtk.ConstraintLayout] as the source.
   * Returns: the source of the constraint
   */
  ConstraintTarget getSource()
  {
    GtkConstraintTarget* _cretval;
    _cretval = gtk_constraint_get_source(cast(GtkConstraint*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ConstraintTarget(cast(GtkConstraintTarget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the attribute of the source to be read by the constraint.
   * Returns: the source's attribute
   */
  ConstraintAttribute getSourceAttribute()
  {
    GtkConstraintAttribute _cretval;
    _cretval = gtk_constraint_get_source_attribute(cast(GtkConstraint*)cPtr);
    ConstraintAttribute _retval = cast(ConstraintAttribute)_cretval;
    return _retval;
  }

  /**
   * Retrieves the strength of the constraint.
   * Returns: the strength value
   */
  int getStrength()
  {
    int _retval;
    _retval = gtk_constraint_get_strength(cast(GtkConstraint*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the [Gtk.ConstraintTarget] used as the target for
   * the constraint.
   * If the targe is set to `NULL` at creation, the constraint will use
   * the widget using the [Gtk.ConstraintLayout] as the target.
   * Returns: a `GtkConstraintTarget`
   */
  ConstraintTarget getTarget()
  {
    GtkConstraintTarget* _cretval;
    _cretval = gtk_constraint_get_target(cast(GtkConstraint*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ConstraintTarget(cast(GtkConstraintTarget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the attribute of the target to be set by the constraint.
   * Returns: the target's attribute
   */
  ConstraintAttribute getTargetAttribute()
  {
    GtkConstraintAttribute _cretval;
    _cretval = gtk_constraint_get_target_attribute(cast(GtkConstraint*)cPtr);
    ConstraintAttribute _retval = cast(ConstraintAttribute)_cretval;
    return _retval;
  }

  /**
   * Checks whether the constraint is attached to a [Gtk.ConstraintLayout],
   * and it is contributing to the layout.
   * Returns: `TRUE` if the constraint is attached
   */
  bool isAttached()
  {
    bool _retval;
    _retval = gtk_constraint_is_attached(cast(GtkConstraint*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the constraint describes a relation between an attribute
   * on the [Gtk.Constraint.target] and a constant value.
   * Returns: `TRUE` if the constraint is a constant relation
   */
  bool isConstant()
  {
    bool _retval;
    _retval = gtk_constraint_is_constant(cast(GtkConstraint*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the constraint is a required relation for solving the
   * constraint layout.
   * Returns: %TRUE if the constraint is required
   */
  bool isRequired()
  {
    bool _retval;
    _retval = gtk_constraint_is_required(cast(GtkConstraint*)cPtr);
    return _retval;
  }
}
