import 'package:flutter/material.dart';

import '../screens/task_timer_controller.dart';
import 'button.dart';
import 'rounded_button.dart';
import 'spacing.dart';

class FooterButtons extends StatelessWidget {
  final TaskTimerController controller;

  const FooterButtons({
    super.key,
    required this.controller,
  });

  void _onStop(BuildContext context) {
    controller.onStop().then((_) {
      Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = controller.isLoading;

    if (controller.finished) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Button(
          text: 'Retornar',
          isLoading: isLoading,
          onPressed: () => _onStop(context),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Button(
              text: 'Parar',
              isLoading: isLoading,
              padding: EdgeInsets.zero,
              onPressed: () => _onStop(context),
            ),
          ),
          const Spacing.horizontal(24),
          Expanded(
            child: RoundedButton(
              selected: true,
              size: const Size.fromHeight(54.0),
              onPressed: isLoading ? null : controller.onPause,
              text: controller.lastProgressAfterPause != null
                  ? 'Retomar'
                  : 'Pausar',
            ),
          ),
        ],
      ),
    );
  }
}
