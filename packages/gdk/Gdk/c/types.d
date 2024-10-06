module Gdk.c.types;

public import GdkPixbuf.c.types;
public import Gio.c.types;
public import Pango.c.types;
public import PangoCairo.c.types;
public import cairo.c.types;

/**
 * Positioning hints for aligning a surface relative to a rectangle.
 * These hints determine how the surface should be positioned in the case that
 * the surface would fall off-screen if placed in its ideal position.
 * For example, %GDK_ANCHOR_FLIP_X will replace %GDK_GRAVITY_NORTH_WEST with
 * %GDK_GRAVITY_NORTH_EAST and vice versa if the surface extends beyond the left
 * or right edges of the monitor.
 * If %GDK_ANCHOR_SLIDE_X is set, the surface can be shifted horizontally to fit
 * on-screen. If %GDK_ANCHOR_RESIZE_X is set, the surface can be shrunken
 * horizontally to fit.
 * In general, when multiple flags are set, flipping should take precedence over
 * sliding, which should take precedence over resizing.
 */
enum GdkAnchorHints : uint
{
  /**
   * allow flipping anchors horizontally
   */
  FlipX = 1,

  /**
   * allow flipping anchors vertically
   */
  FlipY = 2,

  /**
   * allow sliding surface horizontally
   */
  SlideX = 4,

  /**
   * allow sliding surface vertically
   */
  SlideY = 8,

  /**
   * allow resizing surface horizontally
   */
  ResizeX = 16,

  /**
   * allow resizing surface vertically
   */
  ResizeY = 32,

  /**
   * allow flipping anchors on both axes
   */
  Flip = 3,

  /**
   * allow sliding surface on both axes
   */
  Slide = 12,

  /**
   * allow resizing surface on both axes
   */
  Resize = 48,
}

/**
 * Flags describing the current capabilities of a device/tool.
 */
enum GdkAxisFlags : uint
{
  /**
   * X axis is present
   */
  X = 2,

  /**
   * Y axis is present
   */
  Y = 4,

  /**
   * Scroll X delta axis is present
   */
  DeltaX = 8,

  /**
   * Scroll Y delta axis is present
   */
  DeltaY = 16,

  /**
   * Pressure axis is present
   */
  Pressure = 32,

  /**
   * X tilt axis is present
   */
  Xtilt = 64,

  /**
   * Y tilt axis is present
   */
  Ytilt = 128,

  /**
   * Wheel axis is present
   */
  Wheel = 256,

  /**
   * Distance axis is present
   */
  Distance = 512,

  /**
   * Z-axis rotation is present
   */
  Rotation = 1024,

  /**
   * Slider axis is present
   */
  Slider = 2048,
}

/**
 * Defines how device axes are interpreted by GTK.
 * Note that the X and Y axes are not really needed; pointer devices
 * report their location via the x/y members of events regardless. Whether
 * X and Y are present as axes depends on the GDK backend.
 */
enum GdkAxisUse
{
  /**
   * the axis is ignored.
   */
  Ignore = 0,

  /**
   * the axis is used as the x axis.
   */
  X = 1,

  /**
   * the axis is used as the y axis.
   */
  Y = 2,

  /**
   * the axis is used as the scroll x delta
   */
  DeltaX = 3,

  /**
   * the axis is used as the scroll y delta
   */
  DeltaY = 4,

  /**
   * the axis is used for pressure information.
   */
  Pressure = 5,

  /**
   * the axis is used for x tilt information.
   */
  Xtilt = 6,

  /**
   * the axis is used for y tilt information.
   */
  Ytilt = 7,

  /**
   * the axis is used for wheel information.
   */
  Wheel = 8,

  /**
   * the axis is used for pen/tablet distance information
   */
  Distance = 9,

  /**
   * the axis is used for pen rotation information
   */
  Rotation = 10,

  /**
   * the axis is used for pen slider information
   */
  Slider = 11,

  /**
   * a constant equal to the numerically highest axis value.
   */
  Last = 12,
}

/**
 * Specifies the crossing mode for enter and leave events.
 */
enum GdkCrossingMode
{
  /**
   * crossing because of pointer motion.
   */
  Normal = 0,

  /**
   * crossing because a grab is activated.
   */
  Grab = 1,

  /**
   * crossing because a grab is deactivated.
   */
  Ungrab = 2,

  /**
   * crossing because a GTK grab is activated.
   */
  GtkGrab = 3,

  /**
   * crossing because a GTK grab is deactivated.
   */
  GtkUngrab = 4,

  /**
   * crossing because a GTK widget changed
   * state $(LPAREN)e.g. sensitivity$(RPAREN).
   */
  StateChanged = 5,

  /**
   * crossing because a touch sequence has begun,
   * this event is synthetic as the pointer might have not left the surface.
   */
  TouchBegin = 6,

  /**
   * crossing because a touch sequence has ended,
   * this event is synthetic as the pointer might have not left the surface.
   */
  TouchEnd = 7,

  /**
   * crossing because of a device switch $(LPAREN)i.e.
   * a mouse taking control of the pointer after a touch device$(RPAREN), this event
   * is synthetic as the pointer didn’t leave the surface.
   */
  DeviceSwitch = 8,
}

/**
 * A pad feature.
 */
enum GdkDevicePadFeature
{
  /**
   * a button
   */
  Button = 0,

  /**
   * a ring-shaped interactive area
   */
  Ring = 1,

  /**
   * a straight interactive area
   */
  Strip = 2,
}

/**
 * Indicates the specific type of tool being used being a tablet. Such as an
 * airbrush, pencil, etc.
 */
enum GdkDeviceToolType
{
  /**
   * Tool is of an unknown type.
   */
  Unknown = 0,

  /**
   * Tool is a standard tablet stylus.
   */
  Pen = 1,

  /**
   * Tool is standard tablet eraser.
   */
  Eraser = 2,

  /**
   * Tool is a brush stylus.
   */
  Brush = 3,

  /**
   * Tool is a pencil stylus.
   */
  Pencil = 4,

  /**
   * Tool is an airbrush stylus.
   */
  Airbrush = 5,

  /**
   * Tool is a mouse.
   */
  Mouse = 6,

  /**
   * Tool is a lens cursor.
   */
  Lens = 7,
}

/**
 * Error enumeration for `GdkDmabufTexture`.
 */
enum GdkDmabufError
{
  /**
   * Dmabuf support is not available, because the OS
   * is not Linux, or it was explicitly disabled at compile- or runtime
   */
  NotAvailable = 0,

  /**
   * The requested format is not supported
   */
  UnsupportedFormat = 1,

  /**
   * GTK failed to create the resource for other
   * reasons
   */
  CreationFailed = 2,
}

/**
 * Used in `GdkDrop` and `GdkDrag` to indicate the actions that the
 * destination can and should do with the dropped data.
 */
enum GdkDragAction : uint
{
  /**
   * Copy the data.
   */
  Copy = 1,

  /**
   * Move the data, i.e. first copy it, then delete
   * it from the source using the DELETE target of the X selection protocol.
   */
  Move = 2,

  /**
   * Add a link to the data. Note that this is only
   * useful if source and destination agree on what it means, and is not
   * supported on all platforms.
   */
  Link = 4,

  /**
   * Ask the user what to do with the data.
   */
  Ask = 8,
}

/**
 * Used in `GdkDrag` to the reason of a cancelled DND operation.
 */
enum GdkDragCancelReason
{
  /**
   * There is no suitable drop target.
   */
  NoTarget = 0,

  /**
   * Drag cancelled by the user
   */
  UserCancelled = 1,

  /**
   * Unspecified error.
   */
  Error = 2,
}

/**
 * Specifies the type of the event.
 */
enum GdkEventType
{
  /**
   * the window manager has requested that the toplevel surface be
   * hidden or destroyed, usually when the user clicks on a special icon in the
   * title bar.
   */
  Delete = 0,

  /**
   * the pointer $(LPAREN)usually a mouse$(RPAREN) has moved.
   */
  MotionNotify = 1,

  /**
   * a mouse button has been pressed.
   */
  ButtonPress = 2,

  /**
   * a mouse button has been released.
   */
  ButtonRelease = 3,

  /**
   * a key has been pressed.
   */
  KeyPress = 4,

  /**
   * a key has been released.
   */
  KeyRelease = 5,

  /**
   * the pointer has entered the surface.
   */
  EnterNotify = 6,

  /**
   * the pointer has left the surface.
   */
  LeaveNotify = 7,

  /**
   * the keyboard focus has entered or left the surface.
   */
  FocusChange = 8,

  /**
   * an input device has moved into contact with a sensing
   * surface $(LPAREN)e.g. a touchscreen or graphics tablet$(RPAREN).
   */
  ProximityIn = 9,

  /**
   * an input device has moved out of contact with a sensing
   * surface.
   */
  ProximityOut = 10,

