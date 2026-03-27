import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/error_view.dart';
import '../controllers/news_controller.dart';
import '../models/story_type.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/story_card.dart';

/// Main news screen displaying Hacker News stories with navigation support.
///
/// This screen provides:
/// - Tabbed navigation between different story types
/// - Story cards with intelligent navigation (detail view vs web view)
/// - Pull-to-refresh functionality
/// - Infinite scroll pagination
/// - Repository link in app bar
class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar using ShadCN UI components
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'WHACK',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  ShadButton.ghost(
                    onPressed: () {
                      // TODO: Add repository link action
                    },
                    child: const Icon(Icons.link),
                  ),
                ],
              ),
            ),

            // Custom Tab Bar
            GetBuilder<NewsController>(
              builder: (controller) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                ),
                child: CustomTabBar(
                  tabs: StoryType.values,
                  tabController: controller.tabController,
                ),
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: StoryType.values.map((type) {
                  return _buildStoriesList(type);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesList(StoryType type) {
    return Obx(() {
      // Only show stories for the current active type
      if (controller.currentStoryType.value != type) {
        return AppLoader(message: 'Loading ${type.displayName} stories...');
      }

      if (controller.isLoading.value && controller.stories.isEmpty) {
        return AppLoader(message: 'Loading ${type.displayName} stories...');
      }

      if (controller.errorMessage.isNotEmpty && controller.stories.isEmpty) {
        return ErrorView(
          message: controller.errorMessage.value,
          onRetry: () => controller.refreshStories(),
        );
      }

      return RefreshIndicator(
        onRefresh: () => controller.refreshStories(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.stories.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.stories.length) {
              if (controller.stories.isEmpty) return const SizedBox.shrink();
              controller.fetchMore();
              return const AppLoader(message: 'Loading more stories...');
            }
            final story = controller.stories[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: StoryCard(story: story),
            );
          },
        ),
      );
    });
  }
}
