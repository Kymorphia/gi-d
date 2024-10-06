module Gio.SettingsSchema;

import GLib.Boxed;
import Gid.gid;
import Gio.SettingsSchemaKey;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The [Gio.SettingsSchemaSource] and `GSettingsSchema` APIs provide a
 * mechanism for advanced control over the loading of schemas and a
 * mechanism for introspecting their content.
 * Plugin loading systems that wish to provide plugins a way to access
 * settings face the problem of how to make the schemas for these
 * settings visible to GSettings.  Typically, a plugin will want to ship
 * the schema along with itself and it won't be installed into the
 * standard system directories for schemas.
 * [Gio.SettingsSchemaSource] provides a mechanism for dealing with this
 * by allowing the creation of a new ‘schema source’ from which schemas can
 * be acquired.  This schema source can then become part of the metadata
 * associated with the plugin and queried whenever the plugin requires
 * access to some settings.
 * Consider the following example:
 * ```c
 * typedef struct
 * {
 * …
 * GSettingsSchemaSource *schema_source;
 * …
 * } Plugin;
 * Plugin *
 * initialise_plugin $(LPAREN)const gchar *dir$(RPAREN)
 * {
 * Plugin *plugin;
 * …
 * plugin->schema_source \=
 * g_settings_schema_source_new_from_directory $(LPAREN)dir,
 * g_settings_schema_source_get_default $(LPAREN)$(RPAREN), FALSE, NULL$(RPAREN);
 * …
 * return plugin;
 * }
 * …
 * GSettings *
 * plugin_get_settings $(LPAREN)Plugin      *plugin,
 * const gchar *schema_id$(RPAREN)
 * {
 * GSettingsSchema *schema;
 * if $(LPAREN)schema_id \=\= NULL$(RPAREN)
 * schema_id \= plugin->identifier;
 * schema \= g_settings_schema_source_lookup $(LPAREN)plugin->schema_source,
 * schema_id, FALSE$(RPAREN);
 * if $(LPAREN)schema \=\= NULL$(RPAREN)
 * {
 * … disable the plugin or abort, etc …
 * }
 * return g_settings_new_full $(LPAREN)schema, NULL, NULL$(RPAREN);
 * }
 * ```
 * The code above shows how hooks should be added to the code that
 * initialises $(LPAREN)or enables$(RPAREN) the plugin to create the schema source and
 * how an API can be added to the plugin system to provide a convenient
 * way for the plugin to access its settings, using the schemas that it
 * ships.
 * From the standpoint of the plugin, it would need to ensure that it
 * ships a gschemas.compiled file as part of itself, and then simply do
 * the following:
 * ```c
 * {
 * GSettings *settings;
 * gint some_value;
 * settings \= plugin_get_settings $(LPAREN)self, NULL$(RPAREN);
 * some_value \= g_settings_get_int $(LPAREN)settings, "some-value"$(RPAREN);
 * …
 * }
 * ```
 * It's also possible that the plugin system expects the schema source
 * files $(LPAREN)ie: `.gschema.xml` files$(RPAREN) instead of a `gschemas.compiled` file.
 * In that case, the plugin loading system must compile the schemas for
 * itself before attempting to create the settings source.
 */
class SettingsSchema : Boxed
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
    return g_settings_schema_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Get the ID of schema.
   * Returns: the ID
   */
  string getId()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_get_id(cast(GSettingsSchema*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the key named name from schema.
   * It is a programmer error to request a key that does not exist.  See
   * [Gio.SettingsSchema.listKeys].
   * Params:
   *   name = the name of a key
   * Returns: the #GSettingsSchemaKey for name
   */
  SettingsSchemaKey getKey(string name)
  {
    GSettingsSchemaKey* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_settings_schema_get_key(cast(GSettingsSchema*)cPtr, _name);
    auto _retval = _cretval ? new SettingsSchemaKey(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the path associated with schema, or %NULL.
   * Schemas may be single-instance or relocatable.  Single-instance
   * schemas correspond to exactly one set of keys in the backend
   * database: those located at the path returned by this function.
   * Relocatable schemas can be referenced by other schemas and can
   * therefore describe multiple sets of keys at different locations.  For
   * relocatable schemas, this function will return %NULL.
   * Returns: the path of the schema, or %NULL
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_get_path(cast(GSettingsSchema*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks if schema has a key named name.
   * Params:
   *   name = the name of a key
   * Returns: %TRUE if such a key exists
   */
  bool hasKey(string name)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_settings_schema_has_key(cast(GSettingsSchema*)cPtr, _name);
    return _retval;
  }

  /**
   * Gets the list of children in schema.
   * You should free the return value with [GLib.Global.strfreev] when you are done
   * with it.
   * Returns: a list of
   *   the children on settings, in no defined order
   */
  string[] listChildren()
  {
    char** _cretval;
    _cretval = g_settings_schema_list_children(cast(GSettingsSchema*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Introspects the list of keys on schema.
   * You should probably not be calling this function from "normal" code
   * $(LPAREN)since you should already know what keys are in your schema$(RPAREN).  This
   * function is intended for introspection reasons.
   * Returns: a list
   *   of the keys on schema, in no defined order
   */
  string[] listKeys()
  {
    char** _cretval;
    _cretval = g_settings_schema_list_keys(cast(GSettingsSchema*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }
}
