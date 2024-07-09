//!repo Pango-1.0

//# Pango.Language conflicts with Cairo.Language
//!subtype Language PgLanguage

//# LayoutLine isParagraphStart conflicts with property, disable it
//!set record[LayoutLine].method[is_paragraph_start][disable] 1

//# Change Layout.setText() text parameter to an array of chars with a length to remove length param and optimize
//!set class[Layout].method[set_text].parameters.parameter[text].type '<array length="1" c:type="gchar*"><type name="char" c:type="char"/></array>'
