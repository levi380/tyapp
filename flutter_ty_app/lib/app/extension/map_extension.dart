extension MapExtensions on Map<String, dynamic> {
  dynamic get(String keyPath) {
    List<String> keys = keyPath.split('.');
    dynamic value = this;

    for (var key in keys) {
      if (value is Map<String, dynamic>) {
        value = value[key];
      } else if (value is List<dynamic> &&
          key.contains('[') &&
          key.contains(']')) {
        var index =
            int.parse(key.substring(key.indexOf('[') + 1, key.indexOf(']')));
        value = value[index];
      } else {
        return null;
      }
    }

    return value;
  }

  T? safe<T>(dynamic key) {
    if (containsKey(key)) {
      return this[key] as T;
    }
    return null;
  }
}

/// JSON读取工具类：用于从 Map<String, dynamic> 中安全读取各种类型，并支持 keyPath（a.b[0].c）
class JsonReader {
  JsonReader(this._json);

  final Map<String, dynamic>? _json;

  /// 读取原始值（支持 keyPath）
  dynamic raw(String keyPath) => _readKeyPath(_json, keyPath);

  /// 读取 String（会做 trim，可设置默认值）
  String string(String keyPath, {String defaultValue = ''}) {
    final v = raw(keyPath);
    if (v == null) return defaultValue;
    if (v is String) return v.trim();
    return v.toString().trim();
  }

  /// 读取 String?（空字符串会返回 null）
  String? stringOrNull(String keyPath) {
    final s = string(keyPath);
    return s.isEmpty ? null : s;
  }

  /// 读取 int（支持 num / String / bool）
  int intValue(String keyPath, {int defaultValue = 0}) {
    final v = raw(keyPath);
    if (v == null) return defaultValue;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is bool) return v ? 1 : 0;
    if (v is String) {
      final s = v.trim();
      final i = int.tryParse(s);
      if (i != null) return i;
      final d = double.tryParse(s);
      if (d != null) return d.toInt();
      return defaultValue;
    }
    return defaultValue;
  }

  /// 读取 double（支持 num / String / bool）
  double doubleValue(String keyPath, {double defaultValue = 0}) {
    final v = raw(keyPath);
    if (v == null) return defaultValue;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    if (v is bool) return v ? 1.0 : 0.0;
    if (v is String) {
      final d = double.tryParse(v.trim());
      return d ?? defaultValue;
    }
    return defaultValue;
  }

  /// 读取 num
  num numValue(String keyPath, {num defaultValue = 0}) {
    final v = raw(keyPath);
    if (v == null) return defaultValue;
    if (v is num) return v;
    if (v is bool) return v ? 1 : 0;
    if (v is String) {
      final n = num.tryParse(v.trim());
      return n ?? defaultValue;
    }
    return defaultValue;
  }

  /// 读取 bool（支持 bool / num / String: true/false/1/0）
  bool boolValue(String keyPath, {bool defaultValue = false}) {
    final v = raw(keyPath);
    if (v == null) return defaultValue;
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.trim().toLowerCase();
      if (s == 'true' || s == 't' || s == 'yes' || s == 'y') return true;
      if (s == 'false' || s == 'f' || s == 'no' || s == 'n') return false;
      final i = int.tryParse(s);
      if (i != null) return i != 0;
      return defaultValue;
    }
    return defaultValue;
  }

  /// 读取 Map（类型不匹配会返回 null）
  Map<String, dynamic>? map(String keyPath) {
    final v = raw(keyPath);
    return v is Map<String, dynamic> ? v : null;
  }

  /// 读取 List（类型不匹配会返回空 List）
  List<dynamic> list(String keyPath) {
    final v = raw(keyPath);
    return v is List ? v : const [];
  }

  /// 读取 String List（会过滤 null，并做 toString + trim）
  List<String> stringList(String keyPath, {bool removeEmpty = true}) {
    final v = list(keyPath);
    final res = <String>[];
    for (final e in v) {
      if (e == null) continue;
      final s = e.toString().trim();
      if (removeEmpty && s.isEmpty) continue;
      res.add(s);
    }
    return res;
  }

  /// 读取 int List（支持 num / String）
  List<int> intList(String keyPath) {
    final v = list(keyPath);
    final res = <int>[];
    for (final e in v) {
      if (e == null) continue;
      if (e is int) {
        res.add(e);
        continue;
      }
      if (e is num) {
        res.add(e.toInt());
        continue;
      }
      if (e is String) {
        final i = int.tryParse(e.trim());
        if (i != null) res.add(i);
      }
    }
    return res;
  }

  /// 读取 DateTime（支持毫秒/秒时间戳、ISO8601 字符串）
  DateTime? dateTime(String keyPath, {bool isUtc = false}) {
    final v = raw(keyPath);
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is num) {
      final n = v.toInt();
      final ms = n < 10000000000 ? n * 1000 : n;
      return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    }
    if (v is String) {
      final s = v.trim();
      final asNum = num.tryParse(s);
      if (asNum != null) {
        final n = asNum.toInt();
        final ms = n < 10000000000 ? n * 1000 : n;
        return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
      }
      final dt = DateTime.tryParse(s);
      if (dt == null) return null;
      return isUtc ? dt.toUtc() : dt.toLocal();
    }
    return null;
  }

  /// 读取 Duration（单位毫秒；支持 num / String）
  Duration durationMs(String keyPath, {Duration defaultValue = Duration.zero}) {
    final ms = intValue(keyPath, defaultValue: defaultValue.inMilliseconds);
    return Duration(milliseconds: ms);
  }

  /// 读取 Uri（不合法则返回 null）
  Uri? uri(String keyPath) {
    final s = stringOrNull(keyPath);
    if (s == null) return null;
    return Uri.tryParse(s);
  }

  /// 读取枚举：通过自定义映射函数把原始值映射成枚举
  T? enumValue<T>(
    String keyPath,
    T? Function(dynamic raw) mapper,
  ) {
    final v = raw(keyPath);
    return mapper(v);
  }

  static dynamic _readKeyPath(Map<String, dynamic>? json, String keyPath) {
    if (json == null) return null;
    if (keyPath.isEmpty) return null;

    final keys = keyPath.split('.');
    dynamic value = json;

    for (final key in keys) {
      if (value is Map<String, dynamic>) {
        value = value[key];
        continue;
      }

      if (value is List<dynamic> && key.contains('[') && key.contains(']')) {
        final left = key.indexOf('[');
        final right = key.indexOf(']');
        if (left < 0 || right <= left) return null;
        final indexStr = key.substring(left + 1, right);
        final index = int.tryParse(indexStr);
        if (index == null || index < 0 || index >= value.length) return null;
        value = value[index];
        continue;
      }

      return null;
    }

    return value;
  }
}

/// 便捷入口：map.reader.string('a.b')
extension JsonReaderX on Map<String, dynamic> {
  JsonReader get reader => JsonReader(this);
}
