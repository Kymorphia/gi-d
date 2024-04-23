module GLib.VariantBuilder;

import GLib.Boxed;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A utility type for constructing container-type #GVariant instances.
 *
 * This is an opaque structure and may only be accessed using the
 * following functions.
 *
 * #GVariantBuilder is not threadsafe in any way.  Do not attempt to
 * access it from more than one thread.
 */
class VariantBuilder : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GVariantBuilder))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_variant_builder_get_type();
  }

  /**
   * a #GVariantBuilder
   */
  this(VariantType type)
  {
    GVariantBuilder* _cretval;
    _cretval = g_variant_builder_new(type ? type.cPtr!GVariantType : null);
    this(_cretval, true);
  }

  /**
   * Adds @value to @builder.
   *
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed.  Some examples of this are
   * putting different types of items into an array, putting the wrong
   * types or number of items in a tuple, putting more than one value into
   * a variant, etc.
   *
   * If @value is a floating reference (see g_variant_ref_sink()),
   * the @builder instance takes ownership of @value.
   */
  void addValue(Variant value)
  {
    g_variant_builder_add_value(cPtr!GVariantBuilder, value ? value.cPtr!GVariant : null);
  }

  /**
   * Closes the subcontainer inside the given @builder that was opened by
   * the most recent call to g_variant_builder_open().
   *
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed (ie: too few values added to the
   * subcontainer).
   */
  void close()
  {
    g_variant_builder_close(cPtr!GVariantBuilder);
  }

  /**
   * a new, floating, #GVariant
   */
  Variant end()
  {
    GVariant* _cretval;
    _cretval = g_variant_builder_end(cPtr!GVariantBuilder);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * Opens a subcontainer inside the given @builder.  When done adding
   * items to the subcontainer, g_variant_builder_close() must be called. @type
   * is the type of the container: so to build a tuple of several values, @type
   * must include the tuple itself.
   *
   * It is an error to call this function in any way that would cause an
   * inconsistent value to be constructed (ie: adding too many values or
   * a value of an incorrect type).
   *
   * Example of building a nested variant:
   * |[<!-- language="C" -->
   * GVariantBuilder builder;
   * guint32 some_number = get_number ();
   * g_autoptr (GHashTable) some_dict = get_dict ();
   * GHashTableIter iter;
   * const gchar *key;
   * const GVariant *value;
   * g_autoptr (GVariant) output = NULL;
   *
   * g_variant_builder_init (&builder, G_VARIANT_TYPE ("(ua{sv})"));
   * g_variant_builder_add (&builder, "u", some_number);
   * g_variant_builder_open (&builder, G_VARIANT_TYPE ("a{sv}"));
   *
   * g_hash_table_iter_init (&iter, some_dict);
   * while (g_hash_table_iter_next (&iter, (gpointer *) &key, (gpointer *) &value))
   * {
   * g_variant_builder_open (&builder, G_VARIANT_TYPE ("{sv}"));
   * g_variant_builder_add (&builder, "s", key);
   * g_variant_builder_add (&builder, "v", value);
   * g_variant_builder_close (&builder);
   * }
   *
   * g_variant_builder_close (&builder);
   *
   * output = g_variant_builder_end (&builder);
   * ]|
   */
  void open(VariantType type)
  {
    g_variant_builder_open(cPtr!GVariantBuilder, type ? type.cPtr!GVariantType : null);
  }
}
