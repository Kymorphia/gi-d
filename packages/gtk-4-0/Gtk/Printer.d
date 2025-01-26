module Gtk.Printer;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.PageSetup;
import Gtk.PaperSize;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkPrinter` object represents a printer.
 * You only need to deal directly with printers if you use the
 * non-portable [Gtk.PrintUnixDialog] API.
 * A `GtkPrinter` allows to get status information about the printer,
 * such as its description, its location, the number of queued jobs,
 * etc. Most importantly, a `GtkPrinter` object can be used to create
 * a [Gtk.PrintJob] object, which lets you print to the printer.
 */
class Printer : ObjectG
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
    return gtk_printer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPrinter`.
   * Params:
   *   name = the name of the printer
   *   backend = a `GtkPrintBackend`
   *   virtual = whether the printer is virtual
   * Returns: a new `GtkPrinter`
   */
  this(string name, PrintBackend backend, bool virtual)
  {
    GtkPrinter* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_printer_new(_name, backend, virtual);
    this(_cretval, true);
  }

  /**
   * Returns whether the printer accepts input in
   * PDF format.
   * Returns: %TRUE if printer accepts PDF
   */
  bool acceptsPdf()
  {
    bool _retval;
    _retval = gtk_printer_accepts_pdf(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer accepts input in
   * PostScript format.
   * Returns: %TRUE if printer accepts PostScript
   */
  bool acceptsPs()
  {
    bool _retval;
    _retval = gtk_printer_accepts_ps(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Compares two printers.
   * Params:
   *   b = another `GtkPrinter`
   * Returns: 0 if the printer match, a negative value if a < b,
   *   or a positive value if a > b
   */
  int compare(Printer b)
  {
    int _retval;
    _retval = gtk_printer_compare(cast(GtkPrinter*)cPtr, b ? cast(GtkPrinter*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the backend of the printer.
   * Returns: the backend of printer
   */
  PrintBackend getBackend()
  {
    auto _retval = gtk_printer_get_backend(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns the printer’s capabilities.
   * This is useful when you’re using `GtkPrintUnixDialog`’s
   * manual-capabilities setting and need to know which settings
   * the printer can handle and which you must handle yourself.
   * This will return 0 unless the printer’s details are
   * available, see [Gtk.Printer.hasDetails] and
   * [Gtk.Printer.requestDetails].
   * Returns: the printer’s capabilities
   */
  PrintCapabilities getCapabilities()
  {
    GtkPrintCapabilities _cretval;
    _cretval = gtk_printer_get_capabilities(cast(GtkPrinter*)cPtr);
    PrintCapabilities _retval = cast(PrintCapabilities)_cretval;
    return _retval;
  }

  /**
   * Returns default page size of printer.
   * Returns: a newly allocated `GtkPageSetup` with default page size
   *   of the printer.
   */
  PageSetup getDefaultPageSize()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_printer_get_default_page_size(cast(GtkPrinter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the description of the printer.
   * Returns: the description of printer
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = gtk_printer_get_description(cast(GtkPrinter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieve the hard margins of printer.
   * These are the margins that define the area at the borders
   * of the paper that the printer cannot print to.
   * Note: This will not succeed unless the printer’s details are
   * available, see [Gtk.Printer.hasDetails] and
   * [Gtk.Printer.requestDetails].
   * Params:
   *   top = a location to store the top margin in
   *   bottom = a location to store the bottom margin in
   *   left = a location to store the left margin in
   *   right = a location to store the right margin in
   * Returns: %TRUE iff the hard margins were retrieved
   */
  bool getHardMargins(out double top, out double bottom, out double left, out double right)
  {
    bool _retval;
    _retval = gtk_printer_get_hard_margins(cast(GtkPrinter*)cPtr, cast(double*)&top, cast(double*)&bottom, cast(double*)&left, cast(double*)&right);
    return _retval;
  }

  /**
   * Retrieve the hard margins of printer for paper_size.
   * These are the margins that define the area at the borders
   * of the paper that the printer cannot print to.
   * Note: This will not succeed unless the printer’s details are
   * available, see [Gtk.Printer.hasDetails] and
   * [Gtk.Printer.requestDetails].
   * Params:
   *   paperSize = a `GtkPaperSize`
   *   top = a location to store the top margin in
   *   bottom = a location to store the bottom margin in
   *   left = a location to store the left margin in
   *   right = a location to store the right margin in
   * Returns: %TRUE iff the hard margins were retrieved
   */
  bool getHardMarginsForPaperSize(PaperSize paperSize, out double top, out double bottom, out double left, out double right)
  {
    bool _retval;
    _retval = gtk_printer_get_hard_margins_for_paper_size(cast(GtkPrinter*)cPtr, paperSize ? cast(GtkPaperSize*)paperSize.cPtr(false) : null, cast(double*)&top, cast(double*)&bottom, cast(double*)&left, cast(double*)&right);
    return _retval;
  }

  /**
   * Gets the name of the icon to use for the printer.
   * Returns: the icon name for printer
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_printer_get_icon_name(cast(GtkPrinter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the number of jobs currently queued on the printer.
   * Returns: the number of jobs on printer
   */
  int getJobCount()
  {
    int _retval;
    _retval = gtk_printer_get_job_count(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns a description of the location of the printer.
   * Returns: the location of printer
   */
  string getLocation()
  {
    const(char)* _cretval;
    _cretval = gtk_printer_get_location(cast(GtkPrinter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the name of the printer.
   * Returns: the name of printer
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_printer_get_name(cast(GtkPrinter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the state message describing the current state
   * of the printer.
   * Returns: the state message of printer
   */
  string getStateMessage()
  {
    const(char)* _cretval;
    _cretval = gtk_printer_get_state_message(cast(GtkPrinter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the printer details are available.
   * Returns: %TRUE if printer details are available
   */
  bool hasDetails()
  {
    bool _retval;
    _retval = gtk_printer_has_details(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer is accepting jobs
   * Returns: %TRUE if printer is accepting jobs
   */
  bool isAcceptingJobs()
  {
    bool _retval;
    _retval = gtk_printer_is_accepting_jobs(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer is currently active $(LPAREN)i.e.
   * accepts new jobs$(RPAREN).
   * Returns: %TRUE if printer is active
   */
  bool isActive()
  {
    bool _retval;
    _retval = gtk_printer_is_active(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer is the default printer.
   * Returns: %TRUE if printer is the default
   */
  bool isDefault()
  {
    bool _retval;
    _retval = gtk_printer_is_default(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer is currently paused.
   * A paused printer still accepts jobs, but it is not
   * printing them.
   * Returns: %TRUE if printer is paused
   */
  bool isPaused()
  {
    bool _retval;
    _retval = gtk_printer_is_paused(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the printer is virtual $(LPAREN)i.e. does not
   * represent actual printer hardware, but something like
   * a CUPS class$(RPAREN).
   * Returns: %TRUE if printer is virtual
   */
  bool isVirtual()
  {
    bool _retval;
    _retval = gtk_printer_is_virtual(cast(GtkPrinter*)cPtr);
    return _retval;
  }

  /**
   * Lists all the paper sizes printer supports.
   * This will return and empty list unless the printer’s details
   * are available, see [Gtk.Printer.hasDetails] and
   * [Gtk.Printer.requestDetails].
   * Returns: a newly
   *   allocated list of newly allocated `GtkPageSetup`s.
   */
  PageSetup[] listPapers()
  {
    GList* _cretval;
    _cretval = gtk_printer_list_papers(cast(GtkPrinter*)cPtr);
    auto _retval = gListToD!(PageSetup, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Requests the printer details.
   * When the details are available, the
   * signalGtk.Printer::details-acquired signal
   * will be emitted on printer.
   */
  void requestDetails()
  {
    gtk_printer_request_details(cast(GtkPrinter*)cPtr);
  }

  /**
   * Emitted in response to a request for detailed information
   * about a printer from the print backend.
   * The success parameter indicates if the information was
   * actually obtained.
   * Params
   *   success = %TRUE if the details were successfully acquired
   *   printer = the instance the signal is connected to
   */
  alias DetailsAcquiredCallback = void delegate(bool success, Printer printer);

  /**
   * Connect to DetailsAcquired signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDetailsAcquired(DetailsAcquiredCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto printer = getVal!Printer(_paramVals);
      auto success = getVal!bool(&_paramVals[1]);
      _dgClosure.dlg(success, printer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("details-acquired", closure, after);
  }
}
