module Gtk.PrintJob;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.PageSetup;
import Gtk.PrintSettings;
import Gtk.Printer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import cairo.Surface;

/**
 * A `GtkPrintJob` object represents a job that is sent to a printer.
 * You only need to deal directly with print jobs if you use the
 * non-portable [Gtk.PrintUnixDialog] API.
 * Use [Gtk.PrintJob.getSurface] to obtain the cairo surface
 * onto which the pages must be drawn. Use [Gtk.PrintJob.send]
 * to send the finished job to the printer. If you don’t use cairo
 * `GtkPrintJob` also supports printing of manually generated PostScript,
 * via [Gtk.PrintJob.setSourceFile].
 */
class PrintJob : ObjectG
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
    return gtk_print_job_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPrintJob`.
   * Params:
   *   title = the job title
   *   printer = a `GtkPrinter`
   *   settings = a `GtkPrintSettings`
   *   pageSetup = a `GtkPageSetup`
   * Returns: a new `GtkPrintJob`
   */
  this(string title, Printer printer, PrintSettings settings, PageSetup pageSetup)
  {
    GtkPrintJob* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = gtk_print_job_new(_title, printer ? cast(GtkPrinter*)printer.cPtr(false) : null, settings ? cast(GtkPrintSettings*)settings.cPtr(false) : null, pageSetup ? cast(GtkPageSetup*)pageSetup.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets whether this job is printed collated.
   * Returns: whether the job is printed collated
   */
  bool getCollate()
  {
    bool _retval;
    _retval = gtk_print_job_get_collate(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets the n-up setting for this job.
   * Returns: the n-up setting
   */
  uint getNUp()
  {
    uint _retval;
    _retval = gtk_print_job_get_n_up(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets the n-up layout setting for this job.
   * Returns: the n-up layout
   */
  NumberUpLayout getNUpLayout()
  {
    GtkNumberUpLayout _cretval;
    _cretval = gtk_print_job_get_n_up_layout(cast(GtkPrintJob*)cPtr);
    NumberUpLayout _retval = cast(NumberUpLayout)_cretval;
    return _retval;
  }

  /**
   * Gets the number of copies of this job.
   * Returns: the number of copies
   */
  int getNumCopies()
  {
    int _retval;
    _retval = gtk_print_job_get_num_copies(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets the page ranges for this job.
   * Returns: a pointer to an
   *   array of `GtkPageRange` structs
   */
  PageRange[] getPageRanges()
  {
    GtkPageRange* _cretval;
    int _cretlength;
    _cretval = gtk_print_job_get_page_ranges(cast(GtkPrintJob*)cPtr, &_cretlength);
    PageRange[] _retval;

    if (_cretval)
    {
      _retval = new PageRange[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i];
    }
    return _retval;
  }

  /**
   * Gets the `GtkPageSet` setting for this job.
   * Returns: the `GtkPageSet` setting
   */
  PageSet getPageSet()
  {
    GtkPageSet _cretval;
    _cretval = gtk_print_job_get_page_set(cast(GtkPrintJob*)cPtr);
    PageSet _retval = cast(PageSet)_cretval;
    return _retval;
  }

  /**
   * Gets the `GtkPrintPages` setting for this job.
   * Returns: the `GtkPrintPages` setting
   */
  PrintPages getPages()
  {
    GtkPrintPages _cretval;
    _cretval = gtk_print_job_get_pages(cast(GtkPrintJob*)cPtr);
    PrintPages _retval = cast(PrintPages)_cretval;
    return _retval;
  }

  /**
   * Gets the `GtkPrinter` of the print job.
   * Returns: the printer of job
   */
  Printer getPrinter()
  {
    GtkPrinter* _cretval;
    _cretval = gtk_print_job_get_printer(cast(GtkPrintJob*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Printer(cast(GtkPrinter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether this job is printed reversed.
   * Returns: whether the job is printed reversed.
   */
  bool getReverse()
  {
    bool _retval;
    _retval = gtk_print_job_get_reverse(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the job is printed rotated.
   * Returns: whether the job is printed rotated
   */
  bool getRotate()
  {
    bool _retval;
    _retval = gtk_print_job_get_rotate(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets the scale for this job.
   * Returns: the scale
   */
  double getScale()
  {
    double _retval;
    _retval = gtk_print_job_get_scale(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GtkPrintSettings` of the print job.
   * Returns: the settings of job
   */
  PrintSettings getSettings()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_job_get_settings(cast(GtkPrintJob*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the status of the print job.
   * Returns: the status of job
   */
  PrintStatus getStatus()
  {
    GtkPrintStatus _cretval;
    _cretval = gtk_print_job_get_status(cast(GtkPrintJob*)cPtr);
    PrintStatus _retval = cast(PrintStatus)_cretval;
    return _retval;
  }

  /**
   * Gets a cairo surface onto which the pages of
   * the print job should be rendered.
   * Returns: the cairo surface of job
   */
  Surface getSurface()
  {
    cairo_surface_t* _cretval;
    GError *_err;
    _cretval = gtk_print_job_get_surface(cast(GtkPrintJob*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Surface(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the job title.
   * Returns: the title of job
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_print_job_get_title(cast(GtkPrintJob*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether jobs will be tracked after printing.
   * For details, see [Gtk.PrintJob.setTrackPrintStatus].
   * Returns: %TRUE if print job status will be reported after printing
   */
  bool getTrackPrintStatus()
  {
    bool _retval;
    _retval = gtk_print_job_get_track_print_status(cast(GtkPrintJob*)cPtr);
    return _retval;
  }

  /**
   * Sends the print job off to the printer.
   * Params:
   *   callback = function to call when the job completes or an error occurs
   */
  void send(PrintJobCompleteFunc callback)
  {
    extern(C) void _callbackCallback(GtkPrintJob* printJob, void* userData, const(GError)* error)
    {
      auto _dlg = cast(PrintJobCompleteFunc*)userData;

      (*_dlg)(printJob ? ObjectG.getDObject!PrintJob(cast(void*)printJob, false) : null, error ? new ErrorG(cast(void*)error, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_print_job_send(cast(GtkPrintJob*)cPtr, &_callbackCallback, _callback, &thawDelegate);
  }

  /**
   * Sets whether this job is printed collated.
   * Params:
   *   collate = whether the job is printed collated
   */
  void setCollate(bool collate)
  {
    gtk_print_job_set_collate(cast(GtkPrintJob*)cPtr, collate);
  }

  /**
   * Sets the n-up setting for this job.
   * Params:
   *   nUp = the n-up value
   */
  void setNUp(uint nUp)
  {
    gtk_print_job_set_n_up(cast(GtkPrintJob*)cPtr, nUp);
  }

  /**
   * Sets the n-up layout setting for this job.
   * Params:
   *   layout = the n-up layout setting
   */
  void setNUpLayout(NumberUpLayout layout)
  {
    gtk_print_job_set_n_up_layout(cast(GtkPrintJob*)cPtr, layout);
  }

  /**
   * Sets the number of copies for this job.
   * Params:
   *   numCopies = the number of copies
   */
  void setNumCopies(int numCopies)
  {
    gtk_print_job_set_num_copies(cast(GtkPrintJob*)cPtr, numCopies);
  }

  /**
   * Sets the `GtkPageSet` setting for this job.
   * Params:
   *   pageSet = a `GtkPageSet` setting
   */
  void setPageSet(PageSet pageSet)
  {
    gtk_print_job_set_page_set(cast(GtkPrintJob*)cPtr, pageSet);
  }

  /**
   * Sets the `GtkPrintPages` setting for this job.
   * Params:
   *   pages = the `GtkPrintPages` setting
   */
  void setPages(PrintPages pages)
  {
    gtk_print_job_set_pages(cast(GtkPrintJob*)cPtr, pages);
  }

  /**
   * Sets whether this job is printed reversed.
   * Params:
   *   reverse = whether the job is printed reversed
   */
  void setReverse(bool reverse)
  {
    gtk_print_job_set_reverse(cast(GtkPrintJob*)cPtr, reverse);
  }

  /**
   * Sets whether this job is printed rotated.
   * Params:
   *   rotate = whether to print rotated
   */
  void setRotate(bool rotate)
  {
    gtk_print_job_set_rotate(cast(GtkPrintJob*)cPtr, rotate);
  }

  /**
   * Sets the scale for this job.
   * 1.0 means unscaled.
   * Params:
   *   scale = the scale
   */
  void setScale(double scale)
  {
    gtk_print_job_set_scale(cast(GtkPrintJob*)cPtr, scale);
  }

  /**
   * Make the `GtkPrintJob` send an existing document to the
   * printing system.
   * The file can be in any format understood by the platforms
   * printing system $(LPAREN)typically PostScript, but on many platforms
   * PDF may work too$(RPAREN). See [Gtk.Printer.acceptsPdf] and
   * [Gtk.Printer.acceptsPs].
   * This is similar to [Gtk.PrintJob.setSourceFile],
   * but takes expects an open file descriptor for the file,
   * instead of a filename.
   * Params:
   *   fd = a file descriptor
   * Returns: %FALSE if an error occurred
   */
  bool setSourceFd(int fd)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_print_job_set_source_fd(cast(GtkPrintJob*)cPtr, fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Make the `GtkPrintJob` send an existing document to the
   * printing system.
   * The file can be in any format understood by the platforms
   * printing system $(LPAREN)typically PostScript, but on many platforms
   * PDF may work too$(RPAREN). See [Gtk.Printer.acceptsPdf] and
   * [Gtk.Printer.acceptsPs].
   * Params:
   *   filename = the file to be printed
   * Returns: %FALSE if an error occurred
   */
  bool setSourceFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = gtk_print_job_set_source_file(cast(GtkPrintJob*)cPtr, _filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * If track_status is %TRUE, the print job will try to continue report
   * on the status of the print job in the printer queues and printer.
   * This can allow your application to show things like “out of paper”
   * issues, and when the print job actually reaches the printer.
   * This function is often implemented using some form of polling,
   * so it should not be enabled unless needed.
   * Params:
   *   trackStatus = %TRUE to track status after printing
   */
  void setTrackPrintStatus(bool trackStatus)
  {
    gtk_print_job_set_track_print_status(cast(GtkPrintJob*)cPtr, trackStatus);
  }

  /**
   * Emitted when the status of a job changes.
   * The signal handler can use [Gtk.PrintJob.getStatus]
   * to obtain the new status.
   *   printJob = the instance the signal is connected to
   */
  alias StatusChangedCallback = void delegate(PrintJob printJob);

  /**
   * Connect to StatusChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStatusChanged(StatusChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto printJob = getVal!PrintJob(_paramVals);
      _dgClosure.dlg(printJob);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("status-changed", closure, after);
  }
}
