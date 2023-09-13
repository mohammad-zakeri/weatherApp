import 'package:flutter/material.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'core/widgets/main_wrapper.dart';
import 'locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{

  /// init locator
  await setUp();

  runApp(

    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MultiBlocProvider(

        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>()),
        ],

        child: MainWrapper(),
      ),

    ),

  );

}
