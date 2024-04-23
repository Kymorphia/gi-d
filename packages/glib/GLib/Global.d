module GLib.Global;

import GLib.Bytes;
import GLib.DebugKey;
import GLib.ErrorG;
import GLib.IOChannel;
import GLib.LogField;
import GLib.Source;
import GLib.TestSuite;
import GLib.TimeVal;
import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GLib.c.types;
import GObject.Types;
import Gid.Gid;


/**
 * zero if the pathname refers to an existing file system
 * object that has all the tested permissions, or -1 otherwise
 * or on error.
 */
int access(string filename, int mode)
{
  int _retval;
  const(char)* _filename = filename.toCString(false);
  _retval = g_access(_filename, mode);
  return _retval;
}

/**
 * the allocated memory
 */
void* alignedAlloc(size_t nBlocks, size_t nBlockBytes, size_t alignment)
{
  void* _retval;
  _retval = g_aligned_alloc(nBlocks, nBlockBytes, alignment);
  return _retval;
}

/**
 * the allocated, cleared memory
 */
void* alignedAlloc0(size_t nBlocks, size_t nBlockBytes, size_t alignment)
{
  void* _retval;
  _retval = g_aligned_alloc0(nBlocks, nBlockBytes, alignment);
  return _retval;
}

/**
 * Frees the memory allocated by g_aligned_alloc().
 */
void alignedFree(void* mem)
{
  g_aligned_free(mem);
}

/**
 * Frees the memory pointed to by @mem, assuming it is has the given @size and
 * @alignment.
 *
 * If @mem is %NULL this is a no-op (and @size is ignored).
 *
 * It is an error if @size doesn’t match the size, or @alignment doesn’t match
 * the alignment, passed when @mem was allocated. @size and @alignment are
 * passed to this function to allow optimizations in the allocator. If you
 * don’t know either of them, use g_aligned_free() instead.
 */
void alignedFreeSized(void* mem, size_t alignment, size_t size)
{
  g_aligned_free_sized(mem, alignment, size);
}

/**
 * If @c is a decimal digit (according to g_ascii_isdigit()),
 * its numeric value. Otherwise, -1.
 */
int asciiDigitValue(char c)
{
  int _retval;
  _retval = g_ascii_digit_value(c);
  return _retval;
}

/**
 * The pointer to the buffer with the converted string.
 */
