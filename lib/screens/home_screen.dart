import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/edit_Screen.dart';
import 'package:studentprovider/screens/full_view_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final StudentsModel student = studentProvider.student[index];
                return Card(
                  color: listTilecolor,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullViewScreen(
                                    student: student,
                                  )));
                    },
                    child: ListTile(
                      title: Text(student.studentName!),
                      subtitle: Text(student.studentRegNo!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditScreen(studentt: student)));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDeleteDialog(
                                    context, studentProvider, student);
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: studentProvider.student.length,
            ),
          )
        ],
      ),
    );
  }

  void showDeleteDialog(BuildContext context, StudentProvider studentProvider,
      StudentsModel student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  studentProvider.deleteDetails(student);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'))
          ],
        );
      },
    );
  }
}
