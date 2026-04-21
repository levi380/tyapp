import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  final String localhost;

  MyHttpOverrides(this.localhost);


  @override
  HttpClient createHttpClient(SecurityContext? context)  {
    var http = super.createHttpClient(context);
    try {
      http.findProxy = (uri) {
        return "PROXY $localhost";
      };

      http.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return http;
    } catch (e) {
    }
    return http;
  }
}
