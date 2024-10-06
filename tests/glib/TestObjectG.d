module gobject.TestObjectG;

import GLib.c.functions;
import GObject.InitiallyUnowned;
import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;

import core.memory : GC;

unittest
{
  // Test GObject lifecycle
  void* weakPtr = cast(void*)1; // Added as a weak pointer to the GObject which should get cleared when it is destroyed
  auto gobj = g_object_new(GTypeEnum.Object, null); // We own a reference
  g_object_add_weak_pointer(cast(ObjectC*)gobj, &weakPtr);
  auto dobj = new ObjectG(gobj, true); // D object takes over reference
  assert(weakPtr);
  dobj.destroy;
  assert(!weakPtr);  

  // Test InitiallyUnowned lifecycle
  weakPtr = cast(void*)1;
  auto floatObj = g_object_new(InitiallyUnowned.getType, null); // Floating reference
  g_object_add_weak_pointer(cast(ObjectC*)floatObj, &weakPtr);
  dobj = new InitiallyUnowned(floatObj, true); // D object takes over ownership
  assert(weakPtr);
  dobj.destroy;
  assert(!weakPtr);  
}
