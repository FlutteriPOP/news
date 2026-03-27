// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../../features/comments/bindings/comments_binding.dart';
import '../../features/news/bindings/news_binding.dart';
import '../../features/news/models/story.dart';
import '../../features/news/screens/news_detail_screen.dart';
import '../../features/news/screens/news_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  /// The initial route when the app starts
  static const INITIAL = Routes.HOME;

  /// List of all application routes
  ///
  /// Each GetPage defines:
  /// - [name]: The route path
  /// - [page]: The widget to display
  /// - [binding]: The dependency injection binding for this route
  static final routes = [
    // Home/News screen route
    GetPage(
      name: _Paths.HOME,
      page: () => const NewsScreen(),
      binding: NewsBinding(),
    ),

    // News detail screen route
    // Expects a Story object as navigation argument
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () {
        final story = Get.arguments as Story;
        return NewsDetailScreen(story: story);
      },
      binding: CommentsBinding(),
    ),
  ];
}
