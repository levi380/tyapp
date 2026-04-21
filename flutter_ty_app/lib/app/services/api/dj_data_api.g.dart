// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dj_data_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _DjDataApi implements DjDataApi {
  _DjDataApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiRes<List<DjDateEntityEntity>>> getDateMenuList(String csid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'csid': csid};
    final _options = _setStreamType<ApiRes<List<DjDateEntityEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/esports/getDateMenuList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<DjDateEntityEntity>> _value;
    try {
      _value = ApiRes<List<DjDateEntityEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> esportsMatches(
    String category,
    String csid,
    String cuid,
    String euid,
    String hpsFlag,
    String md,
    String sort,
    String type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'csid': csid,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/esportsMatches',
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
  Future<ApiRes<List<MatchEntity>>> collection(
    int collect,
    String csid,
    String cuid,
    String euid,
    String hpsFlag,
    String md,
    String sort,
    String type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'collect': collect,
      'csid': csid,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/escnh5',
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
  Future<ApiRes<List<MatchEntity>>> matchesPB(
    String category,
    String cuid,
    String euid,
    String hpsFlag,
    String md,
    String sort,
    String type,
  ) async {
    final _extra = <String, dynamic>{
      'retry_retryable': true,
      'retry_code': '0401038',
    };
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'sort': sort,
      'type': type,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchesPB',
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
  Future<ApiRes<int>> updateCollectMatches(
    String cuid,
    String euid,
    String device,
    int sort,
    int type,
    String csid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'device': device,
      'sort': sort,
      'type': type,
      'csid': csid,
    };
    final _options = _setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/escnCount',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<int> _value;
    try {
      _value = ApiRes<int>.fromJson(_result.data!);
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
