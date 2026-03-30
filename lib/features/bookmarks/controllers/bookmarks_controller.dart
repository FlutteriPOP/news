import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/controllers/base_controller.dart';
import '../../news/models/story.dart';

class BookmarksController extends BaseController {
  final RxList<Story> bookmarks = <Story>[].obs;

  static const String _bookmarksKey = 'bookmarks';

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      bookmarks.clear();
      for (final json in bookmarksJson) {
        try {
          final story = Story.fromJsonString(json);
          bookmarks.add(story);
        } catch (e) {
          // Skip invalid bookmark entries
          continue;
        }
      }
      update(); // Trigger UI update
    } catch (e) {
      setError('Failed to load bookmarks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addBookmark(Story story) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      // Check if already bookmarked
      if (bookmarks.any((bookmark) => bookmark.id == story.id)) {
        return;
      }

      bookmarksJson.add(story.toJsonString());
      await prefs.setStringList(_bookmarksKey, bookmarksJson);
      bookmarks.add(story);
      update(); // Trigger UI update
    } catch (e) {
      setError('Failed to add bookmark: $e');
    }
  }

  Future<void> removeBookmark(Story story) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      // Remove the bookmark
      bookmarksJson.removeWhere((json) {
        try {
          final bookmarkStory = Story.fromJsonString(json);
          return bookmarkStory.id == story.id;
        } catch (e) {
          return false;
        }
      });

      await prefs.setStringList(_bookmarksKey, bookmarksJson);
      bookmarks.removeWhere((bookmark) => bookmark.id == story.id);
      update(); // Trigger UI update
    } catch (e) {
      setError('Failed to remove bookmark: $e');
    }
  }

  Future<void> clearAllBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_bookmarksKey);
      bookmarks.clear();
      update(); // Trigger UI update
    } catch (e) {
      setError('Failed to clear bookmarks: $e');
    }
  }

  bool isBookmarked(int storyId) {
    return bookmarks.any((bookmark) => bookmark.id == storyId);
  }

  Future<void> toggleBookmark(Story story) async {
    if (isBookmarked(story.id)) {
      await removeBookmark(story);
    } else {
      await addBookmark(story);
    }
  }
}
