import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_log.dart';
import '../../news/models/story.dart';

class BookmarkService extends GetxService {
  static BookmarkService get to => Get.find();

  final RxList<Story> bookmarks = <Story>[].obs;
  static const String _bookmarksKey = 'bookmarks';

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadBookmarks();
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
          continue;
        }
      }
    } catch (e) {
      AppLog.e('Failed to load bookmarks: $e');
    }
  }

  Future<void> addBookmark(Story story) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      if (isBookmarked(story.id)) return;

      bookmarksJson.add(story.toJsonString());
      await prefs.setStringList(_bookmarksKey, bookmarksJson);
      bookmarks.add(story);
    } catch (e) {
      AppLog.e('Failed to add bookmark: $e');
    }
  }

  Future<void> removeBookmark(Story story) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

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
    } catch (e) {
      AppLog.e('Failed to remove bookmark: $e');
    }
  }

  Future<void> toggleBookmark(Story story) async {
    if (isBookmarked(story.id)) {
      await removeBookmark(story);
    } else {
      await addBookmark(story);
    }
  }

  bool isBookmarked(int storyId) {
    return bookmarks.any((bookmark) => bookmark.id == storyId);
  }

  Future<void> clearAllBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_bookmarksKey);
      bookmarks.clear();
    } catch (e) {
      AppLog.e('Failed to clear bookmarks: $e');
    }
  }
}
