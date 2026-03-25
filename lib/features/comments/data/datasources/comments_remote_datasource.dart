import 'package:dio/dio.dart';

import '../models/comment_model.dart';

abstract class CommentsRemoteDataSource {
  Future<CommentModel> getCommentById(int id);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  CommentsRemoteDataSourceImpl(this.client);
  final Dio client;

  @override
  Future<CommentModel> getCommentById(int id) async {
    final response = await client.get('item/$id.json');
    if (response.statusCode == 200) {
      if (response.data == null) {
        throw Exception('Comment not found');
      }
      return CommentModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }
}
