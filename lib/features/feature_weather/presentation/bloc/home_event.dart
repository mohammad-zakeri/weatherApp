part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadCurrentWeatherEvent extends HomeEvent{
  LoadCurrentWeatherEvent(this.cityName);

  final String cityName;

}
