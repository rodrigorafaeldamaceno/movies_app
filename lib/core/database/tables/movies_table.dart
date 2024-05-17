import 'package:drift/drift.dart';

@DataClassName('Movie')
class Movies extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get overview => text().nullable()();

  @JsonKey('backdrop_path')
  TextColumn get backdropPath => text().nullable()();
  @JsonKey('release_date')
  TextColumn get releaseDate => text().nullable()();
  @JsonKey('original_title')
  TextColumn get originalTitle => text().nullable()();
  @JsonKey('poster_path')
  TextColumn get posterPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
