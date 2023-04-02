import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button_widget.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/snack_bar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

import '../widgets/app_button_row_widget.dart';
import '../widgets/app_text_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailTextEditController = TextEditingController();

  final TextEditingController firstNameTextEditController =
      TextEditingController();

  final TextEditingController lastNameTextEditController =
      TextEditingController();

  final TextEditingController mobileTextEditController =
      TextEditingController();

  final TextEditingController passwordTextEditController =
      TextEditingController();

  final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .2),

                    //
                    Text(
                      'Join With Us',
                      style: screenTitleTextStyle,
                    ),

                    const SizedBox(height: 24),

                    //
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

                    //
                    AppTextFieldWidget(
                      hintText: 'First name',
                      controller: firstNameTextEditController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    //
                    AppTextFieldWidget(
                      hintText: 'Last name',
                      controller: lastNameTextEditController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    //
                    AppTextFieldWidget(
                      hintText: 'Mobile',
                      controller: mobileTextEditController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your mobile no';
                        } else if (value.length < 11) {
                          return 'Enter valid mobile no';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    //
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          //
                          final result = await NetworkUtils.postMethod(
                            url: Urls.registrationUrl,
                            body: {
                              "email": emailTextEditController.text.trim(),
                              "firstName":
                                  firstNameTextEditController.text.trim(),
                              "lastName":
                                  lastNameTextEditController.text.trim(),
                              "mobile": mobileTextEditController.text.trim(),
                              "password": passwordTextEditController.text,
                              "photo": ""
                            },
                          );

                          print(result);
                          if (result != null && result['status'] == 'success') {
                            //
                            showSnackBarMessage(context,
                                title: 'Registration successfully');

                            //clean field
                            emailTextEditController.clear();
                            firstNameTextEditController.clear();
                            lastNameTextEditController.clear();
                            mobileTextEditController.clear();
                            passwordTextEditController.clear();

                            //
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            showSnackBarMessage(
                              context,
                              title: 'Registration failed',
                              error: true,
                            );

                            //
                            setState(() {
                              _isLoading = true;
                            });
                          }
                        }
                      },
                      child: _isLoading
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
                    AppButtonRowWidget(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      titleText: 'Have account?',
                      buttonText: 'Sign In',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
