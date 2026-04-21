class BackupQuickQueryOps {
  static void removeKeysByPrefix(Map<String, dynamic> map, String prefix) {
    final keys =
        map.keys.where((k) => k.startsWith(prefix)).toList(growable: false);
    for (final k in keys) {
      map.remove(k);
    }
  }

  static void removeMountPointsFromListToObj(
    Map<String, dynamic> listToObj,
    String prefix,
  ) {
    for (final value in listToObj.values) {
      if (value is Map<String, dynamic>) {
        removeKeysByPrefix(value, prefix);
      } else if (value is Map) {
        removeKeysByPrefix(
          value.cast<String, dynamic>(),
          prefix,
        );
      }
    }
  }
}
