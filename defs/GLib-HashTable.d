import GLib.Boxed;
import GLib.global;

/**
 * HashTable template.
 */
class HashTable(K, KCT, VT, VCT)
{
  GHashTable* cPtr; // Hash table
  GidOwnership ownership; // Ownership of the hash table keys and values

  this(GHashTable* hash, GidOwnership ownership)
  {
    cPtr = hash;
    this.ownership = ownership;
  }

  ~this()
  {
    if (ownership == GidOwnership.None)
      return;

    if (ownership == GidOwnership.Full)
    {
      GHashTableIter iter;
      void* key;
      void* value;

      for (g_hash_table_iter_init(&iter, cPtr); g_hash_table_iter_next(&key, &key, &value); )
      {
        containerFreeItem!(K, KCT)(key);
        containerFreeItem!(VT, VCT)(value);
      }
    }

    g_hash_table_destroy(cPtr);
  }

  K opIndex(K key) const
  {
    void* pKey;

    static if (is(K : string))
      pKey = cast(void*)key.toStringz;
    else
      pKey = cast(void*)key;

    return containerGetItem!(V, VCT)(g_hash_table_lookup(cPtr, pKey));
  }

  void opIndexAssign(V value, K key)
  {
    g_hash_table_insert(containerCopyItem!(K, KT)(key), containerCopyItem!(V, VT)(value));
  }

  size_t length() const
  {
    return g_hash_table_size(cPtr);
  }
}
