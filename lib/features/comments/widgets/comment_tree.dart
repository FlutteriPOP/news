import 'package:flutter/material.dart';

import '../models/comment.dart';
import 'comment_tile.dart';

class CommentTree extends StatelessWidget {
  const CommentTree({
    required this.comment,
    super.key,
    this.depth = 0,
    this.isExpanded = false,
    this.onToggleExpanded,
    this.controller,
  });

  final Comment comment;
  final int depth;
  final bool isExpanded;
  final VoidCallback? onToggleExpanded;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    final hasReplies = comment.replies.isNotEmpty;
    final effectiveDepth = depth.clamp(0, 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main comment with proper indentation
        Container(
          margin: EdgeInsets.only(
            left: effectiveDepth == 0 ? 0.0 : 24.0,
            bottom: 8.0,
          ),
          child: CommentTile(
            comment: comment,
            showRepliesButton: hasReplies,
            isRepliesVisible: isExpanded,
            onToggleReplies: hasReplies ? onToggleExpanded : null,
          ),
        ),

        // Replies section - nested CommentTrees for replies
        if (hasReplies && isExpanded)
          ...comment.replies.map(
            (reply) => CommentTree(
              comment: reply,
              depth: depth + 1,
              isExpanded: controller?.isCommentExpanded(reply.id) ?? false,
              onToggleExpanded: controller != null
                  ? () => controller.toggleCommentExpansion(reply.id)
                  : null,
              controller: controller,
            ),
          ),
      ],
    );
  }
}
