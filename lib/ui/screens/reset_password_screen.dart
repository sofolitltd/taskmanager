import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button_widget.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

import '../widgets/app_button_row_widget.dart';
import '../widgets/app_text_field_widget.dart';
import 'main_bottom_nav_bar.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                'Set Password',
                style: screenTitleTextStyle,
              ),

              const SizedBox(height: 4),

              //
              Text(
                'Minimum length password 8 character with letter and number combination',
                style: screenSubtitleTextStyle,
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Password',
                controller: TextEditingController(),
                obscureText: true,
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Confirm Password',
                controller: TextEditingController(),
                obscureText: true,
              ),

              const SizedBox(height: 24),

              //btn
              AppElevatedButtonWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainBottomNavBar(),
                    ),
                  );
                },
                child: const Text('Confirm'),
              ),

              const SizedBox(height: 24),

              //
              AppButtonRowWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                titleText: 'Have account?',
                buttonText: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
