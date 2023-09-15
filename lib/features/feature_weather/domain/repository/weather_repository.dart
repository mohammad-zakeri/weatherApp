import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/resourcies/data_state.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import '../../data/models/suggest_city_model.dart';

abstract class WeatherRepository{

  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(ForecastParams params);

  Future<List<Data>> fetchSuggestData(cityName);

}