import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_alert.dart';

/// Utility class for launching URLs in external applications.
///
/// This class provides a safe way to launch URLs with proper
/// error handling and user feedback. It handles:
/// - URL validation and parsing
/// - Checking if the URL can be launched
/// - Launching in appropriate mode (in-app browser)
/// - Error handling with user-friendly messages
class UrlLauncherUtils {
  /// Launches the given URL in an in-app browser view.
  ///
  /// [url] The URL string to launch
  ///
  /// This method will:
  /// 1. Parse and validate the URL
  /// 2. Check if the URL can be launched on the current device
  /// 3. Launch the URL in an in-app browser view
  /// 4. Show appropriate error messages if launching fails
  ///
  /// Shows error alerts using AppAlert if:
  /// - The URL cannot be launched
  /// - An exception occurs during launching
  static Future<void> launch(String url) async {
    try {
      // Parse the URL string into a Uri object
      final uri = Uri.parse(url);

      // Check if the device can launch this URL
      if (await canLaunchUrl(uri)) {
        // Launch the URL in an in-app browser view for better UX
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      } else {
        // Show error if URL cannot be launched
        AppAlert(title: 'Error', description: 'Could not launch $url');
      }
    } catch (e) {
      // Show error for any exceptions during URL launching
      AppAlert(
        title: 'Error',
        description: 'Could not launch $url',
        type: AppAlertType.error,
      );
    }
  }
}
