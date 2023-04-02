import 'package:flutter/material.dart';

class DashboardItemWidget extends StatelessWidget {
  const DashboardItemWidget({
    Key? key,
    required this.numberOfTask,
    required this.typeOfTask,
  }) : super(key: key);

  final String numberOfTask;
  final String typeOfTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                numberOfTask,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              //
              FittedBox(
                child: Text(
                  typeOfTask,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
