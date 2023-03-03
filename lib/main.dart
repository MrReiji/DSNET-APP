import 'package:dorm_gym/ComplexDrawer.dart';
import 'package:dorm_gym/GymScreen.dart';
import 'package:dorm_gym/HomePage.dart';
import 'package:flutter/material.dart';

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
            unselectedWidgetColor: Colors.white),
        home: HomePage(),
        routes: {
          GymScreen.routeName: (ctx) => GymScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => HomePage(),
          );
        });
  }
}
