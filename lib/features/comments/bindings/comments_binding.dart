import 'package:get/get.dart';

import '../../news/models/story.dart';
import '../controllers/comments_controller.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    final story = Get.arguments as Story;
    Get.lazyPut<CommentsController>(
      () => CommentsController(initialCommentIds: story.kids),
      tag: story.id.toString(),
    );
  }
}
