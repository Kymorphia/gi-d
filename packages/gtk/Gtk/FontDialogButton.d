module Gtk.FontDialogButton;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.FontDialog;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.FontDescription;
import Pango.PgLanguage;

/**
 * The `GtkFontDialogButton` is wrapped around a [Gtk.FontDialog]
 * and allows to open a font chooser dialog to change the font.
 * ![An example GtkFontDialogButton](font-button.png)
 * It is suitable widget for selecting a font in a preference dialog.
 * # CSS nodes
 * ```
 * fontbutton
 * ╰── button.font
 * ╰── [content]
 * ```
 * `GtkFontDialogButton` has a single CSS node with name fontbutton which
 * contains a button node with the .font style class.
 */
class FontDialogButton : Widget
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_font_dialog_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFontDialogButton` with the
   * given `GtkFontDialog`.
   * You can pass `NULL` to this function and set a `GtkFontDialog`
   * later. The button will be insensitive until that happens.
   * Params:
   *   dialog = the `GtkFontDialog` to use
   * Returns: the new `GtkFontDialogButton`
   */
  this(FontDialog dialog)
  {
    GtkWidget* _cretval;
    _cretval = gtk_font_dialog_button_new(dialog ? cast(GtkFontDialog*)dialog.cPtr(true) : null);
    this(_cretval, false);
  }

  /**
   * Returns the `GtkFontDialog` of self.
   * Returns: the `GtkFontDialog`
   */
  FontDialog getDialog()
  {
    GtkFontDialog* _cretval;
    _cretval = gtk_font_dialog_button_get_dialog(cast(GtkFontDialogButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontDialog(cast(GtkFontDialog*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the font of the button.
   * This function is what should be used to obtain
   * the font that was chosen by the user. To get
   * informed about changes, listen to "notify::font-desc".
   * Returns: the font
   */
  FontDescription getFontDesc()
  {
    PangoFontDescription* _cretval;
    _cretval = gtk_font_dialog_button_get_font_desc(cast(GtkFontDialogButton*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the font features of the button.
   * This function is what should be used to obtain the font features
   * that were chosen by the user. To get informed about changes, listen
   * to "notify::font-features".
   * Note that the button will only let users choose font features
   * if [Gtk.FontDialogButton.level] is set to
   * `GTK_FONT_LEVEL_FEATURES`.
   * Returns: the font features
   */
  string getFontFeatures()
  {
    const(char)* _cretval;
    _cretval = gtk_font_dialog_button_get_font_features(cast(GtkFontDialogButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the language that is used for font features.
   * Returns: the language
   */
  PgLanguage getLanguage()
  {
    PangoLanguage* _cretval;
    _cretval = gtk_font_dialog_button_get_language(cast(GtkFontDialogButton*)cPtr);
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the level of detail at which this dialog
   * lets the user select fonts.
   * Returns: the level of detail
   */
  FontLevel getLevel()
  {
    GtkFontLevel _cretval;
    _cretval = gtk_font_dialog_button_get_level(cast(GtkFontDialogButton*)cPtr);
    FontLevel _retval = cast(FontLevel)_cretval;
    return _retval;
  }

  /**
   * Returns whether the selected font is used in the label.
   * Returns: whether the selected font is used in the label
   */
  bool getUseFont()
  {
    bool _retval;
    _retval = gtk_font_dialog_button_get_use_font(cast(GtkFontDialogButton*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the selected font size is used in the label.
   * Returns: whether the selected font size is used in the label
   */
  bool getUseSize()
  {
    bool _retval;
    _retval = gtk_font_dialog_button_get_use_size(cast(GtkFontDialogButton*)cPtr);
    return _retval;
  }

  /**
   * Sets a `GtkFontDialog` object to use for
   * creating the font chooser dialog that is
   * presented when the user clicks the button.
   * Params:
   *   dialog = the new `GtkFontDialog`
   */
  void setDialog(FontDialog dialog)
  {
    gtk_font_dialog_button_set_dialog(cast(GtkFontDialogButton*)cPtr, dialog ? cast(GtkFontDialog*)dialog.cPtr(false) : null);
  }

  /**
   * Sets the font of the button.
   * Params:
   *   fontDesc = the new font
   */
  void setFontDesc(FontDescription fontDesc)
  {
    gtk_font_dialog_button_set_font_desc(cast(GtkFontDialogButton*)cPtr, fontDesc ? cast(PangoFontDescription*)fontDesc.cPtr(false) : null);
  }

  /**
   * Sets the font features of the button.
   * Params:
   *   fontFeatures = the font features
   */
  void setFontFeatures(string fontFeatures)
  {
    const(char)* _fontFeatures = fontFeatures.toCString(false);
    gtk_font_dialog_button_set_font_features(cast(GtkFontDialogButton*)cPtr, _fontFeatures);
  }

  /**
   * Sets the language to use for font features.
   * Params:
   *   language = the new language
   */
  void setLanguage(PgLanguage language)
  {
    gtk_font_dialog_button_set_language(cast(GtkFontDialogButton*)cPtr, language ? cast(PangoLanguage*)language.cPtr(false) : null);
  }

  /**
   * Sets the level of detail at which this dialog
   * lets the user select fonts.
   * Params:
   *   level = the level of detail
   */
  void setLevel(FontLevel level)
  {
    gtk_font_dialog_button_set_level(cast(GtkFontDialogButton*)cPtr, level);
  }

  /**
   * If use_font is `TRUE`, the font name will be written
   * using the selected font.
   * Params:
   *   useFont = If `TRUE`, font name will be written using
   *     the chosen font
   */
  void setUseFont(bool useFont)
  {
    gtk_font_dialog_button_set_use_font(cast(GtkFontDialogButton*)cPtr, useFont);
  }

  /**
   * If use_size is `TRUE`, the font name will be written
   * using the selected font size.
   * Params:
   *   useSize = If `TRUE`, font name will be written using
   *     the chosen font size
   */
  void setUseSize(bool useSize)
  {
    gtk_font_dialog_button_set_use_size(cast(GtkFontDialogButton*)cPtr, useSize);
  }

  /**
   * Emitted when the font dialog button is activated.
   * The `::activate` signal on `GtkFontDialogButton` is an action signal
   * and emitting it causes the button to pop up its dialog.
   *   fontDialogButton = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(FontDialogButton fontDialogButton);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fontDialogButton = getVal!FontDialogButton(_paramVals);
      _dgClosure.dlg(fontDialogButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }
}
