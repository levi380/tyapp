import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

extension VrVideoUrl on VrSportReplayDetailValue? {
  String get formattedPlayUrl {
    final url = this?.thirdMatchVideoUrl ?? '';
    AppLogger.debug('formattedPlayUrl thirdMatchVideoUrl: $url');
    if (url.isEmpty) return '';

    AppLogger.debug('formattedPlayUrl oriUrl: $url');

    String mimeType = url.mimeType;
    AppLogger.debug('formattedPlayUrl mimeType: $mimeType');
    if (mimeType.isEmpty) return url;

    final urlSplit = url.split(mimeType);
    final first = urlSplit.firstOrNull ?? '';
    AppLogger.debug('formattedPlayUrl first: $first');
    if (first.isEmpty) return url;

    final formattedUrl = first + mimeType;
    AppLogger.debug('formattedPlayUrl formattedUrl: $formattedUrl');
    return formattedUrl;
  }

  String formattedPlayUrlWith(int type) {
    if (type == 2) return this?.thirdMatchVideoUrl ?? '';
    return formattedPlayUrl;
  }
}

extension _UrlMimeType on String? {
  String get mimeType {
    final url = this ?? '';
    if (url.contains('.m3u8')) {
      return '.m3u8';
    } else if (url.contains('.flv')) {
      return '.flv';
    } else if (url.contains('.mp4')) {
      return '.mp4';
    }
    return '';
  }
}
