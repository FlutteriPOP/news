import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'features/news/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  runApp(
    ProviderScope(
      child: ShadApp(
        title: 'Whack',
        theme: ShadThemeData(
          colorScheme: const ShadSlateColorScheme.light(),
          brightness: Brightness.light,
        ),
        darkTheme: ShadThemeData(
          colorScheme: const ShadSlateColorScheme.dark(),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const MainScreen(),
      ),
    ),
  );
}
