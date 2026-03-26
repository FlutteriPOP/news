import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'failures.dart';

mixin ErrorHandler {
  Future<Either<Failure, T>> handleErrors<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
