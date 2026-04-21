/// 通用的按日期分组方法
List<List<T>> groupRecordsByDate<T>(
  List<T> records,
  int Function(T) getCreatedAt,
) {
  if (records.isEmpty) return [];

  // 按照本地日历日期分组，避免时区问题
  final Map<DateTime, List<T>> groupedRecords = {};
  for (var item in records) {
    final createdAtMillis = getCreatedAt(item);
    final date = DateTime.fromMillisecondsSinceEpoch(createdAtMillis);
    final dateKey = DateTime(date.year, date.month, date.day);
    groupedRecords.putIfAbsent(dateKey, () => []).add(item);
  }

  // 按日期倒序排列
  final sortedKeys = groupedRecords.keys.toList()
    ..sort((a, b) => b.compareTo(a));

  final list = sortedKeys.map((key) => groupedRecords[key]!).toList();
  return list;
}
