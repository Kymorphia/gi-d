module Gtk.c.functions;

import Gtk.c.types;
public import Gdk.c.types;
public import Gsk.c.types;

version(Windows)
  private immutable LIBS = ["libgtk-4-1.dll;gtk-4-1.dll;gtk-4.dll"];
version(OSX)
  private immutable LIBS = ["libgtk-4.1.dylib"];
else
  private immutable LIBS = ["libgtk-4.so.1"];

__gshared extern(C)
{
  // ATContext
  GType function() c_gtk_at_context_get_type;
  GtkATContext* function(GtkAccessibleRole accessibleRole, GtkAccessible* accessible, GdkDisplay* display) c_gtk_at_context_create;
  GtkAccessible* function(GtkATContext* self) c_gtk_at_context_get_accessible;
  GtkAccessibleRole function(GtkATContext* self) c_gtk_at_context_get_accessible_role;

  // AboutDialog
  GType function() c_gtk_about_dialog_get_type;
  GtkWidget* function() c_gtk_about_dialog_new;
  void function(GtkAboutDialog* about, const(char)* sectionName, const(char*)* people) c_gtk_about_dialog_add_credit_section;
  const(char*)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_artists;
  const(char*)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_authors;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_comments;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_copyright;
  const(char*)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_documenters;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_license;
  GtkLicense function(GtkAboutDialog* about) c_gtk_about_dialog_get_license_type;
  GdkPaintable* function(GtkAboutDialog* about) c_gtk_about_dialog_get_logo;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_logo_icon_name;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_program_name;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_system_information;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_translator_credits;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_version;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_website;
  const(char)* function(GtkAboutDialog* about) c_gtk_about_dialog_get_website_label;
  bool function(GtkAboutDialog* about) c_gtk_about_dialog_get_wrap_license;
  void function(GtkAboutDialog* about, const(char*)* artists) c_gtk_about_dialog_set_artists;
  void function(GtkAboutDialog* about, const(char*)* authors) c_gtk_about_dialog_set_authors;
  void function(GtkAboutDialog* about, const(char)* comments) c_gtk_about_dialog_set_comments;
  void function(GtkAboutDialog* about, const(char)* copyright) c_gtk_about_dialog_set_copyright;
  void function(GtkAboutDialog* about, const(char*)* documenters) c_gtk_about_dialog_set_documenters;
  void function(GtkAboutDialog* about, const(char)* license) c_gtk_about_dialog_set_license;
  void function(GtkAboutDialog* about, GtkLicense licenseType) c_gtk_about_dialog_set_license_type;
  void function(GtkAboutDialog* about, GdkPaintable* logo) c_gtk_about_dialog_set_logo;
  void function(GtkAboutDialog* about, const(char)* iconName) c_gtk_about_dialog_set_logo_icon_name;
  void function(GtkAboutDialog* about, const(char)* name) c_gtk_about_dialog_set_program_name;
  void function(GtkAboutDialog* about, const(char)* systemInformation) c_gtk_about_dialog_set_system_information;
  void function(GtkAboutDialog* about, const(char)* translatorCredits) c_gtk_about_dialog_set_translator_credits;
  void function(GtkAboutDialog* about, const(char)* version_) c_gtk_about_dialog_set_version;
  void function(GtkAboutDialog* about, const(char)* website) c_gtk_about_dialog_set_website;
  void function(GtkAboutDialog* about, const(char)* websiteLabel) c_gtk_about_dialog_set_website_label;
  void function(GtkAboutDialog* about, bool wrapLicense) c_gtk_about_dialog_set_wrap_license;

  // Accessible
  GType function() c_gtk_accessible_get_type;
  void function(GtkAccessible* self, const(char)* message, GtkAccessibleAnnouncementPriority priority) c_gtk_accessible_announce;
  GtkAccessible* function(GtkAccessible* self) c_gtk_accessible_get_accessible_parent;
  GtkAccessibleRole function(GtkAccessible* self) c_gtk_accessible_get_accessible_role;
  GtkATContext* function(GtkAccessible* self) c_gtk_accessible_get_at_context;
  bool function(GtkAccessible* self, int* x, int* y, int* width, int* height) c_gtk_accessible_get_bounds;
  GtkAccessible* function(GtkAccessible* self) c_gtk_accessible_get_first_accessible_child;
  GtkAccessible* function(GtkAccessible* self) c_gtk_accessible_get_next_accessible_sibling;
  bool function(GtkAccessible* self, GtkAccessiblePlatformState state) c_gtk_accessible_get_platform_state;
  void function(GtkAccessible* self, GtkAccessibleProperty property) c_gtk_accessible_reset_property;
  void function(GtkAccessible* self, GtkAccessibleRelation relation) c_gtk_accessible_reset_relation;
  void function(GtkAccessible* self, GtkAccessibleState state) c_gtk_accessible_reset_state;
  void function(GtkAccessible* self, GtkAccessible* parent, GtkAccessible* nextSibling) c_gtk_accessible_set_accessible_parent;
  void function(GtkAccessible* self, GtkAccessible* newSibling) c_gtk_accessible_update_next_accessible_sibling;
  void function(GtkAccessible* self, GtkAccessibleProperty firstProperty,  ...) c_gtk_accessible_update_property;
  void function(GtkAccessible* self, int nProperties, GtkAccessibleProperty* properties, const(GValue)* values) c_gtk_accessible_update_property_value;
  void function(GtkAccessible* self, GtkAccessibleRelation firstRelation,  ...) c_gtk_accessible_update_relation;
  void function(GtkAccessible* self, int nRelations, GtkAccessibleRelation* relations, const(GValue)* values) c_gtk_accessible_update_relation_value;
  void function(GtkAccessible* self, GtkAccessibleState firstState,  ...) c_gtk_accessible_update_state;
  void function(GtkAccessible* self, int nStates, GtkAccessibleState* states, const(GValue)* values) c_gtk_accessible_update_state_value;

  // AccessibleList
  GType function() c_gtk_accessible_list_get_type;
  GtkAccessibleList* function(GtkAccessible** accessibles, size_t nAccessibles) c_gtk_accessible_list_new_from_array;
  GtkAccessibleList* function(GList* list) c_gtk_accessible_list_new_from_list;
  GList* function(GtkAccessibleList* accessibleList) c_gtk_accessible_list_get_objects;

  // AccessibleRange
  GType function() c_gtk_accessible_range_get_type;

  // AccessibleText
  GType function() c_gtk_accessible_text_get_type;
  void function(GtkAccessibleText* self) c_gtk_accessible_text_update_caret_position;
  void function(GtkAccessibleText* self, GtkAccessibleTextContentChange change, uint start, uint end) c_gtk_accessible_text_update_contents;
  void function(GtkAccessibleText* self) c_gtk_accessible_text_update_selection_bound;

  // ActionBar
  GType function() c_gtk_action_bar_get_type;
  GtkWidget* function() c_gtk_action_bar_new;
  GtkWidget* function(GtkActionBar* actionBar) c_gtk_action_bar_get_center_widget;
  bool function(GtkActionBar* actionBar) c_gtk_action_bar_get_revealed;
  void function(GtkActionBar* actionBar, GtkWidget* child) c_gtk_action_bar_pack_end;
  void function(GtkActionBar* actionBar, GtkWidget* child) c_gtk_action_bar_pack_start;
  void function(GtkActionBar* actionBar, GtkWidget* child) c_gtk_action_bar_remove;
  void function(GtkActionBar* actionBar, GtkWidget* centerWidget) c_gtk_action_bar_set_center_widget;
  void function(GtkActionBar* actionBar, bool revealed) c_gtk_action_bar_set_revealed;

  // Actionable
  GType function() c_gtk_actionable_get_type;
  const(char)* function(GtkActionable* actionable) c_gtk_actionable_get_action_name;
  VariantC* function(GtkActionable* actionable) c_gtk_actionable_get_action_target_value;
  void function(GtkActionable* actionable, const(char)* actionName) c_gtk_actionable_set_action_name;
  void function(GtkActionable* actionable, const(char)* formatString,  ...) c_gtk_actionable_set_action_target;
  void function(GtkActionable* actionable, VariantC* targetValue) c_gtk_actionable_set_action_target_value;
  void function(GtkActionable* actionable, const(char)* detailedActionName) c_gtk_actionable_set_detailed_action_name;

  // ActivateAction
  GType function() c_gtk_activate_action_get_type;
  GtkShortcutAction* function() c_gtk_activate_action_get;

  // Adjustment
  GType function() c_gtk_adjustment_get_type;
  GtkAdjustment* function(double value, double lower, double upper, double stepIncrement, double pageIncrement, double pageSize) c_gtk_adjustment_new;
  void function(GtkAdjustment* adjustment, double lower, double upper) c_gtk_adjustment_clamp_page;
  void function(GtkAdjustment* adjustment, double value, double lower, double upper, double stepIncrement, double pageIncrement, double pageSize) c_gtk_adjustment_configure;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_lower;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_minimum_increment;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_page_increment;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_page_size;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_step_increment;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_upper;
  double function(GtkAdjustment* adjustment) c_gtk_adjustment_get_value;
  void function(GtkAdjustment* adjustment, double lower) c_gtk_adjustment_set_lower;
  void function(GtkAdjustment* adjustment, double pageIncrement) c_gtk_adjustment_set_page_increment;
  void function(GtkAdjustment* adjustment, double pageSize) c_gtk_adjustment_set_page_size;
  void function(GtkAdjustment* adjustment, double stepIncrement) c_gtk_adjustment_set_step_increment;
  void function(GtkAdjustment* adjustment, double upper) c_gtk_adjustment_set_upper;
  void function(GtkAdjustment* adjustment, double value) c_gtk_adjustment_set_value;

  // AlertDialog
  GType function() c_gtk_alert_dialog_get_type;
  GtkAlertDialog* function(const(char)* format,  ...) c_gtk_alert_dialog_new;
  void function(GtkAlertDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_alert_dialog_choose;
  int function(GtkAlertDialog* self, GAsyncResult* result, GError** _err) c_gtk_alert_dialog_choose_finish;
  const(char*)* function(GtkAlertDialog* self) c_gtk_alert_dialog_get_buttons;
  int function(GtkAlertDialog* self) c_gtk_alert_dialog_get_cancel_button;
  int function(GtkAlertDialog* self) c_gtk_alert_dialog_get_default_button;
  const(char)* function(GtkAlertDialog* self) c_gtk_alert_dialog_get_detail;
  const(char)* function(GtkAlertDialog* self) c_gtk_alert_dialog_get_message;
  bool function(GtkAlertDialog* self) c_gtk_alert_dialog_get_modal;
  void function(GtkAlertDialog* self, const(char*)* labels) c_gtk_alert_dialog_set_buttons;
  void function(GtkAlertDialog* self, int button) c_gtk_alert_dialog_set_cancel_button;
  void function(GtkAlertDialog* self, int button) c_gtk_alert_dialog_set_default_button;
  void function(GtkAlertDialog* self, const(char)* detail) c_gtk_alert_dialog_set_detail;
  void function(GtkAlertDialog* self, const(char)* message) c_gtk_alert_dialog_set_message;
  void function(GtkAlertDialog* self, bool modal) c_gtk_alert_dialog_set_modal;
  void function(GtkAlertDialog* self, GtkWindow* parent) c_gtk_alert_dialog_show;

  // AlternativeTrigger
  GType function() c_gtk_alternative_trigger_get_type;
  GtkShortcutTrigger* function(GtkShortcutTrigger* first, GtkShortcutTrigger* second) c_gtk_alternative_trigger_new;
  GtkShortcutTrigger* function(GtkAlternativeTrigger* self) c_gtk_alternative_trigger_get_first;
  GtkShortcutTrigger* function(GtkAlternativeTrigger* self) c_gtk_alternative_trigger_get_second;

  // AnyFilter
  GType function() c_gtk_any_filter_get_type;
  GtkAnyFilter* function() c_gtk_any_filter_new;

  // AppChooser
  GType function() c_gtk_app_chooser_get_type;
  GAppInfo* function(GtkAppChooser* self) c_gtk_app_chooser_get_app_info;
  char* function(GtkAppChooser* self) c_gtk_app_chooser_get_content_type;
  void function(GtkAppChooser* self) c_gtk_app_chooser_refresh;

  // AppChooserButton
  GType function() c_gtk_app_chooser_button_get_type;
  GtkWidget* function(const(char)* contentType) c_gtk_app_chooser_button_new;
  void function(GtkAppChooserButton* self, const(char)* name, const(char)* label, GIcon* icon) c_gtk_app_chooser_button_append_custom_item;
  void function(GtkAppChooserButton* self) c_gtk_app_chooser_button_append_separator;
  const(char)* function(GtkAppChooserButton* self) c_gtk_app_chooser_button_get_heading;
  bool function(GtkAppChooserButton* self) c_gtk_app_chooser_button_get_modal;
  bool function(GtkAppChooserButton* self) c_gtk_app_chooser_button_get_show_default_item;
  bool function(GtkAppChooserButton* self) c_gtk_app_chooser_button_get_show_dialog_item;
  void function(GtkAppChooserButton* self, const(char)* name) c_gtk_app_chooser_button_set_active_custom_item;
  void function(GtkAppChooserButton* self, const(char)* heading) c_gtk_app_chooser_button_set_heading;
  void function(GtkAppChooserButton* self, bool modal) c_gtk_app_chooser_button_set_modal;
  void function(GtkAppChooserButton* self, bool setting) c_gtk_app_chooser_button_set_show_default_item;
  void function(GtkAppChooserButton* self, bool setting) c_gtk_app_chooser_button_set_show_dialog_item;

  // AppChooserDialog
  GType function() c_gtk_app_chooser_dialog_get_type;
  GtkWidget* function(GtkWindow* parent, GtkDialogFlags flags, GFile* file) c_gtk_app_chooser_dialog_new;
  GtkWidget* function(GtkWindow* parent, GtkDialogFlags flags, const(char)* contentType) c_gtk_app_chooser_dialog_new_for_content_type;
  const(char)* function(GtkAppChooserDialog* self) c_gtk_app_chooser_dialog_get_heading;
  GtkWidget* function(GtkAppChooserDialog* self) c_gtk_app_chooser_dialog_get_widget;
  void function(GtkAppChooserDialog* self, const(char)* heading) c_gtk_app_chooser_dialog_set_heading;

  // AppChooserWidget
  GType function() c_gtk_app_chooser_widget_get_type;
  GtkWidget* function(const(char)* contentType) c_gtk_app_chooser_widget_new;
  const(char)* function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_default_text;
  bool function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_show_all;
  bool function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_show_default;
  bool function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_show_fallback;
  bool function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_show_other;
  bool function(GtkAppChooserWidget* self) c_gtk_app_chooser_widget_get_show_recommended;
  void function(GtkAppChooserWidget* self, const(char)* text) c_gtk_app_chooser_widget_set_default_text;
  void function(GtkAppChooserWidget* self, bool setting) c_gtk_app_chooser_widget_set_show_all;
  void function(GtkAppChooserWidget* self, bool setting) c_gtk_app_chooser_widget_set_show_default;
  void function(GtkAppChooserWidget* self, bool setting) c_gtk_app_chooser_widget_set_show_fallback;
  void function(GtkAppChooserWidget* self, bool setting) c_gtk_app_chooser_widget_set_show_other;
  void function(GtkAppChooserWidget* self, bool setting) c_gtk_app_chooser_widget_set_show_recommended;

  // Application
  GType function() c_gtk_application_get_type;
  GtkApplication* function(const(char)* applicationId, GApplicationFlags flags) c_gtk_application_new;
  void function(GtkApplication* application, GtkWindow* window) c_gtk_application_add_window;
  char** function(GtkApplication* application, const(char)* detailedActionName) c_gtk_application_get_accels_for_action;
  char** function(GtkApplication* application, const(char)* accel) c_gtk_application_get_actions_for_accel;
  GtkWindow* function(GtkApplication* application) c_gtk_application_get_active_window;
  GMenu* function(GtkApplication* application, const(char)* id) c_gtk_application_get_menu_by_id;
  GMenuModel* function(GtkApplication* application) c_gtk_application_get_menubar;
  GtkWindow* function(GtkApplication* application, uint id) c_gtk_application_get_window_by_id;
  GList* function(GtkApplication* application) c_gtk_application_get_windows;
  uint function(GtkApplication* application, GtkWindow* window, GtkApplicationInhibitFlags flags, const(char)* reason) c_gtk_application_inhibit;
  char** function(GtkApplication* application) c_gtk_application_list_action_descriptions;
  void function(GtkApplication* application, GtkWindow* window) c_gtk_application_remove_window;
  void function(GtkApplication* application, const(char)* detailedActionName, const(char*)* accels) c_gtk_application_set_accels_for_action;
  void function(GtkApplication* application, GMenuModel* menubar) c_gtk_application_set_menubar;
  void function(GtkApplication* application, uint cookie) c_gtk_application_uninhibit;

  // ApplicationWindow
  GType function() c_gtk_application_window_get_type;
  GtkWidget* function(GtkApplication* application) c_gtk_application_window_new;
  GtkShortcutsWindow* function(GtkApplicationWindow* window) c_gtk_application_window_get_help_overlay;
  uint function(GtkApplicationWindow* window) c_gtk_application_window_get_id;
  bool function(GtkApplicationWindow* window) c_gtk_application_window_get_show_menubar;
  void function(GtkApplicationWindow* window, GtkShortcutsWindow* helpOverlay) c_gtk_application_window_set_help_overlay;
  void function(GtkApplicationWindow* window, bool showMenubar) c_gtk_application_window_set_show_menubar;

  // AspectFrame
  GType function() c_gtk_aspect_frame_get_type;
  GtkWidget* function(float xalign, float yalign, float ratio, bool obeyChild) c_gtk_aspect_frame_new;
  GtkWidget* function(GtkAspectFrame* self) c_gtk_aspect_frame_get_child;
  bool function(GtkAspectFrame* self) c_gtk_aspect_frame_get_obey_child;
  float function(GtkAspectFrame* self) c_gtk_aspect_frame_get_ratio;
  float function(GtkAspectFrame* self) c_gtk_aspect_frame_get_xalign;
  float function(GtkAspectFrame* self) c_gtk_aspect_frame_get_yalign;
  void function(GtkAspectFrame* self, GtkWidget* child) c_gtk_aspect_frame_set_child;
  void function(GtkAspectFrame* self, bool obeyChild) c_gtk_aspect_frame_set_obey_child;
  void function(GtkAspectFrame* self, float ratio) c_gtk_aspect_frame_set_ratio;
  void function(GtkAspectFrame* self, float xalign) c_gtk_aspect_frame_set_xalign;
  void function(GtkAspectFrame* self, float yalign) c_gtk_aspect_frame_set_yalign;

  // Assistant
  GType function() c_gtk_assistant_get_type;
  GtkWidget* function() c_gtk_assistant_new;
  void function(GtkAssistant* assistant, GtkWidget* child) c_gtk_assistant_add_action_widget;
  int function(GtkAssistant* assistant, GtkWidget* page) c_gtk_assistant_append_page;
  void function(GtkAssistant* assistant) c_gtk_assistant_commit;
  int function(GtkAssistant* assistant) c_gtk_assistant_get_current_page;
  int function(GtkAssistant* assistant) c_gtk_assistant_get_n_pages;
  GtkWidget* function(GtkAssistant* assistant, int pageNum) c_gtk_assistant_get_nth_page;
  GtkAssistantPage* function(GtkAssistant* assistant, GtkWidget* child) c_gtk_assistant_get_page;
  bool function(GtkAssistant* assistant, GtkWidget* page) c_gtk_assistant_get_page_complete;
  const(char)* function(GtkAssistant* assistant, GtkWidget* page) c_gtk_assistant_get_page_title;
  GtkAssistantPageType function(GtkAssistant* assistant, GtkWidget* page) c_gtk_assistant_get_page_type;
  GListModel* function(GtkAssistant* assistant) c_gtk_assistant_get_pages;
  int function(GtkAssistant* assistant, GtkWidget* page, int position) c_gtk_assistant_insert_page;
  void function(GtkAssistant* assistant) c_gtk_assistant_next_page;
  int function(GtkAssistant* assistant, GtkWidget* page) c_gtk_assistant_prepend_page;
  void function(GtkAssistant* assistant) c_gtk_assistant_previous_page;
  void function(GtkAssistant* assistant, GtkWidget* child) c_gtk_assistant_remove_action_widget;
  void function(GtkAssistant* assistant, int pageNum) c_gtk_assistant_remove_page;
  void function(GtkAssistant* assistant, int pageNum) c_gtk_assistant_set_current_page;
  void function(GtkAssistant* assistant, GtkAssistantPageFunc pageFunc, void* data, GDestroyNotify destroy) c_gtk_assistant_set_forward_page_func;
  void function(GtkAssistant* assistant, GtkWidget* page, bool complete) c_gtk_assistant_set_page_complete;
  void function(GtkAssistant* assistant, GtkWidget* page, const(char)* title) c_gtk_assistant_set_page_title;
  void function(GtkAssistant* assistant, GtkWidget* page, GtkAssistantPageType type) c_gtk_assistant_set_page_type;
  void function(GtkAssistant* assistant) c_gtk_assistant_update_buttons_state;

  // AssistantPage
  GType function() c_gtk_assistant_page_get_type;
  GtkWidget* function(GtkAssistantPage* page) c_gtk_assistant_page_get_child;

  // BinLayout
  GType function() c_gtk_bin_layout_get_type;
  GtkLayoutManager* function() c_gtk_bin_layout_new;

  // Bitset
  GType function() c_gtk_bitset_get_type;
  GtkBitset* function() c_gtk_bitset_new_empty;
  GtkBitset* function(uint start, uint nItems) c_gtk_bitset_new_range;
  bool function(GtkBitset* self, uint value) c_gtk_bitset_add;
  void function(GtkBitset* self, uint start, uint nItems) c_gtk_bitset_add_range;
  void function(GtkBitset* self, uint first, uint last) c_gtk_bitset_add_range_closed;
  void function(GtkBitset* self, uint start, uint width, uint height, uint stride) c_gtk_bitset_add_rectangle;
  bool function(const(GtkBitset)* self, uint value) c_gtk_bitset_contains;
  GtkBitset* function(const(GtkBitset)* self) c_gtk_bitset_copy;
  void function(GtkBitset* self, const(GtkBitset)* other) c_gtk_bitset_difference;
  bool function(const(GtkBitset)* self, const(GtkBitset)* other) c_gtk_bitset_equals;
  uint function(const(GtkBitset)* self) c_gtk_bitset_get_maximum;
  uint function(const(GtkBitset)* self) c_gtk_bitset_get_minimum;
  uint function(const(GtkBitset)* self, uint nth) c_gtk_bitset_get_nth;
  ulong function(const(GtkBitset)* self) c_gtk_bitset_get_size;
  ulong function(const(GtkBitset)* self, uint first, uint last) c_gtk_bitset_get_size_in_range;
  void function(GtkBitset* self, const(GtkBitset)* other) c_gtk_bitset_intersect;
  bool function(const(GtkBitset)* self) c_gtk_bitset_is_empty;
  GtkBitset* function(GtkBitset* self) c_gtk_bitset_ref;
  bool function(GtkBitset* self, uint value) c_gtk_bitset_remove;
  void function(GtkBitset* self) c_gtk_bitset_remove_all;
  void function(GtkBitset* self, uint start, uint nItems) c_gtk_bitset_remove_range;
  void function(GtkBitset* self, uint first, uint last) c_gtk_bitset_remove_range_closed;
  void function(GtkBitset* self, uint start, uint width, uint height, uint stride) c_gtk_bitset_remove_rectangle;
  void function(GtkBitset* self, uint amount) c_gtk_bitset_shift_left;
  void function(GtkBitset* self, uint amount) c_gtk_bitset_shift_right;
  void function(GtkBitset* self, uint position, uint removed, uint added) c_gtk_bitset_splice;
  void function(GtkBitset* self, const(GtkBitset)* other) c_gtk_bitset_subtract;
  void function(GtkBitset* self, const(GtkBitset)* other) c_gtk_bitset_union;
  void function(GtkBitset* self) c_gtk_bitset_unref;

  // BitsetIter
  GType function() c_gtk_bitset_iter_get_type;
  uint function(const(GtkBitsetIter)* iter) c_gtk_bitset_iter_get_value;
  bool function(const(GtkBitsetIter)* iter) c_gtk_bitset_iter_is_valid;
  bool function(GtkBitsetIter* iter, uint* value) c_gtk_bitset_iter_next;
  bool function(GtkBitsetIter* iter, uint* value) c_gtk_bitset_iter_previous;
  bool function(GtkBitsetIter* iter, const(GtkBitset)* set, uint target, uint* value) c_gtk_bitset_iter_init_at;
  bool function(GtkBitsetIter* iter, const(GtkBitset)* set, uint* value) c_gtk_bitset_iter_init_first;
  bool function(GtkBitsetIter* iter, const(GtkBitset)* set, uint* value) c_gtk_bitset_iter_init_last;

  // BookmarkList
  GType function() c_gtk_bookmark_list_get_type;
  GtkBookmarkList* function(const(char)* filename, const(char)* attributes) c_gtk_bookmark_list_new;
  const(char)* function(GtkBookmarkList* self) c_gtk_bookmark_list_get_attributes;
  const(char)* function(GtkBookmarkList* self) c_gtk_bookmark_list_get_filename;
  int function(GtkBookmarkList* self) c_gtk_bookmark_list_get_io_priority;
  bool function(GtkBookmarkList* self) c_gtk_bookmark_list_is_loading;
  void function(GtkBookmarkList* self, const(char)* attributes) c_gtk_bookmark_list_set_attributes;
  void function(GtkBookmarkList* self, int ioPriority) c_gtk_bookmark_list_set_io_priority;

  // BoolFilter
  GType function() c_gtk_bool_filter_get_type;
  GtkBoolFilter* function(GtkExpression* expression) c_gtk_bool_filter_new;
  GtkExpression* function(GtkBoolFilter* self) c_gtk_bool_filter_get_expression;
  bool function(GtkBoolFilter* self) c_gtk_bool_filter_get_invert;
  void function(GtkBoolFilter* self, GtkExpression* expression) c_gtk_bool_filter_set_expression;
  void function(GtkBoolFilter* self, bool invert) c_gtk_bool_filter_set_invert;

  // Border
  GType function() c_gtk_border_get_type;
  GtkBorder* function() c_gtk_border_new;
  GtkBorder* function(const(GtkBorder)* border) c_gtk_border_copy;
  void function(GtkBorder* border) c_gtk_border_free;

  // Box
  GType function() c_gtk_box_get_type;
  GtkWidget* function(GtkOrientation orientation, int spacing) c_gtk_box_new;
  void function(GtkBox* box, GtkWidget* child) c_gtk_box_append;
  int function(GtkBox* box) c_gtk_box_get_baseline_child;
  GtkBaselinePosition function(GtkBox* box) c_gtk_box_get_baseline_position;
  bool function(GtkBox* box) c_gtk_box_get_homogeneous;
  int function(GtkBox* box) c_gtk_box_get_spacing;
  void function(GtkBox* box, GtkWidget* child, GtkWidget* sibling) c_gtk_box_insert_child_after;
  void function(GtkBox* box, GtkWidget* child) c_gtk_box_prepend;
  void function(GtkBox* box, GtkWidget* child) c_gtk_box_remove;
  void function(GtkBox* box, GtkWidget* child, GtkWidget* sibling) c_gtk_box_reorder_child_after;
  void function(GtkBox* box, int child) c_gtk_box_set_baseline_child;
  void function(GtkBox* box, GtkBaselinePosition position) c_gtk_box_set_baseline_position;
  void function(GtkBox* box, bool homogeneous) c_gtk_box_set_homogeneous;
  void function(GtkBox* box, int spacing) c_gtk_box_set_spacing;

  // BoxLayout
  GType function() c_gtk_box_layout_get_type;
  GtkLayoutManager* function(GtkOrientation orientation) c_gtk_box_layout_new;
  int function(GtkBoxLayout* boxLayout) c_gtk_box_layout_get_baseline_child;
  GtkBaselinePosition function(GtkBoxLayout* boxLayout) c_gtk_box_layout_get_baseline_position;
  bool function(GtkBoxLayout* boxLayout) c_gtk_box_layout_get_homogeneous;
  uint function(GtkBoxLayout* boxLayout) c_gtk_box_layout_get_spacing;
  void function(GtkBoxLayout* boxLayout, int child) c_gtk_box_layout_set_baseline_child;
  void function(GtkBoxLayout* boxLayout, GtkBaselinePosition position) c_gtk_box_layout_set_baseline_position;
  void function(GtkBoxLayout* boxLayout, bool homogeneous) c_gtk_box_layout_set_homogeneous;
  void function(GtkBoxLayout* boxLayout, uint spacing) c_gtk_box_layout_set_spacing;

  // Buildable
  GType function() c_gtk_buildable_get_type;
  const(char)* function(GtkBuildable* buildable) c_gtk_buildable_get_buildable_id;

  // BuildableParseContext
  const(char)* function(GtkBuildableParseContext* context) c_gtk_buildable_parse_context_get_element;
  GPtrArray* function(GtkBuildableParseContext* context) c_gtk_buildable_parse_context_get_element_stack;
  void function(GtkBuildableParseContext* context, int* lineNumber, int* charNumber) c_gtk_buildable_parse_context_get_position;
  void* function(GtkBuildableParseContext* context) c_gtk_buildable_parse_context_pop;
  void function(GtkBuildableParseContext* context, const(GtkBuildableParser)* parser, void* userData) c_gtk_buildable_parse_context_push;

  // Builder
  GType function() c_gtk_builder_get_type;
  GtkBuilder* function() c_gtk_builder_new;
  GtkBuilder* function(const(char)* filename) c_gtk_builder_new_from_file;
  GtkBuilder* function(const(char)* resourcePath) c_gtk_builder_new_from_resource;
  GtkBuilder* function(const(char)* string_, ptrdiff_t length) c_gtk_builder_new_from_string;
  bool function(GtkBuilder* builder, const(char)* filename, GError** _err) c_gtk_builder_add_from_file;
  bool function(GtkBuilder* builder, const(char)* resourcePath, GError** _err) c_gtk_builder_add_from_resource;
  bool function(GtkBuilder* builder, const(char)* buffer, ptrdiff_t length, GError** _err) c_gtk_builder_add_from_string;
  bool function(GtkBuilder* builder, const(char)* filename, const(char*)* objectIds, GError** _err) c_gtk_builder_add_objects_from_file;
  bool function(GtkBuilder* builder, const(char)* resourcePath, const(char*)* objectIds, GError** _err) c_gtk_builder_add_objects_from_resource;
  bool function(GtkBuilder* builder, const(char)* buffer, ptrdiff_t length, const(char*)* objectIds, GError** _err) c_gtk_builder_add_objects_from_string;
  GClosure* function(GtkBuilder* builder, const(char)* functionName, GtkBuilderClosureFlags flags, ObjectC* object, GError** _err) c_gtk_builder_create_closure;
  void function(GtkBuilder* builder, const(char)* name, ObjectC* object) c_gtk_builder_expose_object;
  bool function(GtkBuilder* builder, ObjectC* object, GType templateType, const(char)* buffer, ptrdiff_t length, GError** _err) c_gtk_builder_extend_with_template;
  ObjectC* function(GtkBuilder* builder) c_gtk_builder_get_current_object;
  ObjectC* function(GtkBuilder* builder, const(char)* name) c_gtk_builder_get_object;
  GSList* function(GtkBuilder* builder) c_gtk_builder_get_objects;
  GtkBuilderScope* function(GtkBuilder* builder) c_gtk_builder_get_scope;
  const(char)* function(GtkBuilder* builder) c_gtk_builder_get_translation_domain;
  GType function(GtkBuilder* builder, const(char)* typeName) c_gtk_builder_get_type_from_name;
  void function(GtkBuilder* builder, ObjectC* currentObject) c_gtk_builder_set_current_object;
  void function(GtkBuilder* builder, GtkBuilderScope* scope_) c_gtk_builder_set_scope;
  void function(GtkBuilder* builder, const(char)* domain) c_gtk_builder_set_translation_domain;
  bool function(GtkBuilder* builder, GParamSpec* pspec, const(char)* string_, GValue* value, GError** _err) c_gtk_builder_value_from_string;
  bool function(GtkBuilder* builder, GType type, const(char)* string_, GValue* value, GError** _err) c_gtk_builder_value_from_string_type;

  // BuilderCScope
  GType function() c_gtk_builder_cscope_get_type;
  GtkBuilderScope* function() c_gtk_builder_cscope_new;
  void function(GtkBuilderCScope* self, const(char)* callbackName, GCallback callbackSymbol) c_gtk_builder_cscope_add_callback_symbol;
  void function(GtkBuilderCScope* self, const(char)* firstCallbackName, GCallback firstCallbackSymbol,  ...) c_gtk_builder_cscope_add_callback_symbols;
  GCallback function(GtkBuilderCScope* self, const(char)* callbackName) c_gtk_builder_cscope_lookup_callback_symbol;

  // BuilderListItemFactory
  GType function() c_gtk_builder_list_item_factory_get_type;
  GtkListItemFactory* function(GtkBuilderScope* scope_, GBytes* bytes) c_gtk_builder_list_item_factory_new_from_bytes;
  GtkListItemFactory* function(GtkBuilderScope* scope_, const(char)* resourcePath) c_gtk_builder_list_item_factory_new_from_resource;
  GBytes* function(GtkBuilderListItemFactory* self) c_gtk_builder_list_item_factory_get_bytes;
  const(char)* function(GtkBuilderListItemFactory* self) c_gtk_builder_list_item_factory_get_resource;
  GtkBuilderScope* function(GtkBuilderListItemFactory* self) c_gtk_builder_list_item_factory_get_scope;

  // BuilderScope
  GType function() c_gtk_builder_scope_get_type;

  // Button
  GType function() c_gtk_button_get_type;
  GtkWidget* function() c_gtk_button_new;
  GtkWidget* function(const(char)* iconName) c_gtk_button_new_from_icon_name;
  GtkWidget* function(const(char)* label) c_gtk_button_new_with_label;
  GtkWidget* function(const(char)* label) c_gtk_button_new_with_mnemonic;
  bool function(GtkButton* button) c_gtk_button_get_can_shrink;
  GtkWidget* function(GtkButton* button) c_gtk_button_get_child;
  bool function(GtkButton* button) c_gtk_button_get_has_frame;
  const(char)* function(GtkButton* button) c_gtk_button_get_icon_name;
  const(char)* function(GtkButton* button) c_gtk_button_get_label;
  bool function(GtkButton* button) c_gtk_button_get_use_underline;
  void function(GtkButton* button, bool canShrink) c_gtk_button_set_can_shrink;
  void function(GtkButton* button, GtkWidget* child) c_gtk_button_set_child;
  void function(GtkButton* button, bool hasFrame) c_gtk_button_set_has_frame;
  void function(GtkButton* button, const(char)* iconName) c_gtk_button_set_icon_name;
  void function(GtkButton* button, const(char)* label) c_gtk_button_set_label;
  void function(GtkButton* button, bool useUnderline) c_gtk_button_set_use_underline;

  // CClosureExpression
  GType function() c_gtk_cclosure_expression_get_type;
  GtkExpression* function(GType valueType, GClosureMarshal marshal, uint nParams, GtkExpression** params, GCallback callbackFunc, void* userData, GClosureNotify userDestroy) c_gtk_cclosure_expression_new;

  // Calendar
  GType function() c_gtk_calendar_get_type;
  GtkWidget* function() c_gtk_calendar_new;
  void function(GtkCalendar* calendar) c_gtk_calendar_clear_marks;
  GDateTime* function(GtkCalendar* self) c_gtk_calendar_get_date;
  int function(GtkCalendar* self) c_gtk_calendar_get_day;
  bool function(GtkCalendar* calendar, uint day) c_gtk_calendar_get_day_is_marked;
  int function(GtkCalendar* self) c_gtk_calendar_get_month;
  bool function(GtkCalendar* self) c_gtk_calendar_get_show_day_names;
  bool function(GtkCalendar* self) c_gtk_calendar_get_show_heading;
  bool function(GtkCalendar* self) c_gtk_calendar_get_show_week_numbers;
  int function(GtkCalendar* self) c_gtk_calendar_get_year;
  void function(GtkCalendar* calendar, uint day) c_gtk_calendar_mark_day;
  void function(GtkCalendar* self, GDateTime* date) c_gtk_calendar_select_day;
  void function(GtkCalendar* self, int day) c_gtk_calendar_set_day;
  void function(GtkCalendar* self, int month) c_gtk_calendar_set_month;
  void function(GtkCalendar* self, bool value) c_gtk_calendar_set_show_day_names;
  void function(GtkCalendar* self, bool value) c_gtk_calendar_set_show_heading;
  void function(GtkCalendar* self, bool value) c_gtk_calendar_set_show_week_numbers;
  void function(GtkCalendar* self, int year) c_gtk_calendar_set_year;
  void function(GtkCalendar* calendar, uint day) c_gtk_calendar_unmark_day;

  // CallbackAction
  GType function() c_gtk_callback_action_get_type;
  GtkShortcutAction* function(GtkShortcutFunc callback, void* data, GDestroyNotify destroy) c_gtk_callback_action_new;

  // CellArea
  GType function() c_gtk_cell_area_get_type;
  bool function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, const(GdkRectangle)* cellArea, GtkCellRendererState flags, bool editOnly) c_gtk_cell_area_activate;
  bool function(GtkCellArea* area, GtkWidget* widget, GtkCellRenderer* renderer, GdkEvent* event, const(GdkRectangle)* cellArea, GtkCellRendererState flags) c_gtk_cell_area_activate_cell;
  void function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_add;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, GtkCellRenderer* sibling) c_gtk_cell_area_add_focus_sibling;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* firstPropName,  ...) c_gtk_cell_area_add_with_properties;
  void function(GtkCellArea* area, GtkTreeModel* treeModel, GtkTreeIter* iter, bool isExpander, bool isExpanded) c_gtk_cell_area_apply_attributes;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* attribute, int column) c_gtk_cell_area_attribute_connect;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* attribute) c_gtk_cell_area_attribute_disconnect;
  int function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* attribute) c_gtk_cell_area_attribute_get_column;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* firstPropName,  ...) c_gtk_cell_area_cell_get;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* propertyName, GValue* value) c_gtk_cell_area_cell_get_property;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* firstPropertyName, void* varArgs) c_gtk_cell_area_cell_get_valist;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* firstPropName,  ...) c_gtk_cell_area_cell_set;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* propertyName, const(GValue)* value) c_gtk_cell_area_cell_set_property;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, const(char)* firstPropertyName, void* varArgs) c_gtk_cell_area_cell_set_valist;
  GtkCellAreaContext* function(GtkCellArea* area, GtkCellAreaContext* context) c_gtk_cell_area_copy_context;
  GtkCellAreaContext* function(GtkCellArea* area) c_gtk_cell_area_create_context;
  int function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, GdkEvent* event, const(GdkRectangle)* cellArea, GtkCellRendererState flags) c_gtk_cell_area_event;
  bool function(GtkCellArea* area, GtkDirectionType direction) c_gtk_cell_area_focus;
  void function(GtkCellArea* area, GtkCellCallback callback, void* callbackData) c_gtk_cell_area_foreach;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, const(GdkRectangle)* cellArea, const(GdkRectangle)* backgroundArea, GtkCellAllocCallback callback, void* callbackData) c_gtk_cell_area_foreach_alloc;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, GtkCellRenderer* renderer, const(GdkRectangle)* cellArea, GdkRectangle* allocation) c_gtk_cell_area_get_cell_allocation;
  GtkCellRenderer* function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, const(GdkRectangle)* cellArea, int x, int y, GdkRectangle* allocArea) c_gtk_cell_area_get_cell_at_position;
  const(char)* function(GtkCellArea* area) c_gtk_cell_area_get_current_path_string;
  GtkCellEditable* function(GtkCellArea* area) c_gtk_cell_area_get_edit_widget;
  GtkCellRenderer* function(GtkCellArea* area) c_gtk_cell_area_get_edited_cell;
  GtkCellRenderer* function(GtkCellArea* area) c_gtk_cell_area_get_focus_cell;
  GtkCellRenderer* function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_get_focus_from_sibling;
  const(GList)* function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_get_focus_siblings;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int* minimumHeight, int* naturalHeight) c_gtk_cell_area_get_preferred_height;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int width, int* minimumHeight, int* naturalHeight) c_gtk_cell_area_get_preferred_height_for_width;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int* minimumWidth, int* naturalWidth) c_gtk_cell_area_get_preferred_width;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int height, int* minimumWidth, int* naturalWidth) c_gtk_cell_area_get_preferred_width_for_height;
  GtkSizeRequestMode function(GtkCellArea* area) c_gtk_cell_area_get_request_mode;
  bool function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_has_renderer;
  void function(GtkCellArea* area, GtkWidget* widget, const(GdkRectangle)* cellArea, GdkRectangle* innerArea) c_gtk_cell_area_inner_cell_area;
  bool function(GtkCellArea* area) c_gtk_cell_area_is_activatable;
  bool function(GtkCellArea* area, GtkCellRenderer* renderer, GtkCellRenderer* sibling) c_gtk_cell_area_is_focus_sibling;
  void function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_remove;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, GtkCellRenderer* sibling) c_gtk_cell_area_remove_focus_sibling;
  void function(GtkCellArea* area, GtkCellRenderer* renderer, GtkOrientation orientation, GtkWidget* widget, int forSize, int* minimumSize, int* naturalSize) c_gtk_cell_area_request_renderer;
  void function(GtkCellArea* area, GtkCellRenderer* renderer) c_gtk_cell_area_set_focus_cell;
  void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, GtkSnapshot* snapshot, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags, bool paintFocus) c_gtk_cell_area_snapshot;
  void function(GtkCellArea* area, bool canceled) c_gtk_cell_area_stop_editing;

  // CellAreaBox
  GType function() c_gtk_cell_area_box_get_type;
  GtkCellArea* function() c_gtk_cell_area_box_new;
  int function(GtkCellAreaBox* box) c_gtk_cell_area_box_get_spacing;
  void function(GtkCellAreaBox* box, GtkCellRenderer* renderer, bool expand, bool align_, bool fixed) c_gtk_cell_area_box_pack_end;
  void function(GtkCellAreaBox* box, GtkCellRenderer* renderer, bool expand, bool align_, bool fixed) c_gtk_cell_area_box_pack_start;
  void function(GtkCellAreaBox* box, int spacing) c_gtk_cell_area_box_set_spacing;

  // CellAreaClass
  GParamSpec* function(GtkCellAreaClass* aclass, const(char)* propertyName) c_gtk_cell_area_class_find_cell_property;
  void function(GtkCellAreaClass* aclass, uint propertyId, GParamSpec* pspec) c_gtk_cell_area_class_install_cell_property;
  GParamSpec** function(GtkCellAreaClass* aclass, uint* nProperties) c_gtk_cell_area_class_list_cell_properties;

  // CellAreaContext
  GType function() c_gtk_cell_area_context_get_type;
  void function(GtkCellAreaContext* context, int width, int height) c_gtk_cell_area_context_allocate;
  void function(GtkCellAreaContext* context, int* width, int* height) c_gtk_cell_area_context_get_allocation;
  GtkCellArea* function(GtkCellAreaContext* context) c_gtk_cell_area_context_get_area;
  void function(GtkCellAreaContext* context, int* minimumHeight, int* naturalHeight) c_gtk_cell_area_context_get_preferred_height;
  void function(GtkCellAreaContext* context, int width, int* minimumHeight, int* naturalHeight) c_gtk_cell_area_context_get_preferred_height_for_width;
  void function(GtkCellAreaContext* context, int* minimumWidth, int* naturalWidth) c_gtk_cell_area_context_get_preferred_width;
  void function(GtkCellAreaContext* context, int height, int* minimumWidth, int* naturalWidth) c_gtk_cell_area_context_get_preferred_width_for_height;
  void function(GtkCellAreaContext* context, int minimumHeight, int naturalHeight) c_gtk_cell_area_context_push_preferred_height;
  void function(GtkCellAreaContext* context, int minimumWidth, int naturalWidth) c_gtk_cell_area_context_push_preferred_width;
  void function(GtkCellAreaContext* context) c_gtk_cell_area_context_reset;

  // CellEditable
  GType function() c_gtk_cell_editable_get_type;
  void function(GtkCellEditable* cellEditable) c_gtk_cell_editable_editing_done;
  void function(GtkCellEditable* cellEditable) c_gtk_cell_editable_remove_widget;
  void function(GtkCellEditable* cellEditable, GdkEvent* event) c_gtk_cell_editable_start_editing;

  // CellLayout
  GType function() c_gtk_cell_layout_get_type;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, const(char)* attribute, int column) c_gtk_cell_layout_add_attribute;
  void function(GtkCellLayout* cellLayout) c_gtk_cell_layout_clear;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell) c_gtk_cell_layout_clear_attributes;
  GtkCellArea* function(GtkCellLayout* cellLayout) c_gtk_cell_layout_get_area;
  GList* function(GtkCellLayout* cellLayout) c_gtk_cell_layout_get_cells;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, bool expand) c_gtk_cell_layout_pack_end;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, bool expand) c_gtk_cell_layout_pack_start;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, int position) c_gtk_cell_layout_reorder;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell,  ...) c_gtk_cell_layout_set_attributes;
  void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, GtkCellLayoutDataFunc func, void* funcData, GDestroyNotify destroy) c_gtk_cell_layout_set_cell_data_func;

  // CellRenderer
  GType function() c_gtk_cell_renderer_get_type;
  bool function(GtkCellRenderer* cell, GdkEvent* event, GtkWidget* widget, const(char)* path, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags) c_gtk_cell_renderer_activate;
  void function(GtkCellRenderer* cell, GtkWidget* widget, GtkCellRendererState flags, const(GdkRectangle)* cellArea, GdkRectangle* alignedArea) c_gtk_cell_renderer_get_aligned_area;
  void function(GtkCellRenderer* cell, float* xalign, float* yalign) c_gtk_cell_renderer_get_alignment;
  void function(GtkCellRenderer* cell, int* width, int* height) c_gtk_cell_renderer_get_fixed_size;
  bool function(GtkCellRenderer* cell) c_gtk_cell_renderer_get_is_expanded;
  bool function(GtkCellRenderer* cell) c_gtk_cell_renderer_get_is_expander;
  void function(GtkCellRenderer* cell, int* xpad, int* ypad) c_gtk_cell_renderer_get_padding;
  void function(GtkCellRenderer* cell, GtkWidget* widget, int* minimumSize, int* naturalSize) c_gtk_cell_renderer_get_preferred_height;
  void function(GtkCellRenderer* cell, GtkWidget* widget, int width, int* minimumHeight, int* naturalHeight) c_gtk_cell_renderer_get_preferred_height_for_width;
  void function(GtkCellRenderer* cell, GtkWidget* widget, GtkRequisition* minimumSize, GtkRequisition* naturalSize) c_gtk_cell_renderer_get_preferred_size;
  void function(GtkCellRenderer* cell, GtkWidget* widget, int* minimumSize, int* naturalSize) c_gtk_cell_renderer_get_preferred_width;
  void function(GtkCellRenderer* cell, GtkWidget* widget, int height, int* minimumWidth, int* naturalWidth) c_gtk_cell_renderer_get_preferred_width_for_height;
  GtkSizeRequestMode function(GtkCellRenderer* cell) c_gtk_cell_renderer_get_request_mode;
  bool function(GtkCellRenderer* cell) c_gtk_cell_renderer_get_sensitive;
  GtkStateFlags function(GtkCellRenderer* cell, GtkWidget* widget, GtkCellRendererState cellState) c_gtk_cell_renderer_get_state;
  bool function(GtkCellRenderer* cell) c_gtk_cell_renderer_get_visible;
  bool function(GtkCellRenderer* cell) c_gtk_cell_renderer_is_activatable;
  void function(GtkCellRenderer* cell, float xalign, float yalign) c_gtk_cell_renderer_set_alignment;
  void function(GtkCellRenderer* cell, int width, int height) c_gtk_cell_renderer_set_fixed_size;
  void function(GtkCellRenderer* cell, bool isExpanded) c_gtk_cell_renderer_set_is_expanded;
  void function(GtkCellRenderer* cell, bool isExpander) c_gtk_cell_renderer_set_is_expander;
  void function(GtkCellRenderer* cell, int xpad, int ypad) c_gtk_cell_renderer_set_padding;
  void function(GtkCellRenderer* cell, bool sensitive) c_gtk_cell_renderer_set_sensitive;
  void function(GtkCellRenderer* cell, bool visible) c_gtk_cell_renderer_set_visible;
  void function(GtkCellRenderer* cell, GtkSnapshot* snapshot, GtkWidget* widget, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags) c_gtk_cell_renderer_snapshot;
  GtkCellEditable* function(GtkCellRenderer* cell, GdkEvent* event, GtkWidget* widget, const(char)* path, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags) c_gtk_cell_renderer_start_editing;
  void function(GtkCellRenderer* cell, bool canceled) c_gtk_cell_renderer_stop_editing;

  // CellRendererAccel
  GType function() c_gtk_cell_renderer_accel_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_accel_new;

  // CellRendererCombo
  GType function() c_gtk_cell_renderer_combo_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_combo_new;

  // CellRendererPixbuf
  GType function() c_gtk_cell_renderer_pixbuf_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_pixbuf_new;

  // CellRendererProgress
  GType function() c_gtk_cell_renderer_progress_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_progress_new;

  // CellRendererSpin
  GType function() c_gtk_cell_renderer_spin_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_spin_new;

  // CellRendererSpinner
  GType function() c_gtk_cell_renderer_spinner_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_spinner_new;

  // CellRendererText
  GType function() c_gtk_cell_renderer_text_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_text_new;
  void function(GtkCellRendererText* renderer, int numberOfRows) c_gtk_cell_renderer_text_set_fixed_height_from_font;

  // CellRendererToggle
  GType function() c_gtk_cell_renderer_toggle_get_type;
  GtkCellRenderer* function() c_gtk_cell_renderer_toggle_new;
  bool function(GtkCellRendererToggle* toggle) c_gtk_cell_renderer_toggle_get_activatable;
  bool function(GtkCellRendererToggle* toggle) c_gtk_cell_renderer_toggle_get_active;
  bool function(GtkCellRendererToggle* toggle) c_gtk_cell_renderer_toggle_get_radio;
  void function(GtkCellRendererToggle* toggle, bool setting) c_gtk_cell_renderer_toggle_set_activatable;
  void function(GtkCellRendererToggle* toggle, bool setting) c_gtk_cell_renderer_toggle_set_active;
  void function(GtkCellRendererToggle* toggle, bool radio) c_gtk_cell_renderer_toggle_set_radio;

  // CellView
  GType function() c_gtk_cell_view_get_type;
  GtkWidget* function() c_gtk_cell_view_new;
  GtkWidget* function(GtkCellArea* area, GtkCellAreaContext* context) c_gtk_cell_view_new_with_context;
  GtkWidget* function(const(char)* markup) c_gtk_cell_view_new_with_markup;
  GtkWidget* function(const(char)* text) c_gtk_cell_view_new_with_text;
  GtkWidget* function(GdkTexture* texture) c_gtk_cell_view_new_with_texture;
  GtkTreePath* function(GtkCellView* cellView) c_gtk_cell_view_get_displayed_row;
  bool function(GtkCellView* cellView) c_gtk_cell_view_get_draw_sensitive;
  bool function(GtkCellView* cellView) c_gtk_cell_view_get_fit_model;
  GtkTreeModel* function(GtkCellView* cellView) c_gtk_cell_view_get_model;
  void function(GtkCellView* cellView, GtkTreePath* path) c_gtk_cell_view_set_displayed_row;
  void function(GtkCellView* cellView, bool drawSensitive) c_gtk_cell_view_set_draw_sensitive;
  void function(GtkCellView* cellView, bool fitModel) c_gtk_cell_view_set_fit_model;
  void function(GtkCellView* cellView, GtkTreeModel* model) c_gtk_cell_view_set_model;

  // CenterBox
  GType function() c_gtk_center_box_get_type;
  GtkWidget* function() c_gtk_center_box_new;
  GtkBaselinePosition function(GtkCenterBox* self) c_gtk_center_box_get_baseline_position;
  GtkWidget* function(GtkCenterBox* self) c_gtk_center_box_get_center_widget;
  GtkWidget* function(GtkCenterBox* self) c_gtk_center_box_get_end_widget;
  bool function(GtkCenterBox* self) c_gtk_center_box_get_shrink_center_last;
  GtkWidget* function(GtkCenterBox* self) c_gtk_center_box_get_start_widget;
  void function(GtkCenterBox* self, GtkBaselinePosition position) c_gtk_center_box_set_baseline_position;
  void function(GtkCenterBox* self, GtkWidget* child) c_gtk_center_box_set_center_widget;
  void function(GtkCenterBox* self, GtkWidget* child) c_gtk_center_box_set_end_widget;
  void function(GtkCenterBox* self, bool shrinkCenterLast) c_gtk_center_box_set_shrink_center_last;
  void function(GtkCenterBox* self, GtkWidget* child) c_gtk_center_box_set_start_widget;

  // CenterLayout
  GType function() c_gtk_center_layout_get_type;
  GtkLayoutManager* function() c_gtk_center_layout_new;
  GtkBaselinePosition function(GtkCenterLayout* self) c_gtk_center_layout_get_baseline_position;
  GtkWidget* function(GtkCenterLayout* self) c_gtk_center_layout_get_center_widget;
  GtkWidget* function(GtkCenterLayout* self) c_gtk_center_layout_get_end_widget;
  GtkOrientation function(GtkCenterLayout* self) c_gtk_center_layout_get_orientation;
  bool function(GtkCenterLayout* self) c_gtk_center_layout_get_shrink_center_last;
  GtkWidget* function(GtkCenterLayout* self) c_gtk_center_layout_get_start_widget;
  void function(GtkCenterLayout* self, GtkBaselinePosition baselinePosition) c_gtk_center_layout_set_baseline_position;
  void function(GtkCenterLayout* self, GtkWidget* widget) c_gtk_center_layout_set_center_widget;
  void function(GtkCenterLayout* self, GtkWidget* widget) c_gtk_center_layout_set_end_widget;
  void function(GtkCenterLayout* self, GtkOrientation orientation) c_gtk_center_layout_set_orientation;
  void function(GtkCenterLayout* self, bool shrinkCenterLast) c_gtk_center_layout_set_shrink_center_last;
  void function(GtkCenterLayout* self, GtkWidget* widget) c_gtk_center_layout_set_start_widget;

  // CheckButton
  GType function() c_gtk_check_button_get_type;
  GtkWidget* function() c_gtk_check_button_new;
  GtkWidget* function(const(char)* label) c_gtk_check_button_new_with_label;
  GtkWidget* function(const(char)* label) c_gtk_check_button_new_with_mnemonic;
  bool function(GtkCheckButton* self) c_gtk_check_button_get_active;
  GtkWidget* function(GtkCheckButton* button) c_gtk_check_button_get_child;
  bool function(GtkCheckButton* checkButton) c_gtk_check_button_get_inconsistent;
  const(char)* function(GtkCheckButton* self) c_gtk_check_button_get_label;
  bool function(GtkCheckButton* self) c_gtk_check_button_get_use_underline;
  void function(GtkCheckButton* self, bool setting) c_gtk_check_button_set_active;
  void function(GtkCheckButton* button, GtkWidget* child) c_gtk_check_button_set_child;
  void function(GtkCheckButton* self, GtkCheckButton* group) c_gtk_check_button_set_group;
  void function(GtkCheckButton* checkButton, bool inconsistent) c_gtk_check_button_set_inconsistent;
  void function(GtkCheckButton* self, const(char)* label) c_gtk_check_button_set_label;
  void function(GtkCheckButton* self, bool setting) c_gtk_check_button_set_use_underline;

  // ClosureExpression
  GType function() c_gtk_closure_expression_get_type;
  GtkExpression* function(GType valueType, GClosure* closure, uint nParams, GtkExpression** params) c_gtk_closure_expression_new;

  // ColorButton
  GType function() c_gtk_color_button_get_type;
  GtkWidget* function() c_gtk_color_button_new;
  GtkWidget* function(const(GdkRGBA)* rgba) c_gtk_color_button_new_with_rgba;
  bool function(GtkColorButton* button) c_gtk_color_button_get_modal;
  const(char)* function(GtkColorButton* button) c_gtk_color_button_get_title;
  void function(GtkColorButton* button, bool modal) c_gtk_color_button_set_modal;
  void function(GtkColorButton* button, const(char)* title) c_gtk_color_button_set_title;

  // ColorChooser
  GType function() c_gtk_color_chooser_get_type;
  void function(GtkColorChooser* chooser, GtkOrientation orientation, int colorsPerLine, int nColors, GdkRGBA* colors) c_gtk_color_chooser_add_palette;
  void function(GtkColorChooser* chooser, GdkRGBA* color) c_gtk_color_chooser_get_rgba;
  bool function(GtkColorChooser* chooser) c_gtk_color_chooser_get_use_alpha;
  void function(GtkColorChooser* chooser, const(GdkRGBA)* color) c_gtk_color_chooser_set_rgba;
  void function(GtkColorChooser* chooser, bool useAlpha) c_gtk_color_chooser_set_use_alpha;

  // ColorChooserDialog
  GType function() c_gtk_color_chooser_dialog_get_type;
  GtkWidget* function(const(char)* title, GtkWindow* parent) c_gtk_color_chooser_dialog_new;

  // ColorChooserWidget
  GType function() c_gtk_color_chooser_widget_get_type;
  GtkWidget* function() c_gtk_color_chooser_widget_new;

  // ColorDialog
  GType function() c_gtk_color_dialog_get_type;
  GtkColorDialog* function() c_gtk_color_dialog_new;
  void function(GtkColorDialog* self, GtkWindow* parent, const(GdkRGBA)* initialColor, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_color_dialog_choose_rgba;
  GdkRGBA* function(GtkColorDialog* self, GAsyncResult* result, GError** _err) c_gtk_color_dialog_choose_rgba_finish;
  bool function(GtkColorDialog* self) c_gtk_color_dialog_get_modal;
  const(char)* function(GtkColorDialog* self) c_gtk_color_dialog_get_title;
  bool function(GtkColorDialog* self) c_gtk_color_dialog_get_with_alpha;
  void function(GtkColorDialog* self, bool modal) c_gtk_color_dialog_set_modal;
  void function(GtkColorDialog* self, const(char)* title) c_gtk_color_dialog_set_title;
  void function(GtkColorDialog* self, bool withAlpha) c_gtk_color_dialog_set_with_alpha;

  // ColorDialogButton
  GType function() c_gtk_color_dialog_button_get_type;
  GtkWidget* function(GtkColorDialog* dialog) c_gtk_color_dialog_button_new;
  GtkColorDialog* function(GtkColorDialogButton* self) c_gtk_color_dialog_button_get_dialog;
  const(GdkRGBA)* function(GtkColorDialogButton* self) c_gtk_color_dialog_button_get_rgba;
  void function(GtkColorDialogButton* self, GtkColorDialog* dialog) c_gtk_color_dialog_button_set_dialog;
  void function(GtkColorDialogButton* self, const(GdkRGBA)* color) c_gtk_color_dialog_button_set_rgba;

  // ColumnView
  GType function() c_gtk_column_view_get_type;
  GtkWidget* function(GtkSelectionModel* model) c_gtk_column_view_new;
  void function(GtkColumnView* self, GtkColumnViewColumn* column) c_gtk_column_view_append_column;
  GListModel* function(GtkColumnView* self) c_gtk_column_view_get_columns;
  bool function(GtkColumnView* self) c_gtk_column_view_get_enable_rubberband;
  GtkListItemFactory* function(GtkColumnView* self) c_gtk_column_view_get_header_factory;
  GtkSelectionModel* function(GtkColumnView* self) c_gtk_column_view_get_model;
  bool function(GtkColumnView* self) c_gtk_column_view_get_reorderable;
  GtkListItemFactory* function(GtkColumnView* self) c_gtk_column_view_get_row_factory;
  bool function(GtkColumnView* self) c_gtk_column_view_get_show_column_separators;
  bool function(GtkColumnView* self) c_gtk_column_view_get_show_row_separators;
  bool function(GtkColumnView* self) c_gtk_column_view_get_single_click_activate;
  GtkSorter* function(GtkColumnView* self) c_gtk_column_view_get_sorter;
  GtkListTabBehavior function(GtkColumnView* self) c_gtk_column_view_get_tab_behavior;
  void function(GtkColumnView* self, uint position, GtkColumnViewColumn* column) c_gtk_column_view_insert_column;
  void function(GtkColumnView* self, GtkColumnViewColumn* column) c_gtk_column_view_remove_column;
  void function(GtkColumnView* self, uint pos, GtkColumnViewColumn* column, GtkListScrollFlags flags, GtkScrollInfo* scroll) c_gtk_column_view_scroll_to;
  void function(GtkColumnView* self, bool enableRubberband) c_gtk_column_view_set_enable_rubberband;
  void function(GtkColumnView* self, GtkListItemFactory* factory) c_gtk_column_view_set_header_factory;
  void function(GtkColumnView* self, GtkSelectionModel* model) c_gtk_column_view_set_model;
  void function(GtkColumnView* self, bool reorderable) c_gtk_column_view_set_reorderable;
  void function(GtkColumnView* self, GtkListItemFactory* factory) c_gtk_column_view_set_row_factory;
  void function(GtkColumnView* self, bool showColumnSeparators) c_gtk_column_view_set_show_column_separators;
  void function(GtkColumnView* self, bool showRowSeparators) c_gtk_column_view_set_show_row_separators;
  void function(GtkColumnView* self, bool singleClickActivate) c_gtk_column_view_set_single_click_activate;
  void function(GtkColumnView* self, GtkListTabBehavior tabBehavior) c_gtk_column_view_set_tab_behavior;
  void function(GtkColumnView* self, GtkColumnViewColumn* column, GtkSortType direction) c_gtk_column_view_sort_by_column;

  // ColumnViewCell
  GType function() c_gtk_column_view_cell_get_type;
  GtkWidget* function(GtkColumnViewCell* self) c_gtk_column_view_cell_get_child;
  bool function(GtkColumnViewCell* self) c_gtk_column_view_cell_get_focusable;
  ObjectC* function(GtkColumnViewCell* self) c_gtk_column_view_cell_get_item;
  uint function(GtkColumnViewCell* self) c_gtk_column_view_cell_get_position;
  bool function(GtkColumnViewCell* self) c_gtk_column_view_cell_get_selected;
  void function(GtkColumnViewCell* self, GtkWidget* child) c_gtk_column_view_cell_set_child;
  void function(GtkColumnViewCell* self, bool focusable) c_gtk_column_view_cell_set_focusable;

  // ColumnViewColumn
  GType function() c_gtk_column_view_column_get_type;
  GtkColumnViewColumn* function(const(char)* title, GtkListItemFactory* factory) c_gtk_column_view_column_new;
  GtkColumnView* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_column_view;
  bool function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_expand;
  GtkListItemFactory* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_factory;
  int function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_fixed_width;
  GMenuModel* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_header_menu;
  const(char)* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_id;
  bool function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_resizable;
  GtkSorter* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_sorter;
  const(char)* function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_title;
  bool function(GtkColumnViewColumn* self) c_gtk_column_view_column_get_visible;
  void function(GtkColumnViewColumn* self, bool expand) c_gtk_column_view_column_set_expand;
  void function(GtkColumnViewColumn* self, GtkListItemFactory* factory) c_gtk_column_view_column_set_factory;
  void function(GtkColumnViewColumn* self, int fixedWidth) c_gtk_column_view_column_set_fixed_width;
  void function(GtkColumnViewColumn* self, GMenuModel* menu) c_gtk_column_view_column_set_header_menu;
  void function(GtkColumnViewColumn* self, const(char)* id) c_gtk_column_view_column_set_id;
  void function(GtkColumnViewColumn* self, bool resizable) c_gtk_column_view_column_set_resizable;
  void function(GtkColumnViewColumn* self, GtkSorter* sorter) c_gtk_column_view_column_set_sorter;
  void function(GtkColumnViewColumn* self, const(char)* title) c_gtk_column_view_column_set_title;
  void function(GtkColumnViewColumn* self, bool visible) c_gtk_column_view_column_set_visible;

  // ColumnViewRow
  GType function() c_gtk_column_view_row_get_type;
  const(char)* function(GtkColumnViewRow* self) c_gtk_column_view_row_get_accessible_description;
  const(char)* function(GtkColumnViewRow* self) c_gtk_column_view_row_get_accessible_label;
  bool function(GtkColumnViewRow* self) c_gtk_column_view_row_get_activatable;
  bool function(GtkColumnViewRow* self) c_gtk_column_view_row_get_focusable;
  ObjectC* function(GtkColumnViewRow* self) c_gtk_column_view_row_get_item;
  uint function(GtkColumnViewRow* self) c_gtk_column_view_row_get_position;
  bool function(GtkColumnViewRow* self) c_gtk_column_view_row_get_selectable;
  bool function(GtkColumnViewRow* self) c_gtk_column_view_row_get_selected;
  void function(GtkColumnViewRow* self, const(char)* description) c_gtk_column_view_row_set_accessible_description;
  void function(GtkColumnViewRow* self, const(char)* label) c_gtk_column_view_row_set_accessible_label;
  void function(GtkColumnViewRow* self, bool activatable) c_gtk_column_view_row_set_activatable;
  void function(GtkColumnViewRow* self, bool focusable) c_gtk_column_view_row_set_focusable;
  void function(GtkColumnViewRow* self, bool selectable) c_gtk_column_view_row_set_selectable;

  // ColumnViewSorter
  GType function() c_gtk_column_view_sorter_get_type;
  uint function(GtkColumnViewSorter* self) c_gtk_column_view_sorter_get_n_sort_columns;
  GtkColumnViewColumn* function(GtkColumnViewSorter* self, uint position, GtkSortType* sortOrder) c_gtk_column_view_sorter_get_nth_sort_column;
  GtkColumnViewColumn* function(GtkColumnViewSorter* self) c_gtk_column_view_sorter_get_primary_sort_column;
  GtkSortType function(GtkColumnViewSorter* self) c_gtk_column_view_sorter_get_primary_sort_order;

  // ComboBox
  GType function() c_gtk_combo_box_get_type;
  GtkWidget* function() c_gtk_combo_box_new;
  GtkWidget* function() c_gtk_combo_box_new_with_entry;
  GtkWidget* function(GtkTreeModel* model) c_gtk_combo_box_new_with_model;
  GtkWidget* function(GtkTreeModel* model) c_gtk_combo_box_new_with_model_and_entry;
  int function(GtkComboBox* comboBox) c_gtk_combo_box_get_active;
  const(char)* function(GtkComboBox* comboBox) c_gtk_combo_box_get_active_id;
  bool function(GtkComboBox* comboBox, GtkTreeIter* iter) c_gtk_combo_box_get_active_iter;
  GtkSensitivityType function(GtkComboBox* comboBox) c_gtk_combo_box_get_button_sensitivity;
  GtkWidget* function(GtkComboBox* comboBox) c_gtk_combo_box_get_child;
  int function(GtkComboBox* comboBox) c_gtk_combo_box_get_entry_text_column;
  bool function(GtkComboBox* comboBox) c_gtk_combo_box_get_has_entry;
  int function(GtkComboBox* comboBox) c_gtk_combo_box_get_id_column;
  GtkTreeModel* function(GtkComboBox* comboBox) c_gtk_combo_box_get_model;
  bool function(GtkComboBox* comboBox) c_gtk_combo_box_get_popup_fixed_width;
  GtkTreeViewRowSeparatorFunc function(GtkComboBox* comboBox) c_gtk_combo_box_get_row_separator_func;
  void function(GtkComboBox* comboBox) c_gtk_combo_box_popdown;
  void function(GtkComboBox* comboBox) c_gtk_combo_box_popup;
  void function(GtkComboBox* comboBox, GdkDevice* device) c_gtk_combo_box_popup_for_device;
  void function(GtkComboBox* comboBox, int index) c_gtk_combo_box_set_active;
  bool function(GtkComboBox* comboBox, const(char)* activeId) c_gtk_combo_box_set_active_id;
  void function(GtkComboBox* comboBox, GtkTreeIter* iter) c_gtk_combo_box_set_active_iter;
  void function(GtkComboBox* comboBox, GtkSensitivityType sensitivity) c_gtk_combo_box_set_button_sensitivity;
  void function(GtkComboBox* comboBox, GtkWidget* child) c_gtk_combo_box_set_child;
  void function(GtkComboBox* comboBox, int textColumn) c_gtk_combo_box_set_entry_text_column;
  void function(GtkComboBox* comboBox, int idColumn) c_gtk_combo_box_set_id_column;
  void function(GtkComboBox* comboBox, GtkTreeModel* model) c_gtk_combo_box_set_model;
  void function(GtkComboBox* comboBox, bool fixed) c_gtk_combo_box_set_popup_fixed_width;
  void function(GtkComboBox* comboBox, GtkTreeViewRowSeparatorFunc func, void* data, GDestroyNotify destroy) c_gtk_combo_box_set_row_separator_func;

  // ComboBoxText
  GType function() c_gtk_combo_box_text_get_type;
  GtkWidget* function() c_gtk_combo_box_text_new;
  GtkWidget* function() c_gtk_combo_box_text_new_with_entry;
  void function(GtkComboBoxText* comboBox, const(char)* id, const(char)* text) c_gtk_combo_box_text_append;
  void function(GtkComboBoxText* comboBox, const(char)* text) c_gtk_combo_box_text_append_text;
  char* function(GtkComboBoxText* comboBox) c_gtk_combo_box_text_get_active_text;
  void function(GtkComboBoxText* comboBox, int position, const(char)* id, const(char)* text) c_gtk_combo_box_text_insert;
  void function(GtkComboBoxText* comboBox, int position, const(char)* text) c_gtk_combo_box_text_insert_text;
  void function(GtkComboBoxText* comboBox, const(char)* id, const(char)* text) c_gtk_combo_box_text_prepend;
  void function(GtkComboBoxText* comboBox, const(char)* text) c_gtk_combo_box_text_prepend_text;
  void function(GtkComboBoxText* comboBox, int position) c_gtk_combo_box_text_remove;
  void function(GtkComboBoxText* comboBox) c_gtk_combo_box_text_remove_all;

  // ConstantExpression
  GType function() c_gtk_constant_expression_get_type;
  GtkExpression* function(GType valueType,  ...) c_gtk_constant_expression_new;
  GtkExpression* function(const(GValue)* value) c_gtk_constant_expression_new_for_value;
  const(GValue)* function(GtkExpression* expression) c_gtk_constant_expression_get_value;

  // Constraint
  GType function() c_gtk_constraint_get_type;
  GtkConstraint* function(GtkConstraintTarget* target, GtkConstraintAttribute targetAttribute, GtkConstraintRelation relation, GtkConstraintTarget* source, GtkConstraintAttribute sourceAttribute, double multiplier, double constant, int strength) c_gtk_constraint_new;
  GtkConstraint* function(GtkConstraintTarget* target, GtkConstraintAttribute targetAttribute, GtkConstraintRelation relation, double constant, int strength) c_gtk_constraint_new_constant;
  double function(GtkConstraint* constraint) c_gtk_constraint_get_constant;
  double function(GtkConstraint* constraint) c_gtk_constraint_get_multiplier;
  GtkConstraintRelation function(GtkConstraint* constraint) c_gtk_constraint_get_relation;
  GtkConstraintTarget* function(GtkConstraint* constraint) c_gtk_constraint_get_source;
  GtkConstraintAttribute function(GtkConstraint* constraint) c_gtk_constraint_get_source_attribute;
  int function(GtkConstraint* constraint) c_gtk_constraint_get_strength;
  GtkConstraintTarget* function(GtkConstraint* constraint) c_gtk_constraint_get_target;
  GtkConstraintAttribute function(GtkConstraint* constraint) c_gtk_constraint_get_target_attribute;
  bool function(GtkConstraint* constraint) c_gtk_constraint_is_attached;
  bool function(GtkConstraint* constraint) c_gtk_constraint_is_constant;
  bool function(GtkConstraint* constraint) c_gtk_constraint_is_required;

  // ConstraintGuide
  GType function() c_gtk_constraint_guide_get_type;
  GtkConstraintGuide* function() c_gtk_constraint_guide_new;
  void function(GtkConstraintGuide* guide, int* width, int* height) c_gtk_constraint_guide_get_max_size;
  void function(GtkConstraintGuide* guide, int* width, int* height) c_gtk_constraint_guide_get_min_size;
  const(char)* function(GtkConstraintGuide* guide) c_gtk_constraint_guide_get_name;
  void function(GtkConstraintGuide* guide, int* width, int* height) c_gtk_constraint_guide_get_nat_size;
  GtkConstraintStrength function(GtkConstraintGuide* guide) c_gtk_constraint_guide_get_strength;
  void function(GtkConstraintGuide* guide, int width, int height) c_gtk_constraint_guide_set_max_size;
  void function(GtkConstraintGuide* guide, int width, int height) c_gtk_constraint_guide_set_min_size;
  void function(GtkConstraintGuide* guide, const(char)* name) c_gtk_constraint_guide_set_name;
  void function(GtkConstraintGuide* guide, int width, int height) c_gtk_constraint_guide_set_nat_size;
  void function(GtkConstraintGuide* guide, GtkConstraintStrength strength) c_gtk_constraint_guide_set_strength;

  // ConstraintLayout
  GType function() c_gtk_constraint_layout_get_type;
  GtkLayoutManager* function() c_gtk_constraint_layout_new;
  void function(GtkConstraintLayout* layout, GtkConstraint* constraint) c_gtk_constraint_layout_add_constraint;
  GList* function(GtkConstraintLayout* layout, const(char*)* lines, size_t nLines, int hspacing, int vspacing, GError** error, const(char)* firstView,  ...) c_gtk_constraint_layout_add_constraints_from_description;
  GList* function(GtkConstraintLayout* layout, const(char*)* lines, size_t nLines, int hspacing, int vspacing, GHashTable* views, GError** _err) c_gtk_constraint_layout_add_constraints_from_descriptionv;
  void function(GtkConstraintLayout* layout, GtkConstraintGuide* guide) c_gtk_constraint_layout_add_guide;
  GListModel* function(GtkConstraintLayout* layout) c_gtk_constraint_layout_observe_constraints;
  GListModel* function(GtkConstraintLayout* layout) c_gtk_constraint_layout_observe_guides;
  void function(GtkConstraintLayout* layout) c_gtk_constraint_layout_remove_all_constraints;
  void function(GtkConstraintLayout* layout, GtkConstraint* constraint) c_gtk_constraint_layout_remove_constraint;
  void function(GtkConstraintLayout* layout, GtkConstraintGuide* guide) c_gtk_constraint_layout_remove_guide;

  // ConstraintLayoutChild
  GType function() c_gtk_constraint_layout_child_get_type;

  // ConstraintTarget
  GType function() c_gtk_constraint_target_get_type;

  // CssProvider
  GType function() c_gtk_css_provider_get_type;
  GtkCssProvider* function() c_gtk_css_provider_new;
  void function(GtkCssProvider* cssProvider, GBytes* data) c_gtk_css_provider_load_from_bytes;
  void function(GtkCssProvider* cssProvider, const(char)* data, ptrdiff_t length) c_gtk_css_provider_load_from_data;
  void function(GtkCssProvider* cssProvider, GFile* file) c_gtk_css_provider_load_from_file;
  void function(GtkCssProvider* cssProvider, const(char)* path) c_gtk_css_provider_load_from_path;
  void function(GtkCssProvider* cssProvider, const(char)* resourcePath) c_gtk_css_provider_load_from_resource;
  void function(GtkCssProvider* cssProvider, const(char)* string_) c_gtk_css_provider_load_from_string;
  void function(GtkCssProvider* provider, const(char)* name, const(char)* variant) c_gtk_css_provider_load_named;
  char* function(GtkCssProvider* provider) c_gtk_css_provider_to_string;

  // CssSection
  GType function() c_gtk_css_section_get_type;
  GtkCssSection* function(GFile* file, const(GtkCssLocation)* start, const(GtkCssLocation)* end) c_gtk_css_section_new;
  const(GtkCssLocation)* function(const(GtkCssSection)* section) c_gtk_css_section_get_end_location;
  GFile* function(const(GtkCssSection)* section) c_gtk_css_section_get_file;
  GtkCssSection* function(const(GtkCssSection)* section) c_gtk_css_section_get_parent;
  const(GtkCssLocation)* function(const(GtkCssSection)* section) c_gtk_css_section_get_start_location;
  void function(const(GtkCssSection)* section, GString* string_) c_gtk_css_section_print;
  GtkCssSection* function(GtkCssSection* section) c_gtk_css_section_ref;
  char* function(const(GtkCssSection)* section) c_gtk_css_section_to_string;
  void function(GtkCssSection* section) c_gtk_css_section_unref;

  // CustomFilter
  GType function() c_gtk_custom_filter_get_type;
  GtkCustomFilter* function(GtkCustomFilterFunc matchFunc, void* userData, GDestroyNotify userDestroy) c_gtk_custom_filter_new;
  void function(GtkCustomFilter* self, GtkCustomFilterFunc matchFunc, void* userData, GDestroyNotify userDestroy) c_gtk_custom_filter_set_filter_func;

  // CustomLayout
  GType function() c_gtk_custom_layout_get_type;
  GtkLayoutManager* function(GtkCustomRequestModeFunc requestMode, GtkCustomMeasureFunc measure, GtkCustomAllocateFunc allocate) c_gtk_custom_layout_new;

  // CustomSorter
  GType function() c_gtk_custom_sorter_get_type;
  GtkCustomSorter* function(GCompareDataFunc sortFunc, void* userData, GDestroyNotify userDestroy) c_gtk_custom_sorter_new;
  void function(GtkCustomSorter* self, GCompareDataFunc sortFunc, void* userData, GDestroyNotify userDestroy) c_gtk_custom_sorter_set_sort_func;

  // Dialog
  GType function() c_gtk_dialog_get_type;
  GtkWidget* function() c_gtk_dialog_new;
  GtkWidget* function(const(char)* title, GtkWindow* parent, GtkDialogFlags flags, const(char)* firstButtonText,  ...) c_gtk_dialog_new_with_buttons;
  void function(GtkDialog* dialog, GtkWidget* child, int responseId) c_gtk_dialog_add_action_widget;
  GtkWidget* function(GtkDialog* dialog, const(char)* buttonText, int responseId) c_gtk_dialog_add_button;
  void function(GtkDialog* dialog, const(char)* firstButtonText,  ...) c_gtk_dialog_add_buttons;
  GtkWidget* function(GtkDialog* dialog) c_gtk_dialog_get_content_area;
  GtkWidget* function(GtkDialog* dialog) c_gtk_dialog_get_header_bar;
  int function(GtkDialog* dialog, GtkWidget* widget) c_gtk_dialog_get_response_for_widget;
  GtkWidget* function(GtkDialog* dialog, int responseId) c_gtk_dialog_get_widget_for_response;
  void function(GtkDialog* dialog, int responseId) c_gtk_dialog_response;
  void function(GtkDialog* dialog, int responseId) c_gtk_dialog_set_default_response;
  void function(GtkDialog* dialog, int responseId, bool setting) c_gtk_dialog_set_response_sensitive;

  // DirectoryList
  GType function() c_gtk_directory_list_get_type;
  GtkDirectoryList* function(const(char)* attributes, GFile* file) c_gtk_directory_list_new;
  const(char)* function(GtkDirectoryList* self) c_gtk_directory_list_get_attributes;
  const(GError)* function(GtkDirectoryList* self) c_gtk_directory_list_get_error;
  GFile* function(GtkDirectoryList* self) c_gtk_directory_list_get_file;
  int function(GtkDirectoryList* self) c_gtk_directory_list_get_io_priority;
  bool function(GtkDirectoryList* self) c_gtk_directory_list_get_monitored;
  bool function(GtkDirectoryList* self) c_gtk_directory_list_is_loading;
  void function(GtkDirectoryList* self, const(char)* attributes) c_gtk_directory_list_set_attributes;
  void function(GtkDirectoryList* self, GFile* file) c_gtk_directory_list_set_file;
  void function(GtkDirectoryList* self, int ioPriority) c_gtk_directory_list_set_io_priority;
  void function(GtkDirectoryList* self, bool monitored) c_gtk_directory_list_set_monitored;

  // DragIcon
  GType function() c_gtk_drag_icon_get_type;
  GtkWidget* function(const(GValue)* value) c_gtk_drag_icon_create_widget_for_value;
  GtkWidget* function(GdkDrag* drag) c_gtk_drag_icon_get_for_drag;
  void function(GdkDrag* drag, GdkPaintable* paintable, int hotX, int hotY) c_gtk_drag_icon_set_from_paintable;
  GtkWidget* function(GtkDragIcon* self) c_gtk_drag_icon_get_child;
  void function(GtkDragIcon* self, GtkWidget* child) c_gtk_drag_icon_set_child;

  // DragSource
  GType function() c_gtk_drag_source_get_type;
  GtkDragSource* function() c_gtk_drag_source_new;
  void function(GtkDragSource* source) c_gtk_drag_source_drag_cancel;
  GdkDragAction function(GtkDragSource* source) c_gtk_drag_source_get_actions;
  GdkContentProvider* function(GtkDragSource* source) c_gtk_drag_source_get_content;
  GdkDrag* function(GtkDragSource* source) c_gtk_drag_source_get_drag;
  void function(GtkDragSource* source, GdkDragAction actions) c_gtk_drag_source_set_actions;
  void function(GtkDragSource* source, GdkContentProvider* content) c_gtk_drag_source_set_content;
  void function(GtkDragSource* source, GdkPaintable* paintable, int hotX, int hotY) c_gtk_drag_source_set_icon;

  // DrawingArea
  GType function() c_gtk_drawing_area_get_type;
  GtkWidget* function() c_gtk_drawing_area_new;
  int function(GtkDrawingArea* self) c_gtk_drawing_area_get_content_height;
  int function(GtkDrawingArea* self) c_gtk_drawing_area_get_content_width;
  void function(GtkDrawingArea* self, int height) c_gtk_drawing_area_set_content_height;
  void function(GtkDrawingArea* self, int width) c_gtk_drawing_area_set_content_width;
  void function(GtkDrawingArea* self, GtkDrawingAreaDrawFunc drawFunc, void* userData, GDestroyNotify destroy) c_gtk_drawing_area_set_draw_func;

  // DropControllerMotion
  GType function() c_gtk_drop_controller_motion_get_type;
  GtkEventController* function() c_gtk_drop_controller_motion_new;
  bool function(GtkDropControllerMotion* self) c_gtk_drop_controller_motion_contains_pointer;
  GdkDrop* function(GtkDropControllerMotion* self) c_gtk_drop_controller_motion_get_drop;
  bool function(GtkDropControllerMotion* self) c_gtk_drop_controller_motion_is_pointer;

  // DropDown
  GType function() c_gtk_drop_down_get_type;
  GtkWidget* function(GListModel* model, GtkExpression* expression) c_gtk_drop_down_new;
  GtkWidget* function(const(char*)* strings) c_gtk_drop_down_new_from_strings;
  bool function(GtkDropDown* self) c_gtk_drop_down_get_enable_search;
  GtkExpression* function(GtkDropDown* self) c_gtk_drop_down_get_expression;
  GtkListItemFactory* function(GtkDropDown* self) c_gtk_drop_down_get_factory;
  GtkListItemFactory* function(GtkDropDown* self) c_gtk_drop_down_get_header_factory;
  GtkListItemFactory* function(GtkDropDown* self) c_gtk_drop_down_get_list_factory;
  GListModel* function(GtkDropDown* self) c_gtk_drop_down_get_model;
  GtkStringFilterMatchMode function(GtkDropDown* self) c_gtk_drop_down_get_search_match_mode;
  uint function(GtkDropDown* self) c_gtk_drop_down_get_selected;
  ObjectC* function(GtkDropDown* self) c_gtk_drop_down_get_selected_item;
  bool function(GtkDropDown* self) c_gtk_drop_down_get_show_arrow;
  void function(GtkDropDown* self, bool enableSearch) c_gtk_drop_down_set_enable_search;
  void function(GtkDropDown* self, GtkExpression* expression) c_gtk_drop_down_set_expression;
  void function(GtkDropDown* self, GtkListItemFactory* factory) c_gtk_drop_down_set_factory;
  void function(GtkDropDown* self, GtkListItemFactory* factory) c_gtk_drop_down_set_header_factory;
  void function(GtkDropDown* self, GtkListItemFactory* factory) c_gtk_drop_down_set_list_factory;
  void function(GtkDropDown* self, GListModel* model) c_gtk_drop_down_set_model;
  void function(GtkDropDown* self, GtkStringFilterMatchMode searchMatchMode) c_gtk_drop_down_set_search_match_mode;
  void function(GtkDropDown* self, uint position) c_gtk_drop_down_set_selected;
  void function(GtkDropDown* self, bool showArrow) c_gtk_drop_down_set_show_arrow;

  // DropTarget
  GType function() c_gtk_drop_target_get_type;
  GtkDropTarget* function(GType type, GdkDragAction actions) c_gtk_drop_target_new;
  GdkDragAction function(GtkDropTarget* self) c_gtk_drop_target_get_actions;
  GdkDrop* function(GtkDropTarget* self) c_gtk_drop_target_get_current_drop;
  GdkDrop* function(GtkDropTarget* self) c_gtk_drop_target_get_drop;
  GdkContentFormats* function(GtkDropTarget* self) c_gtk_drop_target_get_formats;
  const(GType)* function(GtkDropTarget* self, size_t* nTypes) c_gtk_drop_target_get_gtypes;
  bool function(GtkDropTarget* self) c_gtk_drop_target_get_preload;
  const(GValue)* function(GtkDropTarget* self) c_gtk_drop_target_get_value;
  void function(GtkDropTarget* self) c_gtk_drop_target_reject;
  void function(GtkDropTarget* self, GdkDragAction actions) c_gtk_drop_target_set_actions;
  void function(GtkDropTarget* self, GType* types, size_t nTypes) c_gtk_drop_target_set_gtypes;
  void function(GtkDropTarget* self, bool preload) c_gtk_drop_target_set_preload;

  // DropTargetAsync
  GType function() c_gtk_drop_target_async_get_type;
  GtkDropTargetAsync* function(GdkContentFormats* formats, GdkDragAction actions) c_gtk_drop_target_async_new;
  GdkDragAction function(GtkDropTargetAsync* self) c_gtk_drop_target_async_get_actions;
  GdkContentFormats* function(GtkDropTargetAsync* self) c_gtk_drop_target_async_get_formats;
  void function(GtkDropTargetAsync* self, GdkDrop* drop) c_gtk_drop_target_async_reject_drop;
  void function(GtkDropTargetAsync* self, GdkDragAction actions) c_gtk_drop_target_async_set_actions;
  void function(GtkDropTargetAsync* self, GdkContentFormats* formats) c_gtk_drop_target_async_set_formats;

  // Editable
  GType function() c_gtk_editable_get_type;
  bool function(ObjectC* object, uint propId, GValue* value, GParamSpec* pspec) c_gtk_editable_delegate_get_property;
  bool function(ObjectC* object, uint propId, const(GValue)* value, GParamSpec* pspec) c_gtk_editable_delegate_set_property;
  uint function(GObjectClass* objectClass, uint firstProp) c_gtk_editable_install_properties;
  bool function(GtkEditable* editable, GtkAccessiblePlatformState state) c_gtk_editable_delegate_get_accessible_platform_state;
  void function(GtkEditable* editable) c_gtk_editable_delete_selection;
  void function(GtkEditable* editable, int startPos, int endPos) c_gtk_editable_delete_text;
  void function(GtkEditable* editable) c_gtk_editable_finish_delegate;
  float function(GtkEditable* editable) c_gtk_editable_get_alignment;
  char* function(GtkEditable* editable, int startPos, int endPos) c_gtk_editable_get_chars;
  GtkEditable* function(GtkEditable* editable) c_gtk_editable_get_delegate;
  bool function(GtkEditable* editable) c_gtk_editable_get_editable;
  bool function(GtkEditable* editable) c_gtk_editable_get_enable_undo;
  int function(GtkEditable* editable) c_gtk_editable_get_max_width_chars;
  int function(GtkEditable* editable) c_gtk_editable_get_position;
  bool function(GtkEditable* editable, int* startPos, int* endPos) c_gtk_editable_get_selection_bounds;
  const(char)* function(GtkEditable* editable) c_gtk_editable_get_text;
  int function(GtkEditable* editable) c_gtk_editable_get_width_chars;
  void function(GtkEditable* editable) c_gtk_editable_init_delegate;
  void function(GtkEditable* editable, const(char)* text, int length, int* position) c_gtk_editable_insert_text;
  void function(GtkEditable* editable, int startPos, int endPos) c_gtk_editable_select_region;
  void function(GtkEditable* editable, float xalign) c_gtk_editable_set_alignment;
  void function(GtkEditable* editable, bool isEditable) c_gtk_editable_set_editable;
  void function(GtkEditable* editable, bool enableUndo) c_gtk_editable_set_enable_undo;
  void function(GtkEditable* editable, int nChars) c_gtk_editable_set_max_width_chars;
  void function(GtkEditable* editable, int position) c_gtk_editable_set_position;
  void function(GtkEditable* editable, const(char)* text) c_gtk_editable_set_text;
  void function(GtkEditable* editable, int nChars) c_gtk_editable_set_width_chars;

  // EditableLabel
  GType function() c_gtk_editable_label_get_type;
  GtkWidget* function(const(char)* str) c_gtk_editable_label_new;
  bool function(GtkEditableLabel* self) c_gtk_editable_label_get_editing;
  void function(GtkEditableLabel* self) c_gtk_editable_label_start_editing;
  void function(GtkEditableLabel* self, bool commit) c_gtk_editable_label_stop_editing;

  // EmojiChooser
  GType function() c_gtk_emoji_chooser_get_type;
  GtkWidget* function() c_gtk_emoji_chooser_new;

  // Entry
  GType function() c_gtk_entry_get_type;
  GtkWidget* function() c_gtk_entry_new;
  GtkWidget* function(GtkEntryBuffer* buffer) c_gtk_entry_new_with_buffer;
  bool function(GtkEntry* entry) c_gtk_entry_get_activates_default;
  float function(GtkEntry* entry) c_gtk_entry_get_alignment;
  PangoAttrList* function(GtkEntry* entry) c_gtk_entry_get_attributes;
  GtkEntryBuffer* function(GtkEntry* entry) c_gtk_entry_get_buffer;
  GtkEntryCompletion* function(GtkEntry* entry) c_gtk_entry_get_completion;
  int function(GtkEntry* entry) c_gtk_entry_get_current_icon_drag_source;
  GMenuModel* function(GtkEntry* entry) c_gtk_entry_get_extra_menu;
  bool function(GtkEntry* entry) c_gtk_entry_get_has_frame;
  bool function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_activatable;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, GdkRectangle* iconArea) c_gtk_entry_get_icon_area;
  int function(GtkEntry* entry, int x, int y) c_gtk_entry_get_icon_at_pos;
  GIcon* function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_gicon;
  const(char)* function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_name;
  GdkPaintable* function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_paintable;
  bool function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_sensitive;
  GtkImageType function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_storage_type;
  char* function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_tooltip_markup;
  char* function(GtkEntry* entry, GtkEntryIconPosition iconPos) c_gtk_entry_get_icon_tooltip_text;
  GtkInputHints function(GtkEntry* entry) c_gtk_entry_get_input_hints;
  GtkInputPurpose function(GtkEntry* entry) c_gtk_entry_get_input_purpose;
  dchar function(GtkEntry* entry) c_gtk_entry_get_invisible_char;
  int function(GtkEntry* entry) c_gtk_entry_get_max_length;
  bool function(GtkEntry* entry) c_gtk_entry_get_overwrite_mode;
  const(char)* function(GtkEntry* entry) c_gtk_entry_get_placeholder_text;
  double function(GtkEntry* entry) c_gtk_entry_get_progress_fraction;
  double function(GtkEntry* entry) c_gtk_entry_get_progress_pulse_step;
  PangoTabArray* function(GtkEntry* entry) c_gtk_entry_get_tabs;
  ushort function(GtkEntry* entry) c_gtk_entry_get_text_length;
  bool function(GtkEntry* entry) c_gtk_entry_get_visibility;
  bool function(GtkEntry* entry) c_gtk_entry_grab_focus_without_selecting;
  void function(GtkEntry* entry) c_gtk_entry_progress_pulse;
  void function(GtkEntry* entry) c_gtk_entry_reset_im_context;
  void function(GtkEntry* entry, bool setting) c_gtk_entry_set_activates_default;
  void function(GtkEntry* entry, float xalign) c_gtk_entry_set_alignment;
  void function(GtkEntry* entry, PangoAttrList* attrs) c_gtk_entry_set_attributes;
  void function(GtkEntry* entry, GtkEntryBuffer* buffer) c_gtk_entry_set_buffer;
  void function(GtkEntry* entry, GtkEntryCompletion* completion) c_gtk_entry_set_completion;
  void function(GtkEntry* entry, GMenuModel* model) c_gtk_entry_set_extra_menu;
  void function(GtkEntry* entry, bool setting) c_gtk_entry_set_has_frame;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, bool activatable) c_gtk_entry_set_icon_activatable;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, GdkContentProvider* provider, GdkDragAction actions) c_gtk_entry_set_icon_drag_source;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, GIcon* icon) c_gtk_entry_set_icon_from_gicon;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, const(char)* iconName) c_gtk_entry_set_icon_from_icon_name;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, GdkPaintable* paintable) c_gtk_entry_set_icon_from_paintable;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, bool sensitive) c_gtk_entry_set_icon_sensitive;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, const(char)* tooltip) c_gtk_entry_set_icon_tooltip_markup;
  void function(GtkEntry* entry, GtkEntryIconPosition iconPos, const(char)* tooltip) c_gtk_entry_set_icon_tooltip_text;
  void function(GtkEntry* entry, GtkInputHints hints) c_gtk_entry_set_input_hints;
  void function(GtkEntry* entry, GtkInputPurpose purpose) c_gtk_entry_set_input_purpose;
  void function(GtkEntry* entry, dchar ch) c_gtk_entry_set_invisible_char;
  void function(GtkEntry* entry, int max) c_gtk_entry_set_max_length;
  void function(GtkEntry* entry, bool overwrite) c_gtk_entry_set_overwrite_mode;
  void function(GtkEntry* entry, const(char)* text) c_gtk_entry_set_placeholder_text;
  void function(GtkEntry* entry, double fraction) c_gtk_entry_set_progress_fraction;
  void function(GtkEntry* entry, double fraction) c_gtk_entry_set_progress_pulse_step;
  void function(GtkEntry* entry, PangoTabArray* tabs) c_gtk_entry_set_tabs;
  void function(GtkEntry* entry, bool visible) c_gtk_entry_set_visibility;
  void function(GtkEntry* entry) c_gtk_entry_unset_invisible_char;

  // EntryBuffer
  GType function() c_gtk_entry_buffer_get_type;
  GtkEntryBuffer* function(const(char)* initialChars, int nInitialChars) c_gtk_entry_buffer_new;
  uint function(GtkEntryBuffer* buffer, uint position, int nChars) c_gtk_entry_buffer_delete_text;
  void function(GtkEntryBuffer* buffer, uint position, uint nChars) c_gtk_entry_buffer_emit_deleted_text;
  void function(GtkEntryBuffer* buffer, uint position, const(char)* chars, uint nChars) c_gtk_entry_buffer_emit_inserted_text;
  size_t function(GtkEntryBuffer* buffer) c_gtk_entry_buffer_get_bytes;
  uint function(GtkEntryBuffer* buffer) c_gtk_entry_buffer_get_length;
  int function(GtkEntryBuffer* buffer) c_gtk_entry_buffer_get_max_length;
  const(char)* function(GtkEntryBuffer* buffer) c_gtk_entry_buffer_get_text;
  uint function(GtkEntryBuffer* buffer, uint position, const(char)* chars, int nChars) c_gtk_entry_buffer_insert_text;
  void function(GtkEntryBuffer* buffer, int maxLength) c_gtk_entry_buffer_set_max_length;
  void function(GtkEntryBuffer* buffer, const(char)* chars, int nChars) c_gtk_entry_buffer_set_text;

  // EntryCompletion
  GType function() c_gtk_entry_completion_get_type;
  GtkEntryCompletion* function() c_gtk_entry_completion_new;
  GtkEntryCompletion* function(GtkCellArea* area) c_gtk_entry_completion_new_with_area;
  void function(GtkEntryCompletion* completion) c_gtk_entry_completion_complete;
  char* function(GtkEntryCompletion* completion, const(char)* key) c_gtk_entry_completion_compute_prefix;
  const(char)* function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_completion_prefix;
  GtkWidget* function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_entry;
  bool function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_inline_completion;
  bool function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_inline_selection;
  int function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_minimum_key_length;
  GtkTreeModel* function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_model;
  bool function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_popup_completion;
  bool function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_popup_set_width;
  bool function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_popup_single_match;
  int function(GtkEntryCompletion* completion) c_gtk_entry_completion_get_text_column;
  void function(GtkEntryCompletion* completion) c_gtk_entry_completion_insert_prefix;
  void function(GtkEntryCompletion* completion, bool inlineCompletion) c_gtk_entry_completion_set_inline_completion;
  void function(GtkEntryCompletion* completion, bool inlineSelection) c_gtk_entry_completion_set_inline_selection;
  void function(GtkEntryCompletion* completion, GtkEntryCompletionMatchFunc func, void* funcData, GDestroyNotify funcNotify) c_gtk_entry_completion_set_match_func;
  void function(GtkEntryCompletion* completion, int length) c_gtk_entry_completion_set_minimum_key_length;
  void function(GtkEntryCompletion* completion, GtkTreeModel* model) c_gtk_entry_completion_set_model;
  void function(GtkEntryCompletion* completion, bool popupCompletion) c_gtk_entry_completion_set_popup_completion;
  void function(GtkEntryCompletion* completion, bool popupSetWidth) c_gtk_entry_completion_set_popup_set_width;
  void function(GtkEntryCompletion* completion, bool popupSingleMatch) c_gtk_entry_completion_set_popup_single_match;
  void function(GtkEntryCompletion* completion, int column) c_gtk_entry_completion_set_text_column;

  // EventController
  GType function() c_gtk_event_controller_get_type;
  GdkEvent* function(GtkEventController* controller) c_gtk_event_controller_get_current_event;
  GdkDevice* function(GtkEventController* controller) c_gtk_event_controller_get_current_event_device;
  GdkModifierType function(GtkEventController* controller) c_gtk_event_controller_get_current_event_state;
  uint function(GtkEventController* controller) c_gtk_event_controller_get_current_event_time;
  const(char)* function(GtkEventController* controller) c_gtk_event_controller_get_name;
  GtkPropagationLimit function(GtkEventController* controller) c_gtk_event_controller_get_propagation_limit;
  GtkPropagationPhase function(GtkEventController* controller) c_gtk_event_controller_get_propagation_phase;
  GtkWidget* function(GtkEventController* controller) c_gtk_event_controller_get_widget;
  void function(GtkEventController* controller) c_gtk_event_controller_reset;
  void function(GtkEventController* controller, const(char)* name) c_gtk_event_controller_set_name;
  void function(GtkEventController* controller, GtkPropagationLimit limit) c_gtk_event_controller_set_propagation_limit;
  void function(GtkEventController* controller, GtkPropagationPhase phase) c_gtk_event_controller_set_propagation_phase;
  void function(GtkEventController* controller, const(char)* name) c_gtk_event_controller_set_static_name;

  // EventControllerFocus
  GType function() c_gtk_event_controller_focus_get_type;
  GtkEventController* function() c_gtk_event_controller_focus_new;
  bool function(GtkEventControllerFocus* self) c_gtk_event_controller_focus_contains_focus;
  bool function(GtkEventControllerFocus* self) c_gtk_event_controller_focus_is_focus;

  // EventControllerKey
  GType function() c_gtk_event_controller_key_get_type;
  GtkEventController* function() c_gtk_event_controller_key_new;
  bool function(GtkEventControllerKey* controller, GtkWidget* widget) c_gtk_event_controller_key_forward;
  uint function(GtkEventControllerKey* controller) c_gtk_event_controller_key_get_group;
  GtkIMContext* function(GtkEventControllerKey* controller) c_gtk_event_controller_key_get_im_context;
  void function(GtkEventControllerKey* controller, GtkIMContext* imContext) c_gtk_event_controller_key_set_im_context;

  // EventControllerLegacy
  GType function() c_gtk_event_controller_legacy_get_type;
  GtkEventController* function() c_gtk_event_controller_legacy_new;

  // EventControllerMotion
  GType function() c_gtk_event_controller_motion_get_type;
  GtkEventController* function() c_gtk_event_controller_motion_new;
  bool function(GtkEventControllerMotion* self) c_gtk_event_controller_motion_contains_pointer;
  bool function(GtkEventControllerMotion* self) c_gtk_event_controller_motion_is_pointer;

  // EventControllerScroll
  GType function() c_gtk_event_controller_scroll_get_type;
  GtkEventController* function(GtkEventControllerScrollFlags flags) c_gtk_event_controller_scroll_new;
  GtkEventControllerScrollFlags function(GtkEventControllerScroll* scroll) c_gtk_event_controller_scroll_get_flags;
  GdkScrollUnit function(GtkEventControllerScroll* scroll) c_gtk_event_controller_scroll_get_unit;
  void function(GtkEventControllerScroll* scroll, GtkEventControllerScrollFlags flags) c_gtk_event_controller_scroll_set_flags;

  // EveryFilter
  GType function() c_gtk_every_filter_get_type;
  GtkEveryFilter* function() c_gtk_every_filter_new;

  // Expander
  GType function() c_gtk_expander_get_type;
  GtkWidget* function(const(char)* label) c_gtk_expander_new;
  GtkWidget* function(const(char)* label) c_gtk_expander_new_with_mnemonic;
  GtkWidget* function(GtkExpander* expander) c_gtk_expander_get_child;
  bool function(GtkExpander* expander) c_gtk_expander_get_expanded;
  const(char)* function(GtkExpander* expander) c_gtk_expander_get_label;
  GtkWidget* function(GtkExpander* expander) c_gtk_expander_get_label_widget;
  bool function(GtkExpander* expander) c_gtk_expander_get_resize_toplevel;
  bool function(GtkExpander* expander) c_gtk_expander_get_use_markup;
  bool function(GtkExpander* expander) c_gtk_expander_get_use_underline;
  void function(GtkExpander* expander, GtkWidget* child) c_gtk_expander_set_child;
  void function(GtkExpander* expander, bool expanded) c_gtk_expander_set_expanded;
  void function(GtkExpander* expander, const(char)* label) c_gtk_expander_set_label;
  void function(GtkExpander* expander, GtkWidget* labelWidget) c_gtk_expander_set_label_widget;
  void function(GtkExpander* expander, bool resizeToplevel) c_gtk_expander_set_resize_toplevel;
  void function(GtkExpander* expander, bool useMarkup) c_gtk_expander_set_use_markup;
  void function(GtkExpander* expander, bool useUnderline) c_gtk_expander_set_use_underline;

  // Expression
  GType function() c_gtk_expression_get_type;
  GtkExpressionWatch* function(GtkExpression* self, ObjectC* target, const(char)* property, ObjectC* this_) c_gtk_expression_bind;
  bool function(GtkExpression* self, ObjectC* this_, GValue* value) c_gtk_expression_evaluate;
  GType function(GtkExpression* self) c_gtk_expression_get_value_type;
  bool function(GtkExpression* self) c_gtk_expression_is_static;
  GtkExpression* function(GtkExpression* self) c_gtk_expression_ref;
  void function(GtkExpression* self) c_gtk_expression_unref;
  GtkExpressionWatch* function(GtkExpression* self, ObjectC* this_, GtkExpressionNotify notify, void* userData, GDestroyNotify userDestroy) c_gtk_expression_watch;

  // ExpressionWatch
  GType function() c_gtk_expression_watch_get_type;
  bool function(GtkExpressionWatch* watch, GValue* value) c_gtk_expression_watch_evaluate;
  GtkExpressionWatch* function(GtkExpressionWatch* watch) c_gtk_expression_watch_ref;
  void function(GtkExpressionWatch* watch) c_gtk_expression_watch_unref;
  void function(GtkExpressionWatch* watch) c_gtk_expression_watch_unwatch;

  // FileChooser
  GType function() c_gtk_file_chooser_get_type;
  void function(GtkFileChooser* chooser, const(char)* id, const(char)* label, const(char*)* options, const(char*)* optionLabels) c_gtk_file_chooser_add_choice;
  void function(GtkFileChooser* chooser, GtkFileFilter* filter) c_gtk_file_chooser_add_filter;
  bool function(GtkFileChooser* chooser, GFile* folder, GError** _err) c_gtk_file_chooser_add_shortcut_folder;
  GtkFileChooserAction function(GtkFileChooser* chooser) c_gtk_file_chooser_get_action;
  const(char)* function(GtkFileChooser* chooser, const(char)* id) c_gtk_file_chooser_get_choice;
  bool function(GtkFileChooser* chooser) c_gtk_file_chooser_get_create_folders;
  GFile* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_current_folder;
  char* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_current_name;
  GFile* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_file;
  GListModel* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_files;
  GtkFileFilter* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_filter;
  GListModel* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_filters;
  bool function(GtkFileChooser* chooser) c_gtk_file_chooser_get_select_multiple;
  GListModel* function(GtkFileChooser* chooser) c_gtk_file_chooser_get_shortcut_folders;
  void function(GtkFileChooser* chooser, const(char)* id) c_gtk_file_chooser_remove_choice;
  void function(GtkFileChooser* chooser, GtkFileFilter* filter) c_gtk_file_chooser_remove_filter;
  bool function(GtkFileChooser* chooser, GFile* folder, GError** _err) c_gtk_file_chooser_remove_shortcut_folder;
  void function(GtkFileChooser* chooser, GtkFileChooserAction action) c_gtk_file_chooser_set_action;
  void function(GtkFileChooser* chooser, const(char)* id, const(char)* option) c_gtk_file_chooser_set_choice;
  void function(GtkFileChooser* chooser, bool createFolders) c_gtk_file_chooser_set_create_folders;
  bool function(GtkFileChooser* chooser, GFile* file, GError** _err) c_gtk_file_chooser_set_current_folder;
  void function(GtkFileChooser* chooser, const(char)* name) c_gtk_file_chooser_set_current_name;
  bool function(GtkFileChooser* chooser, GFile* file, GError** _err) c_gtk_file_chooser_set_file;
  void function(GtkFileChooser* chooser, GtkFileFilter* filter) c_gtk_file_chooser_set_filter;
  void function(GtkFileChooser* chooser, bool selectMultiple) c_gtk_file_chooser_set_select_multiple;

  // FileChooserDialog
  GType function() c_gtk_file_chooser_dialog_get_type;
  GtkWidget* function(const(char)* title, GtkWindow* parent, GtkFileChooserAction action, const(char)* firstButtonText,  ...) c_gtk_file_chooser_dialog_new;

  // FileChooserNative
  GType function() c_gtk_file_chooser_native_get_type;
  GtkFileChooserNative* function(const(char)* title, GtkWindow* parent, GtkFileChooserAction action, const(char)* acceptLabel, const(char)* cancelLabel) c_gtk_file_chooser_native_new;
  const(char)* function(GtkFileChooserNative* self) c_gtk_file_chooser_native_get_accept_label;
  const(char)* function(GtkFileChooserNative* self) c_gtk_file_chooser_native_get_cancel_label;
  void function(GtkFileChooserNative* self, const(char)* acceptLabel) c_gtk_file_chooser_native_set_accept_label;
  void function(GtkFileChooserNative* self, const(char)* cancelLabel) c_gtk_file_chooser_native_set_cancel_label;

  // FileChooserWidget
  GType function() c_gtk_file_chooser_widget_get_type;
  GtkWidget* function(GtkFileChooserAction action) c_gtk_file_chooser_widget_new;

  // FileDialog
  GType function() c_gtk_file_dialog_get_type;
  GtkFileDialog* function() c_gtk_file_dialog_new;
  const(char)* function(GtkFileDialog* self) c_gtk_file_dialog_get_accept_label;
  GtkFileFilter* function(GtkFileDialog* self) c_gtk_file_dialog_get_default_filter;
  GListModel* function(GtkFileDialog* self) c_gtk_file_dialog_get_filters;
  GFile* function(GtkFileDialog* self) c_gtk_file_dialog_get_initial_file;
  GFile* function(GtkFileDialog* self) c_gtk_file_dialog_get_initial_folder;
  const(char)* function(GtkFileDialog* self) c_gtk_file_dialog_get_initial_name;
  bool function(GtkFileDialog* self) c_gtk_file_dialog_get_modal;
  const(char)* function(GtkFileDialog* self) c_gtk_file_dialog_get_title;
  void function(GtkFileDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_dialog_open;
  GFile* function(GtkFileDialog* self, GAsyncResult* result, GError** _err) c_gtk_file_dialog_open_finish;
  void function(GtkFileDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_dialog_open_multiple;
  GListModel* function(GtkFileDialog* self, GAsyncResult* result, GError** _err) c_gtk_file_dialog_open_multiple_finish;
  void function(GtkFileDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_dialog_save;
  GFile* function(GtkFileDialog* self, GAsyncResult* result, GError** _err) c_gtk_file_dialog_save_finish;
  void function(GtkFileDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_dialog_select_folder;
  GFile* function(GtkFileDialog* self, GAsyncResult* result, GError** _err) c_gtk_file_dialog_select_folder_finish;
  void function(GtkFileDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_dialog_select_multiple_folders;
  GListModel* function(GtkFileDialog* self, GAsyncResult* result, GError** _err) c_gtk_file_dialog_select_multiple_folders_finish;
  void function(GtkFileDialog* self, const(char)* acceptLabel) c_gtk_file_dialog_set_accept_label;
  void function(GtkFileDialog* self, GtkFileFilter* filter) c_gtk_file_dialog_set_default_filter;
  void function(GtkFileDialog* self, GListModel* filters) c_gtk_file_dialog_set_filters;
  void function(GtkFileDialog* self, GFile* file) c_gtk_file_dialog_set_initial_file;
  void function(GtkFileDialog* self, GFile* folder) c_gtk_file_dialog_set_initial_folder;
  void function(GtkFileDialog* self, const(char)* name) c_gtk_file_dialog_set_initial_name;
  void function(GtkFileDialog* self, bool modal) c_gtk_file_dialog_set_modal;
  void function(GtkFileDialog* self, const(char)* title) c_gtk_file_dialog_set_title;

  // FileFilter
  GType function() c_gtk_file_filter_get_type;
  GtkFileFilter* function() c_gtk_file_filter_new;
  GtkFileFilter* function(VariantC* variant) c_gtk_file_filter_new_from_gvariant;
  void function(GtkFileFilter* filter, const(char)* mimeType) c_gtk_file_filter_add_mime_type;
  void function(GtkFileFilter* filter, const(char)* pattern) c_gtk_file_filter_add_pattern;
  void function(GtkFileFilter* filter) c_gtk_file_filter_add_pixbuf_formats;
  void function(GtkFileFilter* filter, const(char)* suffix) c_gtk_file_filter_add_suffix;
  const(char*)* function(GtkFileFilter* filter) c_gtk_file_filter_get_attributes;
  const(char)* function(GtkFileFilter* filter) c_gtk_file_filter_get_name;
  void function(GtkFileFilter* filter, const(char)* name) c_gtk_file_filter_set_name;
  VariantC* function(GtkFileFilter* filter) c_gtk_file_filter_to_gvariant;

  // FileLauncher
  GType function() c_gtk_file_launcher_get_type;
  GtkFileLauncher* function(GFile* file) c_gtk_file_launcher_new;
  bool function(GtkFileLauncher* self) c_gtk_file_launcher_get_always_ask;
  GFile* function(GtkFileLauncher* self) c_gtk_file_launcher_get_file;
  bool function(GtkFileLauncher* self) c_gtk_file_launcher_get_writable;
  void function(GtkFileLauncher* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_launcher_launch;
  bool function(GtkFileLauncher* self, GAsyncResult* result, GError** _err) c_gtk_file_launcher_launch_finish;
  void function(GtkFileLauncher* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_file_launcher_open_containing_folder;
  bool function(GtkFileLauncher* self, GAsyncResult* result, GError** _err) c_gtk_file_launcher_open_containing_folder_finish;
  void function(GtkFileLauncher* self, bool alwaysAsk) c_gtk_file_launcher_set_always_ask;
  void function(GtkFileLauncher* self, GFile* file) c_gtk_file_launcher_set_file;
  void function(GtkFileLauncher* self, bool writable) c_gtk_file_launcher_set_writable;

  // Filter
  GType function() c_gtk_filter_get_type;
  void function(GtkFilter* self, GtkFilterChange change) c_gtk_filter_changed;
  GtkFilterMatch function(GtkFilter* self) c_gtk_filter_get_strictness;
  bool function(GtkFilter* self, ObjectC* item) c_gtk_filter_match;

  // FilterListModel
  GType function() c_gtk_filter_list_model_get_type;
  GtkFilterListModel* function(GListModel* model, GtkFilter* filter) c_gtk_filter_list_model_new;
  GtkFilter* function(GtkFilterListModel* self) c_gtk_filter_list_model_get_filter;
  bool function(GtkFilterListModel* self) c_gtk_filter_list_model_get_incremental;
  GListModel* function(GtkFilterListModel* self) c_gtk_filter_list_model_get_model;
  uint function(GtkFilterListModel* self) c_gtk_filter_list_model_get_pending;
  void function(GtkFilterListModel* self, GtkFilter* filter) c_gtk_filter_list_model_set_filter;
  void function(GtkFilterListModel* self, bool incremental) c_gtk_filter_list_model_set_incremental;
  void function(GtkFilterListModel* self, GListModel* model) c_gtk_filter_list_model_set_model;

  // Fixed
  GType function() c_gtk_fixed_get_type;
  GtkWidget* function() c_gtk_fixed_new;
  void function(GtkFixed* fixed, GtkWidget* widget, double* x, double* y) c_gtk_fixed_get_child_position;
  GskTransform* function(GtkFixed* fixed, GtkWidget* widget) c_gtk_fixed_get_child_transform;
  void function(GtkFixed* fixed, GtkWidget* widget, double x, double y) c_gtk_fixed_move;
  void function(GtkFixed* fixed, GtkWidget* widget, double x, double y) c_gtk_fixed_put;
  void function(GtkFixed* fixed, GtkWidget* widget) c_gtk_fixed_remove;
  void function(GtkFixed* fixed, GtkWidget* widget, GskTransform* transform) c_gtk_fixed_set_child_transform;

  // FixedLayout
  GType function() c_gtk_fixed_layout_get_type;
  GtkLayoutManager* function() c_gtk_fixed_layout_new;

  // FixedLayoutChild
  GType function() c_gtk_fixed_layout_child_get_type;
  GskTransform* function(GtkFixedLayoutChild* child) c_gtk_fixed_layout_child_get_transform;
  void function(GtkFixedLayoutChild* child, GskTransform* transform) c_gtk_fixed_layout_child_set_transform;

  // FlattenListModel
  GType function() c_gtk_flatten_list_model_get_type;
  GtkFlattenListModel* function(GListModel* model) c_gtk_flatten_list_model_new;
  GListModel* function(GtkFlattenListModel* self) c_gtk_flatten_list_model_get_model;
  GListModel* function(GtkFlattenListModel* self, uint position) c_gtk_flatten_list_model_get_model_for_item;
  void function(GtkFlattenListModel* self, GListModel* model) c_gtk_flatten_list_model_set_model;

  // FlowBox
  GType function() c_gtk_flow_box_get_type;
  GtkWidget* function() c_gtk_flow_box_new;
  void function(GtkFlowBox* self, GtkWidget* child) c_gtk_flow_box_append;
  void function(GtkFlowBox* box, GListModel* model, GtkFlowBoxCreateWidgetFunc createWidgetFunc, void* userData, GDestroyNotify userDataFreeFunc) c_gtk_flow_box_bind_model;
  bool function(GtkFlowBox* box) c_gtk_flow_box_get_activate_on_single_click;
  GtkFlowBoxChild* function(GtkFlowBox* box, int idx) c_gtk_flow_box_get_child_at_index;
  GtkFlowBoxChild* function(GtkFlowBox* box, int x, int y) c_gtk_flow_box_get_child_at_pos;
  uint function(GtkFlowBox* box) c_gtk_flow_box_get_column_spacing;
  bool function(GtkFlowBox* box) c_gtk_flow_box_get_homogeneous;
  uint function(GtkFlowBox* box) c_gtk_flow_box_get_max_children_per_line;
  uint function(GtkFlowBox* box) c_gtk_flow_box_get_min_children_per_line;
  uint function(GtkFlowBox* box) c_gtk_flow_box_get_row_spacing;
  GList* function(GtkFlowBox* box) c_gtk_flow_box_get_selected_children;
  GtkSelectionMode function(GtkFlowBox* box) c_gtk_flow_box_get_selection_mode;
  void function(GtkFlowBox* box, GtkWidget* widget, int position) c_gtk_flow_box_insert;
  void function(GtkFlowBox* box) c_gtk_flow_box_invalidate_filter;
  void function(GtkFlowBox* box) c_gtk_flow_box_invalidate_sort;
  void function(GtkFlowBox* self, GtkWidget* child) c_gtk_flow_box_prepend;
  void function(GtkFlowBox* box, GtkWidget* widget) c_gtk_flow_box_remove;
  void function(GtkFlowBox* box) c_gtk_flow_box_remove_all;
  void function(GtkFlowBox* box) c_gtk_flow_box_select_all;
  void function(GtkFlowBox* box, GtkFlowBoxChild* child) c_gtk_flow_box_select_child;
  void function(GtkFlowBox* box, GtkFlowBoxForeachFunc func, void* data) c_gtk_flow_box_selected_foreach;
  void function(GtkFlowBox* box, bool single) c_gtk_flow_box_set_activate_on_single_click;
  void function(GtkFlowBox* box, uint spacing) c_gtk_flow_box_set_column_spacing;
  void function(GtkFlowBox* box, GtkFlowBoxFilterFunc filterFunc, void* userData, GDestroyNotify destroy) c_gtk_flow_box_set_filter_func;
  void function(GtkFlowBox* box, GtkAdjustment* adjustment) c_gtk_flow_box_set_hadjustment;
  void function(GtkFlowBox* box, bool homogeneous) c_gtk_flow_box_set_homogeneous;
  void function(GtkFlowBox* box, uint nChildren) c_gtk_flow_box_set_max_children_per_line;
  void function(GtkFlowBox* box, uint nChildren) c_gtk_flow_box_set_min_children_per_line;
  void function(GtkFlowBox* box, uint spacing) c_gtk_flow_box_set_row_spacing;
  void function(GtkFlowBox* box, GtkSelectionMode mode) c_gtk_flow_box_set_selection_mode;
  void function(GtkFlowBox* box, GtkFlowBoxSortFunc sortFunc, void* userData, GDestroyNotify destroy) c_gtk_flow_box_set_sort_func;
  void function(GtkFlowBox* box, GtkAdjustment* adjustment) c_gtk_flow_box_set_vadjustment;
  void function(GtkFlowBox* box) c_gtk_flow_box_unselect_all;
  void function(GtkFlowBox* box, GtkFlowBoxChild* child) c_gtk_flow_box_unselect_child;

  // FlowBoxChild
  GType function() c_gtk_flow_box_child_get_type;
  GtkWidget* function() c_gtk_flow_box_child_new;
  void function(GtkFlowBoxChild* child) c_gtk_flow_box_child_changed;
  GtkWidget* function(GtkFlowBoxChild* self) c_gtk_flow_box_child_get_child;
  int function(GtkFlowBoxChild* child) c_gtk_flow_box_child_get_index;
  bool function(GtkFlowBoxChild* child) c_gtk_flow_box_child_is_selected;
  void function(GtkFlowBoxChild* self, GtkWidget* child) c_gtk_flow_box_child_set_child;

  // FontButton
  GType function() c_gtk_font_button_get_type;
  GtkWidget* function() c_gtk_font_button_new;
  GtkWidget* function(const(char)* fontname) c_gtk_font_button_new_with_font;
  bool function(GtkFontButton* fontButton) c_gtk_font_button_get_modal;
  const(char)* function(GtkFontButton* fontButton) c_gtk_font_button_get_title;
  bool function(GtkFontButton* fontButton) c_gtk_font_button_get_use_font;
  bool function(GtkFontButton* fontButton) c_gtk_font_button_get_use_size;
  void function(GtkFontButton* fontButton, bool modal) c_gtk_font_button_set_modal;
  void function(GtkFontButton* fontButton, const(char)* title) c_gtk_font_button_set_title;
  void function(GtkFontButton* fontButton, bool useFont) c_gtk_font_button_set_use_font;
  void function(GtkFontButton* fontButton, bool useSize) c_gtk_font_button_set_use_size;

  // FontChooser
  GType function() c_gtk_font_chooser_get_type;
  char* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font;
  PangoFontDescription* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_desc;
  PangoFontFace* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_face;
  PangoFontFamily* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_family;
  char* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_features;
  PangoFontMap* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_map;
  int function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_font_size;
  char* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_language;
  GtkFontChooserLevel function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_level;
  char* function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_preview_text;
  bool function(GtkFontChooser* fontchooser) c_gtk_font_chooser_get_show_preview_entry;
  void function(GtkFontChooser* fontchooser, GtkFontFilterFunc filter, void* userData, GDestroyNotify destroy) c_gtk_font_chooser_set_filter_func;
  void function(GtkFontChooser* fontchooser, const(char)* fontname) c_gtk_font_chooser_set_font;
  void function(GtkFontChooser* fontchooser, const(PangoFontDescription)* fontDesc) c_gtk_font_chooser_set_font_desc;
  void function(GtkFontChooser* fontchooser, PangoFontMap* fontmap) c_gtk_font_chooser_set_font_map;
  void function(GtkFontChooser* fontchooser, const(char)* language) c_gtk_font_chooser_set_language;
  void function(GtkFontChooser* fontchooser, GtkFontChooserLevel level) c_gtk_font_chooser_set_level;
  void function(GtkFontChooser* fontchooser, const(char)* text) c_gtk_font_chooser_set_preview_text;
  void function(GtkFontChooser* fontchooser, bool showPreviewEntry) c_gtk_font_chooser_set_show_preview_entry;

  // FontChooserDialog
  GType function() c_gtk_font_chooser_dialog_get_type;
  GtkWidget* function(const(char)* title, GtkWindow* parent) c_gtk_font_chooser_dialog_new;

  // FontChooserWidget
  GType function() c_gtk_font_chooser_widget_get_type;
  GtkWidget* function() c_gtk_font_chooser_widget_new;

  // FontDialog
  GType function() c_gtk_font_dialog_get_type;
  GtkFontDialog* function() c_gtk_font_dialog_new;
  void function(GtkFontDialog* self, GtkWindow* parent, PangoFontFace* initialValue, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_font_dialog_choose_face;
  PangoFontFace* function(GtkFontDialog* self, GAsyncResult* result, GError** _err) c_gtk_font_dialog_choose_face_finish;
  void function(GtkFontDialog* self, GtkWindow* parent, PangoFontFamily* initialValue, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_font_dialog_choose_family;
  PangoFontFamily* function(GtkFontDialog* self, GAsyncResult* result, GError** _err) c_gtk_font_dialog_choose_family_finish;
  void function(GtkFontDialog* self, GtkWindow* parent, PangoFontDescription* initialValue, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_font_dialog_choose_font;
  void function(GtkFontDialog* self, GtkWindow* parent, PangoFontDescription* initialValue, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_font_dialog_choose_font_and_features;
  bool function(GtkFontDialog* self, GAsyncResult* result, PangoFontDescription** fontDesc, char** fontFeatures, PangoLanguage** language, GError** _err) c_gtk_font_dialog_choose_font_and_features_finish;
  PangoFontDescription* function(GtkFontDialog* self, GAsyncResult* result, GError** _err) c_gtk_font_dialog_choose_font_finish;
  GtkFilter* function(GtkFontDialog* self) c_gtk_font_dialog_get_filter;
  PangoFontMap* function(GtkFontDialog* self) c_gtk_font_dialog_get_font_map;
  PangoLanguage* function(GtkFontDialog* self) c_gtk_font_dialog_get_language;
  bool function(GtkFontDialog* self) c_gtk_font_dialog_get_modal;
  const(char)* function(GtkFontDialog* self) c_gtk_font_dialog_get_title;
  void function(GtkFontDialog* self, GtkFilter* filter) c_gtk_font_dialog_set_filter;
  void function(GtkFontDialog* self, PangoFontMap* fontmap) c_gtk_font_dialog_set_font_map;
  void function(GtkFontDialog* self, PangoLanguage* language) c_gtk_font_dialog_set_language;
  void function(GtkFontDialog* self, bool modal) c_gtk_font_dialog_set_modal;
  void function(GtkFontDialog* self, const(char)* title) c_gtk_font_dialog_set_title;

  // FontDialogButton
  GType function() c_gtk_font_dialog_button_get_type;
  GtkWidget* function(GtkFontDialog* dialog) c_gtk_font_dialog_button_new;
  GtkFontDialog* function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_dialog;
  PangoFontDescription* function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_font_desc;
  const(char)* function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_font_features;
  PangoLanguage* function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_language;
  GtkFontLevel function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_level;
  bool function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_use_font;
  bool function(GtkFontDialogButton* self) c_gtk_font_dialog_button_get_use_size;
  void function(GtkFontDialogButton* self, GtkFontDialog* dialog) c_gtk_font_dialog_button_set_dialog;
  void function(GtkFontDialogButton* self, const(PangoFontDescription)* fontDesc) c_gtk_font_dialog_button_set_font_desc;
  void function(GtkFontDialogButton* self, const(char)* fontFeatures) c_gtk_font_dialog_button_set_font_features;
  void function(GtkFontDialogButton* self, PangoLanguage* language) c_gtk_font_dialog_button_set_language;
  void function(GtkFontDialogButton* self, GtkFontLevel level) c_gtk_font_dialog_button_set_level;
  void function(GtkFontDialogButton* self, bool useFont) c_gtk_font_dialog_button_set_use_font;
  void function(GtkFontDialogButton* self, bool useSize) c_gtk_font_dialog_button_set_use_size;

  // Frame
  GType function() c_gtk_frame_get_type;
  GtkWidget* function(const(char)* label) c_gtk_frame_new;
  GtkWidget* function(GtkFrame* frame) c_gtk_frame_get_child;
  const(char)* function(GtkFrame* frame) c_gtk_frame_get_label;
  float function(GtkFrame* frame) c_gtk_frame_get_label_align;
  GtkWidget* function(GtkFrame* frame) c_gtk_frame_get_label_widget;
  void function(GtkFrame* frame, GtkWidget* child) c_gtk_frame_set_child;
  void function(GtkFrame* frame, const(char)* label) c_gtk_frame_set_label;
  void function(GtkFrame* frame, float xalign) c_gtk_frame_set_label_align;
  void function(GtkFrame* frame, GtkWidget* labelWidget) c_gtk_frame_set_label_widget;

  // GLArea
  GType function() c_gtk_gl_area_get_type;
  GtkWidget* function() c_gtk_gl_area_new;
  void function(GtkGLArea* area) c_gtk_gl_area_attach_buffers;
  GdkGLAPI function(GtkGLArea* area) c_gtk_gl_area_get_allowed_apis;
  GdkGLAPI function(GtkGLArea* area) c_gtk_gl_area_get_api;
  bool function(GtkGLArea* area) c_gtk_gl_area_get_auto_render;
  GdkGLContext* function(GtkGLArea* area) c_gtk_gl_area_get_context;
  GError* function(GtkGLArea* area) c_gtk_gl_area_get_error;
  bool function(GtkGLArea* area) c_gtk_gl_area_get_has_depth_buffer;
  bool function(GtkGLArea* area) c_gtk_gl_area_get_has_stencil_buffer;
  void function(GtkGLArea* area, int* major, int* minor) c_gtk_gl_area_get_required_version;
  bool function(GtkGLArea* area) c_gtk_gl_area_get_use_es;
  void function(GtkGLArea* area) c_gtk_gl_area_make_current;
  void function(GtkGLArea* area) c_gtk_gl_area_queue_render;
  void function(GtkGLArea* area, GdkGLAPI apis) c_gtk_gl_area_set_allowed_apis;
  void function(GtkGLArea* area, bool autoRender) c_gtk_gl_area_set_auto_render;
  void function(GtkGLArea* area, const(GError)* error) c_gtk_gl_area_set_error;
  void function(GtkGLArea* area, bool hasDepthBuffer) c_gtk_gl_area_set_has_depth_buffer;
  void function(GtkGLArea* area, bool hasStencilBuffer) c_gtk_gl_area_set_has_stencil_buffer;
  void function(GtkGLArea* area, int major, int minor) c_gtk_gl_area_set_required_version;
  void function(GtkGLArea* area, bool useEs) c_gtk_gl_area_set_use_es;

  // Gesture
  GType function() c_gtk_gesture_get_type;
  bool function(GtkGesture* gesture, GdkRectangle* rect) c_gtk_gesture_get_bounding_box;
  bool function(GtkGesture* gesture, double* x, double* y) c_gtk_gesture_get_bounding_box_center;
  GdkDevice* function(GtkGesture* gesture) c_gtk_gesture_get_device;
  GList* function(GtkGesture* gesture) c_gtk_gesture_get_group;
  GdkEvent* function(GtkGesture* gesture, GdkEventSequence* sequence) c_gtk_gesture_get_last_event;
  GdkEventSequence* function(GtkGesture* gesture) c_gtk_gesture_get_last_updated_sequence;
  bool function(GtkGesture* gesture, GdkEventSequence* sequence, double* x, double* y) c_gtk_gesture_get_point;
  GtkEventSequenceState function(GtkGesture* gesture, GdkEventSequence* sequence) c_gtk_gesture_get_sequence_state;
  GList* function(GtkGesture* gesture) c_gtk_gesture_get_sequences;
  void function(GtkGesture* groupGesture, GtkGesture* gesture) c_gtk_gesture_group;
  bool function(GtkGesture* gesture, GdkEventSequence* sequence) c_gtk_gesture_handles_sequence;
  bool function(GtkGesture* gesture) c_gtk_gesture_is_active;
  bool function(GtkGesture* gesture, GtkGesture* other) c_gtk_gesture_is_grouped_with;
  bool function(GtkGesture* gesture) c_gtk_gesture_is_recognized;
  bool function(GtkGesture* gesture, GdkEventSequence* sequence, GtkEventSequenceState state) c_gtk_gesture_set_sequence_state;
  bool function(GtkGesture* gesture, GtkEventSequenceState state) c_gtk_gesture_set_state;
  void function(GtkGesture* gesture) c_gtk_gesture_ungroup;

  // GestureClick
  GType function() c_gtk_gesture_click_get_type;
  GtkGesture* function() c_gtk_gesture_click_new;

  // GestureDrag
  GType function() c_gtk_gesture_drag_get_type;
  GtkGesture* function() c_gtk_gesture_drag_new;
  bool function(GtkGestureDrag* gesture, double* x, double* y) c_gtk_gesture_drag_get_offset;
  bool function(GtkGestureDrag* gesture, double* x, double* y) c_gtk_gesture_drag_get_start_point;

  // GestureLongPress
  GType function() c_gtk_gesture_long_press_get_type;
  GtkGesture* function() c_gtk_gesture_long_press_new;
  double function(GtkGestureLongPress* gesture) c_gtk_gesture_long_press_get_delay_factor;
  void function(GtkGestureLongPress* gesture, double delayFactor) c_gtk_gesture_long_press_set_delay_factor;

  // GesturePan
  GType function() c_gtk_gesture_pan_get_type;
  GtkGesture* function(GtkOrientation orientation) c_gtk_gesture_pan_new;
  GtkOrientation function(GtkGesturePan* gesture) c_gtk_gesture_pan_get_orientation;
  void function(GtkGesturePan* gesture, GtkOrientation orientation) c_gtk_gesture_pan_set_orientation;

  // GestureRotate
  GType function() c_gtk_gesture_rotate_get_type;
  GtkGesture* function() c_gtk_gesture_rotate_new;
  double function(GtkGestureRotate* gesture) c_gtk_gesture_rotate_get_angle_delta;

  // GestureSingle
  GType function() c_gtk_gesture_single_get_type;
  uint function(GtkGestureSingle* gesture) c_gtk_gesture_single_get_button;
  uint function(GtkGestureSingle* gesture) c_gtk_gesture_single_get_current_button;
  GdkEventSequence* function(GtkGestureSingle* gesture) c_gtk_gesture_single_get_current_sequence;
  bool function(GtkGestureSingle* gesture) c_gtk_gesture_single_get_exclusive;
  bool function(GtkGestureSingle* gesture) c_gtk_gesture_single_get_touch_only;
  void function(GtkGestureSingle* gesture, uint button) c_gtk_gesture_single_set_button;
  void function(GtkGestureSingle* gesture, bool exclusive) c_gtk_gesture_single_set_exclusive;
  void function(GtkGestureSingle* gesture, bool touchOnly) c_gtk_gesture_single_set_touch_only;

  // GestureStylus
  GType function() c_gtk_gesture_stylus_get_type;
  GtkGesture* function() c_gtk_gesture_stylus_new;
  bool function(GtkGestureStylus* gesture, GdkAxisUse* axes, double** values) c_gtk_gesture_stylus_get_axes;
  bool function(GtkGestureStylus* gesture, GdkAxisUse axis, double* value) c_gtk_gesture_stylus_get_axis;
  bool function(GtkGestureStylus* gesture, GdkTimeCoord** backlog, uint* nElems) c_gtk_gesture_stylus_get_backlog;
  GdkDeviceTool* function(GtkGestureStylus* gesture) c_gtk_gesture_stylus_get_device_tool;
  bool function(GtkGestureStylus* gesture) c_gtk_gesture_stylus_get_stylus_only;
  void function(GtkGestureStylus* gesture, bool stylusOnly) c_gtk_gesture_stylus_set_stylus_only;

  // GestureSwipe
  GType function() c_gtk_gesture_swipe_get_type;
  GtkGesture* function() c_gtk_gesture_swipe_new;
  bool function(GtkGestureSwipe* gesture, double* velocityX, double* velocityY) c_gtk_gesture_swipe_get_velocity;

  // GestureZoom
  GType function() c_gtk_gesture_zoom_get_type;
  GtkGesture* function() c_gtk_gesture_zoom_new;
  double function(GtkGestureZoom* gesture) c_gtk_gesture_zoom_get_scale_delta;

  // Global
  GdkModifierType function() c_gtk_accelerator_get_default_mod_mask;
  char* function(uint acceleratorKey, GdkModifierType acceleratorMods) c_gtk_accelerator_get_label;
  char* function(GdkDisplay* display, uint acceleratorKey, uint keycode, GdkModifierType acceleratorMods) c_gtk_accelerator_get_label_with_keycode;
  char* function(uint acceleratorKey, GdkModifierType acceleratorMods) c_gtk_accelerator_name;
  char* function(GdkDisplay* display, uint acceleratorKey, uint keycode, GdkModifierType acceleratorMods) c_gtk_accelerator_name_with_keycode;
  bool function(const(char)* accelerator, uint* acceleratorKey, GdkModifierType* acceleratorMods) c_gtk_accelerator_parse;
  bool function(const(char)* accelerator, GdkDisplay* display, uint* acceleratorKey, uint** acceleratorCodes, GdkModifierType* acceleratorMods) c_gtk_accelerator_parse_with_keycode;
  bool function(uint keyval, GdkModifierType modifiers) c_gtk_accelerator_valid;
  const(char)* function(uint requiredMajor, uint requiredMinor, uint requiredMicro) c_gtk_check_version;
  GQuark function() c_gtk_css_parser_error_quark;
  GQuark function() c_gtk_css_parser_warning_quark;
  void function() c_gtk_disable_setlocale;
  int function(int extraSpace, uint nRequestedSizes, GtkRequestedSize* sizes) c_gtk_distribute_natural_allocation;
  void function(GtkPrinterFunc func, void* data, GDestroyNotify destroy, bool wait) c_gtk_enumerate_printers;
  uint function() c_gtk_get_binary_age;
  GtkDebugFlags function() c_gtk_get_debug_flags;
  PangoLanguage* function() c_gtk_get_default_language;
  uint function() c_gtk_get_interface_age;
  GtkTextDirection function() c_gtk_get_locale_direction;
  uint function() c_gtk_get_major_version;
  uint function() c_gtk_get_micro_version;
  uint function() c_gtk_get_minor_version;
  void function(float h, float s, float v, float* r, float* g, float* b) c_gtk_hsv_to_rgb;
  void function() c_gtk_init;
  bool function() c_gtk_init_check;
  bool function() c_gtk_is_initialized;
  GParamSpec* function(const(char)* name, const(char)* nick, const(char)* blurb, GParamFlags flags) c_gtk_param_spec_expression;
  GtkPageSetup* function(GtkWindow* parent, GtkPageSetup* pageSetup, GtkPrintSettings* settings) c_gtk_print_run_page_setup_dialog;
  void function(GtkWindow* parent, GtkPageSetup* pageSetup, GtkPrintSettings* settings, GtkPageSetupDoneFunc doneCb, void* data) c_gtk_print_run_page_setup_dialog_async;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_activity;
  void function(GtkStyleContext* context, cairo_t* cr, double angle, double x, double y, double size) c_gtk_render_arrow;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_background;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_check;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_expander;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_focus;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_frame;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_handle;
  void function(GtkStyleContext* context, cairo_t* cr, GdkTexture* texture, double x, double y) c_gtk_render_icon;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, PangoLayout* layout) c_gtk_render_layout;
  void function(GtkStyleContext* context, cairo_t* cr, double x0, double y0, double x1, double y1) c_gtk_render_line;
  void function(GtkStyleContext* context, cairo_t* cr, double x, double y, double width, double height) c_gtk_render_option;
  void function(float r, float g, float b, float* h, float* s, float* v) c_gtk_rgb_to_hsv;
  void function(GtkDebugFlags flags) c_gtk_set_debug_flags;
  void function(GtkWindow* parent, const(char)* firstPropertyName,  ...) c_gtk_show_about_dialog;
  void function(GtkWindow* parent, const(char)* uri, uint timestamp) c_gtk_show_uri;
  void function(GtkWindow* parent, const(char)* uri, uint timestamp, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_show_uri_full;
  bool function(GtkWindow* parent, GAsyncResult* result, GError** _err) c_gtk_show_uri_full_finish;
  void function(const(char)* domain, const(char)* file, int line, const(char)* func, const(char)* expr, GtkAccessible* accessible, GtkAccessibleRole expectedRole, GtkAccessibleRole actualRole) c_gtk_test_accessible_assertion_message_role;
  char* function(GtkAccessible* accessible, GtkAccessibleProperty property,  ...) c_gtk_test_accessible_check_property;
  char* function(GtkAccessible* accessible, GtkAccessibleRelation relation,  ...) c_gtk_test_accessible_check_relation;
  char* function(GtkAccessible* accessible, GtkAccessibleState state,  ...) c_gtk_test_accessible_check_state;
  bool function(GtkAccessible* accessible, GtkAccessibleProperty property) c_gtk_test_accessible_has_property;
  bool function(GtkAccessible* accessible, GtkAccessibleRelation relation) c_gtk_test_accessible_has_relation;
  bool function(GtkAccessible* accessible, GtkAccessibleRole role) c_gtk_test_accessible_has_role;
  bool function(GtkAccessible* accessible, GtkAccessibleState state) c_gtk_test_accessible_has_state;
  void function(int* argcp, char*** argvp,  ...) c_gtk_test_init;
  const(GType)* function(uint* nTypes) c_gtk_test_list_all_types;
  void function() c_gtk_test_register_all_types;
  void function(GtkWidget* widget) c_gtk_test_widget_wait_for_draw;
  GdkContentProvider* function(GtkTreeModel* treeModel, GtkTreePath* path) c_gtk_tree_create_row_drag_content;
  bool function(const(GValue)* value, GtkTreeModel** treeModel, GtkTreePath** path) c_gtk_tree_get_row_drag_data;
  GtkExpression* function(const(GValue)* value) c_gtk_value_dup_expression;
  GtkExpression* function(const(GValue)* value) c_gtk_value_get_expression;
  void function(GValue* value, GtkExpression* expression) c_gtk_value_set_expression;
  void function(GValue* value, GtkExpression* expression) c_gtk_value_take_expression;

  // GraphicsOffload
  GType function() c_gtk_graphics_offload_get_type;
  GtkWidget* function(GtkWidget* child) c_gtk_graphics_offload_new;
  GtkWidget* function(GtkGraphicsOffload* self) c_gtk_graphics_offload_get_child;
  GtkGraphicsOffloadEnabled function(GtkGraphicsOffload* self) c_gtk_graphics_offload_get_enabled;
  void function(GtkGraphicsOffload* self, GtkWidget* child) c_gtk_graphics_offload_set_child;
  void function(GtkGraphicsOffload* self, GtkGraphicsOffloadEnabled enabled) c_gtk_graphics_offload_set_enabled;

  // Grid
  GType function() c_gtk_grid_get_type;
  GtkWidget* function() c_gtk_grid_new;
  void function(GtkGrid* grid, GtkWidget* child, int column, int row, int width, int height) c_gtk_grid_attach;
  void function(GtkGrid* grid, GtkWidget* child, GtkWidget* sibling, GtkPositionType side, int width, int height) c_gtk_grid_attach_next_to;
  int function(GtkGrid* grid) c_gtk_grid_get_baseline_row;
  GtkWidget* function(GtkGrid* grid, int column, int row) c_gtk_grid_get_child_at;
  bool function(GtkGrid* grid) c_gtk_grid_get_column_homogeneous;
  uint function(GtkGrid* grid) c_gtk_grid_get_column_spacing;
  GtkBaselinePosition function(GtkGrid* grid, int row) c_gtk_grid_get_row_baseline_position;
  bool function(GtkGrid* grid) c_gtk_grid_get_row_homogeneous;
  uint function(GtkGrid* grid) c_gtk_grid_get_row_spacing;
  void function(GtkGrid* grid, int position) c_gtk_grid_insert_column;
  void function(GtkGrid* grid, GtkWidget* sibling, GtkPositionType side) c_gtk_grid_insert_next_to;
  void function(GtkGrid* grid, int position) c_gtk_grid_insert_row;
  void function(GtkGrid* grid, GtkWidget* child, int* column, int* row, int* width, int* height) c_gtk_grid_query_child;
  void function(GtkGrid* grid, GtkWidget* child) c_gtk_grid_remove;
  void function(GtkGrid* grid, int position) c_gtk_grid_remove_column;
  void function(GtkGrid* grid, int position) c_gtk_grid_remove_row;
  void function(GtkGrid* grid, int row) c_gtk_grid_set_baseline_row;
  void function(GtkGrid* grid, bool homogeneous) c_gtk_grid_set_column_homogeneous;
  void function(GtkGrid* grid, uint spacing) c_gtk_grid_set_column_spacing;
  void function(GtkGrid* grid, int row, GtkBaselinePosition pos) c_gtk_grid_set_row_baseline_position;
  void function(GtkGrid* grid, bool homogeneous) c_gtk_grid_set_row_homogeneous;
  void function(GtkGrid* grid, uint spacing) c_gtk_grid_set_row_spacing;

  // GridLayout
  GType function() c_gtk_grid_layout_get_type;
  GtkLayoutManager* function() c_gtk_grid_layout_new;
  int function(GtkGridLayout* grid) c_gtk_grid_layout_get_baseline_row;
  bool function(GtkGridLayout* grid) c_gtk_grid_layout_get_column_homogeneous;
  uint function(GtkGridLayout* grid) c_gtk_grid_layout_get_column_spacing;
  GtkBaselinePosition function(GtkGridLayout* grid, int row) c_gtk_grid_layout_get_row_baseline_position;
  bool function(GtkGridLayout* grid) c_gtk_grid_layout_get_row_homogeneous;
  uint function(GtkGridLayout* grid) c_gtk_grid_layout_get_row_spacing;
  void function(GtkGridLayout* grid, int row) c_gtk_grid_layout_set_baseline_row;
  void function(GtkGridLayout* grid, bool homogeneous) c_gtk_grid_layout_set_column_homogeneous;
  void function(GtkGridLayout* grid, uint spacing) c_gtk_grid_layout_set_column_spacing;
  void function(GtkGridLayout* grid, int row, GtkBaselinePosition pos) c_gtk_grid_layout_set_row_baseline_position;
  void function(GtkGridLayout* grid, bool homogeneous) c_gtk_grid_layout_set_row_homogeneous;
  void function(GtkGridLayout* grid, uint spacing) c_gtk_grid_layout_set_row_spacing;

  // GridLayoutChild
  GType function() c_gtk_grid_layout_child_get_type;
  int function(GtkGridLayoutChild* child) c_gtk_grid_layout_child_get_column;
  int function(GtkGridLayoutChild* child) c_gtk_grid_layout_child_get_column_span;
  int function(GtkGridLayoutChild* child) c_gtk_grid_layout_child_get_row;
  int function(GtkGridLayoutChild* child) c_gtk_grid_layout_child_get_row_span;
  void function(GtkGridLayoutChild* child, int column) c_gtk_grid_layout_child_set_column;
  void function(GtkGridLayoutChild* child, int span) c_gtk_grid_layout_child_set_column_span;
  void function(GtkGridLayoutChild* child, int row) c_gtk_grid_layout_child_set_row;
  void function(GtkGridLayoutChild* child, int span) c_gtk_grid_layout_child_set_row_span;

  // GridView
  GType function() c_gtk_grid_view_get_type;
  GtkWidget* function(GtkSelectionModel* model, GtkListItemFactory* factory) c_gtk_grid_view_new;
  bool function(GtkGridView* self) c_gtk_grid_view_get_enable_rubberband;
  GtkListItemFactory* function(GtkGridView* self) c_gtk_grid_view_get_factory;
  uint function(GtkGridView* self) c_gtk_grid_view_get_max_columns;
  uint function(GtkGridView* self) c_gtk_grid_view_get_min_columns;
  GtkSelectionModel* function(GtkGridView* self) c_gtk_grid_view_get_model;
  bool function(GtkGridView* self) c_gtk_grid_view_get_single_click_activate;
  GtkListTabBehavior function(GtkGridView* self) c_gtk_grid_view_get_tab_behavior;
  void function(GtkGridView* self, uint pos, GtkListScrollFlags flags, GtkScrollInfo* scroll) c_gtk_grid_view_scroll_to;
  void function(GtkGridView* self, bool enableRubberband) c_gtk_grid_view_set_enable_rubberband;
  void function(GtkGridView* self, GtkListItemFactory* factory) c_gtk_grid_view_set_factory;
  void function(GtkGridView* self, uint maxColumns) c_gtk_grid_view_set_max_columns;
  void function(GtkGridView* self, uint minColumns) c_gtk_grid_view_set_min_columns;
  void function(GtkGridView* self, GtkSelectionModel* model) c_gtk_grid_view_set_model;
  void function(GtkGridView* self, bool singleClickActivate) c_gtk_grid_view_set_single_click_activate;
  void function(GtkGridView* self, GtkListTabBehavior tabBehavior) c_gtk_grid_view_set_tab_behavior;

  // HeaderBar
  GType function() c_gtk_header_bar_get_type;
  GtkWidget* function() c_gtk_header_bar_new;
  const(char)* function(GtkHeaderBar* bar) c_gtk_header_bar_get_decoration_layout;
  bool function(GtkHeaderBar* bar) c_gtk_header_bar_get_show_title_buttons;
  GtkWidget* function(GtkHeaderBar* bar) c_gtk_header_bar_get_title_widget;
  void function(GtkHeaderBar* bar, GtkWidget* child) c_gtk_header_bar_pack_end;
  void function(GtkHeaderBar* bar, GtkWidget* child) c_gtk_header_bar_pack_start;
  void function(GtkHeaderBar* bar, GtkWidget* child) c_gtk_header_bar_remove;
  void function(GtkHeaderBar* bar, const(char)* layout) c_gtk_header_bar_set_decoration_layout;
  void function(GtkHeaderBar* bar, bool setting) c_gtk_header_bar_set_show_title_buttons;
  void function(GtkHeaderBar* bar, GtkWidget* titleWidget) c_gtk_header_bar_set_title_widget;

  // IMContext
  GType function() c_gtk_im_context_get_type;
  bool function(GtkIMContext* context, GdkEvent* event) c_gtk_im_context_activate_osk;
  bool function(GtkIMContext* context, int offset, int nChars) c_gtk_im_context_delete_surrounding;
  bool function(GtkIMContext* context, bool press, GdkSurface* surface, GdkDevice* device, uint time, uint keycode, GdkModifierType state, int group) c_gtk_im_context_filter_key;
  bool function(GtkIMContext* context, GdkEvent* event) c_gtk_im_context_filter_keypress;
  void function(GtkIMContext* context) c_gtk_im_context_focus_in;
  void function(GtkIMContext* context) c_gtk_im_context_focus_out;
  void function(GtkIMContext* context, char** str, PangoAttrList** attrs, int* cursorPos) c_gtk_im_context_get_preedit_string;
  bool function(GtkIMContext* context, char** text, int* cursorIndex) c_gtk_im_context_get_surrounding;
  bool function(GtkIMContext* context, char** text, int* cursorIndex, int* anchorIndex) c_gtk_im_context_get_surrounding_with_selection;
  void function(GtkIMContext* context) c_gtk_im_context_reset;
  void function(GtkIMContext* context, GtkWidget* widget) c_gtk_im_context_set_client_widget;
  void function(GtkIMContext* context, const(GdkRectangle)* area) c_gtk_im_context_set_cursor_location;
  void function(GtkIMContext* context, const(char)* text, int len, int cursorIndex) c_gtk_im_context_set_surrounding;
  void function(GtkIMContext* context, const(char)* text, int len, int cursorIndex, int anchorIndex) c_gtk_im_context_set_surrounding_with_selection;
  void function(GtkIMContext* context, bool usePreedit) c_gtk_im_context_set_use_preedit;

  // IMContextSimple
  GType function() c_gtk_im_context_simple_get_type;
  GtkIMContext* function() c_gtk_im_context_simple_new;
  void function(GtkIMContextSimple* contextSimple, const(char)* composeFile) c_gtk_im_context_simple_add_compose_file;
  void function(GtkIMContextSimple* contextSimple, ushort* data, int maxSeqLen, int nSeqs) c_gtk_im_context_simple_add_table;

  // IMMulticontext
  GType function() c_gtk_im_multicontext_get_type;
  GtkIMContext* function() c_gtk_im_multicontext_new;
  const(char)* function(GtkIMMulticontext* context) c_gtk_im_multicontext_get_context_id;
  void function(GtkIMMulticontext* context, const(char)* contextId) c_gtk_im_multicontext_set_context_id;

  // IconPaintable
  GType function() c_gtk_icon_paintable_get_type;
  GtkIconPaintable* function(GFile* file, int size, int scale) c_gtk_icon_paintable_new_for_file;
  GFile* function(GtkIconPaintable* self) c_gtk_icon_paintable_get_file;
  const(char)* function(GtkIconPaintable* self) c_gtk_icon_paintable_get_icon_name;
  bool function(GtkIconPaintable* self) c_gtk_icon_paintable_is_symbolic;

  // IconTheme
  GType function() c_gtk_icon_theme_get_type;
  GtkIconTheme* function() c_gtk_icon_theme_new;
  GtkIconTheme* function(GdkDisplay* display) c_gtk_icon_theme_get_for_display;
  void function(GtkIconTheme* self, const(char)* path) c_gtk_icon_theme_add_resource_path;
  void function(GtkIconTheme* self, const(char)* path) c_gtk_icon_theme_add_search_path;
  GdkDisplay* function(GtkIconTheme* self) c_gtk_icon_theme_get_display;
  char** function(GtkIconTheme* self) c_gtk_icon_theme_get_icon_names;
  int* function(GtkIconTheme* self, const(char)* iconName) c_gtk_icon_theme_get_icon_sizes;
  char** function(GtkIconTheme* self) c_gtk_icon_theme_get_resource_path;
  char** function(GtkIconTheme* self) c_gtk_icon_theme_get_search_path;
  char* function(GtkIconTheme* self) c_gtk_icon_theme_get_theme_name;
  bool function(GtkIconTheme* self, GIcon* gicon) c_gtk_icon_theme_has_gicon;
  bool function(GtkIconTheme* self, const(char)* iconName) c_gtk_icon_theme_has_icon;
  GtkIconPaintable* function(GtkIconTheme* self, GIcon* icon, int size, int scale, GtkTextDirection direction, GtkIconLookupFlags flags) c_gtk_icon_theme_lookup_by_gicon;
  GtkIconPaintable* function(GtkIconTheme* self, const(char)* iconName, const(char*)* fallbacks, int size, int scale, GtkTextDirection direction, GtkIconLookupFlags flags) c_gtk_icon_theme_lookup_icon;
  void function(GtkIconTheme* self, const(char*)* path) c_gtk_icon_theme_set_resource_path;
  void function(GtkIconTheme* self, const(char*)* path) c_gtk_icon_theme_set_search_path;
  void function(GtkIconTheme* self, const(char)* themeName) c_gtk_icon_theme_set_theme_name;

  // IconView
  GType function() c_gtk_icon_view_get_type;
  GtkWidget* function() c_gtk_icon_view_new;
  GtkWidget* function(GtkCellArea* area) c_gtk_icon_view_new_with_area;
  GtkWidget* function(GtkTreeModel* model) c_gtk_icon_view_new_with_model;
  GdkPaintable* function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_create_drag_icon;
  void function(GtkIconView* iconView, GdkContentFormats* formats, GdkDragAction actions) c_gtk_icon_view_enable_model_drag_dest;
  void function(GtkIconView* iconView, GdkModifierType startButtonMask, GdkContentFormats* formats, GdkDragAction actions) c_gtk_icon_view_enable_model_drag_source;
  bool function(GtkIconView* iconView) c_gtk_icon_view_get_activate_on_single_click;
  bool function(GtkIconView* iconView, GtkTreePath* path, GtkCellRenderer* cell, GdkRectangle* rect) c_gtk_icon_view_get_cell_rect;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_column_spacing;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_columns;
  bool function(GtkIconView* iconView, GtkTreePath** path, GtkCellRenderer** cell) c_gtk_icon_view_get_cursor;
  bool function(GtkIconView* iconView, int dragX, int dragY, GtkTreePath** path, GtkIconViewDropPosition* pos) c_gtk_icon_view_get_dest_item_at_pos;
  void function(GtkIconView* iconView, GtkTreePath** path, GtkIconViewDropPosition* pos) c_gtk_icon_view_get_drag_dest_item;
  bool function(GtkIconView* iconView, int x, int y, GtkTreePath** path, GtkCellRenderer** cell) c_gtk_icon_view_get_item_at_pos;
  int function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_get_item_column;
  GtkOrientation function(GtkIconView* iconView) c_gtk_icon_view_get_item_orientation;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_item_padding;
  int function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_get_item_row;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_item_width;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_margin;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_markup_column;
  GtkTreeModel* function(GtkIconView* iconView) c_gtk_icon_view_get_model;
  GtkTreePath* function(GtkIconView* iconView, int x, int y) c_gtk_icon_view_get_path_at_pos;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_pixbuf_column;
  bool function(GtkIconView* iconView) c_gtk_icon_view_get_reorderable;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_row_spacing;
  GList* function(GtkIconView* iconView) c_gtk_icon_view_get_selected_items;
  GtkSelectionMode function(GtkIconView* iconView) c_gtk_icon_view_get_selection_mode;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_spacing;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_text_column;
  int function(GtkIconView* iconView) c_gtk_icon_view_get_tooltip_column;
  bool function(GtkIconView* iconView, int x, int y, bool keyboardTip, GtkTreeModel** model, GtkTreePath** path, GtkTreeIter* iter) c_gtk_icon_view_get_tooltip_context;
  bool function(GtkIconView* iconView, GtkTreePath** startPath, GtkTreePath** endPath) c_gtk_icon_view_get_visible_range;
  void function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_item_activated;
  bool function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_path_is_selected;
  void function(GtkIconView* iconView, GtkTreePath* path, bool useAlign, float rowAlign, float colAlign) c_gtk_icon_view_scroll_to_path;
  void function(GtkIconView* iconView) c_gtk_icon_view_select_all;
  void function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_select_path;
  void function(GtkIconView* iconView, GtkIconViewForeachFunc func, void* data) c_gtk_icon_view_selected_foreach;
  void function(GtkIconView* iconView, bool single) c_gtk_icon_view_set_activate_on_single_click;
  void function(GtkIconView* iconView, int columnSpacing) c_gtk_icon_view_set_column_spacing;
  void function(GtkIconView* iconView, int columns) c_gtk_icon_view_set_columns;
  void function(GtkIconView* iconView, GtkTreePath* path, GtkCellRenderer* cell, bool startEditing) c_gtk_icon_view_set_cursor;
  void function(GtkIconView* iconView, GtkTreePath* path, GtkIconViewDropPosition pos) c_gtk_icon_view_set_drag_dest_item;
  void function(GtkIconView* iconView, GtkOrientation orientation) c_gtk_icon_view_set_item_orientation;
  void function(GtkIconView* iconView, int itemPadding) c_gtk_icon_view_set_item_padding;
  void function(GtkIconView* iconView, int itemWidth) c_gtk_icon_view_set_item_width;
  void function(GtkIconView* iconView, int margin) c_gtk_icon_view_set_margin;
  void function(GtkIconView* iconView, int column) c_gtk_icon_view_set_markup_column;
  void function(GtkIconView* iconView, GtkTreeModel* model) c_gtk_icon_view_set_model;
  void function(GtkIconView* iconView, int column) c_gtk_icon_view_set_pixbuf_column;
  void function(GtkIconView* iconView, bool reorderable) c_gtk_icon_view_set_reorderable;
  void function(GtkIconView* iconView, int rowSpacing) c_gtk_icon_view_set_row_spacing;
  void function(GtkIconView* iconView, GtkSelectionMode mode) c_gtk_icon_view_set_selection_mode;
  void function(GtkIconView* iconView, int spacing) c_gtk_icon_view_set_spacing;
  void function(GtkIconView* iconView, int column) c_gtk_icon_view_set_text_column;
  void function(GtkIconView* iconView, GtkTooltip* tooltip, GtkTreePath* path, GtkCellRenderer* cell) c_gtk_icon_view_set_tooltip_cell;
  void function(GtkIconView* iconView, int column) c_gtk_icon_view_set_tooltip_column;
  void function(GtkIconView* iconView, GtkTooltip* tooltip, GtkTreePath* path) c_gtk_icon_view_set_tooltip_item;
  void function(GtkIconView* iconView) c_gtk_icon_view_unselect_all;
  void function(GtkIconView* iconView, GtkTreePath* path) c_gtk_icon_view_unselect_path;
  void function(GtkIconView* iconView) c_gtk_icon_view_unset_model_drag_dest;
  void function(GtkIconView* iconView) c_gtk_icon_view_unset_model_drag_source;

  // Image
  GType function() c_gtk_image_get_type;
  GtkWidget* function() c_gtk_image_new;
  GtkWidget* function(const(char)* filename) c_gtk_image_new_from_file;
  GtkWidget* function(GIcon* icon) c_gtk_image_new_from_gicon;
  GtkWidget* function(const(char)* iconName) c_gtk_image_new_from_icon_name;
  GtkWidget* function(GdkPaintable* paintable) c_gtk_image_new_from_paintable;
  GtkWidget* function(PixbufC* pixbuf) c_gtk_image_new_from_pixbuf;
  GtkWidget* function(const(char)* resourcePath) c_gtk_image_new_from_resource;
  void function(GtkImage* image) c_gtk_image_clear;
  GIcon* function(GtkImage* image) c_gtk_image_get_gicon;
  const(char)* function(GtkImage* image) c_gtk_image_get_icon_name;
  GtkIconSize function(GtkImage* image) c_gtk_image_get_icon_size;
  GdkPaintable* function(GtkImage* image) c_gtk_image_get_paintable;
  int function(GtkImage* image) c_gtk_image_get_pixel_size;
  GtkImageType function(GtkImage* image) c_gtk_image_get_storage_type;
  void function(GtkImage* image, const(char)* filename) c_gtk_image_set_from_file;
  void function(GtkImage* image, GIcon* icon) c_gtk_image_set_from_gicon;
  void function(GtkImage* image, const(char)* iconName) c_gtk_image_set_from_icon_name;
  void function(GtkImage* image, GdkPaintable* paintable) c_gtk_image_set_from_paintable;
  void function(GtkImage* image, PixbufC* pixbuf) c_gtk_image_set_from_pixbuf;
  void function(GtkImage* image, const(char)* resourcePath) c_gtk_image_set_from_resource;
  void function(GtkImage* image, GtkIconSize iconSize) c_gtk_image_set_icon_size;
  void function(GtkImage* image, int pixelSize) c_gtk_image_set_pixel_size;

  // InfoBar
  GType function() c_gtk_info_bar_get_type;
  GtkWidget* function() c_gtk_info_bar_new;
  GtkWidget* function(const(char)* firstButtonText,  ...) c_gtk_info_bar_new_with_buttons;
  void function(GtkInfoBar* infoBar, GtkWidget* child, int responseId) c_gtk_info_bar_add_action_widget;
  GtkWidget* function(GtkInfoBar* infoBar, const(char)* buttonText, int responseId) c_gtk_info_bar_add_button;
  void function(GtkInfoBar* infoBar, const(char)* firstButtonText,  ...) c_gtk_info_bar_add_buttons;
  void function(GtkInfoBar* infoBar, GtkWidget* widget) c_gtk_info_bar_add_child;
  GtkMessageType function(GtkInfoBar* infoBar) c_gtk_info_bar_get_message_type;
  bool function(GtkInfoBar* infoBar) c_gtk_info_bar_get_revealed;
  bool function(GtkInfoBar* infoBar) c_gtk_info_bar_get_show_close_button;
  void function(GtkInfoBar* infoBar, GtkWidget* widget) c_gtk_info_bar_remove_action_widget;
  void function(GtkInfoBar* infoBar, GtkWidget* widget) c_gtk_info_bar_remove_child;
  void function(GtkInfoBar* infoBar, int responseId) c_gtk_info_bar_response;
  void function(GtkInfoBar* infoBar, int responseId) c_gtk_info_bar_set_default_response;
  void function(GtkInfoBar* infoBar, GtkMessageType messageType) c_gtk_info_bar_set_message_type;
  void function(GtkInfoBar* infoBar, int responseId, bool setting) c_gtk_info_bar_set_response_sensitive;
  void function(GtkInfoBar* infoBar, bool revealed) c_gtk_info_bar_set_revealed;
  void function(GtkInfoBar* infoBar, bool setting) c_gtk_info_bar_set_show_close_button;

  // Inscription
  GType function() c_gtk_inscription_get_type;
  GtkWidget* function(const(char)* text) c_gtk_inscription_new;
  PangoAttrList* function(GtkInscription* self) c_gtk_inscription_get_attributes;
  uint function(GtkInscription* self) c_gtk_inscription_get_min_chars;
  uint function(GtkInscription* self) c_gtk_inscription_get_min_lines;
  uint function(GtkInscription* self) c_gtk_inscription_get_nat_chars;
  uint function(GtkInscription* self) c_gtk_inscription_get_nat_lines;
  const(char)* function(GtkInscription* self) c_gtk_inscription_get_text;
  GtkInscriptionOverflow function(GtkInscription* self) c_gtk_inscription_get_text_overflow;
  PangoWrapMode function(GtkInscription* self) c_gtk_inscription_get_wrap_mode;
  float function(GtkInscription* self) c_gtk_inscription_get_xalign;
  float function(GtkInscription* self) c_gtk_inscription_get_yalign;
  void function(GtkInscription* self, PangoAttrList* attrs) c_gtk_inscription_set_attributes;
  void function(GtkInscription* self, const(char)* markup) c_gtk_inscription_set_markup;
  void function(GtkInscription* self, uint minChars) c_gtk_inscription_set_min_chars;
  void function(GtkInscription* self, uint minLines) c_gtk_inscription_set_min_lines;
  void function(GtkInscription* self, uint natChars) c_gtk_inscription_set_nat_chars;
  void function(GtkInscription* self, uint natLines) c_gtk_inscription_set_nat_lines;
  void function(GtkInscription* self, const(char)* text) c_gtk_inscription_set_text;
  void function(GtkInscription* self, GtkInscriptionOverflow overflow) c_gtk_inscription_set_text_overflow;
  void function(GtkInscription* self, PangoWrapMode wrapMode) c_gtk_inscription_set_wrap_mode;
  void function(GtkInscription* self, float xalign) c_gtk_inscription_set_xalign;
  void function(GtkInscription* self, float yalign) c_gtk_inscription_set_yalign;

  // KeyvalTrigger
  GType function() c_gtk_keyval_trigger_get_type;
  GtkShortcutTrigger* function(uint keyval, GdkModifierType modifiers) c_gtk_keyval_trigger_new;
  uint function(GtkKeyvalTrigger* self) c_gtk_keyval_trigger_get_keyval;
  GdkModifierType function(GtkKeyvalTrigger* self) c_gtk_keyval_trigger_get_modifiers;

  // Label
  GType function() c_gtk_label_get_type;
  GtkWidget* function(const(char)* str) c_gtk_label_new;
  GtkWidget* function(const(char)* str) c_gtk_label_new_with_mnemonic;
  PangoAttrList* function(GtkLabel* self) c_gtk_label_get_attributes;
  const(char)* function(GtkLabel* self) c_gtk_label_get_current_uri;
  PangoEllipsizeMode function(GtkLabel* self) c_gtk_label_get_ellipsize;
  GMenuModel* function(GtkLabel* self) c_gtk_label_get_extra_menu;
  GtkJustification function(GtkLabel* self) c_gtk_label_get_justify;
  const(char)* function(GtkLabel* self) c_gtk_label_get_label;
  PangoLayout* function(GtkLabel* self) c_gtk_label_get_layout;
  void function(GtkLabel* self, int* x, int* y) c_gtk_label_get_layout_offsets;
  int function(GtkLabel* self) c_gtk_label_get_lines;
  int function(GtkLabel* self) c_gtk_label_get_max_width_chars;
  uint function(GtkLabel* self) c_gtk_label_get_mnemonic_keyval;
  GtkWidget* function(GtkLabel* self) c_gtk_label_get_mnemonic_widget;
  GtkNaturalWrapMode function(GtkLabel* self) c_gtk_label_get_natural_wrap_mode;
  bool function(GtkLabel* self) c_gtk_label_get_selectable;
  bool function(GtkLabel* self, int* start, int* end) c_gtk_label_get_selection_bounds;
  bool function(GtkLabel* self) c_gtk_label_get_single_line_mode;
  PangoTabArray* function(GtkLabel* self) c_gtk_label_get_tabs;
  const(char)* function(GtkLabel* self) c_gtk_label_get_text;
  bool function(GtkLabel* self) c_gtk_label_get_use_markup;
  bool function(GtkLabel* self) c_gtk_label_get_use_underline;
  int function(GtkLabel* self) c_gtk_label_get_width_chars;
  bool function(GtkLabel* self) c_gtk_label_get_wrap;
  PangoWrapMode function(GtkLabel* self) c_gtk_label_get_wrap_mode;
  float function(GtkLabel* self) c_gtk_label_get_xalign;
  float function(GtkLabel* self) c_gtk_label_get_yalign;
  void function(GtkLabel* self, int startOffset, int endOffset) c_gtk_label_select_region;
  void function(GtkLabel* self, PangoAttrList* attrs) c_gtk_label_set_attributes;
  void function(GtkLabel* self, PangoEllipsizeMode mode) c_gtk_label_set_ellipsize;
  void function(GtkLabel* self, GMenuModel* model) c_gtk_label_set_extra_menu;
  void function(GtkLabel* self, GtkJustification jtype) c_gtk_label_set_justify;
  void function(GtkLabel* self, const(char)* str) c_gtk_label_set_label;
  void function(GtkLabel* self, int lines) c_gtk_label_set_lines;
  void function(GtkLabel* self, const(char)* str) c_gtk_label_set_markup;
  void function(GtkLabel* self, const(char)* str) c_gtk_label_set_markup_with_mnemonic;
  void function(GtkLabel* self, int nChars) c_gtk_label_set_max_width_chars;
  void function(GtkLabel* self, GtkWidget* widget) c_gtk_label_set_mnemonic_widget;
  void function(GtkLabel* self, GtkNaturalWrapMode wrapMode) c_gtk_label_set_natural_wrap_mode;
  void function(GtkLabel* self, bool setting) c_gtk_label_set_selectable;
  void function(GtkLabel* self, bool singleLineMode) c_gtk_label_set_single_line_mode;
  void function(GtkLabel* self, PangoTabArray* tabs) c_gtk_label_set_tabs;
  void function(GtkLabel* self, const(char)* str) c_gtk_label_set_text;
  void function(GtkLabel* self, const(char)* str) c_gtk_label_set_text_with_mnemonic;
  void function(GtkLabel* self, bool setting) c_gtk_label_set_use_markup;
  void function(GtkLabel* self, bool setting) c_gtk_label_set_use_underline;
  void function(GtkLabel* self, int nChars) c_gtk_label_set_width_chars;
  void function(GtkLabel* self, bool wrap) c_gtk_label_set_wrap;
  void function(GtkLabel* self, PangoWrapMode wrapMode) c_gtk_label_set_wrap_mode;
  void function(GtkLabel* self, float xalign) c_gtk_label_set_xalign;
  void function(GtkLabel* self, float yalign) c_gtk_label_set_yalign;

  // LayoutChild
  GType function() c_gtk_layout_child_get_type;
  GtkWidget* function(GtkLayoutChild* layoutChild) c_gtk_layout_child_get_child_widget;
  GtkLayoutManager* function(GtkLayoutChild* layoutChild) c_gtk_layout_child_get_layout_manager;

  // LayoutManager
  GType function() c_gtk_layout_manager_get_type;
  void function(GtkLayoutManager* manager, GtkWidget* widget, int width, int height, int baseline) c_gtk_layout_manager_allocate;
  GtkLayoutChild* function(GtkLayoutManager* manager, GtkWidget* child) c_gtk_layout_manager_get_layout_child;
  GtkSizeRequestMode function(GtkLayoutManager* manager) c_gtk_layout_manager_get_request_mode;
  GtkWidget* function(GtkLayoutManager* manager) c_gtk_layout_manager_get_widget;
  void function(GtkLayoutManager* manager) c_gtk_layout_manager_layout_changed;
  void function(GtkLayoutManager* manager, GtkWidget* widget, GtkOrientation orientation, int forSize, int* minimum, int* natural, int* minimumBaseline, int* naturalBaseline) c_gtk_layout_manager_measure;

  // LevelBar
  GType function() c_gtk_level_bar_get_type;
  GtkWidget* function() c_gtk_level_bar_new;
  GtkWidget* function(double minValue, double maxValue) c_gtk_level_bar_new_for_interval;
  void function(GtkLevelBar* self, const(char)* name, double value) c_gtk_level_bar_add_offset_value;
  bool function(GtkLevelBar* self) c_gtk_level_bar_get_inverted;
  double function(GtkLevelBar* self) c_gtk_level_bar_get_max_value;
  double function(GtkLevelBar* self) c_gtk_level_bar_get_min_value;
  GtkLevelBarMode function(GtkLevelBar* self) c_gtk_level_bar_get_mode;
  bool function(GtkLevelBar* self, const(char)* name, double* value) c_gtk_level_bar_get_offset_value;
  double function(GtkLevelBar* self) c_gtk_level_bar_get_value;
  void function(GtkLevelBar* self, const(char)* name) c_gtk_level_bar_remove_offset_value;
  void function(GtkLevelBar* self, bool inverted) c_gtk_level_bar_set_inverted;
  void function(GtkLevelBar* self, double value) c_gtk_level_bar_set_max_value;
  void function(GtkLevelBar* self, double value) c_gtk_level_bar_set_min_value;
  void function(GtkLevelBar* self, GtkLevelBarMode mode) c_gtk_level_bar_set_mode;
  void function(GtkLevelBar* self, double value) c_gtk_level_bar_set_value;

  // LinkButton
  GType function() c_gtk_link_button_get_type;
  GtkWidget* function(const(char)* uri) c_gtk_link_button_new;
  GtkWidget* function(const(char)* uri, const(char)* label) c_gtk_link_button_new_with_label;
  const(char)* function(GtkLinkButton* linkButton) c_gtk_link_button_get_uri;
  bool function(GtkLinkButton* linkButton) c_gtk_link_button_get_visited;
  void function(GtkLinkButton* linkButton, const(char)* uri) c_gtk_link_button_set_uri;
  void function(GtkLinkButton* linkButton, bool visited) c_gtk_link_button_set_visited;

  // ListBase
  GType function() c_gtk_list_base_get_type;

  // ListBox
  GType function() c_gtk_list_box_get_type;
  GtkWidget* function() c_gtk_list_box_new;
  void function(GtkListBox* box, GtkWidget* child) c_gtk_list_box_append;
  void function(GtkListBox* box, GListModel* model, GtkListBoxCreateWidgetFunc createWidgetFunc, void* userData, GDestroyNotify userDataFreeFunc) c_gtk_list_box_bind_model;
  void function(GtkListBox* box, GtkListBoxRow* row) c_gtk_list_box_drag_highlight_row;
  void function(GtkListBox* box) c_gtk_list_box_drag_unhighlight_row;
  bool function(GtkListBox* box) c_gtk_list_box_get_activate_on_single_click;
  GtkAdjustment* function(GtkListBox* box) c_gtk_list_box_get_adjustment;
  GtkListBoxRow* function(GtkListBox* box, int index) c_gtk_list_box_get_row_at_index;
  GtkListBoxRow* function(GtkListBox* box, int y) c_gtk_list_box_get_row_at_y;
  GtkListBoxRow* function(GtkListBox* box) c_gtk_list_box_get_selected_row;
  GList* function(GtkListBox* box) c_gtk_list_box_get_selected_rows;
  GtkSelectionMode function(GtkListBox* box) c_gtk_list_box_get_selection_mode;
  bool function(GtkListBox* box) c_gtk_list_box_get_show_separators;
  void function(GtkListBox* box, GtkWidget* child, int position) c_gtk_list_box_insert;
  void function(GtkListBox* box) c_gtk_list_box_invalidate_filter;
  void function(GtkListBox* box) c_gtk_list_box_invalidate_headers;
  void function(GtkListBox* box) c_gtk_list_box_invalidate_sort;
  void function(GtkListBox* box, GtkWidget* child) c_gtk_list_box_prepend;
  void function(GtkListBox* box, GtkWidget* child) c_gtk_list_box_remove;
  void function(GtkListBox* box) c_gtk_list_box_remove_all;
  void function(GtkListBox* box) c_gtk_list_box_select_all;
  void function(GtkListBox* box, GtkListBoxRow* row) c_gtk_list_box_select_row;
  void function(GtkListBox* box, GtkListBoxForeachFunc func, void* data) c_gtk_list_box_selected_foreach;
  void function(GtkListBox* box, bool single) c_gtk_list_box_set_activate_on_single_click;
  void function(GtkListBox* box, GtkAdjustment* adjustment) c_gtk_list_box_set_adjustment;
  void function(GtkListBox* box, GtkListBoxFilterFunc filterFunc, void* userData, GDestroyNotify destroy) c_gtk_list_box_set_filter_func;
  void function(GtkListBox* box, GtkListBoxUpdateHeaderFunc updateHeader, void* userData, GDestroyNotify destroy) c_gtk_list_box_set_header_func;
  void function(GtkListBox* box, GtkWidget* placeholder) c_gtk_list_box_set_placeholder;
  void function(GtkListBox* box, GtkSelectionMode mode) c_gtk_list_box_set_selection_mode;
  void function(GtkListBox* box, bool showSeparators) c_gtk_list_box_set_show_separators;
  void function(GtkListBox* box, GtkListBoxSortFunc sortFunc, void* userData, GDestroyNotify destroy) c_gtk_list_box_set_sort_func;
  void function(GtkListBox* box) c_gtk_list_box_unselect_all;
  void function(GtkListBox* box, GtkListBoxRow* row) c_gtk_list_box_unselect_row;

  // ListBoxRow
  GType function() c_gtk_list_box_row_get_type;
  GtkWidget* function() c_gtk_list_box_row_new;
  void function(GtkListBoxRow* row) c_gtk_list_box_row_changed;
  bool function(GtkListBoxRow* row) c_gtk_list_box_row_get_activatable;
  GtkWidget* function(GtkListBoxRow* row) c_gtk_list_box_row_get_child;
  GtkWidget* function(GtkListBoxRow* row) c_gtk_list_box_row_get_header;
  int function(GtkListBoxRow* row) c_gtk_list_box_row_get_index;
  bool function(GtkListBoxRow* row) c_gtk_list_box_row_get_selectable;
  bool function(GtkListBoxRow* row) c_gtk_list_box_row_is_selected;
  void function(GtkListBoxRow* row, bool activatable) c_gtk_list_box_row_set_activatable;
  void function(GtkListBoxRow* row, GtkWidget* child) c_gtk_list_box_row_set_child;
  void function(GtkListBoxRow* row, GtkWidget* header) c_gtk_list_box_row_set_header;
  void function(GtkListBoxRow* row, bool selectable) c_gtk_list_box_row_set_selectable;

  // ListHeader
  GType function() c_gtk_list_header_get_type;
  GtkWidget* function(GtkListHeader* self) c_gtk_list_header_get_child;
  uint function(GtkListHeader* self) c_gtk_list_header_get_end;
  ObjectC* function(GtkListHeader* self) c_gtk_list_header_get_item;
  uint function(GtkListHeader* self) c_gtk_list_header_get_n_items;
  uint function(GtkListHeader* self) c_gtk_list_header_get_start;
  void function(GtkListHeader* self, GtkWidget* child) c_gtk_list_header_set_child;

  // ListItem
  GType function() c_gtk_list_item_get_type;
  const(char)* function(GtkListItem* self) c_gtk_list_item_get_accessible_description;
  const(char)* function(GtkListItem* self) c_gtk_list_item_get_accessible_label;
  bool function(GtkListItem* self) c_gtk_list_item_get_activatable;
  GtkWidget* function(GtkListItem* self) c_gtk_list_item_get_child;
  bool function(GtkListItem* self) c_gtk_list_item_get_focusable;
  ObjectC* function(GtkListItem* self) c_gtk_list_item_get_item;
  uint function(GtkListItem* self) c_gtk_list_item_get_position;
  bool function(GtkListItem* self) c_gtk_list_item_get_selectable;
  bool function(GtkListItem* self) c_gtk_list_item_get_selected;
  void function(GtkListItem* self, const(char)* description) c_gtk_list_item_set_accessible_description;
  void function(GtkListItem* self, const(char)* label) c_gtk_list_item_set_accessible_label;
  void function(GtkListItem* self, bool activatable) c_gtk_list_item_set_activatable;
  void function(GtkListItem* self, GtkWidget* child) c_gtk_list_item_set_child;
  void function(GtkListItem* self, bool focusable) c_gtk_list_item_set_focusable;
  void function(GtkListItem* self, bool selectable) c_gtk_list_item_set_selectable;

  // ListItemFactory
  GType function() c_gtk_list_item_factory_get_type;

  // ListStore
  GType function() c_gtk_list_store_get_type;
  GtkListStore* function(int nColumns,  ...) c_gtk_list_store_new;
  GtkListStore* function(int nColumns, GType* types) c_gtk_list_store_newv;
  void function(GtkListStore* listStore, GtkTreeIter* iter) c_gtk_list_store_append;
  void function(GtkListStore* listStore) c_gtk_list_store_clear;
  void function(GtkListStore* listStore, GtkTreeIter* iter, int position) c_gtk_list_store_insert;
  void function(GtkListStore* listStore, GtkTreeIter* iter, GtkTreeIter* sibling) c_gtk_list_store_insert_after;
  void function(GtkListStore* listStore, GtkTreeIter* iter, GtkTreeIter* sibling) c_gtk_list_store_insert_before;
  void function(GtkListStore* listStore, GtkTreeIter* iter, int position,  ...) c_gtk_list_store_insert_with_values;
  void function(GtkListStore* listStore, GtkTreeIter* iter, int position, int* columns, GValue* values, int nValues) c_gtk_list_store_insert_with_valuesv;
  bool function(GtkListStore* listStore, GtkTreeIter* iter) c_gtk_list_store_iter_is_valid;
  void function(GtkListStore* store, GtkTreeIter* iter, GtkTreeIter* position) c_gtk_list_store_move_after;
  void function(GtkListStore* store, GtkTreeIter* iter, GtkTreeIter* position) c_gtk_list_store_move_before;
  void function(GtkListStore* listStore, GtkTreeIter* iter) c_gtk_list_store_prepend;
  bool function(GtkListStore* listStore, GtkTreeIter* iter) c_gtk_list_store_remove;
  void function(GtkListStore* store, int* newOrder) c_gtk_list_store_reorder;
  void function(GtkListStore* listStore, GtkTreeIter* iter,  ...) c_gtk_list_store_set;
  void function(GtkListStore* listStore, int nColumns, GType* types) c_gtk_list_store_set_column_types;
  void function(GtkListStore* listStore, GtkTreeIter* iter, void* varArgs) c_gtk_list_store_set_valist;
  void function(GtkListStore* listStore, GtkTreeIter* iter, int column, GValue* value) c_gtk_list_store_set_value;
  void function(GtkListStore* listStore, GtkTreeIter* iter, int* columns, GValue* values, int nValues) c_gtk_list_store_set_valuesv;
  void function(GtkListStore* store, GtkTreeIter* a, GtkTreeIter* b) c_gtk_list_store_swap;

  // ListView
  GType function() c_gtk_list_view_get_type;
  GtkWidget* function(GtkSelectionModel* model, GtkListItemFactory* factory) c_gtk_list_view_new;
  bool function(GtkListView* self) c_gtk_list_view_get_enable_rubberband;
  GtkListItemFactory* function(GtkListView* self) c_gtk_list_view_get_factory;
  GtkListItemFactory* function(GtkListView* self) c_gtk_list_view_get_header_factory;
  GtkSelectionModel* function(GtkListView* self) c_gtk_list_view_get_model;
  bool function(GtkListView* self) c_gtk_list_view_get_show_separators;
  bool function(GtkListView* self) c_gtk_list_view_get_single_click_activate;
  GtkListTabBehavior function(GtkListView* self) c_gtk_list_view_get_tab_behavior;
  void function(GtkListView* self, uint pos, GtkListScrollFlags flags, GtkScrollInfo* scroll) c_gtk_list_view_scroll_to;
  void function(GtkListView* self, bool enableRubberband) c_gtk_list_view_set_enable_rubberband;
  void function(GtkListView* self, GtkListItemFactory* factory) c_gtk_list_view_set_factory;
  void function(GtkListView* self, GtkListItemFactory* factory) c_gtk_list_view_set_header_factory;
  void function(GtkListView* self, GtkSelectionModel* model) c_gtk_list_view_set_model;
  void function(GtkListView* self, bool showSeparators) c_gtk_list_view_set_show_separators;
  void function(GtkListView* self, bool singleClickActivate) c_gtk_list_view_set_single_click_activate;
  void function(GtkListView* self, GtkListTabBehavior tabBehavior) c_gtk_list_view_set_tab_behavior;

  // LockButton
  GType function() c_gtk_lock_button_get_type;
  GtkWidget* function(GPermission* permission) c_gtk_lock_button_new;
  GPermission* function(GtkLockButton* button) c_gtk_lock_button_get_permission;
  void function(GtkLockButton* button, GPermission* permission) c_gtk_lock_button_set_permission;

  // MapListModel
  GType function() c_gtk_map_list_model_get_type;
  GtkMapListModel* function(GListModel* model, GtkMapListModelMapFunc mapFunc, void* userData, GDestroyNotify userDestroy) c_gtk_map_list_model_new;
  GListModel* function(GtkMapListModel* self) c_gtk_map_list_model_get_model;
  bool function(GtkMapListModel* self) c_gtk_map_list_model_has_map;
  void function(GtkMapListModel* self, GtkMapListModelMapFunc mapFunc, void* userData, GDestroyNotify userDestroy) c_gtk_map_list_model_set_map_func;
  void function(GtkMapListModel* self, GListModel* model) c_gtk_map_list_model_set_model;

  // MediaControls
  GType function() c_gtk_media_controls_get_type;
  GtkWidget* function(GtkMediaStream* stream) c_gtk_media_controls_new;
  GtkMediaStream* function(GtkMediaControls* controls) c_gtk_media_controls_get_media_stream;
  void function(GtkMediaControls* controls, GtkMediaStream* stream) c_gtk_media_controls_set_media_stream;

  // MediaFile
  GType function() c_gtk_media_file_get_type;
  GtkMediaStream* function() c_gtk_media_file_new;
  GtkMediaStream* function(GFile* file) c_gtk_media_file_new_for_file;
  GtkMediaStream* function(const(char)* filename) c_gtk_media_file_new_for_filename;
  GtkMediaStream* function(GInputStream* stream) c_gtk_media_file_new_for_input_stream;
  GtkMediaStream* function(const(char)* resourcePath) c_gtk_media_file_new_for_resource;
  void function(GtkMediaFile* self) c_gtk_media_file_clear;
  GFile* function(GtkMediaFile* self) c_gtk_media_file_get_file;
  GInputStream* function(GtkMediaFile* self) c_gtk_media_file_get_input_stream;
  void function(GtkMediaFile* self, GFile* file) c_gtk_media_file_set_file;
  void function(GtkMediaFile* self, const(char)* filename) c_gtk_media_file_set_filename;
  void function(GtkMediaFile* self, GInputStream* stream) c_gtk_media_file_set_input_stream;
  void function(GtkMediaFile* self, const(char)* resourcePath) c_gtk_media_file_set_resource;

  // MediaStream
  GType function() c_gtk_media_stream_get_type;
  void function(GtkMediaStream* self) c_gtk_media_stream_ended;
  void function(GtkMediaStream* self, GQuark domain, int code, const(char)* format,  ...) c_gtk_media_stream_error;
  void function(GtkMediaStream* self, GQuark domain, int code, const(char)* format, void* args) c_gtk_media_stream_error_valist;
  void function(GtkMediaStream* self, GError* error) c_gtk_media_stream_gerror;
  long function(GtkMediaStream* self) c_gtk_media_stream_get_duration;
  bool function(GtkMediaStream* self) c_gtk_media_stream_get_ended;
  const(GError)* function(GtkMediaStream* self) c_gtk_media_stream_get_error;
  bool function(GtkMediaStream* self) c_gtk_media_stream_get_loop;
  bool function(GtkMediaStream* self) c_gtk_media_stream_get_muted;
  bool function(GtkMediaStream* self) c_gtk_media_stream_get_playing;
  long function(GtkMediaStream* self) c_gtk_media_stream_get_timestamp;
  double function(GtkMediaStream* self) c_gtk_media_stream_get_volume;
  bool function(GtkMediaStream* self) c_gtk_media_stream_has_audio;
  bool function(GtkMediaStream* self) c_gtk_media_stream_has_video;
  bool function(GtkMediaStream* self) c_gtk_media_stream_is_prepared;
  bool function(GtkMediaStream* self) c_gtk_media_stream_is_seekable;
  bool function(GtkMediaStream* self) c_gtk_media_stream_is_seeking;
  void function(GtkMediaStream* self) c_gtk_media_stream_pause;
  void function(GtkMediaStream* self) c_gtk_media_stream_play;
  void function(GtkMediaStream* self, bool hasAudio, bool hasVideo, bool seekable, long duration) c_gtk_media_stream_prepared;
  void function(GtkMediaStream* self, GdkSurface* surface) c_gtk_media_stream_realize;
  void function(GtkMediaStream* self, long timestamp) c_gtk_media_stream_seek;
  void function(GtkMediaStream* self) c_gtk_media_stream_seek_failed;
  void function(GtkMediaStream* self) c_gtk_media_stream_seek_success;
  void function(GtkMediaStream* self, bool loop) c_gtk_media_stream_set_loop;
  void function(GtkMediaStream* self, bool muted) c_gtk_media_stream_set_muted;
  void function(GtkMediaStream* self, bool playing) c_gtk_media_stream_set_playing;
  void function(GtkMediaStream* self, double volume) c_gtk_media_stream_set_volume;
  void function(GtkMediaStream* self) c_gtk_media_stream_stream_ended;
  void function(GtkMediaStream* self, bool hasAudio, bool hasVideo, bool seekable, long duration) c_gtk_media_stream_stream_prepared;
  void function(GtkMediaStream* self) c_gtk_media_stream_stream_unprepared;
  void function(GtkMediaStream* self) c_gtk_media_stream_unprepared;
  void function(GtkMediaStream* self, GdkSurface* surface) c_gtk_media_stream_unrealize;
  void function(GtkMediaStream* self, long timestamp) c_gtk_media_stream_update;

  // MenuButton
  GType function() c_gtk_menu_button_get_type;
  GtkWidget* function() c_gtk_menu_button_new;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_active;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_always_show_arrow;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_can_shrink;
  GtkWidget* function(GtkMenuButton* menuButton) c_gtk_menu_button_get_child;
  GtkArrowType function(GtkMenuButton* menuButton) c_gtk_menu_button_get_direction;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_has_frame;
  const(char)* function(GtkMenuButton* menuButton) c_gtk_menu_button_get_icon_name;
  const(char)* function(GtkMenuButton* menuButton) c_gtk_menu_button_get_label;
  GMenuModel* function(GtkMenuButton* menuButton) c_gtk_menu_button_get_menu_model;
  GtkPopover* function(GtkMenuButton* menuButton) c_gtk_menu_button_get_popover;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_primary;
  bool function(GtkMenuButton* menuButton) c_gtk_menu_button_get_use_underline;
  void function(GtkMenuButton* menuButton) c_gtk_menu_button_popdown;
  void function(GtkMenuButton* menuButton) c_gtk_menu_button_popup;
  void function(GtkMenuButton* menuButton, bool active) c_gtk_menu_button_set_active;
  void function(GtkMenuButton* menuButton, bool alwaysShowArrow) c_gtk_menu_button_set_always_show_arrow;
  void function(GtkMenuButton* menuButton, bool canShrink) c_gtk_menu_button_set_can_shrink;
  void function(GtkMenuButton* menuButton, GtkWidget* child) c_gtk_menu_button_set_child;
  void function(GtkMenuButton* menuButton, GtkMenuButtonCreatePopupFunc func, void* userData, GDestroyNotify destroyNotify) c_gtk_menu_button_set_create_popup_func;
  void function(GtkMenuButton* menuButton, GtkArrowType direction) c_gtk_menu_button_set_direction;
  void function(GtkMenuButton* menuButton, bool hasFrame) c_gtk_menu_button_set_has_frame;
  void function(GtkMenuButton* menuButton, const(char)* iconName) c_gtk_menu_button_set_icon_name;
  void function(GtkMenuButton* menuButton, const(char)* label) c_gtk_menu_button_set_label;
  void function(GtkMenuButton* menuButton, GMenuModel* menuModel) c_gtk_menu_button_set_menu_model;
  void function(GtkMenuButton* menuButton, GtkWidget* popover) c_gtk_menu_button_set_popover;
  void function(GtkMenuButton* menuButton, bool primary) c_gtk_menu_button_set_primary;
  void function(GtkMenuButton* menuButton, bool useUnderline) c_gtk_menu_button_set_use_underline;

  // MessageDialog
  GType function() c_gtk_message_dialog_get_type;
  GtkWidget* function(GtkWindow* parent, GtkDialogFlags flags, GtkMessageType type, GtkButtonsType buttons, const(char)* messageFormat,  ...) c_gtk_message_dialog_new;
  GtkWidget* function(GtkWindow* parent, GtkDialogFlags flags, GtkMessageType type, GtkButtonsType buttons, const(char)* messageFormat,  ...) c_gtk_message_dialog_new_with_markup;
  void function(GtkMessageDialog* messageDialog, const(char)* messageFormat,  ...) c_gtk_message_dialog_format_secondary_markup;
  void function(GtkMessageDialog* messageDialog, const(char)* messageFormat,  ...) c_gtk_message_dialog_format_secondary_text;
  GtkWidget* function(GtkMessageDialog* messageDialog) c_gtk_message_dialog_get_message_area;
  void function(GtkMessageDialog* messageDialog, const(char)* str) c_gtk_message_dialog_set_markup;

  // MnemonicAction
  GType function() c_gtk_mnemonic_action_get_type;
  GtkShortcutAction* function() c_gtk_mnemonic_action_get;

  // MnemonicTrigger
  GType function() c_gtk_mnemonic_trigger_get_type;
  GtkShortcutTrigger* function(uint keyval) c_gtk_mnemonic_trigger_new;
  uint function(GtkMnemonicTrigger* self) c_gtk_mnemonic_trigger_get_keyval;

  // MountOperation
  GType function() c_gtk_mount_operation_get_type;
  GMountOperation* function(GtkWindow* parent) c_gtk_mount_operation_new;
  GdkDisplay* function(GtkMountOperation* op) c_gtk_mount_operation_get_display;
  GtkWindow* function(GtkMountOperation* op) c_gtk_mount_operation_get_parent;
  bool function(GtkMountOperation* op) c_gtk_mount_operation_is_showing;
  void function(GtkMountOperation* op, GdkDisplay* display) c_gtk_mount_operation_set_display;
  void function(GtkMountOperation* op, GtkWindow* parent) c_gtk_mount_operation_set_parent;

  // MultiFilter
  GType function() c_gtk_multi_filter_get_type;
  void function(GtkMultiFilter* self, GtkFilter* filter) c_gtk_multi_filter_append;
  void function(GtkMultiFilter* self, uint position) c_gtk_multi_filter_remove;

  // MultiSelection
  GType function() c_gtk_multi_selection_get_type;
  GtkMultiSelection* function(GListModel* model) c_gtk_multi_selection_new;
  GListModel* function(GtkMultiSelection* self) c_gtk_multi_selection_get_model;
  void function(GtkMultiSelection* self, GListModel* model) c_gtk_multi_selection_set_model;

  // MultiSorter
  GType function() c_gtk_multi_sorter_get_type;
  GtkMultiSorter* function() c_gtk_multi_sorter_new;
  void function(GtkMultiSorter* self, GtkSorter* sorter) c_gtk_multi_sorter_append;
  void function(GtkMultiSorter* self, uint position) c_gtk_multi_sorter_remove;

  // NamedAction
  GType function() c_gtk_named_action_get_type;
  GtkShortcutAction* function(const(char)* name) c_gtk_named_action_new;
  const(char)* function(GtkNamedAction* self) c_gtk_named_action_get_action_name;

  // Native
  GType function() c_gtk_native_get_type;
  GtkNative* function(GdkSurface* surface) c_gtk_native_get_for_surface;
  GskRenderer* function(GtkNative* self) c_gtk_native_get_renderer;
  GdkSurface* function(GtkNative* self) c_gtk_native_get_surface;
  void function(GtkNative* self, double* x, double* y) c_gtk_native_get_surface_transform;
  void function(GtkNative* self) c_gtk_native_realize;
  void function(GtkNative* self) c_gtk_native_unrealize;

  // NativeDialog
  GType function() c_gtk_native_dialog_get_type;
  void function(GtkNativeDialog* self) c_gtk_native_dialog_destroy;
  bool function(GtkNativeDialog* self) c_gtk_native_dialog_get_modal;
  const(char)* function(GtkNativeDialog* self) c_gtk_native_dialog_get_title;
  GtkWindow* function(GtkNativeDialog* self) c_gtk_native_dialog_get_transient_for;
  bool function(GtkNativeDialog* self) c_gtk_native_dialog_get_visible;
  void function(GtkNativeDialog* self) c_gtk_native_dialog_hide;
  void function(GtkNativeDialog* self, bool modal) c_gtk_native_dialog_set_modal;
  void function(GtkNativeDialog* self, const(char)* title) c_gtk_native_dialog_set_title;
  void function(GtkNativeDialog* self, GtkWindow* parent) c_gtk_native_dialog_set_transient_for;
  void function(GtkNativeDialog* self) c_gtk_native_dialog_show;

  // NeverTrigger
  GType function() c_gtk_never_trigger_get_type;
  GtkShortcutTrigger* function() c_gtk_never_trigger_get;

  // NoSelection
  GType function() c_gtk_no_selection_get_type;
  GtkNoSelection* function(GListModel* model) c_gtk_no_selection_new;
  GListModel* function(GtkNoSelection* self) c_gtk_no_selection_get_model;
  void function(GtkNoSelection* self, GListModel* model) c_gtk_no_selection_set_model;

  // Notebook
  GType function() c_gtk_notebook_get_type;
  GtkWidget* function() c_gtk_notebook_new;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel) c_gtk_notebook_append_page;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel, GtkWidget* menuLabel) c_gtk_notebook_append_page_menu;
  void function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_detach_tab;
  GtkWidget* function(GtkNotebook* notebook, GtkPackType packType) c_gtk_notebook_get_action_widget;
  int function(GtkNotebook* notebook) c_gtk_notebook_get_current_page;
  const(char)* function(GtkNotebook* notebook) c_gtk_notebook_get_group_name;
  GtkWidget* function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_menu_label;
  const(char)* function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_menu_label_text;
  int function(GtkNotebook* notebook) c_gtk_notebook_get_n_pages;
  GtkWidget* function(GtkNotebook* notebook, int pageNum) c_gtk_notebook_get_nth_page;
  GtkNotebookPage* function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_page;
  GListModel* function(GtkNotebook* notebook) c_gtk_notebook_get_pages;
  bool function(GtkNotebook* notebook) c_gtk_notebook_get_scrollable;
  bool function(GtkNotebook* notebook) c_gtk_notebook_get_show_border;
  bool function(GtkNotebook* notebook) c_gtk_notebook_get_show_tabs;
  bool function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_tab_detachable;
  GtkWidget* function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_tab_label;
  const(char)* function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_tab_label_text;
  GtkPositionType function(GtkNotebook* notebook) c_gtk_notebook_get_tab_pos;
  bool function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_get_tab_reorderable;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel, int position) c_gtk_notebook_insert_page;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel, GtkWidget* menuLabel, int position) c_gtk_notebook_insert_page_menu;
  void function(GtkNotebook* notebook) c_gtk_notebook_next_page;
  int function(GtkNotebook* notebook, GtkWidget* child) c_gtk_notebook_page_num;
  void function(GtkNotebook* notebook) c_gtk_notebook_popup_disable;
  void function(GtkNotebook* notebook) c_gtk_notebook_popup_enable;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel) c_gtk_notebook_prepend_page;
  int function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel, GtkWidget* menuLabel) c_gtk_notebook_prepend_page_menu;
  void function(GtkNotebook* notebook) c_gtk_notebook_prev_page;
  void function(GtkNotebook* notebook, int pageNum) c_gtk_notebook_remove_page;
  void function(GtkNotebook* notebook, GtkWidget* child, int position) c_gtk_notebook_reorder_child;
  void function(GtkNotebook* notebook, GtkWidget* widget, GtkPackType packType) c_gtk_notebook_set_action_widget;
  void function(GtkNotebook* notebook, int pageNum) c_gtk_notebook_set_current_page;
  void function(GtkNotebook* notebook, const(char)* groupName) c_gtk_notebook_set_group_name;
  void function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* menuLabel) c_gtk_notebook_set_menu_label;
  void function(GtkNotebook* notebook, GtkWidget* child, const(char)* menuText) c_gtk_notebook_set_menu_label_text;
  void function(GtkNotebook* notebook, bool scrollable) c_gtk_notebook_set_scrollable;
  void function(GtkNotebook* notebook, bool showBorder) c_gtk_notebook_set_show_border;
  void function(GtkNotebook* notebook, bool showTabs) c_gtk_notebook_set_show_tabs;
  void function(GtkNotebook* notebook, GtkWidget* child, bool detachable) c_gtk_notebook_set_tab_detachable;
  void function(GtkNotebook* notebook, GtkWidget* child, GtkWidget* tabLabel) c_gtk_notebook_set_tab_label;
  void function(GtkNotebook* notebook, GtkWidget* child, const(char)* tabText) c_gtk_notebook_set_tab_label_text;
  void function(GtkNotebook* notebook, GtkPositionType pos) c_gtk_notebook_set_tab_pos;
  void function(GtkNotebook* notebook, GtkWidget* child, bool reorderable) c_gtk_notebook_set_tab_reorderable;

  // NotebookPage
  GType function() c_gtk_notebook_page_get_type;
  GtkWidget* function(GtkNotebookPage* page) c_gtk_notebook_page_get_child;

  // NothingAction
  GType function() c_gtk_nothing_action_get_type;
  GtkShortcutAction* function() c_gtk_nothing_action_get;

  // NumericSorter
  GType function() c_gtk_numeric_sorter_get_type;
  GtkNumericSorter* function(GtkExpression* expression) c_gtk_numeric_sorter_new;
  GtkExpression* function(GtkNumericSorter* self) c_gtk_numeric_sorter_get_expression;
  GtkSortType function(GtkNumericSorter* self) c_gtk_numeric_sorter_get_sort_order;
  void function(GtkNumericSorter* self, GtkExpression* expression) c_gtk_numeric_sorter_set_expression;
  void function(GtkNumericSorter* self, GtkSortType sortOrder) c_gtk_numeric_sorter_set_sort_order;

  // ObjectExpression
  GType function() c_gtk_object_expression_get_type;
  GtkExpression* function(ObjectC* object) c_gtk_object_expression_new;
  ObjectC* function(GtkExpression* expression) c_gtk_object_expression_get_object;

  // Orientable
  GType function() c_gtk_orientable_get_type;
  GtkOrientation function(GtkOrientable* orientable) c_gtk_orientable_get_orientation;
  void function(GtkOrientable* orientable, GtkOrientation orientation) c_gtk_orientable_set_orientation;

  // Overlay
  GType function() c_gtk_overlay_get_type;
  GtkWidget* function() c_gtk_overlay_new;
  void function(GtkOverlay* overlay, GtkWidget* widget) c_gtk_overlay_add_overlay;
  GtkWidget* function(GtkOverlay* overlay) c_gtk_overlay_get_child;
  bool function(GtkOverlay* overlay, GtkWidget* widget) c_gtk_overlay_get_clip_overlay;
  bool function(GtkOverlay* overlay, GtkWidget* widget) c_gtk_overlay_get_measure_overlay;
  void function(GtkOverlay* overlay, GtkWidget* widget) c_gtk_overlay_remove_overlay;
  void function(GtkOverlay* overlay, GtkWidget* child) c_gtk_overlay_set_child;
  void function(GtkOverlay* overlay, GtkWidget* widget, bool clipOverlay) c_gtk_overlay_set_clip_overlay;
  void function(GtkOverlay* overlay, GtkWidget* widget, bool measure) c_gtk_overlay_set_measure_overlay;

  // OverlayLayout
  GType function() c_gtk_overlay_layout_get_type;
  GtkLayoutManager* function() c_gtk_overlay_layout_new;

  // OverlayLayoutChild
  GType function() c_gtk_overlay_layout_child_get_type;
  bool function(GtkOverlayLayoutChild* child) c_gtk_overlay_layout_child_get_clip_overlay;
  bool function(GtkOverlayLayoutChild* child) c_gtk_overlay_layout_child_get_measure;
  void function(GtkOverlayLayoutChild* child, bool clipOverlay) c_gtk_overlay_layout_child_set_clip_overlay;
  void function(GtkOverlayLayoutChild* child, bool measure) c_gtk_overlay_layout_child_set_measure;

  // PadController
  GType function() c_gtk_pad_controller_get_type;
  GtkPadController* function(GActionGroup* group, GdkDevice* pad) c_gtk_pad_controller_new;
  void function(GtkPadController* controller, GtkPadActionType type, int index, int mode, const(char)* label, const(char)* actionName) c_gtk_pad_controller_set_action;
  void function(GtkPadController* controller, const(GtkPadActionEntry)* entries, int nEntries) c_gtk_pad_controller_set_action_entries;

  // PageSetup
  GType function() c_gtk_page_setup_get_type;
  GtkPageSetup* function() c_gtk_page_setup_new;
  GtkPageSetup* function(const(char)* fileName, GError** _err) c_gtk_page_setup_new_from_file;
  GtkPageSetup* function(VariantC* variant) c_gtk_page_setup_new_from_gvariant;
  GtkPageSetup* function(GKeyFile* keyFile, const(char)* groupName, GError** _err) c_gtk_page_setup_new_from_key_file;
  GtkPageSetup* function(GtkPageSetup* other) c_gtk_page_setup_copy;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_bottom_margin;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_left_margin;
  GtkPageOrientation function(GtkPageSetup* setup) c_gtk_page_setup_get_orientation;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_page_height;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_page_width;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_paper_height;
  GtkPaperSize* function(GtkPageSetup* setup) c_gtk_page_setup_get_paper_size;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_paper_width;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_right_margin;
  double function(GtkPageSetup* setup, GtkUnit unit) c_gtk_page_setup_get_top_margin;
  bool function(GtkPageSetup* setup, const(char)* fileName, GError** _err) c_gtk_page_setup_load_file;
  bool function(GtkPageSetup* setup, GKeyFile* keyFile, const(char)* groupName, GError** _err) c_gtk_page_setup_load_key_file;
  void function(GtkPageSetup* setup, double margin, GtkUnit unit) c_gtk_page_setup_set_bottom_margin;
  void function(GtkPageSetup* setup, double margin, GtkUnit unit) c_gtk_page_setup_set_left_margin;
  void function(GtkPageSetup* setup, GtkPageOrientation orientation) c_gtk_page_setup_set_orientation;
  void function(GtkPageSetup* setup, GtkPaperSize* size) c_gtk_page_setup_set_paper_size;
  void function(GtkPageSetup* setup, GtkPaperSize* size) c_gtk_page_setup_set_paper_size_and_default_margins;
  void function(GtkPageSetup* setup, double margin, GtkUnit unit) c_gtk_page_setup_set_right_margin;
  void function(GtkPageSetup* setup, double margin, GtkUnit unit) c_gtk_page_setup_set_top_margin;
  bool function(GtkPageSetup* setup, const(char)* fileName, GError** _err) c_gtk_page_setup_to_file;
  VariantC* function(GtkPageSetup* setup) c_gtk_page_setup_to_gvariant;
  void function(GtkPageSetup* setup, GKeyFile* keyFile, const(char)* groupName) c_gtk_page_setup_to_key_file;

  // PageSetupUnixDialog
  GType function() c_gtk_page_setup_unix_dialog_get_type;
  GtkWidget* function(const(char)* title, GtkWindow* parent) c_gtk_page_setup_unix_dialog_new;
  GtkPageSetup* function(GtkPageSetupUnixDialog* dialog) c_gtk_page_setup_unix_dialog_get_page_setup;
  GtkPrintSettings* function(GtkPageSetupUnixDialog* dialog) c_gtk_page_setup_unix_dialog_get_print_settings;
  void function(GtkPageSetupUnixDialog* dialog, GtkPageSetup* pageSetup) c_gtk_page_setup_unix_dialog_set_page_setup;
  void function(GtkPageSetupUnixDialog* dialog, GtkPrintSettings* printSettings) c_gtk_page_setup_unix_dialog_set_print_settings;

  // Paned
  GType function() c_gtk_paned_get_type;
  GtkWidget* function(GtkOrientation orientation) c_gtk_paned_new;
  GtkWidget* function(GtkPaned* paned) c_gtk_paned_get_end_child;
  int function(GtkPaned* paned) c_gtk_paned_get_position;
  bool function(GtkPaned* paned) c_gtk_paned_get_resize_end_child;
  bool function(GtkPaned* paned) c_gtk_paned_get_resize_start_child;
  bool function(GtkPaned* paned) c_gtk_paned_get_shrink_end_child;
  bool function(GtkPaned* paned) c_gtk_paned_get_shrink_start_child;
  GtkWidget* function(GtkPaned* paned) c_gtk_paned_get_start_child;
  bool function(GtkPaned* paned) c_gtk_paned_get_wide_handle;
  void function(GtkPaned* paned, GtkWidget* child) c_gtk_paned_set_end_child;
  void function(GtkPaned* paned, int position) c_gtk_paned_set_position;
  void function(GtkPaned* paned, bool resize) c_gtk_paned_set_resize_end_child;
  void function(GtkPaned* paned, bool resize) c_gtk_paned_set_resize_start_child;
  void function(GtkPaned* paned, bool resize) c_gtk_paned_set_shrink_end_child;
  void function(GtkPaned* paned, bool resize) c_gtk_paned_set_shrink_start_child;
  void function(GtkPaned* paned, GtkWidget* child) c_gtk_paned_set_start_child;
  void function(GtkPaned* paned, bool wide) c_gtk_paned_set_wide_handle;

  // PaperSize
  GType function() c_gtk_paper_size_get_type;
  GtkPaperSize* function(const(char)* name) c_gtk_paper_size_new;
  GtkPaperSize* function(const(char)* name, const(char)* displayName, double width, double height, GtkUnit unit) c_gtk_paper_size_new_custom;
  GtkPaperSize* function(VariantC* variant) c_gtk_paper_size_new_from_gvariant;
  GtkPaperSize* function(const(char)* ippName, double width, double height) c_gtk_paper_size_new_from_ipp;
  GtkPaperSize* function(GKeyFile* keyFile, const(char)* groupName, GError** _err) c_gtk_paper_size_new_from_key_file;
  GtkPaperSize* function(const(char)* ppdName, const(char)* ppdDisplayName, double width, double height) c_gtk_paper_size_new_from_ppd;
  GtkPaperSize* function(GtkPaperSize* other) c_gtk_paper_size_copy;
  void function(GtkPaperSize* size) c_gtk_paper_size_free;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_default_bottom_margin;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_default_left_margin;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_default_right_margin;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_default_top_margin;
  const(char)* function(GtkPaperSize* size) c_gtk_paper_size_get_display_name;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_height;
  const(char)* function(GtkPaperSize* size) c_gtk_paper_size_get_name;
  const(char)* function(GtkPaperSize* size) c_gtk_paper_size_get_ppd_name;
  double function(GtkPaperSize* size, GtkUnit unit) c_gtk_paper_size_get_width;
  bool function(GtkPaperSize* size) c_gtk_paper_size_is_custom;
  bool function(GtkPaperSize* size1, GtkPaperSize* size2) c_gtk_paper_size_is_equal;
  bool function(GtkPaperSize* size) c_gtk_paper_size_is_ipp;
  void function(GtkPaperSize* size, double width, double height, GtkUnit unit) c_gtk_paper_size_set_size;
  VariantC* function(GtkPaperSize* paperSize) c_gtk_paper_size_to_gvariant;
  void function(GtkPaperSize* size, GKeyFile* keyFile, const(char)* groupName) c_gtk_paper_size_to_key_file;
  const(char)* function() c_gtk_paper_size_get_default;
  GList* function(bool includeCustom) c_gtk_paper_size_get_paper_sizes;

  // ParamSpecExpression
  GType function() c_gtk_param_expression_get_type;

  // PasswordEntry
  GType function() c_gtk_password_entry_get_type;
  GtkWidget* function() c_gtk_password_entry_new;
  GMenuModel* function(GtkPasswordEntry* entry) c_gtk_password_entry_get_extra_menu;
  bool function(GtkPasswordEntry* entry) c_gtk_password_entry_get_show_peek_icon;
  void function(GtkPasswordEntry* entry, GMenuModel* model) c_gtk_password_entry_set_extra_menu;
  void function(GtkPasswordEntry* entry, bool showPeekIcon) c_gtk_password_entry_set_show_peek_icon;

  // PasswordEntryBuffer
  GType function() c_gtk_password_entry_buffer_get_type;
  GtkEntryBuffer* function() c_gtk_password_entry_buffer_new;

  // Picture
  GType function() c_gtk_picture_get_type;
  GtkWidget* function() c_gtk_picture_new;
  GtkWidget* function(GFile* file) c_gtk_picture_new_for_file;
  GtkWidget* function(const(char)* filename) c_gtk_picture_new_for_filename;
  GtkWidget* function(GdkPaintable* paintable) c_gtk_picture_new_for_paintable;
  GtkWidget* function(PixbufC* pixbuf) c_gtk_picture_new_for_pixbuf;
  GtkWidget* function(const(char)* resourcePath) c_gtk_picture_new_for_resource;
  const(char)* function(GtkPicture* self) c_gtk_picture_get_alternative_text;
  bool function(GtkPicture* self) c_gtk_picture_get_can_shrink;
  GtkContentFit function(GtkPicture* self) c_gtk_picture_get_content_fit;
  GFile* function(GtkPicture* self) c_gtk_picture_get_file;
  bool function(GtkPicture* self) c_gtk_picture_get_keep_aspect_ratio;
  GdkPaintable* function(GtkPicture* self) c_gtk_picture_get_paintable;
  void function(GtkPicture* self, const(char)* alternativeText) c_gtk_picture_set_alternative_text;
  void function(GtkPicture* self, bool canShrink) c_gtk_picture_set_can_shrink;
  void function(GtkPicture* self, GtkContentFit contentFit) c_gtk_picture_set_content_fit;
  void function(GtkPicture* self, GFile* file) c_gtk_picture_set_file;
  void function(GtkPicture* self, const(char)* filename) c_gtk_picture_set_filename;
  void function(GtkPicture* self, bool keepAspectRatio) c_gtk_picture_set_keep_aspect_ratio;
  void function(GtkPicture* self, GdkPaintable* paintable) c_gtk_picture_set_paintable;
  void function(GtkPicture* self, PixbufC* pixbuf) c_gtk_picture_set_pixbuf;
  void function(GtkPicture* self, const(char)* resourcePath) c_gtk_picture_set_resource;

  // Popover
  GType function() c_gtk_popover_get_type;
  GtkWidget* function() c_gtk_popover_new;
  bool function(GtkPopover* popover) c_gtk_popover_get_autohide;
  bool function(GtkPopover* popover) c_gtk_popover_get_cascade_popdown;
  GtkWidget* function(GtkPopover* popover) c_gtk_popover_get_child;
  bool function(GtkPopover* popover) c_gtk_popover_get_has_arrow;
  bool function(GtkPopover* popover) c_gtk_popover_get_mnemonics_visible;
  void function(GtkPopover* popover, int* xOffset, int* yOffset) c_gtk_popover_get_offset;
  bool function(GtkPopover* popover, GdkRectangle* rect) c_gtk_popover_get_pointing_to;
  GtkPositionType function(GtkPopover* popover) c_gtk_popover_get_position;
  void function(GtkPopover* popover) c_gtk_popover_popdown;
  void function(GtkPopover* popover) c_gtk_popover_popup;
  void function(GtkPopover* popover) c_gtk_popover_present;
  void function(GtkPopover* popover, bool autohide) c_gtk_popover_set_autohide;
  void function(GtkPopover* popover, bool cascadePopdown) c_gtk_popover_set_cascade_popdown;
  void function(GtkPopover* popover, GtkWidget* child) c_gtk_popover_set_child;
  void function(GtkPopover* popover, GtkWidget* widget) c_gtk_popover_set_default_widget;
  void function(GtkPopover* popover, bool hasArrow) c_gtk_popover_set_has_arrow;
  void function(GtkPopover* popover, bool mnemonicsVisible) c_gtk_popover_set_mnemonics_visible;
  void function(GtkPopover* popover, int xOffset, int yOffset) c_gtk_popover_set_offset;
  void function(GtkPopover* popover, const(GdkRectangle)* rect) c_gtk_popover_set_pointing_to;
  void function(GtkPopover* popover, GtkPositionType position) c_gtk_popover_set_position;

  // PopoverMenu
  GType function() c_gtk_popover_menu_get_type;
  GtkWidget* function(GMenuModel* model) c_gtk_popover_menu_new_from_model;
  GtkWidget* function(GMenuModel* model, GtkPopoverMenuFlags flags) c_gtk_popover_menu_new_from_model_full;
  bool function(GtkPopoverMenu* popover, GtkWidget* child, const(char)* id) c_gtk_popover_menu_add_child;
  GtkPopoverMenuFlags function(GtkPopoverMenu* popover) c_gtk_popover_menu_get_flags;
  GMenuModel* function(GtkPopoverMenu* popover) c_gtk_popover_menu_get_menu_model;
  bool function(GtkPopoverMenu* popover, GtkWidget* child) c_gtk_popover_menu_remove_child;
  void function(GtkPopoverMenu* popover, GtkPopoverMenuFlags flags) c_gtk_popover_menu_set_flags;
  void function(GtkPopoverMenu* popover, GMenuModel* model) c_gtk_popover_menu_set_menu_model;

  // PopoverMenuBar
  GType function() c_gtk_popover_menu_bar_get_type;
  GtkWidget* function(GMenuModel* model) c_gtk_popover_menu_bar_new_from_model;
  bool function(GtkPopoverMenuBar* bar, GtkWidget* child, const(char)* id) c_gtk_popover_menu_bar_add_child;
  GMenuModel* function(GtkPopoverMenuBar* bar) c_gtk_popover_menu_bar_get_menu_model;
  bool function(GtkPopoverMenuBar* bar, GtkWidget* child) c_gtk_popover_menu_bar_remove_child;
  void function(GtkPopoverMenuBar* bar, GMenuModel* model) c_gtk_popover_menu_bar_set_menu_model;

  // PrintContext
  GType function() c_gtk_print_context_get_type;
  PangoContext* function(GtkPrintContext* context) c_gtk_print_context_create_pango_context;
  PangoLayout* function(GtkPrintContext* context) c_gtk_print_context_create_pango_layout;
  cairo_t* function(GtkPrintContext* context) c_gtk_print_context_get_cairo_context;
  double function(GtkPrintContext* context) c_gtk_print_context_get_dpi_x;
  double function(GtkPrintContext* context) c_gtk_print_context_get_dpi_y;
  bool function(GtkPrintContext* context, double* top, double* bottom, double* left, double* right) c_gtk_print_context_get_hard_margins;
  double function(GtkPrintContext* context) c_gtk_print_context_get_height;
  GtkPageSetup* function(GtkPrintContext* context) c_gtk_print_context_get_page_setup;
  PangoFontMap* function(GtkPrintContext* context) c_gtk_print_context_get_pango_fontmap;
  double function(GtkPrintContext* context) c_gtk_print_context_get_width;
  void function(GtkPrintContext* context, cairo_t* cr, double dpiX, double dpiY) c_gtk_print_context_set_cairo_context;

  // PrintDialog
  GType function() c_gtk_print_dialog_get_type;
  GtkPrintDialog* function() c_gtk_print_dialog_new;
  const(char)* function(GtkPrintDialog* self) c_gtk_print_dialog_get_accept_label;
  bool function(GtkPrintDialog* self) c_gtk_print_dialog_get_modal;
  GtkPageSetup* function(GtkPrintDialog* self) c_gtk_print_dialog_get_page_setup;
  GtkPrintSettings* function(GtkPrintDialog* self) c_gtk_print_dialog_get_print_settings;
  const(char)* function(GtkPrintDialog* self) c_gtk_print_dialog_get_title;
  void function(GtkPrintDialog* self, GtkWindow* parent, GtkPrintSetup* setup, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_print_dialog_print;
  void function(GtkPrintDialog* self, GtkWindow* parent, GtkPrintSetup* setup, GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_print_dialog_print_file;
  bool function(GtkPrintDialog* self, GAsyncResult* result, GError** _err) c_gtk_print_dialog_print_file_finish;
  GOutputStream* function(GtkPrintDialog* self, GAsyncResult* result, GError** _err) c_gtk_print_dialog_print_finish;
  void function(GtkPrintDialog* self, const(char)* acceptLabel) c_gtk_print_dialog_set_accept_label;
  void function(GtkPrintDialog* self, bool modal) c_gtk_print_dialog_set_modal;
  void function(GtkPrintDialog* self, GtkPageSetup* pageSetup) c_gtk_print_dialog_set_page_setup;
  void function(GtkPrintDialog* self, GtkPrintSettings* printSettings) c_gtk_print_dialog_set_print_settings;
  void function(GtkPrintDialog* self, const(char)* title) c_gtk_print_dialog_set_title;
  void function(GtkPrintDialog* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_print_dialog_setup;
  GtkPrintSetup* function(GtkPrintDialog* self, GAsyncResult* result, GError** _err) c_gtk_print_dialog_setup_finish;

  // PrintJob
  GType function() c_gtk_print_job_get_type;
  GtkPrintJob* function(const(char)* title, GtkPrinter* printer, GtkPrintSettings* settings, GtkPageSetup* pageSetup) c_gtk_print_job_new;
  bool function(GtkPrintJob* job) c_gtk_print_job_get_collate;
  uint function(GtkPrintJob* job) c_gtk_print_job_get_n_up;
  GtkNumberUpLayout function(GtkPrintJob* job) c_gtk_print_job_get_n_up_layout;
  int function(GtkPrintJob* job) c_gtk_print_job_get_num_copies;
  GtkPageRange* function(GtkPrintJob* job, int* nRanges) c_gtk_print_job_get_page_ranges;
  GtkPageSet function(GtkPrintJob* job) c_gtk_print_job_get_page_set;
  GtkPrintPages function(GtkPrintJob* job) c_gtk_print_job_get_pages;
  GtkPrinter* function(GtkPrintJob* job) c_gtk_print_job_get_printer;
  bool function(GtkPrintJob* job) c_gtk_print_job_get_reverse;
  bool function(GtkPrintJob* job) c_gtk_print_job_get_rotate;
  double function(GtkPrintJob* job) c_gtk_print_job_get_scale;
  GtkPrintSettings* function(GtkPrintJob* job) c_gtk_print_job_get_settings;
  GtkPrintStatus function(GtkPrintJob* job) c_gtk_print_job_get_status;
  cairo_surface_t* function(GtkPrintJob* job, GError** _err) c_gtk_print_job_get_surface;
  const(char)* function(GtkPrintJob* job) c_gtk_print_job_get_title;
  bool function(GtkPrintJob* job) c_gtk_print_job_get_track_print_status;
  void function(GtkPrintJob* job, GtkPrintJobCompleteFunc callback, void* userData, GDestroyNotify dnotify) c_gtk_print_job_send;
  void function(GtkPrintJob* job, bool collate) c_gtk_print_job_set_collate;
  void function(GtkPrintJob* job, uint nUp) c_gtk_print_job_set_n_up;
  void function(GtkPrintJob* job, GtkNumberUpLayout layout) c_gtk_print_job_set_n_up_layout;
  void function(GtkPrintJob* job, int numCopies) c_gtk_print_job_set_num_copies;
  void function(GtkPrintJob* job, GtkPageRange* ranges, int nRanges) c_gtk_print_job_set_page_ranges;
  void function(GtkPrintJob* job, GtkPageSet pageSet) c_gtk_print_job_set_page_set;
  void function(GtkPrintJob* job, GtkPrintPages pages) c_gtk_print_job_set_pages;
  void function(GtkPrintJob* job, bool reverse) c_gtk_print_job_set_reverse;
  void function(GtkPrintJob* job, bool rotate) c_gtk_print_job_set_rotate;
  void function(GtkPrintJob* job, double scale) c_gtk_print_job_set_scale;
  bool function(GtkPrintJob* job, int fd, GError** _err) c_gtk_print_job_set_source_fd;
  bool function(GtkPrintJob* job, const(char)* filename, GError** _err) c_gtk_print_job_set_source_file;
  void function(GtkPrintJob* job, bool trackStatus) c_gtk_print_job_set_track_print_status;

  // PrintOperation
  GType function() c_gtk_print_operation_get_type;
  GtkPrintOperation* function() c_gtk_print_operation_new;
  void function(GtkPrintOperation* op) c_gtk_print_operation_cancel;
  void function(GtkPrintOperation* op) c_gtk_print_operation_draw_page_finish;
  GtkPageSetup* function(GtkPrintOperation* op) c_gtk_print_operation_get_default_page_setup;
  bool function(GtkPrintOperation* op) c_gtk_print_operation_get_embed_page_setup;
  void function(GtkPrintOperation* op, GError** _err) c_gtk_print_operation_get_error;
  bool function(GtkPrintOperation* op) c_gtk_print_operation_get_has_selection;
  int function(GtkPrintOperation* op) c_gtk_print_operation_get_n_pages_to_print;
  GtkPrintSettings* function(GtkPrintOperation* op) c_gtk_print_operation_get_print_settings;
  GtkPrintStatus function(GtkPrintOperation* op) c_gtk_print_operation_get_status;
  const(char)* function(GtkPrintOperation* op) c_gtk_print_operation_get_status_string;
  bool function(GtkPrintOperation* op) c_gtk_print_operation_get_support_selection;
  bool function(GtkPrintOperation* op) c_gtk_print_operation_is_finished;
  GtkPrintOperationResult function(GtkPrintOperation* op, GtkPrintOperationAction action, GtkWindow* parent, GError** _err) c_gtk_print_operation_run;
  void function(GtkPrintOperation* op, bool allowAsync) c_gtk_print_operation_set_allow_async;
  void function(GtkPrintOperation* op, int currentPage) c_gtk_print_operation_set_current_page;
  void function(GtkPrintOperation* op, const(char)* label) c_gtk_print_operation_set_custom_tab_label;
  void function(GtkPrintOperation* op, GtkPageSetup* defaultPageSetup) c_gtk_print_operation_set_default_page_setup;
  void function(GtkPrintOperation* op) c_gtk_print_operation_set_defer_drawing;
  void function(GtkPrintOperation* op, bool embed) c_gtk_print_operation_set_embed_page_setup;
  void function(GtkPrintOperation* op, const(char)* filename) c_gtk_print_operation_set_export_filename;
  void function(GtkPrintOperation* op, bool hasSelection) c_gtk_print_operation_set_has_selection;
  void function(GtkPrintOperation* op, const(char)* jobName) c_gtk_print_operation_set_job_name;
  void function(GtkPrintOperation* op, int nPages) c_gtk_print_operation_set_n_pages;
  void function(GtkPrintOperation* op, GtkPrintSettings* printSettings) c_gtk_print_operation_set_print_settings;
  void function(GtkPrintOperation* op, bool showProgress) c_gtk_print_operation_set_show_progress;
  void function(GtkPrintOperation* op, bool supportSelection) c_gtk_print_operation_set_support_selection;
  void function(GtkPrintOperation* op, bool trackStatus) c_gtk_print_operation_set_track_print_status;
  void function(GtkPrintOperation* op, GtkUnit unit) c_gtk_print_operation_set_unit;
  void function(GtkPrintOperation* op, bool fullPage) c_gtk_print_operation_set_use_full_page;

  // PrintOperationPreview
  GType function() c_gtk_print_operation_preview_get_type;
  void function(GtkPrintOperationPreview* preview) c_gtk_print_operation_preview_end_preview;
  bool function(GtkPrintOperationPreview* preview, int pageNr) c_gtk_print_operation_preview_is_selected;
  void function(GtkPrintOperationPreview* preview, int pageNr) c_gtk_print_operation_preview_render_page;

  // PrintSettings
  GType function() c_gtk_print_settings_get_type;
  GtkPrintSettings* function() c_gtk_print_settings_new;
  GtkPrintSettings* function(const(char)* fileName, GError** _err) c_gtk_print_settings_new_from_file;
  GtkPrintSettings* function(VariantC* variant) c_gtk_print_settings_new_from_gvariant;
  GtkPrintSettings* function(GKeyFile* keyFile, const(char)* groupName, GError** _err) c_gtk_print_settings_new_from_key_file;
  GtkPrintSettings* function(GtkPrintSettings* other) c_gtk_print_settings_copy;
  void function(GtkPrintSettings* settings, GtkPrintSettingsFunc func, void* userData) c_gtk_print_settings_foreach;
  const(char)* function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_get;
  bool function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_get_bool;
  bool function(GtkPrintSettings* settings) c_gtk_print_settings_get_collate;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_default_source;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_dither;
  double function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_get_double;
  double function(GtkPrintSettings* settings, const(char)* key, double def) c_gtk_print_settings_get_double_with_default;
  GtkPrintDuplex function(GtkPrintSettings* settings) c_gtk_print_settings_get_duplex;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_finishings;
  int function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_get_int;
  int function(GtkPrintSettings* settings, const(char)* key, int def) c_gtk_print_settings_get_int_with_default;
  double function(GtkPrintSettings* settings, const(char)* key, GtkUnit unit) c_gtk_print_settings_get_length;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_media_type;
  int function(GtkPrintSettings* settings) c_gtk_print_settings_get_n_copies;
  int function(GtkPrintSettings* settings) c_gtk_print_settings_get_number_up;
  GtkNumberUpLayout function(GtkPrintSettings* settings) c_gtk_print_settings_get_number_up_layout;
  GtkPageOrientation function(GtkPrintSettings* settings) c_gtk_print_settings_get_orientation;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_output_bin;
  GtkPageRange* function(GtkPrintSettings* settings, int* numRanges) c_gtk_print_settings_get_page_ranges;
  GtkPageSet function(GtkPrintSettings* settings) c_gtk_print_settings_get_page_set;
  double function(GtkPrintSettings* settings, GtkUnit unit) c_gtk_print_settings_get_paper_height;
  GtkPaperSize* function(GtkPrintSettings* settings) c_gtk_print_settings_get_paper_size;
  double function(GtkPrintSettings* settings, GtkUnit unit) c_gtk_print_settings_get_paper_width;
  GtkPrintPages function(GtkPrintSettings* settings) c_gtk_print_settings_get_print_pages;
  const(char)* function(GtkPrintSettings* settings) c_gtk_print_settings_get_printer;
  double function(GtkPrintSettings* settings) c_gtk_print_settings_get_printer_lpi;
  GtkPrintQuality function(GtkPrintSettings* settings) c_gtk_print_settings_get_quality;
  int function(GtkPrintSettings* settings) c_gtk_print_settings_get_resolution;
  int function(GtkPrintSettings* settings) c_gtk_print_settings_get_resolution_x;
  int function(GtkPrintSettings* settings) c_gtk_print_settings_get_resolution_y;
  bool function(GtkPrintSettings* settings) c_gtk_print_settings_get_reverse;
  double function(GtkPrintSettings* settings) c_gtk_print_settings_get_scale;
  bool function(GtkPrintSettings* settings) c_gtk_print_settings_get_use_color;
  bool function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_has_key;
  bool function(GtkPrintSettings* settings, const(char)* fileName, GError** _err) c_gtk_print_settings_load_file;
  bool function(GtkPrintSettings* settings, GKeyFile* keyFile, const(char)* groupName, GError** _err) c_gtk_print_settings_load_key_file;
  void function(GtkPrintSettings* settings, const(char)* key, const(char)* value) c_gtk_print_settings_set;
  void function(GtkPrintSettings* settings, const(char)* key, bool value) c_gtk_print_settings_set_bool;
  void function(GtkPrintSettings* settings, bool collate) c_gtk_print_settings_set_collate;
  void function(GtkPrintSettings* settings, const(char)* defaultSource) c_gtk_print_settings_set_default_source;
  void function(GtkPrintSettings* settings, const(char)* dither) c_gtk_print_settings_set_dither;
  void function(GtkPrintSettings* settings, const(char)* key, double value) c_gtk_print_settings_set_double;
  void function(GtkPrintSettings* settings, GtkPrintDuplex duplex) c_gtk_print_settings_set_duplex;
  void function(GtkPrintSettings* settings, const(char)* finishings) c_gtk_print_settings_set_finishings;
  void function(GtkPrintSettings* settings, const(char)* key, int value) c_gtk_print_settings_set_int;
  void function(GtkPrintSettings* settings, const(char)* key, double value, GtkUnit unit) c_gtk_print_settings_set_length;
  void function(GtkPrintSettings* settings, const(char)* mediaType) c_gtk_print_settings_set_media_type;
  void function(GtkPrintSettings* settings, int numCopies) c_gtk_print_settings_set_n_copies;
  void function(GtkPrintSettings* settings, int numberUp) c_gtk_print_settings_set_number_up;
  void function(GtkPrintSettings* settings, GtkNumberUpLayout numberUpLayout) c_gtk_print_settings_set_number_up_layout;
  void function(GtkPrintSettings* settings, GtkPageOrientation orientation) c_gtk_print_settings_set_orientation;
  void function(GtkPrintSettings* settings, const(char)* outputBin) c_gtk_print_settings_set_output_bin;
  void function(GtkPrintSettings* settings, GtkPageRange* pageRanges, int numRanges) c_gtk_print_settings_set_page_ranges;
  void function(GtkPrintSettings* settings, GtkPageSet pageSet) c_gtk_print_settings_set_page_set;
  void function(GtkPrintSettings* settings, double height, GtkUnit unit) c_gtk_print_settings_set_paper_height;
  void function(GtkPrintSettings* settings, GtkPaperSize* paperSize) c_gtk_print_settings_set_paper_size;
  void function(GtkPrintSettings* settings, double width, GtkUnit unit) c_gtk_print_settings_set_paper_width;
  void function(GtkPrintSettings* settings, GtkPrintPages pages) c_gtk_print_settings_set_print_pages;
  void function(GtkPrintSettings* settings, const(char)* printer) c_gtk_print_settings_set_printer;
  void function(GtkPrintSettings* settings, double lpi) c_gtk_print_settings_set_printer_lpi;
  void function(GtkPrintSettings* settings, GtkPrintQuality quality) c_gtk_print_settings_set_quality;
  void function(GtkPrintSettings* settings, int resolution) c_gtk_print_settings_set_resolution;
  void function(GtkPrintSettings* settings, int resolutionX, int resolutionY) c_gtk_print_settings_set_resolution_xy;
  void function(GtkPrintSettings* settings, bool reverse) c_gtk_print_settings_set_reverse;
  void function(GtkPrintSettings* settings, double scale) c_gtk_print_settings_set_scale;
  void function(GtkPrintSettings* settings, bool useColor) c_gtk_print_settings_set_use_color;
  bool function(GtkPrintSettings* settings, const(char)* fileName, GError** _err) c_gtk_print_settings_to_file;
  VariantC* function(GtkPrintSettings* settings) c_gtk_print_settings_to_gvariant;
  void function(GtkPrintSettings* settings, GKeyFile* keyFile, const(char)* groupName) c_gtk_print_settings_to_key_file;
  void function(GtkPrintSettings* settings, const(char)* key) c_gtk_print_settings_unset;

  // PrintSetup
  GType function() c_gtk_print_setup_get_type;
  GtkPageSetup* function(GtkPrintSetup* setup) c_gtk_print_setup_get_page_setup;
  GtkPrintSettings* function(GtkPrintSetup* setup) c_gtk_print_setup_get_print_settings;
  GtkPrintSetup* function(GtkPrintSetup* setup) c_gtk_print_setup_ref;
  void function(GtkPrintSetup* setup) c_gtk_print_setup_unref;

  // PrintUnixDialog
  GType function() c_gtk_print_unix_dialog_get_type;
  GtkWidget* function(const(char)* title, GtkWindow* parent) c_gtk_print_unix_dialog_new;
  void function(GtkPrintUnixDialog* dialog, GtkWidget* child, GtkWidget* tabLabel) c_gtk_print_unix_dialog_add_custom_tab;
  int function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_current_page;
  bool function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_embed_page_setup;
  bool function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_has_selection;
  GtkPrintCapabilities function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_manual_capabilities;
  GtkPageSetup* function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_page_setup;
  bool function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_page_setup_set;
  GtkPrinter* function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_selected_printer;
  GtkPrintSettings* function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_settings;
  bool function(GtkPrintUnixDialog* dialog) c_gtk_print_unix_dialog_get_support_selection;
  void function(GtkPrintUnixDialog* dialog, int currentPage) c_gtk_print_unix_dialog_set_current_page;
  void function(GtkPrintUnixDialog* dialog, bool embed) c_gtk_print_unix_dialog_set_embed_page_setup;
  void function(GtkPrintUnixDialog* dialog, bool hasSelection) c_gtk_print_unix_dialog_set_has_selection;
  void function(GtkPrintUnixDialog* dialog, GtkPrintCapabilities capabilities) c_gtk_print_unix_dialog_set_manual_capabilities;
  void function(GtkPrintUnixDialog* dialog, GtkPageSetup* pageSetup) c_gtk_print_unix_dialog_set_page_setup;
  void function(GtkPrintUnixDialog* dialog, GtkPrintSettings* settings) c_gtk_print_unix_dialog_set_settings;
  void function(GtkPrintUnixDialog* dialog, bool supportSelection) c_gtk_print_unix_dialog_set_support_selection;

  // Printer
  GType function() c_gtk_printer_get_type;
  GtkPrinter* function(const(char)* name, GtkPrintBackend* backend, bool virtual) c_gtk_printer_new;
  bool function(GtkPrinter* printer) c_gtk_printer_accepts_pdf;
  bool function(GtkPrinter* printer) c_gtk_printer_accepts_ps;
  int function(GtkPrinter* a, GtkPrinter* b) c_gtk_printer_compare;
  GtkPrintBackend* function(GtkPrinter* printer) c_gtk_printer_get_backend;
  GtkPrintCapabilities function(GtkPrinter* printer) c_gtk_printer_get_capabilities;
  GtkPageSetup* function(GtkPrinter* printer) c_gtk_printer_get_default_page_size;
  const(char)* function(GtkPrinter* printer) c_gtk_printer_get_description;
  bool function(GtkPrinter* printer, double* top, double* bottom, double* left, double* right) c_gtk_printer_get_hard_margins;
  bool function(GtkPrinter* printer, GtkPaperSize* paperSize, double* top, double* bottom, double* left, double* right) c_gtk_printer_get_hard_margins_for_paper_size;
  const(char)* function(GtkPrinter* printer) c_gtk_printer_get_icon_name;
  int function(GtkPrinter* printer) c_gtk_printer_get_job_count;
  const(char)* function(GtkPrinter* printer) c_gtk_printer_get_location;
  const(char)* function(GtkPrinter* printer) c_gtk_printer_get_name;
  const(char)* function(GtkPrinter* printer) c_gtk_printer_get_state_message;
  bool function(GtkPrinter* printer) c_gtk_printer_has_details;
  bool function(GtkPrinter* printer) c_gtk_printer_is_accepting_jobs;
  bool function(GtkPrinter* printer) c_gtk_printer_is_active;
  bool function(GtkPrinter* printer) c_gtk_printer_is_default;
  bool function(GtkPrinter* printer) c_gtk_printer_is_paused;
  bool function(GtkPrinter* printer) c_gtk_printer_is_virtual;
  GList* function(GtkPrinter* printer) c_gtk_printer_list_papers;
  void function(GtkPrinter* printer) c_gtk_printer_request_details;

  // ProgressBar
  GType function() c_gtk_progress_bar_get_type;
  GtkWidget* function() c_gtk_progress_bar_new;
  PangoEllipsizeMode function(GtkProgressBar* pbar) c_gtk_progress_bar_get_ellipsize;
  double function(GtkProgressBar* pbar) c_gtk_progress_bar_get_fraction;
  bool function(GtkProgressBar* pbar) c_gtk_progress_bar_get_inverted;
  double function(GtkProgressBar* pbar) c_gtk_progress_bar_get_pulse_step;
  bool function(GtkProgressBar* pbar) c_gtk_progress_bar_get_show_text;
  const(char)* function(GtkProgressBar* pbar) c_gtk_progress_bar_get_text;
  void function(GtkProgressBar* pbar) c_gtk_progress_bar_pulse;
  void function(GtkProgressBar* pbar, PangoEllipsizeMode mode) c_gtk_progress_bar_set_ellipsize;
  void function(GtkProgressBar* pbar, double fraction) c_gtk_progress_bar_set_fraction;
  void function(GtkProgressBar* pbar, bool inverted) c_gtk_progress_bar_set_inverted;
  void function(GtkProgressBar* pbar, double fraction) c_gtk_progress_bar_set_pulse_step;
  void function(GtkProgressBar* pbar, bool showText) c_gtk_progress_bar_set_show_text;
  void function(GtkProgressBar* pbar, const(char)* text) c_gtk_progress_bar_set_text;

  // PropertyExpression
  GType function() c_gtk_property_expression_get_type;
  GtkExpression* function(GType thisType, GtkExpression* expression, const(char)* propertyName) c_gtk_property_expression_new;
  GtkExpression* function(GtkExpression* expression, GParamSpec* pspec) c_gtk_property_expression_new_for_pspec;
  GtkExpression* function(GtkExpression* expression) c_gtk_property_expression_get_expression;
  GParamSpec* function(GtkExpression* expression) c_gtk_property_expression_get_pspec;

  // Range
  GType function() c_gtk_range_get_type;
  GtkAdjustment* function(GtkRange* range) c_gtk_range_get_adjustment;
  double function(GtkRange* range) c_gtk_range_get_fill_level;
  bool function(GtkRange* range) c_gtk_range_get_flippable;
  bool function(GtkRange* range) c_gtk_range_get_inverted;
  void function(GtkRange* range, GdkRectangle* rangeRect) c_gtk_range_get_range_rect;
  bool function(GtkRange* range) c_gtk_range_get_restrict_to_fill_level;
  int function(GtkRange* range) c_gtk_range_get_round_digits;
  bool function(GtkRange* range) c_gtk_range_get_show_fill_level;
  void function(GtkRange* range, int* sliderStart, int* sliderEnd) c_gtk_range_get_slider_range;
  bool function(GtkRange* range) c_gtk_range_get_slider_size_fixed;
  double function(GtkRange* range) c_gtk_range_get_value;
  void function(GtkRange* range, GtkAdjustment* adjustment) c_gtk_range_set_adjustment;
  void function(GtkRange* range, double fillLevel) c_gtk_range_set_fill_level;
  void function(GtkRange* range, bool flippable) c_gtk_range_set_flippable;
  void function(GtkRange* range, double step, double page) c_gtk_range_set_increments;
  void function(GtkRange* range, bool setting) c_gtk_range_set_inverted;
  void function(GtkRange* range, double min, double max) c_gtk_range_set_range;
  void function(GtkRange* range, bool restrictToFillLevel) c_gtk_range_set_restrict_to_fill_level;
  void function(GtkRange* range, int roundDigits) c_gtk_range_set_round_digits;
  void function(GtkRange* range, bool showFillLevel) c_gtk_range_set_show_fill_level;
  void function(GtkRange* range, bool sizeFixed) c_gtk_range_set_slider_size_fixed;
  void function(GtkRange* range, double value) c_gtk_range_set_value;

  // RecentInfo
  GType function() c_gtk_recent_info_get_type;
  GAppInfo* function(GtkRecentInfo* info, const(char)* appName, GError** _err) c_gtk_recent_info_create_app_info;
  bool function(GtkRecentInfo* info) c_gtk_recent_info_exists;
  GDateTime* function(GtkRecentInfo* info) c_gtk_recent_info_get_added;
  int function(GtkRecentInfo* info) c_gtk_recent_info_get_age;
  bool function(GtkRecentInfo* info, const(char)* appName, const(char*)* appExec, uint* count, GDateTime** stamp) c_gtk_recent_info_get_application_info;
  char** function(GtkRecentInfo* info, size_t* length) c_gtk_recent_info_get_applications;
  const(char)* function(GtkRecentInfo* info) c_gtk_recent_info_get_description;
  const(char)* function(GtkRecentInfo* info) c_gtk_recent_info_get_display_name;
  GIcon* function(GtkRecentInfo* info) c_gtk_recent_info_get_gicon;
  char** function(GtkRecentInfo* info, size_t* length) c_gtk_recent_info_get_groups;
  const(char)* function(GtkRecentInfo* info) c_gtk_recent_info_get_mime_type;
  GDateTime* function(GtkRecentInfo* info) c_gtk_recent_info_get_modified;
  bool function(GtkRecentInfo* info) c_gtk_recent_info_get_private_hint;
  char* function(GtkRecentInfo* info) c_gtk_recent_info_get_short_name;
  const(char)* function(GtkRecentInfo* info) c_gtk_recent_info_get_uri;
  char* function(GtkRecentInfo* info) c_gtk_recent_info_get_uri_display;
  GDateTime* function(GtkRecentInfo* info) c_gtk_recent_info_get_visited;
  bool function(GtkRecentInfo* info, const(char)* appName) c_gtk_recent_info_has_application;
  bool function(GtkRecentInfo* info, const(char)* groupName) c_gtk_recent_info_has_group;
  bool function(GtkRecentInfo* info) c_gtk_recent_info_is_local;
  char* function(GtkRecentInfo* info) c_gtk_recent_info_last_application;
  bool function(GtkRecentInfo* infoA, GtkRecentInfo* infoB) c_gtk_recent_info_match;
  GtkRecentInfo* function(GtkRecentInfo* info) c_gtk_recent_info_ref;
  void function(GtkRecentInfo* info) c_gtk_recent_info_unref;

  // RecentManager
  GType function() c_gtk_recent_manager_get_type;
  GtkRecentManager* function() c_gtk_recent_manager_new;
  GtkRecentManager* function() c_gtk_recent_manager_get_default;
  bool function(GtkRecentManager* manager, const(char)* uri, const(GtkRecentData)* recentData) c_gtk_recent_manager_add_full;
  bool function(GtkRecentManager* manager, const(char)* uri) c_gtk_recent_manager_add_item;
  GList* function(GtkRecentManager* manager) c_gtk_recent_manager_get_items;
  bool function(GtkRecentManager* manager, const(char)* uri) c_gtk_recent_manager_has_item;
  GtkRecentInfo* function(GtkRecentManager* manager, const(char)* uri, GError** _err) c_gtk_recent_manager_lookup_item;
  bool function(GtkRecentManager* manager, const(char)* uri, const(char)* newUri, GError** _err) c_gtk_recent_manager_move_item;
  int function(GtkRecentManager* manager, GError** _err) c_gtk_recent_manager_purge_items;
  bool function(GtkRecentManager* manager, const(char)* uri, GError** _err) c_gtk_recent_manager_remove_item;

  // Requisition
  GType function() c_gtk_requisition_get_type;
  GtkRequisition* function() c_gtk_requisition_new;
  GtkRequisition* function(const(GtkRequisition)* requisition) c_gtk_requisition_copy;
  void function(GtkRequisition* requisition) c_gtk_requisition_free;

  // Revealer
  GType function() c_gtk_revealer_get_type;
  GtkWidget* function() c_gtk_revealer_new;
  GtkWidget* function(GtkRevealer* revealer) c_gtk_revealer_get_child;
  bool function(GtkRevealer* revealer) c_gtk_revealer_get_child_revealed;
  bool function(GtkRevealer* revealer) c_gtk_revealer_get_reveal_child;
  uint function(GtkRevealer* revealer) c_gtk_revealer_get_transition_duration;
  GtkRevealerTransitionType function(GtkRevealer* revealer) c_gtk_revealer_get_transition_type;
  void function(GtkRevealer* revealer, GtkWidget* child) c_gtk_revealer_set_child;
  void function(GtkRevealer* revealer, bool revealChild) c_gtk_revealer_set_reveal_child;
  void function(GtkRevealer* revealer, uint duration) c_gtk_revealer_set_transition_duration;
  void function(GtkRevealer* revealer, GtkRevealerTransitionType transition) c_gtk_revealer_set_transition_type;

  // Root
  GType function() c_gtk_root_get_type;
  GdkDisplay* function(GtkRoot* self) c_gtk_root_get_display;
  GtkWidget* function(GtkRoot* self) c_gtk_root_get_focus;
  void function(GtkRoot* self, GtkWidget* focus) c_gtk_root_set_focus;

  // Scale
  GType function() c_gtk_scale_get_type;
  GtkWidget* function(GtkOrientation orientation, GtkAdjustment* adjustment) c_gtk_scale_new;
  GtkWidget* function(GtkOrientation orientation, double min, double max, double step) c_gtk_scale_new_with_range;
  void function(GtkScale* scale, double value, GtkPositionType position, const(char)* markup) c_gtk_scale_add_mark;
  void function(GtkScale* scale) c_gtk_scale_clear_marks;
  int function(GtkScale* scale) c_gtk_scale_get_digits;
  bool function(GtkScale* scale) c_gtk_scale_get_draw_value;
  bool function(GtkScale* scale) c_gtk_scale_get_has_origin;
  PangoLayout* function(GtkScale* scale) c_gtk_scale_get_layout;
  void function(GtkScale* scale, int* x, int* y) c_gtk_scale_get_layout_offsets;
  GtkPositionType function(GtkScale* scale) c_gtk_scale_get_value_pos;
  void function(GtkScale* scale, int digits) c_gtk_scale_set_digits;
  void function(GtkScale* scale, bool drawValue) c_gtk_scale_set_draw_value;
  void function(GtkScale* scale, GtkScaleFormatValueFunc func, void* userData, GDestroyNotify destroyNotify) c_gtk_scale_set_format_value_func;
  void function(GtkScale* scale, bool hasOrigin) c_gtk_scale_set_has_origin;
  void function(GtkScale* scale, GtkPositionType pos) c_gtk_scale_set_value_pos;

  // ScaleButton
  GType function() c_gtk_scale_button_get_type;
  GtkWidget* function(double min, double max, double step, const(char*)* icons) c_gtk_scale_button_new;
  bool function(GtkScaleButton* button) c_gtk_scale_button_get_active;
  GtkAdjustment* function(GtkScaleButton* button) c_gtk_scale_button_get_adjustment;
  bool function(GtkScaleButton* button) c_gtk_scale_button_get_has_frame;
  GtkWidget* function(GtkScaleButton* button) c_gtk_scale_button_get_minus_button;
  GtkWidget* function(GtkScaleButton* button) c_gtk_scale_button_get_plus_button;
  GtkWidget* function(GtkScaleButton* button) c_gtk_scale_button_get_popup;
  double function(GtkScaleButton* button) c_gtk_scale_button_get_value;
  void function(GtkScaleButton* button, GtkAdjustment* adjustment) c_gtk_scale_button_set_adjustment;
  void function(GtkScaleButton* button, bool hasFrame) c_gtk_scale_button_set_has_frame;
  void function(GtkScaleButton* button, const(char*)* icons) c_gtk_scale_button_set_icons;
  void function(GtkScaleButton* button, double value) c_gtk_scale_button_set_value;

  // ScrollInfo
  GType function() c_gtk_scroll_info_get_type;
  GtkScrollInfo* function() c_gtk_scroll_info_new;
  bool function(GtkScrollInfo* self) c_gtk_scroll_info_get_enable_horizontal;
  bool function(GtkScrollInfo* self) c_gtk_scroll_info_get_enable_vertical;
  GtkScrollInfo* function(GtkScrollInfo* self) c_gtk_scroll_info_ref;
  void function(GtkScrollInfo* self, bool horizontal) c_gtk_scroll_info_set_enable_horizontal;
  void function(GtkScrollInfo* self, bool vertical) c_gtk_scroll_info_set_enable_vertical;
  void function(GtkScrollInfo* self) c_gtk_scroll_info_unref;

  // Scrollable
  GType function() c_gtk_scrollable_get_type;
  bool function(GtkScrollable* scrollable, GtkBorder* border) c_gtk_scrollable_get_border;
  GtkAdjustment* function(GtkScrollable* scrollable) c_gtk_scrollable_get_hadjustment;
  GtkScrollablePolicy function(GtkScrollable* scrollable) c_gtk_scrollable_get_hscroll_policy;
  GtkAdjustment* function(GtkScrollable* scrollable) c_gtk_scrollable_get_vadjustment;
  GtkScrollablePolicy function(GtkScrollable* scrollable) c_gtk_scrollable_get_vscroll_policy;
  void function(GtkScrollable* scrollable, GtkAdjustment* hadjustment) c_gtk_scrollable_set_hadjustment;
  void function(GtkScrollable* scrollable, GtkScrollablePolicy policy) c_gtk_scrollable_set_hscroll_policy;
  void function(GtkScrollable* scrollable, GtkAdjustment* vadjustment) c_gtk_scrollable_set_vadjustment;
  void function(GtkScrollable* scrollable, GtkScrollablePolicy policy) c_gtk_scrollable_set_vscroll_policy;

  // Scrollbar
  GType function() c_gtk_scrollbar_get_type;
  GtkWidget* function(GtkOrientation orientation, GtkAdjustment* adjustment) c_gtk_scrollbar_new;
  GtkAdjustment* function(GtkScrollbar* self) c_gtk_scrollbar_get_adjustment;
  void function(GtkScrollbar* self, GtkAdjustment* adjustment) c_gtk_scrollbar_set_adjustment;

  // ScrolledWindow
  GType function() c_gtk_scrolled_window_get_type;
  GtkWidget* function() c_gtk_scrolled_window_new;
  GtkWidget* function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_child;
  GtkAdjustment* function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_hadjustment;
  bool function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_has_frame;
  GtkWidget* function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_hscrollbar;
  bool function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_kinetic_scrolling;
  int function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_max_content_height;
  int function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_max_content_width;
  int function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_min_content_height;
  int function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_min_content_width;
  bool function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_overlay_scrolling;
  GtkCornerType function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_placement;
  void function(GtkScrolledWindow* scrolledWindow, GtkPolicyType* hscrollbarPolicy, GtkPolicyType* vscrollbarPolicy) c_gtk_scrolled_window_get_policy;
  bool function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_propagate_natural_height;
  bool function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_propagate_natural_width;
  GtkAdjustment* function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_vadjustment;
  GtkWidget* function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_get_vscrollbar;
  void function(GtkScrolledWindow* scrolledWindow, GtkWidget* child) c_gtk_scrolled_window_set_child;
  void function(GtkScrolledWindow* scrolledWindow, GtkAdjustment* hadjustment) c_gtk_scrolled_window_set_hadjustment;
  void function(GtkScrolledWindow* scrolledWindow, bool hasFrame) c_gtk_scrolled_window_set_has_frame;
  void function(GtkScrolledWindow* scrolledWindow, bool kineticScrolling) c_gtk_scrolled_window_set_kinetic_scrolling;
  void function(GtkScrolledWindow* scrolledWindow, int height) c_gtk_scrolled_window_set_max_content_height;
  void function(GtkScrolledWindow* scrolledWindow, int width) c_gtk_scrolled_window_set_max_content_width;
  void function(GtkScrolledWindow* scrolledWindow, int height) c_gtk_scrolled_window_set_min_content_height;
  void function(GtkScrolledWindow* scrolledWindow, int width) c_gtk_scrolled_window_set_min_content_width;
  void function(GtkScrolledWindow* scrolledWindow, bool overlayScrolling) c_gtk_scrolled_window_set_overlay_scrolling;
  void function(GtkScrolledWindow* scrolledWindow, GtkCornerType windowPlacement) c_gtk_scrolled_window_set_placement;
  void function(GtkScrolledWindow* scrolledWindow, GtkPolicyType hscrollbarPolicy, GtkPolicyType vscrollbarPolicy) c_gtk_scrolled_window_set_policy;
  void function(GtkScrolledWindow* scrolledWindow, bool propagate) c_gtk_scrolled_window_set_propagate_natural_height;
  void function(GtkScrolledWindow* scrolledWindow, bool propagate) c_gtk_scrolled_window_set_propagate_natural_width;
  void function(GtkScrolledWindow* scrolledWindow, GtkAdjustment* vadjustment) c_gtk_scrolled_window_set_vadjustment;
  void function(GtkScrolledWindow* scrolledWindow) c_gtk_scrolled_window_unset_placement;

  // SearchBar
  GType function() c_gtk_search_bar_get_type;
  GtkWidget* function() c_gtk_search_bar_new;
  void function(GtkSearchBar* bar, GtkEditable* entry) c_gtk_search_bar_connect_entry;
  GtkWidget* function(GtkSearchBar* bar) c_gtk_search_bar_get_child;
  GtkWidget* function(GtkSearchBar* bar) c_gtk_search_bar_get_key_capture_widget;
  bool function(GtkSearchBar* bar) c_gtk_search_bar_get_search_mode;
  bool function(GtkSearchBar* bar) c_gtk_search_bar_get_show_close_button;
  void function(GtkSearchBar* bar, GtkWidget* child) c_gtk_search_bar_set_child;
  void function(GtkSearchBar* bar, GtkWidget* widget) c_gtk_search_bar_set_key_capture_widget;
  void function(GtkSearchBar* bar, bool searchMode) c_gtk_search_bar_set_search_mode;
  void function(GtkSearchBar* bar, bool visible) c_gtk_search_bar_set_show_close_button;

  // SearchEntry
  GType function() c_gtk_search_entry_get_type;
  GtkWidget* function() c_gtk_search_entry_new;
  GtkInputHints function(GtkSearchEntry* entry) c_gtk_search_entry_get_input_hints;
  GtkInputPurpose function(GtkSearchEntry* entry) c_gtk_search_entry_get_input_purpose;
  GtkWidget* function(GtkSearchEntry* entry) c_gtk_search_entry_get_key_capture_widget;
  const(char)* function(GtkSearchEntry* entry) c_gtk_search_entry_get_placeholder_text;
  uint function(GtkSearchEntry* entry) c_gtk_search_entry_get_search_delay;
  void function(GtkSearchEntry* entry, GtkInputHints hints) c_gtk_search_entry_set_input_hints;
  void function(GtkSearchEntry* entry, GtkInputPurpose purpose) c_gtk_search_entry_set_input_purpose;
  void function(GtkSearchEntry* entry, GtkWidget* widget) c_gtk_search_entry_set_key_capture_widget;
  void function(GtkSearchEntry* entry, const(char)* text) c_gtk_search_entry_set_placeholder_text;
  void function(GtkSearchEntry* entry, uint delay) c_gtk_search_entry_set_search_delay;

  // SectionModel
  GType function() c_gtk_section_model_get_type;
  void function(GtkSectionModel* self, uint position, uint* outStart, uint* outEnd) c_gtk_section_model_get_section;
  void function(GtkSectionModel* self, uint position, uint nItems) c_gtk_section_model_sections_changed;

  // SelectionFilterModel
  GType function() c_gtk_selection_filter_model_get_type;
  GtkSelectionFilterModel* function(GtkSelectionModel* model) c_gtk_selection_filter_model_new;
  GtkSelectionModel* function(GtkSelectionFilterModel* self) c_gtk_selection_filter_model_get_model;
  void function(GtkSelectionFilterModel* self, GtkSelectionModel* model) c_gtk_selection_filter_model_set_model;

  // SelectionModel
  GType function() c_gtk_selection_model_get_type;
  GtkBitset* function(GtkSelectionModel* model) c_gtk_selection_model_get_selection;
  GtkBitset* function(GtkSelectionModel* model, uint position, uint nItems) c_gtk_selection_model_get_selection_in_range;
  bool function(GtkSelectionModel* model, uint position) c_gtk_selection_model_is_selected;
  bool function(GtkSelectionModel* model) c_gtk_selection_model_select_all;
  bool function(GtkSelectionModel* model, uint position, bool unselectRest) c_gtk_selection_model_select_item;
  bool function(GtkSelectionModel* model, uint position, uint nItems, bool unselectRest) c_gtk_selection_model_select_range;
  void function(GtkSelectionModel* model, uint position, uint nItems) c_gtk_selection_model_selection_changed;
  bool function(GtkSelectionModel* model, GtkBitset* selected, GtkBitset* mask) c_gtk_selection_model_set_selection;
  bool function(GtkSelectionModel* model) c_gtk_selection_model_unselect_all;
  bool function(GtkSelectionModel* model, uint position) c_gtk_selection_model_unselect_item;
  bool function(GtkSelectionModel* model, uint position, uint nItems) c_gtk_selection_model_unselect_range;

  // Separator
  GType function() c_gtk_separator_get_type;
  GtkWidget* function(GtkOrientation orientation) c_gtk_separator_new;

  // Settings
  GType function() c_gtk_settings_get_type;
  GtkSettings* function() c_gtk_settings_get_default;
  GtkSettings* function(GdkDisplay* display) c_gtk_settings_get_for_display;
  void function(GtkSettings* settings, const(char)* name) c_gtk_settings_reset_property;

  // Shortcut
  GType function() c_gtk_shortcut_get_type;
  GtkShortcut* function(GtkShortcutTrigger* trigger, GtkShortcutAction* action) c_gtk_shortcut_new;
  GtkShortcut* function(GtkShortcutTrigger* trigger, GtkShortcutAction* action, const(char)* formatString,  ...) c_gtk_shortcut_new_with_arguments;
  GtkShortcutAction* function(GtkShortcut* self) c_gtk_shortcut_get_action;
  VariantC* function(GtkShortcut* self) c_gtk_shortcut_get_arguments;
  GtkShortcutTrigger* function(GtkShortcut* self) c_gtk_shortcut_get_trigger;
  void function(GtkShortcut* self, GtkShortcutAction* action) c_gtk_shortcut_set_action;
  void function(GtkShortcut* self, VariantC* args) c_gtk_shortcut_set_arguments;
  void function(GtkShortcut* self, GtkShortcutTrigger* trigger) c_gtk_shortcut_set_trigger;

  // ShortcutAction
  GType function() c_gtk_shortcut_action_get_type;
  GtkShortcutAction* function(const(char)* string_) c_gtk_shortcut_action_parse_string;
  bool function(GtkShortcutAction* self, GtkShortcutActionFlags flags, GtkWidget* widget, VariantC* args) c_gtk_shortcut_action_activate;
  void function(GtkShortcutAction* self, GString* string_) c_gtk_shortcut_action_print;
  char* function(GtkShortcutAction* self) c_gtk_shortcut_action_to_string;

  // ShortcutController
  GType function() c_gtk_shortcut_controller_get_type;
  GtkEventController* function() c_gtk_shortcut_controller_new;
  GtkEventController* function(GListModel* model) c_gtk_shortcut_controller_new_for_model;
  void function(GtkShortcutController* self, GtkShortcut* shortcut) c_gtk_shortcut_controller_add_shortcut;
  GdkModifierType function(GtkShortcutController* self) c_gtk_shortcut_controller_get_mnemonics_modifiers;
  GtkShortcutScope function(GtkShortcutController* self) c_gtk_shortcut_controller_get_scope;
  void function(GtkShortcutController* self, GtkShortcut* shortcut) c_gtk_shortcut_controller_remove_shortcut;
  void function(GtkShortcutController* self, GdkModifierType modifiers) c_gtk_shortcut_controller_set_mnemonics_modifiers;
  void function(GtkShortcutController* self, GtkShortcutScope scope_) c_gtk_shortcut_controller_set_scope;

  // ShortcutLabel
  GType function() c_gtk_shortcut_label_get_type;
  GtkWidget* function(const(char)* accelerator) c_gtk_shortcut_label_new;
  const(char)* function(GtkShortcutLabel* self) c_gtk_shortcut_label_get_accelerator;
  const(char)* function(GtkShortcutLabel* self) c_gtk_shortcut_label_get_disabled_text;
  void function(GtkShortcutLabel* self, const(char)* accelerator) c_gtk_shortcut_label_set_accelerator;
  void function(GtkShortcutLabel* self, const(char)* disabledText) c_gtk_shortcut_label_set_disabled_text;

  // ShortcutManager
  GType function() c_gtk_shortcut_manager_get_type;

  // ShortcutTrigger
  GType function() c_gtk_shortcut_trigger_get_type;
  GtkShortcutTrigger* function(const(char)* string_) c_gtk_shortcut_trigger_parse_string;
  int function(GtkShortcutTrigger* trigger1, GtkShortcutTrigger* trigger2) c_gtk_shortcut_trigger_compare;
  bool function(GtkShortcutTrigger* trigger1, GtkShortcutTrigger* trigger2) c_gtk_shortcut_trigger_equal;
  uint function(GtkShortcutTrigger* trigger) c_gtk_shortcut_trigger_hash;
  void function(GtkShortcutTrigger* self, GString* string_) c_gtk_shortcut_trigger_print;
  bool function(GtkShortcutTrigger* self, GdkDisplay* display, GString* string_) c_gtk_shortcut_trigger_print_label;
  char* function(GtkShortcutTrigger* self, GdkDisplay* display) c_gtk_shortcut_trigger_to_label;
  char* function(GtkShortcutTrigger* self) c_gtk_shortcut_trigger_to_string;
  GdkKeyMatch function(GtkShortcutTrigger* self, GdkEvent* event, bool enableMnemonics) c_gtk_shortcut_trigger_trigger;

  // ShortcutsGroup
  GType function() c_gtk_shortcuts_group_get_type;
  void function(GtkShortcutsGroup* self, GtkShortcutsShortcut* shortcut) c_gtk_shortcuts_group_add_shortcut;

  // ShortcutsSection
  GType function() c_gtk_shortcuts_section_get_type;
  void function(GtkShortcutsSection* self, GtkShortcutsGroup* group) c_gtk_shortcuts_section_add_group;

  // ShortcutsShortcut
  GType function() c_gtk_shortcuts_shortcut_get_type;

  // ShortcutsWindow
  GType function() c_gtk_shortcuts_window_get_type;
  void function(GtkShortcutsWindow* self, GtkShortcutsSection* section) c_gtk_shortcuts_window_add_section;

  // SignalAction
  GType function() c_gtk_signal_action_get_type;
  GtkShortcutAction* function(const(char)* signalName) c_gtk_signal_action_new;
  const(char)* function(GtkSignalAction* self) c_gtk_signal_action_get_signal_name;

  // SignalListItemFactory
  GType function() c_gtk_signal_list_item_factory_get_type;
  GtkListItemFactory* function() c_gtk_signal_list_item_factory_new;

  // SingleSelection
  GType function() c_gtk_single_selection_get_type;
  GtkSingleSelection* function(GListModel* model) c_gtk_single_selection_new;
  bool function(GtkSingleSelection* self) c_gtk_single_selection_get_autoselect;
  bool function(GtkSingleSelection* self) c_gtk_single_selection_get_can_unselect;
  GListModel* function(GtkSingleSelection* self) c_gtk_single_selection_get_model;
  uint function(GtkSingleSelection* self) c_gtk_single_selection_get_selected;
  ObjectC* function(GtkSingleSelection* self) c_gtk_single_selection_get_selected_item;
  void function(GtkSingleSelection* self, bool autoselect) c_gtk_single_selection_set_autoselect;
  void function(GtkSingleSelection* self, bool canUnselect) c_gtk_single_selection_set_can_unselect;
  void function(GtkSingleSelection* self, GListModel* model) c_gtk_single_selection_set_model;
  void function(GtkSingleSelection* self, uint position) c_gtk_single_selection_set_selected;

  // SizeGroup
  GType function() c_gtk_size_group_get_type;
  GtkSizeGroup* function(GtkSizeGroupMode mode) c_gtk_size_group_new;
  void function(GtkSizeGroup* sizeGroup, GtkWidget* widget) c_gtk_size_group_add_widget;
  GtkSizeGroupMode function(GtkSizeGroup* sizeGroup) c_gtk_size_group_get_mode;
  GSList* function(GtkSizeGroup* sizeGroup) c_gtk_size_group_get_widgets;
  void function(GtkSizeGroup* sizeGroup, GtkWidget* widget) c_gtk_size_group_remove_widget;
  void function(GtkSizeGroup* sizeGroup, GtkSizeGroupMode mode) c_gtk_size_group_set_mode;

  // SliceListModel
  GType function() c_gtk_slice_list_model_get_type;
  GtkSliceListModel* function(GListModel* model, uint offset, uint size) c_gtk_slice_list_model_new;
  GListModel* function(GtkSliceListModel* self) c_gtk_slice_list_model_get_model;
  uint function(GtkSliceListModel* self) c_gtk_slice_list_model_get_offset;
  uint function(GtkSliceListModel* self) c_gtk_slice_list_model_get_size;
  void function(GtkSliceListModel* self, GListModel* model) c_gtk_slice_list_model_set_model;
  void function(GtkSliceListModel* self, uint offset) c_gtk_slice_list_model_set_offset;
  void function(GtkSliceListModel* self, uint size) c_gtk_slice_list_model_set_size;

  // Snapshot
  GType function() c_gtk_snapshot_get_type;
  GtkSnapshot* function() c_gtk_snapshot_new;
  void function(GtkSnapshot* snapshot, const(GskRoundedRect)* outline, const(float)* borderWidth, const(GdkRGBA)* borderColor) c_gtk_snapshot_append_border;
  cairo_t* function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds) c_gtk_snapshot_append_cairo;
  void function(GtkSnapshot* snapshot, const(GdkRGBA)* color, const(graphene_rect_t)* bounds) c_gtk_snapshot_append_color;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_point_t)* center, float rotation, const(GskColorStop)* stops, size_t nStops) c_gtk_snapshot_append_conic_gradient;
  void function(GtkSnapshot* snapshot, GskPath* path, GskFillRule fillRule, const(GdkRGBA)* color) c_gtk_snapshot_append_fill;
  void function(GtkSnapshot* snapshot, const(GskRoundedRect)* outline, const(GdkRGBA)* color, float dx, float dy, float spread, float blurRadius) c_gtk_snapshot_append_inset_shadow;
  void function(GtkSnapshot* snapshot, PangoLayout* layout, const(GdkRGBA)* color) c_gtk_snapshot_append_layout;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_point_t)* startPoint, const(graphene_point_t)* endPoint, const(GskColorStop)* stops, size_t nStops) c_gtk_snapshot_append_linear_gradient;
  void function(GtkSnapshot* snapshot, GskRenderNode* node) c_gtk_snapshot_append_node;
  void function(GtkSnapshot* snapshot, const(GskRoundedRect)* outline, const(GdkRGBA)* color, float dx, float dy, float spread, float blurRadius) c_gtk_snapshot_append_outset_shadow;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_point_t)* center, float hradius, float vradius, float start, float end, const(GskColorStop)* stops, size_t nStops) c_gtk_snapshot_append_radial_gradient;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_point_t)* startPoint, const(graphene_point_t)* endPoint, const(GskColorStop)* stops, size_t nStops) c_gtk_snapshot_append_repeating_linear_gradient;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_point_t)* center, float hradius, float vradius, float start, float end, const(GskColorStop)* stops, size_t nStops) c_gtk_snapshot_append_repeating_radial_gradient;
  void function(GtkSnapshot* snapshot, GdkTexture* texture, GskScalingFilter filter, const(graphene_rect_t)* bounds) c_gtk_snapshot_append_scaled_texture;
  void function(GtkSnapshot* snapshot, GskPath* path, const(GskStroke)* stroke, const(GdkRGBA)* color) c_gtk_snapshot_append_stroke;
  void function(GtkSnapshot* snapshot, GdkTexture* texture, const(graphene_rect_t)* bounds) c_gtk_snapshot_append_texture;
  GskRenderNode* function(GtkSnapshot* snapshot) c_gtk_snapshot_free_to_node;
  GdkPaintable* function(GtkSnapshot* snapshot, const(graphene_size_t)* size) c_gtk_snapshot_free_to_paintable;
  void function(GtkSnapshot* snapshot) c_gtk_snapshot_gl_shader_pop_texture;
  void function(GtkSnapshot* snapshot, float depth) c_gtk_snapshot_perspective;
  void function(GtkSnapshot* snapshot) c_gtk_snapshot_pop;
  void function(GtkSnapshot* snapshot, GskBlendMode blendMode) c_gtk_snapshot_push_blend;
  void function(GtkSnapshot* snapshot, double radius) c_gtk_snapshot_push_blur;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds) c_gtk_snapshot_push_clip;
  void function(GtkSnapshot* snapshot, const(graphene_matrix_t)* colorMatrix, const(graphene_vec4_t)* colorOffset) c_gtk_snapshot_push_color_matrix;
  void function(GtkSnapshot* snapshot, double progress) c_gtk_snapshot_push_cross_fade;
  void function(GtkSnapshot* snapshot, const(char)* message,  ...) c_gtk_snapshot_push_debug;
  void function(GtkSnapshot* snapshot, GskPath* path, GskFillRule fillRule) c_gtk_snapshot_push_fill;
  void function(GtkSnapshot* snapshot, GskGLShader* shader, const(graphene_rect_t)* bounds, GBytes* takeArgs) c_gtk_snapshot_push_gl_shader;
  void function(GtkSnapshot* snapshot, GskMaskMode maskMode) c_gtk_snapshot_push_mask;
  void function(GtkSnapshot* snapshot, double opacity) c_gtk_snapshot_push_opacity;
  void function(GtkSnapshot* snapshot, const(graphene_rect_t)* bounds, const(graphene_rect_t)* childBounds) c_gtk_snapshot_push_repeat;
  void function(GtkSnapshot* snapshot, const(GskRoundedRect)* bounds) c_gtk_snapshot_push_rounded_clip;
  void function(GtkSnapshot* snapshot, const(GskShadow)* shadow, size_t nShadows) c_gtk_snapshot_push_shadow;
  void function(GtkSnapshot* snapshot, GskPath* path, const(GskStroke)* stroke) c_gtk_snapshot_push_stroke;
  void function(GtkSnapshot* snapshot, GtkStyleContext* context, double x, double y, double width, double height) c_gtk_snapshot_render_background;
  void function(GtkSnapshot* snapshot, GtkStyleContext* context, double x, double y, double width, double height) c_gtk_snapshot_render_focus;
  void function(GtkSnapshot* snapshot, GtkStyleContext* context, double x, double y, double width, double height) c_gtk_snapshot_render_frame;
  void function(GtkSnapshot* snapshot, GtkStyleContext* context, double x, double y, PangoLayout* layout, int index, PangoDirection direction) c_gtk_snapshot_render_insertion_cursor;
  void function(GtkSnapshot* snapshot, GtkStyleContext* context, double x, double y, PangoLayout* layout) c_gtk_snapshot_render_layout;
  void function(GtkSnapshot* snapshot) c_gtk_snapshot_restore;
  void function(GtkSnapshot* snapshot, float angle) c_gtk_snapshot_rotate;
  void function(GtkSnapshot* snapshot, float angle, const(graphene_vec3_t)* axis) c_gtk_snapshot_rotate_3d;
  void function(GtkSnapshot* snapshot) c_gtk_snapshot_save;
  void function(GtkSnapshot* snapshot, float factorX, float factorY) c_gtk_snapshot_scale;
  void function(GtkSnapshot* snapshot, float factorX, float factorY, float factorZ) c_gtk_snapshot_scale_3d;
  GskRenderNode* function(GtkSnapshot* snapshot) c_gtk_snapshot_to_node;
  GdkPaintable* function(GtkSnapshot* snapshot, const(graphene_size_t)* size) c_gtk_snapshot_to_paintable;
  void function(GtkSnapshot* snapshot, GskTransform* transform) c_gtk_snapshot_transform;
  void function(GtkSnapshot* snapshot, const(graphene_matrix_t)* matrix) c_gtk_snapshot_transform_matrix;
  void function(GtkSnapshot* snapshot, const(graphene_point_t)* point) c_gtk_snapshot_translate;
  void function(GtkSnapshot* snapshot, const(graphene_point3d_t)* point) c_gtk_snapshot_translate_3d;

  // SortListModel
  GType function() c_gtk_sort_list_model_get_type;
  GtkSortListModel* function(GListModel* model, GtkSorter* sorter) c_gtk_sort_list_model_new;
  bool function(GtkSortListModel* self) c_gtk_sort_list_model_get_incremental;
  GListModel* function(GtkSortListModel* self) c_gtk_sort_list_model_get_model;
  uint function(GtkSortListModel* self) c_gtk_sort_list_model_get_pending;
  GtkSorter* function(GtkSortListModel* self) c_gtk_sort_list_model_get_section_sorter;
  GtkSorter* function(GtkSortListModel* self) c_gtk_sort_list_model_get_sorter;
  void function(GtkSortListModel* self, bool incremental) c_gtk_sort_list_model_set_incremental;
  void function(GtkSortListModel* self, GListModel* model) c_gtk_sort_list_model_set_model;
  void function(GtkSortListModel* self, GtkSorter* sorter) c_gtk_sort_list_model_set_section_sorter;
  void function(GtkSortListModel* self, GtkSorter* sorter) c_gtk_sort_list_model_set_sorter;

  // Sorter
  GType function() c_gtk_sorter_get_type;
  void function(GtkSorter* self, GtkSorterChange change) c_gtk_sorter_changed;
  GtkOrdering function(GtkSorter* self, ObjectC* item1, ObjectC* item2) c_gtk_sorter_compare;
  GtkSorterOrder function(GtkSorter* self) c_gtk_sorter_get_order;

  // SpinButton
  GType function() c_gtk_spin_button_get_type;
  GtkWidget* function(GtkAdjustment* adjustment, double climbRate, uint digits) c_gtk_spin_button_new;
  GtkWidget* function(double min, double max, double step) c_gtk_spin_button_new_with_range;
  void function(GtkSpinButton* spinButton, GtkAdjustment* adjustment, double climbRate, uint digits) c_gtk_spin_button_configure;
  bool function(GtkSpinButton* spinButton) c_gtk_spin_button_get_activates_default;
  GtkAdjustment* function(GtkSpinButton* spinButton) c_gtk_spin_button_get_adjustment;
  double function(GtkSpinButton* spinButton) c_gtk_spin_button_get_climb_rate;
  uint function(GtkSpinButton* spinButton) c_gtk_spin_button_get_digits;
  void function(GtkSpinButton* spinButton, double* step, double* page) c_gtk_spin_button_get_increments;
  bool function(GtkSpinButton* spinButton) c_gtk_spin_button_get_numeric;
  void function(GtkSpinButton* spinButton, double* min, double* max) c_gtk_spin_button_get_range;
  bool function(GtkSpinButton* spinButton) c_gtk_spin_button_get_snap_to_ticks;
  GtkSpinButtonUpdatePolicy function(GtkSpinButton* spinButton) c_gtk_spin_button_get_update_policy;
  double function(GtkSpinButton* spinButton) c_gtk_spin_button_get_value;
  int function(GtkSpinButton* spinButton) c_gtk_spin_button_get_value_as_int;
  bool function(GtkSpinButton* spinButton) c_gtk_spin_button_get_wrap;
  void function(GtkSpinButton* spinButton, bool activatesDefault) c_gtk_spin_button_set_activates_default;
  void function(GtkSpinButton* spinButton, GtkAdjustment* adjustment) c_gtk_spin_button_set_adjustment;
  void function(GtkSpinButton* spinButton, double climbRate) c_gtk_spin_button_set_climb_rate;
  void function(GtkSpinButton* spinButton, uint digits) c_gtk_spin_button_set_digits;
  void function(GtkSpinButton* spinButton, double step, double page) c_gtk_spin_button_set_increments;
  void function(GtkSpinButton* spinButton, bool numeric) c_gtk_spin_button_set_numeric;
  void function(GtkSpinButton* spinButton, double min, double max) c_gtk_spin_button_set_range;
  void function(GtkSpinButton* spinButton, bool snapToTicks) c_gtk_spin_button_set_snap_to_ticks;
  void function(GtkSpinButton* spinButton, GtkSpinButtonUpdatePolicy policy) c_gtk_spin_button_set_update_policy;
  void function(GtkSpinButton* spinButton, double value) c_gtk_spin_button_set_value;
  void function(GtkSpinButton* spinButton, bool wrap) c_gtk_spin_button_set_wrap;
  void function(GtkSpinButton* spinButton, GtkSpinType direction, double increment) c_gtk_spin_button_spin;
  void function(GtkSpinButton* spinButton) c_gtk_spin_button_update;

  // Spinner
  GType function() c_gtk_spinner_get_type;
  GtkWidget* function() c_gtk_spinner_new;
  bool function(GtkSpinner* spinner) c_gtk_spinner_get_spinning;
  void function(GtkSpinner* spinner, bool spinning) c_gtk_spinner_set_spinning;
  void function(GtkSpinner* spinner) c_gtk_spinner_start;
  void function(GtkSpinner* spinner) c_gtk_spinner_stop;

  // Stack
  GType function() c_gtk_stack_get_type;
  GtkWidget* function() c_gtk_stack_new;
  GtkStackPage* function(GtkStack* stack, GtkWidget* child) c_gtk_stack_add_child;
  GtkStackPage* function(GtkStack* stack, GtkWidget* child, const(char)* name) c_gtk_stack_add_named;
  GtkStackPage* function(GtkStack* stack, GtkWidget* child, const(char)* name, const(char)* title) c_gtk_stack_add_titled;
  GtkWidget* function(GtkStack* stack, const(char)* name) c_gtk_stack_get_child_by_name;
  bool function(GtkStack* stack) c_gtk_stack_get_hhomogeneous;
  bool function(GtkStack* stack) c_gtk_stack_get_interpolate_size;
  GtkStackPage* function(GtkStack* stack, GtkWidget* child) c_gtk_stack_get_page;
  GtkSelectionModel* function(GtkStack* stack) c_gtk_stack_get_pages;
  uint function(GtkStack* stack) c_gtk_stack_get_transition_duration;
  bool function(GtkStack* stack) c_gtk_stack_get_transition_running;
  GtkStackTransitionType function(GtkStack* stack) c_gtk_stack_get_transition_type;
  bool function(GtkStack* stack) c_gtk_stack_get_vhomogeneous;
  GtkWidget* function(GtkStack* stack) c_gtk_stack_get_visible_child;
  const(char)* function(GtkStack* stack) c_gtk_stack_get_visible_child_name;
  void function(GtkStack* stack, GtkWidget* child) c_gtk_stack_remove;
  void function(GtkStack* stack, bool hhomogeneous) c_gtk_stack_set_hhomogeneous;
  void function(GtkStack* stack, bool interpolateSize) c_gtk_stack_set_interpolate_size;
  void function(GtkStack* stack, uint duration) c_gtk_stack_set_transition_duration;
  void function(GtkStack* stack, GtkStackTransitionType transition) c_gtk_stack_set_transition_type;
  void function(GtkStack* stack, bool vhomogeneous) c_gtk_stack_set_vhomogeneous;
  void function(GtkStack* stack, GtkWidget* child) c_gtk_stack_set_visible_child;
  void function(GtkStack* stack, const(char)* name, GtkStackTransitionType transition) c_gtk_stack_set_visible_child_full;
  void function(GtkStack* stack, const(char)* name) c_gtk_stack_set_visible_child_name;

  // StackPage
  GType function() c_gtk_stack_page_get_type;
  GtkWidget* function(GtkStackPage* self) c_gtk_stack_page_get_child;
  const(char)* function(GtkStackPage* self) c_gtk_stack_page_get_icon_name;
  const(char)* function(GtkStackPage* self) c_gtk_stack_page_get_name;
  bool function(GtkStackPage* self) c_gtk_stack_page_get_needs_attention;
  const(char)* function(GtkStackPage* self) c_gtk_stack_page_get_title;
  bool function(GtkStackPage* self) c_gtk_stack_page_get_use_underline;
  bool function(GtkStackPage* self) c_gtk_stack_page_get_visible;
  void function(GtkStackPage* self, const(char)* setting) c_gtk_stack_page_set_icon_name;
  void function(GtkStackPage* self, const(char)* setting) c_gtk_stack_page_set_name;
  void function(GtkStackPage* self, bool setting) c_gtk_stack_page_set_needs_attention;
  void function(GtkStackPage* self, const(char)* setting) c_gtk_stack_page_set_title;
  void function(GtkStackPage* self, bool setting) c_gtk_stack_page_set_use_underline;
  void function(GtkStackPage* self, bool visible) c_gtk_stack_page_set_visible;

  // StackSidebar
  GType function() c_gtk_stack_sidebar_get_type;
  GtkWidget* function() c_gtk_stack_sidebar_new;
  GtkStack* function(GtkStackSidebar* self) c_gtk_stack_sidebar_get_stack;
  void function(GtkStackSidebar* self, GtkStack* stack) c_gtk_stack_sidebar_set_stack;

  // StackSwitcher
  GType function() c_gtk_stack_switcher_get_type;
  GtkWidget* function() c_gtk_stack_switcher_new;
  GtkStack* function(GtkStackSwitcher* switcher) c_gtk_stack_switcher_get_stack;
  void function(GtkStackSwitcher* switcher, GtkStack* stack) c_gtk_stack_switcher_set_stack;

  // Statusbar
  GType function() c_gtk_statusbar_get_type;
  GtkWidget* function() c_gtk_statusbar_new;
  uint function(GtkStatusbar* statusbar, const(char)* contextDescription) c_gtk_statusbar_get_context_id;
  void function(GtkStatusbar* statusbar, uint contextId) c_gtk_statusbar_pop;
  uint function(GtkStatusbar* statusbar, uint contextId, const(char)* text) c_gtk_statusbar_push;
  void function(GtkStatusbar* statusbar, uint contextId, uint messageId) c_gtk_statusbar_remove;
  void function(GtkStatusbar* statusbar, uint contextId) c_gtk_statusbar_remove_all;

  // StringFilter
  GType function() c_gtk_string_filter_get_type;
  GtkStringFilter* function(GtkExpression* expression) c_gtk_string_filter_new;
  GtkExpression* function(GtkStringFilter* self) c_gtk_string_filter_get_expression;
  bool function(GtkStringFilter* self) c_gtk_string_filter_get_ignore_case;
  GtkStringFilterMatchMode function(GtkStringFilter* self) c_gtk_string_filter_get_match_mode;
  const(char)* function(GtkStringFilter* self) c_gtk_string_filter_get_search;
  void function(GtkStringFilter* self, GtkExpression* expression) c_gtk_string_filter_set_expression;
  void function(GtkStringFilter* self, bool ignoreCase) c_gtk_string_filter_set_ignore_case;
  void function(GtkStringFilter* self, GtkStringFilterMatchMode mode) c_gtk_string_filter_set_match_mode;
  void function(GtkStringFilter* self, const(char)* search) c_gtk_string_filter_set_search;

  // StringList
  GType function() c_gtk_string_list_get_type;
  GtkStringList* function(const(char*)* strings) c_gtk_string_list_new;
  void function(GtkStringList* self, const(char)* string_) c_gtk_string_list_append;
  const(char)* function(GtkStringList* self, uint position) c_gtk_string_list_get_string;
  void function(GtkStringList* self, uint position) c_gtk_string_list_remove;
  void function(GtkStringList* self, uint position, uint nRemovals, const(char*)* additions) c_gtk_string_list_splice;
  void function(GtkStringList* self, char* string_) c_gtk_string_list_take;

  // StringObject
  GType function() c_gtk_string_object_get_type;
  GtkStringObject* function(const(char)* string_) c_gtk_string_object_new;
  const(char)* function(GtkStringObject* self) c_gtk_string_object_get_string;

  // StringSorter
  GType function() c_gtk_string_sorter_get_type;
  GtkStringSorter* function(GtkExpression* expression) c_gtk_string_sorter_new;
  GtkCollation function(GtkStringSorter* self) c_gtk_string_sorter_get_collation;
  GtkExpression* function(GtkStringSorter* self) c_gtk_string_sorter_get_expression;
  bool function(GtkStringSorter* self) c_gtk_string_sorter_get_ignore_case;
  void function(GtkStringSorter* self, GtkCollation collation) c_gtk_string_sorter_set_collation;
  void function(GtkStringSorter* self, GtkExpression* expression) c_gtk_string_sorter_set_expression;
  void function(GtkStringSorter* self, bool ignoreCase) c_gtk_string_sorter_set_ignore_case;

  // StyleContext
  GType function() c_gtk_style_context_get_type;
  void function(GdkDisplay* display, GtkStyleProvider* provider, uint priority) c_gtk_style_context_add_provider_for_display;
  void function(GdkDisplay* display, GtkStyleProvider* provider) c_gtk_style_context_remove_provider_for_display;
  void function(GtkStyleContext* context, const(char)* className) c_gtk_style_context_add_class;
  void function(GtkStyleContext* context, GtkStyleProvider* provider, uint priority) c_gtk_style_context_add_provider;
  void function(GtkStyleContext* context, GtkBorder* border) c_gtk_style_context_get_border;
  void function(GtkStyleContext* context, GdkRGBA* color) c_gtk_style_context_get_color;
  GdkDisplay* function(GtkStyleContext* context) c_gtk_style_context_get_display;
  void function(GtkStyleContext* context, GtkBorder* margin) c_gtk_style_context_get_margin;
  void function(GtkStyleContext* context, GtkBorder* padding) c_gtk_style_context_get_padding;
  int function(GtkStyleContext* context) c_gtk_style_context_get_scale;
  GtkStateFlags function(GtkStyleContext* context) c_gtk_style_context_get_state;
  bool function(GtkStyleContext* context, const(char)* className) c_gtk_style_context_has_class;
  bool function(GtkStyleContext* context, const(char)* colorName, GdkRGBA* color) c_gtk_style_context_lookup_color;
  void function(GtkStyleContext* context, const(char)* className) c_gtk_style_context_remove_class;
  void function(GtkStyleContext* context, GtkStyleProvider* provider) c_gtk_style_context_remove_provider;
  void function(GtkStyleContext* context) c_gtk_style_context_restore;
  void function(GtkStyleContext* context) c_gtk_style_context_save;
  void function(GtkStyleContext* context, GdkDisplay* display) c_gtk_style_context_set_display;
  void function(GtkStyleContext* context, int scale) c_gtk_style_context_set_scale;
  void function(GtkStyleContext* context, GtkStateFlags flags) c_gtk_style_context_set_state;
  char* function(GtkStyleContext* context, GtkStyleContextPrintFlags flags) c_gtk_style_context_to_string;

  // StyleProvider
  GType function() c_gtk_style_provider_get_type;

  // Switch
  GType function() c_gtk_switch_get_type;
  GtkWidget* function() c_gtk_switch_new;
  bool function(GtkSwitch* self) c_gtk_switch_get_active;
  bool function(GtkSwitch* self) c_gtk_switch_get_state;
  void function(GtkSwitch* self, bool isActive) c_gtk_switch_set_active;
  void function(GtkSwitch* self, bool state) c_gtk_switch_set_state;

  // SymbolicPaintable
  GType function() c_gtk_symbolic_paintable_get_type;
  void function(GtkSymbolicPaintable* paintable, GdkSnapshot* snapshot, double width, double height, const(GdkRGBA)* colors, size_t nColors) c_gtk_symbolic_paintable_snapshot_symbolic;

  // Text
  GType function() c_gtk_text_get_type;
  GtkWidget* function() c_gtk_text_new;
  GtkWidget* function(GtkEntryBuffer* buffer) c_gtk_text_new_with_buffer;
  void function(GtkText* self, size_t position, graphene_rect_t* strong, graphene_rect_t* weak) c_gtk_text_compute_cursor_extents;
  bool function(GtkText* self) c_gtk_text_get_activates_default;
  PangoAttrList* function(GtkText* self) c_gtk_text_get_attributes;
  GtkEntryBuffer* function(GtkText* self) c_gtk_text_get_buffer;
  bool function(GtkText* self) c_gtk_text_get_enable_emoji_completion;
  GMenuModel* function(GtkText* self) c_gtk_text_get_extra_menu;
  GtkInputHints function(GtkText* self) c_gtk_text_get_input_hints;
  GtkInputPurpose function(GtkText* self) c_gtk_text_get_input_purpose;
  dchar function(GtkText* self) c_gtk_text_get_invisible_char;
  int function(GtkText* self) c_gtk_text_get_max_length;
  bool function(GtkText* self) c_gtk_text_get_overwrite_mode;
  const(char)* function(GtkText* self) c_gtk_text_get_placeholder_text;
  bool function(GtkText* self) c_gtk_text_get_propagate_text_width;
  PangoTabArray* function(GtkText* self) c_gtk_text_get_tabs;
  ushort function(GtkText* self) c_gtk_text_get_text_length;
  bool function(GtkText* self) c_gtk_text_get_truncate_multiline;
  bool function(GtkText* self) c_gtk_text_get_visibility;
  bool function(GtkText* self) c_gtk_text_grab_focus_without_selecting;
  void function(GtkText* self, bool activates) c_gtk_text_set_activates_default;
  void function(GtkText* self, PangoAttrList* attrs) c_gtk_text_set_attributes;
  void function(GtkText* self, GtkEntryBuffer* buffer) c_gtk_text_set_buffer;
  void function(GtkText* self, bool enableEmojiCompletion) c_gtk_text_set_enable_emoji_completion;
  void function(GtkText* self, GMenuModel* model) c_gtk_text_set_extra_menu;
  void function(GtkText* self, GtkInputHints hints) c_gtk_text_set_input_hints;
  void function(GtkText* self, GtkInputPurpose purpose) c_gtk_text_set_input_purpose;
  void function(GtkText* self, dchar ch) c_gtk_text_set_invisible_char;
  void function(GtkText* self, int length) c_gtk_text_set_max_length;
  void function(GtkText* self, bool overwrite) c_gtk_text_set_overwrite_mode;
  void function(GtkText* self, const(char)* text) c_gtk_text_set_placeholder_text;
  void function(GtkText* self, bool propagateTextWidth) c_gtk_text_set_propagate_text_width;
  void function(GtkText* self, PangoTabArray* tabs) c_gtk_text_set_tabs;
  void function(GtkText* self, bool truncateMultiline) c_gtk_text_set_truncate_multiline;
  void function(GtkText* self, bool visible) c_gtk_text_set_visibility;
  void function(GtkText* self) c_gtk_text_unset_invisible_char;

  // TextBuffer
  GType function() c_gtk_text_buffer_get_type;
  GtkTextBuffer* function(GtkTextTagTable* table) c_gtk_text_buffer_new;
  void function(GtkTextBuffer* buffer, GtkTextMark* mark, const(GtkTextIter)* where) c_gtk_text_buffer_add_mark;
  void function(GtkTextBuffer* buffer, GdkClipboard* clipboard) c_gtk_text_buffer_add_selection_clipboard;
  void function(GtkTextBuffer* buffer, GtkTextTag* tag, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_apply_tag;
  void function(GtkTextBuffer* buffer, const(char)* name, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_apply_tag_by_name;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, bool interactive, bool defaultEditable) c_gtk_text_buffer_backspace;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_begin_irreversible_action;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_begin_user_action;
  void function(GtkTextBuffer* buffer, GdkClipboard* clipboard) c_gtk_text_buffer_copy_clipboard;
  GtkTextChildAnchor* function(GtkTextBuffer* buffer, GtkTextIter* iter) c_gtk_text_buffer_create_child_anchor;
  GtkTextMark* function(GtkTextBuffer* buffer, const(char)* markName, const(GtkTextIter)* where, bool leftGravity) c_gtk_text_buffer_create_mark;
  GtkTextTag* function(GtkTextBuffer* buffer, const(char)* tagName, const(char)* firstPropertyName,  ...) c_gtk_text_buffer_create_tag;
  void function(GtkTextBuffer* buffer, GdkClipboard* clipboard, bool defaultEditable) c_gtk_text_buffer_cut_clipboard;
  void function(GtkTextBuffer* buffer, GtkTextIter* start, GtkTextIter* end) c_gtk_text_buffer_delete;
  bool function(GtkTextBuffer* buffer, GtkTextIter* startIter, GtkTextIter* endIter, bool defaultEditable) c_gtk_text_buffer_delete_interactive;
  void function(GtkTextBuffer* buffer, GtkTextMark* mark) c_gtk_text_buffer_delete_mark;
  void function(GtkTextBuffer* buffer, const(char)* name) c_gtk_text_buffer_delete_mark_by_name;
  bool function(GtkTextBuffer* buffer, bool interactive, bool defaultEditable) c_gtk_text_buffer_delete_selection;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_end_irreversible_action;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_end_user_action;
  void function(GtkTextBuffer* buffer, GtkTextIter* start, GtkTextIter* end) c_gtk_text_buffer_get_bounds;
  bool function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_can_redo;
  bool function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_can_undo;
  int function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_char_count;
  bool function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_enable_undo;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter) c_gtk_text_buffer_get_end_iter;
  bool function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_has_selection;
  GtkTextMark* function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_insert;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, GtkTextChildAnchor* anchor) c_gtk_text_buffer_get_iter_at_child_anchor;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, int lineNumber) c_gtk_text_buffer_get_iter_at_line;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, int lineNumber, int byteIndex) c_gtk_text_buffer_get_iter_at_line_index;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, int lineNumber, int charOffset) c_gtk_text_buffer_get_iter_at_line_offset;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, GtkTextMark* mark) c_gtk_text_buffer_get_iter_at_mark;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, int charOffset) c_gtk_text_buffer_get_iter_at_offset;
  int function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_line_count;
  GtkTextMark* function(GtkTextBuffer* buffer, const(char)* name) c_gtk_text_buffer_get_mark;
  uint function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_max_undo_levels;
  bool function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_modified;
  GtkTextMark* function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_selection_bound;
  bool function(GtkTextBuffer* buffer, GtkTextIter* start, GtkTextIter* end) c_gtk_text_buffer_get_selection_bounds;
  GdkContentProvider* function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_selection_content;
  char* function(GtkTextBuffer* buffer, const(GtkTextIter)* start, const(GtkTextIter)* end, bool includeHiddenChars) c_gtk_text_buffer_get_slice;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter) c_gtk_text_buffer_get_start_iter;
  GtkTextTagTable* function(GtkTextBuffer* buffer) c_gtk_text_buffer_get_tag_table;
  char* function(GtkTextBuffer* buffer, const(GtkTextIter)* start, const(GtkTextIter)* end, bool includeHiddenChars) c_gtk_text_buffer_get_text;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, const(char)* text, int len) c_gtk_text_buffer_insert;
  void function(GtkTextBuffer* buffer, const(char)* text, int len) c_gtk_text_buffer_insert_at_cursor;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, GtkTextChildAnchor* anchor) c_gtk_text_buffer_insert_child_anchor;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, const(char)* text, int len, bool defaultEditable) c_gtk_text_buffer_insert_interactive;
  bool function(GtkTextBuffer* buffer, const(char)* text, int len, bool defaultEditable) c_gtk_text_buffer_insert_interactive_at_cursor;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, const(char)* markup, int len) c_gtk_text_buffer_insert_markup;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, GdkPaintable* paintable) c_gtk_text_buffer_insert_paintable;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_insert_range;
  bool function(GtkTextBuffer* buffer, GtkTextIter* iter, const(GtkTextIter)* start, const(GtkTextIter)* end, bool defaultEditable) c_gtk_text_buffer_insert_range_interactive;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, const(char)* text, int len, GtkTextTag* firstTag,  ...) c_gtk_text_buffer_insert_with_tags;
  void function(GtkTextBuffer* buffer, GtkTextIter* iter, const(char)* text, int len, const(char)* firstTagName,  ...) c_gtk_text_buffer_insert_with_tags_by_name;
  void function(GtkTextBuffer* buffer, GtkTextMark* mark, const(GtkTextIter)* where) c_gtk_text_buffer_move_mark;
  void function(GtkTextBuffer* buffer, const(char)* name, const(GtkTextIter)* where) c_gtk_text_buffer_move_mark_by_name;
  void function(GtkTextBuffer* buffer, GdkClipboard* clipboard, GtkTextIter* overrideLocation, bool defaultEditable) c_gtk_text_buffer_paste_clipboard;
  void function(GtkTextBuffer* buffer, const(GtkTextIter)* where) c_gtk_text_buffer_place_cursor;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_redo;
  void function(GtkTextBuffer* buffer, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_remove_all_tags;
  void function(GtkTextBuffer* buffer, GdkClipboard* clipboard) c_gtk_text_buffer_remove_selection_clipboard;
  void function(GtkTextBuffer* buffer, GtkTextTag* tag, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_remove_tag;
  void function(GtkTextBuffer* buffer, const(char)* name, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_buffer_remove_tag_by_name;
  void function(GtkTextBuffer* buffer, const(GtkTextIter)* ins, const(GtkTextIter)* bound) c_gtk_text_buffer_select_range;
  void function(GtkTextBuffer* buffer, bool enableUndo) c_gtk_text_buffer_set_enable_undo;
  void function(GtkTextBuffer* buffer, uint maxUndoLevels) c_gtk_text_buffer_set_max_undo_levels;
  void function(GtkTextBuffer* buffer, bool setting) c_gtk_text_buffer_set_modified;
  void function(GtkTextBuffer* buffer, const(char)* text, int len) c_gtk_text_buffer_set_text;
  void function(GtkTextBuffer* buffer) c_gtk_text_buffer_undo;

  // TextChildAnchor
  GType function() c_gtk_text_child_anchor_get_type;
  GtkTextChildAnchor* function() c_gtk_text_child_anchor_new;
  GtkTextChildAnchor* function(const(char)* character) c_gtk_text_child_anchor_new_with_replacement;
  bool function(GtkTextChildAnchor* anchor) c_gtk_text_child_anchor_get_deleted;
  GtkWidget** function(GtkTextChildAnchor* anchor, uint* outLen) c_gtk_text_child_anchor_get_widgets;

  // TextIter
  GType function() c_gtk_text_iter_get_type;
  void function(GtkTextIter* iter, const(GtkTextIter)* other) c_gtk_text_iter_assign;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_char;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_chars;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_cursor_position;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_cursor_positions;
  bool function(GtkTextIter* iter, GtkTextCharPredicate pred, void* userData, const(GtkTextIter)* limit) c_gtk_text_iter_backward_find_char;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_line;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_lines;
  bool function(const(GtkTextIter)* iter, const(char)* str, GtkTextSearchFlags flags, GtkTextIter* matchStart, GtkTextIter* matchEnd, const(GtkTextIter)* limit) c_gtk_text_iter_backward_search;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_sentence_start;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_sentence_starts;
  bool function(GtkTextIter* iter, GtkTextTag* tag) c_gtk_text_iter_backward_to_tag_toggle;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_visible_cursor_position;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_visible_cursor_positions;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_visible_line;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_visible_lines;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_visible_word_start;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_visible_word_starts;
  bool function(GtkTextIter* iter) c_gtk_text_iter_backward_word_start;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_backward_word_starts;
  bool function(const(GtkTextIter)* iter, bool defaultEditability) c_gtk_text_iter_can_insert;
  int function(const(GtkTextIter)* lhs, const(GtkTextIter)* rhs) c_gtk_text_iter_compare;
  GtkTextIter* function(const(GtkTextIter)* iter) c_gtk_text_iter_copy;
  bool function(const(GtkTextIter)* iter, bool defaultSetting) c_gtk_text_iter_editable;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_ends_line;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_ends_sentence;
  bool function(const(GtkTextIter)* iter, GtkTextTag* tag) c_gtk_text_iter_ends_tag;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_ends_word;
  bool function(const(GtkTextIter)* lhs, const(GtkTextIter)* rhs) c_gtk_text_iter_equal;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_char;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_chars;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_cursor_position;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_cursor_positions;
  bool function(GtkTextIter* iter, GtkTextCharPredicate pred, void* userData, const(GtkTextIter)* limit) c_gtk_text_iter_forward_find_char;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_line;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_lines;
  bool function(const(GtkTextIter)* iter, const(char)* str, GtkTextSearchFlags flags, GtkTextIter* matchStart, GtkTextIter* matchEnd, const(GtkTextIter)* limit) c_gtk_text_iter_forward_search;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_sentence_end;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_sentence_ends;
  void function(GtkTextIter* iter) c_gtk_text_iter_forward_to_end;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_to_line_end;
  bool function(GtkTextIter* iter, GtkTextTag* tag) c_gtk_text_iter_forward_to_tag_toggle;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_visible_cursor_position;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_visible_cursor_positions;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_visible_line;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_visible_lines;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_visible_word_end;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_visible_word_ends;
  bool function(GtkTextIter* iter) c_gtk_text_iter_forward_word_end;
  bool function(GtkTextIter* iter, int count) c_gtk_text_iter_forward_word_ends;
  void function(GtkTextIter* iter) c_gtk_text_iter_free;
  GtkTextBuffer* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_buffer;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_bytes_in_line;
  dchar function(const(GtkTextIter)* iter) c_gtk_text_iter_get_char;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_chars_in_line;
  GtkTextChildAnchor* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_child_anchor;
  PangoLanguage* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_language;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_line;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_line_index;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_line_offset;
  GSList* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_marks;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_offset;
  GdkPaintable* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_paintable;
  char* function(const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_iter_get_slice;
  GSList* function(const(GtkTextIter)* iter) c_gtk_text_iter_get_tags;
  char* function(const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_iter_get_text;
  GSList* function(const(GtkTextIter)* iter, bool toggledOn) c_gtk_text_iter_get_toggled_tags;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_visible_line_index;
  int function(const(GtkTextIter)* iter) c_gtk_text_iter_get_visible_line_offset;
  char* function(const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_iter_get_visible_slice;
  char* function(const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_iter_get_visible_text;
  bool function(const(GtkTextIter)* iter, GtkTextTag* tag) c_gtk_text_iter_has_tag;
  bool function(const(GtkTextIter)* iter, const(GtkTextIter)* start, const(GtkTextIter)* end) c_gtk_text_iter_in_range;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_inside_sentence;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_inside_word;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_is_cursor_position;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_is_end;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_is_start;
  void function(GtkTextIter* first, GtkTextIter* second) c_gtk_text_iter_order;
  void function(GtkTextIter* iter, int lineNumber) c_gtk_text_iter_set_line;
  void function(GtkTextIter* iter, int byteOnLine) c_gtk_text_iter_set_line_index;
  void function(GtkTextIter* iter, int charOnLine) c_gtk_text_iter_set_line_offset;
  void function(GtkTextIter* iter, int charOffset) c_gtk_text_iter_set_offset;
  void function(GtkTextIter* iter, int byteOnLine) c_gtk_text_iter_set_visible_line_index;
  void function(GtkTextIter* iter, int charOnLine) c_gtk_text_iter_set_visible_line_offset;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_starts_line;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_starts_sentence;
  bool function(const(GtkTextIter)* iter, GtkTextTag* tag) c_gtk_text_iter_starts_tag;
  bool function(const(GtkTextIter)* iter) c_gtk_text_iter_starts_word;
  bool function(const(GtkTextIter)* iter, GtkTextTag* tag) c_gtk_text_iter_toggles_tag;

  // TextMark
  GType function() c_gtk_text_mark_get_type;
  GtkTextMark* function(const(char)* name, bool leftGravity) c_gtk_text_mark_new;
  GtkTextBuffer* function(GtkTextMark* mark) c_gtk_text_mark_get_buffer;
  bool function(GtkTextMark* mark) c_gtk_text_mark_get_deleted;
  bool function(GtkTextMark* mark) c_gtk_text_mark_get_left_gravity;
  const(char)* function(GtkTextMark* mark) c_gtk_text_mark_get_name;
  bool function(GtkTextMark* mark) c_gtk_text_mark_get_visible;
  void function(GtkTextMark* mark, bool setting) c_gtk_text_mark_set_visible;

  // TextTag
  GType function() c_gtk_text_tag_get_type;
  GtkTextTag* function(const(char)* name) c_gtk_text_tag_new;
  void function(GtkTextTag* tag, bool sizeChanged) c_gtk_text_tag_changed;
  int function(GtkTextTag* tag) c_gtk_text_tag_get_priority;
  void function(GtkTextTag* tag, int priority) c_gtk_text_tag_set_priority;

  // TextTagTable
  GType function() c_gtk_text_tag_table_get_type;
  GtkTextTagTable* function() c_gtk_text_tag_table_new;
  bool function(GtkTextTagTable* table, GtkTextTag* tag) c_gtk_text_tag_table_add;
  void function(GtkTextTagTable* table, GtkTextTagTableForeach func, void* data) c_gtk_text_tag_table_foreach;
  int function(GtkTextTagTable* table) c_gtk_text_tag_table_get_size;
  GtkTextTag* function(GtkTextTagTable* table, const(char)* name) c_gtk_text_tag_table_lookup;
  void function(GtkTextTagTable* table, GtkTextTag* tag) c_gtk_text_tag_table_remove;

  // TextView
  GType function() c_gtk_text_view_get_type;
  GtkWidget* function() c_gtk_text_view_new;
  GtkWidget* function(GtkTextBuffer* buffer) c_gtk_text_view_new_with_buffer;
  void function(GtkTextView* textView, GtkWidget* child, GtkTextChildAnchor* anchor) c_gtk_text_view_add_child_at_anchor;
  void function(GtkTextView* textView, GtkWidget* child, int xpos, int ypos) c_gtk_text_view_add_overlay;
  bool function(GtkTextView* textView, GtkTextIter* iter) c_gtk_text_view_backward_display_line;
  bool function(GtkTextView* textView, GtkTextIter* iter) c_gtk_text_view_backward_display_line_start;
  void function(GtkTextView* textView, GtkTextWindowType win, int bufferX, int bufferY, int* windowX, int* windowY) c_gtk_text_view_buffer_to_window_coords;
  bool function(GtkTextView* textView, GtkTextIter* iter) c_gtk_text_view_forward_display_line;
  bool function(GtkTextView* textView, GtkTextIter* iter) c_gtk_text_view_forward_display_line_end;
  bool function(GtkTextView* textView) c_gtk_text_view_get_accepts_tab;
  int function(GtkTextView* textView) c_gtk_text_view_get_bottom_margin;
  GtkTextBuffer* function(GtkTextView* textView) c_gtk_text_view_get_buffer;
  void function(GtkTextView* textView, const(GtkTextIter)* iter, GdkRectangle* strong, GdkRectangle* weak) c_gtk_text_view_get_cursor_locations;
  bool function(GtkTextView* textView) c_gtk_text_view_get_cursor_visible;
  bool function(GtkTextView* textView) c_gtk_text_view_get_editable;
  GMenuModel* function(GtkTextView* textView) c_gtk_text_view_get_extra_menu;
  GtkWidget* function(GtkTextView* textView, GtkTextWindowType win) c_gtk_text_view_get_gutter;
  int function(GtkTextView* textView) c_gtk_text_view_get_indent;
  GtkInputHints function(GtkTextView* textView) c_gtk_text_view_get_input_hints;
  GtkInputPurpose function(GtkTextView* textView) c_gtk_text_view_get_input_purpose;
  bool function(GtkTextView* textView, GtkTextIter* iter, int x, int y) c_gtk_text_view_get_iter_at_location;
  bool function(GtkTextView* textView, GtkTextIter* iter, int* trailing, int x, int y) c_gtk_text_view_get_iter_at_position;
  void function(GtkTextView* textView, const(GtkTextIter)* iter, GdkRectangle* location) c_gtk_text_view_get_iter_location;
  GtkJustification function(GtkTextView* textView) c_gtk_text_view_get_justification;
  int function(GtkTextView* textView) c_gtk_text_view_get_left_margin;
  void function(GtkTextView* textView, GtkTextIter* targetIter, int y, int* lineTop) c_gtk_text_view_get_line_at_y;
  void function(GtkTextView* textView, const(GtkTextIter)* iter, int* y, int* height) c_gtk_text_view_get_line_yrange;
  PangoContext* function(GtkTextView* textView) c_gtk_text_view_get_ltr_context;
  bool function(GtkTextView* textView) c_gtk_text_view_get_monospace;
  bool function(GtkTextView* textView) c_gtk_text_view_get_overwrite;
  int function(GtkTextView* textView) c_gtk_text_view_get_pixels_above_lines;
  int function(GtkTextView* textView) c_gtk_text_view_get_pixels_below_lines;
  int function(GtkTextView* textView) c_gtk_text_view_get_pixels_inside_wrap;
  int function(GtkTextView* textView) c_gtk_text_view_get_right_margin;
  PangoContext* function(GtkTextView* textView) c_gtk_text_view_get_rtl_context;
  PangoTabArray* function(GtkTextView* textView) c_gtk_text_view_get_tabs;
  int function(GtkTextView* textView) c_gtk_text_view_get_top_margin;
  void function(GtkTextView* textView, GdkRectangle* visibleRect) c_gtk_text_view_get_visible_rect;
  GtkWrapMode function(GtkTextView* textView) c_gtk_text_view_get_wrap_mode;
  bool function(GtkTextView* textView, GdkEvent* event) c_gtk_text_view_im_context_filter_keypress;
  bool function(GtkTextView* textView, GtkTextMark* mark) c_gtk_text_view_move_mark_onscreen;
  void function(GtkTextView* textView, GtkWidget* child, int xpos, int ypos) c_gtk_text_view_move_overlay;
  bool function(GtkTextView* textView, GtkTextIter* iter, int count) c_gtk_text_view_move_visually;
  bool function(GtkTextView* textView) c_gtk_text_view_place_cursor_onscreen;
  void function(GtkTextView* textView, GtkWidget* child) c_gtk_text_view_remove;
  void function(GtkTextView* textView) c_gtk_text_view_reset_cursor_blink;
  void function(GtkTextView* textView) c_gtk_text_view_reset_im_context;
  void function(GtkTextView* textView, GtkTextMark* mark) c_gtk_text_view_scroll_mark_onscreen;
  bool function(GtkTextView* textView, GtkTextIter* iter, double withinMargin, bool useAlign, double xalign, double yalign) c_gtk_text_view_scroll_to_iter;
  void function(GtkTextView* textView, GtkTextMark* mark, double withinMargin, bool useAlign, double xalign, double yalign) c_gtk_text_view_scroll_to_mark;
  void function(GtkTextView* textView, bool acceptsTab) c_gtk_text_view_set_accepts_tab;
  void function(GtkTextView* textView, int bottomMargin) c_gtk_text_view_set_bottom_margin;
  void function(GtkTextView* textView, GtkTextBuffer* buffer) c_gtk_text_view_set_buffer;
  void function(GtkTextView* textView, bool setting) c_gtk_text_view_set_cursor_visible;
  void function(GtkTextView* textView, bool setting) c_gtk_text_view_set_editable;
  void function(GtkTextView* textView, GMenuModel* model) c_gtk_text_view_set_extra_menu;
  void function(GtkTextView* textView, GtkTextWindowType win, GtkWidget* widget) c_gtk_text_view_set_gutter;
  void function(GtkTextView* textView, int indent) c_gtk_text_view_set_indent;
  void function(GtkTextView* textView, GtkInputHints hints) c_gtk_text_view_set_input_hints;
  void function(GtkTextView* textView, GtkInputPurpose purpose) c_gtk_text_view_set_input_purpose;
  void function(GtkTextView* textView, GtkJustification justification) c_gtk_text_view_set_justification;
  void function(GtkTextView* textView, int leftMargin) c_gtk_text_view_set_left_margin;
  void function(GtkTextView* textView, bool monospace) c_gtk_text_view_set_monospace;
  void function(GtkTextView* textView, bool overwrite) c_gtk_text_view_set_overwrite;
  void function(GtkTextView* textView, int pixelsAboveLines) c_gtk_text_view_set_pixels_above_lines;
  void function(GtkTextView* textView, int pixelsBelowLines) c_gtk_text_view_set_pixels_below_lines;
  void function(GtkTextView* textView, int pixelsInsideWrap) c_gtk_text_view_set_pixels_inside_wrap;
  void function(GtkTextView* textView, int rightMargin) c_gtk_text_view_set_right_margin;
  void function(GtkTextView* textView, PangoTabArray* tabs) c_gtk_text_view_set_tabs;
  void function(GtkTextView* textView, int topMargin) c_gtk_text_view_set_top_margin;
  void function(GtkTextView* textView, GtkWrapMode wrapMode) c_gtk_text_view_set_wrap_mode;
  bool function(GtkTextView* textView, const(GtkTextIter)* iter) c_gtk_text_view_starts_display_line;
  void function(GtkTextView* textView, GtkTextWindowType win, int windowX, int windowY, int* bufferX, int* bufferY) c_gtk_text_view_window_to_buffer_coords;

  // ToggleButton
  GType function() c_gtk_toggle_button_get_type;
  GtkWidget* function() c_gtk_toggle_button_new;
  GtkWidget* function(const(char)* label) c_gtk_toggle_button_new_with_label;
  GtkWidget* function(const(char)* label) c_gtk_toggle_button_new_with_mnemonic;
  bool function(GtkToggleButton* toggleButton) c_gtk_toggle_button_get_active;
  void function(GtkToggleButton* toggleButton, bool isActive) c_gtk_toggle_button_set_active;
  void function(GtkToggleButton* toggleButton, GtkToggleButton* group) c_gtk_toggle_button_set_group;
  void function(GtkToggleButton* toggleButton) c_gtk_toggle_button_toggled;

  // Tooltip
  GType function() c_gtk_tooltip_get_type;
  void function(GtkTooltip* tooltip, GtkWidget* customWidget) c_gtk_tooltip_set_custom;
  void function(GtkTooltip* tooltip, GdkPaintable* paintable) c_gtk_tooltip_set_icon;
  void function(GtkTooltip* tooltip, GIcon* gicon) c_gtk_tooltip_set_icon_from_gicon;
  void function(GtkTooltip* tooltip, const(char)* iconName) c_gtk_tooltip_set_icon_from_icon_name;
  void function(GtkTooltip* tooltip, const(char)* markup) c_gtk_tooltip_set_markup;
  void function(GtkTooltip* tooltip, const(char)* text) c_gtk_tooltip_set_text;
  void function(GtkTooltip* tooltip, const(GdkRectangle)* rect) c_gtk_tooltip_set_tip_area;

  // TreeDragDest
  GType function() c_gtk_tree_drag_dest_get_type;
  bool function(GtkTreeDragDest* dragDest, GtkTreePath* dest, const(GValue)* value) c_gtk_tree_drag_dest_drag_data_received;
  bool function(GtkTreeDragDest* dragDest, GtkTreePath* destPath, const(GValue)* value) c_gtk_tree_drag_dest_row_drop_possible;

  // TreeDragSource
  GType function() c_gtk_tree_drag_source_get_type;
  bool function(GtkTreeDragSource* dragSource, GtkTreePath* path) c_gtk_tree_drag_source_drag_data_delete;
  GdkContentProvider* function(GtkTreeDragSource* dragSource, GtkTreePath* path) c_gtk_tree_drag_source_drag_data_get;
  bool function(GtkTreeDragSource* dragSource, GtkTreePath* path) c_gtk_tree_drag_source_row_draggable;

  // TreeExpander
  GType function() c_gtk_tree_expander_get_type;
  GtkWidget* function() c_gtk_tree_expander_new;
  GtkWidget* function(GtkTreeExpander* self) c_gtk_tree_expander_get_child;
  bool function(GtkTreeExpander* self) c_gtk_tree_expander_get_hide_expander;
  bool function(GtkTreeExpander* self) c_gtk_tree_expander_get_indent_for_depth;
  bool function(GtkTreeExpander* self) c_gtk_tree_expander_get_indent_for_icon;
  ObjectC* function(GtkTreeExpander* self) c_gtk_tree_expander_get_item;
  GtkTreeListRow* function(GtkTreeExpander* self) c_gtk_tree_expander_get_list_row;
  void function(GtkTreeExpander* self, GtkWidget* child) c_gtk_tree_expander_set_child;
  void function(GtkTreeExpander* self, bool hideExpander) c_gtk_tree_expander_set_hide_expander;
  void function(GtkTreeExpander* self, bool indentForDepth) c_gtk_tree_expander_set_indent_for_depth;
  void function(GtkTreeExpander* self, bool indentForIcon) c_gtk_tree_expander_set_indent_for_icon;
  void function(GtkTreeExpander* self, GtkTreeListRow* listRow) c_gtk_tree_expander_set_list_row;

  // TreeIter
  GType function() c_gtk_tree_iter_get_type;
  GtkTreeIter* function(GtkTreeIter* iter) c_gtk_tree_iter_copy;
  void function(GtkTreeIter* iter) c_gtk_tree_iter_free;

  // TreeListModel
  GType function() c_gtk_tree_list_model_get_type;
  GtkTreeListModel* function(GListModel* root, bool passthrough, bool autoexpand, GtkTreeListModelCreateModelFunc createFunc, void* userData, GDestroyNotify userDestroy) c_gtk_tree_list_model_new;
  bool function(GtkTreeListModel* self) c_gtk_tree_list_model_get_autoexpand;
  GtkTreeListRow* function(GtkTreeListModel* self, uint position) c_gtk_tree_list_model_get_child_row;
  GListModel* function(GtkTreeListModel* self) c_gtk_tree_list_model_get_model;
  bool function(GtkTreeListModel* self) c_gtk_tree_list_model_get_passthrough;
  GtkTreeListRow* function(GtkTreeListModel* self, uint position) c_gtk_tree_list_model_get_row;
  void function(GtkTreeListModel* self, bool autoexpand) c_gtk_tree_list_model_set_autoexpand;

  // TreeListRow
  GType function() c_gtk_tree_list_row_get_type;
  GtkTreeListRow* function(GtkTreeListRow* self, uint position) c_gtk_tree_list_row_get_child_row;
  GListModel* function(GtkTreeListRow* self) c_gtk_tree_list_row_get_children;
  uint function(GtkTreeListRow* self) c_gtk_tree_list_row_get_depth;
  bool function(GtkTreeListRow* self) c_gtk_tree_list_row_get_expanded;
  ObjectC* function(GtkTreeListRow* self) c_gtk_tree_list_row_get_item;
  GtkTreeListRow* function(GtkTreeListRow* self) c_gtk_tree_list_row_get_parent;
  uint function(GtkTreeListRow* self) c_gtk_tree_list_row_get_position;
  bool function(GtkTreeListRow* self) c_gtk_tree_list_row_is_expandable;
  void function(GtkTreeListRow* self, bool expanded) c_gtk_tree_list_row_set_expanded;

  // TreeListRowSorter
  GType function() c_gtk_tree_list_row_sorter_get_type;
  GtkTreeListRowSorter* function(GtkSorter* sorter) c_gtk_tree_list_row_sorter_new;
  GtkSorter* function(GtkTreeListRowSorter* self) c_gtk_tree_list_row_sorter_get_sorter;
  void function(GtkTreeListRowSorter* self, GtkSorter* sorter) c_gtk_tree_list_row_sorter_set_sorter;

  // TreeModel
  GType function() c_gtk_tree_model_get_type;
  GtkTreeModel* function(GtkTreeModel* childModel, GtkTreePath* root) c_gtk_tree_model_filter_new;
  void function(GtkTreeModel* model, GtkTreeModelForeachFunc func, void* userData) c_gtk_tree_model_foreach;
  void function(GtkTreeModel* treeModel, GtkTreeIter* iter,  ...) c_gtk_tree_model_get;
  GType function(GtkTreeModel* treeModel, int index) c_gtk_tree_model_get_column_type;
  GtkTreeModelFlags function(GtkTreeModel* treeModel) c_gtk_tree_model_get_flags;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreePath* path) c_gtk_tree_model_get_iter;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_get_iter_first;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, const(char)* pathString) c_gtk_tree_model_get_iter_from_string;
  int function(GtkTreeModel* treeModel) c_gtk_tree_model_get_n_columns;
  GtkTreePath* function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_get_path;
  char* function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_get_string_from_iter;
  void function(GtkTreeModel* treeModel, GtkTreeIter* iter, void* varArgs) c_gtk_tree_model_get_valist;
  void function(GtkTreeModel* treeModel, GtkTreeIter* iter, int column, GValue* value) c_gtk_tree_model_get_value;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* parent) c_gtk_tree_model_iter_children;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_iter_has_child;
  int function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_iter_n_children;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_iter_next;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* parent, int n) c_gtk_tree_model_iter_nth_child;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* child) c_gtk_tree_model_iter_parent;
  bool function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_iter_previous;
  void function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_ref_node;
  void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter) c_gtk_tree_model_row_changed;
  void function(GtkTreeModel* treeModel, GtkTreePath* path) c_gtk_tree_model_row_deleted;
  void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter) c_gtk_tree_model_row_has_child_toggled;
  void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter) c_gtk_tree_model_row_inserted;
  void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter, int* newOrder) c_gtk_tree_model_rows_reordered;
  void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter, int* newOrder, int length) c_gtk_tree_model_rows_reordered_with_length;
  void function(GtkTreeModel* treeModel, GtkTreeIter* iter) c_gtk_tree_model_unref_node;

  // TreeModelFilter
  GType function() c_gtk_tree_model_filter_get_type;
  void function(GtkTreeModelFilter* filter) c_gtk_tree_model_filter_clear_cache;
  bool function(GtkTreeModelFilter* filter, GtkTreeIter* filterIter, GtkTreeIter* childIter) c_gtk_tree_model_filter_convert_child_iter_to_iter;
  GtkTreePath* function(GtkTreeModelFilter* filter, GtkTreePath* childPath) c_gtk_tree_model_filter_convert_child_path_to_path;
  void function(GtkTreeModelFilter* filter, GtkTreeIter* childIter, GtkTreeIter* filterIter) c_gtk_tree_model_filter_convert_iter_to_child_iter;
  GtkTreePath* function(GtkTreeModelFilter* filter, GtkTreePath* filterPath) c_gtk_tree_model_filter_convert_path_to_child_path;
  GtkTreeModel* function(GtkTreeModelFilter* filter) c_gtk_tree_model_filter_get_model;
  void function(GtkTreeModelFilter* filter) c_gtk_tree_model_filter_refilter;
  void function(GtkTreeModelFilter* filter, int nColumns, GType* types, GtkTreeModelFilterModifyFunc func, void* data, GDestroyNotify destroy) c_gtk_tree_model_filter_set_modify_func;
  void function(GtkTreeModelFilter* filter, int column) c_gtk_tree_model_filter_set_visible_column;
  void function(GtkTreeModelFilter* filter, GtkTreeModelFilterVisibleFunc func, void* data, GDestroyNotify destroy) c_gtk_tree_model_filter_set_visible_func;

  // TreeModelSort
  GType function() c_gtk_tree_model_sort_get_type;
  GtkTreeModel* function(GtkTreeModel* childModel) c_gtk_tree_model_sort_new_with_model;
  void function(GtkTreeModelSort* treeModelSort) c_gtk_tree_model_sort_clear_cache;
  bool function(GtkTreeModelSort* treeModelSort, GtkTreeIter* sortIter, GtkTreeIter* childIter) c_gtk_tree_model_sort_convert_child_iter_to_iter;
  GtkTreePath* function(GtkTreeModelSort* treeModelSort, GtkTreePath* childPath) c_gtk_tree_model_sort_convert_child_path_to_path;
  void function(GtkTreeModelSort* treeModelSort, GtkTreeIter* childIter, GtkTreeIter* sortedIter) c_gtk_tree_model_sort_convert_iter_to_child_iter;
  GtkTreePath* function(GtkTreeModelSort* treeModelSort, GtkTreePath* sortedPath) c_gtk_tree_model_sort_convert_path_to_child_path;
  GtkTreeModel* function(GtkTreeModelSort* treeModel) c_gtk_tree_model_sort_get_model;
  bool function(GtkTreeModelSort* treeModelSort, GtkTreeIter* iter) c_gtk_tree_model_sort_iter_is_valid;
  void function(GtkTreeModelSort* treeModelSort) c_gtk_tree_model_sort_reset_default_sort_func;

  // TreePath
  GType function() c_gtk_tree_path_get_type;
  GtkTreePath* function() c_gtk_tree_path_new;
  GtkTreePath* function() c_gtk_tree_path_new_first;
  GtkTreePath* function(int firstIndex,  ...) c_gtk_tree_path_new_from_indices;
  GtkTreePath* function(int* indices, size_t length) c_gtk_tree_path_new_from_indicesv;
  GtkTreePath* function(const(char)* path) c_gtk_tree_path_new_from_string;
  void function(GtkTreePath* path, int index) c_gtk_tree_path_append_index;
  int function(const(GtkTreePath)* a, const(GtkTreePath)* b) c_gtk_tree_path_compare;
  GtkTreePath* function(const(GtkTreePath)* path) c_gtk_tree_path_copy;
  void function(GtkTreePath* path) c_gtk_tree_path_down;
  void function(GtkTreePath* path) c_gtk_tree_path_free;
  int function(GtkTreePath* path) c_gtk_tree_path_get_depth;
  int* function(GtkTreePath* path) c_gtk_tree_path_get_indices;
  int* function(GtkTreePath* path, int* depth) c_gtk_tree_path_get_indices_with_depth;
  bool function(GtkTreePath* path, GtkTreePath* descendant) c_gtk_tree_path_is_ancestor;
  bool function(GtkTreePath* path, GtkTreePath* ancestor) c_gtk_tree_path_is_descendant;
  void function(GtkTreePath* path) c_gtk_tree_path_next;
  void function(GtkTreePath* path, int index) c_gtk_tree_path_prepend_index;
  bool function(GtkTreePath* path) c_gtk_tree_path_prev;
  char* function(GtkTreePath* path) c_gtk_tree_path_to_string;
  bool function(GtkTreePath* path) c_gtk_tree_path_up;

  // TreeRowReference
  GType function() c_gtk_tree_row_reference_get_type;
  GtkTreeRowReference* function(GtkTreeModel* model, GtkTreePath* path) c_gtk_tree_row_reference_new;
  GtkTreeRowReference* function(ObjectC* proxy, GtkTreeModel* model, GtkTreePath* path) c_gtk_tree_row_reference_new_proxy;
  GtkTreeRowReference* function(GtkTreeRowReference* reference) c_gtk_tree_row_reference_copy;
  void function(GtkTreeRowReference* reference) c_gtk_tree_row_reference_free;
  GtkTreeModel* function(GtkTreeRowReference* reference) c_gtk_tree_row_reference_get_model;
  GtkTreePath* function(GtkTreeRowReference* reference) c_gtk_tree_row_reference_get_path;
  bool function(GtkTreeRowReference* reference) c_gtk_tree_row_reference_valid;
  void function(ObjectC* proxy, GtkTreePath* path) c_gtk_tree_row_reference_deleted;
  void function(ObjectC* proxy, GtkTreePath* path) c_gtk_tree_row_reference_inserted;
  void function(ObjectC* proxy, GtkTreePath* path, GtkTreeIter* iter, int* newOrder) c_gtk_tree_row_reference_reordered;

  // TreeSelection
  GType function() c_gtk_tree_selection_get_type;
  int function(GtkTreeSelection* selection) c_gtk_tree_selection_count_selected_rows;
  GtkSelectionMode function(GtkTreeSelection* selection) c_gtk_tree_selection_get_mode;
  GtkTreeSelectionFunc function(GtkTreeSelection* selection) c_gtk_tree_selection_get_select_function;
  bool function(GtkTreeSelection* selection, GtkTreeModel** model, GtkTreeIter* iter) c_gtk_tree_selection_get_selected;
  GList* function(GtkTreeSelection* selection, GtkTreeModel** model) c_gtk_tree_selection_get_selected_rows;
  GtkTreeView* function(GtkTreeSelection* selection) c_gtk_tree_selection_get_tree_view;
  void* function(GtkTreeSelection* selection) c_gtk_tree_selection_get_user_data;
  bool function(GtkTreeSelection* selection, GtkTreeIter* iter) c_gtk_tree_selection_iter_is_selected;
  bool function(GtkTreeSelection* selection, GtkTreePath* path) c_gtk_tree_selection_path_is_selected;
  void function(GtkTreeSelection* selection) c_gtk_tree_selection_select_all;
  void function(GtkTreeSelection* selection, GtkTreeIter* iter) c_gtk_tree_selection_select_iter;
  void function(GtkTreeSelection* selection, GtkTreePath* path) c_gtk_tree_selection_select_path;
  void function(GtkTreeSelection* selection, GtkTreePath* startPath, GtkTreePath* endPath) c_gtk_tree_selection_select_range;
  void function(GtkTreeSelection* selection, GtkTreeSelectionForeachFunc func, void* data) c_gtk_tree_selection_selected_foreach;
  void function(GtkTreeSelection* selection, GtkSelectionMode type) c_gtk_tree_selection_set_mode;
  void function(GtkTreeSelection* selection, GtkTreeSelectionFunc func, void* data, GDestroyNotify destroy) c_gtk_tree_selection_set_select_function;
  void function(GtkTreeSelection* selection) c_gtk_tree_selection_unselect_all;
  void function(GtkTreeSelection* selection, GtkTreeIter* iter) c_gtk_tree_selection_unselect_iter;
  void function(GtkTreeSelection* selection, GtkTreePath* path) c_gtk_tree_selection_unselect_path;
  void function(GtkTreeSelection* selection, GtkTreePath* startPath, GtkTreePath* endPath) c_gtk_tree_selection_unselect_range;

  // TreeSortable
  GType function() c_gtk_tree_sortable_get_type;
  bool function(GtkTreeSortable* sortable, int* sortColumnId, GtkSortType* order) c_gtk_tree_sortable_get_sort_column_id;
  bool function(GtkTreeSortable* sortable) c_gtk_tree_sortable_has_default_sort_func;
  void function(GtkTreeSortable* sortable, GtkTreeIterCompareFunc sortFunc, void* userData, GDestroyNotify destroy) c_gtk_tree_sortable_set_default_sort_func;
  void function(GtkTreeSortable* sortable, int sortColumnId, GtkSortType order) c_gtk_tree_sortable_set_sort_column_id;
  void function(GtkTreeSortable* sortable, int sortColumnId, GtkTreeIterCompareFunc sortFunc, void* userData, GDestroyNotify destroy) c_gtk_tree_sortable_set_sort_func;
  void function(GtkTreeSortable* sortable) c_gtk_tree_sortable_sort_column_changed;

  // TreeStore
  GType function() c_gtk_tree_store_get_type;
  GtkTreeStore* function(int nColumns,  ...) c_gtk_tree_store_new;
  GtkTreeStore* function(int nColumns, GType* types) c_gtk_tree_store_newv;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent) c_gtk_tree_store_append;
  void function(GtkTreeStore* treeStore) c_gtk_tree_store_clear;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent, int position) c_gtk_tree_store_insert;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent, GtkTreeIter* sibling) c_gtk_tree_store_insert_after;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent, GtkTreeIter* sibling) c_gtk_tree_store_insert_before;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent, int position,  ...) c_gtk_tree_store_insert_with_values;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent, int position, int* columns, GValue* values, int nValues) c_gtk_tree_store_insert_with_valuesv;
  bool function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* descendant) c_gtk_tree_store_is_ancestor;
  int function(GtkTreeStore* treeStore, GtkTreeIter* iter) c_gtk_tree_store_iter_depth;
  bool function(GtkTreeStore* treeStore, GtkTreeIter* iter) c_gtk_tree_store_iter_is_valid;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* position) c_gtk_tree_store_move_after;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* position) c_gtk_tree_store_move_before;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, GtkTreeIter* parent) c_gtk_tree_store_prepend;
  bool function(GtkTreeStore* treeStore, GtkTreeIter* iter) c_gtk_tree_store_remove;
  void function(GtkTreeStore* treeStore, GtkTreeIter* parent, int* newOrder) c_gtk_tree_store_reorder;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter,  ...) c_gtk_tree_store_set;
  void function(GtkTreeStore* treeStore, int nColumns, GType* types) c_gtk_tree_store_set_column_types;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, void* varArgs) c_gtk_tree_store_set_valist;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, int column, GValue* value) c_gtk_tree_store_set_value;
  void function(GtkTreeStore* treeStore, GtkTreeIter* iter, int* columns, GValue* values, int nValues) c_gtk_tree_store_set_valuesv;
  void function(GtkTreeStore* treeStore, GtkTreeIter* a, GtkTreeIter* b) c_gtk_tree_store_swap;

  // TreeView
  GType function() c_gtk_tree_view_get_type;
  GtkWidget* function() c_gtk_tree_view_new;
  GtkWidget* function(GtkTreeModel* model) c_gtk_tree_view_new_with_model;
  int function(GtkTreeView* treeView, GtkTreeViewColumn* column) c_gtk_tree_view_append_column;
  void function(GtkTreeView* treeView) c_gtk_tree_view_collapse_all;
  bool function(GtkTreeView* treeView, GtkTreePath* path) c_gtk_tree_view_collapse_row;
  void function(GtkTreeView* treeView) c_gtk_tree_view_columns_autosize;
  void function(GtkTreeView* treeView, int bx, int by, int* tx, int* ty) c_gtk_tree_view_convert_bin_window_to_tree_coords;
  void function(GtkTreeView* treeView, int bx, int by, int* wx, int* wy) c_gtk_tree_view_convert_bin_window_to_widget_coords;
  void function(GtkTreeView* treeView, int tx, int ty, int* bx, int* by) c_gtk_tree_view_convert_tree_to_bin_window_coords;
  void function(GtkTreeView* treeView, int tx, int ty, int* wx, int* wy) c_gtk_tree_view_convert_tree_to_widget_coords;
  void function(GtkTreeView* treeView, int wx, int wy, int* bx, int* by) c_gtk_tree_view_convert_widget_to_bin_window_coords;
  void function(GtkTreeView* treeView, int wx, int wy, int* tx, int* ty) c_gtk_tree_view_convert_widget_to_tree_coords;
  GdkPaintable* function(GtkTreeView* treeView, GtkTreePath* path) c_gtk_tree_view_create_row_drag_icon;
  void function(GtkTreeView* treeView, GdkContentFormats* formats, GdkDragAction actions) c_gtk_tree_view_enable_model_drag_dest;
  void function(GtkTreeView* treeView, GdkModifierType startButtonMask, GdkContentFormats* formats, GdkDragAction actions) c_gtk_tree_view_enable_model_drag_source;
  void function(GtkTreeView* treeView) c_gtk_tree_view_expand_all;
  bool function(GtkTreeView* treeView, GtkTreePath* path, bool openAll) c_gtk_tree_view_expand_row;
  void function(GtkTreeView* treeView, GtkTreePath* path) c_gtk_tree_view_expand_to_path;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_activate_on_single_click;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* column, GdkRectangle* rect) c_gtk_tree_view_get_background_area;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* column, GdkRectangle* rect) c_gtk_tree_view_get_cell_area;
  GtkTreeViewColumn* function(GtkTreeView* treeView, int n) c_gtk_tree_view_get_column;
  GList* function(GtkTreeView* treeView) c_gtk_tree_view_get_columns;
  void function(GtkTreeView* treeView, GtkTreePath** path, GtkTreeViewColumn** focusColumn) c_gtk_tree_view_get_cursor;
  bool function(GtkTreeView* treeView, int dragX, int dragY, GtkTreePath** path, GtkTreeViewDropPosition* pos) c_gtk_tree_view_get_dest_row_at_pos;
  void function(GtkTreeView* treeView, GtkTreePath** path, GtkTreeViewDropPosition* pos) c_gtk_tree_view_get_drag_dest_row;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_enable_search;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_enable_tree_lines;
  GtkTreeViewColumn* function(GtkTreeView* treeView) c_gtk_tree_view_get_expander_column;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_fixed_height_mode;
  GtkTreeViewGridLines function(GtkTreeView* treeView) c_gtk_tree_view_get_grid_lines;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_headers_clickable;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_headers_visible;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_hover_expand;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_hover_selection;
  int function(GtkTreeView* treeView) c_gtk_tree_view_get_level_indentation;
  GtkTreeModel* function(GtkTreeView* treeView) c_gtk_tree_view_get_model;
  uint function(GtkTreeView* treeView) c_gtk_tree_view_get_n_columns;
  bool function(GtkTreeView* treeView, int x, int y, GtkTreePath** path, GtkTreeViewColumn** column, int* cellX, int* cellY) c_gtk_tree_view_get_path_at_pos;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_reorderable;
  GtkTreeViewRowSeparatorFunc function(GtkTreeView* treeView) c_gtk_tree_view_get_row_separator_func;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_rubber_banding;
  int function(GtkTreeView* treeView) c_gtk_tree_view_get_search_column;
  GtkEditable* function(GtkTreeView* treeView) c_gtk_tree_view_get_search_entry;
  GtkTreeViewSearchEqualFunc function(GtkTreeView* treeView) c_gtk_tree_view_get_search_equal_func;
  GtkTreeSelection* function(GtkTreeView* treeView) c_gtk_tree_view_get_selection;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_get_show_expanders;
  int function(GtkTreeView* treeView) c_gtk_tree_view_get_tooltip_column;
  bool function(GtkTreeView* treeView, int x, int y, bool keyboardTip, GtkTreeModel** model, GtkTreePath** path, GtkTreeIter* iter) c_gtk_tree_view_get_tooltip_context;
  bool function(GtkTreeView* treeView, GtkTreePath** startPath, GtkTreePath** endPath) c_gtk_tree_view_get_visible_range;
  void function(GtkTreeView* treeView, GdkRectangle* visibleRect) c_gtk_tree_view_get_visible_rect;
  int function(GtkTreeView* treeView, GtkTreeViewColumn* column, int position) c_gtk_tree_view_insert_column;
  int function(GtkTreeView* treeView, int position, const(char)* title, GtkCellRenderer* cell,  ...) c_gtk_tree_view_insert_column_with_attributes;
  int function(GtkTreeView* treeView, int position, const(char)* title, GtkCellRenderer* cell, GtkTreeCellDataFunc func, void* data, GDestroyNotify dnotify) c_gtk_tree_view_insert_column_with_data_func;
  bool function(GtkTreeView* treeView, int x, int y, GtkTreePath** path, GtkTreeViewColumn** column, int* cellX, int* cellY) c_gtk_tree_view_is_blank_at_pos;
  bool function(GtkTreeView* treeView) c_gtk_tree_view_is_rubber_banding_active;
  void function(GtkTreeView* treeView, GtkTreeViewMappingFunc func, void* data) c_gtk_tree_view_map_expanded_rows;
  void function(GtkTreeView* treeView, GtkTreeViewColumn* column, GtkTreeViewColumn* baseColumn) c_gtk_tree_view_move_column_after;
  int function(GtkTreeView* treeView, GtkTreeViewColumn* column) c_gtk_tree_view_remove_column;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* column) c_gtk_tree_view_row_activated;
  bool function(GtkTreeView* treeView, GtkTreePath* path) c_gtk_tree_view_row_expanded;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* column, bool useAlign, float rowAlign, float colAlign) c_gtk_tree_view_scroll_to_cell;
  void function(GtkTreeView* treeView, int treeX, int treeY) c_gtk_tree_view_scroll_to_point;
  void function(GtkTreeView* treeView, bool single) c_gtk_tree_view_set_activate_on_single_click;
  void function(GtkTreeView* treeView, GtkTreeViewColumnDropFunc func, void* userData, GDestroyNotify destroy) c_gtk_tree_view_set_column_drag_function;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* focusColumn, bool startEditing) c_gtk_tree_view_set_cursor;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* focusColumn, GtkCellRenderer* focusCell, bool startEditing) c_gtk_tree_view_set_cursor_on_cell;
  void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewDropPosition pos) c_gtk_tree_view_set_drag_dest_row;
  void function(GtkTreeView* treeView, bool enableSearch) c_gtk_tree_view_set_enable_search;
  void function(GtkTreeView* treeView, bool enabled) c_gtk_tree_view_set_enable_tree_lines;
  void function(GtkTreeView* treeView, GtkTreeViewColumn* column) c_gtk_tree_view_set_expander_column;
  void function(GtkTreeView* treeView, bool enable) c_gtk_tree_view_set_fixed_height_mode;
  void function(GtkTreeView* treeView, GtkTreeViewGridLines gridLines) c_gtk_tree_view_set_grid_lines;
  void function(GtkTreeView* treeView, bool setting) c_gtk_tree_view_set_headers_clickable;
  void function(GtkTreeView* treeView, bool headersVisible) c_gtk_tree_view_set_headers_visible;
  void function(GtkTreeView* treeView, bool expand) c_gtk_tree_view_set_hover_expand;
  void function(GtkTreeView* treeView, bool hover) c_gtk_tree_view_set_hover_selection;
  void function(GtkTreeView* treeView, int indentation) c_gtk_tree_view_set_level_indentation;
  void function(GtkTreeView* treeView, GtkTreeModel* model) c_gtk_tree_view_set_model;
  void function(GtkTreeView* treeView, bool reorderable) c_gtk_tree_view_set_reorderable;
  void function(GtkTreeView* treeView, GtkTreeViewRowSeparatorFunc func, void* data, GDestroyNotify destroy) c_gtk_tree_view_set_row_separator_func;
  void function(GtkTreeView* treeView, bool enable) c_gtk_tree_view_set_rubber_banding;
  void function(GtkTreeView* treeView, int column) c_gtk_tree_view_set_search_column;
  void function(GtkTreeView* treeView, GtkEditable* entry) c_gtk_tree_view_set_search_entry;
  void function(GtkTreeView* treeView, GtkTreeViewSearchEqualFunc searchEqualFunc, void* searchUserData, GDestroyNotify searchDestroy) c_gtk_tree_view_set_search_equal_func;
  void function(GtkTreeView* treeView, bool enabled) c_gtk_tree_view_set_show_expanders;
  void function(GtkTreeView* treeView, GtkTooltip* tooltip, GtkTreePath* path, GtkTreeViewColumn* column, GtkCellRenderer* cell) c_gtk_tree_view_set_tooltip_cell;
  void function(GtkTreeView* treeView, int column) c_gtk_tree_view_set_tooltip_column;
  void function(GtkTreeView* treeView, GtkTooltip* tooltip, GtkTreePath* path) c_gtk_tree_view_set_tooltip_row;
  void function(GtkTreeView* treeView) c_gtk_tree_view_unset_rows_drag_dest;
  void function(GtkTreeView* treeView) c_gtk_tree_view_unset_rows_drag_source;

  // TreeViewColumn
  GType function() c_gtk_tree_view_column_get_type;
  GtkTreeViewColumn* function() c_gtk_tree_view_column_new;
  GtkTreeViewColumn* function(GtkCellArea* area) c_gtk_tree_view_column_new_with_area;
  GtkTreeViewColumn* function(const(char)* title, GtkCellRenderer* cell,  ...) c_gtk_tree_view_column_new_with_attributes;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cellRenderer, const(char)* attribute, int column) c_gtk_tree_view_column_add_attribute;
  bool function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cellRenderer, int* xOffset, int* width) c_gtk_tree_view_column_cell_get_position;
  void function(GtkTreeViewColumn* treeColumn, int* xOffset, int* yOffset, int* width, int* height) c_gtk_tree_view_column_cell_get_size;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_cell_is_visible;
  void function(GtkTreeViewColumn* treeColumn, GtkTreeModel* treeModel, GtkTreeIter* iter, bool isExpander, bool isExpanded) c_gtk_tree_view_column_cell_set_cell_data;
  void function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_clear;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cellRenderer) c_gtk_tree_view_column_clear_attributes;
  void function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_clicked;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cell) c_gtk_tree_view_column_focus_cell;
  float function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_alignment;
  GtkWidget* function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_button;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_clickable;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_expand;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_fixed_width;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_max_width;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_min_width;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_reorderable;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_resizable;
  GtkTreeViewColumnSizing function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_sizing;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_sort_column_id;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_sort_indicator;
  GtkSortType function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_sort_order;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_spacing;
  const(char)* function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_title;
  GtkWidget* function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_tree_view;
  bool function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_visible;
  GtkWidget* function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_widget;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_width;
  int function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_get_x_offset;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cell, bool expand) c_gtk_tree_view_column_pack_end;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cell, bool expand) c_gtk_tree_view_column_pack_start;
  void function(GtkTreeViewColumn* treeColumn) c_gtk_tree_view_column_queue_resize;
  void function(GtkTreeViewColumn* treeColumn, float xalign) c_gtk_tree_view_column_set_alignment;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cellRenderer,  ...) c_gtk_tree_view_column_set_attributes;
  void function(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cellRenderer, GtkTreeCellDataFunc func, void* funcData, GDestroyNotify destroy) c_gtk_tree_view_column_set_cell_data_func;
  void function(GtkTreeViewColumn* treeColumn, bool clickable) c_gtk_tree_view_column_set_clickable;
  void function(GtkTreeViewColumn* treeColumn, bool expand) c_gtk_tree_view_column_set_expand;
  void function(GtkTreeViewColumn* treeColumn, int fixedWidth) c_gtk_tree_view_column_set_fixed_width;
  void function(GtkTreeViewColumn* treeColumn, int maxWidth) c_gtk_tree_view_column_set_max_width;
  void function(GtkTreeViewColumn* treeColumn, int minWidth) c_gtk_tree_view_column_set_min_width;
  void function(GtkTreeViewColumn* treeColumn, bool reorderable) c_gtk_tree_view_column_set_reorderable;
  void function(GtkTreeViewColumn* treeColumn, bool resizable) c_gtk_tree_view_column_set_resizable;
  void function(GtkTreeViewColumn* treeColumn, GtkTreeViewColumnSizing type) c_gtk_tree_view_column_set_sizing;
  void function(GtkTreeViewColumn* treeColumn, int sortColumnId) c_gtk_tree_view_column_set_sort_column_id;
  void function(GtkTreeViewColumn* treeColumn, bool setting) c_gtk_tree_view_column_set_sort_indicator;
  void function(GtkTreeViewColumn* treeColumn, GtkSortType order) c_gtk_tree_view_column_set_sort_order;
  void function(GtkTreeViewColumn* treeColumn, int spacing) c_gtk_tree_view_column_set_spacing;
  void function(GtkTreeViewColumn* treeColumn, const(char)* title) c_gtk_tree_view_column_set_title;
  void function(GtkTreeViewColumn* treeColumn, bool visible) c_gtk_tree_view_column_set_visible;
  void function(GtkTreeViewColumn* treeColumn, GtkWidget* widget) c_gtk_tree_view_column_set_widget;

  // UriLauncher
  GType function() c_gtk_uri_launcher_get_type;
  GtkUriLauncher* function(const(char)* uri) c_gtk_uri_launcher_new;
  const(char)* function(GtkUriLauncher* self) c_gtk_uri_launcher_get_uri;
  void function(GtkUriLauncher* self, GtkWindow* parent, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) c_gtk_uri_launcher_launch;
  bool function(GtkUriLauncher* self, GAsyncResult* result, GError** _err) c_gtk_uri_launcher_launch_finish;
  void function(GtkUriLauncher* self, const(char)* uri) c_gtk_uri_launcher_set_uri;

  // Video
  GType function() c_gtk_video_get_type;
  GtkWidget* function() c_gtk_video_new;
  GtkWidget* function(GFile* file) c_gtk_video_new_for_file;
  GtkWidget* function(const(char)* filename) c_gtk_video_new_for_filename;
  GtkWidget* function(GtkMediaStream* stream) c_gtk_video_new_for_media_stream;
  GtkWidget* function(const(char)* resourcePath) c_gtk_video_new_for_resource;
  bool function(GtkVideo* self) c_gtk_video_get_autoplay;
  GFile* function(GtkVideo* self) c_gtk_video_get_file;
  GtkGraphicsOffloadEnabled function(GtkVideo* self) c_gtk_video_get_graphics_offload;
  bool function(GtkVideo* self) c_gtk_video_get_loop;
  GtkMediaStream* function(GtkVideo* self) c_gtk_video_get_media_stream;
  void function(GtkVideo* self, bool autoplay) c_gtk_video_set_autoplay;
  void function(GtkVideo* self, GFile* file) c_gtk_video_set_file;
  void function(GtkVideo* self, const(char)* filename) c_gtk_video_set_filename;
  void function(GtkVideo* self, GtkGraphicsOffloadEnabled enabled) c_gtk_video_set_graphics_offload;
  void function(GtkVideo* self, bool loop) c_gtk_video_set_loop;
  void function(GtkVideo* self, GtkMediaStream* stream) c_gtk_video_set_media_stream;
  void function(GtkVideo* self, const(char)* resourcePath) c_gtk_video_set_resource;

  // Viewport
  GType function() c_gtk_viewport_get_type;
  GtkWidget* function(GtkAdjustment* hadjustment, GtkAdjustment* vadjustment) c_gtk_viewport_new;
  GtkWidget* function(GtkViewport* viewport) c_gtk_viewport_get_child;
  bool function(GtkViewport* viewport) c_gtk_viewport_get_scroll_to_focus;
  void function(GtkViewport* viewport, GtkWidget* descendant, GtkScrollInfo* scroll) c_gtk_viewport_scroll_to;
  void function(GtkViewport* viewport, GtkWidget* child) c_gtk_viewport_set_child;
  void function(GtkViewport* viewport, bool scrollToFocus) c_gtk_viewport_set_scroll_to_focus;

  // VolumeButton
  GType function() c_gtk_volume_button_get_type;
  GtkWidget* function() c_gtk_volume_button_new;

  // Widget
  GType function() c_gtk_widget_get_type;
  GtkTextDirection function() c_gtk_widget_get_default_direction;
  void function(GtkTextDirection dir) c_gtk_widget_set_default_direction;
  void function(GtkWidget* widget, const(char)* actionName, bool enabled) c_gtk_widget_action_set_enabled;
  bool function(GtkWidget* widget) c_gtk_widget_activate;
  bool function(GtkWidget* widget, const(char)* name, const(char)* formatString,  ...) c_gtk_widget_activate_action;
  bool function(GtkWidget* widget, const(char)* name, VariantC* args) c_gtk_widget_activate_action_variant;
  void function(GtkWidget* widget) c_gtk_widget_activate_default;
  void function(GtkWidget* widget, GtkEventController* controller) c_gtk_widget_add_controller;
  void function(GtkWidget* widget, const(char)* cssClass) c_gtk_widget_add_css_class;
  void function(GtkWidget* widget, GtkWidget* label) c_gtk_widget_add_mnemonic_label;
  uint function(GtkWidget* widget, GtkTickCallback callback, void* userData, GDestroyNotify notify) c_gtk_widget_add_tick_callback;
  void function(GtkWidget* widget, int width, int height, int baseline, GskTransform* transform) c_gtk_widget_allocate;
  bool function(GtkWidget* widget, GtkDirectionType direction) c_gtk_widget_child_focus;
  bool function(GtkWidget* widget, GtkWidget* target, graphene_rect_t* outBounds) c_gtk_widget_compute_bounds;
  bool function(GtkWidget* widget, GtkOrientation orientation) c_gtk_widget_compute_expand;
  bool function(GtkWidget* widget, GtkWidget* target, const(graphene_point_t)* point, graphene_point_t* outPoint) c_gtk_widget_compute_point;
  bool function(GtkWidget* widget, GtkWidget* target, graphene_matrix_t* outTransform) c_gtk_widget_compute_transform;
  bool function(GtkWidget* widget, double x, double y) c_gtk_widget_contains;
  PangoContext* function(GtkWidget* widget) c_gtk_widget_create_pango_context;
  PangoLayout* function(GtkWidget* widget, const(char)* text) c_gtk_widget_create_pango_layout;
  void function(GtkWidget* widget, GType widgetType) c_gtk_widget_dispose_template;
  bool function(GtkWidget* widget, int startX, int startY, int currentX, int currentY) c_gtk_drag_check_threshold;
  void function(GtkWidget* widget) c_gtk_widget_error_bell;
  int function(GtkWidget* widget) c_gtk_widget_get_allocated_baseline;
  int function(GtkWidget* widget) c_gtk_widget_get_allocated_height;
  int function(GtkWidget* widget) c_gtk_widget_get_allocated_width;
  void function(GtkWidget* widget, GtkAllocation* allocation) c_gtk_widget_get_allocation;
  GtkWidget* function(GtkWidget* widget, GType widgetType) c_gtk_widget_get_ancestor;
  int function(GtkWidget* widget) c_gtk_widget_get_baseline;
  bool function(GtkWidget* widget) c_gtk_widget_get_can_focus;
  bool function(GtkWidget* widget) c_gtk_widget_get_can_target;
  bool function(GtkWidget* widget) c_gtk_widget_get_child_visible;
  GdkClipboard* function(GtkWidget* widget) c_gtk_widget_get_clipboard;
  void function(GtkWidget* widget, GdkRGBA* color) c_gtk_widget_get_color;
  char** function(GtkWidget* widget) c_gtk_widget_get_css_classes;
  const(char)* function(GtkWidget* self) c_gtk_widget_get_css_name;
  GdkCursor* function(GtkWidget* widget) c_gtk_widget_get_cursor;
  GtkTextDirection function(GtkWidget* widget) c_gtk_widget_get_direction;
  GdkDisplay* function(GtkWidget* widget) c_gtk_widget_get_display;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_first_child;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_focus_child;
  bool function(GtkWidget* widget) c_gtk_widget_get_focus_on_click;
  bool function(GtkWidget* widget) c_gtk_widget_get_focusable;
  PangoFontMap* function(GtkWidget* widget) c_gtk_widget_get_font_map;
  const(cairo_font_options_t)* function(GtkWidget* widget) c_gtk_widget_get_font_options;
  GdkFrameClock* function(GtkWidget* widget) c_gtk_widget_get_frame_clock;
  GtkAlign function(GtkWidget* widget) c_gtk_widget_get_halign;
  bool function(GtkWidget* widget) c_gtk_widget_get_has_tooltip;
  int function(GtkWidget* widget) c_gtk_widget_get_height;
  bool function(GtkWidget* widget) c_gtk_widget_get_hexpand;
  bool function(GtkWidget* widget) c_gtk_widget_get_hexpand_set;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_last_child;
  GtkLayoutManager* function(GtkWidget* widget) c_gtk_widget_get_layout_manager;
  bool function(GtkWidget* widget) c_gtk_widget_get_mapped;
  int function(GtkWidget* widget) c_gtk_widget_get_margin_bottom;
  int function(GtkWidget* widget) c_gtk_widget_get_margin_end;
  int function(GtkWidget* widget) c_gtk_widget_get_margin_start;
  int function(GtkWidget* widget) c_gtk_widget_get_margin_top;
  const(char)* function(GtkWidget* widget) c_gtk_widget_get_name;
  GtkNative* function(GtkWidget* widget) c_gtk_widget_get_native;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_next_sibling;
  double function(GtkWidget* widget) c_gtk_widget_get_opacity;
  GtkOverflow function(GtkWidget* widget) c_gtk_widget_get_overflow;
  PangoContext* function(GtkWidget* widget) c_gtk_widget_get_pango_context;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_parent;
  void function(GtkWidget* widget, GtkRequisition* minimumSize, GtkRequisition* naturalSize) c_gtk_widget_get_preferred_size;
  GtkWidget* function(GtkWidget* widget) c_gtk_widget_get_prev_sibling;
  GdkClipboard* function(GtkWidget* widget) c_gtk_widget_get_primary_clipboard;
  bool function(GtkWidget* widget) c_gtk_widget_get_realized;
  bool function(GtkWidget* widget) c_gtk_widget_get_receives_default;
  GtkSizeRequestMode function(GtkWidget* widget) c_gtk_widget_get_request_mode;
  GtkRoot* function(GtkWidget* widget) c_gtk_widget_get_root;
  int function(GtkWidget* widget) c_gtk_widget_get_scale_factor;
  bool function(GtkWidget* widget) c_gtk_widget_get_sensitive;
  GtkSettings* function(GtkWidget* widget) c_gtk_widget_get_settings;
  int function(GtkWidget* widget, GtkOrientation orientation) c_gtk_widget_get_size;
  void function(GtkWidget* widget, int* width, int* height) c_gtk_widget_get_size_request;
  GtkStateFlags function(GtkWidget* widget) c_gtk_widget_get_state_flags;
  GtkStyleContext* function(GtkWidget* widget) c_gtk_widget_get_style_context;
  ObjectC* function(GtkWidget* widget, GType widgetType, const(char)* name) c_gtk_widget_get_template_child;
  const(char)* function(GtkWidget* widget) c_gtk_widget_get_tooltip_markup;
  const(char)* function(GtkWidget* widget) c_gtk_widget_get_tooltip_text;
  GtkAlign function(GtkWidget* widget) c_gtk_widget_get_valign;
  bool function(GtkWidget* widget) c_gtk_widget_get_vexpand;
  bool function(GtkWidget* widget) c_gtk_widget_get_vexpand_set;
  bool function(GtkWidget* widget) c_gtk_widget_get_visible;
  int function(GtkWidget* widget) c_gtk_widget_get_width;
  bool function(GtkWidget* widget) c_gtk_widget_grab_focus;
  bool function(GtkWidget* widget, const(char)* cssClass) c_gtk_widget_has_css_class;
  bool function(GtkWidget* widget) c_gtk_widget_has_default;
  bool function(GtkWidget* widget) c_gtk_widget_has_focus;
  bool function(GtkWidget* widget) c_gtk_widget_has_visible_focus;
  void function(GtkWidget* widget) c_gtk_widget_hide;
  bool function(GtkWidget* widget) c_gtk_widget_in_destruction;
  void function(GtkWidget* widget) c_gtk_widget_init_template;
  void function(GtkWidget* widget, const(char)* name, GActionGroup* group) c_gtk_widget_insert_action_group;
  void function(GtkWidget* widget, GtkWidget* parent, GtkWidget* previousSibling) c_gtk_widget_insert_after;
  void function(GtkWidget* widget, GtkWidget* parent, GtkWidget* nextSibling) c_gtk_widget_insert_before;
  bool function(GtkWidget* widget, GtkWidget* ancestor) c_gtk_widget_is_ancestor;
  bool function(GtkWidget* widget) c_gtk_widget_is_drawable;
  bool function(GtkWidget* widget) c_gtk_widget_is_focus;
  bool function(GtkWidget* widget) c_gtk_widget_is_sensitive;
  bool function(GtkWidget* widget) c_gtk_widget_is_visible;
  bool function(GtkWidget* widget, GtkDirectionType direction) c_gtk_widget_keynav_failed;
  GList* function(GtkWidget* widget) c_gtk_widget_list_mnemonic_labels;
  void function(GtkWidget* widget) c_gtk_widget_map;
  void function(GtkWidget* widget, GtkOrientation orientation, int forSize, int* minimum, int* natural, int* minimumBaseline, int* naturalBaseline) c_gtk_widget_measure;
  bool function(GtkWidget* widget, bool groupCycling) c_gtk_widget_mnemonic_activate;
  GListModel* function(GtkWidget* widget) c_gtk_widget_observe_children;
  GListModel* function(GtkWidget* widget) c_gtk_widget_observe_controllers;
  GtkWidget* function(GtkWidget* widget, double x, double y, GtkPickFlags flags) c_gtk_widget_pick;
  void function(GtkWidget* widget) c_gtk_widget_queue_allocate;
  void function(GtkWidget* widget) c_gtk_widget_queue_draw;
  void function(GtkWidget* widget) c_gtk_widget_queue_resize;
  void function(GtkWidget* widget) c_gtk_widget_realize;
  void function(GtkWidget* widget, GtkEventController* controller) c_gtk_widget_remove_controller;
  void function(GtkWidget* widget, const(char)* cssClass) c_gtk_widget_remove_css_class;
  void function(GtkWidget* widget, GtkWidget* label) c_gtk_widget_remove_mnemonic_label;
  void function(GtkWidget* widget, uint id) c_gtk_widget_remove_tick_callback;
  void function(GtkWidget* widget, bool canFocus) c_gtk_widget_set_can_focus;
  void function(GtkWidget* widget, bool canTarget) c_gtk_widget_set_can_target;
  void function(GtkWidget* widget, bool childVisible) c_gtk_widget_set_child_visible;
  void function(GtkWidget* widget, const(char*)* classes) c_gtk_widget_set_css_classes;
  void function(GtkWidget* widget, GdkCursor* cursor) c_gtk_widget_set_cursor;
  void function(GtkWidget* widget, const(char)* name) c_gtk_widget_set_cursor_from_name;
  void function(GtkWidget* widget, GtkTextDirection dir) c_gtk_widget_set_direction;
  void function(GtkWidget* widget, GtkWidget* child) c_gtk_widget_set_focus_child;
  void function(GtkWidget* widget, bool focusOnClick) c_gtk_widget_set_focus_on_click;
  void function(GtkWidget* widget, bool focusable) c_gtk_widget_set_focusable;
  void function(GtkWidget* widget, PangoFontMap* fontMap) c_gtk_widget_set_font_map;
  void function(GtkWidget* widget, const(cairo_font_options_t)* options) c_gtk_widget_set_font_options;
  void function(GtkWidget* widget, GtkAlign align_) c_gtk_widget_set_halign;
  void function(GtkWidget* widget, bool hasTooltip) c_gtk_widget_set_has_tooltip;
  void function(GtkWidget* widget, bool expand) c_gtk_widget_set_hexpand;
  void function(GtkWidget* widget, bool set) c_gtk_widget_set_hexpand_set;
  void function(GtkWidget* widget, GtkLayoutManager* layoutManager) c_gtk_widget_set_layout_manager;
  void function(GtkWidget* widget, int margin) c_gtk_widget_set_margin_bottom;
  void function(GtkWidget* widget, int margin) c_gtk_widget_set_margin_end;
  void function(GtkWidget* widget, int margin) c_gtk_widget_set_margin_start;
  void function(GtkWidget* widget, int margin) c_gtk_widget_set_margin_top;
  void function(GtkWidget* widget, const(char)* name) c_gtk_widget_set_name;
  void function(GtkWidget* widget, double opacity) c_gtk_widget_set_opacity;
  void function(GtkWidget* widget, GtkOverflow overflow) c_gtk_widget_set_overflow;
  void function(GtkWidget* widget, GtkWidget* parent) c_gtk_widget_set_parent;
  void function(GtkWidget* widget, bool receivesDefault) c_gtk_widget_set_receives_default;
  void function(GtkWidget* widget, bool sensitive) c_gtk_widget_set_sensitive;
  void function(GtkWidget* widget, int width, int height) c_gtk_widget_set_size_request;
  void function(GtkWidget* widget, GtkStateFlags flags, bool clear) c_gtk_widget_set_state_flags;
  void function(GtkWidget* widget, const(char)* markup) c_gtk_widget_set_tooltip_markup;
  void function(GtkWidget* widget, const(char)* text) c_gtk_widget_set_tooltip_text;
  void function(GtkWidget* widget, GtkAlign align_) c_gtk_widget_set_valign;
  void function(GtkWidget* widget, bool expand) c_gtk_widget_set_vexpand;
  void function(GtkWidget* widget, bool set) c_gtk_widget_set_vexpand_set;
  void function(GtkWidget* widget, bool visible) c_gtk_widget_set_visible;
  bool function(GtkWidget* widget) c_gtk_widget_should_layout;
  void function(GtkWidget* widget) c_gtk_widget_show;
  void function(GtkWidget* widget, const(GtkAllocation)* allocation, int baseline) c_gtk_widget_size_allocate;
  void function(GtkWidget* widget, GtkWidget* child, GtkSnapshot* snapshot) c_gtk_widget_snapshot_child;
  bool function(GtkWidget* srcWidget, GtkWidget* destWidget, double srcX, double srcY, double* destX, double* destY) c_gtk_widget_translate_coordinates;
  void function(GtkWidget* widget) c_gtk_widget_trigger_tooltip_query;
  void function(GtkWidget* widget) c_gtk_widget_unmap;
  void function(GtkWidget* widget) c_gtk_widget_unparent;
  void function(GtkWidget* widget) c_gtk_widget_unrealize;
  void function(GtkWidget* widget, GtkStateFlags flags) c_gtk_widget_unset_state_flags;

  // WidgetClass
  void function(GtkWidgetClass* widgetClass, uint keyval, GdkModifierType mods, GtkShortcutFunc callback, const(char)* formatString,  ...) c_gtk_widget_class_add_binding;
  void function(GtkWidgetClass* widgetClass, uint keyval, GdkModifierType mods, const(char)* actionName, const(char)* formatString,  ...) c_gtk_widget_class_add_binding_action;
  void function(GtkWidgetClass* widgetClass, uint keyval, GdkModifierType mods, const(char)* signal, const(char)* formatString,  ...) c_gtk_widget_class_add_binding_signal;
  void function(GtkWidgetClass* widgetClass, GtkShortcut* shortcut) c_gtk_widget_class_add_shortcut;
  void function(GtkWidgetClass* widgetClass, const(char)* callbackName, GCallback callbackSymbol) c_gtk_widget_class_bind_template_callback_full;
  void function(GtkWidgetClass* widgetClass, const(char)* name, bool internalChild, ptrdiff_t structOffset) c_gtk_widget_class_bind_template_child_full;
  GtkAccessibleRole function(GtkWidgetClass* widgetClass) c_gtk_widget_class_get_accessible_role;
  uint function(GtkWidgetClass* widgetClass) c_gtk_widget_class_get_activate_signal;
  const(char)* function(GtkWidgetClass* widgetClass) c_gtk_widget_class_get_css_name;
  GType function(GtkWidgetClass* widgetClass) c_gtk_widget_class_get_layout_manager_type;
  void function(GtkWidgetClass* widgetClass, const(char)* actionName, const(char)* parameterType, GtkWidgetActionActivateFunc activate) c_gtk_widget_class_install_action;
  void function(GtkWidgetClass* widgetClass, const(char)* actionName, const(char)* propertyName) c_gtk_widget_class_install_property_action;
  bool function(GtkWidgetClass* widgetClass, uint index, GType* owner, const(char*)* actionName, const(GVariantType*)* parameterType, const(char*)* propertyName) c_gtk_widget_class_query_action;
  void function(GtkWidgetClass* widgetClass, GtkAccessibleRole accessibleRole) c_gtk_widget_class_set_accessible_role;
  void function(GtkWidgetClass* widgetClass, uint signalId) c_gtk_widget_class_set_activate_signal;
  void function(GtkWidgetClass* widgetClass, const(char)* signalName) c_gtk_widget_class_set_activate_signal_from_name;
  void function(GtkWidgetClass* widgetClass, const(char)* name) c_gtk_widget_class_set_css_name;
  void function(GtkWidgetClass* widgetClass, GType type) c_gtk_widget_class_set_layout_manager_type;
  void function(GtkWidgetClass* widgetClass, GBytes* templateBytes) c_gtk_widget_class_set_template;
  void function(GtkWidgetClass* widgetClass, const(char)* resourceName) c_gtk_widget_class_set_template_from_resource;
  void function(GtkWidgetClass* widgetClass, GtkBuilderScope* scope_) c_gtk_widget_class_set_template_scope;

  // WidgetPaintable
  GType function() c_gtk_widget_paintable_get_type;
  GdkPaintable* function(GtkWidget* widget) c_gtk_widget_paintable_new;
  GtkWidget* function(GtkWidgetPaintable* self) c_gtk_widget_paintable_get_widget;
  void function(GtkWidgetPaintable* self, GtkWidget* widget) c_gtk_widget_paintable_set_widget;

  // Window
  GType function() c_gtk_window_get_type;
  GtkWidget* function() c_gtk_window_new;
  const(char)* function() c_gtk_window_get_default_icon_name;
  GListModel* function() c_gtk_window_get_toplevels;
  GList* function() c_gtk_window_list_toplevels;
  void function(bool setting) c_gtk_window_set_auto_startup_notification;
  void function(const(char)* name) c_gtk_window_set_default_icon_name;
  void function(bool enable) c_gtk_window_set_interactive_debugging;
  void function(GtkWindow* window) c_gtk_window_close;
  void function(GtkWindow* window) c_gtk_window_destroy;
  void function(GtkWindow* window) c_gtk_window_fullscreen;
  void function(GtkWindow* window, GdkMonitor* monitor) c_gtk_window_fullscreen_on_monitor;
  GtkApplication* function(GtkWindow* window) c_gtk_window_get_application;
  GtkWidget* function(GtkWindow* window) c_gtk_window_get_child;
  bool function(GtkWindow* window) c_gtk_window_get_decorated;
  void function(GtkWindow* window, int* width, int* height) c_gtk_window_get_default_size;
  GtkWidget* function(GtkWindow* window) c_gtk_window_get_default_widget;
  bool function(GtkWindow* window) c_gtk_window_get_deletable;
  bool function(GtkWindow* window) c_gtk_window_get_destroy_with_parent;
  GtkWidget* function(GtkWindow* window) c_gtk_window_get_focus;
  bool function(GtkWindow* window) c_gtk_window_get_focus_visible;
  GtkWindowGroup* function(GtkWindow* window) c_gtk_window_get_group;
  bool function(GtkWindow* window) c_gtk_window_get_handle_menubar_accel;
  bool function(GtkWindow* window) c_gtk_window_get_hide_on_close;
  const(char)* function(GtkWindow* window) c_gtk_window_get_icon_name;
  bool function(GtkWindow* window) c_gtk_window_get_mnemonics_visible;
  bool function(GtkWindow* window) c_gtk_window_get_modal;
  bool function(GtkWindow* window) c_gtk_window_get_resizable;
  const(char)* function(GtkWindow* window) c_gtk_window_get_title;
  GtkWidget* function(GtkWindow* window) c_gtk_window_get_titlebar;
  GtkWindow* function(GtkWindow* window) c_gtk_window_get_transient_for;
  bool function(GtkWindow* window) c_gtk_window_has_group;
  bool function(GtkWindow* window) c_gtk_window_is_active;
  bool function(GtkWindow* window) c_gtk_window_is_fullscreen;
  bool function(GtkWindow* window) c_gtk_window_is_maximized;
  bool function(GtkWindow* window) c_gtk_window_is_suspended;
  void function(GtkWindow* window) c_gtk_window_maximize;
  void function(GtkWindow* window) c_gtk_window_minimize;
  void function(GtkWindow* window) c_gtk_window_present;
  void function(GtkWindow* window, uint timestamp) c_gtk_window_present_with_time;
  void function(GtkWindow* window, GtkApplication* application) c_gtk_window_set_application;
  void function(GtkWindow* window, GtkWidget* child) c_gtk_window_set_child;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_decorated;
  void function(GtkWindow* window, int width, int height) c_gtk_window_set_default_size;
  void function(GtkWindow* window, GtkWidget* defaultWidget) c_gtk_window_set_default_widget;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_deletable;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_destroy_with_parent;
  void function(GtkWindow* window, GdkDisplay* display) c_gtk_window_set_display;
  void function(GtkWindow* window, GtkWidget* focus) c_gtk_window_set_focus;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_focus_visible;
  void function(GtkWindow* window, bool handleMenubarAccel) c_gtk_window_set_handle_menubar_accel;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_hide_on_close;
  void function(GtkWindow* window, const(char)* name) c_gtk_window_set_icon_name;
  void function(GtkWindow* window, bool setting) c_gtk_window_set_mnemonics_visible;
  void function(GtkWindow* window, bool modal) c_gtk_window_set_modal;
  void function(GtkWindow* window, bool resizable) c_gtk_window_set_resizable;
  void function(GtkWindow* window, const(char)* startupId) c_gtk_window_set_startup_id;
  void function(GtkWindow* window, const(char)* title) c_gtk_window_set_title;
  void function(GtkWindow* window, GtkWidget* titlebar) c_gtk_window_set_titlebar;
  void function(GtkWindow* window, GtkWindow* parent) c_gtk_window_set_transient_for;
  void function(GtkWindow* window) c_gtk_window_unfullscreen;
  void function(GtkWindow* window) c_gtk_window_unmaximize;
  void function(GtkWindow* window) c_gtk_window_unminimize;

  // WindowControls
  GType function() c_gtk_window_controls_get_type;
  GtkWidget* function(GtkPackType side) c_gtk_window_controls_new;
  const(char)* function(GtkWindowControls* self) c_gtk_window_controls_get_decoration_layout;
  bool function(GtkWindowControls* self) c_gtk_window_controls_get_empty;
  GtkPackType function(GtkWindowControls* self) c_gtk_window_controls_get_side;
  void function(GtkWindowControls* self, const(char)* layout) c_gtk_window_controls_set_decoration_layout;
  void function(GtkWindowControls* self, GtkPackType side) c_gtk_window_controls_set_side;

  // WindowGroup
  GType function() c_gtk_window_group_get_type;
  GtkWindowGroup* function() c_gtk_window_group_new;
  void function(GtkWindowGroup* windowGroup, GtkWindow* window) c_gtk_window_group_add_window;
  GList* function(GtkWindowGroup* windowGroup) c_gtk_window_group_list_windows;
  void function(GtkWindowGroup* windowGroup, GtkWindow* window) c_gtk_window_group_remove_window;

  // WindowHandle
  GType function() c_gtk_window_handle_get_type;
  GtkWidget* function() c_gtk_window_handle_new;
  GtkWidget* function(GtkWindowHandle* self) c_gtk_window_handle_get_child;
  void function(GtkWindowHandle* self, GtkWidget* child) c_gtk_window_handle_set_child;
}

// ATContext
alias gtk_at_context_get_type = c_gtk_at_context_get_type;
alias gtk_at_context_create = c_gtk_at_context_create;
alias gtk_at_context_get_accessible = c_gtk_at_context_get_accessible;
alias gtk_at_context_get_accessible_role = c_gtk_at_context_get_accessible_role;

// AboutDialog
alias gtk_about_dialog_get_type = c_gtk_about_dialog_get_type;
alias gtk_about_dialog_new = c_gtk_about_dialog_new;
alias gtk_about_dialog_add_credit_section = c_gtk_about_dialog_add_credit_section;
alias gtk_about_dialog_get_artists = c_gtk_about_dialog_get_artists;
alias gtk_about_dialog_get_authors = c_gtk_about_dialog_get_authors;
alias gtk_about_dialog_get_comments = c_gtk_about_dialog_get_comments;
alias gtk_about_dialog_get_copyright = c_gtk_about_dialog_get_copyright;
alias gtk_about_dialog_get_documenters = c_gtk_about_dialog_get_documenters;
alias gtk_about_dialog_get_license = c_gtk_about_dialog_get_license;
alias gtk_about_dialog_get_license_type = c_gtk_about_dialog_get_license_type;
alias gtk_about_dialog_get_logo = c_gtk_about_dialog_get_logo;
alias gtk_about_dialog_get_logo_icon_name = c_gtk_about_dialog_get_logo_icon_name;
alias gtk_about_dialog_get_program_name = c_gtk_about_dialog_get_program_name;
alias gtk_about_dialog_get_system_information = c_gtk_about_dialog_get_system_information;
alias gtk_about_dialog_get_translator_credits = c_gtk_about_dialog_get_translator_credits;
alias gtk_about_dialog_get_version = c_gtk_about_dialog_get_version;
alias gtk_about_dialog_get_website = c_gtk_about_dialog_get_website;
alias gtk_about_dialog_get_website_label = c_gtk_about_dialog_get_website_label;
alias gtk_about_dialog_get_wrap_license = c_gtk_about_dialog_get_wrap_license;
alias gtk_about_dialog_set_artists = c_gtk_about_dialog_set_artists;
alias gtk_about_dialog_set_authors = c_gtk_about_dialog_set_authors;
alias gtk_about_dialog_set_comments = c_gtk_about_dialog_set_comments;
alias gtk_about_dialog_set_copyright = c_gtk_about_dialog_set_copyright;
alias gtk_about_dialog_set_documenters = c_gtk_about_dialog_set_documenters;
alias gtk_about_dialog_set_license = c_gtk_about_dialog_set_license;
alias gtk_about_dialog_set_license_type = c_gtk_about_dialog_set_license_type;
alias gtk_about_dialog_set_logo = c_gtk_about_dialog_set_logo;
alias gtk_about_dialog_set_logo_icon_name = c_gtk_about_dialog_set_logo_icon_name;
alias gtk_about_dialog_set_program_name = c_gtk_about_dialog_set_program_name;
alias gtk_about_dialog_set_system_information = c_gtk_about_dialog_set_system_information;
alias gtk_about_dialog_set_translator_credits = c_gtk_about_dialog_set_translator_credits;
alias gtk_about_dialog_set_version = c_gtk_about_dialog_set_version;
alias gtk_about_dialog_set_website = c_gtk_about_dialog_set_website;
alias gtk_about_dialog_set_website_label = c_gtk_about_dialog_set_website_label;
alias gtk_about_dialog_set_wrap_license = c_gtk_about_dialog_set_wrap_license;

// Accessible
alias gtk_accessible_get_type = c_gtk_accessible_get_type;
alias gtk_accessible_announce = c_gtk_accessible_announce;
alias gtk_accessible_get_accessible_parent = c_gtk_accessible_get_accessible_parent;
alias gtk_accessible_get_accessible_role = c_gtk_accessible_get_accessible_role;
alias gtk_accessible_get_at_context = c_gtk_accessible_get_at_context;
alias gtk_accessible_get_bounds = c_gtk_accessible_get_bounds;
alias gtk_accessible_get_first_accessible_child = c_gtk_accessible_get_first_accessible_child;
alias gtk_accessible_get_next_accessible_sibling = c_gtk_accessible_get_next_accessible_sibling;
alias gtk_accessible_get_platform_state = c_gtk_accessible_get_platform_state;
alias gtk_accessible_reset_property = c_gtk_accessible_reset_property;
alias gtk_accessible_reset_relation = c_gtk_accessible_reset_relation;
alias gtk_accessible_reset_state = c_gtk_accessible_reset_state;
alias gtk_accessible_set_accessible_parent = c_gtk_accessible_set_accessible_parent;
alias gtk_accessible_update_next_accessible_sibling = c_gtk_accessible_update_next_accessible_sibling;
alias gtk_accessible_update_property = c_gtk_accessible_update_property;
alias gtk_accessible_update_property_value = c_gtk_accessible_update_property_value;
alias gtk_accessible_update_relation = c_gtk_accessible_update_relation;
alias gtk_accessible_update_relation_value = c_gtk_accessible_update_relation_value;
alias gtk_accessible_update_state = c_gtk_accessible_update_state;
alias gtk_accessible_update_state_value = c_gtk_accessible_update_state_value;

// AccessibleList
alias gtk_accessible_list_get_type = c_gtk_accessible_list_get_type;
alias gtk_accessible_list_new_from_array = c_gtk_accessible_list_new_from_array;
alias gtk_accessible_list_new_from_list = c_gtk_accessible_list_new_from_list;
alias gtk_accessible_list_get_objects = c_gtk_accessible_list_get_objects;

// AccessibleRange
alias gtk_accessible_range_get_type = c_gtk_accessible_range_get_type;

// AccessibleText
alias gtk_accessible_text_get_type = c_gtk_accessible_text_get_type;
alias gtk_accessible_text_update_caret_position = c_gtk_accessible_text_update_caret_position;
alias gtk_accessible_text_update_contents = c_gtk_accessible_text_update_contents;
alias gtk_accessible_text_update_selection_bound = c_gtk_accessible_text_update_selection_bound;

// ActionBar
alias gtk_action_bar_get_type = c_gtk_action_bar_get_type;
alias gtk_action_bar_new = c_gtk_action_bar_new;
alias gtk_action_bar_get_center_widget = c_gtk_action_bar_get_center_widget;
alias gtk_action_bar_get_revealed = c_gtk_action_bar_get_revealed;
alias gtk_action_bar_pack_end = c_gtk_action_bar_pack_end;
alias gtk_action_bar_pack_start = c_gtk_action_bar_pack_start;
alias gtk_action_bar_remove = c_gtk_action_bar_remove;
alias gtk_action_bar_set_center_widget = c_gtk_action_bar_set_center_widget;
alias gtk_action_bar_set_revealed = c_gtk_action_bar_set_revealed;

// Actionable
alias gtk_actionable_get_type = c_gtk_actionable_get_type;
alias gtk_actionable_get_action_name = c_gtk_actionable_get_action_name;
alias gtk_actionable_get_action_target_value = c_gtk_actionable_get_action_target_value;
alias gtk_actionable_set_action_name = c_gtk_actionable_set_action_name;
alias gtk_actionable_set_action_target = c_gtk_actionable_set_action_target;
alias gtk_actionable_set_action_target_value = c_gtk_actionable_set_action_target_value;
alias gtk_actionable_set_detailed_action_name = c_gtk_actionable_set_detailed_action_name;

// ActivateAction
alias gtk_activate_action_get_type = c_gtk_activate_action_get_type;
alias gtk_activate_action_get = c_gtk_activate_action_get;

// Adjustment
alias gtk_adjustment_get_type = c_gtk_adjustment_get_type;
alias gtk_adjustment_new = c_gtk_adjustment_new;
alias gtk_adjustment_clamp_page = c_gtk_adjustment_clamp_page;
alias gtk_adjustment_configure = c_gtk_adjustment_configure;
alias gtk_adjustment_get_lower = c_gtk_adjustment_get_lower;
alias gtk_adjustment_get_minimum_increment = c_gtk_adjustment_get_minimum_increment;
alias gtk_adjustment_get_page_increment = c_gtk_adjustment_get_page_increment;
alias gtk_adjustment_get_page_size = c_gtk_adjustment_get_page_size;
alias gtk_adjustment_get_step_increment = c_gtk_adjustment_get_step_increment;
alias gtk_adjustment_get_upper = c_gtk_adjustment_get_upper;
alias gtk_adjustment_get_value = c_gtk_adjustment_get_value;
alias gtk_adjustment_set_lower = c_gtk_adjustment_set_lower;
alias gtk_adjustment_set_page_increment = c_gtk_adjustment_set_page_increment;
alias gtk_adjustment_set_page_size = c_gtk_adjustment_set_page_size;
alias gtk_adjustment_set_step_increment = c_gtk_adjustment_set_step_increment;
alias gtk_adjustment_set_upper = c_gtk_adjustment_set_upper;
alias gtk_adjustment_set_value = c_gtk_adjustment_set_value;

// AlertDialog
alias gtk_alert_dialog_get_type = c_gtk_alert_dialog_get_type;
alias gtk_alert_dialog_new = c_gtk_alert_dialog_new;
alias gtk_alert_dialog_choose = c_gtk_alert_dialog_choose;
alias gtk_alert_dialog_choose_finish = c_gtk_alert_dialog_choose_finish;
alias gtk_alert_dialog_get_buttons = c_gtk_alert_dialog_get_buttons;
alias gtk_alert_dialog_get_cancel_button = c_gtk_alert_dialog_get_cancel_button;
alias gtk_alert_dialog_get_default_button = c_gtk_alert_dialog_get_default_button;
alias gtk_alert_dialog_get_detail = c_gtk_alert_dialog_get_detail;
alias gtk_alert_dialog_get_message = c_gtk_alert_dialog_get_message;
alias gtk_alert_dialog_get_modal = c_gtk_alert_dialog_get_modal;
alias gtk_alert_dialog_set_buttons = c_gtk_alert_dialog_set_buttons;
alias gtk_alert_dialog_set_cancel_button = c_gtk_alert_dialog_set_cancel_button;
alias gtk_alert_dialog_set_default_button = c_gtk_alert_dialog_set_default_button;
alias gtk_alert_dialog_set_detail = c_gtk_alert_dialog_set_detail;
alias gtk_alert_dialog_set_message = c_gtk_alert_dialog_set_message;
alias gtk_alert_dialog_set_modal = c_gtk_alert_dialog_set_modal;
alias gtk_alert_dialog_show = c_gtk_alert_dialog_show;

// AlternativeTrigger
alias gtk_alternative_trigger_get_type = c_gtk_alternative_trigger_get_type;
alias gtk_alternative_trigger_new = c_gtk_alternative_trigger_new;
alias gtk_alternative_trigger_get_first = c_gtk_alternative_trigger_get_first;
alias gtk_alternative_trigger_get_second = c_gtk_alternative_trigger_get_second;

// AnyFilter
alias gtk_any_filter_get_type = c_gtk_any_filter_get_type;
alias gtk_any_filter_new = c_gtk_any_filter_new;

// AppChooser
alias gtk_app_chooser_get_type = c_gtk_app_chooser_get_type;
alias gtk_app_chooser_get_app_info = c_gtk_app_chooser_get_app_info;
alias gtk_app_chooser_get_content_type = c_gtk_app_chooser_get_content_type;
alias gtk_app_chooser_refresh = c_gtk_app_chooser_refresh;

// AppChooserButton
alias gtk_app_chooser_button_get_type = c_gtk_app_chooser_button_get_type;
alias gtk_app_chooser_button_new = c_gtk_app_chooser_button_new;
alias gtk_app_chooser_button_append_custom_item = c_gtk_app_chooser_button_append_custom_item;
alias gtk_app_chooser_button_append_separator = c_gtk_app_chooser_button_append_separator;
alias gtk_app_chooser_button_get_heading = c_gtk_app_chooser_button_get_heading;
alias gtk_app_chooser_button_get_modal = c_gtk_app_chooser_button_get_modal;
alias gtk_app_chooser_button_get_show_default_item = c_gtk_app_chooser_button_get_show_default_item;
alias gtk_app_chooser_button_get_show_dialog_item = c_gtk_app_chooser_button_get_show_dialog_item;
alias gtk_app_chooser_button_set_active_custom_item = c_gtk_app_chooser_button_set_active_custom_item;
alias gtk_app_chooser_button_set_heading = c_gtk_app_chooser_button_set_heading;
alias gtk_app_chooser_button_set_modal = c_gtk_app_chooser_button_set_modal;
alias gtk_app_chooser_button_set_show_default_item = c_gtk_app_chooser_button_set_show_default_item;
alias gtk_app_chooser_button_set_show_dialog_item = c_gtk_app_chooser_button_set_show_dialog_item;

// AppChooserDialog
alias gtk_app_chooser_dialog_get_type = c_gtk_app_chooser_dialog_get_type;
alias gtk_app_chooser_dialog_new = c_gtk_app_chooser_dialog_new;
alias gtk_app_chooser_dialog_new_for_content_type = c_gtk_app_chooser_dialog_new_for_content_type;
alias gtk_app_chooser_dialog_get_heading = c_gtk_app_chooser_dialog_get_heading;
alias gtk_app_chooser_dialog_get_widget = c_gtk_app_chooser_dialog_get_widget;
alias gtk_app_chooser_dialog_set_heading = c_gtk_app_chooser_dialog_set_heading;

// AppChooserWidget
alias gtk_app_chooser_widget_get_type = c_gtk_app_chooser_widget_get_type;
alias gtk_app_chooser_widget_new = c_gtk_app_chooser_widget_new;
alias gtk_app_chooser_widget_get_default_text = c_gtk_app_chooser_widget_get_default_text;
alias gtk_app_chooser_widget_get_show_all = c_gtk_app_chooser_widget_get_show_all;
alias gtk_app_chooser_widget_get_show_default = c_gtk_app_chooser_widget_get_show_default;
alias gtk_app_chooser_widget_get_show_fallback = c_gtk_app_chooser_widget_get_show_fallback;
alias gtk_app_chooser_widget_get_show_other = c_gtk_app_chooser_widget_get_show_other;
alias gtk_app_chooser_widget_get_show_recommended = c_gtk_app_chooser_widget_get_show_recommended;
alias gtk_app_chooser_widget_set_default_text = c_gtk_app_chooser_widget_set_default_text;
alias gtk_app_chooser_widget_set_show_all = c_gtk_app_chooser_widget_set_show_all;
alias gtk_app_chooser_widget_set_show_default = c_gtk_app_chooser_widget_set_show_default;
alias gtk_app_chooser_widget_set_show_fallback = c_gtk_app_chooser_widget_set_show_fallback;
alias gtk_app_chooser_widget_set_show_other = c_gtk_app_chooser_widget_set_show_other;
alias gtk_app_chooser_widget_set_show_recommended = c_gtk_app_chooser_widget_set_show_recommended;

// Application
alias gtk_application_get_type = c_gtk_application_get_type;
alias gtk_application_new = c_gtk_application_new;
alias gtk_application_add_window = c_gtk_application_add_window;
alias gtk_application_get_accels_for_action = c_gtk_application_get_accels_for_action;
alias gtk_application_get_actions_for_accel = c_gtk_application_get_actions_for_accel;
alias gtk_application_get_active_window = c_gtk_application_get_active_window;
alias gtk_application_get_menu_by_id = c_gtk_application_get_menu_by_id;
alias gtk_application_get_menubar = c_gtk_application_get_menubar;
alias gtk_application_get_window_by_id = c_gtk_application_get_window_by_id;
alias gtk_application_get_windows = c_gtk_application_get_windows;
alias gtk_application_inhibit = c_gtk_application_inhibit;
alias gtk_application_list_action_descriptions = c_gtk_application_list_action_descriptions;
alias gtk_application_remove_window = c_gtk_application_remove_window;
alias gtk_application_set_accels_for_action = c_gtk_application_set_accels_for_action;
alias gtk_application_set_menubar = c_gtk_application_set_menubar;
alias gtk_application_uninhibit = c_gtk_application_uninhibit;

// ApplicationWindow
alias gtk_application_window_get_type = c_gtk_application_window_get_type;
alias gtk_application_window_new = c_gtk_application_window_new;
alias gtk_application_window_get_help_overlay = c_gtk_application_window_get_help_overlay;
alias gtk_application_window_get_id = c_gtk_application_window_get_id;
alias gtk_application_window_get_show_menubar = c_gtk_application_window_get_show_menubar;
alias gtk_application_window_set_help_overlay = c_gtk_application_window_set_help_overlay;
alias gtk_application_window_set_show_menubar = c_gtk_application_window_set_show_menubar;

// AspectFrame
alias gtk_aspect_frame_get_type = c_gtk_aspect_frame_get_type;
alias gtk_aspect_frame_new = c_gtk_aspect_frame_new;
alias gtk_aspect_frame_get_child = c_gtk_aspect_frame_get_child;
alias gtk_aspect_frame_get_obey_child = c_gtk_aspect_frame_get_obey_child;
alias gtk_aspect_frame_get_ratio = c_gtk_aspect_frame_get_ratio;
alias gtk_aspect_frame_get_xalign = c_gtk_aspect_frame_get_xalign;
alias gtk_aspect_frame_get_yalign = c_gtk_aspect_frame_get_yalign;
alias gtk_aspect_frame_set_child = c_gtk_aspect_frame_set_child;
alias gtk_aspect_frame_set_obey_child = c_gtk_aspect_frame_set_obey_child;
alias gtk_aspect_frame_set_ratio = c_gtk_aspect_frame_set_ratio;
alias gtk_aspect_frame_set_xalign = c_gtk_aspect_frame_set_xalign;
alias gtk_aspect_frame_set_yalign = c_gtk_aspect_frame_set_yalign;

// Assistant
alias gtk_assistant_get_type = c_gtk_assistant_get_type;
alias gtk_assistant_new = c_gtk_assistant_new;
alias gtk_assistant_add_action_widget = c_gtk_assistant_add_action_widget;
alias gtk_assistant_append_page = c_gtk_assistant_append_page;
alias gtk_assistant_commit = c_gtk_assistant_commit;
alias gtk_assistant_get_current_page = c_gtk_assistant_get_current_page;
alias gtk_assistant_get_n_pages = c_gtk_assistant_get_n_pages;
alias gtk_assistant_get_nth_page = c_gtk_assistant_get_nth_page;
alias gtk_assistant_get_page = c_gtk_assistant_get_page;
alias gtk_assistant_get_page_complete = c_gtk_assistant_get_page_complete;
alias gtk_assistant_get_page_title = c_gtk_assistant_get_page_title;
alias gtk_assistant_get_page_type = c_gtk_assistant_get_page_type;
alias gtk_assistant_get_pages = c_gtk_assistant_get_pages;
alias gtk_assistant_insert_page = c_gtk_assistant_insert_page;
alias gtk_assistant_next_page = c_gtk_assistant_next_page;
alias gtk_assistant_prepend_page = c_gtk_assistant_prepend_page;
alias gtk_assistant_previous_page = c_gtk_assistant_previous_page;
alias gtk_assistant_remove_action_widget = c_gtk_assistant_remove_action_widget;
alias gtk_assistant_remove_page = c_gtk_assistant_remove_page;
alias gtk_assistant_set_current_page = c_gtk_assistant_set_current_page;
alias gtk_assistant_set_forward_page_func = c_gtk_assistant_set_forward_page_func;
alias gtk_assistant_set_page_complete = c_gtk_assistant_set_page_complete;
alias gtk_assistant_set_page_title = c_gtk_assistant_set_page_title;
alias gtk_assistant_set_page_type = c_gtk_assistant_set_page_type;
alias gtk_assistant_update_buttons_state = c_gtk_assistant_update_buttons_state;

// AssistantPage
alias gtk_assistant_page_get_type = c_gtk_assistant_page_get_type;
alias gtk_assistant_page_get_child = c_gtk_assistant_page_get_child;

// BinLayout
alias gtk_bin_layout_get_type = c_gtk_bin_layout_get_type;
alias gtk_bin_layout_new = c_gtk_bin_layout_new;

// Bitset
alias gtk_bitset_get_type = c_gtk_bitset_get_type;
alias gtk_bitset_new_empty = c_gtk_bitset_new_empty;
alias gtk_bitset_new_range = c_gtk_bitset_new_range;
alias gtk_bitset_add = c_gtk_bitset_add;
alias gtk_bitset_add_range = c_gtk_bitset_add_range;
alias gtk_bitset_add_range_closed = c_gtk_bitset_add_range_closed;
alias gtk_bitset_add_rectangle = c_gtk_bitset_add_rectangle;
alias gtk_bitset_contains = c_gtk_bitset_contains;
alias gtk_bitset_copy = c_gtk_bitset_copy;
alias gtk_bitset_difference = c_gtk_bitset_difference;
alias gtk_bitset_equals = c_gtk_bitset_equals;
alias gtk_bitset_get_maximum = c_gtk_bitset_get_maximum;
alias gtk_bitset_get_minimum = c_gtk_bitset_get_minimum;
alias gtk_bitset_get_nth = c_gtk_bitset_get_nth;
alias gtk_bitset_get_size = c_gtk_bitset_get_size;
alias gtk_bitset_get_size_in_range = c_gtk_bitset_get_size_in_range;
alias gtk_bitset_intersect = c_gtk_bitset_intersect;
alias gtk_bitset_is_empty = c_gtk_bitset_is_empty;
alias gtk_bitset_ref = c_gtk_bitset_ref;
alias gtk_bitset_remove = c_gtk_bitset_remove;
alias gtk_bitset_remove_all = c_gtk_bitset_remove_all;
alias gtk_bitset_remove_range = c_gtk_bitset_remove_range;
alias gtk_bitset_remove_range_closed = c_gtk_bitset_remove_range_closed;
alias gtk_bitset_remove_rectangle = c_gtk_bitset_remove_rectangle;
alias gtk_bitset_shift_left = c_gtk_bitset_shift_left;
alias gtk_bitset_shift_right = c_gtk_bitset_shift_right;
alias gtk_bitset_splice = c_gtk_bitset_splice;
alias gtk_bitset_subtract = c_gtk_bitset_subtract;
alias gtk_bitset_union = c_gtk_bitset_union;
alias gtk_bitset_unref = c_gtk_bitset_unref;

// BitsetIter
alias gtk_bitset_iter_get_type = c_gtk_bitset_iter_get_type;
alias gtk_bitset_iter_get_value = c_gtk_bitset_iter_get_value;
alias gtk_bitset_iter_is_valid = c_gtk_bitset_iter_is_valid;
alias gtk_bitset_iter_next = c_gtk_bitset_iter_next;
alias gtk_bitset_iter_previous = c_gtk_bitset_iter_previous;
alias gtk_bitset_iter_init_at = c_gtk_bitset_iter_init_at;
alias gtk_bitset_iter_init_first = c_gtk_bitset_iter_init_first;
alias gtk_bitset_iter_init_last = c_gtk_bitset_iter_init_last;

// BookmarkList
alias gtk_bookmark_list_get_type = c_gtk_bookmark_list_get_type;
alias gtk_bookmark_list_new = c_gtk_bookmark_list_new;
alias gtk_bookmark_list_get_attributes = c_gtk_bookmark_list_get_attributes;
alias gtk_bookmark_list_get_filename = c_gtk_bookmark_list_get_filename;
alias gtk_bookmark_list_get_io_priority = c_gtk_bookmark_list_get_io_priority;
alias gtk_bookmark_list_is_loading = c_gtk_bookmark_list_is_loading;
alias gtk_bookmark_list_set_attributes = c_gtk_bookmark_list_set_attributes;
alias gtk_bookmark_list_set_io_priority = c_gtk_bookmark_list_set_io_priority;

// BoolFilter
alias gtk_bool_filter_get_type = c_gtk_bool_filter_get_type;
alias gtk_bool_filter_new = c_gtk_bool_filter_new;
alias gtk_bool_filter_get_expression = c_gtk_bool_filter_get_expression;
alias gtk_bool_filter_get_invert = c_gtk_bool_filter_get_invert;
alias gtk_bool_filter_set_expression = c_gtk_bool_filter_set_expression;
alias gtk_bool_filter_set_invert = c_gtk_bool_filter_set_invert;

// Border
alias gtk_border_get_type = c_gtk_border_get_type;
alias gtk_border_new = c_gtk_border_new;
alias gtk_border_copy = c_gtk_border_copy;
alias gtk_border_free = c_gtk_border_free;

// Box
alias gtk_box_get_type = c_gtk_box_get_type;
alias gtk_box_new = c_gtk_box_new;
alias gtk_box_append = c_gtk_box_append;
alias gtk_box_get_baseline_child = c_gtk_box_get_baseline_child;
alias gtk_box_get_baseline_position = c_gtk_box_get_baseline_position;
alias gtk_box_get_homogeneous = c_gtk_box_get_homogeneous;
alias gtk_box_get_spacing = c_gtk_box_get_spacing;
alias gtk_box_insert_child_after = c_gtk_box_insert_child_after;
alias gtk_box_prepend = c_gtk_box_prepend;
alias gtk_box_remove = c_gtk_box_remove;
alias gtk_box_reorder_child_after = c_gtk_box_reorder_child_after;
alias gtk_box_set_baseline_child = c_gtk_box_set_baseline_child;
alias gtk_box_set_baseline_position = c_gtk_box_set_baseline_position;
alias gtk_box_set_homogeneous = c_gtk_box_set_homogeneous;
alias gtk_box_set_spacing = c_gtk_box_set_spacing;

// BoxLayout
alias gtk_box_layout_get_type = c_gtk_box_layout_get_type;
alias gtk_box_layout_new = c_gtk_box_layout_new;
alias gtk_box_layout_get_baseline_child = c_gtk_box_layout_get_baseline_child;
alias gtk_box_layout_get_baseline_position = c_gtk_box_layout_get_baseline_position;
alias gtk_box_layout_get_homogeneous = c_gtk_box_layout_get_homogeneous;
alias gtk_box_layout_get_spacing = c_gtk_box_layout_get_spacing;
alias gtk_box_layout_set_baseline_child = c_gtk_box_layout_set_baseline_child;
alias gtk_box_layout_set_baseline_position = c_gtk_box_layout_set_baseline_position;
alias gtk_box_layout_set_homogeneous = c_gtk_box_layout_set_homogeneous;
alias gtk_box_layout_set_spacing = c_gtk_box_layout_set_spacing;

// Buildable
alias gtk_buildable_get_type = c_gtk_buildable_get_type;
alias gtk_buildable_get_buildable_id = c_gtk_buildable_get_buildable_id;

// BuildableParseContext
alias gtk_buildable_parse_context_get_element = c_gtk_buildable_parse_context_get_element;
alias gtk_buildable_parse_context_get_element_stack = c_gtk_buildable_parse_context_get_element_stack;
alias gtk_buildable_parse_context_get_position = c_gtk_buildable_parse_context_get_position;
alias gtk_buildable_parse_context_pop = c_gtk_buildable_parse_context_pop;
alias gtk_buildable_parse_context_push = c_gtk_buildable_parse_context_push;

// Builder
alias gtk_builder_get_type = c_gtk_builder_get_type;
alias gtk_builder_new = c_gtk_builder_new;
alias gtk_builder_new_from_file = c_gtk_builder_new_from_file;
alias gtk_builder_new_from_resource = c_gtk_builder_new_from_resource;
alias gtk_builder_new_from_string = c_gtk_builder_new_from_string;
alias gtk_builder_add_from_file = c_gtk_builder_add_from_file;
alias gtk_builder_add_from_resource = c_gtk_builder_add_from_resource;
alias gtk_builder_add_from_string = c_gtk_builder_add_from_string;
alias gtk_builder_add_objects_from_file = c_gtk_builder_add_objects_from_file;
alias gtk_builder_add_objects_from_resource = c_gtk_builder_add_objects_from_resource;
alias gtk_builder_add_objects_from_string = c_gtk_builder_add_objects_from_string;
alias gtk_builder_create_closure = c_gtk_builder_create_closure;
alias gtk_builder_expose_object = c_gtk_builder_expose_object;
alias gtk_builder_extend_with_template = c_gtk_builder_extend_with_template;
alias gtk_builder_get_current_object = c_gtk_builder_get_current_object;
alias gtk_builder_get_object = c_gtk_builder_get_object;
alias gtk_builder_get_objects = c_gtk_builder_get_objects;
alias gtk_builder_get_scope = c_gtk_builder_get_scope;
alias gtk_builder_get_translation_domain = c_gtk_builder_get_translation_domain;
alias gtk_builder_get_type_from_name = c_gtk_builder_get_type_from_name;
alias gtk_builder_set_current_object = c_gtk_builder_set_current_object;
alias gtk_builder_set_scope = c_gtk_builder_set_scope;
alias gtk_builder_set_translation_domain = c_gtk_builder_set_translation_domain;
alias gtk_builder_value_from_string = c_gtk_builder_value_from_string;
alias gtk_builder_value_from_string_type = c_gtk_builder_value_from_string_type;

// BuilderCScope
alias gtk_builder_cscope_get_type = c_gtk_builder_cscope_get_type;
alias gtk_builder_cscope_new = c_gtk_builder_cscope_new;
alias gtk_builder_cscope_add_callback_symbol = c_gtk_builder_cscope_add_callback_symbol;
alias gtk_builder_cscope_add_callback_symbols = c_gtk_builder_cscope_add_callback_symbols;
alias gtk_builder_cscope_lookup_callback_symbol = c_gtk_builder_cscope_lookup_callback_symbol;

// BuilderListItemFactory
alias gtk_builder_list_item_factory_get_type = c_gtk_builder_list_item_factory_get_type;
alias gtk_builder_list_item_factory_new_from_bytes = c_gtk_builder_list_item_factory_new_from_bytes;
alias gtk_builder_list_item_factory_new_from_resource = c_gtk_builder_list_item_factory_new_from_resource;
alias gtk_builder_list_item_factory_get_bytes = c_gtk_builder_list_item_factory_get_bytes;
alias gtk_builder_list_item_factory_get_resource = c_gtk_builder_list_item_factory_get_resource;
alias gtk_builder_list_item_factory_get_scope = c_gtk_builder_list_item_factory_get_scope;

// BuilderScope
alias gtk_builder_scope_get_type = c_gtk_builder_scope_get_type;

// Button
alias gtk_button_get_type = c_gtk_button_get_type;
alias gtk_button_new = c_gtk_button_new;
alias gtk_button_new_from_icon_name = c_gtk_button_new_from_icon_name;
alias gtk_button_new_with_label = c_gtk_button_new_with_label;
alias gtk_button_new_with_mnemonic = c_gtk_button_new_with_mnemonic;
alias gtk_button_get_can_shrink = c_gtk_button_get_can_shrink;
alias gtk_button_get_child = c_gtk_button_get_child;
alias gtk_button_get_has_frame = c_gtk_button_get_has_frame;
alias gtk_button_get_icon_name = c_gtk_button_get_icon_name;
alias gtk_button_get_label = c_gtk_button_get_label;
alias gtk_button_get_use_underline = c_gtk_button_get_use_underline;
alias gtk_button_set_can_shrink = c_gtk_button_set_can_shrink;
alias gtk_button_set_child = c_gtk_button_set_child;
alias gtk_button_set_has_frame = c_gtk_button_set_has_frame;
alias gtk_button_set_icon_name = c_gtk_button_set_icon_name;
alias gtk_button_set_label = c_gtk_button_set_label;
alias gtk_button_set_use_underline = c_gtk_button_set_use_underline;

// CClosureExpression
alias gtk_cclosure_expression_get_type = c_gtk_cclosure_expression_get_type;
alias gtk_cclosure_expression_new = c_gtk_cclosure_expression_new;

// Calendar
alias gtk_calendar_get_type = c_gtk_calendar_get_type;
alias gtk_calendar_new = c_gtk_calendar_new;
alias gtk_calendar_clear_marks = c_gtk_calendar_clear_marks;
alias gtk_calendar_get_date = c_gtk_calendar_get_date;
alias gtk_calendar_get_day = c_gtk_calendar_get_day;
alias gtk_calendar_get_day_is_marked = c_gtk_calendar_get_day_is_marked;
alias gtk_calendar_get_month = c_gtk_calendar_get_month;
alias gtk_calendar_get_show_day_names = c_gtk_calendar_get_show_day_names;
alias gtk_calendar_get_show_heading = c_gtk_calendar_get_show_heading;
alias gtk_calendar_get_show_week_numbers = c_gtk_calendar_get_show_week_numbers;
alias gtk_calendar_get_year = c_gtk_calendar_get_year;
alias gtk_calendar_mark_day = c_gtk_calendar_mark_day;
alias gtk_calendar_select_day = c_gtk_calendar_select_day;
alias gtk_calendar_set_day = c_gtk_calendar_set_day;
alias gtk_calendar_set_month = c_gtk_calendar_set_month;
alias gtk_calendar_set_show_day_names = c_gtk_calendar_set_show_day_names;
alias gtk_calendar_set_show_heading = c_gtk_calendar_set_show_heading;
alias gtk_calendar_set_show_week_numbers = c_gtk_calendar_set_show_week_numbers;
alias gtk_calendar_set_year = c_gtk_calendar_set_year;
alias gtk_calendar_unmark_day = c_gtk_calendar_unmark_day;

// CallbackAction
alias gtk_callback_action_get_type = c_gtk_callback_action_get_type;
alias gtk_callback_action_new = c_gtk_callback_action_new;

// CellArea
alias gtk_cell_area_get_type = c_gtk_cell_area_get_type;
alias gtk_cell_area_activate = c_gtk_cell_area_activate;
alias gtk_cell_area_activate_cell = c_gtk_cell_area_activate_cell;
alias gtk_cell_area_add = c_gtk_cell_area_add;
alias gtk_cell_area_add_focus_sibling = c_gtk_cell_area_add_focus_sibling;
alias gtk_cell_area_add_with_properties = c_gtk_cell_area_add_with_properties;
alias gtk_cell_area_apply_attributes = c_gtk_cell_area_apply_attributes;
alias gtk_cell_area_attribute_connect = c_gtk_cell_area_attribute_connect;
alias gtk_cell_area_attribute_disconnect = c_gtk_cell_area_attribute_disconnect;
alias gtk_cell_area_attribute_get_column = c_gtk_cell_area_attribute_get_column;
alias gtk_cell_area_cell_get = c_gtk_cell_area_cell_get;
alias gtk_cell_area_cell_get_property = c_gtk_cell_area_cell_get_property;
alias gtk_cell_area_cell_get_valist = c_gtk_cell_area_cell_get_valist;
alias gtk_cell_area_cell_set = c_gtk_cell_area_cell_set;
alias gtk_cell_area_cell_set_property = c_gtk_cell_area_cell_set_property;
alias gtk_cell_area_cell_set_valist = c_gtk_cell_area_cell_set_valist;
alias gtk_cell_area_copy_context = c_gtk_cell_area_copy_context;
alias gtk_cell_area_create_context = c_gtk_cell_area_create_context;
alias gtk_cell_area_event = c_gtk_cell_area_event;
alias gtk_cell_area_focus = c_gtk_cell_area_focus;
alias gtk_cell_area_foreach = c_gtk_cell_area_foreach;
alias gtk_cell_area_foreach_alloc = c_gtk_cell_area_foreach_alloc;
alias gtk_cell_area_get_cell_allocation = c_gtk_cell_area_get_cell_allocation;
alias gtk_cell_area_get_cell_at_position = c_gtk_cell_area_get_cell_at_position;
alias gtk_cell_area_get_current_path_string = c_gtk_cell_area_get_current_path_string;
alias gtk_cell_area_get_edit_widget = c_gtk_cell_area_get_edit_widget;
alias gtk_cell_area_get_edited_cell = c_gtk_cell_area_get_edited_cell;
alias gtk_cell_area_get_focus_cell = c_gtk_cell_area_get_focus_cell;
alias gtk_cell_area_get_focus_from_sibling = c_gtk_cell_area_get_focus_from_sibling;
alias gtk_cell_area_get_focus_siblings = c_gtk_cell_area_get_focus_siblings;
alias gtk_cell_area_get_preferred_height = c_gtk_cell_area_get_preferred_height;
alias gtk_cell_area_get_preferred_height_for_width = c_gtk_cell_area_get_preferred_height_for_width;
alias gtk_cell_area_get_preferred_width = c_gtk_cell_area_get_preferred_width;
alias gtk_cell_area_get_preferred_width_for_height = c_gtk_cell_area_get_preferred_width_for_height;
alias gtk_cell_area_get_request_mode = c_gtk_cell_area_get_request_mode;
alias gtk_cell_area_has_renderer = c_gtk_cell_area_has_renderer;
alias gtk_cell_area_inner_cell_area = c_gtk_cell_area_inner_cell_area;
alias gtk_cell_area_is_activatable = c_gtk_cell_area_is_activatable;
alias gtk_cell_area_is_focus_sibling = c_gtk_cell_area_is_focus_sibling;
alias gtk_cell_area_remove = c_gtk_cell_area_remove;
alias gtk_cell_area_remove_focus_sibling = c_gtk_cell_area_remove_focus_sibling;
alias gtk_cell_area_request_renderer = c_gtk_cell_area_request_renderer;
alias gtk_cell_area_set_focus_cell = c_gtk_cell_area_set_focus_cell;
alias gtk_cell_area_snapshot = c_gtk_cell_area_snapshot;
alias gtk_cell_area_stop_editing = c_gtk_cell_area_stop_editing;

// CellAreaBox
alias gtk_cell_area_box_get_type = c_gtk_cell_area_box_get_type;
alias gtk_cell_area_box_new = c_gtk_cell_area_box_new;
alias gtk_cell_area_box_get_spacing = c_gtk_cell_area_box_get_spacing;
alias gtk_cell_area_box_pack_end = c_gtk_cell_area_box_pack_end;
alias gtk_cell_area_box_pack_start = c_gtk_cell_area_box_pack_start;
alias gtk_cell_area_box_set_spacing = c_gtk_cell_area_box_set_spacing;

// CellAreaClass
alias gtk_cell_area_class_find_cell_property = c_gtk_cell_area_class_find_cell_property;
alias gtk_cell_area_class_install_cell_property = c_gtk_cell_area_class_install_cell_property;
alias gtk_cell_area_class_list_cell_properties = c_gtk_cell_area_class_list_cell_properties;

// CellAreaContext
alias gtk_cell_area_context_get_type = c_gtk_cell_area_context_get_type;
alias gtk_cell_area_context_allocate = c_gtk_cell_area_context_allocate;
alias gtk_cell_area_context_get_allocation = c_gtk_cell_area_context_get_allocation;
alias gtk_cell_area_context_get_area = c_gtk_cell_area_context_get_area;
alias gtk_cell_area_context_get_preferred_height = c_gtk_cell_area_context_get_preferred_height;
alias gtk_cell_area_context_get_preferred_height_for_width = c_gtk_cell_area_context_get_preferred_height_for_width;
alias gtk_cell_area_context_get_preferred_width = c_gtk_cell_area_context_get_preferred_width;
alias gtk_cell_area_context_get_preferred_width_for_height = c_gtk_cell_area_context_get_preferred_width_for_height;
alias gtk_cell_area_context_push_preferred_height = c_gtk_cell_area_context_push_preferred_height;
alias gtk_cell_area_context_push_preferred_width = c_gtk_cell_area_context_push_preferred_width;
alias gtk_cell_area_context_reset = c_gtk_cell_area_context_reset;

// CellEditable
alias gtk_cell_editable_get_type = c_gtk_cell_editable_get_type;
alias gtk_cell_editable_editing_done = c_gtk_cell_editable_editing_done;
alias gtk_cell_editable_remove_widget = c_gtk_cell_editable_remove_widget;
alias gtk_cell_editable_start_editing = c_gtk_cell_editable_start_editing;

// CellLayout
alias gtk_cell_layout_get_type = c_gtk_cell_layout_get_type;
alias gtk_cell_layout_add_attribute = c_gtk_cell_layout_add_attribute;
alias gtk_cell_layout_clear = c_gtk_cell_layout_clear;
alias gtk_cell_layout_clear_attributes = c_gtk_cell_layout_clear_attributes;
alias gtk_cell_layout_get_area = c_gtk_cell_layout_get_area;
alias gtk_cell_layout_get_cells = c_gtk_cell_layout_get_cells;
alias gtk_cell_layout_pack_end = c_gtk_cell_layout_pack_end;
alias gtk_cell_layout_pack_start = c_gtk_cell_layout_pack_start;
alias gtk_cell_layout_reorder = c_gtk_cell_layout_reorder;
alias gtk_cell_layout_set_attributes = c_gtk_cell_layout_set_attributes;
alias gtk_cell_layout_set_cell_data_func = c_gtk_cell_layout_set_cell_data_func;

// CellRenderer
alias gtk_cell_renderer_get_type = c_gtk_cell_renderer_get_type;
alias gtk_cell_renderer_activate = c_gtk_cell_renderer_activate;
alias gtk_cell_renderer_get_aligned_area = c_gtk_cell_renderer_get_aligned_area;
alias gtk_cell_renderer_get_alignment = c_gtk_cell_renderer_get_alignment;
alias gtk_cell_renderer_get_fixed_size = c_gtk_cell_renderer_get_fixed_size;
alias gtk_cell_renderer_get_is_expanded = c_gtk_cell_renderer_get_is_expanded;
alias gtk_cell_renderer_get_is_expander = c_gtk_cell_renderer_get_is_expander;
alias gtk_cell_renderer_get_padding = c_gtk_cell_renderer_get_padding;
alias gtk_cell_renderer_get_preferred_height = c_gtk_cell_renderer_get_preferred_height;
alias gtk_cell_renderer_get_preferred_height_for_width = c_gtk_cell_renderer_get_preferred_height_for_width;
alias gtk_cell_renderer_get_preferred_size = c_gtk_cell_renderer_get_preferred_size;
alias gtk_cell_renderer_get_preferred_width = c_gtk_cell_renderer_get_preferred_width;
alias gtk_cell_renderer_get_preferred_width_for_height = c_gtk_cell_renderer_get_preferred_width_for_height;
alias gtk_cell_renderer_get_request_mode = c_gtk_cell_renderer_get_request_mode;
alias gtk_cell_renderer_get_sensitive = c_gtk_cell_renderer_get_sensitive;
alias gtk_cell_renderer_get_state = c_gtk_cell_renderer_get_state;
alias gtk_cell_renderer_get_visible = c_gtk_cell_renderer_get_visible;
alias gtk_cell_renderer_is_activatable = c_gtk_cell_renderer_is_activatable;
alias gtk_cell_renderer_set_alignment = c_gtk_cell_renderer_set_alignment;
alias gtk_cell_renderer_set_fixed_size = c_gtk_cell_renderer_set_fixed_size;
alias gtk_cell_renderer_set_is_expanded = c_gtk_cell_renderer_set_is_expanded;
alias gtk_cell_renderer_set_is_expander = c_gtk_cell_renderer_set_is_expander;
alias gtk_cell_renderer_set_padding = c_gtk_cell_renderer_set_padding;
alias gtk_cell_renderer_set_sensitive = c_gtk_cell_renderer_set_sensitive;
alias gtk_cell_renderer_set_visible = c_gtk_cell_renderer_set_visible;
alias gtk_cell_renderer_snapshot = c_gtk_cell_renderer_snapshot;
alias gtk_cell_renderer_start_editing = c_gtk_cell_renderer_start_editing;
alias gtk_cell_renderer_stop_editing = c_gtk_cell_renderer_stop_editing;

// CellRendererAccel
alias gtk_cell_renderer_accel_get_type = c_gtk_cell_renderer_accel_get_type;
alias gtk_cell_renderer_accel_new = c_gtk_cell_renderer_accel_new;

// CellRendererCombo
alias gtk_cell_renderer_combo_get_type = c_gtk_cell_renderer_combo_get_type;
alias gtk_cell_renderer_combo_new = c_gtk_cell_renderer_combo_new;

// CellRendererPixbuf
alias gtk_cell_renderer_pixbuf_get_type = c_gtk_cell_renderer_pixbuf_get_type;
alias gtk_cell_renderer_pixbuf_new = c_gtk_cell_renderer_pixbuf_new;

// CellRendererProgress
alias gtk_cell_renderer_progress_get_type = c_gtk_cell_renderer_progress_get_type;
alias gtk_cell_renderer_progress_new = c_gtk_cell_renderer_progress_new;

// CellRendererSpin
alias gtk_cell_renderer_spin_get_type = c_gtk_cell_renderer_spin_get_type;
alias gtk_cell_renderer_spin_new = c_gtk_cell_renderer_spin_new;

// CellRendererSpinner
alias gtk_cell_renderer_spinner_get_type = c_gtk_cell_renderer_spinner_get_type;
alias gtk_cell_renderer_spinner_new = c_gtk_cell_renderer_spinner_new;

// CellRendererText
alias gtk_cell_renderer_text_get_type = c_gtk_cell_renderer_text_get_type;
alias gtk_cell_renderer_text_new = c_gtk_cell_renderer_text_new;
alias gtk_cell_renderer_text_set_fixed_height_from_font = c_gtk_cell_renderer_text_set_fixed_height_from_font;

// CellRendererToggle
alias gtk_cell_renderer_toggle_get_type = c_gtk_cell_renderer_toggle_get_type;
alias gtk_cell_renderer_toggle_new = c_gtk_cell_renderer_toggle_new;
alias gtk_cell_renderer_toggle_get_activatable = c_gtk_cell_renderer_toggle_get_activatable;
alias gtk_cell_renderer_toggle_get_active = c_gtk_cell_renderer_toggle_get_active;
alias gtk_cell_renderer_toggle_get_radio = c_gtk_cell_renderer_toggle_get_radio;
alias gtk_cell_renderer_toggle_set_activatable = c_gtk_cell_renderer_toggle_set_activatable;
alias gtk_cell_renderer_toggle_set_active = c_gtk_cell_renderer_toggle_set_active;
alias gtk_cell_renderer_toggle_set_radio = c_gtk_cell_renderer_toggle_set_radio;

// CellView
alias gtk_cell_view_get_type = c_gtk_cell_view_get_type;
alias gtk_cell_view_new = c_gtk_cell_view_new;
alias gtk_cell_view_new_with_context = c_gtk_cell_view_new_with_context;
alias gtk_cell_view_new_with_markup = c_gtk_cell_view_new_with_markup;
alias gtk_cell_view_new_with_text = c_gtk_cell_view_new_with_text;
alias gtk_cell_view_new_with_texture = c_gtk_cell_view_new_with_texture;
alias gtk_cell_view_get_displayed_row = c_gtk_cell_view_get_displayed_row;
alias gtk_cell_view_get_draw_sensitive = c_gtk_cell_view_get_draw_sensitive;
alias gtk_cell_view_get_fit_model = c_gtk_cell_view_get_fit_model;
alias gtk_cell_view_get_model = c_gtk_cell_view_get_model;
alias gtk_cell_view_set_displayed_row = c_gtk_cell_view_set_displayed_row;
alias gtk_cell_view_set_draw_sensitive = c_gtk_cell_view_set_draw_sensitive;
alias gtk_cell_view_set_fit_model = c_gtk_cell_view_set_fit_model;
alias gtk_cell_view_set_model = c_gtk_cell_view_set_model;

// CenterBox
alias gtk_center_box_get_type = c_gtk_center_box_get_type;
alias gtk_center_box_new = c_gtk_center_box_new;
alias gtk_center_box_get_baseline_position = c_gtk_center_box_get_baseline_position;
alias gtk_center_box_get_center_widget = c_gtk_center_box_get_center_widget;
alias gtk_center_box_get_end_widget = c_gtk_center_box_get_end_widget;
alias gtk_center_box_get_shrink_center_last = c_gtk_center_box_get_shrink_center_last;
alias gtk_center_box_get_start_widget = c_gtk_center_box_get_start_widget;
alias gtk_center_box_set_baseline_position = c_gtk_center_box_set_baseline_position;
alias gtk_center_box_set_center_widget = c_gtk_center_box_set_center_widget;
alias gtk_center_box_set_end_widget = c_gtk_center_box_set_end_widget;
alias gtk_center_box_set_shrink_center_last = c_gtk_center_box_set_shrink_center_last;
alias gtk_center_box_set_start_widget = c_gtk_center_box_set_start_widget;

// CenterLayout
alias gtk_center_layout_get_type = c_gtk_center_layout_get_type;
alias gtk_center_layout_new = c_gtk_center_layout_new;
alias gtk_center_layout_get_baseline_position = c_gtk_center_layout_get_baseline_position;
alias gtk_center_layout_get_center_widget = c_gtk_center_layout_get_center_widget;
alias gtk_center_layout_get_end_widget = c_gtk_center_layout_get_end_widget;
alias gtk_center_layout_get_orientation = c_gtk_center_layout_get_orientation;
alias gtk_center_layout_get_shrink_center_last = c_gtk_center_layout_get_shrink_center_last;
alias gtk_center_layout_get_start_widget = c_gtk_center_layout_get_start_widget;
alias gtk_center_layout_set_baseline_position = c_gtk_center_layout_set_baseline_position;
alias gtk_center_layout_set_center_widget = c_gtk_center_layout_set_center_widget;
alias gtk_center_layout_set_end_widget = c_gtk_center_layout_set_end_widget;
alias gtk_center_layout_set_orientation = c_gtk_center_layout_set_orientation;
alias gtk_center_layout_set_shrink_center_last = c_gtk_center_layout_set_shrink_center_last;
alias gtk_center_layout_set_start_widget = c_gtk_center_layout_set_start_widget;

// CheckButton
alias gtk_check_button_get_type = c_gtk_check_button_get_type;
alias gtk_check_button_new = c_gtk_check_button_new;
alias gtk_check_button_new_with_label = c_gtk_check_button_new_with_label;
alias gtk_check_button_new_with_mnemonic = c_gtk_check_button_new_with_mnemonic;
alias gtk_check_button_get_active = c_gtk_check_button_get_active;
alias gtk_check_button_get_child = c_gtk_check_button_get_child;
alias gtk_check_button_get_inconsistent = c_gtk_check_button_get_inconsistent;
alias gtk_check_button_get_label = c_gtk_check_button_get_label;
alias gtk_check_button_get_use_underline = c_gtk_check_button_get_use_underline;
alias gtk_check_button_set_active = c_gtk_check_button_set_active;
alias gtk_check_button_set_child = c_gtk_check_button_set_child;
alias gtk_check_button_set_group = c_gtk_check_button_set_group;
alias gtk_check_button_set_inconsistent = c_gtk_check_button_set_inconsistent;
alias gtk_check_button_set_label = c_gtk_check_button_set_label;
alias gtk_check_button_set_use_underline = c_gtk_check_button_set_use_underline;

// ClosureExpression
alias gtk_closure_expression_get_type = c_gtk_closure_expression_get_type;
alias gtk_closure_expression_new = c_gtk_closure_expression_new;

// ColorButton
alias gtk_color_button_get_type = c_gtk_color_button_get_type;
alias gtk_color_button_new = c_gtk_color_button_new;
alias gtk_color_button_new_with_rgba = c_gtk_color_button_new_with_rgba;
alias gtk_color_button_get_modal = c_gtk_color_button_get_modal;
alias gtk_color_button_get_title = c_gtk_color_button_get_title;
alias gtk_color_button_set_modal = c_gtk_color_button_set_modal;
alias gtk_color_button_set_title = c_gtk_color_button_set_title;

// ColorChooser
alias gtk_color_chooser_get_type = c_gtk_color_chooser_get_type;
alias gtk_color_chooser_add_palette = c_gtk_color_chooser_add_palette;
alias gtk_color_chooser_get_rgba = c_gtk_color_chooser_get_rgba;
alias gtk_color_chooser_get_use_alpha = c_gtk_color_chooser_get_use_alpha;
alias gtk_color_chooser_set_rgba = c_gtk_color_chooser_set_rgba;
alias gtk_color_chooser_set_use_alpha = c_gtk_color_chooser_set_use_alpha;

// ColorChooserDialog
alias gtk_color_chooser_dialog_get_type = c_gtk_color_chooser_dialog_get_type;
alias gtk_color_chooser_dialog_new = c_gtk_color_chooser_dialog_new;

// ColorChooserWidget
alias gtk_color_chooser_widget_get_type = c_gtk_color_chooser_widget_get_type;
alias gtk_color_chooser_widget_new = c_gtk_color_chooser_widget_new;

// ColorDialog
alias gtk_color_dialog_get_type = c_gtk_color_dialog_get_type;
alias gtk_color_dialog_new = c_gtk_color_dialog_new;
alias gtk_color_dialog_choose_rgba = c_gtk_color_dialog_choose_rgba;
alias gtk_color_dialog_choose_rgba_finish = c_gtk_color_dialog_choose_rgba_finish;
alias gtk_color_dialog_get_modal = c_gtk_color_dialog_get_modal;
alias gtk_color_dialog_get_title = c_gtk_color_dialog_get_title;
alias gtk_color_dialog_get_with_alpha = c_gtk_color_dialog_get_with_alpha;
alias gtk_color_dialog_set_modal = c_gtk_color_dialog_set_modal;
alias gtk_color_dialog_set_title = c_gtk_color_dialog_set_title;
alias gtk_color_dialog_set_with_alpha = c_gtk_color_dialog_set_with_alpha;

// ColorDialogButton
alias gtk_color_dialog_button_get_type = c_gtk_color_dialog_button_get_type;
alias gtk_color_dialog_button_new = c_gtk_color_dialog_button_new;
alias gtk_color_dialog_button_get_dialog = c_gtk_color_dialog_button_get_dialog;
alias gtk_color_dialog_button_get_rgba = c_gtk_color_dialog_button_get_rgba;
alias gtk_color_dialog_button_set_dialog = c_gtk_color_dialog_button_set_dialog;
alias gtk_color_dialog_button_set_rgba = c_gtk_color_dialog_button_set_rgba;

// ColumnView
alias gtk_column_view_get_type = c_gtk_column_view_get_type;
alias gtk_column_view_new = c_gtk_column_view_new;
alias gtk_column_view_append_column = c_gtk_column_view_append_column;
alias gtk_column_view_get_columns = c_gtk_column_view_get_columns;
alias gtk_column_view_get_enable_rubberband = c_gtk_column_view_get_enable_rubberband;
alias gtk_column_view_get_header_factory = c_gtk_column_view_get_header_factory;
alias gtk_column_view_get_model = c_gtk_column_view_get_model;
alias gtk_column_view_get_reorderable = c_gtk_column_view_get_reorderable;
alias gtk_column_view_get_row_factory = c_gtk_column_view_get_row_factory;
alias gtk_column_view_get_show_column_separators = c_gtk_column_view_get_show_column_separators;
alias gtk_column_view_get_show_row_separators = c_gtk_column_view_get_show_row_separators;
alias gtk_column_view_get_single_click_activate = c_gtk_column_view_get_single_click_activate;
alias gtk_column_view_get_sorter = c_gtk_column_view_get_sorter;
alias gtk_column_view_get_tab_behavior = c_gtk_column_view_get_tab_behavior;
alias gtk_column_view_insert_column = c_gtk_column_view_insert_column;
alias gtk_column_view_remove_column = c_gtk_column_view_remove_column;
alias gtk_column_view_scroll_to = c_gtk_column_view_scroll_to;
alias gtk_column_view_set_enable_rubberband = c_gtk_column_view_set_enable_rubberband;
alias gtk_column_view_set_header_factory = c_gtk_column_view_set_header_factory;
alias gtk_column_view_set_model = c_gtk_column_view_set_model;
alias gtk_column_view_set_reorderable = c_gtk_column_view_set_reorderable;
alias gtk_column_view_set_row_factory = c_gtk_column_view_set_row_factory;
alias gtk_column_view_set_show_column_separators = c_gtk_column_view_set_show_column_separators;
alias gtk_column_view_set_show_row_separators = c_gtk_column_view_set_show_row_separators;
alias gtk_column_view_set_single_click_activate = c_gtk_column_view_set_single_click_activate;
alias gtk_column_view_set_tab_behavior = c_gtk_column_view_set_tab_behavior;
alias gtk_column_view_sort_by_column = c_gtk_column_view_sort_by_column;

// ColumnViewCell
alias gtk_column_view_cell_get_type = c_gtk_column_view_cell_get_type;
alias gtk_column_view_cell_get_child = c_gtk_column_view_cell_get_child;
alias gtk_column_view_cell_get_focusable = c_gtk_column_view_cell_get_focusable;
alias gtk_column_view_cell_get_item = c_gtk_column_view_cell_get_item;
alias gtk_column_view_cell_get_position = c_gtk_column_view_cell_get_position;
alias gtk_column_view_cell_get_selected = c_gtk_column_view_cell_get_selected;
alias gtk_column_view_cell_set_child = c_gtk_column_view_cell_set_child;
alias gtk_column_view_cell_set_focusable = c_gtk_column_view_cell_set_focusable;

// ColumnViewColumn
alias gtk_column_view_column_get_type = c_gtk_column_view_column_get_type;
alias gtk_column_view_column_new = c_gtk_column_view_column_new;
alias gtk_column_view_column_get_column_view = c_gtk_column_view_column_get_column_view;
alias gtk_column_view_column_get_expand = c_gtk_column_view_column_get_expand;
alias gtk_column_view_column_get_factory = c_gtk_column_view_column_get_factory;
alias gtk_column_view_column_get_fixed_width = c_gtk_column_view_column_get_fixed_width;
alias gtk_column_view_column_get_header_menu = c_gtk_column_view_column_get_header_menu;
alias gtk_column_view_column_get_id = c_gtk_column_view_column_get_id;
alias gtk_column_view_column_get_resizable = c_gtk_column_view_column_get_resizable;
alias gtk_column_view_column_get_sorter = c_gtk_column_view_column_get_sorter;
alias gtk_column_view_column_get_title = c_gtk_column_view_column_get_title;
alias gtk_column_view_column_get_visible = c_gtk_column_view_column_get_visible;
alias gtk_column_view_column_set_expand = c_gtk_column_view_column_set_expand;
alias gtk_column_view_column_set_factory = c_gtk_column_view_column_set_factory;
alias gtk_column_view_column_set_fixed_width = c_gtk_column_view_column_set_fixed_width;
alias gtk_column_view_column_set_header_menu = c_gtk_column_view_column_set_header_menu;
alias gtk_column_view_column_set_id = c_gtk_column_view_column_set_id;
alias gtk_column_view_column_set_resizable = c_gtk_column_view_column_set_resizable;
alias gtk_column_view_column_set_sorter = c_gtk_column_view_column_set_sorter;
alias gtk_column_view_column_set_title = c_gtk_column_view_column_set_title;
alias gtk_column_view_column_set_visible = c_gtk_column_view_column_set_visible;

// ColumnViewRow
alias gtk_column_view_row_get_type = c_gtk_column_view_row_get_type;
alias gtk_column_view_row_get_accessible_description = c_gtk_column_view_row_get_accessible_description;
alias gtk_column_view_row_get_accessible_label = c_gtk_column_view_row_get_accessible_label;
alias gtk_column_view_row_get_activatable = c_gtk_column_view_row_get_activatable;
alias gtk_column_view_row_get_focusable = c_gtk_column_view_row_get_focusable;
alias gtk_column_view_row_get_item = c_gtk_column_view_row_get_item;
alias gtk_column_view_row_get_position = c_gtk_column_view_row_get_position;
alias gtk_column_view_row_get_selectable = c_gtk_column_view_row_get_selectable;
alias gtk_column_view_row_get_selected = c_gtk_column_view_row_get_selected;
alias gtk_column_view_row_set_accessible_description = c_gtk_column_view_row_set_accessible_description;
alias gtk_column_view_row_set_accessible_label = c_gtk_column_view_row_set_accessible_label;
alias gtk_column_view_row_set_activatable = c_gtk_column_view_row_set_activatable;
alias gtk_column_view_row_set_focusable = c_gtk_column_view_row_set_focusable;
alias gtk_column_view_row_set_selectable = c_gtk_column_view_row_set_selectable;

// ColumnViewSorter
alias gtk_column_view_sorter_get_type = c_gtk_column_view_sorter_get_type;
alias gtk_column_view_sorter_get_n_sort_columns = c_gtk_column_view_sorter_get_n_sort_columns;
alias gtk_column_view_sorter_get_nth_sort_column = c_gtk_column_view_sorter_get_nth_sort_column;
alias gtk_column_view_sorter_get_primary_sort_column = c_gtk_column_view_sorter_get_primary_sort_column;
alias gtk_column_view_sorter_get_primary_sort_order = c_gtk_column_view_sorter_get_primary_sort_order;

// ComboBox
alias gtk_combo_box_get_type = c_gtk_combo_box_get_type;
alias gtk_combo_box_new = c_gtk_combo_box_new;
alias gtk_combo_box_new_with_entry = c_gtk_combo_box_new_with_entry;
alias gtk_combo_box_new_with_model = c_gtk_combo_box_new_with_model;
alias gtk_combo_box_new_with_model_and_entry = c_gtk_combo_box_new_with_model_and_entry;
alias gtk_combo_box_get_active = c_gtk_combo_box_get_active;
alias gtk_combo_box_get_active_id = c_gtk_combo_box_get_active_id;
alias gtk_combo_box_get_active_iter = c_gtk_combo_box_get_active_iter;
alias gtk_combo_box_get_button_sensitivity = c_gtk_combo_box_get_button_sensitivity;
alias gtk_combo_box_get_child = c_gtk_combo_box_get_child;
alias gtk_combo_box_get_entry_text_column = c_gtk_combo_box_get_entry_text_column;
alias gtk_combo_box_get_has_entry = c_gtk_combo_box_get_has_entry;
alias gtk_combo_box_get_id_column = c_gtk_combo_box_get_id_column;
alias gtk_combo_box_get_model = c_gtk_combo_box_get_model;
alias gtk_combo_box_get_popup_fixed_width = c_gtk_combo_box_get_popup_fixed_width;
alias gtk_combo_box_get_row_separator_func = c_gtk_combo_box_get_row_separator_func;
alias gtk_combo_box_popdown = c_gtk_combo_box_popdown;
alias gtk_combo_box_popup = c_gtk_combo_box_popup;
alias gtk_combo_box_popup_for_device = c_gtk_combo_box_popup_for_device;
alias gtk_combo_box_set_active = c_gtk_combo_box_set_active;
alias gtk_combo_box_set_active_id = c_gtk_combo_box_set_active_id;
alias gtk_combo_box_set_active_iter = c_gtk_combo_box_set_active_iter;
alias gtk_combo_box_set_button_sensitivity = c_gtk_combo_box_set_button_sensitivity;
alias gtk_combo_box_set_child = c_gtk_combo_box_set_child;
alias gtk_combo_box_set_entry_text_column = c_gtk_combo_box_set_entry_text_column;
alias gtk_combo_box_set_id_column = c_gtk_combo_box_set_id_column;
alias gtk_combo_box_set_model = c_gtk_combo_box_set_model;
alias gtk_combo_box_set_popup_fixed_width = c_gtk_combo_box_set_popup_fixed_width;
alias gtk_combo_box_set_row_separator_func = c_gtk_combo_box_set_row_separator_func;

// ComboBoxText
alias gtk_combo_box_text_get_type = c_gtk_combo_box_text_get_type;
alias gtk_combo_box_text_new = c_gtk_combo_box_text_new;
alias gtk_combo_box_text_new_with_entry = c_gtk_combo_box_text_new_with_entry;
alias gtk_combo_box_text_append = c_gtk_combo_box_text_append;
alias gtk_combo_box_text_append_text = c_gtk_combo_box_text_append_text;
alias gtk_combo_box_text_get_active_text = c_gtk_combo_box_text_get_active_text;
alias gtk_combo_box_text_insert = c_gtk_combo_box_text_insert;
alias gtk_combo_box_text_insert_text = c_gtk_combo_box_text_insert_text;
alias gtk_combo_box_text_prepend = c_gtk_combo_box_text_prepend;
alias gtk_combo_box_text_prepend_text = c_gtk_combo_box_text_prepend_text;
alias gtk_combo_box_text_remove = c_gtk_combo_box_text_remove;
alias gtk_combo_box_text_remove_all = c_gtk_combo_box_text_remove_all;

// ConstantExpression
alias gtk_constant_expression_get_type = c_gtk_constant_expression_get_type;
alias gtk_constant_expression_new = c_gtk_constant_expression_new;
alias gtk_constant_expression_new_for_value = c_gtk_constant_expression_new_for_value;
alias gtk_constant_expression_get_value = c_gtk_constant_expression_get_value;

// Constraint
alias gtk_constraint_get_type = c_gtk_constraint_get_type;
alias gtk_constraint_new = c_gtk_constraint_new;
alias gtk_constraint_new_constant = c_gtk_constraint_new_constant;
alias gtk_constraint_get_constant = c_gtk_constraint_get_constant;
alias gtk_constraint_get_multiplier = c_gtk_constraint_get_multiplier;
alias gtk_constraint_get_relation = c_gtk_constraint_get_relation;
alias gtk_constraint_get_source = c_gtk_constraint_get_source;
alias gtk_constraint_get_source_attribute = c_gtk_constraint_get_source_attribute;
alias gtk_constraint_get_strength = c_gtk_constraint_get_strength;
alias gtk_constraint_get_target = c_gtk_constraint_get_target;
alias gtk_constraint_get_target_attribute = c_gtk_constraint_get_target_attribute;
alias gtk_constraint_is_attached = c_gtk_constraint_is_attached;
alias gtk_constraint_is_constant = c_gtk_constraint_is_constant;
alias gtk_constraint_is_required = c_gtk_constraint_is_required;

// ConstraintGuide
alias gtk_constraint_guide_get_type = c_gtk_constraint_guide_get_type;
alias gtk_constraint_guide_new = c_gtk_constraint_guide_new;
alias gtk_constraint_guide_get_max_size = c_gtk_constraint_guide_get_max_size;
alias gtk_constraint_guide_get_min_size = c_gtk_constraint_guide_get_min_size;
alias gtk_constraint_guide_get_name = c_gtk_constraint_guide_get_name;
alias gtk_constraint_guide_get_nat_size = c_gtk_constraint_guide_get_nat_size;
alias gtk_constraint_guide_get_strength = c_gtk_constraint_guide_get_strength;
alias gtk_constraint_guide_set_max_size = c_gtk_constraint_guide_set_max_size;
alias gtk_constraint_guide_set_min_size = c_gtk_constraint_guide_set_min_size;
alias gtk_constraint_guide_set_name = c_gtk_constraint_guide_set_name;
alias gtk_constraint_guide_set_nat_size = c_gtk_constraint_guide_set_nat_size;
alias gtk_constraint_guide_set_strength = c_gtk_constraint_guide_set_strength;

// ConstraintLayout
alias gtk_constraint_layout_get_type = c_gtk_constraint_layout_get_type;
alias gtk_constraint_layout_new = c_gtk_constraint_layout_new;
alias gtk_constraint_layout_add_constraint = c_gtk_constraint_layout_add_constraint;
alias gtk_constraint_layout_add_constraints_from_description = c_gtk_constraint_layout_add_constraints_from_description;
alias gtk_constraint_layout_add_constraints_from_descriptionv = c_gtk_constraint_layout_add_constraints_from_descriptionv;
alias gtk_constraint_layout_add_guide = c_gtk_constraint_layout_add_guide;
alias gtk_constraint_layout_observe_constraints = c_gtk_constraint_layout_observe_constraints;
alias gtk_constraint_layout_observe_guides = c_gtk_constraint_layout_observe_guides;
alias gtk_constraint_layout_remove_all_constraints = c_gtk_constraint_layout_remove_all_constraints;
alias gtk_constraint_layout_remove_constraint = c_gtk_constraint_layout_remove_constraint;
alias gtk_constraint_layout_remove_guide = c_gtk_constraint_layout_remove_guide;

// ConstraintLayoutChild
alias gtk_constraint_layout_child_get_type = c_gtk_constraint_layout_child_get_type;

// ConstraintTarget
alias gtk_constraint_target_get_type = c_gtk_constraint_target_get_type;

// CssProvider
alias gtk_css_provider_get_type = c_gtk_css_provider_get_type;
alias gtk_css_provider_new = c_gtk_css_provider_new;
alias gtk_css_provider_load_from_bytes = c_gtk_css_provider_load_from_bytes;
alias gtk_css_provider_load_from_data = c_gtk_css_provider_load_from_data;
alias gtk_css_provider_load_from_file = c_gtk_css_provider_load_from_file;
alias gtk_css_provider_load_from_path = c_gtk_css_provider_load_from_path;
alias gtk_css_provider_load_from_resource = c_gtk_css_provider_load_from_resource;
alias gtk_css_provider_load_from_string = c_gtk_css_provider_load_from_string;
alias gtk_css_provider_load_named = c_gtk_css_provider_load_named;
alias gtk_css_provider_to_string = c_gtk_css_provider_to_string;

// CssSection
alias gtk_css_section_get_type = c_gtk_css_section_get_type;
alias gtk_css_section_new = c_gtk_css_section_new;
alias gtk_css_section_get_end_location = c_gtk_css_section_get_end_location;
alias gtk_css_section_get_file = c_gtk_css_section_get_file;
alias gtk_css_section_get_parent = c_gtk_css_section_get_parent;
alias gtk_css_section_get_start_location = c_gtk_css_section_get_start_location;
alias gtk_css_section_print = c_gtk_css_section_print;
alias gtk_css_section_ref = c_gtk_css_section_ref;
alias gtk_css_section_to_string = c_gtk_css_section_to_string;
alias gtk_css_section_unref = c_gtk_css_section_unref;

// CustomFilter
alias gtk_custom_filter_get_type = c_gtk_custom_filter_get_type;
alias gtk_custom_filter_new = c_gtk_custom_filter_new;
alias gtk_custom_filter_set_filter_func = c_gtk_custom_filter_set_filter_func;

// CustomLayout
alias gtk_custom_layout_get_type = c_gtk_custom_layout_get_type;
alias gtk_custom_layout_new = c_gtk_custom_layout_new;

// CustomSorter
alias gtk_custom_sorter_get_type = c_gtk_custom_sorter_get_type;
alias gtk_custom_sorter_new = c_gtk_custom_sorter_new;
alias gtk_custom_sorter_set_sort_func = c_gtk_custom_sorter_set_sort_func;

// Dialog
alias gtk_dialog_get_type = c_gtk_dialog_get_type;
alias gtk_dialog_new = c_gtk_dialog_new;
alias gtk_dialog_new_with_buttons = c_gtk_dialog_new_with_buttons;
alias gtk_dialog_add_action_widget = c_gtk_dialog_add_action_widget;
alias gtk_dialog_add_button = c_gtk_dialog_add_button;
alias gtk_dialog_add_buttons = c_gtk_dialog_add_buttons;
alias gtk_dialog_get_content_area = c_gtk_dialog_get_content_area;
alias gtk_dialog_get_header_bar = c_gtk_dialog_get_header_bar;
alias gtk_dialog_get_response_for_widget = c_gtk_dialog_get_response_for_widget;
alias gtk_dialog_get_widget_for_response = c_gtk_dialog_get_widget_for_response;
alias gtk_dialog_response = c_gtk_dialog_response;
alias gtk_dialog_set_default_response = c_gtk_dialog_set_default_response;
alias gtk_dialog_set_response_sensitive = c_gtk_dialog_set_response_sensitive;

// DirectoryList
alias gtk_directory_list_get_type = c_gtk_directory_list_get_type;
alias gtk_directory_list_new = c_gtk_directory_list_new;
alias gtk_directory_list_get_attributes = c_gtk_directory_list_get_attributes;
alias gtk_directory_list_get_error = c_gtk_directory_list_get_error;
alias gtk_directory_list_get_file = c_gtk_directory_list_get_file;
alias gtk_directory_list_get_io_priority = c_gtk_directory_list_get_io_priority;
alias gtk_directory_list_get_monitored = c_gtk_directory_list_get_monitored;
alias gtk_directory_list_is_loading = c_gtk_directory_list_is_loading;
alias gtk_directory_list_set_attributes = c_gtk_directory_list_set_attributes;
alias gtk_directory_list_set_file = c_gtk_directory_list_set_file;
alias gtk_directory_list_set_io_priority = c_gtk_directory_list_set_io_priority;
alias gtk_directory_list_set_monitored = c_gtk_directory_list_set_monitored;

// DragIcon
alias gtk_drag_icon_get_type = c_gtk_drag_icon_get_type;
alias gtk_drag_icon_create_widget_for_value = c_gtk_drag_icon_create_widget_for_value;
alias gtk_drag_icon_get_for_drag = c_gtk_drag_icon_get_for_drag;
alias gtk_drag_icon_set_from_paintable = c_gtk_drag_icon_set_from_paintable;
alias gtk_drag_icon_get_child = c_gtk_drag_icon_get_child;
alias gtk_drag_icon_set_child = c_gtk_drag_icon_set_child;

// DragSource
alias gtk_drag_source_get_type = c_gtk_drag_source_get_type;
alias gtk_drag_source_new = c_gtk_drag_source_new;
alias gtk_drag_source_drag_cancel = c_gtk_drag_source_drag_cancel;
alias gtk_drag_source_get_actions = c_gtk_drag_source_get_actions;
alias gtk_drag_source_get_content = c_gtk_drag_source_get_content;
alias gtk_drag_source_get_drag = c_gtk_drag_source_get_drag;
alias gtk_drag_source_set_actions = c_gtk_drag_source_set_actions;
alias gtk_drag_source_set_content = c_gtk_drag_source_set_content;
alias gtk_drag_source_set_icon = c_gtk_drag_source_set_icon;

// DrawingArea
alias gtk_drawing_area_get_type = c_gtk_drawing_area_get_type;
alias gtk_drawing_area_new = c_gtk_drawing_area_new;
alias gtk_drawing_area_get_content_height = c_gtk_drawing_area_get_content_height;
alias gtk_drawing_area_get_content_width = c_gtk_drawing_area_get_content_width;
alias gtk_drawing_area_set_content_height = c_gtk_drawing_area_set_content_height;
alias gtk_drawing_area_set_content_width = c_gtk_drawing_area_set_content_width;
alias gtk_drawing_area_set_draw_func = c_gtk_drawing_area_set_draw_func;

// DropControllerMotion
alias gtk_drop_controller_motion_get_type = c_gtk_drop_controller_motion_get_type;
alias gtk_drop_controller_motion_new = c_gtk_drop_controller_motion_new;
alias gtk_drop_controller_motion_contains_pointer = c_gtk_drop_controller_motion_contains_pointer;
alias gtk_drop_controller_motion_get_drop = c_gtk_drop_controller_motion_get_drop;
alias gtk_drop_controller_motion_is_pointer = c_gtk_drop_controller_motion_is_pointer;

// DropDown
alias gtk_drop_down_get_type = c_gtk_drop_down_get_type;
alias gtk_drop_down_new = c_gtk_drop_down_new;
alias gtk_drop_down_new_from_strings = c_gtk_drop_down_new_from_strings;
alias gtk_drop_down_get_enable_search = c_gtk_drop_down_get_enable_search;
alias gtk_drop_down_get_expression = c_gtk_drop_down_get_expression;
alias gtk_drop_down_get_factory = c_gtk_drop_down_get_factory;
alias gtk_drop_down_get_header_factory = c_gtk_drop_down_get_header_factory;
alias gtk_drop_down_get_list_factory = c_gtk_drop_down_get_list_factory;
alias gtk_drop_down_get_model = c_gtk_drop_down_get_model;
alias gtk_drop_down_get_search_match_mode = c_gtk_drop_down_get_search_match_mode;
alias gtk_drop_down_get_selected = c_gtk_drop_down_get_selected;
alias gtk_drop_down_get_selected_item = c_gtk_drop_down_get_selected_item;
alias gtk_drop_down_get_show_arrow = c_gtk_drop_down_get_show_arrow;
alias gtk_drop_down_set_enable_search = c_gtk_drop_down_set_enable_search;
alias gtk_drop_down_set_expression = c_gtk_drop_down_set_expression;
alias gtk_drop_down_set_factory = c_gtk_drop_down_set_factory;
alias gtk_drop_down_set_header_factory = c_gtk_drop_down_set_header_factory;
alias gtk_drop_down_set_list_factory = c_gtk_drop_down_set_list_factory;
alias gtk_drop_down_set_model = c_gtk_drop_down_set_model;
alias gtk_drop_down_set_search_match_mode = c_gtk_drop_down_set_search_match_mode;
alias gtk_drop_down_set_selected = c_gtk_drop_down_set_selected;
alias gtk_drop_down_set_show_arrow = c_gtk_drop_down_set_show_arrow;

// DropTarget
alias gtk_drop_target_get_type = c_gtk_drop_target_get_type;
alias gtk_drop_target_new = c_gtk_drop_target_new;
alias gtk_drop_target_get_actions = c_gtk_drop_target_get_actions;
alias gtk_drop_target_get_current_drop = c_gtk_drop_target_get_current_drop;
alias gtk_drop_target_get_drop = c_gtk_drop_target_get_drop;
alias gtk_drop_target_get_formats = c_gtk_drop_target_get_formats;
alias gtk_drop_target_get_gtypes = c_gtk_drop_target_get_gtypes;
alias gtk_drop_target_get_preload = c_gtk_drop_target_get_preload;
alias gtk_drop_target_get_value = c_gtk_drop_target_get_value;
alias gtk_drop_target_reject = c_gtk_drop_target_reject;
alias gtk_drop_target_set_actions = c_gtk_drop_target_set_actions;
alias gtk_drop_target_set_gtypes = c_gtk_drop_target_set_gtypes;
alias gtk_drop_target_set_preload = c_gtk_drop_target_set_preload;

// DropTargetAsync
alias gtk_drop_target_async_get_type = c_gtk_drop_target_async_get_type;
alias gtk_drop_target_async_new = c_gtk_drop_target_async_new;
alias gtk_drop_target_async_get_actions = c_gtk_drop_target_async_get_actions;
alias gtk_drop_target_async_get_formats = c_gtk_drop_target_async_get_formats;
alias gtk_drop_target_async_reject_drop = c_gtk_drop_target_async_reject_drop;
alias gtk_drop_target_async_set_actions = c_gtk_drop_target_async_set_actions;
alias gtk_drop_target_async_set_formats = c_gtk_drop_target_async_set_formats;

// Editable
alias gtk_editable_get_type = c_gtk_editable_get_type;
alias gtk_editable_delegate_get_property = c_gtk_editable_delegate_get_property;
alias gtk_editable_delegate_set_property = c_gtk_editable_delegate_set_property;
alias gtk_editable_install_properties = c_gtk_editable_install_properties;
alias gtk_editable_delegate_get_accessible_platform_state = c_gtk_editable_delegate_get_accessible_platform_state;
alias gtk_editable_delete_selection = c_gtk_editable_delete_selection;
alias gtk_editable_delete_text = c_gtk_editable_delete_text;
alias gtk_editable_finish_delegate = c_gtk_editable_finish_delegate;
alias gtk_editable_get_alignment = c_gtk_editable_get_alignment;
alias gtk_editable_get_chars = c_gtk_editable_get_chars;
alias gtk_editable_get_delegate = c_gtk_editable_get_delegate;
alias gtk_editable_get_editable = c_gtk_editable_get_editable;
alias gtk_editable_get_enable_undo = c_gtk_editable_get_enable_undo;
alias gtk_editable_get_max_width_chars = c_gtk_editable_get_max_width_chars;
alias gtk_editable_get_position = c_gtk_editable_get_position;
alias gtk_editable_get_selection_bounds = c_gtk_editable_get_selection_bounds;
alias gtk_editable_get_text = c_gtk_editable_get_text;
alias gtk_editable_get_width_chars = c_gtk_editable_get_width_chars;
alias gtk_editable_init_delegate = c_gtk_editable_init_delegate;
alias gtk_editable_insert_text = c_gtk_editable_insert_text;
alias gtk_editable_select_region = c_gtk_editable_select_region;
alias gtk_editable_set_alignment = c_gtk_editable_set_alignment;
alias gtk_editable_set_editable = c_gtk_editable_set_editable;
alias gtk_editable_set_enable_undo = c_gtk_editable_set_enable_undo;
alias gtk_editable_set_max_width_chars = c_gtk_editable_set_max_width_chars;
alias gtk_editable_set_position = c_gtk_editable_set_position;
alias gtk_editable_set_text = c_gtk_editable_set_text;
alias gtk_editable_set_width_chars = c_gtk_editable_set_width_chars;

// EditableLabel
alias gtk_editable_label_get_type = c_gtk_editable_label_get_type;
alias gtk_editable_label_new = c_gtk_editable_label_new;
alias gtk_editable_label_get_editing = c_gtk_editable_label_get_editing;
alias gtk_editable_label_start_editing = c_gtk_editable_label_start_editing;
alias gtk_editable_label_stop_editing = c_gtk_editable_label_stop_editing;

// EmojiChooser
alias gtk_emoji_chooser_get_type = c_gtk_emoji_chooser_get_type;
alias gtk_emoji_chooser_new = c_gtk_emoji_chooser_new;

// Entry
alias gtk_entry_get_type = c_gtk_entry_get_type;
alias gtk_entry_new = c_gtk_entry_new;
alias gtk_entry_new_with_buffer = c_gtk_entry_new_with_buffer;
alias gtk_entry_get_activates_default = c_gtk_entry_get_activates_default;
alias gtk_entry_get_alignment = c_gtk_entry_get_alignment;
alias gtk_entry_get_attributes = c_gtk_entry_get_attributes;
alias gtk_entry_get_buffer = c_gtk_entry_get_buffer;
alias gtk_entry_get_completion = c_gtk_entry_get_completion;
alias gtk_entry_get_current_icon_drag_source = c_gtk_entry_get_current_icon_drag_source;
alias gtk_entry_get_extra_menu = c_gtk_entry_get_extra_menu;
alias gtk_entry_get_has_frame = c_gtk_entry_get_has_frame;
alias gtk_entry_get_icon_activatable = c_gtk_entry_get_icon_activatable;
alias gtk_entry_get_icon_area = c_gtk_entry_get_icon_area;
alias gtk_entry_get_icon_at_pos = c_gtk_entry_get_icon_at_pos;
alias gtk_entry_get_icon_gicon = c_gtk_entry_get_icon_gicon;
alias gtk_entry_get_icon_name = c_gtk_entry_get_icon_name;
alias gtk_entry_get_icon_paintable = c_gtk_entry_get_icon_paintable;
alias gtk_entry_get_icon_sensitive = c_gtk_entry_get_icon_sensitive;
alias gtk_entry_get_icon_storage_type = c_gtk_entry_get_icon_storage_type;
alias gtk_entry_get_icon_tooltip_markup = c_gtk_entry_get_icon_tooltip_markup;
alias gtk_entry_get_icon_tooltip_text = c_gtk_entry_get_icon_tooltip_text;
alias gtk_entry_get_input_hints = c_gtk_entry_get_input_hints;
alias gtk_entry_get_input_purpose = c_gtk_entry_get_input_purpose;
alias gtk_entry_get_invisible_char = c_gtk_entry_get_invisible_char;
alias gtk_entry_get_max_length = c_gtk_entry_get_max_length;
alias gtk_entry_get_overwrite_mode = c_gtk_entry_get_overwrite_mode;
alias gtk_entry_get_placeholder_text = c_gtk_entry_get_placeholder_text;
alias gtk_entry_get_progress_fraction = c_gtk_entry_get_progress_fraction;
alias gtk_entry_get_progress_pulse_step = c_gtk_entry_get_progress_pulse_step;
alias gtk_entry_get_tabs = c_gtk_entry_get_tabs;
alias gtk_entry_get_text_length = c_gtk_entry_get_text_length;
alias gtk_entry_get_visibility = c_gtk_entry_get_visibility;
alias gtk_entry_grab_focus_without_selecting = c_gtk_entry_grab_focus_without_selecting;
alias gtk_entry_progress_pulse = c_gtk_entry_progress_pulse;
alias gtk_entry_reset_im_context = c_gtk_entry_reset_im_context;
alias gtk_entry_set_activates_default = c_gtk_entry_set_activates_default;
alias gtk_entry_set_alignment = c_gtk_entry_set_alignment;
alias gtk_entry_set_attributes = c_gtk_entry_set_attributes;
alias gtk_entry_set_buffer = c_gtk_entry_set_buffer;
alias gtk_entry_set_completion = c_gtk_entry_set_completion;
alias gtk_entry_set_extra_menu = c_gtk_entry_set_extra_menu;
alias gtk_entry_set_has_frame = c_gtk_entry_set_has_frame;
alias gtk_entry_set_icon_activatable = c_gtk_entry_set_icon_activatable;
alias gtk_entry_set_icon_drag_source = c_gtk_entry_set_icon_drag_source;
alias gtk_entry_set_icon_from_gicon = c_gtk_entry_set_icon_from_gicon;
alias gtk_entry_set_icon_from_icon_name = c_gtk_entry_set_icon_from_icon_name;
alias gtk_entry_set_icon_from_paintable = c_gtk_entry_set_icon_from_paintable;
alias gtk_entry_set_icon_sensitive = c_gtk_entry_set_icon_sensitive;
alias gtk_entry_set_icon_tooltip_markup = c_gtk_entry_set_icon_tooltip_markup;
alias gtk_entry_set_icon_tooltip_text = c_gtk_entry_set_icon_tooltip_text;
alias gtk_entry_set_input_hints = c_gtk_entry_set_input_hints;
alias gtk_entry_set_input_purpose = c_gtk_entry_set_input_purpose;
alias gtk_entry_set_invisible_char = c_gtk_entry_set_invisible_char;
alias gtk_entry_set_max_length = c_gtk_entry_set_max_length;
alias gtk_entry_set_overwrite_mode = c_gtk_entry_set_overwrite_mode;
alias gtk_entry_set_placeholder_text = c_gtk_entry_set_placeholder_text;
alias gtk_entry_set_progress_fraction = c_gtk_entry_set_progress_fraction;
alias gtk_entry_set_progress_pulse_step = c_gtk_entry_set_progress_pulse_step;
alias gtk_entry_set_tabs = c_gtk_entry_set_tabs;
alias gtk_entry_set_visibility = c_gtk_entry_set_visibility;
alias gtk_entry_unset_invisible_char = c_gtk_entry_unset_invisible_char;

// EntryBuffer
alias gtk_entry_buffer_get_type = c_gtk_entry_buffer_get_type;
alias gtk_entry_buffer_new = c_gtk_entry_buffer_new;
alias gtk_entry_buffer_delete_text = c_gtk_entry_buffer_delete_text;
alias gtk_entry_buffer_emit_deleted_text = c_gtk_entry_buffer_emit_deleted_text;
alias gtk_entry_buffer_emit_inserted_text = c_gtk_entry_buffer_emit_inserted_text;
alias gtk_entry_buffer_get_bytes = c_gtk_entry_buffer_get_bytes;
alias gtk_entry_buffer_get_length = c_gtk_entry_buffer_get_length;
alias gtk_entry_buffer_get_max_length = c_gtk_entry_buffer_get_max_length;
alias gtk_entry_buffer_get_text = c_gtk_entry_buffer_get_text;
alias gtk_entry_buffer_insert_text = c_gtk_entry_buffer_insert_text;
alias gtk_entry_buffer_set_max_length = c_gtk_entry_buffer_set_max_length;
alias gtk_entry_buffer_set_text = c_gtk_entry_buffer_set_text;

// EntryCompletion
alias gtk_entry_completion_get_type = c_gtk_entry_completion_get_type;
alias gtk_entry_completion_new = c_gtk_entry_completion_new;
alias gtk_entry_completion_new_with_area = c_gtk_entry_completion_new_with_area;
alias gtk_entry_completion_complete = c_gtk_entry_completion_complete;
alias gtk_entry_completion_compute_prefix = c_gtk_entry_completion_compute_prefix;
alias gtk_entry_completion_get_completion_prefix = c_gtk_entry_completion_get_completion_prefix;
alias gtk_entry_completion_get_entry = c_gtk_entry_completion_get_entry;
alias gtk_entry_completion_get_inline_completion = c_gtk_entry_completion_get_inline_completion;
alias gtk_entry_completion_get_inline_selection = c_gtk_entry_completion_get_inline_selection;
alias gtk_entry_completion_get_minimum_key_length = c_gtk_entry_completion_get_minimum_key_length;
alias gtk_entry_completion_get_model = c_gtk_entry_completion_get_model;
alias gtk_entry_completion_get_popup_completion = c_gtk_entry_completion_get_popup_completion;
alias gtk_entry_completion_get_popup_set_width = c_gtk_entry_completion_get_popup_set_width;
alias gtk_entry_completion_get_popup_single_match = c_gtk_entry_completion_get_popup_single_match;
alias gtk_entry_completion_get_text_column = c_gtk_entry_completion_get_text_column;
alias gtk_entry_completion_insert_prefix = c_gtk_entry_completion_insert_prefix;
alias gtk_entry_completion_set_inline_completion = c_gtk_entry_completion_set_inline_completion;
alias gtk_entry_completion_set_inline_selection = c_gtk_entry_completion_set_inline_selection;
alias gtk_entry_completion_set_match_func = c_gtk_entry_completion_set_match_func;
alias gtk_entry_completion_set_minimum_key_length = c_gtk_entry_completion_set_minimum_key_length;
alias gtk_entry_completion_set_model = c_gtk_entry_completion_set_model;
alias gtk_entry_completion_set_popup_completion = c_gtk_entry_completion_set_popup_completion;
alias gtk_entry_completion_set_popup_set_width = c_gtk_entry_completion_set_popup_set_width;
alias gtk_entry_completion_set_popup_single_match = c_gtk_entry_completion_set_popup_single_match;
alias gtk_entry_completion_set_text_column = c_gtk_entry_completion_set_text_column;

// EventController
alias gtk_event_controller_get_type = c_gtk_event_controller_get_type;
alias gtk_event_controller_get_current_event = c_gtk_event_controller_get_current_event;
alias gtk_event_controller_get_current_event_device = c_gtk_event_controller_get_current_event_device;
alias gtk_event_controller_get_current_event_state = c_gtk_event_controller_get_current_event_state;
alias gtk_event_controller_get_current_event_time = c_gtk_event_controller_get_current_event_time;
alias gtk_event_controller_get_name = c_gtk_event_controller_get_name;
alias gtk_event_controller_get_propagation_limit = c_gtk_event_controller_get_propagation_limit;
alias gtk_event_controller_get_propagation_phase = c_gtk_event_controller_get_propagation_phase;
alias gtk_event_controller_get_widget = c_gtk_event_controller_get_widget;
alias gtk_event_controller_reset = c_gtk_event_controller_reset;
alias gtk_event_controller_set_name = c_gtk_event_controller_set_name;
alias gtk_event_controller_set_propagation_limit = c_gtk_event_controller_set_propagation_limit;
alias gtk_event_controller_set_propagation_phase = c_gtk_event_controller_set_propagation_phase;
alias gtk_event_controller_set_static_name = c_gtk_event_controller_set_static_name;

// EventControllerFocus
alias gtk_event_controller_focus_get_type = c_gtk_event_controller_focus_get_type;
alias gtk_event_controller_focus_new = c_gtk_event_controller_focus_new;
alias gtk_event_controller_focus_contains_focus = c_gtk_event_controller_focus_contains_focus;
alias gtk_event_controller_focus_is_focus = c_gtk_event_controller_focus_is_focus;

// EventControllerKey
alias gtk_event_controller_key_get_type = c_gtk_event_controller_key_get_type;
alias gtk_event_controller_key_new = c_gtk_event_controller_key_new;
alias gtk_event_controller_key_forward = c_gtk_event_controller_key_forward;
alias gtk_event_controller_key_get_group = c_gtk_event_controller_key_get_group;
alias gtk_event_controller_key_get_im_context = c_gtk_event_controller_key_get_im_context;
alias gtk_event_controller_key_set_im_context = c_gtk_event_controller_key_set_im_context;

// EventControllerLegacy
alias gtk_event_controller_legacy_get_type = c_gtk_event_controller_legacy_get_type;
alias gtk_event_controller_legacy_new = c_gtk_event_controller_legacy_new;

// EventControllerMotion
alias gtk_event_controller_motion_get_type = c_gtk_event_controller_motion_get_type;
alias gtk_event_controller_motion_new = c_gtk_event_controller_motion_new;
alias gtk_event_controller_motion_contains_pointer = c_gtk_event_controller_motion_contains_pointer;
alias gtk_event_controller_motion_is_pointer = c_gtk_event_controller_motion_is_pointer;

// EventControllerScroll
alias gtk_event_controller_scroll_get_type = c_gtk_event_controller_scroll_get_type;
alias gtk_event_controller_scroll_new = c_gtk_event_controller_scroll_new;
alias gtk_event_controller_scroll_get_flags = c_gtk_event_controller_scroll_get_flags;
alias gtk_event_controller_scroll_get_unit = c_gtk_event_controller_scroll_get_unit;
alias gtk_event_controller_scroll_set_flags = c_gtk_event_controller_scroll_set_flags;

// EveryFilter
alias gtk_every_filter_get_type = c_gtk_every_filter_get_type;
alias gtk_every_filter_new = c_gtk_every_filter_new;

// Expander
alias gtk_expander_get_type = c_gtk_expander_get_type;
alias gtk_expander_new = c_gtk_expander_new;
alias gtk_expander_new_with_mnemonic = c_gtk_expander_new_with_mnemonic;
alias gtk_expander_get_child = c_gtk_expander_get_child;
alias gtk_expander_get_expanded = c_gtk_expander_get_expanded;
alias gtk_expander_get_label = c_gtk_expander_get_label;
alias gtk_expander_get_label_widget = c_gtk_expander_get_label_widget;
alias gtk_expander_get_resize_toplevel = c_gtk_expander_get_resize_toplevel;
alias gtk_expander_get_use_markup = c_gtk_expander_get_use_markup;
alias gtk_expander_get_use_underline = c_gtk_expander_get_use_underline;
alias gtk_expander_set_child = c_gtk_expander_set_child;
alias gtk_expander_set_expanded = c_gtk_expander_set_expanded;
alias gtk_expander_set_label = c_gtk_expander_set_label;
alias gtk_expander_set_label_widget = c_gtk_expander_set_label_widget;
alias gtk_expander_set_resize_toplevel = c_gtk_expander_set_resize_toplevel;
alias gtk_expander_set_use_markup = c_gtk_expander_set_use_markup;
alias gtk_expander_set_use_underline = c_gtk_expander_set_use_underline;

// Expression
alias gtk_expression_get_type = c_gtk_expression_get_type;
alias gtk_expression_bind = c_gtk_expression_bind;
alias gtk_expression_evaluate = c_gtk_expression_evaluate;
alias gtk_expression_get_value_type = c_gtk_expression_get_value_type;
alias gtk_expression_is_static = c_gtk_expression_is_static;
alias gtk_expression_ref = c_gtk_expression_ref;
alias gtk_expression_unref = c_gtk_expression_unref;
alias gtk_expression_watch = c_gtk_expression_watch;

// ExpressionWatch
alias gtk_expression_watch_get_type = c_gtk_expression_watch_get_type;
alias gtk_expression_watch_evaluate = c_gtk_expression_watch_evaluate;
alias gtk_expression_watch_ref = c_gtk_expression_watch_ref;
alias gtk_expression_watch_unref = c_gtk_expression_watch_unref;
alias gtk_expression_watch_unwatch = c_gtk_expression_watch_unwatch;

// FileChooser
alias gtk_file_chooser_get_type = c_gtk_file_chooser_get_type;
alias gtk_file_chooser_add_choice = c_gtk_file_chooser_add_choice;
alias gtk_file_chooser_add_filter = c_gtk_file_chooser_add_filter;
alias gtk_file_chooser_add_shortcut_folder = c_gtk_file_chooser_add_shortcut_folder;
alias gtk_file_chooser_get_action = c_gtk_file_chooser_get_action;
alias gtk_file_chooser_get_choice = c_gtk_file_chooser_get_choice;
alias gtk_file_chooser_get_create_folders = c_gtk_file_chooser_get_create_folders;
alias gtk_file_chooser_get_current_folder = c_gtk_file_chooser_get_current_folder;
alias gtk_file_chooser_get_current_name = c_gtk_file_chooser_get_current_name;
alias gtk_file_chooser_get_file = c_gtk_file_chooser_get_file;
alias gtk_file_chooser_get_files = c_gtk_file_chooser_get_files;
alias gtk_file_chooser_get_filter = c_gtk_file_chooser_get_filter;
alias gtk_file_chooser_get_filters = c_gtk_file_chooser_get_filters;
alias gtk_file_chooser_get_select_multiple = c_gtk_file_chooser_get_select_multiple;
alias gtk_file_chooser_get_shortcut_folders = c_gtk_file_chooser_get_shortcut_folders;
alias gtk_file_chooser_remove_choice = c_gtk_file_chooser_remove_choice;
alias gtk_file_chooser_remove_filter = c_gtk_file_chooser_remove_filter;
alias gtk_file_chooser_remove_shortcut_folder = c_gtk_file_chooser_remove_shortcut_folder;
alias gtk_file_chooser_set_action = c_gtk_file_chooser_set_action;
alias gtk_file_chooser_set_choice = c_gtk_file_chooser_set_choice;
alias gtk_file_chooser_set_create_folders = c_gtk_file_chooser_set_create_folders;
alias gtk_file_chooser_set_current_folder = c_gtk_file_chooser_set_current_folder;
alias gtk_file_chooser_set_current_name = c_gtk_file_chooser_set_current_name;
alias gtk_file_chooser_set_file = c_gtk_file_chooser_set_file;
alias gtk_file_chooser_set_filter = c_gtk_file_chooser_set_filter;
alias gtk_file_chooser_set_select_multiple = c_gtk_file_chooser_set_select_multiple;

// FileChooserDialog
alias gtk_file_chooser_dialog_get_type = c_gtk_file_chooser_dialog_get_type;
alias gtk_file_chooser_dialog_new = c_gtk_file_chooser_dialog_new;

// FileChooserNative
alias gtk_file_chooser_native_get_type = c_gtk_file_chooser_native_get_type;
alias gtk_file_chooser_native_new = c_gtk_file_chooser_native_new;
alias gtk_file_chooser_native_get_accept_label = c_gtk_file_chooser_native_get_accept_label;
alias gtk_file_chooser_native_get_cancel_label = c_gtk_file_chooser_native_get_cancel_label;
alias gtk_file_chooser_native_set_accept_label = c_gtk_file_chooser_native_set_accept_label;
alias gtk_file_chooser_native_set_cancel_label = c_gtk_file_chooser_native_set_cancel_label;

// FileChooserWidget
alias gtk_file_chooser_widget_get_type = c_gtk_file_chooser_widget_get_type;
alias gtk_file_chooser_widget_new = c_gtk_file_chooser_widget_new;

// FileDialog
alias gtk_file_dialog_get_type = c_gtk_file_dialog_get_type;
alias gtk_file_dialog_new = c_gtk_file_dialog_new;
alias gtk_file_dialog_get_accept_label = c_gtk_file_dialog_get_accept_label;
alias gtk_file_dialog_get_default_filter = c_gtk_file_dialog_get_default_filter;
alias gtk_file_dialog_get_filters = c_gtk_file_dialog_get_filters;
alias gtk_file_dialog_get_initial_file = c_gtk_file_dialog_get_initial_file;
alias gtk_file_dialog_get_initial_folder = c_gtk_file_dialog_get_initial_folder;
alias gtk_file_dialog_get_initial_name = c_gtk_file_dialog_get_initial_name;
alias gtk_file_dialog_get_modal = c_gtk_file_dialog_get_modal;
alias gtk_file_dialog_get_title = c_gtk_file_dialog_get_title;
alias gtk_file_dialog_open = c_gtk_file_dialog_open;
alias gtk_file_dialog_open_finish = c_gtk_file_dialog_open_finish;
alias gtk_file_dialog_open_multiple = c_gtk_file_dialog_open_multiple;
alias gtk_file_dialog_open_multiple_finish = c_gtk_file_dialog_open_multiple_finish;
alias gtk_file_dialog_save = c_gtk_file_dialog_save;
alias gtk_file_dialog_save_finish = c_gtk_file_dialog_save_finish;
alias gtk_file_dialog_select_folder = c_gtk_file_dialog_select_folder;
alias gtk_file_dialog_select_folder_finish = c_gtk_file_dialog_select_folder_finish;
alias gtk_file_dialog_select_multiple_folders = c_gtk_file_dialog_select_multiple_folders;
alias gtk_file_dialog_select_multiple_folders_finish = c_gtk_file_dialog_select_multiple_folders_finish;
alias gtk_file_dialog_set_accept_label = c_gtk_file_dialog_set_accept_label;
alias gtk_file_dialog_set_default_filter = c_gtk_file_dialog_set_default_filter;
alias gtk_file_dialog_set_filters = c_gtk_file_dialog_set_filters;
alias gtk_file_dialog_set_initial_file = c_gtk_file_dialog_set_initial_file;
alias gtk_file_dialog_set_initial_folder = c_gtk_file_dialog_set_initial_folder;
alias gtk_file_dialog_set_initial_name = c_gtk_file_dialog_set_initial_name;
alias gtk_file_dialog_set_modal = c_gtk_file_dialog_set_modal;
alias gtk_file_dialog_set_title = c_gtk_file_dialog_set_title;

// FileFilter
alias gtk_file_filter_get_type = c_gtk_file_filter_get_type;
alias gtk_file_filter_new = c_gtk_file_filter_new;
alias gtk_file_filter_new_from_gvariant = c_gtk_file_filter_new_from_gvariant;
alias gtk_file_filter_add_mime_type = c_gtk_file_filter_add_mime_type;
alias gtk_file_filter_add_pattern = c_gtk_file_filter_add_pattern;
alias gtk_file_filter_add_pixbuf_formats = c_gtk_file_filter_add_pixbuf_formats;
alias gtk_file_filter_add_suffix = c_gtk_file_filter_add_suffix;
alias gtk_file_filter_get_attributes = c_gtk_file_filter_get_attributes;
alias gtk_file_filter_get_name = c_gtk_file_filter_get_name;
alias gtk_file_filter_set_name = c_gtk_file_filter_set_name;
alias gtk_file_filter_to_gvariant = c_gtk_file_filter_to_gvariant;

// FileLauncher
alias gtk_file_launcher_get_type = c_gtk_file_launcher_get_type;
alias gtk_file_launcher_new = c_gtk_file_launcher_new;
alias gtk_file_launcher_get_always_ask = c_gtk_file_launcher_get_always_ask;
alias gtk_file_launcher_get_file = c_gtk_file_launcher_get_file;
alias gtk_file_launcher_get_writable = c_gtk_file_launcher_get_writable;
alias gtk_file_launcher_launch = c_gtk_file_launcher_launch;
alias gtk_file_launcher_launch_finish = c_gtk_file_launcher_launch_finish;
alias gtk_file_launcher_open_containing_folder = c_gtk_file_launcher_open_containing_folder;
alias gtk_file_launcher_open_containing_folder_finish = c_gtk_file_launcher_open_containing_folder_finish;
alias gtk_file_launcher_set_always_ask = c_gtk_file_launcher_set_always_ask;
alias gtk_file_launcher_set_file = c_gtk_file_launcher_set_file;
alias gtk_file_launcher_set_writable = c_gtk_file_launcher_set_writable;

// Filter
alias gtk_filter_get_type = c_gtk_filter_get_type;
alias gtk_filter_changed = c_gtk_filter_changed;
alias gtk_filter_get_strictness = c_gtk_filter_get_strictness;
alias gtk_filter_match = c_gtk_filter_match;

// FilterListModel
alias gtk_filter_list_model_get_type = c_gtk_filter_list_model_get_type;
alias gtk_filter_list_model_new = c_gtk_filter_list_model_new;
alias gtk_filter_list_model_get_filter = c_gtk_filter_list_model_get_filter;
alias gtk_filter_list_model_get_incremental = c_gtk_filter_list_model_get_incremental;
alias gtk_filter_list_model_get_model = c_gtk_filter_list_model_get_model;
alias gtk_filter_list_model_get_pending = c_gtk_filter_list_model_get_pending;
alias gtk_filter_list_model_set_filter = c_gtk_filter_list_model_set_filter;
alias gtk_filter_list_model_set_incremental = c_gtk_filter_list_model_set_incremental;
alias gtk_filter_list_model_set_model = c_gtk_filter_list_model_set_model;

// Fixed
alias gtk_fixed_get_type = c_gtk_fixed_get_type;
alias gtk_fixed_new = c_gtk_fixed_new;
alias gtk_fixed_get_child_position = c_gtk_fixed_get_child_position;
alias gtk_fixed_get_child_transform = c_gtk_fixed_get_child_transform;
alias gtk_fixed_move = c_gtk_fixed_move;
alias gtk_fixed_put = c_gtk_fixed_put;
alias gtk_fixed_remove = c_gtk_fixed_remove;
alias gtk_fixed_set_child_transform = c_gtk_fixed_set_child_transform;

// FixedLayout
alias gtk_fixed_layout_get_type = c_gtk_fixed_layout_get_type;
alias gtk_fixed_layout_new = c_gtk_fixed_layout_new;

// FixedLayoutChild
alias gtk_fixed_layout_child_get_type = c_gtk_fixed_layout_child_get_type;
alias gtk_fixed_layout_child_get_transform = c_gtk_fixed_layout_child_get_transform;
alias gtk_fixed_layout_child_set_transform = c_gtk_fixed_layout_child_set_transform;

// FlattenListModel
alias gtk_flatten_list_model_get_type = c_gtk_flatten_list_model_get_type;
alias gtk_flatten_list_model_new = c_gtk_flatten_list_model_new;
alias gtk_flatten_list_model_get_model = c_gtk_flatten_list_model_get_model;
alias gtk_flatten_list_model_get_model_for_item = c_gtk_flatten_list_model_get_model_for_item;
alias gtk_flatten_list_model_set_model = c_gtk_flatten_list_model_set_model;

// FlowBox
alias gtk_flow_box_get_type = c_gtk_flow_box_get_type;
alias gtk_flow_box_new = c_gtk_flow_box_new;
alias gtk_flow_box_append = c_gtk_flow_box_append;
alias gtk_flow_box_bind_model = c_gtk_flow_box_bind_model;
alias gtk_flow_box_get_activate_on_single_click = c_gtk_flow_box_get_activate_on_single_click;
alias gtk_flow_box_get_child_at_index = c_gtk_flow_box_get_child_at_index;
alias gtk_flow_box_get_child_at_pos = c_gtk_flow_box_get_child_at_pos;
alias gtk_flow_box_get_column_spacing = c_gtk_flow_box_get_column_spacing;
alias gtk_flow_box_get_homogeneous = c_gtk_flow_box_get_homogeneous;
alias gtk_flow_box_get_max_children_per_line = c_gtk_flow_box_get_max_children_per_line;
alias gtk_flow_box_get_min_children_per_line = c_gtk_flow_box_get_min_children_per_line;
alias gtk_flow_box_get_row_spacing = c_gtk_flow_box_get_row_spacing;
alias gtk_flow_box_get_selected_children = c_gtk_flow_box_get_selected_children;
alias gtk_flow_box_get_selection_mode = c_gtk_flow_box_get_selection_mode;
alias gtk_flow_box_insert = c_gtk_flow_box_insert;
alias gtk_flow_box_invalidate_filter = c_gtk_flow_box_invalidate_filter;
alias gtk_flow_box_invalidate_sort = c_gtk_flow_box_invalidate_sort;
alias gtk_flow_box_prepend = c_gtk_flow_box_prepend;
alias gtk_flow_box_remove = c_gtk_flow_box_remove;
alias gtk_flow_box_remove_all = c_gtk_flow_box_remove_all;
alias gtk_flow_box_select_all = c_gtk_flow_box_select_all;
alias gtk_flow_box_select_child = c_gtk_flow_box_select_child;
alias gtk_flow_box_selected_foreach = c_gtk_flow_box_selected_foreach;
alias gtk_flow_box_set_activate_on_single_click = c_gtk_flow_box_set_activate_on_single_click;
alias gtk_flow_box_set_column_spacing = c_gtk_flow_box_set_column_spacing;
alias gtk_flow_box_set_filter_func = c_gtk_flow_box_set_filter_func;
alias gtk_flow_box_set_hadjustment = c_gtk_flow_box_set_hadjustment;
alias gtk_flow_box_set_homogeneous = c_gtk_flow_box_set_homogeneous;
alias gtk_flow_box_set_max_children_per_line = c_gtk_flow_box_set_max_children_per_line;
alias gtk_flow_box_set_min_children_per_line = c_gtk_flow_box_set_min_children_per_line;
alias gtk_flow_box_set_row_spacing = c_gtk_flow_box_set_row_spacing;
alias gtk_flow_box_set_selection_mode = c_gtk_flow_box_set_selection_mode;
alias gtk_flow_box_set_sort_func = c_gtk_flow_box_set_sort_func;
alias gtk_flow_box_set_vadjustment = c_gtk_flow_box_set_vadjustment;
alias gtk_flow_box_unselect_all = c_gtk_flow_box_unselect_all;
alias gtk_flow_box_unselect_child = c_gtk_flow_box_unselect_child;

// FlowBoxChild
alias gtk_flow_box_child_get_type = c_gtk_flow_box_child_get_type;
alias gtk_flow_box_child_new = c_gtk_flow_box_child_new;
alias gtk_flow_box_child_changed = c_gtk_flow_box_child_changed;
alias gtk_flow_box_child_get_child = c_gtk_flow_box_child_get_child;
alias gtk_flow_box_child_get_index = c_gtk_flow_box_child_get_index;
alias gtk_flow_box_child_is_selected = c_gtk_flow_box_child_is_selected;
alias gtk_flow_box_child_set_child = c_gtk_flow_box_child_set_child;

// FontButton
alias gtk_font_button_get_type = c_gtk_font_button_get_type;
alias gtk_font_button_new = c_gtk_font_button_new;
alias gtk_font_button_new_with_font = c_gtk_font_button_new_with_font;
alias gtk_font_button_get_modal = c_gtk_font_button_get_modal;
alias gtk_font_button_get_title = c_gtk_font_button_get_title;
alias gtk_font_button_get_use_font = c_gtk_font_button_get_use_font;
alias gtk_font_button_get_use_size = c_gtk_font_button_get_use_size;
alias gtk_font_button_set_modal = c_gtk_font_button_set_modal;
alias gtk_font_button_set_title = c_gtk_font_button_set_title;
alias gtk_font_button_set_use_font = c_gtk_font_button_set_use_font;
alias gtk_font_button_set_use_size = c_gtk_font_button_set_use_size;

// FontChooser
alias gtk_font_chooser_get_type = c_gtk_font_chooser_get_type;
alias gtk_font_chooser_get_font = c_gtk_font_chooser_get_font;
alias gtk_font_chooser_get_font_desc = c_gtk_font_chooser_get_font_desc;
alias gtk_font_chooser_get_font_face = c_gtk_font_chooser_get_font_face;
alias gtk_font_chooser_get_font_family = c_gtk_font_chooser_get_font_family;
alias gtk_font_chooser_get_font_features = c_gtk_font_chooser_get_font_features;
alias gtk_font_chooser_get_font_map = c_gtk_font_chooser_get_font_map;
alias gtk_font_chooser_get_font_size = c_gtk_font_chooser_get_font_size;
alias gtk_font_chooser_get_language = c_gtk_font_chooser_get_language;
alias gtk_font_chooser_get_level = c_gtk_font_chooser_get_level;
alias gtk_font_chooser_get_preview_text = c_gtk_font_chooser_get_preview_text;
alias gtk_font_chooser_get_show_preview_entry = c_gtk_font_chooser_get_show_preview_entry;
alias gtk_font_chooser_set_filter_func = c_gtk_font_chooser_set_filter_func;
alias gtk_font_chooser_set_font = c_gtk_font_chooser_set_font;
alias gtk_font_chooser_set_font_desc = c_gtk_font_chooser_set_font_desc;
alias gtk_font_chooser_set_font_map = c_gtk_font_chooser_set_font_map;
alias gtk_font_chooser_set_language = c_gtk_font_chooser_set_language;
alias gtk_font_chooser_set_level = c_gtk_font_chooser_set_level;
alias gtk_font_chooser_set_preview_text = c_gtk_font_chooser_set_preview_text;
alias gtk_font_chooser_set_show_preview_entry = c_gtk_font_chooser_set_show_preview_entry;

// FontChooserDialog
alias gtk_font_chooser_dialog_get_type = c_gtk_font_chooser_dialog_get_type;
alias gtk_font_chooser_dialog_new = c_gtk_font_chooser_dialog_new;

// FontChooserWidget
alias gtk_font_chooser_widget_get_type = c_gtk_font_chooser_widget_get_type;
alias gtk_font_chooser_widget_new = c_gtk_font_chooser_widget_new;

// FontDialog
alias gtk_font_dialog_get_type = c_gtk_font_dialog_get_type;
alias gtk_font_dialog_new = c_gtk_font_dialog_new;
alias gtk_font_dialog_choose_face = c_gtk_font_dialog_choose_face;
alias gtk_font_dialog_choose_face_finish = c_gtk_font_dialog_choose_face_finish;
alias gtk_font_dialog_choose_family = c_gtk_font_dialog_choose_family;
alias gtk_font_dialog_choose_family_finish = c_gtk_font_dialog_choose_family_finish;
alias gtk_font_dialog_choose_font = c_gtk_font_dialog_choose_font;
alias gtk_font_dialog_choose_font_and_features = c_gtk_font_dialog_choose_font_and_features;
alias gtk_font_dialog_choose_font_and_features_finish = c_gtk_font_dialog_choose_font_and_features_finish;
alias gtk_font_dialog_choose_font_finish = c_gtk_font_dialog_choose_font_finish;
alias gtk_font_dialog_get_filter = c_gtk_font_dialog_get_filter;
alias gtk_font_dialog_get_font_map = c_gtk_font_dialog_get_font_map;
alias gtk_font_dialog_get_language = c_gtk_font_dialog_get_language;
alias gtk_font_dialog_get_modal = c_gtk_font_dialog_get_modal;
alias gtk_font_dialog_get_title = c_gtk_font_dialog_get_title;
alias gtk_font_dialog_set_filter = c_gtk_font_dialog_set_filter;
alias gtk_font_dialog_set_font_map = c_gtk_font_dialog_set_font_map;
alias gtk_font_dialog_set_language = c_gtk_font_dialog_set_language;
alias gtk_font_dialog_set_modal = c_gtk_font_dialog_set_modal;
alias gtk_font_dialog_set_title = c_gtk_font_dialog_set_title;

// FontDialogButton
alias gtk_font_dialog_button_get_type = c_gtk_font_dialog_button_get_type;
alias gtk_font_dialog_button_new = c_gtk_font_dialog_button_new;
alias gtk_font_dialog_button_get_dialog = c_gtk_font_dialog_button_get_dialog;
alias gtk_font_dialog_button_get_font_desc = c_gtk_font_dialog_button_get_font_desc;
alias gtk_font_dialog_button_get_font_features = c_gtk_font_dialog_button_get_font_features;
alias gtk_font_dialog_button_get_language = c_gtk_font_dialog_button_get_language;
alias gtk_font_dialog_button_get_level = c_gtk_font_dialog_button_get_level;
alias gtk_font_dialog_button_get_use_font = c_gtk_font_dialog_button_get_use_font;
alias gtk_font_dialog_button_get_use_size = c_gtk_font_dialog_button_get_use_size;
alias gtk_font_dialog_button_set_dialog = c_gtk_font_dialog_button_set_dialog;
alias gtk_font_dialog_button_set_font_desc = c_gtk_font_dialog_button_set_font_desc;
alias gtk_font_dialog_button_set_font_features = c_gtk_font_dialog_button_set_font_features;
alias gtk_font_dialog_button_set_language = c_gtk_font_dialog_button_set_language;
alias gtk_font_dialog_button_set_level = c_gtk_font_dialog_button_set_level;
alias gtk_font_dialog_button_set_use_font = c_gtk_font_dialog_button_set_use_font;
alias gtk_font_dialog_button_set_use_size = c_gtk_font_dialog_button_set_use_size;

// Frame
alias gtk_frame_get_type = c_gtk_frame_get_type;
alias gtk_frame_new = c_gtk_frame_new;
alias gtk_frame_get_child = c_gtk_frame_get_child;
alias gtk_frame_get_label = c_gtk_frame_get_label;
alias gtk_frame_get_label_align = c_gtk_frame_get_label_align;
alias gtk_frame_get_label_widget = c_gtk_frame_get_label_widget;
alias gtk_frame_set_child = c_gtk_frame_set_child;
alias gtk_frame_set_label = c_gtk_frame_set_label;
alias gtk_frame_set_label_align = c_gtk_frame_set_label_align;
alias gtk_frame_set_label_widget = c_gtk_frame_set_label_widget;

// GLArea
alias gtk_gl_area_get_type = c_gtk_gl_area_get_type;
alias gtk_gl_area_new = c_gtk_gl_area_new;
alias gtk_gl_area_attach_buffers = c_gtk_gl_area_attach_buffers;
alias gtk_gl_area_get_allowed_apis = c_gtk_gl_area_get_allowed_apis;
alias gtk_gl_area_get_api = c_gtk_gl_area_get_api;
alias gtk_gl_area_get_auto_render = c_gtk_gl_area_get_auto_render;
alias gtk_gl_area_get_context = c_gtk_gl_area_get_context;
alias gtk_gl_area_get_error = c_gtk_gl_area_get_error;
alias gtk_gl_area_get_has_depth_buffer = c_gtk_gl_area_get_has_depth_buffer;
alias gtk_gl_area_get_has_stencil_buffer = c_gtk_gl_area_get_has_stencil_buffer;
alias gtk_gl_area_get_required_version = c_gtk_gl_area_get_required_version;
alias gtk_gl_area_get_use_es = c_gtk_gl_area_get_use_es;
alias gtk_gl_area_make_current = c_gtk_gl_area_make_current;
alias gtk_gl_area_queue_render = c_gtk_gl_area_queue_render;
alias gtk_gl_area_set_allowed_apis = c_gtk_gl_area_set_allowed_apis;
alias gtk_gl_area_set_auto_render = c_gtk_gl_area_set_auto_render;
alias gtk_gl_area_set_error = c_gtk_gl_area_set_error;
alias gtk_gl_area_set_has_depth_buffer = c_gtk_gl_area_set_has_depth_buffer;
alias gtk_gl_area_set_has_stencil_buffer = c_gtk_gl_area_set_has_stencil_buffer;
alias gtk_gl_area_set_required_version = c_gtk_gl_area_set_required_version;
alias gtk_gl_area_set_use_es = c_gtk_gl_area_set_use_es;

// Gesture
alias gtk_gesture_get_type = c_gtk_gesture_get_type;
alias gtk_gesture_get_bounding_box = c_gtk_gesture_get_bounding_box;
alias gtk_gesture_get_bounding_box_center = c_gtk_gesture_get_bounding_box_center;
alias gtk_gesture_get_device = c_gtk_gesture_get_device;
alias gtk_gesture_get_group = c_gtk_gesture_get_group;
alias gtk_gesture_get_last_event = c_gtk_gesture_get_last_event;
alias gtk_gesture_get_last_updated_sequence = c_gtk_gesture_get_last_updated_sequence;
alias gtk_gesture_get_point = c_gtk_gesture_get_point;
alias gtk_gesture_get_sequence_state = c_gtk_gesture_get_sequence_state;
alias gtk_gesture_get_sequences = c_gtk_gesture_get_sequences;
alias gtk_gesture_group = c_gtk_gesture_group;
alias gtk_gesture_handles_sequence = c_gtk_gesture_handles_sequence;
alias gtk_gesture_is_active = c_gtk_gesture_is_active;
alias gtk_gesture_is_grouped_with = c_gtk_gesture_is_grouped_with;
alias gtk_gesture_is_recognized = c_gtk_gesture_is_recognized;
alias gtk_gesture_set_sequence_state = c_gtk_gesture_set_sequence_state;
alias gtk_gesture_set_state = c_gtk_gesture_set_state;
alias gtk_gesture_ungroup = c_gtk_gesture_ungroup;

// GestureClick
alias gtk_gesture_click_get_type = c_gtk_gesture_click_get_type;
alias gtk_gesture_click_new = c_gtk_gesture_click_new;

// GestureDrag
alias gtk_gesture_drag_get_type = c_gtk_gesture_drag_get_type;
alias gtk_gesture_drag_new = c_gtk_gesture_drag_new;
alias gtk_gesture_drag_get_offset = c_gtk_gesture_drag_get_offset;
alias gtk_gesture_drag_get_start_point = c_gtk_gesture_drag_get_start_point;

// GestureLongPress
alias gtk_gesture_long_press_get_type = c_gtk_gesture_long_press_get_type;
alias gtk_gesture_long_press_new = c_gtk_gesture_long_press_new;
alias gtk_gesture_long_press_get_delay_factor = c_gtk_gesture_long_press_get_delay_factor;
alias gtk_gesture_long_press_set_delay_factor = c_gtk_gesture_long_press_set_delay_factor;

// GesturePan
alias gtk_gesture_pan_get_type = c_gtk_gesture_pan_get_type;
alias gtk_gesture_pan_new = c_gtk_gesture_pan_new;
alias gtk_gesture_pan_get_orientation = c_gtk_gesture_pan_get_orientation;
alias gtk_gesture_pan_set_orientation = c_gtk_gesture_pan_set_orientation;

// GestureRotate
alias gtk_gesture_rotate_get_type = c_gtk_gesture_rotate_get_type;
alias gtk_gesture_rotate_new = c_gtk_gesture_rotate_new;
alias gtk_gesture_rotate_get_angle_delta = c_gtk_gesture_rotate_get_angle_delta;

// GestureSingle
alias gtk_gesture_single_get_type = c_gtk_gesture_single_get_type;
alias gtk_gesture_single_get_button = c_gtk_gesture_single_get_button;
alias gtk_gesture_single_get_current_button = c_gtk_gesture_single_get_current_button;
alias gtk_gesture_single_get_current_sequence = c_gtk_gesture_single_get_current_sequence;
alias gtk_gesture_single_get_exclusive = c_gtk_gesture_single_get_exclusive;
alias gtk_gesture_single_get_touch_only = c_gtk_gesture_single_get_touch_only;
alias gtk_gesture_single_set_button = c_gtk_gesture_single_set_button;
alias gtk_gesture_single_set_exclusive = c_gtk_gesture_single_set_exclusive;
alias gtk_gesture_single_set_touch_only = c_gtk_gesture_single_set_touch_only;

// GestureStylus
alias gtk_gesture_stylus_get_type = c_gtk_gesture_stylus_get_type;
alias gtk_gesture_stylus_new = c_gtk_gesture_stylus_new;
alias gtk_gesture_stylus_get_axes = c_gtk_gesture_stylus_get_axes;
alias gtk_gesture_stylus_get_axis = c_gtk_gesture_stylus_get_axis;
alias gtk_gesture_stylus_get_backlog = c_gtk_gesture_stylus_get_backlog;
alias gtk_gesture_stylus_get_device_tool = c_gtk_gesture_stylus_get_device_tool;
alias gtk_gesture_stylus_get_stylus_only = c_gtk_gesture_stylus_get_stylus_only;
alias gtk_gesture_stylus_set_stylus_only = c_gtk_gesture_stylus_set_stylus_only;

// GestureSwipe
alias gtk_gesture_swipe_get_type = c_gtk_gesture_swipe_get_type;
alias gtk_gesture_swipe_new = c_gtk_gesture_swipe_new;
alias gtk_gesture_swipe_get_velocity = c_gtk_gesture_swipe_get_velocity;

// GestureZoom
alias gtk_gesture_zoom_get_type = c_gtk_gesture_zoom_get_type;
alias gtk_gesture_zoom_new = c_gtk_gesture_zoom_new;
alias gtk_gesture_zoom_get_scale_delta = c_gtk_gesture_zoom_get_scale_delta;

// Global
alias gtk_accelerator_get_default_mod_mask = c_gtk_accelerator_get_default_mod_mask;
alias gtk_accelerator_get_label = c_gtk_accelerator_get_label;
alias gtk_accelerator_get_label_with_keycode = c_gtk_accelerator_get_label_with_keycode;
alias gtk_accelerator_name = c_gtk_accelerator_name;
alias gtk_accelerator_name_with_keycode = c_gtk_accelerator_name_with_keycode;
alias gtk_accelerator_parse = c_gtk_accelerator_parse;
alias gtk_accelerator_parse_with_keycode = c_gtk_accelerator_parse_with_keycode;
alias gtk_accelerator_valid = c_gtk_accelerator_valid;
alias gtk_check_version = c_gtk_check_version;
alias gtk_css_parser_error_quark = c_gtk_css_parser_error_quark;
alias gtk_css_parser_warning_quark = c_gtk_css_parser_warning_quark;
alias gtk_disable_setlocale = c_gtk_disable_setlocale;
alias gtk_distribute_natural_allocation = c_gtk_distribute_natural_allocation;
alias gtk_enumerate_printers = c_gtk_enumerate_printers;
alias gtk_get_binary_age = c_gtk_get_binary_age;
alias gtk_get_debug_flags = c_gtk_get_debug_flags;
alias gtk_get_default_language = c_gtk_get_default_language;
alias gtk_get_interface_age = c_gtk_get_interface_age;
alias gtk_get_locale_direction = c_gtk_get_locale_direction;
alias gtk_get_major_version = c_gtk_get_major_version;
alias gtk_get_micro_version = c_gtk_get_micro_version;
alias gtk_get_minor_version = c_gtk_get_minor_version;
alias gtk_hsv_to_rgb = c_gtk_hsv_to_rgb;
alias gtk_init = c_gtk_init;
alias gtk_init_check = c_gtk_init_check;
alias gtk_is_initialized = c_gtk_is_initialized;
alias gtk_param_spec_expression = c_gtk_param_spec_expression;
alias gtk_print_run_page_setup_dialog = c_gtk_print_run_page_setup_dialog;
alias gtk_print_run_page_setup_dialog_async = c_gtk_print_run_page_setup_dialog_async;
alias gtk_render_activity = c_gtk_render_activity;
alias gtk_render_arrow = c_gtk_render_arrow;
alias gtk_render_background = c_gtk_render_background;
alias gtk_render_check = c_gtk_render_check;
alias gtk_render_expander = c_gtk_render_expander;
alias gtk_render_focus = c_gtk_render_focus;
alias gtk_render_frame = c_gtk_render_frame;
alias gtk_render_handle = c_gtk_render_handle;
alias gtk_render_icon = c_gtk_render_icon;
alias gtk_render_layout = c_gtk_render_layout;
alias gtk_render_line = c_gtk_render_line;
alias gtk_render_option = c_gtk_render_option;
alias gtk_rgb_to_hsv = c_gtk_rgb_to_hsv;
alias gtk_set_debug_flags = c_gtk_set_debug_flags;
alias gtk_show_about_dialog = c_gtk_show_about_dialog;
alias gtk_show_uri = c_gtk_show_uri;
alias gtk_show_uri_full = c_gtk_show_uri_full;
alias gtk_show_uri_full_finish = c_gtk_show_uri_full_finish;
alias gtk_test_accessible_assertion_message_role = c_gtk_test_accessible_assertion_message_role;
alias gtk_test_accessible_check_property = c_gtk_test_accessible_check_property;
alias gtk_test_accessible_check_relation = c_gtk_test_accessible_check_relation;
alias gtk_test_accessible_check_state = c_gtk_test_accessible_check_state;
alias gtk_test_accessible_has_property = c_gtk_test_accessible_has_property;
alias gtk_test_accessible_has_relation = c_gtk_test_accessible_has_relation;
alias gtk_test_accessible_has_role = c_gtk_test_accessible_has_role;
alias gtk_test_accessible_has_state = c_gtk_test_accessible_has_state;
alias gtk_test_init = c_gtk_test_init;
alias gtk_test_list_all_types = c_gtk_test_list_all_types;
alias gtk_test_register_all_types = c_gtk_test_register_all_types;
alias gtk_test_widget_wait_for_draw = c_gtk_test_widget_wait_for_draw;
alias gtk_tree_create_row_drag_content = c_gtk_tree_create_row_drag_content;
alias gtk_tree_get_row_drag_data = c_gtk_tree_get_row_drag_data;
alias gtk_value_dup_expression = c_gtk_value_dup_expression;
alias gtk_value_get_expression = c_gtk_value_get_expression;
alias gtk_value_set_expression = c_gtk_value_set_expression;
alias gtk_value_take_expression = c_gtk_value_take_expression;

// GraphicsOffload
alias gtk_graphics_offload_get_type = c_gtk_graphics_offload_get_type;
alias gtk_graphics_offload_new = c_gtk_graphics_offload_new;
alias gtk_graphics_offload_get_child = c_gtk_graphics_offload_get_child;
alias gtk_graphics_offload_get_enabled = c_gtk_graphics_offload_get_enabled;
alias gtk_graphics_offload_set_child = c_gtk_graphics_offload_set_child;
alias gtk_graphics_offload_set_enabled = c_gtk_graphics_offload_set_enabled;

// Grid
alias gtk_grid_get_type = c_gtk_grid_get_type;
alias gtk_grid_new = c_gtk_grid_new;
alias gtk_grid_attach = c_gtk_grid_attach;
alias gtk_grid_attach_next_to = c_gtk_grid_attach_next_to;
alias gtk_grid_get_baseline_row = c_gtk_grid_get_baseline_row;
alias gtk_grid_get_child_at = c_gtk_grid_get_child_at;
alias gtk_grid_get_column_homogeneous = c_gtk_grid_get_column_homogeneous;
alias gtk_grid_get_column_spacing = c_gtk_grid_get_column_spacing;
alias gtk_grid_get_row_baseline_position = c_gtk_grid_get_row_baseline_position;
alias gtk_grid_get_row_homogeneous = c_gtk_grid_get_row_homogeneous;
alias gtk_grid_get_row_spacing = c_gtk_grid_get_row_spacing;
alias gtk_grid_insert_column = c_gtk_grid_insert_column;
alias gtk_grid_insert_next_to = c_gtk_grid_insert_next_to;
alias gtk_grid_insert_row = c_gtk_grid_insert_row;
alias gtk_grid_query_child = c_gtk_grid_query_child;
alias gtk_grid_remove = c_gtk_grid_remove;
alias gtk_grid_remove_column = c_gtk_grid_remove_column;
alias gtk_grid_remove_row = c_gtk_grid_remove_row;
alias gtk_grid_set_baseline_row = c_gtk_grid_set_baseline_row;
alias gtk_grid_set_column_homogeneous = c_gtk_grid_set_column_homogeneous;
alias gtk_grid_set_column_spacing = c_gtk_grid_set_column_spacing;
alias gtk_grid_set_row_baseline_position = c_gtk_grid_set_row_baseline_position;
alias gtk_grid_set_row_homogeneous = c_gtk_grid_set_row_homogeneous;
alias gtk_grid_set_row_spacing = c_gtk_grid_set_row_spacing;

// GridLayout
alias gtk_grid_layout_get_type = c_gtk_grid_layout_get_type;
alias gtk_grid_layout_new = c_gtk_grid_layout_new;
alias gtk_grid_layout_get_baseline_row = c_gtk_grid_layout_get_baseline_row;
alias gtk_grid_layout_get_column_homogeneous = c_gtk_grid_layout_get_column_homogeneous;
alias gtk_grid_layout_get_column_spacing = c_gtk_grid_layout_get_column_spacing;
alias gtk_grid_layout_get_row_baseline_position = c_gtk_grid_layout_get_row_baseline_position;
alias gtk_grid_layout_get_row_homogeneous = c_gtk_grid_layout_get_row_homogeneous;
alias gtk_grid_layout_get_row_spacing = c_gtk_grid_layout_get_row_spacing;
alias gtk_grid_layout_set_baseline_row = c_gtk_grid_layout_set_baseline_row;
alias gtk_grid_layout_set_column_homogeneous = c_gtk_grid_layout_set_column_homogeneous;
alias gtk_grid_layout_set_column_spacing = c_gtk_grid_layout_set_column_spacing;
alias gtk_grid_layout_set_row_baseline_position = c_gtk_grid_layout_set_row_baseline_position;
alias gtk_grid_layout_set_row_homogeneous = c_gtk_grid_layout_set_row_homogeneous;
alias gtk_grid_layout_set_row_spacing = c_gtk_grid_layout_set_row_spacing;

// GridLayoutChild
alias gtk_grid_layout_child_get_type = c_gtk_grid_layout_child_get_type;
alias gtk_grid_layout_child_get_column = c_gtk_grid_layout_child_get_column;
alias gtk_grid_layout_child_get_column_span = c_gtk_grid_layout_child_get_column_span;
alias gtk_grid_layout_child_get_row = c_gtk_grid_layout_child_get_row;
alias gtk_grid_layout_child_get_row_span = c_gtk_grid_layout_child_get_row_span;
alias gtk_grid_layout_child_set_column = c_gtk_grid_layout_child_set_column;
alias gtk_grid_layout_child_set_column_span = c_gtk_grid_layout_child_set_column_span;
alias gtk_grid_layout_child_set_row = c_gtk_grid_layout_child_set_row;
alias gtk_grid_layout_child_set_row_span = c_gtk_grid_layout_child_set_row_span;

// GridView
alias gtk_grid_view_get_type = c_gtk_grid_view_get_type;
alias gtk_grid_view_new = c_gtk_grid_view_new;
alias gtk_grid_view_get_enable_rubberband = c_gtk_grid_view_get_enable_rubberband;
alias gtk_grid_view_get_factory = c_gtk_grid_view_get_factory;
alias gtk_grid_view_get_max_columns = c_gtk_grid_view_get_max_columns;
alias gtk_grid_view_get_min_columns = c_gtk_grid_view_get_min_columns;
alias gtk_grid_view_get_model = c_gtk_grid_view_get_model;
alias gtk_grid_view_get_single_click_activate = c_gtk_grid_view_get_single_click_activate;
alias gtk_grid_view_get_tab_behavior = c_gtk_grid_view_get_tab_behavior;
alias gtk_grid_view_scroll_to = c_gtk_grid_view_scroll_to;
alias gtk_grid_view_set_enable_rubberband = c_gtk_grid_view_set_enable_rubberband;
alias gtk_grid_view_set_factory = c_gtk_grid_view_set_factory;
alias gtk_grid_view_set_max_columns = c_gtk_grid_view_set_max_columns;
alias gtk_grid_view_set_min_columns = c_gtk_grid_view_set_min_columns;
alias gtk_grid_view_set_model = c_gtk_grid_view_set_model;
alias gtk_grid_view_set_single_click_activate = c_gtk_grid_view_set_single_click_activate;
alias gtk_grid_view_set_tab_behavior = c_gtk_grid_view_set_tab_behavior;

// HeaderBar
alias gtk_header_bar_get_type = c_gtk_header_bar_get_type;
alias gtk_header_bar_new = c_gtk_header_bar_new;
alias gtk_header_bar_get_decoration_layout = c_gtk_header_bar_get_decoration_layout;
alias gtk_header_bar_get_show_title_buttons = c_gtk_header_bar_get_show_title_buttons;
alias gtk_header_bar_get_title_widget = c_gtk_header_bar_get_title_widget;
alias gtk_header_bar_pack_end = c_gtk_header_bar_pack_end;
alias gtk_header_bar_pack_start = c_gtk_header_bar_pack_start;
alias gtk_header_bar_remove = c_gtk_header_bar_remove;
alias gtk_header_bar_set_decoration_layout = c_gtk_header_bar_set_decoration_layout;
alias gtk_header_bar_set_show_title_buttons = c_gtk_header_bar_set_show_title_buttons;
alias gtk_header_bar_set_title_widget = c_gtk_header_bar_set_title_widget;

// IMContext
alias gtk_im_context_get_type = c_gtk_im_context_get_type;
alias gtk_im_context_activate_osk = c_gtk_im_context_activate_osk;
alias gtk_im_context_delete_surrounding = c_gtk_im_context_delete_surrounding;
alias gtk_im_context_filter_key = c_gtk_im_context_filter_key;
alias gtk_im_context_filter_keypress = c_gtk_im_context_filter_keypress;
alias gtk_im_context_focus_in = c_gtk_im_context_focus_in;
alias gtk_im_context_focus_out = c_gtk_im_context_focus_out;
alias gtk_im_context_get_preedit_string = c_gtk_im_context_get_preedit_string;
alias gtk_im_context_get_surrounding = c_gtk_im_context_get_surrounding;
alias gtk_im_context_get_surrounding_with_selection = c_gtk_im_context_get_surrounding_with_selection;
alias gtk_im_context_reset = c_gtk_im_context_reset;
alias gtk_im_context_set_client_widget = c_gtk_im_context_set_client_widget;
alias gtk_im_context_set_cursor_location = c_gtk_im_context_set_cursor_location;
alias gtk_im_context_set_surrounding = c_gtk_im_context_set_surrounding;
alias gtk_im_context_set_surrounding_with_selection = c_gtk_im_context_set_surrounding_with_selection;
alias gtk_im_context_set_use_preedit = c_gtk_im_context_set_use_preedit;

// IMContextSimple
alias gtk_im_context_simple_get_type = c_gtk_im_context_simple_get_type;
alias gtk_im_context_simple_new = c_gtk_im_context_simple_new;
alias gtk_im_context_simple_add_compose_file = c_gtk_im_context_simple_add_compose_file;
alias gtk_im_context_simple_add_table = c_gtk_im_context_simple_add_table;

// IMMulticontext
alias gtk_im_multicontext_get_type = c_gtk_im_multicontext_get_type;
alias gtk_im_multicontext_new = c_gtk_im_multicontext_new;
alias gtk_im_multicontext_get_context_id = c_gtk_im_multicontext_get_context_id;
alias gtk_im_multicontext_set_context_id = c_gtk_im_multicontext_set_context_id;

// IconPaintable
alias gtk_icon_paintable_get_type = c_gtk_icon_paintable_get_type;
alias gtk_icon_paintable_new_for_file = c_gtk_icon_paintable_new_for_file;
alias gtk_icon_paintable_get_file = c_gtk_icon_paintable_get_file;
alias gtk_icon_paintable_get_icon_name = c_gtk_icon_paintable_get_icon_name;
alias gtk_icon_paintable_is_symbolic = c_gtk_icon_paintable_is_symbolic;

// IconTheme
alias gtk_icon_theme_get_type = c_gtk_icon_theme_get_type;
alias gtk_icon_theme_new = c_gtk_icon_theme_new;
alias gtk_icon_theme_get_for_display = c_gtk_icon_theme_get_for_display;
alias gtk_icon_theme_add_resource_path = c_gtk_icon_theme_add_resource_path;
alias gtk_icon_theme_add_search_path = c_gtk_icon_theme_add_search_path;
alias gtk_icon_theme_get_display = c_gtk_icon_theme_get_display;
alias gtk_icon_theme_get_icon_names = c_gtk_icon_theme_get_icon_names;
alias gtk_icon_theme_get_icon_sizes = c_gtk_icon_theme_get_icon_sizes;
alias gtk_icon_theme_get_resource_path = c_gtk_icon_theme_get_resource_path;
alias gtk_icon_theme_get_search_path = c_gtk_icon_theme_get_search_path;
alias gtk_icon_theme_get_theme_name = c_gtk_icon_theme_get_theme_name;
alias gtk_icon_theme_has_gicon = c_gtk_icon_theme_has_gicon;
alias gtk_icon_theme_has_icon = c_gtk_icon_theme_has_icon;
alias gtk_icon_theme_lookup_by_gicon = c_gtk_icon_theme_lookup_by_gicon;
alias gtk_icon_theme_lookup_icon = c_gtk_icon_theme_lookup_icon;
alias gtk_icon_theme_set_resource_path = c_gtk_icon_theme_set_resource_path;
alias gtk_icon_theme_set_search_path = c_gtk_icon_theme_set_search_path;
alias gtk_icon_theme_set_theme_name = c_gtk_icon_theme_set_theme_name;

// IconView
alias gtk_icon_view_get_type = c_gtk_icon_view_get_type;
alias gtk_icon_view_new = c_gtk_icon_view_new;
alias gtk_icon_view_new_with_area = c_gtk_icon_view_new_with_area;
alias gtk_icon_view_new_with_model = c_gtk_icon_view_new_with_model;
alias gtk_icon_view_create_drag_icon = c_gtk_icon_view_create_drag_icon;
alias gtk_icon_view_enable_model_drag_dest = c_gtk_icon_view_enable_model_drag_dest;
alias gtk_icon_view_enable_model_drag_source = c_gtk_icon_view_enable_model_drag_source;
alias gtk_icon_view_get_activate_on_single_click = c_gtk_icon_view_get_activate_on_single_click;
alias gtk_icon_view_get_cell_rect = c_gtk_icon_view_get_cell_rect;
alias gtk_icon_view_get_column_spacing = c_gtk_icon_view_get_column_spacing;
alias gtk_icon_view_get_columns = c_gtk_icon_view_get_columns;
alias gtk_icon_view_get_cursor = c_gtk_icon_view_get_cursor;
alias gtk_icon_view_get_dest_item_at_pos = c_gtk_icon_view_get_dest_item_at_pos;
alias gtk_icon_view_get_drag_dest_item = c_gtk_icon_view_get_drag_dest_item;
alias gtk_icon_view_get_item_at_pos = c_gtk_icon_view_get_item_at_pos;
alias gtk_icon_view_get_item_column = c_gtk_icon_view_get_item_column;
alias gtk_icon_view_get_item_orientation = c_gtk_icon_view_get_item_orientation;
alias gtk_icon_view_get_item_padding = c_gtk_icon_view_get_item_padding;
alias gtk_icon_view_get_item_row = c_gtk_icon_view_get_item_row;
alias gtk_icon_view_get_item_width = c_gtk_icon_view_get_item_width;
alias gtk_icon_view_get_margin = c_gtk_icon_view_get_margin;
alias gtk_icon_view_get_markup_column = c_gtk_icon_view_get_markup_column;
alias gtk_icon_view_get_model = c_gtk_icon_view_get_model;
alias gtk_icon_view_get_path_at_pos = c_gtk_icon_view_get_path_at_pos;
alias gtk_icon_view_get_pixbuf_column = c_gtk_icon_view_get_pixbuf_column;
alias gtk_icon_view_get_reorderable = c_gtk_icon_view_get_reorderable;
alias gtk_icon_view_get_row_spacing = c_gtk_icon_view_get_row_spacing;
alias gtk_icon_view_get_selected_items = c_gtk_icon_view_get_selected_items;
alias gtk_icon_view_get_selection_mode = c_gtk_icon_view_get_selection_mode;
alias gtk_icon_view_get_spacing = c_gtk_icon_view_get_spacing;
alias gtk_icon_view_get_text_column = c_gtk_icon_view_get_text_column;
alias gtk_icon_view_get_tooltip_column = c_gtk_icon_view_get_tooltip_column;
alias gtk_icon_view_get_tooltip_context = c_gtk_icon_view_get_tooltip_context;
alias gtk_icon_view_get_visible_range = c_gtk_icon_view_get_visible_range;
alias gtk_icon_view_item_activated = c_gtk_icon_view_item_activated;
alias gtk_icon_view_path_is_selected = c_gtk_icon_view_path_is_selected;
alias gtk_icon_view_scroll_to_path = c_gtk_icon_view_scroll_to_path;
alias gtk_icon_view_select_all = c_gtk_icon_view_select_all;
alias gtk_icon_view_select_path = c_gtk_icon_view_select_path;
alias gtk_icon_view_selected_foreach = c_gtk_icon_view_selected_foreach;
alias gtk_icon_view_set_activate_on_single_click = c_gtk_icon_view_set_activate_on_single_click;
alias gtk_icon_view_set_column_spacing = c_gtk_icon_view_set_column_spacing;
alias gtk_icon_view_set_columns = c_gtk_icon_view_set_columns;
alias gtk_icon_view_set_cursor = c_gtk_icon_view_set_cursor;
alias gtk_icon_view_set_drag_dest_item = c_gtk_icon_view_set_drag_dest_item;
alias gtk_icon_view_set_item_orientation = c_gtk_icon_view_set_item_orientation;
alias gtk_icon_view_set_item_padding = c_gtk_icon_view_set_item_padding;
alias gtk_icon_view_set_item_width = c_gtk_icon_view_set_item_width;
alias gtk_icon_view_set_margin = c_gtk_icon_view_set_margin;
alias gtk_icon_view_set_markup_column = c_gtk_icon_view_set_markup_column;
alias gtk_icon_view_set_model = c_gtk_icon_view_set_model;
alias gtk_icon_view_set_pixbuf_column = c_gtk_icon_view_set_pixbuf_column;
alias gtk_icon_view_set_reorderable = c_gtk_icon_view_set_reorderable;
alias gtk_icon_view_set_row_spacing = c_gtk_icon_view_set_row_spacing;
alias gtk_icon_view_set_selection_mode = c_gtk_icon_view_set_selection_mode;
alias gtk_icon_view_set_spacing = c_gtk_icon_view_set_spacing;
alias gtk_icon_view_set_text_column = c_gtk_icon_view_set_text_column;
alias gtk_icon_view_set_tooltip_cell = c_gtk_icon_view_set_tooltip_cell;
alias gtk_icon_view_set_tooltip_column = c_gtk_icon_view_set_tooltip_column;
alias gtk_icon_view_set_tooltip_item = c_gtk_icon_view_set_tooltip_item;
alias gtk_icon_view_unselect_all = c_gtk_icon_view_unselect_all;
alias gtk_icon_view_unselect_path = c_gtk_icon_view_unselect_path;
alias gtk_icon_view_unset_model_drag_dest = c_gtk_icon_view_unset_model_drag_dest;
alias gtk_icon_view_unset_model_drag_source = c_gtk_icon_view_unset_model_drag_source;

// Image
alias gtk_image_get_type = c_gtk_image_get_type;
alias gtk_image_new = c_gtk_image_new;
alias gtk_image_new_from_file = c_gtk_image_new_from_file;
alias gtk_image_new_from_gicon = c_gtk_image_new_from_gicon;
alias gtk_image_new_from_icon_name = c_gtk_image_new_from_icon_name;
alias gtk_image_new_from_paintable = c_gtk_image_new_from_paintable;
alias gtk_image_new_from_pixbuf = c_gtk_image_new_from_pixbuf;
alias gtk_image_new_from_resource = c_gtk_image_new_from_resource;
alias gtk_image_clear = c_gtk_image_clear;
alias gtk_image_get_gicon = c_gtk_image_get_gicon;
alias gtk_image_get_icon_name = c_gtk_image_get_icon_name;
alias gtk_image_get_icon_size = c_gtk_image_get_icon_size;
alias gtk_image_get_paintable = c_gtk_image_get_paintable;
alias gtk_image_get_pixel_size = c_gtk_image_get_pixel_size;
alias gtk_image_get_storage_type = c_gtk_image_get_storage_type;
alias gtk_image_set_from_file = c_gtk_image_set_from_file;
alias gtk_image_set_from_gicon = c_gtk_image_set_from_gicon;
alias gtk_image_set_from_icon_name = c_gtk_image_set_from_icon_name;
alias gtk_image_set_from_paintable = c_gtk_image_set_from_paintable;
alias gtk_image_set_from_pixbuf = c_gtk_image_set_from_pixbuf;
alias gtk_image_set_from_resource = c_gtk_image_set_from_resource;
alias gtk_image_set_icon_size = c_gtk_image_set_icon_size;
alias gtk_image_set_pixel_size = c_gtk_image_set_pixel_size;

// InfoBar
alias gtk_info_bar_get_type = c_gtk_info_bar_get_type;
alias gtk_info_bar_new = c_gtk_info_bar_new;
alias gtk_info_bar_new_with_buttons = c_gtk_info_bar_new_with_buttons;
alias gtk_info_bar_add_action_widget = c_gtk_info_bar_add_action_widget;
alias gtk_info_bar_add_button = c_gtk_info_bar_add_button;
alias gtk_info_bar_add_buttons = c_gtk_info_bar_add_buttons;
alias gtk_info_bar_add_child = c_gtk_info_bar_add_child;
alias gtk_info_bar_get_message_type = c_gtk_info_bar_get_message_type;
alias gtk_info_bar_get_revealed = c_gtk_info_bar_get_revealed;
alias gtk_info_bar_get_show_close_button = c_gtk_info_bar_get_show_close_button;
alias gtk_info_bar_remove_action_widget = c_gtk_info_bar_remove_action_widget;
alias gtk_info_bar_remove_child = c_gtk_info_bar_remove_child;
alias gtk_info_bar_response = c_gtk_info_bar_response;
alias gtk_info_bar_set_default_response = c_gtk_info_bar_set_default_response;
alias gtk_info_bar_set_message_type = c_gtk_info_bar_set_message_type;
alias gtk_info_bar_set_response_sensitive = c_gtk_info_bar_set_response_sensitive;
alias gtk_info_bar_set_revealed = c_gtk_info_bar_set_revealed;
alias gtk_info_bar_set_show_close_button = c_gtk_info_bar_set_show_close_button;

// Inscription
alias gtk_inscription_get_type = c_gtk_inscription_get_type;
alias gtk_inscription_new = c_gtk_inscription_new;
alias gtk_inscription_get_attributes = c_gtk_inscription_get_attributes;
alias gtk_inscription_get_min_chars = c_gtk_inscription_get_min_chars;
alias gtk_inscription_get_min_lines = c_gtk_inscription_get_min_lines;
alias gtk_inscription_get_nat_chars = c_gtk_inscription_get_nat_chars;
alias gtk_inscription_get_nat_lines = c_gtk_inscription_get_nat_lines;
alias gtk_inscription_get_text = c_gtk_inscription_get_text;
alias gtk_inscription_get_text_overflow = c_gtk_inscription_get_text_overflow;
alias gtk_inscription_get_wrap_mode = c_gtk_inscription_get_wrap_mode;
alias gtk_inscription_get_xalign = c_gtk_inscription_get_xalign;
alias gtk_inscription_get_yalign = c_gtk_inscription_get_yalign;
alias gtk_inscription_set_attributes = c_gtk_inscription_set_attributes;
alias gtk_inscription_set_markup = c_gtk_inscription_set_markup;
alias gtk_inscription_set_min_chars = c_gtk_inscription_set_min_chars;
alias gtk_inscription_set_min_lines = c_gtk_inscription_set_min_lines;
alias gtk_inscription_set_nat_chars = c_gtk_inscription_set_nat_chars;
alias gtk_inscription_set_nat_lines = c_gtk_inscription_set_nat_lines;
alias gtk_inscription_set_text = c_gtk_inscription_set_text;
alias gtk_inscription_set_text_overflow = c_gtk_inscription_set_text_overflow;
alias gtk_inscription_set_wrap_mode = c_gtk_inscription_set_wrap_mode;
alias gtk_inscription_set_xalign = c_gtk_inscription_set_xalign;
alias gtk_inscription_set_yalign = c_gtk_inscription_set_yalign;

// KeyvalTrigger
alias gtk_keyval_trigger_get_type = c_gtk_keyval_trigger_get_type;
alias gtk_keyval_trigger_new = c_gtk_keyval_trigger_new;
alias gtk_keyval_trigger_get_keyval = c_gtk_keyval_trigger_get_keyval;
alias gtk_keyval_trigger_get_modifiers = c_gtk_keyval_trigger_get_modifiers;

// Label
alias gtk_label_get_type = c_gtk_label_get_type;
alias gtk_label_new = c_gtk_label_new;
alias gtk_label_new_with_mnemonic = c_gtk_label_new_with_mnemonic;
alias gtk_label_get_attributes = c_gtk_label_get_attributes;
alias gtk_label_get_current_uri = c_gtk_label_get_current_uri;
alias gtk_label_get_ellipsize = c_gtk_label_get_ellipsize;
alias gtk_label_get_extra_menu = c_gtk_label_get_extra_menu;
alias gtk_label_get_justify = c_gtk_label_get_justify;
alias gtk_label_get_label = c_gtk_label_get_label;
alias gtk_label_get_layout = c_gtk_label_get_layout;
alias gtk_label_get_layout_offsets = c_gtk_label_get_layout_offsets;
alias gtk_label_get_lines = c_gtk_label_get_lines;
alias gtk_label_get_max_width_chars = c_gtk_label_get_max_width_chars;
alias gtk_label_get_mnemonic_keyval = c_gtk_label_get_mnemonic_keyval;
alias gtk_label_get_mnemonic_widget = c_gtk_label_get_mnemonic_widget;
alias gtk_label_get_natural_wrap_mode = c_gtk_label_get_natural_wrap_mode;
alias gtk_label_get_selectable = c_gtk_label_get_selectable;
alias gtk_label_get_selection_bounds = c_gtk_label_get_selection_bounds;
alias gtk_label_get_single_line_mode = c_gtk_label_get_single_line_mode;
alias gtk_label_get_tabs = c_gtk_label_get_tabs;
alias gtk_label_get_text = c_gtk_label_get_text;
alias gtk_label_get_use_markup = c_gtk_label_get_use_markup;
alias gtk_label_get_use_underline = c_gtk_label_get_use_underline;
alias gtk_label_get_width_chars = c_gtk_label_get_width_chars;
alias gtk_label_get_wrap = c_gtk_label_get_wrap;
alias gtk_label_get_wrap_mode = c_gtk_label_get_wrap_mode;
alias gtk_label_get_xalign = c_gtk_label_get_xalign;
alias gtk_label_get_yalign = c_gtk_label_get_yalign;
alias gtk_label_select_region = c_gtk_label_select_region;
alias gtk_label_set_attributes = c_gtk_label_set_attributes;
alias gtk_label_set_ellipsize = c_gtk_label_set_ellipsize;
alias gtk_label_set_extra_menu = c_gtk_label_set_extra_menu;
alias gtk_label_set_justify = c_gtk_label_set_justify;
alias gtk_label_set_label = c_gtk_label_set_label;
alias gtk_label_set_lines = c_gtk_label_set_lines;
alias gtk_label_set_markup = c_gtk_label_set_markup;
alias gtk_label_set_markup_with_mnemonic = c_gtk_label_set_markup_with_mnemonic;
alias gtk_label_set_max_width_chars = c_gtk_label_set_max_width_chars;
alias gtk_label_set_mnemonic_widget = c_gtk_label_set_mnemonic_widget;
alias gtk_label_set_natural_wrap_mode = c_gtk_label_set_natural_wrap_mode;
alias gtk_label_set_selectable = c_gtk_label_set_selectable;
alias gtk_label_set_single_line_mode = c_gtk_label_set_single_line_mode;
alias gtk_label_set_tabs = c_gtk_label_set_tabs;
alias gtk_label_set_text = c_gtk_label_set_text;
alias gtk_label_set_text_with_mnemonic = c_gtk_label_set_text_with_mnemonic;
alias gtk_label_set_use_markup = c_gtk_label_set_use_markup;
alias gtk_label_set_use_underline = c_gtk_label_set_use_underline;
alias gtk_label_set_width_chars = c_gtk_label_set_width_chars;
alias gtk_label_set_wrap = c_gtk_label_set_wrap;
alias gtk_label_set_wrap_mode = c_gtk_label_set_wrap_mode;
alias gtk_label_set_xalign = c_gtk_label_set_xalign;
alias gtk_label_set_yalign = c_gtk_label_set_yalign;

// LayoutChild
alias gtk_layout_child_get_type = c_gtk_layout_child_get_type;
alias gtk_layout_child_get_child_widget = c_gtk_layout_child_get_child_widget;
alias gtk_layout_child_get_layout_manager = c_gtk_layout_child_get_layout_manager;

// LayoutManager
alias gtk_layout_manager_get_type = c_gtk_layout_manager_get_type;
alias gtk_layout_manager_allocate = c_gtk_layout_manager_allocate;
alias gtk_layout_manager_get_layout_child = c_gtk_layout_manager_get_layout_child;
alias gtk_layout_manager_get_request_mode = c_gtk_layout_manager_get_request_mode;
alias gtk_layout_manager_get_widget = c_gtk_layout_manager_get_widget;
alias gtk_layout_manager_layout_changed = c_gtk_layout_manager_layout_changed;
alias gtk_layout_manager_measure = c_gtk_layout_manager_measure;

// LevelBar
alias gtk_level_bar_get_type = c_gtk_level_bar_get_type;
alias gtk_level_bar_new = c_gtk_level_bar_new;
alias gtk_level_bar_new_for_interval = c_gtk_level_bar_new_for_interval;
alias gtk_level_bar_add_offset_value = c_gtk_level_bar_add_offset_value;
alias gtk_level_bar_get_inverted = c_gtk_level_bar_get_inverted;
alias gtk_level_bar_get_max_value = c_gtk_level_bar_get_max_value;
alias gtk_level_bar_get_min_value = c_gtk_level_bar_get_min_value;
alias gtk_level_bar_get_mode = c_gtk_level_bar_get_mode;
alias gtk_level_bar_get_offset_value = c_gtk_level_bar_get_offset_value;
alias gtk_level_bar_get_value = c_gtk_level_bar_get_value;
alias gtk_level_bar_remove_offset_value = c_gtk_level_bar_remove_offset_value;
alias gtk_level_bar_set_inverted = c_gtk_level_bar_set_inverted;
alias gtk_level_bar_set_max_value = c_gtk_level_bar_set_max_value;
alias gtk_level_bar_set_min_value = c_gtk_level_bar_set_min_value;
alias gtk_level_bar_set_mode = c_gtk_level_bar_set_mode;
alias gtk_level_bar_set_value = c_gtk_level_bar_set_value;

// LinkButton
alias gtk_link_button_get_type = c_gtk_link_button_get_type;
alias gtk_link_button_new = c_gtk_link_button_new;
alias gtk_link_button_new_with_label = c_gtk_link_button_new_with_label;
alias gtk_link_button_get_uri = c_gtk_link_button_get_uri;
alias gtk_link_button_get_visited = c_gtk_link_button_get_visited;
alias gtk_link_button_set_uri = c_gtk_link_button_set_uri;
alias gtk_link_button_set_visited = c_gtk_link_button_set_visited;

// ListBase
alias gtk_list_base_get_type = c_gtk_list_base_get_type;

// ListBox
alias gtk_list_box_get_type = c_gtk_list_box_get_type;
alias gtk_list_box_new = c_gtk_list_box_new;
alias gtk_list_box_append = c_gtk_list_box_append;
alias gtk_list_box_bind_model = c_gtk_list_box_bind_model;
alias gtk_list_box_drag_highlight_row = c_gtk_list_box_drag_highlight_row;
alias gtk_list_box_drag_unhighlight_row = c_gtk_list_box_drag_unhighlight_row;
alias gtk_list_box_get_activate_on_single_click = c_gtk_list_box_get_activate_on_single_click;
alias gtk_list_box_get_adjustment = c_gtk_list_box_get_adjustment;
alias gtk_list_box_get_row_at_index = c_gtk_list_box_get_row_at_index;
alias gtk_list_box_get_row_at_y = c_gtk_list_box_get_row_at_y;
alias gtk_list_box_get_selected_row = c_gtk_list_box_get_selected_row;
alias gtk_list_box_get_selected_rows = c_gtk_list_box_get_selected_rows;
alias gtk_list_box_get_selection_mode = c_gtk_list_box_get_selection_mode;
alias gtk_list_box_get_show_separators = c_gtk_list_box_get_show_separators;
alias gtk_list_box_insert = c_gtk_list_box_insert;
alias gtk_list_box_invalidate_filter = c_gtk_list_box_invalidate_filter;
alias gtk_list_box_invalidate_headers = c_gtk_list_box_invalidate_headers;
alias gtk_list_box_invalidate_sort = c_gtk_list_box_invalidate_sort;
alias gtk_list_box_prepend = c_gtk_list_box_prepend;
alias gtk_list_box_remove = c_gtk_list_box_remove;
alias gtk_list_box_remove_all = c_gtk_list_box_remove_all;
alias gtk_list_box_select_all = c_gtk_list_box_select_all;
alias gtk_list_box_select_row = c_gtk_list_box_select_row;
alias gtk_list_box_selected_foreach = c_gtk_list_box_selected_foreach;
alias gtk_list_box_set_activate_on_single_click = c_gtk_list_box_set_activate_on_single_click;
alias gtk_list_box_set_adjustment = c_gtk_list_box_set_adjustment;
alias gtk_list_box_set_filter_func = c_gtk_list_box_set_filter_func;
alias gtk_list_box_set_header_func = c_gtk_list_box_set_header_func;
alias gtk_list_box_set_placeholder = c_gtk_list_box_set_placeholder;
alias gtk_list_box_set_selection_mode = c_gtk_list_box_set_selection_mode;
alias gtk_list_box_set_show_separators = c_gtk_list_box_set_show_separators;
alias gtk_list_box_set_sort_func = c_gtk_list_box_set_sort_func;
alias gtk_list_box_unselect_all = c_gtk_list_box_unselect_all;
alias gtk_list_box_unselect_row = c_gtk_list_box_unselect_row;

// ListBoxRow
alias gtk_list_box_row_get_type = c_gtk_list_box_row_get_type;
alias gtk_list_box_row_new = c_gtk_list_box_row_new;
alias gtk_list_box_row_changed = c_gtk_list_box_row_changed;
alias gtk_list_box_row_get_activatable = c_gtk_list_box_row_get_activatable;
alias gtk_list_box_row_get_child = c_gtk_list_box_row_get_child;
alias gtk_list_box_row_get_header = c_gtk_list_box_row_get_header;
alias gtk_list_box_row_get_index = c_gtk_list_box_row_get_index;
alias gtk_list_box_row_get_selectable = c_gtk_list_box_row_get_selectable;
alias gtk_list_box_row_is_selected = c_gtk_list_box_row_is_selected;
alias gtk_list_box_row_set_activatable = c_gtk_list_box_row_set_activatable;
alias gtk_list_box_row_set_child = c_gtk_list_box_row_set_child;
alias gtk_list_box_row_set_header = c_gtk_list_box_row_set_header;
alias gtk_list_box_row_set_selectable = c_gtk_list_box_row_set_selectable;

// ListHeader
alias gtk_list_header_get_type = c_gtk_list_header_get_type;
alias gtk_list_header_get_child = c_gtk_list_header_get_child;
alias gtk_list_header_get_end = c_gtk_list_header_get_end;
alias gtk_list_header_get_item = c_gtk_list_header_get_item;
alias gtk_list_header_get_n_items = c_gtk_list_header_get_n_items;
alias gtk_list_header_get_start = c_gtk_list_header_get_start;
alias gtk_list_header_set_child = c_gtk_list_header_set_child;

// ListItem
alias gtk_list_item_get_type = c_gtk_list_item_get_type;
alias gtk_list_item_get_accessible_description = c_gtk_list_item_get_accessible_description;
alias gtk_list_item_get_accessible_label = c_gtk_list_item_get_accessible_label;
alias gtk_list_item_get_activatable = c_gtk_list_item_get_activatable;
alias gtk_list_item_get_child = c_gtk_list_item_get_child;
alias gtk_list_item_get_focusable = c_gtk_list_item_get_focusable;
alias gtk_list_item_get_item = c_gtk_list_item_get_item;
alias gtk_list_item_get_position = c_gtk_list_item_get_position;
alias gtk_list_item_get_selectable = c_gtk_list_item_get_selectable;
alias gtk_list_item_get_selected = c_gtk_list_item_get_selected;
alias gtk_list_item_set_accessible_description = c_gtk_list_item_set_accessible_description;
alias gtk_list_item_set_accessible_label = c_gtk_list_item_set_accessible_label;
alias gtk_list_item_set_activatable = c_gtk_list_item_set_activatable;
alias gtk_list_item_set_child = c_gtk_list_item_set_child;
alias gtk_list_item_set_focusable = c_gtk_list_item_set_focusable;
alias gtk_list_item_set_selectable = c_gtk_list_item_set_selectable;

// ListItemFactory
alias gtk_list_item_factory_get_type = c_gtk_list_item_factory_get_type;

// ListStore
alias gtk_list_store_get_type = c_gtk_list_store_get_type;
alias gtk_list_store_new = c_gtk_list_store_new;
alias gtk_list_store_newv = c_gtk_list_store_newv;
alias gtk_list_store_append = c_gtk_list_store_append;
alias gtk_list_store_clear = c_gtk_list_store_clear;
alias gtk_list_store_insert = c_gtk_list_store_insert;
alias gtk_list_store_insert_after = c_gtk_list_store_insert_after;
alias gtk_list_store_insert_before = c_gtk_list_store_insert_before;
alias gtk_list_store_insert_with_values = c_gtk_list_store_insert_with_values;
alias gtk_list_store_insert_with_valuesv = c_gtk_list_store_insert_with_valuesv;
alias gtk_list_store_iter_is_valid = c_gtk_list_store_iter_is_valid;
alias gtk_list_store_move_after = c_gtk_list_store_move_after;
alias gtk_list_store_move_before = c_gtk_list_store_move_before;
alias gtk_list_store_prepend = c_gtk_list_store_prepend;
alias gtk_list_store_remove = c_gtk_list_store_remove;
alias gtk_list_store_reorder = c_gtk_list_store_reorder;
alias gtk_list_store_set = c_gtk_list_store_set;
alias gtk_list_store_set_column_types = c_gtk_list_store_set_column_types;
alias gtk_list_store_set_valist = c_gtk_list_store_set_valist;
alias gtk_list_store_set_value = c_gtk_list_store_set_value;
alias gtk_list_store_set_valuesv = c_gtk_list_store_set_valuesv;
alias gtk_list_store_swap = c_gtk_list_store_swap;

// ListView
alias gtk_list_view_get_type = c_gtk_list_view_get_type;
alias gtk_list_view_new = c_gtk_list_view_new;
alias gtk_list_view_get_enable_rubberband = c_gtk_list_view_get_enable_rubberband;
alias gtk_list_view_get_factory = c_gtk_list_view_get_factory;
alias gtk_list_view_get_header_factory = c_gtk_list_view_get_header_factory;
alias gtk_list_view_get_model = c_gtk_list_view_get_model;
alias gtk_list_view_get_show_separators = c_gtk_list_view_get_show_separators;
alias gtk_list_view_get_single_click_activate = c_gtk_list_view_get_single_click_activate;
alias gtk_list_view_get_tab_behavior = c_gtk_list_view_get_tab_behavior;
alias gtk_list_view_scroll_to = c_gtk_list_view_scroll_to;
alias gtk_list_view_set_enable_rubberband = c_gtk_list_view_set_enable_rubberband;
alias gtk_list_view_set_factory = c_gtk_list_view_set_factory;
alias gtk_list_view_set_header_factory = c_gtk_list_view_set_header_factory;
alias gtk_list_view_set_model = c_gtk_list_view_set_model;
alias gtk_list_view_set_show_separators = c_gtk_list_view_set_show_separators;
alias gtk_list_view_set_single_click_activate = c_gtk_list_view_set_single_click_activate;
alias gtk_list_view_set_tab_behavior = c_gtk_list_view_set_tab_behavior;

// LockButton
alias gtk_lock_button_get_type = c_gtk_lock_button_get_type;
alias gtk_lock_button_new = c_gtk_lock_button_new;
alias gtk_lock_button_get_permission = c_gtk_lock_button_get_permission;
alias gtk_lock_button_set_permission = c_gtk_lock_button_set_permission;

// MapListModel
alias gtk_map_list_model_get_type = c_gtk_map_list_model_get_type;
alias gtk_map_list_model_new = c_gtk_map_list_model_new;
alias gtk_map_list_model_get_model = c_gtk_map_list_model_get_model;
alias gtk_map_list_model_has_map = c_gtk_map_list_model_has_map;
alias gtk_map_list_model_set_map_func = c_gtk_map_list_model_set_map_func;
alias gtk_map_list_model_set_model = c_gtk_map_list_model_set_model;

// MediaControls
alias gtk_media_controls_get_type = c_gtk_media_controls_get_type;
alias gtk_media_controls_new = c_gtk_media_controls_new;
alias gtk_media_controls_get_media_stream = c_gtk_media_controls_get_media_stream;
alias gtk_media_controls_set_media_stream = c_gtk_media_controls_set_media_stream;

// MediaFile
alias gtk_media_file_get_type = c_gtk_media_file_get_type;
alias gtk_media_file_new = c_gtk_media_file_new;
alias gtk_media_file_new_for_file = c_gtk_media_file_new_for_file;
alias gtk_media_file_new_for_filename = c_gtk_media_file_new_for_filename;
alias gtk_media_file_new_for_input_stream = c_gtk_media_file_new_for_input_stream;
alias gtk_media_file_new_for_resource = c_gtk_media_file_new_for_resource;
alias gtk_media_file_clear = c_gtk_media_file_clear;
alias gtk_media_file_get_file = c_gtk_media_file_get_file;
alias gtk_media_file_get_input_stream = c_gtk_media_file_get_input_stream;
alias gtk_media_file_set_file = c_gtk_media_file_set_file;
alias gtk_media_file_set_filename = c_gtk_media_file_set_filename;
alias gtk_media_file_set_input_stream = c_gtk_media_file_set_input_stream;
alias gtk_media_file_set_resource = c_gtk_media_file_set_resource;

// MediaStream
alias gtk_media_stream_get_type = c_gtk_media_stream_get_type;
alias gtk_media_stream_ended = c_gtk_media_stream_ended;
alias gtk_media_stream_error = c_gtk_media_stream_error;
alias gtk_media_stream_error_valist = c_gtk_media_stream_error_valist;
alias gtk_media_stream_gerror = c_gtk_media_stream_gerror;
alias gtk_media_stream_get_duration = c_gtk_media_stream_get_duration;
alias gtk_media_stream_get_ended = c_gtk_media_stream_get_ended;
alias gtk_media_stream_get_error = c_gtk_media_stream_get_error;
alias gtk_media_stream_get_loop = c_gtk_media_stream_get_loop;
alias gtk_media_stream_get_muted = c_gtk_media_stream_get_muted;
alias gtk_media_stream_get_playing = c_gtk_media_stream_get_playing;
alias gtk_media_stream_get_timestamp = c_gtk_media_stream_get_timestamp;
alias gtk_media_stream_get_volume = c_gtk_media_stream_get_volume;
alias gtk_media_stream_has_audio = c_gtk_media_stream_has_audio;
alias gtk_media_stream_has_video = c_gtk_media_stream_has_video;
alias gtk_media_stream_is_prepared = c_gtk_media_stream_is_prepared;
alias gtk_media_stream_is_seekable = c_gtk_media_stream_is_seekable;
alias gtk_media_stream_is_seeking = c_gtk_media_stream_is_seeking;
alias gtk_media_stream_pause = c_gtk_media_stream_pause;
alias gtk_media_stream_play = c_gtk_media_stream_play;
alias gtk_media_stream_prepared = c_gtk_media_stream_prepared;
alias gtk_media_stream_realize = c_gtk_media_stream_realize;
alias gtk_media_stream_seek = c_gtk_media_stream_seek;
alias gtk_media_stream_seek_failed = c_gtk_media_stream_seek_failed;
alias gtk_media_stream_seek_success = c_gtk_media_stream_seek_success;
alias gtk_media_stream_set_loop = c_gtk_media_stream_set_loop;
alias gtk_media_stream_set_muted = c_gtk_media_stream_set_muted;
alias gtk_media_stream_set_playing = c_gtk_media_stream_set_playing;
alias gtk_media_stream_set_volume = c_gtk_media_stream_set_volume;
alias gtk_media_stream_stream_ended = c_gtk_media_stream_stream_ended;
alias gtk_media_stream_stream_prepared = c_gtk_media_stream_stream_prepared;
alias gtk_media_stream_stream_unprepared = c_gtk_media_stream_stream_unprepared;
alias gtk_media_stream_unprepared = c_gtk_media_stream_unprepared;
alias gtk_media_stream_unrealize = c_gtk_media_stream_unrealize;
alias gtk_media_stream_update = c_gtk_media_stream_update;

// MenuButton
alias gtk_menu_button_get_type = c_gtk_menu_button_get_type;
alias gtk_menu_button_new = c_gtk_menu_button_new;
alias gtk_menu_button_get_active = c_gtk_menu_button_get_active;
alias gtk_menu_button_get_always_show_arrow = c_gtk_menu_button_get_always_show_arrow;
alias gtk_menu_button_get_can_shrink = c_gtk_menu_button_get_can_shrink;
alias gtk_menu_button_get_child = c_gtk_menu_button_get_child;
alias gtk_menu_button_get_direction = c_gtk_menu_button_get_direction;
alias gtk_menu_button_get_has_frame = c_gtk_menu_button_get_has_frame;
alias gtk_menu_button_get_icon_name = c_gtk_menu_button_get_icon_name;
alias gtk_menu_button_get_label = c_gtk_menu_button_get_label;
alias gtk_menu_button_get_menu_model = c_gtk_menu_button_get_menu_model;
alias gtk_menu_button_get_popover = c_gtk_menu_button_get_popover;
alias gtk_menu_button_get_primary = c_gtk_menu_button_get_primary;
alias gtk_menu_button_get_use_underline = c_gtk_menu_button_get_use_underline;
alias gtk_menu_button_popdown = c_gtk_menu_button_popdown;
alias gtk_menu_button_popup = c_gtk_menu_button_popup;
alias gtk_menu_button_set_active = c_gtk_menu_button_set_active;
alias gtk_menu_button_set_always_show_arrow = c_gtk_menu_button_set_always_show_arrow;
alias gtk_menu_button_set_can_shrink = c_gtk_menu_button_set_can_shrink;
alias gtk_menu_button_set_child = c_gtk_menu_button_set_child;
alias gtk_menu_button_set_create_popup_func = c_gtk_menu_button_set_create_popup_func;
alias gtk_menu_button_set_direction = c_gtk_menu_button_set_direction;
alias gtk_menu_button_set_has_frame = c_gtk_menu_button_set_has_frame;
alias gtk_menu_button_set_icon_name = c_gtk_menu_button_set_icon_name;
alias gtk_menu_button_set_label = c_gtk_menu_button_set_label;
alias gtk_menu_button_set_menu_model = c_gtk_menu_button_set_menu_model;
alias gtk_menu_button_set_popover = c_gtk_menu_button_set_popover;
alias gtk_menu_button_set_primary = c_gtk_menu_button_set_primary;
alias gtk_menu_button_set_use_underline = c_gtk_menu_button_set_use_underline;

// MessageDialog
alias gtk_message_dialog_get_type = c_gtk_message_dialog_get_type;
alias gtk_message_dialog_new = c_gtk_message_dialog_new;
alias gtk_message_dialog_new_with_markup = c_gtk_message_dialog_new_with_markup;
alias gtk_message_dialog_format_secondary_markup = c_gtk_message_dialog_format_secondary_markup;
alias gtk_message_dialog_format_secondary_text = c_gtk_message_dialog_format_secondary_text;
alias gtk_message_dialog_get_message_area = c_gtk_message_dialog_get_message_area;
alias gtk_message_dialog_set_markup = c_gtk_message_dialog_set_markup;

// MnemonicAction
alias gtk_mnemonic_action_get_type = c_gtk_mnemonic_action_get_type;
alias gtk_mnemonic_action_get = c_gtk_mnemonic_action_get;

// MnemonicTrigger
alias gtk_mnemonic_trigger_get_type = c_gtk_mnemonic_trigger_get_type;
alias gtk_mnemonic_trigger_new = c_gtk_mnemonic_trigger_new;
alias gtk_mnemonic_trigger_get_keyval = c_gtk_mnemonic_trigger_get_keyval;

// MountOperation
alias gtk_mount_operation_get_type = c_gtk_mount_operation_get_type;
alias gtk_mount_operation_new = c_gtk_mount_operation_new;
alias gtk_mount_operation_get_display = c_gtk_mount_operation_get_display;
alias gtk_mount_operation_get_parent = c_gtk_mount_operation_get_parent;
alias gtk_mount_operation_is_showing = c_gtk_mount_operation_is_showing;
alias gtk_mount_operation_set_display = c_gtk_mount_operation_set_display;
alias gtk_mount_operation_set_parent = c_gtk_mount_operation_set_parent;

// MultiFilter
alias gtk_multi_filter_get_type = c_gtk_multi_filter_get_type;
alias gtk_multi_filter_append = c_gtk_multi_filter_append;
alias gtk_multi_filter_remove = c_gtk_multi_filter_remove;

// MultiSelection
alias gtk_multi_selection_get_type = c_gtk_multi_selection_get_type;
alias gtk_multi_selection_new = c_gtk_multi_selection_new;
alias gtk_multi_selection_get_model = c_gtk_multi_selection_get_model;
alias gtk_multi_selection_set_model = c_gtk_multi_selection_set_model;

// MultiSorter
alias gtk_multi_sorter_get_type = c_gtk_multi_sorter_get_type;
alias gtk_multi_sorter_new = c_gtk_multi_sorter_new;
alias gtk_multi_sorter_append = c_gtk_multi_sorter_append;
alias gtk_multi_sorter_remove = c_gtk_multi_sorter_remove;

// NamedAction
alias gtk_named_action_get_type = c_gtk_named_action_get_type;
alias gtk_named_action_new = c_gtk_named_action_new;
alias gtk_named_action_get_action_name = c_gtk_named_action_get_action_name;

// Native
alias gtk_native_get_type = c_gtk_native_get_type;
alias gtk_native_get_for_surface = c_gtk_native_get_for_surface;
alias gtk_native_get_renderer = c_gtk_native_get_renderer;
alias gtk_native_get_surface = c_gtk_native_get_surface;
alias gtk_native_get_surface_transform = c_gtk_native_get_surface_transform;
alias gtk_native_realize = c_gtk_native_realize;
alias gtk_native_unrealize = c_gtk_native_unrealize;

// NativeDialog
alias gtk_native_dialog_get_type = c_gtk_native_dialog_get_type;
alias gtk_native_dialog_destroy = c_gtk_native_dialog_destroy;
alias gtk_native_dialog_get_modal = c_gtk_native_dialog_get_modal;
alias gtk_native_dialog_get_title = c_gtk_native_dialog_get_title;
alias gtk_native_dialog_get_transient_for = c_gtk_native_dialog_get_transient_for;
alias gtk_native_dialog_get_visible = c_gtk_native_dialog_get_visible;
alias gtk_native_dialog_hide = c_gtk_native_dialog_hide;
alias gtk_native_dialog_set_modal = c_gtk_native_dialog_set_modal;
alias gtk_native_dialog_set_title = c_gtk_native_dialog_set_title;
alias gtk_native_dialog_set_transient_for = c_gtk_native_dialog_set_transient_for;
alias gtk_native_dialog_show = c_gtk_native_dialog_show;

// NeverTrigger
alias gtk_never_trigger_get_type = c_gtk_never_trigger_get_type;
alias gtk_never_trigger_get = c_gtk_never_trigger_get;

// NoSelection
alias gtk_no_selection_get_type = c_gtk_no_selection_get_type;
alias gtk_no_selection_new = c_gtk_no_selection_new;
alias gtk_no_selection_get_model = c_gtk_no_selection_get_model;
alias gtk_no_selection_set_model = c_gtk_no_selection_set_model;

// Notebook
alias gtk_notebook_get_type = c_gtk_notebook_get_type;
alias gtk_notebook_new = c_gtk_notebook_new;
alias gtk_notebook_append_page = c_gtk_notebook_append_page;
alias gtk_notebook_append_page_menu = c_gtk_notebook_append_page_menu;
alias gtk_notebook_detach_tab = c_gtk_notebook_detach_tab;
alias gtk_notebook_get_action_widget = c_gtk_notebook_get_action_widget;
alias gtk_notebook_get_current_page = c_gtk_notebook_get_current_page;
alias gtk_notebook_get_group_name = c_gtk_notebook_get_group_name;
alias gtk_notebook_get_menu_label = c_gtk_notebook_get_menu_label;
alias gtk_notebook_get_menu_label_text = c_gtk_notebook_get_menu_label_text;
alias gtk_notebook_get_n_pages = c_gtk_notebook_get_n_pages;
alias gtk_notebook_get_nth_page = c_gtk_notebook_get_nth_page;
alias gtk_notebook_get_page = c_gtk_notebook_get_page;
alias gtk_notebook_get_pages = c_gtk_notebook_get_pages;
alias gtk_notebook_get_scrollable = c_gtk_notebook_get_scrollable;
alias gtk_notebook_get_show_border = c_gtk_notebook_get_show_border;
alias gtk_notebook_get_show_tabs = c_gtk_notebook_get_show_tabs;
alias gtk_notebook_get_tab_detachable = c_gtk_notebook_get_tab_detachable;
alias gtk_notebook_get_tab_label = c_gtk_notebook_get_tab_label;
alias gtk_notebook_get_tab_label_text = c_gtk_notebook_get_tab_label_text;
alias gtk_notebook_get_tab_pos = c_gtk_notebook_get_tab_pos;
alias gtk_notebook_get_tab_reorderable = c_gtk_notebook_get_tab_reorderable;
alias gtk_notebook_insert_page = c_gtk_notebook_insert_page;
alias gtk_notebook_insert_page_menu = c_gtk_notebook_insert_page_menu;
alias gtk_notebook_next_page = c_gtk_notebook_next_page;
alias gtk_notebook_page_num = c_gtk_notebook_page_num;
alias gtk_notebook_popup_disable = c_gtk_notebook_popup_disable;
alias gtk_notebook_popup_enable = c_gtk_notebook_popup_enable;
alias gtk_notebook_prepend_page = c_gtk_notebook_prepend_page;
alias gtk_notebook_prepend_page_menu = c_gtk_notebook_prepend_page_menu;
alias gtk_notebook_prev_page = c_gtk_notebook_prev_page;
alias gtk_notebook_remove_page = c_gtk_notebook_remove_page;
alias gtk_notebook_reorder_child = c_gtk_notebook_reorder_child;
alias gtk_notebook_set_action_widget = c_gtk_notebook_set_action_widget;
alias gtk_notebook_set_current_page = c_gtk_notebook_set_current_page;
alias gtk_notebook_set_group_name = c_gtk_notebook_set_group_name;
alias gtk_notebook_set_menu_label = c_gtk_notebook_set_menu_label;
alias gtk_notebook_set_menu_label_text = c_gtk_notebook_set_menu_label_text;
alias gtk_notebook_set_scrollable = c_gtk_notebook_set_scrollable;
alias gtk_notebook_set_show_border = c_gtk_notebook_set_show_border;
alias gtk_notebook_set_show_tabs = c_gtk_notebook_set_show_tabs;
alias gtk_notebook_set_tab_detachable = c_gtk_notebook_set_tab_detachable;
alias gtk_notebook_set_tab_label = c_gtk_notebook_set_tab_label;
alias gtk_notebook_set_tab_label_text = c_gtk_notebook_set_tab_label_text;
alias gtk_notebook_set_tab_pos = c_gtk_notebook_set_tab_pos;
alias gtk_notebook_set_tab_reorderable = c_gtk_notebook_set_tab_reorderable;

// NotebookPage
alias gtk_notebook_page_get_type = c_gtk_notebook_page_get_type;
alias gtk_notebook_page_get_child = c_gtk_notebook_page_get_child;

// NothingAction
alias gtk_nothing_action_get_type = c_gtk_nothing_action_get_type;
alias gtk_nothing_action_get = c_gtk_nothing_action_get;

// NumericSorter
alias gtk_numeric_sorter_get_type = c_gtk_numeric_sorter_get_type;
alias gtk_numeric_sorter_new = c_gtk_numeric_sorter_new;
alias gtk_numeric_sorter_get_expression = c_gtk_numeric_sorter_get_expression;
alias gtk_numeric_sorter_get_sort_order = c_gtk_numeric_sorter_get_sort_order;
alias gtk_numeric_sorter_set_expression = c_gtk_numeric_sorter_set_expression;
alias gtk_numeric_sorter_set_sort_order = c_gtk_numeric_sorter_set_sort_order;

// ObjectExpression
alias gtk_object_expression_get_type = c_gtk_object_expression_get_type;
alias gtk_object_expression_new = c_gtk_object_expression_new;
alias gtk_object_expression_get_object = c_gtk_object_expression_get_object;

// Orientable
alias gtk_orientable_get_type = c_gtk_orientable_get_type;
alias gtk_orientable_get_orientation = c_gtk_orientable_get_orientation;
alias gtk_orientable_set_orientation = c_gtk_orientable_set_orientation;

// Overlay
alias gtk_overlay_get_type = c_gtk_overlay_get_type;
alias gtk_overlay_new = c_gtk_overlay_new;
alias gtk_overlay_add_overlay = c_gtk_overlay_add_overlay;
alias gtk_overlay_get_child = c_gtk_overlay_get_child;
alias gtk_overlay_get_clip_overlay = c_gtk_overlay_get_clip_overlay;
alias gtk_overlay_get_measure_overlay = c_gtk_overlay_get_measure_overlay;
alias gtk_overlay_remove_overlay = c_gtk_overlay_remove_overlay;
alias gtk_overlay_set_child = c_gtk_overlay_set_child;
alias gtk_overlay_set_clip_overlay = c_gtk_overlay_set_clip_overlay;
alias gtk_overlay_set_measure_overlay = c_gtk_overlay_set_measure_overlay;

// OverlayLayout
alias gtk_overlay_layout_get_type = c_gtk_overlay_layout_get_type;
alias gtk_overlay_layout_new = c_gtk_overlay_layout_new;

// OverlayLayoutChild
alias gtk_overlay_layout_child_get_type = c_gtk_overlay_layout_child_get_type;
alias gtk_overlay_layout_child_get_clip_overlay = c_gtk_overlay_layout_child_get_clip_overlay;
alias gtk_overlay_layout_child_get_measure = c_gtk_overlay_layout_child_get_measure;
alias gtk_overlay_layout_child_set_clip_overlay = c_gtk_overlay_layout_child_set_clip_overlay;
alias gtk_overlay_layout_child_set_measure = c_gtk_overlay_layout_child_set_measure;

// PadController
alias gtk_pad_controller_get_type = c_gtk_pad_controller_get_type;
alias gtk_pad_controller_new = c_gtk_pad_controller_new;
alias gtk_pad_controller_set_action = c_gtk_pad_controller_set_action;
alias gtk_pad_controller_set_action_entries = c_gtk_pad_controller_set_action_entries;

// PageSetup
alias gtk_page_setup_get_type = c_gtk_page_setup_get_type;
alias gtk_page_setup_new = c_gtk_page_setup_new;
alias gtk_page_setup_new_from_file = c_gtk_page_setup_new_from_file;
alias gtk_page_setup_new_from_gvariant = c_gtk_page_setup_new_from_gvariant;
alias gtk_page_setup_new_from_key_file = c_gtk_page_setup_new_from_key_file;
alias gtk_page_setup_copy = c_gtk_page_setup_copy;
alias gtk_page_setup_get_bottom_margin = c_gtk_page_setup_get_bottom_margin;
alias gtk_page_setup_get_left_margin = c_gtk_page_setup_get_left_margin;
alias gtk_page_setup_get_orientation = c_gtk_page_setup_get_orientation;
alias gtk_page_setup_get_page_height = c_gtk_page_setup_get_page_height;
alias gtk_page_setup_get_page_width = c_gtk_page_setup_get_page_width;
alias gtk_page_setup_get_paper_height = c_gtk_page_setup_get_paper_height;
alias gtk_page_setup_get_paper_size = c_gtk_page_setup_get_paper_size;
alias gtk_page_setup_get_paper_width = c_gtk_page_setup_get_paper_width;
alias gtk_page_setup_get_right_margin = c_gtk_page_setup_get_right_margin;
alias gtk_page_setup_get_top_margin = c_gtk_page_setup_get_top_margin;
alias gtk_page_setup_load_file = c_gtk_page_setup_load_file;
alias gtk_page_setup_load_key_file = c_gtk_page_setup_load_key_file;
alias gtk_page_setup_set_bottom_margin = c_gtk_page_setup_set_bottom_margin;
alias gtk_page_setup_set_left_margin = c_gtk_page_setup_set_left_margin;
alias gtk_page_setup_set_orientation = c_gtk_page_setup_set_orientation;
alias gtk_page_setup_set_paper_size = c_gtk_page_setup_set_paper_size;
alias gtk_page_setup_set_paper_size_and_default_margins = c_gtk_page_setup_set_paper_size_and_default_margins;
alias gtk_page_setup_set_right_margin = c_gtk_page_setup_set_right_margin;
alias gtk_page_setup_set_top_margin = c_gtk_page_setup_set_top_margin;
alias gtk_page_setup_to_file = c_gtk_page_setup_to_file;
alias gtk_page_setup_to_gvariant = c_gtk_page_setup_to_gvariant;
alias gtk_page_setup_to_key_file = c_gtk_page_setup_to_key_file;

// PageSetupUnixDialog
alias gtk_page_setup_unix_dialog_get_type = c_gtk_page_setup_unix_dialog_get_type;
alias gtk_page_setup_unix_dialog_new = c_gtk_page_setup_unix_dialog_new;
alias gtk_page_setup_unix_dialog_get_page_setup = c_gtk_page_setup_unix_dialog_get_page_setup;
alias gtk_page_setup_unix_dialog_get_print_settings = c_gtk_page_setup_unix_dialog_get_print_settings;
alias gtk_page_setup_unix_dialog_set_page_setup = c_gtk_page_setup_unix_dialog_set_page_setup;
alias gtk_page_setup_unix_dialog_set_print_settings = c_gtk_page_setup_unix_dialog_set_print_settings;

// Paned
alias gtk_paned_get_type = c_gtk_paned_get_type;
alias gtk_paned_new = c_gtk_paned_new;
alias gtk_paned_get_end_child = c_gtk_paned_get_end_child;
alias gtk_paned_get_position = c_gtk_paned_get_position;
alias gtk_paned_get_resize_end_child = c_gtk_paned_get_resize_end_child;
alias gtk_paned_get_resize_start_child = c_gtk_paned_get_resize_start_child;
alias gtk_paned_get_shrink_end_child = c_gtk_paned_get_shrink_end_child;
alias gtk_paned_get_shrink_start_child = c_gtk_paned_get_shrink_start_child;
alias gtk_paned_get_start_child = c_gtk_paned_get_start_child;
alias gtk_paned_get_wide_handle = c_gtk_paned_get_wide_handle;
alias gtk_paned_set_end_child = c_gtk_paned_set_end_child;
alias gtk_paned_set_position = c_gtk_paned_set_position;
alias gtk_paned_set_resize_end_child = c_gtk_paned_set_resize_end_child;
alias gtk_paned_set_resize_start_child = c_gtk_paned_set_resize_start_child;
alias gtk_paned_set_shrink_end_child = c_gtk_paned_set_shrink_end_child;
alias gtk_paned_set_shrink_start_child = c_gtk_paned_set_shrink_start_child;
alias gtk_paned_set_start_child = c_gtk_paned_set_start_child;
alias gtk_paned_set_wide_handle = c_gtk_paned_set_wide_handle;

// PaperSize
alias gtk_paper_size_get_type = c_gtk_paper_size_get_type;
alias gtk_paper_size_new = c_gtk_paper_size_new;
alias gtk_paper_size_new_custom = c_gtk_paper_size_new_custom;
alias gtk_paper_size_new_from_gvariant = c_gtk_paper_size_new_from_gvariant;
alias gtk_paper_size_new_from_ipp = c_gtk_paper_size_new_from_ipp;
alias gtk_paper_size_new_from_key_file = c_gtk_paper_size_new_from_key_file;
alias gtk_paper_size_new_from_ppd = c_gtk_paper_size_new_from_ppd;
alias gtk_paper_size_copy = c_gtk_paper_size_copy;
alias gtk_paper_size_free = c_gtk_paper_size_free;
alias gtk_paper_size_get_default_bottom_margin = c_gtk_paper_size_get_default_bottom_margin;
alias gtk_paper_size_get_default_left_margin = c_gtk_paper_size_get_default_left_margin;
alias gtk_paper_size_get_default_right_margin = c_gtk_paper_size_get_default_right_margin;
alias gtk_paper_size_get_default_top_margin = c_gtk_paper_size_get_default_top_margin;
alias gtk_paper_size_get_display_name = c_gtk_paper_size_get_display_name;
alias gtk_paper_size_get_height = c_gtk_paper_size_get_height;
alias gtk_paper_size_get_name = c_gtk_paper_size_get_name;
alias gtk_paper_size_get_ppd_name = c_gtk_paper_size_get_ppd_name;
alias gtk_paper_size_get_width = c_gtk_paper_size_get_width;
alias gtk_paper_size_is_custom = c_gtk_paper_size_is_custom;
alias gtk_paper_size_is_equal = c_gtk_paper_size_is_equal;
alias gtk_paper_size_is_ipp = c_gtk_paper_size_is_ipp;
alias gtk_paper_size_set_size = c_gtk_paper_size_set_size;
alias gtk_paper_size_to_gvariant = c_gtk_paper_size_to_gvariant;
alias gtk_paper_size_to_key_file = c_gtk_paper_size_to_key_file;
alias gtk_paper_size_get_default = c_gtk_paper_size_get_default;
alias gtk_paper_size_get_paper_sizes = c_gtk_paper_size_get_paper_sizes;

// ParamSpecExpression
alias gtk_param_expression_get_type = c_gtk_param_expression_get_type;

// PasswordEntry
alias gtk_password_entry_get_type = c_gtk_password_entry_get_type;
alias gtk_password_entry_new = c_gtk_password_entry_new;
alias gtk_password_entry_get_extra_menu = c_gtk_password_entry_get_extra_menu;
alias gtk_password_entry_get_show_peek_icon = c_gtk_password_entry_get_show_peek_icon;
alias gtk_password_entry_set_extra_menu = c_gtk_password_entry_set_extra_menu;
alias gtk_password_entry_set_show_peek_icon = c_gtk_password_entry_set_show_peek_icon;

// PasswordEntryBuffer
alias gtk_password_entry_buffer_get_type = c_gtk_password_entry_buffer_get_type;
alias gtk_password_entry_buffer_new = c_gtk_password_entry_buffer_new;

// Picture
alias gtk_picture_get_type = c_gtk_picture_get_type;
alias gtk_picture_new = c_gtk_picture_new;
alias gtk_picture_new_for_file = c_gtk_picture_new_for_file;
alias gtk_picture_new_for_filename = c_gtk_picture_new_for_filename;
alias gtk_picture_new_for_paintable = c_gtk_picture_new_for_paintable;
alias gtk_picture_new_for_pixbuf = c_gtk_picture_new_for_pixbuf;
alias gtk_picture_new_for_resource = c_gtk_picture_new_for_resource;
alias gtk_picture_get_alternative_text = c_gtk_picture_get_alternative_text;
alias gtk_picture_get_can_shrink = c_gtk_picture_get_can_shrink;
alias gtk_picture_get_content_fit = c_gtk_picture_get_content_fit;
alias gtk_picture_get_file = c_gtk_picture_get_file;
alias gtk_picture_get_keep_aspect_ratio = c_gtk_picture_get_keep_aspect_ratio;
alias gtk_picture_get_paintable = c_gtk_picture_get_paintable;
alias gtk_picture_set_alternative_text = c_gtk_picture_set_alternative_text;
alias gtk_picture_set_can_shrink = c_gtk_picture_set_can_shrink;
alias gtk_picture_set_content_fit = c_gtk_picture_set_content_fit;
alias gtk_picture_set_file = c_gtk_picture_set_file;
alias gtk_picture_set_filename = c_gtk_picture_set_filename;
alias gtk_picture_set_keep_aspect_ratio = c_gtk_picture_set_keep_aspect_ratio;
alias gtk_picture_set_paintable = c_gtk_picture_set_paintable;
alias gtk_picture_set_pixbuf = c_gtk_picture_set_pixbuf;
alias gtk_picture_set_resource = c_gtk_picture_set_resource;

// Popover
alias gtk_popover_get_type = c_gtk_popover_get_type;
alias gtk_popover_new = c_gtk_popover_new;
alias gtk_popover_get_autohide = c_gtk_popover_get_autohide;
alias gtk_popover_get_cascade_popdown = c_gtk_popover_get_cascade_popdown;
alias gtk_popover_get_child = c_gtk_popover_get_child;
alias gtk_popover_get_has_arrow = c_gtk_popover_get_has_arrow;
alias gtk_popover_get_mnemonics_visible = c_gtk_popover_get_mnemonics_visible;
alias gtk_popover_get_offset = c_gtk_popover_get_offset;
alias gtk_popover_get_pointing_to = c_gtk_popover_get_pointing_to;
alias gtk_popover_get_position = c_gtk_popover_get_position;
alias gtk_popover_popdown = c_gtk_popover_popdown;
alias gtk_popover_popup = c_gtk_popover_popup;
alias gtk_popover_present = c_gtk_popover_present;
alias gtk_popover_set_autohide = c_gtk_popover_set_autohide;
alias gtk_popover_set_cascade_popdown = c_gtk_popover_set_cascade_popdown;
alias gtk_popover_set_child = c_gtk_popover_set_child;
alias gtk_popover_set_default_widget = c_gtk_popover_set_default_widget;
alias gtk_popover_set_has_arrow = c_gtk_popover_set_has_arrow;
alias gtk_popover_set_mnemonics_visible = c_gtk_popover_set_mnemonics_visible;
alias gtk_popover_set_offset = c_gtk_popover_set_offset;
alias gtk_popover_set_pointing_to = c_gtk_popover_set_pointing_to;
alias gtk_popover_set_position = c_gtk_popover_set_position;

// PopoverMenu
alias gtk_popover_menu_get_type = c_gtk_popover_menu_get_type;
alias gtk_popover_menu_new_from_model = c_gtk_popover_menu_new_from_model;
alias gtk_popover_menu_new_from_model_full = c_gtk_popover_menu_new_from_model_full;
alias gtk_popover_menu_add_child = c_gtk_popover_menu_add_child;
alias gtk_popover_menu_get_flags = c_gtk_popover_menu_get_flags;
alias gtk_popover_menu_get_menu_model = c_gtk_popover_menu_get_menu_model;
alias gtk_popover_menu_remove_child = c_gtk_popover_menu_remove_child;
alias gtk_popover_menu_set_flags = c_gtk_popover_menu_set_flags;
alias gtk_popover_menu_set_menu_model = c_gtk_popover_menu_set_menu_model;

// PopoverMenuBar
alias gtk_popover_menu_bar_get_type = c_gtk_popover_menu_bar_get_type;
alias gtk_popover_menu_bar_new_from_model = c_gtk_popover_menu_bar_new_from_model;
alias gtk_popover_menu_bar_add_child = c_gtk_popover_menu_bar_add_child;
alias gtk_popover_menu_bar_get_menu_model = c_gtk_popover_menu_bar_get_menu_model;
alias gtk_popover_menu_bar_remove_child = c_gtk_popover_menu_bar_remove_child;
alias gtk_popover_menu_bar_set_menu_model = c_gtk_popover_menu_bar_set_menu_model;

// PrintContext
alias gtk_print_context_get_type = c_gtk_print_context_get_type;
alias gtk_print_context_create_pango_context = c_gtk_print_context_create_pango_context;
alias gtk_print_context_create_pango_layout = c_gtk_print_context_create_pango_layout;
alias gtk_print_context_get_cairo_context = c_gtk_print_context_get_cairo_context;
alias gtk_print_context_get_dpi_x = c_gtk_print_context_get_dpi_x;
alias gtk_print_context_get_dpi_y = c_gtk_print_context_get_dpi_y;
alias gtk_print_context_get_hard_margins = c_gtk_print_context_get_hard_margins;
alias gtk_print_context_get_height = c_gtk_print_context_get_height;
alias gtk_print_context_get_page_setup = c_gtk_print_context_get_page_setup;
alias gtk_print_context_get_pango_fontmap = c_gtk_print_context_get_pango_fontmap;
alias gtk_print_context_get_width = c_gtk_print_context_get_width;
alias gtk_print_context_set_cairo_context = c_gtk_print_context_set_cairo_context;

// PrintDialog
alias gtk_print_dialog_get_type = c_gtk_print_dialog_get_type;
alias gtk_print_dialog_new = c_gtk_print_dialog_new;
alias gtk_print_dialog_get_accept_label = c_gtk_print_dialog_get_accept_label;
alias gtk_print_dialog_get_modal = c_gtk_print_dialog_get_modal;
alias gtk_print_dialog_get_page_setup = c_gtk_print_dialog_get_page_setup;
alias gtk_print_dialog_get_print_settings = c_gtk_print_dialog_get_print_settings;
alias gtk_print_dialog_get_title = c_gtk_print_dialog_get_title;
alias gtk_print_dialog_print = c_gtk_print_dialog_print;
alias gtk_print_dialog_print_file = c_gtk_print_dialog_print_file;
alias gtk_print_dialog_print_file_finish = c_gtk_print_dialog_print_file_finish;
alias gtk_print_dialog_print_finish = c_gtk_print_dialog_print_finish;
alias gtk_print_dialog_set_accept_label = c_gtk_print_dialog_set_accept_label;
alias gtk_print_dialog_set_modal = c_gtk_print_dialog_set_modal;
alias gtk_print_dialog_set_page_setup = c_gtk_print_dialog_set_page_setup;
alias gtk_print_dialog_set_print_settings = c_gtk_print_dialog_set_print_settings;
alias gtk_print_dialog_set_title = c_gtk_print_dialog_set_title;
alias gtk_print_dialog_setup = c_gtk_print_dialog_setup;
alias gtk_print_dialog_setup_finish = c_gtk_print_dialog_setup_finish;

// PrintJob
alias gtk_print_job_get_type = c_gtk_print_job_get_type;
alias gtk_print_job_new = c_gtk_print_job_new;
alias gtk_print_job_get_collate = c_gtk_print_job_get_collate;
alias gtk_print_job_get_n_up = c_gtk_print_job_get_n_up;
alias gtk_print_job_get_n_up_layout = c_gtk_print_job_get_n_up_layout;
alias gtk_print_job_get_num_copies = c_gtk_print_job_get_num_copies;
alias gtk_print_job_get_page_ranges = c_gtk_print_job_get_page_ranges;
alias gtk_print_job_get_page_set = c_gtk_print_job_get_page_set;
alias gtk_print_job_get_pages = c_gtk_print_job_get_pages;
alias gtk_print_job_get_printer = c_gtk_print_job_get_printer;
alias gtk_print_job_get_reverse = c_gtk_print_job_get_reverse;
alias gtk_print_job_get_rotate = c_gtk_print_job_get_rotate;
alias gtk_print_job_get_scale = c_gtk_print_job_get_scale;
alias gtk_print_job_get_settings = c_gtk_print_job_get_settings;
alias gtk_print_job_get_status = c_gtk_print_job_get_status;
alias gtk_print_job_get_surface = c_gtk_print_job_get_surface;
alias gtk_print_job_get_title = c_gtk_print_job_get_title;
alias gtk_print_job_get_track_print_status = c_gtk_print_job_get_track_print_status;
alias gtk_print_job_send = c_gtk_print_job_send;
alias gtk_print_job_set_collate = c_gtk_print_job_set_collate;
alias gtk_print_job_set_n_up = c_gtk_print_job_set_n_up;
alias gtk_print_job_set_n_up_layout = c_gtk_print_job_set_n_up_layout;
alias gtk_print_job_set_num_copies = c_gtk_print_job_set_num_copies;
alias gtk_print_job_set_page_ranges = c_gtk_print_job_set_page_ranges;
alias gtk_print_job_set_page_set = c_gtk_print_job_set_page_set;
alias gtk_print_job_set_pages = c_gtk_print_job_set_pages;
alias gtk_print_job_set_reverse = c_gtk_print_job_set_reverse;
alias gtk_print_job_set_rotate = c_gtk_print_job_set_rotate;
alias gtk_print_job_set_scale = c_gtk_print_job_set_scale;
alias gtk_print_job_set_source_fd = c_gtk_print_job_set_source_fd;
alias gtk_print_job_set_source_file = c_gtk_print_job_set_source_file;
alias gtk_print_job_set_track_print_status = c_gtk_print_job_set_track_print_status;

// PrintOperation
alias gtk_print_operation_get_type = c_gtk_print_operation_get_type;
alias gtk_print_operation_new = c_gtk_print_operation_new;
alias gtk_print_operation_cancel = c_gtk_print_operation_cancel;
alias gtk_print_operation_draw_page_finish = c_gtk_print_operation_draw_page_finish;
alias gtk_print_operation_get_default_page_setup = c_gtk_print_operation_get_default_page_setup;
alias gtk_print_operation_get_embed_page_setup = c_gtk_print_operation_get_embed_page_setup;
alias gtk_print_operation_get_error = c_gtk_print_operation_get_error;
alias gtk_print_operation_get_has_selection = c_gtk_print_operation_get_has_selection;
alias gtk_print_operation_get_n_pages_to_print = c_gtk_print_operation_get_n_pages_to_print;
alias gtk_print_operation_get_print_settings = c_gtk_print_operation_get_print_settings;
alias gtk_print_operation_get_status = c_gtk_print_operation_get_status;
alias gtk_print_operation_get_status_string = c_gtk_print_operation_get_status_string;
alias gtk_print_operation_get_support_selection = c_gtk_print_operation_get_support_selection;
alias gtk_print_operation_is_finished = c_gtk_print_operation_is_finished;
alias gtk_print_operation_run = c_gtk_print_operation_run;
alias gtk_print_operation_set_allow_async = c_gtk_print_operation_set_allow_async;
alias gtk_print_operation_set_current_page = c_gtk_print_operation_set_current_page;
alias gtk_print_operation_set_custom_tab_label = c_gtk_print_operation_set_custom_tab_label;
alias gtk_print_operation_set_default_page_setup = c_gtk_print_operation_set_default_page_setup;
alias gtk_print_operation_set_defer_drawing = c_gtk_print_operation_set_defer_drawing;
alias gtk_print_operation_set_embed_page_setup = c_gtk_print_operation_set_embed_page_setup;
alias gtk_print_operation_set_export_filename = c_gtk_print_operation_set_export_filename;
alias gtk_print_operation_set_has_selection = c_gtk_print_operation_set_has_selection;
alias gtk_print_operation_set_job_name = c_gtk_print_operation_set_job_name;
alias gtk_print_operation_set_n_pages = c_gtk_print_operation_set_n_pages;
alias gtk_print_operation_set_print_settings = c_gtk_print_operation_set_print_settings;
alias gtk_print_operation_set_show_progress = c_gtk_print_operation_set_show_progress;
alias gtk_print_operation_set_support_selection = c_gtk_print_operation_set_support_selection;
alias gtk_print_operation_set_track_print_status = c_gtk_print_operation_set_track_print_status;
alias gtk_print_operation_set_unit = c_gtk_print_operation_set_unit;
alias gtk_print_operation_set_use_full_page = c_gtk_print_operation_set_use_full_page;

// PrintOperationPreview
alias gtk_print_operation_preview_get_type = c_gtk_print_operation_preview_get_type;
alias gtk_print_operation_preview_end_preview = c_gtk_print_operation_preview_end_preview;
alias gtk_print_operation_preview_is_selected = c_gtk_print_operation_preview_is_selected;
alias gtk_print_operation_preview_render_page = c_gtk_print_operation_preview_render_page;

// PrintSettings
alias gtk_print_settings_get_type = c_gtk_print_settings_get_type;
alias gtk_print_settings_new = c_gtk_print_settings_new;
alias gtk_print_settings_new_from_file = c_gtk_print_settings_new_from_file;
alias gtk_print_settings_new_from_gvariant = c_gtk_print_settings_new_from_gvariant;
alias gtk_print_settings_new_from_key_file = c_gtk_print_settings_new_from_key_file;
alias gtk_print_settings_copy = c_gtk_print_settings_copy;
alias gtk_print_settings_foreach = c_gtk_print_settings_foreach;
alias gtk_print_settings_get = c_gtk_print_settings_get;
alias gtk_print_settings_get_bool = c_gtk_print_settings_get_bool;
alias gtk_print_settings_get_collate = c_gtk_print_settings_get_collate;
alias gtk_print_settings_get_default_source = c_gtk_print_settings_get_default_source;
alias gtk_print_settings_get_dither = c_gtk_print_settings_get_dither;
alias gtk_print_settings_get_double = c_gtk_print_settings_get_double;
alias gtk_print_settings_get_double_with_default = c_gtk_print_settings_get_double_with_default;
alias gtk_print_settings_get_duplex = c_gtk_print_settings_get_duplex;
alias gtk_print_settings_get_finishings = c_gtk_print_settings_get_finishings;
alias gtk_print_settings_get_int = c_gtk_print_settings_get_int;
alias gtk_print_settings_get_int_with_default = c_gtk_print_settings_get_int_with_default;
alias gtk_print_settings_get_length = c_gtk_print_settings_get_length;
alias gtk_print_settings_get_media_type = c_gtk_print_settings_get_media_type;
alias gtk_print_settings_get_n_copies = c_gtk_print_settings_get_n_copies;
alias gtk_print_settings_get_number_up = c_gtk_print_settings_get_number_up;
alias gtk_print_settings_get_number_up_layout = c_gtk_print_settings_get_number_up_layout;
alias gtk_print_settings_get_orientation = c_gtk_print_settings_get_orientation;
alias gtk_print_settings_get_output_bin = c_gtk_print_settings_get_output_bin;
alias gtk_print_settings_get_page_ranges = c_gtk_print_settings_get_page_ranges;
alias gtk_print_settings_get_page_set = c_gtk_print_settings_get_page_set;
alias gtk_print_settings_get_paper_height = c_gtk_print_settings_get_paper_height;
alias gtk_print_settings_get_paper_size = c_gtk_print_settings_get_paper_size;
alias gtk_print_settings_get_paper_width = c_gtk_print_settings_get_paper_width;
alias gtk_print_settings_get_print_pages = c_gtk_print_settings_get_print_pages;
alias gtk_print_settings_get_printer = c_gtk_print_settings_get_printer;
alias gtk_print_settings_get_printer_lpi = c_gtk_print_settings_get_printer_lpi;
alias gtk_print_settings_get_quality = c_gtk_print_settings_get_quality;
alias gtk_print_settings_get_resolution = c_gtk_print_settings_get_resolution;
alias gtk_print_settings_get_resolution_x = c_gtk_print_settings_get_resolution_x;
alias gtk_print_settings_get_resolution_y = c_gtk_print_settings_get_resolution_y;
alias gtk_print_settings_get_reverse = c_gtk_print_settings_get_reverse;
alias gtk_print_settings_get_scale = c_gtk_print_settings_get_scale;
alias gtk_print_settings_get_use_color = c_gtk_print_settings_get_use_color;
alias gtk_print_settings_has_key = c_gtk_print_settings_has_key;
alias gtk_print_settings_load_file = c_gtk_print_settings_load_file;
alias gtk_print_settings_load_key_file = c_gtk_print_settings_load_key_file;
alias gtk_print_settings_set = c_gtk_print_settings_set;
alias gtk_print_settings_set_bool = c_gtk_print_settings_set_bool;
alias gtk_print_settings_set_collate = c_gtk_print_settings_set_collate;
alias gtk_print_settings_set_default_source = c_gtk_print_settings_set_default_source;
alias gtk_print_settings_set_dither = c_gtk_print_settings_set_dither;
alias gtk_print_settings_set_double = c_gtk_print_settings_set_double;
alias gtk_print_settings_set_duplex = c_gtk_print_settings_set_duplex;
alias gtk_print_settings_set_finishings = c_gtk_print_settings_set_finishings;
alias gtk_print_settings_set_int = c_gtk_print_settings_set_int;
alias gtk_print_settings_set_length = c_gtk_print_settings_set_length;
alias gtk_print_settings_set_media_type = c_gtk_print_settings_set_media_type;
alias gtk_print_settings_set_n_copies = c_gtk_print_settings_set_n_copies;
alias gtk_print_settings_set_number_up = c_gtk_print_settings_set_number_up;
alias gtk_print_settings_set_number_up_layout = c_gtk_print_settings_set_number_up_layout;
alias gtk_print_settings_set_orientation = c_gtk_print_settings_set_orientation;
alias gtk_print_settings_set_output_bin = c_gtk_print_settings_set_output_bin;
alias gtk_print_settings_set_page_ranges = c_gtk_print_settings_set_page_ranges;
alias gtk_print_settings_set_page_set = c_gtk_print_settings_set_page_set;
alias gtk_print_settings_set_paper_height = c_gtk_print_settings_set_paper_height;
alias gtk_print_settings_set_paper_size = c_gtk_print_settings_set_paper_size;
alias gtk_print_settings_set_paper_width = c_gtk_print_settings_set_paper_width;
alias gtk_print_settings_set_print_pages = c_gtk_print_settings_set_print_pages;
alias gtk_print_settings_set_printer = c_gtk_print_settings_set_printer;
alias gtk_print_settings_set_printer_lpi = c_gtk_print_settings_set_printer_lpi;
alias gtk_print_settings_set_quality = c_gtk_print_settings_set_quality;
alias gtk_print_settings_set_resolution = c_gtk_print_settings_set_resolution;
alias gtk_print_settings_set_resolution_xy = c_gtk_print_settings_set_resolution_xy;
alias gtk_print_settings_set_reverse = c_gtk_print_settings_set_reverse;
alias gtk_print_settings_set_scale = c_gtk_print_settings_set_scale;
alias gtk_print_settings_set_use_color = c_gtk_print_settings_set_use_color;
alias gtk_print_settings_to_file = c_gtk_print_settings_to_file;
alias gtk_print_settings_to_gvariant = c_gtk_print_settings_to_gvariant;
alias gtk_print_settings_to_key_file = c_gtk_print_settings_to_key_file;
alias gtk_print_settings_unset = c_gtk_print_settings_unset;

// PrintSetup
alias gtk_print_setup_get_type = c_gtk_print_setup_get_type;
alias gtk_print_setup_get_page_setup = c_gtk_print_setup_get_page_setup;
alias gtk_print_setup_get_print_settings = c_gtk_print_setup_get_print_settings;
alias gtk_print_setup_ref = c_gtk_print_setup_ref;
alias gtk_print_setup_unref = c_gtk_print_setup_unref;

// PrintUnixDialog
alias gtk_print_unix_dialog_get_type = c_gtk_print_unix_dialog_get_type;
alias gtk_print_unix_dialog_new = c_gtk_print_unix_dialog_new;
alias gtk_print_unix_dialog_add_custom_tab = c_gtk_print_unix_dialog_add_custom_tab;
alias gtk_print_unix_dialog_get_current_page = c_gtk_print_unix_dialog_get_current_page;
alias gtk_print_unix_dialog_get_embed_page_setup = c_gtk_print_unix_dialog_get_embed_page_setup;
alias gtk_print_unix_dialog_get_has_selection = c_gtk_print_unix_dialog_get_has_selection;
alias gtk_print_unix_dialog_get_manual_capabilities = c_gtk_print_unix_dialog_get_manual_capabilities;
alias gtk_print_unix_dialog_get_page_setup = c_gtk_print_unix_dialog_get_page_setup;
alias gtk_print_unix_dialog_get_page_setup_set = c_gtk_print_unix_dialog_get_page_setup_set;
alias gtk_print_unix_dialog_get_selected_printer = c_gtk_print_unix_dialog_get_selected_printer;
alias gtk_print_unix_dialog_get_settings = c_gtk_print_unix_dialog_get_settings;
alias gtk_print_unix_dialog_get_support_selection = c_gtk_print_unix_dialog_get_support_selection;
alias gtk_print_unix_dialog_set_current_page = c_gtk_print_unix_dialog_set_current_page;
alias gtk_print_unix_dialog_set_embed_page_setup = c_gtk_print_unix_dialog_set_embed_page_setup;
alias gtk_print_unix_dialog_set_has_selection = c_gtk_print_unix_dialog_set_has_selection;
alias gtk_print_unix_dialog_set_manual_capabilities = c_gtk_print_unix_dialog_set_manual_capabilities;
alias gtk_print_unix_dialog_set_page_setup = c_gtk_print_unix_dialog_set_page_setup;
alias gtk_print_unix_dialog_set_settings = c_gtk_print_unix_dialog_set_settings;
alias gtk_print_unix_dialog_set_support_selection = c_gtk_print_unix_dialog_set_support_selection;

// Printer
alias gtk_printer_get_type = c_gtk_printer_get_type;
alias gtk_printer_new = c_gtk_printer_new;
alias gtk_printer_accepts_pdf = c_gtk_printer_accepts_pdf;
alias gtk_printer_accepts_ps = c_gtk_printer_accepts_ps;
alias gtk_printer_compare = c_gtk_printer_compare;
alias gtk_printer_get_backend = c_gtk_printer_get_backend;
alias gtk_printer_get_capabilities = c_gtk_printer_get_capabilities;
alias gtk_printer_get_default_page_size = c_gtk_printer_get_default_page_size;
alias gtk_printer_get_description = c_gtk_printer_get_description;
alias gtk_printer_get_hard_margins = c_gtk_printer_get_hard_margins;
alias gtk_printer_get_hard_margins_for_paper_size = c_gtk_printer_get_hard_margins_for_paper_size;
alias gtk_printer_get_icon_name = c_gtk_printer_get_icon_name;
alias gtk_printer_get_job_count = c_gtk_printer_get_job_count;
alias gtk_printer_get_location = c_gtk_printer_get_location;
alias gtk_printer_get_name = c_gtk_printer_get_name;
alias gtk_printer_get_state_message = c_gtk_printer_get_state_message;
alias gtk_printer_has_details = c_gtk_printer_has_details;
alias gtk_printer_is_accepting_jobs = c_gtk_printer_is_accepting_jobs;
alias gtk_printer_is_active = c_gtk_printer_is_active;
alias gtk_printer_is_default = c_gtk_printer_is_default;
alias gtk_printer_is_paused = c_gtk_printer_is_paused;
alias gtk_printer_is_virtual = c_gtk_printer_is_virtual;
alias gtk_printer_list_papers = c_gtk_printer_list_papers;
alias gtk_printer_request_details = c_gtk_printer_request_details;

// ProgressBar
alias gtk_progress_bar_get_type = c_gtk_progress_bar_get_type;
alias gtk_progress_bar_new = c_gtk_progress_bar_new;
alias gtk_progress_bar_get_ellipsize = c_gtk_progress_bar_get_ellipsize;
alias gtk_progress_bar_get_fraction = c_gtk_progress_bar_get_fraction;
alias gtk_progress_bar_get_inverted = c_gtk_progress_bar_get_inverted;
alias gtk_progress_bar_get_pulse_step = c_gtk_progress_bar_get_pulse_step;
alias gtk_progress_bar_get_show_text = c_gtk_progress_bar_get_show_text;
alias gtk_progress_bar_get_text = c_gtk_progress_bar_get_text;
alias gtk_progress_bar_pulse = c_gtk_progress_bar_pulse;
alias gtk_progress_bar_set_ellipsize = c_gtk_progress_bar_set_ellipsize;
alias gtk_progress_bar_set_fraction = c_gtk_progress_bar_set_fraction;
alias gtk_progress_bar_set_inverted = c_gtk_progress_bar_set_inverted;
alias gtk_progress_bar_set_pulse_step = c_gtk_progress_bar_set_pulse_step;
alias gtk_progress_bar_set_show_text = c_gtk_progress_bar_set_show_text;
alias gtk_progress_bar_set_text = c_gtk_progress_bar_set_text;

// PropertyExpression
alias gtk_property_expression_get_type = c_gtk_property_expression_get_type;
alias gtk_property_expression_new = c_gtk_property_expression_new;
alias gtk_property_expression_new_for_pspec = c_gtk_property_expression_new_for_pspec;
alias gtk_property_expression_get_expression = c_gtk_property_expression_get_expression;
alias gtk_property_expression_get_pspec = c_gtk_property_expression_get_pspec;

// Range
alias gtk_range_get_type = c_gtk_range_get_type;
alias gtk_range_get_adjustment = c_gtk_range_get_adjustment;
alias gtk_range_get_fill_level = c_gtk_range_get_fill_level;
alias gtk_range_get_flippable = c_gtk_range_get_flippable;
alias gtk_range_get_inverted = c_gtk_range_get_inverted;
alias gtk_range_get_range_rect = c_gtk_range_get_range_rect;
alias gtk_range_get_restrict_to_fill_level = c_gtk_range_get_restrict_to_fill_level;
alias gtk_range_get_round_digits = c_gtk_range_get_round_digits;
alias gtk_range_get_show_fill_level = c_gtk_range_get_show_fill_level;
alias gtk_range_get_slider_range = c_gtk_range_get_slider_range;
alias gtk_range_get_slider_size_fixed = c_gtk_range_get_slider_size_fixed;
alias gtk_range_get_value = c_gtk_range_get_value;
alias gtk_range_set_adjustment = c_gtk_range_set_adjustment;
alias gtk_range_set_fill_level = c_gtk_range_set_fill_level;
alias gtk_range_set_flippable = c_gtk_range_set_flippable;
alias gtk_range_set_increments = c_gtk_range_set_increments;
alias gtk_range_set_inverted = c_gtk_range_set_inverted;
alias gtk_range_set_range = c_gtk_range_set_range;
alias gtk_range_set_restrict_to_fill_level = c_gtk_range_set_restrict_to_fill_level;
alias gtk_range_set_round_digits = c_gtk_range_set_round_digits;
alias gtk_range_set_show_fill_level = c_gtk_range_set_show_fill_level;
alias gtk_range_set_slider_size_fixed = c_gtk_range_set_slider_size_fixed;
alias gtk_range_set_value = c_gtk_range_set_value;

// RecentInfo
alias gtk_recent_info_get_type = c_gtk_recent_info_get_type;
alias gtk_recent_info_create_app_info = c_gtk_recent_info_create_app_info;
alias gtk_recent_info_exists = c_gtk_recent_info_exists;
alias gtk_recent_info_get_added = c_gtk_recent_info_get_added;
alias gtk_recent_info_get_age = c_gtk_recent_info_get_age;
alias gtk_recent_info_get_application_info = c_gtk_recent_info_get_application_info;
alias gtk_recent_info_get_applications = c_gtk_recent_info_get_applications;
alias gtk_recent_info_get_description = c_gtk_recent_info_get_description;
alias gtk_recent_info_get_display_name = c_gtk_recent_info_get_display_name;
alias gtk_recent_info_get_gicon = c_gtk_recent_info_get_gicon;
alias gtk_recent_info_get_groups = c_gtk_recent_info_get_groups;
alias gtk_recent_info_get_mime_type = c_gtk_recent_info_get_mime_type;
alias gtk_recent_info_get_modified = c_gtk_recent_info_get_modified;
alias gtk_recent_info_get_private_hint = c_gtk_recent_info_get_private_hint;
alias gtk_recent_info_get_short_name = c_gtk_recent_info_get_short_name;
alias gtk_recent_info_get_uri = c_gtk_recent_info_get_uri;
alias gtk_recent_info_get_uri_display = c_gtk_recent_info_get_uri_display;
alias gtk_recent_info_get_visited = c_gtk_recent_info_get_visited;
alias gtk_recent_info_has_application = c_gtk_recent_info_has_application;
alias gtk_recent_info_has_group = c_gtk_recent_info_has_group;
alias gtk_recent_info_is_local = c_gtk_recent_info_is_local;
alias gtk_recent_info_last_application = c_gtk_recent_info_last_application;
alias gtk_recent_info_match = c_gtk_recent_info_match;
alias gtk_recent_info_ref = c_gtk_recent_info_ref;
alias gtk_recent_info_unref = c_gtk_recent_info_unref;

// RecentManager
alias gtk_recent_manager_get_type = c_gtk_recent_manager_get_type;
alias gtk_recent_manager_new = c_gtk_recent_manager_new;
alias gtk_recent_manager_get_default = c_gtk_recent_manager_get_default;
alias gtk_recent_manager_add_full = c_gtk_recent_manager_add_full;
alias gtk_recent_manager_add_item = c_gtk_recent_manager_add_item;
alias gtk_recent_manager_get_items = c_gtk_recent_manager_get_items;
alias gtk_recent_manager_has_item = c_gtk_recent_manager_has_item;
alias gtk_recent_manager_lookup_item = c_gtk_recent_manager_lookup_item;
alias gtk_recent_manager_move_item = c_gtk_recent_manager_move_item;
alias gtk_recent_manager_purge_items = c_gtk_recent_manager_purge_items;
alias gtk_recent_manager_remove_item = c_gtk_recent_manager_remove_item;

// Requisition
alias gtk_requisition_get_type = c_gtk_requisition_get_type;
alias gtk_requisition_new = c_gtk_requisition_new;
alias gtk_requisition_copy = c_gtk_requisition_copy;
alias gtk_requisition_free = c_gtk_requisition_free;

// Revealer
alias gtk_revealer_get_type = c_gtk_revealer_get_type;
alias gtk_revealer_new = c_gtk_revealer_new;
alias gtk_revealer_get_child = c_gtk_revealer_get_child;
alias gtk_revealer_get_child_revealed = c_gtk_revealer_get_child_revealed;
alias gtk_revealer_get_reveal_child = c_gtk_revealer_get_reveal_child;
alias gtk_revealer_get_transition_duration = c_gtk_revealer_get_transition_duration;
alias gtk_revealer_get_transition_type = c_gtk_revealer_get_transition_type;
alias gtk_revealer_set_child = c_gtk_revealer_set_child;
alias gtk_revealer_set_reveal_child = c_gtk_revealer_set_reveal_child;
alias gtk_revealer_set_transition_duration = c_gtk_revealer_set_transition_duration;
alias gtk_revealer_set_transition_type = c_gtk_revealer_set_transition_type;

// Root
alias gtk_root_get_type = c_gtk_root_get_type;
alias gtk_root_get_display = c_gtk_root_get_display;
alias gtk_root_get_focus = c_gtk_root_get_focus;
alias gtk_root_set_focus = c_gtk_root_set_focus;

// Scale
alias gtk_scale_get_type = c_gtk_scale_get_type;
alias gtk_scale_new = c_gtk_scale_new;
alias gtk_scale_new_with_range = c_gtk_scale_new_with_range;
alias gtk_scale_add_mark = c_gtk_scale_add_mark;
alias gtk_scale_clear_marks = c_gtk_scale_clear_marks;
alias gtk_scale_get_digits = c_gtk_scale_get_digits;
alias gtk_scale_get_draw_value = c_gtk_scale_get_draw_value;
alias gtk_scale_get_has_origin = c_gtk_scale_get_has_origin;
alias gtk_scale_get_layout = c_gtk_scale_get_layout;
alias gtk_scale_get_layout_offsets = c_gtk_scale_get_layout_offsets;
alias gtk_scale_get_value_pos = c_gtk_scale_get_value_pos;
alias gtk_scale_set_digits = c_gtk_scale_set_digits;
alias gtk_scale_set_draw_value = c_gtk_scale_set_draw_value;
alias gtk_scale_set_format_value_func = c_gtk_scale_set_format_value_func;
alias gtk_scale_set_has_origin = c_gtk_scale_set_has_origin;
alias gtk_scale_set_value_pos = c_gtk_scale_set_value_pos;

// ScaleButton
alias gtk_scale_button_get_type = c_gtk_scale_button_get_type;
alias gtk_scale_button_new = c_gtk_scale_button_new;
alias gtk_scale_button_get_active = c_gtk_scale_button_get_active;
alias gtk_scale_button_get_adjustment = c_gtk_scale_button_get_adjustment;
alias gtk_scale_button_get_has_frame = c_gtk_scale_button_get_has_frame;
alias gtk_scale_button_get_minus_button = c_gtk_scale_button_get_minus_button;
alias gtk_scale_button_get_plus_button = c_gtk_scale_button_get_plus_button;
alias gtk_scale_button_get_popup = c_gtk_scale_button_get_popup;
alias gtk_scale_button_get_value = c_gtk_scale_button_get_value;
alias gtk_scale_button_set_adjustment = c_gtk_scale_button_set_adjustment;
alias gtk_scale_button_set_has_frame = c_gtk_scale_button_set_has_frame;
alias gtk_scale_button_set_icons = c_gtk_scale_button_set_icons;
alias gtk_scale_button_set_value = c_gtk_scale_button_set_value;

// ScrollInfo
alias gtk_scroll_info_get_type = c_gtk_scroll_info_get_type;
alias gtk_scroll_info_new = c_gtk_scroll_info_new;
alias gtk_scroll_info_get_enable_horizontal = c_gtk_scroll_info_get_enable_horizontal;
alias gtk_scroll_info_get_enable_vertical = c_gtk_scroll_info_get_enable_vertical;
alias gtk_scroll_info_ref = c_gtk_scroll_info_ref;
alias gtk_scroll_info_set_enable_horizontal = c_gtk_scroll_info_set_enable_horizontal;
alias gtk_scroll_info_set_enable_vertical = c_gtk_scroll_info_set_enable_vertical;
alias gtk_scroll_info_unref = c_gtk_scroll_info_unref;

// Scrollable
alias gtk_scrollable_get_type = c_gtk_scrollable_get_type;
alias gtk_scrollable_get_border = c_gtk_scrollable_get_border;
alias gtk_scrollable_get_hadjustment = c_gtk_scrollable_get_hadjustment;
alias gtk_scrollable_get_hscroll_policy = c_gtk_scrollable_get_hscroll_policy;
alias gtk_scrollable_get_vadjustment = c_gtk_scrollable_get_vadjustment;
alias gtk_scrollable_get_vscroll_policy = c_gtk_scrollable_get_vscroll_policy;
alias gtk_scrollable_set_hadjustment = c_gtk_scrollable_set_hadjustment;
alias gtk_scrollable_set_hscroll_policy = c_gtk_scrollable_set_hscroll_policy;
alias gtk_scrollable_set_vadjustment = c_gtk_scrollable_set_vadjustment;
alias gtk_scrollable_set_vscroll_policy = c_gtk_scrollable_set_vscroll_policy;

// Scrollbar
alias gtk_scrollbar_get_type = c_gtk_scrollbar_get_type;
alias gtk_scrollbar_new = c_gtk_scrollbar_new;
alias gtk_scrollbar_get_adjustment = c_gtk_scrollbar_get_adjustment;
alias gtk_scrollbar_set_adjustment = c_gtk_scrollbar_set_adjustment;

// ScrolledWindow
alias gtk_scrolled_window_get_type = c_gtk_scrolled_window_get_type;
alias gtk_scrolled_window_new = c_gtk_scrolled_window_new;
alias gtk_scrolled_window_get_child = c_gtk_scrolled_window_get_child;
alias gtk_scrolled_window_get_hadjustment = c_gtk_scrolled_window_get_hadjustment;
alias gtk_scrolled_window_get_has_frame = c_gtk_scrolled_window_get_has_frame;
alias gtk_scrolled_window_get_hscrollbar = c_gtk_scrolled_window_get_hscrollbar;
alias gtk_scrolled_window_get_kinetic_scrolling = c_gtk_scrolled_window_get_kinetic_scrolling;
alias gtk_scrolled_window_get_max_content_height = c_gtk_scrolled_window_get_max_content_height;
alias gtk_scrolled_window_get_max_content_width = c_gtk_scrolled_window_get_max_content_width;
alias gtk_scrolled_window_get_min_content_height = c_gtk_scrolled_window_get_min_content_height;
alias gtk_scrolled_window_get_min_content_width = c_gtk_scrolled_window_get_min_content_width;
alias gtk_scrolled_window_get_overlay_scrolling = c_gtk_scrolled_window_get_overlay_scrolling;
alias gtk_scrolled_window_get_placement = c_gtk_scrolled_window_get_placement;
alias gtk_scrolled_window_get_policy = c_gtk_scrolled_window_get_policy;
alias gtk_scrolled_window_get_propagate_natural_height = c_gtk_scrolled_window_get_propagate_natural_height;
alias gtk_scrolled_window_get_propagate_natural_width = c_gtk_scrolled_window_get_propagate_natural_width;
alias gtk_scrolled_window_get_vadjustment = c_gtk_scrolled_window_get_vadjustment;
alias gtk_scrolled_window_get_vscrollbar = c_gtk_scrolled_window_get_vscrollbar;
alias gtk_scrolled_window_set_child = c_gtk_scrolled_window_set_child;
alias gtk_scrolled_window_set_hadjustment = c_gtk_scrolled_window_set_hadjustment;
alias gtk_scrolled_window_set_has_frame = c_gtk_scrolled_window_set_has_frame;
alias gtk_scrolled_window_set_kinetic_scrolling = c_gtk_scrolled_window_set_kinetic_scrolling;
alias gtk_scrolled_window_set_max_content_height = c_gtk_scrolled_window_set_max_content_height;
alias gtk_scrolled_window_set_max_content_width = c_gtk_scrolled_window_set_max_content_width;
alias gtk_scrolled_window_set_min_content_height = c_gtk_scrolled_window_set_min_content_height;
alias gtk_scrolled_window_set_min_content_width = c_gtk_scrolled_window_set_min_content_width;
alias gtk_scrolled_window_set_overlay_scrolling = c_gtk_scrolled_window_set_overlay_scrolling;
alias gtk_scrolled_window_set_placement = c_gtk_scrolled_window_set_placement;
alias gtk_scrolled_window_set_policy = c_gtk_scrolled_window_set_policy;
alias gtk_scrolled_window_set_propagate_natural_height = c_gtk_scrolled_window_set_propagate_natural_height;
alias gtk_scrolled_window_set_propagate_natural_width = c_gtk_scrolled_window_set_propagate_natural_width;
alias gtk_scrolled_window_set_vadjustment = c_gtk_scrolled_window_set_vadjustment;
alias gtk_scrolled_window_unset_placement = c_gtk_scrolled_window_unset_placement;

// SearchBar
alias gtk_search_bar_get_type = c_gtk_search_bar_get_type;
alias gtk_search_bar_new = c_gtk_search_bar_new;
alias gtk_search_bar_connect_entry = c_gtk_search_bar_connect_entry;
alias gtk_search_bar_get_child = c_gtk_search_bar_get_child;
alias gtk_search_bar_get_key_capture_widget = c_gtk_search_bar_get_key_capture_widget;
alias gtk_search_bar_get_search_mode = c_gtk_search_bar_get_search_mode;
alias gtk_search_bar_get_show_close_button = c_gtk_search_bar_get_show_close_button;
alias gtk_search_bar_set_child = c_gtk_search_bar_set_child;
alias gtk_search_bar_set_key_capture_widget = c_gtk_search_bar_set_key_capture_widget;
alias gtk_search_bar_set_search_mode = c_gtk_search_bar_set_search_mode;
alias gtk_search_bar_set_show_close_button = c_gtk_search_bar_set_show_close_button;

// SearchEntry
alias gtk_search_entry_get_type = c_gtk_search_entry_get_type;
alias gtk_search_entry_new = c_gtk_search_entry_new;
alias gtk_search_entry_get_input_hints = c_gtk_search_entry_get_input_hints;
alias gtk_search_entry_get_input_purpose = c_gtk_search_entry_get_input_purpose;
alias gtk_search_entry_get_key_capture_widget = c_gtk_search_entry_get_key_capture_widget;
alias gtk_search_entry_get_placeholder_text = c_gtk_search_entry_get_placeholder_text;
alias gtk_search_entry_get_search_delay = c_gtk_search_entry_get_search_delay;
alias gtk_search_entry_set_input_hints = c_gtk_search_entry_set_input_hints;
alias gtk_search_entry_set_input_purpose = c_gtk_search_entry_set_input_purpose;
alias gtk_search_entry_set_key_capture_widget = c_gtk_search_entry_set_key_capture_widget;
alias gtk_search_entry_set_placeholder_text = c_gtk_search_entry_set_placeholder_text;
alias gtk_search_entry_set_search_delay = c_gtk_search_entry_set_search_delay;

// SectionModel
alias gtk_section_model_get_type = c_gtk_section_model_get_type;
alias gtk_section_model_get_section = c_gtk_section_model_get_section;
alias gtk_section_model_sections_changed = c_gtk_section_model_sections_changed;

// SelectionFilterModel
alias gtk_selection_filter_model_get_type = c_gtk_selection_filter_model_get_type;
alias gtk_selection_filter_model_new = c_gtk_selection_filter_model_new;
alias gtk_selection_filter_model_get_model = c_gtk_selection_filter_model_get_model;
alias gtk_selection_filter_model_set_model = c_gtk_selection_filter_model_set_model;

// SelectionModel
alias gtk_selection_model_get_type = c_gtk_selection_model_get_type;
alias gtk_selection_model_get_selection = c_gtk_selection_model_get_selection;
alias gtk_selection_model_get_selection_in_range = c_gtk_selection_model_get_selection_in_range;
alias gtk_selection_model_is_selected = c_gtk_selection_model_is_selected;
alias gtk_selection_model_select_all = c_gtk_selection_model_select_all;
alias gtk_selection_model_select_item = c_gtk_selection_model_select_item;
alias gtk_selection_model_select_range = c_gtk_selection_model_select_range;
alias gtk_selection_model_selection_changed = c_gtk_selection_model_selection_changed;
alias gtk_selection_model_set_selection = c_gtk_selection_model_set_selection;
alias gtk_selection_model_unselect_all = c_gtk_selection_model_unselect_all;
alias gtk_selection_model_unselect_item = c_gtk_selection_model_unselect_item;
alias gtk_selection_model_unselect_range = c_gtk_selection_model_unselect_range;

// Separator
alias gtk_separator_get_type = c_gtk_separator_get_type;
alias gtk_separator_new = c_gtk_separator_new;

// Settings
alias gtk_settings_get_type = c_gtk_settings_get_type;
alias gtk_settings_get_default = c_gtk_settings_get_default;
alias gtk_settings_get_for_display = c_gtk_settings_get_for_display;
alias gtk_settings_reset_property = c_gtk_settings_reset_property;

// Shortcut
alias gtk_shortcut_get_type = c_gtk_shortcut_get_type;
alias gtk_shortcut_new = c_gtk_shortcut_new;
alias gtk_shortcut_new_with_arguments = c_gtk_shortcut_new_with_arguments;
alias gtk_shortcut_get_action = c_gtk_shortcut_get_action;
alias gtk_shortcut_get_arguments = c_gtk_shortcut_get_arguments;
alias gtk_shortcut_get_trigger = c_gtk_shortcut_get_trigger;
alias gtk_shortcut_set_action = c_gtk_shortcut_set_action;
alias gtk_shortcut_set_arguments = c_gtk_shortcut_set_arguments;
alias gtk_shortcut_set_trigger = c_gtk_shortcut_set_trigger;

// ShortcutAction
alias gtk_shortcut_action_get_type = c_gtk_shortcut_action_get_type;
alias gtk_shortcut_action_parse_string = c_gtk_shortcut_action_parse_string;
alias gtk_shortcut_action_activate = c_gtk_shortcut_action_activate;
alias gtk_shortcut_action_print = c_gtk_shortcut_action_print;
alias gtk_shortcut_action_to_string = c_gtk_shortcut_action_to_string;

// ShortcutController
alias gtk_shortcut_controller_get_type = c_gtk_shortcut_controller_get_type;
alias gtk_shortcut_controller_new = c_gtk_shortcut_controller_new;
alias gtk_shortcut_controller_new_for_model = c_gtk_shortcut_controller_new_for_model;
alias gtk_shortcut_controller_add_shortcut = c_gtk_shortcut_controller_add_shortcut;
alias gtk_shortcut_controller_get_mnemonics_modifiers = c_gtk_shortcut_controller_get_mnemonics_modifiers;
alias gtk_shortcut_controller_get_scope = c_gtk_shortcut_controller_get_scope;
alias gtk_shortcut_controller_remove_shortcut = c_gtk_shortcut_controller_remove_shortcut;
alias gtk_shortcut_controller_set_mnemonics_modifiers = c_gtk_shortcut_controller_set_mnemonics_modifiers;
alias gtk_shortcut_controller_set_scope = c_gtk_shortcut_controller_set_scope;

// ShortcutLabel
alias gtk_shortcut_label_get_type = c_gtk_shortcut_label_get_type;
alias gtk_shortcut_label_new = c_gtk_shortcut_label_new;
alias gtk_shortcut_label_get_accelerator = c_gtk_shortcut_label_get_accelerator;
alias gtk_shortcut_label_get_disabled_text = c_gtk_shortcut_label_get_disabled_text;
alias gtk_shortcut_label_set_accelerator = c_gtk_shortcut_label_set_accelerator;
alias gtk_shortcut_label_set_disabled_text = c_gtk_shortcut_label_set_disabled_text;

// ShortcutManager
alias gtk_shortcut_manager_get_type = c_gtk_shortcut_manager_get_type;

// ShortcutTrigger
alias gtk_shortcut_trigger_get_type = c_gtk_shortcut_trigger_get_type;
alias gtk_shortcut_trigger_parse_string = c_gtk_shortcut_trigger_parse_string;
alias gtk_shortcut_trigger_compare = c_gtk_shortcut_trigger_compare;
alias gtk_shortcut_trigger_equal = c_gtk_shortcut_trigger_equal;
alias gtk_shortcut_trigger_hash = c_gtk_shortcut_trigger_hash;
alias gtk_shortcut_trigger_print = c_gtk_shortcut_trigger_print;
alias gtk_shortcut_trigger_print_label = c_gtk_shortcut_trigger_print_label;
alias gtk_shortcut_trigger_to_label = c_gtk_shortcut_trigger_to_label;
alias gtk_shortcut_trigger_to_string = c_gtk_shortcut_trigger_to_string;
alias gtk_shortcut_trigger_trigger = c_gtk_shortcut_trigger_trigger;

// ShortcutsGroup
alias gtk_shortcuts_group_get_type = c_gtk_shortcuts_group_get_type;
alias gtk_shortcuts_group_add_shortcut = c_gtk_shortcuts_group_add_shortcut;

// ShortcutsSection
alias gtk_shortcuts_section_get_type = c_gtk_shortcuts_section_get_type;
alias gtk_shortcuts_section_add_group = c_gtk_shortcuts_section_add_group;

// ShortcutsShortcut
alias gtk_shortcuts_shortcut_get_type = c_gtk_shortcuts_shortcut_get_type;

// ShortcutsWindow
alias gtk_shortcuts_window_get_type = c_gtk_shortcuts_window_get_type;
alias gtk_shortcuts_window_add_section = c_gtk_shortcuts_window_add_section;

// SignalAction
alias gtk_signal_action_get_type = c_gtk_signal_action_get_type;
alias gtk_signal_action_new = c_gtk_signal_action_new;
alias gtk_signal_action_get_signal_name = c_gtk_signal_action_get_signal_name;

// SignalListItemFactory
alias gtk_signal_list_item_factory_get_type = c_gtk_signal_list_item_factory_get_type;
alias gtk_signal_list_item_factory_new = c_gtk_signal_list_item_factory_new;

// SingleSelection
alias gtk_single_selection_get_type = c_gtk_single_selection_get_type;
alias gtk_single_selection_new = c_gtk_single_selection_new;
alias gtk_single_selection_get_autoselect = c_gtk_single_selection_get_autoselect;
alias gtk_single_selection_get_can_unselect = c_gtk_single_selection_get_can_unselect;
alias gtk_single_selection_get_model = c_gtk_single_selection_get_model;
alias gtk_single_selection_get_selected = c_gtk_single_selection_get_selected;
alias gtk_single_selection_get_selected_item = c_gtk_single_selection_get_selected_item;
alias gtk_single_selection_set_autoselect = c_gtk_single_selection_set_autoselect;
alias gtk_single_selection_set_can_unselect = c_gtk_single_selection_set_can_unselect;
alias gtk_single_selection_set_model = c_gtk_single_selection_set_model;
alias gtk_single_selection_set_selected = c_gtk_single_selection_set_selected;

// SizeGroup
alias gtk_size_group_get_type = c_gtk_size_group_get_type;
alias gtk_size_group_new = c_gtk_size_group_new;
alias gtk_size_group_add_widget = c_gtk_size_group_add_widget;
alias gtk_size_group_get_mode = c_gtk_size_group_get_mode;
alias gtk_size_group_get_widgets = c_gtk_size_group_get_widgets;
alias gtk_size_group_remove_widget = c_gtk_size_group_remove_widget;
alias gtk_size_group_set_mode = c_gtk_size_group_set_mode;

// SliceListModel
alias gtk_slice_list_model_get_type = c_gtk_slice_list_model_get_type;
alias gtk_slice_list_model_new = c_gtk_slice_list_model_new;
alias gtk_slice_list_model_get_model = c_gtk_slice_list_model_get_model;
alias gtk_slice_list_model_get_offset = c_gtk_slice_list_model_get_offset;
alias gtk_slice_list_model_get_size = c_gtk_slice_list_model_get_size;
alias gtk_slice_list_model_set_model = c_gtk_slice_list_model_set_model;
alias gtk_slice_list_model_set_offset = c_gtk_slice_list_model_set_offset;
alias gtk_slice_list_model_set_size = c_gtk_slice_list_model_set_size;

// Snapshot
alias gtk_snapshot_get_type = c_gtk_snapshot_get_type;
alias gtk_snapshot_new = c_gtk_snapshot_new;
alias gtk_snapshot_append_border = c_gtk_snapshot_append_border;
alias gtk_snapshot_append_cairo = c_gtk_snapshot_append_cairo;
alias gtk_snapshot_append_color = c_gtk_snapshot_append_color;
alias gtk_snapshot_append_conic_gradient = c_gtk_snapshot_append_conic_gradient;
alias gtk_snapshot_append_fill = c_gtk_snapshot_append_fill;
alias gtk_snapshot_append_inset_shadow = c_gtk_snapshot_append_inset_shadow;
alias gtk_snapshot_append_layout = c_gtk_snapshot_append_layout;
alias gtk_snapshot_append_linear_gradient = c_gtk_snapshot_append_linear_gradient;
alias gtk_snapshot_append_node = c_gtk_snapshot_append_node;
alias gtk_snapshot_append_outset_shadow = c_gtk_snapshot_append_outset_shadow;
alias gtk_snapshot_append_radial_gradient = c_gtk_snapshot_append_radial_gradient;
alias gtk_snapshot_append_repeating_linear_gradient = c_gtk_snapshot_append_repeating_linear_gradient;
alias gtk_snapshot_append_repeating_radial_gradient = c_gtk_snapshot_append_repeating_radial_gradient;
alias gtk_snapshot_append_scaled_texture = c_gtk_snapshot_append_scaled_texture;
alias gtk_snapshot_append_stroke = c_gtk_snapshot_append_stroke;
alias gtk_snapshot_append_texture = c_gtk_snapshot_append_texture;
alias gtk_snapshot_free_to_node = c_gtk_snapshot_free_to_node;
alias gtk_snapshot_free_to_paintable = c_gtk_snapshot_free_to_paintable;
alias gtk_snapshot_gl_shader_pop_texture = c_gtk_snapshot_gl_shader_pop_texture;
alias gtk_snapshot_perspective = c_gtk_snapshot_perspective;
alias gtk_snapshot_pop = c_gtk_snapshot_pop;
alias gtk_snapshot_push_blend = c_gtk_snapshot_push_blend;
alias gtk_snapshot_push_blur = c_gtk_snapshot_push_blur;
alias gtk_snapshot_push_clip = c_gtk_snapshot_push_clip;
alias gtk_snapshot_push_color_matrix = c_gtk_snapshot_push_color_matrix;
alias gtk_snapshot_push_cross_fade = c_gtk_snapshot_push_cross_fade;
alias gtk_snapshot_push_debug = c_gtk_snapshot_push_debug;
alias gtk_snapshot_push_fill = c_gtk_snapshot_push_fill;
alias gtk_snapshot_push_gl_shader = c_gtk_snapshot_push_gl_shader;
alias gtk_snapshot_push_mask = c_gtk_snapshot_push_mask;
alias gtk_snapshot_push_opacity = c_gtk_snapshot_push_opacity;
alias gtk_snapshot_push_repeat = c_gtk_snapshot_push_repeat;
alias gtk_snapshot_push_rounded_clip = c_gtk_snapshot_push_rounded_clip;
alias gtk_snapshot_push_shadow = c_gtk_snapshot_push_shadow;
alias gtk_snapshot_push_stroke = c_gtk_snapshot_push_stroke;
alias gtk_snapshot_render_background = c_gtk_snapshot_render_background;
alias gtk_snapshot_render_focus = c_gtk_snapshot_render_focus;
alias gtk_snapshot_render_frame = c_gtk_snapshot_render_frame;
alias gtk_snapshot_render_insertion_cursor = c_gtk_snapshot_render_insertion_cursor;
alias gtk_snapshot_render_layout = c_gtk_snapshot_render_layout;
alias gtk_snapshot_restore = c_gtk_snapshot_restore;
alias gtk_snapshot_rotate = c_gtk_snapshot_rotate;
alias gtk_snapshot_rotate_3d = c_gtk_snapshot_rotate_3d;
alias gtk_snapshot_save = c_gtk_snapshot_save;
alias gtk_snapshot_scale = c_gtk_snapshot_scale;
alias gtk_snapshot_scale_3d = c_gtk_snapshot_scale_3d;
alias gtk_snapshot_to_node = c_gtk_snapshot_to_node;
alias gtk_snapshot_to_paintable = c_gtk_snapshot_to_paintable;
alias gtk_snapshot_transform = c_gtk_snapshot_transform;
alias gtk_snapshot_transform_matrix = c_gtk_snapshot_transform_matrix;
alias gtk_snapshot_translate = c_gtk_snapshot_translate;
alias gtk_snapshot_translate_3d = c_gtk_snapshot_translate_3d;

// SortListModel
alias gtk_sort_list_model_get_type = c_gtk_sort_list_model_get_type;
alias gtk_sort_list_model_new = c_gtk_sort_list_model_new;
alias gtk_sort_list_model_get_incremental = c_gtk_sort_list_model_get_incremental;
alias gtk_sort_list_model_get_model = c_gtk_sort_list_model_get_model;
alias gtk_sort_list_model_get_pending = c_gtk_sort_list_model_get_pending;
alias gtk_sort_list_model_get_section_sorter = c_gtk_sort_list_model_get_section_sorter;
alias gtk_sort_list_model_get_sorter = c_gtk_sort_list_model_get_sorter;
alias gtk_sort_list_model_set_incremental = c_gtk_sort_list_model_set_incremental;
alias gtk_sort_list_model_set_model = c_gtk_sort_list_model_set_model;
alias gtk_sort_list_model_set_section_sorter = c_gtk_sort_list_model_set_section_sorter;
alias gtk_sort_list_model_set_sorter = c_gtk_sort_list_model_set_sorter;

// Sorter
alias gtk_sorter_get_type = c_gtk_sorter_get_type;
alias gtk_sorter_changed = c_gtk_sorter_changed;
alias gtk_sorter_compare = c_gtk_sorter_compare;
alias gtk_sorter_get_order = c_gtk_sorter_get_order;

// SpinButton
alias gtk_spin_button_get_type = c_gtk_spin_button_get_type;
alias gtk_spin_button_new = c_gtk_spin_button_new;
alias gtk_spin_button_new_with_range = c_gtk_spin_button_new_with_range;
alias gtk_spin_button_configure = c_gtk_spin_button_configure;
alias gtk_spin_button_get_activates_default = c_gtk_spin_button_get_activates_default;
alias gtk_spin_button_get_adjustment = c_gtk_spin_button_get_adjustment;
alias gtk_spin_button_get_climb_rate = c_gtk_spin_button_get_climb_rate;
alias gtk_spin_button_get_digits = c_gtk_spin_button_get_digits;
alias gtk_spin_button_get_increments = c_gtk_spin_button_get_increments;
alias gtk_spin_button_get_numeric = c_gtk_spin_button_get_numeric;
alias gtk_spin_button_get_range = c_gtk_spin_button_get_range;
alias gtk_spin_button_get_snap_to_ticks = c_gtk_spin_button_get_snap_to_ticks;
alias gtk_spin_button_get_update_policy = c_gtk_spin_button_get_update_policy;
alias gtk_spin_button_get_value = c_gtk_spin_button_get_value;
alias gtk_spin_button_get_value_as_int = c_gtk_spin_button_get_value_as_int;
alias gtk_spin_button_get_wrap = c_gtk_spin_button_get_wrap;
alias gtk_spin_button_set_activates_default = c_gtk_spin_button_set_activates_default;
alias gtk_spin_button_set_adjustment = c_gtk_spin_button_set_adjustment;
alias gtk_spin_button_set_climb_rate = c_gtk_spin_button_set_climb_rate;
alias gtk_spin_button_set_digits = c_gtk_spin_button_set_digits;
alias gtk_spin_button_set_increments = c_gtk_spin_button_set_increments;
alias gtk_spin_button_set_numeric = c_gtk_spin_button_set_numeric;
alias gtk_spin_button_set_range = c_gtk_spin_button_set_range;
alias gtk_spin_button_set_snap_to_ticks = c_gtk_spin_button_set_snap_to_ticks;
alias gtk_spin_button_set_update_policy = c_gtk_spin_button_set_update_policy;
alias gtk_spin_button_set_value = c_gtk_spin_button_set_value;
alias gtk_spin_button_set_wrap = c_gtk_spin_button_set_wrap;
alias gtk_spin_button_spin = c_gtk_spin_button_spin;
alias gtk_spin_button_update = c_gtk_spin_button_update;

// Spinner
alias gtk_spinner_get_type = c_gtk_spinner_get_type;
alias gtk_spinner_new = c_gtk_spinner_new;
alias gtk_spinner_get_spinning = c_gtk_spinner_get_spinning;
alias gtk_spinner_set_spinning = c_gtk_spinner_set_spinning;
alias gtk_spinner_start = c_gtk_spinner_start;
alias gtk_spinner_stop = c_gtk_spinner_stop;

// Stack
alias gtk_stack_get_type = c_gtk_stack_get_type;
alias gtk_stack_new = c_gtk_stack_new;
alias gtk_stack_add_child = c_gtk_stack_add_child;
alias gtk_stack_add_named = c_gtk_stack_add_named;
alias gtk_stack_add_titled = c_gtk_stack_add_titled;
alias gtk_stack_get_child_by_name = c_gtk_stack_get_child_by_name;
alias gtk_stack_get_hhomogeneous = c_gtk_stack_get_hhomogeneous;
alias gtk_stack_get_interpolate_size = c_gtk_stack_get_interpolate_size;
alias gtk_stack_get_page = c_gtk_stack_get_page;
alias gtk_stack_get_pages = c_gtk_stack_get_pages;
alias gtk_stack_get_transition_duration = c_gtk_stack_get_transition_duration;
alias gtk_stack_get_transition_running = c_gtk_stack_get_transition_running;
alias gtk_stack_get_transition_type = c_gtk_stack_get_transition_type;
alias gtk_stack_get_vhomogeneous = c_gtk_stack_get_vhomogeneous;
alias gtk_stack_get_visible_child = c_gtk_stack_get_visible_child;
alias gtk_stack_get_visible_child_name = c_gtk_stack_get_visible_child_name;
alias gtk_stack_remove = c_gtk_stack_remove;
alias gtk_stack_set_hhomogeneous = c_gtk_stack_set_hhomogeneous;
alias gtk_stack_set_interpolate_size = c_gtk_stack_set_interpolate_size;
alias gtk_stack_set_transition_duration = c_gtk_stack_set_transition_duration;
alias gtk_stack_set_transition_type = c_gtk_stack_set_transition_type;
alias gtk_stack_set_vhomogeneous = c_gtk_stack_set_vhomogeneous;
alias gtk_stack_set_visible_child = c_gtk_stack_set_visible_child;
alias gtk_stack_set_visible_child_full = c_gtk_stack_set_visible_child_full;
alias gtk_stack_set_visible_child_name = c_gtk_stack_set_visible_child_name;

// StackPage
alias gtk_stack_page_get_type = c_gtk_stack_page_get_type;
alias gtk_stack_page_get_child = c_gtk_stack_page_get_child;
alias gtk_stack_page_get_icon_name = c_gtk_stack_page_get_icon_name;
alias gtk_stack_page_get_name = c_gtk_stack_page_get_name;
alias gtk_stack_page_get_needs_attention = c_gtk_stack_page_get_needs_attention;
alias gtk_stack_page_get_title = c_gtk_stack_page_get_title;
alias gtk_stack_page_get_use_underline = c_gtk_stack_page_get_use_underline;
alias gtk_stack_page_get_visible = c_gtk_stack_page_get_visible;
alias gtk_stack_page_set_icon_name = c_gtk_stack_page_set_icon_name;
alias gtk_stack_page_set_name = c_gtk_stack_page_set_name;
alias gtk_stack_page_set_needs_attention = c_gtk_stack_page_set_needs_attention;
alias gtk_stack_page_set_title = c_gtk_stack_page_set_title;
alias gtk_stack_page_set_use_underline = c_gtk_stack_page_set_use_underline;
alias gtk_stack_page_set_visible = c_gtk_stack_page_set_visible;

// StackSidebar
alias gtk_stack_sidebar_get_type = c_gtk_stack_sidebar_get_type;
alias gtk_stack_sidebar_new = c_gtk_stack_sidebar_new;
alias gtk_stack_sidebar_get_stack = c_gtk_stack_sidebar_get_stack;
alias gtk_stack_sidebar_set_stack = c_gtk_stack_sidebar_set_stack;

// StackSwitcher
alias gtk_stack_switcher_get_type = c_gtk_stack_switcher_get_type;
alias gtk_stack_switcher_new = c_gtk_stack_switcher_new;
alias gtk_stack_switcher_get_stack = c_gtk_stack_switcher_get_stack;
alias gtk_stack_switcher_set_stack = c_gtk_stack_switcher_set_stack;

// Statusbar
alias gtk_statusbar_get_type = c_gtk_statusbar_get_type;
alias gtk_statusbar_new = c_gtk_statusbar_new;
alias gtk_statusbar_get_context_id = c_gtk_statusbar_get_context_id;
alias gtk_statusbar_pop = c_gtk_statusbar_pop;
alias gtk_statusbar_push = c_gtk_statusbar_push;
alias gtk_statusbar_remove = c_gtk_statusbar_remove;
alias gtk_statusbar_remove_all = c_gtk_statusbar_remove_all;

// StringFilter
alias gtk_string_filter_get_type = c_gtk_string_filter_get_type;
alias gtk_string_filter_new = c_gtk_string_filter_new;
alias gtk_string_filter_get_expression = c_gtk_string_filter_get_expression;
alias gtk_string_filter_get_ignore_case = c_gtk_string_filter_get_ignore_case;
alias gtk_string_filter_get_match_mode = c_gtk_string_filter_get_match_mode;
alias gtk_string_filter_get_search = c_gtk_string_filter_get_search;
alias gtk_string_filter_set_expression = c_gtk_string_filter_set_expression;
alias gtk_string_filter_set_ignore_case = c_gtk_string_filter_set_ignore_case;
alias gtk_string_filter_set_match_mode = c_gtk_string_filter_set_match_mode;
alias gtk_string_filter_set_search = c_gtk_string_filter_set_search;

// StringList
alias gtk_string_list_get_type = c_gtk_string_list_get_type;
alias gtk_string_list_new = c_gtk_string_list_new;
alias gtk_string_list_append = c_gtk_string_list_append;
alias gtk_string_list_get_string = c_gtk_string_list_get_string;
alias gtk_string_list_remove = c_gtk_string_list_remove;
alias gtk_string_list_splice = c_gtk_string_list_splice;
alias gtk_string_list_take = c_gtk_string_list_take;

// StringObject
alias gtk_string_object_get_type = c_gtk_string_object_get_type;
alias gtk_string_object_new = c_gtk_string_object_new;
alias gtk_string_object_get_string = c_gtk_string_object_get_string;

// StringSorter
alias gtk_string_sorter_get_type = c_gtk_string_sorter_get_type;
alias gtk_string_sorter_new = c_gtk_string_sorter_new;
alias gtk_string_sorter_get_collation = c_gtk_string_sorter_get_collation;
alias gtk_string_sorter_get_expression = c_gtk_string_sorter_get_expression;
alias gtk_string_sorter_get_ignore_case = c_gtk_string_sorter_get_ignore_case;
alias gtk_string_sorter_set_collation = c_gtk_string_sorter_set_collation;
alias gtk_string_sorter_set_expression = c_gtk_string_sorter_set_expression;
alias gtk_string_sorter_set_ignore_case = c_gtk_string_sorter_set_ignore_case;

// StyleContext
alias gtk_style_context_get_type = c_gtk_style_context_get_type;
alias gtk_style_context_add_provider_for_display = c_gtk_style_context_add_provider_for_display;
alias gtk_style_context_remove_provider_for_display = c_gtk_style_context_remove_provider_for_display;
alias gtk_style_context_add_class = c_gtk_style_context_add_class;
alias gtk_style_context_add_provider = c_gtk_style_context_add_provider;
alias gtk_style_context_get_border = c_gtk_style_context_get_border;
alias gtk_style_context_get_color = c_gtk_style_context_get_color;
alias gtk_style_context_get_display = c_gtk_style_context_get_display;
alias gtk_style_context_get_margin = c_gtk_style_context_get_margin;
alias gtk_style_context_get_padding = c_gtk_style_context_get_padding;
alias gtk_style_context_get_scale = c_gtk_style_context_get_scale;
alias gtk_style_context_get_state = c_gtk_style_context_get_state;
alias gtk_style_context_has_class = c_gtk_style_context_has_class;
alias gtk_style_context_lookup_color = c_gtk_style_context_lookup_color;
alias gtk_style_context_remove_class = c_gtk_style_context_remove_class;
alias gtk_style_context_remove_provider = c_gtk_style_context_remove_provider;
alias gtk_style_context_restore = c_gtk_style_context_restore;
alias gtk_style_context_save = c_gtk_style_context_save;
alias gtk_style_context_set_display = c_gtk_style_context_set_display;
alias gtk_style_context_set_scale = c_gtk_style_context_set_scale;
alias gtk_style_context_set_state = c_gtk_style_context_set_state;
alias gtk_style_context_to_string = c_gtk_style_context_to_string;

// StyleProvider
alias gtk_style_provider_get_type = c_gtk_style_provider_get_type;

// Switch
alias gtk_switch_get_type = c_gtk_switch_get_type;
alias gtk_switch_new = c_gtk_switch_new;
alias gtk_switch_get_active = c_gtk_switch_get_active;
alias gtk_switch_get_state = c_gtk_switch_get_state;
alias gtk_switch_set_active = c_gtk_switch_set_active;
alias gtk_switch_set_state = c_gtk_switch_set_state;

// SymbolicPaintable
alias gtk_symbolic_paintable_get_type = c_gtk_symbolic_paintable_get_type;
alias gtk_symbolic_paintable_snapshot_symbolic = c_gtk_symbolic_paintable_snapshot_symbolic;

// Text
alias gtk_text_get_type = c_gtk_text_get_type;
alias gtk_text_new = c_gtk_text_new;
alias gtk_text_new_with_buffer = c_gtk_text_new_with_buffer;
alias gtk_text_compute_cursor_extents = c_gtk_text_compute_cursor_extents;
alias gtk_text_get_activates_default = c_gtk_text_get_activates_default;
alias gtk_text_get_attributes = c_gtk_text_get_attributes;
alias gtk_text_get_buffer = c_gtk_text_get_buffer;
alias gtk_text_get_enable_emoji_completion = c_gtk_text_get_enable_emoji_completion;
alias gtk_text_get_extra_menu = c_gtk_text_get_extra_menu;
alias gtk_text_get_input_hints = c_gtk_text_get_input_hints;
alias gtk_text_get_input_purpose = c_gtk_text_get_input_purpose;
alias gtk_text_get_invisible_char = c_gtk_text_get_invisible_char;
alias gtk_text_get_max_length = c_gtk_text_get_max_length;
alias gtk_text_get_overwrite_mode = c_gtk_text_get_overwrite_mode;
alias gtk_text_get_placeholder_text = c_gtk_text_get_placeholder_text;
alias gtk_text_get_propagate_text_width = c_gtk_text_get_propagate_text_width;
alias gtk_text_get_tabs = c_gtk_text_get_tabs;
alias gtk_text_get_text_length = c_gtk_text_get_text_length;
alias gtk_text_get_truncate_multiline = c_gtk_text_get_truncate_multiline;
alias gtk_text_get_visibility = c_gtk_text_get_visibility;
alias gtk_text_grab_focus_without_selecting = c_gtk_text_grab_focus_without_selecting;
alias gtk_text_set_activates_default = c_gtk_text_set_activates_default;
alias gtk_text_set_attributes = c_gtk_text_set_attributes;
alias gtk_text_set_buffer = c_gtk_text_set_buffer;
alias gtk_text_set_enable_emoji_completion = c_gtk_text_set_enable_emoji_completion;
alias gtk_text_set_extra_menu = c_gtk_text_set_extra_menu;
alias gtk_text_set_input_hints = c_gtk_text_set_input_hints;
alias gtk_text_set_input_purpose = c_gtk_text_set_input_purpose;
alias gtk_text_set_invisible_char = c_gtk_text_set_invisible_char;
alias gtk_text_set_max_length = c_gtk_text_set_max_length;
alias gtk_text_set_overwrite_mode = c_gtk_text_set_overwrite_mode;
alias gtk_text_set_placeholder_text = c_gtk_text_set_placeholder_text;
alias gtk_text_set_propagate_text_width = c_gtk_text_set_propagate_text_width;
alias gtk_text_set_tabs = c_gtk_text_set_tabs;
alias gtk_text_set_truncate_multiline = c_gtk_text_set_truncate_multiline;
alias gtk_text_set_visibility = c_gtk_text_set_visibility;
alias gtk_text_unset_invisible_char = c_gtk_text_unset_invisible_char;

// TextBuffer
alias gtk_text_buffer_get_type = c_gtk_text_buffer_get_type;
alias gtk_text_buffer_new = c_gtk_text_buffer_new;
alias gtk_text_buffer_add_mark = c_gtk_text_buffer_add_mark;
alias gtk_text_buffer_add_selection_clipboard = c_gtk_text_buffer_add_selection_clipboard;
alias gtk_text_buffer_apply_tag = c_gtk_text_buffer_apply_tag;
alias gtk_text_buffer_apply_tag_by_name = c_gtk_text_buffer_apply_tag_by_name;
alias gtk_text_buffer_backspace = c_gtk_text_buffer_backspace;
alias gtk_text_buffer_begin_irreversible_action = c_gtk_text_buffer_begin_irreversible_action;
alias gtk_text_buffer_begin_user_action = c_gtk_text_buffer_begin_user_action;
alias gtk_text_buffer_copy_clipboard = c_gtk_text_buffer_copy_clipboard;
alias gtk_text_buffer_create_child_anchor = c_gtk_text_buffer_create_child_anchor;
alias gtk_text_buffer_create_mark = c_gtk_text_buffer_create_mark;
alias gtk_text_buffer_create_tag = c_gtk_text_buffer_create_tag;
alias gtk_text_buffer_cut_clipboard = c_gtk_text_buffer_cut_clipboard;
alias gtk_text_buffer_delete = c_gtk_text_buffer_delete;
alias gtk_text_buffer_delete_interactive = c_gtk_text_buffer_delete_interactive;
alias gtk_text_buffer_delete_mark = c_gtk_text_buffer_delete_mark;
alias gtk_text_buffer_delete_mark_by_name = c_gtk_text_buffer_delete_mark_by_name;
alias gtk_text_buffer_delete_selection = c_gtk_text_buffer_delete_selection;
alias gtk_text_buffer_end_irreversible_action = c_gtk_text_buffer_end_irreversible_action;
alias gtk_text_buffer_end_user_action = c_gtk_text_buffer_end_user_action;
alias gtk_text_buffer_get_bounds = c_gtk_text_buffer_get_bounds;
alias gtk_text_buffer_get_can_redo = c_gtk_text_buffer_get_can_redo;
alias gtk_text_buffer_get_can_undo = c_gtk_text_buffer_get_can_undo;
alias gtk_text_buffer_get_char_count = c_gtk_text_buffer_get_char_count;
alias gtk_text_buffer_get_enable_undo = c_gtk_text_buffer_get_enable_undo;
alias gtk_text_buffer_get_end_iter = c_gtk_text_buffer_get_end_iter;
alias gtk_text_buffer_get_has_selection = c_gtk_text_buffer_get_has_selection;
alias gtk_text_buffer_get_insert = c_gtk_text_buffer_get_insert;
alias gtk_text_buffer_get_iter_at_child_anchor = c_gtk_text_buffer_get_iter_at_child_anchor;
alias gtk_text_buffer_get_iter_at_line = c_gtk_text_buffer_get_iter_at_line;
alias gtk_text_buffer_get_iter_at_line_index = c_gtk_text_buffer_get_iter_at_line_index;
alias gtk_text_buffer_get_iter_at_line_offset = c_gtk_text_buffer_get_iter_at_line_offset;
alias gtk_text_buffer_get_iter_at_mark = c_gtk_text_buffer_get_iter_at_mark;
alias gtk_text_buffer_get_iter_at_offset = c_gtk_text_buffer_get_iter_at_offset;
alias gtk_text_buffer_get_line_count = c_gtk_text_buffer_get_line_count;
alias gtk_text_buffer_get_mark = c_gtk_text_buffer_get_mark;
alias gtk_text_buffer_get_max_undo_levels = c_gtk_text_buffer_get_max_undo_levels;
alias gtk_text_buffer_get_modified = c_gtk_text_buffer_get_modified;
alias gtk_text_buffer_get_selection_bound = c_gtk_text_buffer_get_selection_bound;
alias gtk_text_buffer_get_selection_bounds = c_gtk_text_buffer_get_selection_bounds;
alias gtk_text_buffer_get_selection_content = c_gtk_text_buffer_get_selection_content;
alias gtk_text_buffer_get_slice = c_gtk_text_buffer_get_slice;
alias gtk_text_buffer_get_start_iter = c_gtk_text_buffer_get_start_iter;
alias gtk_text_buffer_get_tag_table = c_gtk_text_buffer_get_tag_table;
alias gtk_text_buffer_get_text = c_gtk_text_buffer_get_text;
alias gtk_text_buffer_insert = c_gtk_text_buffer_insert;
alias gtk_text_buffer_insert_at_cursor = c_gtk_text_buffer_insert_at_cursor;
alias gtk_text_buffer_insert_child_anchor = c_gtk_text_buffer_insert_child_anchor;
alias gtk_text_buffer_insert_interactive = c_gtk_text_buffer_insert_interactive;
alias gtk_text_buffer_insert_interactive_at_cursor = c_gtk_text_buffer_insert_interactive_at_cursor;
alias gtk_text_buffer_insert_markup = c_gtk_text_buffer_insert_markup;
alias gtk_text_buffer_insert_paintable = c_gtk_text_buffer_insert_paintable;
alias gtk_text_buffer_insert_range = c_gtk_text_buffer_insert_range;
alias gtk_text_buffer_insert_range_interactive = c_gtk_text_buffer_insert_range_interactive;
alias gtk_text_buffer_insert_with_tags = c_gtk_text_buffer_insert_with_tags;
alias gtk_text_buffer_insert_with_tags_by_name = c_gtk_text_buffer_insert_with_tags_by_name;
alias gtk_text_buffer_move_mark = c_gtk_text_buffer_move_mark;
alias gtk_text_buffer_move_mark_by_name = c_gtk_text_buffer_move_mark_by_name;
alias gtk_text_buffer_paste_clipboard = c_gtk_text_buffer_paste_clipboard;
alias gtk_text_buffer_place_cursor = c_gtk_text_buffer_place_cursor;
alias gtk_text_buffer_redo = c_gtk_text_buffer_redo;
alias gtk_text_buffer_remove_all_tags = c_gtk_text_buffer_remove_all_tags;
alias gtk_text_buffer_remove_selection_clipboard = c_gtk_text_buffer_remove_selection_clipboard;
alias gtk_text_buffer_remove_tag = c_gtk_text_buffer_remove_tag;
alias gtk_text_buffer_remove_tag_by_name = c_gtk_text_buffer_remove_tag_by_name;
alias gtk_text_buffer_select_range = c_gtk_text_buffer_select_range;
alias gtk_text_buffer_set_enable_undo = c_gtk_text_buffer_set_enable_undo;
alias gtk_text_buffer_set_max_undo_levels = c_gtk_text_buffer_set_max_undo_levels;
alias gtk_text_buffer_set_modified = c_gtk_text_buffer_set_modified;
alias gtk_text_buffer_set_text = c_gtk_text_buffer_set_text;
alias gtk_text_buffer_undo = c_gtk_text_buffer_undo;

// TextChildAnchor
alias gtk_text_child_anchor_get_type = c_gtk_text_child_anchor_get_type;
alias gtk_text_child_anchor_new = c_gtk_text_child_anchor_new;
alias gtk_text_child_anchor_new_with_replacement = c_gtk_text_child_anchor_new_with_replacement;
alias gtk_text_child_anchor_get_deleted = c_gtk_text_child_anchor_get_deleted;
alias gtk_text_child_anchor_get_widgets = c_gtk_text_child_anchor_get_widgets;

// TextIter
alias gtk_text_iter_get_type = c_gtk_text_iter_get_type;
alias gtk_text_iter_assign = c_gtk_text_iter_assign;
alias gtk_text_iter_backward_char = c_gtk_text_iter_backward_char;
alias gtk_text_iter_backward_chars = c_gtk_text_iter_backward_chars;
alias gtk_text_iter_backward_cursor_position = c_gtk_text_iter_backward_cursor_position;
alias gtk_text_iter_backward_cursor_positions = c_gtk_text_iter_backward_cursor_positions;
alias gtk_text_iter_backward_find_char = c_gtk_text_iter_backward_find_char;
alias gtk_text_iter_backward_line = c_gtk_text_iter_backward_line;
alias gtk_text_iter_backward_lines = c_gtk_text_iter_backward_lines;
alias gtk_text_iter_backward_search = c_gtk_text_iter_backward_search;
alias gtk_text_iter_backward_sentence_start = c_gtk_text_iter_backward_sentence_start;
alias gtk_text_iter_backward_sentence_starts = c_gtk_text_iter_backward_sentence_starts;
alias gtk_text_iter_backward_to_tag_toggle = c_gtk_text_iter_backward_to_tag_toggle;
alias gtk_text_iter_backward_visible_cursor_position = c_gtk_text_iter_backward_visible_cursor_position;
alias gtk_text_iter_backward_visible_cursor_positions = c_gtk_text_iter_backward_visible_cursor_positions;
alias gtk_text_iter_backward_visible_line = c_gtk_text_iter_backward_visible_line;
alias gtk_text_iter_backward_visible_lines = c_gtk_text_iter_backward_visible_lines;
alias gtk_text_iter_backward_visible_word_start = c_gtk_text_iter_backward_visible_word_start;
alias gtk_text_iter_backward_visible_word_starts = c_gtk_text_iter_backward_visible_word_starts;
alias gtk_text_iter_backward_word_start = c_gtk_text_iter_backward_word_start;
alias gtk_text_iter_backward_word_starts = c_gtk_text_iter_backward_word_starts;
alias gtk_text_iter_can_insert = c_gtk_text_iter_can_insert;
alias gtk_text_iter_compare = c_gtk_text_iter_compare;
alias gtk_text_iter_copy = c_gtk_text_iter_copy;
alias gtk_text_iter_editable = c_gtk_text_iter_editable;
alias gtk_text_iter_ends_line = c_gtk_text_iter_ends_line;
alias gtk_text_iter_ends_sentence = c_gtk_text_iter_ends_sentence;
alias gtk_text_iter_ends_tag = c_gtk_text_iter_ends_tag;
alias gtk_text_iter_ends_word = c_gtk_text_iter_ends_word;
alias gtk_text_iter_equal = c_gtk_text_iter_equal;
alias gtk_text_iter_forward_char = c_gtk_text_iter_forward_char;
alias gtk_text_iter_forward_chars = c_gtk_text_iter_forward_chars;
alias gtk_text_iter_forward_cursor_position = c_gtk_text_iter_forward_cursor_position;
alias gtk_text_iter_forward_cursor_positions = c_gtk_text_iter_forward_cursor_positions;
alias gtk_text_iter_forward_find_char = c_gtk_text_iter_forward_find_char;
alias gtk_text_iter_forward_line = c_gtk_text_iter_forward_line;
alias gtk_text_iter_forward_lines = c_gtk_text_iter_forward_lines;
alias gtk_text_iter_forward_search = c_gtk_text_iter_forward_search;
alias gtk_text_iter_forward_sentence_end = c_gtk_text_iter_forward_sentence_end;
alias gtk_text_iter_forward_sentence_ends = c_gtk_text_iter_forward_sentence_ends;
alias gtk_text_iter_forward_to_end = c_gtk_text_iter_forward_to_end;
alias gtk_text_iter_forward_to_line_end = c_gtk_text_iter_forward_to_line_end;
alias gtk_text_iter_forward_to_tag_toggle = c_gtk_text_iter_forward_to_tag_toggle;
alias gtk_text_iter_forward_visible_cursor_position = c_gtk_text_iter_forward_visible_cursor_position;
alias gtk_text_iter_forward_visible_cursor_positions = c_gtk_text_iter_forward_visible_cursor_positions;
alias gtk_text_iter_forward_visible_line = c_gtk_text_iter_forward_visible_line;
alias gtk_text_iter_forward_visible_lines = c_gtk_text_iter_forward_visible_lines;
alias gtk_text_iter_forward_visible_word_end = c_gtk_text_iter_forward_visible_word_end;
alias gtk_text_iter_forward_visible_word_ends = c_gtk_text_iter_forward_visible_word_ends;
alias gtk_text_iter_forward_word_end = c_gtk_text_iter_forward_word_end;
alias gtk_text_iter_forward_word_ends = c_gtk_text_iter_forward_word_ends;
alias gtk_text_iter_free = c_gtk_text_iter_free;
alias gtk_text_iter_get_buffer = c_gtk_text_iter_get_buffer;
alias gtk_text_iter_get_bytes_in_line = c_gtk_text_iter_get_bytes_in_line;
alias gtk_text_iter_get_char = c_gtk_text_iter_get_char;
alias gtk_text_iter_get_chars_in_line = c_gtk_text_iter_get_chars_in_line;
alias gtk_text_iter_get_child_anchor = c_gtk_text_iter_get_child_anchor;
alias gtk_text_iter_get_language = c_gtk_text_iter_get_language;
alias gtk_text_iter_get_line = c_gtk_text_iter_get_line;
alias gtk_text_iter_get_line_index = c_gtk_text_iter_get_line_index;
alias gtk_text_iter_get_line_offset = c_gtk_text_iter_get_line_offset;
alias gtk_text_iter_get_marks = c_gtk_text_iter_get_marks;
alias gtk_text_iter_get_offset = c_gtk_text_iter_get_offset;
alias gtk_text_iter_get_paintable = c_gtk_text_iter_get_paintable;
alias gtk_text_iter_get_slice = c_gtk_text_iter_get_slice;
alias gtk_text_iter_get_tags = c_gtk_text_iter_get_tags;
alias gtk_text_iter_get_text = c_gtk_text_iter_get_text;
alias gtk_text_iter_get_toggled_tags = c_gtk_text_iter_get_toggled_tags;
alias gtk_text_iter_get_visible_line_index = c_gtk_text_iter_get_visible_line_index;
alias gtk_text_iter_get_visible_line_offset = c_gtk_text_iter_get_visible_line_offset;
alias gtk_text_iter_get_visible_slice = c_gtk_text_iter_get_visible_slice;
alias gtk_text_iter_get_visible_text = c_gtk_text_iter_get_visible_text;
alias gtk_text_iter_has_tag = c_gtk_text_iter_has_tag;
alias gtk_text_iter_in_range = c_gtk_text_iter_in_range;
alias gtk_text_iter_inside_sentence = c_gtk_text_iter_inside_sentence;
alias gtk_text_iter_inside_word = c_gtk_text_iter_inside_word;
alias gtk_text_iter_is_cursor_position = c_gtk_text_iter_is_cursor_position;
alias gtk_text_iter_is_end = c_gtk_text_iter_is_end;
alias gtk_text_iter_is_start = c_gtk_text_iter_is_start;
alias gtk_text_iter_order = c_gtk_text_iter_order;
alias gtk_text_iter_set_line = c_gtk_text_iter_set_line;
alias gtk_text_iter_set_line_index = c_gtk_text_iter_set_line_index;
alias gtk_text_iter_set_line_offset = c_gtk_text_iter_set_line_offset;
alias gtk_text_iter_set_offset = c_gtk_text_iter_set_offset;
alias gtk_text_iter_set_visible_line_index = c_gtk_text_iter_set_visible_line_index;
alias gtk_text_iter_set_visible_line_offset = c_gtk_text_iter_set_visible_line_offset;
alias gtk_text_iter_starts_line = c_gtk_text_iter_starts_line;
alias gtk_text_iter_starts_sentence = c_gtk_text_iter_starts_sentence;
alias gtk_text_iter_starts_tag = c_gtk_text_iter_starts_tag;
alias gtk_text_iter_starts_word = c_gtk_text_iter_starts_word;
alias gtk_text_iter_toggles_tag = c_gtk_text_iter_toggles_tag;

// TextMark
alias gtk_text_mark_get_type = c_gtk_text_mark_get_type;
alias gtk_text_mark_new = c_gtk_text_mark_new;
alias gtk_text_mark_get_buffer = c_gtk_text_mark_get_buffer;
alias gtk_text_mark_get_deleted = c_gtk_text_mark_get_deleted;
alias gtk_text_mark_get_left_gravity = c_gtk_text_mark_get_left_gravity;
alias gtk_text_mark_get_name = c_gtk_text_mark_get_name;
alias gtk_text_mark_get_visible = c_gtk_text_mark_get_visible;
alias gtk_text_mark_set_visible = c_gtk_text_mark_set_visible;

// TextTag
alias gtk_text_tag_get_type = c_gtk_text_tag_get_type;
alias gtk_text_tag_new = c_gtk_text_tag_new;
alias gtk_text_tag_changed = c_gtk_text_tag_changed;
alias gtk_text_tag_get_priority = c_gtk_text_tag_get_priority;
alias gtk_text_tag_set_priority = c_gtk_text_tag_set_priority;

// TextTagTable
alias gtk_text_tag_table_get_type = c_gtk_text_tag_table_get_type;
alias gtk_text_tag_table_new = c_gtk_text_tag_table_new;
alias gtk_text_tag_table_add = c_gtk_text_tag_table_add;
alias gtk_text_tag_table_foreach = c_gtk_text_tag_table_foreach;
alias gtk_text_tag_table_get_size = c_gtk_text_tag_table_get_size;
alias gtk_text_tag_table_lookup = c_gtk_text_tag_table_lookup;
alias gtk_text_tag_table_remove = c_gtk_text_tag_table_remove;

// TextView
alias gtk_text_view_get_type = c_gtk_text_view_get_type;
alias gtk_text_view_new = c_gtk_text_view_new;
alias gtk_text_view_new_with_buffer = c_gtk_text_view_new_with_buffer;
alias gtk_text_view_add_child_at_anchor = c_gtk_text_view_add_child_at_anchor;
alias gtk_text_view_add_overlay = c_gtk_text_view_add_overlay;
alias gtk_text_view_backward_display_line = c_gtk_text_view_backward_display_line;
alias gtk_text_view_backward_display_line_start = c_gtk_text_view_backward_display_line_start;
alias gtk_text_view_buffer_to_window_coords = c_gtk_text_view_buffer_to_window_coords;
alias gtk_text_view_forward_display_line = c_gtk_text_view_forward_display_line;
alias gtk_text_view_forward_display_line_end = c_gtk_text_view_forward_display_line_end;
alias gtk_text_view_get_accepts_tab = c_gtk_text_view_get_accepts_tab;
alias gtk_text_view_get_bottom_margin = c_gtk_text_view_get_bottom_margin;
alias gtk_text_view_get_buffer = c_gtk_text_view_get_buffer;
alias gtk_text_view_get_cursor_locations = c_gtk_text_view_get_cursor_locations;
alias gtk_text_view_get_cursor_visible = c_gtk_text_view_get_cursor_visible;
alias gtk_text_view_get_editable = c_gtk_text_view_get_editable;
alias gtk_text_view_get_extra_menu = c_gtk_text_view_get_extra_menu;
alias gtk_text_view_get_gutter = c_gtk_text_view_get_gutter;
alias gtk_text_view_get_indent = c_gtk_text_view_get_indent;
alias gtk_text_view_get_input_hints = c_gtk_text_view_get_input_hints;
alias gtk_text_view_get_input_purpose = c_gtk_text_view_get_input_purpose;
alias gtk_text_view_get_iter_at_location = c_gtk_text_view_get_iter_at_location;
alias gtk_text_view_get_iter_at_position = c_gtk_text_view_get_iter_at_position;
alias gtk_text_view_get_iter_location = c_gtk_text_view_get_iter_location;
alias gtk_text_view_get_justification = c_gtk_text_view_get_justification;
alias gtk_text_view_get_left_margin = c_gtk_text_view_get_left_margin;
alias gtk_text_view_get_line_at_y = c_gtk_text_view_get_line_at_y;
alias gtk_text_view_get_line_yrange = c_gtk_text_view_get_line_yrange;
alias gtk_text_view_get_ltr_context = c_gtk_text_view_get_ltr_context;
alias gtk_text_view_get_monospace = c_gtk_text_view_get_monospace;
alias gtk_text_view_get_overwrite = c_gtk_text_view_get_overwrite;
alias gtk_text_view_get_pixels_above_lines = c_gtk_text_view_get_pixels_above_lines;
alias gtk_text_view_get_pixels_below_lines = c_gtk_text_view_get_pixels_below_lines;
alias gtk_text_view_get_pixels_inside_wrap = c_gtk_text_view_get_pixels_inside_wrap;
alias gtk_text_view_get_right_margin = c_gtk_text_view_get_right_margin;
alias gtk_text_view_get_rtl_context = c_gtk_text_view_get_rtl_context;
alias gtk_text_view_get_tabs = c_gtk_text_view_get_tabs;
alias gtk_text_view_get_top_margin = c_gtk_text_view_get_top_margin;
alias gtk_text_view_get_visible_rect = c_gtk_text_view_get_visible_rect;
alias gtk_text_view_get_wrap_mode = c_gtk_text_view_get_wrap_mode;
alias gtk_text_view_im_context_filter_keypress = c_gtk_text_view_im_context_filter_keypress;
alias gtk_text_view_move_mark_onscreen = c_gtk_text_view_move_mark_onscreen;
alias gtk_text_view_move_overlay = c_gtk_text_view_move_overlay;
alias gtk_text_view_move_visually = c_gtk_text_view_move_visually;
alias gtk_text_view_place_cursor_onscreen = c_gtk_text_view_place_cursor_onscreen;
alias gtk_text_view_remove = c_gtk_text_view_remove;
alias gtk_text_view_reset_cursor_blink = c_gtk_text_view_reset_cursor_blink;
alias gtk_text_view_reset_im_context = c_gtk_text_view_reset_im_context;
alias gtk_text_view_scroll_mark_onscreen = c_gtk_text_view_scroll_mark_onscreen;
alias gtk_text_view_scroll_to_iter = c_gtk_text_view_scroll_to_iter;
alias gtk_text_view_scroll_to_mark = c_gtk_text_view_scroll_to_mark;
alias gtk_text_view_set_accepts_tab = c_gtk_text_view_set_accepts_tab;
alias gtk_text_view_set_bottom_margin = c_gtk_text_view_set_bottom_margin;
alias gtk_text_view_set_buffer = c_gtk_text_view_set_buffer;
alias gtk_text_view_set_cursor_visible = c_gtk_text_view_set_cursor_visible;
alias gtk_text_view_set_editable = c_gtk_text_view_set_editable;
alias gtk_text_view_set_extra_menu = c_gtk_text_view_set_extra_menu;
alias gtk_text_view_set_gutter = c_gtk_text_view_set_gutter;
alias gtk_text_view_set_indent = c_gtk_text_view_set_indent;
alias gtk_text_view_set_input_hints = c_gtk_text_view_set_input_hints;
alias gtk_text_view_set_input_purpose = c_gtk_text_view_set_input_purpose;
alias gtk_text_view_set_justification = c_gtk_text_view_set_justification;
alias gtk_text_view_set_left_margin = c_gtk_text_view_set_left_margin;
alias gtk_text_view_set_monospace = c_gtk_text_view_set_monospace;
alias gtk_text_view_set_overwrite = c_gtk_text_view_set_overwrite;
alias gtk_text_view_set_pixels_above_lines = c_gtk_text_view_set_pixels_above_lines;
alias gtk_text_view_set_pixels_below_lines = c_gtk_text_view_set_pixels_below_lines;
alias gtk_text_view_set_pixels_inside_wrap = c_gtk_text_view_set_pixels_inside_wrap;
alias gtk_text_view_set_right_margin = c_gtk_text_view_set_right_margin;
alias gtk_text_view_set_tabs = c_gtk_text_view_set_tabs;
alias gtk_text_view_set_top_margin = c_gtk_text_view_set_top_margin;
alias gtk_text_view_set_wrap_mode = c_gtk_text_view_set_wrap_mode;
alias gtk_text_view_starts_display_line = c_gtk_text_view_starts_display_line;
alias gtk_text_view_window_to_buffer_coords = c_gtk_text_view_window_to_buffer_coords;

// ToggleButton
alias gtk_toggle_button_get_type = c_gtk_toggle_button_get_type;
alias gtk_toggle_button_new = c_gtk_toggle_button_new;
alias gtk_toggle_button_new_with_label = c_gtk_toggle_button_new_with_label;
alias gtk_toggle_button_new_with_mnemonic = c_gtk_toggle_button_new_with_mnemonic;
alias gtk_toggle_button_get_active = c_gtk_toggle_button_get_active;
alias gtk_toggle_button_set_active = c_gtk_toggle_button_set_active;
alias gtk_toggle_button_set_group = c_gtk_toggle_button_set_group;
alias gtk_toggle_button_toggled = c_gtk_toggle_button_toggled;

// Tooltip
alias gtk_tooltip_get_type = c_gtk_tooltip_get_type;
alias gtk_tooltip_set_custom = c_gtk_tooltip_set_custom;
alias gtk_tooltip_set_icon = c_gtk_tooltip_set_icon;
alias gtk_tooltip_set_icon_from_gicon = c_gtk_tooltip_set_icon_from_gicon;
alias gtk_tooltip_set_icon_from_icon_name = c_gtk_tooltip_set_icon_from_icon_name;
alias gtk_tooltip_set_markup = c_gtk_tooltip_set_markup;
alias gtk_tooltip_set_text = c_gtk_tooltip_set_text;
alias gtk_tooltip_set_tip_area = c_gtk_tooltip_set_tip_area;

// TreeDragDest
alias gtk_tree_drag_dest_get_type = c_gtk_tree_drag_dest_get_type;
alias gtk_tree_drag_dest_drag_data_received = c_gtk_tree_drag_dest_drag_data_received;
alias gtk_tree_drag_dest_row_drop_possible = c_gtk_tree_drag_dest_row_drop_possible;

// TreeDragSource
alias gtk_tree_drag_source_get_type = c_gtk_tree_drag_source_get_type;
alias gtk_tree_drag_source_drag_data_delete = c_gtk_tree_drag_source_drag_data_delete;
alias gtk_tree_drag_source_drag_data_get = c_gtk_tree_drag_source_drag_data_get;
alias gtk_tree_drag_source_row_draggable = c_gtk_tree_drag_source_row_draggable;

// TreeExpander
alias gtk_tree_expander_get_type = c_gtk_tree_expander_get_type;
alias gtk_tree_expander_new = c_gtk_tree_expander_new;
alias gtk_tree_expander_get_child = c_gtk_tree_expander_get_child;
alias gtk_tree_expander_get_hide_expander = c_gtk_tree_expander_get_hide_expander;
alias gtk_tree_expander_get_indent_for_depth = c_gtk_tree_expander_get_indent_for_depth;
alias gtk_tree_expander_get_indent_for_icon = c_gtk_tree_expander_get_indent_for_icon;
alias gtk_tree_expander_get_item = c_gtk_tree_expander_get_item;
alias gtk_tree_expander_get_list_row = c_gtk_tree_expander_get_list_row;
alias gtk_tree_expander_set_child = c_gtk_tree_expander_set_child;
alias gtk_tree_expander_set_hide_expander = c_gtk_tree_expander_set_hide_expander;
alias gtk_tree_expander_set_indent_for_depth = c_gtk_tree_expander_set_indent_for_depth;
alias gtk_tree_expander_set_indent_for_icon = c_gtk_tree_expander_set_indent_for_icon;
alias gtk_tree_expander_set_list_row = c_gtk_tree_expander_set_list_row;

// TreeIter
alias gtk_tree_iter_get_type = c_gtk_tree_iter_get_type;
alias gtk_tree_iter_copy = c_gtk_tree_iter_copy;
alias gtk_tree_iter_free = c_gtk_tree_iter_free;

// TreeListModel
alias gtk_tree_list_model_get_type = c_gtk_tree_list_model_get_type;
alias gtk_tree_list_model_new = c_gtk_tree_list_model_new;
alias gtk_tree_list_model_get_autoexpand = c_gtk_tree_list_model_get_autoexpand;
alias gtk_tree_list_model_get_child_row = c_gtk_tree_list_model_get_child_row;
alias gtk_tree_list_model_get_model = c_gtk_tree_list_model_get_model;
alias gtk_tree_list_model_get_passthrough = c_gtk_tree_list_model_get_passthrough;
alias gtk_tree_list_model_get_row = c_gtk_tree_list_model_get_row;
alias gtk_tree_list_model_set_autoexpand = c_gtk_tree_list_model_set_autoexpand;

// TreeListRow
alias gtk_tree_list_row_get_type = c_gtk_tree_list_row_get_type;
alias gtk_tree_list_row_get_child_row = c_gtk_tree_list_row_get_child_row;
alias gtk_tree_list_row_get_children = c_gtk_tree_list_row_get_children;
alias gtk_tree_list_row_get_depth = c_gtk_tree_list_row_get_depth;
alias gtk_tree_list_row_get_expanded = c_gtk_tree_list_row_get_expanded;
alias gtk_tree_list_row_get_item = c_gtk_tree_list_row_get_item;
alias gtk_tree_list_row_get_parent = c_gtk_tree_list_row_get_parent;
alias gtk_tree_list_row_get_position = c_gtk_tree_list_row_get_position;
alias gtk_tree_list_row_is_expandable = c_gtk_tree_list_row_is_expandable;
alias gtk_tree_list_row_set_expanded = c_gtk_tree_list_row_set_expanded;

// TreeListRowSorter
alias gtk_tree_list_row_sorter_get_type = c_gtk_tree_list_row_sorter_get_type;
alias gtk_tree_list_row_sorter_new = c_gtk_tree_list_row_sorter_new;
alias gtk_tree_list_row_sorter_get_sorter = c_gtk_tree_list_row_sorter_get_sorter;
alias gtk_tree_list_row_sorter_set_sorter = c_gtk_tree_list_row_sorter_set_sorter;

// TreeModel
alias gtk_tree_model_get_type = c_gtk_tree_model_get_type;
alias gtk_tree_model_filter_new = c_gtk_tree_model_filter_new;
alias gtk_tree_model_foreach = c_gtk_tree_model_foreach;
alias gtk_tree_model_get = c_gtk_tree_model_get;
alias gtk_tree_model_get_column_type = c_gtk_tree_model_get_column_type;
alias gtk_tree_model_get_flags = c_gtk_tree_model_get_flags;
alias gtk_tree_model_get_iter = c_gtk_tree_model_get_iter;
alias gtk_tree_model_get_iter_first = c_gtk_tree_model_get_iter_first;
alias gtk_tree_model_get_iter_from_string = c_gtk_tree_model_get_iter_from_string;
alias gtk_tree_model_get_n_columns = c_gtk_tree_model_get_n_columns;
alias gtk_tree_model_get_path = c_gtk_tree_model_get_path;
alias gtk_tree_model_get_string_from_iter = c_gtk_tree_model_get_string_from_iter;
alias gtk_tree_model_get_valist = c_gtk_tree_model_get_valist;
alias gtk_tree_model_get_value = c_gtk_tree_model_get_value;
alias gtk_tree_model_iter_children = c_gtk_tree_model_iter_children;
alias gtk_tree_model_iter_has_child = c_gtk_tree_model_iter_has_child;
alias gtk_tree_model_iter_n_children = c_gtk_tree_model_iter_n_children;
alias gtk_tree_model_iter_next = c_gtk_tree_model_iter_next;
alias gtk_tree_model_iter_nth_child = c_gtk_tree_model_iter_nth_child;
alias gtk_tree_model_iter_parent = c_gtk_tree_model_iter_parent;
alias gtk_tree_model_iter_previous = c_gtk_tree_model_iter_previous;
alias gtk_tree_model_ref_node = c_gtk_tree_model_ref_node;
alias gtk_tree_model_row_changed = c_gtk_tree_model_row_changed;
alias gtk_tree_model_row_deleted = c_gtk_tree_model_row_deleted;
alias gtk_tree_model_row_has_child_toggled = c_gtk_tree_model_row_has_child_toggled;
alias gtk_tree_model_row_inserted = c_gtk_tree_model_row_inserted;
alias gtk_tree_model_rows_reordered = c_gtk_tree_model_rows_reordered;
alias gtk_tree_model_rows_reordered_with_length = c_gtk_tree_model_rows_reordered_with_length;
alias gtk_tree_model_unref_node = c_gtk_tree_model_unref_node;

// TreeModelFilter
alias gtk_tree_model_filter_get_type = c_gtk_tree_model_filter_get_type;
alias gtk_tree_model_filter_clear_cache = c_gtk_tree_model_filter_clear_cache;
alias gtk_tree_model_filter_convert_child_iter_to_iter = c_gtk_tree_model_filter_convert_child_iter_to_iter;
alias gtk_tree_model_filter_convert_child_path_to_path = c_gtk_tree_model_filter_convert_child_path_to_path;
alias gtk_tree_model_filter_convert_iter_to_child_iter = c_gtk_tree_model_filter_convert_iter_to_child_iter;
alias gtk_tree_model_filter_convert_path_to_child_path = c_gtk_tree_model_filter_convert_path_to_child_path;
alias gtk_tree_model_filter_get_model = c_gtk_tree_model_filter_get_model;
alias gtk_tree_model_filter_refilter = c_gtk_tree_model_filter_refilter;
alias gtk_tree_model_filter_set_modify_func = c_gtk_tree_model_filter_set_modify_func;
alias gtk_tree_model_filter_set_visible_column = c_gtk_tree_model_filter_set_visible_column;
alias gtk_tree_model_filter_set_visible_func = c_gtk_tree_model_filter_set_visible_func;

// TreeModelSort
alias gtk_tree_model_sort_get_type = c_gtk_tree_model_sort_get_type;
alias gtk_tree_model_sort_new_with_model = c_gtk_tree_model_sort_new_with_model;
alias gtk_tree_model_sort_clear_cache = c_gtk_tree_model_sort_clear_cache;
alias gtk_tree_model_sort_convert_child_iter_to_iter = c_gtk_tree_model_sort_convert_child_iter_to_iter;
alias gtk_tree_model_sort_convert_child_path_to_path = c_gtk_tree_model_sort_convert_child_path_to_path;
alias gtk_tree_model_sort_convert_iter_to_child_iter = c_gtk_tree_model_sort_convert_iter_to_child_iter;
alias gtk_tree_model_sort_convert_path_to_child_path = c_gtk_tree_model_sort_convert_path_to_child_path;
alias gtk_tree_model_sort_get_model = c_gtk_tree_model_sort_get_model;
alias gtk_tree_model_sort_iter_is_valid = c_gtk_tree_model_sort_iter_is_valid;
alias gtk_tree_model_sort_reset_default_sort_func = c_gtk_tree_model_sort_reset_default_sort_func;

// TreePath
alias gtk_tree_path_get_type = c_gtk_tree_path_get_type;
alias gtk_tree_path_new = c_gtk_tree_path_new;
alias gtk_tree_path_new_first = c_gtk_tree_path_new_first;
alias gtk_tree_path_new_from_indices = c_gtk_tree_path_new_from_indices;
alias gtk_tree_path_new_from_indicesv = c_gtk_tree_path_new_from_indicesv;
alias gtk_tree_path_new_from_string = c_gtk_tree_path_new_from_string;
alias gtk_tree_path_append_index = c_gtk_tree_path_append_index;
alias gtk_tree_path_compare = c_gtk_tree_path_compare;
alias gtk_tree_path_copy = c_gtk_tree_path_copy;
alias gtk_tree_path_down = c_gtk_tree_path_down;
alias gtk_tree_path_free = c_gtk_tree_path_free;
alias gtk_tree_path_get_depth = c_gtk_tree_path_get_depth;
alias gtk_tree_path_get_indices = c_gtk_tree_path_get_indices;
alias gtk_tree_path_get_indices_with_depth = c_gtk_tree_path_get_indices_with_depth;
alias gtk_tree_path_is_ancestor = c_gtk_tree_path_is_ancestor;
alias gtk_tree_path_is_descendant = c_gtk_tree_path_is_descendant;
alias gtk_tree_path_next = c_gtk_tree_path_next;
alias gtk_tree_path_prepend_index = c_gtk_tree_path_prepend_index;
alias gtk_tree_path_prev = c_gtk_tree_path_prev;
alias gtk_tree_path_to_string = c_gtk_tree_path_to_string;
alias gtk_tree_path_up = c_gtk_tree_path_up;

// TreeRowReference
alias gtk_tree_row_reference_get_type = c_gtk_tree_row_reference_get_type;
alias gtk_tree_row_reference_new = c_gtk_tree_row_reference_new;
alias gtk_tree_row_reference_new_proxy = c_gtk_tree_row_reference_new_proxy;
alias gtk_tree_row_reference_copy = c_gtk_tree_row_reference_copy;
alias gtk_tree_row_reference_free = c_gtk_tree_row_reference_free;
alias gtk_tree_row_reference_get_model = c_gtk_tree_row_reference_get_model;
alias gtk_tree_row_reference_get_path = c_gtk_tree_row_reference_get_path;
alias gtk_tree_row_reference_valid = c_gtk_tree_row_reference_valid;
alias gtk_tree_row_reference_deleted = c_gtk_tree_row_reference_deleted;
alias gtk_tree_row_reference_inserted = c_gtk_tree_row_reference_inserted;
alias gtk_tree_row_reference_reordered = c_gtk_tree_row_reference_reordered;

// TreeSelection
alias gtk_tree_selection_get_type = c_gtk_tree_selection_get_type;
alias gtk_tree_selection_count_selected_rows = c_gtk_tree_selection_count_selected_rows;
alias gtk_tree_selection_get_mode = c_gtk_tree_selection_get_mode;
alias gtk_tree_selection_get_select_function = c_gtk_tree_selection_get_select_function;
alias gtk_tree_selection_get_selected = c_gtk_tree_selection_get_selected;
alias gtk_tree_selection_get_selected_rows = c_gtk_tree_selection_get_selected_rows;
alias gtk_tree_selection_get_tree_view = c_gtk_tree_selection_get_tree_view;
alias gtk_tree_selection_get_user_data = c_gtk_tree_selection_get_user_data;
alias gtk_tree_selection_iter_is_selected = c_gtk_tree_selection_iter_is_selected;
alias gtk_tree_selection_path_is_selected = c_gtk_tree_selection_path_is_selected;
alias gtk_tree_selection_select_all = c_gtk_tree_selection_select_all;
alias gtk_tree_selection_select_iter = c_gtk_tree_selection_select_iter;
alias gtk_tree_selection_select_path = c_gtk_tree_selection_select_path;
alias gtk_tree_selection_select_range = c_gtk_tree_selection_select_range;
alias gtk_tree_selection_selected_foreach = c_gtk_tree_selection_selected_foreach;
alias gtk_tree_selection_set_mode = c_gtk_tree_selection_set_mode;
alias gtk_tree_selection_set_select_function = c_gtk_tree_selection_set_select_function;
alias gtk_tree_selection_unselect_all = c_gtk_tree_selection_unselect_all;
alias gtk_tree_selection_unselect_iter = c_gtk_tree_selection_unselect_iter;
alias gtk_tree_selection_unselect_path = c_gtk_tree_selection_unselect_path;
alias gtk_tree_selection_unselect_range = c_gtk_tree_selection_unselect_range;

// TreeSortable
alias gtk_tree_sortable_get_type = c_gtk_tree_sortable_get_type;
alias gtk_tree_sortable_get_sort_column_id = c_gtk_tree_sortable_get_sort_column_id;
alias gtk_tree_sortable_has_default_sort_func = c_gtk_tree_sortable_has_default_sort_func;
alias gtk_tree_sortable_set_default_sort_func = c_gtk_tree_sortable_set_default_sort_func;
alias gtk_tree_sortable_set_sort_column_id = c_gtk_tree_sortable_set_sort_column_id;
alias gtk_tree_sortable_set_sort_func = c_gtk_tree_sortable_set_sort_func;
alias gtk_tree_sortable_sort_column_changed = c_gtk_tree_sortable_sort_column_changed;

// TreeStore
alias gtk_tree_store_get_type = c_gtk_tree_store_get_type;
alias gtk_tree_store_new = c_gtk_tree_store_new;
alias gtk_tree_store_newv = c_gtk_tree_store_newv;
alias gtk_tree_store_append = c_gtk_tree_store_append;
alias gtk_tree_store_clear = c_gtk_tree_store_clear;
alias gtk_tree_store_insert = c_gtk_tree_store_insert;
alias gtk_tree_store_insert_after = c_gtk_tree_store_insert_after;
alias gtk_tree_store_insert_before = c_gtk_tree_store_insert_before;
alias gtk_tree_store_insert_with_values = c_gtk_tree_store_insert_with_values;
alias gtk_tree_store_insert_with_valuesv = c_gtk_tree_store_insert_with_valuesv;
alias gtk_tree_store_is_ancestor = c_gtk_tree_store_is_ancestor;
alias gtk_tree_store_iter_depth = c_gtk_tree_store_iter_depth;
alias gtk_tree_store_iter_is_valid = c_gtk_tree_store_iter_is_valid;
alias gtk_tree_store_move_after = c_gtk_tree_store_move_after;
alias gtk_tree_store_move_before = c_gtk_tree_store_move_before;
alias gtk_tree_store_prepend = c_gtk_tree_store_prepend;
alias gtk_tree_store_remove = c_gtk_tree_store_remove;
alias gtk_tree_store_reorder = c_gtk_tree_store_reorder;
alias gtk_tree_store_set = c_gtk_tree_store_set;
alias gtk_tree_store_set_column_types = c_gtk_tree_store_set_column_types;
alias gtk_tree_store_set_valist = c_gtk_tree_store_set_valist;
alias gtk_tree_store_set_value = c_gtk_tree_store_set_value;
alias gtk_tree_store_set_valuesv = c_gtk_tree_store_set_valuesv;
alias gtk_tree_store_swap = c_gtk_tree_store_swap;

// TreeView
alias gtk_tree_view_get_type = c_gtk_tree_view_get_type;
alias gtk_tree_view_new = c_gtk_tree_view_new;
alias gtk_tree_view_new_with_model = c_gtk_tree_view_new_with_model;
alias gtk_tree_view_append_column = c_gtk_tree_view_append_column;
alias gtk_tree_view_collapse_all = c_gtk_tree_view_collapse_all;
alias gtk_tree_view_collapse_row = c_gtk_tree_view_collapse_row;
alias gtk_tree_view_columns_autosize = c_gtk_tree_view_columns_autosize;
alias gtk_tree_view_convert_bin_window_to_tree_coords = c_gtk_tree_view_convert_bin_window_to_tree_coords;
alias gtk_tree_view_convert_bin_window_to_widget_coords = c_gtk_tree_view_convert_bin_window_to_widget_coords;
alias gtk_tree_view_convert_tree_to_bin_window_coords = c_gtk_tree_view_convert_tree_to_bin_window_coords;
alias gtk_tree_view_convert_tree_to_widget_coords = c_gtk_tree_view_convert_tree_to_widget_coords;
alias gtk_tree_view_convert_widget_to_bin_window_coords = c_gtk_tree_view_convert_widget_to_bin_window_coords;
alias gtk_tree_view_convert_widget_to_tree_coords = c_gtk_tree_view_convert_widget_to_tree_coords;
alias gtk_tree_view_create_row_drag_icon = c_gtk_tree_view_create_row_drag_icon;
alias gtk_tree_view_enable_model_drag_dest = c_gtk_tree_view_enable_model_drag_dest;
alias gtk_tree_view_enable_model_drag_source = c_gtk_tree_view_enable_model_drag_source;
alias gtk_tree_view_expand_all = c_gtk_tree_view_expand_all;
alias gtk_tree_view_expand_row = c_gtk_tree_view_expand_row;
alias gtk_tree_view_expand_to_path = c_gtk_tree_view_expand_to_path;
alias gtk_tree_view_get_activate_on_single_click = c_gtk_tree_view_get_activate_on_single_click;
alias gtk_tree_view_get_background_area = c_gtk_tree_view_get_background_area;
alias gtk_tree_view_get_cell_area = c_gtk_tree_view_get_cell_area;
alias gtk_tree_view_get_column = c_gtk_tree_view_get_column;
alias gtk_tree_view_get_columns = c_gtk_tree_view_get_columns;
alias gtk_tree_view_get_cursor = c_gtk_tree_view_get_cursor;
alias gtk_tree_view_get_dest_row_at_pos = c_gtk_tree_view_get_dest_row_at_pos;
alias gtk_tree_view_get_drag_dest_row = c_gtk_tree_view_get_drag_dest_row;
alias gtk_tree_view_get_enable_search = c_gtk_tree_view_get_enable_search;
alias gtk_tree_view_get_enable_tree_lines = c_gtk_tree_view_get_enable_tree_lines;
alias gtk_tree_view_get_expander_column = c_gtk_tree_view_get_expander_column;
alias gtk_tree_view_get_fixed_height_mode = c_gtk_tree_view_get_fixed_height_mode;
alias gtk_tree_view_get_grid_lines = c_gtk_tree_view_get_grid_lines;
alias gtk_tree_view_get_headers_clickable = c_gtk_tree_view_get_headers_clickable;
alias gtk_tree_view_get_headers_visible = c_gtk_tree_view_get_headers_visible;
alias gtk_tree_view_get_hover_expand = c_gtk_tree_view_get_hover_expand;
alias gtk_tree_view_get_hover_selection = c_gtk_tree_view_get_hover_selection;
alias gtk_tree_view_get_level_indentation = c_gtk_tree_view_get_level_indentation;
alias gtk_tree_view_get_model = c_gtk_tree_view_get_model;
alias gtk_tree_view_get_n_columns = c_gtk_tree_view_get_n_columns;
alias gtk_tree_view_get_path_at_pos = c_gtk_tree_view_get_path_at_pos;
alias gtk_tree_view_get_reorderable = c_gtk_tree_view_get_reorderable;
alias gtk_tree_view_get_row_separator_func = c_gtk_tree_view_get_row_separator_func;
alias gtk_tree_view_get_rubber_banding = c_gtk_tree_view_get_rubber_banding;
alias gtk_tree_view_get_search_column = c_gtk_tree_view_get_search_column;
alias gtk_tree_view_get_search_entry = c_gtk_tree_view_get_search_entry;
alias gtk_tree_view_get_search_equal_func = c_gtk_tree_view_get_search_equal_func;
alias gtk_tree_view_get_selection = c_gtk_tree_view_get_selection;
alias gtk_tree_view_get_show_expanders = c_gtk_tree_view_get_show_expanders;
alias gtk_tree_view_get_tooltip_column = c_gtk_tree_view_get_tooltip_column;
alias gtk_tree_view_get_tooltip_context = c_gtk_tree_view_get_tooltip_context;
alias gtk_tree_view_get_visible_range = c_gtk_tree_view_get_visible_range;
alias gtk_tree_view_get_visible_rect = c_gtk_tree_view_get_visible_rect;
alias gtk_tree_view_insert_column = c_gtk_tree_view_insert_column;
alias gtk_tree_view_insert_column_with_attributes = c_gtk_tree_view_insert_column_with_attributes;
alias gtk_tree_view_insert_column_with_data_func = c_gtk_tree_view_insert_column_with_data_func;
alias gtk_tree_view_is_blank_at_pos = c_gtk_tree_view_is_blank_at_pos;
alias gtk_tree_view_is_rubber_banding_active = c_gtk_tree_view_is_rubber_banding_active;
alias gtk_tree_view_map_expanded_rows = c_gtk_tree_view_map_expanded_rows;
alias gtk_tree_view_move_column_after = c_gtk_tree_view_move_column_after;
alias gtk_tree_view_remove_column = c_gtk_tree_view_remove_column;
alias gtk_tree_view_row_activated = c_gtk_tree_view_row_activated;
alias gtk_tree_view_row_expanded = c_gtk_tree_view_row_expanded;
alias gtk_tree_view_scroll_to_cell = c_gtk_tree_view_scroll_to_cell;
alias gtk_tree_view_scroll_to_point = c_gtk_tree_view_scroll_to_point;
alias gtk_tree_view_set_activate_on_single_click = c_gtk_tree_view_set_activate_on_single_click;
alias gtk_tree_view_set_column_drag_function = c_gtk_tree_view_set_column_drag_function;
alias gtk_tree_view_set_cursor = c_gtk_tree_view_set_cursor;
alias gtk_tree_view_set_cursor_on_cell = c_gtk_tree_view_set_cursor_on_cell;
alias gtk_tree_view_set_drag_dest_row = c_gtk_tree_view_set_drag_dest_row;
alias gtk_tree_view_set_enable_search = c_gtk_tree_view_set_enable_search;
alias gtk_tree_view_set_enable_tree_lines = c_gtk_tree_view_set_enable_tree_lines;
alias gtk_tree_view_set_expander_column = c_gtk_tree_view_set_expander_column;
alias gtk_tree_view_set_fixed_height_mode = c_gtk_tree_view_set_fixed_height_mode;
alias gtk_tree_view_set_grid_lines = c_gtk_tree_view_set_grid_lines;
alias gtk_tree_view_set_headers_clickable = c_gtk_tree_view_set_headers_clickable;
alias gtk_tree_view_set_headers_visible = c_gtk_tree_view_set_headers_visible;
alias gtk_tree_view_set_hover_expand = c_gtk_tree_view_set_hover_expand;
alias gtk_tree_view_set_hover_selection = c_gtk_tree_view_set_hover_selection;
alias gtk_tree_view_set_level_indentation = c_gtk_tree_view_set_level_indentation;
alias gtk_tree_view_set_model = c_gtk_tree_view_set_model;
alias gtk_tree_view_set_reorderable = c_gtk_tree_view_set_reorderable;
alias gtk_tree_view_set_row_separator_func = c_gtk_tree_view_set_row_separator_func;
alias gtk_tree_view_set_rubber_banding = c_gtk_tree_view_set_rubber_banding;
alias gtk_tree_view_set_search_column = c_gtk_tree_view_set_search_column;
alias gtk_tree_view_set_search_entry = c_gtk_tree_view_set_search_entry;
alias gtk_tree_view_set_search_equal_func = c_gtk_tree_view_set_search_equal_func;
alias gtk_tree_view_set_show_expanders = c_gtk_tree_view_set_show_expanders;
alias gtk_tree_view_set_tooltip_cell = c_gtk_tree_view_set_tooltip_cell;
alias gtk_tree_view_set_tooltip_column = c_gtk_tree_view_set_tooltip_column;
alias gtk_tree_view_set_tooltip_row = c_gtk_tree_view_set_tooltip_row;
alias gtk_tree_view_unset_rows_drag_dest = c_gtk_tree_view_unset_rows_drag_dest;
alias gtk_tree_view_unset_rows_drag_source = c_gtk_tree_view_unset_rows_drag_source;

// TreeViewColumn
alias gtk_tree_view_column_get_type = c_gtk_tree_view_column_get_type;
alias gtk_tree_view_column_new = c_gtk_tree_view_column_new;
alias gtk_tree_view_column_new_with_area = c_gtk_tree_view_column_new_with_area;
alias gtk_tree_view_column_new_with_attributes = c_gtk_tree_view_column_new_with_attributes;
alias gtk_tree_view_column_add_attribute = c_gtk_tree_view_column_add_attribute;
alias gtk_tree_view_column_cell_get_position = c_gtk_tree_view_column_cell_get_position;
alias gtk_tree_view_column_cell_get_size = c_gtk_tree_view_column_cell_get_size;
alias gtk_tree_view_column_cell_is_visible = c_gtk_tree_view_column_cell_is_visible;
alias gtk_tree_view_column_cell_set_cell_data = c_gtk_tree_view_column_cell_set_cell_data;
alias gtk_tree_view_column_clear = c_gtk_tree_view_column_clear;
alias gtk_tree_view_column_clear_attributes = c_gtk_tree_view_column_clear_attributes;
alias gtk_tree_view_column_clicked = c_gtk_tree_view_column_clicked;
alias gtk_tree_view_column_focus_cell = c_gtk_tree_view_column_focus_cell;
alias gtk_tree_view_column_get_alignment = c_gtk_tree_view_column_get_alignment;
alias gtk_tree_view_column_get_button = c_gtk_tree_view_column_get_button;
alias gtk_tree_view_column_get_clickable = c_gtk_tree_view_column_get_clickable;
alias gtk_tree_view_column_get_expand = c_gtk_tree_view_column_get_expand;
alias gtk_tree_view_column_get_fixed_width = c_gtk_tree_view_column_get_fixed_width;
alias gtk_tree_view_column_get_max_width = c_gtk_tree_view_column_get_max_width;
alias gtk_tree_view_column_get_min_width = c_gtk_tree_view_column_get_min_width;
alias gtk_tree_view_column_get_reorderable = c_gtk_tree_view_column_get_reorderable;
alias gtk_tree_view_column_get_resizable = c_gtk_tree_view_column_get_resizable;
alias gtk_tree_view_column_get_sizing = c_gtk_tree_view_column_get_sizing;
alias gtk_tree_view_column_get_sort_column_id = c_gtk_tree_view_column_get_sort_column_id;
alias gtk_tree_view_column_get_sort_indicator = c_gtk_tree_view_column_get_sort_indicator;
alias gtk_tree_view_column_get_sort_order = c_gtk_tree_view_column_get_sort_order;
alias gtk_tree_view_column_get_spacing = c_gtk_tree_view_column_get_spacing;
alias gtk_tree_view_column_get_title = c_gtk_tree_view_column_get_title;
alias gtk_tree_view_column_get_tree_view = c_gtk_tree_view_column_get_tree_view;
alias gtk_tree_view_column_get_visible = c_gtk_tree_view_column_get_visible;
alias gtk_tree_view_column_get_widget = c_gtk_tree_view_column_get_widget;
alias gtk_tree_view_column_get_width = c_gtk_tree_view_column_get_width;
alias gtk_tree_view_column_get_x_offset = c_gtk_tree_view_column_get_x_offset;
alias gtk_tree_view_column_pack_end = c_gtk_tree_view_column_pack_end;
alias gtk_tree_view_column_pack_start = c_gtk_tree_view_column_pack_start;
alias gtk_tree_view_column_queue_resize = c_gtk_tree_view_column_queue_resize;
alias gtk_tree_view_column_set_alignment = c_gtk_tree_view_column_set_alignment;
alias gtk_tree_view_column_set_attributes = c_gtk_tree_view_column_set_attributes;
alias gtk_tree_view_column_set_cell_data_func = c_gtk_tree_view_column_set_cell_data_func;
alias gtk_tree_view_column_set_clickable = c_gtk_tree_view_column_set_clickable;
alias gtk_tree_view_column_set_expand = c_gtk_tree_view_column_set_expand;
alias gtk_tree_view_column_set_fixed_width = c_gtk_tree_view_column_set_fixed_width;
alias gtk_tree_view_column_set_max_width = c_gtk_tree_view_column_set_max_width;
alias gtk_tree_view_column_set_min_width = c_gtk_tree_view_column_set_min_width;
alias gtk_tree_view_column_set_reorderable = c_gtk_tree_view_column_set_reorderable;
alias gtk_tree_view_column_set_resizable = c_gtk_tree_view_column_set_resizable;
alias gtk_tree_view_column_set_sizing = c_gtk_tree_view_column_set_sizing;
alias gtk_tree_view_column_set_sort_column_id = c_gtk_tree_view_column_set_sort_column_id;
alias gtk_tree_view_column_set_sort_indicator = c_gtk_tree_view_column_set_sort_indicator;
alias gtk_tree_view_column_set_sort_order = c_gtk_tree_view_column_set_sort_order;
alias gtk_tree_view_column_set_spacing = c_gtk_tree_view_column_set_spacing;
alias gtk_tree_view_column_set_title = c_gtk_tree_view_column_set_title;
alias gtk_tree_view_column_set_visible = c_gtk_tree_view_column_set_visible;
alias gtk_tree_view_column_set_widget = c_gtk_tree_view_column_set_widget;

// UriLauncher
alias gtk_uri_launcher_get_type = c_gtk_uri_launcher_get_type;
alias gtk_uri_launcher_new = c_gtk_uri_launcher_new;
alias gtk_uri_launcher_get_uri = c_gtk_uri_launcher_get_uri;
alias gtk_uri_launcher_launch = c_gtk_uri_launcher_launch;
alias gtk_uri_launcher_launch_finish = c_gtk_uri_launcher_launch_finish;
alias gtk_uri_launcher_set_uri = c_gtk_uri_launcher_set_uri;

// Video
alias gtk_video_get_type = c_gtk_video_get_type;
alias gtk_video_new = c_gtk_video_new;
alias gtk_video_new_for_file = c_gtk_video_new_for_file;
alias gtk_video_new_for_filename = c_gtk_video_new_for_filename;
alias gtk_video_new_for_media_stream = c_gtk_video_new_for_media_stream;
alias gtk_video_new_for_resource = c_gtk_video_new_for_resource;
alias gtk_video_get_autoplay = c_gtk_video_get_autoplay;
alias gtk_video_get_file = c_gtk_video_get_file;
alias gtk_video_get_graphics_offload = c_gtk_video_get_graphics_offload;
alias gtk_video_get_loop = c_gtk_video_get_loop;
alias gtk_video_get_media_stream = c_gtk_video_get_media_stream;
alias gtk_video_set_autoplay = c_gtk_video_set_autoplay;
alias gtk_video_set_file = c_gtk_video_set_file;
alias gtk_video_set_filename = c_gtk_video_set_filename;
alias gtk_video_set_graphics_offload = c_gtk_video_set_graphics_offload;
alias gtk_video_set_loop = c_gtk_video_set_loop;
alias gtk_video_set_media_stream = c_gtk_video_set_media_stream;
alias gtk_video_set_resource = c_gtk_video_set_resource;

// Viewport
alias gtk_viewport_get_type = c_gtk_viewport_get_type;
alias gtk_viewport_new = c_gtk_viewport_new;
alias gtk_viewport_get_child = c_gtk_viewport_get_child;
alias gtk_viewport_get_scroll_to_focus = c_gtk_viewport_get_scroll_to_focus;
alias gtk_viewport_scroll_to = c_gtk_viewport_scroll_to;
alias gtk_viewport_set_child = c_gtk_viewport_set_child;
alias gtk_viewport_set_scroll_to_focus = c_gtk_viewport_set_scroll_to_focus;

// VolumeButton
alias gtk_volume_button_get_type = c_gtk_volume_button_get_type;
alias gtk_volume_button_new = c_gtk_volume_button_new;

// Widget
alias gtk_widget_get_type = c_gtk_widget_get_type;
alias gtk_widget_get_default_direction = c_gtk_widget_get_default_direction;
alias gtk_widget_set_default_direction = c_gtk_widget_set_default_direction;
alias gtk_widget_action_set_enabled = c_gtk_widget_action_set_enabled;
alias gtk_widget_activate = c_gtk_widget_activate;
alias gtk_widget_activate_action = c_gtk_widget_activate_action;
alias gtk_widget_activate_action_variant = c_gtk_widget_activate_action_variant;
alias gtk_widget_activate_default = c_gtk_widget_activate_default;
alias gtk_widget_add_controller = c_gtk_widget_add_controller;
alias gtk_widget_add_css_class = c_gtk_widget_add_css_class;
alias gtk_widget_add_mnemonic_label = c_gtk_widget_add_mnemonic_label;
alias gtk_widget_add_tick_callback = c_gtk_widget_add_tick_callback;
alias gtk_widget_allocate = c_gtk_widget_allocate;
alias gtk_widget_child_focus = c_gtk_widget_child_focus;
alias gtk_widget_compute_bounds = c_gtk_widget_compute_bounds;
alias gtk_widget_compute_expand = c_gtk_widget_compute_expand;
alias gtk_widget_compute_point = c_gtk_widget_compute_point;
alias gtk_widget_compute_transform = c_gtk_widget_compute_transform;
alias gtk_widget_contains = c_gtk_widget_contains;
alias gtk_widget_create_pango_context = c_gtk_widget_create_pango_context;
alias gtk_widget_create_pango_layout = c_gtk_widget_create_pango_layout;
alias gtk_widget_dispose_template = c_gtk_widget_dispose_template;
alias gtk_drag_check_threshold = c_gtk_drag_check_threshold;
alias gtk_widget_error_bell = c_gtk_widget_error_bell;
alias gtk_widget_get_allocated_baseline = c_gtk_widget_get_allocated_baseline;
alias gtk_widget_get_allocated_height = c_gtk_widget_get_allocated_height;
alias gtk_widget_get_allocated_width = c_gtk_widget_get_allocated_width;
alias gtk_widget_get_allocation = c_gtk_widget_get_allocation;
alias gtk_widget_get_ancestor = c_gtk_widget_get_ancestor;
alias gtk_widget_get_baseline = c_gtk_widget_get_baseline;
alias gtk_widget_get_can_focus = c_gtk_widget_get_can_focus;
alias gtk_widget_get_can_target = c_gtk_widget_get_can_target;
alias gtk_widget_get_child_visible = c_gtk_widget_get_child_visible;
alias gtk_widget_get_clipboard = c_gtk_widget_get_clipboard;
alias gtk_widget_get_color = c_gtk_widget_get_color;
alias gtk_widget_get_css_classes = c_gtk_widget_get_css_classes;
alias gtk_widget_get_css_name = c_gtk_widget_get_css_name;
alias gtk_widget_get_cursor = c_gtk_widget_get_cursor;
alias gtk_widget_get_direction = c_gtk_widget_get_direction;
alias gtk_widget_get_display = c_gtk_widget_get_display;
alias gtk_widget_get_first_child = c_gtk_widget_get_first_child;
alias gtk_widget_get_focus_child = c_gtk_widget_get_focus_child;
alias gtk_widget_get_focus_on_click = c_gtk_widget_get_focus_on_click;
alias gtk_widget_get_focusable = c_gtk_widget_get_focusable;
alias gtk_widget_get_font_map = c_gtk_widget_get_font_map;
alias gtk_widget_get_font_options = c_gtk_widget_get_font_options;
alias gtk_widget_get_frame_clock = c_gtk_widget_get_frame_clock;
alias gtk_widget_get_halign = c_gtk_widget_get_halign;
alias gtk_widget_get_has_tooltip = c_gtk_widget_get_has_tooltip;
alias gtk_widget_get_height = c_gtk_widget_get_height;
alias gtk_widget_get_hexpand = c_gtk_widget_get_hexpand;
alias gtk_widget_get_hexpand_set = c_gtk_widget_get_hexpand_set;
alias gtk_widget_get_last_child = c_gtk_widget_get_last_child;
alias gtk_widget_get_layout_manager = c_gtk_widget_get_layout_manager;
alias gtk_widget_get_mapped = c_gtk_widget_get_mapped;
alias gtk_widget_get_margin_bottom = c_gtk_widget_get_margin_bottom;
alias gtk_widget_get_margin_end = c_gtk_widget_get_margin_end;
alias gtk_widget_get_margin_start = c_gtk_widget_get_margin_start;
alias gtk_widget_get_margin_top = c_gtk_widget_get_margin_top;
alias gtk_widget_get_name = c_gtk_widget_get_name;
alias gtk_widget_get_native = c_gtk_widget_get_native;
alias gtk_widget_get_next_sibling = c_gtk_widget_get_next_sibling;
alias gtk_widget_get_opacity = c_gtk_widget_get_opacity;
alias gtk_widget_get_overflow = c_gtk_widget_get_overflow;
alias gtk_widget_get_pango_context = c_gtk_widget_get_pango_context;
alias gtk_widget_get_parent = c_gtk_widget_get_parent;
alias gtk_widget_get_preferred_size = c_gtk_widget_get_preferred_size;
alias gtk_widget_get_prev_sibling = c_gtk_widget_get_prev_sibling;
alias gtk_widget_get_primary_clipboard = c_gtk_widget_get_primary_clipboard;
alias gtk_widget_get_realized = c_gtk_widget_get_realized;
alias gtk_widget_get_receives_default = c_gtk_widget_get_receives_default;
alias gtk_widget_get_request_mode = c_gtk_widget_get_request_mode;
alias gtk_widget_get_root = c_gtk_widget_get_root;
alias gtk_widget_get_scale_factor = c_gtk_widget_get_scale_factor;
alias gtk_widget_get_sensitive = c_gtk_widget_get_sensitive;
alias gtk_widget_get_settings = c_gtk_widget_get_settings;
alias gtk_widget_get_size = c_gtk_widget_get_size;
alias gtk_widget_get_size_request = c_gtk_widget_get_size_request;
alias gtk_widget_get_state_flags = c_gtk_widget_get_state_flags;
alias gtk_widget_get_style_context = c_gtk_widget_get_style_context;
alias gtk_widget_get_template_child = c_gtk_widget_get_template_child;
alias gtk_widget_get_tooltip_markup = c_gtk_widget_get_tooltip_markup;
alias gtk_widget_get_tooltip_text = c_gtk_widget_get_tooltip_text;
alias gtk_widget_get_valign = c_gtk_widget_get_valign;
alias gtk_widget_get_vexpand = c_gtk_widget_get_vexpand;
alias gtk_widget_get_vexpand_set = c_gtk_widget_get_vexpand_set;
alias gtk_widget_get_visible = c_gtk_widget_get_visible;
alias gtk_widget_get_width = c_gtk_widget_get_width;
alias gtk_widget_grab_focus = c_gtk_widget_grab_focus;
alias gtk_widget_has_css_class = c_gtk_widget_has_css_class;
alias gtk_widget_has_default = c_gtk_widget_has_default;
alias gtk_widget_has_focus = c_gtk_widget_has_focus;
alias gtk_widget_has_visible_focus = c_gtk_widget_has_visible_focus;
alias gtk_widget_hide = c_gtk_widget_hide;
alias gtk_widget_in_destruction = c_gtk_widget_in_destruction;
alias gtk_widget_init_template = c_gtk_widget_init_template;
alias gtk_widget_insert_action_group = c_gtk_widget_insert_action_group;
alias gtk_widget_insert_after = c_gtk_widget_insert_after;
alias gtk_widget_insert_before = c_gtk_widget_insert_before;
alias gtk_widget_is_ancestor = c_gtk_widget_is_ancestor;
alias gtk_widget_is_drawable = c_gtk_widget_is_drawable;
alias gtk_widget_is_focus = c_gtk_widget_is_focus;
alias gtk_widget_is_sensitive = c_gtk_widget_is_sensitive;
alias gtk_widget_is_visible = c_gtk_widget_is_visible;
alias gtk_widget_keynav_failed = c_gtk_widget_keynav_failed;
alias gtk_widget_list_mnemonic_labels = c_gtk_widget_list_mnemonic_labels;
alias gtk_widget_map = c_gtk_widget_map;
alias gtk_widget_measure = c_gtk_widget_measure;
alias gtk_widget_mnemonic_activate = c_gtk_widget_mnemonic_activate;
alias gtk_widget_observe_children = c_gtk_widget_observe_children;
alias gtk_widget_observe_controllers = c_gtk_widget_observe_controllers;
alias gtk_widget_pick = c_gtk_widget_pick;
alias gtk_widget_queue_allocate = c_gtk_widget_queue_allocate;
alias gtk_widget_queue_draw = c_gtk_widget_queue_draw;
alias gtk_widget_queue_resize = c_gtk_widget_queue_resize;
alias gtk_widget_realize = c_gtk_widget_realize;
alias gtk_widget_remove_controller = c_gtk_widget_remove_controller;
alias gtk_widget_remove_css_class = c_gtk_widget_remove_css_class;
alias gtk_widget_remove_mnemonic_label = c_gtk_widget_remove_mnemonic_label;
alias gtk_widget_remove_tick_callback = c_gtk_widget_remove_tick_callback;
alias gtk_widget_set_can_focus = c_gtk_widget_set_can_focus;
alias gtk_widget_set_can_target = c_gtk_widget_set_can_target;
alias gtk_widget_set_child_visible = c_gtk_widget_set_child_visible;
alias gtk_widget_set_css_classes = c_gtk_widget_set_css_classes;
alias gtk_widget_set_cursor = c_gtk_widget_set_cursor;
alias gtk_widget_set_cursor_from_name = c_gtk_widget_set_cursor_from_name;
alias gtk_widget_set_direction = c_gtk_widget_set_direction;
alias gtk_widget_set_focus_child = c_gtk_widget_set_focus_child;
alias gtk_widget_set_focus_on_click = c_gtk_widget_set_focus_on_click;
alias gtk_widget_set_focusable = c_gtk_widget_set_focusable;
alias gtk_widget_set_font_map = c_gtk_widget_set_font_map;
alias gtk_widget_set_font_options = c_gtk_widget_set_font_options;
alias gtk_widget_set_halign = c_gtk_widget_set_halign;
alias gtk_widget_set_has_tooltip = c_gtk_widget_set_has_tooltip;
alias gtk_widget_set_hexpand = c_gtk_widget_set_hexpand;
alias gtk_widget_set_hexpand_set = c_gtk_widget_set_hexpand_set;
alias gtk_widget_set_layout_manager = c_gtk_widget_set_layout_manager;
alias gtk_widget_set_margin_bottom = c_gtk_widget_set_margin_bottom;
alias gtk_widget_set_margin_end = c_gtk_widget_set_margin_end;
alias gtk_widget_set_margin_start = c_gtk_widget_set_margin_start;
alias gtk_widget_set_margin_top = c_gtk_widget_set_margin_top;
alias gtk_widget_set_name = c_gtk_widget_set_name;
alias gtk_widget_set_opacity = c_gtk_widget_set_opacity;
alias gtk_widget_set_overflow = c_gtk_widget_set_overflow;
alias gtk_widget_set_parent = c_gtk_widget_set_parent;
alias gtk_widget_set_receives_default = c_gtk_widget_set_receives_default;
alias gtk_widget_set_sensitive = c_gtk_widget_set_sensitive;
alias gtk_widget_set_size_request = c_gtk_widget_set_size_request;
alias gtk_widget_set_state_flags = c_gtk_widget_set_state_flags;
alias gtk_widget_set_tooltip_markup = c_gtk_widget_set_tooltip_markup;
alias gtk_widget_set_tooltip_text = c_gtk_widget_set_tooltip_text;
alias gtk_widget_set_valign = c_gtk_widget_set_valign;
alias gtk_widget_set_vexpand = c_gtk_widget_set_vexpand;
alias gtk_widget_set_vexpand_set = c_gtk_widget_set_vexpand_set;
alias gtk_widget_set_visible = c_gtk_widget_set_visible;
alias gtk_widget_should_layout = c_gtk_widget_should_layout;
alias gtk_widget_show = c_gtk_widget_show;
alias gtk_widget_size_allocate = c_gtk_widget_size_allocate;
alias gtk_widget_snapshot_child = c_gtk_widget_snapshot_child;
alias gtk_widget_translate_coordinates = c_gtk_widget_translate_coordinates;
alias gtk_widget_trigger_tooltip_query = c_gtk_widget_trigger_tooltip_query;
alias gtk_widget_unmap = c_gtk_widget_unmap;
alias gtk_widget_unparent = c_gtk_widget_unparent;
alias gtk_widget_unrealize = c_gtk_widget_unrealize;
alias gtk_widget_unset_state_flags = c_gtk_widget_unset_state_flags;

// WidgetClass
alias gtk_widget_class_add_binding = c_gtk_widget_class_add_binding;
alias gtk_widget_class_add_binding_action = c_gtk_widget_class_add_binding_action;
alias gtk_widget_class_add_binding_signal = c_gtk_widget_class_add_binding_signal;
alias gtk_widget_class_add_shortcut = c_gtk_widget_class_add_shortcut;
alias gtk_widget_class_bind_template_callback_full = c_gtk_widget_class_bind_template_callback_full;
alias gtk_widget_class_bind_template_child_full = c_gtk_widget_class_bind_template_child_full;
alias gtk_widget_class_get_accessible_role = c_gtk_widget_class_get_accessible_role;
alias gtk_widget_class_get_activate_signal = c_gtk_widget_class_get_activate_signal;
alias gtk_widget_class_get_css_name = c_gtk_widget_class_get_css_name;
alias gtk_widget_class_get_layout_manager_type = c_gtk_widget_class_get_layout_manager_type;
alias gtk_widget_class_install_action = c_gtk_widget_class_install_action;
alias gtk_widget_class_install_property_action = c_gtk_widget_class_install_property_action;
alias gtk_widget_class_query_action = c_gtk_widget_class_query_action;
alias gtk_widget_class_set_accessible_role = c_gtk_widget_class_set_accessible_role;
alias gtk_widget_class_set_activate_signal = c_gtk_widget_class_set_activate_signal;
alias gtk_widget_class_set_activate_signal_from_name = c_gtk_widget_class_set_activate_signal_from_name;
alias gtk_widget_class_set_css_name = c_gtk_widget_class_set_css_name;
alias gtk_widget_class_set_layout_manager_type = c_gtk_widget_class_set_layout_manager_type;
alias gtk_widget_class_set_template = c_gtk_widget_class_set_template;
alias gtk_widget_class_set_template_from_resource = c_gtk_widget_class_set_template_from_resource;
alias gtk_widget_class_set_template_scope = c_gtk_widget_class_set_template_scope;

// WidgetPaintable
alias gtk_widget_paintable_get_type = c_gtk_widget_paintable_get_type;
alias gtk_widget_paintable_new = c_gtk_widget_paintable_new;
alias gtk_widget_paintable_get_widget = c_gtk_widget_paintable_get_widget;
alias gtk_widget_paintable_set_widget = c_gtk_widget_paintable_set_widget;

// Window
alias gtk_window_get_type = c_gtk_window_get_type;
alias gtk_window_new = c_gtk_window_new;
alias gtk_window_get_default_icon_name = c_gtk_window_get_default_icon_name;
alias gtk_window_get_toplevels = c_gtk_window_get_toplevels;
alias gtk_window_list_toplevels = c_gtk_window_list_toplevels;
alias gtk_window_set_auto_startup_notification = c_gtk_window_set_auto_startup_notification;
alias gtk_window_set_default_icon_name = c_gtk_window_set_default_icon_name;
alias gtk_window_set_interactive_debugging = c_gtk_window_set_interactive_debugging;
alias gtk_window_close = c_gtk_window_close;
alias gtk_window_destroy = c_gtk_window_destroy;
alias gtk_window_fullscreen = c_gtk_window_fullscreen;
alias gtk_window_fullscreen_on_monitor = c_gtk_window_fullscreen_on_monitor;
alias gtk_window_get_application = c_gtk_window_get_application;
alias gtk_window_get_child = c_gtk_window_get_child;
alias gtk_window_get_decorated = c_gtk_window_get_decorated;
alias gtk_window_get_default_size = c_gtk_window_get_default_size;
alias gtk_window_get_default_widget = c_gtk_window_get_default_widget;
alias gtk_window_get_deletable = c_gtk_window_get_deletable;
alias gtk_window_get_destroy_with_parent = c_gtk_window_get_destroy_with_parent;
alias gtk_window_get_focus = c_gtk_window_get_focus;
alias gtk_window_get_focus_visible = c_gtk_window_get_focus_visible;
alias gtk_window_get_group = c_gtk_window_get_group;
alias gtk_window_get_handle_menubar_accel = c_gtk_window_get_handle_menubar_accel;
alias gtk_window_get_hide_on_close = c_gtk_window_get_hide_on_close;
alias gtk_window_get_icon_name = c_gtk_window_get_icon_name;
alias gtk_window_get_mnemonics_visible = c_gtk_window_get_mnemonics_visible;
alias gtk_window_get_modal = c_gtk_window_get_modal;
alias gtk_window_get_resizable = c_gtk_window_get_resizable;
alias gtk_window_get_title = c_gtk_window_get_title;
alias gtk_window_get_titlebar = c_gtk_window_get_titlebar;
alias gtk_window_get_transient_for = c_gtk_window_get_transient_for;
alias gtk_window_has_group = c_gtk_window_has_group;
alias gtk_window_is_active = c_gtk_window_is_active;
alias gtk_window_is_fullscreen = c_gtk_window_is_fullscreen;
alias gtk_window_is_maximized = c_gtk_window_is_maximized;
alias gtk_window_is_suspended = c_gtk_window_is_suspended;
alias gtk_window_maximize = c_gtk_window_maximize;
alias gtk_window_minimize = c_gtk_window_minimize;
alias gtk_window_present = c_gtk_window_present;
alias gtk_window_present_with_time = c_gtk_window_present_with_time;
alias gtk_window_set_application = c_gtk_window_set_application;
alias gtk_window_set_child = c_gtk_window_set_child;
alias gtk_window_set_decorated = c_gtk_window_set_decorated;
alias gtk_window_set_default_size = c_gtk_window_set_default_size;
alias gtk_window_set_default_widget = c_gtk_window_set_default_widget;
alias gtk_window_set_deletable = c_gtk_window_set_deletable;
alias gtk_window_set_destroy_with_parent = c_gtk_window_set_destroy_with_parent;
alias gtk_window_set_display = c_gtk_window_set_display;
alias gtk_window_set_focus = c_gtk_window_set_focus;
alias gtk_window_set_focus_visible = c_gtk_window_set_focus_visible;
alias gtk_window_set_handle_menubar_accel = c_gtk_window_set_handle_menubar_accel;
alias gtk_window_set_hide_on_close = c_gtk_window_set_hide_on_close;
alias gtk_window_set_icon_name = c_gtk_window_set_icon_name;
alias gtk_window_set_mnemonics_visible = c_gtk_window_set_mnemonics_visible;
alias gtk_window_set_modal = c_gtk_window_set_modal;
alias gtk_window_set_resizable = c_gtk_window_set_resizable;
alias gtk_window_set_startup_id = c_gtk_window_set_startup_id;
alias gtk_window_set_title = c_gtk_window_set_title;
alias gtk_window_set_titlebar = c_gtk_window_set_titlebar;
alias gtk_window_set_transient_for = c_gtk_window_set_transient_for;
alias gtk_window_unfullscreen = c_gtk_window_unfullscreen;
alias gtk_window_unmaximize = c_gtk_window_unmaximize;
alias gtk_window_unminimize = c_gtk_window_unminimize;

// WindowControls
alias gtk_window_controls_get_type = c_gtk_window_controls_get_type;
alias gtk_window_controls_new = c_gtk_window_controls_new;
alias gtk_window_controls_get_decoration_layout = c_gtk_window_controls_get_decoration_layout;
alias gtk_window_controls_get_empty = c_gtk_window_controls_get_empty;
alias gtk_window_controls_get_side = c_gtk_window_controls_get_side;
alias gtk_window_controls_set_decoration_layout = c_gtk_window_controls_set_decoration_layout;
alias gtk_window_controls_set_side = c_gtk_window_controls_set_side;

// WindowGroup
alias gtk_window_group_get_type = c_gtk_window_group_get_type;
alias gtk_window_group_new = c_gtk_window_group_new;
alias gtk_window_group_add_window = c_gtk_window_group_add_window;
alias gtk_window_group_list_windows = c_gtk_window_group_list_windows;
alias gtk_window_group_remove_window = c_gtk_window_group_remove_window;

// WindowHandle
alias gtk_window_handle_get_type = c_gtk_window_handle_get_type;
alias gtk_window_handle_new = c_gtk_window_handle_new;
alias gtk_window_handle_get_child = c_gtk_window_handle_get_child;
alias gtk_window_handle_set_child = c_gtk_window_handle_set_child;

shared static this()
{
  // ATContext
  link(gtk_at_context_get_type, "gtk_at_context_get_type");
  link(gtk_at_context_create, "gtk_at_context_create");
  link(gtk_at_context_get_accessible, "gtk_at_context_get_accessible");
  link(gtk_at_context_get_accessible_role, "gtk_at_context_get_accessible_role");

  // AboutDialog
  link(gtk_about_dialog_get_type, "gtk_about_dialog_get_type");
  link(gtk_about_dialog_new, "gtk_about_dialog_new");
  link(gtk_about_dialog_add_credit_section, "gtk_about_dialog_add_credit_section");
  link(gtk_about_dialog_get_artists, "gtk_about_dialog_get_artists");
  link(gtk_about_dialog_get_authors, "gtk_about_dialog_get_authors");
  link(gtk_about_dialog_get_comments, "gtk_about_dialog_get_comments");
  link(gtk_about_dialog_get_copyright, "gtk_about_dialog_get_copyright");
  link(gtk_about_dialog_get_documenters, "gtk_about_dialog_get_documenters");
  link(gtk_about_dialog_get_license, "gtk_about_dialog_get_license");
  link(gtk_about_dialog_get_license_type, "gtk_about_dialog_get_license_type");
  link(gtk_about_dialog_get_logo, "gtk_about_dialog_get_logo");
  link(gtk_about_dialog_get_logo_icon_name, "gtk_about_dialog_get_logo_icon_name");
  link(gtk_about_dialog_get_program_name, "gtk_about_dialog_get_program_name");
  link(gtk_about_dialog_get_system_information, "gtk_about_dialog_get_system_information");
  link(gtk_about_dialog_get_translator_credits, "gtk_about_dialog_get_translator_credits");
  link(gtk_about_dialog_get_version, "gtk_about_dialog_get_version");
  link(gtk_about_dialog_get_website, "gtk_about_dialog_get_website");
  link(gtk_about_dialog_get_website_label, "gtk_about_dialog_get_website_label");
  link(gtk_about_dialog_get_wrap_license, "gtk_about_dialog_get_wrap_license");
  link(gtk_about_dialog_set_artists, "gtk_about_dialog_set_artists");
  link(gtk_about_dialog_set_authors, "gtk_about_dialog_set_authors");
  link(gtk_about_dialog_set_comments, "gtk_about_dialog_set_comments");
  link(gtk_about_dialog_set_copyright, "gtk_about_dialog_set_copyright");
  link(gtk_about_dialog_set_documenters, "gtk_about_dialog_set_documenters");
  link(gtk_about_dialog_set_license, "gtk_about_dialog_set_license");
  link(gtk_about_dialog_set_license_type, "gtk_about_dialog_set_license_type");
  link(gtk_about_dialog_set_logo, "gtk_about_dialog_set_logo");
  link(gtk_about_dialog_set_logo_icon_name, "gtk_about_dialog_set_logo_icon_name");
  link(gtk_about_dialog_set_program_name, "gtk_about_dialog_set_program_name");
  link(gtk_about_dialog_set_system_information, "gtk_about_dialog_set_system_information");
  link(gtk_about_dialog_set_translator_credits, "gtk_about_dialog_set_translator_credits");
  link(gtk_about_dialog_set_version, "gtk_about_dialog_set_version");
  link(gtk_about_dialog_set_website, "gtk_about_dialog_set_website");
  link(gtk_about_dialog_set_website_label, "gtk_about_dialog_set_website_label");
  link(gtk_about_dialog_set_wrap_license, "gtk_about_dialog_set_wrap_license");

  // Accessible
  link(gtk_accessible_get_type, "gtk_accessible_get_type");
  link(gtk_accessible_announce, "gtk_accessible_announce");
  link(gtk_accessible_get_accessible_parent, "gtk_accessible_get_accessible_parent");
  link(gtk_accessible_get_accessible_role, "gtk_accessible_get_accessible_role");
  link(gtk_accessible_get_at_context, "gtk_accessible_get_at_context");
  link(gtk_accessible_get_bounds, "gtk_accessible_get_bounds");
  link(gtk_accessible_get_first_accessible_child, "gtk_accessible_get_first_accessible_child");
  link(gtk_accessible_get_next_accessible_sibling, "gtk_accessible_get_next_accessible_sibling");
  link(gtk_accessible_get_platform_state, "gtk_accessible_get_platform_state");
  link(gtk_accessible_reset_property, "gtk_accessible_reset_property");
  link(gtk_accessible_reset_relation, "gtk_accessible_reset_relation");
  link(gtk_accessible_reset_state, "gtk_accessible_reset_state");
  link(gtk_accessible_set_accessible_parent, "gtk_accessible_set_accessible_parent");
  link(gtk_accessible_update_next_accessible_sibling, "gtk_accessible_update_next_accessible_sibling");
  link(gtk_accessible_update_property, "gtk_accessible_update_property");
  link(gtk_accessible_update_property_value, "gtk_accessible_update_property_value");
  link(gtk_accessible_update_relation, "gtk_accessible_update_relation");
  link(gtk_accessible_update_relation_value, "gtk_accessible_update_relation_value");
  link(gtk_accessible_update_state, "gtk_accessible_update_state");
  link(gtk_accessible_update_state_value, "gtk_accessible_update_state_value");

  // AccessibleList
  link(gtk_accessible_list_get_type, "gtk_accessible_list_get_type");
  link(gtk_accessible_list_new_from_array, "gtk_accessible_list_new_from_array");
  link(gtk_accessible_list_new_from_list, "gtk_accessible_list_new_from_list");
  link(gtk_accessible_list_get_objects, "gtk_accessible_list_get_objects");

  // AccessibleRange
  link(gtk_accessible_range_get_type, "gtk_accessible_range_get_type");

  // AccessibleText
  link(gtk_accessible_text_get_type, "gtk_accessible_text_get_type");
  link(gtk_accessible_text_update_caret_position, "gtk_accessible_text_update_caret_position");
  link(gtk_accessible_text_update_contents, "gtk_accessible_text_update_contents");
  link(gtk_accessible_text_update_selection_bound, "gtk_accessible_text_update_selection_bound");

  // ActionBar
  link(gtk_action_bar_get_type, "gtk_action_bar_get_type");
  link(gtk_action_bar_new, "gtk_action_bar_new");
  link(gtk_action_bar_get_center_widget, "gtk_action_bar_get_center_widget");
  link(gtk_action_bar_get_revealed, "gtk_action_bar_get_revealed");
  link(gtk_action_bar_pack_end, "gtk_action_bar_pack_end");
  link(gtk_action_bar_pack_start, "gtk_action_bar_pack_start");
  link(gtk_action_bar_remove, "gtk_action_bar_remove");
  link(gtk_action_bar_set_center_widget, "gtk_action_bar_set_center_widget");
  link(gtk_action_bar_set_revealed, "gtk_action_bar_set_revealed");

  // Actionable
  link(gtk_actionable_get_type, "gtk_actionable_get_type");
  link(gtk_actionable_get_action_name, "gtk_actionable_get_action_name");
  link(gtk_actionable_get_action_target_value, "gtk_actionable_get_action_target_value");
  link(gtk_actionable_set_action_name, "gtk_actionable_set_action_name");
  link(gtk_actionable_set_action_target, "gtk_actionable_set_action_target");
  link(gtk_actionable_set_action_target_value, "gtk_actionable_set_action_target_value");
  link(gtk_actionable_set_detailed_action_name, "gtk_actionable_set_detailed_action_name");

  // ActivateAction
  link(gtk_activate_action_get_type, "gtk_activate_action_get_type");
  link(gtk_activate_action_get, "gtk_activate_action_get");

  // Adjustment
  link(gtk_adjustment_get_type, "gtk_adjustment_get_type");
  link(gtk_adjustment_new, "gtk_adjustment_new");
  link(gtk_adjustment_clamp_page, "gtk_adjustment_clamp_page");
  link(gtk_adjustment_configure, "gtk_adjustment_configure");
  link(gtk_adjustment_get_lower, "gtk_adjustment_get_lower");
  link(gtk_adjustment_get_minimum_increment, "gtk_adjustment_get_minimum_increment");
  link(gtk_adjustment_get_page_increment, "gtk_adjustment_get_page_increment");
  link(gtk_adjustment_get_page_size, "gtk_adjustment_get_page_size");
  link(gtk_adjustment_get_step_increment, "gtk_adjustment_get_step_increment");
  link(gtk_adjustment_get_upper, "gtk_adjustment_get_upper");
  link(gtk_adjustment_get_value, "gtk_adjustment_get_value");
  link(gtk_adjustment_set_lower, "gtk_adjustment_set_lower");
  link(gtk_adjustment_set_page_increment, "gtk_adjustment_set_page_increment");
  link(gtk_adjustment_set_page_size, "gtk_adjustment_set_page_size");
  link(gtk_adjustment_set_step_increment, "gtk_adjustment_set_step_increment");
  link(gtk_adjustment_set_upper, "gtk_adjustment_set_upper");
  link(gtk_adjustment_set_value, "gtk_adjustment_set_value");

  // AlertDialog
  link(gtk_alert_dialog_get_type, "gtk_alert_dialog_get_type");
  link(gtk_alert_dialog_new, "gtk_alert_dialog_new");
  link(gtk_alert_dialog_choose, "gtk_alert_dialog_choose");
  link(gtk_alert_dialog_choose_finish, "gtk_alert_dialog_choose_finish");
  link(gtk_alert_dialog_get_buttons, "gtk_alert_dialog_get_buttons");
  link(gtk_alert_dialog_get_cancel_button, "gtk_alert_dialog_get_cancel_button");
  link(gtk_alert_dialog_get_default_button, "gtk_alert_dialog_get_default_button");
  link(gtk_alert_dialog_get_detail, "gtk_alert_dialog_get_detail");
  link(gtk_alert_dialog_get_message, "gtk_alert_dialog_get_message");
  link(gtk_alert_dialog_get_modal, "gtk_alert_dialog_get_modal");
  link(gtk_alert_dialog_set_buttons, "gtk_alert_dialog_set_buttons");
  link(gtk_alert_dialog_set_cancel_button, "gtk_alert_dialog_set_cancel_button");
  link(gtk_alert_dialog_set_default_button, "gtk_alert_dialog_set_default_button");
  link(gtk_alert_dialog_set_detail, "gtk_alert_dialog_set_detail");
  link(gtk_alert_dialog_set_message, "gtk_alert_dialog_set_message");
  link(gtk_alert_dialog_set_modal, "gtk_alert_dialog_set_modal");
  link(gtk_alert_dialog_show, "gtk_alert_dialog_show");

  // AlternativeTrigger
  link(gtk_alternative_trigger_get_type, "gtk_alternative_trigger_get_type");
  link(gtk_alternative_trigger_new, "gtk_alternative_trigger_new");
  link(gtk_alternative_trigger_get_first, "gtk_alternative_trigger_get_first");
  link(gtk_alternative_trigger_get_second, "gtk_alternative_trigger_get_second");

  // AnyFilter
  link(gtk_any_filter_get_type, "gtk_any_filter_get_type");
  link(gtk_any_filter_new, "gtk_any_filter_new");

  // AppChooser
  link(gtk_app_chooser_get_type, "gtk_app_chooser_get_type");
  link(gtk_app_chooser_get_app_info, "gtk_app_chooser_get_app_info");
  link(gtk_app_chooser_get_content_type, "gtk_app_chooser_get_content_type");
  link(gtk_app_chooser_refresh, "gtk_app_chooser_refresh");

  // AppChooserButton
  link(gtk_app_chooser_button_get_type, "gtk_app_chooser_button_get_type");
  link(gtk_app_chooser_button_new, "gtk_app_chooser_button_new");
  link(gtk_app_chooser_button_append_custom_item, "gtk_app_chooser_button_append_custom_item");
  link(gtk_app_chooser_button_append_separator, "gtk_app_chooser_button_append_separator");
  link(gtk_app_chooser_button_get_heading, "gtk_app_chooser_button_get_heading");
  link(gtk_app_chooser_button_get_modal, "gtk_app_chooser_button_get_modal");
  link(gtk_app_chooser_button_get_show_default_item, "gtk_app_chooser_button_get_show_default_item");
  link(gtk_app_chooser_button_get_show_dialog_item, "gtk_app_chooser_button_get_show_dialog_item");
  link(gtk_app_chooser_button_set_active_custom_item, "gtk_app_chooser_button_set_active_custom_item");
  link(gtk_app_chooser_button_set_heading, "gtk_app_chooser_button_set_heading");
  link(gtk_app_chooser_button_set_modal, "gtk_app_chooser_button_set_modal");
  link(gtk_app_chooser_button_set_show_default_item, "gtk_app_chooser_button_set_show_default_item");
  link(gtk_app_chooser_button_set_show_dialog_item, "gtk_app_chooser_button_set_show_dialog_item");

  // AppChooserDialog
  link(gtk_app_chooser_dialog_get_type, "gtk_app_chooser_dialog_get_type");
  link(gtk_app_chooser_dialog_new, "gtk_app_chooser_dialog_new");
  link(gtk_app_chooser_dialog_new_for_content_type, "gtk_app_chooser_dialog_new_for_content_type");
  link(gtk_app_chooser_dialog_get_heading, "gtk_app_chooser_dialog_get_heading");
  link(gtk_app_chooser_dialog_get_widget, "gtk_app_chooser_dialog_get_widget");
  link(gtk_app_chooser_dialog_set_heading, "gtk_app_chooser_dialog_set_heading");

  // AppChooserWidget
  link(gtk_app_chooser_widget_get_type, "gtk_app_chooser_widget_get_type");
  link(gtk_app_chooser_widget_new, "gtk_app_chooser_widget_new");
  link(gtk_app_chooser_widget_get_default_text, "gtk_app_chooser_widget_get_default_text");
  link(gtk_app_chooser_widget_get_show_all, "gtk_app_chooser_widget_get_show_all");
  link(gtk_app_chooser_widget_get_show_default, "gtk_app_chooser_widget_get_show_default");
  link(gtk_app_chooser_widget_get_show_fallback, "gtk_app_chooser_widget_get_show_fallback");
  link(gtk_app_chooser_widget_get_show_other, "gtk_app_chooser_widget_get_show_other");
  link(gtk_app_chooser_widget_get_show_recommended, "gtk_app_chooser_widget_get_show_recommended");
  link(gtk_app_chooser_widget_set_default_text, "gtk_app_chooser_widget_set_default_text");
  link(gtk_app_chooser_widget_set_show_all, "gtk_app_chooser_widget_set_show_all");
  link(gtk_app_chooser_widget_set_show_default, "gtk_app_chooser_widget_set_show_default");
  link(gtk_app_chooser_widget_set_show_fallback, "gtk_app_chooser_widget_set_show_fallback");
  link(gtk_app_chooser_widget_set_show_other, "gtk_app_chooser_widget_set_show_other");
  link(gtk_app_chooser_widget_set_show_recommended, "gtk_app_chooser_widget_set_show_recommended");

  // Application
  link(gtk_application_get_type, "gtk_application_get_type");
  link(gtk_application_new, "gtk_application_new");
  link(gtk_application_add_window, "gtk_application_add_window");
  link(gtk_application_get_accels_for_action, "gtk_application_get_accels_for_action");
  link(gtk_application_get_actions_for_accel, "gtk_application_get_actions_for_accel");
  link(gtk_application_get_active_window, "gtk_application_get_active_window");
  link(gtk_application_get_menu_by_id, "gtk_application_get_menu_by_id");
  link(gtk_application_get_menubar, "gtk_application_get_menubar");
  link(gtk_application_get_window_by_id, "gtk_application_get_window_by_id");
  link(gtk_application_get_windows, "gtk_application_get_windows");
  link(gtk_application_inhibit, "gtk_application_inhibit");
  link(gtk_application_list_action_descriptions, "gtk_application_list_action_descriptions");
  link(gtk_application_remove_window, "gtk_application_remove_window");
  link(gtk_application_set_accels_for_action, "gtk_application_set_accels_for_action");
  link(gtk_application_set_menubar, "gtk_application_set_menubar");
  link(gtk_application_uninhibit, "gtk_application_uninhibit");

  // ApplicationWindow
  link(gtk_application_window_get_type, "gtk_application_window_get_type");
  link(gtk_application_window_new, "gtk_application_window_new");
  link(gtk_application_window_get_help_overlay, "gtk_application_window_get_help_overlay");
  link(gtk_application_window_get_id, "gtk_application_window_get_id");
  link(gtk_application_window_get_show_menubar, "gtk_application_window_get_show_menubar");
  link(gtk_application_window_set_help_overlay, "gtk_application_window_set_help_overlay");
  link(gtk_application_window_set_show_menubar, "gtk_application_window_set_show_menubar");

  // AspectFrame
  link(gtk_aspect_frame_get_type, "gtk_aspect_frame_get_type");
  link(gtk_aspect_frame_new, "gtk_aspect_frame_new");
  link(gtk_aspect_frame_get_child, "gtk_aspect_frame_get_child");
  link(gtk_aspect_frame_get_obey_child, "gtk_aspect_frame_get_obey_child");
  link(gtk_aspect_frame_get_ratio, "gtk_aspect_frame_get_ratio");
  link(gtk_aspect_frame_get_xalign, "gtk_aspect_frame_get_xalign");
  link(gtk_aspect_frame_get_yalign, "gtk_aspect_frame_get_yalign");
  link(gtk_aspect_frame_set_child, "gtk_aspect_frame_set_child");
  link(gtk_aspect_frame_set_obey_child, "gtk_aspect_frame_set_obey_child");
  link(gtk_aspect_frame_set_ratio, "gtk_aspect_frame_set_ratio");
  link(gtk_aspect_frame_set_xalign, "gtk_aspect_frame_set_xalign");
  link(gtk_aspect_frame_set_yalign, "gtk_aspect_frame_set_yalign");

  // Assistant
  link(gtk_assistant_get_type, "gtk_assistant_get_type");
  link(gtk_assistant_new, "gtk_assistant_new");
  link(gtk_assistant_add_action_widget, "gtk_assistant_add_action_widget");
  link(gtk_assistant_append_page, "gtk_assistant_append_page");
  link(gtk_assistant_commit, "gtk_assistant_commit");
  link(gtk_assistant_get_current_page, "gtk_assistant_get_current_page");
  link(gtk_assistant_get_n_pages, "gtk_assistant_get_n_pages");
  link(gtk_assistant_get_nth_page, "gtk_assistant_get_nth_page");
  link(gtk_assistant_get_page, "gtk_assistant_get_page");
  link(gtk_assistant_get_page_complete, "gtk_assistant_get_page_complete");
  link(gtk_assistant_get_page_title, "gtk_assistant_get_page_title");
  link(gtk_assistant_get_page_type, "gtk_assistant_get_page_type");
  link(gtk_assistant_get_pages, "gtk_assistant_get_pages");
  link(gtk_assistant_insert_page, "gtk_assistant_insert_page");
  link(gtk_assistant_next_page, "gtk_assistant_next_page");
  link(gtk_assistant_prepend_page, "gtk_assistant_prepend_page");
  link(gtk_assistant_previous_page, "gtk_assistant_previous_page");
  link(gtk_assistant_remove_action_widget, "gtk_assistant_remove_action_widget");
  link(gtk_assistant_remove_page, "gtk_assistant_remove_page");
  link(gtk_assistant_set_current_page, "gtk_assistant_set_current_page");
  link(gtk_assistant_set_forward_page_func, "gtk_assistant_set_forward_page_func");
  link(gtk_assistant_set_page_complete, "gtk_assistant_set_page_complete");
  link(gtk_assistant_set_page_title, "gtk_assistant_set_page_title");
  link(gtk_assistant_set_page_type, "gtk_assistant_set_page_type");
  link(gtk_assistant_update_buttons_state, "gtk_assistant_update_buttons_state");

  // AssistantPage
  link(gtk_assistant_page_get_type, "gtk_assistant_page_get_type");
  link(gtk_assistant_page_get_child, "gtk_assistant_page_get_child");

  // BinLayout
  link(gtk_bin_layout_get_type, "gtk_bin_layout_get_type");
  link(gtk_bin_layout_new, "gtk_bin_layout_new");

  // Bitset
  link(gtk_bitset_get_type, "gtk_bitset_get_type");
  link(gtk_bitset_new_empty, "gtk_bitset_new_empty");
  link(gtk_bitset_new_range, "gtk_bitset_new_range");
  link(gtk_bitset_add, "gtk_bitset_add");
  link(gtk_bitset_add_range, "gtk_bitset_add_range");
  link(gtk_bitset_add_range_closed, "gtk_bitset_add_range_closed");
  link(gtk_bitset_add_rectangle, "gtk_bitset_add_rectangle");
  link(gtk_bitset_contains, "gtk_bitset_contains");
  link(gtk_bitset_copy, "gtk_bitset_copy");
  link(gtk_bitset_difference, "gtk_bitset_difference");
  link(gtk_bitset_equals, "gtk_bitset_equals");
  link(gtk_bitset_get_maximum, "gtk_bitset_get_maximum");
  link(gtk_bitset_get_minimum, "gtk_bitset_get_minimum");
  link(gtk_bitset_get_nth, "gtk_bitset_get_nth");
  link(gtk_bitset_get_size, "gtk_bitset_get_size");
  link(gtk_bitset_get_size_in_range, "gtk_bitset_get_size_in_range");
  link(gtk_bitset_intersect, "gtk_bitset_intersect");
  link(gtk_bitset_is_empty, "gtk_bitset_is_empty");
  link(gtk_bitset_ref, "gtk_bitset_ref");
  link(gtk_bitset_remove, "gtk_bitset_remove");
  link(gtk_bitset_remove_all, "gtk_bitset_remove_all");
  link(gtk_bitset_remove_range, "gtk_bitset_remove_range");
  link(gtk_bitset_remove_range_closed, "gtk_bitset_remove_range_closed");
  link(gtk_bitset_remove_rectangle, "gtk_bitset_remove_rectangle");
  link(gtk_bitset_shift_left, "gtk_bitset_shift_left");
  link(gtk_bitset_shift_right, "gtk_bitset_shift_right");
  link(gtk_bitset_splice, "gtk_bitset_splice");
  link(gtk_bitset_subtract, "gtk_bitset_subtract");
  link(gtk_bitset_union, "gtk_bitset_union");
  link(gtk_bitset_unref, "gtk_bitset_unref");

  // BitsetIter
  link(gtk_bitset_iter_get_type, "gtk_bitset_iter_get_type");
  link(gtk_bitset_iter_get_value, "gtk_bitset_iter_get_value");
  link(gtk_bitset_iter_is_valid, "gtk_bitset_iter_is_valid");
  link(gtk_bitset_iter_next, "gtk_bitset_iter_next");
  link(gtk_bitset_iter_previous, "gtk_bitset_iter_previous");
  link(gtk_bitset_iter_init_at, "gtk_bitset_iter_init_at");
  link(gtk_bitset_iter_init_first, "gtk_bitset_iter_init_first");
  link(gtk_bitset_iter_init_last, "gtk_bitset_iter_init_last");

  // BookmarkList
  link(gtk_bookmark_list_get_type, "gtk_bookmark_list_get_type");
  link(gtk_bookmark_list_new, "gtk_bookmark_list_new");
  link(gtk_bookmark_list_get_attributes, "gtk_bookmark_list_get_attributes");
  link(gtk_bookmark_list_get_filename, "gtk_bookmark_list_get_filename");
  link(gtk_bookmark_list_get_io_priority, "gtk_bookmark_list_get_io_priority");
  link(gtk_bookmark_list_is_loading, "gtk_bookmark_list_is_loading");
  link(gtk_bookmark_list_set_attributes, "gtk_bookmark_list_set_attributes");
  link(gtk_bookmark_list_set_io_priority, "gtk_bookmark_list_set_io_priority");

  // BoolFilter
  link(gtk_bool_filter_get_type, "gtk_bool_filter_get_type");
  link(gtk_bool_filter_new, "gtk_bool_filter_new");
  link(gtk_bool_filter_get_expression, "gtk_bool_filter_get_expression");
  link(gtk_bool_filter_get_invert, "gtk_bool_filter_get_invert");
  link(gtk_bool_filter_set_expression, "gtk_bool_filter_set_expression");
  link(gtk_bool_filter_set_invert, "gtk_bool_filter_set_invert");

  // Border
  link(gtk_border_get_type, "gtk_border_get_type");
  link(gtk_border_new, "gtk_border_new");
  link(gtk_border_copy, "gtk_border_copy");
  link(gtk_border_free, "gtk_border_free");

  // Box
  link(gtk_box_get_type, "gtk_box_get_type");
  link(gtk_box_new, "gtk_box_new");
  link(gtk_box_append, "gtk_box_append");
  link(gtk_box_get_baseline_child, "gtk_box_get_baseline_child");
  link(gtk_box_get_baseline_position, "gtk_box_get_baseline_position");
  link(gtk_box_get_homogeneous, "gtk_box_get_homogeneous");
  link(gtk_box_get_spacing, "gtk_box_get_spacing");
  link(gtk_box_insert_child_after, "gtk_box_insert_child_after");
  link(gtk_box_prepend, "gtk_box_prepend");
  link(gtk_box_remove, "gtk_box_remove");
  link(gtk_box_reorder_child_after, "gtk_box_reorder_child_after");
  link(gtk_box_set_baseline_child, "gtk_box_set_baseline_child");
  link(gtk_box_set_baseline_position, "gtk_box_set_baseline_position");
  link(gtk_box_set_homogeneous, "gtk_box_set_homogeneous");
  link(gtk_box_set_spacing, "gtk_box_set_spacing");

  // BoxLayout
  link(gtk_box_layout_get_type, "gtk_box_layout_get_type");
  link(gtk_box_layout_new, "gtk_box_layout_new");
  link(gtk_box_layout_get_baseline_child, "gtk_box_layout_get_baseline_child");
  link(gtk_box_layout_get_baseline_position, "gtk_box_layout_get_baseline_position");
  link(gtk_box_layout_get_homogeneous, "gtk_box_layout_get_homogeneous");
  link(gtk_box_layout_get_spacing, "gtk_box_layout_get_spacing");
  link(gtk_box_layout_set_baseline_child, "gtk_box_layout_set_baseline_child");
  link(gtk_box_layout_set_baseline_position, "gtk_box_layout_set_baseline_position");
  link(gtk_box_layout_set_homogeneous, "gtk_box_layout_set_homogeneous");
  link(gtk_box_layout_set_spacing, "gtk_box_layout_set_spacing");

  // Buildable
  link(gtk_buildable_get_type, "gtk_buildable_get_type");
  link(gtk_buildable_get_buildable_id, "gtk_buildable_get_buildable_id");

  // BuildableParseContext
  link(gtk_buildable_parse_context_get_element, "gtk_buildable_parse_context_get_element");
  link(gtk_buildable_parse_context_get_element_stack, "gtk_buildable_parse_context_get_element_stack");
  link(gtk_buildable_parse_context_get_position, "gtk_buildable_parse_context_get_position");
  link(gtk_buildable_parse_context_pop, "gtk_buildable_parse_context_pop");
  link(gtk_buildable_parse_context_push, "gtk_buildable_parse_context_push");

  // Builder
  link(gtk_builder_get_type, "gtk_builder_get_type");
  link(gtk_builder_new, "gtk_builder_new");
  link(gtk_builder_new_from_file, "gtk_builder_new_from_file");
  link(gtk_builder_new_from_resource, "gtk_builder_new_from_resource");
  link(gtk_builder_new_from_string, "gtk_builder_new_from_string");
  link(gtk_builder_add_from_file, "gtk_builder_add_from_file");
  link(gtk_builder_add_from_resource, "gtk_builder_add_from_resource");
  link(gtk_builder_add_from_string, "gtk_builder_add_from_string");
  link(gtk_builder_add_objects_from_file, "gtk_builder_add_objects_from_file");
  link(gtk_builder_add_objects_from_resource, "gtk_builder_add_objects_from_resource");
  link(gtk_builder_add_objects_from_string, "gtk_builder_add_objects_from_string");
  link(gtk_builder_create_closure, "gtk_builder_create_closure");
  link(gtk_builder_expose_object, "gtk_builder_expose_object");
  link(gtk_builder_extend_with_template, "gtk_builder_extend_with_template");
  link(gtk_builder_get_current_object, "gtk_builder_get_current_object");
  link(gtk_builder_get_object, "gtk_builder_get_object");
  link(gtk_builder_get_objects, "gtk_builder_get_objects");
  link(gtk_builder_get_scope, "gtk_builder_get_scope");
  link(gtk_builder_get_translation_domain, "gtk_builder_get_translation_domain");
  link(gtk_builder_get_type_from_name, "gtk_builder_get_type_from_name");
  link(gtk_builder_set_current_object, "gtk_builder_set_current_object");
  link(gtk_builder_set_scope, "gtk_builder_set_scope");
  link(gtk_builder_set_translation_domain, "gtk_builder_set_translation_domain");
  link(gtk_builder_value_from_string, "gtk_builder_value_from_string");
  link(gtk_builder_value_from_string_type, "gtk_builder_value_from_string_type");

  // BuilderCScope
  link(gtk_builder_cscope_get_type, "gtk_builder_cscope_get_type");
  link(gtk_builder_cscope_new, "gtk_builder_cscope_new");
  link(gtk_builder_cscope_add_callback_symbol, "gtk_builder_cscope_add_callback_symbol");
  link(gtk_builder_cscope_add_callback_symbols, "gtk_builder_cscope_add_callback_symbols");
  link(gtk_builder_cscope_lookup_callback_symbol, "gtk_builder_cscope_lookup_callback_symbol");

  // BuilderListItemFactory
  link(gtk_builder_list_item_factory_get_type, "gtk_builder_list_item_factory_get_type");
  link(gtk_builder_list_item_factory_new_from_bytes, "gtk_builder_list_item_factory_new_from_bytes");
  link(gtk_builder_list_item_factory_new_from_resource, "gtk_builder_list_item_factory_new_from_resource");
  link(gtk_builder_list_item_factory_get_bytes, "gtk_builder_list_item_factory_get_bytes");
  link(gtk_builder_list_item_factory_get_resource, "gtk_builder_list_item_factory_get_resource");
  link(gtk_builder_list_item_factory_get_scope, "gtk_builder_list_item_factory_get_scope");

  // BuilderScope
  link(gtk_builder_scope_get_type, "gtk_builder_scope_get_type");

  // Button
  link(gtk_button_get_type, "gtk_button_get_type");
  link(gtk_button_new, "gtk_button_new");
  link(gtk_button_new_from_icon_name, "gtk_button_new_from_icon_name");
  link(gtk_button_new_with_label, "gtk_button_new_with_label");
  link(gtk_button_new_with_mnemonic, "gtk_button_new_with_mnemonic");
  link(gtk_button_get_can_shrink, "gtk_button_get_can_shrink");
  link(gtk_button_get_child, "gtk_button_get_child");
  link(gtk_button_get_has_frame, "gtk_button_get_has_frame");
  link(gtk_button_get_icon_name, "gtk_button_get_icon_name");
  link(gtk_button_get_label, "gtk_button_get_label");
  link(gtk_button_get_use_underline, "gtk_button_get_use_underline");
  link(gtk_button_set_can_shrink, "gtk_button_set_can_shrink");
  link(gtk_button_set_child, "gtk_button_set_child");
  link(gtk_button_set_has_frame, "gtk_button_set_has_frame");
  link(gtk_button_set_icon_name, "gtk_button_set_icon_name");
  link(gtk_button_set_label, "gtk_button_set_label");
  link(gtk_button_set_use_underline, "gtk_button_set_use_underline");

  // CClosureExpression
  link(gtk_cclosure_expression_get_type, "gtk_cclosure_expression_get_type");
  link(gtk_cclosure_expression_new, "gtk_cclosure_expression_new");

  // Calendar
  link(gtk_calendar_get_type, "gtk_calendar_get_type");
  link(gtk_calendar_new, "gtk_calendar_new");
  link(gtk_calendar_clear_marks, "gtk_calendar_clear_marks");
  link(gtk_calendar_get_date, "gtk_calendar_get_date");
  link(gtk_calendar_get_day, "gtk_calendar_get_day");
  link(gtk_calendar_get_day_is_marked, "gtk_calendar_get_day_is_marked");
  link(gtk_calendar_get_month, "gtk_calendar_get_month");
  link(gtk_calendar_get_show_day_names, "gtk_calendar_get_show_day_names");
  link(gtk_calendar_get_show_heading, "gtk_calendar_get_show_heading");
  link(gtk_calendar_get_show_week_numbers, "gtk_calendar_get_show_week_numbers");
  link(gtk_calendar_get_year, "gtk_calendar_get_year");
  link(gtk_calendar_mark_day, "gtk_calendar_mark_day");
  link(gtk_calendar_select_day, "gtk_calendar_select_day");
  link(gtk_calendar_set_day, "gtk_calendar_set_day");
  link(gtk_calendar_set_month, "gtk_calendar_set_month");
  link(gtk_calendar_set_show_day_names, "gtk_calendar_set_show_day_names");
  link(gtk_calendar_set_show_heading, "gtk_calendar_set_show_heading");
  link(gtk_calendar_set_show_week_numbers, "gtk_calendar_set_show_week_numbers");
  link(gtk_calendar_set_year, "gtk_calendar_set_year");
  link(gtk_calendar_unmark_day, "gtk_calendar_unmark_day");

  // CallbackAction
  link(gtk_callback_action_get_type, "gtk_callback_action_get_type");
  link(gtk_callback_action_new, "gtk_callback_action_new");

  // CellArea
  link(gtk_cell_area_get_type, "gtk_cell_area_get_type");
  link(gtk_cell_area_activate, "gtk_cell_area_activate");
  link(gtk_cell_area_activate_cell, "gtk_cell_area_activate_cell");
  link(gtk_cell_area_add, "gtk_cell_area_add");
  link(gtk_cell_area_add_focus_sibling, "gtk_cell_area_add_focus_sibling");
  link(gtk_cell_area_add_with_properties, "gtk_cell_area_add_with_properties");
  link(gtk_cell_area_apply_attributes, "gtk_cell_area_apply_attributes");
  link(gtk_cell_area_attribute_connect, "gtk_cell_area_attribute_connect");
  link(gtk_cell_area_attribute_disconnect, "gtk_cell_area_attribute_disconnect");
  link(gtk_cell_area_attribute_get_column, "gtk_cell_area_attribute_get_column");
  link(gtk_cell_area_cell_get, "gtk_cell_area_cell_get");
  link(gtk_cell_area_cell_get_property, "gtk_cell_area_cell_get_property");
  link(gtk_cell_area_cell_get_valist, "gtk_cell_area_cell_get_valist");
  link(gtk_cell_area_cell_set, "gtk_cell_area_cell_set");
  link(gtk_cell_area_cell_set_property, "gtk_cell_area_cell_set_property");
  link(gtk_cell_area_cell_set_valist, "gtk_cell_area_cell_set_valist");
  link(gtk_cell_area_copy_context, "gtk_cell_area_copy_context");
  link(gtk_cell_area_create_context, "gtk_cell_area_create_context");
  link(gtk_cell_area_event, "gtk_cell_area_event");
  link(gtk_cell_area_focus, "gtk_cell_area_focus");
  link(gtk_cell_area_foreach, "gtk_cell_area_foreach");
  link(gtk_cell_area_foreach_alloc, "gtk_cell_area_foreach_alloc");
  link(gtk_cell_area_get_cell_allocation, "gtk_cell_area_get_cell_allocation");
  link(gtk_cell_area_get_cell_at_position, "gtk_cell_area_get_cell_at_position");
  link(gtk_cell_area_get_current_path_string, "gtk_cell_area_get_current_path_string");
  link(gtk_cell_area_get_edit_widget, "gtk_cell_area_get_edit_widget");
  link(gtk_cell_area_get_edited_cell, "gtk_cell_area_get_edited_cell");
  link(gtk_cell_area_get_focus_cell, "gtk_cell_area_get_focus_cell");
  link(gtk_cell_area_get_focus_from_sibling, "gtk_cell_area_get_focus_from_sibling");
  link(gtk_cell_area_get_focus_siblings, "gtk_cell_area_get_focus_siblings");
  link(gtk_cell_area_get_preferred_height, "gtk_cell_area_get_preferred_height");
  link(gtk_cell_area_get_preferred_height_for_width, "gtk_cell_area_get_preferred_height_for_width");
  link(gtk_cell_area_get_preferred_width, "gtk_cell_area_get_preferred_width");
  link(gtk_cell_area_get_preferred_width_for_height, "gtk_cell_area_get_preferred_width_for_height");
  link(gtk_cell_area_get_request_mode, "gtk_cell_area_get_request_mode");
  link(gtk_cell_area_has_renderer, "gtk_cell_area_has_renderer");
  link(gtk_cell_area_inner_cell_area, "gtk_cell_area_inner_cell_area");
  link(gtk_cell_area_is_activatable, "gtk_cell_area_is_activatable");
  link(gtk_cell_area_is_focus_sibling, "gtk_cell_area_is_focus_sibling");
  link(gtk_cell_area_remove, "gtk_cell_area_remove");
  link(gtk_cell_area_remove_focus_sibling, "gtk_cell_area_remove_focus_sibling");
  link(gtk_cell_area_request_renderer, "gtk_cell_area_request_renderer");
  link(gtk_cell_area_set_focus_cell, "gtk_cell_area_set_focus_cell");
  link(gtk_cell_area_snapshot, "gtk_cell_area_snapshot");
  link(gtk_cell_area_stop_editing, "gtk_cell_area_stop_editing");

  // CellAreaBox
  link(gtk_cell_area_box_get_type, "gtk_cell_area_box_get_type");
  link(gtk_cell_area_box_new, "gtk_cell_area_box_new");
  link(gtk_cell_area_box_get_spacing, "gtk_cell_area_box_get_spacing");
  link(gtk_cell_area_box_pack_end, "gtk_cell_area_box_pack_end");
  link(gtk_cell_area_box_pack_start, "gtk_cell_area_box_pack_start");
  link(gtk_cell_area_box_set_spacing, "gtk_cell_area_box_set_spacing");

  // CellAreaClass
  link(gtk_cell_area_class_find_cell_property, "gtk_cell_area_class_find_cell_property");
  link(gtk_cell_area_class_install_cell_property, "gtk_cell_area_class_install_cell_property");
  link(gtk_cell_area_class_list_cell_properties, "gtk_cell_area_class_list_cell_properties");

  // CellAreaContext
  link(gtk_cell_area_context_get_type, "gtk_cell_area_context_get_type");
  link(gtk_cell_area_context_allocate, "gtk_cell_area_context_allocate");
  link(gtk_cell_area_context_get_allocation, "gtk_cell_area_context_get_allocation");
  link(gtk_cell_area_context_get_area, "gtk_cell_area_context_get_area");
  link(gtk_cell_area_context_get_preferred_height, "gtk_cell_area_context_get_preferred_height");
  link(gtk_cell_area_context_get_preferred_height_for_width, "gtk_cell_area_context_get_preferred_height_for_width");
  link(gtk_cell_area_context_get_preferred_width, "gtk_cell_area_context_get_preferred_width");
  link(gtk_cell_area_context_get_preferred_width_for_height, "gtk_cell_area_context_get_preferred_width_for_height");
  link(gtk_cell_area_context_push_preferred_height, "gtk_cell_area_context_push_preferred_height");
  link(gtk_cell_area_context_push_preferred_width, "gtk_cell_area_context_push_preferred_width");
  link(gtk_cell_area_context_reset, "gtk_cell_area_context_reset");

  // CellEditable
  link(gtk_cell_editable_get_type, "gtk_cell_editable_get_type");
  link(gtk_cell_editable_editing_done, "gtk_cell_editable_editing_done");
  link(gtk_cell_editable_remove_widget, "gtk_cell_editable_remove_widget");
  link(gtk_cell_editable_start_editing, "gtk_cell_editable_start_editing");

  // CellLayout
  link(gtk_cell_layout_get_type, "gtk_cell_layout_get_type");
  link(gtk_cell_layout_add_attribute, "gtk_cell_layout_add_attribute");
  link(gtk_cell_layout_clear, "gtk_cell_layout_clear");
  link(gtk_cell_layout_clear_attributes, "gtk_cell_layout_clear_attributes");
  link(gtk_cell_layout_get_area, "gtk_cell_layout_get_area");
  link(gtk_cell_layout_get_cells, "gtk_cell_layout_get_cells");
  link(gtk_cell_layout_pack_end, "gtk_cell_layout_pack_end");
  link(gtk_cell_layout_pack_start, "gtk_cell_layout_pack_start");
  link(gtk_cell_layout_reorder, "gtk_cell_layout_reorder");
  link(gtk_cell_layout_set_attributes, "gtk_cell_layout_set_attributes");
  link(gtk_cell_layout_set_cell_data_func, "gtk_cell_layout_set_cell_data_func");

  // CellRenderer
  link(gtk_cell_renderer_get_type, "gtk_cell_renderer_get_type");
  link(gtk_cell_renderer_activate, "gtk_cell_renderer_activate");
  link(gtk_cell_renderer_get_aligned_area, "gtk_cell_renderer_get_aligned_area");
  link(gtk_cell_renderer_get_alignment, "gtk_cell_renderer_get_alignment");
  link(gtk_cell_renderer_get_fixed_size, "gtk_cell_renderer_get_fixed_size");
  link(gtk_cell_renderer_get_is_expanded, "gtk_cell_renderer_get_is_expanded");
  link(gtk_cell_renderer_get_is_expander, "gtk_cell_renderer_get_is_expander");
  link(gtk_cell_renderer_get_padding, "gtk_cell_renderer_get_padding");
  link(gtk_cell_renderer_get_preferred_height, "gtk_cell_renderer_get_preferred_height");
  link(gtk_cell_renderer_get_preferred_height_for_width, "gtk_cell_renderer_get_preferred_height_for_width");
  link(gtk_cell_renderer_get_preferred_size, "gtk_cell_renderer_get_preferred_size");
  link(gtk_cell_renderer_get_preferred_width, "gtk_cell_renderer_get_preferred_width");
  link(gtk_cell_renderer_get_preferred_width_for_height, "gtk_cell_renderer_get_preferred_width_for_height");
  link(gtk_cell_renderer_get_request_mode, "gtk_cell_renderer_get_request_mode");
  link(gtk_cell_renderer_get_sensitive, "gtk_cell_renderer_get_sensitive");
  link(gtk_cell_renderer_get_state, "gtk_cell_renderer_get_state");
  link(gtk_cell_renderer_get_visible, "gtk_cell_renderer_get_visible");
  link(gtk_cell_renderer_is_activatable, "gtk_cell_renderer_is_activatable");
  link(gtk_cell_renderer_set_alignment, "gtk_cell_renderer_set_alignment");
  link(gtk_cell_renderer_set_fixed_size, "gtk_cell_renderer_set_fixed_size");
  link(gtk_cell_renderer_set_is_expanded, "gtk_cell_renderer_set_is_expanded");
  link(gtk_cell_renderer_set_is_expander, "gtk_cell_renderer_set_is_expander");
  link(gtk_cell_renderer_set_padding, "gtk_cell_renderer_set_padding");
  link(gtk_cell_renderer_set_sensitive, "gtk_cell_renderer_set_sensitive");
  link(gtk_cell_renderer_set_visible, "gtk_cell_renderer_set_visible");
  link(gtk_cell_renderer_snapshot, "gtk_cell_renderer_snapshot");
  link(gtk_cell_renderer_start_editing, "gtk_cell_renderer_start_editing");
  link(gtk_cell_renderer_stop_editing, "gtk_cell_renderer_stop_editing");

  // CellRendererAccel
  link(gtk_cell_renderer_accel_get_type, "gtk_cell_renderer_accel_get_type");
  link(gtk_cell_renderer_accel_new, "gtk_cell_renderer_accel_new");

  // CellRendererCombo
  link(gtk_cell_renderer_combo_get_type, "gtk_cell_renderer_combo_get_type");
  link(gtk_cell_renderer_combo_new, "gtk_cell_renderer_combo_new");

  // CellRendererPixbuf
  link(gtk_cell_renderer_pixbuf_get_type, "gtk_cell_renderer_pixbuf_get_type");
  link(gtk_cell_renderer_pixbuf_new, "gtk_cell_renderer_pixbuf_new");

  // CellRendererProgress
  link(gtk_cell_renderer_progress_get_type, "gtk_cell_renderer_progress_get_type");
  link(gtk_cell_renderer_progress_new, "gtk_cell_renderer_progress_new");

  // CellRendererSpin
  link(gtk_cell_renderer_spin_get_type, "gtk_cell_renderer_spin_get_type");
  link(gtk_cell_renderer_spin_new, "gtk_cell_renderer_spin_new");

  // CellRendererSpinner
  link(gtk_cell_renderer_spinner_get_type, "gtk_cell_renderer_spinner_get_type");
  link(gtk_cell_renderer_spinner_new, "gtk_cell_renderer_spinner_new");

  // CellRendererText
  link(gtk_cell_renderer_text_get_type, "gtk_cell_renderer_text_get_type");
  link(gtk_cell_renderer_text_new, "gtk_cell_renderer_text_new");
  link(gtk_cell_renderer_text_set_fixed_height_from_font, "gtk_cell_renderer_text_set_fixed_height_from_font");

  // CellRendererToggle
  link(gtk_cell_renderer_toggle_get_type, "gtk_cell_renderer_toggle_get_type");
  link(gtk_cell_renderer_toggle_new, "gtk_cell_renderer_toggle_new");
  link(gtk_cell_renderer_toggle_get_activatable, "gtk_cell_renderer_toggle_get_activatable");
  link(gtk_cell_renderer_toggle_get_active, "gtk_cell_renderer_toggle_get_active");
  link(gtk_cell_renderer_toggle_get_radio, "gtk_cell_renderer_toggle_get_radio");
  link(gtk_cell_renderer_toggle_set_activatable, "gtk_cell_renderer_toggle_set_activatable");
  link(gtk_cell_renderer_toggle_set_active, "gtk_cell_renderer_toggle_set_active");
  link(gtk_cell_renderer_toggle_set_radio, "gtk_cell_renderer_toggle_set_radio");

  // CellView
  link(gtk_cell_view_get_type, "gtk_cell_view_get_type");
  link(gtk_cell_view_new, "gtk_cell_view_new");
  link(gtk_cell_view_new_with_context, "gtk_cell_view_new_with_context");
  link(gtk_cell_view_new_with_markup, "gtk_cell_view_new_with_markup");
  link(gtk_cell_view_new_with_text, "gtk_cell_view_new_with_text");
  link(gtk_cell_view_new_with_texture, "gtk_cell_view_new_with_texture");
  link(gtk_cell_view_get_displayed_row, "gtk_cell_view_get_displayed_row");
  link(gtk_cell_view_get_draw_sensitive, "gtk_cell_view_get_draw_sensitive");
  link(gtk_cell_view_get_fit_model, "gtk_cell_view_get_fit_model");
  link(gtk_cell_view_get_model, "gtk_cell_view_get_model");
  link(gtk_cell_view_set_displayed_row, "gtk_cell_view_set_displayed_row");
  link(gtk_cell_view_set_draw_sensitive, "gtk_cell_view_set_draw_sensitive");
  link(gtk_cell_view_set_fit_model, "gtk_cell_view_set_fit_model");
  link(gtk_cell_view_set_model, "gtk_cell_view_set_model");

  // CenterBox
  link(gtk_center_box_get_type, "gtk_center_box_get_type");
  link(gtk_center_box_new, "gtk_center_box_new");
  link(gtk_center_box_get_baseline_position, "gtk_center_box_get_baseline_position");
  link(gtk_center_box_get_center_widget, "gtk_center_box_get_center_widget");
  link(gtk_center_box_get_end_widget, "gtk_center_box_get_end_widget");
  link(gtk_center_box_get_shrink_center_last, "gtk_center_box_get_shrink_center_last");
  link(gtk_center_box_get_start_widget, "gtk_center_box_get_start_widget");
  link(gtk_center_box_set_baseline_position, "gtk_center_box_set_baseline_position");
  link(gtk_center_box_set_center_widget, "gtk_center_box_set_center_widget");
  link(gtk_center_box_set_end_widget, "gtk_center_box_set_end_widget");
  link(gtk_center_box_set_shrink_center_last, "gtk_center_box_set_shrink_center_last");
  link(gtk_center_box_set_start_widget, "gtk_center_box_set_start_widget");

  // CenterLayout
  link(gtk_center_layout_get_type, "gtk_center_layout_get_type");
  link(gtk_center_layout_new, "gtk_center_layout_new");
  link(gtk_center_layout_get_baseline_position, "gtk_center_layout_get_baseline_position");
  link(gtk_center_layout_get_center_widget, "gtk_center_layout_get_center_widget");
  link(gtk_center_layout_get_end_widget, "gtk_center_layout_get_end_widget");
  link(gtk_center_layout_get_orientation, "gtk_center_layout_get_orientation");
  link(gtk_center_layout_get_shrink_center_last, "gtk_center_layout_get_shrink_center_last");
  link(gtk_center_layout_get_start_widget, "gtk_center_layout_get_start_widget");
  link(gtk_center_layout_set_baseline_position, "gtk_center_layout_set_baseline_position");
  link(gtk_center_layout_set_center_widget, "gtk_center_layout_set_center_widget");
  link(gtk_center_layout_set_end_widget, "gtk_center_layout_set_end_widget");
  link(gtk_center_layout_set_orientation, "gtk_center_layout_set_orientation");
  link(gtk_center_layout_set_shrink_center_last, "gtk_center_layout_set_shrink_center_last");
  link(gtk_center_layout_set_start_widget, "gtk_center_layout_set_start_widget");

  // CheckButton
  link(gtk_check_button_get_type, "gtk_check_button_get_type");
  link(gtk_check_button_new, "gtk_check_button_new");
  link(gtk_check_button_new_with_label, "gtk_check_button_new_with_label");
  link(gtk_check_button_new_with_mnemonic, "gtk_check_button_new_with_mnemonic");
  link(gtk_check_button_get_active, "gtk_check_button_get_active");
  link(gtk_check_button_get_child, "gtk_check_button_get_child");
  link(gtk_check_button_get_inconsistent, "gtk_check_button_get_inconsistent");
  link(gtk_check_button_get_label, "gtk_check_button_get_label");
  link(gtk_check_button_get_use_underline, "gtk_check_button_get_use_underline");
  link(gtk_check_button_set_active, "gtk_check_button_set_active");
  link(gtk_check_button_set_child, "gtk_check_button_set_child");
  link(gtk_check_button_set_group, "gtk_check_button_set_group");
  link(gtk_check_button_set_inconsistent, "gtk_check_button_set_inconsistent");
  link(gtk_check_button_set_label, "gtk_check_button_set_label");
  link(gtk_check_button_set_use_underline, "gtk_check_button_set_use_underline");

  // ClosureExpression
  link(gtk_closure_expression_get_type, "gtk_closure_expression_get_type");
  link(gtk_closure_expression_new, "gtk_closure_expression_new");

  // ColorButton
  link(gtk_color_button_get_type, "gtk_color_button_get_type");
  link(gtk_color_button_new, "gtk_color_button_new");
  link(gtk_color_button_new_with_rgba, "gtk_color_button_new_with_rgba");
  link(gtk_color_button_get_modal, "gtk_color_button_get_modal");
  link(gtk_color_button_get_title, "gtk_color_button_get_title");
  link(gtk_color_button_set_modal, "gtk_color_button_set_modal");
  link(gtk_color_button_set_title, "gtk_color_button_set_title");

  // ColorChooser
  link(gtk_color_chooser_get_type, "gtk_color_chooser_get_type");
  link(gtk_color_chooser_add_palette, "gtk_color_chooser_add_palette");
  link(gtk_color_chooser_get_rgba, "gtk_color_chooser_get_rgba");
  link(gtk_color_chooser_get_use_alpha, "gtk_color_chooser_get_use_alpha");
  link(gtk_color_chooser_set_rgba, "gtk_color_chooser_set_rgba");
  link(gtk_color_chooser_set_use_alpha, "gtk_color_chooser_set_use_alpha");

  // ColorChooserDialog
  link(gtk_color_chooser_dialog_get_type, "gtk_color_chooser_dialog_get_type");
  link(gtk_color_chooser_dialog_new, "gtk_color_chooser_dialog_new");

  // ColorChooserWidget
  link(gtk_color_chooser_widget_get_type, "gtk_color_chooser_widget_get_type");
  link(gtk_color_chooser_widget_new, "gtk_color_chooser_widget_new");

  // ColorDialog
  link(gtk_color_dialog_get_type, "gtk_color_dialog_get_type");
  link(gtk_color_dialog_new, "gtk_color_dialog_new");
  link(gtk_color_dialog_choose_rgba, "gtk_color_dialog_choose_rgba");
  link(gtk_color_dialog_choose_rgba_finish, "gtk_color_dialog_choose_rgba_finish");
  link(gtk_color_dialog_get_modal, "gtk_color_dialog_get_modal");
  link(gtk_color_dialog_get_title, "gtk_color_dialog_get_title");
  link(gtk_color_dialog_get_with_alpha, "gtk_color_dialog_get_with_alpha");
  link(gtk_color_dialog_set_modal, "gtk_color_dialog_set_modal");
  link(gtk_color_dialog_set_title, "gtk_color_dialog_set_title");
  link(gtk_color_dialog_set_with_alpha, "gtk_color_dialog_set_with_alpha");

  // ColorDialogButton
  link(gtk_color_dialog_button_get_type, "gtk_color_dialog_button_get_type");
  link(gtk_color_dialog_button_new, "gtk_color_dialog_button_new");
  link(gtk_color_dialog_button_get_dialog, "gtk_color_dialog_button_get_dialog");
  link(gtk_color_dialog_button_get_rgba, "gtk_color_dialog_button_get_rgba");
  link(gtk_color_dialog_button_set_dialog, "gtk_color_dialog_button_set_dialog");
  link(gtk_color_dialog_button_set_rgba, "gtk_color_dialog_button_set_rgba");

  // ColumnView
  link(gtk_column_view_get_type, "gtk_column_view_get_type");
  link(gtk_column_view_new, "gtk_column_view_new");
  link(gtk_column_view_append_column, "gtk_column_view_append_column");
  link(gtk_column_view_get_columns, "gtk_column_view_get_columns");
  link(gtk_column_view_get_enable_rubberband, "gtk_column_view_get_enable_rubberband");
  link(gtk_column_view_get_header_factory, "gtk_column_view_get_header_factory");
  link(gtk_column_view_get_model, "gtk_column_view_get_model");
  link(gtk_column_view_get_reorderable, "gtk_column_view_get_reorderable");
  link(gtk_column_view_get_row_factory, "gtk_column_view_get_row_factory");
  link(gtk_column_view_get_show_column_separators, "gtk_column_view_get_show_column_separators");
  link(gtk_column_view_get_show_row_separators, "gtk_column_view_get_show_row_separators");
  link(gtk_column_view_get_single_click_activate, "gtk_column_view_get_single_click_activate");
  link(gtk_column_view_get_sorter, "gtk_column_view_get_sorter");
  link(gtk_column_view_get_tab_behavior, "gtk_column_view_get_tab_behavior");
  link(gtk_column_view_insert_column, "gtk_column_view_insert_column");
  link(gtk_column_view_remove_column, "gtk_column_view_remove_column");
  link(gtk_column_view_scroll_to, "gtk_column_view_scroll_to");
  link(gtk_column_view_set_enable_rubberband, "gtk_column_view_set_enable_rubberband");
  link(gtk_column_view_set_header_factory, "gtk_column_view_set_header_factory");
  link(gtk_column_view_set_model, "gtk_column_view_set_model");
  link(gtk_column_view_set_reorderable, "gtk_column_view_set_reorderable");
  link(gtk_column_view_set_row_factory, "gtk_column_view_set_row_factory");
  link(gtk_column_view_set_show_column_separators, "gtk_column_view_set_show_column_separators");
  link(gtk_column_view_set_show_row_separators, "gtk_column_view_set_show_row_separators");
  link(gtk_column_view_set_single_click_activate, "gtk_column_view_set_single_click_activate");
  link(gtk_column_view_set_tab_behavior, "gtk_column_view_set_tab_behavior");
  link(gtk_column_view_sort_by_column, "gtk_column_view_sort_by_column");

  // ColumnViewCell
  link(gtk_column_view_cell_get_type, "gtk_column_view_cell_get_type");
  link(gtk_column_view_cell_get_child, "gtk_column_view_cell_get_child");
  link(gtk_column_view_cell_get_focusable, "gtk_column_view_cell_get_focusable");
  link(gtk_column_view_cell_get_item, "gtk_column_view_cell_get_item");
  link(gtk_column_view_cell_get_position, "gtk_column_view_cell_get_position");
  link(gtk_column_view_cell_get_selected, "gtk_column_view_cell_get_selected");
  link(gtk_column_view_cell_set_child, "gtk_column_view_cell_set_child");
  link(gtk_column_view_cell_set_focusable, "gtk_column_view_cell_set_focusable");

  // ColumnViewColumn
  link(gtk_column_view_column_get_type, "gtk_column_view_column_get_type");
  link(gtk_column_view_column_new, "gtk_column_view_column_new");
  link(gtk_column_view_column_get_column_view, "gtk_column_view_column_get_column_view");
  link(gtk_column_view_column_get_expand, "gtk_column_view_column_get_expand");
  link(gtk_column_view_column_get_factory, "gtk_column_view_column_get_factory");
  link(gtk_column_view_column_get_fixed_width, "gtk_column_view_column_get_fixed_width");
  link(gtk_column_view_column_get_header_menu, "gtk_column_view_column_get_header_menu");
  link(gtk_column_view_column_get_id, "gtk_column_view_column_get_id");
  link(gtk_column_view_column_get_resizable, "gtk_column_view_column_get_resizable");
  link(gtk_column_view_column_get_sorter, "gtk_column_view_column_get_sorter");
  link(gtk_column_view_column_get_title, "gtk_column_view_column_get_title");
  link(gtk_column_view_column_get_visible, "gtk_column_view_column_get_visible");
  link(gtk_column_view_column_set_expand, "gtk_column_view_column_set_expand");
  link(gtk_column_view_column_set_factory, "gtk_column_view_column_set_factory");
  link(gtk_column_view_column_set_fixed_width, "gtk_column_view_column_set_fixed_width");
  link(gtk_column_view_column_set_header_menu, "gtk_column_view_column_set_header_menu");
  link(gtk_column_view_column_set_id, "gtk_column_view_column_set_id");
  link(gtk_column_view_column_set_resizable, "gtk_column_view_column_set_resizable");
  link(gtk_column_view_column_set_sorter, "gtk_column_view_column_set_sorter");
  link(gtk_column_view_column_set_title, "gtk_column_view_column_set_title");
  link(gtk_column_view_column_set_visible, "gtk_column_view_column_set_visible");

  // ColumnViewRow
  link(gtk_column_view_row_get_type, "gtk_column_view_row_get_type");
  link(gtk_column_view_row_get_accessible_description, "gtk_column_view_row_get_accessible_description");
  link(gtk_column_view_row_get_accessible_label, "gtk_column_view_row_get_accessible_label");
  link(gtk_column_view_row_get_activatable, "gtk_column_view_row_get_activatable");
  link(gtk_column_view_row_get_focusable, "gtk_column_view_row_get_focusable");
  link(gtk_column_view_row_get_item, "gtk_column_view_row_get_item");
  link(gtk_column_view_row_get_position, "gtk_column_view_row_get_position");
  link(gtk_column_view_row_get_selectable, "gtk_column_view_row_get_selectable");
  link(gtk_column_view_row_get_selected, "gtk_column_view_row_get_selected");
  link(gtk_column_view_row_set_accessible_description, "gtk_column_view_row_set_accessible_description");
  link(gtk_column_view_row_set_accessible_label, "gtk_column_view_row_set_accessible_label");
  link(gtk_column_view_row_set_activatable, "gtk_column_view_row_set_activatable");
  link(gtk_column_view_row_set_focusable, "gtk_column_view_row_set_focusable");
  link(gtk_column_view_row_set_selectable, "gtk_column_view_row_set_selectable");

  // ColumnViewSorter
  link(gtk_column_view_sorter_get_type, "gtk_column_view_sorter_get_type");
  link(gtk_column_view_sorter_get_n_sort_columns, "gtk_column_view_sorter_get_n_sort_columns");
  link(gtk_column_view_sorter_get_nth_sort_column, "gtk_column_view_sorter_get_nth_sort_column");
  link(gtk_column_view_sorter_get_primary_sort_column, "gtk_column_view_sorter_get_primary_sort_column");
  link(gtk_column_view_sorter_get_primary_sort_order, "gtk_column_view_sorter_get_primary_sort_order");

  // ComboBox
  link(gtk_combo_box_get_type, "gtk_combo_box_get_type");
  link(gtk_combo_box_new, "gtk_combo_box_new");
  link(gtk_combo_box_new_with_entry, "gtk_combo_box_new_with_entry");
  link(gtk_combo_box_new_with_model, "gtk_combo_box_new_with_model");
  link(gtk_combo_box_new_with_model_and_entry, "gtk_combo_box_new_with_model_and_entry");
  link(gtk_combo_box_get_active, "gtk_combo_box_get_active");
  link(gtk_combo_box_get_active_id, "gtk_combo_box_get_active_id");
  link(gtk_combo_box_get_active_iter, "gtk_combo_box_get_active_iter");
  link(gtk_combo_box_get_button_sensitivity, "gtk_combo_box_get_button_sensitivity");
  link(gtk_combo_box_get_child, "gtk_combo_box_get_child");
  link(gtk_combo_box_get_entry_text_column, "gtk_combo_box_get_entry_text_column");
  link(gtk_combo_box_get_has_entry, "gtk_combo_box_get_has_entry");
  link(gtk_combo_box_get_id_column, "gtk_combo_box_get_id_column");
  link(gtk_combo_box_get_model, "gtk_combo_box_get_model");
  link(gtk_combo_box_get_popup_fixed_width, "gtk_combo_box_get_popup_fixed_width");
  link(gtk_combo_box_get_row_separator_func, "gtk_combo_box_get_row_separator_func");
  link(gtk_combo_box_popdown, "gtk_combo_box_popdown");
  link(gtk_combo_box_popup, "gtk_combo_box_popup");
  link(gtk_combo_box_popup_for_device, "gtk_combo_box_popup_for_device");
  link(gtk_combo_box_set_active, "gtk_combo_box_set_active");
  link(gtk_combo_box_set_active_id, "gtk_combo_box_set_active_id");
  link(gtk_combo_box_set_active_iter, "gtk_combo_box_set_active_iter");
  link(gtk_combo_box_set_button_sensitivity, "gtk_combo_box_set_button_sensitivity");
  link(gtk_combo_box_set_child, "gtk_combo_box_set_child");
  link(gtk_combo_box_set_entry_text_column, "gtk_combo_box_set_entry_text_column");
  link(gtk_combo_box_set_id_column, "gtk_combo_box_set_id_column");
  link(gtk_combo_box_set_model, "gtk_combo_box_set_model");
  link(gtk_combo_box_set_popup_fixed_width, "gtk_combo_box_set_popup_fixed_width");
  link(gtk_combo_box_set_row_separator_func, "gtk_combo_box_set_row_separator_func");

  // ComboBoxText
  link(gtk_combo_box_text_get_type, "gtk_combo_box_text_get_type");
  link(gtk_combo_box_text_new, "gtk_combo_box_text_new");
  link(gtk_combo_box_text_new_with_entry, "gtk_combo_box_text_new_with_entry");
  link(gtk_combo_box_text_append, "gtk_combo_box_text_append");
  link(gtk_combo_box_text_append_text, "gtk_combo_box_text_append_text");
  link(gtk_combo_box_text_get_active_text, "gtk_combo_box_text_get_active_text");
  link(gtk_combo_box_text_insert, "gtk_combo_box_text_insert");
  link(gtk_combo_box_text_insert_text, "gtk_combo_box_text_insert_text");
  link(gtk_combo_box_text_prepend, "gtk_combo_box_text_prepend");
  link(gtk_combo_box_text_prepend_text, "gtk_combo_box_text_prepend_text");
  link(gtk_combo_box_text_remove, "gtk_combo_box_text_remove");
  link(gtk_combo_box_text_remove_all, "gtk_combo_box_text_remove_all");

  // ConstantExpression
  link(gtk_constant_expression_get_type, "gtk_constant_expression_get_type");
  link(gtk_constant_expression_new, "gtk_constant_expression_new");
  link(gtk_constant_expression_new_for_value, "gtk_constant_expression_new_for_value");
  link(gtk_constant_expression_get_value, "gtk_constant_expression_get_value");

  // Constraint
  link(gtk_constraint_get_type, "gtk_constraint_get_type");
  link(gtk_constraint_new, "gtk_constraint_new");
  link(gtk_constraint_new_constant, "gtk_constraint_new_constant");
  link(gtk_constraint_get_constant, "gtk_constraint_get_constant");
  link(gtk_constraint_get_multiplier, "gtk_constraint_get_multiplier");
  link(gtk_constraint_get_relation, "gtk_constraint_get_relation");
  link(gtk_constraint_get_source, "gtk_constraint_get_source");
  link(gtk_constraint_get_source_attribute, "gtk_constraint_get_source_attribute");
  link(gtk_constraint_get_strength, "gtk_constraint_get_strength");
  link(gtk_constraint_get_target, "gtk_constraint_get_target");
  link(gtk_constraint_get_target_attribute, "gtk_constraint_get_target_attribute");
  link(gtk_constraint_is_attached, "gtk_constraint_is_attached");
  link(gtk_constraint_is_constant, "gtk_constraint_is_constant");
  link(gtk_constraint_is_required, "gtk_constraint_is_required");

  // ConstraintGuide
  link(gtk_constraint_guide_get_type, "gtk_constraint_guide_get_type");
  link(gtk_constraint_guide_new, "gtk_constraint_guide_new");
  link(gtk_constraint_guide_get_max_size, "gtk_constraint_guide_get_max_size");
  link(gtk_constraint_guide_get_min_size, "gtk_constraint_guide_get_min_size");
  link(gtk_constraint_guide_get_name, "gtk_constraint_guide_get_name");
  link(gtk_constraint_guide_get_nat_size, "gtk_constraint_guide_get_nat_size");
  link(gtk_constraint_guide_get_strength, "gtk_constraint_guide_get_strength");
  link(gtk_constraint_guide_set_max_size, "gtk_constraint_guide_set_max_size");
  link(gtk_constraint_guide_set_min_size, "gtk_constraint_guide_set_min_size");
  link(gtk_constraint_guide_set_name, "gtk_constraint_guide_set_name");
  link(gtk_constraint_guide_set_nat_size, "gtk_constraint_guide_set_nat_size");
  link(gtk_constraint_guide_set_strength, "gtk_constraint_guide_set_strength");

  // ConstraintLayout
  link(gtk_constraint_layout_get_type, "gtk_constraint_layout_get_type");
  link(gtk_constraint_layout_new, "gtk_constraint_layout_new");
  link(gtk_constraint_layout_add_constraint, "gtk_constraint_layout_add_constraint");
  link(gtk_constraint_layout_add_constraints_from_description, "gtk_constraint_layout_add_constraints_from_description");
  link(gtk_constraint_layout_add_constraints_from_descriptionv, "gtk_constraint_layout_add_constraints_from_descriptionv");
  link(gtk_constraint_layout_add_guide, "gtk_constraint_layout_add_guide");
  link(gtk_constraint_layout_observe_constraints, "gtk_constraint_layout_observe_constraints");
  link(gtk_constraint_layout_observe_guides, "gtk_constraint_layout_observe_guides");
  link(gtk_constraint_layout_remove_all_constraints, "gtk_constraint_layout_remove_all_constraints");
  link(gtk_constraint_layout_remove_constraint, "gtk_constraint_layout_remove_constraint");
  link(gtk_constraint_layout_remove_guide, "gtk_constraint_layout_remove_guide");

  // ConstraintLayoutChild
  link(gtk_constraint_layout_child_get_type, "gtk_constraint_layout_child_get_type");

  // ConstraintTarget
  link(gtk_constraint_target_get_type, "gtk_constraint_target_get_type");

  // CssProvider
  link(gtk_css_provider_get_type, "gtk_css_provider_get_type");
  link(gtk_css_provider_new, "gtk_css_provider_new");
  link(gtk_css_provider_load_from_bytes, "gtk_css_provider_load_from_bytes");
  link(gtk_css_provider_load_from_data, "gtk_css_provider_load_from_data");
  link(gtk_css_provider_load_from_file, "gtk_css_provider_load_from_file");
  link(gtk_css_provider_load_from_path, "gtk_css_provider_load_from_path");
  link(gtk_css_provider_load_from_resource, "gtk_css_provider_load_from_resource");
  link(gtk_css_provider_load_from_string, "gtk_css_provider_load_from_string");
  link(gtk_css_provider_load_named, "gtk_css_provider_load_named");
  link(gtk_css_provider_to_string, "gtk_css_provider_to_string");

  // CssSection
  link(gtk_css_section_get_type, "gtk_css_section_get_type");
  link(gtk_css_section_new, "gtk_css_section_new");
  link(gtk_css_section_get_end_location, "gtk_css_section_get_end_location");
  link(gtk_css_section_get_file, "gtk_css_section_get_file");
  link(gtk_css_section_get_parent, "gtk_css_section_get_parent");
  link(gtk_css_section_get_start_location, "gtk_css_section_get_start_location");
  link(gtk_css_section_print, "gtk_css_section_print");
  link(gtk_css_section_ref, "gtk_css_section_ref");
  link(gtk_css_section_to_string, "gtk_css_section_to_string");
  link(gtk_css_section_unref, "gtk_css_section_unref");

  // CustomFilter
  link(gtk_custom_filter_get_type, "gtk_custom_filter_get_type");
  link(gtk_custom_filter_new, "gtk_custom_filter_new");
  link(gtk_custom_filter_set_filter_func, "gtk_custom_filter_set_filter_func");

  // CustomLayout
  link(gtk_custom_layout_get_type, "gtk_custom_layout_get_type");
  link(gtk_custom_layout_new, "gtk_custom_layout_new");

  // CustomSorter
  link(gtk_custom_sorter_get_type, "gtk_custom_sorter_get_type");
  link(gtk_custom_sorter_new, "gtk_custom_sorter_new");
  link(gtk_custom_sorter_set_sort_func, "gtk_custom_sorter_set_sort_func");

  // Dialog
  link(gtk_dialog_get_type, "gtk_dialog_get_type");
  link(gtk_dialog_new, "gtk_dialog_new");
  link(gtk_dialog_new_with_buttons, "gtk_dialog_new_with_buttons");
  link(gtk_dialog_add_action_widget, "gtk_dialog_add_action_widget");
  link(gtk_dialog_add_button, "gtk_dialog_add_button");
  link(gtk_dialog_add_buttons, "gtk_dialog_add_buttons");
  link(gtk_dialog_get_content_area, "gtk_dialog_get_content_area");
  link(gtk_dialog_get_header_bar, "gtk_dialog_get_header_bar");
  link(gtk_dialog_get_response_for_widget, "gtk_dialog_get_response_for_widget");
  link(gtk_dialog_get_widget_for_response, "gtk_dialog_get_widget_for_response");
  link(gtk_dialog_response, "gtk_dialog_response");
  link(gtk_dialog_set_default_response, "gtk_dialog_set_default_response");
  link(gtk_dialog_set_response_sensitive, "gtk_dialog_set_response_sensitive");

  // DirectoryList
  link(gtk_directory_list_get_type, "gtk_directory_list_get_type");
  link(gtk_directory_list_new, "gtk_directory_list_new");
  link(gtk_directory_list_get_attributes, "gtk_directory_list_get_attributes");
  link(gtk_directory_list_get_error, "gtk_directory_list_get_error");
  link(gtk_directory_list_get_file, "gtk_directory_list_get_file");
  link(gtk_directory_list_get_io_priority, "gtk_directory_list_get_io_priority");
  link(gtk_directory_list_get_monitored, "gtk_directory_list_get_monitored");
  link(gtk_directory_list_is_loading, "gtk_directory_list_is_loading");
  link(gtk_directory_list_set_attributes, "gtk_directory_list_set_attributes");
  link(gtk_directory_list_set_file, "gtk_directory_list_set_file");
  link(gtk_directory_list_set_io_priority, "gtk_directory_list_set_io_priority");
  link(gtk_directory_list_set_monitored, "gtk_directory_list_set_monitored");

  // DragIcon
  link(gtk_drag_icon_get_type, "gtk_drag_icon_get_type");
  link(gtk_drag_icon_create_widget_for_value, "gtk_drag_icon_create_widget_for_value");
  link(gtk_drag_icon_get_for_drag, "gtk_drag_icon_get_for_drag");
  link(gtk_drag_icon_set_from_paintable, "gtk_drag_icon_set_from_paintable");
  link(gtk_drag_icon_get_child, "gtk_drag_icon_get_child");
  link(gtk_drag_icon_set_child, "gtk_drag_icon_set_child");

  // DragSource
  link(gtk_drag_source_get_type, "gtk_drag_source_get_type");
  link(gtk_drag_source_new, "gtk_drag_source_new");
  link(gtk_drag_source_drag_cancel, "gtk_drag_source_drag_cancel");
  link(gtk_drag_source_get_actions, "gtk_drag_source_get_actions");
  link(gtk_drag_source_get_content, "gtk_drag_source_get_content");
  link(gtk_drag_source_get_drag, "gtk_drag_source_get_drag");
  link(gtk_drag_source_set_actions, "gtk_drag_source_set_actions");
  link(gtk_drag_source_set_content, "gtk_drag_source_set_content");
  link(gtk_drag_source_set_icon, "gtk_drag_source_set_icon");

  // DrawingArea
  link(gtk_drawing_area_get_type, "gtk_drawing_area_get_type");
  link(gtk_drawing_area_new, "gtk_drawing_area_new");
  link(gtk_drawing_area_get_content_height, "gtk_drawing_area_get_content_height");
  link(gtk_drawing_area_get_content_width, "gtk_drawing_area_get_content_width");
  link(gtk_drawing_area_set_content_height, "gtk_drawing_area_set_content_height");
  link(gtk_drawing_area_set_content_width, "gtk_drawing_area_set_content_width");
  link(gtk_drawing_area_set_draw_func, "gtk_drawing_area_set_draw_func");

  // DropControllerMotion
  link(gtk_drop_controller_motion_get_type, "gtk_drop_controller_motion_get_type");
  link(gtk_drop_controller_motion_new, "gtk_drop_controller_motion_new");
  link(gtk_drop_controller_motion_contains_pointer, "gtk_drop_controller_motion_contains_pointer");
  link(gtk_drop_controller_motion_get_drop, "gtk_drop_controller_motion_get_drop");
  link(gtk_drop_controller_motion_is_pointer, "gtk_drop_controller_motion_is_pointer");

  // DropDown
  link(gtk_drop_down_get_type, "gtk_drop_down_get_type");
  link(gtk_drop_down_new, "gtk_drop_down_new");
  link(gtk_drop_down_new_from_strings, "gtk_drop_down_new_from_strings");
  link(gtk_drop_down_get_enable_search, "gtk_drop_down_get_enable_search");
  link(gtk_drop_down_get_expression, "gtk_drop_down_get_expression");
  link(gtk_drop_down_get_factory, "gtk_drop_down_get_factory");
  link(gtk_drop_down_get_header_factory, "gtk_drop_down_get_header_factory");
  link(gtk_drop_down_get_list_factory, "gtk_drop_down_get_list_factory");
  link(gtk_drop_down_get_model, "gtk_drop_down_get_model");
  link(gtk_drop_down_get_search_match_mode, "gtk_drop_down_get_search_match_mode");
  link(gtk_drop_down_get_selected, "gtk_drop_down_get_selected");
  link(gtk_drop_down_get_selected_item, "gtk_drop_down_get_selected_item");
  link(gtk_drop_down_get_show_arrow, "gtk_drop_down_get_show_arrow");
  link(gtk_drop_down_set_enable_search, "gtk_drop_down_set_enable_search");
  link(gtk_drop_down_set_expression, "gtk_drop_down_set_expression");
  link(gtk_drop_down_set_factory, "gtk_drop_down_set_factory");
  link(gtk_drop_down_set_header_factory, "gtk_drop_down_set_header_factory");
  link(gtk_drop_down_set_list_factory, "gtk_drop_down_set_list_factory");
  link(gtk_drop_down_set_model, "gtk_drop_down_set_model");
  link(gtk_drop_down_set_search_match_mode, "gtk_drop_down_set_search_match_mode");
  link(gtk_drop_down_set_selected, "gtk_drop_down_set_selected");
  link(gtk_drop_down_set_show_arrow, "gtk_drop_down_set_show_arrow");

  // DropTarget
  link(gtk_drop_target_get_type, "gtk_drop_target_get_type");
  link(gtk_drop_target_new, "gtk_drop_target_new");
  link(gtk_drop_target_get_actions, "gtk_drop_target_get_actions");
  link(gtk_drop_target_get_current_drop, "gtk_drop_target_get_current_drop");
  link(gtk_drop_target_get_drop, "gtk_drop_target_get_drop");
  link(gtk_drop_target_get_formats, "gtk_drop_target_get_formats");
  link(gtk_drop_target_get_gtypes, "gtk_drop_target_get_gtypes");
  link(gtk_drop_target_get_preload, "gtk_drop_target_get_preload");
  link(gtk_drop_target_get_value, "gtk_drop_target_get_value");
  link(gtk_drop_target_reject, "gtk_drop_target_reject");
  link(gtk_drop_target_set_actions, "gtk_drop_target_set_actions");
  link(gtk_drop_target_set_gtypes, "gtk_drop_target_set_gtypes");
  link(gtk_drop_target_set_preload, "gtk_drop_target_set_preload");

  // DropTargetAsync
  link(gtk_drop_target_async_get_type, "gtk_drop_target_async_get_type");
  link(gtk_drop_target_async_new, "gtk_drop_target_async_new");
  link(gtk_drop_target_async_get_actions, "gtk_drop_target_async_get_actions");
  link(gtk_drop_target_async_get_formats, "gtk_drop_target_async_get_formats");
  link(gtk_drop_target_async_reject_drop, "gtk_drop_target_async_reject_drop");
  link(gtk_drop_target_async_set_actions, "gtk_drop_target_async_set_actions");
  link(gtk_drop_target_async_set_formats, "gtk_drop_target_async_set_formats");

  // Editable
  link(gtk_editable_get_type, "gtk_editable_get_type");
  link(gtk_editable_delegate_get_property, "gtk_editable_delegate_get_property");
  link(gtk_editable_delegate_set_property, "gtk_editable_delegate_set_property");
  link(gtk_editable_install_properties, "gtk_editable_install_properties");
  link(gtk_editable_delegate_get_accessible_platform_state, "gtk_editable_delegate_get_accessible_platform_state");
  link(gtk_editable_delete_selection, "gtk_editable_delete_selection");
  link(gtk_editable_delete_text, "gtk_editable_delete_text");
  link(gtk_editable_finish_delegate, "gtk_editable_finish_delegate");
  link(gtk_editable_get_alignment, "gtk_editable_get_alignment");
  link(gtk_editable_get_chars, "gtk_editable_get_chars");
  link(gtk_editable_get_delegate, "gtk_editable_get_delegate");
  link(gtk_editable_get_editable, "gtk_editable_get_editable");
  link(gtk_editable_get_enable_undo, "gtk_editable_get_enable_undo");
  link(gtk_editable_get_max_width_chars, "gtk_editable_get_max_width_chars");
  link(gtk_editable_get_position, "gtk_editable_get_position");
  link(gtk_editable_get_selection_bounds, "gtk_editable_get_selection_bounds");
  link(gtk_editable_get_text, "gtk_editable_get_text");
  link(gtk_editable_get_width_chars, "gtk_editable_get_width_chars");
  link(gtk_editable_init_delegate, "gtk_editable_init_delegate");
  link(gtk_editable_insert_text, "gtk_editable_insert_text");
  link(gtk_editable_select_region, "gtk_editable_select_region");
  link(gtk_editable_set_alignment, "gtk_editable_set_alignment");
  link(gtk_editable_set_editable, "gtk_editable_set_editable");
  link(gtk_editable_set_enable_undo, "gtk_editable_set_enable_undo");
  link(gtk_editable_set_max_width_chars, "gtk_editable_set_max_width_chars");
  link(gtk_editable_set_position, "gtk_editable_set_position");
  link(gtk_editable_set_text, "gtk_editable_set_text");
  link(gtk_editable_set_width_chars, "gtk_editable_set_width_chars");

  // EditableLabel
  link(gtk_editable_label_get_type, "gtk_editable_label_get_type");
  link(gtk_editable_label_new, "gtk_editable_label_new");
  link(gtk_editable_label_get_editing, "gtk_editable_label_get_editing");
  link(gtk_editable_label_start_editing, "gtk_editable_label_start_editing");
  link(gtk_editable_label_stop_editing, "gtk_editable_label_stop_editing");

  // EmojiChooser
  link(gtk_emoji_chooser_get_type, "gtk_emoji_chooser_get_type");
  link(gtk_emoji_chooser_new, "gtk_emoji_chooser_new");

  // Entry
  link(gtk_entry_get_type, "gtk_entry_get_type");
  link(gtk_entry_new, "gtk_entry_new");
  link(gtk_entry_new_with_buffer, "gtk_entry_new_with_buffer");
  link(gtk_entry_get_activates_default, "gtk_entry_get_activates_default");
  link(gtk_entry_get_alignment, "gtk_entry_get_alignment");
  link(gtk_entry_get_attributes, "gtk_entry_get_attributes");
  link(gtk_entry_get_buffer, "gtk_entry_get_buffer");
  link(gtk_entry_get_completion, "gtk_entry_get_completion");
  link(gtk_entry_get_current_icon_drag_source, "gtk_entry_get_current_icon_drag_source");
  link(gtk_entry_get_extra_menu, "gtk_entry_get_extra_menu");
  link(gtk_entry_get_has_frame, "gtk_entry_get_has_frame");
  link(gtk_entry_get_icon_activatable, "gtk_entry_get_icon_activatable");
  link(gtk_entry_get_icon_area, "gtk_entry_get_icon_area");
  link(gtk_entry_get_icon_at_pos, "gtk_entry_get_icon_at_pos");
  link(gtk_entry_get_icon_gicon, "gtk_entry_get_icon_gicon");
  link(gtk_entry_get_icon_name, "gtk_entry_get_icon_name");
  link(gtk_entry_get_icon_paintable, "gtk_entry_get_icon_paintable");
  link(gtk_entry_get_icon_sensitive, "gtk_entry_get_icon_sensitive");
  link(gtk_entry_get_icon_storage_type, "gtk_entry_get_icon_storage_type");
  link(gtk_entry_get_icon_tooltip_markup, "gtk_entry_get_icon_tooltip_markup");
  link(gtk_entry_get_icon_tooltip_text, "gtk_entry_get_icon_tooltip_text");
  link(gtk_entry_get_input_hints, "gtk_entry_get_input_hints");
  link(gtk_entry_get_input_purpose, "gtk_entry_get_input_purpose");
  link(gtk_entry_get_invisible_char, "gtk_entry_get_invisible_char");
  link(gtk_entry_get_max_length, "gtk_entry_get_max_length");
  link(gtk_entry_get_overwrite_mode, "gtk_entry_get_overwrite_mode");
  link(gtk_entry_get_placeholder_text, "gtk_entry_get_placeholder_text");
  link(gtk_entry_get_progress_fraction, "gtk_entry_get_progress_fraction");
  link(gtk_entry_get_progress_pulse_step, "gtk_entry_get_progress_pulse_step");
  link(gtk_entry_get_tabs, "gtk_entry_get_tabs");
  link(gtk_entry_get_text_length, "gtk_entry_get_text_length");
  link(gtk_entry_get_visibility, "gtk_entry_get_visibility");
  link(gtk_entry_grab_focus_without_selecting, "gtk_entry_grab_focus_without_selecting");
  link(gtk_entry_progress_pulse, "gtk_entry_progress_pulse");
  link(gtk_entry_reset_im_context, "gtk_entry_reset_im_context");
  link(gtk_entry_set_activates_default, "gtk_entry_set_activates_default");
  link(gtk_entry_set_alignment, "gtk_entry_set_alignment");
  link(gtk_entry_set_attributes, "gtk_entry_set_attributes");
  link(gtk_entry_set_buffer, "gtk_entry_set_buffer");
  link(gtk_entry_set_completion, "gtk_entry_set_completion");
  link(gtk_entry_set_extra_menu, "gtk_entry_set_extra_menu");
  link(gtk_entry_set_has_frame, "gtk_entry_set_has_frame");
  link(gtk_entry_set_icon_activatable, "gtk_entry_set_icon_activatable");
  link(gtk_entry_set_icon_drag_source, "gtk_entry_set_icon_drag_source");
  link(gtk_entry_set_icon_from_gicon, "gtk_entry_set_icon_from_gicon");
  link(gtk_entry_set_icon_from_icon_name, "gtk_entry_set_icon_from_icon_name");
  link(gtk_entry_set_icon_from_paintable, "gtk_entry_set_icon_from_paintable");
  link(gtk_entry_set_icon_sensitive, "gtk_entry_set_icon_sensitive");
  link(gtk_entry_set_icon_tooltip_markup, "gtk_entry_set_icon_tooltip_markup");
  link(gtk_entry_set_icon_tooltip_text, "gtk_entry_set_icon_tooltip_text");
  link(gtk_entry_set_input_hints, "gtk_entry_set_input_hints");
  link(gtk_entry_set_input_purpose, "gtk_entry_set_input_purpose");
  link(gtk_entry_set_invisible_char, "gtk_entry_set_invisible_char");
  link(gtk_entry_set_max_length, "gtk_entry_set_max_length");
  link(gtk_entry_set_overwrite_mode, "gtk_entry_set_overwrite_mode");
  link(gtk_entry_set_placeholder_text, "gtk_entry_set_placeholder_text");
  link(gtk_entry_set_progress_fraction, "gtk_entry_set_progress_fraction");
  link(gtk_entry_set_progress_pulse_step, "gtk_entry_set_progress_pulse_step");
  link(gtk_entry_set_tabs, "gtk_entry_set_tabs");
  link(gtk_entry_set_visibility, "gtk_entry_set_visibility");
  link(gtk_entry_unset_invisible_char, "gtk_entry_unset_invisible_char");

  // EntryBuffer
  link(gtk_entry_buffer_get_type, "gtk_entry_buffer_get_type");
  link(gtk_entry_buffer_new, "gtk_entry_buffer_new");
  link(gtk_entry_buffer_delete_text, "gtk_entry_buffer_delete_text");
  link(gtk_entry_buffer_emit_deleted_text, "gtk_entry_buffer_emit_deleted_text");
  link(gtk_entry_buffer_emit_inserted_text, "gtk_entry_buffer_emit_inserted_text");
  link(gtk_entry_buffer_get_bytes, "gtk_entry_buffer_get_bytes");
  link(gtk_entry_buffer_get_length, "gtk_entry_buffer_get_length");
  link(gtk_entry_buffer_get_max_length, "gtk_entry_buffer_get_max_length");
  link(gtk_entry_buffer_get_text, "gtk_entry_buffer_get_text");
  link(gtk_entry_buffer_insert_text, "gtk_entry_buffer_insert_text");
  link(gtk_entry_buffer_set_max_length, "gtk_entry_buffer_set_max_length");
  link(gtk_entry_buffer_set_text, "gtk_entry_buffer_set_text");

  // EntryCompletion
  link(gtk_entry_completion_get_type, "gtk_entry_completion_get_type");
  link(gtk_entry_completion_new, "gtk_entry_completion_new");
  link(gtk_entry_completion_new_with_area, "gtk_entry_completion_new_with_area");
  link(gtk_entry_completion_complete, "gtk_entry_completion_complete");
  link(gtk_entry_completion_compute_prefix, "gtk_entry_completion_compute_prefix");
  link(gtk_entry_completion_get_completion_prefix, "gtk_entry_completion_get_completion_prefix");
  link(gtk_entry_completion_get_entry, "gtk_entry_completion_get_entry");
  link(gtk_entry_completion_get_inline_completion, "gtk_entry_completion_get_inline_completion");
  link(gtk_entry_completion_get_inline_selection, "gtk_entry_completion_get_inline_selection");
  link(gtk_entry_completion_get_minimum_key_length, "gtk_entry_completion_get_minimum_key_length");
  link(gtk_entry_completion_get_model, "gtk_entry_completion_get_model");
  link(gtk_entry_completion_get_popup_completion, "gtk_entry_completion_get_popup_completion");
  link(gtk_entry_completion_get_popup_set_width, "gtk_entry_completion_get_popup_set_width");
  link(gtk_entry_completion_get_popup_single_match, "gtk_entry_completion_get_popup_single_match");
  link(gtk_entry_completion_get_text_column, "gtk_entry_completion_get_text_column");
  link(gtk_entry_completion_insert_prefix, "gtk_entry_completion_insert_prefix");
  link(gtk_entry_completion_set_inline_completion, "gtk_entry_completion_set_inline_completion");
  link(gtk_entry_completion_set_inline_selection, "gtk_entry_completion_set_inline_selection");
  link(gtk_entry_completion_set_match_func, "gtk_entry_completion_set_match_func");
  link(gtk_entry_completion_set_minimum_key_length, "gtk_entry_completion_set_minimum_key_length");
  link(gtk_entry_completion_set_model, "gtk_entry_completion_set_model");
  link(gtk_entry_completion_set_popup_completion, "gtk_entry_completion_set_popup_completion");
  link(gtk_entry_completion_set_popup_set_width, "gtk_entry_completion_set_popup_set_width");
  link(gtk_entry_completion_set_popup_single_match, "gtk_entry_completion_set_popup_single_match");
  link(gtk_entry_completion_set_text_column, "gtk_entry_completion_set_text_column");

  // EventController
  link(gtk_event_controller_get_type, "gtk_event_controller_get_type");
  link(gtk_event_controller_get_current_event, "gtk_event_controller_get_current_event");
  link(gtk_event_controller_get_current_event_device, "gtk_event_controller_get_current_event_device");
  link(gtk_event_controller_get_current_event_state, "gtk_event_controller_get_current_event_state");
  link(gtk_event_controller_get_current_event_time, "gtk_event_controller_get_current_event_time");
  link(gtk_event_controller_get_name, "gtk_event_controller_get_name");
  link(gtk_event_controller_get_propagation_limit, "gtk_event_controller_get_propagation_limit");
  link(gtk_event_controller_get_propagation_phase, "gtk_event_controller_get_propagation_phase");
  link(gtk_event_controller_get_widget, "gtk_event_controller_get_widget");
  link(gtk_event_controller_reset, "gtk_event_controller_reset");
  link(gtk_event_controller_set_name, "gtk_event_controller_set_name");
  link(gtk_event_controller_set_propagation_limit, "gtk_event_controller_set_propagation_limit");
  link(gtk_event_controller_set_propagation_phase, "gtk_event_controller_set_propagation_phase");
  link(gtk_event_controller_set_static_name, "gtk_event_controller_set_static_name");

  // EventControllerFocus
  link(gtk_event_controller_focus_get_type, "gtk_event_controller_focus_get_type");
  link(gtk_event_controller_focus_new, "gtk_event_controller_focus_new");
  link(gtk_event_controller_focus_contains_focus, "gtk_event_controller_focus_contains_focus");
  link(gtk_event_controller_focus_is_focus, "gtk_event_controller_focus_is_focus");

  // EventControllerKey
  link(gtk_event_controller_key_get_type, "gtk_event_controller_key_get_type");
  link(gtk_event_controller_key_new, "gtk_event_controller_key_new");
  link(gtk_event_controller_key_forward, "gtk_event_controller_key_forward");
  link(gtk_event_controller_key_get_group, "gtk_event_controller_key_get_group");
  link(gtk_event_controller_key_get_im_context, "gtk_event_controller_key_get_im_context");
  link(gtk_event_controller_key_set_im_context, "gtk_event_controller_key_set_im_context");

  // EventControllerLegacy
  link(gtk_event_controller_legacy_get_type, "gtk_event_controller_legacy_get_type");
  link(gtk_event_controller_legacy_new, "gtk_event_controller_legacy_new");

  // EventControllerMotion
  link(gtk_event_controller_motion_get_type, "gtk_event_controller_motion_get_type");
  link(gtk_event_controller_motion_new, "gtk_event_controller_motion_new");
  link(gtk_event_controller_motion_contains_pointer, "gtk_event_controller_motion_contains_pointer");
  link(gtk_event_controller_motion_is_pointer, "gtk_event_controller_motion_is_pointer");

  // EventControllerScroll
  link(gtk_event_controller_scroll_get_type, "gtk_event_controller_scroll_get_type");
  link(gtk_event_controller_scroll_new, "gtk_event_controller_scroll_new");
  link(gtk_event_controller_scroll_get_flags, "gtk_event_controller_scroll_get_flags");
  link(gtk_event_controller_scroll_get_unit, "gtk_event_controller_scroll_get_unit");
  link(gtk_event_controller_scroll_set_flags, "gtk_event_controller_scroll_set_flags");

  // EveryFilter
  link(gtk_every_filter_get_type, "gtk_every_filter_get_type");
  link(gtk_every_filter_new, "gtk_every_filter_new");

  // Expander
  link(gtk_expander_get_type, "gtk_expander_get_type");
  link(gtk_expander_new, "gtk_expander_new");
  link(gtk_expander_new_with_mnemonic, "gtk_expander_new_with_mnemonic");
  link(gtk_expander_get_child, "gtk_expander_get_child");
  link(gtk_expander_get_expanded, "gtk_expander_get_expanded");
  link(gtk_expander_get_label, "gtk_expander_get_label");
  link(gtk_expander_get_label_widget, "gtk_expander_get_label_widget");
  link(gtk_expander_get_resize_toplevel, "gtk_expander_get_resize_toplevel");
  link(gtk_expander_get_use_markup, "gtk_expander_get_use_markup");
  link(gtk_expander_get_use_underline, "gtk_expander_get_use_underline");
  link(gtk_expander_set_child, "gtk_expander_set_child");
  link(gtk_expander_set_expanded, "gtk_expander_set_expanded");
  link(gtk_expander_set_label, "gtk_expander_set_label");
  link(gtk_expander_set_label_widget, "gtk_expander_set_label_widget");
  link(gtk_expander_set_resize_toplevel, "gtk_expander_set_resize_toplevel");
  link(gtk_expander_set_use_markup, "gtk_expander_set_use_markup");
  link(gtk_expander_set_use_underline, "gtk_expander_set_use_underline");

  // Expression
  link(gtk_expression_get_type, "gtk_expression_get_type");
  link(gtk_expression_bind, "gtk_expression_bind");
  link(gtk_expression_evaluate, "gtk_expression_evaluate");
  link(gtk_expression_get_value_type, "gtk_expression_get_value_type");
  link(gtk_expression_is_static, "gtk_expression_is_static");
  link(gtk_expression_ref, "gtk_expression_ref");
  link(gtk_expression_unref, "gtk_expression_unref");
  link(gtk_expression_watch, "gtk_expression_watch");

  // ExpressionWatch
  link(gtk_expression_watch_get_type, "gtk_expression_watch_get_type");
  link(gtk_expression_watch_evaluate, "gtk_expression_watch_evaluate");
  link(gtk_expression_watch_ref, "gtk_expression_watch_ref");
  link(gtk_expression_watch_unref, "gtk_expression_watch_unref");
  link(gtk_expression_watch_unwatch, "gtk_expression_watch_unwatch");

  // FileChooser
  link(gtk_file_chooser_get_type, "gtk_file_chooser_get_type");
  link(gtk_file_chooser_add_choice, "gtk_file_chooser_add_choice");
  link(gtk_file_chooser_add_filter, "gtk_file_chooser_add_filter");
  link(gtk_file_chooser_add_shortcut_folder, "gtk_file_chooser_add_shortcut_folder");
  link(gtk_file_chooser_get_action, "gtk_file_chooser_get_action");
  link(gtk_file_chooser_get_choice, "gtk_file_chooser_get_choice");
  link(gtk_file_chooser_get_create_folders, "gtk_file_chooser_get_create_folders");
  link(gtk_file_chooser_get_current_folder, "gtk_file_chooser_get_current_folder");
  link(gtk_file_chooser_get_current_name, "gtk_file_chooser_get_current_name");
  link(gtk_file_chooser_get_file, "gtk_file_chooser_get_file");
  link(gtk_file_chooser_get_files, "gtk_file_chooser_get_files");
  link(gtk_file_chooser_get_filter, "gtk_file_chooser_get_filter");
  link(gtk_file_chooser_get_filters, "gtk_file_chooser_get_filters");
  link(gtk_file_chooser_get_select_multiple, "gtk_file_chooser_get_select_multiple");
  link(gtk_file_chooser_get_shortcut_folders, "gtk_file_chooser_get_shortcut_folders");
  link(gtk_file_chooser_remove_choice, "gtk_file_chooser_remove_choice");
  link(gtk_file_chooser_remove_filter, "gtk_file_chooser_remove_filter");
  link(gtk_file_chooser_remove_shortcut_folder, "gtk_file_chooser_remove_shortcut_folder");
  link(gtk_file_chooser_set_action, "gtk_file_chooser_set_action");
  link(gtk_file_chooser_set_choice, "gtk_file_chooser_set_choice");
  link(gtk_file_chooser_set_create_folders, "gtk_file_chooser_set_create_folders");
  link(gtk_file_chooser_set_current_folder, "gtk_file_chooser_set_current_folder");
  link(gtk_file_chooser_set_current_name, "gtk_file_chooser_set_current_name");
  link(gtk_file_chooser_set_file, "gtk_file_chooser_set_file");
  link(gtk_file_chooser_set_filter, "gtk_file_chooser_set_filter");
  link(gtk_file_chooser_set_select_multiple, "gtk_file_chooser_set_select_multiple");

  // FileChooserDialog
  link(gtk_file_chooser_dialog_get_type, "gtk_file_chooser_dialog_get_type");
  link(gtk_file_chooser_dialog_new, "gtk_file_chooser_dialog_new");

  // FileChooserNative
  link(gtk_file_chooser_native_get_type, "gtk_file_chooser_native_get_type");
  link(gtk_file_chooser_native_new, "gtk_file_chooser_native_new");
  link(gtk_file_chooser_native_get_accept_label, "gtk_file_chooser_native_get_accept_label");
  link(gtk_file_chooser_native_get_cancel_label, "gtk_file_chooser_native_get_cancel_label");
  link(gtk_file_chooser_native_set_accept_label, "gtk_file_chooser_native_set_accept_label");
  link(gtk_file_chooser_native_set_cancel_label, "gtk_file_chooser_native_set_cancel_label");

  // FileChooserWidget
  link(gtk_file_chooser_widget_get_type, "gtk_file_chooser_widget_get_type");
  link(gtk_file_chooser_widget_new, "gtk_file_chooser_widget_new");

  // FileDialog
  link(gtk_file_dialog_get_type, "gtk_file_dialog_get_type");
  link(gtk_file_dialog_new, "gtk_file_dialog_new");
  link(gtk_file_dialog_get_accept_label, "gtk_file_dialog_get_accept_label");
  link(gtk_file_dialog_get_default_filter, "gtk_file_dialog_get_default_filter");
  link(gtk_file_dialog_get_filters, "gtk_file_dialog_get_filters");
  link(gtk_file_dialog_get_initial_file, "gtk_file_dialog_get_initial_file");
  link(gtk_file_dialog_get_initial_folder, "gtk_file_dialog_get_initial_folder");
  link(gtk_file_dialog_get_initial_name, "gtk_file_dialog_get_initial_name");
  link(gtk_file_dialog_get_modal, "gtk_file_dialog_get_modal");
  link(gtk_file_dialog_get_title, "gtk_file_dialog_get_title");
  link(gtk_file_dialog_open, "gtk_file_dialog_open");
  link(gtk_file_dialog_open_finish, "gtk_file_dialog_open_finish");
  link(gtk_file_dialog_open_multiple, "gtk_file_dialog_open_multiple");
  link(gtk_file_dialog_open_multiple_finish, "gtk_file_dialog_open_multiple_finish");
  link(gtk_file_dialog_save, "gtk_file_dialog_save");
  link(gtk_file_dialog_save_finish, "gtk_file_dialog_save_finish");
  link(gtk_file_dialog_select_folder, "gtk_file_dialog_select_folder");
  link(gtk_file_dialog_select_folder_finish, "gtk_file_dialog_select_folder_finish");
  link(gtk_file_dialog_select_multiple_folders, "gtk_file_dialog_select_multiple_folders");
  link(gtk_file_dialog_select_multiple_folders_finish, "gtk_file_dialog_select_multiple_folders_finish");
  link(gtk_file_dialog_set_accept_label, "gtk_file_dialog_set_accept_label");
  link(gtk_file_dialog_set_default_filter, "gtk_file_dialog_set_default_filter");
  link(gtk_file_dialog_set_filters, "gtk_file_dialog_set_filters");
  link(gtk_file_dialog_set_initial_file, "gtk_file_dialog_set_initial_file");
  link(gtk_file_dialog_set_initial_folder, "gtk_file_dialog_set_initial_folder");
  link(gtk_file_dialog_set_initial_name, "gtk_file_dialog_set_initial_name");
  link(gtk_file_dialog_set_modal, "gtk_file_dialog_set_modal");
  link(gtk_file_dialog_set_title, "gtk_file_dialog_set_title");

  // FileFilter
  link(gtk_file_filter_get_type, "gtk_file_filter_get_type");
  link(gtk_file_filter_new, "gtk_file_filter_new");
  link(gtk_file_filter_new_from_gvariant, "gtk_file_filter_new_from_gvariant");
  link(gtk_file_filter_add_mime_type, "gtk_file_filter_add_mime_type");
  link(gtk_file_filter_add_pattern, "gtk_file_filter_add_pattern");
  link(gtk_file_filter_add_pixbuf_formats, "gtk_file_filter_add_pixbuf_formats");
  link(gtk_file_filter_add_suffix, "gtk_file_filter_add_suffix");
  link(gtk_file_filter_get_attributes, "gtk_file_filter_get_attributes");
  link(gtk_file_filter_get_name, "gtk_file_filter_get_name");
  link(gtk_file_filter_set_name, "gtk_file_filter_set_name");
  link(gtk_file_filter_to_gvariant, "gtk_file_filter_to_gvariant");

  // FileLauncher
  link(gtk_file_launcher_get_type, "gtk_file_launcher_get_type");
  link(gtk_file_launcher_new, "gtk_file_launcher_new");
  link(gtk_file_launcher_get_always_ask, "gtk_file_launcher_get_always_ask");
  link(gtk_file_launcher_get_file, "gtk_file_launcher_get_file");
  link(gtk_file_launcher_get_writable, "gtk_file_launcher_get_writable");
  link(gtk_file_launcher_launch, "gtk_file_launcher_launch");
  link(gtk_file_launcher_launch_finish, "gtk_file_launcher_launch_finish");
  link(gtk_file_launcher_open_containing_folder, "gtk_file_launcher_open_containing_folder");
  link(gtk_file_launcher_open_containing_folder_finish, "gtk_file_launcher_open_containing_folder_finish");
  link(gtk_file_launcher_set_always_ask, "gtk_file_launcher_set_always_ask");
  link(gtk_file_launcher_set_file, "gtk_file_launcher_set_file");
  link(gtk_file_launcher_set_writable, "gtk_file_launcher_set_writable");

  // Filter
  link(gtk_filter_get_type, "gtk_filter_get_type");
  link(gtk_filter_changed, "gtk_filter_changed");
  link(gtk_filter_get_strictness, "gtk_filter_get_strictness");
  link(gtk_filter_match, "gtk_filter_match");

  // FilterListModel
  link(gtk_filter_list_model_get_type, "gtk_filter_list_model_get_type");
  link(gtk_filter_list_model_new, "gtk_filter_list_model_new");
  link(gtk_filter_list_model_get_filter, "gtk_filter_list_model_get_filter");
  link(gtk_filter_list_model_get_incremental, "gtk_filter_list_model_get_incremental");
  link(gtk_filter_list_model_get_model, "gtk_filter_list_model_get_model");
  link(gtk_filter_list_model_get_pending, "gtk_filter_list_model_get_pending");
  link(gtk_filter_list_model_set_filter, "gtk_filter_list_model_set_filter");
  link(gtk_filter_list_model_set_incremental, "gtk_filter_list_model_set_incremental");
  link(gtk_filter_list_model_set_model, "gtk_filter_list_model_set_model");

  // Fixed
  link(gtk_fixed_get_type, "gtk_fixed_get_type");
  link(gtk_fixed_new, "gtk_fixed_new");
  link(gtk_fixed_get_child_position, "gtk_fixed_get_child_position");
  link(gtk_fixed_get_child_transform, "gtk_fixed_get_child_transform");
  link(gtk_fixed_move, "gtk_fixed_move");
  link(gtk_fixed_put, "gtk_fixed_put");
  link(gtk_fixed_remove, "gtk_fixed_remove");
  link(gtk_fixed_set_child_transform, "gtk_fixed_set_child_transform");

  // FixedLayout
  link(gtk_fixed_layout_get_type, "gtk_fixed_layout_get_type");
  link(gtk_fixed_layout_new, "gtk_fixed_layout_new");

  // FixedLayoutChild
  link(gtk_fixed_layout_child_get_type, "gtk_fixed_layout_child_get_type");
  link(gtk_fixed_layout_child_get_transform, "gtk_fixed_layout_child_get_transform");
  link(gtk_fixed_layout_child_set_transform, "gtk_fixed_layout_child_set_transform");

  // FlattenListModel
  link(gtk_flatten_list_model_get_type, "gtk_flatten_list_model_get_type");
  link(gtk_flatten_list_model_new, "gtk_flatten_list_model_new");
  link(gtk_flatten_list_model_get_model, "gtk_flatten_list_model_get_model");
  link(gtk_flatten_list_model_get_model_for_item, "gtk_flatten_list_model_get_model_for_item");
  link(gtk_flatten_list_model_set_model, "gtk_flatten_list_model_set_model");

  // FlowBox
  link(gtk_flow_box_get_type, "gtk_flow_box_get_type");
  link(gtk_flow_box_new, "gtk_flow_box_new");
  link(gtk_flow_box_append, "gtk_flow_box_append");
  link(gtk_flow_box_bind_model, "gtk_flow_box_bind_model");
  link(gtk_flow_box_get_activate_on_single_click, "gtk_flow_box_get_activate_on_single_click");
  link(gtk_flow_box_get_child_at_index, "gtk_flow_box_get_child_at_index");
  link(gtk_flow_box_get_child_at_pos, "gtk_flow_box_get_child_at_pos");
  link(gtk_flow_box_get_column_spacing, "gtk_flow_box_get_column_spacing");
  link(gtk_flow_box_get_homogeneous, "gtk_flow_box_get_homogeneous");
  link(gtk_flow_box_get_max_children_per_line, "gtk_flow_box_get_max_children_per_line");
  link(gtk_flow_box_get_min_children_per_line, "gtk_flow_box_get_min_children_per_line");
  link(gtk_flow_box_get_row_spacing, "gtk_flow_box_get_row_spacing");
  link(gtk_flow_box_get_selected_children, "gtk_flow_box_get_selected_children");
  link(gtk_flow_box_get_selection_mode, "gtk_flow_box_get_selection_mode");
  link(gtk_flow_box_insert, "gtk_flow_box_insert");
  link(gtk_flow_box_invalidate_filter, "gtk_flow_box_invalidate_filter");
  link(gtk_flow_box_invalidate_sort, "gtk_flow_box_invalidate_sort");
  link(gtk_flow_box_prepend, "gtk_flow_box_prepend");
  link(gtk_flow_box_remove, "gtk_flow_box_remove");
  link(gtk_flow_box_remove_all, "gtk_flow_box_remove_all");
  link(gtk_flow_box_select_all, "gtk_flow_box_select_all");
  link(gtk_flow_box_select_child, "gtk_flow_box_select_child");
  link(gtk_flow_box_selected_foreach, "gtk_flow_box_selected_foreach");
  link(gtk_flow_box_set_activate_on_single_click, "gtk_flow_box_set_activate_on_single_click");
  link(gtk_flow_box_set_column_spacing, "gtk_flow_box_set_column_spacing");
  link(gtk_flow_box_set_filter_func, "gtk_flow_box_set_filter_func");
  link(gtk_flow_box_set_hadjustment, "gtk_flow_box_set_hadjustment");
  link(gtk_flow_box_set_homogeneous, "gtk_flow_box_set_homogeneous");
  link(gtk_flow_box_set_max_children_per_line, "gtk_flow_box_set_max_children_per_line");
  link(gtk_flow_box_set_min_children_per_line, "gtk_flow_box_set_min_children_per_line");
  link(gtk_flow_box_set_row_spacing, "gtk_flow_box_set_row_spacing");
  link(gtk_flow_box_set_selection_mode, "gtk_flow_box_set_selection_mode");
  link(gtk_flow_box_set_sort_func, "gtk_flow_box_set_sort_func");
  link(gtk_flow_box_set_vadjustment, "gtk_flow_box_set_vadjustment");
  link(gtk_flow_box_unselect_all, "gtk_flow_box_unselect_all");
  link(gtk_flow_box_unselect_child, "gtk_flow_box_unselect_child");

  // FlowBoxChild
  link(gtk_flow_box_child_get_type, "gtk_flow_box_child_get_type");
  link(gtk_flow_box_child_new, "gtk_flow_box_child_new");
  link(gtk_flow_box_child_changed, "gtk_flow_box_child_changed");
  link(gtk_flow_box_child_get_child, "gtk_flow_box_child_get_child");
  link(gtk_flow_box_child_get_index, "gtk_flow_box_child_get_index");
  link(gtk_flow_box_child_is_selected, "gtk_flow_box_child_is_selected");
  link(gtk_flow_box_child_set_child, "gtk_flow_box_child_set_child");

  // FontButton
  link(gtk_font_button_get_type, "gtk_font_button_get_type");
  link(gtk_font_button_new, "gtk_font_button_new");
  link(gtk_font_button_new_with_font, "gtk_font_button_new_with_font");
  link(gtk_font_button_get_modal, "gtk_font_button_get_modal");
  link(gtk_font_button_get_title, "gtk_font_button_get_title");
  link(gtk_font_button_get_use_font, "gtk_font_button_get_use_font");
  link(gtk_font_button_get_use_size, "gtk_font_button_get_use_size");
  link(gtk_font_button_set_modal, "gtk_font_button_set_modal");
  link(gtk_font_button_set_title, "gtk_font_button_set_title");
  link(gtk_font_button_set_use_font, "gtk_font_button_set_use_font");
  link(gtk_font_button_set_use_size, "gtk_font_button_set_use_size");

  // FontChooser
  link(gtk_font_chooser_get_type, "gtk_font_chooser_get_type");
  link(gtk_font_chooser_get_font, "gtk_font_chooser_get_font");
  link(gtk_font_chooser_get_font_desc, "gtk_font_chooser_get_font_desc");
  link(gtk_font_chooser_get_font_face, "gtk_font_chooser_get_font_face");
  link(gtk_font_chooser_get_font_family, "gtk_font_chooser_get_font_family");
  link(gtk_font_chooser_get_font_features, "gtk_font_chooser_get_font_features");
  link(gtk_font_chooser_get_font_map, "gtk_font_chooser_get_font_map");
  link(gtk_font_chooser_get_font_size, "gtk_font_chooser_get_font_size");
  link(gtk_font_chooser_get_language, "gtk_font_chooser_get_language");
  link(gtk_font_chooser_get_level, "gtk_font_chooser_get_level");
  link(gtk_font_chooser_get_preview_text, "gtk_font_chooser_get_preview_text");
  link(gtk_font_chooser_get_show_preview_entry, "gtk_font_chooser_get_show_preview_entry");
  link(gtk_font_chooser_set_filter_func, "gtk_font_chooser_set_filter_func");
  link(gtk_font_chooser_set_font, "gtk_font_chooser_set_font");
  link(gtk_font_chooser_set_font_desc, "gtk_font_chooser_set_font_desc");
  link(gtk_font_chooser_set_font_map, "gtk_font_chooser_set_font_map");
  link(gtk_font_chooser_set_language, "gtk_font_chooser_set_language");
  link(gtk_font_chooser_set_level, "gtk_font_chooser_set_level");
  link(gtk_font_chooser_set_preview_text, "gtk_font_chooser_set_preview_text");
  link(gtk_font_chooser_set_show_preview_entry, "gtk_font_chooser_set_show_preview_entry");

  // FontChooserDialog
  link(gtk_font_chooser_dialog_get_type, "gtk_font_chooser_dialog_get_type");
  link(gtk_font_chooser_dialog_new, "gtk_font_chooser_dialog_new");

  // FontChooserWidget
  link(gtk_font_chooser_widget_get_type, "gtk_font_chooser_widget_get_type");
  link(gtk_font_chooser_widget_new, "gtk_font_chooser_widget_new");

  // FontDialog
  link(gtk_font_dialog_get_type, "gtk_font_dialog_get_type");
  link(gtk_font_dialog_new, "gtk_font_dialog_new");
  link(gtk_font_dialog_choose_face, "gtk_font_dialog_choose_face");
  link(gtk_font_dialog_choose_face_finish, "gtk_font_dialog_choose_face_finish");
  link(gtk_font_dialog_choose_family, "gtk_font_dialog_choose_family");
  link(gtk_font_dialog_choose_family_finish, "gtk_font_dialog_choose_family_finish");
  link(gtk_font_dialog_choose_font, "gtk_font_dialog_choose_font");
  link(gtk_font_dialog_choose_font_and_features, "gtk_font_dialog_choose_font_and_features");
  link(gtk_font_dialog_choose_font_and_features_finish, "gtk_font_dialog_choose_font_and_features_finish");
  link(gtk_font_dialog_choose_font_finish, "gtk_font_dialog_choose_font_finish");
  link(gtk_font_dialog_get_filter, "gtk_font_dialog_get_filter");
  link(gtk_font_dialog_get_font_map, "gtk_font_dialog_get_font_map");
  link(gtk_font_dialog_get_language, "gtk_font_dialog_get_language");
  link(gtk_font_dialog_get_modal, "gtk_font_dialog_get_modal");
  link(gtk_font_dialog_get_title, "gtk_font_dialog_get_title");
  link(gtk_font_dialog_set_filter, "gtk_font_dialog_set_filter");
  link(gtk_font_dialog_set_font_map, "gtk_font_dialog_set_font_map");
  link(gtk_font_dialog_set_language, "gtk_font_dialog_set_language");
  link(gtk_font_dialog_set_modal, "gtk_font_dialog_set_modal");
  link(gtk_font_dialog_set_title, "gtk_font_dialog_set_title");

  // FontDialogButton
  link(gtk_font_dialog_button_get_type, "gtk_font_dialog_button_get_type");
  link(gtk_font_dialog_button_new, "gtk_font_dialog_button_new");
  link(gtk_font_dialog_button_get_dialog, "gtk_font_dialog_button_get_dialog");
  link(gtk_font_dialog_button_get_font_desc, "gtk_font_dialog_button_get_font_desc");
  link(gtk_font_dialog_button_get_font_features, "gtk_font_dialog_button_get_font_features");
  link(gtk_font_dialog_button_get_language, "gtk_font_dialog_button_get_language");
  link(gtk_font_dialog_button_get_level, "gtk_font_dialog_button_get_level");
  link(gtk_font_dialog_button_get_use_font, "gtk_font_dialog_button_get_use_font");
  link(gtk_font_dialog_button_get_use_size, "gtk_font_dialog_button_get_use_size");
  link(gtk_font_dialog_button_set_dialog, "gtk_font_dialog_button_set_dialog");
  link(gtk_font_dialog_button_set_font_desc, "gtk_font_dialog_button_set_font_desc");
  link(gtk_font_dialog_button_set_font_features, "gtk_font_dialog_button_set_font_features");
  link(gtk_font_dialog_button_set_language, "gtk_font_dialog_button_set_language");
  link(gtk_font_dialog_button_set_level, "gtk_font_dialog_button_set_level");
  link(gtk_font_dialog_button_set_use_font, "gtk_font_dialog_button_set_use_font");
  link(gtk_font_dialog_button_set_use_size, "gtk_font_dialog_button_set_use_size");

  // Frame
  link(gtk_frame_get_type, "gtk_frame_get_type");
  link(gtk_frame_new, "gtk_frame_new");
  link(gtk_frame_get_child, "gtk_frame_get_child");
  link(gtk_frame_get_label, "gtk_frame_get_label");
  link(gtk_frame_get_label_align, "gtk_frame_get_label_align");
  link(gtk_frame_get_label_widget, "gtk_frame_get_label_widget");
  link(gtk_frame_set_child, "gtk_frame_set_child");
  link(gtk_frame_set_label, "gtk_frame_set_label");
  link(gtk_frame_set_label_align, "gtk_frame_set_label_align");
  link(gtk_frame_set_label_widget, "gtk_frame_set_label_widget");

  // GLArea
  link(gtk_gl_area_get_type, "gtk_gl_area_get_type");
  link(gtk_gl_area_new, "gtk_gl_area_new");
  link(gtk_gl_area_attach_buffers, "gtk_gl_area_attach_buffers");
  link(gtk_gl_area_get_allowed_apis, "gtk_gl_area_get_allowed_apis");
  link(gtk_gl_area_get_api, "gtk_gl_area_get_api");
  link(gtk_gl_area_get_auto_render, "gtk_gl_area_get_auto_render");
  link(gtk_gl_area_get_context, "gtk_gl_area_get_context");
  link(gtk_gl_area_get_error, "gtk_gl_area_get_error");
  link(gtk_gl_area_get_has_depth_buffer, "gtk_gl_area_get_has_depth_buffer");
  link(gtk_gl_area_get_has_stencil_buffer, "gtk_gl_area_get_has_stencil_buffer");
  link(gtk_gl_area_get_required_version, "gtk_gl_area_get_required_version");
  link(gtk_gl_area_get_use_es, "gtk_gl_area_get_use_es");
  link(gtk_gl_area_make_current, "gtk_gl_area_make_current");
  link(gtk_gl_area_queue_render, "gtk_gl_area_queue_render");
  link(gtk_gl_area_set_allowed_apis, "gtk_gl_area_set_allowed_apis");
  link(gtk_gl_area_set_auto_render, "gtk_gl_area_set_auto_render");
  link(gtk_gl_area_set_error, "gtk_gl_area_set_error");
  link(gtk_gl_area_set_has_depth_buffer, "gtk_gl_area_set_has_depth_buffer");
  link(gtk_gl_area_set_has_stencil_buffer, "gtk_gl_area_set_has_stencil_buffer");
  link(gtk_gl_area_set_required_version, "gtk_gl_area_set_required_version");
  link(gtk_gl_area_set_use_es, "gtk_gl_area_set_use_es");

  // Gesture
  link(gtk_gesture_get_type, "gtk_gesture_get_type");
  link(gtk_gesture_get_bounding_box, "gtk_gesture_get_bounding_box");
  link(gtk_gesture_get_bounding_box_center, "gtk_gesture_get_bounding_box_center");
  link(gtk_gesture_get_device, "gtk_gesture_get_device");
  link(gtk_gesture_get_group, "gtk_gesture_get_group");
  link(gtk_gesture_get_last_event, "gtk_gesture_get_last_event");
  link(gtk_gesture_get_last_updated_sequence, "gtk_gesture_get_last_updated_sequence");
  link(gtk_gesture_get_point, "gtk_gesture_get_point");
  link(gtk_gesture_get_sequence_state, "gtk_gesture_get_sequence_state");
  link(gtk_gesture_get_sequences, "gtk_gesture_get_sequences");
  link(gtk_gesture_group, "gtk_gesture_group");
  link(gtk_gesture_handles_sequence, "gtk_gesture_handles_sequence");
  link(gtk_gesture_is_active, "gtk_gesture_is_active");
  link(gtk_gesture_is_grouped_with, "gtk_gesture_is_grouped_with");
  link(gtk_gesture_is_recognized, "gtk_gesture_is_recognized");
  link(gtk_gesture_set_sequence_state, "gtk_gesture_set_sequence_state");
  link(gtk_gesture_set_state, "gtk_gesture_set_state");
  link(gtk_gesture_ungroup, "gtk_gesture_ungroup");

  // GestureClick
  link(gtk_gesture_click_get_type, "gtk_gesture_click_get_type");
  link(gtk_gesture_click_new, "gtk_gesture_click_new");

  // GestureDrag
  link(gtk_gesture_drag_get_type, "gtk_gesture_drag_get_type");
  link(gtk_gesture_drag_new, "gtk_gesture_drag_new");
  link(gtk_gesture_drag_get_offset, "gtk_gesture_drag_get_offset");
  link(gtk_gesture_drag_get_start_point, "gtk_gesture_drag_get_start_point");

  // GestureLongPress
  link(gtk_gesture_long_press_get_type, "gtk_gesture_long_press_get_type");
  link(gtk_gesture_long_press_new, "gtk_gesture_long_press_new");
  link(gtk_gesture_long_press_get_delay_factor, "gtk_gesture_long_press_get_delay_factor");
  link(gtk_gesture_long_press_set_delay_factor, "gtk_gesture_long_press_set_delay_factor");

  // GesturePan
  link(gtk_gesture_pan_get_type, "gtk_gesture_pan_get_type");
  link(gtk_gesture_pan_new, "gtk_gesture_pan_new");
  link(gtk_gesture_pan_get_orientation, "gtk_gesture_pan_get_orientation");
  link(gtk_gesture_pan_set_orientation, "gtk_gesture_pan_set_orientation");

  // GestureRotate
  link(gtk_gesture_rotate_get_type, "gtk_gesture_rotate_get_type");
  link(gtk_gesture_rotate_new, "gtk_gesture_rotate_new");
  link(gtk_gesture_rotate_get_angle_delta, "gtk_gesture_rotate_get_angle_delta");

  // GestureSingle
  link(gtk_gesture_single_get_type, "gtk_gesture_single_get_type");
  link(gtk_gesture_single_get_button, "gtk_gesture_single_get_button");
  link(gtk_gesture_single_get_current_button, "gtk_gesture_single_get_current_button");
  link(gtk_gesture_single_get_current_sequence, "gtk_gesture_single_get_current_sequence");
  link(gtk_gesture_single_get_exclusive, "gtk_gesture_single_get_exclusive");
  link(gtk_gesture_single_get_touch_only, "gtk_gesture_single_get_touch_only");
  link(gtk_gesture_single_set_button, "gtk_gesture_single_set_button");
  link(gtk_gesture_single_set_exclusive, "gtk_gesture_single_set_exclusive");
  link(gtk_gesture_single_set_touch_only, "gtk_gesture_single_set_touch_only");

  // GestureStylus
  link(gtk_gesture_stylus_get_type, "gtk_gesture_stylus_get_type");
  link(gtk_gesture_stylus_new, "gtk_gesture_stylus_new");
  link(gtk_gesture_stylus_get_axes, "gtk_gesture_stylus_get_axes");
  link(gtk_gesture_stylus_get_axis, "gtk_gesture_stylus_get_axis");
  link(gtk_gesture_stylus_get_backlog, "gtk_gesture_stylus_get_backlog");
  link(gtk_gesture_stylus_get_device_tool, "gtk_gesture_stylus_get_device_tool");
  link(gtk_gesture_stylus_get_stylus_only, "gtk_gesture_stylus_get_stylus_only");
  link(gtk_gesture_stylus_set_stylus_only, "gtk_gesture_stylus_set_stylus_only");

  // GestureSwipe
  link(gtk_gesture_swipe_get_type, "gtk_gesture_swipe_get_type");
  link(gtk_gesture_swipe_new, "gtk_gesture_swipe_new");
  link(gtk_gesture_swipe_get_velocity, "gtk_gesture_swipe_get_velocity");

  // GestureZoom
  link(gtk_gesture_zoom_get_type, "gtk_gesture_zoom_get_type");
  link(gtk_gesture_zoom_new, "gtk_gesture_zoom_new");
  link(gtk_gesture_zoom_get_scale_delta, "gtk_gesture_zoom_get_scale_delta");

  // Global
  link(gtk_accelerator_get_default_mod_mask, "gtk_accelerator_get_default_mod_mask");
  link(gtk_accelerator_get_label, "gtk_accelerator_get_label");
  link(gtk_accelerator_get_label_with_keycode, "gtk_accelerator_get_label_with_keycode");
  link(gtk_accelerator_name, "gtk_accelerator_name");
  link(gtk_accelerator_name_with_keycode, "gtk_accelerator_name_with_keycode");
  link(gtk_accelerator_parse, "gtk_accelerator_parse");
  link(gtk_accelerator_parse_with_keycode, "gtk_accelerator_parse_with_keycode");
  link(gtk_accelerator_valid, "gtk_accelerator_valid");
  link(gtk_check_version, "gtk_check_version");
  link(gtk_css_parser_error_quark, "gtk_css_parser_error_quark");
  link(gtk_css_parser_warning_quark, "gtk_css_parser_warning_quark");
  link(gtk_disable_setlocale, "gtk_disable_setlocale");
  link(gtk_distribute_natural_allocation, "gtk_distribute_natural_allocation");
  link(gtk_enumerate_printers, "gtk_enumerate_printers");
  link(gtk_get_binary_age, "gtk_get_binary_age");
  link(gtk_get_debug_flags, "gtk_get_debug_flags");
  link(gtk_get_default_language, "gtk_get_default_language");
  link(gtk_get_interface_age, "gtk_get_interface_age");
  link(gtk_get_locale_direction, "gtk_get_locale_direction");
  link(gtk_get_major_version, "gtk_get_major_version");
  link(gtk_get_micro_version, "gtk_get_micro_version");
  link(gtk_get_minor_version, "gtk_get_minor_version");
  link(gtk_hsv_to_rgb, "gtk_hsv_to_rgb");
  link(gtk_init, "gtk_init");
  link(gtk_init_check, "gtk_init_check");
  link(gtk_is_initialized, "gtk_is_initialized");
  link(gtk_param_spec_expression, "gtk_param_spec_expression");
  link(gtk_print_run_page_setup_dialog, "gtk_print_run_page_setup_dialog");
  link(gtk_print_run_page_setup_dialog_async, "gtk_print_run_page_setup_dialog_async");
  link(gtk_render_activity, "gtk_render_activity");
  link(gtk_render_arrow, "gtk_render_arrow");
  link(gtk_render_background, "gtk_render_background");
  link(gtk_render_check, "gtk_render_check");
  link(gtk_render_expander, "gtk_render_expander");
  link(gtk_render_focus, "gtk_render_focus");
  link(gtk_render_frame, "gtk_render_frame");
  link(gtk_render_handle, "gtk_render_handle");
  link(gtk_render_icon, "gtk_render_icon");
  link(gtk_render_layout, "gtk_render_layout");
  link(gtk_render_line, "gtk_render_line");
  link(gtk_render_option, "gtk_render_option");
  link(gtk_rgb_to_hsv, "gtk_rgb_to_hsv");
  link(gtk_set_debug_flags, "gtk_set_debug_flags");
  link(gtk_show_about_dialog, "gtk_show_about_dialog");
  link(gtk_show_uri, "gtk_show_uri");
  link(gtk_show_uri_full, "gtk_show_uri_full");
  link(gtk_show_uri_full_finish, "gtk_show_uri_full_finish");
  link(gtk_test_accessible_assertion_message_role, "gtk_test_accessible_assertion_message_role");
  link(gtk_test_accessible_check_property, "gtk_test_accessible_check_property");
  link(gtk_test_accessible_check_relation, "gtk_test_accessible_check_relation");
  link(gtk_test_accessible_check_state, "gtk_test_accessible_check_state");
  link(gtk_test_accessible_has_property, "gtk_test_accessible_has_property");
  link(gtk_test_accessible_has_relation, "gtk_test_accessible_has_relation");
  link(gtk_test_accessible_has_role, "gtk_test_accessible_has_role");
  link(gtk_test_accessible_has_state, "gtk_test_accessible_has_state");
  link(gtk_test_init, "gtk_test_init");
  link(gtk_test_list_all_types, "gtk_test_list_all_types");
  link(gtk_test_register_all_types, "gtk_test_register_all_types");
  link(gtk_test_widget_wait_for_draw, "gtk_test_widget_wait_for_draw");
  link(gtk_tree_create_row_drag_content, "gtk_tree_create_row_drag_content");
  link(gtk_tree_get_row_drag_data, "gtk_tree_get_row_drag_data");
  link(gtk_value_dup_expression, "gtk_value_dup_expression");
  link(gtk_value_get_expression, "gtk_value_get_expression");
  link(gtk_value_set_expression, "gtk_value_set_expression");
  link(gtk_value_take_expression, "gtk_value_take_expression");

  // GraphicsOffload
  link(gtk_graphics_offload_get_type, "gtk_graphics_offload_get_type");
  link(gtk_graphics_offload_new, "gtk_graphics_offload_new");
  link(gtk_graphics_offload_get_child, "gtk_graphics_offload_get_child");
  link(gtk_graphics_offload_get_enabled, "gtk_graphics_offload_get_enabled");
  link(gtk_graphics_offload_set_child, "gtk_graphics_offload_set_child");
  link(gtk_graphics_offload_set_enabled, "gtk_graphics_offload_set_enabled");

  // Grid
  link(gtk_grid_get_type, "gtk_grid_get_type");
  link(gtk_grid_new, "gtk_grid_new");
  link(gtk_grid_attach, "gtk_grid_attach");
  link(gtk_grid_attach_next_to, "gtk_grid_attach_next_to");
  link(gtk_grid_get_baseline_row, "gtk_grid_get_baseline_row");
  link(gtk_grid_get_child_at, "gtk_grid_get_child_at");
  link(gtk_grid_get_column_homogeneous, "gtk_grid_get_column_homogeneous");
  link(gtk_grid_get_column_spacing, "gtk_grid_get_column_spacing");
  link(gtk_grid_get_row_baseline_position, "gtk_grid_get_row_baseline_position");
  link(gtk_grid_get_row_homogeneous, "gtk_grid_get_row_homogeneous");
  link(gtk_grid_get_row_spacing, "gtk_grid_get_row_spacing");
  link(gtk_grid_insert_column, "gtk_grid_insert_column");
  link(gtk_grid_insert_next_to, "gtk_grid_insert_next_to");
  link(gtk_grid_insert_row, "gtk_grid_insert_row");
  link(gtk_grid_query_child, "gtk_grid_query_child");
  link(gtk_grid_remove, "gtk_grid_remove");
  link(gtk_grid_remove_column, "gtk_grid_remove_column");
  link(gtk_grid_remove_row, "gtk_grid_remove_row");
  link(gtk_grid_set_baseline_row, "gtk_grid_set_baseline_row");
  link(gtk_grid_set_column_homogeneous, "gtk_grid_set_column_homogeneous");
  link(gtk_grid_set_column_spacing, "gtk_grid_set_column_spacing");
  link(gtk_grid_set_row_baseline_position, "gtk_grid_set_row_baseline_position");
  link(gtk_grid_set_row_homogeneous, "gtk_grid_set_row_homogeneous");
  link(gtk_grid_set_row_spacing, "gtk_grid_set_row_spacing");

  // GridLayout
  link(gtk_grid_layout_get_type, "gtk_grid_layout_get_type");
  link(gtk_grid_layout_new, "gtk_grid_layout_new");
  link(gtk_grid_layout_get_baseline_row, "gtk_grid_layout_get_baseline_row");
  link(gtk_grid_layout_get_column_homogeneous, "gtk_grid_layout_get_column_homogeneous");
  link(gtk_grid_layout_get_column_spacing, "gtk_grid_layout_get_column_spacing");
  link(gtk_grid_layout_get_row_baseline_position, "gtk_grid_layout_get_row_baseline_position");
  link(gtk_grid_layout_get_row_homogeneous, "gtk_grid_layout_get_row_homogeneous");
  link(gtk_grid_layout_get_row_spacing, "gtk_grid_layout_get_row_spacing");
  link(gtk_grid_layout_set_baseline_row, "gtk_grid_layout_set_baseline_row");
  link(gtk_grid_layout_set_column_homogeneous, "gtk_grid_layout_set_column_homogeneous");
  link(gtk_grid_layout_set_column_spacing, "gtk_grid_layout_set_column_spacing");
  link(gtk_grid_layout_set_row_baseline_position, "gtk_grid_layout_set_row_baseline_position");
  link(gtk_grid_layout_set_row_homogeneous, "gtk_grid_layout_set_row_homogeneous");
  link(gtk_grid_layout_set_row_spacing, "gtk_grid_layout_set_row_spacing");

  // GridLayoutChild
  link(gtk_grid_layout_child_get_type, "gtk_grid_layout_child_get_type");
  link(gtk_grid_layout_child_get_column, "gtk_grid_layout_child_get_column");
  link(gtk_grid_layout_child_get_column_span, "gtk_grid_layout_child_get_column_span");
  link(gtk_grid_layout_child_get_row, "gtk_grid_layout_child_get_row");
  link(gtk_grid_layout_child_get_row_span, "gtk_grid_layout_child_get_row_span");
  link(gtk_grid_layout_child_set_column, "gtk_grid_layout_child_set_column");
  link(gtk_grid_layout_child_set_column_span, "gtk_grid_layout_child_set_column_span");
  link(gtk_grid_layout_child_set_row, "gtk_grid_layout_child_set_row");
  link(gtk_grid_layout_child_set_row_span, "gtk_grid_layout_child_set_row_span");

  // GridView
  link(gtk_grid_view_get_type, "gtk_grid_view_get_type");
  link(gtk_grid_view_new, "gtk_grid_view_new");
  link(gtk_grid_view_get_enable_rubberband, "gtk_grid_view_get_enable_rubberband");
  link(gtk_grid_view_get_factory, "gtk_grid_view_get_factory");
  link(gtk_grid_view_get_max_columns, "gtk_grid_view_get_max_columns");
  link(gtk_grid_view_get_min_columns, "gtk_grid_view_get_min_columns");
  link(gtk_grid_view_get_model, "gtk_grid_view_get_model");
  link(gtk_grid_view_get_single_click_activate, "gtk_grid_view_get_single_click_activate");
  link(gtk_grid_view_get_tab_behavior, "gtk_grid_view_get_tab_behavior");
  link(gtk_grid_view_scroll_to, "gtk_grid_view_scroll_to");
  link(gtk_grid_view_set_enable_rubberband, "gtk_grid_view_set_enable_rubberband");
  link(gtk_grid_view_set_factory, "gtk_grid_view_set_factory");
  link(gtk_grid_view_set_max_columns, "gtk_grid_view_set_max_columns");
  link(gtk_grid_view_set_min_columns, "gtk_grid_view_set_min_columns");
  link(gtk_grid_view_set_model, "gtk_grid_view_set_model");
  link(gtk_grid_view_set_single_click_activate, "gtk_grid_view_set_single_click_activate");
  link(gtk_grid_view_set_tab_behavior, "gtk_grid_view_set_tab_behavior");

  // HeaderBar
  link(gtk_header_bar_get_type, "gtk_header_bar_get_type");
  link(gtk_header_bar_new, "gtk_header_bar_new");
  link(gtk_header_bar_get_decoration_layout, "gtk_header_bar_get_decoration_layout");
  link(gtk_header_bar_get_show_title_buttons, "gtk_header_bar_get_show_title_buttons");
  link(gtk_header_bar_get_title_widget, "gtk_header_bar_get_title_widget");
  link(gtk_header_bar_pack_end, "gtk_header_bar_pack_end");
  link(gtk_header_bar_pack_start, "gtk_header_bar_pack_start");
  link(gtk_header_bar_remove, "gtk_header_bar_remove");
  link(gtk_header_bar_set_decoration_layout, "gtk_header_bar_set_decoration_layout");
  link(gtk_header_bar_set_show_title_buttons, "gtk_header_bar_set_show_title_buttons");
  link(gtk_header_bar_set_title_widget, "gtk_header_bar_set_title_widget");

  // IMContext
  link(gtk_im_context_get_type, "gtk_im_context_get_type");
  link(gtk_im_context_activate_osk, "gtk_im_context_activate_osk");
  link(gtk_im_context_delete_surrounding, "gtk_im_context_delete_surrounding");
  link(gtk_im_context_filter_key, "gtk_im_context_filter_key");
  link(gtk_im_context_filter_keypress, "gtk_im_context_filter_keypress");
  link(gtk_im_context_focus_in, "gtk_im_context_focus_in");
  link(gtk_im_context_focus_out, "gtk_im_context_focus_out");
  link(gtk_im_context_get_preedit_string, "gtk_im_context_get_preedit_string");
  link(gtk_im_context_get_surrounding, "gtk_im_context_get_surrounding");
  link(gtk_im_context_get_surrounding_with_selection, "gtk_im_context_get_surrounding_with_selection");
  link(gtk_im_context_reset, "gtk_im_context_reset");
  link(gtk_im_context_set_client_widget, "gtk_im_context_set_client_widget");
  link(gtk_im_context_set_cursor_location, "gtk_im_context_set_cursor_location");
  link(gtk_im_context_set_surrounding, "gtk_im_context_set_surrounding");
  link(gtk_im_context_set_surrounding_with_selection, "gtk_im_context_set_surrounding_with_selection");
  link(gtk_im_context_set_use_preedit, "gtk_im_context_set_use_preedit");

  // IMContextSimple
  link(gtk_im_context_simple_get_type, "gtk_im_context_simple_get_type");
  link(gtk_im_context_simple_new, "gtk_im_context_simple_new");
  link(gtk_im_context_simple_add_compose_file, "gtk_im_context_simple_add_compose_file");
  link(gtk_im_context_simple_add_table, "gtk_im_context_simple_add_table");

  // IMMulticontext
  link(gtk_im_multicontext_get_type, "gtk_im_multicontext_get_type");
  link(gtk_im_multicontext_new, "gtk_im_multicontext_new");
  link(gtk_im_multicontext_get_context_id, "gtk_im_multicontext_get_context_id");
  link(gtk_im_multicontext_set_context_id, "gtk_im_multicontext_set_context_id");

  // IconPaintable
  link(gtk_icon_paintable_get_type, "gtk_icon_paintable_get_type");
  link(gtk_icon_paintable_new_for_file, "gtk_icon_paintable_new_for_file");
  link(gtk_icon_paintable_get_file, "gtk_icon_paintable_get_file");
  link(gtk_icon_paintable_get_icon_name, "gtk_icon_paintable_get_icon_name");
  link(gtk_icon_paintable_is_symbolic, "gtk_icon_paintable_is_symbolic");

  // IconTheme
  link(gtk_icon_theme_get_type, "gtk_icon_theme_get_type");
  link(gtk_icon_theme_new, "gtk_icon_theme_new");
  link(gtk_icon_theme_get_for_display, "gtk_icon_theme_get_for_display");
  link(gtk_icon_theme_add_resource_path, "gtk_icon_theme_add_resource_path");
  link(gtk_icon_theme_add_search_path, "gtk_icon_theme_add_search_path");
  link(gtk_icon_theme_get_display, "gtk_icon_theme_get_display");
  link(gtk_icon_theme_get_icon_names, "gtk_icon_theme_get_icon_names");
  link(gtk_icon_theme_get_icon_sizes, "gtk_icon_theme_get_icon_sizes");
  link(gtk_icon_theme_get_resource_path, "gtk_icon_theme_get_resource_path");
  link(gtk_icon_theme_get_search_path, "gtk_icon_theme_get_search_path");
  link(gtk_icon_theme_get_theme_name, "gtk_icon_theme_get_theme_name");
  link(gtk_icon_theme_has_gicon, "gtk_icon_theme_has_gicon");
  link(gtk_icon_theme_has_icon, "gtk_icon_theme_has_icon");
  link(gtk_icon_theme_lookup_by_gicon, "gtk_icon_theme_lookup_by_gicon");
  link(gtk_icon_theme_lookup_icon, "gtk_icon_theme_lookup_icon");
  link(gtk_icon_theme_set_resource_path, "gtk_icon_theme_set_resource_path");
  link(gtk_icon_theme_set_search_path, "gtk_icon_theme_set_search_path");
  link(gtk_icon_theme_set_theme_name, "gtk_icon_theme_set_theme_name");

  // IconView
  link(gtk_icon_view_get_type, "gtk_icon_view_get_type");
  link(gtk_icon_view_new, "gtk_icon_view_new");
  link(gtk_icon_view_new_with_area, "gtk_icon_view_new_with_area");
  link(gtk_icon_view_new_with_model, "gtk_icon_view_new_with_model");
  link(gtk_icon_view_create_drag_icon, "gtk_icon_view_create_drag_icon");
  link(gtk_icon_view_enable_model_drag_dest, "gtk_icon_view_enable_model_drag_dest");
  link(gtk_icon_view_enable_model_drag_source, "gtk_icon_view_enable_model_drag_source");
  link(gtk_icon_view_get_activate_on_single_click, "gtk_icon_view_get_activate_on_single_click");
  link(gtk_icon_view_get_cell_rect, "gtk_icon_view_get_cell_rect");
  link(gtk_icon_view_get_column_spacing, "gtk_icon_view_get_column_spacing");
  link(gtk_icon_view_get_columns, "gtk_icon_view_get_columns");
  link(gtk_icon_view_get_cursor, "gtk_icon_view_get_cursor");
  link(gtk_icon_view_get_dest_item_at_pos, "gtk_icon_view_get_dest_item_at_pos");
  link(gtk_icon_view_get_drag_dest_item, "gtk_icon_view_get_drag_dest_item");
  link(gtk_icon_view_get_item_at_pos, "gtk_icon_view_get_item_at_pos");
  link(gtk_icon_view_get_item_column, "gtk_icon_view_get_item_column");
  link(gtk_icon_view_get_item_orientation, "gtk_icon_view_get_item_orientation");
  link(gtk_icon_view_get_item_padding, "gtk_icon_view_get_item_padding");
  link(gtk_icon_view_get_item_row, "gtk_icon_view_get_item_row");
  link(gtk_icon_view_get_item_width, "gtk_icon_view_get_item_width");
  link(gtk_icon_view_get_margin, "gtk_icon_view_get_margin");
  link(gtk_icon_view_get_markup_column, "gtk_icon_view_get_markup_column");
  link(gtk_icon_view_get_model, "gtk_icon_view_get_model");
  link(gtk_icon_view_get_path_at_pos, "gtk_icon_view_get_path_at_pos");
  link(gtk_icon_view_get_pixbuf_column, "gtk_icon_view_get_pixbuf_column");
  link(gtk_icon_view_get_reorderable, "gtk_icon_view_get_reorderable");
  link(gtk_icon_view_get_row_spacing, "gtk_icon_view_get_row_spacing");
  link(gtk_icon_view_get_selected_items, "gtk_icon_view_get_selected_items");
  link(gtk_icon_view_get_selection_mode, "gtk_icon_view_get_selection_mode");
  link(gtk_icon_view_get_spacing, "gtk_icon_view_get_spacing");
  link(gtk_icon_view_get_text_column, "gtk_icon_view_get_text_column");
  link(gtk_icon_view_get_tooltip_column, "gtk_icon_view_get_tooltip_column");
  link(gtk_icon_view_get_tooltip_context, "gtk_icon_view_get_tooltip_context");
  link(gtk_icon_view_get_visible_range, "gtk_icon_view_get_visible_range");
  link(gtk_icon_view_item_activated, "gtk_icon_view_item_activated");
  link(gtk_icon_view_path_is_selected, "gtk_icon_view_path_is_selected");
  link(gtk_icon_view_scroll_to_path, "gtk_icon_view_scroll_to_path");
  link(gtk_icon_view_select_all, "gtk_icon_view_select_all");
  link(gtk_icon_view_select_path, "gtk_icon_view_select_path");
  link(gtk_icon_view_selected_foreach, "gtk_icon_view_selected_foreach");
  link(gtk_icon_view_set_activate_on_single_click, "gtk_icon_view_set_activate_on_single_click");
  link(gtk_icon_view_set_column_spacing, "gtk_icon_view_set_column_spacing");
  link(gtk_icon_view_set_columns, "gtk_icon_view_set_columns");
  link(gtk_icon_view_set_cursor, "gtk_icon_view_set_cursor");
  link(gtk_icon_view_set_drag_dest_item, "gtk_icon_view_set_drag_dest_item");
  link(gtk_icon_view_set_item_orientation, "gtk_icon_view_set_item_orientation");
  link(gtk_icon_view_set_item_padding, "gtk_icon_view_set_item_padding");
  link(gtk_icon_view_set_item_width, "gtk_icon_view_set_item_width");
  link(gtk_icon_view_set_margin, "gtk_icon_view_set_margin");
  link(gtk_icon_view_set_markup_column, "gtk_icon_view_set_markup_column");
  link(gtk_icon_view_set_model, "gtk_icon_view_set_model");
  link(gtk_icon_view_set_pixbuf_column, "gtk_icon_view_set_pixbuf_column");
  link(gtk_icon_view_set_reorderable, "gtk_icon_view_set_reorderable");
  link(gtk_icon_view_set_row_spacing, "gtk_icon_view_set_row_spacing");
  link(gtk_icon_view_set_selection_mode, "gtk_icon_view_set_selection_mode");
  link(gtk_icon_view_set_spacing, "gtk_icon_view_set_spacing");
  link(gtk_icon_view_set_text_column, "gtk_icon_view_set_text_column");
  link(gtk_icon_view_set_tooltip_cell, "gtk_icon_view_set_tooltip_cell");
  link(gtk_icon_view_set_tooltip_column, "gtk_icon_view_set_tooltip_column");
  link(gtk_icon_view_set_tooltip_item, "gtk_icon_view_set_tooltip_item");
  link(gtk_icon_view_unselect_all, "gtk_icon_view_unselect_all");
  link(gtk_icon_view_unselect_path, "gtk_icon_view_unselect_path");
  link(gtk_icon_view_unset_model_drag_dest, "gtk_icon_view_unset_model_drag_dest");
  link(gtk_icon_view_unset_model_drag_source, "gtk_icon_view_unset_model_drag_source");

  // Image
  link(gtk_image_get_type, "gtk_image_get_type");
  link(gtk_image_new, "gtk_image_new");
  link(gtk_image_new_from_file, "gtk_image_new_from_file");
  link(gtk_image_new_from_gicon, "gtk_image_new_from_gicon");
  link(gtk_image_new_from_icon_name, "gtk_image_new_from_icon_name");
  link(gtk_image_new_from_paintable, "gtk_image_new_from_paintable");
  link(gtk_image_new_from_pixbuf, "gtk_image_new_from_pixbuf");
  link(gtk_image_new_from_resource, "gtk_image_new_from_resource");
  link(gtk_image_clear, "gtk_image_clear");
  link(gtk_image_get_gicon, "gtk_image_get_gicon");
  link(gtk_image_get_icon_name, "gtk_image_get_icon_name");
  link(gtk_image_get_icon_size, "gtk_image_get_icon_size");
  link(gtk_image_get_paintable, "gtk_image_get_paintable");
  link(gtk_image_get_pixel_size, "gtk_image_get_pixel_size");
  link(gtk_image_get_storage_type, "gtk_image_get_storage_type");
  link(gtk_image_set_from_file, "gtk_image_set_from_file");
  link(gtk_image_set_from_gicon, "gtk_image_set_from_gicon");
  link(gtk_image_set_from_icon_name, "gtk_image_set_from_icon_name");
  link(gtk_image_set_from_paintable, "gtk_image_set_from_paintable");
  link(gtk_image_set_from_pixbuf, "gtk_image_set_from_pixbuf");
  link(gtk_image_set_from_resource, "gtk_image_set_from_resource");
  link(gtk_image_set_icon_size, "gtk_image_set_icon_size");
  link(gtk_image_set_pixel_size, "gtk_image_set_pixel_size");

  // InfoBar
  link(gtk_info_bar_get_type, "gtk_info_bar_get_type");
  link(gtk_info_bar_new, "gtk_info_bar_new");
  link(gtk_info_bar_new_with_buttons, "gtk_info_bar_new_with_buttons");
  link(gtk_info_bar_add_action_widget, "gtk_info_bar_add_action_widget");
  link(gtk_info_bar_add_button, "gtk_info_bar_add_button");
  link(gtk_info_bar_add_buttons, "gtk_info_bar_add_buttons");
  link(gtk_info_bar_add_child, "gtk_info_bar_add_child");
  link(gtk_info_bar_get_message_type, "gtk_info_bar_get_message_type");
  link(gtk_info_bar_get_revealed, "gtk_info_bar_get_revealed");
  link(gtk_info_bar_get_show_close_button, "gtk_info_bar_get_show_close_button");
  link(gtk_info_bar_remove_action_widget, "gtk_info_bar_remove_action_widget");
  link(gtk_info_bar_remove_child, "gtk_info_bar_remove_child");
  link(gtk_info_bar_response, "gtk_info_bar_response");
  link(gtk_info_bar_set_default_response, "gtk_info_bar_set_default_response");
  link(gtk_info_bar_set_message_type, "gtk_info_bar_set_message_type");
  link(gtk_info_bar_set_response_sensitive, "gtk_info_bar_set_response_sensitive");
  link(gtk_info_bar_set_revealed, "gtk_info_bar_set_revealed");
  link(gtk_info_bar_set_show_close_button, "gtk_info_bar_set_show_close_button");

  // Inscription
  link(gtk_inscription_get_type, "gtk_inscription_get_type");
  link(gtk_inscription_new, "gtk_inscription_new");
  link(gtk_inscription_get_attributes, "gtk_inscription_get_attributes");
  link(gtk_inscription_get_min_chars, "gtk_inscription_get_min_chars");
  link(gtk_inscription_get_min_lines, "gtk_inscription_get_min_lines");
  link(gtk_inscription_get_nat_chars, "gtk_inscription_get_nat_chars");
  link(gtk_inscription_get_nat_lines, "gtk_inscription_get_nat_lines");
  link(gtk_inscription_get_text, "gtk_inscription_get_text");
  link(gtk_inscription_get_text_overflow, "gtk_inscription_get_text_overflow");
  link(gtk_inscription_get_wrap_mode, "gtk_inscription_get_wrap_mode");
  link(gtk_inscription_get_xalign, "gtk_inscription_get_xalign");
  link(gtk_inscription_get_yalign, "gtk_inscription_get_yalign");
  link(gtk_inscription_set_attributes, "gtk_inscription_set_attributes");
  link(gtk_inscription_set_markup, "gtk_inscription_set_markup");
  link(gtk_inscription_set_min_chars, "gtk_inscription_set_min_chars");
  link(gtk_inscription_set_min_lines, "gtk_inscription_set_min_lines");
  link(gtk_inscription_set_nat_chars, "gtk_inscription_set_nat_chars");
  link(gtk_inscription_set_nat_lines, "gtk_inscription_set_nat_lines");
  link(gtk_inscription_set_text, "gtk_inscription_set_text");
  link(gtk_inscription_set_text_overflow, "gtk_inscription_set_text_overflow");
  link(gtk_inscription_set_wrap_mode, "gtk_inscription_set_wrap_mode");
  link(gtk_inscription_set_xalign, "gtk_inscription_set_xalign");
  link(gtk_inscription_set_yalign, "gtk_inscription_set_yalign");

  // KeyvalTrigger
  link(gtk_keyval_trigger_get_type, "gtk_keyval_trigger_get_type");
  link(gtk_keyval_trigger_new, "gtk_keyval_trigger_new");
  link(gtk_keyval_trigger_get_keyval, "gtk_keyval_trigger_get_keyval");
  link(gtk_keyval_trigger_get_modifiers, "gtk_keyval_trigger_get_modifiers");

  // Label
  link(gtk_label_get_type, "gtk_label_get_type");
  link(gtk_label_new, "gtk_label_new");
  link(gtk_label_new_with_mnemonic, "gtk_label_new_with_mnemonic");
  link(gtk_label_get_attributes, "gtk_label_get_attributes");
  link(gtk_label_get_current_uri, "gtk_label_get_current_uri");
  link(gtk_label_get_ellipsize, "gtk_label_get_ellipsize");
  link(gtk_label_get_extra_menu, "gtk_label_get_extra_menu");
  link(gtk_label_get_justify, "gtk_label_get_justify");
  link(gtk_label_get_label, "gtk_label_get_label");
  link(gtk_label_get_layout, "gtk_label_get_layout");
  link(gtk_label_get_layout_offsets, "gtk_label_get_layout_offsets");
  link(gtk_label_get_lines, "gtk_label_get_lines");
  link(gtk_label_get_max_width_chars, "gtk_label_get_max_width_chars");
  link(gtk_label_get_mnemonic_keyval, "gtk_label_get_mnemonic_keyval");
  link(gtk_label_get_mnemonic_widget, "gtk_label_get_mnemonic_widget");
  link(gtk_label_get_natural_wrap_mode, "gtk_label_get_natural_wrap_mode");
  link(gtk_label_get_selectable, "gtk_label_get_selectable");
  link(gtk_label_get_selection_bounds, "gtk_label_get_selection_bounds");
  link(gtk_label_get_single_line_mode, "gtk_label_get_single_line_mode");
  link(gtk_label_get_tabs, "gtk_label_get_tabs");
  link(gtk_label_get_text, "gtk_label_get_text");
  link(gtk_label_get_use_markup, "gtk_label_get_use_markup");
  link(gtk_label_get_use_underline, "gtk_label_get_use_underline");
  link(gtk_label_get_width_chars, "gtk_label_get_width_chars");
  link(gtk_label_get_wrap, "gtk_label_get_wrap");
  link(gtk_label_get_wrap_mode, "gtk_label_get_wrap_mode");
  link(gtk_label_get_xalign, "gtk_label_get_xalign");
  link(gtk_label_get_yalign, "gtk_label_get_yalign");
  link(gtk_label_select_region, "gtk_label_select_region");
  link(gtk_label_set_attributes, "gtk_label_set_attributes");
  link(gtk_label_set_ellipsize, "gtk_label_set_ellipsize");
  link(gtk_label_set_extra_menu, "gtk_label_set_extra_menu");
  link(gtk_label_set_justify, "gtk_label_set_justify");
  link(gtk_label_set_label, "gtk_label_set_label");
  link(gtk_label_set_lines, "gtk_label_set_lines");
  link(gtk_label_set_markup, "gtk_label_set_markup");
  link(gtk_label_set_markup_with_mnemonic, "gtk_label_set_markup_with_mnemonic");
  link(gtk_label_set_max_width_chars, "gtk_label_set_max_width_chars");
  link(gtk_label_set_mnemonic_widget, "gtk_label_set_mnemonic_widget");
  link(gtk_label_set_natural_wrap_mode, "gtk_label_set_natural_wrap_mode");
  link(gtk_label_set_selectable, "gtk_label_set_selectable");
  link(gtk_label_set_single_line_mode, "gtk_label_set_single_line_mode");
  link(gtk_label_set_tabs, "gtk_label_set_tabs");
  link(gtk_label_set_text, "gtk_label_set_text");
  link(gtk_label_set_text_with_mnemonic, "gtk_label_set_text_with_mnemonic");
  link(gtk_label_set_use_markup, "gtk_label_set_use_markup");
  link(gtk_label_set_use_underline, "gtk_label_set_use_underline");
  link(gtk_label_set_width_chars, "gtk_label_set_width_chars");
  link(gtk_label_set_wrap, "gtk_label_set_wrap");
  link(gtk_label_set_wrap_mode, "gtk_label_set_wrap_mode");
  link(gtk_label_set_xalign, "gtk_label_set_xalign");
  link(gtk_label_set_yalign, "gtk_label_set_yalign");

  // LayoutChild
  link(gtk_layout_child_get_type, "gtk_layout_child_get_type");
  link(gtk_layout_child_get_child_widget, "gtk_layout_child_get_child_widget");
  link(gtk_layout_child_get_layout_manager, "gtk_layout_child_get_layout_manager");

  // LayoutManager
  link(gtk_layout_manager_get_type, "gtk_layout_manager_get_type");
  link(gtk_layout_manager_allocate, "gtk_layout_manager_allocate");
  link(gtk_layout_manager_get_layout_child, "gtk_layout_manager_get_layout_child");
  link(gtk_layout_manager_get_request_mode, "gtk_layout_manager_get_request_mode");
  link(gtk_layout_manager_get_widget, "gtk_layout_manager_get_widget");
  link(gtk_layout_manager_layout_changed, "gtk_layout_manager_layout_changed");
  link(gtk_layout_manager_measure, "gtk_layout_manager_measure");

  // LevelBar
  link(gtk_level_bar_get_type, "gtk_level_bar_get_type");
  link(gtk_level_bar_new, "gtk_level_bar_new");
  link(gtk_level_bar_new_for_interval, "gtk_level_bar_new_for_interval");
  link(gtk_level_bar_add_offset_value, "gtk_level_bar_add_offset_value");
  link(gtk_level_bar_get_inverted, "gtk_level_bar_get_inverted");
  link(gtk_level_bar_get_max_value, "gtk_level_bar_get_max_value");
  link(gtk_level_bar_get_min_value, "gtk_level_bar_get_min_value");
  link(gtk_level_bar_get_mode, "gtk_level_bar_get_mode");
  link(gtk_level_bar_get_offset_value, "gtk_level_bar_get_offset_value");
  link(gtk_level_bar_get_value, "gtk_level_bar_get_value");
  link(gtk_level_bar_remove_offset_value, "gtk_level_bar_remove_offset_value");
  link(gtk_level_bar_set_inverted, "gtk_level_bar_set_inverted");
  link(gtk_level_bar_set_max_value, "gtk_level_bar_set_max_value");
  link(gtk_level_bar_set_min_value, "gtk_level_bar_set_min_value");
  link(gtk_level_bar_set_mode, "gtk_level_bar_set_mode");
  link(gtk_level_bar_set_value, "gtk_level_bar_set_value");

  // LinkButton
  link(gtk_link_button_get_type, "gtk_link_button_get_type");
  link(gtk_link_button_new, "gtk_link_button_new");
  link(gtk_link_button_new_with_label, "gtk_link_button_new_with_label");
  link(gtk_link_button_get_uri, "gtk_link_button_get_uri");
  link(gtk_link_button_get_visited, "gtk_link_button_get_visited");
  link(gtk_link_button_set_uri, "gtk_link_button_set_uri");
  link(gtk_link_button_set_visited, "gtk_link_button_set_visited");

  // ListBase
  link(gtk_list_base_get_type, "gtk_list_base_get_type");

  // ListBox
  link(gtk_list_box_get_type, "gtk_list_box_get_type");
  link(gtk_list_box_new, "gtk_list_box_new");
  link(gtk_list_box_append, "gtk_list_box_append");
  link(gtk_list_box_bind_model, "gtk_list_box_bind_model");
  link(gtk_list_box_drag_highlight_row, "gtk_list_box_drag_highlight_row");
  link(gtk_list_box_drag_unhighlight_row, "gtk_list_box_drag_unhighlight_row");
  link(gtk_list_box_get_activate_on_single_click, "gtk_list_box_get_activate_on_single_click");
  link(gtk_list_box_get_adjustment, "gtk_list_box_get_adjustment");
  link(gtk_list_box_get_row_at_index, "gtk_list_box_get_row_at_index");
  link(gtk_list_box_get_row_at_y, "gtk_list_box_get_row_at_y");
  link(gtk_list_box_get_selected_row, "gtk_list_box_get_selected_row");
  link(gtk_list_box_get_selected_rows, "gtk_list_box_get_selected_rows");
  link(gtk_list_box_get_selection_mode, "gtk_list_box_get_selection_mode");
  link(gtk_list_box_get_show_separators, "gtk_list_box_get_show_separators");
  link(gtk_list_box_insert, "gtk_list_box_insert");
  link(gtk_list_box_invalidate_filter, "gtk_list_box_invalidate_filter");
  link(gtk_list_box_invalidate_headers, "gtk_list_box_invalidate_headers");
  link(gtk_list_box_invalidate_sort, "gtk_list_box_invalidate_sort");
  link(gtk_list_box_prepend, "gtk_list_box_prepend");
  link(gtk_list_box_remove, "gtk_list_box_remove");
  link(gtk_list_box_remove_all, "gtk_list_box_remove_all");
  link(gtk_list_box_select_all, "gtk_list_box_select_all");
  link(gtk_list_box_select_row, "gtk_list_box_select_row");
  link(gtk_list_box_selected_foreach, "gtk_list_box_selected_foreach");
  link(gtk_list_box_set_activate_on_single_click, "gtk_list_box_set_activate_on_single_click");
  link(gtk_list_box_set_adjustment, "gtk_list_box_set_adjustment");
  link(gtk_list_box_set_filter_func, "gtk_list_box_set_filter_func");
  link(gtk_list_box_set_header_func, "gtk_list_box_set_header_func");
  link(gtk_list_box_set_placeholder, "gtk_list_box_set_placeholder");
  link(gtk_list_box_set_selection_mode, "gtk_list_box_set_selection_mode");
  link(gtk_list_box_set_show_separators, "gtk_list_box_set_show_separators");
  link(gtk_list_box_set_sort_func, "gtk_list_box_set_sort_func");
  link(gtk_list_box_unselect_all, "gtk_list_box_unselect_all");
  link(gtk_list_box_unselect_row, "gtk_list_box_unselect_row");

  // ListBoxRow
  link(gtk_list_box_row_get_type, "gtk_list_box_row_get_type");
  link(gtk_list_box_row_new, "gtk_list_box_row_new");
  link(gtk_list_box_row_changed, "gtk_list_box_row_changed");
  link(gtk_list_box_row_get_activatable, "gtk_list_box_row_get_activatable");
  link(gtk_list_box_row_get_child, "gtk_list_box_row_get_child");
  link(gtk_list_box_row_get_header, "gtk_list_box_row_get_header");
  link(gtk_list_box_row_get_index, "gtk_list_box_row_get_index");
  link(gtk_list_box_row_get_selectable, "gtk_list_box_row_get_selectable");
  link(gtk_list_box_row_is_selected, "gtk_list_box_row_is_selected");
  link(gtk_list_box_row_set_activatable, "gtk_list_box_row_set_activatable");
  link(gtk_list_box_row_set_child, "gtk_list_box_row_set_child");
  link(gtk_list_box_row_set_header, "gtk_list_box_row_set_header");
  link(gtk_list_box_row_set_selectable, "gtk_list_box_row_set_selectable");

  // ListHeader
  link(gtk_list_header_get_type, "gtk_list_header_get_type");
  link(gtk_list_header_get_child, "gtk_list_header_get_child");
  link(gtk_list_header_get_end, "gtk_list_header_get_end");
  link(gtk_list_header_get_item, "gtk_list_header_get_item");
  link(gtk_list_header_get_n_items, "gtk_list_header_get_n_items");
  link(gtk_list_header_get_start, "gtk_list_header_get_start");
  link(gtk_list_header_set_child, "gtk_list_header_set_child");

  // ListItem
  link(gtk_list_item_get_type, "gtk_list_item_get_type");
  link(gtk_list_item_get_accessible_description, "gtk_list_item_get_accessible_description");
  link(gtk_list_item_get_accessible_label, "gtk_list_item_get_accessible_label");
  link(gtk_list_item_get_activatable, "gtk_list_item_get_activatable");
  link(gtk_list_item_get_child, "gtk_list_item_get_child");
  link(gtk_list_item_get_focusable, "gtk_list_item_get_focusable");
  link(gtk_list_item_get_item, "gtk_list_item_get_item");
  link(gtk_list_item_get_position, "gtk_list_item_get_position");
  link(gtk_list_item_get_selectable, "gtk_list_item_get_selectable");
  link(gtk_list_item_get_selected, "gtk_list_item_get_selected");
  link(gtk_list_item_set_accessible_description, "gtk_list_item_set_accessible_description");
  link(gtk_list_item_set_accessible_label, "gtk_list_item_set_accessible_label");
  link(gtk_list_item_set_activatable, "gtk_list_item_set_activatable");
  link(gtk_list_item_set_child, "gtk_list_item_set_child");
  link(gtk_list_item_set_focusable, "gtk_list_item_set_focusable");
  link(gtk_list_item_set_selectable, "gtk_list_item_set_selectable");

  // ListItemFactory
  link(gtk_list_item_factory_get_type, "gtk_list_item_factory_get_type");

  // ListStore
  link(gtk_list_store_get_type, "gtk_list_store_get_type");
  link(gtk_list_store_new, "gtk_list_store_new");
  link(gtk_list_store_newv, "gtk_list_store_newv");
  link(gtk_list_store_append, "gtk_list_store_append");
  link(gtk_list_store_clear, "gtk_list_store_clear");
  link(gtk_list_store_insert, "gtk_list_store_insert");
  link(gtk_list_store_insert_after, "gtk_list_store_insert_after");
  link(gtk_list_store_insert_before, "gtk_list_store_insert_before");
  link(gtk_list_store_insert_with_values, "gtk_list_store_insert_with_values");
  link(gtk_list_store_insert_with_valuesv, "gtk_list_store_insert_with_valuesv");
  link(gtk_list_store_iter_is_valid, "gtk_list_store_iter_is_valid");
  link(gtk_list_store_move_after, "gtk_list_store_move_after");
  link(gtk_list_store_move_before, "gtk_list_store_move_before");
  link(gtk_list_store_prepend, "gtk_list_store_prepend");
  link(gtk_list_store_remove, "gtk_list_store_remove");
  link(gtk_list_store_reorder, "gtk_list_store_reorder");
  link(gtk_list_store_set, "gtk_list_store_set");
  link(gtk_list_store_set_column_types, "gtk_list_store_set_column_types");
  link(gtk_list_store_set_valist, "gtk_list_store_set_valist");
  link(gtk_list_store_set_value, "gtk_list_store_set_value");
  link(gtk_list_store_set_valuesv, "gtk_list_store_set_valuesv");
  link(gtk_list_store_swap, "gtk_list_store_swap");

  // ListView
  link(gtk_list_view_get_type, "gtk_list_view_get_type");
  link(gtk_list_view_new, "gtk_list_view_new");
  link(gtk_list_view_get_enable_rubberband, "gtk_list_view_get_enable_rubberband");
  link(gtk_list_view_get_factory, "gtk_list_view_get_factory");
  link(gtk_list_view_get_header_factory, "gtk_list_view_get_header_factory");
  link(gtk_list_view_get_model, "gtk_list_view_get_model");
  link(gtk_list_view_get_show_separators, "gtk_list_view_get_show_separators");
  link(gtk_list_view_get_single_click_activate, "gtk_list_view_get_single_click_activate");
  link(gtk_list_view_get_tab_behavior, "gtk_list_view_get_tab_behavior");
  link(gtk_list_view_scroll_to, "gtk_list_view_scroll_to");
  link(gtk_list_view_set_enable_rubberband, "gtk_list_view_set_enable_rubberband");
  link(gtk_list_view_set_factory, "gtk_list_view_set_factory");
  link(gtk_list_view_set_header_factory, "gtk_list_view_set_header_factory");
  link(gtk_list_view_set_model, "gtk_list_view_set_model");
  link(gtk_list_view_set_show_separators, "gtk_list_view_set_show_separators");
  link(gtk_list_view_set_single_click_activate, "gtk_list_view_set_single_click_activate");
  link(gtk_list_view_set_tab_behavior, "gtk_list_view_set_tab_behavior");

  // LockButton
  link(gtk_lock_button_get_type, "gtk_lock_button_get_type");
  link(gtk_lock_button_new, "gtk_lock_button_new");
  link(gtk_lock_button_get_permission, "gtk_lock_button_get_permission");
  link(gtk_lock_button_set_permission, "gtk_lock_button_set_permission");

  // MapListModel
  link(gtk_map_list_model_get_type, "gtk_map_list_model_get_type");
  link(gtk_map_list_model_new, "gtk_map_list_model_new");
  link(gtk_map_list_model_get_model, "gtk_map_list_model_get_model");
  link(gtk_map_list_model_has_map, "gtk_map_list_model_has_map");
  link(gtk_map_list_model_set_map_func, "gtk_map_list_model_set_map_func");
  link(gtk_map_list_model_set_model, "gtk_map_list_model_set_model");

  // MediaControls
  link(gtk_media_controls_get_type, "gtk_media_controls_get_type");
  link(gtk_media_controls_new, "gtk_media_controls_new");
  link(gtk_media_controls_get_media_stream, "gtk_media_controls_get_media_stream");
  link(gtk_media_controls_set_media_stream, "gtk_media_controls_set_media_stream");

  // MediaFile
  link(gtk_media_file_get_type, "gtk_media_file_get_type");
  link(gtk_media_file_new, "gtk_media_file_new");
  link(gtk_media_file_new_for_file, "gtk_media_file_new_for_file");
  link(gtk_media_file_new_for_filename, "gtk_media_file_new_for_filename");
  link(gtk_media_file_new_for_input_stream, "gtk_media_file_new_for_input_stream");
  link(gtk_media_file_new_for_resource, "gtk_media_file_new_for_resource");
  link(gtk_media_file_clear, "gtk_media_file_clear");
  link(gtk_media_file_get_file, "gtk_media_file_get_file");
  link(gtk_media_file_get_input_stream, "gtk_media_file_get_input_stream");
  link(gtk_media_file_set_file, "gtk_media_file_set_file");
  link(gtk_media_file_set_filename, "gtk_media_file_set_filename");
  link(gtk_media_file_set_input_stream, "gtk_media_file_set_input_stream");
  link(gtk_media_file_set_resource, "gtk_media_file_set_resource");

  // MediaStream
  link(gtk_media_stream_get_type, "gtk_media_stream_get_type");
  link(gtk_media_stream_ended, "gtk_media_stream_ended");
  link(gtk_media_stream_error, "gtk_media_stream_error");
  link(gtk_media_stream_error_valist, "gtk_media_stream_error_valist");
  link(gtk_media_stream_gerror, "gtk_media_stream_gerror");
  link(gtk_media_stream_get_duration, "gtk_media_stream_get_duration");
  link(gtk_media_stream_get_ended, "gtk_media_stream_get_ended");
  link(gtk_media_stream_get_error, "gtk_media_stream_get_error");
  link(gtk_media_stream_get_loop, "gtk_media_stream_get_loop");
  link(gtk_media_stream_get_muted, "gtk_media_stream_get_muted");
  link(gtk_media_stream_get_playing, "gtk_media_stream_get_playing");
  link(gtk_media_stream_get_timestamp, "gtk_media_stream_get_timestamp");
  link(gtk_media_stream_get_volume, "gtk_media_stream_get_volume");
  link(gtk_media_stream_has_audio, "gtk_media_stream_has_audio");
  link(gtk_media_stream_has_video, "gtk_media_stream_has_video");
  link(gtk_media_stream_is_prepared, "gtk_media_stream_is_prepared");
  link(gtk_media_stream_is_seekable, "gtk_media_stream_is_seekable");
  link(gtk_media_stream_is_seeking, "gtk_media_stream_is_seeking");
  link(gtk_media_stream_pause, "gtk_media_stream_pause");
  link(gtk_media_stream_play, "gtk_media_stream_play");
  link(gtk_media_stream_prepared, "gtk_media_stream_prepared");
  link(gtk_media_stream_realize, "gtk_media_stream_realize");
  link(gtk_media_stream_seek, "gtk_media_stream_seek");
  link(gtk_media_stream_seek_failed, "gtk_media_stream_seek_failed");
  link(gtk_media_stream_seek_success, "gtk_media_stream_seek_success");
  link(gtk_media_stream_set_loop, "gtk_media_stream_set_loop");
  link(gtk_media_stream_set_muted, "gtk_media_stream_set_muted");
  link(gtk_media_stream_set_playing, "gtk_media_stream_set_playing");
  link(gtk_media_stream_set_volume, "gtk_media_stream_set_volume");
  link(gtk_media_stream_stream_ended, "gtk_media_stream_stream_ended");
  link(gtk_media_stream_stream_prepared, "gtk_media_stream_stream_prepared");
  link(gtk_media_stream_stream_unprepared, "gtk_media_stream_stream_unprepared");
  link(gtk_media_stream_unprepared, "gtk_media_stream_unprepared");
  link(gtk_media_stream_unrealize, "gtk_media_stream_unrealize");
  link(gtk_media_stream_update, "gtk_media_stream_update");

  // MenuButton
  link(gtk_menu_button_get_type, "gtk_menu_button_get_type");
  link(gtk_menu_button_new, "gtk_menu_button_new");
  link(gtk_menu_button_get_active, "gtk_menu_button_get_active");
  link(gtk_menu_button_get_always_show_arrow, "gtk_menu_button_get_always_show_arrow");
  link(gtk_menu_button_get_can_shrink, "gtk_menu_button_get_can_shrink");
  link(gtk_menu_button_get_child, "gtk_menu_button_get_child");
  link(gtk_menu_button_get_direction, "gtk_menu_button_get_direction");
  link(gtk_menu_button_get_has_frame, "gtk_menu_button_get_has_frame");
  link(gtk_menu_button_get_icon_name, "gtk_menu_button_get_icon_name");
  link(gtk_menu_button_get_label, "gtk_menu_button_get_label");
  link(gtk_menu_button_get_menu_model, "gtk_menu_button_get_menu_model");
  link(gtk_menu_button_get_popover, "gtk_menu_button_get_popover");
  link(gtk_menu_button_get_primary, "gtk_menu_button_get_primary");
  link(gtk_menu_button_get_use_underline, "gtk_menu_button_get_use_underline");
  link(gtk_menu_button_popdown, "gtk_menu_button_popdown");
  link(gtk_menu_button_popup, "gtk_menu_button_popup");
  link(gtk_menu_button_set_active, "gtk_menu_button_set_active");
  link(gtk_menu_button_set_always_show_arrow, "gtk_menu_button_set_always_show_arrow");
  link(gtk_menu_button_set_can_shrink, "gtk_menu_button_set_can_shrink");
  link(gtk_menu_button_set_child, "gtk_menu_button_set_child");
  link(gtk_menu_button_set_create_popup_func, "gtk_menu_button_set_create_popup_func");
  link(gtk_menu_button_set_direction, "gtk_menu_button_set_direction");
  link(gtk_menu_button_set_has_frame, "gtk_menu_button_set_has_frame");
  link(gtk_menu_button_set_icon_name, "gtk_menu_button_set_icon_name");
  link(gtk_menu_button_set_label, "gtk_menu_button_set_label");
  link(gtk_menu_button_set_menu_model, "gtk_menu_button_set_menu_model");
  link(gtk_menu_button_set_popover, "gtk_menu_button_set_popover");
  link(gtk_menu_button_set_primary, "gtk_menu_button_set_primary");
  link(gtk_menu_button_set_use_underline, "gtk_menu_button_set_use_underline");

  // MessageDialog
  link(gtk_message_dialog_get_type, "gtk_message_dialog_get_type");
  link(gtk_message_dialog_new, "gtk_message_dialog_new");
  link(gtk_message_dialog_new_with_markup, "gtk_message_dialog_new_with_markup");
  link(gtk_message_dialog_format_secondary_markup, "gtk_message_dialog_format_secondary_markup");
  link(gtk_message_dialog_format_secondary_text, "gtk_message_dialog_format_secondary_text");
  link(gtk_message_dialog_get_message_area, "gtk_message_dialog_get_message_area");
  link(gtk_message_dialog_set_markup, "gtk_message_dialog_set_markup");

  // MnemonicAction
  link(gtk_mnemonic_action_get_type, "gtk_mnemonic_action_get_type");
  link(gtk_mnemonic_action_get, "gtk_mnemonic_action_get");

  // MnemonicTrigger
  link(gtk_mnemonic_trigger_get_type, "gtk_mnemonic_trigger_get_type");
  link(gtk_mnemonic_trigger_new, "gtk_mnemonic_trigger_new");
  link(gtk_mnemonic_trigger_get_keyval, "gtk_mnemonic_trigger_get_keyval");

  // MountOperation
  link(gtk_mount_operation_get_type, "gtk_mount_operation_get_type");
  link(gtk_mount_operation_new, "gtk_mount_operation_new");
  link(gtk_mount_operation_get_display, "gtk_mount_operation_get_display");
  link(gtk_mount_operation_get_parent, "gtk_mount_operation_get_parent");
  link(gtk_mount_operation_is_showing, "gtk_mount_operation_is_showing");
  link(gtk_mount_operation_set_display, "gtk_mount_operation_set_display");
  link(gtk_mount_operation_set_parent, "gtk_mount_operation_set_parent");

  // MultiFilter
  link(gtk_multi_filter_get_type, "gtk_multi_filter_get_type");
  link(gtk_multi_filter_append, "gtk_multi_filter_append");
  link(gtk_multi_filter_remove, "gtk_multi_filter_remove");

  // MultiSelection
  link(gtk_multi_selection_get_type, "gtk_multi_selection_get_type");
  link(gtk_multi_selection_new, "gtk_multi_selection_new");
  link(gtk_multi_selection_get_model, "gtk_multi_selection_get_model");
  link(gtk_multi_selection_set_model, "gtk_multi_selection_set_model");

  // MultiSorter
  link(gtk_multi_sorter_get_type, "gtk_multi_sorter_get_type");
  link(gtk_multi_sorter_new, "gtk_multi_sorter_new");
  link(gtk_multi_sorter_append, "gtk_multi_sorter_append");
  link(gtk_multi_sorter_remove, "gtk_multi_sorter_remove");

  // NamedAction
  link(gtk_named_action_get_type, "gtk_named_action_get_type");
  link(gtk_named_action_new, "gtk_named_action_new");
  link(gtk_named_action_get_action_name, "gtk_named_action_get_action_name");

  // Native
  link(gtk_native_get_type, "gtk_native_get_type");
  link(gtk_native_get_for_surface, "gtk_native_get_for_surface");
  link(gtk_native_get_renderer, "gtk_native_get_renderer");
  link(gtk_native_get_surface, "gtk_native_get_surface");
  link(gtk_native_get_surface_transform, "gtk_native_get_surface_transform");
  link(gtk_native_realize, "gtk_native_realize");
  link(gtk_native_unrealize, "gtk_native_unrealize");

  // NativeDialog
  link(gtk_native_dialog_get_type, "gtk_native_dialog_get_type");
  link(gtk_native_dialog_destroy, "gtk_native_dialog_destroy");
  link(gtk_native_dialog_get_modal, "gtk_native_dialog_get_modal");
  link(gtk_native_dialog_get_title, "gtk_native_dialog_get_title");
  link(gtk_native_dialog_get_transient_for, "gtk_native_dialog_get_transient_for");
  link(gtk_native_dialog_get_visible, "gtk_native_dialog_get_visible");
  link(gtk_native_dialog_hide, "gtk_native_dialog_hide");
  link(gtk_native_dialog_set_modal, "gtk_native_dialog_set_modal");
  link(gtk_native_dialog_set_title, "gtk_native_dialog_set_title");
  link(gtk_native_dialog_set_transient_for, "gtk_native_dialog_set_transient_for");
  link(gtk_native_dialog_show, "gtk_native_dialog_show");

  // NeverTrigger
  link(gtk_never_trigger_get_type, "gtk_never_trigger_get_type");
  link(gtk_never_trigger_get, "gtk_never_trigger_get");

  // NoSelection
  link(gtk_no_selection_get_type, "gtk_no_selection_get_type");
  link(gtk_no_selection_new, "gtk_no_selection_new");
  link(gtk_no_selection_get_model, "gtk_no_selection_get_model");
  link(gtk_no_selection_set_model, "gtk_no_selection_set_model");

  // Notebook
  link(gtk_notebook_get_type, "gtk_notebook_get_type");
  link(gtk_notebook_new, "gtk_notebook_new");
  link(gtk_notebook_append_page, "gtk_notebook_append_page");
  link(gtk_notebook_append_page_menu, "gtk_notebook_append_page_menu");
  link(gtk_notebook_detach_tab, "gtk_notebook_detach_tab");
  link(gtk_notebook_get_action_widget, "gtk_notebook_get_action_widget");
  link(gtk_notebook_get_current_page, "gtk_notebook_get_current_page");
  link(gtk_notebook_get_group_name, "gtk_notebook_get_group_name");
  link(gtk_notebook_get_menu_label, "gtk_notebook_get_menu_label");
  link(gtk_notebook_get_menu_label_text, "gtk_notebook_get_menu_label_text");
  link(gtk_notebook_get_n_pages, "gtk_notebook_get_n_pages");
  link(gtk_notebook_get_nth_page, "gtk_notebook_get_nth_page");
  link(gtk_notebook_get_page, "gtk_notebook_get_page");
  link(gtk_notebook_get_pages, "gtk_notebook_get_pages");
  link(gtk_notebook_get_scrollable, "gtk_notebook_get_scrollable");
  link(gtk_notebook_get_show_border, "gtk_notebook_get_show_border");
  link(gtk_notebook_get_show_tabs, "gtk_notebook_get_show_tabs");
  link(gtk_notebook_get_tab_detachable, "gtk_notebook_get_tab_detachable");
  link(gtk_notebook_get_tab_label, "gtk_notebook_get_tab_label");
  link(gtk_notebook_get_tab_label_text, "gtk_notebook_get_tab_label_text");
  link(gtk_notebook_get_tab_pos, "gtk_notebook_get_tab_pos");
  link(gtk_notebook_get_tab_reorderable, "gtk_notebook_get_tab_reorderable");
  link(gtk_notebook_insert_page, "gtk_notebook_insert_page");
  link(gtk_notebook_insert_page_menu, "gtk_notebook_insert_page_menu");
  link(gtk_notebook_next_page, "gtk_notebook_next_page");
  link(gtk_notebook_page_num, "gtk_notebook_page_num");
  link(gtk_notebook_popup_disable, "gtk_notebook_popup_disable");
  link(gtk_notebook_popup_enable, "gtk_notebook_popup_enable");
  link(gtk_notebook_prepend_page, "gtk_notebook_prepend_page");
  link(gtk_notebook_prepend_page_menu, "gtk_notebook_prepend_page_menu");
  link(gtk_notebook_prev_page, "gtk_notebook_prev_page");
  link(gtk_notebook_remove_page, "gtk_notebook_remove_page");
  link(gtk_notebook_reorder_child, "gtk_notebook_reorder_child");
  link(gtk_notebook_set_action_widget, "gtk_notebook_set_action_widget");
  link(gtk_notebook_set_current_page, "gtk_notebook_set_current_page");
  link(gtk_notebook_set_group_name, "gtk_notebook_set_group_name");
  link(gtk_notebook_set_menu_label, "gtk_notebook_set_menu_label");
  link(gtk_notebook_set_menu_label_text, "gtk_notebook_set_menu_label_text");
  link(gtk_notebook_set_scrollable, "gtk_notebook_set_scrollable");
  link(gtk_notebook_set_show_border, "gtk_notebook_set_show_border");
  link(gtk_notebook_set_show_tabs, "gtk_notebook_set_show_tabs");
  link(gtk_notebook_set_tab_detachable, "gtk_notebook_set_tab_detachable");
  link(gtk_notebook_set_tab_label, "gtk_notebook_set_tab_label");
  link(gtk_notebook_set_tab_label_text, "gtk_notebook_set_tab_label_text");
  link(gtk_notebook_set_tab_pos, "gtk_notebook_set_tab_pos");
  link(gtk_notebook_set_tab_reorderable, "gtk_notebook_set_tab_reorderable");

  // NotebookPage
  link(gtk_notebook_page_get_type, "gtk_notebook_page_get_type");
  link(gtk_notebook_page_get_child, "gtk_notebook_page_get_child");

  // NothingAction
  link(gtk_nothing_action_get_type, "gtk_nothing_action_get_type");
  link(gtk_nothing_action_get, "gtk_nothing_action_get");

  // NumericSorter
  link(gtk_numeric_sorter_get_type, "gtk_numeric_sorter_get_type");
  link(gtk_numeric_sorter_new, "gtk_numeric_sorter_new");
  link(gtk_numeric_sorter_get_expression, "gtk_numeric_sorter_get_expression");
  link(gtk_numeric_sorter_get_sort_order, "gtk_numeric_sorter_get_sort_order");
  link(gtk_numeric_sorter_set_expression, "gtk_numeric_sorter_set_expression");
  link(gtk_numeric_sorter_set_sort_order, "gtk_numeric_sorter_set_sort_order");

  // ObjectExpression
  link(gtk_object_expression_get_type, "gtk_object_expression_get_type");
  link(gtk_object_expression_new, "gtk_object_expression_new");
  link(gtk_object_expression_get_object, "gtk_object_expression_get_object");

  // Orientable
  link(gtk_orientable_get_type, "gtk_orientable_get_type");
  link(gtk_orientable_get_orientation, "gtk_orientable_get_orientation");
  link(gtk_orientable_set_orientation, "gtk_orientable_set_orientation");

  // Overlay
  link(gtk_overlay_get_type, "gtk_overlay_get_type");
  link(gtk_overlay_new, "gtk_overlay_new");
  link(gtk_overlay_add_overlay, "gtk_overlay_add_overlay");
  link(gtk_overlay_get_child, "gtk_overlay_get_child");
  link(gtk_overlay_get_clip_overlay, "gtk_overlay_get_clip_overlay");
  link(gtk_overlay_get_measure_overlay, "gtk_overlay_get_measure_overlay");
  link(gtk_overlay_remove_overlay, "gtk_overlay_remove_overlay");
  link(gtk_overlay_set_child, "gtk_overlay_set_child");
  link(gtk_overlay_set_clip_overlay, "gtk_overlay_set_clip_overlay");
  link(gtk_overlay_set_measure_overlay, "gtk_overlay_set_measure_overlay");

  // OverlayLayout
  link(gtk_overlay_layout_get_type, "gtk_overlay_layout_get_type");
  link(gtk_overlay_layout_new, "gtk_overlay_layout_new");

  // OverlayLayoutChild
  link(gtk_overlay_layout_child_get_type, "gtk_overlay_layout_child_get_type");
  link(gtk_overlay_layout_child_get_clip_overlay, "gtk_overlay_layout_child_get_clip_overlay");
  link(gtk_overlay_layout_child_get_measure, "gtk_overlay_layout_child_get_measure");
  link(gtk_overlay_layout_child_set_clip_overlay, "gtk_overlay_layout_child_set_clip_overlay");
  link(gtk_overlay_layout_child_set_measure, "gtk_overlay_layout_child_set_measure");

  // PadController
  link(gtk_pad_controller_get_type, "gtk_pad_controller_get_type");
  link(gtk_pad_controller_new, "gtk_pad_controller_new");
  link(gtk_pad_controller_set_action, "gtk_pad_controller_set_action");
  link(gtk_pad_controller_set_action_entries, "gtk_pad_controller_set_action_entries");

  // PageSetup
  link(gtk_page_setup_get_type, "gtk_page_setup_get_type");
  link(gtk_page_setup_new, "gtk_page_setup_new");
  link(gtk_page_setup_new_from_file, "gtk_page_setup_new_from_file");
  link(gtk_page_setup_new_from_gvariant, "gtk_page_setup_new_from_gvariant");
  link(gtk_page_setup_new_from_key_file, "gtk_page_setup_new_from_key_file");
  link(gtk_page_setup_copy, "gtk_page_setup_copy");
  link(gtk_page_setup_get_bottom_margin, "gtk_page_setup_get_bottom_margin");
  link(gtk_page_setup_get_left_margin, "gtk_page_setup_get_left_margin");
  link(gtk_page_setup_get_orientation, "gtk_page_setup_get_orientation");
  link(gtk_page_setup_get_page_height, "gtk_page_setup_get_page_height");
  link(gtk_page_setup_get_page_width, "gtk_page_setup_get_page_width");
  link(gtk_page_setup_get_paper_height, "gtk_page_setup_get_paper_height");
  link(gtk_page_setup_get_paper_size, "gtk_page_setup_get_paper_size");
  link(gtk_page_setup_get_paper_width, "gtk_page_setup_get_paper_width");
  link(gtk_page_setup_get_right_margin, "gtk_page_setup_get_right_margin");
  link(gtk_page_setup_get_top_margin, "gtk_page_setup_get_top_margin");
  link(gtk_page_setup_load_file, "gtk_page_setup_load_file");
  link(gtk_page_setup_load_key_file, "gtk_page_setup_load_key_file");
  link(gtk_page_setup_set_bottom_margin, "gtk_page_setup_set_bottom_margin");
  link(gtk_page_setup_set_left_margin, "gtk_page_setup_set_left_margin");
  link(gtk_page_setup_set_orientation, "gtk_page_setup_set_orientation");
  link(gtk_page_setup_set_paper_size, "gtk_page_setup_set_paper_size");
  link(gtk_page_setup_set_paper_size_and_default_margins, "gtk_page_setup_set_paper_size_and_default_margins");
  link(gtk_page_setup_set_right_margin, "gtk_page_setup_set_right_margin");
  link(gtk_page_setup_set_top_margin, "gtk_page_setup_set_top_margin");
  link(gtk_page_setup_to_file, "gtk_page_setup_to_file");
  link(gtk_page_setup_to_gvariant, "gtk_page_setup_to_gvariant");
  link(gtk_page_setup_to_key_file, "gtk_page_setup_to_key_file");

  // PageSetupUnixDialog
  link(gtk_page_setup_unix_dialog_get_type, "gtk_page_setup_unix_dialog_get_type");
  link(gtk_page_setup_unix_dialog_new, "gtk_page_setup_unix_dialog_new");
  link(gtk_page_setup_unix_dialog_get_page_setup, "gtk_page_setup_unix_dialog_get_page_setup");
  link(gtk_page_setup_unix_dialog_get_print_settings, "gtk_page_setup_unix_dialog_get_print_settings");
  link(gtk_page_setup_unix_dialog_set_page_setup, "gtk_page_setup_unix_dialog_set_page_setup");
  link(gtk_page_setup_unix_dialog_set_print_settings, "gtk_page_setup_unix_dialog_set_print_settings");

  // Paned
  link(gtk_paned_get_type, "gtk_paned_get_type");
  link(gtk_paned_new, "gtk_paned_new");
  link(gtk_paned_get_end_child, "gtk_paned_get_end_child");
  link(gtk_paned_get_position, "gtk_paned_get_position");
  link(gtk_paned_get_resize_end_child, "gtk_paned_get_resize_end_child");
  link(gtk_paned_get_resize_start_child, "gtk_paned_get_resize_start_child");
  link(gtk_paned_get_shrink_end_child, "gtk_paned_get_shrink_end_child");
  link(gtk_paned_get_shrink_start_child, "gtk_paned_get_shrink_start_child");
  link(gtk_paned_get_start_child, "gtk_paned_get_start_child");
  link(gtk_paned_get_wide_handle, "gtk_paned_get_wide_handle");
  link(gtk_paned_set_end_child, "gtk_paned_set_end_child");
  link(gtk_paned_set_position, "gtk_paned_set_position");
  link(gtk_paned_set_resize_end_child, "gtk_paned_set_resize_end_child");
  link(gtk_paned_set_resize_start_child, "gtk_paned_set_resize_start_child");
  link(gtk_paned_set_shrink_end_child, "gtk_paned_set_shrink_end_child");
  link(gtk_paned_set_shrink_start_child, "gtk_paned_set_shrink_start_child");
  link(gtk_paned_set_start_child, "gtk_paned_set_start_child");
  link(gtk_paned_set_wide_handle, "gtk_paned_set_wide_handle");

  // PaperSize
  link(gtk_paper_size_get_type, "gtk_paper_size_get_type");
  link(gtk_paper_size_new, "gtk_paper_size_new");
  link(gtk_paper_size_new_custom, "gtk_paper_size_new_custom");
  link(gtk_paper_size_new_from_gvariant, "gtk_paper_size_new_from_gvariant");
  link(gtk_paper_size_new_from_ipp, "gtk_paper_size_new_from_ipp");
  link(gtk_paper_size_new_from_key_file, "gtk_paper_size_new_from_key_file");
  link(gtk_paper_size_new_from_ppd, "gtk_paper_size_new_from_ppd");
  link(gtk_paper_size_copy, "gtk_paper_size_copy");
  link(gtk_paper_size_free, "gtk_paper_size_free");
  link(gtk_paper_size_get_default_bottom_margin, "gtk_paper_size_get_default_bottom_margin");
  link(gtk_paper_size_get_default_left_margin, "gtk_paper_size_get_default_left_margin");
  link(gtk_paper_size_get_default_right_margin, "gtk_paper_size_get_default_right_margin");
  link(gtk_paper_size_get_default_top_margin, "gtk_paper_size_get_default_top_margin");
  link(gtk_paper_size_get_display_name, "gtk_paper_size_get_display_name");
  link(gtk_paper_size_get_height, "gtk_paper_size_get_height");
  link(gtk_paper_size_get_name, "gtk_paper_size_get_name");
  link(gtk_paper_size_get_ppd_name, "gtk_paper_size_get_ppd_name");
  link(gtk_paper_size_get_width, "gtk_paper_size_get_width");
  link(gtk_paper_size_is_custom, "gtk_paper_size_is_custom");
  link(gtk_paper_size_is_equal, "gtk_paper_size_is_equal");
  link(gtk_paper_size_is_ipp, "gtk_paper_size_is_ipp");
  link(gtk_paper_size_set_size, "gtk_paper_size_set_size");
  link(gtk_paper_size_to_gvariant, "gtk_paper_size_to_gvariant");
  link(gtk_paper_size_to_key_file, "gtk_paper_size_to_key_file");
  link(gtk_paper_size_get_default, "gtk_paper_size_get_default");
  link(gtk_paper_size_get_paper_sizes, "gtk_paper_size_get_paper_sizes");

  // ParamSpecExpression
  link(gtk_param_expression_get_type, "gtk_param_expression_get_type");

  // PasswordEntry
  link(gtk_password_entry_get_type, "gtk_password_entry_get_type");
  link(gtk_password_entry_new, "gtk_password_entry_new");
  link(gtk_password_entry_get_extra_menu, "gtk_password_entry_get_extra_menu");
  link(gtk_password_entry_get_show_peek_icon, "gtk_password_entry_get_show_peek_icon");
  link(gtk_password_entry_set_extra_menu, "gtk_password_entry_set_extra_menu");
  link(gtk_password_entry_set_show_peek_icon, "gtk_password_entry_set_show_peek_icon");

  // PasswordEntryBuffer
  link(gtk_password_entry_buffer_get_type, "gtk_password_entry_buffer_get_type");
  link(gtk_password_entry_buffer_new, "gtk_password_entry_buffer_new");

  // Picture
  link(gtk_picture_get_type, "gtk_picture_get_type");
  link(gtk_picture_new, "gtk_picture_new");
  link(gtk_picture_new_for_file, "gtk_picture_new_for_file");
  link(gtk_picture_new_for_filename, "gtk_picture_new_for_filename");
  link(gtk_picture_new_for_paintable, "gtk_picture_new_for_paintable");
  link(gtk_picture_new_for_pixbuf, "gtk_picture_new_for_pixbuf");
  link(gtk_picture_new_for_resource, "gtk_picture_new_for_resource");
  link(gtk_picture_get_alternative_text, "gtk_picture_get_alternative_text");
  link(gtk_picture_get_can_shrink, "gtk_picture_get_can_shrink");
  link(gtk_picture_get_content_fit, "gtk_picture_get_content_fit");
  link(gtk_picture_get_file, "gtk_picture_get_file");
  link(gtk_picture_get_keep_aspect_ratio, "gtk_picture_get_keep_aspect_ratio");
  link(gtk_picture_get_paintable, "gtk_picture_get_paintable");
  link(gtk_picture_set_alternative_text, "gtk_picture_set_alternative_text");
  link(gtk_picture_set_can_shrink, "gtk_picture_set_can_shrink");
  link(gtk_picture_set_content_fit, "gtk_picture_set_content_fit");
  link(gtk_picture_set_file, "gtk_picture_set_file");
  link(gtk_picture_set_filename, "gtk_picture_set_filename");
  link(gtk_picture_set_keep_aspect_ratio, "gtk_picture_set_keep_aspect_ratio");
  link(gtk_picture_set_paintable, "gtk_picture_set_paintable");
  link(gtk_picture_set_pixbuf, "gtk_picture_set_pixbuf");
  link(gtk_picture_set_resource, "gtk_picture_set_resource");

  // Popover
  link(gtk_popover_get_type, "gtk_popover_get_type");
  link(gtk_popover_new, "gtk_popover_new");
  link(gtk_popover_get_autohide, "gtk_popover_get_autohide");
  link(gtk_popover_get_cascade_popdown, "gtk_popover_get_cascade_popdown");
  link(gtk_popover_get_child, "gtk_popover_get_child");
  link(gtk_popover_get_has_arrow, "gtk_popover_get_has_arrow");
  link(gtk_popover_get_mnemonics_visible, "gtk_popover_get_mnemonics_visible");
  link(gtk_popover_get_offset, "gtk_popover_get_offset");
  link(gtk_popover_get_pointing_to, "gtk_popover_get_pointing_to");
  link(gtk_popover_get_position, "gtk_popover_get_position");
  link(gtk_popover_popdown, "gtk_popover_popdown");
  link(gtk_popover_popup, "gtk_popover_popup");
  link(gtk_popover_present, "gtk_popover_present");
  link(gtk_popover_set_autohide, "gtk_popover_set_autohide");
  link(gtk_popover_set_cascade_popdown, "gtk_popover_set_cascade_popdown");
  link(gtk_popover_set_child, "gtk_popover_set_child");
  link(gtk_popover_set_default_widget, "gtk_popover_set_default_widget");
  link(gtk_popover_set_has_arrow, "gtk_popover_set_has_arrow");
  link(gtk_popover_set_mnemonics_visible, "gtk_popover_set_mnemonics_visible");
  link(gtk_popover_set_offset, "gtk_popover_set_offset");
  link(gtk_popover_set_pointing_to, "gtk_popover_set_pointing_to");
  link(gtk_popover_set_position, "gtk_popover_set_position");

  // PopoverMenu
  link(gtk_popover_menu_get_type, "gtk_popover_menu_get_type");
  link(gtk_popover_menu_new_from_model, "gtk_popover_menu_new_from_model");
  link(gtk_popover_menu_new_from_model_full, "gtk_popover_menu_new_from_model_full");
  link(gtk_popover_menu_add_child, "gtk_popover_menu_add_child");
  link(gtk_popover_menu_get_flags, "gtk_popover_menu_get_flags");
  link(gtk_popover_menu_get_menu_model, "gtk_popover_menu_get_menu_model");
  link(gtk_popover_menu_remove_child, "gtk_popover_menu_remove_child");
  link(gtk_popover_menu_set_flags, "gtk_popover_menu_set_flags");
  link(gtk_popover_menu_set_menu_model, "gtk_popover_menu_set_menu_model");

  // PopoverMenuBar
  link(gtk_popover_menu_bar_get_type, "gtk_popover_menu_bar_get_type");
  link(gtk_popover_menu_bar_new_from_model, "gtk_popover_menu_bar_new_from_model");
  link(gtk_popover_menu_bar_add_child, "gtk_popover_menu_bar_add_child");
  link(gtk_popover_menu_bar_get_menu_model, "gtk_popover_menu_bar_get_menu_model");
  link(gtk_popover_menu_bar_remove_child, "gtk_popover_menu_bar_remove_child");
  link(gtk_popover_menu_bar_set_menu_model, "gtk_popover_menu_bar_set_menu_model");

  // PrintContext
  link(gtk_print_context_get_type, "gtk_print_context_get_type");
  link(gtk_print_context_create_pango_context, "gtk_print_context_create_pango_context");
  link(gtk_print_context_create_pango_layout, "gtk_print_context_create_pango_layout");
  link(gtk_print_context_get_cairo_context, "gtk_print_context_get_cairo_context");
  link(gtk_print_context_get_dpi_x, "gtk_print_context_get_dpi_x");
  link(gtk_print_context_get_dpi_y, "gtk_print_context_get_dpi_y");
  link(gtk_print_context_get_hard_margins, "gtk_print_context_get_hard_margins");
  link(gtk_print_context_get_height, "gtk_print_context_get_height");
  link(gtk_print_context_get_page_setup, "gtk_print_context_get_page_setup");
  link(gtk_print_context_get_pango_fontmap, "gtk_print_context_get_pango_fontmap");
  link(gtk_print_context_get_width, "gtk_print_context_get_width");
  link(gtk_print_context_set_cairo_context, "gtk_print_context_set_cairo_context");

  // PrintDialog
  link(gtk_print_dialog_get_type, "gtk_print_dialog_get_type");
  link(gtk_print_dialog_new, "gtk_print_dialog_new");
  link(gtk_print_dialog_get_accept_label, "gtk_print_dialog_get_accept_label");
  link(gtk_print_dialog_get_modal, "gtk_print_dialog_get_modal");
  link(gtk_print_dialog_get_page_setup, "gtk_print_dialog_get_page_setup");
  link(gtk_print_dialog_get_print_settings, "gtk_print_dialog_get_print_settings");
  link(gtk_print_dialog_get_title, "gtk_print_dialog_get_title");
  link(gtk_print_dialog_print, "gtk_print_dialog_print");
  link(gtk_print_dialog_print_file, "gtk_print_dialog_print_file");
  link(gtk_print_dialog_print_file_finish, "gtk_print_dialog_print_file_finish");
  link(gtk_print_dialog_print_finish, "gtk_print_dialog_print_finish");
  link(gtk_print_dialog_set_accept_label, "gtk_print_dialog_set_accept_label");
  link(gtk_print_dialog_set_modal, "gtk_print_dialog_set_modal");
  link(gtk_print_dialog_set_page_setup, "gtk_print_dialog_set_page_setup");
  link(gtk_print_dialog_set_print_settings, "gtk_print_dialog_set_print_settings");
  link(gtk_print_dialog_set_title, "gtk_print_dialog_set_title");
  link(gtk_print_dialog_setup, "gtk_print_dialog_setup");
  link(gtk_print_dialog_setup_finish, "gtk_print_dialog_setup_finish");

  // PrintJob
  link(gtk_print_job_get_type, "gtk_print_job_get_type");
  link(gtk_print_job_new, "gtk_print_job_new");
  link(gtk_print_job_get_collate, "gtk_print_job_get_collate");
  link(gtk_print_job_get_n_up, "gtk_print_job_get_n_up");
  link(gtk_print_job_get_n_up_layout, "gtk_print_job_get_n_up_layout");
  link(gtk_print_job_get_num_copies, "gtk_print_job_get_num_copies");
  link(gtk_print_job_get_page_ranges, "gtk_print_job_get_page_ranges");
  link(gtk_print_job_get_page_set, "gtk_print_job_get_page_set");
  link(gtk_print_job_get_pages, "gtk_print_job_get_pages");
  link(gtk_print_job_get_printer, "gtk_print_job_get_printer");
  link(gtk_print_job_get_reverse, "gtk_print_job_get_reverse");
  link(gtk_print_job_get_rotate, "gtk_print_job_get_rotate");
  link(gtk_print_job_get_scale, "gtk_print_job_get_scale");
  link(gtk_print_job_get_settings, "gtk_print_job_get_settings");
  link(gtk_print_job_get_status, "gtk_print_job_get_status");
  link(gtk_print_job_get_surface, "gtk_print_job_get_surface");
  link(gtk_print_job_get_title, "gtk_print_job_get_title");
  link(gtk_print_job_get_track_print_status, "gtk_print_job_get_track_print_status");
  link(gtk_print_job_send, "gtk_print_job_send");
  link(gtk_print_job_set_collate, "gtk_print_job_set_collate");
  link(gtk_print_job_set_n_up, "gtk_print_job_set_n_up");
  link(gtk_print_job_set_n_up_layout, "gtk_print_job_set_n_up_layout");
  link(gtk_print_job_set_num_copies, "gtk_print_job_set_num_copies");
  link(gtk_print_job_set_page_ranges, "gtk_print_job_set_page_ranges");
  link(gtk_print_job_set_page_set, "gtk_print_job_set_page_set");
  link(gtk_print_job_set_pages, "gtk_print_job_set_pages");
  link(gtk_print_job_set_reverse, "gtk_print_job_set_reverse");
  link(gtk_print_job_set_rotate, "gtk_print_job_set_rotate");
  link(gtk_print_job_set_scale, "gtk_print_job_set_scale");
  link(gtk_print_job_set_source_fd, "gtk_print_job_set_source_fd");
  link(gtk_print_job_set_source_file, "gtk_print_job_set_source_file");
  link(gtk_print_job_set_track_print_status, "gtk_print_job_set_track_print_status");

  // PrintOperation
  link(gtk_print_operation_get_type, "gtk_print_operation_get_type");
  link(gtk_print_operation_new, "gtk_print_operation_new");
  link(gtk_print_operation_cancel, "gtk_print_operation_cancel");
  link(gtk_print_operation_draw_page_finish, "gtk_print_operation_draw_page_finish");
  link(gtk_print_operation_get_default_page_setup, "gtk_print_operation_get_default_page_setup");
  link(gtk_print_operation_get_embed_page_setup, "gtk_print_operation_get_embed_page_setup");
  link(gtk_print_operation_get_error, "gtk_print_operation_get_error");
  link(gtk_print_operation_get_has_selection, "gtk_print_operation_get_has_selection");
  link(gtk_print_operation_get_n_pages_to_print, "gtk_print_operation_get_n_pages_to_print");
  link(gtk_print_operation_get_print_settings, "gtk_print_operation_get_print_settings");
  link(gtk_print_operation_get_status, "gtk_print_operation_get_status");
  link(gtk_print_operation_get_status_string, "gtk_print_operation_get_status_string");
  link(gtk_print_operation_get_support_selection, "gtk_print_operation_get_support_selection");
  link(gtk_print_operation_is_finished, "gtk_print_operation_is_finished");
  link(gtk_print_operation_run, "gtk_print_operation_run");
  link(gtk_print_operation_set_allow_async, "gtk_print_operation_set_allow_async");
  link(gtk_print_operation_set_current_page, "gtk_print_operation_set_current_page");
  link(gtk_print_operation_set_custom_tab_label, "gtk_print_operation_set_custom_tab_label");
  link(gtk_print_operation_set_default_page_setup, "gtk_print_operation_set_default_page_setup");
  link(gtk_print_operation_set_defer_drawing, "gtk_print_operation_set_defer_drawing");
  link(gtk_print_operation_set_embed_page_setup, "gtk_print_operation_set_embed_page_setup");
  link(gtk_print_operation_set_export_filename, "gtk_print_operation_set_export_filename");
  link(gtk_print_operation_set_has_selection, "gtk_print_operation_set_has_selection");
  link(gtk_print_operation_set_job_name, "gtk_print_operation_set_job_name");
  link(gtk_print_operation_set_n_pages, "gtk_print_operation_set_n_pages");
  link(gtk_print_operation_set_print_settings, "gtk_print_operation_set_print_settings");
  link(gtk_print_operation_set_show_progress, "gtk_print_operation_set_show_progress");
  link(gtk_print_operation_set_support_selection, "gtk_print_operation_set_support_selection");
  link(gtk_print_operation_set_track_print_status, "gtk_print_operation_set_track_print_status");
  link(gtk_print_operation_set_unit, "gtk_print_operation_set_unit");
  link(gtk_print_operation_set_use_full_page, "gtk_print_operation_set_use_full_page");

  // PrintOperationPreview
  link(gtk_print_operation_preview_get_type, "gtk_print_operation_preview_get_type");
  link(gtk_print_operation_preview_end_preview, "gtk_print_operation_preview_end_preview");
  link(gtk_print_operation_preview_is_selected, "gtk_print_operation_preview_is_selected");
  link(gtk_print_operation_preview_render_page, "gtk_print_operation_preview_render_page");

  // PrintSettings
  link(gtk_print_settings_get_type, "gtk_print_settings_get_type");
  link(gtk_print_settings_new, "gtk_print_settings_new");
  link(gtk_print_settings_new_from_file, "gtk_print_settings_new_from_file");
  link(gtk_print_settings_new_from_gvariant, "gtk_print_settings_new_from_gvariant");
  link(gtk_print_settings_new_from_key_file, "gtk_print_settings_new_from_key_file");
  link(gtk_print_settings_copy, "gtk_print_settings_copy");
  link(gtk_print_settings_foreach, "gtk_print_settings_foreach");
  link(gtk_print_settings_get, "gtk_print_settings_get");
  link(gtk_print_settings_get_bool, "gtk_print_settings_get_bool");
  link(gtk_print_settings_get_collate, "gtk_print_settings_get_collate");
  link(gtk_print_settings_get_default_source, "gtk_print_settings_get_default_source");
  link(gtk_print_settings_get_dither, "gtk_print_settings_get_dither");
  link(gtk_print_settings_get_double, "gtk_print_settings_get_double");
  link(gtk_print_settings_get_double_with_default, "gtk_print_settings_get_double_with_default");
  link(gtk_print_settings_get_duplex, "gtk_print_settings_get_duplex");
  link(gtk_print_settings_get_finishings, "gtk_print_settings_get_finishings");
  link(gtk_print_settings_get_int, "gtk_print_settings_get_int");
  link(gtk_print_settings_get_int_with_default, "gtk_print_settings_get_int_with_default");
  link(gtk_print_settings_get_length, "gtk_print_settings_get_length");
  link(gtk_print_settings_get_media_type, "gtk_print_settings_get_media_type");
  link(gtk_print_settings_get_n_copies, "gtk_print_settings_get_n_copies");
  link(gtk_print_settings_get_number_up, "gtk_print_settings_get_number_up");
  link(gtk_print_settings_get_number_up_layout, "gtk_print_settings_get_number_up_layout");
  link(gtk_print_settings_get_orientation, "gtk_print_settings_get_orientation");
  link(gtk_print_settings_get_output_bin, "gtk_print_settings_get_output_bin");
  link(gtk_print_settings_get_page_ranges, "gtk_print_settings_get_page_ranges");
  link(gtk_print_settings_get_page_set, "gtk_print_settings_get_page_set");
  link(gtk_print_settings_get_paper_height, "gtk_print_settings_get_paper_height");
  link(gtk_print_settings_get_paper_size, "gtk_print_settings_get_paper_size");
  link(gtk_print_settings_get_paper_width, "gtk_print_settings_get_paper_width");
  link(gtk_print_settings_get_print_pages, "gtk_print_settings_get_print_pages");
  link(gtk_print_settings_get_printer, "gtk_print_settings_get_printer");
  link(gtk_print_settings_get_printer_lpi, "gtk_print_settings_get_printer_lpi");
  link(gtk_print_settings_get_quality, "gtk_print_settings_get_quality");
  link(gtk_print_settings_get_resolution, "gtk_print_settings_get_resolution");
  link(gtk_print_settings_get_resolution_x, "gtk_print_settings_get_resolution_x");
  link(gtk_print_settings_get_resolution_y, "gtk_print_settings_get_resolution_y");
  link(gtk_print_settings_get_reverse, "gtk_print_settings_get_reverse");
  link(gtk_print_settings_get_scale, "gtk_print_settings_get_scale");
  link(gtk_print_settings_get_use_color, "gtk_print_settings_get_use_color");
  link(gtk_print_settings_has_key, "gtk_print_settings_has_key");
  link(gtk_print_settings_load_file, "gtk_print_settings_load_file");
  link(gtk_print_settings_load_key_file, "gtk_print_settings_load_key_file");
  link(gtk_print_settings_set, "gtk_print_settings_set");
  link(gtk_print_settings_set_bool, "gtk_print_settings_set_bool");
  link(gtk_print_settings_set_collate, "gtk_print_settings_set_collate");
  link(gtk_print_settings_set_default_source, "gtk_print_settings_set_default_source");
  link(gtk_print_settings_set_dither, "gtk_print_settings_set_dither");
  link(gtk_print_settings_set_double, "gtk_print_settings_set_double");
  link(gtk_print_settings_set_duplex, "gtk_print_settings_set_duplex");
  link(gtk_print_settings_set_finishings, "gtk_print_settings_set_finishings");
  link(gtk_print_settings_set_int, "gtk_print_settings_set_int");
  link(gtk_print_settings_set_length, "gtk_print_settings_set_length");
  link(gtk_print_settings_set_media_type, "gtk_print_settings_set_media_type");
  link(gtk_print_settings_set_n_copies, "gtk_print_settings_set_n_copies");
  link(gtk_print_settings_set_number_up, "gtk_print_settings_set_number_up");
  link(gtk_print_settings_set_number_up_layout, "gtk_print_settings_set_number_up_layout");
  link(gtk_print_settings_set_orientation, "gtk_print_settings_set_orientation");
  link(gtk_print_settings_set_output_bin, "gtk_print_settings_set_output_bin");
  link(gtk_print_settings_set_page_ranges, "gtk_print_settings_set_page_ranges");
  link(gtk_print_settings_set_page_set, "gtk_print_settings_set_page_set");
  link(gtk_print_settings_set_paper_height, "gtk_print_settings_set_paper_height");
  link(gtk_print_settings_set_paper_size, "gtk_print_settings_set_paper_size");
  link(gtk_print_settings_set_paper_width, "gtk_print_settings_set_paper_width");
  link(gtk_print_settings_set_print_pages, "gtk_print_settings_set_print_pages");
  link(gtk_print_settings_set_printer, "gtk_print_settings_set_printer");
  link(gtk_print_settings_set_printer_lpi, "gtk_print_settings_set_printer_lpi");
  link(gtk_print_settings_set_quality, "gtk_print_settings_set_quality");
  link(gtk_print_settings_set_resolution, "gtk_print_settings_set_resolution");
  link(gtk_print_settings_set_resolution_xy, "gtk_print_settings_set_resolution_xy");
  link(gtk_print_settings_set_reverse, "gtk_print_settings_set_reverse");
  link(gtk_print_settings_set_scale, "gtk_print_settings_set_scale");
  link(gtk_print_settings_set_use_color, "gtk_print_settings_set_use_color");
  link(gtk_print_settings_to_file, "gtk_print_settings_to_file");
  link(gtk_print_settings_to_gvariant, "gtk_print_settings_to_gvariant");
  link(gtk_print_settings_to_key_file, "gtk_print_settings_to_key_file");
  link(gtk_print_settings_unset, "gtk_print_settings_unset");

  // PrintSetup
  link(gtk_print_setup_get_type, "gtk_print_setup_get_type");
  link(gtk_print_setup_get_page_setup, "gtk_print_setup_get_page_setup");
  link(gtk_print_setup_get_print_settings, "gtk_print_setup_get_print_settings");
  link(gtk_print_setup_ref, "gtk_print_setup_ref");
  link(gtk_print_setup_unref, "gtk_print_setup_unref");

  // PrintUnixDialog
  link(gtk_print_unix_dialog_get_type, "gtk_print_unix_dialog_get_type");
  link(gtk_print_unix_dialog_new, "gtk_print_unix_dialog_new");
  link(gtk_print_unix_dialog_add_custom_tab, "gtk_print_unix_dialog_add_custom_tab");
  link(gtk_print_unix_dialog_get_current_page, "gtk_print_unix_dialog_get_current_page");
  link(gtk_print_unix_dialog_get_embed_page_setup, "gtk_print_unix_dialog_get_embed_page_setup");
  link(gtk_print_unix_dialog_get_has_selection, "gtk_print_unix_dialog_get_has_selection");
  link(gtk_print_unix_dialog_get_manual_capabilities, "gtk_print_unix_dialog_get_manual_capabilities");
  link(gtk_print_unix_dialog_get_page_setup, "gtk_print_unix_dialog_get_page_setup");
  link(gtk_print_unix_dialog_get_page_setup_set, "gtk_print_unix_dialog_get_page_setup_set");
  link(gtk_print_unix_dialog_get_selected_printer, "gtk_print_unix_dialog_get_selected_printer");
  link(gtk_print_unix_dialog_get_settings, "gtk_print_unix_dialog_get_settings");
  link(gtk_print_unix_dialog_get_support_selection, "gtk_print_unix_dialog_get_support_selection");
  link(gtk_print_unix_dialog_set_current_page, "gtk_print_unix_dialog_set_current_page");
  link(gtk_print_unix_dialog_set_embed_page_setup, "gtk_print_unix_dialog_set_embed_page_setup");
  link(gtk_print_unix_dialog_set_has_selection, "gtk_print_unix_dialog_set_has_selection");
  link(gtk_print_unix_dialog_set_manual_capabilities, "gtk_print_unix_dialog_set_manual_capabilities");
  link(gtk_print_unix_dialog_set_page_setup, "gtk_print_unix_dialog_set_page_setup");
  link(gtk_print_unix_dialog_set_settings, "gtk_print_unix_dialog_set_settings");
  link(gtk_print_unix_dialog_set_support_selection, "gtk_print_unix_dialog_set_support_selection");

  // Printer
  link(gtk_printer_get_type, "gtk_printer_get_type");
  link(gtk_printer_new, "gtk_printer_new");
  link(gtk_printer_accepts_pdf, "gtk_printer_accepts_pdf");
  link(gtk_printer_accepts_ps, "gtk_printer_accepts_ps");
  link(gtk_printer_compare, "gtk_printer_compare");
  link(gtk_printer_get_backend, "gtk_printer_get_backend");
  link(gtk_printer_get_capabilities, "gtk_printer_get_capabilities");
  link(gtk_printer_get_default_page_size, "gtk_printer_get_default_page_size");
  link(gtk_printer_get_description, "gtk_printer_get_description");
  link(gtk_printer_get_hard_margins, "gtk_printer_get_hard_margins");
  link(gtk_printer_get_hard_margins_for_paper_size, "gtk_printer_get_hard_margins_for_paper_size");
  link(gtk_printer_get_icon_name, "gtk_printer_get_icon_name");
  link(gtk_printer_get_job_count, "gtk_printer_get_job_count");
  link(gtk_printer_get_location, "gtk_printer_get_location");
  link(gtk_printer_get_name, "gtk_printer_get_name");
  link(gtk_printer_get_state_message, "gtk_printer_get_state_message");
  link(gtk_printer_has_details, "gtk_printer_has_details");
  link(gtk_printer_is_accepting_jobs, "gtk_printer_is_accepting_jobs");
  link(gtk_printer_is_active, "gtk_printer_is_active");
  link(gtk_printer_is_default, "gtk_printer_is_default");
  link(gtk_printer_is_paused, "gtk_printer_is_paused");
  link(gtk_printer_is_virtual, "gtk_printer_is_virtual");
  link(gtk_printer_list_papers, "gtk_printer_list_papers");
  link(gtk_printer_request_details, "gtk_printer_request_details");

  // ProgressBar
  link(gtk_progress_bar_get_type, "gtk_progress_bar_get_type");
  link(gtk_progress_bar_new, "gtk_progress_bar_new");
  link(gtk_progress_bar_get_ellipsize, "gtk_progress_bar_get_ellipsize");
  link(gtk_progress_bar_get_fraction, "gtk_progress_bar_get_fraction");
  link(gtk_progress_bar_get_inverted, "gtk_progress_bar_get_inverted");
  link(gtk_progress_bar_get_pulse_step, "gtk_progress_bar_get_pulse_step");
  link(gtk_progress_bar_get_show_text, "gtk_progress_bar_get_show_text");
  link(gtk_progress_bar_get_text, "gtk_progress_bar_get_text");
  link(gtk_progress_bar_pulse, "gtk_progress_bar_pulse");
  link(gtk_progress_bar_set_ellipsize, "gtk_progress_bar_set_ellipsize");
  link(gtk_progress_bar_set_fraction, "gtk_progress_bar_set_fraction");
  link(gtk_progress_bar_set_inverted, "gtk_progress_bar_set_inverted");
  link(gtk_progress_bar_set_pulse_step, "gtk_progress_bar_set_pulse_step");
  link(gtk_progress_bar_set_show_text, "gtk_progress_bar_set_show_text");
  link(gtk_progress_bar_set_text, "gtk_progress_bar_set_text");

  // PropertyExpression
  link(gtk_property_expression_get_type, "gtk_property_expression_get_type");
  link(gtk_property_expression_new, "gtk_property_expression_new");
  link(gtk_property_expression_new_for_pspec, "gtk_property_expression_new_for_pspec");
  link(gtk_property_expression_get_expression, "gtk_property_expression_get_expression");
  link(gtk_property_expression_get_pspec, "gtk_property_expression_get_pspec");

  // Range
  link(gtk_range_get_type, "gtk_range_get_type");
  link(gtk_range_get_adjustment, "gtk_range_get_adjustment");
  link(gtk_range_get_fill_level, "gtk_range_get_fill_level");
  link(gtk_range_get_flippable, "gtk_range_get_flippable");
  link(gtk_range_get_inverted, "gtk_range_get_inverted");
  link(gtk_range_get_range_rect, "gtk_range_get_range_rect");
  link(gtk_range_get_restrict_to_fill_level, "gtk_range_get_restrict_to_fill_level");
  link(gtk_range_get_round_digits, "gtk_range_get_round_digits");
  link(gtk_range_get_show_fill_level, "gtk_range_get_show_fill_level");
  link(gtk_range_get_slider_range, "gtk_range_get_slider_range");
  link(gtk_range_get_slider_size_fixed, "gtk_range_get_slider_size_fixed");
  link(gtk_range_get_value, "gtk_range_get_value");
  link(gtk_range_set_adjustment, "gtk_range_set_adjustment");
  link(gtk_range_set_fill_level, "gtk_range_set_fill_level");
  link(gtk_range_set_flippable, "gtk_range_set_flippable");
  link(gtk_range_set_increments, "gtk_range_set_increments");
  link(gtk_range_set_inverted, "gtk_range_set_inverted");
  link(gtk_range_set_range, "gtk_range_set_range");
  link(gtk_range_set_restrict_to_fill_level, "gtk_range_set_restrict_to_fill_level");
  link(gtk_range_set_round_digits, "gtk_range_set_round_digits");
  link(gtk_range_set_show_fill_level, "gtk_range_set_show_fill_level");
  link(gtk_range_set_slider_size_fixed, "gtk_range_set_slider_size_fixed");
  link(gtk_range_set_value, "gtk_range_set_value");

  // RecentInfo
  link(gtk_recent_info_get_type, "gtk_recent_info_get_type");
  link(gtk_recent_info_create_app_info, "gtk_recent_info_create_app_info");
  link(gtk_recent_info_exists, "gtk_recent_info_exists");
  link(gtk_recent_info_get_added, "gtk_recent_info_get_added");
  link(gtk_recent_info_get_age, "gtk_recent_info_get_age");
  link(gtk_recent_info_get_application_info, "gtk_recent_info_get_application_info");
  link(gtk_recent_info_get_applications, "gtk_recent_info_get_applications");
  link(gtk_recent_info_get_description, "gtk_recent_info_get_description");
  link(gtk_recent_info_get_display_name, "gtk_recent_info_get_display_name");
  link(gtk_recent_info_get_gicon, "gtk_recent_info_get_gicon");
  link(gtk_recent_info_get_groups, "gtk_recent_info_get_groups");
  link(gtk_recent_info_get_mime_type, "gtk_recent_info_get_mime_type");
  link(gtk_recent_info_get_modified, "gtk_recent_info_get_modified");
  link(gtk_recent_info_get_private_hint, "gtk_recent_info_get_private_hint");
  link(gtk_recent_info_get_short_name, "gtk_recent_info_get_short_name");
  link(gtk_recent_info_get_uri, "gtk_recent_info_get_uri");
  link(gtk_recent_info_get_uri_display, "gtk_recent_info_get_uri_display");
  link(gtk_recent_info_get_visited, "gtk_recent_info_get_visited");
  link(gtk_recent_info_has_application, "gtk_recent_info_has_application");
  link(gtk_recent_info_has_group, "gtk_recent_info_has_group");
  link(gtk_recent_info_is_local, "gtk_recent_info_is_local");
  link(gtk_recent_info_last_application, "gtk_recent_info_last_application");
  link(gtk_recent_info_match, "gtk_recent_info_match");
  link(gtk_recent_info_ref, "gtk_recent_info_ref");
  link(gtk_recent_info_unref, "gtk_recent_info_unref");

  // RecentManager
  link(gtk_recent_manager_get_type, "gtk_recent_manager_get_type");
  link(gtk_recent_manager_new, "gtk_recent_manager_new");
  link(gtk_recent_manager_get_default, "gtk_recent_manager_get_default");
  link(gtk_recent_manager_add_full, "gtk_recent_manager_add_full");
  link(gtk_recent_manager_add_item, "gtk_recent_manager_add_item");
  link(gtk_recent_manager_get_items, "gtk_recent_manager_get_items");
  link(gtk_recent_manager_has_item, "gtk_recent_manager_has_item");
  link(gtk_recent_manager_lookup_item, "gtk_recent_manager_lookup_item");
  link(gtk_recent_manager_move_item, "gtk_recent_manager_move_item");
  link(gtk_recent_manager_purge_items, "gtk_recent_manager_purge_items");
  link(gtk_recent_manager_remove_item, "gtk_recent_manager_remove_item");

  // Requisition
  link(gtk_requisition_get_type, "gtk_requisition_get_type");
  link(gtk_requisition_new, "gtk_requisition_new");
  link(gtk_requisition_copy, "gtk_requisition_copy");
  link(gtk_requisition_free, "gtk_requisition_free");

  // Revealer
  link(gtk_revealer_get_type, "gtk_revealer_get_type");
  link(gtk_revealer_new, "gtk_revealer_new");
  link(gtk_revealer_get_child, "gtk_revealer_get_child");
  link(gtk_revealer_get_child_revealed, "gtk_revealer_get_child_revealed");
  link(gtk_revealer_get_reveal_child, "gtk_revealer_get_reveal_child");
  link(gtk_revealer_get_transition_duration, "gtk_revealer_get_transition_duration");
  link(gtk_revealer_get_transition_type, "gtk_revealer_get_transition_type");
  link(gtk_revealer_set_child, "gtk_revealer_set_child");
  link(gtk_revealer_set_reveal_child, "gtk_revealer_set_reveal_child");
  link(gtk_revealer_set_transition_duration, "gtk_revealer_set_transition_duration");
  link(gtk_revealer_set_transition_type, "gtk_revealer_set_transition_type");

  // Root
  link(gtk_root_get_type, "gtk_root_get_type");
  link(gtk_root_get_display, "gtk_root_get_display");
  link(gtk_root_get_focus, "gtk_root_get_focus");
  link(gtk_root_set_focus, "gtk_root_set_focus");

  // Scale
  link(gtk_scale_get_type, "gtk_scale_get_type");
  link(gtk_scale_new, "gtk_scale_new");
  link(gtk_scale_new_with_range, "gtk_scale_new_with_range");
  link(gtk_scale_add_mark, "gtk_scale_add_mark");
  link(gtk_scale_clear_marks, "gtk_scale_clear_marks");
  link(gtk_scale_get_digits, "gtk_scale_get_digits");
  link(gtk_scale_get_draw_value, "gtk_scale_get_draw_value");
  link(gtk_scale_get_has_origin, "gtk_scale_get_has_origin");
  link(gtk_scale_get_layout, "gtk_scale_get_layout");
  link(gtk_scale_get_layout_offsets, "gtk_scale_get_layout_offsets");
  link(gtk_scale_get_value_pos, "gtk_scale_get_value_pos");
  link(gtk_scale_set_digits, "gtk_scale_set_digits");
  link(gtk_scale_set_draw_value, "gtk_scale_set_draw_value");
  link(gtk_scale_set_format_value_func, "gtk_scale_set_format_value_func");
  link(gtk_scale_set_has_origin, "gtk_scale_set_has_origin");
  link(gtk_scale_set_value_pos, "gtk_scale_set_value_pos");

  // ScaleButton
  link(gtk_scale_button_get_type, "gtk_scale_button_get_type");
  link(gtk_scale_button_new, "gtk_scale_button_new");
  link(gtk_scale_button_get_active, "gtk_scale_button_get_active");
  link(gtk_scale_button_get_adjustment, "gtk_scale_button_get_adjustment");
  link(gtk_scale_button_get_has_frame, "gtk_scale_button_get_has_frame");
  link(gtk_scale_button_get_minus_button, "gtk_scale_button_get_minus_button");
  link(gtk_scale_button_get_plus_button, "gtk_scale_button_get_plus_button");
  link(gtk_scale_button_get_popup, "gtk_scale_button_get_popup");
  link(gtk_scale_button_get_value, "gtk_scale_button_get_value");
  link(gtk_scale_button_set_adjustment, "gtk_scale_button_set_adjustment");
  link(gtk_scale_button_set_has_frame, "gtk_scale_button_set_has_frame");
  link(gtk_scale_button_set_icons, "gtk_scale_button_set_icons");
  link(gtk_scale_button_set_value, "gtk_scale_button_set_value");

  // ScrollInfo
  link(gtk_scroll_info_get_type, "gtk_scroll_info_get_type");
  link(gtk_scroll_info_new, "gtk_scroll_info_new");
  link(gtk_scroll_info_get_enable_horizontal, "gtk_scroll_info_get_enable_horizontal");
  link(gtk_scroll_info_get_enable_vertical, "gtk_scroll_info_get_enable_vertical");
  link(gtk_scroll_info_ref, "gtk_scroll_info_ref");
  link(gtk_scroll_info_set_enable_horizontal, "gtk_scroll_info_set_enable_horizontal");
  link(gtk_scroll_info_set_enable_vertical, "gtk_scroll_info_set_enable_vertical");
  link(gtk_scroll_info_unref, "gtk_scroll_info_unref");

  // Scrollable
  link(gtk_scrollable_get_type, "gtk_scrollable_get_type");
  link(gtk_scrollable_get_border, "gtk_scrollable_get_border");
  link(gtk_scrollable_get_hadjustment, "gtk_scrollable_get_hadjustment");
  link(gtk_scrollable_get_hscroll_policy, "gtk_scrollable_get_hscroll_policy");
  link(gtk_scrollable_get_vadjustment, "gtk_scrollable_get_vadjustment");
  link(gtk_scrollable_get_vscroll_policy, "gtk_scrollable_get_vscroll_policy");
  link(gtk_scrollable_set_hadjustment, "gtk_scrollable_set_hadjustment");
  link(gtk_scrollable_set_hscroll_policy, "gtk_scrollable_set_hscroll_policy");
  link(gtk_scrollable_set_vadjustment, "gtk_scrollable_set_vadjustment");
  link(gtk_scrollable_set_vscroll_policy, "gtk_scrollable_set_vscroll_policy");

  // Scrollbar
  link(gtk_scrollbar_get_type, "gtk_scrollbar_get_type");
  link(gtk_scrollbar_new, "gtk_scrollbar_new");
  link(gtk_scrollbar_get_adjustment, "gtk_scrollbar_get_adjustment");
  link(gtk_scrollbar_set_adjustment, "gtk_scrollbar_set_adjustment");

  // ScrolledWindow
  link(gtk_scrolled_window_get_type, "gtk_scrolled_window_get_type");
  link(gtk_scrolled_window_new, "gtk_scrolled_window_new");
  link(gtk_scrolled_window_get_child, "gtk_scrolled_window_get_child");
  link(gtk_scrolled_window_get_hadjustment, "gtk_scrolled_window_get_hadjustment");
  link(gtk_scrolled_window_get_has_frame, "gtk_scrolled_window_get_has_frame");
  link(gtk_scrolled_window_get_hscrollbar, "gtk_scrolled_window_get_hscrollbar");
  link(gtk_scrolled_window_get_kinetic_scrolling, "gtk_scrolled_window_get_kinetic_scrolling");
  link(gtk_scrolled_window_get_max_content_height, "gtk_scrolled_window_get_max_content_height");
  link(gtk_scrolled_window_get_max_content_width, "gtk_scrolled_window_get_max_content_width");
  link(gtk_scrolled_window_get_min_content_height, "gtk_scrolled_window_get_min_content_height");
  link(gtk_scrolled_window_get_min_content_width, "gtk_scrolled_window_get_min_content_width");
  link(gtk_scrolled_window_get_overlay_scrolling, "gtk_scrolled_window_get_overlay_scrolling");
  link(gtk_scrolled_window_get_placement, "gtk_scrolled_window_get_placement");
  link(gtk_scrolled_window_get_policy, "gtk_scrolled_window_get_policy");
  link(gtk_scrolled_window_get_propagate_natural_height, "gtk_scrolled_window_get_propagate_natural_height");
  link(gtk_scrolled_window_get_propagate_natural_width, "gtk_scrolled_window_get_propagate_natural_width");
  link(gtk_scrolled_window_get_vadjustment, "gtk_scrolled_window_get_vadjustment");
  link(gtk_scrolled_window_get_vscrollbar, "gtk_scrolled_window_get_vscrollbar");
  link(gtk_scrolled_window_set_child, "gtk_scrolled_window_set_child");
  link(gtk_scrolled_window_set_hadjustment, "gtk_scrolled_window_set_hadjustment");
  link(gtk_scrolled_window_set_has_frame, "gtk_scrolled_window_set_has_frame");
  link(gtk_scrolled_window_set_kinetic_scrolling, "gtk_scrolled_window_set_kinetic_scrolling");
  link(gtk_scrolled_window_set_max_content_height, "gtk_scrolled_window_set_max_content_height");
  link(gtk_scrolled_window_set_max_content_width, "gtk_scrolled_window_set_max_content_width");
  link(gtk_scrolled_window_set_min_content_height, "gtk_scrolled_window_set_min_content_height");
  link(gtk_scrolled_window_set_min_content_width, "gtk_scrolled_window_set_min_content_width");
  link(gtk_scrolled_window_set_overlay_scrolling, "gtk_scrolled_window_set_overlay_scrolling");
  link(gtk_scrolled_window_set_placement, "gtk_scrolled_window_set_placement");
  link(gtk_scrolled_window_set_policy, "gtk_scrolled_window_set_policy");
  link(gtk_scrolled_window_set_propagate_natural_height, "gtk_scrolled_window_set_propagate_natural_height");
  link(gtk_scrolled_window_set_propagate_natural_width, "gtk_scrolled_window_set_propagate_natural_width");
  link(gtk_scrolled_window_set_vadjustment, "gtk_scrolled_window_set_vadjustment");
  link(gtk_scrolled_window_unset_placement, "gtk_scrolled_window_unset_placement");

  // SearchBar
  link(gtk_search_bar_get_type, "gtk_search_bar_get_type");
  link(gtk_search_bar_new, "gtk_search_bar_new");
  link(gtk_search_bar_connect_entry, "gtk_search_bar_connect_entry");
  link(gtk_search_bar_get_child, "gtk_search_bar_get_child");
  link(gtk_search_bar_get_key_capture_widget, "gtk_search_bar_get_key_capture_widget");
  link(gtk_search_bar_get_search_mode, "gtk_search_bar_get_search_mode");
  link(gtk_search_bar_get_show_close_button, "gtk_search_bar_get_show_close_button");
  link(gtk_search_bar_set_child, "gtk_search_bar_set_child");
  link(gtk_search_bar_set_key_capture_widget, "gtk_search_bar_set_key_capture_widget");
  link(gtk_search_bar_set_search_mode, "gtk_search_bar_set_search_mode");
  link(gtk_search_bar_set_show_close_button, "gtk_search_bar_set_show_close_button");

  // SearchEntry
  link(gtk_search_entry_get_type, "gtk_search_entry_get_type");
  link(gtk_search_entry_new, "gtk_search_entry_new");
  link(gtk_search_entry_get_input_hints, "gtk_search_entry_get_input_hints");
  link(gtk_search_entry_get_input_purpose, "gtk_search_entry_get_input_purpose");
  link(gtk_search_entry_get_key_capture_widget, "gtk_search_entry_get_key_capture_widget");
  link(gtk_search_entry_get_placeholder_text, "gtk_search_entry_get_placeholder_text");
  link(gtk_search_entry_get_search_delay, "gtk_search_entry_get_search_delay");
  link(gtk_search_entry_set_input_hints, "gtk_search_entry_set_input_hints");
  link(gtk_search_entry_set_input_purpose, "gtk_search_entry_set_input_purpose");
  link(gtk_search_entry_set_key_capture_widget, "gtk_search_entry_set_key_capture_widget");
  link(gtk_search_entry_set_placeholder_text, "gtk_search_entry_set_placeholder_text");
  link(gtk_search_entry_set_search_delay, "gtk_search_entry_set_search_delay");

  // SectionModel
  link(gtk_section_model_get_type, "gtk_section_model_get_type");
  link(gtk_section_model_get_section, "gtk_section_model_get_section");
  link(gtk_section_model_sections_changed, "gtk_section_model_sections_changed");

  // SelectionFilterModel
  link(gtk_selection_filter_model_get_type, "gtk_selection_filter_model_get_type");
  link(gtk_selection_filter_model_new, "gtk_selection_filter_model_new");
  link(gtk_selection_filter_model_get_model, "gtk_selection_filter_model_get_model");
  link(gtk_selection_filter_model_set_model, "gtk_selection_filter_model_set_model");

  // SelectionModel
  link(gtk_selection_model_get_type, "gtk_selection_model_get_type");
  link(gtk_selection_model_get_selection, "gtk_selection_model_get_selection");
  link(gtk_selection_model_get_selection_in_range, "gtk_selection_model_get_selection_in_range");
  link(gtk_selection_model_is_selected, "gtk_selection_model_is_selected");
  link(gtk_selection_model_select_all, "gtk_selection_model_select_all");
  link(gtk_selection_model_select_item, "gtk_selection_model_select_item");
  link(gtk_selection_model_select_range, "gtk_selection_model_select_range");
  link(gtk_selection_model_selection_changed, "gtk_selection_model_selection_changed");
  link(gtk_selection_model_set_selection, "gtk_selection_model_set_selection");
  link(gtk_selection_model_unselect_all, "gtk_selection_model_unselect_all");
  link(gtk_selection_model_unselect_item, "gtk_selection_model_unselect_item");
  link(gtk_selection_model_unselect_range, "gtk_selection_model_unselect_range");

  // Separator
  link(gtk_separator_get_type, "gtk_separator_get_type");
  link(gtk_separator_new, "gtk_separator_new");

  // Settings
  link(gtk_settings_get_type, "gtk_settings_get_type");
  link(gtk_settings_get_default, "gtk_settings_get_default");
  link(gtk_settings_get_for_display, "gtk_settings_get_for_display");
  link(gtk_settings_reset_property, "gtk_settings_reset_property");

  // Shortcut
  link(gtk_shortcut_get_type, "gtk_shortcut_get_type");
  link(gtk_shortcut_new, "gtk_shortcut_new");
  link(gtk_shortcut_new_with_arguments, "gtk_shortcut_new_with_arguments");
  link(gtk_shortcut_get_action, "gtk_shortcut_get_action");
  link(gtk_shortcut_get_arguments, "gtk_shortcut_get_arguments");
  link(gtk_shortcut_get_trigger, "gtk_shortcut_get_trigger");
  link(gtk_shortcut_set_action, "gtk_shortcut_set_action");
  link(gtk_shortcut_set_arguments, "gtk_shortcut_set_arguments");
  link(gtk_shortcut_set_trigger, "gtk_shortcut_set_trigger");

  // ShortcutAction
  link(gtk_shortcut_action_get_type, "gtk_shortcut_action_get_type");
  link(gtk_shortcut_action_parse_string, "gtk_shortcut_action_parse_string");
  link(gtk_shortcut_action_activate, "gtk_shortcut_action_activate");
  link(gtk_shortcut_action_print, "gtk_shortcut_action_print");
  link(gtk_shortcut_action_to_string, "gtk_shortcut_action_to_string");

  // ShortcutController
  link(gtk_shortcut_controller_get_type, "gtk_shortcut_controller_get_type");
  link(gtk_shortcut_controller_new, "gtk_shortcut_controller_new");
  link(gtk_shortcut_controller_new_for_model, "gtk_shortcut_controller_new_for_model");
  link(gtk_shortcut_controller_add_shortcut, "gtk_shortcut_controller_add_shortcut");
  link(gtk_shortcut_controller_get_mnemonics_modifiers, "gtk_shortcut_controller_get_mnemonics_modifiers");
  link(gtk_shortcut_controller_get_scope, "gtk_shortcut_controller_get_scope");
  link(gtk_shortcut_controller_remove_shortcut, "gtk_shortcut_controller_remove_shortcut");
  link(gtk_shortcut_controller_set_mnemonics_modifiers, "gtk_shortcut_controller_set_mnemonics_modifiers");
  link(gtk_shortcut_controller_set_scope, "gtk_shortcut_controller_set_scope");

  // ShortcutLabel
  link(gtk_shortcut_label_get_type, "gtk_shortcut_label_get_type");
  link(gtk_shortcut_label_new, "gtk_shortcut_label_new");
  link(gtk_shortcut_label_get_accelerator, "gtk_shortcut_label_get_accelerator");
  link(gtk_shortcut_label_get_disabled_text, "gtk_shortcut_label_get_disabled_text");
  link(gtk_shortcut_label_set_accelerator, "gtk_shortcut_label_set_accelerator");
  link(gtk_shortcut_label_set_disabled_text, "gtk_shortcut_label_set_disabled_text");

  // ShortcutManager
  link(gtk_shortcut_manager_get_type, "gtk_shortcut_manager_get_type");

  // ShortcutTrigger
  link(gtk_shortcut_trigger_get_type, "gtk_shortcut_trigger_get_type");
  link(gtk_shortcut_trigger_parse_string, "gtk_shortcut_trigger_parse_string");
  link(gtk_shortcut_trigger_compare, "gtk_shortcut_trigger_compare");
  link(gtk_shortcut_trigger_equal, "gtk_shortcut_trigger_equal");
  link(gtk_shortcut_trigger_hash, "gtk_shortcut_trigger_hash");
  link(gtk_shortcut_trigger_print, "gtk_shortcut_trigger_print");
  link(gtk_shortcut_trigger_print_label, "gtk_shortcut_trigger_print_label");
  link(gtk_shortcut_trigger_to_label, "gtk_shortcut_trigger_to_label");
  link(gtk_shortcut_trigger_to_string, "gtk_shortcut_trigger_to_string");
  link(gtk_shortcut_trigger_trigger, "gtk_shortcut_trigger_trigger");

  // ShortcutsGroup
  link(gtk_shortcuts_group_get_type, "gtk_shortcuts_group_get_type");
  link(gtk_shortcuts_group_add_shortcut, "gtk_shortcuts_group_add_shortcut");

  // ShortcutsSection
  link(gtk_shortcuts_section_get_type, "gtk_shortcuts_section_get_type");
  link(gtk_shortcuts_section_add_group, "gtk_shortcuts_section_add_group");

  // ShortcutsShortcut
  link(gtk_shortcuts_shortcut_get_type, "gtk_shortcuts_shortcut_get_type");

  // ShortcutsWindow
  link(gtk_shortcuts_window_get_type, "gtk_shortcuts_window_get_type");
  link(gtk_shortcuts_window_add_section, "gtk_shortcuts_window_add_section");

  // SignalAction
  link(gtk_signal_action_get_type, "gtk_signal_action_get_type");
  link(gtk_signal_action_new, "gtk_signal_action_new");
  link(gtk_signal_action_get_signal_name, "gtk_signal_action_get_signal_name");

  // SignalListItemFactory
  link(gtk_signal_list_item_factory_get_type, "gtk_signal_list_item_factory_get_type");
  link(gtk_signal_list_item_factory_new, "gtk_signal_list_item_factory_new");

  // SingleSelection
  link(gtk_single_selection_get_type, "gtk_single_selection_get_type");
  link(gtk_single_selection_new, "gtk_single_selection_new");
  link(gtk_single_selection_get_autoselect, "gtk_single_selection_get_autoselect");
  link(gtk_single_selection_get_can_unselect, "gtk_single_selection_get_can_unselect");
  link(gtk_single_selection_get_model, "gtk_single_selection_get_model");
  link(gtk_single_selection_get_selected, "gtk_single_selection_get_selected");
  link(gtk_single_selection_get_selected_item, "gtk_single_selection_get_selected_item");
  link(gtk_single_selection_set_autoselect, "gtk_single_selection_set_autoselect");
  link(gtk_single_selection_set_can_unselect, "gtk_single_selection_set_can_unselect");
  link(gtk_single_selection_set_model, "gtk_single_selection_set_model");
  link(gtk_single_selection_set_selected, "gtk_single_selection_set_selected");

  // SizeGroup
  link(gtk_size_group_get_type, "gtk_size_group_get_type");
  link(gtk_size_group_new, "gtk_size_group_new");
  link(gtk_size_group_add_widget, "gtk_size_group_add_widget");
  link(gtk_size_group_get_mode, "gtk_size_group_get_mode");
  link(gtk_size_group_get_widgets, "gtk_size_group_get_widgets");
  link(gtk_size_group_remove_widget, "gtk_size_group_remove_widget");
  link(gtk_size_group_set_mode, "gtk_size_group_set_mode");

  // SliceListModel
  link(gtk_slice_list_model_get_type, "gtk_slice_list_model_get_type");
  link(gtk_slice_list_model_new, "gtk_slice_list_model_new");
  link(gtk_slice_list_model_get_model, "gtk_slice_list_model_get_model");
  link(gtk_slice_list_model_get_offset, "gtk_slice_list_model_get_offset");
  link(gtk_slice_list_model_get_size, "gtk_slice_list_model_get_size");
  link(gtk_slice_list_model_set_model, "gtk_slice_list_model_set_model");
  link(gtk_slice_list_model_set_offset, "gtk_slice_list_model_set_offset");
  link(gtk_slice_list_model_set_size, "gtk_slice_list_model_set_size");

  // Snapshot
  link(gtk_snapshot_get_type, "gtk_snapshot_get_type");
  link(gtk_snapshot_new, "gtk_snapshot_new");
  link(gtk_snapshot_append_border, "gtk_snapshot_append_border");
  link(gtk_snapshot_append_cairo, "gtk_snapshot_append_cairo");
  link(gtk_snapshot_append_color, "gtk_snapshot_append_color");
  link(gtk_snapshot_append_conic_gradient, "gtk_snapshot_append_conic_gradient");
  link(gtk_snapshot_append_fill, "gtk_snapshot_append_fill");
  link(gtk_snapshot_append_inset_shadow, "gtk_snapshot_append_inset_shadow");
  link(gtk_snapshot_append_layout, "gtk_snapshot_append_layout");
  link(gtk_snapshot_append_linear_gradient, "gtk_snapshot_append_linear_gradient");
  link(gtk_snapshot_append_node, "gtk_snapshot_append_node");
  link(gtk_snapshot_append_outset_shadow, "gtk_snapshot_append_outset_shadow");
  link(gtk_snapshot_append_radial_gradient, "gtk_snapshot_append_radial_gradient");
  link(gtk_snapshot_append_repeating_linear_gradient, "gtk_snapshot_append_repeating_linear_gradient");
  link(gtk_snapshot_append_repeating_radial_gradient, "gtk_snapshot_append_repeating_radial_gradient");
  link(gtk_snapshot_append_scaled_texture, "gtk_snapshot_append_scaled_texture");
  link(gtk_snapshot_append_stroke, "gtk_snapshot_append_stroke");
  link(gtk_snapshot_append_texture, "gtk_snapshot_append_texture");
  link(gtk_snapshot_free_to_node, "gtk_snapshot_free_to_node");
  link(gtk_snapshot_free_to_paintable, "gtk_snapshot_free_to_paintable");
  link(gtk_snapshot_gl_shader_pop_texture, "gtk_snapshot_gl_shader_pop_texture");
  link(gtk_snapshot_perspective, "gtk_snapshot_perspective");
  link(gtk_snapshot_pop, "gtk_snapshot_pop");
  link(gtk_snapshot_push_blend, "gtk_snapshot_push_blend");
  link(gtk_snapshot_push_blur, "gtk_snapshot_push_blur");
  link(gtk_snapshot_push_clip, "gtk_snapshot_push_clip");
  link(gtk_snapshot_push_color_matrix, "gtk_snapshot_push_color_matrix");
  link(gtk_snapshot_push_cross_fade, "gtk_snapshot_push_cross_fade");
  link(gtk_snapshot_push_debug, "gtk_snapshot_push_debug");
  link(gtk_snapshot_push_fill, "gtk_snapshot_push_fill");
  link(gtk_snapshot_push_gl_shader, "gtk_snapshot_push_gl_shader");
  link(gtk_snapshot_push_mask, "gtk_snapshot_push_mask");
  link(gtk_snapshot_push_opacity, "gtk_snapshot_push_opacity");
  link(gtk_snapshot_push_repeat, "gtk_snapshot_push_repeat");
  link(gtk_snapshot_push_rounded_clip, "gtk_snapshot_push_rounded_clip");
  link(gtk_snapshot_push_shadow, "gtk_snapshot_push_shadow");
  link(gtk_snapshot_push_stroke, "gtk_snapshot_push_stroke");
  link(gtk_snapshot_render_background, "gtk_snapshot_render_background");
  link(gtk_snapshot_render_focus, "gtk_snapshot_render_focus");
  link(gtk_snapshot_render_frame, "gtk_snapshot_render_frame");
  link(gtk_snapshot_render_insertion_cursor, "gtk_snapshot_render_insertion_cursor");
  link(gtk_snapshot_render_layout, "gtk_snapshot_render_layout");
  link(gtk_snapshot_restore, "gtk_snapshot_restore");
  link(gtk_snapshot_rotate, "gtk_snapshot_rotate");
  link(gtk_snapshot_rotate_3d, "gtk_snapshot_rotate_3d");
  link(gtk_snapshot_save, "gtk_snapshot_save");
  link(gtk_snapshot_scale, "gtk_snapshot_scale");
  link(gtk_snapshot_scale_3d, "gtk_snapshot_scale_3d");
  link(gtk_snapshot_to_node, "gtk_snapshot_to_node");
  link(gtk_snapshot_to_paintable, "gtk_snapshot_to_paintable");
  link(gtk_snapshot_transform, "gtk_snapshot_transform");
  link(gtk_snapshot_transform_matrix, "gtk_snapshot_transform_matrix");
  link(gtk_snapshot_translate, "gtk_snapshot_translate");
  link(gtk_snapshot_translate_3d, "gtk_snapshot_translate_3d");

  // SortListModel
  link(gtk_sort_list_model_get_type, "gtk_sort_list_model_get_type");
  link(gtk_sort_list_model_new, "gtk_sort_list_model_new");
  link(gtk_sort_list_model_get_incremental, "gtk_sort_list_model_get_incremental");
  link(gtk_sort_list_model_get_model, "gtk_sort_list_model_get_model");
  link(gtk_sort_list_model_get_pending, "gtk_sort_list_model_get_pending");
  link(gtk_sort_list_model_get_section_sorter, "gtk_sort_list_model_get_section_sorter");
  link(gtk_sort_list_model_get_sorter, "gtk_sort_list_model_get_sorter");
  link(gtk_sort_list_model_set_incremental, "gtk_sort_list_model_set_incremental");
  link(gtk_sort_list_model_set_model, "gtk_sort_list_model_set_model");
  link(gtk_sort_list_model_set_section_sorter, "gtk_sort_list_model_set_section_sorter");
  link(gtk_sort_list_model_set_sorter, "gtk_sort_list_model_set_sorter");

  // Sorter
  link(gtk_sorter_get_type, "gtk_sorter_get_type");
  link(gtk_sorter_changed, "gtk_sorter_changed");
  link(gtk_sorter_compare, "gtk_sorter_compare");
  link(gtk_sorter_get_order, "gtk_sorter_get_order");

  // SpinButton
  link(gtk_spin_button_get_type, "gtk_spin_button_get_type");
  link(gtk_spin_button_new, "gtk_spin_button_new");
  link(gtk_spin_button_new_with_range, "gtk_spin_button_new_with_range");
  link(gtk_spin_button_configure, "gtk_spin_button_configure");
  link(gtk_spin_button_get_activates_default, "gtk_spin_button_get_activates_default");
  link(gtk_spin_button_get_adjustment, "gtk_spin_button_get_adjustment");
  link(gtk_spin_button_get_climb_rate, "gtk_spin_button_get_climb_rate");
  link(gtk_spin_button_get_digits, "gtk_spin_button_get_digits");
  link(gtk_spin_button_get_increments, "gtk_spin_button_get_increments");
  link(gtk_spin_button_get_numeric, "gtk_spin_button_get_numeric");
  link(gtk_spin_button_get_range, "gtk_spin_button_get_range");
  link(gtk_spin_button_get_snap_to_ticks, "gtk_spin_button_get_snap_to_ticks");
  link(gtk_spin_button_get_update_policy, "gtk_spin_button_get_update_policy");
  link(gtk_spin_button_get_value, "gtk_spin_button_get_value");
  link(gtk_spin_button_get_value_as_int, "gtk_spin_button_get_value_as_int");
  link(gtk_spin_button_get_wrap, "gtk_spin_button_get_wrap");
  link(gtk_spin_button_set_activates_default, "gtk_spin_button_set_activates_default");
  link(gtk_spin_button_set_adjustment, "gtk_spin_button_set_adjustment");
  link(gtk_spin_button_set_climb_rate, "gtk_spin_button_set_climb_rate");
  link(gtk_spin_button_set_digits, "gtk_spin_button_set_digits");
  link(gtk_spin_button_set_increments, "gtk_spin_button_set_increments");
  link(gtk_spin_button_set_numeric, "gtk_spin_button_set_numeric");
  link(gtk_spin_button_set_range, "gtk_spin_button_set_range");
  link(gtk_spin_button_set_snap_to_ticks, "gtk_spin_button_set_snap_to_ticks");
  link(gtk_spin_button_set_update_policy, "gtk_spin_button_set_update_policy");
  link(gtk_spin_button_set_value, "gtk_spin_button_set_value");
  link(gtk_spin_button_set_wrap, "gtk_spin_button_set_wrap");
  link(gtk_spin_button_spin, "gtk_spin_button_spin");
  link(gtk_spin_button_update, "gtk_spin_button_update");

  // Spinner
  link(gtk_spinner_get_type, "gtk_spinner_get_type");
  link(gtk_spinner_new, "gtk_spinner_new");
  link(gtk_spinner_get_spinning, "gtk_spinner_get_spinning");
  link(gtk_spinner_set_spinning, "gtk_spinner_set_spinning");
  link(gtk_spinner_start, "gtk_spinner_start");
  link(gtk_spinner_stop, "gtk_spinner_stop");

  // Stack
  link(gtk_stack_get_type, "gtk_stack_get_type");
  link(gtk_stack_new, "gtk_stack_new");
  link(gtk_stack_add_child, "gtk_stack_add_child");
  link(gtk_stack_add_named, "gtk_stack_add_named");
  link(gtk_stack_add_titled, "gtk_stack_add_titled");
  link(gtk_stack_get_child_by_name, "gtk_stack_get_child_by_name");
  link(gtk_stack_get_hhomogeneous, "gtk_stack_get_hhomogeneous");
  link(gtk_stack_get_interpolate_size, "gtk_stack_get_interpolate_size");
  link(gtk_stack_get_page, "gtk_stack_get_page");
  link(gtk_stack_get_pages, "gtk_stack_get_pages");
  link(gtk_stack_get_transition_duration, "gtk_stack_get_transition_duration");
  link(gtk_stack_get_transition_running, "gtk_stack_get_transition_running");
  link(gtk_stack_get_transition_type, "gtk_stack_get_transition_type");
  link(gtk_stack_get_vhomogeneous, "gtk_stack_get_vhomogeneous");
  link(gtk_stack_get_visible_child, "gtk_stack_get_visible_child");
  link(gtk_stack_get_visible_child_name, "gtk_stack_get_visible_child_name");
  link(gtk_stack_remove, "gtk_stack_remove");
  link(gtk_stack_set_hhomogeneous, "gtk_stack_set_hhomogeneous");
  link(gtk_stack_set_interpolate_size, "gtk_stack_set_interpolate_size");
  link(gtk_stack_set_transition_duration, "gtk_stack_set_transition_duration");
  link(gtk_stack_set_transition_type, "gtk_stack_set_transition_type");
  link(gtk_stack_set_vhomogeneous, "gtk_stack_set_vhomogeneous");
  link(gtk_stack_set_visible_child, "gtk_stack_set_visible_child");
  link(gtk_stack_set_visible_child_full, "gtk_stack_set_visible_child_full");
  link(gtk_stack_set_visible_child_name, "gtk_stack_set_visible_child_name");

  // StackPage
  link(gtk_stack_page_get_type, "gtk_stack_page_get_type");
  link(gtk_stack_page_get_child, "gtk_stack_page_get_child");
  link(gtk_stack_page_get_icon_name, "gtk_stack_page_get_icon_name");
  link(gtk_stack_page_get_name, "gtk_stack_page_get_name");
  link(gtk_stack_page_get_needs_attention, "gtk_stack_page_get_needs_attention");
  link(gtk_stack_page_get_title, "gtk_stack_page_get_title");
  link(gtk_stack_page_get_use_underline, "gtk_stack_page_get_use_underline");
  link(gtk_stack_page_get_visible, "gtk_stack_page_get_visible");
  link(gtk_stack_page_set_icon_name, "gtk_stack_page_set_icon_name");
  link(gtk_stack_page_set_name, "gtk_stack_page_set_name");
  link(gtk_stack_page_set_needs_attention, "gtk_stack_page_set_needs_attention");
  link(gtk_stack_page_set_title, "gtk_stack_page_set_title");
  link(gtk_stack_page_set_use_underline, "gtk_stack_page_set_use_underline");
  link(gtk_stack_page_set_visible, "gtk_stack_page_set_visible");

  // StackSidebar
  link(gtk_stack_sidebar_get_type, "gtk_stack_sidebar_get_type");
  link(gtk_stack_sidebar_new, "gtk_stack_sidebar_new");
  link(gtk_stack_sidebar_get_stack, "gtk_stack_sidebar_get_stack");
  link(gtk_stack_sidebar_set_stack, "gtk_stack_sidebar_set_stack");

  // StackSwitcher
  link(gtk_stack_switcher_get_type, "gtk_stack_switcher_get_type");
  link(gtk_stack_switcher_new, "gtk_stack_switcher_new");
  link(gtk_stack_switcher_get_stack, "gtk_stack_switcher_get_stack");
  link(gtk_stack_switcher_set_stack, "gtk_stack_switcher_set_stack");

  // Statusbar
  link(gtk_statusbar_get_type, "gtk_statusbar_get_type");
  link(gtk_statusbar_new, "gtk_statusbar_new");
  link(gtk_statusbar_get_context_id, "gtk_statusbar_get_context_id");
  link(gtk_statusbar_pop, "gtk_statusbar_pop");
  link(gtk_statusbar_push, "gtk_statusbar_push");
  link(gtk_statusbar_remove, "gtk_statusbar_remove");
  link(gtk_statusbar_remove_all, "gtk_statusbar_remove_all");

  // StringFilter
  link(gtk_string_filter_get_type, "gtk_string_filter_get_type");
  link(gtk_string_filter_new, "gtk_string_filter_new");
  link(gtk_string_filter_get_expression, "gtk_string_filter_get_expression");
  link(gtk_string_filter_get_ignore_case, "gtk_string_filter_get_ignore_case");
  link(gtk_string_filter_get_match_mode, "gtk_string_filter_get_match_mode");
  link(gtk_string_filter_get_search, "gtk_string_filter_get_search");
  link(gtk_string_filter_set_expression, "gtk_string_filter_set_expression");
  link(gtk_string_filter_set_ignore_case, "gtk_string_filter_set_ignore_case");
  link(gtk_string_filter_set_match_mode, "gtk_string_filter_set_match_mode");
  link(gtk_string_filter_set_search, "gtk_string_filter_set_search");

  // StringList
  link(gtk_string_list_get_type, "gtk_string_list_get_type");
  link(gtk_string_list_new, "gtk_string_list_new");
  link(gtk_string_list_append, "gtk_string_list_append");
  link(gtk_string_list_get_string, "gtk_string_list_get_string");
  link(gtk_string_list_remove, "gtk_string_list_remove");
  link(gtk_string_list_splice, "gtk_string_list_splice");
  link(gtk_string_list_take, "gtk_string_list_take");

  // StringObject
  link(gtk_string_object_get_type, "gtk_string_object_get_type");
  link(gtk_string_object_new, "gtk_string_object_new");
  link(gtk_string_object_get_string, "gtk_string_object_get_string");

  // StringSorter
  link(gtk_string_sorter_get_type, "gtk_string_sorter_get_type");
  link(gtk_string_sorter_new, "gtk_string_sorter_new");
  link(gtk_string_sorter_get_collation, "gtk_string_sorter_get_collation");
  link(gtk_string_sorter_get_expression, "gtk_string_sorter_get_expression");
  link(gtk_string_sorter_get_ignore_case, "gtk_string_sorter_get_ignore_case");
  link(gtk_string_sorter_set_collation, "gtk_string_sorter_set_collation");
  link(gtk_string_sorter_set_expression, "gtk_string_sorter_set_expression");
  link(gtk_string_sorter_set_ignore_case, "gtk_string_sorter_set_ignore_case");

  // StyleContext
  link(gtk_style_context_get_type, "gtk_style_context_get_type");
  link(gtk_style_context_add_provider_for_display, "gtk_style_context_add_provider_for_display");
  link(gtk_style_context_remove_provider_for_display, "gtk_style_context_remove_provider_for_display");
  link(gtk_style_context_add_class, "gtk_style_context_add_class");
  link(gtk_style_context_add_provider, "gtk_style_context_add_provider");
  link(gtk_style_context_get_border, "gtk_style_context_get_border");
  link(gtk_style_context_get_color, "gtk_style_context_get_color");
  link(gtk_style_context_get_display, "gtk_style_context_get_display");
  link(gtk_style_context_get_margin, "gtk_style_context_get_margin");
  link(gtk_style_context_get_padding, "gtk_style_context_get_padding");
  link(gtk_style_context_get_scale, "gtk_style_context_get_scale");
  link(gtk_style_context_get_state, "gtk_style_context_get_state");
  link(gtk_style_context_has_class, "gtk_style_context_has_class");
  link(gtk_style_context_lookup_color, "gtk_style_context_lookup_color");
  link(gtk_style_context_remove_class, "gtk_style_context_remove_class");
  link(gtk_style_context_remove_provider, "gtk_style_context_remove_provider");
  link(gtk_style_context_restore, "gtk_style_context_restore");
  link(gtk_style_context_save, "gtk_style_context_save");
  link(gtk_style_context_set_display, "gtk_style_context_set_display");
  link(gtk_style_context_set_scale, "gtk_style_context_set_scale");
  link(gtk_style_context_set_state, "gtk_style_context_set_state");
  link(gtk_style_context_to_string, "gtk_style_context_to_string");

  // StyleProvider
  link(gtk_style_provider_get_type, "gtk_style_provider_get_type");

  // Switch
  link(gtk_switch_get_type, "gtk_switch_get_type");
  link(gtk_switch_new, "gtk_switch_new");
  link(gtk_switch_get_active, "gtk_switch_get_active");
  link(gtk_switch_get_state, "gtk_switch_get_state");
  link(gtk_switch_set_active, "gtk_switch_set_active");
  link(gtk_switch_set_state, "gtk_switch_set_state");

  // SymbolicPaintable
  link(gtk_symbolic_paintable_get_type, "gtk_symbolic_paintable_get_type");
  link(gtk_symbolic_paintable_snapshot_symbolic, "gtk_symbolic_paintable_snapshot_symbolic");

  // Text
  link(gtk_text_get_type, "gtk_text_get_type");
  link(gtk_text_new, "gtk_text_new");
  link(gtk_text_new_with_buffer, "gtk_text_new_with_buffer");
  link(gtk_text_compute_cursor_extents, "gtk_text_compute_cursor_extents");
  link(gtk_text_get_activates_default, "gtk_text_get_activates_default");
  link(gtk_text_get_attributes, "gtk_text_get_attributes");
  link(gtk_text_get_buffer, "gtk_text_get_buffer");
  link(gtk_text_get_enable_emoji_completion, "gtk_text_get_enable_emoji_completion");
  link(gtk_text_get_extra_menu, "gtk_text_get_extra_menu");
  link(gtk_text_get_input_hints, "gtk_text_get_input_hints");
  link(gtk_text_get_input_purpose, "gtk_text_get_input_purpose");
  link(gtk_text_get_invisible_char, "gtk_text_get_invisible_char");
  link(gtk_text_get_max_length, "gtk_text_get_max_length");
  link(gtk_text_get_overwrite_mode, "gtk_text_get_overwrite_mode");
  link(gtk_text_get_placeholder_text, "gtk_text_get_placeholder_text");
  link(gtk_text_get_propagate_text_width, "gtk_text_get_propagate_text_width");
  link(gtk_text_get_tabs, "gtk_text_get_tabs");
  link(gtk_text_get_text_length, "gtk_text_get_text_length");
  link(gtk_text_get_truncate_multiline, "gtk_text_get_truncate_multiline");
  link(gtk_text_get_visibility, "gtk_text_get_visibility");
  link(gtk_text_grab_focus_without_selecting, "gtk_text_grab_focus_without_selecting");
  link(gtk_text_set_activates_default, "gtk_text_set_activates_default");
  link(gtk_text_set_attributes, "gtk_text_set_attributes");
  link(gtk_text_set_buffer, "gtk_text_set_buffer");
  link(gtk_text_set_enable_emoji_completion, "gtk_text_set_enable_emoji_completion");
  link(gtk_text_set_extra_menu, "gtk_text_set_extra_menu");
  link(gtk_text_set_input_hints, "gtk_text_set_input_hints");
  link(gtk_text_set_input_purpose, "gtk_text_set_input_purpose");
  link(gtk_text_set_invisible_char, "gtk_text_set_invisible_char");
  link(gtk_text_set_max_length, "gtk_text_set_max_length");
  link(gtk_text_set_overwrite_mode, "gtk_text_set_overwrite_mode");
  link(gtk_text_set_placeholder_text, "gtk_text_set_placeholder_text");
  link(gtk_text_set_propagate_text_width, "gtk_text_set_propagate_text_width");
  link(gtk_text_set_tabs, "gtk_text_set_tabs");
  link(gtk_text_set_truncate_multiline, "gtk_text_set_truncate_multiline");
  link(gtk_text_set_visibility, "gtk_text_set_visibility");
  link(gtk_text_unset_invisible_char, "gtk_text_unset_invisible_char");

  // TextBuffer
  link(gtk_text_buffer_get_type, "gtk_text_buffer_get_type");
  link(gtk_text_buffer_new, "gtk_text_buffer_new");
  link(gtk_text_buffer_add_mark, "gtk_text_buffer_add_mark");
  link(gtk_text_buffer_add_selection_clipboard, "gtk_text_buffer_add_selection_clipboard");
  link(gtk_text_buffer_apply_tag, "gtk_text_buffer_apply_tag");
  link(gtk_text_buffer_apply_tag_by_name, "gtk_text_buffer_apply_tag_by_name");
  link(gtk_text_buffer_backspace, "gtk_text_buffer_backspace");
  link(gtk_text_buffer_begin_irreversible_action, "gtk_text_buffer_begin_irreversible_action");
  link(gtk_text_buffer_begin_user_action, "gtk_text_buffer_begin_user_action");
  link(gtk_text_buffer_copy_clipboard, "gtk_text_buffer_copy_clipboard");
  link(gtk_text_buffer_create_child_anchor, "gtk_text_buffer_create_child_anchor");
  link(gtk_text_buffer_create_mark, "gtk_text_buffer_create_mark");
  link(gtk_text_buffer_create_tag, "gtk_text_buffer_create_tag");
  link(gtk_text_buffer_cut_clipboard, "gtk_text_buffer_cut_clipboard");
  link(gtk_text_buffer_delete, "gtk_text_buffer_delete");
  link(gtk_text_buffer_delete_interactive, "gtk_text_buffer_delete_interactive");
  link(gtk_text_buffer_delete_mark, "gtk_text_buffer_delete_mark");
  link(gtk_text_buffer_delete_mark_by_name, "gtk_text_buffer_delete_mark_by_name");
  link(gtk_text_buffer_delete_selection, "gtk_text_buffer_delete_selection");
  link(gtk_text_buffer_end_irreversible_action, "gtk_text_buffer_end_irreversible_action");
  link(gtk_text_buffer_end_user_action, "gtk_text_buffer_end_user_action");
  link(gtk_text_buffer_get_bounds, "gtk_text_buffer_get_bounds");
  link(gtk_text_buffer_get_can_redo, "gtk_text_buffer_get_can_redo");
  link(gtk_text_buffer_get_can_undo, "gtk_text_buffer_get_can_undo");
  link(gtk_text_buffer_get_char_count, "gtk_text_buffer_get_char_count");
  link(gtk_text_buffer_get_enable_undo, "gtk_text_buffer_get_enable_undo");
  link(gtk_text_buffer_get_end_iter, "gtk_text_buffer_get_end_iter");
  link(gtk_text_buffer_get_has_selection, "gtk_text_buffer_get_has_selection");
  link(gtk_text_buffer_get_insert, "gtk_text_buffer_get_insert");
  link(gtk_text_buffer_get_iter_at_child_anchor, "gtk_text_buffer_get_iter_at_child_anchor");
  link(gtk_text_buffer_get_iter_at_line, "gtk_text_buffer_get_iter_at_line");
  link(gtk_text_buffer_get_iter_at_line_index, "gtk_text_buffer_get_iter_at_line_index");
  link(gtk_text_buffer_get_iter_at_line_offset, "gtk_text_buffer_get_iter_at_line_offset");
  link(gtk_text_buffer_get_iter_at_mark, "gtk_text_buffer_get_iter_at_mark");
  link(gtk_text_buffer_get_iter_at_offset, "gtk_text_buffer_get_iter_at_offset");
  link(gtk_text_buffer_get_line_count, "gtk_text_buffer_get_line_count");
  link(gtk_text_buffer_get_mark, "gtk_text_buffer_get_mark");
  link(gtk_text_buffer_get_max_undo_levels, "gtk_text_buffer_get_max_undo_levels");
  link(gtk_text_buffer_get_modified, "gtk_text_buffer_get_modified");
  link(gtk_text_buffer_get_selection_bound, "gtk_text_buffer_get_selection_bound");
  link(gtk_text_buffer_get_selection_bounds, "gtk_text_buffer_get_selection_bounds");
  link(gtk_text_buffer_get_selection_content, "gtk_text_buffer_get_selection_content");
  link(gtk_text_buffer_get_slice, "gtk_text_buffer_get_slice");
  link(gtk_text_buffer_get_start_iter, "gtk_text_buffer_get_start_iter");
  link(gtk_text_buffer_get_tag_table, "gtk_text_buffer_get_tag_table");
  link(gtk_text_buffer_get_text, "gtk_text_buffer_get_text");
  link(gtk_text_buffer_insert, "gtk_text_buffer_insert");
  link(gtk_text_buffer_insert_at_cursor, "gtk_text_buffer_insert_at_cursor");
  link(gtk_text_buffer_insert_child_anchor, "gtk_text_buffer_insert_child_anchor");
  link(gtk_text_buffer_insert_interactive, "gtk_text_buffer_insert_interactive");
  link(gtk_text_buffer_insert_interactive_at_cursor, "gtk_text_buffer_insert_interactive_at_cursor");
  link(gtk_text_buffer_insert_markup, "gtk_text_buffer_insert_markup");
  link(gtk_text_buffer_insert_paintable, "gtk_text_buffer_insert_paintable");
  link(gtk_text_buffer_insert_range, "gtk_text_buffer_insert_range");
  link(gtk_text_buffer_insert_range_interactive, "gtk_text_buffer_insert_range_interactive");
  link(gtk_text_buffer_insert_with_tags, "gtk_text_buffer_insert_with_tags");
  link(gtk_text_buffer_insert_with_tags_by_name, "gtk_text_buffer_insert_with_tags_by_name");
  link(gtk_text_buffer_move_mark, "gtk_text_buffer_move_mark");
  link(gtk_text_buffer_move_mark_by_name, "gtk_text_buffer_move_mark_by_name");
  link(gtk_text_buffer_paste_clipboard, "gtk_text_buffer_paste_clipboard");
  link(gtk_text_buffer_place_cursor, "gtk_text_buffer_place_cursor");
  link(gtk_text_buffer_redo, "gtk_text_buffer_redo");
  link(gtk_text_buffer_remove_all_tags, "gtk_text_buffer_remove_all_tags");
  link(gtk_text_buffer_remove_selection_clipboard, "gtk_text_buffer_remove_selection_clipboard");
  link(gtk_text_buffer_remove_tag, "gtk_text_buffer_remove_tag");
  link(gtk_text_buffer_remove_tag_by_name, "gtk_text_buffer_remove_tag_by_name");
  link(gtk_text_buffer_select_range, "gtk_text_buffer_select_range");
  link(gtk_text_buffer_set_enable_undo, "gtk_text_buffer_set_enable_undo");
  link(gtk_text_buffer_set_max_undo_levels, "gtk_text_buffer_set_max_undo_levels");
  link(gtk_text_buffer_set_modified, "gtk_text_buffer_set_modified");
  link(gtk_text_buffer_set_text, "gtk_text_buffer_set_text");
  link(gtk_text_buffer_undo, "gtk_text_buffer_undo");

  // TextChildAnchor
  link(gtk_text_child_anchor_get_type, "gtk_text_child_anchor_get_type");
  link(gtk_text_child_anchor_new, "gtk_text_child_anchor_new");
  link(gtk_text_child_anchor_new_with_replacement, "gtk_text_child_anchor_new_with_replacement");
  link(gtk_text_child_anchor_get_deleted, "gtk_text_child_anchor_get_deleted");
  link(gtk_text_child_anchor_get_widgets, "gtk_text_child_anchor_get_widgets");

  // TextIter
  link(gtk_text_iter_get_type, "gtk_text_iter_get_type");
  link(gtk_text_iter_assign, "gtk_text_iter_assign");
  link(gtk_text_iter_backward_char, "gtk_text_iter_backward_char");
  link(gtk_text_iter_backward_chars, "gtk_text_iter_backward_chars");
  link(gtk_text_iter_backward_cursor_position, "gtk_text_iter_backward_cursor_position");
  link(gtk_text_iter_backward_cursor_positions, "gtk_text_iter_backward_cursor_positions");
  link(gtk_text_iter_backward_find_char, "gtk_text_iter_backward_find_char");
  link(gtk_text_iter_backward_line, "gtk_text_iter_backward_line");
  link(gtk_text_iter_backward_lines, "gtk_text_iter_backward_lines");
  link(gtk_text_iter_backward_search, "gtk_text_iter_backward_search");
  link(gtk_text_iter_backward_sentence_start, "gtk_text_iter_backward_sentence_start");
  link(gtk_text_iter_backward_sentence_starts, "gtk_text_iter_backward_sentence_starts");
  link(gtk_text_iter_backward_to_tag_toggle, "gtk_text_iter_backward_to_tag_toggle");
  link(gtk_text_iter_backward_visible_cursor_position, "gtk_text_iter_backward_visible_cursor_position");
  link(gtk_text_iter_backward_visible_cursor_positions, "gtk_text_iter_backward_visible_cursor_positions");
  link(gtk_text_iter_backward_visible_line, "gtk_text_iter_backward_visible_line");
  link(gtk_text_iter_backward_visible_lines, "gtk_text_iter_backward_visible_lines");
  link(gtk_text_iter_backward_visible_word_start, "gtk_text_iter_backward_visible_word_start");
  link(gtk_text_iter_backward_visible_word_starts, "gtk_text_iter_backward_visible_word_starts");
  link(gtk_text_iter_backward_word_start, "gtk_text_iter_backward_word_start");
  link(gtk_text_iter_backward_word_starts, "gtk_text_iter_backward_word_starts");
  link(gtk_text_iter_can_insert, "gtk_text_iter_can_insert");
  link(gtk_text_iter_compare, "gtk_text_iter_compare");
  link(gtk_text_iter_copy, "gtk_text_iter_copy");
  link(gtk_text_iter_editable, "gtk_text_iter_editable");
  link(gtk_text_iter_ends_line, "gtk_text_iter_ends_line");
  link(gtk_text_iter_ends_sentence, "gtk_text_iter_ends_sentence");
  link(gtk_text_iter_ends_tag, "gtk_text_iter_ends_tag");
  link(gtk_text_iter_ends_word, "gtk_text_iter_ends_word");
  link(gtk_text_iter_equal, "gtk_text_iter_equal");
  link(gtk_text_iter_forward_char, "gtk_text_iter_forward_char");
  link(gtk_text_iter_forward_chars, "gtk_text_iter_forward_chars");
  link(gtk_text_iter_forward_cursor_position, "gtk_text_iter_forward_cursor_position");
  link(gtk_text_iter_forward_cursor_positions, "gtk_text_iter_forward_cursor_positions");
  link(gtk_text_iter_forward_find_char, "gtk_text_iter_forward_find_char");
  link(gtk_text_iter_forward_line, "gtk_text_iter_forward_line");
  link(gtk_text_iter_forward_lines, "gtk_text_iter_forward_lines");
  link(gtk_text_iter_forward_search, "gtk_text_iter_forward_search");
  link(gtk_text_iter_forward_sentence_end, "gtk_text_iter_forward_sentence_end");
  link(gtk_text_iter_forward_sentence_ends, "gtk_text_iter_forward_sentence_ends");
  link(gtk_text_iter_forward_to_end, "gtk_text_iter_forward_to_end");
  link(gtk_text_iter_forward_to_line_end, "gtk_text_iter_forward_to_line_end");
  link(gtk_text_iter_forward_to_tag_toggle, "gtk_text_iter_forward_to_tag_toggle");
  link(gtk_text_iter_forward_visible_cursor_position, "gtk_text_iter_forward_visible_cursor_position");
  link(gtk_text_iter_forward_visible_cursor_positions, "gtk_text_iter_forward_visible_cursor_positions");
  link(gtk_text_iter_forward_visible_line, "gtk_text_iter_forward_visible_line");
  link(gtk_text_iter_forward_visible_lines, "gtk_text_iter_forward_visible_lines");
  link(gtk_text_iter_forward_visible_word_end, "gtk_text_iter_forward_visible_word_end");
  link(gtk_text_iter_forward_visible_word_ends, "gtk_text_iter_forward_visible_word_ends");
  link(gtk_text_iter_forward_word_end, "gtk_text_iter_forward_word_end");
  link(gtk_text_iter_forward_word_ends, "gtk_text_iter_forward_word_ends");
  link(gtk_text_iter_free, "gtk_text_iter_free");
  link(gtk_text_iter_get_buffer, "gtk_text_iter_get_buffer");
  link(gtk_text_iter_get_bytes_in_line, "gtk_text_iter_get_bytes_in_line");
  link(gtk_text_iter_get_char, "gtk_text_iter_get_char");
  link(gtk_text_iter_get_chars_in_line, "gtk_text_iter_get_chars_in_line");
  link(gtk_text_iter_get_child_anchor, "gtk_text_iter_get_child_anchor");
  link(gtk_text_iter_get_language, "gtk_text_iter_get_language");
  link(gtk_text_iter_get_line, "gtk_text_iter_get_line");
  link(gtk_text_iter_get_line_index, "gtk_text_iter_get_line_index");
  link(gtk_text_iter_get_line_offset, "gtk_text_iter_get_line_offset");
  link(gtk_text_iter_get_marks, "gtk_text_iter_get_marks");
  link(gtk_text_iter_get_offset, "gtk_text_iter_get_offset");
  link(gtk_text_iter_get_paintable, "gtk_text_iter_get_paintable");
  link(gtk_text_iter_get_slice, "gtk_text_iter_get_slice");
  link(gtk_text_iter_get_tags, "gtk_text_iter_get_tags");
  link(gtk_text_iter_get_text, "gtk_text_iter_get_text");
  link(gtk_text_iter_get_toggled_tags, "gtk_text_iter_get_toggled_tags");
  link(gtk_text_iter_get_visible_line_index, "gtk_text_iter_get_visible_line_index");
  link(gtk_text_iter_get_visible_line_offset, "gtk_text_iter_get_visible_line_offset");
  link(gtk_text_iter_get_visible_slice, "gtk_text_iter_get_visible_slice");
  link(gtk_text_iter_get_visible_text, "gtk_text_iter_get_visible_text");
  link(gtk_text_iter_has_tag, "gtk_text_iter_has_tag");
  link(gtk_text_iter_in_range, "gtk_text_iter_in_range");
  link(gtk_text_iter_inside_sentence, "gtk_text_iter_inside_sentence");
  link(gtk_text_iter_inside_word, "gtk_text_iter_inside_word");
  link(gtk_text_iter_is_cursor_position, "gtk_text_iter_is_cursor_position");
  link(gtk_text_iter_is_end, "gtk_text_iter_is_end");
  link(gtk_text_iter_is_start, "gtk_text_iter_is_start");
  link(gtk_text_iter_order, "gtk_text_iter_order");
  link(gtk_text_iter_set_line, "gtk_text_iter_set_line");
  link(gtk_text_iter_set_line_index, "gtk_text_iter_set_line_index");
  link(gtk_text_iter_set_line_offset, "gtk_text_iter_set_line_offset");
  link(gtk_text_iter_set_offset, "gtk_text_iter_set_offset");
  link(gtk_text_iter_set_visible_line_index, "gtk_text_iter_set_visible_line_index");
  link(gtk_text_iter_set_visible_line_offset, "gtk_text_iter_set_visible_line_offset");
  link(gtk_text_iter_starts_line, "gtk_text_iter_starts_line");
  link(gtk_text_iter_starts_sentence, "gtk_text_iter_starts_sentence");
  link(gtk_text_iter_starts_tag, "gtk_text_iter_starts_tag");
  link(gtk_text_iter_starts_word, "gtk_text_iter_starts_word");
  link(gtk_text_iter_toggles_tag, "gtk_text_iter_toggles_tag");

  // TextMark
  link(gtk_text_mark_get_type, "gtk_text_mark_get_type");
  link(gtk_text_mark_new, "gtk_text_mark_new");
  link(gtk_text_mark_get_buffer, "gtk_text_mark_get_buffer");
  link(gtk_text_mark_get_deleted, "gtk_text_mark_get_deleted");
  link(gtk_text_mark_get_left_gravity, "gtk_text_mark_get_left_gravity");
  link(gtk_text_mark_get_name, "gtk_text_mark_get_name");
  link(gtk_text_mark_get_visible, "gtk_text_mark_get_visible");
  link(gtk_text_mark_set_visible, "gtk_text_mark_set_visible");

  // TextTag
  link(gtk_text_tag_get_type, "gtk_text_tag_get_type");
  link(gtk_text_tag_new, "gtk_text_tag_new");
  link(gtk_text_tag_changed, "gtk_text_tag_changed");
  link(gtk_text_tag_get_priority, "gtk_text_tag_get_priority");
  link(gtk_text_tag_set_priority, "gtk_text_tag_set_priority");

  // TextTagTable
  link(gtk_text_tag_table_get_type, "gtk_text_tag_table_get_type");
  link(gtk_text_tag_table_new, "gtk_text_tag_table_new");
  link(gtk_text_tag_table_add, "gtk_text_tag_table_add");
  link(gtk_text_tag_table_foreach, "gtk_text_tag_table_foreach");
  link(gtk_text_tag_table_get_size, "gtk_text_tag_table_get_size");
  link(gtk_text_tag_table_lookup, "gtk_text_tag_table_lookup");
  link(gtk_text_tag_table_remove, "gtk_text_tag_table_remove");

  // TextView
  link(gtk_text_view_get_type, "gtk_text_view_get_type");
  link(gtk_text_view_new, "gtk_text_view_new");
  link(gtk_text_view_new_with_buffer, "gtk_text_view_new_with_buffer");
  link(gtk_text_view_add_child_at_anchor, "gtk_text_view_add_child_at_anchor");
  link(gtk_text_view_add_overlay, "gtk_text_view_add_overlay");
  link(gtk_text_view_backward_display_line, "gtk_text_view_backward_display_line");
  link(gtk_text_view_backward_display_line_start, "gtk_text_view_backward_display_line_start");
  link(gtk_text_view_buffer_to_window_coords, "gtk_text_view_buffer_to_window_coords");
  link(gtk_text_view_forward_display_line, "gtk_text_view_forward_display_line");
  link(gtk_text_view_forward_display_line_end, "gtk_text_view_forward_display_line_end");
  link(gtk_text_view_get_accepts_tab, "gtk_text_view_get_accepts_tab");
  link(gtk_text_view_get_bottom_margin, "gtk_text_view_get_bottom_margin");
  link(gtk_text_view_get_buffer, "gtk_text_view_get_buffer");
  link(gtk_text_view_get_cursor_locations, "gtk_text_view_get_cursor_locations");
  link(gtk_text_view_get_cursor_visible, "gtk_text_view_get_cursor_visible");
  link(gtk_text_view_get_editable, "gtk_text_view_get_editable");
  link(gtk_text_view_get_extra_menu, "gtk_text_view_get_extra_menu");
  link(gtk_text_view_get_gutter, "gtk_text_view_get_gutter");
  link(gtk_text_view_get_indent, "gtk_text_view_get_indent");
  link(gtk_text_view_get_input_hints, "gtk_text_view_get_input_hints");
  link(gtk_text_view_get_input_purpose, "gtk_text_view_get_input_purpose");
  link(gtk_text_view_get_iter_at_location, "gtk_text_view_get_iter_at_location");
  link(gtk_text_view_get_iter_at_position, "gtk_text_view_get_iter_at_position");
  link(gtk_text_view_get_iter_location, "gtk_text_view_get_iter_location");
  link(gtk_text_view_get_justification, "gtk_text_view_get_justification");
  link(gtk_text_view_get_left_margin, "gtk_text_view_get_left_margin");
  link(gtk_text_view_get_line_at_y, "gtk_text_view_get_line_at_y");
  link(gtk_text_view_get_line_yrange, "gtk_text_view_get_line_yrange");
  link(gtk_text_view_get_ltr_context, "gtk_text_view_get_ltr_context");
  link(gtk_text_view_get_monospace, "gtk_text_view_get_monospace");
  link(gtk_text_view_get_overwrite, "gtk_text_view_get_overwrite");
  link(gtk_text_view_get_pixels_above_lines, "gtk_text_view_get_pixels_above_lines");
  link(gtk_text_view_get_pixels_below_lines, "gtk_text_view_get_pixels_below_lines");
  link(gtk_text_view_get_pixels_inside_wrap, "gtk_text_view_get_pixels_inside_wrap");
  link(gtk_text_view_get_right_margin, "gtk_text_view_get_right_margin");
  link(gtk_text_view_get_rtl_context, "gtk_text_view_get_rtl_context");
  link(gtk_text_view_get_tabs, "gtk_text_view_get_tabs");
  link(gtk_text_view_get_top_margin, "gtk_text_view_get_top_margin");
  link(gtk_text_view_get_visible_rect, "gtk_text_view_get_visible_rect");
  link(gtk_text_view_get_wrap_mode, "gtk_text_view_get_wrap_mode");
  link(gtk_text_view_im_context_filter_keypress, "gtk_text_view_im_context_filter_keypress");
  link(gtk_text_view_move_mark_onscreen, "gtk_text_view_move_mark_onscreen");
  link(gtk_text_view_move_overlay, "gtk_text_view_move_overlay");
  link(gtk_text_view_move_visually, "gtk_text_view_move_visually");
  link(gtk_text_view_place_cursor_onscreen, "gtk_text_view_place_cursor_onscreen");
  link(gtk_text_view_remove, "gtk_text_view_remove");
  link(gtk_text_view_reset_cursor_blink, "gtk_text_view_reset_cursor_blink");
  link(gtk_text_view_reset_im_context, "gtk_text_view_reset_im_context");
  link(gtk_text_view_scroll_mark_onscreen, "gtk_text_view_scroll_mark_onscreen");
  link(gtk_text_view_scroll_to_iter, "gtk_text_view_scroll_to_iter");
  link(gtk_text_view_scroll_to_mark, "gtk_text_view_scroll_to_mark");
  link(gtk_text_view_set_accepts_tab, "gtk_text_view_set_accepts_tab");
  link(gtk_text_view_set_bottom_margin, "gtk_text_view_set_bottom_margin");
  link(gtk_text_view_set_buffer, "gtk_text_view_set_buffer");
  link(gtk_text_view_set_cursor_visible, "gtk_text_view_set_cursor_visible");
  link(gtk_text_view_set_editable, "gtk_text_view_set_editable");
  link(gtk_text_view_set_extra_menu, "gtk_text_view_set_extra_menu");
  link(gtk_text_view_set_gutter, "gtk_text_view_set_gutter");
  link(gtk_text_view_set_indent, "gtk_text_view_set_indent");
  link(gtk_text_view_set_input_hints, "gtk_text_view_set_input_hints");
  link(gtk_text_view_set_input_purpose, "gtk_text_view_set_input_purpose");
  link(gtk_text_view_set_justification, "gtk_text_view_set_justification");
  link(gtk_text_view_set_left_margin, "gtk_text_view_set_left_margin");
  link(gtk_text_view_set_monospace, "gtk_text_view_set_monospace");
  link(gtk_text_view_set_overwrite, "gtk_text_view_set_overwrite");
  link(gtk_text_view_set_pixels_above_lines, "gtk_text_view_set_pixels_above_lines");
  link(gtk_text_view_set_pixels_below_lines, "gtk_text_view_set_pixels_below_lines");
  link(gtk_text_view_set_pixels_inside_wrap, "gtk_text_view_set_pixels_inside_wrap");
  link(gtk_text_view_set_right_margin, "gtk_text_view_set_right_margin");
  link(gtk_text_view_set_tabs, "gtk_text_view_set_tabs");
  link(gtk_text_view_set_top_margin, "gtk_text_view_set_top_margin");
  link(gtk_text_view_set_wrap_mode, "gtk_text_view_set_wrap_mode");
  link(gtk_text_view_starts_display_line, "gtk_text_view_starts_display_line");
  link(gtk_text_view_window_to_buffer_coords, "gtk_text_view_window_to_buffer_coords");

  // ToggleButton
  link(gtk_toggle_button_get_type, "gtk_toggle_button_get_type");
  link(gtk_toggle_button_new, "gtk_toggle_button_new");
  link(gtk_toggle_button_new_with_label, "gtk_toggle_button_new_with_label");
  link(gtk_toggle_button_new_with_mnemonic, "gtk_toggle_button_new_with_mnemonic");
  link(gtk_toggle_button_get_active, "gtk_toggle_button_get_active");
  link(gtk_toggle_button_set_active, "gtk_toggle_button_set_active");
  link(gtk_toggle_button_set_group, "gtk_toggle_button_set_group");
  link(gtk_toggle_button_toggled, "gtk_toggle_button_toggled");

  // Tooltip
  link(gtk_tooltip_get_type, "gtk_tooltip_get_type");
  link(gtk_tooltip_set_custom, "gtk_tooltip_set_custom");
  link(gtk_tooltip_set_icon, "gtk_tooltip_set_icon");
  link(gtk_tooltip_set_icon_from_gicon, "gtk_tooltip_set_icon_from_gicon");
  link(gtk_tooltip_set_icon_from_icon_name, "gtk_tooltip_set_icon_from_icon_name");
  link(gtk_tooltip_set_markup, "gtk_tooltip_set_markup");
  link(gtk_tooltip_set_text, "gtk_tooltip_set_text");
  link(gtk_tooltip_set_tip_area, "gtk_tooltip_set_tip_area");

  // TreeDragDest
  link(gtk_tree_drag_dest_get_type, "gtk_tree_drag_dest_get_type");
  link(gtk_tree_drag_dest_drag_data_received, "gtk_tree_drag_dest_drag_data_received");
  link(gtk_tree_drag_dest_row_drop_possible, "gtk_tree_drag_dest_row_drop_possible");

  // TreeDragSource
  link(gtk_tree_drag_source_get_type, "gtk_tree_drag_source_get_type");
  link(gtk_tree_drag_source_drag_data_delete, "gtk_tree_drag_source_drag_data_delete");
  link(gtk_tree_drag_source_drag_data_get, "gtk_tree_drag_source_drag_data_get");
  link(gtk_tree_drag_source_row_draggable, "gtk_tree_drag_source_row_draggable");

  // TreeExpander
  link(gtk_tree_expander_get_type, "gtk_tree_expander_get_type");
  link(gtk_tree_expander_new, "gtk_tree_expander_new");
  link(gtk_tree_expander_get_child, "gtk_tree_expander_get_child");
  link(gtk_tree_expander_get_hide_expander, "gtk_tree_expander_get_hide_expander");
  link(gtk_tree_expander_get_indent_for_depth, "gtk_tree_expander_get_indent_for_depth");
  link(gtk_tree_expander_get_indent_for_icon, "gtk_tree_expander_get_indent_for_icon");
  link(gtk_tree_expander_get_item, "gtk_tree_expander_get_item");
  link(gtk_tree_expander_get_list_row, "gtk_tree_expander_get_list_row");
  link(gtk_tree_expander_set_child, "gtk_tree_expander_set_child");
  link(gtk_tree_expander_set_hide_expander, "gtk_tree_expander_set_hide_expander");
  link(gtk_tree_expander_set_indent_for_depth, "gtk_tree_expander_set_indent_for_depth");
  link(gtk_tree_expander_set_indent_for_icon, "gtk_tree_expander_set_indent_for_icon");
  link(gtk_tree_expander_set_list_row, "gtk_tree_expander_set_list_row");

  // TreeIter
  link(gtk_tree_iter_get_type, "gtk_tree_iter_get_type");
  link(gtk_tree_iter_copy, "gtk_tree_iter_copy");
  link(gtk_tree_iter_free, "gtk_tree_iter_free");

  // TreeListModel
  link(gtk_tree_list_model_get_type, "gtk_tree_list_model_get_type");
  link(gtk_tree_list_model_new, "gtk_tree_list_model_new");
  link(gtk_tree_list_model_get_autoexpand, "gtk_tree_list_model_get_autoexpand");
  link(gtk_tree_list_model_get_child_row, "gtk_tree_list_model_get_child_row");
  link(gtk_tree_list_model_get_model, "gtk_tree_list_model_get_model");
  link(gtk_tree_list_model_get_passthrough, "gtk_tree_list_model_get_passthrough");
  link(gtk_tree_list_model_get_row, "gtk_tree_list_model_get_row");
  link(gtk_tree_list_model_set_autoexpand, "gtk_tree_list_model_set_autoexpand");

  // TreeListRow
  link(gtk_tree_list_row_get_type, "gtk_tree_list_row_get_type");
  link(gtk_tree_list_row_get_child_row, "gtk_tree_list_row_get_child_row");
  link(gtk_tree_list_row_get_children, "gtk_tree_list_row_get_children");
  link(gtk_tree_list_row_get_depth, "gtk_tree_list_row_get_depth");
  link(gtk_tree_list_row_get_expanded, "gtk_tree_list_row_get_expanded");
  link(gtk_tree_list_row_get_item, "gtk_tree_list_row_get_item");
  link(gtk_tree_list_row_get_parent, "gtk_tree_list_row_get_parent");
  link(gtk_tree_list_row_get_position, "gtk_tree_list_row_get_position");
  link(gtk_tree_list_row_is_expandable, "gtk_tree_list_row_is_expandable");
  link(gtk_tree_list_row_set_expanded, "gtk_tree_list_row_set_expanded");

  // TreeListRowSorter
  link(gtk_tree_list_row_sorter_get_type, "gtk_tree_list_row_sorter_get_type");
  link(gtk_tree_list_row_sorter_new, "gtk_tree_list_row_sorter_new");
  link(gtk_tree_list_row_sorter_get_sorter, "gtk_tree_list_row_sorter_get_sorter");
  link(gtk_tree_list_row_sorter_set_sorter, "gtk_tree_list_row_sorter_set_sorter");

  // TreeModel
  link(gtk_tree_model_get_type, "gtk_tree_model_get_type");
  link(gtk_tree_model_filter_new, "gtk_tree_model_filter_new");
  link(gtk_tree_model_foreach, "gtk_tree_model_foreach");
  link(gtk_tree_model_get, "gtk_tree_model_get");
  link(gtk_tree_model_get_column_type, "gtk_tree_model_get_column_type");
  link(gtk_tree_model_get_flags, "gtk_tree_model_get_flags");
  link(gtk_tree_model_get_iter, "gtk_tree_model_get_iter");
  link(gtk_tree_model_get_iter_first, "gtk_tree_model_get_iter_first");
  link(gtk_tree_model_get_iter_from_string, "gtk_tree_model_get_iter_from_string");
  link(gtk_tree_model_get_n_columns, "gtk_tree_model_get_n_columns");
  link(gtk_tree_model_get_path, "gtk_tree_model_get_path");
  link(gtk_tree_model_get_string_from_iter, "gtk_tree_model_get_string_from_iter");
  link(gtk_tree_model_get_valist, "gtk_tree_model_get_valist");
  link(gtk_tree_model_get_value, "gtk_tree_model_get_value");
  link(gtk_tree_model_iter_children, "gtk_tree_model_iter_children");
  link(gtk_tree_model_iter_has_child, "gtk_tree_model_iter_has_child");
  link(gtk_tree_model_iter_n_children, "gtk_tree_model_iter_n_children");
  link(gtk_tree_model_iter_next, "gtk_tree_model_iter_next");
  link(gtk_tree_model_iter_nth_child, "gtk_tree_model_iter_nth_child");
  link(gtk_tree_model_iter_parent, "gtk_tree_model_iter_parent");
  link(gtk_tree_model_iter_previous, "gtk_tree_model_iter_previous");
  link(gtk_tree_model_ref_node, "gtk_tree_model_ref_node");
  link(gtk_tree_model_row_changed, "gtk_tree_model_row_changed");
  link(gtk_tree_model_row_deleted, "gtk_tree_model_row_deleted");
  link(gtk_tree_model_row_has_child_toggled, "gtk_tree_model_row_has_child_toggled");
  link(gtk_tree_model_row_inserted, "gtk_tree_model_row_inserted");
  link(gtk_tree_model_rows_reordered, "gtk_tree_model_rows_reordered");
  link(gtk_tree_model_rows_reordered_with_length, "gtk_tree_model_rows_reordered_with_length");
  link(gtk_tree_model_unref_node, "gtk_tree_model_unref_node");

  // TreeModelFilter
  link(gtk_tree_model_filter_get_type, "gtk_tree_model_filter_get_type");
  link(gtk_tree_model_filter_clear_cache, "gtk_tree_model_filter_clear_cache");
  link(gtk_tree_model_filter_convert_child_iter_to_iter, "gtk_tree_model_filter_convert_child_iter_to_iter");
  link(gtk_tree_model_filter_convert_child_path_to_path, "gtk_tree_model_filter_convert_child_path_to_path");
  link(gtk_tree_model_filter_convert_iter_to_child_iter, "gtk_tree_model_filter_convert_iter_to_child_iter");
  link(gtk_tree_model_filter_convert_path_to_child_path, "gtk_tree_model_filter_convert_path_to_child_path");
  link(gtk_tree_model_filter_get_model, "gtk_tree_model_filter_get_model");
  link(gtk_tree_model_filter_refilter, "gtk_tree_model_filter_refilter");
  link(gtk_tree_model_filter_set_modify_func, "gtk_tree_model_filter_set_modify_func");
  link(gtk_tree_model_filter_set_visible_column, "gtk_tree_model_filter_set_visible_column");
  link(gtk_tree_model_filter_set_visible_func, "gtk_tree_model_filter_set_visible_func");

  // TreeModelSort
  link(gtk_tree_model_sort_get_type, "gtk_tree_model_sort_get_type");
  link(gtk_tree_model_sort_new_with_model, "gtk_tree_model_sort_new_with_model");
  link(gtk_tree_model_sort_clear_cache, "gtk_tree_model_sort_clear_cache");
  link(gtk_tree_model_sort_convert_child_iter_to_iter, "gtk_tree_model_sort_convert_child_iter_to_iter");
  link(gtk_tree_model_sort_convert_child_path_to_path, "gtk_tree_model_sort_convert_child_path_to_path");
  link(gtk_tree_model_sort_convert_iter_to_child_iter, "gtk_tree_model_sort_convert_iter_to_child_iter");
  link(gtk_tree_model_sort_convert_path_to_child_path, "gtk_tree_model_sort_convert_path_to_child_path");
  link(gtk_tree_model_sort_get_model, "gtk_tree_model_sort_get_model");
  link(gtk_tree_model_sort_iter_is_valid, "gtk_tree_model_sort_iter_is_valid");
  link(gtk_tree_model_sort_reset_default_sort_func, "gtk_tree_model_sort_reset_default_sort_func");

  // TreePath
  link(gtk_tree_path_get_type, "gtk_tree_path_get_type");
  link(gtk_tree_path_new, "gtk_tree_path_new");
  link(gtk_tree_path_new_first, "gtk_tree_path_new_first");
  link(gtk_tree_path_new_from_indices, "gtk_tree_path_new_from_indices");
  link(gtk_tree_path_new_from_indicesv, "gtk_tree_path_new_from_indicesv");
  link(gtk_tree_path_new_from_string, "gtk_tree_path_new_from_string");
  link(gtk_tree_path_append_index, "gtk_tree_path_append_index");
  link(gtk_tree_path_compare, "gtk_tree_path_compare");
  link(gtk_tree_path_copy, "gtk_tree_path_copy");
  link(gtk_tree_path_down, "gtk_tree_path_down");
  link(gtk_tree_path_free, "gtk_tree_path_free");
  link(gtk_tree_path_get_depth, "gtk_tree_path_get_depth");
  link(gtk_tree_path_get_indices, "gtk_tree_path_get_indices");
  link(gtk_tree_path_get_indices_with_depth, "gtk_tree_path_get_indices_with_depth");
  link(gtk_tree_path_is_ancestor, "gtk_tree_path_is_ancestor");
  link(gtk_tree_path_is_descendant, "gtk_tree_path_is_descendant");
  link(gtk_tree_path_next, "gtk_tree_path_next");
  link(gtk_tree_path_prepend_index, "gtk_tree_path_prepend_index");
  link(gtk_tree_path_prev, "gtk_tree_path_prev");
  link(gtk_tree_path_to_string, "gtk_tree_path_to_string");
  link(gtk_tree_path_up, "gtk_tree_path_up");

  // TreeRowReference
  link(gtk_tree_row_reference_get_type, "gtk_tree_row_reference_get_type");
  link(gtk_tree_row_reference_new, "gtk_tree_row_reference_new");
  link(gtk_tree_row_reference_new_proxy, "gtk_tree_row_reference_new_proxy");
  link(gtk_tree_row_reference_copy, "gtk_tree_row_reference_copy");
  link(gtk_tree_row_reference_free, "gtk_tree_row_reference_free");
  link(gtk_tree_row_reference_get_model, "gtk_tree_row_reference_get_model");
  link(gtk_tree_row_reference_get_path, "gtk_tree_row_reference_get_path");
  link(gtk_tree_row_reference_valid, "gtk_tree_row_reference_valid");
  link(gtk_tree_row_reference_deleted, "gtk_tree_row_reference_deleted");
  link(gtk_tree_row_reference_inserted, "gtk_tree_row_reference_inserted");
  link(gtk_tree_row_reference_reordered, "gtk_tree_row_reference_reordered");

  // TreeSelection
  link(gtk_tree_selection_get_type, "gtk_tree_selection_get_type");
  link(gtk_tree_selection_count_selected_rows, "gtk_tree_selection_count_selected_rows");
  link(gtk_tree_selection_get_mode, "gtk_tree_selection_get_mode");
  link(gtk_tree_selection_get_select_function, "gtk_tree_selection_get_select_function");
  link(gtk_tree_selection_get_selected, "gtk_tree_selection_get_selected");
  link(gtk_tree_selection_get_selected_rows, "gtk_tree_selection_get_selected_rows");
  link(gtk_tree_selection_get_tree_view, "gtk_tree_selection_get_tree_view");
  link(gtk_tree_selection_get_user_data, "gtk_tree_selection_get_user_data");
  link(gtk_tree_selection_iter_is_selected, "gtk_tree_selection_iter_is_selected");
  link(gtk_tree_selection_path_is_selected, "gtk_tree_selection_path_is_selected");
  link(gtk_tree_selection_select_all, "gtk_tree_selection_select_all");
  link(gtk_tree_selection_select_iter, "gtk_tree_selection_select_iter");
  link(gtk_tree_selection_select_path, "gtk_tree_selection_select_path");
  link(gtk_tree_selection_select_range, "gtk_tree_selection_select_range");
  link(gtk_tree_selection_selected_foreach, "gtk_tree_selection_selected_foreach");
  link(gtk_tree_selection_set_mode, "gtk_tree_selection_set_mode");
  link(gtk_tree_selection_set_select_function, "gtk_tree_selection_set_select_function");
  link(gtk_tree_selection_unselect_all, "gtk_tree_selection_unselect_all");
  link(gtk_tree_selection_unselect_iter, "gtk_tree_selection_unselect_iter");
  link(gtk_tree_selection_unselect_path, "gtk_tree_selection_unselect_path");
  link(gtk_tree_selection_unselect_range, "gtk_tree_selection_unselect_range");

  // TreeSortable
  link(gtk_tree_sortable_get_type, "gtk_tree_sortable_get_type");
  link(gtk_tree_sortable_get_sort_column_id, "gtk_tree_sortable_get_sort_column_id");
  link(gtk_tree_sortable_has_default_sort_func, "gtk_tree_sortable_has_default_sort_func");
  link(gtk_tree_sortable_set_default_sort_func, "gtk_tree_sortable_set_default_sort_func");
  link(gtk_tree_sortable_set_sort_column_id, "gtk_tree_sortable_set_sort_column_id");
  link(gtk_tree_sortable_set_sort_func, "gtk_tree_sortable_set_sort_func");
  link(gtk_tree_sortable_sort_column_changed, "gtk_tree_sortable_sort_column_changed");

  // TreeStore
  link(gtk_tree_store_get_type, "gtk_tree_store_get_type");
  link(gtk_tree_store_new, "gtk_tree_store_new");
  link(gtk_tree_store_newv, "gtk_tree_store_newv");
  link(gtk_tree_store_append, "gtk_tree_store_append");
  link(gtk_tree_store_clear, "gtk_tree_store_clear");
  link(gtk_tree_store_insert, "gtk_tree_store_insert");
  link(gtk_tree_store_insert_after, "gtk_tree_store_insert_after");
  link(gtk_tree_store_insert_before, "gtk_tree_store_insert_before");
  link(gtk_tree_store_insert_with_values, "gtk_tree_store_insert_with_values");
  link(gtk_tree_store_insert_with_valuesv, "gtk_tree_store_insert_with_valuesv");
  link(gtk_tree_store_is_ancestor, "gtk_tree_store_is_ancestor");
  link(gtk_tree_store_iter_depth, "gtk_tree_store_iter_depth");
  link(gtk_tree_store_iter_is_valid, "gtk_tree_store_iter_is_valid");
  link(gtk_tree_store_move_after, "gtk_tree_store_move_after");
  link(gtk_tree_store_move_before, "gtk_tree_store_move_before");
  link(gtk_tree_store_prepend, "gtk_tree_store_prepend");
  link(gtk_tree_store_remove, "gtk_tree_store_remove");
  link(gtk_tree_store_reorder, "gtk_tree_store_reorder");
  link(gtk_tree_store_set, "gtk_tree_store_set");
  link(gtk_tree_store_set_column_types, "gtk_tree_store_set_column_types");
  link(gtk_tree_store_set_valist, "gtk_tree_store_set_valist");
  link(gtk_tree_store_set_value, "gtk_tree_store_set_value");
  link(gtk_tree_store_set_valuesv, "gtk_tree_store_set_valuesv");
  link(gtk_tree_store_swap, "gtk_tree_store_swap");

  // TreeView
  link(gtk_tree_view_get_type, "gtk_tree_view_get_type");
  link(gtk_tree_view_new, "gtk_tree_view_new");
  link(gtk_tree_view_new_with_model, "gtk_tree_view_new_with_model");
  link(gtk_tree_view_append_column, "gtk_tree_view_append_column");
  link(gtk_tree_view_collapse_all, "gtk_tree_view_collapse_all");
  link(gtk_tree_view_collapse_row, "gtk_tree_view_collapse_row");
  link(gtk_tree_view_columns_autosize, "gtk_tree_view_columns_autosize");
  link(gtk_tree_view_convert_bin_window_to_tree_coords, "gtk_tree_view_convert_bin_window_to_tree_coords");
  link(gtk_tree_view_convert_bin_window_to_widget_coords, "gtk_tree_view_convert_bin_window_to_widget_coords");
  link(gtk_tree_view_convert_tree_to_bin_window_coords, "gtk_tree_view_convert_tree_to_bin_window_coords");
  link(gtk_tree_view_convert_tree_to_widget_coords, "gtk_tree_view_convert_tree_to_widget_coords");
  link(gtk_tree_view_convert_widget_to_bin_window_coords, "gtk_tree_view_convert_widget_to_bin_window_coords");
  link(gtk_tree_view_convert_widget_to_tree_coords, "gtk_tree_view_convert_widget_to_tree_coords");
  link(gtk_tree_view_create_row_drag_icon, "gtk_tree_view_create_row_drag_icon");
  link(gtk_tree_view_enable_model_drag_dest, "gtk_tree_view_enable_model_drag_dest");
  link(gtk_tree_view_enable_model_drag_source, "gtk_tree_view_enable_model_drag_source");
  link(gtk_tree_view_expand_all, "gtk_tree_view_expand_all");
  link(gtk_tree_view_expand_row, "gtk_tree_view_expand_row");
  link(gtk_tree_view_expand_to_path, "gtk_tree_view_expand_to_path");
  link(gtk_tree_view_get_activate_on_single_click, "gtk_tree_view_get_activate_on_single_click");
  link(gtk_tree_view_get_background_area, "gtk_tree_view_get_background_area");
  link(gtk_tree_view_get_cell_area, "gtk_tree_view_get_cell_area");
  link(gtk_tree_view_get_column, "gtk_tree_view_get_column");
  link(gtk_tree_view_get_columns, "gtk_tree_view_get_columns");
  link(gtk_tree_view_get_cursor, "gtk_tree_view_get_cursor");
  link(gtk_tree_view_get_dest_row_at_pos, "gtk_tree_view_get_dest_row_at_pos");
  link(gtk_tree_view_get_drag_dest_row, "gtk_tree_view_get_drag_dest_row");
  link(gtk_tree_view_get_enable_search, "gtk_tree_view_get_enable_search");
  link(gtk_tree_view_get_enable_tree_lines, "gtk_tree_view_get_enable_tree_lines");
  link(gtk_tree_view_get_expander_column, "gtk_tree_view_get_expander_column");
  link(gtk_tree_view_get_fixed_height_mode, "gtk_tree_view_get_fixed_height_mode");
  link(gtk_tree_view_get_grid_lines, "gtk_tree_view_get_grid_lines");
  link(gtk_tree_view_get_headers_clickable, "gtk_tree_view_get_headers_clickable");
  link(gtk_tree_view_get_headers_visible, "gtk_tree_view_get_headers_visible");
  link(gtk_tree_view_get_hover_expand, "gtk_tree_view_get_hover_expand");
  link(gtk_tree_view_get_hover_selection, "gtk_tree_view_get_hover_selection");
  link(gtk_tree_view_get_level_indentation, "gtk_tree_view_get_level_indentation");
  link(gtk_tree_view_get_model, "gtk_tree_view_get_model");
  link(gtk_tree_view_get_n_columns, "gtk_tree_view_get_n_columns");
  link(gtk_tree_view_get_path_at_pos, "gtk_tree_view_get_path_at_pos");
  link(gtk_tree_view_get_reorderable, "gtk_tree_view_get_reorderable");
  link(gtk_tree_view_get_row_separator_func, "gtk_tree_view_get_row_separator_func");
  link(gtk_tree_view_get_rubber_banding, "gtk_tree_view_get_rubber_banding");
  link(gtk_tree_view_get_search_column, "gtk_tree_view_get_search_column");
  link(gtk_tree_view_get_search_entry, "gtk_tree_view_get_search_entry");
  link(gtk_tree_view_get_search_equal_func, "gtk_tree_view_get_search_equal_func");
  link(gtk_tree_view_get_selection, "gtk_tree_view_get_selection");
  link(gtk_tree_view_get_show_expanders, "gtk_tree_view_get_show_expanders");
  link(gtk_tree_view_get_tooltip_column, "gtk_tree_view_get_tooltip_column");
  link(gtk_tree_view_get_tooltip_context, "gtk_tree_view_get_tooltip_context");
  link(gtk_tree_view_get_visible_range, "gtk_tree_view_get_visible_range");
  link(gtk_tree_view_get_visible_rect, "gtk_tree_view_get_visible_rect");
  link(gtk_tree_view_insert_column, "gtk_tree_view_insert_column");
  link(gtk_tree_view_insert_column_with_attributes, "gtk_tree_view_insert_column_with_attributes");
  link(gtk_tree_view_insert_column_with_data_func, "gtk_tree_view_insert_column_with_data_func");
  link(gtk_tree_view_is_blank_at_pos, "gtk_tree_view_is_blank_at_pos");
  link(gtk_tree_view_is_rubber_banding_active, "gtk_tree_view_is_rubber_banding_active");
  link(gtk_tree_view_map_expanded_rows, "gtk_tree_view_map_expanded_rows");
  link(gtk_tree_view_move_column_after, "gtk_tree_view_move_column_after");
  link(gtk_tree_view_remove_column, "gtk_tree_view_remove_column");
  link(gtk_tree_view_row_activated, "gtk_tree_view_row_activated");
  link(gtk_tree_view_row_expanded, "gtk_tree_view_row_expanded");
  link(gtk_tree_view_scroll_to_cell, "gtk_tree_view_scroll_to_cell");
  link(gtk_tree_view_scroll_to_point, "gtk_tree_view_scroll_to_point");
  link(gtk_tree_view_set_activate_on_single_click, "gtk_tree_view_set_activate_on_single_click");
  link(gtk_tree_view_set_column_drag_function, "gtk_tree_view_set_column_drag_function");
  link(gtk_tree_view_set_cursor, "gtk_tree_view_set_cursor");
  link(gtk_tree_view_set_cursor_on_cell, "gtk_tree_view_set_cursor_on_cell");
  link(gtk_tree_view_set_drag_dest_row, "gtk_tree_view_set_drag_dest_row");
  link(gtk_tree_view_set_enable_search, "gtk_tree_view_set_enable_search");
  link(gtk_tree_view_set_enable_tree_lines, "gtk_tree_view_set_enable_tree_lines");
  link(gtk_tree_view_set_expander_column, "gtk_tree_view_set_expander_column");
  link(gtk_tree_view_set_fixed_height_mode, "gtk_tree_view_set_fixed_height_mode");
  link(gtk_tree_view_set_grid_lines, "gtk_tree_view_set_grid_lines");
  link(gtk_tree_view_set_headers_clickable, "gtk_tree_view_set_headers_clickable");
  link(gtk_tree_view_set_headers_visible, "gtk_tree_view_set_headers_visible");
  link(gtk_tree_view_set_hover_expand, "gtk_tree_view_set_hover_expand");
  link(gtk_tree_view_set_hover_selection, "gtk_tree_view_set_hover_selection");
  link(gtk_tree_view_set_level_indentation, "gtk_tree_view_set_level_indentation");
  link(gtk_tree_view_set_model, "gtk_tree_view_set_model");
  link(gtk_tree_view_set_reorderable, "gtk_tree_view_set_reorderable");
  link(gtk_tree_view_set_row_separator_func, "gtk_tree_view_set_row_separator_func");
  link(gtk_tree_view_set_rubber_banding, "gtk_tree_view_set_rubber_banding");
  link(gtk_tree_view_set_search_column, "gtk_tree_view_set_search_column");
  link(gtk_tree_view_set_search_entry, "gtk_tree_view_set_search_entry");
  link(gtk_tree_view_set_search_equal_func, "gtk_tree_view_set_search_equal_func");
  link(gtk_tree_view_set_show_expanders, "gtk_tree_view_set_show_expanders");
  link(gtk_tree_view_set_tooltip_cell, "gtk_tree_view_set_tooltip_cell");
  link(gtk_tree_view_set_tooltip_column, "gtk_tree_view_set_tooltip_column");
  link(gtk_tree_view_set_tooltip_row, "gtk_tree_view_set_tooltip_row");
  link(gtk_tree_view_unset_rows_drag_dest, "gtk_tree_view_unset_rows_drag_dest");
  link(gtk_tree_view_unset_rows_drag_source, "gtk_tree_view_unset_rows_drag_source");

  // TreeViewColumn
  link(gtk_tree_view_column_get_type, "gtk_tree_view_column_get_type");
  link(gtk_tree_view_column_new, "gtk_tree_view_column_new");
  link(gtk_tree_view_column_new_with_area, "gtk_tree_view_column_new_with_area");
  link(gtk_tree_view_column_new_with_attributes, "gtk_tree_view_column_new_with_attributes");
  link(gtk_tree_view_column_add_attribute, "gtk_tree_view_column_add_attribute");
  link(gtk_tree_view_column_cell_get_position, "gtk_tree_view_column_cell_get_position");
  link(gtk_tree_view_column_cell_get_size, "gtk_tree_view_column_cell_get_size");
  link(gtk_tree_view_column_cell_is_visible, "gtk_tree_view_column_cell_is_visible");
  link(gtk_tree_view_column_cell_set_cell_data, "gtk_tree_view_column_cell_set_cell_data");
  link(gtk_tree_view_column_clear, "gtk_tree_view_column_clear");
  link(gtk_tree_view_column_clear_attributes, "gtk_tree_view_column_clear_attributes");
  link(gtk_tree_view_column_clicked, "gtk_tree_view_column_clicked");
  link(gtk_tree_view_column_focus_cell, "gtk_tree_view_column_focus_cell");
  link(gtk_tree_view_column_get_alignment, "gtk_tree_view_column_get_alignment");
  link(gtk_tree_view_column_get_button, "gtk_tree_view_column_get_button");
  link(gtk_tree_view_column_get_clickable, "gtk_tree_view_column_get_clickable");
  link(gtk_tree_view_column_get_expand, "gtk_tree_view_column_get_expand");
  link(gtk_tree_view_column_get_fixed_width, "gtk_tree_view_column_get_fixed_width");
  link(gtk_tree_view_column_get_max_width, "gtk_tree_view_column_get_max_width");
  link(gtk_tree_view_column_get_min_width, "gtk_tree_view_column_get_min_width");
  link(gtk_tree_view_column_get_reorderable, "gtk_tree_view_column_get_reorderable");
  link(gtk_tree_view_column_get_resizable, "gtk_tree_view_column_get_resizable");
  link(gtk_tree_view_column_get_sizing, "gtk_tree_view_column_get_sizing");
  link(gtk_tree_view_column_get_sort_column_id, "gtk_tree_view_column_get_sort_column_id");
  link(gtk_tree_view_column_get_sort_indicator, "gtk_tree_view_column_get_sort_indicator");
  link(gtk_tree_view_column_get_sort_order, "gtk_tree_view_column_get_sort_order");
  link(gtk_tree_view_column_get_spacing, "gtk_tree_view_column_get_spacing");
  link(gtk_tree_view_column_get_title, "gtk_tree_view_column_get_title");
  link(gtk_tree_view_column_get_tree_view, "gtk_tree_view_column_get_tree_view");
  link(gtk_tree_view_column_get_visible, "gtk_tree_view_column_get_visible");
  link(gtk_tree_view_column_get_widget, "gtk_tree_view_column_get_widget");
  link(gtk_tree_view_column_get_width, "gtk_tree_view_column_get_width");
  link(gtk_tree_view_column_get_x_offset, "gtk_tree_view_column_get_x_offset");
  link(gtk_tree_view_column_pack_end, "gtk_tree_view_column_pack_end");
  link(gtk_tree_view_column_pack_start, "gtk_tree_view_column_pack_start");
  link(gtk_tree_view_column_queue_resize, "gtk_tree_view_column_queue_resize");
  link(gtk_tree_view_column_set_alignment, "gtk_tree_view_column_set_alignment");
  link(gtk_tree_view_column_set_attributes, "gtk_tree_view_column_set_attributes");
  link(gtk_tree_view_column_set_cell_data_func, "gtk_tree_view_column_set_cell_data_func");
  link(gtk_tree_view_column_set_clickable, "gtk_tree_view_column_set_clickable");
  link(gtk_tree_view_column_set_expand, "gtk_tree_view_column_set_expand");
  link(gtk_tree_view_column_set_fixed_width, "gtk_tree_view_column_set_fixed_width");
  link(gtk_tree_view_column_set_max_width, "gtk_tree_view_column_set_max_width");
  link(gtk_tree_view_column_set_min_width, "gtk_tree_view_column_set_min_width");
  link(gtk_tree_view_column_set_reorderable, "gtk_tree_view_column_set_reorderable");
  link(gtk_tree_view_column_set_resizable, "gtk_tree_view_column_set_resizable");
  link(gtk_tree_view_column_set_sizing, "gtk_tree_view_column_set_sizing");
  link(gtk_tree_view_column_set_sort_column_id, "gtk_tree_view_column_set_sort_column_id");
  link(gtk_tree_view_column_set_sort_indicator, "gtk_tree_view_column_set_sort_indicator");
  link(gtk_tree_view_column_set_sort_order, "gtk_tree_view_column_set_sort_order");
  link(gtk_tree_view_column_set_spacing, "gtk_tree_view_column_set_spacing");
  link(gtk_tree_view_column_set_title, "gtk_tree_view_column_set_title");
  link(gtk_tree_view_column_set_visible, "gtk_tree_view_column_set_visible");
  link(gtk_tree_view_column_set_widget, "gtk_tree_view_column_set_widget");

  // UriLauncher
  link(gtk_uri_launcher_get_type, "gtk_uri_launcher_get_type");
  link(gtk_uri_launcher_new, "gtk_uri_launcher_new");
  link(gtk_uri_launcher_get_uri, "gtk_uri_launcher_get_uri");
  link(gtk_uri_launcher_launch, "gtk_uri_launcher_launch");
  link(gtk_uri_launcher_launch_finish, "gtk_uri_launcher_launch_finish");
  link(gtk_uri_launcher_set_uri, "gtk_uri_launcher_set_uri");

  // Video
  link(gtk_video_get_type, "gtk_video_get_type");
  link(gtk_video_new, "gtk_video_new");
  link(gtk_video_new_for_file, "gtk_video_new_for_file");
  link(gtk_video_new_for_filename, "gtk_video_new_for_filename");
  link(gtk_video_new_for_media_stream, "gtk_video_new_for_media_stream");
  link(gtk_video_new_for_resource, "gtk_video_new_for_resource");
  link(gtk_video_get_autoplay, "gtk_video_get_autoplay");
  link(gtk_video_get_file, "gtk_video_get_file");
  link(gtk_video_get_graphics_offload, "gtk_video_get_graphics_offload");
  link(gtk_video_get_loop, "gtk_video_get_loop");
  link(gtk_video_get_media_stream, "gtk_video_get_media_stream");
  link(gtk_video_set_autoplay, "gtk_video_set_autoplay");
  link(gtk_video_set_file, "gtk_video_set_file");
  link(gtk_video_set_filename, "gtk_video_set_filename");
  link(gtk_video_set_graphics_offload, "gtk_video_set_graphics_offload");
  link(gtk_video_set_loop, "gtk_video_set_loop");
  link(gtk_video_set_media_stream, "gtk_video_set_media_stream");
  link(gtk_video_set_resource, "gtk_video_set_resource");

  // Viewport
  link(gtk_viewport_get_type, "gtk_viewport_get_type");
  link(gtk_viewport_new, "gtk_viewport_new");
  link(gtk_viewport_get_child, "gtk_viewport_get_child");
  link(gtk_viewport_get_scroll_to_focus, "gtk_viewport_get_scroll_to_focus");
  link(gtk_viewport_scroll_to, "gtk_viewport_scroll_to");
  link(gtk_viewport_set_child, "gtk_viewport_set_child");
  link(gtk_viewport_set_scroll_to_focus, "gtk_viewport_set_scroll_to_focus");

  // VolumeButton
  link(gtk_volume_button_get_type, "gtk_volume_button_get_type");
  link(gtk_volume_button_new, "gtk_volume_button_new");

  // Widget
  link(gtk_widget_get_type, "gtk_widget_get_type");
  link(gtk_widget_get_default_direction, "gtk_widget_get_default_direction");
  link(gtk_widget_set_default_direction, "gtk_widget_set_default_direction");
  link(gtk_widget_action_set_enabled, "gtk_widget_action_set_enabled");
  link(gtk_widget_activate, "gtk_widget_activate");
  link(gtk_widget_activate_action, "gtk_widget_activate_action");
  link(gtk_widget_activate_action_variant, "gtk_widget_activate_action_variant");
  link(gtk_widget_activate_default, "gtk_widget_activate_default");
  link(gtk_widget_add_controller, "gtk_widget_add_controller");
  link(gtk_widget_add_css_class, "gtk_widget_add_css_class");
  link(gtk_widget_add_mnemonic_label, "gtk_widget_add_mnemonic_label");
  link(gtk_widget_add_tick_callback, "gtk_widget_add_tick_callback");
  link(gtk_widget_allocate, "gtk_widget_allocate");
  link(gtk_widget_child_focus, "gtk_widget_child_focus");
  link(gtk_widget_compute_bounds, "gtk_widget_compute_bounds");
  link(gtk_widget_compute_expand, "gtk_widget_compute_expand");
  link(gtk_widget_compute_point, "gtk_widget_compute_point");
  link(gtk_widget_compute_transform, "gtk_widget_compute_transform");
  link(gtk_widget_contains, "gtk_widget_contains");
  link(gtk_widget_create_pango_context, "gtk_widget_create_pango_context");
  link(gtk_widget_create_pango_layout, "gtk_widget_create_pango_layout");
  link(gtk_widget_dispose_template, "gtk_widget_dispose_template");
  link(gtk_drag_check_threshold, "gtk_drag_check_threshold");
  link(gtk_widget_error_bell, "gtk_widget_error_bell");
  link(gtk_widget_get_allocated_baseline, "gtk_widget_get_allocated_baseline");
  link(gtk_widget_get_allocated_height, "gtk_widget_get_allocated_height");
  link(gtk_widget_get_allocated_width, "gtk_widget_get_allocated_width");
  link(gtk_widget_get_allocation, "gtk_widget_get_allocation");
  link(gtk_widget_get_ancestor, "gtk_widget_get_ancestor");
  link(gtk_widget_get_baseline, "gtk_widget_get_baseline");
  link(gtk_widget_get_can_focus, "gtk_widget_get_can_focus");
  link(gtk_widget_get_can_target, "gtk_widget_get_can_target");
  link(gtk_widget_get_child_visible, "gtk_widget_get_child_visible");
  link(gtk_widget_get_clipboard, "gtk_widget_get_clipboard");
  link(gtk_widget_get_color, "gtk_widget_get_color");
  link(gtk_widget_get_css_classes, "gtk_widget_get_css_classes");
  link(gtk_widget_get_css_name, "gtk_widget_get_css_name");
  link(gtk_widget_get_cursor, "gtk_widget_get_cursor");
  link(gtk_widget_get_direction, "gtk_widget_get_direction");
  link(gtk_widget_get_display, "gtk_widget_get_display");
  link(gtk_widget_get_first_child, "gtk_widget_get_first_child");
  link(gtk_widget_get_focus_child, "gtk_widget_get_focus_child");
  link(gtk_widget_get_focus_on_click, "gtk_widget_get_focus_on_click");
  link(gtk_widget_get_focusable, "gtk_widget_get_focusable");
  link(gtk_widget_get_font_map, "gtk_widget_get_font_map");
  link(gtk_widget_get_font_options, "gtk_widget_get_font_options");
  link(gtk_widget_get_frame_clock, "gtk_widget_get_frame_clock");
  link(gtk_widget_get_halign, "gtk_widget_get_halign");
  link(gtk_widget_get_has_tooltip, "gtk_widget_get_has_tooltip");
  link(gtk_widget_get_height, "gtk_widget_get_height");
  link(gtk_widget_get_hexpand, "gtk_widget_get_hexpand");
  link(gtk_widget_get_hexpand_set, "gtk_widget_get_hexpand_set");
  link(gtk_widget_get_last_child, "gtk_widget_get_last_child");
  link(gtk_widget_get_layout_manager, "gtk_widget_get_layout_manager");
  link(gtk_widget_get_mapped, "gtk_widget_get_mapped");
  link(gtk_widget_get_margin_bottom, "gtk_widget_get_margin_bottom");
  link(gtk_widget_get_margin_end, "gtk_widget_get_margin_end");
  link(gtk_widget_get_margin_start, "gtk_widget_get_margin_start");
  link(gtk_widget_get_margin_top, "gtk_widget_get_margin_top");
  link(gtk_widget_get_name, "gtk_widget_get_name");
  link(gtk_widget_get_native, "gtk_widget_get_native");
  link(gtk_widget_get_next_sibling, "gtk_widget_get_next_sibling");
  link(gtk_widget_get_opacity, "gtk_widget_get_opacity");
  link(gtk_widget_get_overflow, "gtk_widget_get_overflow");
  link(gtk_widget_get_pango_context, "gtk_widget_get_pango_context");
  link(gtk_widget_get_parent, "gtk_widget_get_parent");
  link(gtk_widget_get_preferred_size, "gtk_widget_get_preferred_size");
  link(gtk_widget_get_prev_sibling, "gtk_widget_get_prev_sibling");
  link(gtk_widget_get_primary_clipboard, "gtk_widget_get_primary_clipboard");
  link(gtk_widget_get_realized, "gtk_widget_get_realized");
  link(gtk_widget_get_receives_default, "gtk_widget_get_receives_default");
  link(gtk_widget_get_request_mode, "gtk_widget_get_request_mode");
  link(gtk_widget_get_root, "gtk_widget_get_root");
  link(gtk_widget_get_scale_factor, "gtk_widget_get_scale_factor");
  link(gtk_widget_get_sensitive, "gtk_widget_get_sensitive");
  link(gtk_widget_get_settings, "gtk_widget_get_settings");
  link(gtk_widget_get_size, "gtk_widget_get_size");
  link(gtk_widget_get_size_request, "gtk_widget_get_size_request");
  link(gtk_widget_get_state_flags, "gtk_widget_get_state_flags");
  link(gtk_widget_get_style_context, "gtk_widget_get_style_context");
  link(gtk_widget_get_template_child, "gtk_widget_get_template_child");
  link(gtk_widget_get_tooltip_markup, "gtk_widget_get_tooltip_markup");
  link(gtk_widget_get_tooltip_text, "gtk_widget_get_tooltip_text");
  link(gtk_widget_get_valign, "gtk_widget_get_valign");
  link(gtk_widget_get_vexpand, "gtk_widget_get_vexpand");
  link(gtk_widget_get_vexpand_set, "gtk_widget_get_vexpand_set");
  link(gtk_widget_get_visible, "gtk_widget_get_visible");
  link(gtk_widget_get_width, "gtk_widget_get_width");
  link(gtk_widget_grab_focus, "gtk_widget_grab_focus");
  link(gtk_widget_has_css_class, "gtk_widget_has_css_class");
  link(gtk_widget_has_default, "gtk_widget_has_default");
  link(gtk_widget_has_focus, "gtk_widget_has_focus");
  link(gtk_widget_has_visible_focus, "gtk_widget_has_visible_focus");
  link(gtk_widget_hide, "gtk_widget_hide");
  link(gtk_widget_in_destruction, "gtk_widget_in_destruction");
  link(gtk_widget_init_template, "gtk_widget_init_template");
  link(gtk_widget_insert_action_group, "gtk_widget_insert_action_group");
  link(gtk_widget_insert_after, "gtk_widget_insert_after");
  link(gtk_widget_insert_before, "gtk_widget_insert_before");
  link(gtk_widget_is_ancestor, "gtk_widget_is_ancestor");
  link(gtk_widget_is_drawable, "gtk_widget_is_drawable");
  link(gtk_widget_is_focus, "gtk_widget_is_focus");
  link(gtk_widget_is_sensitive, "gtk_widget_is_sensitive");
  link(gtk_widget_is_visible, "gtk_widget_is_visible");
  link(gtk_widget_keynav_failed, "gtk_widget_keynav_failed");
  link(gtk_widget_list_mnemonic_labels, "gtk_widget_list_mnemonic_labels");
  link(gtk_widget_map, "gtk_widget_map");
  link(gtk_widget_measure, "gtk_widget_measure");
  link(gtk_widget_mnemonic_activate, "gtk_widget_mnemonic_activate");
  link(gtk_widget_observe_children, "gtk_widget_observe_children");
  link(gtk_widget_observe_controllers, "gtk_widget_observe_controllers");
  link(gtk_widget_pick, "gtk_widget_pick");
  link(gtk_widget_queue_allocate, "gtk_widget_queue_allocate");
  link(gtk_widget_queue_draw, "gtk_widget_queue_draw");
  link(gtk_widget_queue_resize, "gtk_widget_queue_resize");
  link(gtk_widget_realize, "gtk_widget_realize");
  link(gtk_widget_remove_controller, "gtk_widget_remove_controller");
  link(gtk_widget_remove_css_class, "gtk_widget_remove_css_class");
  link(gtk_widget_remove_mnemonic_label, "gtk_widget_remove_mnemonic_label");
  link(gtk_widget_remove_tick_callback, "gtk_widget_remove_tick_callback");
  link(gtk_widget_set_can_focus, "gtk_widget_set_can_focus");
  link(gtk_widget_set_can_target, "gtk_widget_set_can_target");
  link(gtk_widget_set_child_visible, "gtk_widget_set_child_visible");
  link(gtk_widget_set_css_classes, "gtk_widget_set_css_classes");
  link(gtk_widget_set_cursor, "gtk_widget_set_cursor");
  link(gtk_widget_set_cursor_from_name, "gtk_widget_set_cursor_from_name");
  link(gtk_widget_set_direction, "gtk_widget_set_direction");
  link(gtk_widget_set_focus_child, "gtk_widget_set_focus_child");
  link(gtk_widget_set_focus_on_click, "gtk_widget_set_focus_on_click");
  link(gtk_widget_set_focusable, "gtk_widget_set_focusable");
  link(gtk_widget_set_font_map, "gtk_widget_set_font_map");
  link(gtk_widget_set_font_options, "gtk_widget_set_font_options");
  link(gtk_widget_set_halign, "gtk_widget_set_halign");
  link(gtk_widget_set_has_tooltip, "gtk_widget_set_has_tooltip");
  link(gtk_widget_set_hexpand, "gtk_widget_set_hexpand");
  link(gtk_widget_set_hexpand_set, "gtk_widget_set_hexpand_set");
  link(gtk_widget_set_layout_manager, "gtk_widget_set_layout_manager");
  link(gtk_widget_set_margin_bottom, "gtk_widget_set_margin_bottom");
  link(gtk_widget_set_margin_end, "gtk_widget_set_margin_end");
  link(gtk_widget_set_margin_start, "gtk_widget_set_margin_start");
  link(gtk_widget_set_margin_top, "gtk_widget_set_margin_top");
  link(gtk_widget_set_name, "gtk_widget_set_name");
  link(gtk_widget_set_opacity, "gtk_widget_set_opacity");
  link(gtk_widget_set_overflow, "gtk_widget_set_overflow");
  link(gtk_widget_set_parent, "gtk_widget_set_parent");
  link(gtk_widget_set_receives_default, "gtk_widget_set_receives_default");
  link(gtk_widget_set_sensitive, "gtk_widget_set_sensitive");
  link(gtk_widget_set_size_request, "gtk_widget_set_size_request");
  link(gtk_widget_set_state_flags, "gtk_widget_set_state_flags");
  link(gtk_widget_set_tooltip_markup, "gtk_widget_set_tooltip_markup");
  link(gtk_widget_set_tooltip_text, "gtk_widget_set_tooltip_text");
  link(gtk_widget_set_valign, "gtk_widget_set_valign");
  link(gtk_widget_set_vexpand, "gtk_widget_set_vexpand");
  link(gtk_widget_set_vexpand_set, "gtk_widget_set_vexpand_set");
  link(gtk_widget_set_visible, "gtk_widget_set_visible");
  link(gtk_widget_should_layout, "gtk_widget_should_layout");
  link(gtk_widget_show, "gtk_widget_show");
  link(gtk_widget_size_allocate, "gtk_widget_size_allocate");
  link(gtk_widget_snapshot_child, "gtk_widget_snapshot_child");
  link(gtk_widget_translate_coordinates, "gtk_widget_translate_coordinates");
  link(gtk_widget_trigger_tooltip_query, "gtk_widget_trigger_tooltip_query");
  link(gtk_widget_unmap, "gtk_widget_unmap");
  link(gtk_widget_unparent, "gtk_widget_unparent");
  link(gtk_widget_unrealize, "gtk_widget_unrealize");
  link(gtk_widget_unset_state_flags, "gtk_widget_unset_state_flags");

  // WidgetClass
  link(gtk_widget_class_add_binding, "gtk_widget_class_add_binding");
  link(gtk_widget_class_add_binding_action, "gtk_widget_class_add_binding_action");
  link(gtk_widget_class_add_binding_signal, "gtk_widget_class_add_binding_signal");
  link(gtk_widget_class_add_shortcut, "gtk_widget_class_add_shortcut");
  link(gtk_widget_class_bind_template_callback_full, "gtk_widget_class_bind_template_callback_full");
  link(gtk_widget_class_bind_template_child_full, "gtk_widget_class_bind_template_child_full");
  link(gtk_widget_class_get_accessible_role, "gtk_widget_class_get_accessible_role");
  link(gtk_widget_class_get_activate_signal, "gtk_widget_class_get_activate_signal");
  link(gtk_widget_class_get_css_name, "gtk_widget_class_get_css_name");
  link(gtk_widget_class_get_layout_manager_type, "gtk_widget_class_get_layout_manager_type");
  link(gtk_widget_class_install_action, "gtk_widget_class_install_action");
  link(gtk_widget_class_install_property_action, "gtk_widget_class_install_property_action");
  link(gtk_widget_class_query_action, "gtk_widget_class_query_action");
  link(gtk_widget_class_set_accessible_role, "gtk_widget_class_set_accessible_role");
  link(gtk_widget_class_set_activate_signal, "gtk_widget_class_set_activate_signal");
  link(gtk_widget_class_set_activate_signal_from_name, "gtk_widget_class_set_activate_signal_from_name");
  link(gtk_widget_class_set_css_name, "gtk_widget_class_set_css_name");
  link(gtk_widget_class_set_layout_manager_type, "gtk_widget_class_set_layout_manager_type");
  link(gtk_widget_class_set_template, "gtk_widget_class_set_template");
  link(gtk_widget_class_set_template_from_resource, "gtk_widget_class_set_template_from_resource");
  link(gtk_widget_class_set_template_scope, "gtk_widget_class_set_template_scope");

  // WidgetPaintable
  link(gtk_widget_paintable_get_type, "gtk_widget_paintable_get_type");
  link(gtk_widget_paintable_new, "gtk_widget_paintable_new");
  link(gtk_widget_paintable_get_widget, "gtk_widget_paintable_get_widget");
  link(gtk_widget_paintable_set_widget, "gtk_widget_paintable_set_widget");

  // Window
  link(gtk_window_get_type, "gtk_window_get_type");
  link(gtk_window_new, "gtk_window_new");
  link(gtk_window_get_default_icon_name, "gtk_window_get_default_icon_name");
  link(gtk_window_get_toplevels, "gtk_window_get_toplevels");
  link(gtk_window_list_toplevels, "gtk_window_list_toplevels");
  link(gtk_window_set_auto_startup_notification, "gtk_window_set_auto_startup_notification");
  link(gtk_window_set_default_icon_name, "gtk_window_set_default_icon_name");
  link(gtk_window_set_interactive_debugging, "gtk_window_set_interactive_debugging");
  link(gtk_window_close, "gtk_window_close");
  link(gtk_window_destroy, "gtk_window_destroy");
  link(gtk_window_fullscreen, "gtk_window_fullscreen");
  link(gtk_window_fullscreen_on_monitor, "gtk_window_fullscreen_on_monitor");
  link(gtk_window_get_application, "gtk_window_get_application");
  link(gtk_window_get_child, "gtk_window_get_child");
  link(gtk_window_get_decorated, "gtk_window_get_decorated");
  link(gtk_window_get_default_size, "gtk_window_get_default_size");
  link(gtk_window_get_default_widget, "gtk_window_get_default_widget");
  link(gtk_window_get_deletable, "gtk_window_get_deletable");
  link(gtk_window_get_destroy_with_parent, "gtk_window_get_destroy_with_parent");
  link(gtk_window_get_focus, "gtk_window_get_focus");
  link(gtk_window_get_focus_visible, "gtk_window_get_focus_visible");
  link(gtk_window_get_group, "gtk_window_get_group");
  link(gtk_window_get_handle_menubar_accel, "gtk_window_get_handle_menubar_accel");
  link(gtk_window_get_hide_on_close, "gtk_window_get_hide_on_close");
  link(gtk_window_get_icon_name, "gtk_window_get_icon_name");
  link(gtk_window_get_mnemonics_visible, "gtk_window_get_mnemonics_visible");
  link(gtk_window_get_modal, "gtk_window_get_modal");
  link(gtk_window_get_resizable, "gtk_window_get_resizable");
  link(gtk_window_get_title, "gtk_window_get_title");
  link(gtk_window_get_titlebar, "gtk_window_get_titlebar");
  link(gtk_window_get_transient_for, "gtk_window_get_transient_for");
  link(gtk_window_has_group, "gtk_window_has_group");
  link(gtk_window_is_active, "gtk_window_is_active");
  link(gtk_window_is_fullscreen, "gtk_window_is_fullscreen");
  link(gtk_window_is_maximized, "gtk_window_is_maximized");
  link(gtk_window_is_suspended, "gtk_window_is_suspended");
  link(gtk_window_maximize, "gtk_window_maximize");
  link(gtk_window_minimize, "gtk_window_minimize");
  link(gtk_window_present, "gtk_window_present");
  link(gtk_window_present_with_time, "gtk_window_present_with_time");
  link(gtk_window_set_application, "gtk_window_set_application");
  link(gtk_window_set_child, "gtk_window_set_child");
  link(gtk_window_set_decorated, "gtk_window_set_decorated");
  link(gtk_window_set_default_size, "gtk_window_set_default_size");
  link(gtk_window_set_default_widget, "gtk_window_set_default_widget");
  link(gtk_window_set_deletable, "gtk_window_set_deletable");
  link(gtk_window_set_destroy_with_parent, "gtk_window_set_destroy_with_parent");
  link(gtk_window_set_display, "gtk_window_set_display");
  link(gtk_window_set_focus, "gtk_window_set_focus");
  link(gtk_window_set_focus_visible, "gtk_window_set_focus_visible");
  link(gtk_window_set_handle_menubar_accel, "gtk_window_set_handle_menubar_accel");
  link(gtk_window_set_hide_on_close, "gtk_window_set_hide_on_close");
  link(gtk_window_set_icon_name, "gtk_window_set_icon_name");
  link(gtk_window_set_mnemonics_visible, "gtk_window_set_mnemonics_visible");
  link(gtk_window_set_modal, "gtk_window_set_modal");
  link(gtk_window_set_resizable, "gtk_window_set_resizable");
  link(gtk_window_set_startup_id, "gtk_window_set_startup_id");
  link(gtk_window_set_title, "gtk_window_set_title");
  link(gtk_window_set_titlebar, "gtk_window_set_titlebar");
  link(gtk_window_set_transient_for, "gtk_window_set_transient_for");
  link(gtk_window_unfullscreen, "gtk_window_unfullscreen");
  link(gtk_window_unmaximize, "gtk_window_unmaximize");
  link(gtk_window_unminimize, "gtk_window_unminimize");

  // WindowControls
  link(gtk_window_controls_get_type, "gtk_window_controls_get_type");
  link(gtk_window_controls_new, "gtk_window_controls_new");
  link(gtk_window_controls_get_decoration_layout, "gtk_window_controls_get_decoration_layout");
  link(gtk_window_controls_get_empty, "gtk_window_controls_get_empty");
  link(gtk_window_controls_get_side, "gtk_window_controls_get_side");
  link(gtk_window_controls_set_decoration_layout, "gtk_window_controls_set_decoration_layout");
  link(gtk_window_controls_set_side, "gtk_window_controls_set_side");

  // WindowGroup
  link(gtk_window_group_get_type, "gtk_window_group_get_type");
  link(gtk_window_group_new, "gtk_window_group_new");
  link(gtk_window_group_add_window, "gtk_window_group_add_window");
  link(gtk_window_group_list_windows, "gtk_window_group_list_windows");
  link(gtk_window_group_remove_window, "gtk_window_group_remove_window");

  // WindowHandle
  link(gtk_window_handle_get_type, "gtk_window_handle_get_type");
  link(gtk_window_handle_new, "gtk_window_handle_new");
  link(gtk_window_handle_get_child, "gtk_window_handle_get_child");
  link(gtk_window_handle_set_child, "gtk_window_handle_set_child");
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
