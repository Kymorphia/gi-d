module gir.structure;

import code_writer;
import defs;
import import_symbols;
import gir.base;
import gir.field;
import gir.func;
import gir.func_writer;
import gir.property;
import gir.repo;
import gir.signal_writer;
import gir.type_node;
import utils;

/// Structure class which is used for class, interface, and records in Gir files
final class Structure : TypeNode
{
  this(Base parent)
  {
    super(parent);
    defCode = new DefCode;
  }

  this(Base parent, XmlNode node)
  {
    this(parent);
    fromXml(node);
  }

  override @property dstring name()
  {
    return dType;
  }

  override @property bool inModule()
  {
    with (TypeKind) return kind.among(Opaque, Wrap, Boxed, Reffed, Object, Interface, Namespace) != 0;
  }

  override @property bool inGlobal()
  {
    with (TypeKind) return kind.among(Simple, Pointer) != 0;
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    structType = cast(StructType)StructTypeValues.countUntil(node.id);
    cSymbolPrefix = node.get("c:symbol-prefix");
    parentType = node.get("parent");
    version_ = node.get("version");

    abstract_ = node.get("abstract") == "1";
    deprecated_ = node.get("deprecated") == "1";
    opaque = node.get("opaque") == "1";
    pointer = node.get("pointer") == "1";
    glibFundamental = node.get("glib:fundamental") == "1";

    deprecatedVersion = node.get("deprecated-version");
    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibGetValueFunc = node.get("glib:get-value-func");
    glibSetValueFunc = node.get("glib:set-value-func");
    glibRefFunc = node.get("glib:ref-func");
    glibUnrefFunc = node.get("glib:unref-func");
    glibTypeStruct = node.get("glib:type-struct");
    glibIsGtypeStructFor = node.get("glib:is-gtype-struct-for");
    copyFunction = node.get("copy-function");
    freeFunction = node.get("free-function");
  }

  /**
   * Add a function to a structure.
   * Params:
   *   func = The function to add
   */
  void addFunc(Func func)
  {
    functions ~= func;
    funcNameHash[func.name] = func;
  }

  /**
   * Look through a class structure's parent object ancestry to see which one implements a given interface.
   * Params:
   *   iface = The interface structure to find an implementation of
   * Returns: The ancestor structure that implements the interface or null if not found.
   */
  Structure getIfaceAncestor(Structure iface)
  {
    for (auto cl = parentStruct; cl; cl = cl.parentStruct)
      if (cl.implementStructs.canFind(iface))
        return cl;

    return null;
  }

  // Calculate the structure type kind
  private TypeKind calcKind()
  {
    if (structType == StructType.Record && !glibGetType.empty)
      return TypeKind.Boxed;

    if (structType == StructType.Record && (opaque || pointer))
      return functions.filter!(x => !x.disable).empty ? TypeKind.Pointer : TypeKind.Opaque;

    if (structType == StructType.Record || structType == StructType.Union)
    {
      if (!functions.empty)
        return TypeKind.Wrap;

      auto retKind = TypeKind.Simple;
      foreach (field; fields) // HACK: Check for field.callback since it is set before the kind is resolved (fixup dependency issue)
      {
        if (field.kind == TypeKind.Unknown)
          retKind = TypeKind.Unknown;
        else if (!field.callback && !field.kind.among(TypeKind.Basic, TypeKind.BasicAlias, TypeKind.Callback,
          TypeKind.Enum, TypeKind.Flags))
        {
          retKind = TypeKind.Wrap;
          break;
        }
      }

      return retKind;
    }

    if (structType == StructType.Class && glibFundamental
        && (!parentType.empty || (!glibRefFunc.empty && !glibUnrefFunc.empty)))
      return TypeKind.Reffed;

    if (structType == StructType.Class && !parentType.empty && !glibGetType.empty)
      return TypeKind.Object;

    if (structType == StructType.Interface)
      return TypeKind.Interface;

    if (dType == "ObjectG") // Minor HACK: ObjectG is the OG Object
      return TypeKind.Object;

    return TypeKind.Unknown;
  }

