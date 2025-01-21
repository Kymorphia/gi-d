//!repo Pango-1.0

//# Pango.Language conflicts with Cairo.Language
//!subtype Language PgLanguage

//# LayoutLine isParagraphStart conflicts with property, disable it
//!set record[LayoutLine].method[is_paragraph_start][disable] 1

//# Change Layout.setText() text parameter to an array of chars with a length to remove length param and optimize
//!set class[Layout].method[set_text].parameters.parameter[text].type '<array length="1" c:type="gchar*"><type name="char" c:type="char"/></array>'

//# Set arrays to be zero-terminated=1
//!set class[Font].method[get_languages].return-value.array[][zero-terminated] 1
//!set function[split_file_list].return-value.array[][zero-terminated] 1
//!set record[Language].function[get_preferred].return-value.array[][zero-terminated] 1
