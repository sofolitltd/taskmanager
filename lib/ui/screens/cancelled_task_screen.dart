import 'package:flutter/material.dart';
import 'package:task_manager/utils/color_styles.dart';

import '../../data/models/task_models.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/status_change_bottom_widget.dart';
import '../widgets/task_list_item_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskModel taskModel = TaskModel();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getaAllTasks(url: Urls.canceledTaskUrl);
  }

  Future getaAllTasks({required String url}) async {
    setState(() => _inProgress = true);
    var result = await NetworkUtils.getMethod(url: url);

    //
    setState(() => _inProgress = false);
    if (result != null && result['status'] == 'success') {
      taskModel = TaskModel.fromJson(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
        child: _inProgress
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  getaAllTasks(url: Urls.canceledTaskUrl);
                },
                child: taskModel.data!.isEmpty
                    ? const Center(child: Text('No task found'))
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        // reverse: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: taskModel.data?.length ?? 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        itemBuilder: (context, index) {
                          return TaskListItemWidget(
                            title: taskModel.data?[index].title ?? 'unknown',
                            description:
                                taskModel.data?[index].description ?? 'unknown',
                            date:
                                taskModel.data?[index].createdDate ?? 'unknown',
                            type: 'Canceled',
                            color: ColorStyles.kRedColor,
                            onDeletePress: () {
                              NetworkUtils.deleteTask(
                                  taskModel.data?[index].sId ?? '');
                              getaAllTasks(url: Urls.canceledTaskUrl);
                            },
                            onEditPress: () {
                              showChangeTaskStatus(
                                task: 'Canceled',
                                taskId: taskModel.data?[index].sId ?? '',
                                onTaskChanged: () {
                                  getaAllTasks(url: Urls.canceledTaskUrl);
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
