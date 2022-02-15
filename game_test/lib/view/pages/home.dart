import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/view/blocs/cubit/get_game_cubit.dart';
import 'package:game_test/view/pages/game_detail_page.dart';
import 'package:game_test/view/widgets/screenshot_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          context.read<GetGameCubit>().scrollGames();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetGameCubit>().plusOffset();
          context.read<GetGameCubit>().getOtherGames(forceMoreGames: true);
        },
        child: BlocBuilder<GetGameCubit, GetGameState>(
          builder: (context, state) {
            if (state is GetGameInitial) {
              context.read<GetGameCubit>().getFirstGames();
              return Center(
                child: Column(
                children: const [
                  Text('Welcome! wait the games...'),
                  CircularProgressIndicator(),
                ],
              ));
            } else if (state is GetGameLoading) {
              return  const Center(child: CircularProgressIndicator());
            } else if (state is GetGameLoaded) {
              if (state.gameModels.isNotEmpty) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 32.0,),
                      const Text('Welcome to Layos test!'),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.gameModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          final gameModel = state.gameModels[index];
                
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
                                    child: ScreenshotImage(
                                      gameId: gameModel.id,
                                      width: 140,
                                    )
                                  ),
                                  const SizedBox(width: 8.0,),
                                  Expanded(child: Text(state.gameModels[index].name))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: 500,
                    child: Center(child: Text('There are no games here!.'))
                  ),
                );
              }
            } else if (state is GetGameError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('There are no games.'));
            }
          },
        ),
      ),
    );
  }
}
