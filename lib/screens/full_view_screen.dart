import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/edit_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';

class FullViewScreen extends StatelessWidget {
  final StudentsModel student;

  FullViewScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = const AssetImage('assets/images.jpeg');

    if (student.studentPhoto != null && student.studentPhoto!.isNotEmpty) {
      final file = File(student.studentPhoto!);
      if (file.existsSync()) {
        imageProvider = FileImage(file);
      } else {
        print('File does not exist: ${student.studentPhoto}');
      }
    }

    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecode,
        foregroundColor: iconsColor,
        title: const Center(
          child: Text(
            "Student Details",
            style: TextStyle(fontWeight: studentfont),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: listTilecolor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Student Name : ${student.studentName!}',
                      style: const TextStyle(
                        color: iconsColor,
                        fontWeight: studentfont,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Age : ${student.studentAge}',
                      style: const TextStyle(
                        color: iconsColor,
                        fontWeight: studentfont,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Register Number : ${student.studentRegNo!}',
                      style: const TextStyle(
                        color: iconsColor,
                        fontWeight: studentfont,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Contact Number : ${student.studentContactNo!}',
                      style: const TextStyle(
                        color: iconsColor,
                        fontWeight: studentfont,
                      ),
                    ),
                    const SizedBox(height: 90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditScreen(studentt: student),
                              ),
                            );
                          },
                          child: const Text(
                            "EDIT",
                            style: TextStyle(color: iconsColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDeleteDialog(context, studentProvider, student);
                          },
                          child: const Text(
                            "DELETE",
                            style: TextStyle(color: iconsColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                  Navigator.of(context).pop();
                },
                child: const Text('Delete')),
          ],
        );
      },
    );
  }
}
