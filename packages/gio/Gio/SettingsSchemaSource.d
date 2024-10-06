module Gio.SettingsSchemaSource;

import GLib.Boxed;
import GLib.ErrorG;
import Gid.gid;
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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_settings_schema_source_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Attempts to create a new schema source corresponding to the contents
   * of the given directory.
   * This function is not required for normal uses of #GSettings but it
   * may be useful to authors of plugin management systems.
   * The directory should contain a file called `gschemas.compiled` as
   * produced by the [glib-compile-schemas][glib-compile-schemas] tool.
   * If trusted is %TRUE then `gschemas.compiled` is trusted not to be
   * corrupted. This assumption has a performance advantage, but can result
   * in crashes or inconsistent behaviour in the case of a corrupted file.
   * Generally, you should set trusted to %TRUE for files installed by the
   * system and to %FALSE for files in the home directory.
   * In either case, an empty file or some types of corruption in the file will
   * result in %G_FILE_ERROR_INVAL being returned.
   * If parent is non-%NULL then there are two effects.
   * First, if [Gio.SettingsSchemaSource.lookup] is called with the
   * recursive flag set to %TRUE and the schema can not be found in the
   * source, the lookup will recurse to the parent.
   * Second, any references to other schemas specified within this
   * source $(LPAREN)ie: `child` or `extends`$(RPAREN) references may be resolved
   * from the parent.
   * For this second reason, except in very unusual situations, the
   * parent should probably be given as the default schema source, as
   * returned by [Gio.SettingsSchemaSource.getDefault].
   * Params:
   *   directory = the filename of a directory
   *   parent = a #GSettingsSchemaSource, or %NULL
   *   trusted = %TRUE, if the directory is trusted
   * Returns:
   */
  static SettingsSchemaSource newFromDirectory(string directory, SettingsSchemaSource parent, bool trusted)
  {
    GSettingsSchemaSource* _cretval;
    const(char)* _directory = directory.toCString(false);
    GError *_err;
    _cretval = g_settings_schema_source_new_from_directory(_directory, parent ? cast(GSettingsSchemaSource*)parent.cPtr(false) : null, trusted, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new SettingsSchemaSource(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Lists the schemas in a given source.
   * If recursive is %TRUE then include parent sources.  If %FALSE then
   * only include the schemas from one source $(LPAREN)ie: one directory$(RPAREN).  You
   * probably want %TRUE.
   * Non-relocatable schemas are those for which you can call
   * [Gio.Settings.new_].  Relocatable schemas are those for which you must
   * use [Gio.Settings.newWithPath].
   * Do not call this function from normal programs.  This is designed for
   * use by database editors, commandline tools, etc.
   * Params:
   *   recursive = if we should recurse
   *   nonRelocatable = the
   *     list of non-relocatable schemas, in no defined order
   *   relocatable = the list
   *     of relocatable schemas, in no defined order
   */
  void listSchemas(bool recursive, out string[] nonRelocatable, out string[] relocatable)
  {
    char** _nonRelocatable;
    char** _relocatable;
    g_settings_schema_source_list_schemas(cast(GSettingsSchemaSource*)cPtr, recursive, &_nonRelocatable, &_relocatable);
    uint _lennonRelocatable;
    if (_nonRelocatable)
    {
      for (; _nonRelocatable[_lennonRelocatable] !is null; _lennonRelocatable++)
      {
      }
    }
    nonRelocatable.length = _lennonRelocatable;
    foreach (i; 0 .. _lennonRelocatable)
      nonRelocatable[i] = _nonRelocatable[i].fromCString(true);
    safeFree(cast(void*)_nonRelocatable);
    uint _lenrelocatable;
    if (_relocatable)
    {
      for (; _relocatable[_lenrelocatable] !is null; _lenrelocatable++)
      {
      }
    }
    relocatable.length = _lenrelocatable;
    foreach (i; 0 .. _lenrelocatable)
      relocatable[i] = _relocatable[i].fromCString(true);
    safeFree(cast(void*)_relocatable);
  }

  /**
   * Looks up a schema with the identifier schema_id in source.
   * This function is not required for normal uses of #GSettings but it
   * may be useful to authors of plugin management systems or to those who
   * want to introspect the content of schemas.
   * If the schema isn't found directly in source and recursive is %TRUE
   * then the parent sources will also be checked.
   * If the schema isn't found, %NULL is returned.
   * Params:
   *   schemaId = a schema ID
   *   recursive = %TRUE if the lookup should be recursive
   * Returns: a new #GSettingsSchema
   */
  SettingsSchema lookup(string schemaId, bool recursive)
  {
    GSettingsSchema* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    _cretval = g_settings_schema_source_lookup(cast(GSettingsSchemaSource*)cPtr, _schemaId, recursive);
    auto _retval = _cretval ? new SettingsSchema(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the default system schema source.
   * This function is not required for normal uses of #GSettings but it
   * may be useful to authors of plugin management systems or to those who
   * want to introspect the content of schemas.
   * If no schemas are installed, %NULL will be returned.
   * The returned source may actually consist of multiple schema sources
   * from different directories, depending on which directories were given
   * in `XDG_DATA_DIRS` and `GSETTINGS_SCHEMA_DIR`. For this reason, all
   * lookups performed against the default source should probably be done
   * recursively.
   * Returns: the default schema source
   */
  static SettingsSchemaSource getDefault()
  {
    GSettingsSchemaSource* _cretval;
    _cretval = g_settings_schema_source_get_default();
    auto _retval = _cretval ? new SettingsSchemaSource(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
