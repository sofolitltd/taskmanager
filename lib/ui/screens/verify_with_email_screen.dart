import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/otp_verification_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button_widget.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

import '../widgets/app_button_row_widget.dart';
import '../widgets/app_text_field_widget.dart';

class VerifyWithEmailScreen extends StatelessWidget {
  const VerifyWithEmailScreen({Key? key}) : super(key: key);

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
                'Your Email address',
                style: screenTitleTextStyle,
              ),

              const SizedBox(height: 4),

              //
              Text(
                'A 6 digit verification pin will send to your email address',
                style: screenSubtitleTextStyle,
              ),

              const SizedBox(height: 16),

              // email
              AppTextFieldWidget(
                hintText: 'Email',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 24),

              //btn
              AppElevatedButtonWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpVerificationScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_circle_right_outlined),
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
