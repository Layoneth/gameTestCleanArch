import 'package:dio/dio.dart';
import 'package:game_test/core/constants.dart';
import 'package:game_test/data/local/game_local_data_source.dart';
import 'package:game_test/data/remote/game_remote_data_source.dart';
import 'package:game_test/data/repository/game_repository.dart';
import 'package:game_test/domain/repository/games_repository.dart';
import 'package:game_test/domain/use_cases/get_game.dart';
import 'package:game_test/view/blocs/cubit/get_game_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  await initGames();
}

Future<void> initGames() async {

  //! Features - GetGame
  // Cubit
  sl.registerFactory(() => GetGameCubit(sl()));

  // use cases
  sl.registerLazySingleton(() => GetGameUseCase(sl()));

  // Repository
  sl.registerLazySingleton<GamesRepository>(() => GamesRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<GameRemoteDataSource>(
      () => GameRemoteDataSourceImp(sl()));
  
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerLazySingleton<AppDatabase>(() => database);


  //! External
  sl.registerLazySingleton(() {
    var options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    return dio;
  });

}