import 'package:flutter/material.dart';

import '../models/comment.dart';
import 'comment_tile.dart';

class CommentTree extends StatefulWidget {
  const CommentTree({required this.comment, super.key, this.depth = 0});
  final Comment comment;
  final int depth;

  @override
  State<CommentTree> createState() => _CommentTreeState();
}

class _CommentTreeState extends State<CommentTree> {
  bool _showReplies = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Limit indentation to prevent horizontal overflow on deep threads
    final bool canIndent = widget.depth < 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentTile(
          comment: widget.comment,
          showRepliesButton: widget.comment.replies.isNotEmpty,
          isRepliesVisible: _showReplies,
          onToggleReplies: () {
            setState(() {
              _showReplies = !_showReplies;
            });
          },
        ),
        if (widget.comment.replies.isNotEmpty && _showReplies)
          Padding(
            padding: EdgeInsets.only(
              left: canIndent ? 19.5 : 0, // Align with center of 32px avatar
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  if (canIndent) ...[
                    // Vertical Line
                    Container(
                      width: 1.5,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      children: widget.comment.replies
                          .map(
                            (reply) => CommentTree(
                              comment: reply,
                              depth: widget.depth + 1,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
