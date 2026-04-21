
List<dynamic> toList(dynamic json) {
  if (json is List) {
    // 如果是 List，直接返回
    return json;
  } else if (json is Map) {
    // 如果是 Map，将其转换为 List<MapEntry>
    return [json];
  } else {
    // 其他情况返回空 List
    return [];
  }
}