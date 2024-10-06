module Gdk.Global;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.Event;
import Gdk.RGBA;
import Gdk.Rectangle;
import Gdk.Surface;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import GdkPixbuf.Pixbuf;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import cairo.Context;
import cairo.Region;
import cairo.Surface : DcairoSurface = Surface;


/**
 * The main way to not draw GL content in GTK.
 * It takes a render buffer ID $(LPAREN)source_type \=\= GL_RENDERBUFFER$(RPAREN) or a texture
 * id $(LPAREN)source_type \=\= GL_TEXTURE$(RPAREN) and draws it onto cr with an OVER operation,
 * respecting the current clip. The top left corner of the rectangle specified
 * by x, y, width and height will be drawn at the current $(LPAREN)0,0$(RPAREN) position of
 * the `cairo_t`.
 * This will work for *all* `cairo_t`, as long as surface is realized, but the
 * fallback implementation that reads back the pixels from the buffer may be
 * used in the general case. In the case of direct drawing to a surface with
 * no special effects applied to cr it will however use a more efficient
 * approach.
 * For GL_RENDERBUFFER the code will always fall back to software for buffers
 * with alpha components, so make sure you use GL_TEXTURE if using alpha.
 * Calling this may change the current GL context.
 * Params:
 *   cr = a cairo context
 *   surface = The surface we're rendering for $(LPAREN)not necessarily into$(RPAREN)
 *   source = The GL ID of the source buffer
 *   sourceType = The type of the source
 *   bufferScale = The scale-factor that the source buffer is allocated for
 *   x = The source x position in source to start copying from in GL coordinates
 *   y = The source y position in source to start copying from in GL coordinates
 *   width = The width of the region to draw
 *   height = The height of the region to draw

 * Deprecated: The function is overly complex and produces broken output
 *   in various combinations of arguments. If you want to draw with GL textures
 *   in GTK, use [Gdk.GLTexture.new_]; if you want to use that texture in
 *   Cairo, use [Gdk.Texture.download] to download the data into a Cairo
 *   image surface.
 */
void cairoDrawFromGl(Context cr, Surface surface, int source, int sourceType, int bufferScale, int x, int y, int width, int height)
{
  gdk_cairo_draw_from_gl(cr ? cast(cairo_t*)cr.cPtr(false) : null, surface ? cast(GdkSurface*)surface.cPtr(false) : null, source, sourceType, bufferScale, x, y, width, height);
}

/**
 * Adds the given rectangle to the current path of cr.
 * Params:
 *   cr = a cairo context
 *   rectangle = a `GdkRectangle`
 */
void cairoRectangle(Context cr, Rectangle rectangle)
{
  gdk_cairo_rectangle(cr ? cast(cairo_t*)cr.cPtr(false) : null, rectangle ? cast(GdkRectangle*)rectangle.cPtr(false) : null);
}

/**
 * Adds the given region to the current path of cr.
 * Params:
 *   cr = a cairo context
 *   region = a `cairo_region_t`
 */
void cairoRegion(Context cr, Region region)
{
  gdk_cairo_region(cr ? cast(cairo_t*)cr.cPtr(false) : null, region ? cast(cairo_region_t*)region.cPtr(false) : null);
}

/**
 * Creates region that covers the area where the given
 * surface is more than 50% opaque.
 * This function takes into account device offsets that might be
 * set with [cairo.Surface.setDeviceOffset].
 * Params:
 *   surface = a cairo surface
 * Returns: A `cairo_region_t`
 */
