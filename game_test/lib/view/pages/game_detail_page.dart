import 'package:flutter/material.dart';
import 'package:game_test/data/models/game_model.dart';

class GameDetailPage extends StatelessWidget {
  final GameModel gameModel;
  const GameDetailPage({Key? key, required this.gameModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageId = gameModel.screenshots != null 
      ? gameModel.screenshots![0].imageId
      : 'nf6v8ax7nhzvr98qpoop';
                      
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(gameModel.name),
              background: Image.network(
                'https://images.igdb.com/igdb/image/upload/t_screenshot_med/$imageId.jpg',
                fit: BoxFit.fitWidth,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return Container();
                },
              ),
            ),
          ),
          gameModel.screenshots != null ? SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: gameModel.screenshots!.length,
                itemBuilder: (BuildContext context, int index) {
                  final imageIdA = gameModel.screenshots != null 
                    ? gameModel.screenshots![index].imageId
                    : 'nf6v8ax7nhzvr98qpoop';

                  return Image.network(
                    'https://images.igdb.com/igdb/image/upload/t_screenshot_med/$imageIdA.jpg',
                  );
                },
              ),
            ),
          ) : const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('There are no screenshots in this game'),
              ),
            ),
          ),
        ]
      ),
    );
  }
}