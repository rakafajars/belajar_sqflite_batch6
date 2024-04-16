import 'package:belajar_sq_flite/database_helper.dart';
import 'package:belajar_sq_flite/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _listTask = [];
  List<TaskModel> get listTask => _listTask;

  late DatabaseHelper _databaseHelper;

  TaskProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllTask();
  }

  void _getAllTask() async {
    _listTask = await _databaseHelper.getTask();
    notifyListeners();
  }

  Future<TaskModel> getTaskModelById(int id) async {
    return await _databaseHelper.getTaskById(id);
  }

  Future<void> addTask(TaskModel taskModel) async {
    await _databaseHelper.insertTask(taskModel);
    _getAllTask();
  }

  void updateTask(TaskModel taskModel) async {
    await _databaseHelper.updateTask(taskModel);
    _getAllTask();
  }

  void deleteTask(int id) async {
    await _databaseHelper.deleteTask(id);
    _getAllTask();
  }
}
