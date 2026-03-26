import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DioClient extends GetxService {
  late Dio dio;

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
