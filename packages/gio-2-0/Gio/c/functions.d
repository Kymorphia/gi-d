module Gio.c.functions;

import Gio.c.types;
public import GLib.c.types;
public import GModule.c.types;
public import GObject.c.types;

version(Windows)
  private immutable LIBS = ["libgio-2.0-0.dll;gio-2.0-0.dll;gio-2.dll"];
version(OSX)
  private immutable LIBS = ["libgio-2.0.0.dylib"];
else
  private immutable LIBS = ["libgio-2.0.so.0"];

__gshared extern(C)
{
  // Action
  GType function() c_g_action_get_type;
  bool function(const(char)* actionName) c_g_action_name_is_valid;
  bool function(const(char)* detailedName, char** actionName, GVariant** targetValue, GError** _err) c_g_action_parse_detailed_name;
  char* function(const(char)* actionName, GVariant* targetValue) c_g_action_print_detailed_name;
  void function(GAction* action, GVariant* parameter) c_g_action_activate;
  void function(GAction* action, GVariant* value) c_g_action_change_state;
  bool function(GAction* action) c_g_action_get_enabled;
  const(char)* function(GAction* action) c_g_action_get_name;
  const(GVariantType)* function(GAction* action) c_g_action_get_parameter_type;
  GVariant* function(GAction* action) c_g_action_get_state;
  GVariant* function(GAction* action) c_g_action_get_state_hint;
  const(GVariantType)* function(GAction* action) c_g_action_get_state_type;

  // ActionGroup
  GType function() c_g_action_group_get_type;
  void function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_action_added;
  void function(GActionGroup* actionGroup, const(char)* actionName, bool enabled) c_g_action_group_action_enabled_changed;
  void function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_action_removed;
  void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* state) c_g_action_group_action_state_changed;
  void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* parameter) c_g_action_group_activate_action;
  void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* value) c_g_action_group_change_action_state;
  bool function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_get_action_enabled;
  const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_get_action_parameter_type;
  GVariant* function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_get_action_state;
  GVariant* function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_get_action_state_hint;
  const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_get_action_state_type;
  bool function(GActionGroup* actionGroup, const(char)* actionName) c_g_action_group_has_action;
  char** function(GActionGroup* actionGroup) c_g_action_group_list_actions;
  bool function(GActionGroup* actionGroup, const(char)* actionName, bool* enabled, const(GVariantType*)* parameterType, const(GVariantType*)* stateType, GVariant** stateHint, GVariant** state) c_g_action_group_query_action;

  // ActionMap
  GType function() c_g_action_map_get_type;
  void function(GActionMap* actionMap, GAction* action) c_g_action_map_add_action;
  void function(GActionMap* actionMap, const(GActionEntry)* entries, int nEntries, void* userData) c_g_action_map_add_action_entries;
  GAction* function(GActionMap* actionMap, const(char)* actionName) c_g_action_map_lookup_action;
  void function(GActionMap* actionMap, const(char)* actionName) c_g_action_map_remove_action;
  void function(GActionMap* actionMap, const(GActionEntry)* entries, int nEntries) c_g_action_map_remove_action_entries;

  // AppInfo
  GType function() c_g_app_info_get_type;
  GAppInfo* function(const(char)* commandline, const(char)* applicationName, GAppInfoCreateFlags flags, GError** _err) c_g_app_info_create_from_commandline;
  GList* function() c_g_app_info_get_all;
  GList* function(const(char)* contentType) c_g_app_info_get_all_for_type;
  GAppInfo* function(const(char)* contentType, bool mustSupportUris) c_g_app_info_get_default_for_type;
  void function(const(char)* contentType, bool mustSupportUris, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_app_info_get_default_for_type_async;
  GAppInfo* function(GAsyncResult* result, GError** _err) c_g_app_info_get_default_for_type_finish;
  GAppInfo* function(const(char)* uriScheme) c_g_app_info_get_default_for_uri_scheme;
  void function(const(char)* uriScheme, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_app_info_get_default_for_uri_scheme_async;
  GAppInfo* function(GAsyncResult* result, GError** _err) c_g_app_info_get_default_for_uri_scheme_finish;
  GList* function(const(char)* contentType) c_g_app_info_get_fallback_for_type;
  GList* function(const(char)* contentType) c_g_app_info_get_recommended_for_type;
  bool function(const(char)* uri, GAppLaunchContext* context, GError** _err) c_g_app_info_launch_default_for_uri;
  void function(const(char)* uri, GAppLaunchContext* context, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_app_info_launch_default_for_uri_async;
  bool function(GAsyncResult* result, GError** _err) c_g_app_info_launch_default_for_uri_finish;
  void function(const(char)* contentType) c_g_app_info_reset_type_associations;
  bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) c_g_app_info_add_supports_type;
  bool function(GAppInfo* appinfo) c_g_app_info_can_delete;
  bool function(GAppInfo* appinfo) c_g_app_info_can_remove_supports_type;
  bool function(GAppInfo* appinfo) c_g_app_info_delete;
  GAppInfo* function(GAppInfo* appinfo) c_g_app_info_dup;
  bool function(GAppInfo* appinfo1, GAppInfo* appinfo2) c_g_app_info_equal;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_commandline;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_description;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_display_name;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_executable;
  GIcon* function(GAppInfo* appinfo) c_g_app_info_get_icon;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_id;
  const(char)* function(GAppInfo* appinfo) c_g_app_info_get_name;
  const(char*)* function(GAppInfo* appinfo) c_g_app_info_get_supported_types;
  bool function(GAppInfo* appinfo, GList* files, GAppLaunchContext* context, GError** _err) c_g_app_info_launch;
  bool function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GError** _err) c_g_app_info_launch_uris;
  void function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_app_info_launch_uris_async;
  bool function(GAppInfo* appinfo, GAsyncResult* result, GError** _err) c_g_app_info_launch_uris_finish;
  bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) c_g_app_info_remove_supports_type;
  bool function(GAppInfo* appinfo, const(char)* extension, GError** _err) c_g_app_info_set_as_default_for_extension;
  bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) c_g_app_info_set_as_default_for_type;
  bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) c_g_app_info_set_as_last_used_for_type;
  bool function(GAppInfo* appinfo) c_g_app_info_should_show;
  bool function(GAppInfo* appinfo) c_g_app_info_supports_files;
  bool function(GAppInfo* appinfo) c_g_app_info_supports_uris;

  // AppInfoMonitor
  GType function() c_g_app_info_monitor_get_type;
  GAppInfoMonitor* function() c_g_app_info_monitor_get;

  // AppLaunchContext
  GType function() c_g_app_launch_context_get_type;
  GAppLaunchContext* function() c_g_app_launch_context_new;
  char* function(GAppLaunchContext* context, GAppInfo* info, GList* files) c_g_app_launch_context_get_display;
  char** function(GAppLaunchContext* context) c_g_app_launch_context_get_environment;
  char* function(GAppLaunchContext* context, GAppInfo* info, GList* files) c_g_app_launch_context_get_startup_notify_id;
  void function(GAppLaunchContext* context, const(char)* startupNotifyId) c_g_app_launch_context_launch_failed;
  void function(GAppLaunchContext* context, const(char)* variable, const(char)* value) c_g_app_launch_context_setenv;
  void function(GAppLaunchContext* context, const(char)* variable) c_g_app_launch_context_unsetenv;

  // Application
  GType function() c_g_application_get_type;
  GApplication* function(const(char)* applicationId, GApplicationFlags flags) c_g_application_new;
  GApplication* function() c_g_application_get_default;
  bool function(const(char)* applicationId) c_g_application_id_is_valid;
  void function(GApplication* application) c_g_application_activate;
  void function(GApplication* application, const(char)* longName, char shortName, GOptionFlags flags, GOptionArg arg, const(char)* description, const(char)* argDescription) c_g_application_add_main_option;
  void function(GApplication* application, const(GOptionEntry)* entries) c_g_application_add_main_option_entries;
  void function(GApplication* application, GOptionGroup* group) c_g_application_add_option_group;
  void function(GApplication* application, ObjectC* object, const(char)* property) c_g_application_bind_busy_property;
  const(char)* function(GApplication* application) c_g_application_get_application_id;
  GDBusConnection* function(GApplication* application) c_g_application_get_dbus_connection;
  const(char)* function(GApplication* application) c_g_application_get_dbus_object_path;
  GApplicationFlags function(GApplication* application) c_g_application_get_flags;
  uint function(GApplication* application) c_g_application_get_inactivity_timeout;
  bool function(GApplication* application) c_g_application_get_is_busy;
  bool function(GApplication* application) c_g_application_get_is_registered;
  bool function(GApplication* application) c_g_application_get_is_remote;
  const(char)* function(GApplication* application) c_g_application_get_resource_base_path;
  const(char)* function(GApplication* application) c_g_application_get_version;
  void function(GApplication* application) c_g_application_hold;
  void function(GApplication* application) c_g_application_mark_busy;
  void function(GApplication* application, GFile** files, int nFiles, const(char)* hint) c_g_application_open;
  void function(GApplication* application) c_g_application_quit;
  bool function(GApplication* application, GCancellable* cancellable, GError** _err) c_g_application_register;
  void function(GApplication* application) c_g_application_release;
  int function(GApplication* application, int argc, char** argv) c_g_application_run;
  void function(GApplication* application, const(char)* id, GNotification* notification) c_g_application_send_notification;
  void function(GApplication* application, GActionGroup* actionGroup) c_g_application_set_action_group;
  void function(GApplication* application, const(char)* applicationId) c_g_application_set_application_id;
  void function(GApplication* application) c_g_application_set_default;
  void function(GApplication* application, GApplicationFlags flags) c_g_application_set_flags;
  void function(GApplication* application, uint inactivityTimeout) c_g_application_set_inactivity_timeout;
  void function(GApplication* application, const(char)* description) c_g_application_set_option_context_description;
  void function(GApplication* application, const(char)* parameterString) c_g_application_set_option_context_parameter_string;
  void function(GApplication* application, const(char)* summary) c_g_application_set_option_context_summary;
  void function(GApplication* application, const(char)* resourcePath) c_g_application_set_resource_base_path;
  void function(GApplication* application, const(char)* version_) c_g_application_set_version;
  void function(GApplication* application, ObjectC* object, const(char)* property) c_g_application_unbind_busy_property;
  void function(GApplication* application) c_g_application_unmark_busy;
  void function(GApplication* application, const(char)* id) c_g_application_withdraw_notification;

  // ApplicationCommandLine
  GType function() c_g_application_command_line_get_type;
  GFile* function(GApplicationCommandLine* cmdline, const(char)* arg) c_g_application_command_line_create_file_for_arg;
  void function(GApplicationCommandLine* cmdline) c_g_application_command_line_done;
  char** function(GApplicationCommandLine* cmdline, int* argc) c_g_application_command_line_get_arguments;
  const(char)* function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_cwd;
  const(char*)* function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_environ;
  int function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_exit_status;
  bool function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_is_remote;
  GVariantDict* function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_options_dict;
  GVariant* function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_platform_data;
  GInputStream* function(GApplicationCommandLine* cmdline) c_g_application_command_line_get_stdin;
  const(char)* function(GApplicationCommandLine* cmdline, const(char)* name) c_g_application_command_line_getenv;
  void function(GApplicationCommandLine* cmdline, const(char)* format,  ...) c_g_application_command_line_print;
  void function(GApplicationCommandLine* cmdline, const(char)* message) c_g_application_command_line_print_literal;
  void function(GApplicationCommandLine* cmdline, const(char)* format,  ...) c_g_application_command_line_printerr;
  void function(GApplicationCommandLine* cmdline, const(char)* message) c_g_application_command_line_printerr_literal;
  void function(GApplicationCommandLine* cmdline, int exitStatus) c_g_application_command_line_set_exit_status;

  // AsyncInitable
  GType function() c_g_async_initable_get_type;
  void function(GType objectType, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData, const(char)* firstPropertyName,  ...) c_g_async_initable_new_async;
  void function(GType objectType, const(char)* firstPropertyName, void* varArgs, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_async_initable_new_valist_async;
  void function(GType objectType, uint nParameters, GParameter* parameters, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_async_initable_newv_async;
  void function(GAsyncInitable* initable, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_async_initable_init_async;
  bool function(GAsyncInitable* initable, GAsyncResult* res, GError** _err) c_g_async_initable_init_finish;
  ObjectC* function(GAsyncInitable* initable, GAsyncResult* res, GError** _err) c_g_async_initable_new_finish;

  // AsyncResult
  GType function() c_g_async_result_get_type;
  ObjectC* function(GAsyncResult* res) c_g_async_result_get_source_object;
  void* function(GAsyncResult* res) c_g_async_result_get_user_data;
  bool function(GAsyncResult* res, void* sourceTag) c_g_async_result_is_tagged;
  bool function(GAsyncResult* res, GError** _err) c_g_async_result_legacy_propagate_error;

  // BufferedInputStream
  GType function() c_g_buffered_input_stream_get_type;
  GInputStream* function(GInputStream* baseStream) c_g_buffered_input_stream_new;
  GInputStream* function(GInputStream* baseStream, size_t size) c_g_buffered_input_stream_new_sized;
  ptrdiff_t function(GBufferedInputStream* stream, ptrdiff_t count, GCancellable* cancellable, GError** _err) c_g_buffered_input_stream_fill;
  void function(GBufferedInputStream* stream, ptrdiff_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_buffered_input_stream_fill_async;
  ptrdiff_t function(GBufferedInputStream* stream, GAsyncResult* result, GError** _err) c_g_buffered_input_stream_fill_finish;
  size_t function(GBufferedInputStream* stream) c_g_buffered_input_stream_get_available;
  size_t function(GBufferedInputStream* stream) c_g_buffered_input_stream_get_buffer_size;
  size_t function(GBufferedInputStream* stream, void* buffer, size_t offset, size_t count) c_g_buffered_input_stream_peek;
  void* function(GBufferedInputStream* stream, size_t* count) c_g_buffered_input_stream_peek_buffer;
  int function(GBufferedInputStream* stream, GCancellable* cancellable, GError** _err) c_g_buffered_input_stream_read_byte;
  void function(GBufferedInputStream* stream, size_t size) c_g_buffered_input_stream_set_buffer_size;

  // BufferedOutputStream
  GType function() c_g_buffered_output_stream_get_type;
  GOutputStream* function(GOutputStream* baseStream) c_g_buffered_output_stream_new;
  GOutputStream* function(GOutputStream* baseStream, size_t size) c_g_buffered_output_stream_new_sized;
  bool function(GBufferedOutputStream* stream) c_g_buffered_output_stream_get_auto_grow;
  size_t function(GBufferedOutputStream* stream) c_g_buffered_output_stream_get_buffer_size;
  void function(GBufferedOutputStream* stream, bool autoGrow) c_g_buffered_output_stream_set_auto_grow;
  void function(GBufferedOutputStream* stream, size_t size) c_g_buffered_output_stream_set_buffer_size;

  // BytesIcon
  GType function() c_g_bytes_icon_get_type;
  GIcon* function(GBytes* bytes) c_g_bytes_icon_new;
  GBytes* function(GBytesIcon* icon) c_g_bytes_icon_get_bytes;

  // Cancellable
  GType function() c_g_cancellable_get_type;
  GCancellable* function() c_g_cancellable_new;
  GCancellable* function() c_g_cancellable_get_current;
  void function(GCancellable* cancellable) c_g_cancellable_cancel;
  ulong function(GCancellable* cancellable, GCallback callback, void* data, GDestroyNotify dataDestroyFunc) c_g_cancellable_connect;
  void function(GCancellable* cancellable, ulong handlerId) c_g_cancellable_disconnect;
  int function(GCancellable* cancellable) c_g_cancellable_get_fd;
  bool function(GCancellable* cancellable) c_g_cancellable_is_cancelled;
  bool function(GCancellable* cancellable, GPollFD* pollfd) c_g_cancellable_make_pollfd;
  void function(GCancellable* cancellable) c_g_cancellable_pop_current;
  void function(GCancellable* cancellable) c_g_cancellable_push_current;
  void function(GCancellable* cancellable) c_g_cancellable_release_fd;
  void function(GCancellable* cancellable) c_g_cancellable_reset;
  bool function(GCancellable* cancellable, GError** _err) c_g_cancellable_set_error_if_cancelled;
  GSource* function(GCancellable* cancellable) c_g_cancellable_source_new;

  // CharsetConverter
  GType function() c_g_charset_converter_get_type;
  GCharsetConverter* function(const(char)* toCharset, const(char)* fromCharset, GError** _err) c_g_charset_converter_new;
  uint function(GCharsetConverter* converter) c_g_charset_converter_get_num_fallbacks;
  bool function(GCharsetConverter* converter) c_g_charset_converter_get_use_fallback;
  void function(GCharsetConverter* converter, bool useFallback) c_g_charset_converter_set_use_fallback;

  // Converter
  GType function() c_g_converter_get_type;
  GConverterResult function(GConverter* converter, void* inbuf, size_t inbufSize, void* outbuf, size_t outbufSize, GConverterFlags flags, size_t* bytesRead, size_t* bytesWritten, GError** _err) c_g_converter_convert;
  void function(GConverter* converter) c_g_converter_reset;

  // ConverterInputStream
  GType function() c_g_converter_input_stream_get_type;
  GInputStream* function(GInputStream* baseStream, GConverter* converter) c_g_converter_input_stream_new;
  GConverter* function(GConverterInputStream* converterStream) c_g_converter_input_stream_get_converter;

  // ConverterOutputStream
  GType function() c_g_converter_output_stream_get_type;
  GOutputStream* function(GOutputStream* baseStream, GConverter* converter) c_g_converter_output_stream_new;
  GConverter* function(GConverterOutputStream* converterStream) c_g_converter_output_stream_get_converter;

  // Credentials
  GType function() c_g_credentials_get_type;
  GCredentials* function() c_g_credentials_new;
  void* function(GCredentials* credentials, GCredentialsType nativeType) c_g_credentials_get_native;
  int function(GCredentials* credentials, GError** _err) c_g_credentials_get_unix_pid;
  uint function(GCredentials* credentials, GError** _err) c_g_credentials_get_unix_user;
  bool function(GCredentials* credentials, GCredentials* otherCredentials, GError** _err) c_g_credentials_is_same_user;
  void function(GCredentials* credentials, GCredentialsType nativeType, void* native) c_g_credentials_set_native;
  bool function(GCredentials* credentials, uint uid, GError** _err) c_g_credentials_set_unix_user;
  char* function(GCredentials* credentials) c_g_credentials_to_string;

  // DBusActionGroup
  GType function() c_g_dbus_action_group_get_type;
  GDBusActionGroup* function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath) c_g_dbus_action_group_get;

  // DBusAnnotationInfo
  GType function() c_g_dbus_annotation_info_get_type;
  GDBusAnnotationInfo* function(GDBusAnnotationInfo* info) c_g_dbus_annotation_info_ref;
  void function(GDBusAnnotationInfo* info) c_g_dbus_annotation_info_unref;
  const(char)* function(GDBusAnnotationInfo** annotations, const(char)* name) c_g_dbus_annotation_info_lookup;

  // DBusArgInfo
  GType function() c_g_dbus_arg_info_get_type;
  GDBusArgInfo* function(GDBusArgInfo* info) c_g_dbus_arg_info_ref;
  void function(GDBusArgInfo* info) c_g_dbus_arg_info_unref;

  // DBusAuthObserver
  GType function() c_g_dbus_auth_observer_get_type;
  GDBusAuthObserver* function() c_g_dbus_auth_observer_new;
  bool function(GDBusAuthObserver* observer, const(char)* mechanism) c_g_dbus_auth_observer_allow_mechanism;
  bool function(GDBusAuthObserver* observer, GIOStream* stream, GCredentials* credentials) c_g_dbus_auth_observer_authorize_authenticated_peer;

  // DBusConnection
  GType function() c_g_dbus_connection_get_type;
  GDBusConnection* function(GAsyncResult* res, GError** _err) c_g_dbus_connection_new_finish;
  GDBusConnection* function(GAsyncResult* res, GError** _err) c_g_dbus_connection_new_for_address_finish;
  GDBusConnection* function(const(char)* address, GDBusConnectionFlags flags, GDBusAuthObserver* observer, GCancellable* cancellable, GError** _err) c_g_dbus_connection_new_for_address_sync;
  GDBusConnection* function(GIOStream* stream, const(char)* guid, GDBusConnectionFlags flags, GDBusAuthObserver* observer, GCancellable* cancellable, GError** _err) c_g_dbus_connection_new_sync;
  void function(GIOStream* stream, const(char)* guid, GDBusConnectionFlags flags, GDBusAuthObserver* observer, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_new;
  void function(const(char)* address, GDBusConnectionFlags flags, GDBusAuthObserver* observer, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_new_for_address;
  uint function(GDBusConnection* connection, GDBusMessageFilterFunction filterFunction, void* userData, GDestroyNotify userDataFreeFunc) c_g_dbus_connection_add_filter;
  void function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath, const(char)* interfaceName, const(char)* methodName, GVariant* parameters, const(GVariantType)* replyType, GDBusCallFlags flags, int timeoutMsec, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_call;
  GVariant* function(GDBusConnection* connection, GAsyncResult* res, GError** _err) c_g_dbus_connection_call_finish;
  GVariant* function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath, const(char)* interfaceName, const(char)* methodName, GVariant* parameters, const(GVariantType)* replyType, GDBusCallFlags flags, int timeoutMsec, GCancellable* cancellable, GError** _err) c_g_dbus_connection_call_sync;
  void function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath, const(char)* interfaceName, const(char)* methodName, GVariant* parameters, const(GVariantType)* replyType, GDBusCallFlags flags, int timeoutMsec, GUnixFDList* fdList, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_call_with_unix_fd_list;
  GVariant* function(GDBusConnection* connection, GUnixFDList** outFdList, GAsyncResult* res, GError** _err) c_g_dbus_connection_call_with_unix_fd_list_finish;
  GVariant* function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath, const(char)* interfaceName, const(char)* methodName, GVariant* parameters, const(GVariantType)* replyType, GDBusCallFlags flags, int timeoutMsec, GUnixFDList* fdList, GUnixFDList** outFdList, GCancellable* cancellable, GError** _err) c_g_dbus_connection_call_with_unix_fd_list_sync;
  void function(GDBusConnection* connection, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_close;
  bool function(GDBusConnection* connection, GAsyncResult* res, GError** _err) c_g_dbus_connection_close_finish;
  bool function(GDBusConnection* connection, GCancellable* cancellable, GError** _err) c_g_dbus_connection_close_sync;
  bool function(GDBusConnection* connection, const(char)* destinationBusName, const(char)* objectPath, const(char)* interfaceName, const(char)* signalName, GVariant* parameters, GError** _err) c_g_dbus_connection_emit_signal;
  uint function(GDBusConnection* connection, const(char)* objectPath, GActionGroup* actionGroup, GError** _err) c_g_dbus_connection_export_action_group;
  uint function(GDBusConnection* connection, const(char)* objectPath, GMenuModel* menu, GError** _err) c_g_dbus_connection_export_menu_model;
  void function(GDBusConnection* connection, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_flush;
  bool function(GDBusConnection* connection, GAsyncResult* res, GError** _err) c_g_dbus_connection_flush_finish;
  bool function(GDBusConnection* connection, GCancellable* cancellable, GError** _err) c_g_dbus_connection_flush_sync;
  GDBusCapabilityFlags function(GDBusConnection* connection) c_g_dbus_connection_get_capabilities;
  bool function(GDBusConnection* connection) c_g_dbus_connection_get_exit_on_close;
  GDBusConnectionFlags function(GDBusConnection* connection) c_g_dbus_connection_get_flags;
  const(char)* function(GDBusConnection* connection) c_g_dbus_connection_get_guid;
  uint function(GDBusConnection* connection) c_g_dbus_connection_get_last_serial;
  GCredentials* function(GDBusConnection* connection) c_g_dbus_connection_get_peer_credentials;
  GIOStream* function(GDBusConnection* connection) c_g_dbus_connection_get_stream;
  const(char)* function(GDBusConnection* connection) c_g_dbus_connection_get_unique_name;
  bool function(GDBusConnection* connection) c_g_dbus_connection_is_closed;
  uint function(GDBusConnection* connection, const(char)* objectPath, GDBusInterfaceInfo* interfaceInfo, const(GDBusInterfaceVTable)* vtable, void* userData, GDestroyNotify userDataFreeFunc, GError** _err) c_g_dbus_connection_register_object;
  uint function(GDBusConnection* connection, const(char)* objectPath, GDBusInterfaceInfo* interfaceInfo, GClosure* methodCallClosure, GClosure* getPropertyClosure, GClosure* setPropertyClosure, GError** _err) c_g_dbus_connection_register_object_with_closures;
  uint function(GDBusConnection* connection, const(char)* objectPath, const(GDBusSubtreeVTable)* vtable, GDBusSubtreeFlags flags, void* userData, GDestroyNotify userDataFreeFunc, GError** _err) c_g_dbus_connection_register_subtree;
  void function(GDBusConnection* connection, uint filterId) c_g_dbus_connection_remove_filter;
  bool function(GDBusConnection* connection, GDBusMessage* message, GDBusSendMessageFlags flags, uint* outSerial, GError** _err) c_g_dbus_connection_send_message;
  void function(GDBusConnection* connection, GDBusMessage* message, GDBusSendMessageFlags flags, int timeoutMsec, uint* outSerial, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_connection_send_message_with_reply;
  GDBusMessage* function(GDBusConnection* connection, GAsyncResult* res, GError** _err) c_g_dbus_connection_send_message_with_reply_finish;
  GDBusMessage* function(GDBusConnection* connection, GDBusMessage* message, GDBusSendMessageFlags flags, int timeoutMsec, uint* outSerial, GCancellable* cancellable, GError** _err) c_g_dbus_connection_send_message_with_reply_sync;
  void function(GDBusConnection* connection, bool exitOnClose) c_g_dbus_connection_set_exit_on_close;
  uint function(GDBusConnection* connection, const(char)* sender, const(char)* interfaceName, const(char)* member, const(char)* objectPath, const(char)* arg0, GDBusSignalFlags flags, GDBusSignalCallback callback, void* userData, GDestroyNotify userDataFreeFunc) c_g_dbus_connection_signal_subscribe;
  void function(GDBusConnection* connection, uint subscriptionId) c_g_dbus_connection_signal_unsubscribe;
  void function(GDBusConnection* connection) c_g_dbus_connection_start_message_processing;
  void function(GDBusConnection* connection, uint exportId) c_g_dbus_connection_unexport_action_group;
  void function(GDBusConnection* connection, uint exportId) c_g_dbus_connection_unexport_menu_model;
  bool function(GDBusConnection* connection, uint registrationId) c_g_dbus_connection_unregister_object;
  bool function(GDBusConnection* connection, uint registrationId) c_g_dbus_connection_unregister_subtree;

  // DBusInterface
  GType function() c_g_dbus_interface_get_type;
  GDBusObject* function(GDBusInterface* interface_) c_g_dbus_interface_dup_object;
  GDBusInterfaceInfo* function(GDBusInterface* interface_) c_g_dbus_interface_get_info;
  GDBusObject* function(GDBusInterface* interface_) c_g_dbus_interface_get_object;
  void function(GDBusInterface* interface_, GDBusObject* object) c_g_dbus_interface_set_object;

  // DBusInterfaceInfo
  GType function() c_g_dbus_interface_info_get_type;
  void function(GDBusInterfaceInfo* info) c_g_dbus_interface_info_cache_build;
  void function(GDBusInterfaceInfo* info) c_g_dbus_interface_info_cache_release;
  void function(GDBusInterfaceInfo* info, uint indent, GString* stringBuilder) c_g_dbus_interface_info_generate_xml;
  GDBusMethodInfo* function(GDBusInterfaceInfo* info, const(char)* name) c_g_dbus_interface_info_lookup_method;
  GDBusPropertyInfo* function(GDBusInterfaceInfo* info, const(char)* name) c_g_dbus_interface_info_lookup_property;
  GDBusSignalInfo* function(GDBusInterfaceInfo* info, const(char)* name) c_g_dbus_interface_info_lookup_signal;
  GDBusInterfaceInfo* function(GDBusInterfaceInfo* info) c_g_dbus_interface_info_ref;
  void function(GDBusInterfaceInfo* info) c_g_dbus_interface_info_unref;

  // DBusInterfaceSkeleton
  GType function() c_g_dbus_interface_skeleton_get_type;
  bool function(GDBusInterfaceSkeleton* interface_, GDBusConnection* connection, const(char)* objectPath, GError** _err) c_g_dbus_interface_skeleton_export;
  void function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_flush;
  GDBusConnection* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_connection;
  GList* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_connections;
  GDBusInterfaceSkeletonFlags function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_flags;
  GDBusInterfaceInfo* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_info;
  const(char)* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_object_path;
  GVariant* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_properties;
  GDBusInterfaceVTable* function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_get_vtable;
  bool function(GDBusInterfaceSkeleton* interface_, GDBusConnection* connection) c_g_dbus_interface_skeleton_has_connection;
  void function(GDBusInterfaceSkeleton* interface_, GDBusInterfaceSkeletonFlags flags) c_g_dbus_interface_skeleton_set_flags;
  void function(GDBusInterfaceSkeleton* interface_) c_g_dbus_interface_skeleton_unexport;
  void function(GDBusInterfaceSkeleton* interface_, GDBusConnection* connection) c_g_dbus_interface_skeleton_unexport_from_connection;

  // DBusMenuModel
  GType function() c_g_dbus_menu_model_get_type;
  GDBusMenuModel* function(GDBusConnection* connection, const(char)* busName, const(char)* objectPath) c_g_dbus_menu_model_get;

  // DBusMessage
  GType function() c_g_dbus_message_get_type;
  GDBusMessage* function() c_g_dbus_message_new;
  GDBusMessage* function(ubyte* blob, size_t blobLen, GDBusCapabilityFlags capabilities, GError** _err) c_g_dbus_message_new_from_blob;
  GDBusMessage* function(const(char)* name, const(char)* path, const(char)* interface_, const(char)* method) c_g_dbus_message_new_method_call;
  GDBusMessage* function(const(char)* path, const(char)* interface_, const(char)* signal) c_g_dbus_message_new_signal;
  ptrdiff_t function(ubyte* blob, size_t blobLen, GError** _err) c_g_dbus_message_bytes_needed;
  GDBusMessage* function(GDBusMessage* message, GError** _err) c_g_dbus_message_copy;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_arg0;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_arg0_path;
  GVariant* function(GDBusMessage* message) c_g_dbus_message_get_body;
  GDBusMessageByteOrder function(GDBusMessage* message) c_g_dbus_message_get_byte_order;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_destination;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_error_name;
  GDBusMessageFlags function(GDBusMessage* message) c_g_dbus_message_get_flags;
  GVariant* function(GDBusMessage* message, GDBusMessageHeaderField headerField) c_g_dbus_message_get_header;
  ubyte* function(GDBusMessage* message) c_g_dbus_message_get_header_fields;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_interface;
  bool function(GDBusMessage* message) c_g_dbus_message_get_locked;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_member;
  GDBusMessageType function(GDBusMessage* message) c_g_dbus_message_get_message_type;
  uint function(GDBusMessage* message) c_g_dbus_message_get_num_unix_fds;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_path;
  uint function(GDBusMessage* message) c_g_dbus_message_get_reply_serial;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_sender;
  uint function(GDBusMessage* message) c_g_dbus_message_get_serial;
  const(char)* function(GDBusMessage* message) c_g_dbus_message_get_signature;
  GUnixFDList* function(GDBusMessage* message) c_g_dbus_message_get_unix_fd_list;
  void function(GDBusMessage* message) c_g_dbus_message_lock;
  GDBusMessage* function(GDBusMessage* methodCallMessage, const(char)* errorName, const(char)* errorMessageFormat,  ...) c_g_dbus_message_new_method_error;
  GDBusMessage* function(GDBusMessage* methodCallMessage, const(char)* errorName, const(char)* errorMessage) c_g_dbus_message_new_method_error_literal;
  GDBusMessage* function(GDBusMessage* methodCallMessage, const(char)* errorName, const(char)* errorMessageFormat, void* varArgs) c_g_dbus_message_new_method_error_valist;
  GDBusMessage* function(GDBusMessage* methodCallMessage) c_g_dbus_message_new_method_reply;
  char* function(GDBusMessage* message, uint indent) c_g_dbus_message_print;
  void function(GDBusMessage* message, GVariant* body_) c_g_dbus_message_set_body;
  void function(GDBusMessage* message, GDBusMessageByteOrder byteOrder) c_g_dbus_message_set_byte_order;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_destination;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_error_name;
  void function(GDBusMessage* message, GDBusMessageFlags flags) c_g_dbus_message_set_flags;
  void function(GDBusMessage* message, GDBusMessageHeaderField headerField, GVariant* value) c_g_dbus_message_set_header;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_interface;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_member;
  void function(GDBusMessage* message, GDBusMessageType type) c_g_dbus_message_set_message_type;
  void function(GDBusMessage* message, uint value) c_g_dbus_message_set_num_unix_fds;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_path;
  void function(GDBusMessage* message, uint value) c_g_dbus_message_set_reply_serial;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_sender;
  void function(GDBusMessage* message, uint serial) c_g_dbus_message_set_serial;
  void function(GDBusMessage* message, const(char)* value) c_g_dbus_message_set_signature;
  void function(GDBusMessage* message, GUnixFDList* fdList) c_g_dbus_message_set_unix_fd_list;
  ubyte* function(GDBusMessage* message, size_t* outSize, GDBusCapabilityFlags capabilities, GError** _err) c_g_dbus_message_to_blob;
  bool function(GDBusMessage* message, GError** _err) c_g_dbus_message_to_gerror;

  // DBusMethodInfo
  GType function() c_g_dbus_method_info_get_type;
  GDBusMethodInfo* function(GDBusMethodInfo* info) c_g_dbus_method_info_ref;
  void function(GDBusMethodInfo* info) c_g_dbus_method_info_unref;

  // DBusMethodInvocation
  GType function() c_g_dbus_method_invocation_get_type;
  GDBusConnection* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_connection;
  const(char)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_interface_name;
  GDBusMessage* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_message;
  const(GDBusMethodInfo)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_method_info;
  const(char)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_method_name;
  const(char)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_object_path;
  GVariant* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_parameters;
  const(GDBusPropertyInfo)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_property_info;
  const(char)* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_sender;
  void* function(GDBusMethodInvocation* invocation) c_g_dbus_method_invocation_get_user_data;
  void function(GDBusMethodInvocation* invocation, const(char)* errorName, const(char)* errorMessage) c_g_dbus_method_invocation_return_dbus_error;
  void function(GDBusMethodInvocation* invocation, GQuark domain, int code, const(char)* format,  ...) c_g_dbus_method_invocation_return_error;
  void function(GDBusMethodInvocation* invocation, GQuark domain, int code, const(char)* message) c_g_dbus_method_invocation_return_error_literal;
  void function(GDBusMethodInvocation* invocation, GQuark domain, int code, const(char)* format, void* varArgs) c_g_dbus_method_invocation_return_error_valist;
  void function(GDBusMethodInvocation* invocation, const(GError)* error) c_g_dbus_method_invocation_return_gerror;
  void function(GDBusMethodInvocation* invocation, GVariant* parameters) c_g_dbus_method_invocation_return_value;
  void function(GDBusMethodInvocation* invocation, GVariant* parameters, GUnixFDList* fdList) c_g_dbus_method_invocation_return_value_with_unix_fd_list;
  void function(GDBusMethodInvocation* invocation, GError* error) c_g_dbus_method_invocation_take_error;

  // DBusNodeInfo
  GType function() c_g_dbus_node_info_get_type;
  GDBusNodeInfo* function(const(char)* xmlData, GError** _err) c_g_dbus_node_info_new_for_xml;
  void function(GDBusNodeInfo* info, uint indent, GString* stringBuilder) c_g_dbus_node_info_generate_xml;
  GDBusInterfaceInfo* function(GDBusNodeInfo* info, const(char)* name) c_g_dbus_node_info_lookup_interface;
  GDBusNodeInfo* function(GDBusNodeInfo* info) c_g_dbus_node_info_ref;
  void function(GDBusNodeInfo* info) c_g_dbus_node_info_unref;

  // DBusObject
  GType function() c_g_dbus_object_get_type;
  GDBusInterface* function(GDBusObject* object, const(char)* interfaceName) c_g_dbus_object_get_interface;
  GList* function(GDBusObject* object) c_g_dbus_object_get_interfaces;
  const(char)* function(GDBusObject* object) c_g_dbus_object_get_object_path;

  // DBusObjectManager
  GType function() c_g_dbus_object_manager_get_type;
  GDBusInterface* function(GDBusObjectManager* manager, const(char)* objectPath, const(char)* interfaceName) c_g_dbus_object_manager_get_interface;
  GDBusObject* function(GDBusObjectManager* manager, const(char)* objectPath) c_g_dbus_object_manager_get_object;
  const(char)* function(GDBusObjectManager* manager) c_g_dbus_object_manager_get_object_path;
  GList* function(GDBusObjectManager* manager) c_g_dbus_object_manager_get_objects;

  // DBusObjectManagerClient
  GType function() c_g_dbus_object_manager_client_get_type;
  GDBusObjectManager* function(GAsyncResult* res, GError** _err) c_g_dbus_object_manager_client_new_finish;
  GDBusObjectManager* function(GAsyncResult* res, GError** _err) c_g_dbus_object_manager_client_new_for_bus_finish;
  GDBusObjectManager* function(GBusType busType, GDBusObjectManagerClientFlags flags, const(char)* name, const(char)* objectPath, GDBusProxyTypeFunc getProxyTypeFunc, void* getProxyTypeUserData, GDestroyNotify getProxyTypeDestroyNotify, GCancellable* cancellable, GError** _err) c_g_dbus_object_manager_client_new_for_bus_sync;
  GDBusObjectManager* function(GDBusConnection* connection, GDBusObjectManagerClientFlags flags, const(char)* name, const(char)* objectPath, GDBusProxyTypeFunc getProxyTypeFunc, void* getProxyTypeUserData, GDestroyNotify getProxyTypeDestroyNotify, GCancellable* cancellable, GError** _err) c_g_dbus_object_manager_client_new_sync;
  void function(GDBusConnection* connection, GDBusObjectManagerClientFlags flags, const(char)* name, const(char)* objectPath, GDBusProxyTypeFunc getProxyTypeFunc, void* getProxyTypeUserData, GDestroyNotify getProxyTypeDestroyNotify, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_object_manager_client_new;
  void function(GBusType busType, GDBusObjectManagerClientFlags flags, const(char)* name, const(char)* objectPath, GDBusProxyTypeFunc getProxyTypeFunc, void* getProxyTypeUserData, GDestroyNotify getProxyTypeDestroyNotify, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_object_manager_client_new_for_bus;
  GDBusConnection* function(GDBusObjectManagerClient* manager) c_g_dbus_object_manager_client_get_connection;
  GDBusObjectManagerClientFlags function(GDBusObjectManagerClient* manager) c_g_dbus_object_manager_client_get_flags;
  const(char)* function(GDBusObjectManagerClient* manager) c_g_dbus_object_manager_client_get_name;
  char* function(GDBusObjectManagerClient* manager) c_g_dbus_object_manager_client_get_name_owner;

  // DBusObjectManagerServer
  GType function() c_g_dbus_object_manager_server_get_type;
  GDBusObjectManagerServer* function(const(char)* objectPath) c_g_dbus_object_manager_server_new;
  void function(GDBusObjectManagerServer* manager, GDBusObjectSkeleton* object) c_g_dbus_object_manager_server_export;
  void function(GDBusObjectManagerServer* manager, GDBusObjectSkeleton* object) c_g_dbus_object_manager_server_export_uniquely;
  GDBusConnection* function(GDBusObjectManagerServer* manager) c_g_dbus_object_manager_server_get_connection;
  bool function(GDBusObjectManagerServer* manager, GDBusObjectSkeleton* object) c_g_dbus_object_manager_server_is_exported;
  void function(GDBusObjectManagerServer* manager, GDBusConnection* connection) c_g_dbus_object_manager_server_set_connection;
  bool function(GDBusObjectManagerServer* manager, const(char)* objectPath) c_g_dbus_object_manager_server_unexport;

  // DBusObjectProxy
  GType function() c_g_dbus_object_proxy_get_type;
  GDBusObjectProxy* function(GDBusConnection* connection, const(char)* objectPath) c_g_dbus_object_proxy_new;
  GDBusConnection* function(GDBusObjectProxy* proxy) c_g_dbus_object_proxy_get_connection;

  // DBusObjectSkeleton
  GType function() c_g_dbus_object_skeleton_get_type;
  GDBusObjectSkeleton* function(const(char)* objectPath) c_g_dbus_object_skeleton_new;
  void function(GDBusObjectSkeleton* object, GDBusInterfaceSkeleton* interface_) c_g_dbus_object_skeleton_add_interface;
  void function(GDBusObjectSkeleton* object) c_g_dbus_object_skeleton_flush;
  void function(GDBusObjectSkeleton* object, GDBusInterfaceSkeleton* interface_) c_g_dbus_object_skeleton_remove_interface;
  void function(GDBusObjectSkeleton* object, const(char)* interfaceName) c_g_dbus_object_skeleton_remove_interface_by_name;
  void function(GDBusObjectSkeleton* object, const(char)* objectPath) c_g_dbus_object_skeleton_set_object_path;

  // DBusPropertyInfo
  GType function() c_g_dbus_property_info_get_type;
  GDBusPropertyInfo* function(GDBusPropertyInfo* info) c_g_dbus_property_info_ref;
  void function(GDBusPropertyInfo* info) c_g_dbus_property_info_unref;

  // DBusProxy
  GType function() c_g_dbus_proxy_get_type;
  GDBusProxy* function(GAsyncResult* res, GError** _err) c_g_dbus_proxy_new_finish;
  GDBusProxy* function(GAsyncResult* res, GError** _err) c_g_dbus_proxy_new_for_bus_finish;
  GDBusProxy* function(GBusType busType, GDBusProxyFlags flags, GDBusInterfaceInfo* info, const(char)* name, const(char)* objectPath, const(char)* interfaceName, GCancellable* cancellable, GError** _err) c_g_dbus_proxy_new_for_bus_sync;
  GDBusProxy* function(GDBusConnection* connection, GDBusProxyFlags flags, GDBusInterfaceInfo* info, const(char)* name, const(char)* objectPath, const(char)* interfaceName, GCancellable* cancellable, GError** _err) c_g_dbus_proxy_new_sync;
  void function(GDBusConnection* connection, GDBusProxyFlags flags, GDBusInterfaceInfo* info, const(char)* name, const(char)* objectPath, const(char)* interfaceName, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_proxy_new;
  void function(GBusType busType, GDBusProxyFlags flags, GDBusInterfaceInfo* info, const(char)* name, const(char)* objectPath, const(char)* interfaceName, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_proxy_new_for_bus;
  void function(GDBusProxy* proxy, const(char)* methodName, GVariant* parameters, GDBusCallFlags flags, int timeoutMsec, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_proxy_call;
  GVariant* function(GDBusProxy* proxy, GAsyncResult* res, GError** _err) c_g_dbus_proxy_call_finish;
  GVariant* function(GDBusProxy* proxy, const(char)* methodName, GVariant* parameters, GDBusCallFlags flags, int timeoutMsec, GCancellable* cancellable, GError** _err) c_g_dbus_proxy_call_sync;
  void function(GDBusProxy* proxy, const(char)* methodName, GVariant* parameters, GDBusCallFlags flags, int timeoutMsec, GUnixFDList* fdList, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_proxy_call_with_unix_fd_list;
  GVariant* function(GDBusProxy* proxy, GUnixFDList** outFdList, GAsyncResult* res, GError** _err) c_g_dbus_proxy_call_with_unix_fd_list_finish;
  GVariant* function(GDBusProxy* proxy, const(char)* methodName, GVariant* parameters, GDBusCallFlags flags, int timeoutMsec, GUnixFDList* fdList, GUnixFDList** outFdList, GCancellable* cancellable, GError** _err) c_g_dbus_proxy_call_with_unix_fd_list_sync;
  GVariant* function(GDBusProxy* proxy, const(char)* propertyName) c_g_dbus_proxy_get_cached_property;
  char** function(GDBusProxy* proxy) c_g_dbus_proxy_get_cached_property_names;
  GDBusConnection* function(GDBusProxy* proxy) c_g_dbus_proxy_get_connection;
  int function(GDBusProxy* proxy) c_g_dbus_proxy_get_default_timeout;
  GDBusProxyFlags function(GDBusProxy* proxy) c_g_dbus_proxy_get_flags;
  GDBusInterfaceInfo* function(GDBusProxy* proxy) c_g_dbus_proxy_get_interface_info;
  const(char)* function(GDBusProxy* proxy) c_g_dbus_proxy_get_interface_name;
  const(char)* function(GDBusProxy* proxy) c_g_dbus_proxy_get_name;
  char* function(GDBusProxy* proxy) c_g_dbus_proxy_get_name_owner;
  const(char)* function(GDBusProxy* proxy) c_g_dbus_proxy_get_object_path;
  void function(GDBusProxy* proxy, const(char)* propertyName, GVariant* value) c_g_dbus_proxy_set_cached_property;
  void function(GDBusProxy* proxy, int timeoutMsec) c_g_dbus_proxy_set_default_timeout;
  void function(GDBusProxy* proxy, GDBusInterfaceInfo* info) c_g_dbus_proxy_set_interface_info;

  // DBusServer
  GType function() c_g_dbus_server_get_type;
  GDBusServer* function(const(char)* address, GDBusServerFlags flags, const(char)* guid, GDBusAuthObserver* observer, GCancellable* cancellable, GError** _err) c_g_dbus_server_new_sync;
  const(char)* function(GDBusServer* server) c_g_dbus_server_get_client_address;
  GDBusServerFlags function(GDBusServer* server) c_g_dbus_server_get_flags;
  const(char)* function(GDBusServer* server) c_g_dbus_server_get_guid;
  bool function(GDBusServer* server) c_g_dbus_server_is_active;
  void function(GDBusServer* server) c_g_dbus_server_start;
  void function(GDBusServer* server) c_g_dbus_server_stop;

  // DBusSignalInfo
  GType function() c_g_dbus_signal_info_get_type;
  GDBusSignalInfo* function(GDBusSignalInfo* info) c_g_dbus_signal_info_ref;
  void function(GDBusSignalInfo* info) c_g_dbus_signal_info_unref;

  // DataInputStream
  GType function() c_g_data_input_stream_get_type;
  GDataInputStream* function(GInputStream* baseStream) c_g_data_input_stream_new;
  GDataStreamByteOrder function(GDataInputStream* stream) c_g_data_input_stream_get_byte_order;
  GDataStreamNewlineType function(GDataInputStream* stream) c_g_data_input_stream_get_newline_type;
  ubyte function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_byte;
  short function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_int16;
  int function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_int32;
  long function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_int64;
  char* function(GDataInputStream* stream, size_t* length, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_line;
  void function(GDataInputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_data_input_stream_read_line_async;
  char* function(GDataInputStream* stream, GAsyncResult* result, size_t* length, GError** _err) c_g_data_input_stream_read_line_finish;
  char* function(GDataInputStream* stream, GAsyncResult* result, size_t* length, GError** _err) c_g_data_input_stream_read_line_finish_utf8;
  char* function(GDataInputStream* stream, size_t* length, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_line_utf8;
  ushort function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_uint16;
  uint function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_uint32;
  ulong function(GDataInputStream* stream, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_uint64;
  char* function(GDataInputStream* stream, const(char)* stopChars, size_t* length, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_until;
  void function(GDataInputStream* stream, const(char)* stopChars, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_data_input_stream_read_until_async;
  char* function(GDataInputStream* stream, GAsyncResult* result, size_t* length, GError** _err) c_g_data_input_stream_read_until_finish;
  char* function(GDataInputStream* stream, const(char)* stopChars, ptrdiff_t stopCharsLen, size_t* length, GCancellable* cancellable, GError** _err) c_g_data_input_stream_read_upto;
  void function(GDataInputStream* stream, const(char)* stopChars, ptrdiff_t stopCharsLen, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_data_input_stream_read_upto_async;
  char* function(GDataInputStream* stream, GAsyncResult* result, size_t* length, GError** _err) c_g_data_input_stream_read_upto_finish;
  void function(GDataInputStream* stream, GDataStreamByteOrder order) c_g_data_input_stream_set_byte_order;
  void function(GDataInputStream* stream, GDataStreamNewlineType type) c_g_data_input_stream_set_newline_type;

  // DataOutputStream
  GType function() c_g_data_output_stream_get_type;
  GDataOutputStream* function(GOutputStream* baseStream) c_g_data_output_stream_new;
  GDataStreamByteOrder function(GDataOutputStream* stream) c_g_data_output_stream_get_byte_order;
  bool function(GDataOutputStream* stream, ubyte data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_byte;
  bool function(GDataOutputStream* stream, short data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_int16;
  bool function(GDataOutputStream* stream, int data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_int32;
  bool function(GDataOutputStream* stream, long data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_int64;
  bool function(GDataOutputStream* stream, const(char)* str, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_string;
  bool function(GDataOutputStream* stream, ushort data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_uint16;
  bool function(GDataOutputStream* stream, uint data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_uint32;
  bool function(GDataOutputStream* stream, ulong data, GCancellable* cancellable, GError** _err) c_g_data_output_stream_put_uint64;
  void function(GDataOutputStream* stream, GDataStreamByteOrder order) c_g_data_output_stream_set_byte_order;

  // DatagramBased
  GType function() c_g_datagram_based_get_type;
  GIOCondition function(GDatagramBased* datagramBased, GIOCondition condition) c_g_datagram_based_condition_check;
  bool function(GDatagramBased* datagramBased, GIOCondition condition, long timeout, GCancellable* cancellable, GError** _err) c_g_datagram_based_condition_wait;
  GSource* function(GDatagramBased* datagramBased, GIOCondition condition, GCancellable* cancellable) c_g_datagram_based_create_source;
  int function(GDatagramBased* datagramBased, GInputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err) c_g_datagram_based_receive_messages;
  int function(GDatagramBased* datagramBased, GOutputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err) c_g_datagram_based_send_messages;

  // DebugController
  GType function() c_g_debug_controller_get_type;
  bool function(GDebugController* self) c_g_debug_controller_get_debug_enabled;
  void function(GDebugController* self, bool debugEnabled) c_g_debug_controller_set_debug_enabled;

  // DebugControllerDBus
  GType function() c_g_debug_controller_dbus_get_type;
  GDebugControllerDBus* function(GDBusConnection* connection, GCancellable* cancellable, GError** _err) c_g_debug_controller_dbus_new;
  void function(GDebugControllerDBus* self) c_g_debug_controller_dbus_stop;

  // DesktopAppInfo
  GType function() c_g_desktop_app_info_get_type;
  GDesktopAppInfo* function(const(char)* desktopId) c_g_desktop_app_info_new;
  GDesktopAppInfo* function(const(char)* filename) c_g_desktop_app_info_new_from_filename;
  GDesktopAppInfo* function(GKeyFile* keyFile) c_g_desktop_app_info_new_from_keyfile;
  GList* function(const(char)* interface_) c_g_desktop_app_info_get_implementations;
  char*** function(const(char)* searchString) c_g_desktop_app_info_search;
  void function(const(char)* desktopEnv) c_g_desktop_app_info_set_desktop_env;
  char* function(GDesktopAppInfo* info, const(char)* actionName) c_g_desktop_app_info_get_action_name;
  bool function(GDesktopAppInfo* info, const(char)* key) c_g_desktop_app_info_get_boolean;
  const(char)* function(GDesktopAppInfo* info) c_g_desktop_app_info_get_categories;
  const(char)* function(GDesktopAppInfo* info) c_g_desktop_app_info_get_filename;
  const(char)* function(GDesktopAppInfo* info) c_g_desktop_app_info_get_generic_name;
  bool function(GDesktopAppInfo* info) c_g_desktop_app_info_get_is_hidden;
  const(char*)* function(GDesktopAppInfo* info) c_g_desktop_app_info_get_keywords;
  char* function(GDesktopAppInfo* info, const(char)* key) c_g_desktop_app_info_get_locale_string;
  bool function(GDesktopAppInfo* info) c_g_desktop_app_info_get_nodisplay;
  bool function(GDesktopAppInfo* info, const(char)* desktopEnv) c_g_desktop_app_info_get_show_in;
  const(char)* function(GDesktopAppInfo* info) c_g_desktop_app_info_get_startup_wm_class;
  char* function(GDesktopAppInfo* info, const(char)* key) c_g_desktop_app_info_get_string;
  char** function(GDesktopAppInfo* info, const(char)* key, size_t* length) c_g_desktop_app_info_get_string_list;
  bool function(GDesktopAppInfo* info, const(char)* key) c_g_desktop_app_info_has_key;
  void function(GDesktopAppInfo* info, const(char)* actionName, GAppLaunchContext* launchContext) c_g_desktop_app_info_launch_action;
  bool function(GDesktopAppInfo* appinfo, GList* uris, GAppLaunchContext* launchContext, GSpawnFlags spawnFlags, GSpawnChildSetupFunc userSetup, void* userSetupData, GDesktopAppLaunchCallback pidCallback, void* pidCallbackData, GError** _err) c_g_desktop_app_info_launch_uris_as_manager;
  bool function(GDesktopAppInfo* appinfo, GList* uris, GAppLaunchContext* launchContext, GSpawnFlags spawnFlags, GSpawnChildSetupFunc userSetup, void* userSetupData, GDesktopAppLaunchCallback pidCallback, void* pidCallbackData, int stdinFd, int stdoutFd, int stderrFd, GError** _err) c_g_desktop_app_info_launch_uris_as_manager_with_fds;
  const(char*)* function(GDesktopAppInfo* info) c_g_desktop_app_info_list_actions;

  // DesktopAppInfoLookup
  GType function() c_g_desktop_app_info_lookup_get_type;
  GAppInfo* function(GDesktopAppInfoLookup* lookup, const(char)* uriScheme) c_g_desktop_app_info_lookup_get_default_for_uri_scheme;

  // Drive
  GType function() c_g_drive_get_type;
  bool function(GDrive* drive) c_g_drive_can_eject;
  bool function(GDrive* drive) c_g_drive_can_poll_for_media;
  bool function(GDrive* drive) c_g_drive_can_start;
  bool function(GDrive* drive) c_g_drive_can_start_degraded;
  bool function(GDrive* drive) c_g_drive_can_stop;
  void function(GDrive* drive, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_drive_eject;
  bool function(GDrive* drive, GAsyncResult* result, GError** _err) c_g_drive_eject_finish;
  void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_drive_eject_with_operation;
  bool function(GDrive* drive, GAsyncResult* result, GError** _err) c_g_drive_eject_with_operation_finish;
  char** function(GDrive* drive) c_g_drive_enumerate_identifiers;
  GIcon* function(GDrive* drive) c_g_drive_get_icon;
  char* function(GDrive* drive, const(char)* kind) c_g_drive_get_identifier;
  char* function(GDrive* drive) c_g_drive_get_name;
  const(char)* function(GDrive* drive) c_g_drive_get_sort_key;
  GDriveStartStopType function(GDrive* drive) c_g_drive_get_start_stop_type;
  GIcon* function(GDrive* drive) c_g_drive_get_symbolic_icon;
  GList* function(GDrive* drive) c_g_drive_get_volumes;
  bool function(GDrive* drive) c_g_drive_has_media;
  bool function(GDrive* drive) c_g_drive_has_volumes;
  bool function(GDrive* drive) c_g_drive_is_media_check_automatic;
  bool function(GDrive* drive) c_g_drive_is_media_removable;
  bool function(GDrive* drive) c_g_drive_is_removable;
  void function(GDrive* drive, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_drive_poll_for_media;
  bool function(GDrive* drive, GAsyncResult* result, GError** _err) c_g_drive_poll_for_media_finish;
  void function(GDrive* drive, GDriveStartFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_drive_start;
  bool function(GDrive* drive, GAsyncResult* result, GError** _err) c_g_drive_start_finish;
  void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_drive_stop;
  bool function(GDrive* drive, GAsyncResult* result, GError** _err) c_g_drive_stop_finish;

  // DtlsClientConnection
  GType function() c_g_dtls_client_connection_get_type;
  GDatagramBased* function(GDatagramBased* baseSocket, GSocketConnectable* serverIdentity, GError** _err) c_g_dtls_client_connection_new;
  GList* function(GDtlsClientConnection* conn) c_g_dtls_client_connection_get_accepted_cas;
  GSocketConnectable* function(GDtlsClientConnection* conn) c_g_dtls_client_connection_get_server_identity;
  GTlsCertificateFlags function(GDtlsClientConnection* conn) c_g_dtls_client_connection_get_validation_flags;
  void function(GDtlsClientConnection* conn, GSocketConnectable* identity) c_g_dtls_client_connection_set_server_identity;
  void function(GDtlsClientConnection* conn, GTlsCertificateFlags flags) c_g_dtls_client_connection_set_validation_flags;

  // DtlsConnection
  GType function() c_g_dtls_connection_get_type;
  bool function(GDtlsConnection* conn, GCancellable* cancellable, GError** _err) c_g_dtls_connection_close;
  void function(GDtlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dtls_connection_close_async;
  bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err) c_g_dtls_connection_close_finish;
  bool function(GDtlsConnection* conn, GTlsCertificate* peerCert, GTlsCertificateFlags errors) c_g_dtls_connection_emit_accept_certificate;
  GTlsCertificate* function(GDtlsConnection* conn) c_g_dtls_connection_get_certificate;
  bool function(GDtlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err) c_g_dtls_connection_get_channel_binding_data;
  char* function(GDtlsConnection* conn) c_g_dtls_connection_get_ciphersuite_name;
  GTlsDatabase* function(GDtlsConnection* conn) c_g_dtls_connection_get_database;
  GTlsInteraction* function(GDtlsConnection* conn) c_g_dtls_connection_get_interaction;
  const(char)* function(GDtlsConnection* conn) c_g_dtls_connection_get_negotiated_protocol;
  GTlsCertificate* function(GDtlsConnection* conn) c_g_dtls_connection_get_peer_certificate;
  GTlsCertificateFlags function(GDtlsConnection* conn) c_g_dtls_connection_get_peer_certificate_errors;
  GTlsProtocolVersion function(GDtlsConnection* conn) c_g_dtls_connection_get_protocol_version;
  GTlsRehandshakeMode function(GDtlsConnection* conn) c_g_dtls_connection_get_rehandshake_mode;
  bool function(GDtlsConnection* conn) c_g_dtls_connection_get_require_close_notify;
  bool function(GDtlsConnection* conn, GCancellable* cancellable, GError** _err) c_g_dtls_connection_handshake;
  void function(GDtlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dtls_connection_handshake_async;
  bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err) c_g_dtls_connection_handshake_finish;
  void function(GDtlsConnection* conn, const(char*)* protocols) c_g_dtls_connection_set_advertised_protocols;
  void function(GDtlsConnection* conn, GTlsCertificate* certificate) c_g_dtls_connection_set_certificate;
  void function(GDtlsConnection* conn, GTlsDatabase* database) c_g_dtls_connection_set_database;
  void function(GDtlsConnection* conn, GTlsInteraction* interaction) c_g_dtls_connection_set_interaction;
  void function(GDtlsConnection* conn, GTlsRehandshakeMode mode) c_g_dtls_connection_set_rehandshake_mode;
  void function(GDtlsConnection* conn, bool requireCloseNotify) c_g_dtls_connection_set_require_close_notify;
  bool function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, GCancellable* cancellable, GError** _err) c_g_dtls_connection_shutdown;
  void function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dtls_connection_shutdown_async;
  bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err) c_g_dtls_connection_shutdown_finish;

  // DtlsServerConnection
  GType function() c_g_dtls_server_connection_get_type;
  GDatagramBased* function(GDatagramBased* baseSocket, GTlsCertificate* certificate, GError** _err) c_g_dtls_server_connection_new;

  // Emblem
  GType function() c_g_emblem_get_type;
  GEmblem* function(GIcon* icon) c_g_emblem_new;
  GEmblem* function(GIcon* icon, GEmblemOrigin origin) c_g_emblem_new_with_origin;
  GIcon* function(GEmblem* emblem) c_g_emblem_get_icon;
  GEmblemOrigin function(GEmblem* emblem) c_g_emblem_get_origin;

  // EmblemedIcon
  GType function() c_g_emblemed_icon_get_type;
  GIcon* function(GIcon* icon, GEmblem* emblem) c_g_emblemed_icon_new;
  void function(GEmblemedIcon* emblemed, GEmblem* emblem) c_g_emblemed_icon_add_emblem;
  void function(GEmblemedIcon* emblemed) c_g_emblemed_icon_clear_emblems;
  GList* function(GEmblemedIcon* emblemed) c_g_emblemed_icon_get_emblems;
  GIcon* function(GEmblemedIcon* emblemed) c_g_emblemed_icon_get_icon;

  // File
  GType function() c_g_file_get_type;
  GFile* function(const(char)* firstElement,  ...) c_g_file_new_build_filename;
  GFile* function(const(char*)* args) c_g_file_new_build_filenamev;
  GFile* function(const(char)* arg) c_g_file_new_for_commandline_arg;
  GFile* function(const(char)* arg, const(char)* cwd) c_g_file_new_for_commandline_arg_and_cwd;
  GFile* function(const(char)* path) c_g_file_new_for_path;
  GFile* function(const(char)* uri) c_g_file_new_for_uri;
  GFile* function(const(char)* tmpl, GFileIOStream** iostream, GError** _err) c_g_file_new_tmp;
  void function(const(char)* tmpl, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_new_tmp_async;
  void function(const(char)* tmpl, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_new_tmp_dir_async;
  GFile* function(GAsyncResult* result, GError** _err) c_g_file_new_tmp_dir_finish;
  GFile* function(GAsyncResult* result, GFileIOStream** iostream, GError** _err) c_g_file_new_tmp_finish;
  GFile* function(const(char)* parseName) c_g_file_parse_name;
  GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) c_g_file_append_to;
  void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_append_to_async;
  GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_append_to_finish;
  char* function(GFile* file, GFileCopyFlags flags, GCancellable* cancellable, GError** _err) c_g_file_build_attribute_list_for_copy;
  bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err) c_g_file_copy;
  void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData) c_g_file_copy_async;
  bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GError** _err) c_g_file_copy_attributes;
  bool function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_copy_finish;
  GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) c_g_file_create;
  void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_create_async;
  GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_create_finish;
  GFileIOStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) c_g_file_create_readwrite;
  void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_create_readwrite_async;
  GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_create_readwrite_finish;
  bool function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_delete;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_delete_async;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_delete_finish;
  GFile* function(GFile* file) c_g_file_dup;
  void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_eject_mountable;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_eject_mountable_finish;
  void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_eject_mountable_with_operation;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_eject_mountable_with_operation_finish;
  GFileEnumerator* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_enumerate_children;
  void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_enumerate_children_async;
  GFileEnumerator* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_enumerate_children_finish;
  bool function(GFile* file1, GFile* file2) c_g_file_equal;
  GMount* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_find_enclosing_mount;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_find_enclosing_mount_async;
  GMount* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_find_enclosing_mount_finish;
  char* function(GFile* file) c_g_file_get_basename;
  GFile* function(GFile* file, const(char)* name) c_g_file_get_child;
  GFile* function(GFile* file, const(char)* displayName, GError** _err) c_g_file_get_child_for_display_name;
  GFile* function(GFile* file) c_g_file_get_parent;
  char* function(GFile* file) c_g_file_get_parse_name;
  char* function(GFile* file) c_g_file_get_path;
  char* function(GFile* parent, GFile* descendant) c_g_file_get_relative_path;
  char* function(GFile* file) c_g_file_get_uri;
  char* function(GFile* file) c_g_file_get_uri_scheme;
  bool function(GFile* file, GFile* parent) c_g_file_has_parent;
  bool function(GFile* file, GFile* prefix) c_g_file_has_prefix;
  bool function(GFile* file, const(char)* uriScheme) c_g_file_has_uri_scheme;
  uint function(GFile* file) c_g_file_hash;
  bool function(GFile* file) c_g_file_is_native;
  GBytes* function(GFile* file, GCancellable* cancellable, char** etagOut, GError** _err) c_g_file_load_bytes;
  void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_load_bytes_async;
  GBytes* function(GFile* file, GAsyncResult* result, char** etagOut, GError** _err) c_g_file_load_bytes_finish;
  bool function(GFile* file, GCancellable* cancellable, ubyte** contents, size_t* length, char** etagOut, GError** _err) c_g_file_load_contents;
  void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_load_contents_async;
  bool function(GFile* file, GAsyncResult* res, ubyte** contents, size_t* length, char** etagOut, GError** _err) c_g_file_load_contents_finish;
  void function(GFile* file, GCancellable* cancellable, GFileReadMoreCallback readMoreCallback, GAsyncReadyCallback callback, void* userData) c_g_file_load_partial_contents_async;
  bool function(GFile* file, GAsyncResult* res, ubyte** contents, size_t* length, char** etagOut, GError** _err) c_g_file_load_partial_contents_finish;
  bool function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_make_directory;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_make_directory_async;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_make_directory_finish;
  bool function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_make_directory_with_parents;
  bool function(GFile* file, const(char)* symlinkValue, GCancellable* cancellable, GError** _err) c_g_file_make_symbolic_link;
  void function(GFile* file, const(char)* symlinkValue, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_make_symbolic_link_async;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_make_symbolic_link_finish;
  bool function(GFile* file, GFileMeasureFlags flags, GCancellable* cancellable, GFileMeasureProgressCallback progressCallback, void* progressData, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err) c_g_file_measure_disk_usage;
  void function(GFile* file, GFileMeasureFlags flags, int ioPriority, GCancellable* cancellable, GFileMeasureProgressCallback progressCallback, void* progressData, GAsyncReadyCallback callback, void* userData) c_g_file_measure_disk_usage_async;
  bool function(GFile* file, GAsyncResult* result, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err) c_g_file_measure_disk_usage_finish;
  GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err) c_g_file_monitor;
  GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err) c_g_file_monitor_directory;
  GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err) c_g_file_monitor_file;
  void function(GFile* location, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_mount_enclosing_volume;
  bool function(GFile* location, GAsyncResult* result, GError** _err) c_g_file_mount_enclosing_volume_finish;
  void function(GFile* file, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_mount_mountable;
  GFile* function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_mount_mountable_finish;
  bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err) c_g_file_move;
  void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData) c_g_file_move_async;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_move_finish;
  GFileIOStream* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_open_readwrite;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_open_readwrite_async;
  GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_open_readwrite_finish;
  const(char)* function(GFile* file) c_g_file_peek_path;
  void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_poll_mountable;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_poll_mountable_finish;
  GAppInfo* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_query_default_handler;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_query_default_handler_async;
  GAppInfo* function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_query_default_handler_finish;
  bool function(GFile* file, GCancellable* cancellable) c_g_file_query_exists;
  GFileType function(GFile* file, GFileQueryInfoFlags flags, GCancellable* cancellable) c_g_file_query_file_type;
  GFileInfo* function(GFile* file, const(char)* attributes, GCancellable* cancellable, GError** _err) c_g_file_query_filesystem_info;
  void function(GFile* file, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_query_filesystem_info_async;
  GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_query_filesystem_info_finish;
  GFileInfo* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_query_info;
  void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_query_info_async;
  GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_query_info_finish;
  GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_query_settable_attributes;
  GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_query_writable_namespaces;
  GFileInputStream* function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_read;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_read_async;
  GFileInputStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_read_finish;
  GFileOutputStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) c_g_file_replace;
  void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_replace_async;
  bool function(GFile* file, const(ubyte)* contents, size_t length, const(char)* etag, bool makeBackup, GFileCreateFlags flags, char** newEtag, GCancellable* cancellable, GError** _err) c_g_file_replace_contents;
  void function(GFile* file, const(ubyte)* contents, size_t length, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_replace_contents_async;
  void function(GFile* file, GBytes* contents, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_replace_contents_bytes_async;
  bool function(GFile* file, GAsyncResult* res, char** newEtag, GError** _err) c_g_file_replace_contents_finish;
  GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_replace_finish;
  GFileIOStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) c_g_file_replace_readwrite;
  void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_replace_readwrite_async;
  GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_replace_readwrite_finish;
  GFile* function(GFile* file, const(char)* relativePath) c_g_file_resolve_relative_path;
  bool function(GFile* file, const(char)* attribute, GFileAttributeType type, void* valueP, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute;
  bool function(GFile* file, const(char)* attribute, const(char)* value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_byte_string;
  bool function(GFile* file, const(char)* attribute, int value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_int32;
  bool function(GFile* file, const(char)* attribute, long value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_int64;
  bool function(GFile* file, const(char)* attribute, const(char)* value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_string;
  bool function(GFile* file, const(char)* attribute, uint value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_uint32;
  bool function(GFile* file, const(char)* attribute, ulong value, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attribute_uint64;
  void function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_set_attributes_async;
  bool function(GFile* file, GAsyncResult* result, GFileInfo** info, GError** _err) c_g_file_set_attributes_finish;
  bool function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) c_g_file_set_attributes_from_info;
  GFile* function(GFile* file, const(char)* displayName, GCancellable* cancellable, GError** _err) c_g_file_set_display_name;
  void function(GFile* file, const(char)* displayName, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_set_display_name_async;
  GFile* function(GFile* file, GAsyncResult* res, GError** _err) c_g_file_set_display_name_finish;
  void function(GFile* file, GDriveStartFlags flags, GMountOperation* startOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_start_mountable;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_start_mountable_finish;
  void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_stop_mountable;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_stop_mountable_finish;
  bool function(GFile* file) c_g_file_supports_thread_contexts;
  bool function(GFile* file, GCancellable* cancellable, GError** _err) c_g_file_trash;
  void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_trash_async;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_trash_finish;
  void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_unmount_mountable;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_unmount_mountable_finish;
  void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_unmount_mountable_with_operation;
  bool function(GFile* file, GAsyncResult* result, GError** _err) c_g_file_unmount_mountable_with_operation_finish;

  // FileAttributeInfoList
  GType function() c_g_file_attribute_info_list_get_type;
  GFileAttributeInfoList* function() c_g_file_attribute_info_list_new;
  void function(GFileAttributeInfoList* list, const(char)* name, GFileAttributeType type, GFileAttributeInfoFlags flags) c_g_file_attribute_info_list_add;
  GFileAttributeInfoList* function(GFileAttributeInfoList* list) c_g_file_attribute_info_list_dup;
  const(GFileAttributeInfo)* function(GFileAttributeInfoList* list, const(char)* name) c_g_file_attribute_info_list_lookup;
  GFileAttributeInfoList* function(GFileAttributeInfoList* list) c_g_file_attribute_info_list_ref;
  void function(GFileAttributeInfoList* list) c_g_file_attribute_info_list_unref;

  // FileAttributeMatcher
  GType function() c_g_file_attribute_matcher_get_type;
  GFileAttributeMatcher* function(const(char)* attributes) c_g_file_attribute_matcher_new;
  bool function(GFileAttributeMatcher* matcher, const(char)* ns) c_g_file_attribute_matcher_enumerate_namespace;
  const(char)* function(GFileAttributeMatcher* matcher) c_g_file_attribute_matcher_enumerate_next;
  bool function(GFileAttributeMatcher* matcher, const(char)* attribute) c_g_file_attribute_matcher_matches;
  bool function(GFileAttributeMatcher* matcher, const(char)* attribute) c_g_file_attribute_matcher_matches_only;
  GFileAttributeMatcher* function(GFileAttributeMatcher* matcher) c_g_file_attribute_matcher_ref;
  GFileAttributeMatcher* function(GFileAttributeMatcher* matcher, GFileAttributeMatcher* subtract) c_g_file_attribute_matcher_subtract;
  char* function(GFileAttributeMatcher* matcher) c_g_file_attribute_matcher_to_string;
  void function(GFileAttributeMatcher* matcher) c_g_file_attribute_matcher_unref;

  // FileDescriptorBased
  GType function() c_g_file_descriptor_based_get_type;
  int function(GFileDescriptorBased* fdBased) c_g_file_descriptor_based_get_fd;

  // FileEnumerator
  GType function() c_g_file_enumerator_get_type;
  bool function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err) c_g_file_enumerator_close;
  void function(GFileEnumerator* enumerator, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_enumerator_close_async;
  bool function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err) c_g_file_enumerator_close_finish;
  GFile* function(GFileEnumerator* enumerator, GFileInfo* info) c_g_file_enumerator_get_child;
  GFile* function(GFileEnumerator* enumerator) c_g_file_enumerator_get_container;
  bool function(GFileEnumerator* enumerator) c_g_file_enumerator_has_pending;
  bool function(GFileEnumerator* enumerator) c_g_file_enumerator_is_closed;
  bool function(GFileEnumerator* direnum, GFileInfo** outInfo, GFile** outChild, GCancellable* cancellable, GError** _err) c_g_file_enumerator_iterate;
  GFileInfo* function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err) c_g_file_enumerator_next_file;
  void function(GFileEnumerator* enumerator, int numFiles, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_enumerator_next_files_async;
  GList* function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err) c_g_file_enumerator_next_files_finish;
  void function(GFileEnumerator* enumerator, bool pending) c_g_file_enumerator_set_pending;

  // FileIOStream
  GType function() c_g_file_io_stream_get_type;
  char* function(GFileIOStream* stream) c_g_file_io_stream_get_etag;
  GFileInfo* function(GFileIOStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) c_g_file_io_stream_query_info;
  void function(GFileIOStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_io_stream_query_info_async;
  GFileInfo* function(GFileIOStream* stream, GAsyncResult* result, GError** _err) c_g_file_io_stream_query_info_finish;

  // FileIcon
  GType function() c_g_file_icon_get_type;
  GIcon* function(GFile* file) c_g_file_icon_new;
  GFile* function(GFileIcon* icon) c_g_file_icon_get_file;

  // FileInfo
  GType function() c_g_file_info_get_type;
  GFileInfo* function() c_g_file_info_new;
  void function(GFileInfo* info) c_g_file_info_clear_status;
  void function(GFileInfo* srcInfo, GFileInfo* destInfo) c_g_file_info_copy_into;
  GFileInfo* function(GFileInfo* other) c_g_file_info_dup;
  GDateTime* function(GFileInfo* info) c_g_file_info_get_access_date_time;
  char* function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_as_string;
  bool function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_boolean;
  const(char)* function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_byte_string;
  bool function(GFileInfo* info, const(char)* attribute, GFileAttributeType* type, void** valuePp, GFileAttributeStatus* status) c_g_file_info_get_attribute_data;
  const(char)* function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_file_path;
  int function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_int32;
  long function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_int64;
  ObjectC* function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_object;
  GFileAttributeStatus function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_status;
  const(char)* function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_string;
  char** function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_stringv;
  GFileAttributeType function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_type;
  uint function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_uint32;
  ulong function(GFileInfo* info, const(char)* attribute) c_g_file_info_get_attribute_uint64;
  const(char)* function(GFileInfo* info) c_g_file_info_get_content_type;
  GDateTime* function(GFileInfo* info) c_g_file_info_get_creation_date_time;
  GDateTime* function(GFileInfo* info) c_g_file_info_get_deletion_date;
  const(char)* function(GFileInfo* info) c_g_file_info_get_display_name;
  const(char)* function(GFileInfo* info) c_g_file_info_get_edit_name;
  const(char)* function(GFileInfo* info) c_g_file_info_get_etag;
  GFileType function(GFileInfo* info) c_g_file_info_get_file_type;
  GIcon* function(GFileInfo* info) c_g_file_info_get_icon;
  bool function(GFileInfo* info) c_g_file_info_get_is_backup;
  bool function(GFileInfo* info) c_g_file_info_get_is_hidden;
  bool function(GFileInfo* info) c_g_file_info_get_is_symlink;
  GDateTime* function(GFileInfo* info) c_g_file_info_get_modification_date_time;
  void function(GFileInfo* info, GTimeVal* result) c_g_file_info_get_modification_time;
  const(char)* function(GFileInfo* info) c_g_file_info_get_name;
  long function(GFileInfo* info) c_g_file_info_get_size;
  int function(GFileInfo* info) c_g_file_info_get_sort_order;
  GIcon* function(GFileInfo* info) c_g_file_info_get_symbolic_icon;
  const(char)* function(GFileInfo* info) c_g_file_info_get_symlink_target;
  bool function(GFileInfo* info, const(char)* attribute) c_g_file_info_has_attribute;
  bool function(GFileInfo* info, const(char)* nameSpace) c_g_file_info_has_namespace;
  char** function(GFileInfo* info, const(char)* nameSpace) c_g_file_info_list_attributes;
  void function(GFileInfo* info, const(char)* attribute) c_g_file_info_remove_attribute;
  void function(GFileInfo* info, GDateTime* atime) c_g_file_info_set_access_date_time;
  void function(GFileInfo* info, const(char)* attribute, GFileAttributeType type, void* valueP) c_g_file_info_set_attribute;
  void function(GFileInfo* info, const(char)* attribute, bool attrValue) c_g_file_info_set_attribute_boolean;
  void function(GFileInfo* info, const(char)* attribute, const(char)* attrValue) c_g_file_info_set_attribute_byte_string;
  void function(GFileInfo* info, const(char)* attribute, const(char)* attrValue) c_g_file_info_set_attribute_file_path;
  void function(GFileInfo* info, const(char)* attribute, int attrValue) c_g_file_info_set_attribute_int32;
  void function(GFileInfo* info, const(char)* attribute, long attrValue) c_g_file_info_set_attribute_int64;
  void function(GFileInfo* info, GFileAttributeMatcher* mask) c_g_file_info_set_attribute_mask;
  void function(GFileInfo* info, const(char)* attribute, ObjectC* attrValue) c_g_file_info_set_attribute_object;
  bool function(GFileInfo* info, const(char)* attribute, GFileAttributeStatus status) c_g_file_info_set_attribute_status;
  void function(GFileInfo* info, const(char)* attribute, const(char)* attrValue) c_g_file_info_set_attribute_string;
  void function(GFileInfo* info, const(char)* attribute, char** attrValue) c_g_file_info_set_attribute_stringv;
  void function(GFileInfo* info, const(char)* attribute, uint attrValue) c_g_file_info_set_attribute_uint32;
  void function(GFileInfo* info, const(char)* attribute, ulong attrValue) c_g_file_info_set_attribute_uint64;
  void function(GFileInfo* info, const(char)* contentType) c_g_file_info_set_content_type;
  void function(GFileInfo* info, GDateTime* creationTime) c_g_file_info_set_creation_date_time;
  void function(GFileInfo* info, const(char)* displayName) c_g_file_info_set_display_name;
  void function(GFileInfo* info, const(char)* editName) c_g_file_info_set_edit_name;
  void function(GFileInfo* info, GFileType type) c_g_file_info_set_file_type;
  void function(GFileInfo* info, GIcon* icon) c_g_file_info_set_icon;
  void function(GFileInfo* info, bool isHidden) c_g_file_info_set_is_hidden;
  void function(GFileInfo* info, bool isSymlink) c_g_file_info_set_is_symlink;
  void function(GFileInfo* info, GDateTime* mtime) c_g_file_info_set_modification_date_time;
  void function(GFileInfo* info, GTimeVal* mtime) c_g_file_info_set_modification_time;
  void function(GFileInfo* info, const(char)* name) c_g_file_info_set_name;
  void function(GFileInfo* info, long size) c_g_file_info_set_size;
  void function(GFileInfo* info, int sortOrder) c_g_file_info_set_sort_order;
  void function(GFileInfo* info, GIcon* icon) c_g_file_info_set_symbolic_icon;
  void function(GFileInfo* info, const(char)* symlinkTarget) c_g_file_info_set_symlink_target;
  void function(GFileInfo* info) c_g_file_info_unset_attribute_mask;

  // FileInputStream
  GType function() c_g_file_input_stream_get_type;
  GFileInfo* function(GFileInputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) c_g_file_input_stream_query_info;
  void function(GFileInputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_input_stream_query_info_async;
  GFileInfo* function(GFileInputStream* stream, GAsyncResult* result, GError** _err) c_g_file_input_stream_query_info_finish;

  // FileMonitor
  GType function() c_g_file_monitor_get_type;
  bool function(GFileMonitor* monitor) c_g_file_monitor_cancel;
  void function(GFileMonitor* monitor, GFile* child, GFile* otherFile, GFileMonitorEvent eventType) c_g_file_monitor_emit_event;
  bool function(GFileMonitor* monitor) c_g_file_monitor_is_cancelled;
  void function(GFileMonitor* monitor, int limitMsecs) c_g_file_monitor_set_rate_limit;

  // FileOutputStream
  GType function() c_g_file_output_stream_get_type;
  char* function(GFileOutputStream* stream) c_g_file_output_stream_get_etag;
  GFileInfo* function(GFileOutputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) c_g_file_output_stream_query_info;
  void function(GFileOutputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_file_output_stream_query_info_async;
  GFileInfo* function(GFileOutputStream* stream, GAsyncResult* result, GError** _err) c_g_file_output_stream_query_info_finish;

  // FilenameCompleter
  GType function() c_g_filename_completer_get_type;
  GFilenameCompleter* function() c_g_filename_completer_new;
  char* function(GFilenameCompleter* completer, const(char)* initialText) c_g_filename_completer_get_completion_suffix;
  char** function(GFilenameCompleter* completer, const(char)* initialText) c_g_filename_completer_get_completions;
  void function(GFilenameCompleter* completer, bool dirsOnly) c_g_filename_completer_set_dirs_only;

  // FilterInputStream
  GType function() c_g_filter_input_stream_get_type;
  GInputStream* function(GFilterInputStream* stream) c_g_filter_input_stream_get_base_stream;
  bool function(GFilterInputStream* stream) c_g_filter_input_stream_get_close_base_stream;
  void function(GFilterInputStream* stream, bool closeBase) c_g_filter_input_stream_set_close_base_stream;

  // FilterOutputStream
  GType function() c_g_filter_output_stream_get_type;
  GOutputStream* function(GFilterOutputStream* stream) c_g_filter_output_stream_get_base_stream;
  bool function(GFilterOutputStream* stream) c_g_filter_output_stream_get_close_base_stream;
  void function(GFilterOutputStream* stream, bool closeBase) c_g_filter_output_stream_set_close_base_stream;

  // Global
  void function(GBusType busType, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_bus_get;
  GDBusConnection* function(GAsyncResult* res, GError** _err) c_g_bus_get_finish;
  GDBusConnection* function(GBusType busType, GCancellable* cancellable, GError** _err) c_g_bus_get_sync;
  uint function(GBusType busType, const(char)* name, GBusNameOwnerFlags flags, GBusAcquiredCallback busAcquiredHandler, GBusNameAcquiredCallback nameAcquiredHandler, GBusNameLostCallback nameLostHandler, void* userData, GDestroyNotify userDataFreeFunc) c_g_bus_own_name;
  uint function(GDBusConnection* connection, const(char)* name, GBusNameOwnerFlags flags, GBusNameAcquiredCallback nameAcquiredHandler, GBusNameLostCallback nameLostHandler, void* userData, GDestroyNotify userDataFreeFunc) c_g_bus_own_name_on_connection;
  uint function(GDBusConnection* connection, const(char)* name, GBusNameOwnerFlags flags, GClosure* nameAcquiredClosure, GClosure* nameLostClosure) c_g_bus_own_name_on_connection_with_closures;
  uint function(GBusType busType, const(char)* name, GBusNameOwnerFlags flags, GClosure* busAcquiredClosure, GClosure* nameAcquiredClosure, GClosure* nameLostClosure) c_g_bus_own_name_with_closures;
  void function(uint ownerId) c_g_bus_unown_name;
  void function(uint watcherId) c_g_bus_unwatch_name;
  uint function(GBusType busType, const(char)* name, GBusNameWatcherFlags flags, GBusNameAppearedCallback nameAppearedHandler, GBusNameVanishedCallback nameVanishedHandler, void* userData, GDestroyNotify userDataFreeFunc) c_g_bus_watch_name;
  uint function(GDBusConnection* connection, const(char)* name, GBusNameWatcherFlags flags, GBusNameAppearedCallback nameAppearedHandler, GBusNameVanishedCallback nameVanishedHandler, void* userData, GDestroyNotify userDataFreeFunc) c_g_bus_watch_name_on_connection;
  uint function(GDBusConnection* connection, const(char)* name, GBusNameWatcherFlags flags, GClosure* nameAppearedClosure, GClosure* nameVanishedClosure) c_g_bus_watch_name_on_connection_with_closures;
  uint function(GBusType busType, const(char)* name, GBusNameWatcherFlags flags, GClosure* nameAppearedClosure, GClosure* nameVanishedClosure) c_g_bus_watch_name_with_closures;
  bool function(const(char)* type) c_g_content_type_can_be_executable;
  bool function(const(char)* type1, const(char)* type2) c_g_content_type_equals;
  char* function(const(char)* mimeType) c_g_content_type_from_mime_type;
  char* function(const(char)* type) c_g_content_type_get_description;
  char* function(const(char)* type) c_g_content_type_get_generic_icon_name;
  GIcon* function(const(char)* type) c_g_content_type_get_icon;
  const(char*)* function() c_g_content_type_get_mime_dirs;
  char* function(const(char)* type) c_g_content_type_get_mime_type;
  GIcon* function(const(char)* type) c_g_content_type_get_symbolic_icon;
  char* function(const(char)* filename, const(ubyte)* data, size_t dataSize, bool* resultUncertain) c_g_content_type_guess;
  char** function(GFile* root) c_g_content_type_guess_for_tree;
  bool function(const(char)* type, const(char)* supertype) c_g_content_type_is_a;
  bool function(const(char)* type, const(char)* mimeType) c_g_content_type_is_mime_type;
  bool function(const(char)* type) c_g_content_type_is_unknown;
  void function(const(char*)* dirs) c_g_content_type_set_mime_dirs;
  GList* function() c_g_content_types_get_registered;
  char* function(const(char)* string_) c_g_dbus_address_escape_value;
  char* function(GBusType busType, GCancellable* cancellable, GError** _err) c_g_dbus_address_get_for_bus_sync;
  void function(const(char)* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_dbus_address_get_stream;
  GIOStream* function(GAsyncResult* res, char** outGuid, GError** _err) c_g_dbus_address_get_stream_finish;
  GIOStream* function(const(char)* address, char** outGuid, GCancellable* cancellable, GError** _err) c_g_dbus_address_get_stream_sync;
  char* function(const(char)* s) c_g_dbus_escape_object_path;
  char* function(const(ubyte)* bytes) c_g_dbus_escape_object_path_bytestring;
  char* function() c_g_dbus_generate_guid;
  GVariant* function(const(GValue)* gvalue, const(GVariantType)* type) c_g_dbus_gvalue_to_gvariant;
  void function(GVariant* value, GValue* outGvalue) c_g_dbus_gvariant_to_gvalue;
  bool function(const(char)* string_) c_g_dbus_is_address;
  bool function(const(char)* string_) c_g_dbus_is_error_name;
  bool function(const(char)* string_) c_g_dbus_is_guid;
  bool function(const(char)* string_) c_g_dbus_is_interface_name;
  bool function(const(char)* string_) c_g_dbus_is_member_name;
  bool function(const(char)* string_) c_g_dbus_is_name;
  bool function(const(char)* string_, GError** _err) c_g_dbus_is_supported_address;
  bool function(const(char)* string_) c_g_dbus_is_unique_name;
  ubyte* function(const(char)* s) c_g_dbus_unescape_object_path;
  GIOErrorEnum function(int errNo) c_g_io_error_from_errno;
  GIOErrorEnum function(GFileError fileError) c_g_io_error_from_file_error;
  GQuark function() c_g_io_error_quark;
  GList* function(const(char)* dirname) c_g_io_modules_load_all_in_directory;
  GList* function(const(char)* dirname, GIOModuleScope* scope_) c_g_io_modules_load_all_in_directory_with_scope;
  void function(const(char)* dirname) c_g_io_modules_scan_all_in_directory;
  void function(const(char)* dirname, GIOModuleScope* scope_) c_g_io_modules_scan_all_in_directory_with_scope;
  void function() c_g_io_scheduler_cancel_all_jobs;
  void function(GIOSchedulerJobFunc jobFunc, void* userData, GDestroyNotify notify, int ioPriority, GCancellable* cancellable) c_g_io_scheduler_push_job;
  GSettingsBackend* function(const(char)* filename, const(char)* rootPath, const(char)* rootGroup) c_g_keyfile_settings_backend_new;
  GSettingsBackend* function() c_g_memory_settings_backend_new;
  void function() c_g_networking_init;
  GSettingsBackend* function() c_g_null_settings_backend_new;
  GSource* function(ObjectC* pollableStream) c_g_pollable_source_new;
  GSource* function(ObjectC* pollableStream, GSource* childSource, GCancellable* cancellable) c_g_pollable_source_new_full;
  ptrdiff_t function(GInputStream* stream, void* buffer, size_t count, bool blocking, GCancellable* cancellable, GError** _err) c_g_pollable_stream_read;
  ptrdiff_t function(GOutputStream* stream, void* buffer, size_t count, bool blocking, GCancellable* cancellable, GError** _err) c_g_pollable_stream_write;
  bool function(GOutputStream* stream, void* buffer, size_t count, bool blocking, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_pollable_stream_write_all;
  char** function(const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resources_enumerate_children;
  bool function(const(char)* path, GResourceLookupFlags lookupFlags, size_t* size, uint* flags, GError** _err) c_g_resources_get_info;
  GBytes* function(const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resources_lookup_data;
  GInputStream* function(const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resources_open_stream;
  void function(GResource* resource) c_g_resources_register;
  void function(GResource* resource) c_g_resources_unregister;
  void function(ObjectC* object, GAsyncReadyCallback callback, void* userData, GQuark domain, int code, const(char)* format,  ...) c_g_simple_async_report_error_in_idle;
  void function(ObjectC* object, GAsyncReadyCallback callback, void* userData, const(GError)* error) c_g_simple_async_report_gerror_in_idle;
  void function(ObjectC* object, GAsyncReadyCallback callback, void* userData, GError* error) c_g_simple_async_report_take_gerror_in_idle;
  bool function(const(char)* mountPath) c_g_unix_is_mount_path_system_internal;
  bool function(const(char)* devicePath) c_g_unix_is_system_device_path;
  bool function(const(char)* fsType) c_g_unix_is_system_fs_type;
  GUnixMountEntry* function(const(char)* mountPath, ulong* timeRead) c_g_unix_mount_at;
  int function(GUnixMountEntry* mount1, GUnixMountEntry* mount2) c_g_unix_mount_compare;
  GUnixMountEntry* function(GUnixMountEntry* mountEntry) c_g_unix_mount_copy;
  GUnixMountEntry* function(const(char)* filePath, ulong* timeRead) c_g_unix_mount_for;
  void function(GUnixMountEntry* mountEntry) c_g_unix_mount_free;
  const(char)* function(GUnixMountEntry* mountEntry) c_g_unix_mount_get_device_path;
  const(char)* function(GUnixMountEntry* mountEntry) c_g_unix_mount_get_fs_type;
  const(char)* function(GUnixMountEntry* mountEntry) c_g_unix_mount_get_mount_path;
  const(char)* function(GUnixMountEntry* mountEntry) c_g_unix_mount_get_options;
  const(char)* function(GUnixMountEntry* mountEntry) c_g_unix_mount_get_root_path;
  bool function(GUnixMountEntry* mountEntry) c_g_unix_mount_guess_can_eject;
  GIcon* function(GUnixMountEntry* mountEntry) c_g_unix_mount_guess_icon;
  char* function(GUnixMountEntry* mountEntry) c_g_unix_mount_guess_name;
  bool function(GUnixMountEntry* mountEntry) c_g_unix_mount_guess_should_display;
  GIcon* function(GUnixMountEntry* mountEntry) c_g_unix_mount_guess_symbolic_icon;
  bool function(GUnixMountEntry* mountEntry) c_g_unix_mount_is_readonly;
  bool function(GUnixMountEntry* mountEntry) c_g_unix_mount_is_system_internal;
  bool function(ulong time) c_g_unix_mount_points_changed_since;
  GList* function(ulong* timeRead) c_g_unix_mount_points_get;
  bool function(ulong time) c_g_unix_mounts_changed_since;
  GList* function(ulong* timeRead) c_g_unix_mounts_get;

  // IOExtension
  const(char)* function(GIOExtension* extension) c_g_io_extension_get_name;
  int function(GIOExtension* extension) c_g_io_extension_get_priority;
  GType function(GIOExtension* extension) c_g_io_extension_get_type;
  GTypeClass* function(GIOExtension* extension) c_g_io_extension_ref_class;

  // IOExtensionPoint
  GIOExtension* function(GIOExtensionPoint* extensionPoint, const(char)* name) c_g_io_extension_point_get_extension_by_name;
  GList* function(GIOExtensionPoint* extensionPoint) c_g_io_extension_point_get_extensions;
  GType function(GIOExtensionPoint* extensionPoint) c_g_io_extension_point_get_required_type;
  void function(GIOExtensionPoint* extensionPoint, GType type) c_g_io_extension_point_set_required_type;
  GIOExtension* function(const(char)* extensionPointName, GType type, const(char)* extensionName, int priority) c_g_io_extension_point_implement;
  GIOExtensionPoint* function(const(char)* name) c_g_io_extension_point_lookup;
  GIOExtensionPoint* function(const(char)* name) c_g_io_extension_point_register;

  // IOModule
  GType function() c_g_io_module_get_type;
  GIOModule* function(const(char)* filename) c_g_io_module_new;
  char** function() c_g_io_module_query;
  void function(GIOModule* module_) c_g_io_module_load;
  void function(GIOModule* module_) c_g_io_module_unload;

  // IOModuleScope
  void function(GIOModuleScope* scope_, const(char)* basename) c_g_io_module_scope_block;
  void function(GIOModuleScope* scope_) c_g_io_module_scope_free;
  GIOModuleScope* function(GIOModuleScopeFlags flags) c_g_io_module_scope_new;

  // IOSchedulerJob
  bool function(GIOSchedulerJob* job, GSourceFunc func, void* userData, GDestroyNotify notify) c_g_io_scheduler_job_send_to_mainloop;
  void function(GIOSchedulerJob* job, GSourceFunc func, void* userData, GDestroyNotify notify) c_g_io_scheduler_job_send_to_mainloop_async;

  // IOStream
  GType function() c_g_io_stream_get_type;
  bool function(GAsyncResult* result, GError** _err) c_g_io_stream_splice_finish;
  void function(GIOStream* stream) c_g_io_stream_clear_pending;
  bool function(GIOStream* stream, GCancellable* cancellable, GError** _err) c_g_io_stream_close;
  void function(GIOStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_io_stream_close_async;
  bool function(GIOStream* stream, GAsyncResult* result, GError** _err) c_g_io_stream_close_finish;
  GInputStream* function(GIOStream* stream) c_g_io_stream_get_input_stream;
  GOutputStream* function(GIOStream* stream) c_g_io_stream_get_output_stream;
  bool function(GIOStream* stream) c_g_io_stream_has_pending;
  bool function(GIOStream* stream) c_g_io_stream_is_closed;
  bool function(GIOStream* stream, GError** _err) c_g_io_stream_set_pending;
  void function(GIOStream* stream1, GIOStream* stream2, GIOStreamSpliceFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_io_stream_splice_async;

  // Icon
  GType function() c_g_icon_get_type;
  GIcon* function(GVariant* value) c_g_icon_deserialize;
  GIcon* function(const(char)* str, GError** _err) c_g_icon_new_for_string;
  bool function(GIcon* icon1, GIcon* icon2) c_g_icon_equal;
  uint function(GIcon* icon) c_g_icon_hash;
  GVariant* function(GIcon* icon) c_g_icon_serialize;
  char* function(GIcon* icon) c_g_icon_to_string;

  // InetAddress
  GType function() c_g_inet_address_get_type;
  GInetAddress* function(GSocketFamily family) c_g_inet_address_new_any;
  GInetAddress* function(const(ubyte)* bytes, GSocketFamily family) c_g_inet_address_new_from_bytes;
  GInetAddress* function(const(char)* string_) c_g_inet_address_new_from_string;
  GInetAddress* function(GSocketFamily family) c_g_inet_address_new_loopback;
  bool function(GInetAddress* address, GInetAddress* otherAddress) c_g_inet_address_equal;
  GSocketFamily function(GInetAddress* address) c_g_inet_address_get_family;
  bool function(GInetAddress* address) c_g_inet_address_get_is_any;
  bool function(GInetAddress* address) c_g_inet_address_get_is_link_local;
  bool function(GInetAddress* address) c_g_inet_address_get_is_loopback;
  bool function(GInetAddress* address) c_g_inet_address_get_is_mc_global;
  bool function(GInetAddress* address) c_g_inet_address_get_is_mc_link_local;
  bool function(GInetAddress* address) c_g_inet_address_get_is_mc_node_local;
  bool function(GInetAddress* address) c_g_inet_address_get_is_mc_org_local;
  bool function(GInetAddress* address) c_g_inet_address_get_is_mc_site_local;
  bool function(GInetAddress* address) c_g_inet_address_get_is_multicast;
  bool function(GInetAddress* address) c_g_inet_address_get_is_site_local;
  size_t function(GInetAddress* address) c_g_inet_address_get_native_size;
  const(ubyte)* function(GInetAddress* address) c_g_inet_address_to_bytes;
  char* function(GInetAddress* address) c_g_inet_address_to_string;

  // InetAddressMask
  GType function() c_g_inet_address_mask_get_type;
  GInetAddressMask* function(GInetAddress* addr, uint length, GError** _err) c_g_inet_address_mask_new;
  GInetAddressMask* function(const(char)* maskString, GError** _err) c_g_inet_address_mask_new_from_string;
  bool function(GInetAddressMask* mask, GInetAddressMask* mask2) c_g_inet_address_mask_equal;
  GInetAddress* function(GInetAddressMask* mask) c_g_inet_address_mask_get_address;
  GSocketFamily function(GInetAddressMask* mask) c_g_inet_address_mask_get_family;
  uint function(GInetAddressMask* mask) c_g_inet_address_mask_get_length;
  bool function(GInetAddressMask* mask, GInetAddress* address) c_g_inet_address_mask_matches;
  char* function(GInetAddressMask* mask) c_g_inet_address_mask_to_string;

  // InetSocketAddress
  GType function() c_g_inet_socket_address_get_type;
  GSocketAddress* function(GInetAddress* address, ushort port) c_g_inet_socket_address_new;
  GSocketAddress* function(const(char)* address, uint port) c_g_inet_socket_address_new_from_string;
  GInetAddress* function(GInetSocketAddress* address) c_g_inet_socket_address_get_address;
  uint function(GInetSocketAddress* address) c_g_inet_socket_address_get_flowinfo;
  ushort function(GInetSocketAddress* address) c_g_inet_socket_address_get_port;
  uint function(GInetSocketAddress* address) c_g_inet_socket_address_get_scope_id;

  // Initable
  GType function() c_g_initable_get_type;
  ObjectC* function(GType objectType, GCancellable* cancellable, GError** error, const(char)* firstPropertyName,  ...) c_g_initable_new;
  ObjectC* function(GType objectType, const(char)* firstPropertyName, void* varArgs, GCancellable* cancellable, GError** _err) c_g_initable_new_valist;
  ObjectC* function(GType objectType, uint nParameters, GParameter* parameters, GCancellable* cancellable, GError** _err) c_g_initable_newv;
  bool function(GInitable* initable, GCancellable* cancellable, GError** _err) c_g_initable_init;

  // InputStream
  GType function() c_g_input_stream_get_type;
  void function(GInputStream* stream) c_g_input_stream_clear_pending;
  bool function(GInputStream* stream, GCancellable* cancellable, GError** _err) c_g_input_stream_close;
  void function(GInputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_input_stream_close_async;
  bool function(GInputStream* stream, GAsyncResult* result, GError** _err) c_g_input_stream_close_finish;
  bool function(GInputStream* stream) c_g_input_stream_has_pending;
  bool function(GInputStream* stream) c_g_input_stream_is_closed;
  ptrdiff_t function(GInputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) c_g_input_stream_read;
  bool function(GInputStream* stream, void* buffer, size_t count, size_t* bytesRead, GCancellable* cancellable, GError** _err) c_g_input_stream_read_all;
  void function(GInputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_input_stream_read_all_async;
  bool function(GInputStream* stream, GAsyncResult* result, size_t* bytesRead, GError** _err) c_g_input_stream_read_all_finish;
  void function(GInputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_input_stream_read_async;
  GBytes* function(GInputStream* stream, size_t count, GCancellable* cancellable, GError** _err) c_g_input_stream_read_bytes;
  void function(GInputStream* stream, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_input_stream_read_bytes_async;
  GBytes* function(GInputStream* stream, GAsyncResult* result, GError** _err) c_g_input_stream_read_bytes_finish;
  ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err) c_g_input_stream_read_finish;
  bool function(GInputStream* stream, GError** _err) c_g_input_stream_set_pending;
  ptrdiff_t function(GInputStream* stream, size_t count, GCancellable* cancellable, GError** _err) c_g_input_stream_skip;
  void function(GInputStream* stream, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_input_stream_skip_async;
  ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err) c_g_input_stream_skip_finish;

  // ListModel
  GType function() c_g_list_model_get_type;
  void* function(GListModel* list, uint position) c_g_list_model_get_item;
  GType function(GListModel* list) c_g_list_model_get_item_type;
  uint function(GListModel* list) c_g_list_model_get_n_items;
  ObjectC* function(GListModel* list, uint position) c_g_list_model_get_object;
  void function(GListModel* list, uint position, uint removed, uint added) c_g_list_model_items_changed;

  // ListStore
  GType function() c_g_list_store_get_type;
  GListStore* function(GType itemType) c_g_list_store_new;
  void function(GListStore* store, ObjectC* item) c_g_list_store_append;
  bool function(GListStore* store, ObjectC* item, uint* position) c_g_list_store_find;
  bool function(GListStore* store, ObjectC* item, GEqualFunc equalFunc, uint* position) c_g_list_store_find_with_equal_func;
  bool function(GListStore* store, ObjectC* item, GEqualFuncFull equalFunc, void* userData, uint* position) c_g_list_store_find_with_equal_func_full;
  void function(GListStore* store, uint position, ObjectC* item) c_g_list_store_insert;
  uint function(GListStore* store, ObjectC* item, GCompareDataFunc compareFunc, void* userData) c_g_list_store_insert_sorted;
  void function(GListStore* store, uint position) c_g_list_store_remove;
  void function(GListStore* store) c_g_list_store_remove_all;
  void function(GListStore* store, GCompareDataFunc compareFunc, void* userData) c_g_list_store_sort;
  void function(GListStore* store, uint position, uint nRemovals, void** additions, uint nAdditions) c_g_list_store_splice;

  // LoadableIcon
  GType function() c_g_loadable_icon_get_type;
  GInputStream* function(GLoadableIcon* icon, int size, char** type, GCancellable* cancellable, GError** _err) c_g_loadable_icon_load;
  void function(GLoadableIcon* icon, int size, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_loadable_icon_load_async;
  GInputStream* function(GLoadableIcon* icon, GAsyncResult* res, char** type, GError** _err) c_g_loadable_icon_load_finish;

  // MemoryInputStream
  GType function() c_g_memory_input_stream_get_type;
  GInputStream* function() c_g_memory_input_stream_new;
  GInputStream* function(GBytes* bytes) c_g_memory_input_stream_new_from_bytes;
  GInputStream* function(void* data, ptrdiff_t len, GDestroyNotify destroy) c_g_memory_input_stream_new_from_data;
  void function(GMemoryInputStream* stream, GBytes* bytes) c_g_memory_input_stream_add_bytes;
  void function(GMemoryInputStream* stream, void* data, ptrdiff_t len, GDestroyNotify destroy) c_g_memory_input_stream_add_data;

  // MemoryMonitor
  GType function() c_g_memory_monitor_get_type;
  GMemoryMonitor* function() c_g_memory_monitor_dup_default;

  // MemoryOutputStream
  GType function() c_g_memory_output_stream_get_type;
  GOutputStream* function(void* data, size_t size, GReallocFunc reallocFunction, GDestroyNotify destroyFunction) c_g_memory_output_stream_new;
  GOutputStream* function() c_g_memory_output_stream_new_resizable;
  void* function(GMemoryOutputStream* ostream) c_g_memory_output_stream_get_data;
  size_t function(GMemoryOutputStream* ostream) c_g_memory_output_stream_get_data_size;
  size_t function(GMemoryOutputStream* ostream) c_g_memory_output_stream_get_size;
  GBytes* function(GMemoryOutputStream* ostream) c_g_memory_output_stream_steal_as_bytes;
  void* function(GMemoryOutputStream* ostream) c_g_memory_output_stream_steal_data;

  // Menu
  GType function() c_g_menu_get_type;
  GMenu* function() c_g_menu_new;
  void function(GMenu* menu, const(char)* label, const(char)* detailedAction) c_g_menu_append;
  void function(GMenu* menu, GMenuItem* item) c_g_menu_append_item;
  void function(GMenu* menu, const(char)* label, GMenuModel* section) c_g_menu_append_section;
  void function(GMenu* menu, const(char)* label, GMenuModel* submenu) c_g_menu_append_submenu;
  void function(GMenu* menu) c_g_menu_freeze;
  void function(GMenu* menu, int position, const(char)* label, const(char)* detailedAction) c_g_menu_insert;
  void function(GMenu* menu, int position, GMenuItem* item) c_g_menu_insert_item;
  void function(GMenu* menu, int position, const(char)* label, GMenuModel* section) c_g_menu_insert_section;
  void function(GMenu* menu, int position, const(char)* label, GMenuModel* submenu) c_g_menu_insert_submenu;
  void function(GMenu* menu, const(char)* label, const(char)* detailedAction) c_g_menu_prepend;
  void function(GMenu* menu, GMenuItem* item) c_g_menu_prepend_item;
  void function(GMenu* menu, const(char)* label, GMenuModel* section) c_g_menu_prepend_section;
  void function(GMenu* menu, const(char)* label, GMenuModel* submenu) c_g_menu_prepend_submenu;
  void function(GMenu* menu, int position) c_g_menu_remove;
  void function(GMenu* menu) c_g_menu_remove_all;

  // MenuAttributeIter
  GType function() c_g_menu_attribute_iter_get_type;
  const(char)* function(GMenuAttributeIter* iter) c_g_menu_attribute_iter_get_name;
  bool function(GMenuAttributeIter* iter, const(char*)* outName, GVariant** value) c_g_menu_attribute_iter_get_next;
  GVariant* function(GMenuAttributeIter* iter) c_g_menu_attribute_iter_get_value;
  bool function(GMenuAttributeIter* iter) c_g_menu_attribute_iter_next;

  // MenuItem
  GType function() c_g_menu_item_get_type;
  GMenuItem* function(const(char)* label, const(char)* detailedAction) c_g_menu_item_new;
  GMenuItem* function(GMenuModel* model, int itemIndex) c_g_menu_item_new_from_model;
  GMenuItem* function(const(char)* label, GMenuModel* section) c_g_menu_item_new_section;
  GMenuItem* function(const(char)* label, GMenuModel* submenu) c_g_menu_item_new_submenu;
  bool function(GMenuItem* menuItem, const(char)* attribute, const(char)* formatString,  ...) c_g_menu_item_get_attribute;
  GVariant* function(GMenuItem* menuItem, const(char)* attribute, const(GVariantType)* expectedType) c_g_menu_item_get_attribute_value;
  GMenuModel* function(GMenuItem* menuItem, const(char)* link) c_g_menu_item_get_link;
  void function(GMenuItem* menuItem, const(char)* action, const(char)* formatString,  ...) c_g_menu_item_set_action_and_target;
  void function(GMenuItem* menuItem, const(char)* action, GVariant* targetValue) c_g_menu_item_set_action_and_target_value;
  void function(GMenuItem* menuItem, const(char)* attribute, const(char)* formatString,  ...) c_g_menu_item_set_attribute;
  void function(GMenuItem* menuItem, const(char)* attribute, GVariant* value) c_g_menu_item_set_attribute_value;
  void function(GMenuItem* menuItem, const(char)* detailedAction) c_g_menu_item_set_detailed_action;
  void function(GMenuItem* menuItem, GIcon* icon) c_g_menu_item_set_icon;
  void function(GMenuItem* menuItem, const(char)* label) c_g_menu_item_set_label;
  void function(GMenuItem* menuItem, const(char)* link, GMenuModel* model) c_g_menu_item_set_link;
  void function(GMenuItem* menuItem, GMenuModel* section) c_g_menu_item_set_section;
  void function(GMenuItem* menuItem, GMenuModel* submenu) c_g_menu_item_set_submenu;

  // MenuLinkIter
  GType function() c_g_menu_link_iter_get_type;
  const(char)* function(GMenuLinkIter* iter) c_g_menu_link_iter_get_name;
  bool function(GMenuLinkIter* iter, const(char*)* outLink, GMenuModel** value) c_g_menu_link_iter_get_next;
  GMenuModel* function(GMenuLinkIter* iter) c_g_menu_link_iter_get_value;
  bool function(GMenuLinkIter* iter) c_g_menu_link_iter_next;

  // MenuModel
  GType function() c_g_menu_model_get_type;
  bool function(GMenuModel* model, int itemIndex, const(char)* attribute, const(char)* formatString,  ...) c_g_menu_model_get_item_attribute;
  GVariant* function(GMenuModel* model, int itemIndex, const(char)* attribute, const(GVariantType)* expectedType) c_g_menu_model_get_item_attribute_value;
  GMenuModel* function(GMenuModel* model, int itemIndex, const(char)* link) c_g_menu_model_get_item_link;
  int function(GMenuModel* model) c_g_menu_model_get_n_items;
  bool function(GMenuModel* model) c_g_menu_model_is_mutable;
  void function(GMenuModel* model, int position, int removed, int added) c_g_menu_model_items_changed;
  GMenuAttributeIter* function(GMenuModel* model, int itemIndex) c_g_menu_model_iterate_item_attributes;
  GMenuLinkIter* function(GMenuModel* model, int itemIndex) c_g_menu_model_iterate_item_links;

  // Mount
  GType function() c_g_mount_get_type;
  bool function(GMount* mount) c_g_mount_can_eject;
  bool function(GMount* mount) c_g_mount_can_unmount;
  void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_eject;
  bool function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_eject_finish;
  void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_eject_with_operation;
  bool function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_eject_with_operation_finish;
  GFile* function(GMount* mount) c_g_mount_get_default_location;
  GDrive* function(GMount* mount) c_g_mount_get_drive;
  GIcon* function(GMount* mount) c_g_mount_get_icon;
  char* function(GMount* mount) c_g_mount_get_name;
  GFile* function(GMount* mount) c_g_mount_get_root;
  const(char)* function(GMount* mount) c_g_mount_get_sort_key;
  GIcon* function(GMount* mount) c_g_mount_get_symbolic_icon;
  char* function(GMount* mount) c_g_mount_get_uuid;
  GVolume* function(GMount* mount) c_g_mount_get_volume;
  void function(GMount* mount, bool forceRescan, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_guess_content_type;
  char** function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_guess_content_type_finish;
  char** function(GMount* mount, bool forceRescan, GCancellable* cancellable, GError** _err) c_g_mount_guess_content_type_sync;
  bool function(GMount* mount) c_g_mount_is_shadowed;
  void function(GMount* mount, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_remount;
  bool function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_remount_finish;
  void function(GMount* mount) c_g_mount_shadow;
  void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_unmount;
  bool function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_unmount_finish;
  void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_mount_unmount_with_operation;
  bool function(GMount* mount, GAsyncResult* result, GError** _err) c_g_mount_unmount_with_operation_finish;
  void function(GMount* mount) c_g_mount_unshadow;

  // MountOperation
  GType function() c_g_mount_operation_get_type;
  GMountOperation* function() c_g_mount_operation_new;
  bool function(GMountOperation* op) c_g_mount_operation_get_anonymous;
  int function(GMountOperation* op) c_g_mount_operation_get_choice;
  const(char)* function(GMountOperation* op) c_g_mount_operation_get_domain;
  bool function(GMountOperation* op) c_g_mount_operation_get_is_tcrypt_hidden_volume;
  bool function(GMountOperation* op) c_g_mount_operation_get_is_tcrypt_system_volume;
  const(char)* function(GMountOperation* op) c_g_mount_operation_get_password;
  GPasswordSave function(GMountOperation* op) c_g_mount_operation_get_password_save;
  uint function(GMountOperation* op) c_g_mount_operation_get_pim;
  const(char)* function(GMountOperation* op) c_g_mount_operation_get_username;
  void function(GMountOperation* op, GMountOperationResult result) c_g_mount_operation_reply;
  void function(GMountOperation* op, bool anonymous) c_g_mount_operation_set_anonymous;
  void function(GMountOperation* op, int choice) c_g_mount_operation_set_choice;
  void function(GMountOperation* op, const(char)* domain) c_g_mount_operation_set_domain;
  void function(GMountOperation* op, bool hiddenVolume) c_g_mount_operation_set_is_tcrypt_hidden_volume;
  void function(GMountOperation* op, bool systemVolume) c_g_mount_operation_set_is_tcrypt_system_volume;
  void function(GMountOperation* op, const(char)* password) c_g_mount_operation_set_password;
  void function(GMountOperation* op, GPasswordSave save) c_g_mount_operation_set_password_save;
  void function(GMountOperation* op, uint pim) c_g_mount_operation_set_pim;
  void function(GMountOperation* op, const(char)* username) c_g_mount_operation_set_username;

  // NativeSocketAddress
  GType function() c_g_native_socket_address_get_type;
  GSocketAddress* function(void* native, size_t len) c_g_native_socket_address_new;

  // NativeVolumeMonitor
  GType function() c_g_native_volume_monitor_get_type;

  // NetworkAddress
  GType function() c_g_network_address_get_type;
  GSocketConnectable* function(const(char)* hostname, ushort port) c_g_network_address_new;
  GSocketConnectable* function(ushort port) c_g_network_address_new_loopback;
  GSocketConnectable* function(const(char)* hostAndPort, ushort defaultPort, GError** _err) c_g_network_address_parse;
  GSocketConnectable* function(const(char)* uri, ushort defaultPort, GError** _err) c_g_network_address_parse_uri;
  const(char)* function(GNetworkAddress* addr) c_g_network_address_get_hostname;
  ushort function(GNetworkAddress* addr) c_g_network_address_get_port;
  const(char)* function(GNetworkAddress* addr) c_g_network_address_get_scheme;

  // NetworkMonitor
  GType function() c_g_network_monitor_get_type;
  GNetworkMonitor* function() c_g_network_monitor_get_default;
  bool function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GError** _err) c_g_network_monitor_can_reach;
  void function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_network_monitor_can_reach_async;
  bool function(GNetworkMonitor* monitor, GAsyncResult* result, GError** _err) c_g_network_monitor_can_reach_finish;
  GNetworkConnectivity function(GNetworkMonitor* monitor) c_g_network_monitor_get_connectivity;
  bool function(GNetworkMonitor* monitor) c_g_network_monitor_get_network_available;
  bool function(GNetworkMonitor* monitor) c_g_network_monitor_get_network_metered;

  // NetworkService
  GType function() c_g_network_service_get_type;
  GSocketConnectable* function(const(char)* service, const(char)* protocol, const(char)* domain) c_g_network_service_new;
  const(char)* function(GNetworkService* srv) c_g_network_service_get_domain;
  const(char)* function(GNetworkService* srv) c_g_network_service_get_protocol;
  const(char)* function(GNetworkService* srv) c_g_network_service_get_scheme;
  const(char)* function(GNetworkService* srv) c_g_network_service_get_service;
  void function(GNetworkService* srv, const(char)* scheme) c_g_network_service_set_scheme;

  // Notification
  GType function() c_g_notification_get_type;
  GNotification* function(const(char)* title) c_g_notification_new;
  void function(GNotification* notification, const(char)* label, const(char)* detailedAction) c_g_notification_add_button;
  void function(GNotification* notification, const(char)* label, const(char)* action, const(char)* targetFormat,  ...) c_g_notification_add_button_with_target;
  void function(GNotification* notification, const(char)* label, const(char)* action, GVariant* target) c_g_notification_add_button_with_target_value;
  void function(GNotification* notification, const(char)* body_) c_g_notification_set_body;
  void function(GNotification* notification, const(char)* category) c_g_notification_set_category;
  void function(GNotification* notification, const(char)* detailedAction) c_g_notification_set_default_action;
  void function(GNotification* notification, const(char)* action, const(char)* targetFormat,  ...) c_g_notification_set_default_action_and_target;
  void function(GNotification* notification, const(char)* action, GVariant* target) c_g_notification_set_default_action_and_target_value;
  void function(GNotification* notification, GIcon* icon) c_g_notification_set_icon;
  void function(GNotification* notification, GNotificationPriority priority) c_g_notification_set_priority;
  void function(GNotification* notification, const(char)* title) c_g_notification_set_title;
  void function(GNotification* notification, bool urgent) c_g_notification_set_urgent;

  // OutputStream
  GType function() c_g_output_stream_get_type;
  void function(GOutputStream* stream) c_g_output_stream_clear_pending;
  bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err) c_g_output_stream_close;
  void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_close_async;
  bool function(GOutputStream* stream, GAsyncResult* result, GError** _err) c_g_output_stream_close_finish;
  bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err) c_g_output_stream_flush;
  void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_flush_async;
  bool function(GOutputStream* stream, GAsyncResult* result, GError** _err) c_g_output_stream_flush_finish;
  bool function(GOutputStream* stream) c_g_output_stream_has_pending;
  bool function(GOutputStream* stream) c_g_output_stream_is_closed;
  bool function(GOutputStream* stream) c_g_output_stream_is_closing;
  bool function(GOutputStream* stream, size_t* bytesWritten, GCancellable* cancellable, GError** error, const(char)* format,  ...) c_g_output_stream_printf;
  bool function(GOutputStream* stream, GError** _err) c_g_output_stream_set_pending;
  ptrdiff_t function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, GCancellable* cancellable, GError** _err) c_g_output_stream_splice;
  void function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_splice_async;
  ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err) c_g_output_stream_splice_finish;
  bool function(GOutputStream* stream, size_t* bytesWritten, GCancellable* cancellable, GError** error, const(char)* format, void* args) c_g_output_stream_vprintf;
  ptrdiff_t function(GOutputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) c_g_output_stream_write;
  bool function(GOutputStream* stream, void* buffer, size_t count, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_output_stream_write_all;
  void function(GOutputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_write_all_async;
  bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err) c_g_output_stream_write_all_finish;
  void function(GOutputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_write_async;
  ptrdiff_t function(GOutputStream* stream, GBytes* bytes, GCancellable* cancellable, GError** _err) c_g_output_stream_write_bytes;
  void function(GOutputStream* stream, GBytes* bytes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_write_bytes_async;
  ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err) c_g_output_stream_write_bytes_finish;
  ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err) c_g_output_stream_write_finish;
  bool function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_output_stream_writev;
  bool function(GOutputStream* stream, GOutputVector* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_output_stream_writev_all;
  void function(GOutputStream* stream, GOutputVector* vectors, size_t nVectors, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_writev_all_async;
  bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err) c_g_output_stream_writev_all_finish;
  void function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_output_stream_writev_async;
  bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err) c_g_output_stream_writev_finish;

  // Permission
  GType function() c_g_permission_get_type;
  bool function(GPermission* permission, GCancellable* cancellable, GError** _err) c_g_permission_acquire;
  void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_permission_acquire_async;
  bool function(GPermission* permission, GAsyncResult* result, GError** _err) c_g_permission_acquire_finish;
  bool function(GPermission* permission) c_g_permission_get_allowed;
  bool function(GPermission* permission) c_g_permission_get_can_acquire;
  bool function(GPermission* permission) c_g_permission_get_can_release;
  void function(GPermission* permission, bool allowed, bool canAcquire, bool canRelease) c_g_permission_impl_update;
  bool function(GPermission* permission, GCancellable* cancellable, GError** _err) c_g_permission_release;
  void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_permission_release_async;
  bool function(GPermission* permission, GAsyncResult* result, GError** _err) c_g_permission_release_finish;

  // PollableInputStream
  GType function() c_g_pollable_input_stream_get_type;
  bool function(GPollableInputStream* stream) c_g_pollable_input_stream_can_poll;
  GSource* function(GPollableInputStream* stream, GCancellable* cancellable) c_g_pollable_input_stream_create_source;
  bool function(GPollableInputStream* stream) c_g_pollable_input_stream_is_readable;
  ptrdiff_t function(GPollableInputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) c_g_pollable_input_stream_read_nonblocking;

  // PollableOutputStream
  GType function() c_g_pollable_output_stream_get_type;
  bool function(GPollableOutputStream* stream) c_g_pollable_output_stream_can_poll;
  GSource* function(GPollableOutputStream* stream, GCancellable* cancellable) c_g_pollable_output_stream_create_source;
  bool function(GPollableOutputStream* stream) c_g_pollable_output_stream_is_writable;
  ptrdiff_t function(GPollableOutputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) c_g_pollable_output_stream_write_nonblocking;
  GPollableReturn function(GPollableOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_pollable_output_stream_writev_nonblocking;

  // PowerProfileMonitor
  GType function() c_g_power_profile_monitor_get_type;
  GPowerProfileMonitor* function() c_g_power_profile_monitor_dup_default;
  bool function(GPowerProfileMonitor* monitor) c_g_power_profile_monitor_get_power_saver_enabled;

  // PropertyAction
  GType function() c_g_property_action_get_type;
  GPropertyAction* function(const(char)* name, ObjectC* object, const(char)* propertyName) c_g_property_action_new;

  // Proxy
  GType function() c_g_proxy_get_type;
  GProxy* function(const(char)* protocol) c_g_proxy_get_default_for_protocol;
  GIOStream* function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GError** _err) c_g_proxy_connect;
  void function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_proxy_connect_async;
  GIOStream* function(GProxy* proxy, GAsyncResult* result, GError** _err) c_g_proxy_connect_finish;
  bool function(GProxy* proxy) c_g_proxy_supports_hostname;

  // ProxyAddress
  GType function() c_g_proxy_address_get_type;
  GSocketAddress* function(GInetAddress* inetaddr, ushort port, const(char)* protocol, const(char)* destHostname, ushort destPort, const(char)* username, const(char)* password) c_g_proxy_address_new;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_destination_hostname;
  ushort function(GProxyAddress* proxy) c_g_proxy_address_get_destination_port;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_destination_protocol;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_password;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_protocol;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_uri;
  const(char)* function(GProxyAddress* proxy) c_g_proxy_address_get_username;

  // ProxyAddressEnumerator
  GType function() c_g_proxy_address_enumerator_get_type;

  // ProxyResolver
  GType function() c_g_proxy_resolver_get_type;
  GProxyResolver* function() c_g_proxy_resolver_get_default;
  bool function(GProxyResolver* resolver) c_g_proxy_resolver_is_supported;
  char** function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GError** _err) c_g_proxy_resolver_lookup;
  void function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_proxy_resolver_lookup_async;
  char** function(GProxyResolver* resolver, GAsyncResult* result, GError** _err) c_g_proxy_resolver_lookup_finish;

  // RemoteActionGroup
  GType function() c_g_remote_action_group_get_type;
  void function(GRemoteActionGroup* remote, const(char)* actionName, GVariant* parameter, GVariant* platformData) c_g_remote_action_group_activate_action_full;
  void function(GRemoteActionGroup* remote, const(char)* actionName, GVariant* value, GVariant* platformData) c_g_remote_action_group_change_action_state_full;

  // Resolver
  GType function() c_g_resolver_get_type;
  void function(GList* addresses) c_g_resolver_free_addresses;
  void function(GList* targets) c_g_resolver_free_targets;
  GResolver* function() c_g_resolver_get_default;
  uint function(GResolver* resolver) c_g_resolver_get_timeout;
  char* function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GError** _err) c_g_resolver_lookup_by_address;
  void function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_resolver_lookup_by_address_async;
  char* function(GResolver* resolver, GAsyncResult* result, GError** _err) c_g_resolver_lookup_by_address_finish;
  GList* function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GError** _err) c_g_resolver_lookup_by_name;
  void function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_resolver_lookup_by_name_async;
  GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) c_g_resolver_lookup_by_name_finish;
  GList* function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GError** _err) c_g_resolver_lookup_by_name_with_flags;
  void function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_resolver_lookup_by_name_with_flags_async;
  GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) c_g_resolver_lookup_by_name_with_flags_finish;
  GList* function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GError** _err) c_g_resolver_lookup_records;
  void function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_resolver_lookup_records_async;
  GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) c_g_resolver_lookup_records_finish;
  GList* function(GResolver* resolver, const(char)* service, const(char)* protocol, const(char)* domain, GCancellable* cancellable, GError** _err) c_g_resolver_lookup_service;
  void function(GResolver* resolver, const(char)* service, const(char)* protocol, const(char)* domain, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_resolver_lookup_service_async;
  GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) c_g_resolver_lookup_service_finish;
  void function(GResolver* resolver) c_g_resolver_set_default;
  void function(GResolver* resolver, uint timeoutMs) c_g_resolver_set_timeout;

  // Resource
  GType function() c_g_resource_get_type;
  GResource* function(GBytes* data, GError** _err) c_g_resource_new_from_data;
  char** function(GResource* resource, const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resource_enumerate_children;
  bool function(GResource* resource, const(char)* path, GResourceLookupFlags lookupFlags, size_t* size, uint* flags, GError** _err) c_g_resource_get_info;
  GBytes* function(GResource* resource, const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resource_lookup_data;
  GInputStream* function(GResource* resource, const(char)* path, GResourceLookupFlags lookupFlags, GError** _err) c_g_resource_open_stream;
  GResource* function(GResource* resource) c_g_resource_ref;
  void function(GResource* resource) c_g_resource_unref;
  GResource* function(const(char)* filename, GError** _err) c_g_resource_load;

  // Seekable
  GType function() c_g_seekable_get_type;
  bool function(GSeekable* seekable) c_g_seekable_can_seek;
  bool function(GSeekable* seekable) c_g_seekable_can_truncate;
  bool function(GSeekable* seekable, long offset, GSeekType type, GCancellable* cancellable, GError** _err) c_g_seekable_seek;
  long function(GSeekable* seekable) c_g_seekable_tell;
  bool function(GSeekable* seekable, long offset, GCancellable* cancellable, GError** _err) c_g_seekable_truncate;

  // Settings
  GType function() c_g_settings_get_type;
  GSettings* function(const(char)* schemaId) c_g_settings_new;
  GSettings* function(GSettingsSchema* schema, GSettingsBackend* backend, const(char)* path) c_g_settings_new_full;
  GSettings* function(const(char)* schemaId, GSettingsBackend* backend) c_g_settings_new_with_backend;
  GSettings* function(const(char)* schemaId, GSettingsBackend* backend, const(char)* path) c_g_settings_new_with_backend_and_path;
  GSettings* function(const(char)* schemaId, const(char)* path) c_g_settings_new_with_path;
  const(char*)* function() c_g_settings_list_relocatable_schemas;
  const(char*)* function() c_g_settings_list_schemas;
  void function() c_g_settings_sync;
  void function(ObjectC* object, const(char)* property) c_g_settings_unbind;
  void function(GSettings* settings) c_g_settings_apply;
  void function(GSettings* settings, const(char)* key, ObjectC* object, const(char)* property, GSettingsBindFlags flags) c_g_settings_bind;
  void function(GSettings* settings, const(char)* key, ObjectC* object, const(char)* property, GSettingsBindFlags flags, GSettingsBindGetMapping getMapping, GSettingsBindSetMapping setMapping, void* userData, GDestroyNotify destroy) c_g_settings_bind_with_mapping;
  void function(GSettings* settings, const(char)* key, ObjectC* object, const(char)* property, bool inverted) c_g_settings_bind_writable;
  GAction* function(GSettings* settings, const(char)* key) c_g_settings_create_action;
  void function(GSettings* settings) c_g_settings_delay;
  void function(GSettings* settings, const(char)* key, const(char)* format,  ...) c_g_settings_get;
  bool function(GSettings* settings, const(char)* key) c_g_settings_get_boolean;
  GSettings* function(GSettings* settings, const(char)* name) c_g_settings_get_child;
  GVariant* function(GSettings* settings, const(char)* key) c_g_settings_get_default_value;
  double function(GSettings* settings, const(char)* key) c_g_settings_get_double;
  int function(GSettings* settings, const(char)* key) c_g_settings_get_enum;
  uint function(GSettings* settings, const(char)* key) c_g_settings_get_flags;
  bool function(GSettings* settings) c_g_settings_get_has_unapplied;
  int function(GSettings* settings, const(char)* key) c_g_settings_get_int;
  long function(GSettings* settings, const(char)* key) c_g_settings_get_int64;
  void* function(GSettings* settings, const(char)* key, GSettingsGetMapping mapping, void* userData) c_g_settings_get_mapped;
  GVariant* function(GSettings* settings, const(char)* key) c_g_settings_get_range;
  char* function(GSettings* settings, const(char)* key) c_g_settings_get_string;
  char** function(GSettings* settings, const(char)* key) c_g_settings_get_strv;
  uint function(GSettings* settings, const(char)* key) c_g_settings_get_uint;
  ulong function(GSettings* settings, const(char)* key) c_g_settings_get_uint64;
  GVariant* function(GSettings* settings, const(char)* key) c_g_settings_get_user_value;
  GVariant* function(GSettings* settings, const(char)* key) c_g_settings_get_value;
  bool function(GSettings* settings, const(char)* name) c_g_settings_is_writable;
  char** function(GSettings* settings) c_g_settings_list_children;
  char** function(GSettings* settings) c_g_settings_list_keys;
  bool function(GSettings* settings, const(char)* key, GVariant* value) c_g_settings_range_check;
  void function(GSettings* settings, const(char)* key) c_g_settings_reset;
  void function(GSettings* settings) c_g_settings_revert;
  bool function(GSettings* settings, const(char)* key, const(char)* format,  ...) c_g_settings_set;
  bool function(GSettings* settings, const(char)* key, bool value) c_g_settings_set_boolean;
  bool function(GSettings* settings, const(char)* key, double value) c_g_settings_set_double;
  bool function(GSettings* settings, const(char)* key, int value) c_g_settings_set_enum;
  bool function(GSettings* settings, const(char)* key, uint value) c_g_settings_set_flags;
  bool function(GSettings* settings, const(char)* key, int value) c_g_settings_set_int;
  bool function(GSettings* settings, const(char)* key, long value) c_g_settings_set_int64;
  bool function(GSettings* settings, const(char)* key, const(char)* value) c_g_settings_set_string;
  bool function(GSettings* settings, const(char)* key, const(char*)* value) c_g_settings_set_strv;
  bool function(GSettings* settings, const(char)* key, uint value) c_g_settings_set_uint;
  bool function(GSettings* settings, const(char)* key, ulong value) c_g_settings_set_uint64;
  bool function(GSettings* settings, const(char)* key, GVariant* value) c_g_settings_set_value;

  // SettingsBackend
  GType function() c_g_settings_backend_get_type;
  void function(GTree* tree, char** path, const(char**)* keys, GVariant*** values) c_g_settings_backend_flatten_tree;
  GSettingsBackend* function() c_g_settings_backend_get_default;
  void function(GSettingsBackend* backend, const(char)* key, void* originTag) c_g_settings_backend_changed;
  void function(GSettingsBackend* backend, GTree* tree, void* originTag) c_g_settings_backend_changed_tree;
  void function(GSettingsBackend* backend, const(char)* path, const(char*)* items, void* originTag) c_g_settings_backend_keys_changed;
  void function(GSettingsBackend* backend, const(char)* path, void* originTag) c_g_settings_backend_path_changed;
  void function(GSettingsBackend* backend, const(char)* path) c_g_settings_backend_path_writable_changed;
  void function(GSettingsBackend* backend, const(char)* key) c_g_settings_backend_writable_changed;

  // SettingsSchema
  GType function() c_g_settings_schema_get_type;
  const(char)* function(GSettingsSchema* schema) c_g_settings_schema_get_id;
  GSettingsSchemaKey* function(GSettingsSchema* schema, const(char)* name) c_g_settings_schema_get_key;
  const(char)* function(GSettingsSchema* schema) c_g_settings_schema_get_path;
  bool function(GSettingsSchema* schema, const(char)* name) c_g_settings_schema_has_key;
  char** function(GSettingsSchema* schema) c_g_settings_schema_list_children;
  char** function(GSettingsSchema* schema) c_g_settings_schema_list_keys;
  GSettingsSchema* function(GSettingsSchema* schema) c_g_settings_schema_ref;
  void function(GSettingsSchema* schema) c_g_settings_schema_unref;

  // SettingsSchemaKey
  GType function() c_g_settings_schema_key_get_type;
  GVariant* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_default_value;
  const(char)* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_description;
  const(char)* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_name;
  GVariant* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_range;
  const(char)* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_summary;
  const(GVariantType)* function(GSettingsSchemaKey* key) c_g_settings_schema_key_get_value_type;
  bool function(GSettingsSchemaKey* key, GVariant* value) c_g_settings_schema_key_range_check;
  GSettingsSchemaKey* function(GSettingsSchemaKey* key) c_g_settings_schema_key_ref;
  void function(GSettingsSchemaKey* key) c_g_settings_schema_key_unref;

  // SettingsSchemaSource
  GType function() c_g_settings_schema_source_get_type;
  GSettingsSchemaSource* function(const(char)* directory, GSettingsSchemaSource* parent, bool trusted, GError** _err) c_g_settings_schema_source_new_from_directory;
  void function(GSettingsSchemaSource* source, bool recursive, char*** nonRelocatable, char*** relocatable) c_g_settings_schema_source_list_schemas;
  GSettingsSchema* function(GSettingsSchemaSource* source, const(char)* schemaId, bool recursive) c_g_settings_schema_source_lookup;
  GSettingsSchemaSource* function(GSettingsSchemaSource* source) c_g_settings_schema_source_ref;
  void function(GSettingsSchemaSource* source) c_g_settings_schema_source_unref;
  GSettingsSchemaSource* function() c_g_settings_schema_source_get_default;

  // SimpleAction
  GType function() c_g_simple_action_get_type;
  GSimpleAction* function(const(char)* name, const(GVariantType)* parameterType) c_g_simple_action_new;
  GSimpleAction* function(const(char)* name, const(GVariantType)* parameterType, GVariant* state) c_g_simple_action_new_stateful;
  void function(GSimpleAction* simple, bool enabled) c_g_simple_action_set_enabled;
  void function(GSimpleAction* simple, GVariant* value) c_g_simple_action_set_state;
  void function(GSimpleAction* simple, GVariant* stateHint) c_g_simple_action_set_state_hint;

  // SimpleActionGroup
  GType function() c_g_simple_action_group_get_type;
  GSimpleActionGroup* function() c_g_simple_action_group_new;
  void function(GSimpleActionGroup* simple, const(GActionEntry)* entries, int nEntries, void* userData) c_g_simple_action_group_add_entries;
  void function(GSimpleActionGroup* simple, GAction* action) c_g_simple_action_group_insert;
  GAction* function(GSimpleActionGroup* simple, const(char)* actionName) c_g_simple_action_group_lookup;
  void function(GSimpleActionGroup* simple, const(char)* actionName) c_g_simple_action_group_remove;

  // SimpleAsyncResult
  GType function() c_g_simple_async_result_get_type;
  GSimpleAsyncResult* function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* userData, void* sourceTag) c_g_simple_async_result_new;
  GSimpleAsyncResult* function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* userData, GQuark domain, int code, const(char)* format,  ...) c_g_simple_async_result_new_error;
  GSimpleAsyncResult* function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* userData, const(GError)* error) c_g_simple_async_result_new_from_error;
  GSimpleAsyncResult* function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* userData, GError* error) c_g_simple_async_result_new_take_error;
  bool function(GAsyncResult* result, ObjectC* source, void* sourceTag) c_g_simple_async_result_is_valid;
  void function(GSimpleAsyncResult* simple) c_g_simple_async_result_complete;
  void function(GSimpleAsyncResult* simple) c_g_simple_async_result_complete_in_idle;
  bool function(GSimpleAsyncResult* simple) c_g_simple_async_result_get_op_res_gboolean;
  void* function(GSimpleAsyncResult* simple) c_g_simple_async_result_get_op_res_gpointer;
  ptrdiff_t function(GSimpleAsyncResult* simple) c_g_simple_async_result_get_op_res_gssize;
  void* function(GSimpleAsyncResult* simple) c_g_simple_async_result_get_source_tag;
  bool function(GSimpleAsyncResult* simple, GError** _err) c_g_simple_async_result_propagate_error;
  void function(GSimpleAsyncResult* simple, GSimpleAsyncThreadFunc func, int ioPriority, GCancellable* cancellable) c_g_simple_async_result_run_in_thread;
  void function(GSimpleAsyncResult* simple, GCancellable* checkCancellable) c_g_simple_async_result_set_check_cancellable;
  void function(GSimpleAsyncResult* simple, GQuark domain, int code, const(char)* format,  ...) c_g_simple_async_result_set_error;
  void function(GSimpleAsyncResult* simple, GQuark domain, int code, const(char)* format, void* args) c_g_simple_async_result_set_error_va;
  void function(GSimpleAsyncResult* simple, const(GError)* error) c_g_simple_async_result_set_from_error;
  void function(GSimpleAsyncResult* simple, bool handleCancellation) c_g_simple_async_result_set_handle_cancellation;
  void function(GSimpleAsyncResult* simple, bool opRes) c_g_simple_async_result_set_op_res_gboolean;
  void function(GSimpleAsyncResult* simple, void* opRes, GDestroyNotify destroyOpRes) c_g_simple_async_result_set_op_res_gpointer;
  void function(GSimpleAsyncResult* simple, ptrdiff_t opRes) c_g_simple_async_result_set_op_res_gssize;
  void function(GSimpleAsyncResult* simple, GError* error) c_g_simple_async_result_take_error;

  // SimpleIOStream
  GType function() c_g_simple_io_stream_get_type;
  GIOStream* function(GInputStream* inputStream, GOutputStream* outputStream) c_g_simple_io_stream_new;

  // SimplePermission
  GType function() c_g_simple_permission_get_type;
  GPermission* function(bool allowed) c_g_simple_permission_new;

  // SimpleProxyResolver
  GType function() c_g_simple_proxy_resolver_get_type;
  GProxyResolver* function(const(char)* defaultProxy, char** ignoreHosts) c_g_simple_proxy_resolver_new;
  void function(GSimpleProxyResolver* resolver, const(char)* defaultProxy) c_g_simple_proxy_resolver_set_default_proxy;
  void function(GSimpleProxyResolver* resolver, char** ignoreHosts) c_g_simple_proxy_resolver_set_ignore_hosts;
  void function(GSimpleProxyResolver* resolver, const(char)* uriScheme, const(char)* proxy) c_g_simple_proxy_resolver_set_uri_proxy;

  // Socket
  GType function() c_g_socket_get_type;
  GSocket* function(GSocketFamily family, GSocketType type, GSocketProtocol protocol, GError** _err) c_g_socket_new;
  GSocket* function(int fd, GError** _err) c_g_socket_new_from_fd;
  GSocket* function(GSocket* socket, GCancellable* cancellable, GError** _err) c_g_socket_accept;
  bool function(GSocket* socket, GSocketAddress* address, bool allowReuse, GError** _err) c_g_socket_bind;
  bool function(GSocket* socket, GError** _err) c_g_socket_check_connect_result;
  bool function(GSocket* socket, GError** _err) c_g_socket_close;
  GIOCondition function(GSocket* socket, GIOCondition condition) c_g_socket_condition_check;
  bool function(GSocket* socket, GIOCondition condition, long timeoutUs, GCancellable* cancellable, GError** _err) c_g_socket_condition_timed_wait;
  bool function(GSocket* socket, GIOCondition condition, GCancellable* cancellable, GError** _err) c_g_socket_condition_wait;
  bool function(GSocket* socket, GSocketAddress* address, GCancellable* cancellable, GError** _err) c_g_socket_connect;
  GSocketConnection* function(GSocket* socket) c_g_socket_connection_factory_create_connection;
  GSource* function(GSocket* socket, GIOCondition condition, GCancellable* cancellable) c_g_socket_create_source;
  ptrdiff_t function(GSocket* socket) c_g_socket_get_available_bytes;
  bool function(GSocket* socket) c_g_socket_get_blocking;
  bool function(GSocket* socket) c_g_socket_get_broadcast;
  GCredentials* function(GSocket* socket, GError** _err) c_g_socket_get_credentials;
  GSocketFamily function(GSocket* socket) c_g_socket_get_family;
  int function(GSocket* socket) c_g_socket_get_fd;
  bool function(GSocket* socket) c_g_socket_get_keepalive;
  int function(GSocket* socket) c_g_socket_get_listen_backlog;
  GSocketAddress* function(GSocket* socket, GError** _err) c_g_socket_get_local_address;
  bool function(GSocket* socket) c_g_socket_get_multicast_loopback;
  uint function(GSocket* socket) c_g_socket_get_multicast_ttl;
  bool function(GSocket* socket, int level, int optname, int* value, GError** _err) c_g_socket_get_option;
  GSocketProtocol function(GSocket* socket) c_g_socket_get_protocol;
  GSocketAddress* function(GSocket* socket, GError** _err) c_g_socket_get_remote_address;
  GSocketType function(GSocket* socket) c_g_socket_get_socket_type;
  uint function(GSocket* socket) c_g_socket_get_timeout;
  uint function(GSocket* socket) c_g_socket_get_ttl;
  bool function(GSocket* socket) c_g_socket_is_closed;
  bool function(GSocket* socket) c_g_socket_is_connected;
  bool function(GSocket* socket, GInetAddress* group, bool sourceSpecific, const(char)* iface, GError** _err) c_g_socket_join_multicast_group;
  bool function(GSocket* socket, GInetAddress* group, GInetAddress* sourceSpecific, const(char)* iface, GError** _err) c_g_socket_join_multicast_group_ssm;
  bool function(GSocket* socket, GInetAddress* group, bool sourceSpecific, const(char)* iface, GError** _err) c_g_socket_leave_multicast_group;
  bool function(GSocket* socket, GInetAddress* group, GInetAddress* sourceSpecific, const(char)* iface, GError** _err) c_g_socket_leave_multicast_group_ssm;
  bool function(GSocket* socket, GError** _err) c_g_socket_listen;
  ptrdiff_t function(GSocket* socket, ubyte* buffer, size_t size, GCancellable* cancellable, GError** _err) c_g_socket_receive;
  GBytes* function(GSocket* socket, size_t size, long timeoutUs, GCancellable* cancellable, GError** _err) c_g_socket_receive_bytes;
  GBytes* function(GSocket* socket, GSocketAddress** address, size_t size, long timeoutUs, GCancellable* cancellable, GError** _err) c_g_socket_receive_bytes_from;
  ptrdiff_t function(GSocket* socket, GSocketAddress** address, ubyte* buffer, size_t size, GCancellable* cancellable, GError** _err) c_g_socket_receive_from;
  ptrdiff_t function(GSocket* socket, GSocketAddress** address, GInputVector* vectors, int numVectors, GSocketControlMessage*** messages, int* numMessages, int* flags, GCancellable* cancellable, GError** _err) c_g_socket_receive_message;
  int function(GSocket* socket, GInputMessage* messages, uint numMessages, int flags, GCancellable* cancellable, GError** _err) c_g_socket_receive_messages;
  ptrdiff_t function(GSocket* socket, ubyte* buffer, size_t size, bool blocking, GCancellable* cancellable, GError** _err) c_g_socket_receive_with_blocking;
  ptrdiff_t function(GSocket* socket, const(ubyte)* buffer, size_t size, GCancellable* cancellable, GError** _err) c_g_socket_send;
  ptrdiff_t function(GSocket* socket, GSocketAddress* address, GOutputVector* vectors, int numVectors, GSocketControlMessage** messages, int numMessages, int flags, GCancellable* cancellable, GError** _err) c_g_socket_send_message;
  GPollableReturn function(GSocket* socket, GSocketAddress* address, const(GOutputVector)* vectors, int numVectors, GSocketControlMessage** messages, int numMessages, int flags, long timeoutUs, size_t* bytesWritten, GCancellable* cancellable, GError** _err) c_g_socket_send_message_with_timeout;
  int function(GSocket* socket, GOutputMessage* messages, uint numMessages, int flags, GCancellable* cancellable, GError** _err) c_g_socket_send_messages;
  ptrdiff_t function(GSocket* socket, GSocketAddress* address, const(ubyte)* buffer, size_t size, GCancellable* cancellable, GError** _err) c_g_socket_send_to;
  ptrdiff_t function(GSocket* socket, const(ubyte)* buffer, size_t size, bool blocking, GCancellable* cancellable, GError** _err) c_g_socket_send_with_blocking;
  void function(GSocket* socket, bool blocking) c_g_socket_set_blocking;
  void function(GSocket* socket, bool broadcast) c_g_socket_set_broadcast;
  void function(GSocket* socket, bool keepalive) c_g_socket_set_keepalive;
  void function(GSocket* socket, int backlog) c_g_socket_set_listen_backlog;
  void function(GSocket* socket, bool loopback) c_g_socket_set_multicast_loopback;
  void function(GSocket* socket, uint ttl) c_g_socket_set_multicast_ttl;
  bool function(GSocket* socket, int level, int optname, int value, GError** _err) c_g_socket_set_option;
  void function(GSocket* socket, uint timeout) c_g_socket_set_timeout;
  void function(GSocket* socket, uint ttl) c_g_socket_set_ttl;
  bool function(GSocket* socket, bool shutdownRead, bool shutdownWrite, GError** _err) c_g_socket_shutdown;
  bool function(GSocket* socket) c_g_socket_speaks_ipv4;

  // SocketAddress
  GType function() c_g_socket_address_get_type;
  GSocketAddress* function(void* native, size_t len) c_g_socket_address_new_from_native;
  GSocketFamily function(GSocketAddress* address) c_g_socket_address_get_family;
  ptrdiff_t function(GSocketAddress* address) c_g_socket_address_get_native_size;
  bool function(GSocketAddress* address, void* dest, size_t destlen, GError** _err) c_g_socket_address_to_native;

  // SocketAddressEnumerator
  GType function() c_g_socket_address_enumerator_get_type;
  GSocketAddress* function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GError** _err) c_g_socket_address_enumerator_next;
  void function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_address_enumerator_next_async;
  GSocketAddress* function(GSocketAddressEnumerator* enumerator, GAsyncResult* result, GError** _err) c_g_socket_address_enumerator_next_finish;

  // SocketClient
  GType function() c_g_socket_client_get_type;
  GSocketClient* function() c_g_socket_client_new;
  void function(GSocketClient* client, const(char)* protocol) c_g_socket_client_add_application_proxy;
  GSocketConnection* function(GSocketClient* client, GSocketConnectable* connectable, GCancellable* cancellable, GError** _err) c_g_socket_client_connect;
  void function(GSocketClient* client, GSocketConnectable* connectable, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_client_connect_async;
  GSocketConnection* function(GSocketClient* client, GAsyncResult* result, GError** _err) c_g_socket_client_connect_finish;
  GSocketConnection* function(GSocketClient* client, const(char)* hostAndPort, ushort defaultPort, GCancellable* cancellable, GError** _err) c_g_socket_client_connect_to_host;
  void function(GSocketClient* client, const(char)* hostAndPort, ushort defaultPort, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_client_connect_to_host_async;
  GSocketConnection* function(GSocketClient* client, GAsyncResult* result, GError** _err) c_g_socket_client_connect_to_host_finish;
  GSocketConnection* function(GSocketClient* client, const(char)* domain, const(char)* service, GCancellable* cancellable, GError** _err) c_g_socket_client_connect_to_service;
  void function(GSocketClient* client, const(char)* domain, const(char)* service, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_client_connect_to_service_async;
  GSocketConnection* function(GSocketClient* client, GAsyncResult* result, GError** _err) c_g_socket_client_connect_to_service_finish;
  GSocketConnection* function(GSocketClient* client, const(char)* uri, ushort defaultPort, GCancellable* cancellable, GError** _err) c_g_socket_client_connect_to_uri;
  void function(GSocketClient* client, const(char)* uri, ushort defaultPort, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_client_connect_to_uri_async;
  GSocketConnection* function(GSocketClient* client, GAsyncResult* result, GError** _err) c_g_socket_client_connect_to_uri_finish;
  bool function(GSocketClient* client) c_g_socket_client_get_enable_proxy;
  GSocketFamily function(GSocketClient* client) c_g_socket_client_get_family;
  GSocketAddress* function(GSocketClient* client) c_g_socket_client_get_local_address;
  GSocketProtocol function(GSocketClient* client) c_g_socket_client_get_protocol;
  GProxyResolver* function(GSocketClient* client) c_g_socket_client_get_proxy_resolver;
  GSocketType function(GSocketClient* client) c_g_socket_client_get_socket_type;
  uint function(GSocketClient* client) c_g_socket_client_get_timeout;
  bool function(GSocketClient* client) c_g_socket_client_get_tls;
  GTlsCertificateFlags function(GSocketClient* client) c_g_socket_client_get_tls_validation_flags;
  void function(GSocketClient* client, bool enable) c_g_socket_client_set_enable_proxy;
  void function(GSocketClient* client, GSocketFamily family) c_g_socket_client_set_family;
  void function(GSocketClient* client, GSocketAddress* address) c_g_socket_client_set_local_address;
  void function(GSocketClient* client, GSocketProtocol protocol) c_g_socket_client_set_protocol;
  void function(GSocketClient* client, GProxyResolver* proxyResolver) c_g_socket_client_set_proxy_resolver;
  void function(GSocketClient* client, GSocketType type) c_g_socket_client_set_socket_type;
  void function(GSocketClient* client, uint timeout) c_g_socket_client_set_timeout;
  void function(GSocketClient* client, bool tls) c_g_socket_client_set_tls;
  void function(GSocketClient* client, GTlsCertificateFlags flags) c_g_socket_client_set_tls_validation_flags;

  // SocketConnectable
  GType function() c_g_socket_connectable_get_type;
  GSocketAddressEnumerator* function(GSocketConnectable* connectable) c_g_socket_connectable_enumerate;
  GSocketAddressEnumerator* function(GSocketConnectable* connectable) c_g_socket_connectable_proxy_enumerate;
  char* function(GSocketConnectable* connectable) c_g_socket_connectable_to_string;

  // SocketConnection
  GType function() c_g_socket_connection_get_type;
  GType function(GSocketFamily family, GSocketType type, int protocolId) c_g_socket_connection_factory_lookup_type;
  void function(GType gType, GSocketFamily family, GSocketType type, int protocol) c_g_socket_connection_factory_register_type;
  bool function(GSocketConnection* connection, GSocketAddress* address, GCancellable* cancellable, GError** _err) c_g_socket_connection_connect;
  void function(GSocketConnection* connection, GSocketAddress* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_connection_connect_async;
  bool function(GSocketConnection* connection, GAsyncResult* result, GError** _err) c_g_socket_connection_connect_finish;
  GSocketAddress* function(GSocketConnection* connection, GError** _err) c_g_socket_connection_get_local_address;
  GSocketAddress* function(GSocketConnection* connection, GError** _err) c_g_socket_connection_get_remote_address;
  GSocket* function(GSocketConnection* connection) c_g_socket_connection_get_socket;
  bool function(GSocketConnection* connection) c_g_socket_connection_is_connected;

  // SocketControlMessage
  GType function() c_g_socket_control_message_get_type;
  GSocketControlMessage* function(int level, int type, size_t size, void* data) c_g_socket_control_message_deserialize;
  int function(GSocketControlMessage* message) c_g_socket_control_message_get_level;
  int function(GSocketControlMessage* message) c_g_socket_control_message_get_msg_type;
  size_t function(GSocketControlMessage* message) c_g_socket_control_message_get_size;
  void function(GSocketControlMessage* message, void* data) c_g_socket_control_message_serialize;

  // SocketListener
  GType function() c_g_socket_listener_get_type;
  GSocketListener* function() c_g_socket_listener_new;
  GSocketConnection* function(GSocketListener* listener, ObjectC** sourceObject, GCancellable* cancellable, GError** _err) c_g_socket_listener_accept;
  void function(GSocketListener* listener, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_listener_accept_async;
  GSocketConnection* function(GSocketListener* listener, GAsyncResult* result, ObjectC** sourceObject, GError** _err) c_g_socket_listener_accept_finish;
  GSocket* function(GSocketListener* listener, ObjectC** sourceObject, GCancellable* cancellable, GError** _err) c_g_socket_listener_accept_socket;
  void function(GSocketListener* listener, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_socket_listener_accept_socket_async;
  GSocket* function(GSocketListener* listener, GAsyncResult* result, ObjectC** sourceObject, GError** _err) c_g_socket_listener_accept_socket_finish;
  bool function(GSocketListener* listener, GSocketAddress* address, GSocketType type, GSocketProtocol protocol, ObjectC* sourceObject, GSocketAddress** effectiveAddress, GError** _err) c_g_socket_listener_add_address;
  ushort function(GSocketListener* listener, ObjectC* sourceObject, GError** _err) c_g_socket_listener_add_any_inet_port;
  bool function(GSocketListener* listener, ushort port, ObjectC* sourceObject, GError** _err) c_g_socket_listener_add_inet_port;
  bool function(GSocketListener* listener, GSocket* socket, ObjectC* sourceObject, GError** _err) c_g_socket_listener_add_socket;
  void function(GSocketListener* listener) c_g_socket_listener_close;
  void function(GSocketListener* listener, int listenBacklog) c_g_socket_listener_set_backlog;

  // SocketService
  GType function() c_g_socket_service_get_type;
  GSocketService* function() c_g_socket_service_new;
  bool function(GSocketService* service) c_g_socket_service_is_active;
  void function(GSocketService* service) c_g_socket_service_start;
  void function(GSocketService* service) c_g_socket_service_stop;

  // SrvTarget
  GType function() c_g_srv_target_get_type;
  GSrvTarget* function(const(char)* hostname, ushort port, ushort priority, ushort weight) c_g_srv_target_new;
  GSrvTarget* function(GSrvTarget* target) c_g_srv_target_copy;
  void function(GSrvTarget* target) c_g_srv_target_free;
  const(char)* function(GSrvTarget* target) c_g_srv_target_get_hostname;
  ushort function(GSrvTarget* target) c_g_srv_target_get_port;
  ushort function(GSrvTarget* target) c_g_srv_target_get_priority;
  ushort function(GSrvTarget* target) c_g_srv_target_get_weight;
  GList* function(GList* targets) c_g_srv_target_list_sort;

  // StaticResource
  void function(GStaticResource* staticResource) c_g_static_resource_fini;
  GResource* function(GStaticResource* staticResource) c_g_static_resource_get_resource;
  void function(GStaticResource* staticResource) c_g_static_resource_init;

  // Subprocess
  GType function() c_g_subprocess_get_type;
  GSubprocess* function(GSubprocessFlags flags, GError** error, const(char)* argv0,  ...) c_g_subprocess_new;
  GSubprocess* function(const(char*)* argv, GSubprocessFlags flags, GError** _err) c_g_subprocess_newv;
  bool function(GSubprocess* subprocess, GBytes* stdinBuf, GCancellable* cancellable, GBytes** stdoutBuf, GBytes** stderrBuf, GError** _err) c_g_subprocess_communicate;
  void function(GSubprocess* subprocess, GBytes* stdinBuf, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_subprocess_communicate_async;
  bool function(GSubprocess* subprocess, GAsyncResult* result, GBytes** stdoutBuf, GBytes** stderrBuf, GError** _err) c_g_subprocess_communicate_finish;
  bool function(GSubprocess* subprocess, const(char)* stdinBuf, GCancellable* cancellable, char** stdoutBuf, char** stderrBuf, GError** _err) c_g_subprocess_communicate_utf8;
  void function(GSubprocess* subprocess, const(char)* stdinBuf, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_subprocess_communicate_utf8_async;
  bool function(GSubprocess* subprocess, GAsyncResult* result, char** stdoutBuf, char** stderrBuf, GError** _err) c_g_subprocess_communicate_utf8_finish;
  void function(GSubprocess* subprocess) c_g_subprocess_force_exit;
  int function(GSubprocess* subprocess) c_g_subprocess_get_exit_status;
  const(char)* function(GSubprocess* subprocess) c_g_subprocess_get_identifier;
  bool function(GSubprocess* subprocess) c_g_subprocess_get_if_exited;
  bool function(GSubprocess* subprocess) c_g_subprocess_get_if_signaled;
  int function(GSubprocess* subprocess) c_g_subprocess_get_status;
  GInputStream* function(GSubprocess* subprocess) c_g_subprocess_get_stderr_pipe;
  GOutputStream* function(GSubprocess* subprocess) c_g_subprocess_get_stdin_pipe;
  GInputStream* function(GSubprocess* subprocess) c_g_subprocess_get_stdout_pipe;
  bool function(GSubprocess* subprocess) c_g_subprocess_get_successful;
  int function(GSubprocess* subprocess) c_g_subprocess_get_term_sig;
  void function(GSubprocess* subprocess, int signalNum) c_g_subprocess_send_signal;
  bool function(GSubprocess* subprocess, GCancellable* cancellable, GError** _err) c_g_subprocess_wait;
  void function(GSubprocess* subprocess, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_subprocess_wait_async;
  bool function(GSubprocess* subprocess, GCancellable* cancellable, GError** _err) c_g_subprocess_wait_check;
  void function(GSubprocess* subprocess, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_subprocess_wait_check_async;
  bool function(GSubprocess* subprocess, GAsyncResult* result, GError** _err) c_g_subprocess_wait_check_finish;
  bool function(GSubprocess* subprocess, GAsyncResult* result, GError** _err) c_g_subprocess_wait_finish;

  // SubprocessLauncher
  GType function() c_g_subprocess_launcher_get_type;
  GSubprocessLauncher* function(GSubprocessFlags flags) c_g_subprocess_launcher_new;
  void function(GSubprocessLauncher* self) c_g_subprocess_launcher_close;
  const(char)* function(GSubprocessLauncher* self, const(char)* variable) c_g_subprocess_launcher_getenv;
  void function(GSubprocessLauncher* self, GSpawnChildSetupFunc childSetup, void* userData, GDestroyNotify destroyNotify) c_g_subprocess_launcher_set_child_setup;
  void function(GSubprocessLauncher* self, const(char)* cwd) c_g_subprocess_launcher_set_cwd;
  void function(GSubprocessLauncher* self, char** env) c_g_subprocess_launcher_set_environ;
  void function(GSubprocessLauncher* self, GSubprocessFlags flags) c_g_subprocess_launcher_set_flags;
  void function(GSubprocessLauncher* self, const(char)* path) c_g_subprocess_launcher_set_stderr_file_path;
  void function(GSubprocessLauncher* self, const(char)* path) c_g_subprocess_launcher_set_stdin_file_path;
  void function(GSubprocessLauncher* self, const(char)* path) c_g_subprocess_launcher_set_stdout_file_path;
  void function(GSubprocessLauncher* self, const(char)* variable, const(char)* value, bool overwrite) c_g_subprocess_launcher_setenv;
  GSubprocess* function(GSubprocessLauncher* self, GError** error, const(char)* argv0,  ...) c_g_subprocess_launcher_spawn;
  GSubprocess* function(GSubprocessLauncher* self, const(char*)* argv, GError** _err) c_g_subprocess_launcher_spawnv;
  void function(GSubprocessLauncher* self, int sourceFd, int targetFd) c_g_subprocess_launcher_take_fd;
  void function(GSubprocessLauncher* self, int fd) c_g_subprocess_launcher_take_stderr_fd;
  void function(GSubprocessLauncher* self, int fd) c_g_subprocess_launcher_take_stdin_fd;
  void function(GSubprocessLauncher* self, int fd) c_g_subprocess_launcher_take_stdout_fd;
  void function(GSubprocessLauncher* self, const(char)* variable) c_g_subprocess_launcher_unsetenv;

  // Task
  GType function() c_g_task_get_type;
  GTask* function(ObjectC* sourceObject, GCancellable* cancellable, GAsyncReadyCallback callback, void* callbackData) c_g_task_new;
  bool function(GAsyncResult* result, ObjectC* sourceObject) c_g_task_is_valid;
  void function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* callbackData, void* sourceTag, GError* error) c_g_task_report_error;
  void function(ObjectC* sourceObject, GAsyncReadyCallback callback, void* callbackData, void* sourceTag, GQuark domain, int code, const(char)* format,  ...) c_g_task_report_new_error;
  void function(GTask* task, GSource* source, GSourceFunc callback) c_g_task_attach_source;
  GCancellable* function(GTask* task) c_g_task_get_cancellable;
  bool function(GTask* task) c_g_task_get_check_cancellable;
  bool function(GTask* task) c_g_task_get_completed;
  GMainContext* function(GTask* task) c_g_task_get_context;
  const(char)* function(GTask* task) c_g_task_get_name;
  int function(GTask* task) c_g_task_get_priority;
  bool function(GTask* task) c_g_task_get_return_on_cancel;
  ObjectC* function(GTask* task) c_g_task_get_source_object;
  void* function(GTask* task) c_g_task_get_source_tag;
  void* function(GTask* task) c_g_task_get_task_data;
  bool function(GTask* task) c_g_task_had_error;
  bool function(GTask* task, GError** _err) c_g_task_propagate_boolean;
  ptrdiff_t function(GTask* task, GError** _err) c_g_task_propagate_int;
  void* function(GTask* task, GError** _err) c_g_task_propagate_pointer;
  bool function(GTask* task, GValue* value, GError** _err) c_g_task_propagate_value;
  void function(GTask* task, bool result) c_g_task_return_boolean;
  void function(GTask* task, GError* error) c_g_task_return_error;
  bool function(GTask* task) c_g_task_return_error_if_cancelled;
  void function(GTask* task, ptrdiff_t result) c_g_task_return_int;
  void function(GTask* task, GQuark domain, int code, const(char)* format,  ...) c_g_task_return_new_error;
  void function(GTask* task, GQuark domain, int code, const(char)* message) c_g_task_return_new_error_literal;
  void function(GTask* task, void* result, GDestroyNotify resultDestroy) c_g_task_return_pointer;
  void function(GTask* task, GError* error, const(char)* format,  ...) c_g_task_return_prefixed_error;
  void function(GTask* task, GValue* result) c_g_task_return_value;
  void function(GTask* task, GTaskThreadFunc taskFunc) c_g_task_run_in_thread;
  void function(GTask* task, GTaskThreadFunc taskFunc) c_g_task_run_in_thread_sync;
  void function(GTask* task, bool checkCancellable) c_g_task_set_check_cancellable;
  void function(GTask* task, const(char)* name) c_g_task_set_name;
  void function(GTask* task, int priority) c_g_task_set_priority;
  bool function(GTask* task, bool returnOnCancel) c_g_task_set_return_on_cancel;
  void function(GTask* task, void* sourceTag) c_g_task_set_source_tag;
  void function(GTask* task, const(char)* name) c_g_task_set_static_name;
  void function(GTask* task, void* taskData, GDestroyNotify taskDataDestroy) c_g_task_set_task_data;

  // TcpConnection
  GType function() c_g_tcp_connection_get_type;
  bool function(GTcpConnection* connection) c_g_tcp_connection_get_graceful_disconnect;
  void function(GTcpConnection* connection, bool gracefulDisconnect) c_g_tcp_connection_set_graceful_disconnect;

  // TcpWrapperConnection
  GType function() c_g_tcp_wrapper_connection_get_type;
  GSocketConnection* function(GIOStream* baseIoStream, GSocket* socket) c_g_tcp_wrapper_connection_new;
  GIOStream* function(GTcpWrapperConnection* conn) c_g_tcp_wrapper_connection_get_base_io_stream;

  // TestDBus
  GType function() c_g_test_dbus_get_type;
  GTestDBus* function(GTestDBusFlags flags) c_g_test_dbus_new;
  void function() c_g_test_dbus_unset;
  void function(GTestDBus* self, const(char)* path) c_g_test_dbus_add_service_dir;
  void function(GTestDBus* self) c_g_test_dbus_down;
  const(char)* function(GTestDBus* self) c_g_test_dbus_get_bus_address;
  GTestDBusFlags function(GTestDBus* self) c_g_test_dbus_get_flags;
  void function(GTestDBus* self) c_g_test_dbus_stop;
  void function(GTestDBus* self) c_g_test_dbus_up;

  // ThemedIcon
  GType function() c_g_themed_icon_get_type;
  GIcon* function(const(char)* iconname) c_g_themed_icon_new;
  GIcon* function(char** iconnames, int len) c_g_themed_icon_new_from_names;
  GIcon* function(const(char)* iconname) c_g_themed_icon_new_with_default_fallbacks;
  void function(GThemedIcon* icon, const(char)* iconname) c_g_themed_icon_append_name;
  const(char*)* function(GThemedIcon* icon) c_g_themed_icon_get_names;
  void function(GThemedIcon* icon, const(char)* iconname) c_g_themed_icon_prepend_name;

  // ThreadedResolver
  GType function() c_g_threaded_resolver_get_type;

  // ThreadedSocketService
  GType function() c_g_threaded_socket_service_get_type;
  GSocketService* function(int maxThreads) c_g_threaded_socket_service_new;

  // TlsBackend
  GType function() c_g_tls_backend_get_type;
  GTlsBackend* function() c_g_tls_backend_get_default;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_certificate_type;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_client_connection_type;
  GTlsDatabase* function(GTlsBackend* backend) c_g_tls_backend_get_default_database;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_dtls_client_connection_type;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_dtls_server_connection_type;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_file_database_type;
  GType function(GTlsBackend* backend) c_g_tls_backend_get_server_connection_type;
  void function(GTlsBackend* backend, GTlsDatabase* database) c_g_tls_backend_set_default_database;
  bool function(GTlsBackend* backend) c_g_tls_backend_supports_dtls;
  bool function(GTlsBackend* backend) c_g_tls_backend_supports_tls;

  // TlsCertificate
  GType function() c_g_tls_certificate_get_type;
  GTlsCertificate* function(const(char)* file, GError** _err) c_g_tls_certificate_new_from_file;
  GTlsCertificate* function(const(char)* file, const(char)* password, GError** _err) c_g_tls_certificate_new_from_file_with_password;
  GTlsCertificate* function(const(char)* certFile, const(char)* keyFile, GError** _err) c_g_tls_certificate_new_from_files;
  GTlsCertificate* function(const(char)* data, ptrdiff_t length, GError** _err) c_g_tls_certificate_new_from_pem;
  GTlsCertificate* function(const(char)* pkcs11Uri, const(char)* privateKeyPkcs11Uri, GError** _err) c_g_tls_certificate_new_from_pkcs11_uris;
  GTlsCertificate* function(const(ubyte)* data, size_t length, const(char)* password, GError** _err) c_g_tls_certificate_new_from_pkcs12;
  GList* function(const(char)* file, GError** _err) c_g_tls_certificate_list_new_from_file;
  GPtrArray* function(GTlsCertificate* cert) c_g_tls_certificate_get_dns_names;
  GPtrArray* function(GTlsCertificate* cert) c_g_tls_certificate_get_ip_addresses;
  GTlsCertificate* function(GTlsCertificate* cert) c_g_tls_certificate_get_issuer;
  char* function(GTlsCertificate* cert) c_g_tls_certificate_get_issuer_name;
  GDateTime* function(GTlsCertificate* cert) c_g_tls_certificate_get_not_valid_after;
  GDateTime* function(GTlsCertificate* cert) c_g_tls_certificate_get_not_valid_before;
  char* function(GTlsCertificate* cert) c_g_tls_certificate_get_subject_name;
  bool function(GTlsCertificate* certOne, GTlsCertificate* certTwo) c_g_tls_certificate_is_same;
  GTlsCertificateFlags function(GTlsCertificate* cert, GSocketConnectable* identity, GTlsCertificate* trustedCa) c_g_tls_certificate_verify;

  // TlsClientConnection
  GType function() c_g_tls_client_connection_get_type;
  GIOStream* function(GIOStream* baseIoStream, GSocketConnectable* serverIdentity, GError** _err) c_g_tls_client_connection_new;
  void function(GTlsClientConnection* conn, GTlsClientConnection* source) c_g_tls_client_connection_copy_session_state;
  GList* function(GTlsClientConnection* conn) c_g_tls_client_connection_get_accepted_cas;
  GSocketConnectable* function(GTlsClientConnection* conn) c_g_tls_client_connection_get_server_identity;
  bool function(GTlsClientConnection* conn) c_g_tls_client_connection_get_use_ssl3;
  GTlsCertificateFlags function(GTlsClientConnection* conn) c_g_tls_client_connection_get_validation_flags;
  void function(GTlsClientConnection* conn, GSocketConnectable* identity) c_g_tls_client_connection_set_server_identity;
  void function(GTlsClientConnection* conn, bool useSsl3) c_g_tls_client_connection_set_use_ssl3;
  void function(GTlsClientConnection* conn, GTlsCertificateFlags flags) c_g_tls_client_connection_set_validation_flags;

  // TlsConnection
  GType function() c_g_tls_connection_get_type;
  bool function(GTlsConnection* conn, GTlsCertificate* peerCert, GTlsCertificateFlags errors) c_g_tls_connection_emit_accept_certificate;
  GTlsCertificate* function(GTlsConnection* conn) c_g_tls_connection_get_certificate;
  bool function(GTlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err) c_g_tls_connection_get_channel_binding_data;
  char* function(GTlsConnection* conn) c_g_tls_connection_get_ciphersuite_name;
  GTlsDatabase* function(GTlsConnection* conn) c_g_tls_connection_get_database;
  GTlsInteraction* function(GTlsConnection* conn) c_g_tls_connection_get_interaction;
  const(char)* function(GTlsConnection* conn) c_g_tls_connection_get_negotiated_protocol;
  GTlsCertificate* function(GTlsConnection* conn) c_g_tls_connection_get_peer_certificate;
  GTlsCertificateFlags function(GTlsConnection* conn) c_g_tls_connection_get_peer_certificate_errors;
  GTlsProtocolVersion function(GTlsConnection* conn) c_g_tls_connection_get_protocol_version;
  GTlsRehandshakeMode function(GTlsConnection* conn) c_g_tls_connection_get_rehandshake_mode;
  bool function(GTlsConnection* conn) c_g_tls_connection_get_require_close_notify;
  bool function(GTlsConnection* conn) c_g_tls_connection_get_use_system_certdb;
  bool function(GTlsConnection* conn, GCancellable* cancellable, GError** _err) c_g_tls_connection_handshake;
  void function(GTlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_connection_handshake_async;
  bool function(GTlsConnection* conn, GAsyncResult* result, GError** _err) c_g_tls_connection_handshake_finish;
  void function(GTlsConnection* conn, const(char*)* protocols) c_g_tls_connection_set_advertised_protocols;
  void function(GTlsConnection* conn, GTlsCertificate* certificate) c_g_tls_connection_set_certificate;
  void function(GTlsConnection* conn, GTlsDatabase* database) c_g_tls_connection_set_database;
  void function(GTlsConnection* conn, GTlsInteraction* interaction) c_g_tls_connection_set_interaction;
  void function(GTlsConnection* conn, GTlsRehandshakeMode mode) c_g_tls_connection_set_rehandshake_mode;
  void function(GTlsConnection* conn, bool requireCloseNotify) c_g_tls_connection_set_require_close_notify;
  void function(GTlsConnection* conn, bool useSystemCertdb) c_g_tls_connection_set_use_system_certdb;

  // TlsDatabase
  GType function() c_g_tls_database_get_type;
  char* function(GTlsDatabase* self, GTlsCertificate* certificate) c_g_tls_database_create_certificate_handle;
  GTlsCertificate* function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_database_lookup_certificate_for_handle;
  void function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_database_lookup_certificate_for_handle_async;
  GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) c_g_tls_database_lookup_certificate_for_handle_finish;
  GTlsCertificate* function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_database_lookup_certificate_issuer;
  void function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_database_lookup_certificate_issuer_async;
  GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) c_g_tls_database_lookup_certificate_issuer_finish;
  GList* function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_database_lookup_certificates_issued_by;
  void function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_database_lookup_certificates_issued_by_async;
  GList* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) c_g_tls_database_lookup_certificates_issued_by_finish;
  GTlsCertificateFlags function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_database_verify_chain;
  void function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_database_verify_chain_async;
  GTlsCertificateFlags function(GTlsDatabase* self, GAsyncResult* result, GError** _err) c_g_tls_database_verify_chain_finish;

  // TlsFileDatabase
  GType function() c_g_tls_file_database_get_type;
  GTlsDatabase* function(const(char)* anchors, GError** _err) c_g_tls_file_database_new;

  // TlsInteraction
  GType function() c_g_tls_interaction_get_type;
  GTlsInteractionResult function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GError** _err) c_g_tls_interaction_ask_password;
  void function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_interaction_ask_password_async;
  GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err) c_g_tls_interaction_ask_password_finish;
  GTlsInteractionResult function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GError** _err) c_g_tls_interaction_invoke_ask_password;
  GTlsInteractionResult function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_interaction_invoke_request_certificate;
  GTlsInteractionResult function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GError** _err) c_g_tls_interaction_request_certificate;
  void function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_tls_interaction_request_certificate_async;
  GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err) c_g_tls_interaction_request_certificate_finish;

  // TlsPassword
  GType function() c_g_tls_password_get_type;
  GTlsPassword* function(GTlsPasswordFlags flags, const(char)* description) c_g_tls_password_new;
  const(char)* function(GTlsPassword* password) c_g_tls_password_get_description;
  GTlsPasswordFlags function(GTlsPassword* password) c_g_tls_password_get_flags;
  const(ubyte)* function(GTlsPassword* password, size_t* length) c_g_tls_password_get_value;
  const(char)* function(GTlsPassword* password) c_g_tls_password_get_warning;
  void function(GTlsPassword* password, const(char)* description) c_g_tls_password_set_description;
  void function(GTlsPassword* password, GTlsPasswordFlags flags) c_g_tls_password_set_flags;
  void function(GTlsPassword* password, const(ubyte)* value, ptrdiff_t length) c_g_tls_password_set_value;
  void function(GTlsPassword* password, ubyte* value, ptrdiff_t length, GDestroyNotify destroy) c_g_tls_password_set_value_full;
  void function(GTlsPassword* password, const(char)* warning) c_g_tls_password_set_warning;

  // TlsServerConnection
  GType function() c_g_tls_server_connection_get_type;
  GIOStream* function(GIOStream* baseIoStream, GTlsCertificate* certificate, GError** _err) c_g_tls_server_connection_new;

  // UnixConnection
  GType function() c_g_unix_connection_get_type;
  GCredentials* function(GUnixConnection* connection, GCancellable* cancellable, GError** _err) c_g_unix_connection_receive_credentials;
  void function(GUnixConnection* connection, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_unix_connection_receive_credentials_async;
  GCredentials* function(GUnixConnection* connection, GAsyncResult* result, GError** _err) c_g_unix_connection_receive_credentials_finish;
  int function(GUnixConnection* connection, GCancellable* cancellable, GError** _err) c_g_unix_connection_receive_fd;
  bool function(GUnixConnection* connection, GCancellable* cancellable, GError** _err) c_g_unix_connection_send_credentials;
  void function(GUnixConnection* connection, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_unix_connection_send_credentials_async;
  bool function(GUnixConnection* connection, GAsyncResult* result, GError** _err) c_g_unix_connection_send_credentials_finish;
  bool function(GUnixConnection* connection, int fd, GCancellable* cancellable, GError** _err) c_g_unix_connection_send_fd;

  // UnixCredentialsMessage
  GType function() c_g_unix_credentials_message_get_type;
  GSocketControlMessage* function() c_g_unix_credentials_message_new;
  GSocketControlMessage* function(GCredentials* credentials) c_g_unix_credentials_message_new_with_credentials;
  bool function() c_g_unix_credentials_message_is_supported;
  GCredentials* function(GUnixCredentialsMessage* message) c_g_unix_credentials_message_get_credentials;

  // UnixFDList
  GType function() c_g_unix_fd_list_get_type;
  GUnixFDList* function() c_g_unix_fd_list_new;
  GUnixFDList* function(const(int)* fds, int nFds) c_g_unix_fd_list_new_from_array;
  int function(GUnixFDList* list, int fd, GError** _err) c_g_unix_fd_list_append;
  int function(GUnixFDList* list, int index, GError** _err) c_g_unix_fd_list_get;
  int function(GUnixFDList* list) c_g_unix_fd_list_get_length;
  const(int)* function(GUnixFDList* list, int* length) c_g_unix_fd_list_peek_fds;
  int* function(GUnixFDList* list, int* length) c_g_unix_fd_list_steal_fds;

  // UnixFDMessage
  GType function() c_g_unix_fd_message_get_type;
  GSocketControlMessage* function() c_g_unix_fd_message_new;
  GSocketControlMessage* function(GUnixFDList* fdList) c_g_unix_fd_message_new_with_fd_list;
  bool function(GUnixFDMessage* message, int fd, GError** _err) c_g_unix_fd_message_append_fd;
  GUnixFDList* function(GUnixFDMessage* message) c_g_unix_fd_message_get_fd_list;
  int* function(GUnixFDMessage* message, int* length) c_g_unix_fd_message_steal_fds;

  // UnixInputStream
  GType function() c_g_unix_input_stream_get_type;
  GInputStream* function(int fd, bool closeFd) c_g_unix_input_stream_new;
  bool function(GUnixInputStream* stream) c_g_unix_input_stream_get_close_fd;
  int function(GUnixInputStream* stream) c_g_unix_input_stream_get_fd;
  void function(GUnixInputStream* stream, bool closeFd) c_g_unix_input_stream_set_close_fd;

  // UnixMountEntry
  GType function() c_g_unix_mount_entry_get_type;

  // UnixMountMonitor
  GType function() c_g_unix_mount_monitor_get_type;
  GUnixMountMonitor* function() c_g_unix_mount_monitor_new;
  GUnixMountMonitor* function() c_g_unix_mount_monitor_get;
  void function(GUnixMountMonitor* mountMonitor, int limitMsec) c_g_unix_mount_monitor_set_rate_limit;

  // UnixMountPoint
  GType function() c_g_unix_mount_point_get_type;
  int function(GUnixMountPoint* mount1, GUnixMountPoint* mount2) c_g_unix_mount_point_compare;
  GUnixMountPoint* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_copy;
  void function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_free;
  const(char)* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_get_device_path;
  const(char)* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_get_fs_type;
  const(char)* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_get_mount_path;
  const(char)* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_get_options;
  bool function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_guess_can_eject;
  GIcon* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_guess_icon;
  char* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_guess_name;
  GIcon* function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_guess_symbolic_icon;
  bool function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_is_loopback;
  bool function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_is_readonly;
  bool function(GUnixMountPoint* mountPoint) c_g_unix_mount_point_is_user_mountable;
  GUnixMountPoint* function(const(char)* mountPath, ulong* timeRead) c_g_unix_mount_point_at;

  // UnixOutputStream
  GType function() c_g_unix_output_stream_get_type;
  GOutputStream* function(int fd, bool closeFd) c_g_unix_output_stream_new;
  bool function(GUnixOutputStream* stream) c_g_unix_output_stream_get_close_fd;
  int function(GUnixOutputStream* stream) c_g_unix_output_stream_get_fd;
  void function(GUnixOutputStream* stream, bool closeFd) c_g_unix_output_stream_set_close_fd;

  // UnixSocketAddress
  GType function() c_g_unix_socket_address_get_type;
  GSocketAddress* function(const(char)* path) c_g_unix_socket_address_new;
  GSocketAddress* function(const(char)* path, int pathLen) c_g_unix_socket_address_new_abstract;
  GSocketAddress* function(const(char)* path, int pathLen, GUnixSocketAddressType type) c_g_unix_socket_address_new_with_type;
  bool function() c_g_unix_socket_address_abstract_names_supported;
  GUnixSocketAddressType function(GUnixSocketAddress* address) c_g_unix_socket_address_get_address_type;
  bool function(GUnixSocketAddress* address) c_g_unix_socket_address_get_is_abstract;
  const(char)* function(GUnixSocketAddress* address) c_g_unix_socket_address_get_path;
  size_t function(GUnixSocketAddress* address) c_g_unix_socket_address_get_path_len;

  // Vfs
  GType function() c_g_vfs_get_type;
  GVfs* function() c_g_vfs_get_default;
  GVfs* function() c_g_vfs_get_local;
  GFile* function(GVfs* vfs, const(char)* path) c_g_vfs_get_file_for_path;
  GFile* function(GVfs* vfs, const(char)* uri) c_g_vfs_get_file_for_uri;
  const(char*)* function(GVfs* vfs) c_g_vfs_get_supported_uri_schemes;
  bool function(GVfs* vfs) c_g_vfs_is_active;
  GFile* function(GVfs* vfs, const(char)* parseName) c_g_vfs_parse_name;
  bool function(GVfs* vfs, const(char)* scheme, GVfsFileLookupFunc uriFunc, void* uriData, GDestroyNotify uriDestroy, GVfsFileLookupFunc parseNameFunc, void* parseNameData, GDestroyNotify parseNameDestroy) c_g_vfs_register_uri_scheme;
  bool function(GVfs* vfs, const(char)* scheme) c_g_vfs_unregister_uri_scheme;

  // Volume
  GType function() c_g_volume_get_type;
  bool function(GVolume* volume) c_g_volume_can_eject;
  bool function(GVolume* volume) c_g_volume_can_mount;
  void function(GVolume* volume, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_volume_eject;
  bool function(GVolume* volume, GAsyncResult* result, GError** _err) c_g_volume_eject_finish;
  void function(GVolume* volume, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_volume_eject_with_operation;
  bool function(GVolume* volume, GAsyncResult* result, GError** _err) c_g_volume_eject_with_operation_finish;
  char** function(GVolume* volume) c_g_volume_enumerate_identifiers;
  GFile* function(GVolume* volume) c_g_volume_get_activation_root;
  GDrive* function(GVolume* volume) c_g_volume_get_drive;
  GIcon* function(GVolume* volume) c_g_volume_get_icon;
  char* function(GVolume* volume, const(char)* kind) c_g_volume_get_identifier;
  GMount* function(GVolume* volume) c_g_volume_get_mount;
  char* function(GVolume* volume) c_g_volume_get_name;
  const(char)* function(GVolume* volume) c_g_volume_get_sort_key;
  GIcon* function(GVolume* volume) c_g_volume_get_symbolic_icon;
  char* function(GVolume* volume) c_g_volume_get_uuid;
  void function(GVolume* volume, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_g_volume_mount;
  bool function(GVolume* volume, GAsyncResult* result, GError** _err) c_g_volume_mount_finish;
  bool function(GVolume* volume) c_g_volume_should_automount;

  // VolumeMonitor
  GType function() c_g_volume_monitor_get_type;
  GVolume* function(GMount* mount) c_g_volume_monitor_adopt_orphan_mount;
  GVolumeMonitor* function() c_g_volume_monitor_get;
  GList* function(GVolumeMonitor* volumeMonitor) c_g_volume_monitor_get_connected_drives;
  GMount* function(GVolumeMonitor* volumeMonitor, const(char)* uuid) c_g_volume_monitor_get_mount_for_uuid;
  GList* function(GVolumeMonitor* volumeMonitor) c_g_volume_monitor_get_mounts;
  GVolume* function(GVolumeMonitor* volumeMonitor, const(char)* uuid) c_g_volume_monitor_get_volume_for_uuid;
  GList* function(GVolumeMonitor* volumeMonitor) c_g_volume_monitor_get_volumes;

  // ZlibCompressor
  GType function() c_g_zlib_compressor_get_type;
  GZlibCompressor* function(GZlibCompressorFormat format, int level) c_g_zlib_compressor_new;
  GFileInfo* function(GZlibCompressor* compressor) c_g_zlib_compressor_get_file_info;
  void function(GZlibCompressor* compressor, GFileInfo* fileInfo) c_g_zlib_compressor_set_file_info;

  // ZlibDecompressor
  GType function() c_g_zlib_decompressor_get_type;
  GZlibDecompressor* function(GZlibCompressorFormat format) c_g_zlib_decompressor_new;
  GFileInfo* function(GZlibDecompressor* decompressor) c_g_zlib_decompressor_get_file_info;
}

// Action
alias g_action_get_type = c_g_action_get_type;
alias g_action_name_is_valid = c_g_action_name_is_valid;
alias g_action_parse_detailed_name = c_g_action_parse_detailed_name;
alias g_action_print_detailed_name = c_g_action_print_detailed_name;
alias g_action_activate = c_g_action_activate;
alias g_action_change_state = c_g_action_change_state;
alias g_action_get_enabled = c_g_action_get_enabled;
alias g_action_get_name = c_g_action_get_name;
alias g_action_get_parameter_type = c_g_action_get_parameter_type;
alias g_action_get_state = c_g_action_get_state;
alias g_action_get_state_hint = c_g_action_get_state_hint;
alias g_action_get_state_type = c_g_action_get_state_type;

// ActionGroup
alias g_action_group_get_type = c_g_action_group_get_type;
alias g_action_group_action_added = c_g_action_group_action_added;
alias g_action_group_action_enabled_changed = c_g_action_group_action_enabled_changed;
alias g_action_group_action_removed = c_g_action_group_action_removed;
alias g_action_group_action_state_changed = c_g_action_group_action_state_changed;
alias g_action_group_activate_action = c_g_action_group_activate_action;
alias g_action_group_change_action_state = c_g_action_group_change_action_state;
alias g_action_group_get_action_enabled = c_g_action_group_get_action_enabled;
alias g_action_group_get_action_parameter_type = c_g_action_group_get_action_parameter_type;
alias g_action_group_get_action_state = c_g_action_group_get_action_state;
alias g_action_group_get_action_state_hint = c_g_action_group_get_action_state_hint;
alias g_action_group_get_action_state_type = c_g_action_group_get_action_state_type;
alias g_action_group_has_action = c_g_action_group_has_action;
alias g_action_group_list_actions = c_g_action_group_list_actions;
alias g_action_group_query_action = c_g_action_group_query_action;

// ActionMap
alias g_action_map_get_type = c_g_action_map_get_type;
alias g_action_map_add_action = c_g_action_map_add_action;
alias g_action_map_add_action_entries = c_g_action_map_add_action_entries;
alias g_action_map_lookup_action = c_g_action_map_lookup_action;
alias g_action_map_remove_action = c_g_action_map_remove_action;
alias g_action_map_remove_action_entries = c_g_action_map_remove_action_entries;

// AppInfo
alias g_app_info_get_type = c_g_app_info_get_type;
alias g_app_info_create_from_commandline = c_g_app_info_create_from_commandline;
alias g_app_info_get_all = c_g_app_info_get_all;
alias g_app_info_get_all_for_type = c_g_app_info_get_all_for_type;
alias g_app_info_get_default_for_type = c_g_app_info_get_default_for_type;
alias g_app_info_get_default_for_type_async = c_g_app_info_get_default_for_type_async;
alias g_app_info_get_default_for_type_finish = c_g_app_info_get_default_for_type_finish;
alias g_app_info_get_default_for_uri_scheme = c_g_app_info_get_default_for_uri_scheme;
alias g_app_info_get_default_for_uri_scheme_async = c_g_app_info_get_default_for_uri_scheme_async;
alias g_app_info_get_default_for_uri_scheme_finish = c_g_app_info_get_default_for_uri_scheme_finish;
alias g_app_info_get_fallback_for_type = c_g_app_info_get_fallback_for_type;
alias g_app_info_get_recommended_for_type = c_g_app_info_get_recommended_for_type;
alias g_app_info_launch_default_for_uri = c_g_app_info_launch_default_for_uri;
alias g_app_info_launch_default_for_uri_async = c_g_app_info_launch_default_for_uri_async;
alias g_app_info_launch_default_for_uri_finish = c_g_app_info_launch_default_for_uri_finish;
alias g_app_info_reset_type_associations = c_g_app_info_reset_type_associations;
alias g_app_info_add_supports_type = c_g_app_info_add_supports_type;
alias g_app_info_can_delete = c_g_app_info_can_delete;
alias g_app_info_can_remove_supports_type = c_g_app_info_can_remove_supports_type;
alias g_app_info_delete = c_g_app_info_delete;
alias g_app_info_dup = c_g_app_info_dup;
alias g_app_info_equal = c_g_app_info_equal;
alias g_app_info_get_commandline = c_g_app_info_get_commandline;
alias g_app_info_get_description = c_g_app_info_get_description;
alias g_app_info_get_display_name = c_g_app_info_get_display_name;
alias g_app_info_get_executable = c_g_app_info_get_executable;
alias g_app_info_get_icon = c_g_app_info_get_icon;
alias g_app_info_get_id = c_g_app_info_get_id;
alias g_app_info_get_name = c_g_app_info_get_name;
alias g_app_info_get_supported_types = c_g_app_info_get_supported_types;
alias g_app_info_launch = c_g_app_info_launch;
alias g_app_info_launch_uris = c_g_app_info_launch_uris;
alias g_app_info_launch_uris_async = c_g_app_info_launch_uris_async;
alias g_app_info_launch_uris_finish = c_g_app_info_launch_uris_finish;
alias g_app_info_remove_supports_type = c_g_app_info_remove_supports_type;
alias g_app_info_set_as_default_for_extension = c_g_app_info_set_as_default_for_extension;
alias g_app_info_set_as_default_for_type = c_g_app_info_set_as_default_for_type;
alias g_app_info_set_as_last_used_for_type = c_g_app_info_set_as_last_used_for_type;
alias g_app_info_should_show = c_g_app_info_should_show;
alias g_app_info_supports_files = c_g_app_info_supports_files;
alias g_app_info_supports_uris = c_g_app_info_supports_uris;

// AppInfoMonitor
alias g_app_info_monitor_get_type = c_g_app_info_monitor_get_type;
alias g_app_info_monitor_get = c_g_app_info_monitor_get;

// AppLaunchContext
alias g_app_launch_context_get_type = c_g_app_launch_context_get_type;
alias g_app_launch_context_new = c_g_app_launch_context_new;
alias g_app_launch_context_get_display = c_g_app_launch_context_get_display;
alias g_app_launch_context_get_environment = c_g_app_launch_context_get_environment;
alias g_app_launch_context_get_startup_notify_id = c_g_app_launch_context_get_startup_notify_id;
alias g_app_launch_context_launch_failed = c_g_app_launch_context_launch_failed;
alias g_app_launch_context_setenv = c_g_app_launch_context_setenv;
alias g_app_launch_context_unsetenv = c_g_app_launch_context_unsetenv;

// Application
alias g_application_get_type = c_g_application_get_type;
alias g_application_new = c_g_application_new;
alias g_application_get_default = c_g_application_get_default;
alias g_application_id_is_valid = c_g_application_id_is_valid;
alias g_application_activate = c_g_application_activate;
alias g_application_add_main_option = c_g_application_add_main_option;
alias g_application_add_main_option_entries = c_g_application_add_main_option_entries;
alias g_application_add_option_group = c_g_application_add_option_group;
alias g_application_bind_busy_property = c_g_application_bind_busy_property;
alias g_application_get_application_id = c_g_application_get_application_id;
alias g_application_get_dbus_connection = c_g_application_get_dbus_connection;
alias g_application_get_dbus_object_path = c_g_application_get_dbus_object_path;
alias g_application_get_flags = c_g_application_get_flags;
alias g_application_get_inactivity_timeout = c_g_application_get_inactivity_timeout;
alias g_application_get_is_busy = c_g_application_get_is_busy;
alias g_application_get_is_registered = c_g_application_get_is_registered;
alias g_application_get_is_remote = c_g_application_get_is_remote;
alias g_application_get_resource_base_path = c_g_application_get_resource_base_path;
alias g_application_get_version = c_g_application_get_version;
alias g_application_hold = c_g_application_hold;
alias g_application_mark_busy = c_g_application_mark_busy;
alias g_application_open = c_g_application_open;
alias g_application_quit = c_g_application_quit;
alias g_application_register = c_g_application_register;
alias g_application_release = c_g_application_release;
alias g_application_run = c_g_application_run;
alias g_application_send_notification = c_g_application_send_notification;
alias g_application_set_action_group = c_g_application_set_action_group;
alias g_application_set_application_id = c_g_application_set_application_id;
alias g_application_set_default = c_g_application_set_default;
alias g_application_set_flags = c_g_application_set_flags;
alias g_application_set_inactivity_timeout = c_g_application_set_inactivity_timeout;
alias g_application_set_option_context_description = c_g_application_set_option_context_description;
alias g_application_set_option_context_parameter_string = c_g_application_set_option_context_parameter_string;
alias g_application_set_option_context_summary = c_g_application_set_option_context_summary;
alias g_application_set_resource_base_path = c_g_application_set_resource_base_path;
alias g_application_set_version = c_g_application_set_version;
alias g_application_unbind_busy_property = c_g_application_unbind_busy_property;
alias g_application_unmark_busy = c_g_application_unmark_busy;
alias g_application_withdraw_notification = c_g_application_withdraw_notification;

// ApplicationCommandLine
alias g_application_command_line_get_type = c_g_application_command_line_get_type;
alias g_application_command_line_create_file_for_arg = c_g_application_command_line_create_file_for_arg;
alias g_application_command_line_done = c_g_application_command_line_done;
alias g_application_command_line_get_arguments = c_g_application_command_line_get_arguments;
alias g_application_command_line_get_cwd = c_g_application_command_line_get_cwd;
alias g_application_command_line_get_environ = c_g_application_command_line_get_environ;
alias g_application_command_line_get_exit_status = c_g_application_command_line_get_exit_status;
alias g_application_command_line_get_is_remote = c_g_application_command_line_get_is_remote;
alias g_application_command_line_get_options_dict = c_g_application_command_line_get_options_dict;
alias g_application_command_line_get_platform_data = c_g_application_command_line_get_platform_data;
alias g_application_command_line_get_stdin = c_g_application_command_line_get_stdin;
alias g_application_command_line_getenv = c_g_application_command_line_getenv;
alias g_application_command_line_print = c_g_application_command_line_print;
alias g_application_command_line_print_literal = c_g_application_command_line_print_literal;
alias g_application_command_line_printerr = c_g_application_command_line_printerr;
alias g_application_command_line_printerr_literal = c_g_application_command_line_printerr_literal;
alias g_application_command_line_set_exit_status = c_g_application_command_line_set_exit_status;

// AsyncInitable
alias g_async_initable_get_type = c_g_async_initable_get_type;
alias g_async_initable_new_async = c_g_async_initable_new_async;
alias g_async_initable_new_valist_async = c_g_async_initable_new_valist_async;
alias g_async_initable_newv_async = c_g_async_initable_newv_async;
alias g_async_initable_init_async = c_g_async_initable_init_async;
alias g_async_initable_init_finish = c_g_async_initable_init_finish;
alias g_async_initable_new_finish = c_g_async_initable_new_finish;

// AsyncResult
alias g_async_result_get_type = c_g_async_result_get_type;
alias g_async_result_get_source_object = c_g_async_result_get_source_object;
alias g_async_result_get_user_data = c_g_async_result_get_user_data;
alias g_async_result_is_tagged = c_g_async_result_is_tagged;
alias g_async_result_legacy_propagate_error = c_g_async_result_legacy_propagate_error;

// BufferedInputStream
alias g_buffered_input_stream_get_type = c_g_buffered_input_stream_get_type;
alias g_buffered_input_stream_new = c_g_buffered_input_stream_new;
alias g_buffered_input_stream_new_sized = c_g_buffered_input_stream_new_sized;
alias g_buffered_input_stream_fill = c_g_buffered_input_stream_fill;
alias g_buffered_input_stream_fill_async = c_g_buffered_input_stream_fill_async;
alias g_buffered_input_stream_fill_finish = c_g_buffered_input_stream_fill_finish;
alias g_buffered_input_stream_get_available = c_g_buffered_input_stream_get_available;
alias g_buffered_input_stream_get_buffer_size = c_g_buffered_input_stream_get_buffer_size;
alias g_buffered_input_stream_peek = c_g_buffered_input_stream_peek;
alias g_buffered_input_stream_peek_buffer = c_g_buffered_input_stream_peek_buffer;
alias g_buffered_input_stream_read_byte = c_g_buffered_input_stream_read_byte;
alias g_buffered_input_stream_set_buffer_size = c_g_buffered_input_stream_set_buffer_size;

// BufferedOutputStream
alias g_buffered_output_stream_get_type = c_g_buffered_output_stream_get_type;
alias g_buffered_output_stream_new = c_g_buffered_output_stream_new;
alias g_buffered_output_stream_new_sized = c_g_buffered_output_stream_new_sized;
alias g_buffered_output_stream_get_auto_grow = c_g_buffered_output_stream_get_auto_grow;
alias g_buffered_output_stream_get_buffer_size = c_g_buffered_output_stream_get_buffer_size;
alias g_buffered_output_stream_set_auto_grow = c_g_buffered_output_stream_set_auto_grow;
alias g_buffered_output_stream_set_buffer_size = c_g_buffered_output_stream_set_buffer_size;

// BytesIcon
alias g_bytes_icon_get_type = c_g_bytes_icon_get_type;
alias g_bytes_icon_new = c_g_bytes_icon_new;
alias g_bytes_icon_get_bytes = c_g_bytes_icon_get_bytes;

// Cancellable
alias g_cancellable_get_type = c_g_cancellable_get_type;
alias g_cancellable_new = c_g_cancellable_new;
alias g_cancellable_get_current = c_g_cancellable_get_current;
alias g_cancellable_cancel = c_g_cancellable_cancel;
alias g_cancellable_connect = c_g_cancellable_connect;
alias g_cancellable_disconnect = c_g_cancellable_disconnect;
alias g_cancellable_get_fd = c_g_cancellable_get_fd;
alias g_cancellable_is_cancelled = c_g_cancellable_is_cancelled;
alias g_cancellable_make_pollfd = c_g_cancellable_make_pollfd;
alias g_cancellable_pop_current = c_g_cancellable_pop_current;
alias g_cancellable_push_current = c_g_cancellable_push_current;
alias g_cancellable_release_fd = c_g_cancellable_release_fd;
alias g_cancellable_reset = c_g_cancellable_reset;
alias g_cancellable_set_error_if_cancelled = c_g_cancellable_set_error_if_cancelled;
alias g_cancellable_source_new = c_g_cancellable_source_new;

// CharsetConverter
alias g_charset_converter_get_type = c_g_charset_converter_get_type;
alias g_charset_converter_new = c_g_charset_converter_new;
alias g_charset_converter_get_num_fallbacks = c_g_charset_converter_get_num_fallbacks;
alias g_charset_converter_get_use_fallback = c_g_charset_converter_get_use_fallback;
alias g_charset_converter_set_use_fallback = c_g_charset_converter_set_use_fallback;

// Converter
alias g_converter_get_type = c_g_converter_get_type;
alias g_converter_convert = c_g_converter_convert;
alias g_converter_reset = c_g_converter_reset;

// ConverterInputStream
alias g_converter_input_stream_get_type = c_g_converter_input_stream_get_type;
alias g_converter_input_stream_new = c_g_converter_input_stream_new;
alias g_converter_input_stream_get_converter = c_g_converter_input_stream_get_converter;

// ConverterOutputStream
alias g_converter_output_stream_get_type = c_g_converter_output_stream_get_type;
alias g_converter_output_stream_new = c_g_converter_output_stream_new;
alias g_converter_output_stream_get_converter = c_g_converter_output_stream_get_converter;

// Credentials
alias g_credentials_get_type = c_g_credentials_get_type;
alias g_credentials_new = c_g_credentials_new;
alias g_credentials_get_native = c_g_credentials_get_native;
alias g_credentials_get_unix_pid = c_g_credentials_get_unix_pid;
alias g_credentials_get_unix_user = c_g_credentials_get_unix_user;
alias g_credentials_is_same_user = c_g_credentials_is_same_user;
alias g_credentials_set_native = c_g_credentials_set_native;
alias g_credentials_set_unix_user = c_g_credentials_set_unix_user;
alias g_credentials_to_string = c_g_credentials_to_string;

// DBusActionGroup
alias g_dbus_action_group_get_type = c_g_dbus_action_group_get_type;
alias g_dbus_action_group_get = c_g_dbus_action_group_get;

// DBusAnnotationInfo
alias g_dbus_annotation_info_get_type = c_g_dbus_annotation_info_get_type;
alias g_dbus_annotation_info_ref = c_g_dbus_annotation_info_ref;
alias g_dbus_annotation_info_unref = c_g_dbus_annotation_info_unref;
alias g_dbus_annotation_info_lookup = c_g_dbus_annotation_info_lookup;

// DBusArgInfo
alias g_dbus_arg_info_get_type = c_g_dbus_arg_info_get_type;
alias g_dbus_arg_info_ref = c_g_dbus_arg_info_ref;
alias g_dbus_arg_info_unref = c_g_dbus_arg_info_unref;

// DBusAuthObserver
alias g_dbus_auth_observer_get_type = c_g_dbus_auth_observer_get_type;
alias g_dbus_auth_observer_new = c_g_dbus_auth_observer_new;
alias g_dbus_auth_observer_allow_mechanism = c_g_dbus_auth_observer_allow_mechanism;
alias g_dbus_auth_observer_authorize_authenticated_peer = c_g_dbus_auth_observer_authorize_authenticated_peer;

// DBusConnection
alias g_dbus_connection_get_type = c_g_dbus_connection_get_type;
alias g_dbus_connection_new_finish = c_g_dbus_connection_new_finish;
alias g_dbus_connection_new_for_address_finish = c_g_dbus_connection_new_for_address_finish;
alias g_dbus_connection_new_for_address_sync = c_g_dbus_connection_new_for_address_sync;
alias g_dbus_connection_new_sync = c_g_dbus_connection_new_sync;
alias g_dbus_connection_new = c_g_dbus_connection_new;
alias g_dbus_connection_new_for_address = c_g_dbus_connection_new_for_address;
alias g_dbus_connection_add_filter = c_g_dbus_connection_add_filter;
alias g_dbus_connection_call = c_g_dbus_connection_call;
alias g_dbus_connection_call_finish = c_g_dbus_connection_call_finish;
alias g_dbus_connection_call_sync = c_g_dbus_connection_call_sync;
alias g_dbus_connection_call_with_unix_fd_list = c_g_dbus_connection_call_with_unix_fd_list;
alias g_dbus_connection_call_with_unix_fd_list_finish = c_g_dbus_connection_call_with_unix_fd_list_finish;
alias g_dbus_connection_call_with_unix_fd_list_sync = c_g_dbus_connection_call_with_unix_fd_list_sync;
alias g_dbus_connection_close = c_g_dbus_connection_close;
alias g_dbus_connection_close_finish = c_g_dbus_connection_close_finish;
alias g_dbus_connection_close_sync = c_g_dbus_connection_close_sync;
alias g_dbus_connection_emit_signal = c_g_dbus_connection_emit_signal;
alias g_dbus_connection_export_action_group = c_g_dbus_connection_export_action_group;
alias g_dbus_connection_export_menu_model = c_g_dbus_connection_export_menu_model;
alias g_dbus_connection_flush = c_g_dbus_connection_flush;
alias g_dbus_connection_flush_finish = c_g_dbus_connection_flush_finish;
alias g_dbus_connection_flush_sync = c_g_dbus_connection_flush_sync;
alias g_dbus_connection_get_capabilities = c_g_dbus_connection_get_capabilities;
alias g_dbus_connection_get_exit_on_close = c_g_dbus_connection_get_exit_on_close;
alias g_dbus_connection_get_flags = c_g_dbus_connection_get_flags;
alias g_dbus_connection_get_guid = c_g_dbus_connection_get_guid;
alias g_dbus_connection_get_last_serial = c_g_dbus_connection_get_last_serial;
alias g_dbus_connection_get_peer_credentials = c_g_dbus_connection_get_peer_credentials;
alias g_dbus_connection_get_stream = c_g_dbus_connection_get_stream;
alias g_dbus_connection_get_unique_name = c_g_dbus_connection_get_unique_name;
alias g_dbus_connection_is_closed = c_g_dbus_connection_is_closed;
alias g_dbus_connection_register_object = c_g_dbus_connection_register_object;
alias g_dbus_connection_register_object_with_closures = c_g_dbus_connection_register_object_with_closures;
alias g_dbus_connection_register_subtree = c_g_dbus_connection_register_subtree;
alias g_dbus_connection_remove_filter = c_g_dbus_connection_remove_filter;
alias g_dbus_connection_send_message = c_g_dbus_connection_send_message;
alias g_dbus_connection_send_message_with_reply = c_g_dbus_connection_send_message_with_reply;
alias g_dbus_connection_send_message_with_reply_finish = c_g_dbus_connection_send_message_with_reply_finish;
alias g_dbus_connection_send_message_with_reply_sync = c_g_dbus_connection_send_message_with_reply_sync;
alias g_dbus_connection_set_exit_on_close = c_g_dbus_connection_set_exit_on_close;
alias g_dbus_connection_signal_subscribe = c_g_dbus_connection_signal_subscribe;
alias g_dbus_connection_signal_unsubscribe = c_g_dbus_connection_signal_unsubscribe;
alias g_dbus_connection_start_message_processing = c_g_dbus_connection_start_message_processing;
alias g_dbus_connection_unexport_action_group = c_g_dbus_connection_unexport_action_group;
alias g_dbus_connection_unexport_menu_model = c_g_dbus_connection_unexport_menu_model;
alias g_dbus_connection_unregister_object = c_g_dbus_connection_unregister_object;
alias g_dbus_connection_unregister_subtree = c_g_dbus_connection_unregister_subtree;

// DBusInterface
alias g_dbus_interface_get_type = c_g_dbus_interface_get_type;
alias g_dbus_interface_dup_object = c_g_dbus_interface_dup_object;
alias g_dbus_interface_get_info = c_g_dbus_interface_get_info;
alias g_dbus_interface_get_object = c_g_dbus_interface_get_object;
alias g_dbus_interface_set_object = c_g_dbus_interface_set_object;

// DBusInterfaceInfo
alias g_dbus_interface_info_get_type = c_g_dbus_interface_info_get_type;
alias g_dbus_interface_info_cache_build = c_g_dbus_interface_info_cache_build;
alias g_dbus_interface_info_cache_release = c_g_dbus_interface_info_cache_release;
alias g_dbus_interface_info_generate_xml = c_g_dbus_interface_info_generate_xml;
alias g_dbus_interface_info_lookup_method = c_g_dbus_interface_info_lookup_method;
alias g_dbus_interface_info_lookup_property = c_g_dbus_interface_info_lookup_property;
alias g_dbus_interface_info_lookup_signal = c_g_dbus_interface_info_lookup_signal;
alias g_dbus_interface_info_ref = c_g_dbus_interface_info_ref;
alias g_dbus_interface_info_unref = c_g_dbus_interface_info_unref;

// DBusInterfaceSkeleton
alias g_dbus_interface_skeleton_get_type = c_g_dbus_interface_skeleton_get_type;
alias g_dbus_interface_skeleton_export = c_g_dbus_interface_skeleton_export;
alias g_dbus_interface_skeleton_flush = c_g_dbus_interface_skeleton_flush;
alias g_dbus_interface_skeleton_get_connection = c_g_dbus_interface_skeleton_get_connection;
alias g_dbus_interface_skeleton_get_connections = c_g_dbus_interface_skeleton_get_connections;
alias g_dbus_interface_skeleton_get_flags = c_g_dbus_interface_skeleton_get_flags;
alias g_dbus_interface_skeleton_get_info = c_g_dbus_interface_skeleton_get_info;
alias g_dbus_interface_skeleton_get_object_path = c_g_dbus_interface_skeleton_get_object_path;
alias g_dbus_interface_skeleton_get_properties = c_g_dbus_interface_skeleton_get_properties;
alias g_dbus_interface_skeleton_get_vtable = c_g_dbus_interface_skeleton_get_vtable;
alias g_dbus_interface_skeleton_has_connection = c_g_dbus_interface_skeleton_has_connection;
alias g_dbus_interface_skeleton_set_flags = c_g_dbus_interface_skeleton_set_flags;
alias g_dbus_interface_skeleton_unexport = c_g_dbus_interface_skeleton_unexport;
alias g_dbus_interface_skeleton_unexport_from_connection = c_g_dbus_interface_skeleton_unexport_from_connection;

// DBusMenuModel
alias g_dbus_menu_model_get_type = c_g_dbus_menu_model_get_type;
alias g_dbus_menu_model_get = c_g_dbus_menu_model_get;

// DBusMessage
alias g_dbus_message_get_type = c_g_dbus_message_get_type;
alias g_dbus_message_new = c_g_dbus_message_new;
alias g_dbus_message_new_from_blob = c_g_dbus_message_new_from_blob;
alias g_dbus_message_new_method_call = c_g_dbus_message_new_method_call;
alias g_dbus_message_new_signal = c_g_dbus_message_new_signal;
alias g_dbus_message_bytes_needed = c_g_dbus_message_bytes_needed;
alias g_dbus_message_copy = c_g_dbus_message_copy;
alias g_dbus_message_get_arg0 = c_g_dbus_message_get_arg0;
alias g_dbus_message_get_arg0_path = c_g_dbus_message_get_arg0_path;
alias g_dbus_message_get_body = c_g_dbus_message_get_body;
alias g_dbus_message_get_byte_order = c_g_dbus_message_get_byte_order;
alias g_dbus_message_get_destination = c_g_dbus_message_get_destination;
alias g_dbus_message_get_error_name = c_g_dbus_message_get_error_name;
alias g_dbus_message_get_flags = c_g_dbus_message_get_flags;
alias g_dbus_message_get_header = c_g_dbus_message_get_header;
alias g_dbus_message_get_header_fields = c_g_dbus_message_get_header_fields;
alias g_dbus_message_get_interface = c_g_dbus_message_get_interface;
alias g_dbus_message_get_locked = c_g_dbus_message_get_locked;
alias g_dbus_message_get_member = c_g_dbus_message_get_member;
alias g_dbus_message_get_message_type = c_g_dbus_message_get_message_type;
alias g_dbus_message_get_num_unix_fds = c_g_dbus_message_get_num_unix_fds;
alias g_dbus_message_get_path = c_g_dbus_message_get_path;
alias g_dbus_message_get_reply_serial = c_g_dbus_message_get_reply_serial;
alias g_dbus_message_get_sender = c_g_dbus_message_get_sender;
alias g_dbus_message_get_serial = c_g_dbus_message_get_serial;
alias g_dbus_message_get_signature = c_g_dbus_message_get_signature;
alias g_dbus_message_get_unix_fd_list = c_g_dbus_message_get_unix_fd_list;
alias g_dbus_message_lock = c_g_dbus_message_lock;
alias g_dbus_message_new_method_error = c_g_dbus_message_new_method_error;
alias g_dbus_message_new_method_error_literal = c_g_dbus_message_new_method_error_literal;
alias g_dbus_message_new_method_error_valist = c_g_dbus_message_new_method_error_valist;
alias g_dbus_message_new_method_reply = c_g_dbus_message_new_method_reply;
alias g_dbus_message_print = c_g_dbus_message_print;
alias g_dbus_message_set_body = c_g_dbus_message_set_body;
alias g_dbus_message_set_byte_order = c_g_dbus_message_set_byte_order;
alias g_dbus_message_set_destination = c_g_dbus_message_set_destination;
alias g_dbus_message_set_error_name = c_g_dbus_message_set_error_name;
alias g_dbus_message_set_flags = c_g_dbus_message_set_flags;
alias g_dbus_message_set_header = c_g_dbus_message_set_header;
alias g_dbus_message_set_interface = c_g_dbus_message_set_interface;
alias g_dbus_message_set_member = c_g_dbus_message_set_member;
alias g_dbus_message_set_message_type = c_g_dbus_message_set_message_type;
alias g_dbus_message_set_num_unix_fds = c_g_dbus_message_set_num_unix_fds;
alias g_dbus_message_set_path = c_g_dbus_message_set_path;
alias g_dbus_message_set_reply_serial = c_g_dbus_message_set_reply_serial;
alias g_dbus_message_set_sender = c_g_dbus_message_set_sender;
alias g_dbus_message_set_serial = c_g_dbus_message_set_serial;
alias g_dbus_message_set_signature = c_g_dbus_message_set_signature;
alias g_dbus_message_set_unix_fd_list = c_g_dbus_message_set_unix_fd_list;
alias g_dbus_message_to_blob = c_g_dbus_message_to_blob;
alias g_dbus_message_to_gerror = c_g_dbus_message_to_gerror;

// DBusMethodInfo
alias g_dbus_method_info_get_type = c_g_dbus_method_info_get_type;
alias g_dbus_method_info_ref = c_g_dbus_method_info_ref;
alias g_dbus_method_info_unref = c_g_dbus_method_info_unref;

// DBusMethodInvocation
alias g_dbus_method_invocation_get_type = c_g_dbus_method_invocation_get_type;
alias g_dbus_method_invocation_get_connection = c_g_dbus_method_invocation_get_connection;
alias g_dbus_method_invocation_get_interface_name = c_g_dbus_method_invocation_get_interface_name;
alias g_dbus_method_invocation_get_message = c_g_dbus_method_invocation_get_message;
alias g_dbus_method_invocation_get_method_info = c_g_dbus_method_invocation_get_method_info;
alias g_dbus_method_invocation_get_method_name = c_g_dbus_method_invocation_get_method_name;
alias g_dbus_method_invocation_get_object_path = c_g_dbus_method_invocation_get_object_path;
alias g_dbus_method_invocation_get_parameters = c_g_dbus_method_invocation_get_parameters;
alias g_dbus_method_invocation_get_property_info = c_g_dbus_method_invocation_get_property_info;
alias g_dbus_method_invocation_get_sender = c_g_dbus_method_invocation_get_sender;
alias g_dbus_method_invocation_get_user_data = c_g_dbus_method_invocation_get_user_data;
alias g_dbus_method_invocation_return_dbus_error = c_g_dbus_method_invocation_return_dbus_error;
alias g_dbus_method_invocation_return_error = c_g_dbus_method_invocation_return_error;
alias g_dbus_method_invocation_return_error_literal = c_g_dbus_method_invocation_return_error_literal;
alias g_dbus_method_invocation_return_error_valist = c_g_dbus_method_invocation_return_error_valist;
alias g_dbus_method_invocation_return_gerror = c_g_dbus_method_invocation_return_gerror;
alias g_dbus_method_invocation_return_value = c_g_dbus_method_invocation_return_value;
alias g_dbus_method_invocation_return_value_with_unix_fd_list = c_g_dbus_method_invocation_return_value_with_unix_fd_list;
alias g_dbus_method_invocation_take_error = c_g_dbus_method_invocation_take_error;

// DBusNodeInfo
alias g_dbus_node_info_get_type = c_g_dbus_node_info_get_type;
alias g_dbus_node_info_new_for_xml = c_g_dbus_node_info_new_for_xml;
alias g_dbus_node_info_generate_xml = c_g_dbus_node_info_generate_xml;
alias g_dbus_node_info_lookup_interface = c_g_dbus_node_info_lookup_interface;
alias g_dbus_node_info_ref = c_g_dbus_node_info_ref;
alias g_dbus_node_info_unref = c_g_dbus_node_info_unref;

// DBusObject
alias g_dbus_object_get_type = c_g_dbus_object_get_type;
alias g_dbus_object_get_interface = c_g_dbus_object_get_interface;
alias g_dbus_object_get_interfaces = c_g_dbus_object_get_interfaces;
alias g_dbus_object_get_object_path = c_g_dbus_object_get_object_path;

// DBusObjectManager
alias g_dbus_object_manager_get_type = c_g_dbus_object_manager_get_type;
alias g_dbus_object_manager_get_interface = c_g_dbus_object_manager_get_interface;
alias g_dbus_object_manager_get_object = c_g_dbus_object_manager_get_object;
alias g_dbus_object_manager_get_object_path = c_g_dbus_object_manager_get_object_path;
alias g_dbus_object_manager_get_objects = c_g_dbus_object_manager_get_objects;

// DBusObjectManagerClient
alias g_dbus_object_manager_client_get_type = c_g_dbus_object_manager_client_get_type;
alias g_dbus_object_manager_client_new_finish = c_g_dbus_object_manager_client_new_finish;
alias g_dbus_object_manager_client_new_for_bus_finish = c_g_dbus_object_manager_client_new_for_bus_finish;
alias g_dbus_object_manager_client_new_for_bus_sync = c_g_dbus_object_manager_client_new_for_bus_sync;
alias g_dbus_object_manager_client_new_sync = c_g_dbus_object_manager_client_new_sync;
alias g_dbus_object_manager_client_new = c_g_dbus_object_manager_client_new;
alias g_dbus_object_manager_client_new_for_bus = c_g_dbus_object_manager_client_new_for_bus;
alias g_dbus_object_manager_client_get_connection = c_g_dbus_object_manager_client_get_connection;
alias g_dbus_object_manager_client_get_flags = c_g_dbus_object_manager_client_get_flags;
alias g_dbus_object_manager_client_get_name = c_g_dbus_object_manager_client_get_name;
alias g_dbus_object_manager_client_get_name_owner = c_g_dbus_object_manager_client_get_name_owner;

// DBusObjectManagerServer
alias g_dbus_object_manager_server_get_type = c_g_dbus_object_manager_server_get_type;
alias g_dbus_object_manager_server_new = c_g_dbus_object_manager_server_new;
alias g_dbus_object_manager_server_export = c_g_dbus_object_manager_server_export;
alias g_dbus_object_manager_server_export_uniquely = c_g_dbus_object_manager_server_export_uniquely;
alias g_dbus_object_manager_server_get_connection = c_g_dbus_object_manager_server_get_connection;
alias g_dbus_object_manager_server_is_exported = c_g_dbus_object_manager_server_is_exported;
alias g_dbus_object_manager_server_set_connection = c_g_dbus_object_manager_server_set_connection;
alias g_dbus_object_manager_server_unexport = c_g_dbus_object_manager_server_unexport;

// DBusObjectProxy
alias g_dbus_object_proxy_get_type = c_g_dbus_object_proxy_get_type;
alias g_dbus_object_proxy_new = c_g_dbus_object_proxy_new;
alias g_dbus_object_proxy_get_connection = c_g_dbus_object_proxy_get_connection;

// DBusObjectSkeleton
alias g_dbus_object_skeleton_get_type = c_g_dbus_object_skeleton_get_type;
alias g_dbus_object_skeleton_new = c_g_dbus_object_skeleton_new;
alias g_dbus_object_skeleton_add_interface = c_g_dbus_object_skeleton_add_interface;
alias g_dbus_object_skeleton_flush = c_g_dbus_object_skeleton_flush;
alias g_dbus_object_skeleton_remove_interface = c_g_dbus_object_skeleton_remove_interface;
alias g_dbus_object_skeleton_remove_interface_by_name = c_g_dbus_object_skeleton_remove_interface_by_name;
alias g_dbus_object_skeleton_set_object_path = c_g_dbus_object_skeleton_set_object_path;

// DBusPropertyInfo
alias g_dbus_property_info_get_type = c_g_dbus_property_info_get_type;
alias g_dbus_property_info_ref = c_g_dbus_property_info_ref;
alias g_dbus_property_info_unref = c_g_dbus_property_info_unref;

// DBusProxy
alias g_dbus_proxy_get_type = c_g_dbus_proxy_get_type;
alias g_dbus_proxy_new_finish = c_g_dbus_proxy_new_finish;
alias g_dbus_proxy_new_for_bus_finish = c_g_dbus_proxy_new_for_bus_finish;
alias g_dbus_proxy_new_for_bus_sync = c_g_dbus_proxy_new_for_bus_sync;
alias g_dbus_proxy_new_sync = c_g_dbus_proxy_new_sync;
alias g_dbus_proxy_new = c_g_dbus_proxy_new;
alias g_dbus_proxy_new_for_bus = c_g_dbus_proxy_new_for_bus;
alias g_dbus_proxy_call = c_g_dbus_proxy_call;
alias g_dbus_proxy_call_finish = c_g_dbus_proxy_call_finish;
alias g_dbus_proxy_call_sync = c_g_dbus_proxy_call_sync;
alias g_dbus_proxy_call_with_unix_fd_list = c_g_dbus_proxy_call_with_unix_fd_list;
alias g_dbus_proxy_call_with_unix_fd_list_finish = c_g_dbus_proxy_call_with_unix_fd_list_finish;
alias g_dbus_proxy_call_with_unix_fd_list_sync = c_g_dbus_proxy_call_with_unix_fd_list_sync;
alias g_dbus_proxy_get_cached_property = c_g_dbus_proxy_get_cached_property;
alias g_dbus_proxy_get_cached_property_names = c_g_dbus_proxy_get_cached_property_names;
alias g_dbus_proxy_get_connection = c_g_dbus_proxy_get_connection;
alias g_dbus_proxy_get_default_timeout = c_g_dbus_proxy_get_default_timeout;
alias g_dbus_proxy_get_flags = c_g_dbus_proxy_get_flags;
alias g_dbus_proxy_get_interface_info = c_g_dbus_proxy_get_interface_info;
alias g_dbus_proxy_get_interface_name = c_g_dbus_proxy_get_interface_name;
alias g_dbus_proxy_get_name = c_g_dbus_proxy_get_name;
alias g_dbus_proxy_get_name_owner = c_g_dbus_proxy_get_name_owner;
alias g_dbus_proxy_get_object_path = c_g_dbus_proxy_get_object_path;
alias g_dbus_proxy_set_cached_property = c_g_dbus_proxy_set_cached_property;
alias g_dbus_proxy_set_default_timeout = c_g_dbus_proxy_set_default_timeout;
alias g_dbus_proxy_set_interface_info = c_g_dbus_proxy_set_interface_info;

// DBusServer
alias g_dbus_server_get_type = c_g_dbus_server_get_type;
alias g_dbus_server_new_sync = c_g_dbus_server_new_sync;
alias g_dbus_server_get_client_address = c_g_dbus_server_get_client_address;
alias g_dbus_server_get_flags = c_g_dbus_server_get_flags;
alias g_dbus_server_get_guid = c_g_dbus_server_get_guid;
alias g_dbus_server_is_active = c_g_dbus_server_is_active;
alias g_dbus_server_start = c_g_dbus_server_start;
alias g_dbus_server_stop = c_g_dbus_server_stop;

// DBusSignalInfo
alias g_dbus_signal_info_get_type = c_g_dbus_signal_info_get_type;
alias g_dbus_signal_info_ref = c_g_dbus_signal_info_ref;
alias g_dbus_signal_info_unref = c_g_dbus_signal_info_unref;

// DataInputStream
alias g_data_input_stream_get_type = c_g_data_input_stream_get_type;
alias g_data_input_stream_new = c_g_data_input_stream_new;
alias g_data_input_stream_get_byte_order = c_g_data_input_stream_get_byte_order;
alias g_data_input_stream_get_newline_type = c_g_data_input_stream_get_newline_type;
alias g_data_input_stream_read_byte = c_g_data_input_stream_read_byte;
alias g_data_input_stream_read_int16 = c_g_data_input_stream_read_int16;
alias g_data_input_stream_read_int32 = c_g_data_input_stream_read_int32;
alias g_data_input_stream_read_int64 = c_g_data_input_stream_read_int64;
alias g_data_input_stream_read_line = c_g_data_input_stream_read_line;
alias g_data_input_stream_read_line_async = c_g_data_input_stream_read_line_async;
alias g_data_input_stream_read_line_finish = c_g_data_input_stream_read_line_finish;
alias g_data_input_stream_read_line_finish_utf8 = c_g_data_input_stream_read_line_finish_utf8;
alias g_data_input_stream_read_line_utf8 = c_g_data_input_stream_read_line_utf8;
alias g_data_input_stream_read_uint16 = c_g_data_input_stream_read_uint16;
alias g_data_input_stream_read_uint32 = c_g_data_input_stream_read_uint32;
alias g_data_input_stream_read_uint64 = c_g_data_input_stream_read_uint64;
alias g_data_input_stream_read_until = c_g_data_input_stream_read_until;
alias g_data_input_stream_read_until_async = c_g_data_input_stream_read_until_async;
alias g_data_input_stream_read_until_finish = c_g_data_input_stream_read_until_finish;
alias g_data_input_stream_read_upto = c_g_data_input_stream_read_upto;
alias g_data_input_stream_read_upto_async = c_g_data_input_stream_read_upto_async;
alias g_data_input_stream_read_upto_finish = c_g_data_input_stream_read_upto_finish;
alias g_data_input_stream_set_byte_order = c_g_data_input_stream_set_byte_order;
alias g_data_input_stream_set_newline_type = c_g_data_input_stream_set_newline_type;

// DataOutputStream
alias g_data_output_stream_get_type = c_g_data_output_stream_get_type;
alias g_data_output_stream_new = c_g_data_output_stream_new;
alias g_data_output_stream_get_byte_order = c_g_data_output_stream_get_byte_order;
alias g_data_output_stream_put_byte = c_g_data_output_stream_put_byte;
alias g_data_output_stream_put_int16 = c_g_data_output_stream_put_int16;
alias g_data_output_stream_put_int32 = c_g_data_output_stream_put_int32;
alias g_data_output_stream_put_int64 = c_g_data_output_stream_put_int64;
alias g_data_output_stream_put_string = c_g_data_output_stream_put_string;
alias g_data_output_stream_put_uint16 = c_g_data_output_stream_put_uint16;
alias g_data_output_stream_put_uint32 = c_g_data_output_stream_put_uint32;
alias g_data_output_stream_put_uint64 = c_g_data_output_stream_put_uint64;
alias g_data_output_stream_set_byte_order = c_g_data_output_stream_set_byte_order;

// DatagramBased
alias g_datagram_based_get_type = c_g_datagram_based_get_type;
alias g_datagram_based_condition_check = c_g_datagram_based_condition_check;
alias g_datagram_based_condition_wait = c_g_datagram_based_condition_wait;
alias g_datagram_based_create_source = c_g_datagram_based_create_source;
alias g_datagram_based_receive_messages = c_g_datagram_based_receive_messages;
alias g_datagram_based_send_messages = c_g_datagram_based_send_messages;

// DebugController
alias g_debug_controller_get_type = c_g_debug_controller_get_type;
alias g_debug_controller_get_debug_enabled = c_g_debug_controller_get_debug_enabled;
alias g_debug_controller_set_debug_enabled = c_g_debug_controller_set_debug_enabled;

// DebugControllerDBus
alias g_debug_controller_dbus_get_type = c_g_debug_controller_dbus_get_type;
alias g_debug_controller_dbus_new = c_g_debug_controller_dbus_new;
alias g_debug_controller_dbus_stop = c_g_debug_controller_dbus_stop;

// DesktopAppInfo
alias g_desktop_app_info_get_type = c_g_desktop_app_info_get_type;
alias g_desktop_app_info_new = c_g_desktop_app_info_new;
alias g_desktop_app_info_new_from_filename = c_g_desktop_app_info_new_from_filename;
alias g_desktop_app_info_new_from_keyfile = c_g_desktop_app_info_new_from_keyfile;
alias g_desktop_app_info_get_implementations = c_g_desktop_app_info_get_implementations;
alias g_desktop_app_info_search = c_g_desktop_app_info_search;
alias g_desktop_app_info_set_desktop_env = c_g_desktop_app_info_set_desktop_env;
alias g_desktop_app_info_get_action_name = c_g_desktop_app_info_get_action_name;
alias g_desktop_app_info_get_boolean = c_g_desktop_app_info_get_boolean;
alias g_desktop_app_info_get_categories = c_g_desktop_app_info_get_categories;
alias g_desktop_app_info_get_filename = c_g_desktop_app_info_get_filename;
alias g_desktop_app_info_get_generic_name = c_g_desktop_app_info_get_generic_name;
alias g_desktop_app_info_get_is_hidden = c_g_desktop_app_info_get_is_hidden;
alias g_desktop_app_info_get_keywords = c_g_desktop_app_info_get_keywords;
alias g_desktop_app_info_get_locale_string = c_g_desktop_app_info_get_locale_string;
alias g_desktop_app_info_get_nodisplay = c_g_desktop_app_info_get_nodisplay;
alias g_desktop_app_info_get_show_in = c_g_desktop_app_info_get_show_in;
alias g_desktop_app_info_get_startup_wm_class = c_g_desktop_app_info_get_startup_wm_class;
alias g_desktop_app_info_get_string = c_g_desktop_app_info_get_string;
alias g_desktop_app_info_get_string_list = c_g_desktop_app_info_get_string_list;
alias g_desktop_app_info_has_key = c_g_desktop_app_info_has_key;
alias g_desktop_app_info_launch_action = c_g_desktop_app_info_launch_action;
alias g_desktop_app_info_launch_uris_as_manager = c_g_desktop_app_info_launch_uris_as_manager;
alias g_desktop_app_info_launch_uris_as_manager_with_fds = c_g_desktop_app_info_launch_uris_as_manager_with_fds;
alias g_desktop_app_info_list_actions = c_g_desktop_app_info_list_actions;

// DesktopAppInfoLookup
alias g_desktop_app_info_lookup_get_type = c_g_desktop_app_info_lookup_get_type;
alias g_desktop_app_info_lookup_get_default_for_uri_scheme = c_g_desktop_app_info_lookup_get_default_for_uri_scheme;

// Drive
alias g_drive_get_type = c_g_drive_get_type;
alias g_drive_can_eject = c_g_drive_can_eject;
alias g_drive_can_poll_for_media = c_g_drive_can_poll_for_media;
alias g_drive_can_start = c_g_drive_can_start;
alias g_drive_can_start_degraded = c_g_drive_can_start_degraded;
alias g_drive_can_stop = c_g_drive_can_stop;
alias g_drive_eject = c_g_drive_eject;
alias g_drive_eject_finish = c_g_drive_eject_finish;
alias g_drive_eject_with_operation = c_g_drive_eject_with_operation;
alias g_drive_eject_with_operation_finish = c_g_drive_eject_with_operation_finish;
alias g_drive_enumerate_identifiers = c_g_drive_enumerate_identifiers;
alias g_drive_get_icon = c_g_drive_get_icon;
alias g_drive_get_identifier = c_g_drive_get_identifier;
alias g_drive_get_name = c_g_drive_get_name;
alias g_drive_get_sort_key = c_g_drive_get_sort_key;
alias g_drive_get_start_stop_type = c_g_drive_get_start_stop_type;
alias g_drive_get_symbolic_icon = c_g_drive_get_symbolic_icon;
alias g_drive_get_volumes = c_g_drive_get_volumes;
alias g_drive_has_media = c_g_drive_has_media;
alias g_drive_has_volumes = c_g_drive_has_volumes;
alias g_drive_is_media_check_automatic = c_g_drive_is_media_check_automatic;
alias g_drive_is_media_removable = c_g_drive_is_media_removable;
alias g_drive_is_removable = c_g_drive_is_removable;
alias g_drive_poll_for_media = c_g_drive_poll_for_media;
alias g_drive_poll_for_media_finish = c_g_drive_poll_for_media_finish;
alias g_drive_start = c_g_drive_start;
alias g_drive_start_finish = c_g_drive_start_finish;
alias g_drive_stop = c_g_drive_stop;
alias g_drive_stop_finish = c_g_drive_stop_finish;

// DtlsClientConnection
alias g_dtls_client_connection_get_type = c_g_dtls_client_connection_get_type;
alias g_dtls_client_connection_new = c_g_dtls_client_connection_new;
alias g_dtls_client_connection_get_accepted_cas = c_g_dtls_client_connection_get_accepted_cas;
alias g_dtls_client_connection_get_server_identity = c_g_dtls_client_connection_get_server_identity;
alias g_dtls_client_connection_get_validation_flags = c_g_dtls_client_connection_get_validation_flags;
alias g_dtls_client_connection_set_server_identity = c_g_dtls_client_connection_set_server_identity;
alias g_dtls_client_connection_set_validation_flags = c_g_dtls_client_connection_set_validation_flags;

// DtlsConnection
alias g_dtls_connection_get_type = c_g_dtls_connection_get_type;
alias g_dtls_connection_close = c_g_dtls_connection_close;
alias g_dtls_connection_close_async = c_g_dtls_connection_close_async;
alias g_dtls_connection_close_finish = c_g_dtls_connection_close_finish;
alias g_dtls_connection_emit_accept_certificate = c_g_dtls_connection_emit_accept_certificate;
alias g_dtls_connection_get_certificate = c_g_dtls_connection_get_certificate;
alias g_dtls_connection_get_channel_binding_data = c_g_dtls_connection_get_channel_binding_data;
alias g_dtls_connection_get_ciphersuite_name = c_g_dtls_connection_get_ciphersuite_name;
alias g_dtls_connection_get_database = c_g_dtls_connection_get_database;
alias g_dtls_connection_get_interaction = c_g_dtls_connection_get_interaction;
alias g_dtls_connection_get_negotiated_protocol = c_g_dtls_connection_get_negotiated_protocol;
alias g_dtls_connection_get_peer_certificate = c_g_dtls_connection_get_peer_certificate;
alias g_dtls_connection_get_peer_certificate_errors = c_g_dtls_connection_get_peer_certificate_errors;
alias g_dtls_connection_get_protocol_version = c_g_dtls_connection_get_protocol_version;
alias g_dtls_connection_get_rehandshake_mode = c_g_dtls_connection_get_rehandshake_mode;
alias g_dtls_connection_get_require_close_notify = c_g_dtls_connection_get_require_close_notify;
alias g_dtls_connection_handshake = c_g_dtls_connection_handshake;
alias g_dtls_connection_handshake_async = c_g_dtls_connection_handshake_async;
alias g_dtls_connection_handshake_finish = c_g_dtls_connection_handshake_finish;
alias g_dtls_connection_set_advertised_protocols = c_g_dtls_connection_set_advertised_protocols;
alias g_dtls_connection_set_certificate = c_g_dtls_connection_set_certificate;
alias g_dtls_connection_set_database = c_g_dtls_connection_set_database;
alias g_dtls_connection_set_interaction = c_g_dtls_connection_set_interaction;
alias g_dtls_connection_set_rehandshake_mode = c_g_dtls_connection_set_rehandshake_mode;
alias g_dtls_connection_set_require_close_notify = c_g_dtls_connection_set_require_close_notify;
alias g_dtls_connection_shutdown = c_g_dtls_connection_shutdown;
alias g_dtls_connection_shutdown_async = c_g_dtls_connection_shutdown_async;
alias g_dtls_connection_shutdown_finish = c_g_dtls_connection_shutdown_finish;

// DtlsServerConnection
alias g_dtls_server_connection_get_type = c_g_dtls_server_connection_get_type;
alias g_dtls_server_connection_new = c_g_dtls_server_connection_new;

// Emblem
alias g_emblem_get_type = c_g_emblem_get_type;
alias g_emblem_new = c_g_emblem_new;
alias g_emblem_new_with_origin = c_g_emblem_new_with_origin;
alias g_emblem_get_icon = c_g_emblem_get_icon;
alias g_emblem_get_origin = c_g_emblem_get_origin;

// EmblemedIcon
alias g_emblemed_icon_get_type = c_g_emblemed_icon_get_type;
alias g_emblemed_icon_new = c_g_emblemed_icon_new;
alias g_emblemed_icon_add_emblem = c_g_emblemed_icon_add_emblem;
alias g_emblemed_icon_clear_emblems = c_g_emblemed_icon_clear_emblems;
alias g_emblemed_icon_get_emblems = c_g_emblemed_icon_get_emblems;
alias g_emblemed_icon_get_icon = c_g_emblemed_icon_get_icon;

// File
alias g_file_get_type = c_g_file_get_type;
alias g_file_new_build_filename = c_g_file_new_build_filename;
alias g_file_new_build_filenamev = c_g_file_new_build_filenamev;
alias g_file_new_for_commandline_arg = c_g_file_new_for_commandline_arg;
alias g_file_new_for_commandline_arg_and_cwd = c_g_file_new_for_commandline_arg_and_cwd;
alias g_file_new_for_path = c_g_file_new_for_path;
alias g_file_new_for_uri = c_g_file_new_for_uri;
alias g_file_new_tmp = c_g_file_new_tmp;
alias g_file_new_tmp_async = c_g_file_new_tmp_async;
alias g_file_new_tmp_dir_async = c_g_file_new_tmp_dir_async;
alias g_file_new_tmp_dir_finish = c_g_file_new_tmp_dir_finish;
alias g_file_new_tmp_finish = c_g_file_new_tmp_finish;
alias g_file_parse_name = c_g_file_parse_name;
alias g_file_append_to = c_g_file_append_to;
alias g_file_append_to_async = c_g_file_append_to_async;
alias g_file_append_to_finish = c_g_file_append_to_finish;
alias g_file_build_attribute_list_for_copy = c_g_file_build_attribute_list_for_copy;
alias g_file_copy = c_g_file_copy;
alias g_file_copy_async = c_g_file_copy_async;
alias g_file_copy_attributes = c_g_file_copy_attributes;
alias g_file_copy_finish = c_g_file_copy_finish;
alias g_file_create = c_g_file_create;
alias g_file_create_async = c_g_file_create_async;
alias g_file_create_finish = c_g_file_create_finish;
alias g_file_create_readwrite = c_g_file_create_readwrite;
alias g_file_create_readwrite_async = c_g_file_create_readwrite_async;
alias g_file_create_readwrite_finish = c_g_file_create_readwrite_finish;
alias g_file_delete = c_g_file_delete;
alias g_file_delete_async = c_g_file_delete_async;
alias g_file_delete_finish = c_g_file_delete_finish;
alias g_file_dup = c_g_file_dup;
alias g_file_eject_mountable = c_g_file_eject_mountable;
alias g_file_eject_mountable_finish = c_g_file_eject_mountable_finish;
alias g_file_eject_mountable_with_operation = c_g_file_eject_mountable_with_operation;
alias g_file_eject_mountable_with_operation_finish = c_g_file_eject_mountable_with_operation_finish;
alias g_file_enumerate_children = c_g_file_enumerate_children;
alias g_file_enumerate_children_async = c_g_file_enumerate_children_async;
alias g_file_enumerate_children_finish = c_g_file_enumerate_children_finish;
alias g_file_equal = c_g_file_equal;
alias g_file_find_enclosing_mount = c_g_file_find_enclosing_mount;
alias g_file_find_enclosing_mount_async = c_g_file_find_enclosing_mount_async;
alias g_file_find_enclosing_mount_finish = c_g_file_find_enclosing_mount_finish;
alias g_file_get_basename = c_g_file_get_basename;
alias g_file_get_child = c_g_file_get_child;
alias g_file_get_child_for_display_name = c_g_file_get_child_for_display_name;
alias g_file_get_parent = c_g_file_get_parent;
alias g_file_get_parse_name = c_g_file_get_parse_name;
alias g_file_get_path = c_g_file_get_path;
alias g_file_get_relative_path = c_g_file_get_relative_path;
alias g_file_get_uri = c_g_file_get_uri;
alias g_file_get_uri_scheme = c_g_file_get_uri_scheme;
alias g_file_has_parent = c_g_file_has_parent;
alias g_file_has_prefix = c_g_file_has_prefix;
alias g_file_has_uri_scheme = c_g_file_has_uri_scheme;
alias g_file_hash = c_g_file_hash;
alias g_file_is_native = c_g_file_is_native;
alias g_file_load_bytes = c_g_file_load_bytes;
alias g_file_load_bytes_async = c_g_file_load_bytes_async;
alias g_file_load_bytes_finish = c_g_file_load_bytes_finish;
alias g_file_load_contents = c_g_file_load_contents;
alias g_file_load_contents_async = c_g_file_load_contents_async;
alias g_file_load_contents_finish = c_g_file_load_contents_finish;
alias g_file_load_partial_contents_async = c_g_file_load_partial_contents_async;
alias g_file_load_partial_contents_finish = c_g_file_load_partial_contents_finish;
alias g_file_make_directory = c_g_file_make_directory;
alias g_file_make_directory_async = c_g_file_make_directory_async;
alias g_file_make_directory_finish = c_g_file_make_directory_finish;
alias g_file_make_directory_with_parents = c_g_file_make_directory_with_parents;
alias g_file_make_symbolic_link = c_g_file_make_symbolic_link;
alias g_file_make_symbolic_link_async = c_g_file_make_symbolic_link_async;
alias g_file_make_symbolic_link_finish = c_g_file_make_symbolic_link_finish;
alias g_file_measure_disk_usage = c_g_file_measure_disk_usage;
alias g_file_measure_disk_usage_async = c_g_file_measure_disk_usage_async;
alias g_file_measure_disk_usage_finish = c_g_file_measure_disk_usage_finish;
alias g_file_monitor = c_g_file_monitor;
alias g_file_monitor_directory = c_g_file_monitor_directory;
alias g_file_monitor_file = c_g_file_monitor_file;
alias g_file_mount_enclosing_volume = c_g_file_mount_enclosing_volume;
alias g_file_mount_enclosing_volume_finish = c_g_file_mount_enclosing_volume_finish;
alias g_file_mount_mountable = c_g_file_mount_mountable;
alias g_file_mount_mountable_finish = c_g_file_mount_mountable_finish;
alias g_file_move = c_g_file_move;
alias g_file_move_async = c_g_file_move_async;
alias g_file_move_finish = c_g_file_move_finish;
alias g_file_open_readwrite = c_g_file_open_readwrite;
alias g_file_open_readwrite_async = c_g_file_open_readwrite_async;
alias g_file_open_readwrite_finish = c_g_file_open_readwrite_finish;
alias g_file_peek_path = c_g_file_peek_path;
alias g_file_poll_mountable = c_g_file_poll_mountable;
alias g_file_poll_mountable_finish = c_g_file_poll_mountable_finish;
alias g_file_query_default_handler = c_g_file_query_default_handler;
alias g_file_query_default_handler_async = c_g_file_query_default_handler_async;
alias g_file_query_default_handler_finish = c_g_file_query_default_handler_finish;
alias g_file_query_exists = c_g_file_query_exists;
alias g_file_query_file_type = c_g_file_query_file_type;
alias g_file_query_filesystem_info = c_g_file_query_filesystem_info;
alias g_file_query_filesystem_info_async = c_g_file_query_filesystem_info_async;
alias g_file_query_filesystem_info_finish = c_g_file_query_filesystem_info_finish;
alias g_file_query_info = c_g_file_query_info;
alias g_file_query_info_async = c_g_file_query_info_async;
alias g_file_query_info_finish = c_g_file_query_info_finish;
alias g_file_query_settable_attributes = c_g_file_query_settable_attributes;
alias g_file_query_writable_namespaces = c_g_file_query_writable_namespaces;
alias g_file_read = c_g_file_read;
alias g_file_read_async = c_g_file_read_async;
alias g_file_read_finish = c_g_file_read_finish;
alias g_file_replace = c_g_file_replace;
alias g_file_replace_async = c_g_file_replace_async;
alias g_file_replace_contents = c_g_file_replace_contents;
alias g_file_replace_contents_async = c_g_file_replace_contents_async;
alias g_file_replace_contents_bytes_async = c_g_file_replace_contents_bytes_async;
alias g_file_replace_contents_finish = c_g_file_replace_contents_finish;
alias g_file_replace_finish = c_g_file_replace_finish;
alias g_file_replace_readwrite = c_g_file_replace_readwrite;
alias g_file_replace_readwrite_async = c_g_file_replace_readwrite_async;
alias g_file_replace_readwrite_finish = c_g_file_replace_readwrite_finish;
alias g_file_resolve_relative_path = c_g_file_resolve_relative_path;
alias g_file_set_attribute = c_g_file_set_attribute;
alias g_file_set_attribute_byte_string = c_g_file_set_attribute_byte_string;
alias g_file_set_attribute_int32 = c_g_file_set_attribute_int32;
alias g_file_set_attribute_int64 = c_g_file_set_attribute_int64;
alias g_file_set_attribute_string = c_g_file_set_attribute_string;
alias g_file_set_attribute_uint32 = c_g_file_set_attribute_uint32;
alias g_file_set_attribute_uint64 = c_g_file_set_attribute_uint64;
alias g_file_set_attributes_async = c_g_file_set_attributes_async;
alias g_file_set_attributes_finish = c_g_file_set_attributes_finish;
alias g_file_set_attributes_from_info = c_g_file_set_attributes_from_info;
alias g_file_set_display_name = c_g_file_set_display_name;
alias g_file_set_display_name_async = c_g_file_set_display_name_async;
alias g_file_set_display_name_finish = c_g_file_set_display_name_finish;
alias g_file_start_mountable = c_g_file_start_mountable;
alias g_file_start_mountable_finish = c_g_file_start_mountable_finish;
alias g_file_stop_mountable = c_g_file_stop_mountable;
alias g_file_stop_mountable_finish = c_g_file_stop_mountable_finish;
alias g_file_supports_thread_contexts = c_g_file_supports_thread_contexts;
alias g_file_trash = c_g_file_trash;
alias g_file_trash_async = c_g_file_trash_async;
alias g_file_trash_finish = c_g_file_trash_finish;
alias g_file_unmount_mountable = c_g_file_unmount_mountable;
alias g_file_unmount_mountable_finish = c_g_file_unmount_mountable_finish;
alias g_file_unmount_mountable_with_operation = c_g_file_unmount_mountable_with_operation;
alias g_file_unmount_mountable_with_operation_finish = c_g_file_unmount_mountable_with_operation_finish;

// FileAttributeInfoList
alias g_file_attribute_info_list_get_type = c_g_file_attribute_info_list_get_type;
alias g_file_attribute_info_list_new = c_g_file_attribute_info_list_new;
alias g_file_attribute_info_list_add = c_g_file_attribute_info_list_add;
alias g_file_attribute_info_list_dup = c_g_file_attribute_info_list_dup;
alias g_file_attribute_info_list_lookup = c_g_file_attribute_info_list_lookup;
alias g_file_attribute_info_list_ref = c_g_file_attribute_info_list_ref;
alias g_file_attribute_info_list_unref = c_g_file_attribute_info_list_unref;

// FileAttributeMatcher
alias g_file_attribute_matcher_get_type = c_g_file_attribute_matcher_get_type;
alias g_file_attribute_matcher_new = c_g_file_attribute_matcher_new;
alias g_file_attribute_matcher_enumerate_namespace = c_g_file_attribute_matcher_enumerate_namespace;
alias g_file_attribute_matcher_enumerate_next = c_g_file_attribute_matcher_enumerate_next;
alias g_file_attribute_matcher_matches = c_g_file_attribute_matcher_matches;
alias g_file_attribute_matcher_matches_only = c_g_file_attribute_matcher_matches_only;
alias g_file_attribute_matcher_ref = c_g_file_attribute_matcher_ref;
alias g_file_attribute_matcher_subtract = c_g_file_attribute_matcher_subtract;
alias g_file_attribute_matcher_to_string = c_g_file_attribute_matcher_to_string;
alias g_file_attribute_matcher_unref = c_g_file_attribute_matcher_unref;

// FileDescriptorBased
alias g_file_descriptor_based_get_type = c_g_file_descriptor_based_get_type;
alias g_file_descriptor_based_get_fd = c_g_file_descriptor_based_get_fd;

// FileEnumerator
alias g_file_enumerator_get_type = c_g_file_enumerator_get_type;
alias g_file_enumerator_close = c_g_file_enumerator_close;
alias g_file_enumerator_close_async = c_g_file_enumerator_close_async;
alias g_file_enumerator_close_finish = c_g_file_enumerator_close_finish;
alias g_file_enumerator_get_child = c_g_file_enumerator_get_child;
alias g_file_enumerator_get_container = c_g_file_enumerator_get_container;
alias g_file_enumerator_has_pending = c_g_file_enumerator_has_pending;
alias g_file_enumerator_is_closed = c_g_file_enumerator_is_closed;
alias g_file_enumerator_iterate = c_g_file_enumerator_iterate;
alias g_file_enumerator_next_file = c_g_file_enumerator_next_file;
alias g_file_enumerator_next_files_async = c_g_file_enumerator_next_files_async;
alias g_file_enumerator_next_files_finish = c_g_file_enumerator_next_files_finish;
alias g_file_enumerator_set_pending = c_g_file_enumerator_set_pending;

// FileIOStream
alias g_file_io_stream_get_type = c_g_file_io_stream_get_type;
alias g_file_io_stream_get_etag = c_g_file_io_stream_get_etag;
alias g_file_io_stream_query_info = c_g_file_io_stream_query_info;
alias g_file_io_stream_query_info_async = c_g_file_io_stream_query_info_async;
alias g_file_io_stream_query_info_finish = c_g_file_io_stream_query_info_finish;

// FileIcon
alias g_file_icon_get_type = c_g_file_icon_get_type;
alias g_file_icon_new = c_g_file_icon_new;
alias g_file_icon_get_file = c_g_file_icon_get_file;

// FileInfo
alias g_file_info_get_type = c_g_file_info_get_type;
alias g_file_info_new = c_g_file_info_new;
alias g_file_info_clear_status = c_g_file_info_clear_status;
alias g_file_info_copy_into = c_g_file_info_copy_into;
alias g_file_info_dup = c_g_file_info_dup;
alias g_file_info_get_access_date_time = c_g_file_info_get_access_date_time;
alias g_file_info_get_attribute_as_string = c_g_file_info_get_attribute_as_string;
alias g_file_info_get_attribute_boolean = c_g_file_info_get_attribute_boolean;
alias g_file_info_get_attribute_byte_string = c_g_file_info_get_attribute_byte_string;
alias g_file_info_get_attribute_data = c_g_file_info_get_attribute_data;
alias g_file_info_get_attribute_file_path = c_g_file_info_get_attribute_file_path;
alias g_file_info_get_attribute_int32 = c_g_file_info_get_attribute_int32;
alias g_file_info_get_attribute_int64 = c_g_file_info_get_attribute_int64;
alias g_file_info_get_attribute_object = c_g_file_info_get_attribute_object;
alias g_file_info_get_attribute_status = c_g_file_info_get_attribute_status;
alias g_file_info_get_attribute_string = c_g_file_info_get_attribute_string;
alias g_file_info_get_attribute_stringv = c_g_file_info_get_attribute_stringv;
alias g_file_info_get_attribute_type = c_g_file_info_get_attribute_type;
alias g_file_info_get_attribute_uint32 = c_g_file_info_get_attribute_uint32;
alias g_file_info_get_attribute_uint64 = c_g_file_info_get_attribute_uint64;
alias g_file_info_get_content_type = c_g_file_info_get_content_type;
alias g_file_info_get_creation_date_time = c_g_file_info_get_creation_date_time;
alias g_file_info_get_deletion_date = c_g_file_info_get_deletion_date;
alias g_file_info_get_display_name = c_g_file_info_get_display_name;
alias g_file_info_get_edit_name = c_g_file_info_get_edit_name;
alias g_file_info_get_etag = c_g_file_info_get_etag;
alias g_file_info_get_file_type = c_g_file_info_get_file_type;
alias g_file_info_get_icon = c_g_file_info_get_icon;
alias g_file_info_get_is_backup = c_g_file_info_get_is_backup;
alias g_file_info_get_is_hidden = c_g_file_info_get_is_hidden;
alias g_file_info_get_is_symlink = c_g_file_info_get_is_symlink;
alias g_file_info_get_modification_date_time = c_g_file_info_get_modification_date_time;
alias g_file_info_get_modification_time = c_g_file_info_get_modification_time;
alias g_file_info_get_name = c_g_file_info_get_name;
alias g_file_info_get_size = c_g_file_info_get_size;
alias g_file_info_get_sort_order = c_g_file_info_get_sort_order;
alias g_file_info_get_symbolic_icon = c_g_file_info_get_symbolic_icon;
alias g_file_info_get_symlink_target = c_g_file_info_get_symlink_target;
alias g_file_info_has_attribute = c_g_file_info_has_attribute;
alias g_file_info_has_namespace = c_g_file_info_has_namespace;
alias g_file_info_list_attributes = c_g_file_info_list_attributes;
alias g_file_info_remove_attribute = c_g_file_info_remove_attribute;
alias g_file_info_set_access_date_time = c_g_file_info_set_access_date_time;
alias g_file_info_set_attribute = c_g_file_info_set_attribute;
alias g_file_info_set_attribute_boolean = c_g_file_info_set_attribute_boolean;
alias g_file_info_set_attribute_byte_string = c_g_file_info_set_attribute_byte_string;
alias g_file_info_set_attribute_file_path = c_g_file_info_set_attribute_file_path;
alias g_file_info_set_attribute_int32 = c_g_file_info_set_attribute_int32;
alias g_file_info_set_attribute_int64 = c_g_file_info_set_attribute_int64;
alias g_file_info_set_attribute_mask = c_g_file_info_set_attribute_mask;
alias g_file_info_set_attribute_object = c_g_file_info_set_attribute_object;
alias g_file_info_set_attribute_status = c_g_file_info_set_attribute_status;
alias g_file_info_set_attribute_string = c_g_file_info_set_attribute_string;
alias g_file_info_set_attribute_stringv = c_g_file_info_set_attribute_stringv;
alias g_file_info_set_attribute_uint32 = c_g_file_info_set_attribute_uint32;
alias g_file_info_set_attribute_uint64 = c_g_file_info_set_attribute_uint64;
alias g_file_info_set_content_type = c_g_file_info_set_content_type;
alias g_file_info_set_creation_date_time = c_g_file_info_set_creation_date_time;
alias g_file_info_set_display_name = c_g_file_info_set_display_name;
alias g_file_info_set_edit_name = c_g_file_info_set_edit_name;
alias g_file_info_set_file_type = c_g_file_info_set_file_type;
alias g_file_info_set_icon = c_g_file_info_set_icon;
alias g_file_info_set_is_hidden = c_g_file_info_set_is_hidden;
alias g_file_info_set_is_symlink = c_g_file_info_set_is_symlink;
alias g_file_info_set_modification_date_time = c_g_file_info_set_modification_date_time;
alias g_file_info_set_modification_time = c_g_file_info_set_modification_time;
alias g_file_info_set_name = c_g_file_info_set_name;
alias g_file_info_set_size = c_g_file_info_set_size;
alias g_file_info_set_sort_order = c_g_file_info_set_sort_order;
alias g_file_info_set_symbolic_icon = c_g_file_info_set_symbolic_icon;
alias g_file_info_set_symlink_target = c_g_file_info_set_symlink_target;
alias g_file_info_unset_attribute_mask = c_g_file_info_unset_attribute_mask;

// FileInputStream
alias g_file_input_stream_get_type = c_g_file_input_stream_get_type;
alias g_file_input_stream_query_info = c_g_file_input_stream_query_info;
alias g_file_input_stream_query_info_async = c_g_file_input_stream_query_info_async;
alias g_file_input_stream_query_info_finish = c_g_file_input_stream_query_info_finish;

// FileMonitor
alias g_file_monitor_get_type = c_g_file_monitor_get_type;
alias g_file_monitor_cancel = c_g_file_monitor_cancel;
alias g_file_monitor_emit_event = c_g_file_monitor_emit_event;
alias g_file_monitor_is_cancelled = c_g_file_monitor_is_cancelled;
alias g_file_monitor_set_rate_limit = c_g_file_monitor_set_rate_limit;

// FileOutputStream
alias g_file_output_stream_get_type = c_g_file_output_stream_get_type;
alias g_file_output_stream_get_etag = c_g_file_output_stream_get_etag;
alias g_file_output_stream_query_info = c_g_file_output_stream_query_info;
alias g_file_output_stream_query_info_async = c_g_file_output_stream_query_info_async;
alias g_file_output_stream_query_info_finish = c_g_file_output_stream_query_info_finish;

// FilenameCompleter
alias g_filename_completer_get_type = c_g_filename_completer_get_type;
alias g_filename_completer_new = c_g_filename_completer_new;
alias g_filename_completer_get_completion_suffix = c_g_filename_completer_get_completion_suffix;
alias g_filename_completer_get_completions = c_g_filename_completer_get_completions;
alias g_filename_completer_set_dirs_only = c_g_filename_completer_set_dirs_only;

// FilterInputStream
alias g_filter_input_stream_get_type = c_g_filter_input_stream_get_type;
alias g_filter_input_stream_get_base_stream = c_g_filter_input_stream_get_base_stream;
alias g_filter_input_stream_get_close_base_stream = c_g_filter_input_stream_get_close_base_stream;
alias g_filter_input_stream_set_close_base_stream = c_g_filter_input_stream_set_close_base_stream;

// FilterOutputStream
alias g_filter_output_stream_get_type = c_g_filter_output_stream_get_type;
alias g_filter_output_stream_get_base_stream = c_g_filter_output_stream_get_base_stream;
alias g_filter_output_stream_get_close_base_stream = c_g_filter_output_stream_get_close_base_stream;
alias g_filter_output_stream_set_close_base_stream = c_g_filter_output_stream_set_close_base_stream;

// Global
alias g_bus_get = c_g_bus_get;
alias g_bus_get_finish = c_g_bus_get_finish;
alias g_bus_get_sync = c_g_bus_get_sync;
alias g_bus_own_name = c_g_bus_own_name;
alias g_bus_own_name_on_connection = c_g_bus_own_name_on_connection;
alias g_bus_own_name_on_connection_with_closures = c_g_bus_own_name_on_connection_with_closures;
alias g_bus_own_name_with_closures = c_g_bus_own_name_with_closures;
alias g_bus_unown_name = c_g_bus_unown_name;
alias g_bus_unwatch_name = c_g_bus_unwatch_name;
alias g_bus_watch_name = c_g_bus_watch_name;
alias g_bus_watch_name_on_connection = c_g_bus_watch_name_on_connection;
alias g_bus_watch_name_on_connection_with_closures = c_g_bus_watch_name_on_connection_with_closures;
alias g_bus_watch_name_with_closures = c_g_bus_watch_name_with_closures;
alias g_content_type_can_be_executable = c_g_content_type_can_be_executable;
alias g_content_type_equals = c_g_content_type_equals;
alias g_content_type_from_mime_type = c_g_content_type_from_mime_type;
alias g_content_type_get_description = c_g_content_type_get_description;
alias g_content_type_get_generic_icon_name = c_g_content_type_get_generic_icon_name;
alias g_content_type_get_icon = c_g_content_type_get_icon;
alias g_content_type_get_mime_dirs = c_g_content_type_get_mime_dirs;
alias g_content_type_get_mime_type = c_g_content_type_get_mime_type;
alias g_content_type_get_symbolic_icon = c_g_content_type_get_symbolic_icon;
alias g_content_type_guess = c_g_content_type_guess;
alias g_content_type_guess_for_tree = c_g_content_type_guess_for_tree;
alias g_content_type_is_a = c_g_content_type_is_a;
alias g_content_type_is_mime_type = c_g_content_type_is_mime_type;
alias g_content_type_is_unknown = c_g_content_type_is_unknown;
alias g_content_type_set_mime_dirs = c_g_content_type_set_mime_dirs;
alias g_content_types_get_registered = c_g_content_types_get_registered;
alias g_dbus_address_escape_value = c_g_dbus_address_escape_value;
alias g_dbus_address_get_for_bus_sync = c_g_dbus_address_get_for_bus_sync;
alias g_dbus_address_get_stream = c_g_dbus_address_get_stream;
alias g_dbus_address_get_stream_finish = c_g_dbus_address_get_stream_finish;
alias g_dbus_address_get_stream_sync = c_g_dbus_address_get_stream_sync;
alias g_dbus_escape_object_path = c_g_dbus_escape_object_path;
alias g_dbus_escape_object_path_bytestring = c_g_dbus_escape_object_path_bytestring;
alias g_dbus_generate_guid = c_g_dbus_generate_guid;
alias g_dbus_gvalue_to_gvariant = c_g_dbus_gvalue_to_gvariant;
alias g_dbus_gvariant_to_gvalue = c_g_dbus_gvariant_to_gvalue;
alias g_dbus_is_address = c_g_dbus_is_address;
alias g_dbus_is_error_name = c_g_dbus_is_error_name;
alias g_dbus_is_guid = c_g_dbus_is_guid;
alias g_dbus_is_interface_name = c_g_dbus_is_interface_name;
alias g_dbus_is_member_name = c_g_dbus_is_member_name;
alias g_dbus_is_name = c_g_dbus_is_name;
alias g_dbus_is_supported_address = c_g_dbus_is_supported_address;
alias g_dbus_is_unique_name = c_g_dbus_is_unique_name;
alias g_dbus_unescape_object_path = c_g_dbus_unescape_object_path;
alias g_io_error_from_errno = c_g_io_error_from_errno;
alias g_io_error_from_file_error = c_g_io_error_from_file_error;
alias g_io_error_quark = c_g_io_error_quark;
alias g_io_modules_load_all_in_directory = c_g_io_modules_load_all_in_directory;
alias g_io_modules_load_all_in_directory_with_scope = c_g_io_modules_load_all_in_directory_with_scope;
alias g_io_modules_scan_all_in_directory = c_g_io_modules_scan_all_in_directory;
alias g_io_modules_scan_all_in_directory_with_scope = c_g_io_modules_scan_all_in_directory_with_scope;
alias g_io_scheduler_cancel_all_jobs = c_g_io_scheduler_cancel_all_jobs;
alias g_io_scheduler_push_job = c_g_io_scheduler_push_job;
alias g_keyfile_settings_backend_new = c_g_keyfile_settings_backend_new;
alias g_memory_settings_backend_new = c_g_memory_settings_backend_new;
alias g_networking_init = c_g_networking_init;
alias g_null_settings_backend_new = c_g_null_settings_backend_new;
alias g_pollable_source_new = c_g_pollable_source_new;
alias g_pollable_source_new_full = c_g_pollable_source_new_full;
alias g_pollable_stream_read = c_g_pollable_stream_read;
alias g_pollable_stream_write = c_g_pollable_stream_write;
alias g_pollable_stream_write_all = c_g_pollable_stream_write_all;
alias g_resources_enumerate_children = c_g_resources_enumerate_children;
alias g_resources_get_info = c_g_resources_get_info;
alias g_resources_lookup_data = c_g_resources_lookup_data;
alias g_resources_open_stream = c_g_resources_open_stream;
alias g_resources_register = c_g_resources_register;
alias g_resources_unregister = c_g_resources_unregister;
alias g_simple_async_report_error_in_idle = c_g_simple_async_report_error_in_idle;
alias g_simple_async_report_gerror_in_idle = c_g_simple_async_report_gerror_in_idle;
alias g_simple_async_report_take_gerror_in_idle = c_g_simple_async_report_take_gerror_in_idle;
alias g_unix_is_mount_path_system_internal = c_g_unix_is_mount_path_system_internal;
alias g_unix_is_system_device_path = c_g_unix_is_system_device_path;
alias g_unix_is_system_fs_type = c_g_unix_is_system_fs_type;
alias g_unix_mount_at = c_g_unix_mount_at;
alias g_unix_mount_compare = c_g_unix_mount_compare;
alias g_unix_mount_copy = c_g_unix_mount_copy;
alias g_unix_mount_for = c_g_unix_mount_for;
alias g_unix_mount_free = c_g_unix_mount_free;
alias g_unix_mount_get_device_path = c_g_unix_mount_get_device_path;
alias g_unix_mount_get_fs_type = c_g_unix_mount_get_fs_type;
alias g_unix_mount_get_mount_path = c_g_unix_mount_get_mount_path;
alias g_unix_mount_get_options = c_g_unix_mount_get_options;
alias g_unix_mount_get_root_path = c_g_unix_mount_get_root_path;
alias g_unix_mount_guess_can_eject = c_g_unix_mount_guess_can_eject;
alias g_unix_mount_guess_icon = c_g_unix_mount_guess_icon;
alias g_unix_mount_guess_name = c_g_unix_mount_guess_name;
alias g_unix_mount_guess_should_display = c_g_unix_mount_guess_should_display;
alias g_unix_mount_guess_symbolic_icon = c_g_unix_mount_guess_symbolic_icon;
alias g_unix_mount_is_readonly = c_g_unix_mount_is_readonly;
alias g_unix_mount_is_system_internal = c_g_unix_mount_is_system_internal;
alias g_unix_mount_points_changed_since = c_g_unix_mount_points_changed_since;
alias g_unix_mount_points_get = c_g_unix_mount_points_get;
alias g_unix_mounts_changed_since = c_g_unix_mounts_changed_since;
alias g_unix_mounts_get = c_g_unix_mounts_get;

// IOExtension
alias g_io_extension_get_name = c_g_io_extension_get_name;
alias g_io_extension_get_priority = c_g_io_extension_get_priority;
alias g_io_extension_get_type = c_g_io_extension_get_type;
alias g_io_extension_ref_class = c_g_io_extension_ref_class;

// IOExtensionPoint
alias g_io_extension_point_get_extension_by_name = c_g_io_extension_point_get_extension_by_name;
alias g_io_extension_point_get_extensions = c_g_io_extension_point_get_extensions;
alias g_io_extension_point_get_required_type = c_g_io_extension_point_get_required_type;
alias g_io_extension_point_set_required_type = c_g_io_extension_point_set_required_type;
alias g_io_extension_point_implement = c_g_io_extension_point_implement;
alias g_io_extension_point_lookup = c_g_io_extension_point_lookup;
alias g_io_extension_point_register = c_g_io_extension_point_register;

// IOModule
alias g_io_module_get_type = c_g_io_module_get_type;
alias g_io_module_new = c_g_io_module_new;
alias g_io_module_query = c_g_io_module_query;
alias g_io_module_load = c_g_io_module_load;
alias g_io_module_unload = c_g_io_module_unload;

// IOModuleScope
alias g_io_module_scope_block = c_g_io_module_scope_block;
alias g_io_module_scope_free = c_g_io_module_scope_free;
alias g_io_module_scope_new = c_g_io_module_scope_new;

// IOSchedulerJob
alias g_io_scheduler_job_send_to_mainloop = c_g_io_scheduler_job_send_to_mainloop;
alias g_io_scheduler_job_send_to_mainloop_async = c_g_io_scheduler_job_send_to_mainloop_async;

// IOStream
alias g_io_stream_get_type = c_g_io_stream_get_type;
alias g_io_stream_splice_finish = c_g_io_stream_splice_finish;
alias g_io_stream_clear_pending = c_g_io_stream_clear_pending;
alias g_io_stream_close = c_g_io_stream_close;
alias g_io_stream_close_async = c_g_io_stream_close_async;
alias g_io_stream_close_finish = c_g_io_stream_close_finish;
alias g_io_stream_get_input_stream = c_g_io_stream_get_input_stream;
alias g_io_stream_get_output_stream = c_g_io_stream_get_output_stream;
alias g_io_stream_has_pending = c_g_io_stream_has_pending;
alias g_io_stream_is_closed = c_g_io_stream_is_closed;
alias g_io_stream_set_pending = c_g_io_stream_set_pending;
alias g_io_stream_splice_async = c_g_io_stream_splice_async;

// Icon
alias g_icon_get_type = c_g_icon_get_type;
alias g_icon_deserialize = c_g_icon_deserialize;
alias g_icon_new_for_string = c_g_icon_new_for_string;
alias g_icon_equal = c_g_icon_equal;
alias g_icon_hash = c_g_icon_hash;
alias g_icon_serialize = c_g_icon_serialize;
alias g_icon_to_string = c_g_icon_to_string;

// InetAddress
alias g_inet_address_get_type = c_g_inet_address_get_type;
alias g_inet_address_new_any = c_g_inet_address_new_any;
alias g_inet_address_new_from_bytes = c_g_inet_address_new_from_bytes;
alias g_inet_address_new_from_string = c_g_inet_address_new_from_string;
alias g_inet_address_new_loopback = c_g_inet_address_new_loopback;
alias g_inet_address_equal = c_g_inet_address_equal;
alias g_inet_address_get_family = c_g_inet_address_get_family;
alias g_inet_address_get_is_any = c_g_inet_address_get_is_any;
alias g_inet_address_get_is_link_local = c_g_inet_address_get_is_link_local;
alias g_inet_address_get_is_loopback = c_g_inet_address_get_is_loopback;
alias g_inet_address_get_is_mc_global = c_g_inet_address_get_is_mc_global;
alias g_inet_address_get_is_mc_link_local = c_g_inet_address_get_is_mc_link_local;
alias g_inet_address_get_is_mc_node_local = c_g_inet_address_get_is_mc_node_local;
alias g_inet_address_get_is_mc_org_local = c_g_inet_address_get_is_mc_org_local;
alias g_inet_address_get_is_mc_site_local = c_g_inet_address_get_is_mc_site_local;
alias g_inet_address_get_is_multicast = c_g_inet_address_get_is_multicast;
alias g_inet_address_get_is_site_local = c_g_inet_address_get_is_site_local;
alias g_inet_address_get_native_size = c_g_inet_address_get_native_size;
alias g_inet_address_to_bytes = c_g_inet_address_to_bytes;
alias g_inet_address_to_string = c_g_inet_address_to_string;

// InetAddressMask
alias g_inet_address_mask_get_type = c_g_inet_address_mask_get_type;
alias g_inet_address_mask_new = c_g_inet_address_mask_new;
alias g_inet_address_mask_new_from_string = c_g_inet_address_mask_new_from_string;
alias g_inet_address_mask_equal = c_g_inet_address_mask_equal;
alias g_inet_address_mask_get_address = c_g_inet_address_mask_get_address;
alias g_inet_address_mask_get_family = c_g_inet_address_mask_get_family;
alias g_inet_address_mask_get_length = c_g_inet_address_mask_get_length;
alias g_inet_address_mask_matches = c_g_inet_address_mask_matches;
alias g_inet_address_mask_to_string = c_g_inet_address_mask_to_string;

// InetSocketAddress
alias g_inet_socket_address_get_type = c_g_inet_socket_address_get_type;
alias g_inet_socket_address_new = c_g_inet_socket_address_new;
alias g_inet_socket_address_new_from_string = c_g_inet_socket_address_new_from_string;
alias g_inet_socket_address_get_address = c_g_inet_socket_address_get_address;
alias g_inet_socket_address_get_flowinfo = c_g_inet_socket_address_get_flowinfo;
alias g_inet_socket_address_get_port = c_g_inet_socket_address_get_port;
alias g_inet_socket_address_get_scope_id = c_g_inet_socket_address_get_scope_id;

// Initable
alias g_initable_get_type = c_g_initable_get_type;
alias g_initable_new = c_g_initable_new;
alias g_initable_new_valist = c_g_initable_new_valist;
alias g_initable_newv = c_g_initable_newv;
alias g_initable_init = c_g_initable_init;

// InputStream
alias g_input_stream_get_type = c_g_input_stream_get_type;
alias g_input_stream_clear_pending = c_g_input_stream_clear_pending;
alias g_input_stream_close = c_g_input_stream_close;
alias g_input_stream_close_async = c_g_input_stream_close_async;
alias g_input_stream_close_finish = c_g_input_stream_close_finish;
alias g_input_stream_has_pending = c_g_input_stream_has_pending;
alias g_input_stream_is_closed = c_g_input_stream_is_closed;
alias g_input_stream_read = c_g_input_stream_read;
alias g_input_stream_read_all = c_g_input_stream_read_all;
alias g_input_stream_read_all_async = c_g_input_stream_read_all_async;
alias g_input_stream_read_all_finish = c_g_input_stream_read_all_finish;
alias g_input_stream_read_async = c_g_input_stream_read_async;
alias g_input_stream_read_bytes = c_g_input_stream_read_bytes;
alias g_input_stream_read_bytes_async = c_g_input_stream_read_bytes_async;
alias g_input_stream_read_bytes_finish = c_g_input_stream_read_bytes_finish;
alias g_input_stream_read_finish = c_g_input_stream_read_finish;
alias g_input_stream_set_pending = c_g_input_stream_set_pending;
alias g_input_stream_skip = c_g_input_stream_skip;
alias g_input_stream_skip_async = c_g_input_stream_skip_async;
alias g_input_stream_skip_finish = c_g_input_stream_skip_finish;

// ListModel
alias g_list_model_get_type = c_g_list_model_get_type;
alias g_list_model_get_item = c_g_list_model_get_item;
alias g_list_model_get_item_type = c_g_list_model_get_item_type;
alias g_list_model_get_n_items = c_g_list_model_get_n_items;
alias g_list_model_get_object = c_g_list_model_get_object;
alias g_list_model_items_changed = c_g_list_model_items_changed;

// ListStore
alias g_list_store_get_type = c_g_list_store_get_type;
alias g_list_store_new = c_g_list_store_new;
alias g_list_store_append = c_g_list_store_append;
alias g_list_store_find = c_g_list_store_find;
alias g_list_store_find_with_equal_func = c_g_list_store_find_with_equal_func;
alias g_list_store_find_with_equal_func_full = c_g_list_store_find_with_equal_func_full;
alias g_list_store_insert = c_g_list_store_insert;
alias g_list_store_insert_sorted = c_g_list_store_insert_sorted;
alias g_list_store_remove = c_g_list_store_remove;
alias g_list_store_remove_all = c_g_list_store_remove_all;
alias g_list_store_sort = c_g_list_store_sort;
alias g_list_store_splice = c_g_list_store_splice;

// LoadableIcon
alias g_loadable_icon_get_type = c_g_loadable_icon_get_type;
alias g_loadable_icon_load = c_g_loadable_icon_load;
alias g_loadable_icon_load_async = c_g_loadable_icon_load_async;
alias g_loadable_icon_load_finish = c_g_loadable_icon_load_finish;

// MemoryInputStream
alias g_memory_input_stream_get_type = c_g_memory_input_stream_get_type;
alias g_memory_input_stream_new = c_g_memory_input_stream_new;
alias g_memory_input_stream_new_from_bytes = c_g_memory_input_stream_new_from_bytes;
alias g_memory_input_stream_new_from_data = c_g_memory_input_stream_new_from_data;
alias g_memory_input_stream_add_bytes = c_g_memory_input_stream_add_bytes;
alias g_memory_input_stream_add_data = c_g_memory_input_stream_add_data;

// MemoryMonitor
alias g_memory_monitor_get_type = c_g_memory_monitor_get_type;
alias g_memory_monitor_dup_default = c_g_memory_monitor_dup_default;

// MemoryOutputStream
alias g_memory_output_stream_get_type = c_g_memory_output_stream_get_type;
alias g_memory_output_stream_new = c_g_memory_output_stream_new;
alias g_memory_output_stream_new_resizable = c_g_memory_output_stream_new_resizable;
alias g_memory_output_stream_get_data = c_g_memory_output_stream_get_data;
alias g_memory_output_stream_get_data_size = c_g_memory_output_stream_get_data_size;
alias g_memory_output_stream_get_size = c_g_memory_output_stream_get_size;
alias g_memory_output_stream_steal_as_bytes = c_g_memory_output_stream_steal_as_bytes;
alias g_memory_output_stream_steal_data = c_g_memory_output_stream_steal_data;

// Menu
alias g_menu_get_type = c_g_menu_get_type;
alias g_menu_new = c_g_menu_new;
alias g_menu_append = c_g_menu_append;
alias g_menu_append_item = c_g_menu_append_item;
alias g_menu_append_section = c_g_menu_append_section;
alias g_menu_append_submenu = c_g_menu_append_submenu;
alias g_menu_freeze = c_g_menu_freeze;
alias g_menu_insert = c_g_menu_insert;
alias g_menu_insert_item = c_g_menu_insert_item;
alias g_menu_insert_section = c_g_menu_insert_section;
alias g_menu_insert_submenu = c_g_menu_insert_submenu;
alias g_menu_prepend = c_g_menu_prepend;
alias g_menu_prepend_item = c_g_menu_prepend_item;
alias g_menu_prepend_section = c_g_menu_prepend_section;
alias g_menu_prepend_submenu = c_g_menu_prepend_submenu;
alias g_menu_remove = c_g_menu_remove;
alias g_menu_remove_all = c_g_menu_remove_all;

// MenuAttributeIter
alias g_menu_attribute_iter_get_type = c_g_menu_attribute_iter_get_type;
alias g_menu_attribute_iter_get_name = c_g_menu_attribute_iter_get_name;
alias g_menu_attribute_iter_get_next = c_g_menu_attribute_iter_get_next;
alias g_menu_attribute_iter_get_value = c_g_menu_attribute_iter_get_value;
alias g_menu_attribute_iter_next = c_g_menu_attribute_iter_next;

// MenuItem
alias g_menu_item_get_type = c_g_menu_item_get_type;
alias g_menu_item_new = c_g_menu_item_new;
alias g_menu_item_new_from_model = c_g_menu_item_new_from_model;
alias g_menu_item_new_section = c_g_menu_item_new_section;
alias g_menu_item_new_submenu = c_g_menu_item_new_submenu;
alias g_menu_item_get_attribute = c_g_menu_item_get_attribute;
alias g_menu_item_get_attribute_value = c_g_menu_item_get_attribute_value;
alias g_menu_item_get_link = c_g_menu_item_get_link;
alias g_menu_item_set_action_and_target = c_g_menu_item_set_action_and_target;
alias g_menu_item_set_action_and_target_value = c_g_menu_item_set_action_and_target_value;
alias g_menu_item_set_attribute = c_g_menu_item_set_attribute;
alias g_menu_item_set_attribute_value = c_g_menu_item_set_attribute_value;
alias g_menu_item_set_detailed_action = c_g_menu_item_set_detailed_action;
alias g_menu_item_set_icon = c_g_menu_item_set_icon;
alias g_menu_item_set_label = c_g_menu_item_set_label;
alias g_menu_item_set_link = c_g_menu_item_set_link;
alias g_menu_item_set_section = c_g_menu_item_set_section;
alias g_menu_item_set_submenu = c_g_menu_item_set_submenu;

// MenuLinkIter
alias g_menu_link_iter_get_type = c_g_menu_link_iter_get_type;
alias g_menu_link_iter_get_name = c_g_menu_link_iter_get_name;
alias g_menu_link_iter_get_next = c_g_menu_link_iter_get_next;
alias g_menu_link_iter_get_value = c_g_menu_link_iter_get_value;
alias g_menu_link_iter_next = c_g_menu_link_iter_next;

// MenuModel
alias g_menu_model_get_type = c_g_menu_model_get_type;
alias g_menu_model_get_item_attribute = c_g_menu_model_get_item_attribute;
alias g_menu_model_get_item_attribute_value = c_g_menu_model_get_item_attribute_value;
alias g_menu_model_get_item_link = c_g_menu_model_get_item_link;
alias g_menu_model_get_n_items = c_g_menu_model_get_n_items;
alias g_menu_model_is_mutable = c_g_menu_model_is_mutable;
alias g_menu_model_items_changed = c_g_menu_model_items_changed;
alias g_menu_model_iterate_item_attributes = c_g_menu_model_iterate_item_attributes;
alias g_menu_model_iterate_item_links = c_g_menu_model_iterate_item_links;

// Mount
alias g_mount_get_type = c_g_mount_get_type;
alias g_mount_can_eject = c_g_mount_can_eject;
alias g_mount_can_unmount = c_g_mount_can_unmount;
alias g_mount_eject = c_g_mount_eject;
alias g_mount_eject_finish = c_g_mount_eject_finish;
alias g_mount_eject_with_operation = c_g_mount_eject_with_operation;
alias g_mount_eject_with_operation_finish = c_g_mount_eject_with_operation_finish;
alias g_mount_get_default_location = c_g_mount_get_default_location;
alias g_mount_get_drive = c_g_mount_get_drive;
alias g_mount_get_icon = c_g_mount_get_icon;
alias g_mount_get_name = c_g_mount_get_name;
alias g_mount_get_root = c_g_mount_get_root;
alias g_mount_get_sort_key = c_g_mount_get_sort_key;
alias g_mount_get_symbolic_icon = c_g_mount_get_symbolic_icon;
alias g_mount_get_uuid = c_g_mount_get_uuid;
alias g_mount_get_volume = c_g_mount_get_volume;
alias g_mount_guess_content_type = c_g_mount_guess_content_type;
alias g_mount_guess_content_type_finish = c_g_mount_guess_content_type_finish;
alias g_mount_guess_content_type_sync = c_g_mount_guess_content_type_sync;
alias g_mount_is_shadowed = c_g_mount_is_shadowed;
alias g_mount_remount = c_g_mount_remount;
alias g_mount_remount_finish = c_g_mount_remount_finish;
alias g_mount_shadow = c_g_mount_shadow;
alias g_mount_unmount = c_g_mount_unmount;
alias g_mount_unmount_finish = c_g_mount_unmount_finish;
alias g_mount_unmount_with_operation = c_g_mount_unmount_with_operation;
alias g_mount_unmount_with_operation_finish = c_g_mount_unmount_with_operation_finish;
alias g_mount_unshadow = c_g_mount_unshadow;

// MountOperation
alias g_mount_operation_get_type = c_g_mount_operation_get_type;
alias g_mount_operation_new = c_g_mount_operation_new;
alias g_mount_operation_get_anonymous = c_g_mount_operation_get_anonymous;
alias g_mount_operation_get_choice = c_g_mount_operation_get_choice;
alias g_mount_operation_get_domain = c_g_mount_operation_get_domain;
alias g_mount_operation_get_is_tcrypt_hidden_volume = c_g_mount_operation_get_is_tcrypt_hidden_volume;
alias g_mount_operation_get_is_tcrypt_system_volume = c_g_mount_operation_get_is_tcrypt_system_volume;
alias g_mount_operation_get_password = c_g_mount_operation_get_password;
alias g_mount_operation_get_password_save = c_g_mount_operation_get_password_save;
alias g_mount_operation_get_pim = c_g_mount_operation_get_pim;
alias g_mount_operation_get_username = c_g_mount_operation_get_username;
alias g_mount_operation_reply = c_g_mount_operation_reply;
alias g_mount_operation_set_anonymous = c_g_mount_operation_set_anonymous;
alias g_mount_operation_set_choice = c_g_mount_operation_set_choice;
alias g_mount_operation_set_domain = c_g_mount_operation_set_domain;
alias g_mount_operation_set_is_tcrypt_hidden_volume = c_g_mount_operation_set_is_tcrypt_hidden_volume;
alias g_mount_operation_set_is_tcrypt_system_volume = c_g_mount_operation_set_is_tcrypt_system_volume;
alias g_mount_operation_set_password = c_g_mount_operation_set_password;
alias g_mount_operation_set_password_save = c_g_mount_operation_set_password_save;
alias g_mount_operation_set_pim = c_g_mount_operation_set_pim;
alias g_mount_operation_set_username = c_g_mount_operation_set_username;

// NativeSocketAddress
alias g_native_socket_address_get_type = c_g_native_socket_address_get_type;
alias g_native_socket_address_new = c_g_native_socket_address_new;

// NativeVolumeMonitor
alias g_native_volume_monitor_get_type = c_g_native_volume_monitor_get_type;

// NetworkAddress
alias g_network_address_get_type = c_g_network_address_get_type;
alias g_network_address_new = c_g_network_address_new;
alias g_network_address_new_loopback = c_g_network_address_new_loopback;
alias g_network_address_parse = c_g_network_address_parse;
alias g_network_address_parse_uri = c_g_network_address_parse_uri;
alias g_network_address_get_hostname = c_g_network_address_get_hostname;
alias g_network_address_get_port = c_g_network_address_get_port;
alias g_network_address_get_scheme = c_g_network_address_get_scheme;

// NetworkMonitor
alias g_network_monitor_get_type = c_g_network_monitor_get_type;
alias g_network_monitor_get_default = c_g_network_monitor_get_default;
alias g_network_monitor_can_reach = c_g_network_monitor_can_reach;
alias g_network_monitor_can_reach_async = c_g_network_monitor_can_reach_async;
alias g_network_monitor_can_reach_finish = c_g_network_monitor_can_reach_finish;
alias g_network_monitor_get_connectivity = c_g_network_monitor_get_connectivity;
alias g_network_monitor_get_network_available = c_g_network_monitor_get_network_available;
alias g_network_monitor_get_network_metered = c_g_network_monitor_get_network_metered;

// NetworkService
alias g_network_service_get_type = c_g_network_service_get_type;
alias g_network_service_new = c_g_network_service_new;
alias g_network_service_get_domain = c_g_network_service_get_domain;
alias g_network_service_get_protocol = c_g_network_service_get_protocol;
alias g_network_service_get_scheme = c_g_network_service_get_scheme;
alias g_network_service_get_service = c_g_network_service_get_service;
alias g_network_service_set_scheme = c_g_network_service_set_scheme;

// Notification
alias g_notification_get_type = c_g_notification_get_type;
alias g_notification_new = c_g_notification_new;
alias g_notification_add_button = c_g_notification_add_button;
alias g_notification_add_button_with_target = c_g_notification_add_button_with_target;
alias g_notification_add_button_with_target_value = c_g_notification_add_button_with_target_value;
alias g_notification_set_body = c_g_notification_set_body;
alias g_notification_set_category = c_g_notification_set_category;
alias g_notification_set_default_action = c_g_notification_set_default_action;
alias g_notification_set_default_action_and_target = c_g_notification_set_default_action_and_target;
alias g_notification_set_default_action_and_target_value = c_g_notification_set_default_action_and_target_value;
alias g_notification_set_icon = c_g_notification_set_icon;
alias g_notification_set_priority = c_g_notification_set_priority;
alias g_notification_set_title = c_g_notification_set_title;
alias g_notification_set_urgent = c_g_notification_set_urgent;

// OutputStream
alias g_output_stream_get_type = c_g_output_stream_get_type;
alias g_output_stream_clear_pending = c_g_output_stream_clear_pending;
alias g_output_stream_close = c_g_output_stream_close;
alias g_output_stream_close_async = c_g_output_stream_close_async;
alias g_output_stream_close_finish = c_g_output_stream_close_finish;
alias g_output_stream_flush = c_g_output_stream_flush;
alias g_output_stream_flush_async = c_g_output_stream_flush_async;
alias g_output_stream_flush_finish = c_g_output_stream_flush_finish;
alias g_output_stream_has_pending = c_g_output_stream_has_pending;
alias g_output_stream_is_closed = c_g_output_stream_is_closed;
alias g_output_stream_is_closing = c_g_output_stream_is_closing;
alias g_output_stream_printf = c_g_output_stream_printf;
alias g_output_stream_set_pending = c_g_output_stream_set_pending;
alias g_output_stream_splice = c_g_output_stream_splice;
alias g_output_stream_splice_async = c_g_output_stream_splice_async;
alias g_output_stream_splice_finish = c_g_output_stream_splice_finish;
alias g_output_stream_vprintf = c_g_output_stream_vprintf;
alias g_output_stream_write = c_g_output_stream_write;
alias g_output_stream_write_all = c_g_output_stream_write_all;
alias g_output_stream_write_all_async = c_g_output_stream_write_all_async;
alias g_output_stream_write_all_finish = c_g_output_stream_write_all_finish;
alias g_output_stream_write_async = c_g_output_stream_write_async;
alias g_output_stream_write_bytes = c_g_output_stream_write_bytes;
alias g_output_stream_write_bytes_async = c_g_output_stream_write_bytes_async;
alias g_output_stream_write_bytes_finish = c_g_output_stream_write_bytes_finish;
alias g_output_stream_write_finish = c_g_output_stream_write_finish;
alias g_output_stream_writev = c_g_output_stream_writev;
alias g_output_stream_writev_all = c_g_output_stream_writev_all;
alias g_output_stream_writev_all_async = c_g_output_stream_writev_all_async;
alias g_output_stream_writev_all_finish = c_g_output_stream_writev_all_finish;
alias g_output_stream_writev_async = c_g_output_stream_writev_async;
alias g_output_stream_writev_finish = c_g_output_stream_writev_finish;

// Permission
alias g_permission_get_type = c_g_permission_get_type;
alias g_permission_acquire = c_g_permission_acquire;
alias g_permission_acquire_async = c_g_permission_acquire_async;
alias g_permission_acquire_finish = c_g_permission_acquire_finish;
alias g_permission_get_allowed = c_g_permission_get_allowed;
alias g_permission_get_can_acquire = c_g_permission_get_can_acquire;
alias g_permission_get_can_release = c_g_permission_get_can_release;
alias g_permission_impl_update = c_g_permission_impl_update;
alias g_permission_release = c_g_permission_release;
alias g_permission_release_async = c_g_permission_release_async;
alias g_permission_release_finish = c_g_permission_release_finish;

// PollableInputStream
alias g_pollable_input_stream_get_type = c_g_pollable_input_stream_get_type;
alias g_pollable_input_stream_can_poll = c_g_pollable_input_stream_can_poll;
alias g_pollable_input_stream_create_source = c_g_pollable_input_stream_create_source;
alias g_pollable_input_stream_is_readable = c_g_pollable_input_stream_is_readable;
alias g_pollable_input_stream_read_nonblocking = c_g_pollable_input_stream_read_nonblocking;

// PollableOutputStream
alias g_pollable_output_stream_get_type = c_g_pollable_output_stream_get_type;
alias g_pollable_output_stream_can_poll = c_g_pollable_output_stream_can_poll;
alias g_pollable_output_stream_create_source = c_g_pollable_output_stream_create_source;
alias g_pollable_output_stream_is_writable = c_g_pollable_output_stream_is_writable;
alias g_pollable_output_stream_write_nonblocking = c_g_pollable_output_stream_write_nonblocking;
alias g_pollable_output_stream_writev_nonblocking = c_g_pollable_output_stream_writev_nonblocking;

// PowerProfileMonitor
alias g_power_profile_monitor_get_type = c_g_power_profile_monitor_get_type;
alias g_power_profile_monitor_dup_default = c_g_power_profile_monitor_dup_default;
alias g_power_profile_monitor_get_power_saver_enabled = c_g_power_profile_monitor_get_power_saver_enabled;

// PropertyAction
alias g_property_action_get_type = c_g_property_action_get_type;
alias g_property_action_new = c_g_property_action_new;

// Proxy
alias g_proxy_get_type = c_g_proxy_get_type;
alias g_proxy_get_default_for_protocol = c_g_proxy_get_default_for_protocol;
alias g_proxy_connect = c_g_proxy_connect;
alias g_proxy_connect_async = c_g_proxy_connect_async;
alias g_proxy_connect_finish = c_g_proxy_connect_finish;
alias g_proxy_supports_hostname = c_g_proxy_supports_hostname;

// ProxyAddress
alias g_proxy_address_get_type = c_g_proxy_address_get_type;
alias g_proxy_address_new = c_g_proxy_address_new;
alias g_proxy_address_get_destination_hostname = c_g_proxy_address_get_destination_hostname;
alias g_proxy_address_get_destination_port = c_g_proxy_address_get_destination_port;
alias g_proxy_address_get_destination_protocol = c_g_proxy_address_get_destination_protocol;
alias g_proxy_address_get_password = c_g_proxy_address_get_password;
alias g_proxy_address_get_protocol = c_g_proxy_address_get_protocol;
alias g_proxy_address_get_uri = c_g_proxy_address_get_uri;
alias g_proxy_address_get_username = c_g_proxy_address_get_username;

// ProxyAddressEnumerator
alias g_proxy_address_enumerator_get_type = c_g_proxy_address_enumerator_get_type;

// ProxyResolver
alias g_proxy_resolver_get_type = c_g_proxy_resolver_get_type;
alias g_proxy_resolver_get_default = c_g_proxy_resolver_get_default;
alias g_proxy_resolver_is_supported = c_g_proxy_resolver_is_supported;
alias g_proxy_resolver_lookup = c_g_proxy_resolver_lookup;
alias g_proxy_resolver_lookup_async = c_g_proxy_resolver_lookup_async;
alias g_proxy_resolver_lookup_finish = c_g_proxy_resolver_lookup_finish;

// RemoteActionGroup
alias g_remote_action_group_get_type = c_g_remote_action_group_get_type;
alias g_remote_action_group_activate_action_full = c_g_remote_action_group_activate_action_full;
alias g_remote_action_group_change_action_state_full = c_g_remote_action_group_change_action_state_full;

// Resolver
alias g_resolver_get_type = c_g_resolver_get_type;
alias g_resolver_free_addresses = c_g_resolver_free_addresses;
alias g_resolver_free_targets = c_g_resolver_free_targets;
alias g_resolver_get_default = c_g_resolver_get_default;
alias g_resolver_get_timeout = c_g_resolver_get_timeout;
alias g_resolver_lookup_by_address = c_g_resolver_lookup_by_address;
alias g_resolver_lookup_by_address_async = c_g_resolver_lookup_by_address_async;
alias g_resolver_lookup_by_address_finish = c_g_resolver_lookup_by_address_finish;
alias g_resolver_lookup_by_name = c_g_resolver_lookup_by_name;
alias g_resolver_lookup_by_name_async = c_g_resolver_lookup_by_name_async;
alias g_resolver_lookup_by_name_finish = c_g_resolver_lookup_by_name_finish;
alias g_resolver_lookup_by_name_with_flags = c_g_resolver_lookup_by_name_with_flags;
alias g_resolver_lookup_by_name_with_flags_async = c_g_resolver_lookup_by_name_with_flags_async;
alias g_resolver_lookup_by_name_with_flags_finish = c_g_resolver_lookup_by_name_with_flags_finish;
alias g_resolver_lookup_records = c_g_resolver_lookup_records;
alias g_resolver_lookup_records_async = c_g_resolver_lookup_records_async;
alias g_resolver_lookup_records_finish = c_g_resolver_lookup_records_finish;
alias g_resolver_lookup_service = c_g_resolver_lookup_service;
alias g_resolver_lookup_service_async = c_g_resolver_lookup_service_async;
alias g_resolver_lookup_service_finish = c_g_resolver_lookup_service_finish;
alias g_resolver_set_default = c_g_resolver_set_default;
alias g_resolver_set_timeout = c_g_resolver_set_timeout;

// Resource
alias g_resource_get_type = c_g_resource_get_type;
alias g_resource_new_from_data = c_g_resource_new_from_data;
alias g_resource_enumerate_children = c_g_resource_enumerate_children;
alias g_resource_get_info = c_g_resource_get_info;
alias g_resource_lookup_data = c_g_resource_lookup_data;
alias g_resource_open_stream = c_g_resource_open_stream;
alias g_resource_ref = c_g_resource_ref;
alias g_resource_unref = c_g_resource_unref;
alias g_resource_load = c_g_resource_load;

// Seekable
alias g_seekable_get_type = c_g_seekable_get_type;
alias g_seekable_can_seek = c_g_seekable_can_seek;
alias g_seekable_can_truncate = c_g_seekable_can_truncate;
alias g_seekable_seek = c_g_seekable_seek;
alias g_seekable_tell = c_g_seekable_tell;
alias g_seekable_truncate = c_g_seekable_truncate;

// Settings
alias g_settings_get_type = c_g_settings_get_type;
alias g_settings_new = c_g_settings_new;
alias g_settings_new_full = c_g_settings_new_full;
alias g_settings_new_with_backend = c_g_settings_new_with_backend;
alias g_settings_new_with_backend_and_path = c_g_settings_new_with_backend_and_path;
alias g_settings_new_with_path = c_g_settings_new_with_path;
alias g_settings_list_relocatable_schemas = c_g_settings_list_relocatable_schemas;
alias g_settings_list_schemas = c_g_settings_list_schemas;
alias g_settings_sync = c_g_settings_sync;
alias g_settings_unbind = c_g_settings_unbind;
alias g_settings_apply = c_g_settings_apply;
alias g_settings_bind = c_g_settings_bind;
alias g_settings_bind_with_mapping = c_g_settings_bind_with_mapping;
alias g_settings_bind_writable = c_g_settings_bind_writable;
alias g_settings_create_action = c_g_settings_create_action;
alias g_settings_delay = c_g_settings_delay;
alias g_settings_get = c_g_settings_get;
alias g_settings_get_boolean = c_g_settings_get_boolean;
alias g_settings_get_child = c_g_settings_get_child;
alias g_settings_get_default_value = c_g_settings_get_default_value;
alias g_settings_get_double = c_g_settings_get_double;
alias g_settings_get_enum = c_g_settings_get_enum;
alias g_settings_get_flags = c_g_settings_get_flags;
alias g_settings_get_has_unapplied = c_g_settings_get_has_unapplied;
alias g_settings_get_int = c_g_settings_get_int;
alias g_settings_get_int64 = c_g_settings_get_int64;
alias g_settings_get_mapped = c_g_settings_get_mapped;
alias g_settings_get_range = c_g_settings_get_range;
alias g_settings_get_string = c_g_settings_get_string;
alias g_settings_get_strv = c_g_settings_get_strv;
alias g_settings_get_uint = c_g_settings_get_uint;
alias g_settings_get_uint64 = c_g_settings_get_uint64;
alias g_settings_get_user_value = c_g_settings_get_user_value;
alias g_settings_get_value = c_g_settings_get_value;
alias g_settings_is_writable = c_g_settings_is_writable;
alias g_settings_list_children = c_g_settings_list_children;
alias g_settings_list_keys = c_g_settings_list_keys;
alias g_settings_range_check = c_g_settings_range_check;
alias g_settings_reset = c_g_settings_reset;
alias g_settings_revert = c_g_settings_revert;
alias g_settings_set = c_g_settings_set;
alias g_settings_set_boolean = c_g_settings_set_boolean;
alias g_settings_set_double = c_g_settings_set_double;
alias g_settings_set_enum = c_g_settings_set_enum;
alias g_settings_set_flags = c_g_settings_set_flags;
alias g_settings_set_int = c_g_settings_set_int;
alias g_settings_set_int64 = c_g_settings_set_int64;
alias g_settings_set_string = c_g_settings_set_string;
alias g_settings_set_strv = c_g_settings_set_strv;
alias g_settings_set_uint = c_g_settings_set_uint;
alias g_settings_set_uint64 = c_g_settings_set_uint64;
alias g_settings_set_value = c_g_settings_set_value;

// SettingsBackend
alias g_settings_backend_get_type = c_g_settings_backend_get_type;
alias g_settings_backend_flatten_tree = c_g_settings_backend_flatten_tree;
alias g_settings_backend_get_default = c_g_settings_backend_get_default;
alias g_settings_backend_changed = c_g_settings_backend_changed;
alias g_settings_backend_changed_tree = c_g_settings_backend_changed_tree;
alias g_settings_backend_keys_changed = c_g_settings_backend_keys_changed;
alias g_settings_backend_path_changed = c_g_settings_backend_path_changed;
alias g_settings_backend_path_writable_changed = c_g_settings_backend_path_writable_changed;
alias g_settings_backend_writable_changed = c_g_settings_backend_writable_changed;

// SettingsSchema
alias g_settings_schema_get_type = c_g_settings_schema_get_type;
alias g_settings_schema_get_id = c_g_settings_schema_get_id;
alias g_settings_schema_get_key = c_g_settings_schema_get_key;
alias g_settings_schema_get_path = c_g_settings_schema_get_path;
alias g_settings_schema_has_key = c_g_settings_schema_has_key;
alias g_settings_schema_list_children = c_g_settings_schema_list_children;
alias g_settings_schema_list_keys = c_g_settings_schema_list_keys;
alias g_settings_schema_ref = c_g_settings_schema_ref;
alias g_settings_schema_unref = c_g_settings_schema_unref;

// SettingsSchemaKey
alias g_settings_schema_key_get_type = c_g_settings_schema_key_get_type;
alias g_settings_schema_key_get_default_value = c_g_settings_schema_key_get_default_value;
alias g_settings_schema_key_get_description = c_g_settings_schema_key_get_description;
alias g_settings_schema_key_get_name = c_g_settings_schema_key_get_name;
alias g_settings_schema_key_get_range = c_g_settings_schema_key_get_range;
alias g_settings_schema_key_get_summary = c_g_settings_schema_key_get_summary;
alias g_settings_schema_key_get_value_type = c_g_settings_schema_key_get_value_type;
alias g_settings_schema_key_range_check = c_g_settings_schema_key_range_check;
alias g_settings_schema_key_ref = c_g_settings_schema_key_ref;
alias g_settings_schema_key_unref = c_g_settings_schema_key_unref;

// SettingsSchemaSource
alias g_settings_schema_source_get_type = c_g_settings_schema_source_get_type;
alias g_settings_schema_source_new_from_directory = c_g_settings_schema_source_new_from_directory;
alias g_settings_schema_source_list_schemas = c_g_settings_schema_source_list_schemas;
alias g_settings_schema_source_lookup = c_g_settings_schema_source_lookup;
alias g_settings_schema_source_ref = c_g_settings_schema_source_ref;
alias g_settings_schema_source_unref = c_g_settings_schema_source_unref;
alias g_settings_schema_source_get_default = c_g_settings_schema_source_get_default;

// SimpleAction
alias g_simple_action_get_type = c_g_simple_action_get_type;
alias g_simple_action_new = c_g_simple_action_new;
alias g_simple_action_new_stateful = c_g_simple_action_new_stateful;
alias g_simple_action_set_enabled = c_g_simple_action_set_enabled;
alias g_simple_action_set_state = c_g_simple_action_set_state;
alias g_simple_action_set_state_hint = c_g_simple_action_set_state_hint;

// SimpleActionGroup
alias g_simple_action_group_get_type = c_g_simple_action_group_get_type;
alias g_simple_action_group_new = c_g_simple_action_group_new;
alias g_simple_action_group_add_entries = c_g_simple_action_group_add_entries;
alias g_simple_action_group_insert = c_g_simple_action_group_insert;
alias g_simple_action_group_lookup = c_g_simple_action_group_lookup;
alias g_simple_action_group_remove = c_g_simple_action_group_remove;

// SimpleAsyncResult
alias g_simple_async_result_get_type = c_g_simple_async_result_get_type;
alias g_simple_async_result_new = c_g_simple_async_result_new;
alias g_simple_async_result_new_error = c_g_simple_async_result_new_error;
alias g_simple_async_result_new_from_error = c_g_simple_async_result_new_from_error;
alias g_simple_async_result_new_take_error = c_g_simple_async_result_new_take_error;
alias g_simple_async_result_is_valid = c_g_simple_async_result_is_valid;
alias g_simple_async_result_complete = c_g_simple_async_result_complete;
alias g_simple_async_result_complete_in_idle = c_g_simple_async_result_complete_in_idle;
alias g_simple_async_result_get_op_res_gboolean = c_g_simple_async_result_get_op_res_gboolean;
alias g_simple_async_result_get_op_res_gpointer = c_g_simple_async_result_get_op_res_gpointer;
alias g_simple_async_result_get_op_res_gssize = c_g_simple_async_result_get_op_res_gssize;
alias g_simple_async_result_get_source_tag = c_g_simple_async_result_get_source_tag;
alias g_simple_async_result_propagate_error = c_g_simple_async_result_propagate_error;
alias g_simple_async_result_run_in_thread = c_g_simple_async_result_run_in_thread;
alias g_simple_async_result_set_check_cancellable = c_g_simple_async_result_set_check_cancellable;
alias g_simple_async_result_set_error = c_g_simple_async_result_set_error;
alias g_simple_async_result_set_error_va = c_g_simple_async_result_set_error_va;
alias g_simple_async_result_set_from_error = c_g_simple_async_result_set_from_error;
alias g_simple_async_result_set_handle_cancellation = c_g_simple_async_result_set_handle_cancellation;
alias g_simple_async_result_set_op_res_gboolean = c_g_simple_async_result_set_op_res_gboolean;
alias g_simple_async_result_set_op_res_gpointer = c_g_simple_async_result_set_op_res_gpointer;
alias g_simple_async_result_set_op_res_gssize = c_g_simple_async_result_set_op_res_gssize;
alias g_simple_async_result_take_error = c_g_simple_async_result_take_error;

// SimpleIOStream
alias g_simple_io_stream_get_type = c_g_simple_io_stream_get_type;
alias g_simple_io_stream_new = c_g_simple_io_stream_new;

// SimplePermission
alias g_simple_permission_get_type = c_g_simple_permission_get_type;
alias g_simple_permission_new = c_g_simple_permission_new;

// SimpleProxyResolver
alias g_simple_proxy_resolver_get_type = c_g_simple_proxy_resolver_get_type;
alias g_simple_proxy_resolver_new = c_g_simple_proxy_resolver_new;
alias g_simple_proxy_resolver_set_default_proxy = c_g_simple_proxy_resolver_set_default_proxy;
alias g_simple_proxy_resolver_set_ignore_hosts = c_g_simple_proxy_resolver_set_ignore_hosts;
alias g_simple_proxy_resolver_set_uri_proxy = c_g_simple_proxy_resolver_set_uri_proxy;

// Socket
alias g_socket_get_type = c_g_socket_get_type;
alias g_socket_new = c_g_socket_new;
alias g_socket_new_from_fd = c_g_socket_new_from_fd;
alias g_socket_accept = c_g_socket_accept;
alias g_socket_bind = c_g_socket_bind;
alias g_socket_check_connect_result = c_g_socket_check_connect_result;
alias g_socket_close = c_g_socket_close;
alias g_socket_condition_check = c_g_socket_condition_check;
alias g_socket_condition_timed_wait = c_g_socket_condition_timed_wait;
alias g_socket_condition_wait = c_g_socket_condition_wait;
alias g_socket_connect = c_g_socket_connect;
alias g_socket_connection_factory_create_connection = c_g_socket_connection_factory_create_connection;
alias g_socket_create_source = c_g_socket_create_source;
alias g_socket_get_available_bytes = c_g_socket_get_available_bytes;
alias g_socket_get_blocking = c_g_socket_get_blocking;
alias g_socket_get_broadcast = c_g_socket_get_broadcast;
alias g_socket_get_credentials = c_g_socket_get_credentials;
alias g_socket_get_family = c_g_socket_get_family;
alias g_socket_get_fd = c_g_socket_get_fd;
alias g_socket_get_keepalive = c_g_socket_get_keepalive;
alias g_socket_get_listen_backlog = c_g_socket_get_listen_backlog;
alias g_socket_get_local_address = c_g_socket_get_local_address;
alias g_socket_get_multicast_loopback = c_g_socket_get_multicast_loopback;
alias g_socket_get_multicast_ttl = c_g_socket_get_multicast_ttl;
alias g_socket_get_option = c_g_socket_get_option;
alias g_socket_get_protocol = c_g_socket_get_protocol;
alias g_socket_get_remote_address = c_g_socket_get_remote_address;
alias g_socket_get_socket_type = c_g_socket_get_socket_type;
alias g_socket_get_timeout = c_g_socket_get_timeout;
alias g_socket_get_ttl = c_g_socket_get_ttl;
alias g_socket_is_closed = c_g_socket_is_closed;
alias g_socket_is_connected = c_g_socket_is_connected;
alias g_socket_join_multicast_group = c_g_socket_join_multicast_group;
alias g_socket_join_multicast_group_ssm = c_g_socket_join_multicast_group_ssm;
alias g_socket_leave_multicast_group = c_g_socket_leave_multicast_group;
alias g_socket_leave_multicast_group_ssm = c_g_socket_leave_multicast_group_ssm;
alias g_socket_listen = c_g_socket_listen;
alias g_socket_receive = c_g_socket_receive;
alias g_socket_receive_bytes = c_g_socket_receive_bytes;
alias g_socket_receive_bytes_from = c_g_socket_receive_bytes_from;
alias g_socket_receive_from = c_g_socket_receive_from;
alias g_socket_receive_message = c_g_socket_receive_message;
alias g_socket_receive_messages = c_g_socket_receive_messages;
alias g_socket_receive_with_blocking = c_g_socket_receive_with_blocking;
alias g_socket_send = c_g_socket_send;
alias g_socket_send_message = c_g_socket_send_message;
alias g_socket_send_message_with_timeout = c_g_socket_send_message_with_timeout;
alias g_socket_send_messages = c_g_socket_send_messages;
alias g_socket_send_to = c_g_socket_send_to;
alias g_socket_send_with_blocking = c_g_socket_send_with_blocking;
alias g_socket_set_blocking = c_g_socket_set_blocking;
alias g_socket_set_broadcast = c_g_socket_set_broadcast;
alias g_socket_set_keepalive = c_g_socket_set_keepalive;
alias g_socket_set_listen_backlog = c_g_socket_set_listen_backlog;
alias g_socket_set_multicast_loopback = c_g_socket_set_multicast_loopback;
alias g_socket_set_multicast_ttl = c_g_socket_set_multicast_ttl;
alias g_socket_set_option = c_g_socket_set_option;
alias g_socket_set_timeout = c_g_socket_set_timeout;
alias g_socket_set_ttl = c_g_socket_set_ttl;
alias g_socket_shutdown = c_g_socket_shutdown;
alias g_socket_speaks_ipv4 = c_g_socket_speaks_ipv4;

// SocketAddress
alias g_socket_address_get_type = c_g_socket_address_get_type;
alias g_socket_address_new_from_native = c_g_socket_address_new_from_native;
alias g_socket_address_get_family = c_g_socket_address_get_family;
alias g_socket_address_get_native_size = c_g_socket_address_get_native_size;
alias g_socket_address_to_native = c_g_socket_address_to_native;

// SocketAddressEnumerator
alias g_socket_address_enumerator_get_type = c_g_socket_address_enumerator_get_type;
alias g_socket_address_enumerator_next = c_g_socket_address_enumerator_next;
alias g_socket_address_enumerator_next_async = c_g_socket_address_enumerator_next_async;
alias g_socket_address_enumerator_next_finish = c_g_socket_address_enumerator_next_finish;

// SocketClient
alias g_socket_client_get_type = c_g_socket_client_get_type;
alias g_socket_client_new = c_g_socket_client_new;
alias g_socket_client_add_application_proxy = c_g_socket_client_add_application_proxy;
alias g_socket_client_connect = c_g_socket_client_connect;
alias g_socket_client_connect_async = c_g_socket_client_connect_async;
alias g_socket_client_connect_finish = c_g_socket_client_connect_finish;
alias g_socket_client_connect_to_host = c_g_socket_client_connect_to_host;
alias g_socket_client_connect_to_host_async = c_g_socket_client_connect_to_host_async;
alias g_socket_client_connect_to_host_finish = c_g_socket_client_connect_to_host_finish;
alias g_socket_client_connect_to_service = c_g_socket_client_connect_to_service;
alias g_socket_client_connect_to_service_async = c_g_socket_client_connect_to_service_async;
alias g_socket_client_connect_to_service_finish = c_g_socket_client_connect_to_service_finish;
alias g_socket_client_connect_to_uri = c_g_socket_client_connect_to_uri;
alias g_socket_client_connect_to_uri_async = c_g_socket_client_connect_to_uri_async;
alias g_socket_client_connect_to_uri_finish = c_g_socket_client_connect_to_uri_finish;
alias g_socket_client_get_enable_proxy = c_g_socket_client_get_enable_proxy;
alias g_socket_client_get_family = c_g_socket_client_get_family;
alias g_socket_client_get_local_address = c_g_socket_client_get_local_address;
alias g_socket_client_get_protocol = c_g_socket_client_get_protocol;
alias g_socket_client_get_proxy_resolver = c_g_socket_client_get_proxy_resolver;
alias g_socket_client_get_socket_type = c_g_socket_client_get_socket_type;
alias g_socket_client_get_timeout = c_g_socket_client_get_timeout;
alias g_socket_client_get_tls = c_g_socket_client_get_tls;
alias g_socket_client_get_tls_validation_flags = c_g_socket_client_get_tls_validation_flags;
alias g_socket_client_set_enable_proxy = c_g_socket_client_set_enable_proxy;
alias g_socket_client_set_family = c_g_socket_client_set_family;
alias g_socket_client_set_local_address = c_g_socket_client_set_local_address;
alias g_socket_client_set_protocol = c_g_socket_client_set_protocol;
alias g_socket_client_set_proxy_resolver = c_g_socket_client_set_proxy_resolver;
alias g_socket_client_set_socket_type = c_g_socket_client_set_socket_type;
alias g_socket_client_set_timeout = c_g_socket_client_set_timeout;
alias g_socket_client_set_tls = c_g_socket_client_set_tls;
alias g_socket_client_set_tls_validation_flags = c_g_socket_client_set_tls_validation_flags;

// SocketConnectable
alias g_socket_connectable_get_type = c_g_socket_connectable_get_type;
alias g_socket_connectable_enumerate = c_g_socket_connectable_enumerate;
alias g_socket_connectable_proxy_enumerate = c_g_socket_connectable_proxy_enumerate;
alias g_socket_connectable_to_string = c_g_socket_connectable_to_string;

// SocketConnection
alias g_socket_connection_get_type = c_g_socket_connection_get_type;
alias g_socket_connection_factory_lookup_type = c_g_socket_connection_factory_lookup_type;
alias g_socket_connection_factory_register_type = c_g_socket_connection_factory_register_type;
alias g_socket_connection_connect = c_g_socket_connection_connect;
alias g_socket_connection_connect_async = c_g_socket_connection_connect_async;
alias g_socket_connection_connect_finish = c_g_socket_connection_connect_finish;
alias g_socket_connection_get_local_address = c_g_socket_connection_get_local_address;
alias g_socket_connection_get_remote_address = c_g_socket_connection_get_remote_address;
alias g_socket_connection_get_socket = c_g_socket_connection_get_socket;
alias g_socket_connection_is_connected = c_g_socket_connection_is_connected;

// SocketControlMessage
alias g_socket_control_message_get_type = c_g_socket_control_message_get_type;
alias g_socket_control_message_deserialize = c_g_socket_control_message_deserialize;
alias g_socket_control_message_get_level = c_g_socket_control_message_get_level;
alias g_socket_control_message_get_msg_type = c_g_socket_control_message_get_msg_type;
alias g_socket_control_message_get_size = c_g_socket_control_message_get_size;
alias g_socket_control_message_serialize = c_g_socket_control_message_serialize;

// SocketListener
alias g_socket_listener_get_type = c_g_socket_listener_get_type;
alias g_socket_listener_new = c_g_socket_listener_new;
alias g_socket_listener_accept = c_g_socket_listener_accept;
alias g_socket_listener_accept_async = c_g_socket_listener_accept_async;
alias g_socket_listener_accept_finish = c_g_socket_listener_accept_finish;
alias g_socket_listener_accept_socket = c_g_socket_listener_accept_socket;
alias g_socket_listener_accept_socket_async = c_g_socket_listener_accept_socket_async;
alias g_socket_listener_accept_socket_finish = c_g_socket_listener_accept_socket_finish;
alias g_socket_listener_add_address = c_g_socket_listener_add_address;
alias g_socket_listener_add_any_inet_port = c_g_socket_listener_add_any_inet_port;
alias g_socket_listener_add_inet_port = c_g_socket_listener_add_inet_port;
alias g_socket_listener_add_socket = c_g_socket_listener_add_socket;
alias g_socket_listener_close = c_g_socket_listener_close;
alias g_socket_listener_set_backlog = c_g_socket_listener_set_backlog;

// SocketService
alias g_socket_service_get_type = c_g_socket_service_get_type;
alias g_socket_service_new = c_g_socket_service_new;
alias g_socket_service_is_active = c_g_socket_service_is_active;
alias g_socket_service_start = c_g_socket_service_start;
alias g_socket_service_stop = c_g_socket_service_stop;

// SrvTarget
alias g_srv_target_get_type = c_g_srv_target_get_type;
alias g_srv_target_new = c_g_srv_target_new;
alias g_srv_target_copy = c_g_srv_target_copy;
alias g_srv_target_free = c_g_srv_target_free;
alias g_srv_target_get_hostname = c_g_srv_target_get_hostname;
alias g_srv_target_get_port = c_g_srv_target_get_port;
alias g_srv_target_get_priority = c_g_srv_target_get_priority;
alias g_srv_target_get_weight = c_g_srv_target_get_weight;
alias g_srv_target_list_sort = c_g_srv_target_list_sort;

// StaticResource
alias g_static_resource_fini = c_g_static_resource_fini;
alias g_static_resource_get_resource = c_g_static_resource_get_resource;
alias g_static_resource_init = c_g_static_resource_init;

// Subprocess
alias g_subprocess_get_type = c_g_subprocess_get_type;
alias g_subprocess_new = c_g_subprocess_new;
alias g_subprocess_newv = c_g_subprocess_newv;
alias g_subprocess_communicate = c_g_subprocess_communicate;
alias g_subprocess_communicate_async = c_g_subprocess_communicate_async;
alias g_subprocess_communicate_finish = c_g_subprocess_communicate_finish;
alias g_subprocess_communicate_utf8 = c_g_subprocess_communicate_utf8;
alias g_subprocess_communicate_utf8_async = c_g_subprocess_communicate_utf8_async;
alias g_subprocess_communicate_utf8_finish = c_g_subprocess_communicate_utf8_finish;
alias g_subprocess_force_exit = c_g_subprocess_force_exit;
alias g_subprocess_get_exit_status = c_g_subprocess_get_exit_status;
alias g_subprocess_get_identifier = c_g_subprocess_get_identifier;
alias g_subprocess_get_if_exited = c_g_subprocess_get_if_exited;
alias g_subprocess_get_if_signaled = c_g_subprocess_get_if_signaled;
alias g_subprocess_get_status = c_g_subprocess_get_status;
alias g_subprocess_get_stderr_pipe = c_g_subprocess_get_stderr_pipe;
alias g_subprocess_get_stdin_pipe = c_g_subprocess_get_stdin_pipe;
alias g_subprocess_get_stdout_pipe = c_g_subprocess_get_stdout_pipe;
alias g_subprocess_get_successful = c_g_subprocess_get_successful;
alias g_subprocess_get_term_sig = c_g_subprocess_get_term_sig;
alias g_subprocess_send_signal = c_g_subprocess_send_signal;
alias g_subprocess_wait = c_g_subprocess_wait;
alias g_subprocess_wait_async = c_g_subprocess_wait_async;
alias g_subprocess_wait_check = c_g_subprocess_wait_check;
alias g_subprocess_wait_check_async = c_g_subprocess_wait_check_async;
alias g_subprocess_wait_check_finish = c_g_subprocess_wait_check_finish;
alias g_subprocess_wait_finish = c_g_subprocess_wait_finish;

// SubprocessLauncher
alias g_subprocess_launcher_get_type = c_g_subprocess_launcher_get_type;
alias g_subprocess_launcher_new = c_g_subprocess_launcher_new;
alias g_subprocess_launcher_close = c_g_subprocess_launcher_close;
alias g_subprocess_launcher_getenv = c_g_subprocess_launcher_getenv;
alias g_subprocess_launcher_set_child_setup = c_g_subprocess_launcher_set_child_setup;
alias g_subprocess_launcher_set_cwd = c_g_subprocess_launcher_set_cwd;
alias g_subprocess_launcher_set_environ = c_g_subprocess_launcher_set_environ;
alias g_subprocess_launcher_set_flags = c_g_subprocess_launcher_set_flags;
alias g_subprocess_launcher_set_stderr_file_path = c_g_subprocess_launcher_set_stderr_file_path;
alias g_subprocess_launcher_set_stdin_file_path = c_g_subprocess_launcher_set_stdin_file_path;
alias g_subprocess_launcher_set_stdout_file_path = c_g_subprocess_launcher_set_stdout_file_path;
alias g_subprocess_launcher_setenv = c_g_subprocess_launcher_setenv;
alias g_subprocess_launcher_spawn = c_g_subprocess_launcher_spawn;
alias g_subprocess_launcher_spawnv = c_g_subprocess_launcher_spawnv;
alias g_subprocess_launcher_take_fd = c_g_subprocess_launcher_take_fd;
alias g_subprocess_launcher_take_stderr_fd = c_g_subprocess_launcher_take_stderr_fd;
alias g_subprocess_launcher_take_stdin_fd = c_g_subprocess_launcher_take_stdin_fd;
alias g_subprocess_launcher_take_stdout_fd = c_g_subprocess_launcher_take_stdout_fd;
alias g_subprocess_launcher_unsetenv = c_g_subprocess_launcher_unsetenv;

// Task
alias g_task_get_type = c_g_task_get_type;
alias g_task_new = c_g_task_new;
alias g_task_is_valid = c_g_task_is_valid;
alias g_task_report_error = c_g_task_report_error;
alias g_task_report_new_error = c_g_task_report_new_error;
alias g_task_attach_source = c_g_task_attach_source;
alias g_task_get_cancellable = c_g_task_get_cancellable;
alias g_task_get_check_cancellable = c_g_task_get_check_cancellable;
alias g_task_get_completed = c_g_task_get_completed;
alias g_task_get_context = c_g_task_get_context;
alias g_task_get_name = c_g_task_get_name;
alias g_task_get_priority = c_g_task_get_priority;
alias g_task_get_return_on_cancel = c_g_task_get_return_on_cancel;
alias g_task_get_source_object = c_g_task_get_source_object;
alias g_task_get_source_tag = c_g_task_get_source_tag;
alias g_task_get_task_data = c_g_task_get_task_data;
alias g_task_had_error = c_g_task_had_error;
alias g_task_propagate_boolean = c_g_task_propagate_boolean;
alias g_task_propagate_int = c_g_task_propagate_int;
alias g_task_propagate_pointer = c_g_task_propagate_pointer;
alias g_task_propagate_value = c_g_task_propagate_value;
alias g_task_return_boolean = c_g_task_return_boolean;
alias g_task_return_error = c_g_task_return_error;
alias g_task_return_error_if_cancelled = c_g_task_return_error_if_cancelled;
alias g_task_return_int = c_g_task_return_int;
alias g_task_return_new_error = c_g_task_return_new_error;
alias g_task_return_new_error_literal = c_g_task_return_new_error_literal;
alias g_task_return_pointer = c_g_task_return_pointer;
alias g_task_return_prefixed_error = c_g_task_return_prefixed_error;
alias g_task_return_value = c_g_task_return_value;
alias g_task_run_in_thread = c_g_task_run_in_thread;
alias g_task_run_in_thread_sync = c_g_task_run_in_thread_sync;
alias g_task_set_check_cancellable = c_g_task_set_check_cancellable;
alias g_task_set_name = c_g_task_set_name;
alias g_task_set_priority = c_g_task_set_priority;
alias g_task_set_return_on_cancel = c_g_task_set_return_on_cancel;
alias g_task_set_source_tag = c_g_task_set_source_tag;
alias g_task_set_static_name = c_g_task_set_static_name;
alias g_task_set_task_data = c_g_task_set_task_data;

// TcpConnection
alias g_tcp_connection_get_type = c_g_tcp_connection_get_type;
alias g_tcp_connection_get_graceful_disconnect = c_g_tcp_connection_get_graceful_disconnect;
alias g_tcp_connection_set_graceful_disconnect = c_g_tcp_connection_set_graceful_disconnect;

// TcpWrapperConnection
alias g_tcp_wrapper_connection_get_type = c_g_tcp_wrapper_connection_get_type;
alias g_tcp_wrapper_connection_new = c_g_tcp_wrapper_connection_new;
alias g_tcp_wrapper_connection_get_base_io_stream = c_g_tcp_wrapper_connection_get_base_io_stream;

// TestDBus
alias g_test_dbus_get_type = c_g_test_dbus_get_type;
alias g_test_dbus_new = c_g_test_dbus_new;
alias g_test_dbus_unset = c_g_test_dbus_unset;
alias g_test_dbus_add_service_dir = c_g_test_dbus_add_service_dir;
alias g_test_dbus_down = c_g_test_dbus_down;
alias g_test_dbus_get_bus_address = c_g_test_dbus_get_bus_address;
alias g_test_dbus_get_flags = c_g_test_dbus_get_flags;
alias g_test_dbus_stop = c_g_test_dbus_stop;
alias g_test_dbus_up = c_g_test_dbus_up;

// ThemedIcon
alias g_themed_icon_get_type = c_g_themed_icon_get_type;
alias g_themed_icon_new = c_g_themed_icon_new;
alias g_themed_icon_new_from_names = c_g_themed_icon_new_from_names;
alias g_themed_icon_new_with_default_fallbacks = c_g_themed_icon_new_with_default_fallbacks;
alias g_themed_icon_append_name = c_g_themed_icon_append_name;
alias g_themed_icon_get_names = c_g_themed_icon_get_names;
alias g_themed_icon_prepend_name = c_g_themed_icon_prepend_name;

// ThreadedResolver
alias g_threaded_resolver_get_type = c_g_threaded_resolver_get_type;

// ThreadedSocketService
alias g_threaded_socket_service_get_type = c_g_threaded_socket_service_get_type;
alias g_threaded_socket_service_new = c_g_threaded_socket_service_new;

// TlsBackend
alias g_tls_backend_get_type = c_g_tls_backend_get_type;
alias g_tls_backend_get_default = c_g_tls_backend_get_default;
alias g_tls_backend_get_certificate_type = c_g_tls_backend_get_certificate_type;
alias g_tls_backend_get_client_connection_type = c_g_tls_backend_get_client_connection_type;
alias g_tls_backend_get_default_database = c_g_tls_backend_get_default_database;
alias g_tls_backend_get_dtls_client_connection_type = c_g_tls_backend_get_dtls_client_connection_type;
alias g_tls_backend_get_dtls_server_connection_type = c_g_tls_backend_get_dtls_server_connection_type;
alias g_tls_backend_get_file_database_type = c_g_tls_backend_get_file_database_type;
alias g_tls_backend_get_server_connection_type = c_g_tls_backend_get_server_connection_type;
alias g_tls_backend_set_default_database = c_g_tls_backend_set_default_database;
alias g_tls_backend_supports_dtls = c_g_tls_backend_supports_dtls;
alias g_tls_backend_supports_tls = c_g_tls_backend_supports_tls;

// TlsCertificate
alias g_tls_certificate_get_type = c_g_tls_certificate_get_type;
alias g_tls_certificate_new_from_file = c_g_tls_certificate_new_from_file;
alias g_tls_certificate_new_from_file_with_password = c_g_tls_certificate_new_from_file_with_password;
alias g_tls_certificate_new_from_files = c_g_tls_certificate_new_from_files;
alias g_tls_certificate_new_from_pem = c_g_tls_certificate_new_from_pem;
alias g_tls_certificate_new_from_pkcs11_uris = c_g_tls_certificate_new_from_pkcs11_uris;
alias g_tls_certificate_new_from_pkcs12 = c_g_tls_certificate_new_from_pkcs12;
alias g_tls_certificate_list_new_from_file = c_g_tls_certificate_list_new_from_file;
alias g_tls_certificate_get_dns_names = c_g_tls_certificate_get_dns_names;
alias g_tls_certificate_get_ip_addresses = c_g_tls_certificate_get_ip_addresses;
alias g_tls_certificate_get_issuer = c_g_tls_certificate_get_issuer;
alias g_tls_certificate_get_issuer_name = c_g_tls_certificate_get_issuer_name;
alias g_tls_certificate_get_not_valid_after = c_g_tls_certificate_get_not_valid_after;
alias g_tls_certificate_get_not_valid_before = c_g_tls_certificate_get_not_valid_before;
alias g_tls_certificate_get_subject_name = c_g_tls_certificate_get_subject_name;
alias g_tls_certificate_is_same = c_g_tls_certificate_is_same;
alias g_tls_certificate_verify = c_g_tls_certificate_verify;

// TlsClientConnection
alias g_tls_client_connection_get_type = c_g_tls_client_connection_get_type;
alias g_tls_client_connection_new = c_g_tls_client_connection_new;
alias g_tls_client_connection_copy_session_state = c_g_tls_client_connection_copy_session_state;
alias g_tls_client_connection_get_accepted_cas = c_g_tls_client_connection_get_accepted_cas;
alias g_tls_client_connection_get_server_identity = c_g_tls_client_connection_get_server_identity;
alias g_tls_client_connection_get_use_ssl3 = c_g_tls_client_connection_get_use_ssl3;
alias g_tls_client_connection_get_validation_flags = c_g_tls_client_connection_get_validation_flags;
alias g_tls_client_connection_set_server_identity = c_g_tls_client_connection_set_server_identity;
alias g_tls_client_connection_set_use_ssl3 = c_g_tls_client_connection_set_use_ssl3;
alias g_tls_client_connection_set_validation_flags = c_g_tls_client_connection_set_validation_flags;

// TlsConnection
alias g_tls_connection_get_type = c_g_tls_connection_get_type;
alias g_tls_connection_emit_accept_certificate = c_g_tls_connection_emit_accept_certificate;
alias g_tls_connection_get_certificate = c_g_tls_connection_get_certificate;
alias g_tls_connection_get_channel_binding_data = c_g_tls_connection_get_channel_binding_data;
alias g_tls_connection_get_ciphersuite_name = c_g_tls_connection_get_ciphersuite_name;
alias g_tls_connection_get_database = c_g_tls_connection_get_database;
alias g_tls_connection_get_interaction = c_g_tls_connection_get_interaction;
alias g_tls_connection_get_negotiated_protocol = c_g_tls_connection_get_negotiated_protocol;
alias g_tls_connection_get_peer_certificate = c_g_tls_connection_get_peer_certificate;
alias g_tls_connection_get_peer_certificate_errors = c_g_tls_connection_get_peer_certificate_errors;
alias g_tls_connection_get_protocol_version = c_g_tls_connection_get_protocol_version;
alias g_tls_connection_get_rehandshake_mode = c_g_tls_connection_get_rehandshake_mode;
alias g_tls_connection_get_require_close_notify = c_g_tls_connection_get_require_close_notify;
alias g_tls_connection_get_use_system_certdb = c_g_tls_connection_get_use_system_certdb;
alias g_tls_connection_handshake = c_g_tls_connection_handshake;
alias g_tls_connection_handshake_async = c_g_tls_connection_handshake_async;
alias g_tls_connection_handshake_finish = c_g_tls_connection_handshake_finish;
alias g_tls_connection_set_advertised_protocols = c_g_tls_connection_set_advertised_protocols;
alias g_tls_connection_set_certificate = c_g_tls_connection_set_certificate;
alias g_tls_connection_set_database = c_g_tls_connection_set_database;
alias g_tls_connection_set_interaction = c_g_tls_connection_set_interaction;
alias g_tls_connection_set_rehandshake_mode = c_g_tls_connection_set_rehandshake_mode;
alias g_tls_connection_set_require_close_notify = c_g_tls_connection_set_require_close_notify;
alias g_tls_connection_set_use_system_certdb = c_g_tls_connection_set_use_system_certdb;

// TlsDatabase
alias g_tls_database_get_type = c_g_tls_database_get_type;
alias g_tls_database_create_certificate_handle = c_g_tls_database_create_certificate_handle;
alias g_tls_database_lookup_certificate_for_handle = c_g_tls_database_lookup_certificate_for_handle;
alias g_tls_database_lookup_certificate_for_handle_async = c_g_tls_database_lookup_certificate_for_handle_async;
alias g_tls_database_lookup_certificate_for_handle_finish = c_g_tls_database_lookup_certificate_for_handle_finish;
alias g_tls_database_lookup_certificate_issuer = c_g_tls_database_lookup_certificate_issuer;
alias g_tls_database_lookup_certificate_issuer_async = c_g_tls_database_lookup_certificate_issuer_async;
alias g_tls_database_lookup_certificate_issuer_finish = c_g_tls_database_lookup_certificate_issuer_finish;
alias g_tls_database_lookup_certificates_issued_by = c_g_tls_database_lookup_certificates_issued_by;
alias g_tls_database_lookup_certificates_issued_by_async = c_g_tls_database_lookup_certificates_issued_by_async;
alias g_tls_database_lookup_certificates_issued_by_finish = c_g_tls_database_lookup_certificates_issued_by_finish;
alias g_tls_database_verify_chain = c_g_tls_database_verify_chain;
alias g_tls_database_verify_chain_async = c_g_tls_database_verify_chain_async;
alias g_tls_database_verify_chain_finish = c_g_tls_database_verify_chain_finish;

// TlsFileDatabase
alias g_tls_file_database_get_type = c_g_tls_file_database_get_type;
alias g_tls_file_database_new = c_g_tls_file_database_new;

// TlsInteraction
alias g_tls_interaction_get_type = c_g_tls_interaction_get_type;
alias g_tls_interaction_ask_password = c_g_tls_interaction_ask_password;
alias g_tls_interaction_ask_password_async = c_g_tls_interaction_ask_password_async;
alias g_tls_interaction_ask_password_finish = c_g_tls_interaction_ask_password_finish;
alias g_tls_interaction_invoke_ask_password = c_g_tls_interaction_invoke_ask_password;
alias g_tls_interaction_invoke_request_certificate = c_g_tls_interaction_invoke_request_certificate;
alias g_tls_interaction_request_certificate = c_g_tls_interaction_request_certificate;
alias g_tls_interaction_request_certificate_async = c_g_tls_interaction_request_certificate_async;
alias g_tls_interaction_request_certificate_finish = c_g_tls_interaction_request_certificate_finish;

// TlsPassword
alias g_tls_password_get_type = c_g_tls_password_get_type;
alias g_tls_password_new = c_g_tls_password_new;
alias g_tls_password_get_description = c_g_tls_password_get_description;
alias g_tls_password_get_flags = c_g_tls_password_get_flags;
alias g_tls_password_get_value = c_g_tls_password_get_value;
alias g_tls_password_get_warning = c_g_tls_password_get_warning;
alias g_tls_password_set_description = c_g_tls_password_set_description;
alias g_tls_password_set_flags = c_g_tls_password_set_flags;
alias g_tls_password_set_value = c_g_tls_password_set_value;
alias g_tls_password_set_value_full = c_g_tls_password_set_value_full;
alias g_tls_password_set_warning = c_g_tls_password_set_warning;

// TlsServerConnection
alias g_tls_server_connection_get_type = c_g_tls_server_connection_get_type;
alias g_tls_server_connection_new = c_g_tls_server_connection_new;

// UnixConnection
alias g_unix_connection_get_type = c_g_unix_connection_get_type;
alias g_unix_connection_receive_credentials = c_g_unix_connection_receive_credentials;
alias g_unix_connection_receive_credentials_async = c_g_unix_connection_receive_credentials_async;
alias g_unix_connection_receive_credentials_finish = c_g_unix_connection_receive_credentials_finish;
alias g_unix_connection_receive_fd = c_g_unix_connection_receive_fd;
alias g_unix_connection_send_credentials = c_g_unix_connection_send_credentials;
alias g_unix_connection_send_credentials_async = c_g_unix_connection_send_credentials_async;
alias g_unix_connection_send_credentials_finish = c_g_unix_connection_send_credentials_finish;
alias g_unix_connection_send_fd = c_g_unix_connection_send_fd;

// UnixCredentialsMessage
alias g_unix_credentials_message_get_type = c_g_unix_credentials_message_get_type;
alias g_unix_credentials_message_new = c_g_unix_credentials_message_new;
alias g_unix_credentials_message_new_with_credentials = c_g_unix_credentials_message_new_with_credentials;
alias g_unix_credentials_message_is_supported = c_g_unix_credentials_message_is_supported;
alias g_unix_credentials_message_get_credentials = c_g_unix_credentials_message_get_credentials;

// UnixFDList
alias g_unix_fd_list_get_type = c_g_unix_fd_list_get_type;
alias g_unix_fd_list_new = c_g_unix_fd_list_new;
alias g_unix_fd_list_new_from_array = c_g_unix_fd_list_new_from_array;
alias g_unix_fd_list_append = c_g_unix_fd_list_append;
alias g_unix_fd_list_get = c_g_unix_fd_list_get;
alias g_unix_fd_list_get_length = c_g_unix_fd_list_get_length;
alias g_unix_fd_list_peek_fds = c_g_unix_fd_list_peek_fds;
alias g_unix_fd_list_steal_fds = c_g_unix_fd_list_steal_fds;

// UnixFDMessage
alias g_unix_fd_message_get_type = c_g_unix_fd_message_get_type;
alias g_unix_fd_message_new = c_g_unix_fd_message_new;
alias g_unix_fd_message_new_with_fd_list = c_g_unix_fd_message_new_with_fd_list;
alias g_unix_fd_message_append_fd = c_g_unix_fd_message_append_fd;
alias g_unix_fd_message_get_fd_list = c_g_unix_fd_message_get_fd_list;
alias g_unix_fd_message_steal_fds = c_g_unix_fd_message_steal_fds;

// UnixInputStream
alias g_unix_input_stream_get_type = c_g_unix_input_stream_get_type;
alias g_unix_input_stream_new = c_g_unix_input_stream_new;
alias g_unix_input_stream_get_close_fd = c_g_unix_input_stream_get_close_fd;
alias g_unix_input_stream_get_fd = c_g_unix_input_stream_get_fd;
alias g_unix_input_stream_set_close_fd = c_g_unix_input_stream_set_close_fd;

// UnixMountEntry
alias g_unix_mount_entry_get_type = c_g_unix_mount_entry_get_type;

// UnixMountMonitor
alias g_unix_mount_monitor_get_type = c_g_unix_mount_monitor_get_type;
alias g_unix_mount_monitor_new = c_g_unix_mount_monitor_new;
alias g_unix_mount_monitor_get = c_g_unix_mount_monitor_get;
alias g_unix_mount_monitor_set_rate_limit = c_g_unix_mount_monitor_set_rate_limit;

// UnixMountPoint
alias g_unix_mount_point_get_type = c_g_unix_mount_point_get_type;
alias g_unix_mount_point_compare = c_g_unix_mount_point_compare;
alias g_unix_mount_point_copy = c_g_unix_mount_point_copy;
alias g_unix_mount_point_free = c_g_unix_mount_point_free;
alias g_unix_mount_point_get_device_path = c_g_unix_mount_point_get_device_path;
alias g_unix_mount_point_get_fs_type = c_g_unix_mount_point_get_fs_type;
alias g_unix_mount_point_get_mount_path = c_g_unix_mount_point_get_mount_path;
alias g_unix_mount_point_get_options = c_g_unix_mount_point_get_options;
alias g_unix_mount_point_guess_can_eject = c_g_unix_mount_point_guess_can_eject;
alias g_unix_mount_point_guess_icon = c_g_unix_mount_point_guess_icon;
alias g_unix_mount_point_guess_name = c_g_unix_mount_point_guess_name;
alias g_unix_mount_point_guess_symbolic_icon = c_g_unix_mount_point_guess_symbolic_icon;
alias g_unix_mount_point_is_loopback = c_g_unix_mount_point_is_loopback;
alias g_unix_mount_point_is_readonly = c_g_unix_mount_point_is_readonly;
alias g_unix_mount_point_is_user_mountable = c_g_unix_mount_point_is_user_mountable;
alias g_unix_mount_point_at = c_g_unix_mount_point_at;

// UnixOutputStream
alias g_unix_output_stream_get_type = c_g_unix_output_stream_get_type;
alias g_unix_output_stream_new = c_g_unix_output_stream_new;
alias g_unix_output_stream_get_close_fd = c_g_unix_output_stream_get_close_fd;
alias g_unix_output_stream_get_fd = c_g_unix_output_stream_get_fd;
alias g_unix_output_stream_set_close_fd = c_g_unix_output_stream_set_close_fd;

// UnixSocketAddress
alias g_unix_socket_address_get_type = c_g_unix_socket_address_get_type;
alias g_unix_socket_address_new = c_g_unix_socket_address_new;
alias g_unix_socket_address_new_abstract = c_g_unix_socket_address_new_abstract;
alias g_unix_socket_address_new_with_type = c_g_unix_socket_address_new_with_type;
alias g_unix_socket_address_abstract_names_supported = c_g_unix_socket_address_abstract_names_supported;
alias g_unix_socket_address_get_address_type = c_g_unix_socket_address_get_address_type;
alias g_unix_socket_address_get_is_abstract = c_g_unix_socket_address_get_is_abstract;
alias g_unix_socket_address_get_path = c_g_unix_socket_address_get_path;
alias g_unix_socket_address_get_path_len = c_g_unix_socket_address_get_path_len;

// Vfs
alias g_vfs_get_type = c_g_vfs_get_type;
alias g_vfs_get_default = c_g_vfs_get_default;
alias g_vfs_get_local = c_g_vfs_get_local;
alias g_vfs_get_file_for_path = c_g_vfs_get_file_for_path;
alias g_vfs_get_file_for_uri = c_g_vfs_get_file_for_uri;
alias g_vfs_get_supported_uri_schemes = c_g_vfs_get_supported_uri_schemes;
alias g_vfs_is_active = c_g_vfs_is_active;
alias g_vfs_parse_name = c_g_vfs_parse_name;
alias g_vfs_register_uri_scheme = c_g_vfs_register_uri_scheme;
alias g_vfs_unregister_uri_scheme = c_g_vfs_unregister_uri_scheme;

// Volume
alias g_volume_get_type = c_g_volume_get_type;
alias g_volume_can_eject = c_g_volume_can_eject;
alias g_volume_can_mount = c_g_volume_can_mount;
alias g_volume_eject = c_g_volume_eject;
alias g_volume_eject_finish = c_g_volume_eject_finish;
alias g_volume_eject_with_operation = c_g_volume_eject_with_operation;
alias g_volume_eject_with_operation_finish = c_g_volume_eject_with_operation_finish;
alias g_volume_enumerate_identifiers = c_g_volume_enumerate_identifiers;
alias g_volume_get_activation_root = c_g_volume_get_activation_root;
alias g_volume_get_drive = c_g_volume_get_drive;
alias g_volume_get_icon = c_g_volume_get_icon;
alias g_volume_get_identifier = c_g_volume_get_identifier;
alias g_volume_get_mount = c_g_volume_get_mount;
alias g_volume_get_name = c_g_volume_get_name;
alias g_volume_get_sort_key = c_g_volume_get_sort_key;
alias g_volume_get_symbolic_icon = c_g_volume_get_symbolic_icon;
alias g_volume_get_uuid = c_g_volume_get_uuid;
alias g_volume_mount = c_g_volume_mount;
alias g_volume_mount_finish = c_g_volume_mount_finish;
alias g_volume_should_automount = c_g_volume_should_automount;

// VolumeMonitor
alias g_volume_monitor_get_type = c_g_volume_monitor_get_type;
alias g_volume_monitor_adopt_orphan_mount = c_g_volume_monitor_adopt_orphan_mount;
alias g_volume_monitor_get = c_g_volume_monitor_get;
alias g_volume_monitor_get_connected_drives = c_g_volume_monitor_get_connected_drives;
alias g_volume_monitor_get_mount_for_uuid = c_g_volume_monitor_get_mount_for_uuid;
alias g_volume_monitor_get_mounts = c_g_volume_monitor_get_mounts;
alias g_volume_monitor_get_volume_for_uuid = c_g_volume_monitor_get_volume_for_uuid;
alias g_volume_monitor_get_volumes = c_g_volume_monitor_get_volumes;

// ZlibCompressor
alias g_zlib_compressor_get_type = c_g_zlib_compressor_get_type;
alias g_zlib_compressor_new = c_g_zlib_compressor_new;
alias g_zlib_compressor_get_file_info = c_g_zlib_compressor_get_file_info;
alias g_zlib_compressor_set_file_info = c_g_zlib_compressor_set_file_info;

// ZlibDecompressor
alias g_zlib_decompressor_get_type = c_g_zlib_decompressor_get_type;
alias g_zlib_decompressor_new = c_g_zlib_decompressor_new;
alias g_zlib_decompressor_get_file_info = c_g_zlib_decompressor_get_file_info;

shared static this()
{
  // Action
  link(g_action_get_type, "g_action_get_type");
  link(g_action_name_is_valid, "g_action_name_is_valid");
  link(g_action_parse_detailed_name, "g_action_parse_detailed_name");
  link(g_action_print_detailed_name, "g_action_print_detailed_name");
  link(g_action_activate, "g_action_activate");
  link(g_action_change_state, "g_action_change_state");
  link(g_action_get_enabled, "g_action_get_enabled");
  link(g_action_get_name, "g_action_get_name");
  link(g_action_get_parameter_type, "g_action_get_parameter_type");
  link(g_action_get_state, "g_action_get_state");
  link(g_action_get_state_hint, "g_action_get_state_hint");
  link(g_action_get_state_type, "g_action_get_state_type");

  // ActionGroup
  link(g_action_group_get_type, "g_action_group_get_type");
  link(g_action_group_action_added, "g_action_group_action_added");
  link(g_action_group_action_enabled_changed, "g_action_group_action_enabled_changed");
  link(g_action_group_action_removed, "g_action_group_action_removed");
  link(g_action_group_action_state_changed, "g_action_group_action_state_changed");
  link(g_action_group_activate_action, "g_action_group_activate_action");
  link(g_action_group_change_action_state, "g_action_group_change_action_state");
  link(g_action_group_get_action_enabled, "g_action_group_get_action_enabled");
  link(g_action_group_get_action_parameter_type, "g_action_group_get_action_parameter_type");
  link(g_action_group_get_action_state, "g_action_group_get_action_state");
  link(g_action_group_get_action_state_hint, "g_action_group_get_action_state_hint");
  link(g_action_group_get_action_state_type, "g_action_group_get_action_state_type");
  link(g_action_group_has_action, "g_action_group_has_action");
  link(g_action_group_list_actions, "g_action_group_list_actions");
  link(g_action_group_query_action, "g_action_group_query_action");

  // ActionMap
  link(g_action_map_get_type, "g_action_map_get_type");
  link(g_action_map_add_action, "g_action_map_add_action");
  link(g_action_map_add_action_entries, "g_action_map_add_action_entries");
  link(g_action_map_lookup_action, "g_action_map_lookup_action");
  link(g_action_map_remove_action, "g_action_map_remove_action");
  link(g_action_map_remove_action_entries, "g_action_map_remove_action_entries");

  // AppInfo
  link(g_app_info_get_type, "g_app_info_get_type");
  link(g_app_info_create_from_commandline, "g_app_info_create_from_commandline");
  link(g_app_info_get_all, "g_app_info_get_all");
  link(g_app_info_get_all_for_type, "g_app_info_get_all_for_type");
  link(g_app_info_get_default_for_type, "g_app_info_get_default_for_type");
  link(g_app_info_get_default_for_type_async, "g_app_info_get_default_for_type_async");
  link(g_app_info_get_default_for_type_finish, "g_app_info_get_default_for_type_finish");
  link(g_app_info_get_default_for_uri_scheme, "g_app_info_get_default_for_uri_scheme");
  link(g_app_info_get_default_for_uri_scheme_async, "g_app_info_get_default_for_uri_scheme_async");
  link(g_app_info_get_default_for_uri_scheme_finish, "g_app_info_get_default_for_uri_scheme_finish");
  link(g_app_info_get_fallback_for_type, "g_app_info_get_fallback_for_type");
  link(g_app_info_get_recommended_for_type, "g_app_info_get_recommended_for_type");
  link(g_app_info_launch_default_for_uri, "g_app_info_launch_default_for_uri");
  link(g_app_info_launch_default_for_uri_async, "g_app_info_launch_default_for_uri_async");
  link(g_app_info_launch_default_for_uri_finish, "g_app_info_launch_default_for_uri_finish");
  link(g_app_info_reset_type_associations, "g_app_info_reset_type_associations");
  link(g_app_info_add_supports_type, "g_app_info_add_supports_type");
  link(g_app_info_can_delete, "g_app_info_can_delete");
  link(g_app_info_can_remove_supports_type, "g_app_info_can_remove_supports_type");
  link(g_app_info_delete, "g_app_info_delete");
  link(g_app_info_dup, "g_app_info_dup");
  link(g_app_info_equal, "g_app_info_equal");
  link(g_app_info_get_commandline, "g_app_info_get_commandline");
  link(g_app_info_get_description, "g_app_info_get_description");
  link(g_app_info_get_display_name, "g_app_info_get_display_name");
  link(g_app_info_get_executable, "g_app_info_get_executable");
  link(g_app_info_get_icon, "g_app_info_get_icon");
  link(g_app_info_get_id, "g_app_info_get_id");
  link(g_app_info_get_name, "g_app_info_get_name");
  link(g_app_info_get_supported_types, "g_app_info_get_supported_types");
  link(g_app_info_launch, "g_app_info_launch");
  link(g_app_info_launch_uris, "g_app_info_launch_uris");
  link(g_app_info_launch_uris_async, "g_app_info_launch_uris_async");
  link(g_app_info_launch_uris_finish, "g_app_info_launch_uris_finish");
  link(g_app_info_remove_supports_type, "g_app_info_remove_supports_type");
  link(g_app_info_set_as_default_for_extension, "g_app_info_set_as_default_for_extension");
  link(g_app_info_set_as_default_for_type, "g_app_info_set_as_default_for_type");
  link(g_app_info_set_as_last_used_for_type, "g_app_info_set_as_last_used_for_type");
  link(g_app_info_should_show, "g_app_info_should_show");
  link(g_app_info_supports_files, "g_app_info_supports_files");
  link(g_app_info_supports_uris, "g_app_info_supports_uris");

  // AppInfoMonitor
  link(g_app_info_monitor_get_type, "g_app_info_monitor_get_type");
  link(g_app_info_monitor_get, "g_app_info_monitor_get");

  // AppLaunchContext
  link(g_app_launch_context_get_type, "g_app_launch_context_get_type");
  link(g_app_launch_context_new, "g_app_launch_context_new");
  link(g_app_launch_context_get_display, "g_app_launch_context_get_display");
  link(g_app_launch_context_get_environment, "g_app_launch_context_get_environment");
  link(g_app_launch_context_get_startup_notify_id, "g_app_launch_context_get_startup_notify_id");
  link(g_app_launch_context_launch_failed, "g_app_launch_context_launch_failed");
  link(g_app_launch_context_setenv, "g_app_launch_context_setenv");
  link(g_app_launch_context_unsetenv, "g_app_launch_context_unsetenv");

  // Application
  link(g_application_get_type, "g_application_get_type");
  link(g_application_new, "g_application_new");
  link(g_application_get_default, "g_application_get_default");
  link(g_application_id_is_valid, "g_application_id_is_valid");
  link(g_application_activate, "g_application_activate");
  link(g_application_add_main_option, "g_application_add_main_option");
  link(g_application_add_main_option_entries, "g_application_add_main_option_entries");
  link(g_application_add_option_group, "g_application_add_option_group");
  link(g_application_bind_busy_property, "g_application_bind_busy_property");
  link(g_application_get_application_id, "g_application_get_application_id");
  link(g_application_get_dbus_connection, "g_application_get_dbus_connection");
  link(g_application_get_dbus_object_path, "g_application_get_dbus_object_path");
  link(g_application_get_flags, "g_application_get_flags");
  link(g_application_get_inactivity_timeout, "g_application_get_inactivity_timeout");
  link(g_application_get_is_busy, "g_application_get_is_busy");
  link(g_application_get_is_registered, "g_application_get_is_registered");
  link(g_application_get_is_remote, "g_application_get_is_remote");
  link(g_application_get_resource_base_path, "g_application_get_resource_base_path");
  link(g_application_get_version, "g_application_get_version");
  link(g_application_hold, "g_application_hold");
  link(g_application_mark_busy, "g_application_mark_busy");
  link(g_application_open, "g_application_open");
  link(g_application_quit, "g_application_quit");
  link(g_application_register, "g_application_register");
  link(g_application_release, "g_application_release");
  link(g_application_run, "g_application_run");
  link(g_application_send_notification, "g_application_send_notification");
  link(g_application_set_action_group, "g_application_set_action_group");
  link(g_application_set_application_id, "g_application_set_application_id");
  link(g_application_set_default, "g_application_set_default");
  link(g_application_set_flags, "g_application_set_flags");
  link(g_application_set_inactivity_timeout, "g_application_set_inactivity_timeout");
  link(g_application_set_option_context_description, "g_application_set_option_context_description");
  link(g_application_set_option_context_parameter_string, "g_application_set_option_context_parameter_string");
  link(g_application_set_option_context_summary, "g_application_set_option_context_summary");
  link(g_application_set_resource_base_path, "g_application_set_resource_base_path");
  link(g_application_set_version, "g_application_set_version");
  link(g_application_unbind_busy_property, "g_application_unbind_busy_property");
  link(g_application_unmark_busy, "g_application_unmark_busy");
  link(g_application_withdraw_notification, "g_application_withdraw_notification");

  // ApplicationCommandLine
  link(g_application_command_line_get_type, "g_application_command_line_get_type");
  link(g_application_command_line_create_file_for_arg, "g_application_command_line_create_file_for_arg");
  link(g_application_command_line_done, "g_application_command_line_done");
  link(g_application_command_line_get_arguments, "g_application_command_line_get_arguments");
  link(g_application_command_line_get_cwd, "g_application_command_line_get_cwd");
  link(g_application_command_line_get_environ, "g_application_command_line_get_environ");
  link(g_application_command_line_get_exit_status, "g_application_command_line_get_exit_status");
  link(g_application_command_line_get_is_remote, "g_application_command_line_get_is_remote");
  link(g_application_command_line_get_options_dict, "g_application_command_line_get_options_dict");
  link(g_application_command_line_get_platform_data, "g_application_command_line_get_platform_data");
  link(g_application_command_line_get_stdin, "g_application_command_line_get_stdin");
  link(g_application_command_line_getenv, "g_application_command_line_getenv");
  link(g_application_command_line_print, "g_application_command_line_print");
  link(g_application_command_line_print_literal, "g_application_command_line_print_literal");
  link(g_application_command_line_printerr, "g_application_command_line_printerr");
  link(g_application_command_line_printerr_literal, "g_application_command_line_printerr_literal");
  link(g_application_command_line_set_exit_status, "g_application_command_line_set_exit_status");

  // AsyncInitable
  link(g_async_initable_get_type, "g_async_initable_get_type");
  link(g_async_initable_new_async, "g_async_initable_new_async");
  link(g_async_initable_new_valist_async, "g_async_initable_new_valist_async");
  link(g_async_initable_newv_async, "g_async_initable_newv_async");
  link(g_async_initable_init_async, "g_async_initable_init_async");
  link(g_async_initable_init_finish, "g_async_initable_init_finish");
  link(g_async_initable_new_finish, "g_async_initable_new_finish");

  // AsyncResult
  link(g_async_result_get_type, "g_async_result_get_type");
  link(g_async_result_get_source_object, "g_async_result_get_source_object");
  link(g_async_result_get_user_data, "g_async_result_get_user_data");
  link(g_async_result_is_tagged, "g_async_result_is_tagged");
  link(g_async_result_legacy_propagate_error, "g_async_result_legacy_propagate_error");

  // BufferedInputStream
  link(g_buffered_input_stream_get_type, "g_buffered_input_stream_get_type");
  link(g_buffered_input_stream_new, "g_buffered_input_stream_new");
  link(g_buffered_input_stream_new_sized, "g_buffered_input_stream_new_sized");
  link(g_buffered_input_stream_fill, "g_buffered_input_stream_fill");
  link(g_buffered_input_stream_fill_async, "g_buffered_input_stream_fill_async");
  link(g_buffered_input_stream_fill_finish, "g_buffered_input_stream_fill_finish");
  link(g_buffered_input_stream_get_available, "g_buffered_input_stream_get_available");
  link(g_buffered_input_stream_get_buffer_size, "g_buffered_input_stream_get_buffer_size");
  link(g_buffered_input_stream_peek, "g_buffered_input_stream_peek");
  link(g_buffered_input_stream_peek_buffer, "g_buffered_input_stream_peek_buffer");
  link(g_buffered_input_stream_read_byte, "g_buffered_input_stream_read_byte");
  link(g_buffered_input_stream_set_buffer_size, "g_buffered_input_stream_set_buffer_size");

  // BufferedOutputStream
  link(g_buffered_output_stream_get_type, "g_buffered_output_stream_get_type");
  link(g_buffered_output_stream_new, "g_buffered_output_stream_new");
  link(g_buffered_output_stream_new_sized, "g_buffered_output_stream_new_sized");
  link(g_buffered_output_stream_get_auto_grow, "g_buffered_output_stream_get_auto_grow");
  link(g_buffered_output_stream_get_buffer_size, "g_buffered_output_stream_get_buffer_size");
  link(g_buffered_output_stream_set_auto_grow, "g_buffered_output_stream_set_auto_grow");
  link(g_buffered_output_stream_set_buffer_size, "g_buffered_output_stream_set_buffer_size");

  // BytesIcon
  link(g_bytes_icon_get_type, "g_bytes_icon_get_type");
  link(g_bytes_icon_new, "g_bytes_icon_new");
  link(g_bytes_icon_get_bytes, "g_bytes_icon_get_bytes");

  // Cancellable
  link(g_cancellable_get_type, "g_cancellable_get_type");
  link(g_cancellable_new, "g_cancellable_new");
  link(g_cancellable_get_current, "g_cancellable_get_current");
  link(g_cancellable_cancel, "g_cancellable_cancel");
  link(g_cancellable_connect, "g_cancellable_connect");
  link(g_cancellable_disconnect, "g_cancellable_disconnect");
  link(g_cancellable_get_fd, "g_cancellable_get_fd");
  link(g_cancellable_is_cancelled, "g_cancellable_is_cancelled");
  link(g_cancellable_make_pollfd, "g_cancellable_make_pollfd");
  link(g_cancellable_pop_current, "g_cancellable_pop_current");
  link(g_cancellable_push_current, "g_cancellable_push_current");
  link(g_cancellable_release_fd, "g_cancellable_release_fd");
  link(g_cancellable_reset, "g_cancellable_reset");
  link(g_cancellable_set_error_if_cancelled, "g_cancellable_set_error_if_cancelled");
  link(g_cancellable_source_new, "g_cancellable_source_new");

  // CharsetConverter
  link(g_charset_converter_get_type, "g_charset_converter_get_type");
  link(g_charset_converter_new, "g_charset_converter_new");
  link(g_charset_converter_get_num_fallbacks, "g_charset_converter_get_num_fallbacks");
  link(g_charset_converter_get_use_fallback, "g_charset_converter_get_use_fallback");
  link(g_charset_converter_set_use_fallback, "g_charset_converter_set_use_fallback");

  // Converter
  link(g_converter_get_type, "g_converter_get_type");
  link(g_converter_convert, "g_converter_convert");
  link(g_converter_reset, "g_converter_reset");

  // ConverterInputStream
  link(g_converter_input_stream_get_type, "g_converter_input_stream_get_type");
  link(g_converter_input_stream_new, "g_converter_input_stream_new");
  link(g_converter_input_stream_get_converter, "g_converter_input_stream_get_converter");

  // ConverterOutputStream
  link(g_converter_output_stream_get_type, "g_converter_output_stream_get_type");
  link(g_converter_output_stream_new, "g_converter_output_stream_new");
  link(g_converter_output_stream_get_converter, "g_converter_output_stream_get_converter");

  // Credentials
  link(g_credentials_get_type, "g_credentials_get_type");
  link(g_credentials_new, "g_credentials_new");
  link(g_credentials_get_native, "g_credentials_get_native");
  link(g_credentials_get_unix_pid, "g_credentials_get_unix_pid");
  link(g_credentials_get_unix_user, "g_credentials_get_unix_user");
  link(g_credentials_is_same_user, "g_credentials_is_same_user");
  link(g_credentials_set_native, "g_credentials_set_native");
  link(g_credentials_set_unix_user, "g_credentials_set_unix_user");
  link(g_credentials_to_string, "g_credentials_to_string");

  // DBusActionGroup
  link(g_dbus_action_group_get_type, "g_dbus_action_group_get_type");
  link(g_dbus_action_group_get, "g_dbus_action_group_get");

  // DBusAnnotationInfo
  link(g_dbus_annotation_info_get_type, "g_dbus_annotation_info_get_type");
  link(g_dbus_annotation_info_ref, "g_dbus_annotation_info_ref");
  link(g_dbus_annotation_info_unref, "g_dbus_annotation_info_unref");
  link(g_dbus_annotation_info_lookup, "g_dbus_annotation_info_lookup");

  // DBusArgInfo
  link(g_dbus_arg_info_get_type, "g_dbus_arg_info_get_type");
  link(g_dbus_arg_info_ref, "g_dbus_arg_info_ref");
  link(g_dbus_arg_info_unref, "g_dbus_arg_info_unref");

  // DBusAuthObserver
  link(g_dbus_auth_observer_get_type, "g_dbus_auth_observer_get_type");
  link(g_dbus_auth_observer_new, "g_dbus_auth_observer_new");
  link(g_dbus_auth_observer_allow_mechanism, "g_dbus_auth_observer_allow_mechanism");
  link(g_dbus_auth_observer_authorize_authenticated_peer, "g_dbus_auth_observer_authorize_authenticated_peer");

  // DBusConnection
  link(g_dbus_connection_get_type, "g_dbus_connection_get_type");
  link(g_dbus_connection_new_finish, "g_dbus_connection_new_finish");
  link(g_dbus_connection_new_for_address_finish, "g_dbus_connection_new_for_address_finish");
  link(g_dbus_connection_new_for_address_sync, "g_dbus_connection_new_for_address_sync");
  link(g_dbus_connection_new_sync, "g_dbus_connection_new_sync");
  link(g_dbus_connection_new, "g_dbus_connection_new");
  link(g_dbus_connection_new_for_address, "g_dbus_connection_new_for_address");
  link(g_dbus_connection_add_filter, "g_dbus_connection_add_filter");
  link(g_dbus_connection_call, "g_dbus_connection_call");
  link(g_dbus_connection_call_finish, "g_dbus_connection_call_finish");
  link(g_dbus_connection_call_sync, "g_dbus_connection_call_sync");
  link(g_dbus_connection_call_with_unix_fd_list, "g_dbus_connection_call_with_unix_fd_list");
  link(g_dbus_connection_call_with_unix_fd_list_finish, "g_dbus_connection_call_with_unix_fd_list_finish");
  link(g_dbus_connection_call_with_unix_fd_list_sync, "g_dbus_connection_call_with_unix_fd_list_sync");
  link(g_dbus_connection_close, "g_dbus_connection_close");
  link(g_dbus_connection_close_finish, "g_dbus_connection_close_finish");
  link(g_dbus_connection_close_sync, "g_dbus_connection_close_sync");
  link(g_dbus_connection_emit_signal, "g_dbus_connection_emit_signal");
  link(g_dbus_connection_export_action_group, "g_dbus_connection_export_action_group");
  link(g_dbus_connection_export_menu_model, "g_dbus_connection_export_menu_model");
  link(g_dbus_connection_flush, "g_dbus_connection_flush");
  link(g_dbus_connection_flush_finish, "g_dbus_connection_flush_finish");
  link(g_dbus_connection_flush_sync, "g_dbus_connection_flush_sync");
  link(g_dbus_connection_get_capabilities, "g_dbus_connection_get_capabilities");
  link(g_dbus_connection_get_exit_on_close, "g_dbus_connection_get_exit_on_close");
  link(g_dbus_connection_get_flags, "g_dbus_connection_get_flags");
  link(g_dbus_connection_get_guid, "g_dbus_connection_get_guid");
  link(g_dbus_connection_get_last_serial, "g_dbus_connection_get_last_serial");
  link(g_dbus_connection_get_peer_credentials, "g_dbus_connection_get_peer_credentials");
  link(g_dbus_connection_get_stream, "g_dbus_connection_get_stream");
  link(g_dbus_connection_get_unique_name, "g_dbus_connection_get_unique_name");
  link(g_dbus_connection_is_closed, "g_dbus_connection_is_closed");
  link(g_dbus_connection_register_object, "g_dbus_connection_register_object");
  link(g_dbus_connection_register_object_with_closures, "g_dbus_connection_register_object_with_closures");
  link(g_dbus_connection_register_subtree, "g_dbus_connection_register_subtree");
  link(g_dbus_connection_remove_filter, "g_dbus_connection_remove_filter");
  link(g_dbus_connection_send_message, "g_dbus_connection_send_message");
  link(g_dbus_connection_send_message_with_reply, "g_dbus_connection_send_message_with_reply");
  link(g_dbus_connection_send_message_with_reply_finish, "g_dbus_connection_send_message_with_reply_finish");
  link(g_dbus_connection_send_message_with_reply_sync, "g_dbus_connection_send_message_with_reply_sync");
  link(g_dbus_connection_set_exit_on_close, "g_dbus_connection_set_exit_on_close");
  link(g_dbus_connection_signal_subscribe, "g_dbus_connection_signal_subscribe");
  link(g_dbus_connection_signal_unsubscribe, "g_dbus_connection_signal_unsubscribe");
  link(g_dbus_connection_start_message_processing, "g_dbus_connection_start_message_processing");
  link(g_dbus_connection_unexport_action_group, "g_dbus_connection_unexport_action_group");
  link(g_dbus_connection_unexport_menu_model, "g_dbus_connection_unexport_menu_model");
  link(g_dbus_connection_unregister_object, "g_dbus_connection_unregister_object");
  link(g_dbus_connection_unregister_subtree, "g_dbus_connection_unregister_subtree");

  // DBusInterface
  link(g_dbus_interface_get_type, "g_dbus_interface_get_type");
  link(g_dbus_interface_dup_object, "g_dbus_interface_dup_object");
  link(g_dbus_interface_get_info, "g_dbus_interface_get_info");
  link(g_dbus_interface_get_object, "g_dbus_interface_get_object");
  link(g_dbus_interface_set_object, "g_dbus_interface_set_object");

  // DBusInterfaceInfo
  link(g_dbus_interface_info_get_type, "g_dbus_interface_info_get_type");
  link(g_dbus_interface_info_cache_build, "g_dbus_interface_info_cache_build");
  link(g_dbus_interface_info_cache_release, "g_dbus_interface_info_cache_release");
  link(g_dbus_interface_info_generate_xml, "g_dbus_interface_info_generate_xml");
  link(g_dbus_interface_info_lookup_method, "g_dbus_interface_info_lookup_method");
  link(g_dbus_interface_info_lookup_property, "g_dbus_interface_info_lookup_property");
  link(g_dbus_interface_info_lookup_signal, "g_dbus_interface_info_lookup_signal");
  link(g_dbus_interface_info_ref, "g_dbus_interface_info_ref");
  link(g_dbus_interface_info_unref, "g_dbus_interface_info_unref");

  // DBusInterfaceSkeleton
  link(g_dbus_interface_skeleton_get_type, "g_dbus_interface_skeleton_get_type");
  link(g_dbus_interface_skeleton_export, "g_dbus_interface_skeleton_export");
  link(g_dbus_interface_skeleton_flush, "g_dbus_interface_skeleton_flush");
  link(g_dbus_interface_skeleton_get_connection, "g_dbus_interface_skeleton_get_connection");
  link(g_dbus_interface_skeleton_get_connections, "g_dbus_interface_skeleton_get_connections");
  link(g_dbus_interface_skeleton_get_flags, "g_dbus_interface_skeleton_get_flags");
  link(g_dbus_interface_skeleton_get_info, "g_dbus_interface_skeleton_get_info");
  link(g_dbus_interface_skeleton_get_object_path, "g_dbus_interface_skeleton_get_object_path");
  link(g_dbus_interface_skeleton_get_properties, "g_dbus_interface_skeleton_get_properties");
  link(g_dbus_interface_skeleton_get_vtable, "g_dbus_interface_skeleton_get_vtable");
  link(g_dbus_interface_skeleton_has_connection, "g_dbus_interface_skeleton_has_connection");
  link(g_dbus_interface_skeleton_set_flags, "g_dbus_interface_skeleton_set_flags");
  link(g_dbus_interface_skeleton_unexport, "g_dbus_interface_skeleton_unexport");
  link(g_dbus_interface_skeleton_unexport_from_connection, "g_dbus_interface_skeleton_unexport_from_connection");

  // DBusMenuModel
  link(g_dbus_menu_model_get_type, "g_dbus_menu_model_get_type");
  link(g_dbus_menu_model_get, "g_dbus_menu_model_get");

  // DBusMessage
  link(g_dbus_message_get_type, "g_dbus_message_get_type");
  link(g_dbus_message_new, "g_dbus_message_new");
  link(g_dbus_message_new_from_blob, "g_dbus_message_new_from_blob");
  link(g_dbus_message_new_method_call, "g_dbus_message_new_method_call");
  link(g_dbus_message_new_signal, "g_dbus_message_new_signal");
  link(g_dbus_message_bytes_needed, "g_dbus_message_bytes_needed");
  link(g_dbus_message_copy, "g_dbus_message_copy");
  link(g_dbus_message_get_arg0, "g_dbus_message_get_arg0");
  link(g_dbus_message_get_arg0_path, "g_dbus_message_get_arg0_path");
  link(g_dbus_message_get_body, "g_dbus_message_get_body");
  link(g_dbus_message_get_byte_order, "g_dbus_message_get_byte_order");
  link(g_dbus_message_get_destination, "g_dbus_message_get_destination");
  link(g_dbus_message_get_error_name, "g_dbus_message_get_error_name");
  link(g_dbus_message_get_flags, "g_dbus_message_get_flags");
  link(g_dbus_message_get_header, "g_dbus_message_get_header");
  link(g_dbus_message_get_header_fields, "g_dbus_message_get_header_fields");
  link(g_dbus_message_get_interface, "g_dbus_message_get_interface");
  link(g_dbus_message_get_locked, "g_dbus_message_get_locked");
  link(g_dbus_message_get_member, "g_dbus_message_get_member");
  link(g_dbus_message_get_message_type, "g_dbus_message_get_message_type");
  link(g_dbus_message_get_num_unix_fds, "g_dbus_message_get_num_unix_fds");
  link(g_dbus_message_get_path, "g_dbus_message_get_path");
  link(g_dbus_message_get_reply_serial, "g_dbus_message_get_reply_serial");
  link(g_dbus_message_get_sender, "g_dbus_message_get_sender");
  link(g_dbus_message_get_serial, "g_dbus_message_get_serial");
  link(g_dbus_message_get_signature, "g_dbus_message_get_signature");
  link(g_dbus_message_get_unix_fd_list, "g_dbus_message_get_unix_fd_list");
  link(g_dbus_message_lock, "g_dbus_message_lock");
  link(g_dbus_message_new_method_error, "g_dbus_message_new_method_error");
  link(g_dbus_message_new_method_error_literal, "g_dbus_message_new_method_error_literal");
  link(g_dbus_message_new_method_error_valist, "g_dbus_message_new_method_error_valist");
  link(g_dbus_message_new_method_reply, "g_dbus_message_new_method_reply");
  link(g_dbus_message_print, "g_dbus_message_print");
  link(g_dbus_message_set_body, "g_dbus_message_set_body");
  link(g_dbus_message_set_byte_order, "g_dbus_message_set_byte_order");
  link(g_dbus_message_set_destination, "g_dbus_message_set_destination");
  link(g_dbus_message_set_error_name, "g_dbus_message_set_error_name");
  link(g_dbus_message_set_flags, "g_dbus_message_set_flags");
  link(g_dbus_message_set_header, "g_dbus_message_set_header");
  link(g_dbus_message_set_interface, "g_dbus_message_set_interface");
  link(g_dbus_message_set_member, "g_dbus_message_set_member");
  link(g_dbus_message_set_message_type, "g_dbus_message_set_message_type");
  link(g_dbus_message_set_num_unix_fds, "g_dbus_message_set_num_unix_fds");
  link(g_dbus_message_set_path, "g_dbus_message_set_path");
  link(g_dbus_message_set_reply_serial, "g_dbus_message_set_reply_serial");
  link(g_dbus_message_set_sender, "g_dbus_message_set_sender");
  link(g_dbus_message_set_serial, "g_dbus_message_set_serial");
  link(g_dbus_message_set_signature, "g_dbus_message_set_signature");
  link(g_dbus_message_set_unix_fd_list, "g_dbus_message_set_unix_fd_list");
  link(g_dbus_message_to_blob, "g_dbus_message_to_blob");
  link(g_dbus_message_to_gerror, "g_dbus_message_to_gerror");

  // DBusMethodInfo
  link(g_dbus_method_info_get_type, "g_dbus_method_info_get_type");
  link(g_dbus_method_info_ref, "g_dbus_method_info_ref");
  link(g_dbus_method_info_unref, "g_dbus_method_info_unref");

  // DBusMethodInvocation
  link(g_dbus_method_invocation_get_type, "g_dbus_method_invocation_get_type");
  link(g_dbus_method_invocation_get_connection, "g_dbus_method_invocation_get_connection");
  link(g_dbus_method_invocation_get_interface_name, "g_dbus_method_invocation_get_interface_name");
  link(g_dbus_method_invocation_get_message, "g_dbus_method_invocation_get_message");
  link(g_dbus_method_invocation_get_method_info, "g_dbus_method_invocation_get_method_info");
  link(g_dbus_method_invocation_get_method_name, "g_dbus_method_invocation_get_method_name");
  link(g_dbus_method_invocation_get_object_path, "g_dbus_method_invocation_get_object_path");
  link(g_dbus_method_invocation_get_parameters, "g_dbus_method_invocation_get_parameters");
  link(g_dbus_method_invocation_get_property_info, "g_dbus_method_invocation_get_property_info");
  link(g_dbus_method_invocation_get_sender, "g_dbus_method_invocation_get_sender");
  link(g_dbus_method_invocation_get_user_data, "g_dbus_method_invocation_get_user_data");
  link(g_dbus_method_invocation_return_dbus_error, "g_dbus_method_invocation_return_dbus_error");
  link(g_dbus_method_invocation_return_error, "g_dbus_method_invocation_return_error");
  link(g_dbus_method_invocation_return_error_literal, "g_dbus_method_invocation_return_error_literal");
  link(g_dbus_method_invocation_return_error_valist, "g_dbus_method_invocation_return_error_valist");
  link(g_dbus_method_invocation_return_gerror, "g_dbus_method_invocation_return_gerror");
  link(g_dbus_method_invocation_return_value, "g_dbus_method_invocation_return_value");
  link(g_dbus_method_invocation_return_value_with_unix_fd_list, "g_dbus_method_invocation_return_value_with_unix_fd_list");
  link(g_dbus_method_invocation_take_error, "g_dbus_method_invocation_take_error");

  // DBusNodeInfo
  link(g_dbus_node_info_get_type, "g_dbus_node_info_get_type");
  link(g_dbus_node_info_new_for_xml, "g_dbus_node_info_new_for_xml");
  link(g_dbus_node_info_generate_xml, "g_dbus_node_info_generate_xml");
  link(g_dbus_node_info_lookup_interface, "g_dbus_node_info_lookup_interface");
  link(g_dbus_node_info_ref, "g_dbus_node_info_ref");
  link(g_dbus_node_info_unref, "g_dbus_node_info_unref");

  // DBusObject
  link(g_dbus_object_get_type, "g_dbus_object_get_type");
  link(g_dbus_object_get_interface, "g_dbus_object_get_interface");
  link(g_dbus_object_get_interfaces, "g_dbus_object_get_interfaces");
  link(g_dbus_object_get_object_path, "g_dbus_object_get_object_path");

  // DBusObjectManager
  link(g_dbus_object_manager_get_type, "g_dbus_object_manager_get_type");
  link(g_dbus_object_manager_get_interface, "g_dbus_object_manager_get_interface");
  link(g_dbus_object_manager_get_object, "g_dbus_object_manager_get_object");
  link(g_dbus_object_manager_get_object_path, "g_dbus_object_manager_get_object_path");
  link(g_dbus_object_manager_get_objects, "g_dbus_object_manager_get_objects");

  // DBusObjectManagerClient
  link(g_dbus_object_manager_client_get_type, "g_dbus_object_manager_client_get_type");
  link(g_dbus_object_manager_client_new_finish, "g_dbus_object_manager_client_new_finish");
  link(g_dbus_object_manager_client_new_for_bus_finish, "g_dbus_object_manager_client_new_for_bus_finish");
  link(g_dbus_object_manager_client_new_for_bus_sync, "g_dbus_object_manager_client_new_for_bus_sync");
  link(g_dbus_object_manager_client_new_sync, "g_dbus_object_manager_client_new_sync");
  link(g_dbus_object_manager_client_new, "g_dbus_object_manager_client_new");
  link(g_dbus_object_manager_client_new_for_bus, "g_dbus_object_manager_client_new_for_bus");
  link(g_dbus_object_manager_client_get_connection, "g_dbus_object_manager_client_get_connection");
  link(g_dbus_object_manager_client_get_flags, "g_dbus_object_manager_client_get_flags");
  link(g_dbus_object_manager_client_get_name, "g_dbus_object_manager_client_get_name");
  link(g_dbus_object_manager_client_get_name_owner, "g_dbus_object_manager_client_get_name_owner");

  // DBusObjectManagerServer
  link(g_dbus_object_manager_server_get_type, "g_dbus_object_manager_server_get_type");
  link(g_dbus_object_manager_server_new, "g_dbus_object_manager_server_new");
  link(g_dbus_object_manager_server_export, "g_dbus_object_manager_server_export");
  link(g_dbus_object_manager_server_export_uniquely, "g_dbus_object_manager_server_export_uniquely");
  link(g_dbus_object_manager_server_get_connection, "g_dbus_object_manager_server_get_connection");
  link(g_dbus_object_manager_server_is_exported, "g_dbus_object_manager_server_is_exported");
  link(g_dbus_object_manager_server_set_connection, "g_dbus_object_manager_server_set_connection");
  link(g_dbus_object_manager_server_unexport, "g_dbus_object_manager_server_unexport");

  // DBusObjectProxy
  link(g_dbus_object_proxy_get_type, "g_dbus_object_proxy_get_type");
  link(g_dbus_object_proxy_new, "g_dbus_object_proxy_new");
  link(g_dbus_object_proxy_get_connection, "g_dbus_object_proxy_get_connection");

  // DBusObjectSkeleton
  link(g_dbus_object_skeleton_get_type, "g_dbus_object_skeleton_get_type");
  link(g_dbus_object_skeleton_new, "g_dbus_object_skeleton_new");
  link(g_dbus_object_skeleton_add_interface, "g_dbus_object_skeleton_add_interface");
  link(g_dbus_object_skeleton_flush, "g_dbus_object_skeleton_flush");
  link(g_dbus_object_skeleton_remove_interface, "g_dbus_object_skeleton_remove_interface");
  link(g_dbus_object_skeleton_remove_interface_by_name, "g_dbus_object_skeleton_remove_interface_by_name");
  link(g_dbus_object_skeleton_set_object_path, "g_dbus_object_skeleton_set_object_path");

  // DBusPropertyInfo
  link(g_dbus_property_info_get_type, "g_dbus_property_info_get_type");
  link(g_dbus_property_info_ref, "g_dbus_property_info_ref");
  link(g_dbus_property_info_unref, "g_dbus_property_info_unref");

  // DBusProxy
  link(g_dbus_proxy_get_type, "g_dbus_proxy_get_type");
  link(g_dbus_proxy_new_finish, "g_dbus_proxy_new_finish");
  link(g_dbus_proxy_new_for_bus_finish, "g_dbus_proxy_new_for_bus_finish");
  link(g_dbus_proxy_new_for_bus_sync, "g_dbus_proxy_new_for_bus_sync");
  link(g_dbus_proxy_new_sync, "g_dbus_proxy_new_sync");
  link(g_dbus_proxy_new, "g_dbus_proxy_new");
  link(g_dbus_proxy_new_for_bus, "g_dbus_proxy_new_for_bus");
  link(g_dbus_proxy_call, "g_dbus_proxy_call");
  link(g_dbus_proxy_call_finish, "g_dbus_proxy_call_finish");
  link(g_dbus_proxy_call_sync, "g_dbus_proxy_call_sync");
  link(g_dbus_proxy_call_with_unix_fd_list, "g_dbus_proxy_call_with_unix_fd_list");
  link(g_dbus_proxy_call_with_unix_fd_list_finish, "g_dbus_proxy_call_with_unix_fd_list_finish");
  link(g_dbus_proxy_call_with_unix_fd_list_sync, "g_dbus_proxy_call_with_unix_fd_list_sync");
  link(g_dbus_proxy_get_cached_property, "g_dbus_proxy_get_cached_property");
  link(g_dbus_proxy_get_cached_property_names, "g_dbus_proxy_get_cached_property_names");
  link(g_dbus_proxy_get_connection, "g_dbus_proxy_get_connection");
  link(g_dbus_proxy_get_default_timeout, "g_dbus_proxy_get_default_timeout");
  link(g_dbus_proxy_get_flags, "g_dbus_proxy_get_flags");
  link(g_dbus_proxy_get_interface_info, "g_dbus_proxy_get_interface_info");
  link(g_dbus_proxy_get_interface_name, "g_dbus_proxy_get_interface_name");
  link(g_dbus_proxy_get_name, "g_dbus_proxy_get_name");
  link(g_dbus_proxy_get_name_owner, "g_dbus_proxy_get_name_owner");
  link(g_dbus_proxy_get_object_path, "g_dbus_proxy_get_object_path");
  link(g_dbus_proxy_set_cached_property, "g_dbus_proxy_set_cached_property");
  link(g_dbus_proxy_set_default_timeout, "g_dbus_proxy_set_default_timeout");
  link(g_dbus_proxy_set_interface_info, "g_dbus_proxy_set_interface_info");

  // DBusServer
  link(g_dbus_server_get_type, "g_dbus_server_get_type");
  link(g_dbus_server_new_sync, "g_dbus_server_new_sync");
  link(g_dbus_server_get_client_address, "g_dbus_server_get_client_address");
  link(g_dbus_server_get_flags, "g_dbus_server_get_flags");
  link(g_dbus_server_get_guid, "g_dbus_server_get_guid");
  link(g_dbus_server_is_active, "g_dbus_server_is_active");
  link(g_dbus_server_start, "g_dbus_server_start");
  link(g_dbus_server_stop, "g_dbus_server_stop");

  // DBusSignalInfo
  link(g_dbus_signal_info_get_type, "g_dbus_signal_info_get_type");
  link(g_dbus_signal_info_ref, "g_dbus_signal_info_ref");
  link(g_dbus_signal_info_unref, "g_dbus_signal_info_unref");

  // DataInputStream
  link(g_data_input_stream_get_type, "g_data_input_stream_get_type");
  link(g_data_input_stream_new, "g_data_input_stream_new");
  link(g_data_input_stream_get_byte_order, "g_data_input_stream_get_byte_order");
  link(g_data_input_stream_get_newline_type, "g_data_input_stream_get_newline_type");
  link(g_data_input_stream_read_byte, "g_data_input_stream_read_byte");
  link(g_data_input_stream_read_int16, "g_data_input_stream_read_int16");
  link(g_data_input_stream_read_int32, "g_data_input_stream_read_int32");
  link(g_data_input_stream_read_int64, "g_data_input_stream_read_int64");
  link(g_data_input_stream_read_line, "g_data_input_stream_read_line");
  link(g_data_input_stream_read_line_async, "g_data_input_stream_read_line_async");
  link(g_data_input_stream_read_line_finish, "g_data_input_stream_read_line_finish");
  link(g_data_input_stream_read_line_finish_utf8, "g_data_input_stream_read_line_finish_utf8");
  link(g_data_input_stream_read_line_utf8, "g_data_input_stream_read_line_utf8");
  link(g_data_input_stream_read_uint16, "g_data_input_stream_read_uint16");
  link(g_data_input_stream_read_uint32, "g_data_input_stream_read_uint32");
  link(g_data_input_stream_read_uint64, "g_data_input_stream_read_uint64");
  link(g_data_input_stream_read_until, "g_data_input_stream_read_until");
  link(g_data_input_stream_read_until_async, "g_data_input_stream_read_until_async");
  link(g_data_input_stream_read_until_finish, "g_data_input_stream_read_until_finish");
  link(g_data_input_stream_read_upto, "g_data_input_stream_read_upto");
  link(g_data_input_stream_read_upto_async, "g_data_input_stream_read_upto_async");
  link(g_data_input_stream_read_upto_finish, "g_data_input_stream_read_upto_finish");
  link(g_data_input_stream_set_byte_order, "g_data_input_stream_set_byte_order");
  link(g_data_input_stream_set_newline_type, "g_data_input_stream_set_newline_type");

  // DataOutputStream
  link(g_data_output_stream_get_type, "g_data_output_stream_get_type");
  link(g_data_output_stream_new, "g_data_output_stream_new");
  link(g_data_output_stream_get_byte_order, "g_data_output_stream_get_byte_order");
  link(g_data_output_stream_put_byte, "g_data_output_stream_put_byte");
  link(g_data_output_stream_put_int16, "g_data_output_stream_put_int16");
  link(g_data_output_stream_put_int32, "g_data_output_stream_put_int32");
  link(g_data_output_stream_put_int64, "g_data_output_stream_put_int64");
  link(g_data_output_stream_put_string, "g_data_output_stream_put_string");
  link(g_data_output_stream_put_uint16, "g_data_output_stream_put_uint16");
  link(g_data_output_stream_put_uint32, "g_data_output_stream_put_uint32");
  link(g_data_output_stream_put_uint64, "g_data_output_stream_put_uint64");
  link(g_data_output_stream_set_byte_order, "g_data_output_stream_set_byte_order");

  // DatagramBased
  link(g_datagram_based_get_type, "g_datagram_based_get_type");
  link(g_datagram_based_condition_check, "g_datagram_based_condition_check");
  link(g_datagram_based_condition_wait, "g_datagram_based_condition_wait");
  link(g_datagram_based_create_source, "g_datagram_based_create_source");
  link(g_datagram_based_receive_messages, "g_datagram_based_receive_messages");
  link(g_datagram_based_send_messages, "g_datagram_based_send_messages");

  // DebugController
  link(g_debug_controller_get_type, "g_debug_controller_get_type");
  link(g_debug_controller_get_debug_enabled, "g_debug_controller_get_debug_enabled");
  link(g_debug_controller_set_debug_enabled, "g_debug_controller_set_debug_enabled");

  // DebugControllerDBus
  link(g_debug_controller_dbus_get_type, "g_debug_controller_dbus_get_type");
  link(g_debug_controller_dbus_new, "g_debug_controller_dbus_new");
  link(g_debug_controller_dbus_stop, "g_debug_controller_dbus_stop");

  // DesktopAppInfo
  link(g_desktop_app_info_get_type, "g_desktop_app_info_get_type");
  link(g_desktop_app_info_new, "g_desktop_app_info_new");
  link(g_desktop_app_info_new_from_filename, "g_desktop_app_info_new_from_filename");
  link(g_desktop_app_info_new_from_keyfile, "g_desktop_app_info_new_from_keyfile");
  link(g_desktop_app_info_get_implementations, "g_desktop_app_info_get_implementations");
  link(g_desktop_app_info_search, "g_desktop_app_info_search");
  link(g_desktop_app_info_set_desktop_env, "g_desktop_app_info_set_desktop_env");
  link(g_desktop_app_info_get_action_name, "g_desktop_app_info_get_action_name");
  link(g_desktop_app_info_get_boolean, "g_desktop_app_info_get_boolean");
  link(g_desktop_app_info_get_categories, "g_desktop_app_info_get_categories");
  link(g_desktop_app_info_get_filename, "g_desktop_app_info_get_filename");
  link(g_desktop_app_info_get_generic_name, "g_desktop_app_info_get_generic_name");
  link(g_desktop_app_info_get_is_hidden, "g_desktop_app_info_get_is_hidden");
  link(g_desktop_app_info_get_keywords, "g_desktop_app_info_get_keywords");
  link(g_desktop_app_info_get_locale_string, "g_desktop_app_info_get_locale_string");
  link(g_desktop_app_info_get_nodisplay, "g_desktop_app_info_get_nodisplay");
  link(g_desktop_app_info_get_show_in, "g_desktop_app_info_get_show_in");
  link(g_desktop_app_info_get_startup_wm_class, "g_desktop_app_info_get_startup_wm_class");
  link(g_desktop_app_info_get_string, "g_desktop_app_info_get_string");
  link(g_desktop_app_info_get_string_list, "g_desktop_app_info_get_string_list");
  link(g_desktop_app_info_has_key, "g_desktop_app_info_has_key");
  link(g_desktop_app_info_launch_action, "g_desktop_app_info_launch_action");
  link(g_desktop_app_info_launch_uris_as_manager, "g_desktop_app_info_launch_uris_as_manager");
  link(g_desktop_app_info_launch_uris_as_manager_with_fds, "g_desktop_app_info_launch_uris_as_manager_with_fds");
  link(g_desktop_app_info_list_actions, "g_desktop_app_info_list_actions");

  // DesktopAppInfoLookup
  link(g_desktop_app_info_lookup_get_type, "g_desktop_app_info_lookup_get_type");
  link(g_desktop_app_info_lookup_get_default_for_uri_scheme, "g_desktop_app_info_lookup_get_default_for_uri_scheme");

  // Drive
  link(g_drive_get_type, "g_drive_get_type");
  link(g_drive_can_eject, "g_drive_can_eject");
  link(g_drive_can_poll_for_media, "g_drive_can_poll_for_media");
  link(g_drive_can_start, "g_drive_can_start");
  link(g_drive_can_start_degraded, "g_drive_can_start_degraded");
  link(g_drive_can_stop, "g_drive_can_stop");
  link(g_drive_eject, "g_drive_eject");
  link(g_drive_eject_finish, "g_drive_eject_finish");
  link(g_drive_eject_with_operation, "g_drive_eject_with_operation");
  link(g_drive_eject_with_operation_finish, "g_drive_eject_with_operation_finish");
  link(g_drive_enumerate_identifiers, "g_drive_enumerate_identifiers");
  link(g_drive_get_icon, "g_drive_get_icon");
  link(g_drive_get_identifier, "g_drive_get_identifier");
  link(g_drive_get_name, "g_drive_get_name");
  link(g_drive_get_sort_key, "g_drive_get_sort_key");
  link(g_drive_get_start_stop_type, "g_drive_get_start_stop_type");
  link(g_drive_get_symbolic_icon, "g_drive_get_symbolic_icon");
  link(g_drive_get_volumes, "g_drive_get_volumes");
  link(g_drive_has_media, "g_drive_has_media");
  link(g_drive_has_volumes, "g_drive_has_volumes");
  link(g_drive_is_media_check_automatic, "g_drive_is_media_check_automatic");
  link(g_drive_is_media_removable, "g_drive_is_media_removable");
  link(g_drive_is_removable, "g_drive_is_removable");
  link(g_drive_poll_for_media, "g_drive_poll_for_media");
  link(g_drive_poll_for_media_finish, "g_drive_poll_for_media_finish");
  link(g_drive_start, "g_drive_start");
  link(g_drive_start_finish, "g_drive_start_finish");
  link(g_drive_stop, "g_drive_stop");
  link(g_drive_stop_finish, "g_drive_stop_finish");

  // DtlsClientConnection
  link(g_dtls_client_connection_get_type, "g_dtls_client_connection_get_type");
  link(g_dtls_client_connection_new, "g_dtls_client_connection_new");
  link(g_dtls_client_connection_get_accepted_cas, "g_dtls_client_connection_get_accepted_cas");
  link(g_dtls_client_connection_get_server_identity, "g_dtls_client_connection_get_server_identity");
  link(g_dtls_client_connection_get_validation_flags, "g_dtls_client_connection_get_validation_flags");
  link(g_dtls_client_connection_set_server_identity, "g_dtls_client_connection_set_server_identity");
  link(g_dtls_client_connection_set_validation_flags, "g_dtls_client_connection_set_validation_flags");

  // DtlsConnection
  link(g_dtls_connection_get_type, "g_dtls_connection_get_type");
  link(g_dtls_connection_close, "g_dtls_connection_close");
  link(g_dtls_connection_close_async, "g_dtls_connection_close_async");
  link(g_dtls_connection_close_finish, "g_dtls_connection_close_finish");
  link(g_dtls_connection_emit_accept_certificate, "g_dtls_connection_emit_accept_certificate");
  link(g_dtls_connection_get_certificate, "g_dtls_connection_get_certificate");
  link(g_dtls_connection_get_channel_binding_data, "g_dtls_connection_get_channel_binding_data");
  link(g_dtls_connection_get_ciphersuite_name, "g_dtls_connection_get_ciphersuite_name");
  link(g_dtls_connection_get_database, "g_dtls_connection_get_database");
  link(g_dtls_connection_get_interaction, "g_dtls_connection_get_interaction");
  link(g_dtls_connection_get_negotiated_protocol, "g_dtls_connection_get_negotiated_protocol");
  link(g_dtls_connection_get_peer_certificate, "g_dtls_connection_get_peer_certificate");
  link(g_dtls_connection_get_peer_certificate_errors, "g_dtls_connection_get_peer_certificate_errors");
  link(g_dtls_connection_get_protocol_version, "g_dtls_connection_get_protocol_version");
  link(g_dtls_connection_get_rehandshake_mode, "g_dtls_connection_get_rehandshake_mode");
  link(g_dtls_connection_get_require_close_notify, "g_dtls_connection_get_require_close_notify");
  link(g_dtls_connection_handshake, "g_dtls_connection_handshake");
  link(g_dtls_connection_handshake_async, "g_dtls_connection_handshake_async");
  link(g_dtls_connection_handshake_finish, "g_dtls_connection_handshake_finish");
  link(g_dtls_connection_set_advertised_protocols, "g_dtls_connection_set_advertised_protocols");
  link(g_dtls_connection_set_certificate, "g_dtls_connection_set_certificate");
  link(g_dtls_connection_set_database, "g_dtls_connection_set_database");
  link(g_dtls_connection_set_interaction, "g_dtls_connection_set_interaction");
  link(g_dtls_connection_set_rehandshake_mode, "g_dtls_connection_set_rehandshake_mode");
  link(g_dtls_connection_set_require_close_notify, "g_dtls_connection_set_require_close_notify");
  link(g_dtls_connection_shutdown, "g_dtls_connection_shutdown");
  link(g_dtls_connection_shutdown_async, "g_dtls_connection_shutdown_async");
  link(g_dtls_connection_shutdown_finish, "g_dtls_connection_shutdown_finish");

  // DtlsServerConnection
  link(g_dtls_server_connection_get_type, "g_dtls_server_connection_get_type");
  link(g_dtls_server_connection_new, "g_dtls_server_connection_new");

  // Emblem
  link(g_emblem_get_type, "g_emblem_get_type");
  link(g_emblem_new, "g_emblem_new");
  link(g_emblem_new_with_origin, "g_emblem_new_with_origin");
  link(g_emblem_get_icon, "g_emblem_get_icon");
  link(g_emblem_get_origin, "g_emblem_get_origin");

  // EmblemedIcon
  link(g_emblemed_icon_get_type, "g_emblemed_icon_get_type");
  link(g_emblemed_icon_new, "g_emblemed_icon_new");
  link(g_emblemed_icon_add_emblem, "g_emblemed_icon_add_emblem");
  link(g_emblemed_icon_clear_emblems, "g_emblemed_icon_clear_emblems");
  link(g_emblemed_icon_get_emblems, "g_emblemed_icon_get_emblems");
  link(g_emblemed_icon_get_icon, "g_emblemed_icon_get_icon");

  // File
  link(g_file_get_type, "g_file_get_type");
  link(g_file_new_build_filename, "g_file_new_build_filename");
  link(g_file_new_build_filenamev, "g_file_new_build_filenamev");
  link(g_file_new_for_commandline_arg, "g_file_new_for_commandline_arg");
  link(g_file_new_for_commandline_arg_and_cwd, "g_file_new_for_commandline_arg_and_cwd");
  link(g_file_new_for_path, "g_file_new_for_path");
  link(g_file_new_for_uri, "g_file_new_for_uri");
  link(g_file_new_tmp, "g_file_new_tmp");
  link(g_file_new_tmp_async, "g_file_new_tmp_async");
  link(g_file_new_tmp_dir_async, "g_file_new_tmp_dir_async");
  link(g_file_new_tmp_dir_finish, "g_file_new_tmp_dir_finish");
  link(g_file_new_tmp_finish, "g_file_new_tmp_finish");
  link(g_file_parse_name, "g_file_parse_name");
  link(g_file_append_to, "g_file_append_to");
  link(g_file_append_to_async, "g_file_append_to_async");
  link(g_file_append_to_finish, "g_file_append_to_finish");
  link(g_file_build_attribute_list_for_copy, "g_file_build_attribute_list_for_copy");
  link(g_file_copy, "g_file_copy");
  link(g_file_copy_async, "g_file_copy_async");
  link(g_file_copy_attributes, "g_file_copy_attributes");
  link(g_file_copy_finish, "g_file_copy_finish");
  link(g_file_create, "g_file_create");
  link(g_file_create_async, "g_file_create_async");
  link(g_file_create_finish, "g_file_create_finish");
  link(g_file_create_readwrite, "g_file_create_readwrite");
  link(g_file_create_readwrite_async, "g_file_create_readwrite_async");
  link(g_file_create_readwrite_finish, "g_file_create_readwrite_finish");
  link(g_file_delete, "g_file_delete");
  link(g_file_delete_async, "g_file_delete_async");
  link(g_file_delete_finish, "g_file_delete_finish");
  link(g_file_dup, "g_file_dup");
  link(g_file_eject_mountable, "g_file_eject_mountable");
  link(g_file_eject_mountable_finish, "g_file_eject_mountable_finish");
  link(g_file_eject_mountable_with_operation, "g_file_eject_mountable_with_operation");
  link(g_file_eject_mountable_with_operation_finish, "g_file_eject_mountable_with_operation_finish");
  link(g_file_enumerate_children, "g_file_enumerate_children");
  link(g_file_enumerate_children_async, "g_file_enumerate_children_async");
  link(g_file_enumerate_children_finish, "g_file_enumerate_children_finish");
  link(g_file_equal, "g_file_equal");
  link(g_file_find_enclosing_mount, "g_file_find_enclosing_mount");
  link(g_file_find_enclosing_mount_async, "g_file_find_enclosing_mount_async");
  link(g_file_find_enclosing_mount_finish, "g_file_find_enclosing_mount_finish");
  link(g_file_get_basename, "g_file_get_basename");
  link(g_file_get_child, "g_file_get_child");
  link(g_file_get_child_for_display_name, "g_file_get_child_for_display_name");
  link(g_file_get_parent, "g_file_get_parent");
  link(g_file_get_parse_name, "g_file_get_parse_name");
  link(g_file_get_path, "g_file_get_path");
  link(g_file_get_relative_path, "g_file_get_relative_path");
  link(g_file_get_uri, "g_file_get_uri");
  link(g_file_get_uri_scheme, "g_file_get_uri_scheme");
  link(g_file_has_parent, "g_file_has_parent");
  link(g_file_has_prefix, "g_file_has_prefix");
  link(g_file_has_uri_scheme, "g_file_has_uri_scheme");
  link(g_file_hash, "g_file_hash");
  link(g_file_is_native, "g_file_is_native");
  link(g_file_load_bytes, "g_file_load_bytes");
  link(g_file_load_bytes_async, "g_file_load_bytes_async");
  link(g_file_load_bytes_finish, "g_file_load_bytes_finish");
  link(g_file_load_contents, "g_file_load_contents");
  link(g_file_load_contents_async, "g_file_load_contents_async");
  link(g_file_load_contents_finish, "g_file_load_contents_finish");
  link(g_file_load_partial_contents_async, "g_file_load_partial_contents_async");
  link(g_file_load_partial_contents_finish, "g_file_load_partial_contents_finish");
  link(g_file_make_directory, "g_file_make_directory");
  link(g_file_make_directory_async, "g_file_make_directory_async");
  link(g_file_make_directory_finish, "g_file_make_directory_finish");
  link(g_file_make_directory_with_parents, "g_file_make_directory_with_parents");
  link(g_file_make_symbolic_link, "g_file_make_symbolic_link");
  link(g_file_make_symbolic_link_async, "g_file_make_symbolic_link_async");
  link(g_file_make_symbolic_link_finish, "g_file_make_symbolic_link_finish");
  link(g_file_measure_disk_usage, "g_file_measure_disk_usage");
  link(g_file_measure_disk_usage_async, "g_file_measure_disk_usage_async");
  link(g_file_measure_disk_usage_finish, "g_file_measure_disk_usage_finish");
  link(g_file_monitor, "g_file_monitor");
  link(g_file_monitor_directory, "g_file_monitor_directory");
  link(g_file_monitor_file, "g_file_monitor_file");
  link(g_file_mount_enclosing_volume, "g_file_mount_enclosing_volume");
  link(g_file_mount_enclosing_volume_finish, "g_file_mount_enclosing_volume_finish");
  link(g_file_mount_mountable, "g_file_mount_mountable");
  link(g_file_mount_mountable_finish, "g_file_mount_mountable_finish");
  link(g_file_move, "g_file_move");
  link(g_file_move_async, "g_file_move_async");
  link(g_file_move_finish, "g_file_move_finish");
  link(g_file_open_readwrite, "g_file_open_readwrite");
  link(g_file_open_readwrite_async, "g_file_open_readwrite_async");
  link(g_file_open_readwrite_finish, "g_file_open_readwrite_finish");
  link(g_file_peek_path, "g_file_peek_path");
  link(g_file_poll_mountable, "g_file_poll_mountable");
  link(g_file_poll_mountable_finish, "g_file_poll_mountable_finish");
  link(g_file_query_default_handler, "g_file_query_default_handler");
  link(g_file_query_default_handler_async, "g_file_query_default_handler_async");
  link(g_file_query_default_handler_finish, "g_file_query_default_handler_finish");
  link(g_file_query_exists, "g_file_query_exists");
  link(g_file_query_file_type, "g_file_query_file_type");
  link(g_file_query_filesystem_info, "g_file_query_filesystem_info");
  link(g_file_query_filesystem_info_async, "g_file_query_filesystem_info_async");
  link(g_file_query_filesystem_info_finish, "g_file_query_filesystem_info_finish");
  link(g_file_query_info, "g_file_query_info");
  link(g_file_query_info_async, "g_file_query_info_async");
  link(g_file_query_info_finish, "g_file_query_info_finish");
  link(g_file_query_settable_attributes, "g_file_query_settable_attributes");
  link(g_file_query_writable_namespaces, "g_file_query_writable_namespaces");
  link(g_file_read, "g_file_read");
  link(g_file_read_async, "g_file_read_async");
  link(g_file_read_finish, "g_file_read_finish");
  link(g_file_replace, "g_file_replace");
  link(g_file_replace_async, "g_file_replace_async");
  link(g_file_replace_contents, "g_file_replace_contents");
  link(g_file_replace_contents_async, "g_file_replace_contents_async");
  link(g_file_replace_contents_bytes_async, "g_file_replace_contents_bytes_async");
  link(g_file_replace_contents_finish, "g_file_replace_contents_finish");
  link(g_file_replace_finish, "g_file_replace_finish");
  link(g_file_replace_readwrite, "g_file_replace_readwrite");
  link(g_file_replace_readwrite_async, "g_file_replace_readwrite_async");
  link(g_file_replace_readwrite_finish, "g_file_replace_readwrite_finish");
  link(g_file_resolve_relative_path, "g_file_resolve_relative_path");
  link(g_file_set_attribute, "g_file_set_attribute");
  link(g_file_set_attribute_byte_string, "g_file_set_attribute_byte_string");
  link(g_file_set_attribute_int32, "g_file_set_attribute_int32");
  link(g_file_set_attribute_int64, "g_file_set_attribute_int64");
  link(g_file_set_attribute_string, "g_file_set_attribute_string");
  link(g_file_set_attribute_uint32, "g_file_set_attribute_uint32");
  link(g_file_set_attribute_uint64, "g_file_set_attribute_uint64");
  link(g_file_set_attributes_async, "g_file_set_attributes_async");
  link(g_file_set_attributes_finish, "g_file_set_attributes_finish");
  link(g_file_set_attributes_from_info, "g_file_set_attributes_from_info");
  link(g_file_set_display_name, "g_file_set_display_name");
  link(g_file_set_display_name_async, "g_file_set_display_name_async");
  link(g_file_set_display_name_finish, "g_file_set_display_name_finish");
  link(g_file_start_mountable, "g_file_start_mountable");
  link(g_file_start_mountable_finish, "g_file_start_mountable_finish");
  link(g_file_stop_mountable, "g_file_stop_mountable");
  link(g_file_stop_mountable_finish, "g_file_stop_mountable_finish");
  link(g_file_supports_thread_contexts, "g_file_supports_thread_contexts");
  link(g_file_trash, "g_file_trash");
  link(g_file_trash_async, "g_file_trash_async");
  link(g_file_trash_finish, "g_file_trash_finish");
  link(g_file_unmount_mountable, "g_file_unmount_mountable");
  link(g_file_unmount_mountable_finish, "g_file_unmount_mountable_finish");
  link(g_file_unmount_mountable_with_operation, "g_file_unmount_mountable_with_operation");
  link(g_file_unmount_mountable_with_operation_finish, "g_file_unmount_mountable_with_operation_finish");

  // FileAttributeInfoList
  link(g_file_attribute_info_list_get_type, "g_file_attribute_info_list_get_type");
  link(g_file_attribute_info_list_new, "g_file_attribute_info_list_new");
  link(g_file_attribute_info_list_add, "g_file_attribute_info_list_add");
  link(g_file_attribute_info_list_dup, "g_file_attribute_info_list_dup");
  link(g_file_attribute_info_list_lookup, "g_file_attribute_info_list_lookup");
  link(g_file_attribute_info_list_ref, "g_file_attribute_info_list_ref");
  link(g_file_attribute_info_list_unref, "g_file_attribute_info_list_unref");

  // FileAttributeMatcher
  link(g_file_attribute_matcher_get_type, "g_file_attribute_matcher_get_type");
  link(g_file_attribute_matcher_new, "g_file_attribute_matcher_new");
  link(g_file_attribute_matcher_enumerate_namespace, "g_file_attribute_matcher_enumerate_namespace");
  link(g_file_attribute_matcher_enumerate_next, "g_file_attribute_matcher_enumerate_next");
  link(g_file_attribute_matcher_matches, "g_file_attribute_matcher_matches");
  link(g_file_attribute_matcher_matches_only, "g_file_attribute_matcher_matches_only");
  link(g_file_attribute_matcher_ref, "g_file_attribute_matcher_ref");
  link(g_file_attribute_matcher_subtract, "g_file_attribute_matcher_subtract");
  link(g_file_attribute_matcher_to_string, "g_file_attribute_matcher_to_string");
  link(g_file_attribute_matcher_unref, "g_file_attribute_matcher_unref");

  // FileDescriptorBased
  link(g_file_descriptor_based_get_type, "g_file_descriptor_based_get_type");
  link(g_file_descriptor_based_get_fd, "g_file_descriptor_based_get_fd");

  // FileEnumerator
  link(g_file_enumerator_get_type, "g_file_enumerator_get_type");
  link(g_file_enumerator_close, "g_file_enumerator_close");
  link(g_file_enumerator_close_async, "g_file_enumerator_close_async");
  link(g_file_enumerator_close_finish, "g_file_enumerator_close_finish");
  link(g_file_enumerator_get_child, "g_file_enumerator_get_child");
  link(g_file_enumerator_get_container, "g_file_enumerator_get_container");
  link(g_file_enumerator_has_pending, "g_file_enumerator_has_pending");
  link(g_file_enumerator_is_closed, "g_file_enumerator_is_closed");
  link(g_file_enumerator_iterate, "g_file_enumerator_iterate");
  link(g_file_enumerator_next_file, "g_file_enumerator_next_file");
  link(g_file_enumerator_next_files_async, "g_file_enumerator_next_files_async");
  link(g_file_enumerator_next_files_finish, "g_file_enumerator_next_files_finish");
  link(g_file_enumerator_set_pending, "g_file_enumerator_set_pending");

  // FileIOStream
  link(g_file_io_stream_get_type, "g_file_io_stream_get_type");
  link(g_file_io_stream_get_etag, "g_file_io_stream_get_etag");
  link(g_file_io_stream_query_info, "g_file_io_stream_query_info");
  link(g_file_io_stream_query_info_async, "g_file_io_stream_query_info_async");
  link(g_file_io_stream_query_info_finish, "g_file_io_stream_query_info_finish");

  // FileIcon
  link(g_file_icon_get_type, "g_file_icon_get_type");
  link(g_file_icon_new, "g_file_icon_new");
  link(g_file_icon_get_file, "g_file_icon_get_file");

  // FileInfo
  link(g_file_info_get_type, "g_file_info_get_type");
  link(g_file_info_new, "g_file_info_new");
  link(g_file_info_clear_status, "g_file_info_clear_status");
  link(g_file_info_copy_into, "g_file_info_copy_into");
  link(g_file_info_dup, "g_file_info_dup");
  link(g_file_info_get_access_date_time, "g_file_info_get_access_date_time");
  link(g_file_info_get_attribute_as_string, "g_file_info_get_attribute_as_string");
  link(g_file_info_get_attribute_boolean, "g_file_info_get_attribute_boolean");
  link(g_file_info_get_attribute_byte_string, "g_file_info_get_attribute_byte_string");
  link(g_file_info_get_attribute_data, "g_file_info_get_attribute_data");
  link(g_file_info_get_attribute_file_path, "g_file_info_get_attribute_file_path");
  link(g_file_info_get_attribute_int32, "g_file_info_get_attribute_int32");
  link(g_file_info_get_attribute_int64, "g_file_info_get_attribute_int64");
  link(g_file_info_get_attribute_object, "g_file_info_get_attribute_object");
  link(g_file_info_get_attribute_status, "g_file_info_get_attribute_status");
  link(g_file_info_get_attribute_string, "g_file_info_get_attribute_string");
  link(g_file_info_get_attribute_stringv, "g_file_info_get_attribute_stringv");
  link(g_file_info_get_attribute_type, "g_file_info_get_attribute_type");
  link(g_file_info_get_attribute_uint32, "g_file_info_get_attribute_uint32");
  link(g_file_info_get_attribute_uint64, "g_file_info_get_attribute_uint64");
  link(g_file_info_get_content_type, "g_file_info_get_content_type");
  link(g_file_info_get_creation_date_time, "g_file_info_get_creation_date_time");
  link(g_file_info_get_deletion_date, "g_file_info_get_deletion_date");
  link(g_file_info_get_display_name, "g_file_info_get_display_name");
  link(g_file_info_get_edit_name, "g_file_info_get_edit_name");
  link(g_file_info_get_etag, "g_file_info_get_etag");
  link(g_file_info_get_file_type, "g_file_info_get_file_type");
  link(g_file_info_get_icon, "g_file_info_get_icon");
  link(g_file_info_get_is_backup, "g_file_info_get_is_backup");
  link(g_file_info_get_is_hidden, "g_file_info_get_is_hidden");
  link(g_file_info_get_is_symlink, "g_file_info_get_is_symlink");
  link(g_file_info_get_modification_date_time, "g_file_info_get_modification_date_time");
  link(g_file_info_get_modification_time, "g_file_info_get_modification_time");
  link(g_file_info_get_name, "g_file_info_get_name");
  link(g_file_info_get_size, "g_file_info_get_size");
  link(g_file_info_get_sort_order, "g_file_info_get_sort_order");
  link(g_file_info_get_symbolic_icon, "g_file_info_get_symbolic_icon");
  link(g_file_info_get_symlink_target, "g_file_info_get_symlink_target");
  link(g_file_info_has_attribute, "g_file_info_has_attribute");
  link(g_file_info_has_namespace, "g_file_info_has_namespace");
  link(g_file_info_list_attributes, "g_file_info_list_attributes");
  link(g_file_info_remove_attribute, "g_file_info_remove_attribute");
  link(g_file_info_set_access_date_time, "g_file_info_set_access_date_time");
  link(g_file_info_set_attribute, "g_file_info_set_attribute");
  link(g_file_info_set_attribute_boolean, "g_file_info_set_attribute_boolean");
  link(g_file_info_set_attribute_byte_string, "g_file_info_set_attribute_byte_string");
  link(g_file_info_set_attribute_file_path, "g_file_info_set_attribute_file_path");
  link(g_file_info_set_attribute_int32, "g_file_info_set_attribute_int32");
  link(g_file_info_set_attribute_int64, "g_file_info_set_attribute_int64");
  link(g_file_info_set_attribute_mask, "g_file_info_set_attribute_mask");
  link(g_file_info_set_attribute_object, "g_file_info_set_attribute_object");
  link(g_file_info_set_attribute_status, "g_file_info_set_attribute_status");
  link(g_file_info_set_attribute_string, "g_file_info_set_attribute_string");
  link(g_file_info_set_attribute_stringv, "g_file_info_set_attribute_stringv");
  link(g_file_info_set_attribute_uint32, "g_file_info_set_attribute_uint32");
  link(g_file_info_set_attribute_uint64, "g_file_info_set_attribute_uint64");
  link(g_file_info_set_content_type, "g_file_info_set_content_type");
  link(g_file_info_set_creation_date_time, "g_file_info_set_creation_date_time");
  link(g_file_info_set_display_name, "g_file_info_set_display_name");
  link(g_file_info_set_edit_name, "g_file_info_set_edit_name");
  link(g_file_info_set_file_type, "g_file_info_set_file_type");
  link(g_file_info_set_icon, "g_file_info_set_icon");
  link(g_file_info_set_is_hidden, "g_file_info_set_is_hidden");
  link(g_file_info_set_is_symlink, "g_file_info_set_is_symlink");
  link(g_file_info_set_modification_date_time, "g_file_info_set_modification_date_time");
  link(g_file_info_set_modification_time, "g_file_info_set_modification_time");
  link(g_file_info_set_name, "g_file_info_set_name");
  link(g_file_info_set_size, "g_file_info_set_size");
  link(g_file_info_set_sort_order, "g_file_info_set_sort_order");
  link(g_file_info_set_symbolic_icon, "g_file_info_set_symbolic_icon");
  link(g_file_info_set_symlink_target, "g_file_info_set_symlink_target");
  link(g_file_info_unset_attribute_mask, "g_file_info_unset_attribute_mask");

  // FileInputStream
  link(g_file_input_stream_get_type, "g_file_input_stream_get_type");
  link(g_file_input_stream_query_info, "g_file_input_stream_query_info");
  link(g_file_input_stream_query_info_async, "g_file_input_stream_query_info_async");
  link(g_file_input_stream_query_info_finish, "g_file_input_stream_query_info_finish");

  // FileMonitor
  link(g_file_monitor_get_type, "g_file_monitor_get_type");
  link(g_file_monitor_cancel, "g_file_monitor_cancel");
  link(g_file_monitor_emit_event, "g_file_monitor_emit_event");
  link(g_file_monitor_is_cancelled, "g_file_monitor_is_cancelled");
  link(g_file_monitor_set_rate_limit, "g_file_monitor_set_rate_limit");

  // FileOutputStream
  link(g_file_output_stream_get_type, "g_file_output_stream_get_type");
  link(g_file_output_stream_get_etag, "g_file_output_stream_get_etag");
  link(g_file_output_stream_query_info, "g_file_output_stream_query_info");
  link(g_file_output_stream_query_info_async, "g_file_output_stream_query_info_async");
  link(g_file_output_stream_query_info_finish, "g_file_output_stream_query_info_finish");

  // FilenameCompleter
  link(g_filename_completer_get_type, "g_filename_completer_get_type");
  link(g_filename_completer_new, "g_filename_completer_new");
  link(g_filename_completer_get_completion_suffix, "g_filename_completer_get_completion_suffix");
  link(g_filename_completer_get_completions, "g_filename_completer_get_completions");
  link(g_filename_completer_set_dirs_only, "g_filename_completer_set_dirs_only");

  // FilterInputStream
  link(g_filter_input_stream_get_type, "g_filter_input_stream_get_type");
  link(g_filter_input_stream_get_base_stream, "g_filter_input_stream_get_base_stream");
  link(g_filter_input_stream_get_close_base_stream, "g_filter_input_stream_get_close_base_stream");
  link(g_filter_input_stream_set_close_base_stream, "g_filter_input_stream_set_close_base_stream");

  // FilterOutputStream
  link(g_filter_output_stream_get_type, "g_filter_output_stream_get_type");
  link(g_filter_output_stream_get_base_stream, "g_filter_output_stream_get_base_stream");
  link(g_filter_output_stream_get_close_base_stream, "g_filter_output_stream_get_close_base_stream");
  link(g_filter_output_stream_set_close_base_stream, "g_filter_output_stream_set_close_base_stream");

  // Global
  link(g_bus_get, "g_bus_get");
  link(g_bus_get_finish, "g_bus_get_finish");
  link(g_bus_get_sync, "g_bus_get_sync");
  link(g_bus_own_name, "g_bus_own_name");
  link(g_bus_own_name_on_connection, "g_bus_own_name_on_connection");
  link(g_bus_own_name_on_connection_with_closures, "g_bus_own_name_on_connection_with_closures");
  link(g_bus_own_name_with_closures, "g_bus_own_name_with_closures");
  link(g_bus_unown_name, "g_bus_unown_name");
  link(g_bus_unwatch_name, "g_bus_unwatch_name");
  link(g_bus_watch_name, "g_bus_watch_name");
  link(g_bus_watch_name_on_connection, "g_bus_watch_name_on_connection");
  link(g_bus_watch_name_on_connection_with_closures, "g_bus_watch_name_on_connection_with_closures");
  link(g_bus_watch_name_with_closures, "g_bus_watch_name_with_closures");
  link(g_content_type_can_be_executable, "g_content_type_can_be_executable");
  link(g_content_type_equals, "g_content_type_equals");
  link(g_content_type_from_mime_type, "g_content_type_from_mime_type");
  link(g_content_type_get_description, "g_content_type_get_description");
  link(g_content_type_get_generic_icon_name, "g_content_type_get_generic_icon_name");
  link(g_content_type_get_icon, "g_content_type_get_icon");
  link(g_content_type_get_mime_dirs, "g_content_type_get_mime_dirs");
  link(g_content_type_get_mime_type, "g_content_type_get_mime_type");
  link(g_content_type_get_symbolic_icon, "g_content_type_get_symbolic_icon");
  link(g_content_type_guess, "g_content_type_guess");
  link(g_content_type_guess_for_tree, "g_content_type_guess_for_tree");
  link(g_content_type_is_a, "g_content_type_is_a");
  link(g_content_type_is_mime_type, "g_content_type_is_mime_type");
  link(g_content_type_is_unknown, "g_content_type_is_unknown");
  link(g_content_type_set_mime_dirs, "g_content_type_set_mime_dirs");
  link(g_content_types_get_registered, "g_content_types_get_registered");
  link(g_dbus_address_escape_value, "g_dbus_address_escape_value");
  link(g_dbus_address_get_for_bus_sync, "g_dbus_address_get_for_bus_sync");
  link(g_dbus_address_get_stream, "g_dbus_address_get_stream");
  link(g_dbus_address_get_stream_finish, "g_dbus_address_get_stream_finish");
  link(g_dbus_address_get_stream_sync, "g_dbus_address_get_stream_sync");
  link(g_dbus_escape_object_path, "g_dbus_escape_object_path");
  link(g_dbus_escape_object_path_bytestring, "g_dbus_escape_object_path_bytestring");
  link(g_dbus_generate_guid, "g_dbus_generate_guid");
  link(g_dbus_gvalue_to_gvariant, "g_dbus_gvalue_to_gvariant");
  link(g_dbus_gvariant_to_gvalue, "g_dbus_gvariant_to_gvalue");
  link(g_dbus_is_address, "g_dbus_is_address");
  link(g_dbus_is_error_name, "g_dbus_is_error_name");
  link(g_dbus_is_guid, "g_dbus_is_guid");
  link(g_dbus_is_interface_name, "g_dbus_is_interface_name");
  link(g_dbus_is_member_name, "g_dbus_is_member_name");
  link(g_dbus_is_name, "g_dbus_is_name");
  link(g_dbus_is_supported_address, "g_dbus_is_supported_address");
  link(g_dbus_is_unique_name, "g_dbus_is_unique_name");
  link(g_dbus_unescape_object_path, "g_dbus_unescape_object_path");
  link(g_io_error_from_errno, "g_io_error_from_errno");
  link(g_io_error_from_file_error, "g_io_error_from_file_error");
  link(g_io_error_quark, "g_io_error_quark");
  link(g_io_modules_load_all_in_directory, "g_io_modules_load_all_in_directory");
  link(g_io_modules_load_all_in_directory_with_scope, "g_io_modules_load_all_in_directory_with_scope");
  link(g_io_modules_scan_all_in_directory, "g_io_modules_scan_all_in_directory");
  link(g_io_modules_scan_all_in_directory_with_scope, "g_io_modules_scan_all_in_directory_with_scope");
  link(g_io_scheduler_cancel_all_jobs, "g_io_scheduler_cancel_all_jobs");
  link(g_io_scheduler_push_job, "g_io_scheduler_push_job");
  link(g_keyfile_settings_backend_new, "g_keyfile_settings_backend_new");
  link(g_memory_settings_backend_new, "g_memory_settings_backend_new");
  link(g_networking_init, "g_networking_init");
  link(g_null_settings_backend_new, "g_null_settings_backend_new");
  link(g_pollable_source_new, "g_pollable_source_new");
  link(g_pollable_source_new_full, "g_pollable_source_new_full");
  link(g_pollable_stream_read, "g_pollable_stream_read");
  link(g_pollable_stream_write, "g_pollable_stream_write");
  link(g_pollable_stream_write_all, "g_pollable_stream_write_all");
  link(g_resources_enumerate_children, "g_resources_enumerate_children");
  link(g_resources_get_info, "g_resources_get_info");
  link(g_resources_lookup_data, "g_resources_lookup_data");
  link(g_resources_open_stream, "g_resources_open_stream");
  link(g_resources_register, "g_resources_register");
  link(g_resources_unregister, "g_resources_unregister");
  link(g_simple_async_report_error_in_idle, "g_simple_async_report_error_in_idle");
  link(g_simple_async_report_gerror_in_idle, "g_simple_async_report_gerror_in_idle");
  link(g_simple_async_report_take_gerror_in_idle, "g_simple_async_report_take_gerror_in_idle");
  link(g_unix_is_mount_path_system_internal, "g_unix_is_mount_path_system_internal");
  link(g_unix_is_system_device_path, "g_unix_is_system_device_path");
  link(g_unix_is_system_fs_type, "g_unix_is_system_fs_type");
  link(g_unix_mount_at, "g_unix_mount_at");
  link(g_unix_mount_compare, "g_unix_mount_compare");
  link(g_unix_mount_copy, "g_unix_mount_copy");
  link(g_unix_mount_for, "g_unix_mount_for");
  link(g_unix_mount_free, "g_unix_mount_free");
  link(g_unix_mount_get_device_path, "g_unix_mount_get_device_path");
  link(g_unix_mount_get_fs_type, "g_unix_mount_get_fs_type");
  link(g_unix_mount_get_mount_path, "g_unix_mount_get_mount_path");
  link(g_unix_mount_get_options, "g_unix_mount_get_options");
  link(g_unix_mount_get_root_path, "g_unix_mount_get_root_path");
  link(g_unix_mount_guess_can_eject, "g_unix_mount_guess_can_eject");
  link(g_unix_mount_guess_icon, "g_unix_mount_guess_icon");
  link(g_unix_mount_guess_name, "g_unix_mount_guess_name");
  link(g_unix_mount_guess_should_display, "g_unix_mount_guess_should_display");
  link(g_unix_mount_guess_symbolic_icon, "g_unix_mount_guess_symbolic_icon");
  link(g_unix_mount_is_readonly, "g_unix_mount_is_readonly");
  link(g_unix_mount_is_system_internal, "g_unix_mount_is_system_internal");
  link(g_unix_mount_points_changed_since, "g_unix_mount_points_changed_since");
  link(g_unix_mount_points_get, "g_unix_mount_points_get");
  link(g_unix_mounts_changed_since, "g_unix_mounts_changed_since");
  link(g_unix_mounts_get, "g_unix_mounts_get");

  // IOExtension
  link(g_io_extension_get_name, "g_io_extension_get_name");
  link(g_io_extension_get_priority, "g_io_extension_get_priority");
  link(g_io_extension_get_type, "g_io_extension_get_type");
  link(g_io_extension_ref_class, "g_io_extension_ref_class");

  // IOExtensionPoint
  link(g_io_extension_point_get_extension_by_name, "g_io_extension_point_get_extension_by_name");
  link(g_io_extension_point_get_extensions, "g_io_extension_point_get_extensions");
  link(g_io_extension_point_get_required_type, "g_io_extension_point_get_required_type");
  link(g_io_extension_point_set_required_type, "g_io_extension_point_set_required_type");
  link(g_io_extension_point_implement, "g_io_extension_point_implement");
  link(g_io_extension_point_lookup, "g_io_extension_point_lookup");
  link(g_io_extension_point_register, "g_io_extension_point_register");

  // IOModule
  link(g_io_module_get_type, "g_io_module_get_type");
  link(g_io_module_new, "g_io_module_new");
  link(g_io_module_query, "g_io_module_query");
  link(g_io_module_load, "g_io_module_load");
  link(g_io_module_unload, "g_io_module_unload");

  // IOModuleScope
  link(g_io_module_scope_block, "g_io_module_scope_block");
  link(g_io_module_scope_free, "g_io_module_scope_free");
  link(g_io_module_scope_new, "g_io_module_scope_new");

  // IOSchedulerJob
  link(g_io_scheduler_job_send_to_mainloop, "g_io_scheduler_job_send_to_mainloop");
  link(g_io_scheduler_job_send_to_mainloop_async, "g_io_scheduler_job_send_to_mainloop_async");

  // IOStream
  link(g_io_stream_get_type, "g_io_stream_get_type");
  link(g_io_stream_splice_finish, "g_io_stream_splice_finish");
  link(g_io_stream_clear_pending, "g_io_stream_clear_pending");
  link(g_io_stream_close, "g_io_stream_close");
  link(g_io_stream_close_async, "g_io_stream_close_async");
  link(g_io_stream_close_finish, "g_io_stream_close_finish");
  link(g_io_stream_get_input_stream, "g_io_stream_get_input_stream");
  link(g_io_stream_get_output_stream, "g_io_stream_get_output_stream");
  link(g_io_stream_has_pending, "g_io_stream_has_pending");
  link(g_io_stream_is_closed, "g_io_stream_is_closed");
  link(g_io_stream_set_pending, "g_io_stream_set_pending");
  link(g_io_stream_splice_async, "g_io_stream_splice_async");

  // Icon
  link(g_icon_get_type, "g_icon_get_type");
  link(g_icon_deserialize, "g_icon_deserialize");
  link(g_icon_new_for_string, "g_icon_new_for_string");
  link(g_icon_equal, "g_icon_equal");
  link(g_icon_hash, "g_icon_hash");
  link(g_icon_serialize, "g_icon_serialize");
  link(g_icon_to_string, "g_icon_to_string");

  // InetAddress
  link(g_inet_address_get_type, "g_inet_address_get_type");
  link(g_inet_address_new_any, "g_inet_address_new_any");
  link(g_inet_address_new_from_bytes, "g_inet_address_new_from_bytes");
  link(g_inet_address_new_from_string, "g_inet_address_new_from_string");
  link(g_inet_address_new_loopback, "g_inet_address_new_loopback");
  link(g_inet_address_equal, "g_inet_address_equal");
  link(g_inet_address_get_family, "g_inet_address_get_family");
  link(g_inet_address_get_is_any, "g_inet_address_get_is_any");
  link(g_inet_address_get_is_link_local, "g_inet_address_get_is_link_local");
  link(g_inet_address_get_is_loopback, "g_inet_address_get_is_loopback");
  link(g_inet_address_get_is_mc_global, "g_inet_address_get_is_mc_global");
  link(g_inet_address_get_is_mc_link_local, "g_inet_address_get_is_mc_link_local");
  link(g_inet_address_get_is_mc_node_local, "g_inet_address_get_is_mc_node_local");
  link(g_inet_address_get_is_mc_org_local, "g_inet_address_get_is_mc_org_local");
  link(g_inet_address_get_is_mc_site_local, "g_inet_address_get_is_mc_site_local");
  link(g_inet_address_get_is_multicast, "g_inet_address_get_is_multicast");
  link(g_inet_address_get_is_site_local, "g_inet_address_get_is_site_local");
  link(g_inet_address_get_native_size, "g_inet_address_get_native_size");
  link(g_inet_address_to_bytes, "g_inet_address_to_bytes");
  link(g_inet_address_to_string, "g_inet_address_to_string");

  // InetAddressMask
  link(g_inet_address_mask_get_type, "g_inet_address_mask_get_type");
  link(g_inet_address_mask_new, "g_inet_address_mask_new");
  link(g_inet_address_mask_new_from_string, "g_inet_address_mask_new_from_string");
  link(g_inet_address_mask_equal, "g_inet_address_mask_equal");
  link(g_inet_address_mask_get_address, "g_inet_address_mask_get_address");
  link(g_inet_address_mask_get_family, "g_inet_address_mask_get_family");
  link(g_inet_address_mask_get_length, "g_inet_address_mask_get_length");
  link(g_inet_address_mask_matches, "g_inet_address_mask_matches");
  link(g_inet_address_mask_to_string, "g_inet_address_mask_to_string");

  // InetSocketAddress
  link(g_inet_socket_address_get_type, "g_inet_socket_address_get_type");
  link(g_inet_socket_address_new, "g_inet_socket_address_new");
  link(g_inet_socket_address_new_from_string, "g_inet_socket_address_new_from_string");
  link(g_inet_socket_address_get_address, "g_inet_socket_address_get_address");
  link(g_inet_socket_address_get_flowinfo, "g_inet_socket_address_get_flowinfo");
  link(g_inet_socket_address_get_port, "g_inet_socket_address_get_port");
  link(g_inet_socket_address_get_scope_id, "g_inet_socket_address_get_scope_id");

  // Initable
  link(g_initable_get_type, "g_initable_get_type");
  link(g_initable_new, "g_initable_new");
  link(g_initable_new_valist, "g_initable_new_valist");
  link(g_initable_newv, "g_initable_newv");
  link(g_initable_init, "g_initable_init");

  // InputStream
  link(g_input_stream_get_type, "g_input_stream_get_type");
  link(g_input_stream_clear_pending, "g_input_stream_clear_pending");
  link(g_input_stream_close, "g_input_stream_close");
  link(g_input_stream_close_async, "g_input_stream_close_async");
  link(g_input_stream_close_finish, "g_input_stream_close_finish");
  link(g_input_stream_has_pending, "g_input_stream_has_pending");
  link(g_input_stream_is_closed, "g_input_stream_is_closed");
  link(g_input_stream_read, "g_input_stream_read");
  link(g_input_stream_read_all, "g_input_stream_read_all");
  link(g_input_stream_read_all_async, "g_input_stream_read_all_async");
  link(g_input_stream_read_all_finish, "g_input_stream_read_all_finish");
  link(g_input_stream_read_async, "g_input_stream_read_async");
  link(g_input_stream_read_bytes, "g_input_stream_read_bytes");
  link(g_input_stream_read_bytes_async, "g_input_stream_read_bytes_async");
  link(g_input_stream_read_bytes_finish, "g_input_stream_read_bytes_finish");
  link(g_input_stream_read_finish, "g_input_stream_read_finish");
  link(g_input_stream_set_pending, "g_input_stream_set_pending");
  link(g_input_stream_skip, "g_input_stream_skip");
  link(g_input_stream_skip_async, "g_input_stream_skip_async");
  link(g_input_stream_skip_finish, "g_input_stream_skip_finish");

  // ListModel
  link(g_list_model_get_type, "g_list_model_get_type");
  link(g_list_model_get_item, "g_list_model_get_item");
  link(g_list_model_get_item_type, "g_list_model_get_item_type");
  link(g_list_model_get_n_items, "g_list_model_get_n_items");
  link(g_list_model_get_object, "g_list_model_get_object");
  link(g_list_model_items_changed, "g_list_model_items_changed");

  // ListStore
  link(g_list_store_get_type, "g_list_store_get_type");
  link(g_list_store_new, "g_list_store_new");
  link(g_list_store_append, "g_list_store_append");
  link(g_list_store_find, "g_list_store_find");
  link(g_list_store_find_with_equal_func, "g_list_store_find_with_equal_func");
  link(g_list_store_find_with_equal_func_full, "g_list_store_find_with_equal_func_full");
  link(g_list_store_insert, "g_list_store_insert");
  link(g_list_store_insert_sorted, "g_list_store_insert_sorted");
  link(g_list_store_remove, "g_list_store_remove");
  link(g_list_store_remove_all, "g_list_store_remove_all");
  link(g_list_store_sort, "g_list_store_sort");
  link(g_list_store_splice, "g_list_store_splice");

  // LoadableIcon
  link(g_loadable_icon_get_type, "g_loadable_icon_get_type");
  link(g_loadable_icon_load, "g_loadable_icon_load");
  link(g_loadable_icon_load_async, "g_loadable_icon_load_async");
  link(g_loadable_icon_load_finish, "g_loadable_icon_load_finish");

  // MemoryInputStream
  link(g_memory_input_stream_get_type, "g_memory_input_stream_get_type");
  link(g_memory_input_stream_new, "g_memory_input_stream_new");
  link(g_memory_input_stream_new_from_bytes, "g_memory_input_stream_new_from_bytes");
  link(g_memory_input_stream_new_from_data, "g_memory_input_stream_new_from_data");
  link(g_memory_input_stream_add_bytes, "g_memory_input_stream_add_bytes");
  link(g_memory_input_stream_add_data, "g_memory_input_stream_add_data");

  // MemoryMonitor
  link(g_memory_monitor_get_type, "g_memory_monitor_get_type");
  link(g_memory_monitor_dup_default, "g_memory_monitor_dup_default");

  // MemoryOutputStream
  link(g_memory_output_stream_get_type, "g_memory_output_stream_get_type");
  link(g_memory_output_stream_new, "g_memory_output_stream_new");
  link(g_memory_output_stream_new_resizable, "g_memory_output_stream_new_resizable");
  link(g_memory_output_stream_get_data, "g_memory_output_stream_get_data");
  link(g_memory_output_stream_get_data_size, "g_memory_output_stream_get_data_size");
  link(g_memory_output_stream_get_size, "g_memory_output_stream_get_size");
  link(g_memory_output_stream_steal_as_bytes, "g_memory_output_stream_steal_as_bytes");
  link(g_memory_output_stream_steal_data, "g_memory_output_stream_steal_data");

  // Menu
  link(g_menu_get_type, "g_menu_get_type");
  link(g_menu_new, "g_menu_new");
  link(g_menu_append, "g_menu_append");
  link(g_menu_append_item, "g_menu_append_item");
  link(g_menu_append_section, "g_menu_append_section");
  link(g_menu_append_submenu, "g_menu_append_submenu");
  link(g_menu_freeze, "g_menu_freeze");
  link(g_menu_insert, "g_menu_insert");
  link(g_menu_insert_item, "g_menu_insert_item");
  link(g_menu_insert_section, "g_menu_insert_section");
  link(g_menu_insert_submenu, "g_menu_insert_submenu");
  link(g_menu_prepend, "g_menu_prepend");
  link(g_menu_prepend_item, "g_menu_prepend_item");
  link(g_menu_prepend_section, "g_menu_prepend_section");
  link(g_menu_prepend_submenu, "g_menu_prepend_submenu");
  link(g_menu_remove, "g_menu_remove");
  link(g_menu_remove_all, "g_menu_remove_all");

  // MenuAttributeIter
  link(g_menu_attribute_iter_get_type, "g_menu_attribute_iter_get_type");
  link(g_menu_attribute_iter_get_name, "g_menu_attribute_iter_get_name");
  link(g_menu_attribute_iter_get_next, "g_menu_attribute_iter_get_next");
  link(g_menu_attribute_iter_get_value, "g_menu_attribute_iter_get_value");
  link(g_menu_attribute_iter_next, "g_menu_attribute_iter_next");

  // MenuItem
  link(g_menu_item_get_type, "g_menu_item_get_type");
  link(g_menu_item_new, "g_menu_item_new");
  link(g_menu_item_new_from_model, "g_menu_item_new_from_model");
  link(g_menu_item_new_section, "g_menu_item_new_section");
  link(g_menu_item_new_submenu, "g_menu_item_new_submenu");
  link(g_menu_item_get_attribute, "g_menu_item_get_attribute");
  link(g_menu_item_get_attribute_value, "g_menu_item_get_attribute_value");
  link(g_menu_item_get_link, "g_menu_item_get_link");
  link(g_menu_item_set_action_and_target, "g_menu_item_set_action_and_target");
  link(g_menu_item_set_action_and_target_value, "g_menu_item_set_action_and_target_value");
  link(g_menu_item_set_attribute, "g_menu_item_set_attribute");
  link(g_menu_item_set_attribute_value, "g_menu_item_set_attribute_value");
  link(g_menu_item_set_detailed_action, "g_menu_item_set_detailed_action");
  link(g_menu_item_set_icon, "g_menu_item_set_icon");
  link(g_menu_item_set_label, "g_menu_item_set_label");
  link(g_menu_item_set_link, "g_menu_item_set_link");
  link(g_menu_item_set_section, "g_menu_item_set_section");
  link(g_menu_item_set_submenu, "g_menu_item_set_submenu");

  // MenuLinkIter
  link(g_menu_link_iter_get_type, "g_menu_link_iter_get_type");
  link(g_menu_link_iter_get_name, "g_menu_link_iter_get_name");
  link(g_menu_link_iter_get_next, "g_menu_link_iter_get_next");
  link(g_menu_link_iter_get_value, "g_menu_link_iter_get_value");
  link(g_menu_link_iter_next, "g_menu_link_iter_next");

  // MenuModel
  link(g_menu_model_get_type, "g_menu_model_get_type");
  link(g_menu_model_get_item_attribute, "g_menu_model_get_item_attribute");
  link(g_menu_model_get_item_attribute_value, "g_menu_model_get_item_attribute_value");
  link(g_menu_model_get_item_link, "g_menu_model_get_item_link");
  link(g_menu_model_get_n_items, "g_menu_model_get_n_items");
  link(g_menu_model_is_mutable, "g_menu_model_is_mutable");
  link(g_menu_model_items_changed, "g_menu_model_items_changed");
  link(g_menu_model_iterate_item_attributes, "g_menu_model_iterate_item_attributes");
  link(g_menu_model_iterate_item_links, "g_menu_model_iterate_item_links");

  // Mount
  link(g_mount_get_type, "g_mount_get_type");
  link(g_mount_can_eject, "g_mount_can_eject");
  link(g_mount_can_unmount, "g_mount_can_unmount");
  link(g_mount_eject, "g_mount_eject");
  link(g_mount_eject_finish, "g_mount_eject_finish");
  link(g_mount_eject_with_operation, "g_mount_eject_with_operation");
  link(g_mount_eject_with_operation_finish, "g_mount_eject_with_operation_finish");
  link(g_mount_get_default_location, "g_mount_get_default_location");
  link(g_mount_get_drive, "g_mount_get_drive");
  link(g_mount_get_icon, "g_mount_get_icon");
  link(g_mount_get_name, "g_mount_get_name");
  link(g_mount_get_root, "g_mount_get_root");
  link(g_mount_get_sort_key, "g_mount_get_sort_key");
  link(g_mount_get_symbolic_icon, "g_mount_get_symbolic_icon");
  link(g_mount_get_uuid, "g_mount_get_uuid");
  link(g_mount_get_volume, "g_mount_get_volume");
  link(g_mount_guess_content_type, "g_mount_guess_content_type");
  link(g_mount_guess_content_type_finish, "g_mount_guess_content_type_finish");
  link(g_mount_guess_content_type_sync, "g_mount_guess_content_type_sync");
  link(g_mount_is_shadowed, "g_mount_is_shadowed");
  link(g_mount_remount, "g_mount_remount");
  link(g_mount_remount_finish, "g_mount_remount_finish");
  link(g_mount_shadow, "g_mount_shadow");
  link(g_mount_unmount, "g_mount_unmount");
  link(g_mount_unmount_finish, "g_mount_unmount_finish");
  link(g_mount_unmount_with_operation, "g_mount_unmount_with_operation");
  link(g_mount_unmount_with_operation_finish, "g_mount_unmount_with_operation_finish");
  link(g_mount_unshadow, "g_mount_unshadow");

  // MountOperation
  link(g_mount_operation_get_type, "g_mount_operation_get_type");
  link(g_mount_operation_new, "g_mount_operation_new");
  link(g_mount_operation_get_anonymous, "g_mount_operation_get_anonymous");
  link(g_mount_operation_get_choice, "g_mount_operation_get_choice");
  link(g_mount_operation_get_domain, "g_mount_operation_get_domain");
  link(g_mount_operation_get_is_tcrypt_hidden_volume, "g_mount_operation_get_is_tcrypt_hidden_volume");
  link(g_mount_operation_get_is_tcrypt_system_volume, "g_mount_operation_get_is_tcrypt_system_volume");
  link(g_mount_operation_get_password, "g_mount_operation_get_password");
  link(g_mount_operation_get_password_save, "g_mount_operation_get_password_save");
  link(g_mount_operation_get_pim, "g_mount_operation_get_pim");
  link(g_mount_operation_get_username, "g_mount_operation_get_username");
  link(g_mount_operation_reply, "g_mount_operation_reply");
  link(g_mount_operation_set_anonymous, "g_mount_operation_set_anonymous");
  link(g_mount_operation_set_choice, "g_mount_operation_set_choice");
  link(g_mount_operation_set_domain, "g_mount_operation_set_domain");
  link(g_mount_operation_set_is_tcrypt_hidden_volume, "g_mount_operation_set_is_tcrypt_hidden_volume");
  link(g_mount_operation_set_is_tcrypt_system_volume, "g_mount_operation_set_is_tcrypt_system_volume");
  link(g_mount_operation_set_password, "g_mount_operation_set_password");
  link(g_mount_operation_set_password_save, "g_mount_operation_set_password_save");
  link(g_mount_operation_set_pim, "g_mount_operation_set_pim");
  link(g_mount_operation_set_username, "g_mount_operation_set_username");

  // NativeSocketAddress
  link(g_native_socket_address_get_type, "g_native_socket_address_get_type");
  link(g_native_socket_address_new, "g_native_socket_address_new");

  // NativeVolumeMonitor
  link(g_native_volume_monitor_get_type, "g_native_volume_monitor_get_type");

  // NetworkAddress
  link(g_network_address_get_type, "g_network_address_get_type");
  link(g_network_address_new, "g_network_address_new");
  link(g_network_address_new_loopback, "g_network_address_new_loopback");
  link(g_network_address_parse, "g_network_address_parse");
  link(g_network_address_parse_uri, "g_network_address_parse_uri");
  link(g_network_address_get_hostname, "g_network_address_get_hostname");
  link(g_network_address_get_port, "g_network_address_get_port");
  link(g_network_address_get_scheme, "g_network_address_get_scheme");

  // NetworkMonitor
  link(g_network_monitor_get_type, "g_network_monitor_get_type");
  link(g_network_monitor_get_default, "g_network_monitor_get_default");
  link(g_network_monitor_can_reach, "g_network_monitor_can_reach");
  link(g_network_monitor_can_reach_async, "g_network_monitor_can_reach_async");
  link(g_network_monitor_can_reach_finish, "g_network_monitor_can_reach_finish");
  link(g_network_monitor_get_connectivity, "g_network_monitor_get_connectivity");
  link(g_network_monitor_get_network_available, "g_network_monitor_get_network_available");
  link(g_network_monitor_get_network_metered, "g_network_monitor_get_network_metered");

  // NetworkService
  link(g_network_service_get_type, "g_network_service_get_type");
  link(g_network_service_new, "g_network_service_new");
  link(g_network_service_get_domain, "g_network_service_get_domain");
  link(g_network_service_get_protocol, "g_network_service_get_protocol");
  link(g_network_service_get_scheme, "g_network_service_get_scheme");
  link(g_network_service_get_service, "g_network_service_get_service");
  link(g_network_service_set_scheme, "g_network_service_set_scheme");

  // Notification
  link(g_notification_get_type, "g_notification_get_type");
  link(g_notification_new, "g_notification_new");
  link(g_notification_add_button, "g_notification_add_button");
  link(g_notification_add_button_with_target, "g_notification_add_button_with_target");
  link(g_notification_add_button_with_target_value, "g_notification_add_button_with_target_value");
  link(g_notification_set_body, "g_notification_set_body");
  link(g_notification_set_category, "g_notification_set_category");
  link(g_notification_set_default_action, "g_notification_set_default_action");
  link(g_notification_set_default_action_and_target, "g_notification_set_default_action_and_target");
  link(g_notification_set_default_action_and_target_value, "g_notification_set_default_action_and_target_value");
  link(g_notification_set_icon, "g_notification_set_icon");
  link(g_notification_set_priority, "g_notification_set_priority");
  link(g_notification_set_title, "g_notification_set_title");
  link(g_notification_set_urgent, "g_notification_set_urgent");

  // OutputStream
  link(g_output_stream_get_type, "g_output_stream_get_type");
  link(g_output_stream_clear_pending, "g_output_stream_clear_pending");
  link(g_output_stream_close, "g_output_stream_close");
  link(g_output_stream_close_async, "g_output_stream_close_async");
  link(g_output_stream_close_finish, "g_output_stream_close_finish");
  link(g_output_stream_flush, "g_output_stream_flush");
  link(g_output_stream_flush_async, "g_output_stream_flush_async");
  link(g_output_stream_flush_finish, "g_output_stream_flush_finish");
  link(g_output_stream_has_pending, "g_output_stream_has_pending");
  link(g_output_stream_is_closed, "g_output_stream_is_closed");
  link(g_output_stream_is_closing, "g_output_stream_is_closing");
  link(g_output_stream_printf, "g_output_stream_printf");
  link(g_output_stream_set_pending, "g_output_stream_set_pending");
  link(g_output_stream_splice, "g_output_stream_splice");
  link(g_output_stream_splice_async, "g_output_stream_splice_async");
  link(g_output_stream_splice_finish, "g_output_stream_splice_finish");
  link(g_output_stream_vprintf, "g_output_stream_vprintf");
  link(g_output_stream_write, "g_output_stream_write");
  link(g_output_stream_write_all, "g_output_stream_write_all");
  link(g_output_stream_write_all_async, "g_output_stream_write_all_async");
  link(g_output_stream_write_all_finish, "g_output_stream_write_all_finish");
  link(g_output_stream_write_async, "g_output_stream_write_async");
  link(g_output_stream_write_bytes, "g_output_stream_write_bytes");
  link(g_output_stream_write_bytes_async, "g_output_stream_write_bytes_async");
  link(g_output_stream_write_bytes_finish, "g_output_stream_write_bytes_finish");
  link(g_output_stream_write_finish, "g_output_stream_write_finish");
  link(g_output_stream_writev, "g_output_stream_writev");
  link(g_output_stream_writev_all, "g_output_stream_writev_all");
  link(g_output_stream_writev_all_async, "g_output_stream_writev_all_async");
  link(g_output_stream_writev_all_finish, "g_output_stream_writev_all_finish");
  link(g_output_stream_writev_async, "g_output_stream_writev_async");
  link(g_output_stream_writev_finish, "g_output_stream_writev_finish");

  // Permission
  link(g_permission_get_type, "g_permission_get_type");
  link(g_permission_acquire, "g_permission_acquire");
  link(g_permission_acquire_async, "g_permission_acquire_async");
  link(g_permission_acquire_finish, "g_permission_acquire_finish");
  link(g_permission_get_allowed, "g_permission_get_allowed");
  link(g_permission_get_can_acquire, "g_permission_get_can_acquire");
  link(g_permission_get_can_release, "g_permission_get_can_release");
  link(g_permission_impl_update, "g_permission_impl_update");
  link(g_permission_release, "g_permission_release");
  link(g_permission_release_async, "g_permission_release_async");
  link(g_permission_release_finish, "g_permission_release_finish");

  // PollableInputStream
  link(g_pollable_input_stream_get_type, "g_pollable_input_stream_get_type");
  link(g_pollable_input_stream_can_poll, "g_pollable_input_stream_can_poll");
  link(g_pollable_input_stream_create_source, "g_pollable_input_stream_create_source");
  link(g_pollable_input_stream_is_readable, "g_pollable_input_stream_is_readable");
  link(g_pollable_input_stream_read_nonblocking, "g_pollable_input_stream_read_nonblocking");

  // PollableOutputStream
  link(g_pollable_output_stream_get_type, "g_pollable_output_stream_get_type");
  link(g_pollable_output_stream_can_poll, "g_pollable_output_stream_can_poll");
  link(g_pollable_output_stream_create_source, "g_pollable_output_stream_create_source");
  link(g_pollable_output_stream_is_writable, "g_pollable_output_stream_is_writable");
  link(g_pollable_output_stream_write_nonblocking, "g_pollable_output_stream_write_nonblocking");
  link(g_pollable_output_stream_writev_nonblocking, "g_pollable_output_stream_writev_nonblocking");

  // PowerProfileMonitor
  link(g_power_profile_monitor_get_type, "g_power_profile_monitor_get_type");
  link(g_power_profile_monitor_dup_default, "g_power_profile_monitor_dup_default");
  link(g_power_profile_monitor_get_power_saver_enabled, "g_power_profile_monitor_get_power_saver_enabled");

  // PropertyAction
  link(g_property_action_get_type, "g_property_action_get_type");
  link(g_property_action_new, "g_property_action_new");

  // Proxy
  link(g_proxy_get_type, "g_proxy_get_type");
  link(g_proxy_get_default_for_protocol, "g_proxy_get_default_for_protocol");
  link(g_proxy_connect, "g_proxy_connect");
  link(g_proxy_connect_async, "g_proxy_connect_async");
  link(g_proxy_connect_finish, "g_proxy_connect_finish");
  link(g_proxy_supports_hostname, "g_proxy_supports_hostname");

  // ProxyAddress
  link(g_proxy_address_get_type, "g_proxy_address_get_type");
  link(g_proxy_address_new, "g_proxy_address_new");
  link(g_proxy_address_get_destination_hostname, "g_proxy_address_get_destination_hostname");
  link(g_proxy_address_get_destination_port, "g_proxy_address_get_destination_port");
  link(g_proxy_address_get_destination_protocol, "g_proxy_address_get_destination_protocol");
  link(g_proxy_address_get_password, "g_proxy_address_get_password");
  link(g_proxy_address_get_protocol, "g_proxy_address_get_protocol");
  link(g_proxy_address_get_uri, "g_proxy_address_get_uri");
  link(g_proxy_address_get_username, "g_proxy_address_get_username");

  // ProxyAddressEnumerator
  link(g_proxy_address_enumerator_get_type, "g_proxy_address_enumerator_get_type");

  // ProxyResolver
  link(g_proxy_resolver_get_type, "g_proxy_resolver_get_type");
  link(g_proxy_resolver_get_default, "g_proxy_resolver_get_default");
  link(g_proxy_resolver_is_supported, "g_proxy_resolver_is_supported");
  link(g_proxy_resolver_lookup, "g_proxy_resolver_lookup");
  link(g_proxy_resolver_lookup_async, "g_proxy_resolver_lookup_async");
  link(g_proxy_resolver_lookup_finish, "g_proxy_resolver_lookup_finish");

  // RemoteActionGroup
  link(g_remote_action_group_get_type, "g_remote_action_group_get_type");
  link(g_remote_action_group_activate_action_full, "g_remote_action_group_activate_action_full");
  link(g_remote_action_group_change_action_state_full, "g_remote_action_group_change_action_state_full");

  // Resolver
  link(g_resolver_get_type, "g_resolver_get_type");
  link(g_resolver_free_addresses, "g_resolver_free_addresses");
  link(g_resolver_free_targets, "g_resolver_free_targets");
  link(g_resolver_get_default, "g_resolver_get_default");
  link(g_resolver_get_timeout, "g_resolver_get_timeout");
  link(g_resolver_lookup_by_address, "g_resolver_lookup_by_address");
  link(g_resolver_lookup_by_address_async, "g_resolver_lookup_by_address_async");
  link(g_resolver_lookup_by_address_finish, "g_resolver_lookup_by_address_finish");
  link(g_resolver_lookup_by_name, "g_resolver_lookup_by_name");
  link(g_resolver_lookup_by_name_async, "g_resolver_lookup_by_name_async");
  link(g_resolver_lookup_by_name_finish, "g_resolver_lookup_by_name_finish");
  link(g_resolver_lookup_by_name_with_flags, "g_resolver_lookup_by_name_with_flags");
  link(g_resolver_lookup_by_name_with_flags_async, "g_resolver_lookup_by_name_with_flags_async");
  link(g_resolver_lookup_by_name_with_flags_finish, "g_resolver_lookup_by_name_with_flags_finish");
  link(g_resolver_lookup_records, "g_resolver_lookup_records");
  link(g_resolver_lookup_records_async, "g_resolver_lookup_records_async");
  link(g_resolver_lookup_records_finish, "g_resolver_lookup_records_finish");
  link(g_resolver_lookup_service, "g_resolver_lookup_service");
  link(g_resolver_lookup_service_async, "g_resolver_lookup_service_async");
  link(g_resolver_lookup_service_finish, "g_resolver_lookup_service_finish");
  link(g_resolver_set_default, "g_resolver_set_default");
  link(g_resolver_set_timeout, "g_resolver_set_timeout");

  // Resource
  link(g_resource_get_type, "g_resource_get_type");
  link(g_resource_new_from_data, "g_resource_new_from_data");
  link(g_resource_enumerate_children, "g_resource_enumerate_children");
  link(g_resource_get_info, "g_resource_get_info");
  link(g_resource_lookup_data, "g_resource_lookup_data");
  link(g_resource_open_stream, "g_resource_open_stream");
  link(g_resource_ref, "g_resource_ref");
  link(g_resource_unref, "g_resource_unref");
  link(g_resource_load, "g_resource_load");

  // Seekable
  link(g_seekable_get_type, "g_seekable_get_type");
  link(g_seekable_can_seek, "g_seekable_can_seek");
  link(g_seekable_can_truncate, "g_seekable_can_truncate");
  link(g_seekable_seek, "g_seekable_seek");
  link(g_seekable_tell, "g_seekable_tell");
  link(g_seekable_truncate, "g_seekable_truncate");

  // Settings
  link(g_settings_get_type, "g_settings_get_type");
  link(g_settings_new, "g_settings_new");
  link(g_settings_new_full, "g_settings_new_full");
  link(g_settings_new_with_backend, "g_settings_new_with_backend");
  link(g_settings_new_with_backend_and_path, "g_settings_new_with_backend_and_path");
  link(g_settings_new_with_path, "g_settings_new_with_path");
  link(g_settings_list_relocatable_schemas, "g_settings_list_relocatable_schemas");
  link(g_settings_list_schemas, "g_settings_list_schemas");
  link(g_settings_sync, "g_settings_sync");
  link(g_settings_unbind, "g_settings_unbind");
  link(g_settings_apply, "g_settings_apply");
  link(g_settings_bind, "g_settings_bind");
  link(g_settings_bind_with_mapping, "g_settings_bind_with_mapping");
  link(g_settings_bind_writable, "g_settings_bind_writable");
  link(g_settings_create_action, "g_settings_create_action");
  link(g_settings_delay, "g_settings_delay");
  link(g_settings_get, "g_settings_get");
  link(g_settings_get_boolean, "g_settings_get_boolean");
  link(g_settings_get_child, "g_settings_get_child");
  link(g_settings_get_default_value, "g_settings_get_default_value");
  link(g_settings_get_double, "g_settings_get_double");
  link(g_settings_get_enum, "g_settings_get_enum");
  link(g_settings_get_flags, "g_settings_get_flags");
  link(g_settings_get_has_unapplied, "g_settings_get_has_unapplied");
  link(g_settings_get_int, "g_settings_get_int");
  link(g_settings_get_int64, "g_settings_get_int64");
  link(g_settings_get_mapped, "g_settings_get_mapped");
  link(g_settings_get_range, "g_settings_get_range");
  link(g_settings_get_string, "g_settings_get_string");
  link(g_settings_get_strv, "g_settings_get_strv");
  link(g_settings_get_uint, "g_settings_get_uint");
  link(g_settings_get_uint64, "g_settings_get_uint64");
  link(g_settings_get_user_value, "g_settings_get_user_value");
  link(g_settings_get_value, "g_settings_get_value");
  link(g_settings_is_writable, "g_settings_is_writable");
  link(g_settings_list_children, "g_settings_list_children");
  link(g_settings_list_keys, "g_settings_list_keys");
  link(g_settings_range_check, "g_settings_range_check");
  link(g_settings_reset, "g_settings_reset");
  link(g_settings_revert, "g_settings_revert");
  link(g_settings_set, "g_settings_set");
  link(g_settings_set_boolean, "g_settings_set_boolean");
  link(g_settings_set_double, "g_settings_set_double");
  link(g_settings_set_enum, "g_settings_set_enum");
  link(g_settings_set_flags, "g_settings_set_flags");
  link(g_settings_set_int, "g_settings_set_int");
  link(g_settings_set_int64, "g_settings_set_int64");
  link(g_settings_set_string, "g_settings_set_string");
  link(g_settings_set_strv, "g_settings_set_strv");
  link(g_settings_set_uint, "g_settings_set_uint");
  link(g_settings_set_uint64, "g_settings_set_uint64");
  link(g_settings_set_value, "g_settings_set_value");

  // SettingsBackend
  link(g_settings_backend_get_type, "g_settings_backend_get_type");
  link(g_settings_backend_flatten_tree, "g_settings_backend_flatten_tree");
  link(g_settings_backend_get_default, "g_settings_backend_get_default");
  link(g_settings_backend_changed, "g_settings_backend_changed");
  link(g_settings_backend_changed_tree, "g_settings_backend_changed_tree");
  link(g_settings_backend_keys_changed, "g_settings_backend_keys_changed");
  link(g_settings_backend_path_changed, "g_settings_backend_path_changed");
  link(g_settings_backend_path_writable_changed, "g_settings_backend_path_writable_changed");
  link(g_settings_backend_writable_changed, "g_settings_backend_writable_changed");

  // SettingsSchema
  link(g_settings_schema_get_type, "g_settings_schema_get_type");
  link(g_settings_schema_get_id, "g_settings_schema_get_id");
  link(g_settings_schema_get_key, "g_settings_schema_get_key");
  link(g_settings_schema_get_path, "g_settings_schema_get_path");
  link(g_settings_schema_has_key, "g_settings_schema_has_key");
  link(g_settings_schema_list_children, "g_settings_schema_list_children");
  link(g_settings_schema_list_keys, "g_settings_schema_list_keys");
  link(g_settings_schema_ref, "g_settings_schema_ref");
  link(g_settings_schema_unref, "g_settings_schema_unref");

  // SettingsSchemaKey
  link(g_settings_schema_key_get_type, "g_settings_schema_key_get_type");
  link(g_settings_schema_key_get_default_value, "g_settings_schema_key_get_default_value");
  link(g_settings_schema_key_get_description, "g_settings_schema_key_get_description");
  link(g_settings_schema_key_get_name, "g_settings_schema_key_get_name");
  link(g_settings_schema_key_get_range, "g_settings_schema_key_get_range");
  link(g_settings_schema_key_get_summary, "g_settings_schema_key_get_summary");
  link(g_settings_schema_key_get_value_type, "g_settings_schema_key_get_value_type");
  link(g_settings_schema_key_range_check, "g_settings_schema_key_range_check");
  link(g_settings_schema_key_ref, "g_settings_schema_key_ref");
  link(g_settings_schema_key_unref, "g_settings_schema_key_unref");

  // SettingsSchemaSource
  link(g_settings_schema_source_get_type, "g_settings_schema_source_get_type");
  link(g_settings_schema_source_new_from_directory, "g_settings_schema_source_new_from_directory");
  link(g_settings_schema_source_list_schemas, "g_settings_schema_source_list_schemas");
  link(g_settings_schema_source_lookup, "g_settings_schema_source_lookup");
  link(g_settings_schema_source_ref, "g_settings_schema_source_ref");
  link(g_settings_schema_source_unref, "g_settings_schema_source_unref");
  link(g_settings_schema_source_get_default, "g_settings_schema_source_get_default");

  // SimpleAction
  link(g_simple_action_get_type, "g_simple_action_get_type");
  link(g_simple_action_new, "g_simple_action_new");
  link(g_simple_action_new_stateful, "g_simple_action_new_stateful");
  link(g_simple_action_set_enabled, "g_simple_action_set_enabled");
  link(g_simple_action_set_state, "g_simple_action_set_state");
  link(g_simple_action_set_state_hint, "g_simple_action_set_state_hint");

  // SimpleActionGroup
  link(g_simple_action_group_get_type, "g_simple_action_group_get_type");
  link(g_simple_action_group_new, "g_simple_action_group_new");
  link(g_simple_action_group_add_entries, "g_simple_action_group_add_entries");
  link(g_simple_action_group_insert, "g_simple_action_group_insert");
  link(g_simple_action_group_lookup, "g_simple_action_group_lookup");
  link(g_simple_action_group_remove, "g_simple_action_group_remove");

  // SimpleAsyncResult
  link(g_simple_async_result_get_type, "g_simple_async_result_get_type");
  link(g_simple_async_result_new, "g_simple_async_result_new");
  link(g_simple_async_result_new_error, "g_simple_async_result_new_error");
  link(g_simple_async_result_new_from_error, "g_simple_async_result_new_from_error");
  link(g_simple_async_result_new_take_error, "g_simple_async_result_new_take_error");
  link(g_simple_async_result_is_valid, "g_simple_async_result_is_valid");
  link(g_simple_async_result_complete, "g_simple_async_result_complete");
  link(g_simple_async_result_complete_in_idle, "g_simple_async_result_complete_in_idle");
  link(g_simple_async_result_get_op_res_gboolean, "g_simple_async_result_get_op_res_gboolean");
  link(g_simple_async_result_get_op_res_gpointer, "g_simple_async_result_get_op_res_gpointer");
  link(g_simple_async_result_get_op_res_gssize, "g_simple_async_result_get_op_res_gssize");
  link(g_simple_async_result_get_source_tag, "g_simple_async_result_get_source_tag");
  link(g_simple_async_result_propagate_error, "g_simple_async_result_propagate_error");
  link(g_simple_async_result_run_in_thread, "g_simple_async_result_run_in_thread");
  link(g_simple_async_result_set_check_cancellable, "g_simple_async_result_set_check_cancellable");
  link(g_simple_async_result_set_error, "g_simple_async_result_set_error");
  link(g_simple_async_result_set_error_va, "g_simple_async_result_set_error_va");
  link(g_simple_async_result_set_from_error, "g_simple_async_result_set_from_error");
  link(g_simple_async_result_set_handle_cancellation, "g_simple_async_result_set_handle_cancellation");
  link(g_simple_async_result_set_op_res_gboolean, "g_simple_async_result_set_op_res_gboolean");
  link(g_simple_async_result_set_op_res_gpointer, "g_simple_async_result_set_op_res_gpointer");
  link(g_simple_async_result_set_op_res_gssize, "g_simple_async_result_set_op_res_gssize");
  link(g_simple_async_result_take_error, "g_simple_async_result_take_error");

  // SimpleIOStream
  link(g_simple_io_stream_get_type, "g_simple_io_stream_get_type");
  link(g_simple_io_stream_new, "g_simple_io_stream_new");

  // SimplePermission
  link(g_simple_permission_get_type, "g_simple_permission_get_type");
  link(g_simple_permission_new, "g_simple_permission_new");

  // SimpleProxyResolver
  link(g_simple_proxy_resolver_get_type, "g_simple_proxy_resolver_get_type");
  link(g_simple_proxy_resolver_new, "g_simple_proxy_resolver_new");
  link(g_simple_proxy_resolver_set_default_proxy, "g_simple_proxy_resolver_set_default_proxy");
  link(g_simple_proxy_resolver_set_ignore_hosts, "g_simple_proxy_resolver_set_ignore_hosts");
  link(g_simple_proxy_resolver_set_uri_proxy, "g_simple_proxy_resolver_set_uri_proxy");

  // Socket
  link(g_socket_get_type, "g_socket_get_type");
  link(g_socket_new, "g_socket_new");
  link(g_socket_new_from_fd, "g_socket_new_from_fd");
  link(g_socket_accept, "g_socket_accept");
  link(g_socket_bind, "g_socket_bind");
  link(g_socket_check_connect_result, "g_socket_check_connect_result");
  link(g_socket_close, "g_socket_close");
  link(g_socket_condition_check, "g_socket_condition_check");
  link(g_socket_condition_timed_wait, "g_socket_condition_timed_wait");
  link(g_socket_condition_wait, "g_socket_condition_wait");
  link(g_socket_connect, "g_socket_connect");
  link(g_socket_connection_factory_create_connection, "g_socket_connection_factory_create_connection");
  link(g_socket_create_source, "g_socket_create_source");
  link(g_socket_get_available_bytes, "g_socket_get_available_bytes");
  link(g_socket_get_blocking, "g_socket_get_blocking");
  link(g_socket_get_broadcast, "g_socket_get_broadcast");
  link(g_socket_get_credentials, "g_socket_get_credentials");
  link(g_socket_get_family, "g_socket_get_family");
  link(g_socket_get_fd, "g_socket_get_fd");
  link(g_socket_get_keepalive, "g_socket_get_keepalive");
  link(g_socket_get_listen_backlog, "g_socket_get_listen_backlog");
  link(g_socket_get_local_address, "g_socket_get_local_address");
  link(g_socket_get_multicast_loopback, "g_socket_get_multicast_loopback");
  link(g_socket_get_multicast_ttl, "g_socket_get_multicast_ttl");
  link(g_socket_get_option, "g_socket_get_option");
  link(g_socket_get_protocol, "g_socket_get_protocol");
  link(g_socket_get_remote_address, "g_socket_get_remote_address");
  link(g_socket_get_socket_type, "g_socket_get_socket_type");
  link(g_socket_get_timeout, "g_socket_get_timeout");
  link(g_socket_get_ttl, "g_socket_get_ttl");
  link(g_socket_is_closed, "g_socket_is_closed");
  link(g_socket_is_connected, "g_socket_is_connected");
  link(g_socket_join_multicast_group, "g_socket_join_multicast_group");
  link(g_socket_join_multicast_group_ssm, "g_socket_join_multicast_group_ssm");
  link(g_socket_leave_multicast_group, "g_socket_leave_multicast_group");
  link(g_socket_leave_multicast_group_ssm, "g_socket_leave_multicast_group_ssm");
  link(g_socket_listen, "g_socket_listen");
  link(g_socket_receive, "g_socket_receive");
  link(g_socket_receive_bytes, "g_socket_receive_bytes");
  link(g_socket_receive_bytes_from, "g_socket_receive_bytes_from");
  link(g_socket_receive_from, "g_socket_receive_from");
  link(g_socket_receive_message, "g_socket_receive_message");
  link(g_socket_receive_messages, "g_socket_receive_messages");
  link(g_socket_receive_with_blocking, "g_socket_receive_with_blocking");
  link(g_socket_send, "g_socket_send");
  link(g_socket_send_message, "g_socket_send_message");
  link(g_socket_send_message_with_timeout, "g_socket_send_message_with_timeout");
  link(g_socket_send_messages, "g_socket_send_messages");
  link(g_socket_send_to, "g_socket_send_to");
  link(g_socket_send_with_blocking, "g_socket_send_with_blocking");
  link(g_socket_set_blocking, "g_socket_set_blocking");
  link(g_socket_set_broadcast, "g_socket_set_broadcast");
  link(g_socket_set_keepalive, "g_socket_set_keepalive");
  link(g_socket_set_listen_backlog, "g_socket_set_listen_backlog");
  link(g_socket_set_multicast_loopback, "g_socket_set_multicast_loopback");
  link(g_socket_set_multicast_ttl, "g_socket_set_multicast_ttl");
  link(g_socket_set_option, "g_socket_set_option");
  link(g_socket_set_timeout, "g_socket_set_timeout");
  link(g_socket_set_ttl, "g_socket_set_ttl");
  link(g_socket_shutdown, "g_socket_shutdown");
  link(g_socket_speaks_ipv4, "g_socket_speaks_ipv4");

  // SocketAddress
  link(g_socket_address_get_type, "g_socket_address_get_type");
  link(g_socket_address_new_from_native, "g_socket_address_new_from_native");
  link(g_socket_address_get_family, "g_socket_address_get_family");
  link(g_socket_address_get_native_size, "g_socket_address_get_native_size");
  link(g_socket_address_to_native, "g_socket_address_to_native");

  // SocketAddressEnumerator
  link(g_socket_address_enumerator_get_type, "g_socket_address_enumerator_get_type");
  link(g_socket_address_enumerator_next, "g_socket_address_enumerator_next");
  link(g_socket_address_enumerator_next_async, "g_socket_address_enumerator_next_async");
  link(g_socket_address_enumerator_next_finish, "g_socket_address_enumerator_next_finish");

  // SocketClient
  link(g_socket_client_get_type, "g_socket_client_get_type");
  link(g_socket_client_new, "g_socket_client_new");
  link(g_socket_client_add_application_proxy, "g_socket_client_add_application_proxy");
  link(g_socket_client_connect, "g_socket_client_connect");
  link(g_socket_client_connect_async, "g_socket_client_connect_async");
  link(g_socket_client_connect_finish, "g_socket_client_connect_finish");
  link(g_socket_client_connect_to_host, "g_socket_client_connect_to_host");
  link(g_socket_client_connect_to_host_async, "g_socket_client_connect_to_host_async");
  link(g_socket_client_connect_to_host_finish, "g_socket_client_connect_to_host_finish");
  link(g_socket_client_connect_to_service, "g_socket_client_connect_to_service");
  link(g_socket_client_connect_to_service_async, "g_socket_client_connect_to_service_async");
  link(g_socket_client_connect_to_service_finish, "g_socket_client_connect_to_service_finish");
  link(g_socket_client_connect_to_uri, "g_socket_client_connect_to_uri");
  link(g_socket_client_connect_to_uri_async, "g_socket_client_connect_to_uri_async");
  link(g_socket_client_connect_to_uri_finish, "g_socket_client_connect_to_uri_finish");
  link(g_socket_client_get_enable_proxy, "g_socket_client_get_enable_proxy");
  link(g_socket_client_get_family, "g_socket_client_get_family");
  link(g_socket_client_get_local_address, "g_socket_client_get_local_address");
  link(g_socket_client_get_protocol, "g_socket_client_get_protocol");
  link(g_socket_client_get_proxy_resolver, "g_socket_client_get_proxy_resolver");
  link(g_socket_client_get_socket_type, "g_socket_client_get_socket_type");
  link(g_socket_client_get_timeout, "g_socket_client_get_timeout");
  link(g_socket_client_get_tls, "g_socket_client_get_tls");
  link(g_socket_client_get_tls_validation_flags, "g_socket_client_get_tls_validation_flags");
  link(g_socket_client_set_enable_proxy, "g_socket_client_set_enable_proxy");
  link(g_socket_client_set_family, "g_socket_client_set_family");
  link(g_socket_client_set_local_address, "g_socket_client_set_local_address");
  link(g_socket_client_set_protocol, "g_socket_client_set_protocol");
  link(g_socket_client_set_proxy_resolver, "g_socket_client_set_proxy_resolver");
  link(g_socket_client_set_socket_type, "g_socket_client_set_socket_type");
  link(g_socket_client_set_timeout, "g_socket_client_set_timeout");
  link(g_socket_client_set_tls, "g_socket_client_set_tls");
  link(g_socket_client_set_tls_validation_flags, "g_socket_client_set_tls_validation_flags");

  // SocketConnectable
  link(g_socket_connectable_get_type, "g_socket_connectable_get_type");
  link(g_socket_connectable_enumerate, "g_socket_connectable_enumerate");
  link(g_socket_connectable_proxy_enumerate, "g_socket_connectable_proxy_enumerate");
  link(g_socket_connectable_to_string, "g_socket_connectable_to_string");

  // SocketConnection
  link(g_socket_connection_get_type, "g_socket_connection_get_type");
  link(g_socket_connection_factory_lookup_type, "g_socket_connection_factory_lookup_type");
  link(g_socket_connection_factory_register_type, "g_socket_connection_factory_register_type");
  link(g_socket_connection_connect, "g_socket_connection_connect");
  link(g_socket_connection_connect_async, "g_socket_connection_connect_async");
  link(g_socket_connection_connect_finish, "g_socket_connection_connect_finish");
  link(g_socket_connection_get_local_address, "g_socket_connection_get_local_address");
  link(g_socket_connection_get_remote_address, "g_socket_connection_get_remote_address");
  link(g_socket_connection_get_socket, "g_socket_connection_get_socket");
  link(g_socket_connection_is_connected, "g_socket_connection_is_connected");

  // SocketControlMessage
  link(g_socket_control_message_get_type, "g_socket_control_message_get_type");
  link(g_socket_control_message_deserialize, "g_socket_control_message_deserialize");
  link(g_socket_control_message_get_level, "g_socket_control_message_get_level");
  link(g_socket_control_message_get_msg_type, "g_socket_control_message_get_msg_type");
  link(g_socket_control_message_get_size, "g_socket_control_message_get_size");
  link(g_socket_control_message_serialize, "g_socket_control_message_serialize");

  // SocketListener
  link(g_socket_listener_get_type, "g_socket_listener_get_type");
  link(g_socket_listener_new, "g_socket_listener_new");
  link(g_socket_listener_accept, "g_socket_listener_accept");
  link(g_socket_listener_accept_async, "g_socket_listener_accept_async");
  link(g_socket_listener_accept_finish, "g_socket_listener_accept_finish");
  link(g_socket_listener_accept_socket, "g_socket_listener_accept_socket");
  link(g_socket_listener_accept_socket_async, "g_socket_listener_accept_socket_async");
  link(g_socket_listener_accept_socket_finish, "g_socket_listener_accept_socket_finish");
  link(g_socket_listener_add_address, "g_socket_listener_add_address");
  link(g_socket_listener_add_any_inet_port, "g_socket_listener_add_any_inet_port");
  link(g_socket_listener_add_inet_port, "g_socket_listener_add_inet_port");
  link(g_socket_listener_add_socket, "g_socket_listener_add_socket");
  link(g_socket_listener_close, "g_socket_listener_close");
  link(g_socket_listener_set_backlog, "g_socket_listener_set_backlog");

  // SocketService
  link(g_socket_service_get_type, "g_socket_service_get_type");
  link(g_socket_service_new, "g_socket_service_new");
  link(g_socket_service_is_active, "g_socket_service_is_active");
  link(g_socket_service_start, "g_socket_service_start");
  link(g_socket_service_stop, "g_socket_service_stop");

  // SrvTarget
  link(g_srv_target_get_type, "g_srv_target_get_type");
  link(g_srv_target_new, "g_srv_target_new");
  link(g_srv_target_copy, "g_srv_target_copy");
  link(g_srv_target_free, "g_srv_target_free");
  link(g_srv_target_get_hostname, "g_srv_target_get_hostname");
  link(g_srv_target_get_port, "g_srv_target_get_port");
  link(g_srv_target_get_priority, "g_srv_target_get_priority");
  link(g_srv_target_get_weight, "g_srv_target_get_weight");
  link(g_srv_target_list_sort, "g_srv_target_list_sort");

  // StaticResource
  link(g_static_resource_fini, "g_static_resource_fini");
  link(g_static_resource_get_resource, "g_static_resource_get_resource");
  link(g_static_resource_init, "g_static_resource_init");

  // Subprocess
  link(g_subprocess_get_type, "g_subprocess_get_type");
  link(g_subprocess_new, "g_subprocess_new");
  link(g_subprocess_newv, "g_subprocess_newv");
  link(g_subprocess_communicate, "g_subprocess_communicate");
  link(g_subprocess_communicate_async, "g_subprocess_communicate_async");
  link(g_subprocess_communicate_finish, "g_subprocess_communicate_finish");
  link(g_subprocess_communicate_utf8, "g_subprocess_communicate_utf8");
  link(g_subprocess_communicate_utf8_async, "g_subprocess_communicate_utf8_async");
  link(g_subprocess_communicate_utf8_finish, "g_subprocess_communicate_utf8_finish");
  link(g_subprocess_force_exit, "g_subprocess_force_exit");
  link(g_subprocess_get_exit_status, "g_subprocess_get_exit_status");
  link(g_subprocess_get_identifier, "g_subprocess_get_identifier");
  link(g_subprocess_get_if_exited, "g_subprocess_get_if_exited");
  link(g_subprocess_get_if_signaled, "g_subprocess_get_if_signaled");
  link(g_subprocess_get_status, "g_subprocess_get_status");
  link(g_subprocess_get_stderr_pipe, "g_subprocess_get_stderr_pipe");
  link(g_subprocess_get_stdin_pipe, "g_subprocess_get_stdin_pipe");
  link(g_subprocess_get_stdout_pipe, "g_subprocess_get_stdout_pipe");
  link(g_subprocess_get_successful, "g_subprocess_get_successful");
  link(g_subprocess_get_term_sig, "g_subprocess_get_term_sig");
  link(g_subprocess_send_signal, "g_subprocess_send_signal");
  link(g_subprocess_wait, "g_subprocess_wait");
  link(g_subprocess_wait_async, "g_subprocess_wait_async");
  link(g_subprocess_wait_check, "g_subprocess_wait_check");
  link(g_subprocess_wait_check_async, "g_subprocess_wait_check_async");
  link(g_subprocess_wait_check_finish, "g_subprocess_wait_check_finish");
  link(g_subprocess_wait_finish, "g_subprocess_wait_finish");

  // SubprocessLauncher
  link(g_subprocess_launcher_get_type, "g_subprocess_launcher_get_type");
  link(g_subprocess_launcher_new, "g_subprocess_launcher_new");
  link(g_subprocess_launcher_close, "g_subprocess_launcher_close");
  link(g_subprocess_launcher_getenv, "g_subprocess_launcher_getenv");
  link(g_subprocess_launcher_set_child_setup, "g_subprocess_launcher_set_child_setup");
  link(g_subprocess_launcher_set_cwd, "g_subprocess_launcher_set_cwd");
  link(g_subprocess_launcher_set_environ, "g_subprocess_launcher_set_environ");
  link(g_subprocess_launcher_set_flags, "g_subprocess_launcher_set_flags");
  link(g_subprocess_launcher_set_stderr_file_path, "g_subprocess_launcher_set_stderr_file_path");
  link(g_subprocess_launcher_set_stdin_file_path, "g_subprocess_launcher_set_stdin_file_path");
  link(g_subprocess_launcher_set_stdout_file_path, "g_subprocess_launcher_set_stdout_file_path");
  link(g_subprocess_launcher_setenv, "g_subprocess_launcher_setenv");
  link(g_subprocess_launcher_spawn, "g_subprocess_launcher_spawn");
  link(g_subprocess_launcher_spawnv, "g_subprocess_launcher_spawnv");
  link(g_subprocess_launcher_take_fd, "g_subprocess_launcher_take_fd");
  link(g_subprocess_launcher_take_stderr_fd, "g_subprocess_launcher_take_stderr_fd");
  link(g_subprocess_launcher_take_stdin_fd, "g_subprocess_launcher_take_stdin_fd");
  link(g_subprocess_launcher_take_stdout_fd, "g_subprocess_launcher_take_stdout_fd");
  link(g_subprocess_launcher_unsetenv, "g_subprocess_launcher_unsetenv");

  // Task
  link(g_task_get_type, "g_task_get_type");
  link(g_task_new, "g_task_new");
  link(g_task_is_valid, "g_task_is_valid");
  link(g_task_report_error, "g_task_report_error");
  link(g_task_report_new_error, "g_task_report_new_error");
  link(g_task_attach_source, "g_task_attach_source");
  link(g_task_get_cancellable, "g_task_get_cancellable");
  link(g_task_get_check_cancellable, "g_task_get_check_cancellable");
  link(g_task_get_completed, "g_task_get_completed");
  link(g_task_get_context, "g_task_get_context");
  link(g_task_get_name, "g_task_get_name");
  link(g_task_get_priority, "g_task_get_priority");
  link(g_task_get_return_on_cancel, "g_task_get_return_on_cancel");
  link(g_task_get_source_object, "g_task_get_source_object");
  link(g_task_get_source_tag, "g_task_get_source_tag");
  link(g_task_get_task_data, "g_task_get_task_data");
  link(g_task_had_error, "g_task_had_error");
  link(g_task_propagate_boolean, "g_task_propagate_boolean");
  link(g_task_propagate_int, "g_task_propagate_int");
  link(g_task_propagate_pointer, "g_task_propagate_pointer");
  link(g_task_propagate_value, "g_task_propagate_value");
  link(g_task_return_boolean, "g_task_return_boolean");
  link(g_task_return_error, "g_task_return_error");
  link(g_task_return_error_if_cancelled, "g_task_return_error_if_cancelled");
  link(g_task_return_int, "g_task_return_int");
  link(g_task_return_new_error, "g_task_return_new_error");
  link(g_task_return_new_error_literal, "g_task_return_new_error_literal");
  link(g_task_return_pointer, "g_task_return_pointer");
  link(g_task_return_prefixed_error, "g_task_return_prefixed_error");
  link(g_task_return_value, "g_task_return_value");
  link(g_task_run_in_thread, "g_task_run_in_thread");
  link(g_task_run_in_thread_sync, "g_task_run_in_thread_sync");
  link(g_task_set_check_cancellable, "g_task_set_check_cancellable");
  link(g_task_set_name, "g_task_set_name");
  link(g_task_set_priority, "g_task_set_priority");
  link(g_task_set_return_on_cancel, "g_task_set_return_on_cancel");
  link(g_task_set_source_tag, "g_task_set_source_tag");
  link(g_task_set_static_name, "g_task_set_static_name");
  link(g_task_set_task_data, "g_task_set_task_data");

  // TcpConnection
  link(g_tcp_connection_get_type, "g_tcp_connection_get_type");
  link(g_tcp_connection_get_graceful_disconnect, "g_tcp_connection_get_graceful_disconnect");
  link(g_tcp_connection_set_graceful_disconnect, "g_tcp_connection_set_graceful_disconnect");

  // TcpWrapperConnection
  link(g_tcp_wrapper_connection_get_type, "g_tcp_wrapper_connection_get_type");
  link(g_tcp_wrapper_connection_new, "g_tcp_wrapper_connection_new");
  link(g_tcp_wrapper_connection_get_base_io_stream, "g_tcp_wrapper_connection_get_base_io_stream");

  // TestDBus
  link(g_test_dbus_get_type, "g_test_dbus_get_type");
  link(g_test_dbus_new, "g_test_dbus_new");
  link(g_test_dbus_unset, "g_test_dbus_unset");
  link(g_test_dbus_add_service_dir, "g_test_dbus_add_service_dir");
  link(g_test_dbus_down, "g_test_dbus_down");
  link(g_test_dbus_get_bus_address, "g_test_dbus_get_bus_address");
  link(g_test_dbus_get_flags, "g_test_dbus_get_flags");
  link(g_test_dbus_stop, "g_test_dbus_stop");
  link(g_test_dbus_up, "g_test_dbus_up");

  // ThemedIcon
  link(g_themed_icon_get_type, "g_themed_icon_get_type");
  link(g_themed_icon_new, "g_themed_icon_new");
  link(g_themed_icon_new_from_names, "g_themed_icon_new_from_names");
  link(g_themed_icon_new_with_default_fallbacks, "g_themed_icon_new_with_default_fallbacks");
  link(g_themed_icon_append_name, "g_themed_icon_append_name");
  link(g_themed_icon_get_names, "g_themed_icon_get_names");
  link(g_themed_icon_prepend_name, "g_themed_icon_prepend_name");

  // ThreadedResolver
  link(g_threaded_resolver_get_type, "g_threaded_resolver_get_type");

  // ThreadedSocketService
  link(g_threaded_socket_service_get_type, "g_threaded_socket_service_get_type");
  link(g_threaded_socket_service_new, "g_threaded_socket_service_new");

  // TlsBackend
  link(g_tls_backend_get_type, "g_tls_backend_get_type");
  link(g_tls_backend_get_default, "g_tls_backend_get_default");
  link(g_tls_backend_get_certificate_type, "g_tls_backend_get_certificate_type");
  link(g_tls_backend_get_client_connection_type, "g_tls_backend_get_client_connection_type");
  link(g_tls_backend_get_default_database, "g_tls_backend_get_default_database");
  link(g_tls_backend_get_dtls_client_connection_type, "g_tls_backend_get_dtls_client_connection_type");
  link(g_tls_backend_get_dtls_server_connection_type, "g_tls_backend_get_dtls_server_connection_type");
  link(g_tls_backend_get_file_database_type, "g_tls_backend_get_file_database_type");
  link(g_tls_backend_get_server_connection_type, "g_tls_backend_get_server_connection_type");
  link(g_tls_backend_set_default_database, "g_tls_backend_set_default_database");
  link(g_tls_backend_supports_dtls, "g_tls_backend_supports_dtls");
  link(g_tls_backend_supports_tls, "g_tls_backend_supports_tls");

  // TlsCertificate
  link(g_tls_certificate_get_type, "g_tls_certificate_get_type");
  link(g_tls_certificate_new_from_file, "g_tls_certificate_new_from_file");
  link(g_tls_certificate_new_from_file_with_password, "g_tls_certificate_new_from_file_with_password");
  link(g_tls_certificate_new_from_files, "g_tls_certificate_new_from_files");
  link(g_tls_certificate_new_from_pem, "g_tls_certificate_new_from_pem");
  link(g_tls_certificate_new_from_pkcs11_uris, "g_tls_certificate_new_from_pkcs11_uris");
  link(g_tls_certificate_new_from_pkcs12, "g_tls_certificate_new_from_pkcs12");
  link(g_tls_certificate_list_new_from_file, "g_tls_certificate_list_new_from_file");
  link(g_tls_certificate_get_dns_names, "g_tls_certificate_get_dns_names");
  link(g_tls_certificate_get_ip_addresses, "g_tls_certificate_get_ip_addresses");
  link(g_tls_certificate_get_issuer, "g_tls_certificate_get_issuer");
  link(g_tls_certificate_get_issuer_name, "g_tls_certificate_get_issuer_name");
  link(g_tls_certificate_get_not_valid_after, "g_tls_certificate_get_not_valid_after");
  link(g_tls_certificate_get_not_valid_before, "g_tls_certificate_get_not_valid_before");
  link(g_tls_certificate_get_subject_name, "g_tls_certificate_get_subject_name");
  link(g_tls_certificate_is_same, "g_tls_certificate_is_same");
  link(g_tls_certificate_verify, "g_tls_certificate_verify");

  // TlsClientConnection
  link(g_tls_client_connection_get_type, "g_tls_client_connection_get_type");
  link(g_tls_client_connection_new, "g_tls_client_connection_new");
  link(g_tls_client_connection_copy_session_state, "g_tls_client_connection_copy_session_state");
  link(g_tls_client_connection_get_accepted_cas, "g_tls_client_connection_get_accepted_cas");
  link(g_tls_client_connection_get_server_identity, "g_tls_client_connection_get_server_identity");
  link(g_tls_client_connection_get_use_ssl3, "g_tls_client_connection_get_use_ssl3");
  link(g_tls_client_connection_get_validation_flags, "g_tls_client_connection_get_validation_flags");
  link(g_tls_client_connection_set_server_identity, "g_tls_client_connection_set_server_identity");
  link(g_tls_client_connection_set_use_ssl3, "g_tls_client_connection_set_use_ssl3");
  link(g_tls_client_connection_set_validation_flags, "g_tls_client_connection_set_validation_flags");

  // TlsConnection
  link(g_tls_connection_get_type, "g_tls_connection_get_type");
  link(g_tls_connection_emit_accept_certificate, "g_tls_connection_emit_accept_certificate");
  link(g_tls_connection_get_certificate, "g_tls_connection_get_certificate");
  link(g_tls_connection_get_channel_binding_data, "g_tls_connection_get_channel_binding_data");
  link(g_tls_connection_get_ciphersuite_name, "g_tls_connection_get_ciphersuite_name");
  link(g_tls_connection_get_database, "g_tls_connection_get_database");
  link(g_tls_connection_get_interaction, "g_tls_connection_get_interaction");
  link(g_tls_connection_get_negotiated_protocol, "g_tls_connection_get_negotiated_protocol");
  link(g_tls_connection_get_peer_certificate, "g_tls_connection_get_peer_certificate");
  link(g_tls_connection_get_peer_certificate_errors, "g_tls_connection_get_peer_certificate_errors");
  link(g_tls_connection_get_protocol_version, "g_tls_connection_get_protocol_version");
  link(g_tls_connection_get_rehandshake_mode, "g_tls_connection_get_rehandshake_mode");
  link(g_tls_connection_get_require_close_notify, "g_tls_connection_get_require_close_notify");
  link(g_tls_connection_get_use_system_certdb, "g_tls_connection_get_use_system_certdb");
  link(g_tls_connection_handshake, "g_tls_connection_handshake");
  link(g_tls_connection_handshake_async, "g_tls_connection_handshake_async");
  link(g_tls_connection_handshake_finish, "g_tls_connection_handshake_finish");
  link(g_tls_connection_set_advertised_protocols, "g_tls_connection_set_advertised_protocols");
  link(g_tls_connection_set_certificate, "g_tls_connection_set_certificate");
  link(g_tls_connection_set_database, "g_tls_connection_set_database");
  link(g_tls_connection_set_interaction, "g_tls_connection_set_interaction");
  link(g_tls_connection_set_rehandshake_mode, "g_tls_connection_set_rehandshake_mode");
  link(g_tls_connection_set_require_close_notify, "g_tls_connection_set_require_close_notify");
  link(g_tls_connection_set_use_system_certdb, "g_tls_connection_set_use_system_certdb");

  // TlsDatabase
  link(g_tls_database_get_type, "g_tls_database_get_type");
  link(g_tls_database_create_certificate_handle, "g_tls_database_create_certificate_handle");
  link(g_tls_database_lookup_certificate_for_handle, "g_tls_database_lookup_certificate_for_handle");
  link(g_tls_database_lookup_certificate_for_handle_async, "g_tls_database_lookup_certificate_for_handle_async");
  link(g_tls_database_lookup_certificate_for_handle_finish, "g_tls_database_lookup_certificate_for_handle_finish");
  link(g_tls_database_lookup_certificate_issuer, "g_tls_database_lookup_certificate_issuer");
  link(g_tls_database_lookup_certificate_issuer_async, "g_tls_database_lookup_certificate_issuer_async");
  link(g_tls_database_lookup_certificate_issuer_finish, "g_tls_database_lookup_certificate_issuer_finish");
  link(g_tls_database_lookup_certificates_issued_by, "g_tls_database_lookup_certificates_issued_by");
  link(g_tls_database_lookup_certificates_issued_by_async, "g_tls_database_lookup_certificates_issued_by_async");
  link(g_tls_database_lookup_certificates_issued_by_finish, "g_tls_database_lookup_certificates_issued_by_finish");
  link(g_tls_database_verify_chain, "g_tls_database_verify_chain");
  link(g_tls_database_verify_chain_async, "g_tls_database_verify_chain_async");
  link(g_tls_database_verify_chain_finish, "g_tls_database_verify_chain_finish");

  // TlsFileDatabase
  link(g_tls_file_database_get_type, "g_tls_file_database_get_type");
  link(g_tls_file_database_new, "g_tls_file_database_new");

  // TlsInteraction
  link(g_tls_interaction_get_type, "g_tls_interaction_get_type");
  link(g_tls_interaction_ask_password, "g_tls_interaction_ask_password");
  link(g_tls_interaction_ask_password_async, "g_tls_interaction_ask_password_async");
  link(g_tls_interaction_ask_password_finish, "g_tls_interaction_ask_password_finish");
  link(g_tls_interaction_invoke_ask_password, "g_tls_interaction_invoke_ask_password");
  link(g_tls_interaction_invoke_request_certificate, "g_tls_interaction_invoke_request_certificate");
  link(g_tls_interaction_request_certificate, "g_tls_interaction_request_certificate");
  link(g_tls_interaction_request_certificate_async, "g_tls_interaction_request_certificate_async");
  link(g_tls_interaction_request_certificate_finish, "g_tls_interaction_request_certificate_finish");

  // TlsPassword
  link(g_tls_password_get_type, "g_tls_password_get_type");
  link(g_tls_password_new, "g_tls_password_new");
  link(g_tls_password_get_description, "g_tls_password_get_description");
  link(g_tls_password_get_flags, "g_tls_password_get_flags");
  link(g_tls_password_get_value, "g_tls_password_get_value");
  link(g_tls_password_get_warning, "g_tls_password_get_warning");
  link(g_tls_password_set_description, "g_tls_password_set_description");
  link(g_tls_password_set_flags, "g_tls_password_set_flags");
  link(g_tls_password_set_value, "g_tls_password_set_value");
  link(g_tls_password_set_value_full, "g_tls_password_set_value_full");
  link(g_tls_password_set_warning, "g_tls_password_set_warning");

  // TlsServerConnection
  link(g_tls_server_connection_get_type, "g_tls_server_connection_get_type");
  link(g_tls_server_connection_new, "g_tls_server_connection_new");

  // UnixConnection
  link(g_unix_connection_get_type, "g_unix_connection_get_type");
  link(g_unix_connection_receive_credentials, "g_unix_connection_receive_credentials");
  link(g_unix_connection_receive_credentials_async, "g_unix_connection_receive_credentials_async");
  link(g_unix_connection_receive_credentials_finish, "g_unix_connection_receive_credentials_finish");
  link(g_unix_connection_receive_fd, "g_unix_connection_receive_fd");
  link(g_unix_connection_send_credentials, "g_unix_connection_send_credentials");
  link(g_unix_connection_send_credentials_async, "g_unix_connection_send_credentials_async");
  link(g_unix_connection_send_credentials_finish, "g_unix_connection_send_credentials_finish");
  link(g_unix_connection_send_fd, "g_unix_connection_send_fd");

  // UnixCredentialsMessage
  link(g_unix_credentials_message_get_type, "g_unix_credentials_message_get_type");
  link(g_unix_credentials_message_new, "g_unix_credentials_message_new");
  link(g_unix_credentials_message_new_with_credentials, "g_unix_credentials_message_new_with_credentials");
  link(g_unix_credentials_message_is_supported, "g_unix_credentials_message_is_supported");
  link(g_unix_credentials_message_get_credentials, "g_unix_credentials_message_get_credentials");

  // UnixFDList
  link(g_unix_fd_list_get_type, "g_unix_fd_list_get_type");
  link(g_unix_fd_list_new, "g_unix_fd_list_new");
  link(g_unix_fd_list_new_from_array, "g_unix_fd_list_new_from_array");
  link(g_unix_fd_list_append, "g_unix_fd_list_append");
  link(g_unix_fd_list_get, "g_unix_fd_list_get");
  link(g_unix_fd_list_get_length, "g_unix_fd_list_get_length");
  link(g_unix_fd_list_peek_fds, "g_unix_fd_list_peek_fds");
  link(g_unix_fd_list_steal_fds, "g_unix_fd_list_steal_fds");

  // UnixFDMessage
  link(g_unix_fd_message_get_type, "g_unix_fd_message_get_type");
  link(g_unix_fd_message_new, "g_unix_fd_message_new");
  link(g_unix_fd_message_new_with_fd_list, "g_unix_fd_message_new_with_fd_list");
  link(g_unix_fd_message_append_fd, "g_unix_fd_message_append_fd");
  link(g_unix_fd_message_get_fd_list, "g_unix_fd_message_get_fd_list");
  link(g_unix_fd_message_steal_fds, "g_unix_fd_message_steal_fds");

  // UnixInputStream
  link(g_unix_input_stream_get_type, "g_unix_input_stream_get_type");
  link(g_unix_input_stream_new, "g_unix_input_stream_new");
  link(g_unix_input_stream_get_close_fd, "g_unix_input_stream_get_close_fd");
  link(g_unix_input_stream_get_fd, "g_unix_input_stream_get_fd");
  link(g_unix_input_stream_set_close_fd, "g_unix_input_stream_set_close_fd");

  // UnixMountEntry
  link(g_unix_mount_entry_get_type, "g_unix_mount_entry_get_type");

  // UnixMountMonitor
  link(g_unix_mount_monitor_get_type, "g_unix_mount_monitor_get_type");
  link(g_unix_mount_monitor_new, "g_unix_mount_monitor_new");
  link(g_unix_mount_monitor_get, "g_unix_mount_monitor_get");
  link(g_unix_mount_monitor_set_rate_limit, "g_unix_mount_monitor_set_rate_limit");

  // UnixMountPoint
  link(g_unix_mount_point_get_type, "g_unix_mount_point_get_type");
  link(g_unix_mount_point_compare, "g_unix_mount_point_compare");
  link(g_unix_mount_point_copy, "g_unix_mount_point_copy");
  link(g_unix_mount_point_free, "g_unix_mount_point_free");
  link(g_unix_mount_point_get_device_path, "g_unix_mount_point_get_device_path");
  link(g_unix_mount_point_get_fs_type, "g_unix_mount_point_get_fs_type");
  link(g_unix_mount_point_get_mount_path, "g_unix_mount_point_get_mount_path");
  link(g_unix_mount_point_get_options, "g_unix_mount_point_get_options");
  link(g_unix_mount_point_guess_can_eject, "g_unix_mount_point_guess_can_eject");
  link(g_unix_mount_point_guess_icon, "g_unix_mount_point_guess_icon");
  link(g_unix_mount_point_guess_name, "g_unix_mount_point_guess_name");
  link(g_unix_mount_point_guess_symbolic_icon, "g_unix_mount_point_guess_symbolic_icon");
  link(g_unix_mount_point_is_loopback, "g_unix_mount_point_is_loopback");
  link(g_unix_mount_point_is_readonly, "g_unix_mount_point_is_readonly");
  link(g_unix_mount_point_is_user_mountable, "g_unix_mount_point_is_user_mountable");
  link(g_unix_mount_point_at, "g_unix_mount_point_at");

  // UnixOutputStream
  link(g_unix_output_stream_get_type, "g_unix_output_stream_get_type");
  link(g_unix_output_stream_new, "g_unix_output_stream_new");
  link(g_unix_output_stream_get_close_fd, "g_unix_output_stream_get_close_fd");
  link(g_unix_output_stream_get_fd, "g_unix_output_stream_get_fd");
  link(g_unix_output_stream_set_close_fd, "g_unix_output_stream_set_close_fd");

  // UnixSocketAddress
  link(g_unix_socket_address_get_type, "g_unix_socket_address_get_type");
  link(g_unix_socket_address_new, "g_unix_socket_address_new");
  link(g_unix_socket_address_new_abstract, "g_unix_socket_address_new_abstract");
  link(g_unix_socket_address_new_with_type, "g_unix_socket_address_new_with_type");
  link(g_unix_socket_address_abstract_names_supported, "g_unix_socket_address_abstract_names_supported");
  link(g_unix_socket_address_get_address_type, "g_unix_socket_address_get_address_type");
  link(g_unix_socket_address_get_is_abstract, "g_unix_socket_address_get_is_abstract");
  link(g_unix_socket_address_get_path, "g_unix_socket_address_get_path");
  link(g_unix_socket_address_get_path_len, "g_unix_socket_address_get_path_len");

  // Vfs
  link(g_vfs_get_type, "g_vfs_get_type");
  link(g_vfs_get_default, "g_vfs_get_default");
  link(g_vfs_get_local, "g_vfs_get_local");
  link(g_vfs_get_file_for_path, "g_vfs_get_file_for_path");
  link(g_vfs_get_file_for_uri, "g_vfs_get_file_for_uri");
  link(g_vfs_get_supported_uri_schemes, "g_vfs_get_supported_uri_schemes");
  link(g_vfs_is_active, "g_vfs_is_active");
  link(g_vfs_parse_name, "g_vfs_parse_name");
  link(g_vfs_register_uri_scheme, "g_vfs_register_uri_scheme");
  link(g_vfs_unregister_uri_scheme, "g_vfs_unregister_uri_scheme");

  // Volume
  link(g_volume_get_type, "g_volume_get_type");
  link(g_volume_can_eject, "g_volume_can_eject");
  link(g_volume_can_mount, "g_volume_can_mount");
  link(g_volume_eject, "g_volume_eject");
  link(g_volume_eject_finish, "g_volume_eject_finish");
  link(g_volume_eject_with_operation, "g_volume_eject_with_operation");
  link(g_volume_eject_with_operation_finish, "g_volume_eject_with_operation_finish");
  link(g_volume_enumerate_identifiers, "g_volume_enumerate_identifiers");
  link(g_volume_get_activation_root, "g_volume_get_activation_root");
  link(g_volume_get_drive, "g_volume_get_drive");
  link(g_volume_get_icon, "g_volume_get_icon");
  link(g_volume_get_identifier, "g_volume_get_identifier");
  link(g_volume_get_mount, "g_volume_get_mount");
  link(g_volume_get_name, "g_volume_get_name");
  link(g_volume_get_sort_key, "g_volume_get_sort_key");
  link(g_volume_get_symbolic_icon, "g_volume_get_symbolic_icon");
  link(g_volume_get_uuid, "g_volume_get_uuid");
  link(g_volume_mount, "g_volume_mount");
  link(g_volume_mount_finish, "g_volume_mount_finish");
  link(g_volume_should_automount, "g_volume_should_automount");

  // VolumeMonitor
  link(g_volume_monitor_get_type, "g_volume_monitor_get_type");
  link(g_volume_monitor_adopt_orphan_mount, "g_volume_monitor_adopt_orphan_mount");
  link(g_volume_monitor_get, "g_volume_monitor_get");
  link(g_volume_monitor_get_connected_drives, "g_volume_monitor_get_connected_drives");
  link(g_volume_monitor_get_mount_for_uuid, "g_volume_monitor_get_mount_for_uuid");
  link(g_volume_monitor_get_mounts, "g_volume_monitor_get_mounts");
  link(g_volume_monitor_get_volume_for_uuid, "g_volume_monitor_get_volume_for_uuid");
  link(g_volume_monitor_get_volumes, "g_volume_monitor_get_volumes");

  // ZlibCompressor
  link(g_zlib_compressor_get_type, "g_zlib_compressor_get_type");
  link(g_zlib_compressor_new, "g_zlib_compressor_new");
  link(g_zlib_compressor_get_file_info, "g_zlib_compressor_get_file_info");
  link(g_zlib_compressor_set_file_info, "g_zlib_compressor_set_file_info");

  // ZlibDecompressor
  link(g_zlib_decompressor_get_type, "g_zlib_decompressor_get_type");
  link(g_zlib_decompressor_new, "g_zlib_decompressor_new");
  link(g_zlib_decompressor_get_file_info, "g_zlib_decompressor_get_file_info");
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
