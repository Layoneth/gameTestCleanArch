import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_test/core/constants.dart';
import 'package:game_test/data/models/game_model.dart';

abstract class GameRemoteDataSource {
  Future<List<GameModel>> requestGames(int offset);
}

class GameRemoteDataSourceImp implements GameRemoteDataSource {

  final Dio dio;

  GameRemoteDataSourceImp(this.dio);

  @override
  Future<List<GameModel>> requestGames(int offset) async {
    try {

      final response = await dio.post(
        '/games',
        data: 'fields id, category,cover,created_at,first_release_date,name,slug,status,summary,updated_at,url,checksum,parent_game,rating, screenshots.*; limit 10; offset $offset;',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Client-ID': Constants.clientId,
            HttpHeaders.authorizationHeader: 'Bearer ${Constants.token}',
          }
        )
      );

      print(response.data);
      // final respDeco = jsonDecode(response.data);
      return GameModel.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

}