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

  static Future<bool> postData(
      Map<String, String> data, BuildContext context) async {
    const url = "https://panel.dsnet.agh.edu.pl/login_check";
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

      dom.Document mainPageLoggedIn =
          await getData("https://panel.dsnet.agh.edu.pl");

      return mainPageLoggedIn
          .querySelector('#tour_welcome')!
          .text
          .contains("Witaj");
      // } on DioError {
      //   showDialog(
      //       barrierDismissible: false,
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text("Connection error"),
      //           content: Text(
      //               "An error occurred while sending your request. Please try again."),
      //           actions: [
      //             TextButton(
      //               child: Text("Ok"),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             )
      //           ],
      //         );
      //       });
      //   return false;
    } catch (error) {
      return false;
    }
  }
}
