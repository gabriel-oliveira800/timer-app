import 'package:flutter/material.dart';

import '../values/colors.dart';

class TaskTimerScreen extends StatefulWidget {
  const TaskTimerScreen({Key? key}) : super(key: key);

  @override
  State<TaskTimerScreen> createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends State<TaskTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        leading: const BackButton(color: AppColors.white),
      ),
      body: Container(),
    );
  }
}
