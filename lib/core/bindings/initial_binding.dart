import 'package:get/get.dart';
import '../network/dio_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => DioClient().init(), permanent: true);
  }
}
