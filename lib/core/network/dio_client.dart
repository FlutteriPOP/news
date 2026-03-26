import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL'].toString(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );

  // Remove logging for now to debug
  // dio.interceptors.add(LogInterceptor(
  //   requestHeader: true,
  //   requestBody: true,
  //   responseBody: true,
  //   error: true,
  // ));

  return dio;
});
