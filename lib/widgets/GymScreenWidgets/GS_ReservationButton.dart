import 'package:flutter/material.dart';

class GS_ReservationButton extends StatelessWidget {
  GS_ReservationButton({required this.buttonText, required this.buttonColor});

  final String buttonText;
  final Color buttonColor;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Rezerwacja'),
                centerTitle: true,
              ),
              body: const Center(
                child: Text(
                  'Strona testowa',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(20, 20),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontFamily: 'Verdana'),
      ),
    );
  }
}
