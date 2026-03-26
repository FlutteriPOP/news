enum StoryType {
  top('Top Stories', 'topstories'),
  new_('New Stories', 'newstories'),
  best('Best Stories', 'beststories'),
  ask('Ask HN', 'askstories'),
  show('Show HN', 'showstories'),
  jobs('Jobs', 'jobstories');

  const StoryType(this.displayName, this.apiPath);

  final String displayName;
  final String apiPath;
}
