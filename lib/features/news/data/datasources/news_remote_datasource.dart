import 'package:dio/dio.dart';

import '../models/story_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<int>> getTopStoriesIds();
  Future<List<int>> getNewStoriesIds();
  Future<List<int>> getBestStoriesIds();
  Future<List<int>> getAskStoriesIds();
  Future<List<int>> getShowStoriesIds();
  Future<List<int>> getJobStoriesIds();
  Future<StoryModel> getStoryById(int id);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl(this.client);
  final Dio client;

  @override
  Future<List<int>> getTopStoriesIds() async {
    final response = await client.get('topstories.json');
    if (response.statusCode == 200 && response.data != null) {
      return List<int>.from(response.data);
    } else {
      throw Exception('Invalid response: ${response.statusCode}');
    }
  }

  @override
  Future<List<int>> getNewStoriesIds() async {
    final response = await client.get('newstories.json');
    if (response.statusCode == 200) {
      return List<int>.from(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<List<int>> getBestStoriesIds() async {
    final response = await client.get('beststories.json');
    if (response.statusCode == 200) {
      return List<int>.from(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<List<int>> getAskStoriesIds() async {
    final response = await client.get('askstories.json');
    if (response.statusCode == 200) {
      return List<int>.from(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<List<int>> getShowStoriesIds() async {
    final response = await client.get('showstories.json');
    if (response.statusCode == 200) {
      return List<int>.from(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<List<int>> getJobStoriesIds() async {
    final response = await client.get('jobstories.json');
    if (response.statusCode == 200) {
      return List<int>.from(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<StoryModel> getStoryById(int id) async {
    final response = await client.get('item/$id.json');
    if (response.statusCode == 200 && response.data != null) {
      return StoryModel.fromJson(response.data);
    } else {
      throw Exception('Invalid story response: ${response.statusCode}');
    }
  }
}
