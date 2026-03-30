import 'package:flutter/material.dart';

class MetadataItem extends StatelessWidget {
  const MetadataItem({
    required this.icon,
    required this.text,
    super.key,
    this.color,
    this.iconSize,
    this.fontSize,
  });
  final IconData icon;
  final String text;
  final Color? color;
  final double? iconSize;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize ?? 14,
          color: color ?? theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color ?? theme.colorScheme.onSurfaceVariant,
              fontSize: fontSize ?? 12,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
