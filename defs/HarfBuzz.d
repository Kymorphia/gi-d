//!repo HarfBuzz-0.0

//!subtype face_t HBFace

//# Disable problematic callbacks
//!set callback[font_get_glyph_advances_func_t][introspectable] 0
//!set callback[font_get_nominal_glyphs_func_t][introspectable] 0 

//# Set arrays to be zero-terminated=1
//!set function[buffer_serialize_list_formats].return-value.array[][zero-terminated] 1
//!set function[face_builder_sort_tables].parameters.parameter[tags].array[][zero-terminated] 1
//!set function[ot_layout_collect_features].parameters.parameter[scripts].array[][zero-terminated] 1
//!set function[ot_layout_collect_features].parameters.parameter[languages].array[][zero-terminated] 1
//!set function[ot_layout_collect_features].parameters.parameter[features].array[][zero-terminated] 1
//!set function[ot_layout_collect_lookups].parameters.parameter[scripts].array[][zero-terminated] 1
//!set function[ot_layout_collect_lookups].parameters.parameter[languages].array[][zero-terminated] 1
//!set function[ot_layout_collect_lookups].parameters.parameter[features].array[][zero-terminated] 1
//!set function[shape_full].parameters.parameter[shaper_list].array[][zero-terminated] 1
//!set function[shape_justify].parameters.parameter[shaper_list].array[][zero-terminated] 1
//!set function[shape_list_shapers].return-value.array[][zero-terminated] 1
//!set function[shape_plan_create].parameters.parameter[shaper_list].array[][zero-terminated] 1
//!set function[shape_plan_create2].parameters.parameter[shaper_list].array[][zero-terminated] 1
//!set function[shape_plan_create_cached].parameters.parameter[shaper_list].array[][zero-terminated] 1
//!set function[shape_plan_create_cached2].parameters.parameter[shaper_list].array[][zero-terminated] 1

//# Set array length parameters to be inout
//!set function[aat_layout_feature_type_get_selector_infos].parameters.parameter[selector_count][direction] inout
//!set function[aat_layout_get_feature_types].parameters.parameter[feature_count][direction] inout
//!set function[color_line_get_color_stops].parameters.parameter[count][direction] inout
//!set callback[color_line_get_color_stops_func_t].parameters.parameter[count][direction] inout
//!set function[face_get_table_tags].parameters.parameter[table_count][direction] inout
//!set function[ot_color_glyph_get_layers].parameters.parameter[layer_count][direction] inout
//!set function[ot_color_palette_get_colors].parameters.parameter[color_count][direction] inout
//!set function[ot_layout_feature_get_characters].parameters.parameter[char_count][direction] inout
//!set function[ot_layout_feature_get_lookups].parameters.parameter[lookup_count][direction] inout
//!set function[ot_layout_feature_with_variations_get_lookups].parameters.parameter[lookup_count][direction] inout
//!set function[ot_layout_get_attach_points].parameters.parameter[point_count][direction] inout
//!set function[ot_layout_get_ligature_carets].parameters.parameter[caret_count][direction] inout
//!set function[ot_layout_language_get_feature_indexes].parameters.parameter[feature_count][direction] inout
//!set function[ot_layout_language_get_feature_tags].parameters.parameter[feature_count][direction] inout
//!set function[ot_layout_lookup_get_glyph_alternates].parameters.parameter[alternate_count][direction] inout
//!set function[ot_layout_script_get_language_tags].parameters.parameter[language_count][direction] inout
//!set function[ot_layout_table_get_feature_tags].parameters.parameter[feature_count][direction] inout
//!set function[ot_layout_table_get_script_tags].parameters.parameter[script_count][direction] inout
//!set function[ot_math_get_glyph_assembly].parameters.parameter[parts_count][direction] inout
//!set function[ot_math_get_glyph_kernings].parameters.parameter[entries_count][direction] inout
//!set function[ot_math_get_glyph_variants].parameters.parameter[variants_count][direction] inout
//!set function[ot_var_get_axes].parameters.parameter[axes_count][direction] inout
//!set function[ot_var_get_axis_infos].parameters.parameter[axes_count][direction] inout
//!set function[ot_var_named_instance_get_design_coords].parameters.parameter[coords_length][direction] inout

//# Set array parameters to be caller-allocates
//!set callback[font_get_glyph_name_func_t].parameters.parameter[name][caller-allocates] 1
//!set callback[font_get_glyph_name_func_t].parameters.parameter[size][direction] in
//!set function[face_get_table_tags].parameters.parameter[table_tags][caller-allocates] 1
//!set function[ot_color_palette_get_colors].parameters.parameter[colors][caller-allocates] 1
//!set function[ot_layout_feature_get_lookups].parameters.parameter[lookup_indexes][caller-allocates] 1
//!set function[ot_layout_feature_with_variations_get_lookups].parameters.parameter[lookup_indexes][caller-allocates] 1
//!set function[ot_layout_get_attach_points].parameters.parameter[point_array][caller-allocates] 1
//!set function[ot_layout_get_ligature_carets].parameters.parameter[caret_array][caller-allocates] 1
//!set function[ot_layout_language_get_feature_indexes].parameters.parameter[feature_indexes][caller-allocates] 1
//!set function[ot_layout_language_get_feature_tags].parameters.parameter[feature_tags][caller-allocates] 1
//!set function[ot_layout_script_get_language_tags].parameters.parameter[language_tags][caller-allocates] 1
//!set function[ot_layout_table_get_feature_tags].parameters.parameter[feature_tags][caller-allocates] 1
//!set function[ot_layout_table_get_script_tags].parameters.parameter[script_tags][caller-allocates] 1
//!set function[ot_var_named_instance_get_design_coords].parameters.parameter[coords][caller-allocates] 1
