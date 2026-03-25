import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/comments_remote_datasource.dart';
import '../../data/repository_impl/comments_repository_impl.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comments_repository.dart';

final commentsRemoteDataSourceProvider = Provider<CommentsRemoteDataSource>((ref) {
  return CommentsRemoteDataSourceImpl(ref.watch(dioProvider));
});

final commentsRepositoryProvider = Provider<CommentsRepository>((ref) {
  return CommentsRepositoryImpl(ref.watch(commentsRemoteDataSourceProvider));
});

final storyCommentsProvider = FutureProvider.family<List<Comment>, List<int>>((ref, ids) async {
  if (ids.isEmpty) return [];
  final repository = ref.watch(commentsRepositoryProvider);
  
  Future<Comment> fetchRecursive(int id) async {
    final result = await repository.getCommentById(id);
    return await result.fold(
      (failure) => throw Exception(failure.message),
      (comment) async {
        if (comment.kids.isEmpty) return comment;
        final replies = await Future.wait(comment.kids.map((kidId) => fetchRecursive(kidId)));
        return comment.copyWith(replies: replies);
      },
    );
  }

  return await Future.wait(ids.map((id) => fetchRecursive(id)));
});
