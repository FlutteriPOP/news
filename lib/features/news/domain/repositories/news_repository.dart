import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/story.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<int>>> getTopStoriesIds();
  Future<Either<Failure, List<int>>> getNewStoriesIds();
  Future<Either<Failure, List<int>>> getBestStoriesIds();
  Future<Either<Failure, List<int>>> getAskStoriesIds();
  Future<Either<Failure, List<int>>> getShowStoriesIds();
  Future<Either<Failure, List<int>>> getJobStoriesIds();
  Future<Either<Failure, Story>> getStoryById(int id);
}
