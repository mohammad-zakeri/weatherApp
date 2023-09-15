part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadCurrentWeatherEvent extends HomeEvent{
  LoadCurrentWeatherEvent(this.cityName);

  final String cityName;

}

class LoadForecastWeatherEvent extends HomeEvent{
  LoadForecastWeatherEvent(this.params);

  final ForecastParams params;

}
