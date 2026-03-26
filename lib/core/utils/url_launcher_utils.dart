import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_alert.dart';

class UrlLauncherUtils {
  static Future<void> launch(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        AppAlert(title: 'Error', description: 'Could not launch $url');
      }
    } catch (e) {
      AppAlert(
        title: 'Error',
        description: 'Could not launch $url',
        type: AppAlertType.error,
      );
    }
  }
}
