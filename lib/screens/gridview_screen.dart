import 'dart:io'; // Import the dart:io package for File
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/full_view_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      body: studentProvider.student.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: studentProvider.student.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                final StudentsModel student = studentProvider.student[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullViewScreen(student: student),
                      ),
                    );
                  },
                  child: Card(
                    color: themecode,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: student.studentPhoto != null &&
                                  student.studentPhoto!.isNotEmpty
                              ? FileImage(File(student.studentPhoto!))
                              : null,
                          radius: 40,
                          child: student.studentPhoto == null ||
                                  student.studentPhoto!.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(255, 82, 81, 81),
                                )
                              : null,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          student.studentName ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Age: ${student.studentAge ?? 'N/A'}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
