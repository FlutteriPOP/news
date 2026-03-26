import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/base_controller.dart';
import '../../../../core/network/dio_client.dart';
import '../models/comment.dart';

class CommentsController extends BaseController {
  CommentsController({required this.initialCommentIds});
  final List<int> initialCommentIds;
  final Dio _dio = Get.find<DioClient>().dio;

  final RxList<Comment> comments = <Comment>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future<void> fetchComments() async {
    if (initialCommentIds.isEmpty) return;

    showLoading();
    clearError();
    try {
      final results = await Future.wait(
        initialCommentIds.map((id) => _fetchRecursive(id)),
      );
      comments.value = results.whereType<Comment>().toList();
    } catch (e) {
      setError(e.toString());
    } finally {
      hideLoading();
    }
  }

  Future<Comment?> _fetchRecursive(int id) async {
    try {
      final response = await _dio.get('item/$id.json');
      if (response.statusCode == 200 && response.data != null) {
        final comment = Comment.fromJson(response.data);
        if (comment.kids.isEmpty) return comment;

        final replies = await Future.wait(
          comment.kids.map((kidId) => _fetchRecursive(kidId)),
        );
        return comment.copyWith(replies: replies.whereType<Comment>().toList());
      }
    } catch (e) {
      // Silently fail for individual comments
    }
    return null;
  }
}
