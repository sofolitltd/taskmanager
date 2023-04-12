import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../../utils/snack_bar_message.dart';
import 'app_elevated_button_widget.dart';

showChangeTaskStatus({
  required String task,
  required String taskId,
  required VoidCallback onTaskChanged,
}) {
  String currentTask = task;
  bool inProgress = false;

  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    context: TaskManager.navigatorKey.currentContext!,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: StatefulBuilder(builder: (context, changeState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('New'),
                value: 'New',
                groupValue: currentTask,
                onChanged: (state) {
                  currentTask = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                title: const Text('Completed'),
                value: 'Completed',
                groupValue: currentTask,
                onChanged: (state) {
                  currentTask = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                title: const Text('Canceled'),
                value: 'Canceled',
                groupValue: currentTask,
                onChanged: (state) {
                  currentTask = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                title: const Text('Progress'),
                value: 'Progress',
                groupValue: currentTask,
                onChanged: (state) {
                  currentTask = state!;
                  changeState(() {});
                },
              ),

              //
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppElevatedButtonWidget(
                  onPressed: () async {
                    inProgress = true;
                    changeState(() {});
                    //
                    final response = await NetworkUtils.getMethod(
                      url: Urls.changeStatus(taskId, currentTask),
                    );

                    inProgress = false;
                    changeState(() {});
                    //
                    if (response != null) {
                      Navigator.pop(TaskManager.navigatorKey.currentContext!);
                      onTaskChanged();
                    } else {
                      inProgress = false;
                      changeState(() {});
                      showSnackBarMessage(
                          TaskManager.navigatorKey.currentContext!,
                          title: "Status change failed!",
                          error: true);
                    }
                  },
                  child: inProgress
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Change Status'),
                ),
              )
            ],
          );
        }),
      );
    },
  );
}
