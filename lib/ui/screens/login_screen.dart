import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/screens/verify_with_email_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button_widget.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/text_styles.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../../utils/snack_bar_message.dart';
import '../widgets/app_button_row_widget.dart';
import '../widgets/app_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailTextEditController = TextEditingController();

  final TextEditingController passwordTextEditController =
      TextEditingController();

  final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  'Get Started With',
                  style: screenTitleTextStyle,
                ),

                const SizedBox(height: 24),

                // email
                AppTextFieldWidget(
                  hintText: 'Email',
                  controller: emailTextEditController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // password
                AppTextFieldWidget(
                  hintText: 'Password',
                  controller: passwordTextEditController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    } else if (value.length < 6) {
                      return 'Enter password more than 6 characters';
                    }
                    return null;
                  },
                  obscureText: true,
                ),

                const SizedBox(height: 24),

                //btn
                AppElevatedButtonWidget(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: _inProgress
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.arrow_circle_right_outlined),
                ),

                const SizedBox(height: 24),

                //
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyWithEmailScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                //
                AppButtonRowWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  titleText: 'Don\'t have an account?',
                  buttonText: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
  Future login() async {
    setState(() {
      _inProgress = true;
    });
    //
    final result = await NetworkUtils.postMethod(
      url: Urls.loginUrl,
      body: {
        "email": emailTextEditController.text.trim(),
        "password": passwordTextEditController.text,
      },
      onUnAuthorized: () {
        showSnackBarMessage(context,
            title: 'User name or password incorrect', error: true);
      },
    );
    setState(() {
      _inProgress = false;
    });
    print(result);
    if (result != null && result['status'] == 'success') {
      //save
      AuthUtils.saveUserData(
        result['token'],
        result['data']['firstName'],
        result['data']['lastName'],
        result['data']['email'],
        result['data']['mobile'],
        result['data']['photo'],
      );

      if (!mounted) return;
      //
      // showSnackBarMessage(context, title: 'Login successful');

      //clean field
      emailTextEditController.clear();
      passwordTextEditController.clear();

      //
      setState(() {
        _inProgress = false;
      });

      //
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavBar()),
          (route) => false);
    } else {
      if (!mounted) return;

      showSnackBarMessage(
        context,
        title: 'Login failed',
        error: true,
      );

      //
      setState(() {
        _inProgress = false;
      });
    }
  }
}
