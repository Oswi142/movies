import 'package:flutter/material.dart';

void main() {
  runApp(const Movies());
}

class Movies extends StatelessWidget {
  const Movies({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
