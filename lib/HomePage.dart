import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'ComplexDrawer.dart';
import 'MyColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: MyColors.compexDrawerCanvasColor,
    );
    ;
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    iconTheme: IconTheme.of(context).copyWith(
      color: MyColors.complexDrawerBlack,
    ),
    title: Text(
      "Dorm Gym",
      style: TextStyle(color: MyColors.complexDrawerBlack),
    ),
    backgroundColor: MyColors.compexDrawerCanvasColor,
  );
}

Widget body() {
  return Center(
    child: Container(
      foregroundDecoration: BoxDecoration(
        color: MyColors.complexDrawerBlack,
        backgroundBlendMode: BlendMode.saturation,
      ),
      child: FlutterLogo(
        size: 150,
      ),
    ),
  );
}
