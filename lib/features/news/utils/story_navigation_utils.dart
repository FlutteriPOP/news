import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/routes/app_pages.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../models/story.dart';

/// Utility class for handling story navigation and actions.
///
/// Provides centralized navigation logic for stories with:
/// - Smart navigation (detail view vs web view)
/// - Context menu options
/// - Share functionality
/// - Link copying
class StoryNavigationUtils {
  const StoryNavigationUtils._();

  /// Handles story tap with intelligent navigation
  ///
  /// Smart navigation logic:
  /// - If story has comments: Show detail view with introduction
  /// - If story has no comments but has URL: Open directly in website
  /// - If story has neither: Show detail view (for Ask HN, Show HN, etc.)
  ///
  /// [story] The story to navigate to
  /// [context] The build context for showing dialogs
  static Future<void> handleStoryTap(Story story, BuildContext context) async {
    if (hasComments(story)) {
      // Story has comments - show detail view with introduction
      Get.toNamed(Routes.NEWS_DETAIL, arguments: story);
    } else if (story.url != null && story.url!.isNotEmpty) {
      // No comments but has URL - open directly in website
      await UrlLauncherUtils.launch(story.url!);
    } else {
      // No comments and no URL - show detail view (e.g., Ask HN, Show HN)
      Get.toNamed(Routes.NEWS_DETAIL, arguments: story);
    }
  }

  /// Checks if a story has comments available
  ///
  /// Returns true if the story has comments or comment IDs
  static bool hasComments(Story story) {
    return story.commentsCount > 0 || story.kids.isNotEmpty;
  }

  /// Shows context menu with additional options
  static Future<void> showContextMenu(Story story, BuildContext context) async {
    final hasCommentsAvailable = hasComments(story);

    await showModalBottomSheet(
      context: context,
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: ShadCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  hasCommentsAvailable
                      ? LucideIcons.messageCircle
                      : LucideIcons.messageSquare,
                  color: hasCommentsAvailable
                      ? null
                      : ShadTheme.of(context).colorScheme.mutedForeground,
                ),
                title: Text(
                  hasCommentsAvailable ? 'View Comments' : 'View Story',
                  style: TextStyle(
                    color: hasCommentsAvailable
                        ? null
                        : ShadTheme.of(context).colorScheme.mutedForeground,
                  ),
                ),
                subtitle: hasCommentsAvailable
                    ? null
                    : Text(
                        'No comments available',
                        style: ShadTheme.of(
                          context,
                        ).textTheme.muted.copyWith(fontSize: 12),
                      ),
                onTap: () {
                  Navigator.of(context).pop();
                  openComments(story, context);
                },
              ),
              if (story.url != null && story.url!.isNotEmpty)
                ListTile(
                  leading: const Icon(LucideIcons.externalLink),
                  title: const Text('Open in Browser'),
                  onTap: () {
                    Navigator.of(context).pop();
                    openInBrowser(story, context);
                  },
                ),
              ListTile(
                leading: const Icon(LucideIcons.share),
                title: const Text('Share Story'),
                onTap: () {
                  Navigator.of(context).pop();
                  shareStory(story, context);
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.copy),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.of(context).pop();
                  copyStoryLink(story, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shares the story using the platform share dialog
  static Future<void> shareStory(Story story, BuildContext context) async {
    try {
      final url =
          story.url ?? 'https://news.ycombinator.com/item?id=${story.id}';
      await Share.share('${story.title}\\n\\n$url', subject: story.title);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to share story')));
    }
  }

  /// Copies the story URL to clipboard
  static Future<void> copyStoryLink(Story story, BuildContext context) async {
    try {
      final url =
          story.url ?? 'https://news.ycombinator.com/item?id=${story.id}';
      await Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link copied to clipboard!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to copy link')));
    }
  }

  /// Opens story in browser (for direct access)
  static Future<void> openInBrowser(Story story, BuildContext context) async {
    if (story.url != null && story.url!.isNotEmpty) {
      await UrlLauncherUtils.launch(story.url!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This story has no external URL')),
      );
    }
  }

  /// Opens story comments/detail view
  static void openComments(Story story, BuildContext context) {
    Get.toNamed(Routes.NEWS_DETAIL, arguments: story);
  }

  /// Gets navigation description for UI display
  ///
  /// Returns a description of what will happen on tap
  static String getNavigationDescription(Story story) {
    if (hasComments(story)) {
      return 'View story and comments';
    } else if (story.url != null && story.url!.isNotEmpty) {
      return 'Open in browser';
    } else {
      return 'View story details';
    }
  }

  /// Gets navigation hint for UI display
  static String getNavigationHint(Story story) {
    if (hasComments(story)) {
      return 'Tap to read story and ${story.commentsCount} comments';
    } else if (story.url != null && story.url!.isNotEmpty) {
      return 'Tap to open website';
    } else {
      return 'Tap to view story';
    }
  }

  /// Generates the shareable URL for a story
  static String getStoryUrl(Story story) {
    return story.url ?? 'https://news.ycombinator.com/item?id=${story.id}';
  }

  /// Generates the HN comments URL for a story
  static String getCommentsUrl(Story story) {
    return 'https://news.ycombinator.com/item?id=${story.id}';
  }
}
