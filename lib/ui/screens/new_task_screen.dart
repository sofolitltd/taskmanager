import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_models.dart';
import 'package:task_manager/ui/widgets/screen_background_widget.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../widgets/dashboard_item_widget.dart';
import '../widgets/task_list_item_widget.dart';

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
    getaAllNewTasks();
  }

  Future getaAllNewTasks() async {
    setState(() => _inProgress = true);
    var result = await NetworkUtils.getMethod(
      url: Urls.newTaskListUrl,
    );

    //
    setState(() => _inProgress = false);
    if (result != null && result['status'] == 'success') {
      taskModel = TaskModel.fromJson(result);
      print(taskModel.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
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
                    numberOfTask: '3', typeOfTask: 'Completed'),
                const DashboardItemWidget(
                    numberOfTask: '8', typeOfTask: 'Canceled'),
                const DashboardItemWidget(
                    numberOfTask: '2', typeOfTask: 'Progress'),
              ],
            ),

            const SizedBox(height: 4),
            //
            Expanded(
              child: _inProgress
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async {
                        getaAllNewTasks();
                      },

                      //todo: video =>30, time=> 1:8
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        // reverse: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: taskModel.data!.length ?? 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        itemBuilder: (context, index) => TaskListItemWidget(
                          title: taskModel.data?[index].title ?? 'unknown',
                          description:
                              taskModel.data?[index].description ?? 'unknown',
                          date: taskModel.data?[index].createdDate ?? 'unknown',
                          type: 'New',
                          color: Colors.blueAccent.shade100,
                          onDeletePress: () {},
                          onEditPress: () {},
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
