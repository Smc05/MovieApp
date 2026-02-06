import 'package:flutter/material.dart';
import '../../data/dummy/dummy_movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final DummyMovie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('movie detail screen')));
  }
}
