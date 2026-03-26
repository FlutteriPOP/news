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

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const NewsScreen(),
      binding: NewsBinding(),
    ),
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
