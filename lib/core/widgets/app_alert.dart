import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppAlertType { info, success, error, warning }

class AppAlert extends StatelessWidget {
  const AppAlert({
    required this.title,
    required this.description,
    super.key,
    this.type = AppAlertType.info,
  });

  final String title;
  final String description;
  final AppAlertType type;

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);

    return ShadCard(
      padding: const EdgeInsets.all(12),
      border: ShadBorder.all(color: color.withOpacity(0.3)),
      backgroundColor: color.withOpacity(0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_getIcon(), color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: color.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case AppAlertType.success:
        return Icons.check_circle;
      case AppAlertType.error:
        return Icons.error;
      case AppAlertType.warning:
        return Icons.warning;
      case AppAlertType.info:
        return Icons.info;
    }
  }

  Color _getColor(BuildContext context) {
    switch (type) {
      case AppAlertType.success:
        return Colors.green;
      case AppAlertType.error:
        return Colors.red;
      case AppAlertType.warning:
        return Colors.orange;
      case AppAlertType.info:
        return Colors.blue;
    }
  }
}
