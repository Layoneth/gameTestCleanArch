import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/domain/repository/games_repository.dart';

class GetGameUseCase {

  final GamesRepository gamesRepo;
  GetGameUseCase(this.gamesRepo);

  Future<List<GameModel>?> getGamesCall() async {
    return gamesRepo.getGames();
  }

}