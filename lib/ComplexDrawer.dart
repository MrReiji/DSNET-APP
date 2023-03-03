import 'package:dorm_gym/GymScreen.dart';
import 'package:flutter/material.dart';

import 'ComplexDrawerMenu.dart';
import 'MyColors.dart';

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(GymScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Container(
      width: width,
      child: drawerMenu(),
      color: MyColors.compexDrawerCanvasColor,
    );
  }

  Widget drawerMenu() {
    return Container(
      width: 200,
      color: MyColors.complexDrawerBlack,
      child: Column(
        children: [
          logoTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return cdm.submenus.isEmpty
                    ? ListTile(
                        leading: Icon(cdm.icon, color: Colors.white),
                        title: Text(
                          cdm.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = selected ? index : -1;
                          });
                        },
                      )
                    : ExpansionTile(
                        initiallyExpanded: selectedIndex == index,
                        key: UniqueKey(),
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            selectedIndex = isExpanded ? index : -1;
                          });
                        },
                        leading: Icon(cdm.icon, color: Colors.white),
                        title: Text(
                          cdm.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        children: cdm.submenus.map((subMenu) {
                          return sMenuButton(subMenu);
                        }).toList(),
                      );
              },
            ),
          ),
          accountTile(),
        ],
      ),
    );
  }

  Widget logoTile() {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          child: Image.asset("dsnet-logo-small.png"),
        ),
        title: Text(
          "DSNET Panel",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget sMenuButton(String subMenu) {
    return InkWell(
      onTap: () {
        selectCategory(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          subMenu,
          style: TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: MyColors.complexDrawerBlueGrey,
      child: ListTile(
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.white70,
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2016/03/29/03/14/portrait-1287421_960_720.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        title: Text(
          "Gabriel",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text("DSNET User", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  static List<CDM> cdms = [
    CDM(Icons.person, "Moje dane", []),
    CDM(Icons.house, "Zakwaterowanie", [
      "Bieżące zakwaterowanie",
      "Ostatnie wpłaty",
      "Rada mieszkańców",
      "Wykwaterowanie"
    ]),
    CDM(Icons.stacked_bar_chart_sharp, "Urządzenia i statystyki", []),
    CDM(Icons.fitness_center, "Siłownia", []),
    CDM(Icons.local_laundry_service, "Pralnia", [
      "Pralka 1",
      "Pralka 2",
      "Pralka 3",
      "Pralka 4",
      "Pralka 5",
      "Suszarka 1 Bosch",
      "Suszarka 2 Electrolux"
    ]),
    CDM(Icons.sports_esports_outlined, "Sala rekreacyjna",
        ["Bilard | Tenis stołowy | Dart | Piłkarzyki", "Xbox | Telewizor"]),
    CDM(Icons.sports_basketball, "Boisko sportowe",
        ["Piłka nożna cz. B", "Piłka nożna cz. C", "Siatkówka", "Koszykówka"]),
    CDM(Icons.cleaning_services, "Sprzęty", [
      "Odkurzacze",
      "Planszówki",
      "Sprzęt sportowy",
      "Żelazka i deski do prasowania",
      "Wyposażenie portierni"
    ]),
  ];
}
