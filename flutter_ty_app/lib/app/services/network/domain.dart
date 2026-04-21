import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import '../../db/app_cache.dart';
import '../../global/ws/ws_app.dart';
import '../../modules/sdk_home/sdk_home_controller.dart';
import '../models/res/user_info.dart';
import 'app_dio.dart';
import '../models/domain_model.dart';
import 'domain.part.dart';

/// ***  4.10 针对app架构调整 ****
/// 参数域名 拼接 oss/prod.json oss兜底操作（域名能访问，则oss一定能访问得到）app不在访问本地oss目录下资源
/// todo 根据商户标识 merchantLabel 缓存 userinfo接口实体


// 创建domai 实例
//AllDomain domainInstance = AllDomain();

class AllDomain {
  // AllDomain() {
  //   BUILDIN_CONFIG['DOMAIN_RESULT'] = DOMAIN_RESULT;
  // }
  AllDomain._internal(){
    BUILDIN_CONFIG['DOMAIN_RESULT'] = DOMAIN_RESULT;
  }
  static final AllDomain _domainInstance = AllDomain._internal();
  factory AllDomain.instance() => _domainInstance;

  static const Duration timeout3 = Duration(seconds: 3);
  static const Duration timeout5 = Duration(seconds: 5);
  static const Duration tmeout30 = Duration(seconds: 30);

  // 是否使用跳转链接的api参数
  // 当oss文件的域名很慢时 打开此开关
  bool useApi = true;

  // 跳转链接解析参数的map
  UrlModel urlParams = UrlModel();

  // url 是否有参数
  bool hasToken = false;

  // toppic定时器
  var timer_toppic_fast = null;

  /* init方法中初始化字段 */
  // 是否首次加载页面
  bool loaded = false;

  // url 内的api 解析后的 数据
  var url_api = null;

  // 最快的oss url地址返回的数据
  var oss_file_content = null;

  // oss file 文件内的 api 配置
  List oss_file_api = [];

  //  当前计算后的前端本地 api 池子
  var local_api_pool = [];

  Function create_callback = () {};

  // 域名计算  本地存错 挂载键
  // String DOMAIN_API_STORAGE_KEY = DOMAIN_API_STORAGE_KEY;
  // getuserinfo接口 内的 oss  配置 内的 oss
  OssObj GETUSERINFO_OSS = OssObj();

  // 合并 oss 文件内的 api配置 到 最终的 前端 本地 域名池子  开关
  bool MERGE_OSS_FILE_TO_LOCAL_API_POOL = true;

  // 合并 前端本地旧的   api配置 到 最终的 前端 本地 域名池子  开关
  bool MERGE_OLD_LOCAL_API_TO_LOCAL_API_POOL = true;

  //  getuserinfo  内的 oss 下的 api 数组 是强制的 必须 做为最基础数据 依据的  因此不提供开关。
  //  url 内的 api 参数内的数组  正常是  getuserinfo  内的 oss 下的 api 数组 的 子集 ，
  //  但是在用户试用期间， getuserinfo  内的 oss 下的 api 数组 可能 会变更，因此 理论上 每次页面主动或者被动调用 getuserinfo 都需要写入进来，存储到本地
  // 当前的 流程  ： 流程1   use_url_api 或者 流程2   use_oss_file_api
  String current_api_flow = "use_oss_file_api";

  // 最大的 本地域名池子数量上限
  var LOCAL_API_POOL_MAX = 10;

  // 记录到本地域名池子内的api 的过期时间，超过此时间的api 需要 在 再次刷新本地 域名池的时候 清理掉
  var LOCAL_API_EXPIRATION_TIME = 30 * 24 * 60 * 1000;

  // 每次不论是 如何去检测  API 接口的 ，只要那个API 可用 ，就刷新这个 API 的创建时间 到当时的检测通过时间，相当于加长这个域名在域名池的理论存活时间
  // 当 走 url 内 api 流程 出错是否 去掉api 参数并强制刷新页面去 走  oss 文件流程，也可以不刷新，静默切换流程
  bool force_reload_to_use_oss_file_api = false;

  //oss 文件内 视频播放地址
  String live_domains_oss_path_file = 'live_domains.h5';

  //api  内 视频播放地址
  String live_domains_oss_path_api = 'live_h5';

  List oss_urls = [];
  static const DECRYPT_KEY = "panda1234_1234ob";
  static const DECRYPT_KEY_URL_API = "OBTY20220712OBTY";

  late UserInfo? userInfo;

