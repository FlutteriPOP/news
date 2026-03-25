import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comments_repository.dart';
import '../datasources/comments_remote_datasource.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  CommentsRepositoryImpl(this.remoteDataSource);
  final CommentsRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, Comment>> getCommentById(int id) async {
    try {
      final model = await remoteDataSource.getCommentById(id);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsByIds(List<int> ids) async {
    try {
      final results = await Future.wait(
        ids.map((id) => remoteDataSource.getCommentById(id)),
      );
      return Right(results.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
