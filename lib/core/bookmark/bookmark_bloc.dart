import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/job/job_model.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final List<Job> _bookmarkedJobs = [];

  BookmarkBloc() : super(BookmarkInitial()) {
    on<BookmarkJob>(_onBookmarkJob);
    on<RemoveBookmark>(_onRemoveBookmark);
    on<LoadBookmarks>(_onLoadBookmarks);

    // Load bookmarks when bloc is created
    add(LoadBookmarks());
  }

  Future<void> _onBookmarkJob(
      BookmarkJob event,
      Emitter<BookmarkState> emit,
      ) async {
    try {
      final job = event.job.copyWith(isBookmarked: true);

      // Check if job is already bookmarked
      final existingIndex = _bookmarkedJobs.indexWhere((j) => j.id == job.id);
      if (existingIndex == -1) {
        _bookmarkedJobs.add(job);
        await _saveBookmarks();
      }

      emit(BookmarksLoaded(List.from(_bookmarkedJobs)));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> _onRemoveBookmark(
      RemoveBookmark event,
      Emitter<BookmarkState> emit,
      ) async {
    try {
      _bookmarkedJobs.removeWhere((job) => job.id == event.jobId);
      await _saveBookmarks();
      emit(BookmarksLoaded(List.from(_bookmarkedJobs)));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> _onLoadBookmarks(
      LoadBookmarks event,
      Emitter<BookmarkState> emit,
      ) async {
    emit(BookmarkLoading());

    try {
      await _loadBookmarks();
      emit(BookmarksLoaded(List.from(_bookmarkedJobs)));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> jobJsonList = _bookmarkedJobs
          .map((job) => json.encode(job.toJson()))
          .toList();

      await prefs.setStringList('bookmarked_jobs', jobJsonList);
    } catch (e) {
      throw Exception('Failed to save bookmarks: $e');
    }
  }

  Future<void> _loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String>? jobJsonList = prefs.getStringList('bookmarked_jobs');

      if (jobJsonList != null) {
        _bookmarkedJobs.clear();

        for (final jobJson in jobJsonList) {
          final Map<String, dynamic> jobMap = json.decode(jobJson);
          final job = Job.fromJson(jobMap).copyWith(isBookmarked: true);
          _bookmarkedJobs.add(job);
        }
      }
    } catch (e) {
      throw Exception('Failed to load bookmarks: $e');
    }
  }

  bool isJobBookmarked(int jobId) {
    return _bookmarkedJobs.any((job) => job.id == jobId);
  }
}
