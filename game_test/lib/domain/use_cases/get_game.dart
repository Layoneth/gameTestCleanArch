import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/domain/repository/games_repository.dart';

class GetGameUseCase {

  final GamesRepository gamesRepo;
  GetGameUseCase(this.gamesRepo);

  Future<List<GameModel>> getGamesCall(int? offset, {bool forceMoreGames = false}) async {
    try {
      final games = offset == null
        ? await gamesRepo.getGames(forceMoreGames: forceMoreGames)
        : await gamesRepo.getMoreGames(offset, forceMoreGames: forceMoreGames);

      for (var game in games) {
        await gamesRepo.getScreeshots(game.id);
      }
      return games;
    } catch (e) {
      print(e);
      return [];
    }
  }

}