  /**
   * the mouse has entered the surface while a drag is in progress.
   */
  DragEnter = 11,

  /**
   * the mouse has left the surface while a drag is in progress.
   */
  DragLeave = 12,

  /**
   * the mouse has moved in the surface while a drag is in
   * progress.
   */
  DragMotion = 13,

  /**
   * a drop operation onto the surface has started.
   */
  DropStart = 14,

  /**
   * the scroll wheel was turned
   */
  Scroll = 15,

  /**
   * a pointer or keyboard grab was broken.
   */
  GrabBroken = 16,

  /**
   * A new touch event sequence has just started.
   */
  TouchBegin = 17,

  /**
   * A touch event sequence has been updated.
   */
  TouchUpdate = 18,

  /**
   * A touch event sequence has finished.
   */
  TouchEnd = 19,

  /**
   * A touch event sequence has been canceled.
   */
  TouchCancel = 20,

  /**
   * A touchpad swipe gesture event, the current state
   * is determined by its phase field.
   */
  TouchpadSwipe = 21,

  /**
   * A touchpad pinch gesture event, the current state
   * is determined by its phase field.
   */
  TouchpadPinch = 22,

  /**
   * A tablet pad button press event.
   */
  PadButtonPress = 23,

  /**
   * A tablet pad button release event.
   */
  PadButtonRelease = 24,

  /**
   * A tablet pad axis event from a "ring".
   */
  PadRing = 25,

  /**
   * A tablet pad axis event from a "strip".
   */
  PadStrip = 26,

  /**
   * A tablet pad group mode change.
   */
  PadGroupMode = 27,

  /**
   * A touchpad hold gesture event, the current state is determined by its phase
   * field.
   */
  TouchpadHold = 28,

  /**
   * marks the end of the GdkEventType enumeration.
   */
  EventLast = 29,
}

/**
 * Used to represent the different paint clock phases that can be requested.
 * The elements of the enumeration correspond to the signals of `GdkFrameClock`.
 */
enum GdkFrameClockPhase : uint
{
  /**
   * no phase
   */
  None = 0,

  /**
   * corresponds to GdkFrameClock::flush-events. Should not be handled by applications.
   */
  FlushEvents = 1,

  /**
   * corresponds to GdkFrameClock::before-paint. Should not be handled by applications.
   */
  BeforePaint = 2,

  /**
   * corresponds to GdkFrameClock::update.
   */
  Update = 4,

  /**
   * corresponds to GdkFrameClock::layout. Should not be handled by applications.
   */
  Layout = 8,

  /**
   * corresponds to GdkFrameClock::paint.
   */
  Paint = 16,

  /**
   * corresponds to GdkFrameClock::resume-events. Should not be handled by applications.
   */
  ResumeEvents = 32,

  /**
   * corresponds to GdkFrameClock::after-paint. Should not be handled by applications.
   */
  AfterPaint = 64,
}

/**
 * Indicates which monitor a surface should span over when in fullscreen mode.
 */
enum GdkFullscreenMode
{
  /**
   * Fullscreen on current monitor only.
   */
  CurrentMonitor = 0,

  /**
   * Span across all monitors when fullscreen.
   */
  AllMonitors = 1,
}

/**
 * The list of the different APIs that GdkGLContext can potentially support.
 */
enum GdkGLAPI : uint
{
  /**
   * The OpenGL API
   */
  Gl = 1,

  /**
   * The OpenGL ES API
   */
  Gles = 2,
}

/**
 * Error enumeration for `GdkGLContext`.
 */
enum GdkGLError
{
  /**
   * OpenGL support is not available
   */
  NotAvailable = 0,

  /**
   * The requested visual format is not supported
   */
  UnsupportedFormat = 1,

  /**
   * The requested profile is not supported
   */
  UnsupportedProfile = 2,

  /**
   * The shader compilation failed
   */
  CompilationFailed = 3,

  /**
   * The shader linking failed
   */
  LinkFailed = 4,
}

/**
 * Defines the reference point of a surface and is used in `GdkPopupLayout`.
 */
enum GdkGravity
{
  /**
   * the reference point is at the top left corner.
   */
  NorthWest = 1,

  /**
   * the reference point is in the middle of the top edge.
   */
  North = 2,

  /**
   * the reference point is at the top right corner.
   */
  NorthEast = 3,

  /**
   * the reference point is at the middle of the left edge.
   */
  West = 4,

  /**
   * the reference point is at the center of the surface.
   */
  Center = 5,

  /**
   * the reference point is at the middle of the right edge.
   */
  East = 6,

  /**
   * the reference point is at the lower left corner.
   */
  SouthWest = 7,

  /**
   * the reference point is at the middle of the lower edge.
   */
  South = 8,

  /**
   * the reference point is at the lower right corner.
   */
  SouthEast = 9,

  /**
   * the reference point is at the top left corner of the
   * surface itself, ignoring window manager decorations.
   */
  Static = 10,
}

/**
 * An enumeration describing the type of an input device in general terms.
 */
enum GdkInputSource
{
  /**
   * the device is a mouse. $(LPAREN)This will be reported for the core
   * pointer, even if it is something else, such as a trackball.$(RPAREN)
   */
  Mouse = 0,

  /**
   * the device is a stylus of a graphics tablet or similar device.
   */
  Pen = 1,

  /**
   * the device is a keyboard.
   */
  Keyboard = 2,

  /**
   * the device is a direct-input touch device, such
   * as a touchscreen or tablet
   */
  Touchscreen = 3,

  /**
   * the device is an indirect touch device, such
   * as a touchpad
   */
  Touchpad = 4,

  /**
   * the device is a trackpoint
   */
  Trackpoint = 5,

  /**
   * the device is a "pad", a collection of buttons,
   * rings and strips found in drawing tablets
   */
  TabletPad = 6,
}

/**
 * Describes how well an event matches a given keyval and modifiers.
 * `GdkKeyMatch` values are returned by [Gdk.KeyEvent.matches].
 */
enum GdkKeyMatch
{
  /**
   * The key event does not match
   */
  None = 0,

  /**
   * The key event matches if keyboard state
   * $(LPAREN)specifically, the currently active group$(RPAREN) is ignored
   */
  Partial = 1,

  /**
   * The key event matches
   */
  Exact = 2,
}

/**
 * `GdkMemoryFormat` describes formats that image data can have in memory.
 * It describes formats by listing the contents of the memory passed to it.
 * So `GDK_MEMORY_A8R8G8B8` will be 1 byte $(LPAREN)8 bits$(RPAREN) of alpha, followed by a
 * byte each of red, green and blue. It is not endian-dependent, so
 * `CAIRO_FORMAT_ARGB32` is represented by different `GdkMemoryFormats`
 * on architectures with different endiannesses.
 * Its naming is modelled after
 * [VkFormat](https://www.khronos.org/registry/vulkan/specs/1.0/html/vkspec.html#VkFormat)
 * for details$(RPAREN).
 */
enum GdkMemoryFormat
{
  /**
   * 4 bytes; for blue, green, red, alpha.
   * The color values are premultiplied with the alpha value.
   */
  B8g8r8a8Premultiplied = 0,

  /**
   * 4 bytes; for alpha, red, green, blue.
   * The color values are premultiplied with the alpha value.
   */
  A8r8g8b8Premultiplied = 1,

  /**
   * 4 bytes; for red, green, blue, alpha
   * The color values are premultiplied with the alpha value.
   */
  R8g8b8a8Premultiplied = 2,

  /**
   * 4 bytes; for blue, green, red, alpha.
   */
  B8g8r8a8 = 3,

  /**
   * 4 bytes; for alpha, red, green, blue.
   */
  A8r8g8b8 = 4,

  /**
   * 4 bytes; for red, green, blue, alpha.
   */
  R8g8b8a8 = 5,

  /**
   * 4 bytes; for alpha, blue, green, red.
   */
  A8b8g8r8 = 6,

  /**
   * 3 bytes; for red, green, blue. The data is opaque.
   */
  R8g8b8 = 7,

  /**
   * 3 bytes; for blue, green, red. The data is opaque.
   */
  B8g8r8 = 8,

  /**
   * 3 guint16 values; for red, green, blue.
   */
  R16g16b16 = 9,

  /**
   * 4 guint16 values; for red, green, blue, alpha. The color values are
   * premultiplied with the alpha value.
   */
  R16g16b16a16Premultiplied = 10,

  /**
   * 4 guint16 values; for red, green, blue, alpha.
   */
  R16g16b16a16 = 11,

  /**
   * 3 half-float values; for red, green, blue. The data is opaque.
   */
  R16g16b16Float = 12,

  /**
   * 4 half-float values; for red, green, blue and alpha. The color values are
   * premultiplied with the alpha value.
   */
  R16g16b16a16FloatPremultiplied = 13,

