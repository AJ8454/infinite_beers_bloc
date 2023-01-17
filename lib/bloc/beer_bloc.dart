import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:infinite_beers_bloc/feature_display_beers/models/beer_model.dart';
import 'package:infinite_beers_bloc/feature_display_beers/repository/beer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'beer_event.dart';
part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  final BeerRepository beerRepository;
  int page = 1;
  bool isFetching = false;

  BeerBloc({
    required this.beerRepository,
  }) : super(const BeerInitialState());

  @override
  Stream<BeerState> mapEventToState(BeerEvent event) async* {
    if (event is BeerFetchEvent) {
      yield const BeerLoadingState(message: 'Loading Beers');
      final response = await beerRepository.getBeers(page: page);
      if (response is http.Response) {
        if (response.statusCode == 200) {
          final beers = jsonDecode(response.body) as List;
          yield BeerSuccessState(
            beers: beers.map((beer) => BeerModel.fromJson(beer)).toList(),
          );
          page++;
        } else {
          yield BeerErrorState(error: response.body);
        }
      } else if (response is String) {
        yield BeerErrorState(error: response);
      }
    }
  }
}
