import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/base_controller.dart';
import '../../../../core/network/dio_client.dart';
import '../models/story.dart';
import '../models/story_type.dart';

class NewsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final Dio _dio = Get.find<DioClient>().dio;

  final RxList<Story> stories = <Story>[].obs;
  final Rx<StoryType> currentStoryType = StoryType.top.obs;
  final RxBool isLoadingMore = false.obs;

  late TabController tabController;

  int _currentIndex = 0;
  static const int _pageSize = 20;
  List<int> _allIds = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: StoryType.values.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentStoryType.value = StoryType.values[tabController.index];
        fetchStories();
      }
    });
    fetchStories();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> fetchStories() async {
    showLoading();
    clearError();
    stories.clear(); // Clear stories to trigger the loading view in UI
    _currentIndex = 0;
    try {
      final response = await _dio.get('${currentStoryType.value.apiPath}.json');
      if (response.statusCode == 200 && response.data != null) {
        _allIds = List<int>.from(response.data);
        stories.value = await _fetchNextBatch();
      } else {
        setError('Failed to load stories');
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      hideLoading();
    }
  }

  Future<List<Story>> _fetchNextBatch() async {
    final nextIds = _allIds.skip(_currentIndex).take(_pageSize).toList();
    _currentIndex += _pageSize;

    final results = await Future.wait(
      nextIds.map((id) => _dio.get('item/$id.json')),
    );

    final List<Story> batch = [];
    for (final response in results) {
      if (response.statusCode == 200 && response.data != null) {
        batch.add(Story.fromJson(response.data));
      }
    }
    return batch;
  }

  Future<void> fetchMore() async {
    if (isLoadingMore.value || _currentIndex >= _allIds.length) {
      return;
    }

    isLoadingMore.value = true;
    try {
      final nextBatch = await _fetchNextBatch();
      stories.addAll(nextBatch);
    } catch (e) {
      setError(e.toString());
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshStories() async {
    await fetchStories();
  }

  Future<void> changeStoryType(StoryType newType) async {
    if (currentStoryType.value == newType) return;
    currentStoryType.value = newType;
    await fetchStories();
  }
}