  /**
   * 4 half-float values; for red, green, blue and alpha.
   */
  R16g16b16a16Float = 14,

  /**
   * 3 float values; for red, green, blue.
   */
  R32g32b32Float = 15,

  /**
   * 4 float values; for red, green, blue and alpha. The color values are
   * premultiplied with the alpha value.
   */
  R32g32b32a32FloatPremultiplied = 16,

  /**
   * 4 float values; for red, green, blue and alpha.
   */
  R32g32b32a32Float = 17,

  /**
   * 2 bytes; for grayscale, alpha. The color values are premultiplied with the
   * alpha value.
   */
  G8a8Premultiplied = 18,

  /**
   * 2 bytes; for grayscale, alpha.
   */
  G8a8 = 19,

  /**
   * One byte; for grayscale. The data is opaque.
   */
  G8 = 20,

  /**
   * 2 guint16 values; for grayscale, alpha. The color values are premultiplied
   * with the alpha value.
   */
  G16a16Premultiplied = 21,

  /**
   * 2 guint16 values; for grayscale, alpha.
   */
  G16a16 = 22,

  /**
   * One guint16 value; for grayscale. The data is opaque.
   */
  G16 = 23,

  /**
   * One byte; for alpha.
   */
  A8 = 24,

  /**
   * One guint16 value; for alpha.
   */
  A16 = 25,

  /**
   * One half-float value; for alpha.
   */
  A16Float = 26,

  /**
   * One float value; for alpha.
   */
  A32Float = 27,

  /**
   * 4 bytes; for alpha, blue, green, red, The color values are premultiplied with
   * the alpha value.
   */
  A8b8g8r8Premultiplied = 28,

  /**
   * 4 bytes; for blue, green, red, unused.
   */
  B8g8r8x8 = 29,

  /**
   * 4 bytes; for unused, red, green, blue.
   */
  X8r8g8b8 = 30,

  /**
   * 4 bytes; for red, green, blue, unused.
   */
  R8g8b8x8 = 31,

  /**
   * 4 bytes; for unused, blue, green, red.
   */
  X8b8g8r8 = 32,

  /**
   * The number of formats. This value will change as
   * more formats get added, so do not rely on its concrete integer.
   */
  NFormats = 33,
}

/**
 * Flags to indicate the state of modifier keys and mouse buttons
 * in events.
 * Typical modifier keys are Shift, Control, Meta, Super, Hyper, Alt, Compose,
 * Apple, CapsLock or ShiftLock.
 * Note that GDK may add internal values to events which include values outside
 * of this enumeration. Your code should preserve and ignore them.  You can use
 * %GDK_MODIFIER_MASK to remove all private values.
 */
enum GdkModifierType : uint
{
  /**
   * No modifier.
   */
  NoModifierMask = 0,

  /**
   * the Shift key.
   */
  ShiftMask = 1,

  /**
   * a Lock key $(LPAREN)depending on the modifier mapping of the
   * X server this may either be CapsLock or ShiftLock$(RPAREN).
   */
  LockMask = 2,

  /**
   * the Control key.
   */
  ControlMask = 4,

  /**
   * the fourth modifier key $(LPAREN)it depends on the modifier
   * mapping of the X server which key is interpreted as this modifier, but
   * normally it is the Alt key$(RPAREN).
   */
  AltMask = 8,

  /**
   * the first mouse button.
   */
  Button1Mask = 256,

  /**
   * the second mouse button.
   */
  Button2Mask = 512,

  /**
   * the third mouse button.
   */
  Button3Mask = 1024,

  /**
   * the fourth mouse button.
   */
  Button4Mask = 2048,

  /**
   * the fifth mouse button.
   */
  Button5Mask = 4096,

  /**
   * the Super modifier
   */
  SuperMask = 67108864,

  /**
   * the Hyper modifier
   */
  HyperMask = 134217728,

  /**
   * the Meta modifier
   */
  MetaMask = 268435456,
}

/**
 * Specifies the kind of crossing for enter and leave events.
 * See the X11 protocol specification of LeaveNotify for
 * full details of crossing event generation.
 */
enum GdkNotifyType
{
  /**
   * the surface is entered from an ancestor or
   * left towards an ancestor.
   */
  Ancestor = 0,

  /**
   * the pointer moves between an ancestor and an
   * inferior of the surface.
   */
  Virtual = 1,

  /**
   * the surface is entered from an inferior or
   * left towards an inferior.
   */
  Inferior = 2,

  /**
   * the surface is entered from or left towards
   * a surface which is neither an ancestor nor an inferior.
   */
  Nonlinear = 3,

  /**
   * the pointer moves between two surfaces
   * which are not ancestors of each other and the surface is part of
   * the ancestor chain between one of these surfaces and their least
   * common ancestor.
   */
  NonlinearVirtual = 4,

  /**
   * an unknown type of enter/leave event occurred.
   */
  Unknown = 5,
}

/**
 * Flags about a paintable object.
 * Implementations use these for optimizations such as caching.
 */
enum GdkPaintableFlags : uint
{
  /**
   * The size is immutable.
   * The signal@Gdk.Paintable::invalidate-size signal will never be
   * emitted.
   */
  Size = 1,

  /**
   * The content is immutable.
   * The signal@Gdk.Paintable::invalidate-contents signal will never be
   * emitted.
   */
  Contents = 2,
}

/**
 * Specifies the direction for scroll events.
 */
enum GdkScrollDirection
{
  /**
   * the surface is scrolled up.
   */
  Up = 0,

  /**
   * the surface is scrolled down.
   */
  Down = 1,

  /**
   * the surface is scrolled to the left.
   */
  Left = 2,

  /**
   * the surface is scrolled to the right.
   */
  Right = 3,

  /**
   * the scrolling is determined by the delta values
   * in scroll events. See [Gdk.ScrollEvent.getDeltas]
   */
  Smooth = 4,
}

/**
 * Specifies the unit of scroll deltas.
 * When you get %GDK_SCROLL_UNIT_WHEEL, a delta of 1.0 means 1 wheel detent
 * click in the south direction, 2.0 means 2 wheel detent clicks in the south
 * direction... This is the same logic for negative values but in the north
 * direction.
 * If you get %GDK_SCROLL_UNIT_SURFACE, are managing a scrollable view and get a
 * value of 123, you have to scroll 123 surface logical pixels right if it's
 * @delta_x or down if it's @delta_y. This is the same logic for negative values
 * but you have to scroll left instead of right if it's @delta_x and up instead
 * of down if it's @delta_y.
 * 1 surface logical pixel is equal to 1 real screen pixel multiplied by the
 * final scale factor of your graphical interface $(LPAREN)the product of the desktop
 * scale factor and eventually a custom scale factor in your app$(RPAREN).
 */
enum GdkScrollUnit
{
  /**
   * The delta is in number of wheel clicks.
   */
  Wheel = 0,

  /**
   * The delta is in surface pixels to scroll directly
   * on screen.
   */
  Surface = 1,
}

/**
 * Flags describing the seat capabilities.
 */
enum GdkSeatCapabilities : uint
{
  /**
   * No input capabilities
   */
  None = 0,

  /**
   * The seat has a pointer $(LPAREN)e.g. mouse$(RPAREN)
   */
  Pointer = 1,

  /**
   * The seat has touchscreen$(LPAREN)s$(RPAREN) attached
   */
  Touch = 2,

  /**
   * The seat has drawing tablet$(LPAREN)s$(RPAREN) attached
   */
  TabletStylus = 4,

  /**
   * The seat has keyboard$(LPAREN)s$(RPAREN) attached
   */
  Keyboard = 8,

  /**
   * The seat has drawing tablet pad$(LPAREN)s$(RPAREN) attached
   */
  TabletPad = 16,

  /**
   * The union of all pointing capabilities
   */
  AllPointing = 7,

  /**
   * The union of all capabilities
   */
  All = 31,
}

/**
 * This enumeration describes how the red, green and blue components
 * of physical pixels on an output device are laid out.
 */
enum GdkSubpixelLayout
{
  /**
   * The layout is not known
   */
  Unknown = 0,

  /**
   * Not organized in this way
   */
  None = 1,

  /**
   * The layout is horizontal, the order is RGB
   */
  HorizontalRgb = 2,

  /**
   * The layout is horizontal, the order is BGR
   */
  HorizontalBgr = 3,

  /**
   * The layout is vertical, the order is RGB
   */
  VerticalRgb = 4,

  /**
   * The layout is vertical, the order is BGR
   */
  VerticalBgr = 5,
}

/**
 * Determines a surface edge or corner.
 */
enum GdkSurfaceEdge
{
  /**
   * the top left corner.
   */
  NorthWest = 0,

  /**
   * the top edge.
   */
  North = 1,

