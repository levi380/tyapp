/**
 * @Author swifter
 * @Date 2024/2/4 18:22
 */

import 'dart:math';

import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

/// 安全数据组
extension SafeList<T> on List<T> {
  T? safe(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  T? get safeLast {
    if (length > 0) {
      return this[length - 1];
    }
    return null;
  }

  T? get safeFirst {
    if (length > 0) {
      return this[0];
    }
    return null;
  }

  T? get safeRe {
    if (length > 0) {
      return this[0];
    }
    return null;
  }

  List<T> safeSublist(int startIndex, int endIndex) {
    // 确保索引范围有效
    if (startIndex < 0) startIndex = 0;
    if (endIndex >= length) endIndex = length - 1;

    if (startIndex <= endIndex) {
      return sublist(startIndex, endIndex + 1);
    } else {
      return <T>[];
    }
  }

  T? safeRemoveLast() {
    if (isEmpty) {
      return null;
    } else {
      return removeLast();
    }
  }
}

extension SecondsToCountdownTime on int? {
  // 转成倒计时
  String get secondsToCountdown {
    if (this == null || this == 0) {
      return "00:00";
    }

    int hours = (this! / 3600).floor();
    int minutes = ((this! % 3600) / 60).floor();
    int remainingSeconds = this! % 60;

    if (hours <= 0) {
      String minutesString = minutes.toString().padLeft(2, '0');
      String secondsString = remainingSeconds.toString().padLeft(2, '0');
      return '$minutesString:$secondsString';
    } else {
      String hoursString = hours.toString().padLeft(2, '0');
      String minutesString = minutes.toString().padLeft(2, '0');
      String secondsString = remainingSeconds.toString().padLeft(2, '0');
      return '$hoursString:$minutesString:$secondsString';
    }
  } // 转成倒计时

  String get millsecondsToCountdown {
    if (this == null || this == 0) {
      return "00:00";
    }

    int seconds = (this! / 1000).floor();
    int milliseconds = (this! % 900);
    String secondsString = seconds.toString().padLeft(2, '0');
    String millisecondsString = milliseconds.toString().padLeft(2, '0');
    return '$secondsString:$millisecondsString';
  }
}

extension doubleScale on double {
  double get scale {
    return TyTextScaler.instance().scale(this);
  }
}

/// 集合工具类：把常用的 List/Iterable 处理逻辑集中封装，便于复用（不依赖业务模型）
class CollectionTools {
  /// 分组：key 相同的元素放在同一个 List 里
  static Map<K, List<T>> groupBy<T, K>(
    Iterable<T> items,
    K Function(T item) keyOf,
  ) {
    final Map<K, List<T>> res = {};
    for (final item in items) {
      final key = keyOf(item);
      (res[key] ??= <T>[]).add(item);
    }
    return res;
  }

  /// 计数：统计每个 key 出现次数
  static Map<K, int> countBy<T, K>(
    Iterable<T> items,
    K Function(T item) keyOf,
  ) {
    final Map<K, int> res = {};
    for (final item in items) {
      final key = keyOf(item);
      res[key] = (res[key] ?? 0) + 1;
    }
    return res;
  }

  /// 去重：按 key 保留第一次出现的元素
  static List<T> distinctBy<T, K>(
    Iterable<T> items,
    K Function(T item) keyOf,
  ) {
    final seen = <K>{};
    final res = <T>[];
    for (final item in items) {
      final key = keyOf(item);
      if (seen.add(key)) res.add(item);
    }
    return res;
  }

  /// 切片：按固定 size 分块（size<=0 返回空）
  static List<List<T>> chunk<T>(List<T> items, int size) {
    if (size <= 0 || items.isEmpty) return const [];
    final res = <List<T>>[];
    for (int i = 0; i < items.length; i += size) {
      res.add(items.sublist(i, min(i + size, items.length)));
    }
    return res;
  }

  /// 切分：满足条件的和不满足条件的分别返回
  static ({List<T> matched, List<T> rest}) partition<T>(
    Iterable<T> items,
    bool Function(T item) test,
  ) {
    final matched = <T>[];
    final rest = <T>[];
    for (final item in items) {
      (test(item) ? matched : rest).add(item);
    }
    return (matched: matched, rest: rest);
  }

  /// 安全取值：越界返回 null
  static T? at<T>(List<T> items, int index) {
    if (index < 0 || index >= items.length) return null;
    return items[index];
  }

  /// 生成 0..len-1 的索引列表
  static List<int> indices(int len) {
    if (len <= 0) return const [];
    return List<int>.generate(len, (i) => i);
  }

