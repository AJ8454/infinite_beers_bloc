import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_beers_bloc/bloc/beer_bloc.dart';
import 'package:infinite_beers_bloc/feature_display_beers/repository/beer_repository.dart';
import 'package:infinite_beers_bloc/feature_display_beers/widgets/beer_body.dart';

class BeerScreen extends StatelessWidget {
  const BeerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeerBloc(
        beerRepository: BeerRepository(),
      )..add(const BeerFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beers \u{1F37A}'),
        ),
        body: BeerBody(),
      ),
    );
  }
}
