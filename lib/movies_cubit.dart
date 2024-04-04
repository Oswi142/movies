import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final Dio dio = Dio();

  MoviesCubit() : super(MoviesState([]));

  void getMovies() async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=fa3e844ce31744388e07fa47c7c5d8c3');
      emit(MoviesState(response.data['results']));
    } catch (e) {
      print('Error fetching popular movies: $e');
    }
  }
}
