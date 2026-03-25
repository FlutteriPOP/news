import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../core/utils/time_formatter.dart';
import '../../domain/entities/comment.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    required this.comment,
    super.key,
    this.depth = 0,
  });
  final Comment comment;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        left: depth == 0 ? 0 : 16,
        right: 16,
        bottom: 16,
      ),
      child: ShadCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Author and Time
              Row(
                children: [
                  // Avatar
                  ShadAvatar(
                    comment.author.isNotEmpty
                        ? comment.author[0].toUpperCase()
                        : 'A',
                  ),
                  const SizedBox(width: 12),

                  // Author Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.author,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          TimeFormatter.formatRelative(comment.time),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Comment Content
              HtmlWidget(
                comment.text,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurface,
                ),
                customStylesBuilder: (element) {
                  switch (element.localName) {
                    case 'body':
                      return {'margin': '0', 'padding': '0'};
                    case 'p':
                      return {'margin': '0 0 8px 0', 'line-height': '1.5'};
                    case 'code':
                      return {
                        'background': '#f5f5f5',
                        'padding': '2px 4px',
                        'border-radius': '4px',
                        'font-family': 'monospace',
                      };
                    default:
                      return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
