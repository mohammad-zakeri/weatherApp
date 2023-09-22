import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';

@immutable
abstract class CurrentWeatherStatus extends Equatable{}

class CurrentWeatherLoading extends CurrentWeatherStatus{
  @override
  List<Object?> get props => [];
}

class CurrentWeatherCompleted extends CurrentWeatherStatus{
  CurrentWeatherCompleted(this.currentCityEntity);

  final CurrentCityEntity currentCityEntity;

  @override
  List<Object?> get props => [currentCityEntity];
}

class CurrentWeatherError extends CurrentWeatherStatus{
  CurrentWeatherError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}