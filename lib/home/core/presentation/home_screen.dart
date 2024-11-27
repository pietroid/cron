import 'package:cron/core/view/creation_bottom_sheet.dart';
import 'package:cron/home/sections/current_tasks/presentation/current_tasks_section.dart';
import 'package:cron/home/sections/next_tasks/presentation/next_tasks_section.dart';
import 'package:cron/home/sections/todo_list/presentation/todo_list_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final creationBottomSheet = context.read<CreationBottomSheet>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: const [
              CurrentTasksSection(),
              NextTasksSection(),
              TodoListSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00ACBB),
        onPressed: () {
          creationBottomSheet.show(context);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