  /**
   * the top right corner.
   */
  NorthEast = 2,

  /**
   * the left edge.
   */
  West = 3,

  /**
   * the right edge.
   */
  East = 4,

  /**
   * the lower left corner.
   */
  SouthWest = 5,

  /**
   * the lower edge.
   */
  South = 6,

  /**
   * the lower right corner.
   */
  SouthEast = 7,
}

/**
 * Possible errors that can be returned by `GdkTexture` constructors.
 */
enum GdkTextureError
{
  /**
   * Not enough memory to handle this image
   */
  TooLarge = 0,

  /**
   * The image data appears corrupted
   */
  CorruptImage = 1,

  /**
   * The image contains features
   * that cannot be loaded
   */
  UnsupportedContent = 2,

  /**
   * The image format is not supported
   */
  UnsupportedFormat = 3,
}

enum GdkTitlebarGesture
{
  DoubleClick = 1,

  RightClick = 2,

  MiddleClick = 3,
}

/**
 * Specifies the state of a toplevel surface.
 * On platforms that support information about individual edges, the
 * %GDK_TOPLEVEL_STATE_TILED state will be set whenever any of the individual
 * tiled states is set. On platforms that lack that support, the tiled state
 * will give an indication of tiledness without any of the per-edge states
 * being set.
 */
enum GdkToplevelState : uint
{
  /**
   * the surface is minimized
   */
  Minimized = 1,

  /**
   * the surface is maximized
   */
  Maximized = 2,

  /**
   * the surface is sticky
   */
  Sticky = 4,

  /**
   * the surface is maximized without decorations
   */
  Fullscreen = 8,

  /**
   * the surface is kept above other surfaces
   */
  Above = 16,

  /**
   * the surface is kept below other surfaces
   */
  Below = 32,

  /**
   * the surface is presented as focused $(LPAREN)with active decorations$(RPAREN)
   */
  Focused = 64,

  /**
   * the surface is in a tiled state
   */
  Tiled = 128,

  /**
   * whether the top edge is tiled
   */
  TopTiled = 256,

  /**
   * whether the top edge is resizable
   */
  TopResizable = 512,

  /**
   * whether the right edge is tiled
   */
  RightTiled = 1024,

  /**
   * whether the right edge is resizable
   */
  RightResizable = 2048,

  /**
   * whether the bottom edge is tiled
   */
  BottomTiled = 4096,

  /**
   * whether the bottom edge is resizable
   */
  BottomResizable = 8192,

  /**
   * whether the left edge is tiled
   */
  LeftTiled = 16384,

  /**
   * whether the left edge is resizable
   */
  LeftResizable = 32768,

  /**
   * the surface is not visible to the user
   */
  Suspended = 65536,
}

/**
 * Specifies the current state of a touchpad gesture.
 * All gestures are guaranteed to begin with an event with phase
 * %GDK_TOUCHPAD_GESTURE_PHASE_BEGIN, followed by 0 or several events
 * with phase %GDK_TOUCHPAD_GESTURE_PHASE_UPDATE.
 * A finished gesture may have 2 possible outcomes, an event with phase
 * %GDK_TOUCHPAD_GESTURE_PHASE_END will be emitted when the gesture is
 * considered successful, this should be used as the hint to perform any
 * permanent changes.
 * Cancelled gestures may be so for a variety of reasons, due to hardware
 * or the compositor, or due to the gesture recognition layers hinting the
 * gesture did not finish resolutely $(LPAREN)eg. a 3rd finger being added during
 * a pinch gesture$(RPAREN). In these cases, the last event will report the phase
 * %GDK_TOUCHPAD_GESTURE_PHASE_CANCEL, this should be used as a hint
 * to undo any visible/permanent changes that were done throughout the
 * progress of the gesture.
 */
enum GdkTouchpadGesturePhase
{
  /**
   * The gesture has begun.
   */
  Begin = 0,

  /**
   * The gesture has been updated.
   */
  Update = 1,

  /**
   * The gesture was finished, changes
   * should be permanently applied.
   */
  End = 2,

  /**
   * The gesture was cancelled, all
   * changes should be undone.
   */
  Cancel = 3,
}

/**
 * Error enumeration for `GdkVulkanContext`.
 */
enum GdkVulkanError
{
  /**
   * Vulkan is not supported on this backend or has not been
   * compiled in.
   */
  Unsupported = 0,

  /**
   * Vulkan support is not available on this Surface
   */
  NotAvailable = 1,
}

/**
 * `GdkAppLaunchContext` handles launching an application in a graphical context.
 * It is an implementation of `GAppLaunchContext` that provides startup
 * notification and allows to launch applications on a specific workspace.
 * ## Launching an application
 * ```c
 * GdkAppLaunchContext *context;
 * context \= gdk_display_get_app_launch_context $(LPAREN)display$(RPAREN);
 * gdk_app_launch_context_set_timestamp $(LPAREN)gdk_event_get_time $(LPAREN)event$(RPAREN)$(RPAREN);
 * if $(LPAREN)!g_app_info_launch_default_for_uri $(LPAREN)"http://www.gtk.org", context, &error$(RPAREN)$(RPAREN)
 * g_warning $(LPAREN)"Launching failed: %s\n", error->message$(RPAREN);
 * g_object_unref $(LPAREN)context$(RPAREN);
 * ```
 */
struct GdkAppLaunchContext;

/**
 * An event related to a button on a pointer device.
 */
struct GdkButtonEvent;

/**
 * `GdkCairoContext` is an object representing the platform-specific
 * draw context.
 * `GdkCairoContext`s are created for a surface using
 * [Gdk.Surface.createCairoContext], and the context
 * can then be used to draw on that surface.
 */
struct GdkCairoContext;

/**
 * The `GdkClipboard` object represents data shared between applications or
 * inside an application.
 * To get a `GdkClipboard` object, use [Gdk.Display.getClipboard] or
 * [Gdk.Display.getPrimaryClipboard]. You can find out about the data
 * that is currently available in a clipboard using
 * [Gdk.Clipboard.getFormats].
 * To make text or image data available in a clipboard, use
 * [Gdk.Clipboard.setText] or [Gdk.Clipboard.setTexture].
 * For other data, you can use [Gdk.Clipboard.setContent], which
 * takes a [Gdk.ContentProvider] object.
 * To read textual or image data from a clipboard, use
 * [Gdk.Clipboard.readTextAsync] or
 * [Gdk.Clipboard.readTextureAsync]. For other data, use
 * [Gdk.Clipboard.readAsync], which provides a `GInputStream` object.
 */
struct GdkClipboard;

/**
 * A `GdkContentDeserializer` is used to deserialize content received via
 * inter-application data transfers.
 * The `GdkContentDeserializer` transforms serialized content that is
 * identified by a mime type into an object identified by a GType.
 * GTK provides serializers and deserializers for common data types
 * such as text, colors, images or file lists. To register your own
 * deserialization functions, use func@content_register_deserializer.
 * Also see [Gdk.ContentSerializer].
 */
struct GdkContentDeserializer;

/**
 * The `GdkContentFormats` structure is used to advertise and negotiate the
 * format of content.
 * You will encounter `GdkContentFormats` when interacting with objects
 * controlling operations that pass data between different widgets, window
 * or application, like [Gdk.Drag], [Gdk.Drop],
 * [Gdk.Clipboard] or [Gdk.ContentProvider].
 * GDK supports content in 2 forms: `GType` and mime type.
 * Using `GTypes` is meant only for in-process content transfers. Mime types
 * are meant to be used for data passing both in-process and out-of-process.
 * The details of how data is passed is described in the documentation of
 * the actual implementations. To transform between the two forms,
 * [Gdk.ContentSerializer] and [Gdk.ContentDeserializer] are used.
 * A `GdkContentFormats` describes a set of possible formats content can be
 * exchanged in. It is assumed that this set is ordered. `GTypes` are more
 * important than mime types. Order between different `GTypes` or mime types
 * is the order they were added in, most important first. Functions that
 * care about order, such as [Gdk.ContentFormats.union_], will describe
 * in their documentation how they interpret that order, though in general the
 * order of the first argument is considered the primary order of the result,
 * followed by the order of further arguments.
 * For debugging purposes, the function [Gdk.ContentFormats.toString_]
 * exists. It will print a comma-separated list of formats from most important
 * to least important.
 * `GdkContentFormats` is an immutable struct. After creation, you cannot change
 * the types it represents. Instead, new `GdkContentFormats` have to be created.
 * The [Gdk.ContentFormatsBuilder] structure is meant to help in this
 * endeavor.
 */
struct GdkContentFormats;

/**
 * A `GdkContentFormatsBuilder` is an auxiliary struct used to create
 * new `GdkContentFormats`, and should not be kept around.
 */
struct GdkContentFormatsBuilder;

