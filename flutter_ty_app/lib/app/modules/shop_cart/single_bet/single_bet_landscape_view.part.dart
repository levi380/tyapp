part of 'single_bet_landscape_view.dart';

extension SingleBetLandscapeComponentEx on SingleBetLandscapeComponent{
  Widget _buildBetItem() {
    ShopCartItem shopCartItem = logic.itemList.safeFirst!;
    if (shopCartItem.isColsed) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
          ),
          child: Row(children: [
            _buildCloseButton(),
            Expanded(
              child: _buildClosedItem(),
              /*
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ImageView(
                      'assets/images/shopcart/closed_pic1.png',
                      width: 36,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      LocaleKeys.bet_closed.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14.0.scale,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),

               */
            ),
          ]));
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
          ),
          child: Row(
            children: [
              _buildCloseButton(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  width: 2,
                                  height: 16,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF127DCC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.50),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Obx(
                                      () => Text(
                                    '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                                    style: TextStyle(
                                      color:
                                      Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14.0.scale,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          final oddColor = shopCartItem.oddStateType.value ==
                              OddStateType.oddUp
                              ? const Color(0xFFF53F3F)
                              : shopCartItem.oddStateType.value ==
                              OddStateType.oddDown
                              ? const Color(0xFF00B42A)
                              : Colors.white.withValues(alpha: 0.9);
                          return Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '@',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: oddColor,
                                    fontSize: 14.0.scale,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  shopCartItem.oddFinally.value,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: oddColor,
                                    fontSize: 16.0.scale,
                                    fontFamily: 'Akrobat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 6),
                                if (shopCartItem.matchType == 2) ...[
                                  Text(
                                    '[${LocaleKeys.new_menu_1.tr}]',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF179CFF),
                                      fontSize: 12.0.scale,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  shopCartItem.playName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 12.0.scale,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                if (shopCartItem.sportId == 1) ...[
                                  Text(
                                    shopCartItem.markScore,
                                    style: TextStyle(
                                      color:
                                      Colors.white.withValues(alpha: 0.9),
                                      fontSize: 12.0.scale,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  '[${TYUserController.to.curOddsLabel(shopCartItem.oddsHsw).tr}]',
                                  style: TextStyle(
                                    color: const Color(0xFF179CFF),
                                    fontSize: 12.0.scale,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          final oddColor = shopCartItem.oddStateType.value ==
                              OddStateType.oddUp
                              ? const Color(0xFFF53F3F)
                              : shopCartItem.oddStateType.value ==
                              OddStateType.oddDown
                              ? const Color(0xFF00B42A)
                              : Colors.white.withValues(alpha: 0.9);
                          return Container(
                            child: shopCartItem.oddStateType.value !=
                                OddStateType.none
                                ? Text(
                              LocaleKeys.common_odds_change.tr,
                              style: TextStyle(
                                color: oddColor,
                                fontSize: 12.0.scale,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                                : null,
                          );
                        }),
                      ],
                    ),
                    if (shopCartItem.home.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${shopCartItem.home} VS ${shopCartItem.away}',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12.0.scale,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              shopCartItem.tidName,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12.0.scale,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ));
    }
  }

  Widget _buildClosedItem() {
    ShopCartItem shopCartItem = logic.itemList.safeFirst!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      width: 2,
                      height: 16,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF127DCC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Obx(
                          () => Text(
                        '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                        style: TextStyle(
                          color:
                          Colors.white.withValues(alpha: 0.6),
                          fontSize: 14.0.scale,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              LocaleKeys.bet_close.tr,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.0.scale ,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6),
                    if (shopCartItem.matchType == 2) ...[
                      Text(
                        '[${LocaleKeys.new_menu_1.tr}]',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.0.scale,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                    Text(
                      shopCartItem.playName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.0.scale,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    if (shopCartItem.sportId == 1) ...[
                      Text(
                        shopCartItem.markScore,
                        style: TextStyle(
                          color:
                          Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.0.scale,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                    Text(
                      '[${TYUserController.to.curOddsLabel(shopCartItem.oddsHsw).tr}]',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.0.scale,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (shopCartItem.home.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${shopCartItem.home} VS ${shopCartItem.away}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.0.scale,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  shopCartItem.tidName,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


}