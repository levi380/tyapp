import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import 'package:flutter_ty_app/app/utils/pb.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';


import '../../../main.dart';
import '../../db/app_cache.dart';
import '../../global/ty_user_controller.dart';
import '../models/res/user_info.dart';
import 'response_interceptor.dart';
import '../models/domain_model.dart';
import 'domain.dart';

extension AllDomainExtension on AllDomain{
/*
   * 计算当前流程
   *  流程1   use_url_api    首次进入
   *  流程2   use_oss_file_api    首次进入
   */
  compute_current_api_flow() {
    // 当前的 流程  ：
    var unDecrypt = "";
    var url_search = urlParams;
    var api = url_search.api;

    List unDecryptList = [];
    //   AppLogger.debug('location.href-',location.href);
    //   AppLogger.debug('api------------',api);
    //  AppLogger.debug('api------------',  api.replace(/\s/g,'+'));
    //   AppLogger.debug('url_search----',url_search);
    //   AppLogger.debug('url_search---2222-', new URL(location));
    if (api == null || !useApi) {
      // 没有从地址获取api返回
      current_api_flow = "use_oss_file_api";
    } else {
      api = api.replaceAll(RegExp(r'\s'), "+");
      // const api = 'vEtkQtmX6wF8fAGV5b4UDx2mPRca2zMHLMj/YELjSwxjyhV5t0ifZDD6I0iwkpzJ'
      unDecrypt = get_oss_decrypt_str(api, key: AllDomain.DECRYPT_KEY_URL_API);
      // AppLogger.debug("unDecrypt----------1", unDecrypt);

      if (unDecrypt != '') {
        unDecryptList = unDecrypt
            .split(",")
            .map((x) => x.trim())
            .where((x) => x.startsWith("http://") || x.startsWith("https://"))
            .toList();
      }
      if (unDecryptList.isEmpty) {
        current_api_flow = "use_oss_file_api";
      } else {
        current_api_flow = "use_url_api";
      }
      // AppLogger.debug("unDecrypt----------2", JSON.stringify(unDecrypt));
    }
    // AppLogger.debug('unDecrypt----------2', JSON.stringify(unDecrypt_f));
    url_api = unDecryptList;
  }

/*
   * 流程一  url 内 有api 参数 和 分组参数 ，并且api 参数解析后长度不为0   use_url_api
   * 流程一    当 使用url 内 api 参数  计算一个可用的 api
   */
  Future<void> begin_process_when_use_url_api() async {
    // 获取 token
    String? token = urlParams.token;

    // 并发请求
    List<Future<Response>> reqs = [];
    String pb = '';
    try {
      if (hasValue(urlParams.pb)) {
        pb = 'PB';
      }
    } catch (error) {
      print(error);
    }
    for (var item in url_api) {
      // 并发调取 getUserInfo
      Future<Response> response = Dio(
          BaseOptions(
            // 设置超时时间为 3 秒
              receiveTimeout: AllDomain.timeout3,
              connectTimeout: AllDomain.timeout3
          )
      ).get(
        '$item/yewu12/user/getUserInfo$pb',
        queryParameters: {'token': token},
        options: Options(
          headers: {'requestId': token},
          contentType: Headers.jsonContentType,
        ),
      );
      reqs.add(response);
    }

    try {
      Response res = await myAny(reqs);
      // Response res = await Future.any(reqs);
      var resData = res.data;
      // 只要有一个请求成功
      String code = lodash.get(resData, 'code');
      if (code == '0000000') {
        // 当流程一：当使用 URL 内 API 参数计算一个可用的 API 计算出来之后后置进程
        try {
          var dataTemp = lodash.get(resData, 'data');
          if (pb.isNotEmpty) {
            dataTemp = pakoPb.unzipData(dataTemp);
          }
          // Uint8List? dataTemp =
          //     pako.inflate(utf8.encode(get(res,'data')));
          if (hasValue(dataTemp)) {
            resData['data'] = dataTemp;
            // jsonDecode(res.body)['data'] = utf8.decode(dataTemp);
          }
        } catch (error) {
          print(error);
        }
        // 保存用户数据
        TYUserController.to.userInfo.value =
            UserInfo.fromJson(resData['data']);
        resData['time_upd'] = DateTime
            .now()
            .millisecondsSinceEpoch;
        DOMAIN_RESULT.getuserinfo_res = res;
        begin_process_when_use_url_api_after_process(res);
      } else if (hasToken && code == '0401013') {
        // getUserInfo 都走不通 token过期了
        ResponseInterceptor.tokenExpiredAction(res);
        //SDK需继续游客模式进入MainTab
        if (isSDK) {
          // 强制走 OSS 文件逻辑
          force_current_api_flow_to_use_oss_file_api();
        }
      } else {
        print('token 失效，走oss文件逻辑');
        // 强制走 OSS 文件逻辑
        force_current_api_flow_to_use_oss_file_api();
      }
    } catch (error) {
      // 所有全部请求失败
      print(error);
      // 需要重定向 URL 页面重新刷新去掉 API 参数
      // 去掉 API 参数 reload
      // 强制走 OSS 文件逻辑
      force_current_api_flow_to_use_oss_file_api();
    }
    /*
      //不取userInfo了，直接取json
/*
    begin_process_when_use_oss_file_api();
    Response res = Response(
      data: {"oss":oss_file_content},
      requestOptions:RequestOptions(),
    );
    begin_process_when_use_url_api_after_process(res);
*/

      // 加载oss.json
      String oss_file_name = BUILDIN_CONFIG['OSS_FILE_NAME'];

      String u = 'http://user-h5-reprint.dbsportxxx14bl5.com/';
      String finalUrl = composeUrl(u, 'oss/$oss_file_name');

      ///要trycatch 下  oss 文件路径变更 需要给本地静态资源
      var ossRes;
      try {
        if (u.isNotEmpty) {
          Response res = await Dio().get(finalUrl);

          ///获取oss api域名
          if (lodash.isPlainObject(res.data)) {
            ossRes = res.data;
            jiexi_oss_file(ossRes);
          }
        }
      } catch (e) {
        print('拉取: $finalUrl oss文件失败');
        // print(e.toString());

        ///  oss 文件获取失败
        // GetUtil.Get.snackbar(
        //   LocaleKeys.app_h5_cathectic_kind_tips.tr,
        //   LocaleKeys.home_login_invalid.tr,
        //   colorText: Colors.white,
        //   snackPosition: SnackPosition.TOP,
        // );
      } finally {
        if (ossRes == null) {
          /*
         起因：三方调用SDK未传入url，不能获取到api。
         解决方案：oss域名放在图片服务器，因App不好热更，所以不写oss服务器地址
       */
          // 没有拉到oss数据  走oss json

          for (var oss_domain_item in BUILDIN_CONFIG['OSS_DOMAIN']) {
            if (hasStrValue(oss_domain_item)) {
              finalUrl = composeUrl(
                //OssUtil.getServerPath('assets/images/common'), '$oss_file_name'
                  oss_domain_item, oss_file_name
              );
              try {
                Dio dio = Dio();
                if (BUILDIN_CONFIG['CURRENT_ENV'] != 'idc_online') {
                  (dio.httpClientAdapter as IOHttpClientAdapter)
                      .createHttpClient = () =>
                  HttpClient()
                    ..badCertificateCallback =
                        (X509Certificate cert, String host, int port) => true;
                }
                Response res = await dio.get(finalUrl);

                ///获取oss api域名
                if (lodash.isPlainObject(res.data)) {
                  ossRes = res.data;
                  jiexi_oss_file(ossRes);
                  break;
                }
              } catch (e) {
                print('拉取: $finalUrl oss文件失败');
              }
            }
          }
        }
        // 没有拉到oss数据  走本地oss json
        if (ossRes == null) {
          String path = 'res/oss/$oss_file_name';

          String ossJson;
          try {
            ossJson = await rootBundle.loadString(path);
          } catch (e) {
            path = 'packages/flutter_ty_app/' + path;
            ossJson = await rootBundle.loadString(path);
          }
          Map ossRes = json.decode(ossJson);
          jiexi_oss_file(ossRes);
        }
      }
      Response res = Response(
        data: {"oss": oss_file_content},
        requestOptions: RequestOptions(),
      );
      begin_process_when_use_url_api_after_process(res);
    }

