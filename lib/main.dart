import 'package:dorm_gym/widgets/ComplexDrawer.dart';
import 'package:dorm_gym/screens/GymScreen.dart';
import 'package:dorm_gym/screens/HomeScreen.dart';
import 'package:dorm_gym/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'models/MyColors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dorm Gym',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          unselectedWidgetColor: Colors.white,
          primaryColor: MyColors.complexDrawerBlack,
          canvasColor: MyColors.complexDrawerCanvasColor,
        ),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          GymScreen.routeName: (ctx) => GymScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          );
        });
  }
}
