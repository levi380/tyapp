abstract class MenuUtil {
  static String getCSIDFromMi(int mi) {
    String csid = "";
    List<int> v1_mi = [0, 300, 600, 2000, 50000];
    if (v1_mi.contains(mi)) {
      csid = "";
    } else if (mi < 300) {
      csid = (mi - 100).toString();
    } else if (mi > 1000 && mi < 2000) {
      String num = mi.toString().substring(0, 3);
      csid = ((int.tryParse(num) ?? 101) - 100).toString();
    } else if (mi > 400 && mi < 1000) {
      csid = (mi - 400).toString();
    } else if (mi > 2000 && mi < 3000) {
      csid = (mi - 2000).toString();
    } else if (mi > 30000) {
      csid = (mi - 30000).toString();
    } else {
      csid = mi.toString();
    }
    return csid;
  }
}
