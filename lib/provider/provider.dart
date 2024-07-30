import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studentprovider/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final Box<StudentsModel> studentbox = Hive.box<StudentsModel>('student');
  List<StudentsModel> get student => studentbox.values.toList();
  void addStudentadd(StudentsModel student) {
    studentbox.add(student);
    notifyListeners();
  }
}
