import 'package:game_test/data/models/game_model.dart';

abstract class GamesRepository {
  Future<List<GameModel>> getGames(int offset);
}