  override void fixup()
  {
    if (auto field = cast(Field)parent) // Structure as a field of another structure?
    { // dType and cType are the field name (not an actual type)
      dType = field.dName;
      cType = repo.defs.symbolName(origCType);
      kind = TypeKind.Simple;
      return;
    }

    super.fixup;

    foreach (f; fields) // Fixup structure fields
    {
      f.fixup;

      if (opaque || pointer)
        f.disable = true;
    }

    foreach (fn; functions) // Fixup structure function/methods
    {
      fn.fixup;

      if (!fn.shadows.empty)
        fn.shadowsFunc = funcNameHash.get(fn.shadows, null);

      if (fn.funcType == FuncType.Constructor && fn.name == "new") // Set "new" constructor as the primary constructor
        ctorFunc = fn;

      if (fn.funcType == FuncType.Function && fn.dType == "Quark" && fn.name.endsWith("error_quark"))
        errorQuarks ~= fn; // Add exception error quark functions to array
    }

    if (ctorFunc)
      ctorFunc.isCtor = true;

    foreach (sg; signals) // Fixup structure signals
      sg.fixup;
  }

  override void resolve()
  {
    if (auto field = cast(Field)parent) // Structure as a field of another structure?
      return;

    if (kind == TypeKind.Unknown)
      kind = calcKind;

    super.resolve;

    foreach (f; fields) // Resolve structure fields
      f.resolve;

    foreach (fn; functions) // Resolve structure function/methods
      fn.resolve;

    foreach (sg; signals) // Resolve structure signals
      sg.resolve;

    if (kind == TypeKind.Boxed && parentType.empty)
      parentType = "GLib.Boxed";

    if (!parentType.empty)
    {
      parentStruct = cast(Structure)repo.defs.findTypeObject(parentType, repo);
      updateUnresolvedFlags(UnresolvedFlags.ParentStruct, parentStruct is null);
    }

    implementStructs.length = 0;

    foreach (ifaceName; implements)
      if (auto ifaceStruct = cast(Structure)repo.defs.findTypeObject(ifaceName, repo))
        implementStructs ~= ifaceStruct;
  }

