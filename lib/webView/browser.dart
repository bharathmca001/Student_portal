import 'package:url_launcher/url_launcher.dart';

class Browser {
  Future<void> launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: false,
      enableJavaScript: true,
      universalLinksOnly: false,
      enableDomStorage: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
