import 'package:flutter/material.dart';
import 'package:timer_app/src/screens/home_controller.dart';

import '../components/custom_curpertino_picker.dart';
import '../components/grid_tasks.dart';
import '../components/spacing.dart';
import '../components/button.dart';
import '../models/task_time_state.dart';
import '../values/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeController _controller;
  @override
  void initState() {
    super.initState();
    _controller = HomeController()..onInit(_onSaveStateAndNavigate);
  }

  void navigateTo(TaskTimeState data) {
    Navigator.of(context).pushNamed('/task-time', arguments: data);
  }

  void _onSaveStateAndNavigate([TaskTimeState? data]) async {
    if (data != null) return navigateTo(data);

    final result = await _controller.onTaskTimeState();
    navigateTo(result);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Scaffold(
        bottomNavigationBar: _initButton(),
        backgroundColor: AppColors.secondary,
        body: SafeArea(child: Center(child: _body())),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Spacing.vertical(88),
          CustomCupertinoTimerPicker(
            backgroundColor: AppColors.secondary,
            initialTimerDuration: _controller.selectedDuration,
            onTimerDurationChanged: _controller.onSelectedDuration,
          ),
          const Spacing.vertical(48),
          GridTasks(
            tasks: _controller.tasks,
            onDelete: _controller.onDeletedTask,
            selectedTask: _controller.selectedTask,
            onCreatedTask: _controller.onAddNewTask,
            onSelectedTask: _controller.onSelectedTask,
          ),
        ],
      ),
    );
  }

  Widget _initButton() {
    final isEnable = _controller.isEnableStartButton();

    return Button(
      isLoading: _controller.isLoading,
      onPressed: isEnable ? _onSaveStateAndNavigate : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
