import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../core/widgets/app_bar.dart';
import '../controllers/bookmarks_controller.dart';
import '../widgets/bookmark_card.dart';

class BookmarksScreen extends GetView<BookmarksController> {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar using reusable component
            AppAppBar(
              title: 'Bookmarks',
              showBackButton: true,
              actions: [
                Obx(
                  () => controller.bookmarks.isNotEmpty
                      ? ShadButton.ghost(
                          onPressed: () => _showClearAllDialog(context),
                          child: const Icon(Icons.clear_all),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),

            // Bookmarks List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const AppLoader(message: 'Loading bookmarks...');
                }

                if (controller.errorMessage.isNotEmpty) {
                  return ErrorView(
                    message: controller.errorMessage.value,
                    onRetry: () => controller.loadBookmarks(),
                  );
                }

                if (controller.bookmarks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No bookmarks yet',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bookmark stories to read them later',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.loadBookmarks(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = controller.bookmarks[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: BookmarkCard(
                          bookmark: bookmark,
                          onRemove: () => controller.removeBookmark(bookmark),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Clear All Bookmarks'),
        description: const Text(
          'Are you sure you want to remove all bookmarks?',
        ),
        actions: [
          ShadButton.outline(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ShadButton.destructive(
            onPressed: () {
              Get.back();
              controller.clearAllBookmarks();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
