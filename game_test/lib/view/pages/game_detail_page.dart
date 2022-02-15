import 'package:flutter/material.dart';
import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/data/models/screenshot_model.dart';
import 'package:game_test/domain/repository/games_repository.dart';
import 'package:game_test/injector_container.dart';
import 'package:game_test/view/widgets/screenshot_image.dart';

class GameDetailPage extends StatelessWidget {
  final GameModel gameModel;
  const GameDetailPage({Key? key, required this.gameModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
                      
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(gameModel.name),
              background: ScreenshotImage(
                gameId: gameModel.id,
              )
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<ScreenshotModel>>(
              future: sl<GamesRepository>().getScreeshots(gameModel.id),
              builder: (BuildContext context, AsyncSnapshot<List<ScreenshotModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    width: 20,
                    child: CircularProgressIndicator()
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const SizedBox(
                    height: 20,
                    child: Center(
                      child: Text('There are no screenshots in this game'),
                    ),
                  );
                }

                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final imageIdA = snapshot.data![index].imageId;

                      return Image.network(
                        'https://images.igdb.com/igdb/image/upload/t_screenshot_med/$imageIdA.jpg',
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0,),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gameModel.checksum != null 
                  ? TextGame( leftText: 'Checksum: ', text: gameModel.checksum!)
                  : const SizedBox(),
                  gameModel.rating != null 
                    ? TextGame(leftText: 'Rating: ', text: gameModel.rating!.toString())
                    : const SizedBox(),
                  gameModel.url != null 
                    ? TextGame(leftText: 'url: ', text: gameModel.url!)
                    : const SizedBox(),
                  gameModel.slug != null 
                    ? TextGame(leftText: 'slug: ', text: gameModel.slug!)
                    : const SizedBox(),
                  gameModel.summary != null 
                    ? TextGame(leftText: 'summary: ', text: gameModel.summary!)
                    : const SizedBox(),
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}

class TextGame extends StatelessWidget {
  final String leftText;
  final String text;
  const TextGame({Key? key, required this.text, required this.leftText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        leftText + text,
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: Color(0xff707070),
        ),
      ),
    );
  }
}