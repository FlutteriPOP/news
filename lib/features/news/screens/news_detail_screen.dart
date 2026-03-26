import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/utils/time_formatter.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../core/widgets/app_loader.dart';
import '../../comments/controllers/comments_controller.dart';
import '../../comments/widgets/comment_tree.dart';
import '../models/story.dart';

class NewsDetailScreen extends GetView<CommentsController> {
  const NewsDetailScreen({required this.story, super.key});
  final Story story;

  @override
  String? get tag => story.id.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          if (story.url != null)
            ShadButton.ghost(
              onPressed: () => UrlLauncherUtils.launch(story.url!),
              child: const Icon(Icons.open_in_new),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ShadCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ShadBadge(child: Text('${story.score} points')),
                            ShadBadge.outline(child: Text(story.author)),
                            ShadBadge.secondary(
                              child: Text('${story.commentsCount} comments'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'Posted ${TimeFormatter.formatRelative(story.dateTime)}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.comment,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  ShadBadge.outline(
                    child: Text(story.commentsCount.toString()),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            sliver: Obx(() {
              if (controller.isLoading.value) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: AppLoader(message: 'Loading comments...'),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorView(
                    message: controller.errorMessage.value,
                    onRetry: () => controller.fetchComments(),
                  ),
                );
              }

              if (controller.comments.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('No comments yet')),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      CommentTree(comment: controller.comments[index]),
                  childCount: controller.comments.length,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
