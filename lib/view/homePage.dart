import 'package:flutter/material.dart';
import 'package:music_hunt/utlis/utils.dart';
import 'package:music_hunt/view/tabs/nearby.dart';
import 'package:music_hunt/view/tabs/popular.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff141424),
              automaticallyImplyLeading: false,
              leading: Image.asset("images/logo.png"),
              title: const Text(
                'Music Hunt',
                style: TextStyle(
                    fontSize: 24,
                    color: AppColors.themecolor,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              actions: const [
                Icon(Icons.search,color: Colors.white,),
                SizedBox(width: 15,),
              ],
              bottom: const TabBar(
                labelColor: AppColors.txtcolor,
                indicatorColor: AppColors.txtcolor,
                tabs: [
                  Tab(text: 'Popular'),
                  Tab(text: 'Nearby'),
                  Tab(text: 'Recommended'),
                ],
              ),
            ),
            body:  TabBarView(
              children: [
                Popular(),
                Nearby(),
                Center(child: Text('Tab 3 content')),
              ],
            )));
  }
}
