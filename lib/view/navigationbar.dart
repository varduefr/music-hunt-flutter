import 'package:flutter/material.dart';
import 'package:music_hunt/utlis/utils.dart';
import 'package:music_hunt/view/setting_page.dart';

import 'homePage.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 38,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class MaterialYou extends StatefulWidget {
  const MaterialYou({Key? key}) : super(key: key);

  @override
  State<MaterialYou> createState() => _MaterialYouState();
}

class _MaterialYouState extends State<MaterialYou> {
  int _currentIndex = 0;
 // List<DataModel> dataList = []; // Your data initialization here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.black,
          backgroundColor: AppColors.blackcolor,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: Color(0xfff0ea36)),
              icon: Icon(Icons.home_outlined,color: Color(0xffa8aaad),),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.category, color:Color(0xfff0ea36)),
              icon: Icon(Icons.category,color:Color(0xffa8aaad),),
              label: 'Categories',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark, color:Color(0xfff0ea36)),
              icon: Icon(Icons.bookmark_add,color: Color(0xffa8aaad),),
              label: 'Bookmark',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: Color(0xfff0ea36)),
              icon: Icon(Icons.person,color:Color(0xffa8aaad),size: 30,),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get pages => [
    MyHomePage(),
    Text(""),
    Text(""),
    Seeting_Page()

  ];
}
