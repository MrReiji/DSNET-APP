import 'package:flutter/material.dart';

import 'package:dorm_gym/screens/GymScreen.dart';

import '../../models/ComplexDrawerElement.dart';

import '../cdms.dart';
import '../models/MyColors.dart';
import '../screens/HomeScreen.dart';
import '../screens/LandryScreen.dart';

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  void selectCategory(
      BuildContext context, String routeName, String screenTitle) {
    if (routeName == '/laundry') {
      int washerNumber = int.parse(screenTitle[screenTitle.length - 1]);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LaundryScreen(
            url:
                'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/229${3 + washerNumber}',
            washerNumber: washerNumber,
          ),
        ),
      );
    } else {
      Navigator.of(context).pushNamed(routeName, arguments: screenTitle);
    }
  }

  void returnToHomeScreen(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Container(
      width: width,
      child: drawerMenu(),
      color: MyColors.complexDrawerCanvasColor,
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
                CDE cdm = cdms[index];
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
                            selectCategory(context, cdm.routeName, cdm.title);
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
                          return sMenuButton(subMenu, cdm.routeName);
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
          child: Image.asset("assets\\images\\dsnet-logo-small.png"),
        ),
        title: Text(
          "DSNET Panel",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          setState(() {
            returnToHomeScreen(context);
          });
        },
      ),
    );
  }

  Widget sMenuButton(String subMenu, String routeName) {
    return InkWell(
      onTap: () {
        selectCategory(context, routeName, subMenu);
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
                  "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg"),
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
}
