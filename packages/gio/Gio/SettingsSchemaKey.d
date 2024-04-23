module Gio.SettingsSchemaKey;

import GLib.Boxed;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSettingsSchemaKey is an opaque data structure and can only be accessed
 * using the following functions.
 */
class SettingsSchemaKey : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GSettingsSchemaKey))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_settings_schema_key_get_type();
  }

  /**
   * the default value for the key
   */
  Variant getDefaultValue()
  {
    GVariant* _cretval;
    _cretval = g_settings_schema_key_get_default_value(cPtr!GSettingsSchemaKey);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the description for @key, or %NULL
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_description(cPtr!GSettingsSchemaKey);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the name of @key.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_name(cPtr!GSettingsSchemaKey);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GVariant describing the range
   */
  Variant getRange()
  {
    GVariant* _cretval;
    _cretval = g_settings_schema_key_get_range(cPtr!GSettingsSchemaKey);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the summary for @key, or %NULL
   */
  string getSummary()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_summary(cPtr!GSettingsSchemaKey);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the type of @key
   */
  VariantType getValueType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_settings_schema_key_get_value_type(cPtr!GSettingsSchemaKey);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if @value is valid for @key
   */
  bool rangeCheck(Variant value)
  {
    bool _retval;
    _retval = g_settings_schema_key_range_check(cPtr!GSettingsSchemaKey, value ? value.cPtr!GVariant : null);
    return _retval;
  }
}
