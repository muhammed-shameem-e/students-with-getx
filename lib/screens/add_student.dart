import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_with_getx/model/getx_class.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_with_getx/model/student_model.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final ImageController imageController = Get.put(ImageController());

    Future<void> getImage() async {
      final ImagePicker image = ImagePicker();
      final XFile? pick = await image.pickImage(source: ImageSource.gallery);
      if (pick != null) {
        imageController.updateImage(pick.path); // Update image in ImageController
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () => getImage(),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 197, 197, 197),
                        image: imageController.imagePath.value != null
                            ? DecorationImage(
                                image: FileImage(
                                  File(imageController.imagePath.value!),
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imageController.imagePath.value == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  keyboardType: ,
                  decoration: InputDecoration(
                      labelText: 'Age',
                      prefixIcon: const Icon(Icons.cake),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your age';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: placeController,
                  decoration: InputDecoration(
                      labelText: 'Place',
                      prefixIcon: const Icon(Icons.place),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your place';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final students = Details(
                        id: DateTime.now().millisecond,
                        name: nameController.text,
                        age: ageController.text,
                        place: placeController.text,
                        image: imageController.imagePath.value ??
                            '', // default to empty string if null
                      );
                      final studentController = Get.find<StudentController>();
                      await studentController.addStudent(students);
                      nameController.clear();
                      ageController.clear();
                      placeController.clear();
                      imageController.resetImage();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Student added successfully',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 60),
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
