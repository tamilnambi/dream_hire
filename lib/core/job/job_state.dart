

import '../../models/job/job_model.dart';

abstract class JobState {}

class JobInitial extends JobState {}
class JobLoading extends JobState {}
class JobsLoaded extends JobState {
  final List<Job> jobs;
  JobsLoaded(this.jobs);
}
class JobError extends JobState {
  final String message;
  JobError(this.message);
}