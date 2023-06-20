import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/presentation/courses/CoursesScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/profile/ProfileScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [
    const CoursesScreen(),
    const ProfileScreen(),
    SettingsScreen()
  ];
  var _selectedPageIndex  = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex  = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedPageIndex != 0) {
          setState(() {
            _selectedPageIndex=0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        body: SafeArea(
          child: IndexedStack(
            index: _selectedPageIndex ,
            children: _pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedPageIndex ,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: SvgPicture.asset(
                  "assets/courses.svg",
                  color:
                  _selectedPageIndex  == 0 ? const Color(0xffE3562A) : const Color(0xffBEBAB3),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 20,
                height: 20,
                margin: const  EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: SvgPicture.asset("assets/profile.svg",
                    color: _selectedPageIndex  == 1
                        ? const Color(0xffE3562A)
                        : const Color(0xffBEBAB3)),
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 20,
                height: 20,
                margin: const  EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: SvgPicture.asset(
                  "assets/settings.svg",
                  color:
                  _selectedPageIndex  == 2 ? const Color(0xffE3562A) : const Color(0xffBEBAB3),
                ),
              ),
              label: 'Settings',
            ),
          ],
          selectedLabelStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xffE3562A)),
          selectedItemColor: const Color(0xffE3562A),
          unselectedLabelStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xffBEBAB3)),
        ),
      ),
    );
  }
}
