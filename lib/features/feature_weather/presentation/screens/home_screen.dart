import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import '../../../../core/params/forecast_params.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../../../locator.dart';
import '../../../feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import '../../data/models/forecast_days_model.dart';
import '../../data/models/suggest_city_model.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../domain/use_cases/get_suggestion_city_usecase.dart';
import '../bloc/home_bloc.dart';
import '../widgets/bookmark_icon.dart';
import '../widgets/day_weather_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  TextEditingController textEditingController = TextEditingController();

  /// We call GetSuggestionCityUseCase directly and there is no need to use a bloc
  GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());

  String cityName = "Tehran";
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCurrentWeatherEvent(cityName));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),

              child: Row(
                children: [

                  /// search box
                  Expanded(

                    child: TypeAheadField(

                        textFieldConfiguration: TextFieldConfiguration(
                          controller: textEditingController,

                          /// Click on Enter on the phone keyboard
                          onSubmitted: (String prefix) {
                            textEditingController.text = prefix;
                            BlocProvider.of<HomeBloc>(context).add(LoadCurrentWeatherEvent(prefix));
                          },

                          style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),

                          decoration: const InputDecoration(
                            hintText: "Enter a City...",
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            hintStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),

                        ),

                        suggestionsCallback: (String prefix){
                          return getSuggestionCityUseCase(prefix);
                        },

                        itemBuilder: (context, Data model){
                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(model.name!),
                            subtitle: Text("${model.region!}, ${model.country!}"),
                          );
                        },

                        onSuggestionSelected: (Data model){
                          textEditingController.text = model.name!;
                          BlocProvider.of<HomeBloc>(context).add(LoadCurrentWeatherEvent(model.name!));
                        },

                    ),

                  ),

                  const SizedBox(width: 10),

                  BlocBuilder<HomeBloc, HomeState>(

                      buildWhen: (previous, current){
                        if(previous.currentWeatherStatus == current.currentWeatherStatus){
                          return false;
                        }
                        return true;
                      },

                      builder: (context, state){

                        /// show Loading State for currentWeatherStatus
                        if (state.currentWeatherStatus is CurrentWeatherLoading) {
                          return const CircularProgressIndicator();
                        }

                        /// show Error State for currentWeatherStatus
                        if (state.currentWeatherStatus is CurrentWeatherError) {
                          return IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.error,color: Colors.white,size: 35),
                          );
                        }

                        if(state.currentWeatherStatus is CurrentWeatherCompleted){
                          final CurrentWeatherCompleted cwComplete = state.currentWeatherStatus as CurrentWeatherCompleted;
                          BlocProvider.of<BookmarkBloc>(context).add(GetCityByNameEvent(cwComplete.currentCityEntity.name!));
                          return BookMarkIcon(name: cwComplete.currentCityEntity.name!);
                        }

                        return Container();

                      }

                  ),

                ],
              ),

            ),

            /// main UI
            BlocBuilder<HomeBloc,HomeState>(

              buildWhen: (previous, current){
                /// rebuild just when currentWeatherStatus Changed
                if(previous.currentWeatherStatus == current.currentWeatherStatus){
                  return false;
                }
                return true;
              },

              builder: (context, state){

                if(state.currentWeatherStatus is CurrentWeatherLoading){
                  return const Expanded(child: DotLoadingWidget());
                }

                if(state.currentWeatherStatus is CurrentWeatherCompleted){

                  /// cast
                  final CurrentWeatherCompleted cwCompleted = state.currentWeatherStatus as CurrentWeatherCompleted;
                  final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;

                  /// create params for api call
                  final ForecastParams forecastParams = ForecastParams(currentCityEntity.coord!.lat!, currentCityEntity.coord!.lon!);

                  /// start load Forecast Weather event
                  BlocProvider.of<HomeBloc>(context).add(LoadForecastWeatherEvent(forecastParams));

                  /// change Times to Hour --5:55 AM/PM----
                  final sunset =  DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunset,currentCityEntity.timezone);
                  final sunrise = DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunrise,currentCityEntity.timezone);

                  return Expanded(

                      child: ListView(
                        children: [

                          Padding(
                            padding: EdgeInsets.only(top: height * 0.02),

                            child: SizedBox(
                              width: width,
                              height: 400,

                              child: PageView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                allowImplicitScrolling: true,
                                controller: _pageController,
                                itemCount: 2,

                                itemBuilder: (context, position) {

                                  if (position == 0) {

                                    return Column(
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.only(top: 50),

                                          child: Text(
                                            currentCityEntity.name!,
                                            style: const TextStyle(fontSize: 30,color: Colors.white),
                                          ),

                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),

                                          child: Text(
                                            currentCityEntity.weather![0].description!,
                                            style: const TextStyle(fontSize: 20,color: Colors.grey),
                                          ),

                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: AppBackground.setIconForMain(currentCityEntity.weather![0].description!),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),

                                          child: Text(
                                            "${currentCityEntity.main!.temp!.round()}\u00B0",
                                            style: const TextStyle(fontSize: 50,color: Colors.white),
                                          ),

                                        ),

                                        const SizedBox(height: 20),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [

                                            /// max temp
                                            Column(
                                              children: [

                                                const Text(
                                                  "max",
                                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                                ),

                                                const SizedBox(height: 10),

                                                Text(
                                                  "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                                )

                                              ],
                                            ),

                                            /// divider
                                            Padding(

                                              padding: const EdgeInsets.only(left: 10.0, right: 10),

                                              child: Container(
                                                color: Colors.grey,
                                                width: 2,
                                                height: 40,
                                              ),

                                            ),

                                            /// min temp
                                            Column(
                                              children: [

                                                const Text(
                                                  "min",
                                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                                ),

                                                const SizedBox(height: 10),

                                                Text(
                                                  "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                                ),

                                              ],
                                            ),

                                          ],
                                        ),

                                      ],
                                    );

                                  } else {

                                    return Container(
                                      color: Colors.amber,
                                    );

                                  }

                                },
                              ),

                            ),

                          ),

                          const SizedBox(height: 10),

                          /// pageView Indicator
                          Center(

                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: const ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                spacing: 5,
                                activeDotColor: Colors.white,
                              ),
                              onDotClicked: (index) => _pageController.animateToPage(index, duration: const Duration(microseconds: 500), curve: Curves.bounceOut),
                            ),

                          ),

                          /// divider
                          Padding(
                            padding: const EdgeInsets.only(top: 30),

                            child: Container(
                              color: Colors.white24,
                              height: 2,
                              width: double.infinity,
                            ),

                          ),

                          /// forecast weather 7 days
                          Padding(
                            padding: const EdgeInsets.only(top: 15),

                            child: SizedBox(
                              width: double.infinity,
                              height: 100,

                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),

                                child: Center(

                                  child: BlocBuilder<HomeBloc, HomeState>(

                                    builder: (BuildContext context, state) {

                                      /// show Loading State for Forecast Weather
                                      if (state.forecastWeatherStatus is ForecastWeatherLoading) {
                                        return const DotLoadingWidget();
                                      }

                                      /// show Completed State for Forecast Weather
                                      if (state.forecastWeatherStatus is ForecastWeatherCompleted) {
                                        /// casting
                                        final ForecastWeatherCompleted fwCompleted = state.forecastWeatherStatus as ForecastWeatherCompleted;
                                        final ForecastDaysEntity forecastDaysEntity = fwCompleted.forecastDaysEntity;
                                        final List<Daily> mainDaily = forecastDaysEntity.daily!;

                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 8,

                                          itemBuilder: (BuildContext context, int index) {
                                            return DaysWeatherView(daily: mainDaily[index]);
                                          },

                                        );

                                      }

                                      /// show Error State for Forecast Weather
                                      if (state.forecastWeatherStatus is ForecastWeatherError) {

                                        final ForecastWeatherError fwError = state.forecastWeatherStatus as ForecastWeatherError;

                                        return Center(
                                          child: Text(fwError.message),
                                        );

                                      }

                                      /// show Default State for Forecast Weather
                                      return Container();

                                    },

                                  ),

                                ),

                              ),

                            ),

                          ),

                          /// divider
                          Padding(
                            padding: const EdgeInsets.only(top: 15),

                            child: Container(
                              color: Colors.white24,
                              height: 2,
                              width: double.infinity,
                            ),

                          ),

                          const SizedBox(height: 30),

                          /// last Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Column(
                                children: [

                                  Text(
                                    "wind speed",
                                    style: TextStyle(fontSize: height * 0.017, color: Colors.amber),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),

                                    child: Text(
                                      "${currentCityEntity.wind!.speed!} m/s",
                                      style: TextStyle(fontSize: height * 0.016, color: Colors.white),
                                    ),

                                  ),

                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),

                                child: Container(color: Colors.white24, height: 30, width: 2),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),

                                child: Column(
                                  children: [

                                    Text(
                                      "sunrise",

                                      style: TextStyle(fontSize: height * 0.017, color: Colors.amber),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),

                                      child: Text(
                                        sunrise,

                                        style: TextStyle(
                                          fontSize: height * 0.016,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ),

                                  ],
                                ),

                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),

                                child: Container(color: Colors.white24, height: 30, width: 2),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),

                                child: Column(
                                  children: [

                                    Text(
                                      "sunset",

                                      style: TextStyle(fontSize: height * 0.017, color: Colors.amber),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),

                                    child: Text(
                                      sunset,
                                      style: TextStyle(fontSize: height * 0.016, color: Colors.white),
                                    ),

                                  ),

                                  ],
                                ),

                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),

                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),

                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),

                                child: Column(
                                  children: [

                                  Text(
                                    "humidity",

                                    style: TextStyle(fontSize: height * 0.017, color: Colors.amber),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),

                                    child: Text(
                                      "${currentCityEntity.main!.humidity!}%",

                                      style: TextStyle(fontSize: height * 0.016, color: Colors.white),
                                    ),

                                  ),

                                  ],
                                ),

                              ),

                            ],
                          ),

                          const SizedBox(height: 30),

                        ],
                      ),

                  );

                }

                if(state.currentWeatherStatus is CurrentWeatherError){
                  return const Center(child: Text('error',style: TextStyle(color: Colors.white)));
                }

                return Container();

              },
            ),

          ],
        ),

    );

  }

  /// used for AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;

}