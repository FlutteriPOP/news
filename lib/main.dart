import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/network/dio_client.dart';
import 'core/routes/app_pages.dart';

/// Main entry point for the Whack Hacker News client application.
///
/// This function initializes the app by:
/// 1. Loading environment variables from .env file
/// 2. Initializing the DioClient for network requests
/// 3. Setting up the MaterialApp with GetX routing and ShadCN UI theming
void main() async {
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load environment variables from .env file
  await dotenv.load();

  // 2. Initialize DioClient for network requests and make it permanent
  await Get.putAsync(() => DioClient().init(), permanent: true);

  // Run the app with GetX material app and ShadCN UI theming
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whack',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        return ShadApp(
          theme: ShadThemeData(
            colorScheme: const ShadSlateColorScheme.light(),
            brightness: Brightness.light,
          ),
          darkTheme: ShadThemeData(
            colorScheme: const ShadSlateColorScheme.dark(),
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.system,
          home: child,
        );
      },
    ),
  );
}
