import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;

  void setError(String message) {
    errorMessage.value = message;
    if (message.isNotEmpty) {
      ShadAlert.destructive(
        icon: const Icon(LucideIcons.circleAlert),
        title: const Text('Error'),
        description: Text(message),
      );
    }
  }

  void clearError() => errorMessage.value = '';
}
