class BackupDeepClear {
  static void clear(dynamic value) {
    if (value == null) return;

    if (value is Map) {
      final keys = value.keys.toList(growable: false);
      for (final key in keys) {
        final v = value[key];
        clear(v);
        value.remove(key);
      }
      return;
    }

    if (value is List) {
      for (final item in value) {
        clear(item);
      }
      value.clear();
    }
  }
}
