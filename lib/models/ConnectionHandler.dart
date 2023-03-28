import 'dart:convert';
import 'dart:io';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

Dio dio = Dio();
CookieJar cookieJar = CookieJar();

class ConnectionHandler {
  //final String urlStr = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889";
  static Future<void> getData() async {
    const url = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889";
    try {
      final response = await dio.get(
        url,
      );
      print(response.data.toString());
    } catch (error) {
      throw (error);
    }
  }

  static Future<bool> postData(Map<String, String> data) async {
    const url = "https://panel.dsnet.agh.edu.pl/login_check";
    try {
      final response = await dio.post(url,
          data: data,
          options: Options(headers: {
            'accept':
                'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
            'accept-encoding': 'gzip, deflate, br',
            'accept-language': 'pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7',
            'cache-control': 'max-age=0',
            'content-type': 'application/x-www-form-urlencoded',
            'origin': 'https://panel.dsnet.agh.edu.pl',
            'referer': 'https://panel.dsnet.agh.edu.pl/login',
          }));

      dio.interceptors.add(CookieManager(cookieJar));
      final cookies = response.headers['set-cookie'];
      print(cookies);
      dio.interceptors.add(DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ));
      //print(response.data);
      var elem = parser
          .parse(response.data)
          .getElementsByClassName('tour_welcome')
          .isEmpty;
      //print(elem);
      //print(data);
      return response.statusCode == 200;
    } catch (error) {
      throw (error);
    }
  }
}
