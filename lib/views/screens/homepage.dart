import 'package:budget_tracker_app/views/components/helper/Helper.dart';
import 'package:budget_tracker_app/views/screens/page1.dart';
import 'package:budget_tracker_app/views/screens/page2.dart';
import 'package:budget_tracker_app/views/screens/page3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  List<Widget> allPages = [Page1(),Page2(),Page3(),];

  int selectedIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: selectedIndex,keepPage: true);
    DbHelper.dbHelper.initDb();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: allPages,
        onPageChanged: (val){
          setState(() {
            selectedIndex = val;

          });
        },

      ),
      bottomNavigationBar: NavigationBar(

        selectedIndex: selectedIndex,
          onDestinationSelected: (val){
            setState(() {

              selectedIndex = val;
              pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 10), curve: Curves.linear);
            });
          },
          destinations: [
        NavigationDestination(icon: Icon(CupertinoIcons.home), label: "Home"),
        NavigationDestination(icon: Icon(CupertinoIcons.settings), label: "Settings"),
        NavigationDestination(icon: Icon(CupertinoIcons.phone), label: "Calls"),
      ]),
    );
  }
}
