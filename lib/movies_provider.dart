import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies_builder.dart';
import 'movies_cubit.dart';

class MoviesProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getMovies(),
      child: PopularMoviesScreen(),
    );
  }
}
