import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  BottomTabs(
      {required this.selectedTabs,
      required this.tabs,
      required this.toggle,
      required this.pageCtrl,
      Key? key})
      : super(key: key);
  final int selectedTabs;
  final List<Map<String, dynamic>> tabs;
  final Function(int) toggle;
  final PageController pageCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...tabs.map((Map<String, dynamic> tabsItem) {
            return BottomTabsBtn(
              imagePath: tabsItem['iconImage'],
              checkActive: selectedTabs == tabsItem['index'],
              toggle: toggle,
              currentIndex: tabsItem['index'],
              pageCtrl: pageCtrl,
            );
          }).toList(),
          BottomTabsBtn(
            imagePath: "assets/images/tab_logout.png",
            checkActive: false,
            toggle: toggle,
          )
        ],
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String imagePath;
  final bool checkActive;
  final Function(int) toggle;
  final int? currentIndex;
  final PageController? pageCtrl;
  const BottomTabsBtn(
      {required this.imagePath,
      required this.checkActive,
      required this.toggle,
      this.currentIndex,
      this.pageCtrl,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (currentIndex == null) {
          await FirebaseAuth.instance.signOut();
          return;
        }
        pageCtrl!.jumpToPage(currentIndex!);
        toggle(currentIndex!);
      },
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 28.0,
            horizontal: 24.0,
          ),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: checkActive == true
                ? Theme.of(context).accentColor
                : Colors.transparent,
            width: 2.0,
          ))),
          child: Image(
            image: AssetImage(imagePath),
            width: 22.0,
            height: 22.0,
            color: checkActive == true
                ? Theme.of(context).accentColor
                : Colors.black,
          )),
    );
  }
}
