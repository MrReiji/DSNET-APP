import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchData {
  //final String urlStr = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889";
  static Future<void> fetchData() async {
    final url =
        Uri.parse("https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889");
    try {
      final response = await http.get(url);
      print(response.body);
    } catch (error) {
      throw (error);
    }
  }
}
