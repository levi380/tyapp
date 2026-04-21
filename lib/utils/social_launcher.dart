import 'package:url_launcher/url_launcher.dart';

class SocialLauncher {
  /// 打开 Telegram
  static Future<void> openTelegram(String username) async {
    final Uri tg = Uri.parse("tg://resolve?domain=$username");
    final Uri web = Uri.parse("https://t.me/$username");

    if (await canLaunchUrl(tg)) {
      await launchUrl(tg, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(web, mode: LaunchMode.externalApplication);
    }
  }

  /// 打开 WhatsApp
  static Future<void> openWhatsApp(String phone) async {
    final Uri url = Uri.parse("https://wa.me/$phone");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  /// 打开 Line
  static Future<void> openLine(String id) async {
    final Uri appUrl = Uri.parse("line://ti/p/~$id");
    final Uri webUrl = Uri.parse("https://line.me/R/ti/p/~$id");

    if (await canLaunchUrl(appUrl)) {
      await launchUrl(appUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  /// 打开 Skype
  static Future<void> openSkype(String username) async {
    final Uri url = Uri.parse("skype:$username?chat");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  /// 打开 YeeChat / YeeCall
  static Future<void> openYeeChat(String username) async {
    final Uri appUrl = Uri.parse("yeecall://user?username=$username");
    final Uri webUrl = Uri.parse("https://www.yeechat.app/");

    if (await canLaunchUrl(appUrl)) {
      await launchUrl(appUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  /// 打电话
  static Future<void> callPhone(String phone) async {
    final Uri url = Uri.parse("tel:$phone");
    await launchUrl(url);
  }

  /// 打开浏览器
  static Future<void> openBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
