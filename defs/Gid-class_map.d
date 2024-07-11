//!kind class_map Namespace

import GObject.c.types;

// Map of GTypes to D class info
private shared TypeInfo_Class[GType] gtypeClassMap;

void registerGTypeClassMap(TypeInfo_Class typeClass, GType gType)
{
  gtypeClassMap[gType] = cast(shared)typeClass;
}

TypeInfo_Class lookupClassByGType(GType gType)
{
  if (auto pClass = gType in gtypeClassMap)
    return cast(TypeInfo_Class)*pClass;

  return null;
}
