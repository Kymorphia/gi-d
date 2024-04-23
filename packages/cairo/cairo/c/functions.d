module cairo.c.functions;

import cairo.c.types;
public import GObject.c.types;

version(Windows)
  private immutable LIBS = ["libcairo-gobject-2.dll;cairo-gobject-2.dll;cairo-gobject.dll"];
version(OSX)
  private immutable LIBS = ["libcairo-gobject.2.dylib"];
else
  private immutable LIBS = ["libcairo-gobject.so.2"];

__gshared extern(C)
{
  // Context
  GType function() c_cairo_gobject_context_get_type;

  // Device
  GType function() c_cairo_gobject_device_get_type;

  // FontFace
  GType function() c_cairo_gobject_font_face_get_type;

  // FontOptions
  GType function() c_cairo_gobject_font_options_get_type;

  // Global
  void function() c_cairo_image_surface_create;

  // Pattern
  GType function() c_cairo_gobject_pattern_get_type;

  // Rectangle
  GType function() c_cairo_gobject_rectangle_get_type;

  // RectangleInt
  GType function() c_cairo_gobject_rectangle_int_get_type;

  // Region
  GType function() c_cairo_gobject_region_get_type;

  // ScaledFont
  GType function() c_cairo_gobject_scaled_font_get_type;

  // Surface
  GType function() c_cairo_gobject_surface_get_type;
}

// Context
alias cairo_gobject_context_get_type = c_cairo_gobject_context_get_type;

// Device
alias cairo_gobject_device_get_type = c_cairo_gobject_device_get_type;

// FontFace
alias cairo_gobject_font_face_get_type = c_cairo_gobject_font_face_get_type;

// FontOptions
alias cairo_gobject_font_options_get_type = c_cairo_gobject_font_options_get_type;

// Global
alias cairo_image_surface_create = c_cairo_image_surface_create;

// Pattern
alias cairo_gobject_pattern_get_type = c_cairo_gobject_pattern_get_type;

// Rectangle
alias cairo_gobject_rectangle_get_type = c_cairo_gobject_rectangle_get_type;

// RectangleInt
alias cairo_gobject_rectangle_int_get_type = c_cairo_gobject_rectangle_int_get_type;

// Region
alias cairo_gobject_region_get_type = c_cairo_gobject_region_get_type;

// ScaledFont
alias cairo_gobject_scaled_font_get_type = c_cairo_gobject_scaled_font_get_type;

// Surface
alias cairo_gobject_surface_get_type = c_cairo_gobject_surface_get_type;

shared static this()
{
  // Context
  link(cairo_gobject_context_get_type, "cairo_gobject_context_get_type");

  // Device
  link(cairo_gobject_device_get_type, "cairo_gobject_device_get_type");

  // FontFace
  link(cairo_gobject_font_face_get_type, "cairo_gobject_font_face_get_type");

  // FontOptions
  link(cairo_gobject_font_options_get_type, "cairo_gobject_font_options_get_type");

  // Global
  link(cairo_image_surface_create, "cairo_image_surface_create");

  // Pattern
  link(cairo_gobject_pattern_get_type, "cairo_gobject_pattern_get_type");

  // Rectangle
  link(cairo_gobject_rectangle_get_type, "cairo_gobject_rectangle_get_type");

  // RectangleInt
  link(cairo_gobject_rectangle_int_get_type, "cairo_gobject_rectangle_int_get_type");

  // Region
  link(cairo_gobject_region_get_type, "cairo_gobject_region_get_type");

  // ScaledFont
  link(cairo_gobject_scaled_font_get_type, "cairo_gobject_scaled_font_get_type");

  // Surface
  link(cairo_gobject_surface_get_type, "cairo_gobject_surface_get_type");
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
