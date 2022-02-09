import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_test/data/models/game_model.dart';
import 'package:game_test/domain/use_cases/get_game.dart';
import 'package:meta/meta.dart';

part 'get_game_state.dart';

class GetGameCubit extends Cubit<GetGameState> {
  final GetGameUseCase getGameUseCase;
  GetGameCubit(this.getGameUseCase) : super(GetGameInitial());

  Future<void> getGames() async {
    emit(GetGameLoading());
    final games = await getGameUseCase.getGamesCall();
    emit(GetGameLoaded(games));
  }
}
