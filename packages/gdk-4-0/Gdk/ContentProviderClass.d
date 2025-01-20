module Gdk.ContentProviderClass;

import GObject.ObjectClass;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * Class structure for `GdkContentProvider`.
 */
class ContentProviderClass
{
  GdkContentProviderClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ContentProviderClass");

    cInstance = *cast(GdkContentProviderClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GdkContentProviderClass*)cPtr).parentClass);
  }

  alias ContentChangedFuncType = extern(C) void function(GdkContentProvider* provider);

  @property ContentChangedFuncType contentChanged()
  {
    return (cast(GdkContentProviderClass*)cPtr).contentChanged;
  }

  alias AttachClipboardFuncType = extern(C) void function(GdkContentProvider* provider, GdkClipboard* clipboard);

  @property AttachClipboardFuncType attachClipboard()
  {
    return (cast(GdkContentProviderClass*)cPtr).attachClipboard;
  }

  alias DetachClipboardFuncType = extern(C) void function(GdkContentProvider* provider, GdkClipboard* clipboard);

  @property DetachClipboardFuncType detachClipboard()
  {
    return (cast(GdkContentProviderClass*)cPtr).detachClipboard;
  }

  alias RefFormatsFuncType = extern(C) GdkContentFormats* function(GdkContentProvider* provider);

  @property RefFormatsFuncType refFormats()
  {
    return (cast(GdkContentProviderClass*)cPtr).refFormats;
  }

  alias RefStorableFormatsFuncType = extern(C) GdkContentFormats* function(GdkContentProvider* provider);

  @property RefStorableFormatsFuncType refStorableFormats()
  {
    return (cast(GdkContentProviderClass*)cPtr).refStorableFormats;
  }

  alias WriteMimeTypeAsyncFuncType = extern(C) void function(GdkContentProvider* provider, const(char)* mimeType, GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property WriteMimeTypeAsyncFuncType writeMimeTypeAsync()
  {
    return (cast(GdkContentProviderClass*)cPtr).writeMimeTypeAsync;
  }

  alias WriteMimeTypeFinishFuncType = extern(C) bool function(GdkContentProvider* provider, GAsyncResult* result, GError** _err);

  @property WriteMimeTypeFinishFuncType writeMimeTypeFinish()
  {
    return (cast(GdkContentProviderClass*)cPtr).writeMimeTypeFinish;
  }

  alias GetValueFuncType = extern(C) bool function(GdkContentProvider* provider, GValue* value, GError** _err);

  @property GetValueFuncType getValue()
  {
    return (cast(GdkContentProviderClass*)cPtr).getValue;
  }
}
