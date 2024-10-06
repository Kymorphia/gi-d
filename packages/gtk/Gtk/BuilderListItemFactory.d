module Gtk.BuilderListItemFactory;

import GLib.Bytes;
import GObject.ObjectG;
import Gid.gid;
import Gtk.BuilderScope;
import Gtk.BuilderScopeT;
import Gtk.ListItemFactory;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkBuilderListItemFactory` is a `GtkListItemFactory` that creates
 * widgets by instantiating `GtkBuilder` UI templates.
 * The templates must be extending `GtkListItem`, and typically use
 * `GtkExpression`s to obtain data from the items in the model.
 * Example:
 * ```xml
 * <interface>
 * <template class\="GtkListItem">
 * <property name\="child">
 * <object class\="GtkLabel">
 * <property name\="xalign">0</property>
 * <binding name\="label">
 * <lookup name\="name" type\="SettingsKey">
 * <lookup name\="item">GtkListItem</lookup>
 * </lookup>
 * </binding>
 * </object>
 * </property>
 * </template>
 * </interface>
 * ```
 */
class BuilderListItemFactory : ListItemFactory
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_builder_list_item_factory_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkBuilderListItemFactory` that instantiates widgets
   * using bytes as the data to pass to `GtkBuilder`.
   * Params:
   *   scope_ = A scope to use when instantiating
   *   bytes = the `GBytes` containing the ui file to instantiate
   * Returns: a new `GtkBuilderListItemFactory`
   */
  static BuilderListItemFactory newFromBytes(BuilderScope scope_, Bytes bytes)
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_builder_list_item_factory_new_from_bytes(scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(false) : null, bytes ? cast(GBytes*)bytes.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!BuilderListItemFactory(cast(GtkListItemFactory*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkBuilderListItemFactory` that instantiates widgets
   * using data read from the given resource_path to pass to `GtkBuilder`.
   * Params:
   *   scope_ = A scope to use when instantiating
   *   resourcePath = valid path to a resource that contains the data
   * Returns: a new `GtkBuilderListItemFactory`
   */
  static BuilderListItemFactory newFromResource(BuilderScope scope_, string resourcePath)
  {
    GtkListItemFactory* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    _cretval = gtk_builder_list_item_factory_new_from_resource(scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(false) : null, _resourcePath);
    auto _retval = _cretval ? ObjectG.getDObject!BuilderListItemFactory(cast(GtkListItemFactory*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the data used as the `GtkBuilder` UI template for constructing
   * listitems.
   * Returns: The `GtkBuilder` data
   */
  Bytes getBytes()
  {
    GBytes* _cretval;
    _cretval = gtk_builder_list_item_factory_get_bytes(cast(GtkBuilderListItemFactory*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If the data references a resource, gets the path of that resource.
   * Returns: The path to the resource
   */
  string getResource()
  {
    const(char)* _cretval;
    _cretval = gtk_builder_list_item_factory_get_resource(cast(GtkBuilderListItemFactory*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the scope used when constructing listitems.
   * Returns: The scope used when constructing listitems
   */
  BuilderScope getScope()
  {
    GtkBuilderScope* _cretval;
    _cretval = gtk_builder_list_item_factory_get_scope(cast(GtkBuilderListItemFactory*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!BuilderScope(cast(GtkBuilderScope*)_cretval, false) : null;
    return _retval;
  }
}
