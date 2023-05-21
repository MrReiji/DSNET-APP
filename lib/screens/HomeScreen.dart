import 'package:dorm_gym/screens/GymScreen.dart';
import 'package:dorm_gym/widgets/HomeScreenCard.dart';
import 'package:flutter/material.dart';

import '../widgets/ComplexDrawer.dart';
import '../models/MyColors.dart';
import '../cdms.dart';

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
      backgroundColor: Colors.grey.shade200,
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
      "DSNET Panel",
      style: TextStyle(color: MyColors.complexDrawerBlack),
    ),
    backgroundColor: Theme.of(context).canvasColor,
  );
}

Widget body(BuildContext context) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: cdms.length,
      itemBuilder: (BuildContext context, int index) {
        return HSCard(
          icon: cdms[index].icon,
          cardTitle: cdms[index].title,
          routeName: cdms[index].routeName,
        );
      });
}
