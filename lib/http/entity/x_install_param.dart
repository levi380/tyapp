import 'dart:convert';

/// channelCode : "渠道编号"
/// data : {"co":{},"uo":{"ic":"自定义value1"}} 或嵌套的 JSON 字符串

class XInstallParam {
  XInstallParam({
    this.channelCode,
    this.data,
    this.bindData,
    this.timeSpan,
    this.isFirstFetch,
  });

  /// [raw] 为 Map 或已 decode 的对象；若为 String 则先 jsonDecode
  static Map<String, dynamic>? _parseDataField(dynamic raw) {
    if (raw == null) return null;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    if (raw is String) {
      if (raw.isEmpty) return null;
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  XInstallParam.fromJson(dynamic json) {
    channelCode = json['channelCode']?.toString();
    final dataMap = _parseDataField(json['data']);
    data = dataMap != null ? Data.fromJson(dataMap) : null;
    final bindMap = _parseDataField(json['bindData']);
    bindData = bindMap != null ? Data.fromJson(bindMap) : null;
    timeSpan = json['timeSpan']?.toString();

    isFirstFetch = json['isFirstFetch'] is bool
        ? json['isFirstFetch'] as bool
        : json['isFirstFetch']?.toString() == 'true';
  }

  String? channelCode;
  Data? data;
  Data? bindData;
  String? timeSpan;
  bool? isFirstFetch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['channelCode'] = channelCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (bindData != null) {
      map['bindData'] = bindData?.toJson();
    }
    map['timeSpan'] = timeSpan;
    map['isFirstFetch'] = isFirstFetch;
    return map;
  }
}

/// co : {}
/// uo : {"ic":"自定义value1"}

class Data {
  Data({
    this.co,
    this.uo,
  });

  Data.fromJson(dynamic json) {
    co = json['co'];
    uo = json['uo'] != null ? Uo.fromJson(json['uo']) : null;
  }

  dynamic co;
  Uo? uo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['co'] = co;
    if (uo != null) {
      map['uo'] = uo?.toJson();
    }
    return map;
  }
}

/// ic : "自定义value1"

class Uo {
  Uo({
    this.ic,
  });

  Uo.fromJson(dynamic json) {
    final v = json['ic'];
    ic = v == null ? null : v.toString();
  }

  String? ic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ic'] = ic;
    return map;
  }
}
