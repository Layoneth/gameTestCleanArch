import 'package:dio/dio.dart';
import 'package:game_test/core/constants.dart';
import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/data/models/screenshot_model.dart';

abstract class GameRemoteDataSource {
  Future<List<GameModel>> requestGames({int? offset});
  Future<List<ScreenshotModel>> requestScreenshotsOfGame(int gameOwner);
  
}

class GameRemoteDataSourceImp implements GameRemoteDataSource {

  final Dio dio;

  GameRemoteDataSourceImp(this.dio);

  @override
  Future<List<GameModel>> requestGames({int? offset}) async {
    try {

      final response = await dio.post(
        '/games',
        data: 'fields id, category,cover,created_at,first_release_date,name,slug,status,summary,updated_at,url,checksum,parent_game,rating; limit 10; offset ${offset ?? 0};',
        options: Constants.dioOptions
      );

      return GameModel.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<ScreenshotModel>> requestScreenshotsOfGame(int gameOwner) async {
    try {

      final response = await dio.post(
        '/screenshots',
        data: 'fields *; where game = $gameOwner;',
        options: Constants.dioOptions
      );

      return ScreenshotModel.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

}