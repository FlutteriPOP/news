import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final theme = ShadTheme.of(context);

    // Limit indentation to prevent horizontal overflow on deep threads
    final bool canIndent = widget.depth < 3;
    final double indentAmount = 20.0 + (widget.depth * 16.0);

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
          Container(
            margin: EdgeInsets.only(left: canIndent ? indentAmount : 0, top: 4),
            decoration: canIndent
                ? BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  )
                : null,
            child: Padding(
              padding: EdgeInsets.only(
                left: canIndent ? 16 : 0,
                top: canIndent ? 8 : 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Connection indicator
                  if (canIndent)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: theme.colorScheme.primary.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Replies with enhanced spacing
                  ...widget.comment.replies.asMap().entries.map((entry) {
                    final index = entry.key;
                    final reply = entry.value;
                    final isLast = index == widget.comment.replies.length - 1;

                    return Container(
                      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
                      child: CommentTree(
                        comment: reply,
                        depth: widget.depth + 1,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
