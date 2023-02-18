import 'package:flutter/material.dart';

import 'ComplexDrawerMenu.dart';

int selectedIndex = -1; //don't set to 0
int currentCattegory = -1;

class ComplexDrawerPage extends StatefulWidget {
  const ComplexDrawerPage({Key? key}) : super(key: key);

  @override
  State<ComplexDrawerPage> createState() => _ComplexDrawerPageState();
}

class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color(0xffe3e9f7),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Dorm Gym",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color(0xffe3e9f7),
    );
  }
}

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  State<ComplexDrawer> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return Container(
      //width: width / 2,
      child: Row(
        children: [blackIconMenu(changeIndex), invisibleSubMenus()],
      ),
    );
  }

  void changeIndex() {
    setState(() {
      currentCattegory = selectedIndex;
    });
  }
}

Container blackIconMenu(VoidCallback changeIndex) {
  return Container(
      width: 100,
      color: Color(0xff11111d),
      child: ListView.builder(
          itemCount: cdms.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () {
                selectedIndex = index;
                changeIndex();
              },
              child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Icon(
                    cdms[index].icon,
                    color: Colors.white,
                  )),
            );
          }));
}

Container invisibleSubMenus() {
  return Container(
    width: 125,
    color: Color(0xffe3e9f7),
    child: ListView.builder(
      itemCount: cdms.length,
      itemBuilder: (ctx, index) {
        CDM cdm = cdms[index];
        bool isValidSubMenu =
            (currentCattegory == index) && cdm.submenus.isNotEmpty;
        return subMenuWidget([cdm.title]..addAll(cdm.submenus), isValidSubMenu);
      },
    ),
  );
}

Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 400),
    height: isValidSubMenu ? 200 : 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isValidSubMenu ? Color(0xff1d1b31) : Colors.transparent,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: ListView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: isValidSubMenu ? submenus.length : 0,
      itemBuilder: (ctx, index) {
        String subMenu = submenus[index];
        return InkWell(
          onTap: () {
            //TODO handle the function
            //TODO index== 0 ? doNothing : doLogic
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subMenu,
              style: TextStyle(
                  fontSize: index == 0 ? 17 : 14,
                  color: index == 0 ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    ),
  );
}

List<CDM> cdms = [
  CDM(Icons.grid_view, "Dashboard", []),
  CDM(Icons.subscriptions, "Category",
      ["HTML & CSS", "Javascript", "PHP & MySQL"]),
  CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
  CDM(Icons.pie_chart, "Analytics", []),
  CDM(Icons.trending_up, "Chart", []),
  CDM(Icons.power, "Plugins", ["Ad Blocker", "Everything Https", "Dark Mode"]),
  CDM(Icons.explore, "Explore", []),
  CDM(Icons.settings, "Setting", []),
];
