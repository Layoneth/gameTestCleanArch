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

  Future<void> getGames() async {
    emit(GetGameLoading());
    final gamesSaved = await getGameUseCase.getGamesCall(offset);
    emit(GetGameLoaded(gameModels: gamesSaved, offset: offset));
  }

  Future<void> scrollGames() async {
    // emit(GetGameLoading());
    plusOffset();
    final games = await getGameUseCase.getGamesCall(offset);
    gamesSaved.addAll(games);
    emit(GetGameLoaded(gameModels: gamesSaved).addGames(games: gamesSaved)
    );
  }

  void plusOffset(){
    offset += 10;
  }
}
