import 'dart:convert';
import 'dart:io';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:requests/requests.dart';
import 'package:http_parser/http_parser.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

Dio dio = Dio();
String cookie = "";

class ConnectionHandler {
  static Future<String> getData(String url) async {
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Cookie": cookie,
          }));
      return response.toString();
    } catch (error) {
      throw (error);
    }
  }

  static Future<bool> postData(Map<String, String> data) async {
    const url = "https://panel.dsnet.agh.edu.pl/login_check";
    try {
      final response = await dio.post(url,
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              // print(status);
              return status! < 500;
            },
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
            },
          ));

      cookie = response.headers['set-cookie']![0].split(';')[0];

      String mainPageLoggedIn = await getData("https://panel.dsnet.agh.edu.pl");

      // debugPrint(mainPageLoggedIn);

      // print(cookie);

      return (mainPageLoggedIn.contains("tour_welcome"));
    } catch (error) {
      throw (error);
    }
  }
}
