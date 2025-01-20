module GdkPixbuf.PixbufModule;

import GModule.Module;
import GdkPixbuf.PixbufFormat;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * A `GdkPixbufModule` contains the necessary functions to load and save
 * images in a certain file format.
 * If `GdkPixbuf` has been compiled with `GModule` support, it can be extended
 * by modules which can load $(LPAREN)and perhaps also save$(RPAREN) new image and animation
 * formats.
 * ## Implementing modules
 * The `GdkPixbuf` interfaces needed for implementing modules are contained in
 * `gdk-pixbuf-io.h` $(LPAREN)and `gdk-pixbuf-animation.h` if the module supports
 * animations$(RPAREN). They are not covered by the same stability guarantees as the
 * regular GdkPixbuf API. To underline this fact, they are protected by the
 * `GDK_PIXBUF_ENABLE_BACKEND` pre-processor symbol.
 * Each loadable module must contain a `GdkPixbufModuleFillVtableFunc` function
 * named `fill_vtable`, which will get called when the module
 * is loaded and must set the function pointers of the `GdkPixbufModule`.
 * In order to make format-checking work before actually loading the modules
 * $(LPAREN)which may require calling `dlopen` to load image libraries$(RPAREN), modules export
 * their signatures $(LPAREN)and other information$(RPAREN) via the `fill_info` function. An
 * external utility, `gdk-pixbuf-query-loaders`, uses this to create a text
 * file containing a list of all available loaders and  their signatures.
 * This file is then read at runtime by `GdkPixbuf` to obtain the list of
 * available loaders and their signatures.
 * Modules may only implement a subset of the functionality available via
 * `GdkPixbufModule`. If a particular functionality is not implemented, the
 * `fill_vtable` function will simply not set the corresponding
 * function pointers of the `GdkPixbufModule` structure. If a module supports
 * incremental loading $(LPAREN)i.e. provides `begin_load`, `stop_load` and
 * `load_increment`$(RPAREN), it doesn't have to implement `load`, since `GdkPixbuf`
 * can supply a generic `load` implementation wrapping the incremental loading.
 * ## Installing modules
 * Installing a module is a two-step process:
 * - copy the module file$(LPAREN)s$(RPAREN) to the loader directory $(LPAREN)normally
 * `\$libdir/gdk-pixbuf-2.0/\$version/loaders`, unless overridden by the
 * environment variable `GDK_PIXBUF_MODULEDIR`$(RPAREN)
 * - call `gdk-pixbuf-query-loaders` to update the module file $(LPAREN)normally
 * `\$libdir/gdk-pixbuf-2.0/\$version/loaders.cache`, unless overridden
 * by the environment variable `GDK_PIXBUF_MODULE_FILE`$(RPAREN)
 */
class PixbufModule
{
  GdkPixbufModule cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GdkPixbuf.PixbufModule");

    cInstance = *cast(GdkPixbufModule*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string moduleName()
  {
    return (cast(GdkPixbufModule*)cPtr).moduleName.fromCString(false);
  }

  @property void moduleName(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufModule*)cPtr).moduleName);
    (cast(GdkPixbufModule*)cPtr).moduleName = propval.toCString(true);
  }

  @property string modulePath()
  {
    return (cast(GdkPixbufModule*)cPtr).modulePath.fromCString(false);
  }

  @property void modulePath(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufModule*)cPtr).modulePath);
    (cast(GdkPixbufModule*)cPtr).modulePath = propval.toCString(true);
  }

  @property Module module_()
  {
    return new Module(cast(ModuleC*)(cast(GdkPixbufModule*)cPtr).module_);
  }

  @property PixbufFormat info()
  {
    return new PixbufFormat(cast(GdkPixbufFormat*)(cast(GdkPixbufModule*)cPtr).info);
  }

  @property GdkPixbufModuleLoadFunc load()
  {
    return (cast(GdkPixbufModule*)cPtr).load;
  }

  @property void load(GdkPixbufModuleLoadFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).load = propval;
  }

  @property GdkPixbufModuleLoadXpmDataFunc loadXpmData()
  {
    return (cast(GdkPixbufModule*)cPtr).loadXpmData;
  }

  @property void loadXpmData(GdkPixbufModuleLoadXpmDataFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).loadXpmData = propval;
  }

  @property GdkPixbufModuleBeginLoadFunc beginLoad()
  {
    return (cast(GdkPixbufModule*)cPtr).beginLoad;
  }

  @property void beginLoad(GdkPixbufModuleBeginLoadFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).beginLoad = propval;
  }

  @property GdkPixbufModuleStopLoadFunc stopLoad()
  {
    return (cast(GdkPixbufModule*)cPtr).stopLoad;
  }

  @property void stopLoad(GdkPixbufModuleStopLoadFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).stopLoad = propval;
  }

  @property GdkPixbufModuleIncrementLoadFunc loadIncrement()
  {
    return (cast(GdkPixbufModule*)cPtr).loadIncrement;
  }

  @property void loadIncrement(GdkPixbufModuleIncrementLoadFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).loadIncrement = propval;
  }

  @property GdkPixbufModuleLoadAnimationFunc loadAnimation()
  {
    return (cast(GdkPixbufModule*)cPtr).loadAnimation;
  }

  @property void loadAnimation(GdkPixbufModuleLoadAnimationFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).loadAnimation = propval;
  }

  @property GdkPixbufModuleSaveFunc save()
  {
    return (cast(GdkPixbufModule*)cPtr).save;
  }

  @property void save(GdkPixbufModuleSaveFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).save = propval;
  }

  @property GdkPixbufModuleSaveCallbackFunc saveToCallback()
  {
    return (cast(GdkPixbufModule*)cPtr).saveToCallback;
  }

  @property void saveToCallback(GdkPixbufModuleSaveCallbackFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).saveToCallback = propval;
  }

  @property GdkPixbufModuleSaveOptionSupportedFunc isSaveOptionSupported()
  {
    return (cast(GdkPixbufModule*)cPtr).isSaveOptionSupported;
  }

  @property void isSaveOptionSupported(GdkPixbufModuleSaveOptionSupportedFunc propval)
  {
    (cast(GdkPixbufModule*)cPtr).isSaveOptionSupported = propval;
  }
}
