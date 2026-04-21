import 'package:flutter/material.dart';

import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/cp/widget/cp_ticket_card_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:flutter_ty_app/main.dart';

class CpCollectedTicketGridView extends StatelessWidget {
  const CpCollectedTicketGridView({
    super.key,
    required this.tickets,
    required this.onTicketTap,
    required this.onCancelTicketCollect,
  });

  final List<CpTicketCateList> tickets;
  final ValueChanged<CpTicketCateList> onTicketTap;
  final ValueChanged<CpTicketCateList> onCancelTicketCollect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(CpState.gameGridHPadding).copyWith(bottom: CpState.gameGridBPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: CpState.gameGridMainAxisSpacing,
        crossAxisSpacing: CpState.gameGridCrossAxisSpacing,
        childAspectRatio: isIPad ? 2.2 : 1.5,
      ),
      itemCount: tickets.length,
      itemBuilder: (BuildContext context, int index) {
        final ticket = tickets[index];
        return CpTicketCardWidget(
          onTicketTap: onTicketTap,
          ticket: ticket,
          onTicketCollectTap: onCancelTicketCollect,
        );
      },
    );
  }
}
