part of 'beer_bloc.dart';

abstract class BeerEvent {
  const BeerEvent();
}

class BeerFetchEvent extends BeerEvent {
  const BeerFetchEvent();
}
