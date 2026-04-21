// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _MatchApi implements MatchApi {
  _MatchApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ChampionMatchResultEntity> championMatchResults(
    String euid,
    int type,
    int orderBy,
    int category,
    String startTime,
    String endTime,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'euid': euid,
      r'type': type,
      r'orderBy': orderBy,
      r'category': category,
      r'startTime': startTime,
      r'endTime': endTime,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ChampionMatchResultEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/championMatchResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ChampionMatchResultEntity _value;
    try {
      _value = ChampionMatchResultEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<FireworksActivityEntity>>> getFireworksActivity(
      String requestid) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'requestid': requestid};
    final _options =
        _setStreamType<ApiRes<List<FireworksActivityEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu12/fireworksActivity/getFireworksActivity',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<FireworksActivityEntity>> _value;
    try {
      _value = ApiRes<List<FireworksActivityEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<dynamic> getUserPlayInfo(
    String requestid,
    String id,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'requestid': requestid,
      'id': id,
    };
    final _options = _setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/fireworksActivity/getUserPlayInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch(_options);
    final _value = _result.data;
    return _value;
  }

  @override
  Future<dynamic> saveUserPlayInfo(
    String id,
    String isPlayed,
    String requestid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'id': id,
      'isPlayed': isPlayed,
      'requestid': requestid,
    };
    final _options = _setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/fireworksActivity/saveUserPlayInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch(_options);
    final _value = _result.data;
    return _value;
  }

  @override
  Future<EventInfo2Entity> getEventInfo() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<EventInfo2Entity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/eventInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EventInfo2Entity _value;
    try {
      _value = EventInfo2Entity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matchesCollectNewH5(
    String cuid,
    String euid,
    int sort,
    int type, [
    String? device = 'v2_h5_st',
    String? md = null,
  ]) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'sort': sort,
      'type': type,
      'device': device,
      'md': md,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchesCollectNewH5V2PB',
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
  Future<ApiRes<Map<String, dynamic>>> getUserPersonaliseNew(
    List<dynamic> paramKey,
    String uid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'paramKey': paramKey,
      'uid': uid,
    };
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/user/getUserPersonaliseNew',
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
  Future<ApiRes<String>> setUserPersonaliseNew(
    String uid,
    List<dynamic> userPersonaliseNewList,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'uid': uid,
      'userPersonaliseNewList': userPersonaliseNewList,
    };
    final _options = _setStreamType<ApiRes<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/user/setUserPersonaliseNew',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<String> _value;
    try {
      _value = ApiRes<String>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<String>> setUserTimeZonePersonaliseNew(
    String uid,
    Map<dynamic, dynamic> userParams,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'uid': uid,
      'userParams': userParams,
    };
    final _options = _setStreamType<ApiRes<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/user/setUserPersonaliseNew',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<String> _value;
    try {
      _value = ApiRes<String>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<Map<String, CollectionInfo?>>> collectMatches(
    int matchType,
    String cuid,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'matchType': matchType,
      'cuid': cuid,
    };
    final _options =
        _setStreamType<ApiRes<Map<String, CollectionInfo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/collectMatches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<Map<String, CollectionInfo?>> _value;
    try {
      _value = ApiRes<Map<String, CollectionInfo>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResN<List<MatchEntity>>> getMatchBaseInfo(
    String mids,
    String? cuid,
    int sort,
    String? euid,
    String device,
    String? pids,
    String? isUser,
    int? playId,
    int? scroll,
    List<dynamic> tabs,
  ) async {
    final _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1000,
    };
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mids': mids,
      'cuid': cuid,
      'sort': sort,
      'euid': euid,
      'device': device,
      'pids': pids,
      'is_user': isUser,
      'playId': playId,
      'scroll': scroll,
      'tabs': tabs,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResN<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getMatchBaseInfoByMidsPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResN<List<MatchEntity>> _value;
    try {
      _value = ApiResN<List<MatchEntity>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                .map<MatchEntity>(
                    (i) => MatchEntity.fromJson(i as Map<String, dynamic>))
                .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<MatchBaseInfoEntity>> getMatchBaseInfoWithTabs(
    String mids,
    String? cuid,
    int sort,
    String? euid,
    String device,
    String? pids,
    String? isUser,
    int? playId, {
    required List<dynamic> tabs,
  }) async {
    final _extra = <String, dynamic>{
      'retry_retryable': true,
      'throttle_able': true,
      'throttle_durtion': 1000,
    };
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mids': mids,
      'cuid': cuid,
      'sort': sort,
      'euid': euid,
      'device': device,
      'pids': pids,
      'is_user': isUser,
      'playId': playId,
      'tabs': tabs,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<MatchBaseInfoEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getMatchBaseInfoByMidsPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<MatchBaseInfoEntity> _value;
    try {
      _value = ApiRes<MatchBaseInfoEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matches(MatchListReq req) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
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
    int sort,
    int type,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'sort': sort,
      'type': type,
    };
    final _options = _setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchesCollectNewH5Count',
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

  @override
  Future<ApiRes<int>> addOrCancelMatch(
    String cuid,
    String mid,
    int cf, {
    int? dota2,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'mid': mid,
      'cf': cf,
      'dota2': dota2,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/userCollection/addOrCancelMatch',
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

  @override
  Future<ApiRes<int>> addOrCancelTournament(
    String cuid,
    String tid,
    int cf, {
    int? dota2,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'tid': tid,
      'cf': cf,
      'dota2': dota2,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/userCollection/addOrCancelTournament',
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

  @override
  Future<ApiRes<int>> addOrCancelTournamentGuanjun(
    String cuid,
    String mid,
    int cf, {
    int? dota2,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'mid': mid,
      'cf': cf,
      'dota2': dota2,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<int>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/userCollection/addOrCancelTournament',
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

  @override
  Future<ApiRes<AddedOddsMatchesEntity>> getAllAddedOddsMatches(
    String cuid,
    String euid,
    String sportId,
    String sort,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'sportId': sportId,
      'sort': sort,
    };
    final _options = _setStreamType<ApiRes<AddedOddsMatchesEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getAllAddedOddsMatchesPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<AddedOddsMatchesEntity> _value;
    try {
      _value = ApiRes<AddedOddsMatchesEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<dynamic>> leagueTopPB({
    required String cuid,
    required int status,
    String? tId,
    String? matchId,
    required int menuId,
    required int mType,
    required String mLeve3,
    required int h5Collect,
    int? matchType,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'status': status,
      'tId': tId,
      'matchId': matchId,
      'menuId': menuId,
      'mType': mType,
      'mLeve3': mLeve3,
      'h5Collect': h5Collect,
      'matchType': matchType,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/leagueTopPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<dynamic> _value;
    try {
      _value = ApiRes<dynamic>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> findTopMatchsPB({
    required int menuId,
    required int mType,
    required String md,
    required String mLeve3,
    required int h5Collect,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'menuId': menuId,
      'mType': mType,
      'md': md,
      'mLeve3': mLeve3,
      'h5Collect': h5Collect,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/findTopMatchsPB',
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
  Future<ApiRes<PinInfoEntity>> findTopIdsPB({
    required int menuId,
    required int mType,
    required String mLeve3,
    required int h5Collect,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'menuId': menuId,
      'mType': mType,
      'mLeve3': mLeve3,
      'h5Collect': h5Collect,
    };
    final _options = _setStreamType<ApiRes<PinInfoEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/findTopIds',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<PinInfoEntity> _value;
    try {
      _value = ApiRes<PinInfoEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<MatchEsportEntity>> matchesNew(
      {required MatchListReq req}) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<ApiRes<MatchEsportEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchesNewPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<MatchEsportEntity> _value;
    try {
      _value = ApiRes<MatchEsportEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> structureLiveMatches({
    required String cuid,
    required int euid,
    required int type,
    required int sort,
    required int orpt,
    required int apiType,
    required int hotMatches,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'type': type,
      'sort': sort,
      'orpt': orpt,
      'apiType': apiType,
      'hotMatches': hotMatches,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/structureLiveMatchesPB',
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
  Future<ApiRes<DiscountOddEntity>> getAddedOddsMatches({
    required String cuid,
    required String euid,
    required String sportId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'sportId': sportId,
    };
    final _options = _setStreamType<ApiRes<DiscountOddEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getAddedOddsMatches',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<DiscountOddEntity> _value;
    try {
      _value = ApiRes<DiscountOddEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<GetOddCountBeanEntity>> getQueryBetCount(
      {required List<dynamic> paramList}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'paramList': paramList};
    final _options = _setStreamType<ApiRes<GetOddCountBeanEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/query/queryBetCount',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<GetOddCountBeanEntity> _value;
    try {
      _value = ApiRes<GetOddCountBeanEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<MatchAllEntity>> getAllInPlayMatchList({
    required String cuid,
    required String euid,
    required int type,
    required int sort,
    String device = 'v2_h5_st',
    int hpsFlag = 1,
    int category = 1,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'euid': euid,
      'type': type,
      'sort': sort,
      'device': device,
      'hpsFlag': hpsFlag,
      'category': category,
    };
    final _options = _setStreamType<ApiRes<MatchAllEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/getAllInPlayMatchListPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<MatchAllEntity> _value;
    try {
      _value = ApiRes<MatchAllEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<Map<String, dynamic>>>> getKeywordList(
    String? sportId,
    int mType,
    String? md,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'sportId': sportId,
      r'mType': mType,
      r'md': md,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<Map<String, dynamic>>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/keyword/selectKeywordListMobile',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<Map<String, dynamic>>> _value;
    try {
      _value = ApiRes<List<Map<String, dynamic>>>.fromJson(_result.data!);
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
