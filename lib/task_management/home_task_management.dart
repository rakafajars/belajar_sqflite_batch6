import 'dart:io';

import 'package:belajar_sq_flite/gallery_image_picker_constant.dart';
import 'package:belajar_sq_flite/model/task_model.dart';
import 'package:belajar_sq_flite/task_management/create_task_management.dart';
import 'package:belajar_sq_flite/task_management/empty_task_management.dart';
import 'package:belajar_sq_flite/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeTaskManagement extends StatefulWidget {
  const HomeTaskManagement({super.key});

  @override
  State<HomeTaskManagement> createState() => _HomeTaskManagementState();
}

class _HomeTaskManagementState extends State<HomeTaskManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Management',
        ),
        centerTitle: true,
      ),
      body: buildScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTaskManagement(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildScreen() {
    return Consumer<TaskProvider>(
      builder: (context, TaskProvider taskProvider, child) {
        if (taskProvider.listTask.isNotEmpty) {
          return ListView.builder(
            itemCount: taskProvider.listTask.length,
            itemBuilder: (context, int index) {
              return Container(
                color: Colors.amber,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateTaskManagement(
                          isUpdate: true,
                          taskModel: taskProvider.listTask[index],
                        ),
                      ),
                    );
                  },
                  title: Text(
                    taskProvider.listTask[index].taskName,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Apakah Kamu ingin menghapus task ini?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Tidak',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  taskProvider.deleteTask(
                                    taskProvider.listTask[index].id ?? 0,
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Iya',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const EmptyTaskManagement();
        }
      },
    );
  }
}
