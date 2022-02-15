import 'package:flutter/material.dart';
import 'package:game_test/data/models/screenshot_model.dart';
import 'package:game_test/domain/repository/games_repository.dart';
import 'package:game_test/injector_container.dart';

class ScreenshotImage extends StatelessWidget {
  final int gameId;
  final double? width;
  const ScreenshotImage({Key? key, required this.gameId, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScreenshotModel>>(
      future: sl<GamesRepository>().getScreeshots(gameId),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<ScreenshotModel>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else if (snapshot.data!.isNotEmpty) {
          return Image.network(
            'https://images.igdb.com/igdb/image/upload/t_screenshot_med/${snapshot.data![0].imageId}.jpg',
            width: width,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
              return Container();
            },
          );
        } else {
          return Image.network(
            'https://images.igdb.com/igdb/image/upload/t_screenshot_med/yzgec5vxvgnbi7giqkvf.jpg',
            width: width,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
              return Container();
            },
          );
        }
      },
    );
  }
}