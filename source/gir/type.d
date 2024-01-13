module gir.type;

/// Ownership transfer of a type
enum Ownership : dstring
{
  None = "none",
  Container = "container",
  Full = "full",
}

/// Type information
class Type
{
  bool isArray;
  int arrayLength;
  dstring arrayCType;
  dstring elemType;
  dstring elemCType;
}

/// Array size type
enum ArraySize : ubyte
{
  Fixed, /// Fixed size array ('size' specifies the array size)
  Param, /// Parameter specifies the size ('size' is the parameter index)
  Zero, /// Zero terminated array
}

/// Array information structure
struct ArrayInfo
{
  bool isArray; /// true if this type is an array
  dstring cType; /// C type of the array
  ArraySize sizeType; /// Array size type
  uint size; /// Used for specifying the size (sizeTypeL: actual size if ArraySize.Fixed, parameter index if ArraySize.Param, not used if ArraySize.Zero)
}
