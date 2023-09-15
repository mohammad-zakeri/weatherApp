import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';

@immutable
abstract class ForecastWeatherStatus extends Equatable{}

class ForecastWeatherLoading extends ForecastWeatherStatus{

  @override
  List<Object?> get props => [];
}

class ForecastWeatherCompleted extends ForecastWeatherStatus{
  final ForecastDaysEntity forecastDaysEntity;

  ForecastWeatherCompleted(this.forecastDaysEntity);

  @override
  List<Object?> get props => [forecastDaysEntity];
}

class ForecastWeatherError extends ForecastWeatherStatus{
  final String message;

  ForecastWeatherError(this.message);

  @override
  List<Object?> get props => [message];

}