     */
  }

/*
   *
   * 当流程一： 当 使用url 内 api 参数  计算一个可用的 api   计算出来之后 后置进程
   *
   */
  begin_process_when_use_url_api_after_process(Response res) {
    var resData = res.data;
    // 确保分组信息 赋值
    String gr = lodash.get(resData, "data.gr") ?? '';
    setGr(gr);

    //OSS 对象
    // var ossobj = get(resData, "data.oss");
    // AppLogger.debug("ossobj--------", ossobj);
    // 如果 有 api 但是拿不到 ossobj    ， 强制 走 oss 文件逻辑
    if (lodash.get(resData, "data.oss") == null) {
      force_current_api_flow_to_use_oss_file_api();
      return false;
    }
    OssObj ossobj = OssObj.fromJson(lodash.get(resData, "data.oss"));
    // 第一步  拿到 可用api
    // 确保 ossobj .api 字段内  有包含 当前这个可用的  api
    // String c_url = Uri.parse(res.realUri.origin).toString();
    // if(c_url.startsWith('http')){
    //   c_url = new URL(res.config.url);
    // } else{
    //   c_url = new URL(res.config.baseURL);
    // }
    // AppLogger.debug("c_url------", c_url);
    //当前这个可用的 api
    var use_api = Uri.parse(res.realUri.origin).toString();
    // 当前唯一 已知可用的 api
    var objapi = format_api_to_obj(use_api);
    // 确保初始化
    ossobj.api ??= [];
    if (ossobj.api is! List) {
      ossobj.api = [];
    }
    // List<String> apiList = ossobj.api as List<String>;

    // 去空
    ossobj.api = ossobj.api!.where((x) => hasValue(x)).toList();
    // 容错必须包含当前请求通的url
    // if( !ossobj.api.includes(use_api)){
    //   ossobj.api.push(use_api)
    // }
    ossobj.api = [...?ossobj.api, ...url_api];
    // apiList.addAll(url_api);
    // 同步最新域名到  全量API 数组

    DOMAIN_RESULT.full_apis = lodash.uniq([
      ...?ossobj.api,
      ...DOMAIN_RESULT.full_apis,
    ]);

    // // 第二步 设置
    set_getuserinfo_oss(ossobj);
    // 发现可用的域名的逻辑处理
    find_use_apis_event_first_one(objapi);
    // 图片 以及 静态域名 分流处理
    begin_process_when_use_url_api_after_process_handle_other_domain(ossobj);
    // 补充 oss file 进来
    // 空闲时间执行
    begin_process_when_use_oss_file_api();
  }

  void set_getuserinfo_oss(OssObj ossobj) {
    final api = ossobj.api;
    final img = ossobj.img;
    final live_h5 = ossobj.live_h5;
    // final live_pc = ossobj.live_pc;
    if (hasValue(api) && api!.isNotEmpty) {
      GETUSERINFO_OSS = ossobj;
      // GETUSERINFO_OSS = {
      //   'api': api,
      //   'img': img,
      //   'live_h5': live_h5,
      //   'live_pc': live_pc
      // };
      // 计算当前的域名池子
      compute_current_local_api_pool();
    }
    if (hasValue(img) && img!.isNotEmpty) {
      // 更新图片域名
      DOMAIN_RESULT.img_domains = img;
      StringKV.imgUrl.save(DOMAIN_RESULT.img_domains.first);
    }

    if (hasValue(live_h5) && live_h5!.isNotEmpty) {
      // 更新视频项目域名
      DOMAIN_RESULT.live_domains = live_h5;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
  }

/*
   *
   *  根据流程计算本地api域名池子 三种
   *  逻辑 每次都走 有冗余，但是 事实上 调度次数很少 无所谓
   */
  compute_current_local_api_pool() {
    try {
      //  前端本地旧的   api配置
      var old_local_api = get_save_domain_api();
      var getuserinfo_oss_api = GETUSERINFO_OSS.api ?? [];
      // 变形后 放入的数组
      List new_get_api_obj_arr = [];
      for (var x in getuserinfo_oss_api) {
        new_get_api_obj_arr
            .add(format_api_to_obj(x, group: getGr()));
      }
      //  oss 文件 oss_file_api
      for (var x in oss_file_api) {
        new_get_api_obj_arr
            .add(format_api_to_obj(x, group: getGr()));
      }
      new_get_api_obj_arr = lodash.uniqBy(new_get_api_obj_arr, "api");

      //把认为新进来的 里面的  事实上本地已存在的 删除掉，留下真正新增的
      List real_new_api =
      lodash.pullAllBy(new_get_api_obj_arr, old_local_api, "api");

      // 最终的 api 数组
      List final_api_pool = [...real_new_api, ...old_local_api];
      // 删除旧的
      // 当前时间
      final ct = DateTime
          .now()
          .millisecondsSinceEpoch;
      // 时间差
      final sc = LOCAL_API_EXPIRATION_TIME;
      // 当前计算后的前端本地 api 池子
      List<Map<String, dynamic>> localApiPool = [];
      final_api_pool.forEach((x) {
        if (x['update_time'] == null) {
          x['update_time'] = ct;
        }
        x.remove('type');
        if (ct - x['update_time'] < sc) {
          localApiPool.add(x);
        }
      });

      // 排序，按照更新时间从大到小排列，新的在前，旧的在后
      localApiPool.sort((a, b) => b['update_time'] - a['update_time']);

      final cgr = getGr();
      // 当前分组的 api
      final local_api_pool_cg =
      localApiPool.where((x) => isSameGr(x['group'], cgr)).toList();
      // 非当前分组的 api
      final local_api_pool_not_cg =
      localApiPool.where((x) => !isSameGr(x['group'], cgr)).toList();

      // 截取最大的本地域名池子数量上限
      if (local_api_pool_cg.length > LOCAL_API_POOL_MAX) {
        local_api_pool_cg.removeRange(
            LOCAL_API_POOL_MAX, local_api_pool_cg.length);
      }

      // 重新组合本地域名池
      local_api_pool = [...local_api_pool_cg, ...local_api_pool_not_cg];
      local_api_pool = lodash.uniqBy(local_api_pool, "api");

      set_sava_json_key(local_api_pool);
    } catch (e) {
      print(e);
    }
  }

/*
   * 检查 域名池子 内 域名的 域名分组 正确性 并纠错
   */
  check_and_correct_local_api_pool_group() {
    compute_api_domain_firstone_by_currentTimeMillis(check_group: true);
  }

/*
   *  // 初次进入,发现可用的域名
   */
  find_use_apis_event_first_one(obj) {
    // 首次进入,发现最快的域名
    final api = obj['api'];
    // AppLogger.debug("首次加载,已经找到最快的域名:", api);
    // 写入可用api
    StringKV.best_api.save(api);
    // 挂载当前 环境能使用的 api 数组
    DOMAIN_RESULT.first_one = api;

    //成功了释放sdkTyHomeController
    sdkTyHomeController = null;
    // 执行回调
    create_callback(DOMAIN_RESULT);
  }

/*
   *
   * 当流程一： 当 使用url 内 api 参数  计算一个可用的 api   计算出来之后 后置进程
   *
   * 处理除了api  之外的域名
   */
  begin_process_when_use_url_api_after_process_handle_other_domain(
      OssObj oss_data) {
    // api: [null]
    // img: ["http://sit-image.sportxxxkd1.com"]
    // live_h5: "http://testliveh5.sportxxx13ky.com"
    // live_pc: "http://testlivepc.sportxxx13ky.com"
    // loginUrl: "http://test-user-pc-bw4.sportxxxifbdxm2.com/?token=5cc56f7830e569fe3a815b6ffa50634cf32af09a&gr=common&tm=1&lg=zh&mk=EU&stm=blue"
    // loginUrlArr: [,…]
    //解密 img
    List img = lodash.get(oss_data.toJson(), "img");
    // //解密 static
    // let static_src = lodash.get(oss_data, "static",[]);
    //解密 live_domains live_h5
    String live_domains = oss_data.live_h5 ?? "";

    // 设置live_domains
    if (hasStrValue(live_domains)) {
      DOMAIN_RESULT.live_domains = live_domains;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
    // 设置oss_img_domains

    check_img_domain(img);
  }

/*
   *
   * 流程二： url 内 无 api gr 此类信息  use_oss_file_api
   * 走 oss 逻辑
   *
   */
  begin_process_when_use_oss_file_api() async {
    String oss_file_name = BUILDIN_CONFIG['OSS_FILE_NAME'];
    String u = urlParams.domain ?? '';
    var ossRes;

    // 尝试从 URL 参数中的 domain 获取 OSS 文件
    if (u.isNotEmpty) {
      String finalUrl = composeUrl(u, 'oss/$oss_file_name');
      try {
        Response res = await Dio(
          BaseOptions(
            receiveTimeout: AllDomain.timeout5, // 使用定义的超时时间
            connectTimeout: AllDomain.timeout5, // 使用定义的超时时间
          ),
        ).get(finalUrl);

        if (lodash.isPlainObject(res.data)) {
          ossRes = res.data;
          jiexi_oss_file(ossRes);
        }
      } catch (e) {
        AppLogger.error('拉取: $finalUrl oss文件失败: $e');
      }
    }

    // 如果未从 URL 参数的 domain 获取到，尝试 BUILDIN_CONFIG['OSS_DOMAIN'] 列表
    if (ossRes == null) {
      for (var oss_domain_item in BUILDIN_CONFIG['OSS_DOMAIN']) {
        if (hasStrValue(oss_domain_item)) {
          String finalUrl = composeUrl(oss_domain_item, oss_file_name);
          try {
            Dio dio = Dio(
              BaseOptions(
                receiveTimeout: AllDomain.timeout5, // 使用定义的超时时间
                connectTimeout: AllDomain.timeout5, // 使用定义的超时时间
              ),
            );
            if (BUILDIN_CONFIG['CURRENT_ENV'] != 'idc_online') {
              (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
                  () =>
              HttpClient()
                ..badCertificateCallback = (X509Certificate cert, String host,
                    int port) => true;
            }
            Response res = await dio.get(finalUrl);

            if (lodash.isPlainObject(res.data)) {
              ossRes = res.data;
              jiexi_oss_file(ossRes);
              break; // 找到一个成功的就跳出循环
            }
          } catch (e) {
            AppLogger.error('拉取: $finalUrl oss文件失败: $e');
          }
        }
      }
    }

    // 如果所有外部获取都失败，则从本地 assets 加载
    if (ossRes == null) {
      String path = 'res/oss/$oss_file_name';
      String ossJson;
      try {
        ossJson = await rootBundle.loadString(path);
      } catch (e) {
        path = 'packages/flutter_ty_app/' + path;
        ossJson = await rootBundle.loadString(path);
      }
      Map decodedOssRes = json.decode(ossJson);
      jiexi_oss_file(decodedOssRes);
      AppLogger.debug('从本地 assets 加载了 oss 文件: $path');
    }

    // String path = 'res/oss/$oss_file_name';
    // final ossJson = await rootBundle.loadString(path);
    // Map ossRes = json.decode(ossJson);
    // print(ossRes);

    // 测试用
    // String ossjsonTest = '{"update_time":"2024-01-14 17:43:41","topic":["VijmdUkIZl454580y0teW5a6L5RigX1Rb1SDcRpHTjAZE5fPL8WdYjBf/9i8SUT3"],"jt_static":["6FbdCIHRX4gkt/R1Pb1/GhNx9Fp7th8HIOHBcX4W+dNaDKqR3GvdECeXRhscoqcd"],"img":["pV9gSBMQ8z3xSR9EYFS38yLmr3+qSebRP0Cad2LynSo="],"static":[],"live_domains":{"pc":"Wgyqkdxr3RAnl0YbHKKnHQ==","h5":"Wgyqkdxr3RAnl0YbHKKnHQ==","end":"Wgyqkdxr3RAnl0YbHKKnHQ=="},"file_name":"play.json","GAS":{"api":["foD/zLIIeO76kcWlq8BdueuRIdc8vSVBdN0GllYmF35aDKqR3GvdECeXRhscoqcd"]},"GAB":{"api":["s7OWtICGLnxK8h7C85vGK8qChrgxrydp+DzFcALrSMI="]},"api":["foD/zLIIeO76kcWlq8BdudP1Hsa6u03+SQMuVOpBPiA=","foD/zLIIeO76kcWlq8Bdudn+Y6IG/YSGOxOystGOGx7MRzXIPOdjmugug2I6HLZZ"],"update_by":"ob","type":"试玩环境","GAY":{"api":["crj9UzMyiV8d+xKktZ8n1i/+ogaqj6l3j0ty2x2m5SV/UkN1QmDi/y0TPBmRgQLF"]},"GACOMMON":{"api":["foD/zLIIeO76kcWlq8BdudP1Hsa6u03+SQMuVOpBPiA=","foD/zLIIeO76kcWlq8Bdudn+Y6IG/YSGOxOystGOGx7MRzXIPOdjmugug2I6HLZZ"]}}';
    // Map ossRes = json.decode(ossjsonTest);
    // jiexi_oss_file(ossRes);
  }

/*
   * 解析 OSS 文件返回体内容
   * @param {*} res
   */
  jiexi_oss_file(obj) {
    // 获取解密后的明码数据
    get_decrypt_oss_data(obj);
    // oss url地址返回的数据
    oss_file_content = obj;
    // 设置 oss文件中的数据到全局配置文件中
    set_all_config_from_oss_file_data_2(obj);
    // 全局变量可视化设置
    BUILDIN_CONFIG['OSS_JSON'] = obj;
  }


/*
   * @description: 设置持久化localStorage中的数据
   * @param {string} key localStorage key值
   */
  set_sava_json_key(val) {
    ListKV.domainApi.save(val);
  }

/*
   *    强制 走 oss 文件逻辑
   */
  force_current_api_flow_to_use_oss_file_api() {
    // 强制刷新 去 变更流程 保证流程正确
    if (force_reload_to_use_oss_file_api) {
      // 缺点 ： 页面刷了 ，loading 加长，而且如果页面显示出来之后 ，内部触发刷新 ，这里还是 一样长时间 ，双倍
      // 优点 ： 后面刷新单倍时长 理论不会走到这里
      // force_current_api_flow_use_oss_file_api_reload();
    } else {
      // 缺点：每次刷新 ，都要走一次报错，甚至多次 报错后 才能走到正规 ， 设置的 axios_instance  超时 10 秒
      force_current_api_flow_use_oss_file_api_no_reload();
    }
  }

/*
   * 虽然 url 有api 字段 ,但是 如果 getuserinfo 接口不返回 oss 字段  强制 走  oss 文件 逻辑
   */
  force_current_api_flow_use_oss_file_api_no_reload() {
    // url 内的api 解析后的 数据
    url_api = [];
    // 当前流程
    current_api_flow = "use_oss_file_api";
    // 流程 2 开始
    begin_process_when_use_oss_file_api();
  }

/*
   * @description: 解密数组中的加密数据,并进行赋值操作(获取解密后的信息)
   * @param {*} obj
   * @return {*}
   */
  get_oss_decrypt_obj(obj) {
    if (isList(obj)) {
      // for(var item in obj){}
      for (var i = 0; i < obj.length; i++) {
        // 解密数据,重新设置数据
        obj[i] = get_oss_decrypt_str(obj[i]);
      }
    } else if (isMap(obj)) {
      obj.forEach((key, value) {
        if (hasKey(obj, key)) {
          // 解密数据,重新设置数据
          obj[key] = get_oss_decrypt_str(value);
        }
      });
    }
  }

/*
   * @description: 获取oss文件中的明码数据
   * @param {*} data oss文件加密数据
   * @return {*} oss文件中的明码数据
   */
  get_decrypt_oss_data(data) {
    if (!hasValue(data)) return;

    // 解密img
    final img = lodash.get(data, 'img');
    if (isStrList(img)) {
      get_oss_decrypt_obj(img);
    } else {
      data["img"] = [];
    }

    // 解密jt_static
    final jt_static = lodash.get(data, 'jt_static');
    if (isStrList(jt_static)) {
      get_oss_decrypt_obj(jt_static);
    } else {
      data["jt_static"] = [];
    }
    // 解密 topic
    final topic = lodash.get(data, 'topic');
    if (isStrList(topic)) {
      get_oss_decrypt_obj(topic);
    } else {
      data["topic"] = [];
    }
    // 解密 static
    final static = lodash.get(data, 'static');
    if (isStrList(static)) {
      get_oss_decrypt_obj(static);
    } else {
      data["static"] = [];
    }
    // 解密 live_domains
    final lds = lodash.get(data, 'live_domains');
    if (hasValue(lds) && lodash.isPlainObject(lds)) {
      get_oss_decrypt_obj(lds);
    } else {
      data["live_domains"] = '';
    }

    for (var key in data.keys.toList()) {
      if (hasValue(key) && key.startsWith("GA")) {
        // 解密 GA*.api
        var api = data[key]['api'];
        if (isStrList(api)) {
          get_oss_decrypt_obj(api);
        } else {
          data[key]['api'] = [];
        }
      }
    }
  }

/*
   * @description: 检测设置oss返回的可以图片域名
   * @param {Array} oss_img_domains oss图片域名数组
   */
  check_img_domain(List oss_img_domains) {
    if (oss_img_domains.isEmpty) {
      return;
    }
    /// 循环检测图片域名
    for (var img_domain_item in oss_img_domains) {
      if (hasStrValue(img_domain_item)) {
        // 检测设置oss图片域名
        img_domain_is_ok(img_domain_item);
      }
    }
  }

/*
   * @description: 检测设置oss返回的可以jt_static域名
   * @param {Array} oss_img_domains oss图片域名数组
   */
  check_jt_static_domain(List jt_static_domains) {
    if (jt_static_domains.isEmpty) {
      return;
    }
    String path = OssUtil.getServerPath('assets/images/icon/main_tab_menu1.png');
    Uri uri = Uri.parse(path);
    path = uri.path;

    // 循环检测图片域名
    for (var jt_static_domain_item in jt_static_domains) {
      if (hasStrValue(jt_static_domain_item)) {
        // 检测设置oss图片域名
        jt_static_domain_is_ok(jt_static_domain_item, path);
      }
    }
  }

/*
   * 检测设置oss图片域名
   * @param domain 域名
   * @param path 图片路径
   */
  Future<bool> img_domain_is_ok(String domain) async {
    // 拼接完整的图片域名
    String url = domain;
    Completer<bool> completer = Completer<bool>();
    try {
      // HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
      // HttpClientResponse response = await request.close();
      // print(response);
      // if (response.statusCode == HttpStatus.ok) {
      //     // todo
      //     // UserCtr.setCommonImgDomain(domain); // 设置用户图片
      //     DOMAIN_RESULT.img_domains = lodash.uniq([
      //       domain,
      //       ...DOMAIN_RESULT.img_domains
      //     ]);
      // }
      Response response = await Dio().get(url);
      if (response.statusCode == HttpStatus.ok) {
        // todo
        // UserCtr.setCommonImgDomain(domain); // 设置用户图片
        DOMAIN_RESULT.img_domains =
            lodash.uniq([domain, ...DOMAIN_RESULT.img_domains]);
        StringKV.imgUrl.save(DOMAIN_RESULT.img_domains.first);
        AppLogger.debug("imgUrl ${StringKV.imgUrl.get() ?? ''}");
        completer.complete(true);
      }
    } catch (e) {
      // print(url);
      completer.complete(false);
    }
    return completer.future;
  }

/*
   * 检测设置ossjt_static域名
   * @param domain 域名
   * @param path 图片路径
   */
  Future<bool> jt_static_domain_is_ok(String domain, String path) async {
    // 拼接完整的图片域名
    String url = domain + path;
    Completer<bool> completer = Completer<bool>();
    try {
      Response response = await Dio().get(url);
      if (response.statusCode == HttpStatus.ok) {
        DOMAIN_RESULT.jt_static_domains =
            lodash.uniq([domain, ...DOMAIN_RESULT.jt_static_domains]);
        // StringKV.jtStaticUrl.save(DOMAIN_RESULT.jt_static_domains.first,toFile: false);
        StringKV.jtStaticUrl.save(domain);
        AppLogger.debug("成功更新 jt_static 图片域名为: $domain");
        completer.complete(true);
      }
    } catch (e) {
      AppLogger.error('jt_static 域名验证失败: $url, 错误: $e');
      // print(url);
      completer.complete(false);
    }
    return completer.future;
  }

// 解析外部进来的url参数
  UrlModel parseUrl(String url) {
    Uri uri = Uri.parse(url);
    var domain;
    try {
      domain = uri.origin;
    }catch(e){
      print(e);
    }
    Map params = uri.queryParameters;

    var token = params['token'];
    var gr = params['gr'];
    var api = params['api'];
    var lang = params['lg'] ?? params['lang'];
    var theme = params['theme'];
    var topic = params['topic'];
    var pb = params['pb'];
    var env = params['env'];
    // String rdm = params['rdm'].toString();
    // String project = params['project'].toString();

    UrlModel res = UrlModel();
    res.domain = domain;
    res.api = api;
    res.token = token;
    res.gr = gr;
    res.topic = topic;
    res.theme = theme;
    res.lang = lang;
    res.pb = pb;
    res.env = env;
    // res.rdm = rdm;
    // res.project = project;
    return res;
  }

/*
   * @description: 获取本地的oss文件路径(增加本域名的oss url地址)
   */
  get_oss_urls() {
    // 获取本地的oss_url_obj路径  json数组
    List domains = ['https://xbnhjktbwggfvyok.ybgjhb.com/prod.json'];
    return domains;
  }
}