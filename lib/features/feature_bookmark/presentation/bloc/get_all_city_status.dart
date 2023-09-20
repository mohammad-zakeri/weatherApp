import 'package:equatable/equatable.dart';
import '../../domain/entities/city_entity.dart';

abstract class GetAllCityStatus extends Equatable{}

class GetAllCityLoading extends GetAllCityStatus{
  @override
  List<Object?> get props => [];
}

class GetAllCityCompleted extends GetAllCityStatus{
  GetAllCityCompleted(this.cities);

  final List<City> cities;

  @override
  List<Object?> get props => [cities];
}

class GetAllCityError extends GetAllCityStatus{
  GetAllCityError(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}