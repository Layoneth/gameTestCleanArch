import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_test/core/constants.dart';
import 'package:game_test/data/models/game_model.dart';

abstract class GameRemoteDataSource {
  Future<List<GameModel>?> requestGames();
}

class GameRemoteDataSourceImp implements GameRemoteDataSource {

  final Dio dio;

  GameRemoteDataSourceImp(this.dio);

  @override
  Future<List<GameModel>?> requestGames() async {
    try {

      final response = await dio.post(
        '/games',
        data: 'fields *; limit 5;',
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
      return null;
    }
  }

}