  override void verify()
  {
    if (disable || cast(Field)parent) // Don't verify if structure is disabled or a field structure
      return;

    super.verify;

    if (!parentType.empty && !parentStruct)
      throw new Exception("Failed to resolve parent type '" ~ parentType.to!string ~ "'");

    foreach (ifaceName; implements)
      if (!cast(Structure)repo.defs.findTypeObject(ifaceName, repo))
        warning(xmlLocation ~ "Unable to resolve structure " ~ fullName.to!string ~ " interface " ~ ifaceName.to!string);

    if (!defCode.genFuncs) // Skip verification of functions, signals, and fields if they aren't being generated
      return;

    foreach (fn; functions) // Verify structure function/methods
    {
      with(FuncType) if (!fn.funcType.among(Callback, Function, Constructor, Signal, Method))
      {
        fn.disable = true;
        warning(fn.xmlLocation ~ "Disabling function '" ~ fn.fullName.to!string ~ "' of type '" ~ fn.funcType.to!string
            ~ "' which is not supported");
      }
      else
        fn.verify;
    }

    foreach (sig; signals) // Verify structure signals
    {
      try
        sig.verify;
      catch (Exception e)
      {
        sig.disable = true;
        warning(sig.xmlLocation ~ "Disabling signal '" ~ sig.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (f; fields) // Verify structure fields
    {
      try
        f.verify;
      catch (Exception e)
      {
        f.disable = true;
        warning(f.xmlLocation ~ "Disabling field '" ~ f.fullName.to!string ~ "': " ~ e.msg);
      }
    }
  }

  /**
   * Write structure module.
   * Params:
   *   path = Directory to store the structure file(s) to (interfaces have multiple files)
   *   ifaceModule = Set to true to write interface module (defaults to false which writes the template mixin module for interfaces)
   */
  void write(string path, bool ifaceModule = false)
  {
    codeTrap("struct.write", fullName);

    auto isIfaceTemplate = kind == TypeKind.Interface && !ifaceModule;
    auto writer = new CodeWriter(buildPath(path, dType.to!string ~ (isIfaceTemplate ? "T" : "") ~ ".d")); // Append T to type name for interface mixin template module
    writer ~= ["module " ~ fullName ~ (isIfaceTemplate ? "T;"d : ";"d), ""];

    auto imports = new ImportSymbols(defCode.imports, this);

    imports.add("Gid.gid");
    imports.add(repo.namespace ~ ".c.functions");
    imports.add(repo.namespace ~ ".c.types");

    if (kind == TypeKind.Wrap)
      imports.add("GLib.c.functions"); // For g_free() - FIXME: probably shouldn't pull in everything here

    dstring[] propMethods;
    FuncWriter[] funcWriters;
    SignalWriter[] signalWriters;

    // Create the function and signal writers first to construct the imports
    if (defCode.genFuncs)
    {
      if (kind == TypeKind.Wrap || kind == TypeKind.Boxed)
        propMethods = constructFieldProps(imports); // Construct wrapper property methods in order to collect imports

      foreach (fn; functions)
      {
        if (!fn.disable)
          funcWriters ~= new FuncWriter(fn, imports);
      }

      foreach (sig; signals)
      {
        if (!sig.disable)
        {
          codeTrap("struct.signal", sig.fullName);
          signalWriters ~= new SignalWriter(sig, imports);
          imports.add("GObject.DClosure");
        }
      }
    }

    if (parentStruct)
      parentStruct.addImports(imports, repo); // Add parent to imports

    foreach (st; implementStructs) // Add implemented interfaces to imports
    {
      st.addImports(imports, repo);
      imports.add(st.fullDType ~ "T"); // Import interface template module also
    }

    if (!errorQuarks.empty)
      imports.add("GLib.ErrorG");

    imports.remove(fullDType);

    if (imports.write(writer, isIfaceTemplate ? "public " : "")) // Interface templates use public imports so they are conveyed to the object they are mixed into
      writer ~= "";

    if (defCode.preClass.length > 0)
      writer ~= defCode.preClass;

    writeDocs(writer);

    dstring[] objIfaces;

    if (defCode.classDecl.empty)
    {
      if (kind == TypeKind.Interface)
      {
        if (ifaceModule)
          writer ~= "interface " ~ dType;
        else
          writer ~= "template " ~ dType ~ "T(TStruct)";
      }
      else
      { // Create range of parent type and implemented interface types, but filter out interfaces already implemented by ancestors
        objIfaces = implementStructs.filter!(x => !getIfaceAncestor(x)).map!(x => x.dType).array;
        auto parentAndIfaces = (parentStruct ? [imports.resolveClassName(parentStruct)] : []) ~ objIfaces;
        writer ~= "class " ~ dType ~ (!parentAndIfaces.empty ? " : " ~ parentAndIfaces.join(", ") : "");
      }
    }
    else
      writer ~= defCode.classDecl;

    writer ~= "{";

    if (defCode.genInit)
      writeInitCode(writer, propMethods, ifaceModule);

    if (kind == TypeKind.Object && !objIfaces.empty)
    {
      writer ~= "";

      foreach (iface; objIfaces)
        writer ~= "mixin " ~ iface ~ "T!" ~ cType ~ ";";
    }

    if (defCode.inClass.length > 0)
      writer ~= defCode.inClass;

    if (defCode.genFuncs)
    {
      foreach (fnWriter; funcWriters)
      {
        writer ~= "";
        fnWriter.write(writer, ifaceModule);
      }

      foreach (sigWriter; signalWriters)
      {
        writer ~= "";
        sigWriter.write(writer, ifaceModule);
      }
    }

    writer ~= "}";

    if (defCode.genFuncs)
    {
      foreach (quarkFunc; errorQuarks) // Add error exceptions
      {
        if (!quarkFunc.disable)
        {
          writer ~= "";
          writer ~= quarkFunc.constructException;
        }
      }
    }

    if (defCode.postClass.length > 0)
      writer ~= defCode.postClass;

    writer.write();
  }

  // Write class init code
  private void writeInitCode(CodeWriter writer, dstring[] propMethods, bool ifaceModule)
  {
    if ((kind == TypeKind.Opaque && !pointer) || (kind == TypeKind.Reffed && !parentStruct))
      writer ~= [cTypeRemPtr ~ "* cInstancePtr;"];
    else if (kind == TypeKind.Opaque && pointer)
      writer ~= [cType ~ " cInstancePtr;"];
    else if (kind == TypeKind.Wrap)
      writer ~= [cTypeRemPtr ~ " cInstance;"];

    if (kind == TypeKind.Opaque)
      writer ~= "bool owned;";

    if (kind == TypeKind.Opaque)
      writer ~= ["", "this(void* ptr, bool owned = false)", "{",
        "if (!ptr)", "throw new GidConstructException(\"Null instance pointer for " ~ fullName ~ "\");", ""];
    else if (kind == TypeKind.Wrap || kind == TypeKind.Reffed)
      writer ~= ["", "this(void* ptr, bool ownedRef = false)", "{",
        "if (!ptr)", "throw new GidConstructException(\"Null instance pointer for " ~ fullName ~ "\");", ""];
    else if (kind == TypeKind.Boxed || kind == TypeKind.Object)
      writer ~= ["", "this(void* ptr, bool ownedRef = false)", "{",
        "super(cast(void*)ptr, ownedRef);", "}"];

    if (kind == TypeKind.Opaque && !pointer)
      writer ~= ["cInstancePtr = cast(" ~ cTypeRemPtr ~ "*)ptr;", "", "this.owned = owned;", "}"];
    else if (kind == TypeKind.Opaque && pointer)
      writer ~= ["cInstancePtr = cast(" ~ cType ~ ")ptr;", "", "this.owned = owned;", "}"];
    else if (kind == TypeKind.Wrap)
      writer ~= ["cInstance = *cast(" ~ cTypeRemPtr ~ "*)ptr;", "", "if (ownedRef)", "g_free(ptr);", "}"];
    else if (kind == TypeKind.Reffed && !parentStruct)
      writer ~= ["cInstancePtr = cast(" ~ cTypeRemPtr ~ "*)ptr;", "", "if (!ownedRef)", glibRefFunc
        ~ "(cInstancePtr);", "}", "", "~this()", "{", glibUnrefFunc ~ "(cInstancePtr);", "}", ""];
    else if (kind == TypeKind.Reffed && parentStruct)
      writer ~= ["super(cast(" ~ parentStruct.cType ~ "*)ptr, ownedRef);", "}"];

    if (kind == TypeKind.Opaque && freeFunction)
      writer ~= ["", "~this()", "{", "if (owned)", freeFunction ~ "(cInstancePtr);", "}"];
    else if (kind == TypeKind.Wrap && freeFunction)
      writer ~= ["", "~this()", "{", freeFunction ~ "(&cInstance);", "}"];

    if (kind == TypeKind.Opaque)
      writer ~= ["", "void* cPtr()", "{", "return cast(void*)cInstancePtr;", "}"];
    else if (kind == TypeKind.Reffed && !parentStruct)
      writer ~= ["", "void* cPtr(bool addRef = false)", "{", "if (addRef)", glibRefFunc ~ "(cInstancePtr);", "",
        "return cInstancePtr;", "}"];
    else if (kind == TypeKind.Boxed)
      writer ~= ["", "void* cPtr(bool makeCopy = false)", "{", "return makeCopy ? copy_ : cInstancePtr;", "}"];
    else if (kind == TypeKind.Wrap)
      writer ~= ["", "void* cPtr()", "{", "return cast(void*)&cInstance;", "}"];

    if (kind.among(TypeKind.Boxed, TypeKind.Object) || (kind == TypeKind.Interface && ifaceModule))
      writer ~= ["", "static GType getType()", "{", "return " ~ glibGetType ~ "();", "}"];

    if (kind.among(TypeKind.Opaque, TypeKind.Wrap, TypeKind.Boxed))
      writer ~= propMethods;
  }

  // Construct struct wrapper property methods
  private dstring[] constructFieldProps(ImportSymbols imports)
  {
    dstring[] lines;

    auto cPtr = "(cast(" ~ (cType.countStars > 0 ? cTypeRemPtr : cType) ~ "*)cPtr)";

    foreach (f; fields)
    {
      if (f.disable || f.private_)
        continue;

      assert(!f.directStruct, "Unsupported embedded structure field " ~ f.fullName.to!string);

      assert(f.containerType == ContainerType.None, "Unsupported structure field " ~ f.fullName.to!string
          ~ " with container type " ~ f.containerType.to!string);

      f.addImports(imports, repo);

      with (TypeKind) if (!f.kind.among(Callback, Simple))
        lines ~= ["", "@property " ~ f.dType ~ " " ~ f.dName ~ "()", "{"];
      else if (!f.typeObject) // Callback function type directly defined in field?
        lines ~= [
        "", "alias " ~ f.name.camelCase(true) ~ "FuncType = extern(C) " ~ f.callback.getCPrototype ~ ";"
      ]; // Add a type alias, since extern(C) can't be used directly in arg definition

      final switch (f.kind) with (TypeKind)
      {
        case Basic, BasicAlias, Pointer:
          lines ~= "return " ~ cPtr ~ "." ~ f.dName ~ ";";
          break;
        case String:
          lines ~= "return " ~ cPtr ~ "." ~ f.dName ~ ".fromCString(false);";
          break;
        case Enum, Flags:
          lines ~= "return cast(" ~ f.dType ~ ")" ~ cPtr ~ "." ~ f.dName ~ ";";
          break;
        case Simple:
          lines ~= ["", "@property " ~ f.dType ~ " " ~ f.dName ~ "()", "{"];
          lines ~= "return " ~ (f.cType.countStars == 1 ? "*"d : "") ~ cPtr ~ "." ~ f.dName ~ ";"; // Copy structure (dereference if it is a pointer to a structure)
          break;
        case Callback:
          if (f.typeObject) // Callback function is an alias type?
          {
            lines ~= ["", "@property " ~ f.cType ~ " " ~ f.dName ~ "()", "{"];

            if (auto typeNode = cast(TypeNode)f.typeObject)
              typeNode.addImports(imports, repo);
          }
          else // Callback function type is directly defined in field
            lines ~= ["", "@property " ~ f.name.camelCase(true) ~ "FuncType " ~ f.dName ~ "()", "{"];

          lines ~= "return " ~ cPtr ~ "." ~ f.dName ~ ";";
          break;
        case Opaque, Wrap, Boxed, Reffed:
          auto starCount = f.cType.retro.countUntil!(x => x != '*');

          if (starCount < 1) // The cast is for casting away "const"
            lines ~= "return new " ~ f.dType ~ "(cast(" ~ f.cType.stripConst ~ "*)" ~ "&" ~ cPtr ~ "." ~ f.dName ~ ");";
          else
            lines ~= "return new " ~ f.dType ~ "(cast(" ~ f.cType.stripConst ~ ")" ~ cPtr ~ "." ~ f.dName ~ ");";
          break;
        case Object:
          lines ~= "return ObjectG.getDObject!" ~ f.dType ~ "(" ~ cPtr ~ "." ~ f.dName ~ ", false);";
          imports.add("GObject.ObjectG");
          break;
        case Unknown, Interface, Container, Namespace:
          throw new Exception(
              "Unhandled readable field property type '" ~ f.dType.to!string ~ "' (" ~ f.kind.to!string
              ~ ") for struct " ~ dType.to!string);
      }

      lines ~= "}";

      if (!f.writable)
        continue;

      if (f.kind != TypeKind.Callback && f.kind != TypeKind.Simple)
        lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.dType ~ " propval)", "{"];

      final switch (f.kind) with (TypeKind)
      {
        case Basic, BasicAlias, Pointer:
          lines ~= cPtr ~ "." ~ f.dName ~ " = propval;";
          break;
        case String:
          lines ~= [
            "g_free(cast(void*)" ~ cPtr ~ "." ~ f.dName ~ ");",
            cPtr ~ "." ~ f.dName ~ " = propval.toCString(true);"
          ];
          imports.add("GLib.c.functions");
          break;
        case Enum, Flags:
          lines ~= cPtr ~ "." ~ f.dName ~ " = cast(" ~ f.cType ~ ")propval;";
          break;
        case Simple:
          lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.dType ~ " propval)", "{"];
          lines ~= cPtr ~ "." ~ f.dName ~ " = " ~ (f.cType.countStars == 1 ? "&"d : ""d) ~ "propval;"; // If field is a pointer, use the address of the structure
          break;
        case Callback:
          if (f.typeObject) // Callback function is an alias type?
          {
            lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.cType ~ " propval)", "{"];

            if (auto typeNode = cast(TypeNode)f.typeObject)
              typeNode.addImports(imports, repo);
          }
          else // Callback function type is directly defined in field
            lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.name.camelCase(true) ~ "FuncType propval)", "{"];

          lines ~= cPtr ~ "." ~ f.dName ~ " = propval;";
          break;
        case Opaque, Boxed, Wrap, Reffed, Object, Interface, Container, Namespace, Unknown:
          throw new Exception("Unhandled writable field property type '" ~ f.dType.to!string ~ "' (" ~ f
              .kind.to!string ~ ") for struct " ~ dType.to!string);
      }

      lines ~= "}";
    }

