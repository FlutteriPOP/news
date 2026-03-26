import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/utils/time_formatter.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../models/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    required this.comment,
    super.key,
    this.onToggleReplies,
    this.showRepliesButton = false,
    this.isRepliesVisible = false,
  });

  final Comment comment;
  final VoidCallback? onToggleReplies;
  final bool showRepliesButton;
  final bool isRepliesVisible;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                comment.displayAuthor.isNotEmpty
                    ? comment.displayAuthor.substring(0, 1).toUpperCase()
                    : 'A',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author and Time
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '@${comment.displayAuthor}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TimeFormatter.formatRelative(comment.dateTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Comment Text
                Html(
                  data: comment.text,
                  onLinkTap: (url, _, _) {
                    if (url != null) {
                      UrlLauncherUtils.launch(url);
                    }
                  },
                  style: {
                    'body': Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      fontSize: FontSize(14),
                      lineHeight: const LineHeight(1.5),
                      color: theme.colorScheme.onSurface,
                    ),
                    'p': Style(margin: Margins.only(bottom: 6)),
                    'a': Style(
                      color: theme.colorScheme.primary,
                      textDecoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                    ),
                    'code': Style(
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      padding: HtmlPaddings.all(4),
                      fontFamily: 'monospace',
                      fontSize: FontSize(12),
                    ),
                  },
                ),
                // Actions: Show Replies
                if (showRepliesButton && comment.replies.isNotEmpty)
                  GestureDetector(
                    onTap: onToggleReplies,
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isRepliesVisible
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isRepliesVisible
                                ? 'Hide replies'
                                : '${comment.replies.length} ${comment.replies.length == 1 ? 'reply' : 'replies'}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
