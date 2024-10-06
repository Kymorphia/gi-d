module PangoCairo.c.types;

public import GObject.c.types;
public import Pango.c.types;
public import cairo.c.types;

/**
 * `PangoCairoFont` is an interface exported by fonts for
 * use with Cairo.
 * The actual type of the font will depend on the particular
 * font technology Cairo was compiled to use.
 */
struct PangoCairoFont;

/**
 * `PangoCairoFontMap` is an interface exported by font maps for
 * use with Cairo.
 * The actual type of the font map will depend on the particular
 * font technology Cairo was compiled to use.
 */
struct PangoCairoFontMap;

alias extern(C) void function(cairo_t* cr, PangoAttrShape* attr, bool doPath, void* data) PangoCairoShapeRendererFunc;

