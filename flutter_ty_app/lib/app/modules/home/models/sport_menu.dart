class SportMenu {
  SportMenu({
    required this.mi,
    required this.euid,
    required this.iconIndex,
    required this.title,
    this.count,
    this.sort
  });

  int? count;//数量
  String euid;//
  int iconIndex;//图片下标
  String mi;//`${常规球类csid}${一级菜单id}`; //例如 足球+今日  1012
  int? sort=0;
  String title;//标题名称

  @override
  String toString() {
    return 'SportMenu{mi: $mi, euid: $euid, iconIndex: $iconIndex, title: $title, count: $count  sort: $sort}';
  }
}
