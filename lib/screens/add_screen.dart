import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';
import 'package:studentprovider/widget/custom_textformfields.dart';
import 'package:studentprovider/widget/tabar.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final registerNoController = TextEditingController();
  final contactController = TextEditingController();
  String? imagesImg;
  // final PickedImageController pickimgController =
  //     Get.put(PickedImageController());
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<;
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
                      child: Consumer<ImageProviderImg>(
                          builder: (context, imageprovider, _) {
                        return imageprovider.imgPath != null
                            ? ClipOval(
                                child: Image.file(
                                File(imageprovider.imgPath!),
                                fit: BoxFit.cover,
                              ))
                            : const Icon(
                                Icons.add_a_photo,
                                size: 60,
                                color: Colors.white,
                              );
                      })),
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Add save functionality here
                        }
                      },
                      child: const Text("SAVE"),
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

  Future<void> pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      Provider.of<ImageProviderImg>(context, listen: false)
          .setImage(pickedFile.path);
    }
  }

  addStudentDetails(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final StudentsModel student = StudentsModel(
        studentName: nameController.text,
        studentAge: ageController.text,
        studentRegNo: registerNoController.text,
        studentContactNo: contactController.text,
        studentPhoto:
            Provider.of<ImageProviderImg>(context, listen: false).imgPath ?? '',
      );
      Provider.of<StudentProvider>(context, listen: false)
          .addStudentadd(student);
      Provider.of<ImageProviderImg>(context, listen: false).setImage(null);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TabBarScreen()));
    }
  }
}

class ImageProviderImg extends ChangeNotifier {
  String? _imgPath;
  String? get imgPath => _imgPath;
  void setImage(String? path) {
    _imgPath = path;
    notifyListeners();
  }
}
