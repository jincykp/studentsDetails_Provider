import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';
import 'package:studentprovider/widget/custom_textformfields.dart';

class EditScreen extends StatelessWidget {
  final StudentsModel studentt;

  EditScreen({super.key, required this.studentt});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final imageprovider = Provider.of<EditingImageprovider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (imageprovider.imagePath != studentt.studentPhoto) {
        imageprovider.initializeImagePath(studentt.studentPhoto ?? '');
      }
    });
    final nameController = TextEditingController(text: studentt.studentName);
    final ageController = TextEditingController(text: studentt.studentAge);
    final registerNoController =
        TextEditingController(text: studentt.studentRegNo);
    final contactController =
        TextEditingController(text: studentt.studentContactNo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecode,
        foregroundColor: iconsColor,
        title: const Text(
          "Add Student Details",
          style: TextStyle(fontWeight: fonntsStyless),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await pickImage(context);
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: Consumer<EditingImageprovider>(
                        builder: (context, imageprovider, _) {
                      return imageprovider.imagePath != null
                          ? ClipOval(
                              child: Image.file(
                              File(imageprovider.imagePath!),
                              fit: BoxFit.cover,
                            ))
                          : const Icon(
                              Icons.add_a_photo_outlined,
                              size: 60,
                              color: Colors.white,
                            );
                    }),
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  controller: nameController,
                  hintText: "Enter Your name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  hintText: "Enter Your age",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  keyboardType: TextInputType.number,
                  controller: registerNoController,
                  hintText: "Enter Your RegisterNumber",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'RegisterNumber is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  keyboardType: TextInputType.phone,
                  controller: contactController,
                  hintText: "Enter Your Contact Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(themecode),
                      ),
                      onPressed: () {
                        editStudent(
                            context,
                            nameController.text.trim(),
                            ageController.text.trim(),
                            registerNoController.text.trim(),
                            contactController.text.trim());
                      },
                      child: const Text(
                        "UPDATE",
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
    );
  }

  void editStudent(BuildContext context, String name, String age, String regno,
      String contactno) async {
    if (formKey.currentState!.validate()) {
      studentt.studentName = name;
      studentt.studentAge = age;
      studentt.studentRegNo = regno;
      studentt.studentContactNo = contactno;
      studentt.studentPhoto =
          Provider.of<EditingImageprovider>(context, listen: false).imagePath;
      Provider.of<StudentProvider>(context, listen: false)
          .updateDetails(studentt);
      Navigator.of(context).pop();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<EditingImageprovider>(context, listen: false)
          .setImagePath(pickedFile.path);
    }
  }
}

class EditingImageprovider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  void initializeImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}
