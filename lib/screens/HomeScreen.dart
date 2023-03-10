import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/ComplexDrawer.dart';
import '../models/MyColors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Theme.of(context).canvasColor,
    );
    ;
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    iconTheme: IconTheme.of(context).copyWith(
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      "Dorm Gym",
      style: TextStyle(color: MyColors.complexDrawerBlack),
    ),
    backgroundColor: Theme.of(context).canvasColor,
  );
}

Widget body(BuildContext context) {
  return Center(
    child: Container(
      foregroundDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        backgroundBlendMode: BlendMode.saturation,
      ),
      child: FlutterLogo(
        size: 150,
      ),
    ),
  );
}
