import 'package:equatable/equatable.dart';
import '../../domain/entities/city_entity.dart';

abstract class GetCityStatus extends Equatable{}

class GetCityLoading extends GetCityStatus{
  @override
  List<Object?> get props => [];
}

class GetCityCompleted extends GetCityStatus{
  GetCityCompleted(this.city);

  final City? city;

  @override
  List<Object?> get props => [city];
}

class GetCityError extends GetCityStatus{
  GetCityError(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}