//!repo Gdk-4.0

//# Conflicts with undocumented Phobos object.Object.Monitor interface
//!subtype Monitor MonitorG

//# Set arrays to be zero-terminated=1
//!set class[Clipboard].method[read_async].parameters.parameter[mime_types].array[][zero-terminated] 1
//!set class[Drop].method[read_async].parameters.parameter[mime_types].array[][zero-terminated] 1
