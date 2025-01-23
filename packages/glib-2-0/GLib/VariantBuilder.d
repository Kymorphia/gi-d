module GLib.VariantBuilder;

import GLib.Boxed;
import GLib.Types;
import GLib.VariantG;
import GLib.VariantType;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A utility type for constructing container-type #GVariant instances.
 * This is an opaque structure and may only be accessed using the
 * following functions.
 * #GVariantBuilder is not threadsafe in any way.  Do not attempt to
 * access it from more than one thread.
 */
class VariantBuilder : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_variant_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates and initialises a new #GVariantBuilder.
   * You should call [GLib.VariantBuilder.unref] on the return value when it
   * is no longer needed.  The memory will not be automatically freed by
   * any other call.
   * In most cases it is easier to place a #GVariantBuilder directly on
   * the stack of the calling function and initialise it with
   * [GLib.VariantBuilder.init_].
   * Params:
   *   type = a container type
   * Returns: a #GVariantBuilder
   */
  this(VariantType type)
  {
    GVariantBuilder* _cretval;
    _cretval = g_variant_builder_new(type ? cast(GVariantType*)type.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Adds value to builder.
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed.  Some examples of this are
   * putting different types of items into an array, putting the wrong
   * types or number of items in a tuple, putting more than one value into
   * a variant, etc.
   * If value is a floating reference $(LPAREN)see [GLib.VariantG.refSink]$(RPAREN),
   * the builder instance takes ownership of value.
   * Params:
   *   value = a #GVariant
   */
  void addValue(VariantG value)
  {
    g_variant_builder_add_value(cast(GVariantBuilder*)cPtr, value ? cast(VariantC*)value.cPtr(false) : null);
  }

  /**
   * Closes the subcontainer inside the given builder that was opened by
   * the most recent call to [GLib.VariantBuilder.open].
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed $(LPAREN)ie: too few values added to the
   * subcontainer$(RPAREN).
   */
  void close()
  {
    g_variant_builder_close(cast(GVariantBuilder*)cPtr);
  }

  /**
   * Ends the builder process and returns the constructed value.
   * It is not permissible to use builder in any way after this call
   * except for reference counting operations $(LPAREN)in the case of a
   * heap-allocated #GVariantBuilder$(RPAREN) or by reinitialising it with
   * [GLib.VariantBuilder.init_] (in the case of stack-allocated). This
   * means that for the stack-allocated builders there is no need to
   * call [GLib.VariantBuilder.clear] after the call to
   * [GLib.VariantBuilder.end].
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed $(LPAREN)ie: insufficient number of
   * items added to a container with a specific number of children
   * required$(RPAREN).  It is also an error to call this function if the builder
   * was created with an indefinite array or maybe type and no children
   * have been added; in this case it is impossible to infer the type of
   * the empty array.
   * Returns: a new, floating, #GVariant
   */
  VariantG end()
  {
    VariantC* _cretval;
    _cretval = g_variant_builder_end(cast(GVariantBuilder*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Opens a subcontainer inside the given builder.  When done adding
   * items to the subcontainer, [GLib.VariantBuilder.close] must be called. type
   * is the type of the container: so to build a tuple of several values, type
   * must include the tuple itself.
   * It is an error to call this function in any way that would cause an
   * inconsistent value to be constructed $(LPAREN)ie: adding too many values or
   * a value of an incorrect type$(RPAREN).
   * Example of building a nested variant:
   * |[<!-- language\="C" -->
   * GVariantBuilder builder;
   * guint32 some_number \= get_number $(LPAREN)$(RPAREN);
   * g_autoptr $(LPAREN)GHashTable$(RPAREN) some_dict \= get_dict $(LPAREN)$(RPAREN);
   * GHashTableIter iter;
   * const gchar *key;
   * const GVariant *value;
   * g_autoptr $(LPAREN)GVariant$(RPAREN) output \= NULL;
   * g_variant_builder_init $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"$(LPAREN)ua{sv}$(RPAREN)"$(RPAREN)$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "u", some_number$(RPAREN);
   * g_variant_builder_open $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"a{sv}"$(RPAREN)$(RPAREN);
   * g_hash_table_iter_init $(LPAREN)&iter, some_dict$(RPAREN);
   * while $(LPAREN)g_hash_table_iter_next $(LPAREN)&iter, $(LPAREN)gpointer *$(RPAREN) &key, $(LPAREN)gpointer *$(RPAREN) &value$(RPAREN)$(RPAREN)
   * {
   * g_variant_builder_open $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"{sv}"$(RPAREN)$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "s", key$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "v", value$(RPAREN);
   * g_variant_builder_close $(LPAREN)&builder$(RPAREN);
   * }
   * g_variant_builder_close $(LPAREN)&builder$(RPAREN);
   * output \= g_variant_builder_end $(LPAREN)&builder$(RPAREN);
   * ]|
   * Params:
   *   type = the #GVariantType of the container
   */
  void open(VariantType type)
  {
    g_variant_builder_open(cast(GVariantBuilder*)cPtr, type ? cast(GVariantType*)type.cPtr(false) : null);
  }
}
