import 'package:dorm_gym/models/DataHandler.dart';
import 'package:flutter/material.dart';
import 'package:dorm_gym/models/ConnectionHandler.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton(
      {super.key,
      required this.url,
      required this.daysFromToday,
      required this.rowNumber,
      required this.refreshScreen});

  final String url;
  final int daysFromToday;
  final VoidCallback refreshScreen;
  final int rowNumber;

  @override
  Widget build(BuildContext context) {
    int rNum = 2327 + rowNumber;

    return ElevatedButton(
      onPressed: () async {
        try {
          String date = DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + daysFromToday)
              .toString()
              .substring(0, 10);
          List<String> formActions = await DataHandler.getFormActionList(url);
          String reservationUrl = 'https://panel.dsnet.agh.edu.pl' +
              formActions.firstWhere((element) =>
                  element.contains(date) && element.contains(rNum.toString()));
          ConnectionHandler.makeReservation(reservationUrl);
          refreshScreen();
        } catch (error) {
          rethrow;
        }
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: const Size(20, 20)),
      //maximumSize: const Size(70, 40)),
      child: const Text(
        "Rezerwuj",
        style: TextStyle(fontFamily: 'Verdana', fontSize: 12),
      ),
    );
  }
}

class RemoveReservationButton extends StatelessWidget {
  const RemoveReservationButton(
      {super.key, required this.url, required this.refreshScreen});

  final String url;
  final VoidCallback refreshScreen;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          List<String> formActions = await DataHandler.getFormActionList(url);
          String reservationUrl =
              'https://panel.dsnet.agh.edu.pl' + formActions.last;
          ConnectionHandler.makeReservation(reservationUrl);
          refreshScreen();
        } catch (error) {
          rethrow;
        }
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: const Size(20, 20)),
      //maximumSize: const Size(70, 40)),
      child: const Text(
        "Usuń",
        style: TextStyle(fontFamily: 'Verdana', fontSize: 12),
      ),
    );
  }
}
