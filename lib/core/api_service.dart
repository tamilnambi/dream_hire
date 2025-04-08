import 'package:dio/dio.dart';
import '../models/job/job_model.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://remotive.com/api/';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<JobResponse> getJobs() async {
    try {
      final response = await _dio.get('remote-jobs');
      return JobResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load jobs: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to connect to server: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // New method to search for jobs
  Future<JobResponse> searchJobs(String query) async {
    try {
      final response = await _dio.get('remote-jobs?search=$query');
      return JobResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Failed to search jobs: ${e.response?.data}');
        throw Exception('Failed to search jobs: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to connect to server: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}