
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final ApiService _apiService;

  JobBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(JobInitial()) {
    on<FetchJobs>(_onFetchJobs);
  }

  Future<void> _onFetchJobs(
      FetchJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());

    try {
      final jobResponse = await _apiService.getJobs();

      if (jobResponse.jobs.isNotEmpty) {
        emit(JobsLoaded(jobResponse.jobs));
      } else {
        emit(JobError('No jobs found'));
      }
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}