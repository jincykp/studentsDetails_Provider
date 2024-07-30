import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studentprovider/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final Box<StudentsModel> studentbox = Hive.box<StudentsModel>('students');
  List<StudentsModel> get student => studentbox.values.toList();
  void addStudentadd(StudentsModel student) {
    studentbox.add(student);
    print('students data added :${student.studentName}');
    notifyListeners();
  }

  void updateDetails(StudentsModel student) {
    int index = studentbox.values.toList().indexOf(student);

    studentbox.putAt(index, student);
    notifyListeners();
  }

  void deleteDetails(StudentsModel student) {
    int index = studentbox.values.toList().indexOf(student);
    studentbox.deleteAt(index);
    notifyListeners();
  }
}
