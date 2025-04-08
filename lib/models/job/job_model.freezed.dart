// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobResponse implements DiagnosticableTreeMixin {

@JsonKey(name: 'job-count') int? get jobCount;@JsonKey(name: 'total-job-count') int? get totalJobCount; List<Job> get jobs;
/// Create a copy of JobResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobResponseCopyWith<JobResponse> get copyWith => _$JobResponseCopyWithImpl<JobResponse>(this as JobResponse, _$identity);

  /// Serializes this JobResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'JobResponse'))
    ..add(DiagnosticsProperty('jobCount', jobCount))..add(DiagnosticsProperty('totalJobCount', totalJobCount))..add(DiagnosticsProperty('jobs', jobs));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobResponse&&(identical(other.jobCount, jobCount) || other.jobCount == jobCount)&&(identical(other.totalJobCount, totalJobCount) || other.totalJobCount == totalJobCount)&&const DeepCollectionEquality().equals(other.jobs, jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobCount,totalJobCount,const DeepCollectionEquality().hash(jobs));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'JobResponse(jobCount: $jobCount, totalJobCount: $totalJobCount, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class $JobResponseCopyWith<$Res>  {
  factory $JobResponseCopyWith(JobResponse value, $Res Function(JobResponse) _then) = _$JobResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'job-count') int? jobCount,@JsonKey(name: 'total-job-count') int? totalJobCount, List<Job> jobs
});




}
/// @nodoc
class _$JobResponseCopyWithImpl<$Res>
    implements $JobResponseCopyWith<$Res> {
  _$JobResponseCopyWithImpl(this._self, this._then);

  final JobResponse _self;
  final $Res Function(JobResponse) _then;

/// Create a copy of JobResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobCount = freezed,Object? totalJobCount = freezed,Object? jobs = null,}) {
  return _then(_self.copyWith(
jobCount: freezed == jobCount ? _self.jobCount : jobCount // ignore: cast_nullable_to_non_nullable
as int?,totalJobCount: freezed == totalJobCount ? _self.totalJobCount : totalJobCount // ignore: cast_nullable_to_non_nullable
as int?,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Job>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _JobResponse extends JobResponse with DiagnosticableTreeMixin {
  const _JobResponse({@JsonKey(name: 'job-count') this.jobCount, @JsonKey(name: 'total-job-count') this.totalJobCount, required final  List<Job> jobs}): _jobs = jobs,super._();
  factory _JobResponse.fromJson(Map<String, dynamic> json) => _$JobResponseFromJson(json);

@override@JsonKey(name: 'job-count') final  int? jobCount;
@override@JsonKey(name: 'total-job-count') final  int? totalJobCount;
 final  List<Job> _jobs;
@override List<Job> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}


/// Create a copy of JobResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobResponseCopyWith<_JobResponse> get copyWith => __$JobResponseCopyWithImpl<_JobResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'JobResponse'))
    ..add(DiagnosticsProperty('jobCount', jobCount))..add(DiagnosticsProperty('totalJobCount', totalJobCount))..add(DiagnosticsProperty('jobs', jobs));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobResponse&&(identical(other.jobCount, jobCount) || other.jobCount == jobCount)&&(identical(other.totalJobCount, totalJobCount) || other.totalJobCount == totalJobCount)&&const DeepCollectionEquality().equals(other._jobs, _jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobCount,totalJobCount,const DeepCollectionEquality().hash(_jobs));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'JobResponse(jobCount: $jobCount, totalJobCount: $totalJobCount, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class _$JobResponseCopyWith<$Res> implements $JobResponseCopyWith<$Res> {
  factory _$JobResponseCopyWith(_JobResponse value, $Res Function(_JobResponse) _then) = __$JobResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'job-count') int? jobCount,@JsonKey(name: 'total-job-count') int? totalJobCount, List<Job> jobs
});




}
/// @nodoc
class __$JobResponseCopyWithImpl<$Res>
    implements _$JobResponseCopyWith<$Res> {
  __$JobResponseCopyWithImpl(this._self, this._then);

  final _JobResponse _self;
  final $Res Function(_JobResponse) _then;

/// Create a copy of JobResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobCount = freezed,Object? totalJobCount = freezed,Object? jobs = null,}) {
  return _then(_JobResponse(
jobCount: freezed == jobCount ? _self.jobCount : jobCount // ignore: cast_nullable_to_non_nullable
as int?,totalJobCount: freezed == totalJobCount ? _self.totalJobCount : totalJobCount // ignore: cast_nullable_to_non_nullable
as int?,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Job>,
  ));
}


}


