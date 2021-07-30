import 'package:ecommerce/widgets/bottom_tabs/bottom_tabs.dart';
import 'package:ecommerce/widgets/tabs/home_tab.dart';
import 'package:ecommerce/widgets/tabs/saved_tab.dart';
import 'package:ecommerce/widgets/tabs/search_tab.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  PageController _tabPageController = PageController();

  List<Map<String, dynamic>> _tabs = [
    {'title': "Home", 'iconImage': "assets/images/tab_home.png", 'index': 0},
    {
      'title': "Search",
      'iconImage': "assets/images/tab_search.png",
      'index': 1
    },
    {'title': "Saved", 'iconImage': "assets/images/tab_saved.png", 'index': 2},
  ];
  int _selectedIndex = 0;

  _toggleThePage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: PageView(
              onPageChanged: (index) {
                _toggleThePage(index);
              },
              controller: _tabPageController,
              children: [HomeTab(), SearchTab(), SavedTab()],
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomTabs(
        selectedTabs: _selectedIndex,
        tabs: _tabs,
        toggle: _toggleThePage,
        pageCtrl: _tabPageController,
      ),
    );
  }
}
