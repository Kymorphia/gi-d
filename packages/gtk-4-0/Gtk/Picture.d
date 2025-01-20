module Gtk.Picture;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import GdkPixbuf.Pixbuf;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkPicture` widget displays a `GdkPaintable`.
 * ![An example GtkPicture](picture.png)
 * Many convenience functions are provided to make pictures simple to use.
 * For example, if you want to load an image from a file, and then display
 * it, there’s a convenience function to do this:
 * ```c
 * GtkWidget *widget \= gtk_picture_new_for_filename $(LPAREN)"myfile.png"$(RPAREN);
 * ```
 * If the file isn’t loaded successfully, the picture will contain a
 * “broken image” icon similar to that used in many web browsers.
 * If you want to handle errors in loading the file yourself,
 * for example by displaying an error message, then load the image with
 * [Gdk.Texture.newFromFile], then create the `GtkPicture` with
 * [Gtk.Picture.newForPaintable].
 * Sometimes an application will want to avoid depending on external data
 * files, such as image files. See the documentation of `GResource` for details.
 * In this case, [Gtk.Picture.newForResource] and
 * [Gtk.Picture.setResource] should be used.
 * `GtkPicture` displays an image at its natural size. See [Gtk.Image]
 * if you want to display a fixed-size image, such as an icon.
 * ## Sizing the paintable
 * You can influence how the paintable is displayed inside the `GtkPicture`
 * by changing property@Gtk.Picture:content-fit. See [Gtk]
 * for details. property@Gtk.Picture:can-shrink can be unset to make sure
 * that paintables are never made smaller than their ideal size - but
 * be careful if you do not know the size of the paintable in use $(LPAREN)like
 * when displaying user-loaded images$(RPAREN). This can easily cause the picture to
 * grow larger than the screen. And [Gtk.Widget.halign] and
 * [Gtk.Widget.valign] can be used to make sure the paintable doesn't
 * fill all available space but is instead displayed at its original size.
 * ## CSS nodes
 * `GtkPicture` has a single CSS node with the name `picture`.
 * ## Accessibility
 * `GtkPicture` uses the `GTK_ACCESSIBLE_ROLE_IMG` role.
 */
class Picture : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_picture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty `GtkPicture` widget.
   * Returns: a newly created `GtkPicture` widget.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_picture_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkPicture` displaying the given file.
   * If the file isn’t found or can’t be loaded, the resulting
   * `GtkPicture` is empty.
   * If you need to detect failures to load the file, use
   * [Gdk.Texture.newFromFile] to load the file yourself,
   * then create the `GtkPicture` from the texture.
   * Params:
   *   file = a `GFile`
   * Returns: a new `GtkPicture`
   */
  static Picture newForFile(File file)
  {
    GtkWidget* _cretval;
    _cretval = gtk_picture_new_for_file(file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Picture(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkPicture` displaying the file filename.
   * This is a utility function that calls [Gtk.Picture.newForFile].
   * See that function for details.
   * Params:
   *   filename = a filename
   * Returns: a new `GtkPicture`
   */
  static Picture newForFilename(string filename)
  {
    GtkWidget* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = gtk_picture_new_for_filename(_filename);
    auto _retval = _cretval ? ObjectG.getDObject!Picture(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkPicture` displaying paintable.
   * The `GtkPicture` will track changes to the paintable and update
   * its size and contents in response to it.
   * Params:
   *   paintable = a `GdkPaintable`
   * Returns: a new `GtkPicture`
   */
  static Picture newForPaintable(Paintable paintable)
  {
    GtkWidget* _cretval;
    _cretval = gtk_picture_new_for_paintable(paintable ? cast(GdkPaintable*)(cast(ObjectG)paintable).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Picture(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkPicture` displaying pixbuf.
   * This is a utility function that calls [Gtk.Picture.newForPaintable],
   * See that function for details.
   * The pixbuf must not be modified after passing it to this function.
   * Params:
   *   pixbuf = a `GdkPixbuf`
   * Returns: a new `GtkPicture`

   * Deprecated: Use [Gtk.Picture.newForPaintable] and
   *   [Gdk.Texture.newForPixbuf] instead
   */
  static Picture newForPixbuf(Pixbuf pixbuf)
  {
    GtkWidget* _cretval;
    _cretval = gtk_picture_new_for_pixbuf(pixbuf ? cast(PixbufC*)pixbuf.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Picture(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkPicture` displaying the resource at resource_path.
   * This is a utility function that calls [Gtk.Picture.newForFile].
   * See that function for details.
   * Params:
   *   resourcePath = resource path to play back
   * Returns: a new `GtkPicture`
   */
  static Picture newForResource(string resourcePath)
  {
    GtkWidget* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    _cretval = gtk_picture_new_for_resource(_resourcePath);
    auto _retval = _cretval ? ObjectG.getDObject!Picture(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the alternative textual description of the picture.
   * The returned string will be %NULL if the picture cannot be described textually.
   * Returns: the alternative textual description of self.
   */
  string getAlternativeText()
  {
    const(char)* _cretval;
    _cretval = gtk_picture_get_alternative_text(cast(GtkPicture*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the `GtkPicture` respects its contents size.
   * Returns: %TRUE if the picture can be made smaller than its contents
   */
  bool getCanShrink()
  {
    bool _retval;
    _retval = gtk_picture_get_can_shrink(cast(GtkPicture*)cPtr);
    return _retval;
  }

  /**
   * Returns the fit mode for the content of the `GtkPicture`.
   * See [Gtk] for details.
   * Returns: the content fit mode
   */
  ContentFit getContentFit()
  {
    GtkContentFit _cretval;
    _cretval = gtk_picture_get_content_fit(cast(GtkPicture*)cPtr);
    ContentFit _retval = cast(ContentFit)_cretval;
    return _retval;
  }

  /**
   * Gets the `GFile` currently displayed if self is displaying a file.
   * If self is not displaying a file, for example when
   * [Gtk.Picture.setPaintable] was used, then %NULL is returned.
   * Returns: The `GFile` displayed by self.
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_picture_get_file(cast(GtkPicture*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the `GtkPicture` preserves its contents aspect ratio.
   * Returns: %TRUE if the self tries to keep the contents' aspect ratio

   * Deprecated: Use [Gtk.Picture.getContentFit] instead. This will
   *   now return `FALSE` only if propertyGtk.Picture:content-fit is
   *   `GTK_CONTENT_FIT_FILL`. Returns `TRUE` otherwise.
   */
  bool getKeepAspectRatio()
  {
    bool _retval;
    _retval = gtk_picture_get_keep_aspect_ratio(cast(GtkPicture*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GdkPaintable` being displayed by the `GtkPicture`.
   * Returns: the displayed paintable
   */
  Paintable getPaintable()
  {
    GdkPaintable* _cretval;
    _cretval = gtk_picture_get_paintable(cast(GtkPicture*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets an alternative textual description for the picture contents.
   * It is equivalent to the "alt" attribute for images on websites.
   * This text will be made available to accessibility tools.
   * If the picture cannot be described textually, set this property to %NULL.
   * Params:
   *   alternativeText = a textual description of the contents
   */
  void setAlternativeText(string alternativeText)
  {
    const(char)* _alternativeText = alternativeText.toCString(false);
    gtk_picture_set_alternative_text(cast(GtkPicture*)cPtr, _alternativeText);
  }

  /**
   * If set to %TRUE, the self can be made smaller than its contents.
   * The contents will then be scaled down when rendering.
   * If you want to still force a minimum size manually, consider using
   * [Gtk.Widget.setSizeRequest].
   * Also of note is that a similar function for growing does not exist
   * because the grow behavior can be controlled via
   * [Gtk.Widget.setHalign] and [Gtk.Widget.setValign].
   * Params:
   *   canShrink = if self can be made smaller than its contents
   */
  void setCanShrink(bool canShrink)
  {
    gtk_picture_set_can_shrink(cast(GtkPicture*)cPtr, canShrink);
  }

  /**
   * Sets how the content should be resized to fit the `GtkPicture`.
   * See [Gtk] for details.
   * Params:
   *   contentFit = the content fit mode
   */
  void setContentFit(ContentFit contentFit)
  {
    gtk_picture_set_content_fit(cast(GtkPicture*)cPtr, contentFit);
  }

  /**
   * Makes self load and display file.
   * See [Gtk.Picture.newForFile] for details.
   * Params:
   *   file = a `GFile`
   */
  void setFile(File file)
  {
    gtk_picture_set_file(cast(GtkPicture*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
  }

  /**
   * Makes self load and display the given filename.
   * This is a utility function that calls [Gtk.Picture.setFile].
   * Params:
   *   filename = the filename to play
   */
  void setFilename(string filename)
  {
    const(char)* _filename = filename.toCString(false);
    gtk_picture_set_filename(cast(GtkPicture*)cPtr, _filename);
  }

  /**
   * If set to %TRUE, the self will render its contents according to
   * their aspect ratio.
   * That means that empty space may show up at the top/bottom or
   * left/right of self.
   * If set to %FALSE or if the contents provide no aspect ratio,
   * the contents will be stretched over the picture's whole area.
   * Params:
   *   keepAspectRatio = whether to keep aspect ratio

   * Deprecated: Use [Gtk.Picture.setContentFit] instead. If still
   *   used, this method will always set the propertyGtk.Picture:content-fit
   *   property to `GTK_CONTENT_FIT_CONTAIN` if keep_aspect_ratio is true,
   *   otherwise it will set it to `GTK_CONTENT_FIT_FILL`.
   */
  void setKeepAspectRatio(bool keepAspectRatio)
  {
    gtk_picture_set_keep_aspect_ratio(cast(GtkPicture*)cPtr, keepAspectRatio);
  }

  /**
   * Makes self display the given paintable.
   * If paintable is %NULL, nothing will be displayed.
   * See [Gtk.Picture.newForPaintable] for details.
   * Params:
   *   paintable = a `GdkPaintable`
   */
  void setPaintable(Paintable paintable)
  {
    gtk_picture_set_paintable(cast(GtkPicture*)cPtr, paintable ? cast(GdkPaintable*)(cast(ObjectG)paintable).cPtr(false) : null);
  }

  /**
   * Sets a `GtkPicture` to show a `GdkPixbuf`.
   * See [Gtk.Picture.newForPixbuf] for details.
   * This is a utility function that calls [Gtk.Picture.setPaintable].
   * Params:
   *   pixbuf = a `GdkPixbuf`

   * Deprecated: Use [Gtk.Picture.setPaintable] instead
   */
  void setPixbuf(Pixbuf pixbuf)
  {
    gtk_picture_set_pixbuf(cast(GtkPicture*)cPtr, pixbuf ? cast(PixbufC*)pixbuf.cPtr(false) : null);
  }

  /**
   * Makes self load and display the resource at the given
   * resource_path.
   * This is a utility function that calls [Gtk.Picture.setFile].
   * Params:
   *   resourcePath = the resource to set
   */
  void setResource(string resourcePath)
  {
    const(char)* _resourcePath = resourcePath.toCString(false);
    gtk_picture_set_resource(cast(GtkPicture*)cPtr, _resourcePath);
  }
}
