import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class BackupValueReaders {
  static String? readMid(dynamic match) {
    if (match == null) return null;
    if (match is Map) {
      final mid = match['mid'];
      return mid?.toString();
    }
    if (match is MatchEntity) {
      return match.mid;
    }
    return null;
  }

  static Map<String, dynamic>? readMatchMap(dynamic match) {
    if (match == null) return null;
    if (match is Map<String, dynamic>) return match;
    if (match is Map) return Map<String, dynamic>.from(match);
    if (match is MatchEntity) return match.toJson();
    return null;
  }

  static List<dynamic> readHpsList(Map<String, dynamic> matchMap) {
    final oddsInfo = matchMap['odds_info'];
    if (oddsInfo is List) return oddsInfo;
    final hps = matchMap['hps'];
    if (hps is List) return hps;
    return const [];
  }

  static List<dynamic> readHlList(dynamic hps) {
    if (hps is Map) {
      final hl = hps['hl'];
      if (hl is List) return hl;
      final hls = hps['hls'];
      if (hls is List) return hls;
      if (hl is Map) return [hl];
      return const [];
    }
    if (hps is MatchHps) {
      return hps.hl;
    }
    return const [];
  }

  static List<dynamic> readOlList(dynamic hl) {
    if (hl is Map) {
      final ol = hl['ol'];
      if (ol is List) return ol;
      return const [];
    }
    if (hl is MatchHpsHl) {
      return hl.ol;
    }
    return const [];
  }

  static String? readHid(dynamic hl) {
    if (hl == null) return null;
    if (hl is Map) {
      final hid = hl['hid'];
      return hid?.toString();
    }
    if (hl is MatchHpsHl) {
      return hl.hid;
    }
    return null;
  }

  static String? readOid(dynamic ol) {
    if (ol == null) return null;
    if (ol is Map) {
      final oid = ol['oid'];
      return oid?.toString();
    }
    if (ol is MatchHpsHlOl) {
      return ol.oid;
    }
    return null;
  }

  static int? readHn(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    if (value is Map) {
      final hn = value['hn'];
      return readHn(hn);
    }
    if (value is MatchHpsHl) {
      return value.hn;
    }
    return null;
  }
}
