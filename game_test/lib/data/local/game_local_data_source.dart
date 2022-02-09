// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:game_test/data/models/game_model.dart';

part 'game_local_data_source.g.dart';

@dao
abstract class GameLocalDataSourceDao {
  @Query('SELECT * FROM GameModel')
  Future<List<GameModel>?> requestGames();
}

@Database(version: 1, entities: [GameModel])
abstract class GameDatabase extends FloorDatabase {
  GameLocalDataSourceDao get gameLocalDataSourceDao;
}