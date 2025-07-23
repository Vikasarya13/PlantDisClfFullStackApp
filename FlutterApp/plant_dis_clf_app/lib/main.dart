import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/cubit/detailCubit.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/detailRepository.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/detailScreen.dart';
import 'package:plant_dis_clf_app/Screens/HomeScreen/cubit/homeCubit.dart';
import 'package:plant_dis_clf_app/Screens/HomeScreen/fileFetch.dart';
import 'package:plant_dis_clf_app/constants/app_theme.dart';

import 'Screens/HomeScreen/homeScreen.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> DetailCubit(DetailRepository())),
        BlocProvider(create: (context) => HomeCubit(FileFetch())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plant Disease Classification App',
        theme: AppTheme.themeData(context),
        home: const MyHomePage(),
      ),
    );
  }
}
