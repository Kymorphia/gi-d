module Gio.IOExtensionPoint;

import GLib.List;
import GObject.Types;
import Gid.gid;
import Gio.IOExtension;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GIOExtensionPoint` provides a mechanism for modules to extend the
 * functionality of the library or application that loaded it in an
 * organized fashion.
 * An extension point is identified by a name, and it may optionally
 * require that any implementation must be of a certain type $(LPAREN)or derived
 * thereof$(RPAREN). Use [Gio.IOExtensionPoint.register] to register an
 * extension point, and [Gio.IOExtensionPoint.setRequiredType] to
 * set a required type.
 * A module can implement an extension point by specifying the
 * [GObject.GType] that implements the functionality. Additionally, each
 * implementation of an extension point has a name, and a priority. Use
 * [Gio.IOExtensionPoint.implement] to implement an extension point.
 * ```c
 * GIOExtensionPoint *ep;
 * // Register an extension point
 * ep \= g_io_extension_point_register $(LPAREN)"my-extension-point"$(RPAREN);
 * g_io_extension_point_set_required_type $(LPAREN)ep, MY_TYPE_EXAMPLE$(RPAREN);
 * ```
 * ```c
 * // Implement an extension point
 * G_DEFINE_TYPE $(LPAREN)MyExampleImpl, my_example_impl, MY_TYPE_EXAMPLE$(RPAREN)
 * g_io_extension_point_implement $(LPAREN)"my-extension-point",
 * my_example_impl_get_type $(LPAREN)$(RPAREN),
 * "my-example",
 * 10$(RPAREN);
 * ```
 * It is up to the code that registered the extension point how
 * it uses the implementations that have been associated with it.
 * Depending on the use case, it may use all implementations, or
 * only the one with the highest priority, or pick a specific
 * one by name.
 * To avoid opening all modules just to find out what extension
 * points they implement, GIO makes use of a caching mechanism,
 * see [gio-querymodules](gio-querymodules.html).
 * You are expected to run this command after installing a
 * GIO module.
 * The `GIO_EXTRA_MODULES` environment variable can be used to
 * specify additional directories to automatically load modules
 * from. This environment variable has the same syntax as the
 * `PATH`. If two modules have the same base name in different
 * directories, then the latter one will be ignored. If additional
 * directories are specified GIO will load modules from the built-in
 * directory last.
 */
class IOExtensionPoint
{
  GIOExtensionPoint* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOExtensionPoint");

    cInstancePtr = cast(GIOExtensionPoint*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Finds a #GIOExtension for an extension point by name.
   * Params:
   *   name = the name of the extension to get
   * Returns: the #GIOExtension for extension_point that has the
   *   given name, or %NULL if there is no extension with that name
   */
  IOExtension getExtensionByName(string name)
  {
    GIOExtension* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_get_extension_by_name(cast(GIOExtensionPoint*)cPtr, _name);
    auto _retval = _cretval ? new IOExtension(cast(GIOExtension*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a list of all extensions that implement this extension point.
   * The list is sorted by priority, beginning with the highest priority.
   * Returns: a #GList of
   *   #GIOExtensions. The list is owned by GIO and should not be
   *   modified.
   */
  List!(IOExtension) getExtensions()
  {
    GList* _cretval;
    _cretval = g_io_extension_point_get_extensions(cast(GIOExtensionPoint*)cPtr);
    List!(IOExtension) _retval = new List!(IOExtension)(cast(GList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Gets the required type for extension_point.
   * Returns: the #GType that all implementations must have,
   *   or %G_TYPE_INVALID if the extension point has no required type
   */
  GType getRequiredType()
  {
    GType _retval;
    _retval = g_io_extension_point_get_required_type(cast(GIOExtensionPoint*)cPtr);
    return _retval;
  }

  /**
   * Sets the required type for extension_point to type.
   * All implementations must henceforth have this type.
   * Params:
   *   type = the #GType to require
   */
  void setRequiredType(GType type)
  {
    g_io_extension_point_set_required_type(cast(GIOExtensionPoint*)cPtr, type);
  }

  /**
   * Registers type as extension for the extension point with name
   * extension_point_name.
   * If type has already been registered as an extension for this
   * extension point, the existing #GIOExtension object is returned.
   * Params:
   *   extensionPointName = the name of the extension point
   *   type = the #GType to register as extension
   *   extensionName = the name for the extension
   *   priority = the priority for the extension
   * Returns: a #GIOExtension object for #GType
   */
  static IOExtension implement(string extensionPointName, GType type, string extensionName, int priority)
  {
    GIOExtension* _cretval;
    const(char)* _extensionPointName = extensionPointName.toCString(false);
    const(char)* _extensionName = extensionName.toCString(false);
    _cretval = g_io_extension_point_implement(_extensionPointName, type, _extensionName, priority);
    auto _retval = _cretval ? new IOExtension(cast(GIOExtension*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Looks up an existing extension point.
   * Params:
   *   name = the name of the extension point
   * Returns: the #GIOExtensionPoint, or %NULL if there
   *   is no registered extension point with the given name.
   */
  static IOExtensionPoint lookup(string name)
  {
    GIOExtensionPoint* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_lookup(_name);
    auto _retval = _cretval ? new IOExtensionPoint(cast(GIOExtensionPoint*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Registers an extension point.
   * Params:
   *   name = The name of the extension point
   * Returns: the new #GIOExtensionPoint. This object is
   *   owned by GIO and should not be freed.
   */
  static IOExtensionPoint register(string name)
  {
    GIOExtensionPoint* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_register(_name);
    auto _retval = _cretval ? new IOExtensionPoint(cast(GIOExtensionPoint*)_cretval, false) : null;
    return _retval;
  }
}
