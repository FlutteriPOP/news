import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    required this.currentTheme,
    required this.onThemeChanged,
    super.key,
  });
  final ThemeMode currentTheme;
  final Function(ThemeMode) onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildThemeOption(
                context,
                'Light',
                Icons.light_mode,
                ThemeMode.light,
                currentTheme == ThemeMode.light,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThemeOption(
                context,
                'Dark',
                Icons.dark_mode,
                ThemeMode.dark,
                currentTheme == ThemeMode.dark,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThemeOption(
                context,
                'System',
                Icons.settings_brightness,
                ThemeMode.system,
                currentTheme == ThemeMode.system,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode theme,
    bool isSelected,
  ) {
    return ShadButton(
      onPressed: () => onThemeChanged(theme),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
