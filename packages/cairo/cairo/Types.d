module cairo.Types;

import Gid.Gid;
import cairo.c.types;


// Enums
alias Status = cairo_status_t;
alias Content = cairo_content_t;
alias Operator = cairo_operator_t;
alias Antialias = cairo_antialias_t;
alias FillRule = cairo_fill_rule_t;
alias LineCap = cairo_line_cap_t;
alias LineJoin = cairo_line_join_t;
alias TextClusterFlags = cairo_text_cluster_flags_t;
alias FontSlant = cairo_font_slant_t;
alias FontWeight = cairo_font_weight_t;
alias SubpixelOrder = cairo_subpixel_order_t;
alias HintStyle = cairo_hint_style_t;
alias HintMetrics = cairo_hint_metrics_t;
alias FontType = cairo_font_type_t;
alias PathDataType = cairo_path_data_type_t;
alias DeviceType = cairo_device_type_t;
alias SurfaceType = cairo_surface_type_t;
alias Format = cairo_format_t;
alias PatternType = cairo_pattern_type_t;
alias Extend = cairo_extend_t;
alias Filter = cairo_filter_t;
alias RegionOverlap = cairo_region_overlap_t;

// Structs
alias Matrix = cairo_matrix_t;
alias Path = cairo_path_t;
