import '../../models/job/job_model.dart';

abstract class BookmarkEvent {}

class BookmarkJob extends BookmarkEvent {
  final Job job;
  BookmarkJob(this.job);
}

class RemoveBookmark extends BookmarkEvent {
  final int jobId;
  RemoveBookmark(this.jobId);
}

class LoadBookmarks extends BookmarkEvent {}