/**
 * A `GdkContentProvider` is used to provide content for the clipboard or
 * for drag-and-drop operations in a number of formats.
 * To create a `GdkContentProvider`, use [Gdk.ContentProvider.newForValue]
 * or [Gdk.ContentProvider.newForBytes].
 * GDK knows how to handle common text and image formats out-of-the-box. See
 * [Gdk.ContentSerializer] and [Gdk.ContentDeserializer] if you want
 * to add support for application-specific data formats.
 */
struct GdkContentProvider
{
  ObjectC parent;
}

/**
 * Class structure for `GdkContentProvider`.
 */
struct GdkContentProviderClass
{
  GObjectClass parentClass;

  /**
   * Signal class closure for `GdkContentProvider::content-changed`
   */
  extern(C) void function(GdkContentProvider* provider) contentChanged;

  extern(C) void function(GdkContentProvider* provider, GdkClipboard* clipboard) attachClipboard;

  extern(C) void function(GdkContentProvider* provider, GdkClipboard* clipboard) detachClipboard;

  extern(C) GdkContentFormats* function(GdkContentProvider* provider) refFormats;

  extern(C) GdkContentFormats* function(GdkContentProvider* provider) refStorableFormats;

  extern(C) void function(GdkContentProvider* provider, const(char)* mimeType, GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) writeMimeTypeAsync;

  extern(C) bool function(GdkContentProvider* provider, GAsyncResult* result, GError** _err) writeMimeTypeFinish;

  extern(C) bool function(GdkContentProvider* provider, GValue* value, GError** _err) getValue;

  void*[8] padding;
}

/**
 * A `GdkContentSerializer` is used to serialize content for
 * inter-application data transfers.
 * The `GdkContentSerializer` transforms an object that is identified
 * by a GType into a serialized form $(LPAREN)i.e. a byte stream$(RPAREN) that is
 * identified by a mime type.
 * GTK provides serializers and deserializers for common data types
 * such as text, colors, images or file lists. To register your own
 * serialization functions, use func@Gdk.content_register_serializer.
 * Also see [Gdk.ContentDeserializer].
 */
struct GdkContentSerializer;

/**
 * An event caused by a pointing device moving between surfaces.
 */
struct GdkCrossingEvent;

/**
 * `GdkCursor` is used to create and destroy cursors.
 * Cursors are immutable objects, so once you created them, there is no way
 * to modify them later. You should create a new cursor when you want to change
 * something about it.
 * Cursors by themselves are not very interesting: they must be bound to a
 * window for users to see them. This is done with [Gdk.Surface.setCursor]
 * or [Gdk.Surface.setDeviceCursor]. Applications will typically
 * use higher-level GTK functions such as [[Gtk.Widget.setCursor]](../gtk4/method.Widget.set_cursor.html)
 * instead.
 * Cursors are not bound to a given [Gdk.Display], so they can be shared.
 * However, the appearance of cursors may vary when used on different
 * platforms.
 * ## Named and texture cursors
 * There are multiple ways to create cursors. The platform's own cursors
 * can be created with [Gdk.Cursor.newFromName]. That function lists
 * the commonly available names that are shared with the CSS specification.
 * Other names may be available, depending on the platform in use. On some
 * platforms, what images are used for named cursors may be influenced by
 * the cursor theme.
 * Another option to create a cursor is to use [Gdk.Cursor.newFromTexture]
 * and provide an image to use for the cursor.
 * To ease work with unsupported cursors, a fallback cursor can be provided.
 * If a [Gdk.Surface] cannot use a cursor because of the reasons mentioned
 * above, it will try the fallback cursor. Fallback cursors can themselves have
 * fallback cursors again, so it is possible to provide a chain of progressively
 * easier to support cursors. If none of the provided cursors can be supported,
 * the default cursor will be the ultimate fallback.
 */
struct GdkCursor;

/**
 * An event related to drag and drop operations.
 */
struct GdkDNDEvent;

/**
 * An event related to closing a top-level surface.
 */
struct GdkDeleteEvent;

/**
 * The `GdkDevice` object represents an input device, such
 * as a keyboard, a mouse, or a touchpad.
 * See the [Gdk.Seat] documentation for more information
 * about the various kinds of devices, and their relationships.
 */
struct GdkDevice;

/**
 * `GdkDevicePad` is an interface implemented by devices of type
 * %GDK_SOURCE_TABLET_PAD
 * It allows querying the features provided by the pad device.
 * Tablet pads may contain one or more groups, each containing a subset
 * of the buttons/rings/strips available. [Gdk.DevicePad.getNGroups]
 * can be used to obtain the number of groups, [Gdk.DevicePad.getNFeatures]
 * and [Gdk.DevicePad.getFeatureGroup] can be combined to find out
 * the number of buttons/rings/strips the device has, and how are they grouped.
 * Each of those groups have different modes, which may be used to map each
 * individual pad feature to multiple actions. Only one mode is effective
 * $(LPAREN)current$(RPAREN) for each given group, different groups may have different
 * current modes. The number of available modes in a group can be found
 * out through [Gdk.DevicePad.getGroupNModes], and the current mode
 * for a given group will be notified through events of type `GDK_PAD_GROUP_MODE`.
 */
struct GdkDevicePad;

struct GdkDevicePadInterface;

/**
 * A physical tool associated to a `GdkDevice`.
 */
struct GdkDeviceTool;

/**
 * `GdkDisplay` objects are the GDK representation of a workstation.
 * Their purpose are two-fold:
 * - To manage and provide information about input devices $(LPAREN)pointers, keyboards, etc$(RPAREN)
 * - To manage and provide information about output devices $(LPAREN)monitors, projectors, etc$(RPAREN)
 * Most of the input device handling has been factored out into separate
 * [Gdk.Seat] objects. Every display has a one or more seats, which
 * can be accessed with [Gdk.Display.getDefaultSeat] and
 * [Gdk.Display.listSeats].
 * Output devices are represented by [Gdk.MonitorG] objects, which can
 * be accessed with [Gdk.Display.getMonitorAtSurface] and similar APIs.
 */
struct GdkDisplay;

/**
 * A singleton object that offers notification when displays appear or
 * disappear.
 * You can use [Gdk.DisplayManager.get] to obtain the `GdkDisplayManager`
 * singleton, but that should be rarely necessary. Typically, initializing
 * GTK opens a display that you can work with without ever accessing the
 * `GdkDisplayManager`.
 * The GDK library can be built with support for multiple backends.
 * The `GdkDisplayManager` object determines which backend is used
 * at runtime.
 * In the rare case that you need to influence which of the backends
 * is being used, you can use func@Gdk.set_allowed_backends. Note
 * that you need to call this function before initializing GTK.
 * ## Backend-specific code
 * When writing backend-specific code that is supposed to work with
 * multiple GDK backends, you have to consider both compile time and
 * runtime. At compile time, use the `GDK_WINDOWING_X11`, `GDK_WINDOWING_WIN32`
 * macros, etc. to find out which backends are present in the GDK library
 * you are building your application against. At runtime, use type-check
 * macros like GDK_IS_X11_DISPLAY$(LPAREN)$(RPAREN) to find out which backend is in use:
 * ```c
 * #ifdef GDK_WINDOWING_X11
 * if $(LPAREN)GDK_IS_X11_DISPLAY $(LPAREN)display$(RPAREN)$(RPAREN)
 * {
 * // make X11-specific calls here
 * }
 * else
 * #endif
 * #ifdef GDK_WINDOWING_MACOS
 * if $(LPAREN)GDK_IS_MACOS_DISPLAY $(LPAREN)display$(RPAREN)$(RPAREN)
 * {
 * // make Quartz-specific calls here
 * }
 * else
 * #endif
 * g_error $(LPAREN)"Unsupported GDK backend"$(RPAREN);
 * ```
 */
struct GdkDisplayManager;

/**
 * The `GdkDmabufFormats` struct provides information about
 * supported DMA buffer formats.
 * You can query whether a given format is supported with
 * [Gdk.DmabufFormats.contains] and you can iterate
 * over the list of all supported formats with
 * [Gdk.DmabufFormats.getNFormats] and
 * [Gdk.DmabufFormats.getFormat].
 * The list of supported formats is sorted by preference,
 * with the best formats coming first.
 * The list may contains $(LPAREN)format, modifier$(RPAREN) pairs where the modifier
 * is `DMA_FORMAT_MOD_INVALID`, indicating that **_implicit modifiers_**
 * may be used with this format.
 * See [Gdk.DmabufTextureBuilder] for more information
 * about DMA buffers.
 * Note that DMA buffers only exist on Linux.
 */
struct GdkDmabufFormats;

/**
 * A `GdkTexture` representing a DMA buffer.
 * To create a `GdkDmabufTexture`, use the auxiliary
 * [Gdk.DmabufTextureBuilder] object.
 * Dma-buf textures can only be created on Linux.
 */
