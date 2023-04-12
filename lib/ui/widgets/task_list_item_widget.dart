import 'package:flutter/material.dart';

class TaskListItemWidget extends StatelessWidget {
  const TaskListItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.color,
    required this.onEditPress,
    required this.onDeletePress,
  }) : super(key: key);

  final String title;
  final String description;
  final String date;
  final String type;
  final Color color;
  final VoidCallback onEditPress, onDeletePress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 2),

            //
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 8),

            //
            Text(
              'Date: $date',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: Colors.white,
                      // fontSize: 12,
                    ),
                  ),
                ),

                const Spacer(),

                //
                IconButton(
                  visualDensity: const VisualDensity(horizontal: -4),
                  onPressed: onEditPress,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(width: 8),

                //
                IconButton(
                  visualDensity: const VisualDensity(horizontal: -4),
                  onPressed: onDeletePress,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
