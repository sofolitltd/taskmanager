import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

AppBar userProfileWidget(context) {
  return AppBar(
    backgroundColor: Colors.green,
    titleSpacing: 0,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      leading: const CircleAvatar(),
      title: Text(
        '${AuthUtils.firstName} ${AuthUtils.lastName}' ?? 'user',
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        AuthUtils.email ?? 'unknown',
        style: const TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthUtils.clearData();

          //
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
        icon: const Icon(
          Icons.exit_to_app_outlined,
          color: Colors.white,
        ),
      ),
    ),
  );
}
