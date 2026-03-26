import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../core/widgets/app_loader.dart';
import '../controllers/news_controller.dart';
import '../models/story_type.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/story_card.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WHACK',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
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
