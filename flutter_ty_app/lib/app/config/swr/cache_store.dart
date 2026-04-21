import 'package:hive_ce/hive.dart';

/// 缓存实体：原始数据 + 写入时间戳
class CacheEntry {
  final dynamic raw;
  final int tsMs;
  const CacheEntry(this.raw, this.tsMs);
}

/// 缓存接口：可插拔
abstract class ICacheStore {
  Future<CacheEntry?> get(String box, String key);
  Future<void> set(String box, String key, CacheEntry entry);
  Future<void> remove(String box, String key);
  Future<void> clearBox(String box);
}

/// L1：内存缓存（进程内，最快）
class MemoryCacheStore implements ICacheStore {
  final Map<String, Map<String, CacheEntry>> _mem = {};

  String _bk(String box, String key) => '$box::$key';

  @override
  Future<CacheEntry?> get(String box, String key) async {
    return _mem[box]?[key];
  }

  @override
  Future<void> set(String box, String key, CacheEntry entry) async {
    _mem.putIfAbsent(box, () => {})[key] = entry;
  }

  @override
  Future<void> remove(String box, String key) async {
    _mem[box]?.remove(key);
  }

  @override
  Future<void> clearBox(String box) async {
    _mem[box]?.clear();
  }
}

/// L2：Hive 缓存（持久化）
/// 结构：Map{ 'raw': any, 'ts': int }
class HiveCacheStore implements ICacheStore {
  Future<Box> _open(String box) async {
    if (!Hive.isBoxOpen(box)) {
      return Hive.openBox(box);
    }
    return Hive.box(box);
  }

  @override
  Future<CacheEntry?> get(String box, String key) async {
    final b = await _open(box);
    final m = b.get(key);
    if (m is Map && m.containsKey('ts')) {
      return CacheEntry(m['raw'], m['ts'] as int);
    }
    return null;
  }

  @override
  Future<void> set(String box, String key, CacheEntry entry) async {
    final b = await _open(box);
    await b.put(key, {'raw': entry.raw, 'ts': entry.tsMs});
  }

  @override
  Future<void> remove(String box, String key) async {
    final b = await _open(box);
    await b.delete(key);
  }

  @override
  Future<void> clearBox(String box) async {
    final b = await _open(box);
    await b.clear();
  }
}

/// 组合缓存：L1→L2（可继续扩展）
/// get：按顺序命中；若命中下层，会“写回”上层（提升命中率）
/// set/remove/clear：全链路同步
class MultiLevelCache implements ICacheStore {
  final List<ICacheStore> layers;
  MultiLevelCache(this.layers);

  @override
  Future<CacheEntry?> get(String box, String key) async {
    CacheEntry? hit;
    int hitIdx = -1;
    for (var i = 0; i < layers.length; i++) {
      final v = await layers[i].get(box, key);
      if (v != null) {
        hit = v;
        hitIdx = i;
        break;
      }
    }
    if (hit != null && hitIdx > 0) {
      // 写回上层
      for (var i = hitIdx - 1; i >= 0; i--) {
        await layers[i].set(box, key, hit);
      }
    }
    return hit;
  }

  @override
  Future<void> set(String box, String key, CacheEntry entry) async {
    for (final l in layers) {
      await l.set(box, key, entry);
    }
  }

  @override
  Future<void> remove(String box, String key) async {
    for (final l in layers) {
      await l.remove(box, key);
    }
  }

  @override
  Future<void> clearBox(String box) async {
    for (final l in layers) {
      await l.clearBox(box);
    }
  }
}

/// TTL 包装器：读到过期项就返回 null，并顺手删掉（lazy eviction）
class TtlCacheStore implements ICacheStore {
  final ICacheStore inner;
  final Duration? ttl; // null 表示不过期
  TtlCacheStore(this.inner, this.ttl);

  bool _expired(CacheEntry e) {
    if (ttl == null) return false;
    final now = DateTime.now().millisecondsSinceEpoch;
    return now - e.tsMs > ttl!.inMilliseconds;
  }

  @override
  Future<CacheEntry?> get(String box, String key) async {
    final e = await inner.get(box, key);
    if (e == null) return null;
    if (_expired(e)) {
      // 过期：删掉并当作未命中
      await inner.remove(box, key);
      return null;
    }
    // swrLog('已经过期 false${e}');
    return e;
  }

  @override
  Future<void> set(String box, String key, CacheEntry entry) =>
      inner.set(box, key, entry);

  @override
  Future<void> remove(String box, String key) => inner.remove(box, key);

  @override
  Future<void> clearBox(String box) => inner.clearBox(box);
}
