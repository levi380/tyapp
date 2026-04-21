import 'package:flutter/material.dart';

/**
 * 只是写了个增值赔率样式，暂时没涉及到功能
 */
class AppreciationOddsWidget extends StatefulWidget {
  const AppreciationOddsWidget({super.key});

  @override
  State<AppreciationOddsWidget> createState() => _AppreciationOddsState();
}

class _AppreciationOddsState extends State<AppreciationOddsWidget> {
  // int _selectedTopTab = 0;
  int _selectedSubTab = 1; // 赔率增值是第二个tab

  // final List<String> _topTabs = [
  //   '投注',
  //   '赛况',
  //   '首发',
  //   '前瞻',
  //   '聊天',
  //   '红单',
  // ];

  final List<String> _subTabs = [
    '所有投注',
    '赔率增值',
    '让球&大小',
    '半场',
    '进球',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // 二级导航栏
            _buildSubNavigationBar(),
            // 主要内容区域
            Expanded(
              child: _buildContentArea(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTopNavigationBar() {
  //   return Container(
  //     color: Colors.white,
  //     height: 50,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: _topTabs.length,
  //       itemBuilder: (context, index) {
  //         final isSelected = index == _selectedTopTab;
  //         return GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               _selectedTopTab = index;
  //             });
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //             decoration: BoxDecoration(
  //               border: Border(
  //                 bottom: BorderSide(
  //                   color: isSelected ? Colors.blue : Colors.transparent,
  //                   width: 2,
  //                 ),
  //               ),
  //             ),
  //             child: Text(
  //               _topTabs[index],
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 color: isSelected ? Colors.blue : Colors.black87,
  //                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildSubNavigationBar() {
    return Container(
      color: Colors.white,
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _subTabs.length + 1, // +1 for dropdown icon
        itemBuilder: (context, index) {
          if (index == _subTabs.length) {
            // Dropdown icon
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.grey,
              ),
            );
          }
          final isSelected = index == _selectedSubTab;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSubTab = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _subTabs[index],
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.blue : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentArea() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 波胆 1-1 卡片
          _buildOddsBoostCard('波胆 1-1', 3.25, 3.70),
          const SizedBox(height: 12),
          // 半场/全场/和/和 卡片
          _buildOddsBoostCard('半场/全场/和/和', 4.75, 5.13),
          const SizedBox(height: 12),
          // 上半场-波胆 0-0 卡片
          _buildOddsBoostCard('上半场-波胆 0-0', 3.72, 4.25),
          const SizedBox(height: 12),
          // 全场独赢(0-0) 比赛信息卡片
          _buildMatchInfoCard(
            title: '全场独赢(0-0)',
            match: '克拉拉·陶森 VS 瓦尔瓦拉·格拉切娃',
            league: '意大利甲级联赛',
          ),
          const SizedBox(height: 12),
          // 总进球(0-0) 比赛信息卡片
          _buildMatchInfoCard(
            title: '总进球(0-0)',
            match: '皇家马德里 VS 马德里体育会',
            league: '西班牙甲级联赛',
          ),
          const SizedBox(height: 12),
          // 让球(0-0) 比赛信息卡片
          _buildMatchInfoCard(
            title: '让球(0-0)',
            match: '中央海岸水手足球俱乐部 VS 女王公园',
            league: '意大利甲级联赛',
          ),
          const SizedBox(height: 12),
          // 3串1增值 卡片
          _buildOddsBoostCard('3串1增值', 3.25, 3.70),
        ],
      ),
    );
  }

  Widget _buildOddsBoostCard(String betType, double originalOdds, double boostedOdds) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            betType,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                originalOdds.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                boostedOdds.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_upward,
                size: 18,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchInfoCard({
    required String title,
    required String match,
    required String league,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            match,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            league,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

