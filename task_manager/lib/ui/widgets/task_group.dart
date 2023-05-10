import 'package:flutter/material.dart';
import 'package:task_manager/ui/core/res/color.dart';

class TaskGroupContainer extends StatelessWidget {
  final MaterialColor color;
  final bool? isSmall;
  final IconData icon;
  final String taskGroup;
  final num taskCount;
  const TaskGroupContainer({
    Key? key,
    required this.color,
    this.isSmall = false,
    required this.icon,
    required this.taskGroup,
    required this.taskCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[400],
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 4,
            offset: const Offset(2, 6),
          )
        ],
        gradient: AppColors.getDarkLinearGradient(color),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          Align(
            alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
            child: Icon(
              icon,
              size: isSmall! ? 60 : 80,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            taskGroup,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "$taskCount Task",
            style: TextStyle(
              color: Colors.white.withOpacity(1),
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
