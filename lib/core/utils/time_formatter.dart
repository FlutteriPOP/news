import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // If the time is in the future, show "just now"
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }

  static String formatShort(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // If the time is in the future, show "now"
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}

class DateTimeUtils {
  static DateTime fromUnix(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
