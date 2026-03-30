import 'package:get/get.dart';

import '../../bookmarks/controllers/bookmarks_controller.dart';
import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<BookmarksController>(() => BookmarksController());
  }
}
