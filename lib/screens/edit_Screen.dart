import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    // Initialize the image path from the student's model
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
          "Edit Student Details",
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
                        final image = imageprovider.imagePath != null
                            ? FileImage(File(imageprovider.imagePath!))
                            : const AssetImage('assets/images.jpeg')
                                as ImageProvider;
                        return ClipOval(
                          child: Image(
                            image: image,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  controller: nameController,
                  hintText: "Enter Your name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Name can only contain letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2)
                  ],
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  hintText: "Enter Your age",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is required';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 99) {
                      return 'Age must be between 1 and 99';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  keyboardType: TextInputType.number,
                  controller: registerNoController,
                  hintText: "Enter Your Register Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Register Number is required';
                    } else if (value.length != 6) {
                      return 'Register Number must be 6 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormFields(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  keyboardType: TextInputType.phone,
                  controller: contactController,
                  hintText: "Enter Your Contact Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number is required';
                    } else if (value.length != 10) {
                      return 'Contact number must be 10 digits';
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
