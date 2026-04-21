
import '../../login/login_head_import.dart';

class TriangleDown extends CustomClipper<Path>{
  bool? up;
  TriangleDown({this.up});
  
  @override
  Path getClip(Size size) {
    var path = Path();
    if(up==true) {
      path.moveTo(0, size.height);
      path.lineTo(size.width,  size.height);
      path.lineTo(size.width/2, 0);
      path.close();
    }else{
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width/2, size.height);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}