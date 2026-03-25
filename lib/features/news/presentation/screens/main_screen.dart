import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../domain/entities/story.dart';
import '../../domain/entities/story_type.dart';
import '../providers/generic_stories_provider.dart';
import '../widgets/story_card.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  StoryType _currentStoryType = StoryType.top;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: StoryType.values.length,
      vsync: this,
    );

    // Listen for tab changes
    _tabController.addListener(() {
      final newType = StoryType.values[_tabController.index];
      if (newType != _currentStoryType) {
        _currentStoryType = newType;
        // Update both the story type provider and call changeStoryType
        ref.read(storyTypeProvider.notifier).state = newType;
        ref.read(storiesProvider.notifier).changeStoryType(newType);
      }
    });

    // Initialize with top stories
    ref.read(storyTypeProvider.notifier).state = StoryType.top;
    ref.read(storiesProvider.notifier).changeStoryType(StoryType.top);
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stories = ref.watch(storiesProvider);
    final storiesNotifier = ref.watch(storiesProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          // Modern Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Column(
              children: [
                // Title
                Text(
                  'WHACK',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),

                // Tabs
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: StoryType.values.map((type) {
                    return Tab(
                      text: type.displayName,
                      icon: Icon(_getIconForType(type)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: StoryType.values.map((type) {
                return _buildStoriesList(stories, storiesNotifier);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoriesList(
    AsyncValue<List<Story>> stories,
    StoriesNotifier storiesNotifier,
  ) {
    return stories.when(
      data: (storyList) {
        return RefreshIndicator(
          onRefresh: () => storiesNotifier.refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: storyList.length + 1,
            itemBuilder: (context, index) {
              if (index == storyList.length) {
                storiesNotifier.fetchMore();
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final story = storyList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: StoryCard(story: story),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadCard(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading stories',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        err.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ShadButton.ghost(
                        onPressed: () => storiesNotifier.refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(StoryType type) {
    switch (type) {
      case StoryType.top:
        return Icons.trending_up;
      case StoryType.new_:
        return Icons.fiber_new;
      case StoryType.best:
        return Icons.star;
      case StoryType.ask:
        return Icons.help_outline;
      case StoryType.show:
        return Icons.visibility;
      case StoryType.jobs:
        return Icons.work;
    }
  }
}

class StorySearchDelegate extends SearchDelegate<Story?> {
  StorySearchDelegate(this.ref);
  final WidgetRef ref;
  List<Story> _allStories = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Load current stories for searching
    final stories = ref.watch(storiesProvider);
    stories.whenData((storyList) {
      _allStories = storyList;
    });

    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(child: Text('Enter a search term'));
    }

    final filteredStories = _allStories.where((story) {
      final title = story.title.toLowerCase();
      final author = story.author.toLowerCase();
      final searchQuery = query.toLowerCase();

      return title.contains(searchQuery) || author.contains(searchQuery);
    }).toList();

    if (filteredStories.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: filteredStories.length,
      itemBuilder: (context, index) {
        final story = filteredStories[index];
        return StoryCard(story: story);
      },
    );
  }
}
