part of 'home_bloc.dart';

class HomeState {

  CurrentWeatherStatus currentWeatherStatus;

  HomeState({required this.currentWeatherStatus});

  HomeState copyWith({CurrentWeatherStatus? newCurrentWeatherStatus}){
    return HomeState(currentWeatherStatus: newCurrentWeatherStatus ?? currentWeatherStatus);
  }

}
