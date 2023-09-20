import 'package:flutter/material.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';

@immutable
abstract class CurrentWeatherStatus{}

class CurrentWeatherLoading extends CurrentWeatherStatus{}

class CurrentWeatherCompleted extends CurrentWeatherStatus{
  CurrentWeatherCompleted(this.currentCityEntity);

  final CurrentCityEntity currentCityEntity;

}

class CurrentWeatherError extends CurrentWeatherStatus{
  CurrentWeatherError(this.message);

  final String message;

}