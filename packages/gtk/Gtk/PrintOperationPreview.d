module Gtk.PrintOperationPreview;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.PageSetup;
import Gtk.PrintContext;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkPrintOperationPreview` is the interface that is used to
 * implement print preview.
 * A `GtkPrintOperationPreview` object is passed to the
 * [Gtk.PrintOperation.preview] signal by
 * [Gtk.PrintOperation].
 */
interface PrintOperationPreview
{

  static GType getType()
  {
    return gtk_print_operation_preview_get_type();
  }

  /**
   * Ends a preview.
   * This function must be called to finish a custom print preview.
   */
  void endPreview();

  /**
   * Returns whether the given page is included in the set of pages that
   * have been selected for printing.
   * Params:
   *   pageNr = a page number
   * Returns: %TRUE if the page has been selected for printing
   */
  bool isSelected(int pageNr);

  /**
   * Renders a page to the preview.
   * This is using the print context that was passed to the
   * [Gtk.PrintOperation.preview] handler together
   * with preview.
   * A custom print preview should use this function to render
   * the currently selected page.
   * Note that this function requires a suitable cairo context to
   * be associated with the print context.
   * Params:
   *   pageNr = the page to render
   */
  void renderPage(int pageNr);

  /**
   * Emitted once for each page that gets rendered to the preview.
   * A handler for this signal should update the context
   * according to page_setup and set up a suitable cairo
   * context, using [Gtk.PrintContext.setCairoContext].
   * Params
   *   context = the current `GtkPrintContext`
   *   pageSetup = the `GtkPageSetup` for the current page
   *   printOperationPreview = the instance the signal is connected to
   */
  alias GotPageSizeCallback = void delegate(PrintContext context, PageSetup pageSetup, PrintOperationPreview printOperationPreview);

  /**
   * Connect to GotPageSize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectGotPageSize(GotPageSizeCallback dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * The ::ready signal gets emitted once per preview operation,
   * before the first page is rendered.
   * A handler for this signal can be used for setup tasks.
   * Params
   *   context = the current `GtkPrintContext`
   *   printOperationPreview = the instance the signal is connected to
   */
  alias ReadyCallback = void delegate(PrintContext context, PrintOperationPreview printOperationPreview);

  /**
   * Connect to Ready signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectReady(ReadyCallback dlg, ConnectFlags flags = ConnectFlags.Default);
}
