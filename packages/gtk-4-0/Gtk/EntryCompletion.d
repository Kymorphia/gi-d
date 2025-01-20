module Gtk.EntryCompletion;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellArea;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEntryCompletion` is an auxiliary object to provide completion functionality
 * for `GtkEntry`.
 * It implements the [Gtk.CellLayout] interface, to allow the user
 * to add extra cells to the `GtkTreeView` with completion matches.
 * “Completion functionality” means that when the user modifies the text
 * in the entry, `GtkEntryCompletion` checks which rows in the model match
 * the current content of the entry, and displays a list of matches.
 * By default, the matching is done by comparing the entry text
 * case-insensitively against the text column of the model $(LPAREN)see
 * [Gtk.EntryCompletion.setTextColumn]$(RPAREN), but this can be overridden
 * with a custom match function $(LPAREN)see [Gtk.EntryCompletion.setMatchFunc]$(RPAREN).
 * When the user selects a completion, the content of the entry is
 * updated. By default, the content of the entry is replaced by the
 * text column of the model, but this can be overridden by connecting
 * to the signal@Gtk.EntryCompletion::match-selected signal and updating the
 * entry in the signal handler. Note that you should return %TRUE from
 * the signal handler to suppress the default behaviour.
 * To add completion functionality to an entry, use
 * [Gtk.Entry.setCompletion].
 * `GtkEntryCompletion` uses a [Gtk.TreeModelFilter] model to
 * represent the subset of the entire model that is currently matching.
 * While the `GtkEntryCompletion` signals
 * signal@Gtk.EntryCompletion::match-selected and
 * signal@Gtk.EntryCompletion::cursor-on-match take the original model
 * and an iter pointing to that model as arguments, other callbacks and
 * signals $(LPAREN)such as `GtkCellLayoutDataFunc` or
 * signal@Gtk.CellArea::apply-attributes$(RPAREN)
 * will generally take the filter model as argument. As long as you are
 * only calling [Gtk.TreeModel.get], this will make no difference to
 * you. If for some reason, you need the original model, use
 * [Gtk.TreeModelFilter.getModel]. Don’t forget to use
 * [Gtk.TreeModelFilter.convertIterToChildIter] to obtain a
 * matching iter.
 */
class EntryCompletion : ObjectG, Buildable, CellLayout
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_entry_completion_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!();
  mixin CellLayoutT!();

  /**
   * Creates a new `GtkEntryCompletion` object.
   * Returns: A newly created `GtkEntryCompletion` object

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  this()
  {
    GtkEntryCompletion* _cretval;
    _cretval = gtk_entry_completion_new();
    this(_cretval, true);
  }

  /**
   * Creates a new `GtkEntryCompletion` object using the
   * specified area.
   * The `GtkCellArea` is used to layout cells in the underlying
   * `GtkTreeViewColumn` for the drop-down menu.
   * Params:
   *   area = the `GtkCellArea` used to layout cells
   * Returns: A newly created `GtkEntryCompletion` object

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  static EntryCompletion newWithArea(CellArea area)
  {
    GtkEntryCompletion* _cretval;
    _cretval = gtk_entry_completion_new_with_area(area ? cast(GtkCellArea*)area.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!EntryCompletion(cast(GtkEntryCompletion*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Requests a completion operation, or in other words a refiltering of the
   * current list with completions, using the current key.
   * The completion list view will be updated accordingly.

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void complete()
  {
    gtk_entry_completion_complete(cast(GtkEntryCompletion*)cPtr);
  }

  /**
   * Computes the common prefix that is shared by all rows in completion
   * that start with key.
   * If no row matches key, %NULL will be returned.
   * Note that a text column must have been set for this function to work,
   * see [Gtk.EntryCompletion.setTextColumn] for details.
   * Params:
   *   key = The text to complete for
   * Returns: The common prefix all rows
   *   starting with key

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  string computePrefix(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = gtk_entry_completion_compute_prefix(cast(GtkEntryCompletion*)cPtr, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Get the original text entered by the user that triggered
   * the completion or %NULL if there’s no completion ongoing.
   * Returns: the prefix for the current completion

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  string getCompletionPrefix()
  {
    const(char)* _cretval;
    _cretval = gtk_entry_completion_get_completion_prefix(cast(GtkEntryCompletion*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the entry completion has been attached to.
   * Returns: The entry completion has been attached to

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  Widget getEntry()
  {
    GtkWidget* _cretval;
    _cretval = gtk_entry_completion_get_entry(cast(GtkEntryCompletion*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the common prefix of the possible completions should
   * be automatically inserted in the entry.
   * Returns: %TRUE if inline completion is turned on

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  bool getInlineCompletion()
  {
    bool _retval;
    _retval = gtk_entry_completion_get_inline_completion(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if inline-selection mode is turned on.
   * Returns: %TRUE if inline-selection mode is on

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  bool getInlineSelection()
  {
    bool _retval;
    _retval = gtk_entry_completion_get_inline_selection(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns the minimum key length as set for completion.
   * Returns: The currently used minimum key length

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  int getMinimumKeyLength()
  {
    int _retval;
    _retval = gtk_entry_completion_get_minimum_key_length(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns the model the `GtkEntryCompletion` is using as data source.
   * Returns %NULL if the model is unset.
   * Returns: A `GtkTreeModel`

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_entry_completion_get_model(cast(GtkEntryCompletion*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the completions should be presented in a popup window.
   * Returns: %TRUE if popup completion is turned on

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  bool getPopupCompletion()
  {
    bool _retval;
    _retval = gtk_entry_completion_get_popup_completion(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the completion popup window will be resized to the
   * width of the entry.
   * Returns: %TRUE if the popup window will be resized to the width of
   *   the entry

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  bool getPopupSetWidth()
  {
    bool _retval;
    _retval = gtk_entry_completion_get_popup_set_width(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the completion popup window will appear even if there is
   * only a single match.
   * Returns: %TRUE if the popup window will appear regardless of the
   *   number of matches

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  bool getPopupSingleMatch()
  {
    bool _retval;
    _retval = gtk_entry_completion_get_popup_single_match(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Returns the column in the model of completion to get strings from.
   * Returns: the column containing the strings

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  int getTextColumn()
  {
    int _retval;
    _retval = gtk_entry_completion_get_text_column(cast(GtkEntryCompletion*)cPtr);
    return _retval;
  }

  /**
   * Requests a prefix insertion.

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void insertPrefix()
  {
    gtk_entry_completion_insert_prefix(cast(GtkEntryCompletion*)cPtr);
  }

  /**
   * Sets whether the common prefix of the possible completions should
   * be automatically inserted in the entry.
   * Params:
   *   inlineCompletion = %TRUE to do inline completion

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setInlineCompletion(bool inlineCompletion)
  {
    gtk_entry_completion_set_inline_completion(cast(GtkEntryCompletion*)cPtr, inlineCompletion);
  }

  /**
   * Sets whether it is possible to cycle through the possible completions
   * inside the entry.
   * Params:
   *   inlineSelection = %TRUE to do inline selection

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setInlineSelection(bool inlineSelection)
  {
    gtk_entry_completion_set_inline_selection(cast(GtkEntryCompletion*)cPtr, inlineSelection);
  }

  /**
   * Sets the match function for completion to be func.
   * The match function is used to determine if a row should or
   * should not be in the completion list.
   * Params:
   *   func = the `GtkEntryCompletion`MatchFunc to use

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setMatchFunc(EntryCompletionMatchFunc func)
  {
    extern(C) bool _funcCallback(GtkEntryCompletion* completion, const(char)* key, GtkTreeIter* iter, void* userData)
    {
      auto _dlg = cast(EntryCompletionMatchFunc*)userData;
      string _key = key.fromCString(false);

      bool _retval = (*_dlg)(completion ? ObjectG.getDObject!EntryCompletion(cast(void*)completion, false) : null, _key, iter ? new TreeIter(cast(void*)iter, false) : null);
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_entry_completion_set_match_func(cast(GtkEntryCompletion*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Requires the length of the search key for completion to be at least
   * length.
   * This is useful for long lists, where completing using a small
   * key takes a lot of time and will come up with meaningless results anyway
   * $(LPAREN)ie, a too large dataset$(RPAREN).
   * Params:
   *   length = the minimum length of the key in order to start completing

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setMinimumKeyLength(int length)
  {
    gtk_entry_completion_set_minimum_key_length(cast(GtkEntryCompletion*)cPtr, length);
  }

  /**
   * Sets the model for a `GtkEntryCompletion`.
   * If completion already has a model set, it will remove it
   * before setting the new model. If model is %NULL, then it
   * will unset the model.
   * Params:
   *   model = the `GtkTreeModel`

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setModel(TreeModel model)
  {
    gtk_entry_completion_set_model(cast(GtkEntryCompletion*)cPtr, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets whether the completions should be presented in a popup window.
   * Params:
   *   popupCompletion = %TRUE to do popup completion

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setPopupCompletion(bool popupCompletion)
  {
    gtk_entry_completion_set_popup_completion(cast(GtkEntryCompletion*)cPtr, popupCompletion);
  }

  /**
   * Sets whether the completion popup window will be resized to be the same
   * width as the entry.
   * Params:
   *   popupSetWidth = %TRUE to make the width of the popup the same as the entry

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setPopupSetWidth(bool popupSetWidth)
  {
    gtk_entry_completion_set_popup_set_width(cast(GtkEntryCompletion*)cPtr, popupSetWidth);
  }

  /**
   * Sets whether the completion popup window will appear even if there is
   * only a single match.
   * You may want to set this to %FALSE if you
   * are using propertyGtk.EntryCompletion:inline-completion.
   * Params:
   *   popupSingleMatch = %TRUE if the popup should appear even for a single match

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setPopupSingleMatch(bool popupSingleMatch)
  {
    gtk_entry_completion_set_popup_single_match(cast(GtkEntryCompletion*)cPtr, popupSingleMatch);
  }

  /**
   * Convenience function for setting up the most used case of this code: a
   * completion list with just strings.
   * This function will set up completion
   * to have a list displaying all $(LPAREN)and just$(RPAREN) strings in the completion list,
   * and to get those strings from column in the model of completion.
   * This functions creates and adds a `GtkCellRendererText` for the selected
   * column. If you need to set the text column, but don't want the cell
   * renderer, use [GObject.ObjectG.set] to set the
   * propertyGtk.EntryCompletion:text-column property directly.
   * Params:
   *   column = the column in the model of completion to get strings from

   * Deprecated: GtkEntryCompletion will be removed in GTK 5.
   */
  void setTextColumn(int column)
  {
    gtk_entry_completion_set_text_column(cast(GtkEntryCompletion*)cPtr, column);
  }

  /**
   * Emitted when a match from the cursor is on a match of the list.
   * The default behaviour is to replace the contents
   * of the entry with the contents of the text column in the row
   * pointed to by iter.
   * Note that model is the model that was passed to
   * [Gtk.EntryCompletion.setModel].
   * Params
   *   model = the `GtkTreeModel` containing the matches
   *   iter = a `GtkTreeIter` positioned at the selected match
   *   entryCompletion = the instance the signal is connected to
   * Returns: %TRUE if the signal has been handled
   */
  alias CursorOnMatchCallback = bool delegate(TreeModel model, TreeIter iter, EntryCompletion entryCompletion);

  /**
   * Connect to CursorOnMatch signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCursorOnMatch(CursorOnMatchCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto entryCompletion = getVal!EntryCompletion(_paramVals);
      auto model = getVal!TreeModel(&_paramVals[1]);
      auto iter = getVal!TreeIter(&_paramVals[2]);
      _retval = _dgClosure.dlg(model, iter, entryCompletion);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cursor-on-match", closure, after);
  }

  /**
   * Emitted when the inline autocompletion is triggered.
   * The default behaviour is to make the entry display the
   * whole prefix and select the newly inserted part.
   * Applications may connect to this signal in order to insert only a
   * smaller part of the prefix into the entry - e.g. the entry used in
   * the `GtkFileChooser` inserts only the part of the prefix up to the
   * next '/'.
   * Params
   *   prefix = the common prefix of all possible completions
   *   entryCompletion = the instance the signal is connected to
   * Returns: %TRUE if the signal has been handled
   */
  alias InsertPrefixCallback = bool delegate(string prefix, EntryCompletion entryCompletion);

  /**
   * Connect to InsertPrefix signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertPrefix(InsertPrefixCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto entryCompletion = getVal!EntryCompletion(_paramVals);
      auto prefix = getVal!string(&_paramVals[1]);
      _retval = _dgClosure.dlg(prefix, entryCompletion);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-prefix", closure, after);
  }

  /**
   * Emitted when a match from the list is selected.
   * The default behaviour is to replace the contents of the
   * entry with the contents of the text column in the row
   * pointed to by iter.
   * Note that model is the model that was passed to
   * [Gtk.EntryCompletion.setModel].
   * Params
   *   model = the `GtkTreeModel` containing the matches
   *   iter = a `GtkTreeIter` positioned at the selected match
   *   entryCompletion = the instance the signal is connected to
   * Returns: %TRUE if the signal has been handled
   */
  alias MatchSelectedCallback = bool delegate(TreeModel model, TreeIter iter, EntryCompletion entryCompletion);

  /**
   * Connect to MatchSelected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMatchSelected(MatchSelectedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto entryCompletion = getVal!EntryCompletion(_paramVals);
      auto model = getVal!TreeModel(&_paramVals[1]);
      auto iter = getVal!TreeIter(&_paramVals[2]);
      _retval = _dgClosure.dlg(model, iter, entryCompletion);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("match-selected", closure, after);
  }

  /**
   * Emitted when the filter model has zero
   * number of rows in completion_complete method.
   * In other words when `GtkEntryCompletion` is out of suggestions.
   *   entryCompletion = the instance the signal is connected to
   */
  alias NoMatchesCallback = void delegate(EntryCompletion entryCompletion);

  /**
   * Connect to NoMatches signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNoMatches(NoMatchesCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto entryCompletion = getVal!EntryCompletion(_paramVals);
      _dgClosure.dlg(entryCompletion);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("no-matches", closure, after);
  }
}
