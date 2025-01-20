module Gio.SettingsSchemaKey;

import GLib.Boxed;
import GLib.Variant;
import GLib.VariantType;
import Gid.gid;
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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_settings_schema_key_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the default value for key.
   * Note that this is the default value according to the schema.  System
   * administrator defaults and lockdown are not visible via this API.
   * Returns: the default value for the key
   */
  Variant getDefaultValue()
  {
    GVariant* _cretval;
    _cretval = g_settings_schema_key_get_default_value(cast(GSettingsSchemaKey*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the description for key.
   * If no description has been provided in the schema for key, returns
   * %NULL.
   * The description can be one sentence to several paragraphs in length.
   * Paragraphs are delimited with a double newline.  Descriptions can be
   * translated and the value returned from this function is is the
   * current locale.
   * This function is slow.  The summary and description information for
   * the schemas is not stored in the compiled schema database so this
   * function has to parse all of the source XML files in the schema
   * directory.
   * Returns: the description for key, or %NULL
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_description(cast(GSettingsSchemaKey*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the name of key.
   * Returns: the name of key.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_name(cast(GSettingsSchemaKey*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Queries the range of a key.
   * This function will return a #GVariant that fully describes the range
   * of values that are valid for key.
   * The type of #GVariant returned is `$(LPAREN)sv$(RPAREN)`. The string describes
   * the type of range restriction in effect. The type and meaning of
   * the value contained in the variant depends on the string.
   * If the string is `'type'` then the variant contains an empty array.
   * The element type of that empty array is the expected type of value
   * and all values of that type are valid.
   * If the string is `'enum'` then the variant contains an array
   * enumerating the possible values. Each item in the array is
   * a possible valid value and no other values are valid.
   * If the string is `'flags'` then the variant contains an array. Each
   * item in the array is a value that may appear zero or one times in an
   * array to be used as the value for this key. For example, if the
   * variant contained the array `['x', 'y']` then the valid values for
   * the key would be `[]`, `['x']`, `['y']`, `['x', 'y']` and
   * `['y', 'x']`.
   * Finally, if the string is `'range'` then the variant contains a pair
   * of like-typed values -- the minimum and maximum permissible values
   * for this key.
   * This information should not be used by normal programs.  It is
   * considered to be a hint for introspection purposes.  Normal programs
   * should already know what is permitted by their own schema.  The
   * format may change in any way in the future -- but particularly, new
   * forms may be added to the possibilities described above.
   * You should free the returned value with [GLib.Variant.unref] when it is
   * no longer needed.
   * Returns: a #GVariant describing the range
   */
  Variant getRange()
  {
    GVariant* _cretval;
    _cretval = g_settings_schema_key_get_range(cast(GSettingsSchemaKey*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the summary for key.
   * If no summary has been provided in the schema for key, returns
   * %NULL.
   * The summary is a short description of the purpose of the key; usually
   * one short sentence.  Summaries can be translated and the value
   * returned from this function is is the current locale.
   * This function is slow.  The summary and description information for
   * the schemas is not stored in the compiled schema database so this
   * function has to parse all of the source XML files in the schema
   * directory.
   * Returns: the summary for key, or %NULL
   */
  string getSummary()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_key_get_summary(cast(GSettingsSchemaKey*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the #GVariantType of key.
   * Returns: the type of key
   */
  VariantType getValueType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_settings_schema_key_get_value_type(cast(GSettingsSchemaKey*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if the given value is within the
   * permitted range for key.
   * It is a programmer error if value is not of the correct type — you
   * must check for this first.
   * Params:
   *   value = the value to check
   * Returns: %TRUE if value is valid for key
   */
  bool rangeCheck(Variant value)
  {
    bool _retval;
    _retval = g_settings_schema_key_range_check(cast(GSettingsSchemaKey*)cPtr, value ? cast(GVariant*)value.cPtr(false) : null);
    return _retval;
  }
}
