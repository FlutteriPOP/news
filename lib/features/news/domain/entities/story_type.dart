enum StoryType {
  top('Top Stories'),
  new_('New Stories'),
  best('Best Stories'),
  ask('Ask HN'),
  show('Show HN'),
  jobs('Jobs');

  const StoryType(this.displayName);
  
  final String displayName;
}
