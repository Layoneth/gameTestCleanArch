import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/domain/use_cases/get_game.dart';
import 'package:meta/meta.dart';

part 'get_game_state.dart';

class GetGameCubit extends Cubit<GetGameState> {
  final GetGameUseCase getGameUseCase;
  int offset = 0;
  List<GameModel> gamesSaved = [];
  GetGameCubit(this.getGameUseCase) : super(GetGameInitial());

  Future<void> getFirstGames() async {
    try {
      emit(GetGameLoading());
      gamesSaved = [];
      gamesSaved = await getGameUseCase.getGamesCall(null);
      emit(GetGameLoaded(gameModels: gamesSaved, offset: offset));
    } catch (e) {
      emit(GetGameError('There was an error'));
      print(e);
    }
  }

  Future<void> getOtherGames({bool forceMoreGames = false}) async {
    try {
      emit(GetGameLoading());
      plusOffset();
      gamesSaved = await getGameUseCase.getGamesCall(offset, forceMoreGames: forceMoreGames);
      emit(GetGameLoaded(gameModels: gamesSaved, offset: offset));
    } catch (e) {
      emit(GetGameError('There was an error'));
      print(e);
    }
  }

  Future<void> scrollGames() async {
    try {
      plusOffset();
      final games = await getGameUseCase.getGamesCall(offset, forceMoreGames: true);
      gamesSaved.addAll(games);
      emit(GetGameLoaded(gameModels: gamesSaved).addGames(games: gamesSaved));
    } catch (e) {
      emit(GetGameError('There was an error'));
      print(e);
    }
  }

  void plusOffset(){
    offset += 10;
  }
}
