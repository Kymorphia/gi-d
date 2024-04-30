//!repo Pango-1.0

//# Pango.Language conflicts with Cairo.Language
//!subtype Language PgLanguage

//# LayoutLine isParagraphStart conflicts with property, disable it
//!set record[LayoutLine].method[is_paragraph_start][disable] 1
