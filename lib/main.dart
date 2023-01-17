import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_beers_bloc/feature_display_beers/beer_screen.dart';
import 'package:infinite_beers_bloc/helpers/beer_bloc_observer.dart';

void main() {
  Bloc.observer = BeerBlocObserver();
  runApp(const BeerApp());
}

class BeerApp extends StatelessWidget {
  const BeerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const BeerScreen(),
      },
    );
  }
}
