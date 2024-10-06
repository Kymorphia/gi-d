module GdkPixbuf.c.functions;

import GdkPixbuf.c.types;
public import GModule.c.types;
public import Gio.c.types;

version(Windows)
  private immutable LIBS = ["libgdk_pixbuf-2.0-0.dll;gdk_pixbuf-2.0-0.dll;gdk_pixbuf-2.dll"];
version(OSX)
  private immutable LIBS = ["libgdk_pixbuf-2.0.0.dylib"];
else
  private immutable LIBS = ["libgdk_pixbuf-2.0.so.0"];

__gshared extern(C)
{
  // Pixbuf
  GType function() c_gdk_pixbuf_get_type;
  PixbufC* function(GdkColorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height) c_gdk_pixbuf_new;
  PixbufC* function(GBytes* data, GdkColorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height, int rowstride) c_gdk_pixbuf_new_from_bytes;
  PixbufC* function(const(ubyte)* data, GdkColorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height, int rowstride, GdkPixbufDestroyNotify destroyFn, void* destroyFnData) c_gdk_pixbuf_new_from_data;
  PixbufC* function(const(char)* filename, GError** _err) c_gdk_pixbuf_new_from_file;
  PixbufC* function(const(char)* filename, int width, int height, bool preserveAspectRatio, GError** _err) c_gdk_pixbuf_new_from_file_at_scale;
  PixbufC* function(const(char)* filename, int width, int height, GError** _err) c_gdk_pixbuf_new_from_file_at_size;
  PixbufC* function(int dataLength, const(ubyte)* data, bool copyPixels, GError** _err) c_gdk_pixbuf_new_from_inline;
  PixbufC* function(const(char)* resourcePath, GError** _err) c_gdk_pixbuf_new_from_resource;
  PixbufC* function(const(char)* resourcePath, int width, int height, bool preserveAspectRatio, GError** _err) c_gdk_pixbuf_new_from_resource_at_scale;
  PixbufC* function(GInputStream* stream, GCancellable* cancellable, GError** _err) c_gdk_pixbuf_new_from_stream;
  PixbufC* function(GInputStream* stream, int width, int height, bool preserveAspectRatio, GCancellable* cancellable, GError** _err) c_gdk_pixbuf_new_from_stream_at_scale;
  PixbufC* function(GAsyncResult* asyncResult, GError** _err) c_gdk_pixbuf_new_from_stream_finish;
  PixbufC* function(const(char*)* data) c_gdk_pixbuf_new_from_xpm_data;
  int function(GdkColorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height) c_gdk_pixbuf_calculate_rowstride;
  GdkPixbufFormat* function(const(char)* filename, int* width, int* height) c_gdk_pixbuf_get_file_info;
  void function(const(char)* filename, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_pixbuf_get_file_info_async;
  GdkPixbufFormat* function(GAsyncResult* asyncResult, int* width, int* height, GError** _err) c_gdk_pixbuf_get_file_info_finish;
  GSList* function() c_gdk_pixbuf_get_formats;
  bool function(const(char)* path, GError** _err) c_gdk_pixbuf_init_modules;
  void function(GInputStream* stream, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_pixbuf_new_from_stream_async;
  void function(GInputStream* stream, int width, int height, bool preserveAspectRatio, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_pixbuf_new_from_stream_at_scale_async;
  bool function(GAsyncResult* asyncResult, GError** _err) c_gdk_pixbuf_save_to_stream_finish;
  PixbufC* function(const(PixbufC)* pixbuf, bool substituteColor, ubyte r, ubyte g, ubyte b) c_gdk_pixbuf_add_alpha;
  PixbufC* function(PixbufC* src) c_gdk_pixbuf_apply_embedded_orientation;
  void function(const(PixbufC)* src, PixbufC* dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, GdkInterpType interpType, int overallAlpha) c_gdk_pixbuf_composite;
  void function(const(PixbufC)* src, PixbufC* dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, GdkInterpType interpType, int overallAlpha, int checkX, int checkY, int checkSize, uint color1, uint color2) c_gdk_pixbuf_composite_color;
  PixbufC* function(const(PixbufC)* src, int destWidth, int destHeight, GdkInterpType interpType, int overallAlpha, int checkSize, uint color1, uint color2) c_gdk_pixbuf_composite_color_simple;
  PixbufC* function(const(PixbufC)* pixbuf) c_gdk_pixbuf_copy;
  void function(const(PixbufC)* srcPixbuf, int srcX, int srcY, int width, int height, PixbufC* destPixbuf, int destX, int destY) c_gdk_pixbuf_copy_area;
  bool function(PixbufC* srcPixbuf, PixbufC* destPixbuf) c_gdk_pixbuf_copy_options;
  void function(PixbufC* pixbuf, uint pixel) c_gdk_pixbuf_fill;
  PixbufC* function(const(PixbufC)* src, bool horizontal) c_gdk_pixbuf_flip;
  int function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_bits_per_sample;
  size_t function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_byte_length;
  GdkColorspace function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_colorspace;
  bool function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_has_alpha;
  int function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_height;
  int function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_n_channels;
  const(char)* function(PixbufC* pixbuf, const(char)* key) c_gdk_pixbuf_get_option;
  GHashTable* function(PixbufC* pixbuf) c_gdk_pixbuf_get_options;
  ubyte* function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_pixels;
  ubyte* function(const(PixbufC)* pixbuf, uint* length) c_gdk_pixbuf_get_pixels_with_length;
  int function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_rowstride;
  int function(const(PixbufC)* pixbuf) c_gdk_pixbuf_get_width;
  PixbufC* function(PixbufC* srcPixbuf, int srcX, int srcY, int width, int height) c_gdk_pixbuf_new_subpixbuf;
  GBytes* function(const(PixbufC)* pixbuf) c_gdk_pixbuf_read_pixel_bytes;
  const(ubyte)* function(const(PixbufC)* pixbuf) c_gdk_pixbuf_read_pixels;
  PixbufC* function(PixbufC* pixbuf) c_gdk_pixbuf_ref;
  bool function(PixbufC* pixbuf, const(char)* key) c_gdk_pixbuf_remove_option;
  PixbufC* function(const(PixbufC)* src, GdkPixbufRotation angle) c_gdk_pixbuf_rotate_simple;
  void function(const(PixbufC)* src, PixbufC* dest, float saturation, bool pixelate) c_gdk_pixbuf_saturate_and_pixelate;
  bool function(PixbufC* pixbuf, const(char)* filename, const(char)* type, GError** error,  ...) c_gdk_pixbuf_save;
  bool function(PixbufC* pixbuf, ubyte** buffer, size_t* bufferSize, const(char)* type, GError** error,  ...) c_gdk_pixbuf_save_to_buffer;
  bool function(PixbufC* pixbuf, ubyte** buffer, size_t* bufferSize, const(char)* type, char** optionKeys, char** optionValues, GError** _err) c_gdk_pixbuf_save_to_bufferv;
  bool function(PixbufC* pixbuf, GdkPixbufSaveFunc saveFunc, void* userData, const(char)* type, GError** error,  ...) c_gdk_pixbuf_save_to_callback;
  bool function(PixbufC* pixbuf, GdkPixbufSaveFunc saveFunc, void* userData, const(char)* type, char** optionKeys, char** optionValues, GError** _err) c_gdk_pixbuf_save_to_callbackv;
  bool function(PixbufC* pixbuf, GOutputStream* stream, const(char)* type, GCancellable* cancellable, GError** error,  ...) c_gdk_pixbuf_save_to_stream;
  void function(PixbufC* pixbuf, GOutputStream* stream, const(char)* type, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData,  ...) c_gdk_pixbuf_save_to_stream_async;
  bool function(PixbufC* pixbuf, GOutputStream* stream, const(char)* type, char** optionKeys, char** optionValues, GCancellable* cancellable, GError** _err) c_gdk_pixbuf_save_to_streamv;
  void function(PixbufC* pixbuf, GOutputStream* stream, const(char)* type, char** optionKeys, char** optionValues, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_pixbuf_save_to_streamv_async;
  bool function(PixbufC* pixbuf, const(char)* filename, const(char)* type, char** optionKeys, char** optionValues, GError** _err) c_gdk_pixbuf_savev;
  void function(const(PixbufC)* src, PixbufC* dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, GdkInterpType interpType) c_gdk_pixbuf_scale;
  PixbufC* function(const(PixbufC)* src, int destWidth, int destHeight, GdkInterpType interpType) c_gdk_pixbuf_scale_simple;
  bool function(PixbufC* pixbuf, const(char)* key, const(char)* value) c_gdk_pixbuf_set_option;
  void function(PixbufC* pixbuf) c_gdk_pixbuf_unref;

  // PixbufAnimation
  GType function() c_gdk_pixbuf_animation_get_type;
  GdkPixbufAnimation* function(const(char)* filename, GError** _err) c_gdk_pixbuf_animation_new_from_file;
  GdkPixbufAnimation* function(const(char)* resourcePath, GError** _err) c_gdk_pixbuf_animation_new_from_resource;
  GdkPixbufAnimation* function(GInputStream* stream, GCancellable* cancellable, GError** _err) c_gdk_pixbuf_animation_new_from_stream;
  GdkPixbufAnimation* function(GAsyncResult* asyncResult, GError** _err) c_gdk_pixbuf_animation_new_from_stream_finish;
  void function(GInputStream* stream, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gdk_pixbuf_animation_new_from_stream_async;
  int function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_get_height;
  GdkPixbufAnimationIter* function(GdkPixbufAnimation* animation, const(GTimeVal)* startTime) c_gdk_pixbuf_animation_get_iter;
  PixbufC* function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_get_static_image;
  int function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_get_width;
  bool function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_is_static_image;
  GdkPixbufAnimation* function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_ref;
  void function(GdkPixbufAnimation* animation) c_gdk_pixbuf_animation_unref;

  // PixbufAnimationIter
  GType function() c_gdk_pixbuf_animation_iter_get_type;
  bool function(GdkPixbufAnimationIter* iter, const(GTimeVal)* currentTime) c_gdk_pixbuf_animation_iter_advance;
  int function(GdkPixbufAnimationIter* iter) c_gdk_pixbuf_animation_iter_get_delay_time;
  PixbufC* function(GdkPixbufAnimationIter* iter) c_gdk_pixbuf_animation_iter_get_pixbuf;
  bool function(GdkPixbufAnimationIter* iter) c_gdk_pixbuf_animation_iter_on_currently_loading_frame;

  // PixbufFormat
  GType function() c_gdk_pixbuf_format_get_type;
  GdkPixbufFormat* function(const(GdkPixbufFormat)* format) c_gdk_pixbuf_format_copy;
  void function(GdkPixbufFormat* format) c_gdk_pixbuf_format_free;
  char* function(GdkPixbufFormat* format) c_gdk_pixbuf_format_get_description;
  char** function(GdkPixbufFormat* format) c_gdk_pixbuf_format_get_extensions;
  char* function(GdkPixbufFormat* format) c_gdk_pixbuf_format_get_license;
  char** function(GdkPixbufFormat* format) c_gdk_pixbuf_format_get_mime_types;
  char* function(GdkPixbufFormat* format) c_gdk_pixbuf_format_get_name;
  bool function(GdkPixbufFormat* format) c_gdk_pixbuf_format_is_disabled;
  bool function(GdkPixbufFormat* format, const(char)* optionKey) c_gdk_pixbuf_format_is_save_option_supported;
  bool function(GdkPixbufFormat* format) c_gdk_pixbuf_format_is_scalable;
  bool function(GdkPixbufFormat* format) c_gdk_pixbuf_format_is_writable;
  void function(GdkPixbufFormat* format, bool disabled) c_gdk_pixbuf_format_set_disabled;

  // PixbufLoader
  GType function() c_gdk_pixbuf_loader_get_type;
  GdkPixbufLoader* function() c_gdk_pixbuf_loader_new;
  GdkPixbufLoader* function(const(char)* mimeType, GError** _err) c_gdk_pixbuf_loader_new_with_mime_type;
  GdkPixbufLoader* function(const(char)* imageType, GError** _err) c_gdk_pixbuf_loader_new_with_type;
  bool function(GdkPixbufLoader* loader, GError** _err) c_gdk_pixbuf_loader_close;
  GdkPixbufAnimation* function(GdkPixbufLoader* loader) c_gdk_pixbuf_loader_get_animation;
  GdkPixbufFormat* function(GdkPixbufLoader* loader) c_gdk_pixbuf_loader_get_format;
  PixbufC* function(GdkPixbufLoader* loader) c_gdk_pixbuf_loader_get_pixbuf;
  void function(GdkPixbufLoader* loader, int width, int height) c_gdk_pixbuf_loader_set_size;
  bool function(GdkPixbufLoader* loader, const(ubyte)* buf, size_t count, GError** _err) c_gdk_pixbuf_loader_write;
  bool function(GdkPixbufLoader* loader, GBytes* buffer, GError** _err) c_gdk_pixbuf_loader_write_bytes;

  // PixbufNonAnim
  GType function() c_gdk_pixbuf_non_anim_get_type;
  GdkPixbufAnimation* function(PixbufC* pixbuf) c_gdk_pixbuf_non_anim_new;

  // PixbufSimpleAnim
  GType function() c_gdk_pixbuf_simple_anim_get_type;
  GdkPixbufSimpleAnim* function(int width, int height, float rate) c_gdk_pixbuf_simple_anim_new;
  void function(GdkPixbufSimpleAnim* animation, PixbufC* pixbuf) c_gdk_pixbuf_simple_anim_add_frame;
  bool function(GdkPixbufSimpleAnim* animation) c_gdk_pixbuf_simple_anim_get_loop;
  void function(GdkPixbufSimpleAnim* animation, bool loop) c_gdk_pixbuf_simple_anim_set_loop;

  // PixbufSimpleAnimIter
  GType function() c_gdk_pixbuf_simple_anim_iter_get_type;
}

// Pixbuf
alias gdk_pixbuf_get_type = c_gdk_pixbuf_get_type;
alias gdk_pixbuf_new = c_gdk_pixbuf_new;
alias gdk_pixbuf_new_from_bytes = c_gdk_pixbuf_new_from_bytes;
alias gdk_pixbuf_new_from_data = c_gdk_pixbuf_new_from_data;
alias gdk_pixbuf_new_from_file = c_gdk_pixbuf_new_from_file;
alias gdk_pixbuf_new_from_file_at_scale = c_gdk_pixbuf_new_from_file_at_scale;
alias gdk_pixbuf_new_from_file_at_size = c_gdk_pixbuf_new_from_file_at_size;
alias gdk_pixbuf_new_from_inline = c_gdk_pixbuf_new_from_inline;
alias gdk_pixbuf_new_from_resource = c_gdk_pixbuf_new_from_resource;
alias gdk_pixbuf_new_from_resource_at_scale = c_gdk_pixbuf_new_from_resource_at_scale;
alias gdk_pixbuf_new_from_stream = c_gdk_pixbuf_new_from_stream;
alias gdk_pixbuf_new_from_stream_at_scale = c_gdk_pixbuf_new_from_stream_at_scale;
alias gdk_pixbuf_new_from_stream_finish = c_gdk_pixbuf_new_from_stream_finish;
alias gdk_pixbuf_new_from_xpm_data = c_gdk_pixbuf_new_from_xpm_data;
alias gdk_pixbuf_calculate_rowstride = c_gdk_pixbuf_calculate_rowstride;
alias gdk_pixbuf_get_file_info = c_gdk_pixbuf_get_file_info;
alias gdk_pixbuf_get_file_info_async = c_gdk_pixbuf_get_file_info_async;
alias gdk_pixbuf_get_file_info_finish = c_gdk_pixbuf_get_file_info_finish;
alias gdk_pixbuf_get_formats = c_gdk_pixbuf_get_formats;
alias gdk_pixbuf_init_modules = c_gdk_pixbuf_init_modules;
alias gdk_pixbuf_new_from_stream_async = c_gdk_pixbuf_new_from_stream_async;
alias gdk_pixbuf_new_from_stream_at_scale_async = c_gdk_pixbuf_new_from_stream_at_scale_async;
alias gdk_pixbuf_save_to_stream_finish = c_gdk_pixbuf_save_to_stream_finish;
alias gdk_pixbuf_add_alpha = c_gdk_pixbuf_add_alpha;
alias gdk_pixbuf_apply_embedded_orientation = c_gdk_pixbuf_apply_embedded_orientation;
alias gdk_pixbuf_composite = c_gdk_pixbuf_composite;
alias gdk_pixbuf_composite_color = c_gdk_pixbuf_composite_color;
alias gdk_pixbuf_composite_color_simple = c_gdk_pixbuf_composite_color_simple;
alias gdk_pixbuf_copy = c_gdk_pixbuf_copy;
alias gdk_pixbuf_copy_area = c_gdk_pixbuf_copy_area;
alias gdk_pixbuf_copy_options = c_gdk_pixbuf_copy_options;
alias gdk_pixbuf_fill = c_gdk_pixbuf_fill;
alias gdk_pixbuf_flip = c_gdk_pixbuf_flip;
alias gdk_pixbuf_get_bits_per_sample = c_gdk_pixbuf_get_bits_per_sample;
alias gdk_pixbuf_get_byte_length = c_gdk_pixbuf_get_byte_length;
alias gdk_pixbuf_get_colorspace = c_gdk_pixbuf_get_colorspace;
alias gdk_pixbuf_get_has_alpha = c_gdk_pixbuf_get_has_alpha;
alias gdk_pixbuf_get_height = c_gdk_pixbuf_get_height;
alias gdk_pixbuf_get_n_channels = c_gdk_pixbuf_get_n_channels;
alias gdk_pixbuf_get_option = c_gdk_pixbuf_get_option;
alias gdk_pixbuf_get_options = c_gdk_pixbuf_get_options;
alias gdk_pixbuf_get_pixels = c_gdk_pixbuf_get_pixels;
alias gdk_pixbuf_get_pixels_with_length = c_gdk_pixbuf_get_pixels_with_length;
alias gdk_pixbuf_get_rowstride = c_gdk_pixbuf_get_rowstride;
alias gdk_pixbuf_get_width = c_gdk_pixbuf_get_width;
alias gdk_pixbuf_new_subpixbuf = c_gdk_pixbuf_new_subpixbuf;
alias gdk_pixbuf_read_pixel_bytes = c_gdk_pixbuf_read_pixel_bytes;
alias gdk_pixbuf_read_pixels = c_gdk_pixbuf_read_pixels;
alias gdk_pixbuf_ref = c_gdk_pixbuf_ref;
alias gdk_pixbuf_remove_option = c_gdk_pixbuf_remove_option;
alias gdk_pixbuf_rotate_simple = c_gdk_pixbuf_rotate_simple;
alias gdk_pixbuf_saturate_and_pixelate = c_gdk_pixbuf_saturate_and_pixelate;
alias gdk_pixbuf_save = c_gdk_pixbuf_save;
alias gdk_pixbuf_save_to_buffer = c_gdk_pixbuf_save_to_buffer;
alias gdk_pixbuf_save_to_bufferv = c_gdk_pixbuf_save_to_bufferv;
alias gdk_pixbuf_save_to_callback = c_gdk_pixbuf_save_to_callback;
alias gdk_pixbuf_save_to_callbackv = c_gdk_pixbuf_save_to_callbackv;
alias gdk_pixbuf_save_to_stream = c_gdk_pixbuf_save_to_stream;
alias gdk_pixbuf_save_to_stream_async = c_gdk_pixbuf_save_to_stream_async;
alias gdk_pixbuf_save_to_streamv = c_gdk_pixbuf_save_to_streamv;
alias gdk_pixbuf_save_to_streamv_async = c_gdk_pixbuf_save_to_streamv_async;
alias gdk_pixbuf_savev = c_gdk_pixbuf_savev;
alias gdk_pixbuf_scale = c_gdk_pixbuf_scale;
alias gdk_pixbuf_scale_simple = c_gdk_pixbuf_scale_simple;
alias gdk_pixbuf_set_option = c_gdk_pixbuf_set_option;
alias gdk_pixbuf_unref = c_gdk_pixbuf_unref;

// PixbufAnimation
alias gdk_pixbuf_animation_get_type = c_gdk_pixbuf_animation_get_type;
alias gdk_pixbuf_animation_new_from_file = c_gdk_pixbuf_animation_new_from_file;
alias gdk_pixbuf_animation_new_from_resource = c_gdk_pixbuf_animation_new_from_resource;
alias gdk_pixbuf_animation_new_from_stream = c_gdk_pixbuf_animation_new_from_stream;
alias gdk_pixbuf_animation_new_from_stream_finish = c_gdk_pixbuf_animation_new_from_stream_finish;
alias gdk_pixbuf_animation_new_from_stream_async = c_gdk_pixbuf_animation_new_from_stream_async;
alias gdk_pixbuf_animation_get_height = c_gdk_pixbuf_animation_get_height;
alias gdk_pixbuf_animation_get_iter = c_gdk_pixbuf_animation_get_iter;
alias gdk_pixbuf_animation_get_static_image = c_gdk_pixbuf_animation_get_static_image;
alias gdk_pixbuf_animation_get_width = c_gdk_pixbuf_animation_get_width;
alias gdk_pixbuf_animation_is_static_image = c_gdk_pixbuf_animation_is_static_image;
alias gdk_pixbuf_animation_ref = c_gdk_pixbuf_animation_ref;
alias gdk_pixbuf_animation_unref = c_gdk_pixbuf_animation_unref;

// PixbufAnimationIter
alias gdk_pixbuf_animation_iter_get_type = c_gdk_pixbuf_animation_iter_get_type;
alias gdk_pixbuf_animation_iter_advance = c_gdk_pixbuf_animation_iter_advance;
alias gdk_pixbuf_animation_iter_get_delay_time = c_gdk_pixbuf_animation_iter_get_delay_time;
alias gdk_pixbuf_animation_iter_get_pixbuf = c_gdk_pixbuf_animation_iter_get_pixbuf;
alias gdk_pixbuf_animation_iter_on_currently_loading_frame = c_gdk_pixbuf_animation_iter_on_currently_loading_frame;

// PixbufFormat
alias gdk_pixbuf_format_get_type = c_gdk_pixbuf_format_get_type;
alias gdk_pixbuf_format_copy = c_gdk_pixbuf_format_copy;
alias gdk_pixbuf_format_free = c_gdk_pixbuf_format_free;
alias gdk_pixbuf_format_get_description = c_gdk_pixbuf_format_get_description;
alias gdk_pixbuf_format_get_extensions = c_gdk_pixbuf_format_get_extensions;
alias gdk_pixbuf_format_get_license = c_gdk_pixbuf_format_get_license;
alias gdk_pixbuf_format_get_mime_types = c_gdk_pixbuf_format_get_mime_types;
alias gdk_pixbuf_format_get_name = c_gdk_pixbuf_format_get_name;
alias gdk_pixbuf_format_is_disabled = c_gdk_pixbuf_format_is_disabled;
alias gdk_pixbuf_format_is_save_option_supported = c_gdk_pixbuf_format_is_save_option_supported;
alias gdk_pixbuf_format_is_scalable = c_gdk_pixbuf_format_is_scalable;
alias gdk_pixbuf_format_is_writable = c_gdk_pixbuf_format_is_writable;
alias gdk_pixbuf_format_set_disabled = c_gdk_pixbuf_format_set_disabled;

// PixbufLoader
alias gdk_pixbuf_loader_get_type = c_gdk_pixbuf_loader_get_type;
alias gdk_pixbuf_loader_new = c_gdk_pixbuf_loader_new;
alias gdk_pixbuf_loader_new_with_mime_type = c_gdk_pixbuf_loader_new_with_mime_type;
alias gdk_pixbuf_loader_new_with_type = c_gdk_pixbuf_loader_new_with_type;
alias gdk_pixbuf_loader_close = c_gdk_pixbuf_loader_close;
alias gdk_pixbuf_loader_get_animation = c_gdk_pixbuf_loader_get_animation;
alias gdk_pixbuf_loader_get_format = c_gdk_pixbuf_loader_get_format;
alias gdk_pixbuf_loader_get_pixbuf = c_gdk_pixbuf_loader_get_pixbuf;
alias gdk_pixbuf_loader_set_size = c_gdk_pixbuf_loader_set_size;
alias gdk_pixbuf_loader_write = c_gdk_pixbuf_loader_write;
alias gdk_pixbuf_loader_write_bytes = c_gdk_pixbuf_loader_write_bytes;

// PixbufNonAnim
alias gdk_pixbuf_non_anim_get_type = c_gdk_pixbuf_non_anim_get_type;
alias gdk_pixbuf_non_anim_new = c_gdk_pixbuf_non_anim_new;

// PixbufSimpleAnim
alias gdk_pixbuf_simple_anim_get_type = c_gdk_pixbuf_simple_anim_get_type;
alias gdk_pixbuf_simple_anim_new = c_gdk_pixbuf_simple_anim_new;
alias gdk_pixbuf_simple_anim_add_frame = c_gdk_pixbuf_simple_anim_add_frame;
alias gdk_pixbuf_simple_anim_get_loop = c_gdk_pixbuf_simple_anim_get_loop;
alias gdk_pixbuf_simple_anim_set_loop = c_gdk_pixbuf_simple_anim_set_loop;

// PixbufSimpleAnimIter
alias gdk_pixbuf_simple_anim_iter_get_type = c_gdk_pixbuf_simple_anim_iter_get_type;

shared static this()
{
  // Pixbuf
  link(gdk_pixbuf_get_type, "gdk_pixbuf_get_type");
  link(gdk_pixbuf_new, "gdk_pixbuf_new");
  link(gdk_pixbuf_new_from_bytes, "gdk_pixbuf_new_from_bytes");
  link(gdk_pixbuf_new_from_data, "gdk_pixbuf_new_from_data");
  link(gdk_pixbuf_new_from_file, "gdk_pixbuf_new_from_file");
  link(gdk_pixbuf_new_from_file_at_scale, "gdk_pixbuf_new_from_file_at_scale");
  link(gdk_pixbuf_new_from_file_at_size, "gdk_pixbuf_new_from_file_at_size");
  link(gdk_pixbuf_new_from_inline, "gdk_pixbuf_new_from_inline");
  link(gdk_pixbuf_new_from_resource, "gdk_pixbuf_new_from_resource");
  link(gdk_pixbuf_new_from_resource_at_scale, "gdk_pixbuf_new_from_resource_at_scale");
  link(gdk_pixbuf_new_from_stream, "gdk_pixbuf_new_from_stream");
  link(gdk_pixbuf_new_from_stream_at_scale, "gdk_pixbuf_new_from_stream_at_scale");
  link(gdk_pixbuf_new_from_stream_finish, "gdk_pixbuf_new_from_stream_finish");
  link(gdk_pixbuf_new_from_xpm_data, "gdk_pixbuf_new_from_xpm_data");
  link(gdk_pixbuf_calculate_rowstride, "gdk_pixbuf_calculate_rowstride");
  link(gdk_pixbuf_get_file_info, "gdk_pixbuf_get_file_info");
  link(gdk_pixbuf_get_file_info_async, "gdk_pixbuf_get_file_info_async");
  link(gdk_pixbuf_get_file_info_finish, "gdk_pixbuf_get_file_info_finish");
  link(gdk_pixbuf_get_formats, "gdk_pixbuf_get_formats");
  link(gdk_pixbuf_init_modules, "gdk_pixbuf_init_modules");
  link(gdk_pixbuf_new_from_stream_async, "gdk_pixbuf_new_from_stream_async");
  link(gdk_pixbuf_new_from_stream_at_scale_async, "gdk_pixbuf_new_from_stream_at_scale_async");
  link(gdk_pixbuf_save_to_stream_finish, "gdk_pixbuf_save_to_stream_finish");
  link(gdk_pixbuf_add_alpha, "gdk_pixbuf_add_alpha");
  link(gdk_pixbuf_apply_embedded_orientation, "gdk_pixbuf_apply_embedded_orientation");
  link(gdk_pixbuf_composite, "gdk_pixbuf_composite");
  link(gdk_pixbuf_composite_color, "gdk_pixbuf_composite_color");
  link(gdk_pixbuf_composite_color_simple, "gdk_pixbuf_composite_color_simple");
  link(gdk_pixbuf_copy, "gdk_pixbuf_copy");
  link(gdk_pixbuf_copy_area, "gdk_pixbuf_copy_area");
  link(gdk_pixbuf_copy_options, "gdk_pixbuf_copy_options");
  link(gdk_pixbuf_fill, "gdk_pixbuf_fill");
  link(gdk_pixbuf_flip, "gdk_pixbuf_flip");
  link(gdk_pixbuf_get_bits_per_sample, "gdk_pixbuf_get_bits_per_sample");
  link(gdk_pixbuf_get_byte_length, "gdk_pixbuf_get_byte_length");
  link(gdk_pixbuf_get_colorspace, "gdk_pixbuf_get_colorspace");
  link(gdk_pixbuf_get_has_alpha, "gdk_pixbuf_get_has_alpha");
  link(gdk_pixbuf_get_height, "gdk_pixbuf_get_height");
  link(gdk_pixbuf_get_n_channels, "gdk_pixbuf_get_n_channels");
  link(gdk_pixbuf_get_option, "gdk_pixbuf_get_option");
  link(gdk_pixbuf_get_options, "gdk_pixbuf_get_options");
  link(gdk_pixbuf_get_pixels, "gdk_pixbuf_get_pixels");
  link(gdk_pixbuf_get_pixels_with_length, "gdk_pixbuf_get_pixels_with_length");
  link(gdk_pixbuf_get_rowstride, "gdk_pixbuf_get_rowstride");
  link(gdk_pixbuf_get_width, "gdk_pixbuf_get_width");
  link(gdk_pixbuf_new_subpixbuf, "gdk_pixbuf_new_subpixbuf");
  link(gdk_pixbuf_read_pixel_bytes, "gdk_pixbuf_read_pixel_bytes");
  link(gdk_pixbuf_read_pixels, "gdk_pixbuf_read_pixels");
  link(gdk_pixbuf_ref, "gdk_pixbuf_ref");
  link(gdk_pixbuf_remove_option, "gdk_pixbuf_remove_option");
  link(gdk_pixbuf_rotate_simple, "gdk_pixbuf_rotate_simple");
  link(gdk_pixbuf_saturate_and_pixelate, "gdk_pixbuf_saturate_and_pixelate");
  link(gdk_pixbuf_save, "gdk_pixbuf_save");
  link(gdk_pixbuf_save_to_buffer, "gdk_pixbuf_save_to_buffer");
  link(gdk_pixbuf_save_to_bufferv, "gdk_pixbuf_save_to_bufferv");
  link(gdk_pixbuf_save_to_callback, "gdk_pixbuf_save_to_callback");
  link(gdk_pixbuf_save_to_callbackv, "gdk_pixbuf_save_to_callbackv");
  link(gdk_pixbuf_save_to_stream, "gdk_pixbuf_save_to_stream");
  link(gdk_pixbuf_save_to_stream_async, "gdk_pixbuf_save_to_stream_async");
  link(gdk_pixbuf_save_to_streamv, "gdk_pixbuf_save_to_streamv");
  link(gdk_pixbuf_save_to_streamv_async, "gdk_pixbuf_save_to_streamv_async");
  link(gdk_pixbuf_savev, "gdk_pixbuf_savev");
  link(gdk_pixbuf_scale, "gdk_pixbuf_scale");
  link(gdk_pixbuf_scale_simple, "gdk_pixbuf_scale_simple");
  link(gdk_pixbuf_set_option, "gdk_pixbuf_set_option");
  link(gdk_pixbuf_unref, "gdk_pixbuf_unref");

  // PixbufAnimation
  link(gdk_pixbuf_animation_get_type, "gdk_pixbuf_animation_get_type");
  link(gdk_pixbuf_animation_new_from_file, "gdk_pixbuf_animation_new_from_file");
  link(gdk_pixbuf_animation_new_from_resource, "gdk_pixbuf_animation_new_from_resource");
  link(gdk_pixbuf_animation_new_from_stream, "gdk_pixbuf_animation_new_from_stream");
  link(gdk_pixbuf_animation_new_from_stream_finish, "gdk_pixbuf_animation_new_from_stream_finish");
  link(gdk_pixbuf_animation_new_from_stream_async, "gdk_pixbuf_animation_new_from_stream_async");
  link(gdk_pixbuf_animation_get_height, "gdk_pixbuf_animation_get_height");
  link(gdk_pixbuf_animation_get_iter, "gdk_pixbuf_animation_get_iter");
  link(gdk_pixbuf_animation_get_static_image, "gdk_pixbuf_animation_get_static_image");
  link(gdk_pixbuf_animation_get_width, "gdk_pixbuf_animation_get_width");
  link(gdk_pixbuf_animation_is_static_image, "gdk_pixbuf_animation_is_static_image");
  link(gdk_pixbuf_animation_ref, "gdk_pixbuf_animation_ref");
  link(gdk_pixbuf_animation_unref, "gdk_pixbuf_animation_unref");

  // PixbufAnimationIter
  link(gdk_pixbuf_animation_iter_get_type, "gdk_pixbuf_animation_iter_get_type");
  link(gdk_pixbuf_animation_iter_advance, "gdk_pixbuf_animation_iter_advance");
  link(gdk_pixbuf_animation_iter_get_delay_time, "gdk_pixbuf_animation_iter_get_delay_time");
  link(gdk_pixbuf_animation_iter_get_pixbuf, "gdk_pixbuf_animation_iter_get_pixbuf");
  link(gdk_pixbuf_animation_iter_on_currently_loading_frame, "gdk_pixbuf_animation_iter_on_currently_loading_frame");

  // PixbufFormat
  link(gdk_pixbuf_format_get_type, "gdk_pixbuf_format_get_type");
  link(gdk_pixbuf_format_copy, "gdk_pixbuf_format_copy");
  link(gdk_pixbuf_format_free, "gdk_pixbuf_format_free");
  link(gdk_pixbuf_format_get_description, "gdk_pixbuf_format_get_description");
  link(gdk_pixbuf_format_get_extensions, "gdk_pixbuf_format_get_extensions");
  link(gdk_pixbuf_format_get_license, "gdk_pixbuf_format_get_license");
  link(gdk_pixbuf_format_get_mime_types, "gdk_pixbuf_format_get_mime_types");
  link(gdk_pixbuf_format_get_name, "gdk_pixbuf_format_get_name");
  link(gdk_pixbuf_format_is_disabled, "gdk_pixbuf_format_is_disabled");
  link(gdk_pixbuf_format_is_save_option_supported, "gdk_pixbuf_format_is_save_option_supported");
  link(gdk_pixbuf_format_is_scalable, "gdk_pixbuf_format_is_scalable");
  link(gdk_pixbuf_format_is_writable, "gdk_pixbuf_format_is_writable");
  link(gdk_pixbuf_format_set_disabled, "gdk_pixbuf_format_set_disabled");

  // PixbufLoader
  link(gdk_pixbuf_loader_get_type, "gdk_pixbuf_loader_get_type");
  link(gdk_pixbuf_loader_new, "gdk_pixbuf_loader_new");
  link(gdk_pixbuf_loader_new_with_mime_type, "gdk_pixbuf_loader_new_with_mime_type");
  link(gdk_pixbuf_loader_new_with_type, "gdk_pixbuf_loader_new_with_type");
  link(gdk_pixbuf_loader_close, "gdk_pixbuf_loader_close");
  link(gdk_pixbuf_loader_get_animation, "gdk_pixbuf_loader_get_animation");
  link(gdk_pixbuf_loader_get_format, "gdk_pixbuf_loader_get_format");
  link(gdk_pixbuf_loader_get_pixbuf, "gdk_pixbuf_loader_get_pixbuf");
  link(gdk_pixbuf_loader_set_size, "gdk_pixbuf_loader_set_size");
  link(gdk_pixbuf_loader_write, "gdk_pixbuf_loader_write");
  link(gdk_pixbuf_loader_write_bytes, "gdk_pixbuf_loader_write_bytes");

  // PixbufNonAnim
  link(gdk_pixbuf_non_anim_get_type, "gdk_pixbuf_non_anim_get_type");
  link(gdk_pixbuf_non_anim_new, "gdk_pixbuf_non_anim_new");

  // PixbufSimpleAnim
  link(gdk_pixbuf_simple_anim_get_type, "gdk_pixbuf_simple_anim_get_type");
  link(gdk_pixbuf_simple_anim_new, "gdk_pixbuf_simple_anim_new");
  link(gdk_pixbuf_simple_anim_add_frame, "gdk_pixbuf_simple_anim_add_frame");
  link(gdk_pixbuf_simple_anim_get_loop, "gdk_pixbuf_simple_anim_get_loop");
  link(gdk_pixbuf_simple_anim_set_loop, "gdk_pixbuf_simple_anim_set_loop");

  // PixbufSimpleAnimIter
  link(gdk_pixbuf_simple_anim_iter_get_type, "gdk_pixbuf_simple_anim_iter_get_type");
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
