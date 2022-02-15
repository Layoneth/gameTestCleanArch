// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_local_data_source.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GameLocalDataSourceDao? _gameLocalDataSourceDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GameModel` (`id` INTEGER NOT NULL, `category` INTEGER, `cover` INTEGER, `createdAt` INTEGER, `firstReleaseDate` INTEGER, `name` TEXT NOT NULL, `slug` TEXT, `status` INTEGER, `summary` TEXT, `updatedAt` INTEGER, `url` TEXT, `checksum` TEXT, `parentGame` INTEGER, `rating` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ScreenshotModel` (`id` INTEGER NOT NULL, `game` INTEGER NOT NULL, `height` INTEGER NOT NULL, `imageId` TEXT NOT NULL, `url` TEXT NOT NULL, `width` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GameLocalDataSourceDao get gameLocalDataSourceDao {
    return _gameLocalDataSourceDaoInstance ??=
        _$GameLocalDataSourceDao(database, changeListener);
  }
}

class _$GameLocalDataSourceDao extends GameLocalDataSourceDao {
  _$GameLocalDataSourceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gameModelInsertionAdapter = InsertionAdapter(
            database,
            'GameModel',
            (GameModel item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'cover': item.cover,
                  'createdAt': item.createdAt,
                  'firstReleaseDate': item.firstReleaseDate,
                  'name': item.name,
                  'slug': item.slug,
                  'status': item.status,
                  'summary': item.summary,
                  'updatedAt': item.updatedAt,
                  'url': item.url,
                  'checksum': item.checksum,
                  'parentGame': item.parentGame,
                  'rating': item.rating
                }),
        _screenshotModelInsertionAdapter = InsertionAdapter(
            database,
            'ScreenshotModel',
            (ScreenshotModel item) => <String, Object?>{
                  'id': item.id,
                  'game': item.game,
                  'height': item.height,
                  'imageId': item.imageId,
                  'url': item.url,
                  'width': item.width
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GameModel> _gameModelInsertionAdapter;

  final InsertionAdapter<ScreenshotModel> _screenshotModelInsertionAdapter;

  @override
  Future<List<GameModel>> getGames() async {
    return _queryAdapter.queryList('SELECT * FROM GameModel',
        mapper: (Map<String, Object?> row) => GameModel(
            id: row['id'] as int,
            category: row['category'] as int?,
            cover: row['cover'] as int?,
            createdAt: row['createdAt'] as int?,
            firstReleaseDate: row['firstReleaseDate'] as int?,
            name: row['name'] as String,
            slug: row['slug'] as String?,
            status: row['status'] as int?,
            summary: row['summary'] as String?,
            updatedAt: row['updatedAt'] as int?,
            url: row['url'] as String?,
            checksum: row['checksum'] as String?,
            parentGame: row['parentGame'] as int?,
            rating: row['rating'] as double?));
  }

  @override
  Future<List<ScreenshotModel>> getScreenshots(int idGame) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ScreenshotModel WHERE game = ?1',
        mapper: (Map<String, Object?> row) => ScreenshotModel(
            id: row['id'] as int,
            game: row['game'] as int,
            height: row['height'] as int,
            imageId: row['imageId'] as String,
            url: row['url'] as String,
            width: row['width'] as int),
        arguments: [idGame]);
  }

  @override
  Future<ScreenshotModel?> getScreenshot(int idScreen) async {
    return _queryAdapter.query('SELECT * FROM ScreenshotModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ScreenshotModel(
            id: row['id'] as int,
            game: row['game'] as int,
            height: row['height'] as int,
            imageId: row['imageId'] as String,
            url: row['url'] as String,
            width: row['width'] as int),
        arguments: [idScreen]);
  }

  @override
  Future<void> insertGames(List<GameModel> games) async {
    await _gameModelInsertionAdapter.insertList(
        games, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertScreenshots(List<ScreenshotModel> screenshots) async {
    await _screenshotModelInsertionAdapter.insertList(
        screenshots, OnConflictStrategy.abort);
  }
}
