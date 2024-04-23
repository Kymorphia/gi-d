module Gio.SettingsSchema;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import Gio.SettingsSchemaKey;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GSettingsSchemaSource and #GSettingsSchema APIs provide a
 * mechanism for advanced control over the loading of schemas and a
 * mechanism for introspecting their content.
 *
 * Plugin loading systems that wish to provide plugins a way to access
 * settings face the problem of how to make the schemas for these
 * settings visible to GSettings.  Typically, a plugin will want to ship
 * the schema along with itself and it won't be installed into the
 * standard system directories for schemas.
 *
 * #GSettingsSchemaSource provides a mechanism for dealing with this by
 * allowing the creation of a new 'schema source' from which schemas can
 * be acquired.  This schema source can then become part of the metadata
 * associated with the plugin and queried whenever the plugin requires
 * access to some settings.
 *
 * Consider the following example:
 *
 * |[<!-- language="C" -->
 * typedef struct
 * {
 * ...
 * GSettingsSchemaSource *schema_source;
 * ...
 * } Plugin;
 *
 * Plugin *
 * initialise_plugin (const gchar *dir)
 * {
 * Plugin *plugin;
 *
 * ...
 *
 * plugin->schema_source =
 * g_settings_schema_source_new_from_directory (dir,
 * g_settings_schema_source_get_default (), FALSE, NULL);
 *
 * ...
 *
 * return plugin;
 * }
 *
 * ...
 *
 * GSettings *
 * plugin_get_settings (Plugin      *plugin,
 * const gchar *schema_id)
 * {
 * GSettingsSchema *schema;
 *
 * if (schema_id == NULL)
 * schema_id = plugin->identifier;
 *
 * schema = g_settings_schema_source_lookup (plugin->schema_source,
 * schema_id, FALSE);
 *
 * if (schema == NULL)
 * {
 * ... disable the plugin or abort, etc ...
 * }
 *
 * return g_settings_new_full (schema, NULL, NULL);
 * }
 * ]|
 *
 * The code above shows how hooks should be added to the code that
 * initialises (or enables) the plugin to create the schema source and
 * how an API can be added to the plugin system to provide a convenient
 * way for the plugin to access its settings, using the schemas that it
 * ships.
 *
 * From the standpoint of the plugin, it would need to ensure that it
 * ships a gschemas.compiled file as part of itself, and then simply do
 * the following:
 *
 * |[<!-- language="C" -->
 * {
 * GSettings *settings;
 * gint some_value;
 *
 * settings = plugin_get_settings (self, NULL);
 * some_value = g_settings_get_int (settings, "some-value");
 * ...
 * }
 * ]|
 *
 * It's also possible that the plugin system expects the schema source
 * files (ie: .gschema.xml files) instead of a gschemas.compiled file.
 * In that case, the plugin loading system must compile the schemas for
 * itself before attempting to create the settings source.
 */
class SettingsSchema : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GSettingsSchema))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_settings_schema_get_type();
  }

  /**
   * the ID
   */
  string getId()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_get_id(cPtr!GSettingsSchema);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the #GSettingsSchemaKey for @name
   */
  SettingsSchemaKey getKey(string name)
  {
    GSettingsSchemaKey* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_settings_schema_get_key(cPtr!GSettingsSchema, _name);
    SettingsSchemaKey _retval = new SettingsSchemaKey(cast(GSettingsSchemaKey*)_cretval, true);
    return _retval;
  }

  /**
   * the path of the schema, or %NULL
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_settings_schema_get_path(cPtr!GSettingsSchema);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if such a key exists
   */
  bool hasKey(string name)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_settings_schema_has_key(cPtr!GSettingsSchema, _name);
    return _retval;
  }

  /**
   * a list of
   * the children on @settings, in no defined order
   */
  string[] listChildren()
  {
    char** _cretval;
    _cretval = g_settings_schema_list_children(cPtr!GSettingsSchema);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * a list
   * of the keys on @schema, in no defined order
   */
  string[] listKeys()
  {
    char** _cretval;
    _cretval = g_settings_schema_list_keys(cPtr!GSettingsSchema);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }
}
