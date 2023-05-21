import 'package:flutter/material.dart';
import 'package:dorm_gym/models/ConnectionHandler.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({required this.url});

  final String url;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ConnectionHandler.makeReservation(url);
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
