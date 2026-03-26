import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../core/utils/time_formatter.dart';
import '../models/story.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({required this.story, super.key});
  final Story story;

  @override
  Widget build(BuildContext context) {
    final timeAgo = TimeFormatter.formatRelative(story.dateTime);

    return ShadCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(Routes.NEWS_DETAIL, arguments: story);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              story.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            if (story.url != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      StringUtils.extractDomain(story.url!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                ShadBadge(child: Text('${story.score} points')),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          story.author,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ShadBadge.outline(
                  child: Text('${story.commentsCount} comments'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
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