struct GdkDmabufTexture;

/**
 * `GdkDmabufTextureBuilder` is a builder used to construct [Gdk.Texture]
 * objects from DMA buffers.
 * DMA buffers are commonly called **_dma-bufs_**.
 * DMA buffers are a feature of the Linux kernel to enable efficient buffer and
 * memory sharing between hardware such as codecs, GPUs, displays, cameras and the
 * kernel drivers controlling them. For example, a decoder may want its output to
 * be directly shared with the display server for rendering without a copy.
 * Any device driver which participates in DMA buffer sharing, can do so as either
 * the exporter or importer of buffers $(LPAREN)or both$(RPAREN).
 * The memory that is shared via DMA buffers is usually stored in non-system memory
 * $(LPAREN)maybe in device's local memory or something else not directly accessible by the
 * CPU$(RPAREN), and accessing this memory from the CPU may have higher-than-usual overhead.
 * In particular for graphics data, it is not uncommon that data consists of multiple
 * separate blocks of memory, for example one block for each of the red, green and
 * blue channels. These blocks are called **_planes_**. DMA buffers can have up to
 * four planes. Even if the memory is a single block, the data can be organized in
 * multiple planes, by specifying offsets from the beginning of the data.
 * DMA buffers are exposed to user-space as file descriptors allowing to pass them
 * between processes. If a DMA buffer has multiple planes, there is one file
 * descriptor per plane.
 * The format of the data $(LPAREN)for graphics data, essentially its colorspace$(RPAREN) is described
 * by a 32-bit integer. These format identifiers are defined in the header file `drm_fourcc.h`
 * and commonly referred to as **_fourcc_** values, since they are identified by 4 ASCII
 * characters. Additionally, each DMA buffer has a **_modifier_**, which is a 64-bit integer
 * that describes driver-specific details of the memory layout, such as tiling or compression.
 * For historical reasons, some producers of dma-bufs don't provide an explicit modifier, but
 * instead return `DMA_FORMAT_MOD_INVALID` to indicate that their modifier is **_implicit_**.
 * GTK tries to accommodate this situation by accepting `DMA_FORMAT_MOD_INVALID` as modifier.
 * The operation of `GdkDmabufTextureBuilder` is quite simple: Create a texture builder,
 * set all the necessary properties, and then call [Gdk.DmabufTextureBuilder.build]
 * to create the new texture.
 * The required properties for a dma-buf texture are
 * * The width and height in pixels
 * * The `fourcc` code and `modifier` which identify the format and memory layout of the dma-buf
 * * The file descriptor, offset and stride for each of the planes
 * `GdkDmabufTextureBuilder` can be used for quick one-shot construction of
 * textures as well as kept around and reused to construct multiple textures.
 * For further information, see
 * * The Linux kernel [documentation](https://docs.kernel.org/driver-api/dma-buf.html)
 * * The header file [drm_fourcc.h](https://gitlab.freedesktop.org/mesa/drm/-/blob/main/include/drm/drm_fourcc.h)
 */
struct GdkDmabufTextureBuilder;

struct GdkDmabufTextureBuilderClass;

struct GdkDmabufTextureClass;

/**
 * The `GdkDrag` object represents the source of an ongoing DND operation.
 * A `GdkDrag` is created when a drag is started, and stays alive for duration of
 * the DND operation. After a drag has been started with [Gdk.Drag.begin],
 * the caller gets informed about the status of the ongoing drag operation
 * with signals on the `GdkDrag` object.
 * GTK provides a higher level abstraction based on top of these functions,
 * and so they are not normally needed in GTK applications. See the
 * "Drag and Drop" section of the GTK documentation for more information.
 */
struct GdkDrag;

/**
 * A `GdkDragSurface` is an interface for surfaces used during DND.
 */
struct GdkDragSurface;

/**
 * The `GdkDragSurfaceInterface` implementation is private to GDK.
 */
struct GdkDragSurfaceInterface;

/**
 * The `GdkDragSurfaceSize` struct contains information that is useful
 * to compute the size of a drag surface.
 */
struct GdkDragSurfaceSize;

/**
 * Base class for objects implementing different rendering methods.
 * `GdkDrawContext` is the base object used by contexts implementing different
 * rendering methods, such as [Gdk.CairoContext] or [Gdk.GLContext].
 * It provides shared functionality between those contexts.
 * You will always interact with one of those subclasses.
 * A `GdkDrawContext` is always associated with a single toplevel surface.
 */
struct GdkDrawContext;

/**
 * The `GdkDrop` object represents the target of an ongoing DND operation.
 * Possible drop sites get informed about the status of the ongoing drag
 * operation with events of type %GDK_DRAG_ENTER, %GDK_DRAG_LEAVE,
 * %GDK_DRAG_MOTION and %GDK_DROP_START. The `GdkDrop` object can be obtained
 * from these [Gdk.Event] types using [Gdk.DNDEvent.getDrop].
 * The actual data transfer is initiated from the target side via an async
 * read, using one of the `GdkDrop` methods for this purpose:
 * [Gdk.Drop.readAsync] or [Gdk.Drop.readValueAsync].
 * GTK provides a higher level abstraction based on top of these functions,
 * and so they are not normally needed in GTK applications. See the
 * "Drag and Drop" section of the GTK documentation for more information.
 */
struct GdkDrop;

/**
 * `GdkEvent`s are immutable data structures, created by GDK to
 * represent windowing system events.
 * In GTK applications the events are handled automatically by toplevel
 * widgets and passed on to the event controllers of appropriate widgets,
 * so using `GdkEvent` and its related API is rarely needed.
 */
struct GdkEvent;

/**
 * `GdkEventSequence` is an opaque type representing a sequence
 * of related touch events.
 */
struct GdkEventSequence;

/**
 * An opaque type representing a list of files.
 */
struct GdkFileList;

/**
 * An event related to a keyboard focus change.
 */
struct GdkFocusEvent;

/**
 * A `GdkFrameClock` tells the application when to update and repaint
 * a surface.
 * This may be synced to the vertical refresh rate of the monitor, for example.
 * Even when the frame clock uses a simple timer rather than a hardware-based
 * vertical sync, the frame clock helps because it ensures everything paints at
 * the same time $(LPAREN)reducing the total number of frames$(RPAREN).
 * The frame clock can also automatically stop painting when it knows the frames
 * will not be visible, or scale back animation framerates.
 * `GdkFrameClock` is designed to be compatible with an OpenGL-based implementation
 * or with mozRequestAnimationFrame in Firefox, for example.
 * A frame clock is idle until someone requests a frame with
 * [Gdk.FrameClock.requestPhase]. At some later point that makes sense
 * for the synchronization being implemented, the clock will process a frame and
 * emit signals for each phase that has been requested. $(LPAREN)See the signals of the
 * `GdkFrameClock` class for documentation of the phases.
 * %GDK_FRAME_CLOCK_PHASE_UPDATE and the [Gdk.FrameClock.update] signal
 * are most interesting for application writers, and are used to update the
 * animations, using the frame time given by [Gdk.FrameClock.getFrameTime].
 * The frame time is reported in microseconds and generally in the same
 * timescale as [GLib.Global.getMonotonicTime], however, it is not the same
 * as [GLib.Global.getMonotonicTime]. The frame time does not advance during
 * the time a frame is being painted, and outside of a frame, an attempt
 * is made so that all calls to [Gdk.FrameClock.getFrameTime] that
 * are called at a “similar” time get the same value. This means that
 * if different animations are timed by looking at the difference in
 * time between an initial value from [Gdk.FrameClock.getFrameTime]
 * and the value inside the [Gdk.FrameClock.update] signal of the clock,
 * they will stay exactly synchronized.
 */
struct GdkFrameClock;

struct GdkFrameClockClass;

struct GdkFrameClockPrivate;

/**
 * A `GdkFrameTimings` object holds timing information for a single frame
 * of the application’s displays.
 * To retrieve `GdkFrameTimings` objects, use [Gdk.FrameClock.getTimings]
 * or [Gdk.FrameClock.getCurrentTimings]. The information in
 * `GdkFrameTimings` is useful for precise synchronization of video with
 * the event or audio streams, and for measuring quality metrics for the
 * application’s display, such as latency and jitter.
 */
struct GdkFrameTimings;

