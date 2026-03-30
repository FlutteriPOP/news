import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/controllers/base_controller.dart';

class SettingsController extends BaseController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxBool autoRefreshEnabled = false.obs;
  final RxString refreshInterval = '30'.obs;
  final RxBool compactViewEnabled = false.obs;

  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _autoRefreshKey = 'auto_refresh_enabled';
  static const String _refreshIntervalKey = 'refresh_interval';
  static const String _compactViewKey = 'compact_view_enabled';

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      themeMode.value = ThemeMode.values[themeIndex];
      
      notificationsEnabled.value = prefs.getBool(_notificationsKey) ?? true;
      autoRefreshEnabled.value = prefs.getBool(_autoRefreshKey) ?? false;
      refreshInterval.value = prefs.getString(_refreshIntervalKey) ?? '30';
      compactViewEnabled.value = prefs.getBool(_compactViewKey) ?? false;
    } catch (e) {
      setError('Failed to load settings: $e');
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, mode.index);
      themeMode.value = mode;
    } catch (e) {
      setError('Failed to save theme: $e');
    }
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_notificationsKey, enabled);
      notificationsEnabled.value = enabled;
    } catch (e) {
      setError('Failed to save notification settings: $e');
    }
  }

  Future<void> saveAutoRefreshEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_autoRefreshKey, enabled);
      autoRefreshEnabled.value = enabled;
    } catch (e) {
      setError('Failed to save auto-refresh settings: $e');
    }
  }

  Future<void> saveRefreshInterval(String interval) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshIntervalKey, interval);
      refreshInterval.value = interval;
    } catch (e) {
      setError('Failed to save refresh interval: $e');
    }
  }

  Future<void> saveCompactViewEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_compactViewKey, enabled);
      compactViewEnabled.value = enabled;
    } catch (e) {
      setError('Failed to save view settings: $e');
    }
  }

  Future<void> resetToDefaults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.remove(_themeKey);
      await prefs.remove(_notificationsKey);
      await prefs.remove(_autoRefreshKey);
      await prefs.remove(_refreshIntervalKey);
      await prefs.remove(_compactViewKey);
      
      await loadSettings();
    } catch (e) {
      setError('Failed to reset settings: $e');
    }
  }

  List<String> get refreshIntervals => ['15', '30', '60', '120'];
}
