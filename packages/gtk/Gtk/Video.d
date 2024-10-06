module Gtk.Video;

import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.MediaStream;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkVideo` is a widget to show a `GtkMediaStream` with media controls.
 * ![An example GtkVideo](video.png)
 * The controls are available separately as [Gtk.MediaControls].
 * If you just want to display a video without controls, you can treat it
 * like any other paintable and for example put it into a [Gtk.Picture].
 * `GtkVideo` aims to cover use cases such as previews, embedded animations,
 * etc. It supports autoplay, looping, and simple media controls. It does
 * not have support for video overlays, multichannel audio, device
 * selection, or input. If you are writing a full-fledged video player,
 * you may want to use the [Gdk.Paintable] API and a media framework
 * such as Gstreamer directly.
 */
class Video : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_video_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty `GtkVideo`.
   * Returns: a new `GtkVideo`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_video_new();
    this(_cretval, false);
  }

  /**
   * Creates a `GtkVideo` to play back the given file.
   * Params:
   *   file = a `GFile`
   * Returns: a new `GtkVideo`
   */
  static Video newForFile(File file)
  {
    GtkWidget* _cretval;
    _cretval = gtk_video_new_for_file(file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Video(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkVideo` to play back the given filename.
   * This is a utility function that calls [Gtk.Video.newForFile],
   * See that function for details.
   * Params:
   *   filename = filename to play back
   * Returns: a new `GtkVideo`
   */
  static Video newForFilename(string filename)
  {
    GtkWidget* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = gtk_video_new_for_filename(_filename);
    auto _retval = _cretval ? ObjectG.getDObject!Video(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkVideo` to play back the given stream.
   * Params:
   *   stream = a `GtkMediaStream`
   * Returns: a new `GtkVideo`
   */
  static Video newForMediaStream(MediaStream stream)
  {
    GtkWidget* _cretval;
    _cretval = gtk_video_new_for_media_stream(stream ? cast(GtkMediaStream*)stream.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Video(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkVideo` to play back the resource at the
   * given resource_path.
   * This is a utility function that calls [Gtk.Video.newForFile].
   * Params:
   *   resourcePath = resource path to play back
   * Returns: a new `GtkVideo`
   */
  static Video newForResource(string resourcePath)
  {
    GtkWidget* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    _cretval = gtk_video_new_for_resource(_resourcePath);
    auto _retval = _cretval ? ObjectG.getDObject!Video(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if videos have been set to loop.
   * Returns: %TRUE if streams should autoplay
   */
  bool getAutoplay()
  {
    bool _retval;
    _retval = gtk_video_get_autoplay(cast(GtkVideo*)cPtr);
    return _retval;
  }

  /**
   * Gets the file played by self or %NULL if not playing back
   * a file.
   * Returns: The file played by self
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_video_get_file(cast(GtkVideo*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether graphics offload is enabled.
   * See [Gtk.GraphicsOffload] for more information on graphics offload.
   * Returns: the graphics offload status
   */
  GraphicsOffloadEnabled getGraphicsOffload()
  {
    GtkGraphicsOffloadEnabled _cretval;
    _cretval = gtk_video_get_graphics_offload(cast(GtkVideo*)cPtr);
    GraphicsOffloadEnabled _retval = cast(GraphicsOffloadEnabled)_cretval;
    return _retval;
  }

  /**
   * Returns %TRUE if videos have been set to loop.
   * Returns: %TRUE if streams should loop
   */
  bool getLoop()
  {
    bool _retval;
    _retval = gtk_video_get_loop(cast(GtkVideo*)cPtr);
    return _retval;
  }

  /**
   * Gets the media stream managed by self or %NULL if none.
   * Returns: The media stream managed by self
   */
  MediaStream getMediaStream()
  {
    GtkMediaStream* _cretval;
    _cretval = gtk_video_get_media_stream(cast(GtkVideo*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MediaStream(cast(GtkMediaStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets whether self automatically starts playback when it
   * becomes visible or when a new file gets loaded.
   * Params:
   *   autoplay = whether media streams should autoplay
   */
  void setAutoplay(bool autoplay)
  {
    gtk_video_set_autoplay(cast(GtkVideo*)cPtr, autoplay);
  }

  /**
   * Makes self play the given file.
   * Params:
   *   file = the file to play
   */
  void setFile(File file)
  {
    gtk_video_set_file(cast(GtkVideo*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
  }

  /**
   * Makes self play the given filename.
   * This is a utility function that calls [Gtk.Video.setFile],
   * Params:
   *   filename = the filename to play
   */
  void setFilename(string filename)
  {
    const(char)* _filename = filename.toCString(false);
    gtk_video_set_filename(cast(GtkVideo*)cPtr, _filename);
  }

  /**
   * Sets whether to enable graphics offload.
   * See [Gtk.GraphicsOffload] for more information on graphics offload.
   * Params:
   *   enabled = the new graphics offload status
   */
  void setGraphicsOffload(GraphicsOffloadEnabled enabled)
  {
    gtk_video_set_graphics_offload(cast(GtkVideo*)cPtr, enabled);
  }

  /**
   * Sets whether new files loaded by self should be set to loop.
   * Params:
   *   loop = whether media streams should loop
   */
  void setLoop(bool loop)
  {
    gtk_video_set_loop(cast(GtkVideo*)cPtr, loop);
  }

  /**
   * Sets the media stream to be played back.
   * self will take full control of managing the media stream. If you
   * want to manage a media stream yourself, consider using a
   * [Gtk.Picture] for display.
   * If you want to display a file, consider using [Gtk.Video.setFile]
   * instead.
   * Params:
   *   stream = The media stream to play or %NULL to unset
   */
  void setMediaStream(MediaStream stream)
  {
    gtk_video_set_media_stream(cast(GtkVideo*)cPtr, stream ? cast(GtkMediaStream*)stream.cPtr(false) : null);
  }

  /**
   * Makes self play the resource at the given resource_path.
   * This is a utility function that calls [Gtk.Video.setFile].
   * Params:
   *   resourcePath = the resource to set
   */
  void setResource(string resourcePath)
  {
    const(char)* _resourcePath = resourcePath.toCString(false);
    gtk_video_set_resource(cast(GtkVideo*)cPtr, _resourcePath);
  }
}
