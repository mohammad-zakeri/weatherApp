import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/resourcies/data_state.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/domain/use_cases/get_current_weather_use_case.dart';
import 'package:weather_app/features/feature_weather/domain/use_cases/get_forecast_weather_use_case.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'home_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([GetCurrentWeatherUseCase, GetForecastWeatherUseCase])
void main(){

  MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
  MockGetForecastWeatherUseCase mockGetForecastWeatherUseCase = MockGetForecastWeatherUseCase();

  String cityName = 'Tehran';
  String error = 'error';

  group('current weather Event test', () {

    when(mockGetCurrentWeatherUseCase.call(any)).thenAnswer((_) async => Future.value(const DataSuccess(CurrentCityEntity())));

    blocTest<HomeBloc, HomeState>(
      'emit Loading and Completed state',
      build: () => HomeBloc(mockGetCurrentWeatherUseCase, mockGetForecastWeatherUseCase),

      act: (bloc) {
        bloc.add(LoadCurrentWeatherEvent(cityName));
      },

      expect: () => <HomeState>[
        HomeState(currentWeatherStatus: CurrentWeatherLoading(), forecastWeatherStatus: ForecastWeatherLoading()),
        HomeState(currentWeatherStatus: CurrentWeatherCompleted(const CurrentCityEntity()), forecastWeatherStatus: ForecastWeatherLoading()),
      ],

    );

    /// Second Way
    test('emit Loading and Error state', () {

      when(mockGetCurrentWeatherUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed(error)));

      final bloc = HomeBloc(mockGetCurrentWeatherUseCase,mockGetForecastWeatherUseCase);
      bloc.add(LoadCurrentWeatherEvent(cityName));

      expectLater(
        bloc.stream,emitsInOrder(
          [
            HomeState(currentWeatherStatus: CurrentWeatherLoading(), forecastWeatherStatus: ForecastWeatherLoading()),
            HomeState(currentWeatherStatus: CurrentWeatherError(error), forecastWeatherStatus: ForecastWeatherLoading()),
          ],
        ),
      );

    });

  });

}