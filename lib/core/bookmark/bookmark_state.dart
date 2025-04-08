import '../../models/job/job_model.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}
class BookmarkLoading extends BookmarkState {}
class BookmarksLoaded extends BookmarkState {
  final List<Job> bookmarkedJobs;
  BookmarksLoaded(this.bookmarkedJobs);
}
class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}