/**
 * `GdkGLContext` is an object representing a platform-specific
 * OpenGL draw context.
 * `GdkGLContext`s are created for a surface using
 * [Gdk.Surface.createGlContext], and the context will match
 * the characteristics of the surface.
 * A `GdkGLContext` is not tied to any particular normal framebuffer.
 * For instance, it cannot draw to the surface back buffer. The GDK
 * repaint system is in full control of the painting to that. Instead,
 * you can create render buffers or textures and use func@cairo_draw_from_gl
 * in the draw function of your widget to draw them. Then GDK will handle
 * the integration of your rendering with that of other widgets.
 * Support for `GdkGLContext` is platform-specific and context creation
 * can fail, returning %NULL context.
 * A `GdkGLContext` has to be made "current" in order to start using
 * it, otherwise any OpenGL call will be ignored.
 * ## Creating a new OpenGL context
 * In order to create a new `GdkGLContext` instance you need a `GdkSurface`,
 * which you typically get during the realize call of a widget.
 * A `GdkGLContext` is not realized until either [Gdk.GLContext.makeCurrent]
 * or [Gdk.GLContext.realize] is called. It is possible to specify
 * details of the GL context like the OpenGL version to be used, or whether
 * the GL context should have extra state validation enabled after calling
 * [Gdk.Surface.createGlContext] by calling [Gdk.GLContext.realize].
 * If the realization fails you have the option to change the settings of
 * the `GdkGLContext` and try again.
 * ## Using a GdkGLContext
 * You will need to make the `GdkGLContext` the current context before issuing
 * OpenGL calls; the system sends OpenGL commands to whichever context is current.
 * It is possible to have multiple contexts, so you always need to ensure that
 * the one which you want to draw with is the current one before issuing commands:
 * ```c
 * gdk_gl_context_make_current $(LPAREN)context$(RPAREN);
 * ```
 * You can now perform your drawing using OpenGL commands.
 * You can check which `GdkGLContext` is the current one by using
 * [Gdk.GLContext.getCurrent]; you can also unset any `GdkGLContext`
 * that is currently set by calling [Gdk.GLContext.clearCurrent].
 */
struct GdkGLContext;

/**
 * A GdkTexture representing a GL texture object.
 */
struct GdkGLTexture;

/**
 * `GdkGLTextureBuilder` is a builder used to construct [Gdk.Texture] objects from
 * GL textures.
 * The operation is quite simple: Create a texture builder, set all the necessary
 * properties - keep in mind that the properties [Gdk.GLTextureBuilder.context],
 * [Gdk.GLTextureBuilder.id], [Gdk.GLTextureBuilder.width], and
 * [Gdk.GLTextureBuilder.height] are mandatory - and then call
 * [Gdk.GLTextureBuilder.build] to create the new texture.
 * `GdkGLTextureBuilder` can be used for quick one-shot construction of
 * textures as well as kept around and reused to construct multiple textures.
 */
struct GdkGLTextureBuilder;

struct GdkGLTextureBuilderClass;

struct GdkGLTextureClass;

/**
 * An event related to a broken windowing system grab.
 */
struct GdkGrabBrokenEvent;

/**
 * An event related to a key-based device.
 */
struct GdkKeyEvent;

/**
 * A `GdkKeymapKey` is a hardware key that can be mapped to a keyval.
 */
struct GdkKeymapKey
{
  /**
   * the hardware keycode. This is an identifying number for a
   * physical key.
   */
  uint keycode;

  /**
   * indicates movement in a horizontal direction. Usually groups are used
   * for two different languages. In group 0, a key might have two English
   * characters, and in group 1 it might have two Hebrew characters. The Hebrew
   * characters will be printed on the key next to the English characters.
   */
  int group;

  /**
   * indicates which symbol on the key will be used, in a vertical direction.
   * So on a standard US keyboard, the key with the number “1” on it also has the
   * exclamation point $(LPAREN)"!"$(RPAREN) character on it. The level indicates whether to use
   * the “1” or the “!” symbol. The letter keys are considered to have a lowercase
   * letter at level 0, and an uppercase letter at level 1, though only the
   * uppercase letter is printed.
   */
  int level;
}

/**
 * A `GdkTexture` representing image data in memory.
 */
struct GdkMemoryTexture;

struct GdkMemoryTextureClass;

struct GdkMonitorClass;

/**
 * `GdkMonitor` objects represent the individual outputs that are
 * associated with a `GdkDisplay`.
 * `GdkDisplay` keeps a `GListModel` to enumerate and monitor
 * monitors with [Gdk.Display.getMonitors]. You can use
 * [Gdk.Display.getMonitorAtSurface] to find a particular
 * monitor.
 */
struct GdkMonitor;

/**
 * An event related to a pointer or touch device motion.
 */
struct GdkMotionEvent;

/**
 * An event related to a pad-based device.
 */
struct GdkPadEvent;

/**
 * `GdkPaintable` is a simple interface used by GTK to represent content that
 * can be painted.
 * The content of a `GdkPaintable` can be painted anywhere at any size
 * without requiring any sort of layout. The interface is inspired by
 * similar concepts elsewhere, such as
 * [ClutterContent](https://developer.gnome.org/clutter/stable/ClutterContent.html),
 * [HTML/CSS Paint Sources](https://www.w3.org/TR/css-images-4/#paint-source),
 * or [SVG Paint Servers](https://www.w3.org/TR/SVG2/pservers.html).
 * A `GdkPaintable` can be snapshot at any time and size using
 * [Gdk.Paintable.snapshot]. How the paintable interprets that size and
 * if it scales or centers itself into the given rectangle is implementation
 * defined, though if you are implementing a `GdkPaintable` and don't know what
 * to do, it is suggested that you scale your paintable ignoring any potential
 * aspect ratio.
 * The contents that a `GdkPaintable` produces may depend on the [Gdk.Snapshot]
 * passed to it. For example, paintables may decide to use more detailed images
 * on higher resolution screens or when OpenGL is available. A `GdkPaintable`
 * will however always produce the same output for the same snapshot.
 * A `GdkPaintable` may change its contents, meaning that it will now produce
 * a different output with the same snapshot. Once that happens, it will call
 * [Gdk.Paintable.invalidateContents] which will emit the
 * signal@Gdk.Paintable::invalidate-contents signal. If a paintable is known
 * to never change its contents, it will set the %GDK_PAINTABLE_STATIC_CONTENTS
 * flag. If a consumer cannot deal with changing contents, it may call
 * [Gdk.Paintable.getCurrentImage] which will return a static
 * paintable and use that.
 * A paintable can report an intrinsic $(LPAREN)or preferred$(RPAREN) size or aspect ratio it
 * wishes to be rendered at, though it doesn't have to. Consumers of the interface
 * can use this information to layout thepaintable appropriately. Just like the
 * contents, the size of a paintable can change. A paintable will indicate this
 * by calling [Gdk.Paintable.invalidateSize] which will emit the
 * signal@Gdk.Paintable::invalidate-size signal. And just like for contents,
 * if a paintable is known to never change its size, it will set the
 * %GDK_PAINTABLE_STATIC_SIZE flag.
 * Besides API for applications, there are some functions that are only
 * useful for implementing subclasses and should not be used by applications:
 * [Gdk.Paintable.invalidateContents],
 * [Gdk.Paintable.invalidateSize],
 * [Gdk.Paintable.newEmpty].
 */
struct GdkPaintable;

/**
 * The list of functions that can be implemented for the `GdkPaintable`
 * interface.
 * Note that apart from the vfunc@Gdk.Paintable.snapshot function,
 * no virtual function of this interface is mandatory to implement, though it
 * is a good idea to implement vfunc@Gdk.Paintable.get_current_image
 * for non-static paintables and vfunc@Gdk.Paintable.get_flags if the
 * image is not dynamic as the default implementation returns no flags and
 * that will make the implementation likely quite slow.
 */
struct GdkPaintableInterface
{
  GTypeInterface gIface;

  /**
   * Snapshot the paintable. The given @width and @height are
   * guaranteed to be larger than 0.0. The resulting snapshot must modify
   * only the area in the rectangle from $(LPAREN)0,0$(RPAREN) to $(LPAREN)width, height$(RPAREN).
   * This is the only function that must be implemented for this interface.
   */
  extern(C) void function(GdkPaintable* paintable, GdkSnapshot* snapshot, double width, double height) snapshot;

  /**
   * return a `GdkPaintable` that does not change over
   * time. This means the `GDK_PAINTABLE_STATIC_SIZE` and
   * `GDK_PAINTABLE_STATIC_CONTENTS` flag are set.
   */
  extern(C) GdkPaintable* function(GdkPaintable* paintable) getCurrentImage;

  /**
   * Get the flags for this instance. See [Gdk]
   * for details.
   */
  extern(C) GdkPaintableFlags function(GdkPaintable* paintable) getFlags;

  /**
   * The preferred width for this object to be
   * snapshot at or 0 if none. This is purely a hint. The object must still
   * be able to render at any size.
   */
  extern(C) int function(GdkPaintable* paintable) getIntrinsicWidth;

  /**
   * The preferred height for this object to be
   * snapshot at or 0 if none. This is purely a hint. The object must still
   * be able to render at any size.
   */
  extern(C) int function(GdkPaintable* paintable) getIntrinsicHeight;

