import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class City extends Equatable{
  City(this.name);

  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  @override
  List<Object?> get props => [name];
}