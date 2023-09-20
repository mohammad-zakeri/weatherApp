import 'package:equatable/equatable.dart';
import '../../domain/entities/city_entity.dart';

abstract class SaveCityStatus extends Equatable{}

class SaveCityInitial extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

class SaveCityLoading extends SaveCityStatus{
  @override
  List<Object?> get props => [];
}

class SaveCityCompleted extends SaveCityStatus{
  SaveCityCompleted(this.city);

  final City city;

  @override
  List<Object?> get props => [city];
}

class SaveCityError extends SaveCityStatus{
  SaveCityError(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}