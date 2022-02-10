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

class GetGameLoaded extends GetGameState {
  final List<GameModel> gameModel;
  final offset;
  GetGameLoaded(this.gameModel, this.offset);

  GetGameLoaded copyWith(int? offset) {
    return GetGameLoaded(
      gameModel, offset ?? this.offset
    );
  }

  @override
  List<Object?> get props => [gameModel];
}
