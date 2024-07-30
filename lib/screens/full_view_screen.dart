import 'package:flutter/material.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';

class FullViewScreen extends StatelessWidget {
  final StudentsModel student;

  const FullViewScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      radius: 50,
                      backgroundImage: student.studentPhoto != null
                          ? NetworkImage(student.studentPhoto!)
                          : null,
                      child: student.studentPhoto == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: iconsColor,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Student Name: ${student.studentName!}',
                    style: const TextStyle(
                      color: iconsColor,
                      fontWeight: studentfont,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Age: ${student.studentAge}',
                    style: const TextStyle(
                      color: iconsColor,
                      fontWeight: studentfont,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Register Number: ${student.studentRegNo!}',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
