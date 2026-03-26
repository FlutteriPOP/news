import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

/// HTTP client wrapper using Dio for network requests.
///
/// This class extends GetxService to provide dependency injection
/// and lifecycle management through GetX. It handles:
/// - Base URL configuration from environment variables
/// - Timeout settings for connectivity
/// - Default headers and content type
/// - Error handling configuration
class DioClient extends GetxService {
  /// The Dio instance used for making HTTP requests
  late Dio dio;

  /// Initializes the Dio client with configuration from environment variables.
  ///
  /// Sets up:
  /// - Base URL from BASE_URL environment variable
  /// - Connection timeout (10 seconds)
  /// - Receive timeout (10 seconds)
  /// - Default content type to application/json
  ///
  /// Returns the initialized DioClient instance for chaining
  Future<DioClient> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'].toString(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );
    return this;
  }
}
