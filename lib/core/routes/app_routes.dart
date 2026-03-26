// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

/// Route constants used throughout the application.
///
/// This class provides type-safe access to all route names
/// defined in the application. Use these constants instead
/// of hardcoded strings to avoid typos and maintain consistency.
abstract class Routes {
  Routes._();

  /// Home route displaying the news list
  static const HOME = _Paths.HOME;

  /// News detail route for viewing individual stories and comments
  static const NEWS_DETAIL = _Paths.NEWS_DETAIL;
}

/// Path strings for navigation routes.
///
/// This class contains the actual path strings used by the
/// navigation system. These paths should match the route
/// definitions in AppPages.routes.
abstract class _Paths {
  _Paths._();

  /// Root path for the home/news screen
  static const HOME = '/';

  /// Path for news detail screen with story parameter
  static const NEWS_DETAIL = '/news-detail';
}
