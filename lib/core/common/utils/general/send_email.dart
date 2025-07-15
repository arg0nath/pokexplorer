import 'package:url_launcher/url_launcher.dart';

void sendContactEmail() async {
  final Uri mail = Uri.parse('mailto:vamakris07@gmail.com?subject=About pokexplorer');
  if (await launchUrl(mail)) {
  } else {
    throw 'Could not launch';
  }
}
