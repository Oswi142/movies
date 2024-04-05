import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies_cubit.dart';
import 'package:popular_movies/movies_state.dart';

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
                    _showMovieDetails(context, movie);
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

  void _showMovieDetails(BuildContext context, dynamic movie) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie['title'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                movie['overview'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$20', // Precio fijo de $20
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de comprar
                    },
                    child: Text('Comprar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
