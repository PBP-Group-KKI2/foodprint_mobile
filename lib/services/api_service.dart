import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:foodprint_mobile/models/analytics_summary.dart';
import 'package:foodprint_mobile/models/article.dart';
import 'package:foodprint_mobile/models/collection_task.dart';
import 'package:foodprint_mobile/models/reward_status.dart';
import 'package:foodprint_mobile/models/user_profile.dart';
import 'package:foodprint_mobile/models/waste_report.dart';
import 'package:foodprint_mobile/services/api_config.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  bool get needsLogin => statusCode == 401 || statusCode == 403;

  @override
  String toString() => message;
}

class ApiService {
  static Future<dynamic> _get(String path) async {
    final http.Response response;
    try {
      response = await http
          .get(
            Uri.parse('$baseUrl$path'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));
    } on http.ClientException {
      throw const ApiException(
        0,
        'Cannot reach the FoodPrint server at $baseUrl.',
      );
    } on TimeoutException {
      throw const ApiException(
        0,
        'The FoodPrint server took too long to answer.',
      );
    }

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, _errorMessage(response));
    }
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static String _errorMessage(http.Response response) {
    final fallback = 'Request failed (HTTP ${response.statusCode}).';
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is Map && body['detail'] is String) {
        return body['detail'] as String;
      }
    } on FormatException {
      return fallback;
    }
    return fallback;
  }

  static Future<List<T>> _getList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await _get(path) as List<dynamic>;
    return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
  }

  static Future<List<WasteReport>> fetchReports() =>
      _getList('/api/v1/reports/', WasteReport.fromJson);

  static Future<List<Article>> fetchArticles() =>
      _getList('/api/v1/learn/articles/', Article.fromJson);

  static Future<AnalyticsSummary> fetchAnalyticsSummary() async =>
      AnalyticsSummary.fromJson(await _get('/api/v1/analytics/summary/'));

  static Future<UserProfile> fetchProfile() async =>
      UserProfile.fromJson(await _get('/api/v1/profile/'));

  static Future<RewardStatus> fetchRewards() async =>
      RewardStatus.fromJson(await _get('/api/v1/rewards/'));

  static Future<List<CollectionTask>> fetchMyTasks() =>
      _getList('/api/v1/tasks/', CollectionTask.fromJson);
}
