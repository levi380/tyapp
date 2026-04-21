

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';

import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';

/// 增值赔率模版
class AddedTemp extends StatefulWidget {
  const AddedTemp(
      {super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  @override
  State<AddedTemp> createState() => _AddedTempState();
}

class _AddedTempState extends State<AddedTemp> {
  @override
  Widget build(BuildContext context) {
    MatchEntity? match =
        DataStoreController.to.getMatchById(widget.matchHps.mid);

    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        // 其他
        ...widget.matchHps.hl.first.ol.map((e) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: OddsButton(
              height: widget.fullscreen ? 44.5 : 44.5.h,
              match: match,
              hps: e.ppHps,
              ol: e,
              hl: e.pHl,
              isDetail: true,
              fullscreen: widget.fullscreen,
              direction: OddsTextDirection.horizontal,
            ),
          );
        }),
      ],
    );
  }
}
