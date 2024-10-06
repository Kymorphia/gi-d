module Gtk.Notebook;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.NotebookPage;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkNotebook` is a container whose children are pages switched
 * between using tabs.
 * ![An example GtkNotebook](notebook.png)
 * There are many configuration options for `GtkNotebook`. Among
 * other things, you can choose on which edge the tabs appear
 * $(LPAREN)see [Gtk.Notebook.setTabPos]$(RPAREN), whether, if there are
 * too many tabs to fit the notebook should be made bigger or scrolling
 * arrows added $(LPAREN)see [Gtk.Notebook.setScrollable]$(RPAREN), and whether
 * there will be a popup menu allowing the users to switch pages.
 * $(LPAREN)see [Gtk.Notebook.popupEnable]$(RPAREN).
 * # GtkNotebook as GtkBuildable
 * The `GtkNotebook` implementation of the `GtkBuildable` interface
 * supports placing children into tabs by specifying “tab” as the
 * “type” attribute of a `<child>` element. Note that the content
 * of the tab must be created before the tab can be filled.
 * A tab child can be specified without specifying a `<child>`
 * type attribute.
 * To add a child widget in the notebooks action area, specify
 * "action-start" or “action-end” as the “type” attribute of the
 * `<child>` element.
 * An example of a UI definition fragment with `GtkNotebook`:
 * ```xml
 * <object class\="GtkNotebook">
 * <child>
 * <object class\="GtkLabel" id\="notebook-content">
 * <property name\="label">Content</property>
 * </object>
 * </child>
 * <child type\="tab">
 * <object class\="GtkLabel" id\="notebook-tab">
 * <property name\="label">Tab</property>
 * </object>
 * </child>
 * </object>
 * ```
 * # CSS nodes
 * ```
 * notebook
 * ├── header.top
 * │   ├── [<action widget>]
 * │   ├── tabs
 * │   │   ├── [arrow]
 * │   │   ├── tab
 * │   │   │   ╰── <tab label>
 * ┊   ┊   ┊
 * │   │   ├── tab[.reorderable-page]
 * │   │   │   ╰── <tab label>
 * │   │   ╰── [arrow]
 * │   ╰── [<action widget>]
 * │
 * ╰── stack
 * ├── <child>
 * ┊
 * ╰── <child>
 * ```
 * `GtkNotebook` has a main CSS node with name `notebook`, a subnode
 * with name `header` and below that a subnode with name `tabs` which
 * contains one subnode per tab with name `tab`.
 * If action widgets are present, their CSS nodes are placed next
 * to the `tabs` node. If the notebook is scrollable, CSS nodes with
 * name `arrow` are placed as first and last child of the `tabs` node.
 * The main node gets the `.frame` style class when the notebook
 * has a border $(LPAREN)see [Gtk.Notebook.setShowBorder]$(RPAREN).
 * The header node gets one of the style class `.top`, `.bottom`,
 * `.left` or `.right`, depending on where the tabs are placed. For
 * reorderable pages, the tab node gets the `.reorderable-page` class.
 * A `tab` node gets the `.dnd` style class while it is moved with drag-and-drop.
 * The nodes are always arranged from left-to-right, regardless of text direction.
 * # Accessibility
 * `GtkNotebook` uses the following roles:
 * - %GTK_ACCESSIBLE_ROLE_GROUP for the notebook widget
 * - %GTK_ACCESSIBLE_ROLE_TAB_LIST for the list of tabs
 * - %GTK_ACCESSIBLE_ROLE_TAB role for each tab
 * - %GTK_ACCESSIBLE_ROLE_TAB_PANEL for each page
 */
class Notebook : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_notebook_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkNotebook` widget with no pages.
   * Returns: the newly created `GtkNotebook`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_new();
    this(_cretval, false);
  }

  /**
   * Appends a page to notebook.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the appended
   *   page in the notebook, or -1 if function fails
   */
  int appendPage(Widget child, Widget tabLabel)
  {
    int _retval;
    _retval = gtk_notebook_append_page(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null);
    return _retval;
  }

  /**
   * Appends a page to notebook, specifying the widget to use as the
   * label in the popup menu.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   *   menuLabel = the widget to use as a label for the
   *     page-switch menu, if that is enabled. If %NULL, and tab_label
   *     is a `GtkLabel` or %NULL, then the menu label will be a newly
   *     created label with the same text as tab_label; if tab_label
   *     is not a `GtkLabel`, menu_label must be specified if the
   *     page-switch menu is to be used.
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the appended
   *   page in the notebook, or -1 if function fails
   */
  int appendPageMenu(Widget child, Widget tabLabel, Widget menuLabel)
  {
    int _retval;
    _retval = gtk_notebook_append_page_menu(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null, menuLabel ? cast(GtkWidget*)menuLabel.cPtr(false) : null);
    return _retval;
  }

  /**
   * Removes the child from the notebook.
   * This function is very similar to [Gtk.Notebook.removePage],
   * but additionally informs the notebook that the removal
   * is happening as part of a tab DND operation, which should
   * not be cancelled.
   * Params:
   *   child = a child
   */
  void detachTab(Widget child)
  {
    gtk_notebook_detach_tab(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Gets one of the action widgets.
   * See [Gtk.Notebook.setActionWidget].
   * Params:
   *   packType = pack type of the action widget to receive
   * Returns: The action widget
   *   with the given pack_type or %NULL when this action
   *   widget has not been set
   */
  Widget getActionWidget(PackType packType)
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_get_action_widget(cast(GtkNotebook*)cPtr, packType);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the page number of the current page.
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the current
   *   page in the notebook. If the notebook has no pages,
   *   then -1 will be returned.
   */
  int getCurrentPage()
  {
    int _retval;
    _retval = gtk_notebook_get_current_page(cast(GtkNotebook*)cPtr);
    return _retval;
  }

  /**
   * Gets the current group name for notebook.
   * Returns: the group name,
   *   or %NULL if none is set
   */
  string getGroupName()
  {
    const(char)* _cretval;
    _cretval = gtk_notebook_get_group_name(cast(GtkNotebook*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the menu label widget of the page containing child.
   * Params:
   *   child = a widget contained in a page of notebook
   * Returns: the menu label, or %NULL
   *   if the notebook page does not have a menu label other than
   *   the default $(LPAREN)the tab label$(RPAREN).
   */
  Widget getMenuLabel(Widget child)
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_get_menu_label(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the text of the menu label for the page containing
   * child.
   * Params:
   *   child = the child widget of a page of the notebook.
   * Returns: the text of the tab label, or %NULL if
   *   the widget does not have a menu label other than the default
   *   menu label, or the menu label widget is not a `GtkLabel`.
   *   The string is owned by the widget and must not be freed.
   */
  string getMenuLabelText(Widget child)
  {
    const(char)* _cretval;
    _cretval = gtk_notebook_get_menu_label_text(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the number of pages in a notebook.
   * Returns: the number of pages in the notebook
   */
  int getNPages()
  {
    int _retval;
    _retval = gtk_notebook_get_n_pages(cast(GtkNotebook*)cPtr);
    return _retval;
  }

  /**
   * Returns the child widget contained in page number page_num.
   * Params:
   *   pageNum = the index of a page in the notebook, or -1
   *     to get the last page
   * Returns: the child widget, or %NULL if page_num
   *   is out of bounds
   */
  Widget getNthPage(int pageNum)
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_get_nth_page(cast(GtkNotebook*)cPtr, pageNum);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GtkNotebookPage` for child.
   * Params:
   *   child = a child of notebook
   * Returns: the `GtkNotebookPage` for child
   */
  NotebookPage getPage(Widget child)
  {
    GtkNotebookPage* _cretval;
    _cretval = gtk_notebook_get_page(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!NotebookPage(cast(GtkNotebookPage*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns a `GListModel` that contains the pages of the notebook.
   * This can be used to keep an up-to-date view. The model also
   * implements [Gtk.SelectionModel] and can be used to track
   * and modify the visible page.
   * Returns: a
   *   `GListModel` for the notebook's children
   */
  ListModel getPages()
  {
    GListModel* _cretval;
    _cretval = gtk_notebook_get_pages(cast(GtkNotebook*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether the tab label area has arrows for scrolling.
   * Returns: %TRUE if arrows for scrolling are present
   */
  bool getScrollable()
  {
    bool _retval;
    _retval = gtk_notebook_get_scrollable(cast(GtkNotebook*)cPtr);
    return _retval;
  }

  /**
   * Returns whether a bevel will be drawn around the notebook pages.
   * Returns: %TRUE if the bevel is drawn
   */
  bool getShowBorder()
  {
    bool _retval;
    _retval = gtk_notebook_get_show_border(cast(GtkNotebook*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the tabs of the notebook are shown.
   * Returns: %TRUE if the tabs are shown
   */
  bool getShowTabs()
  {
    bool _retval;
    _retval = gtk_notebook_get_show_tabs(cast(GtkNotebook*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the tab contents can be detached from notebook.
   * Params:
   *   child = a child `GtkWidget`
   * Returns: %TRUE if the tab is detachable.
   */
  bool getTabDetachable(Widget child)
  {
    bool _retval;
    _retval = gtk_notebook_get_tab_detachable(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the tab label widget for the page child.
   * %NULL is returned if child is not in notebook or
   * if no tab label has specifically been set for child.
   * Params:
   *   child = the page
   * Returns: the tab label
   */
  Widget getTabLabel(Widget child)
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_get_tab_label(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the text of the tab label for the page containing
   * child.
   * Params:
   *   child = a widget contained in a page of notebook
   * Returns: the text of the tab label, or %NULL if
   *   the tab label widget is not a `GtkLabel`. The string is owned
   *   by the widget and must not be freed.
   */
  string getTabLabelText(Widget child)
  {
    const(char)* _cretval;
    _cretval = gtk_notebook_get_tab_label_text(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the edge at which the tabs are drawn.
   * Returns: the edge at which the tabs are drawn
   */
  PositionType getTabPos()
  {
    GtkPositionType _cretval;
    _cretval = gtk_notebook_get_tab_pos(cast(GtkNotebook*)cPtr);
    PositionType _retval = cast(PositionType)_cretval;
    return _retval;
  }

  /**
   * Gets whether the tab can be reordered via drag and drop or not.
   * Params:
   *   child = a child `GtkWidget`
   * Returns: %TRUE if the tab is reorderable.
   */
  bool getTabReorderable(Widget child)
  {
    bool _retval;
    _retval = gtk_notebook_get_tab_reorderable(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    return _retval;
  }

  /**
   * Insert a page into notebook at the given position.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   *   position = the index $(LPAREN)starting at 0$(RPAREN) at which to insert the page,
   *     or -1 to append the page after all other pages
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the inserted
   *   page in the notebook, or -1 if function fails
   */
  int insertPage(Widget child, Widget tabLabel, int position)
  {
    int _retval;
    _retval = gtk_notebook_insert_page(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null, position);
    return _retval;
  }

  /**
   * Insert a page into notebook at the given position, specifying
   * the widget to use as the label in the popup menu.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   *   menuLabel = the widget to use as a label for the
   *     page-switch menu, if that is enabled. If %NULL, and tab_label
   *     is a `GtkLabel` or %NULL, then the menu label will be a newly
   *     created label with the same text as tab_label; if tab_label
   *     is not a `GtkLabel`, menu_label must be specified if the
   *     page-switch menu is to be used.
   *   position = the index $(LPAREN)starting at 0$(RPAREN) at which to insert the page,
   *     or -1 to append the page after all other pages.
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the inserted
   *   page in the notebook
   */
  int insertPageMenu(Widget child, Widget tabLabel, Widget menuLabel, int position)
  {
    int _retval;
    _retval = gtk_notebook_insert_page_menu(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null, menuLabel ? cast(GtkWidget*)menuLabel.cPtr(false) : null, position);
    return _retval;
  }

  /**
   * Switches to the next page.
   * Nothing happens if the current page is the last page.
   */
  void nextPage()
  {
    gtk_notebook_next_page(cast(GtkNotebook*)cPtr);
  }

  /**
   * Finds the index of the page which contains the given child
   * widget.
   * Params:
   *   child = a `GtkWidget`
   * Returns: the index of the page containing child, or
   *   -1 if child is not in the notebook
   */
  int pageNum(Widget child)
  {
    int _retval;
    _retval = gtk_notebook_page_num(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    return _retval;
  }

  /**
   * Disables the popup menu.
   */
  void popupDisable()
  {
    gtk_notebook_popup_disable(cast(GtkNotebook*)cPtr);
  }

  /**
   * Enables the popup menu.
   * If the user clicks with the right mouse button on the tab labels,
   * a menu with all the pages will be popped up.
   */
  void popupEnable()
  {
    gtk_notebook_popup_enable(cast(GtkNotebook*)cPtr);
  }

  /**
   * Prepends a page to notebook.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the prepended
   *   page in the notebook, or -1 if function fails
   */
  int prependPage(Widget child, Widget tabLabel)
  {
    int _retval;
    _retval = gtk_notebook_prepend_page(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null);
    return _retval;
  }

  /**
   * Prepends a page to notebook, specifying the widget to use as the
   * label in the popup menu.
   * Params:
   *   child = the `GtkWidget` to use as the contents of the page
   *   tabLabel = the `GtkWidget` to be used as the label
   *     for the page, or %NULL to use the default label, “page N”
   *   menuLabel = the widget to use as a label for the
   *     page-switch menu, if that is enabled. If %NULL, and tab_label
   *     is a `GtkLabel` or %NULL, then the menu label will be a newly
   *     created label with the same text as tab_label; if tab_label
   *     is not a `GtkLabel`, menu_label must be specified if the
   *     page-switch menu is to be used.
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the prepended
   *   page in the notebook, or -1 if function fails
   */
  int prependPageMenu(Widget child, Widget tabLabel, Widget menuLabel)
  {
    int _retval;
    _retval = gtk_notebook_prepend_page_menu(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null, menuLabel ? cast(GtkWidget*)menuLabel.cPtr(false) : null);
    return _retval;
  }

  /**
   * Switches to the previous page.
   * Nothing happens if the current page is the first page.
   */
  void prevPage()
  {
    gtk_notebook_prev_page(cast(GtkNotebook*)cPtr);
  }

  /**
   * Removes a page from the notebook given its index
   * in the notebook.
   * Params:
   *   pageNum = the index of a notebook page, starting
   *     from 0. If -1, the last page will be removed.
   */
  void removePage(int pageNum)
  {
    gtk_notebook_remove_page(cast(GtkNotebook*)cPtr, pageNum);
  }

  /**
   * Reorders the page containing child, so that it appears in position
   * position.
   * If position is greater than or equal to the number of children in
   * the list or negative, child will be moved to the end of the list.
   * Params:
   *   child = the child to move
   *   position = the new position, or -1 to move to the end
   */
  void reorderChild(Widget child, int position)
  {
    gtk_notebook_reorder_child(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, position);
  }

  /**
   * Sets widget as one of the action widgets.
   * Depending on the pack type the widget will be placed before
   * or after the tabs. You can use a `GtkBox` if you need to pack
   * more than one widget on the same side.
   * Params:
   *   widget = a `GtkWidget`
   *   packType = pack type of the action widget
   */
  void setActionWidget(Widget widget, PackType packType)
  {
    gtk_notebook_set_action_widget(cast(GtkNotebook*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, packType);
  }

  /**
   * Switches to the page number page_num.
   * Note that due to historical reasons, GtkNotebook refuses
   * to switch to a page unless the child widget is visible.
   * Therefore, it is recommended to show child widgets before
   * adding them to a notebook.
   * Params:
   *   pageNum = index of the page to switch to, starting from 0.
   *     If negative, the last page will be used. If greater
   *     than the number of pages in the notebook, nothing
   *     will be done.
   */
  void setCurrentPage(int pageNum)
  {
    gtk_notebook_set_current_page(cast(GtkNotebook*)cPtr, pageNum);
  }

  /**
   * Sets a group name for notebook.
   * Notebooks with the same name will be able to exchange tabs
   * via drag and drop. A notebook with a %NULL group name will
   * not be able to exchange tabs with any other notebook.
   * Params:
   *   groupName = the name of the notebook group,
   *     or %NULL to unset it
   */
  void setGroupName(string groupName)
  {
    const(char)* _groupName = groupName.toCString(false);
    gtk_notebook_set_group_name(cast(GtkNotebook*)cPtr, _groupName);
  }

  /**
   * Changes the menu label for the page containing child.
   * Params:
   *   child = the child widget
   *   menuLabel = the menu label, or %NULL for default
   */
  void setMenuLabel(Widget child, Widget menuLabel)
  {
    gtk_notebook_set_menu_label(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, menuLabel ? cast(GtkWidget*)menuLabel.cPtr(false) : null);
  }

  /**
   * Creates a new label and sets it as the menu label of child.
   * Params:
   *   child = the child widget
   *   menuText = the label text
   */
  void setMenuLabelText(Widget child, string menuText)
  {
    const(char)* _menuText = menuText.toCString(false);
    gtk_notebook_set_menu_label_text(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, _menuText);
  }

  /**
   * Sets whether the tab label area will have arrows for
   * scrolling if there are too many tabs to fit in the area.
   * Params:
   *   scrollable = %TRUE if scroll arrows should be added
   */
  void setScrollable(bool scrollable)
  {
    gtk_notebook_set_scrollable(cast(GtkNotebook*)cPtr, scrollable);
  }

  /**
   * Sets whether a bevel will be drawn around the notebook pages.
   * This only has a visual effect when the tabs are not shown.
   * Params:
   *   showBorder = %TRUE if a bevel should be drawn around the notebook
   */
  void setShowBorder(bool showBorder)
  {
    gtk_notebook_set_show_border(cast(GtkNotebook*)cPtr, showBorder);
  }

  /**
   * Sets whether to show the tabs for the notebook or not.
   * Params:
   *   showTabs = %TRUE if the tabs should be shown
   */
  void setShowTabs(bool showTabs)
  {
    gtk_notebook_set_show_tabs(cast(GtkNotebook*)cPtr, showTabs);
  }

  /**
   * Sets whether the tab can be detached from notebook to another
   * notebook or widget.
   * Note that two notebooks must share a common group identifier
   * $(LPAREN)see [Gtk.Notebook.setGroupName]$(RPAREN) to allow automatic tabs
   * interchange between them.
   * If you want a widget to interact with a notebook through DnD
   * $(LPAREN)i.e.: accept dragged tabs from it$(RPAREN) it must be set as a drop
   * destination by adding to it a [Gtk.DropTarget] controller that accepts
   * the GType `GTK_TYPE_NOTEBOOK_PAGE`. The `:value` of said drop target will be
   * preloaded with a [Gtk.NotebookPage] object that corresponds to the
   * dropped tab, so you can process the value via `::accept` or `::drop` signals.
   * Note that you should use [Gtk.Notebook.detachTab] instead
   * of [Gtk.Notebook.removePage] if you want to remove the tab
   * from the source notebook as part of accepting a drop. Otherwise,
   * the source notebook will think that the dragged tab was removed
   * from underneath the ongoing drag operation, and will initiate a
   * drag cancel animation.
   * ```c
   * static void
   * on_drag_data_received $(LPAREN)GtkWidget        *widget,
   * GdkDrop          *drop,
   * GtkSelectionData *data,
   * guint             time,
   * gpointer          user_data$(RPAREN)
   * {
   * GtkDrag *drag;
   * GtkWidget *notebook;
   * GtkWidget **child;
   * drag \= gtk_drop_get_drag $(LPAREN)drop$(RPAREN);
   * notebook \= g_object_get_data $(LPAREN)drag, "gtk-notebook-drag-origin"$(RPAREN);
   * child \= $(LPAREN)void*$(RPAREN) gtk_selection_data_get_data $(LPAREN)data$(RPAREN);
   * // process_widget $(LPAREN)*child$(RPAREN);
   * gtk_notebook_detach_tab $(LPAREN)GTK_NOTEBOOK $(LPAREN)notebook$(RPAREN), *child$(RPAREN);
   * }
   * ```
   * If you want a notebook to accept drags from other widgets,
   * you will have to set your own DnD code to do it.
   * Params:
   *   child = a child `GtkWidget`
   *   detachable = whether the tab is detachable or not
   */
  void setTabDetachable(Widget child, bool detachable)
  {
    gtk_notebook_set_tab_detachable(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, detachable);
  }

  /**
   * Changes the tab label for child.
   * If %NULL is specified for tab_label, then the page will
   * have the label “page N”.
   * Params:
   *   child = the page
   *   tabLabel = the tab label widget to use, or %NULL
   *     for default tab label
   */
  void setTabLabel(Widget child, Widget tabLabel)
  {
    gtk_notebook_set_tab_label(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, tabLabel ? cast(GtkWidget*)tabLabel.cPtr(false) : null);
  }

  /**
   * Creates a new label and sets it as the tab label for the page
   * containing child.
   * Params:
   *   child = the page
   *   tabText = the label text
   */
  void setTabLabelText(Widget child, string tabText)
  {
    const(char)* _tabText = tabText.toCString(false);
    gtk_notebook_set_tab_label_text(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, _tabText);
  }

  /**
   * Sets the edge at which the tabs are drawn.
   * Params:
   *   pos = the edge to draw the tabs at
   */
  void setTabPos(PositionType pos)
  {
    gtk_notebook_set_tab_pos(cast(GtkNotebook*)cPtr, pos);
  }

  /**
   * Sets whether the notebook tab can be reordered
   * via drag and drop or not.
   * Params:
   *   child = a child `GtkWidget`
   *   reorderable = whether the tab is reorderable or not
   */
  void setTabReorderable(Widget child, bool reorderable)
  {
    gtk_notebook_set_tab_reorderable(cast(GtkNotebook*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, reorderable);
  }

  alias ChangeCurrentPageCallback = bool delegate(int object, Notebook notebook);

  /**
   * Connect to ChangeCurrentPage signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectChangeCurrentPage(ChangeCurrentPageCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto notebook = getVal!Notebook(_paramVals);
      auto object = getVal!int(&_paramVals[1]);
      _retval = _dgClosure.dlg(object, notebook);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("change-current-page", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::create-window signal is emitted when a detachable
   * tab is dropped on the root window.
   * A handler for this signal can create a window containing
   * a notebook where the tab will be attached. It is also
   * responsible for moving/resizing the window and adding the
   * necessary properties to the notebook $(LPAREN)e.g. the
   * `GtkNotebook`:group-name $(RPAREN).
   * Params
   *   page = the tab of notebook that is being detached
   *   notebook = the instance the signal is connected to
   * Returns: a `GtkNotebook` that
   *   page should be added to
   */
  alias CreateWindowCallback = Notebook delegate(Widget page, Notebook notebook);

  /**
   * Connect to CreateWindow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCreateWindow(CreateWindowCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto page = getVal!Widget(&_paramVals[1]);
      auto _retval = _dgClosure.dlg(page, notebook);
      setVal!Notebook(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("create-window", closure, (flags & ConnectFlags.After) != 0);
  }

  alias FocusTabCallback = bool delegate(NotebookTab object, Notebook notebook);

  /**
   * Connect to FocusTab signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectFocusTab(FocusTabCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto notebook = getVal!Notebook(_paramVals);
      auto object = getVal!NotebookTab(&_paramVals[1]);
      _retval = _dgClosure.dlg(object, notebook);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("focus-tab", closure, (flags & ConnectFlags.After) != 0);
  }

  alias MoveFocusOutCallback = void delegate(DirectionType object, Notebook notebook);

  /**
   * Connect to MoveFocusOut signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMoveFocusOut(MoveFocusOutCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto object = getVal!DirectionType(&_paramVals[1]);
      _dgClosure.dlg(object, notebook);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-focus-out", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * the ::page-added signal is emitted in the notebook
   * right after a page is added to the notebook.
   * Params
   *   child = the child `GtkWidget` affected
   *   pageNum = the new page number for child
   *   notebook = the instance the signal is connected to
   */
  alias PageAddedCallback = void delegate(Widget child, uint pageNum, Notebook notebook);

  /**
   * Connect to PageAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPageAdded(PageAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto child = getVal!Widget(&_paramVals[1]);
      auto pageNum = getVal!uint(&_paramVals[2]);
      _dgClosure.dlg(child, pageNum, notebook);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("page-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * the ::page-removed signal is emitted in the notebook
   * right after a page is removed from the notebook.
   * Params
   *   child = the child `GtkWidget` affected
   *   pageNum = the child page number
   *   notebook = the instance the signal is connected to
   */
  alias PageRemovedCallback = void delegate(Widget child, uint pageNum, Notebook notebook);

  /**
   * Connect to PageRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPageRemoved(PageRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto child = getVal!Widget(&_paramVals[1]);
      auto pageNum = getVal!uint(&_paramVals[2]);
      _dgClosure.dlg(child, pageNum, notebook);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("page-removed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * the ::page-reordered signal is emitted in the notebook
   * right after a page has been reordered.
   * Params
   *   child = the child `GtkWidget` affected
   *   pageNum = the new page number for child
   *   notebook = the instance the signal is connected to
   */
  alias PageReorderedCallback = void delegate(Widget child, uint pageNum, Notebook notebook);

  /**
   * Connect to PageReordered signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPageReordered(PageReorderedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto child = getVal!Widget(&_paramVals[1]);
      auto pageNum = getVal!uint(&_paramVals[2]);
      _dgClosure.dlg(child, pageNum, notebook);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("page-reordered", closure, (flags & ConnectFlags.After) != 0);
  }

  alias ReorderTabCallback = bool delegate(DirectionType object, bool p0, Notebook notebook);

  /**
   * Connect to ReorderTab signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectReorderTab(ReorderTabCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto notebook = getVal!Notebook(_paramVals);
      auto object = getVal!DirectionType(&_paramVals[1]);
      auto p0 = getVal!bool(&_paramVals[2]);
      _retval = _dgClosure.dlg(object, p0, notebook);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("reorder-tab", closure, (flags & ConnectFlags.After) != 0);
  }

  alias SelectPageCallback = bool delegate(bool object, Notebook notebook);

  /**
   * Connect to SelectPage signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectSelectPage(SelectPageCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto notebook = getVal!Notebook(_paramVals);
      auto object = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(object, notebook);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-page", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user or a function changes the current page.
   * Params
   *   page = the new current page
   *   pageNum = the index of the page
   *   notebook = the instance the signal is connected to
   */
  alias SwitchPageCallback = void delegate(Widget page, uint pageNum, Notebook notebook);

  /**
   * Connect to SwitchPage signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectSwitchPage(SwitchPageCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto notebook = getVal!Notebook(_paramVals);
      auto page = getVal!Widget(&_paramVals[1]);
      auto pageNum = getVal!uint(&_paramVals[2]);
      _dgClosure.dlg(page, pageNum, notebook);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("switch-page", closure, (flags & ConnectFlags.After) != 0);
  }
}
