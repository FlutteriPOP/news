import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final theme = ShadTheme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.8),
                  theme.colorScheme.primary.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                comment.displayAuthor.isNotEmpty
                    ? comment.displayAuthor.substring(0, 1).toUpperCase()
                    : 'A',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.border.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced Author and Time Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            comment.displayAuthor,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6366F1),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.muted.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.clock,
                                size: 10,
                                color: theme.colorScheme.mutedForeground,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                TimeFormatter.formatRelative(comment.dateTime),
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Enhanced Comment Content
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
                          lineHeight: const LineHeight(1.6),
                          color: theme.colorScheme.foreground,
                        ),
                        'p': Style(
                          margin: Margins.only(bottom: 8),
                          fontSize: FontSize(14),
                        ),
                        'a': Style(
                          color: theme.colorScheme.primary,
                          textDecoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize(14),
                        ),
                        'code': Style(
                          backgroundColor: theme.colorScheme.muted.withOpacity(
                            0.3,
                          ),
                          padding: HtmlPaddings.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          fontFamily: 'monospace',
                          fontSize: FontSize(12),
                          color: theme.colorScheme.primary,
                        ),
                        'pre': Style(
                          backgroundColor: theme.colorScheme.muted.withOpacity(
                            0.3,
                          ),
                          padding: HtmlPaddings.all(8),
                          fontFamily: 'monospace',
                          fontSize: FontSize(12),
                        ),
                        'blockquote': Style(
                          border: Border(
                            left: BorderSide(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          padding: HtmlPaddings.only(left: 12),
                          margin: Margins.symmetric(vertical: 8),
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      },
                    ),

                    // Enhanced Replies Button
                    if (showRepliesButton && comment.replies.isNotEmpty)
                      GestureDetector(
                        onTap: onToggleReplies,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.1),
                                theme.colorScheme.primary.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isRepliesVisible
                                    ? LucideIcons.chevronUp
                                    : LucideIcons.chevronDown,
                                size: 14,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isRepliesVisible
                                    ? 'Hide replies'
                                    : '${comment.replies.length} ${comment.replies.length == 1 ? 'reply' : 'replies'}',
                                style: const TextStyle(
                                  color: Color(0xFF6366F1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              if (!isRepliesVisible) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${comment.replies.length}',
                                    style: const TextStyle(
                                      color: Color(0xFF6366F1),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
