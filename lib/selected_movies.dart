import 'package:flutter/material.dart';

class SelectedMoviesPage extends StatefulWidget {
  final List<dynamic> selectedMovies;

  SelectedMoviesPage({required this.selectedMovies});

  @override
  _SelectedMoviesPageState createState() => _SelectedMoviesPageState();
}

class _SelectedMoviesPageState extends State<SelectedMoviesPage> {
  List<int> quantities = [];
  int unitPrice = 20;

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.selectedMovies.length, 1);
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;

    for (int i = 0; i < widget.selectedMovies.length; i++) {
      final quantity = quantities[i];
      final total = quantity * unitPrice;
      totalPrice += total;
    }

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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Precio unitario: \$${unitPrice.toString()}'),
                Text('Cantidad: $quantity'),
              ],
            ),
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${totalPrice.toString()}'),
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(totalPrice);
                },
                child: Text('Comprar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(int totalPrice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Compra'),
          content: Text('El total a pagar es de \$${totalPrice.toString()}. ¿Estás seguro de comprar estas películas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
