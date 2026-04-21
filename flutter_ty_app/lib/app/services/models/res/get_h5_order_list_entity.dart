import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/get_pre_settle_order_detail_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_h5_order_list_entity.g.dart';
export 'package:flutter_ty_app/generated/json/get_h5_order_list_entity.g.dart';

@JsonSerializable()
class GetH5OrderListEntity {
	late String code;
	late GetH5OrderListData data;
	late String msg;
	late int ts;

	GetH5OrderListEntity();

	factory GetH5OrderListEntity.fromJson(Map<String, dynamic> json) => $GetH5OrderListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5OrderListData {
	dynamic ascs;
	late String betTotalAmount;
	late String current;
	dynamic descs;
	late bool hasNext;
	late bool hasPrevious;
	late bool optimizeCountSql;
	late String pages;
	late String preBetTotalAmount;
	late String maxWinTotalAmount;
	late String profit;
	@JSONField(name:"record")
	Map<String,GetH5OrderListDataRecordx?>? record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String total;

	GetH5OrderListData();

	factory GetH5OrderListData.fromJson(Map<String, dynamic> json) => $GetH5OrderListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5OrderListDataRecordx {
	late double betAmount;
	late List<GetH5OrderListDataRecordxData> data;
	late int totalOrders;
	late double profit;

	GetH5OrderListDataRecordx();

	factory GetH5OrderListDataRecordx.fromJson(Map<String, dynamic> json) => $GetH5OrderListDataRecordxFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListDataRecordxToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5OrderListDataRecordxData {
	 ///Expand自己新增加的，用来折叠串关用的判断(只有已结注单才有)
	late var isExpand = false.obs;
	///preSettleExpand自己新增加的，用来折叠单关，提前结算信息的view(只有已结注单才有)
	late var preSettleExpand = false.obs;

	///turnOnEarlySettlement自己新增加的,只有当点击后变成true，才能开启提前结算。(只有未结注单，未结算才有)
	late bool turnOnEarlySettlement = false;
	///exhibitEarlySettlement自己新增加的,通过轮询接口订单号才能判断是否展示提前结算。(只有未结注单，未结算才有)
	late bool exhibitEarlySettlement =false;
	///earlySettlementBeingRequested自己新增加的,提前前结算状态，结算中已经发起请求才是true。(只有未结注单，未结算才有)
	late bool earlySettlementBeingRequested =false;
	///earlySettlementSuccessfulType自己新增加的,提前前结算是否成功。(只有未结注单，未结算才有)
	///0:默认没有提前结算，
	///1:提前结算等待中。
	///2:提前结算成功。
	///3:提前结算失败了。
  late int earlySettlementSuccessfulType = 0;


	///0: 预约提前和部分提前按钮不显示
	///1: 预约提前和部分提前按钮显示，折叠关闭
	///2: 预约提前和部分提前按钮显示，折叠开启
	late int earlySettlementState = 0;
  ///0: 预约提前结算
	///1: 部分提前结算
	///2: 两个都不显示
	late int earlySettlementType = 0;

	/// 预约提前结算是否显示
	late bool bookedSettleSwitch =false;
	/// 部分提前结算是否显示
	late bool partSettleSwitch =false;

	/// 预约提前结算按钮状态
	///0:确认提前结算（点击发起提前结算请求）。
	///1:取消预约提前结算，（点击一次后，变成确认取消）
	///2:确认取消预约提前结算（当前状态再点击才会发起请求取消，若没点击轮询接口返，改回1，取消预约提前结算样式）。
	late var earlyAppointmentSettlementType = 0.obs;

	/// 预约提前结算金额，键盘输入金额
	late var earlyAppointmentSettlementAmount = ''.obs;

	/// 预约提前结算,已经预约金额
	late var reserveCashOutAmount=0.00.obs;

  /// 部分提前结算比例
	double earlyProportionSettleRatio = 0.00;

	///3250需求
	///当前比赛倒计时
	late var countdownGameTime= ''.obs;
	///当前比赛比分
	late var currentMatchScores= ''.obs;
  late String acCode;
	late int addition;
	late double backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetH5OrderListDataRecordxDataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	dynamic maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late double orderAmountTotal = 0;
	late String orderNo;
	late String orderStatus;
	late List<GetH5OrderListDataRecordxDataOrderVOS> orderVOS;
	late int outcome;
	late double preBetAmount = 0.00;
	dynamic preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	late double preSettleBetAmount= 0.00;
	late double profitAmount;
  late int seriesSum = 0;
  late String seriesType;
	late String seriesValue;
	late String odds ='';
	late String settleTime;
	late int settleType;
	late double settledAmount;
	///原来接口没有，根据 已结算的提前兑现详情接口数据来获取
	late List<GetPreSettleOrderDetailData> data;
	late bool betIsExpand = true;

	GetH5OrderListDataRecordxData();

	factory GetH5OrderListDataRecordxData.fromJson(Map<String, dynamic> json) => $GetH5OrderListDataRecordxDataFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListDataRecordxDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5OrderListDataRecordxDataDetailList {
	dynamic acceptBetOdds;
	late String awayName;
	late String backAmount;
	late String batchNo;
	late String beginTime;
	late String betAmount;
	late String betNo;
	late int betResult;
	late int betStatus;
	dynamic betTime;
	late int cancelType;
	dynamic childPlayId;
	dynamic closingTime;
	dynamic createTime;
  late String dataSourceCode = "";
  late String eov = '';
  dynamic firstNum;
	late String homeName;
	dynamic isValid;
	late String marketId;
	late String marketName;
	late String marketType;
	late String marketValue;
	late String matchDay;
	late String matchId;
	late String matchInfo = '';
	late int matchManageType;
	late String matchName;
	late int matchOver=0;
	late String matchPeriodId = '';
	dynamic matchStatusId;
	late String matchTestScore;
	late int matchType;
	late int matchVideoTag;
	late String oddFinally;
	late double oddsValue;
	late String optionValue;
	late String orderAmountTotal;
	late String orderNo;
	late String outrightYear;
	late String phase;
	dynamic placeNum;
	late int playId;
	String originalMarketValue ="";
	late String playName;
	late String playOptionName;
	late String playOptions;
	late String playOptionsId;
	late String playOptionsRange;
	late String remark;
	late String riskEvent;
	late String score;
  late String scoreBenchmark = "";
  dynamic secondNum;
	late String secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String thirdMatchId;
	late String tournamentId;
	late String tournamentPic;
	dynamic uid;
	late String userId;



	GetH5OrderListDataRecordxDataDetailList();

	factory GetH5OrderListDataRecordxDataDetailList.fromJson(Map<String, dynamic> json) => $GetH5OrderListDataRecordxDataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListDataRecordxDataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5OrderListDataRecordxDataOrderVOS {
	late String batchNo;
	late String beginTime;
	late int betResult;
	late int betStatus;
	late int cancelType;
	dynamic closingTime;
	late int hs;
	late String langCode;
	late String marketId;
	late String marketType;
	late String marketValue;
	late String matchDay;
	late String matchId;
	late String matchInfo;
	late String matchName;
	late int matchType;
	late String oddFinally;
	late String oddsValue;
	late String outrightYear;
	late int playId;
	late String playName;
	late String playOptions;
	late String playOptionsId;
	 String scoreBenchmark ="";
	late String settleScore;
	late int sportId;
	late String sportName;
	late String tournamentId;
	late String tournamentPic;

	GetH5OrderListDataRecordxDataOrderVOS();

	factory GetH5OrderListDataRecordxDataOrderVOS.fromJson(Map<String, dynamic> json) => $GetH5OrderListDataRecordxDataOrderVOSFromJson(json);

	Map<String, dynamic> toJson() => $GetH5OrderListDataRecordxDataOrderVOSToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