  SdkTyHomeController? sdkTyHomeController;

  init(){
    // 是否使用跳转链接的api参数
    // 当oss文件的域名很慢时 打开此开关
    useApi = true;

    // 跳转链接解析参数的map
    urlParams = UrlModel();

    // url 是否有参数
    hasToken = false;

    // toppic定时器
    timer_toppic_fast = null;

    /* init方法中初始化字段 */
    // 是否首次加载页面
    loaded = false;

    // url 内的api 解析后的 数据
    url_api = null;

    // 最快的oss url地址返回的数据
    oss_file_content = null;

    // oss file 文件内的 api 配置
    oss_file_api = [];

    //  当前计算后的前端本地 api 池子
    local_api_pool = [];

    create_callback = () {};

    // 域名计算  本地存错 挂载键
    // String DOMAIN_API_STORAGE_KEY = DOMAIN_API_STORAGE_KEY;
    // getuserinfo接口 内的 oss  配置 内的 oss
    GETUSERINFO_OSS = OssObj();

    // 合并 oss 文件内的 api配置 到 最终的 前端 本地 域名池子  开关
    MERGE_OSS_FILE_TO_LOCAL_API_POOL = true;

    // 合并 前端本地旧的   api配置 到 最终的 前端 本地 域名池子  开关
    MERGE_OLD_LOCAL_API_TO_LOCAL_API_POOL = true;

    //  getuserinfo  内的 oss 下的 api 数组 是强制的 必须 做为最基础数据 依据的  因此不提供开关。
    //  url 内的 api 参数内的数组  正常是  getuserinfo  内的 oss 下的 api 数组 的 子集 ，
    //  但是在用户试用期间， getuserinfo  内的 oss 下的 api 数组 可能 会变更，因此 理论上 每次页面主动或者被动调用 getuserinfo 都需要写入进来，存储到本地
    // 当前的 流程  ： 流程1   use_url_api 或者 流程2   use_oss_file_apiString current_api_flow = "use_oss_file_api";

    // 最大的 本地域名池子数量上限
    LOCAL_API_POOL_MAX = 10;

    // 记录到本地域名池子内的api 的过期时间，超过此时间的api 需要 在 再次刷新本地 域名池的时候 清理掉
    LOCAL_API_EXPIRATION_TIME = 30 * 24 * 60 * 1000;

    // 每次不论是 如何去检测  API 接口的 ，只要那个API 可用 ，就刷新这个 API 的创建时间 到当时的检测通过时间，相当于加长这个域名在域名池的理论存活时间
    // 当 走 url 内 api 流程 出错是否 去掉api 参数并强制刷新页面去 走  oss 文件流程，也可以不刷新，静默切换流程
    force_reload_to_use_oss_file_api = false;

    //oss 文件内 视频播放地址
    live_domains_oss_path_file = 'live_domains.h5';

    //api  内 视频播放地址
    live_domains_oss_path_api = 'live_h5';

    oss_urls = [];

    userInfo = null;

    //移除原来的
    ListKV.domainApi.remove();
  }

  /*
   * @description: 构造函数
   * @return {undefined} callback 回调方法通知   {type:'domain_api',status:0 ,list:[]} status字段:0-初始状态 1-已经发现最快的api域名并已经设置,  2-已经切换到最新的可用域名, 3-切换时发现没有域名可用
   */
  create(url, {Function? callback}) {
    //需先清空上次登录存留的数据
    init();

    // 解析url
    urlParams = parseUrl(url);
    // urlParams.token = '75237f391973ba00631037e123aaece64215a8e8'; // 测试使用
    hasToken = hasStrValue(urlParams.token ?? StringKV.token.get());

    // 处理环境
    setEnv();
    setGr(urlParams.gr?.toUpperCase());

    //  初始化原始数据
    // init();

    // 获取本地配置的oss url地址
    // oss_urls = get_oss_urls();

    // 解密使用的key
    // DECRYPT_KEY = CryptoJS.enc.Utf8.parse("panda1234_1234ob");
    // DECRYPT_KEY = utf8.encode("panda1234_1234ob");
    // DECRYPT_KEY = "panda1234_1234ob";
    // 解密url 内 api 字段使用的 key
    // DECRYPT_KEY_URL_API = CryptoJS.enc.Utf8.parse("OBTY20220712OBTY");
    // DECRYPT_KEY_URL_API = utf8.encode("OBTY20220712OBTY");
    // DECRYPT_KEY_URL_API = "OBTY20220712OBTY";
    // 回调方法参数: {type:'domain_api',status:0 ,list:[]}
    // status字段:0-初始状态 1-首次进入: 发现最快的api域名并已经设置,  2-切换域名时 :已经切换到最新的可用域名, 3- 切换域名时:切换时发现没有域名可用
    if (callback is Function) {
      create_callback = callback;
    }
  }

