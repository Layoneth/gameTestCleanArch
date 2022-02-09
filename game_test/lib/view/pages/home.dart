import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/view/blocs/cubit/get_game_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetGameCubit, GetGameState>(
        builder: (context, state) {
          if (state is GetGameInitial) {
            context.read<GetGameCubit>().getGames();
          } else if (state is GetGameLoading) {
            return const CircularProgressIndicator();
          } else if (state is GetGameLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                print('');
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.gameModel!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(state.gameModel![index].name)
                    ],
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
