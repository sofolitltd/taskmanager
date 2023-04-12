import 'package:flutter/material.dart';

import '/ui/screens/cancelled_task_screen.dart';
import '/ui/screens/completed_task_screen.dart';
import '/ui/screens/progress_task_screen.dart';
import '/utils/color_styles.dart';
import '../widgets/user_profile_widget.dart';
import 'new_task_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

List _screens = const [
  NewTaskScreen(),
  CompletedTaskScreen(),
  CancelledTaskScreen(),
  ProgressTaskScreen(),
];

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileWidget(
        context,
        selectedItemColor(_selectedScreen),
      ),
      //
      body: _screens[_selectedScreen],

      //
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectedItemColor(_selectedScreen),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        iconSize: 28,
        selectedFontSize: 12,
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
        elevation: 4,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_presentation_outlined),
              label: 'Canceled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity_outlined), label: 'Progress'),
        ],
      ),
    );
  }
}

// selected item color
selectedItemColor(index) {
  if (index == 0) {
    return ColorStyles.kBlueColor;
  } else if (index == 1) {
    return ColorStyles.kGreenColor;
  } else if (index == 2) {
    return ColorStyles.kRedColor;
  } else {
    return ColorStyles.kPurpleColor;
  }
}
