import 'package:get/get.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/news_remote_datasource.dart';
import '../../data/repository_impl/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    // We use Get.find<DioClient>() which is now guaranteed to exist 
    // because we initialized it in main() before the app started.
    Get.lazyPut<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(Get.find<DioClient>().dio),
    );
    Get.lazyPut<NewsRepository>(
      () => NewsRepositoryImpl(Get.find<NewsRemoteDataSource>()),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(repository: Get.find<NewsRepository>()),
    );
  }
}
