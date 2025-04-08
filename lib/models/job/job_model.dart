import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
abstract class JobResponse with _$JobResponse {
  const JobResponse._(); // Add this line

  const factory JobResponse({
    @JsonKey(name: 'job-count') int? jobCount,
    @JsonKey(name: 'total-job-count') int? totalJobCount,
    required List<Job> jobs,
  }) = _JobResponse;

  factory JobResponse.fromJson(Map<String, dynamic> json) => _$JobResponseFromJson(json);
}

@freezed
abstract class Job with _$Job {
  const Job._(); // Add this line

  const factory Job({
    required int id,
    required String url,
    required String title,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'company_logo') String? companyLogo,
    required String category,
    required List<String> tags,
    @JsonKey(name: 'job_type') required String jobType,
    @JsonKey(name: 'publication_date') required String publicationDate,
    @JsonKey(name: 'candidate_required_location') required String candidateRequiredLocation,
    String? salary,
    required String description,
    @JsonKey(name: 'company_logo_url') String? companyLogoUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) @Default(false) bool isBookmarked,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}