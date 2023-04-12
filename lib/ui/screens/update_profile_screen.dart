import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/color_styles.dart';

import '../../utils/text_styles.dart';
import '../widgets/app_elevated_button_widget.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/user_profile_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileWidget(context, ColorStyles.kGreenColor),

      //
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              //
              Text(
                'Update Profile',
                style: screenTitleTextStyle,
              ),

              const SizedBox(height: 24),

              //
              Row(
                children: [
                  //
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: const Text('Photo'),
                  ),

                  //
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(''),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Email',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'First name',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Last name',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Mobile',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 16),

              //
              AppTextFieldWidget(
                hintText: 'Password',
                controller: TextEditingController(),
              ),

              const SizedBox(height: 24),

              //btn
              AppElevatedButtonWidget(
                onPressed: () {},
                child: const Icon(Icons.arrow_circle_right_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
