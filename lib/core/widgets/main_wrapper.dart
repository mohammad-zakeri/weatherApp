import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/home_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCurrentWeatherEvent("Tehran"));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),

      body: BlocBuilder<HomeBloc, HomeState>(

        builder: (context, state) {

          if(state.currentWeatherStatus is CurrentWeatherLoading){
            return const Center(child: Text('loading ...'));
          }

          if(state.currentWeatherStatus is CurrentWeatherCompleted){
            return const Center(child: Text('completed'));
          }

          if(state.currentWeatherStatus is CurrentWeatherError){
            return const Center(child: Text('error'));
          }

          return Container();

        },

      ),

    );

  }

}
