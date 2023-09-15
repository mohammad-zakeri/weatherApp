import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/resourcies/data_state.dart';
import 'package:weather_app/core/use_case/use_case.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app/features/feature_weather/domain/repository/weather_repository.dart';

class GetForecastWeatherUseCase extends UseCase<DataState<ForecastDaysEntity>, ForecastParams>{
  GetForecastWeatherUseCase(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams param) {
    return weatherRepository.fetchForecastWeatherData(param);
  }

}