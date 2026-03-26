import 'package:get/get.dart';

class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;

  void setError(String message) {
    errorMessage.value = message;
    if (message.isNotEmpty) {
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearError() => errorMessage.value = '';
}
