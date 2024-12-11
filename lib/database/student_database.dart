import 'package:student_with_getx/model/student_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addAllStudent(Details student)async{
  final studentBox = await Hive.openBox<Details>('student');
  await studentBox.add(student);
}
Future<List<Details>> getAllStudent()async{
  final studentBox = await Hive.openBox<Details>('student');
  return studentBox.values.toList();
}
Future<void> updateData(int id,Details updateData)async{
  final studentBox = await Hive.openBox<Details>('student');
  final index = studentBox.values.toList().indexWhere((student) => student.id == id);
  if(index != -1){
    await studentBox.putAt(index, updateData);
  }else{
    throw Exception('student with ID $id not found');
  }
}
Future<void> deleteStudents(int id)async{
  final studentBox = await Hive.openBox<Details>('student');
  final index = studentBox.keys.firstWhere(
    (key) => studentBox.get(key)?.id == id,
    orElse: () => null,
  );
  if(index != null){
    await studentBox.delete(index);
  }else{
    throw Exception('student with ID $id not found');
  }
}
