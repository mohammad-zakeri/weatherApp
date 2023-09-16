import 'dart:async';
import 'city_dao.dart';
import 'package:floor/floor.dart';
import '../../../domain/entities/city_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite; // use to database.g.dart

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}