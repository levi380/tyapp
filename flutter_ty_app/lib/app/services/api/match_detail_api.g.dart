// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _MatchDetailApi implements MatchDetailApi {
  _MatchDetailApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchDetail(
    String mid,
    String cuid,
    String init,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'cuid': cuid,
      r'init': init,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getMatchDetailPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<Map<String, dynamic>> _value;
    try {
      _value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchDetailW(
    String mid,
    String cuid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'cuid': cuid,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/matchDetail/getMatchDetailPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<Map<String, dynamic>> _value;
    try {
      _value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getESMatchDetail(
    String mid,
    String cuid,
    String init,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'cuid': cuid,
      r'init': init,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getESMatchDetail',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<Map<String, dynamic>> _value;
    try {
      _value = ApiRes<Map<String, dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<CategoryListData>>> getCategoryList(
    String sportId,
    String mid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'sportId': sportId,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<CategoryListData>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/category/getCategoryList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<CategoryListData>> _value;
    try {
      _value = ApiRes<List<CategoryListData>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<CategoryListData>>> getESCategoryList(
    String sportId,
    String mid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'sportId': sportId,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<CategoryListData>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/category/getESCategoryList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<CategoryListData>> _value;
    try {
      _value = ApiRes<List<CategoryListData>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<CategoryListData>>> getESWCategoryList(
    String sportId,
    String mid, {
    String? type,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'sportId': sportId,
      r'mid': mid,
      r'type': type,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<CategoryListData>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/category/getESCategoryList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<CategoryListData>> _value;
    try {
      _value = ApiRes<List<CategoryListData>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> getMatchDetailByTournamentId(
    String tId,
    num? type,
    String? dateTime,
    String? isESport,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'tId': tId,
      r'type': type,
      r'dateTime': dateTime,
      r'isESport': isESport,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getMatchDetailByTournamentIdPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<MatchEntity>> _value;
    try {
      _value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getMatchOddsInfo1(
    String mcid,
    String mid,
    String cuid,
    int newUser,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'newUser': newUser,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getMatchOddsInfo1PB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<dynamic>> _value;
    try {
      _value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getESMatchOddsInfo(
    String mcid,
    String mid,
    String cuid, {
    int? showType,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'showType': showType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getESMatchOddsInfoPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<dynamic>> _value;
    try {
      _value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getVirtualMatchOddsInfo(
    String mcid,
    String mid,
    String cuid, {
    int? showType,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'showType': showType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getVirtualMatchOddsInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<dynamic>> _value;
    try {
      _value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getVirtualMatchResult(
    String mcid,
    String mid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getVirtualMatchResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<dynamic>> _value;
    try {
      _value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<DetailVideoEntity>> getDetailVideo(
    String sm,
    String euid,
    String csid,
    String tid,
    String sort,
    String keyword,
    String cuid,
    String mid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'sm': sm,
      r'euid': euid,
      r'csid': csid,
      r'tid': tid,
      r'sort': sort,
      r'keyword': keyword,
      r'cuid': cuid,
      r'mid': mid,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<DetailVideoEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/getDetailVideo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<DetailVideoEntity> _value;
    try {
      _value = ApiRes<DetailVideoEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<LiveVideoUrlEntity> liveVideoUrl(
    String device,
    String mid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'device': device,
      'mid': mid,
    };
    final _options = _setStreamType<LiveVideoUrlEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/liveVideoUrl',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late LiveVideoUrlEntity _value;
    try {
      _value = LiveVideoUrlEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<VideoAnimationUrlEntity>> getVideoAnimationUrl(
    String type,
    String mid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'type': type,
      'mid': mid,
    };
    final _options = _setStreamType<ApiRes<VideoAnimationUrlEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/videoAnimationUrl',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<VideoAnimationUrlEntity> _value;
    try {
      _value = ApiRes<VideoAnimationUrlEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> setPlayTop(
    String status,
    String playId,
    String matchId,
    String cuid,
    String topKey,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'status': status,
      r'playId': playId,
      r'matchId': matchId,
      r'cuid': cuid,
      r'topKey': topKey,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/category/playTop',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ApiRes<List<PlayTopEntity>>> findPlayTop() async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<PlayTopEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/category/findPlayTop',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<PlayTopEntity>> _value;
    try {
      _value = ApiRes<List<PlayTopEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<OutrightDisplayMatchsEntity>> getOutrightDisplayMatchs(
    String tid,
    String cuid,
    String euid,
    String sportId,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'tid': tid,
      'cuid': cuid,
      'euid': euid,
      'sportId': sportId,
    };
    final _options =
        _setStreamType<ApiRes<OutrightDisplayMatchsEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/m/getMobileOutrightDisplayMatchs',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<OutrightDisplayMatchsEntity> _value;
    try {
      _value = ApiRes<OutrightDisplayMatchsEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
