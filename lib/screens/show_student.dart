import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_with_getx/model/getx_class.dart';
import 'package:student_with_getx/screens/add_student.dart';
import 'package:student_with_getx/screens/student_details.dart';
import 'package:get/get.dart';

class ShowStudent extends StatelessWidget {
  const ShowStudent({super.key});

  @override
  Widget build(BuildContext context) {

    final studentcontroller = Get.put(StudentController());
    studentcontroller.loadStudent();
    studentcontroller.load();
    
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                studentcontroller.updateSearchQuery(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:Obx((){
                if(studentcontroller.studentList.isEmpty){
                  return const Center(
                    child: Text('No students yet'),
                  );
                }
                return ListView.separated(
                itemBuilder: (ctx,index){
                  final student = studentcontroller.filterList[index];
                  return GestureDetector(
                    onTap: () => 
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StudentDetails(student: student))),
                    child: ListTile(
                      leading: student.image.isNotEmpty ? 
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          image: 
                          DecorationImage(
                            image: FileImage(
                              File(student.image),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      :const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                      ),
                      title: Text(
                        student.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          alertButton(context,student.id);
                        },
                        icon:  const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),)
                    ),
                  );
                }, 
                separatorBuilder: (ctx,index){
                  return const SizedBox(height: 20,);
                }, 
                itemCount: studentcontroller.filterList.length); 
              })
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddStudent())),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  alertButton(BuildContext context,int index){
   showDialog(
    context: context, 
    builder: (context){
      return  AlertDialog(
      title: const Text(
        'Confirm',
      ),
      content: const Text(
        'are you sure to delete this student',
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text(
            'NO',
            style: TextStyle(
              color: Colors.blue,
            ),
          )),
          TextButton(
          onPressed: (){
            final studentController = Get.find<StudentController>();
            studentController.deleteStudent(index);
            Navigator.of(context).pop();
          },
          child: const Text(
            'YES',
            style: TextStyle(
              color: Colors.red,
            ),
          ))
      ],
    );
    }
    );
  }
}