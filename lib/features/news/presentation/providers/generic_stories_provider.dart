import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/news_remote_datasource.dart';
import '../../data/repository_impl/news_repository_impl.dart';
import '../../domain/entities/story.dart';
import '../../domain/entities/story_type.dart';
import '../../domain/repositories/news_repository.dart';

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  return NewsRemoteDataSourceImpl(ref.watch(dioProvider));
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(ref.watch(newsRemoteDataSourceProvider));
});

class StoriesNotifier extends AsyncNotifier<List<Story>> {
  int _currentIndex = 0;
  static const int _pageSize = 20;
  List<int> _allIds = [];
  late StoryType _storyType;
  bool _isLoadingMore = false;

  void setStoryType(StoryType type) {
    _storyType = type;
  }

  bool get isLoadingMore => _isLoadingMore;

  @override
  Future<List<Story>> build() async {
    // Get story type from provider
    _storyType = ref.read(storyTypeProvider);
    final ids = await _fetchStoryIds();
    _allIds = ids;
    return _fetchNextBatch();
  }

  Future<List<int>> _fetchStoryIds() async {
    final repository = ref.watch(newsRepositoryProvider);
    final result = await switch (_storyType) {
      StoryType.top => repository.getTopStoriesIds(),
      StoryType.new_ => repository.getNewStoriesIds(),
      StoryType.best => repository.getBestStoriesIds(),
      StoryType.ask => repository.getAskStoriesIds(),
      StoryType.show => repository.getShowStoriesIds(),
      StoryType.jobs => repository.getJobStoriesIds(),
    };

    return result.fold(
      (failure) => throw Exception(failure.message),
      (ids) => ids,
    );
  }

  Future<List<Story>> _fetchNextBatch() async {
    final nextIds = _allIds.skip(_currentIndex).take(_pageSize).toList();
    _currentIndex += _pageSize;

    final stories = await Future.wait(
      nextIds.map((id) => ref.read(newsRepositoryProvider).getStoryById(id)),
    );

    final List<Story> batch = [];
    for (final result in stories) {
      result.fold((_) => null, (story) => batch.add(story));
    }
    return batch;
  }

  Future<void> fetchMore() async {
    if (state.isLoading || _isLoadingMore || _currentIndex >= _allIds.length) {
      return;
    }

    _isLoadingMore = true;
    final previousState = state.value ?? [];

    state = await AsyncValue.guard(() async {
      final nextBatch = await _fetchNextBatch();
      return [...previousState, ...nextBatch];
    });

    _isLoadingMore = false;
  }

  Future<void> refresh() async {
    _currentIndex = 0;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final ids = await _fetchStoryIds();
      _allIds = ids;
      return _fetchNextBatch();
    });
  }

  Future<void> changeStoryType(StoryType newType) async {
    if (_storyType == newType) return;

    _storyType = newType;
    _currentIndex = 0;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final ids = await _fetchStoryIds();
      _allIds = ids;
      return _fetchNextBatch();
    });
  }
}

final storiesProvider = AsyncNotifierProvider<StoriesNotifier, List<Story>>(() {
  return StoriesNotifier();
});

final storyTypeProvider = StateProvider<StoryType>((ref) => StoryType.top);
