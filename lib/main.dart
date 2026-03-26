import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/network/dio_client.dart';
import 'core/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load environment variables
  await dotenv.load();

  // 2. Initialize critical services and await them
  await Get.putAsync(() => DioClient().init(), permanent: true);

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
