import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movies_cubit.dart';
import 'movies_state.dart';

class PopularMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () {
                    _showMovieDetails(context, movie['title']);
                  },
                  child: ListTile(
                    title: Text(movie['title']),
                    subtitle: Text(movie['overview']),
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Ha ocurrido un error'));
          }
        },
      ),
    );
  }

  void _showMovieDetails(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
