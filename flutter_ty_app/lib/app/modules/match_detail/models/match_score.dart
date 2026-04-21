class MatchScore {
  String home = "0";
  String away = "0";
  String overtime_home = "0";
  String overtime_away = "0";

  MatchScore({
    required this.home,
    required this.away,
    this.overtime_home = "0",
    this.overtime_away = "0",
  });
}