  /**
   * The preferred aspect ratio for this object
   * or 0 if none. If both vfunc@Gdk.Paintable.get_intrinsic_width
   * and vfunc@Gdk.Paintable.get_intrinsic_height return non-zero
   * values, this function should return the aspect ratio computed from those.
   */
  extern(C) double function(GdkPaintable* paintable) getIntrinsicAspectRatio;
}

/**
 * A `GdkPopup` is a surface that is attached to another surface.
 * The `GdkPopup` is positioned relative to its parent surface.
 * `GdkPopup`s are typically used to implement menus and similar popups.
 * They can be modal, which is indicated by the [Gdk.Popup.autohide]
 * property.
 */
struct GdkPopup;

struct GdkPopupInterface;

/**
 * The `GdkPopupLayout` struct contains information that is
 * necessary position a [Gdk.Popup] relative to its parent.
 * The positioning requires a negotiation with the windowing system,
 * since it depends on external constraints, such as the position of
 * the parent surface, and the screen dimensions.
 * The basic ingredients are a rectangle on the parent surface,
 * and the anchor on both that rectangle and the popup. The anchors
 * specify a side or corner to place next to each other.
 * ![Popup anchors](popup-anchors.png)
 * For cases where placing the anchors next to each other would make
 * the popup extend offscreen, the layout includes some hints for how
 * to resolve this problem. The hints may suggest to flip the anchor
 * position to the other side, or to 'slide' the popup along a side,
 * or to resize it.
 * ![Flipping popups](popup-flip.png)
 * ![Sliding popups](popup-slide.png)
 * These hints may be combined.
 * Ultimatively, it is up to the windowing system to determine the position
 * and size of the popup. You can learn about the result by calling
 * [Gdk.Popup.getPositionX], [Gdk.Popup.getPositionY],
 * [Gdk.Popup.getRectAnchor] and [Gdk.Popup.getSurfaceAnchor]
 * after the popup has been presented. This can be used to adjust the rendering.
 * For example, [GtkPopover](../gtk4/class.Popover.html) changes its arrow position
 * accordingly. But you have to be careful avoid changing the size of the popover,
 * or it has to be presented again.
 */
struct GdkPopupLayout;

/**
 * An event related to the proximity of a tool to a device.
 */
struct GdkProximityEvent;

/**
 * A `GdkRGBA` is used to represent a color, in a way that is compatible
 * with cairo’s notion of color.
 * `GdkRGBA` is a convenient way to pass colors around. It’s based on
 * cairo’s way to deal with colors and mirrors its behavior. All values
 * are in the range from 0.0 to 1.0 inclusive. So the color
 * $(LPAREN)0.0, 0.0, 0.0, 0.0$(RPAREN) represents transparent black and
 * $(LPAREN)1.0, 1.0, 1.0, 1.0$(RPAREN) is opaque white. Other values will
 * be clamped to this range when drawing.
 */
struct GdkRGBA
{
  /**
   * The intensity of the red channel from 0.0 to 1.0 inclusive
   */
  float red;

  /**
   * The intensity of the green channel from 0.0 to 1.0 inclusive
   */
  float green;

  /**
   * The intensity of the blue channel from 0.0 to 1.0 inclusive
   */
  float blue;

  /**
   * The opacity of the color from 0.0 for completely translucent to
   * 1.0 for opaque
   */
  float alpha;
}

/**
 * A `GdkRectangle` data type for representing rectangles.
 * `GdkRectangle` is identical to `cairo_rectangle_t`. Together with Cairo’s
 * `cairo_region_t` data type, these are the central types for representing
 * sets of pixels.
 * The intersection of two rectangles can be computed with
 * [Gdk.Rectangle.intersect]; to find the union of two rectangles use
 * [Gdk.Rectangle.union_].
 * The `cairo_region_t` type provided by Cairo is usually used for managing
 * non-rectangular clipping of graphical operations.
 * The Graphene library has a number of other data types for regions and
 * volumes in 2D and 3D.
 */
struct GdkRectangle
{
  /**
   * the x coordinate of the top left corner
   */
  int x;

  /**
   * the y coordinate of the top left corner
   */
  int y;

  /**
   * the width of the rectangle
   */
  int width;

  /**
   * the height of the rectangle
   */
  int height;
}

/**
 * An event related to a scrolling motion.
 */
struct GdkScrollEvent;

/**
 * The `GdkSeat` object represents a collection of input devices
 * that belong to a user.
 */
struct GdkSeat
{
  ObjectC parentInstance;
}

/**
 * Base type for snapshot operations.
 * The subclass of `GdkSnapshot` used by GTK is [GtkSnapshot](../gtk4/class.Snapshot.html).
 */
struct GdkSnapshot;

struct GdkSnapshotClass;

/**
 * A `GdkSurface` is a rectangular region on the screen.
 * It’s a low-level object, used to implement high-level objects
 * such as [GtkWindow](../gtk4/class.Window.html).
 * The surfaces you see in practice are either [Gdk.Toplevel] or
 * [Gdk.Popup], and those interfaces provide much of the required
 * API to interact with these surfaces. Other, more specialized surface
 * types exist, but you will rarely interact with them directly.
 */
struct GdkSurface;

struct GdkSurfaceClass;

/**
 * `GdkTexture` is the basic element used to refer to pixel data.
 * It is primarily meant for pixel data that will not change over
 * multiple frames, and will be used for a long time.
 * There are various ways to create `GdkTexture` objects from a
 * [GdkPixbuf.Pixbuf], or from bytes stored in memory, a file, or a
 * [Gio.Resource].
 * The ownership of the pixel data is transferred to the `GdkTexture`
 * instance; you can only make a copy of it, via [Gdk.Texture.download].
 * `GdkTexture` is an immutable object: That means you cannot change
 * anything about it other than increasing the reference count via
 * [GObject.ObjectG.ref_], and consequently, it is a thread-safe object.
 */
struct GdkTexture;

struct GdkTextureClass;

/**
 * The `GdkTextureDownloader` is used to download the contents of a
 * [Gdk.Texture].
 * It is intended to be created as a short-term object for a single download,
 * but can be used for multiple downloads of different textures or with different
 * settings.
 * `GdkTextureDownloader` can be used to convert data between different formats.
 * Create a `GdkTexture` for the existing format and then download it in a
 * different format.
 */
struct GdkTextureDownloader;

/**
 * A `GdkTimeCoord` stores a single event in a motion history.
 * To check whether an axis is present, check whether the corresponding
 * flag from the [Gdk] enumeration is set in the @flags
 * To access individual axis values, use the values of the values of
 * the [Gdk] enumerations as indices.
 */
struct GdkTimeCoord
{
  /**
   * The timestamp for this event
   */
  uint time;

  /**
   * Flags indicating what axes are present, see [Gdk]
   */
  GdkAxisFlags flags;

  /**
   * axis values, indexed by [Gdk]
   */
  double[12] axes;
}

/**
 * A `GdkToplevel` is a freestanding toplevel surface.
 * The `GdkToplevel` interface provides useful APIs for interacting with
 * the windowing system, such as controlling maximization and size of the
 * surface, setting icons and transient parents for dialogs.
 */
struct GdkToplevel;

struct GdkToplevelInterface;

/**
 * The `GdkToplevelLayout` struct contains information that
 * is necessary to present a sovereign window on screen.
 * The `GdkToplevelLayout` struct is necessary for using
 * [Gdk.Toplevel.present].
 * Toplevel surfaces are sovereign windows that can be presented
 * to the user in various states $(LPAREN)maximized, on all workspaces,
 * etc$(RPAREN).
 */
struct GdkToplevelLayout;

/**
 * The `GdkToplevelSize` struct contains information that is useful
 * to compute the size of a toplevel.
 */
struct GdkToplevelSize;

/**
 * An event related to a touch-based device.
 */
struct GdkTouchEvent;

/**
 * An event related to a gesture on a touchpad device.
 * Unlike touchscreens, where the windowing system sends basic
 * sequences of begin, update, end events, and leaves gesture
 * recognition to the clients, touchpad gestures are typically
 * processed by the system, resulting in these events.
 */
struct GdkTouchpadEvent;

/**
 * `GdkVulkanContext` is an object representing the platform-specific
 * Vulkan draw context.
 * `GdkVulkanContext`s are created for a surface using
 * [Gdk.Surface.createVulkanContext], and the context will match
 * the characteristics of the surface.
 * Support for `GdkVulkanContext` is platform-specific and context creation
 * can fail, returning %NULL context.
 */
struct GdkVulkanContext;

alias extern(C) void function(GdkContentDeserializer* deserializer) GdkContentDeserializeFunc;

alias extern(C) void function(GdkContentSerializer* serializer) GdkContentSerializeFunc;

