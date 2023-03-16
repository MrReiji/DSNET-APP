import 'package:dorm_gym/models/ConnectionHandler.dart';
import 'package:dorm_gym/widgets/ComplexDrawer.dart';
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
    final screenName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconTheme.of(context).copyWith(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          screenName,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      drawer: ComplexDrawer(),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        height: 500,
        width: 500,
        child: IconButton(
          icon: Icon(Icons.yard),
          onPressed: () {
            ConnectionHandler.getData();
          },
        ),
      )),
    );
  }
}
