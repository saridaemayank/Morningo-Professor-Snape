import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:morningo/Models/infoGathering.dart';
import 'package:morningo/Pages/HomePage.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/SettingsPage.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/courses.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/leaderboard.dart';

// ignore: must_be_immutable
class BottomNavController extends StatefulWidget {
  // ignore: non_constant_identifier_names
  InfoGateherer gateherer;
  // New
  BuildContext contextOf;

  BottomNavController({
    Key key,
    this.gateherer,
    this.contextOf,
  }) : super(key: key);
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  List screens = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      CoursesPage(),
      HomePage(
        gateherer: widget.gateherer,
        contextOf: widget.contextOf,
      ),
      LeaderboardPage(),
      SettingsPage(),
    ];
  }

  var currentIndex_ = 1;

  Future<bool> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to exit Morningo?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('NO'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('back button pressed');
        final shouldPop = await showWarning(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,

        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(28),
              topLeft: Radius.circular(28),
            ),
            child: SizedBox(
              height: 100,
              child: BottomNavigationBar(
                currentIndex: currentIndex_,
                enableFeedback: true,
                unselectedItemColor: const Color(0xffdbdbdb),
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.public), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
                ],
                selectedItemColor: Color(0xffb0a4fb),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                onTap: (index) {
                  setState(() {
                    currentIndex_ = index;
                    print(currentIndex_);
                  });
                },
              ),
            ),
          ),
        ),
        extendBody: false,
        body: screens[currentIndex_],
      ),
    );
  }
}
