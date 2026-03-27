import 'package:flutter/material.dart';

import '../models/story_type.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    required this.tabs,
    required this.tabController,
    super.key,
  });

  final List<StoryType> tabs;
  final TabController tabController;

  IconData _getIconForStoryType(StoryType type) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TabBar(
      padding: EdgeInsets.zero,
      enableFeedback: false,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: theme.colorScheme.primary,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: theme.colorScheme.onSurface,
      ),
      indicatorColor: theme.colorScheme.primary,
      controller: tabController,
      tabs: tabs.map((type) {
        return Tab(
          icon: Icon(
            _getIconForStoryType(type),
            size: 16,
            color: theme.colorScheme.onSurface,
          ),
          text: type.displayName,
        );
      }).toList(),
      dividerHeight: 0,
    );
  }
}
