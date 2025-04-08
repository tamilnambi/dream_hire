import 'package:dream_hire/core/search/search_event.dart';
import 'package:dream_hire/core/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService _apiService;

  SearchBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(SearchInitial()) {
    on<SearchJobs>(_onSearchJobs);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchJobs(
      SearchJobs event,
      Emitter<SearchState> emit,
      ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final jobResponse = await _apiService.searchJobs(event.query);

      emit(SearchLoaded(jobResponse.jobs, event.query));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _onClearSearch(
      ClearSearch event,
      Emitter<SearchState> emit,
      ) {
    emit(SearchInitial());
  }
}
