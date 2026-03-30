import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/widgets/app_bar.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_section.dart';
import '../widgets/theme_selector.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar using reusable component
            AppAppBar(
              title: 'Settings',
              showBackButton: true,
              actions: [
                ShadButton.ghost(
                  onPressed: () => _showResetDialog(context),
                  child: const Icon(Icons.restore),
                ),
              ],
            ),

            // Settings Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Appearance Section
                    SettingsSection(
                      title: 'Appearance',
                      children: [
                        Obx(
                          () => ThemeSelector(
                            currentTheme: controller.themeMode.value,
                            onThemeChanged: controller.saveThemeMode,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Notifications Section
                    SettingsSection(
                      title: 'Notifications',
                      children: [
                        Obx(
                          () => ShadSwitch(
                            value: controller.notificationsEnabled.value,
                            onChanged: controller.saveNotificationsEnabled,
                            label: const Text('Enable notifications'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Content Section
                    SettingsSection(
                      title: 'Content',
                      children: [
                        Obx(
                          () => ShadSwitch(
                            value: controller.autoRefreshEnabled.value,
                            onChanged: (value) {
                              controller.saveAutoRefreshEnabled(value);
                            },
                            label: const Text('Auto-refresh stories'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => DropdownButton<String>(
                            value: controller.refreshInterval.value,
                            onChanged: controller.autoRefreshEnabled.value
                                ? (value) {
                                    if (value != null) {
                                      controller.saveRefreshInterval(value);
                                    }
                                  }
                                : null,
                            items: controller.refreshIntervals
                                .map(
                                  (interval) => DropdownMenuItem(
                                    value: interval,
                                    child: Text('$interval seconds'),
                                  ),
                                )
                                .toList(),
                            isExpanded: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => ShadSwitch(
                            value: controller.compactViewEnabled.value,
                            onChanged: controller.saveCompactViewEnabled,
                            label: const Text('Compact view'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // About Section
                    SettingsSection(
                      title: 'About',
                      children: [
                        const ListTile(
                          title: Text('Version'),
                          subtitle: Text('0.1.0+1'),
                          leading: Icon(Icons.info_outline),
                        ),
                        ListTile(
                          title: const Text('Source Code'),
                          subtitle: const Text('View on GitHub'),
                          leading: const Icon(Icons.code),
                          onTap: () {
                            // TODO: Add GitHub link
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Reset Settings'),
        description: const Text(
          'Are you sure you want to reset all settings to their default values?',
        ),
        actions: [
          ShadButton.outline(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ShadButton.destructive(
            onPressed: () {
              Get.back();
              controller.resetToDefaults();
              Get.snackbar(
                'Settings Reset',
                'All settings have been reset to defaults',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
