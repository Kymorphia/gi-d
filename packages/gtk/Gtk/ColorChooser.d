module Gtk.ColorChooser;

import GObject.DClosure;
import GObject.Types;
import Gdk.RGBA;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColorChooser` is an interface that is implemented by widgets
 * for choosing colors.
 * Depending on the situation, colors may be allowed to have alpha $(LPAREN)translucency$(RPAREN).
 * In GTK, the main widgets that implement this interface are
 * [Gtk.ColorChooserWidget], [Gtk.ColorChooserDialog] and
 * [Gtk.ColorButton].

 * Deprecated: Use [Gtk.ColorDialog] and [Gtk.ColorDialogButton]
 *   instead of widgets implementing `GtkColorChooser`
 */
interface ColorChooser
{

  static GType getType()
  {
    return gtk_color_chooser_get_type();
  }

  /**
   * Adds a palette to the color chooser.
   * If orientation is horizontal, the colors are grouped in rows,
   * with colors_per_line colors in each row. If horizontal is %FALSE,
   * the colors are grouped in columns instead.
   * The default color palette of [Gtk.ColorChooserWidget] has
   * 45 colors, organized in columns of 5 colors $(LPAREN)this includes some
   * grays$(RPAREN).
   * The layout of the color chooser widget works best when the
   * palettes have 9-10 columns.
   * Calling this function for the first time has the side effect
   * of removing the default color palette from the color chooser.
   * If colors is %NULL, removes all previously added palettes.
   * Params:
   *   orientation = %GTK_ORIENTATION_HORIZONTAL if the palette should
   *     be displayed in rows, %GTK_ORIENTATION_VERTICAL for columns
   *   colorsPerLine = the number of colors to show in each row/column
   *   colors = the colors of the palette

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  void addPalette(Orientation orientation, int colorsPerLine, RGBA[] colors);

  /**
   * Gets the currently-selected color.
   * Params:
   *   color = a `GdkRGBA` to fill in with the current color

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  void getRgba(out RGBA color);

  /**
   * Returns whether the color chooser shows the alpha channel.
   * Returns: %TRUE if the color chooser uses the alpha channel,
   *   %FALSE if not

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  bool getUseAlpha();

  /**
   * Sets the color.
   * Params:
   *   color = the new color

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  void setRgba(RGBA color);

  /**
   * Sets whether or not the color chooser should use the alpha channel.
   * Params:
   *   useAlpha = %TRUE if color chooser should use alpha channel, %FALSE if not

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  void setUseAlpha(bool useAlpha);

  /**
   * Emitted when a color is activated from the color chooser.
   * This usually happens when the user clicks a color swatch,
   * or a color is selected and the user presses one of the keys
   * Space, Shift+Space, Return or Enter.
   * Params
   *   color = the color
   *   colorChooser = the instance the signal is connected to

   * Deprecated: Use [Gtk.ColorDialog] and [Gtk.ColorDialogButton]
   *   instead of widgets implementing `GtkColorChooser`
   */
  alias ColorActivatedCallback = void delegate(RGBA color, ColorChooser colorChooser);

  /**
   * Connect to ColorActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectColorActivated(ColorActivatedCallback dlg, ConnectFlags flags = ConnectFlags.Default);
}
