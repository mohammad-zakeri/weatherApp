import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';

/// lat : 27.142
/// lon : 57.076
/// timezone : "Asia/Tehran"
/// timezone_offset : 12600
/// current : {"dt":1694787995,"sunrise":1694743016,"sunset":1694787455,"temp":32.05,"feels_like":37.81,"pressure":1002,"humidity":62,"dew_point":23.85,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":4.79,"wind_deg":197,"wind_gust":5.01,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}]}
/// daily : [{"dt":1694763000,"sunrise":1694743016,"sunset":1694787455,"moonrise":1694743260,"moonset":1694788620,"moon_phase":0,"temp":{"day":34.02,"min":29.28,"max":34.69,"night":29.92,"eve":32.36,"morn":29.34},"feels_like":{"day":39.86,"night":35.08,"eve":37.93,"morn":35.7},"pressure":1005,"humidity":54,"dew_point":23.27,"wind_speed":5.29,"wind_deg":251,"wind_gust":5.01,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":3,"pop":0,"uvi":9.48},{"dt":1694849400,"sunrise":1694829441,"sunset":1694873785,"moonrise":1694832780,"moonset":1694876700,"moon_phase":0.04,"temp":{"day":33.65,"min":28.51,"max":34.72,"night":30.23,"eve":33.28,"morn":28.66},"feels_like":{"day":38.63,"night":35.1,"eve":37.48,"morn":33.05},"pressure":1004,"humidity":53,"dew_point":22.38,"wind_speed":5.26,"wind_deg":235,"wind_gust":4.71,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":4,"pop":0,"uvi":9.53},{"dt":1694935800,"sunrise":1694915866,"sunset":1694960115,"moonrise":1694922360,"moonset":1694964780,"moon_phase":0.07,"temp":{"day":34.6,"min":28.81,"max":36.33,"night":31.64,"eve":35.29,"morn":28.98},"feels_like":{"day":39.02,"night":34.91,"eve":38.08,"morn":33.25},"pressure":1002,"humidity":48,"dew_point":21.42,"wind_speed":4.95,"wind_deg":230,"wind_gust":4.22,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":14,"pop":0,"uvi":9.58},{"dt":1695022200,"sunrise":1695002292,"sunset":1695046445,"moonrise":1695012000,"moonset":1695053040,"moon_phase":0.1,"temp":{"day":36.7,"min":30.45,"max":39.16,"night":32.41,"eve":37.1,"morn":30.71},"feels_like":{"day":38.46,"night":36.51,"eve":40.64,"morn":33.34},"pressure":1002,"humidity":34,"dew_point":17.5,"wind_speed":5.28,"wind_deg":228,"wind_gust":3.68,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":49,"pop":0,"uvi":9.54},{"dt":1695108600,"sunrise":1695088718,"sunset":1695132775,"moonrise":1695101820,"moonset":1695141480,"moon_phase":0.13,"temp":{"day":33.99,"min":29.55,"max":37.27,"night":31.62,"eve":36.43,"morn":29.55},"feels_like":{"day":38.04,"night":35.92,"eve":40.02,"morn":34.41},"pressure":1006,"humidity":49,"dew_point":21.31,"wind_speed":4.81,"wind_deg":247,"wind_gust":3.38,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":54,"pop":0,"uvi":9.45},{"dt":1695195000,"sunrise":1695175143,"sunset":1695219106,"moonrise":1695191760,"moonset":1695230220,"moon_phase":0.17,"temp":{"day":35.69,"min":29.8,"max":38.65,"night":32.29,"eve":37.72,"morn":29.8},"feels_like":{"day":36.99,"night":34.65,"eve":39.63,"morn":32.84},"pressure":1007,"humidity":35,"dew_point":17.4,"wind_speed":4.55,"wind_deg":243,"wind_gust":3.8,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":2,"pop":0,"uvi":10},{"dt":1695281400,"sunrise":1695261569,"sunset":1695305436,"moonrise":1695281880,"moonset":1695319440,"moon_phase":0.2,"temp":{"day":38.96,"min":31.74,"max":39.03,"night":32.92,"eve":37.94,"morn":31.74},"feels_like":{"day":38.48,"night":33.87,"eve":39.34,"morn":31.74},"pressure":1006,"humidity":22,"dew_point":11.75,"wind_speed":4.94,"wind_deg":224,"wind_gust":4.22,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":4,"pop":0,"uvi":10},{"dt":1695367800,"sunrise":1695347995,"sunset":1695391766,"moonrise":1695372060,"moonset":1695409080,"moon_phase":0.25,"temp":{"day":38.74,"min":31.26,"max":39.36,"night":32.22,"eve":38.12,"morn":31.26},"feels_like":{"day":37.64,"night":34.05,"eve":38.38,"morn":31.25},"pressure":1005,"humidity":20,"dew_point":11.05,"wind_speed":6.58,"wind_deg":229,"wind_gust":5.39,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":1,"pop":0,"uvi":10}]

