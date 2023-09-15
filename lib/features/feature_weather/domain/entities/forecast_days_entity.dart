import 'package:equatable/equatable.dart';
import '../../data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable{
  final num? lat;
  final num? lon;
  final String? timezone;
  final num? timezoneOffset;
  final Current? current;
  final List<Daily>? daily;

  const ForecastDaysEntity({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.daily,
  });

  @override
  List<Object?> get props => [
    lat,
    lon,
    timezone,
    timezoneOffset,
    current,
    daily,
  ];

}