import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this.remoteDataSource);
  final NewsRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<int>>> getTopStoriesIds() async {
    try {
      final ids = await remoteDataSource.getTopStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getNewStoriesIds() async {
    try {
      final ids = await remoteDataSource.getNewStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getBestStoriesIds() async {
    try {
      final ids = await remoteDataSource.getBestStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAskStoriesIds() async {
    try {
      final ids = await remoteDataSource.getAskStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getShowStoriesIds() async {
    try {
      final ids = await remoteDataSource.getShowStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getJobStoriesIds() async {
    try {
      final ids = await remoteDataSource.getJobStoriesIds();
      return Right(ids);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Story>> getStoryById(int id) async {
    try {
      final model = await remoteDataSource.getStoryById(id);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
