import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../login/login_head_import.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(已失效)控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能管理预约投注的数据加载、时间选择、状态更新等功能。
    - 注单状态监听bug，监听提前结算，赛事详情
    - 注单已失效-注单单号，注单时间，注单详情，注单投注额，注单预约中状态
    - 注单已失效-单关
    - 注单已失效-全部，今日，昨日，一周，自定义
    - `listData`：存储预约投注的数据列表。
    - `loading`：指示当前是否在加载数据。
    - `refreshController`：用于控制下拉刷新和上拉加载。
    - `startTime` 和 `endTime`：用于展示选择的时间。
    - `startTimestamp` 和 `endTimestamp`：用于网络请求的时间戳。
    - `selectType`：当前选择的时间类型（全部、今日、昨日等）。
    - `openSelectTypeTime`：指示是否开启自定义时间选择。
    - `lastSelectType`：记录上一次选择的时间类型。
    - `page`：用于翻页请求的数据页码。
    - `size`：请求数据的条数。
    - setSelectType()设置时间类型，清除旧数据，并请求数据。
    - showTime()显示自定义时间选择器，更新开始和结束时间。
    - onReady()页面准备好后调用，初始化数据请求。
    - onClose()页面关闭时释放资源。
    - getH5PreBetOrderlist()请求预约投注列表，根据选择的时间类型发送不同的请求，并处理返回的数据。
    】】】
 *
 */
class LapseBetsLogic extends GetxController {
  List<GetH5PreBetOrderlistDataRecordxData> listData = [];

  //加载展示
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  var startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  var endTimestamp = "";

  /// 0:全部 1:今日 2:昨日 3:近7日 4:近30日,5:自定义(自己定义的不传5，传起始时间戳和结束时间)
  var selectType = 0.obs;

  ///开启自定义时间
  var openSelectTypeTime = false.obs;

  ///记录上一次的（0:全部 1:今日 2:昨日 3:近7日 ）
  // var lastSelectType = -1;

  ///网络请求翻页
  var page = 1;

  ///未结算注单统计
  List<String> statistics = ['0', '0.00'];

  ///请求数据条数
  final int size = 300;

  setSelectType(int type) {
    ///防止多次点击
    if (type != 5 && type == selectType.value) {
      return;
    }
    if (type != 5) {
      startTimestamp = "";
      endTimestamp = "";
      startTime.value = "";
      endTime.value = "";
    }
    selectType.value = type;
    openSelectTypeTime.value = false;

    ///切换时间清除就数据
    listData.clear();

    ///重制统计数据
    statistics = ['0', '0.00'];
    loading = true;
    // refreshController.refreshCompleted(resetFooterState: true);
    update();
    getH5PreBetOrderlist();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    // lastSelectType = selectType.value;
    selectType.value = type;
    openSelectTypeTime.value = true;

    ///结束时间
    endTimestamp = DateUtil.formatDateMs(
      DateTime.now().millisecondsSinceEpoch,
      format: DateFormats.y_mo_d,
    );
    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        startTime.value = DateUtil.formatDateMs(
          date[0].millisecondsSinceEpoch,
          format: DateFormats.y_mo_d,
        ).toString();
        startTimestamp = date[0].millisecondsSinceEpoch.toString();

        ///结束时间
        endTime.value = DateUtil.formatDateMs(
          date[1].millisecondsSinceEpoch,
          format: DateFormats.y_mo_d,
        ).toString();

        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {
          endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        } else {
          endTimestamp = date[1].millisecondsSinceEpoch.toString();
        }
        setSelectType(type);
      },
      // cancel: (dynamic) {
      //   selectType.value = lastSelectType;
      // },
    );
  }

  @override
  void onReady() {
    super.onReady();
    getH5PreBetOrderlist();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> getH5PreBetOrderlist() async {
    GetH5PreBetOrderlistEntity res;

    ///当使用时间选择的时候不能传timeType这个参数给后台
    if (selectType.value != 5) {
      ///预投注订单状态(0预约中 ;1预约成功;2.风控预约失败;3.风控取消预约注单.4.用户手动取消预约投注) 比如 [0,1,2,3]
      if (selectType.value == 0) {
        res = await BetApi.instance()
            .getH5PreBetOrderlist([2, 3, 4], '', size: size, page: page);
      } else {
        res = await BetApi.instance().getH5PreBetOrderlist([2, 3, 4], '',
            size: size, page: page, timeType: selectType.value);
      }
    } else {
      res = await BetApi.instance().getH5PreBetOrderlist([2, 3, 4], '',
          size: size,
          page: page,
          beginTime: startTimestamp,
          endTime: endTimestamp);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5PreBetOrderlistData data = res.data;
      statistics[0] = data.total;
      statistics[1] = data.betTotalAmount;
      if (data.record != null && data.record!.isNotEmpty) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        late Map<String, GetH5PreBetOrderlistDataRecordx?> record =
            data.record ?? {};
        if (record.isNotEmpty) {
          List<MapEntry<String, GetH5PreBetOrderlistDataRecordx?>> entries =
              record.entries.toList();
          Map<String, GetH5PreBetOrderlistDataRecordx?> reversedMap =
              Map.fromEntries(entries);

          ///便利map，把数据全部放在一起。
          reversedMap.forEach((key, value) {
            listData.addAll(value!.data);
          });
        }
      }
    }
    loading = false;
    update();
  }
}
