import 'package:drift/drift.dart';

@DataClassName('Movie')
class Movies extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get originalTitle => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get overview => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
