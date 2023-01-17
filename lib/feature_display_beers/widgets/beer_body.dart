import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_beers_bloc/bloc/beer_bloc.dart';
import 'package:infinite_beers_bloc/feature_display_beers/models/beer_model.dart';
import 'package:infinite_beers_bloc/feature_display_beers/widgets/beer_list_item.dart';

class BeerBody extends StatelessWidget {
  final List<BeerModel> _beers = [];
  final ScrollController _scrollController = ScrollController();

  BeerBody({super.key});

  void _showToast(BuildContext context, String data) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<BeerBloc, BeerState>(
        listener: (context, beerState) {
          if (beerState is BeerLoadingState) {
            _showToast(context, beerState.message);
          } else if (beerState is BeerSuccessState && beerState.beers.isEmpty) {
            _showToast(context, "No more beers");
          } else if (beerState is BeerErrorState) {
            _showToast(context, beerState.error);
            context.read<BeerBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, beerState) {
          if (beerState is BeerInitialState ||
              beerState is BeerLoadingState && _beers.isEmpty) {
            return const CircularProgressIndicator();
          } else if (beerState is BeerSuccessState) {
            _beers.addAll(beerState.beers);
            context.read<BeerBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (beerState is BeerErrorState && _beers.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<BeerBloc>()
                      ..isFetching = true
                      ..add(const BeerFetchEvent());
                  },
                  icon: const Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(beerState.error, textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.read<BeerBloc>().isFetching) {
                  context.read<BeerBloc>()
                    ..isFetching = true
                    ..add(const BeerFetchEvent());
                }
              }),
            itemBuilder: (context, index) => BeerListItem(_beers[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _beers.length,
          );
        },
      ),
    );
  }
}
