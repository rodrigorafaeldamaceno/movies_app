import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/movies_table.dart';

part 'movies_dao.g.dart';

@DriftAccessor(tables: [Movies])
class MoviesDao extends DatabaseAccessor<AppDatabase> with _$MoviesDaoMixin {
  MoviesDao(super.db);

  Future<int> add(entity) {
    return into(movies).insert(entity);
  }

  Future addAll(List<Movie> entities) {
    return batch((batch) => batch.insertAll(movies, entities));
  }

  Future<Movie?> findById(int id) {
    return (select(movies)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<List<Movie>> getAll() {
    return select(movies).watch();
  }

  Future<List<Movie>> getAllAsFuture({String? filter}) {
    return select(movies).get();
  }

  Future remove(int id) {
    return (delete(movies)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future removeAll() {
    return delete(movies).go();
  }

  Future updateMovie(entity) {
    return (update(movies).replace(entity));
  }
}
