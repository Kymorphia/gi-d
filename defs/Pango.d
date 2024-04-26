//!repo Pango-1.0

//# Context conflicts with cairo.Context, rename it PgContext
//!subtype Context PgContext

//# LayoutLine isParagraphStart conflicts with property, disable it
//!set record[LayoutLine].method[is_paragraph_start][disable] 1
