module Gtk.MediaStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Surface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkMediaStream` is the integration point for media playback inside GTK.
 * GTK provides an implementation of the `GtkMediaStream` interface that
 * is called [Gtk.MediaFile].
 * Apart from application-facing API for stream playback, `GtkMediaStream`
 * has a number of APIs that are only useful for implementations and should
 * not be used in applications:
 * [Gtk.MediaStream.prepared],
 * [Gtk.MediaStream.unprepared],
 * [Gtk.MediaStream.update],
 * [Gtk.MediaStream.ended],
 * [Gtk.MediaStream.seekSuccess],
 * [Gtk.MediaStream.seekFailed],
 * [Gtk.MediaStream.gerror],
 * [Gtk.MediaStream.error],
 * [Gtk.MediaStream.errorValist].
 */
class MediaStream : ObjectG, Paintable
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
    return gtk_media_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PaintableT!();

  /**
   * Sets self into an error state.
   * This will pause the stream $(LPAREN)you can check for an error
   * via [Gtk.MediaStream.getError] in your
   * GtkMediaStream.pause$(LPAREN)$(RPAREN) implementation$(RPAREN), abort pending
   * seeks and mark the stream as prepared.
   * if the stream is already in an error state, this call
   * will be ignored and the existing error will be retained.
   * To unset an error, the stream must be reset via a call to
   * [Gtk.MediaStream.unprepared].
   * Params:
   *   error = the `GError` to set
   */
  void gerror(ErrorG error)
  {
    gtk_media_stream_gerror(cast(GtkMediaStream*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Gets the duration of the stream.
   * If the duration is not known, 0 will be returned.
   * Returns: the duration of the stream or 0 if not known.
   */
  long getDuration()
  {
    long _retval;
    _retval = gtk_media_stream_get_duration(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the streams playback is finished.
   * Returns: %TRUE if playback is finished
   */
  bool getEnded()
  {
    bool _retval;
    _retval = gtk_media_stream_get_ended(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * If the stream is in an error state, returns the `GError`
   * explaining that state.
   * Any type of error can be reported here depending on the
   * implementation of the media stream.
   * A media stream in an error cannot be operated on, calls
   * like [Gtk.MediaStream.play] or
   * [Gtk.MediaStream.seek] will not have any effect.
   * `GtkMediaStream` itself does not provide a way to unset
   * an error, but implementations may provide options. For example,
   * a [Gtk.MediaFile] will unset errors when a new source is
   * set, e.g. with [Gtk.MediaFile.setFile].
   * Returns: %NULL if not in an
   *   error state or the `GError` of the stream
   */
  ErrorG getError()
  {
    const(GError)* _cretval;
    _cretval = gtk_media_stream_get_error(cast(GtkMediaStream*)cPtr);
    auto _retval = _cretval ? new ErrorG(cast(GError*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns whether the stream is set to loop.
   * See [Gtk.MediaStream.setLoop] for details.
   * Returns: %TRUE if the stream should loop
   */
  bool getLoop()
  {
    bool _retval;
    _retval = gtk_media_stream_get_loop(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the audio for the stream is muted.
   * See [Gtk.MediaStream.setMuted] for details.
   * Returns: %TRUE if the stream is muted
   */
  bool getMuted()
  {
    bool _retval;
    _retval = gtk_media_stream_get_muted(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Return whether the stream is currently playing.
   * Returns: %TRUE if the stream is playing
   */
  bool getPlaying()
  {
    bool _retval;
    _retval = gtk_media_stream_get_playing(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns the current presentation timestamp in microseconds.
   * Returns: the timestamp in microseconds
   */
  long getTimestamp()
  {
    long _retval;
    _retval = gtk_media_stream_get_timestamp(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns the volume of the audio for the stream.
   * See [Gtk.MediaStream.setVolume] for details.
   * Returns: volume of the stream from 0.0 to 1.0
   */
  double getVolume()
  {
    double _retval;
    _retval = gtk_media_stream_get_volume(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the stream has audio.
   * Returns: %TRUE if the stream has audio
   */
  bool hasAudio()
  {
    bool _retval;
    _retval = gtk_media_stream_has_audio(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the stream has video.
   * Returns: %TRUE if the stream has video
   */
  bool hasVideo()
  {
    bool _retval;
    _retval = gtk_media_stream_has_video(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the stream has finished initializing.
   * At this point the existence of audio and video is known.
   * Returns: %TRUE if the stream is prepared
   */
  bool isPrepared()
  {
    bool _retval;
    _retval = gtk_media_stream_is_prepared(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if a stream may be seekable.
   * This is meant to be a hint. Streams may not allow seeking even if
   * this function returns %TRUE. However, if this function returns
   * %FALSE, streams are guaranteed to not be seekable and user interfaces
   * may hide controls that allow seeking.
   * It is allowed to call [Gtk.MediaStream.seek] on a non-seekable
   * stream, though it will not do anything.
   * Returns: %TRUE if the stream may support seeking
   */
  bool isSeekable()
  {
    bool _retval;
    _retval = gtk_media_stream_is_seekable(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if there is currently a seek operation going on.
   * Returns: %TRUE if a seek operation is ongoing.
   */
  bool isSeeking()
  {
    bool _retval;
    _retval = gtk_media_stream_is_seeking(cast(GtkMediaStream*)cPtr);
    return _retval;
  }

  /**
   * Pauses playback of the stream.
   * If the stream is not playing, do nothing.
   */
  void pause()
  {
    gtk_media_stream_pause(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Starts playing the stream.
   * If the stream is in error or already playing, do nothing.
   */
  void play()
  {
    gtk_media_stream_play(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Called by users to attach the media stream to a `GdkSurface` they manage.
   * The stream can then access the resources of surface for its
   * rendering purposes. In particular, media streams might want to
   * create a `GdkGLContext` or sync to the `GdkFrameClock`.
   * Whoever calls this function is responsible for calling
   * [Gtk.MediaStream.unrealize] before either the stream
   * or surface get destroyed.
   * Multiple calls to this function may happen from different
   * users of the video, even with the same surface. Each of these
   * calls must be followed by its own call to
   * [Gtk.MediaStream.unrealize].
   * It is not required to call this function to make a media stream work.
   * Params:
   *   surface = a `GdkSurface`
   */
  void realize(Surface surface)
  {
    gtk_media_stream_realize(cast(GtkMediaStream*)cPtr, surface ? cast(GdkSurface*)surface.cPtr(false) : null);
  }

  /**
   * Start a seek operation on self to timestamp.
   * If timestamp is out of range, it will be clamped.
   * Seek operations may not finish instantly. While a
   * seek operation is in process, the [Gtk.MediaStream.seeking]
   * property will be set.
   * When calling [Gtk.MediaStream.seek] during an
   * ongoing seek operation, the new seek will override
   * any pending seek.
   * Params:
   *   timestamp = timestamp to seek to.
   */
  void seek(long timestamp)
  {
    gtk_media_stream_seek(cast(GtkMediaStream*)cPtr, timestamp);
  }

  /**
   * Ends a seek operation started via GtkMediaStream.seek$(LPAREN)$(RPAREN) as a failure.
   * This will not cause an error on the stream and will assume that
   * playback continues as if no seek had happened.
   * See [Gtk.MediaStream.seekSuccess] for the other way of
   * ending a seek.
   */
  void seekFailed()
  {
    gtk_media_stream_seek_failed(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Ends a seek operation started via GtkMediaStream.seek$(LPAREN)$(RPAREN) successfully.
   * This function will unset the GtkMediaStream:ended property
   * if it was set.
   * See [Gtk.MediaStream.seekFailed] for the other way of
   * ending a seek.
   */
  void seekSuccess()
  {
    gtk_media_stream_seek_success(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Sets whether the stream should loop.
   * In this case, it will attempt to restart playback
   * from the beginning instead of stopping at the end.
   * Not all streams may support looping, in particular
   * non-seekable streams. Those streams will ignore the
   * loop setting and just end.
   * Params:
   *   loop = %TRUE if the stream should loop
   */
  void setLoop(bool loop)
  {
    gtk_media_stream_set_loop(cast(GtkMediaStream*)cPtr, loop);
  }

  /**
   * Sets whether the audio stream should be muted.
   * Muting a stream will cause no audio to be played, but it
   * does not modify the volume. This means that muting and
   * then unmuting the stream will restore the volume settings.
   * If the stream has no audio, calling this function will
   * still work but it will not have an audible effect.
   * Params:
   *   muted = %TRUE if the stream should be muted
   */
  void setMuted(bool muted)
  {
    gtk_media_stream_set_muted(cast(GtkMediaStream*)cPtr, muted);
  }

  /**
   * Starts or pauses playback of the stream.
   * Params:
   *   playing = whether to start or pause playback
   */
  void setPlaying(bool playing)
  {
    gtk_media_stream_set_playing(cast(GtkMediaStream*)cPtr, playing);
  }

  /**
   * Sets the volume of the audio stream.
   * This function call will work even if the stream is muted.
   * The given volume should range from 0.0 for silence to 1.0
   * for as loud as possible. Values outside of this range will
   * be clamped to the nearest value.
   * If the stream has no audio or is muted, calling this function
   * will still work but it will not have an immediate audible effect.
   * When the stream is unmuted, the new volume setting will take effect.
   * Params:
   *   volume = New volume of the stream from 0.0 to 1.0
   */
  void setVolume(double volume)
  {
    gtk_media_stream_set_volume(cast(GtkMediaStream*)cPtr, volume);
  }

  /**
   * Pauses the media stream and marks it as ended.
   * This is a hint only, calls to [Gtk.MediaStream.play]
   * may still happen.
   * The media stream must be prepared when this function is called.
   */
  void streamEnded()
  {
    gtk_media_stream_stream_ended(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Called by `GtkMediaStream` implementations to advertise the stream
   * being ready to play and providing details about the stream.
   * Note that the arguments are hints. If the stream implementation
   * cannot determine the correct values, it is better to err on the
   * side of caution and return %TRUE. User interfaces will use those
   * values to determine what controls to show.
   * This function may not be called again until the stream has been
   * reset via [Gtk.MediaStream.streamUnprepared].
   * Params:
   *   hasAudio = %TRUE if the stream should advertise audio support
   *   hasVideo = %TRUE if the stream should advertise video support
   *   seekable = %TRUE if the stream should advertise seekability
   *   duration = The duration of the stream or 0 if unknown
   */
  void streamPrepared(bool hasAudio, bool hasVideo, bool seekable, long duration)
  {
    gtk_media_stream_stream_prepared(cast(GtkMediaStream*)cPtr, hasAudio, hasVideo, seekable, duration);
  }

  /**
   * Resets a given media stream implementation.
   * [Gtk.MediaStream.streamPrepared] can then be called again.
   * This function will also reset any error state the stream was in.
   */
  void streamUnprepared()
  {
    gtk_media_stream_stream_unprepared(cast(GtkMediaStream*)cPtr);
  }

  /**
   * Undoes a previous call to [Gtk.MediaStream.realize].
   * This causes the stream to release all resources it had
   * allocated from surface.
   * Params:
   *   surface = the `GdkSurface` the stream was realized with
   */
  void unrealize(Surface surface)
  {
    gtk_media_stream_unrealize(cast(GtkMediaStream*)cPtr, surface ? cast(GdkSurface*)surface.cPtr(false) : null);
  }

  /**
   * Media stream implementations should regularly call this
   * function to update the timestamp reported by the stream.
   * It is up to implementations to call this at the frequency
   * they deem appropriate.
   * The media stream must be prepared when this function is called.
   * Params:
   *   timestamp = the new timestamp
   */
  void update(long timestamp)
  {
    gtk_media_stream_update(cast(GtkMediaStream*)cPtr, timestamp);
  }
}
