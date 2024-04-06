import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies_cubit.dart';
import 'package:popular_movies/movies_state.dart';
import 'selected_movies.dart';

class PopularMoviesScreen extends StatefulWidget {
  @override
  _MoviesBuilderState createState() => _MoviesBuilderState();
}

class _MoviesBuilderState extends State<PopularMoviesScreen
> {
  List<dynamic> selectedMovies = [];

  void toggleMovieSelection(dynamic movie) {
    if (selectedMovies.contains(movie)) {
      setState(() {
        selectedMovies.remove(movie);
      });
    } else if (selectedMovies.length < 3) {
      setState(() {
        selectedMovies.add(movie);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Solo puedes seleccionar hasta 3 películas.'),
        ),
      );
    }
  }

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
                    toggleMovieSelection(movie);
                  },
                  child: ListTile(
                    title: Text(movie['title']),
                    subtitle: Text(movie['overview']),
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    trailing: selectedMovies.contains(movie)
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.circle_outlined),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Ha ocurrido un error'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedMovies.isNotEmpty) {
            _showSelectedMovies(context);
          }
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showSelectedMovies(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Películas seleccionadas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedMovies.length,
                itemBuilder: (context, index) {
                  final movie = selectedMovies[index];
                  return ListTile(
                    title: Text(movie['title']),
                    subtitle: Text(
                      movie['overview'].length > 100
                          ? movie['overview'].substring(0, 100) + '...'
                          : movie['overview'],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _navigateToSelectedMoviesPage(context);
                },
                child: Text('Comprar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToSelectedMoviesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedMoviesPage(selectedMovies: selectedMovies),
      ),
    );
  }
}