string asciiDtostr(string buffer, int bufLen, double d)
{
  char* _cretval;
  char* _buffer = buffer.toCString(false);
  _cretval = g_ascii_dtostr(_buffer, bufLen, d);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * The pointer to the buffer with the converted string.
 */
string asciiFormatd(string buffer, int bufLen, string format, double d)
{
  char* _cretval;
  char* _buffer = buffer.toCString(false);
  const(char)* _format = format.toCString(false);
  _cretval = g_ascii_formatd(_buffer, bufLen, _format, d);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * 0 if the strings match, a negative value if @s1 < @s2,
 * or a positive value if @s1 > @s2.
 */
int asciiStrcasecmp(string s1, string s2)
{
  int _retval;
  const(char)* _s1 = s1.toCString(false);
  const(char)* _s2 = s2.toCString(false);
  _retval = g_ascii_strcasecmp(_s1, _s2);
  return _retval;
}

/**
 * a newly-allocated string, with all the upper case
 * characters in @str converted to lower case, with semantics that
 * exactly match g_ascii_tolower(). (Note that this is unlike the
 * old g_strdown(), which modified the string in place.)
 */
string asciiStrdown(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_ascii_strdown(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if @str was a number, otherwise %FALSE.
 */
bool asciiStringToSigned(string str, uint base, long min, long max, out long outNum)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  GError *_err;
  _retval = g_ascii_string_to_signed(_str, base, min, max, cast(long*)&outNum, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE if @str was a number, otherwise %FALSE.
 */
bool asciiStringToUnsigned(string str, uint base, ulong min, ulong max, out ulong outNum)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  GError *_err;
  _retval = g_ascii_string_to_unsigned(_str, base, min, max, cast(ulong*)&outNum, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * 0 if the strings match, a negative value if @s1 < @s2,
 * or a positive value if @s1 > @s2.
 */
int asciiStrncasecmp(string s1, string s2, size_t n)
{
  int _retval;
  const(char)* _s1 = s1.toCString(false);
  const(char)* _s2 = s2.toCString(false);
  _retval = g_ascii_strncasecmp(_s1, _s2, n);
  return _retval;
}

/**
 * the #gdouble value.
 */
double asciiStrtod(string nptr, out string endptr)
{
  double _retval;
  const(char)* _nptr = nptr.toCString(false);
  char* _endptr;
  _retval = g_ascii_strtod(_nptr, &_endptr);
  endptr = _endptr.fromCString(false);
  return _retval;
}

/**
 * the #gint64 value or zero on error.
 */
long asciiStrtoll(string nptr, out string endptr, uint base)
{
  long _retval;
  const(char)* _nptr = nptr.toCString(false);
  char* _endptr;
  _retval = g_ascii_strtoll(_nptr, &_endptr, base);
  endptr = _endptr.fromCString(false);
  return _retval;
}

/**
 * the #guint64 value or zero on error.
 */
ulong asciiStrtoull(string nptr, out string endptr, uint base)
{
  ulong _retval;
  const(char)* _nptr = nptr.toCString(false);
  char* _endptr;
  _retval = g_ascii_strtoull(_nptr, &_endptr, base);
  endptr = _endptr.fromCString(false);
  return _retval;
}

/**
 * a newly allocated string, with all the lower case
 * characters in @str converted to upper case, with semantics that
 * exactly match g_ascii_toupper(). (Note that this is unlike the
 * old g_strup(), which modified the string in place.)
 */
string asciiStrup(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_ascii_strup(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the result of converting @c to lower case. If @c is
 * not an ASCII upper case letter, @c is returned unchanged.
 */
char asciiTolower(char c)
{
  char _retval;
  _retval = g_ascii_tolower(c);
  return _retval;
}

/**
 * the result of converting @c to upper case. If @c is not
 * an ASCII lower case letter, @c is returned unchanged.
 */
char asciiToupper(char c)
{
  char _retval;
  _retval = g_ascii_toupper(c);
  return _retval;
}

/**
 * If @c is a hex digit (according to g_ascii_isxdigit()),
 * its numeric value. Otherwise, -1.
 */
int asciiXdigitValue(char c)
{
  int _retval;
  _retval = g_ascii_xdigit_value(c);
  return _retval;
}

void assertWarning(string logDomain, string file, int line, string prettyFunction, string expression)
{
  const(char)* _logDomain = logDomain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _prettyFunction = prettyFunction.toCString(false);
  const(char)* _expression = expression.toCString(false);
  g_assert_warning(_logDomain, _file, line, _prettyFunction, _expression);
}

void assertionMessage(string domain, string file, int line, string func, string message)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _message = message.toCString(false);
  g_assertion_message(_domain, _file, line, _func, _message);
}

void assertionMessageCmpint(string domain, string file, int line, string func, string expr, ulong arg1, string cmp, ulong arg2, char numtype)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _expr = expr.toCString(false);
  const(char)* _cmp = cmp.toCString(false);
  g_assertion_message_cmpint(_domain, _file, line, _func, _expr, arg1, _cmp, arg2, numtype);
}

void assertionMessageCmpstr(string domain, string file, int line, string func, string expr, string arg1, string cmp, string arg2)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _expr = expr.toCString(false);
  const(char)* _arg1 = arg1.toCString(false);
  const(char)* _cmp = cmp.toCString(false);
  const(char)* _arg2 = arg2.toCString(false);
  g_assertion_message_cmpstr(_domain, _file, line, _func, _expr, _arg1, _cmp, _arg2);
}

void assertionMessageCmpstrv(string domain, string file, int line, string func, string expr, string[] arg1, string[] arg2, size_t firstWrongIdx)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _expr = expr.toCString(false);
  const(char)*[] _tmparg1;
  foreach (s; arg1)
    _tmparg1 ~= s.toCString(false);
  _tmparg1 ~= null;
  const(char*)* _arg1 = _tmparg1.ptr;

  const(char)*[] _tmparg2;
  foreach (s; arg2)
    _tmparg2 ~= s.toCString(false);
  _tmparg2 ~= null;
  const(char*)* _arg2 = _tmparg2.ptr;
  g_assertion_message_cmpstrv(_domain, _file, line, _func, _expr, _arg1, _arg2, firstWrongIdx);
}

void assertionMessageError(string domain, string file, int line, string func, string expr, ErrorG error, Quark errorDomain, int errorCode)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _expr = expr.toCString(false);
  g_assertion_message_error(_domain, _file, line, _func, _expr, error ? error.cPtr!GError : null, errorDomain, errorCode);
}

/**
 * the value of @atomic before the add, signed
 */
int atomicIntAdd(inout int atomic, int val)
{
  int _retval;
  _retval = g_atomic_int_add(cast(int*)&atomic, val);
  return _retval;
}

/**
 * the value of @atomic before the operation, unsigned
 */
uint atomicIntAnd(inout uint atomic, uint val)
{
  uint _retval;
  _retval = g_atomic_int_and(cast(uint*)&atomic, val);
  return _retval;
}

/**
 * %TRUE if the exchange took place
 */
bool atomicIntCompareAndExchange(inout int atomic, int oldval, int newval)
{
  bool _retval;
  _retval = g_atomic_int_compare_and_exchange(cast(int*)&atomic, oldval, newval);
  return _retval;
}

/**
 * %TRUE if the exchange took place
 */
bool atomicIntCompareAndExchangeFull(inout int atomic, int oldval, int newval, out int preval)
{
  bool _retval;
  _retval = g_atomic_int_compare_and_exchange_full(cast(int*)&atomic, oldval, newval, cast(int*)&preval);
  return _retval;
}

/**
 * %TRUE if the resultant value is zero
 */
bool atomicIntDecAndTest(inout int atomic)
{
  bool _retval;
  _retval = g_atomic_int_dec_and_test(cast(int*)&atomic);
  return _retval;
}

/**
 * the value of @atomic before the exchange, signed
 */
int atomicIntExchange(inout int atomic, int newval)
{
  int _retval;
  _retval = g_atomic_int_exchange(cast(int*)&atomic, newval);
  return _retval;
}

/**
 * the value of @atomic before the add, signed
 */
int atomicIntExchangeAndAdd(inout int atomic, int val)
{
  int _retval;
  _retval = g_atomic_int_exchange_and_add(cast(int*)&atomic, val);
  return _retval;
}

/**
 * the value of the integer
 */
int atomicIntGet(out int atomic)
{
  int _retval;
  _retval = g_atomic_int_get(cast(const(int)*)&atomic);
  return _retval;
}

/**
 * Increments the value of @atomic by 1.
 *
 * Think of this operation as an atomic version of `{ *atomic += 1; }`.
 *
 * This call acts as a full compiler and hardware memory barrier.
 *
 * While @atomic has a `volatile` qualifier, this is a historical artifact and
 * the pointer passed to it should not be `volatile`.
 */
void atomicIntInc(inout int atomic)
{
  g_atomic_int_inc(cast(int*)&atomic);
}

/**
 * the value of @atomic before the operation, unsigned
 */
uint atomicIntOr(inout uint atomic, uint val)
{
  uint _retval;
  _retval = g_atomic_int_or(cast(uint*)&atomic, val);
  return _retval;
}

/**
 * Sets the value of @atomic to @newval.
 *
 * This call acts as a full compiler and hardware
 * memory barrier (after the set).
 *
 * While @atomic has a `volatile` qualifier, this is a historical artifact and
 * the pointer passed to it should not be `volatile`.
 */
void atomicIntSet(inout int atomic, int newval)
{
  g_atomic_int_set(cast(int*)&atomic, newval);
}

/**
 * the value of @atomic before the operation, unsigned
 */
uint atomicIntXor(inout uint atomic, uint val)
{
  uint _retval;
  _retval = g_atomic_int_xor(cast(uint*)&atomic, val);
  return _retval;
}

/**
 * the value of @atomic before the add, signed
 */
ptrdiff_t atomicPointerAdd(void* atomic, ptrdiff_t val)
{
  ptrdiff_t _retval;
  _retval = g_atomic_pointer_add(atomic, val);
  return _retval;
}

/**
 * the value of @atomic before the operation, unsigned
 */
size_t atomicPointerAnd(void* atomic, size_t val)
{
  size_t _retval;
  _retval = g_atomic_pointer_and(atomic, val);
  return _retval;
}

/**
 * %TRUE if the exchange took place
 */
bool atomicPointerCompareAndExchange(void* atomic, void* oldval, void* newval)
{
  bool _retval;
  _retval = g_atomic_pointer_compare_and_exchange(atomic, oldval, newval);
  return _retval;
}

/**
 * %TRUE if the exchange took place
 */
bool atomicPointerCompareAndExchangeFull(void* atomic, void* oldval, void* newval, out void* preval)
{
  bool _retval;
  _retval = g_atomic_pointer_compare_and_exchange_full(atomic, oldval, newval, cast(void*)&preval);
  return _retval;
}

/**
 * the value of @atomic before the exchange
 */
void* atomicPointerExchange(void* atomic, void* newval)
{
  void* _retval;
  _retval = g_atomic_pointer_exchange(atomic, newval);
  return _retval;
}

/**
 * the value of the pointer
 */
void* atomicPointerGet(void* atomic)
{
  void* _retval;
  _retval = g_atomic_pointer_get(atomic);
  return _retval;
}

/**
 * the value of @atomic before the operation, unsigned
 */
size_t atomicPointerOr(void* atomic, size_t val)
{
  size_t _retval;
  _retval = g_atomic_pointer_or(atomic, val);
  return _retval;
}

/**
 * Sets the value of @atomic to @newval.
 *
 * This call acts as a full compiler and hardware
 * memory barrier (after the set).
 *
 * While @atomic has a `volatile` qualifier, this is a historical artifact and
 * the pointer passed to it should not be `volatile`.
 */
void atomicPointerSet(void* atomic, void* newval)
{
  g_atomic_pointer_set(atomic, newval);
}

/**
 * the value of @atomic before the operation, unsigned
 */
size_t atomicPointerXor(void* atomic, size_t val)
{
  size_t _retval;
  _retval = g_atomic_pointer_xor(atomic, val);
  return _retval;
}

/**
 * a pointer to the data,
 * with its reference count increased
 */
void* atomicRcBoxAcquire(void* memBlock)
{
  void* _retval;
  _retval = g_atomic_rc_box_acquire(memBlock);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* atomicRcBoxAlloc(size_t blockSize)
{
  void* _retval;
  _retval = g_atomic_rc_box_alloc(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* atomicRcBoxAlloc0(size_t blockSize)
{
  void* _retval;
  _retval = g_atomic_rc_box_alloc0(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated
 * memory
 */
void* atomicRcBoxDup(size_t blockSize, const(void)* memBlock)
{
  void* _retval;
  _retval = g_atomic_rc_box_dup(blockSize, memBlock);
  return _retval;
}

/**
 * the size of the data, in bytes
 */
size_t atomicRcBoxGetSize(void* memBlock)
{
  size_t _retval;
  _retval = g_atomic_rc_box_get_size(memBlock);
  return _retval;
}

/**
 * Atomically releases a reference on the data pointed by @mem_block.
 *
 * If the reference was the last one, it will free the
 * resources allocated for @mem_block.
 */
void atomicRcBoxRelease(void* memBlock)
{
  g_atomic_rc_box_release(memBlock);
}

/**
 * Atomically releases a reference on the data pointed by @mem_block.
 *
 * If the reference was the last one, it will call @clear_func
 * to clear the contents of @mem_block, and then will free the
 * resources allocated for @mem_block.
 */
void atomicRcBoxReleaseFull(void* memBlock, DestroyNotify clearFunc)
{
  static DestroyNotify _static_clearFunc;

  extern(C) void _clearFuncCallback(void* data)
  {
    _static_clearFunc();
  }

  _static_clearFunc = clearFunc;
  g_atomic_rc_box_release_full(memBlock, &_clearFuncCallback);
  _static_clearFunc = null;
}

/**
 * %TRUE if the reference count is the same
 * as the given value
 */
bool atomicRefCountCompare(inout int arc, int val)
{
  bool _retval;
  _retval = g_atomic_ref_count_compare(cast(int*)&arc, val);
  return _retval;
}

/**
 * %TRUE if the reference count reached 0, and %FALSE otherwise
 */
bool atomicRefCountDec(inout int arc)
{
  bool _retval;
  _retval = g_atomic_ref_count_dec(cast(int*)&arc);
  return _retval;
}

/**
 * Atomically increases the reference count.
 */
void atomicRefCountInc(inout int arc)
{
  g_atomic_ref_count_inc(cast(int*)&arc);
}

/**
 * Initializes a reference count variable to 1.
 */
void atomicRefCountInit(inout int arc)
{
  g_atomic_ref_count_init(cast(int*)&arc);
}

/**
 * newly allocated buffer containing the binary data
 * that @text represents. The returned buffer must
 * be freed with g_free().
 */
ubyte[] base64Decode(string text)
{
  ubyte* _cretval;
  size_t _cretlength;
  const(char)* _text = text.toCString(false);
  _cretval = g_base64_decode(_text, &_cretlength);
  ubyte[] _retval;

  if (_cretval)
  {
    _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a newly allocated, zero-terminated Base-64
 * encoded string representing @data. The returned string must
 * be freed with g_free().
 */
string base64Encode(ubyte[] data)
{
  char* _cretval;
  auto _data = cast(const(ubyte)*)data.ptr;
  _cretval = g_base64_encode(_data, data ? cast(size_t)data.length : 0);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the name of the file without any leading
 * directory components
 */
string basename(string fileName)
{
  const(char)* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = g_basename(_fileName);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Sets the indicated @lock_bit in @address.  If the bit is already
 * set, this call will block until g_bit_unlock() unsets the
 * corresponding bit.
 *
 * Attempting to lock on two different bits within the same integer is
 * not supported and will very probably cause deadlocks.
 *
 * The value of the bit that is set is (1u << @bit).  If @bit is not
 * between 0 and 31 then the result is undefined.
 *
 * This function accesses @address atomically.  All other accesses to
 * @address must be atomic in order for this function to work
 * reliably. While @address has a `volatile` qualifier, this is a historical
 * artifact and the argument passed to it should not be `volatile`.
 */
void bitLock(inout int address, int lockBit)
{
  g_bit_lock(cast(int*)&address, lockBit);
}

/**
 * the index of the first bit set which is higher than @nth_bit, or -1
 * if no higher bits are set
 */
int bitNthLsf(ulong mask, int nthBit)
{
  int _retval;
  _retval = g_bit_nth_lsf(mask, nthBit);
  return _retval;
}

/**
 * the index of the first bit set which is lower than @nth_bit, or -1
 * if no lower bits are set
 */
int bitNthMsf(ulong mask, int nthBit)
{
  int _retval;
  _retval = g_bit_nth_msf(mask, nthBit);
  return _retval;
}

/**
 * the number of bits used to hold @number
 */
uint bitStorage(ulong number)
{
  uint _retval;
  _retval = g_bit_storage(number);
  return _retval;
}

/**
 * %TRUE if the lock was acquired
 */
bool bitTrylock(inout int address, int lockBit)
{
  bool _retval;
  _retval = g_bit_trylock(cast(int*)&address, lockBit);
  return _retval;
}

/**
 * Clears the indicated @lock_bit in @address.  If another thread is
 * currently blocked in g_bit_lock() on this same bit then it will be
 * woken up.
 *
 * This function accesses @address atomically.  All other accesses to
 * @address must be atomic in order for this function to work
 * reliably. While @address has a `volatile` qualifier, this is a historical
 * artifact and the argument passed to it should not be `volatile`.
 */
void bitUnlock(inout int address, int lockBit)
{
  g_bit_unlock(cast(int*)&address, lockBit);
}

/**
 * the newly allocated path
 */
string buildFilenamev(string[] args)
{
  char* _cretval;
  char*[] _tmpargs;
  foreach (s; args)
    _tmpargs ~= s.toCString(false);
  _tmpargs ~= null;
  char** _args = _tmpargs.ptr;
  _cretval = g_build_filenamev(_args);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated string that
 * must be freed with g_free().
 */
string buildPathv(string separator, string[] args)
{
  char* _cretval;
  const(char)* _separator = separator.toCString(false);
  char*[] _tmpargs;
  foreach (s; args)
    _tmpargs ~= s.toCString(false);
  _tmpargs ~= null;
  char** _args = _tmpargs.ptr;
  _cretval = g_build_pathv(_separator, _args);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string with the
 * canonical file path
 */
string canonicalizeFilename(string filename, string relativeTo)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  const(char)* _relativeTo = relativeTo.toCString(false);
  _cretval = g_canonicalize_filename(_filename, _relativeTo);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * 0 on success, -1 if an error occurred.
 */
int chdir(string path)
{
  int _retval;
  const(char)* _path = path.toCString(false);
  _retval = g_chdir(_path);
  return _retval;
}

/**
 * %NULL if the GLib library is
 * compatible with the given version, or a string describing the
 * version mismatch. The returned string is owned by GLib and must
 * not be modified or freed.
 */
string checkVersion(uint requiredMajor, uint requiredMinor, uint requiredMicro)
{
  const(char)* _cretval;
  _cretval = glib_check_version(requiredMajor, requiredMinor, requiredMicro);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the ID (greater than 0) of the event source.
 */
uint childWatchAdd(int priority, Pid pid, ChildWatchFunc function_)
{
  extern(C) void _function_Callback(GPid pid, int waitStatus, void* userData)
  {
    (*(cast(ChildWatchFunc*)userData))(pid, waitStatus);
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&function_);
  _retval = g_child_watch_add_full(priority, pid, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * the newly-created child watch source
 */
Source childWatchSourceNew(Pid pid)
{
  GSource* _cretval;
  _cretval = g_child_watch_source_new(pid);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * If @err or *@err is %NULL, does nothing. Otherwise,
 * calls g_error_free() on *@err and sets *@err to %NULL.
 */
void clearError()
{
  GError *_err;
  g_clear_error(&_err);
  if (_err)
    throw new ErrorG(_err);
}

/**
 * %TRUE on success, %FALSE if there was an error.
 */
bool close(int fd)
{
  bool _retval;
  GError *_err;
  _retval = g_close(fd, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * the digest of the binary data as a
 * string in hexadecimal, or %NULL if g_checksum_new() fails for
 * @checksum_type. The returned string should be freed with g_free() when
 * done using it.
 */
string computeChecksumForBytes(ChecksumType checksumType, Bytes data)
{
  char* _cretval;
  _cretval = g_compute_checksum_for_bytes(checksumType, data ? data.cPtr!GBytes : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the digest of the binary data as a
 * string in hexadecimal, or %NULL if g_checksum_new() fails for
 * @checksum_type. The returned string should be freed with g_free() when
 * done using it.
 */
string computeChecksumForData(ChecksumType checksumType, ubyte[] data)
{
  char* _cretval;
  auto _data = cast(const(ubyte)*)data.ptr;
  _cretval = g_compute_checksum_for_data(checksumType, _data, data ? cast(size_t)data.length : 0);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the checksum as a hexadecimal string,
 * or %NULL if g_checksum_new() fails for @checksum_type. The returned string
 * should be freed with g_free() when done using it.
 */
string computeChecksumForString(ChecksumType checksumType, string str, ptrdiff_t length)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_compute_checksum_for_string(checksumType, _str, length);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the HMAC of the binary data as a string in hexadecimal.
 * The returned string should be freed with g_free() when done using it.
 */
string computeHmacForBytes(ChecksumType digestType, Bytes key, Bytes data)
{
  char* _cretval;
  _cretval = g_compute_hmac_for_bytes(digestType, key ? key.cPtr!GBytes : null, data ? data.cPtr!GBytes : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the HMAC of the binary data as a string in hexadecimal.
 * The returned string should be freed with g_free() when done using it.
 */
string computeHmacForData(ChecksumType digestType, ubyte[] key, ubyte[] data)
{
  char* _cretval;
  auto _key = cast(const(ubyte)*)key.ptr;
  auto _data = cast(const(ubyte)*)data.ptr;
  _cretval = g_compute_hmac_for_data(digestType, _key, key ? cast(size_t)key.length : 0, _data, data ? cast(size_t)data.length : 0);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the HMAC as a hexadecimal string.
 * The returned string should be freed with g_free()
 * when done using it.
 */
string computeHmacForString(ChecksumType digestType, ubyte[] key, string str, ptrdiff_t length)
{
  char* _cretval;
  auto _key = cast(const(ubyte)*)key.ptr;
  const(char)* _str = str.toCString(false);
  _cretval = g_compute_hmac_for_string(digestType, _key, key ? cast(size_t)key.length : 0, _str, length);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * If the conversion was successful, a newly allocated buffer
 * containing the converted string, which must be freed with g_free().
 * Otherwise %NULL and @error will be set.
 */
ubyte[] convert(ubyte[] str, string toCodeset, string fromCodeset, out size_t bytesRead)
{
  ubyte* _cretval;
  size_t _cretlength;
  auto _str = cast(const(ubyte)*)str.ptr;
  const(char)* _toCodeset = toCodeset.toCString(false);
  const(char)* _fromCodeset = fromCodeset.toCString(false);
  GError *_err;
  _cretval = g_convert(_str, str ? cast(ptrdiff_t)str.length : 0, _toCodeset, _fromCodeset, cast(size_t*)&bytesRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  ubyte[] _retval;

  if (_cretval)
  {
    _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

Quark convertErrorQuark()
{
  Quark _retval;
  _retval = g_convert_error_quark();
  return _retval;
}

/**
 * If the conversion was successful, a newly allocated buffer
 * containing the converted string, which must be freed with g_free().
 * Otherwise %NULL and @error will be set.
 */
ubyte[] convertWithFallback(ubyte[] str, string toCodeset, string fromCodeset, string fallback, out size_t bytesRead)
{
  ubyte* _cretval;
  size_t _cretlength;
  auto _str = cast(const(ubyte)*)str.ptr;
  const(char)* _toCodeset = toCodeset.toCString(false);
  const(char)* _fromCodeset = fromCodeset.toCString(false);
  const(char)* _fallback = fallback.toCString(false);
  GError *_err;
  _cretval = g_convert_with_fallback(_str, str ? cast(ptrdiff_t)str.length : 0, _toCodeset, _fromCodeset, _fallback, cast(size_t*)&bytesRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  ubyte[] _retval;

  if (_cretval)
  {
    _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Destroys the dataset, freeing all memory allocated, and calling any
 * destroy functions set for data elements.
 */
void datasetDestroy(const(void)* datasetLocation)
{
  g_dataset_destroy(datasetLocation);
}

/**
 * Calls the given function for each data element which is associated
 * with the given location. Note that this function is NOT thread-safe.
 * So unless @dataset_location can be protected from any modifications
 * during invocation of this function, it should not be called.
 *
 * @func can make changes to the dataset, but the iteration will not
 * reflect changes made during the g_dataset_foreach() call, other
 * than skipping over elements that are removed.
 */
void datasetForeach(const(void)* datasetLocation, DataForeachFunc func)
{
  static DataForeachFunc _static_func;

  extern(C) void _funcCallback(GQuark keyId, void* data, void* userData)
  {
    _static_func(keyId, data);
  }

  _static_func = func;
  ptrFreezeGC(cast(void*)&func);
  g_dataset_foreach(datasetLocation, &_funcCallback, cast(void*)&func);
  _static_func = null;
}

/**
 * the data element corresponding to
 * the #GQuark, or %NULL if it is not found.
 */
void* datasetIdGetData(const(void)* datasetLocation, Quark keyId)
{
  void* _retval;
  _retval = g_dataset_id_get_data(datasetLocation, keyId);
  return _retval;
}

/**
 * the translated string for the given locale category
 */
string dcgettext(string domain, string msgid, int category)
{
  const(char)* _cretval;
  const(char)* _domain = domain.toCString(false);
  const(char)* _msgid = msgid.toCString(false);
  _cretval = g_dcgettext(_domain, _msgid, category);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * The translated string
 */
string dgettext(string domain, string msgid)
{
  const(char)* _cretval;
  const(char)* _domain = domain.toCString(false);
  const(char)* _msgid = msgid.toCString(false);
  _cretval = g_dgettext(_domain, _msgid);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if the two keys match.
 */
bool directEqual(const(void)* v1, const(void)* v2)
{
  bool _retval;
  _retval = g_direct_equal(v1, v2);
  return _retval;
}

/**
 * a hash value corresponding to the key.
 */
uint directHash(const(void)* v)
{
  uint _retval;
  _retval = g_direct_hash(v);
  return _retval;
}

/**
 * The translated string
 */
string dngettext(string domain, string msgid, string msgidPlural, ulong n)
{
  const(char)* _cretval;
  const(char)* _domain = domain.toCString(false);
  const(char)* _msgid = msgid.toCString(false);
  const(char)* _msgidPlural = msgidPlural.toCString(false);
  _cretval = g_dngettext(_domain, _msgid, _msgidPlural, n);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if the two keys match.
 */
bool doubleEqual(const(void)* v1, const(void)* v2)
{
  bool _retval;
  _retval = g_double_equal(v1, v2);
  return _retval;
}

/**
 * a hash value corresponding to the key.
 */
uint doubleHash(const(void)* v)
{
  uint _retval;
  _retval = g_double_hash(v);
  return _retval;
}

/**
 * The translated string
 */
string dpgettext(string domain, string msgctxtid, size_t msgidoffset)
{
  const(char)* _cretval;
  const(char)* _domain = domain.toCString(false);
  const(char)* _msgctxtid = msgctxtid.toCString(false);
  _cretval = g_dpgettext(_domain, _msgctxtid, msgidoffset);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * The translated string
 */
string dpgettext2(string domain, string context, string msgid)
{
  const(char)* _cretval;
  const(char)* _domain = domain.toCString(false);
  const(char)* _context = context.toCString(false);
  const(char)* _msgid = msgid.toCString(false);
  _cretval = g_dpgettext2(_domain, _context, _msgid);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the value of the environment variable, or %NULL if
 * the environment variable is not set in @envp. The returned
 * string is owned by @envp, and will be freed if @variable is
 * set or unset again.
 */
string environGetenv(string[] envp, string variable)
{
  const(char)* _cretval;
  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  char** _envp = _tmpenvp.ptr;

  const(char)* _variable = variable.toCString(false);
  _cretval = g_environ_getenv(_envp, _variable);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * #GFileError corresponding to the given @err_no
 */
FileError fileErrorFromErrno(int errNo)
{
  GFileError _cretval;
  _cretval = g_file_error_from_errno(errNo);
  FileError _retval = cast(FileError)_cretval;
  return _retval;
}

Quark fileErrorQuark()
{
  Quark _retval;
  _retval = g_file_error_quark();
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error occurred
 */
bool fileGetContents(string filename, out ubyte[] contents)
{
  bool _retval;
  const(char)* _filename = filename.toCString(false);
  ubyte* _contents;
  size_t _length;
  GError *_err;
  _retval = g_file_get_contents(_filename, &_contents, &_length, &_err);
  if (_err)
    throw new ErrorG(_err);
  contents = _contents[0 .. _length];
  g_free(cast(void*)_contents);
  return _retval;
}

/**
 * A file handle (as from open()) to the file opened for
 * reading and writing. The file is opened in binary mode on platforms
 * where there is a difference. The file handle should be closed with
 * close(). In case of errors, -1 is returned and @error will be set.
 */
int fileOpenTmp(string tmpl, out string nameUsed)
{
  int _retval;
  const(char)* _tmpl = tmpl.toCString(false);
  char* _nameUsed;
  GError *_err;
  _retval = g_file_open_tmp(_tmpl, &_nameUsed, &_err);
  if (_err)
    throw new ErrorG(_err);
  nameUsed = _nameUsed.fromCString(true);
  return _retval;
}

/**
 * A newly-allocated string with
 * the contents of the symbolic link, or %NULL if an error occurred.
 */
string fileReadLink(string filename)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  GError *_err;
  _cretval = g_file_read_link(_filename, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error occurred
 */
bool fileSetContents(string filename, ubyte[] contents)
{
  bool _retval;
  const(char)* _filename = filename.toCString(false);
  auto _contents = cast(const(ubyte)*)contents.ptr;
  GError *_err;
  _retval = g_file_set_contents(_filename, _contents, contents ? cast(ptrdiff_t)contents.length : 0, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error occurred
 */
bool fileSetContentsFull(string filename, ubyte[] contents, FileSetContentsFlags flags, int mode)
{
  bool _retval;
  const(char)* _filename = filename.toCString(false);
  auto _contents = cast(const(ubyte)*)contents.ptr;
  GError *_err;
  _retval = g_file_set_contents_full(_filename, _contents, contents ? cast(ptrdiff_t)contents.length : 0, flags, mode, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * whether a test was %TRUE
 */
bool fileTest(string filename, FileTest test)
{
  bool _retval;
  const(char)* _filename = filename.toCString(false);
  _retval = g_file_test(_filename, test);
  return _retval;
}

/**
 * a newly allocated string containing
 * a rendition of the basename of the filename in valid UTF-8
 */
string filenameDisplayBasename(string filename)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = g_filename_display_basename(_filename);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string containing
 * a rendition of the filename in valid UTF-8
 */
string filenameDisplayName(string filename)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = g_filename_display_name(_filename);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated string holding
 * the resulting filename, or %NULL on an error.
 */
string filenameFromUri(string uri, out string hostname)
{
  char* _cretval;
  const(char)* _uri = uri.toCString(false);
  char* _hostname;
  GError *_err;
  _cretval = g_filename_from_uri(_uri, &_hostname, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  hostname = _hostname.fromCString(true);
  return _retval;
}

/**
 * The converted string, or %NULL on an error.
 */
string filenameFromUtf8(string utf8string, ptrdiff_t len, out size_t bytesRead, out size_t bytesWritten)
{
  char* _cretval;
  const(char)* _utf8string = utf8string.toCString(false);
  GError *_err;
  _cretval = g_filename_from_utf8(_utf8string, len, cast(size_t*)&bytesRead, cast(size_t*)&bytesWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated string holding the resulting
 * URI, or %NULL on an error.
 */
string filenameToUri(string filename, string hostname)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  const(char)* _hostname = hostname.toCString(false);
  GError *_err;
  _cretval = g_filename_to_uri(_filename, _hostname, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * The converted string, or %NULL on an error.
 */
string filenameToUtf8(string opsysstring, ptrdiff_t len, out size_t bytesRead, out size_t bytesWritten)
{
  char* _cretval;
  const(char)* _opsysstring = opsysstring.toCString(false);
  GError *_err;
  _cretval = g_filename_to_utf8(_opsysstring, len, cast(size_t*)&bytesRead, cast(size_t*)&bytesWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated
 * string with the absolute path, or %NULL
 */
string findProgramInPath(string program)
{
  char* _cretval;
  const(char)* _program = program.toCString(false);
  _cretval = g_find_program_in_path(_program);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated formatted string containing
 * a human readable file size
 */
string formatSize(ulong size)
{
  char* _cretval;
  _cretval = g_format_size(size);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated formatted string
 * containing a human readable file size
 */
string formatSizeForDisplay(long size)
{
  char* _cretval;
  _cretval = g_format_size_for_display(size);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated formatted string
 * containing a human readable file size
 */
string formatSizeFull(ulong size, FormatSizeFlags flags)
{
  char* _cretval;
  _cretval = g_format_size_full(size, flags);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Frees the memory pointed to by @mem.
 *
 * If you know the allocated size of @mem, calling g_free_sized() may be faster,
 * depending on the libc implementation in use.
 *
 * Starting from GLib 2.78, this may happen automatically in case a GCC
 * compatible compiler is used with some optimization level and the allocated
 * size is known at compile time (see [documentation of
 * `__builtin_object_size()`](https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html)
 * to understand its caveats).
 *
 * If @mem is %NULL it simply returns, so there is no need to check @mem
 * against %NULL before calling this function.
 */
void gfree(void* mem)
{
  g_free(mem);
}

/**
 * Frees the memory pointed to by @mem, assuming it is has the given @size.
 *
 * If @mem is %NULL this is a no-op (and @size is ignored).
 *
 * It is an error if @size doesn’t match the size passed when @mem was
 * allocated. @size is passed to this function to allow optimizations in the
 * allocator. If you don’t know the allocation size, use g_free() instead.
 *
 * In case a GCC compatible compiler is used, this function may be used
 * automatically via g_free() if the allocated size is known at compile time,
 * since GLib 2.78.
 */
void freeSized(void* mem, size_t size)
{
  g_free_sized(mem, size);
}

/**
 * human-readable application
 * name. May return %NULL
 */
string getApplicationName()
{
  const(char)* _cretval;
  _cretval = g_get_application_name();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if the returned charset is UTF-8
 */
bool getCharset(out string charset)
{
  bool _retval;
  char* _charset;
  _retval = g_get_charset(&_charset);
  charset = _charset.fromCString(false);
  return _retval;
}

/**
 * a newly allocated string containing the name
 * of the character set. This string must be freed with g_free().
 */
string getCodeset()
{
  char* _cretval;
  _cretval = g_get_codeset();
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if the returned charset is UTF-8
 */
bool getConsoleCharset(out string charset)
{
  bool _retval;
  char* _charset;
  _retval = g_get_console_charset(&_charset);
  charset = _charset.fromCString(false);
  return _retval;
}

/**
 * the current directory
 */
string getCurrentDir()
{
  char* _cretval;
  _cretval = g_get_current_dir();
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Equivalent to the UNIX gettimeofday() function, but portable.
 *
 * You may find g_get_real_time() to be more convenient.
 */
void getCurrentTime(TimeVal result)
{
  g_get_current_time(result ? result.cPtr!GTimeVal : null);
}

/**
 * the list of environment variables
 */
string[] getEnviron()
{
  char** _cretval;
  _cretval = g_get_environ();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * %TRUE if the filename encoding is UTF-8.
 */
bool getFilenameCharsets(out string[] filenameCharsets)
{
  bool _retval;
  const(char*)* _filenameCharsets;
  _retval = g_get_filename_charsets(&_filenameCharsets);
  uint _lenfilenameCharsets;
  if (_filenameCharsets)
  {
    for (; _filenameCharsets[_lenfilenameCharsets] != null; _lenfilenameCharsets++)
    {
    }
  }
  filenameCharsets.length = _lenfilenameCharsets;
  foreach (i; 0 .. _lenfilenameCharsets)
    filenameCharsets[i] = _filenameCharsets[i].fromCString(false);
  return _retval;
}

/**
 * the current user's home directory
 */
string getHomeDir()
{
  const(char)* _cretval;
  _cretval = g_get_home_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the host name of the machine.
 */
string getHostName()
{
  const(char)* _cretval;
  _cretval = g_get_host_name();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a %NULL-terminated array of strings owned by GLib
 * that must not be modified or freed.
 */
string[] getLanguageNames()
{
  const(char*)* _cretval;
  _cretval = g_get_language_names();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * a %NULL-terminated array of strings owned by
 * the thread g_get_language_names_with_category was called from.
 * It must not be modified or freed. It must be copied if planned to be used in another thread.
 */
string[] getLanguageNamesWithCategory(string categoryName)
{
  const(char*)* _cretval;
  const(char)* _categoryName = categoryName.toCString(false);
  _cretval = g_get_language_names_with_category(_categoryName);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * a newly
 * allocated array of newly allocated strings with the locale variants. Free with
 * g_strfreev().
 */
string[] getLocaleVariants(string locale)
{
  char** _cretval;
  const(char)* _locale = locale.toCString(false);
  _cretval = g_get_locale_variants(_locale);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * the monotonic time, in microseconds
 */
long getMonotonicTime()
{
  long _retval;
  _retval = g_get_monotonic_time();
  return _retval;
}

/**
 * Number of schedulable threads, always greater than 0
 */
uint getNumProcessors()
{
  uint _retval;
  _retval = g_get_num_processors();
  return _retval;
}

/**
 * The associated value for the requested key or %NULL if
 * this information is not provided.
 */
string getOsInfo(string keyName)
{
  char* _cretval;
  const(char)* _keyName = keyName.toCString(false);
  _cretval = g_get_os_info(_keyName);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the name of the program,
 * or %NULL if it has not been set yet. The returned string belongs
 * to GLib and must not be modified or freed.
 */
string getPrgname()
{
  const(char)* _cretval;
  _cretval = g_get_prgname();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the user's real name.
 */
string getRealName()
{
  const(char)* _cretval;
  _cretval = g_get_real_name();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the number of microseconds since January 1, 1970 UTC.
 */
long getRealTime()
{
  long _retval;
  _retval = g_get_real_time();
  return _retval;
}

/**
 * a %NULL-terminated array of strings owned by GLib that must not be
 * modified or freed.
 */
string[] getSystemConfigDirs()
{
  const(char*)* _cretval;
  _cretval = g_get_system_config_dirs();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * a %NULL-terminated array of strings owned by GLib that must not be
 * modified or freed.
 */
string[] getSystemDataDirs()
{
  const(char*)* _cretval;
  _cretval = g_get_system_data_dirs();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * the directory to use for temporary files.
 */
string getTmpDir()
{
  const(char)* _cretval;
  _cretval = g_get_tmp_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string owned by GLib that
 * must not be modified or freed.
 */
string getUserCacheDir()
{
  const(char)* _cretval;
  _cretval = g_get_user_cache_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string owned by GLib that
 * must not be modified or freed.
 */
string getUserConfigDir()
{
  const(char)* _cretval;
  _cretval = g_get_user_config_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string owned by GLib that must
 * not be modified or freed.
 */
string getUserDataDir()
{
  const(char)* _cretval;
  _cretval = g_get_user_data_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the user name of the current user.
 */
string getUserName()
{
  const(char)* _cretval;
  _cretval = g_get_user_name();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string owned by GLib that must not be
 * modified or freed.
 */
string getUserRuntimeDir()
{
  const(char)* _cretval;
  _cretval = g_get_user_runtime_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the path to the specified special
 * directory, or %NULL if the logical id was not found. The returned string is
 * owned by GLib and should not be modified or freed.
 */
string getUserSpecialDir(UserDirectory directory)
{
  const(char)* _cretval;
  _cretval = g_get_user_special_dir(directory);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string owned by GLib that
 * must not be modified or freed.
 */
string getUserStateDir()
{
  const(char)* _cretval;
  _cretval = g_get_user_state_dir();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the value of the environment variable, or %NULL if
 * the environment variable is not found. The returned string
 * may be overwritten by the next call to g_getenv(), g_setenv()
 * or g_unsetenv().
 */
string getenv(string variable)
{
  const(char)* _cretval;
  const(char)* _variable = variable.toCString(false);
  _cretval = g_getenv(_variable);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if @hostname contains any ASCII-encoded
 * segments.
 */
bool hostnameIsAsciiEncoded(string hostname)
{
  bool _retval;
  const(char)* _hostname = hostname.toCString(false);
  _retval = g_hostname_is_ascii_encoded(_hostname);
  return _retval;
}

/**
 * %TRUE if @hostname is an IP address
 */
bool hostnameIsIpAddress(string hostname)
{
  bool _retval;
  const(char)* _hostname = hostname.toCString(false);
  _retval = g_hostname_is_ip_address(_hostname);
  return _retval;
}

/**
 * %TRUE if @hostname contains any non-ASCII characters
 */
bool hostnameIsNonAscii(string hostname)
{
  bool _retval;
  const(char)* _hostname = hostname.toCString(false);
  _retval = g_hostname_is_non_ascii(_hostname);
  return _retval;
}

/**
 * an ASCII hostname, which must be freed,
 * or %NULL if @hostname is in some way invalid.
 */
string hostnameToAscii(string hostname)
{
  char* _cretval;
  const(char)* _hostname = hostname.toCString(false);
  _cretval = g_hostname_to_ascii(_hostname);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a UTF-8 hostname, which must be freed,
 * or %NULL if @hostname is in some way invalid.
 */
string hostnameToUnicode(string hostname)
{
  char* _cretval;
  const(char)* _hostname = hostname.toCString(false);
  _cretval = g_hostname_to_unicode(_hostname);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the ID (greater than 0) of the event source.
 */
uint idleAdd(int priority, SourceFunc function_)
{
  extern(C) bool _function_Callback(void* userData)
  {
    bool _retval = (*(cast(SourceFunc*)userData))();
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&function_);
  _retval = g_idle_add_full(priority, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * %TRUE if an idle source was found and removed.
 */
bool idleRemoveByData(void* data)
{
  bool _retval;
  _retval = g_idle_remove_by_data(data);
  return _retval;
}

/**
 * the newly-created idle source
 */
Source idleSourceNew()
{
  GSource* _cretval;
  _cretval = g_idle_source_new();
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * %TRUE if the two keys match.
 */
bool int64Equal(const(void)* v1, const(void)* v2)
{
  bool _retval;
  _retval = g_int64_equal(v1, v2);
  return _retval;
}

/**
 * a hash value corresponding to the key.
 */
uint int64Hash(const(void)* v)
{
  uint _retval;
  _retval = g_int64_hash(v);
  return _retval;
}

/**
 * %TRUE if the two keys match.
 */
bool intEqual(const(void)* v1, const(void)* v2)
{
  bool _retval;
  _retval = g_int_equal(v1, v2);
  return _retval;
}

/**
 * a hash value corresponding to the key.
 */
uint intHash(const(void)* v)
{
  uint _retval;
  _retval = g_int_hash(v);
  return _retval;
}

/**
 * a canonical representation for the string
 */
string internStaticString(string string_)
{
  const(char)* _cretval;
  const(char)* _string_ = string_.toCString(false);
  _cretval = g_intern_static_string(_string_);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a canonical representation for the string
 */
string internString(string string_)
{
  const(char)* _cretval;
  const(char)* _string_ = string_.toCString(false);
  _cretval = g_intern_string(_string_);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the event source id
 */
uint ioAddWatch(IOChannel channel, int priority, IOCondition condition, IOFunc func)
{
  extern(C) bool _funcCallback(GIOChannel* source, GIOCondition condition, void* data)
  {
    bool _retval = (*(cast(IOFunc*)data))(source ? new IOChannel(source, false) : null, condition);
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&func);
  _retval = g_io_add_watch_full(channel ? channel.cPtr!GIOChannel : null, priority, condition, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * a new #GSource
 */
Source ioCreateWatch(IOChannel channel, IOCondition condition)
{
  GSource* _cretval;
  _cretval = g_io_create_watch(channel ? channel.cPtr!GIOChannel : null, condition);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * a %NULL-terminated list of strings which must be freed with
 * g_strfreev().
 */
string[] listenv()
{
  char** _cretval;
  _cretval = g_listenv();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * A newly-allocated buffer containing the converted string,
 * or %NULL on an error, and error will be set.
 */
ubyte[] localeFromUtf8(string utf8string, ptrdiff_t len, out size_t bytesRead)
{
  ubyte* _cretval;
  size_t _cretlength;
  const(char)* _utf8string = utf8string.toCString(false);
  GError *_err;
  _cretval = g_locale_from_utf8(_utf8string, len, cast(size_t*)&bytesRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  ubyte[] _retval;

  if (_cretval)
  {
    _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * The converted string, or %NULL on an error.
 */
string localeToUtf8(ubyte[] opsysstring, out size_t bytesRead, out size_t bytesWritten)
{
  char* _cretval;
  auto _opsysstring = cast(const(ubyte)*)opsysstring.ptr;
  GError *_err;
  _cretval = g_locale_to_utf8(_opsysstring, opsysstring ? cast(ptrdiff_t)opsysstring.length : 0, cast(size_t*)&bytesRead, cast(size_t*)&bytesWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * The default log handler set up by GLib; g_log_set_default_handler()
 * allows to install an alternate default log handler.
 * This is used if no log handler has been set for the particular log
 * domain and log level combination. It outputs the message to stderr
 * or stdout and if the log level is fatal it calls G_BREAKPOINT(). It automatically
 * prints a new-line character after the message, so one does not need to be
 * manually included in @message.
 *
 * The behavior of this log handler can be influenced by a number of
 * environment variables:
 *
 * - `G_MESSAGES_PREFIXED`: A :-separated list of log levels for which
 * messages should be prefixed by the program name and PID of the
 * application.
 *
 * - `G_MESSAGES_DEBUG`: A space-separated list of log domains for
 * which debug and informational messages are printed. By default
 * these messages are not printed.
 *
 * stderr is used for levels %G_LOG_LEVEL_ERROR, %G_LOG_LEVEL_CRITICAL,
 * %G_LOG_LEVEL_WARNING and %G_LOG_LEVEL_MESSAGE. stdout is used for
 * the rest, unless stderr was requested by
 * g_log_writer_default_set_use_stderr().
 *
 * This has no effect if structured logging is enabled; see
 * [Using Structured Logging][using-structured-logging].
 */
void logDefaultHandler(string logDomain, LogLevelFlags logLevel, string message, void* unusedData)
{
  const(char)* _logDomain = logDomain.toCString(false);
  const(char)* _message = message.toCString(false);
  g_log_default_handler(_logDomain, logLevel, _message, unusedData);
}

/**
 * %TRUE if debug output is enabled, %FALSE otherwise
 */
bool logGetDebugEnabled()
{
  bool _retval;
  _retval = g_log_get_debug_enabled();
  return _retval;
}

/**
 * Removes the log handler.
 *
 * This has no effect if structured logging is enabled; see
 * [Using Structured Logging][using-structured-logging].
 */
void logRemoveHandler(string logDomain, uint handlerId)
{
  const(char)* _logDomain = logDomain.toCString(false);
  g_log_remove_handler(_logDomain, handlerId);
}

/**
 * the old fatal mask
 */
LogLevelFlags logSetAlwaysFatal(LogLevelFlags fatalMask)
{
  GLogLevelFlags _cretval;
  _cretval = g_log_set_always_fatal(fatalMask);
  LogLevelFlags _retval = cast(LogLevelFlags)_cretval;
  return _retval;
}

/**
 * Enable or disable debug output from the GLib logging system for all domains.
 * This value interacts disjunctively with `G_MESSAGES_DEBUG` — if either of
 * them would allow a debug message to be outputted, it will be.
 *
 * Note that this should not be used from within library code to enable debug
 * output — it is intended for external use.
 */
void logSetDebugEnabled(bool enabled)
{
  g_log_set_debug_enabled(enabled);
}

/**
 * the old fatal mask for the log domain
 */
LogLevelFlags logSetFatalMask(string logDomain, LogLevelFlags fatalMask)
{
  GLogLevelFlags _cretval;
  const(char)* _logDomain = logDomain.toCString(false);
  _cretval = g_log_set_fatal_mask(_logDomain, fatalMask);
  LogLevelFlags _retval = cast(LogLevelFlags)_cretval;
  return _retval;
}

/**
 * the id of the new handler
 */
uint logSetHandler(string logDomain, LogLevelFlags logLevels, LogFunc logFunc)
{
  extern(C) void _logFuncCallback(const(char)* logDomain, GLogLevelFlags logLevel, const(char)* message, void* userData)
  {
    string _logDomain = logDomain.fromCString(false);
    string _message = message.fromCString(false);

    (*(cast(LogFunc*)userData))(_logDomain, logLevel, _message);
  }

  uint _retval;
  const(char)* _logDomain = logDomain.toCString(false);
  ptrFreezeGC(cast(void*)&logFunc);
  _retval = g_log_set_handler_full(_logDomain, logLevels, &_logFuncCallback, cast(void*)&logFunc, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * Set a writer function which will be called to format and write out each log
 * message. Each program should set a writer function, or the default writer
 * (g_log_writer_default()) will be used.
 *
 * Libraries **must not** call this function — only programs are allowed to
 * install a writer function, as there must be a single, central point where
 * log messages are formatted and outputted.
 *
 * There can only be one writer function. It is an error to set more than one.
 */
void logSetWriterFunc(LogWriterFunc func)
{
  extern(C) GLogWriterOutput _funcCallback(GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData)
  {
    LogWriterOutput _dretval;
    LogField[] _fields;
    foreach (i; 0 .. nFields)
      _fields ~= new LogField(cast(GLogField*)&fields[i], false);

    _dretval = (*(cast(LogWriterFunc*)userData))(logLevel, _fields);
    GLogWriterOutput _retval = cast(GLogWriterOutput)_dretval;

    return _retval;
  }

  ptrFreezeGC(cast(void*)&func);
  g_log_set_writer_func(&_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
}

/**
 * Log a message with structured data. The message will be passed through to the
 * log writer set by the application using g_log_set_writer_func(). If the
 * message is fatal (i.e. its log level is %G_LOG_LEVEL_ERROR), the program will
 * be aborted at the end of this function.
 *
 * See g_log_structured() for more documentation.
 *
 * This assumes that @log_level is already present in @fields (typically as the
 * `PRIORITY` field).
 */
void logStructuredArray(LogLevelFlags logLevel, LogField[] fields)
{
  GLogField[] _tmpfields;
  foreach (obj; fields)
    _tmpfields ~= obj.cInstance;
  const(GLogField)* _fields = _tmpfields.ptr;
  g_log_structured_array(logLevel, _fields, fields ? cast(size_t)fields.length : 0);
}

/**
 * Log a message with structured data, accepting the data within a #GVariant. This
 * version is especially useful for use in other languages, via introspection.
 *
 * The only mandatory item in the @fields dictionary is the "MESSAGE" which must
 * contain the text shown to the user.
 *
 * The values in the @fields dictionary are likely to be of type String
 * (%G_VARIANT_TYPE_STRING). Array of bytes (%G_VARIANT_TYPE_BYTESTRING) is also
 * supported. In this case the message is handled as binary and will be forwarded
 * to the log writer as such. The size of the array should not be higher than
 * %G_MAXSSIZE. Otherwise it will be truncated to this size. For other types
 * g_variant_print() will be used to convert the value into a string.
 *
 * For more details on its usage and about the parameters, see g_log_structured().
 */
void logVariant(string logDomain, LogLevelFlags logLevel, Variant fields)
{
  const(char)* _logDomain = logDomain.toCString(false);
  g_log_variant(_logDomain, logLevel, fields ? fields.cPtr!GVariant : null);
}

/**
 * %G_LOG_WRITER_HANDLED on success, %G_LOG_WRITER_UNHANDLED otherwise
 */
LogWriterOutput logWriterDefault(LogLevelFlags logLevel, LogField[] fields, void* userData)
{
  GLogWriterOutput _cretval;
  GLogField[] _tmpfields;
  foreach (obj; fields)
    _tmpfields ~= obj.cInstance;
  const(GLogField)* _fields = _tmpfields.ptr;
  _cretval = g_log_writer_default(logLevel, _fields, fields ? cast(size_t)fields.length : 0, userData);
  LogWriterOutput _retval = cast(LogWriterOutput)_cretval;
  return _retval;
}

/**
 * Configure whether the built-in log functions
 * (g_log_default_handler() for the old-style API, and both
 * g_log_writer_default() and g_log_writer_standard_streams() for the
 * structured API) will output all log messages to `stderr`.
 *
 * By default, log messages of levels %G_LOG_LEVEL_INFO and
 * %G_LOG_LEVEL_DEBUG are sent to `stdout`, and other log messages are
 * sent to `stderr`. This is problematic for applications that intend
 * to reserve `stdout` for structured output such as JSON or XML.
 *
 * This function sets global state. It is not thread-aware, and should be
 * called at the very start of a program, before creating any other threads
 * or creating objects that could create worker threads of their own.
 */
void logWriterDefaultSetUseStderr(bool useStderr)
{
  g_log_writer_default_set_use_stderr(useStderr);
}

/**
 * %TRUE if the log message would be dropped by GLib's
 * default log handlers
 */
bool logWriterDefaultWouldDrop(LogLevelFlags logLevel, string logDomain)
{
  bool _retval;
  const(char)* _logDomain = logDomain.toCString(false);
  _retval = g_log_writer_default_would_drop(logLevel, _logDomain);
  return _retval;
}

/**
 * string containing the formatted log message, in
 * the character set of the current locale
 */
string logWriterFormatFields(LogLevelFlags logLevel, LogField[] fields, bool useColor)
{
  char* _cretval;
  GLogField[] _tmpfields;
  foreach (obj; fields)
    _tmpfields ~= obj.cInstance;
  const(GLogField)* _fields = _tmpfields.ptr;
  _cretval = g_log_writer_format_fields(logLevel, _fields, fields ? cast(size_t)fields.length : 0, useColor);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if @output_fd points to the journal, %FALSE otherwise
 */
bool logWriterIsJournald(int outputFd)
{
  bool _retval;
  _retval = g_log_writer_is_journald(outputFd);
  return _retval;
}

/**
 * %G_LOG_WRITER_HANDLED on success, %G_LOG_WRITER_UNHANDLED otherwise
 */
LogWriterOutput logWriterJournald(LogLevelFlags logLevel, LogField[] fields, void* userData)
{
  GLogWriterOutput _cretval;
  GLogField[] _tmpfields;
  foreach (obj; fields)
    _tmpfields ~= obj.cInstance;
  const(GLogField)* _fields = _tmpfields.ptr;
  _cretval = g_log_writer_journald(logLevel, _fields, fields ? cast(size_t)fields.length : 0, userData);
  LogWriterOutput _retval = cast(LogWriterOutput)_cretval;
  return _retval;
}

/**
 * %G_LOG_WRITER_HANDLED on success, %G_LOG_WRITER_UNHANDLED otherwise
 */
LogWriterOutput logWriterStandardStreams(LogLevelFlags logLevel, LogField[] fields, void* userData)
{
  GLogWriterOutput _cretval;
  GLogField[] _tmpfields;
  foreach (obj; fields)
    _tmpfields ~= obj.cInstance;
  const(GLogField)* _fields = _tmpfields.ptr;
  _cretval = g_log_writer_standard_streams(logLevel, _fields, fields ? cast(size_t)fields.length : 0, userData);
  LogWriterOutput _retval = cast(LogWriterOutput)_cretval;
  return _retval;
}

/**
 * %TRUE if ANSI color escapes are supported, %FALSE otherwise
 */
bool logWriterSupportsColor(int outputFd)
{
  bool _retval;
  _retval = g_log_writer_supports_color(outputFd);
  return _retval;
}

/**
 * The currently firing source or %NULL.
 */
Source mainCurrentSource()
{
  GSource* _cretval;
  _cretval = g_main_current_source();
  Source _retval = new Source(cast(GSource*)_cretval, false);
  return _retval;
}

/**
 * The main loop recursion level in the current thread
 */
int mainDepth()
{
  int _retval;
  _retval = g_main_depth();
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* gmalloc(size_t nBytes)
{
  void* _retval;
  _retval = g_malloc(nBytes);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* malloc0(size_t nBytes)
{
  void* _retval;
  _retval = g_malloc0(nBytes);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* malloc0N(size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_malloc0_n(nBlocks, nBlockBytes);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* mallocN(size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_malloc_n(nBlocks, nBlockBytes);
  return _retval;
}

Quark markupErrorQuark()
{
  Quark _retval;
  _retval = g_markup_error_quark();
  return _retval;
}

/**
 * a newly allocated string with the escaped text
 */
string markupEscapeText(string text, ptrdiff_t length)
{
  char* _cretval;
  const(char)* _text = text.toCString(false);
  _cretval = g_markup_escape_text(_text, length);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * if %TRUE, malloc() and g_malloc() can be mixed.
 */
bool memIsSystemMalloc()
{
  bool _retval;
  _retval = g_mem_is_system_malloc();
  return _retval;
}

/**
 * GLib used to support some tools for memory profiling, but this
 * no longer works. There are many other useful tools for memory
 * profiling these days which can be used instead.
 */
void memProfile()
{
  g_mem_profile();
}

/**
 * This function used to let you override the memory allocation function.
 * However, its use was incompatible with the use of global constructors
 * in GLib and GIO, because those use the GLib allocators before main is
 * reached. Therefore this function is now deprecated and is just a stub.
 */
void memSetVtable(MemVTable vtable)
{
  g_mem_set_vtable(&vtable);
}

/**
 * a pointer to the newly-allocated copy of the memory, or %NULL if @mem
 * is %NULL.
 */
void* memdup(const(void)* mem, uint byteSize)
{
  void* _retval;
  _retval = g_memdup(mem, byteSize);
  return _retval;
}

/**
 * a pointer to the newly-allocated copy of the memory,
 * or %NULL if @mem is %NULL.
 */
void* memdup2(const(void)* mem, size_t byteSize)
{
  void* _retval;
  _retval = g_memdup2(mem, byteSize);
  return _retval;
}

/**
 * 0 if the directory already exists, or was successfully
 * created. Returns -1 if an error occurred, with errno set.
 */
int mkdirWithParents(string pathname, int mode)
{
  int _retval;
  const(char)* _pathname = pathname.toCString(false);
  _retval = g_mkdir_with_parents(_pathname, mode);
  return _retval;
}

/**
 * Set the pointer at the specified location to %NULL.
 */
void nullifyPointer(out void* nullifyLocation)
{
  g_nullify_pointer(cast(void**)&nullifyLocation);
}

Quark numberParserErrorQuark()
{
  Quark _retval;
  _retval = g_number_parser_error_quark();
  return _retval;
}

/**
 * Prompts the user with
 * `[E]xit, [H]alt, show [S]tack trace or [P]roceed`.
 * This function is intended to be used for debugging use only.
 * The following example shows how it can be used together with
 * the g_log() functions.
 *
 * |[<!-- language="C" -->
 * #include <glib.h>
 *
 * static void
 * log_handler (const gchar   *log_domain,
 * GLogLevelFlags log_level,
 * const gchar   *message,
 * gpointer       user_data)
 * {
 * g_log_default_handler (log_domain, log_level, message, user_data);
 *
 * g_on_error_query (MY_PROGRAM_NAME);
 * }
 *
 * int
 * main (int argc, char *argv[])
 * {
 * g_log_set_handler (MY_LOG_DOMAIN,
 * G_LOG_LEVEL_WARNING |
 * G_LOG_LEVEL_ERROR |
 * G_LOG_LEVEL_CRITICAL,
 * log_handler,
 * NULL);
 * ...
 * ]|
 *
 * If "[E]xit" is selected, the application terminates with a call
 * to _exit(0).
 *
 * If "[S]tack" trace is selected, g_on_error_stack_trace() is called.
 * This invokes gdb, which attaches to the current process and shows
 * a stack trace. The prompt is then shown again.
 *
 * If "[P]roceed" is selected, the function returns.
 *
 * This function may cause different actions on non-UNIX platforms.
 *
 * On Windows consider using the `G_DEBUGGER` environment
 * variable (see [Running GLib Applications](glib-running.html)) and
 * calling g_on_error_stack_trace() instead.
 */
void onErrorQuery(string prgName)
{
  const(char)* _prgName = prgName.toCString(false);
  g_on_error_query(_prgName);
}

/**
 * Invokes gdb, which attaches to the current process and shows a
 * stack trace. Called by g_on_error_query() when the "[S]tack trace"
 * option is selected. You can get the current process's program name
 * with g_get_prgname(), assuming that you have called gtk_init() or
 * gdk_init().
 *
 * This function may cause different actions on non-UNIX platforms.
 *
 * When running on Windows, this function is *not* called by
 * g_on_error_query(). If called directly, it will raise an
 * exception, which will crash the program. If the `G_DEBUGGER` environment
 * variable is set, a debugger will be invoked to attach and
 * handle that exception (see [Running GLib Applications](glib-running.html)).
 */
void onErrorStackTrace(string prgName)
{
  const(char)* _prgName = prgName.toCString(false);
  g_on_error_stack_trace(_prgName);
}

Quark optionErrorQuark()
{
  Quark _retval;
  _retval = g_option_error_quark();
  return _retval;
}

/**
 * the combined set of bit flags.
 */
uint parseDebugString(string string_, DebugKey[] keys)
{
  uint _retval;
  const(char)* _string_ = string_.toCString(false);
  GDebugKey[] _tmpkeys;
  foreach (obj; keys)
    _tmpkeys ~= obj.cInstance;
  const(GDebugKey)* _keys = _tmpkeys.ptr;
  _retval = g_parse_debug_string(_string_, _keys, keys ? cast(uint)keys.length : 0);
  return _retval;
}

/**
 * a newly allocated string
 * containing the last component of the filename
 */
string pathGetBasename(string fileName)
{
  char* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = g_path_get_basename(_fileName);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the directory components of the file
 */
string pathGetDirname(string fileName)
{
  char* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = g_path_get_dirname(_fileName);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if @file_name is absolute
 */
bool pathIsAbsolute(string fileName)
{
  bool _retval;
  const(char)* _fileName = fileName.toCString(false);
  _retval = g_path_is_absolute(_fileName);
  return _retval;
}

/**
 * a pointer into @file_name after the
 * root component
 */
string pathSkipRoot(string fileName)
{
  const(char)* _cretval;
  const(char)* _fileName = fileName.toCString(false);
  _cretval = g_path_skip_root(_fileName);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if @string matches @pspec
 */
bool patternMatchSimple(string pattern, string string_)
{
  bool _retval;
  const(char)* _pattern = pattern.toCString(false);
  const(char)* _string_ = string_.toCString(false);
  _retval = g_pattern_match_simple(_pattern, _string_);
  return _retval;
}

/**
 * This is equivalent to g_bit_lock, but working on pointers (or other
 * pointer-sized values).
 *
 * For portability reasons, you may only lock on the bottom 32 bits of
 * the pointer.
 *
 * While @address has a `volatile` qualifier, this is a historical
 * artifact and the argument passed to it should not be `volatile`.
 */
void pointerBitLock(void* address, int lockBit)
{
  g_pointer_bit_lock(address, lockBit);
}

/**
 * %TRUE if the lock was acquired
 */
bool pointerBitTrylock(void* address, int lockBit)
{
  bool _retval;
  _retval = g_pointer_bit_trylock(address, lockBit);
  return _retval;
}

/**
 * This is equivalent to g_bit_unlock, but working on pointers (or other
 * pointer-sized values).
 *
 * For portability reasons, you may only lock on the bottom 32 bits of
 * the pointer.
 *
 * While @address has a `volatile` qualifier, this is a historical
 * artifact and the argument passed to it should not be `volatile`.
 */
void pointerBitUnlock(void* address, int lockBit)
{
  g_pointer_bit_unlock(address, lockBit);
}

/**
 * the number of entries in @fds whose @revents fields
 * were filled in, or 0 if the operation timed out, or -1 on error or
 * if the call was interrupted.
 */
int poll(PollFD fds, uint nfds, int timeout)
{
  int _retval;
  _retval = g_poll(&fds, nfds, timeout);
  return _retval;
}

/**
 * If @dest is %NULL, free @src; otherwise, moves @src into *@dest.
 * The error variable @dest points to must be %NULL.
 *
 * @src must be non-%NULL.
 *
 * Note that @src is no longer valid after this call. If you want
 * to keep using the same GError*, you need to set it to %NULL
 * after calling this function on it.
 */
void propagateError(out ErrorG dest, ErrorG src)
{
  GError* _dest;
  g_propagate_error(&_dest, src ? src.cPtr!GError : null);
  dest = new ErrorG(cast(void*)_dest, true);
}

/**
 * the #GQuark identifying the string, or 0 if @string is %NULL
 */
Quark quarkFromStaticString(string string_)
{
  Quark _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_quark_from_static_string(_string_);
  return _retval;
}

/**
 * the #GQuark identifying the string, or 0 if @string is %NULL
 */
Quark quarkFromString(string string_)
{
  Quark _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_quark_from_string(_string_);
  return _retval;
}

/**
 * the string associated with the #GQuark
 */
string quarkToString(Quark quark)
{
  const(char)* _cretval;
  _cretval = g_quark_to_string(quark);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the #GQuark associated with the string, or 0 if @string is
 * %NULL or there is no #GQuark associated with it
 */
Quark quarkTryString(string string_)
{
  Quark _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_quark_try_string(_string_);
  return _retval;
}

/**
 * a random number
 */
double randomDouble()
{
  double _retval;
  _retval = g_random_double();
  return _retval;
}

/**
 * a random number
 */
double randomDoubleRange(double begin, double end)
{
  double _retval;
  _retval = g_random_double_range(begin, end);
  return _retval;
}

/**
 * a random number
 */
uint randomInt()
{
  uint _retval;
  _retval = g_random_int();
  return _retval;
}

/**
 * a random number
 */
int randomIntRange(int begin, int end)
{
  int _retval;
  _retval = g_random_int_range(begin, end);
  return _retval;
}

/**
 * Sets the seed for the global random number generator, which is used
 * by the g_random_* functions, to @seed.
 */
void randomSetSeed(uint seed)
{
  g_random_set_seed(seed);
}

/**
 * a pointer to the data,
 * with its reference count increased
 */
void* rcBoxAcquire(void* memBlock)
{
  void* _retval;
  _retval = g_rc_box_acquire(memBlock);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* rcBoxAlloc(size_t blockSize)
{
  void* _retval;
  _retval = g_rc_box_alloc(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated memory
 */
void* rcBoxAlloc0(size_t blockSize)
{
  void* _retval;
  _retval = g_rc_box_alloc0(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated
 * memory
 */
void* rcBoxDup(size_t blockSize, const(void)* memBlock)
{
  void* _retval;
  _retval = g_rc_box_dup(blockSize, memBlock);
  return _retval;
}

/**
 * the size of the data, in bytes
 */
size_t rcBoxGetSize(void* memBlock)
{
  size_t _retval;
  _retval = g_rc_box_get_size(memBlock);
  return _retval;
}

/**
 * Releases a reference on the data pointed by @mem_block.
 *
 * If the reference was the last one, it will free the
 * resources allocated for @mem_block.
 */
void rcBoxRelease(void* memBlock)
{
  g_rc_box_release(memBlock);
}

/**
 * Releases a reference on the data pointed by @mem_block.
 *
 * If the reference was the last one, it will call @clear_func
 * to clear the contents of @mem_block, and then will free the
 * resources allocated for @mem_block.
 */
void rcBoxReleaseFull(void* memBlock, DestroyNotify clearFunc)
{
  static DestroyNotify _static_clearFunc;

  extern(C) void _clearFuncCallback(void* data)
  {
    _static_clearFunc();
  }

  _static_clearFunc = clearFunc;
  g_rc_box_release_full(memBlock, &_clearFuncCallback);
  _static_clearFunc = null;
}

/**
 * the new address of the allocated memory
 */
void* realloc(void* mem, size_t nBytes)
{
  void* _retval;
  _retval = g_realloc(mem, nBytes);
  return _retval;
}

/**
 * the new address of the allocated memory
 */
void* reallocN(void* mem, size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_realloc_n(mem, nBlocks, nBlockBytes);
  return _retval;
}

/**
 * %TRUE if the reference count is the same
 * as the given value
 */
bool refCountCompare(inout int rc, int val)
{
  bool _retval;
  _retval = g_ref_count_compare(cast(int*)&rc, val);
  return _retval;
}

/**
 * %TRUE if the reference count reached 0, and %FALSE otherwise
 */
bool refCountDec(inout int rc)
{
  bool _retval;
  _retval = g_ref_count_dec(cast(int*)&rc);
  return _retval;
}

/**
 * Increases the reference count.
 */
void refCountInc(inout int rc)
{
  g_ref_count_inc(cast(int*)&rc);
}

/**
 * Initializes a reference count variable to 1.
 */
void refCountInit(inout int rc)
{
  g_ref_count_init(cast(int*)&rc);
}

/**
 * the given string, with its reference count increased
 */
string refStringAcquire(string str)
{
  char* _cretval;
  char* _str = str.toCString(false);
  _cretval = g_ref_string_acquire(_str);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the length of the given string, in bytes
 */
size_t refStringLength(string str)
{
  size_t _retval;
  char* _str = str.toCString(false);
  _retval = g_ref_string_length(_str);
  return _retval;
}

/**
 * the newly created reference counted string
 */
string refStringNew(string str)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_ref_string_new(_str);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the newly created reference
 * counted string, or a new reference to an existing string
 */
string refStringNewIntern(string str)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_ref_string_new_intern(_str);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the newly created reference counted string
 */
string refStringNewLen(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_ref_string_new_len(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Releases a reference on a string; if it was the last reference, the
 * resources allocated by the string are freed as well.
 */
void refStringRelease(string str)
{
  char* _str = str.toCString(false);
  g_ref_string_release(_str);
}

/**
 * Resets the cache used for g_get_user_special_dir(), so
 * that the latest on-disk version is used. Call this only
 * if you just changed the data on disk yourself.
 *
 * Due to thread safety issues this may cause leaking of strings
 * that were previously returned from g_get_user_special_dir()
 * that can't be freed. We ensure to only leak the data for
 * the directories that actually changed value though.
 */
void reloadUserSpecialDirsCache()
{
  g_reload_user_special_dirs_cache();
}

/**
 * 0 if the directory was successfully removed, -1 if an error
 * occurred
 */
int rmdir(string filename)
{
  int _retval;
  const(char)* _filename = filename.toCString(false);
  _retval = g_rmdir(_filename);
  return _retval;
}

/**
 * Sets a human-readable name for the application. This name should be
 * localized if possible, and is intended for display to the user.
 * Contrast with g_set_prgname(), which sets a non-localized name.
 * g_set_prgname() will be called automatically by gtk_init(),
 * but g_set_application_name() will not.
 *
 * Note that for thread safety reasons, this function can only
 * be called once.
 *
 * The application name will be used in contexts such as error messages,
 * or when displaying an application's name in the task list.
 */
void setApplicationName(string applicationName)
{
  const(char)* _applicationName = applicationName.toCString(false);
  g_set_application_name(_applicationName);
}

/**
 * Does nothing if @err is %NULL; if @err is non-%NULL, then *@err
 * must be %NULL. A new #GError is created and assigned to *@err.
 * Unlike g_set_error(), @message is not a printf()-style format string.
 * Use this function if @message contains text you don't have control over,
 * that could include printf() escape sequences.
 */
void setErrorLiteral(out ErrorG err, Quark domain, int code, string message)
{
  GError* _err;
  const(char)* _message = message.toCString(false);
  g_set_error_literal(&_err, domain, code, _message);
  err = new ErrorG(cast(void*)_err, true);
}

/**
 * Sets the name of the program. This name should not be localized,
 * in contrast to g_set_application_name().
 *
 * If you are using #GApplication the program name is set in
 * g_application_run(). In case of GDK or GTK it is set in
 * gdk_init(), which is called by gtk_init() and the
 * #GtkApplication::startup handler. The program name is found by
 * taking the last component of @argv[0].
 *
 * Since GLib 2.72, this function can be called multiple times
 * and is fully thread safe. Prior to GLib 2.72, this function
 * could only be called once per process.
 */
void setPrgname(string prgname)
{
  const(char)* _prgname = prgname.toCString(false);
  g_set_prgname(_prgname);
}

/**
 * %FALSE if the environment variable couldn't be set.
 */
bool setenv(string variable, string value, bool overwrite)
{
  bool _retval;
  const(char)* _variable = variable.toCString(false);
  const(char)* _value = value.toCString(false);
  _retval = g_setenv(_variable, _value, overwrite);
  return _retval;
}

Quark shellErrorQuark()
{
  Quark _retval;
  _retval = g_shell_error_quark();
  return _retval;
}

/**
 * %TRUE on success, %FALSE if error set
 */
bool shellParseArgv(string commandLine, out string[] argvp)
{
  bool _retval;
  const(char)* _commandLine = commandLine.toCString(false);
  int _argcp;
  char** _argvp;
  GError *_err;
  _retval = g_shell_parse_argv(_commandLine, &_argcp, &_argvp, &_err);
  if (_err)
    throw new ErrorG(_err);
  argvp.length = _argcp;
  foreach (i; 0 .. _argcp)
    argvp[i] = _argvp[i].fromCString(true);
  g_free(cast(void*)_argvp);
  return _retval;
}

/**
 * quoted string
 */
string shellQuote(string unquotedString)
{
  char* _cretval;
  const(char)* _unquotedString = unquotedString.toCString(false);
  _cretval = g_shell_quote(_unquotedString);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * an unquoted string
 */
string shellUnquote(string quotedString)
{
  char* _cretval;
  const(char)* _quotedString = quotedString.toCString(false);
  GError *_err;
  _cretval = g_shell_unquote(_quotedString, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a pointer to the allocated memory block, which will
 * be %NULL if and only if @mem_size is 0
 */
void* sliceAlloc(size_t blockSize)
{
  void* _retval;
  _retval = g_slice_alloc(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated block, which will be %NULL
 * if and only if @mem_size is 0
 */
void* sliceAlloc0(size_t blockSize)
{
  void* _retval;
  _retval = g_slice_alloc0(blockSize);
  return _retval;
}

/**
 * a pointer to the allocated memory block,
 * which will be %NULL if and only if @mem_size is 0
 */
void* sliceCopy(size_t blockSize, const(void)* memBlock)
{
  void* _retval;
  _retval = g_slice_copy(blockSize, memBlock);
  return _retval;
}

/**
 * Frees a block of memory.
 *
 * The memory must have been allocated via g_slice_alloc() or
 * g_slice_alloc0() and the @block_size has to match the size
 * specified upon allocation. Note that the exact release behaviour
 * can be changed with the [`G_DEBUG=gc-friendly`][G_DEBUG] environment
 * variable.
 *
 * If @mem_block is %NULL, this function does nothing.
 *
 * Since GLib 2.76 this always uses the system free_sized() implementation
 * internally.
 */
void sliceFree1(size_t blockSize, void* memBlock)
{
  g_slice_free1(blockSize, memBlock);
}

/**
 * Frees a linked list of memory blocks of structure type @type.
 *
 * The memory blocks must be equal-sized, allocated via
 * g_slice_alloc() or g_slice_alloc0() and linked together by a
 * @next pointer (similar to #GSList). The offset of the @next
 * field in each block is passed as third argument.
 * Note that the exact release behaviour can be changed with the
 * [`G_DEBUG=gc-friendly`][G_DEBUG] environment variable.
 *
 * If @mem_chain is %NULL, this function does nothing.
 *
 * Since GLib 2.76 this always uses the system free_sized() implementation
 * internally.
 */
void sliceFreeChainWithOffset(size_t blockSize, void* memChain, size_t nextOffset)
{
  g_slice_free_chain_with_offset(blockSize, memChain, nextOffset);
}

long sliceGetConfig(SliceConfig ckey)
{
  long _retval;
  _retval = g_slice_get_config(ckey);
  return _retval;
}

long[] sliceGetConfigState(SliceConfig ckey, long address)
{
  const(long)* _cretval;
  uint _cretlength;
  _cretval = g_slice_get_config_state(ckey, address, &_cretlength);
  long[] _retval;

  if (_cretval)
  {
    _retval = cast(long[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

void sliceSetConfig(SliceConfig ckey, long value)
{
  g_slice_set_config(ckey, value);
}

/**
 * the smallest prime number from a built-in array of primes
 * which is larger than @num
 */
uint spacedPrimesClosest(uint num)
{
  uint _retval;
  _retval = g_spaced_primes_closest(num);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if error is set
 */
bool spawnAsync(string workingDirectory, string[] argv, string[] envp, SpawnFlags flags, SpawnChildSetupFunc childSetup, out Pid childPid)
{
  extern(C) void _childSetupCallback(void* data)
  {
    ptrThawGC(data);

    (*(cast(SpawnChildSetupFunc*)data))();
  }

  bool _retval;
  const(char)* _workingDirectory = workingDirectory.toCString(false);
  char*[] _tmpargv;
  foreach (s; argv)
    _tmpargv ~= s.toCString(false);
  _tmpargv ~= null;
  char** _argv = _tmpargv.ptr;

  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  char** _envp = _tmpenvp.ptr;

  ptrFreezeGC(cast(void*)&childSetup);
  GError *_err;
  _retval = g_spawn_async(_workingDirectory, _argv, _envp, flags, &_childSetupCallback, cast(void*)&childSetup, cast(GPid*)&childPid, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error was set
 */
bool spawnAsyncWithFds(string workingDirectory, string[] argv, string[] envp, SpawnFlags flags, SpawnChildSetupFunc childSetup, out Pid childPid, int stdinFd, int stdoutFd, int stderrFd)
{
  extern(C) void _childSetupCallback(void* data)
  {
    ptrThawGC(data);

    (*(cast(SpawnChildSetupFunc*)data))();
  }

  bool _retval;
  const(char)* _workingDirectory = workingDirectory.toCString(false);
  char*[] _tmpargv;
  foreach (s; argv)
    _tmpargv ~= s.toCString(false);
  _tmpargv ~= null;
  char** _argv = _tmpargv.ptr;

  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  char** _envp = _tmpenvp.ptr;

  ptrFreezeGC(cast(void*)&childSetup);
  GError *_err;
  _retval = g_spawn_async_with_fds(_workingDirectory, _argv, _envp, flags, &_childSetupCallback, cast(void*)&childSetup, cast(GPid*)&childPid, stdinFd, stdoutFd, stderrFd, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error was set
 */
bool spawnAsyncWithPipes(string workingDirectory, string[] argv, string[] envp, SpawnFlags flags, SpawnChildSetupFunc childSetup, out Pid childPid, out int standardInput, out int standardOutput, out int standardError)
{
  extern(C) void _childSetupCallback(void* data)
  {
    ptrThawGC(data);

    (*(cast(SpawnChildSetupFunc*)data))();
  }

  bool _retval;
  const(char)* _workingDirectory = workingDirectory.toCString(false);
  char*[] _tmpargv;
  foreach (s; argv)
    _tmpargv ~= s.toCString(false);
  _tmpargv ~= null;
  char** _argv = _tmpargv.ptr;

  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  char** _envp = _tmpenvp.ptr;

  ptrFreezeGC(cast(void*)&childSetup);
  GError *_err;
  _retval = g_spawn_async_with_pipes(_workingDirectory, _argv, _envp, flags, &_childSetupCallback, cast(void*)&childSetup, cast(GPid*)&childPid, cast(int*)&standardInput, cast(int*)&standardOutput, cast(int*)&standardError, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error was set
 */
bool spawnAsyncWithPipesAndFds(string workingDirectory, string[] argv, string[] envp, SpawnFlags flags, SpawnChildSetupFunc childSetup, int stdinFd, int stdoutFd, int stderrFd, int[] sourceFds, int[] targetFds, out Pid childPidOut, out int stdinPipeOut, out int stdoutPipeOut, out int stderrPipeOut)
{
  extern(C) void _childSetupCallback(void* data)
  {
    ptrThawGC(data);

    (*(cast(SpawnChildSetupFunc*)data))();
  }

  bool _retval;
  const(char)* _workingDirectory = workingDirectory.toCString(false);
  char*[] _tmpargv;
  foreach (s; argv)
    _tmpargv ~= s.toCString(false);
  _tmpargv ~= null;
  const(char*)* _argv = _tmpargv.ptr;

  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  const(char*)* _envp = _tmpenvp.ptr;

  ptrFreezeGC(cast(void*)&childSetup);
  auto _sourceFds = cast(const(int)*)sourceFds.ptr;
  auto _targetFds = cast(const(int)*)targetFds.ptr;
  GError *_err;
  _retval = g_spawn_async_with_pipes_and_fds(_workingDirectory, _argv, _envp, flags, &_childSetupCallback, cast(void*)&childSetup, stdinFd, stdoutFd, stderrFd, _sourceFds, _targetFds, targetFds ? cast(size_t)targetFds.length : 0, cast(GPid*)&childPidOut, cast(int*)&stdinPipeOut, cast(int*)&stdoutPipeOut, cast(int*)&stderrPipeOut, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE if child exited successfully, %FALSE otherwise (and
 * @error will be set)
 */
bool spawnCheckExitStatus(int waitStatus)
{
  bool _retval;
  GError *_err;
  _retval = g_spawn_check_exit_status(waitStatus, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE if child exited successfully, %FALSE otherwise (and
 * @error will be set)
 */
bool spawnCheckWaitStatus(int waitStatus)
{
  bool _retval;
  GError *_err;
  _retval = g_spawn_check_wait_status(waitStatus, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * On some platforms, notably Windows, the #GPid type represents a resource
 * which must be closed to prevent resource leaking. g_spawn_close_pid()
 * is provided for this purpose. It should be used on all platforms, even
 * though it doesn't do anything under UNIX.
 */
void spawnClosePid(Pid pid)
{
  g_spawn_close_pid(pid);
}

/**
 * %TRUE on success, %FALSE if error is set
 */
bool spawnCommandLineAsync(string commandLine)
{
  bool _retval;
  const(char)* _commandLine = commandLine.toCString(false);
  GError *_err;
  _retval = g_spawn_command_line_async(_commandLine, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error was set
 */
bool spawnCommandLineSync(string commandLine, out string standardOutput, out string standardError, out int waitStatus)
{
  bool _retval;
  const(char)* _commandLine = commandLine.toCString(false);
  char* _standardOutput;
  char* _standardError;
  GError *_err;
  _retval = g_spawn_command_line_sync(_commandLine, &_standardOutput, &_standardError, cast(int*)&waitStatus, &_err);
  if (_err)
    throw new ErrorG(_err);
  standardOutput = _standardOutput.fromCString(true);
  standardError = _standardError.fromCString(true);
  return _retval;
}

Quark spawnErrorQuark()
{
  Quark _retval;
  _retval = g_spawn_error_quark();
  return _retval;
}

Quark spawnExitErrorQuark()
{
  Quark _retval;
  _retval = g_spawn_exit_error_quark();
  return _retval;
}

/**
 * %TRUE on success, %FALSE if an error was set
 */
bool spawnSync(string workingDirectory, string[] argv, string[] envp, SpawnFlags flags, SpawnChildSetupFunc childSetup, out string standardOutput, out string standardError, out int waitStatus)
{
  static SpawnChildSetupFunc _static_childSetup;

  extern(C) void _childSetupCallback(void* data)
  {
    _static_childSetup();
  }

  _static_childSetup = childSetup;
  bool _retval;
  const(char)* _workingDirectory = workingDirectory.toCString(false);
  char*[] _tmpargv;
  foreach (s; argv)
    _tmpargv ~= s.toCString(false);
  _tmpargv ~= null;
  char** _argv = _tmpargv.ptr;

  char*[] _tmpenvp;
  foreach (s; envp)
    _tmpenvp ~= s.toCString(false);
  _tmpenvp ~= null;
  char** _envp = _tmpenvp.ptr;

  ptrFreezeGC(cast(void*)&childSetup);
  char* _standardOutput;
  char* _standardError;
  GError *_err;
  _retval = g_spawn_sync(_workingDirectory, _argv, _envp, flags, &_childSetupCallback, cast(void*)&childSetup, &_standardOutput, &_standardError, cast(int*)&waitStatus, &_err);
  if (_err)
    throw new ErrorG(_err);
  _static_childSetup = null;
  standardOutput = _standardOutput.fromCString(true);
  standardError = _standardError.fromCString(true);
  return _retval;
}

/**
 * a pointer to the trailing nul byte in `dest`.
 */
string stpcpy(string dest, string src)
{
  char* _cretval;
  char* _dest = dest.toCString(false);
  const(char)* _src = src.toCString(false);
  _cretval = g_stpcpy(_dest, _src);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if the two keys match
 */
bool strEqual(const(void)* v1, const(void)* v2)
{
  bool _retval;
  _retval = g_str_equal(v1, v2);
  return _retval;
}

/**
 * %TRUE if @str begins with @prefix, %FALSE otherwise.
 */
bool strHasPrefix(string str, string prefix)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  const(char)* _prefix = prefix.toCString(false);
  _retval = g_str_has_prefix(_str, _prefix);
  return _retval;
}

/**
 * %TRUE if @str end with @suffix, %FALSE otherwise.
 */
bool strHasSuffix(string str, string suffix)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  const(char)* _suffix = suffix.toCString(false);
  _retval = g_str_has_suffix(_str, _suffix);
  return _retval;
}

/**
 * a hash value corresponding to the key
 */
uint strHash(const(void)* v)
{
  uint _retval;
  _retval = g_str_hash(v);
  return _retval;
}

/**
 * %TRUE if @str is ASCII
 */
bool strIsAscii(string str)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  _retval = g_str_is_ascii(_str);
  return _retval;
}

/**
 * %TRUE if @potential_hit is a hit
 */
bool strMatchString(string searchTerm, string potentialHit, bool acceptAlternates)
{
  bool _retval;
  const(char)* _searchTerm = searchTerm.toCString(false);
  const(char)* _potentialHit = potentialHit.toCString(false);
  _retval = g_str_match_string(_searchTerm, _potentialHit, acceptAlternates);
  return _retval;
}

/**
 * a string in plain ASCII
 */
string strToAscii(string str, string fromLocale)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  const(char)* _fromLocale = fromLocale.toCString(false);
  _cretval = g_str_to_ascii(_str, _fromLocale);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the folded tokens
 */
string[] strTokenizeAndFold(string string_, string translitLocale, out string[] asciiAlternates)
{
  char** _cretval;
  const(char)* _string_ = string_.toCString(false);
  const(char)* _translitLocale = translitLocale.toCString(false);
  char** _asciiAlternates;
  _cretval = g_str_tokenize_and_fold(_string_, _translitLocale, &_asciiAlternates);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  uint _lenasciiAlternates;
  if (_asciiAlternates)
  {
    for (; _asciiAlternates[_lenasciiAlternates] != null; _lenasciiAlternates++)
    {
    }
  }
  asciiAlternates.length = _lenasciiAlternates;
  foreach (i; 0 .. _lenasciiAlternates)
    asciiAlternates[i] = _asciiAlternates[i].fromCString(true);
  g_free(cast(void*)_asciiAlternates);
  return _retval;
}

/**
 * the modified @string
 */
string strcanon(string string_, string validChars, char substitutor)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  const(char)* _validChars = validChars.toCString(false);
  _cretval = g_strcanon(_string_, _validChars, substitutor);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * 0 if the strings match, a negative value if @s1 < @s2,
 * or a positive value if @s1 > @s2.
 */
int strcasecmp(string s1, string s2)
{
  int _retval;
  const(char)* _s1 = s1.toCString(false);
  const(char)* _s2 = s2.toCString(false);
  _retval = g_strcasecmp(_s1, _s2);
  return _retval;
}

/**
 * @string
 */
string strchomp(string string_)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  _cretval = g_strchomp(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * @string
 */
string strchug(string string_)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  _cretval = g_strchug(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * an integer less than, equal to, or greater than zero, if @str1 is <, == or > than @str2.
 */
int strcmp0(string str1, string str2)
{
  int _retval;
  const(char)* _str1 = str1.toCString(false);
  const(char)* _str2 = str2.toCString(false);
  _retval = g_strcmp0(_str1, _str2);
  return _retval;
}

/**
 * a newly-allocated copy of @source with all escaped
 * character compressed
 */
string strcompress(string source)
{
  char* _cretval;
  const(char)* _source = source.toCString(false);
  _cretval = g_strcompress(_source);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the modified @string
 */
string strdelimit(string string_, string delimiters, char newDelimiter)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  const(char)* _delimiters = delimiters.toCString(false);
  _cretval = g_strdelimit(_string_, _delimiters, newDelimiter);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the string
 */
string strdown(string string_)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  _cretval = g_strdown(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated copy of @str
 */
string strdup(string str)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_strdup(_str);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a UTF-8 string describing the error code. If the error code
 * is unknown, it returns a string like "Unknown error: <code>".
 */
string strerror(int errnum)
{
  const(char)* _cretval;
  _cretval = g_strerror(errnum);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a newly-allocated copy of @source with certain
 * characters escaped. See above.
 */
string strescape(string source, string exceptions)
{
  char* _cretval;
  const(char)* _source = source.toCString(false);
  const(char)* _exceptions = exceptions.toCString(false);
  _cretval = g_strescape(_source, _exceptions);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * @msgval, unless @msgval is identical to @msgid
 * and contains a '|' character, in which case a pointer to
 * the substring of msgid after the first '|' character is returned.
 */
string stripContext(string msgid, string msgval)
{
  const(char)* _cretval;
  const(char)* _msgid = msgid.toCString(false);
  const(char)* _msgval = msgval.toCString(false);
  _cretval = g_strip_context(_msgid, _msgval);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a newly-allocated string containing all of the strings joined
 * together, with @separator between them
 */
string strjoinv(string separator, string[] strArray)
{
  char* _cretval;
  const(char)* _separator = separator.toCString(false);
  char*[] _tmpstrArray;
  foreach (s; strArray)
    _tmpstrArray ~= s.toCString(false);
  _tmpstrArray ~= null;
  char** _strArray = _tmpstrArray.ptr;
  _cretval = g_strjoinv(_separator, _strArray);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * size of attempted result, which is MIN (dest_size, strlen
 * (original dest)) + strlen (src), so if retval >= dest_size,
 * truncation occurred.
 */
size_t strlcat(string dest, string src, size_t destSize)
{
  size_t _retval;
  char* _dest = dest.toCString(false);
  const(char)* _src = src.toCString(false);
  _retval = g_strlcat(_dest, _src, destSize);
  return _retval;
}

/**
 * length of @src
 */
size_t strlcpy(string dest, string src, size_t destSize)
{
  size_t _retval;
  char* _dest = dest.toCString(false);
  const(char)* _src = src.toCString(false);
  _retval = g_strlcpy(_dest, _src, destSize);
  return _retval;
}

/**
 * 0 if the strings match, a negative value if @s1 < @s2,
 * or a positive value if @s1 > @s2.
 */
int strncasecmp(string s1, string s2, uint n)
{
  int _retval;
  const(char)* _s1 = s1.toCString(false);
  const(char)* _s2 = s2.toCString(false);
  _retval = g_strncasecmp(_s1, _s2, n);
  return _retval;
}

/**
 * a newly-allocated buffer containing the first @n bytes
 * of @str, nul-terminated
 */
string strndup(string str, size_t n)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_strndup(_str, n);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly-allocated string filled the @fill_char
 */
string strnfill(size_t length, char fillChar)
{
  char* _cretval;
  _cretval = g_strnfill(length, fillChar);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the same pointer passed in as @string
 */
string strreverse(string string_)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  _cretval = g_strreverse(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a pointer to the found occurrence, or
 * %NULL if not found.
 */
string strrstr(string haystack, string needle)
{
  char* _cretval;
  const(char)* _haystack = haystack.toCString(false);
  const(char)* _needle = needle.toCString(false);
  _cretval = g_strrstr(_haystack, _needle);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a pointer to the found occurrence, or
 * %NULL if not found.
 */
string strrstrLen(string haystack, ptrdiff_t haystackLen, string needle)
{
  char* _cretval;
  const(char)* _haystack = haystack.toCString(false);
  const(char)* _needle = needle.toCString(false);
  _cretval = g_strrstr_len(_haystack, haystackLen, _needle);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a UTF-8 string describing the signal. If the signal is unknown,
 * it returns "unknown signal (<signum>)".
 */
string strsignal(int signum)
{
  const(char)* _cretval;
  _cretval = g_strsignal(signum);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a newly-allocated %NULL-terminated array of
 * strings. Use g_strfreev() to free it.
 */
string[] strsplit(string string_, string delimiter, int maxTokens)
{
  char** _cretval;
  const(char)* _string_ = string_.toCString(false);
  const(char)* _delimiter = delimiter.toCString(false);
  _cretval = g_strsplit(_string_, _delimiter, maxTokens);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * a newly-allocated %NULL-terminated array of
 * strings. Use g_strfreev() to free it.
 */
string[] strsplitSet(string string_, string delimiters, int maxTokens)
{
  char** _cretval;
  const(char)* _string_ = string_.toCString(false);
  const(char)* _delimiters = delimiters.toCString(false);
  _cretval = g_strsplit_set(_string_, _delimiters, maxTokens);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * a pointer to the found occurrence, or
 * %NULL if not found.
 */
string strstrLen(string haystack, ptrdiff_t haystackLen, string needle)
{
  char* _cretval;
  const(char)* _haystack = haystack.toCString(false);
  const(char)* _needle = needle.toCString(false);
  _cretval = g_strstr_len(_haystack, haystackLen, _needle);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the #gdouble value.
 */
double strtod(string nptr, out string endptr)
{
  double _retval;
  const(char)* _nptr = nptr.toCString(false);
  char* _endptr;
  _retval = g_strtod(_nptr, &_endptr);
  endptr = _endptr.fromCString(false);
  return _retval;
}

/**
 * the string
 */
string strup(string string_)
{
  char* _cretval;
  char* _string_ = string_.toCString(false);
  _cretval = g_strup(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if @str is an element of @strv, according to g_str_equal().
 */
bool strvContains(string[] strv, string str)
{
  bool _retval;
  const(char)*[] _tmpstrv;
  foreach (s; strv)
    _tmpstrv ~= s.toCString(false);
  _tmpstrv ~= null;
  const(char*)* _strv = _tmpstrv.ptr;

  const(char)* _str = str.toCString(false);
  _retval = g_strv_contains(_strv, _str);
  return _retval;
}

/**
 * %TRUE if @strv1 and @strv2 are equal
 */
bool strvEqual(string[] strv1, string[] strv2)
{
  bool _retval;
  const(char)*[] _tmpstrv1;
  foreach (s; strv1)
    _tmpstrv1 ~= s.toCString(false);
  _tmpstrv1 ~= null;
  const(char*)* _strv1 = _tmpstrv1.ptr;

  const(char)*[] _tmpstrv2;
  foreach (s; strv2)
    _tmpstrv2 ~= s.toCString(false);
  _tmpstrv2 ~= null;
  const(char*)* _strv2 = _tmpstrv2.ptr;
  _retval = g_strv_equal(_strv1, _strv2);
  return _retval;
}

GType strvGetType()
{
  GType _retval;
  _retval = g_strv_get_type();
  return _retval;
}

/**
 * length of @str_array.
 */
uint strvLength(string[] strArray)
{
  uint _retval;
  const(char)*[] _tmpstrArray;
  foreach (s; strArray)
    _tmpstrArray ~= s.toCString(false);
  _tmpstrArray ~= null;
  const(char*)* _strArray = _tmpstrArray.ptr;
  _retval = g_strv_length(_strArray);
  return _retval;
}

/**
 * Create a new test case, similar to g_test_create_case(). However
 * the test is assumed to use no fixture, and test suites are automatically
 * created on the fly and added to the root fixture, based on the
 * slash-separated portions of @testpath. The @test_data argument
 * will be passed as first argument to @test_func.
 *
 * If @testpath includes the component "subprocess" anywhere in it,
 * the test will be skipped by default, and only run if explicitly
 * required via the `-p` command-line option or g_test_trap_subprocess().
 *
 * No component of @testpath may start with a dot (`.`) if the
 * %G_TEST_OPTION_ISOLATE_DIRS option is being used; and it is recommended to
 * do so even if it isn’t.
 */
void testAddDataFunc(string testpath, const(void)* testData, TestDataFunc testFunc)
{
  extern(C) void _testFuncCallback(const(void)* userData)
  {
    ptrThawGC(userData);

    (*(cast(TestDataFunc*)userData))();
  }

  const(char)* _testpath = testpath.toCString(false);
  g_test_add_data_func(_testpath, testData, &_testFuncCallback);
}

void testAssertExpectedMessagesInternal(string domain, string file, int line, string func)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  g_test_assert_expected_messages_internal(_domain, _file, line, _func);
}

/**
 * This function adds a message to test reports that
 * associates a bug URI with a test case.
 *
 * Bug URIs are constructed from a base URI set with g_test_bug_base()
 * and @bug_uri_snippet. If g_test_bug_base() has not been called, it is
 * assumed to be the empty string, so a full URI can be provided to
 * g_test_bug() instead.
 *
 * Since GLib 2.70, the base URI is not prepended to @bug_uri_snippet if it
 * is already a valid URI.
 */
void testBug(string bugUriSnippet)
{
  const(char)* _bugUriSnippet = bugUriSnippet.toCString(false);
  g_test_bug(_bugUriSnippet);
}

/**
 * Specify the base URI for bug reports.
 *
 * The base URI is used to construct bug report messages for
 * g_test_message() when g_test_bug() is called.
 * Calling this function outside of a test case sets the
 * default base URI for all test cases. Calling it from within
 * a test case changes the base URI for the scope of the test
 * case only.
 * Bug URIs are constructed by appending a bug specific URI
 * portion to @uri_pattern, or by replacing the special string
 * `%s` within @uri_pattern if that is present.
 *
 * If g_test_bug_base() is not called, bug URIs are formed solely
 * from the value provided by g_test_bug().
 */
void testBugBase(string uriPattern)
{
  const(char)* _uriPattern = uriPattern.toCString(false);
  g_test_bug_base(_uriPattern);
}

/**
 * Attempt to disable system crash reporting infrastructure.
 *
 * This function should be called before exercising code paths that are
 * expected or intended to crash, to avoid wasting resources in system-wide
 * crash collection infrastructure such as systemd-coredump or abrt.
 */
void testDisableCrashReporting()
{
  g_test_disable_crash_reporting();
}

/**
 * Indicates that a message with the given @log_domain and @log_level,
 * with text matching @pattern, is expected to be logged. When this
 * message is logged, it will not be printed, and the test case will
 * not abort.
 *
 * This API may only be used with the old logging API (g_log() without
 * %G_LOG_USE_STRUCTURED defined). It will not work with the structured logging
 * API. See [Testing for Messages][testing-for-messages].
 *
 * Use g_test_assert_expected_messages() to assert that all
 * previously-expected messages have been seen and suppressed.
 *
 * You can call this multiple times in a row, if multiple messages are
 * expected as a result of a single call. (The messages must appear in
 * the same order as the calls to g_test_expect_message().)
 *
 * For example:
 *
 * |[<!-- language="C" -->
 * // g_main_context_push_thread_default() should fail if the
 * // context is already owned by another thread.
 * g_test_expect_message (G_LOG_DOMAIN,
 * G_LOG_LEVEL_CRITICAL,
 * "assertion*acquired_context*failed");
 * g_main_context_push_thread_default (bad_context);
 * g_test_assert_expected_messages ();
 * ]|
 *
 * Note that you cannot use this to test g_error() messages, since
 * g_error() intentionally never returns even if the program doesn't
 * abort; use g_test_trap_subprocess() in this case.
 *
 * If messages at %G_LOG_LEVEL_DEBUG are emitted, but not explicitly
 * expected via g_test_expect_message() then they will be ignored.
 */
void testExpectMessage(string logDomain, LogLevelFlags logLevel, string pattern)
{
  const(char)* _logDomain = logDomain.toCString(false);
  const(char)* _pattern = pattern.toCString(false);
  g_test_expect_message(_logDomain, logLevel, _pattern);
}

/**
 * Indicates that a test failed. This function can be called
 * multiple times from the same test. You can use this function
 * if your test failed in a recoverable way.
 *
 * Do not use this function if the failure of a test could cause
 * other tests to malfunction.
 *
 * Calling this function will not stop the test from running, you
 * need to return from the test function yourself. So you can
 * produce additional diagnostic messages or even continue running
 * the test.
 *
 * If not called from inside a test, this function does nothing.
 *
 * Note that unlike g_test_skip() and g_test_incomplete(), this
 * function does not log a message alongside the test failure.
 * If details of the test failure are available, either log them with
 * g_test_message() before g_test_fail(), or use g_test_fail_printf()
 * instead.
 */
void testFail()
{
  g_test_fail();
}

/**
 * %TRUE if the test has failed
 */
bool testFailed()
{
  bool _retval;
  _retval = g_test_failed();
  return _retval;
}

/**
 * the path of the directory, owned by GLib
 */
string testGetDir(TestFileType fileType)
{
  const(char)* _cretval;
  _cretval = g_test_get_dir(fileType);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the test path for the test currently being run
 */
string testGetPath()
{
  const(char)* _cretval;
  _cretval = g_test_get_path();
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Indicates that a test failed because of some incomplete
 * functionality. This function can be called multiple times
 * from the same test.
 *
 * Calling this function will not stop the test from running, you
 * need to return from the test function yourself. So you can
 * produce additional diagnostic messages or even continue running
 * the test.
 *
 * If not called from inside a test, this function does nothing.
 */
void testIncomplete(string msg)
{
  const(char)* _msg = msg.toCString(false);
  g_test_incomplete(_msg);
}

string testLogTypeName(TestLogType logType)
{
  const(char)* _cretval;
  _cretval = g_test_log_type_name(logType);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Enqueue a pointer to be released with g_free() during the next
 * teardown phase. This is equivalent to calling g_test_queue_destroy()
 * with a destroy callback of g_free().
 */
void testQueueFree(void* gfreePointer)
{
  g_test_queue_free(gfreePointer);
}

/**
 * a random number from the seeded random number generator.
 */
double testRandDouble()
{
  double _retval;
  _retval = g_test_rand_double();
  return _retval;
}

/**
 * a number with @range_start <= number < @range_end.
 */
double testRandDoubleRange(double rangeStart, double rangeEnd)
{
  double _retval;
  _retval = g_test_rand_double_range(rangeStart, rangeEnd);
  return _retval;
}

/**
 * a random number from the seeded random number generator.
 */
int testRandInt()
{
  int _retval;
  _retval = g_test_rand_int();
  return _retval;
}

/**
 * a number with @begin <= number < @end.
 */
int testRandIntRange(int begin, int end)
{
  int _retval;
  _retval = g_test_rand_int_range(begin, end);
  return _retval;
}

/**
 * 0 on success, 1 on failure (assuming it returns at all),
 * 0 or 77 if all tests were skipped with g_test_skip() and/or
 * g_test_incomplete()
 */
int testRun()
{
  int _retval;
  _retval = g_test_run();
  return _retval;
}

/**
 * 0 on success
 */
int testRunSuite(TestSuite suite)
{
  int _retval;
  _retval = g_test_run_suite(suite ? suite.cPtr!GTestSuite : null);
  return _retval;
}

/**
 * Changes the behaviour of the various `g_assert_*()` macros,
 * g_test_assert_expected_messages() and the various
 * `g_test_trap_assert_*()` macros to not abort to program, but instead
 * call g_test_fail() and continue. (This also changes the behavior of
 * g_test_fail() so that it will not cause the test program to abort
 * after completing the failed test.)
 *
 * Note that the g_assert_not_reached() and g_assert() macros are not
 * affected by this.
 *
 * This function can only be called after g_test_init().
 */
void testSetNonfatalAssertions()
{
  g_test_set_nonfatal_assertions();
}

/**
 * Indicates that a test was skipped.
 *
 * Calling this function will not stop the test from running, you
 * need to return from the test function yourself. So you can
 * produce additional diagnostic messages or even continue running
 * the test.
 *
 * If not called from inside a test, this function does nothing.
 */
void testSkip(string msg)
{
  const(char)* _msg = msg.toCString(false);
  g_test_skip(_msg);
}

/**
 * %TRUE if the test program is running under
 * g_test_trap_subprocess().
 */
bool testSubprocess()
{
  bool _retval;
  _retval = g_test_subprocess();
  return _retval;
}

/**
 * Set the summary for a test, which describes what the test checks, and how it
 * goes about checking it. This may be included in test report output, and is
 * useful documentation for anyone reading the source code or modifying a test
 * in future. It must be a single line.
 *
 * This should be called at the top of a test function.
 *
 * For example:
 * |[<!-- language="C" -->
 * static void
 * test_array_sort (void)
 * {
 * g_test_summary ("Test my_array_sort() sorts the array correctly and stably, "
 * "including testing zero length and one-element arrays.");
 *
 * …
 * }
 * ]|
 */
void testSummary(string summary)
{
  const(char)* _summary = summary.toCString(false);
  g_test_summary(_summary);
}

/**
 * the time since the last start of the timer in seconds, as a double
 */
double testTimerElapsed()
{
  double _retval;
  _retval = g_test_timer_elapsed();
  return _retval;
}

/**
 * the last result of g_test_timer_elapsed(), as a double
 */
double testTimerLast()
{
  double _retval;
  _retval = g_test_timer_last();
  return _retval;
}

/**
 * Start a timing test. Call g_test_timer_elapsed() when the task is supposed
 * to be done. Call this function again to restart the timer.
 */
void testTimerStart()
{
  g_test_timer_start();
}

void testTrapAssertions(string domain, string file, int line, string func, ulong assertionFlags, string pattern)
{
  const(char)* _domain = domain.toCString(false);
  const(char)* _file = file.toCString(false);
  const(char)* _func = func.toCString(false);
  const(char)* _pattern = pattern.toCString(false);
  g_test_trap_assertions(_domain, _file, line, _func, assertionFlags, _pattern);
}

/**
 * %TRUE for the forked child and %FALSE for the executing parent process.
 */
bool testTrapFork(ulong usecTimeout, TestTrapFlags testTrapFlags)
{
  bool _retval;
  _retval = g_test_trap_fork(usecTimeout, testTrapFlags);
  return _retval;
}

/**
 * %TRUE if the last test subprocess terminated successfully.
 */
bool testTrapHasPassed()
{
  bool _retval;
  _retval = g_test_trap_has_passed();
  return _retval;
}

/**
 * %TRUE if the last test subprocess got killed due to a timeout.
 */
bool testTrapReachedTimeout()
{
  bool _retval;
  _retval = g_test_trap_reached_timeout();
  return _retval;
}

/**
 * Respawns the test program to run only @test_path in a subprocess.
 * This can be used for a test case that might not return, or that
 * might abort.
 *
 * If @test_path is %NULL then the same test is re-run in a subprocess.
 * You can use g_test_subprocess() to determine whether the test is in
 * a subprocess or not.
 *
 * @test_path can also be the name of the parent test, followed by
 * "`/subprocess/`" and then a name for the specific subtest (or just
 * ending with "`/subprocess`" if the test only has one child test);
 * tests with names of this form will automatically be skipped in the
 * parent process.
 *
 * If @usec_timeout is non-0, the test subprocess is aborted and
 * considered failing if its run time exceeds it.
 *
 * The subprocess behavior can be configured with the
 * #GTestSubprocessFlags flags.
 *
 * You can use methods such as g_test_trap_assert_passed(),
 * g_test_trap_assert_failed(), and g_test_trap_assert_stderr() to
 * check the results of the subprocess. (But note that
 * g_test_trap_assert_stdout() and g_test_trap_assert_stderr()
 * cannot be used if @test_flags specifies that the child should
 * inherit the parent stdout/stderr.)
 *
 * If your `main ()` needs to behave differently in
 * the subprocess, you can call g_test_subprocess() (after calling
 * g_test_init()) to see whether you are in a subprocess.
 *
 * Internally, this function tracks the child process using
 * g_child_watch_source_new(), so your process must not ignore `SIGCHLD`, and
 * must not attempt to watch or wait for the child process via another
 * mechanism.
 *
 * The following example tests that calling
 * `my_object_new(1000000)` will abort with an error
 * message.
 *
 * |[<!-- language="C" -->
 * static void
 * test_create_large_object (void)
 * {
 * if (g_test_subprocess ())
 * {
 * my_object_new (1000000);
 * return;
 * }
 *
 * // Reruns this same test in a subprocess
 * g_test_trap_subprocess (NULL, 0, G_TEST_SUBPROCESS_DEFAULT);
 * g_test_trap_assert_failed ();
 * g_test_trap_assert_stderr ("*ERROR*too large*");
 * }
 *
 * int
 * main (int argc, char **argv)
 * {
 * g_test_init (&argc, &argv, NULL);
 *
 * g_test_add_func ("/myobject/create_large_object",
 * test_create_large_object);
 * return g_test_run ();
 * }
 * ]|
 */
void testTrapSubprocess(string testPath, ulong usecTimeout, TestSubprocessFlags testFlags)
{
  const(char)* _testPath = testPath.toCString(false);
  g_test_trap_subprocess(_testPath, usecTimeout, testFlags);
}

/**
 * the ID (greater than 0) of the event source.
 */
uint timeoutAdd(int priority, uint interval, SourceFunc function_)
{
  extern(C) bool _function_Callback(void* userData)
  {
    bool _retval = (*(cast(SourceFunc*)userData))();
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&function_);
  _retval = g_timeout_add_full(priority, interval, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * the ID (greater than 0) of the event source.
 */
uint timeoutAddSeconds(int priority, uint interval, SourceFunc function_)
{
  extern(C) bool _function_Callback(void* userData)
  {
    bool _retval = (*(cast(SourceFunc*)userData))();
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&function_);
  _retval = g_timeout_add_seconds_full(priority, interval, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * the newly-created timeout source
 */
Source timeoutSourceNew(uint interval)
{
  GSource* _cretval;
  _cretval = g_timeout_source_new(interval);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * the newly-created timeout source
 */
Source timeoutSourceNewSeconds(uint interval)
{
  GSource* _cretval;
  _cretval = g_timeout_source_new_seconds(interval);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * the allocated memory, or %NULL.
 */
void* tryMalloc(size_t nBytes)
{
  void* _retval;
  _retval = g_try_malloc(nBytes);
  return _retval;
}

/**
 * the allocated memory, or %NULL
 */
void* tryMalloc0(size_t nBytes)
{
  void* _retval;
  _retval = g_try_malloc0(nBytes);
  return _retval;
}

/**
 * the allocated memory, or %NULL
 */
void* tryMalloc0N(size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_try_malloc0_n(nBlocks, nBlockBytes);
  return _retval;
}

/**
 * the allocated memory, or %NULL.
 */
void* tryMallocN(size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_try_malloc_n(nBlocks, nBlockBytes);
  return _retval;
}

/**
 * the allocated memory, or %NULL.
 */
void* tryRealloc(void* mem, size_t nBytes)
{
  void* _retval;
  _retval = g_try_realloc(mem, nBytes);
  return _retval;
}

/**
 * the allocated memory, or %NULL.
 */
void* tryReallocN(void* mem, size_t nBlocks, size_t nBlockBytes)
{
  void* _retval;
  _retval = g_try_realloc_n(mem, nBlocks, nBlockBytes);
  return _retval;
}

/**
 * a pointer to a newly allocated UTF-16 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set.
 */
ushort[] ucs4ToUtf16(dchar[] str, out long itemsRead, out long itemsWritten)
{
  ushort* _cretval;
  auto _str = cast(const(dchar)*)str.ptr;
  GError *_err;
  _cretval = g_ucs4_to_utf16(_str, str ? cast(long)str.length : 0, cast(long*)&itemsRead, cast(long*)&itemsWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  ushort[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != 0; _cretlength++)
      break;
    _retval = cast(ushort[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a pointer to a newly allocated UTF-8 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set. In that case, @items_read
 * will be set to the position of the first invalid input character.
 */
string ucs4ToUtf8(dchar[] str, out long itemsRead, out long itemsWritten)
{
  char* _cretval;
  auto _str = cast(const(dchar)*)str.ptr;
  GError *_err;
  _cretval = g_ucs4_to_utf8(_str, str ? cast(long)str.length : 0, cast(long*)&itemsRead, cast(long*)&itemsWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the break type of @c
 */
UnicodeBreakType unicharBreakType(dchar c)
{
  GUnicodeBreakType _cretval;
  _cretval = g_unichar_break_type(c);
  UnicodeBreakType _retval = cast(UnicodeBreakType)_cretval;
  return _retval;
}

/**
 * the combining class of the character
 */
int unicharCombiningClass(dchar uc)
{
  int _retval;
  _retval = g_unichar_combining_class(uc);
  return _retval;
}

/**
 * %TRUE if the characters could be composed
 */
bool unicharCompose(dchar a, dchar b, out dchar ch)
{
  bool _retval;
  _retval = g_unichar_compose(a, b, cast(dchar*)&ch);
  return _retval;
}

/**
 * %TRUE if the character could be decomposed
 */
bool unicharDecompose(dchar ch, out dchar a, out dchar b)
{
  bool _retval;
  _retval = g_unichar_decompose(ch, cast(dchar*)&a, cast(dchar*)&b);
  return _retval;
}

/**
 * If @c is a decimal digit (according to
 * g_unichar_isdigit()), its numeric value. Otherwise, -1.
 */
int unicharDigitValue(dchar c)
{
  int _retval;
  _retval = g_unichar_digit_value(c);
  return _retval;
}

/**
 * the length of the full decomposition.
 */
size_t unicharFullyDecompose(dchar ch, bool compat, out dchar result, size_t resultLen)
{
  size_t _retval;
  _retval = g_unichar_fully_decompose(ch, compat, cast(dchar*)&result, resultLen);
  return _retval;
}

/**
 * %TRUE if @ch has a mirrored character, %FALSE otherwise
 */
bool unicharGetMirrorChar(dchar ch, out dchar mirroredCh)
{
  bool _retval;
  _retval = g_unichar_get_mirror_char(ch, cast(dchar*)&mirroredCh);
  return _retval;
}

/**
 * the #GUnicodeScript for the character.
 */
UnicodeScript unicharGetScript(dchar ch)
{
  GUnicodeScript _cretval;
  _cretval = g_unichar_get_script(ch);
  UnicodeScript _retval = cast(UnicodeScript)_cretval;
  return _retval;
}

/**
 * %TRUE if @c is an alphanumeric character
 */
bool unicharIsalnum(dchar c)
{
  bool _retval;
  _retval = g_unichar_isalnum(c);
  return _retval;
}

/**
 * %TRUE if @c is an alphabetic character
 */
bool unicharIsalpha(dchar c)
{
  bool _retval;
  _retval = g_unichar_isalpha(c);
  return _retval;
}

/**
 * %TRUE if @c is a control character
 */
bool unicharIscntrl(dchar c)
{
  bool _retval;
  _retval = g_unichar_iscntrl(c);
  return _retval;
}

/**
 * %TRUE if the character has an assigned value
 */
bool unicharIsdefined(dchar c)
{
  bool _retval;
  _retval = g_unichar_isdefined(c);
  return _retval;
}

/**
 * %TRUE if @c is a digit
 */
bool unicharIsdigit(dchar c)
{
  bool _retval;
  _retval = g_unichar_isdigit(c);
  return _retval;
}

/**
 * %TRUE if @c is printable unless it's a space
 */
bool unicharIsgraph(dchar c)
{
  bool _retval;
  _retval = g_unichar_isgraph(c);
  return _retval;
}

/**
 * %TRUE if @c is a lowercase letter
 */
bool unicharIslower(dchar c)
{
  bool _retval;
  _retval = g_unichar_islower(c);
  return _retval;
}

/**
 * %TRUE if @c is a mark character
 */
bool unicharIsmark(dchar c)
{
  bool _retval;
  _retval = g_unichar_ismark(c);
  return _retval;
}

/**
 * %TRUE if @c is printable
 */
bool unicharIsprint(dchar c)
{
  bool _retval;
  _retval = g_unichar_isprint(c);
  return _retval;
}

/**
 * %TRUE if @c is a punctuation or symbol character
 */
bool unicharIspunct(dchar c)
{
  bool _retval;
  _retval = g_unichar_ispunct(c);
  return _retval;
}

/**
 * %TRUE if @c is a space character
 */
bool unicharIsspace(dchar c)
{
  bool _retval;
  _retval = g_unichar_isspace(c);
  return _retval;
}

/**
 * %TRUE if the character is titlecase
 */
bool unicharIstitle(dchar c)
{
  bool _retval;
  _retval = g_unichar_istitle(c);
  return _retval;
}

/**
 * %TRUE if @c is an uppercase character
 */
bool unicharIsupper(dchar c)
{
  bool _retval;
  _retval = g_unichar_isupper(c);
  return _retval;
}

/**
 * %TRUE if the character is wide
 */
bool unicharIswide(dchar c)
{
  bool _retval;
  _retval = g_unichar_iswide(c);
  return _retval;
}

/**
 * %TRUE if the character is wide in legacy East Asian locales
 */
bool unicharIswideCjk(dchar c)
{
  bool _retval;
  _retval = g_unichar_iswide_cjk(c);
  return _retval;
}

/**
 * %TRUE if the character is a hexadecimal digit
 */
bool unicharIsxdigit(dchar c)
{
  bool _retval;
  _retval = g_unichar_isxdigit(c);
  return _retval;
}

/**
 * %TRUE if the character has zero width
 */
bool unicharIszerowidth(dchar c)
{
  bool _retval;
  _retval = g_unichar_iszerowidth(c);
  return _retval;
}

/**
 * the result of converting @c to lower case.
 * If @c is not an upperlower or titlecase character,
 * or has no lowercase equivalent @c is returned unchanged.
 */
dchar unicharTolower(dchar c)
{
  dchar _retval;
  _retval = g_unichar_tolower(c);
  return _retval;
}

/**
 * the result of converting @c to titlecase.
 * If @c is not an uppercase or lowercase character,
 * @c is returned unchanged.
 */
dchar unicharTotitle(dchar c)
{
  dchar _retval;
  _retval = g_unichar_totitle(c);
  return _retval;
}

/**
 * the result of converting @c to uppercase.
 * If @c is not a lowercase or titlecase character,
 * or has no upper case equivalent @c is returned unchanged.
 */
dchar unicharToupper(dchar c)
{
  dchar _retval;
  _retval = g_unichar_toupper(c);
  return _retval;
}

/**
 * the type of the character.
 */
UnicodeType unicharType(dchar c)
{
  GUnicodeType _cretval;
  _cretval = g_unichar_type(c);
  UnicodeType _retval = cast(UnicodeType)_cretval;
  return _retval;
}

/**
 * %TRUE if @ch is a valid Unicode character
 */
bool unicharValidate(dchar ch)
{
  bool _retval;
  _retval = g_unichar_validate(ch);
  return _retval;
}

/**
 * If @c is a hex digit (according to
 * g_unichar_isxdigit()), its numeric value. Otherwise, -1.
 */
int unicharXdigitValue(dchar c)
{
  int _retval;
  _retval = g_unichar_xdigit_value(c);
  return _retval;
}

/**
 * a newly allocated string of Unicode characters.
 * @result_len is set to the resulting length of the string.
 */
dchar[] unicodeCanonicalDecomposition(dchar ch)
{
  dchar* _cretval;
  size_t _cretlength;
  _cretval = g_unicode_canonical_decomposition(ch, &_cretlength);
  dchar[] _retval;

  if (_cretval)
  {
    _retval = cast(dchar[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Computes the canonical ordering of a string in-place.
 * This rearranges decomposed characters in the string
 * according to their combining classes.  See the Unicode
 * manual for more information.
 */
void unicodeCanonicalOrdering(dchar[] string_)
{
  auto _string_ = cast(dchar*)string_.ptr;
  g_unicode_canonical_ordering(_string_, string_ ? cast(size_t)string_.length : 0);
}

/**
 * the Unicode script for @iso15924, or
 * of %G_UNICODE_SCRIPT_INVALID_CODE if @iso15924 is zero and
 * %G_UNICODE_SCRIPT_UNKNOWN if @iso15924 is unknown.
 */
UnicodeScript unicodeScriptFromIso15924(uint iso15924)
{
  GUnicodeScript _cretval;
  _cretval = g_unicode_script_from_iso15924(iso15924);
  UnicodeScript _retval = cast(UnicodeScript)_cretval;
  return _retval;
}

/**
 * the ISO 15924 code for @script, encoded as an integer,
 * of zero if @script is %G_UNICODE_SCRIPT_INVALID_CODE or
 * ISO 15924 code 'Zzzz' (script code for UNKNOWN) if @script is not understood.
 */
uint unicodeScriptToIso15924(UnicodeScript script)
{
  uint _retval;
  _retval = g_unicode_script_to_iso15924(script);
  return _retval;
}

Quark unixErrorQuark()
{
  Quark _retval;
  _retval = g_unix_error_quark();
  return _retval;
}

/**
 * the ID (greater than 0) of the event source
 */
uint unixFdAddFull(int priority, int fd, IOCondition condition, UnixFDSourceFunc function_)
{
  extern(C) bool _function_Callback(int fd, GIOCondition condition, void* userData)
  {
    bool _retval = (*(cast(UnixFDSourceFunc*)userData))(fd, condition);
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&function_);
  _retval = g_unix_fd_add_full(priority, fd, condition, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * the newly created #GSource
 */
Source unixFdSourceNew(int fd, IOCondition condition)
{
  GSource* _cretval;
  _cretval = g_unix_fd_source_new(fd, condition);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * passwd entry, or %NULL on error; free the returned
 * value with g_free()
 */
void* unixGetPasswdEntry(string userName)
{
  void* _retval;
  const(char)* _userName = userName.toCString(false);
  GError *_err;
  _retval = g_unix_get_passwd_entry(_userName, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if not (and errno will be set).
 */
bool unixOpenPipe(int[] fds, int flags)
{
  bool _retval;
  assert(!fds || fds.length == 2);
  auto _fds = cast(int*)fds.ptr;
  GError *_err;
  _retval = g_unix_open_pipe(_fds, flags, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE if successful
 */
bool unixSetFdNonblocking(int fd, bool nonblock)
{
  bool _retval;
  GError *_err;
  _retval = g_unix_set_fd_nonblocking(fd, nonblock, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * An ID (greater than 0) for the event source
 */
uint unixSignalAdd(int priority, int signum, SourceFunc handler)
{
  extern(C) bool _handlerCallback(void* userData)
  {
    bool _retval = (*(cast(SourceFunc*)userData))();
    return _retval;
  }

  uint _retval;
  ptrFreezeGC(cast(void*)&handler);
  _retval = g_unix_signal_add_full(priority, signum, &_handlerCallback, cast(void*)&handler, &ptrThawDestroyNotify);
  return _retval;
}

/**
 * A newly created #GSource
 */
Source unixSignalSourceNew(int signum)
{
  GSource* _cretval;
  _cretval = g_unix_signal_source_new(signum);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * 0 if the name was successfully deleted, -1 if an error
 * occurred
 */
int unlink(string filename)
{
  int _retval;
  const(char)* _filename = filename.toCString(false);
  _retval = g_unlink(_filename);
  return _retval;
}

/**
 * Removes an environment variable from the environment.
 *
 * Note that on some systems, when variables are overwritten, the
 * memory used for the previous variables and its value isn't reclaimed.
 *
 * You should be mindful of the fact that environment variable handling
 * in UNIX is not thread-safe, and your program may crash if one thread
 * calls g_unsetenv() while another thread is calling getenv(). (And note
 * that many functions, such as gettext(), call getenv() internally.) This
 * function is only safe to use at the very start of your program, before
 * creating any other threads (or creating objects that create worker
 * threads of their own).
 *
 * If you need to set up the environment for a child process, you can
 * use g_get_environ() to get an environment array, modify that with
 * g_environ_setenv() and g_environ_unsetenv(), and then pass that
 * array directly to execvpe(), g_spawn_async(), or the like.
 */
void unsetenv(string variable)
{
  const(char)* _variable = variable.toCString(false);
  g_unsetenv(_variable);
}

/**
 * Pauses the current thread for the given number of microseconds.
 *
 * There are 1 million microseconds per second (represented by the
 * %G_USEC_PER_SEC macro). g_usleep() may have limited precision,
 * depending on hardware and operating system; don't rely on the exact
 * length of the sleep.
 */
void usleep(ulong microseconds)
{
  g_usleep(microseconds);
}

/**
 * a pointer to a newly allocated UCS-4 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set.
 */
dchar[] utf16ToUcs4(ushort[] str, out long itemsRead)
{
  dchar* _cretval;
  long _cretlength;
  auto _str = cast(const(ushort)*)str.ptr;
  GError *_err;
  _cretval = g_utf16_to_ucs4(_str, str ? cast(long)str.length : 0, cast(long*)&itemsRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  dchar[] _retval;

  if (_cretval)
  {
    _retval = cast(dchar[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a pointer to a newly allocated UTF-8 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set.
 */
string utf16ToUtf8(ushort[] str, out long itemsRead, out long itemsWritten)
{
  char* _cretval;
  auto _str = cast(const(ushort)*)str.ptr;
  GError *_err;
  _cretval = g_utf16_to_utf8(_str, str ? cast(long)str.length : 0, cast(long*)&itemsRead, cast(long*)&itemsWritten, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string, that is a
 * case independent form of @str.
 */
string utf8Casefold(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_casefold(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * < 0 if @str1 compares before @str2,
 * 0 if they compare equal, > 0 if @str1 compares after @str2.
 */
int utf8Collate(string str1, string str2)
{
  int _retval;
  const(char)* _str1 = str1.toCString(false);
  const(char)* _str2 = str2.toCString(false);
  _retval = g_utf8_collate(_str1, _str2);
  return _retval;
}

/**
 * a newly allocated string. This string should
 * be freed with g_free() when you are done with it.
 */
string utf8CollateKey(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_collate_key(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string. This string should
 * be freed with g_free() when you are done with it.
 */
string utf8CollateKeyForFilename(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_collate_key_for_filename(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a pointer to the found character or %NULL if @end is
 * set and is reached
 */
string utf8FindNextChar(string p, string end)
{
  char* _cretval;
  const(char)* _p = p.toCString(false);
  const(char)* _end = end.toCString(false);
  _cretval = g_utf8_find_next_char(_p, _end);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a pointer to the found character or %NULL.
 */
string utf8FindPrevChar(string str, string p)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  const(char)* _p = p.toCString(false);
  _cretval = g_utf8_find_prev_char(_str, _p);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the resulting character
 */
dchar utf8GetChar(string p)
{
  dchar _retval;
  const(char)* _p = p.toCString(false);
  _retval = g_utf8_get_char(_p);
  return _retval;
}

/**
 * the resulting character. If @p points to a partial
 * sequence at the end of a string that could begin a valid
 * character (or if @max_len is zero), returns (gunichar)-2;
 * otherwise, if @p does not point to a valid UTF-8 encoded
 * Unicode character, returns (gunichar)-1.
 */
dchar utf8GetCharValidated(string p, ptrdiff_t maxLen)
{
  dchar _retval;
  const(char)* _p = p.toCString(false);
  _retval = g_utf8_get_char_validated(_p, maxLen);
  return _retval;
}

/**
 * a valid UTF-8 string whose content resembles @str
 */
string utf8MakeValid(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_make_valid(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string, that
 * is the normalized form of @str, or %NULL if @str
 * is not valid UTF-8.
 */
string utf8Normalize(string str, ptrdiff_t len, NormalizeMode mode)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_normalize(_str, len, mode);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the resulting pointer
 */
string utf8OffsetToPointer(string str, long offset)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_offset_to_pointer(_str, offset);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the resulting character offset
 */
long utf8PointerToOffset(string str, string pos)
{
  long _retval;
  const(char)* _str = str.toCString(false);
  const(char)* _pos = pos.toCString(false);
  _retval = g_utf8_pointer_to_offset(_str, _pos);
  return _retval;
}

/**
 * a pointer to the found character
 */
string utf8PrevChar(string p)
{
  char* _cretval;
  const(char)* _p = p.toCString(false);
  _cretval = g_utf8_prev_char(_p);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %NULL if the string does not contain the character,
 * otherwise, a pointer to the start of the leftmost occurrence
 * of the character in the string.
 */
string utf8Strchr(string p, ptrdiff_t len, dchar c)
{
  char* _cretval;
  const(char)* _p = p.toCString(false);
  _cretval = g_utf8_strchr(_p, len, c);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a newly allocated string, with all characters
 * converted to lowercase.
 */
string utf8Strdown(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_strdown(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * the length of the string in characters
 */
long utf8Strlen(string p, ptrdiff_t max)
{
  long _retval;
  const(char)* _p = p.toCString(false);
  _retval = g_utf8_strlen(_p, max);
  return _retval;
}

/**
 * @dest
 */
string utf8Strncpy(string dest, string src, size_t n)
{
  char* _cretval;
  char* _dest = dest.toCString(false);
  const(char)* _src = src.toCString(false);
  _cretval = g_utf8_strncpy(_dest, _src, n);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %NULL if the string does not contain the character,
 * otherwise, a pointer to the start of the rightmost occurrence
 * of the character in the string.
 */
string utf8Strrchr(string p, ptrdiff_t len, dchar c)
{
  char* _cretval;
  const(char)* _p = p.toCString(false);
  _cretval = g_utf8_strrchr(_p, len, c);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a newly-allocated string which is the reverse of @str
 */
string utf8Strreverse(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_strreverse(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated string, with all characters
 * converted to uppercase.
 */
string utf8Strup(string str, ptrdiff_t len)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_strup(_str, len);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a newly allocated copy of the requested
 * substring. Free with g_free() when no longer needed.
 */
string utf8Substring(string str, long startPos, long endPos)
{
  char* _cretval;
  const(char)* _str = str.toCString(false);
  _cretval = g_utf8_substring(_str, startPos, endPos);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * a pointer to a newly allocated UCS-4 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set.
 */
dchar[] utf8ToUcs4(string str, long len, out long itemsRead)
{
  dchar* _cretval;
  long _cretlength;
  const(char)* _str = str.toCString(false);
  GError *_err;
  _cretval = g_utf8_to_ucs4(_str, len, cast(long*)&itemsRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  dchar[] _retval;

  if (_cretval)
  {
    _retval = cast(dchar[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a pointer to a newly allocated UCS-4 string.
 * This value must be freed with g_free().
 */
dchar[] utf8ToUcs4Fast(string str)
{
  dchar* _cretval;
  long _cretlength;
  auto _str = cast(const(char)*)(str ~ 0).ptr;
  _cretval = g_utf8_to_ucs4_fast(_str, str ? cast(long)str.length : 0, &_cretlength);
  dchar[] _retval;

  if (_cretval)
  {
    _retval = cast(dchar[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a pointer to a newly allocated UTF-16 string.
 * This value must be freed with g_free(). If an error occurs,
 * %NULL will be returned and @error set.
 */
ushort[] utf8ToUtf16(string str, long len, out long itemsRead)
{
  ushort* _cretval;
  long _cretlength;
  const(char)* _str = str.toCString(false);
  GError *_err;
  _cretval = g_utf8_to_utf16(_str, len, cast(long*)&itemsRead, &_cretlength, &_err);
  if (_err)
    throw new ErrorG(_err);
  ushort[] _retval;

  if (_cretval)
  {
    _retval = cast(ushort[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * a newly-allocated copy of @string ellipsized in the middle
 */
string utf8TruncateMiddle(string string_, size_t truncateLength)
{
  char* _cretval;
  const(char)* _string_ = string_.toCString(false);
  _cretval = g_utf8_truncate_middle(_string_, truncateLength);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if the text was valid UTF-8
 */
bool utf8Validate(ubyte[] str, out string end)
{
  bool _retval;
  auto _str = cast(const(ubyte)*)str.ptr;
  char* _end;
  _retval = g_utf8_validate(_str, str ? cast(ptrdiff_t)str.length : 0, &_end);
  end = _end.fromCString(false);
  return _retval;
}

/**
 * %TRUE if the text was valid UTF-8
 */
bool utf8ValidateLen(ubyte[] str, out string end)
{
  bool _retval;
  auto _str = cast(const(ubyte)*)str.ptr;
  char* _end;
  _retval = g_utf8_validate_len(_str, str ? cast(size_t)str.length : 0, &_end);
  end = _end.fromCString(false);
  return _retval;
}

/**
 * %TRUE if @str is a valid UUID, %FALSE otherwise.
 */
bool uuidStringIsValid(string str)
{
  bool _retval;
  const(char)* _str = str.toCString(false);
  _retval = g_uuid_string_is_valid(_str);
  return _retval;
}

/**
 * A string that should be freed with g_free().
 */
string uuidStringRandom()
{
  char* _cretval;
  _cretval = g_uuid_string_random();
  string _retval = _cretval.fromCString(true);
  return _retval;
}

GType variantGetGtype()
{
  GType _retval;
  _retval = g_variant_get_gtype();
  return _retval;
}
