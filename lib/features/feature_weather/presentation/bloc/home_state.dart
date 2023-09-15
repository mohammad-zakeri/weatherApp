part of 'home_bloc.dart';

class HomeState extends Equatable {

  final CurrentWeatherStatus currentWeatherStatus;
  final ForecastWeatherStatus forecastWeatherStatus;

  const HomeState({required this.currentWeatherStatus, required this.forecastWeatherStatus});

  HomeState copyWith({CurrentWeatherStatus? newCurrentWeatherStatus, ForecastWeatherStatus? newForecastWeatherStatus}){
    return HomeState(currentWeatherStatus: newCurrentWeatherStatus ?? currentWeatherStatus, forecastWeatherStatus: newForecastWeatherStatus ?? forecastWeatherStatus);
  }

  @override
  List<Object?> get props => [currentWeatherStatus, forecastWeatherStatus];

}
