module Gdk.c.functions;

import Gdk.c.types;
public import GdkPixbuf.c.types;
public import Gio.c.types;
public import Pango.c.types;
public import PangoCairo.c.types;
public import cairo.c.types;

version(Windows)
  private immutable LIBS = ["libgtk-4-1.dll;gtk-4-1.dll;gtk-4.dll"];
version(OSX)
  private immutable LIBS = ["libgtk-4.1.dylib"];
else
  private immutable LIBS = ["libgtk-4.so.1"];

__gshared extern(C)
{
  // AppLaunchContext
  GType function() c_gdk_app_launch_context_get_type;
  GdkDisplay* function(GdkAppLaunchContext* context) c_gdk_app_launch_context_get_display;
  void function(GdkAppLaunchContext* context, int desktop) c_gdk_app_launch_context_set_desktop;
  void function(GdkAppLaunchContext* context, GIcon* icon) c_gdk_app_launch_context_set_icon;
  void function(GdkAppLaunchContext* context, const(char)* iconName) c_gdk_app_launch_context_set_icon_name;
  void function(GdkAppLaunchContext* context, uint timestamp) c_gdk_app_launch_context_set_timestamp;

  // ButtonEvent
  GType function() c_gdk_button_event_get_type;
  uint function(GdkEvent* event) c_gdk_button_event_get_button;

  // CairoContext
  GType function() c_gdk_cairo_context_get_type;
  cairo_t* function(GdkCairoContext* self) c_gdk_cairo_context_cairo_create;

  // Clipboard
  GType function() c_gdk_clipboard_get_type;
  GdkContentProvider* function(GdkClipboard* clipboard) c_gdk_clipboard_get_content;
  GdkDisplay* function(GdkClipboard* clipboard) c_gdk_clipboard_get_display;
  GdkContentFormats* function(GdkClipboard* clipboard) c_gdk_clipboard_get_formats;
  bool function(GdkClipboard* clipboard) c_gdk_clipboard_is_local;
  void function(GdkClipboard* clipboard, const(char*)* mimeTypes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_clipboard_read_async;
  GInputStream* function(GdkClipboard* clipboard, GAsyncResult* result, const(char*)* outMimeType, GError** _err) c_gdk_clipboard_read_finish;
  void function(GdkClipboard* clipboard, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_clipboard_read_text_async;
  char* function(GdkClipboard* clipboard, GAsyncResult* result, GError** _err) c_gdk_clipboard_read_text_finish;
  void function(GdkClipboard* clipboard, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_clipboard_read_texture_async;
  GdkTexture* function(GdkClipboard* clipboard, GAsyncResult* result, GError** _err) c_gdk_clipboard_read_texture_finish;
  void function(GdkClipboard* clipboard, GType type, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_clipboard_read_value_async;
  const(GValue)* function(GdkClipboard* clipboard, GAsyncResult* result, GError** _err) c_gdk_clipboard_read_value_finish;
  void function(GdkClipboard* clipboard, GType type,  ...) c_gdk_clipboard_set;
  bool function(GdkClipboard* clipboard, GdkContentProvider* provider) c_gdk_clipboard_set_content;
  void function(GdkClipboard* clipboard, const(char)* text) c_gdk_clipboard_set_text;
  void function(GdkClipboard* clipboard, GdkTexture* texture) c_gdk_clipboard_set_texture;
  void function(GdkClipboard* clipboard, GType type, void* args) c_gdk_clipboard_set_valist;
  void function(GdkClipboard* clipboard, const(GValue)* value) c_gdk_clipboard_set_value;
  void function(GdkClipboard* clipboard, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_clipboard_store_async;
  bool function(GdkClipboard* clipboard, GAsyncResult* result, GError** _err) c_gdk_clipboard_store_finish;

  // ContentDeserializer
  GType function() c_gdk_content_deserializer_get_type;
  GCancellable* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_cancellable;
  GType function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_gtype;
  GInputStream* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_input_stream;
  const(char)* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_mime_type;
  int function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_priority;
  void* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_task_data;
  void* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_user_data;
  GValue* function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_get_value;
  void function(GdkContentDeserializer* deserializer, GError* error) c_gdk_content_deserializer_return_error;
  void function(GdkContentDeserializer* deserializer) c_gdk_content_deserializer_return_success;
  void function(GdkContentDeserializer* deserializer, void* data, GDestroyNotify notify) c_gdk_content_deserializer_set_task_data;

  // ContentFormats
  GType function() c_gdk_content_formats_get_type;
  GdkContentFormats* function(const(char*)* mimeTypes, uint nMimeTypes) c_gdk_content_formats_new;
  GdkContentFormats* function(GType type) c_gdk_content_formats_new_for_gtype;
  bool function(const(GdkContentFormats)* formats, GType type) c_gdk_content_formats_contain_gtype;
  bool function(const(GdkContentFormats)* formats, const(char)* mimeType) c_gdk_content_formats_contain_mime_type;
  const(GType)* function(const(GdkContentFormats)* formats, size_t* nGtypes) c_gdk_content_formats_get_gtypes;
  const(char*)* function(const(GdkContentFormats)* formats, size_t* nMimeTypes) c_gdk_content_formats_get_mime_types;
  bool function(const(GdkContentFormats)* first, const(GdkContentFormats)* second) c_gdk_content_formats_match;
  GType function(const(GdkContentFormats)* first, const(GdkContentFormats)* second) c_gdk_content_formats_match_gtype;
  const(char)* function(const(GdkContentFormats)* first, const(GdkContentFormats)* second) c_gdk_content_formats_match_mime_type;
  void function(GdkContentFormats* formats, GString* string_) c_gdk_content_formats_print;
  GdkContentFormats* function(GdkContentFormats* formats) c_gdk_content_formats_ref;
  char* function(GdkContentFormats* formats) c_gdk_content_formats_to_string;
  GdkContentFormats* function(GdkContentFormats* first, const(GdkContentFormats)* second) c_gdk_content_formats_union;
  GdkContentFormats* function(GdkContentFormats* formats) c_gdk_content_formats_union_deserialize_gtypes;
  GdkContentFormats* function(GdkContentFormats* formats) c_gdk_content_formats_union_deserialize_mime_types;
  GdkContentFormats* function(GdkContentFormats* formats) c_gdk_content_formats_union_serialize_gtypes;
  GdkContentFormats* function(GdkContentFormats* formats) c_gdk_content_formats_union_serialize_mime_types;
  void function(GdkContentFormats* formats) c_gdk_content_formats_unref;
  GdkContentFormats* function(const(char)* string_) c_gdk_content_formats_parse;

  // ContentFormatsBuilder
  GType function() c_gdk_content_formats_builder_get_type;
  GdkContentFormatsBuilder* function() c_gdk_content_formats_builder_new;
  void function(GdkContentFormatsBuilder* builder, const(GdkContentFormats)* formats) c_gdk_content_formats_builder_add_formats;
  void function(GdkContentFormatsBuilder* builder, GType type) c_gdk_content_formats_builder_add_gtype;
  void function(GdkContentFormatsBuilder* builder, const(char)* mimeType) c_gdk_content_formats_builder_add_mime_type;
  GdkContentFormats* function(GdkContentFormatsBuilder* builder) c_gdk_content_formats_builder_free_to_formats;
  GdkContentFormatsBuilder* function(GdkContentFormatsBuilder* builder) c_gdk_content_formats_builder_ref;
  GdkContentFormats* function(GdkContentFormatsBuilder* builder) c_gdk_content_formats_builder_to_formats;
  void function(GdkContentFormatsBuilder* builder) c_gdk_content_formats_builder_unref;

  // ContentProvider
  GType function() c_gdk_content_provider_get_type;
  GdkContentProvider* function(const(char)* mimeType, GBytes* bytes) c_gdk_content_provider_new_for_bytes;
  GdkContentProvider* function(const(GValue)* value) c_gdk_content_provider_new_for_value;
  GdkContentProvider* function(GType type,  ...) c_gdk_content_provider_new_typed;
  GdkContentProvider* function(GdkContentProvider** providers, size_t nProviders) c_gdk_content_provider_new_union;
  void function(GdkContentProvider* provider) c_gdk_content_provider_content_changed;
  bool function(GdkContentProvider* provider, GValue* value, GError** _err) c_gdk_content_provider_get_value;
  GdkContentFormats* function(GdkContentProvider* provider) c_gdk_content_provider_ref_formats;
  GdkContentFormats* function(GdkContentProvider* provider) c_gdk_content_provider_ref_storable_formats;
  void function(GdkContentProvider* provider, const(char)* mimeType, GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_content_provider_write_mime_type_async;
  bool function(GdkContentProvider* provider, GAsyncResult* result, GError** _err) c_gdk_content_provider_write_mime_type_finish;

  // ContentSerializer
  GType function() c_gdk_content_serializer_get_type;
  GCancellable* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_cancellable;
  GType function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_gtype;
  const(char)* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_mime_type;
  GOutputStream* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_output_stream;
  int function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_priority;
  void* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_task_data;
  void* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_user_data;
  const(GValue)* function(GdkContentSerializer* serializer) c_gdk_content_serializer_get_value;
  void function(GdkContentSerializer* serializer, GError* error) c_gdk_content_serializer_return_error;
  void function(GdkContentSerializer* serializer) c_gdk_content_serializer_return_success;
  void function(GdkContentSerializer* serializer, void* data, GDestroyNotify notify) c_gdk_content_serializer_set_task_data;

  // CrossingEvent
  GType function() c_gdk_crossing_event_get_type;
  GdkNotifyType function(GdkEvent* event) c_gdk_crossing_event_get_detail;
  bool function(GdkEvent* event) c_gdk_crossing_event_get_focus;
  GdkCrossingMode function(GdkEvent* event) c_gdk_crossing_event_get_mode;

  // Cursor
  GType function() c_gdk_cursor_get_type;
  GdkCursor* function(const(char)* name, GdkCursor* fallback) c_gdk_cursor_new_from_name;
  GdkCursor* function(GdkTexture* texture, int hotspotX, int hotspotY, GdkCursor* fallback) c_gdk_cursor_new_from_texture;
  GdkCursor* function(GdkCursor* cursor) c_gdk_cursor_get_fallback;
  int function(GdkCursor* cursor) c_gdk_cursor_get_hotspot_x;
  int function(GdkCursor* cursor) c_gdk_cursor_get_hotspot_y;
  const(char)* function(GdkCursor* cursor) c_gdk_cursor_get_name;
  GdkTexture* function(GdkCursor* cursor) c_gdk_cursor_get_texture;

  // DNDEvent
  GType function() c_gdk_dnd_event_get_type;
  GdkDrop* function(GdkEvent* event) c_gdk_dnd_event_get_drop;

  // DeleteEvent
  GType function() c_gdk_delete_event_get_type;

  // Device
  GType function() c_gdk_device_get_type;
  bool function(GdkDevice* device) c_gdk_device_get_caps_lock_state;
  GdkDeviceTool* function(GdkDevice* device) c_gdk_device_get_device_tool;
  PangoDirection function(GdkDevice* device) c_gdk_device_get_direction;
  GdkDisplay* function(GdkDevice* device) c_gdk_device_get_display;
  bool function(GdkDevice* device) c_gdk_device_get_has_cursor;
  GdkModifierType function(GdkDevice* device) c_gdk_device_get_modifier_state;
  const(char)* function(GdkDevice* device) c_gdk_device_get_name;
  bool function(GdkDevice* device) c_gdk_device_get_num_lock_state;
  uint function(GdkDevice* device) c_gdk_device_get_num_touches;
  const(char)* function(GdkDevice* device) c_gdk_device_get_product_id;
  bool function(GdkDevice* device) c_gdk_device_get_scroll_lock_state;
  GdkSeat* function(GdkDevice* device) c_gdk_device_get_seat;
  GdkInputSource function(GdkDevice* device) c_gdk_device_get_source;
  GdkSurface* function(GdkDevice* device, double* winX, double* winY) c_gdk_device_get_surface_at_position;
  uint function(GdkDevice* device) c_gdk_device_get_timestamp;
  const(char)* function(GdkDevice* device) c_gdk_device_get_vendor_id;
  bool function(GdkDevice* device) c_gdk_device_has_bidi_layouts;

  // DevicePad
  GType function() c_gdk_device_pad_get_type;
  int function(GdkDevicePad* pad, GdkDevicePadFeature feature, int featureIdx) c_gdk_device_pad_get_feature_group;
  int function(GdkDevicePad* pad, int groupIdx) c_gdk_device_pad_get_group_n_modes;
  int function(GdkDevicePad* pad, GdkDevicePadFeature feature) c_gdk_device_pad_get_n_features;
  int function(GdkDevicePad* pad) c_gdk_device_pad_get_n_groups;

  // DeviceTool
  GType function() c_gdk_device_tool_get_type;
  GdkAxisFlags function(GdkDeviceTool* tool) c_gdk_device_tool_get_axes;
  ulong function(GdkDeviceTool* tool) c_gdk_device_tool_get_hardware_id;
  ulong function(GdkDeviceTool* tool) c_gdk_device_tool_get_serial;
  GdkDeviceToolType function(GdkDeviceTool* tool) c_gdk_device_tool_get_tool_type;

  // Display
  GType function() c_gdk_display_get_type;
  GdkDisplay* function() c_gdk_display_get_default;
  GdkDisplay* function(const(char)* displayName) c_gdk_display_open;
  void function(GdkDisplay* display) c_gdk_display_beep;
  void function(GdkDisplay* display) c_gdk_display_close;
  GdkGLContext* function(GdkDisplay* self, GError** _err) c_gdk_display_create_gl_context;
  bool function(GdkDisplay* display, GdkDevice* device) c_gdk_display_device_is_grabbed;
  void function(GdkDisplay* display) c_gdk_display_flush;
  GdkAppLaunchContext* function(GdkDisplay* display) c_gdk_display_get_app_launch_context;
  GdkClipboard* function(GdkDisplay* display) c_gdk_display_get_clipboard;
  GdkSeat* function(GdkDisplay* display) c_gdk_display_get_default_seat;
  GdkDmabufFormats* function(GdkDisplay* display) c_gdk_display_get_dmabuf_formats;
  GdkMonitor* function(GdkDisplay* display, GdkSurface* surface) c_gdk_display_get_monitor_at_surface;
  GListModel* function(GdkDisplay* self) c_gdk_display_get_monitors;
  const(char)* function(GdkDisplay* display) c_gdk_display_get_name;
  GdkClipboard* function(GdkDisplay* display) c_gdk_display_get_primary_clipboard;
  bool function(GdkDisplay* display, const(char)* name, GValue* value) c_gdk_display_get_setting;
  const(char)* function(GdkDisplay* display) c_gdk_display_get_startup_notification_id;
  bool function(GdkDisplay* display) c_gdk_display_is_closed;
  bool function(GdkDisplay* display) c_gdk_display_is_composited;
  bool function(GdkDisplay* display) c_gdk_display_is_rgba;
  GList* function(GdkDisplay* display) c_gdk_display_list_seats;
  bool function(GdkDisplay* display, uint keycode, GdkKeymapKey** keys, uint** keyvals, int* nEntries) c_gdk_display_map_keycode;
  bool function(GdkDisplay* display, uint keyval, GdkKeymapKey** keys, int* nKeys) c_gdk_display_map_keyval;
  void function(GdkDisplay* display, const(char)* startupId) c_gdk_display_notify_startup_complete;
  bool function(GdkDisplay* self, GError** _err) c_gdk_display_prepare_gl;
  void function(GdkDisplay* display, GdkEvent* event) c_gdk_display_put_event;
  bool function(GdkDisplay* display) c_gdk_display_supports_input_shapes;
  bool function(GdkDisplay* display) c_gdk_display_supports_shadow_width;
  void function(GdkDisplay* display) c_gdk_display_sync;
  bool function(GdkDisplay* display, uint keycode, GdkModifierType state, int group, uint* keyval, int* effectiveGroup, int* level, GdkModifierType* consumed) c_gdk_display_translate_key;

  // DisplayManager
  GType function() c_gdk_display_manager_get_type;
  GdkDisplayManager* function() c_gdk_display_manager_get;
  GdkDisplay* function(GdkDisplayManager* manager) c_gdk_display_manager_get_default_display;
  GSList* function(GdkDisplayManager* manager) c_gdk_display_manager_list_displays;
  GdkDisplay* function(GdkDisplayManager* manager, const(char)* name) c_gdk_display_manager_open_display;
  void function(GdkDisplayManager* manager, GdkDisplay* display) c_gdk_display_manager_set_default_display;

  // DmabufFormats
  GType function() c_gdk_dmabuf_formats_get_type;
  bool function(GdkDmabufFormats* formats, uint fourcc, ulong modifier) c_gdk_dmabuf_formats_contains;
  bool function(const(GdkDmabufFormats)* formats1, const(GdkDmabufFormats)* formats2) c_gdk_dmabuf_formats_equal;
  void function(GdkDmabufFormats* formats, size_t idx, uint* fourcc, ulong* modifier) c_gdk_dmabuf_formats_get_format;
  size_t function(GdkDmabufFormats* formats) c_gdk_dmabuf_formats_get_n_formats;
  GdkDmabufFormats* function(GdkDmabufFormats* formats) c_gdk_dmabuf_formats_ref;
  void function(GdkDmabufFormats* formats) c_gdk_dmabuf_formats_unref;

  // DmabufTexture
  GType function() c_gdk_dmabuf_texture_get_type;

  // DmabufTextureBuilder
  GType function() c_gdk_dmabuf_texture_builder_get_type;
  GdkDmabufTextureBuilder* function() c_gdk_dmabuf_texture_builder_new;
  GdkTexture* function(GdkDmabufTextureBuilder* self, GDestroyNotify destroy, void* data, GError** _err) c_gdk_dmabuf_texture_builder_build;
  GdkDisplay* function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_display;
  int function(GdkDmabufTextureBuilder* self, uint plane) c_gdk_dmabuf_texture_builder_get_fd;
  uint function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_fourcc;
  uint function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_height;
  ulong function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_modifier;
  uint function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_n_planes;
  uint function(GdkDmabufTextureBuilder* self, uint plane) c_gdk_dmabuf_texture_builder_get_offset;
  bool function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_premultiplied;
  uint function(GdkDmabufTextureBuilder* self, uint plane) c_gdk_dmabuf_texture_builder_get_stride;
  cairo_region_t* function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_update_region;
  GdkTexture* function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_update_texture;
  uint function(GdkDmabufTextureBuilder* self) c_gdk_dmabuf_texture_builder_get_width;
  void function(GdkDmabufTextureBuilder* self, GdkDisplay* display) c_gdk_dmabuf_texture_builder_set_display;
  void function(GdkDmabufTextureBuilder* self, uint plane, int fd) c_gdk_dmabuf_texture_builder_set_fd;
  void function(GdkDmabufTextureBuilder* self, uint fourcc) c_gdk_dmabuf_texture_builder_set_fourcc;
  void function(GdkDmabufTextureBuilder* self, uint height) c_gdk_dmabuf_texture_builder_set_height;
  void function(GdkDmabufTextureBuilder* self, ulong modifier) c_gdk_dmabuf_texture_builder_set_modifier;
  void function(GdkDmabufTextureBuilder* self, uint nPlanes) c_gdk_dmabuf_texture_builder_set_n_planes;
  void function(GdkDmabufTextureBuilder* self, uint plane, uint offset) c_gdk_dmabuf_texture_builder_set_offset;
  void function(GdkDmabufTextureBuilder* self, bool premultiplied) c_gdk_dmabuf_texture_builder_set_premultiplied;
  void function(GdkDmabufTextureBuilder* self, uint plane, uint stride) c_gdk_dmabuf_texture_builder_set_stride;
  void function(GdkDmabufTextureBuilder* self, cairo_region_t* region) c_gdk_dmabuf_texture_builder_set_update_region;
  void function(GdkDmabufTextureBuilder* self, GdkTexture* texture) c_gdk_dmabuf_texture_builder_set_update_texture;
  void function(GdkDmabufTextureBuilder* self, uint width) c_gdk_dmabuf_texture_builder_set_width;

  // Drag
  GType function() c_gdk_drag_get_type;
  GdkDrag* function(GdkSurface* surface, GdkDevice* device, GdkContentProvider* content, GdkDragAction actions, double dx, double dy) c_gdk_drag_begin;
  void function(GdkDrag* drag, bool success) c_gdk_drag_drop_done;
  GdkDragAction function(GdkDrag* drag) c_gdk_drag_get_actions;
  GdkContentProvider* function(GdkDrag* drag) c_gdk_drag_get_content;
  GdkDevice* function(GdkDrag* drag) c_gdk_drag_get_device;
  GdkDisplay* function(GdkDrag* drag) c_gdk_drag_get_display;
  GdkSurface* function(GdkDrag* drag) c_gdk_drag_get_drag_surface;
  GdkContentFormats* function(GdkDrag* drag) c_gdk_drag_get_formats;
  GdkDragAction function(GdkDrag* drag) c_gdk_drag_get_selected_action;
  GdkSurface* function(GdkDrag* drag) c_gdk_drag_get_surface;
  void function(GdkDrag* drag, int hotX, int hotY) c_gdk_drag_set_hotspot;

  // DragSurface
  GType function() c_gdk_drag_surface_get_type;
  bool function(GdkDragSurface* dragSurface, int width, int height) c_gdk_drag_surface_present;

  // DragSurfaceSize
  void function(GdkDragSurfaceSize* size, int width, int height) c_gdk_drag_surface_size_set_size;

  // DrawContext
  GType function() c_gdk_draw_context_get_type;
  void function(GdkDrawContext* context, const(cairo_region_t)* region) c_gdk_draw_context_begin_frame;
  void function(GdkDrawContext* context) c_gdk_draw_context_end_frame;
  GdkDisplay* function(GdkDrawContext* context) c_gdk_draw_context_get_display;
  const(cairo_region_t)* function(GdkDrawContext* context) c_gdk_draw_context_get_frame_region;
  GdkSurface* function(GdkDrawContext* context) c_gdk_draw_context_get_surface;
  bool function(GdkDrawContext* context) c_gdk_draw_context_is_in_frame;

  // Drop
  GType function() c_gdk_drop_get_type;
  void function(GdkDrop* self, GdkDragAction action) c_gdk_drop_finish;
  GdkDragAction function(GdkDrop* self) c_gdk_drop_get_actions;
  GdkDevice* function(GdkDrop* self) c_gdk_drop_get_device;
  GdkDisplay* function(GdkDrop* self) c_gdk_drop_get_display;
  GdkDrag* function(GdkDrop* self) c_gdk_drop_get_drag;
  GdkContentFormats* function(GdkDrop* self) c_gdk_drop_get_formats;
  GdkSurface* function(GdkDrop* self) c_gdk_drop_get_surface;
  void function(GdkDrop* self, const(char*)* mimeTypes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_drop_read_async;
  GInputStream* function(GdkDrop* self, GAsyncResult* result, const(char*)* outMimeType, GError** _err) c_gdk_drop_read_finish;
  void function(GdkDrop* self, GType type, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_drop_read_value_async;
  const(GValue)* function(GdkDrop* self, GAsyncResult* result, GError** _err) c_gdk_drop_read_value_finish;
  void function(GdkDrop* self, GdkDragAction actions, GdkDragAction preferred) c_gdk_drop_status;

  // Event
  GType function() c_gdk_event_get_type;
  bool function(GdkEvent* event, double** axes, uint* nAxes) c_gdk_event_get_axes;
  bool function(GdkEvent* event, GdkAxisUse axisUse, double* value) c_gdk_event_get_axis;
  GdkDevice* function(GdkEvent* event) c_gdk_event_get_device;
  GdkDeviceTool* function(GdkEvent* event) c_gdk_event_get_device_tool;
  GdkDisplay* function(GdkEvent* event) c_gdk_event_get_display;
  GdkEventSequence* function(GdkEvent* event) c_gdk_event_get_event_sequence;
  GdkEventType function(GdkEvent* event) c_gdk_event_get_event_type;
  GdkTimeCoord* function(GdkEvent* event, uint* outNCoords) c_gdk_event_get_history;
  GdkModifierType function(GdkEvent* event) c_gdk_event_get_modifier_state;
  bool function(GdkEvent* event) c_gdk_event_get_pointer_emulated;
  bool function(GdkEvent* event, double* x, double* y) c_gdk_event_get_position;
  GdkSeat* function(GdkEvent* event) c_gdk_event_get_seat;
  GdkSurface* function(GdkEvent* event) c_gdk_event_get_surface;
  uint function(GdkEvent* event) c_gdk_event_get_time;
  GdkEvent* function(GdkEvent* event) c_gdk_event_ref;
  bool function(GdkEvent* event) c_gdk_event_triggers_context_menu;
  void function(GdkEvent* event) c_gdk_event_unref;

  // EventSequence
  GType function() c_gdk_event_sequence_get_type;

  // FileList
  GType function() c_gdk_file_list_get_type;
  GdkFileList* function(GFile** files, size_t nFiles) c_gdk_file_list_new_from_array;
  GdkFileList* function(GSList* files) c_gdk_file_list_new_from_list;
  GSList* function(GdkFileList* fileList) c_gdk_file_list_get_files;

  // FocusEvent
  GType function() c_gdk_focus_event_get_type;
  bool function(GdkEvent* event) c_gdk_focus_event_get_in;

  // FrameClock
  GType function() c_gdk_frame_clock_get_type;
  void function(GdkFrameClock* frameClock) c_gdk_frame_clock_begin_updating;
  void function(GdkFrameClock* frameClock) c_gdk_frame_clock_end_updating;
  GdkFrameTimings* function(GdkFrameClock* frameClock) c_gdk_frame_clock_get_current_timings;
  double function(GdkFrameClock* frameClock) c_gdk_frame_clock_get_fps;
  long function(GdkFrameClock* frameClock) c_gdk_frame_clock_get_frame_counter;
  long function(GdkFrameClock* frameClock) c_gdk_frame_clock_get_frame_time;
  long function(GdkFrameClock* frameClock) c_gdk_frame_clock_get_history_start;
  void function(GdkFrameClock* frameClock, long baseTime, long* refreshIntervalReturn, long* presentationTimeReturn) c_gdk_frame_clock_get_refresh_info;
  GdkFrameTimings* function(GdkFrameClock* frameClock, long frameCounter) c_gdk_frame_clock_get_timings;
  void function(GdkFrameClock* frameClock, GdkFrameClockPhase phase) c_gdk_frame_clock_request_phase;

  // FrameTimings
  GType function() c_gdk_frame_timings_get_type;
  bool function(GdkFrameTimings* timings) c_gdk_frame_timings_get_complete;
  long function(GdkFrameTimings* timings) c_gdk_frame_timings_get_frame_counter;
  long function(GdkFrameTimings* timings) c_gdk_frame_timings_get_frame_time;
  long function(GdkFrameTimings* timings) c_gdk_frame_timings_get_predicted_presentation_time;
  long function(GdkFrameTimings* timings) c_gdk_frame_timings_get_presentation_time;
  long function(GdkFrameTimings* timings) c_gdk_frame_timings_get_refresh_interval;
  GdkFrameTimings* function(GdkFrameTimings* timings) c_gdk_frame_timings_ref;
  void function(GdkFrameTimings* timings) c_gdk_frame_timings_unref;

  // GLContext
  GType function() c_gdk_gl_context_get_type;
  void function() c_gdk_gl_context_clear_current;
  GdkGLContext* function() c_gdk_gl_context_get_current;
  GdkGLAPI function(GdkGLContext* self) c_gdk_gl_context_get_allowed_apis;
  GdkGLAPI function(GdkGLContext* self) c_gdk_gl_context_get_api;
  bool function(GdkGLContext* context) c_gdk_gl_context_get_debug_enabled;
  GdkDisplay* function(GdkGLContext* context) c_gdk_gl_context_get_display;
  bool function(GdkGLContext* context) c_gdk_gl_context_get_forward_compatible;
  void function(GdkGLContext* context, int* major, int* minor) c_gdk_gl_context_get_required_version;
  GdkGLContext* function(GdkGLContext* context) c_gdk_gl_context_get_shared_context;
  GdkSurface* function(GdkGLContext* context) c_gdk_gl_context_get_surface;
  bool function(GdkGLContext* context) c_gdk_gl_context_get_use_es;
  void function(GdkGLContext* context, int* major, int* minor) c_gdk_gl_context_get_version;
  bool function(GdkGLContext* context) c_gdk_gl_context_is_legacy;
  bool function(GdkGLContext* self, GdkGLContext* other) c_gdk_gl_context_is_shared;
  void function(GdkGLContext* context) c_gdk_gl_context_make_current;
  bool function(GdkGLContext* context, GError** _err) c_gdk_gl_context_realize;
  void function(GdkGLContext* self, GdkGLAPI apis) c_gdk_gl_context_set_allowed_apis;
  void function(GdkGLContext* context, bool enabled) c_gdk_gl_context_set_debug_enabled;
  void function(GdkGLContext* context, bool compatible) c_gdk_gl_context_set_forward_compatible;
  void function(GdkGLContext* context, int major, int minor) c_gdk_gl_context_set_required_version;
  void function(GdkGLContext* context, int useEs) c_gdk_gl_context_set_use_es;

  // GLTexture
  GType function() c_gdk_gl_texture_get_type;
  GdkTexture* function(GdkGLContext* context, uint id, int width, int height, GDestroyNotify destroy, void* data) c_gdk_gl_texture_new;
  void function(GdkGLTexture* self) c_gdk_gl_texture_release;

  // GLTextureBuilder
  GType function() c_gdk_gl_texture_builder_get_type;
  GdkGLTextureBuilder* function() c_gdk_gl_texture_builder_new;
  GdkTexture* function(GdkGLTextureBuilder* self, GDestroyNotify destroy, void* data) c_gdk_gl_texture_builder_build;
  GdkGLContext* function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_context;
  GdkMemoryFormat function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_format;
  bool function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_has_mipmap;
  int function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_height;
  uint function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_id;
  void* function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_sync;
  cairo_region_t* function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_update_region;
  GdkTexture* function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_update_texture;
  int function(GdkGLTextureBuilder* self) c_gdk_gl_texture_builder_get_width;
  void function(GdkGLTextureBuilder* self, GdkGLContext* context) c_gdk_gl_texture_builder_set_context;
  void function(GdkGLTextureBuilder* self, GdkMemoryFormat format) c_gdk_gl_texture_builder_set_format;
  void function(GdkGLTextureBuilder* self, bool hasMipmap) c_gdk_gl_texture_builder_set_has_mipmap;
  void function(GdkGLTextureBuilder* self, int height) c_gdk_gl_texture_builder_set_height;
  void function(GdkGLTextureBuilder* self, uint id) c_gdk_gl_texture_builder_set_id;
  void function(GdkGLTextureBuilder* self, void* sync) c_gdk_gl_texture_builder_set_sync;
  void function(GdkGLTextureBuilder* self, cairo_region_t* region) c_gdk_gl_texture_builder_set_update_region;
  void function(GdkGLTextureBuilder* self, GdkTexture* texture) c_gdk_gl_texture_builder_set_update_texture;
  void function(GdkGLTextureBuilder* self, int width) c_gdk_gl_texture_builder_set_width;

  // Global
  void function(cairo_t* cr, GdkSurface* surface, int source, int sourceType, int bufferScale, int x, int y, int width, int height) c_gdk_cairo_draw_from_gl;
  void function(cairo_t* cr, const(GdkRectangle)* rectangle) c_gdk_cairo_rectangle;
  void function(cairo_t* cr, const(cairo_region_t)* region) c_gdk_cairo_region;
  cairo_region_t* function(cairo_surface_t* surface) c_gdk_cairo_region_create_from_surface;
  void function(cairo_t* cr, const(PixbufC)* pixbuf, double pixbufX, double pixbufY) c_gdk_cairo_set_source_pixbuf;
  void function(cairo_t* cr, const(GdkRGBA)* rgba) c_gdk_cairo_set_source_rgba;
  void function(GInputStream* stream, const(char)* mimeType, GType type, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_content_deserialize_async;
  bool function(GAsyncResult* result, GValue* value, GError** _err) c_gdk_content_deserialize_finish;
  void function(const(char)* mimeType, GType type, GdkContentDeserializeFunc deserialize, void* data, GDestroyNotify notify) c_gdk_content_register_deserializer;
  void function(GType type, const(char)* mimeType, GdkContentSerializeFunc serialize, void* data, GDestroyNotify notify) c_gdk_content_register_serializer;
  void function(GOutputStream* stream, const(char)* mimeType, const(GValue)* value, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_content_serialize_async;
  bool function(GAsyncResult* result, GError** _err) c_gdk_content_serialize_finish;
  GType function() c_gdk_drag_surface_size_get_type;
  bool function(GdkEvent* event1, GdkEvent* event2, double* angle) c_gdk_events_get_angle;
  bool function(GdkEvent* event1, GdkEvent* event2, double* x, double* y) c_gdk_events_get_center;
  bool function(GdkEvent* event1, GdkEvent* event2, double* distance) c_gdk_events_get_distance;
  const(char)* function(const(char)* string_) c_gdk_intern_mime_type;
  void function(uint symbol, uint* lower, uint* upper) c_gdk_keyval_convert_case;
  uint function(const(char)* keyvalName) c_gdk_keyval_from_name;
  bool function(uint keyval) c_gdk_keyval_is_lower;
  bool function(uint keyval) c_gdk_keyval_is_upper;
  const(char)* function(uint keyval) c_gdk_keyval_name;
  uint function(uint keyval) c_gdk_keyval_to_lower;
  uint function(uint keyval) c_gdk_keyval_to_unicode;
  uint function(uint keyval) c_gdk_keyval_to_upper;
  cairo_region_t* function(PangoLayout* layout, int xOrigin, int yOrigin, const(int)* indexRanges, int nRanges) c_gdk_pango_layout_get_clip_region;
  cairo_region_t* function(PangoLayoutLine* line, int xOrigin, int yOrigin, const(int)* indexRanges, int nRanges) c_gdk_pango_layout_line_get_clip_region;
  PixbufC* function(cairo_surface_t* surface, int srcX, int srcY, int width, int height) c_gdk_pixbuf_get_from_surface;
  PixbufC* function(GdkTexture* texture) c_gdk_pixbuf_get_from_texture;
  void function(const(char)* backends) c_gdk_set_allowed_backends;
  GType function() c_gdk_toplevel_size_get_type;
  uint function(uint wc) c_gdk_unicode_to_keyval;

  // GrabBrokenEvent
  GType function() c_gdk_grab_broken_event_get_type;
  GdkSurface* function(GdkEvent* event) c_gdk_grab_broken_event_get_grab_surface;
  bool function(GdkEvent* event) c_gdk_grab_broken_event_get_implicit;

  // KeyEvent
  GType function() c_gdk_key_event_get_type;
  GdkModifierType function(GdkEvent* event) c_gdk_key_event_get_consumed_modifiers;
  uint function(GdkEvent* event) c_gdk_key_event_get_keycode;
  uint function(GdkEvent* event) c_gdk_key_event_get_keyval;
  uint function(GdkEvent* event) c_gdk_key_event_get_layout;
  uint function(GdkEvent* event) c_gdk_key_event_get_level;
  bool function(GdkEvent* event, uint* keyval, GdkModifierType* modifiers) c_gdk_key_event_get_match;
  bool function(GdkEvent* event) c_gdk_key_event_is_modifier;
  GdkKeyMatch function(GdkEvent* event, uint keyval, GdkModifierType modifiers) c_gdk_key_event_matches;

  // MemoryTexture
  GType function() c_gdk_memory_texture_get_type;
  GdkTexture* function(int width, int height, GdkMemoryFormat format, GBytes* bytes, size_t stride) c_gdk_memory_texture_new;

  // MonitorG
  GType function() c_gdk_monitor_get_type;
  const(char)* function(GdkMonitor* monitor) c_gdk_monitor_get_connector;
  const(char)* function(GdkMonitor* monitor) c_gdk_monitor_get_description;
  GdkDisplay* function(GdkMonitor* monitor) c_gdk_monitor_get_display;
  void function(GdkMonitor* monitor, GdkRectangle* geometry) c_gdk_monitor_get_geometry;
  int function(GdkMonitor* monitor) c_gdk_monitor_get_height_mm;
  const(char)* function(GdkMonitor* monitor) c_gdk_monitor_get_manufacturer;
  const(char)* function(GdkMonitor* monitor) c_gdk_monitor_get_model;
  int function(GdkMonitor* monitor) c_gdk_monitor_get_refresh_rate;
  double function(GdkMonitor* monitor) c_gdk_monitor_get_scale;
  int function(GdkMonitor* monitor) c_gdk_monitor_get_scale_factor;
  GdkSubpixelLayout function(GdkMonitor* monitor) c_gdk_monitor_get_subpixel_layout;
  int function(GdkMonitor* monitor) c_gdk_monitor_get_width_mm;
  bool function(GdkMonitor* monitor) c_gdk_monitor_is_valid;

  // MotionEvent
  GType function() c_gdk_motion_event_get_type;

  // PadEvent
  GType function() c_gdk_pad_event_get_type;
  void function(GdkEvent* event, uint* index, double* value) c_gdk_pad_event_get_axis_value;
  uint function(GdkEvent* event) c_gdk_pad_event_get_button;
  void function(GdkEvent* event, uint* group, uint* mode) c_gdk_pad_event_get_group_mode;

  // Paintable
  GType function() c_gdk_paintable_get_type;
  GdkPaintable* function(int intrinsicWidth, int intrinsicHeight) c_gdk_paintable_new_empty;
  void function(GdkPaintable* paintable, double specifiedWidth, double specifiedHeight, double defaultWidth, double defaultHeight, double* concreteWidth, double* concreteHeight) c_gdk_paintable_compute_concrete_size;
  GdkPaintable* function(GdkPaintable* paintable) c_gdk_paintable_get_current_image;
  GdkPaintableFlags function(GdkPaintable* paintable) c_gdk_paintable_get_flags;
  double function(GdkPaintable* paintable) c_gdk_paintable_get_intrinsic_aspect_ratio;
  int function(GdkPaintable* paintable) c_gdk_paintable_get_intrinsic_height;
  int function(GdkPaintable* paintable) c_gdk_paintable_get_intrinsic_width;
  void function(GdkPaintable* paintable) c_gdk_paintable_invalidate_contents;
  void function(GdkPaintable* paintable) c_gdk_paintable_invalidate_size;
  void function(GdkPaintable* paintable, GdkSnapshot* snapshot, double width, double height) c_gdk_paintable_snapshot;

  // Popup
  GType function() c_gdk_popup_get_type;
  bool function(GdkPopup* popup) c_gdk_popup_get_autohide;
  GdkSurface* function(GdkPopup* popup) c_gdk_popup_get_parent;
  int function(GdkPopup* popup) c_gdk_popup_get_position_x;
  int function(GdkPopup* popup) c_gdk_popup_get_position_y;
  GdkGravity function(GdkPopup* popup) c_gdk_popup_get_rect_anchor;
  GdkGravity function(GdkPopup* popup) c_gdk_popup_get_surface_anchor;
  bool function(GdkPopup* popup, int width, int height, GdkPopupLayout* layout) c_gdk_popup_present;

  // PopupLayout
  GType function() c_gdk_popup_layout_get_type;
  GdkPopupLayout* function(const(GdkRectangle)* anchorRect, GdkGravity rectAnchor, GdkGravity surfaceAnchor) c_gdk_popup_layout_new;
  GdkPopupLayout* function(GdkPopupLayout* layout) c_gdk_popup_layout_copy;
  bool function(GdkPopupLayout* layout, GdkPopupLayout* other) c_gdk_popup_layout_equal;
  GdkAnchorHints function(GdkPopupLayout* layout) c_gdk_popup_layout_get_anchor_hints;
  const(GdkRectangle)* function(GdkPopupLayout* layout) c_gdk_popup_layout_get_anchor_rect;
  void function(GdkPopupLayout* layout, int* dx, int* dy) c_gdk_popup_layout_get_offset;
  GdkGravity function(GdkPopupLayout* layout) c_gdk_popup_layout_get_rect_anchor;
  void function(GdkPopupLayout* layout, int* left, int* right, int* top, int* bottom) c_gdk_popup_layout_get_shadow_width;
  GdkGravity function(GdkPopupLayout* layout) c_gdk_popup_layout_get_surface_anchor;
  GdkPopupLayout* function(GdkPopupLayout* layout) c_gdk_popup_layout_ref;
  void function(GdkPopupLayout* layout, GdkAnchorHints anchorHints) c_gdk_popup_layout_set_anchor_hints;
  void function(GdkPopupLayout* layout, const(GdkRectangle)* anchorRect) c_gdk_popup_layout_set_anchor_rect;
  void function(GdkPopupLayout* layout, int dx, int dy) c_gdk_popup_layout_set_offset;
  void function(GdkPopupLayout* layout, GdkGravity anchor) c_gdk_popup_layout_set_rect_anchor;
  void function(GdkPopupLayout* layout, int left, int right, int top, int bottom) c_gdk_popup_layout_set_shadow_width;
  void function(GdkPopupLayout* layout, GdkGravity anchor) c_gdk_popup_layout_set_surface_anchor;
  void function(GdkPopupLayout* layout) c_gdk_popup_layout_unref;

  // ProximityEvent
  GType function() c_gdk_proximity_event_get_type;

  // RGBA
  GType function() c_gdk_rgba_get_type;
  GdkRGBA* function(const(GdkRGBA)* rgba) c_gdk_rgba_copy;
  bool function(GdkRGBA* p1, GdkRGBA* p2) c_gdk_rgba_equal;
  void function(GdkRGBA* rgba) c_gdk_rgba_free;
  uint function(GdkRGBA* p) c_gdk_rgba_hash;
  bool function(const(GdkRGBA)* rgba) c_gdk_rgba_is_clear;
  bool function(const(GdkRGBA)* rgba) c_gdk_rgba_is_opaque;
  bool function(GdkRGBA* rgba, const(char)* spec) c_gdk_rgba_parse;
  char* function(const(GdkRGBA)* rgba) c_gdk_rgba_to_string;

  // Rectangle
  GType function() c_gdk_rectangle_get_type;
  bool function(const(GdkRectangle)* rect, int x, int y) c_gdk_rectangle_contains_point;
  bool function(const(GdkRectangle)* rect1, const(GdkRectangle)* rect2) c_gdk_rectangle_equal;
  bool function(const(GdkRectangle)* src1, const(GdkRectangle)* src2, GdkRectangle* dest) c_gdk_rectangle_intersect;
  void function(const(GdkRectangle)* src1, const(GdkRectangle)* src2, GdkRectangle* dest) c_gdk_rectangle_union;

  // ScrollEvent
  GType function() c_gdk_scroll_event_get_type;
  void function(GdkEvent* event, double* deltaX, double* deltaY) c_gdk_scroll_event_get_deltas;
  GdkScrollDirection function(GdkEvent* event) c_gdk_scroll_event_get_direction;
  GdkScrollUnit function(GdkEvent* event) c_gdk_scroll_event_get_unit;
  bool function(GdkEvent* event) c_gdk_scroll_event_is_stop;

  // Seat
  GType function() c_gdk_seat_get_type;
  GdkSeatCapabilities function(GdkSeat* seat) c_gdk_seat_get_capabilities;
  GList* function(GdkSeat* seat, GdkSeatCapabilities capabilities) c_gdk_seat_get_devices;
  GdkDisplay* function(GdkSeat* seat) c_gdk_seat_get_display;
  GdkDevice* function(GdkSeat* seat) c_gdk_seat_get_keyboard;
  GdkDevice* function(GdkSeat* seat) c_gdk_seat_get_pointer;
  GList* function(GdkSeat* seat) c_gdk_seat_get_tools;

  // Snapshot
  GType function() c_gdk_snapshot_get_type;

  // Surface
  GType function() c_gdk_surface_get_type;
  GdkSurface* function(GdkSurface* parent, bool autohide) c_gdk_surface_new_popup;
  GdkSurface* function(GdkDisplay* display) c_gdk_surface_new_toplevel;
  void function(GdkSurface* surface) c_gdk_surface_beep;
  GdkCairoContext* function(GdkSurface* surface) c_gdk_surface_create_cairo_context;
  GdkGLContext* function(GdkSurface* surface, GError** _err) c_gdk_surface_create_gl_context;
  cairo_surface_t* function(GdkSurface* surface, cairo_content_t content, int width, int height) c_gdk_surface_create_similar_surface;
  GdkVulkanContext* function(GdkSurface* surface, GError** _err) c_gdk_surface_create_vulkan_context;
  void function(GdkSurface* surface) c_gdk_surface_destroy;
  GdkCursor* function(GdkSurface* surface) c_gdk_surface_get_cursor;
  GdkCursor* function(GdkSurface* surface, GdkDevice* device) c_gdk_surface_get_device_cursor;
  bool function(GdkSurface* surface, GdkDevice* device, double* x, double* y, GdkModifierType* mask) c_gdk_surface_get_device_position;
  GdkDisplay* function(GdkSurface* surface) c_gdk_surface_get_display;
  GdkFrameClock* function(GdkSurface* surface) c_gdk_surface_get_frame_clock;
  int function(GdkSurface* surface) c_gdk_surface_get_height;
  bool function(GdkSurface* surface) c_gdk_surface_get_mapped;
  double function(GdkSurface* surface) c_gdk_surface_get_scale;
  int function(GdkSurface* surface) c_gdk_surface_get_scale_factor;
  int function(GdkSurface* surface) c_gdk_surface_get_width;
  void function(GdkSurface* surface) c_gdk_surface_hide;
  bool function(GdkSurface* surface) c_gdk_surface_is_destroyed;
  void function(GdkSurface* surface) c_gdk_surface_queue_render;
  void function(GdkSurface* surface) c_gdk_surface_request_layout;
  void function(GdkSurface* surface, GdkCursor* cursor) c_gdk_surface_set_cursor;
  void function(GdkSurface* surface, GdkDevice* device, GdkCursor* cursor) c_gdk_surface_set_device_cursor;
  void function(GdkSurface* surface, cairo_region_t* region) c_gdk_surface_set_input_region;
  void function(GdkSurface* surface, cairo_region_t* region) c_gdk_surface_set_opaque_region;
  bool function(GdkSurface* from, GdkSurface* to, double* x, double* y) c_gdk_surface_translate_coordinates;

  // Texture
  GType function() c_gdk_texture_get_type;
  GdkTexture* function(PixbufC* pixbuf) c_gdk_texture_new_for_pixbuf;
  GdkTexture* function(GBytes* bytes, GError** _err) c_gdk_texture_new_from_bytes;
  GdkTexture* function(GFile* file, GError** _err) c_gdk_texture_new_from_file;
  GdkTexture* function(const(char)* path, GError** _err) c_gdk_texture_new_from_filename;
  GdkTexture* function(const(char)* resourcePath) c_gdk_texture_new_from_resource;
  void function(GdkTexture* texture, ubyte* data, size_t stride) c_gdk_texture_download;
  GdkMemoryFormat function(GdkTexture* self) c_gdk_texture_get_format;
  int function(GdkTexture* texture) c_gdk_texture_get_height;
  int function(GdkTexture* texture) c_gdk_texture_get_width;
  bool function(GdkTexture* texture, const(char)* filename) c_gdk_texture_save_to_png;
  GBytes* function(GdkTexture* texture) c_gdk_texture_save_to_png_bytes;
  bool function(GdkTexture* texture, const(char)* filename) c_gdk_texture_save_to_tiff;
  GBytes* function(GdkTexture* texture) c_gdk_texture_save_to_tiff_bytes;

  // TextureDownloader
  GType function() c_gdk_texture_downloader_get_type;
  GdkTextureDownloader* function(GdkTexture* texture) c_gdk_texture_downloader_new;
  GdkTextureDownloader* function(const(GdkTextureDownloader)* self) c_gdk_texture_downloader_copy;
  GBytes* function(const(GdkTextureDownloader)* self, size_t* outStride) c_gdk_texture_downloader_download_bytes;
  void function(const(GdkTextureDownloader)* self, ubyte* data, size_t stride) c_gdk_texture_downloader_download_into;
  void function(GdkTextureDownloader* self) c_gdk_texture_downloader_free;
  GdkMemoryFormat function(const(GdkTextureDownloader)* self) c_gdk_texture_downloader_get_format;
  GdkTexture* function(const(GdkTextureDownloader)* self) c_gdk_texture_downloader_get_texture;
  void function(GdkTextureDownloader* self, GdkMemoryFormat format) c_gdk_texture_downloader_set_format;
  void function(GdkTextureDownloader* self, GdkTexture* texture) c_gdk_texture_downloader_set_texture;

  // Toplevel
  GType function() c_gdk_toplevel_get_type;
  void function(GdkToplevel* toplevel, GdkDevice* device, int button, double x, double y, uint timestamp) c_gdk_toplevel_begin_move;
  void function(GdkToplevel* toplevel, GdkSurfaceEdge edge, GdkDevice* device, int button, double x, double y, uint timestamp) c_gdk_toplevel_begin_resize;
  void function(GdkToplevel* toplevel, uint timestamp) c_gdk_toplevel_focus;
  GdkToplevelState function(GdkToplevel* toplevel) c_gdk_toplevel_get_state;
  void function(GdkToplevel* toplevel, GdkEvent* event) c_gdk_toplevel_inhibit_system_shortcuts;
  bool function(GdkToplevel* toplevel) c_gdk_toplevel_lower;
  bool function(GdkToplevel* toplevel) c_gdk_toplevel_minimize;
  void function(GdkToplevel* toplevel, GdkToplevelLayout* layout) c_gdk_toplevel_present;
  void function(GdkToplevel* toplevel) c_gdk_toplevel_restore_system_shortcuts;
  void function(GdkToplevel* toplevel, bool decorated) c_gdk_toplevel_set_decorated;
  void function(GdkToplevel* toplevel, bool deletable) c_gdk_toplevel_set_deletable;
  void function(GdkToplevel* toplevel, GList* surfaces) c_gdk_toplevel_set_icon_list;
  void function(GdkToplevel* toplevel, bool modal) c_gdk_toplevel_set_modal;
  void function(GdkToplevel* toplevel, const(char)* startupId) c_gdk_toplevel_set_startup_id;
  void function(GdkToplevel* toplevel, const(char)* title) c_gdk_toplevel_set_title;
  void function(GdkToplevel* toplevel, GdkSurface* parent) c_gdk_toplevel_set_transient_for;
  bool function(GdkToplevel* toplevel, GdkEvent* event) c_gdk_toplevel_show_window_menu;
  bool function(GdkToplevel* toplevel) c_gdk_toplevel_supports_edge_constraints;
  bool function(GdkToplevel* toplevel, GdkTitlebarGesture gesture) c_gdk_toplevel_titlebar_gesture;

  // ToplevelLayout
  GType function() c_gdk_toplevel_layout_get_type;
  GdkToplevelLayout* function() c_gdk_toplevel_layout_new;
  GdkToplevelLayout* function(GdkToplevelLayout* layout) c_gdk_toplevel_layout_copy;
  bool function(GdkToplevelLayout* layout, GdkToplevelLayout* other) c_gdk_toplevel_layout_equal;
  bool function(GdkToplevelLayout* layout, bool* fullscreen) c_gdk_toplevel_layout_get_fullscreen;
  GdkMonitor* function(GdkToplevelLayout* layout) c_gdk_toplevel_layout_get_fullscreen_monitor;
  bool function(GdkToplevelLayout* layout, bool* maximized) c_gdk_toplevel_layout_get_maximized;
  bool function(GdkToplevelLayout* layout) c_gdk_toplevel_layout_get_resizable;
  GdkToplevelLayout* function(GdkToplevelLayout* layout) c_gdk_toplevel_layout_ref;
  void function(GdkToplevelLayout* layout, bool fullscreen, GdkMonitor* monitor) c_gdk_toplevel_layout_set_fullscreen;
  void function(GdkToplevelLayout* layout, bool maximized) c_gdk_toplevel_layout_set_maximized;
  void function(GdkToplevelLayout* layout, bool resizable) c_gdk_toplevel_layout_set_resizable;
  void function(GdkToplevelLayout* layout) c_gdk_toplevel_layout_unref;

  // ToplevelSize
  void function(GdkToplevelSize* size, int* boundsWidth, int* boundsHeight) c_gdk_toplevel_size_get_bounds;
  void function(GdkToplevelSize* size, int minWidth, int minHeight) c_gdk_toplevel_size_set_min_size;
  void function(GdkToplevelSize* size, int left, int right, int top, int bottom) c_gdk_toplevel_size_set_shadow_width;
  void function(GdkToplevelSize* size, int width, int height) c_gdk_toplevel_size_set_size;

  // TouchEvent
  GType function() c_gdk_touch_event_get_type;
  bool function(GdkEvent* event) c_gdk_touch_event_get_emulating_pointer;

  // TouchpadEvent
  GType function() c_gdk_touchpad_event_get_type;
  void function(GdkEvent* event, double* dx, double* dy) c_gdk_touchpad_event_get_deltas;
  GdkTouchpadGesturePhase function(GdkEvent* event) c_gdk_touchpad_event_get_gesture_phase;
  uint function(GdkEvent* event) c_gdk_touchpad_event_get_n_fingers;
  double function(GdkEvent* event) c_gdk_touchpad_event_get_pinch_angle_delta;
  double function(GdkEvent* event) c_gdk_touchpad_event_get_pinch_scale;

  // VulkanContext
  GType function() c_gdk_vulkan_context_get_type;
}

// AppLaunchContext
alias gdk_app_launch_context_get_type = c_gdk_app_launch_context_get_type;
alias gdk_app_launch_context_get_display = c_gdk_app_launch_context_get_display;
alias gdk_app_launch_context_set_desktop = c_gdk_app_launch_context_set_desktop;
alias gdk_app_launch_context_set_icon = c_gdk_app_launch_context_set_icon;
alias gdk_app_launch_context_set_icon_name = c_gdk_app_launch_context_set_icon_name;
alias gdk_app_launch_context_set_timestamp = c_gdk_app_launch_context_set_timestamp;

// ButtonEvent
alias gdk_button_event_get_type = c_gdk_button_event_get_type;
alias gdk_button_event_get_button = c_gdk_button_event_get_button;

// CairoContext
alias gdk_cairo_context_get_type = c_gdk_cairo_context_get_type;
alias gdk_cairo_context_cairo_create = c_gdk_cairo_context_cairo_create;

// Clipboard
alias gdk_clipboard_get_type = c_gdk_clipboard_get_type;
alias gdk_clipboard_get_content = c_gdk_clipboard_get_content;
alias gdk_clipboard_get_display = c_gdk_clipboard_get_display;
alias gdk_clipboard_get_formats = c_gdk_clipboard_get_formats;
alias gdk_clipboard_is_local = c_gdk_clipboard_is_local;
alias gdk_clipboard_read_async = c_gdk_clipboard_read_async;
alias gdk_clipboard_read_finish = c_gdk_clipboard_read_finish;
alias gdk_clipboard_read_text_async = c_gdk_clipboard_read_text_async;
alias gdk_clipboard_read_text_finish = c_gdk_clipboard_read_text_finish;
alias gdk_clipboard_read_texture_async = c_gdk_clipboard_read_texture_async;
alias gdk_clipboard_read_texture_finish = c_gdk_clipboard_read_texture_finish;
alias gdk_clipboard_read_value_async = c_gdk_clipboard_read_value_async;
alias gdk_clipboard_read_value_finish = c_gdk_clipboard_read_value_finish;
alias gdk_clipboard_set = c_gdk_clipboard_set;
alias gdk_clipboard_set_content = c_gdk_clipboard_set_content;
alias gdk_clipboard_set_text = c_gdk_clipboard_set_text;
alias gdk_clipboard_set_texture = c_gdk_clipboard_set_texture;
alias gdk_clipboard_set_valist = c_gdk_clipboard_set_valist;
alias gdk_clipboard_set_value = c_gdk_clipboard_set_value;
alias gdk_clipboard_store_async = c_gdk_clipboard_store_async;
alias gdk_clipboard_store_finish = c_gdk_clipboard_store_finish;

// ContentDeserializer
alias gdk_content_deserializer_get_type = c_gdk_content_deserializer_get_type;
alias gdk_content_deserializer_get_cancellable = c_gdk_content_deserializer_get_cancellable;
alias gdk_content_deserializer_get_gtype = c_gdk_content_deserializer_get_gtype;
alias gdk_content_deserializer_get_input_stream = c_gdk_content_deserializer_get_input_stream;
alias gdk_content_deserializer_get_mime_type = c_gdk_content_deserializer_get_mime_type;
alias gdk_content_deserializer_get_priority = c_gdk_content_deserializer_get_priority;
alias gdk_content_deserializer_get_task_data = c_gdk_content_deserializer_get_task_data;
alias gdk_content_deserializer_get_user_data = c_gdk_content_deserializer_get_user_data;
alias gdk_content_deserializer_get_value = c_gdk_content_deserializer_get_value;
alias gdk_content_deserializer_return_error = c_gdk_content_deserializer_return_error;
alias gdk_content_deserializer_return_success = c_gdk_content_deserializer_return_success;
alias gdk_content_deserializer_set_task_data = c_gdk_content_deserializer_set_task_data;

// ContentFormats
alias gdk_content_formats_get_type = c_gdk_content_formats_get_type;
alias gdk_content_formats_new = c_gdk_content_formats_new;
alias gdk_content_formats_new_for_gtype = c_gdk_content_formats_new_for_gtype;
alias gdk_content_formats_contain_gtype = c_gdk_content_formats_contain_gtype;
alias gdk_content_formats_contain_mime_type = c_gdk_content_formats_contain_mime_type;
alias gdk_content_formats_get_gtypes = c_gdk_content_formats_get_gtypes;
alias gdk_content_formats_get_mime_types = c_gdk_content_formats_get_mime_types;
alias gdk_content_formats_match = c_gdk_content_formats_match;
alias gdk_content_formats_match_gtype = c_gdk_content_formats_match_gtype;
alias gdk_content_formats_match_mime_type = c_gdk_content_formats_match_mime_type;
alias gdk_content_formats_print = c_gdk_content_formats_print;
alias gdk_content_formats_ref = c_gdk_content_formats_ref;
alias gdk_content_formats_to_string = c_gdk_content_formats_to_string;
alias gdk_content_formats_union = c_gdk_content_formats_union;
alias gdk_content_formats_union_deserialize_gtypes = c_gdk_content_formats_union_deserialize_gtypes;
alias gdk_content_formats_union_deserialize_mime_types = c_gdk_content_formats_union_deserialize_mime_types;
alias gdk_content_formats_union_serialize_gtypes = c_gdk_content_formats_union_serialize_gtypes;
alias gdk_content_formats_union_serialize_mime_types = c_gdk_content_formats_union_serialize_mime_types;
alias gdk_content_formats_unref = c_gdk_content_formats_unref;
alias gdk_content_formats_parse = c_gdk_content_formats_parse;

// ContentFormatsBuilder
alias gdk_content_formats_builder_get_type = c_gdk_content_formats_builder_get_type;
alias gdk_content_formats_builder_new = c_gdk_content_formats_builder_new;
alias gdk_content_formats_builder_add_formats = c_gdk_content_formats_builder_add_formats;
alias gdk_content_formats_builder_add_gtype = c_gdk_content_formats_builder_add_gtype;
alias gdk_content_formats_builder_add_mime_type = c_gdk_content_formats_builder_add_mime_type;
alias gdk_content_formats_builder_free_to_formats = c_gdk_content_formats_builder_free_to_formats;
alias gdk_content_formats_builder_ref = c_gdk_content_formats_builder_ref;
alias gdk_content_formats_builder_to_formats = c_gdk_content_formats_builder_to_formats;
alias gdk_content_formats_builder_unref = c_gdk_content_formats_builder_unref;

// ContentProvider
alias gdk_content_provider_get_type = c_gdk_content_provider_get_type;
alias gdk_content_provider_new_for_bytes = c_gdk_content_provider_new_for_bytes;
alias gdk_content_provider_new_for_value = c_gdk_content_provider_new_for_value;
alias gdk_content_provider_new_typed = c_gdk_content_provider_new_typed;
alias gdk_content_provider_new_union = c_gdk_content_provider_new_union;
alias gdk_content_provider_content_changed = c_gdk_content_provider_content_changed;
alias gdk_content_provider_get_value = c_gdk_content_provider_get_value;
alias gdk_content_provider_ref_formats = c_gdk_content_provider_ref_formats;
alias gdk_content_provider_ref_storable_formats = c_gdk_content_provider_ref_storable_formats;
alias gdk_content_provider_write_mime_type_async = c_gdk_content_provider_write_mime_type_async;
alias gdk_content_provider_write_mime_type_finish = c_gdk_content_provider_write_mime_type_finish;

// ContentSerializer
alias gdk_content_serializer_get_type = c_gdk_content_serializer_get_type;
alias gdk_content_serializer_get_cancellable = c_gdk_content_serializer_get_cancellable;
alias gdk_content_serializer_get_gtype = c_gdk_content_serializer_get_gtype;
alias gdk_content_serializer_get_mime_type = c_gdk_content_serializer_get_mime_type;
alias gdk_content_serializer_get_output_stream = c_gdk_content_serializer_get_output_stream;
alias gdk_content_serializer_get_priority = c_gdk_content_serializer_get_priority;
alias gdk_content_serializer_get_task_data = c_gdk_content_serializer_get_task_data;
alias gdk_content_serializer_get_user_data = c_gdk_content_serializer_get_user_data;
alias gdk_content_serializer_get_value = c_gdk_content_serializer_get_value;
alias gdk_content_serializer_return_error = c_gdk_content_serializer_return_error;
alias gdk_content_serializer_return_success = c_gdk_content_serializer_return_success;
alias gdk_content_serializer_set_task_data = c_gdk_content_serializer_set_task_data;

// CrossingEvent
alias gdk_crossing_event_get_type = c_gdk_crossing_event_get_type;
alias gdk_crossing_event_get_detail = c_gdk_crossing_event_get_detail;
alias gdk_crossing_event_get_focus = c_gdk_crossing_event_get_focus;
alias gdk_crossing_event_get_mode = c_gdk_crossing_event_get_mode;

// Cursor
alias gdk_cursor_get_type = c_gdk_cursor_get_type;
alias gdk_cursor_new_from_name = c_gdk_cursor_new_from_name;
alias gdk_cursor_new_from_texture = c_gdk_cursor_new_from_texture;
alias gdk_cursor_get_fallback = c_gdk_cursor_get_fallback;
alias gdk_cursor_get_hotspot_x = c_gdk_cursor_get_hotspot_x;
alias gdk_cursor_get_hotspot_y = c_gdk_cursor_get_hotspot_y;
alias gdk_cursor_get_name = c_gdk_cursor_get_name;
alias gdk_cursor_get_texture = c_gdk_cursor_get_texture;

// DNDEvent
alias gdk_dnd_event_get_type = c_gdk_dnd_event_get_type;
alias gdk_dnd_event_get_drop = c_gdk_dnd_event_get_drop;

// DeleteEvent
alias gdk_delete_event_get_type = c_gdk_delete_event_get_type;

// Device
alias gdk_device_get_type = c_gdk_device_get_type;
alias gdk_device_get_caps_lock_state = c_gdk_device_get_caps_lock_state;
alias gdk_device_get_device_tool = c_gdk_device_get_device_tool;
alias gdk_device_get_direction = c_gdk_device_get_direction;
alias gdk_device_get_display = c_gdk_device_get_display;
alias gdk_device_get_has_cursor = c_gdk_device_get_has_cursor;
alias gdk_device_get_modifier_state = c_gdk_device_get_modifier_state;
alias gdk_device_get_name = c_gdk_device_get_name;
alias gdk_device_get_num_lock_state = c_gdk_device_get_num_lock_state;
alias gdk_device_get_num_touches = c_gdk_device_get_num_touches;
alias gdk_device_get_product_id = c_gdk_device_get_product_id;
alias gdk_device_get_scroll_lock_state = c_gdk_device_get_scroll_lock_state;
alias gdk_device_get_seat = c_gdk_device_get_seat;
alias gdk_device_get_source = c_gdk_device_get_source;
alias gdk_device_get_surface_at_position = c_gdk_device_get_surface_at_position;
alias gdk_device_get_timestamp = c_gdk_device_get_timestamp;
alias gdk_device_get_vendor_id = c_gdk_device_get_vendor_id;
alias gdk_device_has_bidi_layouts = c_gdk_device_has_bidi_layouts;

// DevicePad
alias gdk_device_pad_get_type = c_gdk_device_pad_get_type;
alias gdk_device_pad_get_feature_group = c_gdk_device_pad_get_feature_group;
alias gdk_device_pad_get_group_n_modes = c_gdk_device_pad_get_group_n_modes;
alias gdk_device_pad_get_n_features = c_gdk_device_pad_get_n_features;
alias gdk_device_pad_get_n_groups = c_gdk_device_pad_get_n_groups;

// DeviceTool
alias gdk_device_tool_get_type = c_gdk_device_tool_get_type;
alias gdk_device_tool_get_axes = c_gdk_device_tool_get_axes;
alias gdk_device_tool_get_hardware_id = c_gdk_device_tool_get_hardware_id;
alias gdk_device_tool_get_serial = c_gdk_device_tool_get_serial;
alias gdk_device_tool_get_tool_type = c_gdk_device_tool_get_tool_type;

// Display
alias gdk_display_get_type = c_gdk_display_get_type;
alias gdk_display_get_default = c_gdk_display_get_default;
alias gdk_display_open = c_gdk_display_open;
alias gdk_display_beep = c_gdk_display_beep;
alias gdk_display_close = c_gdk_display_close;
alias gdk_display_create_gl_context = c_gdk_display_create_gl_context;
alias gdk_display_device_is_grabbed = c_gdk_display_device_is_grabbed;
alias gdk_display_flush = c_gdk_display_flush;
alias gdk_display_get_app_launch_context = c_gdk_display_get_app_launch_context;
alias gdk_display_get_clipboard = c_gdk_display_get_clipboard;
alias gdk_display_get_default_seat = c_gdk_display_get_default_seat;
alias gdk_display_get_dmabuf_formats = c_gdk_display_get_dmabuf_formats;
alias gdk_display_get_monitor_at_surface = c_gdk_display_get_monitor_at_surface;
alias gdk_display_get_monitors = c_gdk_display_get_monitors;
alias gdk_display_get_name = c_gdk_display_get_name;
alias gdk_display_get_primary_clipboard = c_gdk_display_get_primary_clipboard;
alias gdk_display_get_setting = c_gdk_display_get_setting;
alias gdk_display_get_startup_notification_id = c_gdk_display_get_startup_notification_id;
alias gdk_display_is_closed = c_gdk_display_is_closed;
alias gdk_display_is_composited = c_gdk_display_is_composited;
alias gdk_display_is_rgba = c_gdk_display_is_rgba;
alias gdk_display_list_seats = c_gdk_display_list_seats;
alias gdk_display_map_keycode = c_gdk_display_map_keycode;
alias gdk_display_map_keyval = c_gdk_display_map_keyval;
alias gdk_display_notify_startup_complete = c_gdk_display_notify_startup_complete;
alias gdk_display_prepare_gl = c_gdk_display_prepare_gl;
alias gdk_display_put_event = c_gdk_display_put_event;
alias gdk_display_supports_input_shapes = c_gdk_display_supports_input_shapes;
alias gdk_display_supports_shadow_width = c_gdk_display_supports_shadow_width;
alias gdk_display_sync = c_gdk_display_sync;
alias gdk_display_translate_key = c_gdk_display_translate_key;

// DisplayManager
alias gdk_display_manager_get_type = c_gdk_display_manager_get_type;
alias gdk_display_manager_get = c_gdk_display_manager_get;
alias gdk_display_manager_get_default_display = c_gdk_display_manager_get_default_display;
alias gdk_display_manager_list_displays = c_gdk_display_manager_list_displays;
alias gdk_display_manager_open_display = c_gdk_display_manager_open_display;
alias gdk_display_manager_set_default_display = c_gdk_display_manager_set_default_display;

// DmabufFormats
alias gdk_dmabuf_formats_get_type = c_gdk_dmabuf_formats_get_type;
alias gdk_dmabuf_formats_contains = c_gdk_dmabuf_formats_contains;
alias gdk_dmabuf_formats_equal = c_gdk_dmabuf_formats_equal;
alias gdk_dmabuf_formats_get_format = c_gdk_dmabuf_formats_get_format;
alias gdk_dmabuf_formats_get_n_formats = c_gdk_dmabuf_formats_get_n_formats;
alias gdk_dmabuf_formats_ref = c_gdk_dmabuf_formats_ref;
alias gdk_dmabuf_formats_unref = c_gdk_dmabuf_formats_unref;

// DmabufTexture
alias gdk_dmabuf_texture_get_type = c_gdk_dmabuf_texture_get_type;

// DmabufTextureBuilder
alias gdk_dmabuf_texture_builder_get_type = c_gdk_dmabuf_texture_builder_get_type;
alias gdk_dmabuf_texture_builder_new = c_gdk_dmabuf_texture_builder_new;
alias gdk_dmabuf_texture_builder_build = c_gdk_dmabuf_texture_builder_build;
alias gdk_dmabuf_texture_builder_get_display = c_gdk_dmabuf_texture_builder_get_display;
alias gdk_dmabuf_texture_builder_get_fd = c_gdk_dmabuf_texture_builder_get_fd;
alias gdk_dmabuf_texture_builder_get_fourcc = c_gdk_dmabuf_texture_builder_get_fourcc;
alias gdk_dmabuf_texture_builder_get_height = c_gdk_dmabuf_texture_builder_get_height;
alias gdk_dmabuf_texture_builder_get_modifier = c_gdk_dmabuf_texture_builder_get_modifier;
alias gdk_dmabuf_texture_builder_get_n_planes = c_gdk_dmabuf_texture_builder_get_n_planes;
alias gdk_dmabuf_texture_builder_get_offset = c_gdk_dmabuf_texture_builder_get_offset;
alias gdk_dmabuf_texture_builder_get_premultiplied = c_gdk_dmabuf_texture_builder_get_premultiplied;
alias gdk_dmabuf_texture_builder_get_stride = c_gdk_dmabuf_texture_builder_get_stride;
alias gdk_dmabuf_texture_builder_get_update_region = c_gdk_dmabuf_texture_builder_get_update_region;
alias gdk_dmabuf_texture_builder_get_update_texture = c_gdk_dmabuf_texture_builder_get_update_texture;
alias gdk_dmabuf_texture_builder_get_width = c_gdk_dmabuf_texture_builder_get_width;
alias gdk_dmabuf_texture_builder_set_display = c_gdk_dmabuf_texture_builder_set_display;
alias gdk_dmabuf_texture_builder_set_fd = c_gdk_dmabuf_texture_builder_set_fd;
alias gdk_dmabuf_texture_builder_set_fourcc = c_gdk_dmabuf_texture_builder_set_fourcc;
alias gdk_dmabuf_texture_builder_set_height = c_gdk_dmabuf_texture_builder_set_height;
alias gdk_dmabuf_texture_builder_set_modifier = c_gdk_dmabuf_texture_builder_set_modifier;
alias gdk_dmabuf_texture_builder_set_n_planes = c_gdk_dmabuf_texture_builder_set_n_planes;
alias gdk_dmabuf_texture_builder_set_offset = c_gdk_dmabuf_texture_builder_set_offset;
alias gdk_dmabuf_texture_builder_set_premultiplied = c_gdk_dmabuf_texture_builder_set_premultiplied;
alias gdk_dmabuf_texture_builder_set_stride = c_gdk_dmabuf_texture_builder_set_stride;
alias gdk_dmabuf_texture_builder_set_update_region = c_gdk_dmabuf_texture_builder_set_update_region;
alias gdk_dmabuf_texture_builder_set_update_texture = c_gdk_dmabuf_texture_builder_set_update_texture;
alias gdk_dmabuf_texture_builder_set_width = c_gdk_dmabuf_texture_builder_set_width;

// Drag
alias gdk_drag_get_type = c_gdk_drag_get_type;
alias gdk_drag_begin = c_gdk_drag_begin;
alias gdk_drag_drop_done = c_gdk_drag_drop_done;
alias gdk_drag_get_actions = c_gdk_drag_get_actions;
alias gdk_drag_get_content = c_gdk_drag_get_content;
alias gdk_drag_get_device = c_gdk_drag_get_device;
alias gdk_drag_get_display = c_gdk_drag_get_display;
alias gdk_drag_get_drag_surface = c_gdk_drag_get_drag_surface;
alias gdk_drag_get_formats = c_gdk_drag_get_formats;
alias gdk_drag_get_selected_action = c_gdk_drag_get_selected_action;
alias gdk_drag_get_surface = c_gdk_drag_get_surface;
alias gdk_drag_set_hotspot = c_gdk_drag_set_hotspot;

// DragSurface
alias gdk_drag_surface_get_type = c_gdk_drag_surface_get_type;
alias gdk_drag_surface_present = c_gdk_drag_surface_present;

// DragSurfaceSize
alias gdk_drag_surface_size_set_size = c_gdk_drag_surface_size_set_size;

// DrawContext
alias gdk_draw_context_get_type = c_gdk_draw_context_get_type;
alias gdk_draw_context_begin_frame = c_gdk_draw_context_begin_frame;
alias gdk_draw_context_end_frame = c_gdk_draw_context_end_frame;
alias gdk_draw_context_get_display = c_gdk_draw_context_get_display;
alias gdk_draw_context_get_frame_region = c_gdk_draw_context_get_frame_region;
alias gdk_draw_context_get_surface = c_gdk_draw_context_get_surface;
alias gdk_draw_context_is_in_frame = c_gdk_draw_context_is_in_frame;

// Drop
alias gdk_drop_get_type = c_gdk_drop_get_type;
alias gdk_drop_finish = c_gdk_drop_finish;
alias gdk_drop_get_actions = c_gdk_drop_get_actions;
alias gdk_drop_get_device = c_gdk_drop_get_device;
alias gdk_drop_get_display = c_gdk_drop_get_display;
alias gdk_drop_get_drag = c_gdk_drop_get_drag;
alias gdk_drop_get_formats = c_gdk_drop_get_formats;
alias gdk_drop_get_surface = c_gdk_drop_get_surface;
alias gdk_drop_read_async = c_gdk_drop_read_async;
alias gdk_drop_read_finish = c_gdk_drop_read_finish;
alias gdk_drop_read_value_async = c_gdk_drop_read_value_async;
alias gdk_drop_read_value_finish = c_gdk_drop_read_value_finish;
alias gdk_drop_status = c_gdk_drop_status;

// Event
alias gdk_event_get_type = c_gdk_event_get_type;
alias gdk_event_get_axes = c_gdk_event_get_axes;
alias gdk_event_get_axis = c_gdk_event_get_axis;
alias gdk_event_get_device = c_gdk_event_get_device;
alias gdk_event_get_device_tool = c_gdk_event_get_device_tool;
alias gdk_event_get_display = c_gdk_event_get_display;
alias gdk_event_get_event_sequence = c_gdk_event_get_event_sequence;
alias gdk_event_get_event_type = c_gdk_event_get_event_type;
alias gdk_event_get_history = c_gdk_event_get_history;
alias gdk_event_get_modifier_state = c_gdk_event_get_modifier_state;
alias gdk_event_get_pointer_emulated = c_gdk_event_get_pointer_emulated;
alias gdk_event_get_position = c_gdk_event_get_position;
alias gdk_event_get_seat = c_gdk_event_get_seat;
alias gdk_event_get_surface = c_gdk_event_get_surface;
alias gdk_event_get_time = c_gdk_event_get_time;
alias gdk_event_ref = c_gdk_event_ref;
alias gdk_event_triggers_context_menu = c_gdk_event_triggers_context_menu;
alias gdk_event_unref = c_gdk_event_unref;

// EventSequence
alias gdk_event_sequence_get_type = c_gdk_event_sequence_get_type;

// FileList
alias gdk_file_list_get_type = c_gdk_file_list_get_type;
alias gdk_file_list_new_from_array = c_gdk_file_list_new_from_array;
alias gdk_file_list_new_from_list = c_gdk_file_list_new_from_list;
alias gdk_file_list_get_files = c_gdk_file_list_get_files;

// FocusEvent
alias gdk_focus_event_get_type = c_gdk_focus_event_get_type;
alias gdk_focus_event_get_in = c_gdk_focus_event_get_in;

// FrameClock
alias gdk_frame_clock_get_type = c_gdk_frame_clock_get_type;
alias gdk_frame_clock_begin_updating = c_gdk_frame_clock_begin_updating;
alias gdk_frame_clock_end_updating = c_gdk_frame_clock_end_updating;
alias gdk_frame_clock_get_current_timings = c_gdk_frame_clock_get_current_timings;
alias gdk_frame_clock_get_fps = c_gdk_frame_clock_get_fps;
alias gdk_frame_clock_get_frame_counter = c_gdk_frame_clock_get_frame_counter;
alias gdk_frame_clock_get_frame_time = c_gdk_frame_clock_get_frame_time;
alias gdk_frame_clock_get_history_start = c_gdk_frame_clock_get_history_start;
alias gdk_frame_clock_get_refresh_info = c_gdk_frame_clock_get_refresh_info;
alias gdk_frame_clock_get_timings = c_gdk_frame_clock_get_timings;
alias gdk_frame_clock_request_phase = c_gdk_frame_clock_request_phase;

// FrameTimings
alias gdk_frame_timings_get_type = c_gdk_frame_timings_get_type;
alias gdk_frame_timings_get_complete = c_gdk_frame_timings_get_complete;
alias gdk_frame_timings_get_frame_counter = c_gdk_frame_timings_get_frame_counter;
alias gdk_frame_timings_get_frame_time = c_gdk_frame_timings_get_frame_time;
alias gdk_frame_timings_get_predicted_presentation_time = c_gdk_frame_timings_get_predicted_presentation_time;
alias gdk_frame_timings_get_presentation_time = c_gdk_frame_timings_get_presentation_time;
alias gdk_frame_timings_get_refresh_interval = c_gdk_frame_timings_get_refresh_interval;
alias gdk_frame_timings_ref = c_gdk_frame_timings_ref;
alias gdk_frame_timings_unref = c_gdk_frame_timings_unref;

// GLContext
alias gdk_gl_context_get_type = c_gdk_gl_context_get_type;
alias gdk_gl_context_clear_current = c_gdk_gl_context_clear_current;
alias gdk_gl_context_get_current = c_gdk_gl_context_get_current;
alias gdk_gl_context_get_allowed_apis = c_gdk_gl_context_get_allowed_apis;
alias gdk_gl_context_get_api = c_gdk_gl_context_get_api;
alias gdk_gl_context_get_debug_enabled = c_gdk_gl_context_get_debug_enabled;
alias gdk_gl_context_get_display = c_gdk_gl_context_get_display;
alias gdk_gl_context_get_forward_compatible = c_gdk_gl_context_get_forward_compatible;
alias gdk_gl_context_get_required_version = c_gdk_gl_context_get_required_version;
alias gdk_gl_context_get_shared_context = c_gdk_gl_context_get_shared_context;
alias gdk_gl_context_get_surface = c_gdk_gl_context_get_surface;
alias gdk_gl_context_get_use_es = c_gdk_gl_context_get_use_es;
alias gdk_gl_context_get_version = c_gdk_gl_context_get_version;
alias gdk_gl_context_is_legacy = c_gdk_gl_context_is_legacy;
alias gdk_gl_context_is_shared = c_gdk_gl_context_is_shared;
alias gdk_gl_context_make_current = c_gdk_gl_context_make_current;
alias gdk_gl_context_realize = c_gdk_gl_context_realize;
alias gdk_gl_context_set_allowed_apis = c_gdk_gl_context_set_allowed_apis;
alias gdk_gl_context_set_debug_enabled = c_gdk_gl_context_set_debug_enabled;
alias gdk_gl_context_set_forward_compatible = c_gdk_gl_context_set_forward_compatible;
alias gdk_gl_context_set_required_version = c_gdk_gl_context_set_required_version;
alias gdk_gl_context_set_use_es = c_gdk_gl_context_set_use_es;

// GLTexture
alias gdk_gl_texture_get_type = c_gdk_gl_texture_get_type;
alias gdk_gl_texture_new = c_gdk_gl_texture_new;
alias gdk_gl_texture_release = c_gdk_gl_texture_release;

// GLTextureBuilder
alias gdk_gl_texture_builder_get_type = c_gdk_gl_texture_builder_get_type;
alias gdk_gl_texture_builder_new = c_gdk_gl_texture_builder_new;
alias gdk_gl_texture_builder_build = c_gdk_gl_texture_builder_build;
alias gdk_gl_texture_builder_get_context = c_gdk_gl_texture_builder_get_context;
alias gdk_gl_texture_builder_get_format = c_gdk_gl_texture_builder_get_format;
alias gdk_gl_texture_builder_get_has_mipmap = c_gdk_gl_texture_builder_get_has_mipmap;
alias gdk_gl_texture_builder_get_height = c_gdk_gl_texture_builder_get_height;
alias gdk_gl_texture_builder_get_id = c_gdk_gl_texture_builder_get_id;
alias gdk_gl_texture_builder_get_sync = c_gdk_gl_texture_builder_get_sync;
alias gdk_gl_texture_builder_get_update_region = c_gdk_gl_texture_builder_get_update_region;
alias gdk_gl_texture_builder_get_update_texture = c_gdk_gl_texture_builder_get_update_texture;
alias gdk_gl_texture_builder_get_width = c_gdk_gl_texture_builder_get_width;
alias gdk_gl_texture_builder_set_context = c_gdk_gl_texture_builder_set_context;
alias gdk_gl_texture_builder_set_format = c_gdk_gl_texture_builder_set_format;
alias gdk_gl_texture_builder_set_has_mipmap = c_gdk_gl_texture_builder_set_has_mipmap;
alias gdk_gl_texture_builder_set_height = c_gdk_gl_texture_builder_set_height;
alias gdk_gl_texture_builder_set_id = c_gdk_gl_texture_builder_set_id;
alias gdk_gl_texture_builder_set_sync = c_gdk_gl_texture_builder_set_sync;
alias gdk_gl_texture_builder_set_update_region = c_gdk_gl_texture_builder_set_update_region;
alias gdk_gl_texture_builder_set_update_texture = c_gdk_gl_texture_builder_set_update_texture;
alias gdk_gl_texture_builder_set_width = c_gdk_gl_texture_builder_set_width;

// Global
alias gdk_cairo_draw_from_gl = c_gdk_cairo_draw_from_gl;
alias gdk_cairo_rectangle = c_gdk_cairo_rectangle;
alias gdk_cairo_region = c_gdk_cairo_region;
alias gdk_cairo_region_create_from_surface = c_gdk_cairo_region_create_from_surface;
alias gdk_cairo_set_source_pixbuf = c_gdk_cairo_set_source_pixbuf;
alias gdk_cairo_set_source_rgba = c_gdk_cairo_set_source_rgba;
alias gdk_content_deserialize_async = c_gdk_content_deserialize_async;
alias gdk_content_deserialize_finish = c_gdk_content_deserialize_finish;
alias gdk_content_register_deserializer = c_gdk_content_register_deserializer;
alias gdk_content_register_serializer = c_gdk_content_register_serializer;
alias gdk_content_serialize_async = c_gdk_content_serialize_async;
alias gdk_content_serialize_finish = c_gdk_content_serialize_finish;
alias gdk_drag_surface_size_get_type = c_gdk_drag_surface_size_get_type;
alias gdk_events_get_angle = c_gdk_events_get_angle;
alias gdk_events_get_center = c_gdk_events_get_center;
alias gdk_events_get_distance = c_gdk_events_get_distance;
alias gdk_intern_mime_type = c_gdk_intern_mime_type;
alias gdk_keyval_convert_case = c_gdk_keyval_convert_case;
alias gdk_keyval_from_name = c_gdk_keyval_from_name;
alias gdk_keyval_is_lower = c_gdk_keyval_is_lower;
alias gdk_keyval_is_upper = c_gdk_keyval_is_upper;
alias gdk_keyval_name = c_gdk_keyval_name;
alias gdk_keyval_to_lower = c_gdk_keyval_to_lower;
alias gdk_keyval_to_unicode = c_gdk_keyval_to_unicode;
alias gdk_keyval_to_upper = c_gdk_keyval_to_upper;
alias gdk_pango_layout_get_clip_region = c_gdk_pango_layout_get_clip_region;
alias gdk_pango_layout_line_get_clip_region = c_gdk_pango_layout_line_get_clip_region;
alias gdk_pixbuf_get_from_surface = c_gdk_pixbuf_get_from_surface;
alias gdk_pixbuf_get_from_texture = c_gdk_pixbuf_get_from_texture;
alias gdk_set_allowed_backends = c_gdk_set_allowed_backends;
alias gdk_toplevel_size_get_type = c_gdk_toplevel_size_get_type;
alias gdk_unicode_to_keyval = c_gdk_unicode_to_keyval;

// GrabBrokenEvent
alias gdk_grab_broken_event_get_type = c_gdk_grab_broken_event_get_type;
alias gdk_grab_broken_event_get_grab_surface = c_gdk_grab_broken_event_get_grab_surface;
alias gdk_grab_broken_event_get_implicit = c_gdk_grab_broken_event_get_implicit;

// KeyEvent
alias gdk_key_event_get_type = c_gdk_key_event_get_type;
alias gdk_key_event_get_consumed_modifiers = c_gdk_key_event_get_consumed_modifiers;
alias gdk_key_event_get_keycode = c_gdk_key_event_get_keycode;
alias gdk_key_event_get_keyval = c_gdk_key_event_get_keyval;
alias gdk_key_event_get_layout = c_gdk_key_event_get_layout;
alias gdk_key_event_get_level = c_gdk_key_event_get_level;
alias gdk_key_event_get_match = c_gdk_key_event_get_match;
alias gdk_key_event_is_modifier = c_gdk_key_event_is_modifier;
alias gdk_key_event_matches = c_gdk_key_event_matches;

// MemoryTexture
alias gdk_memory_texture_get_type = c_gdk_memory_texture_get_type;
alias gdk_memory_texture_new = c_gdk_memory_texture_new;

// MonitorG
alias gdk_monitor_get_type = c_gdk_monitor_get_type;
alias gdk_monitor_get_connector = c_gdk_monitor_get_connector;
alias gdk_monitor_get_description = c_gdk_monitor_get_description;
alias gdk_monitor_get_display = c_gdk_monitor_get_display;
alias gdk_monitor_get_geometry = c_gdk_monitor_get_geometry;
alias gdk_monitor_get_height_mm = c_gdk_monitor_get_height_mm;
alias gdk_monitor_get_manufacturer = c_gdk_monitor_get_manufacturer;
alias gdk_monitor_get_model = c_gdk_monitor_get_model;
alias gdk_monitor_get_refresh_rate = c_gdk_monitor_get_refresh_rate;
alias gdk_monitor_get_scale = c_gdk_monitor_get_scale;
alias gdk_monitor_get_scale_factor = c_gdk_monitor_get_scale_factor;
alias gdk_monitor_get_subpixel_layout = c_gdk_monitor_get_subpixel_layout;
alias gdk_monitor_get_width_mm = c_gdk_monitor_get_width_mm;
alias gdk_monitor_is_valid = c_gdk_monitor_is_valid;

// MotionEvent
alias gdk_motion_event_get_type = c_gdk_motion_event_get_type;

// PadEvent
alias gdk_pad_event_get_type = c_gdk_pad_event_get_type;
alias gdk_pad_event_get_axis_value = c_gdk_pad_event_get_axis_value;
alias gdk_pad_event_get_button = c_gdk_pad_event_get_button;
alias gdk_pad_event_get_group_mode = c_gdk_pad_event_get_group_mode;

// Paintable
alias gdk_paintable_get_type = c_gdk_paintable_get_type;
alias gdk_paintable_new_empty = c_gdk_paintable_new_empty;
alias gdk_paintable_compute_concrete_size = c_gdk_paintable_compute_concrete_size;
alias gdk_paintable_get_current_image = c_gdk_paintable_get_current_image;
alias gdk_paintable_get_flags = c_gdk_paintable_get_flags;
alias gdk_paintable_get_intrinsic_aspect_ratio = c_gdk_paintable_get_intrinsic_aspect_ratio;
alias gdk_paintable_get_intrinsic_height = c_gdk_paintable_get_intrinsic_height;
alias gdk_paintable_get_intrinsic_width = c_gdk_paintable_get_intrinsic_width;
alias gdk_paintable_invalidate_contents = c_gdk_paintable_invalidate_contents;
alias gdk_paintable_invalidate_size = c_gdk_paintable_invalidate_size;
alias gdk_paintable_snapshot = c_gdk_paintable_snapshot;

// Popup
alias gdk_popup_get_type = c_gdk_popup_get_type;
alias gdk_popup_get_autohide = c_gdk_popup_get_autohide;
alias gdk_popup_get_parent = c_gdk_popup_get_parent;
alias gdk_popup_get_position_x = c_gdk_popup_get_position_x;
alias gdk_popup_get_position_y = c_gdk_popup_get_position_y;
alias gdk_popup_get_rect_anchor = c_gdk_popup_get_rect_anchor;
alias gdk_popup_get_surface_anchor = c_gdk_popup_get_surface_anchor;
alias gdk_popup_present = c_gdk_popup_present;

// PopupLayout
alias gdk_popup_layout_get_type = c_gdk_popup_layout_get_type;
alias gdk_popup_layout_new = c_gdk_popup_layout_new;
alias gdk_popup_layout_copy = c_gdk_popup_layout_copy;
alias gdk_popup_layout_equal = c_gdk_popup_layout_equal;
alias gdk_popup_layout_get_anchor_hints = c_gdk_popup_layout_get_anchor_hints;
alias gdk_popup_layout_get_anchor_rect = c_gdk_popup_layout_get_anchor_rect;
alias gdk_popup_layout_get_offset = c_gdk_popup_layout_get_offset;
alias gdk_popup_layout_get_rect_anchor = c_gdk_popup_layout_get_rect_anchor;
alias gdk_popup_layout_get_shadow_width = c_gdk_popup_layout_get_shadow_width;
alias gdk_popup_layout_get_surface_anchor = c_gdk_popup_layout_get_surface_anchor;
alias gdk_popup_layout_ref = c_gdk_popup_layout_ref;
alias gdk_popup_layout_set_anchor_hints = c_gdk_popup_layout_set_anchor_hints;
alias gdk_popup_layout_set_anchor_rect = c_gdk_popup_layout_set_anchor_rect;
alias gdk_popup_layout_set_offset = c_gdk_popup_layout_set_offset;
alias gdk_popup_layout_set_rect_anchor = c_gdk_popup_layout_set_rect_anchor;
alias gdk_popup_layout_set_shadow_width = c_gdk_popup_layout_set_shadow_width;
alias gdk_popup_layout_set_surface_anchor = c_gdk_popup_layout_set_surface_anchor;
alias gdk_popup_layout_unref = c_gdk_popup_layout_unref;

// ProximityEvent
alias gdk_proximity_event_get_type = c_gdk_proximity_event_get_type;

// RGBA
alias gdk_rgba_get_type = c_gdk_rgba_get_type;
alias gdk_rgba_copy = c_gdk_rgba_copy;
alias gdk_rgba_equal = c_gdk_rgba_equal;
alias gdk_rgba_free = c_gdk_rgba_free;
alias gdk_rgba_hash = c_gdk_rgba_hash;
alias gdk_rgba_is_clear = c_gdk_rgba_is_clear;
alias gdk_rgba_is_opaque = c_gdk_rgba_is_opaque;
alias gdk_rgba_parse = c_gdk_rgba_parse;
alias gdk_rgba_to_string = c_gdk_rgba_to_string;

// Rectangle
alias gdk_rectangle_get_type = c_gdk_rectangle_get_type;
alias gdk_rectangle_contains_point = c_gdk_rectangle_contains_point;
alias gdk_rectangle_equal = c_gdk_rectangle_equal;
alias gdk_rectangle_intersect = c_gdk_rectangle_intersect;
alias gdk_rectangle_union = c_gdk_rectangle_union;

// ScrollEvent
alias gdk_scroll_event_get_type = c_gdk_scroll_event_get_type;
alias gdk_scroll_event_get_deltas = c_gdk_scroll_event_get_deltas;
alias gdk_scroll_event_get_direction = c_gdk_scroll_event_get_direction;
alias gdk_scroll_event_get_unit = c_gdk_scroll_event_get_unit;
alias gdk_scroll_event_is_stop = c_gdk_scroll_event_is_stop;

// Seat
alias gdk_seat_get_type = c_gdk_seat_get_type;
alias gdk_seat_get_capabilities = c_gdk_seat_get_capabilities;
alias gdk_seat_get_devices = c_gdk_seat_get_devices;
alias gdk_seat_get_display = c_gdk_seat_get_display;
alias gdk_seat_get_keyboard = c_gdk_seat_get_keyboard;
alias gdk_seat_get_pointer = c_gdk_seat_get_pointer;
alias gdk_seat_get_tools = c_gdk_seat_get_tools;

// Snapshot
alias gdk_snapshot_get_type = c_gdk_snapshot_get_type;

// Surface
alias gdk_surface_get_type = c_gdk_surface_get_type;
alias gdk_surface_new_popup = c_gdk_surface_new_popup;
alias gdk_surface_new_toplevel = c_gdk_surface_new_toplevel;
alias gdk_surface_beep = c_gdk_surface_beep;
alias gdk_surface_create_cairo_context = c_gdk_surface_create_cairo_context;
alias gdk_surface_create_gl_context = c_gdk_surface_create_gl_context;
alias gdk_surface_create_similar_surface = c_gdk_surface_create_similar_surface;
alias gdk_surface_create_vulkan_context = c_gdk_surface_create_vulkan_context;
alias gdk_surface_destroy = c_gdk_surface_destroy;
alias gdk_surface_get_cursor = c_gdk_surface_get_cursor;
alias gdk_surface_get_device_cursor = c_gdk_surface_get_device_cursor;
alias gdk_surface_get_device_position = c_gdk_surface_get_device_position;
alias gdk_surface_get_display = c_gdk_surface_get_display;
alias gdk_surface_get_frame_clock = c_gdk_surface_get_frame_clock;
alias gdk_surface_get_height = c_gdk_surface_get_height;
alias gdk_surface_get_mapped = c_gdk_surface_get_mapped;
alias gdk_surface_get_scale = c_gdk_surface_get_scale;
alias gdk_surface_get_scale_factor = c_gdk_surface_get_scale_factor;
alias gdk_surface_get_width = c_gdk_surface_get_width;
alias gdk_surface_hide = c_gdk_surface_hide;
alias gdk_surface_is_destroyed = c_gdk_surface_is_destroyed;
alias gdk_surface_queue_render = c_gdk_surface_queue_render;
alias gdk_surface_request_layout = c_gdk_surface_request_layout;
alias gdk_surface_set_cursor = c_gdk_surface_set_cursor;
alias gdk_surface_set_device_cursor = c_gdk_surface_set_device_cursor;
alias gdk_surface_set_input_region = c_gdk_surface_set_input_region;
alias gdk_surface_set_opaque_region = c_gdk_surface_set_opaque_region;
alias gdk_surface_translate_coordinates = c_gdk_surface_translate_coordinates;

// Texture
alias gdk_texture_get_type = c_gdk_texture_get_type;
alias gdk_texture_new_for_pixbuf = c_gdk_texture_new_for_pixbuf;
alias gdk_texture_new_from_bytes = c_gdk_texture_new_from_bytes;
alias gdk_texture_new_from_file = c_gdk_texture_new_from_file;
alias gdk_texture_new_from_filename = c_gdk_texture_new_from_filename;
alias gdk_texture_new_from_resource = c_gdk_texture_new_from_resource;
alias gdk_texture_download = c_gdk_texture_download;
alias gdk_texture_get_format = c_gdk_texture_get_format;
alias gdk_texture_get_height = c_gdk_texture_get_height;
alias gdk_texture_get_width = c_gdk_texture_get_width;
alias gdk_texture_save_to_png = c_gdk_texture_save_to_png;
alias gdk_texture_save_to_png_bytes = c_gdk_texture_save_to_png_bytes;
alias gdk_texture_save_to_tiff = c_gdk_texture_save_to_tiff;
alias gdk_texture_save_to_tiff_bytes = c_gdk_texture_save_to_tiff_bytes;

// TextureDownloader
alias gdk_texture_downloader_get_type = c_gdk_texture_downloader_get_type;
alias gdk_texture_downloader_new = c_gdk_texture_downloader_new;
alias gdk_texture_downloader_copy = c_gdk_texture_downloader_copy;
alias gdk_texture_downloader_download_bytes = c_gdk_texture_downloader_download_bytes;
alias gdk_texture_downloader_download_into = c_gdk_texture_downloader_download_into;
alias gdk_texture_downloader_free = c_gdk_texture_downloader_free;
alias gdk_texture_downloader_get_format = c_gdk_texture_downloader_get_format;
alias gdk_texture_downloader_get_texture = c_gdk_texture_downloader_get_texture;
alias gdk_texture_downloader_set_format = c_gdk_texture_downloader_set_format;
alias gdk_texture_downloader_set_texture = c_gdk_texture_downloader_set_texture;

// Toplevel
alias gdk_toplevel_get_type = c_gdk_toplevel_get_type;
alias gdk_toplevel_begin_move = c_gdk_toplevel_begin_move;
alias gdk_toplevel_begin_resize = c_gdk_toplevel_begin_resize;
alias gdk_toplevel_focus = c_gdk_toplevel_focus;
alias gdk_toplevel_get_state = c_gdk_toplevel_get_state;
alias gdk_toplevel_inhibit_system_shortcuts = c_gdk_toplevel_inhibit_system_shortcuts;
alias gdk_toplevel_lower = c_gdk_toplevel_lower;
alias gdk_toplevel_minimize = c_gdk_toplevel_minimize;
alias gdk_toplevel_present = c_gdk_toplevel_present;
alias gdk_toplevel_restore_system_shortcuts = c_gdk_toplevel_restore_system_shortcuts;
alias gdk_toplevel_set_decorated = c_gdk_toplevel_set_decorated;
alias gdk_toplevel_set_deletable = c_gdk_toplevel_set_deletable;
alias gdk_toplevel_set_icon_list = c_gdk_toplevel_set_icon_list;
alias gdk_toplevel_set_modal = c_gdk_toplevel_set_modal;
alias gdk_toplevel_set_startup_id = c_gdk_toplevel_set_startup_id;
alias gdk_toplevel_set_title = c_gdk_toplevel_set_title;
alias gdk_toplevel_set_transient_for = c_gdk_toplevel_set_transient_for;
alias gdk_toplevel_show_window_menu = c_gdk_toplevel_show_window_menu;
alias gdk_toplevel_supports_edge_constraints = c_gdk_toplevel_supports_edge_constraints;
alias gdk_toplevel_titlebar_gesture = c_gdk_toplevel_titlebar_gesture;

// ToplevelLayout
alias gdk_toplevel_layout_get_type = c_gdk_toplevel_layout_get_type;
alias gdk_toplevel_layout_new = c_gdk_toplevel_layout_new;
alias gdk_toplevel_layout_copy = c_gdk_toplevel_layout_copy;
alias gdk_toplevel_layout_equal = c_gdk_toplevel_layout_equal;
alias gdk_toplevel_layout_get_fullscreen = c_gdk_toplevel_layout_get_fullscreen;
alias gdk_toplevel_layout_get_fullscreen_monitor = c_gdk_toplevel_layout_get_fullscreen_monitor;
alias gdk_toplevel_layout_get_maximized = c_gdk_toplevel_layout_get_maximized;
alias gdk_toplevel_layout_get_resizable = c_gdk_toplevel_layout_get_resizable;
alias gdk_toplevel_layout_ref = c_gdk_toplevel_layout_ref;
alias gdk_toplevel_layout_set_fullscreen = c_gdk_toplevel_layout_set_fullscreen;
alias gdk_toplevel_layout_set_maximized = c_gdk_toplevel_layout_set_maximized;
alias gdk_toplevel_layout_set_resizable = c_gdk_toplevel_layout_set_resizable;
alias gdk_toplevel_layout_unref = c_gdk_toplevel_layout_unref;

// ToplevelSize
alias gdk_toplevel_size_get_bounds = c_gdk_toplevel_size_get_bounds;
alias gdk_toplevel_size_set_min_size = c_gdk_toplevel_size_set_min_size;
alias gdk_toplevel_size_set_shadow_width = c_gdk_toplevel_size_set_shadow_width;
alias gdk_toplevel_size_set_size = c_gdk_toplevel_size_set_size;

// TouchEvent
alias gdk_touch_event_get_type = c_gdk_touch_event_get_type;
alias gdk_touch_event_get_emulating_pointer = c_gdk_touch_event_get_emulating_pointer;

// TouchpadEvent
alias gdk_touchpad_event_get_type = c_gdk_touchpad_event_get_type;
alias gdk_touchpad_event_get_deltas = c_gdk_touchpad_event_get_deltas;
alias gdk_touchpad_event_get_gesture_phase = c_gdk_touchpad_event_get_gesture_phase;
alias gdk_touchpad_event_get_n_fingers = c_gdk_touchpad_event_get_n_fingers;
alias gdk_touchpad_event_get_pinch_angle_delta = c_gdk_touchpad_event_get_pinch_angle_delta;
alias gdk_touchpad_event_get_pinch_scale = c_gdk_touchpad_event_get_pinch_scale;

// VulkanContext
alias gdk_vulkan_context_get_type = c_gdk_vulkan_context_get_type;

shared static this()
{
  // AppLaunchContext
  link(gdk_app_launch_context_get_type, "gdk_app_launch_context_get_type");
  link(gdk_app_launch_context_get_display, "gdk_app_launch_context_get_display");
  link(gdk_app_launch_context_set_desktop, "gdk_app_launch_context_set_desktop");
  link(gdk_app_launch_context_set_icon, "gdk_app_launch_context_set_icon");
  link(gdk_app_launch_context_set_icon_name, "gdk_app_launch_context_set_icon_name");
  link(gdk_app_launch_context_set_timestamp, "gdk_app_launch_context_set_timestamp");

  // ButtonEvent
  link(gdk_button_event_get_type, "gdk_button_event_get_type");
  link(gdk_button_event_get_button, "gdk_button_event_get_button");

  // CairoContext
  link(gdk_cairo_context_get_type, "gdk_cairo_context_get_type");
  link(gdk_cairo_context_cairo_create, "gdk_cairo_context_cairo_create");

  // Clipboard
  link(gdk_clipboard_get_type, "gdk_clipboard_get_type");
  link(gdk_clipboard_get_content, "gdk_clipboard_get_content");
  link(gdk_clipboard_get_display, "gdk_clipboard_get_display");
  link(gdk_clipboard_get_formats, "gdk_clipboard_get_formats");
  link(gdk_clipboard_is_local, "gdk_clipboard_is_local");
  link(gdk_clipboard_read_async, "gdk_clipboard_read_async");
  link(gdk_clipboard_read_finish, "gdk_clipboard_read_finish");
  link(gdk_clipboard_read_text_async, "gdk_clipboard_read_text_async");
  link(gdk_clipboard_read_text_finish, "gdk_clipboard_read_text_finish");
  link(gdk_clipboard_read_texture_async, "gdk_clipboard_read_texture_async");
  link(gdk_clipboard_read_texture_finish, "gdk_clipboard_read_texture_finish");
  link(gdk_clipboard_read_value_async, "gdk_clipboard_read_value_async");
  link(gdk_clipboard_read_value_finish, "gdk_clipboard_read_value_finish");
  link(gdk_clipboard_set, "gdk_clipboard_set");
  link(gdk_clipboard_set_content, "gdk_clipboard_set_content");
  link(gdk_clipboard_set_text, "gdk_clipboard_set_text");
  link(gdk_clipboard_set_texture, "gdk_clipboard_set_texture");
  link(gdk_clipboard_set_valist, "gdk_clipboard_set_valist");
  link(gdk_clipboard_set_value, "gdk_clipboard_set_value");
  link(gdk_clipboard_store_async, "gdk_clipboard_store_async");
  link(gdk_clipboard_store_finish, "gdk_clipboard_store_finish");

  // ContentDeserializer
  link(gdk_content_deserializer_get_type, "gdk_content_deserializer_get_type");
  link(gdk_content_deserializer_get_cancellable, "gdk_content_deserializer_get_cancellable");
  link(gdk_content_deserializer_get_gtype, "gdk_content_deserializer_get_gtype");
  link(gdk_content_deserializer_get_input_stream, "gdk_content_deserializer_get_input_stream");
  link(gdk_content_deserializer_get_mime_type, "gdk_content_deserializer_get_mime_type");
  link(gdk_content_deserializer_get_priority, "gdk_content_deserializer_get_priority");
  link(gdk_content_deserializer_get_task_data, "gdk_content_deserializer_get_task_data");
  link(gdk_content_deserializer_get_user_data, "gdk_content_deserializer_get_user_data");
  link(gdk_content_deserializer_get_value, "gdk_content_deserializer_get_value");
  link(gdk_content_deserializer_return_error, "gdk_content_deserializer_return_error");
  link(gdk_content_deserializer_return_success, "gdk_content_deserializer_return_success");
  link(gdk_content_deserializer_set_task_data, "gdk_content_deserializer_set_task_data");

  // ContentFormats
  link(gdk_content_formats_get_type, "gdk_content_formats_get_type");
  link(gdk_content_formats_new, "gdk_content_formats_new");
  link(gdk_content_formats_new_for_gtype, "gdk_content_formats_new_for_gtype");
  link(gdk_content_formats_contain_gtype, "gdk_content_formats_contain_gtype");
  link(gdk_content_formats_contain_mime_type, "gdk_content_formats_contain_mime_type");
  link(gdk_content_formats_get_gtypes, "gdk_content_formats_get_gtypes");
  link(gdk_content_formats_get_mime_types, "gdk_content_formats_get_mime_types");
  link(gdk_content_formats_match, "gdk_content_formats_match");
  link(gdk_content_formats_match_gtype, "gdk_content_formats_match_gtype");
  link(gdk_content_formats_match_mime_type, "gdk_content_formats_match_mime_type");
  link(gdk_content_formats_print, "gdk_content_formats_print");
  link(gdk_content_formats_ref, "gdk_content_formats_ref");
  link(gdk_content_formats_to_string, "gdk_content_formats_to_string");
  link(gdk_content_formats_union, "gdk_content_formats_union");
  link(gdk_content_formats_union_deserialize_gtypes, "gdk_content_formats_union_deserialize_gtypes");
  link(gdk_content_formats_union_deserialize_mime_types, "gdk_content_formats_union_deserialize_mime_types");
  link(gdk_content_formats_union_serialize_gtypes, "gdk_content_formats_union_serialize_gtypes");
  link(gdk_content_formats_union_serialize_mime_types, "gdk_content_formats_union_serialize_mime_types");
  link(gdk_content_formats_unref, "gdk_content_formats_unref");
  link(gdk_content_formats_parse, "gdk_content_formats_parse");

  // ContentFormatsBuilder
  link(gdk_content_formats_builder_get_type, "gdk_content_formats_builder_get_type");
  link(gdk_content_formats_builder_new, "gdk_content_formats_builder_new");
  link(gdk_content_formats_builder_add_formats, "gdk_content_formats_builder_add_formats");
  link(gdk_content_formats_builder_add_gtype, "gdk_content_formats_builder_add_gtype");
  link(gdk_content_formats_builder_add_mime_type, "gdk_content_formats_builder_add_mime_type");
  link(gdk_content_formats_builder_free_to_formats, "gdk_content_formats_builder_free_to_formats");
  link(gdk_content_formats_builder_ref, "gdk_content_formats_builder_ref");
  link(gdk_content_formats_builder_to_formats, "gdk_content_formats_builder_to_formats");
  link(gdk_content_formats_builder_unref, "gdk_content_formats_builder_unref");

  // ContentProvider
  link(gdk_content_provider_get_type, "gdk_content_provider_get_type");
  link(gdk_content_provider_new_for_bytes, "gdk_content_provider_new_for_bytes");
  link(gdk_content_provider_new_for_value, "gdk_content_provider_new_for_value");
  link(gdk_content_provider_new_typed, "gdk_content_provider_new_typed");
  link(gdk_content_provider_new_union, "gdk_content_provider_new_union");
  link(gdk_content_provider_content_changed, "gdk_content_provider_content_changed");
  link(gdk_content_provider_get_value, "gdk_content_provider_get_value");
  link(gdk_content_provider_ref_formats, "gdk_content_provider_ref_formats");
  link(gdk_content_provider_ref_storable_formats, "gdk_content_provider_ref_storable_formats");
  link(gdk_content_provider_write_mime_type_async, "gdk_content_provider_write_mime_type_async");
  link(gdk_content_provider_write_mime_type_finish, "gdk_content_provider_write_mime_type_finish");

  // ContentSerializer
  link(gdk_content_serializer_get_type, "gdk_content_serializer_get_type");
  link(gdk_content_serializer_get_cancellable, "gdk_content_serializer_get_cancellable");
  link(gdk_content_serializer_get_gtype, "gdk_content_serializer_get_gtype");
  link(gdk_content_serializer_get_mime_type, "gdk_content_serializer_get_mime_type");
  link(gdk_content_serializer_get_output_stream, "gdk_content_serializer_get_output_stream");
  link(gdk_content_serializer_get_priority, "gdk_content_serializer_get_priority");
  link(gdk_content_serializer_get_task_data, "gdk_content_serializer_get_task_data");
  link(gdk_content_serializer_get_user_data, "gdk_content_serializer_get_user_data");
  link(gdk_content_serializer_get_value, "gdk_content_serializer_get_value");
  link(gdk_content_serializer_return_error, "gdk_content_serializer_return_error");
  link(gdk_content_serializer_return_success, "gdk_content_serializer_return_success");
  link(gdk_content_serializer_set_task_data, "gdk_content_serializer_set_task_data");

  // CrossingEvent
  link(gdk_crossing_event_get_type, "gdk_crossing_event_get_type");
  link(gdk_crossing_event_get_detail, "gdk_crossing_event_get_detail");
  link(gdk_crossing_event_get_focus, "gdk_crossing_event_get_focus");
  link(gdk_crossing_event_get_mode, "gdk_crossing_event_get_mode");

  // Cursor
  link(gdk_cursor_get_type, "gdk_cursor_get_type");
  link(gdk_cursor_new_from_name, "gdk_cursor_new_from_name");
  link(gdk_cursor_new_from_texture, "gdk_cursor_new_from_texture");
  link(gdk_cursor_get_fallback, "gdk_cursor_get_fallback");
  link(gdk_cursor_get_hotspot_x, "gdk_cursor_get_hotspot_x");
  link(gdk_cursor_get_hotspot_y, "gdk_cursor_get_hotspot_y");
  link(gdk_cursor_get_name, "gdk_cursor_get_name");
  link(gdk_cursor_get_texture, "gdk_cursor_get_texture");

  // DNDEvent
  link(gdk_dnd_event_get_type, "gdk_dnd_event_get_type");
  link(gdk_dnd_event_get_drop, "gdk_dnd_event_get_drop");

  // DeleteEvent
  link(gdk_delete_event_get_type, "gdk_delete_event_get_type");

  // Device
  link(gdk_device_get_type, "gdk_device_get_type");
  link(gdk_device_get_caps_lock_state, "gdk_device_get_caps_lock_state");
  link(gdk_device_get_device_tool, "gdk_device_get_device_tool");
  link(gdk_device_get_direction, "gdk_device_get_direction");
  link(gdk_device_get_display, "gdk_device_get_display");
  link(gdk_device_get_has_cursor, "gdk_device_get_has_cursor");
  link(gdk_device_get_modifier_state, "gdk_device_get_modifier_state");
  link(gdk_device_get_name, "gdk_device_get_name");
  link(gdk_device_get_num_lock_state, "gdk_device_get_num_lock_state");
  link(gdk_device_get_num_touches, "gdk_device_get_num_touches");
  link(gdk_device_get_product_id, "gdk_device_get_product_id");
  link(gdk_device_get_scroll_lock_state, "gdk_device_get_scroll_lock_state");
  link(gdk_device_get_seat, "gdk_device_get_seat");
  link(gdk_device_get_source, "gdk_device_get_source");
  link(gdk_device_get_surface_at_position, "gdk_device_get_surface_at_position");
  link(gdk_device_get_timestamp, "gdk_device_get_timestamp");
  link(gdk_device_get_vendor_id, "gdk_device_get_vendor_id");
  link(gdk_device_has_bidi_layouts, "gdk_device_has_bidi_layouts");

  // DevicePad
  link(gdk_device_pad_get_type, "gdk_device_pad_get_type");
  link(gdk_device_pad_get_feature_group, "gdk_device_pad_get_feature_group");
  link(gdk_device_pad_get_group_n_modes, "gdk_device_pad_get_group_n_modes");
  link(gdk_device_pad_get_n_features, "gdk_device_pad_get_n_features");
  link(gdk_device_pad_get_n_groups, "gdk_device_pad_get_n_groups");

  // DeviceTool
  link(gdk_device_tool_get_type, "gdk_device_tool_get_type");
  link(gdk_device_tool_get_axes, "gdk_device_tool_get_axes");
  link(gdk_device_tool_get_hardware_id, "gdk_device_tool_get_hardware_id");
  link(gdk_device_tool_get_serial, "gdk_device_tool_get_serial");
  link(gdk_device_tool_get_tool_type, "gdk_device_tool_get_tool_type");

  // Display
  link(gdk_display_get_type, "gdk_display_get_type");
  link(gdk_display_get_default, "gdk_display_get_default");
  link(gdk_display_open, "gdk_display_open");
  link(gdk_display_beep, "gdk_display_beep");
  link(gdk_display_close, "gdk_display_close");
  link(gdk_display_create_gl_context, "gdk_display_create_gl_context");
  link(gdk_display_device_is_grabbed, "gdk_display_device_is_grabbed");
  link(gdk_display_flush, "gdk_display_flush");
  link(gdk_display_get_app_launch_context, "gdk_display_get_app_launch_context");
  link(gdk_display_get_clipboard, "gdk_display_get_clipboard");
  link(gdk_display_get_default_seat, "gdk_display_get_default_seat");
  link(gdk_display_get_dmabuf_formats, "gdk_display_get_dmabuf_formats");
  link(gdk_display_get_monitor_at_surface, "gdk_display_get_monitor_at_surface");
  link(gdk_display_get_monitors, "gdk_display_get_monitors");
  link(gdk_display_get_name, "gdk_display_get_name");
  link(gdk_display_get_primary_clipboard, "gdk_display_get_primary_clipboard");
  link(gdk_display_get_setting, "gdk_display_get_setting");
  link(gdk_display_get_startup_notification_id, "gdk_display_get_startup_notification_id");
  link(gdk_display_is_closed, "gdk_display_is_closed");
  link(gdk_display_is_composited, "gdk_display_is_composited");
  link(gdk_display_is_rgba, "gdk_display_is_rgba");
  link(gdk_display_list_seats, "gdk_display_list_seats");
  link(gdk_display_map_keycode, "gdk_display_map_keycode");
  link(gdk_display_map_keyval, "gdk_display_map_keyval");
  link(gdk_display_notify_startup_complete, "gdk_display_notify_startup_complete");
  link(gdk_display_prepare_gl, "gdk_display_prepare_gl");
  link(gdk_display_put_event, "gdk_display_put_event");
  link(gdk_display_supports_input_shapes, "gdk_display_supports_input_shapes");
  link(gdk_display_supports_shadow_width, "gdk_display_supports_shadow_width");
  link(gdk_display_sync, "gdk_display_sync");
  link(gdk_display_translate_key, "gdk_display_translate_key");

  // DisplayManager
  link(gdk_display_manager_get_type, "gdk_display_manager_get_type");
  link(gdk_display_manager_get, "gdk_display_manager_get");
  link(gdk_display_manager_get_default_display, "gdk_display_manager_get_default_display");
  link(gdk_display_manager_list_displays, "gdk_display_manager_list_displays");
  link(gdk_display_manager_open_display, "gdk_display_manager_open_display");
  link(gdk_display_manager_set_default_display, "gdk_display_manager_set_default_display");

  // DmabufFormats
  link(gdk_dmabuf_formats_get_type, "gdk_dmabuf_formats_get_type");
  link(gdk_dmabuf_formats_contains, "gdk_dmabuf_formats_contains");
  link(gdk_dmabuf_formats_equal, "gdk_dmabuf_formats_equal");
  link(gdk_dmabuf_formats_get_format, "gdk_dmabuf_formats_get_format");
  link(gdk_dmabuf_formats_get_n_formats, "gdk_dmabuf_formats_get_n_formats");
  link(gdk_dmabuf_formats_ref, "gdk_dmabuf_formats_ref");
  link(gdk_dmabuf_formats_unref, "gdk_dmabuf_formats_unref");

  // DmabufTexture
  link(gdk_dmabuf_texture_get_type, "gdk_dmabuf_texture_get_type");

  // DmabufTextureBuilder
  link(gdk_dmabuf_texture_builder_get_type, "gdk_dmabuf_texture_builder_get_type");
  link(gdk_dmabuf_texture_builder_new, "gdk_dmabuf_texture_builder_new");
  link(gdk_dmabuf_texture_builder_build, "gdk_dmabuf_texture_builder_build");
  link(gdk_dmabuf_texture_builder_get_display, "gdk_dmabuf_texture_builder_get_display");
  link(gdk_dmabuf_texture_builder_get_fd, "gdk_dmabuf_texture_builder_get_fd");
  link(gdk_dmabuf_texture_builder_get_fourcc, "gdk_dmabuf_texture_builder_get_fourcc");
  link(gdk_dmabuf_texture_builder_get_height, "gdk_dmabuf_texture_builder_get_height");
  link(gdk_dmabuf_texture_builder_get_modifier, "gdk_dmabuf_texture_builder_get_modifier");
  link(gdk_dmabuf_texture_builder_get_n_planes, "gdk_dmabuf_texture_builder_get_n_planes");
  link(gdk_dmabuf_texture_builder_get_offset, "gdk_dmabuf_texture_builder_get_offset");
  link(gdk_dmabuf_texture_builder_get_premultiplied, "gdk_dmabuf_texture_builder_get_premultiplied");
  link(gdk_dmabuf_texture_builder_get_stride, "gdk_dmabuf_texture_builder_get_stride");
  link(gdk_dmabuf_texture_builder_get_update_region, "gdk_dmabuf_texture_builder_get_update_region");
  link(gdk_dmabuf_texture_builder_get_update_texture, "gdk_dmabuf_texture_builder_get_update_texture");
  link(gdk_dmabuf_texture_builder_get_width, "gdk_dmabuf_texture_builder_get_width");
  link(gdk_dmabuf_texture_builder_set_display, "gdk_dmabuf_texture_builder_set_display");
  link(gdk_dmabuf_texture_builder_set_fd, "gdk_dmabuf_texture_builder_set_fd");
  link(gdk_dmabuf_texture_builder_set_fourcc, "gdk_dmabuf_texture_builder_set_fourcc");
  link(gdk_dmabuf_texture_builder_set_height, "gdk_dmabuf_texture_builder_set_height");
  link(gdk_dmabuf_texture_builder_set_modifier, "gdk_dmabuf_texture_builder_set_modifier");
  link(gdk_dmabuf_texture_builder_set_n_planes, "gdk_dmabuf_texture_builder_set_n_planes");
  link(gdk_dmabuf_texture_builder_set_offset, "gdk_dmabuf_texture_builder_set_offset");
  link(gdk_dmabuf_texture_builder_set_premultiplied, "gdk_dmabuf_texture_builder_set_premultiplied");
  link(gdk_dmabuf_texture_builder_set_stride, "gdk_dmabuf_texture_builder_set_stride");
  link(gdk_dmabuf_texture_builder_set_update_region, "gdk_dmabuf_texture_builder_set_update_region");
  link(gdk_dmabuf_texture_builder_set_update_texture, "gdk_dmabuf_texture_builder_set_update_texture");
  link(gdk_dmabuf_texture_builder_set_width, "gdk_dmabuf_texture_builder_set_width");

  // Drag
  link(gdk_drag_get_type, "gdk_drag_get_type");
  link(gdk_drag_begin, "gdk_drag_begin");
  link(gdk_drag_drop_done, "gdk_drag_drop_done");
  link(gdk_drag_get_actions, "gdk_drag_get_actions");
  link(gdk_drag_get_content, "gdk_drag_get_content");
  link(gdk_drag_get_device, "gdk_drag_get_device");
  link(gdk_drag_get_display, "gdk_drag_get_display");
  link(gdk_drag_get_drag_surface, "gdk_drag_get_drag_surface");
  link(gdk_drag_get_formats, "gdk_drag_get_formats");
  link(gdk_drag_get_selected_action, "gdk_drag_get_selected_action");
  link(gdk_drag_get_surface, "gdk_drag_get_surface");
  link(gdk_drag_set_hotspot, "gdk_drag_set_hotspot");

  // DragSurface
  link(gdk_drag_surface_get_type, "gdk_drag_surface_get_type");
  link(gdk_drag_surface_present, "gdk_drag_surface_present");

  // DragSurfaceSize
  link(gdk_drag_surface_size_set_size, "gdk_drag_surface_size_set_size");

  // DrawContext
  link(gdk_draw_context_get_type, "gdk_draw_context_get_type");
  link(gdk_draw_context_begin_frame, "gdk_draw_context_begin_frame");
  link(gdk_draw_context_end_frame, "gdk_draw_context_end_frame");
  link(gdk_draw_context_get_display, "gdk_draw_context_get_display");
  link(gdk_draw_context_get_frame_region, "gdk_draw_context_get_frame_region");
  link(gdk_draw_context_get_surface, "gdk_draw_context_get_surface");
  link(gdk_draw_context_is_in_frame, "gdk_draw_context_is_in_frame");

  // Drop
  link(gdk_drop_get_type, "gdk_drop_get_type");
  link(gdk_drop_finish, "gdk_drop_finish");
  link(gdk_drop_get_actions, "gdk_drop_get_actions");
  link(gdk_drop_get_device, "gdk_drop_get_device");
  link(gdk_drop_get_display, "gdk_drop_get_display");
  link(gdk_drop_get_drag, "gdk_drop_get_drag");
  link(gdk_drop_get_formats, "gdk_drop_get_formats");
  link(gdk_drop_get_surface, "gdk_drop_get_surface");
  link(gdk_drop_read_async, "gdk_drop_read_async");
  link(gdk_drop_read_finish, "gdk_drop_read_finish");
  link(gdk_drop_read_value_async, "gdk_drop_read_value_async");
  link(gdk_drop_read_value_finish, "gdk_drop_read_value_finish");
  link(gdk_drop_status, "gdk_drop_status");

  // Event
  link(gdk_event_get_type, "gdk_event_get_type");
  link(gdk_event_get_axes, "gdk_event_get_axes");
  link(gdk_event_get_axis, "gdk_event_get_axis");
  link(gdk_event_get_device, "gdk_event_get_device");
  link(gdk_event_get_device_tool, "gdk_event_get_device_tool");
  link(gdk_event_get_display, "gdk_event_get_display");
  link(gdk_event_get_event_sequence, "gdk_event_get_event_sequence");
  link(gdk_event_get_event_type, "gdk_event_get_event_type");
  link(gdk_event_get_history, "gdk_event_get_history");
  link(gdk_event_get_modifier_state, "gdk_event_get_modifier_state");
  link(gdk_event_get_pointer_emulated, "gdk_event_get_pointer_emulated");
  link(gdk_event_get_position, "gdk_event_get_position");
  link(gdk_event_get_seat, "gdk_event_get_seat");
  link(gdk_event_get_surface, "gdk_event_get_surface");
  link(gdk_event_get_time, "gdk_event_get_time");
  link(gdk_event_ref, "gdk_event_ref");
  link(gdk_event_triggers_context_menu, "gdk_event_triggers_context_menu");
  link(gdk_event_unref, "gdk_event_unref");

  // EventSequence
  link(gdk_event_sequence_get_type, "gdk_event_sequence_get_type");

  // FileList
  link(gdk_file_list_get_type, "gdk_file_list_get_type");
  link(gdk_file_list_new_from_array, "gdk_file_list_new_from_array");
  link(gdk_file_list_new_from_list, "gdk_file_list_new_from_list");
  link(gdk_file_list_get_files, "gdk_file_list_get_files");

  // FocusEvent
  link(gdk_focus_event_get_type, "gdk_focus_event_get_type");
  link(gdk_focus_event_get_in, "gdk_focus_event_get_in");

  // FrameClock
  link(gdk_frame_clock_get_type, "gdk_frame_clock_get_type");
  link(gdk_frame_clock_begin_updating, "gdk_frame_clock_begin_updating");
  link(gdk_frame_clock_end_updating, "gdk_frame_clock_end_updating");
  link(gdk_frame_clock_get_current_timings, "gdk_frame_clock_get_current_timings");
  link(gdk_frame_clock_get_fps, "gdk_frame_clock_get_fps");
  link(gdk_frame_clock_get_frame_counter, "gdk_frame_clock_get_frame_counter");
  link(gdk_frame_clock_get_frame_time, "gdk_frame_clock_get_frame_time");
  link(gdk_frame_clock_get_history_start, "gdk_frame_clock_get_history_start");
  link(gdk_frame_clock_get_refresh_info, "gdk_frame_clock_get_refresh_info");
  link(gdk_frame_clock_get_timings, "gdk_frame_clock_get_timings");
  link(gdk_frame_clock_request_phase, "gdk_frame_clock_request_phase");

  // FrameTimings
  link(gdk_frame_timings_get_type, "gdk_frame_timings_get_type");
  link(gdk_frame_timings_get_complete, "gdk_frame_timings_get_complete");
  link(gdk_frame_timings_get_frame_counter, "gdk_frame_timings_get_frame_counter");
  link(gdk_frame_timings_get_frame_time, "gdk_frame_timings_get_frame_time");
  link(gdk_frame_timings_get_predicted_presentation_time, "gdk_frame_timings_get_predicted_presentation_time");
  link(gdk_frame_timings_get_presentation_time, "gdk_frame_timings_get_presentation_time");
  link(gdk_frame_timings_get_refresh_interval, "gdk_frame_timings_get_refresh_interval");
  link(gdk_frame_timings_ref, "gdk_frame_timings_ref");
  link(gdk_frame_timings_unref, "gdk_frame_timings_unref");

  // GLContext
  link(gdk_gl_context_get_type, "gdk_gl_context_get_type");
  link(gdk_gl_context_clear_current, "gdk_gl_context_clear_current");
  link(gdk_gl_context_get_current, "gdk_gl_context_get_current");
  link(gdk_gl_context_get_allowed_apis, "gdk_gl_context_get_allowed_apis");
  link(gdk_gl_context_get_api, "gdk_gl_context_get_api");
  link(gdk_gl_context_get_debug_enabled, "gdk_gl_context_get_debug_enabled");
  link(gdk_gl_context_get_display, "gdk_gl_context_get_display");
  link(gdk_gl_context_get_forward_compatible, "gdk_gl_context_get_forward_compatible");
  link(gdk_gl_context_get_required_version, "gdk_gl_context_get_required_version");
  link(gdk_gl_context_get_shared_context, "gdk_gl_context_get_shared_context");
  link(gdk_gl_context_get_surface, "gdk_gl_context_get_surface");
  link(gdk_gl_context_get_use_es, "gdk_gl_context_get_use_es");
  link(gdk_gl_context_get_version, "gdk_gl_context_get_version");
  link(gdk_gl_context_is_legacy, "gdk_gl_context_is_legacy");
  link(gdk_gl_context_is_shared, "gdk_gl_context_is_shared");
  link(gdk_gl_context_make_current, "gdk_gl_context_make_current");
  link(gdk_gl_context_realize, "gdk_gl_context_realize");
  link(gdk_gl_context_set_allowed_apis, "gdk_gl_context_set_allowed_apis");
  link(gdk_gl_context_set_debug_enabled, "gdk_gl_context_set_debug_enabled");
  link(gdk_gl_context_set_forward_compatible, "gdk_gl_context_set_forward_compatible");
  link(gdk_gl_context_set_required_version, "gdk_gl_context_set_required_version");
  link(gdk_gl_context_set_use_es, "gdk_gl_context_set_use_es");

  // GLTexture
  link(gdk_gl_texture_get_type, "gdk_gl_texture_get_type");
  link(gdk_gl_texture_new, "gdk_gl_texture_new");
  link(gdk_gl_texture_release, "gdk_gl_texture_release");

  // GLTextureBuilder
  link(gdk_gl_texture_builder_get_type, "gdk_gl_texture_builder_get_type");
  link(gdk_gl_texture_builder_new, "gdk_gl_texture_builder_new");
  link(gdk_gl_texture_builder_build, "gdk_gl_texture_builder_build");
  link(gdk_gl_texture_builder_get_context, "gdk_gl_texture_builder_get_context");
  link(gdk_gl_texture_builder_get_format, "gdk_gl_texture_builder_get_format");
  link(gdk_gl_texture_builder_get_has_mipmap, "gdk_gl_texture_builder_get_has_mipmap");
  link(gdk_gl_texture_builder_get_height, "gdk_gl_texture_builder_get_height");
  link(gdk_gl_texture_builder_get_id, "gdk_gl_texture_builder_get_id");
  link(gdk_gl_texture_builder_get_sync, "gdk_gl_texture_builder_get_sync");
  link(gdk_gl_texture_builder_get_update_region, "gdk_gl_texture_builder_get_update_region");
  link(gdk_gl_texture_builder_get_update_texture, "gdk_gl_texture_builder_get_update_texture");
  link(gdk_gl_texture_builder_get_width, "gdk_gl_texture_builder_get_width");
  link(gdk_gl_texture_builder_set_context, "gdk_gl_texture_builder_set_context");
  link(gdk_gl_texture_builder_set_format, "gdk_gl_texture_builder_set_format");
  link(gdk_gl_texture_builder_set_has_mipmap, "gdk_gl_texture_builder_set_has_mipmap");
  link(gdk_gl_texture_builder_set_height, "gdk_gl_texture_builder_set_height");
  link(gdk_gl_texture_builder_set_id, "gdk_gl_texture_builder_set_id");
  link(gdk_gl_texture_builder_set_sync, "gdk_gl_texture_builder_set_sync");
  link(gdk_gl_texture_builder_set_update_region, "gdk_gl_texture_builder_set_update_region");
  link(gdk_gl_texture_builder_set_update_texture, "gdk_gl_texture_builder_set_update_texture");
  link(gdk_gl_texture_builder_set_width, "gdk_gl_texture_builder_set_width");

  // Global
  link(gdk_cairo_draw_from_gl, "gdk_cairo_draw_from_gl");
  link(gdk_cairo_rectangle, "gdk_cairo_rectangle");
  link(gdk_cairo_region, "gdk_cairo_region");
  link(gdk_cairo_region_create_from_surface, "gdk_cairo_region_create_from_surface");
  link(gdk_cairo_set_source_pixbuf, "gdk_cairo_set_source_pixbuf");
  link(gdk_cairo_set_source_rgba, "gdk_cairo_set_source_rgba");
  link(gdk_content_deserialize_async, "gdk_content_deserialize_async");
  link(gdk_content_deserialize_finish, "gdk_content_deserialize_finish");
  link(gdk_content_register_deserializer, "gdk_content_register_deserializer");
  link(gdk_content_register_serializer, "gdk_content_register_serializer");
  link(gdk_content_serialize_async, "gdk_content_serialize_async");
  link(gdk_content_serialize_finish, "gdk_content_serialize_finish");
  link(gdk_drag_surface_size_get_type, "gdk_drag_surface_size_get_type");
  link(gdk_events_get_angle, "gdk_events_get_angle");
  link(gdk_events_get_center, "gdk_events_get_center");
  link(gdk_events_get_distance, "gdk_events_get_distance");
  link(gdk_intern_mime_type, "gdk_intern_mime_type");
  link(gdk_keyval_convert_case, "gdk_keyval_convert_case");
  link(gdk_keyval_from_name, "gdk_keyval_from_name");
  link(gdk_keyval_is_lower, "gdk_keyval_is_lower");
  link(gdk_keyval_is_upper, "gdk_keyval_is_upper");
  link(gdk_keyval_name, "gdk_keyval_name");
  link(gdk_keyval_to_lower, "gdk_keyval_to_lower");
  link(gdk_keyval_to_unicode, "gdk_keyval_to_unicode");
  link(gdk_keyval_to_upper, "gdk_keyval_to_upper");
  link(gdk_pango_layout_get_clip_region, "gdk_pango_layout_get_clip_region");
  link(gdk_pango_layout_line_get_clip_region, "gdk_pango_layout_line_get_clip_region");
  link(gdk_pixbuf_get_from_surface, "gdk_pixbuf_get_from_surface");
  link(gdk_pixbuf_get_from_texture, "gdk_pixbuf_get_from_texture");
  link(gdk_set_allowed_backends, "gdk_set_allowed_backends");
  link(gdk_toplevel_size_get_type, "gdk_toplevel_size_get_type");
  link(gdk_unicode_to_keyval, "gdk_unicode_to_keyval");

  // GrabBrokenEvent
  link(gdk_grab_broken_event_get_type, "gdk_grab_broken_event_get_type");
  link(gdk_grab_broken_event_get_grab_surface, "gdk_grab_broken_event_get_grab_surface");
  link(gdk_grab_broken_event_get_implicit, "gdk_grab_broken_event_get_implicit");

  // KeyEvent
  link(gdk_key_event_get_type, "gdk_key_event_get_type");
  link(gdk_key_event_get_consumed_modifiers, "gdk_key_event_get_consumed_modifiers");
  link(gdk_key_event_get_keycode, "gdk_key_event_get_keycode");
  link(gdk_key_event_get_keyval, "gdk_key_event_get_keyval");
  link(gdk_key_event_get_layout, "gdk_key_event_get_layout");
  link(gdk_key_event_get_level, "gdk_key_event_get_level");
  link(gdk_key_event_get_match, "gdk_key_event_get_match");
  link(gdk_key_event_is_modifier, "gdk_key_event_is_modifier");
  link(gdk_key_event_matches, "gdk_key_event_matches");

  // MemoryTexture
  link(gdk_memory_texture_get_type, "gdk_memory_texture_get_type");
  link(gdk_memory_texture_new, "gdk_memory_texture_new");

  // MonitorG
  link(gdk_monitor_get_type, "gdk_monitor_get_type");
  link(gdk_monitor_get_connector, "gdk_monitor_get_connector");
  link(gdk_monitor_get_description, "gdk_monitor_get_description");
  link(gdk_monitor_get_display, "gdk_monitor_get_display");
  link(gdk_monitor_get_geometry, "gdk_monitor_get_geometry");
  link(gdk_monitor_get_height_mm, "gdk_monitor_get_height_mm");
  link(gdk_monitor_get_manufacturer, "gdk_monitor_get_manufacturer");
  link(gdk_monitor_get_model, "gdk_monitor_get_model");
  link(gdk_monitor_get_refresh_rate, "gdk_monitor_get_refresh_rate");
  link(gdk_monitor_get_scale, "gdk_monitor_get_scale");
  link(gdk_monitor_get_scale_factor, "gdk_monitor_get_scale_factor");
  link(gdk_monitor_get_subpixel_layout, "gdk_monitor_get_subpixel_layout");
  link(gdk_monitor_get_width_mm, "gdk_monitor_get_width_mm");
  link(gdk_monitor_is_valid, "gdk_monitor_is_valid");

  // MotionEvent
  link(gdk_motion_event_get_type, "gdk_motion_event_get_type");

  // PadEvent
  link(gdk_pad_event_get_type, "gdk_pad_event_get_type");
  link(gdk_pad_event_get_axis_value, "gdk_pad_event_get_axis_value");
  link(gdk_pad_event_get_button, "gdk_pad_event_get_button");
  link(gdk_pad_event_get_group_mode, "gdk_pad_event_get_group_mode");

  // Paintable
  link(gdk_paintable_get_type, "gdk_paintable_get_type");
  link(gdk_paintable_new_empty, "gdk_paintable_new_empty");
  link(gdk_paintable_compute_concrete_size, "gdk_paintable_compute_concrete_size");
  link(gdk_paintable_get_current_image, "gdk_paintable_get_current_image");
  link(gdk_paintable_get_flags, "gdk_paintable_get_flags");
  link(gdk_paintable_get_intrinsic_aspect_ratio, "gdk_paintable_get_intrinsic_aspect_ratio");
  link(gdk_paintable_get_intrinsic_height, "gdk_paintable_get_intrinsic_height");
  link(gdk_paintable_get_intrinsic_width, "gdk_paintable_get_intrinsic_width");
  link(gdk_paintable_invalidate_contents, "gdk_paintable_invalidate_contents");
  link(gdk_paintable_invalidate_size, "gdk_paintable_invalidate_size");
  link(gdk_paintable_snapshot, "gdk_paintable_snapshot");

  // Popup
  link(gdk_popup_get_type, "gdk_popup_get_type");
  link(gdk_popup_get_autohide, "gdk_popup_get_autohide");
  link(gdk_popup_get_parent, "gdk_popup_get_parent");
  link(gdk_popup_get_position_x, "gdk_popup_get_position_x");
  link(gdk_popup_get_position_y, "gdk_popup_get_position_y");
  link(gdk_popup_get_rect_anchor, "gdk_popup_get_rect_anchor");
  link(gdk_popup_get_surface_anchor, "gdk_popup_get_surface_anchor");
  link(gdk_popup_present, "gdk_popup_present");

  // PopupLayout
  link(gdk_popup_layout_get_type, "gdk_popup_layout_get_type");
  link(gdk_popup_layout_new, "gdk_popup_layout_new");
  link(gdk_popup_layout_copy, "gdk_popup_layout_copy");
  link(gdk_popup_layout_equal, "gdk_popup_layout_equal");
  link(gdk_popup_layout_get_anchor_hints, "gdk_popup_layout_get_anchor_hints");
  link(gdk_popup_layout_get_anchor_rect, "gdk_popup_layout_get_anchor_rect");
  link(gdk_popup_layout_get_offset, "gdk_popup_layout_get_offset");
  link(gdk_popup_layout_get_rect_anchor, "gdk_popup_layout_get_rect_anchor");
  link(gdk_popup_layout_get_shadow_width, "gdk_popup_layout_get_shadow_width");
  link(gdk_popup_layout_get_surface_anchor, "gdk_popup_layout_get_surface_anchor");
  link(gdk_popup_layout_ref, "gdk_popup_layout_ref");
  link(gdk_popup_layout_set_anchor_hints, "gdk_popup_layout_set_anchor_hints");
  link(gdk_popup_layout_set_anchor_rect, "gdk_popup_layout_set_anchor_rect");
  link(gdk_popup_layout_set_offset, "gdk_popup_layout_set_offset");
  link(gdk_popup_layout_set_rect_anchor, "gdk_popup_layout_set_rect_anchor");
  link(gdk_popup_layout_set_shadow_width, "gdk_popup_layout_set_shadow_width");
  link(gdk_popup_layout_set_surface_anchor, "gdk_popup_layout_set_surface_anchor");
  link(gdk_popup_layout_unref, "gdk_popup_layout_unref");

  // ProximityEvent
  link(gdk_proximity_event_get_type, "gdk_proximity_event_get_type");

  // RGBA
  link(gdk_rgba_get_type, "gdk_rgba_get_type");
  link(gdk_rgba_copy, "gdk_rgba_copy");
  link(gdk_rgba_equal, "gdk_rgba_equal");
  link(gdk_rgba_free, "gdk_rgba_free");
  link(gdk_rgba_hash, "gdk_rgba_hash");
  link(gdk_rgba_is_clear, "gdk_rgba_is_clear");
  link(gdk_rgba_is_opaque, "gdk_rgba_is_opaque");
  link(gdk_rgba_parse, "gdk_rgba_parse");
  link(gdk_rgba_to_string, "gdk_rgba_to_string");

  // Rectangle
  link(gdk_rectangle_get_type, "gdk_rectangle_get_type");
  link(gdk_rectangle_contains_point, "gdk_rectangle_contains_point");
  link(gdk_rectangle_equal, "gdk_rectangle_equal");
  link(gdk_rectangle_intersect, "gdk_rectangle_intersect");
  link(gdk_rectangle_union, "gdk_rectangle_union");

  // ScrollEvent
  link(gdk_scroll_event_get_type, "gdk_scroll_event_get_type");
  link(gdk_scroll_event_get_deltas, "gdk_scroll_event_get_deltas");
  link(gdk_scroll_event_get_direction, "gdk_scroll_event_get_direction");
  link(gdk_scroll_event_get_unit, "gdk_scroll_event_get_unit");
  link(gdk_scroll_event_is_stop, "gdk_scroll_event_is_stop");

  // Seat
  link(gdk_seat_get_type, "gdk_seat_get_type");
  link(gdk_seat_get_capabilities, "gdk_seat_get_capabilities");
  link(gdk_seat_get_devices, "gdk_seat_get_devices");
  link(gdk_seat_get_display, "gdk_seat_get_display");
  link(gdk_seat_get_keyboard, "gdk_seat_get_keyboard");
  link(gdk_seat_get_pointer, "gdk_seat_get_pointer");
  link(gdk_seat_get_tools, "gdk_seat_get_tools");

  // Snapshot
  link(gdk_snapshot_get_type, "gdk_snapshot_get_type");

  // Surface
  link(gdk_surface_get_type, "gdk_surface_get_type");
  link(gdk_surface_new_popup, "gdk_surface_new_popup");
  link(gdk_surface_new_toplevel, "gdk_surface_new_toplevel");
  link(gdk_surface_beep, "gdk_surface_beep");
  link(gdk_surface_create_cairo_context, "gdk_surface_create_cairo_context");
  link(gdk_surface_create_gl_context, "gdk_surface_create_gl_context");
  link(gdk_surface_create_similar_surface, "gdk_surface_create_similar_surface");
  link(gdk_surface_create_vulkan_context, "gdk_surface_create_vulkan_context");
  link(gdk_surface_destroy, "gdk_surface_destroy");
  link(gdk_surface_get_cursor, "gdk_surface_get_cursor");
  link(gdk_surface_get_device_cursor, "gdk_surface_get_device_cursor");
  link(gdk_surface_get_device_position, "gdk_surface_get_device_position");
  link(gdk_surface_get_display, "gdk_surface_get_display");
  link(gdk_surface_get_frame_clock, "gdk_surface_get_frame_clock");
  link(gdk_surface_get_height, "gdk_surface_get_height");
  link(gdk_surface_get_mapped, "gdk_surface_get_mapped");
  link(gdk_surface_get_scale, "gdk_surface_get_scale");
  link(gdk_surface_get_scale_factor, "gdk_surface_get_scale_factor");
  link(gdk_surface_get_width, "gdk_surface_get_width");
  link(gdk_surface_hide, "gdk_surface_hide");
  link(gdk_surface_is_destroyed, "gdk_surface_is_destroyed");
  link(gdk_surface_queue_render, "gdk_surface_queue_render");
  link(gdk_surface_request_layout, "gdk_surface_request_layout");
  link(gdk_surface_set_cursor, "gdk_surface_set_cursor");
  link(gdk_surface_set_device_cursor, "gdk_surface_set_device_cursor");
  link(gdk_surface_set_input_region, "gdk_surface_set_input_region");
  link(gdk_surface_set_opaque_region, "gdk_surface_set_opaque_region");
  link(gdk_surface_translate_coordinates, "gdk_surface_translate_coordinates");

  // Texture
  link(gdk_texture_get_type, "gdk_texture_get_type");
  link(gdk_texture_new_for_pixbuf, "gdk_texture_new_for_pixbuf");
  link(gdk_texture_new_from_bytes, "gdk_texture_new_from_bytes");
  link(gdk_texture_new_from_file, "gdk_texture_new_from_file");
  link(gdk_texture_new_from_filename, "gdk_texture_new_from_filename");
  link(gdk_texture_new_from_resource, "gdk_texture_new_from_resource");
  link(gdk_texture_download, "gdk_texture_download");
  link(gdk_texture_get_format, "gdk_texture_get_format");
  link(gdk_texture_get_height, "gdk_texture_get_height");
  link(gdk_texture_get_width, "gdk_texture_get_width");
  link(gdk_texture_save_to_png, "gdk_texture_save_to_png");
  link(gdk_texture_save_to_png_bytes, "gdk_texture_save_to_png_bytes");
  link(gdk_texture_save_to_tiff, "gdk_texture_save_to_tiff");
  link(gdk_texture_save_to_tiff_bytes, "gdk_texture_save_to_tiff_bytes");

  // TextureDownloader
  link(gdk_texture_downloader_get_type, "gdk_texture_downloader_get_type");
  link(gdk_texture_downloader_new, "gdk_texture_downloader_new");
  link(gdk_texture_downloader_copy, "gdk_texture_downloader_copy");
  link(gdk_texture_downloader_download_bytes, "gdk_texture_downloader_download_bytes");
  link(gdk_texture_downloader_download_into, "gdk_texture_downloader_download_into");
  link(gdk_texture_downloader_free, "gdk_texture_downloader_free");
  link(gdk_texture_downloader_get_format, "gdk_texture_downloader_get_format");
  link(gdk_texture_downloader_get_texture, "gdk_texture_downloader_get_texture");
  link(gdk_texture_downloader_set_format, "gdk_texture_downloader_set_format");
  link(gdk_texture_downloader_set_texture, "gdk_texture_downloader_set_texture");

  // Toplevel
  link(gdk_toplevel_get_type, "gdk_toplevel_get_type");
  link(gdk_toplevel_begin_move, "gdk_toplevel_begin_move");
  link(gdk_toplevel_begin_resize, "gdk_toplevel_begin_resize");
  link(gdk_toplevel_focus, "gdk_toplevel_focus");
  link(gdk_toplevel_get_state, "gdk_toplevel_get_state");
  link(gdk_toplevel_inhibit_system_shortcuts, "gdk_toplevel_inhibit_system_shortcuts");
  link(gdk_toplevel_lower, "gdk_toplevel_lower");
  link(gdk_toplevel_minimize, "gdk_toplevel_minimize");
  link(gdk_toplevel_present, "gdk_toplevel_present");
  link(gdk_toplevel_restore_system_shortcuts, "gdk_toplevel_restore_system_shortcuts");
  link(gdk_toplevel_set_decorated, "gdk_toplevel_set_decorated");
  link(gdk_toplevel_set_deletable, "gdk_toplevel_set_deletable");
  link(gdk_toplevel_set_icon_list, "gdk_toplevel_set_icon_list");
  link(gdk_toplevel_set_modal, "gdk_toplevel_set_modal");
  link(gdk_toplevel_set_startup_id, "gdk_toplevel_set_startup_id");
  link(gdk_toplevel_set_title, "gdk_toplevel_set_title");
  link(gdk_toplevel_set_transient_for, "gdk_toplevel_set_transient_for");
  link(gdk_toplevel_show_window_menu, "gdk_toplevel_show_window_menu");
  link(gdk_toplevel_supports_edge_constraints, "gdk_toplevel_supports_edge_constraints");
  link(gdk_toplevel_titlebar_gesture, "gdk_toplevel_titlebar_gesture");

  // ToplevelLayout
  link(gdk_toplevel_layout_get_type, "gdk_toplevel_layout_get_type");
  link(gdk_toplevel_layout_new, "gdk_toplevel_layout_new");
  link(gdk_toplevel_layout_copy, "gdk_toplevel_layout_copy");
  link(gdk_toplevel_layout_equal, "gdk_toplevel_layout_equal");
  link(gdk_toplevel_layout_get_fullscreen, "gdk_toplevel_layout_get_fullscreen");
  link(gdk_toplevel_layout_get_fullscreen_monitor, "gdk_toplevel_layout_get_fullscreen_monitor");
  link(gdk_toplevel_layout_get_maximized, "gdk_toplevel_layout_get_maximized");
  link(gdk_toplevel_layout_get_resizable, "gdk_toplevel_layout_get_resizable");
  link(gdk_toplevel_layout_ref, "gdk_toplevel_layout_ref");
  link(gdk_toplevel_layout_set_fullscreen, "gdk_toplevel_layout_set_fullscreen");
  link(gdk_toplevel_layout_set_maximized, "gdk_toplevel_layout_set_maximized");
  link(gdk_toplevel_layout_set_resizable, "gdk_toplevel_layout_set_resizable");
  link(gdk_toplevel_layout_unref, "gdk_toplevel_layout_unref");

  // ToplevelSize
  link(gdk_toplevel_size_get_bounds, "gdk_toplevel_size_get_bounds");
  link(gdk_toplevel_size_set_min_size, "gdk_toplevel_size_set_min_size");
  link(gdk_toplevel_size_set_shadow_width, "gdk_toplevel_size_set_shadow_width");
  link(gdk_toplevel_size_set_size, "gdk_toplevel_size_set_size");

  // TouchEvent
  link(gdk_touch_event_get_type, "gdk_touch_event_get_type");
  link(gdk_touch_event_get_emulating_pointer, "gdk_touch_event_get_emulating_pointer");

  // TouchpadEvent
  link(gdk_touchpad_event_get_type, "gdk_touchpad_event_get_type");
  link(gdk_touchpad_event_get_deltas, "gdk_touchpad_event_get_deltas");
  link(gdk_touchpad_event_get_gesture_phase, "gdk_touchpad_event_get_gesture_phase");
  link(gdk_touchpad_event_get_n_fingers, "gdk_touchpad_event_get_n_fingers");
  link(gdk_touchpad_event_get_pinch_angle_delta, "gdk_touchpad_event_get_pinch_angle_delta");
  link(gdk_touchpad_event_get_pinch_scale, "gdk_touchpad_event_get_pinch_scale");

  // VulkanContext
  link(gdk_vulkan_context_get_type, "gdk_vulkan_context_get_type");
}

import core.sys.posix.dlfcn : dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
import std.string : fromStringz, toStringz;

private void link(T)(ref T funcPtr, string symbol)
{
  foreach (lib; LIBS)
  {
  if (auto handle = dlopen(cast(char*)toStringz(lib), RTLD_GLOBAL | RTLD_NOW))
  {
  if (auto symPtr = dlsym(handle, cast(char*)toStringz(symbol)))
  {
  funcPtr = cast(T)symPtr;
  return;
  }
  }
  else
  throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  funcPtr = cast(T)&symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
