module Gio.SettingsSchemaSource;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.SettingsSchema;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This is an opaque structure type.  You may not access it directly.
 */
class SettingsSchemaSource : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GSettingsSchemaSource))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_settings_schema_source_get_type();
  }

  /**
   * Attempts to create a new schema source corresponding to the contents
   * of the given directory.
   *
   * This function is not required for normal uses of #GSettings but it
   * may be useful to authors of plugin management systems.
   *
   * The directory should contain a file called `gschemas.compiled` as
   * produced by the [glib-compile-schemas][glib-compile-schemas] tool.
   *
   * If @trusted is %TRUE then `gschemas.compiled` is trusted not to be
   * corrupted. This assumption has a performance advantage, but can result
   * in crashes or inconsistent behaviour in the case of a corrupted file.
   * Generally, you should set @trusted to %TRUE for files installed by the
   * system and to %FALSE for files in the home directory.
   *
   * In either case, an empty file or some types of corruption in the file will
   * result in %G_FILE_ERROR_INVAL being returned.
   *
   * If @parent is non-%NULL then there are two effects.
   *
   * First, if g_settings_schema_source_lookup() is called with the
   * @recursive flag set to %TRUE and the schema can not be found in the
   * source, the lookup will recurse to the parent.
   *
   * Second, any references to other schemas specified within this
   * source (ie: `child` or `extends`) references may be resolved
   * from the @parent.
   *
   * For this second reason, except in very unusual situations, the
   * @parent should probably be given as the default schema source, as
   * returned by g_settings_schema_source_get_default().
   */
  static SettingsSchemaSource newFromDirectory(string directory, SettingsSchemaSource parent, bool trusted)
  {
    GSettingsSchemaSource* _cretval;
    const(char)* _directory = directory.toCString(false);
    GError *_err;
    _cretval = g_settings_schema_source_new_from_directory(_directory, parent ? parent.cPtr!GSettingsSchemaSource : null, trusted, &_err);
    if (_err)
      throw new ErrorG(_err);
    SettingsSchemaSource _retval = new SettingsSchemaSource(cast(GSettingsSchemaSource*)_cretval, true);
    return _retval;
  }

  /**
   * Lists the schemas in a given source.
   *
   * If @recursive is %TRUE then include parent sources.  If %FALSE then
   * only include the schemas from one source (ie: one directory).  You
   * probably want %TRUE.
   *
   * Non-relocatable schemas are those for which you can call
   * g_settings_new().  Relocatable schemas are those for which you must
   * use g_settings_new_with_path().
   *
   * Do not call this function from normal programs.  This is designed for
   * use by database editors, commandline tools, etc.
   */
  void listSchemas(bool recursive, out string[] nonRelocatable, out string[] relocatable)
  {
    char** _nonRelocatable;
    char** _relocatable;
    g_settings_schema_source_list_schemas(cPtr!GSettingsSchemaSource, recursive, &_nonRelocatable, &_relocatable);
    uint _lennonRelocatable;
    if (_nonRelocatable)
    {
      for (; _nonRelocatable[_lennonRelocatable] != null; _lennonRelocatable++)
      {
      }
    }
    nonRelocatable.length = _lennonRelocatable;
    foreach (i; 0 .. _lennonRelocatable)
      nonRelocatable[i] = _nonRelocatable[i].fromCString(true);
    g_free(cast(void*)_nonRelocatable);
    uint _lenrelocatable;
    if (_relocatable)
    {
      for (; _relocatable[_lenrelocatable] != null; _lenrelocatable++)
      {
      }
    }
    relocatable.length = _lenrelocatable;
    foreach (i; 0 .. _lenrelocatable)
      relocatable[i] = _relocatable[i].fromCString(true);
    g_free(cast(void*)_relocatable);
  }

  /**
   * a new #GSettingsSchema
   */
  SettingsSchema lookup(string schemaId, bool recursive)
  {
    GSettingsSchema* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    _cretval = g_settings_schema_source_lookup(cPtr!GSettingsSchemaSource, _schemaId, recursive);
    SettingsSchema _retval = new SettingsSchema(cast(GSettingsSchema*)_cretval, true);
    return _retval;
  }

  /**
   * the default schema source
   */
  static SettingsSchemaSource getDefault()
  {
    GSettingsSchemaSource* _cretval;
    _cretval = g_settings_schema_source_get_default();
    SettingsSchemaSource _retval = new SettingsSchemaSource(cast(GSettingsSchemaSource*)_cretval, false);
    return _retval;
  }
}
