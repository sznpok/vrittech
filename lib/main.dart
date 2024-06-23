import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrititech/bloc/bottom_nav_bar_bloc/home_page_bloc.dart';
import 'package:vrititech/utils/size.dart';
import 'package:vrititech/utils/theme_data.dart';

import 'screen/bottom_nav_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightThemeData(context),
        debugShowCheckedModeBanner: false,
        home: const BottomNavBarScreen(),
      ),
    );
  }
}
