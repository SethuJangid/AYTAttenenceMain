import 'package:AYT_Attendence/Screens/Expenses/track_expenses.dart';
import 'package:AYT_Attendence/Screens/leavelists/track_leave.dart';
import 'package:AYT_Attendence/Screens/notification/NotificationScreen.dart';
import 'package:AYT_Attendence/pages/homepage.dart';
import 'package:AYT_Attendence/pages/myaccountspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';



class BottomNavBar extends StatefulWidget {
  final titles = ['Dashboard', 'Expenses', 'Track Leave', 'Profile',];
  final colors = [Colors.orange, Colors.orange, Colors.orange, Colors.orange, ];
  final icons = [
    Icons.home,
    Icons.explicit,
    Icons.article,
    Icons.person,
    Icons.notifications
  ];
  final classes=[
    HomePage(),
    MyTrackExpenses(),
    MyTrackLeave(),
    ProfileScreen(),
  ];

  BottomNavBar({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavBar> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController = PageController(
        initialPage: 0,
        keepPage: false,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification && scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[1000],
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            controller: _pageController,
            ///children: widget.colors.map((Color c) => Container(color: c)).toList(),
            children: widget.classes.map((Widget widget) => Container(child: widget,)).toList(),
            onPageChanged: (page) {
            },
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.blue[1000],
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 50)
            );
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, Colors.white),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        )
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
