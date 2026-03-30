import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/utils/time_formatter.dart';
import '../../../../core/widgets/metadata_item.dart';
import '../../../routes/app_pages.dart';
import '../../bookmarks/services/bookmark_service.dart';
import '../models/story.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({required this.story, super.key});
  final Story story;

  @override
  Widget build(BuildContext context) {
    final timeAgo = TimeFormatter.formatRelative(story.dateTime);

    final theme = Theme.of(context);
    return ShadCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(Routes.NEWS_DETAIL, arguments: story);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with better typography
            Text(
              story.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Metadata section with better layout
            Row(
              children: [
                // Score badge with improved design
                MetadataItem(
                  icon: LucideIcons.arrowUp,
                  text: story.score.toString(),
                  color: theme.colorScheme.primary,
                ),

                const SizedBox(width: 16),

                // Author info
                Expanded(
                  child: MetadataItem(
                    icon: LucideIcons.user,
                    text: story.author,
                  ),
                ),

                // Comments badge
                const SizedBox(width: 8),
                MetadataItem(
                  icon: LucideIcons.messageCircle,
                  text: story.commentsCount.toString(),
                ),
                const SizedBox(width: 8),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                // Time info with subtle styling
                MetadataItem(
                  icon: LucideIcons.clock,
                  text: timeAgo,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  iconSize: 12,
                  fontSize: 11,
                ),
                const Spacer(),
                Obx(
                  () => ShadButton.ghost(
                    onPressed: () => BookmarkService.to.toggleBookmark(story),
                    child: Icon(
                      BookmarkService.to.isBookmarked(story.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 20,
                      color: BookmarkService.to.isBookmarked(story.id)
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
