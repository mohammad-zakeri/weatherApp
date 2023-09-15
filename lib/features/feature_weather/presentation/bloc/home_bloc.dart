import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/resourcies/data_state.dart';
import 'package:weather_app/features/feature_weather/domain/use_cases/get_forecast_weather_use_case.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import '../../domain/use_cases/get_current_weather_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase) : super(HomeState(currentWeatherStatus: CurrentWeatherLoading(), forecastWeatherStatus: ForecastWeatherLoading())) {

    on<LoadCurrentWeatherEvent>((event, emit) async {

      emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherLoading()));

      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if(dataState is DataSuccess){

        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherCompleted(dataState.data)));

      }

      if(dataState is DataFailed){

        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherError(dataState.error!)));

      }

    });

    on<LoadForecastWeatherEvent>((event, emit) async {

      emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherLoading()));

      DataState dataState = await getForecastWeatherUseCase(event.params);

      if(dataState is DataSuccess){

        emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherCompleted(dataState.data)));

      }

      if(dataState is DataFailed){

        emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherError(dataState.error!)));

      }

    });

  }

}
