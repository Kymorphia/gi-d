module Gdk.ContentFormatsBuilder;

import GLib.Boxed;
import GObject.Types;
import Gdk.ContentFormats;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkContentFormatsBuilder` is an auxiliary struct used to create
 * new `GdkContentFormats`, and should not be kept around.
 */
class ContentFormatsBuilder : Boxed
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
    return gdk_content_formats_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `GdkContentFormatsBuilder` object.
   * The resulting builder would create an empty `GdkContentFormats`.
   * Use addition functions to add types to it.
   * Returns: a new `GdkContentFormatsBuilder`
   */
  this()
  {
    GdkContentFormatsBuilder* _cretval;
    _cretval = gdk_content_formats_builder_new();
    this(_cretval, true);
  }

  /**
   * Appends all formats from formats to builder, skipping those that
   * already exist.
   * Params:
   *   formats = the formats to add
   */
  void addFormats(ContentFormats formats)
  {
    gdk_content_formats_builder_add_formats(cast(GdkContentFormatsBuilder*)cPtr, formats ? cast(GdkContentFormats*)formats.cPtr(false) : null);
  }

  /**
   * Appends type to builder if it has not already been added.
   * Params:
   *   type = a `GType`
   */
  void addGtype(GType type)
  {
    gdk_content_formats_builder_add_gtype(cast(GdkContentFormatsBuilder*)cPtr, type);
  }

  /**
   * Appends mime_type to builder if it has not already been added.
   * Params:
   *   mimeType = a mime type
   */
  void addMimeType(string mimeType)
  {
    const(char)* _mimeType = mimeType.toCString(false);
    gdk_content_formats_builder_add_mime_type(cast(GdkContentFormatsBuilder*)cPtr, _mimeType);
  }

  /**
   * Creates a new `GdkContentFormats` from the given builder.
   * The given `GdkContentFormatsBuilder` is reset once this function returns;
   * you cannot call this function multiple times on the same builder instance.
   * This function is intended primarily for bindings. C code should use
   * [Gdk.ContentFormatsBuilder.freeToFormats].
   * Returns: the newly created `GdkContentFormats`
   *   with all the formats added to builder
   */
  ContentFormats toFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_formats_builder_to_formats(cast(GdkContentFormatsBuilder*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
