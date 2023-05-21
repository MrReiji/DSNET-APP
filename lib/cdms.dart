import 'package:dorm_gym/screens/LandryScreen.dart';
import 'package:flutter/material.dart';

import 'models/ComplexDrawerElement.dart';

import 'package:dorm_gym/screens/GymScreen.dart';

List<CDE> cdms = [
  CDE(
    Icons.person,
    "Moje dane",
    [],
    GymScreen.routeName,
  ),
  CDE(
      Icons.house,
      "Zakwaterowanie",
      [
        "Bieżące zakwaterowanie",
        "Ostatnie wpłaty",
        "Rada mieszkańców",
        "Wykwaterowanie"
      ],
      GymScreen.routeName),
  CDE(
    Icons.stacked_bar_chart_sharp,
    "Urządzenia i statystyki",
    [],
    GymScreen.routeName,
  ),
  CDE(
    Icons.fitness_center,
    "Siłownia",
    [],
    GymScreen.routeName,
  ),
  CDE(
    Icons.local_laundry_service,
    "Pralnia",
    [
      "Pralka 1",
      "Pralka 2",
      "Pralka 3",
      "Pralka 4",
      "Pralka 5",
      "Suszarka 1 Bosch",
      "Suszarka 2 Electrolux"
    ],
    LaundryScreen.routeName,
  ),
  CDE(
    Icons.sports_esports_outlined,
    "Sala rekreacyjna",
    ["Bilard | Tenis stołowy | Dart | Piłkarzyki", "Xbox | Telewizor"],
    GymScreen.routeName,
  ),
  CDE(
    Icons.sports_basketball,
    "Boisko sportowe",
    ["Piłka nożna cz. B", "Piłka nożna cz. C", "Siatkówka", "Koszykówka"],
    GymScreen.routeName,
  ),
  CDE(
    Icons.cleaning_services,
    "Sprzęty",
    [
      "Odkurzacze",
      "Planszówki",
      "Sprzęt sportowy",
      "Żelazka i deski do prasowania",
      "Wyposażenie portierni"
    ],
    GymScreen.routeName,
  ),
];
