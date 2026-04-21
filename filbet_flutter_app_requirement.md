# Filbet Flutter 綜合盤 App 需求文檔







所有的定义的 GetxController 都需要继承  GetXBaseController
如果用的背景图的继承 CustomScffold
网络图片 network_image 用这个类
需要特定的navbar  用 titlebar 
日志 用 Logger
弹窗  可以看看这个 SkBaseDialog
主题 用 theme_service
http 接口
home_view_controller.dart  有列子代码
需要持有的view want_keep_alive_widget

 使用vc的 自带加载

  Future<String> platformList() async {
    var response = await HttpClient.get(Api.platformList,
        queryParameters: {"page": 1, "page_size": 10, "game_type": 0});
    if (response.status == false) {
      throw response.error!;
    }

    return response.message ?? "";
  }

    fetchHandler<String>(
        loading: true,
        platformList(),
        onSuccess: (response) {},
        onError: (exception) {},
      );

 python3 scripts/upload_ios.py  

APK
flutter build apk --dart-define=ENV=prod -Penv=prod --dart-define=BUILD_TIME="$(date +%Y-%m-%d\ %H:%M:%S)"

flutter build apk --dart-define=ENV=dev -Penv=dev --dart-define=BUILD_TIME="$(date +%Y-%m-%d\ %H:%M:%S)"
python3 scripts/upload_apk.py  

IPA
./scripts/build_ios.sh prod

    
  


  sh scripts/launcher_icon.sh