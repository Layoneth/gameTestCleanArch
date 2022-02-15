import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/data/models/screenshot_model.dart';

abstract class GamesRepository {
  Future<List<GameModel>> getGames({bool forceMoreGames = false});
  Future<List<GameModel>> getMoreGames(int offset, {bool forceMoreGames = false});
  Future<List<ScreenshotModel>> getScreeshots(int gameOwner);
}