import 'package:flutter/material.dart';

class SelectedMoviesPage extends StatefulWidget {
  final List<dynamic> selectedMovies;

  SelectedMoviesPage({required this.selectedMovies});

  @override
  _SelectedMoviesPageState createState() => _SelectedMoviesPageState();
}

class _SelectedMoviesPageState extends State<SelectedMoviesPage> {
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.selectedMovies.length, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas Seleccionadas'),
      ),
      body: ListView.builder(
        itemCount: widget.selectedMovies.length,
        itemBuilder: (context, index) {
          final movie = widget.selectedMovies[index];
          final quantity = quantities[index];

          return ListTile(
            title: Text(movie['title']),
            subtitle: Text(movie['overview']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantities[index]--;
                      });
                    }
                  },
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantities[index]++;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón de comprar
          _showConfirmationDialog();
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Compra'),
          content: Text('¿Estás seguro de comprar estas películas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Realizar la acción de compra
                Navigator.pop(context); // Cerrar el diálogo
                _showPurchaseSuccessSnackbar();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showPurchaseSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Compra realizada con éxito!'),
      ),
    );
  }
}
