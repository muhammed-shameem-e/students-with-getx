import 'package:get/get.dart';
import 'package:student_with_getx/database/student_database.dart';
import 'package:student_with_getx/model/student_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
// getting image from gallery
class ImageController extends GetxController{
  var imagePath = Rx<String?>(null);
  void updateImage(String path){
    if(path.isNotEmpty){
      imagePath.value = path; 
    }
  }
  void resetImage(){
    imagePath.value = null;
  }
  @override
  void onInit(){
    super.onInit();
    resetImage();
  }
}
// showing students from hive box
class StudentController extends GetxController{
  @override
  void onInit(){
    super.onInit();
    loadStudent();
  }
  RxList<Details> studentList = <Details>[].obs;
  RxList<Details> filterList = <Details>[].obs;
  RxString searchQuery = ''.obs;
  void loadStudent()async{
    filterList.value = await getAllStudent();
  }
  Future<void> addStudent(Details student)async{
    await addAllStudent(student);
    load();
  }
  Future<void> updateStudent(int index,Details details)async{
    await updateData(index, details);
    load();
  }
  Future<void> deleteStudent(int index)async{
    await deleteStudents(index);
    load();
  }
  void load(){
    final studentBox = Hive.box<Details>('student').values.toList();
    studentList.assignAll(studentBox);
    filterList.assignAll(studentBox);
  }
  void updateSearchQuery(String query){
    searchQuery.value = query;
    if(query.isEmpty){
      filterList.assignAll(studentList);
    }else{
      filterList.assignAll(
        studentList.where(
          (student) => student.name.toLowerCase().contains(query.toLowerCase()),
        )
      );
    }
  }
}