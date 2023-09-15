import 'package:dio/dio.dart';
import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/resourcies/data_state.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather_app/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app/features/feature_weather/domain/repository/weather_repository.dart';
import '../../domain/entities/suggest_city_entity.dart';
import '../models/suggest_city_model.dart';

class WeatherRepositoryImpl extends WeatherRepository{

  ApiProvider apiProvider;

  WeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async {

    try{

      Response response = await apiProvider.callCurrentWeather(cityName: cityName);

      if(response.statusCode == 200){

        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(response.data);
        
        return DataSuccess(currentCityEntity);
        
      }else{
        
        return const DataFailed(Constants.error);
        
      }

    }catch(e){

      return const DataFailed(Constants.internetError);

    }

  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(ForecastParams params) async {

    try{

      Response response = await apiProvider.sendRequest7DayForecast(params: params);

      if(response.statusCode == 200){

        ForecastDaysEntity forecastDaysEntity = ForecastDaysModel.fromJson(response.data);

        return DataSuccess(forecastDaysEntity);

      }else{

        return const DataFailed(Constants.error);

      }

    }catch(e){

      return const DataFailed(Constants.internetError);

    }

  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {

    Response response = await apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityEntity suggestCityEntity = SuggestCityModel.fromJson(response.data);

    return suggestCityEntity.data!;
  }

}