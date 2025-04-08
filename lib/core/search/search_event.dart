abstract class SearchEvent {}

class SearchJobs extends SearchEvent {
  final String query;
  SearchJobs(this.query);
}

class ClearSearch extends SearchEvent {}