  /// 插入分隔元素：把 [a,b,c] 变成 [a,sep,b,sep,c]
  static List<T> intersperse<T>(List<T> items, T separator) {
    if (items.length <= 1) return List<T>.from(items);
    final res = <T>[];
    for (int i = 0; i < items.length; i++) {
      if (i != 0) res.add(separator);
      res.add(items[i]);
    }
    return res;
  }

  /// Zip：按最短长度配对
  static List<R> zip2<A, B, R>(
    Iterable<A> a,
    Iterable<B> b,
    R Function(A a, B b) mapper,
  ) {
    final ia = a.iterator;
    final ib = b.iterator;
    final res = <R>[];
    while (ia.moveNext() && ib.moveNext()) {
      res.add(mapper(ia.current, ib.current));
    }
    return res;
  }

  /// 平铺：把二维列表合成一维（null/空会自动跳过）
  static List<T> flatten<T>(Iterable<Iterable<T>?> items) {
    final res = <T>[];
    for (final e in items) {
      if (e == null) continue;
      res.addAll(e);
    }
    return res;
  }

  /// 稳定排序：排序时保证相同 key 的元素维持原相对顺序
  static List<T> stableSortBy<T, K extends Comparable>(
    List<T> items,
    K Function(T item) keyOf, {
    bool ascending = true,
  }) {
    final indexed = <({int i, T v})>[];
    for (int i = 0; i < items.length; i++) {
      indexed.add((i: i, v: items[i]));
    }

    indexed.sort((a, b) {
      final ka = keyOf(a.v);
      final kb = keyOf(b.v);
      final cmp = ka.compareTo(kb);
      if (cmp != 0) return ascending ? cmp : -cmp;
      return a.i.compareTo(b.i);
    });

    return indexed.map((e) => e.v).toList();
  }
}

/// Iterable 扩展：补充一些常用遍历/过滤能力（不会和 SafeList 冲突）
extension IterableToolsX<T> on Iterable<T> {
  /// map 带索引
  Iterable<R> mapIndexed<R>(R Function(int index, T item) mapper) sync* {
    int i = 0;
    for (final e in this) {
      yield mapper(i, e);
      i++;
    }
  }

  /// where 带索引
  Iterable<T> whereIndexed(bool Function(int index, T item) test) sync* {
    int i = 0;
    for (final e in this) {
      if (test(i, e)) yield e;
      i++;
    }
  }

  /// 第一个满足条件的元素（找不到返回 null）
  T? firstWhereOrNull(bool Function(T item) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }

  /// 最后一个满足条件的元素（找不到返回 null）
  T? lastWhereOrNull(bool Function(T item) test) {
    T? res;
    for (final e in this) {
      if (test(e)) res = e;
    }
    return res;
  }

  /// 转 Map：key 冲突时后者覆盖前者
  Map<K, V> toMapBy<K, V>(
    K Function(T item) keyOf,
    V Function(T item) valueOf,
  ) {
    final res = <K, V>{};
    for (final e in this) {
      res[keyOf(e)] = valueOf(e);
    }
    return res;
  }

  /// 统计数量
  int countWhere(bool Function(T item) test) {
    int count = 0;
    for (final e in this) {
      if (test(e)) count++;
    }
    return count;
  }
}

/// List 扩展：更偏“修改/重排”的操作
extension ListToolsX<T> on List<T> {
  /// 切片（按 size 分块）
  List<List<T>> chunked(int size) => CollectionTools.chunk(this, size);

  /// 去重：按 key 保留第一次出现
  List<T> distinctBy<K>(K Function(T item) keyOf) =>
      CollectionTools.distinctBy(this, keyOf);

  /// 交换两个元素（越界不处理，返回是否成功）
  bool swap(int i, int j) {
    if (i < 0 || i >= length) return false;
    if (j < 0 || j >= length) return false;
    if (i == j) return true;
    final tmp = this[i];
    this[i] = this[j];
    this[j] = tmp;
    return true;
  }

  /// 移动元素：把 oldIndex 的元素移动到 newIndex
  bool move(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= length) return false;
    if (newIndex < 0 || newIndex >= length) return false;
    if (oldIndex == newIndex) return true;
    final item = removeAt(oldIndex);
    insert(newIndex, item);
    return true;
  }

  /// 安全替换：越界则不处理，返回是否成功
  bool replaceAt(int index, T value) {
    if (index < 0 || index >= length) return false;
    this[index] = value;
    return true;
  }

  /// 取一个随机元素（空返回 null）
  T? randomItem([Random? random]) {
    if (isEmpty) return null;
    final r = random ?? Random();
    return this[r.nextInt(length)];
  }
}
