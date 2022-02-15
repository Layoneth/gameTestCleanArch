// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:game_test/data/models/screenshot_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:game_test/data/models/game_model.dart';

part 'game_local_data_source.g.dart';

@Database(version: 1, entities: [GameModel, ScreenshotModel])
abstract class AppDatabase extends FloorDatabase {
  GameLocalDataSourceDao get gameLocalDataSourceDao;
}

@dao
abstract class GameLocalDataSourceDao {

  @insert
  Future<void> insertGames(List<GameModel> games);

  @insert
  Future<void> insertScreenshots(List<ScreenshotModel> screenshots);

  @Query('SELECT * FROM GameModel')
  Future<List<GameModel>> getGames();

  @Query('SELECT * FROM ScreenshotModel WHERE game = :idGame')
  Future<List<ScreenshotModel>> getScreenshots(int idGame);

  @Query('SELECT * FROM ScreenshotModel WHERE id = :idScreen')
  Future<ScreenshotModel?> getScreenshot(int idScreen);

}
