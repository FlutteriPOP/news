import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Base controller class that provides common functionality for all controllers.
///
/// This class extends GetxController and provides:
/// - Loading state management with RxBool
/// - Error message handling with RxString
/// - ShadCN UI alert integration for error display
/// - Common loading state methods
///
/// All feature controllers should extend this class to inherit
/// common loading and error handling functionality.
class BaseController extends GetxController {
  /// Reactive boolean to track loading state
  final RxBool isLoading = false.obs;

  /// Reactive string to store error messages
  final RxString errorMessage = ''.obs;

  /// Sets the loading state to true
  void showLoading() => isLoading.value = true;

  /// Sets the loading state to false
  void hideLoading() => isLoading.value = false;

  /// Sets an error message and displays it using ShadCN UI alert
  ///
  /// [message] The error message to display
  /// If the message is empty, no alert will be shown
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

  /// Clears any existing error message
  void clearError() => errorMessage.value = '';
}
