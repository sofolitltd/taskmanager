import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button_widget.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

import '../widgets/app_button_row_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
                'Pin Verification',
                style: screenTitleTextStyle,
              ),

              const SizedBox(height: 4),

              //
              Text(
                'A 6 digit verification pin will send to your email address',
                style: screenSubtitleTextStyle,
              ),

              const SizedBox(height: 16),

              // otp
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(4),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Colors.white,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.green,
                  selectedFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                // errorAnimationController: TextEditingController(),
                // controller: TextEditingController(),
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    // currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),

              const SizedBox(height: 24),

              //btn
              AppElevatedButtonWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
                child: const Text('Verify'),
              ),

              const SizedBox(height: 24),

              //
              AppButtonRowWidget(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
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
