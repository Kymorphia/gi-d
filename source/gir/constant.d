module gir.constant;

import gir.type;

class Constant
{
  dstring name; /// Name of constant
  dstring value; /// Value of constant
  Type type; /// Type
  dstring cType; /// C type name

  dstring sourceFilename; /// Source filename
  uint sourceLine; /// Source line
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line
}
