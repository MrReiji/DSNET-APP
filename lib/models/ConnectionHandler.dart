import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:convert';

class ConnectionHandler {
  //final String urlStr = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889";
  static Future<void> getData() async {
    final url =
        Uri.parse("https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889");
    try {
      final response = await http.get(url);
      print(response.body);
    } catch (error) {
      throw (error);
    }
  }

  static Future<bool> postData(Map<String, String> data) async {
    final url = Uri.parse("https://panel.dsnet.agh.edu.pl/login_check");
    try {
      final response = await http.post(url, body: data);
      print(response.body);
      var elem = parser
          .parse(response.body)
          .getElementsByClassName("tour_welcome")
          .isEmpty;
      print(elem);
      print(data);
      return response.statusCode == 200;
    } catch (error) {
      throw (error);
    }
  }
}