Region cairoRegionCreateFromSurface(DcairoSurface surface)
{
  cairo_region_t* _cretval;
  _cretval = gdk_cairo_region_create_from_surface(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  auto _retval = _cretval ? new Region(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Sets the given pixbuf as the source pattern for cr.
 * The pattern has an extend mode of %CAIRO_EXTEND_NONE and is aligned
 * so that the origin of pixbuf is pixbuf_x, pixbuf_y.
 * Params:
 *   cr = a cairo context
 *   pixbuf = a `GdkPixbuf`
 *   pixbufX = X coordinate of location to place upper left corner of pixbuf
 *   pixbufY = Y coordinate of location to place upper left corner of pixbuf
 */
void cairoSetSourcePixbuf(Context cr, Pixbuf pixbuf, double pixbufX, double pixbufY)
{
  gdk_cairo_set_source_pixbuf(cr ? cast(cairo_t*)cr.cPtr(false) : null, pixbuf ? cast(PixbufC*)pixbuf.cPtr(false) : null, pixbufX, pixbufY);
}

/**
 * Sets the specified `GdkRGBA` as the source color of cr.
 * Params:
 *   cr = a cairo context
 *   rgba = a `GdkRGBA`
 */
void cairoSetSourceRgba(Context cr, RGBA rgba)
{
  gdk_cairo_set_source_rgba(cr ? cast(cairo_t*)cr.cPtr(false) : null, rgba ? cast(GdkRGBA*)rgba.cPtr(false) : null);
}

/**
 * Read content from the given input stream and deserialize it, asynchronously.
 * The default I/O priority is %G_PRIORITY_DEFAULT $(LPAREN)i.e. 0$(RPAREN), and lower numbers
 * indicate a higher priority.
 * When the operation is finished, callback will be called. You must then
 * call funcGdk.content_deserialize_finish to get the result of the operation.
 * Params:
 *   stream = a `GInputStream` to read the serialized content from
 *   mimeType = the mime type to deserialize from
 *   type = the GType to deserialize from
 *   ioPriority = the I/O priority of the operation
 *   cancellable = optional `GCancellable` object
 *   callback = callback to call when the operation is done
 */
void contentDeserializeAsync(InputStream stream, string mimeType, GType type, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  const(char)* _mimeType = mimeType.toCString(false);
  auto _callback = freezeDelegate(cast(void*)&callback);
  gdk_content_deserialize_async(stream ? cast(GInputStream*)stream.cPtr(false) : null, _mimeType, type, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
}

/**
 * Finishes a content deserialization operation.
 * Params:
 *   result = the `GAsyncResult`
 *   value = return location for the result of the operation
 * Returns: %TRUE if the operation was successful. In this case,
 *   value is set. %FALSE if an error occurred. In this case,
 *   error is set
 */
bool contentDeserializeFinish(AsyncResult result, out Value value)
{
  bool _retval;
  GValue _value;
  GError *_err;
  _retval = gdk_content_deserialize_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_value, &_err);
  if (_err)
    throw new ErrorG(_err);
  value = new Value(cast(void*)&_value, false);
  return _retval;
}

/**
 * Serialize content and write it to the given output stream, asynchronously.
 * The default I/O priority is %G_PRIORITY_DEFAULT $(LPAREN)i.e. 0$(RPAREN), and lower numbers
 * indicate a higher priority.
 * When the operation is finished, callback will be called. You must then
 * call funcGdk.content_serialize_finish to get the result of the operation.
 * Params:
 *   stream = a `GOutputStream` to write the serialized content to
 *   mimeType = the mime type to serialize to
 *   value = the content to serialize
 *   ioPriority = the I/O priority of the operation
 *   cancellable = optional `GCancellable` object
 *   callback = callback to call when the operation is done
 */
void contentSerializeAsync(OutputStream stream, string mimeType, Value value, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  const(char)* _mimeType = mimeType.toCString(false);
  auto _callback = freezeDelegate(cast(void*)&callback);
  gdk_content_serialize_async(stream ? cast(GOutputStream*)stream.cPtr(false) : null, _mimeType, value ? cast(GValue*)value.cPtr(false) : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
}

/**
 * Finishes a content serialization operation.
 * Params:
 *   result = the `GAsyncResult`
 * Returns: %TRUE if the operation was successful, %FALSE if an
 *   error occurred. In this case, error is set
 */
bool contentSerializeFinish(AsyncResult result)
{
  bool _retval;
  GError *_err;
  _retval = gdk_content_serialize_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

GType dragSurfaceSizeGetType()
{
  GType _retval;
  _retval = gdk_drag_surface_size_get_type();
  return _retval;
}

/**
 * Returns the relative angle from event1 to event2.
 * The relative angle is the angle between the X axis and the line
 * through both events' positions. The rotation direction for positive
 * angles is from the positive X axis towards the positive Y axis.
 * This assumes that both events have X/Y information.
 * If not, this function returns %FALSE.
 * Params:
 *   event1 = first `GdkEvent`
 *   event2 = second `GdkEvent`
 *   angle = return location for the relative angle between both events
 * Returns: %TRUE if the angle could be calculated.
 */
bool eventsGetAngle(Event event1, Event event2, out double angle)
{
  bool _retval;
  _retval = gdk_events_get_angle(event1 ? cast(GdkEvent*)event1.cPtr(false) : null, event2 ? cast(GdkEvent*)event2.cPtr(false) : null, cast(double*)&angle);
  return _retval;
}

/**
 * Returns the point halfway between the events' positions.
 * This assumes that both events have X/Y information.
 * If not, this function returns %FALSE.
 * Params:
 *   event1 = first `GdkEvent`
 *   event2 = second `GdkEvent`
 *   x = return location for the X coordinate of the center
 *   y = return location for the Y coordinate of the center
 * Returns: %TRUE if the center could be calculated.
 */
bool eventsGetCenter(Event event1, Event event2, out double x, out double y)
{
  bool _retval;
  _retval = gdk_events_get_center(event1 ? cast(GdkEvent*)event1.cPtr(false) : null, event2 ? cast(GdkEvent*)event2.cPtr(false) : null, cast(double*)&x, cast(double*)&y);
  return _retval;
}

/**
 * Returns the distance between the event locations.
 * This assumes that both events have X/Y information.
 * If not, this function returns %FALSE.
 * Params:
 *   event1 = first `GdkEvent`
 *   event2 = second `GdkEvent`
 *   distance = return location for the distance
 * Returns: %TRUE if the distance could be calculated.
 */
bool eventsGetDistance(Event event1, Event event2, out double distance)
{
  bool _retval;
  _retval = gdk_events_get_distance(event1 ? cast(GdkEvent*)event1.cPtr(false) : null, event2 ? cast(GdkEvent*)event2.cPtr(false) : null, cast(double*)&distance);
  return _retval;
}

/**
 * Canonicalizes the given mime type and interns the result.
 * If string is not a valid mime type, %NULL is returned instead.
 * See RFC 2048 for the syntax if mime types.
 * Params:
 *   string_ = string of a potential mime type
 * Returns: An interned string for the canonicalized
 *   mime type or %NULL if the string wasn't a valid mime type
 */
string internMimeType(string string_)
{
  const(char)* _cretval;
  const(char)* _string_ = string_.toCString(false);
  _cretval = gdk_intern_mime_type(_string_);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Obtains the upper- and lower-case versions of the keyval symbol.
 * Examples of keyvals are `GDK_KEY_a`, `GDK_KEY_Enter`, `GDK_KEY_F1`, etc.
 * Params:
 *   symbol = a keyval
 *   lower = return location for lowercase version of symbol
 *   upper = return location for uppercase version of symbol
 */
void keyvalConvertCase(uint symbol, out uint lower, out uint upper)
{
  gdk_keyval_convert_case(symbol, cast(uint*)&lower, cast(uint*)&upper);
}

/**
 * Converts a key name to a key value.
 * The names are the same as those in the
 * `gdk/gdkkeysyms.h` header file
 * but without the leading “GDK_KEY_”.
 * Params:
 *   keyvalName = a key name
 * Returns: the corresponding key value, or %GDK_KEY_VoidSymbol
 *   if the key name is not a valid key
 */
uint keyvalFromName(string keyvalName)
{
  uint _retval;
  const(char)* _keyvalName = keyvalName.toCString(false);
  _retval = gdk_keyval_from_name(_keyvalName);
  return _retval;
}

/**
 * Returns %TRUE if the given key value is in lower case.
 * Params:
 *   keyval = a key value.
 * Returns: %TRUE if keyval is in lower case, or if keyval is not
 *   subject to case conversion.
 */
bool keyvalIsLower(uint keyval)
{
  bool _retval;
  _retval = gdk_keyval_is_lower(keyval);
  return _retval;
}

/**
 * Returns %TRUE if the given key value is in upper case.
 * Params:
 *   keyval = a key value.
 * Returns: %TRUE if keyval is in upper case, or if keyval is not subject to
 *   case conversion.
 */
bool keyvalIsUpper(uint keyval)
{
  bool _retval;
  _retval = gdk_keyval_is_upper(keyval);
  return _retval;
}

/**
 * Converts a key value into a symbolic name.
 * The names are the same as those in the
 * `gdk/gdkkeysyms.h` header file
 * but without the leading “GDK_KEY_”.
 * Params:
 *   keyval = a key value
 * Returns: a string containing the name
 *   of the key
 */
string keyvalName(uint keyval)
{
  const(char)* _cretval;
  _cretval = gdk_keyval_name(keyval);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Converts a key value to lower case, if applicable.
 * Params:
 *   keyval = a key value.
 * Returns: the lower case form of keyval, or keyval itself if it is already
 *   in lower case or it is not subject to case conversion.
 */
uint keyvalToLower(uint keyval)
{
  uint _retval;
  _retval = gdk_keyval_to_lower(keyval);
  return _retval;
}

/**
 * Convert from a GDK key symbol to the corresponding Unicode
 * character.
 * Note that the conversion does not take the current locale
 * into consideration, which might be expected for particular
 * keyvals, such as %GDK_KEY_KP_Decimal.
 * Params:
 *   keyval = a GDK key symbol
 * Returns: the corresponding unicode character, or 0 if there
 *   is no corresponding character.
 */
uint keyvalToUnicode(uint keyval)
{
  uint _retval;
  _retval = gdk_keyval_to_unicode(keyval);
  return _retval;
}

/**
 * Converts a key value to upper case, if applicable.
 * Params:
 *   keyval = a key value.
 * Returns: the upper case form of keyval, or keyval itself if it is already
 *   in upper case or it is not subject to case conversion.
 */
uint keyvalToUpper(uint keyval)
{
  uint _retval;
  _retval = gdk_keyval_to_upper(keyval);
  return _retval;
}

/**
 * Transfers image data from a `cairo_surface_t` and converts it
 * to a `GdkPixbuf`.
 * This allows you to efficiently read individual pixels from cairo surfaces.
 * This function will create an RGB pixbuf with 8 bits per channel.
 * The pixbuf will contain an alpha channel if the surface contains one.
 * Params:
 *   surface = surface to copy from
 *   srcX = Source X coordinate within surface
 *   srcY = Source Y coordinate within surface
 *   width = Width in pixels of region to get
 *   height = Height in pixels of region to get
 * Returns: A newly-created pixbuf with a
 *   reference count of 1

 * Deprecated: Use [Gdk.Texture] and subclasses instead
 *   cairo surfaces and pixbufs
 */
Pixbuf pixbufGetFromSurface(DcairoSurface surface, int srcX, int srcY, int width, int height)
{
  PixbufC* _cretval;
  _cretval = gdk_pixbuf_get_from_surface(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, srcX, srcY, width, height);
  auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new pixbuf from texture.
 * This should generally not be used in newly written code as later
 * stages will almost certainly convert the pixbuf back into a texture
 * to draw it on screen.
 * Params:
 *   texture = a `GdkTexture`
 * Returns: a new `GdkPixbuf`

 * Deprecated: Use [Gdk.Texture] and subclasses instead
 *   cairo surfaces and pixbufs
 */
Pixbuf pixbufGetFromTexture(Texture texture)
{
  PixbufC* _cretval;
  _cretval = gdk_pixbuf_get_from_texture(texture ? cast(GdkTexture*)texture.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
  return _retval;
}

/**
 * Sets a list of backends that GDK should try to use.
 * This can be useful if your application does not
 * work with certain GDK backends.
 * By default, GDK tries all included backends.
 * For example:
 * ```c
 * gdk_set_allowed_backends $(LPAREN)"wayland,macos,*"$(RPAREN);
 * ```
 * instructs GDK to try the Wayland backend first, followed by the
 * MacOs backend, and then all others.
 * If the `GDK_BACKEND` environment variable is set, it determines
 * what backends are tried in what order, while still respecting the
 * set of allowed backends that are specified by this function.
 * The possible backend names are:
 * - `broadway`
 * - `macos`
 * - `wayland`.
 * - `win32`
 * - `x11`
 * You can also include a `*` in the list to try all remaining backends.
 * This call must happen prior to functions that open a display, such
 * as [Gdk.Display.open], `[Gtk.Global.init_]`, or `[Gtk.Global.initCheck]`
 * in order to take effect.
 * Params:
 *   backends = a comma-separated list of backends
 */
void setAllowedBackends(string backends)
{
  const(char)* _backends = backends.toCString(false);
  gdk_set_allowed_backends(_backends);
}

GType toplevelSizeGetType()
{
  GType _retval;
  _retval = gdk_toplevel_size_get_type();
  return _retval;
}

/**
 * Convert from a Unicode character to a key symbol.
 * Params:
 *   wc = a Unicode character
 * Returns: the corresponding GDK key symbol, if one exists.
 *   or, if there is no corresponding symbol, wc | 0x01000000
 */
uint unicodeToKeyval(uint wc)
{
  uint _retval;
  _retval = gdk_unicode_to_keyval(wc);
  return _retval;
}
