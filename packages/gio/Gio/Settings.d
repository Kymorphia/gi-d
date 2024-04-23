module Gio.Settings;

import GLib.Types;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
import Gio.SettingsBackend;
import Gio.SettingsSchema;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GSettings class provides a convenient API for storing and retrieving
 * application settings.
 *
 * Reads and writes can be considered to be non-blocking.  Reading
 * settings with #GSettings is typically extremely fast: on
 * approximately the same order of magnitude (but slower than) a
 * #GHashTable lookup.  Writing settings is also extremely fast in terms
 * of time to return to your application, but can be extremely expensive
 * for other threads and other processes.  Many settings backends
 * (including dconf) have lazy initialisation which means in the common
 * case of the user using their computer without modifying any settings
 * a lot of work can be avoided.  For dconf, the D-Bus service doesn't
 * even need to be started in this case.  For this reason, you should
 * only ever modify #GSettings keys in response to explicit user action.
 * Particular care should be paid to ensure that modifications are not
 * made during startup -- for example, when setting the initial value
 * of preferences widgets.  The built-in g_settings_bind() functionality
 * is careful not to write settings in response to notify signals as a
 * result of modifications that it makes to widgets.
 *
 * When creating a GSettings instance, you have to specify a schema
 * that describes the keys in your settings and their types and default
 * values, as well as some other information.
 *
 * Normally, a schema has a fixed path that determines where the settings
 * are stored in the conceptual global tree of settings. However, schemas
 * can also be '[relocatable][gsettings-relocatable]', i.e. not equipped with
 * a fixed path. This is
 * useful e.g. when the schema describes an 'account', and you want to be
 * able to store a arbitrary number of accounts.
 *
 * Paths must start with and end with a forward slash character ('/')
 * and must not contain two sequential slash characters.  Paths should
 * be chosen based on a domain name associated with the program or
 * library to which the settings belong.  Examples of paths are
 * "/org/gtk/settings/file-chooser/" and "/ca/desrt/dconf-editor/".
 * Paths should not start with "/apps/", "/desktop/" or "/system/" as
 * they often did in GConf.
 *
 * Unlike other configuration systems (like GConf), GSettings does not
 * restrict keys to basic types like strings and numbers. GSettings stores
 * values as #GVariant, and allows any #GVariantType for keys. Key names
 * are restricted to lowercase characters, numbers and '-'. Furthermore,
 * the names must begin with a lowercase character, must not end
 * with a '-', and must not contain consecutive dashes.
 *
 * Similar to GConf, the default values in GSettings schemas can be
 * localized, but the localized values are stored in gettext catalogs
 * and looked up with the domain that is specified in the
 * `gettext-domain` attribute of the <schemalist> or <schema>
 * elements and the category that is specified in the `l10n` attribute of
 * the <default> element. The string which is translated includes all text in
 * the <default> element, including any surrounding quotation marks.
 *
 * The `l10n` attribute must be set to `messages` or `time`, and sets the
 * [locale category for
 * translation](https://www.gnu.org/software/gettext/manual/html_node/Aspects.html#index-locale-categories-1).
 * The `messages` category should be used by default; use `time` for
 * translatable date or time formats. A translation comment can be added as an
 * XML comment immediately above the <default> element — it is recommended to
 * add these comments to aid translators understand the meaning and
 * implications of the default value. An optional translation `context`
 * attribute can be set on the <default> element to disambiguate multiple
 * defaults which use the same string.
 *
 * For example:
 * |[
 * <!-- Translators: A list of words which are not allowed to be typed, in
 * GVariant serialization syntax.
 * See: https://developer.gnome.org/glib/stable/gvariant-text.html -->
 * <default l10n='messages' context='Banned words'>['bad', 'words']</default>
 * ]|
 *
 * Translations of default values must remain syntactically valid serialized
 * #GVariants (e.g. retaining any surrounding quotation marks) or runtime
 * errors will occur.
 *
 * GSettings uses schemas in a compact binary form that is created
 * by the [glib-compile-schemas][glib-compile-schemas]
 * utility. The input is a schema description in an XML format.
 *
 * A DTD for the gschema XML format can be found here:
 * [gschema.dtd](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/gschema.dtd)
 *
 * The [glib-compile-schemas][glib-compile-schemas] tool expects schema
 * files to have the extension `.gschema.xml`.
 *
 * At runtime, schemas are identified by their id (as specified in the
 * id attribute of the <schema> element). The convention for schema
 * ids is to use a dotted name, similar in style to a D-Bus bus name,
 * e.g. "org.gnome.SessionManager". In particular, if the settings are
 * for a specific service that owns a D-Bus bus name, the D-Bus bus name
 * and schema id should match. For schemas which deal with settings not
 * associated with one named application, the id should not use
 * StudlyCaps, e.g. "org.gnome.font-rendering".
 *
 * In addition to #GVariant types, keys can have types that have
 * enumerated types. These can be described by a <choice>,
 * <enum> or <flags> element, as seen in the
 * [example][schema-enumerated]. The underlying type of such a key
 * is string, but you can use g_settings_get_enum(), g_settings_set_enum(),
 * g_settings_get_flags(), g_settings_set_flags() access the numeric values
 * corresponding to the string value of enum and flags keys.
 *
 * An example for default value:
 * |[
 * <schemalist>
 * <schema id="org.gtk.Test" path="/org/gtk/Test/" gettext-domain="test">
 *
 * <key name="greeting" type="s">
 * <default l10n="messages">"Hello, earthlings"</default>
 * <summary>A greeting</summary>
 * <description>
 * Greeting of the invading martians
 * </description>
 * </key>
 *
 * <key name="box" type="(ii)">
 * <default>(20,30)</default>
 * </key>
 *
 * <key name="empty-string" type="s">
 * <default>""</default>
 * <summary>Empty strings have to be provided in GVariant form</summary>
 * </key>
 *
 * </schema>
 * </schemalist>
 * ]|
 *
 * An example for ranges, choices and enumerated types:
 * |[
 * <schemalist>
 *
 * <enum id="org.gtk.Test.myenum">
 * <value nick="first" value="1"/>
 * <value nick="second" value="2"/>
 * </enum>
 *
 * <flags id="org.gtk.Test.myflags">
 * <value nick="flag1" value="1"/>
 * <value nick="flag2" value="2"/>
 * <value nick="flag3" value="4"/>
 * </flags>
 *
 * <schema id="org.gtk.Test">
 *
 * <key name="key-with-range" type="i">
 * <range min="1" max="100"/>
 * <default>10</default>
 * </key>
 *
 * <key name="key-with-choices" type="s">
 * <choices>
 * <choice value='Elisabeth'/>
 * <choice value='Annabeth'/>
 * <choice value='Joe'/>
 * </choices>
 * <aliases>
 * <alias value='Anna' target='Annabeth'/>
 * <alias value='Beth' target='Elisabeth'/>
 * </aliases>
 * <default>'Joe'</default>
 * </key>
 *
 * <key name='enumerated-key' enum='org.gtk.Test.myenum'>
 * <default>'first'</default>
 * </key>
 *
 * <key name='flags-key' flags='org.gtk.Test.myflags'>
 * <default>["flag1","flag2"]</default>
 * </key>
 * </schema>
 * </schemalist>
 * ]|
 *
 * ## Vendor overrides
 *
 * Default values are defined in the schemas that get installed by
 * an application. Sometimes, it is necessary for a vendor or distributor
 * to adjust these defaults. Since patching the XML source for the schema
 * is inconvenient and error-prone,
 * [glib-compile-schemas][glib-compile-schemas] reads so-called vendor
 * override' files. These are keyfiles in the same directory as the XML
 * schema sources which can override default values. The schema id serves
 * as the group name in the key file, and the values are expected in
 * serialized GVariant form, as in the following example:
 * |[
 * [org.gtk.Example]
 * key1='string'
 * key2=1.5
 * ]|
 *
 * glib-compile-schemas expects schema files to have the extension
 * `.gschema.override`.
 *
 * ## Binding
 *
 * A very convenient feature of GSettings lets you bind #GObject properties
 * directly to settings, using g_settings_bind(). Once a GObject property
 * has been bound to a setting, changes on either side are automatically
 * propagated to the other side. GSettings handles details like mapping
 * between GObject and GVariant types, and preventing infinite cycles.
 *
 * This makes it very easy to hook up a preferences dialog to the
 * underlying settings. To make this even more convenient, GSettings
 * looks for a boolean property with the name "sensitivity" and
 * automatically binds it to the writability of the bound setting.
 * If this 'magic' gets in the way, it can be suppressed with the
 * %G_SETTINGS_BIND_NO_SENSITIVITY flag.
 *
 * ## Relocatable schemas # {#gsettings-relocatable}
 *
 * A relocatable schema is one with no `path` attribute specified on its
 * <schema> element. By using g_settings_new_with_path(), a #GSettings object
 * can be instantiated for a relocatable schema, assigning a path to the
 * instance. Paths passed to g_settings_new_with_path() will typically be
 * constructed dynamically from a constant prefix plus some form of instance
 * identifier; but they must still be valid GSettings paths. Paths could also
 * be constant and used with a globally installed schema originating from a
 * dependency library.
 *
 * For example, a relocatable schema could be used to store geometry information
 * for different windows in an application. If the schema ID was
 * `org.foo.MyApp.Window`, it could be instantiated for paths
 * `/org/foo/MyApp/main/`, `/org/foo/MyApp/document-1/`,
 * `/org/foo/MyApp/document-2/`, etc. If any of the paths are well-known
 * they can be specified as <child> elements in the parent schema, e.g.:
 * |[
 * <schema id="org.foo.MyApp" path="/org/foo/MyApp/">
 * <child name="main" schema="org.foo.MyApp.Window"/>
 * </schema>
 * ]|
 *
 * ## Build system integration # {#gsettings-build-system}
 *
 * GSettings comes with autotools integration to simplify compiling and
 * installing schemas. To add GSettings support to an application, add the
 * following to your `configure.ac`:
 * |[
 * GLIB_GSETTINGS
 * ]|
 *
 * In the appropriate `Makefile.am`, use the following snippet to compile and
 * install the named schema:
 * |[
 * gsettings_SCHEMAS = org.foo.MyApp.gschema.xml
 * EXTRA_DIST = $(gsettings_SCHEMAS)
 *
 * @GSETTINGS_RULES@
 * ]|
 *
 * No changes are needed to the build system to mark a schema XML file for
 * translation. Assuming it sets the `gettext-domain` attribute, a schema may
 * be marked for translation by adding it to `POTFILES.in`, assuming gettext
 * 0.19 is in use (the preferred method for translation):
 * |[
 * data/org.foo.MyApp.gschema.xml
 * ]|
 *
 * Alternatively, if intltool 0.50.1 is in use:
 * |[
 * [type: gettext/gsettings]data/org.foo.MyApp.gschema.xml
 * ]|
 *
 * GSettings will use gettext to look up translations for the <summary> and
 * <description> elements, and also any <default> elements which have a `l10n`
 * attribute set. Translations must not be included in the `.gschema.xml` file
 * by the build system, for example by using intltool XML rules with a
 * `.gschema.xml.in` template.
 *
 * If an enumerated type defined in a C header file is to be used in a GSettings
 * schema, it can either be defined manually using an <enum> element in the
 * schema XML, or it can be extracted automatically from the C header. This
 * approach is preferred, as it ensures the two representations are always
 * synchronised. To do so, add the following to the relevant `Makefile.am`:
 * |[
 * gsettings_ENUM_NAMESPACE = org.foo.MyApp
 * gsettings_ENUM_FILES = my-app-enums.h my-app-misc.h
 * ]|
 *
 * `gsettings_ENUM_NAMESPACE` specifies the schema namespace for the enum files,
 * which are specified in `gsettings_ENUM_FILES`. This will generate a
 * `org.foo.MyApp.enums.xml` file containing the extracted enums, which will be
 * automatically included in the schema compilation, install and uninstall
 * rules. It should not be committed to version control or included in
 * `EXTRA_DIST`.
 */
class Settings : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_settings_get_type();
  }

  /**
   * a new #GSettings object
   */
  this(string schemaId)
  {
    GSettings* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    _cretval = g_settings_new(_schemaId);
    this(_cretval, true);
  }

  /**
   * a new #GSettings object
   */
  static Settings newFull(SettingsSchema schema, SettingsBackend backend, string path)
  {
    GSettings* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_settings_new_full(schema ? schema.cPtr!GSettingsSchema : null, backend ? backend.cPtr!GSettingsBackend : null, _path);
    Settings _retval = ObjectG.getDObject!Settings(cast(GSettings*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GSettings object
   */
  static Settings newWithBackend(string schemaId, SettingsBackend backend)
  {
    GSettings* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    _cretval = g_settings_new_with_backend(_schemaId, backend ? backend.cPtr!GSettingsBackend : null);
    Settings _retval = ObjectG.getDObject!Settings(cast(GSettings*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GSettings object
   */
  static Settings newWithBackendAndPath(string schemaId, SettingsBackend backend, string path)
  {
    GSettings* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    const(char)* _path = path.toCString(false);
    _cretval = g_settings_new_with_backend_and_path(_schemaId, backend ? backend.cPtr!GSettingsBackend : null, _path);
    Settings _retval = ObjectG.getDObject!Settings(cast(GSettings*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GSettings object
   */
  static Settings newWithPath(string schemaId, string path)
  {
    GSettings* _cretval;
    const(char)* _schemaId = schemaId.toCString(false);
    const(char)* _path = path.toCString(false);
    _cretval = g_settings_new_with_path(_schemaId, _path);
    Settings _retval = ObjectG.getDObject!Settings(cast(GSettings*)_cretval, true);
    return _retval;
  }

  /**
   * a list of
   * relocatable #GSettings schemas that are available, in no defined order.
   * The list must not be modified or freed.
   */
  static string[] listRelocatableSchemas()
  {
    const(char*)* _cretval;
    _cretval = g_settings_list_relocatable_schemas();
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * a list of
   * #GSettings schemas that are available, in no defined order.  The list
   * must not be modified or freed.
   */
  static string[] listSchemas()
  {
    const(char*)* _cretval;
    _cretval = g_settings_list_schemas();
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Ensures that all pending operations are complete for the default backend.
   *
   * Writes made to a #GSettings are handled asynchronously.  For this
   * reason, it is very unlikely that the changes have it to disk by the
   * time g_settings_set() returns.
   *
   * This call will block until all of the writes have made it to the
   * backend.  Since the mainloop is not running, no change notifications
   * will be dispatched during this call (but some may be queued by the
   * time the call is done).
   */
  static void sync()
  {
    g_settings_sync();
  }

  /**
   * Removes an existing binding for @property on @object.
   *
   * Note that bindings are automatically removed when the
   * object is finalized, so it is rarely necessary to call this
   * function.
   */
  static void unbind(ObjectG object, string property)
  {
    const(char)* _property = property.toCString(false);
    g_settings_unbind(object ? object.cPtr!ObjectC : null, _property);
  }

  /**
   * Applies any changes that have been made to the settings.  This
   * function does nothing unless @settings is in 'delay-apply' mode;
   * see g_settings_delay().  In the normal case settings are always
   * applied immediately.
   */
  void apply()
  {
    g_settings_apply(cPtr!GSettings);
  }

  /**
   * Create a binding between the @key in the @settings object
   * and the property @property of @object.
   *
   * The binding uses the default GIO mapping functions to map
   * between the settings and property values. These functions
   * handle booleans, numeric types and string types in a
   * straightforward way. Use g_settings_bind_with_mapping() if
   * you need a custom mapping, or map between types that are not
   * supported by the default mapping functions.
   *
   * Unless the @flags include %G_SETTINGS_BIND_NO_SENSITIVITY, this
   * function also establishes a binding between the writability of
   * @key and the "sensitive" property of @object (if @object has
   * a boolean property by that name). See g_settings_bind_writable()
   * for more details about writable bindings.
   *
   * Note that the lifecycle of the binding is tied to @object,
   * and that you can have only one binding per object property.
   * If you bind the same property twice on the same object, the second
   * binding overrides the first one.
   */
  void bind(string key, ObjectG object, string property, SettingsBindFlags flags)
  {
    const(char)* _key = key.toCString(false);
    const(char)* _property = property.toCString(false);
    g_settings_bind(cPtr!GSettings, _key, object ? object.cPtr!ObjectC : null, _property, flags);
  }

  /**
   * Create a binding between the writability of @key in the
   * @settings object and the property @property of @object.
   * The property must be boolean; "sensitive" or "visible"
   * properties of widgets are the most likely candidates.
   *
   * Writable bindings are always uni-directional; changes of the
   * writability of the setting will be propagated to the object
   * property, not the other way.
   *
   * When the @inverted argument is %TRUE, the binding inverts the
   * value as it passes from the setting to the object, i.e. @property
   * will be set to %TRUE if the key is not writable.
   *
   * Note that the lifecycle of the binding is tied to @object,
   * and that you can have only one binding per object property.
   * If you bind the same property twice on the same object, the second
   * binding overrides the first one.
   */
  void bindWritable(string key, ObjectG object, string property, bool inverted)
  {
    const(char)* _key = key.toCString(false);
    const(char)* _property = property.toCString(false);
    g_settings_bind_writable(cPtr!GSettings, _key, object ? object.cPtr!ObjectC : null, _property, inverted);
  }

  /**
   * a new #GAction
   */
  Action createAction(string key)
  {
    GAction* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_create_action(cPtr!GSettings, _key);
    Action _retval = ObjectG.getDObject!Action(cast(GAction*)_cretval, true);
    return _retval;
  }

  /**
   * Changes the #GSettings object into 'delay-apply' mode. In this
   * mode, changes to @settings are not immediately propagated to the
   * backend, but kept locally until g_settings_apply() is called.
   */
  void delay()
  {
    g_settings_delay(cPtr!GSettings);
  }

  /**
   * a boolean
   */
  bool getBoolean(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_boolean(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * a 'child' settings object
   */
  Settings getChild(string name)
  {
    GSettings* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_settings_get_child(cPtr!GSettings, _name);
    Settings _retval = ObjectG.getDObject!Settings(cast(GSettings*)_cretval, true);
    return _retval;
  }

  /**
   * the default value
   */
  Variant getDefaultValue(string key)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_default_value(cPtr!GSettings, _key);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a double
   */
  double getDouble(string key)
  {
    double _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_double(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * the enum value
   */
  int getEnum(string key)
  {
    int _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_enum(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * the flags value
   */
  uint getFlags(string key)
  {
    uint _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_flags(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * %TRUE if @settings has unapplied changes
   */
  bool getHasUnapplied()
  {
    bool _retval;
    _retval = g_settings_get_has_unapplied(cPtr!GSettings);
    return _retval;
  }

  /**
   * an integer
   */
  int getInt(string key)
  {
    int _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_int(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * a 64-bit integer
   */
  long getInt64(string key)
  {
    long _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_int64(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * the result, which may be %NULL
   */
  void* getMapped(string key, SettingsGetMapping mapping)
  {
    static SettingsGetMapping _static_mapping;

    extern(C) bool _mappingCallback(GVariant* value, void** result, void* userData)
    {
      bool _retval = _static_mapping(value ? new Variant(value, false) : null, *result);
      return _retval;
    }

    _static_mapping = mapping;
    void* _retval;
    const(char)* _key = key.toCString(false);
    ptrFreezeGC(cast(void*)&mapping);
    _retval = g_settings_get_mapped(cPtr!GSettings, _key, &_mappingCallback, cast(void*)&mapping);
    _static_mapping = null;
    return _retval;
  }

  /**
   * Queries the range of a key.
   */
  Variant getRange(string key)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_range(cPtr!GSettings, _key);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a newly-allocated string
   */
  string getString(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_string(cPtr!GSettings, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a
   * newly-allocated, %NULL-terminated array of strings, the value that
   * is stored at @key in @settings.
   */
  string[] getStrv(string key)
  {
    char** _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_strv(cPtr!GSettings, _key);
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
   * an unsigned integer
   */
  uint getUint(string key)
  {
    uint _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_uint(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * a 64-bit unsigned integer
   */
  ulong getUint64(string key)
  {
    ulong _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_get_uint64(cPtr!GSettings, _key);
    return _retval;
  }

  /**
   * the user's value, if set
   */
  Variant getUserValue(string key)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_user_value(cPtr!GSettings, _key);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GVariant
   */
  Variant getValue(string key)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_settings_get_value(cPtr!GSettings, _key);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the key @name is writable
   */
  bool isWritable(string name)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_settings_is_writable(cPtr!GSettings, _name);
    return _retval;
  }

  /**
   * a list of the children
   * on @settings, in no defined order
   */
  string[] listChildren()
  {
    char** _cretval;
    _cretval = g_settings_list_children(cPtr!GSettings);
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
   * of the keys on @settings, in no defined order
   */
  string[] listKeys()
  {
    char** _cretval;
    _cretval = g_settings_list_keys(cPtr!GSettings);
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
   * %TRUE if @value is valid for @key
   */
  bool rangeCheck(string key, Variant value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_range_check(cPtr!GSettings, _key, value ? value.cPtr!GVariant : null);
    return _retval;
  }

  /**
   * Resets @key to its default value.
   *
   * This call resets the key, as much as possible, to its default value.
   * That might be the value specified in the schema or the one set by the
   * administrator.
   */
  void reset(string key)
  {
    const(char)* _key = key.toCString(false);
    g_settings_reset(cPtr!GSettings, _key);
  }

  /**
   * Reverts all non-applied changes to the settings.  This function
   * does nothing unless @settings is in 'delay-apply' mode; see
   * g_settings_delay().  In the normal case settings are always applied
   * immediately.
   *
   * Change notifications will be emitted for affected keys.
   */
  void revert()
  {
    g_settings_revert(cPtr!GSettings);
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setBoolean(string key, bool value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_boolean(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setDouble(string key, double value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_double(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE, if the set succeeds
   */
  bool setEnum(string key, int value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_enum(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE, if the set succeeds
   */
  bool setFlags(string key, uint value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_flags(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setInt(string key, int value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_int(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setInt64(string key, long value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_int64(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setString(string key, string value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    const(char)* _value = value.toCString(false);
    _retval = g_settings_set_string(cPtr!GSettings, _key, _value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setStrv(string key, string[] value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    char*[] _tmpvalue;
    foreach (s; value)
      _tmpvalue ~= s.toCString(false);
    _tmpvalue ~= null;
    const(char*)* _value = _tmpvalue.ptr;
    _retval = g_settings_set_strv(cPtr!GSettings, _key, _value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setUint(string key, uint value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_uint(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setUint64(string key, ulong value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_uint64(cPtr!GSettings, _key, value);
    return _retval;
  }

  /**
   * %TRUE if setting the key succeeded,
   * %FALSE if the key was not writable
   */
  bool setValue(string key, Variant value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_settings_set_value(cPtr!GSettings, _key, value ? value.cPtr!GVariant : null);
    return _retval;
  }

  /**
   * The "changed" signal is emitted when a key has potentially changed.
   * You should call one of the g_settings_get() calls to check the new
   * value.
   *
   * This signal supports detailed connections.  You can connect to the
   * detailed signal "changed::x" in order to only receive callbacks
   * when key "x" changes.
   *
   * Note that @settings only emits this signal if you have read @key at
   * least once while a signal handler was already connected for @key.
   */
  ulong connectChanged(void delegate(string key, Settings settings) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto settings = getVal!Settings(_paramVals);
      auto key = getVal!string(&_paramVals[1]);
      char* _key = key.toCString(false);
      _dgClosure.dlg(key, settings);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * %TRUE to stop other handlers from being invoked for the
   * event. FALSE to propagate the event further.
   */
  ulong connectWritableChangeEvent(bool delegate(uint key, Settings settings) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto settings = getVal!Settings(_paramVals);
      auto key = getVal!uint(&_paramVals[1]);
      _retval = _dgClosure.dlg(key, settings);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("writable-change-event", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The "writable-changed" signal is emitted when the writability of a
   * key has potentially changed.  You should call
   * g_settings_is_writable() in order to determine the new status.
   *
   * This signal supports detailed connections.  You can connect to the
   * detailed signal "writable-changed::x" in order to only receive
   * callbacks when the writability of "x" changes.
   */
  ulong connectWritableChanged(void delegate(string key, Settings settings) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto settings = getVal!Settings(_paramVals);
      auto key = getVal!string(&_paramVals[1]);
      char* _key = key.toCString(false);
      _dgClosure.dlg(key, settings);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("writable-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
