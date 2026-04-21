

import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全屏赛事分析
    】】】
 *
 */
class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
       LocaleKeys.ouzhou_detail_event_analysis.tr,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
