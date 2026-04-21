
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_sporting_event_item.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_sporting_event_model.dart';

/// VR 体育赛事列表组件
///
/// 用于在 VR 模块首页展示可切换的体育赛事类型（如足球、篮球、赛马等）。
/// 支持通过 [TabController] 联动切换，也可独立使用。
class VrSportingEventsRow extends StatefulWidget {
  /// 外部传入的赛事菜单列表
  /// 如果为空，则会尝试使用 [eventsFromModels] 获取，或使用内部默认配置
  final List<VrSportingEventModel> sportsMenus;

  /// 默认选中的索引，默认为 0
  final int defaultSelIndex;

  /// 赛事切换回调
  /// 当用户点击某个赛事图标时触发，返回选中的索引
  final ValueChanged<int>? onEventChanged;

  /// 动态获取赛事列表的回调函数
  /// 返回一个包含 Map 数据的列表，用于兼容旧的数据结构
  final List<Map> Function()? eventsFromModels;

  /// 外部传入的 TabController，用于实现联动效果
  final TabController? tabController;

  /// 构造函数
  const VrSportingEventsRow({
    Key? key,
    this.sportsMenus = const [],
    this.defaultSelIndex = 0,
    this.onEventChanged,
    this.eventsFromModels,
    this.tabController,
  }) : super(key: key);

  @override
  State<VrSportingEventsRow> createState() => _VrSportingEventsRowState();
}

/// VR 体育赛事列表组件状态类
class _VrSportingEventsRowState extends State<VrSportingEventsRow> {
  /// 内部维护的赛事列表数据
  List<dynamic> _sportingEvents = [];

  /// 当前选中的索引
  int _selIndex = 0;

  /// 默认的赛事配置列表
  /// 包含：图片名称、选中图片名称、赛事名称、未读消息数
  final List<Map<String, dynamic>> _defaultEvents = [
    {
      'imgName': 'vr_home_football',
      'imgNameSel': 'vr_home_football_sel',
      'eventName': 'VR足球',
      'unreadCount': 25,
    },
    {
      'imgName': 'vr_home_basketball',
      'imgNameSel': 'vr_home_basketball_sel',
      'eventName': 'VR篮球',
      'unreadCount': 36,
    },
    {
      'imgName': 'vr_home_dog',
      'imgNameSel': 'vr_home_dog_sel',
      'eventName': 'VR赛狗',
      'unreadCount': 1258,
    },
    {
      'imgName': 'vr_home_horse',
      'imgNameSel': 'vr_home_horse_sel',
      'eventName': 'VR赛马',
      'unreadCount': 698,
    },
    {
      'imgName': 'vr_home_motorcycle',
      'imgNameSel': 'vr_home_motorcycle_sel',
      'eventName': 'VR摩托车',
      'unreadCount': 120,
    },
    {
      'imgName': 'vr_home_dirt_bike',
      'imgNameSel': 'vr_home_dirt_bike_sel',
      'eventName': '泥地摩托车',
      'unreadCount': 60,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initData();
    // 监听 TabController 变化
    widget.tabController?.addListener(_onTabIndexChanged);
  }

  @override
  void dispose() {
    widget.tabController?.removeListener(_onTabIndexChanged);
    super.dispose();
  }

  /// 初始化数据
  /// 优先级：widget.sportsMenus > widget.eventsFromModels > _defaultEvents
  void _initData() {
    if (widget.sportsMenus.isNotEmpty) {
      _sportingEvents = widget.sportsMenus;
    } else if (widget.eventsFromModels != null) {
      _sportingEvents = widget.eventsFromModels!();
    } else {
      _sportingEvents = _defaultEvents;
    }

    // 确保选中索引不越界
    _selIndex = (_sportingEvents.length > widget.defaultSelIndex)
        ? widget.defaultSelIndex
        : 0;
  }

  /// TabController 索引变化回调
  void _onTabIndexChanged() {
    // 如果 Tab 正在滑动动画中，暂不更新，避免频繁刷新
    if (widget.tabController?.indexIsChanging == true) return;

    final index = widget.tabController?.index ?? 0;
    if (_selIndex != index) {
      _selIndex = index;
      _safeSetState(() {});
    }
  }

  /// 安全更新状态
  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  /// 处理点击事件
  void _handleTap(int index) {
    if (_selIndex == index) return;

    setState(() {
      _selIndex = index;
    });

    // 触发外部回调
    widget.onEventChanged?.call(index);

    // 如果有关联的 TabController，同步更新
    if (widget.tabController != null) {
      widget.tabController!.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      constraints: BoxConstraints(minWidth: Get.width),
      // 使用 TabBar 来展示，因为可能关联了 TabController
      // 但实际上 TabBar 的 item 是自定义的 Widget
      child: TabBar(
        controller: widget.tabController,
        isScrollable: true,
        // 去除默认指示器
        indicator: const BoxDecoration(),
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        // 点击 TabBar item 也会触发 controller 变化
        onTap: (index) {
          _handleTap(index);
        },
        tabs: List.generate(_sportingEvents.length, (index) {
          return _buildTabItem(index);
        }),
      ),
    );
  }

  /// 构建单个 Tab 项
  Widget _buildTabItem(int index) {
    final event = _sportingEvents[index];
    final isSelected = _selIndex == index;

    // 解析数据模型
    String imgName = '';
    String eventName = '';
    int unreadCount = 0;

    if (event is VrSportingEventModel) {
      imgName = isSelected ? event.imgNameSel : event.imgName;
      eventName = event.eventName;
      unreadCount = event.unreadCount;
    } else if (event is Map) {
      final baseImgName = isSelected
          ? (event['imgNameSel'] ?? '')
          : (event['imgName'] ?? '');
      // 兼容本地资源路径拼接
      imgName = baseImgName.startsWith('assets') || baseImgName.startsWith('http')
          ? baseImgName
          : 'assets/images/vr/$baseImgName.png';
      eventName = event['eventName'] ?? '';
      unreadCount = event['unreadCount'] ?? 0;
    }

    return VrSportingEventItem(
      imgName: imgName,
      eventName: eventName,
      unreadCount: unreadCount,
      isSelected: isSelected,
      // TabBar 自身有 onTap 处理，这里不需要额外处理
      // 但如果不用 TabBar，可以在这里加 onTap
    );
  }
}
