import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_with_getx/model/getx_class.dart';
import 'package:student_with_getx/model/student_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({super.key,required this.student});
  final Details student;
  final ImageController imageController = Get.put(ImageController());
  Future<void> getImage()async{
    final ImagePicker imagepicker = ImagePicker();
    final XFile? pickedFile = await imagepicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      imageController.updateImage(pickedFile.path);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController newName = TextEditingController(text: student.name);
    TextEditingController newAge = TextEditingController(text: student.age);
    TextEditingController newPlace = TextEditingController(text: student.place);
    imageController.imagePath.value = student.image;
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
                Obx((){
                  return GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 197, 197, 197),
                      image: imageController.imagePath.value!.isNotEmpty
                      ? DecorationImage(
                        image: FileImage(
                          File(imageController.imagePath.value!),
                        ),
                        fit: BoxFit.cover,
                      )
                      :null,
                    ),
                    child: imageController.imagePath.value!.isEmpty
                    ?const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    )
                    :null,
                                ),
                  ); 
                }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your new name';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newAge,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    prefixIcon: const Icon(Icons.cake),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your new name';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newPlace,
                  decoration: InputDecoration(
                    labelText: 'Place',
                    prefixIcon: const Icon(Icons.place),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your new name';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      final students = Details(
                        id: student.id,
                        name: newName.text,
                        age: newAge.text, 
                        place: newPlace.text, 
                        image: imageController.imagePath.value!,
                        );
                        final studentController = Get.find<StudentController>();
                        studentController.updateStudent(student.id, students);
                    }
                    Navigator.of(context).pop();
                  },
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 60),
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Text(
                    'Save',
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