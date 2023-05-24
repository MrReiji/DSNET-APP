import 'package:dorm_gym/screens/GymScreen.dart';
import 'package:dorm_gym/screens/HomeScreen.dart';
import 'package:dorm_gym/screens/LandryScreen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (ctx) => HomeScreen(),
  GymScreen.routeName: (ctx) => GymScreen(),
  LaundryScreen.routeName: (ctx) => LaundryScreen(
        url: 'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294',
        washerNumber: 1,
      ),
};
