import 'package:flutter/material.dart';

import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item_widget.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: 10,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          itemBuilder: (context, index) => TaskListItemWidget(
            title: 'Title of the topic',
            description: 'description of the item ',
            date: '28-12-2022',
            type: 'Completed',
            color: Colors.green.shade400,
            onDeletePress: () {},
            onEditPress: () {},
          ),
        ),
      ),
    );
  }
}
