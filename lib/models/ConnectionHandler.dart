import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart';

Dio dio = Dio();
String cookie = "";

showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: new Row(
          children: [
            CircularProgressIndicator(),
            Container(
                margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
          ],
        ),
      );
    },
  );
}

class ConnectionHandler {
  static Future<dom.Document> getData(String url) async {
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Cookie": cookie,
          }));
      return parser.parse(response.data);
    } catch (error) {
      throw (error);
    }
  }

  static Future<bool> loginFunction(
      Map<String, String> data, BuildContext context) async {
    const String url = "https://panel.dsnet.agh.edu.pl/login_check";
    try {
      showLoaderDialog(context);

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
      //print(cookie);

      dom.Document mainPageLoggedIn =
          await getData("https://panel.dsnet.agh.edu.pl");

      return mainPageLoggedIn
          .querySelector('#tour_welcome')!
          .text
          .contains("Witaj");
    } catch (error) {
      return false;
    }
  }

  static Future<void> makeReservation(String url) async {
    final String _url = url;
    try {
      final response = await dio.post(url,
          data: {'form': 'single'},
          options: Options(
            headers: {
              'cookie': cookie,
            },
          ));
    } catch (e) {
      if (e is DioError) {
        final dioError = e as DioError;
        if (dioError.response != null) {
          if (dioError.response!.statusCode == 302) {
            print("Your booking request has been sent");
          } else {
            rethrow;
          }
        }
      }
    }
  }
}
