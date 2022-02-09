import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/data/remote/game_remote_data_source.dart';
import 'package:game_test/domain/repository/games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GameRemoteDataSource gameRemoteDataSource;
  GamesRepositoryImpl(this.gameRemoteDataSource);

  @override
  Future<List<GameModel>?> getGames() async {
    try {
      final games = gameRemoteDataSource.requestGames();
      return games;
    } catch (e) {
      print(e);
    }
  }

}