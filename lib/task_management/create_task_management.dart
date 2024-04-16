import 'package:belajar_sq_flite/model/task_model.dart';
import 'package:belajar_sq_flite/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskManagement extends StatefulWidget {
  final bool? isUpdate;
  final TaskModel? taskModel;
  const CreateTaskManagement({
    super.key,
    this.isUpdate,
    this.taskModel,
  });

  @override
  State<CreateTaskManagement> createState() => _CreateTaskManagementState();
}

class _CreateTaskManagementState extends State<CreateTaskManagement> {
  TextEditingController _controller = TextEditingController();

  String? nameTask;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameTask = widget.taskModel?.taskName;
    _controller = TextEditingController(
      text: nameTask,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.isUpdate == true ? "Edit" : "Create"} Task",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Masukan Kegiatan Hari Ini',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (widget.isUpdate == true) {
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  TaskModel(
                    id: widget.taskModel?.id,
                    taskName: _controller.text,
                  ),
                );
                Navigator.pop(context);
              } else {
                Provider.of<TaskProvider>(context, listen: false).addTask(
                  TaskModel(
                    taskName: _controller.text,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              "${widget.isUpdate == true ? "Edit" : "Create"} Task",
            ),
          )
        ],
      ),
    );
  }
}
