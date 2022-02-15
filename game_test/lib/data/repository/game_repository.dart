import 'package:game_test/data/local/game_local_data_source.dart';
import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/data/models/screenshot_model.dart';
import 'package:game_test/data/remote/game_remote_data_source.dart';
import 'package:game_test/domain/repository/games_repository.dart';
import 'package:game_test/injector_container.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GameRemoteDataSource gameRemoteDataSource;
  GamesRepositoryImpl(this.gameRemoteDataSource);

  @override
  Future<List<GameModel>> getGames({bool forceMoreGames = false}) async {
    try {
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<GameModel> games = await db.getGames();

      if (games.isEmpty || forceMoreGames) {
        games = await gameRemoteDataSource.requestGames();
        if (games.isNotEmpty) {
          db.insertGames(games);
          for (var game in games) {
            getScreeshots(game.id);
          }
        }
      }

      return games;
    } catch (e) {
      print(e);
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<GameModel> games = await db.getGames();
      return games;
    }
  }

  @override
  Future<List<GameModel>> getMoreGames(int offset, {bool forceMoreGames = false}) async {
    try {
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<GameModel> gamesInDb = await db.getGames();
      List<GameModel> returnGames = gamesInDb;

      if (gamesInDb.isEmpty || forceMoreGames) {
        final games = await gameRemoteDataSource.requestGames(offset: offset);
        if (games.isNotEmpty) {
          returnGames.addAll(games);
          db.insertGames(games);
          for (var game in games) {
            final screenLIst = await getScreeshots(game.id);
            db.insertScreenshots(screenLIst);
          }
        }
      }

      return returnGames;
    } catch (e) {
      print(e);
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<GameModel> games = await db.getGames();
      return games;
    }
  }

  @override
  Future<List<ScreenshotModel>> getScreeshots(int gameOwner) async {
    try {
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<ScreenshotModel>? screenshots = await db.getScreenshots(gameOwner);
      
      if (screenshots.isEmpty) {
        final newScreenshots = await gameRemoteDataSource.requestScreenshotsOfGame(gameOwner);
        if (screenshots.isNotEmpty || screenshots.length < newScreenshots.length) {
          // db.getScreenshot(screenshots)
          db.insertScreenshots(newScreenshots);
        }
      }

      return screenshots;
    } catch (e) {
      print(e);
      final db = sl<AppDatabase>().gameLocalDataSourceDao;
      List<ScreenshotModel>? screenshots = await db.getScreenshots(gameOwner);
      return screenshots;
    }
  }

}