class ForecastDaysModel extends ForecastDaysEntity {
  const ForecastDaysModel({
    num? lat,
    num? lon,
    String? timezone,
    num? timezoneOffset,
    Current? current,
    List<Daily>? daily,
  }): super(
    lat: lat,
    lon: lon,
    timezone: timezone,
    timezoneOffset: timezoneOffset,
    current: current,
    daily: daily,
  );

  factory ForecastDaysModel.fromJson(dynamic json) {

    List<Daily> daily = [];

    if (json['daily'] != null) {

      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });

    }

    return ForecastDaysModel(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
      daily: daily,
    );

  }

}

/// dt : 1694763000
/// sunrise : 1694743016
/// sunset : 1694787455
/// moonrise : 1694743260
/// moonset : 1694788620
/// moon_phase : 0
/// temp : {"day":34.02,"min":29.28,"max":34.69,"night":29.92,"eve":32.36,"morn":29.34}
/// feels_like : {"day":39.86,"night":35.08,"eve":37.93,"morn":35.7}
/// pressure : 1005
/// humidity : 54
/// dew_point : 23.27
/// wind_speed : 5.29
/// wind_deg : 251
/// wind_gust : 5.01
/// weather : [{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}]
/// clouds : 3
/// pop : 0
/// uvi : 9.48

class Daily {
  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  Daily.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? FeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
  }
  num? dt;
  num? sunrise;
  num? sunset;
  num? moonrise;
  num? moonset;
  num? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<Weather>? weather;
  num? clouds;
  num? pop;
  num? uvi;

}

/// id : 800
/// main : "Clear"
/// description : "clear sky"
/// icon : "01d"

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
  num? id;
  String? main;
  String? description;
  String? icon;

}

/// day : 39.86
/// night : 35.08
/// eve : 37.93
/// morn : 35.7

class FeelsLike {
  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike.fromJson(dynamic json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? night;
  num? eve;
  num? morn;

}

/// day : 34.02
/// min : 29.28
/// max : 34.69
/// night : 29.92
/// eve : 32.36
/// morn : 29.34

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp.fromJson(dynamic json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? min;
  num? max;
  num? night;
  num? eve;
  num? morn;

}

/// dt : 1694787995
/// sunrise : 1694743016
/// sunset : 1694787455
/// temp : 32.05
/// feels_like : 37.81
/// pressure : 1002
/// humidity : 62
/// dew_point : 23.85
/// uvi : 0
/// clouds : 0
/// visibility : 10000
/// wind_speed : 4.79
/// wind_deg : 197
/// wind_gust : 5.01
/// weather : [{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}]

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  Current.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
  }
  num? dt;
  num? sunrise;
  num? sunset;
  num? temp;
  num? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? uvi;
  num? clouds;
  num? visibility;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<Weather>? weather;

}