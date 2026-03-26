import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/error_view.dart';
import '../controllers/news_controller.dart';
import '../models/story_type.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/story_card.dart';
import '../widgets/story_search_delegate.dart';

/// Main news screen displaying Hacker News stories with navigation support.
///
/// This screen provides:
/// - Tabbed navigation between different story types
/// - Story cards with intelligent navigation (detail view vs web view)
/// - Pull-to-refresh functionality
/// - Infinite scroll pagination
/// - Search functionality
/// - Repository link in app bar
class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

  /// Handles navigation to the repository
  void _navigateToRepository() {
    UrlLauncherUtils.launch('https://github.com/birmehto/news');
  }

  /// Handles search functionality
  void _handleSearch() {
    showSearch(
      context: Get.context!,
      delegate: StorySearchDelegate(controller.stories),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WHACK',
          style: ShadTheme.of(
            context,
          ).textTheme.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ShadTheme.of(context).colorScheme.background,
        actions: [
          // Search button
          ShadButton.ghost(
            onPressed: _handleSearch,
            child: const Icon(LucideIcons.search),
          ),
          const SizedBox(width: 8),
          // Repo button
          ShadButton.ghost(
            onPressed: _navigateToRepository,
            child: const Icon(LucideIcons.code),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GetBuilder<NewsController>(
            builder: (controller) => CustomTabBar(
              tabs: StoryType.values,
              tabController: controller.tabController,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: StoryType.values.map((type) {
          return _buildStoriesList(type);
        }).toList(),
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
