
enum ShopCartBetStatus {
  Prebook,//预约投注
  // 1-投注状态,2-投注中状态,3-投注成功状态(主要控制完成按钮),4-投注失败状态,5-投注项失效 6-预约中 7-预约成功  8-预约取消
  Normal,
  Betting,
  Success,
  Failure,
  Invalid,
  Prebooking,
  PrebookSuccess,
  PrebookCancel,
  OneClickBetting,
  PartSuccess,
}

enum OddStateType {
  oddUp,
  oddDown,
  none,
  oddOverrun,
}

// data.status（4:拒单、0:接单、3:待确认、2:取消、1:已处理)
// 4,2 失败
// 0,1 成功
// 3 继续拉单
enum OrderStatus {
  success0(0),
  success1(1),
  failure2(2),
  uncomplete3(3),
  failure4(4);

  final int code;
  const OrderStatus(this.code);
}

enum OrderStatusCode {
  failure(0),
  success(1),
  uncomplete(2);

  final int code;
  const OrderStatusCode(this.code);
}

enum BetSeriesType {
  single(1),
  parlay(2),
  combo(100);

  final int code;
  const BetSeriesType(this.code);
}

enum BetAcceptOdds {
  acceptBetter(1),
  acceptAll(2),
  acceptNone(3);

  final int code;
  const BetAcceptOdds(this.code);
}