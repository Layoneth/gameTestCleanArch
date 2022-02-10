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