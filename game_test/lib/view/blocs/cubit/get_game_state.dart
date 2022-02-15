part of 'get_game_cubit.dart';

@immutable
abstract class GetGameState extends Equatable{}

class GetGameInitial extends GetGameState {
  @override
  List<Object?> get props => [];
}

class GetGameLoading extends GetGameState {
  @override
  List<Object?> get props => [];
}

class GetGameError extends GetGameState {
  final String errorMessage;
  GetGameError(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class GetGameLoaded extends GetGameState {
  final List<GameModel> gameModels;
  final int offset;
  GetGameLoaded({
    this.gameModels = const [],
    this.offset = 0
  });

  GetGameLoaded addGames({
    List<GameModel>? games,
    int? offset
  }){
    return GetGameLoaded(
      gameModels: games ?? gameModels,
      offset: offset ?? this.offset
    );
  }

  @override
  List<Object?> get props => [gameModels];
}