/// @nodoc
mixin _$Job implements DiagnosticableTreeMixin {

 int get id; String get url; String get title;@JsonKey(name: 'company_name') String get companyName;@JsonKey(name: 'company_logo') String? get companyLogo; String get category; List<String> get tags;@JsonKey(name: 'job_type') String get jobType;@JsonKey(name: 'publication_date') String get publicationDate;@JsonKey(name: 'candidate_required_location') String get candidateRequiredLocation; String? get salary; String get description;@JsonKey(name: 'company_logo_url') String? get companyLogoUrl;@JsonKey(includeFromJson: false, includeToJson: false) bool get isBookmarked;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Job'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('url', url))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('companyName', companyName))..add(DiagnosticsProperty('companyLogo', companyLogo))..add(DiagnosticsProperty('category', category))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('jobType', jobType))..add(DiagnosticsProperty('publicationDate', publicationDate))..add(DiagnosticsProperty('candidateRequiredLocation', candidateRequiredLocation))..add(DiagnosticsProperty('salary', salary))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('companyLogoUrl', companyLogoUrl))..add(DiagnosticsProperty('isBookmarked', isBookmarked));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyLogo, companyLogo) || other.companyLogo == companyLogo)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.publicationDate, publicationDate) || other.publicationDate == publicationDate)&&(identical(other.candidateRequiredLocation, candidateRequiredLocation) || other.candidateRequiredLocation == candidateRequiredLocation)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyLogoUrl, companyLogoUrl) || other.companyLogoUrl == companyLogoUrl)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,title,companyName,companyLogo,category,const DeepCollectionEquality().hash(tags),jobType,publicationDate,candidateRequiredLocation,salary,description,companyLogoUrl,isBookmarked);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Job(id: $id, url: $url, title: $title, companyName: $companyName, companyLogo: $companyLogo, category: $category, tags: $tags, jobType: $jobType, publicationDate: $publicationDate, candidateRequiredLocation: $candidateRequiredLocation, salary: $salary, description: $description, companyLogoUrl: $companyLogoUrl, isBookmarked: $isBookmarked)';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 int id, String url, String title,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_logo') String? companyLogo, String category, List<String> tags,@JsonKey(name: 'job_type') String jobType,@JsonKey(name: 'publication_date') String publicationDate,@JsonKey(name: 'candidate_required_location') String candidateRequiredLocation, String? salary, String description,@JsonKey(name: 'company_logo_url') String? companyLogoUrl,@JsonKey(includeFromJson: false, includeToJson: false) bool isBookmarked
});




}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? title = null,Object? companyName = null,Object? companyLogo = freezed,Object? category = null,Object? tags = null,Object? jobType = null,Object? publicationDate = null,Object? candidateRequiredLocation = null,Object? salary = freezed,Object? description = null,Object? companyLogoUrl = freezed,Object? isBookmarked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String,publicationDate: null == publicationDate ? _self.publicationDate : publicationDate // ignore: cast_nullable_to_non_nullable
as String,candidateRequiredLocation: null == candidateRequiredLocation ? _self.candidateRequiredLocation : candidateRequiredLocation // ignore: cast_nullable_to_non_nullable
as String,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyLogoUrl: freezed == companyLogoUrl ? _self.companyLogoUrl : companyLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Job extends Job with DiagnosticableTreeMixin {
  const _Job({required this.id, required this.url, required this.title, @JsonKey(name: 'company_name') required this.companyName, @JsonKey(name: 'company_logo') this.companyLogo, required this.category, required final  List<String> tags, @JsonKey(name: 'job_type') required this.jobType, @JsonKey(name: 'publication_date') required this.publicationDate, @JsonKey(name: 'candidate_required_location') required this.candidateRequiredLocation, this.salary, required this.description, @JsonKey(name: 'company_logo_url') this.companyLogoUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.isBookmarked = false}): _tags = tags,super._();
  factory _Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

@override final  int id;
@override final  String url;
@override final  String title;
@override@JsonKey(name: 'company_name') final  String companyName;
@override@JsonKey(name: 'company_logo') final  String? companyLogo;
@override final  String category;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'job_type') final  String jobType;
@override@JsonKey(name: 'publication_date') final  String publicationDate;
@override@JsonKey(name: 'candidate_required_location') final  String candidateRequiredLocation;
@override final  String? salary;
@override final  String description;
@override@JsonKey(name: 'company_logo_url') final  String? companyLogoUrl;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  bool isBookmarked;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Job'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('url', url))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('companyName', companyName))..add(DiagnosticsProperty('companyLogo', companyLogo))..add(DiagnosticsProperty('category', category))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('jobType', jobType))..add(DiagnosticsProperty('publicationDate', publicationDate))..add(DiagnosticsProperty('candidateRequiredLocation', candidateRequiredLocation))..add(DiagnosticsProperty('salary', salary))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('companyLogoUrl', companyLogoUrl))..add(DiagnosticsProperty('isBookmarked', isBookmarked));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyLogo, companyLogo) || other.companyLogo == companyLogo)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.publicationDate, publicationDate) || other.publicationDate == publicationDate)&&(identical(other.candidateRequiredLocation, candidateRequiredLocation) || other.candidateRequiredLocation == candidateRequiredLocation)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyLogoUrl, companyLogoUrl) || other.companyLogoUrl == companyLogoUrl)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,title,companyName,companyLogo,category,const DeepCollectionEquality().hash(_tags),jobType,publicationDate,candidateRequiredLocation,salary,description,companyLogoUrl,isBookmarked);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Job(id: $id, url: $url, title: $title, companyName: $companyName, companyLogo: $companyLogo, category: $category, tags: $tags, jobType: $jobType, publicationDate: $publicationDate, candidateRequiredLocation: $candidateRequiredLocation, salary: $salary, description: $description, companyLogoUrl: $companyLogoUrl, isBookmarked: $isBookmarked)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, String title,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_logo') String? companyLogo, String category, List<String> tags,@JsonKey(name: 'job_type') String jobType,@JsonKey(name: 'publication_date') String publicationDate,@JsonKey(name: 'candidate_required_location') String candidateRequiredLocation, String? salary, String description,@JsonKey(name: 'company_logo_url') String? companyLogoUrl,@JsonKey(includeFromJson: false, includeToJson: false) bool isBookmarked
});




}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? title = null,Object? companyName = null,Object? companyLogo = freezed,Object? category = null,Object? tags = null,Object? jobType = null,Object? publicationDate = null,Object? candidateRequiredLocation = null,Object? salary = freezed,Object? description = null,Object? companyLogoUrl = freezed,Object? isBookmarked = null,}) {
  return _then(_Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String,publicationDate: null == publicationDate ? _self.publicationDate : publicationDate // ignore: cast_nullable_to_non_nullable
as String,candidateRequiredLocation: null == candidateRequiredLocation ? _self.candidateRequiredLocation : candidateRequiredLocation // ignore: cast_nullable_to_non_nullable
as String,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyLogoUrl: freezed == companyLogoUrl ? _self.companyLogoUrl : companyLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
