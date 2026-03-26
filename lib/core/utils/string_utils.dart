class StringUtils {
  static String extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (e) {
      return 'Unknown';
    }
  }
}
