import 'backup_value_readers.dart';

class BackupQuickQueryIndexBuilder {
  BackupQuickQueryIndexBuilder({
    required this.keyBuilder,
  });

  final String Function(String mid, String id, String type) keyBuilder;

  Map<String, dynamic> buildManyObj(List<dynamic> matches, int timestamp) {
    final Map<String, dynamic> manyObj = {
      'ol_obj': <String, dynamic>{},
      'hl_obj': <String, dynamic>{},
      'hn_obj': <String, dynamic>{},
      'mid_obj': <String, dynamic>{},
    };

    final Map<String, dynamic> midObj =
        manyObj['mid_obj'] as Map<String, dynamic>;
    final Map<String, dynamic> hlObj = manyObj['hl_obj'] as Map<String, dynamic>;
    final Map<String, dynamic> olObj = manyObj['ol_obj'] as Map<String, dynamic>;
    final Map<String, dynamic> hnObj = manyObj['hn_obj'] as Map<String, dynamic>;

    for (final match in matches) {
      final mid = BackupValueReaders.readMid(match);
      if (mid == null || mid.isEmpty) continue;

      final matchMap = BackupValueReaders.readMatchMap(match);
      if (matchMap == null) continue;

      matchMap['_upd_time'] = timestamp;
      midObj[keyBuilder(mid, mid, 'mid')] = matchMap;

      final hpsList = BackupValueReaders.readHpsList(matchMap);
      for (final hps in hpsList) {
        final hlList = BackupValueReaders.readHlList(hps);
        for (final hl in hlList) {
          final hid = BackupValueReaders.readHid(hl);
          if (hid == null || hid.isEmpty) continue;

          if (hl is Map) {
            hl['_upd_time'] = timestamp;
          }
          hlObj[keyBuilder(mid, hid, 'hl')] = hl;

          final hn = BackupValueReaders.readHn(hl);
          if (hn != null && hn != 0) {
            hnObj[keyBuilder(mid, hn.toString(), 'hn')] = hl;
          }

          final olList = BackupValueReaders.readOlList(hl);
          for (final ol in olList) {
            final oid = BackupValueReaders.readOid(ol);
            if (oid == null || oid.isEmpty) continue;
            if (ol is Map) {
              ol['_upd_time'] = timestamp;
            }
            olObj[keyBuilder(mid, oid, 'ol')] = ol;
          }
        }
      }
    }

    return manyObj;
  }
}

