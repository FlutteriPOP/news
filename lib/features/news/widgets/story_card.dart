import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/utils/string_utils.dart';
import '../../../../core/utils/time_formatter.dart';
import '../models/story.dart';
import '../utils/story_navigation_utils.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({required this.story, super.key});
  final Story story;

  /// Handles navigation when the story card is tapped
  void _handleStoryTap(BuildContext context) {
    StoryNavigationUtils.handleStoryTap(story, context);
  }

  /// Shows context menu with additional options
  void _showContextMenu(BuildContext context) {
    StoryNavigationUtils.showContextMenu(story, context);
  }

  @override
  Widget build(BuildContext context) {
    final timeAgo = TimeFormatter.formatRelative(story.dateTime);
    final navigationHint = StoryNavigationUtils.getNavigationHint(story);
    final hasComments = StoryNavigationUtils.hasComments(story);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ShadTheme.of(context).colorScheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _handleStoryTap(context),
          onLongPress: () => _showContextMenu(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title with better typography
                Text(
                  story.title,
                  style: ShadTheme.of(context).textTheme.h4.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.4,
                    color: ShadTheme.of(context).colorScheme.foreground,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Navigation hint with better styling
                if (navigationHint.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ShadTheme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      navigationHint,
                      style: ShadTheme.of(context).textTheme.muted.copyWith(
                        color: ShadTheme.of(context).colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // URL section with better design
                if (story.url != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ShadTheme.of(
                        context,
                      ).colorScheme.muted.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.link,
                          size: 14,
                          color: ShadTheme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            StringUtils.extractDomain(story.url!),
                            style: ShadTheme.of(context).textTheme.muted
                                .copyWith(
                                  color: ShadTheme.of(
                                    context,
                                  ).colorScheme.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Metadata section with better layout
                Row(
                  children: [
                    // Score badge with improved design
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: hasComments
                            ? ShadTheme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1)
                            : ShadTheme.of(
                                context,
                              ).colorScheme.muted.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.arrowUp,
                            size: 12,
                            color: hasComments
                                ? ShadTheme.of(context).colorScheme.primary
                                : ShadTheme.of(
                                    context,
                                  ).colorScheme.mutedForeground,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            story.score.toString(),
                            style: ShadTheme.of(context).textTheme.muted
                                .copyWith(
                                  color: hasComments
                                      ? ShadTheme.of(
                                          context,
                                        ).colorScheme.primary
                                      : ShadTheme.of(
                                          context,
                                        ).colorScheme.mutedForeground,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Author info
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.user,
                            size: 14,
                            color: ShadTheme.of(
                              context,
                            ).colorScheme.mutedForeground,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              story.author,
                              style: ShadTheme.of(context).textTheme.muted
                                  .copyWith(
                                    color: ShadTheme.of(
                                      context,
                                    ).colorScheme.mutedForeground,
                                    fontSize: 12,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Comments badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: hasComments
                            ? ShadTheme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.1)
                            : ShadTheme.of(
                                context,
                              ).colorScheme.muted.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: hasComments
                              ? ShadTheme.of(
                                  context,
                                ).colorScheme.secondary.withOpacity(0.3)
                              : ShadTheme.of(context).colorScheme.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.messageCircle,
                            size: 12,
                            color: hasComments
                                ? ShadTheme.of(context).colorScheme.secondary
                                : ShadTheme.of(
                                    context,
                                  ).colorScheme.mutedForeground,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            story.commentsCount.toString(),
                            style: ShadTheme.of(context).textTheme.muted
                                .copyWith(
                                  color: hasComments
                                      ? ShadTheme.of(
                                          context,
                                        ).colorScheme.secondary
                                      : ShadTheme.of(
                                          context,
                                        ).colorScheme.mutedForeground,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Time info with subtle styling
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 12,
                      color: ShadTheme.of(
                        context,
                      ).colorScheme.mutedForeground.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: ShadTheme.of(context).textTheme.muted.copyWith(
                        color: ShadTheme.of(
                          context,
                        ).colorScheme.mutedForeground.withOpacity(0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
