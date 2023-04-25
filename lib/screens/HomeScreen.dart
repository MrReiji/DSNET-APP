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
      "DSNET Panel",
      style: TextStyle(color: MyColors.complexDrawerBlack),
    ),
    backgroundColor: Theme.of(context).canvasColor,
  );
}

Widget body(BuildContext context) {
  return GridView.count(
    primary: false,
    padding: const EdgeInsets.all(10),
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    crossAxisCount: 2,
    children: <Widget>[
      Card(
        color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          containedInkWell: true,
          splashColor: Colors.amberAccent,
          onTap: () {},
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fitness_center, size: 100),
                SizedBox(height: 10),
                Text(
                  "Gym",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[200],
        child: const Text('Heed not the rabble'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('Sound of screams but the'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[400],
        child: const Text('Who scream'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[500],
        child: const Text('Revolution is coming...'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[600],
        child: const Text('Revolution, they...'),
      ),
    ],
  );
}
