import 'package:dorm_gym/ComplexDrawer.dart';
import 'package:flutter/material.dart';

class GymScreen extends StatefulWidget {
  const GymScreen({super.key});

  static const routeName = '/gym';

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: ComplexDrawer(),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        height: 500,
        width: 500,
        child: Icon(Icons.abc),
      )),
    );
  }
}
