import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/story.dart';
import '../utils/story_navigation_utils.dart';

/// Search delegate for searching through stories.
///
/// Provides search functionality for stories with:
/// - Real-time search filtering
/// - Navigation to story details or external URLs
/// - Proper error handling
class StorySearchDelegate extends SearchDelegate<String> {
  StorySearchDelegate(this.stories);
  final List<Story> stories;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      ShadButton.ghost(
        onPressed: () {
          query = '';
        },
        child: const Icon(LucideIcons.x),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return ShadButton.ghost(
      onPressed: () {
        close(context, '');
      },
      child: const Icon(LucideIcons.arrowLeft),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = stories.where((story) {
      return story.title.toLowerCase().contains(query.toLowerCase()) ||
          story.author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.searchX,
                  size: 48,
                  color: ShadTheme.of(context).colorScheme.mutedForeground,
                ),
                const SizedBox(height: 16),
                Text(
                  'No stories found',
                  style: ShadTheme.of(context).textTheme.muted,
                ),
                const SizedBox(height: 8),
                Text(
                  'Try searching for different keywords',
                  style: ShadTheme.of(
                    context,
                  ).textTheme.muted.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final story = results[index];
        return StorySearchResultTile(
          story: story,
          query: query,
          onTap: () => _handleStoryTap(context, story),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = stories
        .where((story) {
          return story.title.toLowerCase().contains(query.toLowerCase()) ||
              story.author.toLowerCase().contains(query.toLowerCase());
        })
        .take(5)
        .toList();

    if (suggestions.isEmpty) {
      return Center(
        child: ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No suggestions',
              style: ShadTheme.of(context).textTheme.muted,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final story = suggestions[index];
        return StorySearchResultTile(
          story: story,
          query: query,
          onTap: () => _handleStoryTap(context, story),
        );
      },
    );
  }

  /// Handles story tap from search results
  void _handleStoryTap(BuildContext context, Story story) {
    close(context, '');
    StoryNavigationUtils.handleStoryTap(story, context);
  }
}

/// Custom tile for displaying search results with highlighted text
class StorySearchResultTile extends StatelessWidget {
  const StorySearchResultTile({
    required this.story,
    required this.query,
    required this.onTap,
    super.key,
  });

  final Story story;
  final String query;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: _buildHighlightedText(
            story.title,
            query,
            ShadTheme.of(
              context,
            ).textTheme.muted.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            'by ${story.author} • ${story.score} points • ${story.commentsCount} comments',
            style: ShadTheme.of(context).textTheme.muted.copyWith(fontSize: 12),
          ),
          onTap: onTap,
          leading: ShadBadge(
            child: Text(
              story.score.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds text with highlighted query matches
  Widget _buildHighlightedText(String text, String query, TextStyle? style) {
    if (query.isEmpty) {
      return Text(text, style: style);
    }

    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerQuery);

    while (index != -1) {
      // Add non-matching text
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      // Add matching text with highlight
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            backgroundColor: Color(0xFFFFF3CD), // Light yellow background
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: style?.copyWith(
          color: ShadTheme.of(Get.context!).colorScheme.foreground,
        ),
      ),
    );
  }
}
