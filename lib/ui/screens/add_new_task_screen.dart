import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';
import 'package:task_manager/utils/color_styles.dart';

import '../../data/auth_utils.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../../utils/snack_bar_message.dart';
import '../../utils/text_styles.dart';
import '../widgets/app_elevated_button_widget.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/user_profile_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectTextEditController =
      TextEditingController();
  final TextEditingController _descriptionTextEditController =
      TextEditingController();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileWidget(context, ColorStyles.kGreenColor),

      //
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                //
                Text(
                  'Add New Task',
                  style: screenTitleTextStyle,
                ),

                const SizedBox(height: 24),

                //
                AppTextFieldWidget(
                  hintText: 'Subject',
                  controller: _subjectTextEditController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter subject';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                //
                AppTextFieldWidget(
                  hintText: 'Description',
                  controller: _descriptionTextEditController,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                //btn
                AppElevatedButtonWidget(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var status = 'New';
                      //
                      setState(() {
                        _inProgress = true;
                      });
                      final result = await NetworkUtils.postMethod(
                          url: Urls.createTaskUrl,
                          token: AuthUtils.token,
                          body: {
                            'title': _subjectTextEditController.text.trim(),
                            'description':
                                _descriptionTextEditController.text.trim(),
                            'status': status,
                          });

                      //

                      // todo: video => live class 30...
                      if (!mounted) return;
                      if (result != null && result['status'] == 'success') {
                        showSnackBarMessage(context, title: 'New task added');
                        print(result);

                        _subjectTextEditController.clear();
                        _descriptionTextEditController.clear();
                        _inProgress = false;
                        setState(() {});
                        // Navigator.pop(context);
                      } else {
                        showSnackBarMessage(context,
                            title: 'New task add failed! Try again',
                            error: true);

                        _inProgress = false;
                        setState(() {});
                      }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