  setEnv() {
    // 三方跳转过来的环境参数
    ///不要只根据传进来的url进行判断环境 app用户会选择环境
    String env = StringKV.env.get() ?? "";
    if (env.isEmpty) {
      env = urlParams.env ?? 'prod';
    } else {
      if (env == '生产维护') {
        env = 'prod';
      } else if (env == '开发') {
        env = 'dev';
      } else if (env == '测试') {
        env = 'test';
      } else if (env == '隔离') {
        env = 'geli';
      } else if (env == '试玩') {
        env = 'sandbox';
      } else if (env == 'MINI') {
        env = 'mini';
      }
    }

    if (env == 'prod') {
      // 生产
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_online';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'prod.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://xbnhjktbwggfvyok.ybgjhb.com', 'https://aukukktsxfauannt.zyakxf.com','https://xbnhjktbwggfvyok.chinazjyh.com','https://xbnhjktbwggfvyok.lcjzgt.com'];
    } else if (env == 'dev') {
      // 开发
      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_dev';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'dev.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://api-json.dbsportxxx3pk.com'];
    } else if (env == 'test') {
      // 测试
      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_test';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'test.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://api-json.dbsportxxx3pk.com'];
    } else if (env == 'geli') {
      // 隔离
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_lspre';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'lspre.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://api-json.dbsportxxx3pk.com'];
    } else if (env == 'sandbox') {
      // 试玩
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_sandbox';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'play.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://api-json.dbsportxxx3pk.com'];
    } else if (env == 'mini') {
      // mini
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_ylcs';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'mini.json';
      BUILDIN_CONFIG['OSS_DOMAIN'] = ['https://api-json.dbsportxxx3pk.com'];
    }
  }

  /*
   * @description: 设置topic
  * @param {*} topic 域名列表
  * @return {*}
  */
  set_topic(topic) {
    if (topic.isNotEmpty) {
      toppic_fast(topic, (api_obj) {
        // api_obj 格式如下
        // "sports_rules" -> "https://topic.sportxxx1zx.com/sports-rules/23-app/common/"
        // "domain" -> "https://topic.sportxxx1zx.com"
        // "activity" -> "https://topic.sportxxx1zx.com/activity/common/common/"
        BUILDIN_CONFIG['TOPIC'] = api_obj;
        // 缓存
        MapKV.topic.save(api_obj);
        // LocalStorage.set('topic',api_obj);
      });
    }
  }

  setUserInfo(UserInfo? value){
    userInfo = value;
  }

