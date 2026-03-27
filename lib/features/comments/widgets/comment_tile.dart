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
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar, author, and time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(comment: comment),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AuthorBadge(comment: comment),
                    const SizedBox(height: 4),
                    _TimeChip(dateTime: comment.dateTime),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Comment content
          _Content(comment: comment),

          // Replies button
          if (_shouldShowReplies) ...[
            const SizedBox(height: 8),
            _RepliesButton(
              count: comment.replies.length,
              isVisible: isRepliesVisible,
              onTap: onToggleReplies,
            ),
          ],
        ],
      ),
    );
  }

  bool get _shouldShowReplies =>
      showRepliesButton && comment.replies.isNotEmpty;
}

/// ============================
/// AVATAR
/// ============================

class _Avatar extends StatelessWidget {
  const _Avatar({required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final authorName = comment.displayAuthor;
    final initial = authorName.isNotEmpty && authorName != '[deleted]'
        ? authorName[0].toUpperCase()
        : 'D'; // D for deleted

    return CircleAvatar(
      radius: 16,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Text(
        initial,
        style: const TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// ============================
/// AUTHOR BADGE
/// ============================

class _AuthorBadge extends StatelessWidget {
  const _AuthorBadge({required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Text(
      comment.displayAuthor,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Colors.black87,
      ),
    );
  }
}

/// ============================
/// TIME CHIP
/// ============================

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.dateTime});
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      TimeFormatter.formatRelative(dateTime),
      style: TextStyle(
        fontSize: 11,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

/// ============================
/// CONTENT (HTML)
/// ============================

class _Content extends StatelessWidget {
  const _Content({required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Html(
      data: comment.text,
      onLinkTap: (url, _, _) {
        if (url != null) UrlLauncherUtils.launch(url);
      },
      style: {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(14),
          lineHeight: const LineHeight(1.6),
          color: theme.colorScheme.onSurface,
        ),
        'p': Style(margin: Margins.only(bottom: 8), fontSize: FontSize(14)),
        'a': Style(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration.none,
        ),
        'code': Style(
          backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
          color: theme.colorScheme.onSurface,
          padding: HtmlPaddings.symmetric(horizontal: 6, vertical: 2),
          fontFamily: 'monospace',
          fontSize: FontSize(12),
        ),
        'pre': Style(
          backgroundColor: theme.colorScheme.onSurface.withOpacity(0.3),
          color: theme.colorScheme.onSurface,
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
        ),
      },
    );
  }
}

/// ============================
/// REPLIES BUTTON
/// ============================

class _RepliesButton extends StatelessWidget {
  const _RepliesButton({
    required this.count,
    required this.isVisible,
    required this.onTap,
  });
  final int count;
  final bool isVisible;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadButton.ghost(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVisible ? LucideIcons.chevronUp : LucideIcons.chevronDown,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            isVisible
                ? 'Hide replies'
                : '$count ${count == 1 ? 'reply' : 'replies'}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
