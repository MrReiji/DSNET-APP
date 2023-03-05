import 'package:flutter/material.dart';

import 'models/ComplexDrawerElement.dart';

List<CDE> cdms = [
  CDE(Icons.person, "Moje dane", []),
  CDE(Icons.house, "Zakwaterowanie", [
    "Bieżące zakwaterowanie",
    "Ostatnie wpłaty",
    "Rada mieszkańców",
    "Wykwaterowanie"
  ]),
  CDE(Icons.stacked_bar_chart_sharp, "Urządzenia i statystyki", []),
  CDE(Icons.fitness_center, "Siłownia", []),
  CDE(Icons.local_laundry_service, "Pralnia", [
    "Pralka 1",
    "Pralka 2",
    "Pralka 3",
    "Pralka 4",
    "Pralka 5",
    "Suszarka 1 Bosch",
    "Suszarka 2 Electrolux"
  ]),
  CDE(Icons.sports_esports_outlined, "Sala rekreacyjna",
      ["Bilard | Tenis stołowy | Dart | Piłkarzyki", "Xbox | Telewizor"]),
  CDE(Icons.sports_basketball, "Boisko sportowe",
      ["Piłka nożna cz. B", "Piłka nożna cz. C", "Siatkówka", "Koszykówka"]),
  CDE(Icons.cleaning_services, "Sprzęty", [
    "Odkurzacze",
    "Planszówki",
    "Sprzęt sportowy",
    "Żelazka i deski do prasowania",
    "Wyposażenie portierni"
  ]),
];
