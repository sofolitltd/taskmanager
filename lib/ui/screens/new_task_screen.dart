import 'package:flutter/material.dart';

import '/data/models/task_models.dart';
import '/ui/widgets/screen_background_widget.dart';
import '/utils/color_styles.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../widgets/dashboard_item_widget.dart';
import '../widgets/status_change_bottom_widget.dart';
import '../widgets/task_list_item_widget.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskModel taskModel = TaskModel();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getaAllTasks(url: Urls.newTaskUrl);
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
    return Scaffold(
      //
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorStyles.kBlueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      //
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              //
              Row(
                children: [
                  DashboardItemWidget(
                      numberOfTask: taskModel.data?.length.toString() ?? '0',
                      typeOfTask: 'New'),
                  const DashboardItemWidget(
                      numberOfTask: '0', typeOfTask: 'Completed'),
                  const DashboardItemWidget(
                      numberOfTask: '0', typeOfTask: 'Canceled'),
                  const DashboardItemWidget(
                      numberOfTask: '0', typeOfTask: 'Progress'),
                ],
              ),

              const SizedBox(height: 4),
              //
              Expanded(
                child: _inProgress
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () async {
                          getaAllTasks(url: Urls.newTaskUrl);
                        },

                        //
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
                                itemBuilder: (context, index) =>
                                    TaskListItemWidget(
                                  title:
                                      taskModel.data?[index].title ?? 'unknown',
                                  description:
                                      taskModel.data?[index].description ??
                                          'unknown',
                                  date: taskModel.data?[index].createdDate ??
                                      'unknown',
                                  type: 'New',
                                  color: ColorStyles.kBlueColor,
                                  onDeletePress: () {
                                    NetworkUtils.deleteTask(
                                        taskModel.data?[index].sId ?? '');
                                    getaAllTasks(url: Urls.newTaskUrl);
                                  },
                                  onEditPress: () {
                                    showChangeTaskStatus(
                                      task: 'New',
                                      taskId: taskModel.data?[index].sId ?? '',
                                      onTaskChanged: () {
                                        getaAllTasks(url: Urls.newTaskUrl);
                                      },
                                    );
                                  },
                                ),
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
