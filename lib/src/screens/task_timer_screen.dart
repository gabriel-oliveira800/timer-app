import 'package:flutter/material.dart';
import 'package:timer_app/src/values/extensions.dart';

import '../components/footer_buttons.dart';
import '../components/spacing.dart';
import '../models/task_time_state.dart';
import '../values/colors.dart';
import 'task_timer_controller.dart';

class TaskTimerScreen extends StatefulWidget {
  const TaskTimerScreen({Key? key}) : super(key: key);

  @override
  State<TaskTimerScreen> createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends State<TaskTimerScreen> {
  late final TaskTimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TaskTimerController();
    Future.delayed(Duration.zero, _handlerArgs);
  }

  Future<void> _handlerArgs() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    _controller.onInit(args as TaskTimeState);
  }

  void _onBack() {
    _controller.onStop().then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          leading: BackButton(color: AppColors.white, onPressed: _onBack),
        ),
        bottomNavigationBar: FooterButtons(controller: _controller),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 12,
            strokeAlign: 18,
            strokeCap: StrokeCap.round,
            value: _controller.getProgress(),
            color: AppColors.progressColor,
            backgroundColor: AppColors.progressBgColor,
          ),
        ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _controller.progress.formatted(),
                style: const TextStyle(
                  fontSize: 36,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacing.vertical(8),
              Text(
                _controller.getTask(),
                style: const TextStyle(fontSize: 16, color: AppColors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