  /*
   * @description: 设置oss文件中的数据到全局配置文件中
   * @param {*} data oss文件数据
   * @return {*}
   */
  set_all_config_from_oss_file_data_2(oss_data) {
    //解密 img
    final img = lodash.get(oss_data, "img");
    //解密 jt_static
    List jt_static = lodash.get(oss_data, "jt_static");
    //解密 static
    // final static_src = lodash.get(oss_data, "static");
    //解密 live_domains
    final live_domains = lodash.get(oss_data, live_domains_oss_path_file);

    // 设置live_domains
    if (hasValue(live_domains)) {
      DOMAIN_RESULT.live_domains = live_domains;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
    // 设置oss_img_domains
    if (isStrList(img)) {
      check_img_domain(img);
    }
    // 设置oss_jt_static
    if (isStrList(jt_static)) {
      check_jt_static_domain(jt_static);
    }
    // 设置topic
    final topic = lodash.get(oss_data, "topic");
    set_topic(topic);
    // 处理 api  逻辑
    set_all_config_from_oss_file_data_2_api(oss_data);
  }

  setGr(String? gr) {
    gr ??= 'COMMON';
    String upGr = gr.toUpperCase();
    StringKV.gr.save(upGr);
    DOMAIN_RESULT.gr = upGr;
  }
  getGr(){
    String gr = StringKV.gr.get() ?? 'COMMON';
    return  gr.toUpperCase();
  }
  isSameGr(String gr1,String gr2){
    return gr1.toUpperCase() == gr2.toUpperCase();
  }

  /*
   * @description: 设置oss文件中的数据到全局配置文件中  的  api  部分
   * @param {*} data oss文件数据
   * @return {*}
   */
  set_all_config_from_oss_file_data_2_api(oss_data) {
    List api = [];
    var api_x = lodash.get(oss_data, "GA${DOMAIN_RESULT.gr}.api");

    // 因为存在 对接接口 历史遗留 ，用户 进入界面可能无 gr 参数  但是  时间戳接口可以混合调用，getuserinfo 也一样能 混合调用
    if (api_x == null) {
      String cgr = "COMMON";
      setGr(cgr);
      api_x = lodash.get(oss_data, "GA$cgr.api") ?? [];
      // AppLogger.debug(
      //   "分组信息错误,分组强制设置为COMMON组 api_x:" + JSON.stringify(api_x)
      // );
    }
    api = [...api_x];
    // 存到
    oss_file_api = api;
    // 计算当前的 域名池子
    compute_current_local_api_pool();
    // 如果当时 的 流程是 ： 流程 1 走通了 附带 去集成备份oss 文件配置到前端 这里 不需要去 找可用域名
    // 此时已经有可用域名了
    if (current_api_flow == "use_url_api") {
    } else {
      // 如果当时 的 流程是 ： 流程 2  ,此时 是没有可用域名的  ，这里需要去找 可用域名
      //这里开始 找到一个可用域名  ，不做排序  ，使用 时间戳 接口
      compute_api_domain_firstone_by_currentTimeMillis();
    }
  }

  List getMatchApiList(List arr) {
    return arr.where((x) => x['group'] == getGr()).toList();
  }

  /*
   * 找到 第一个可用的 api   去 进行 后续 页面逻辑
   * @param {*} api
   */
  compute_api_domain_firstone_by_currentTimeMillis(
      {check_group = false}) async {
    final api = getMatchApiList(local_api_pool);
    bool check_ok = hasValList(api);
    print(
      "compute_api_domain_firstone_by_currentTimeMillis--",
    );
    print(api);
    if (!check_ok) {
      // todo 补偿逻辑 如果没有api流程走不下去了 没有刷新过 先刷新下尝试解决问题
      //compute_current_local_api_pool 应该是找这个方法的问题 this.local_api_pool没筛选出值 暂时很难找到 862行计算的
      // const reload_num=LocalStorage.get("reload",0)
      // if(reload_num==0){
      //   LocalStorage.set("reload",reload_num+1)
      //   window.location.reload()
      // }
      // AppLogger.debug('compute_api_domain_firstone_by_currentTimeMillis--检查失败',);
      showLoadingError();
      return false;
    }
    // let api =   JSON.parse(JSON.stringify(this.local_api_pool))
    // api.push( { api:"http://xxx.com"})
    List<Future<Response>> reqs = [];
    //if (hasToken)
    {
      for (var x in api) {
        // 循环对api进行测试访问处理
        int t = DateTime.now().millisecondsSinceEpoch;
        // 请求的地址
        var api = x['api'];
        String url = '$api?t=$t';
        reqs.add(Dio(
          BaseOptions(
            // 设置超时时间为 3 秒
            receiveTimeout: timeout3,
            connectTimeout: timeout3
          )
        ).get(
          url,
        ));
      }
    }
    //最快的域名对象
    Map fastest_api_obj = {};


    //如果  不是检查 域名分组 正确性 并纠错
    try{
      var res = await myAny(reqs);
      // var res = await Future.any(reqs); 
      String c_url = Uri.parse(res.realUri.origin).toString();
      fastest_api_obj = format_api_to_obj(
          c_url,
          group: compute_exact_group_by_str(str: res.data ?? ""));

      if (!check_group) {
        find_use_apis_event_first_one(fastest_api_obj);
      }

    }catch(e){
      print(e);
    }
  

    // 纠错
    try {

      Future allSettled(List<Future> futures) {
        Completer completer = Completer();
        Future future = completer.future;

        int len = 0;
        int reqsLen = reqs.length;
        List res = List.generate(reqsLen, (index) => null);

        reqs.asMap().forEach((index, element) {
          element.then((value) {
            len +=1;
            res[index] =  {'status': 'fulfilled', 'value': api[index],'response':value };
            if(len == reqsLen){
              completer.complete(res);
            }
          }).catchError((error) {
            len +=1;
            res[index] =  {'status': 'rejected', 'value': api[index] };
            if(len == reqsLen){
              completer.complete(res);
            }
          });
        });
        return future;
      }

      List results = await allSettled(reqs);
      // 异步操作成功时
      // {status: 'fulfilled', value: value}
      // 异步操作失败时
      // {status: 'rejected', reason: reason}
      // print(" 域名时间戳检测逻辑结果 results----------", results);
      //失败次数
      int rejected_num = 0;
      int tr = DateTime.now().millisecondsSinceEpoch;

      results.asMap().forEach((i, result) {
        // 'fulfilled' 异步操作成功时
        if (result['status'] == 'fulfilled') {
          // 刷新 域名的创建时间 ，刷新理论存活时间
          api[i]["update_time"] = tr;
          api[i]["group"] = compute_exact_group_by_str(str: result['response'].data ?? "");
        } else {
          // 'rejected'  异步操作失败时
          rejected_num++;
        }
      });
      //保存数据到本地
      set_sava_json_key(local_api_pool);
      // 重新计算本地域名池 并且写入本地存储
      compute_current_local_api_pool();
      //全部错误
      if (rejected_num == api.length) {
        // 失败 页面  没网 之类的 错误页面
        showLoadingError();
      } else {
        //如果 是检查 域名分组 正确性 并纠错
        if (check_group) {
          // 获取当前使用的 api
          var capi = DOMAIN_RESULT.first_one;
          // 当前使用的 api 的 host
          var capi_str = capi.split('://')[1];
          // 当前使用的 api 的分组
          var capi_group = (local_api_pool.firstWhere(
                  (x) => x['api'].contains(capi_str),
                  orElse: () => {}))['group'] ??
              '';

          final gr = DOMAIN_RESULT.gr;
          // 如果当前在用的域名的分组和用户的分组不相同
          if(!isSameGr(capi_group, gr)){
            // 如果新的最快 API 的分组和用户的分组相同
            if ( isSameGr(fastest_api_obj['group'], gr)) {
              // 设置可用的域名
              find_use_apis_event_first_one(fastest_api_obj);
            } else {
              // 如果分组不相同，则利用新的域名池重新排序
              compute_api_domain_firstone_by_currentTimeMillis();
            }
          }else{
            showLoadingError();
          }
        }else{
          showLoadingError();
        }
      }
    } catch (e) {
      // print("域名检测 出错:");
      print(e);
      showLoadingError();
    }
  }

  void showLoadingError(){
    //APP 暂不处理。APP调用find<SdkTyHomeController>()会创建SdkTyHomeController，导致错误
    if(sdkTyHomeController!=null) {
      sdkTyHomeController!.logic.loading.value = false;
    }
  }

  /* todo 接口请求失败
   * 找到toppic中最快的域名
   * @param {*} api
   */
  Future<void> toppic_fast(List api, Function callback, {int count = 0}) async {
    count++;
    // 清除计时器
    clean_timer(timer_toppic_fast);

    List<Future<Response>> reqs = [];
    //if (hasToken)
    {
      for (var x in api) {
        // 循环对api进行测试访问处理
        int t = DateTime.now().millisecondsSinceEpoch;
        // 请求的地址
        String url = '$x/check.json?t=$t';

        final dio_options = BaseOptions(
          receiveTimeout: timeout5,
          connectTimeout: timeout5,
        );
        reqs.add(Dio(dio_options).get(url));
      }
    }

    try {
      // Response res = await Future.any(reqs);
      Response res = await myAny(reqs);
      // 最快toppic的域名
      String cUrl = Uri.parse(res.realUri.origin).toString();
      clean_timer(timer_toppic_fast);
      var obj_ = {'sports_rules': ''};
      // 体育规则配置
      // 布局规则
      // --2021亚洲H5+PC	common
      // --2023亚洲PC	23-as
      // --2023欧洲H5+PC	23-eu
      // --2023KYAPP复刻版	23-app
      // 路径规则：最优域名/sports-rules/布局/内容 （内容字段需要接口下发，默认common）
      // 比如 https://test-topic.sportxxxifbdxm2.com/sports-rules/common/common
      // 获取项目信息
      final PROJECT_NAME = BUILDIN_CONFIG['PROJECT_NAME'];
      obj_['domain'] = cUrl;
      // window.SEARCH_PARAMS.init_param_set({'topic': obj_['domain']});
      obj_['activity'] = '$cUrl/activity/common/common/';

      switch (PROJECT_NAME) {
        case 'yazhou-h5':
        case 'yazhou-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-as/common/';
          break;
        case 'ouzhou-h5':
        case 'ouzhou-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-eu/common/';
          break;
        case 'app-h5':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-app/common/';
          break;
        case 'new-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-as/common/';
          break;
        default:
          obj_['sports_rules'] = '$cUrl/sports-rules/common/common/';
          break;
      }
      if (isFunction(callback)) {
        callback(obj_);
      }
      return;
    } catch (error) {
      // 所有  全部请求失败
      // print(error);
    }

    try {
      List<Response> results = await Future.wait(reqs);
      // 异步操作成功时
      // {status: 'fulfilled', value: value}
      // 异步操作失败时
      // {status: 'rejected', reason: reason}
      // print(" 域名时间戳检测逻辑结果 results----------", results);
      //失败次数
      int rejected_num = 0;

      results.asMap().forEach((i, result) {
        print(result);
        // todo 'fulfilled' 异步操作成功时
        if (result.statusCode! >= 200 && result.statusCode! < 300) {
          // 刷新 域名的创建时间 ，刷新理论存活时间
        } else {
          // 'rejected'  异步操作失败时
          rejected_num++;
        }
      });
      //全部错误
      if (rejected_num == api.length) {
        // 失败 页面  没网 之类的 错误页面
        timer_toppic_fast = Timer(timeout5, () {
          toppic_fast(api, callback, count: count);
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  clean_timer(timer) {
    if (hasValue(timer)) {
      timer.cancel();
    }
  }

  /*
   * @description: 运行检测功能
   */
  run() {
    // 前置 几道工序
    // 当前的 流程  ： 流程1   use_url_api 或者 流程2   use_oss_file_api
    compute_current_api_flow();
    if (current_api_flow == "use_url_api") {
      // 流程 1 开始 修改为先从本地缓存竞速获取最优域名进行 后续再拉取oss合并
      // 加入useApi判断
      begin_process_when_use_url_api();
    } else {
      // 流程 2 开始
      begin_process_when_use_oss_file_api();
    }

    // 初始化topic
    var topic_url = urlParams.topic;
    if (hasValue(topic_url)) {
      topic_url = Uri.decodeComponent(topic_url!);
      set_topic(topic_url.split(','));
    }

    print(BUILDIN_CONFIG);
    //意义不明，去掉
    // 检查纠正 分组信息
    //Timer(const Duration(seconds: 30), () {
    //  check_and_correct_local_api_pool_group();
    //});
  }

// 更换域名
  changeDomain() {
    List localApis = get_save_domain_api();
    String currentApi = StringKV.best_api.get()??'';
    String gr = getGr();

    // 过滤掉失效域名
    localApis = localApis.where((element) => element['api']!=currentApi).toList();
    set_sava_json_key(localApis);

    // 当前分组的 api
    List groupList =
    localApis.where((x) => isSameGr(x['group'], gr))
        .toList();
    groupList.sort((a, b) => b['update_time'] - a['update_time']);
    String? url = groupList.safeFirst?['api'];

    if(url == null){
      List notGroupList =
      localApis.where((x) => !isSameGr(x['group'], gr))
          .toList();
      if(notGroupList.isEmpty){
        return null;
      }
      notGroupList.sort((a, b) => b['update_time'] - a['update_time']);
      var url2 = notGroupList.safeFirst?['api'];
      url = url2;
    }

    if(url == null)return null;

    // 设置当前域名
    DOMAIN_RESULT.first_one = url;
    StringKV.best_api.save(url);
    // 执行回调
    // 通知dio ws 更换 域名

    AppDio.getInstance().setApiDomain();
    if(StringKV.token.get()?.isNotEmpty??false) {
      AppWebSocket.changWsUrl();
    }
    return url;

  }

  /*
   * @description: 获取持久化localStorage中的数据
   * @param {string} key localStorage key值
   * @return {object} 返回Json类型数据
   */
  List get_save_domain_api() {
    List domai_api = ListKV.domainApi.get();
    return domai_api;
  }

  String get_oss_decrypt_str(word, {key = AllDomain.DECRYPT_KEY}) {
    var ret = "";
    if (word != null && word.isNotEmpty) {
      try {
        // 解密
        ret = jiemiWord(word, key);
        // 转字符串
        // ret = utf8.decode(decrypt);
        // 去除左右空格
        ret = ret.trim();
        // 删除结尾的 /
        if (ret.isNotEmpty && ret.endsWith('/')) {
          ret = ret.substring(0, ret.length - 1);
        }
      } catch (error) {
        print("getOssDecryptStr: $error");
      }
    }
    return ret;
  }
}
