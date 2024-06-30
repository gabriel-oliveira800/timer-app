import 'package:flutter/material.dart';

import '../values/colors.dart';

import 'button.dart';
import 'spacing.dart';

class CreateTasksModalContent extends StatefulWidget {
  final ValueChanged<String> onCreatedTask;

  const CreateTasksModalContent({
    super.key,
    required this.onCreatedTask,
  });

  @override
  State<CreateTasksModalContent> createState() =>
      _CreateTasksModalContentState();
}

class _CreateTasksModalContentState extends State<CreateTasksModalContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _onCreatedTask() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onCreatedTask(_controller.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefa',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacing.vertical(16),
            TextFormField(
              controller: _controller,
              style: const TextStyle(color: AppColors.white),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Campo obrigatório';
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Nome da tarefa',
                hintStyle: TextStyle(color: AppColors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white),
                ),
              ),
            ),
            const Spacing.vertical(16),
            Button(
              text: 'Cria Tarefa',
              onPressed: _onCreatedTask,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _controller.dispose();
    super.dispose();
  }
}
