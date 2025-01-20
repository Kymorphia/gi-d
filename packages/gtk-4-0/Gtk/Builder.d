module Gtk.Builder;

import GLib.ErrorG;
import GLib.SList;
import GObject.Closure;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.Types;
import GObject.Value;
import Gid.gid;
import Gtk.BuilderScope;
import Gtk.BuilderScopeT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkBuilder` reads XML descriptions of a user interface and
 * instantiates the described objects.
 * To create a `GtkBuilder` from a user interface description, call
 * [Gtk.Builder.newFromFile], [Gtk.Builder.newFromResource]
 * or [Gtk.Builder.newFromString].
 * In the $(LPAREN)unusual$(RPAREN) case that you want to add user interface
 * descriptions from multiple sources to the same `GtkBuilder` you can
 * call [Gtk.Builder.new_] to get an empty builder and populate it by
 * $(LPAREN)multiple$(RPAREN) calls to [Gtk.Builder.addFromFile],
 * [Gtk.Builder.addFromResource] or
 * [Gtk.Builder.addFromString].
 * A `GtkBuilder` holds a reference to all objects that it has constructed
 * and drops these references when it is finalized. This finalization can
 * cause the destruction of non-widget objects or widgets which are not
 * contained in a toplevel window. For toplevel windows constructed by a
 * builder, it is the responsibility of the user to call
 * [Gtk.Window.destroy] to get rid of them and all the widgets
 * they contain.
 * The functions [Gtk.Builder.getObject] and
 * [Gtk.Builder.getObjects] can be used to access the widgets in
 * the interface by the names assigned to them inside the UI description.
 * Toplevel windows returned by these functions will stay around until the
 * user explicitly destroys them with [Gtk.Window.destroy]. Other
 * widgets will either be part of a larger hierarchy constructed by the
 * builder $(LPAREN)in which case you should not have to worry about their lifecycle$(RPAREN),
 * or without a parent, in which case they have to be added to some container
 * to make use of them. Non-widget objects need to be reffed with
 * [GObject.ObjectG.ref_] to keep them beyond the lifespan of the builder.
 * ## GtkBuilder UI Definitions
 * `GtkBuilder` parses textual descriptions of user interfaces which are
 * specified in XML format. We refer to these descriptions as “GtkBuilder
 * UI definitions” or just “UI definitions” if the context is clear.
 * ### Structure of UI definitions
 * UI definition files are always encoded in UTF-8.
 * The toplevel element is `<interface>`. It optionally takes a “domain”
 * attribute, which will make the builder look for translated strings
 * using `dgettext$(LPAREN)$(RPAREN)` in the domain specified. This can also be done by
 * calling [Gtk.Builder.setTranslationDomain] on the builder.
 * For example:
 * ```xml
 * <?xml version\="1.0" encoding\="UTF-8">
 * <interface domain\="your-app">
 * ...
 * </interface>
 * ```
 * ### Requirements
 * The target toolkit version$(LPAREN)s$(RPAREN) are described by `<requires>` elements,
 * the “lib” attribute specifies the widget library in question $(LPAREN)currently
 * the only supported value is “gtk”$(RPAREN) and the “version” attribute specifies
 * the target version in the form “`<major>`.`<minor>`”. `GtkBuilder` will
 * error out if the version requirements are not met. For example:
 * ```xml
 * <?xml version\="1.0" encoding\="UTF-8">
 * <interface domain\="your-app">
 * <requires lib\="gtk" version\="4.0" />
 * </interface>
 * ```
 * ### Objects
 * Objects are defined as children of the `<interface>` element.
 * Objects are described by `<object>` elements, which can contain
 * `<property>` elements to set properties, `<signal>` elements which
 * connect signals to handlers, and `<child>` elements, which describe
 * child objects.
 * Typically, the specific kind of object represented by an `<object>`
 * element is specified by the “class” attribute. If the type has not
 * been loaded yet, GTK tries to find the `get_type$(LPAREN)$(RPAREN)` function from the
 * class name by applying heuristics. This works in most cases, but if
 * necessary, it is possible to specify the name of the `get_type$(LPAREN)$(RPAREN)`
 * function explicitly with the "type-func" attribute. If your UI definition
 * is referencing internal types, you should make sure to call
 * `[GObject.Global.typeEnsure]` for each object type before parsing the UI definition.
 * Objects may be given a name with the “id” attribute, which allows the
 * application to retrieve them from the builder with
 * [Gtk.Builder.getObject]. An id is also necessary to use the
 * object as property value in other parts of the UI definition. GTK
 * reserves ids starting and ending with `___` $(LPAREN)three consecutive
 * underscores$(RPAREN) for its own purposes.
 * ### Properties
 * Setting properties of objects is pretty straightforward with the
 * `<property>` element: the “name” attribute specifies the name of the
 * property, and the content of the element specifies the value:
 * ```xml
 * <object class\="GtkButton">
 * <property name\="label">Hello, world</property>
 * </object>
 * ```
 * If the “translatable” attribute is set to a true value, GTK uses
 * `gettext$(LPAREN)$(RPAREN)` $(LPAREN)or `dgettext$(LPAREN)$(RPAREN)` if the builder has a translation domain set$(RPAREN)
 * to find a translation for the value. This happens before the value
 * is parsed, so it can be used for properties of any type, but it is
 * probably most useful for string properties. It is also possible to
 * specify a context to disambiguate short strings, and comments which
 * may help the translators:
 * ```xml
 * <object class\="GtkButton">
 * <property name\="label" translatable\="yes" context\="button">Hello, world</property>
 * </object>
 * ```
 * `GtkBuilder` can parse textual representations for the most common
 * property types:
 * - characters
 * - strings
 * - integers
 * - floating-point numbers
 * - booleans $(LPAREN)strings like “TRUE”, “t”, “yes”, “y”, “1” are interpreted
 * as true values, strings like “FALSE”, “f”, “no”, “n”, “0” are interpreted
 * as false values$(RPAREN)
 * - enumeration types $(LPAREN)can be specified by their full C identifier their short
 * name used when registering the enumeration type, or their integer value$(RPAREN)
 * - flag types $(LPAREN)can be specified by their C identifier, short name, integer
 * value, and optionally combined with “|” for bitwise OR, e.g.
 * “GTK_INPUT_HINT_EMOJI|GTK_INPUT_HINT_LOWERCASE”, or “emoji|lowercase”$(RPAREN)
 * - colors $(LPAREN)in a format understood by [Gdk.RGBA.parse]$(RPAREN)
 * - `GVariant` $(LPAREN)can be specified in the format understood by
 * [GLib.Variant.parse]$(RPAREN)
 * - pixbufs $(LPAREN)can be specified as a filename of an image file to load$(RPAREN)
 * Objects can be referred to by their name and by default refer to
 * objects declared in the local XML fragment and objects exposed via
 * [Gtk.Builder.exposeObject]. In general, `GtkBuilder` allows
 * forward references to objects declared in the local XML; an object
 * doesn’t have to be constructed before it can be referred to. The
 * exception to this rule is that an object has to be constructed before
 * it can be used as the value of a construct-only property.
 * ### Child objects
 * Many widgets have properties for child widgets, such as
 * [Gtk.Expander.child]. In this case, the preferred way to
 * specify the child widget in a ui file is to simply set the property:
 * ```xml
 * <object class\="GtkExpander">
 * <property name\="child">
 * <object class\="GtkLabel">
 * ...
 * </object>
 * </property>
 * </object>
 * ```
 * Generic containers that can contain an arbitrary number of children,
 * such as [Gtk.Box] instead use the `<child>` element. A `<child>`
 * element contains an `<object>` element which describes the child object.
 * Most often, child objects are widgets inside a container, but they can
 * also be, e.g., actions in an action group, or columns in a tree model.
 * Any object type that implements the [Gtk.Buildable] interface can
 * specify how children may be added to it. Since many objects and widgets that
 * are included with GTK already implement the `GtkBuildable` interface,
 * typically child objects can be added using the `<child>` element without
 * having to be concerned about the underlying implementation.
 * See the [`GtkWidget` documentation](class.Widget.html#gtkwidget-as-gtkbuildable)
 * for many examples of using `GtkBuilder` with widgets, including setting
 * child objects using the `<child>` element.
 * A noteworthy special case to the general rule that only objects implementing
 * `GtkBuildable` may specify how to handle the `<child>` element is that
 * `GtkBuilder` provides special support for adding objects to a
 * [Gio.ListStore] by using the `<child>` element. For instance:
 * ```xml
 * <object class\="GListStore">
 * <property name\="item-type">MyObject</property>
 * <child>
 * <object class\="MyObject" />
 * </child>
 * ...
 * </object>
 * ```
 * ### Property bindings
 * It is also possible to bind a property value to another object's
 * property value using the attributes "bind-source" to specify the
 * source object of the binding, and optionally, "bind-property" and
 * "bind-flags" to specify the source property and source binding flags
 * respectively. Internally, `GtkBuilder` implements this using
 * [GObject.Binding] objects.
 * For instance, in the example below the “label” property of the
 * `bottom_label` widget is bound to the “label” property of the
 * `top_button` widget:
 * ```xml
 * <object class\="GtkBox">
 * <property name\="orientation">vertical</property>
 * <child>
 * <object class\="GtkButton" id\="top_button">
 * <property name\="label">Hello, world</property>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkLabel" id\="bottom_label">
 * <property name\="label"
 * bind-source\="top_button"
 * bind-property\="label"
 * bind-flags\="sync-create" />
 * </object>
 * </child>
 * </object>
 * ```
 * For more information, see the documentation of the
 * [GObject.ObjectG.bindProperty] method.
 * Please note that another way to set up bindings between objects in .ui files
 * is to use the `GtkExpression` methodology. See the
 * [`GtkExpression` documentation](class.Expression.html#gtkexpression-in-ui-files)
 * for more information.
 * ### Internal children
 * Sometimes it is necessary to refer to widgets which have implicitly
 * been constructed by GTK as part of a composite widget, to set
 * properties on them or to add further children $(LPAREN)e.g. the content area
 * of a `GtkDialog`$(RPAREN). This can be achieved by setting the “internal-child”
 * property of the `<child>` element to a true value. Note that `GtkBuilder`
 * still requires an `<object>` element for the internal child, even if it
 * has already been constructed.
 * ### Specialized children
 * A number of widgets have different places where a child can be added
 * $(LPAREN)e.g. tabs vs. page content in notebooks$(RPAREN). This can be reflected in
 * a UI definition by specifying the “type” attribute on a `<child>`
 * The possible values for the “type” attribute are described in the
 * sections describing the widget-specific portions of UI definitions.
 * ### Signal handlers and function pointers
 * Signal handlers are set up with the `<signal>` element. The “name”
 * attribute specifies the name of the signal, and the “handler” attribute
 * specifies the function to connect to the signal.
 * ```xml
 * <object class\="GtkButton" id\="hello_button">
 * <signal name\="clicked" handler\="hello_button__clicked" />
 * </object>
 * ```
 * The remaining attributes, “after”, “swapped” and “object”, have the
 * same meaning as the corresponding parameters of the
 * func@GObject.signal_connect_object or func@GObject.signal_connect_data
 * functions:
 * - “after” matches the `G_CONNECT_AFTER` flag, and will ensure that the
 * handler is called after the default class closure for the signal
 * - “swapped” matches the `G_CONNECT_SWAPPED` flag, and will swap the
 * instance and closure arguments when invoking the signal handler
 * - “object” will bind the signal handler to the lifetime of the object
 * referenced by the attribute
 * By default "swapped" will be set to "yes" if not specified otherwise, in
 * the case where "object" is set, for convenience. A “last_modification_time”
 * attribute is also allowed, but it does not have a meaning to the builder.
 * When compiling applications for Windows, you must declare signal callbacks
 * with the `G_MODULE_EXPORT` decorator, or they will not be put in the symbol
 * table:
 * ```c
 * G_MODULE_EXPORT void
 * hello_button__clicked $(LPAREN)GtkButton *button,
 * gpointer data$(RPAREN)
 * {
 * // ...
 * }
 * ```
 * On Linux and Unix, this is not necessary; applications should instead
 * be compiled with the `-Wl,--export-dynamic` argument inside their compiler
 * flags, and linked against `gmodule-export-2.0`.
 * ## Example UI Definition
 * ```xml
 * <interface>
 * <object class\="GtkDialog" id\="dialog1">
 * <child internal-child\="content_area">
 * <object class\="GtkBox">
 * <child internal-child\="action_area">
 * <object class\="GtkBox">
 * <child>
 * <object class\="GtkButton" id\="ok_button">
 * <property name\="label" translatable\="yes">_Ok</property>
 * <property name\="use-underline">True</property>
 * <signal name\="clicked" handler\="ok_button_clicked"/>
 * </object>
 * </child>
 * </object>
 * </child>
 * </object>
 * </child>
 * </object>
 * </interface>
 * ```
 * ## Using GtkBuildable for extending UI definitions
 * Objects can implement the [Gtk.Buildable] interface to add custom
 * elements and attributes to the XML. Typically, any extension will be
 * documented in each type that implements the interface.
 * ## Templates
 * When describing a [Gtk.Widget], you can use the `<template>` tag to
 * describe a UI bound to a specific widget type. GTK will automatically load
 * the UI definition when instantiating the type, and bind children and
 * signal handlers to instance fields and function symbols.
 * For more information, see the [`GtkWidget` documentation](class.Widget.html#building-composite-widgets-from-template-xml)
 * for details.
 */
class Builder : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty builder object.
   * This function is only useful if you intend to make multiple calls
   * to [Gtk.Builder.addFromFile], [Gtk.Builder.addFromResource]
   * or [Gtk.Builder.addFromString] in order to merge multiple UI
   * descriptions into a single builder.
   * Returns: a new $(LPAREN)empty$(RPAREN) `GtkBuilder` object
   */
  this()
  {
    GtkBuilder* _cretval;
    _cretval = gtk_builder_new();
    this(_cretval, true);
  }

  /**
   * Parses the UI definition in the file filename.
   * If there is an error opening the file or parsing the description then
   * the program will be aborted. You should only ever attempt to parse
   * user interface descriptions that are shipped as part of your program.
   * Params:
   *   filename = filename of user interface description file
   * Returns: a `GtkBuilder` containing the described interface
   */
  static Builder newFromFile(string filename)
  {
    GtkBuilder* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = gtk_builder_new_from_file(_filename);
    auto _retval = _cretval ? ObjectG.getDObject!Builder(cast(GtkBuilder*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses the UI definition at resource_path.
   * If there is an error locating the resource or parsing the
   * description, then the program will be aborted.
   * Params:
   *   resourcePath = a `GResource` resource path
   * Returns: a `GtkBuilder` containing the described interface
   */
  static Builder newFromResource(string resourcePath)
  {
    GtkBuilder* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    _cretval = gtk_builder_new_from_resource(_resourcePath);
    auto _retval = _cretval ? ObjectG.getDObject!Builder(cast(GtkBuilder*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses the UI definition in string.
   * If string is %NULL-terminated, then length should be -1.
   * If length is not -1, then it is the length of string.
   * If there is an error parsing string then the program will be
   * aborted. You should not attempt to parse user interface description
   * from untrusted sources.
   * Params:
   *   string_ = a user interface $(LPAREN)XML$(RPAREN) description
   *   length = the length of string, or -1
   * Returns: a `GtkBuilder` containing the interface described by string
   */
  static Builder newFromString(string string_, ptrdiff_t length)
  {
    GtkBuilder* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gtk_builder_new_from_string(_string_, length);
    auto _retval = _cretval ? ObjectG.getDObject!Builder(cast(GtkBuilder*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses a file containing a UI definition and merges it with
   * the current contents of builder.
   * This function is useful if you need to call
   * [Gtk.Builder.setCurrentObject]$(RPAREN) to add user data to
   * callbacks before loading GtkBuilder UI. Otherwise, you probably
   * want [Gtk.Builder.newFromFile] instead.
   * If an error occurs, 0 will be returned and error will be assigned a
   * `GError` from the `GTK_BUILDER_ERROR`, `G_MARKUP_ERROR` or `G_FILE_ERROR`
   * domains.
   * It’s not really reasonable to attempt to handle failures of this
   * call. You should not use this function with untrusted files $(LPAREN)ie:
   * files that are not part of your application$(RPAREN). Broken `GtkBuilder`
   * files can easily crash your program, and it’s possible that memory
   * was leaked leading up to the reported failure. The only reasonable
   * thing to do when an error is detected is to call `g_error$(LPAREN)$(RPAREN)`.
   * Params:
   *   filename = the name of the file to parse
   * Returns: %TRUE on success, %FALSE if an error occurred
   */
  bool addFromFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = gtk_builder_add_from_file(cast(GtkBuilder*)cPtr, _filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Parses a resource file containing a UI definition
   * and merges it with the current contents of builder.
   * This function is useful if you need to call
   * [Gtk.Builder.setCurrentObject] to add user data to
   * callbacks before loading GtkBuilder UI. Otherwise, you probably
   * want [Gtk.Builder.newFromResource] instead.
   * If an error occurs, 0 will be returned and error will be assigned a
   * `GError` from the %GTK_BUILDER_ERROR, %G_MARKUP_ERROR or %G_RESOURCE_ERROR
   * domain.
   * It’s not really reasonable to attempt to handle failures of this
   * call.  The only reasonable thing to do when an error is detected is
   * to call g_error$(LPAREN)$(RPAREN).
   * Params:
   *   resourcePath = the path of the resource file to parse
   * Returns: %TRUE on success, %FALSE if an error occurred
   */
  bool addFromResource(string resourcePath)
  {
    bool _retval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    GError *_err;
    _retval = gtk_builder_add_from_resource(cast(GtkBuilder*)cPtr, _resourcePath, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Parses a string containing a UI definition and merges it
   * with the current contents of builder.
   * This function is useful if you need to call
   * [Gtk.Builder.setCurrentObject] to add user data to
   * callbacks before loading `GtkBuilder` UI. Otherwise, you probably
   * want [Gtk.Builder.newFromString] instead.
   * Upon errors %FALSE will be returned and error will be assigned a
   * `GError` from the %GTK_BUILDER_ERROR, %G_MARKUP_ERROR or
   * %G_VARIANT_PARSE_ERROR domain.
   * It’s not really reasonable to attempt to handle failures of this
   * call.  The only reasonable thing to do when an error is detected is
   * to call g_error$(LPAREN)$(RPAREN).
   * Params:
   *   buffer = the string to parse
   *   length = the length of buffer $(LPAREN)may be -1 if buffer is nul-terminated$(RPAREN)
   * Returns: %TRUE on success, %FALSE if an error occurred
   */
  bool addFromString(string buffer, ptrdiff_t length)
  {
    bool _retval;
    const(char)* _buffer = buffer.toCString(false);
    GError *_err;
    _retval = gtk_builder_add_from_string(cast(GtkBuilder*)cPtr, _buffer, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a closure to invoke the function called function_name.
   * This is using the create_closure$(LPAREN)$(RPAREN) implementation of builder's
   * [Gtk.BuilderScope].
   * If no closure could be created, %NULL will be returned and error
   * will be set.
   * Params:
   *   functionName = name of the function to look up
   *   flags = closure creation flags
   *   object = Object to create the closure with
   * Returns: A new closure for invoking function_name
   */
  Closure createClosure(string functionName, BuilderClosureFlags flags, ObjectG object)
  {
    GClosure* _cretval;
    const(char)* _functionName = functionName.toCString(false);
    GError *_err;
    _cretval = gtk_builder_create_closure(cast(GtkBuilder*)cPtr, _functionName, flags, object ? cast(ObjectC*)object.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Closure(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Add object to the builder object pool so it can be
   * referenced just like any other object built by builder.
   * Only a single object may be added using name. However,
   * it is not an error to expose the same object under multiple
   * names. `[Gtk.Builder.getObject]` may be used to determine
   * if an object has already been added with name.
   * Params:
   *   name = the name of the object exposed to the builder
   *   object = the object to expose
   */
  void exposeObject(string name, ObjectG object)
  {
    const(char)* _name = name.toCString(false);
    gtk_builder_expose_object(cast(GtkBuilder*)cPtr, _name, object ? cast(ObjectC*)object.cPtr(false) : null);
  }

  /**
   * Main private entry point for building composite components
   * from template XML.
   * Most likely you do not need to call this function in applications as
   * templates are handled by `GtkWidget`.
   * Params:
   *   object = the object that is being extended
   *   templateType = the type that the template is for
   *   buffer = the string to parse
   *   length = the length of buffer $(LPAREN)may be -1 if buffer is nul-terminated$(RPAREN)
   * Returns: A positive value on success, 0 if an error occurred
   */
  bool extendWithTemplate(ObjectG object, GType templateType, string buffer, ptrdiff_t length)
  {
    bool _retval;
    const(char)* _buffer = buffer.toCString(false);
    GError *_err;
    _retval = gtk_builder_extend_with_template(cast(GtkBuilder*)cPtr, object ? cast(ObjectC*)object.cPtr(false) : null, templateType, _buffer, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the current object set via [Gtk.Builder.setCurrentObject].
   * Returns: the current object
   */
  ObjectG getCurrentObject()
  {
    ObjectC* _cretval;
    _cretval = gtk_builder_get_current_object(cast(GtkBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the object named name.
   * Note that this function does not increment the reference count
   * of the returned object.
   * Params:
   *   name = name of object to get
   * Returns: the object named name
   */
  ObjectG getObject(string name)
  {
    ObjectC* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_builder_get_object(cast(GtkBuilder*)cPtr, _name);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets all objects that have been constructed by builder.
   * Note that this function does not increment the reference
   * counts of the returned objects.
   * Returns: a
   *   newly-allocated `GSList` containing all the objects
   *   constructed by the `GtkBuilder instance`. It should be
   *   freed by [GLib.SList.free]
   */
  SList!(ObjectG, ObjectC) getObjects()
  {
    GSList* _cretval;
    _cretval = gtk_builder_get_objects(cast(GtkBuilder*)cPtr);
    SList!(ObjectG, ObjectC) _retval = new SList!(ObjectG, ObjectC)(cast(GSList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Gets the scope in use that was set via [Gtk.Builder.setScope].
   * Returns: the current scope
   */
  BuilderScope getScope()
  {
    GtkBuilderScope* _cretval;
    _cretval = gtk_builder_get_scope(cast(GtkBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!BuilderScope(cast(GtkBuilderScope*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the translation domain of builder.
   * Returns: the translation domain
   */
  string getTranslationDomain()
  {
    const(char)* _cretval;
    _cretval = gtk_builder_get_translation_domain(cast(GtkBuilder*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Looks up a type by name.
   * This is using the virtual function that `GtkBuilder` has
   * for that purpose. This is mainly used when implementing
   * the `GtkBuildable` interface on a type.
   * Params:
   *   typeName = type name to lookup
   * Returns: the `GType` found for type_name or %G_TYPE_INVALID
   *   if no type was found
   */
  GType getTypeFromName(string typeName)
  {
    GType _retval;
    const(char)* _typeName = typeName.toCString(false);
    _retval = gtk_builder_get_type_from_name(cast(GtkBuilder*)cPtr, _typeName);
    return _retval;
  }

  /**
   * Sets the current object for the builder.
   * The current object can be thought of as the `this` object that the
   * builder is working for and will often be used as the default object
   * when an object is optional.
   * [Gtk.Widget.initTemplate] for example will set the current
   * object to the widget the template is inited for. For functions like
   * [Gtk.Builder.newFromResource], the current object will be %NULL.
   * Params:
   *   currentObject = the new current object
   */
  void setCurrentObject(ObjectG currentObject)
  {
    gtk_builder_set_current_object(cast(GtkBuilder*)cPtr, currentObject ? cast(ObjectC*)currentObject.cPtr(false) : null);
  }

  /**
   * Sets the scope the builder should operate in.
   * If scope is %NULL, a new [Gtk.BuilderCScope] will be created.
   * Params:
   *   scope_ = the scope to use
   */
  void setScope(BuilderScope scope_)
  {
    gtk_builder_set_scope(cast(GtkBuilder*)cPtr, scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(false) : null);
  }

  /**
   * Sets the translation domain of builder.
   * Params:
   *   domain = the translation domain
   */
  void setTranslationDomain(string domain)
  {
    const(char)* _domain = domain.toCString(false);
    gtk_builder_set_translation_domain(cast(GtkBuilder*)cPtr, _domain);
  }

  /**
   * Demarshals a value from a string.
   * This function calls [GObject.Value.init_] on the value argument,
   * so it need not be initialised beforehand.
   * Can handle char, uchar, boolean, int, uint, long,
   * ulong, enum, flags, float, double, string, `GdkRGBA` and
   * `GtkAdjustment` type values.
   * Upon errors %FALSE will be returned and error will be
   * assigned a `GError` from the %GTK_BUILDER_ERROR domain.
   * Params:
   *   pspec = the `GParamSpec` for the property
   *   string_ = the string representation of the value
   *   value = the `GValue` to store the result in
   * Returns: %TRUE on success
   */
  bool valueFromString(ParamSpec pspec, string string_, out Value value)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GValue _value;
    GError *_err;
    _retval = gtk_builder_value_from_string(cast(GtkBuilder*)cPtr, pspec ? cast(GParamSpec*)pspec.cPtr(false) : null, _string_, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    value = new Value(cast(void*)&_value, false);
    return _retval;
  }

  /**
   * Demarshals a value from a string.
   * Unlike [Gtk.Builder.valueFromString], this function
   * takes a `GType` instead of `GParamSpec`.
   * Calls [GObject.Value.init_] on the value argument, so it
   * need not be initialised beforehand.
   * Upon errors %FALSE will be returned and error will be
   * assigned a `GError` from the %GTK_BUILDER_ERROR domain.
   * Params:
   *   type = the `GType` of the value
   *   string_ = the string representation of the value
   *   value = the `GValue` to store the result in
   * Returns: %TRUE on success
   */
  bool valueFromStringType(GType type, string string_, out Value value)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GValue _value;
    GError *_err;
    _retval = gtk_builder_value_from_string_type(cast(GtkBuilder*)cPtr, type, _string_, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    value = new Value(cast(void*)&_value, false);
    return _retval;
  }
}
