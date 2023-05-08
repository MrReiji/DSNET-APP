import 'package:flutter/material.dart';

class HSCard extends StatelessWidget {
  final IconData icon;
  final String cardTitle;
  final String routeName;

  const HSCard(
      {required this.icon,
      required this.cardTitle,
      required this.routeName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkResponse(
        highlightShape: BoxShape.rectangle,
        containedInkWell: true,
        splashColor: Colors.amberAccent,
        onTap: () {
          Navigator.of(context).pushNamed(routeName, arguments: cardTitle);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 100),
              SizedBox(height: 10),
              Text(
                cardTitle,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
