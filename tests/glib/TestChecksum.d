module glib.TestChecksum;

import std.digest.md, std.digest.sha;
import std.string : toLower;
import std.traits;

import GLib.Checksum;
import GLib.global;

unittest
{
  auto testString = cast(ubyte[])"Dlang is the best";

  auto hashSizes = [
    ChecksumType.Md5: 16,
    ChecksumType.Sha1: 20,
    ChecksumType.Sha256: 32,
    ChecksumType.Sha512: 64,
    ChecksumType.Sha384: 48,
  ];

  char[][ChecksumType] testHashes;
  testHashes[ChecksumType.Md5] = hexDigest!MD5(testString);
  testHashes[ChecksumType.Sha1] = hexDigest!SHA1(testString);
  testHashes[ChecksumType.Sha256] = hexDigest!SHA256(testString);
  testHashes[ChecksumType.Sha512] = hexDigest!SHA512(testString);
  testHashes[ChecksumType.Sha384] = hexDigest!SHA384(testString);

  foreach (v; hashSizes.byKeyValue)
    assert(Checksum.typeGetLength(v.key) == v.value);

  foreach (typ; EnumMembers!ChecksumType)
  {
    auto checksum = new Checksum(typ);
    checksum.update(testString);
    assert(checksum.getString.toLower == testHashes[typ].toLower);
    auto checksumCopy = checksum.copy;
    assert(checksumCopy !is null);
    assert(checksumCopy.getString.toLower == testHashes[typ].toLower);
  }
}
