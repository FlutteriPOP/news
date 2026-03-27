import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message, this.fullScreen = false});

  final String? message;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 12),
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (!fullScreen) {
      return Center(child: loader);
    }

    return Container(
      color: theme.colorScheme.surface.withOpacity(0.8),
      alignment: Alignment.center,
      child: loader,
    );
  }
}
