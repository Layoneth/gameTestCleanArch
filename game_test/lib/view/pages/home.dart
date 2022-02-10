import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/view/blocs/cubit/get_game_cubit.dart';
import 'package:game_test/view/pages/game_detail_page.dart';

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
            return  const Center(child: CircularProgressIndicator());
          } else if (state is GetGameLoaded) {
            if (state.gameModel.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<GetGameCubit>().plusOffset();
                  context.read<GetGameCubit>().getGames();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.gameModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    final gameModel = state.gameModel[index];
                    final imageId = gameModel.screenshots != null 
                      ? gameModel.screenshots![0].imageId
                      : 'nf6v8ax7nhzvr98qpoop';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GameDetailPage(gameModel: gameModel,)),
                          );
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Image.network(
                                'https://images.igdb.com/igdb/image/upload/t_screenshot_med/$imageId.jpg',
                                width: 140,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                                  return Container();
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0,),
                            Expanded(child: Text(state.gameModel[index].name))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              const Text('There are no games.');
            }
          }

          return Container();
        },
      ),
    );
  }
}
