

import '../../models/job/job_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<Job> jobs;
  final String query;
  SearchLoaded(this.jobs, this.query);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}