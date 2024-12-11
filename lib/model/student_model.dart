import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';
@HiveType(typeId: 0)
class Details{
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String age;
  @HiveField(3)
  String place;
  @HiveField(4)
  String image;
  Details({
    required this.id,
    required this.name,
    required this.age,
    required this.place,
    required this.image,
  });
}