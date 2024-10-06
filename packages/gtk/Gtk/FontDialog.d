module Gtk.FontDialog;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gtk.Filter;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.FontDescription;
import Pango.FontFace;
import Pango.FontFamily;
import Pango.FontMap;
import Pango.PgLanguage;

/**
 * A `GtkFontDialog` object collects the arguments that
 * are needed to present a font chooser dialog to the
 * user, such as a title for the dialog and whether it
 * should be modal.
 * The dialog is shown with the [Gtk.FontDialog.chooseFont]
 * function or its variants. This API follows the GIO async pattern,
 * and the result can be obtained by calling the corresponding
 * finish function, such as [Gtk.FontDialog.chooseFontFinish].
 * See [Gtk.FontDialogButton] for a convenient control
 * that uses `GtkFontDialog` and presents the results.
 */
class FontDialog : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_font_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFontDialog` object.
   * Returns: the new `GtkFontDialog`
   */
  this()
  {
    GtkFontDialog* _cretval;
    _cretval = gtk_font_dialog_new();
    this(_cretval, true);
  }

  /**
   * This function initiates a font selection operation by
   * presenting a dialog to the user for selecting a font face
   * $(LPAREN)i.e. a font family and style, but not a specific font size$(RPAREN).
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FontDialog.chooseFaceFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   initialValue = the initial value
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void chooseFace(Window parent, FontFace initialValue, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_font_dialog_choose_face(cast(GtkFontDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, initialValue ? cast(PangoFontFace*)initialValue.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FontDialog.chooseFace] call
   * and returns the resulting font face.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the selected font face
   */
  FontFace chooseFaceFinish(AsyncResult result)
  {
    PangoFontFace* _cretval;
    GError *_err;
    _cretval = gtk_font_dialog_choose_face_finish(cast(GtkFontDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FontFace(cast(PangoFontFace*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a font selection operation by
   * presenting a dialog to the user for selecting a font family.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FontDialog.chooseFamilyFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   initialValue = the initial value
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void chooseFamily(Window parent, FontFamily initialValue, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_font_dialog_choose_family(cast(GtkFontDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, initialValue ? cast(PangoFontFamily*)initialValue.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FontDialog.chooseFamily] call
   * and returns the resulting family.
   * This function never returns an error. If the operation is
   * not finished successfully, the value passed as initial_value
   * to [Gtk.FontDialog.chooseFamily] is returned.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the selected family
   */
  FontFamily chooseFamilyFinish(AsyncResult result)
  {
    PangoFontFamily* _cretval;
    GError *_err;
    _cretval = gtk_font_dialog_choose_family_finish(cast(GtkFontDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FontFamily(cast(PangoFontFamily*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a font selection operation by
   * presenting a dialog to the user for selecting a font.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FontDialog.chooseFontFinish]
   * to obtain the result.
   * If you want to let the user select font features as well,
   * use [Gtk.FontDialog.chooseFontAndFeatures] instead.
   * Params:
   *   parent = the parent `GtkWindow`
   *   initialValue = the font to select initially
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void chooseFont(Window parent, FontDescription initialValue, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_font_dialog_choose_font(cast(GtkFontDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, initialValue ? cast(PangoFontDescription*)initialValue.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * This function initiates a font selection operation by
   * presenting a dialog to the user for selecting a font and
   * font features.
   * Font features affect how the font is rendered, for example
   * enabling glyph variants or ligatures.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FontDialog.chooseFontAndFeaturesFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   initialValue = the font to select initially
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void chooseFontAndFeatures(Window parent, FontDescription initialValue, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_font_dialog_choose_font_and_features(cast(GtkFontDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, initialValue ? cast(PangoFontDescription*)initialValue.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FontDialog.chooseFontAndFeatures]
   * call and returns the resulting font description and font features.
   * Params:
   *   result = a `GAsyncResult`
   *   fontDesc = return location for font description
   *   fontFeatures = return location for font features
   *   language = return location for the language
   * Returns: `TRUE` if a font was selected. Otherwise `FALSE` is returned
   *   and error is set
   */
  bool chooseFontAndFeaturesFinish(AsyncResult result, out FontDescription fontDesc, out string fontFeatures, out PgLanguage language)
  {
    bool _retval;
    PangoFontDescription* _fontDesc;
    char* _fontFeatures;
    PangoLanguage* _language;
    GError *_err;
    _retval = gtk_font_dialog_choose_font_and_features_finish(cast(GtkFontDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_fontDesc, &_fontFeatures, &_language, &_err);
    if (_err)
      throw new ErrorG(_err);
    fontDesc = new FontDescription(cast(void*)_fontDesc, true);
    fontFeatures = _fontFeatures.fromCString(true);
    language = new PgLanguage(cast(void*)_language, true);
    return _retval;
  }

  /**
   * Finishes the [Gtk.FontDialog.chooseFont] call
   * and returns the resulting font description.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the selected font
   */
  FontDescription chooseFontFinish(AsyncResult result)
  {
    PangoFontDescription* _cretval;
    GError *_err;
    _cretval = gtk_font_dialog_choose_font_finish(cast(GtkFontDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the filter that decides which fonts to display
   * in the font chooser dialog.
   * Returns: the filter
   */
  Filter getFilter()
  {
    GtkFilter* _cretval;
    _cretval = gtk_font_dialog_get_filter(cast(GtkFontDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Filter(cast(GtkFilter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the fontmap from which fonts are selected,
   * or `NULL` for the default fontmap.
   * Returns: the fontmap
   */
  FontMap getFontMap()
  {
    PangoFontMap* _cretval;
    _cretval = gtk_font_dialog_get_font_map(cast(GtkFontDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the language for which font features are applied.
   * Returns: the language for font features
   */
  PgLanguage getLanguage()
  {
    PangoLanguage* _cretval;
    _cretval = gtk_font_dialog_get_language(cast(GtkFontDialog*)cPtr);
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether the font chooser dialog
   * blocks interaction with the parent window
   * while it is presented.
   * Returns: `TRUE` if the font chooser dialog is modal
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_font_dialog_get_modal(cast(GtkFontDialog*)cPtr);
    return _retval;
  }

  /**
   * Returns the title that will be shown on the
   * font chooser dialog.
   * Returns: the title
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_font_dialog_get_title(cast(GtkFontDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Adds a filter that decides which fonts to display
   * in the font chooser dialog.
   * The `GtkFilter` must be able to handle both `PangoFontFamily`
   * and `PangoFontFace` objects.
   * Params:
   *   filter = a `GtkFilter`
   */
  void setFilter(Filter filter)
  {
    gtk_font_dialog_set_filter(cast(GtkFontDialog*)cPtr, filter ? cast(GtkFilter*)filter.cPtr(false) : null);
  }

  /**
   * Sets the fontmap from which fonts are selected.
   * If fontmap is `NULL`, the default fontmap is used.
   * Params:
   *   fontmap = the fontmap
   */
  void setFontMap(FontMap fontmap)
  {
    gtk_font_dialog_set_font_map(cast(GtkFontDialog*)cPtr, fontmap ? cast(PangoFontMap*)fontmap.cPtr(false) : null);
  }

  /**
   * Sets the language for which font features are applied.
   * Params:
   *   language = the language for font features
   */
  void setLanguage(PgLanguage language)
  {
    gtk_font_dialog_set_language(cast(GtkFontDialog*)cPtr, language ? cast(PangoLanguage*)language.cPtr(false) : null);
  }

  /**
   * Sets whether the font chooser dialog
   * blocks interaction with the parent window
   * while it is presented.
   * Params:
   *   modal = the new value
   */
  void setModal(bool modal)
  {
    gtk_font_dialog_set_modal(cast(GtkFontDialog*)cPtr, modal);
  }

  /**
   * Sets the title that will be shown on the
   * font chooser dialog.
   * Params:
   *   title = the new title
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_font_dialog_set_title(cast(GtkFontDialog*)cPtr, _title);
  }
}
