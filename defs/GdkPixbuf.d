//!repo GdkPixbuf-2.0
//!subctype GdkPixbuf PixbufC

//# Set arrays to be zero-terminated=1
//!set callback[PixbufModuleLoadXpmDataFunc].parameters.parameter[data].array[][zero-terminated] 1
//!set callback[PixbufModuleSaveFunc].parameters.parameter[param_keys].array[][zero-terminated] 1
//!set callback[PixbufModuleSaveFunc].parameters.parameter[param_values].array[][zero-terminated] 1
//!set class[Pixbuf].constructor[new_from_xpm_data].parameters.parameter[data].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_bufferv].parameters.parameter[option_keys].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_bufferv].parameters.parameter[option_values].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_callbackv].parameters.parameter[option_keys].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_callbackv].parameters.parameter[option_values].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_streamv].parameters.parameter[option_keys].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_streamv].parameters.parameter[option_values].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_streamv_async].parameters.parameter[option_keys].array[][zero-terminated] 1
//!set class[Pixbuf].method[save_to_streamv_async].parameters.parameter[option_values].array[][zero-terminated] 1
//!set class[Pixbuf].method[savev].parameters.parameter[option_keys].array[][zero-terminated] 1
//!set class[Pixbuf].method[savev].parameters.parameter[option_values].array[][zero-terminated] 1
//!set record[PixbufFormat].method[get_extensions].return-value.array[][zero-terminated] 1
//!set record[PixbufFormat].method[get_mime_types].return-value.array[][zero-terminated] 1
//!set record[PixbufFormat].field[mime_types].array[][zero-terminated] 1
//!set record[PixbufFormat].field[extensions].array[][zero-terminated] 1

//# Set basic parameters to out
//!set callback[PixbufModuleSizeFunc].parameters.parameter[width][direction] out
//!set callback[PixbufModuleSizeFunc].parameters.parameter[height][direction] out
//!set record[PixbufAnimationClass].field[get_size].callback[get_size].parameters.parameter[width][direction] out
//!set record[PixbufAnimationClass].field[get_size].callback[get_size].parameters.parameter[height][direction] out
