// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _AnalyzeDetailApi implements AnalyzeDetailApi {
  _AnalyzeDetailApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiRes<MatchPlaybackVideoInfoEntity>> playbackVideoUrl(
    String? mid,
    String? device,
    String? eventCode,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mid': mid,
      'device': device,
      'eventCode': eventCode,
    };
    _data.removeWhere((k, v) => v == null);
    final _options =
        _setStreamType<ApiRes<MatchPlaybackVideoInfoEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v1/w/playbackVideoUrlPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<MatchPlaybackVideoInfoEntity> _value;
    try {
      _value = ApiRes<MatchPlaybackVideoInfoEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeVSInfoEntity>>> vsInfo(
    String? mid,
    String? flag,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<AnalyzeVSInfoEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/statistics/vsInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeVSInfoEntity>> _value;
    try {
      _value = ApiRes<List<AnalyzeVSInfoEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>> vsInfoNew(
    String? mid,
    String? type,
    String? flag,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'flag': flag,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeVsInfoNewInfoEntity>> _value;
    try {
      _value = ApiRes<List<AnalyzeVsInfoNewInfoEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeVsInfoNewInfoTeamRankings>>> vsInfoCombined(
    String? mid,
    String? type,
    String? flag,
    String? t,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'flag': flag,
      r't': t,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<List<AnalyzeVsInfoNewInfoTeamRankings>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeVsInfoNewInfoTeamRankings>> _value;
    try {
      _value = ApiRes<List<AnalyzeVsInfoNewInfoTeamRankings>>.fromJson(
          _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeTeamVsHistoryEntity>>> teamVSHistory(
    String? mid,
    String? flag,
    String? cps,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<List<AnalyzeTeamVsHistoryEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/teamVSHistory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeTeamVsHistoryEntity>> _value;
    try {
      _value = ApiRes<List<AnalyzeTeamVsHistoryEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<StatisticsTeamVsOtherTeamEntity>> teamVsOtherTeam(
    String? mid,
    String? flag,
    String? cps,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'cps': cps,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<StatisticsTeamVsOtherTeamEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/teamVsOtherTeam',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<StatisticsTeamVsOtherTeamEntity> _value;
    try {
      _value = ApiRes<StatisticsTeamVsOtherTeamEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<Map<String, dynamic>>> getMatchAnalysiseData(
    String? parentMenuId,
    String? sonMenuId,
    String? standardMatchId,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'parentMenuId': parentMenuId,
      'sonMenuId': sonMenuId,
      'standardMatchId': standardMatchId,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData',
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
  Future<ApiRes<Map<String, dynamic>>> getKnockoutInfo({
    String? mid,
    String? stId,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'stId': stId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<Map<String, dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/statistics/knockoutInfo',
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
  Future<ApiRes<StatisticsFrontFightEntity>> getFrontFight(
      {String? mid}) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'mid': mid};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<StatisticsFrontFightEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/statistics/frontFightPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<StatisticsFrontFightEntity> _value;
    try {
      _value = ApiRes<StatisticsFrontFightEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<FrontFightPBBeanEntityElectronicFootballEntity>>>
      getFrontFightPBForElectronicFootball({String? mid}) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'mid': mid};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<
        ApiRes<List<FrontFightPBBeanEntityElectronicFootballEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/statisticsC01/frontFight',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<FrontFightPBBeanEntityElectronicFootballEntity>> _value;
    try {
      _value =
          ApiRes<List<FrontFightPBBeanEntityElectronicFootballEntity>>.fromJson(
              _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<HistoricalPerformancePBBeanEntity>>>
      getHistoricalPerformancePB({
    String? mid,
    String? flag,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mid': mid,
      'flag': flag,
    };
    _data.removeWhere((k, v) => v == null);
    final _options =
        _setStreamType<ApiRes<List<HistoricalPerformancePBBeanEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/historicalPerformance',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<HistoricalPerformancePBBeanEntity>> _value;
    try {
      _value = ApiRes<List<HistoricalPerformancePBBeanEntity>>.fromJson(
          _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<
          ApiRes<
              List<HistoricalPerformancePBBeanEntityElectronicFootballEntity>>>
      getHistoricalPerformancePBElectronicFootball({
    String? mid,
    String? flag,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mid': mid,
      'flag': flag,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<
            ApiRes<
                List<
                    HistoricalPerformancePBBeanEntityElectronicFootballEntity>>>(
        Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statisticsC01/historicalPerformance',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<HistoricalPerformancePBBeanEntityElectronicFootballEntity>>
        _value;
    try {
      _value = ApiRes<
              List<
                  HistoricalPerformancePBBeanEntityElectronicFootballEntity>>.fromJson(
          _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<SeasonStatsPBBeanEntity>>> getSeasonStatsPB({
    String? mid,
    String? flag,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'mid': mid,
      'flag': flag,
    };
    _data.removeWhere((k, v) => v == null);
    final _options =
        _setStreamType<ApiRes<List<SeasonStatsPBBeanEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/seasonStatsPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<SeasonStatsPBBeanEntity>> _value;
    try {
      _value = ApiRes<List<SeasonStatsPBBeanEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<OddReportAnalyzeDataEntity>> getMultipleOddsReportList({
    String? matchId,
    String? playId,
    String? sportId,
    String? matchType,
    String? marketValue,
    String? playType,
    String? period,
    String? oddsType,
    String? marketId,
    List<String>? dataSourceCodes,
    bool? isdy,
  }) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'matchId': matchId,
      'playId': playId,
      'sportId': sportId,
      'matchType': matchType,
      'marketValue': marketValue,
      'playType': playType,
      'period': period,
      'oddsType': oddsType,
      'marketId': marketId,
      'dataSourceCodes': dataSourceCodes,
      'isdy': isdy,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<OddReportAnalyzeDataEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/matchAnalysis/oddsReportData',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<OddReportAnalyzeDataEntity> _value;
    try {
      _value = ApiRes<OddReportAnalyzeDataEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<String>> addArticleCount(String? id) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<String>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/art/addArticleCount',
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
  Future<ApiRes<AnalyzeNewsEntity>> getArticle(
    String? matchId,
    String? type,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'matchId': matchId,
      r'type': type,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<AnalyzeNewsEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/art/getArticle',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<AnalyzeNewsEntity> _value;
    try {
      _value = ApiRes<AnalyzeNewsEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<AnalyzeArrayPersonEntity>> getMatchLineupList(
    String? matchInfoId,
    String? homeAway,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'matchInfoId': matchInfoId,
      r'homeAway': homeAway,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<AnalyzeArrayPersonEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/matchLineup/getMatchLineupList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<AnalyzeArrayPersonEntity> _value;
    try {
      _value = ApiRes<AnalyzeArrayPersonEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeNewsEntity>>> getFavoriteArticle(
    String? id,
    String? matchId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'matchId': matchId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<AnalyzeNewsEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/art/getFavoriteArticle',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeNewsEntity>> _value;
    try {
      _value = ApiRes<List<AnalyzeNewsEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<StatisticsTabSwitchEntity>> statisticsTabSwitch(
      String? mid) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'mid': mid};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<StatisticsTabSwitchEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/statistics/tabSwitch',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<StatisticsTabSwitchEntity> _value;
    try {
      _value = ApiRes<StatisticsTabSwitchEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchAnalyzeVsInfoEntity>>> vsInfoVersion3(
    String? mid,
    String? type,
    String? flag,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'flag': flag,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<List<MatchAnalyzeVsInfoEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<MatchAnalyzeVsInfoEntity>> _value;
    try {
      _value = ApiRes<List<MatchAnalyzeVsInfoEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>> vsInfoVersion2(
    String? mid,
    String? type,
    String? flag,
  ) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'flag': flag,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/vsInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<AnalyzeVsInfoNewInfoEntity>> _value;
    try {
      _value = ApiRes<List<AnalyzeVsInfoNewInfoEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<StatisticsTechnicalEntity>>> getTechnicalPBBasketBall(
      {String? mid}) async {
    final _extra = <String, dynamic>{'retry_retryable': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'mid': mid};
    _data.removeWhere((k, v) => v == null);
    final _options =
        _setStreamType<ApiRes<List<StatisticsTechnicalEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/statistics/technicalPB',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<StatisticsTechnicalEntity>> _value;
    try {
      _value = ApiRes<List<StatisticsTechnicalEntity>>.fromJson(_result.data!);
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