    return lines;
  }

  /**
   * Write a C structure definition
   * Params:
   *   writer = Code writer
   */
  void writeCStruct(CodeWriter writer)
  { // Recursive function to process embedded struct/union fields
    void recurseStruct(Structure st)
    {
      st.writeDocs(writer);

      auto typeName = st == this ? st.cType : st.name.camelCase(true) ~ "Type";

      writer ~= [(st.structType == StructType.Union ? "union "d : "struct "d) ~ typeName, "{"];

      foreach (fi, f; st.fields)
      {
        f.writeDocs(writer);

        if (f.directStruct)
        {
          recurseStruct(f.directStruct);
        }
        else if (f.containerType == ContainerType.Array)
        {
          if (f.fixedSize == ArrayNotFixed)
          { // Use array cType if array is not a fixed size
            if (!f.cType.empty)
              writer ~= f.cType ~ " " ~ f.dName ~ ";";
            else
              f.xmlNode.warn("Struct array field is not fixed size and array c:type not set");
          }
          else if (!f.elemTypes.empty && !f.elemTypes[0].cType.empty)
            writer ~= f.elemTypes[0].cType ~ "[" ~ f.fixedSize.to!dstring ~ "] " ~ f.dName ~ ";";
          else
            f.xmlNode.warn("Struct array field is missing c:type attribute");
        }
        else if (f.callback && !f.typeObject) // Directly defined callback field?
          writer ~= "extern(C) " ~ f.callback.getCPrototype ~ " " ~ f.callback.dName ~ ";";
        else // A regular field
        {
          if (!f.cType.empty)
            writer ~= f.cType ~ " " ~ f.dName ~ ";";
          else
            f.xmlNode.warn("Struct field is missing c:type attribute");
        }

        if (fi + 1 < st.fields.length)
          writer ~= "";
      }

      writer ~= ["}", ""];

      if (st != this)
        writer ~= [typeName ~ " " ~ st.dType ~ ";"]; // dType is the field name
    }

    recurseStruct(this);
  }

  StructType structType; /// Type of structure
  dstring cSymbolPrefix; /// C symbol prefix
  dstring parentType; /// Parent type name (for derived types)
  Structure parentStruct; /// Resolved parent type object

  dstring[] implements; /// Interfaces implemented by structure
  Structure[] implementStructs; /// Resolved interface implementation structures
  dstring[] prerequisites; /// Interface prerequisite types
  Func[] functions; /// Constructors, functions, methods, and virtual methods
  Func[] signals; /// Signals
  Field[] fields; /// Structure fields
  Property[] properties; /// Properties

  DefCode defCode; /// Code from definitions file
  Func ctorFunc; /// Primary instance constructor function in functions (not a Gir field)
  Func[] errorQuarks; /// List of GError quark functions for exceptions
  Func[dstring] funcNameHash; /// Hash of functions by name

  bool abstract_; /// Is abstract type?
  bool deprecated_; /// Deprecated?
  bool opaque; /// Opaque structure type
  bool pointer; /// Structure pointer type
  dstring version_; /// Version
  dstring deprecatedVersion; /// Deprecated version

  bool glibFundamental;
  dstring glibGetType; /// GLib get_type function
  dstring glibTypeName; /// GLib type name
  dstring glibGetValueFunc; /// GLib get value function
  dstring glibSetValueFunc; /// GLib set value function
  dstring glibRefFunc; /// GLib ref function
  dstring glibUnrefFunc; /// GLib unref function
  dstring glibTypeStruct; /// GLib class structure
  dstring glibIsGtypeStructFor; /// Indicates what type a class structure belongs to
  dstring copyFunction; /// Record/Union copy function (not seen in the wild, but defined in gir-1.2.rnc - we use it via XML patching)
  dstring freeFunction; /// Record/Union free function (not seen in the wild, but defined in gir-1.2.rnc - we use it via XML patching)
}

/// Type of structure
enum StructType
{
  Class, /// A class
  Interface, /// An interface
  Record, /// A structure record
  Union, /// A union
}

immutable dstring[] StructTypeValues = ["class", "interface", "record", "union"];
