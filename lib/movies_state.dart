abstract class MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<dynamic> movies;

  MoviesLoaded({required this.movies});
}

class MoviesError extends MoviesState {
  final error;
  MoviesError({required this.error});
}
