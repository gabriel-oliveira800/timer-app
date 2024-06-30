import 'package:flutter/material.dart';
import 'package:timer_app/src/screens/home.dart';

import 'src/screens/task_timer_screen.dart';
import 'src/values/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      routes: {
        '/': (_) => const Home(),
        '/task-time': (_) => const TaskTimerScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Zona Pro',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
      ),
    );
  }
}
