import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';

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
  InProgressTaskScreen(),
];

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileWidget(context),
      //
      body: _screens[_selectedScreen],

      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

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
    return Colors.blueAccent.shade100;
  } else if (index == 1) {
    return Colors.green.shade400;
  } else if (index == 2) {
    return Colors.redAccent.shade200;
  } else {
    return Colors.purple.shade300;
  }
}
